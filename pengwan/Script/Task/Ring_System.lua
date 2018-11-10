--[[
file:	Ring_System.lua
desc:	ring task system.
author:	chal
update:	2011-12-03

RingCache[1] = {
	任务状态,	-- 0 未接 1 已接未完成 2 已完成
	任务库模板值,
	完成条件序号,
	任务颜色,
}
notes:
	1、当前跑环次数做在次数管理器里
	2、后台随机完成条件及颜色
]]--
local pairs,ipairs,type = pairs,ipairs,type
local ipairs,tostring = ipairs,tostring
local look = look
local uv_TimesTypeTb = TimesTypeTb
local mathrandom = math.random
local tablelocate = table.locate
local uv_RingTaskConfig = RingTaskConfig
local uv_RingTaskLib = RingTaskLib
local CI_GetPlayerData,GetServerTime = CI_GetPlayerData,GetServerTime
local Task_RingData = msgh_s2c_def[1][10]
local Task_RingDir = msgh_s2c_def[1][12]
local SendLuaMsg,CheckGoods = SendLuaMsg,CheckGoods
local db_module =require('Script.cext.dbrpc')
local db_bury_id=db_module.db_bury_id
local db_openshare=db_module.db_openshare
-----------------------------------------------------------------
--data:

-- 悬赏任务刷新概率配置
local RefRateConf = {
	[1] = {500,2000,4000,7000,10000},			-- 40级以下
	[40] = {3000,6000,8000,9500,10000},			-- 40级以上
}
local mData={   monsterId =225, monAtt={[1] =3000,[3] =300,}}--跑环任务怪
----------------------------------------------------------------
--inner function:

-- 随机悬赏任务
local function RT_RandomTask()
	local lv = CI_GetPlayerData(1)
	local idx = 1
	for k, config in ipairs(uv_RingTaskConfig) do
		if lv >= config.LevelNeed[1] and lv <= config.LevelNeed[2] then
			idx = k
			break
		end
	end
	local tp = uv_RingTaskConfig[idx].TaskTemplate
	if uv_RingTaskLib[tp] == nil then
		return
	end
	-- 随机任务完成条件
	local count = #uv_RingTaskLib[tp]
	local com = mathrandom(1,count)
	
	-- 随机任务颜色
	local color = 1
	local lv = CI_GetPlayerData(1)
	local index = tablelocate(RefRateConf,lv,1)
	if index == nil or RefRateConf[index] == nil then return end

	local rd = mathrandom(1,10000)
	for k, v in ipairs(RefRateConf[index]) do
		if rd <= v then
			color = k
			break
		end
	end
	
	return idx,com,color
end

-------------------------------------------------------------------
--interface:

function GetRingTaskCache(playerID)
	local RingCache = GI_GetPlayerData( playerID , "ring" , 100 )
	if nil == RingCache then
		return
	end
	-- RingCache ={
		-- refT,				-- 刷新时间
		-- [1] = {0,0,0,0},		-- {state,idx,cmp,color}
		-- [2] = {0,0,0,0},
		-- [3] = {0,0,0,0},
		-- [4] = {0,0,0,0},
	-- }
	-- look(tostring(RingCache))
	return RingCache
end

-- 获取已接的悬赏任务序号
function RT_GetRingData(sid)
	-- look("RT_GetRingData")
	local ringCache = GetRingTaskCache(sid)
	if ringCache == nil then return end
	if ringCache.refT ~= nil and GetServerTime() - ringCache.refT < 30 * 60 then
		-- look("RT_GetRingData11")
		SendLuaMsg( 0, { ids = Task_RingData, dt = ringCache }, 9 )
		return
	end	
	RT_RefreshTask(sid)
end

-- 获取已接的悬赏任务序号
function RT_GetCurTask(sid)
	local ringCache = GetRingTaskCache(sid)
	if ringCache == nil then return end
	for k, v in pairs(ringCache) do
		if type(k) == type(0) and type(v) == type({}) then
			if v[1] == 1 then	-- 不处于已接状态的都重新随机
				return k
			end
		end
	end
