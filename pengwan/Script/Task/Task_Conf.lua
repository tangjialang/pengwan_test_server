--[[
file:	Task_conf.lua1
desc:	task config(S&C)
author:	chal
update:	2011-12-01
version: 1.0.0.0

1000 - 2999 ��������
3000 - 3999 ֧������
4000 - 4999 �ճ�����
5000 - 5999 �������� 
6000 - 6999 �����
7000 - 7999 �ܻ�����

notes:
	1�����������жϷ�Ϊǰ̨�жϺͺ�̨�жϣ�����ֻ��ǰ̨���̨�ж�����
	TIPtype����Ϊ��������1Ϊ����+�Զ�Ѱ·��2Ϊ������ʾ��3Ϊ������
faction = 1
]]--

TaskList = {}
--���ִ�1
TaskList[1] = 
{
	
}
TaskList[2] = 
{
}
TaskList[1][1] = 
{	
	AcceptNPC = 1,						-- ��������NPC
	SubmitNPC = 1,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	--���û�п��Բ����������¼�
	ServerAcceptEvent = 1,				-- ����˽��������¼� �̶�����OnAcceptTask_taskid(taskid, taskData)
	--ServerCompleteEvent = 1,			-- �������������¼� �̶�����OnSubmitTask_taskid(taskid, taskData)
	--AcceptStoryID		 --�����������
	--SubmitStoryID = 1000001,  --����������
	
	AcceptCondition = 			-- ����˽�����������
	{
	},
	CompleteCondition = 			-- ����������������
	{
	},
	CompleteAwards = 					-- ���������
	{
		-- local Award_Type = {
			-- money = 1,		-- ����
			-- exps = 2,		-- ����
			-- item = 3,		-- ����
			-- bindYB = 4,		-- ��Ԫ��
			-- lingqi = 5,		-- ����
			-- factionGX = 6,	-- ��ṱ��
			-- shengwang = 7,	-- ս��
			--���� = 8      --����
		-- }
		[2] = 100,
		[1] = 1000,
		[5] = 800,
		
	},
    --QuickClear = 30,  ����ָ������Ԫ����������ɱ�����
	--QuickSub = 3011,   ������NPC����Զ���ύ�����񣬲�������һ��ָ������
	--AutoSub = 3011,    ���Զ��ύ�����񣬲�������һ������
	--facidx = 1,		������в���������������Ļ���
	  
	StoryID = 100001,			-- �ύ�������ID
}
TaskList[1][2] = 
{	
	AcceptNPC = 1,						-- ��������NPC
	SubmitNPC = 8,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1001},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_004", 1 ,{3,88,142}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 500,
		[1] = 1000,
		[5] = 800,
		[3] = {{10,10,1}},
	},
	AutoSub = 1003,    
	StoryID = 100002,			-- �ύ�������ID
}

TaskList[1][3] = 
{	
	AcceptNPC = 1,						-- ��������NPC
	SubmitNPC = 8,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1002},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_004", 1 ,{3,77,138}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2500,
		[1] = 1000,
		[5] = 800,
		[3] = {{10,10,1}},
	},
	    
	StoryID = 100003,			-- �ύ�������ID
}

TaskList[1][4] = 
{	
	AcceptNPC = 8,						-- ��������NPC
	SubmitNPC = 4,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1003},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 8000,
		[1] = 1000,
		[5] = 800,
		[3] = {{10,10,1}},
	},
	    
	StoryID = 100004,			-- �ύ�������ID
}


TaskList[1][5] = 
{	
	AcceptNPC = 4,						-- ��������NPC
	SubmitNPC = 5,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1004},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_005", 1 ,{3,56,155}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 10000,
		[1] = 1000,
		[5] = 800,
		[3] = {{10,10,1}},
	},
	StoryID = 100005,			-- �ύ�������ID
	AutoSub = 1006,    
}
TaskList[1][6] = 
{	
	AcceptNPC = 5,						-- ��������NPC
	SubmitNPC = 5,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1005},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_005", 2 ,{3,67,163}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 10000,
		[1] = 1000,
		[5] = 800,
	},
	    
	StoryID = 100006,			-- �ύ�������ID
	AutoSub = 1007,    
}
TaskList[1][7] = 
{	
	AcceptNPC = 5,						-- ��������NPC
	SubmitNPC = 5,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		


	AcceptCondition = 			-- ����˽�����������
	{
		completed={1006},
	},
	CompleteCondition = 			-- ����������������
	{
	  kill = { "M_005", 2 ,{3,73,171}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[1] = 1000,
		[5] = 800,
	},
	    
	StoryID = 100007,			-- �ύ�������ID
	AutoSub = 1008,    
}

TaskList[1][8] = 
{	
	AcceptNPC = 5,						-- ��������NPC
	SubmitNPC = 5,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1007},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_047", 2 ,{3,84,179}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[1] = 1000,
		[5] = 800,
	},
	    
	StoryID = 100008,			-- �ύ�������ID
}
TaskList[1][9] = 
{	
	AcceptNPC = 5,						-- ��������NPC
	SubmitNPC = 6,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1008},
	},
	CompleteCondition = 			-- ����������������
	{

	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[1] = 1000,
		[5] = 800,
	},
	    
	StoryID = 100009,			-- �ύ�������ID
}
TaskList[1][10] = 
{	
	AcceptNPC = 6,						-- ��������NPC
	SubmitNPC = 30,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1,
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1009},
	},
	CompleteCondition = 			-- ����������������
	{

	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[1] = 1000,
		[5] = 800,
		giveGoods = {
			[3] = {
				[1] = {{5333,1,1}},	-- ������
				[2] = {{5370,1,1}},	-- ����
				[3] = {{5407,1,1}},	-- ����
			},
		},
	},
	    
	StoryID = 100010,			-- �ύ�������ID
}
--����õ�10
--���ִ��������������
TaskList[1][50] = 
{	
	AcceptNPC = 30,						-- ��������NPC
	SubmitNPC = 35,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1010},
	},
	CompleteCondition = 			-- ����������������
	{
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
	},
	    
	StoryID = 100050,			-- �ύ�������ID
}
TaskList[1][51] = 
{	
	AcceptNPC = 35,						-- ��������NPC
	SubmitNPC = 35,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1050},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_095", 2 ,{1,17,161}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		[3] = {{10,20,1}},
	},
	    
	StoryID = 100051,			-- �ύ�������ID
}

TaskList[1][54] = 
{	
	AcceptNPC = 35,						-- ��������NPC
	SubmitNPC = 33,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1,
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1051},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_097", 1,{1,36,169,1}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		[3] = {{636,3,1}},
	},
	AcceptStoryID = 1000132,
	SubmitStoryID = 1000002,
	StoryID = 100054,			-- �ύ�������ID
}
TaskList[1][58] = 
{	
	AcceptNPC = 33,						-- ��������NPC
	SubmitNPC = 38,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1,
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1054},
	},
	CompleteCondition = 			-- ����������������
	{
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	    
	StoryID = 100058,			-- �ύ�������ID
}

--��������
TaskList[1][60] = 
{	
	AcceptNPC = 38,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1058},
	},
	CompleteCondition = 			-- ����������������
	{
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	    
	StoryID = 100060,			-- �ύ�������ID
}

TaskList[2][33] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1060},
	},
	CompleteCondition = 			-- ����������������
	{
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		[3] = {{100,2,1}},
	},
	    
	StoryID = 200033,			-- �ύ�������ID
}

TaskList[2][1] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 202,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2033},
	},
	CompleteCondition = 			-- ����������������
	{
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	    
	StoryID = 200001,			-- �ύ�������ID
}

TaskList[2][2] = 
{	
	AcceptNPC = 202,						-- ��������NPC
	SubmitNPC = 203,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2001},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_028", 3 ,{7,49,42}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	    
	StoryID = 200002,			-- �ύ�������ID
}
TaskList[2][3] = 
{	
	AcceptNPC = 203,						-- ��������NPC
	SubmitNPC = 205,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2002},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_029", 3 ,{7,21,58}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	    
	StoryID = 200003,			-- �ύ�������ID
}

TaskList[2][12] = 
{	
	AcceptNPC = 205,						-- ��������NPC
	SubmitNPC = 206,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2003},
	},
	CompleteCondition = 			-- ����������������
	{
		--kill = { "M_029", 5 ,{7,21,58}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	SubmitStoryID = 1000008,
	StoryID = 200012,			-- �ύ�������ID
}

TaskList[2][4] = 
{	
	AcceptNPC = 206,						-- ��������NPC
	SubmitNPC = 211,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2012},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	
	StoryID = 200004,			-- �ύ�������ID
}
TaskList[2][32] = 
{	
	AcceptNPC = 211,						-- ��������NPC
	SubmitNPC = 211,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2004},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10005,1,{7,47,88,100026}}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		[3] = {{100,2,1}},
	},
	    
	StoryID = 200032,			-- �ύ�������ID
}

TaskList[2][5] = 
{	
	AcceptNPC = 211,						-- ��������NPC
	SubmitNPC = 202,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1,
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2032},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	SubmitStoryID = {1000007,1000009,1000010},
	StoryID = 200005,			-- �ύ�������ID
}

TaskList[2][11] = 
{	
	AcceptNPC = 202,						-- ��������NPC
	SubmitNPC = 202,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2005},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		[3] = {{100,2,1}},
	},
	--AcceptStoryID = 1000007,
	StoryID = 200011,			-- �ύ�������ID
}

TaskList[2][13] = 
{	
	AcceptNPC = 202,						-- ��������NPC
	SubmitNPC = 208,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2011},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	--AcceptStoryID = 1000007,
	StoryID = 200013,			-- �ύ�������ID
}

TaskList[2][6] = 
{	
	AcceptNPC = 208,						-- ��������NPC
	SubmitNPC = 202,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2013},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "B_032", 1 ,{7,6,19,1},"�������ڵ�"},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		[3] = {{100,2,1}},
		
	},
	StoryID = 200006,			-- �ύ�������ID
}
TaskList[2][7] = 
{	
	AcceptNPC = 202,						-- ��������NPC
	SubmitNPC = 101,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2006},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 2000,
		[5] = 1500,
		
	},
	StoryID = 200007,			-- �ύ�������ID
}

--��᪽�Ұ����ʼ
TaskList[1][100] = 
{	
	AcceptNPC = 101,						-- ��������NPC
	SubmitNPC = 107,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2007},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_009", 4 ,{6,37,134}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 3000,
		[5] = 2500,
	},
	    
	StoryID = 100100,			-- �ύ�������ID
}
TaskList[1][99] = 
{	
	AcceptNPC = 107,						-- ��������NPC
	SubmitNPC = 102,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1100},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10007,1,{6,64,107,100011}}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 3000,
		[5] = 2500,		
	},
	    
	StoryID = 100099,			-- �ύ�������ID
}
TaskList[1][101] = 
{	
	AcceptNPC = 102,						-- ��������NPC
	SubmitNPC = 108,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1099},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_010", 4 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[1] = 3000,
		[5] = 2500,
		giveGoods = {
			[3] = {
				[1] = {{5334,1,1}},	-- ������
				[2] = {{5371,1,1}},	-- ����
				[3] = {{5408,1,1}},	-- ����
			},
		},
	},
	    
	StoryID = 100101,			-- �ύ�������ID
}
TaskList[1][98] = 
{	
	AcceptNPC = 108,						-- ��������NPC
	SubmitNPC = 103,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1101},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		giveGoods = {
			[3] = {
				[1] = {{5223,1,1}},	-- ������
				[2] = {{5260,1,1}},	-- ����
				[3] = {{5297,1,1}},	-- ����
			},
		},
	},
	    
	StoryID = 100098,			-- �ύ�������ID
}
TaskList[1][102] = 
{	
	AcceptNPC = 103,						-- ��������NPC
	SubmitNPC = 104,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1098},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_011", 4 ,{6,53,26}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		giveGoods = {
			[2] = {
				[10] = {5038,1,1},	-- ������(Ů)
				[11] = {5001,1,1},	-- ������(��)
				[20] = {5112,1,1},	-- ����(Ů)
				[21] = {5075,1,1},	-- ����(��)
				[30] = {5186,1,1},	-- ����(Ů)
				[31] = {5149,1,1},	-- ����(��)	
			},
		},
	},
	    
	StoryID = 100102,			-- �ύ�������ID
}
TaskList[1][103] = 
{	
	AcceptNPC = 104,						-- ��������NPC
	SubmitNPC = 105,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1102},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10003,1,{6,32,63,100010}}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		
	},
	    
	StoryID = 100103,			-- �ύ�������ID
}

TaskList[2][14] = 
{	
	AcceptNPC = 105,						-- ��������NPC
	SubmitNPC = 105,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1103},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		giveGoods = {
			[3] = {
				[1] = {{5445,1,1}},	-- ������
				[2] = {{5482,1,1}},	-- ����
				[3] = {{5519,1,1}},	-- ����
			},
		},
	},
	    
	StoryID = 200014,			-- �ύ�������ID
}

TaskList[1][104] = 
{	
	AcceptNPC = 105,						-- ��������NPC
	SubmitNPC = 106,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1,		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2014},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_012", 5 ,{6,10,48}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		
	},
	SubmitStoryID = 1000003,	--�ҽ�    
	StoryID = 100104,			-- �ύ�������ID
}
TaskList[1][115] = 
{	
	AcceptNPC = 106,						-- ��������NPC
	SubmitNPC = 106,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1,		--��õ�һ���ҽ�
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1104},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,		
	},
	StoryID = 100115,			-- �ύ�������ID
}
TaskList[1][105] = 
{	
	AcceptNPC = 106,						-- ��������NPC
	SubmitNPC = 36,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1115},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "B_015", 1 ,{6,41,13}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 70000,
		[5] = 2500,
	},
	    
	StoryID = 100105,			-- �ύ�������ID
	SubmitStoryID = 1000118,
}

