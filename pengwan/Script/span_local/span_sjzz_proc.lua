--PROGRAM:三界至尊(海选)
--CODE:CUREKO

local active_mgr_m = require('Script.active.active_mgr')
local activitymgr=active_mgr_m.activitymgr

local sjzz_conf_m = require('Script.span_local.span_sjzz_conf')
local hx_config = sjzz_conf_m.hx_config
local hx_monsters_list = sjzz_conf_m.hx_monsters_list

local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist_ex = sclist_m.insert_scorelist_ex

local ys_config = sjzz_conf_m.ys_config
local ys_monsters_list = sjzz_conf_m.ys_monsters_list
local uv_TimesTypeTb,GetStringMsg = TimesTypeTb,GetStringMsg

local SPAN_SJZZ_ID = 8
local _action_time = 0

function sjzz_setwdata(name,val)
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then	return end
	if w_customdata.sjzz == nil then
		w_customdata.sjzz = {}
	end
	local sjzz = w_customdata.sjzz
	sjzz[name] = val
end

function sjzz_getwdata(name)
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then	return end
	if w_customdata.sjzz == nil then
		w_customdata.sjzz = {}
	end
	local sjzz = w_customdata.sjzz
	return sjzz[name]
end

function sjzz_get_player_data(sid)
	--[1]	活动标志
	--[2]	伤害输出
	--[3]	决赛队伍
	return GI_GetPlayerData(sid,'sjzz',50)
end
function sjzz_local_reset()
	sjzz_setwdata("mb_info",nil)
	sjzz_setwdata('js_ranks',nil)
	sjzz_setwdata('mb_kings',nil)
	sjzz_setwdata('sjzz_hx_ranks',nil)
	sjzz_setwdata('sjzz_ys_ranks',nil)
end

function sjzz_hx_start()
	if (GetWorldLevel() or 0 ) < 60 then return end
	--look('sjzz_hx_start',2)
	local Active_sjzz = activitymgr:create('sjzz',true)
	if  Active_sjzz then
		sjzz_setwdata("sjzz_hx_ranks",nil);	
		Active_sjzz.on_regioncreate = sjzz_hx_on_regioncreate
		Active_sjzz.on_active_end = sjzz_hx_active_end	
		Active_sjzz.on_playerlive = sjzz_hx_on_playerlive
		Active_sjzz.start_time = GetServerTime()
		Active_sjzz:createDR(1)
		BroadcastRPC('sjzz_start',1)
	
		local span_svr=GetAllSpanServer()[1] --9990001
		sjzz_setwdata('span_svr',span_svr)
		sjzz_setwdata('span_svr_id',span_svr[1])
		SetEvent(hx_config.pretime,nil,'sjzz_hx_begin')	
	end
end

function sjzz_hx_enter(sid)
	--look('sjzz_hx_enter',2)
	--look(sid,2)
	if IsSpanServer() then return end
	local Active_sjzz=activitymgr:get('sjzz')
	if Active_sjzz==nil or Active_sjzz.sstate ~= 0 then
		RPCEx(sid,'sjzz_err',0)
		return
	end
	local pdata = sjzz_get_player_data(sid)
	look(pdata[1],2)
	look(Active_sjzz.start_time,2)
	if Active_sjzz.start_time ~= pdata[1] then
		pdata[2] = 0
		pdata[1] = Active_sjzz.start_time
	end
	if not Active_sjzz:is_active(sid) then
		Active_sjzz:add_player(sid,1,0,nil,nil,Active_sjzz.mapGID)
	end
end

function sjzz_hx_leave(sid)
	local Active_sjzz=activitymgr:get('sjzz')
	if Active_sjzz==nil then
		return
	end
	Active_sjzz:back_player(sid)
end

local function sjzz_hx_on_player_damage(sid,dest_gid,damage)
	local Active_sjzz
	Active_sjzz = activitymgr:get('sjzz')
	if not Active_sjzz then return false end

	Active_sjzz.damage_ranks = Active_sjzz.damage_ranks or {}
	local pdata =sjzz_get_player_data(sid)
	local name = CI_GetPlayerData(5,2,sid)
	pdata[2] = (pdata[2] or 0) + damage / 10000
	insert_scorelist_ex(Active_sjzz.damage_ranks,10,pdata[2],name,0,sid)
	
	--look(Active_sjzz.damage_ranks,2)
	return true
end