end

-- 刷新悬赏任务
function RT_RefreshTask(sid)
	local ringCache = GetRingTaskCache(sid)
	if ringCache == nil then return end
	if ringCache.refT ~= nil and GetServerTime() - ringCache.refT < 30 * 60 then
		if not CheckTimes(sid,uv_TimesTypeTb.RT_FreeReF,1,-1) then
			if not (CheckGoods(630,1,0,sid,"刷新悬赏任务") == 1 ) then		-- 先扣道具
				if not CheckCost(sid,2,0,1,"100021_刷新悬赏任务") then			-- 道具不足扣钱
					-- look("money not enough")
					return
				end
			end
		end		
	end
	local num = 4	
	for k, v in pairs(ringCache) do
		if type(k) == type(0) and type(v) == type({}) then
			if v[1] ~= 1 then	-- 不处于已接状态的都重新随机
				ringCache[k] = nil
			end
		end
	end
	
	local taskData = GetDBTaskData( sid )	
	if taskData.current[5001] ~= nil  then		-- 已经接过一个任务并且没提交完成 随机3个
		num = 3
	end
	local cc = 0
	for i = 1, num do			-- 随机悬赏任务
		local idx, com, col = RT_RandomTask()
		if idx then
			if col >= 4 then
				if cc >= 2 then
					col = 1
				else
					cc = cc + 1
				end
			end
			if ringCache[i] == nil then
				ringCache[i] = {0,idx,com,col}
			else
				ringCache[i + 1] = {0,idx,com,col}
			end
		end
	end
	
	ringCache.refT = GetServerTime()
	SendLuaMsg( 0, { ids = Task_RingData, dt = ringCache }, 9 )
end

-- 获取悬赏任务完成条件配置
function RT_GetConditionConf(sid)
	local nSelect = RT_GetCurTask(sid)
	if nSelect == nil then
		look("nSelect == nil")
		return
	end
	local ringCache = GetRingTaskCache(sid)
	local idx = ringCache[nSelect][2]
	local tp = uv_RingTaskConfig[idx].TaskTemplate
	local com = ringCache[nSelect][3]
	local taskColor = ringCache[nSelect][4]
	local completeCondition = uv_RingTaskLib[tp][com]
	
	return completeCondition
end

-- 一键完成悬赏任务
function RT_DirectComplete(sid)
	local lv = CI_GetPlayerData(1)
	local idx = nil
	for k, config in ipairs(uv_RingTaskConfig) do
		if lv >= config.LevelNeed[1] and lv <= config.LevelNeed[2] then
			idx = k
			break
		end
	end 
	if idx == nil then return end
	local awards = uv_RingTaskConfig[idx].CompleteAwards
	local taskData = GetDBTaskData( sid )
	if taskData == nil then return end
	if not CheckTimes(sid,uv_TimesTypeTb.TS_Ring,1,-1,1) then
		-- SendLuaMsg( 0, { ids = Task_RingDir, res = 1 }, 9 )
		return
	end	
	local tc = GetTimesInfo(sid,uv_TimesTypeTb.TS_Ring)
	if tc == nil then return end
	local rest = tc[2] or 0
	if rest <= 0 then return end
	local cost = rest * 5
	if not CheckCost( sid , cost , 0 , 1, "一键悬赏") then
		-- SendLuaMsg( 0, { ids = Task_RingDir, res = 2 }, 9 )
		return
	end
	-- 先设置相关数据
	CheckTimes(sid,uv_TimesTypeTb.TS_Ring,rest,-1)
	if taskData.current and taskData.current[5001] then
		taskData.current[5001] = nil
	end
	-- 设置状态
	local ringCache = GetRingTaskCache(sid)
	if ringCache == nil then return end
	for k, v in pairs(ringCache) do
		if type(k) == type(0) and type(v) == type({}) then
			v[1] = 0
		end
	end
	local money = awards[1] or 0
	local exps = awards[2] or 0	
	local LL = awards[12] or 0
	
	exps = rint(exps*6*rest)	-- 以橙色计算
	LL = rint(LL*6*rest)		-- 以橙色计算
	money = rint(money*6*rest)		-- 以橙色计算
	if exps > 0 then
		PI_PayPlayer(1,exps,0,0,"一键悬赏奖励")
	end
	if LL > 0 then
		AddPlayerPoints( sid, 11, LL, nil, "一键悬赏奖励" )
	end
	if money > 0 then
		GiveGoods(0,money,1,"一键悬赏奖励")
	end
	SendLuaMsg( 0, { ids = Task_RingData, dt = ringCache }, 9 )
	-- SendLuaMsg( 0, { ids = Task_RingDir, res = 0, dt = ringCache }, 9 )		
