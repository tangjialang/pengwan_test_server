--[[
file:	message.lua
desc:	active script messages.
author:	chal
update:	2011-12-21
]]--

--------------------------------------------------------------------------
--include:
local msgDispatcher = msgDispatcher
local Boss_Info = msgh_s2c_def[12][1]
local ActiveConf_InitIDS = msgh_s2c_def[12][4]
local AcitveIcon_Info = msgh_s2c_def[12][5]
local fishing 		= require('Script.active.fishing')
local Fish_begin 	= fishing.Fish_begin
local Fish_result 	= fishing.Fish_result
local yushi 		= require('Script.active.yushi')
local Enter_ZXfb 	= yushi.Enter_ZXfb
local Chick_bengin 	= yushi.Chick_bengin
local zxfb_Exit 	= yushi.zxfb_Exit
local wenquan 		= require('Script.active.wenquan')
local wq_enter 		= wenquan.wq_enter
local wq_exit 		= wenquan.wq_exit
local wq_endjump 	= wenquan.wq_endjump
local wq_useitem 	= wenquan.wq_useitem
local qsls 		= require('Script.active.qsls')
local qs_enter 		= qsls.qs_enter
local qs_exit 		= qsls.qs_exit
local qs_answerback 	= qsls.qs_answerback
local qs_drunktop 	= qsls.qs_drunktop
local sjzc_m = require('Script.active.sjzc')
local sjzc_enter = sjzc_m.sjzc_enter
local sjzc_exit = sjzc_m.sjzc_exit
local sjzc_report_result = sjzc_m.sjzc_report_result
local sjzc_give_award = sjzc_m.sjzc_give_award
local lt_module = require('Script.active.lt')
local lt_putinto_map = lt_module.lt_putinto_map
local lt_sign_up = lt_module.lt_sign_up
local lt_panel_info = lt_module.lt_panel_info
local lt_enter = lt_module.lt_enter
local lt_exit = lt_module.lt_exit
local lt_send_viewlist = lt_module.lt_send_viewlist
local lt_viewer_enter = lt_module.lt_viewer_enter
local lt_cancle = lt_module.lt_cancle
local ff_module = require('Script.active.faction_fight')
local ff_panel_sign = ff_module.ff_panel_sign
local ff_sign_up = ff_module.ff_sign_up
local ff_enter = ff_module.ff_enter
local ff_build_tower = ff_module.ff_build_tower
local ff_exit = ff_module.ff_exit
local ff_report_result = ff_module.ff_report_result
local ff_give_award = ff_module.ff_give_award
local ff_occupy_flags = ff_module.ff_occupy_flags
local ff_get_score = ff_module.ff_get_score
local catch_fish 		= require('Script.active.catch_fish')
local catchfish_enter 		= catch_fish.catchfish_enter
local catchfish_exit 		= catch_fish.catchfish_exit
local get_fishaward 		= catch_fish.get_fishaward
local fish_buygold			=catch_fish.fish_buygold
local fish_getgold_everyday = catch_fish.fish_getgold_everyday
-- local catchfish_youyu=catch_fish.catchfish_youyu
local boss 		= require('Script.active.boss_active')
local getbossdata=boss.getbossdata
local hunting = require('Script.active.hunting')
local hunt_enter = hunting.hunt_enter
local hunt_exit = hunting.hunt_exit
local get_zmaward = hunting.get_zmaward
local faction_monster = require('Script.active.faction_monster')
local ss_enter = faction_monster.ss_enter
local ss_exit = faction_monster.ss_exit
local ss_call=faction_monster.ss_call
local ss_getaward = faction_monster.ss_getaward
local escort = require('Script.active.escort')
local es_getzfgoods=escort.es_getzfgoods
local refescort=escort.refescort
local startescort=escort.startescort
local endescort=escort.endescort
local es_ueslibao=escort.es_ueslibao
local pay_escortexponlive=escort.pay_escortexponlive
local af_m = require('Script.active.anonymity_fight')
local afight_enter = af_m.afight_enter
local afight_exit = af_m.afight_exit
local afight_give_award = af_m.afight_give_award
local afight_report_result= af_m.afight_report_result
local task_a = require('Script.active.task_a')
local task_enter = task_a.task_enter
local task_exit = task_a.task_exit
local kf_drx = require('Script.active.kf_drx')
local drx_give_award = kf_drx.drx_give_award
local kf_drx2 = require('Script.active.kf_drx_2')
local drx2_give_award = kf_drx2.drx2_give_award
local sg_module = require('Script.active.show_girl')
local get_show_girl = sg_module.get_show_girl
local first_c = require('Script.active.first_recharge')
local f_getaward=first_c.f_getaward
local cf_module = require('Script.active.city_fight')
local cf_enter = cf_module.cf_enter
local cf_exit = cf_module.cf_exit
local cf_add_buff = cf_module.cf_add_buff
local cf_report_result = cf_module.cf_report_result
local cf_give_award = cf_module.cf_give_award
local cf_eday_gift = cf_module.cf_eday_gift
local cf_up_buff = cf_module.cf_up_buff
local get_city_panel = cf_module.get_city_panel
local wbao = require('Script.active.wabao')
local wb_chick = wbao.wb_chick
local wb_getstore = wbao.wb_getstore
local wb_buy = wbao.wb_buy
local wb_drop=wbao.wb_drop
local tjbx 		= require('Script.active.tjbx')
local tjbx_enter 		= tjbx.tjbx_enter
local tjbx_exit 		= tjbx.tjbx_exit
local vipfuben = require('Script.active.vipfuben_wajue')
local vipfuben_bosswajue = vipfuben.boss_wajue
local jj_module = require('Script.active.jijin')
local jj_touzi=jj_module.jj_touzi
local jj_getyb_all=jj_module.jj_getyb_all
local jj_getaward=jj_module.jj_getaward
local jj_getworldlv=jj_module.jj_getworldlv
local pt_module = require('Script.active.plant_tree')
local plant_tree = pt_module.plant_tree
local gather_tree = pt_module.gather_tree
-----------------------------------------------
local chunjie_module = require('Script.active.chunjie_active')
local chunjie_rolling = chunjie_module.chunjie_rolling
local get_chunjie_info = chunjie_module.get_chunjie_info
---
local award_prize = chunjie_module.award_prize
local award_exchange = chunjie_module.award_exchange
local award_login = chunjie_module.award_login
local award_aim = chunjie_module.award_aim
local award_recharge = chunjie_module.award_recharge 
local get_recharge = chunjie_module.get_recharge
local award_seal = chunjie_module.award_seal

