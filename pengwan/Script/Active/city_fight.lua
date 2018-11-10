--[[
file: city_fight.lua
desc: 攻城战
autor: csj
]]--

-------------------------------------------------------------------------
--include:
local pairs,ipairs,type,tostring = pairs,ipairs,type,tostring
local GetCityFightData = GetCityFightData
local CI_GetFactionInfo = CI_GetFactionInfo
local CI_GetMemberInfo = CI_GetMemberInfo
local CI_GetFactionLeaderInfo = CI_GetFactionLeaderInfo
local CreateObjectIndirect = CreateObjectIndirect
local CreateObjectIndirectEx = CreateObjectIndirectEx
local CI_UpdateMonsterData = CI_UpdateMonsterData
local CI_SetFactionInfo = CI_SetFactionInfo
local MonsterEvents = MonsterEvents
local MonsterRegisterEventTrigger = MonsterRegisterEventTrigger
local CI_DelMonster = CI_DelMonster
local GetFactionData = GetFactionData
local IsPlayerOnline = IsPlayerOnline
local GetNpcidByUID = GetNpcidByUID
local CI_UpdateNpcData = CI_UpdateNpcData
local GetObjectUniqueId = GetObjectUniqueId
local SetRegionMultExp = SetRegionMultExp
local SendSystemMail = SendSystemMail
local MailConfig = MailConfig
local CheckTimes = CheckTimes
local TimesTypeTb = TimesTypeTb
local UpdateCityImageID = UpdateCityImageID
local rint = rint
local look = look
local __G = _G
local __debug = __debug
local RPC = RPC
local RPCEx = RPCEx
local RegionRPC = RegionRPC
local AreaRPC = AreaRPC
local FactionRPC = FactionRPC
local BroadcastRPC = BroadcastRPC
local GiveGoods = GiveGoods
local isFullNum = isFullNum
local GetStringMsg = GetStringMsg
local TipCenter = TipCenter
local CI_GetPKList = CI_GetPKList
local CI_GetCurPos = CI_GetCurPos
local CI_GetPlayerData = CI_GetPlayerData
local CI_GetFactionInfo = CI_GetFactionInfo
local GetMonsterData = GetMonsterData
local npclist = npclist
local call_npc_click = call_npc_click
local call_monster_dead = call_monster_dead
local monster_kill_award = monster_kill_award
local get_faction_union = get_faction_union
local SetEvent = SetEvent
local CI_AddBuff = CI_AddBuff
local CI_DelBuff = CI_DelBuff
local CI_HasBuff = CI_HasBuff
local GetTempTitle = GetTempTitle
local SetTempTitle = SetTempTitle
local ClrTempTitle = ClrTempTitle
local SetPlayerTitle = SetPlayerTitle
local RemovePlayerTitle = RemovePlayerTitle
local CI_SetReadyEvent = CI_SetReadyEvent
local award_check_items = award_check_items
local GI_GiveAward = GI_GiveAward
local PI_MovePlayer = PI_MovePlayer
local GetServerTime = GetServerTime
local CI_GetTopFactionID = CI_GetTopFactionID
local getCityOwner = getCityOwner
local GetPlayerPoints = GetPlayerPoints
local AddPlayerPoints = AddPlayerPoints

local db_module = require('Script.cext.dbrpc')
local db_get_city_info = db_module.db_get_city_info
local define = require('Script.cext.define')
local FACTION_BZ = define.FACTION_BZ
local active_mgr_m = require('Script.active.active_mgr')
local activitymgr = active_mgr_m.activitymgr
local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist = sclist_m.insert_scorelist
local insert_scorelist_ex = sclist_m.insert_scorelist_ex
local get_scorelist_data = sclist_m.get_scorelist_data
local define = require('Script.cext.define')
local ProBarType = define.ProBarType
local sc_add = sc_add
local sc_getdaydata = sc_getdaydata
local sc_reset_getawards = sc_reset_getawards

-------------------------------------------------------------------------
--module:

module(...)

-------------------------------------------------------------------------
--data:

local active_type = 11