function sjzz_hx_on_regioncreate(Active_sjzz,mapGID)
	Active_sjzz.sstate = 0
	Active_sjzz.mapGID = mapGID
	
	SI_RegPlayerDamageProc(mapGID,sjzz_hx_on_player_damage)
	CreateObjectIndirect({monsterId = 880,x = 19, y = 105 ,deadScript = 4902 ,camp = 4,regionId = mapGID,})
end

local function sjzz_hx_refresh_monster(Active_sjzz,turn)
	if turn > hx_config.max_turn then
		sjzz_hx_end(Active_sjzz,true)
		return
	end
	local conf = hx_monsters_list[turn]
	Active_sjzz.turn = turn
	Active_sjzz.mon_num = conf.total
	for k,monster in pairs(conf.monsters) do
		monster.regionId = Active_sjzz.mapGID
		-- monster.monAtt={[1] = 1}
		CreateObjectIndirect(monster)
	end
	RegionRPC(Active_sjzz.mapGID,'sjzz_res',1,turn)
end

function sjzz_hx_begin()
	local Active_sjzz = activitymgr:get('sjzz')
	sjzz_hx_refresh_monster(Active_sjzz,1)
	SetEvent(5,nil,'sjzz_hx_on_timer',Active_sjzz.start_time)	
end

function sjzz_hx_on_timer(start_time)
	--look('sjzz_hx_on_timer',2)
	local Active_sjzz = activitymgr:get('sjzz')
	if not Active_sjzz or Active_sjzz.start_time ~= start_time then return end
	RegionRPC(Active_sjzz.mapGID,'sjzz_res',2,Active_sjzz.damage_ranks)
	return 5
end

function sjzz_hx_end(Active_sjzz,succ)
	if Active_sjzz.sstate ~= 0 then return end 
	Active_sjzz.sstate = 1
	local fid = getCityOwner()
	local cityowner_sid = CI_GetFactionLeaderInfo(fid,1)
	local king_name = nil
	local king_fight = 0
	
	if cityowner_sid then 
		local tsdata = PI_GetTsBaseData(cityowner_sid)
		if tsdata then 
			king_name = tsdata[1] or king_name 
			king_fight = tsdata[7] or king_fight 
		end
	end
	
	if not succ then 
		Active_sjzz.start_time = nil
		RegionRPC(Active_sjzz.mapGID,'sjzz_res',4)
		SendSystemMail(nil,sjzz_conf_m.sjzz_hx_mail,2,2,"",sjzz_conf_m.sjzz_hx_awards[2][1],nil,true)
		if king_name then
				SendSystemMail(king_name,sjzz_conf_m.sjzz_hx_mail,2,2,"",sjzz_conf_m.sjzz_hx_awards[2][2])
		end
		return
	end
	local score = GetServerTime() - Active_sjzz.start_time
	Active_sjzz.start_time = nil
	--look(score,2)
	--look(king_name,2)
	--look(king_fight,2)
	SendSystemMail(nil,sjzz_conf_m.sjzz_hx_mail,1,2,"",sjzz_conf_m.sjzz_hx_awards[1][1],nil,true)
	if king_name then
		SendSystemMail(king_name,sjzz_conf_m.sjzz_hx_mail,1,2,"",sjzz_conf_m.sjzz_hx_awards[1][2])
	end
	PI_SendToSpanSvr(sjzz_getwdata('span_svr_id'),{ids=11001,svrid = GetGroupID(),score=score,king_name=king_name,king_fight=king_fight},0)
	RegionRPC(Active_sjzz.mapGID,'sjzz_res',4,score)
end

function sjzz_hx_get_ranks()
	if sjzz_getwdata("sjzz_hx_ranks") then return nil end
	PI_SendToSpanSvr(sjzz_getwdata('span_svr_id'),{ids=11002,svrid = GetGroupID()},0)	
	return 30
end

function sjzz_hx_on_read_ranks(ranks)
	--look('sjzz_hx_on_read_ranks',2)
	sjzz_setwdata("sjzz_hx_ranks",ranks);
end

function sjzz_hx_active_end(Active_sjzz)
	if Active_sjzz.sstate == 0 then
		sjzz_hx_end(Active_sjzz,false)
	end
	sjzz_setwdata("sjzz_hx_ranks",nil)
	SetEvent(60 * 3 + (GetGroupID() % 60) ,nil,'sjzz_hx_get_ranks',Active_sjzz.start_time)	
end

