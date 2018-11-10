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
local donate = require("Script.Player.player_donate")		-- ��Ҿ��׾�λϵͳ
donate_day_clear = donate.donate_day_clear
--	�ϵͳ��ͨ��ʱ�����ñ�

module(...)

-----------------------------------------------------
--inner:

local _common_time_config =	{
	{everyday = {0,01,10},func = "SI_DBDayRefresh" },		-- ÿ�յ��ô洢���̴�����
	{everyday = {0,01,15},func = "SI_UpdateWorldLevel"},	-- ��������ȼ�
	{everyday = {0,05,10},func = "MakeLotconf" },			-- �齱������ˢ��
	{everyday = {0,00,5},func = "dofile",arg = 'store\\Limit_store.lua'},			-- �޹��ؼ���
	{everyday = {0,00,10},func = "SetLimitstore" },			-- ���õ��ú�������3���޹���Ʒ
	{everyday = {23,59,50},func = "MRK_RankAward" },		-- ��λ������ÿ����λ����(һ��Ҫ��ÿ������֮ǰ)
	{everyday = {0,01,00},func = "PI_SetEnvironment",arg = {5,1} },		-- ����ÿ�յ�������
	{everyday = {5,01,10},func = "Run_Extra_Del" },						-- �����й�����
	{everyday = {0,00,00},func = "SI_refresh_scorelist",arg = 1 },					--ÿ�ջ���а�ˢ��
	{WeekDay = {1},everyday = {0,01,20},func = "SI_refresh_scorelist",arg = 2 },	--ÿ�ܻ���а�ˢ��
	{MonthDay = {1},everyday = {0,01,30},func = "SI_refresh_scorelist",arg = 3 },	--ÿ�»���а�ˢ��
	{everyday = {0,01,15},func = "active_version_update"},				--ÿ��ˢ����Ӫ�
	{everyday = {23,59,55},func = "fsb_creatrank"},				--ÿ��12��ǰ��������Ѱ������
	{everyday = {0,01,20},func = "Marry_ReserveBack"},				--ԤԼ���緵��
	-- {everyday = {0,01,25},func = "SpanActiveNotice"},				--����֪ͨ
	
	{everyday = {0,01,30},func = "faction_eday_refresh" },				--ÿ���������������
	{WeekDay = {1},everyday = {0,01,50},func = "clear_ff_score" },		--ÿ��������ս����
	{everyday = {0,01,25},func = "bsmz_update" },		--ÿ�������ʯ��������
	{everyday = {2,01,00},func = "clear_xtg_data" },		--ÿ������������������
	{everyday = {0,00,10},func = "donate_day_clear" },		--ÿ�������������
	--{everyday = {0,00,10}, func = "update_chunjie_data"},  --ÿ��ǿ��ˢ�´��ڻ
	-- ���BOSS�
	{everyday = {15,19,00},func = "spboss_start_proc"},
	{everyday = {15,50,30},func = "spboss_end_proc"},
	
	{everyday = {22,14,00},func = "spboss_start_proc"},
	{everyday = {22,45,30},func = "spboss_end_proc"},
	
	-- ���Ѱ���
	{everyday = {10,59,00},keepTime = 12*3600, func = "spxb_start_proc"},
	{everyday = {23,30,30},func = "spxb_end_proc"},
	
	--��Ȫ����  21:00 - 21:30 
	{everyday = {21,41,00},func = "wq_start", },	
	--��ˮ�������� 12:00 - 12:30
	{everyday = {12,01,00},func = "qs_start", },	
	--������� 16:00 - 17:00
	{everyday = {16,01,00},func = "task_start", },	

	--�������ᱦ  20:00 - 20:30 
	-- {WeekDay = {2,4,7},everyday = {19,59,00},func = "GI_Active_Start", arg = {'span_sjzc',1} },	
	-- {WeekDay = {2,4,7},everyday = {20,30,30},func = "GI_Active_Start", arg = {'span_sjzc',0} },
	
	--��������ᱦ 20:00 - 20:30
	{WeekDay = {2,4,7},everyday = {20,01,00},func = "GI_Active_Start", arg = {'sjzc'} },	
	
	----������  20:30 - 21:00
	--{everyday = {21,11,00},func = "GI_Active_Start", arg = {'jjc'} },

	--�콵����  14��10-14��40   21��10~21��40	 
	{everyday = {14,11,00},func = "tjbx_start",},
	{everyday = {21,11,00},func = "tjbx_start",},
	
	-- ����콵����(����7���) 14��10-14��40   21��10~21��40
	-- {everyday = {14,09,00},func = "sptjbx_start_proc",},
	-- {everyday = {14,40,30},func = "sptjbx_end_proc",},	
	
	-- {everyday = {21,09,00},func = "sptjbx_start_proc",},
	-- {everyday = {21,40,30},func = "sptjbx_end_proc",},

	--���ս   20:00 - 20:30 (ע�⣺��������ʱ�����ƥ��)
	{WeekDay = {1,3,5},everyday = {19,46,00},func = "GI_Active_Start", arg = {'ff',0,1,'������ս����15���ӣ�������սǰ׼�����缯�ᡢ���ˣ�'}, },
	{WeekDay = {1,3,5},everyday = {19,56,00},func = "GI_Active_Start", arg = {'ff',0,1,'������ս����5���ӣ�������սǰ׼�����缯�ᡢ���ˣ�'}, },
	{WeekDay = {1,3,5},everyday = {20,00,55},func = "GI_Active_Start", arg = {'ff',0,2}, },
	{WeekDay = {1,3,5},everyday = {20,01,00},func = "GI_Active_Start", arg = {'ff',0,3}, },
	{WeekDay = {1,3,5,6},everyday = {23,59,59},func = "GI_Active_Start", arg = {'cl_union',0}, },
	--���ս   20:00 - 20:30 (ע�⣺��������ʱ�����ƥ��)
	{everyday = {19,46,00},func = "GI_Active_Start", arg = {'ff',1,1,'������ս����15���ӣ�������սǰ׼�����缯�ᡢ���ˣ�'}, },
	{everyday = {19,56,00},func = "GI_Active_Start", arg = {'ff',1,1,'������ս����5���ӣ�������սǰ׼�����缯�ᡢ���ˣ�'}, },
	{everyday = {20,00,55},func = "GI_Active_Start", arg = {'ff',1,2}, },
	{everyday = {20,01,00},func = "GI_Active_Start", arg = {'ff',1,3}, },
	{everyday = {23,59,59},func = "GI_Active_Start", arg = {'cl_union',1}, },
	--����ս
	{WeekDay = {6},everyday = {20,01,00},func = "GI_Active_Start", arg = {'cf',0} },
	--����ս
	{everyday = {20,01,00},func = "GI_Active_Start", arg = {'cf',1} },
		
	-- --���칬���� 
	{everyday = {14,01,00},func = "hunt_start", },		
	{everyday = {21,01,00},func = "hunt_start", },		
	
	--����Ѳ�����鱶��--20��
	{everyday = {18,31,00},func = "PI_Set_xunhang",arg = 10 },
	--ȡ��Ѳ�����鱶��--arg = 0
	{everyday = {19,01,00},func = "PI_Set_xunhang",arg = 0 },
	
	--���ײ���  11:15-11:45
	{everyday = {11,14,00},func = "spfish_start_proc",},
	{everyday = {11,45,30},func = "spfish_end_proc",},
	--���ײ���  22:15 - 22:45
	{everyday = {22,49,00},func = "spfish_start_proc",},
	{everyday = {23,20,30},func = "spfish_end_proc",},

	--����3v3  
	{everyday = {12,01,00},func = "v3reg_start",},
	{everyday = {14,01,00},func = "v3reg_end",},
	{everyday = {18,01,00},func = "v3reg_start",},
	{everyday = {20,01,00},func = "v3reg_end",},
	
	--����1v1����
	{everyday = {8,01,00},func = "start_1v1",arg = 1},
	{everyday = {23,59,59},func = "end_1v1",arg = 1},
	
	--���ǵ���� �����ȿ���ӳ�2����

	--���1v1�㲥,�лʱ����
	{dateex = {{2014,7,22,0,0,0},{2014,7,24,23,59,59}},everyday = {20,36,00},func = "TipABrodCast", arg = "����֮ս����5���Ӻ�ʼ���뱨���������������׼��!"},
	--����1v1��ѡ
	{everyday = {20,40,55},func = "start_1v1",arg = 2},
	{everyday = {21,44,00},func = "end_1v1",arg = 2},
	--����1v1Ԥ��
	{everyday = {20,40,55},func = "start_1v1",arg = 3},
	{everyday = {21,23,00},func = "end_1v1",arg = 3},
	--����1v1�����
	{everyday = {20,40,55},func = "start_1v1",arg = 4},
	{everyday = {21,23,00},func = "end_1v1",arg = 4},
	--����1v1����
	{everyday = {20,40,55},func = "start_1v1",arg = 5},
	{everyday = {21,25,00},func = "end_1v1",arg = 5},
	
	--����1v1���ҫ
	{everyday = {00,01,00},func = "end_1v1",arg = 6},
	
	
	--����1v1Ԥ�������
	{everyday = {08,00,00},func = "quiz_lv1_start",arg = 3},
	{everyday = {20,30,00},func = "quiz_lv1_end",arg = 3},	
	--����1v1����������
	{everyday = {08,00,00},func = "quiz_lv1_start",arg = 4},
	{everyday = {20,30,00},func = "quiz_lv1_end",arg = 4},
	--����1v1���������
	{everyday = {08,00,00},func = "quiz_lv1_start",arg = 5},
	{everyday = {20,30,00},func = "quiz_lv1_end",arg = 5},
	
	
	--�ϻ��� ��������
	{everyday = {00,01,00},func = "lhj_rank_refresh",},
	--������� ��������
	{everyday = {00,15,00},func = "kfph_day_refresh",},
	--������ս���� ��������
	{everyday = {23,50,00},func = "cc_clean_ranks",},
	{everyday = {00,30,00},func = "cc_local_ranks",},
	
	--ˢ����
	-- {dateex = {{2014,1,28,0,0,0},{2014,2,10,23,59,59}},everyday = {15,00,00},func = "TipABrodCast", arg = "[�]���ź��ı�����������BOSS����1���Ӻ�������˼�!"},
	-- {dateex = {{2014,1,28,0,0,0},{2014,2,10,23,59,59}},everyday = {15,20,00},func = "TipABrodCast", arg = "[�]���ź��ı�����������BOSS����1���Ӻ�������˼�!"},
	-- {dateex = {{2014,1,28,0,0,0},{2014,2,10,23,59,59}},everyday = {15,40,00},func = "TipABrodCast", arg = "[�]���ź��ı�����������BOSS����1���Ӻ�������˼�!"},
	-- {dateex = {{2014,1,28,0,0,0},{2014,2,10,23,59,59}},everyday = {15,01,00},func = "GI_Monster_Create", arg = 11 },
	-- {dateex = {{2014,1,28,0,0,0},{2014,2,10,23,59,59}},everyday = {15,21,00},func = "GI_Monster_Create", arg = 12 },
	-- {dateex = {{2014,1,28,0,0,0},{2014,2,10,23,59,59}},everyday = {15,41,00},func = "GI_Monster_Create", arg = 13 },
	--Ұ��BOSS
	{everyday = {8,58,00},func = "TipABrodCast", arg = "[�]Ұ��BOSS���������Ӻ�ˢ��!"},												
	{everyday = {9,01,00},func = "GI_Monster_Create", arg = 1 },
	{everyday = {10,58,00},func = "TipABrodCast", arg = "[�]Ұ��BOSS���������Ӻ�ˢ��!"},												
	{everyday = {11,01,00},func = "GI_Monster_Create", arg = 1 },
	{everyday = {12,58,00},func = "TipABrodCast", arg = "[�]Ұ��BOSS���������Ӻ�ˢ��!"},												
	{everyday = {13,01,00},func = "GI_Monster_Create", arg = 1 },
	{everyday = {14,58,00},func = "TipABrodCast", arg = "[�]Ұ��BOSS���������Ӻ�ˢ��!"},												
	{everyday = {15,01,00},func = "GI_Monster_Create", arg = 1 },
	{everyday = {16,58,00},func = "TipABrodCast", arg = "[�]Ұ��BOSS���������Ӻ�ˢ��!"},												
	{everyday = {17,01,00},func = "GI_Monster_Create", arg = 1 },
	{everyday = {18,58,00},func = "TipABrodCast", arg = "[�]Ұ��BOSS���������Ӻ�ˢ��!"},												
	{everyday = {19,01,00},func = "GI_Monster_Create", arg = 1 },
	{everyday = {20,58,00},func = "TipABrodCast", arg = "[�]Ұ��BOSS���������Ӻ�ˢ��!"},												
	{everyday = {21,01,00},func = "GI_Monster_Create", arg = 1 },
	{everyday = {22,58,00},func = "TipABrodCast", arg = "[�]Ұ��BOSS���������Ӻ�ˢ��!"},												
	{everyday = {23,01,00},func = "GI_Monster_Create", arg = 1 },
	{everyday = {0,58,00},func = "TipABrodCast", arg = "[�]Ұ��BOSS���������Ӻ�ˢ��!"},												
	{everyday = {1,01,00},func = "GI_Monster_Create", arg = 1 },
	

	--ˢ��Ӣ��
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
	
	-- ÿСʱ�������а�
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


--���ʱ�����ñ�
local _common_time_config_kuafu={
	-- ���BOSS�(�ȱ�����ǰ1���ӿ�)
	{everyday = {15,18,00},func = "sb_start"},	
	{everyday = {22,13,00},func = "sb_start"},
	-- ���Ѱ��
	{everyday = {10,58,00},func = "spxb_start"},		
	--���ײ���  11:15-11:45
	{everyday = {11,13,00},func = "catchfish_start",},
	--���ײ���  11:15-11:45
	{everyday = {22,48,00},func = "catchfish_start",},
	
	-- -- ����콵���� 14��10-14��40
	-- {everyday = {14,08,00},func = "span_tjbx_start",},
	-- -- ����콵���� 21��10~21��40
	-- {everyday = {21,08,00},func = "span_tjbx_start",},

	-- ���3v3 11��00-13��00
	{everyday = {11,59,00},func = "v3vs_start",},
	-- ���3v3 18��00~20��00
	{everyday = {17,59,00},func = "v3vs_start",},
	--���1v1������ʼ
	{everyday = {08,00,00},func = "v1vs_start",arg = 1},
	--�����������
	{everyday = {23,59,00},func = "v1vs_end",arg = 1 },
	--���1v1��ѡ��ʼ
	{everyday = {20,41,00},func = "v1vs_start",arg = 2},
	--���1v1��ѡ����
	{everyday = {21,42,00},func = "v1vs_end",arg = 2 },
	--���1v1Ԥ����ʼ
	{everyday = {20,41,00},func = "v1vs_start",arg = 3},
	--���1v1Ԥ������
	{everyday = {21,21,00},func = "v1vs_end",arg = 3 },
	--���1v1�������ʼ
	{everyday = {20,41,00},func = "v1vs_start",arg = 4},
	--���1v1���������
	{everyday = {21,21,00},func = "v1vs_end",arg = 4 },
	--���1v1��������
	{everyday = {20,41,00},func = "v1vs_start",arg = 5},
	--���1v1��������
	{everyday = {21,23,00},func = "v1vs_end",arg = 5 },
	--����1v1�ȫ������
	{everyday = {00,01,00},func = "v1vs_end",arg = 6},
	
	--��������
	{everyday = {23,45,00},func = "kfph_ranking_list",},
	
	{everyday = {00,10,00},func = "cc_update_ranks",},
	
	--�������ս��(��ǰ3���ӿ�)
	-- {WeekDay = {2,4,7},everyday = {19,58,00},func = "span_sjzc_start",},
	--�����������
	{dateex = {{2015,04,21,0,0,0},{2015,04,21,23,59,59}},everyday = {20,38,00},func = "sjzz_span_reset",},
	{dateex = {{2015,04,23,0,0,0},{2015,04,23,23,59,59}},everyday = {20,40,00},func = "sjzz_js_start",},
}
	
------------------------------------------------------
--interface:
common_time_config = _common_time_config
common_time_config_kuafu = _common_time_config_kuafu

--�������ø��¹���-- �汾����acb_ver()����ָ�� ����ʽ��ǰָ̨�� �����ݲ߻�ά����


