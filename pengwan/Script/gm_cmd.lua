--refix: done by chal
local dbMgr = dbMgr
local look = look
local TP_FUNC = type( function() end)

local common 			= require('Script.common.Log')
Log 				= common.Log ---全局,不要修改

local wenquan 		= require('Script.active.wenquan')
local wq_start 	= wenquan.wq_start
local qss 		= require('Script.active.qsls')
local qs_start 	= qss.qs_start
local sclist_m = require('Script.scorelist.sclist_func')
local refresh_scorelist = sclist_m.refresh_scorelist
local sjzc_m = require('Script.active.sjzc')
local sjzc_start = sjzc_m.sjzc_start
local yushi = require('Script.active.yushi')
local cs_yushi = yushi.cs_yushi
local af_m = require('Script.active.anonymity_fight')
local afight_start = af_m.afight_start
local afight_enter = af_m.afight_enter
local afight_exit = af_m.afight_exit
local db_module = require('Script.cext.dbrpc')
local get_fight_rank = db_module.get_fight_rank
local lt_module = require('Script.active.lt')
local lt_start = lt_module.lt_start
local lt_clear_data = lt_module.lt_clear_data
local ff_module = require("Script.active.faction_fight")
local ff_start = ff_module.ff_start
local catch_fish = require('Script.active.catch_fish')
local catchfish_start = catch_fish.catchfish_start
local boss_active_m = require('Script.active.boss_active')
local Monster_Create = boss_active_m.Monster_Create
local Monster_Remove=boss_active_m.Monster_Remove
local hunting = require('Script.active.hunting')
local hunt_start = hunting.hunt_start
local faction_monster = require('Script.active.faction_monster')
local ss_call = faction_monster.ss_call
local ss_clcd=faction_monster.ss_clcd
local ss_enter=faction_monster.ss_enter
local ss_exit=faction_monster.ss_exit
local card_=require("Script.card.card_func")
local card_useitem=card_.card_useitem
local card_cl=card_.card_cl
local card_addsl=card_.card_addsl
local obj_set = require('Script.Achieve.fun')
local clear_obj_pos = obj_set.clear_obj_pos
local add_fun_val = obj_set.add_fun_val
local new_guide = require('Script.new_guide.fun')
local set_guide = new_guide.set_guide
local db_module = require('Script.cext.dbrpc')
local db_active_detail = db_module.db_active_detail
local db_active_list=db_module.db_active_list
local task_a = require('Script.active.task_a')
local task_start = task_a.task_start
local cf_module = require("Script.active.city_fight")
local cf_start = cf_module.cf_start
local cf_enter = cf_module.cf_enter
local wbao = require('Script.active.wabao')
local wb_chick = wbao.wb_chick
local wb_getstore = wbao.wb_getstore
local wb_clc=wb_clc
local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond
local tjbx = require('Script.active.tjbx')
local tjbx_start = tjbx.tjbx_start
local tjbx_enter = tjbx.tjbx_enter
local tjbx_exit = tjbx.tjbx_exit
local fun_module = require('Script.Achieve.fun')
local giveplayer_jihuogift = fun_module.giveplayer_jihuogift
--local fun = require('Script.lottery.luck_roll')
local Setluck_roll_mark  = Setluck_roll_mark
local spboss_m = require('Script.span_server.span_boss')
local sb_start = spboss_m.sb_start
local spxb_m = require('Script.span_server.span_xunbao')
local spxb_enter = spxb_m.spxb_enter
local spxb_start = spxb_m.spxb_start
local span_xb_create_monster = spxb_m.CreateMonster
local pres_add_score = pres_add_score
local spxb_start_proc = spxb_start_proc
local sptjbx_m = require('Script.span_server.span_tjbx')
local span_tjbx_start = sptjbx_m.span_tjbx_start
local shq_m = require('Script.ShenQi.shenqi_func')
local shenqi_get = shq_m.shenqi_get
local span_sjzc_module = require('Script.span_server.span_sjzc')
local span_sjzc_start = span_sjzc_module.span_sjzc_start
local wuzhuang = require('Script.wuzhuang.wuzhuang_fun')
local wuzhuang_up = wuzhuang.wuzhuang_up
local gm_set_level = wuzhuang.gm_set_level
local jysh = require('Script.shenshu.jysh_fun')
local jysh_plant    = jysh.jysh_plant
local jysh_open     = jysh.jysh_open
local jysh_renovate = jysh.jysh_renovate
local jysh_obtain   = jysh.jysh_obtain
local jysh_clear    = jysh.jysh_clear
local jysh_tree_delete  = jysh.Jysh_tree_delete
local fabao = require('Script.fabao.fabao_fun')
local fabao_update = fabao.fabao_update
local hunshi_xiangqian = fabao.hunshi_xiangqian
local fb_activated = fabao.fb_activated
local fabao_update = fabao.fabao_update
local hunshi_xiezai = fabao.hunshi_xiezai
local bsmz_m = require("Script.bsmz.bsmz_fun")
local bsmz_clear = bsmz_m.bsmz_clear
local bsmz_refresh = bsmz_m.bsmz_refresh

local chunjie_module = require('Script.Active.chunjie_active')
local test_chunjie = chunjie_module.test_chunjie
local get_chunjie_info = chunjie_module.get_chunjie_info
local award_login = chunjie_module.award_login
local award_aim = chunjie_module.award_aim
local award_recharge = chunjie_module.award_recharge
local get_recharge = chunjie_module.get_recharge
local add_chunjie_score = chunjie_module.add_chunjie_score
local donate = require("Script.Player.player_donate")		-- 玩家捐献爵位系统
-- local player_donate = donate.player_donate
local donate_rank_refresh = donate.donate_rank_refresh
-- local get_donate_panel = donate.get_donate_panel
-- local get_donate_award = donate.get_donate_award

