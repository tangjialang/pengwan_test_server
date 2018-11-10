--[[
file: span_boss.lua
desc: 跨服BOSS活动
autor: csj
]]--


---------------------------------------------------------------
--include:

local pairs,ipairs,type = pairs,ipairs,type
local tostring = tostring
local table_push,table_locate = table.push,table.locate

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
local _get_preslv = get_preslv
local _add_score = pres_add_score
---------------------------------------------------------------
--module:

module(...)

---------------------------------------------------------------
--data:
local spboss_config = {
	monster = {
		[1] = {
			[50] = {		-- 50级	小BOSS		
				{x = 37 , y = 45,controlId = 10010, monAtt = {[1] = 5000000},dir = 5, deadScript = 4501, monsterId = 598, deadbody = 6 ,},
				{x = 42 , y = 51,controlId = 10011, monAtt = {[1] = 5000000},dir = 5, deadScript = 4501, monsterId = 599, deadbody = 6 ,},
				{x = 47 , y = 58,controlId = 10012, monAtt = {[1] = 5000000},dir = 5, deadScript = 4501, monsterId = 600, deadbody = 6 ,},
			},
			[60] = {		-- 60级	小BOSS		
				{x = 37 , y = 45,controlId = 10010, monAtt = {[1] = 7000000},dir = 5, deadScript = 4501, monsterId = 602, deadbody = 6 ,},
				{x = 42 , y = 51,controlId = 10011, monAtt = {[1] = 7000000},dir = 5, deadScript = 4501, monsterId = 603, deadbody = 6 ,},
				{x = 47 , y = 58,controlId = 10012, monAtt = {[1] = 7000000},dir = 5, deadScript = 4501, monsterId = 604, deadbody = 6 ,},
			},	
			[70] = {		-- 70级	小BOSS	
				{x = 37 , y = 45,controlId = 10010, monAtt = {[1] = 10000000},dir = 5, deadScript = 4501, monsterId = 606, deadbody = 6 ,},
				{x = 42 , y = 51,controlId = 10011, monAtt = {[1] = 10000000},dir = 5, deadScript = 4501, monsterId = 607, deadbody = 6 ,},
				{x = 47 , y = 58,controlId = 10012, monAtt = {[1] = 10000000},dir = 5, deadScript = 4501, monsterId = 608, deadbody = 6 ,},
			},
            [80] = {		-- 80级	小BOSS	
				{x = 37 , y = 45,controlId = 10010, monAtt = {[1] = 12000000},dir = 5, deadScript = 4501, monsterId = 895, deadbody = 6 ,},
				{x = 42 , y = 51,controlId = 10011, monAtt = {[1] = 12000000},dir = 5, deadScript = 4501, monsterId = 896, deadbody = 6 ,},
				{x = 47 , y = 58,controlId = 10012, monAtt = {[1] = 12000000},dir = 5, deadScript = 4501, monsterId = 897, deadbody = 6 ,},
			},				
		},
		[2] = {
			[50] = {		-- 50级	大BOSS		
				{x = 50 , y = 42,controlId = 10013, monAtt = {[1] = 20000000},dir = 0, moveArea = 0, deadScript = 4502, monsterId = 601, deadbody = 6 ,},				
			},
			[60] = {		-- 60级	大BOSS		
				{x = 50 , y = 42,controlId = 10013, monAtt = {[1] = 30000000},dir = 0, moveArea = 0, deadScript = 4502, monsterId = 605, deadbody = 6 ,},				
			},	
			[70] = {		-- 70级	大BOSS	
				{x = 50 , y = 42,controlId = 10013, monAtt = {[1] = 40000000},dir = 0, moveArea = 0, deadScript = 4502, monsterId = 609, deadbody = 6 ,},					
			},
			[80] = {		-- 80级	大BOSS	
				{x = 50 , y = 42,controlId = 10013, monAtt = {[1] = 50000000},dir = 0, moveArea = 0, deadScript = 4502, monsterId = 898, deadbody = 6 ,},					
			},
		},
	},
	relive_pos = {9,105},
}

