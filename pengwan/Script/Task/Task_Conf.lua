--[[
file:	Task_conf.lua1
desc:	task config(S&C)
author:	chal
update:	2011-12-01
version: 1.0.0.0

1000 - 2999 主线任务
3000 - 3999 支线任务
4000 - 4999 日常任务
5000 - 5999 悬赏任务 
6000 - 6999 活动任务
7000 - 7999 跑环任务

notes:
	1、任务条件判断分为前台判断和后台判断，可以只配前台或后台判断条件
	TIPtype：空为不引导；1为引导+自动寻路；2为引导提示；3为引导传
faction = 1
]]--

TaskList = {}
--新手村1
TaskList[1] = 
{
	
}
TaskList[2] = 
{
}
TaskList[1][1] = 
{	
	AcceptNPC = 1,						-- 接受任务NPC
	SubmitNPC = 1,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	--如果没有可以不配这两个事件
	ServerAcceptEvent = 1,				-- 服务端接受任务事件 固定调用OnAcceptTask_taskid(taskid, taskData)
	--ServerCompleteEvent = 1,			-- 服务端完成任务事件 固定调用OnSubmitTask_taskid(taskid, taskData)
	--AcceptStoryID		 --接受任务剧情
	--SubmitStoryID = 1000001,  --完成任务剧情
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		-- local Award_Type = {
			-- money = 1,		-- 绑银
			-- exps = 2,		-- 经验
			-- item = 3,		-- 道具
			-- bindYB = 4,		-- 绑定元宝
			-- lingqi = 5,		-- 灵气
			-- factionGX = 6,	-- 帮会贡献
			-- shengwang = 7,	-- 战功
			--声望 = 8      --声望
		-- }
		[2] = 100,
		[1] = 1000,
		[5] = 800,
		
	},
    --QuickClear = 30,  花费指定数量元宝，快速完成本任务
	--QuickSub = 3011,   无需找NPC，可远程提交本任务，并接受下一环指定人物
	--AutoSub = 3011,    可自动提交本任务，并接受下一环任务
	--facidx = 1,		帮会特有参数，代表帮会任务的环数
	  
	StoryID = 100001,			-- 提交任务剧情ID
}
TaskList[1][2] = 
{	
	AcceptNPC = 1,						-- 接受任务NPC
	SubmitNPC = 8,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1001},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_004", 1 ,{3,88,142}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 500,
		[1] = 1000,
		[5] = 800,
		[3] = {{10,10,1}},
	},
	AutoSub = 1003,    
	StoryID = 100002,			-- 提交任务剧情ID
}

TaskList[1][3] = 
{	
	AcceptNPC = 1,						-- 接受任务NPC
	SubmitNPC = 8,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1002},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_004", 1 ,{3,77,138}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2500,
		[1] = 1000,
		[5] = 800,
		[3] = {{10,10,1}},
	},
	    
	StoryID = 100003,			-- 提交任务剧情ID
}

TaskList[1][4] = 
{	
	AcceptNPC = 8,						-- 接受任务NPC
	SubmitNPC = 4,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1003},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 8000,
		[1] = 1000,
		[5] = 800,
		[3] = {{10,10,1}},
	},
	    
	StoryID = 100004,			-- 提交任务剧情ID
}


TaskList[1][5] = 
{	
	AcceptNPC = 4,						-- 接受任务NPC
	SubmitNPC = 5,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1004},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_005", 1 ,{3,56,155}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 10000,
		[1] = 1000,
		[5] = 800,
		[3] = {{10,10,1}},
	},
	StoryID = 100005,			-- 提交任务剧情ID
	AutoSub = 1006,    
}
TaskList[1][6] = 
{	
	AcceptNPC = 5,						-- 接受任务NPC
	SubmitNPC = 5,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1005},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_005", 2 ,{3,67,163}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 10000,
		[1] = 1000,
		[5] = 800,
	},
	    
	StoryID = 100006,			-- 提交任务剧情ID
	AutoSub = 1007,    
}
TaskList[1][7] = 
{	
	AcceptNPC = 5,						-- 接受任务NPC
	SubmitNPC = 5,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		


	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1006},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	  kill = { "M_005", 2 ,{3,73,171}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[1] = 1000,
		[5] = 800,
	},
	    
	StoryID = 100007,			-- 提交任务剧情ID
	AutoSub = 1008,    
}

TaskList[1][8] = 
{	
	AcceptNPC = 5,						-- 接受任务NPC
	SubmitNPC = 5,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1007},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_047", 2 ,{3,84,179}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[1] = 1000,
		[5] = 800,
	},
	    
	StoryID = 100008,			-- 提交任务剧情ID
}
TaskList[1][9] = 
{	
	AcceptNPC = 5,						-- 接受任务NPC
	SubmitNPC = 6,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1008},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{

	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[1] = 1000,
		[5] = 800,
	},
	    
	StoryID = 100009,			-- 提交任务剧情ID
}
TaskList[1][10] = 
{	
	AcceptNPC = 6,						-- 接受任务NPC
	SubmitNPC = 30,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1,
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1009},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{

	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[1] = 1000,
		[5] = 800,
		giveGoods = {
			[3] = {
				[1] = {{5333,1,1}},	-- 将军府
				[2] = {{5370,1,1}},	-- 修仙
				[3] = {{5407,1,1}},	-- 九黎
			},
		},
	},
	    
	StoryID = 100010,			-- 提交任务剧情ID
}
--编号用到10
--新手村结束，京城任务
TaskList[1][50] = 
{	
	AcceptNPC = 30,						-- 接受任务NPC
	SubmitNPC = 35,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1010},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
	},
	    
	StoryID = 100050,			-- 提交任务剧情ID
}
TaskList[1][51] = 
{	
	AcceptNPC = 35,						-- 接受任务NPC
	SubmitNPC = 35,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1050},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_095", 2 ,{1,17,161}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		[3] = {{10,20,1}},
	},
	    
	StoryID = 100051,			-- 提交任务剧情ID
}

TaskList[1][54] = 
{	
	AcceptNPC = 35,						-- 接受任务NPC
	SubmitNPC = 33,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1,
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1051},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_097", 1,{1,36,169,1}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		[3] = {{636,3,1}},
	},
	AcceptStoryID = 1000132,
	SubmitStoryID = 1000002,
	StoryID = 100054,			-- 提交任务剧情ID
}
TaskList[1][58] = 
{	
	AcceptNPC = 33,						-- 接受任务NPC
	SubmitNPC = 38,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1,
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1054},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	    
	StoryID = 100058,			-- 提交任务剧情ID
}

--插入任务
TaskList[1][60] = 
{	
	AcceptNPC = 38,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1058},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	    
	StoryID = 100060,			-- 提交任务剧情ID
}

TaskList[2][33] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1060},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		[3] = {{100,2,1}},
	},
	    
	StoryID = 200033,			-- 提交任务剧情ID
}

TaskList[2][1] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 202,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2033},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	    
	StoryID = 200001,			-- 提交任务剧情ID
}

TaskList[2][2] = 
{	
	AcceptNPC = 202,						-- 接受任务NPC
	SubmitNPC = 203,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2001},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_028", 3 ,{7,49,42}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	    
	StoryID = 200002,			-- 提交任务剧情ID
}
TaskList[2][3] = 
{	
	AcceptNPC = 203,						-- 接受任务NPC
	SubmitNPC = 205,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2002},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_029", 3 ,{7,21,58}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	    
	StoryID = 200003,			-- 提交任务剧情ID
}

TaskList[2][12] = 
{	
	AcceptNPC = 205,						-- 接受任务NPC
	SubmitNPC = 206,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2003},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		--kill = { "M_029", 5 ,{7,21,58}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	SubmitStoryID = 1000008,
	StoryID = 200012,			-- 提交任务剧情ID
}

TaskList[2][4] = 
{	
	AcceptNPC = 206,						-- 接受任务NPC
	SubmitNPC = 211,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2012},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	
	StoryID = 200004,			-- 提交任务剧情ID
}
TaskList[2][32] = 
{	
	AcceptNPC = 211,						-- 接受任务NPC
	SubmitNPC = 211,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2004},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10005,1,{7,47,88,100026}}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		[3] = {{100,2,1}},
	},
	    
	StoryID = 200032,			-- 提交任务剧情ID
}

TaskList[2][5] = 
{	
	AcceptNPC = 211,						-- 接受任务NPC
	SubmitNPC = 202,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1,
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2032},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	SubmitStoryID = {1000007,1000009,1000010},
	StoryID = 200005,			-- 提交任务剧情ID
}

TaskList[2][11] = 
{	
	AcceptNPC = 202,						-- 接受任务NPC
	SubmitNPC = 202,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2005},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		[3] = {{100,2,1}},
	},
	--AcceptStoryID = 1000007,
	StoryID = 200011,			-- 提交任务剧情ID
}

TaskList[2][13] = 
{	
	AcceptNPC = 202,						-- 接受任务NPC
	SubmitNPC = 208,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2011},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	--AcceptStoryID = 1000007,
	StoryID = 200013,			-- 提交任务剧情ID
}

TaskList[2][6] = 
{	
	AcceptNPC = 208,						-- 接受任务NPC
	SubmitNPC = 202,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2013},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "B_032", 1 ,{7,6,19,1},"狼妖王内丹"},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		[3] = {{100,2,1}},
		
	},
	StoryID = 200006,			-- 提交任务剧情ID
}
TaskList[2][7] = 
{	
	AcceptNPC = 202,						-- 接受任务NPC
	SubmitNPC = 101,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2006},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	StoryID = 200007,			-- 提交任务剧情ID
}

--西岐郊野任务开始
TaskList[1][100] = 
{	
	AcceptNPC = 101,						-- 接受任务NPC
	SubmitNPC = 107,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2007},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_009", 4 ,{6,37,134}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 3000,
		[5] = 2500,
	},
	    
	StoryID = 100100,			-- 提交任务剧情ID
}
TaskList[1][99] = 
{	
	AcceptNPC = 107,						-- 接受任务NPC
	SubmitNPC = 102,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10007,1,{6,64,107,100011}}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 3000,
		[5] = 2500,		
	},
	    
	StoryID = 100099,			-- 提交任务剧情ID
}
TaskList[1][101] = 
{	
	AcceptNPC = 102,						-- 接受任务NPC
	SubmitNPC = 108,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1099},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_010", 4 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[1] = 3000,
		[5] = 2500,
		giveGoods = {
			[3] = {
				[1] = {{5334,1,1}},	-- 将军府
				[2] = {{5371,1,1}},	-- 修仙
				[3] = {{5408,1,1}},	-- 九黎
			},
		},
	},
	    
	StoryID = 100101,			-- 提交任务剧情ID
}
TaskList[1][98] = 
{	
	AcceptNPC = 108,						-- 接受任务NPC
	SubmitNPC = 103,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1101},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		giveGoods = {
			[3] = {
				[1] = {{5223,1,1}},	-- 将军府
				[2] = {{5260,1,1}},	-- 修仙
				[3] = {{5297,1,1}},	-- 九黎
			},
		},
	},
	    
	StoryID = 100098,			-- 提交任务剧情ID
}
TaskList[1][102] = 
{	
	AcceptNPC = 103,						-- 接受任务NPC
	SubmitNPC = 104,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1098},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_011", 4 ,{6,53,26}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		giveGoods = {
			[2] = {
				[10] = {5038,1,1},	-- 将军府(女)
				[11] = {5001,1,1},	-- 将军府(男)
				[20] = {5112,1,1},	-- 修仙(女)
				[21] = {5075,1,1},	-- 修仙(男)
				[30] = {5186,1,1},	-- 九黎(女)
				[31] = {5149,1,1},	-- 九黎(男)	
			},
		},
	},
	    
	StoryID = 100102,			-- 提交任务剧情ID
}
TaskList[1][103] = 
{	
	AcceptNPC = 104,						-- 接受任务NPC
	SubmitNPC = 105,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1102},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10003,1,{6,32,63,100010}}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		
	},
	    
	StoryID = 100103,			-- 提交任务剧情ID
}

TaskList[2][14] = 
{	
	AcceptNPC = 105,						-- 接受任务NPC
	SubmitNPC = 105,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1103},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		giveGoods = {
			[3] = {
				[1] = {{5445,1,1}},	-- 将军府
				[2] = {{5482,1,1}},	-- 修仙
				[3] = {{5519,1,1}},	-- 九黎
			},
		},
	},
	    
	StoryID = 200014,			-- 提交任务剧情ID
}

TaskList[1][104] = 
{	
	AcceptNPC = 105,						-- 接受任务NPC
	SubmitNPC = 106,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1,		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2014},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_012", 5 ,{6,10,48}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		
	},
	SubmitStoryID = 1000003,	--家将    
	StoryID = 100104,			-- 提交任务剧情ID
}
TaskList[1][115] = 
{	
	AcceptNPC = 106,						-- 接受任务NPC
	SubmitNPC = 106,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1,		--获得第一个家将
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1104},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,		
	},
	StoryID = 100115,			-- 提交任务剧情ID
}
TaskList[1][105] = 
{	
	AcceptNPC = 106,						-- 接受任务NPC
	SubmitNPC = 36,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1115},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "B_015", 1 ,{6,41,13}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 70000,
		[5] = 2500,
	},
	    
	StoryID = 100105,			-- 提交任务剧情ID
	SubmitStoryID = 1000118,
}

TaskList[1][56] = 
{	
	AcceptNPC = 36,						-- 接受任务NPC
	SubmitNPC = 36,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	--ServerAcceptEvent = 1,
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1105},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 2000,
		[5] = 1500,
		
	},
	StoryID = 100056,			-- 提交任务剧情ID
	
}

TaskList[1][57] = 
{	
	AcceptNPC = 36,						-- 接受任务NPC
	SubmitNPC = 33,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1056},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 2000,
		[5] = 1500,
		
	},
	
	StoryID = 100057,			-- 提交任务剧情ID
}

TaskList[1][106] = 
{	
	AcceptNPC = 33,						-- 接受任务NPC
	SubmitNPC = 38,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1,		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1057},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		
	},
	    
	StoryID = 100106,			-- 提交任务剧情ID
}

TaskList[1][107] = 
{	
	AcceptNPC = 38,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1106},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		
	},
	    
	StoryID = 100107,			-- 提交任务剧情ID
}
TaskList[1][108] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 38,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃	
	
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1107},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		
	},
	    
	StoryID = 100108,			-- 提交任务剧情ID
}
TaskList[1][109] = 
{	
	AcceptNPC = 38,						-- 接受任务NPC
	SubmitNPC = 45,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1108},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		
	},
	    
	StoryID = 100109,			-- 提交任务剧情ID
}
TaskList[1][110] = 
{	
	AcceptNPC = 45,						-- 接受任务NPC
	SubmitNPC = 46,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1109},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		[3] = {{621,1,1}},
	},
	    
	StoryID = 100110,			-- 提交任务剧情ID
}
TaskList[1][112] = 
{	
	AcceptNPC = 46,						-- 接受任务NPC
	SubmitNPC = 47,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1110},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,		
		
	},
	    
	StoryID = 100112,			-- 提交任务剧情ID
}

TaskList[1][113] = 
{	
	AcceptNPC = 47,						-- 接受任务NPC
	SubmitNPC = 33,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1112},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		[3] = {{5555,1,1}},
	},
	    
	StoryID = 100113,			-- 提交任务剧情ID
}
TaskList[1][114] = 
{	
	AcceptNPC = 33,						-- 接受任务NPC
	SubmitNPC = 33,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1113},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 50000,
		
	},
	    
	StoryID = 100114,			-- 提交任务剧情ID
}

