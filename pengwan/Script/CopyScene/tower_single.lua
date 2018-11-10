--[[
file: tower_single.lua
desc: 单人塔防副本
autor: wk && Cureko
update: 2014-4-21
]]--

-----------------------------------------------------
--include:

local table_insert = table.insert
local tostring = tostring
local RPC = RPC
local RPCEx = RPCEx
local AreaRPC = AreaRPC
local CI_AddBuff = CI_AddBuff
local CS_GetTemp = CS_GetTemp
local CS_GetPlayerTemp = CS_GetPlayerTemp
local CI_UpdateMonsterData = CI_UpdateMonsterData
local GetServerTime = GetServerTime
local CreateObjectIndirect = CreateObjectIndirect
local uv_TimesTypeTb,GetStringMsg = TimesTypeTb,GetStringMsg

local OnCSStart = OnCSStart

local exp2_yb = 100 
local onepass_yb = 200
local buytime_yb = 50
local maxmonster = (30 * 20) --怪物总数
------------------------------------------------------
--inner:
local tower_config = 
{
	[1] = {name = '防御塔 lv1',spend = 50000,monAtt = {[3] = 0,[5] = 10000},imageID = 2261,headID = 2261,skillID = {260},skillLevel = {1},attackArea = 16,searchArea=10,atkSpeed=5,aiType=1,},
	[2] = {name = '防御塔 lv2',spend = 100000,monAtt = {[3] = 0,[5] = 10000},imageID = 2129,headID = 2129,skillID = {261},skillLevel = {1}},
	[3] = {name = '防御塔 lv3',spend = 200000,monAtt = {[3] = 0,[5] = 10000},imageID = 2130,headID = 2130,skillID = {262},skillLevel = {1}},
	[4] = {name = '防御塔 lv4',spend = 300000,monAtt = {[3] = 0,[5] = 10000},imageID = 2128,headID = 2128,skillID = {263},skillLevel = {1}},
	[5] = {name = '防御塔 lv5',spend = 400000,monAtt = {[3] = 0,[5] = 10000},imageID = 2262,headID = 2262,skillID = {264},skillLevel = {1}},
	[6] = {name = '防御塔 lv6',spend = 500000,monAtt = {[3] = 0,[5] = 10000},imageID = 2161,headID = 2161,skillID = {265},skillLevel = {1}},
}

local function twone_getplayerdata(playerid)
	local csdata=CS_GetPlayerData(playerid)
	if csdata==nil then return end
	if csdata.twone==nil then 
		csdata.twone={}
		--[[
			[1]= 立即开始标志
			[2]= 杀死数
			[3]= 逃跑数
			[4]= fenshu
		]]
	end
	return csdata.twone
end
-- 怪物死亡 
cs_monster_dead[4601] = function(mapGID, copySceneGID)
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then
		return
	end
	local playerid
	if copyScene.PlayerSIDList then
		for k in pairs(copyScene.PlayerSIDList) do
			if type(k) == type(0) then
				playerid=k
				break
			end
		end
	end
	local pdata=twone_getplayerdata(playerid)
	if pdata==nil then return end
	pdata[2]=(pdata[2] or 0)+1
	RPCEx(playerid,'twone_res',1,pdata[2])
end

for i=4602,4630 do 
	cs_monster_dead[i]=cs_monster_dead[4601] 
end


--逃跑
--怪物移动到一个点回调
call_monster_move[22001]=function (monGID, copySceneGID,deadScriptID)
	local cx,cy,regionID,mapGID = CI_GetCurPos(3)
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then
		return
	end
	local playerid
	if copyScene.PlayerSIDList then
		for k in pairs(copyScene.PlayerSIDList) do
			if type(k) == type(0) then
				playerid=k
				break
			end
		end
	end
	local pdata=twone_getplayerdata(playerid)
	if pdata==nil then return end

	pdata[3]=(pdata[3] or 0)+1
	look("escape",2)
	look(pdata[3],2)
	
	local ControlID = GetObjectUniqueId()
	if pdata[3] >= 20 then --结束
		CS_Complete(copyScene,false)
		return
	end	
	RPCEx(playerid,'twone_res',2,pdata[3])
	--look(pdata[3],2)
	CI_DelMonster(mapGID,monGID)
	local fbID = copyScene.fbID
	local mainID ,subID = GetSubID(fbID)
	local csEventTb = FBConfig[mainID][subID].EventList
		
	-- 怪物死亡触发事件
	if copyScene.TraceList ~= nil and copyScene.TraceList.MonDeads ~= nil then
		local MonDeadEvent = copyScene.TraceList.MonDeads[deadScriptID]
		--look("deadScriptID:" .. deadScriptID )
		if MonDeadEvent ~= nil and  MonDeadEvent.num ~= nil and MonDeadEvent.num ~= 0 then
			MonDeadEvent.num = MonDeadEvent.num - 1		
			if MonDeadEvent.num == 0 and csEventTb.MonDeads[deadScriptID].EventTb then		-- 如果满足触发条件 （怪物死到一定数量）					
				CS_EventProc(copySceneGID,csEventTb.MonDeads[deadScriptID].EventTb)
			end						
			--CS_SendTraceInfo( copyScene, TraceTypeTb.MonDeads, {deadScriptID,MonDeadEvent.num} )		--发送追踪信息
		end
	end		
