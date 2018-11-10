--[[
file: anonymity_fight.lua
desc: 匿名战场
autor: wk
update: 2013-10-10
data:
	active_afight = {
		player[sid] = {		-- 本次活动玩家数据
			--camp = 1,		-- 玩家当前阵营(活动期间不改变)					
			dead_c = 1,		-- 当前死亡次数(用于死亡复仇buffer等级)
			score_m = 2,	-- 本次活动积分(用于活动结算积分最多者)
			kill_m = 2,		-- 累计杀人数(用于活动结算杀人最多者)
			--col_m = 1,		-- 采集法宝碎片数(用于活动结算采集法宝碎片数最多者)
			dead_m = 1,		-- 本场活动总死亡次数(用于活动结算死亡次数最多者)					
		},
	}
]]--

---------------------------------------------------------------
--include:

local pairs,ipairs,type = pairs,ipairs,type
local tostring = tostring
local table_push,table_locate = table.push,table.locate

local look = look
local npclist = npclist
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
local GetNpcidByUID = GetNpcidByUID
local CreateGroundItem = CreateGroundItem
local GetObjectUniqueId = GetObjectUniqueId
local MailConfig = MailConfig
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
local CreateObjectIndirectEx = CreateObjectIndirectEx
local CreateObjectIndirect = CreateObjectIndirect
local RemoveObjectIndirect = RemoveObjectIndirect
local _random=math.random
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
---------------------------------------------------------------
--module:

module(...)