TaskList[2][17] = 
{	
	AcceptNPC = 33,						-- 接受任务NPC
	SubmitNPC = 150,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1114},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		[3] = {{5587,1,1}},
	},
	    
	StoryID = 200017,			-- 提交任务剧情ID
}
--前往陈塘关任务
TaskList[1][150] = 
{	
	AcceptNPC = 150,						-- 接受任务NPC
	SubmitNPC = 151,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1,	  --开启VIP体验
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2017},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[1] = 5000,
		[5] = 4000,
		[3] = {{100,50,1}},
	},
	    
	StoryID = 100150,			-- 提交任务剧情ID
}

TaskList[1][151] = 
{	
	AcceptNPC = 151,						-- 接受任务NPC
	SubmitNPC = 151,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1150},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_016", 5 ,{8,9,9}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		[3] = {{5619,1,1}},
	},
	    
	StoryID = 100151,			-- 提交任务剧情ID
}
TaskList[1][152] = 
{	
	AcceptNPC = 151,						-- 接受任务NPC
	SubmitNPC = 152,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1151},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100152,			-- 提交任务剧情ID
}
TaskList[1][153] = 
{	
	AcceptNPC = 152,						-- 接受任务NPC
	SubmitNPC = 153,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1152},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100153,			-- 提交任务剧情ID
}
TaskList[1][154] = 
{	
	AcceptNPC = 153,						-- 接受任务NPC
	SubmitNPC = 154,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1153},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		[3] = {{5651,1,1}},
	},
	    
	StoryID = 100154,			-- 提交任务剧情ID
}
TaskList[1][155] = 
{	
	AcceptNPC = 154,						-- 接受任务NPC
	SubmitNPC = 154,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1154},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_017", 5 ,{8,15,51}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100155,			-- 提交任务剧情ID
}
TaskList[1][156] = 
{	
	AcceptNPC = 154,						-- 接受任务NPC
	SubmitNPC = 152,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1155},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{

	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100156,			-- 提交任务剧情ID
}
TaskList[1][157] = 
{	
	AcceptNPC = 152,						-- 接受任务NPC
	SubmitNPC = 155,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1156},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{

	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100157,			-- 提交任务剧情ID
}
TaskList[1][158] = 
{	
	AcceptNPC = 155,						-- 接受任务NPC
	SubmitNPC = 155,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃			
	

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1157},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{

	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 200000,
		[5] = 4000,
		[3] = {{612,2,1}},		
	},
	    
	StoryID = 100158,			-- 提交任务剧情ID
}


TaskList[2][18] = 
{	
	AcceptNPC = 155,						-- 接受任务NPC
	SubmitNPC = 156,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1158},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 150000,
		[1] = 5000,
		[5] = 4000,
		giveGoods = {
			[2] = {
				[10] = {5043,1,1},	-- 将军府(女)
				[11] = {5006,1,1},	-- 将军府(男)
				[20] = {5117,1,1},	-- 修仙(女)
				[21] = {5080,1,1},	-- 修仙(男)
				[30] = {5191,1,1},	-- 九黎(女)
				[31] = {5154,1,1},	-- 九黎(男)	
			},
		},
	},
	    
	StoryID = 200018,			-- 提交任务剧情ID
}

TaskList[1][159] = 
{	
	AcceptNPC = 156,						-- 接受任务NPC
	SubmitNPC = 157,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2018},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_018", 8 ,{8,67,111}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	SubmitStoryID = 1000004,  --完成任务剧情    
	StoryID = 100159,			-- 提交任务剧情ID
}
TaskList[1][160] = 
{	
	AcceptNPC = 157,						-- 接受任务NPC
	SubmitNPC = 158,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1159},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		[3] = {{636,3,1}},
	},
	    
	StoryID = 100160,			-- 提交任务剧情ID
}
TaskList[1][161] = 
{	
	AcceptNPC = 158,						-- 接受任务NPC
	SubmitNPC = 159,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1160},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		giveGoods = {
			[3] = {
				[1] = {{5339,1,1}},	-- 将军府
				[2] = {{5376,1,1}},	-- 修仙
				[3] = {{5413,1,1}},	-- 九黎
			},
		},
	},
	    
	StoryID = 100161,			-- 提交任务剧情ID
}
TaskList[1][162] = 
{	
	AcceptNPC = 159,						-- 接受任务NPC
	SubmitNPC = 160,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1161},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_019", 8 ,{8,39,117}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100162,			-- 提交任务剧情ID
}
TaskList[1][163] = 
{	
	AcceptNPC = 160,						-- 接受任务NPC
	SubmitNPC = 161,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1162},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100163,			-- 提交任务剧情ID
}
TaskList[1][164] = 
{	
	AcceptNPC = 161,						-- 接受任务NPC
	SubmitNPC = 161,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1163},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10004,1,{8,41,83,100020}}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100164,			-- 提交任务剧情ID
}
TaskList[1][165] = 
{	
	AcceptNPC = 161,						-- 接受任务NPC
	SubmitNPC = 160,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1164},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100165,			-- 提交任务剧情ID
}
TaskList[1][166] = 
{	
	AcceptNPC = 160,						-- 接受任务NPC
	SubmitNPC = 158,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1165},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 10000,
		[5] = 30000,
		
	},
	    
	StoryID = 100166,			-- 提交任务剧情ID
}
TaskList[1][167] = 
{	
	AcceptNPC = 158,						-- 接受任务NPC
	SubmitNPC = 157,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1166},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100167,			-- 提交任务剧情ID
}
TaskList[1][168] = 
{	
	AcceptNPC = 157,						-- 接受任务NPC
	SubmitNPC = 157,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1167},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "B_022", 1 ,{8,44,138}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		giveGoods = {
			[3] = {
				[1] = {{5450,1,1}},	-- 将军府
				[2] = {{5487,1,1}},	-- 修仙
				[3] = {{5524,1,1}},	-- 九黎
			},
		},
	},
	    
	StoryID = 100168,			-- 提交任务剧情ID
}
TaskList[1][169] = 
{	
	AcceptNPC = 157,						-- 接受任务NPC
	SubmitNPC = 156,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1168},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		[3] = {{11,100,1},},
	},
	    
	StoryID = 100169,			-- 提交任务剧情ID
}
TaskList[1][170] = 
{	
	AcceptNPC = 156,						-- 接受任务NPC
	SubmitNPC = 157,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1169},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100170,			-- 提交任务剧情ID
}
TaskList[1][171] = 
{	
	AcceptNPC = 157,						-- 接受任务NPC
	SubmitNPC = 157,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1,	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1170},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_018", 1 ,{8,63,121}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100171,			-- 提交任务剧情ID
}
TaskList[1][172] = 
{	
	AcceptNPC = 157,						-- 接受任务NPC
	SubmitNPC = 157,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1171},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_019", 1 ,{8,30,99}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
		
	},
	    
	StoryID = 100172,			-- 提交任务剧情ID
}
TaskList[1][173] = 
{	
	AcceptNPC = 157,						-- 接受任务NPC
	SubmitNPC = 157,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1172},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "B_027", 1 ,{8,44,138}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		giveGoods = {
			[3] = {
				[1] = {{5228,1,1}},	-- 将军府
				[2] = {{5265,1,1}},	-- 修仙
				[3] = {{5302,1,1}},	-- 九黎
			},
		},
		
	},
	    
	StoryID = 100173,			-- 提交任务剧情ID
}


TaskList[1][175] = 
{	
	AcceptNPC = 157,						-- 接受任务NPC
	SubmitNPC = 159,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1173},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		[3] = {{768,2,1}},
	},
	    
	StoryID = 100175,			-- 提交任务剧情ID
}
TaskList[1][176] = 
{	
	AcceptNPC = 159,						-- 接受任务NPC
	SubmitNPC = 152,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1175},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100176,			-- 提交任务剧情ID
}
TaskList[1][177] = 
{	
	AcceptNPC = 152,						-- 接受任务NPC
	SubmitNPC = 155,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1176},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100177,			-- 提交任务剧情ID
}
TaskList[1][178] = 
{	
	AcceptNPC = 155,						-- 接受任务NPC
	SubmitNPC = 157,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1,	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1177},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100178,			-- 提交任务剧情ID
}
TaskList[1][179] = 
{	
	AcceptNPC = 157,						-- 接受任务NPC
	SubmitNPC = 155,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1,	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1178},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,	
		[3] = {{100,5,1}},
	},
	AcceptStoryID = 1000005,		 --接受任务剧情    
	StoryID = 100179,			-- 提交任务剧情ID
}
TaskList[1][180] = 
{	
	AcceptNPC = 155,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptOtherTask = {3001},
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1179},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100180,			-- 提交任务剧情ID
}

TaskList[1][258] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptOtherTask = {3030},
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1180},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[1] = 8000,
		[5] = 4000,	
		[8] = 70,
	},
	    
	StoryID = 100258,			-- 提交任务剧情ID
}

TaskList[1][181] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1,
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1258},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 250000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100181,			-- 提交任务剧情ID
}
TaskList[1][256] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1181},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{100,5,1}},
	},
	    
	StoryID = 100256,			-- 提交任务剧情ID
}
TaskList[1][182] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 200,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃	
	AcceptOtherTask = {3010},
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1256},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 250000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100182,			-- 提交任务剧情ID
}
--乾元山任务开始
TaskList[1][200] = 
{	
	AcceptNPC = 200,						-- 接受任务NPC
	SubmitNPC = 201,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1182},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{11,50,1}},
	},
	    
	StoryID = 100200,			-- 提交任务剧情ID
}

TaskList[1][201] = 
{	
	AcceptNPC = 201,						-- 接受任务NPC
	SubmitNPC = 202,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1200},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
	
	},
	    
	StoryID = 100201,			-- 提交任务剧情ID
}
TaskList[1][202] = 
{	
	AcceptNPC = 202,						-- 接受任务NPC
	SubmitNPC = 203,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1201},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{

	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
	},
	    
	StoryID = 100202,			-- 提交任务剧情ID
}
TaskList[1][203] = 
{	
	AcceptNPC = 203,						-- 接受任务NPC
	SubmitNPC = 203,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1202},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_028", 5 ,{7,50,42}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 100203,			-- 提交任务剧情ID
}
TaskList[1][204] = 
{	
	AcceptNPC = 203,						-- 接受任务NPC
	SubmitNPC = 205,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptOtherTask = {3006},
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1203},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 100204,			-- 提交任务剧情ID
}
TaskList[1][205] = 
{	
	AcceptNPC = 205,						-- 接受任务NPC
	SubmitNPC = 205,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1204},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_029", 5 ,{7,14,57}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 100205,			-- 提交任务剧情ID
}
TaskList[1][206] = 
{	
	AcceptNPC = 205,						-- 接受任务NPC
	SubmitNPC = 207,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1205},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 100206,			-- 提交任务剧情ID
}

TaskList[1][212] = 
{	
	AcceptNPC = 207,						-- 接受任务NPC
	SubmitNPC = 207,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1206},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_096", 10 ,{7,17,26}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 100212,			-- 提交任务剧情ID
}
TaskList[1][213] = 
{	
	AcceptNPC = 207,						-- 接受任务NPC
	SubmitNPC = 202,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1212},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "B_035", 1 ,{7,6,19}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{5559,1,1}},
	},
	SubmitStoryID = 1000006,  --完成任务剧情           
	StoryID = 100213,			-- 提交任务剧情ID
}
TaskList[1][214] = 
{	
	AcceptNPC = 202,						-- 接受任务NPC
	SubmitNPC = 204,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1213},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{100,5,1}},
	},
	
	StoryID = 100214,			-- 提交任务剧情ID
}
TaskList[1][215] = 
{	
	AcceptNPC = 204,						-- 接受任务NPC
	SubmitNPC = 160,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1214},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{5591,1,1}},
	},
	    
	StoryID = 100215,			-- 提交任务剧情ID
}

TaskList[2][19] = 
{	
	AcceptNPC = 160,						-- 接受任务NPC
	SubmitNPC = 160,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1215},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_088", 1 ,{8,14,123},"鲨鱼皮"},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{636,3,1}},
	},
	    
	StoryID = 200019,			-- 提交任务剧情ID
}
TaskList[2][20] = 
{	
	AcceptNPC = 160,						-- 接受任务NPC
	SubmitNPC = 160,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2019},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 200020,			-- 提交任务剧情ID
}

TaskList[1][216] = 
{	
	AcceptNPC = 160,						-- 接受任务NPC
	SubmitNPC = 157,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2020},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "B_038", 1 ,{8,14,123}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{5623,1,1}},
	},
	    
	StoryID = 100216,			-- 提交任务剧情ID
}

TaskList[1][218] = 
{	
	AcceptNPC = 157,						-- 接受任务NPC
	SubmitNPC = 155,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1216},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{100,20,1}},
	},
	    
	StoryID = 100218,			-- 提交任务剧情ID
}
TaskList[1][219] = 
{	
	AcceptNPC = 155,						-- 接受任务NPC
	SubmitNPC = 43,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1218},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 100219,			-- 提交任务剧情ID
}
TaskList[1][220] = 
{	
	AcceptNPC = 43,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1  ,  --恢复妲己体力
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1219},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 100220,			-- 提交任务剧情ID
}


TaskList[1][224] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 49,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1220},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{5655,1,1}},
	},
	    
	StoryID = 100224,			-- 提交任务剧情ID
}



TaskList[1][250] = 
{	
	AcceptNPC = 49,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1224},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 100250,			-- 提交任务剧情ID
}

TaskList[2][27] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃
	ServerAcceptEvent = 1,	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1250},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 4000,
		[3] = {{630,5,1}},
	},
	    
	StoryID = 200027,			-- 提交任务剧情ID
}


TaskList[1][300] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 202,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptOtherTask = {3035},

	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2027},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100300,			-- 提交任务剧情ID
}
TaskList[1][301] = 
{	
	AcceptNPC = 202,						-- 接受任务NPC
	SubmitNPC = 204,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1300},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100301,			-- 提交任务剧情ID
}

TaskList[1][302] = 
{	
	AcceptNPC = 204,						-- 接受任务NPC
	SubmitNPC = 204,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1301},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_043", 12 ,{7,79,81}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100302,			-- 提交任务剧情ID
}



TaskList[1][303] = 
{	
	AcceptNPC = 204,						-- 接受任务NPC
	SubmitNPC = 204,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1302},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_044", 12 ,{7,71,122}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100303,			-- 提交任务剧情ID
}

TaskList[1][304] = 
{	
	AcceptNPC = 204,						-- 接受任务NPC
	SubmitNPC = 206,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1303},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100304,			-- 提交任务剧情ID
}


TaskList[1][306] = 
{	
	AcceptNPC = 206,						-- 接受任务NPC
	SubmitNPC = 206,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1304},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_045", 12 ,{7,23,128}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100306,			-- 提交任务剧情ID
}


TaskList[1][307] = 
{	
	AcceptNPC = 206,						-- 接受任务NPC
	SubmitNPC = 206,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1306},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_046", 12 ,{7,4,98}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
		
	},
	    
	StoryID = 100307,			-- 提交任务剧情ID
}