-- 被杀损失
local pres_del_conf = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 10, 10, 10, 10, 10}
---------------------------------------------------------------
--inner:

-- 活动名称
local active_name = 'span_boss'
-- 活动编号
local SPAN_BOSS_ID = 1

-- 根据世界等级创建活动阵营怪物
local function _monster_create(mapGID,idx)
	if mapGID == nil or idx == nil then return end
	local active_sb = activitymgr:get(active_name)
	if active_sb == nil then
		look('_monster_create active_sb == nil')		
		return
	end	
	local active_flags = active_sb:get_state()
	if active_flags == 0 then
		look('_monster_create active has end')
		return
	end
	local region_data = active_sb:get_regiondata(mapGID)
	if region_data == nil then
		look('_monster_create get_regiondata erro')
		return
	end
	local num = (region_data.num or 0) + 1
	local wlevel = GetSpanServerInfo(SPAN_BOSS_ID) or 0
	if wlevel < 50 then
		wlevel = 50
	end
	local monster_conf = spboss_config.monster
	if monster_conf == nil or monster_conf[idx] == nil then return end
	local tpos = table_locate(monster_conf[idx],wlevel,2)
	if tpos == nil then return end
	local mc = monster_conf[idx][tpos]
	if mc == nil then return end
	-- 初始化怪物GID列表
	-- region_data.mons = region_data.mons or {}
	for k, v in ipairs(mc) do
		v.monAtt = v.monAtt or {}
		local orgHP = v.monAtt[1]
		if orgHP and orgHP > 0 then
			local MaxHP = rint(orgHP * num)
			if MaxHP > 2000000000 then
				MaxHP = 2000000000
			end
			v.regionId = mapGID						-- 设置怪物场景ID
			v.level = wlevel
			v.monAtt[1] = MaxHP
			local monGID = CreateObjectIndirect(v)		-- 创建怪物
			-- 注意：这一步很重要必须要还原血量！！！
			v.monAtt[1] = orgHP
			-- if monGID and monGID > 0 then
				-- region_data.mons[monGID] = 1
			-- end			
		end
	end
end

-- 场景创建处理
local function _on_regioncreate(slef,mapGID)	
	local now = GetServerTime()
	local bt_1 = GetTimeThisDay(now,15,20,0) + 60
	local et_1 = GetTimeThisDay(now,16,0,0)
	local bt_2 = GetTimeThisDay(now,22,15,0) + 60

	if now < bt_1 then
		local sec = bt_1 - now
		if sec > 10 * 60 then return end
		SetEvent(sec, nil, 'GI_spanboss_next', mapGID, 1)
		return
	end
	if now > et_1 and now < bt_2 then
		local sec = bt_2 - now
		if sec > 10 * 60 then return end
		SetEvent(sec, nil, 'GI_spanboss_next', mapGID, 1)
		return
	end
	
	_monster_create(mapGID,1)		-- 创建活动怪物		
end

-- 玩家复活处理
local function _on_playerlive(self,sid)	
	local active_sb = activitymgr:get(active_name)
	if active_sb == nil then 
		look('_on_playerlive active_sb == nil')
		return 
	end	
	local pos = spboss_config.relive_pos
	if type(pos) ~= type({}) then
		look('_on_playerlive relive_pos erro')
		return
	end	
	local _,_,_,mapGID = CI_GetCurPos()
	if not PI_MovePlayer(0,pos[1],pos[2],mapGID,2,sid) then
		look('_on_playerlive PI_MovePlayer erro')
		return
	end
	return 1
end

-- 人物死亡
local function _on_playerdead(self, deader_sid, rid, mapGID, killer_sid)
	local mapGID = mapGID
	if deader_sid == nil or mapGID == nil then 
		look('_on_playerdead callback param erro')
		return
	end	
	local score = 0
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
		look('_on_playerdead get_regiondata erro')
		return false
	end
	
	if preslv_deader >= 11 then
		score = pres_del_conf[preslv_deader]
		-- look('_on_playerdead del score ' .. score)
		_add_score(deader_sid, 1, score, 1) -- 死亡减威望值
	end
		
	-- 杀人者 
	if killer_sid and killer_sid > 0 then
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
				score = rint((5 + preslv_deader)*0.5)
			else
				score = rint(5 + preslv_deader)
			end
			-- look('_on_playerkiller add score ' .. score)
			_add_score(killer_sid, 2, score, 1) -- 杀人加威望值
			
			if preslv_deader <= 7 then
				_add_score(deader_sid, 2, 1, 1)	--死亡加威望值
			end
		end
	end
end

-- 移除BOSS
local function _sb_traverse_region(mapGID)
	-- 根据controlid移除BOSS
	for i = 10010,10013 do
		RemoveObjectIndirect(mapGID,i)
	end	
end

-- 活动结束 删除BOSS
local function _on_active_end(self)
	local active_sb = activitymgr:get(active_name)
	if active_sb == nil then
		look('_on_active_end active_sb == nil')		
		return
	end	
	-- 遍历房间移除当前存在的BOSS
	active_sb:traverse_region(_sb_traverse_region)	
end

-- 活动自定义接口处理函数注册
local function _sb_register_func(active_sb)
	active_sb.on_regioncreate = _on_regioncreate
	active_sb.on_regionchange = _on_regionchange
	active_sb.on_playerdead = _on_playerdead
	active_sb.on_playerlive = _on_playerlive
	active_sb.on_login = _on_login
	active_sb.on_logout = _on_logout
	active_sb.on_active_end = _on_active_end	
end

-- 跨服BOSS活动开始
-- 判断下跨服类型为1的才开
local function _sb_start()
	look('-----------_sb_start----------')
	local con = GetSpanServerInfo(SPAN_BOSS_ID)
	if con == nil then 
		look('_sb_start span server type not correct!')
		return 
	end
	-- assert 1: 没结束之前不能开始
	local active_sb = activitymgr:get(active_name)
	if active_sb then
		look('_sb_start has not end')		
		return
	end	
	-- 创建活动
	active_sb = activitymgr:create(active_name)
	if active_sb == nil then
		look('active_sb create erro')
		return
	end
	-- 注册活动类函数(internal use)
	_sb_register_func(active_sb)
	-- 创建活动场景
	local mapGID = active_sb:createDR(1)
	if mapGID == nil then
		look('active_sb createDR erro')
		return
	end
	look('mapGID:' .. mapGID)
	local region_data = active_sb:get_regiondata(mapGID)
	if region_data == nil then
		look('_sb_start get_regiondata erro')
		return
	end
		
	look('BroadcastRPC sb_start')
	BroadcastRPC('sb_start')
end

-- 进入战场
local function _sb_enter(sid, mapGID)
	if sid == nil then return end	
	local active_sb = activitymgr:get(active_name)
	if active_sb == nil then 
		look('_sb_enter active_sb == nil')
		return 
	end
	-- assert 1: 判断活动是否已结束
	local active_flags = active_sb:get_state()
	if active_flags == 0 then
		look('_sb_enter active is end')
		return
	end
	-- assert 2: 判断是否已经在活动中
	if active_sb:is_active(sid) then
		look('_sb_enter player is in active')
		return
	end
	-- assert 3: 等级 >= 50
	local lv = CI_GetPlayerData(1,2,sid)
	if lv < 50 then
		look('_sb_enter player lv < 50')
		return
	end
	-- 获取进入跨服前保存的房间地图GID信息
	mapGID = mapGID or __G.GetPlayerSpanGID(sid)	
	if mapGID == nil then
		look('_sb_enter mapGID == nil')
		-- 为了兼容老服
		local spanData = __G.GetPlayerSpanData(sid)
		if spanData == nil then return end
		spanData[1] = spanData[1] or {}
		mapGID = spanData[1][1]
	end
		
	-- put player to region
	local ret, gid = active_sb:add_player(sid, 1, 0, nil, nil, mapGID)
	if not ret then
		look('_sb_enter add_player erro')
		return
	end	
	local region_data = active_sb:get_regiondata(gid)
	if region_data == nil then
		look('_sb_enter get_regiondata erro')
		return
	end
	
	RPC('sb_enter',region_data.tm)
	return true
