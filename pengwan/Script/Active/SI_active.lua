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

--��Χ�Ӿ���

--   CI_AreaAddExp(id,��Χ��ѡ�����ͣ�ѡ�������exp��info)
-- ѡ������ = 1 ͬ���
-- ѡ������ = 2 ͬ����
function SI_AreaAddExp( sid,len,itype,arg,_exp,info)--��ʱ�Ӿ���ʱ�з���ֵ��һֱ��,�ʷ�װ֮
	--CI_AreaAddExp( sid,len,itype,arg,_exp,info)
	CI_AreaAddExp( 0,len,itype,arg,_exp,info,2,sid)
end

-- �����(�����ٻ���)
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
		if Activity:is_active(sid) then		-- ����ڻ��
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

-- ͨ�û��ʼ����
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
	-- ����ս��(�������Ϸ�ǰ5�첻������ս��)
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
		
	-- ������
	elseif name == 'jjc' then
		-- if days <= 5 then
			-- return
		-- end
		lt_start()
	-- ���ս
	elseif name == 'ff' then
		if args[2] == nil then
			return
		end
		if args[2] == 0 then	-- ����Ϊ�������Ϸ�5���
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
		elseif args[2] == 1 then	-- ����ǰ���쿪���ս
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
	-- ����ս
	elseif name == 'cf' then
		if args[2] == nil then
			return
		end
		if args[2] == 0 then		-- ����Ϊ����5���
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
		elseif args[2] == 1 then	-- ����3��4��5������������ս
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
		if args[2] == 0 then		-- ����Ϊ����5���
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
		elseif args[2] == 1 then	-- ����ǰ5����������
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

-- �жϻ�Ƿ����
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


-- ������ص�
function GI_OnActiveEnd(name)

	local Activity = activitymgr:get(name)
	if Activity then
		-- ����GM�����������
		local active_flag = Activity:get_state()
		if active_flag == 0 then
			return
		end
		-- ���û������־
		Activity:set_state(0)
		
		-- �Զ����������
		if type(Activity.on_active_end) == 'function' then
			Activity:on_active_end()
		end
		
		-- �����������ݼ�ʱ��
		local actconf = uv_DRList[name]
		if actconf and actconf.clrTimer then
			SetEvent(actconf.clrTimer, nil, 'GI_ClrActiveData', name)
		end
		
		-- ֪ͨ��һ����
		BroadcastRPC('Active_End',name)	
	end
end

-- ���������
function GI_ClrActiveData(name)
	local Activity = activitymgr:get(name)
	if Activity then
		activitymgr:clearAll(name)		-- �����������
	end
end

-- ��������ʱ�����ص�����
-- ֧��һ���Զ���ش�����
function GI_OnDRTimeOut(name, mapGID, args, rid, x, y)

	activitymgr:on_DRtimeout(name, mapGID, args)
	CI_DeleteDRegion(mapGID,1,rid,x,y)
end

-- DR region delete callback.
function DR_OnRegionDelete(RegionGID, RegionID, name)
	--look('DR_OnRegionDelete 1:' .. tostring(name))
	-- �ȵ����Զ��崦����
	activitymgr:on_regiondelete(name,RegionID,RegionGID)
	
	-- ������������
	if name then
		activitymgr:clear_regiondata(name,RegionGID)
	end
	--look('DR_OnRegionDelete 2:' .. tostring(name))
end

-- ��̬��������ȫ�������ص�����
function DR_OnMonsterAllDead( regionGID, name )

	if regionGID == nil or name == nil then return end
	activitymgr:on_monDeadAll(regionGID, name)
end

-- ���÷�ʱ����(���ã�����)
function ActivityReset()
	active_mgr_m.active_marank = activitymgr:create('MaRank',1)
	active_mgr_m.active_marobb = activitymgr:create('MaRobb',1)
	active_mgr_m.active_xml = activitymgr:create('xml',1)
	active_mgr_m.active_manor = activitymgr:create('manor',1)
	active_mgr_m.active_yushi = activitymgr:create('yushi',1)
end


--�¼��ص�
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
	-- ��ṥ��սÿ���ж�
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
---�Ƴ���buff�ص�
function SI_OnCostumeBuffEnd(buffid)
	look('�Ƴ���buff�ص�buffid=='..buffid)
	if type(buffid)==type(0) then
		if buffid>=133 and buffid<=137 then --���ڽ���,ʧ��
			endescort(false) 
		end
		
	end
end

-- �ٻ�����ͳһ����ӿ�
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

-- ��Ҽ����ٻ�����
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
	
	
	-- ���ݲ�ͬ�Ĺ���������			
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
	-- ���ù�����Ӫ
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
		if isend == 1 then return end	-- buff������ʱ������
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
		-- if isend ~= 1 then return end	-- buff��ʼ��ʱ������
		-- local sid = CI_GetPlayerData(17)
		-- if sid == nil or sid <= 0 then return end
		-- CI_AddBuff(368,0,1,false,2,sid)
	end
end
-----------------------------------����ս��------------------------------------

-- ����ս��ˢ��buffer
function GI_sjzc_buff_refresh()	
	sjzc_buff_refresh()
end

-- ����ս��ˢ�±���
function GI_sjzc_box_refresh()
	sjzc_box_refresh()
end

-- ����ս��ÿ30�������Ӫ���ָ�ǰ̨
function GI_sjzc_camp_sync()
	local ret = sjzc_camp_sync()
	if ret == true then
		return 30
	end
end

-- ����ս���ɼ�������Ƭ
function GI_sjzc_on_collect(cid)
	sjzc_on_collect(cid)
	return 1