local city_fight_conf = {
	-- 守城方雕像怪(根据帮主职业性别)				
	statue = {
		[10] = { monsterId = 523, x = 50, y = 75, EventID = 1, eventScript = 1023, monAtt = {[1] = 20100}, controlId = 13, mapIcon = 1, deadScript = 4401,},	-- 将军府(女)
		[11] = { monsterId = 522, x = 50, y = 75, EventID = 1, eventScript = 1023, monAtt = {[1] = 20100}, controlId = 13, mapIcon = 1, deadScript = 4401,},	-- 将军府(男)
		[20] = { monsterId = 525, x = 50, y = 75, EventID = 1, eventScript = 1023, monAtt = {[1] = 20100}, controlId = 13, mapIcon = 1, deadScript = 4401,},	-- 修仙(女)
		[21] = { monsterId = 524, x = 50, y = 75, EventID = 1, eventScript = 1023, monAtt = {[1] = 20100}, controlId = 13, mapIcon = 1, deadScript = 4401,},	-- 修仙(男)
		[30] = { monsterId = 527, x = 50, y = 75, EventID = 1, eventScript = 1023, monAtt = {[1] = 20100}, controlId = 13, mapIcon = 1, deadScript = 4401,},	-- 九黎(女)
		[31] = { monsterId = 526, x = 50, y = 75, EventID = 1, eventScript = 1023, monAtt = {[1] = 20100}, controlId = 13, mapIcon = 1, deadScript = 4401,},	-- 九黎(男)	
	},
	-- 防守方箭塔
	tower = {
		[1] = {monsterId = 528, x = 35, y = 77, monAtt = {[1] = 1000},deadScript = 4404,},
		[2] = {monsterId = 528, x = 48, y = 90, monAtt = {[1] = 1000},deadScript = 4404,},
		[3] = {monsterId = 528, x = 56, y = 82, monAtt = {[1] = 1000},deadScript = 4404,},
		[4] = {monsterId = 528, x = 43, y = 70, monAtt = {[1] = 1000},deadScript = 4404,},
		[5] = {monsterId = 528, x = 63, y = 74, monAtt = {[1] = 1000},deadScript = 4404,},
		[6] = {monsterId = 528, x = 51, y = 62, monAtt = {[1] = 1000},deadScript = 4404,},
		[7] = {monsterId = 528, x = 60, y = 53, monAtt = {[1] = 1000},deadScript = 4404,},
		[8] = {monsterId = 528, x = 72, y = 64, monAtt = {[1] = 1000},deadScript = 4404,},
		--[9] = {monsterId = 528, x = 82, y = 55, monAtt = {[1] = 50},deadScript = 4404,},
		--[10] = {monsterId = 528, x = 69, y = 43, monAtt = {[1] = 50},deadScript = 4404,},
	},	
	-- BOSS(守城大将)
	boss = {
		monsterId = 529, x = 50, y = 75, dir = 5, attackArea = 0,moveArea = 0,searchArea = 0, monAtt = {[1] = 200}, deadScript = 4402, controlId = 50001,aiType = 1031,
	},
	-- car
	car = {
		monsterId = 530, x = 14, y = 111, monAtt = {[1] = 800}, camp = 5, targetX = 43, targetY = 80, deadScript = 4403, aiType = 1027, Priority_Except ={ selecttype = 1 , type = 4 , target = 13 } ,
	},
	gcnpc = 400501,
	-- 玉玺npcid
	yuxi = 400500,
	-- 进入点
	enter_pos = {
		[1] = {89,30},				-- 防守方
		[2] = {9,126},				-- 进攻方
	},
	-- 每日礼包
	gifts = {
		[3] = { {682,3,1}, {640,3,1}, {634,3,1}, {636,3,1}, {710,1,1}, {51,1,1}, {601,5,1}, {603,5,1}},
	},
}

-------------------------------------------------------------------------
--inner:

local active_name = 'cf'


-- 当前防守方
local function get_defense_fid()
	local cfData = GetCityFightData()
	if cfData == nil then return end
	return cfData.def_fid
end

-- 设置当前防守方
local function set_defense_fid(fac_id)
	if fac_id == nil or fac_id <= 0 then return end
	local cfData = GetCityFightData()
	if cfData == nil then return end
	cfData.def_fid = fac_id
end

-- 城主帮会
local function get_owner_fid()				
	local cfData = GetCityFightData()
	if cfData == nil then return end
	local owner_fid = cfData.city_fac
	local bzsid = CI_GetFactionLeaderInfo(owner_fid,1)
	look('bzsid:' .. tostring(bzsid))
	local def_fid
	if owner_fid == nil or bzsid == nil then
		-- 如果当前没有城主、取帮会战积分第一的帮会作为守城方
		local have = false
		local ff_sclist = get_scorelist_data(2,9)
		if ff_sclist and ff_sclist[1] then
			local t = ff_sclist[1]
			if t[4] and t[4] > 0 then
				def_fid = t[4]
				local name = CI_GetFactionLeaderInfo(def_fid,3)
				if type(name) == type('') then
					have = true
				end
			end
		end
		-- 如果当前没有帮会战积分、取上周帮会战排名第一的帮会作为守城方
		if not have then
			if cfData.ff_last and cfData.ff_last > 0 then
				def_fid = cfData.ff_last
				local name = CI_GetFactionLeaderInfo(def_fid,3)
				if type(name) == type('') then
					have = true
				end
			end
		end
		-- 这个是最后保险(走到这里说明帮会肯定存在了)
		if not have then
			local top_fid = CI_GetTopFactionID()
			if top_fid and top_fid > 0 then
				def_fid = top_fid
				have = true
			end			
		end
		if not have then
			look('not city owner',1)
			return
		end
		look('def_fid:' .. tostring(def_fid))
		set_defense_fid(def_fid)
		return def_fid
	end
	set_defense_fid(cfData.city_fac)
	return cfData.city_fac
end

-- 设置城主帮会
local function set_owner_fid(fac_id)
	if fac_id == nil then return end
	local cfData = GetCityFightData()
	if cfData == nil then return end
	-- 设置占领时间
	if cfData.city_fac == nil then
		cfData.city_time = GetServerTime()		
	end
	if cfData.city_fac and cfData.city_fac ~= fac_id then
		cfData.city_time = GetServerTime()
		local last_sid = CI_GetFactionLeaderInfo(cfData.city_fac,1)
		if last_sid and IsPlayerOnline(last_sid) then
			RemovePlayerTitle(last_sid,39)
			CI_DelBuff(304,2,last_sid)
		end
		cfData.last_cz = last_sid	-- 记录上一次的城主
	end
	cfData.city_fac = fac_id
	local bzsid = CI_GetFactionLeaderInfo(fac_id,1)
	if bzsid and IsPlayerOnline(bzsid) then
		SetPlayerTitle(bzsid,39)
		CI_AddBuff(304,0,1,true,2,bzsid)
	end
	local name,sex,sch = CI_GetFactionLeaderInfo(fac_id,3)
	if type(name) == type('') then
		cfData.sex = sex
		cfData.sch = sch
	end
	-- 更新国王形象
	UpdateCityImageID(fac_id)
	look('cfData.city_fac:' .. tostring(fac_id))
end