TaskList[1][56] = 
{	
	AcceptNPC = 36,						-- ��������NPC
	SubmitNPC = 36,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	--ServerAcceptEvent = 1,
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1105},
	},
	CompleteCondition = 			-- ����������������
	{
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 2000,
		[5] = 1500,
		
	},
	StoryID = 100056,			-- �ύ�������ID
	
}

TaskList[1][57] = 
{	
	AcceptNPC = 36,						-- ��������NPC
	SubmitNPC = 33,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1056},
	},
	CompleteCondition = 			-- ����������������
	{
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 2000,
		[5] = 1500,
		
	},
	
	StoryID = 100057,			-- �ύ�������ID
}

TaskList[1][106] = 
{	
	AcceptNPC = 33,						-- ��������NPC
	SubmitNPC = 38,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1,		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1057},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		
	},
	    
	StoryID = 100106,			-- �ύ�������ID
}

TaskList[1][107] = 
{	
	AcceptNPC = 38,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1106},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		
	},
	    
	StoryID = 100107,			-- �ύ�������ID
}
TaskList[1][108] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 38,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���	
	
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1107},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		
	},
	    
	StoryID = 100108,			-- �ύ�������ID
}
TaskList[1][109] = 
{	
	AcceptNPC = 38,						-- ��������NPC
	SubmitNPC = 45,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1108},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		
	},
	    
	StoryID = 100109,			-- �ύ�������ID
}
TaskList[1][110] = 
{	
	AcceptNPC = 45,						-- ��������NPC
	SubmitNPC = 46,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1109},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		[3] = {{621,1,1}},
	},
	    
	StoryID = 100110,			-- �ύ�������ID
}
TaskList[1][112] = 
{	
	AcceptNPC = 46,						-- ��������NPC
	SubmitNPC = 47,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1110},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,		
		
	},
	    
	StoryID = 100112,			-- �ύ�������ID
}

TaskList[1][113] = 
{	
	AcceptNPC = 47,						-- ��������NPC
	SubmitNPC = 33,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1112},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		[3] = {{5555,1,1}},
	},
	    
	StoryID = 100113,			-- �ύ�������ID
}
TaskList[1][114] = 
{	
	AcceptNPC = 33,						-- ��������NPC
	SubmitNPC = 33,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1113},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 50000,
		
	},
	    
	StoryID = 100114,			-- �ύ�������ID
}

TaskList[2][17] = 
{	
	AcceptNPC = 33,						-- ��������NPC
	SubmitNPC = 150,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1114},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 3000,
		[5] = 2500,
		[3] = {{5587,1,1}},
	},
	    
	StoryID = 200017,			-- �ύ�������ID
}
--ǰ������������
TaskList[1][150] = 
{	
	AcceptNPC = 150,						-- ��������NPC
	SubmitNPC = 151,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1,	  --����VIP����
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2017},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[1] = 5000,
		[5] = 4000,
		[3] = {{100,50,1}},
	},
	    
	StoryID = 100150,			-- �ύ�������ID
}

TaskList[1][151] = 
{	
	AcceptNPC = 151,						-- ��������NPC
	SubmitNPC = 151,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1150},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_016", 5 ,{8,9,9}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		[3] = {{5619,1,1}},
	},
	    
	StoryID = 100151,			-- �ύ�������ID
}
TaskList[1][152] = 
{	
	AcceptNPC = 151,						-- ��������NPC
	SubmitNPC = 152,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1151},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100152,			-- �ύ�������ID
}
TaskList[1][153] = 
{	
	AcceptNPC = 152,						-- ��������NPC
	SubmitNPC = 153,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1152},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100153,			-- �ύ�������ID
}
TaskList[1][154] = 
{	
	AcceptNPC = 153,						-- ��������NPC
	SubmitNPC = 154,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1153},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		[3] = {{5651,1,1}},
	},
	    
	StoryID = 100154,			-- �ύ�������ID
}
TaskList[1][155] = 
{	
	AcceptNPC = 154,						-- ��������NPC
	SubmitNPC = 154,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1154},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_017", 5 ,{8,15,51}},
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100155,			-- �ύ�������ID
}
TaskList[1][156] = 
{	
	AcceptNPC = 154,						-- ��������NPC
	SubmitNPC = 152,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1155},
	},
	CompleteCondition = 			-- ����������������
	{

	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100156,			-- �ύ�������ID
}
TaskList[1][157] = 
{	
	AcceptNPC = 152,						-- ��������NPC
	SubmitNPC = 155,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1156},
	},
	CompleteCondition = 			-- ����������������
	{

	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100157,			-- �ύ�������ID
}
TaskList[1][158] = 
{	
	AcceptNPC = 155,						-- ��������NPC
	SubmitNPC = 155,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���			
	

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1157},
	},
	CompleteCondition = 			-- ����������������
	{

	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 200000,
		[5] = 4000,
		[3] = {{612,2,1}},		
	},
	    
	StoryID = 100158,			-- �ύ�������ID
}


TaskList[2][18] = 
{	
	AcceptNPC = 155,						-- ��������NPC
	SubmitNPC = 156,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1158},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 150000,
		[1] = 5000,
		[5] = 4000,
		giveGoods = {
			[2] = {
				[10] = {5043,1,1},	-- ������(Ů)
				[11] = {5006,1,1},	-- ������(��)
				[20] = {5117,1,1},	-- ����(Ů)
				[21] = {5080,1,1},	-- ����(��)
				[30] = {5191,1,1},	-- ����(Ů)
				[31] = {5154,1,1},	-- ����(��)	
			},
		},
	},
	    
	StoryID = 200018,			-- �ύ�������ID
}

TaskList[1][159] = 
{	
	AcceptNPC = 156,						-- ��������NPC
	SubmitNPC = 157,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2018},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_018", 8 ,{8,67,111}},
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	SubmitStoryID = 1000004,  --����������    
	StoryID = 100159,			-- �ύ�������ID
}
TaskList[1][160] = 
{	
	AcceptNPC = 157,						-- ��������NPC
	SubmitNPC = 158,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1159},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		[3] = {{636,3,1}},
	},
	    
	StoryID = 100160,			-- �ύ�������ID
}
TaskList[1][161] = 
{	
	AcceptNPC = 158,						-- ��������NPC
	SubmitNPC = 159,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1160},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		giveGoods = {
			[3] = {
				[1] = {{5339,1,1}},	-- ������
				[2] = {{5376,1,1}},	-- ����
				[3] = {{5413,1,1}},	-- ����
			},
		},
	},
	    
	StoryID = 100161,			-- �ύ�������ID
}
TaskList[1][162] = 
{	
	AcceptNPC = 159,						-- ��������NPC
	SubmitNPC = 160,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1161},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_019", 8 ,{8,39,117}},
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100162,			-- �ύ�������ID
}
TaskList[1][163] = 
{	
	AcceptNPC = 160,						-- ��������NPC
	SubmitNPC = 161,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1162},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100163,			-- �ύ�������ID
}
TaskList[1][164] = 
{	
	AcceptNPC = 161,						-- ��������NPC
	SubmitNPC = 161,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1163},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10004,1,{8,41,83,100020}}},
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100164,			-- �ύ�������ID
}
TaskList[1][165] = 
{	
	AcceptNPC = 161,						-- ��������NPC
	SubmitNPC = 160,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1164},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100165,			-- �ύ�������ID
}
TaskList[1][166] = 
{	
	AcceptNPC = 160,						-- ��������NPC
	SubmitNPC = 158,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1165},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 10000,
		[5] = 30000,
		
	},
	    
	StoryID = 100166,			-- �ύ�������ID
}
TaskList[1][167] = 
{	
	AcceptNPC = 158,						-- ��������NPC
	SubmitNPC = 157,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1166},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100167,			-- �ύ�������ID
}
TaskList[1][168] = 
{	
	AcceptNPC = 157,						-- ��������NPC
	SubmitNPC = 157,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1167},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "B_022", 1 ,{8,44,138}},
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		giveGoods = {
			[3] = {
				[1] = {{5450,1,1}},	-- ������
				[2] = {{5487,1,1}},	-- ����
				[3] = {{5524,1,1}},	-- ����
			},
		},
	},
	    
	StoryID = 100168,			-- �ύ�������ID
}
TaskList[1][169] = 
{	
	AcceptNPC = 157,						-- ��������NPC
	SubmitNPC = 156,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1168},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		[3] = {{11,100,1},},
	},
	    
	StoryID = 100169,			-- �ύ�������ID
}
TaskList[1][170] = 
{	
	AcceptNPC = 156,						-- ��������NPC
	SubmitNPC = 157,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1169},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100170,			-- �ύ�������ID
}
TaskList[1][171] = 
{	
	AcceptNPC = 157,						-- ��������NPC
	SubmitNPC = 157,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1,	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1170},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_018", 1 ,{8,63,121}},
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100171,			-- �ύ�������ID
}
TaskList[1][172] = 
{	
	AcceptNPC = 157,						-- ��������NPC
	SubmitNPC = 157,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1171},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_019", 1 ,{8,30,99}},
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
		
	},
	    
	StoryID = 100172,			-- �ύ�������ID
}
TaskList[1][173] = 
{	
	AcceptNPC = 157,						-- ��������NPC
	SubmitNPC = 157,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1172},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "B_027", 1 ,{8,44,138}},
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		giveGoods = {
			[3] = {
				[1] = {{5228,1,1}},	-- ������
				[2] = {{5265,1,1}},	-- ����
				[3] = {{5302,1,1}},	-- ����
			},
		},
		
	},
	    
	StoryID = 100173,			-- �ύ�������ID
}


TaskList[1][175] = 
{	
	AcceptNPC = 157,						-- ��������NPC
	SubmitNPC = 159,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1173},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		[3] = {{768,2,1}},
	},
	    
	StoryID = 100175,			-- �ύ�������ID
}
TaskList[1][176] = 
{	
	AcceptNPC = 159,						-- ��������NPC
	SubmitNPC = 152,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1175},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100176,			-- �ύ�������ID
}
TaskList[1][177] = 
{	
	AcceptNPC = 152,						-- ��������NPC
	SubmitNPC = 155,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1176},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100177,			-- �ύ�������ID
}
TaskList[1][178] = 
{	
	AcceptNPC = 155,						-- ��������NPC
	SubmitNPC = 157,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1,	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1177},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100178,			-- �ύ�������ID
}
TaskList[1][179] = 
{	
	AcceptNPC = 157,						-- ��������NPC
	SubmitNPC = 155,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1,	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1178},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,	
		[3] = {{100,5,1}},
	},
	AcceptStoryID = 1000005,		 --�����������    
	StoryID = 100179,			-- �ύ�������ID
}
TaskList[1][180] = 
{	
	AcceptNPC = 155,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptOtherTask = {3001},
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1179},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100180,			-- �ύ�������ID
}

TaskList[1][258] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptOtherTask = {3030},
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1180},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[1] = 8000,
		[5] = 4000,	
		[8] = 70,
	},
	    
	StoryID = 100258,			-- �ύ�������ID
}

TaskList[1][181] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1,
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1258},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 250000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100181,			-- �ύ�������ID
}
TaskList[1][256] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1181},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{100,5,1}},
	},
	    
	StoryID = 100256,			-- �ύ�������ID
}
TaskList[1][182] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 200,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���	
	AcceptOtherTask = {3010},
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1256},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 250000,
		[1] = 5000,
		[5] = 4000,
		
	},
	    
	StoryID = 100182,			-- �ύ�������ID
}
--ǬԪɽ����ʼ
TaskList[1][200] = 
{	
	AcceptNPC = 200,						-- ��������NPC
	SubmitNPC = 201,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1182},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{11,50,1}},
	},
	    
	StoryID = 100200,			-- �ύ�������ID
}

TaskList[1][201] = 
{	
	AcceptNPC = 201,						-- ��������NPC
	SubmitNPC = 202,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1200},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
	
	},
	    
	StoryID = 100201,			-- �ύ�������ID
}
TaskList[1][202] = 
{	
	AcceptNPC = 202,						-- ��������NPC
	SubmitNPC = 203,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1201},
	},
	CompleteCondition = 			-- ����������������
	{

	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
	},
	    
	StoryID = 100202,			-- �ύ�������ID
}
TaskList[1][203] = 
{	
	AcceptNPC = 203,						-- ��������NPC
	SubmitNPC = 203,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1202},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_028", 5 ,{7,50,42}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 100203,			-- �ύ�������ID
}
TaskList[1][204] = 
{	
	AcceptNPC = 203,						-- ��������NPC
	SubmitNPC = 205,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptOtherTask = {3006},
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1203},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 100204,			-- �ύ�������ID
}
TaskList[1][205] = 
{	
	AcceptNPC = 205,						-- ��������NPC
	SubmitNPC = 205,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1204},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_029", 5 ,{7,14,57}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 100205,			-- �ύ�������ID
}
TaskList[1][206] = 
{	
	AcceptNPC = 205,						-- ��������NPC
	SubmitNPC = 207,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1205},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 100206,			-- �ύ�������ID
}

TaskList[1][212] = 
{	
	AcceptNPC = 207,						-- ��������NPC
	SubmitNPC = 207,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1206},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_096", 10 ,{7,17,26}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 100212,			-- �ύ�������ID
}
TaskList[1][213] = 
{	
	AcceptNPC = 207,						-- ��������NPC
	SubmitNPC = 202,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1212},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "B_035", 1 ,{7,6,19}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{5559,1,1}},
	},
	SubmitStoryID = 1000006,  --����������           
	StoryID = 100213,			-- �ύ�������ID
}
TaskList[1][214] = 
{	
	AcceptNPC = 202,						-- ��������NPC
	SubmitNPC = 204,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1213},
	},
	CompleteCondition = 			-- ����������������
	{
	
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{100,5,1}},
	},
	
	StoryID = 100214,			-- �ύ�������ID
}
TaskList[1][215] = 
{	
	AcceptNPC = 204,						-- ��������NPC
	SubmitNPC = 160,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1214},
	},
	CompleteCondition = 			-- ����������������
	{
	
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{5591,1,1}},
	},
	    
	StoryID = 100215,			-- �ύ�������ID
}

