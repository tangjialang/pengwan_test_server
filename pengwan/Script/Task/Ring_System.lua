--[[
file:	Ring_System.lua
desc:	ring task system.
author:	chal
update:	2011-12-03

RingCache[1] = {
	����״̬,	-- 0 δ�� 1 �ѽ�δ��� 2 �����
	�����ģ��ֵ,
	����������,
	������ɫ,
}
notes:
	1����ǰ�ܻ��������ڴ�����������
	2����̨��������������ɫ
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

-- ��������ˢ�¸�������
local RefRateConf = {
	[1] = {500,2000,4000,7000,10000},			-- 40������
	[40] = {3000,6000,8000,9500,10000},			-- 40������
}
local mData={   monsterId =225, monAtt={[1] =3000,[3] =300,}}--�ܻ������
----------------------------------------------------------------
--inner function:

-- �����������
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
	-- ��������������
	local count = #uv_RingTaskLib[tp]
	local com = mathrandom(1,count)
	
	-- ���������ɫ
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
		-- refT,				-- ˢ��ʱ��
		-- [1] = {0,0,0,0},		-- {state,idx,cmp,color}
		-- [2] = {0,0,0,0},
		-- [3] = {0,0,0,0},
		-- [4] = {0,0,0,0},
	-- }
	-- look(tostring(RingCache))
	return RingCache
end

-- ��ȡ�ѽӵ������������
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

-- ��ȡ�ѽӵ������������
function RT_GetCurTask(sid)
	local ringCache = GetRingTaskCache(sid)
	if ringCache == nil then return end
	for k, v in pairs(ringCache) do
		if type(k) == type(0) and type(v) == type({}) then
			if v[1] == 1 then	-- �������ѽ�״̬�Ķ��������
				return k
			end
		end
	end
end

-- ˢ����������
function RT_RefreshTask(sid)
	local ringCache = GetRingTaskCache(sid)
	if ringCache == nil then return end
	if ringCache.refT ~= nil and GetServerTime() - ringCache.refT < 30 * 60 then
		if not CheckTimes(sid,uv_TimesTypeTb.RT_FreeReF,1,-1) then
			if not (CheckGoods(630,1,0,sid,"ˢ����������") == 1 ) then		-- �ȿ۵���
				if not CheckCost(sid,2,0,1,"100021_ˢ����������") then			-- ���߲����Ǯ
					-- look("money not enough")
					return
				end
			end
		end		
	end
	local num = 4	
	for k, v in pairs(ringCache) do
		if type(k) == type(0) and type(v) == type({}) then
			if v[1] ~= 1 then	-- �������ѽ�״̬�Ķ��������
				ringCache[k] = nil
			end
		end
	end
	
	local taskData = GetDBTaskData( sid )	
	if taskData.current[5001] ~= nil  then		-- �Ѿ��ӹ�һ��������û�ύ��� ���3��
		num = 3
	end
	local cc = 0
	for i = 1, num do			-- �����������
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

-- ��ȡ�������������������
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

-- һ�������������
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
	if not CheckCost( sid , cost , 0 , 1, "һ������") then
		-- SendLuaMsg( 0, { ids = Task_RingDir, res = 2 }, 9 )
		return
	end
	-- �������������
	CheckTimes(sid,uv_TimesTypeTb.TS_Ring,rest,-1)
	if taskData.current and taskData.current[5001] then
		taskData.current[5001] = nil
	end
	-- ����״̬
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
	
	exps = rint(exps*6*rest)	-- �Գ�ɫ����
	LL = rint(LL*6*rest)		-- �Գ�ɫ����
	money = rint(money*6*rest)		-- �Գ�ɫ����
	if exps > 0 then
		PI_PayPlayer(1,exps,0,0,"һ�����ͽ���")
	end
	if LL > 0 then
		AddPlayerPoints( sid, 11, LL, nil, "һ�����ͽ���" )
	end
	if money > 0 then
		GiveGoods(0,money,1,"һ�����ͽ���")
	end
	SendLuaMsg( 0, { ids = Task_RingData, dt = ringCache }, 9 )
	-- SendLuaMsg( 0, { ids = Task_RingDir, res = 0, dt = ringCache }, 9 )		
end

--����ϵͳר��,+100��buff
function power_uptask( sid )
	look('����ϵͳר��')
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

--��������ʱ����
function bury_gettempdata( playerid )
	local cData = GetPlayerTemp_custom(playerid)
	if cData == nil  then return end
	if cData.bury==nil then
		cData.bury={}
	end
	return cData.bury
end
--ǰ̨�������
function bury_id( sid,inid ,lv)
	--look('ǰ̨�������'..'id=='..inid)
	if sid==nil or inid==nil  then return end
	local tempdata=bury_gettempdata(sid)
	if tempdata==nil then return end
	local id=tempdata.id or 0
	if inid>id then
		tempdata.id=inid
		tempdata.lv=lv
	end

end
--����д�洢
function bury_onlive( sid )
	--look('����д�洢')
	--Log('�������.txt',CI_GetPlayerData(3))
	local tempdata=bury_gettempdata(sid)
	if tempdata==nil then 
		--look('ľ���������')
		--Log('�������.txt','ľ���������')
	 	return
	end
	local id=tempdata.id 
	local lv=tempdata.lv 
	if id==nil or lv==nil then 
		--look('ľ���������')
		--Log('�������.txt','__ľ���������__')
		return
	end
	db_bury_id(sid,id,lv)
	--Log('�������.txt','id=='..tostring(id)..'__lv=='..tostring(lv))
end


--�ܻ�����,����npc���ڵ�ͼ,npc��
function task_creatnpcmonster(npcid)
	-- look('�ܻ�����,����npc���ڵ�ͼ,npc��')
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

--ǰ̨��shareд�洢
function b_openshare()
	db_openshare()
end