TaskList[1][308] = 
{	
	AcceptNPC = 206,						-- 接受任务NPC
	SubmitNPC = 206,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1307},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "B_051", 1 ,{7,9,133}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100308,			-- 提交任务剧情ID
}
TaskList[1][309] = 
{	
	AcceptNPC = 206,						-- 接受任务NPC
	SubmitNPC = 215,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	--AcceptOtherTask = {3045},
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1308},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100309,			-- 提交任务剧情ID
}
TaskList[1][310] = 
{	
	AcceptNPC = 215,						-- 接受任务NPC
	SubmitNPC = 215,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1309},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_102", 12 ,{34,5,42}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100310,			-- 提交任务剧情ID
}
TaskList[1][311] = 
{	
	AcceptNPC = 215,						-- 接受任务NPC
	SubmitNPC = 216,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1310},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100311,			-- 提交任务剧情ID
}
TaskList[1][312] = 
{	
	AcceptNPC = 216,						-- 接受任务NPC
	SubmitNPC = 216,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1311},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_103", 12 ,{34,22,8}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100312,			-- 提交任务剧情ID
}

TaskList[1][313] = 
{	
	AcceptNPC = 216,						-- 接受任务NPC
	SubmitNPC = 216,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1312},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_104", 12 ,{34,22,28}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100313,			-- 提交任务剧情ID
}
TaskList[1][314] = 
{	
	AcceptNPC = 216,						-- 接受任务NPC
	SubmitNPC = 216,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1313},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_105", 12 ,{34,39,33}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100314,			-- 提交任务剧情ID
}
TaskList[1][315] = 
{	
	AcceptNPC = 216,						-- 接受任务NPC
	SubmitNPC = 216,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1314},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_106", 12 ,{34,39,54}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100315,			-- 提交任务剧情ID
}
TaskList[1][316] = 
{	
	AcceptNPC = 216,						-- 接受任务NPC
	SubmitNPC = 217,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1315},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100316,			-- 提交任务剧情ID
}
TaskList[1][317] = 
{	
	AcceptNPC = 217,						-- 接受任务NPC
	SubmitNPC = 218,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1316},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10005,1,{34,31,73,100025}}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100317,			-- 提交任务剧情ID
}
TaskList[1][318] = 
{	
	AcceptNPC = 218,						-- 接受任务NPC
	SubmitNPC = 218,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1317},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_107", 12 ,{34,39,97}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100318,			-- 提交任务剧情ID
}
TaskList[1][319] = 
{	
	AcceptNPC = 218,						-- 接受任务NPC
	SubmitNPC = 219,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1318},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_108", 12 ,{34,14,102}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100319,			-- 提交任务剧情ID
}

TaskList[1][320] = 
{	
	AcceptNPC = 219,						-- 接受任务NPC
	SubmitNPC = 219,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1319},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_109", 12 ,{34,7,81}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100320,			-- 提交任务剧情ID
}
TaskList[1][321] = 
{	
	AcceptNPC = 219,						-- 接受任务NPC
	SubmitNPC = 206,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1320},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "B_054", 1 ,{7,9,133}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100321,			-- 提交任务剧情ID
}

TaskList[1][322] = 
{	
	AcceptNPC = 206,						-- 接受任务NPC
	SubmitNPC = 202,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1321},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100322,			-- 提交任务剧情ID
}

TaskList[1][323] = 
{	
	AcceptNPC = 202,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1322},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100323,			-- 提交任务剧情ID
}
TaskList[1][324] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	--ServerAcceptEvent = 1,
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1323},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 50000,
		[5] = 4000,
		[3] = {{411,1,1},{421,1,1}},
	},
	    
	StoryID = 100324,			-- 提交任务剧情ID
}
TaskList[1][350] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 43,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptOtherTask = {3002},
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1324},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100350,			-- 提交任务剧情ID
}
TaskList[1][351] = 
{	
	AcceptNPC = 43,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1350},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100351,			-- 提交任务剧情ID
}
TaskList[1][352] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 300,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1351},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100352,			-- 提交任务剧情ID
}
TaskList[1][353] = 
{	
	AcceptNPC = 300,						-- 接受任务NPC
	SubmitNPC = 300,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1352},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_065", 12 ,{10,12,83}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100353,			-- 提交任务剧情ID
}
TaskList[1][354] = 
{	
	AcceptNPC = 300,						-- 接受任务NPC
	SubmitNPC = 302,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1353},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_039", 12 ,{10,18,157}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100354,			-- 提交任务剧情ID
}
TaskList[1][355] = 
{	
	AcceptNPC = 302,						-- 接受任务NPC
	SubmitNPC = 304,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1354},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100355,			-- 提交任务剧情ID
}
TaskList[1][356] = 
{	
	AcceptNPC = 304,						-- 接受任务NPC
	SubmitNPC = 309,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1355},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100356,			-- 提交任务剧情ID
}
TaskList[1][357] = 
{	
	AcceptNPC = 309,						-- 接受任务NPC
	SubmitNPC = 309,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1356},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_040", 12 ,{10,18,157}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100357,			-- 提交任务剧情ID
}
TaskList[1][358] = 
{	
	AcceptNPC = 309,						-- 接受任务NPC
	SubmitNPC = 305,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1357},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_072", 12 ,{10,43,101}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100358,			-- 提交任务剧情ID
}
TaskList[1][359] = 
{	
	AcceptNPC = 305,						-- 接受任务NPC
	SubmitNPC = 305,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1358},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_073", 12 ,{10,60,145}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100359,			-- 提交任务剧情ID
}
TaskList[1][360] = 
{	
	AcceptNPC = 305,						-- 接受任务NPC
	SubmitNPC = 300,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1359},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10006,1,{10,54,152,100015}}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100360,			-- 提交任务剧情ID
}
TaskList[1][361] = 
{	
	AcceptNPC = 300,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1360},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100361,			-- 提交任务剧情ID
}
TaskList[1][362] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1361},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_066", 12 ,{10,75,145}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100362,			-- 提交任务剧情ID
}
TaskList[1][363] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1362},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_041", 12 ,{10,37,54}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100363,			-- 提交任务剧情ID
}
TaskList[1][364] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 308,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1363},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_069", 12 ,{10,40,38}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100364,			-- 提交任务剧情ID
}
TaskList[1][365] = 
{	
	AcceptNPC = 308,						-- 接受任务NPC
	SubmitNPC = 308,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1364},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_070", 12 ,{10,47,19}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100365,			-- 提交任务剧情ID
}
TaskList[1][366] = 
{	
	AcceptNPC = 308,						-- 接受任务NPC
	SubmitNPC = 308,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1365},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_071", 12 ,{10,62,9}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100366,			-- 提交任务剧情ID
}
TaskList[1][367] = 
{	
	AcceptNPC = 308,						-- 接受任务NPC
	SubmitNPC = 313,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1366},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100367,			-- 提交任务剧情ID
}
TaskList[1][368] = 
{	
	AcceptNPC = 313,						-- 接受任务NPC
	SubmitNPC = 314,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1367},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100368,			-- 提交任务剧情ID
}
TaskList[1][369] = 
{	
	AcceptNPC = 314,						-- 接受任务NPC
	SubmitNPC = 314,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1368},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_074", 12 ,{10,54,52}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100369,			-- 提交任务剧情ID
}
TaskList[1][370] = 
{	
	AcceptNPC = 314,						-- 接受任务NPC
	SubmitNPC = 314,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1369},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_067", 12 ,{10,61,28},"金创药"},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100370,			-- 提交任务剧情ID
}
TaskList[1][371] = 
{	
	AcceptNPC = 314,						-- 接受任务NPC
	SubmitNPC = 314,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1370},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10007,1,{10,74,63,100012}}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100371,			-- 提交任务剧情ID
}
TaskList[1][372] = 
{	
	AcceptNPC = 314,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1371},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100372,			-- 提交任务剧情ID
}
TaskList[1][373] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 307,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1372},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_063", 12 ,{10,18,40}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100373,			-- 提交任务剧情ID
}
TaskList[1][374] = 
{	
	AcceptNPC = 307,						-- 接受任务NPC
	SubmitNPC = 307,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1373},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_064", 12 ,{10,17,15}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100374,			-- 提交任务剧情ID
}
TaskList[1][375] = 
{	
	AcceptNPC = 307,						-- 接受任务NPC
	SubmitNPC = 307,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1,	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1374},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "B_079", 1 ,{10,12,12,1}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100375,			-- 提交任务剧情ID
}
TaskList[1][376] = 
{	
	AcceptNPC = 307,						-- 接受任务NPC
	SubmitNPC = 56,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1375},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
		[3] = {{25,1,1}},
	},	    
	StoryID = 100376,			-- 提交任务剧情ID
}
TaskList[1][377] = 
{	
	AcceptNPC = 56,						-- 接受任务NPC
	SubmitNPC = 56,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1,
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1376},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
		[3] = {{630,10,1},{768,2,1}},
	},	    
	StoryID = 100377,			-- 提交任务剧情ID
}
TaskList[1][378] = 
{	
	AcceptNPC = 56,						-- 接受任务NPC
	SubmitNPC = 56,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptOtherTask = {3045,3100},
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1377},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 40,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
		[3] = {{12,200,1}},
	},	    
	StoryID = 100378,			-- 提交任务剧情ID
}
TaskList[1][400] = 
{	
	AcceptNPC = 56,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptOtherTask = {3008},
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1378},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_066", 15 ,{10,42,73}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100400,			-- 提交任务剧情ID
}
TaskList[1][401] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1400},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_041", 15 ,{10,37,54}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100401,			-- 提交任务剧情ID
}
TaskList[1][402] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1401},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_069", 15 ,{10,41,34}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100402,			-- 提交任务剧情ID
}
TaskList[1][403] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1,	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1402},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "B_080", 1 ,{10,12,12,1}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100403,			-- 提交任务剧情ID
}
TaskList[1][404] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptOtherTask = {3111,7001},
	ServerAcceptEvent = 1,	  --接受日常
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1403},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 41,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100404,			-- 提交任务剧情ID
}
TaskList[2][28] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1404},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200028,			-- 提交任务剧情ID
}
TaskList[1][405] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 308,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2028},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_074", 15 ,{10,52,45}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100405,			-- 提交任务剧情ID
}
TaskList[1][406] = 
{	
	AcceptNPC = 308,						-- 接受任务NPC
	SubmitNPC = 308,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1405},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_070", 15 ,{10,43,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100406,			-- 提交任务剧情ID
}
TaskList[1][407] = 
{	
	AcceptNPC = 308,						-- 接受任务NPC
	SubmitNPC = 308,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1406},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_071", 15 ,{10,64,7}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100407,			-- 提交任务剧情ID
}
TaskList[1][408] = 
{	
	AcceptNPC = 308,						-- 接受任务NPC
	SubmitNPC = 308,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1407},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_067", 15 ,{10,59,28}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100408,			-- 提交任务剧情ID
}
TaskList[1][409] = 
{	
	AcceptNPC = 308,						-- 接受任务NPC
	SubmitNPC = 308,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1,	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1408},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "B_081", 1 ,{10,12,12,1}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100409,			-- 提交任务剧情ID
}
TaskList[1][410] = 
{	
	AcceptNPC = 308,						-- 接受任务NPC
	SubmitNPC = 307,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1409},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 42,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100410,			-- 提交任务剧情ID
}
TaskList[1][411] = 
{	
	AcceptNPC = 307,						-- 接受任务NPC
	SubmitNPC = 307,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1410},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_063", 15 ,{10,17,40}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100411,			-- 提交任务剧情ID
}
TaskList[1][412] = 
{	
	AcceptNPC = 307,						-- 接受任务NPC
	SubmitNPC = 307,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1411},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_064", 15 ,{10,17,16}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100412,			-- 提交任务剧情ID
}
TaskList[1][413] = 
{	
	AcceptNPC = 307,						-- 接受任务NPC
	SubmitNPC = 307,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerAcceptEvent = 1,	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1412},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "B_082", 1 ,{10,12,12,1}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100413,			-- 提交任务剧情ID
}
TaskList[1][414] = 
{	
	AcceptNPC = 307,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1413},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100414,			-- 提交任务剧情ID
}
TaskList[1][415] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1414},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 43,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100415,			-- 提交任务剧情ID
}
TaskList[1][416] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1415},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100416,			-- 提交任务剧情ID
}
TaskList[1][417] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1416},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
		[3] = {{638,20,1}},
	},	    
	StoryID = 100417,			-- 提交任务剧情ID
}
TaskList[1][418] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1417},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
	
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100418,			-- 提交任务剧情ID
}
TaskList[1][419] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1418},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 44,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
		[12] = 3000,
	},	    
	StoryID = 100419,			-- 提交任务剧情ID
}
TaskList[1][420] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1419},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100420,			-- 提交任务剧情ID
}
TaskList[1][421] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1420},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_068", 15 ,{10,75,35}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100421,			-- 提交任务剧情ID
}
TaskList[1][422] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1421},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_110", 15 ,{10,87,24}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100422,			-- 提交任务剧情ID
}
TaskList[2][37] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptOtherTask = {3115},
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1422},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 45,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200037,			-- 提交任务剧情ID
}





TaskList[1][423] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2037},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_111", 15 ,{10,91,45}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100423,			-- 提交任务剧情ID
}
TaskList[1][424] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1423},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10003,1,{10,100,8,100013}}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100424,			-- 提交任务剧情ID
}
TaskList[1][425] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1424},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100425,			-- 提交任务剧情ID
}
TaskList[1][426] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1425},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 46,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100426,			-- 提交任务剧情ID
}
TaskList[1][427] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	--AcceptOtherTask = {3046},
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1426},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_120", 15 ,{10,101,31}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
		[3] = {{634,1,1}},
	},	    
	StoryID = 100427,			-- 提交任务剧情ID
}
TaskList[1][428] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1427},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_112", 15 ,{10,118,43}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
		[3] = {{634,1,1}},
	},	    
	StoryID = 100428,			-- 提交任务剧情ID
}
--47级添加
TaskList[2][38] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1428},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_068", 20 ,{10,75,35}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
		[3] = {{634,1,1}},
	},	    
	StoryID = 200038,			-- 提交任务剧情ID
}
TaskList[2][39] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2038},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_110", 20 ,{10,87,24}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
		[3] = {{634,1,1}},
	},	    
	StoryID = 200039,			-- 提交任务剧情ID
}
TaskList[2][40] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2039},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 47,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200040,			-- 提交任务剧情ID
}
TaskList[2][41] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2040},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_111", 20 ,{10,91,45}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200041,			-- 提交任务剧情ID
}
TaskList[2][42] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2041},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_120", 20 ,{10,101,31}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200042,			-- 提交任务剧情ID
}



TaskList[1][429] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2042},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100429,			-- 提交任务剧情ID
}
TaskList[1][430] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1429},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 48,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100430,			-- 提交任务剧情ID
}
TaskList[1][431] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 319,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1430},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100431,			-- 提交任务剧情ID
}
TaskList[1][432] = 
{	
	AcceptNPC = 319,						-- 接受任务NPC
	SubmitNPC = 319,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1431},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_114", 15 ,{10,102,71}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100432,			-- 提交任务剧情ID
}
TaskList[1][433] = 
{	
	AcceptNPC = 319,						-- 接受任务NPC
	SubmitNPC = 319,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1432},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_113", 15 ,{10,87,71},"寒冰阵情报"},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100433,			-- 提交任务剧情ID
}

TaskList[2][43] = 
{	
	AcceptNPC = 319,						-- 接受任务NPC
	SubmitNPC = 319,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptOtherTask = {3121},
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1433},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 49,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200043,			-- 提交任务剧情ID
}

