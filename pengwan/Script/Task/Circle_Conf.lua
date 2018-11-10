--[[
file: Circle_Conf.lua
desc: 跑环任务
]]--

TaskList[7] = {}

TaskList[7][1] = {
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 58,
	TaskName = "周跑环任务",				-- 任务名称	
	nocancel=1,							-- 不能取消
	NoDrop = 1,							-- 不能放弃	
	TaskInfo = "每50环可获得1个封神王者礼包，完成200环可获得1个封神至尊礼包。",		-- 任务介绍
	ClientAcceptEvent = {				-- 客户端接受任务事件	
	},
	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	ServerAcceptEvent = {				-- 服务端接受任务事件
	},
	ServerCompleteEvent = {				-- 服务端完成任务事件			
	},

	AcceptCondition = {			-- 服务端接受任务条件	
		level = 40 
	},
	CompleteCondition = {			-- 服务端完成任务条件
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
	},
	
    AutoFindWay = { true, SubmitNPC = true},
	QuickClear = 10,
}

-- 周跑环任务
CircleTaskConfig = {	
	[1] = {
		LevelNeed = {40,49},		-- 需要等级				
		CompleteAwards = {			-- 奖励固定
			[1] = 8000, --铜钱
			--[5] = 5000,  --灵气
			cicitem = {
				[50] = {674,1,1},
				[100] = {674,1,1},
				[150] = {674,1,1},
				[200] = {675,1,1},
			},
		},	
		ExtraAwards = {				-- 额外奖励 完成50环奖励
			[50] = { {675,1,1},{674,3,1}},
			[100] = { {675,1,1},{674,2,1}},
			[150] = { {675,1,1},{674,1,1}},
			[200] = { {675,1,1}},
		},
		TaskScale = {2000,2000,2000,5000,5500,9500,10000},		-- 任务类型概率(如果增加类型需要更改这个配置)
	},
	[2] = {
		LevelNeed = {50,59},		-- 需要等级				
		CompleteAwards = {			-- 奖励固定
			[1] = 9000, --铜钱
			--[5] = 6000,  --灵气
			cicitem = {
				[50] = {674,1,1},
				[100] = {674,1,1},
				[150] = {674,1,1},
				[200] = {675,1,1},
			},
		},	
		ExtraAwards = {				-- 额外奖励 完成50环奖励
			[50] = { {675,1,1},{674,3,1}},
			[100] = { {675,1,1},{674,2,1}},
			[150] = { {675,1,1},{674,1,1}},
			[200] = { {675,1,1}},
		},
		TaskScale = {2000,2000,2000,5000,5500,9500,10000},		-- 任务类型概率(如果增加类型需要更改这个配置)
	},
	[3] = {
		LevelNeed = {60,69},		-- 需要等级				
		CompleteAwards = {			-- 奖励固定
			[1] = 10000, --铜钱
			--[5] = 7000,  --灵气
			cicitem = {
				[50] = {674,1,1},
				[100] = {674,1,1},
				[150] = {674,1,1},
				[200] = {675,1,1},
			},
		},	
		ExtraAwards = {				-- 额外奖励 完成50环奖励
			[50] = { {675,1,1},{674,3,1}},
			[100] = { {675,1,1},{674,2,1}},
			[150] = { {675,1,1},{674,1,1}},
			[200] = { {675,1,1}},
		},
		TaskScale = {2000,2000,2000,5000,5500,9500,10000},		-- 任务类型概率(如果增加类型需要更改这个配置)
	},
	[4] = {
		LevelNeed = {70,999},		-- 需要等级				
		CompleteAwards = {			-- 奖励固定
			[1] = 12000, --铜钱
			--[5] = 7000,  --灵气
			cicitem = {
				[50] = {674,1,1},
				[100] = {674,1,1},
				[150] = {674,1,1},
				[200] = {675,1,1},
			},
		},	
		ExtraAwards = {				-- 额外奖励 完成50环奖励
			[50] = { {675,1,1},{674,3,1}},
			[100] = { {675,1,1},{674,2,1}},
			[150] = { {675,1,1},{674,1,1}},
			[200] = { {675,1,1}},
		},
		TaskScale = {2000,2000,2000,5000,5500,9500,10000},		-- 任务类型概率(如果增加类型需要更改这个配置)
	},
}