---------------------------------------------------------------
--data:
local afight_config = {
	monster = {
		[1] = {		-- 基地Boss			
			{x = 52 , y = 81 ,dir = 5 ,controlId = 10100, deadScript = 4007, monsterId = 290, deadbody = 6 },
		},					
		[2] = {		-- 攻击怪
			{BRMONSTER = 1, centerX = 69 , centerY = 72 , BRArea = 3 , BRNumber =2 , refreshTime =250, targetX =69, targetY =87, dir = 1 ,controlId = 10132, monsterId = 296, deadScript = 4006, deadbody = 6 ,camp = 1},			
			{BRMONSTER = 1, centerX = 55 , centerY = 61 , BRArea = 3 , BRNumber =2 , refreshTime =250, targetX =46, targetY =65, dir = 1 ,controlId = 10134, monsterId = 296, deadScript = 4006, deadbody = 6 ,camp = 1},			
			{BRMONSTER = 1, centerX = 60 , centerY = 108 , BRArea = 3 , BRNumber =2 , refreshTime =250, targetX =53, targetY =100, dir = 1 ,controlId = 10128, monsterId = 300, deadScript = 4006, deadbody = 6 ,camp = 2},			
			{BRMONSTER = 1, centerX = 66 , centerY = 105 , BRArea = 3 , BRNumber =2 , refreshTime =250, targetX =68, targetY =89, dir = 1 ,controlId = 10130, monsterId = 300, deadScript = 4006, deadbody = 6 ,camp = 2},			
			{BRMONSTER = 1, centerX = 33 , centerY = 76 , BRArea = 3 , BRNumber =2 , refreshTime =250, targetX =45, targetY =66, dir = 1 ,controlId = 10124, monsterId = 298, deadScript = 4006, deadbody = 6 ,camp = 3},			
			{BRMONSTER = 1, centerX = 35 , centerY = 83 , BRArea = 3 , BRNumber =2 , refreshTime =250, targetX =52, targetY =99, dir = 1 ,controlId = 10126, monsterId = 298, deadScript = 4006, deadbody = 6 ,camp = 3},			
			
		},		
	},
	wlevel = {		-- 世界等级对怪物属性影响
		[30] = {
			 [1] = {[1] = 1000000 , [3] = 50000,[4] = 10000 , [5] = 5000,[6] = 5000 , [7] = 5000,[8] = 5000 , [9] = 5000, },
			-- [2] = {[1] = 100000 , [3] = 3000,[4] = 3000 , [5] = 2500,[6] = 2500 , [7] = 2500,[8] = 2500 , [9] = 2500,},
			[3] = {[1] = 6000 , [3] = 1000,[4] = 1000 , [5] = 500,[6] = 500 , [7] = 500,[8] = 500 , [9] = 500, },	-- 攻击怪二级属性
		},
		[40] = {
			 [1] = {[1] = 2000000 , [3] = 100000,[4] = 15000 , [5] = 6000,[6] = 6000 , [7] = 6000,[8] = 6000 , [9] = 6000,},
			-- [2] = {[1] = 200000 , [3] = 5000,[4] = 5000 , [5] = 3000,[6] = 3000 , [7] = 3000,[8] = 3000 , [9] = 3000, },	
			[3] = {[1] = 8000 , [3] = 1200,[4] = 1200 , [5] = 800,[6] = 800 , [7] = 800,[8] = 800 , [9] = 800, },	-- 攻击怪二级属性
		},
		[50] = {
			 [1] = {[1] = 3000000 , [3] = 150000,[4] = 20000 , [5] = 7000,[6] = 7000 , [7] = 7000,[8] = 7000 , [9] = 7000, },
			 [2] = {[1] = 300000 , [3] = 7000,[4] = 7000 , [5] = 4000,[6] = 4000 , [7] = 4000,[8] = 4000 , [9] = 4000, },
			[3] = {[1] = 10000 , [3] = 1300,[4] = 1300 , [5] = 1000,[6] = 1000 , [7] = 1000,[8] = 1000 , [9] = 1000, },	-- 攻击怪二级属性
		},
		[60] = {
			 [1] = {[1] = 4000000 , [3] = 200000,[4] = 25000 , [5] = 8000,[6] = 8000 , [7] = 8000,[8] = 8000 , [9] = 8000, },
			-- [2] = {[1] = 400000 , [3] = 9000,[4] = 9000 , [5] = 5000,[6] = 5000 , [7] = 5000,[8] = 5000 , [9] = 5000, },
			[3] = {[1] = 15000 , [3] = 1400,[4] = 1400 , [5] = 1200,[6] = 1200 , [7] = 1200,[8] = 1200 , [9] = 1200, },	-- 攻击怪二级属性
		},
		[70] = {
			 [1] = {[1] = 5000000 , [3] = 250000,[4] = 30000 , [5] = 9000,[6] = 9000 , [7] = 9000,[8] = 9000 , [9] = 9000, },
			-- [2] = {[1] = 500000 , [3] = 11000,[4] = 11000 , [5] = 6000,[6] = 6000 , [7] = 6000,[8] = 6000 , [9] = 6000, },
			[3] = {[1] = 20000 , [3] = 1400,[4] = 1400 , [5] = 1300,[6] = 1300 , [7] = 1300,[8] = 1300 , [9] = 1300, },	-- 攻击怪二级属性
		},
	},
	relive_pos = {
		[1] = {80,27},
		[2] = {80,141},
		[3] = {6,82},
	},

}

---------------------------------------------------------------
--inner:

local active_name = 'afight'

local function get_af_data()
	local custom = GetWorldCustomDB()
	if custom == nil then return end
	if custom.afight == nil then
		custom.afight = {
		-- final={},前50名,以sid为key
		-- 	mapGID=mapGID
		-- 	tops = {
		-- 		[1] = {score_m,name},			-- 最完美玩家 = 本场活动积分最多玩家
		-- 		[2] = {kill_m,name},			-- 最勇猛玩家 = 本场活动杀人数最多玩家
		-- 		[3] = {col_m,name},				-- 最勤劳玩家 = 本场活动采集法宝碎片数最多玩家
		-- 		[4] = {dead_m,name},			-- 最倒霉玩家 = 本场活动被杀次数最多玩家
		-- 	},
	}
	end
	return custom.afight
