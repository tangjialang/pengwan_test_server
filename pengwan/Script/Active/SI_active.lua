--[[
file: SI_active.lua
desc: SI_xxx
autor: csj
update: 2013-7-11 
2014-08-22:add by sxj, add bsmz, bsmz_end, GI_bsmz_end()
]]--

local look = look
local uv_DRList = DRList
local CI_UpdateNpcData = CI_UpdateNpcData
local GetServerTime = GetServerTime
local TipCenter = TipCenter
local TipABrodCast = TipABrodCast
local AreaRPC = AreaRPC
local RegionRPC = RegionRPC
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local escort_cannotin	 = msgh_s2c_def[18][5]	

local active_mgr_m = require('Script.active.active_mgr')
local activitymgr = active_mgr_m.activitymgr


local _random=math.random
local time_cnt = require('Script.common.time_cnt')
local GetDiffDayFromTime = time_cnt.GetDiffDayFromTime
local wenquan 		= require('Script.active.wenquan')
local wq_conf 	= wenquan.wq_conf
-- local wq_jump 	= wenquan.wq_jump
local wq_collectduck 	= wenquan.wq_collectduck
local wq_refreshduck=wenquan.wq_refreshduck
local sjzc_module = require('Script.active.sjzc')
local sjzc_start = sjzc_module.sjzc_start
local sjzc_buff_refresh = sjzc_module.sjzc_buff_refresh
local sjzc_camp_sync = sjzc_module.sjzc_camp_sync
local sjzc_on_collect = sjzc_module.sjzc_on_collect
local sjzc_submit_res = sjzc_module.sjzc_submit_res
local sjzc_box_open = sjzc_module.sjzc_box_open
local sjzc_box_refresh = sjzc_module.sjzc_box_refresh
local qsls 		= require('Script.active.qsls')
local qs_refresh 	= qsls.qs_refresh
local qs_collect 	= qsls.qs_collect
local lt_module = require('Script.active.lt')
local lt_start = lt_module.lt_start
local lt_matching = lt_module.lt_matching
local lt_enter_ex = lt_module.lt_enter_ex
local lt_sync_pos = lt_module.lt_sync_pos
local catch_fish 		= require('Script.active.catch_fish')
local catchfish_refreshmonster 		= catch_fish.catchfish_refreshmonster
local ff_module = require('Script.active.faction_fight')
local ff_start = ff_module.ff_start
local ff_sync_data = ff_module.ff_sync_data
local ff_owner_relive = ff_module.ff_owner_relive
local ff_rescue = ff_module.ff_rescue
local ff_submit_res = ff_module.ff_submit_res
local ff_owner_flags = ff_module.ff_owner_flags
local ff_set_block = ff_module.ff_set_block
local ff_flags_score = ff_module.ff_flags_score
local ff_enter = ff_module.ff_enter
local hunting = require('Script.active.hunting')
local hunt_refreshmonster = hunting.hunt_refreshmonster
local escort = require('Script.active.escort')
local getescortdata=escort.getescortdata
local endescortnpc=escort.endescortnpc
local endescort=escort.endescort
local sclist_m = require('Script.scorelist.sclist_func')
local get_scorelist_data = sclist_m.get_scorelist_data
local faction_monster = require('Script.active.faction_monster')
local ss_creatboss=faction_monster.ss_creatboss
local ss_endfail=faction_monster.ss_endfail
local time_proc_m = require('Script.active.time_proc')
local g_active_static_table = time_proc_m.g_active_static_table
--local g_active_dynamic_table = time_proc_m.g_active_dynamic_table
local trigger_active_static = time_proc_m.trigger_active_static
local trigger_active_dynamic = time_proc_m.trigger_active_dynamic
local active_actives = time_proc_m.active_actives
local boss_active_m = require('Script.active.boss_active')
local Monster_Create = boss_active_m.Monster_Create
local af_module = require('Script.active.anonymity_fight')
local af_secfight = af_module.af_secfight
local drx_module = require('Script.active.kf_drx')
local call_drx_award = drx_module.call_drx_award
local drx2_module = require('Script.active.kf_drx_2')
local call_drx2_award = drx2_module.call_drx2_award
local yushi_module = require('Script.active.yushi')
local yushi_creatmonster=yushi_module.yushi_creatmonster
local Chick_bengin=yushi_module.Chick_bengin
local cf_module = require('Script.active.city_fight')
local cf_hold_city = cf_module.cf_hold_city
local cf_start = cf_module.cf_start
local cf_second_proc = cf_module.cf_second_proc
local cf_enter = cf_module.cf_enter
local cf_update_car = cf_module.cf_update_car
local tjbx 		= require('Script.active.tjbx')
local chick_tjbx 	= tjbx.chick_tjbx
local tjbx_refresh=tjbx.tjbx_refresh
local jj_module = require('Script.active.jijin')
jj_cz_callback=jj_module.jj_cz_callback
local jysh    =  require('Script.shenshu.jysh_fun')
local jysh_inform = jysh.jysh_inform
local jysh_user_steal = jysh.jysh_user_steal
--[[sxj,2014-08-21 add start]]-- 
local bsmz = require('Script.bsmz.bsmz_fun')
local bsmz_end = bsmz.bsmz_end
--[[sxj,2014-08-21 add end]]-- 
local chunjie_module = require('Script.Active.chunjie_active')
local GetRechargeInfo = chunjie_module.GetRechargeInfo