local function get_active_flags()
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then 
		return 0
	end
	return active_cf:get_state()
end

local function get_faction_pub(fac_id)
	if fac_id == nil or fac_id <= 0 then return end
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then 
		return
	end
	local pub_data = active_cf:get_pub()
	if pub_data == nil then
		return
	end
	if pub_data[fac_id] == nil then
		pub_data[fac_id] = {}
	end
	return pub_data[fac_id]
end

local function get_cf_list()
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then 
		return
	end
	local pub_data = active_cf:get_pub()
	if pub_data == nil then
		return
	end
	if pub_data.cf_list == nil then
		pub_data.cf_list = {}
	end
	return pub_data.cf_list
end

-- 更新帮派积分
local function update_faction_data(fac_id,val)
	local fac_pub = get_faction_pub(fac_id)
	if fac_pub == nil then 
		return
	end
	local cf_list = get_cf_list()
	if cf_list == nil then 
		return
	end	
	fac_pub.c_score = (fac_pub.c_score or 0) + val
	local fac_name = CI_GetFactionInfo(fac_id,1)
	if type(fac_name) ~= type('') then return end
	local fac_lv = CI_GetFactionInfo(fac_id,2)
	if fac_lv == nil or fac_lv <= 0 then return end
	-- 更新临时积分排名表
	insert_scorelist_ex(cf_list,2,fac_pub.c_score,fac_name,fac_lv,fac_id)
end

-- 1 攻击方 0 防守方
local function get_fight_side(sid)
	local side = 1		-- 默认在攻击方
	-- 判断其是否属于防守方
	local def_fid = get_defense_fid()
	if def_fid == nil then return end
	local fac_id = get_faction_union(sid,1)	
	if fac_id and fac_id > 0 then
		if fac_id == def_fid then
			side = 0
		end
	end	
	return side
end

-- 获取最玩家
local function get_tops()
	local cfData = GetCityFightData()
	if cfData then
		return cfData.tops
	end
end

-- 更新最玩家
local function update_tops(itype,val,sid)
	if itype == nil or val == nil or sid == nil then
		return
	end
	local name = CI_GetPlayerData(5,2,sid)
	local cfData = GetCityFightData()
	if cfData then
		cfData.tops = cfData.tops or {}
		cfData.tops[itype] = cfData.tops[itype] or {}
		local t = cfData.tops[itype]
		if val > (t[1] or 0) then
			t[1] = val
			t[2] = name
		end
	end
end

local function GetPerHP(mon_gid,mapGID)
	local curHP = GetMonsterData(6,4,mon_gid,mapGID)
	if curHP == nil or curHP < 0 then
		return 0
	end
	local totalHP = GetMonsterData(7,4,mon_gid,mapGID)
	if totalHP == nil or curHP < 0 then
		return 0
	end
	local perHP = rint((curHP / totalHP) * 100)
	return perHP
end

-- 获取连斩阶段相关系数 (死亡对方加分,杀人自己倍率)
local function get_kills_pos(kill_c)
	if kill_c == nil or kill_c <= 10 then
		return 10,1
	end
	if kill_c > 10 and kill_c <= 30 then
		return 20,1.2
	elseif kill_c > 30 and kill_c <= 50 then
		return 30,1.5
	elseif kill_c > 50 then
		return 40,2
	end
end

-- 增加活动积分(个人积分/帮会积分)
local function add_score(sid,val)
	if sid == nil or val == nil then
		return
	end
	-- 活动已结束不会加分数了
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then			
		return
	end	
	-- 活动已结束不会加分数了
	local active_flags = active_cf:get_state()
	if active_flags == 0 then	
		return
	end	
	local my_data = active_cf:get_mydata(sid)
	if my_data == nil then
		look('add_score get_mydata erro')
		return
	end
	-- 更新活动积分
	look('val:' .. tostring(val))
	local day_score = sc_add(sid,active_type,val,1)
	look('day_score:' .. tostring(day_score))
	-- 更新最完美玩家
	local name = CI_GetPlayerData(5,2,sid)
	update_tops(1,day_score,sid)
	-- 更新帮会积分
	local fac_id = get_faction_union(sid,1)	
	if fac_id and fac_id > 0 then
		update_faction_data(fac_id,val)	
	end	
	-- 同步玩家当前积分给前台
	RPCEx(sid,'cf_player_score',day_score)
end