-- 周跑环任务
CircleTaskLib = {}

-- 任务类型:[1] 采集 [2] 作废 [3] 作废 [4] 特殊打怪类 [5] 行为类 [6] 打怪类 [7] 特殊收集
CircleTaskLib[1] = {
	[1] = {			-- 对应等级区间
		{ items = {{10001,1,{3,56,155,100002}}},},	
		{ items = {{10002,1,{1,71,155,100005}}},},	
		{ items = {{10003,1,{6,30,62,100010}}},},	
		{ items = {{10004,1,{8,41,89,100022}}},},	
		{ items = {{10005,1,{7,44,95,100026}}},},	
		{ items = {{10006,1,{10,53,150,100014}}},},	
	},
	[2] = {			-- 对应等级区间
		{ items = {{10001,1,{3,56,155,100002}}},},	
		{ items = {{10002,1,{1,71,155,100005}}},},	
		{ items = {{10003,1,{6,30,62,100010}}},},	
		{ items = {{10004,1,{8,41,89,100022}}},},	
		{ items = {{10005,1,{7,44,95,100026}}},},	
		{ items = {{10006,1,{10,53,150,100014}}},},	
	},
	[3] = {			-- 对应等级区间
		{ items = {{10001,1,{3,56,155,100002}}},},	
		{ items = {{10002,1,{1,71,155,100005}}},},	
		{ items = {{10003,1,{6,30,62,100010}}},},	
		{ items = {{10004,1,{8,41,89,100022}}},},	
		{ items = {{10005,1,{7,44,95,100026}}},},	
		{ items = {{10006,1,{10,53,150,100014}}},},	
	},
	[4] = {			-- 对应等级区间
		{ items = {{10001,1,{3,56,155,100002}}},},	
		{ items = {{10002,1,{1,71,155,100005}}},},	
		{ items = {{10003,1,{6,30,62,100010}}},},	
		{ items = {{10004,1,{8,41,89,100022}}},},	
		{ items = {{10005,1,{7,44,95,100026}}},},	
		{ items = {{10006,1,{10,53,150,100014}}},},	
	},
}

CircleTaskLib[2] = {
	[1] = {			-- 对应等级区间
		{ items = {{10,10,{1,72,150,32}}},},	
		{ items = {{1046,1,{1,47,77,54}}},},	
		{ items = {{1048,1,{1,47,77,54}}},},	
		{ items = {{1050,1,{1,47,77,54}}},},	
		{ items = {{1015,1}},},	
		{ items = {{1030,1}},},	
	},
	[2] = {			-- 对应等级区间
		{ items = {{10,10,{1,72,150,32}}},},	
		{ items = {{1046,1,{1,47,77,54}}},},	
		{ items = {{1048,1,{1,47,77,54}}},},	
		{ items = {{1050,1,{1,47,77,54}}},},	
		{ items = {{1015,1}},},	
		{ items = {{1030,1}},},	
	},
	[3] = {			-- 对应等级区间
		{ items = {{10,10,{1,72,150,32}}},},	
		{ items = {{1046,1,{1,47,77,54}}},},	
		{ items = {{1048,1,{1,47,77,54}}},},	
		{ items = {{1050,1,{1,47,77,54}}},},	
		{ items = {{1015,1}},},	
		{ items = {{1030,1}},},	
	},
	[4] = {			-- 对应等级区间
		{ items = {{10,10,{1,72,150,32}}},},	
		{ items = {{1046,1,{1,47,77,54}}},},	
		{ items = {{1048,1,{1,47,77,54}}},},	
		{ items = {{1050,1,{1,47,77,54}}},},	
	},
}