function CALLBACK_GetPayRecords(sid, flag,records)
	GetRechargeInfo(sid, flag, records)
end

function CheckTime()
	look(time_proc_m.g_active_dynamic_table.tick_passed,1)
	look(g_active_static_table.tick_passed,1)
end

function PassTime(cnt)
	
	Log('SetEvent.txt',cnt)
	
	if cnt > 2*60 then
		Log('SetEvent.txt','cnt error')
		return
	end
	
	CheckTime()
	time_proc_m.g_active_dynamic_table.tick_passed = time_proc_m.g_active_dynamic_table.tick_passed + cnt 
	g_active_static_table.tick_passed = g_active_static_table.tick_passed + cnt
	CheckTime()
end

--范围加经验

--   CI_AreaAddExp(id,范围，选择类型，选择参数，exp，info)
-- 选择类型 = 1 同帮会
-- 选择类型 = 2 同队伍
function SI_AreaAddExp( sid,len,itype,arg,_exp,info)--定时加经验时有返回值会一直加,故封装之
	--CI_AreaAddExp( sid,len,itype,arg,_exp,info)
	CI_AreaAddExp( 0,len,itype,arg,_exp,info,2,sid)
end

-- 活动进入(用于召唤令)
function GI_Active_Enter(itype,sid,regionID,enterX,enterY,mapGID)
	-- look(itype)
	-- look(sid)
	-- look(regionID)
	-- look(enterX)
	-- look(enterY)
	-- look(mapGID)
	if itype == nil or sid == nil then return end
	local name
	if itype == 1 then
		name = 'ff'
	elseif itype == 2 then
		name = 'cf'
	end
	if name == nil then return end
	local Activity = activitymgr:get(name)
	if Activity and Activity:get_state() ~= 0 then
		if Activity:is_active(sid) then		-- 玩家在活动中
			look('is_active true')
			if not PI_MovePlayer(regionID,enterX,enterY,mapGID,2,sid) then
				return
			end
		else
			look('is_active false')
			if itype == 1 then
				ff_enter(sid,enterX,enterY)
			elseif itype == 2 then
				cf_enter(sid,enterX,enterY)
			end			
		end
		return true
	end
end