--------------------------------------------------------------------------
-- data:

function SendMainActive()
	if g_ShowActiveIcon and table.maxn(g_ShowActiveIcon) > 0 then
		SendLuaMsg( 0, { ids=AcitveIcon_Info, icon = g_ShowActiveIcon }, 9 )
	end
end

-- BOSS刷新状态
msgDispatcher[12][0] = function(playerid)
	getbossdata()
end

--点击挖宝
msgDispatcher[12][1] = function ( playerid ,msg )
	wb_chick(  playerid )
end
--点击出商店
msgDispatcher[12][2] = function ( playerid ,msg )
	wb_getstore(  playerid )
end

--贿赂
msgDispatcher[12][3] = function ( playerid ,msg )
	wb_drop(playerid)
end

--帮会活动，守卫杨再兴退出副本
msgDispatcher[12][4] = function ( playerid ,msg )
	Bphd_Swyzx_Exit(playerid)
end

--喝完酒的回调
msgDispatcher[12][5] = function ( playerid ,msg )
	Blxm_DrinkCallBack()
end

--获取运营活动信息
msgDispatcher[12][6] = function ( playerid ,msg )
	Active_SendData(playerid,msg.iType,msg.mainID,msg.ver)
end

--领取运营活动奖励
msgDispatcher[12][7] = function ( playerid ,msg )
	ActiveAwardCheck(playerid,msg.mainID,msg.subID)
end