-- 玩家死亡处理
local function _on_playerdead(self,deader_sid,rid,mapGID,killer_sid)
	look('active_cf _on_playerdead')
	if deader_sid == nil or mapGID == nil then 
		look('active_cf _on_playerdead callback param erro')
		return
	end	
	-- 活动已结束不会加分数了
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then			
		return
	end	
	-- 活动已结束不会加分数了
	local active_flags = active_cf:get_state()
	if active_flags == 0 then	
		return
	end
	local deader_data = active_cf:get_mydata(deader_sid)
	if deader_data == nil then
		look('active_cf _on_playerdead get get_mydata erro')
		return
	end
	-- 死亡分数 +2 更新分数
	add_score(deader_sid,2)
	-- 连续死亡次数 +1 (更新复仇buff)
	if not CI_HasBuff(241,2,deader_sid) then		-- 如果已经没有Buff了就又从0开始
		deader_data.dead_c = 0
	end
	deader_data.dead_c = (deader_data.dead_c or 0) + 1
	if deader_data.dead_c > 10 then deader_data.dead_c = 10 end
	-- 死亡 +buffer
	CI_AddBuff(241,0,deader_data.dead_c,false,2,deader_sid)
	-- 本次活动总死亡次数 +1 (更新最倒霉玩家)
	deader_data.dead_m = (deader_data.dead_m or 0) + 1
	update_tops(4,deader_data.dead_m,deader_sid)
	-- 死亡会终结连斩数
	local deader_kill_c = GetTempTitle(deader_sid,1,1) or 0		-- 获取死亡的人的当前连斩数
	SetTempTitle(deader_sid,1,1,0,0)
	
	-- 杀人者 
	if killer_sid and killer_sid > 0 then
		local killer_data = active_cf:get_mydata(killer_sid)
		if killer_data == nil then
			look('_on_playerdead get killer data erro')
			return
		end
		-- 对方连斩数对应积分 * 自己连斩系数
		local base = get_kills_pos(deader_kill_c) 					-- 根据死亡者当前连斩获得基础积分
		local killer_kill_c = GetTempTitle(killer_sid,1,1) or 0
		local _, radio = get_kills_pos(killer_kill_c) 				-- 根据杀人者当前连斩获得积分倍率
		local score = (base or 10) * (radio or 1)
		add_score(killer_sid,score)		-- 更新分数
		-- 连斩杀人数 +1
		SetTempTitle(killer_sid,1,1,1,1)
		-- 本场总杀人数 +1 (更新最完美玩家)
		killer_data.kill_m = (killer_data.kill_m or 0) + 1
		update_tops(2,killer_data.kill_m,killer_sid)
		-- 如果有复仇buff 移除之！
		CI_DelBuff(241,2,killer_sid)
		killer_data.dead_c = 0	-- 保险起见置位杀人者连续死亡次数
		if deader_kill_c >= 5 then
			local killer_name = CI_GetPlayerData(5,2,killer_sid)
			local deader_name = CI_GetPlayerData(5,2,deader_sid)
			RegionRPC(mapGID,'ff_notice',1,killer_name,deader_name,deader_kill_c)
		end
	end
	-- 取助攻者列表 +1分
	local zglist = CI_GetPKList(20,5)
	look('zglist++++++++++++++++')
	look(zglist)
	if type(zglist) == type({}) then
		for _, pid in pairs(zglist) do			
			if pid ~= killer_sid then		-- 非杀人者才加积分
				add_score(pid,1)
			end
		end
	end
end

-- 玩家复活处理
local function _on_playerlive(self,sid)
	look('active_cf:_on_playerlive')
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then 
		look('active_cf:_on_playerlive active_cf == nil')
		return 
	end
	-- 获取玩家阵营
	local side = get_fight_side(sid)
	-- 取进入点
	local pos = city_fight_conf.enter_pos[side+1]
	look(pos)
	if pos == nil then return end
	local _,_,_,mapGID = CI_GetCurPos()
	if not PI_MovePlayer(0,pos[1],pos[2],mapGID,2,sid) then
		look('active_cf:_on_playerlive PI_MovePlayer erro')
		return
	end
	return 1
end

-- 创建雕像
local function create_statue(mapGID)
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then
		look('create_statue active_cf == nil')
		return
	end
	look('create_statue')
	local pub_data = active_cf:get_pub()
	if pub_data == nil then return end
	local def_fid = get_defense_fid()
	if def_fid == nil then return end
	look('create_statue:' .. tostring(def_fid))
	local fac_name = CI_GetFactionInfo(def_fid,1)
	-- 取当前城主信息
	local name,sex,sch = CI_GetFactionLeaderInfo(def_fid,3)
	look('name:' .. tostring(name))
	if type(name) ~= type('') then return end
	local index = sch * 10 + sex
	look('create_statue index:' .. tostring(index))
	-- 创建城主形象雕像
	local mon_conf = city_fight_conf.statue[index]
	if mon_conf == nil then return end
	mon_conf.name = name
	mon_conf.regionId = mapGID
	local mon_gid = CreateObjectIndirect(mon_conf)	
	CI_UpdateMonsterData(2,fac_name,4,mon_gid,mapGID)
	pub_data.statue = mon_gid		-- 保存雕像GID
	MonsterRegisterEventTrigger( mapGID, mon_gid, MonsterEvents[mon_conf.eventScript])
	-- 创建防守箭塔
	local tower_conf = city_fight_conf.tower
	for k, v in ipairs(tower_conf) do
		v.regionId = mapGID
		mon_gid = CreateObjectIndirect(v)
		CI_UpdateMonsterData(2,fac_name,4,mon_gid,mapGID)
	end
	local mon_conf = city_fight_conf.statue[index]
	if mon_conf == nil then return end
end

-- 创建工程器械NPC
local function create_npc(mapGID)
	-- local npc_id = city_fight_conf.gcnpc
	-- local npc_conf = npclist[npc_id]
	-- npc_conf.NpcCreate.regionId = mapGID
	-- CreateObjectIndirectEx(1,npc_id,npc_conf.NpcCreate)
	
	-- 创建攻城车
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then
		look('create_statue active_cf == nil')
		return
	end
	look('create_statue')
	local pub_data = active_cf:get_pub()
	if pub_data == nil then return end
	local car = city_fight_conf.car
	car.regionId = mapGID
	local mon_gid = CreateObjectIndirect(car)
	pub_data.car_gid = mon_gid
	look('call car success')					
end

local function _on_regioncreate(slef,mapGID,args)
	look('mapGID:' .. mapGID)
	-- 创建雕像
	create_statue(mapGID)
	create_npc(mapGID)	
end

-- 场景切换
local function _on_regionchange(slef,sid)
	look('active_ff:_on_regionchange')
	-- 清除连斩
	ClrTempTitle(sid)
	local buffid = 217
	if buffid then
		CI_DelBuff(buffid,2,sid)
	end
end