-- 通用活动开始函数
function GI_Active_Start(args)
	local name = args[1]
	if type(name) ~= type('') then
		return
	end
	local now = GetServerTime()
	local openTime = GetServerOpenTime()
	local days = (GetDiffDayFromTime(openTime) or 0) + 1
	if days == nil then return end
	look('GI_Active_Start openDay:' .. tostring(days))
	local mergeDay
	local mergeTime = GetServerMergeTime()
	if mergeTime > 0 then
		mergeDay = (GetDiffDayFromTime(mergeTime) or 0) + 1
		look('GI_Active_Start mergeDay:' .. tostring(mergeDay))
	end
	-- 三界战场(开服、合服前5天不开三界战场)
	if name == 'sjzc' then
		if mergeDay then
			if mergeDay <= 5 then
				return
			end
		else
			if days <= 5 then
				return
			end
		end		
		
		sjzc_start()
	elseif name == 'span_sjzc' then
		if args[2] == nil then
			return
		end
		if mergeDay then
			if mergeDay <= 5 then
				return
			end
		else
			if days <= 5 then
				return
			end
		end	
		if args[2] == 0 then			
			spsjzc_end_proc()
		elseif args[2] == 1 then
			spsjzc_start_proc()
		end
		
	-- 竞技场
	elseif name == 'jjc' then
		-- if days <= 5 then
			-- return
		-- end
		lt_start()
	-- 帮会战
	elseif name == 'ff' then
		if args[2] == nil then
			return
		end
		if args[2] == 0 then	-- 正常为开服、合服5天后
			if mergeDay then
				if mergeDay <= 5 then
					return
				end
			else
				if days <= 5 then
					return
				end
			end
						
			if args[3] == 1 then
				TipABrodCast(args[4])
			elseif args[3] == 2 then
				ff_start(2)
			elseif args[3] == 3 then
				ff_start(3)
			end
		elseif args[2] == 1 then	-- 开服前两天开帮会战
			if mergeDay then
				if mergeDay > 2 then
					return
				end
			else
				if days > 2 then
					return
				end
			end
			
			if args[3] == 1 then
				TipABrodCast(args[4])
			elseif args[3] == 2 then
				ff_start(2)
			elseif args[3] == 3 then
				ff_start(3)
			end
		end
	-- 攻城战
	elseif name == 'cf' then
		if args[2] == nil then
			return
		end
		if args[2] == 0 then		-- 正常为开服5天后
			if mergeDay then
				if mergeDay <= 5 then
					return
				end
			else
				if days <= 5 then
					return
				end
			end			
			cf_start(1)
		elseif args[2] == 1 then	-- 开服3、4、5天连续开攻城战
			if mergeDay then
				if mergeDay <= 2 or mergeDay > 5 then
					return
				end
			else
				if days <= 2 or days > 5 then
					return
				end
			end			
			cf_start(1)
		end
	elseif name == 'cl_union' then
		if args[2] == nil then
			return
		end
		if args[2] == 0 then		-- 正常为开服5天后
			if mergeDay then
				if mergeDay <= 5 then
					return
				end
			else
				if days <= 5 then
					return
				end
			end		
			ClearFactionUnion()
		elseif args[2] == 1 then	-- 开服前5天连续清理
			if mergeDay then
				if mergeDay > 5 then
					return
				end
			else
				if days > 5 then
					return
				end
			end		
			ClearFactionUnion()
		end
		
	end
end

-- 判断活动是否结束
function GI_Is_Active_Live(name)
	if type(name) ~= type('') then
		return false
	end
	local Activity = activitymgr:get(name)
	if Activity == nil then
		return false
	end
	
	return true
end