TaskList[2][19] = 
{	
	AcceptNPC = 160,						-- ��������NPC
	SubmitNPC = 160,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1215},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_088", 1 ,{8,14,123},"����Ƥ"},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{636,3,1}},
	},
	    
	StoryID = 200019,			-- �ύ�������ID
}
TaskList[2][20] = 
{	
	AcceptNPC = 160,						-- ��������NPC
	SubmitNPC = 160,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={2019},
	},
	CompleteCondition = 			-- ����������������
	{
	
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 200020,			-- �ύ�������ID
}

TaskList[1][216] = 
{	
	AcceptNPC = 160,						-- ��������NPC
	SubmitNPC = 157,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={2020},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "B_038", 1 ,{8,14,123}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{5623,1,1}},
	},
	    
	StoryID = 100216,			-- �ύ�������ID
}

TaskList[1][218] = 
{	
	AcceptNPC = 157,						-- ��������NPC
	SubmitNPC = 155,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1216},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{100,20,1}},
	},
	    
	StoryID = 100218,			-- �ύ�������ID
}
TaskList[1][219] = 
{	
	AcceptNPC = 155,						-- ��������NPC
	SubmitNPC = 43,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1218},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 100219,			-- �ύ�������ID
}
TaskList[1][220] = 
{	
	AcceptNPC = 43,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1  ,  --�ָ�槼�����
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1219},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 100220,			-- �ύ�������ID
}


TaskList[1][224] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 49,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1220},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		[3] = {{5655,1,1}},
	},
	    
	StoryID = 100224,			-- �ύ�������ID
}



TaskList[1][250] = 
{	
	AcceptNPC = 49,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		

	AcceptCondition = 			-- ����˽�����������
	{
		completed={1224},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 5000,
		
	},
	    
	StoryID = 100250,			-- �ύ�������ID
}

TaskList[2][27] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���
	ServerAcceptEvent = 1,	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1250},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 8000,
		[5] = 4000,
		[3] = {{630,5,1}},
	},
	    
	StoryID = 200027,			-- �ύ�������ID
}


TaskList[1][300] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 202,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptOtherTask = {3035},

	AcceptCondition = 			-- ����˽�����������
	{
		completed={2027},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100300,			-- �ύ�������ID
}
TaskList[1][301] = 
{	
	AcceptNPC = 202,						-- ��������NPC
	SubmitNPC = 204,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1300},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100301,			-- �ύ�������ID
}

TaskList[1][302] = 
{	
	AcceptNPC = 204,						-- ��������NPC
	SubmitNPC = 204,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1301},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_043", 12 ,{7,79,81}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100302,			-- �ύ�������ID
}



TaskList[1][303] = 
{	
	AcceptNPC = 204,						-- ��������NPC
	SubmitNPC = 204,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1302},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_044", 12 ,{7,71,122}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100303,			-- �ύ�������ID
}

TaskList[1][304] = 
{	
	AcceptNPC = 204,						-- ��������NPC
	SubmitNPC = 206,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1303},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100304,			-- �ύ�������ID
}


TaskList[1][306] = 
{	
	AcceptNPC = 206,						-- ��������NPC
	SubmitNPC = 206,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1304},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_045", 12 ,{7,23,128}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100306,			-- �ύ�������ID
}


TaskList[1][307] = 
{	
	AcceptNPC = 206,						-- ��������NPC
	SubmitNPC = 206,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1306},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_046", 12 ,{7,4,98}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
		
	},
	    
	StoryID = 100307,			-- �ύ�������ID
}


TaskList[1][308] = 
{	
	AcceptNPC = 206,						-- ��������NPC
	SubmitNPC = 206,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1307},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "B_051", 1 ,{7,9,133}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100308,			-- �ύ�������ID
}
TaskList[1][309] = 
{	
	AcceptNPC = 206,						-- ��������NPC
	SubmitNPC = 215,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	--AcceptOtherTask = {3045},
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1308},
	},
	CompleteCondition = 			-- ����������������
	{
	
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100309,			-- �ύ�������ID
}
TaskList[1][310] = 
{	
	AcceptNPC = 215,						-- ��������NPC
	SubmitNPC = 215,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1309},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_102", 12 ,{34,5,42}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100310,			-- �ύ�������ID
}
TaskList[1][311] = 
{	
	AcceptNPC = 215,						-- ��������NPC
	SubmitNPC = 216,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1310},
	},
	CompleteCondition = 			-- ����������������
	{
	
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100311,			-- �ύ�������ID
}
TaskList[1][312] = 
{	
	AcceptNPC = 216,						-- ��������NPC
	SubmitNPC = 216,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1311},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_103", 12 ,{34,22,8}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100312,			-- �ύ�������ID
}

TaskList[1][313] = 
{	
	AcceptNPC = 216,						-- ��������NPC
	SubmitNPC = 216,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1312},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_104", 12 ,{34,22,28}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100313,			-- �ύ�������ID
}
TaskList[1][314] = 
{	
	AcceptNPC = 216,						-- ��������NPC
	SubmitNPC = 216,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1313},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_105", 12 ,{34,39,33}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100314,			-- �ύ�������ID
}
TaskList[1][315] = 
{	
	AcceptNPC = 216,						-- ��������NPC
	SubmitNPC = 216,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1314},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_106", 12 ,{34,39,54}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100315,			-- �ύ�������ID
}
TaskList[1][316] = 
{	
	AcceptNPC = 216,						-- ��������NPC
	SubmitNPC = 217,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1315},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100316,			-- �ύ�������ID
}
TaskList[1][317] = 
{	
	AcceptNPC = 217,						-- ��������NPC
	SubmitNPC = 218,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1316},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10005,1,{34,31,73,100025}}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100317,			-- �ύ�������ID
}
TaskList[1][318] = 
{	
	AcceptNPC = 218,						-- ��������NPC
	SubmitNPC = 218,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1317},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_107", 12 ,{34,39,97}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100318,			-- �ύ�������ID
}
TaskList[1][319] = 
{	
	AcceptNPC = 218,						-- ��������NPC
	SubmitNPC = 219,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1318},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_108", 12 ,{34,14,102}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100319,			-- �ύ�������ID
}

TaskList[1][320] = 
{	
	AcceptNPC = 219,						-- ��������NPC
	SubmitNPC = 219,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1319},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_109", 12 ,{34,7,81}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100320,			-- �ύ�������ID
}
TaskList[1][321] = 
{	
	AcceptNPC = 219,						-- ��������NPC
	SubmitNPC = 206,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1320},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "B_054", 1 ,{7,9,133}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100321,			-- �ύ�������ID
}

TaskList[1][322] = 
{	
	AcceptNPC = 206,						-- ��������NPC
	SubmitNPC = 202,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1321},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100322,			-- �ύ�������ID
}

TaskList[1][323] = 
{	
	AcceptNPC = 202,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1322},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 5000,
	},
	    
	StoryID = 100323,			-- �ύ�������ID
}
TaskList[1][324] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	--ServerAcceptEvent = 1,
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1323},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 50000,
		[5] = 4000,
		[3] = {{411,1,1},{421,1,1}},
	},
	    
	StoryID = 100324,			-- �ύ�������ID
}
TaskList[1][350] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 43,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptOtherTask = {3002},
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1324},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100350,			-- �ύ�������ID
}
TaskList[1][351] = 
{	
	AcceptNPC = 43,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1350},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100351,			-- �ύ�������ID
}
TaskList[1][352] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 300,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1351},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100352,			-- �ύ�������ID
}
TaskList[1][353] = 
{	
	AcceptNPC = 300,						-- ��������NPC
	SubmitNPC = 300,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1352},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_065", 12 ,{10,12,83}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100353,			-- �ύ�������ID
}
TaskList[1][354] = 
{	
	AcceptNPC = 300,						-- ��������NPC
	SubmitNPC = 302,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1353},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_039", 12 ,{10,18,157}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100354,			-- �ύ�������ID
}
TaskList[1][355] = 
{	
	AcceptNPC = 302,						-- ��������NPC
	SubmitNPC = 304,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1354},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100355,			-- �ύ�������ID
}
TaskList[1][356] = 
{	
	AcceptNPC = 304,						-- ��������NPC
	SubmitNPC = 309,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1355},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100356,			-- �ύ�������ID
}
TaskList[1][357] = 
{	
	AcceptNPC = 309,						-- ��������NPC
	SubmitNPC = 309,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1356},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_040", 12 ,{10,18,157}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100357,			-- �ύ�������ID
}
TaskList[1][358] = 
{	
	AcceptNPC = 309,						-- ��������NPC
	SubmitNPC = 305,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1357},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_072", 12 ,{10,43,101}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100358,			-- �ύ�������ID
}
TaskList[1][359] = 
{	
	AcceptNPC = 305,						-- ��������NPC
	SubmitNPC = 305,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1358},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_073", 12 ,{10,60,145}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100359,			-- �ύ�������ID
}
TaskList[1][360] = 
{	
	AcceptNPC = 305,						-- ��������NPC
	SubmitNPC = 300,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1359},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10006,1,{10,54,152,100015}}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100360,			-- �ύ�������ID
}
TaskList[1][361] = 
{	
	AcceptNPC = 300,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1360},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100361,			-- �ύ�������ID
}
TaskList[1][362] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1361},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_066", 12 ,{10,75,145}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100362,			-- �ύ�������ID
}
TaskList[1][363] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1362},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_041", 12 ,{10,37,54}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100363,			-- �ύ�������ID
}
TaskList[1][364] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 308,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1363},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_069", 12 ,{10,40,38}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100364,			-- �ύ�������ID
}
TaskList[1][365] = 
{	
	AcceptNPC = 308,						-- ��������NPC
	SubmitNPC = 308,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1364},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_070", 12 ,{10,47,19}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100365,			-- �ύ�������ID
}
TaskList[1][366] = 
{	
	AcceptNPC = 308,						-- ��������NPC
	SubmitNPC = 308,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1365},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_071", 12 ,{10,62,9}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100366,			-- �ύ�������ID
}
TaskList[1][367] = 
{	
	AcceptNPC = 308,						-- ��������NPC
	SubmitNPC = 313,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1366},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100367,			-- �ύ�������ID
}
TaskList[1][368] = 
{	
	AcceptNPC = 313,						-- ��������NPC
	SubmitNPC = 314,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1367},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100368,			-- �ύ�������ID
}
TaskList[1][369] = 
{	
	AcceptNPC = 314,						-- ��������NPC
	SubmitNPC = 314,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1368},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_074", 12 ,{10,54,52}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100369,			-- �ύ�������ID
}
TaskList[1][370] = 
{	
	AcceptNPC = 314,						-- ��������NPC
	SubmitNPC = 314,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1369},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_067", 12 ,{10,61,28},"��ҩ"},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100370,			-- �ύ�������ID
}
TaskList[1][371] = 
{	
	AcceptNPC = 314,						-- ��������NPC
	SubmitNPC = 314,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1370},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10007,1,{10,74,63,100012}}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100371,			-- �ύ�������ID
}
TaskList[1][372] = 
{	
	AcceptNPC = 314,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1371},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100372,			-- �ύ�������ID
}
TaskList[1][373] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 307,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1372},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_063", 12 ,{10,18,40}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100373,			-- �ύ�������ID
}
TaskList[1][374] = 
{	
	AcceptNPC = 307,						-- ��������NPC
	SubmitNPC = 307,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1373},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_064", 12 ,{10,17,15}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100374,			-- �ύ�������ID
}
TaskList[1][375] = 
{	
	AcceptNPC = 307,						-- ��������NPC
	SubmitNPC = 307,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1,	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1374},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "B_079", 1 ,{10,12,12,1}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100375,			-- �ύ�������ID
}
TaskList[1][376] = 
{	
	AcceptNPC = 307,						-- ��������NPC
	SubmitNPC = 56,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1375},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
		[3] = {{25,1,1}},
	},	    
	StoryID = 100376,			-- �ύ�������ID
}
TaskList[1][377] = 
{	
	AcceptNPC = 56,						-- ��������NPC
	SubmitNPC = 56,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1,
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1376},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
		[3] = {{630,10,1},{768,2,1}},
	},	    
	StoryID = 100377,			-- �ύ�������ID
}
TaskList[1][378] = 
{	
	AcceptNPC = 56,						-- ��������NPC
	SubmitNPC = 56,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptOtherTask = {3045,3100},
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1377},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 40,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
		[3] = {{12,200,1}},
	},	    
	StoryID = 100378,			-- �ύ�������ID
}
TaskList[1][400] = 
{	
	AcceptNPC = 56,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptOtherTask = {3008},
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1378},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_066", 15 ,{10,42,73}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100400,			-- �ύ�������ID
}
TaskList[1][401] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1400},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_041", 15 ,{10,37,54}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100401,			-- �ύ�������ID
}
TaskList[1][402] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1401},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_069", 15 ,{10,41,34}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100402,			-- �ύ�������ID
}
TaskList[1][403] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1,	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1402},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "B_080", 1 ,{10,12,12,1}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100403,			-- �ύ�������ID
}
TaskList[1][404] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptOtherTask = {3111,7001},
	ServerAcceptEvent = 1,	  --�����ճ�
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1403},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 41,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100404,			-- �ύ�������ID
}
TaskList[2][28] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1404},
	},
	CompleteCondition = 			-- ����������������
	{
	
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200028,			-- �ύ�������ID
}
TaskList[1][405] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 308,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2028},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_074", 15 ,{10,52,45}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100405,			-- �ύ�������ID
}
TaskList[1][406] = 
{	
	AcceptNPC = 308,						-- ��������NPC
	SubmitNPC = 308,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1405},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_070", 15 ,{10,43,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100406,			-- �ύ�������ID
}
TaskList[1][407] = 
{	
	AcceptNPC = 308,						-- ��������NPC
	SubmitNPC = 308,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1406},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_071", 15 ,{10,64,7}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100407,			-- �ύ�������ID
}
TaskList[1][408] = 
{	
	AcceptNPC = 308,						-- ��������NPC
	SubmitNPC = 308,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1407},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_067", 15 ,{10,59,28}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100408,			-- �ύ�������ID
}
TaskList[1][409] = 
{	
	AcceptNPC = 308,						-- ��������NPC
	SubmitNPC = 308,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1,	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1408},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "B_081", 1 ,{10,12,12,1}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100409,			-- �ύ�������ID
}
TaskList[1][410] = 
{	
	AcceptNPC = 308,						-- ��������NPC
	SubmitNPC = 307,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1409},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 42,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100410,			-- �ύ�������ID
}
TaskList[1][411] = 
{	
	AcceptNPC = 307,						-- ��������NPC
	SubmitNPC = 307,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1410},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_063", 15 ,{10,17,40}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100411,			-- �ύ�������ID
}
TaskList[1][412] = 
{	
	AcceptNPC = 307,						-- ��������NPC
	SubmitNPC = 307,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1411},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_064", 15 ,{10,17,16}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100412,			-- �ύ�������ID
}
TaskList[1][413] = 
{	
	AcceptNPC = 307,						-- ��������NPC
	SubmitNPC = 307,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerAcceptEvent = 1,	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1412},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "B_082", 1 ,{10,12,12,1}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100413,			-- �ύ�������ID
}
TaskList[1][414] = 
{	
	AcceptNPC = 307,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1413},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100414,			-- �ύ�������ID
}
TaskList[1][415] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1414},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 43,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100415,			-- �ύ�������ID
}
TaskList[1][416] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1415},
	},
	CompleteCondition = 			-- ����������������
	{
	
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100416,			-- �ύ�������ID
}
TaskList[1][417] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1416},
	},
	CompleteCondition = 			-- ����������������
	{
	
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
		[3] = {{638,20,1}},
	},	    
	StoryID = 100417,			-- �ύ�������ID
}
TaskList[1][418] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1417},
	},
	CompleteCondition = 			-- ����������������
	{
	
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100418,			-- �ύ�������ID
}
TaskList[1][419] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1418},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 44,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
		[12] = 3000,
	},	    
	StoryID = 100419,			-- �ύ�������ID
}
TaskList[1][420] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1419},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100420,			-- �ύ�������ID
}
TaskList[1][421] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1420},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_068", 15 ,{10,75,35}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100421,			-- �ύ�������ID
}
TaskList[1][422] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1421},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_110", 15 ,{10,87,24}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100422,			-- �ύ�������ID
}
TaskList[2][37] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptOtherTask = {3115},
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1422},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 45,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200037,			-- �ύ�������ID
}