end

-- 获取最玩家
local function _get_tops()
	local common_data = get_af_data()
	if common_data then
		return common_data.tops
	end
end

-- 更新最玩家
local function _update_tops(itype,val,name)
	if itype == nil or val == nil or name == nil then
		return
	end
	local common_data = get_af_data()
	if common_data then
		common_data.tops = common_data.tops or {}
		common_data.tops[itype] = common_data.tops[itype] or {}
		local t = common_data.tops[itype]
		if val > (t[1] or 0) then
			t[1] = val
			t[2] = name
		end
	end
end


-- 增加活动积分(本场活动积分及排行榜/周活动积分及排行榜/更新阵营积分)
local function _add_score(sid,val)
	if sid == nil or val == nil then
		return
	end
	-- 活动已结束不会加分数了
	local active_afight = activitymgr:get(active_name)
	if active_afight == nil then			
		return
	end	
	-- 活动已结束不会加分数了
	local active_flags = active_afight:get_state()
	if active_flags == 0 then	
		return
	end
	local common_data = get_af_data()
	if common_data == nil then
		look('_add_score get_common erro')
		return
	end	
	local my_data = active_afight:get_mydata(sid)
	if my_data == nil then
		look('_add_score get_mydata erro')
		return
	end

	local name = CI_GetPlayerData(5,2,sid)
	local school = CI_GetPlayerData(2,2,sid)
	-- 更新活动积分及排行榜(每日和每周)
	local day_score,week_score = sc_add(sid,10,val)
	insert_scorelist(1,10,50,day_score,name,school,sid)		-- 更新每日排行榜
	insert_scorelist(2,10,10,week_score,name,school,sid)		-- 更新每周排行榜

	-- 同步玩家当前积分给前台
	RPCEx(sid,'af_update',day_score)
end


-- 根据世界等级创建活动阵营怪物
local function _monster_create(mapGID)
	look('根据世界等级创建活动阵营怪物')
	look('_monster_create')
	local monster_conf = afight_config.monster
	local wlevel_conf = afight_config.wlevel
	local world_lv = GetWorldLevel() or 1 
	local tpos = table_locate(wlevel_conf,world_lv,2)
	look('_monster_create')
	look(tpos)
	if tpos == nil or wlevel_conf[tpos] == nil then		-- 这里应该不会失败
		look('afight monster config erro')
		return
	end
	local CreateObjectIndirect = CreateObjectIndirect
	for idx, conf in pairs(monster_conf) do
		if type(conf) == type({}) then
			for _, v in pairs(conf) do
				v.regionId = mapGID						-- 设置怪物场景ID
				v.level = tpos
				v.monAtt = wlevel_conf[tpos][idx]				
				local ret = CreateObjectIndirect(v)		-- 创建怪物	
				look('创建怪物')	
				look(ret)			
			end
		end
	end
end


-- 清理上次活动数据
local function _clear_active_common()
	local common_data = get_af_data()
	if common_data == nil then
		look('_clear_active_common get_common erro')
		return
	end	
	--common_data.camps = nil
	common_data.mapGID = nil
	common_data.tops = nil
	common_data.final = nil
end

-- 场景创建处理
local function _on_regioncreate(slef,mapGID)
	look('_on_regioncreate')	
	--_npc_create(mapGID)			-- 创建活动npc
	_monster_create(mapGID)		-- 创建活动怪物		
end

-- 场景切换处理
local function _on_regionchange(slef,sid)
	look('_on_regionchange')
	-- 清理法宝碎片和连斩
	ClrTempTitle(sid)
	CI_DelBuff(169,2,sid)
end

