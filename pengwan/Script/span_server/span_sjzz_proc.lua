--PROGRAM:三界至尊
--CODE:CUREKO
local define = require('Script.cext.define')
local ProBarType = define.ProBarType

local active_mgr_m = require('Script.active.active_mgr')
local activitymgr=active_mgr_m.activitymgr

local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist_ex = sclist_m.insert_scorelist_ex

local sjzz_js_config = 
{
	pretime = 6,
}

local flags_list = 
{
	[1] = {name = "未被占领的旗帜",monsterId = 510,imageID = 2269,headID = 2269,camp=4,eventScript = 208,x = 31,y = 128,},
	[2] = {name = "未被占领的旗帜",monsterId = 510,imageID = 2269,headID = 2269,camp=4,eventScript = 208,x = 83,y =  91,},
	[3] = {name = "未被占领的旗帜",monsterId = 510,imageID = 2269,headID = 2269,camp=4,eventScript = 208,x = 63,y = 107,},
	[4] = {name = "未被占领的旗帜",monsterId = 510,imageID = 2269,headID = 2269,camp=4,eventScript = 208,x = 33,y =  80,},
	[5] = {name = "未被占领的旗帜",monsterId = 510,imageID = 2269,headID = 2269,camp=4,eventScript = 208,x = 55,y =  73,},
	[6] = {name = "未被占领的旗帜",monsterId = 510,imageID = 2269,headID = 2269,camp=4,eventScript = 208,x = 71,y =  50,},
	[7] = {name = "未被占领的旗帜",monsterId = 510,imageID = 2269,headID = 2269,camp=4,eventScript = 208,x = 32,y =  38,},
}

local teams_info = 
{
	[1] = {name = "天界",birth_pos={82,26},},
	[2] = {name = "魔界",birth_pos={78,142},},
	[3] = {name = "人界",birth_pos={6,83},},
}

function sjzz_span_reset()
	look('sjzz_span_reset',2)
	sjzz_setwdata('hx_ranks',nil)
	sjzz_setwdata('ys_ranks',nil)
end

local function sjzz_score_cmp(a,b)
	if a[1] ~= b[1] then return a[1] < b[1] end
	return a[3] > b[3]
end