TaskList[1][423] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2037},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_111", 15 ,{10,91,45}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100423,			-- �ύ�������ID
}
TaskList[1][424] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1423},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10003,1,{10,100,8,100013}}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100424,			-- �ύ�������ID
}
TaskList[1][425] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1424},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100425,			-- �ύ�������ID
}
TaskList[1][426] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1425},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 46,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100426,			-- �ύ�������ID
}
TaskList[1][427] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	--AcceptOtherTask = {3046},
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1426},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_120", 15 ,{10,101,31}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
		[3] = {{634,1,1}},
	},	    
	StoryID = 100427,			-- �ύ�������ID
}
TaskList[1][428] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1427},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_112", 15 ,{10,118,43}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
		[3] = {{634,1,1}},
	},	    
	StoryID = 100428,			-- �ύ�������ID
}
--47�����
TaskList[2][38] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1428},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_068", 20 ,{10,75,35}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
		[3] = {{634,1,1}},
	},	    
	StoryID = 200038,			-- �ύ�������ID
}
TaskList[2][39] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2038},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_110", 20 ,{10,87,24}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
		[3] = {{634,1,1}},
	},	    
	StoryID = 200039,			-- �ύ�������ID
}
TaskList[2][40] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2039},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 47,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200040,			-- �ύ�������ID
}
TaskList[2][41] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2040},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_111", 20 ,{10,91,45}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200041,			-- �ύ�������ID
}
TaskList[2][42] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2041},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_120", 20 ,{10,101,31}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200042,			-- �ύ�������ID
}



TaskList[1][429] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2042},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100429,			-- �ύ�������ID
}
TaskList[1][430] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1429},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 48,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100430,			-- �ύ�������ID
}
TaskList[1][431] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 319,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1430},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100431,			-- �ύ�������ID
}
TaskList[1][432] = 
{	
	AcceptNPC = 319,						-- ��������NPC
	SubmitNPC = 319,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1431},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_114", 15 ,{10,102,71}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100432,			-- �ύ�������ID
}
TaskList[1][433] = 
{	
	AcceptNPC = 319,						-- ��������NPC
	SubmitNPC = 319,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1432},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_113", 15 ,{10,87,71},"�������鱨"},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100433,			-- �ύ�������ID
}

TaskList[2][43] = 
{	
	AcceptNPC = 319,						-- ��������NPC
	SubmitNPC = 319,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptOtherTask = {3121},
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1433},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 49,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200043,			-- �ύ�������ID
}

TaskList[1][434] = 
{	
	AcceptNPC = 319,						-- ��������NPC
	SubmitNPC = 319,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2043},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "B_083", 1 ,{10,122,94,1}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100434,			-- �ύ�������ID
}
TaskList[2][44] = 
{	
	AcceptNPC = 319,						-- ��������NPC
	SubmitNPC = 319,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1434},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_114", 20 ,{10,102,71}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200044,			-- �ύ�������ID
}
TaskList[2][45] = 
{	
	AcceptNPC = 319,						-- ��������NPC
	SubmitNPC = 319,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2044},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_113", 20 ,{10,87,71}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200045,			-- �ύ�������ID
}





TaskList[1][435] = 
{	
	AcceptNPC = 319,						-- ��������NPC
	SubmitNPC = 319,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerCompleteEvent = 1,	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2045},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 50,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100435,			-- �ύ�������ID
}
TaskList[1][436] = 
{	
	AcceptNPC = 319,						-- ��������NPC
	SubmitNPC = 319,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1435},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_113", 15 ,{10,87,71}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100436,			-- �ύ�������ID
}
TaskList[1][437] = 
{	
	AcceptNPC = 319,						-- ��������NPC
	SubmitNPC = 319,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1436},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_114", 15 ,{10,102,71},"������鱨"},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100437,			-- �ύ�������ID
}
TaskList[1][438] = 
{	
	AcceptNPC = 319,						-- ��������NPC
	SubmitNPC = 319,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1437},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "B_084", 1 ,{10,122,94,1}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100438,			-- �ύ�������ID
}
TaskList[1][439] = 
{	
	AcceptNPC = 319,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1438},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100439,			-- �ύ�������ID
}
TaskList[2][46] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1439},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 51,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200046,			-- �ύ�������ID
}
TaskList[2][47] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 308,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2046},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_066", 30 ,{10,39,72}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200047,			-- �ύ�������ID
}
TaskList[2][48] = 
{	
	AcceptNPC = 308,						-- ��������NPC
	SubmitNPC = 308,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2047},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_041", 30 ,{10,37,54}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200048,			-- �ύ�������ID
}
TaskList[2][49] = 
{	
	AcceptNPC = 308,						-- ��������NPC
	SubmitNPC = 308,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2048},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_069", 30 ,{10,40,38}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200049,			-- �ύ�������ID
}
TaskList[2][50] = 
{	
	AcceptNPC = 308,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2049},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_070", 30 ,{10,42,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200050,			-- �ύ�������ID
}
TaskList[2][51] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2050},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 52,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200051,			-- �ύ�������ID
}
TaskList[2][52] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 308,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2051},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_074", 30 ,{10,54,52}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200052,			-- �ύ�������ID
}
TaskList[2][53] = 
{	
	AcceptNPC = 308,						-- ��������NPC
	SubmitNPC = 308,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2052},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_067", 30 ,{10,61,28}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200053,			-- �ύ�������ID
}
TaskList[2][54] = 
{	
	AcceptNPC = 308,						-- ��������NPC
	SubmitNPC = 308,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2053},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_071", 30 ,{10,64,7}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200054,			-- �ύ�������ID
}
TaskList[2][55] = 
{	
	AcceptNPC = 308,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2054},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_112", 30 ,{10,118,43}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200055,			-- �ύ�������ID
}

TaskList[1][440] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2055},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 53,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100440,			-- �ύ�������ID
}


TaskList[1][450] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 316,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1440},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_113", 15 ,{10,87,71}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100450,			-- �ύ�������ID
}
TaskList[1][451] = 
{	
	AcceptNPC = 316,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1450},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_114", 15 ,{10,102,71}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100451,			-- �ύ�������ID
}
TaskList[1][452] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1451},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_075", 15 ,{10,99,119}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100452,			-- �ύ�������ID
}
TaskList[1][453] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1452},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_076", 15 ,{10,84,133}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100453,			-- �ύ�������ID
}
TaskList[2][56] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1453},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 54,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200056,			-- �ύ�������ID
}
TaskList[2][57] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2056},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_040", 30 ,{10,50,123}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200057,			-- �ύ�������ID
}
TaskList[2][58] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2057},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_072", 30 ,{10,43,101}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200058,			-- �ύ�������ID
}
TaskList[2][59] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2058},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_068", 30 ,{10,75,35}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200059,			-- �ύ�������ID
}

TaskList[2][62] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2059},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 55,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200062,			-- �ύ�������ID
}

TaskList[2][60] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2062},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_111", 30 ,{10,91,45}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200060,			-- �ύ�������ID
}
TaskList[2][61] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2060},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_120", 30 ,{10,101,31}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200061,			-- �ύ�������ID
}



TaskList[1][454] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 318,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2061},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100454,			-- �ύ�������ID
}
TaskList[1][455] = 
{	
	AcceptNPC = 318,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1454},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100455,			-- �ύ�������ID
}
TaskList[1][456] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1455},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 56,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100456,			-- �ύ�������ID
}
TaskList[1][457] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1456},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100457,			-- �ύ�������ID
}
TaskList[1][458] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1457},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_077", 15 ,{10,113,138}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100458,			-- �ύ�������ID
}
TaskList[1][459] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1458},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_078", 15 ,{10,97,155}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100459,			-- �ύ�������ID
}
TaskList[1][460] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1459},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_078", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100460,			-- �ύ�������ID
}
TaskList[1][461] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1460},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 57,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100461,			-- �ύ�������ID
}
TaskList[1][462] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1461},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_075", 20 ,{10,97,115}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100462,			-- �ύ�������ID
}

TaskList[2][63] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1462},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 58,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200063,			-- �ύ�������ID
}

TaskList[1][463] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2063},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_076", 20 ,{10,80,131}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100463,			-- �ύ�������ID
}

TaskList[2][64] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1463},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 59,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200064,			-- �ύ�������ID
}
TaskList[2][65] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2064},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200065,			-- �ύ�������ID
}
TaskList[2][66] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2065},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 60,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200066,			-- �ύ�������ID
}
TaskList[2][67] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2066},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200067,			-- �ύ�������ID
}
TaskList[2][68] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2067},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 61,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200068,			-- �ύ�������ID
}

TaskList[1][464] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2068},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_077", 20 ,{10,118,142}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100464,			-- �ύ�������ID
}
TaskList[2][69] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1464},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 62,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200069,			-- �ύ�������ID
}

TaskList[1][465] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2069},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_078", 30 ,{10,98,159}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100465,			-- �ύ�������ID
}

TaskList[2][70] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1465},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 63,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200070,			-- �ύ�������ID
}
TaskList[2][71] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2070},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_075", 50 ,{10,107,115}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200071,			-- �ύ�������ID
}
TaskList[2][72] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2071},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 64,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200072,			-- �ύ�������ID
}
TaskList[2][73] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2072},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_076", 50 ,{10,89,132}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200073,			-- �ύ�������ID
}


TaskList[1][466] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2073},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 65,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100466,			-- �ύ�������ID
}
TaskList[1][467] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1466},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100467,			-- �ύ�������ID
}

TaskList[2][74] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1467},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 66,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200074,			-- �ύ�������ID
}
TaskList[2][75] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2074},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_077", 50 ,{10,113,140}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200075,			-- �ύ�������ID
}
TaskList[2][76] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2075},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 67,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200076,			-- �ύ�������ID
}
TaskList[2][77] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2076},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_078", 50 ,{10,98,163}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200077,			-- �ύ�������ID
}
TaskList[2][78] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2077},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 68,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200078,			-- �ύ�������ID
}
TaskList[2][79] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2078},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_077", 50 ,{10,113,140}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200079,			-- �ύ�������ID
}
TaskList[2][80] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2079},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 69,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200080,			-- �ύ�������ID
}
TaskList[2][81] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 317,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2080},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_076", 50 ,{10,80,131}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 200081,			-- �ύ�������ID
}