--设置新的城主 全服公告
local function set_fight_result()
	local def_fid = get_defense_fid()
	if def_fid == nil then return end
	-- 设置城主
	set_owner_fid(def_fid)
	-- 全服公告
	local fac_name = CI_GetFactionInfo(def_fid,1)
	if type(fac_name) ~= type('') then
		return
	end
	local cz_name = CI_GetFactionLeaderInfo(def_fid,3)
	BroadcastRPC('cf_winner',fac_name,cz_name)
end

-- 活动结束处理
local function _on_active_end()
	-- 设置新的城主
	set_fight_result()
	-- 给最XX玩家发送额外奖励邮件
	local tops = get_tops()
	if type(tops) == type({}) then
		local SendSystemMail = SendSystemMail
		for k, v in pairs(tops) do
			if type(k) == type(0) and type(v) == type({}) then
				look(v[2])
				look(k)
				SendSystemMail(v[2],MailConfig.cf,k,2) 
			end
		end
	end
end

-- 玩家上线处理
local function _on_login(self,sid)
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then
		look('_on_login active_cf == nil')
		return
	end
	local pub_data = active_cf:get_pub()
	if pub_data == nil then return end
	-- 取当前占领帮会名
	local def_fid = get_defense_fid()
	local def_name = CI_GetFactionInfo(def_fid,1)
	if type(def_name) ~= type('') then
		return
	end
	-- 取当前雕像血量
	local perHP = 0	
	if pub_data.statue and pub_data.statue > 0 then
		perHP = GetPerHP(pub_data.statue,pub_data.gid)
	end
	local my_data = active_cf:get_mydata(sid)
	if my_data == nil then return end	
	-- 取同盟帮会
	local union_fid = get_faction_union(nil,2,def_fid)
	local union_name = CI_GetFactionInfo(union_fid,1)
	RPC('cf_online',0,def_name,perHP,my_data.buff_cd,union_name,pub_data.hold_time,my_data.buff_lv)
end

-- 活动自定义接口处理函数注册
local function cf_register_func(active_cf)
	active_cf.on_regioncreate = _on_regioncreate
	active_cf.on_regionchange = _on_regionchange
	active_cf.on_playerdead = _on_playerdead
	active_cf.on_playerlive = _on_playerlive
	active_cf.on_login = _on_login
	active_cf.on_active_end = _on_active_end	
end

-- 清理上次活动数据
local function clear_active_common()
	local cfData = GetCityFightData()
	if cfData == nil then
		look('cf clear_active_common get_common erro')
		return
	end	
	cfData.tops = nil
end

local function _cf_start(flags)
	--1、攻城战开始
	if flags == 1 then
		local owner_fid = get_owner_fid()
		if owner_fid == nil then return end
		-- 创建活动
		local active_cf = activitymgr:create(active_name)
		if active_cf == nil then
			look('cf_start: create active erro')
			return
		end
		-- 清理上次活动数据
		clear_active_common()
		-- 注册活动类函数(internal use)
		cf_register_func(active_cf)
		
		-- 创建场景
		local gid = active_cf:createDR(1)
		look('cf_start gid:' .. tostring(gid))
		if gid and gid > 0 then
			local pub_data = active_cf:get_pub()
			if pub_data then
				pub_data.gid = gid
			end
			-- 设置倒计时(雕像必须在这个时间内打爆)
			local now = GetServerTime()
			pub_data.hold_time = now + 30*60
			-- if __debug then
				-- pub_data.hold_time = now + 3*60
			-- end
		end
		-- 设置当前防守方
		set_defense_fid(owner_fid)
		-- 设置地图归属帮会
		SetRegionMultExp(gid,2,owner_fid)
		active_cf:set_state(1)
		BroadcastRPC('cf_start',1)		
	end
end

-- 帮会攻城战进入
local function _cf_enter(sid,enterX,enterY)
	look('_cf_enter')	
	local flags = get_active_flags()
	if flags == 0 then
		RPC('cf_enter',1)					-- 还没到开始打得时候或已结束
		return 
	end
	local lv = CI_GetPlayerData(1,2,sid)
	if lv == nil or lv < 35 then
		RPC('cf_enter',2)					-- 还没到开始打得时候或已结束
		return
	end
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then
		look('_cf_enter active_cf == nil')
		return
	end
	-- 获取攻城战地图GID
	local pub_data = active_cf:get_pub()
	if pub_data == nil then return end
	local gid = pub_data.gid
	if gid == nil then
		look('active_cf create region error')
		return
	end
	-- 获取玩家阵营
	local side = get_fight_side(sid)
	-- 判断其是否属于防守方
	local def_fid = get_defense_fid()
	if def_fid == nil then return end
	-- 取进入点
	local pos = city_fight_conf.enter_pos[side+1]
	look(pos)
	if pos == nil then return end
	local x = enterX or pos[1]
	local y = enterY or pos[2]
	if not active_cf:add_player(sid,1,0,x,y,gid) then
		look('active_cf:add_player erro')
		return
	end
	-- 取当前占领帮会名
	local def_name = CI_GetFactionInfo(def_fid,1)
	-- 取当前雕像血量
	local perHP = 0	
	if pub_data.statue and pub_data.statue > 0 then
		perHP = GetPerHP(pub_data.statue,gid)
	end
	local my_data = active_cf:get_mydata(sid)
	if my_data == nil then return end
	-- 取同盟帮会
	local union_fid = get_faction_union(nil,2,def_fid)
	local union_name = CI_GetFactionInfo(union_fid,1)
	look('perHP:' .. tostring(perHP))
	RPC('cf_enter',0,def_name,perHP,my_data.buff_cd,union_name,pub_data.hold_time,my_data.buff_lv)					
end

