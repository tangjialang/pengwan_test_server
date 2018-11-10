--[[
file:	tjbx.lua
desc:	天降宝箱
author:	wk
update:	2013-12-16
]]--


local active_mgr_m = require('Script.active.active_mgr')
local activitymgr=active_mgr_m.activitymgr
local uv_TimesTypeTb = TimesTypeTb
local CheckTimes=CheckTimes
local define		= require('Script.cext.define')
local ProBarType = define.ProBarType
local BroadcastRPC=BroadcastRPC
local RegionRPC=RegionRPC
local TipCenter=TipCenter
local PI_PayPlayer=PI_PayPlayer
local SetEvent=SetEvent
local CI_SetReadyEvent=CI_SetReadyEvent
local call_npc_click = call_npc_click
local look = look
local SendLuaMsg=SendLuaMsg
local _random,_floor=math.random,math.floor
local CreateObjectIndirectEx=CreateObjectIndirectEx
local CI_GetCurPos=CI_GetCurPos
local CI_GetPlayerData=CI_GetPlayerData
local GetObjectUniqueId=GetObjectUniqueId
local GetServerTime=GetServerTime
local CI_SelectObject=CI_SelectObject
local RPC=RPC
local GetWorldLevel=GetWorldLevel
local GetStringMsg=GetStringMsg
local type=type
local pairs=pairs
local npclist = npclist
local table_locate = table.locate
local CreateObjectIndirect = CreateObjectIndirect
local call_OnMapEvent=call_OnMapEvent
local PI_MovePlayer=PI_MovePlayer
local call_npc_click=call_npc_click
local GI_GiveAward=GI_GiveAward
local RemoveObjectIndirect=RemoveObjectIndirect
local isFullNum=isFullNum
local GiveGoodsBatch=GiveGoodsBatch
local common_time = require('Script.common.time_cnt')
local GetTimeThisDay = common_time.GetTimeThisDay
local __G = _G
----------------------------------------------------------------------------
-- module:

module(...)

----------------------------------------------------------------------------

local t_conf = {
	-- 采集npc
	npc_site ={400560,400584}, --刷新npc 起始-结束npcid

	refresh={---采集时间,刷新时间
		[1]={20,120},
		[2]={10,60},
		[3]={10,60},
		[4]={10,60},
		[5]={10,60},
		[6]={3,1},
	},

	--奖励--通用奖励配置
	awards={
		[1]={--混沌宝箱
			[1]=100000,
			[5]=100000,
			[2]=250000,
			},
		[2]={--青龙宝箱
			[5]=100000,
			},
		[3]={--白虎宝箱
			[1]=100000,
			},
		[4]={--朱雀宝箱
			[2]=200000,
			},
		[5]={--玄武宝箱
			[4]=100,
			},
		[6]={--普通宝箱
			[1]=30000,
			[5]=30000,
			},
	},
	luckAwards= { --10%概率获得额外奖励
		[1]={--混沌宝箱
			{673,1,1}
			},
		[2]={--青龙宝箱
			{603,20,1}
			},
		[3]={--白虎宝箱
			{601,20,1}
			},
		[4]={--朱雀宝箱
			{672,5,1}
			},
		[5]={--玄武宝箱
			{640,4,1}
			},
	
	},

}
------------------------------------------------------

local active_name = 'span_tjbx'

--天降宝箱活动数据
local function tjbx_getactdata(gid)
	local Active_tjbx=activitymgr:get(active_name)
	if Active_tjbx==nil then return end 
	--[[
		[1]=111,混沌宝箱下次刷新时间
		[2]=111,青龙宝箱下次刷新时间
		[3]=111,白虎宝箱下次刷新时间
		[4]=111,朱雀宝箱下次刷新时间
		[5]=111,玄武宝箱下次刷新时间
	]]
	return Active_tjbx:get_regiondata(gid)
end

--创建NPC
local function _creat_npc_monster( mapGID )
	local npc_conf = t_conf.npc_site
	for i=npc_conf[1], npc_conf[2] do
		local t = npclist[i]		
		if type(t) == type({}) then
			t.NpcCreate.regionId = mapGID
			t.NpcCreate.clickScript = t.NpcCreate.clickScript or 30000
			CreateObjectIndirectEx(1,i,t.NpcCreate)		-- 创建NPC
		end
	end
end

--创建房间回调
local function _tjbx_regioncreate(slef,mapGID)
	local now = GetServerTime()
	local bt_1 = GetTimeThisDay(now,14,10,0) + 60
	local et_1 = GetTimeThisDay(now,16,0,0)
	local bt_2 = GetTimeThisDay(now,21,10,0) + 60

	if now < bt_1 then
		local sec = bt_1 - now
		if sec > 10 * 60 then return end
		SetEvent(sec, nil, 'GI_spantjbx_create', mapGID)
		return
	end
	if now > et_1 and now < bt_2 then
		local sec = bt_2 - now
		if sec > 10 * 60 then return end
		SetEvent(sec, nil, 'GI_spantjbx_create', mapGID)
		return
	end
	
	_creat_npc_monster( mapGID )
end
-- 玩家复活处理
local function _on_playerlive(self,sid)	
	look('_on_playerlive')
	local Active_tjbx = activitymgr:get(active_name)
	if Active_tjbx == nil then 
		look('_on_playerlive Active_tjbx == nil')
		return 
	end
	local _,_,_,mapGID = CI_GetCurPos()
	if not PI_MovePlayer(0,37,107,mapGID,2,sid) then
		look('_on_playerlive PI_MovePlayer erro')
		return
	end
	return 1