TaskList[1][468] = 
{	
	AcceptNPC = 317,						-- ��������NPC
	SubmitNPC = 49,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2081},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100468,			-- �ύ�������ID
}
TaskList[1][469] = 
{	
	AcceptNPC = 49,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1468},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100469,			-- �ύ�������ID
}
TaskList[1][470] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1469},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 70,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100470,			-- �ύ�������ID
}
--��Ұ����
TaskList[1][500] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 350,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1470},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100500,			-- �ύ�������ID
}
TaskList[1][501] = 
{	
	AcceptNPC = 350,						-- ��������NPC
	SubmitNPC = 350,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1500},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_127", 50 ,{12,26,220}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100501,			-- �ύ�������ID
}
TaskList[1][502] = 
{	
	AcceptNPC = 350,						-- ��������NPC
	SubmitNPC = 350,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1501},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_128", 50 ,{12,14,170}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100502,			-- �ύ�������ID
}
TaskList[1][503] = 
{	
	AcceptNPC = 350,						-- ��������NPC
	SubmitNPC = 350,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1502},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 71,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100503,			-- �ύ�������ID
}
TaskList[1][504] = 
{	
	AcceptNPC = 350,						-- ��������NPC
	SubmitNPC = 351,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1503},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100504,			-- �ύ�������ID
}
TaskList[1][505] = 
{	
	AcceptNPC = 351,						-- ��������NPC
	SubmitNPC = 352,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1504},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100505,			-- �ύ�������ID
}
TaskList[1][506] = 
{	
	AcceptNPC = 352,						-- ��������NPC
	SubmitNPC = 352,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1505},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_129", 50 ,{12,20,135},"��ҩ�䷽"},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100506,			-- �ύ�������ID
}
TaskList[1][507] = 
{	
	AcceptNPC = 352,						-- ��������NPC
	SubmitNPC = 351,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1506},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_128", 50 ,{12,23,179},"��ʱ��ҩ"},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100507,			-- �ύ�������ID
}
TaskList[1][508] = 
{	
	AcceptNPC = 351,						-- ��������NPC
	SubmitNPC = 352,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1507},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10001,1,{3,58,155,100001}}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100508,			-- �ύ�������ID
}
TaskList[1][509] = 
{	
	AcceptNPC = 352,						-- ��������NPC
	SubmitNPC = 352,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1508},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10006,1,{10,55,153,100015}}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100509,			-- �ύ�������ID
}
TaskList[1][510] = 
{	
	AcceptNPC = 352,						-- ��������NPC
	SubmitNPC = 351,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1509},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100510,			-- �ύ�������ID
}
TaskList[1][511] = 
{	
	AcceptNPC = 351,						-- ��������NPC
	SubmitNPC = 355,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1510},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100511,			-- �ύ�������ID
}
TaskList[1][512] = 
{	
	AcceptNPC = 355,						-- ��������NPC
	SubmitNPC = 355,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1511},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 72,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100512,			-- �ύ�������ID
}
TaskList[1][513] = 
{	
	AcceptNPC = 355,						-- ��������NPC
	SubmitNPC = 351,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1512},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100513,			-- �ύ�������ID
}
TaskList[1][514] = 
{	
	AcceptNPC = 351,						-- ��������NPC
	SubmitNPC = 351,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1513},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_130", 50 ,{12,15,102}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100514,			-- �ύ�������ID
}
TaskList[1][515] = 
{	
	AcceptNPC = 351,						-- ��������NPC
	SubmitNPC = 351,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1514},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_129", 50 ,{12,25,149}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100515,			-- �ύ�������ID
}
TaskList[1][516] = 
{	
	AcceptNPC = 351,						-- ��������NPC
	SubmitNPC = 350,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1515},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100516,			-- �ύ�������ID
}
TaskList[1][517] = 
{	
	AcceptNPC = 350,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1516},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100517,			-- �ύ�������ID
}
TaskList[1][518] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1517},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 73,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100518,			-- �ύ�������ID
}
TaskList[1][519] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 350,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1518},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100519,			-- �ύ�������ID
}
TaskList[1][520] = 
{	
	AcceptNPC = 350,						-- ��������NPC
	SubmitNPC = 353,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1519},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100520,			-- �ύ�������ID
}
TaskList[1][521] = 
{	
	AcceptNPC = 353,						-- ��������NPC
	SubmitNPC = 353,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1520},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_131", 50 ,{12,57,220}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100521,			-- �ύ�������ID
}
TaskList[1][522] = 
{	
	AcceptNPC = 353,						-- ��������NPC
	SubmitNPC = 353,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1521},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_132", 50 ,{12,91,224}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100522,			-- �ύ�������ID
}
TaskList[1][523] = 
{	
	AcceptNPC = 353,						-- ��������NPC
	SubmitNPC = 353,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1522},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_133", 50 ,{12,72,184}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100523,			-- �ύ�������ID
}
TaskList[1][524] = 
{	
	AcceptNPC = 353,						-- ��������NPC
	SubmitNPC = 353,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1523},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 74,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100524,			-- �ύ�������ID
}
TaskList[1][525] = 
{	
	AcceptNPC = 353,						-- ��������NPC
	SubmitNPC = 56,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1524},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100525,			-- �ύ�������ID
}
TaskList[1][526] = 
{	
	AcceptNPC = 56,						-- ��������NPC
	SubmitNPC = 353,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1525},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_131", 50 ,{12,54,225},"ľ������ʯ"},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100526,			-- �ύ�������ID
}
TaskList[1][527] = 
{	
	AcceptNPC = 353,						-- ��������NPC
	SubmitNPC = 353,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1526},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_132", 50 ,{12,89,213},"��������ʯ"},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100527,			-- �ύ�������ID
}
TaskList[1][528] = 
{	
	AcceptNPC = 353,						-- ��������NPC
	SubmitNPC = 56,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1527},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_133", 50 ,{12,68,184},"��ͭ����ʯ"},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100528,			-- �ύ�������ID
}
TaskList[1][529] = 
{	
	AcceptNPC = 56,						-- ��������NPC
	SubmitNPC = 56,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1528},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 75,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100529,			-- �ύ�������ID
}
TaskList[1][530] = 
{	
	AcceptNPC = 56,						-- ��������NPC
	SubmitNPC = 353,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1529},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_134", 50 ,{12,113,231}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100530,			-- �ύ�������ID
}
TaskList[1][531] = 
{	
	AcceptNPC = 353,						-- ��������NPC
	SubmitNPC = 315,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1530},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100531,			-- �ύ�������ID
}
TaskList[1][532] = 
{	
	AcceptNPC = 315,						-- ��������NPC
	SubmitNPC = 151,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1531},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100532,			-- �ύ�������ID
}
TaskList[1][533] = 
{	
	AcceptNPC = 151,						-- ��������NPC
	SubmitNPC = 353,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1532},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_135", 50 ,{12,98,141},"����"},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100533,			-- �ύ�������ID
}
TaskList[1][534] = 
{	
	AcceptNPC = 353,						-- ��������NPC
	SubmitNPC = 353,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1533},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 76,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100534,			-- �ύ�������ID
}
TaskList[1][535] = 
{	
	AcceptNPC = 353,						-- ��������NPC
	SubmitNPC = 353,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1534},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_136", 50 ,{12,119,168}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100535,			-- �ύ�������ID
}
TaskList[1][536] = 
{	
	AcceptNPC = 353,						-- ��������NPC
	SubmitNPC = 353,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1535},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_133", 50 ,{12,92,179}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100536,			-- �ύ�������ID
}
TaskList[1][537] = 
{	
	AcceptNPC = 353,						-- ��������NPC
	SubmitNPC = 353,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1536},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_134", 50 ,{12,115,212}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100537,			-- �ύ�������ID
}
TaskList[1][538] = 
{	
	AcceptNPC = 353,						-- ��������NPC
	SubmitNPC = 49,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1537},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100538,			-- �ύ�������ID
}
TaskList[1][539] = 
{	
	AcceptNPC = 49,						-- ��������NPC
	SubmitNPC = 49,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1538},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 77,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100539,			-- �ύ�������ID
}
TaskList[1][540] = 
{	
	AcceptNPC = 49,						-- ��������NPC
	SubmitNPC = 56,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1539},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100540,			-- �ύ�������ID
}
TaskList[1][541] = 
{	
	AcceptNPC = 56,						-- ��������NPC
	SubmitNPC = 202,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1540},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100541,			-- �ύ�������ID
}
TaskList[1][542] = 
{	
	AcceptNPC = 202,						-- ��������NPC
	SubmitNPC = 202,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1541},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100542,			-- �ύ�������ID
}
TaskList[1][543] = 
{	
	AcceptNPC = 202,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1542},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 78,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2200000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100543,			-- �ύ�������ID
}
TaskList[1][544] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1543},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_137", 50 ,{12,69,162}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2200000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100544,			-- �ύ�������ID
}
TaskList[1][545] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1544},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_138", 50 ,{12,58,130}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2200000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100545,			-- �ύ�������ID
}
TaskList[1][546] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1545},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 79,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100546,			-- �ύ�������ID
}
TaskList[1][547] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1546},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_139", 50 ,{12,34,100}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100547,			-- �ύ�������ID
}
TaskList[1][548] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1547},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_141", 50 ,{12,16,71}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100548,			-- �ύ�������ID
}
TaskList[1][549] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1548},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2400000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100549,			-- �ύ�������ID
}
TaskList[1][550] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1549},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 80,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2600000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100550,			-- �ύ�������ID
}
TaskList[1][551] = 
{	
	AcceptNPC = 48,						-- ��������NPC
	SubmitNPC = 350,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1550},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2600000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100551,			-- �ύ�������ID
}
TaskList[1][552] = 
{	
	AcceptNPC = 350,						-- ��������NPC
	SubmitNPC = 350,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1551},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_140", 50 ,{12,75,62}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2600000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100552,			-- �ύ�������ID
}
TaskList[1][553] = 
{	
	AcceptNPC = 350,						-- ��������NPC
	SubmitNPC = 350,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1552},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_142", 50 ,{12,40,25}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2600000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100553,			-- �ύ�������ID
}
TaskList[1][554] = 
{	
	AcceptNPC = 350,						-- ��������NPC
	SubmitNPC = 350,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1553},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_143", 50 ,{12,81,29}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2600000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100554,			-- �ύ�������ID
}
TaskList[1][555] = 
{	
	AcceptNPC = 350,						-- ��������NPC
	SubmitNPC = 350,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1554},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_144", 50 ,{12,112,63}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2600000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100555,			-- �ύ�������ID
}
TaskList[1][556] = 
{	
	AcceptNPC = 350,						-- ��������NPC
	SubmitNPC = 350,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1555},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 81,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100556,			-- �ύ�������ID
}
TaskList[1][557] = 
{	
	AcceptNPC = 350,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1556},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100557,			-- �ύ�������ID
}
TaskList[1][558] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1557},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_135", 50 ,{12,87,131}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100558,			-- �ύ�������ID
}
TaskList[1][559] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1558},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_137", 50 ,{12,63,144}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100559,			-- �ύ�������ID
}
TaskList[1][560] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1559},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_138", 50 ,{12,71,118}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3000000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100560,			-- �ύ�������ID
}
TaskList[1][561] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1560},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 82,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3200000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100561,			-- �ύ�������ID
}
TaskList[1][562] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1561},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_139", 50 ,{12,42,89}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3200000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100562,			-- �ύ�������ID
}
TaskList[1][563] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1562},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_141", 50 ,{12,24,65}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3200000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100563,			-- �ύ�������ID
}
TaskList[1][564] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1563},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_140", 50 ,{12,87,44}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3200000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100564,			-- �ύ�������ID
}
TaskList[1][565] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1564},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 83,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100565,			-- �ύ�������ID
}
TaskList[1][566] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1565},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_142", 50 ,{12,56,40}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100566,			-- �ύ�������ID
}
TaskList[1][567] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1566},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_143", 50 ,{12,96,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100567,			-- �ύ�������ID
}
TaskList[1][568] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 354,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1567},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_144", 50 ,{12,111,96}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100568,			-- �ύ�������ID
}
TaskList[1][569] = 
{	
	AcceptNPC = 354,						-- ��������NPC
	SubmitNPC = 350,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1568},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3500000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100569,			-- �ύ�������ID
}
TaskList[1][570] = 
{	
	AcceptNPC = 350,						-- ��������NPC
	SubmitNPC = 350,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1569},
	},
	CompleteCondition = 			-- ����������������
	{
		level = 84,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100570,			-- �ύ�������ID
}
TaskList[1][571] = 
{	
	AcceptNPC = 350,						-- ��������NPC
	SubmitNPC = 356,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1570},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100571,			-- �ύ�������ID
}
TaskList[1][572] = 
{	
	AcceptNPC = 356,						-- ��������NPC
	SubmitNPC = 350,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1571},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100572,			-- �ύ�������ID
}
TaskList[1][573] = 
{	
	AcceptNPC = 350,						-- ��������NPC
	SubmitNPC = 48,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1572},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3800000,
		[1] = 10000,
		[5] = 10000,
	},	    
	StoryID = 100573,			-- �ύ�������ID
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
		kill = { "M_134", 50 ,{12,115,212},"ľ֮��"},
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
		kill = { "M_142", 50 ,{12,56,40},"��֮��"},
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
		kill = { "M_139", 50 ,{12,42,89},"��֮��"},
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
		kill = { "M_144", 50 ,{12,111,96},"��֮��"},
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
		kill = { "M_143", 50 ,{12,96,20},"ˮ֮��"},
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
--������֧��
TaskList[3][1] = 
{	
	AcceptNPC = 38,						-- ��������NPC
	SubmitNPC = 38,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	ServerCompleteEvent = 1,	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1179},
	},
	CompleteCondition = 			-- ����������������
	{
		faction = 1,
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[1] = 50000,
	},
	    
	StoryID = 300001,			-- �ύ�������ID
}
--��ʯ��Ƕ
TaskList[3][2] = 
{	
	AcceptNPC = 38,						-- ��������NPC
	SubmitNPC = 38,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1324},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{607,1,1}},
	},
	    
	StoryID = 300002,			-- �ύ�������ID
}