-- buff变身
local function _cf_add_buff(sid,cancel)
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then
		look('_cf_add_buff active_cf == nil')
		return
	end
	local my_data = active_cf:get_mydata(sid)
	if my_data == nil then return end
	if cancel == 0 then		-- 取消变身
		CI_DelBuff(217,2,sid)
		CI_DelBuff(219,2,sid)
		RPC('cf_add_buff',0)
	else
		local now = GetServerTime()
		-- 判断cd
		if my_data.buff_cd and now < my_data.buff_cd then
			RPC('cf_add_buff',1,1)
			return
		end
		-- 3分钟CD
		my_data.buff_cd = now + 3*60
		-- if __debug then
			-- my_data.buff_cd = now + 10
		-- end
		if my_data.buff_lv then
			CI_AddBuff(219,0,1,false,2,sid)
		else
			CI_AddBuff(217,0,1,false,2,sid)
		end
		RPC('cf_add_buff',1,0,my_data.buff_cd)
		-- 更新最勤劳玩家
		my_data.col_m = (my_data.col_m or 0) + 1
		update_tops(3,my_data.col_m,sid)
	end	
end

-- 升级弩车
local function _cf_up_buff(sid)
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then
		return
	end
	local my_data = active_cf:get_mydata(sid)
	if my_data == nil then 
		return
	end
	if my_data.buff_lv and my_data.buff_lv == 1 then
		RPC('cf_up_buff',1)			-- 已经升到顶了
		return
	end
	local curbg = GetPlayerPoints(sid,4) or 0
	if curbg < 500 then
		RPC('cf_up_buff',2)			-- 帮贡不足
		return
	end
	AddPlayerPoints( sid, 4, -500, nil, '升级弩车', true)
	my_data.buff_lv = 1
	if CI_HasBuff(217,2,sid) then		
		CI_AddBuff(219,0,buff_lv,false,2,sid)
	end
	RPC('cf_up_buff',0)
end

-- 购买攻城车
local function _cf_buy_car(sid)
	look('_cf_buy_car')
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then
		return
	end
	local fac_id = CI_GetPlayerData(23,2,sid)
	if fac_id == nil or fac_id <= 0 then return end
	local fac_name = CI_GetFactionInfo(fac_id,1)
	local pub_data = active_cf:get_pub()
	if pub_data == nil then return end
	-- 判断雕像是否存在
	if pub_data.statue == nil then
		RPC('cf_buy_car',1)				-- 雕像已经死亡不能招了
		return
	end
	-- 判断是否是帮主
	local title = CI_GetMemberInfo(1)
	if title ~= FACTION_BZ then
		RPC('cf_buy_car',2)				-- 不是帮主不能招
		return
	end
	-- 判断帮会资金
	local money = CI_GetFactionInfo(nil,3)
	if money < 2000 then
		RPC('cf_buy_car',3)				-- 帮会资金不够
		return
	end
	if pub_data.car_gid then
		RPC('cf_buy_car',4)				-- 攻城车已经存在
		return
	end
	local def_fid = get_defense_fid()	
	if def_fid and def_fid == fac_id then
		RPC('cf_buy_car',5)				-- 防守方不能召唤攻城车
		return
	end
	local union_fid = get_faction_union(nil,2,def_fid)
	if union_fid and union_fid == fac_id then
		RPC('cf_buy_car',5)				-- 防守方不能召唤攻城车
		return
	end
	-- 扣帮会资金
	CI_SetFactionInfo(nil,3,money - 2000)
	-- 创建攻城车
	local mapGID = pub_data.gid
	local car = city_fight_conf.car
	car.regionId = mapGID
	local mon_gid = CreateObjectIndirect(car)
	CI_UpdateMonsterData(2,fac_name,4,mon_gid,mapGID)
	pub_data.car_gid = mon_gid
	look('call car success')
	RPC('cf_buy_car',0)					
end

-- 每秒回调(这个函数的判断一定要做好 否则无故增加开销)
local function _cf_second_proc()
	local flags = get_active_flags()
	if flags == 0 then
		return
	end
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then
		return
	end
	local pub_data = active_cf:get_pub()
	if pub_data == nil or pub_data.hold_time == nil then return end
	-- 如果坚持住了就赢了
	local now = GetServerTime()
	if now >= pub_data.hold_time then
		__G.GI_OnActiveEnd(active_name)
	end
end

-- 退出攻城战活动场景
local function _cf_exit(sid)
	look('_ff_exit')
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then	
		look('_cf_exit active_cf == nil')
		return
	end	
	active_cf:back_player(sid)
end

-- 占领玉玺
function _cf_hold_city(cid)
	look('_cf_hold_city')
	local flags = get_active_flags()
	if flags == 0 then
		look('_cf_hold_city flags = 1')
		return
	end
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then
		look('_cf_hold_city active_cf == nil')
		return
	end
	local pub_data = active_cf:get_pub()
	if pub_data == nil then return end
	local npcid = GetNpcidByUID(cid)
	if npclist[npcid] == nil then
		look('_cf_hold_city npclist[npcid] == nil')
		return
	end
	if pub_data.boss then		-- 守城大将还在、不能占领
		RPC('cf_hold',1)
		return
	end	
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then return end
	local pname = CI_GetPlayerData(5)
	local fac_id = get_faction_union(sid,1)
	if fac_id == nil or fac_id <= 0 then
		RPC('cf_hold',2)	-- 没有帮会不能占领
		return
	end
	local def_fid = get_defense_fid()
	if def_fid and def_fid == fac_id then
		RPC('cf_hold',3)	-- 同一帮会不能占领
		return
	end
	local mapGID = pub_data.gid
	-- 设置当前防守方
	set_defense_fid(fac_id)
	-- 设置占领倒计时	
	local now = GetServerTime()
	pub_data.hold_time = now + 20*60
	-- if __debug then
		-- pub_data.hold_time = now + 3*60
	-- end
	-- 重新创建守城大将	
	local fac_name = CI_GetFactionInfo(fac_id,1)
	local boss = city_fight_conf.boss
	boss.regionId = mapGID
	local boss_gid = CreateObjectIndirect(boss)
	CI_UpdateMonsterData(2,fac_name,4,boss_gid,mapGID)
	pub_data.boss = boss_gid
	look('_cf_hold_city success')
	SetRegionMultExp(mapGID,2,fac_id)
	-- 场景公告
	if mapGID then
		-- 取同盟帮会
		local union_fid = get_faction_union(nil,2,fac_id)
		local union_name = CI_GetFactionInfo(union_fid,1)
		RegionRPC(mapGID,'cf_notice',2,fac_name,pub_data.hold_time,union_name,pname)
	end