local xtg = require("Script.CopyScene.xtg")
-- local clear_xtg_data = xtg.clear_xtg_data
-- local clear_player_data = xtg.clear_player_data
-- local get_xtg_panel = xtg.get_xtg_panel
-- local get_xtg_award = xtg.get_xtg_award
-- local get_xtg_rank = xtg.get_xtg_rank
local GM_add_kills = xtg.GM_add_kills
local fasb = require("Script.ShenBing.faction_func")
local fasb_clear_data = fasb.fasb_clear_data
local CI_DelBuff = CI_DelBuff
local firstbatt =firstbatt

local dragon = require('Script.ShenBing.dragon_func')
local dragon_up_data = dragon.dragon_up_data
---
local shq_m = require('Script.ShenQi.shenqi_func')
local jiezhi_unload = shq_m.jiezhi_unload
local equip_jiezhi = shq_m.equip_jiezhi

-- local awake_module = require('Script.Player.player_awake')
-- local player_awake_data = awake_module.player_awake_data
-- local player_get_equip = awake_module.player_get_equip
local Times_DayResetTimes = require('Script.TimesMgr.TimesMgr_func') --重置次数管理器

function acb(t)
	if t == 0 then
		GI_OnActiveEnd('span_boss')
	elseif t == 1 then
		sb_start()
	end
end


------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------

function CALLBACK_RoleInfo(sid,rs)
	look(sid,1)
	Log('roleinfo.txt',rs)
end

function temp_xunbao()
	local w_customdata = GetWorldCustomDB()
	if w_customdata.fsbw == nil then return end
	w_customdata.fsbw[2]={}
	w_customdata.fsbw[3]={}
	w_customdata.fsbw[4]={}
	w_customdata.fsbw[5]={}
	w_customdata.fsbw[6]={}
	w_customdata.fsbw[7]=nil
	w_customdata.fsbw[8]=nil
	w_customdata.fsbw[9]=nil
	w_customdata.fsbw[10]={}
	w_customdata.fsbw[11]=nil
	w_customdata.fsbw[12]=nil
end

function set_open_tm()
	--if __debug then
		local tm = GetTimeToSecond(2013,12,11,10,0,0)
		SetServerOpenTime(tm)
	--end
end

function set_merge_tm()
	if __debug then
		local tm = GetTimeToSecond(2013,12,11,10,0,0)
		SetServerMergeTime(tm)
	end
end

function aoe1()
	OnActiveEvent({2000000001,{[307] = 10}})
end

-- 在脚本刷新前在OnScriptClosing里调用，将所有dbTable保存至缓存中
function savedbt() 
	SaveDBTable('extra_data', './dbtables/extra_data.dbt')
	SaveDBTable('world_rank_data', './dbTables/world_rank_data.dbt')
	SaveDBTable('world_custom_data', './dbTables/world_custom_data.dbt')
	SaveDBTable('del_data', './dbTables/del_data.dbt')
end
-- 跨服脚本命令 [主要用于在本服开启跨服活动]
function Span_ScriptGMCMD(gCMD, args)
	look('Span_ScriptGMCMD',1)
	look(gCMD,1)
	look(args,1)
	if gCMD == nil or type(args) ~= type({}) then return end
	if gCMD == 1 then		-- 跨服BOSS活动
		if args[1] == 0 then
			GI_OnActiveEnd('span_boss')
		elseif args[1] == 1 then
			sb_start()			
		elseif args[1] == 2 then
			GI_ClrActiveData('span_boss')
		end
	elseif gCMD == 2 then
		if args[1] == 0 then
			GI_OnActiveEnd('span_xunbao')
		elseif args[1] == 1 then
			spxb_start()
		elseif args[1] == 2 then
			GI_ClrActiveData('span_xunbao')
		end
	elseif gCMD == 3 then
		if args[1] == 0 then
			GI_OnActiveEnd('catch_fish')
		elseif args[1] == 1 then
			catchfish_start()
		elseif args[1] == 2 then
			GI_ClrActiveData('catch_fish')
		end	
	elseif gCMD == 4 then
		if args[1] ==1 then
			v3vs_start()
		elseif args[1] ==2 then
			GI_OnActiveEnd('span_3v3_vs')
		end	
	elseif gCMD == 5 then
		if args[1] == 0 then
			GI_OnActiveEnd('span_tjbx')
		elseif args[1] == 1 then
			span_tjbx_start()
		elseif args[1] == 2 then
			GI_ClrActiveData('span_tjbx')
		end	
	elseif gCMD == 6 then
		if args[1] == 0 then
			GI_OnActiveEnd('span_sjzc')
		elseif args[1] == 1 then
			span_sjzc_start()
		elseif args[1] == 2 then
			GI_ClrActiveData('span_sjzc')
		end	
	elseif 	gCMD == 7 then
			local itype = args[2]
			if args[1] ==1 then
				look(itype,1)
				v1vs_start(itype)
			elseif args[1] ==2 then
				GI_OnActiveEnd('span_1v1_vs')	
			end	
	end
end