--װ��ǿ��
TaskList[3][3] = 
{	
	AcceptNPC = 38,						-- ��������NPC
	SubmitNPC = 38,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3002},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{		
		[2] = 100000,
		[1] = 200000,	
	},
	    
	StoryID = 300003,			-- �ύ�������ID
}
--�ҽ�����
TaskList[3][4] = 
{	
	AcceptNPC = 38,						-- ��������NPC
	SubmitNPC = 38,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3003},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[5] = 200000,
	},
	    
	StoryID = 300004,			-- �ύ�������ID
}
--��������
TaskList[3][5] = 
{	
	AcceptNPC = 38,						-- ��������NPC
	SubmitNPC = 38,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3004},
	},
	CompleteCondition = 			-- ����������������
	{
		  
	},
	CompleteAwards = 					-- ���������
	{		
		[2] = 500000,
			
	},
	    
	StoryID = 300005,			-- �ύ�������ID
}
--�ֽ�װ��
TaskList[3][6] = 
{	
	AcceptNPC = 38,						-- ��������NPC
	SubmitNPC = 38,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1203},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{604,20,1}},
	},
	    
	StoryID = 300006,			-- �ύ�������ID
}
--װ��ϴ��
TaskList[3][7] = 
{	
	AcceptNPC = 38,						-- ��������NPC
	SubmitNPC = 38,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3006},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
	},
	    
	StoryID = 300007,			-- �ύ�������ID
}


--��Ӹ���
TaskList[3][8] = 
{	
	AcceptNPC = 49,						-- ��������NPC
	SubmitNPC = 49,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1378},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 500000,
		[3] = {{625,2,1}},
	},
	    
	StoryID = 300008,			-- �ύ�������ID
}
TaskList[3][9] = 
{	
	AcceptNPC = 49,						-- ��������NPC
	SubmitNPC = 49,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3008},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		
	},
	    
	StoryID = 300009,			-- �ύ�������ID
}
--��ħ¼
TaskList[3][10] = 
{	
	AcceptNPC = 56,						-- ��������NPC
	SubmitNPC = 56,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1256},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{		
		[2] = 100000,
		[1] = 20000,
		[3] = {{724,5,1}},
	},
	QuickSub = 3011,			--Զ���ύ���񲢽�����һ������    
	StoryID = 300010,			-- �ύ�������ID
}
TaskList[3][11] = 
{	
	AcceptNPC = 56,						-- ��������NPC
	SubmitNPC = 56,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3010},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[1] = 30000,
		[3] = {{724,5,1}},
	},
	QuickSub = 3012,			--Զ���ύ���񲢽�����һ������    
	StoryID = 300011,			-- �ύ�������ID
}
TaskList[3][12] = 
{	
	AcceptNPC = 56,						-- ��������NPC
	SubmitNPC = 56,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3011},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[1] = 40000,
		[3] = {{724,5,1}},
	},
	QuickSub = 3013,			--Զ���ύ���񲢽�����һ������        
	StoryID = 300012,			-- �ύ�������ID
}
TaskList[3][13] = 
{	
	AcceptNPC = 56,						-- ��������NPC
	SubmitNPC = 56,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3012},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[1] = 50000,
		[3] = {{724,5,1}},
	},
	QuickSub = 3014,			--Զ���ύ���񲢽�����һ������        
	StoryID = 300013,			-- �ύ�������ID
}
TaskList[3][14] = 
{	
	AcceptNPC = 56,						-- ��������NPC
	SubmitNPC = 56,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3013},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[1] = 60000,
		[3] = {{724,5,1}},
	},
	QuickSub = 3015,			--Զ���ύ���񲢽�����һ������        
	StoryID = 300014,			-- �ύ�������ID
}
TaskList[3][15] = 
{	
	AcceptNPC = 56,						-- ��������NPC
	SubmitNPC = 56,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3014},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[1] = 70000,
		[3] = {{718,3,1}},
	},
	QuickSub = 3016,			--Զ���ύ���񲢽�����һ������        
	StoryID = 300015,			-- �ύ�������ID
}
TaskList[3][16] = 
{	
	AcceptNPC = 56,						-- ��������NPC
	SubmitNPC = 56,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3015},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[1] = 80000,
		[3] = {{718,3,1}},
	},
	QuickSub = 3017,			--Զ���ύ���񲢽�����һ������        
	StoryID = 300016,			-- �ύ�������ID
}
TaskList[3][17] = 
{	
	AcceptNPC = 56,						-- ��������NPC
	SubmitNPC = 56,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3016},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[1] = 90000,
		[3] = {{718,3,1}},
	},
	QuickSub = 1,			--Զ���ύ���񲢽�����һ������        
	StoryID = 300017,			-- �ύ�������ID
}

TaskList[3][30] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1180},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		
		[2] = 100000,
	},	    
	StoryID = 300030,			-- �ύ�������ID
}
TaskList[3][31] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		level = 999,
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[1] = 100000,
		[2] = 200000,
	},	    
	StoryID = 300031,			-- �ύ�������ID
}


TaskList[3][35] = 
{	
	AcceptNPC = 49,						-- ��������NPC
	SubmitNPC = 49,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		level = 999,
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
		[5] = 100000,	
		
	},	    
	StoryID = 300035,			-- �ύ�������ID
}
TaskList[3][40] = 
{	
	AcceptNPC = 49,						-- ��������NPC
	SubmitNPC = 49,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={2027},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[1] = 100000,
		[2] = 200000,
	},	    
	StoryID = 300040,			-- �ύ�������ID
}

TaskList[3][42] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 49,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		--level = 999,
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[1] = 200000,
		[5] = 200000,
		[3] = {{5625,1,1}},
	},	    
	StoryID = 300042,			-- �ύ�������ID
	QuickSub = 1,			--Զ���ύ���񲢽�����һ������       
}
TaskList[3][45] = 
{	
	AcceptNPC = 36,						-- ��������NPC
	SubmitNPC = 36,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1377},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[3] = {{1108,5,1}},
	},	    
	StoryID = 300045,			-- �ύ�������ID
}
TaskList[3][46] = 
{	
	AcceptNPC = 38,						-- ��������NPC
	SubmitNPC = 38,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		level = 999,
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 500000,
		--[3] = {{1110,1,1}},
	},	    
	StoryID = 300046,			-- �ύ�������ID
}


TaskList[3][100] = 
{	
	AcceptNPC = 104,						-- ��������NPC
	SubmitNPC = 104,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1377},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
	},	    
	StoryID = 300100,			-- �ύ�������ID
}
TaskList[3][101] = 
{	
	AcceptNPC = 104,						-- ��������NPC
	SubmitNPC = 104,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3100},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_259", 20 ,{22,28,12}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
	},	    
	StoryID = 300101,			-- �ύ�������ID
}
TaskList[3][102] = 
{	
	AcceptNPC = 104,						-- ��������NPC
	SubmitNPC = 104,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3101},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_260", 20 ,{22,19,51}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
	},	    
	StoryID = 300102,			-- �ύ�������ID
}
TaskList[3][103] = 
{	
	AcceptNPC = 104,						-- ��������NPC
	SubmitNPC = 104,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3102},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_261", 20 ,{22,36,67}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
	},	    
	StoryID = 300103,			-- �ύ�������ID
}


TaskList[3][111] = 
{	
	AcceptNPC = 157,						-- ��������NPC
	SubmitNPC = 157,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1403},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
	},	    
	StoryID = 300111,			-- �ύ�������ID
}
TaskList[3][112] = 
{	
	AcceptNPC = 157,						-- ��������NPC
	SubmitNPC = 157,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3111},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_255", 20 ,{31,10,96}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
	},	    
	StoryID = 300112,			-- �ύ�������ID
}
TaskList[3][113] = 
{	
	AcceptNPC = 157,						-- ��������NPC
	SubmitNPC = 157,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3112},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_256", 20 ,{31,24,63}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
	},	    
	StoryID = 300113,			-- �ύ�������ID
}
TaskList[3][114] = 
{	
	AcceptNPC = 157,						-- ��������NPC
	SubmitNPC = 157,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3113},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_257", 20 ,{31,6,42}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
	},	    
	StoryID = 300114,			-- �ύ�������ID
}
--45��
TaskList[3][115] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1422},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
	},	    
	StoryID = 300115,			-- �ύ�������ID
}
TaskList[3][116] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3115},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_065",30,{10,12,83}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
	},	    
	StoryID = 300116,			-- �ύ�������ID
}
TaskList[3][117] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3116},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_039",30,{10,18,157}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
	},	    
	StoryID = 300117,			-- �ύ�������ID
}
TaskList[3][118] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3117},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_040",30,{10,50,123}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
	},	    
	StoryID = 300118,			-- �ύ�������ID
}
TaskList[3][119] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3118},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_072",30,{10,43,101}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
	},	    
	StoryID = 300119,			-- �ύ�������ID
}
TaskList[3][120] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3119},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_073",30,{10,60,145}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
	},	    
	StoryID = 300120,			-- �ύ�������ID
}

--47��
TaskList[3][121] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={1433},
	},
	CompleteCondition = 			-- ����������������
	{
		
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
	},	    
	StoryID = 300121,			-- �ύ�������ID
}
TaskList[3][122] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3121},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_066",40,{10,39,72}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
	},	    
	StoryID = 300122,			-- �ύ�������ID
}
TaskList[3][123] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3122},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_041",40,{10,37,54}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
	},	    
	StoryID = 300123,			-- �ύ�������ID
}
TaskList[3][124] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3123},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_069",40,{10,40,38}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
	},	    
	StoryID = 300124,			-- �ύ�������ID
}
TaskList[3][125] = 
{	
	AcceptNPC = 306,						-- ��������NPC
	SubmitNPC = 306,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={3124},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_070",40,{10,42,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
	},	    
	StoryID = 300125,			-- �ύ�������ID
}










--�ճ�����
TaskList[4] = 
{
}
TaskList[4][1] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		level = {38,44},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_350", 1000},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 375000,
	},	    
	StoryID = 400001,			-- �ύ�������ID
	QuickClear = 30,
	task = {4,2},	-- ���͸���̨��������
}
TaskList[4][2] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4001},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_350", 1500 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 525000,
	},	    
	StoryID = 400002,			-- �ύ�������ID
	QuickClear = 30,
	task = {4,3},	-- ���͸���̨��������
}
TaskList[4][3] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4002},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_350", 2000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 600000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400003,			-- �ύ�������ID
	QuickClear = 30,
}

TaskList[4][6] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		level = {45,49},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_351", 1000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 437500,
		
	},	    
	StoryID = 400006,			-- �ύ�������ID
	QuickClear = 30,
	task = {4,7},	-- ���͸���̨��������
}
TaskList[4][7] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4006},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_351", 1500 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 612500,
		
	},	    
	StoryID = 400007,			-- �ύ�������ID
	QuickClear = 30,
	task = {4,8},	-- ���͸���̨��������
}
TaskList[4][8] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4007},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_351", 2000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400008,			-- �ύ�������ID
	QuickClear = 30,
}

TaskList[4][11] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		level = {50,54},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_352", 1000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 475000,
		
	},	    
	StoryID = 400011,			-- �ύ�������ID
	QuickClear = 30,
	task = {4,12},	-- ���͸���̨��������
}
TaskList[4][12] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4011},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_352", 1500 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 665000,
		
	},	    
	StoryID = 400012,			-- �ύ�������ID
	QuickClear = 30,
	task = {4,13},	-- ���͸���̨��������
}
TaskList[4][13] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4012},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_352", 2000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 760000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400013,			-- �ύ�������ID
	QuickClear = 30,
}


TaskList[4][16] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		level = {55,59},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_353", 1000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 500000,
		
	},	    
	StoryID = 400016,			-- �ύ�������ID
	QuickClear = 30,
	task = {4,17},	-- ���͸���̨��������
}
TaskList[4][17] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4016},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_353", 1500 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		
	},	    
	StoryID = 400017,			-- �ύ�������ID
	QuickClear = 30,
	task = {4,18},	-- ���͸���̨��������
}
TaskList[4][18] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4017},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_353", 2000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 800000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400018,			-- �ύ�������ID
	QuickClear = 30,
}


TaskList[4][21] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		level = {60,64},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_354", 1000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 625000,
		
	},	    
	StoryID = 400021,			-- �ύ�������ID
	QuickClear = 30,
	task = {4,22},	-- ���͸���̨��������
}
TaskList[4][22] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4021},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_354", 1500 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 875000,
		
	},	    
	StoryID = 400022,			-- �ύ�������ID
	QuickClear = 30,
	task = {4,23},	-- ���͸���̨��������
}
TaskList[4][23] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4022},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_354", 2000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400023,			-- �ύ�������ID
	QuickClear = 30,
}


TaskList[4][26] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		level = {65,69},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_355", 1000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 700000,
		
	},	    
	StoryID = 400026,			-- �ύ�������ID
	QuickClear = 30,
	task = {4,27},	-- ���͸���̨��������
}
TaskList[4][27] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4026},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_355", 1500 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		
	},	    
	StoryID = 400027,			-- �ύ�������ID
	QuickClear = 30,
	task = {4,28},	-- ���͸���̨��������
}
TaskList[4][28] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4027},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_355", 2000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1200000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400028,			-- �ύ�������ID
	QuickClear = 30,
}

TaskList[4][31] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		level = {70,74},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_356", 1000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1500000,
		
	},	    
	StoryID = 400031,			-- �ύ�������ID
	QuickClear = 30,
	task = {4,32},	-- ���͸���̨��������
}
TaskList[4][32] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4031},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_356", 1500 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2100000,
		
	},	    
	StoryID = 400032,			-- �ύ�������ID
	QuickClear = 30,
	task = {4,33},	-- ���͸���̨��������
}
TaskList[4][33] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4032},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_356", 2000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2400000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400033,			-- �ύ�������ID
	QuickClear = 30,
}