--桃花迷阵
msgDispatcher[12][8] = function ( playerid ,msg )
	THMZ_VIPSubmit(playerid)
end
--领取微端登录奖励
msgDispatcher[12][9] = function ( playerid ,msg )
	Client_Login(playerid)
end

--传送进入帮会副本
msgDispatcher[12][10] = function ( playerid ,msg )
	Bpbw_Init()
end

--确定开启帮会副本
msgDispatcher[12][11] = function ( playerid ,msg )
	Bpbw_Init(true)
end

--进行投资
msgDispatcher[12][12] = function ( playerid ,msg )
	AI_RequstInvest(playerid,msg.Index)
end

--刷新投资项
msgDispatcher[12][13] = function ( playerid ,msg )
	AI_RefreshShow(playerid,msg.bItem)
end

--获取投资收益
msgDispatcher[12][14] = function ( playerid ,msg )
	AI_GetInvested(playerid,msg.bDirect)
end

--显示投资面板
msgDispatcher[12][15] = function ( playerid ,msg )
	AI_GetInvestData(playerid)
end

--显示投资列表
msgDispatcher[12][16] = function ( playerid ,msg )
	AI_GetInvestList(playerid,msg.refresh)
end

--掠夺投资
msgDispatcher[12][17] = function ( playerid ,msg )
	AI_Attack(playerid,msg.sidDef,msg.select,msg.bSure)
end

--响应掠夺
msgDispatcher[12][18] = function ( playerid ,msg )
	AI_BeAttack(msg.sidAtc,playerid,msg.op)
end

--领取掠夺奖励
msgDispatcher[12][19] = function ( playerid ,msg )
	AI_GetAtcAward(playerid)
end

--累充活动面板请求消息
msgDispatcher[12][20] = function ( playerid ,msg )	
	GetRecordActive(playerid)
end

--累充活动领取消息
msgDispatcher[12][21] = function ( playerid ,msg )	
	GiveRecordAward(playerid, msg.index)
end

--抓马活动进入
msgDispatcher[12][22] = function ( playerid ,msg )	
	hunt_enter(playerid,msg.mapGID)
end

--抓马退出
msgDispatcher[12][23] = function ( playerid ,msg )	
	hunt_exit( playerid )
end

--抓马领奖
msgDispatcher[12][24] = function ( playerid ,msg )	
	get_zmaward(playerid)
end

--曲水流觞进入
msgDispatcher[12][25] = function ( playerid ,msg )	
	qs_enter(playerid, msg.mapGID)
end

--曲水流觞退出
msgDispatcher[12][26] = function ( playerid ,msg )	
	qs_exit(playerid)
end

--答题结果
msgDispatcher[12][27] = function ( playerid ,msg )			
	qs_answerback(playerid,msg.res,msg.isuse)
end

--灌酒
msgDispatcher[12][28] = function ( playerid ,msg )		
	qs_drunktop(playerid,msg.nplayerid)
end
--请求充值消费信息
msgDispatcher[12][29] = function ( playerid ,msg )
	Getbuyfillinfo(playerid,msg.begintime,msg.endtime,msg.itype)
end
-- 跳下来
msgDispatcher[12][30] = function ( playerid ,msg )	
	wq_endjump(playerid)
end

-- 进入温泉房间
msgDispatcher[12][31] = function ( playerid ,msg )	
	wq_enter(playerid,msg.mapGID)
end

-- 温泉活动使用道具
msgDispatcher[12][32] = function ( playerid ,msg )	
	wq_useitem(playerid,msg.othersid,msg.index,msg.ftype)
end

-- 温泉活动玩家退出
msgDispatcher[12][33] = function ( playerid ,msg )	
	wq_exit(playerid,msg.roomindex)
end

--刷新镖车
msgDispatcher[12][34] = function ( playerid ,msg )	
	refescort(msg.times)
end

--开始运镖
msgDispatcher[12][35] = function ( playerid ,msg )	
	startescort()
end

--结束运镖
msgDispatcher[12][36] = function ( playerid ,msg )	
	endescort(false)
end