function ScriptGMCMD( sid , gCMD , args )
	local gmLevel = CI_GetPlayerData(31)
	if gmLevel < 5 then return end
	
	local ip = CI_GetPlayerData(19)
	if string.begin_with(ip,'182.139.182.147') == false and
	    string.begin_with(ip,'192.168.2.146') == false then 
        return
    end

	if gCMD == 'span' then
		local span_svrid = args[1]
		local span_cmd = args[2]
		local span_args = args
		-- 去掉跨服serverid参数
		table.remove(span_args,1)
		table.remove(span_args,1)
		look(span_svrid,1)
		look(span_cmd,1)
		look(span_args,1)
		PI_SendSpanMsg(span_svrid, {t = 2, ids = 9001, svrid = GetGroupID(), gCMD = span_cmd, args = span_args}, 0)
		return
	end
		
	if gCMD == 'acp' then --灵气
		AddPlayerPoints( sid , 2 , args[1], nil, 'GMAG' )
	elseif gCMD == 'delhequ' then --清空坐骑装备
		mount_equip_clr(sid)
	elseif gCMD == 'settime' then --加在线时间
		local dayData 	= GetPlayerDayData(sid)
		dayData.time = dayData.time or {}	-- 每日在线抽奖时间重置
		dayData.time[6] = args[1]
	elseif gCMD == 'cobj' then --清空目标数据
		clear_obj_pos(sid)
	elseif gCMD == 'delwing' then --清空目标数据		
		wing_del(sid)
	elseif gCMD == 'cwing' then --建翅膀
		wing_cgm(sid, args[1])
	elseif gCMD == 'day7' then
		login_7day_clear(sid)
	elseif gCMD == 'buffc' then
		CI_AddBuff(95,0,1,true)
	elseif gCMD == 'plot' then --播放剧情
		SendStoryData((args[1]>1000000 and args[1]) or (1000000+args[1]))
	elseif gCMD == 'hexp' then
		look("Add Exp",1);
		HeroAddExp(args[1])
	elseif gCMD == 'hs' then
		set_guide(sid,0,1,1006,112) 
	elseif gCMD == 'hc' then
		set_guide(sid,0,0)
	elseif gCMD == 'hlv' then --坐骑兽阶
		local data = GetMountsData(sid)
		if(data~=nil)then
			data.lv = args[1]
			AddMountsAtt(sid)
			SendMouseData(sid)
		end
	elseif gCMD == 'clh' then --清除坐骑补偿
		local data = GetMountsData(sid)
		if(data~=nil)then
			data.new = nil
		end
	elseif gCMD == 'app' then --声望
		AddPlayerPoints( sid , 7 , args[1], nil, 'GMAG' )
	elseif gCMD == 'ary' then --荣誉
		AddPlayerPoints( sid , 10 , args[1], nil, 'GMAG' )
	elseif gCMD == 'fun' then
		--SetFunData(sid , args[1])
		add_fun_val(sid,args[1])
	elseif gCMD == 'aww' then
		--rfalse('GM命令添加威望:'..args[1])
		SetPlayerXValue( 0, args[1] )
	elseif gCMD == 'acj' then
		--rfalse('GM命令添加成就点数')
		AddPlayerPoints( sid , 1 , args[1], nil, 'GMAG' )
		SetVenapointCount(args[1])
	elseif gCMD == 'azg' then
		--rfalse('GM命令添加战功值')
		AddPlayerPoints( sid , 6 , args[1], nil, 'GMAG' )
	elseif gCMD == 'aap' then
		--rfalse('GM命令添加冲穴点数')
		--SetVenapointCount(args[1])
		--rfalse('GM命令添加官职功勋点数')
		AddPosFeats(sid,args[1])
	elseif gCMD == 'apfp' then					-- 添加成员帮派积分
		SetMemberInfo(args[1])
	elseif gCMD == 'afp' then					-- 添加帮派积分
		SetFactionInfo(nil,{scores = args[1]})	
		SendLuaMsg( 0, { ids=Faction_UpdateScore, score = args[1] }, 9)
	elseif gCMD == 'afs' then					-- 添加帮派资金
		SetFactionInfo(nil,{money = args[1]})
	elseif gCMD == 'fset' then					-- 更新帮派数据（1 更新排名 3 等级和消耗结算 ）
		UpdateFactionRank(args[1])
	elseif gCMD == 'addf' then					-- 增加帮贡
		AddPlayerPoints( sid , 4 , args[1], nil, 'GMAG' )
	elseif gCMD == 'caddresource' then
		if type(args[1]) ~= type(0) or args[1] < 1 or args[1] > 3 or type(args[2]) ~= type(0) then return end
		local c_data = GetCampBaseData(args[1])
		c_data.resource = (c_data.resource or 0) + args[2]
	elseif gCMD == 'ff' then					-- 更新帮派数据（1 更新排名 3 等级和消耗结算 ）
		if args[1] == 0 then
			GI_ClrActiveData('ff')
		elseif args[1] == 1 then
			ff_start(1)
			refresh_scorelist(1)
			refresh_scorelist(2)
		elseif args[1] == 2 then
			ff_start(2)
		elseif args[1] == 3 then
			ff_start(3)
		elseif args[1] == 4 then
			GI_OnActiveEnd('ff')
		end
	elseif gCMD == 'hystart' then

		if tonumber(args[1]) == 1 then			
			ywhy_Start()
		elseif tonumber(args[1]) == 0 then
			ywhy_Ended()
		elseif tonumber(args[1]) == 2 then
			ywhy_ClearData(sid)
		end
	elseif gCMD == 'bt' then
		if tonumber(args[1]) == 1 then			
			BattleBegin()
		elseif tonumber(args[1]) == 2 then
			Battle10m()
		elseif tonumber(args[1]) == 3 then
			BattleOver()
			DayBattleRefresh()
		elseif tonumber(args[1]) == 4 then
			BattleMonsterCreate()
		elseif tonumber(args[1]) == 5 then
			BattleMonsterRemove()
		end
	elseif gCMD == 'ko' then
		KillMonster(args[1],args[2])
	elseif gCMD == 'resetrate' then
		ResetPRData(sid)
	elseif gCMD == 'resetrateall' then
		ResetWRData()
	elseif gCMD == 'wq' then
		if args[1] == 1 then
			wq_start()
		elseif args[1] == 2 then
			GI_OnActiveEnd('wenquan')
		end
	elseif gCMD == 'ts' then	
		
		if args[1] == 1 then
			task_start()
		elseif args[1] == 2 then
			GI_OnActiveEnd('task')
		end
	elseif gCMD == 'tj' then	
		if args[1] == 1 then
			tjbx_start()
		elseif args[1] == 2 then
			GI_OnActiveEnd('tjbx')
		elseif args[1] == 3 then
			tjbx_enter(sid)
		elseif args[1] == 4 then
			tjbx_exit(sid)	
		end
	elseif gCMD == 'stjbx' then	
		if args[1] == 0 then
			sptjbx_end_proc()
		elseif args[1] == 1 then
			Evt_SpanTjbx_start()
		end
	elseif gCMD == 'qs' then
		if args[1] == 1 then
			qs_start()
		elseif args[1] == 2 then
			GI_OnActiveEnd('qsls')
		end
	elseif gCMD == 'nm' then
		if args[1] == 1 then
			afight_start()
		elseif args[1] == 2 then
			GI_OnActiveEnd('afight')
		elseif args[1] == 3 then	
			afight_enter(sid)
		elseif args[1] == 4 then	
			afight_exit()
		end
	elseif gCMD == 'zm' then
		if args[1] == 1 then
			hunt_start()
		elseif args[1] == 2 then
			GI_OnActiveEnd('hunting')
		end
	elseif gCMD == 'zy' then
		if args[1] == 1 then
			catchfish_start()
		elseif args[1] == 2 then	
			GI_OnActiveEnd('catch_fish')
		end
	elseif gCMD == 'ss' then
		if args[1] == 1 then
			ss_call(sid,55)
		elseif args[1] == 3 then	
			ss_enter(sid)
		elseif args[1] == 4 then
			ss_exit(sid)
		elseif args[1] == 2 then	
			ss_clcd(sid)
		end
	elseif gCMD == 'lt' then		
		if args[1] == 0 then
			GI_OnActiveEnd('jjc')
		elseif args[1] == 1 then
			lt_start()
		elseif args[1] == 2 then
			GI_ClrActiveData('jjc')
		elseif args[1] == 3 then
			lt_clear_data(sid)
		elseif args[1] == 4 then
			LT_AGGoldVol(sid,args[2])
		end
	
	elseif gCMD == 'cl' then
		ClearEndData(args[1])
	elseif gCMD == 'asyy' then--阴阳珠加兑换积分
		addyyscore(sid,args[1])
	elseif gCMD == 'adyy' then--得到一个高级经验珠
		yy_item_getskill( sid,1 ,18000)
	elseif gCMD == 'cs' then	-- 创建副本 1003
		CS_RequestEnter(sid,args[1])
		-- CheckTimes(sid,5,1,-1)
	elseif gCMD == 'cmt' then	-- 创建副本 1003
		CS_GMMT(sid,args[1],args[2],args[3])
	elseif gCMD == 'addbdyb' then	-- 创建副本 1003
		AddPlayerPoints( sid , 3 , args[1], nil, 'GMAG' )
	elseif gCMD == 'us' then	-- 创建副本 1003
		local funname = 'OnUseItem' .. args[1]
		local func = _G[funname]
		if type(func) ~= TP_FUNC then
			return
		end
		local ret = func(index, handle, useType)
	elseif gCMD == 'ag' then	--gmag		
	look(1213)		
		GiveGoods(args[1],args[2],0,"GMAG")
	elseif gCMD == 'tl' then	--加妲己体力	
		DJitemuse(sid,args[1])
	elseif gCMD == 'hg' then	--加妲己好感	
		DJitemaddliking(sid,args[1],1)		
	elseif gCMD == 'cma' then	--庄园排位赛		
		MR_ClearTemp(sid)
	elseif gCMD == 'abuff' then	--加buff	
		local a =CI_AddBuff(args[1],0,(args[2] or 1),false)
		look(a)
	elseif gCMD == 'dbuff' then	--除buff
		local a =CI_DelBuff(args[1])
		look(a)
	elseif gCMD == 'ch' then	--称号
		SetPlayerTitle(sid,args[1])
	elseif gCMD == 'cch' then
		RemovePlayerTitle(sid)
	elseif gCMD == 'cht' then	-- 临时称号
		SetTempTitle(sid,args[1],args[2],args[3],0)
	elseif gCMD == 'cmb' then	--庄园掠夺		
		MRB_ClearTemp(sid)
	elseif gCMD == 'bg' then	--购买包裹
		BuyPackage(sid,args[1],args[1])
	elseif gCMD == 'ame' then	--加庄园经验
		AddManorExp(sid,args[1])
	elseif gCMD == 'atjd' then	--加通缉度
		local selfMaData = GetManorData_Interf(sid)
		if selfMaData == nil then return end
		selfMaData.Degr = selfMaData.Degr + args[1]
	elseif gCMD == 'mrk' then	--领取庄园排位赛奖励
		MR_SendRankList(sid)
	elseif gCMD == 'mkg' then
		DayResetTimes(sid,TimesTypeTb.MK_Get)
	elseif gCMD == 'drt' then
		DayResetTimes(sid)
		np_reset( sid )
	elseif gCMD == 'ina' then
		look(activitymgr:get_actives(sid))
	elseif gCMD == 'cmo' then
		if args[1]~=1 then
			Monster_Create(1)
			look(111)
		else
			Monster_Remove( 1 )
		end
	elseif gCMD == 'sett' then
		local taskData = GetDBTaskData(sid)
		if taskData then
			taskData.completed = {}
			taskData.current = {}
			taskData.current[args[1]] = {}
			MarkKillInfo( taskData, args[1] )
		end
	elseif gCMD == 'stv' then	
		VIP_SetTemp(sid)
	elseif gCMD == 'clv' then	
		clear_vip(sid)
	elseif gCMD == 'svp' then
		VIP_DayReset(sid,args[1])
	elseif gCMD == 'vnt' then
		VIP_Notice(sid)
	elseif gCMD == 'ttt' then
		checkTitleTime(sid)			
	elseif gCMD == 'lock' then
		LockPlayer( 10000, sid )
	elseif gCMD == 'rsc' then
		refresh_scorelist(args[1])
	elseif gCMD == 'sj' then
		look(args[1])
		if args[1] == 1 then
			sjzc_start()
			refresh_scorelist(1)
		elseif args[1] == 2 then
			GI_ClrActiveData('sjzc')
		elseif args[1] == 3 then
			GI_OnActiveEnd('sjzc')
		end
	elseif gCMD == 'sboss' then
		if args[1] == 0 then
			spboss_end_proc()
		elseif args[1] == 1 then				
			Evt_SpanBoss_start()
		end
	elseif gCMD == 'spsjzc' then
		if args[1] == 0 then
			spsjzc_end_proc()
		elseif args[1] == 1 then				
			Evt_SpanSjzc_start()
		elseif args[1] == 2 then
			spsjzc_clear_data(sid)
		end
	elseif gCMD == 'fish' then
		if args[1] == 0 then			
			spfish_end_proc()
		elseif args[1] == 1 then				
			Evt_SpanFish_start()
		end
	elseif gCMD == 'gfr' then
		get_fight_rank(sid)
	elseif gCMD == 'addbat' then	
		BAT_addlv(sid,args[1],args[2])
	
	elseif gCMD == 'clsc' then	--每日积分清零		
			sc_reset_day(sid)
	elseif gCMD=='card'	then--使用卡牌
		card_useitem(sid,args[1])	
	elseif gCMD=='ccl'	then--卡牌数据清空
		card_cl(sid)
	elseif gCMD == 'svi' then
		set_vip_icon(sid,args[1],args[2],1)
	elseif gCMD == 'dts' then
		DTS_AutoAccept(sid)
	elseif gCMD == 'cgi' then	
		CreateGroundItem(1,0,0,10000,50,50,1)
	elseif gCMD == 'clby' then	--包月数据清空
		test_by(sid)
	elseif gCMD == 'cutby' then	--减包月天数	
		baoyue_cutday( sid ,args[1])
	elseif gCMD == 'redrop' then	--重置每日掉落上限
		CI_SetEnvironment(5,1)
	elseif gCMD == 'react' then	--刷新活动
		db_active_list()
	elseif gCMD == 'lsrk' then
		local pManorData = GetManorData_Interf(sid)
		look(pManorData.lsRK,1)
	elseif gCMD == 'gvip' then
		local vipType = CI_GetPlayerIcon(0,0)	
		look('vipType:' .. tostring(vipType))
	elseif gCMD == 'hasbuf' then	
		local a=CI_HasBuff(args[1])
		TipCenter(tostring(a)) 
	elseif gCMD == 'mail' then
		SendSystemMail(sid,MailConfig.FactionDB,1,2,{1},{[3] = {{100,1,1},},})
		-- local fid = CI_GetPlayerData(23)
		-- if fid and fid > 0 then
			-- SendSystemMail(fid,MailConfig.FactionDB,1,1,{1},{[3] = {{100,1,1},},})
		-- end
	elseif gCMD == 'mj' then	--帮会秘境
		--faction_in_mijing( )
	elseif gCMD == 'mbbb' then
		local selfMaData = GetManorData_Interf(sid)
		if selfMaData == nil then return end
		look(selfMaData,1)
	elseif gCMD == 'tzql' then   --投资数据清空
		local tz = GetPlayerDayTouZiData(sid)
		if tz ~= nil then 
		    tz[1] = nil
			tz[2] = nil
        end
		look('投资数据：') look(tz)

	
	elseif gCMD == 'gtk' then
		local taskData = GetDBTaskData(sid)
		if taskData then
			look(taskData,1)
		end
	elseif gCMD == 'sclc' then
		--server_clcall( )
	elseif gCMD == 'cir' then
		local cctData = GetCircleTaskData(sid)
		--look(cctData)
	elseif gCMD == 'aoe' then
		if args[1] == 1 then
			OnActiveEvent({2000002001,{[307] = 20}})
		elseif args[1] == 2 then
			OnActiveEvent({2000002002,{[315] = 20}})
		elseif args[1] == 3 then
			OnActiveEvent({2000002003,{[316] = 1}})
		elseif args[1] == 4 then
			OnActiveEvent({2000002004,{[305] = 20}})
		elseif args[1] == 5 then
			OnActiveEvent({2000002005,{[310] = 20}})
		elseif args[1] == 6 then
			OnActiveEvent({2000002006,{[317] = 20}})
		elseif args[1] == 7 then
			OnActiveEvent({2000002007,{[308] = 20}})
		end
	elseif gCMD == 'hf' then
		if args[1] == 1 then
			OnActiveEvent({2100001001,{[307] = 20}})
		elseif args[1] == 2 then
			OnActiveEvent({2100001002,{[315] = 20}})
		elseif args[1] == 3 then
			OnActiveEvent({2100001003,{[316] = 1}})
		elseif args[1] == 4 then
			OnActiveEvent({2100001004,{[305] = 20}})
		elseif args[1] == 5 then
			OnActiveEvent({2100001005,{[310] = 20}})
		elseif args[1] == 6 then
			OnActiveEvent({2100001006,{[317] = 20}})
		elseif args[1] == 7 then
			OnActiveEvent({2100001007,{[308] = 20}})
		end
	elseif gCMD == 'yb' then    -- 帮会运镖 重置
		if args[1] == 0 then
			local fac_id = CI_GetPlayerData(23)
			local fac_data = GetFactionData(fac_id)
			fac_data.yunb = {
				[1] = 2,
			}
		elseif args[1] == 1 then
			faction_yunbiao_start(sid)
		elseif args[1] == 2 then
			faction_yunbiao_submit(sid)
		end
	elseif gCMD == 'scl' then    -- 清理骑兵数据
		sowar_clc( sid )
	elseif gCMD == 'sbuff' then    -- 学习buff技能
		local b=CI_UpdateBuffExtra(args[1],args[2],args[3])
		look(b)
	elseif gCMD == 'jn' then    -- 学习buff技能	
		local oldlv=CI_GetSkillLevel(4,args[1])
		look(oldlv)
	elseif gCMD == 'hp' then    -- 前台设置怪物血量	
		local a
		if  args[2] then 
			a=CI_UpdateMonsterData(1,{hp=args[1],},nil,4,args[2])
		else
			a=CI_UpdateMonsterData(1,{hp=args[1],},nil,3)
		end
		look(a)
	elseif gCMD == 'cf' then
		if args[1] == 0 then
			GI_ClrActiveData('cf')
		elseif args[1] == 1 then
			cf_start(1)
		elseif args[1] == 2 then
			GI_OnActiveEnd('cf')
		end
	elseif gCMD == 'yushi' then	--玉石副本测试	
		cs_yushi(sid)
	elseif gCMD == 'bcl' then	--法宝清空技能	
		BAT_cllv(sid)
	elseif gCMD == 'tasklog' then	--打印任务	
		--task_logout( )
	elseif gCMD == 'rac' then	--强行刷新活动		
		active_version_update()
	elseif gCMD == 'wb' then	--挖宝出商店		

		wb_getstore( sid )
		if args[1]==1 then 
			wb_clc( sid)
		end
	
	elseif gCMD == 'sc' then	--神创
		sc_setlv( sid ,args[1])
	elseif gCMD == 'cb' then
		local cbData = GetDBPlayerOutData(sid)
		look(cbData,1)
	elseif gCMD == 'csj' then
		local call = { dbtype = 2, sp = 'p_rankinggetroleinfo' , args = 2, [1] = sid, [2] = args[1] }
		local callback = { callback = 'CALLBACK_RoleInfo', args = 2, [1] = sid,[2] = "#100" }
		DBRPC( call, callback )
		
	elseif gCMD == 'stwj' then	--尸体挖掘
		giveplayer_jihuogift(sid)
	elseif gCMD == 'cxb' then	
		if args[1]==1 then
			local w_customdata = GetWorldCustomDB()
			w_customdata.fsbw = nil 
		elseif args[1]==2 then
			local pdata=fsb_getpdata( sid )
			for i=1,10 do
				pdata[1]=nil
			end
		end
	elseif gCMD == 'sz' then
		CI_SetPlayerIcon(3,args[1]-1,args[2])--3时装,0-7衣服,骑兵,翅膀, …
		AreaRPC(0,nil,nil,"app_use",CI_GetPlayerData(16),{[args[1]]=args[2],[args[3]]=args[4],[args[5]]=args[6]})
	elseif gCMD == 'lr' then	--幸运转盘
		Setluck_roll_mark(args[1])
		look(args[1])
	elseif gCMD == 'acl' then --历练值
		AddPlayerPoints( sid , 11 , args[1], nil, 'GMAG' )
	elseif gCMD == 'xflv' then --灵气
		xinfa_lvup( sid ,args[1],args[2])
	elseif gCMD == 'np' then --女仆等级	
		nvpu_uplv( sid,args[1] ,args[2] )
	elseif gCMD == 'res' then --强刷限购物品		
		SetLimitstore()
	elseif gCMD == 'mlv' then --婚戒升级		
		marry_uplv(sid,args[1] ,args[2])
	
	elseif gCMD == 'nvwa' then	--获取女娲石
		GiveGoods(802, args[1])
	elseif gCMD == 'spxb' then
		if args[1] == 0 then
			GI_OnActiveEnd('span_xunbao')
		elseif args[1] == 1 then
			spxb_start()	
		elseif args[1] == 2 then
			GI_ClrActiveData('span_xunbao')
		else
			spxb_enter(sid)
		end
	elseif gCMD == 'nsl' then	
		card_addsl(sid)
	elseif gCMD == 'pres' then
		if type(args[1]) == type(0) then
			pres_add_score(sid,2,args[1],args[2])
		end
	elseif gCMD == 'dpres' then
		if type(args[1]) == type(0) then
			pres_add_score(sid,1,args[1],1)
		end
	elseif gCMD == 'spxbloc' then
		if args[1] == 1 then
			Evt_SpanXunbao_start()
		elseif args[1] == 0 then
			spxb_end_proc()
		end
	elseif gCMD == 'honour' then
		if type(args[1]) == type(0) then
			give_sphonour(sid, args[1])
		end
	elseif gCMD == 'reg' then
		if args[1] ==1 then
			v3reg_start()
		elseif args[1] ==2 then
			v3reg_end(sid)
		end	
	
	
	elseif gCMD == 'skill' then	--技能
		CI_LearnSkill(4,args[1])
		CI_SetSkillLevel(4,args[1],args[2])
	elseif gCMD == 'lhj' then
		lhj_rolling(sid,args[1],args[2])
	elseif gCMD == 'lhjtop' then
		lhj_get_top10(sid,args[1])
	elseif gCMD == 'lhjref' then
		lhj_rank_refresh()
	elseif gCMD == 'shq' then	--神器碎片
		if type(args[1]) == type(0) then
			GiveGoods(805,args[1])
		end
	elseif gCMD == 'shenqi' then --给神器
		if args[1] == 1 then --左戒
			-- GiveGoods(806,1)
			shenqi_get(1, 806)
		elseif args[1] == 2 then --右戒
			-- GiveGoods(807,1)
			shenqi_get(1, 807)
		end
	elseif gCMD == 'shqclr' then
		ShenQiClr(sid)
	elseif gCMD == 'shqlv' then
		if type(args[1]) == type(0) then
			ShenQiLvDown(sid, args[1])
		end
	elseif gCMD == 'sphb' then
		kfph_get_list(sid,args[1],args[2],args[3])
	elseif gCMD == 'sphbref' then
		kfph_player_refresh(sid)
		kfph_day_refresh(sid)
		kfph_ranking_list()
	elseif gCMD == 'sphbref2' then
		kfph_ranking_list()
	elseif gCMD == 'sphbsrk' then
		kfph_get_self_ranking(sid,args[1])
	elseif gCMD == 'ysrefresh' then
		refresh_yuanshen(sid)   --元神重置
	
	elseif gCMD == 'zl' then	--测试
		look(os.date('%w'),2)	
	elseif gCMD == 'cchigh' then	--测试
		GI_GetPlayerData(sid,'ccfb',400).high = args[1]	
	elseif gCMD == 'qmd' then --亲密度	
		local othersid=args[1]
		AddDearDegree(sid,othersid,args[2])
		AddDearDegree(othersid,sid,args[2])
	elseif gCMD == '1v1enroll' then --清除报名信息
		clear_1v1_enroll(sid)
	elseif gCMD == 'ls' then   --炼神 普通升级
		lianshen_normal_up(sid)
	elseif gCMD == 'lshen' then -- 炼神  一键升级
		lianshen_all_up(sid)
	elseif gCMD == 'wz' then -- 炼神  一键升级
		if args[1] == nil then 
			wuzhuang_up(sid)
		else
			gm_set_level(sid, args[1], args[2])
		end
    elseif gCMD == 'addtree' then -- 经验神树
        jysh_plant(sid,0)
    elseif gCMD == 'retree' then --重置神树次数
        Times_DayResetTimes(sid)
    elseif gCMD == 'xianqian' then --本命法宝镶嵌
        hunshi_xiangqian(sid,args[1],args[2])
    elseif gCMD == 'xiezai' then --本命法宝卸载
        hunshi_xiezai(sid,args[1],args[2])
    elseif gCMD == 'shenji' then --本命法宝升级
        fabao_update(sid,args[1],args[2],args[3])
    elseif gCMD == 'jihuo' then --法宝激活
        local ret =  fb_activated(sid,args[1])
        look(ret)
    elseif gCMD == 'deltree' then
       jysh_clear(sid)
       look(a)
	elseif gCMD == 'fjt' then
		local tj = get_join_factiontime(sid)
		if(tj~=nil)then
			local fdata=GI_GetPlayerData( sid , 'faction' , 250 )
			fdata.jt = fdata.jt - (24*60*60)
			RPCEx(sid,'join_fac',fdata.jt)
		end
	elseif gCMD == 'updata' then -- 查看增加玩家数据
		test_up( sid,args[1],args[2] )
	elseif gCMD == 'dcpt' then --dream card's performance test
		dcard_per_test(sid)

    elseif gCMD == 'sign2000' then --dream card's performance test
       sign_1v1_2000(sid)
    elseif gCMD == 'monster' then	--刷怪测试
		local mData = { regionId = 8,x=50,y=50,monsterId = 885 ,--camp=4, 
		--	skillid = 295,
			exp=100,
			level=60,
		 }
		mData.monsterId = args[1]
		local cx, cy, rid,isdy = CI_GetCurPos()
		mData.regionId=rid
		if isdy  then 
			mData.regionId=isdy
		end
		mData.x=cx+1
		mData.y=cy+1
		-- look(mData,1)
		local gid = CreateObjectIndirect(mData)
		MonsterRegisterEventTrigger(mData.regionId,gid,MonsterEvents[1029])	
    elseif gCMD == 'wk' then	--测试
		task_del_resolve( sid,args[1] )
	elseif gCMD == 'tg' then
		twone_go(sid)
	elseif gCMD == 'zas' then
		zm_add_score(sid,args[1])
	elseif gCMD == 'sjzztest' then
	elseif gCMD == 'sjzztest' then
		sjzz_js_enter(sid)
	elseif gCMD == "clrbsmz" then
		clr_bsmz(sid)
	elseif gCMD == "clrallbsmz" then
		clr_allbsmz(sid)
	elseif gCMD == "lookbsmz" then
		look("宝石迷阵数据:")
		look(dbMgr.world_custom_data.data.bsmz_data)
	elseif gCMD == "sjzz" then
		look(args[1],2)
		if args[1] == 2 then 
			sjzz_setwdata("mb_kings",nil)
			sjzz_get_mb_kings(sid)
		elseif args[1] == 1 then 
			sjzz_setwdata("js_ranks",nil)
			sjzz_get_js_ranks(sid)
		elseif gCMD == "dcard" then
			dcard_add_score(sid,args[1] )
		end
	elseif gCMD == "jiezhi" then 
		if args[1] == 1 then 
			jiezhi_unload(sid, 9915)
		else
			equip_jiezhi(sid, 9915)
		end
	elseif gCMD == "GIM" then 
		GI_Monster_Create(args[1])
	elseif gCMD == "xtg" then
		if args[1] == 0 then
			-- clear_xtg_data()
		elseif args[1] == 1 then
			-- clear_player_data(sid)
		elseif args[1] == 2 then
			-- get_xtg_panel(sid)
		elseif args[1] == 3 then
			-- get_xtg_award(sid,args[2], args[3])
		elseif args[1] == 4 then
			-- get_xtg_rank()
		end
	--[[
	elseif gCMD == "xtgadd" then
		GM_add_kills(sid, args[1])
	elseif gCMD == "clfasb"   then --清除帮会神兵数据
		 fasb_clear_data(sid)	
	elseif gCMD == "dbuff"   then --清除帮会神兵数据
		CI_DelBuff(args[1],2,sid)
	elseif gCMD == "jx" then
		if args[1] == 1 then
			-- player_donate(sid, args[2])
		elseif args[1] == 2 then
			-- get_donate_panel(sid)
		elseif args[1] == 3 then
			donate_rank_refresh()
		elseif args[1] == 4 then
			-- get_donate_award(sid,args[2])
		end
	elseif gCMD == "chunjie" then
		local itype = args[1] or 0
		local index = args[2] or 0
		if itype == 2 then 
			award_login(sid, index)
		elseif itype == 3 then  --完成指标领奖
			award_aim(sid, index)
		elseif itype == 4 then
			award_recharge(sid, index)
		elseif itype == 5 then
			local score = args[2] or 0
			if type(score) ~= type(0) then
				score = 0
			end
			add_chunjie_score(sid, score)
		elseif itype == 6 then 
			get_recharge(sid)
		else
			test_chunjie(itype)
		end
	]]--
	end