-- 活动结束回调
function GI_OnActiveEnd(name)

	local Activity = activitymgr:get(name)
	if Activity then
		-- 屏蔽GM命令结束问题
		local active_flag = Activity:get_state()
		if active_flag == 0 then
			return
		end
		-- 设置活动结束标志
		Activity:set_state(0)
		
		-- 自定义结束处理
		if type(Activity.on_active_end) == 'function' then
			Activity:on_active_end()
		end
		
		-- 设置清除活动数据计时器
		local actconf = uv_DRList[name]
		if actconf and actconf.clrTimer then
			SetEvent(actconf.clrTimer, nil, 'GI_ClrActiveData', name)
		end
		
		-- 通知玩家活动结束
		BroadcastRPC('Active_End',name)	
	end
end

-- 活动数据清理
function GI_ClrActiveData(name)
	local Activity = activitymgr:get(name)
	if Activity then
		activitymgr:clearAll(name)		-- 清除活动相关数据
	end
end

-- 场景倒计时结束回调函数
-- 支持一个自定义回传参数
function GI_OnDRTimeOut(name, mapGID, args, rid, x, y)

	activitymgr:on_DRtimeout(name, mapGID, args)
	CI_DeleteDRegion(mapGID,1,rid,x,y)
end

-- DR region delete callback.
function DR_OnRegionDelete(RegionGID, RegionID, name)
	--look('DR_OnRegionDelete 1:' .. tostring(name))
	-- 先调用自定义处理函数
	activitymgr:on_regiondelete(name,RegionID,RegionGID)
	
	-- 清除活动场景数据
	if name then
		activitymgr:clear_regiondata(name,RegionGID)
	end
	--look('DR_OnRegionDelete 2:' .. tostring(name))
end

-- 动态场景怪物全部死亡回调函数
function DR_OnMonsterAllDead( regionGID, name )

	if regionGID == nil or name == nil then return end
	activitymgr:on_monDeadAll(regionGID, name)
end

-- 重置非时间类活动(慎用！！！)
function ActivityReset()
	active_mgr_m.active_marank = activitymgr:create('MaRank',1)
	active_mgr_m.active_marobb = activitymgr:create('MaRobb',1)
	active_mgr_m.active_xml = activitymgr:create('xml',1)
	active_mgr_m.active_manor = activitymgr:create('manor',1)
	active_mgr_m.active_yushi = activitymgr:create('yushi',1)
end


--事件回调
function SI_UpdateActiveTimer(timer_tick)
	if timer_tick == nil or timer_tick ~= 1 then
		Log('SI_UpdateActiveTimer.txt',timer_tick)
	end
	
	local ret,info = pcall( active_actives,g_active_static_table,trigger_active_static,timer_tick )
	if not ret then
		if type(info) == type('') then
			Log('Lua_Debug.txt',info)
		end
	end
	ret,info = pcall( active_actives,time_proc_m.g_active_dynamic_table, trigger_active_dynamic, timer_tick )
	if not ret then
		if type(info) == type('') then
			Log('Lua_Debug.txt',info)
		end
	end
	-- 帮会攻城战每秒判断
	ret,info = pcall( cf_second_proc )
	if not ret then
		if type(info) == type('') then
			Log('Lua_Debug.txt',info)
		end
	end
	if timer_tick == nil or timer_tick ~= 1 then
		Log('SI_UpdateActiveTimer111.txt',timer_tick)
	end
	__eventtime = GetServerTime()
	return timer_tick 
end
---移除除buff回调
function SI_OnCostumeBuffEnd(buffid)
	look('移除除buff回调buffid=='..buffid)
	if type(buffid)==type(0) then
		if buffid>=133 and buffid<=137 then --运镖结束,失败
			endescort(false) 
		end
		
	end
end

-- 召唤怪物统一处理接口
function CallBuffMonster(rid,x,y,mapGID,num,sid)
	local monster_conf = BuffMonsterConf[num]
	if monster_conf == nil then return end
	monster_conf.x = x
	monster_conf.y = y	
	if mapGID and mapGID > 0 then
		monster_conf.regionId = mapGID
	else
		monster_conf.regionId = rid
	end
	local mon_gid = CreateObjectIndirect(monster_conf,sid)