end

-- ����ս���ύNPC
function GI_sjzc_submit_res()
	local sid = CI_GetPlayerData(17)
	if sid and sid > 0 then
		sjzc_submit_res(sid)
	end
end

-- ���²ɼ�NPC״̬
function GI_sjzc_update_collect(cid,mapGID)

	local ret = CI_UpdateNpcData(2,false,6,cid,mapGID)
	AreaRPC(6,cid,mapGID,'update_npc_collect',cid,false)
end

-- ��������
-- function GI_sjzc_box_open(cid)
	-- sjzc_box_open(cid)
	-- return 1
-- end


-----------------------------------��Ȫ------------------------------------
--�������̨
function wq_Gotojump(playerid,gid,selfname,selfgid)

		local Active_wenquan=activitymgr:get('wenquan')
	if Active_wenquan==nil then

		return
	end
	if not  Active_wenquan:is_active(playerid) then
		return
	end
	PI_MovePlayer(0, 10, 8, gid, 2,playerid)

	RegionRPC(gid,"WQ_Jump_go",selfname) --׼����ˮ
end

--ˢ��Ѽ��
function GI_wq_refreshduck(fbid)

	wq_refreshduck(fbid)
end

--�ɼ�Ѽ��
function GI_wq_collectduck(controlId)
	return wq_collectduck(controlId)
end
-----------------------------------��ˮ����------------------------------------
--ˢ�º�Ҷ��
function GI_qs_refresh(fbid)
	return qs_refresh(fbid)
end

--��������
function send_sclist(mapGID,scoreid)
	local sclist = get_scorelist_data(1,scoreid)

	RegionRPC(mapGID,'sclist',sclist)
end
	-- ÿ30�������ˮ��Ȫ����
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
--npc���غ����
function qs_relook( controlId, gid)
	local res=CI_UpdateNpcData(2,false,6,controlId,gid)	
	if not res or res<1 then return end
	AreaRPC(6,controlId,gid,'update_npc_collect',controlId,false)
end
----------------------------------------������-------------------------------

-- ������ÿ10��ƥ��һ��
function GI_lt_matching()
	lt_matching()
end

-- ǿ�ƽ���
function GI_lt_enter_ex(sidA,sidB,gid)
	lt_enter_ex(sidA,sidB,gid)
end

-- ͬ���������
function GI_lt_sync_pos(sidA,sidB,gid)
	return lt_sync_pos(sidA,sidB,gid)
end

----------------------------------------ץ��-------------------------------
--ˢ��
function GI_catchfish_refreshmonster(posIndex,gid)
	catchfish_refreshmonster(posIndex,gid)
end

----------------------------------------ץ��-------------------------------
--ˢ��
function GI_hunt_refreshmonster(posIndex,gid)
	hunt_refreshmonster(posIndex,gid)
end
----------------------------------------����-------------------------------
--ˢ
function GI_ss_creatboss(mapgid,lv,itype,fid)
	ss_creatboss(mapgid,lv,itype,fid)
end
--��������ʱδ������ʾʧ��
function GI_ss_endfail( fid )
	ss_endfail(fid)
end
----------------------------------------����-------------------------------
---�����ڹ����в�������̬����
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
----------------------------------------���ս-----------------------------

-- ͬ����Ϣ(���֡���Դ������)
function GI_ff_sync_data()
	local ret = ff_sync_data()
	if ret == true then
		return 10
	end
end

-- ÿ2�������ĸ�����
function GI_ff_flags_score()
	local ret = ff_flags_score()
	if ret then
		return 2
	end
end

-- ռ��ˮ�������
function GI_ff_owner_relive(cid)
	ff_owner_relive(cid)
	return 1
end

-- ռ������
function GI_ff_Owner_flags()
	ff_owner_flags()
	return 1
end

-- ���
function GI_ff_rescue(cid)
	ff_rescue(cid)
	return 1
end

-- ���ս�ύNPC
function GI_ff_submit_res()
	local sid = CI_GetPlayerData(17)
	if sid and sid > 0 then
		ff_submit_res(sid)
	end
end

-- 30���̬�赲ʧЧ
function GI_ff_set_block(state)
	ff_set_block(state)
end

-------------------------------------����ս--------------------------------------
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

-------------------------------------����ս��------------------------------------
--��ʼ����
function GI_af_secfight()
	af_secfight()
end

-------------------------------------��Ӫ�------------------------------------



-------------------------------------������--------------------------------------

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

-------------------------------------��ʯ����------------------------------------
function GI_yushi_creatmonster(sid,num,mapgid,time_n,texiao  )

	yushi_creatmonster(sid,num,mapgid,time_n,texiao)
end
--����ҵ��
function GI_Chick_bengin(sid,t_n)

	Chick_bengin(sid,t_n)
end
-------------------------------------�콵����------------------------------------
function GI_chick_tjbx( cid )
	return chick_tjbx( cid )
end

function GI_tjbx_refresh( npcid ,rgid )
	tjbx_refresh( npcid ,rgid)
end
-----------------------------------------��������--------------------------------
function GI_jysh_inform(user_npc)
    jysh_inform(user_npc)  
end
---------------------------------------����������ʵ͵ȡ------------------------
function GI_jysh_steal() 
    jysh_user_steal()
	return 1
end

--[[sxj,2014-08-21 add start]]--
---------------------------------------��ʯ����--------------------------------
function GI_bsmz_end(fid)
	bsmz_end(fid)
end
--[[sxj,2014-08-21 add end]]--