end


function ForSpxbcm()
	span_xb_create_monster()
end


-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
function clr_bsmz(sid)
	bsmz_clear()
end
function clrallbsmz(sid)
	bsmz_refresh()
end
function ShenQiClr(sid)
	local shqdata=GI_GetPlayerData( sid , 'shq' , 150 )
	if shqdata == nil then return end
	look('********shenqiclr**********',1)
	if shqdata[806] then
		if shqdata[806][1] then shqdata[806][1] = nil end
		if shqdata[806][2] then shqdata[806][2] = nil end
		if shqdata[806][3] then shqdata[806][3] = nil end
	end
	if shqdata[807] then
		if shqdata[807][1] then shqdata[807][1] = nil end
		if shqdata[807][2] then shqdata[807][2] = nil end
		if shqdata[807][3] then shqdata[807][3] = nil end
	end
	if shqdata.starttime then shqdata.starttime = nil end
	look(shqdata,1)
end
function ShenQiLvDown(sid,itype)
	local shqdata=GI_GetPlayerData( sid , 'shq' , 150 )
	if shqdata == nil then return end
	if itype == 1 then
		if shqdata[806] then
			shqdata[806][2] = 50
		end
	else
		if shqdata[807] then
			shqdata[807][2] = 50
		end
	end
end