local function sjzz_insert_ranks(t,num,score,name,fight,svrid)
	local ist = true
	for i=1,#t do
		if t[i][4] == svrid then 
			t[i][1] = score;ist = false
		end 
	end
	if ist then	t[#t + 1] = {score,name,fight,svrid} end
	table.sort(t,sjzz_score_cmp)
	t[num + 1] = nil
end

function sjzz_hx_score(svrid,score,king_name,king_fight)
	--look('sjzz_hx_score',2)
	local ranks = sjzz_getwdata('hx_ranks') or {}
	sjzz_insert_ranks(ranks,10,score,king_name,king_fight,svrid)
	sjzz_setwdata('hx_ranks',ranks)
end

function sjzz_get_hx_rank(svrid)
	--look('sjzz_get_hx_rank',2)
	PI_SendToLocalSvr(svrid,{ids = 11002,ranks = sjzz_getwdata('hx_ranks')})
end

function sjzz_ys_score(svrid,score,king_name,king_fight)
	--look('sjzz_ys_score',2)
	local ranks = sjzz_getwdata('ys_ranks') or {}
	sjzz_insert_ranks(ranks,10,score,king_name,king_fight,svrid)
	sjzz_setwdata('ys_ranks',ranks)
end

function sjzz_get_ys_rank(svrid)
	--look(sjzz_getwdata('ys_ranks'),2)
	PI_SendToLocalSvr(svrid,{ids = 11003,ranks = sjzz_getwdata('ys_ranks')})
end

function sjzz_js_start()
	local Active_sjzz = activitymgr:create('sjzz_js',true)
	if  Active_sjzz then
		Active_sjzz.on_regioncreate = sjzz_js_on_regioncreate
		Active_sjzz.on_playerlive = sjzz_js_on_playerlive
		Active_sjzz.on_active_end = sjzz_js_active_end	
		Active_sjzz.start_time = GetServerTime()
		sjzz_setwdata('js_team_ranks',{})
		sjzz_setwdata('span_mb_info',{})
		sjzz_setwdata('js_res',nil)
		Active_sjzz.sjzz_flags_sum = {}
		Active_sjzz.sjzz_flags = {}
		Active_sjzz:createDR(1)
		--look('sjzz_js_start',2)
	end
end

function sjzz_js_get_team(svrid)
	local ranks = sjzz_getwdata('ys_ranks')
	if not ranks then return nil end
	for i=1,3 do
		if ranks[i][4] == svrid then return i end
	end
end

function sjzz_js_enter(sid)
	--look('sjzz_js_enter',2)
	local Active_sjzz=activitymgr:get('sjzz_js')
	if not Active_sjzz then return false end
	local pdata = sjzz_get_player_data(sid)
	if Active_sjzz.start_time ~= pdata[1] then
		pdata[2] = 0
		pdata[1] = Active_sjzz.start_time
	end
	pdata[3] = sjzz_js_get_team(GetPlayerServerID(sid))
	
	--look(pdata[3],2)
	if not pdata[3] then 
		RPCEx(sid,'sjzz_err',2)
		return false
	end
	SetCamp(pdata[3])
	local birth_pos = teams_info[pdata[3]].birth_pos
	Active_sjzz:add_player(sid,1,0,birth_pos[1],birth_pos[2],Active_sjzz.mapGID)
	--look('add_player',2)
	return true
end

function sjzz_js_on_regioncreate(Active_sjzz,mapGID)
	Active_sjzz.mapGID = mapGID
	local flags = Active_sjzz.sjzz_flags 
	local controlID = 1001
	for k,v in pairs(flags_list) do
		v.regionId = mapGID
		v.controlID = controlID
		controlID = controlID + 1
		flags[CreateObjectIndirect(v)] = {conf=v}
	end
	SI_RegPlayerDamageProc(mapGID,sjzz_js_on_player_damage)
	SetEvent(sjzz_js_config.pretime,nil,'sjzz_js_on_timer',mapGID)	
end

function sjzz_js_on_playerlive(Active_sjzz,sid)
	--look('sjzz_js_on_playerlive',2)
	local x,y,regionId,mapGID=CI_GetCurPos()
	local pdata = sjzz_get_player_data(sid)
	local birth_pos = teams_info[pdata[3]].birth_pos
	PI_MovePlayer(regionId,birth_pos[1],birth_pos[2],mapGID)
	return 1
end

function sjzz_js_active_end(Active_sjzz)
	--look("sjzz_js_active_end",2)
	local ys_ranks = sjzz_getwdata('ys_ranks')
	local team_ranks = sjzz_getwdata('js_team_ranks')
	local js_res = {
	}
	for i = 1,3 do
		local t = {}
		js_res[i] = t
		if ys_ranks[i] then 
			t[2] = ys_ranks[i][2]
			t[3] = ys_ranks[i][3]
			t[4] = ys_ranks[i][4]
		end
		t[1] = team_ranks[i] or 0
	end
	table.sort(js_res,function(a,b)
		return a[1] > b[1] 
	end)
	look(js_res,2)
	sjzz_setwdata('js_res',js_res)
	if Active_sjzz then
		RegionRPC(Active_sjzz.mapGID,'sjzz_res3',4)
	end
	for i = 1,3 do
		PI_SendToLocalSvr(js_res[i][4],{ids = 11005,svrid = GetGroupID(),res=js_res})
	end
end

function sjzz_set_kings_info(svrid,kings)
	local js_res = sjzz_getwdata('js_res')
	--look('sjzz_set_kings_info',2)
	kings.svrid = svrid
	look(js_res,2)
	if js_res[1][4] == svrid then 
		js_res[1].kings = kings
		look(js_res,2)
	end
end

function sjzz_add_mb_info(svrid,index)
	--look('sjzz_add_mb_info',2)
	local mb_info = sjzz_getwdata('span_mb_info')
	if index then
		mb_info[index] = (mb_info[index] or 0) + 1
			look(mb_info,2)
	else
		PI_SendToLocalSvr(svrid,{ids = 11004,info = mb_info})
	end
end

function sjzz_get_js_res(svrid)
	--look('sjzz_get_js_res',2)
	PI_SendToLocalSvr(svrid,{ids = 11006,svrid = GetGroupID(),js_res = sjzz_getwdata('js_res')})
end

function sjzz_js_on_timer(mapGID)
	local Active_sjzz = activitymgr:get('sjzz_js')
	if not Active_sjzz or Active_sjzz.mapGID ~= mapGID then return nil end
	local team_ranks = sjzz_getwdata('js_team_ranks')
	local flags = Active_sjzz.sjzz_flags 
	for k,v in pairs(flags) do
		local team = v.team
		if team then team_ranks[team] = (team_ranks[team] or 0)+1 end
	end
	RegionRPC(Active_sjzz.mapGID,'sjzz_res3',1,team_ranks)
	Active_sjzz.tick = (Active_sjzz.tick or 0) + 1
	if not Active_sjzz.tick or Active_sjzz.tick > 5 then
		Active_sjzz.tick = 0
		look(Active_sjzz.damage_ranks,2)
		RegionRPC(Active_sjzz.mapGID,'sjzz_res3',2,Active_sjzz.damage_ranks)
	end
	return 1
end

function sjzz_js_click_flag(sid,gid)
	local Active_sjzz = activitymgr:get('sjzz_js')
	if not Active_sjzz then return nil end
	local flag = Active_sjzz.sjzz_flags[gid]
	local flag_conf = flag.conf
	if not flag_conf then return end
	local pdata = sjzz_get_player_data(sid)
	if flag.team == pdata[3] then return end
	local px,py = CI_GetCurPos()
	local cx,cy = math.abs(px-flag_conf.x),math.abs(py-flag_conf.y)
	if cx * cx + cy * cy > 9 then return end
	local temp = GetPlayerTemp_custom(sid)
	temp.sjzz_fgid = gid
	CI_SetReadyEvent(0,ProBarType.hold,3,1,"sjzz_js_hold_flag")
end

function sjzz_js_hold_flag()
	local Active_sjzz = activitymgr:get('sjzz_js')
	if not Active_sjzz then return nil end
	local flags = Active_sjzz.sjzz_flags 
	
	local sid = GetCurPlayerID()
	local temp = GetPlayerTemp_custom(sid)
	local pdata = sjzz_get_player_data(sid)
	
	local flags_cnt = Active_sjzz.sjzz_flags_sum
	local fgid = temp.sjzz_fgid
	local flag = flags[fgid]
	if flag.team == pdata[3] then return end
	
	if flag.team then flags_cnt[flag.team] = flags_cnt[flag.team]-1 end
	flags[fgid].team = pdata[3]
	flags_cnt[flag.team] = (flags_cnt[flag.team] or 0)+1
	local new_name = teams_info[pdata[3]].name
	local imageID = 2265 + pdata[3]
	CI_UpdateMonsterData(1,{name=new_name,imageID=imageID,headID=imageID},nil,4,fgid)
	RegionRPC(Active_sjzz.mapGID,'sjzz_res3',3,fgid,pdata[3],flags_cnt)
	return 1
end

function sjzz_js_sync(sid)
	local Active_sjzz = activitymgr:get('sjzz_js')
	if not Active_sjzz then return nil end
	local pdata = sjzz_get_player_data(sid)
	local flags_cnt = Active_sjzz.sjzz_flags_sum
	RegionRPC(Active_sjzz.mapGID,'sjzz_res3',5,pdata[2],flags_cnt)
end

function sjzz_js_on_player_damage(sid,dest_gid,damage)
	local Active_sjzz
	Active_sjzz = activitymgr:get('sjzz_js')
	if not Active_sjzz then return false end
	Active_sjzz.damage_ranks = Active_sjzz.damage_ranks or {}
	local pdata =sjzz_get_player_data(sid)
	local name = CI_GetPlayerData(5,2,sid)
	pdata[2] = (pdata[2] or 0) + damage / 10000
	insert_scorelist_ex(Active_sjzz.damage_ranks,10,pdata[2],name,0,sid)
	look(Active_sjzz.damage_ranks,2)
	return true
end

function check_sizz()
	local Active_sjzz_js = activitymgr:get('sjzz_js')
	local	flags_sjzz_js = 0
	if Active_sjzz_js then 
		flags_sjzz_js = Active_sjzz_js:get_state()
	end
	look("Active_sjzz_js state: "..flags_sjzz_js)
end