CircleTaskLib[3] = {
	[1] = {			-- 对应等级区间
		{ kill = { "G_261", 20 ,{22,42,76}},},
		{ kill = { "G_259", 20 ,{22,38,13}},},
		{ kill = { "G_257", 20 ,{31,6,41}},},
		{ kill = { "G_255", 20 ,{31,9,98},},},
		{ kill = { "GJ_350", 20 ,{200,20,20},},},
		{ kill = { "M_066", 20 ,{10,40,73},},},
		{ kill = { "M_073", 20 ,{10,62,149},},},
		{ kill = { "M_108", 20 ,{34,15,100},},},
	},
	[2] = {			-- 对应等级区间
		{ kill = { "G_266", 20 ,{28,27,32}},},
		{ kill = { "G_267", 20 ,{29,16,14}},},
		{ kill = { "G_269", 20 ,{29,17,67}},},
		{ kill = { "G_263", 20 ,{24,8,11},},},
		{ kill = { "G_262", 20 ,{24,54,37},},},
		{ kill = { "G_264", 20 ,{25,20,49},},},
		{ kill = { "G_265", 20 ,{25,58,30},},},
		{ kill = { "GJ_352", 20 ,{202,20,77},},},
	},
	[3] = {			-- 对应等级区间
		{ kill = { "GJ_353", 20 ,{203,20,20}},},
		{ kill = { "GJ_354", 20 ,{204,20,20}},},
		{ kill = { "M_077", 20 ,{10,116,159}},},
		{ kill = { "M_078", 20 ,{10,97,164},},},
		{ kill = { "M_076", 20 ,{10,80,131},},},
	},
	[4] = {			-- 对应等级区间
		{ kill = { "M_127", 20 ,{12,26,220}},},
		{ kill = { "M_128", 20 ,{12,12,168}},},
		{ kill = { "M_129", 20 ,{12,26,124}},},
		{ kill = { "M_130", 20 ,{12,18,121}},},
		{ kill = { "M_131", 20 ,{12,59,218}},},
		{ kill = { "M_132", 20 ,{12,101,204}},},
		{ kill = { "M_133", 20 ,{12,76,190}},},
		{ kill = { "M_134", 20 ,{12,107,215}},},
		{ kill = { "M_135", 20 ,{12,87,131}},},
	},
}

CircleTaskLib[4] = {
	[1] = {			-- 对应等级区间
		{ kill = { 0, 1 ,{22,11,83,1,1020}},},
		{ kill = { 0, 1 ,{31,8,7,1,1021}},},
		{ kill = { 0, 1 ,{10,111,11,1,1022}},},
		{ kill = { 0, 1 ,{7,47,114,1,1023},},},
	},
	[2] = {			-- 对应等级区间
		{ kill = { 0, 1 ,{22,11,83,1,1020}},},
		{ kill = { 0, 1 ,{31,8,7,1,1021}},},
		{ kill = { 0, 1 ,{10,111,11,1,1022}},},
		{ kill = { 0, 1 ,{7,47,114,1,1023},},},
	},
	[3] = {			-- 对应等级区间
		{ kill = { 0, 1 ,{22,11,83,1,1020}},},
		{ kill = { 0, 1 ,{31,8,7,1,1021}},},
		{ kill = { 0, 1 ,{10,111,11,1,1022}},},
		{ kill = { 0, 1 ,{7,47,114,1,1023},},},
	},
	[4] = {			-- 对应等级区间
		{ kill = { 0, 1 ,{22,11,83,1,1020}},},
		{ kill = { 0, 1 ,{31,8,7,1,1021}},},
		{ kill = { 0, 1 ,{10,111,11,1,1022}},},
		{ kill = { 0, 1 ,{7,47,114,1,1023},},},
	},
}