-- 人物死亡
local function _on_playerdead(self,deader_sid,rid,mapGID,killer_sid)
	look('_on_playerdead')
	if deader_sid == nil or mapGID == nil then 
		look('_on_playerdead callback param erro')
		return
	end	
	-- 活动已结束不会加分数了
	local active_afight = activitymgr:get(active_name)
	if active_afight == nil then			
		return
	end	
	-- 活动已结束不会加分数了
	local active_flags = active_afight:get_state()
	if active_flags == 0 then	
		return
	end
	-- 获取场景data
	local region_data = active_afight:get_regiondata(mapGID)
	if region_data == nil then
		look('_afight_buff_refresh get_regiondata erro')
		return false
	end
	local deader_data = active_afight:get_mydata(deader_sid)
	if deader_data == nil then
		look('_on_playerdead get get_mydata erro')
		return
	end
	-- 死亡分数 +2 更新分数
	_add_score(deader_sid,2)
	look('CI_HasBuff')
	-- 连续死亡次数 +1 (更新复仇buff)
	if not CI_HasBuff(241,2,deader_sid) then		-- 如果已经没有Buff了就又从0开始
		deader_data.dead_c = 0
	end
	deader_data.dead_c = (deader_data.dead_c or 0) + 1
	if deader_data.dead_c > 10 then deader_data.dead_c = 10 end
	-- 死亡 +buffer
	-- look(deader_data.dead_c)
	-- look(deader_sid)
	-- look('CI_AddBuff')
	CI_AddBuff(241,0,deader_data.dead_c,false,2,deader_sid)
	-- 本次活动总死亡次数 +1 (更新最倒霉玩家)
	deader_data.dead_m = (deader_data.dead_m or 0) + 1
	local deader_name = CI_GetPlayerData(5,2,deader_sid)
	_update_tops(4,deader_data.dead_m,deader_name)

	-- -- 死亡会终结连斩数
	-- local deader_kill_c = GetTempTitle(deader_sid,1,1) or 0		-- 获取死亡的人的当前连斩数
	-- SetTempTitle(deader_sid,1,1,0,0)
	-- -- 死亡会掉头顶资源(10 - 7 = 3)
	-- local deader_res = GetTempTitle(deader_sid,1,2) or 0		-- 获取死亡的人的当前资源数
	-- if deader_res == 10 then
	-- 	SetTempTitle(deader_sid,1,2,3,0)
	-- end
	
	-- 杀人者 ========================
	if killer_sid and killer_sid > 0 then
		local killer_data = active_afight:get_mydata(killer_sid)
		if killer_data == nil then
			look('_on_playerdead get killer data erro')
			return
		end
		-- -- 对方连斩数对应积分 * 自己连斩系数
		-- local base = _get_kills_pos(deader_kill_c) 					-- 根据死亡者当前连斩获得基础积分
		-- local killer_kill_c = GetTempTitle(killer_sid,1,1) or 0
		-- local _, radio = _get_kills_pos(killer_kill_c) 				-- 根据杀人者当前连斩获得积分倍率
		-- local score = (base or 10) * (radio or 1)
		local score = 10
		_add_score(killer_sid,score)		-- 更新分数
		-- -- 连斩杀人数 +1
		-- SetTempTitle(killer_sid,1,1,1,1)
		-- 本场总杀人数 +1 (更新最完美玩家)
		killer_data.kill_m = (killer_data.kill_m or 0) + 1
		local killer_name = CI_GetPlayerData(5,2,killer_sid)
		_update_tops(2,killer_data.kill_m,killer_name)
		-- 掠夺资源
		-- if deader_res > 0 then
			-- SetTempTitle(killer_sid,1,2,deader_res,1)
		-- end
		-- 如果有复仇buff 移除之！
		CI_DelBuff(241,2,killer_sid)
		killer_data.dead_c = 0	-- 保险起见置位杀人者连续死亡次数
		-- if deader_kill_c >= 5 then
		-- 	RegionRPC(mapGID,'szjc_notice',1,killer_name,deader_name,deader_kill_c)
		-- end
	end
end