end

-- 玩家技能召唤怪物
function PI_SCallMonster(sid,num,x,y,lv)
	-- look('PI_SCallMonster',1)
	if sid == nil or num == nil then return end
	if BuffMonsterConf[num] == nil then
		return
	end
	local monster_conf = BuffMonsterConf[num]
	local rx,ry,rid,mapGID = CI_GetCurPos(2,sid)
	monster_conf.x = rx
	monster_conf.y = ry
	if mapGID and mapGID > 0 then
		monster_conf.regionId = mapGID
	else
		monster_conf.regionId = rid
	end
	if type(x) == type(0) and type(y) == type(0) then
		if ((rx-x)^2+(ry-y)^2)^0.5>10 then return end
		monster_conf.x = x
		monster_conf.y = y
	end
	
	
	-- 根据不同的怪物做处理			
	if num == 2 then
		monster_conf.skillID = {228}
		lv = lv or 1
		monster_conf.skillLevel = {lv}
	elseif num == 3 then
		lv = lv or 1
		monster_conf.IdleTime = (3 + lv) * 5 
	elseif num == 4 then
		lv = lv or 1
		monster_conf.IdleTime = (3 + lv) * 5 
	end
	-- 设置怪物阵营
	local camp = CI_GetPlayerData(39,2,sid)
	monster_conf.camp = camp or 0
	local mon_gid = CreateObjectIndirect(monster_conf)
	if mon_gid and mon_gid > 0 then
		CI_UpdateMonsterData(4,sid,4,mon_gid)
	end
end

function SI_BuffTrigger(buffid,bufflv,isend)
	-- look('SI_BuffTrigger:' .. buffid .. '__' .. isend,1)
	if buffid == 105 then
		if isend == 1 then return end	-- buff结束暂时不处理
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <= 0 then return end
		local monster_conf = BuffMonsterConf[1]
		local _,_,rid,mapGID = CI_GetCurPos()
		local x,y = CI_GetPlayerData(9)
		monster_conf.x = x
		monster_conf.y = y
		if mapGID and mapGID > 0 then
			monster_conf.regionId = mapGID
		else
			monster_conf.regionId = rid
		end
		-- look(monster_conf)
		local mon_gid = CreateObjectIndirect(monster_conf,sid)
		if mon_gid and mon_gid > 0 then
			CI_UpdateMonsterData(4,sid,4,mon_gid)
		end
	-- elseif buffid == 366 then
		-- if isend ~= 1 then return end	-- buff开始暂时不处理
		-- local sid = CI_GetPlayerData(17)
		-- if sid == nil or sid <= 0 then return end
		-- CI_AddBuff(368,0,1,false,2,sid)
	end
end
-----------------------------------三界战场------------------------------------

-- 三界战场刷新buffer
function GI_sjzc_buff_refresh()	
	sjzc_buff_refresh()
end

-- 三界战场刷新宝箱
function GI_sjzc_box_refresh()
	sjzc_box_refresh()
end

-- 三界战场每30秒更新阵营积分给前台
function GI_sjzc_camp_sync()
	local ret = sjzc_camp_sync()
	if ret == true then
		return 30
	end
end

-- 三界战场采集法宝碎片
function GI_sjzc_on_collect(cid)
	sjzc_on_collect(cid)
	return 1
end

-- 三界战场提交NPC
function GI_sjzc_submit_res()
	local sid = CI_GetPlayerData(17)
	if sid and sid > 0 then
		sjzc_submit_res(sid)
	end
end

-- 更新采集NPC状态
function GI_sjzc_update_collect(cid,mapGID)

	local ret = CI_UpdateNpcData(2,false,6,cid,mapGID)
	AreaRPC(6,cid,mapGID,'update_npc_collect',cid,false)
end

-- 开启宝箱
-- function GI_sjzc_box_open(cid)
	-- sjzc_box_open(cid)
	-- return 1