--进入擂台竞技场
msgDispatcher[12][38] = function ( playerid ,msg )	
	lt_putinto_map(playerid)
end

--擂台竞技场报名
msgDispatcher[12][39] = function ( playerid ,msg )		
	lt_sign_up(playerid)
end

-- 打开面板请求
msgDispatcher[12][40] = function ( playerid ,msg )	
	lt_panel_info(playerid)
end

-- 进入擂台赛
msgDispatcher[12][41] = function ( playerid ,msg )	
	lt_enter(playerid)
end

-- 擂台退出
msgDispatcher[12][42] = function ( playerid ,msg )	
	lt_exit(playerid,0)
end

msgDispatcher[12][43] = function ( playerid ,msg )	
	lt_send_viewlist(playerid)
end

msgDispatcher[12][44] = function ( playerid ,msg )	
	lt_viewer_enter(playerid,msg.gid)
end

msgDispatcher[12][46] = function ( playerid ,msg )	
	lt_cancle(playerid)
end
--访问摇钱树
msgDispatcher[12][47] = function ( playerid ,msg )	
	FindMoneyTree(msg.camp)
end
--摇钱
msgDispatcher[12][48] = function ( playerid ,msg )	
	BeginMoneyTree()
end
--收钱
msgDispatcher[12][49] = function ( playerid ,msg )	
	GetMoneyTree()
end
--抢收
msgDispatcher[12][50] = function ( playerid ,msg )	
	MoneyTreeFight()
end
--追加摇钱
msgDispatcher[12][51] = function ( playerid ,msg )	
	SetMoneyTree()
end
--传送回去
msgDispatcher[12][52] = function ( playerid ,msg )	
	MoneyTreeTran(playerid)
end
--点击钓鱼
msgDispatcher[12][53] = function ( playerid ,msg )	
	Fish_begin(playerid)
end
--钓鱼结果
msgDispatcher[12][54] = function ( playerid ,msg )	
	Fish_result(playerid,msg.succ)
end
-- --购买buff
-- msgDispatcher[12][55] = function ( playerid ,msg )
	-- ZX_buybuff(playerid)
-- end
--进紫星石副本
msgDispatcher[12][56] = function ( playerid ,msg )
	Enter_ZXfb(playerid)
end
--点击骰子
msgDispatcher[12][57] = function ( playerid ,msg )
	Chick_bengin(playerid,msg.time_n)
	-- Chick_bengin(playerid)
end
--退fuben
msgDispatcher[12][58] = function ( playerid ,msg )
	zxfb_Exit(playerid)
end
--运镖失败领奖
msgDispatcher[12][59] = function ( playerid ,msg )
	pay_escortexponlive(playerid)
end

--三界战场进入
msgDispatcher[12][60] = function ( playerid ,msg )
	sjzc_enter(playerid, msg.mapGID)
end

-- --三界战场本场积分排行榜
-- msgDispatcher[12][61] = function ( playerid ,msg )
	-- sjzc_get_list(playerid, msg.mapGID)
-- end

--三界战场退出
msgDispatcher[12][62] = function ( playerid ,msg )
	sjzc_exit(playerid)
end
--捕鱼活动进入
msgDispatcher[12][63] = function ( playerid ,msg )	
	catchfish_enter(playerid,msg.mapGID)
end

--捕鱼退出
msgDispatcher[12][64] = function ( playerid ,msg )	
	catchfish_exit( playerid )
end

--捕鱼领奖
msgDispatcher[12][65] = function ( playerid ,msg )	
	get_fishaward(playerid,msg.itype)
end

-- 三界战场结算面板
msgDispatcher[12][66] = function ( playerid ,msg )	
	sjzc_report_result(playerid)
end

-- 三界战场领奖
msgDispatcher[12][67] = function ( playerid ,msg )	
	sjzc_give_award(playerid)
end
--	神兽开启
msgDispatcher[12][68] = function ( playerid ,msg )	
	ss_call(playerid,msg.lv)
end

-- 进入神兽地图
msgDispatcher[12][69] = function ( playerid ,msg )	
	ss_enter(playerid)
