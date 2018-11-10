--[[
file: span_xunbao.lua
desc: 跨服寻宝活动
autor: zld
]]--


---------------------------------------------------------------
--include:

local pairs,ipairs,type = pairs,ipairs,type
local tostring = tostring
local table_push,table_locate = table.push, table.locate
local math_random = math.random

local __G = _G
local look = look
local npclist = npclist
local GetServerTime = GetServerTime
local call_monster_dead = call_monster_dead
local call_npc_click = call_npc_click
local GetWorldLevel = GetWorldLevel
local GetWorldCustomDB = GetWorldCustomDB
local rint = rint
local RPC = RPC
local RPCEx = RPCEx
local AreaRPC = AreaRPC
local RegionRPC = RegionRPC
local BroadcastRPC = BroadcastRPC
local sc_add = sc_add
local SetEvent = SetEvent
local SetCamp = SetCamp
local CI_AddBuff = CI_AddBuff
local CI_DelBuff = CI_DelBuff
local CI_HasBuff = CI_HasBuff
local CI_GetCurPos = CI_GetCurPos
local CI_SelectObject = CI_SelectObject
local CI_GetNpcData = CI_GetNpcData
local CI_UpdateNpcData = CI_UpdateNpcData
local CI_SetReadyEvent = CI_SetReadyEvent
local CI_GetPlayerData = CI_GetPlayerData
local CI_GetPKList = CI_GetPKList
local GetNpcidByUID = GetNpcidByUID
local CreateGroundItem = CreateGroundItem
local GetObjectUniqueId = GetObjectUniqueId
local GetPlayerDayData = GetPlayerDayData
local MailConfig = MailConfig
local GetMonsterData = GetMonsterData
local SendSystemMail = SendSystemMail
local GetTempTitle = GetTempTitle
local SetTempTitle = SetTempTitle
local ClrTempTitle = ClrTempTitle
local CheckTimes = CheckTimes
local TimesTypeTb = TimesTypeTb
local GiveGoods = GiveGoods
local MonsterEvents = MonsterEvents
local MonsterRegisterEventTrigger = MonsterRegisterEventTrigger
local award_check_items = award_check_items
local GI_GiveAward = GI_GiveAward
local sc_getdaydata = sc_getdaydata
local sc_getweekdata = sc_getweekdata
local sc_reset_getawards = sc_reset_getawards
local PI_MovePlayer = PI_MovePlayer
local isFullNum = isFullNum
local GetStringMsg = GetStringMsg
local TipCenter = TipCenter
local PI_SendSpanMsg = PI_SendSpanMsg
local GetSpanServerInfo = GetSpanServerInfo
local CreateObjectIndirectEx = CreateObjectIndirectEx
local CreateObjectIndirect = CreateObjectIndirect
local RemoveObjectIndirect = RemoveObjectIndirect
local CI_UpdateMonsterData = CI_UpdateMonsterData
local active_mgr_m = require('Script.active.active_mgr')
local activitymgr = active_mgr_m.activitymgr
local rand_mgr_m = require('Script.active.random_pos_manager')
local RandPosSys_Get = rand_mgr_m.RandPosSys_Get
local RandPosSys_ReuseAll = rand_mgr_m.RandPosSys_ReuseAll
local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist = sclist_m.insert_scorelist
local insert_scorelist_ex = sclist_m.insert_scorelist_ex
local get_scorelist_data = sclist_m.get_scorelist_data
local db_module = require('Script.cext.dbrpc')
local db_active_getaward = db_module.db_active_getaward
local common_time = require('Script.common.time_cnt')
local GetTimeThisDay = common_time.GetTimeThisDay
local define = require('Script.cext.define')
local ProBarType = define.ProBarType
local _add_score = pres_add_score
local _get_preslv = get_preslv
local GetTimesInfo = GetTimesInfo
local GetPlayerPoints = GetPlayerPoints
---------------------------------------------------------------
--module:

module(...)

---------------------------------------------------------------
--data:
local TYPE_PRE = 12
-- 被杀损失
local pres_del_conf = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10, 10, 10, 20, 20, 20, 20, 20}
local t_conf = {
	-- 采集npc
	npc_site ={400550,400553}, --刷新npc 起始-结束npcid

	refresh={---采集时间,刷新时间
		[1]={15,3600},
		[2]={15,3600},
		[3]={15,3600},
		[4]={15,3600},
	},

	--奖励--通用奖励配置
	awards={
		--爆物品ID
		[1] = {802, 802, 802, 804, 804, 804, 804, 804,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099},
		[2] = {802, 802, 802, 804, 804, 804, 804, 804,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099}, 
		[3] = {802, 802, 802, 804, 804, 804, 804, 804,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099},
		[4] = {802, 802, 802, 804, 804, 804, 804, 804,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099,1099},
	},
	
	-- lucky_awards={[1] = {},},
}

local spxb_config = {
	monster = {
		[1] = {
			[50] = {
				{monsterId = 610, centerX = 22, centerY = 45,BRMONSTER=1,BRArea=6,BRNumber=20, deadScript = 4601,deadbody = 5,refreshTime=1,},
				{monsterId = 610, centerX = 90, centerY = 208,BRMONSTER=1,BRArea=6,BRNumber=20, deadScript = 4601,deadbody = 5,refreshTime=1,},
				{monsterId = 610, centerX = 24, centerY = 200,BRMONSTER=1,BRArea=6,BRNumber=20, deadScript = 4601,deadbody = 5,refreshTime=1,},
				{monsterId = 610, centerX = 18, centerY = 167,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
				{monsterId = 610, centerX = 19, centerY = 113,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
				{monsterId = 610, centerX = 73, centerY = 160,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
				{monsterId = 610, centerX = 99, centerY = 79,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
				{monsterId = 610, centerX = 84, centerY = 13,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},

			},
			[60] = {
				{monsterId = 611, centerX = 22, centerY = 45,BRMONSTER=1,BRArea=6,BRNumber=20, deadScript = 4601,deadbody = 5,refreshTime=1,},
				{monsterId = 611, centerX = 90, centerY = 208,BRMONSTER=1,BRArea=6,BRNumber=20, deadScript = 4601,deadbody = 5,refreshTime=1,},
				{monsterId = 611, centerX = 24, centerY = 200,BRMONSTER=1,BRArea=6,BRNumber=20, deadScript = 4601,deadbody = 5,refreshTime=1,},
				{monsterId = 611, centerX = 18, centerY = 167,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
				{monsterId = 611, centerX = 19, centerY = 113,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
				{monsterId = 611, centerX = 73, centerY = 160,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
				{monsterId = 611, centerX = 99, centerY = 79,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
				{monsterId = 611, centerX = 84, centerY = 13,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
			},
			[70] = {
				{monsterId = 612, centerX = 22, centerY = 45,BRMONSTER=1,BRArea=6,BRNumber=20, deadScript = 4601,deadbody = 5,refreshTime=1,},
				{monsterId = 612, centerX = 90, centerY = 208,BRMONSTER=1,BRArea=6,BRNumber=20, deadScript = 4601,deadbody = 5,refreshTime=1,},
				{monsterId = 612, centerX = 24, centerY = 200,BRMONSTER=1,BRArea=6,BRNumber=20, deadScript = 4601,deadbody = 5,refreshTime=1,},
				{monsterId = 612, centerX = 18, centerY = 167,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
				{monsterId = 612, centerX = 19, centerY = 113,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
				{monsterId = 612, centerX = 73, centerY = 160,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
				{monsterId = 612, centerX = 99, centerY = 79,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
				{monsterId = 612, centerX = 84, centerY = 13,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
			},
			[80] = {
				{monsterId = 612, centerX = 22, centerY = 45,BRMONSTER=1,BRArea=6,BRNumber=20, deadScript = 4601,deadbody = 5,refreshTime=1,},
				{monsterId = 612, centerX = 90, centerY = 208,BRMONSTER=1,BRArea=6,BRNumber=20, deadScript = 4601,deadbody = 5,refreshTime=1,},
				{monsterId = 612, centerX = 24, centerY = 200,BRMONSTER=1,BRArea=6,BRNumber=20, deadScript = 4601,deadbody = 5,refreshTime=1,},
				{monsterId = 612, centerX = 18, centerY = 167,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
				{monsterId = 612, centerX = 19, centerY = 113,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
				{monsterId = 612, centerX = 73, centerY = 160,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
				{monsterId = 612, centerX = 99, centerY = 79,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
				{monsterId = 612, centerX = 84, centerY = 13,BRMONSTER=1,BRArea=10,BRNumber=20, deadScript = 4601,deadbody = 25,refreshTime=25,},
			},
		},
	},
	relive_pos = {
		[1] = {15,23},
		[2] = {110,31},
		[3] = {114,210},
		[4] = {12,210},
	},
}

---------------------------------------------------------------
--inner:

local active_name = 'span_xunbao'

-- 根据世界等级创建活动阵营怪物
local function _spxb_create_monster(mapGID)
	if mapGID == nil then return end
	local active_spxb = activitymgr:get(active_name)
	if active_spxb == nil then
		-- look('_spxb_create_monster active_spxb == nil')		
		return
	end	
	local active_flags = active_spxb:get_state()
	if active_flags == 0 then
		-- look('_spxb_create_monster active has end')
		return
	end
	local region_data = active_spxb:get_regiondata(mapGID)
	if region_data == nil then
		-- look('_spxb_create_monster get_regiondata erro')
		return
	end
	local wlevel = GetSpanServerInfo(2) or 0
	local monster_conf = spxb_config.monster[1]
	if type(monster_conf) ~= type({}) then return end
	local baselv = table_locate(monster_conf, wlevel, 2)
	if baselv == nil or monster_conf[baselv] == nil then
		return
	end
	
	local mc = monster_conf[baselv]
	if mc == nil then return end
	----[[
	for k, v in ipairs(mc) do
		-- v.monAtt = v.monAtt or {}
		v.regionId = mapGID -- 设置怪物场景ID
		v.level = baselv
		local gid = CreateObjectIndirect(v) -- 创建怪物
		if gid == nil then
			-- look('_spxb_create_monster gid == nil')
		end
	end
	--]]
	--[[
		mc[1].monAtt = mc[1].monAtt or {}
		mc[1].regionId = mapGID -- 设置怪物场景ID
		mc[1].level = baselv
		look('*******************start')
		look(mc[1].monAtt)
		look(mc[1].regionId)
		look(mc[1].level)
		look('*******************end')
		local gid = CreateObjectIndirect(mc[1]) -- 创建怪物
		if gid == nil then
			look('_spxb_create_monster gid == nil')
		end
	--]]
end

local function _spxb_traverse_region(mapGID)
	_spxb_create_monster(mapGID)
end

function CreateMonster()
	local active_spxb = activitymgr:get('span_xunbao')
	if active_spxb == nil then
		return
	end	
	local active_spxb_flag = active_spxb:get_state()
	if active_spxb_flag == 0 then	
		return
	end
	active_spxb:traverse_region(_spxb_traverse_region)
end

--创建宝箱NPC
local function _spxb_create_npc_monster( mapGID )
	if mapGID == nil then return end
	local active_spxb = activitymgr:get(active_name)
	if active_spxb == nil then
		-- look('_spxb_create_npc_monster active_spxb == nil')		
		return
	end	
	local active_flags = active_spxb:get_state()
	if active_flags == 0 then
		-- look('_spxb_create_npc_monster active has end')
		return
	end
	local region_data = active_spxb:get_regiondata(mapGID)
	if region_data == nil then
		-- look('_spxb_create_npc_monster get_regiondata erro')
		return
	end
	local npc_conf = t_conf.npc_site
	if npc_conf == nil then return end
	for i = npc_conf[1], npc_conf[2] do
		local t = npclist[i]		
		if type(t) == type({}) then
			t.NpcCreate.regionId = mapGID
			t.NpcCreate.clickScript = t.NpcCreate.clickScript or 50022
			local gid = CreateObjectIndirectEx(1, i, t.NpcCreate) -- 创建宝箱NPC
			if gid == nil then
				-- look('_spxb_create_monster gid == nil')
				return
			end
		end
	end
end

-- 场景创建处理
local function _on_regioncreate(self,mapGID)	
	-- local now = GetServerTime()
	-- local bt_1 = GetTimeThisDay(now,15,20,0) + 60
	-- local et_1 = GetTimeThisDay(now,16,0,0)
	-- local bt_2 = GetTimeThisDay(now,22,15,0) + 60

	-- if now < bt_1 then
		-- local sec = bt_1 - now
		-- if sec > 10 * 60 then return end
		-- SetEvent(sec, nil, 'GI_spanxb_next', mapGID, 1)
		-- return
	-- end
	-- if now > et_1 and now < bt_2 then
		-- local sec = bt_2 - now
		-- if sec > 10 * 60 then return end
		-- SetEvent(sec, nil, 'GI_spanxb_next', mapGID, 1)
		-- return
	-- end
	_spxb_create_monster(mapGID)		-- 创建活动怪物	
	_spxb_create_npc_monster( mapGID )	
end

-- 玩家复活处理
local function _on_playerlive(self,sid)	
	local active_spxb = activitymgr:get(active_name)
	if active_spxb == nil then 
		-- look('_on_playerlive active_spxb == nil')
		return 
	end	
	local rand = math_random(4)
	local pos = spxb_config.relive_pos[rand]
	if type(pos) ~= type({}) then
		-- look('_on_playerlive relive_pos erro')
		return
	end	
	local _,_,_,mapGID = CI_GetCurPos()
	if not PI_MovePlayer(0,pos[1],pos[2],mapGID,2,sid) then
		-- look('_on_playerlive PI_MovePlayer erro')
		return
	end
	return 1
end

-- 人物死亡
local function _on_playerdead(self, deader_sid, rid, mapGID, killer_sid)
	local mapGID = mapGID
	if deader_sid == nil or mapGID == nil then 
		-- look('_on_playerdead callback param erro',1)
		return
	end	
	local score = 0
	-- local pres_deader = GetPlayerPoints(deader_sid, TYPE_PRE) --取玩家威望值
	-- pres_deader = pres_deader or 0
	local preslv_deader = _get_preslv(deader_sid) --取玩家威望等级
	preslv_deader = preslv_deader or 0
	
	-- 活动已结束不会加分数了
	local active_spxb = activitymgr:get(active_name)
	if active_spxb == nil then			
		return
	end	
	-- 活动已结束不会加分数了
	local active_flags = active_spxb:get_state()
	if active_flags == 0 then	
		return
	end
	-- 获取场景data
	local region_data = active_spxb:get_regiondata(mapGID)
	if region_data == nil then
		-- look('_on_playerdead get_regiondata erro')
		return false
	end
	-- local deader_data = active_spxb:get_mydata(deader_sid)
	-- if deader_data == nil then
		-- look('_on_playerdead get get_mydata erro',1)
		-- return
	-- end
	if preslv_deader >= 11 then
		score = pres_del_conf[preslv_deader]
		-- look('_on_playerdead del score ' .. score)
		_add_score(deader_sid, 1, score, 1) -- 死亡减威望值
	end
	
	-- 杀人者 
	if killer_sid and killer_sid > 0 then
		-- local killer_data = active_spxb:get_mydata(killer_sid)
		-- if killer_data == nil then
			-- look('_on_playerdead get killer data erro',1)
			-- return
		-- end
		-- local pres_killer = GetPlayerPoints(killer_sid, TYPE_PRE) --取玩家威望值
		-- pres_killer = pres_killer or 0
		local preslv_killer = _get_preslv(killer_sid)	--取玩家威望等级
		preslv_killer = preslv_killer or 0
		
		local deader_fac = CI_GetPlayerData(23, 2, deader_sid)
		local killer_fac = CI_GetPlayerData(23, 2, killer_sid)
		if killer_fac == nil or deader_fac == nil then
			return
		end
		
		if (killer_fac == 0 and deader_fac == 0) or (killer_fac ~= deader_fac) then --同帮会的不加分
			if preslv_killer - preslv_deader > 10 then --相差10级不加分
				score = 0
			elseif preslv_killer - preslv_deader > 5 then --相差5级分数减半
				score = rint((20 + preslv_deader)*0.5)
			else
				score = rint(20 + preslv_deader)
			end
			-- look('_on_playerkiller add score ' .. score)
			_add_score(killer_sid, 2, score, 1) -- 杀人加威望值
			
			if preslv_deader <= 7 then
				_add_score(deader_sid, 2, 5, 1)	--死亡加威望值
			end
		end
	end
end


-- 移除怪
local function _spxb_traverse_region(mapGID)
	-- 根据controlid移除怪
	for i = 10010, 10013 do
		RemoveObjectIndirect(mapGID,i)
	end	
end

-- 活动结束 删除怪
local function _on_active_end(self)
	local active_spxb = activitymgr:get(active_name)
	if active_spxb == nil then
		-- look('_on_active_end active_spxb == nil')		
		return
	end	
	-- 遍历房间移除当前存在的怪
	-- active_spxb:traverse_region(_spxb_traverse_region)	
end

-- 活动自定义接口处理函数注册
local function _spxb_register_func(active_spxb)
	active_spxb.on_regioncreate = _on_regioncreate
	active_spxb.on_playerdead = _on_playerdead
	active_spxb.on_playerlive = _on_playerlive
	active_spxb.on_active_end = _on_active_end	
end

-- 跨服寻宝活动开始
-- 判断下跨服类型为2的才开
local function _spxb_start()
	-- look('-----------_spxb_start----------')
	----[[
	local uid = GetSpanServerInfo(2)
	if uid == nil then 
		-- look('_spxb_start span server type not correct!')
		return 
	end
	--]]
	-- assert 1: 没结束之前不能开始
	local active_spxb = activitymgr:get(active_name)
	if active_spxb then
		-- look('_spxb_start has not end')		
		return
	end	
	-- 创建活动
	active_spxb = activitymgr:create(active_name)
	if active_spxb == nil then
		-- look('active_spxb create erro')
		return
	end
	-- 注册活动类函数(internal use)
	_spxb_register_func(active_spxb)
	-- 创建活动场景
	local mapGID = active_spxb:createDR(1)
	if mapGID == nil then
		-- look('active_spxb createDR erro')
		return
	end
	-- look('mapGID:' .. mapGID)
	local region_data = active_spxb:get_regiondata(mapGID)
	if region_data == nil then
		-- look('_spxb_start get_regiondata erro')
		return
	end
		
	BroadcastRPC('spanxb_start')
end

-- 进入战场
local function _spxb_enter(sid)
	-- look('_spxb_enter')
	if sid == nil then return end	
	local active_spxb = activitymgr:get(active_name)
	if active_spxb == nil then 
		-- look('_spxb_enter active_spxb == nil')
		return 
	end
	-- assert 1: 判断活动是否已结束
	local active_flags = active_spxb:get_state()
	if active_flags == 0 then
		-- look('_spxb_enter active is end')
		return
	end
	-- assert 2: 判断是否已经在活动中
	if active_spxb:is_active(sid) then
		-- look('_spxb_enter player is in active')
		return
	end
	-- assert 3: 等级 >= 50
	local lv = CI_GetPlayerData(1,2,sid)
	if lv < 50 then
		-- look('_spxb_enter player lv < 50')
		return
	end
	
	----[[
	-- 获取进入跨服前保存的房间地图GID信息
	local mapGID = __G.GetPlayerSpanGID(sid)
	if mapGID == nil then
		-- look('_spxb_enter mapGID == nil')
		return
	end
	--]]
	-- local mapGID = 1073746312
	
	local rand = math_random(4)
	local pos = spxb_config.relive_pos[rand]
	if type(pos) ~= type({}) then
		-- look('_on_playerlive relive_pos erro')
		return
	end	
	-- put player to region
	local ret, gid = active_spxb:add_player(sid, 1, 0, pos[1], pos[2], mapGID)
	if not ret then
		-- look('_spxb_enter add_player erro')
		return
	end	
	local region_data = active_spxb:get_regiondata(gid)
	if region_data == nil then
		-- look('_spxb_enter get_regiondata erro')
		return
	end
	
	RPC('spxb_in',region_data)
	return true
end
----[[
call_monster_dead[4601] = function (mapGID)
	local active_spxb = activitymgr:get(active_name)
	if active_spxb == nil then
		-- look('_spxb_create_monster active_spxb == nil')		
		return
	end	
	local active_flags = active_spxb:get_state()
	if active_flags == 0 then
		-- look('_spxb_create_monster active has end')
		return
	end
	local region_data = active_spxb:get_regiondata(mapGID)
	if region_data == nil then
		-- look('_spxb_create_monster get_regiondata erro')
		return
	end
	-- _spxb_mon_refresh(mapGID)
	local sid= CI_GetPlayerData(17)
	if sid == nil then return end
	if CheckTimes(sid, TimesTypeTb.Spxb_MonDead, 1, -1, 0) then --检查威望值每日上限
		_add_score(sid, 2, 10, 1)
	end
end
--]]
local function _spxb_get_rooms(svrid,uid,con,idx)
	if svrid == nil then return end
	local active_spxb = activitymgr:get(active_name)
	if active_spxb == nil then
		-- look('_spxb_get_rooms active_spxb == nil')
		PI_SendSpanMsg(svrid, {t = 1, ids = 2001, uid = uid, con = con, idx = idx })
		return
	end	
	local active_flags = active_spxb:get_state()
	if active_flags == 0 then
		-- look('_spxb_get_rooms active_spxb has end')
		PI_SendSpanMsg(svrid, {t = 1, ids = 2001, uid = uid, con = con, idx = idx })
		return
	end
	PI_SendSpanMsg(svrid, {t = 1, ids = 2001, uid = uid, con = con, idx = idx, rooms = active_spxb.room })
end

-- 点击拿宝箱
call_npc_click[50022]=function ()	
	-- look('spxb点击拿宝箱')
	local sid= CI_GetPlayerData(17)
	local pakagenum = isFullNum()
	if pakagenum < 1 then --判断背包空间是否足够
		TipCenter(GetStringMsg(14,1))
		return 
	end
	
	local controlID, cid = GetObjectUniqueId()
	local npcid = controlID - 100000
	local index = npcid - t_conf.npc_site[1] + 1
	if index > 4 then 
		index = 4
	end
	local needtime = t_conf.refresh[index][1]
	CI_SetReadyEvent(controlID, ProBarType.collect, needtime, 1, 'GI_spxb_chick')
end
--开宝箱回调
local function _spxb_chick( controlID )
	-- look('spxb开宝箱回调')
	local active_spxb = activitymgr:get(active_name)
	if active_spxb == nil then
		-- look('_spxb_chick active_spxb == nil')
		return
	end	
	local sid = CI_GetPlayerData(17)
	if controlID == nil then
		return
	end
	
	local bx, by, rid, mapGID = CI_GetCurPos(6, controlID)
	-- local bx, by = CI_GetCurPos(2,sid)

	if mapGID == nil then
		return
	end
	local a = CI_SelectObject(6, controlID, mapGID )
	if (not a ) or a < 1 then
		TipCenter(GetStringMsg(436))
		return 0
	end

	local npcid = controlID - 100000
	local index = npcid - t_conf.npc_site[1] + 1
	if index > 4 then 
		index = 4
	end
	local AwardTb = t_conf.awards[index]
	local now = GetServerTime()
	
	local count = 0
	for _, itemid in ipairs(AwardTb) do
		CreateGroundItem(0, mapGID, itemid, 1, bx, by, count)
		count = count + 1			
	end
	--[[
	-- 概率掉落道具
	local rand = math_random(100)
	local dropCount = 1
	if rand <= 5 then
		if not CheckTimes(sid, TimesTypeTb.Shenqi_Drop, dropCount, -1, 0) then return end
		local shCount = 0
		for i = 1, dropCount do
			CreateGroundItem(0, mapGID, 805, 1, bx, by, shCount)
			shCount = shCount + 1
		end
	end
	--]]
	local region_data = active_spxb:get_regiondata(mapGID)
	if region_data == nil then
		-- look('_spxb_enter get_regiondata erro')
		return
	end
	local _time = t_conf.refresh[index][2]

	region_data[index] = now + _time
	if index <= 4 then
		RegionRPC(mapGID,'spxb_up',index,region_data[index],sid,CI_GetPlayerData(3))
	end
	SetEvent(_time, nil, "GI_spxb_box_refresh", npcid, mapGID) 
	RemoveObjectIndirect( mapGID, controlID )
	return 1
end
--[[
--刷怪
local function _spxb_mon_refresh(mapGID)
	if mapGID == nil then return end
	local active_spxb = activitymgr:get(active_name)
	if active_spxb == nil then
		look('_spxb_mon_refresh active_spxb == nil')		
		return
	end	
	local active_flags = active_spxb:get_state()
	if active_flags == 0 then
		look('_spxb_mon_refresh active has end')
		return
	end
	local region_data = active_spxb:get_regiondata(mapGID)
	if region_data == nil then
		look('_spxb_mon_refresh get_regiondata erro')
		return
	end
	local wlevel = GetSpanServerInfo(2) or 0
	if wlevel < 50 then
		wlevel = 50
	end
	
	local mon_conf = spxb_config.monster
	if mon_conf == nil then return end
	mon_conf.monAtt = mon_conf.monAtt or {}
	mon_conf.regionId = mapGID -- 设置怪物场景ID
	mon_conf.level = wlevel
	CreateObjectIndirect(mon_conf) -- 创建怪物	
end
--]]

--重刷宝箱npc
local function _spxb_box_refresh( npcid, mapGID )
	if mapGID == nil then return end
	local active_spxb = activitymgr:get(active_name)
	if active_spxb == nil then
		-- look('_spxb_box_refresh active_spxb == nil')		
		return
	end	
	local active_flags = active_spxb:get_state()
	if active_flags == 0 then
		-- look('_spxb_box_refresh active has end')
		return
	end
	local region_data = active_spxb:get_regiondata(mapGID)
	if region_data == nil then
		-- look('_spxb_box_refresh get_regiondata erro')
		return
	end
	-- look('重刷宝箱npc')
	-- look(npcid)
	-- look(mapGID)
	local npc = npclist[npcid]
	npc.NpcCreate.regionId = mapGID
	CreateObjectIndirectEx(1, npcid, npc.NpcCreate)
end

------------------------------------------------------------
--interface:

spxb_start = _spxb_start
spxb_enter = _spxb_enter
spxb_get_rooms = _spxb_get_rooms
-- spxb_monster_create = _spxb_create_monster
spxb_create_npc_monster = _spxb_create_npc_monster
spxb_chick = _spxb_chick
-- spxb_mon_refresh = _spxb_mon_refresh
spxb_box_refresh = _spxb_box_refresh