TaskList[1][434] = 
{	
	AcceptNPC = 319,						-- 接受任务NPC
	SubmitNPC = 319,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2043},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "B_083", 1 ,{10,122,94,1}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100434,			-- 提交任务剧情ID
}
TaskList[2][44] = 
{	
	AcceptNPC = 319,						-- 接受任务NPC
	SubmitNPC = 319,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1434},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_114", 20 ,{10,102,71}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200044,			-- 提交任务剧情ID
}
TaskList[2][45] = 
{	
	AcceptNPC = 319,						-- 接受任务NPC
	SubmitNPC = 319,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2044},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_113", 20 ,{10,87,71}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200045,			-- 提交任务剧情ID
}





TaskList[1][435] = 
{	
	AcceptNPC = 319,						-- 接受任务NPC
	SubmitNPC = 319,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerCompleteEvent = 1,	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2045},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 50,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100435,			-- 提交任务剧情ID
}
TaskList[1][436] = 
{	
	AcceptNPC = 319,						-- 接受任务NPC
	SubmitNPC = 319,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1435},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_113", 15 ,{10,87,71}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100436,			-- 提交任务剧情ID
}
TaskList[1][437] = 
{	
	AcceptNPC = 319,						-- 接受任务NPC
	SubmitNPC = 319,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1436},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_114", 15 ,{10,102,71},"金光阵情报"},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100437,			-- 提交任务剧情ID
}
TaskList[1][438] = 
{	
	AcceptNPC = 319,						-- 接受任务NPC
	SubmitNPC = 319,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1437},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "B_084", 1 ,{10,122,94,1}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100438,			-- 提交任务剧情ID
}
TaskList[1][439] = 
{	
	AcceptNPC = 319,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1438},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100439,			-- 提交任务剧情ID
}
TaskList[2][46] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1439},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 51,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200046,			-- 提交任务剧情ID
}
TaskList[2][47] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 308,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2046},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_066", 30 ,{10,39,72}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200047,			-- 提交任务剧情ID
}
TaskList[2][48] = 
{	
	AcceptNPC = 308,						-- 接受任务NPC
	SubmitNPC = 308,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2047},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_041", 30 ,{10,37,54}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200048,			-- 提交任务剧情ID
}
TaskList[2][49] = 
{	
	AcceptNPC = 308,						-- 接受任务NPC
	SubmitNPC = 308,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2048},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_069", 30 ,{10,40,38}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200049,			-- 提交任务剧情ID
}
TaskList[2][50] = 
{	
	AcceptNPC = 308,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2049},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_070", 30 ,{10,42,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200050,			-- 提交任务剧情ID
}
TaskList[2][51] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2050},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 52,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200051,			-- 提交任务剧情ID
}
TaskList[2][52] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 308,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2051},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_074", 30 ,{10,54,52}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200052,			-- 提交任务剧情ID
}
TaskList[2][53] = 
{	
	AcceptNPC = 308,						-- 接受任务NPC
	SubmitNPC = 308,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2052},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_067", 30 ,{10,61,28}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200053,			-- 提交任务剧情ID
}
TaskList[2][54] = 
{	
	AcceptNPC = 308,						-- 接受任务NPC
	SubmitNPC = 308,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2053},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_071", 30 ,{10,64,7}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200054,			-- 提交任务剧情ID
}
TaskList[2][55] = 
{	
	AcceptNPC = 308,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2054},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_112", 30 ,{10,118,43}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200055,			-- 提交任务剧情ID
}

TaskList[1][440] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2055},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 53,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100440,			-- 提交任务剧情ID
}


TaskList[1][450] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 316,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1440},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_113", 15 ,{10,87,71}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100450,			-- 提交任务剧情ID
}
TaskList[1][451] = 
{	
	AcceptNPC = 316,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1450},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_114", 15 ,{10,102,71}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100451,			-- 提交任务剧情ID
}
TaskList[1][452] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1451},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_075", 15 ,{10,99,119}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100452,			-- 提交任务剧情ID
}
TaskList[1][453] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1452},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_076", 15 ,{10,84,133}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100453,			-- 提交任务剧情ID
}
TaskList[2][56] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1453},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 54,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200056,			-- 提交任务剧情ID
}
TaskList[2][57] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2056},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_040", 30 ,{10,50,123}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200057,			-- 提交任务剧情ID
}
TaskList[2][58] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2057},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_072", 30 ,{10,43,101}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200058,			-- 提交任务剧情ID
}
TaskList[2][59] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2058},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_068", 30 ,{10,75,35}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200059,			-- 提交任务剧情ID
}

TaskList[2][62] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2059},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 55,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200062,			-- 提交任务剧情ID
}

TaskList[2][60] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2062},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_111", 30 ,{10,91,45}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200060,			-- 提交任务剧情ID
}
TaskList[2][61] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2060},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_120", 30 ,{10,101,31}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200061,			-- 提交任务剧情ID
}



TaskList[1][454] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 318,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2061},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100454,			-- 提交任务剧情ID
}
TaskList[1][455] = 
{	
	AcceptNPC = 318,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1454},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100455,			-- 提交任务剧情ID
}
TaskList[1][456] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1455},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 56,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100456,			-- 提交任务剧情ID
}
TaskList[1][457] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1456},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100457,			-- 提交任务剧情ID
}
TaskList[1][458] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1457},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_077", 15 ,{10,113,138}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100458,			-- 提交任务剧情ID
}
TaskList[1][459] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1458},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_078", 15 ,{10,97,155}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100459,			-- 提交任务剧情ID
}
TaskList[1][460] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1459},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_078", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100460,			-- 提交任务剧情ID
}
TaskList[1][461] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1460},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 57,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100461,			-- 提交任务剧情ID
}
TaskList[1][462] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1461},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_075", 20 ,{10,97,115}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100462,			-- 提交任务剧情ID
}

TaskList[2][63] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1462},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 58,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200063,			-- 提交任务剧情ID
}

TaskList[1][463] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2063},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_076", 20 ,{10,80,131}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100463,			-- 提交任务剧情ID
}

TaskList[2][64] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1463},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 59,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200064,			-- 提交任务剧情ID
}
TaskList[2][65] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2064},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200065,			-- 提交任务剧情ID
}
TaskList[2][66] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2065},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 60,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200066,			-- 提交任务剧情ID
}
TaskList[2][67] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2066},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200067,			-- 提交任务剧情ID
}
TaskList[2][68] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2067},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 61,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200068,			-- 提交任务剧情ID
}

TaskList[1][464] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2068},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_077", 20 ,{10,118,142}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100464,			-- 提交任务剧情ID
}
TaskList[2][69] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1464},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 62,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200069,			-- 提交任务剧情ID
}

TaskList[1][465] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2069},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_078", 30 ,{10,98,159}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100465,			-- 提交任务剧情ID
}

TaskList[2][70] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1465},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 63,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200070,			-- 提交任务剧情ID
}
TaskList[2][71] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2070},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_075", 50 ,{10,107,115}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200071,			-- 提交任务剧情ID
}
TaskList[2][72] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2071},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 64,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200072,			-- 提交任务剧情ID
}
TaskList[2][73] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2072},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_076", 50 ,{10,89,132}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200073,			-- 提交任务剧情ID
}


TaskList[1][466] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2073},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 65,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100466,			-- 提交任务剧情ID
}
TaskList[1][467] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1466},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100467,			-- 提交任务剧情ID
}

TaskList[2][74] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1467},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 66,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200074,			-- 提交任务剧情ID
}
TaskList[2][75] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2074},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_077", 50 ,{10,113,140}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200075,			-- 提交任务剧情ID
}
TaskList[2][76] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2075},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 67,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200076,			-- 提交任务剧情ID
}
TaskList[2][77] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2076},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_078", 50 ,{10,98,163}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200077,			-- 提交任务剧情ID
}
TaskList[2][78] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2077},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 68,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200078,			-- 提交任务剧情ID
}
TaskList[2][79] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2078},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_077", 50 ,{10,113,140}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200079,			-- 提交任务剧情ID
}
TaskList[2][80] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2079},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 69,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200080,			-- 提交任务剧情ID
}
TaskList[2][81] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 317,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2080},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_076", 50 ,{10,80,131}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200081,			-- 提交任务剧情ID
}


TaskList[1][468] = 
{	
	AcceptNPC = 317,						-- 接受任务NPC
	SubmitNPC = 49,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2081},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100468,			-- 提交任务剧情ID
}
TaskList[1][469] = 
{	
	AcceptNPC = 49,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1468},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100469,			-- 提交任务剧情ID
}
TaskList[1][470] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1469},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 70,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100470,			-- 提交任务剧情ID
}
--牧野任务
TaskList[1][500] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 350,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1470},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100500,			-- 提交任务剧情ID
}
TaskList[1][501] = 
{	
	AcceptNPC = 350,						-- 接受任务NPC
	SubmitNPC = 350,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1500},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_127", 50 ,{12,26,220}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100501,			-- 提交任务剧情ID
}
TaskList[1][502] = 
{	
	AcceptNPC = 350,						-- 接受任务NPC
	SubmitNPC = 350,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1501},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_128", 50 ,{12,14,170}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100502,			-- 提交任务剧情ID
}
TaskList[1][503] = 
{	
	AcceptNPC = 350,						-- 接受任务NPC
	SubmitNPC = 350,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1502},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 71,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100503,			-- 提交任务剧情ID
}
TaskList[1][504] = 
{	
	AcceptNPC = 350,						-- 接受任务NPC
	SubmitNPC = 351,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1503},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100504,			-- 提交任务剧情ID
}
TaskList[1][505] = 
{	
	AcceptNPC = 351,						-- 接受任务NPC
	SubmitNPC = 352,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1504},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100505,			-- 提交任务剧情ID
}
TaskList[1][506] = 
{	
	AcceptNPC = 352,						-- 接受任务NPC
	SubmitNPC = 352,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1505},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_129", 50 ,{12,20,135},"毒药配方"},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100506,			-- 提交任务剧情ID
}
TaskList[1][507] = 
{	
	AcceptNPC = 352,						-- 接受任务NPC
	SubmitNPC = 351,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1506},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_128", 50 ,{12,23,179},"临时解药"},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100507,			-- 提交任务剧情ID
}
TaskList[1][508] = 
{	
	AcceptNPC = 351,						-- 接受任务NPC
	SubmitNPC = 352,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1507},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10001,1,{3,58,155,100001}}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100508,			-- 提交任务剧情ID
}
TaskList[1][509] = 
{	
	AcceptNPC = 352,						-- 接受任务NPC
	SubmitNPC = 352,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1508},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10006,1,{10,55,153,100015}}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100509,			-- 提交任务剧情ID
}
TaskList[1][510] = 
{	
	AcceptNPC = 352,						-- 接受任务NPC
	SubmitNPC = 351,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1509},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100510,			-- 提交任务剧情ID
}
TaskList[1][511] = 
{	
	AcceptNPC = 351,						-- 接受任务NPC
	SubmitNPC = 355,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1510},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100511,			-- 提交任务剧情ID
}
TaskList[1][512] = 
{	
	AcceptNPC = 355,						-- 接受任务NPC
	SubmitNPC = 355,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1511},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 72,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100512,			-- 提交任务剧情ID
}
TaskList[1][513] = 
{	
	AcceptNPC = 355,						-- 接受任务NPC
	SubmitNPC = 351,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1512},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100513,			-- 提交任务剧情ID
}
TaskList[1][514] = 
{	
	AcceptNPC = 351,						-- 接受任务NPC
	SubmitNPC = 351,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1513},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_130", 50 ,{12,15,102}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100514,			-- 提交任务剧情ID
}
TaskList[1][515] = 
{	
	AcceptNPC = 351,						-- 接受任务NPC
	SubmitNPC = 351,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1514},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_129", 50 ,{12,25,149}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100515,			-- 提交任务剧情ID
}
TaskList[1][516] = 
{	
	AcceptNPC = 351,						-- 接受任务NPC
	SubmitNPC = 350,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1515},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100516,			-- 提交任务剧情ID
}
TaskList[1][517] = 
{	
	AcceptNPC = 350,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1516},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100517,			-- 提交任务剧情ID
}
TaskList[1][518] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1517},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 73,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100518,			-- 提交任务剧情ID
}
TaskList[1][519] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 350,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1518},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100519,			-- 提交任务剧情ID
}
TaskList[1][520] = 
{	
	AcceptNPC = 350,						-- 接受任务NPC
	SubmitNPC = 353,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1519},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100520,			-- 提交任务剧情ID
}
TaskList[1][521] = 
{	
	AcceptNPC = 353,						-- 接受任务NPC
	SubmitNPC = 353,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1520},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_131", 50 ,{12,57,220}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100521,			-- 提交任务剧情ID
}
TaskList[1][522] = 
{	
	AcceptNPC = 353,						-- 接受任务NPC
	SubmitNPC = 353,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1521},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_132", 50 ,{12,91,224}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100522,			-- 提交任务剧情ID
}
TaskList[1][523] = 
{	
	AcceptNPC = 353,						-- 接受任务NPC
	SubmitNPC = 353,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1522},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_133", 50 ,{12,72,184}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100523,			-- 提交任务剧情ID
}
TaskList[1][524] = 
{	
	AcceptNPC = 353,						-- 接受任务NPC
	SubmitNPC = 353,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1523},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 74,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100524,			-- 提交任务剧情ID
}
TaskList[1][525] = 
{	
	AcceptNPC = 353,						-- 接受任务NPC
	SubmitNPC = 56,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1524},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100525,			-- 提交任务剧情ID
}
TaskList[1][526] = 
{	
	AcceptNPC = 56,						-- 接受任务NPC
	SubmitNPC = 353,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1525},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_131", 50 ,{12,54,225},"木精傀儡石"},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100526,			-- 提交任务剧情ID
}
TaskList[1][527] = 
{	
	AcceptNPC = 353,						-- 接受任务NPC
	SubmitNPC = 353,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1526},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_132", 50 ,{12,89,213},"刀兵傀儡石"},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100527,			-- 提交任务剧情ID
}
TaskList[1][528] = 
{	
	AcceptNPC = 353,						-- 接受任务NPC
	SubmitNPC = 56,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1527},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_133", 50 ,{12,68,184},"青铜傀儡石"},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100528,			-- 提交任务剧情ID
}
TaskList[1][529] = 
{	
	AcceptNPC = 56,						-- 接受任务NPC
	SubmitNPC = 56,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1528},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 75,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100529,			-- 提交任务剧情ID
}
TaskList[1][530] = 
{	
	AcceptNPC = 56,						-- 接受任务NPC
	SubmitNPC = 353,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1529},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_134", 50 ,{12,113,231}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100530,			-- 提交任务剧情ID
}
TaskList[1][531] = 
{	
	AcceptNPC = 353,						-- 接受任务NPC
	SubmitNPC = 315,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1530},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100531,			-- 提交任务剧情ID
}
TaskList[1][532] = 
{	
	AcceptNPC = 315,						-- 接受任务NPC
	SubmitNPC = 151,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1531},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100532,			-- 提交任务剧情ID
}
TaskList[1][533] = 
{	
	AcceptNPC = 151,						-- 接受任务NPC
	SubmitNPC = 353,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1532},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_135", 50 ,{12,98,141},"花心"},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100533,			-- 提交任务剧情ID
}
TaskList[1][534] = 
{	
	AcceptNPC = 353,						-- 接受任务NPC
	SubmitNPC = 353,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1533},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 76,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100534,			-- 提交任务剧情ID
}
TaskList[1][535] = 
{	
	AcceptNPC = 353,						-- 接受任务NPC
	SubmitNPC = 353,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1534},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_136", 50 ,{12,119,168}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100535,			-- 提交任务剧情ID
}
TaskList[1][536] = 
{	
	AcceptNPC = 353,						-- 接受任务NPC
	SubmitNPC = 353,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1535},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_133", 50 ,{12,92,179}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100536,			-- 提交任务剧情ID
}
TaskList[1][537] = 
{	
	AcceptNPC = 353,						-- 接受任务NPC
	SubmitNPC = 353,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1536},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_134", 50 ,{12,115,212}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100537,			-- 提交任务剧情ID
}
TaskList[1][538] = 
{	
	AcceptNPC = 353,						-- 接受任务NPC
	SubmitNPC = 49,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1537},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100538,			-- 提交任务剧情ID
}
TaskList[1][539] = 
{	
	AcceptNPC = 49,						-- 接受任务NPC
	SubmitNPC = 49,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1538},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 77,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100539,			-- 提交任务剧情ID
}
TaskList[1][540] = 
{	
	AcceptNPC = 49,						-- 接受任务NPC
	SubmitNPC = 56,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1539},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100540,			-- 提交任务剧情ID
}
TaskList[1][541] = 
{	
	AcceptNPC = 56,						-- 接受任务NPC
	SubmitNPC = 202,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1540},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100541,			-- 提交任务剧情ID
}
TaskList[1][542] = 
{	
	AcceptNPC = 202,						-- 接受任务NPC
	SubmitNPC = 202,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1541},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100542,			-- 提交任务剧情ID
}
TaskList[1][543] = 
{	
	AcceptNPC = 202,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1542},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 78,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2200000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100543,			-- 提交任务剧情ID
}
TaskList[1][544] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1543},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_137", 50 ,{12,69,162}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2200000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100544,			-- 提交任务剧情ID
}
TaskList[1][545] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1544},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_138", 50 ,{12,58,130}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2200000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100545,			-- 提交任务剧情ID
}
TaskList[1][546] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1545},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 79,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100546,			-- 提交任务剧情ID
}
TaskList[1][547] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1546},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_139", 50 ,{12,34,100}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100547,			-- 提交任务剧情ID
}
TaskList[1][548] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1547},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_141", 50 ,{12,16,71}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100548,			-- 提交任务剧情ID
}
TaskList[1][549] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1548},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100549,			-- 提交任务剧情ID
}
TaskList[1][550] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1549},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 80,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2600000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100550,			-- 提交任务剧情ID
}
TaskList[1][551] = 
{	
	AcceptNPC = 48,						-- 接受任务NPC
	SubmitNPC = 350,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1550},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2600000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100551,			-- 提交任务剧情ID
}
TaskList[1][552] = 
{	
	AcceptNPC = 350,						-- 接受任务NPC
	SubmitNPC = 350,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1551},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_140", 50 ,{12,75,62}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2600000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100552,			-- 提交任务剧情ID
}
TaskList[1][553] = 
{	
	AcceptNPC = 350,						-- 接受任务NPC
	SubmitNPC = 350,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1552},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_142", 50 ,{12,40,25}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2600000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100553,			-- 提交任务剧情ID
}
TaskList[1][554] = 
{	
	AcceptNPC = 350,						-- 接受任务NPC
	SubmitNPC = 350,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1553},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_143", 50 ,{12,81,29}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2600000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100554,			-- 提交任务剧情ID
}
TaskList[1][555] = 
{	
	AcceptNPC = 350,						-- 接受任务NPC
	SubmitNPC = 350,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1554},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_144", 50 ,{12,112,63}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2600000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100555,			-- 提交任务剧情ID
}
TaskList[1][556] = 
{	
	AcceptNPC = 350,						-- 接受任务NPC
	SubmitNPC = 350,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1555},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 81,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100556,			-- 提交任务剧情ID
}
TaskList[1][557] = 
{	
	AcceptNPC = 350,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1556},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100557,			-- 提交任务剧情ID
}
TaskList[1][558] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1557},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_135", 50 ,{12,87,131}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100558,			-- 提交任务剧情ID
}
TaskList[1][559] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1558},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_137", 50 ,{12,63,144}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100559,			-- 提交任务剧情ID
}
TaskList[1][560] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1559},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_138", 50 ,{12,71,118}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100560,			-- 提交任务剧情ID
}
TaskList[1][561] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1560},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 82,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3200000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100561,			-- 提交任务剧情ID
}
TaskList[1][562] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1561},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_139", 50 ,{12,42,89}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3200000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100562,			-- 提交任务剧情ID
}
TaskList[1][563] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1562},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_141", 50 ,{12,24,65}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3200000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100563,			-- 提交任务剧情ID
}
TaskList[1][564] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1563},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_140", 50 ,{12,87,44}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3200000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100564,			-- 提交任务剧情ID
}
TaskList[1][565] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1564},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 83,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100565,			-- 提交任务剧情ID
}
TaskList[1][566] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1565},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_142", 50 ,{12,56,40}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100566,			-- 提交任务剧情ID
}
TaskList[1][567] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1566},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_143", 50 ,{12,96,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100567,			-- 提交任务剧情ID
}
TaskList[1][568] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 354,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1567},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_144", 50 ,{12,111,96}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100568,			-- 提交任务剧情ID
}
TaskList[1][569] = 
{	
	AcceptNPC = 354,						-- 接受任务NPC
	SubmitNPC = 350,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1568},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100569,			-- 提交任务剧情ID
}
TaskList[1][570] = 
{	
	AcceptNPC = 350,						-- 接受任务NPC
	SubmitNPC = 350,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1569},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		level = 84,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100570,			-- 提交任务剧情ID
}
TaskList[1][571] = 
{	
	AcceptNPC = 350,						-- 接受任务NPC
	SubmitNPC = 356,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1570},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100571,			-- 提交任务剧情ID
}
TaskList[1][572] = 
{	
	AcceptNPC = 356,						-- 接受任务NPC
	SubmitNPC = 350,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1571},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100572,			-- 提交任务剧情ID
}
TaskList[1][573] = 
{	
	AcceptNPC = 350,						-- 接受任务NPC
	SubmitNPC = 48,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1572},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100573,			-- 提交任务剧情ID
}

TaskList[1][574] = {
	AcceptNPC = 48,
	SubmitNPC = 48,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1573},
	},
	CompleteCondition = {
		level = 85,
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100574,
}
TaskList[1][575] = {
	AcceptNPC = 48,
	SubmitNPC = 354,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1574},
	},
	CompleteCondition = {},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100575,
}
TaskList[1][576] = {
	AcceptNPC = 354,
	SubmitNPC = 354,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1575},
	},
	CompleteCondition = {
		kill = {"M_135",50,{12,87,131,},},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100576,
}
TaskList[1][577] = {
	AcceptNPC = 354,
	SubmitNPC = 354,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1576},
	},
	CompleteCondition = {
		kill = {"M_137",50,{12,63,144,},},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100577,
}
TaskList[1][578] = {
	AcceptNPC = 354,
	SubmitNPC = 354,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1577},
	},
	CompleteCondition = {
		level = 86,
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100578,
}
TaskList[1][579] = {
	AcceptNPC = 354,
	SubmitNPC = 354,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1578},
	},
	CompleteCondition = {
		kill = {"M_139",50,{12,42,89,},},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100579,
}
TaskList[1][580] = {
	AcceptNPC = 354,
	SubmitNPC = 354,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1579},
	},
	CompleteCondition = {
		kill = {"M_141",50,{12,24,65,},},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100580,
}
TaskList[1][581] = {
	AcceptNPC = 354,
	SubmitNPC = 357,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1580},
	},
	CompleteCondition = {
		kill = {"M_138",50,{12,71,118,},},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100581,
}
TaskList[1][582] = {
	AcceptNPC = 357,
	SubmitNPC = 354,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1581},
	},
	CompleteCondition = {},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100582,
}
TaskList[1][583] = {
	AcceptNPC = 354,
	SubmitNPC = 354,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1582},
	},
	CompleteCondition = {
		level = 87,
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100583,
}
TaskList[1][584] = {
	AcceptNPC = 354,
	SubmitNPC = 354,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1583},
	},
	CompleteCondition = {
		kill = {"M_140",50,{12,87,44,},},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100584,
}
TaskList[1][585] = {
	AcceptNPC = 354,
	SubmitNPC = 48,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1584},
	},
	CompleteCondition = {},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100585,
}
TaskList[1][586] = {
	AcceptNPC = 48,
	SubmitNPC = 155,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1585},
	},
	CompleteCondition = {},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100586,
}
TaskList[1][587] = {
	AcceptNPC = 155,
	SubmitNPC = 155,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1586},
	},
	CompleteCondition = {
		level = 88,
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100587,
}
TaskList[1][588] = {
	AcceptNPC = 155,
	SubmitNPC = 354,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1587},
	},
	CompleteCondition = {},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100588,
}
TaskList[1][589] = {
	AcceptNPC = 354,
	SubmitNPC = 354,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1588},
	},
	CompleteCondition = {
		kill = {"M_142",50,{12,56,40,},},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100589,
}
TaskList[1][590] = {
	AcceptNPC = 354,
	SubmitNPC = 354,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1589},
	},
	CompleteCondition = {
		items = {{10001,1,{3,58,155,100001,},},},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100590,
}
TaskList[1][591] = {
	AcceptNPC = 354,
	SubmitNPC = 354,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1590},
	},
	CompleteCondition = {
		level = 89,
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100591,
}
TaskList[1][592] = {
	AcceptNPC = 354,
	SubmitNPC = 354,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1591},
	},
	CompleteCondition = {
		items = {{10006,1,{10,55,153,100015,},},},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100592,
}
TaskList[1][593] = {
	AcceptNPC = 354,
	SubmitNPC = 354,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1592},
	},
	CompleteCondition = {
		kill = {"M_143",50,{12,96,20,},},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100593,
}
TaskList[1][594] = {
	AcceptNPC = 354,
	SubmitNPC = 354,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1593},
	},
	CompleteCondition = {
		kill = {"M_144",50,{12,111,96,},},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100594,
}
TaskList[1][595] = {
	AcceptNPC = 354,
	SubmitNPC = 354,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1594},
	},
	CompleteCondition = {
		level = 90,
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100595,
}
TaskList[1][596] = {
	AcceptNPC = 354,
	SubmitNPC = 48,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1595},
	},
	CompleteCondition = {
		
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100596,
}
TaskList[1][597] = {
	AcceptNPC = 48,
	SubmitNPC = 371,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1596},
	},
	CompleteCondition = {
		
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100597,
}
TaskList[1][598] = {
	AcceptNPC = 371,
	SubmitNPC = 372,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1597},
	},
	CompleteCondition = {
		
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100598,
}

TaskList[1][600] = {
	AcceptNPC = 372,
	SubmitNPC = 48,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1598},
	},
	CompleteCondition = {
		
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100600,
}
TaskList[1][601] = {
	AcceptNPC = 48,
	SubmitNPC = 373,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1600},
	},
	CompleteCondition = {
		level = 91,
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100601,
}
TaskList[1][602] = {
	AcceptNPC = 373,
	SubmitNPC = 373,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1601},
	},
	CompleteCondition = {
		kill = { "M_134", 50 ,{12,115,212},"木之灵"},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100602,
}
TaskList[1][603] = {
	AcceptNPC = 373,
	SubmitNPC = 373,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1602},
	},
	CompleteCondition = {
		kill = { "M_142", 50 ,{12,56,40},"火之灵"},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100603,
}
TaskList[1][604] = {
	AcceptNPC = 373,
	SubmitNPC = 373,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1603},
	},
	CompleteCondition = {
		kill = { "M_139", 50 ,{12,42,89},"土之灵"},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100604,
}
TaskList[1][605] = {
	AcceptNPC = 373,
	SubmitNPC = 373,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1604},
	},
	CompleteCondition = {
		level = 92,
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100605,
}
TaskList[1][606] = {
	AcceptNPC = 373,
	SubmitNPC = 373,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1605},
	},
	CompleteCondition = {
		kill = { "M_144", 50 ,{12,111,96},"金之灵"},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100606,
}
TaskList[1][607] = {
	AcceptNPC = 373,
	SubmitNPC = 373,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1606},
	},
	CompleteCondition = {
		kill = { "M_143", 50 ,{12,96,20},"水之灵"},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100607,
}
TaskList[2][82] = {
	AcceptNPC = 373,
	SubmitNPC = 48,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1607},
	},
	CompleteCondition = {
		
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 200082,
}

TaskList[1][608] = {
	AcceptNPC = 48,
	SubmitNPC = 373,
	NoDrop = 1,
	AcceptCondition = {
		completed = {2082},
	},
	CompleteCondition = {
		level = 93,
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100608,
}
TaskList[1][609] = {
	AcceptNPC = 373,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1608},
	},
	CompleteCondition = {
		kill = {"M_146",50,{13,9,109}},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100609,
}
TaskList[1][610] = {
	AcceptNPC = 370,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1609},
	},
	CompleteCondition = {
		kill = {"M_147",50,{13,40,124}},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100610,
}
TaskList[1][611] = {
	AcceptNPC = 370,
	SubmitNPC = 374,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1610},
	},
	CompleteCondition = {
		
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100611,
}
TaskList[1][612] = {
	AcceptNPC = 374,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1611},
	},
	CompleteCondition = {
		
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100612,
}
TaskList[1][613] = {
	AcceptNPC = 370,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1612},
	},
	CompleteCondition = {
		level = 94,
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100613,
}
TaskList[1][614] = {
	AcceptNPC = 370,
	SubmitNPC = 155,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1613},
	},
	CompleteCondition = {
	
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100614,
}
TaskList[1][615] = {
	AcceptNPC = 155,
	SubmitNPC = 378,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1614},
	},
	CompleteCondition = {
	
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100615,
}

TaskList[2][83] = {
	AcceptNPC = 378,
	SubmitNPC = 155,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1615},
	},
	CompleteCondition = {
	
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 200083,
}

TaskList[1][616] = {
	AcceptNPC = 155,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {2083},
	},
	CompleteCondition = {
	level = 95,
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100616,
}
TaskList[1][617] = {
	AcceptNPC = 370,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1616},
	},
	CompleteCondition = {
		kill = {"M_148",50,{13,13,71}},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100617,
}
TaskList[1][618] = {
	AcceptNPC = 370,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1617},
	},
	CompleteCondition = {
		kill = {"M_149",50,{13,24,230}},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100618,
}
TaskList[1][619] = {
	AcceptNPC = 370,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1618},
	},
	CompleteCondition = {
		kill = {"M_150",50,{13,119,193}},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100619,
}
TaskList[1][620] = {
	AcceptNPC = 370,
	SubmitNPC = 48,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1619},
	},
	CompleteCondition = {
	
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100620,
}
TaskList[1][621] = {
	AcceptNPC = 48,
	SubmitNPC = 48,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1620},
	},
	CompleteCondition = {
		level = 96,
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100621,
}
TaskList[1][622] = {
	AcceptNPC = 48,
	SubmitNPC = 153,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1621},
	},
	CompleteCondition = {
	
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100622,
}
TaskList[1][623] = {
	AcceptNPC = 153,
	SubmitNPC = 153,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1622},
	},
	CompleteCondition = {
	   items = {{10006,1,{8,74,127,100027,},},},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100623,
}
TaskList[1][624] = {
	AcceptNPC = 153,
	SubmitNPC = 32,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1623},
	},
	CompleteCondition = {
	   
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100624,
}
TaskList[1][625] = {
	AcceptNPC = 32,
	SubmitNPC = 153,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1624},
	},
	CompleteCondition = {
	    items = {{10002,1,{1,70,154,100005,},},},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100625,
}
TaskList[1][626] = {
	AcceptNPC = 153,
	SubmitNPC = 153,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1625},
	},
	CompleteCondition = {
	    items = {{10006,1,{10,52,150,100014,},},},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100626,
}
TaskList[1][627] = {
	AcceptNPC = 153,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1626},
	},
	CompleteCondition = {
	    kill = {"M_151",50,{13,47,224}},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100627,
}
TaskList[1][628] = {
	AcceptNPC = 370,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1627},
	},
	CompleteCondition = {
	     kill = {"M_152",50,{13,75,212}},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100628,
}
TaskList[1][629] = {
	AcceptNPC = 370,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1628},
	},
	CompleteCondition = {
	     kill = {"M_153",50,{13,98,227}},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100629,
}
TaskList[1][630] = {
	AcceptNPC = 370,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1629},
	},
	CompleteCondition = {
	      level = 97,
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100630,
}
TaskList[1][631] = {
	AcceptNPC = 370,
	SubmitNPC = 375,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1630},
	},
	CompleteCondition = {
	      
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100631,
}
TaskList[1][632] = {
	AcceptNPC = 375,
	SubmitNPC = 375,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1631},
	},
	CompleteCondition = {
	   kill = {"M_154",50,{13,50,33}},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100632,
}
TaskList[1][633] = {
	AcceptNPC = 375,
	SubmitNPC = 376,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1632},
	},
	CompleteCondition = {
	      
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100633,
}
TaskList[1][634] = {
	AcceptNPC = 376,
	SubmitNPC = 377,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1633},
	},
	CompleteCondition = {
	      
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100634,
}