end

-- 退出神兽地图
msgDispatcher[12][70] = function ( playerid ,msg )	
	ss_exit(playerid)
end
-- 神兽领奖
msgDispatcher[12][71] = function ( playerid ,msg )	
	ss_getaward(playerid)
end

-- 帮会战报名面板
msgDispatcher[12][72] = function ( playerid ,msg )	
	ff_panel_sign(playerid)
end

-- 帮会战报名
msgDispatcher[12][73] = function ( playerid ,msg )	
	ff_sign_up(playerid)
end

-- 帮会战进入
msgDispatcher[12][74] = function ( playerid ,msg )	
	ff_enter(playerid)
end

-- 修建箭塔
msgDispatcher[12][75] = function ( playerid ,msg )	
	ff_build_tower(playerid, msg.idx)
end

-- 离开帮会战
msgDispatcher[12][76] = function ( playerid ,msg )	
	ff_exit(playerid)
end

-- 帮会战结果面板
msgDispatcher[12][77] = function ( playerid ,msg )	
	ff_report_result(playerid)
end

-- 帮会战领取奖励
msgDispatcher[12][78] = function ( playerid ,msg )	
	ff_give_award(playerid)
end

-- 匿名战进入
msgDispatcher[12][79] = function ( playerid ,msg )	
	afight_enter(playerid)
end
-- 匿名战退出
msgDispatcher[12][80] = function ( playerid ,msg )	
	afight_exit(playerid)
end
-- 匿名战领奖
msgDispatcher[12][81] = function ( playerid ,msg )	
	afight_give_award(playerid)
end
-- 匿名战请求奖励
msgDispatcher[12][82] = function ( playerid ,msg )	
	afight_report_result(playerid)
end
-- 任务活动进入
msgDispatcher[12][83] = function ( playerid ,msg )	
	task_enter(playerid,msg.mapGID)
end
-- -- 任务活动退出
-- msgDispatcher[12][84] = function ( playerid ,msg )	
-- 	task_exit(playerid)
-- end
-- 帮会战占领旗帜
msgDispatcher[12][85] = function ( playerid ,msg )
	ff_occupy_flags(playerid)
end
-- 请求帮会当前积分
msgDispatcher[12][86] = function ( playerid ,msg )
	ff_get_score(playerid)
end
-- 捕鱼购买金币--怒气
msgDispatcher[12][87] = function ( playerid ,msg )
	fish_buygold(playerid)
end

-- 达人秀领取奖励
msgDispatcher[12][88] = function ( playerid ,msg )
	drx_give_award(playerid, msg.itype, msg.idx)
end
-- -- 每日领金币
msgDispatcher[12][89] = function ( playerid ,msg )
	fish_getgold_everyday(playerid)					-- 捕鱼恢复金币
end
-- 首冲领奖
msgDispatcher[12][90] = function ( playerid ,msg )
	f_getaward( playerid )
end

-- 达人秀2领取奖励
msgDispatcher[12][91] = function ( playerid ,msg )
	drx2_give_award(playerid, msg.itype, msg.idx)
end

-- show girl
msgDispatcher[12][92] = function ( playerid ,msg )
	get_show_girl(playerid)
end

-- 名人堂
msgDispatcher[12][93] = function ( playerid ,msg )
	SendHallOfFame(playerid)
end

-- 帮会攻城战(进入)
msgDispatcher[12][94] = function ( playerid ,msg )
	cf_enter(playerid)
end

-- 帮会攻城战(退出)
msgDispatcher[12][95] = function ( playerid ,msg )
	cf_exit(playerid)
end

-- 帮会攻城战(变身buff)
msgDispatcher[12][96] = function ( playerid ,msg )
	cf_add_buff(playerid,msg.cancel)
end

-- 帮会攻城战(奖励面板信息)
msgDispatcher[12][97] = function ( playerid ,msg )
	cf_report_result(playerid)
end

-- 帮会攻城战(领奖消息)
msgDispatcher[12][98] = function ( playerid ,msg )
	cf_give_award(playerid)