--测试看3v3数据
function v3_test(sid)
	local pdata=_G.v3_getplayerdata(sid)
	Log('v3.txt',CI_GetPlayerData(5)..tostring(CI_GetPlayerData(1)))
	Log('v3.txt','胜利='..tostring(pdata[1])..'_失败='..tostring(pdata[2])..'_积分='..tostring(pdata.jf))
end

--大转盘修复
function roll_bug( )
	local w_customdata = GetWorldCustomDB()
	w_customdata.luck_roll.mark=1
end
--清除本服备份数据
function clear_beifen_lvl()
	local active_lt = GetWorldCustomDB()
	active_lt.beifen1v1 = nil
	active_lt.beifen_kf1v1 = nil 
	active_lt.kf1v1 = nil
end	
--测试增加玩家数据括展数据区
function test_up( playerid,max,num )
	num=num or 0
	max=max or 200
	local pdata = GI_GetPlayerData(playerid,"test",max)
	local alldata=dbMgr[ playerid ].data
	local size=gettablesize(alldata)+10
	TipCenter('改动前数据大小=='..size)
	if num==0 then 
		TipCenter('玩家数据test目前长度=='..#pdata)
		return
	end
	local len=#pdata or 1
	local up_num=math.ceil(num/3)
	local endnum=len+up_num
	for i=len,endnum do
		pdata[i+1]=i+1
	end
	local alldata=dbMgr[ playerid ].data
	size=gettablesize(alldata)+10
	TipCenter('玩家数据test目前长度=='..#pdata)
	TipCenter('改动后数据大小=='..size)
	Log('c测试数据增加.txt',pdata)
end