TaskList[2][84] = {
	AcceptNPC = 377,
	SubmitNPC = 375,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1634},
	},
	CompleteCondition = {
	      
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 200084,
}

TaskList[1][635] = {
	AcceptNPC = 375,
	SubmitNPC = 48,
	NoDrop = 1,
	AcceptCondition = {
		completed = {2084},
	},
	CompleteCondition = {
	      
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100635,
}
TaskList[1][636] = {
	AcceptNPC = 48,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1635},
	},
	CompleteCondition = {
	      
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100636,
}
TaskList[1][637] = {
	AcceptNPC = 370,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1636},
	},
	CompleteCondition = {
	    kill = {"M_155",50,{13,24,42}},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100637,
}
TaskList[1][638] = {
	AcceptNPC = 370,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1637},
	},
	CompleteCondition = {
	    kill = {"M_156",50,{13,48,77}},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100638,
}
TaskList[1][639] = {
	AcceptNPC = 370,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1638},
	},
	CompleteCondition = {
	    kill = {"M_157",50,{13,95,60}},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100639,
}
TaskList[1][640] = {
	AcceptNPC = 370,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1639},
	},
	CompleteCondition = {
	    level = 99,
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100640,
}
TaskList[1][641] = {
	AcceptNPC = 370,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1640},
	},
	CompleteCondition = {
	    kill = {"M_158",50,{13,87,68}},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100641,
}

TaskList[1][643] = {
	AcceptNPC = 370,
	SubmitNPC = 370,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1641},
	},
	CompleteCondition = {
	    kill = {"M_159",50,{13,112,129}},
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100643,
}

TaskList[1][646] = {
	AcceptNPC = 370,
	SubmitNPC = 49,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1643},
	},
	CompleteCondition = {
	    
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100646,
}
TaskList[1][647] = {
	AcceptNPC = 49,
	SubmitNPC = 49,
	NoDrop = 1,
	AcceptCondition = {
		completed = {1646},
	},
	CompleteCondition = {
	    level = 100,
	},
	CompleteAwards = {
		[1] = 10000,
		[2] = 4000000,
		[5] = 10000,
	},
	StoryID = 100647,
}







TaskList[3] = 
{
}
--加入帮会支线
TaskList[3][1] = 
{	
	AcceptNPC = 38,						-- 接受任务NPC
	SubmitNPC = 38,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	ServerCompleteEvent = 1,	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1179},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		faction = 1,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[1] = 50000,
	},
	    
	StoryID = 300001,			-- 提交任务剧情ID
}
--宝石镶嵌
TaskList[3][2] = 
{	
	AcceptNPC = 38,						-- 接受任务NPC
	SubmitNPC = 38,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1324},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{607,1,1}},
	},
	    
	StoryID = 300002,			-- 提交任务剧情ID
}

--装备强化
TaskList[3][3] = 
{	
	AcceptNPC = 38,						-- 接受任务NPC
	SubmitNPC = 38,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3002},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{		
		[2] = 100000,
		[1] = 200000,	
	},
	    
	StoryID = 300003,			-- 提交任务剧情ID
}
--家将培养
TaskList[3][4] = 
{	
	AcceptNPC = 38,						-- 接受任务NPC
	SubmitNPC = 38,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3003},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[5] = 200000,
	},
	    
	StoryID = 300004,			-- 提交任务剧情ID
}
--坐骑培养
TaskList[3][5] = 
{	
	AcceptNPC = 38,						-- 接受任务NPC
	SubmitNPC = 38,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3004},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		  
	},
	CompleteAwards = 					-- 完成任务奖励
	{		
		[2] = 500000,
			
	},
	    
	StoryID = 300005,			-- 提交任务剧情ID
}
--分解装备
TaskList[3][6] = 
{	
	AcceptNPC = 38,						-- 接受任务NPC
	SubmitNPC = 38,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1203},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{604,20,1}},
	},
	    
	StoryID = 300006,			-- 提交任务剧情ID
}
--装备洗练
TaskList[3][7] = 
{	
	AcceptNPC = 38,						-- 接受任务NPC
	SubmitNPC = 38,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3006},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
	},
	    
	StoryID = 300007,			-- 提交任务剧情ID
}


--组队副本
TaskList[3][8] = 
{	
	AcceptNPC = 49,						-- 接受任务NPC
	SubmitNPC = 49,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1378},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 500000,
		[3] = {{625,2,1}},
	},
	    
	StoryID = 300008,			-- 提交任务剧情ID
}
TaskList[3][9] = 
{	
	AcceptNPC = 49,						-- 接受任务NPC
	SubmitNPC = 49,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3008},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		
	},
	    
	StoryID = 300009,			-- 提交任务剧情ID
}
--降魔录
TaskList[3][10] = 
{	
	AcceptNPC = 56,						-- 接受任务NPC
	SubmitNPC = 56,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1256},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{		
		[2] = 100000,
		[1] = 20000,
		[3] = {{724,5,1}},
	},
	QuickSub = 3011,			--远程提交任务并接受下一个任务    
	StoryID = 300010,			-- 提交任务剧情ID
}
TaskList[3][11] = 
{	
	AcceptNPC = 56,						-- 接受任务NPC
	SubmitNPC = 56,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3010},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[1] = 30000,
		[3] = {{724,5,1}},
	},
	QuickSub = 3012,			--远程提交任务并接受下一个任务    
	StoryID = 300011,			-- 提交任务剧情ID
}
TaskList[3][12] = 
{	
	AcceptNPC = 56,						-- 接受任务NPC
	SubmitNPC = 56,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3011},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[1] = 40000,
		[3] = {{724,5,1}},
	},
	QuickSub = 3013,			--远程提交任务并接受下一个任务        
	StoryID = 300012,			-- 提交任务剧情ID
}
TaskList[3][13] = 
{	
	AcceptNPC = 56,						-- 接受任务NPC
	SubmitNPC = 56,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3012},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[1] = 50000,
		[3] = {{724,5,1}},
	},
	QuickSub = 3014,			--远程提交任务并接受下一个任务        
	StoryID = 300013,			-- 提交任务剧情ID
}
TaskList[3][14] = 
{	
	AcceptNPC = 56,						-- 接受任务NPC
	SubmitNPC = 56,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3013},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[1] = 60000,
		[3] = {{724,5,1}},
	},
	QuickSub = 3015,			--远程提交任务并接受下一个任务        
	StoryID = 300014,			-- 提交任务剧情ID
}
TaskList[3][15] = 
{	
	AcceptNPC = 56,						-- 接受任务NPC
	SubmitNPC = 56,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3014},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[1] = 70000,
		[3] = {{718,3,1}},
	},
	QuickSub = 3016,			--远程提交任务并接受下一个任务        
	StoryID = 300015,			-- 提交任务剧情ID
}
TaskList[3][16] = 
{	
	AcceptNPC = 56,						-- 接受任务NPC
	SubmitNPC = 56,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3015},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[1] = 80000,
		[3] = {{718,3,1}},
	},
	QuickSub = 3017,			--远程提交任务并接受下一个任务        
	StoryID = 300016,			-- 提交任务剧情ID
}
TaskList[3][17] = 
{	
	AcceptNPC = 56,						-- 接受任务NPC
	SubmitNPC = 56,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3016},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[1] = 90000,
		[3] = {{718,3,1}},
	},
	QuickSub = 1,			--远程提交任务并接受下一个任务        
	StoryID = 300017,			-- 提交任务剧情ID
}

TaskList[3][30] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1180},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		
		[2] = 100000,
	},	    
	StoryID = 300030,			-- 提交任务剧情ID
}
TaskList[3][31] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		level = 999,
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[1] = 100000,
		[2] = 200000,
	},	    
	StoryID = 300031,			-- 提交任务剧情ID
}


TaskList[3][35] = 
{	
	AcceptNPC = 49,						-- 接受任务NPC
	SubmitNPC = 49,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		level = 999,
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
		[5] = 100000,	
		
	},	    
	StoryID = 300035,			-- 提交任务剧情ID
}
TaskList[3][40] = 
{	
	AcceptNPC = 49,						-- 接受任务NPC
	SubmitNPC = 49,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={2027},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[1] = 100000,
		[2] = 200000,
	},	    
	StoryID = 300040,			-- 提交任务剧情ID
}

TaskList[3][42] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 49,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		--level = 999,
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[1] = 200000,
		[5] = 200000,
		[3] = {{5625,1,1}},
	},	    
	StoryID = 300042,			-- 提交任务剧情ID
	QuickSub = 1,			--远程提交任务并接受下一个任务       
}
TaskList[3][45] = 
{	
	AcceptNPC = 36,						-- 接受任务NPC
	SubmitNPC = 36,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1377},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[3] = {{1108,5,1}},
	},	    
	StoryID = 300045,			-- 提交任务剧情ID
}
TaskList[3][46] = 
{	
	AcceptNPC = 38,						-- 接受任务NPC
	SubmitNPC = 38,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		level = 999,
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 500000,
		--[3] = {{1110,1,1}},
	},	    
	StoryID = 300046,			-- 提交任务剧情ID
}


TaskList[3][100] = 
{	
	AcceptNPC = 104,						-- 接受任务NPC
	SubmitNPC = 104,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1377},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
	},	    
	StoryID = 300100,			-- 提交任务剧情ID
}
TaskList[3][101] = 
{	
	AcceptNPC = 104,						-- 接受任务NPC
	SubmitNPC = 104,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_259", 20 ,{22,28,12}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
	},	    
	StoryID = 300101,			-- 提交任务剧情ID
}
TaskList[3][102] = 
{	
	AcceptNPC = 104,						-- 接受任务NPC
	SubmitNPC = 104,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3101},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_260", 20 ,{22,19,51}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
	},	    
	StoryID = 300102,			-- 提交任务剧情ID
}
TaskList[3][103] = 
{	
	AcceptNPC = 104,						-- 接受任务NPC
	SubmitNPC = 104,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3102},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_261", 20 ,{22,36,67}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
	},	    
	StoryID = 300103,			-- 提交任务剧情ID
}


TaskList[3][111] = 
{	
	AcceptNPC = 157,						-- 接受任务NPC
	SubmitNPC = 157,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1403},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
	},	    
	StoryID = 300111,			-- 提交任务剧情ID
}
TaskList[3][112] = 
{	
	AcceptNPC = 157,						-- 接受任务NPC
	SubmitNPC = 157,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3111},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_255", 20 ,{31,10,96}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
	},	    
	StoryID = 300112,			-- 提交任务剧情ID
}
TaskList[3][113] = 
{	
	AcceptNPC = 157,						-- 接受任务NPC
	SubmitNPC = 157,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3112},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_256", 20 ,{31,24,63}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
	},	    
	StoryID = 300113,			-- 提交任务剧情ID
}
TaskList[3][114] = 
{	
	AcceptNPC = 157,						-- 接受任务NPC
	SubmitNPC = 157,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3113},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_257", 20 ,{31,6,42}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
	},	    
	StoryID = 300114,			-- 提交任务剧情ID
}
--45级
TaskList[3][115] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1422},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
	},	    
	StoryID = 300115,			-- 提交任务剧情ID
}
TaskList[3][116] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3115},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_065",30,{10,12,83}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
	},	    
	StoryID = 300116,			-- 提交任务剧情ID
}
TaskList[3][117] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3116},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_039",30,{10,18,157}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
	},	    
	StoryID = 300117,			-- 提交任务剧情ID
}
TaskList[3][118] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3117},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_040",30,{10,50,123}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
	},	    
	StoryID = 300118,			-- 提交任务剧情ID
}
TaskList[3][119] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3118},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_072",30,{10,43,101}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
	},	    
	StoryID = 300119,			-- 提交任务剧情ID
}
TaskList[3][120] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3119},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_073",30,{10,60,145}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
	},	    
	StoryID = 300120,			-- 提交任务剧情ID
}

--47级
TaskList[3][121] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={1433},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
	},	    
	StoryID = 300121,			-- 提交任务剧情ID
}
TaskList[3][122] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3121},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_066",40,{10,39,72}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
	},	    
	StoryID = 300122,			-- 提交任务剧情ID
}
TaskList[3][123] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3122},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_041",40,{10,37,54}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
	},	    
	StoryID = 300123,			-- 提交任务剧情ID
}
TaskList[3][124] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3123},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_069",40,{10,40,38}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
	},	    
	StoryID = 300124,			-- 提交任务剧情ID
}
TaskList[3][125] = 
{	
	AcceptNPC = 306,						-- 接受任务NPC
	SubmitNPC = 306,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={3124},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_070",40,{10,42,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
	},	    
	StoryID = 300125,			-- 提交任务剧情ID
}










--日常任务
TaskList[4] = 
{
}
TaskList[4][1] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		level = {38,44},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_350", 1000},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 375000,
	},	    
	StoryID = 400001,			-- 提交任务剧情ID
	QuickClear = 30,
	task = {4,2},	-- 发送给后台接受任务
}
TaskList[4][2] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4001},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_350", 1500 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 525000,
	},	    
	StoryID = 400002,			-- 提交任务剧情ID
	QuickClear = 30,
	task = {4,3},	-- 发送给后台接受任务
}
TaskList[4][3] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4002},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_350", 2000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 600000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400003,			-- 提交任务剧情ID
	QuickClear = 30,
}

TaskList[4][6] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		level = {45,49},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_351", 1000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 437500,
		
	},	    
	StoryID = 400006,			-- 提交任务剧情ID
	QuickClear = 30,
	task = {4,7},	-- 发送给后台接受任务
}
TaskList[4][7] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4006},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_351", 1500 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 612500,
		
	},	    
	StoryID = 400007,			-- 提交任务剧情ID
	QuickClear = 30,
	task = {4,8},	-- 发送给后台接受任务
}
TaskList[4][8] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4007},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_351", 2000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400008,			-- 提交任务剧情ID
	QuickClear = 30,
}

