--update: 2014-08-26 ,add by sxj ,add bsmz, bsmz_update, updata _common_time_config
local sjzc_m = require('Script.active.sjzc')
 sjzc_start = sjzc_m.sjzc_start
local lt_module = require('Script.active.lt')
 lt_start = lt_module.lt_start
local wenquan 		= require('Script.active.wenquan')
 wq_start 	= wenquan.wq_start
local tjbx 		= require('Script.active.tjbx')
 tjbx_start 	= tjbx.tjbx_start
local qss 		= require('Script.active.qsls')
 qs_start 	= qss.qs_start
local ff_module = require("Script.active.faction_fight")
 ff_start = ff_module.ff_start
local catch_fish = require('Script.active.catch_fish')
 catchfish_start = catch_fish.catchfish_start
local hunting = require('Script.active.hunting')
 hunt_start = hunting.hunt_start
local task_a = require('Script.active.task_a')
 task_start = task_a.task_start
local spboss_m = require('Script.span_server.span_boss')
 sb_start = spboss_m.sb_start
local spxunbao_m = require('Script.span_server.span_xunbao')
 spxb_start = spxunbao_m.spxb_start
local sptjbx_m = require('Script.span_server.span_tjbx')
span_tjbx_start = sptjbx_m.span_tjbx_start
local spsjzc_m = require('Script.span_server.span_sjzc')
span_sjzc_start = spsjzc_m.span_sjzc_start
local bsmz_m = require("Script.bsmz.bsmz_fun")
bsmz_update = bsmz_m.bsmz_refresh
local xtg = require("Script.CopyScene.xtg")
clear_xtg_data = xtg.clear_xtg_data
local donate = require("Script.Player.player_donate")		-- 玩家捐献爵位系统
donate_day_clear = donate.donate_day_clear
--	活动系统的通用时间配置表

module(...)

-----------------------------------------------------
--inner:

local _common_time_config =	{
	{everyday = {0,01,10},func = "SI_DBDayRefresh" },		-- 每日调用存储过程处理函数
	{everyday = {0,01,15},func = "SI_UpdateWorldLevel"},	-- 更新世界等级
	{everyday = {0,05,10},func = "MakeLotconf" },			-- 抽奖库配置刷新
	{everyday = {0,00,5},func = "dofile",arg = 'store\\Limit_store.lua'},			-- 限购重加载
	{everyday = {0,00,10},func = "SetLimitstore" },			-- 重置调用函数生成3个限购商品
	{everyday = {23,59,50},func = "MRK_RankAward" },		-- 排位赛生成每日排位奖励(一定要在每日重置之前)
	{everyday = {0,01,00},func = "PI_SetEnvironment",arg = {5,1} },		-- 重置每日掉落上限
	{everyday = {5,01,10},func = "Run_Extra_Del" },						-- 清理托管数据
	{everyday = {0,00,00},func = "SI_refresh_scorelist",arg = 1 },					--每日活动排行榜刷新
	{WeekDay = {1},everyday = {0,01,20},func = "SI_refresh_scorelist",arg = 2 },	--每周活动排行榜刷新
	{MonthDay = {1},everyday = {0,01,30},func = "SI_refresh_scorelist",arg = 3 },	--每月活动排行榜刷新
	{everyday = {0,01,15},func = "active_version_update"},				--每日刷新运营活动
	{everyday = {23,59,55},func = "fsb_creatrank"},				--每日12点前生成昨日寻宝排行
	{everyday = {0,01,20},func = "Marry_ReserveBack"},				--预约婚宴返还
	-- {everyday = {0,01,25},func = "SpanActiveNotice"},				--跨服活动通知
	
	{everyday = {0,01,30},func = "faction_eday_refresh" },				--每天遍历帮会清理操作
	{WeekDay = {1},everyday = {0,01,50},func = "clear_ff_score" },		--每周清理帮会战积分
	{everyday = {0,01,25},func = "bsmz_update" },		--每天清除宝石迷阵数据
	{everyday = {2,01,00},func = "clear_xtg_data" },		--每天两点清除玄天阁数据
	{everyday = {0,00,10},func = "donate_day_clear" },		--每天清除捐献数据
	--{everyday = {0,00,10}, func = "update_chunjie_data"},  --每天强制刷新春节活动
	-- 跨服BOSS活动
	{everyday = {15,19,00},func = "spboss_start_proc"},
	{everyday = {15,50,30},func = "spboss_end_proc"},
	
	{everyday = {22,14,00},func = "spboss_start_proc"},
	{everyday = {22,45,30},func = "spboss_end_proc"},
	
	-- 跨服寻宝活动
	{everyday = {10,59,00},keepTime = 12*3600, func = "spxb_start_proc"},
	{everyday = {23,30,30},func = "spxb_end_proc"},
	
	--温泉开启  21:00 - 21:30 
	{everyday = {21,41,00},func = "wq_start", },	
	--曲水流觞开启 12:00 - 12:30
	{everyday = {12,01,00},func = "qs_start", },	
	--活动任务开启 16:00 - 17:00
	{everyday = {16,01,00},func = "task_start", },	

	--跨服三界夺宝  20:00 - 20:30 
	-- {WeekDay = {2,4,7},everyday = {19,59,00},func = "GI_Active_Start", arg = {'span_sjzc',1} },	
	-- {WeekDay = {2,4,7},everyday = {20,30,30},func = "GI_Active_Start", arg = {'span_sjzc',0} },
	
	--本服三界夺宝 20:00 - 20:30
	{WeekDay = {2,4,7},everyday = {20,01,00},func = "GI_Active_Start", arg = {'sjzc'} },	
	
	----竞技场  20:30 - 21:00
	--{everyday = {21,11,00},func = "GI_Active_Start", arg = {'jjc'} },

	--天降宝箱  14：10-14：40   21：10~21：40	 
	{everyday = {14,11,00},func = "tjbx_start",},
	{everyday = {21,11,00},func = "tjbx_start",},
	
	-- 跨服天降宝箱(开服7天后) 14：10-14：40   21：10~21：40
	-- {everyday = {14,09,00},func = "sptjbx_start_proc",},
	-- {everyday = {14,40,30},func = "sptjbx_end_proc",},	
	
	-- {everyday = {21,09,00},func = "sptjbx_start_proc",},
	-- {everyday = {21,40,30},func = "sptjbx_end_proc",},

	--帮会战   20:00 - 20:30 (注意：下面两个时间必须匹配)
	{WeekDay = {1,3,5},everyday = {19,46,00},func = "GI_Active_Start", arg = {'ff',0,1,'距离帮会战还有15分钟，请做好战前准备（如集结、结盟）'}, },
	{WeekDay = {1,3,5},everyday = {19,56,00},func = "GI_Active_Start", arg = {'ff',0,1,'距离帮会战还有5分钟，请做好战前准备（如集结、结盟）'}, },
	{WeekDay = {1,3,5},everyday = {20,00,55},func = "GI_Active_Start", arg = {'ff',0,2}, },
	{WeekDay = {1,3,5},everyday = {20,01,00},func = "GI_Active_Start", arg = {'ff',0,3}, },
	{WeekDay = {1,3,5,6},everyday = {23,59,59},func = "GI_Active_Start", arg = {'cl_union',0}, },
	--帮会战   20:00 - 20:30 (注意：下面两个时间必须匹配)
	{everyday = {19,46,00},func = "GI_Active_Start", arg = {'ff',1,1,'距离帮会战还有15分钟，请做好战前准备（如集结、结盟）'}, },
	{everyday = {19,56,00},func = "GI_Active_Start", arg = {'ff',1,1,'距离帮会战还有5分钟，请做好战前准备（如集结、结盟）'}, },
	{everyday = {20,00,55},func = "GI_Active_Start", arg = {'ff',1,2}, },
	{everyday = {20,01,00},func = "GI_Active_Start", arg = {'ff',1,3}, },
	{everyday = {23,59,59},func = "GI_Active_Start", arg = {'cl_union',1}, },
	--攻城战
	{WeekDay = {6},everyday = {20,01,00},func = "GI_Active_Start", arg = {'cf',0} },
	--攻城战
	{everyday = {20,01,00},func = "GI_Active_Start", arg = {'cf',1} },
		
	-- --新天宫狩猎 
	{everyday = {14,01,00},func = "hunt_start", },		
	{everyday = {21,01,00},func = "hunt_start", },		
	
	--设置巡防经验倍率--20倍
	{everyday = {18,31,00},func = "PI_Set_xunhang",arg = 10 },
	--取消巡防经验倍率--arg = 0
	{everyday = {19,01,00},func = "PI_Set_xunhang",arg = 0 },
	
	--海底捕鱼  11:15-11:45
	{everyday = {11,14,00},func = "spfish_start_proc",},
	{everyday = {11,45,30},func = "spfish_end_proc",},
	--海底捕鱼  22:15 - 22:45
	{everyday = {22,49,00},func = "spfish_start_proc",},
	{everyday = {23,20,30},func = "spfish_end_proc",},

	--本服3v3  
	{everyday = {12,01,00},func = "v3reg_start",},
	{everyday = {14,01,00},func = "v3reg_end",},
	{everyday = {18,01,00},func = "v3reg_start",},
	{everyday = {20,01,00},func = "v3reg_end",},
	
	--本服1v1报名
	{everyday = {8,01,00},func = "start_1v1",arg = 1},
	{everyday = {23,59,59},func = "end_1v1",arg = 1},
	
	--考虑到误差 本服比跨服延迟2分钟

	--跨服1v1广播,有活动时配置
	{dateex = {{2014,7,22,0,0,0},{2014,7,24,23,59,59}},everyday = {20,36,00},func = "TipABrodCast", arg = "诸神之战将在5分钟后开始，请报名参赛的玩家做好准备!"},
	--本服1v1海选
	{everyday = {20,40,55},func = "start_1v1",arg = 2},
	{everyday = {21,44,00},func = "end_1v1",arg = 2},
	--本服1v1预赛
	{everyday = {20,40,55},func = "start_1v1",arg = 3},
	{everyday = {21,23,00},func = "end_1v1",arg = 3},
	--本服1v1半决赛
	{everyday = {20,40,55},func = "start_1v1",arg = 4},
	{everyday = {21,23,00},func = "end_1v1",arg = 4},
	--本服1v1决赛
	{everyday = {20,40,55},func = "start_1v1",arg = 5},
	{everyday = {21,25,00},func = "end_1v1",arg = 5},
	
	--本服1v1活动炫耀
	{everyday = {00,01,00},func = "end_1v1",arg = 6},
	
	
	--本服1v1预赛活动竞猜
	{everyday = {08,00,00},func = "quiz_lv1_start",arg = 3},
	{everyday = {20,30,00},func = "quiz_lv1_end",arg = 3},	
	--本服1v1半决赛活动竞猜
	{everyday = {08,00,00},func = "quiz_lv1_start",arg = 4},
	{everyday = {20,30,00},func = "quiz_lv1_end",arg = 4},
	--本服1v1决赛活动竞猜
	{everyday = {08,00,00},func = "quiz_lv1_start",arg = 5},
	{everyday = {20,30,00},func = "quiz_lv1_end",arg = 5},
	
	
	--老虎机 更新排行
	{everyday = {00,01,00},func = "lhj_rank_refresh",},
	--跨服排行 更新排行
	{everyday = {00,15,00},func = "kfph_day_refresh",},
	--夫妻挑战副本 更新排行
	{everyday = {23,50,00},func = "cc_clean_ranks",},
	{everyday = {00,30,00},func = "cc_local_ranks",},
	
	--刷年兽
	-- {dateex = {{2014,1,28,0,0,0},{2014,2,10,23,59,59}},everyday = {15,00,00},func = "TipABrodCast", arg = "[活动]随着轰轰的爆竹声，年兽BOSS将在1分钟后出现在人间!"},
	-- {dateex = {{2014,1,28,0,0,0},{2014,2,10,23,59,59}},everyday = {15,20,00},func = "TipABrodCast", arg = "[活动]随着轰轰的爆竹声，年兽BOSS将在1分钟后出现在人间!"},
	-- {dateex = {{2014,1,28,0,0,0},{2014,2,10,23,59,59}},everyday = {15,40,00},func = "TipABrodCast", arg = "[活动]随着轰轰的爆竹声，年兽BOSS将在1分钟后出现在人间!"},
	-- {dateex = {{2014,1,28,0,0,0},{2014,2,10,23,59,59}},everyday = {15,01,00},func = "GI_Monster_Create", arg = 11 },
	-- {dateex = {{2014,1,28,0,0,0},{2014,2,10,23,59,59}},everyday = {15,21,00},func = "GI_Monster_Create", arg = 12 },
	-- {dateex = {{2014,1,28,0,0,0},{2014,2,10,23,59,59}},everyday = {15,41,00},func = "GI_Monster_Create", arg = 13 },
	--野外BOSS
	{everyday = {8,58,00},func = "TipABrodCast", arg = "[活动]野外BOSS将在三分钟后刷新!"},												
	{everyday = {9,01,00},func = "GI_Monster_Create", arg = 1 },
	{everyday = {10,58,00},func = "TipABrodCast", arg = "[活动]野外BOSS将在三分钟后刷新!"},												
	{everyday = {11,01,00},func = "GI_Monster_Create", arg = 1 },
	{everyday = {12,58,00},func = "TipABrodCast", arg = "[活动]野外BOSS将在三分钟后刷新!"},												
	{everyday = {13,01,00},func = "GI_Monster_Create", arg = 1 },
	{everyday = {14,58,00},func = "TipABrodCast", arg = "[活动]野外BOSS将在三分钟后刷新!"},												
	{everyday = {15,01,00},func = "GI_Monster_Create", arg = 1 },
	{everyday = {16,58,00},func = "TipABrodCast", arg = "[活动]野外BOSS将在三分钟后刷新!"},												
	{everyday = {17,01,00},func = "GI_Monster_Create", arg = 1 },
	{everyday = {18,58,00},func = "TipABrodCast", arg = "[活动]野外BOSS将在三分钟后刷新!"},												
	{everyday = {19,01,00},func = "GI_Monster_Create", arg = 1 },
	{everyday = {20,58,00},func = "TipABrodCast", arg = "[活动]野外BOSS将在三分钟后刷新!"},												
	{everyday = {21,01,00},func = "GI_Monster_Create", arg = 1 },
	{everyday = {22,58,00},func = "TipABrodCast", arg = "[活动]野外BOSS将在三分钟后刷新!"},												
	{everyday = {23,01,00},func = "GI_Monster_Create", arg = 1 },
	{everyday = {0,58,00},func = "TipABrodCast", arg = "[活动]野外BOSS将在三分钟后刷新!"},												
	{everyday = {1,01,00},func = "GI_Monster_Create", arg = 1 },
	

	--刷精英怪
	--{everyday = {0,08,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {0,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {1,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {1,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {2,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {2,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {3,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {3,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {4,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {4,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {5,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {5,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {6,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {6,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {7,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {7,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {8,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {8,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {9,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {9,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {10,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {10,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {11,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {11,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {12,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {12,30,00},func = "GI_Monster_Create", arg = 2 },
--	{everyday = {13,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {13,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {14,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {14,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {15,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {15,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {16,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {16,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {17,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {17,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {18,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {18,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {19,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {19,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {20,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {20,30,00},func = "GI_Monster_Create", arg = 2 },
	--{everyday = {21,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {21,30,00},func = "GI_Monster_Create", arg = 2 },
--	{everyday = {22,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {22,30,00},func = "GI_Monster_Create", arg = 2 },
--	{everyday = {23,01,00},func = "GI_Monster_Create", arg = 2 },
	{everyday = {23,30,00},func = "GI_Monster_Create", arg = 2 },
	
	-- 每小时生成排行榜
	{everyday = {0,00,30},func = "SI_DBHourRefresh"},
	{everyday = {1,00,30},func = "SI_DBHourRefresh"},
	{everyday = {2,00,30},func = "SI_DBHourRefresh"},
	{everyday = {3,00,30},func = "SI_DBHourRefresh"},
	{everyday = {4,00,30},func = "SI_DBHourRefresh"},
	{everyday = {5,00,30},func = "SI_DBHourRefresh"},
	{everyday = {6,00,30},func = "SI_DBHourRefresh"},
	{everyday = {7,00,30},func = "SI_DBHourRefresh"},
	{everyday = {8,00,30},func = "SI_DBHourRefresh"},
	{everyday = {9,00,30},func = "SI_DBHourRefresh"},
	{everyday = {10,00,30},func = "SI_DBHourRefresh"},
	{everyday = {11,00,30},func = "SI_DBHourRefresh"},
	{everyday = {12,00,30},func = "SI_DBHourRefresh"},
	{everyday = {13,00,30},func = "SI_DBHourRefresh"},
	{everyday = {14,00,30},func = "SI_DBHourRefresh"},
	{everyday = {15,00,30},func = "SI_DBHourRefresh"},
	{everyday = {16,00,30},func = "SI_DBHourRefresh"},
	{everyday = {17,00,30},func = "SI_DBHourRefresh"},
	{everyday = {18,00,30},func = "SI_DBHourRefresh"},
	{everyday = {19,00,30},func = "SI_DBHourRefresh"},
	{everyday = {20,00,30},func = "SI_DBHourRefresh"},
	{everyday = {21,00,30},func = "SI_DBHourRefresh"},
	{everyday = {22,00,30},func = "SI_DBHourRefresh"},
	{everyday = {23,00,30},func = "SI_DBHourRefresh"},
	
	{dateex = {{2015, 04, 21,0,0,0},{2015, 04,17,23,59,59}},everyday = {20,38,00},func = "sjzz_local_reset",},
	{dateex = {{2015, 04, 21,0,0,0},{2015, 04, 21,23,59,59}},everyday = {20,35,00},func = "sjzz_notify",arg = 1,},
	{dateex = {{2015, 04, 21,0,0,0},{2015, 04, 21,23,59,59}},everyday = {20,40,00},func = "sjzz_hx_start",},
	
	{dateex = {{2015, 04, 22,0,0,0},{2015, 04,22,23,59,59}},everyday = {20,35,00},func = "sjzz_notify",arg = 2,},
	{dateex = {{2015, 04, 22,0,0,0},{2015, 04,22,23,59,59}},everyday = {20,40,00},func = "sjzz_ys_start",},
	
	{dateex = {{2015, 04, 23,0,0,0},{2015, 04,23,23,59,59}},everyday = {20,35,00},func = "sjzz_notify",arg = 3,},
	{dateex = {{2015, 04, 23,0,0,0},{2015, 04,23,23,59,59}},everyday = {20,40,00},func = "sjzz_js_notify",},
	{dateex = {{2015, 04, 23,0,0,0},{2015, 04,23,23,59,59}}, everyday = {21,25,00},func = "sjzz_on_js_end",},

	{dateex = {{2015, 04, 24,0,0,0},{2015,04,24,23,59,59}},everyday = {00,00,00},func = "sjzz_mb_start",},
	{dateex = {{2015, 04, 26,0,0,0},{2015,04,26,23,59,59}},everyday = {23,59,59},func = "sjzz_mb_end",},
}


--跨服时间配置表
local _common_time_config_kuafu={
	-- 跨服BOSS活动(比本服提前1分钟开)
	{everyday = {15,18,00},func = "sb_start"},	
	{everyday = {22,13,00},func = "sb_start"},
	-- 跨服寻宝
	{everyday = {10,58,00},func = "spxb_start"},		
	--海底捕鱼  11:15-11:45
	{everyday = {11,13,00},func = "catchfish_start",},
	--海底捕鱼  11:15-11:45
	{everyday = {22,48,00},func = "catchfish_start",},
	
	-- -- 跨服天降宝箱 14：10-14：40
	-- {everyday = {14,08,00},func = "span_tjbx_start",},
	-- -- 跨服天降宝箱 21：10~21：40
	-- {everyday = {21,08,00},func = "span_tjbx_start",},

	-- 跨服3v3 11：00-13：00
	{everyday = {11,59,00},func = "v3vs_start",},
	-- 跨服3v3 18：00~20：00
	{everyday = {17,59,00},func = "v3vs_start",},
	--跨服1v1报名开始
	{everyday = {08,00,00},func = "v1vs_start",arg = 1},
	--跨服报名结束
	{everyday = {23,59,00},func = "v1vs_end",arg = 1 },
	--跨服1v1海选开始
	{everyday = {20,41,00},func = "v1vs_start",arg = 2},
	--跨服1v1海选结束
	{everyday = {21,42,00},func = "v1vs_end",arg = 2 },
	--跨服1v1预赛开始
	{everyday = {20,41,00},func = "v1vs_start",arg = 3},
	--跨服1v1预赛结束
	{everyday = {21,21,00},func = "v1vs_end",arg = 3 },
	--跨服1v1半决赛开始
	{everyday = {20,41,00},func = "v1vs_start",arg = 4},
	--跨服1v1半决赛结束
	{everyday = {21,21,00},func = "v1vs_end",arg = 4 },
	--跨服1v1决赛结束
	{everyday = {20,41,00},func = "v1vs_start",arg = 5},
	--跨服1v1决赛结束
	{everyday = {21,23,00},func = "v1vs_end",arg = 5 },
	--本服1v1活动全部结束
	{everyday = {00,01,00},func = "v1vs_end",arg = 6},
	
	--生成排行
	{everyday = {23,45,00},func = "kfph_ranking_list",},
	
	{everyday = {00,10,00},func = "cc_update_ranks",},
	
	--跨服三界战场(提前3分钟开)
	-- {WeekDay = {2,4,7},everyday = {19,58,00},func = "span_sjzc_start",},
	--跨服三界至尊
	{dateex = {{2015,04,21,0,0,0},{2015,04,21,23,59,59}},everyday = {20,38,00},func = "sjzz_span_reset",},
	{dateex = {{2015,04,23,0,0,0},{2015,04,23,23,59,59}},everyday = {20,40,00},func = "sjzz_js_start",},
}
	
------------------------------------------------------
--interface:
common_time_config = _common_time_config
common_time_config_kuafu = _common_time_config_kuafu

--下面配置更新公告-- 版本号在acb_ver()里面指定 ，格式由前台指定 ，内容策划维护。