-- 玩家复活处理
local function _on_playerlive(self,sid)	
	look('_on_playerlive')
	local active_afight = activitymgr:get(active_name)
	if active_afight == nil then 
		look('_on_playerlive active_afight == nil')
		return 
	end
	-- get active player data
	local my_data = active_afight:get_mydata(sid)
	if my_data == nil then
		look('_on_playerlive get_mydata erro')
		return
	end
	local mycamp =_random(1,3)
	local pos = afight_config.relive_pos
	if type(pos) ~= type({}) or pos[mycamp] == nil then
		look('_on_playerlive relive_pos erro')
		return
	end	
	local _,_,_,mapGID = CI_GetCurPos()
	if not PI_MovePlayer(0,pos[mycamp][1],pos[mycamp][2],mapGID,2,sid) then
		look('_on_playerlive PI_MovePlayer erro')
		return
	end
	return 1
end

-- 三界战场上线处理
local function _on_login(self,sid)
	-- local active_afight = activitymgr:get(active_name)
	-- if active_afight == nil then
	-- 	look('_on_login afight has end')		
	-- 	return
	-- end
	-- local common_data = get_af_data()
	-- if common_data == nil then		
	-- 	return
	-- end
	-- -- 上线同步阵营积分
	-- if common_data.camps then
	-- 	active_afight:traverse_region(_afight_traverse_region,3)
	-- end
end

-- 三界战场下线处理
local function _on_logout(self,sid)
	look('afight _on_logout')
	-- 清理法宝碎片和连斩
	ClrTempTitle(sid)
	CI_DelBuff(169,2,sid)
end

-- 三界战场活动结束处理
-- 调用一次同步阵营积分,设置胜利阵营
local function _on_active_end(self)
	look('_on_active_end')
	-- 设置胜利阵营
	--_set_win_camp()
	-- 如果宝箱没开启开启宝箱
	-- local active_afight = activitymgr:get(active_name)
	-- if active_afight then
		-- active_afight:traverse_region(_afight_traverse_region,2)
	-- end
	-- 这里通过排行榜取最完美玩家(积分最高)
	local sclist = get_scorelist_data(1,10)
	if sclist[1] then
		_update_tops(1,sclist[1][1],sclist[1][2]) 
	end
	local tops = _get_tops()		-- 取本场之最
	-- 发送邮件
	if type(tops) == type({}) then
		local SendSystemMail = SendSystemMail
		for k, v in pairs(tops) do
			if type(k) == type(0) and type(v) == type({}) then
				look(v[2])
				look(k)
				SendSystemMail(v[2],MailConfig.afight,k,2) 
			end
		end
	end
end

-- 活动自定义接口处理函数注册
local function _afight_register_func(active_afight)
	active_afight.on_regioncreate = _on_regioncreate
	active_afight.on_regionchange = _on_regionchange
	active_afight.on_playerdead = _on_playerdead
	active_afight.on_playerlive = _on_playerlive
	active_afight.on_login = _on_login
	active_afight.on_logout = _on_logout
	active_afight.on_active_end = _on_active_end	
end

-- 三界战场活动开始
local function _afight_start()
	look('-----------_afight_start----------')
	-- assert 1: 没结束之前不能开始
	local active_afight = activitymgr:get(active_name)
	if active_afight then
		look('afight_start has not end')		
		return
	end	
	-- 清理上次活动数据
	_clear_active_common()
	-- 创建活动
	active_afight = activitymgr:create(active_name)
	if active_afight == nil then
		look('afight_start create erro')
		return
	end
	-- 注册活动类函数(internal use)
	_afight_register_func(active_afight)
	-- 创建活动场景
	local mapGID = active_afight:createDR(1)
	if mapGID == nil then
		look('afight_start createDR erro')
		return
	end
	look('mapGID:' .. mapGID)
	local region_data = active_afight:get_regiondata(mapGID)
	if region_data == nil then
		look('afight_start get_regiondata erro')
		return
	end
	local common_data = get_af_data()
	if common_data == nil then		
		return
	end	
	common_data.mapGID=mapGID
	-- 15分钟决赛
	SetEvent(15*60, nil, "GI_af_secfight") 
	BroadcastRPC('af_start')