TaskList[4][11] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		level = {50,54},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_352", 1000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 475000,
		
	},	    
	StoryID = 400011,			-- 提交任务剧情ID
	QuickClear = 30,
	task = {4,12},	-- 发送给后台接受任务
}
TaskList[4][12] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4011},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_352", 1500 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 665000,
		
	},	    
	StoryID = 400012,			-- 提交任务剧情ID
	QuickClear = 30,
	task = {4,13},	-- 发送给后台接受任务
}
TaskList[4][13] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4012},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_352", 2000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 760000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400013,			-- 提交任务剧情ID
	QuickClear = 30,
}


TaskList[4][16] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		level = {55,59},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_353", 1000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 500000,
		
	},	    
	StoryID = 400016,			-- 提交任务剧情ID
	QuickClear = 30,
	task = {4,17},	-- 发送给后台接受任务
}
TaskList[4][17] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4016},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_353", 1500 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		
	},	    
	StoryID = 400017,			-- 提交任务剧情ID
	QuickClear = 30,
	task = {4,18},	-- 发送给后台接受任务
}
TaskList[4][18] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4017},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_353", 2000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 800000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400018,			-- 提交任务剧情ID
	QuickClear = 30,
}


TaskList[4][21] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		level = {60,64},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_354", 1000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 625000,
		
	},	    
	StoryID = 400021,			-- 提交任务剧情ID
	QuickClear = 30,
	task = {4,22},	-- 发送给后台接受任务
}
TaskList[4][22] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4021},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_354", 1500 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 875000,
		
	},	    
	StoryID = 400022,			-- 提交任务剧情ID
	QuickClear = 30,
	task = {4,23},	-- 发送给后台接受任务
}
TaskList[4][23] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4022},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_354", 2000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400023,			-- 提交任务剧情ID
	QuickClear = 30,
}


TaskList[4][26] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		level = {65,69},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_355", 1000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 700000,
		
	},	    
	StoryID = 400026,			-- 提交任务剧情ID
	QuickClear = 30,
	task = {4,27},	-- 发送给后台接受任务
}
TaskList[4][27] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4026},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_355", 1500 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		
	},	    
	StoryID = 400027,			-- 提交任务剧情ID
	QuickClear = 30,
	task = {4,28},	-- 发送给后台接受任务
}
TaskList[4][28] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4027},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_355", 2000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1200000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400028,			-- 提交任务剧情ID
	QuickClear = 30,
}

TaskList[4][31] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		level = {70,74},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_356", 1000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1500000,
		
	},	    
	StoryID = 400031,			-- 提交任务剧情ID
	QuickClear = 30,
	task = {4,32},	-- 发送给后台接受任务
}
TaskList[4][32] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4031},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_356", 1500 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2100000,
		
	},	    
	StoryID = 400032,			-- 提交任务剧情ID
	QuickClear = 30,
	task = {4,33},	-- 发送给后台接受任务
}
TaskList[4][33] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4032},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_356", 2000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2400000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400033,			-- 提交任务剧情ID
	QuickClear = 30,
}

TaskList[4][36] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		level = {75,79},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_357", 1000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1800000,
		
	},	    
	StoryID = 400036,			-- 提交任务剧情ID
	QuickClear = 30,
	task = {4,37},	-- 发送给后台接受任务
}
TaskList[4][37] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4036},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_357", 1500 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2600000,
		
	},	    
	StoryID = 400037,			-- 提交任务剧情ID
	QuickClear = 30,
	task = {4,38},	-- 发送给后台接受任务
}
TaskList[4][38] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4037},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_357", 2000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3000000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400038,			-- 提交任务剧情ID
	QuickClear = 30,
}
TaskList[4][41] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		level={80,84},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_358", 1000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2000000,
	},	    
	StoryID = 400041,			-- 提交任务剧情ID
	QuickClear = 30,
}
TaskList[4][42] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4041},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_358", 1500 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2800000,
	},	    
	StoryID = 400042,			-- 提交任务剧情ID
	QuickClear = 30,
}
TaskList[4][43] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4042},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_358", 2000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3200000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400043,			-- 提交任务剧情ID
	QuickClear = 30,
}
TaskList[4][46] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		level={85,89},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_359", 1000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2200000,
	},	    
	StoryID = 400046,			-- 提交任务剧情ID
	QuickClear = 30,
}
TaskList[4][47] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4046},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_359", 1500 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3000000,
	},	    
	StoryID = 400047,			-- 提交任务剧情ID
	QuickClear = 30,
}
TaskList[4][48] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4047},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_359", 2000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3400000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400048,			-- 提交任务剧情ID
	QuickClear = 30,	
}
TaskList[4][51] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		level={90,94},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_360", 1000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2400000,
	},	    
	StoryID = 400051,			-- 提交任务剧情ID
	QuickClear = 30,
}
TaskList[4][52] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4051},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_360", 1500 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3200000,
	},	    
	StoryID = 400052,			-- 提交任务剧情ID
	QuickClear = 30,
}
TaskList[4][53] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4052},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_360", 2000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3600000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400053,			-- 提交任务剧情ID
	QuickClear = 30,	
}
TaskList[4][56] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		level={95,999},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_361", 1000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 2600000,
	},	    
	StoryID = 400056,			-- 提交任务剧情ID
	QuickClear = 30,
}
TaskList[4][57] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4056},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_361", 1500 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3400000,
	},	    
	StoryID = 400057,			-- 提交任务剧情ID
	QuickClear = 30,
}
TaskList[4][58] = 
{	
	AcceptNPC = 57,						-- 接受任务NPC
	SubmitNPC = 57,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4057},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "GJ_361", 2000 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 3800000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400058,			-- 提交任务剧情ID
	QuickClear = 30,		
}

--帮会日常
TaskList[4][101] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		faction = 1,
		level = {30,39},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_018", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400101,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,102},	-- 发送给后台接受任务
	facidx = 1,
}
TaskList[4][102] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4101},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_019", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400102,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,103},	-- 发送给后台接受任务
	facidx = 2,
}
TaskList[4][103] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4102},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_017", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400103,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,104},	-- 发送给后台接受任务
	facidx = 3,
}
TaskList[4][104] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4103},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_018", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400104,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,105},	-- 发送给后台接受任务
	facidx = 4,
}
TaskList[4][105] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4104},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_019", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400105,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,160},	-- 发送给后台接受任务
	facidx = 5,
}
TaskList[4][160] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4105},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_017", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400160,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,161},	-- 发送给后台接受任务
	facidx = 6,
}
TaskList[4][161] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4160},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_018", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400161,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,162},	-- 发送给后台接受任务
	facidx = 7,
}
TaskList[4][162] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4161},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_019", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400162,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,163},	-- 发送给后台接受任务
	facidx = 8,
}
TaskList[4][163] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4162},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_017", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400163,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,164},	-- 发送给后台接受任务
	facidx = 9,
}
TaskList[4][164] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4163},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_018", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400164,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,165},	-- 发送给后台接受任务
	facidx = 10,
}
TaskList[4][165] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4164},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_019", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400165,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,166},	-- 发送给后台接受任务
	facidx = 11,
}
TaskList[4][166] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4165},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_017", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400166,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,167},	-- 发送给后台接受任务
	facidx = 12,
}
TaskList[4][167] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4166},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_018", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400167,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,168},	-- 发送给后台接受任务
	facidx = 13,
}
TaskList[4][168] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4167},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_019", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400168,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,169},	-- 发送给后台接受任务
	facidx = 14,
}
TaskList[4][169] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4168},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_017", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400169,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,170},	-- 发送给后台接受任务
	facidx = 15,
}
TaskList[4][170] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4169},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_018", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400170,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,171},	-- 发送给后台接受任务
	facidx = 16,
}
TaskList[4][171] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4170},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_019", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400171,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,172},	-- 发送给后台接受任务
	facidx = 17,
}
TaskList[4][172] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4171},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_017", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400172,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,173},	-- 发送给后台接受任务
	facidx = 18,
}
TaskList[4][173] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4172},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_018", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400173,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,174},	-- 发送给后台接受任务
	facidx = 19,
}
TaskList[4][174] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	LinkEnd = 1,						--环任务结束
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4173},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_019", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 30000,
		[3] = {{749,1,1},{682,1,1}},
	},	    
	StoryID = 400174,			-- 提交任务剧情ID
	QuickClear = 5,
	facidx = 20,
}



--帮会日常
TaskList[4][106] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		faction = 1,
		level = {40,44},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_259", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400106,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,107},	-- 发送给后台接受任务
	facidx = 1,
}
TaskList[4][107] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4106},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_260", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400107,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,108},	-- 发送给后台接受任务
	facidx = 2,
}
TaskList[4][108] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4107},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_261", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400108,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,109},	-- 发送给后台接受任务
	facidx = 3,
}
TaskList[4][109] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4108},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_259", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400109,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,110},	-- 发送给后台接受任务
	facidx = 4,
}
TaskList[4][110] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4109},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_261", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400110,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,180},	-- 发送给后台接受任务
	facidx = 5,
}
TaskList[4][180] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4110},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_259", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400180,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,181},	-- 发送给后台接受任务
	facidx = 6,
}
TaskList[4][181] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4180},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_260", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400181,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,182},	-- 发送给后台接受任务
	facidx = 7,
}
TaskList[4][182] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4181},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_261", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400182,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,183},	-- 发送给后台接受任务
	facidx = 8,
}
TaskList[4][183] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4182},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_259", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400183,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,184},	-- 发送给后台接受任务
	facidx = 9,
}
TaskList[4][184] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4183},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_260", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400184,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,185},	-- 发送给后台接受任务
	facidx = 10,
}
TaskList[4][185] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4184},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_261", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400185,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,186},	-- 发送给后台接受任务
	facidx = 11,
}
TaskList[4][186] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4185},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_259", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400186,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,187},	-- 发送给后台接受任务
	facidx = 12,
}
TaskList[4][187] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4186},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_260", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400187,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,188},	-- 发送给后台接受任务
	facidx = 13,
}
TaskList[4][188] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4187},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_261", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400188,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,189},	-- 发送给后台接受任务
	facidx = 14,
}
TaskList[4][189] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4188},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_259", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400189,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,190},	-- 发送给后台接受任务
	facidx = 15,
}
TaskList[4][190] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4189},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_260", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400190,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,191},	-- 发送给后台接受任务
	facidx = 16,
}
TaskList[4][191] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4190},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_261", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400191,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,192},	-- 发送给后台接受任务
	facidx = 17,
}
TaskList[4][192] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4191},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_259", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400192,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,193},	-- 发送给后台接受任务
	facidx = 18,
}
TaskList[4][193] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4192},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_260", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400193,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,194},	-- 发送给后台接受任务
	facidx = 19,
}
TaskList[4][194] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	LinkEnd = 1,						--环任务结束
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4193},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_261", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 40000,
		[3] = {{749,1,1},{682,1,1}},
	},	    
	StoryID = 400194,			-- 提交任务剧情ID
	QuickClear = 5,
	facidx = 20,
}



--帮会日常
TaskList[4][111] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		faction = 1,
		level = {45,49},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_255", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400111,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,112},	-- 发送给后台接受任务
	facidx = 1,
}
TaskList[4][112] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4111},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_256", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400112,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,113},	-- 发送给后台接受任务
	facidx = 2,
}
TaskList[4][113] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4112},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_257", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400113,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,114},	-- 发送给后台接受任务
	facidx = 3,
}
TaskList[4][114] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4113},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_257", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400114,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,115},	-- 发送给后台接受任务
	facidx = 4,
}
TaskList[4][115] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4114},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_258", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400115,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,200},	-- 发送给后台接受任务
	facidx = 5,
}
TaskList[4][200] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4115},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_255", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400200,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,201},	-- 发送给后台接受任务
	facidx = 6,
}
TaskList[4][201] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4200},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_256", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400201,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,202},	-- 发送给后台接受任务
	facidx = 7,
}
TaskList[4][202] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4201},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_257", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400202,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,203},	-- 发送给后台接受任务
	facidx = 8,
}
TaskList[4][203] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4202},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_257", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400203,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,204},	-- 发送给后台接受任务
	facidx = 9,
}
TaskList[4][204] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4203},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_258", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400204,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,205},	-- 发送给后台接受任务
	facidx = 10,
}
TaskList[4][205] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4204},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_255", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400205,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,206},	-- 发送给后台接受任务
	facidx = 11,
}
TaskList[4][206] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4205},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_256", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400206,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,207},	-- 发送给后台接受任务
	facidx = 12,
}
TaskList[4][207] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4206},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_257", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400207,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,208},	-- 发送给后台接受任务
	facidx = 13,
}
TaskList[4][208] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4207},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_257", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400208,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,209},	-- 发送给后台接受任务
	facidx = 14,
}
TaskList[4][209] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4208},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_258", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400209,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,210},	-- 发送给后台接受任务
	facidx = 15,
}
TaskList[4][210] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4209},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_255", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400210,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,211},	-- 发送给后台接受任务
	facidx = 16,
}
TaskList[4][211] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4210},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_256", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400211,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,212},	-- 发送给后台接受任务
	facidx = 17,
}
TaskList[4][212] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4211},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_257", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400212,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,213},	-- 发送给后台接受任务
	facidx = 18,
}
TaskList[4][213] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4212},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_257", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400213,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,214},	-- 发送给后台接受任务
	facidx = 19,
}
TaskList[4][214] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	LinkEnd = 1,						--环任务结束
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4213},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_258", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 50000,
		[3] = {{749,1,1},{682,1,1}},
	},	    
	StoryID = 400214,			-- 提交任务剧情ID
	QuickClear = 5,
	facidx = 20,
}



--帮会日常
TaskList[4][116] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		faction = 1,
		level = {50,59},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_262", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400116,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,117},	-- 发送给后台接受任务
	facidx = 1,
}
TaskList[4][117] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4116},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_263", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400117,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,118},	-- 发送给后台接受任务
	facidx = 2,
}
TaskList[4][118] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4117},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_264", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400118,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,119},	-- 发送给后台接受任务
	facidx = 3,
}
TaskList[4][119] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4118},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_265", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400119,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,120},	-- 发送给后台接受任务
	facidx = 4,
}
TaskList[4][120] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4119},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_265", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400120,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,220},	-- 发送给后台接受任务
	facidx = 5,
}
TaskList[4][220] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4120},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_262", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400220,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,221},	-- 发送给后台接受任务
	facidx = 6,
}
TaskList[4][221] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4220},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_263", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400221,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,222},	-- 发送给后台接受任务
	facidx = 7,
}
TaskList[4][222] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4221},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_264", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400222,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,223},	-- 发送给后台接受任务
	facidx = 8,
}
TaskList[4][223] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4222},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_265", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400223,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,224},	-- 发送给后台接受任务
	facidx = 9,
}
TaskList[4][224] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4223},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_265", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400224,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,225},	-- 发送给后台接受任务
	facidx = 10,
}
TaskList[4][225] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4224},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_262", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400225,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,226},	-- 发送给后台接受任务
	facidx = 11,
}
TaskList[4][226] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4225},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_263", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400226,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,227},	-- 发送给后台接受任务
	facidx = 12,
}
TaskList[4][227] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4226},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_264", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400227,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,228},	-- 发送给后台接受任务
	facidx = 13,
}
TaskList[4][228] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4227},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_265", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400228,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,229},	-- 发送给后台接受任务
	facidx = 14,
}
TaskList[4][229] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4228},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_265", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400229,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,230},	-- 发送给后台接受任务
	facidx = 15,
}
TaskList[4][230] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4229},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_262", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400230,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,231},	-- 发送给后台接受任务
	facidx = 16,
}
TaskList[4][231] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4230},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_263", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400231,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,232},	-- 发送给后台接受任务
	facidx = 17,
}
TaskList[4][232] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4231},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_264", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400232,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,233},	-- 发送给后台接受任务
	facidx = 18,
}
TaskList[4][233] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4232},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_265", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400233,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,234},	-- 发送给后台接受任务
	facidx = 19,
}
TaskList[4][234] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	LinkEnd = 1,						--环任务结束
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4233},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_265", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 80000,
		[3] = {{749,1,1},{682,1,1}},
	},	    
	StoryID = 400234,			-- 提交任务剧情ID
	QuickClear = 5,
	facidx = 20,
}


