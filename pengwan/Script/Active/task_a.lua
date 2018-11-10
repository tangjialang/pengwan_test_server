--[[
file:	task_a.lua
desc:	下午任务活动,采集打怪等
author:	wk
update:	2013-10-14
]]--


local active_mgr_m = require('Script.active.active_mgr')
local activitymgr=active_mgr_m.activitymgr
local define		= require('Script.cext.define')
local ProBarType = define.ProBarType
local BroadcastRPC=BroadcastRPC
local RegionRPC=RegionRPC
local TipCenter=TipCenter
local AddDearDegree=AddDearDegree
local PI_PayPlayer=PI_PayPlayer
local SetEvent=SetEvent
local CI_SetReadyEvent=CI_SetReadyEvent
local call_npc_click = call_npc_click
local look = look
local SendLuaMsg=SendLuaMsg
local _random,_floor=math.random,math.floor
local npclist=npclist
local CreateObjectIndirectEx=CreateObjectIndirectEx
local CI_GetCurPos=CI_GetCurPos
local CI_GetPlayerData=CI_GetPlayerData
local GetObjectUniqueId=GetObjectUniqueId
local GetServerTime=GetServerTime
local CI_SelectObject=CI_SelectObject
local RPC=RPC
local uv_TimesTypeTb = TimesTypeTb
local RemoveObjectIndirect=RemoveObjectIndirect
local CheckTimes=CheckTimes
local CI_AddBuff=CI_AddBuff
local CI_HasBuff=CI_HasBuff
local GetWorldLevel=GetWorldLevel
local GetStringMsg=GetStringMsg
local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist = sclist_m.insert_scorelist
local get_scorelist_data = sclist_m.get_scorelist_data
local sc_add=sc_add
local SendSystemMail = SendSystemMail
local MailConfig=MailConfig
local type=type
local pairs=pairs
local CreateObjectIndirectEx = CreateObjectIndirectEx
local npclist = npclist
local table_locate = table.locate
local CreateObjectIndirect = CreateObjectIndirect
local call_OnMapEvent=call_OnMapEvent
local PI_MovePlayer=PI_MovePlayer
----------------------------------------------------------------------------
-- module:

module(...)

----------------------------------------------------------------------------

local scoreid=2
local t_conf = {
		-- 采集npc
	 npc_site ={100031,100043}, --刷新npc 起始-结束npcid

	--任务怪
	monster={
		[1]={BRMONSTER = 1, centerX = 31 , centerY = 125 , BRArea = 15 , BRNumber =50 , refreshTime =50, dir = 4 , monsterId = 121, },
		[2]={BRMONSTER = 1, centerX = 43 , centerY = 30 , BRArea = 5 , BRNumber =10 , refreshTime =50, dir = 4 , monsterId = 122, },
	},

	wlevel = {		-- 世界等级对怪物属性影响
		[30] = {
			[1] = {[1] = 14000 , [3] = 400,[4] = 400 , [5] = 500,[6] = 200 , [7] = 200,[8] = 200 , [9] = 200, },
			[2] = {[1] = 150000 , [3] = 600,[4] = 800 , [5] = 1000,[6] = 400 , [7] = 400,[8] = 400 , [9] = 400,},
		},
		[40] = {
			[1] = {[1] = 21000 , [3] = 600,[4] = 600 , [5] = 800,[6] = 300 , [7] = 300,[8] = 300 , [9] = 300,},
			[2] = {[1] = 240000 , [3] = 1000,[4] = 1600 , [5] = 2000,[6] = 800 , [7] = 800,[8] = 800 , [9] = 800, },	
		},
		[45] = {
			[1] = {[1] = 26000 , [3] = 800,[4] = 800 , [5] = 1000,[6] = 400 , [7] = 400,[8] = 400 , [9] = 400,},
			[2] = {[1] = 290000 , [3] = 1200,[4] = 1900 , [5] = 2200,[6] = 900 , [7] = 900,[8] = 900 , [9] = 900, },	
		},
		[50] = {
			[1] = {[1] = 31000 , [3] = 1000,[4] = 1000 , [5] = 1200,[6] = 500 , [7] = 500,[8] = 500, [9] = 500, },
			[2] = {[1] = 340000 , [3] = 2000,[4] = 2300 , [5] = 2800,[6] = 1100 , [7] = 1100,[8] = 1100 , [9] = 1100, },
		},
		[55] = {
			[1] = {[1] = 36000 , [3] = 1200,[4] = 1200 , [5] = 1300,[6] = 600 , [7] = 600,[8] = 600, [9] = 600, },
			[2] = {[1] = 400000 , [3] = 2800,[4] = 2800 , [5] = 3000,[6] = 1400 , [7] = 1400,[8] = 1400 , [9] = 1400, },
		},
		[60] = {
			[1] = {[1] = 42000 , [3] = 1400,[4] = 1400 , [5] = 1600,[6] = 700 , [7] = 700,[8] = 700 , [9] = 700, },
			[2] = {[1] = 480000 , [3] = 3500,[4] = 3400 , [5] = 4000,[6] = 1600 , [7] = 1600,[8] = 1600 , [9] = 1600, },
		},
		[65] = {
			[1] = {[1] = 49000 , [3] = 1600,[4] = 1600 , [5] = 2000,[6] = 800 , [7] = 800,[8] = 800 , [9] = 800, },
			[2] = {[1] = 550000 , [3] = 5000,[4] = 3900 , [5] = 4500,[6] = 1900 , [7] = 1900,[8] = 1900 , [9] = 1900, },
		},
		[70] = {
			[1] = {[1] = 57000 , [3] = 1800,[4] = 1800 , [5] = 2500,[6] = 900 , [7] = 900,[8] = 900 , [9] = 900, },
			[2] = {[1] = 630000 , [3] = 8000,[4] = 4500 , [5] = 5500,[6] = 2300 , [7] = 2300,[8] = 2300 , [9] = 2300, },
		},
	},


}
------------------------------------------------------
--刷怪
local function creat_npc_monster( mapGID )
	
	local npc_conf = t_conf.npc_site
	for i=npc_conf[1], npc_conf[2] do
		local t = npclist[i]		
		if type(t) == type({}) then
			t.NpcCreate.regionId = mapGID
			t.NpcCreate.clickScript = t.NpcCreate.clickScript or 30000
			CreateObjectIndirectEx(1,i,t.NpcCreate)		-- 创建NPC
		end
	end

	local monster_conf = t_conf.monster
	local wlevel_conf = t_conf.wlevel
	local world_lv = GetWorldLevel() or 1 
	local tpos = table_locate(wlevel_conf,world_lv,2)
	if tpos == nil or wlevel_conf[tpos] == nil then		-- 这里应该不会失败
		look('sjzc monster config erro')
		return
	end
	
	for idx, conf in pairs(monster_conf) do
		if type(conf) == type({}) then
				conf.regionId = mapGID						-- 设置怪物场景ID
				conf.level = tpos
				conf.monAtt = wlevel_conf[tpos][idx]				
				CreateObjectIndirect(conf)		-- 创建怪物				
		end
	end
end

--创建房间回调
local function _task_regioncreate(slef,mapGID)
	creat_npc_monster( mapGID )
end
-- 玩家复活处理
local function _on_playerlive(self,sid)	
	look('_on_playerlive')
	local Active_task = activitymgr:get('task')
	if Active_task == nil then 
		look('_on_playerlive Active_task == nil')
		return 
	end
	local _,_,_,mapGID = CI_GetCurPos()
	if not PI_MovePlayer(0,9,78,mapGID,2,sid) then
		look('_on_playerlive PI_MovePlayer erro')
		return
	end
	return 1
end
--活动开启时注册
local function active_task_regedit(Active_task)
	Active_task.on_regioncreate=_task_regioncreate
	Active_task.on_playerlive = _on_playerlive
end

-------------------------------------------------------------------------

--开始
local function _task_start()
	--local Active_taskold=activitymgr:get('task')
	-- if Active_taskold then
		-- look('活动开启中')
		-- return
	-- end
	activitymgr:create('task')
	local Active_task=activitymgr:get('task')
	active_task_regedit(Active_task)
	Active_task:createDR(1)
	BroadcastRPC('task_Start')
end
--进入
local function _task_enter(sid,mapGID)
	local Active_task=activitymgr:get('task')
	if Active_task==nil then
		look('在里面')
		return
	end
	if  not Active_task:is_active(sid) then
		if not Active_task:add_player(sid, 1, 0, nil, nil, mapGID) then 
			return 
		end
	end
end
--退出
local function _task_exit(sid)
	local Active_task=activitymgr:get('task')
	if Active_task==nil then
		return
	end
	Active_task:back_player(sid)
end
--传出
call_OnMapEvent[100102]=function ()
	local sid=CI_GetPlayerData(17)
	_task_exit(sid)
end
-------------------------------------------------------------------
task_start=_task_start--开始
task_enter=_task_enter--进入
task_exit=_task_exit--退出