end
--活动开启时注册
local function active_tjbx_regedit(Active_tjbx)
	Active_tjbx.on_regioncreate=_tjbx_regioncreate
	Active_tjbx.on_playerlive = _on_playerlive
end

-------------------------------------------------------------------------

--开始
local function _span_tjbx_start()
	--local Active_tjbxold=activitymgr:get(active_name)
	-- if Active_tjbxold then
		-- look('活动开启中')
		-- return
	-- end
	activitymgr:create(active_name)
	local Active_tjbx=activitymgr:get(active_name)
	active_tjbx_regedit(Active_tjbx)
	Active_tjbx:createDR(1)
	-- BroadcastRPC('tjbx_Start')
end
--进入
local function _span_tjbx_enter(sid)
	local Active_tjbx=activitymgr:get(active_name)
	if Active_tjbx==nil then
		return
	end
	if Active_tjbx:is_active(sid) then
		return
	end
	local mapGID = __G.GetPlayerSpanGID(sid)
	if mapGID == nil then
		return
	end
	
	-- put player to region
	local ret, gid = Active_tjbx:add_player(sid, 1, 0, nil, nil, mapGID)
	if not ret then
		look('_span_tjbx_enter add_player erro',1)
		return
	end	
	
	local tdata=tjbx_getactdata(gid)
	if tdata==nil then return end
	RPC('tjbx_in',tdata)
	
	return true
end
--退出
local function _span_tjbx_exit(sid)
	local Active_tjbx=activitymgr:get(active_name)
	if Active_tjbx==nil then
		return
	end
	Active_tjbx:back_player(sid)
end


-- 点击拿宝箱
call_npc_click[50023]=function ()	
	local sid= CI_GetPlayerData(17)
	local pakagenum = isFullNum()
	if pakagenum < 1 then --判断背包空间是否足够
		TipCenter(GetStringMsg(14,1))
		return 
	end
	local res=CheckTimes(sid,uv_TimesTypeTb.tjbx,1,-1,1)
	if not res then  
		TipCenter(GetStringMsg(20))
		return 
	end
	local controlID,cid = GetObjectUniqueId()
	local npcid=controlID-100000
	local index=npcid-t_conf.npc_site[1]+1
	if index>6 then 
		index=6
	end
	local needtime=t_conf.refresh[index][1]
	CI_SetReadyEvent(controlID,ProBarType.collect,needtime,1,'GI_span_chick_tjbx')
end
--开宝箱回调
local function _span_chick_tjbx(controlID )
	local sid= CI_GetPlayerData(17)
	local _,_,rid,mapGID = CI_GetCurPos(6,controlID)
	local a=CI_SelectObject(6, controlID, mapGID )
	if (not a ) or a<1 then
		TipCenter(GetStringMsg(436))
		return 0
	end

	local npcid=controlID-100000
	local index=npcid-t_conf.npc_site[1]+1
	if index>6 then 
		index=6
	end

	local res
	if index<6 then 
		local rannum=_random(1,100)
		if rannum<=10 then 
			res=true
			local goods=t_conf.luckAwards[index]
			GiveGoodsBatch(goods,'天降宝箱')
		end
	end

	local AwardTb=t_conf.awards[index]
	local now=GetServerTime()
	CheckTimes(sid,uv_TimesTypeTb.tjbx,1,-1)
	GI_GiveAward( sid, AwardTb, "天降宝箱" )
	local tdata=tjbx_getactdata(mapGID)
	local _time=t_conf.refresh[index][2]

	tdata[index]=now+_time
	if index<6 then 
		RegionRPC(mapGID,'tjbx_up',index,tdata[index],sid,res,CI_GetPlayerData(3))
	else
		RPC('tjbx_succ')
	end
	SetEvent(_time, nil, "GI_span_tjbx_refresh",npcid,mapGID) 
	RemoveObjectIndirect( mapGID, controlID )
	return 1
end

--重刷npc
local function _span_tjbx_refresh( npcid ,rgid)
	look('重刷npc')
	look(npcid)
	look(rgid)
	local npc = npclist[npcid]
	npc.NpcCreate.regionId=rgid
	CreateObjectIndirectEx(1,npcid,npc.NpcCreate)
end

local function _stjbx_get_rooms(svrid,uid,con,idx)
	if svrid == nil then return end
	local Active_tjbx = activitymgr:get(active_name)
	if Active_tjbx == nil then
		look('_stjbx_get_rooms Active_tjbx == nil')
		__G.PI_SendToLocalSvr(svrid, {ids = 5001, uid = uid, con = con, idx = idx })
		return
	end	
	local active_flags = Active_tjbx:get_state()
	if active_flags == 0 then
		look('_stjbx_get_rooms Active_tjbx has end')
		__G.PI_SendToLocalSvr(svrid, {ids = 5001, uid = uid, con = con, idx = idx })
		return
	end
	__G.PI_SendToLocalSvr(svrid, {ids = 5001, uid = uid, con = con, idx = idx, rooms = Active_tjbx.room })
end

-------------------------------------------------------------------
span_tjbx_start=_span_tjbx_start--开始
span_tjbx_enter=_span_tjbx_enter--进入
span_tjbx_exit=_span_tjbx_exit--退出
span_chick_tjbx=_span_chick_tjbx
span_tjbx_refresh=_span_tjbx_refresh
stjbx_get_rooms = _stjbx_get_rooms
creat_npc_monster = _creat_npc_monster