TaskList[4][36] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		level = {75,79},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_357", 1000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1800000,
		
	},	    
	StoryID = 400036,			-- �ύ�������ID
	QuickClear = 30,
	task = {4,37},	-- ���͸���̨��������
}
TaskList[4][37] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4036},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_357", 1500 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2600000,
		
	},	    
	StoryID = 400037,			-- �ύ�������ID
	QuickClear = 30,
	task = {4,38},	-- ���͸���̨��������
}
TaskList[4][38] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4037},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_357", 2000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3000000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400038,			-- �ύ�������ID
	QuickClear = 30,
}
TaskList[4][41] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		level={80,84},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_358", 1000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2000000,
	},	    
	StoryID = 400041,			-- �ύ�������ID
	QuickClear = 30,
}
TaskList[4][42] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4041},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_358", 1500 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2800000,
	},	    
	StoryID = 400042,			-- �ύ�������ID
	QuickClear = 30,
}
TaskList[4][43] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4042},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_358", 2000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3200000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400043,			-- �ύ�������ID
	QuickClear = 30,
}
TaskList[4][46] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		level={85,89},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_359", 1000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2200000,
	},	    
	StoryID = 400046,			-- �ύ�������ID
	QuickClear = 30,
}
TaskList[4][47] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4046},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_359", 1500 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3000000,
	},	    
	StoryID = 400047,			-- �ύ�������ID
	QuickClear = 30,
}
TaskList[4][48] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4047},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_359", 2000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3400000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400048,			-- �ύ�������ID
	QuickClear = 30,	
}
TaskList[4][51] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		level={90,94},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_360", 1000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2400000,
	},	    
	StoryID = 400051,			-- �ύ�������ID
	QuickClear = 30,
}
TaskList[4][52] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4051},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_360", 1500 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3200000,
	},	    
	StoryID = 400052,			-- �ύ�������ID
	QuickClear = 30,
}
TaskList[4][53] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4052},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_360", 2000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3600000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400053,			-- �ύ�������ID
	QuickClear = 30,	
}
TaskList[4][56] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		level={95,999},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_361", 1000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 2600000,
	},	    
	StoryID = 400056,			-- �ύ�������ID
	QuickClear = 30,
}
TaskList[4][57] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4056},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_361", 1500 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3400000,
	},	    
	StoryID = 400057,			-- �ύ�������ID
	QuickClear = 30,
}
TaskList[4][58] = 
{	
	AcceptNPC = 57,						-- ��������NPC
	SubmitNPC = 57,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4057},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "GJ_361", 2000 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 3800000,
		[3] = {{748,1,1}},
	},	    
	StoryID = 400058,			-- �ύ�������ID
	QuickClear = 30,		
}

--����ճ�
TaskList[4][101] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		faction = 1,
		level = {30,39},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_018", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400101,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,102},	-- ���͸���̨��������
	facidx = 1,
}
TaskList[4][102] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4101},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_019", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400102,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,103},	-- ���͸���̨��������
	facidx = 2,
}
TaskList[4][103] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4102},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_017", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400103,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,104},	-- ���͸���̨��������
	facidx = 3,
}
TaskList[4][104] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4103},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_018", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400104,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,105},	-- ���͸���̨��������
	facidx = 4,
}
TaskList[4][105] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4104},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_019", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400105,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,160},	-- ���͸���̨��������
	facidx = 5,
}
TaskList[4][160] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4105},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_017", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400160,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,161},	-- ���͸���̨��������
	facidx = 6,
}
TaskList[4][161] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4160},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_018", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400161,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,162},	-- ���͸���̨��������
	facidx = 7,
}
TaskList[4][162] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4161},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_019", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400162,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,163},	-- ���͸���̨��������
	facidx = 8,
}
TaskList[4][163] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4162},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_017", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400163,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,164},	-- ���͸���̨��������
	facidx = 9,
}
TaskList[4][164] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4163},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_018", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400164,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,165},	-- ���͸���̨��������
	facidx = 10,
}
TaskList[4][165] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4164},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_019", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400165,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,166},	-- ���͸���̨��������
	facidx = 11,
}
TaskList[4][166] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4165},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_017", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400166,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,167},	-- ���͸���̨��������
	facidx = 12,
}
TaskList[4][167] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4166},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_018", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400167,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,168},	-- ���͸���̨��������
	facidx = 13,
}
TaskList[4][168] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4167},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_019", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400168,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,169},	-- ���͸���̨��������
	facidx = 14,
}
TaskList[4][169] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4168},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_017", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400169,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,170},	-- ���͸���̨��������
	facidx = 15,
}
TaskList[4][170] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4169},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_018", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400170,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,171},	-- ���͸���̨��������
	facidx = 16,
}
TaskList[4][171] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4170},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_019", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400171,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,172},	-- ���͸���̨��������
	facidx = 17,
}
TaskList[4][172] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4171},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_017", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400172,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,173},	-- ���͸���̨��������
	facidx = 18,
}
TaskList[4][173] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4172},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_018", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400173,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,174},	-- ���͸���̨��������
	facidx = 19,
}
TaskList[4][174] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	LinkEnd = 1,						--���������
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4173},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_019", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 30000,
		[3] = {{749,1,1},{682,1,1}},
	},	    
	StoryID = 400174,			-- �ύ�������ID
	QuickClear = 5,
	facidx = 20,
}



--����ճ�
TaskList[4][106] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		faction = 1,
		level = {40,44},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_259", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400106,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,107},	-- ���͸���̨��������
	facidx = 1,
}
TaskList[4][107] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4106},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_260", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400107,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,108},	-- ���͸���̨��������
	facidx = 2,
}
TaskList[4][108] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4107},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_261", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400108,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,109},	-- ���͸���̨��������
	facidx = 3,
}
TaskList[4][109] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4108},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_259", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400109,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,110},	-- ���͸���̨��������
	facidx = 4,
}
TaskList[4][110] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4109},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_261", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400110,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,180},	-- ���͸���̨��������
	facidx = 5,
}
TaskList[4][180] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4110},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_259", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400180,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,181},	-- ���͸���̨��������
	facidx = 6,
}
TaskList[4][181] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4180},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_260", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400181,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,182},	-- ���͸���̨��������
	facidx = 7,
}
TaskList[4][182] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4181},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_261", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400182,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,183},	-- ���͸���̨��������
	facidx = 8,
}
TaskList[4][183] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4182},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_259", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400183,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,184},	-- ���͸���̨��������
	facidx = 9,
}
TaskList[4][184] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4183},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_260", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400184,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,185},	-- ���͸���̨��������
	facidx = 10,
}
TaskList[4][185] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4184},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_261", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400185,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,186},	-- ���͸���̨��������
	facidx = 11,
}
TaskList[4][186] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4185},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_259", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400186,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,187},	-- ���͸���̨��������
	facidx = 12,
}
TaskList[4][187] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4186},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_260", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400187,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,188},	-- ���͸���̨��������
	facidx = 13,
}
TaskList[4][188] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4187},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_261", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400188,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,189},	-- ���͸���̨��������
	facidx = 14,
}
TaskList[4][189] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4188},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_259", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400189,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,190},	-- ���͸���̨��������
	facidx = 15,
}
TaskList[4][190] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4189},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_260", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400190,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,191},	-- ���͸���̨��������
	facidx = 16,
}
TaskList[4][191] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4190},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_261", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400191,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,192},	-- ���͸���̨��������
	facidx = 17,
}
TaskList[4][192] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4191},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_259", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400192,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,193},	-- ���͸���̨��������
	facidx = 18,
}
TaskList[4][193] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4192},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_260", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400193,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,194},	-- ���͸���̨��������
	facidx = 19,
}
TaskList[4][194] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	LinkEnd = 1,						--���������
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4193},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_261", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 40000,
		[3] = {{749,1,1},{682,1,1}},
	},	    
	StoryID = 400194,			-- �ύ�������ID
	QuickClear = 5,
	facidx = 20,
}



--����ճ�
TaskList[4][111] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		faction = 1,
		level = {45,49},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_255", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400111,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,112},	-- ���͸���̨��������
	facidx = 1,
}
TaskList[4][112] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4111},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_256", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400112,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,113},	-- ���͸���̨��������
	facidx = 2,
}
TaskList[4][113] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4112},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_257", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400113,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,114},	-- ���͸���̨��������
	facidx = 3,
}
TaskList[4][114] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4113},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_257", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400114,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,115},	-- ���͸���̨��������
	facidx = 4,
}
TaskList[4][115] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4114},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_258", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400115,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,200},	-- ���͸���̨��������
	facidx = 5,
}
TaskList[4][200] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4115},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_255", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400200,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,201},	-- ���͸���̨��������
	facidx = 6,
}
TaskList[4][201] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4200},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_256", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400201,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,202},	-- ���͸���̨��������
	facidx = 7,
}
TaskList[4][202] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4201},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_257", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400202,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,203},	-- ���͸���̨��������
	facidx = 8,
}
TaskList[4][203] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4202},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_257", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400203,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,204},	-- ���͸���̨��������
	facidx = 9,
}
TaskList[4][204] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4203},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_258", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400204,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,205},	-- ���͸���̨��������
	facidx = 10,
}
TaskList[4][205] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4204},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_255", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400205,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,206},	-- ���͸���̨��������
	facidx = 11,
}
TaskList[4][206] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4205},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_256", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400206,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,207},	-- ���͸���̨��������
	facidx = 12,
}
TaskList[4][207] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4206},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_257", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400207,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,208},	-- ���͸���̨��������
	facidx = 13,
}
TaskList[4][208] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4207},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_257", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400208,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,209},	-- ���͸���̨��������
	facidx = 14,
}
TaskList[4][209] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4208},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_258", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400209,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,210},	-- ���͸���̨��������
	facidx = 15,
}
TaskList[4][210] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4209},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_255", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400210,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,211},	-- ���͸���̨��������
	facidx = 16,
}
TaskList[4][211] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4210},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_256", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400211,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,212},	-- ���͸���̨��������
	facidx = 17,
}
TaskList[4][212] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4211},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_257", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400212,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,213},	-- ���͸���̨��������
	facidx = 18,
}
TaskList[4][213] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4212},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_257", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400213,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,214},	-- ���͸���̨��������
	facidx = 19,
}
TaskList[4][214] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	LinkEnd = 1,						--���������
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4213},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_258", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 50000,
		[3] = {{749,1,1},{682,1,1}},
	},	    
	StoryID = 400214,			-- �ύ�������ID
	QuickClear = 5,
	facidx = 20,
}



--����ճ�
TaskList[4][116] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		faction = 1,
		level = {50,59},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_262", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400116,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,117},	-- ���͸���̨��������
	facidx = 1,
}
TaskList[4][117] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4116},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_263", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400117,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,118},	-- ���͸���̨��������
	facidx = 2,
}
TaskList[4][118] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4117},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_264", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400118,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,119},	-- ���͸���̨��������
	facidx = 3,
}
TaskList[4][119] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4118},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_265", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400119,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,120},	-- ���͸���̨��������
	facidx = 4,
}
TaskList[4][120] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4119},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_265", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400120,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,220},	-- ���͸���̨��������
	facidx = 5,
}
TaskList[4][220] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4120},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_262", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400220,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,221},	-- ���͸���̨��������
	facidx = 6,
}
TaskList[4][221] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4220},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_263", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400221,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,222},	-- ���͸���̨��������
	facidx = 7,
}
TaskList[4][222] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4221},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_264", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400222,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,223},	-- ���͸���̨��������
	facidx = 8,
}
TaskList[4][223] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4222},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_265", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400223,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,224},	-- ���͸���̨��������
	facidx = 9,
}
TaskList[4][224] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4223},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_265", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400224,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,225},	-- ���͸���̨��������
	facidx = 10,
}
TaskList[4][225] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4224},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_262", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400225,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,226},	-- ���͸���̨��������
	facidx = 11,
}
TaskList[4][226] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4225},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_263", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400226,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,227},	-- ���͸���̨��������
	facidx = 12,
}
TaskList[4][227] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4226},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_264", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400227,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,228},	-- ���͸���̨��������
	facidx = 13,
}
TaskList[4][228] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4227},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_265", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400228,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,229},	-- ���͸���̨��������
	facidx = 14,
}
TaskList[4][229] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4228},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_265", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400229,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,230},	-- ���͸���̨��������
	facidx = 15,
}
TaskList[4][230] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4229},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_262", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400230,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,231},	-- ���͸���̨��������
	facidx = 16,
}
TaskList[4][231] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4230},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_263", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400231,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,232},	-- ���͸���̨��������
	facidx = 17,
}
TaskList[4][232] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4231},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_264", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400232,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,233},	-- ���͸���̨��������
	facidx = 18,
}
TaskList[4][233] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4232},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_265", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400233,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,234},	-- ���͸���̨��������
	facidx = 19,
}
TaskList[4][234] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	LinkEnd = 1,						--���������
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4233},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_265", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 80000,
		[3] = {{749,1,1},{682,1,1}},
	},	    
	StoryID = 400234,			-- �ύ�������ID
	QuickClear = 5,
	facidx = 20,
}