-- end


-----------------------------------温泉------------------------------------
--玩家上跳台
function wq_Gotojump(playerid,gid,selfname,selfgid)

		local Active_wenquan=activitymgr:get('wenquan')
	if Active_wenquan==nil then

		return
	end
	if not  Active_wenquan:is_active(playerid) then
		return
	end
	PI_MovePlayer(0, 10, 8, gid, 2,playerid)

	RegionRPC(gid,"WQ_Jump_go",selfname) --准备跳水
end

--刷新鸭子
function GI_wq_refreshduck(fbid)

	wq_refreshduck(fbid)
end

--采集鸭子
function GI_wq_collectduck(controlId)
	return wq_collectduck(controlId)
end
-----------------------------------曲水流觞------------------------------------
--刷新荷叶酒
function GI_qs_refresh(fbid)
	return qs_refresh(fbid)
end

--发送排行
function send_sclist(mapGID,scoreid)
	local sclist = get_scorelist_data(1,scoreid)

	RegionRPC(mapGID,'sclist',sclist)
end
	-- 每30秒更新曲水温泉积分
function GI_qs_sc_sync(active_name,scoreid)
	local name = activitymgr:get(active_name)
	if name == nil then			
		return false
	end	
	-- local pubdata=name:get_pub()
	-- local sendmark=pubdata.sendmark
	-- if not sendmark then 

	-- 	return 30
	-- end
	name:traverse_region(send_sclist,scoreid)
	-- pubdata.sendmark=false
	return 30
end

function GI_wq_sc_sync(active_name,scoreid)
	local name = activitymgr:get(active_name)
	if name == nil then			
		return false
	end	
	-- local pubdata=name:get_pub()
	-- local sendmark=pubdata.sendmark
	-- if not sendmark then 

	-- 	return 30
	-- end
	name:traverse_region(send_sclist,scoreid)
	-- pubdata.sendmark=false
	return 30
end
--npc隐藏后出现
function qs_relook( controlId, gid)
	local res=CI_UpdateNpcData(2,false,6,controlId,gid)	
	if not res or res<1 then return end
	AreaRPC(6,controlId,gid,'update_npc_collect',controlId,false)
end
----------------------------------------竞技场-------------------------------

-- 竞技场每10秒匹配一次
function GI_lt_matching()
	lt_matching()
end

-- 强制进入
function GI_lt_enter_ex(sidA,sidB,gid)
	lt_enter_ex(sidA,sidB,gid)
end

-- 同步玩家坐标
function GI_lt_sync_pos(sidA,sidB,gid)
	return lt_sync_pos(sidA,sidB,gid)
end

----------------------------------------抓鱼-------------------------------
--刷鱼
function GI_catchfish_refreshmonster(posIndex,gid)
	catchfish_refreshmonster(posIndex,gid)
end

----------------------------------------抓马-------------------------------
--刷鱼
function GI_hunt_refreshmonster(posIndex,gid)
	hunt_refreshmonster(posIndex,gid)
end
----------------------------------------神兽-------------------------------
--刷
function GI_ss_creatboss(mapgid,lv,itype,fid)
	ss_creatboss(mapgid,lv,itype,fid)
end
--副本结束时未过关提示失败
function GI_ss_endfail( fid )
	ss_endfail(fid)
end
----------------------------------------护送-------------------------------
---在运镖过程中不允许传动态副本
function escort_not_trans(playerSID)
	local sid
	if playerSID==nil then
		
		sid = CI_GetPlayerData(17)
	else
		 sid=playerSID
	end
	local sData = getescortdata(sid)
	if sData==nil then return  end
	if(sData[1]==1)then
		--TipCenter( GetStringMsg(432))
		SendLuaMsg( sid, { ids=escort_cannotin}, 10 )
		return true
	end
end
function GI_endescortnpc(sid, npcid)
	endescortnpc(sid, npcid)
	-- body