CircleTaskLib[5] = {
	[1] = {			-- 对应等级区间
		{ tongling = 1 },		--守护通灵1次
		{ qianghua = 1},		--装备强化次
		{ xiuxing = 1 },		--家将修行1次
	},
	[2] = {			-- 对应等级区间
		{ tongling = 1 },		--守护通灵1次
		{ qianghua = 1},		--装备强化次
		{ xiuxing = 1 },		--家将修行1次
	},
	[3] = {			-- 对应等级区间
		{ tongling = 1 },		--守护通灵1次
		{ qianghua = 1},		--装备强化次
		{ xiuxing = 1 },		--家将修行1次
	},
	[4] = {			-- 对应等级区间
		{ tongling = 1 },		--守护通灵1次
		{ qianghua = 1},		--装备强化次
		{ xiuxing = 1 },		--家将修行1次
	},
}
--打怪数量提升
CircleTaskLib[6] = {
	[1] = {			-- 对应等级区间
		{ kill = { "G_261", 50 ,{22,42,76}},},
		{ kill = { "G_259", 50 ,{22,38,13}},},
		{ kill = { "G_257", 50 ,{31,6,41}},},
		{ kill = { "G_255", 50 ,{31,9,98},},},
		{ kill = { "M_066", 50 ,{10,40,73},},},
		{ kill = { "M_073", 50 ,{10,62,149},},},
		{ kill = { "M_108", 50 ,{34,15,100},},},
	},
	[2] = {			-- 对应等级区间
		{ kill = { "G_266", 50 ,{28,27,32}},},
		{ kill = { "G_267", 50 ,{29,16,14}},},
		{ kill = { "G_269", 50 ,{29,17,67}},},
		{ kill = { "G_263", 50 ,{24,8,11},},},
		{ kill = { "G_262", 50 ,{24,54,37},},},
		{ kill = { "G_264", 50 ,{25,20,49},},},
		{ kill = { "G_265", 50 ,{25,58,30},},},
	},
	[3] = {			-- 对应等级区间
		{ kill = { "M_077", 50 ,{10,116,159}},},
		{ kill = { "M_078", 50 ,{10,97,164},},},
		{ kill = { "M_076", 50 ,{10,80,131},},},
	},
	[4] = {			-- 对应等级区间
		{ kill = { "M_127", 50 ,{12,26,220}},},
		{ kill = { "M_128", 50 ,{12,12,168}},},
		{ kill = { "M_129", 50 ,{12,26,124}},},
		{ kill = { "M_130", 50 ,{12,8,114}},},
		{ kill = { "M_132", 50 ,{12,85,218}},},
		{ kill = { "M_135", 50 ,{12,88,137}},},
	},
}
--特殊采集，为了解决果园种子任务不能点击打开商店的问题
CircleTaskLib[7] = {
	[1] = {			-- 对应等级区间
		{ items = {{10,10,{1,72,150,32}}},},	
		{ items = {{1046,1,{1,47,77,54}}},},	
		{ items = {{1048,1,{1,47,77,54}}},},	
		{ items = {{1050,1,{1,47,77,54}}},},	

	},
	[2] = {			-- 对应等级区间
		{ items = {{10,10,{1,72,150,32}}},},	
		{ items = {{1046,1,{1,47,77,54}}},},	
		{ items = {{1048,1,{1,47,77,54}}},},	
		{ items = {{1050,1,{1,47,77,54}}},},	

	},
	[3] = {			-- 对应等级区间
		{ items = {{10,10,{1,72,150,32}}},},	
		{ items = {{1046,1,{1,47,77,54}}},},	
		{ items = {{1048,1,{1,47,77,54}}},},	
		{ items = {{1050,1,{1,47,77,54}}},},	
	
	},
	[4] = {			-- 对应等级区间
		{ items = {{10,10,{1,72,150,32}}},},	
		{ items = {{1046,1,{1,47,77,54}}},},	
		{ items = {{1048,1,{1,47,77,54}}},},	
		{ items = {{1050,1,{1,47,77,54}}},},	
	
	},
}



CircleTaskLib[101] = {
	[1] = {			-- 对应等级区间
		{ kill = { "GJ_350", 2000 ,{200,20,20},},},		
	},
	[2] = {			-- 对应等级区间
		{ kill = { "GJ_352", 2000 ,{202,20,77},},},
	},
	[3] = {			-- 对应等级区间
		{ kill = { "GJ_354", 2000 ,{204,20,20}},},
	},
	[4] = {			-- 对应等级区间
		{ kill = { "GJ_356", 2000 ,{205,43,130}},},
	},
}