end

local function _cf_update_car()
	look('_cf_update_car')
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then
		look('_cf_hold_city active_cf == nil')
		return
	end
	local pub_data = active_cf:get_pub()
	if pub_data == nil then return end
	if pub_data.statue and pub_data.car_gid then
		local ret = CI_UpdateMonsterData(1,{aiType = 1026,moveArea = 0},nil,4,pub_data.car_gid,pub_data.gid)
		look('ret:' .. tostring(ret))
		return
	end
end

local _awards = {}

-- 生成奖励面板信息
local function _cf_build_award(dayscore,lv,fac_id,owner_fid)
	if dayscore <= 0 then
		return
	end
	-- 清理奖励表
	for k, v in pairs(_awards) do
		_awards[k] = nil
	end
	local field = (rint(dayscore / 100) + 4) / 10
	if field > 1 then field = 1 end
	-- local exps = rint( (lv ^ 2)*1000 + 1000000 )
	local zg = rint( 1000 * field )
	local exps = 5000000
	-- local zg = 1000
	local xznum = 300 + rint(dayscore / 2)
	-- 失败方减半
	if fac_id == nil or owner_fid == nil or fac_id ~= owner_fid then
		exps = rint(exps*0.5)
		zg = rint(zg*0.5)		
	end
	
	if exps < 0 then exps = 0 end
	if zg < 0 then zg = 0 end
	if xznum < 0 then xznum = 0 end
	if xznum > 999 then
		xznum = 999
	end
	
	_awards[2] = exps
	if xznum > 0 then
		_awards[3] = {{1052,xznum,1},}
	end
	_awards[7] = zg	
	
	return _awards
end

-- 发送结果信息
local function _cf_report_result(sid,bget)
	look('_cf_report_result')
	local active_cf = activitymgr:get(active_name)
	-- 如果活动还没结束,不能领奖
	if active_cf then 
		local active_flags = active_cf:get_state()
		if active_flags ~= 0 then
			look('_cf_report_result active_cf is alive:' .. tostring(sid),1)
			return
		end		
	end
	local lv = CI_GetPlayerData(1,2,sid)
	local owner_fid = getCityOwner()
	local side = get_fight_side(sid)
	local fac_id = get_faction_union(sid,1)	
	local dayscore = sc_getdaydata(sid,active_type) or 0		-- 每日积分	
	local tops = get_tops()										-- 取本场之最
	local award = _cf_build_award(dayscore,lv,fac_id,owner_fid)	-- 构造奖励
	look('award-------------')
	look(award)
	if bget then
		return award
	else
		RPC('cf_result_panel',dayscore,tops,award,owner_fid)
	end
end

-- 给奖励
local function _cf_give_award(sid)
	look('_cf_give_award')
	local dayscore = sc_getdaydata(sid,active_type) or 0
	if dayscore <= 0 then		
		RPC('ff_award',1)
		return
	end
	local award = _cf_report_result(sid,1)
	look(award)
	if award == nil then return end
	local getok = award_check_items(award)
	if not getok then
		return
	end
	-- 只做统计(用于活跃度)
	CheckTimes(sid,TimesTypeTb.Fight_Time,1)
	-- 设置领奖标志(积分清0)
	sc_reset_getawards(sid,active_type)
	local ret = GI_GiveAward(sid,award,"攻城战奖励")
	RPC('cf_award',0)
	-- 丢出活动场景
	_cf_exit(sid)
end

-- 领取每日礼包
local function _cf_eday_gift(sid)
	local fac_id = CI_GetPlayerData(23)
	if fac_id == nil or fac_id <= 0 then return end
	local cfData = GetCityFightData()
	if cfData == nil or cfData.city_fac == nil then return end
	if fac_id ~= cfData.city_fac then	
		RPC('cf_give_gift',1)			-- 不是城主帮会的
		return
	end	
	local award = city_fight_conf.gifts
	local getok = award_check_items(award)
	if not getok then
		return
	end
	if not CheckTimes(sid,TimesTypeTb.city_gift,1,-1) then
		RPC('cf_give_gift',2)			-- 已经领取
		return
	end
	local ret = GI_GiveAward(sid,award,"城主帮会每日奖励")
	RPC('cf_give_gift',0)				-- 领取成功
end

-- 取面板信息(调用存储过程)
local function _get_city_panel(sid)
	local owner_fid = getCityOwner()
	if owner_fid == nil then return end
	local bzsid,fbzsid = CI_GetFactionLeaderInfo(owner_fid,1)
	local bzfrsid = __G.GetCoupleSID(bzsid) or 0	
	db_get_city_info(owner_fid,bzsid,fbzsid,bzfrsid)
end

