--[[
file: sjzc_active.lua
desc: ����ս��
autor: csj
update: 2013-7-13	
data:
	active_sjzc = {
		data[mapGID] = {
			c_camp = 1,		-- ��ǰ��Ӫ(������������Ӫ) [1] ��� [2] ħ�� [3] �˽�
			tops = {
				[1] = {score_m,name},			-- ��������� = ���������������
				[2] = {kill_m,name},			-- ��������� = �����ɱ����������
				[3] = {col_m,name},				-- ��������� = ������ɼ�������Ƭ��������
				[4] = {dead_m,name},			-- �ù��� = �������ɱ����������
			},
		},
		player[sid] = {		-- ���λ�������
			camp = 1,		-- ��ҵ�ǰ��Ӫ(��ڼ䲻�ı�)					
			dead_c = 1,		-- ��ǰ��������(������������buffer�ȼ�)
			score_m = 2,	-- ���λ����(���ڻ������������)
			kill_m = 2,		-- �ۼ�ɱ����(���ڻ����ɱ�������)
			col_m = 1,		-- �ɼ�������Ƭ��(���ڻ����ɼ�������Ƭ�������)
			dead_m = 1,		-- ���������������(���ڻ�����������������)					
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
local CI_GetPKList = CI_GetPKList
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
local sjzc_config = {
	monster = {
		[1] = {		-- ����Boss			
			{x = 88 , y = 13 ,dir = 5 ,controlId = 10100, deadScript = 4001, monsterId = 290, deadbody = 6 ,camp = 1},
			{x = 92 , y = 153 ,dir = 5 ,controlId = 10108, deadScript = 4001, monsterId = 291, deadbody = 6 ,camp = 2},
			{x = 3 , y = 83 ,dir = 5 ,controlId = 10116, deadScript = 4001, monsterId = 292, deadbody = 6 ,camp = 3},
		},					
		[2] = {		-- ���ط�����
			{x = 75 , y = 32 ,dir = 5 ,controlId = 10101, deadScript = 4001, monsterId = 293, deadbody = 6 ,camp = 1},
			{x = 74 , y = 26 ,dir = 5 ,controlId = 10102, deadScript = 4001, monsterId = 293, deadbody = 6 ,camp = 1},
			{x = 77 , y = 23 ,dir = 5 ,controlId = 10103, deadScript = 4001, monsterId = 293, deadbody = 6 ,camp = 1},
			{x = 81 , y = 22 ,dir = 5 ,controlId = 10104, deadScript = 4001, monsterId = 293, deadbody = 6 ,camp = 1},
			{x = 81 , y = 35 ,dir = 5 ,controlId = 10105, deadScript = 4001, monsterId = 293, deadbody = 6 ,camp = 1},
			{x = 84 , y = 34 ,dir = 5 ,controlId = 10106, deadScript = 4001, monsterId = 293, deadbody = 6 ,camp = 1},
			{x = 86 , y = 31 ,dir = 5 ,controlId = 10107, deadScript = 4001, monsterId = 293, deadbody = 6 ,camp = 1},
			{x = 86 , y = 25 ,dir = 5 ,controlId = 10138, deadScript = 4001, monsterId = 293, deadbody = 6 ,camp = 1},
			
			{x = 74 , y = 139 ,dir = 5 ,controlId = 10109, deadScript = 4001, monsterId = 294, deadbody = 6 ,camp = 2},
			{x = 78 , y = 135 ,dir = 5 ,controlId = 10110, deadScript = 4001, monsterId = 294, deadbody = 6 ,camp = 2},
			{x = 82 , y = 136 ,dir = 5 ,controlId = 10111, deadScript = 4001, monsterId = 294, deadbody = 6 ,camp = 2},
			{x = 85 , y = 141 ,dir = 5 ,controlId = 10112, deadScript = 4001, monsterId = 294, deadbody = 6 ,camp = 2},
			{x = 82 , y = 150 ,dir = 5 ,controlId = 10113, deadScript = 4001, monsterId = 294, deadbody = 6 ,camp = 2},
			{x = 78 , y = 151 ,dir = 5 ,controlId = 10114, deadScript = 4001, monsterId = 294, deadbody = 6 ,camp = 2},
			{x = 74 , y = 150 ,dir = 5 ,controlId = 10115, deadScript = 4001, monsterId = 294, deadbody = 6 ,camp = 2},
			{x = 71 , y = 145 ,dir = 5 ,controlId = 10137, deadScript = 4001, monsterId = 294, deadbody = 6 ,camp = 2},
			
			{x = 12 , y = 86 ,dir = 5 ,controlId = 10117, deadScript = 4001, monsterId = 295, deadbody = 6 ,camp = 3},
			{x = 12 , y = 80 ,dir = 5 ,controlId = 10118, deadScript = 4001, monsterId = 295, deadbody = 6 ,camp = 3},
			{x = 15 , y = 89 ,dir = 5 ,controlId = 10119, deadScript = 4001, monsterId = 295, deadbody = 6 ,camp = 3},
			{x = 15 , y = 78 ,dir = 5 ,controlId = 10120, deadScript = 4001, monsterId = 295, deadbody = 6 ,camp = 3},
			{x = 18 , y = 89 ,dir = 5 ,controlId = 10121, deadScript = 4001, monsterId = 295, deadbody = 6 ,camp = 3},
			{x = 18 , y = 78 ,dir = 5 ,controlId = 10122, deadScript = 4001, monsterId = 295, deadbody = 6 ,camp = 3},
			{x = 21 , y = 86 ,dir = 5 ,controlId = 10123, deadScript = 4001, monsterId = 295, deadbody = 6 ,camp = 3},
			{x = 21 , y = 81 ,dir = 5 ,controlId = 10136, deadScript = 4001, monsterId = 295, deadbody = 6 ,camp = 3},
		},
		[3] = {		-- ������
			--{BRMONSTER = 1, centerX = 69 , centerY = 72 , BRArea = 3 , BRNumber =2 , refreshTime =250, targetX =69, targetY =87, dir = 1 ,controlId = 10132, monsterId = 296, deadScript = 4002, deadbody = 6 ,camp = 1},			
			--{BRMONSTER = 1, centerX = 55 , centerY = 61 , BRArea = 3 , BRNumber =2 , refreshTime =250, targetX =46, targetY =65, dir = 1 ,controlId = 10134, monsterId = 296, deadScript = 4002, deadbody = 6 ,camp = 1},			
			--{BRMONSTER = 1, centerX = 60 , centerY = 108 , BRArea = 3 , BRNumber =2 , refreshTime =250, targetX =53, targetY =100, dir = 1 ,controlId = 10128, monsterId = 300, deadScript = 4002, deadbody = 6 ,camp = 2},			
			--{BRMONSTER = 1, centerX = 66 , centerY = 105 , BRArea = 3 , BRNumber =2 , refreshTime =250, targetX =68, targetY =89, dir = 1 ,controlId = 10130, monsterId = 300, deadScript = 4002, deadbody = 6 ,camp = 2},			
			--{BRMONSTER = 1, centerX = 33 , centerY = 76 , BRArea = 3 , BRNumber =2 , refreshTime =250, targetX =45, targetY =66, dir = 1 ,controlId = 10124, monsterId = 298, deadScript = 4002, deadbody = 6 ,camp = 3},			
			--{BRMONSTER = 1, centerX = 35 , centerY = 83 , BRArea = 3 , BRNumber =2 , refreshTime =250, targetX =52, targetY =99, dir = 1 ,controlId = 10126, monsterId = 298, deadScript = 4002, deadbody = 6 ,camp = 3},			
			
		},		
	},
	wlevel = {		-- ����ȼ��Թ�������Ӱ��
		[30] = {
			[1] = {[1] = 1000000 , [3] = 50000,[4] = 10000 , [5] = 5000,[6] = 5000 , [7] = 5000,[8] = 5000 , [9] = 5000, },
			[2] = {[1] = 1000000 , [3] = 5000,[4] = 3000 , [5] = 2500,[6] = 2500 , [7] = 2500,[8] = 2500 , [9] = 2500,},
			[3] = {[1] = 6000 , [3] = 1000,[4] = 1000 , [5] = 500,[6] = 500 , [7] = 500,[8] = 500 , [9] = 500, },	-- �����ֶ�������
		},
		[40] = {
			[1] = {[1] = 2000000 , [3] = 100000,[4] = 15000 , [5] = 6000,[6] = 6000 , [7] = 6000,[8] = 6000 , [9] = 6000,},
			[2] = {[1] = 2000000 , [3] = 10000,[4] = 5000 , [5] = 3000,[6] = 3000 , [7] = 3000,[8] = 3000 , [9] = 3000, },	
			[3] = {[1] = 8000 , [3] = 1200,[4] = 1200 , [5] = 800,[6] = 800 , [7] = 800,[8] = 800 , [9] = 800, },	-- �����ֶ�������
		},
		[50] = {
			[1] = {[1] = 3000000 , [3] = 150000,[4] = 20000 , [5] = 7000,[6] = 7000 , [7] = 7000,[8] = 7000 , [9] = 7000, },
			[2] = {[1] = 3000000 , [3] = 15000,[4] = 7000 , [5] = 4000,[6] = 4000 , [7] = 4000,[8] = 4000 , [9] = 4000, },
			[3] = {[1] = 10000 , [3] = 1300,[4] = 1300 , [5] = 1000,[6] = 1000 , [7] = 1000,[8] = 1000 , [9] = 1000, },	-- �����ֶ�������
		},
		[60] = {
			[1] = {[1] = 4000000 , [3] = 200000,[4] = 25000 , [5] = 8000,[6] = 8000 , [7] = 8000,[8] = 8000 , [9] = 8000, },
			[2] = {[1] = 4000000 , [3] = 20000,[4] = 9000 , [5] = 5000,[6] = 5000 , [7] = 5000,[8] = 5000 , [9] = 5000, },
			[3] = {[1] = 15000 , [3] = 1400,[4] = 1400 , [5] = 1200,[6] = 1200 , [7] = 1200,[8] = 1200 , [9] = 1200, },	-- �����ֶ�������
		},
		[70] = {
			[1] = {[1] = 5000000 , [3] = 250000,[4] = 30000 , [5] = 9000,[6] = 9000 , [7] = 9000,[8] = 9000 , [9] = 9000, },
			[2] = {[1] = 5000000 , [3] = 25000,[4] = 11000 , [5] = 6000,[6] = 6000 , [7] = 6000,[8] = 6000 , [9] = 6000, },
			[3] = {[1] = 20000 , [3] = 1400,[4] = 1400 , [5] = 1300,[6] = 1300 , [7] = 1300,[8] = 1300 , [9] = 1300, },	-- �����ֶ�������
		},
		[80] = {
			[1] = {[1] = 7000000 , [3] = 350000,[4] = 50000 , [5] = 20000,[6] = 19000 , [7] = 19000,[8] = 19000 , [9] = 19000, },
			[2] = {[1] = 7000000 , [3] = 35000,[4] = 31000 , [5] = 16000,[6] = 16000 , [7] = 16000,[8] = 16000 , [9] = 16000, },
			[3] = {[1] = 50000 , [3] = 1600,[4] = 1400 , [5] = 1300,[6] = 1300 , [7] = 1300,[8] = 1300 , [9] = 1300, },	-- �����ֶ�������
		},
	},
	box_monster = {
		{x = 56 , y = 73 ,EventID = 1, monAtt={[1] =500,},eventScript = 1011,deadScript = 4003, monsterId = 92, deadbody = 6 ,Priority_Except ={ selecttype = 2 , type =4  , target = 0 }},
		{x = 56 , y = 73 ,EventID = 1, monAtt={[1] =500,},eventScript = 1011,deadScript = 4004, monsterId = 91, deadbody = 6 ,Priority_Except ={ selecttype = 2 , type =4  , target = 0 }},
		{x = 56 , y = 73 ,EventID = 1, monAtt={[1] =500,},eventScript = 1011,deadScript = 4005, monsterId = 90, deadbody = 6 ,Priority_Except ={ selecttype = 2 , type =4  , target = 0 }},
	},
	npcinfo = {		-- NPC����
		[400301] = {{85,15},},
		[400302] = {{6,81},},
		[400303] = {{90,148},},
		--���
		[704000] = {{50,92},{51,92},{52,92},
		{70,87},{71,87},{72,87},
		{48,57},{49,57},{50,57},},
		--�ҳ���С��
		[705000] = {{49,91},{49,92},{49,93},{50,93},{51,94},
		{69,86},{69,87},{69,88},{70,88},
		{47,56},{47,57},{47,58},{48,58},{49,59},
		},
		--����С��
		[709000] = {{52,93},{53,93},{53,91},{53,92},
		{71,89},{72,88},{73,88},{73,87},{73,86},
		{50,58},{51,58},{51,57},{51,56},
		},
	},	
	buff_item = {
		[1141] = 22,
		[1142] = 2,
	},
	relive_pos = {
		[1] = {80,27},
		[2] = {80,141},
		[3] = {6,82},
	},
	-- ������ȼ����
	box_item = {
		[40] = {
			[1] = {5455,5492,5529,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,},   -- ͭ����
			[2] = {5344,5381,5418,5233,5270,5307,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053},   -- ������
			[3] = {5011,5048,5085,5122,5159,5196,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053},   -- ����
		},
		[50] = {
			[1] = {5459,5496,5533,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,},   -- ͭ����
			[2] = {5348,5385,5422,5237,5274,5311,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053},   -- ������
			[3] = {5015,5052,5089,5126,5163,5200,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053},   -- ����
		},
		[60] = {
			[1] = {5463,5500,5537,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,},   -- ͭ����
			[2] = {5352,5389,5426,5241,5278,5315,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053},   -- ������
			[3] = {5093,5130,5167,5204,5056,5019,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053},   -- ����
		},
		[70] = {
			[1] = {5467,5504,5541,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,},   -- ͭ����
			[2] = {5356,5393,5430,5245,5282,5319,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053},   -- ������
			[3] = {5097,5134,5171,5208,5060,5023,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053},   -- ����
		},
		[80] = {
			[1] = {1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,},   -- ͭ����
			[2] = {1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053},   -- ������
			[3] = {1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053,1053},   -- ����
		},
	},
}

---------------------------------------------------------------
--inner:

local active_name = 'sjzc'

local function get_sjzc_data()
	local custom = GetWorldCustomDB()
	if custom == nil then return end
	if custom.sjzc == nil then
		custom.sjzc = {}
	end
	return custom.sjzc
end

-- ��ȡ��ն�׶����ϵ�� (�����Է��ӷ�,ɱ���Լ�����)
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

-- ��ȡ�����
local function _get_tops()
	local common_data = get_sjzc_data()
	if common_data then
		return common_data.tops
	end
end

-- ���������
local function _update_tops(itype,val,name)
	if itype == nil or val == nil or name == nil then
		return
	end
	local common_data = get_sjzc_data()
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

-- ��ȡʤ����Ӫ
local function _get_win_camp()
	local common_data = get_sjzc_data()
	if common_data then
		return common_data.win
	end
end

-- ����ʤ����Ӫ
local function _set_win_camp()
	local common_data = get_sjzc_data()
	if common_data and common_data.camps then
		local t = common_data.camps
		local win
		local maxs = 0
		for i = 1, 3 do
			if (t[i] or 0) >= maxs then
				win = i
				maxs = t[i] or 0
			end
		end
		common_data.camps = nil		-- �����Ӫ��������
		common_data.win = win		-- ����ʤ����Ӫ
	end
	look(common_data)
end

-- ���ӻ����(��������ּ����а�/�ܻ���ּ����а�/������Ӫ����)
local function _add_score(sid,val)
	if sid == nil or val == nil then
		return
	end
	-- ��ѽ�������ӷ�����
	local active_sjzc = activitymgr:get(active_name)
	if active_sjzc == nil then			
		return
	end	
	-- ��ѽ�������ӷ�����
	local active_flags = active_sjzc:get_state()
	if active_flags == 0 then	
		return
	end
	local common_data = get_sjzc_data()
	if common_data == nil then
		look('_add_score get_common erro')
		return
	end	
	local my_data = active_sjzc:get_mydata(sid)
	if my_data == nil then
		look('_add_score get_mydata erro')
		return
	end
	-- ȡ�����Ϣ
	local camp = my_data.camp
	local name = CI_GetPlayerData(5,2,sid)
	local school = CI_GetPlayerData(2,2,sid)
	-- ���»���ּ����а�(ÿ�պ�ÿ��)
	look('val:' .. tostring(val))
	local day_score,week_score = sc_add(sid,6,val)
	look('day_score:' .. tostring(day_score))
	look('week_score:' .. tostring(week_score))
	insert_scorelist(1,6,20,day_score,name,camp,sid)		-- ����ÿ�����а�
	insert_scorelist(2,6,10,week_score,name,school,sid)		-- ����ÿ�����а�
	-- ������Ӫ����	
	common_data.camps = common_data.camps or {}
	local dt = common_data.camps
	dt[camp] = (dt[camp] or 0) + val
	-- ͬ����ҵ�ǰ���ָ�ǰ̨
	RPCEx(sid,'sjzc_update',day_score)
end

-- �����NPC
local function _npc_create(mapGID)
	look('_npc_create')
	local npc_conf = sjzc_config.npcinfo
	local CreateObjectIndirectEx = CreateObjectIndirectEx
	for npcid, pos in pairs(npc_conf) do
		look(npcid)
		local t = npclist[npcid]		
		if type(t) == type({}) then
			t.NpcCreate.regionId = mapGID
			local ret = CreateObjectIndirectEx(1,npcid,t.NpcCreate,#pos,pos)		-- ����NPC
			-- look('ret:' .. ret)
		end
	end
end

-- ��������ȼ��������Ӫ����
local function _monster_create(mapGID)
	look('_monster_create')
	local monster_conf = sjzc_config.monster
	local wlevel_conf = sjzc_config.wlevel
	local world_lv = GetWorldLevel() or 1 
	local tpos = table_locate(wlevel_conf,world_lv,2)
	look('_monster_create')
	look(tpos)
	if tpos == nil or wlevel_conf[tpos] == nil then		-- ����Ӧ�ò���ʧ��
		look('sjzc monster config erro')
		return
	end
	local CreateObjectIndirect = CreateObjectIndirect
	for idx, conf in ipairs(monster_conf) do
		if type(conf) == type({}) then
			for _, v in ipairs(conf) do
				v.regionId = mapGID						-- ���ù��ﳡ��ID
				v.level = tpos
				v.monAtt = wlevel_conf[tpos][idx]				
				local ret = CreateObjectIndirect(v)		-- ��������				
			end
		end
	end
end

-- ����Ԥ����(�����һ�����ӻ�û�������Զ��������Ƴ�)
local function _box_pre_proc(mapGID,box_c)
	if mapGID == nil or box_c == nil or box_c == 0 then
		return
	end
	local npcid
	if box_c == 1 then
		npcid = 400304
	elseif box_c == 2 then
		npcid = 400305
	elseif box_c == 3 then
		npcid = 400306
	end
	if npcid == nil then return end
	local cid = npcid + 100000
	-- ����Ѿ��������˾Ͳ��ô�����
	look(cid)
	look(mapGID)
	local ret = CI_SelectObject(6,cid,mapGID)
	if ret == nil or ret <= 0 then
		return
	end
	-- ���Ƴ�NPC
	RemoveObjectIndirect(mapGID, cid)
	-- ������(������ȼ����)	
	local box_conf = sjzc_config.box_item
	if box_conf == nil then 
		return
	end
	local wlevel = GetWorldLevel() or 1
	local pos = table_locate(box_conf,wlevel,2)
	look('pos:' .. pos)
	look('box_c:' .. box_c)
	if box_conf[pos] and box_conf[pos][box_c] then
		local count = 0
		local CreateGroundItem = CreateGroundItem
		for _, itemid in ipairs(box_conf[pos][box_c]) do
			look('CreateGroundItem:' .. mapGID)
			CreateGroundItem(0,mapGID,itemid,1,56,73,count)
			count = count + 1			
		end
	end
end

-- @arg: [1] ˢ��buff [2] ˢ�±��� [3] ������Ӫ����
local function _sjzc_traverse_region(mapGID,arg)
	if arg == 1 then		-- ˢ��buff
		local buff_conf = sjzc_config.buff_item
		if buff_conf == nil then 
			return
		end
		look('_sjzc_buff_refresh1111')
		local count = 0
		local CreateGroundItem = CreateGroundItem
		for itemid, num in pairs(buff_conf) do
			for i = 1, num do
				local r,x,y = RandPosSys_Get(4)
				if r and x and y then
					CreateGroundItem(0,mapGID,itemid,1,x,y,count)
					count = count + 1
				end
			end
		end
		RandPosSys_ReuseAll(4)
	elseif arg == 2 then		-- ˢ�±���
		local box_monster = sjzc_config.box_monster
		if box_monster == nil then 
			return
		end
		local common_data = get_sjzc_data()
		if common_data == nil then
			look('_sjzc_traverse_region get_common erro 2')
			return
		end
		common_data.box_c = common_data.box_c or 0
		common_data.box_c = common_data.box_c + 1
		local mc = box_monster[common_data.box_c]
		if mc then 
			mc.regionId = mapGID
			local mon_gid = CreateObjectIndirect(mc)
			if mon_gid and mc.EventID and mc.eventScript and mc.eventScript > 0 then
				MonsterRegisterEventTrigger( mc.regionId, mon_gid, MonsterEvents[mc.eventScript])
			end
			RegionRPC(mapGID,'szjc_notice',3,common_data.box_c)
		end			
	elseif arg == 3 then		-- ͬ����Ӫ����
		local common_data = get_sjzc_data()
		if common_data == nil then
			look('_sjzc_traverse_region get_common erro 3')
			return
		end
		if mapGID and common_data.camps then
			RegionRPC(mapGID,'sjzc_camp_score',common_data.camps)
		end
	end
end

-- ÿ5����ˢ��buff����
local function _sjzc_buff_refresh()
	look('_sjzc_buff_refresh')
	-- ��ѽ�������ˢ��buff
	local active_sjzc = activitymgr:get(active_name)
	if active_sjzc == nil then			
		return false
	end	
	-- ��ѽ�������ˢ��buff
	local active_flags = active_sjzc:get_state()
	if active_flags == 0 then	
		return false
	end
	active_sjzc:traverse_region(_sjzc_traverse_region,1)
	return true
end

-- ˢ�±���
local function _sjzc_box_refresh()
	look('_sjzc_buff_refresh')
	-- ��ѽ�������ˢ��box
	local active_sjzc = activitymgr:get(active_name)
	if active_sjzc == nil then			
		return false
	end	
	-- ��ѽ�������ˢ��box
	local active_flags = active_sjzc:get_state()
	if active_flags == 0 then	
		return false
	end
	active_sjzc:traverse_region(_sjzc_traverse_region,2)
	return true
end

-- ÿ30�������Ӫ����
local function _sjzc_camp_sync()
	-- ��ѽ�������ӷ�����
	local active_sjzc = activitymgr:get(active_name)
	if active_sjzc == nil then			
		return false
	end	

	active_sjzc:traverse_region(_sjzc_traverse_region,3)
	return true
end

-- �ύ��Դ����
local function _sjzc_submit_res(sid)
	-- ��ѽ�������ӷ�����
	local active_sjzc = activitymgr:get(active_name)
	if active_sjzc == nil then			
		return
	end	
	-- ��ѽ�������ӷ�����
	local active_flags = active_sjzc:get_state()
	if active_flags == 0 then	
		return
	end
	local my_data = active_sjzc:get_mydata(sid)
	if my_data == nil then
		return			
	end
	local res = GetTempTitle(sid,1,2)
	if res <= 0 then 
		return
	end
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		local info = GetStringMsg(14,1)
		TipCenter(info) 
		return
	end
	if res == 10 then
		GiveGoods(688,2,1,"��Ӫս��")
	end
	if res == 3 then
		GiveGoods(688,1,1,"��Ӫս��")
	end
	_add_score(sid,res*1)		-- һ����Ƭ1��
	-- �ύ��Դ������
	SetTempTitle(sid,1,2,0,0)
	-- ���BUFF
	CI_DelBuff(169,2,sid)
	-- �������������
	local name = CI_GetPlayerData(5,2,sid)
	my_data.col_m = (my_data.col_m or 0) + res
	_update_tops(3,my_data.col_m,name)
end

-- �ɼ�NPC�ص�
local function _sjzc_on_collect(cid)
	if cid == nil then return end
	-- ��ѽ�������ӷ�����
	local active_sjzc = activitymgr:get(active_name)
	if active_sjzc == nil then			
		return
	end	
	-- ��ѽ�������ӷ�����
	local active_flags = active_sjzc:get_state()
	if active_flags == 0 then	
		return
	end
	-- -- �ж��Ƿ��Ѿ����ɼ���
	-- local state = CI_GetNpcData(1,6,cid)
	-- if state == 1 then
		-- return
	-- end
	-- local _,_,_,mapGID = CI_GetCurPos()
	-- -- ����npc״̬�Ѳɼ�
	-- local ret = CI_UpdateNpcData(2,true,6,cid)	
	-- AreaRPC(6,cid,mapGID,'update_npc_collect',cid,true)
	-- SetEvent(10,nil,'GI_sjzc_update_collect',cid,mapGID)	-- 10������Ϊ�ɲɼ�
	-- ȡnpcid
	local npcid = GetNpcidByUID(cid)
	if npcid == nil then return end
	
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then 
		return
	end
	local res = GetTempTitle(sid,1,2)
	if res > 0 then
		return
	end
	if CI_HasBuff(169,2,sid) then
		return
	end
	-- if npcid == 704000 then
		-- SetTempTitle(sid,1,2,10,1)
	-- elseif npcid == 705000 then
		-- SetTempTitle(sid,1,2,10,1)
	-- end
	-- ����10��
	SetTempTitle(sid,1,2,10,1)
	CI_AddBuff(169,0,1,false,2,sid)
end

-- ��������
local function _sjzc_box_open(idx,mapGID)
	look('_sjzc_box_open 1')
	-- ��ѽ���
	local active_sjzc = activitymgr:get(active_name)
	if active_sjzc == nil then			
		return
	end	
	-- ��ѽ���
	local active_flags = active_sjzc:get_state()
	if active_flags == 0 then	
		return
	end
	local common_data = get_sjzc_data()
	if common_data == nil or common_data.box_c == nil then
		look('_sjzc_box_open get_common erro')
		return
	end		
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then
		return
	end	
	look('_sjzc_box_open 4')
	local my_data = active_sjzc:get_mydata(sid)
	if my_data == nil then
		look('_sjzc_box_open get_mydata erro')
		return
	end
	look('_sjzc_box_open 5')
	-- ������(������ȼ����)	
	local box_conf = sjzc_config.box_item
	if box_conf == nil then 
		return
	end
	local wlevel = GetWorldLevel() or 1
	local pos = table_locate(box_conf,wlevel,2)
	
	if box_conf[pos] and box_conf[pos][idx] then
		local count = 0
		local CreateGroundItem = CreateGroundItem
		for _, itemid in ipairs(box_conf[pos][idx]) do
			CreateGroundItem(0,mapGID,itemid,1,56,73,count)
			count = count + 1			
		end
	end
	-- ���¸��˻��ֺ���Ӫ����
	local camp_score = 0
	local player_score = 0
	if idx == 1 then
		player_score = 100
		camp_score = 300
	elseif idx == 2 then
		player_score = 200
		camp_score = 400
	elseif idx == 3 then
		player_score = 300
		camp_score = 500
	end
	-- ���¸��˻���
	_add_score(sid,player_score)
	-- ������Ӫ����
	local camp = my_data.camp
	common_data.camps = common_data.camps or {}
	local dt = common_data.camps
	dt[camp] = (dt[camp] or 0) + camp_score
	
	-- �㲥
	local pname = CI_GetPlayerData(5,2,sid)
	RegionRPC(mapGID,'szjc_notice',2,pname,idx)
end

-- �����ϴλ����
local function _clear_active_common()
	local common_data = get_sjzc_data()
	if common_data == nil then
		look('_clear_active_common get_common erro')
		return
	end	
	common_data.camps = nil
	common_data.win = nil
	common_data.tops = nil
	common_data.box_c = nil
end

-- ������������
local function _on_regioncreate(slef,mapGID)
	look('_on_regioncreate')	
	_npc_create(mapGID)			-- �����npc
	_monster_create(mapGID)		-- ���������		
end

-- �����л�����
local function _on_regionchange(slef,sid)
	look('_on_regionchange')
	-- ��������Ƭ����ն
	ClrTempTitle(sid)
	CI_DelBuff(169,2,sid)
end

-- ��������
local function _on_playerdead(self,deader_sid,rid,mapGID,killer_sid)
	look('_on_playerdead')
	if deader_sid == nil or mapGID == nil then 
		look('_on_playerdead callback param erro')
		return
	end	
	-- ��ѽ�������ӷ�����
	local active_sjzc = activitymgr:get(active_name)
	if active_sjzc == nil then			
		return
	end	
	-- ��ѽ�������ӷ�����
	local active_flags = active_sjzc:get_state()
	if active_flags == 0 then	
		return
	end
	-- ��ȡ����data
	local region_data = active_sjzc:get_regiondata(mapGID)
	if region_data == nil then
		look('_sjzc_buff_refresh get_regiondata erro')
		return false
	end
	local deader_data = active_sjzc:get_mydata(deader_sid)
	if deader_data == nil then
		look('_on_playerdead get get_mydata erro')
		return
	end
	-- �������� +2 ���·���
	_add_score(deader_sid,2)
	look('CI_HasBuff')
	-- ������������ +1 (���¸���buff)
	if not CI_HasBuff(241,2,deader_sid) then		-- ����Ѿ�û��Buff�˾��ִ�0��ʼ
		deader_data.dead_c = 0
	end
	deader_data.dead_c = (deader_data.dead_c or 0) + 1
	if deader_data.dead_c > 10 then deader_data.dead_c = 10 end
	-- ���� +buffer
	look(deader_data.dead_c)
	look(deader_sid)
	look('CI_AddBuff')
	CI_AddBuff(241,0,deader_data.dead_c,false,2,deader_sid)
	-- ���λ���������� +1 (�����ù���)
	deader_data.dead_m = (deader_data.dead_m or 0) + 1
	local deader_name = CI_GetPlayerData(5,2,deader_sid)
	_update_tops(4,deader_data.dead_m,deader_name)
	-- �������ս���ն��
	local deader_kill_c = GetTempTitle(deader_sid,1,1) or 0		-- ��ȡ�������˵ĵ�ǰ��ն��
	SetTempTitle(deader_sid,1,1,0,0)
	-- �������ͷ����Դ(10 - 7 = 3)
	local deader_res = GetTempTitle(deader_sid,1,2) or 0		-- ��ȡ�������˵ĵ�ǰ��Դ��
	if deader_res == 10 then
		SetTempTitle(deader_sid,1,2,3,0)
	end
	
	-- ɱ���� 
	if killer_sid and killer_sid > 0 then
		local killer_data = active_sjzc:get_mydata(killer_sid)
		if killer_data == nil then
			look('_on_playerdead get killer data erro')
			return
		end
		-- �Է���ն����Ӧ���� * �Լ���նϵ��
		local base = get_kills_pos(deader_kill_c) 					-- ���������ߵ�ǰ��ն��û�������
		local killer_kill_c = GetTempTitle(killer_sid,1,1) or 0
		local _, radio = get_kills_pos(killer_kill_c) 				-- ����ɱ���ߵ�ǰ��ն��û��ֱ���
		local score = (base or 10) * (radio or 1)
		_add_score(killer_sid,score)		-- ���·���
		-- ��նɱ���� +1
		SetTempTitle(killer_sid,1,1,1,1)
		-- ������ɱ���� +1 (�������������)
		killer_data.kill_m = (killer_data.kill_m or 0) + 1
		local killer_name = CI_GetPlayerData(5,2,killer_sid)
		_update_tops(2,killer_data.kill_m,killer_name)
		-- �Ӷ���Դ
		-- if deader_res > 0 then
			-- SetTempTitle(killer_sid,1,2,deader_res,1)
		-- end
		-- ����и���buff �Ƴ�֮��
		CI_DelBuff(241,2,killer_sid)
		killer_data.dead_c = 0	-- ���������λɱ����������������
		if deader_kill_c >= 5 then
			RegionRPC(mapGID,'szjc_notice',1,killer_name,deader_name,deader_kill_c)
		end
	end
	-- ȡ�������б� +1��
	local zglist = CI_GetPKList(20,5)
	look('zglist++++++++++++++++')
	look(zglist)
	if type(zglist) == type({}) then
		for _, pid in pairs(zglist) do
			if pid ~= killer_sid then		-- ��ɱ���߲żӻ���
				_add_score(pid,1)
			end
		end
	end
end

-- ��Ҹ����
local function _on_playerlive(self,sid)	
	look('_on_playerlive')
	local active_sjzc = activitymgr:get(active_name)
	if active_sjzc == nil then 
		look('_on_playerlive active_sjzc == nil')
		return 
	end
	-- get active player data
	local my_data = active_sjzc:get_mydata(sid)
	if my_data == nil then
		look('_on_playerlive get_mydata erro')
		return
	end
	local mycamp = my_data.camp
	if mycamp == nil then return end
	local pos = sjzc_config.relive_pos
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

-- ����ս�����ߴ���
local function _on_login(self,sid)
	local active_sjzc = activitymgr:get(active_name)
	if active_sjzc == nil then
		look('_on_login sjzc has end')		
		return
	end
	local common_data = get_sjzc_data()
	if common_data == nil then		
		return
	end
	-- ����ͬ����Ӫ����
	if common_data.camps then
		active_sjzc:traverse_region(_sjzc_traverse_region,3)
	end
end

-- ����ս�����ߴ���
local function _on_logout(self,sid)
	look('sjzc _on_logout')
	-- ��������Ƭ����ն
	ClrTempTitle(sid)
	CI_DelBuff(169,2,sid)
end

-- ����ս�����������
-- ����һ��ͬ����Ӫ����,����ʤ����Ӫ
local function _on_active_end(self)
	look('_on_active_end')
	-- ����ʤ����Ӫ
	_set_win_camp()
	-- �������û������������
	-- local active_sjzc = activitymgr:get(active_name)
	-- if active_sjzc then
		-- active_sjzc:traverse_region(_sjzc_traverse_region,2)
	-- end
	-- ����ͨ�����а�ȡ���������(�������)
	local sclist = get_scorelist_data(1,6)
	if sclist[1] then
		_update_tops(1,sclist[1][1],sclist[1][2])
	end
	local tops = _get_tops()		-- ȡ����֮��
	-- �����ʼ�
	if type(tops) == type({}) then
		local SendSystemMail = SendSystemMail
		for k, v in pairs(tops) do
			if type(k) == type(0) and type(v) == type({}) then
				look(v[2])
				look(k)
				SendSystemMail(v[2],MailConfig.SanJieDB,k,2) 
			end
		end
	end
end

-- ��Զ���ӿڴ�����ע��
local function _sjzc_register_func(active_sjzc)
	active_sjzc.on_regioncreate = _on_regioncreate
	active_sjzc.on_regionchange = _on_regionchange
	active_sjzc.on_playerdead = _on_playerdead
	active_sjzc.on_playerlive = _on_playerlive
	active_sjzc.on_login = _on_login
	active_sjzc.on_logout = _on_logout
	active_sjzc.on_active_end = _on_active_end	
end

-- ����ս�����ʼ
local function _sjzc_start()
	look('-----------_sjzc_start----------')
	-- assert 1: û����֮ǰ���ܿ�ʼ
	local active_sjzc = activitymgr:get(active_name)
	if active_sjzc then
		look('sjzc_start has not end')		
		return
	end	
	-- �����ϴλ����
	_clear_active_common()
	-- �����
	active_sjzc = activitymgr:create(active_name)
	if active_sjzc == nil then
		look('sjzc_start create erro')
		return
	end
	-- ע���ຯ��(internal use)
	_sjzc_register_func(active_sjzc)
	-- ���������
	local mapGID = active_sjzc:createDR(1)
	if mapGID == nil then
		look('sjzc_start createDR erro')
		return
	end
	look('mapGID:' .. mapGID)
	local region_data = active_sjzc:get_regiondata(mapGID)
	if region_data == nil then
		look('sjzc_start get_regiondata erro')
		return
	end
	
	-- ÿ10����ˢBUFF	
	SetEvent(10*60, nil, "GI_sjzc_buff_refresh")   -- ˢBUFF
	SetEvent(20*60, nil, "GI_sjzc_buff_refresh")   -- ˢBUFF
	-- ˢ�±���NPC(5�֡�15�֡�25��)
	SetEvent(5*60, nil, "GI_sjzc_box_refresh")		-- ˢͭ����
	SetEvent(15*60, nil, "GI_sjzc_box_refresh")		-- ˢ������
	SetEvent(25*60, nil, "GI_sjzc_box_refresh")		-- ˢ����	
	-- ÿ30�������Ӫ����
	SetEvent(30, nil, "GI_sjzc_camp_sync")   		-- ͬ����Ӫ����
	
	-- ���õ�ǰ��Ӫ(ÿ����ҽ���ʱת��)
	region_data.c_camp = region_data.c_camp or 1
	-- �㲥: ���ʼ
	look('BroadcastRPC sjzc_start')
	BroadcastRPC('sjzc_start')
end

-- ����ս��
local function _sjzc_enter(sid,mapGID)
	if sid == nil or mapGID == nil then return end	
	local active_sjzc = activitymgr:get(active_name)
	if active_sjzc == nil then 
		look('sjzc_enter active_sjzc == nil')
		return 
	end
	-- assert 1: �жϻ�Ƿ��ѽ���
	local active_flags = active_sjzc:get_state()
	if active_flags == 0 then
		look('sjzc_enter active is end')
		return
	end
	-- assert 2: �ж��Ƿ��Ѿ��ڻ��
	if active_sjzc:is_active(sid) then
		look('sjzc_enter player is in active')
		return
	end
	-- assert 3: �ȼ� >= 30
	local lv = CI_GetPlayerData(1,2,sid)
	if lv < 30 then
		look('sjzc_enter player lv < 30')
		return
	end
	-- get active player data
	local my_data = active_sjzc:get_mydata(sid)
	if my_data == nil then
		look('sjzc_enter get_mydata erro')
		return
	end
	local mycamp = my_data.camp
	look('mycamp:' .. tostring(mycamp))
	local region_data = active_sjzc:get_regiondata(mapGID)
	if region_data == nil then
		look('sjzc_enter get_regiondata erro')
		return
	end
	if mycamp == nil then
		mycamp = region_data.c_camp
	end

	local pos = sjzc_config.relive_pos
	if type(pos) ~= type({}) or pos[mycamp] == nil then
		look('sjzc_enter relive_pos erro')
		return
	end
	-- ���볡��ǰ���������Ӫ�����Բ����ֶ�ͬ��
	SetCamp(mycamp)
	-- put player to region
	if not active_sjzc:add_player(sid, 1, 0, pos[mycamp][1], pos[mycamp][2], mapGID) then
		look('sjzc_enter add_player erro')
		return
	end
	RPC('set_camp',mycamp)
	-- ���������Ӫ
	my_data.camp = mycamp	
	-- ���»��ǰ��Ӫ
	region_data.c_camp = (region_data.c_camp % 3) + 1
	local dayscore = sc_getdaydata(sid,6) or 0		-- ÿ�ջ���
	look('dayscore:' .. dayscore)
	RPC('sjzc_update',dayscore)
end

-- ǰ̨���󱾴λ�������а�
-- local function _sjzc_get_list(sid,mapGID)		
	-- local sclist_data = get_scorelist_data(1,6)
	-- if sclist_data then
		-- RPC('sjzc_list',sclist_data)
	-- end
-- end

-- �˳������
local function _sjzc_exit(sid)
	look('active_sjzc')
	local active_sjzc = activitymgr:get(active_name)
	if active_sjzc == nil then	
		look('_sjzc_exit active_sjzc == nil')
		return
	end	
	look('active_sjzc1111')
	active_sjzc:back_player(sid)
end

local _awards = {}

local function _sjzc_build_award(name,dayscore,sclist,camp,win_c)
	if dayscore <= 0 then
		return
	end
	-- ��������
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
	if dayscore >= 100 then		-- ����100�ֲ��б��佱��
		table_push(_awards[3],{win_id,1,1})
	end
	if box_id then
		table_push(_awards[3],{box_id,1,1})
	end
	return _awards
end

-- ���ͽ����Ϣ
local function _sjzc_report_result(sid,bget)
	look('_sjzc_report_result')
	local active_sjzc = activitymgr:get(active_name)
	-- ������û����,�����콱
	if active_sjzc then 
		local active_flags = active_sjzc:get_state()
		if active_flags ~= 0 then
			look('_sjzc_report_result active_sjzc is alive')
			return
		end		
	end
	local camp = CI_GetPlayerData(39,2,sid)
	if camp == nil or camp <= 0 then
		return
	end
	local dayscore = sc_getdaydata(sid,6) or 0		-- ÿ�ջ���	
	local weekscore = sc_getweekdata(sid,6) or 0	-- ÿ�ܻ���
	local tops = _get_tops()						-- ȡ����֮��
	local win_c = _get_win_camp()					-- ��ȡʤ����Ӫ	
	local sclist = get_scorelist_data(1,6)
	look(sclist)
	local name = CI_GetPlayerData(5,2,sid)
	local award = _sjzc_build_award(name,dayscore,sclist,camp,win_c)	-- ���콱��
	if bget then
		return award
	else
		RPC('sjzc_panel',dayscore,weekscore,win_c,tops,award)
	end	
end

-- ������
local function _sjzc_give_award(sid)
	look('_sjzc_give_award')
	local dayscore = sc_getdaydata(sid,6) or 0
	if dayscore <= 0 then
		sc_reset_getawards(sid,6)		-- ������0
		RPC('sjzc_award',1)
		return
	end
	local award = _sjzc_report_result(sid,1)
	look(award)
	if award == nil then return end
	local getok = award_check_items(award)
	if not getok then
		return
	end
	-- ֻ��ͳ��(���ڻ�Ծ��)
	CheckTimes(sid,TimesTypeTb.Fight_Time,1)			
	-- �����콱��־(������0)
	sc_reset_getawards(sid,6)
	local ret = GI_GiveAward(sid,award,"����ս������")
	RPC('sjzc_award',0)
	-- ���������
	_sjzc_exit(sid)
end

-- ��Ӫ���ع������� + 100 ��
call_monster_dead[4001] = function (mapGID)
	local active_sjzc = activitymgr:get(active_name)
	if active_sjzc == nil then			
		return
	end	
	-- ��ѽ���
	local active_flags = active_sjzc:get_state()
	if active_flags == 0 then	
		return
	end
	local sid = CI_GetPlayerData(17) or 0
	if sid > 0 then
		local my_data = active_sjzc:get_mydata(sid)
		if my_data then
			_add_score(sid,100)
		end
	end
end

-- ��Ӫ���������� +5��
call_monster_dead[4002] = function (mapGID)
	local active_sjzc = activitymgr:get(active_name)
	if active_sjzc == nil then			
		return
	end	
	-- ��ѽ���
	local active_flags = active_sjzc:get_state()
	if active_flags == 0 then	
		return
	end
	local common_data = get_sjzc_data()
	if common_data == nil then		
		return
	end
	local sid = CI_GetPlayerData(17) or 0
	if sid > 0 then
		local my_data = active_sjzc:get_mydata(sid)
		if my_data then
			_add_score(sid,5)
		end
	end
end

call_monster_dead[4003] = function (mapGID)
	_sjzc_box_open(1,mapGID)
end

call_monster_dead[4004] = function (mapGID)
	_sjzc_box_open(2,mapGID)
end

call_monster_dead[4005] = function (mapGID)
	_sjzc_box_open(3,mapGID)
end

-- �ռ�������Ƭ
call_npc_click[50001] = function ()
	local cid = GetObjectUniqueId()
	local npcid = GetNpcidByUID(cid)
	if npclist[npcid] == nil then
		look('call_npc_click 50001 npcid erro')
		return
	end
	local pb_type = npclist[npcid].PBType or 1
	CI_SetReadyEvent( cid,pb_type,3,0,"GI_sjzc_on_collect" )
end

-- �ɼ�����
-- call_npc_click[50002] = function ()
	-- local cid = GetObjectUniqueId()
	-- local npcid = GetNpcidByUID(cid)
	-- if npclist[npcid] == nil then
		-- look('call_npc_click 50002 npcid erro')
		-- return
	-- end
	-- local pb_type = npclist[npcid].PBType or 1
	-- CI_SetReadyEvent( cid,pb_type,20,0,"GI_sjzc_box_open" )		-- 20�뿪����
-- end

------------------------------------------------------------
--interface:

sjzc_start = _sjzc_start
sjzc_enter = _sjzc_enter
sjzc_exit = _sjzc_exit
sjzc_get_list = _sjzc_get_list
sjzc_buff_refresh = _sjzc_buff_refresh
sjzc_box_refresh = _sjzc_box_refresh
sjzc_camp_sync = _sjzc_camp_sync
sjzc_on_collect = _sjzc_on_collect
sjzc_box_open = _sjzc_box_open
sjzc_submit_res = _sjzc_submit_res
sjzc_report_result = _sjzc_report_result
sjzc_give_award = _sjzc_give_award