--����ճ�
TaskList[4][121] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		faction = 1,
		level = {60,120},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400121,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,122},	-- ���͸���̨��������
	facidx = 1,
}
TaskList[4][122] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4121},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400122,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,123},	-- ���͸���̨��������
	facidx = 2,
}
TaskList[4][123] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4122},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_267", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400123,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,124},	-- ���͸���̨��������
	facidx = 3,
}
TaskList[4][124] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4123},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_268", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400124,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,125},	-- ���͸���̨��������
	facidx = 4,
}
TaskList[4][125] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4124},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_269", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400125,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,240},	-- ���͸���̨��������
	facidx = 5,
}
TaskList[4][240] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4125},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400240,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,241},	-- ���͸���̨��������
	facidx = 6,
}
TaskList[4][241] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4240},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400241,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,242},	-- ���͸���̨��������
	facidx = 7,
}
TaskList[4][242] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4241},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_267", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400242,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,243},	-- ���͸���̨��������
	facidx = 8,
}
TaskList[4][243] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4242},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_268", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400243,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,244},	-- ���͸���̨��������
	facidx = 9,
}
TaskList[4][244] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4243},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_269", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400244,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,245},	-- ���͸���̨��������
	facidx = 10,
}
TaskList[4][245] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4244},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400245,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,246},	-- ���͸���̨��������
	facidx = 11,
}
TaskList[4][246] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4245},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400246,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,247},	-- ���͸���̨��������
	facidx = 12,
}
TaskList[4][247] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4246},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_267", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400247,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,248},	-- ���͸���̨��������
	facidx = 13,
}
TaskList[4][248] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4247},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_268", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400248,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,249},	-- ���͸���̨��������
	facidx = 14,
}
TaskList[4][249] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4248},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_269", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400249,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,250},	-- ���͸���̨��������
	facidx = 15,
}
TaskList[4][250] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4249},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400250,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,251},	-- ���͸���̨��������
	facidx = 16,
}
TaskList[4][251] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4250},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400251,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,252},	-- ���͸���̨��������
	facidx = 17,
}
TaskList[4][252] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4251},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_267", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400252,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,253},	-- ���͸���̨��������
	facidx = 18,
}
TaskList[4][253] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4252},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_268", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400253,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,254},	-- ���͸���̨��������
	facidx = 19,
}
TaskList[4][254] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	LinkEnd = 1,						--���������
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4253},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_269", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{749,1,1},{682,1,1}},
	},	    
	StoryID = 400254,			-- �ύ�������ID
	QuickClear = 5,
	facidx = 20,
}


--[[
--����ճ�
TaskList[4][121] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		faction = 1,
		level = {60,100},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400121,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,122},	-- ���͸���̨��������
	facidx = 1,
}
TaskList[4][122] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4121},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400122,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,123},	-- ���͸���̨��������
	facidx = 2,
}
TaskList[4][123] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4122},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_267", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400123,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,124},	-- ���͸���̨��������
	facidx = 3,
}
TaskList[4][124] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4123},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_268", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400124,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,125},	-- ���͸���̨��������
	facidx = 4,
}
TaskList[4][125] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4124},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_269", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400125,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,240},	-- ���͸���̨��������
	facidx = 5,
}
]]--

TaskList[4][240] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4125},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400240,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,241},	-- ���͸���̨��������
	facidx = 6,
}
TaskList[4][241] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4240},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400241,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,242},	-- ���͸���̨��������
	facidx = 7,
}
TaskList[4][242] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4241},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_267", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400242,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,243},	-- ���͸���̨��������
	facidx = 8,
}
TaskList[4][243] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4242},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_268", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400243,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,244},	-- ���͸���̨��������
	facidx = 9,
}
TaskList[4][244] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4243},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_269", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400244,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,245},	-- ���͸���̨��������
	facidx = 10,
}
TaskList[4][245] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4244},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400245,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,246},	-- ���͸���̨��������
	facidx = 11,
}
TaskList[4][246] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4245},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400246,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,247},	-- ���͸���̨��������
	facidx = 12,
}
TaskList[4][247] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4246},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_267", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400247,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,248},	-- ���͸���̨��������
	facidx = 13,
}
TaskList[4][248] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4247},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_268", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400248,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,249},	-- ���͸���̨��������
	facidx = 14,
}
TaskList[4][249] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4248},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_269", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400249,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,250},	-- ���͸���̨��������
	facidx = 15,
}
TaskList[4][250] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4249},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400250,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,251},	-- ���͸���̨��������
	facidx = 16,
}
TaskList[4][251] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4250},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_266", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400251,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,252},	-- ���͸���̨��������
	facidx = 17,
}
TaskList[4][252] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4251},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_267", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400252,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,253},	-- ���͸���̨��������
	facidx = 18,
}
TaskList[4][253] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4252},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_268", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{682,1,1}},
	},	    
	StoryID = 400253,			-- �ύ�������ID
	QuickClear = 5,
	task = {4,254},	-- ���͸���̨��������
	facidx = 19,
}
TaskList[4][254] = 
{	
	AcceptNPC = 40,						-- ��������NPC
	SubmitNPC = 40,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	LinkEnd = 1,						--���������
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4253},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "G_269", 20 },
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 100000,
		[3] = {{749,1,1},{682,1,1}},
	},	    
	StoryID = 400254,			-- �ύ�������ID
	QuickClear = 5,
	facidx = 20,
}











--�����ճ�
TaskList[4][150] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 38,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		vip = 1, 
		level = 999,
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{641,5}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 500000,
	},	    
	StoryID = 400150,			-- �ύ�������ID
	task = {4,151},	-- ���͸���̨��������
}
TaskList[4][151] = 
{	
	AcceptNPC = 38,						-- ��������NPC
	SubmitNPC = 38,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4150},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{641,10}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 800000,
	},	    
	StoryID = 400151,			-- �ύ�������ID
	task = {4,152},	-- ���͸���̨��������
}
TaskList[4][152] = 
{	
	AcceptNPC = 38,						-- ��������NPC
	SubmitNPC = 38,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4151},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{641,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1500000,
	},	    
	StoryID = 400152,			-- �ύ�������ID
}

--����ճ�
TaskList[4][900] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 49,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		level = 50,
	},
	CompleteCondition = 			-- ����������������
	{
		eGetWW = 20,
	},
	CompleteAwards = 					-- ���������
	{
		[14] = 1000,
		[3] = {{683,1,1}},
	},	    
	StoryID = 400900,			-- �ύ�������ID
}



--�����ճ�
TaskList[4][950] = 
{	
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 38,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		vip = 1, 
		level = 35,
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{641,5}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 500000,
	},	    
	StoryID = 400950,			-- �ύ�������ID
	task = {4,951},	-- ���͸���̨��������
}
TaskList[4][951] = 
{	
	AcceptNPC = 38,						-- ��������NPC
	SubmitNPC = 38,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4950},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{641,10}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 800000,
	},	    
	StoryID = 400951,			-- �ύ�������ID
	task = {4,952},	-- ���͸���̨��������
}
TaskList[4][952] = 
{	
	AcceptNPC = 38,						-- ��������NPC
	SubmitNPC = 38,						-- �ύ����NPC
	NoDrop = 1,							-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		completed={4951},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{641,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1500000,
	},	    
	StoryID = 400952,			-- �ύ�������ID
}

--���ͺ�����

TaskList[4][999] = 
{
    
	TaskName = "���ͺ�����",
	AcceptNPC = 53,
	SubmitNPC = 210,
	nocancel=0,
	TaskInfo = "�뽫��Ů���͵�������ң��·;ңԶ��������һ·����������ɹ��ʡ�",
	HelpInfo = "ÿ��^03^3�Σ�^019:30~20:00^3���ͣ��ɻ�^01.5��^3���档",
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
--�_Զ���ż� ( 1 - 100 )
TaskList[6][1] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {40,45},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
		[3] = {{627,10,0}},
		[12] = 500,
	},
	StoryID = 600001,
}
TaskList[6][2] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {40,45},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
		[3] = {{627,20,1}},
		[12] = 500,
	},
	StoryID = 600002,
}
TaskList[6][3] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {40,45},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
		[3] = {{626,10,0}},
		[12] = 500,
	},
	StoryID = 600003,
}
TaskList[6][4] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {40,45},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 200000,
		[3] = {{626,20,1}},
		[12] = 500,
	},
	StoryID = 600004,
}


TaskList[6][6] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {46,50},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[3] = {{627,12,0}},
		[12] = 550,
	},
	StoryID = 600006,
}
TaskList[6][7] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {46,50},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[3] = {{627,25,1}},
		[12] = 550,
	},
	StoryID = 600007,
}
TaskList[6][8] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {46,50},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[3] = {{626,12,0}},
		[12] = 550,
	},
	StoryID = 600008,
}
TaskList[6][9] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {46,50},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 250000,
		[3] = {{626,25,1}},
		[12] = 550,
	},
	StoryID = 600009,
}

TaskList[6][11] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {51,55},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 275000,
		[3] = {{627,15,0}},
		[12] = 600,
	},
	StoryID = 600011,
}
TaskList[6][12] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {51,55},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 275000,
		[3] = {{627,30,1}},
		[12] = 600,
	},
	StoryID = 600012,
}
TaskList[6][13] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		 -- level = {51,55},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 275000,
		[3] = {{626,15,0}},
		[12] = 600,
	},
	StoryID = 600013,
}
TaskList[6][14] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		 -- level = {51,55},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 275000,
		[3] = {{626,30,1}},
		[12] = 600,
	},
	StoryID = 600014,
}


TaskList[6][16] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {56,60},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[3] = {{627,18,0}},
		[12] = 650,
	},
	StoryID = 600016,
}
TaskList[6][17] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {56,60},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[3] = {{627,35,1}},
		[12] = 650,
	},
	StoryID = 600017,
}
TaskList[6][18] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		 -- level = {56,60},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[3] = {{626,18,0}},
		[12] = 650,
	},
	StoryID = 600018,
}
TaskList[6][19] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {56,60},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 300000,
		[3] = {{626,35,1}},
		[12] = 650,
	},
	StoryID = 600019,
}

TaskList[6][21] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {61,65},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 330000,
		[3] = {{627,20,0}},
		[12] = 700,
	},
	StoryID = 600021,
}
TaskList[6][22] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {61,65},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 330000,
		[3] = {{627,40,1}},
		[12] = 700,
	},
	StoryID = 600022,
}
TaskList[6][23] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {61,65},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 330000,
		[3] = {{626,20,0}},
		[12] = 700,
	},
	StoryID = 600023,
}
TaskList[6][24] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {61,65},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 330000,
		[3] = {{626,40,1}},
		[12] = 700,
	},
	StoryID = 600024,
}


TaskList[6][26] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 360000,
		[3] = {{627,25,0}},
		[12] = 800,
	},
	StoryID = 600026,
}
TaskList[6][27] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 360000,
		[3] = {{627,45,1}},
		[12] = 800,
	},
	StoryID = 600027,
}
TaskList[6][28] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		  -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 360000,
		[3] = {{626,25,0}},
		[12] = 800,
	},
	StoryID = 600028,
}
TaskList[6][29] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 360000,
		[3] = {{626,45,1}},
		[12] = 800,
	},
	StoryID = 600029,
}

TaskList[6][31] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 650000,
		[3] = {{627,25,0}},
		[12] = 900,
	},
	StoryID = 600026,
}
TaskList[6][32] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 650000,
		[3] = {{627,45,1}},
		[12] = 900,
	},
	StoryID = 600027,
}
TaskList[6][33] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		  -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 650000,
		[3] = {{626,25,0}},
		[12] = 900,
	},
	StoryID = 600028,
}
TaskList[6][34] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 650000,
		[3] = {{626,45,1}},
		[12] = 900,
	},
	StoryID = 600029,
}

TaskList[6][36] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 880000,
		[3] = {{627,25,0}},
		[12] = 1000,
	},
	StoryID = 600026,
}
TaskList[6][37] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 880000,
		[3] = {{627,45,1}},
		[12] = 1000,
	},
	StoryID = 600027,
}
TaskList[6][38] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		  -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 880000,
		[3] = {{626,25,0}},
		[12] = 1000,
	},
	StoryID = 600028,
}
TaskList[6][39] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 880000,
		[3] = {{626,45,1}},
		[12] = 1000,
	},
	StoryID = 600029,
}

TaskList[6][41] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		[3] = {{627,25,0}},
		[12] = 1000,
	},
	StoryID = 600026,
}
TaskList[6][42] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		[3] = {{627,45,1}},
		[12] = 1000,
	},
	StoryID = 600027,
}
TaskList[6][43] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		  -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		[3] = {{626,25,0}},
		[12] = 1000,
	},
	StoryID = 600028,
}
TaskList[6][44] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		[3] = {{626,45,1}},
		[12] = 1000,
	},
	StoryID = 600029,
}

TaskList[6][46] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		[3] = {{627,25,0}},
		[12] = 1000,
	},
	StoryID = 600026,
}
TaskList[6][47] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		[3] = {{627,45,1}},
		[12] = 1000,
	},
	StoryID = 600027,
}
TaskList[6][48] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		  -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		[3] = {{626,25,0}},
		[12] = 1000,
	},
	StoryID = 600028,
}
TaskList[6][49] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		[3] = {{626,45,1}},
		[12] = 1000,
	},
	StoryID = 600029,
}

TaskList[6][51] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		[3] = {{627,25,0}},
		[12] = 1000,
	},
	StoryID = 600026,
}
TaskList[6][52] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		[3] = {{627,45,1}},
		[12] = 1000,
	},
	StoryID = 600027,
}
TaskList[6][53] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		  -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		[3] = {{626,25,0}},
		[12] = 1000,
	},
	StoryID = 600028,
}
TaskList[6][54] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		[3] = {{626,45,1}},
		[12] = 1000,
	},
	StoryID = 600029,
}

TaskList[6][56] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		-- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_121", 30},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		[3] = {{627,25,0}},
		[12] = 1000,
	},
	StoryID = 600026,
}
TaskList[6][57] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		kill = { "M_122", 10},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		[3] = {{627,45,1}},
		[12] = 1000,
	},
	StoryID = 600027,
}
TaskList[6][58] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		  -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10008,20}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		[3] = {{626,25,0}},
		[12] = 1000,
	},
	StoryID = 600028,
}
TaskList[6][59] = 
{
	AcceptNPC = 0,						-- ��������NPC
	SubmitNPC = 55,						-- �ύ����NPC
	--NoDrop = 1,						-- ���ܷ���		
	
	AcceptCondition = 			-- ����˽�����������
	{
		 -- level = {66,100},
	},
	CompleteCondition = 			-- ����������������
	{
		items = {{10009,10}},
	},
	CompleteAwards = 					-- ���������
	{
		[2] = 1000000,
		[3] = {{626,45,1}},
		[12] = 1000,
	},
	StoryID = 600029,
}