end

call_monster_dead[4501] = function (mapGID)
	local active_sb = activitymgr:get(active_name)
	if active_sb == nil then
		look('_monster_create active_sb == nil')		
		return
	end	
	local active_flags = active_sb:get_state()
	if active_flags == 0 then
		look('_monster_create active has end')
		return
	end
	local region_data = active_sb:get_regiondata(mapGID)
	if region_data == nil then
		look('_monster_create get_regiondata erro')
		return
	end
	-- 移除怪物GID列表
	-- local monGID = GetMonsterData(27,3)
	-- if monGID and monGID > 0 then
		-- region_data.mons = region_data.mons or {}
		-- if region_data.mons[monGID] then
			-- region_data.mons[monGID] = nil
		-- end
	-- end
	region_data.dc = (region_data.dc or 0) + 1
	if region_data.dc >= 3 then
		region_data.dc = 0
		_monster_create(mapGID,2)
	end
end

call_monster_dead[4502] = function (mapGID)
	local active_sb = activitymgr:get(active_name)
	if active_sb == nil then
		look('_monster_create active_sb == nil')		
		return
	end	
	local active_flags = active_sb:get_state()
	if active_flags == 0 then
		look('_monster_create active has end')
		return
	end
	local region_data = active_sb:get_regiondata(mapGID)
	if region_data == nil then
		look('_monster_create get_regiondata erro')
		return
	end
	-- 更新波数
	region_data.num = (region_data.num or 0) + 1
	local net = 3*60
	-- 更新时间
	region_data.tm = GetServerTime() + 3*60
	-- 移除怪物GID列表
	-- local monGID = GetMonsterData(27,3)
	-- if monGID and monGID > 0 then
		-- region_data.mons = region_data.mons or {}
		-- if region_data.mons[monGID] then
			-- region_data.mons[monGID] = nil
		-- end
	-- end
	-- 3分钟后创建下一波怪
	SetEvent(3*60, nil, "GI_spanboss_next", mapGID, 1)
	RegionRPC(mapGID, 'sb_next_time', region_data.tm)
	local pName = CI_GetPlayerData(5)
	if type(pName) == type('') then
		local roomid = active_sb:get_room_id(mapGID)
		BroadcastRPC('sb_notice',pName,roomid)
	end
end

local function _sb_get_rooms(svrid,uid,con,idx)
	if svrid == nil then return end
	local active_sb = activitymgr:get(active_name)
	if active_sb == nil then
		look('_sb_get_rooms active_sb == nil')
		PI_SendSpanMsg(svrid, {t = 1, ids = 1001, uid = uid, con = con, idx = idx })
		return
	end	
	local active_flags = active_sb:get_state()
	if active_flags == 0 then
		look('_sb_get_rooms active_sb has end')
		PI_SendSpanMsg(svrid, {t = 1, ids = 1001, uid = uid, con = con, idx = idx })
		return
	end
	PI_SendSpanMsg(svrid, {t = 1, ids = 1001, uid = uid, con = con, idx = idx, rooms = active_sb.room })
end

------------------------------------------------------------
--interface:

sb_start = _sb_start
sb_enter = _sb_enter
sb_get_rooms = _sb_get_rooms
monster_create = _monster_create