function sjzz_hx_on_playerlive(Active_sjzz,sid)
	local x,y,regionId,mapGID=CI_GetCurPos()
	PI_MovePlayer(regionId,19,105,mapGID)
	return 1
end

call_monster_dead[4901] = function(mapGID)
	local Active_sjzz=activitymgr:get('sjzz')
	Active_sjzz.mon_num = Active_sjzz.mon_num-1
	if Active_sjzz.mon_num <= 0 then sjzz_hx_refresh_monster(Active_sjzz,Active_sjzz.turn + 1) end
end

call_monster_dead[4902] = function(mapGID)
	--look('flag dead',2)
	local Active_sjzz=activitymgr:get('sjzz')
	Active_sjzz.mon_num = Active_sjzz.mon_num-1
	sjzz_hx_end(Active_sjzz,false)
end

--PROGRAM:三界至尊(预赛)
--CODE:CUREKO
--MAP:532
function sjzz_ys_start()
	if (GetWorldLevel() or 0 ) < 60 then return end
	--look('sjzz_ys_start',2)
	local Active_sjzz = activitymgr:create('sjzz_ys',true)
	if  Active_sjzz then
		sjzz_setwdata("sjzz_ys_ranks",nil);
		
		local bCheck = false
		local hx_ranks = sjzz_getwdata("sjzz_hx_ranks")
		if hx_ranks then 
			local svrid = GetGroupID()
			for i=1,#hx_ranks do
				if hx_ranks[i][4] == svrid then 
					bCheck = true 
					break
				end
			end
		end
		Active_sjzz.bCheck = bCheck

		Active_sjzz.on_regioncreate = sjzz_ys_on_regioncreate
		Active_sjzz.on_active_end = sjzz_ys_active_end
		Active_sjzz.on_playerlive = sjzz_ys_on_playerlive
		Active_sjzz.start_time = GetServerTime()		
		Active_sjzz:createDR(1)
	
		BroadcastRPC('sjzz_start',2)
		SetEvent(ys_config.pretime,nil,'sjzz_ys_begin')	
	end
end

function sjzz_ys_enter(sid)
	if IsSpanServer() then return end
	local Active_sjzz=activitymgr:get('sjzz_ys')
	if Active_sjzz==nil or Active_sjzz.sstate ~= 0 then
		RPCEx(sid,'sjzz_err',1)
		return
	end
	
	if not Active_sjzz.bCheck then
		RPCEx(sid,'sjzz_err',2)
		return
	end
	
	local pdata = sjzz_get_player_data(sid)
	if Active_sjzz.start_time ~= pdata[1] then
		pdata[2] = 0
		pdata[1] = Active_sjzz.start_time
	end
	if not Active_sjzz:is_active(sid) then
		Active_sjzz:add_player(sid,1,0,nil,nil,Active_sjzz.mapGID)
	end
end

function sjzz_ys_leave(sid)
	local Active_sjzz=activitymgr:get('sjzz_ys')
	--look('sjzz_ys_leave',2)
	if Active_sjzz==nil then
		return
	end
	Active_sjzz:back_player(sid)
end

local function sjzz_ys_on_player_damage(sid,dest_gid,damage)
	--look('sjzz_ys_on_player_damage',2)
	local Active_sjzz = activitymgr:get('sjzz_ys')
	if not Active_sjzz then return false end
	
	Active_sjzz.damage_ranks = Active_sjzz.damage_ranks or {}
	local pdata =sjzz_get_player_data(sid)
	local name = CI_GetPlayerData(5,2,sid)
	pdata[2] = (pdata[2] or 0) + damage / 10000
	insert_scorelist_ex(Active_sjzz.damage_ranks,10,pdata[2],name,0,sid)
	return true
end

function sjzz_ys_on_regioncreate(Active_sjzz,mapGID)
	Active_sjzz.sstate = 0
	Active_sjzz.mapGID = mapGID
	SI_RegPlayerDamageProc(mapGID,sjzz_ys_on_player_damage)
end

local function sjzz_ys_refresh_monster(Active_sjzz,turn)
	if turn > ys_config.max_turn then
		sjzz_ys_end(Active_sjzz,true)
		return
	end
	local conf = ys_monsters_list[turn]
	Active_sjzz.turn = turn
	Active_sjzz.mon_num = conf.total
	for k,monster in pairs(conf.monsters) do
		monster.regionId = Active_sjzz.mapGID
		CreateObjectIndirect(monster)
	end
end