end

-- 进入战场
local function _afight_enter(sid)
	local common_data = get_af_data()
	if common_data == nil then		
		return
	end	
	local mapGID=common_data.mapGID
	if sid == nil or mapGID == nil then return end	
	local active_afight = activitymgr:get(active_name)
	if active_afight == nil then 
		look('afight_enter active_afight == nil')
		return 
	end
	-- assert 1: 判断活动是否已结束
	local active_flags = active_afight:get_state()
	if active_flags == 0 then
		look('afight_enter active is end')
		return
	end
	-- assert 2: 判断是否已经在活动中
	if active_afight:is_active(sid) then
		look('afight_enter player is in active')
		return
	end
	-- assert 3: 等级 >= 30
	local lv = CI_GetPlayerData(1,2,sid)
	if lv < 38 then
		look('afight_enter player lv < 30')
		return
	end
	-- get active player data
	local my_data = active_afight:get_mydata(sid)
	if my_data == nil then
		look('afight_enter get_mydata erro')
		return
	end
	if (my_data.dead_m or 0)>=12 then 
		RPC('af_res',1)
		return 
	end
	local mycamp =_random(1,3)
	local pos = afight_config.relive_pos
	if type(pos) ~= type({}) or pos[mycamp] == nil then
		look('afight_enter relive_pos erro')
		return
	end
	-- put player to region
	if not active_afight:add_player(sid, 1, 0, pos[mycamp][1], pos[mycamp][2], mapGID) then
		look('afight_enter add_player erro')
		return
	end
	local dayscore = sc_getdaydata(sid,6) or 0		-- 每日积分
	RPC('afight_update',dayscore)
end

-- 退出活动场景
local function _afight_exit(sid)
	look('active_afight')
	local active_afight = activitymgr:get(active_name)
	if active_afight == nil then	
		look('_afight_exit active_afight == nil')
		return
	end	
	look('active_afight1111')
	active_afight:back_player(sid)
end

-- 攻击怪死亡 +10分
call_monster_dead[4006] = function (mapGID)
	local active_afight = activitymgr:get(active_name)
	if active_afight == nil then			
		return
	end	
	-- 活动已结束
	local active_flags = active_afight:get_state()
	if active_flags == 0 then	
		return
	end
	local sid = CI_GetPlayerData(17) or 0
	if sid > 0 then
		local my_data = active_afight:get_mydata(sid)
		if my_data then
			_add_score(sid,10)
		end
	end
end
-- boss死亡 +1000分
call_monster_dead[4007] = function (mapGID)
	local active_afight = activitymgr:get(active_name)
	if active_afight == nil then			
		return
	end	
	-- 活动已结束
	local active_flags = active_afight:get_state()
	if active_flags == 0 then	
		return
	end

	local sid = CI_GetPlayerData(17) or 0
	if sid > 0 then
		local my_data = active_afight:get_mydata(sid)
		if my_data then
			_add_score(sid,1000)
			local killer_name = CI_GetPlayerData(5)
			RegionRPC(mapGID,'af_notice',1,killer_name)
		end
	end
end



--决赛时间到
function _af_secfight( mapGID )
	local sclist_data = get_scorelist_data(1,10)
	local common_data = get_af_data()
	if common_data == nil then		
		return
	end	
	if common_data.final==nil then 
		common_data.final={}
	end
	for i=1,50 do
		common_data.final[sclist_data[i][4]]=i
	end
	RegionRPC(mapGID,'af_sec')
end