end
----------------------------------------boss-----------------------------
function GI_Monster_Create(itype)
	Monster_Create(itype)
end
----------------------------------------帮会战-----------------------------

-- 同步信息(积分、资源、旗子)
function GI_ff_sync_data()
	local ret = ff_sync_data()
	if ret == true then
		return 10
	end
end

-- 每2秒帮会旗帜给积分
function GI_ff_flags_score()
	local ret = ff_flags_score()
	if ret then
		return 2
	end
end

-- 占领水晶复活点
function GI_ff_owner_relive(cid)
	ff_owner_relive(cid)
	return 1
end

-- 占领旗帜
function GI_ff_Owner_flags()
	ff_owner_flags()
	return 1
end

-- 解救
function GI_ff_rescue(cid)
	ff_rescue(cid)
	return 1
end

-- 帮会战提交NPC
function GI_ff_submit_res()
	local sid = CI_GetPlayerData(17)
	if sid and sid > 0 then
		ff_submit_res(sid)
	end
end

-- 30秒后动态阻挡失效
function GI_ff_set_block(state)
	ff_set_block(state)
end

-------------------------------------攻城战--------------------------------------
function GI_cf_hold(cid)
	cf_hold_city(cid)
	return 1
end

function GI_Set_Car_AI()
	cf_update_car(cid)
	return
end

function CALLBACK_GetCityInfo(fac_id,bzsid,fbzsid,bzfrsid,rs)
	look('CALLBACK_GetCityInfo')
	look(fac_id)
	look(bzsid)
	look(fbzsid)
	look(bzfrsid)
	look(rs)
	local cfData = GetCityFightData()
	if cfData == nil then return end
	local fac_name = CI_GetFactionInfo(fac_id,1)
	if type(fac_name) ~= type('') then
		return
	end
	look(fac_name)
	RPC('get_city_info',fac_name,cfData.city_time,bzsid,fbzsid,bzfrsid,rs)
end

-------------------------------------匿名战场------------------------------------
--开始决赛
function GI_af_secfight()
	af_secfight()
end

-------------------------------------运营活动------------------------------------



-------------------------------------达人秀--------------------------------------

function CALLBACK_DrxGiveAwards(sid,mainid,subid,rs,aid)
	look('CALLBACK_DrxGiveAwards')
	call_drx_award(sid,mainid,subid,rs,aid)
end

function CALLBACK_Drx2GiveAwards(sid,mainid,subid,rs,aid)
	look('CALLBACK_Drx2GiveAwards')
	call_drx2_award(sid,mainid,subid,rs,aid)
end

function CALLBACK_ShowGirl(sid,qq,url)
	look('CALLBACK_ShowGirl')
	look(qq)
	look(url)
	RPCEx(sid,'get_show_girl',1,qq,url)
end

-------------------------------------玉石副本------------------------------------
function GI_yushi_creatmonster(sid,num,mapgid,time_n,texiao  )

	yushi_creatmonster(sid,num,mapgid,time_n,texiao)
end
--帮玩家点击
function GI_Chick_bengin(sid,t_n)

	Chick_bengin(sid,t_n)
end
-------------------------------------天降宝箱------------------------------------
function GI_chick_tjbx( cid )
	return chick_tjbx( cid )
end

function GI_tjbx_refresh( npcid ,rgid )
	tjbx_refresh( npcid ,rgid)
end
-----------------------------------------经验神树--------------------------------
function GI_jysh_inform(user_npc)
    jysh_inform(user_npc)  
end
---------------------------------------经验神树果实偷取------------------------
function GI_jysh_steal() 
    jysh_user_steal()
	return 1
end

--[[sxj,2014-08-21 add start]]--
---------------------------------------宝石迷阵--------------------------------
function GI_bsmz_end(fid)
	bsmz_end(fid)
end
--[[sxj,2014-08-21 add end]]--