end

function on_twone_complete(sid)
	look('on_twone_complete',2)
	local pdata = twone_getplayerdata(sid)
	if pdata[5] and pdata[2] then 
		pdata[4] = pdata[2]
		RPCEx(sid,'twone_res',3,pdata[2])
	end
	pdata[1] = nil
	pdata[3] = nil
	pdata[5] = nil
end

-- 升级箭塔
function twone_uplevel(sid,mon_gid)
	if sid == nil or mon_gid == nil then
		return
	end
	
	local mon_lv = GetMonsterData(1,4,mon_gid)
	mon_lv = mon_lv + 1
	local tf = tower_config[mon_lv]
	if not tf then
		RPC('tw_uplevel',1)
		return
	end
	
	if not CheckCost( sid , tf.spend , 0 , 3, "升级箭塔") then
		return
	end
	
	tf.level = mon_lv
	CI_UpdateMonsterData(1,tf,nil,4,mon_gid)
	RPC('twone_update_monter',mon_gid,mon_lv,tf.imageID,tf.name,tf.headID)
end

--单人塔防经验多倍领奖,num=倍数
function twone_getexp(sid,num)
	local playerlv = CI_GetPlayerData(1,2,sid)
	if playerlv > 80 then playerlv = 80 end
	
	local pdata = twone_getplayerdata(sid)
	if not pdata[2] then return end
	
	local a_exp = rint((playerlv^5)/48000) * pdata[2]
	if num == 2 then 
		if not CheckCost(sid,exp2_yb,0,1,'单人塔防经验多倍领奖') then return end
		a_exp = a_exp * 2
	end
	
	PI_PayPlayer(1,a_exp,0,0,"单人塔防经验多倍领奖")
	RPCEx(sid,'twone_exp',num)--多倍经验领取成功
	
	pdata[2] = nil
	pdata[4] = nil
end

--塔防直接完成
function twone_pass(sid)
	local copyScene = CS_GetCopyScene(sid)
	look('twone_pass',2)
	if not copyScene then return end
	if not CheckCost(sid,onepass_yb,0,1,'单人塔防一键完成') then
		
		return 
	end
	
	local playerlv = CI_GetPlayerData(1,2,sid)
	if playerlv > 80 then playerlv = 80 end
	
	local a_exp = rint((playerlv^5)/48000) * maxmonster * 2
	PI_PayPlayer(1,a_exp,0,0,"单人塔防经验多倍领奖")
	local pdata = twone_getplayerdata(sid)
	

	pdata[2] = nil
	pdata[4] = nil
	pdata[5] = nil
	CS_Complete(copyScene,false)
end

function twone_firstin( sid,fbID,CopySceneGID )
	local pdata=twone_getplayerdata(sid)
	
	pdata[1] = nil
	pdata[2] = nil
	pdata[3] = nil
	pdata[4] = nil
	pdata[5] = true
	look('twone_firstin',2)
	OnCSStart(fbID,CopySceneGID)
end

function twone_buytime(sid)
	if not CheckCost(sid,buytime_yb,1,1,'单人塔防次数购买') then	return end
	if not CheckTimes(sid,uv_TimesTypeTb.CS_twone,1,1) then return end
	CheckCost(sid,buytime_yb,0,1,'单人塔防次数购买')
end
--立即生怪
function twone_go(sid)
	local pdata = twone_getplayerdata(sid)
	if pdata[1] then return end
	pdata[1] = 1
	
	local copyScene = CS_GetCopyScene(sid)
	if copyScene.turns then return end
	
	ClrEvent(copyScene.Timers[1])
	SI_cs_timer(copyScene.fbID,copyScene.CopySceneGID,1)
end

function twone_online(sid)
	look('twone_online',2)
	local pdata = twone_getplayerdata(sid)
	local copyScene = CS_GetCopyScene(sid)
	if copyScene and copyScene.fbID == 2201 and not pdata[5] then
		CS_Complete(copyScene,false)
	end
end