function sjzz_ys_begin()
	local Active_sjzz = activitymgr:get('sjzz_ys')
	sjzz_ys_refresh_monster(Active_sjzz,1)
	SetEvent(5,nil,'sjzz_ys_on_timer',Active_sjzz.start_time)	
end

function sjzz_ys_on_timer(start_time)
	local Active_sjzz = activitymgr:get('sjzz_ys')
	if not Active_sjzz or Active_sjzz.start_time ~= start_time then return end
	RegionRPC(Active_sjzz.mapGID,'sjzz_res2',2,Active_sjzz.damage_ranks)
	return 5
end

function sjzz_ys_end(Active_sjzz,succ)
	if Active_sjzz.sstate ~= 0 then return end 
	Active_sjzz.sstate = 1
	if not Active_sjzz.bCheck then return end
	local fid = getCityOwner()
	local cityowner_sid = CI_GetFactionLeaderInfo(fid,1)
	local king_name = nil
	local king_fight = 0

	if cityowner_sid then 
		local tsdata = PI_GetTsBaseData(cityowner_sid)
		if tsdata then 
			king_name = tsdata[1] or king_name 
			king_fight = tsdata[7] or king_fight 
		end
	end	
	
	if not succ then 
		Active_sjzz.start_time = nil
		RegionRPC(Active_sjzz.mapGID,'sjzz_res2',4)
		SendSystemMail(nil,sjzz_conf_m.sjzz_ys_mail,2,2,"",sjzz_conf_m.sjzz_ys_awards[2][1],nil,true)
		if king_name then
			SendSystemMail(king_name,sjzz_conf_m.sjzz_ys_mail,2,2,"",sjzz_conf_m.sjzz_ys_awards[2][2])
		end	
		return
	end	

	local score = GetServerTime() - Active_sjzz.start_time
	Active_sjzz.start_time = nil
	SendSystemMail(nil,sjzz_conf_m.sjzz_ys_mail,1,2,"",sjzz_conf_m.sjzz_ys_awards[1][1],nil,true)
	if king_name then
		SendSystemMail(king_name,sjzz_conf_m.sjzz_ys_mail,1,2,"",sjzz_conf_m.sjzz_ys_awards[1][2])
	end	
	PI_SendToSpanSvr(sjzz_getwdata('span_svr_id'),{ids=12001,svrid = GetGroupID(),score=score,king_name=king_name,king_fight=king_fight},0)
	RegionRPC(Active_sjzz.mapGID,'sjzz_res2',4,score)
end

function sjzz_ys_get_ranks()
	if sjzz_getwdata("sjzz_ys_ranks") then return nil end
	PI_SendToSpanSvr(sjzz_getwdata('span_svr_id'),{ids=12002,svrid = GetGroupID()},0)	
	return 30
end
function sjzz_ys_on_read_ranks(ranks)
	--look(ranks,2)
	sjzz_setwdata("sjzz_ys_ranks",ranks);
end
function sjzz_ys_active_end(Active_sjzz)
	if Active_sjzz.sstate == 0 then
		sjzz_ys_end(Active_sjzz,false)
	end
	sjzz_setwdata("sjzz_ys_ranks",nil)
	SetEvent(60 * 3 + (GetGroupID() % 60) ,nil,'sjzz_ys_get_ranks',Active_sjzz.start_time)	
end
function sjzz_ys_on_playerlive(Active_sjzz,sid)
	local x,y,regionId,mapGID=CI_GetCurPos()
	PI_MovePlayer(regionId,19,105,mapGID)
	return 1
end

local boss_pos = {
	{-1, 0},
	{ 0, 0},
	{ 0, 1},
}
function sjzz_boss_mirrors(mapGID,monGID,x,y,bossprg)
	local Active_sjzz=activitymgr:get('sjzz_ys')
	if not Active_sjzz or Active_sjzz.mapGID ~= mapGID then return end
	
	Active_sjzz.boss_hp = GetMonsterData(6,3)
	Active_sjzz.bossprg = bossprg
	local x,y = CI_GetCurPos(3)
	CI_DelMonster(mapGID,monGID)

	local monster = ys_monsters_list[Active_sjzz.turn]
	local mon_new = {monAtt={[1] = monster.monAtt[1] * 0.2}}
	for i=1,3 do
		monster.regionId = Active_sjzz.mapGID
		monster.x = x + boss_pos[i][1]
		monster.y = y + boss_pos[i][2]
		monster.deadScript = 4912
		monster.controlId = 1006 + i
		monGID = CreateObjectIndirect(monster)
		CI_UpdateMonsterData(1,mon_new,nil,4,monGID)
	end
	Active_sjzz.mirrors = 3
	RegionRPC(Active_sjzz.mapGID,'sjzz_res2',6,1)