-- 雕像怪死亡 刷boss和玉玺
call_monster_dead[4401] = function (mapGID)
	look('call_monster_dead 4401')
	local flags = get_active_flags()
	if flags == 0 then
		return
	end
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then
		return
	end
	local pub_data = active_cf:get_pub()
	if pub_data == nil then return end
	
	-- 雕像消失
	pub_data.statue = nil
	
	local def_fid = get_defense_fid()
	if def_fid == nil then return end
	-- 刷守城大将
	local fac_name = CI_GetFactionInfo(def_fid,1)
	local boss = city_fight_conf.boss
	boss.regionId = mapGID
	local boss_gid = CreateObjectIndirect(boss)
	CI_UpdateMonsterData(2,fac_name,4,boss_gid,mapGID)
	pub_data.boss = boss_gid
	-- 刷玉玺
	local npc_id = city_fight_conf.yuxi
	local npc_conf = npclist[npc_id]
	npc_conf.NpcCreate.regionId = mapGID
	CreateObjectIndirectEx(1,npc_id,npc_conf.NpcCreate)
	-- -- 设置npc状态已采集
	local cid = npc_id + 100000
	local ret = CI_UpdateNpcData(2,true,6,cid)	
	AreaRPC(6,cid,mapGID,'update_npc_collect',cid,true)
	-- 设置占领倒计时	
	pub_data.hold_time = GetServerTime() + 20*60
	if pub_data.gid then
		RegionRPC(pub_data.gid,'cf_notice',1,pub_data.hold_time)
	end
	-- 如果攻城车还在(删除)
	if pub_data.car_gid then		
		CI_DelMonster(mapGID,pub_data.car_gid)
	end
end

-- 守城将军死亡
call_monster_dead[4402] = function (mapGID)
	local flags = get_active_flags()
	if flags == 0 then
		return
	end
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then
		return
	end	
	local pub_data = active_cf:get_pub()
	if pub_data == nil then return end
	local mapGID = pub_data.gid
	
	-- 设置守城大将状态
	pub_data.boss = nil
	-- 更新玉玺状态
	local npc_id = city_fight_conf.yuxi
	local cid = npc_id + 100000
	local ret = CI_UpdateNpcData(2,false,6,cid,mapGID)			-- 设置npc状态可采集
	AreaRPC(6,cid,mapGID,'update_npc_collect',cid,false)
	-- 场景公告
	RegionRPC(mapGID,'cf_notice',3)
	-- 加分数
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then
		return
	end
	add_score(sid,100)
end

-- 攻城车死亡
call_monster_dead[4403] = function (mapGID)
	local flags = get_active_flags()
	if flags == 0 then
		return
	end	
	-- 重新创建攻城车
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then
		look('create_statue active_cf == nil')
		return
	end
	look('create_statue')
	local pub_data = active_cf:get_pub()
	if pub_data == nil then return end
	if pub_data.statue == nil then		-- 雕像死亡不召唤了
		return
	end
	local car = city_fight_conf.car
	car.regionId = mapGID
	local mon_gid = CreateObjectIndirect(car)
	pub_data.car_gid = mon_gid
	look('call car success')
	
	-- 加分数
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then
		return
	end
	add_score(sid,50)
end

-- 箭塔死亡 +分数
call_monster_dead[4404] = function (mapGID)
	-- 加分数
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then
		return
	end
	add_score(sid,200)
end

-- 点击占领玉玺
call_npc_click[50020] = function ()
	look('call_npc_click')
	local flags = get_active_flags()
	if flags == 0 then
		return
	end
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then
		return
	end
	local pub_data = active_cf:get_pub()
	if pub_data == nil then return end
	local cid = GetObjectUniqueId()
	local npcid = GetNpcidByUID(cid)
	if npclist[npcid] == nil then
		look('call_npc_click 50020 npcid erro')
		return
	end	
	if pub_data.boss then
		RPC('cf_hold',1)
		return
	end	
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then return end
	local fac_id = get_faction_union(sid,1)
	if fac_id == nil or fac_id <= 0 then
		RPC('cf_hold',2)	-- 没有帮会不能占领
		return
	end
	local pb_type = npclist[npcid].PBType or 1
	-- 根据情况设置占领读条时间
	local sec = 5
	local cf_list = get_cf_list()
	if type(cf_list) == type({}) then
		for k, v in ipairs(cf_list) do
			if v[4] == fac_id then
				sec = 2
				break
			end
		end
	end
	local owner_fid = getCityOwner()
	if owner_fid and owner_fid == fac_id then
		sec = 4
	end
	CI_SetReadyEvent( cid,pb_type,sec,1,"GI_cf_hold" )
end

-- 雕像被杀按伤害给奖励
monster_kill_award[13] = function (sid,dmgval,dmgper)
	look('monster_kill_award13:' .. tostring(sid) .. '____' .. tostring(dmgval))
	local flags = get_active_flags()
	if flags == 0 then
		return
	end
	local active_cf = activitymgr:get(active_name)
	if active_cf == nil then
		return
	end
	if dmgval and dmgval > 0 then
		add_score(sid,dmgval)
	end
end

------------------------------------------------------------------
--interface:

cf_start = _cf_start
cf_enter = _cf_enter
cf_exit = _cf_exit
cf_hold_city = _cf_hold_city
cf_add_buff = _cf_add_buff
cf_report_result = _cf_report_result
cf_give_award = _cf_give_award
cf_eday_gift = _cf_eday_gift
cf_buy_car = _cf_buy_car
get_city_panel = _get_city_panel
cf_second_proc = _cf_second_proc
cf_update_car = _cf_update_car
cf_up_buff = _cf_up_buff