--帮会日常
TaskList[4][121] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		faction = 1,
		level = {60,120},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400121,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,122},	-- 发送给后台接受任务
	facidx = 1,
}
TaskList[4][122] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4121},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400122,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,123},	-- 发送给后台接受任务
	facidx = 2,
}
TaskList[4][123] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4122},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_267", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400123,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,124},	-- 发送给后台接受任务
	facidx = 3,
}
TaskList[4][124] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4123},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_268", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400124,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,125},	-- 发送给后台接受任务
	facidx = 4,
}
TaskList[4][125] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4124},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_269", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400125,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,240},	-- 发送给后台接受任务
	facidx = 5,
}
TaskList[4][240] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4125},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400240,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,241},	-- 发送给后台接受任务
	facidx = 6,
}
TaskList[4][241] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4240},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400241,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,242},	-- 发送给后台接受任务
	facidx = 7,
}
TaskList[4][242] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4241},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_267", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400242,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,243},	-- 发送给后台接受任务
	facidx = 8,
}
TaskList[4][243] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4242},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_268", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400243,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,244},	-- 发送给后台接受任务
	facidx = 9,
}
TaskList[4][244] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4243},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_269", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400244,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,245},	-- 发送给后台接受任务
	facidx = 10,
}
TaskList[4][245] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4244},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400245,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,246},	-- 发送给后台接受任务
	facidx = 11,
}
TaskList[4][246] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4245},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400246,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,247},	-- 发送给后台接受任务
	facidx = 12,
}
TaskList[4][247] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4246},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_267", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400247,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,248},	-- 发送给后台接受任务
	facidx = 13,
}
TaskList[4][248] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4247},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_268", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400248,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,249},	-- 发送给后台接受任务
	facidx = 14,
}
TaskList[4][249] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4248},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_269", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400249,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,250},	-- 发送给后台接受任务
	facidx = 15,
}
TaskList[4][250] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4249},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400250,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,251},	-- 发送给后台接受任务
	facidx = 16,
}
TaskList[4][251] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4250},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400251,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,252},	-- 发送给后台接受任务
	facidx = 17,
}
TaskList[4][252] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4251},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_267", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400252,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,253},	-- 发送给后台接受任务
	facidx = 18,
}
TaskList[4][253] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4252},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_268", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400253,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,254},	-- 发送给后台接受任务
	facidx = 19,
}
TaskList[4][254] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	LinkEnd = 1,						--环任务结束
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4253},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_269", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{749,1,1},{682,1,1}},
	},	    
	StoryID = 400254,			-- 提交任务剧情ID
	QuickClear = 5,
	facidx = 20,
}


--[[
--帮会日常
TaskList[4][121] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		faction = 1,
		level = {60,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400121,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,122},	-- 发送给后台接受任务
	facidx = 1,
}
TaskList[4][122] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4121},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400122,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,123},	-- 发送给后台接受任务
	facidx = 2,
}
TaskList[4][123] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4122},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_267", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400123,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,124},	-- 发送给后台接受任务
	facidx = 3,
}
TaskList[4][124] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4123},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_268", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400124,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,125},	-- 发送给后台接受任务
	facidx = 4,
}
TaskList[4][125] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4124},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_269", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400125,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,240},	-- 发送给后台接受任务
	facidx = 5,
}
]]--

TaskList[4][240] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4125},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400240,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,241},	-- 发送给后台接受任务
	facidx = 6,
}
TaskList[4][241] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4240},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400241,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,242},	-- 发送给后台接受任务
	facidx = 7,
}
TaskList[4][242] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4241},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_267", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400242,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,243},	-- 发送给后台接受任务
	facidx = 8,
}
TaskList[4][243] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4242},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_268", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400243,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,244},	-- 发送给后台接受任务
	facidx = 9,
}
TaskList[4][244] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4243},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_269", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400244,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,245},	-- 发送给后台接受任务
	facidx = 10,
}
TaskList[4][245] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4244},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400245,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,246},	-- 发送给后台接受任务
	facidx = 11,
}
TaskList[4][246] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4245},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400246,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,247},	-- 发送给后台接受任务
	facidx = 12,
}
TaskList[4][247] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4246},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_267", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400247,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,248},	-- 发送给后台接受任务
	facidx = 13,
}
TaskList[4][248] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4247},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_268", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400248,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,249},	-- 发送给后台接受任务
	facidx = 14,
}
TaskList[4][249] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4248},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_269", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400249,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,250},	-- 发送给后台接受任务
	facidx = 15,
}
TaskList[4][250] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4249},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400250,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,251},	-- 发送给后台接受任务
	facidx = 16,
}
TaskList[4][251] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4250},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400251,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,252},	-- 发送给后台接受任务
	facidx = 17,
}
TaskList[4][252] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4251},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_267", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400252,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,253},	-- 发送给后台接受任务
	facidx = 18,
}
TaskList[4][253] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4252},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_268", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400253,			-- 提交任务剧情ID
	QuickClear = 5,
	task = {4,254},	-- 发送给后台接受任务
	facidx = 19,
}
TaskList[4][254] = 
{	
	AcceptNPC = 40,						-- 接受任务NPC
	SubmitNPC = 40,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	LinkEnd = 1,						--环任务结束
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4253},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "G_269", 20 },
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 100000,
		[3] = {{749,1,1},{682,1,1}},
	},	    
	StoryID = 400254,			-- 提交任务剧情ID
	QuickClear = 5,
	facidx = 20,
}











--经验日常
TaskList[4][150] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 38,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		vip = 1, 
		level = 999,
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{641,5}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 500000,
	},	    
	StoryID = 400150,			-- 提交任务剧情ID
	task = {4,151},	-- 发送给后台接受任务
}
TaskList[4][151] = 
{	
	AcceptNPC = 38,						-- 接受任务NPC
	SubmitNPC = 38,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4150},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{641,10}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 800000,
	},	    
	StoryID = 400151,			-- 提交任务剧情ID
	task = {4,152},	-- 发送给后台接受任务
}
TaskList[4][152] = 
{	
	AcceptNPC = 38,						-- 接受任务NPC
	SubmitNPC = 38,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4151},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{641,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1500000,
	},	    
	StoryID = 400152,			-- 提交任务剧情ID
}

--跨服日常
TaskList[4][900] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 49,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		level = 50,
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		eGetWW = 20,
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[14] = 1000,
		[3] = {{683,1,1}},
	},	    
	StoryID = 400900,			-- 提交任务剧情ID
}



--经验日常
TaskList[4][950] = 
{	
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 38,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		vip = 1, 
		level = 35,
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{641,5}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 500000,
	},	    
	StoryID = 400950,			-- 提交任务剧情ID
	task = {4,951},	-- 发送给后台接受任务
}
TaskList[4][951] = 
{	
	AcceptNPC = 38,						-- 接受任务NPC
	SubmitNPC = 38,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4950},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{641,10}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 800000,
	},	    
	StoryID = 400951,			-- 提交任务剧情ID
	task = {4,952},	-- 发送给后台接受任务
}
TaskList[4][952] = 
{	
	AcceptNPC = 38,						-- 接受任务NPC
	SubmitNPC = 38,						-- 提交任务NPC
	NoDrop = 1,							-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		completed={4951},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{641,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1500000,
	},	    
	StoryID = 400952,			-- 提交任务剧情ID
}

--护送海美人

TaskList[4][999] = 
{
    
	TaskName = "护送海美人",
	AcceptNPC = 53,
	SubmitNPC = 210,
	nocancel=0,
	TaskInfo = "请将美女护送到东海逍遥阁，路途遥远，请朋友一路保护会增大成功率。",
	HelpInfo = "每日^03^3次，^019:30~20:00^3护送，可获^01.5倍^3收益。",
	ClientAcceptEvent = {
	},

	ClientSumitEvent = {
	},	
	ServerAcceptEvent = 
	{
		
	},
	AcceptCondition = {
		 level = {35,999},
	},
	CompleteCondition = 
	{  
		
	},
	CompleteAwords = 
	{	
		
	},
	StoryID = 400999,		
}


TaskList[6] = 
{
}
--活动_远古遗迹 ( 1 - 100 )
TaskList[6][1] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {40,45},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
		[3] = {{627,10,0}},
		[12] = 500,
	},
	StoryID = 600001,
}
TaskList[6][2] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {40,45},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
		[3] = {{627,20,1}},
		[12] = 500,
	},
	StoryID = 600002,
}
TaskList[6][3] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {40,45},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
		[3] = {{626,10,0}},
		[12] = 500,
	},
	StoryID = 600003,
}
TaskList[6][4] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {40,45},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 200000,
		[3] = {{626,20,1}},
		[12] = 500,
	},
	StoryID = 600004,
}


TaskList[6][6] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {46,50},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[3] = {{627,12,0}},
		[12] = 550,
	},
	StoryID = 600006,
}
TaskList[6][7] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {46,50},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[3] = {{627,25,1}},
		[12] = 550,
	},
	StoryID = 600007,
}
TaskList[6][8] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {46,50},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[3] = {{626,12,0}},
		[12] = 550,
	},
	StoryID = 600008,
}
TaskList[6][9] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {46,50},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 250000,
		[3] = {{626,25,1}},
		[12] = 550,
	},
	StoryID = 600009,
}

TaskList[6][11] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {51,55},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 275000,
		[3] = {{627,15,0}},
		[12] = 600,
	},
	StoryID = 600011,
}
TaskList[6][12] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {51,55},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 275000,
		[3] = {{627,30,1}},
		[12] = 600,
	},
	StoryID = 600012,
}
TaskList[6][13] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		 -- level = {51,55},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 275000,
		[3] = {{626,15,0}},
		[12] = 600,
	},
	StoryID = 600013,
}
TaskList[6][14] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		 -- level = {51,55},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 275000,
		[3] = {{626,30,1}},
		[12] = 600,
	},
	StoryID = 600014,
}


TaskList[6][16] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {56,60},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[3] = {{627,18,0}},
		[12] = 650,
	},
	StoryID = 600016,
}
TaskList[6][17] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {56,60},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[3] = {{627,35,1}},
		[12] = 650,
	},
	StoryID = 600017,
}
TaskList[6][18] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		 -- level = {56,60},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[3] = {{626,18,0}},
		[12] = 650,
	},
	StoryID = 600018,
}
TaskList[6][19] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {56,60},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 300000,
		[3] = {{626,35,1}},
		[12] = 650,
	},
	StoryID = 600019,
}

TaskList[6][21] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {61,65},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 330000,
		[3] = {{627,20,0}},
		[12] = 700,
	},
	StoryID = 600021,
}
TaskList[6][22] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {61,65},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 330000,
		[3] = {{627,40,1}},
		[12] = 700,
	},
	StoryID = 600022,
}
TaskList[6][23] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {61,65},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 330000,
		[3] = {{626,20,0}},
		[12] = 700,
	},
	StoryID = 600023,
}
TaskList[6][24] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {61,65},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 330000,
		[3] = {{626,40,1}},
		[12] = 700,
	},
	StoryID = 600024,
}


TaskList[6][26] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 360000,
		[3] = {{627,25,0}},
		[12] = 800,
	},
	StoryID = 600026,
}
TaskList[6][27] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 360000,
		[3] = {{627,45,1}},
		[12] = 800,
	},
	StoryID = 600027,
}
TaskList[6][28] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		  -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 360000,
		[3] = {{626,25,0}},
		[12] = 800,
	},
	StoryID = 600028,
}
TaskList[6][29] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 360000,
		[3] = {{626,45,1}},
		[12] = 800,
	},
	StoryID = 600029,
}

TaskList[6][31] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 650000,
		[3] = {{627,25,0}},
		[12] = 900,
	},
	StoryID = 600026,
}
TaskList[6][32] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 650000,
		[3] = {{627,45,1}},
		[12] = 900,
	},
	StoryID = 600027,
}
TaskList[6][33] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		  -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 650000,
		[3] = {{626,25,0}},
		[12] = 900,
	},
	StoryID = 600028,
}
TaskList[6][34] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 650000,
		[3] = {{626,45,1}},
		[12] = 900,
	},
	StoryID = 600029,
}

TaskList[6][36] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 880000,
		[3] = {{627,25,0}},
		[12] = 1000,
	},
	StoryID = 600026,
}
TaskList[6][37] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 880000,
		[3] = {{627,45,1}},
		[12] = 1000,
	},
	StoryID = 600027,
}
TaskList[6][38] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		  -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 880000,
		[3] = {{626,25,0}},
		[12] = 1000,
	},
	StoryID = 600028,
}
TaskList[6][39] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 880000,
		[3] = {{626,45,1}},
		[12] = 1000,
	},
	StoryID = 600029,
}

TaskList[6][41] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		[3] = {{627,25,0}},
		[12] = 1000,
	},
	StoryID = 600026,
}
TaskList[6][42] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		[3] = {{627,45,1}},
		[12] = 1000,
	},
	StoryID = 600027,
}
TaskList[6][43] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		  -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		[3] = {{626,25,0}},
		[12] = 1000,
	},
	StoryID = 600028,
}
TaskList[6][44] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		[3] = {{626,45,1}},
		[12] = 1000,
	},
	StoryID = 600029,
}

TaskList[6][46] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		[3] = {{627,25,0}},
		[12] = 1000,
	},
	StoryID = 600026,
}
TaskList[6][47] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		[3] = {{627,45,1}},
		[12] = 1000,
	},
	StoryID = 600027,
}
TaskList[6][48] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		  -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		[3] = {{626,25,0}},
		[12] = 1000,
	},
	StoryID = 600028,
}
TaskList[6][49] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		[3] = {{626,45,1}},
		[12] = 1000,
	},
	StoryID = 600029,
}

TaskList[6][51] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		[3] = {{627,25,0}},
		[12] = 1000,
	},
	StoryID = 600026,
}
TaskList[6][52] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		[3] = {{627,45,1}},
		[12] = 1000,
	},
	StoryID = 600027,
}
TaskList[6][53] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		  -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		[3] = {{626,25,0}},
		[12] = 1000,
	},
	StoryID = 600028,
}
TaskList[6][54] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		[3] = {{626,45,1}},
		[12] = 1000,
	},
	StoryID = 600029,
}

TaskList[6][56] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		-- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		[3] = {{627,25,0}},
		[12] = 1000,
	},
	StoryID = 600026,
}
TaskList[6][57] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		[3] = {{627,45,1}},
		[12] = 1000,
	},
	StoryID = 600027,
}
TaskList[6][58] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		  -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		[3] = {{626,25,0}},
		[12] = 1000,
	},
	StoryID = 600028,
}
TaskList[6][59] = 
{
	AcceptNPC = 0,						-- 接受任务NPC
	SubmitNPC = 55,						-- 提交任务NPC
	--NoDrop = 1,						-- 不能放弃		
	
	AcceptCondition = 			-- 服务端接受任务条件
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- 服务端完成任务条件
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- 完成任务奖励
	{
		[2] = 1000000,
		[3] = {{626,45,1}},
		[12] = 1000,
	},
	StoryID = 600029,
}