end

call_monster_dead[4911] = function(mapGID)
	local Active_sjzz=activitymgr:get('sjzz_ys')
	if Active_sjzz.mapGID ~= mapGID then return end
	Active_sjzz.mon_num = Active_sjzz.mon_num-1
	if Active_sjzz.mon_num <= 0 then 
		if Active_sjzz.turn ~= 3 then
			sjzz_ys_refresh_monster(Active_sjzz,Active_sjzz.turn + 1) 
		else		
			Active_sjzz.mon_num = 1
			Active_sjzz.turn = 4
			local monster = ys_monsters_list[Active_sjzz.turn]
			Active_sjzz.mon_num = 1
			monster.deadScript = 4911
			monster.eventScript = 1029
			monster.controlId = 1006
			monster.regionId = Active_sjzz.mapGID
			local mosterGID = CreateObjectIndirect(monster)
			MonsterRegisterEventTrigger(mapGID,mosterGID,MonsterEvents[1029])
		end
	end
end

call_monster_dead[4912] = function(mapGID)
	local Active_sjzz=activitymgr:get('sjzz_ys')
	if Active_sjzz.mapGID ~= mapGID then return end
	Active_sjzz.mirrors = Active_sjzz.mirrors - 1
	if Active_sjzz.mirrors <= 0 then
		local monster = ys_monsters_list[Active_sjzz.turn]
		local x,y,rid = CI_GetCurPos(3)
		monster.x = x
		monster.y = y
		monster.deadScript = 4911
		monster.controlId = 1006
		monster.regionId = Active_sjzz.mapGID
		monster.eventScript = Active_sjzz.bossprg
		local monGID = CreateObjectIndirect(monster)
		CI_UpdateMonsterData(1,{hp = Active_sjzz.boss_hp},nil,4,monGID)
		if monster.eventScript then
			look('MonsterRegisterEventTrigger',2)
			MonsterRegisterEventTrigger(mapGID,monGID,MonsterEvents[monster.eventScript])
		end
	end
end

function sjzz_hx_get_info(sid)
	local Active_sjzz = activitymgr:get('sjzz')
	local pdata = sjzz_get_player_data(sid)
	if Active_sjzz and Active_sjzz.start_time == pdata[1] then
		RPCEx(sid,'sjzz_res',5,Active_sjzz.turn,Active_sjzz.damage_ranks,pdata[2])
	end
end

function sjzz_ys_get_info(sid)
	local Active_sjzz = activitymgr:get('sjzz_ys')
	local pdata = sjzz_get_player_data(sid)
	if Active_sjzz and Active_sjzz.start_time == pdata[1] then
		RPCEx(sid,'sjzz_res2',5,Active_sjzz.turn,Active_sjzz.damage_ranks,pdata[2])
	end
end
--PROGRAM:三界至尊(决赛)
--CODE:CUREKO
--MAP:533

--REQUEST MESSAGE

function sjzz_notify(ntype)
	BroadcastRPC('sjzz_notify',ntype)
end

function sjzz_js_notify()
	BroadcastRPC('sjzz_start',3)
end

function sjzz_enter_span_server(sid,msg)
	--look('sjzz_enter_span_server',2)
	local bCheck = false
	local ys_ranks = sjzz_getwdata("sjzz_ys_ranks")
	--look(ys_ranks,2)
	if ys_ranks then 
		local svrid = GetGroupID()
		for i=1,3 do
			if ys_ranks[i] and ys_ranks[i][4] == svrid then 
				bCheck = true 
				break
			end
		end
	end
	if not bCheck then
		RPCEx(sid,'sjzz_err',2)
		return
	end
	SetPlayerSpanUID(sid,SPAN_SJZZ_ID)
	local svrinfo = sjzz_getwdata('span_svr')
	PI_EnterSpanServerEx(sid,GetTargetSvrID(svrinfo[1]),svrinfo[2],svrinfo[3],msg.pass,msg.localIP,msg.port,msg.entryid)
end