--请求进入决赛
function af_asktosecfight( sid )
	local common_data = get_af_data()
	if common_data == nil then		
		return
	end	
	if common_data.final==nil then 
		return
	end
	if common_data.final[sid]==nil then 
		RPC('af_end',1) --未进前50
	else
		RPC('af_end',2) --进前50
		PI_MovePlayer(nil, 33, 44, common_data.mapGID) 
	end
end
--------------------奖励-----------------------------------
local _awards = {}

local function _afight_build_award(name,dayscore,sclist,camp,win_c)
	if dayscore <= 0 then
		return
	end
	-- 清理奖励表
	for k, v in pairs(_awards) do
		_awards[k] = nil
	end
	local wlevel = GetWorldLevel() or 1
	if wlevel < 30 then wlevel = 30 end
	local field = (rint(dayscore / 100) + 4) / 10
	if field > 1 then field = 1 end
	local exps = rint( (wlevel ^ 2.2 * 27 * 9 * 7 / 8) * field )
	local zg = rint( ((wlevel ^ 2) / 4) * field )
	local win_id = 1077
	if camp and win_c and camp == win_c then
		win_id = 1076
	end
	local rank = 0
	if sclist then
		for k, v in pairs(sclist) do
			if v[2] == name then
				rank = k
				break
			end
		end
	end
	look('rank' .. rank)
	local box_id
	if rank == 1 then
		box_id = 1074
	elseif rank >= 2 and rank <= 10 then
		box_id = 1075
	end
	_awards[2] = exps
	_awards[3] = {}
	_awards[7] = zg
	if dayscore >= 100 then		-- 大于100分才有宝箱奖励
		table_push(_awards[3],{win_id,1,1})
	end
	if box_id then
		table_push(_awards[3],{box_id,1,1})
	end
	return _awards
end

-- 发送结果信息
local function _afight_report_result(sid,bget)
	look('_afight_report_result')
	local active_afight = activitymgr:get(active_name)
	-- 如果活动还没结束,不能领奖
	if active_afight then 
		local active_flags = active_afight:get_state()
		if active_flags ~= 0 then
			look('_afight_report_result active_afight is alive')
			return
		end		
	end
	local camp = CI_GetPlayerData(39,2,sid)
	if camp == nil or camp <= 0 then
		return
	end
	local dayscore = sc_getdaydata(sid,6) or 0		-- 每日积分	
	local weekscore = sc_getweekdata(sid,6) or 0	-- 每周积分
	local tops = _get_tops()						-- 取本场之最
	local win_c = _get_win_camp()					-- 获取胜利阵营	
	local sclist = get_scorelist_data(1,6)
	look(sclist)
	local name = CI_GetPlayerData(5,2,sid)
	local award = _afight_build_award(name,dayscore,sclist,camp,win_c)	-- 构造奖励
	if bget then
		return award
	else
		RPC('afight_panel',dayscore,weekscore,win_c,tops,award)
	end	
end

-- 给奖励
local function _afight_give_award(sid)
	look('_afight_give_award')
	local dayscore = sc_getdaydata(sid,10) or 0
	if dayscore <= 0 then
		sc_reset_getawards(sid,10)		-- 积分清0
		RPC('afight_award',1)
		return
	end
	local award = _afight_report_result(sid,1)
	look(award)
	if award == nil then return end
	local getok = award_check_items(award)
	if not getok then
		return
	end
	-- 只做统计(用于活跃度)
	CheckTimes(sid,TimesTypeTb.Fight_Time,1)			
	-- 设置领奖标志(积分清0)
	sc_reset_getawards(sid,10)
	local ret = GI_GiveAward(sid,award,"三界战场奖励")
	RPC('afight_award',0)
	-- 丢出活动场景
	_afight_exit(sid)
end



------------------------------------------------------------
--interface:

afight_start = _afight_start
afight_enter = _afight_enter
afight_exit = _afight_exit
afight_report_result = _afight_report_result
afight_give_award = _afight_give_award
af_secfight=_af_secfight