end

--觉醒系统专用,+100级buff
function power_uptask( sid )
	look('觉醒系统专用')
	local _, _, rid,_ = CI_GetCurPos()
	if rid~=1004 then return end
	if not  HasTask(sid,2006)  then 
		return
	end
	local school = CI_GetPlayerData(2)
	if 	school==1 then
			CI_AddBuff(226,0,100,false)

	elseif 	school==2 then
			CI_AddBuff(227,0,100,false)
	
	elseif 	school==3 then
			CI_AddBuff(228,0,100,false)

	else
		return
	end

end

--玩家埋点临时数据
function bury_gettempdata( playerid )
	local cData = GetPlayerTemp_custom(playerid)
	if cData == nil  then return end
	if cData.bury==nil then
		cData.bury={}
	end
	return cData.bury
end
--前台任务埋点
function bury_id( sid,inid ,lv)
	--look('前台任务埋点'..'id=='..inid)
	if sid==nil or inid==nil  then return end
	local tempdata=bury_gettempdata(sid)
	if tempdata==nil then return end
	local id=tempdata.id or 0
	if inid>id then
		tempdata.id=inid
		tempdata.lv=lv
	end

end
--下线写存储
function bury_onlive( sid )
	--look('下线写存储')
	--Log('埋点数据.txt',CI_GetPlayerData(3))
	local tempdata=bury_gettempdata(sid)
	if tempdata==nil then 
		--look('木有埋点数据')
		--Log('埋点数据.txt','木有埋点数据')
	 	return
	end
	local id=tempdata.id 
	local lv=tempdata.lv 
	if id==nil or lv==nil then 
		--look('木有埋点数据')
		--Log('埋点数据.txt','__木有埋点数据__')
		return
	end
	db_bury_id(sid,id,lv)
	--Log('埋点数据.txt','id=='..tostring(id)..'__lv=='..tostring(lv))
end


--跑环任务,创建npc所在地图,npc怪
function task_creatnpcmonster(npcid)
	-- look('跑环任务,创建npc所在地图,npc怪')
	local sid=CI_GetPlayerData(17)
	local cid=npcid+100000
	local x,y,mid = CI_GetCurPos(6,cid)
	if y==nil or mid==nil then return end
	local b=CI_SelectObject(6,sid,mid)
	if b and b==1 then 
		return 
	end

	local imageID=npclist[npcid].NpcCreate.imageId
	local lv=CI_GetPlayerData(1)
	mData.name=CI_GetPlayerData(3)
	-- look(imageID)
	mData.imageID = imageID
	mData.headID = imageID
	mData.controlId=sid
	mData.regionId=mid
	mData.monAtt[1] = lv^2*50
	mData.monAtt[3]= lv^2.2*0.2
	mData.x = x+2
	mData.y =y+2
	local a=CreateObjectIndirect(mData)
	--look(a)
end

--前台开share写存储
function b_openshare()
	db_openshare()
end