function sjzz_span_mb(sid,index)
	if not CheckTimes(sid,uv_TimesTypeTb.CS_SJZZ_MB,1,-1) then return end
	local level = CI_GetPlayerData(1)
	GiveGoods(0,level * 1000,1,"三界至尊膜拜")
	PI_SendToSpanSvr(sjzz_getwdata('span_svr_id'),{ids=11003,index=index,},0)
end

function sjzz_get_kings(sid)
	local mb_kings = sjzz_getwdata("mb_kings");
	if not mb_kings then return end
	RPCEx(sid,'sjzz_kings',mb_kings)
end

function sjzz_get_js_ranks(sid)
	local js_ranks = sjzz_getwdata("js_ranks")
	if not js_ranks then return end
	RPCEx(sid,'sjzz_js_ranks',js_ranks)
end

function sjzz_get_mb_info(sid)
	local nowTime = GetServerTime()
	if nowTime - _action_time > 1 then
			_action_time = nowTime
			look('sjzz_get_mb_info',2)
			PI_SendToSpanSvr(sjzz_getwdata('span_svr_id'),{ids=11003,svrid=GetGroupID(),},0)
	end
	RPCEx(sid,'sjzz_mb_info',sjzz_getwdata("mb_info"))
end

function sjzz_set_mb_info(info)
	sjzz_setwdata("mb_info",info)
end

function sjzz_mb_start(sid)
	sjzz_setwdata("mb_state",1)
	SetEvent(10,nil,'sjzz_mb_on_timer')	
end

function sjzz_mb_end(sid)
	sjzz_setwdata("mb_state",nil)
end

local define = require('Script.cext.define')
local EquipItemInfo = define.EquipItemInfo

function sjzz_get_kings_info(svrid,res)
	look('sjzz_get_kings_info',2)
	local owner_fid = getCityOwner()
	if owner_fid == nil then return end
	local bzsid,fbzsid = CI_GetFactionLeaderInfo(owner_fid,1)
	local bzfrsid = _G.GetCoupleSID(bzsid) or 0	

	local local_rank = nil
	local local_svrid = GetGroupID()
	local kings = res[1].kings 
	res[1].king = nil
	sjzz_setwdata("js_ranks",res)
	sjzz_setwdata("mb_kings",kings)
	kings = {
		[1] =PI_GetTsBaseData(bzsid),
		[2] =PI_GetTsBaseData(fbzsid),
		[3] =PI_GetTsBaseData(bzfrsid),}
	for i=1,3 do
		if res[i][4] == local_svrid then
			local_rank = i
		end
		if kings[i] ~= nil then
			kings[10 + i] = CI_GetFactionInfo(kings[i][6],1)
		end
	end
	PI_SendToSpanSvr(svrid,{ids=11005,svrid = GetGroupID(),kings = kings},0)	
	if local_rank then
		SendSystemMail(nil,sjzz_conf_m.sjzz_js_mail,local_rank,2,nil,sjzz_conf_m.sjzz_js_awards[local_rank][1],nil,true)
		if kings[1] then
			SendSystemMail(kings[1][1],sjzz_conf_m.sjzz_js_mail,local_rank,2,nil,sjzz_conf_m.sjzz_js_awards[local_rank][2])
		end
	end
end

function sjzz_try_get_js_res()
	if sjzz_getwdata("js_ranks") then return nil end
		PI_SendToSpanSvr(sjzz_getwdata('span_svr_id'),{ids=11006,svrid=GetGroupID(),index=index,},0)
	return 30
end

function sjzz_on_js_end()
	sjzz_setwdata("js_ranks",nil);
	sjzz_setwdata("mb_kings",nil);
	SetEvent(1 + GetGroupID() % 60,nil,'sjzz_try_get_js_res')	
end

function sjzz_set_js_res(sid,res)
	local kings = res[1].kings 
	res[1].king = nil
	sjzz_setwdata("js_ranks",res);
	sjzz_setwdata("mb_kings",kings);
end

function check_sizz()
	local Active_sjzz = activitymgr:get('sjzz')
	local Active_sjzz_ys = activitymgr:get('sjzz_ys')
	local flags_sjzz = 0
	local	flags_sjzz_ys = 0
	if Active_sjzz then 
		flags_sjzz = Active_sjzz:get_state()
	end
	if Active_sizz_ys then 
		flags_sjzz_ys = Active_sjzz_ys:get_state()
	end
	look("Active_sjzz state: "..flags_sjzz)
	look("Active_sjzz_ys state: "..flags_sjzz_ys)
end