end

-- 帮会攻城战(每日礼包)
msgDispatcher[12][99] = function ( playerid ,msg )
	cf_eday_gift(playerid)
end

-- 帮会攻城战(升级弩车)
msgDispatcher[12][100] = function ( playerid ,msg )
	cf_up_buff(playerid)
end

-- 帮会攻城战(获取城主面板信息)
msgDispatcher[12][101] = function ( playerid ,msg )
	get_city_panel(playerid)
end

--挖宝副本购买
msgDispatcher[12][102] = function ( playerid ,msg )
	wb_buy(playerid,msg.num)
end
--海美人礼包祝福值领东西
msgDispatcher[12][103] = function ( playerid ,msg )
	es_getzfgoods(playerid)
end
--海美人礼包使用
msgDispatcher[12][104] = function ( playerid ,msg )
	es_ueslibao(playerid)
end
-- 取第一次登录时间
msgDispatcher[12][105] = function ( playerid ,msg )
	GetRegistTime(playerid)
end

--天降宝箱进入
msgDispatcher[12][106] = function ( playerid ,msg )
	tjbx_enter(playerid)
end
-- 天降宝箱退出
msgDispatcher[12][107] = function ( playerid ,msg )
	tjbx_exit(playerid)
end

--VIP副本挖尸体
msgDispatcher[12][108] = function ( playerid ,msg )
	vipfuben_bosswajue(playerid)
end
--取时间段内单笔充值记录
msgDispatcher[12][109] = function ( playerid ,msg )
	act_getsolochongzhi(playerid,msg.actid,msg.btime,msg.etime)
end
--取时间段内充值/消费排行榜
msgDispatcher[12][110] = function ( playerid ,msg )
	GetActiveRanklist(playerid,msg.mainID,msg.itype,msg.btime,msg.etime,msg.num)
end

-- 获取跨服BOSS大区列表
msgDispatcher[12][111] = function ( playerid ,msg )
	spboss_get_server()
end

--基金存入
msgDispatcher[12][112] = function ( playerid ,msg )
	jj_touzi(playerid,msg.num )
end
--基金领取奖励
msgDispatcher[12][113] = function ( playerid ,msg )
	jj_getaward( playerid,msg.itype,msg.index )
end
--基金取出总投资元宝
msgDispatcher[12][114] = function ( playerid ,msg )
	jj_getyb_all(playerid)
end

--种树
msgDispatcher[12][115] = function ( playerid ,msg )
	plant_tree(playerid,msg.index )
end
--种树领奖
msgDispatcher[12][116] = function ( playerid ,msg )
	gather_tree( playerid )
end

--取余额宝活动世界等级
msgDispatcher[12][117] = function ( playerid ,msg )
	jj_getworldlv()
end

-----------------------------------------------------------
-----春节活动
--春节抽奖得积分
msgDispatcher[12][120] = function ( playerid ,msg )
	chunjie_rolling(playerid, msg.times, msg.buy)
end
--领取积分档次奖励
msgDispatcher[12][121] = function ( playerid ,msg )
	award_prize(playerid, msg.level)
end
--积分兑换
msgDispatcher[12][122] = function ( playerid ,msg )
	award_exchange(playerid, msg.itemId, msg.index, msg.index1)
end
--
--获取详细信息
msgDispatcher[12][123] = function ( playerid ,msg )
	get_chunjie_info(playerid)
end

--登陆领奖
msgDispatcher[12][124] = function ( playerid ,msg )
	award_login(playerid, msg.index)
end

--完成指标领奖
msgDispatcher[12][125] = function ( playerid ,msg )
	award_aim(playerid, msg.index)
end

--充值领奖
msgDispatcher[12][126] = function ( playerid ,msg )
	award_recharge(playerid, msg.index)
end

--获取充值信息
msgDispatcher[12][127] = function ( playerid ,msg )
	get_recharge(playerid)
end

--领取印章
msgDispatcher[12][128] = function (playerid)
	award_seal(playerid)
end


