--[[
	file:	��������
	desc:
	refix:	done by csj
Notice:
	�������������֧�����и������ͣ�
	1��֧�ֶ�̬�赲����
	2��֧�ָ�����ʼ�ͽ���ʱ�����Զ��庯��������
	3��֧�ֻ��ؿ���ǰ���������¼������¼����ͣ�1��������� 2����̬�赲�Ƿ���Ч 3�������Ƿ�ɹ��� 4�������Ƿ�ɿ��� 5�����鴥�� 6���Զ��庯����
	4��֧�ֶ����������ͣ�1���¼������ת�� 2���˺������� 3����̬���壩
	5��֧�ֶ��ֹ���������� ��1���¼����� 2����ʱˢ�� 3����Ҵ�����
	6����ɽ�����1���������ǽ������� 2����¼���������� 3�����˸���׷�� 4�����س齱 5�����ؿ����䣩
	7����ӹ���1����¼��ǰ���������Ϣ����������Χ��ң�
	8��֧��ɨ��
	9�������������͸���㣬��ֱ���˳�����
	10��������߱���������Ϣֱ������������ߣ���Լ3����ʱ��
	11��������ʱ��
--]]

--[[
����ID����˵��:
	[1][1] ~ [1][999] ���߸���
	[2][1] ~ [2][999] ���˸���
	[3][1] ~ [3][999] ��ʯ���� 
	[4][1] ~ [4][999] ��������
	[5][1] ~ [5][999] ����������()
	[6][1] ~ [6][999] ��Ǯ����
	[7][1] ~ [7][999] ��ͨ����
	[8][1] ~ [8][999] Ӣ�۸���
	[9][1] ~ [9][999] ���鸱��
	[10][1] ~ [10][999] ���Ƹ���()
	[11][1] ~ [11][999] �ڱ�����
	[12][1] ~ [12][999] VIP����
	[13][1] ~ [13][999] ����ֵ����
	[14][1] ~ [14][999] ����װ������
	[15][1] ~ [15][999] ���޸���
	[16][1] ~ [16][999] װ�����Ǹ���
	[17][1] ~ [17][999] Ԫ�񸱱�
	[18][1] ~ [18][999] ������ս����
	[19][1] - [19][999] �����������
	[20][1] - [20][999] �����������(������)
	[21][1] - [21][999] ������������
	[22][1] - [22][999] ������������
	[23][1] - [23][999] һ�ﵱǧ����
	[24][1] - [24][999] ����󸱱�
	
	[999][1] ~ [999][999]  ����ʹ�ø���

����˵��:
	1��controlId  ���������ID��������ʹ�ñ�Ŷ�Ϊ  100~999
	2��TrapID [< 10000] ��ͨ���� [> 10000] �˺�������
]]--

-- �����¼���5������ ��1���������� 2������ 3������� 4����ʱ��, 5��������ʧ��
-- �¼�����
-- controlId  ���������ID    ������ʹ�ñ�Ŷ�Ϊ    100~999
-- IdleTime   ��������֡

--RelivePos = {1,16,88,use=1},-- �����,Ϊ������ǰ����,������use=1ʱ��������Ч

--[[
	��������
	CSAwards = {					-- �������ؽ���
		Exp = 100000,					-- ����
		Money = 10000,				-- ͭǮ
		sy=1000,        --��Դ
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 627, CountList = { 5, 10 }, IsBind = 1 },--���ǵ�
			{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 5, 10 }, IsBind = 1 },--�ʺ�ʯ
		},
		SpecialProc = {---���⽱���ص�����OnSpAward_1001
		},
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=120,
				award={--ͨ�ý�������
					[1]=100,
					[3]={{413,1,1},{413,1,1}},
					},
				},
			[2]={--2��
				_time=100,
				award={--ͨ�ý�������
					[1]=100,
					[3]={{413,1,1},{413,1,1}},
					},
				},	
			[3]={--3��
				_time=50,
				award={--ͨ�ý�������
					[1]=100,
					[3]={{413,1,1},{413,1,1}},
					},
				},	
			
			},
		first={--�״�--ͨ�ý�������
			[1]=100,
			[3]={{413,1,1},{413,1,1}},
			},
		equip= {
			count	-- [1 ~ 99] ����Ӧ����װ�� [{[1] = 2000,[2] = 10000,...}] �������(���뱣֤ÿ���������и���)
			eqLV 	-- [nil] ������ҵȼ�����Ӧװ��(����������ȡ) [20 ~ 100] װ���ȼ� ÿ10��һ������, 
			quality -- [1 ~ 5] ����ӦƷ��װ�� [{[1] = 2000,[2] = 10000,...}] ���Ʒ��(���뱣֤ÿ��Ʒ�ʶ��и���)
			school	-- [nil] �������ְҵ��װ�� [1] ���ְҵ(ƽ������ 1/3)
			eqType 	-- [nil] �����λ(ƽ������ 1/9) [1 ~ 9] ����Ӧ��λװ�� [{1,5}] ��1~5֮�䲿λ���
			sex  	-- [nil] ��������Ա��װ�� [1] ����Ա�(������) 
						Ҳ����˵���sex==nil�� eqType����ָ��Ϊ1 or 2(��ֻ���������Ч)�� ������Ч
			IsBind 	-- [0] ���� [1] ��
		},
		giveGoods={
			[1] = {{itemID,itemNum,bind},...},  	-- �������κ���Ϣ ����������
			[2] = {									-- װ����(����ְҵ���Ա�)
					[10] = {itemID,itemNum,bind},	-- ������(Ů)
					[11] = {itemID,itemNum,bind},	-- ������(��)
					[20] = {itemID,itemNum,bind},	-- ����(Ů)
					[21] = {itemID,itemNum,bind},	-- ����(��)
					[30] = {itemID,itemNum,bind},	-- ����(Ů)
					[31] = {itemID,itemNum,bind},	-- ����(��)					
				},
			}
			[3] = {									-- װ����(ֻ����ְҵ)
				[1] = {{itemID,itemNum,bind},...},	-- ������
				[2] = {{itemID,itemNum,bind},...},	-- ����
				[3] = {{itemID,itemNum,bind},...},	-- ����
		},
	},

]]



--------------------------------------------------------------------------
--include:

--------------------------------------------------------------------------
-- data:

EventTypeTb = {
	MonRefresh = 1,			-- �������
	MonAttack = 2,			-- ����ʱ��ɹ���
	DynBlock = 3,			-- ��̬�赲�Ƿ���Ч
	Mechanism = 4,			-- �����Ƿ�ɿ���
	TrapValid = 5,			-- ������Ƿ���
	Story = 6,				-- ��������
	GiveItems = 7,			-- ����Ʒ
	TimerTrigger = 8,		-- ������ʱ��
	JumpMap = 9,			-- ��ת��ͼ	
	
	Failed = 97,			-- ����ʧ��
	Completion = 98,		-- �������
	UserDefined = 99,		-- �Զ����¼�����
}

-- ����׷������
TraceTypeTb = {
	MonDeads = 1,			-- ������������		
	MecOpens = 2,			-- ���ؿ�������
	MecState = 3,			-- ����״̬�ı�
	BlockState = 4,			-- �赲״̬�ı�
	TrapState = 5,			-- ����״̬�ı�
	StoryBegin = 6,			-- ��������
	MonControl = 7,			-- ���ﲨ��(������������)
	JumpMap = 8,			-- ��ת��ͼ(�����µ�ͼ�ĳ�ʼ״̬)
	LightState = 9,			-- �ȹ�Ȧ
	ClrTimer = 10,			-- ����ʱ��
}
local EventTypeTb = EventTypeTb
--��������
FBConfig = {} --��Ҫ�޸Ĵ˴�

-- ʾ������
FBConfig[1] = {
	FBDescInfo = {			-- ����������Ϣ
		FBName = '',		-- ��������
		ShowLevel = 1,		-- �ȼ�������ʾ������
		Awards = {			-- ����
		},
	},	
}

-- FBConfig[1][1] = {
	-- FBName = '�����ᱦ',	-- ��������	
	-- VictoryCondition = '��ɱBOSS',	--ʤ����������
	-- ICON= 2021,			-- Сͼ�꣨����
	-- MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	-- RecommendLV = 20,		-- �Ƽ��ȼ�
	-- BackPos = {3,103,201},		

	-- EventList = {
	    -- MonDeads = {					-- �������������¼��б�
			-- [1005] = { step = 3, num = 1, EventTb = { {EventTypeTb.Completion}, }},
			-- [1001] = { step = 1, num = 2, EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			-- [1002] = { step = 2, num = 2, EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			
			
		-- },	
		
	-- },
	
	-- MapList = {				-- ��ͼ�б�
	
		-- [1] = {
			-- MapID = 1016, 		-- ��ͼ���	
										
			-- MonsterList = {				-- �����б�
				-- [101] = {
					-- { monsterId = 47, BRMONSTER = 1, centerX = 27 , centerY = 45 , BRArea = 2 , BRNumber =2 , deadbody = 6 , deadScript = 1001,  },	
				-- },
				-- [102] = {
					-- { monsterId = 47, BRMONSTER = 1, centerX = 26 , centerY = 22 , BRArea = 2 , BRNumber =2 , deadbody = 6 , deadScript = 1002,  },
				-- },	
				-- -- [103] = {
					-- -- { monsterId = 47, BRMONSTER = 1, centerX = 2 , centerY = 40 , BRArea = 4 , BRNumber =3 , deadbody = 6 , deadScript = 1003,  },	
				-- -- },
				-- -- [104] = {
					-- -- { monsterId = 47, BRMONSTER = 1, centerX = 27 , centerY = 43 , BRArea = 4 , BRNumber =3 , deadbody = 6 , deadScript = 1004, },
				-- -- },
				-- [105] = {
					-- { monsterId = 48,  x = 12 , y = 23 , monAtt={[1] =850,},isboss=1 , deadbody = 6 , EventID = 1, eventScript = 1002,deadScript = 1005, },
				-- },
            -- },			
			-- DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲			
			-- EnterPos = {{x = 12, y = 44}},		-- �����
			-- RelivePos = {1,12,44},				-- �����
		-- },
	-- },		
	 -- CSAwards = {	
	  -- },
	-- NeedConditions = {				-- ������������
		-- nLevel = 1,					-- ����ȼ�����
		-- nMoney = 0,					-- ��Ҫ��������
		-- nItemList = {				-- ��Ҫ��Ʒ�б�����
			-- },
	-- },	
	

-- }


FBConfig[1][1] = {
	FBName = '�����ᱦ',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2021,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 1,		-- �Ƽ��ȼ�
	BackPos = {3,100,159},		

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			
			[1001] = { step = 1, num = 2, EventTb = {{EventTypeTb.MonRefresh,{1,102},},{EventTypeTb.UserDefined,{func = 'ud_1001_4'},},},},
			[1002] = { step = 2, num = 2, EventTb = {{EventTypeTb.MonRefresh,{1,103},},{EventTypeTb.UserDefined,{func = 'ud_1001_5'},},},},
			[1003] = { step = 3, num = 3, EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[1005] = { step = 4, num = 1, EventTb = { {EventTypeTb.Completion}, }},
			
		},	
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1016, 		-- ��ͼ���	
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 47, BRMONSTER = 1, centerX = 24 , centerY = 87 , BRArea = 2 , BRNumber =2 , deadbody = 6 , deadScript = 1001,  },	
				},
				[102] = {
					{ monsterId = 47, BRMONSTER = 1, centerX = 3 , centerY = 37 , BRArea = 2 , BRNumber =2 , deadbody = 6 , deadScript = 1002,  },
				},	
				[103] = {
					{ monsterId = 47, BRMONSTER = 1, centerX = 25 , centerY = 45 , BRArea = 2 , BRNumber =3 , deadbody = 6 , deadScript = 1003,  },	
				},
				-- [104] = {
					-- { monsterId = 47, BRMONSTER = 1, centerX = 27 , centerY = 43 , BRArea = 4 , BRNumber =3 , deadbody = 6 , deadScript = 1004, },
				-- },
				[105] = {
					{controlId = 100,IdleTime = 10, monsterId = 48,  x = 14 , y = 24 ,isboss=1 , deadbody = 6 , EventID = 1, eventScript = 1002,deadScript = 1005, },
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲						
			EnterPos = {{x = 14, y = 87}},		-- �����
			RelivePos = {3,100,159},				-- �����
		},
	},		
	 CSAwards = {	
	  },
	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	

}

FBConfig[1][2] = {
	FBName = '�����ջ�',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2005,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 20,		-- �Ƽ��ȼ�
	BackPos = {1,37,56},
	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1002] = { step = 1, num = 100, EventTb = {{EventTypeTb.TrapValid,{1,1001,1},},},},
			[1001] = { step = 3, num = 1, EventTb = {{EventTypeTb.Completion}, }},
		},	
		Traps = {						-- ����㴥���¼��б� ����ID��֤����Ψһ ����ֻ�ǵ�ͼΨһ
			[1001] = { step = 2,num = -1, EventTb = {{EventTypeTb.JumpMap, 2},{EventTypeTb.MonRefresh,{2,103}},{EventTypeTb.UserDefined,{func = 'ud_1002_1'},}, } },
		},
		
	},
	
	MapList = {				-- ��ͼ�б�
		[1] = {
			MapID = 1021, 		-- ��ͼ���				
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 19 , centerY = 16 , BRArea = 4 , BRNumber =5 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 22 , centerY = 16 , BRArea = 4 , BRNumber =5 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 25 , centerY = 16 , BRArea = 4 , BRNumber =5 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 28 , centerY = 16 , BRArea = 4 , BRNumber =5 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 31 , centerY = 16 , BRArea = 4 , BRNumber =5 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 34 , centerY = 16 , BRArea = 4 , BRNumber =5 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 37 , centerY = 16 , BRArea = 4 , BRNumber =5 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 40 , centerY = 16 , BRArea = 4 , BRNumber =5 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 43 , centerY = 16 , BRArea = 4 , BRNumber =5 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 46 , centerY = 16 , BRArea = 4 , BRNumber =5 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 49 , centerY = 16 , BRArea = 4 , BRNumber =6 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 52 , centerY = 16 , BRArea = 4 , BRNumber =6 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 55 , centerY = 16 , BRArea = 4 , BRNumber =6 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 58 , centerY = 16 , BRArea = 4 , BRNumber =6 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 61 , centerY = 16 , BRArea = 4 , BRNumber =6 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 64 , centerY = 16 , BRArea = 4 , BRNumber =6 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 67 , centerY = 16 , BRArea = 4 , BRNumber =6 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 70 , centerY = 16 , BRArea = 4 , BRNumber =6 ,deadScript =1002},
					{ monsterId = 97,level = 1 ,monAtt={[1] = 1,[3] = 50,[6] = 1},moveArea = 0, BRMONSTER = 1, deadbody = 6 , aiType = 1031 ,centerX = 73 , centerY = 16 , BRArea = 4 , BRNumber =6 ,deadScript =1002},
				},	
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			TrapPos = {					-- ������б�
				[1001] = {0,92,21,3}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			},				
			EnterPos = {{x = 13, y = 16}},		-- �����
			RelivePos = {1,13,16},				-- �����
		},
		[2] = {
		MapID = 1015, 		-- ��ͼ���		

			
										
			MonsterList = {				-- �����б�

				[103] = {
				    { monsterId = 6,  x = 14 , y = 77 , isboss=1 , deadbody = 6 , aiType = 3, deadScript = 1001, },	
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲			
			EnterPos = {{x = 29, y = 67}},		-- �����
			RelivePos = {1,29,67},				-- �����
		},
	},		
	 CSAwards = {	
	  },
	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	

}

FBConfig[1][3] = {
	FBName = '�ٹ�����',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2003,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 20,		-- �Ƽ��ȼ�
	BackPos = {1,55,27},
	--StoryID = 1000119,			-- ���븱����������ID ���¼������ľ��飬�ڸ��¼��б����ã�
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1004] = { step = 4, num = 1, EventTb = { {EventTypeTb.DynBlock,{1,1,0}}, } },
			[1005] = { step = 5, num = 1, EventTb = { {EventTypeTb.Completion}, } },
			[1001] = { step = 1, num = 3, EventTb = { {EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 3, EventTb = { {EventTypeTb.MonRefresh,{1,103},},},},
			[1003] = { step = 3, num = 5, EventTb = { {EventTypeTb.MonAttack,{1,{1},{aiType=1026}, },},},}
			
		},	
	},	
		
	
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1003, 		-- ��ͼ���					
			
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 13, BRMONSTER = 1, deadbody = 6 , centerX = 22 , centerY = 77 , BRArea = 5 , BRNumber =3 , deadScript = 1001 },
				},	
				[102] = {	
					{ monsterId = 13, BRMONSTER = 1, deadbody = 6 , centerX = 10 , centerY = 70 , BRArea = 5 , BRNumber =3 , deadScript = 1002 },
				},
				[103] = {
					{ monsterId = 14, BRMONSTER = 1, deadbody = 6 , centerX = 8 , centerY = 58 , BRArea = 5 , BRNumber = 5 , deadScript = 1003 },
                    { monsterId = 15, deadbody = 6 , x = 17 , y = 20 , isboss=1 , deadScript = 1005, EventID = 1, eventScript = 1001, },								    
				    { name = '֩����' , monsterId = 42,  monAtt={[1]=6,} ,x = 22 , y = 53 , aiType=0 , controlId = 1 , deadScript = 1004, },
				},
            },			
			DynamicsBlock = {1},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			--TrapPos = {					-- ������б�
				--[1001] = {1,21,49,3,3,{0,1,-10,}}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������	{[1]=�˺����ͣ�0 Ѫ�� 1 ŭ��;[2]=ֵ���ͣ� 0 ֵ 1 �ٷֱ�;[3]=��ֵ ����Ϊ�ӣ���Ϊ����;[4]=ǰ̨���ڱ���ʱ���õ�buffid}			
			--},			
			EnterPos = {{x = 16, y = 88}},		-- �����
			RelivePos = {1,16,88},				-- �����
		},
	},	
	
  CSAwards = {	
  },
	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
}

FBConfig[1][4] = {
    FBName = '����ҹ��',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2017,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 20,		-- �Ƽ��ȼ�
	BackPos = {8,65,134},
	--StoryID = 1000121,			-- ���븱����������ID ���¼������ľ��飬�ڸ��¼��б����ã�
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1006] = { step = 6, num = 1, EventTb = { {EventTypeTb.Completion}, } ,},
			[1002] = { step = 2, num = 1, EventTb = { {EventTypeTb.DynBlock,{1,1,0},}, } ,},
			[1001] = { step = 1, num = 6, EventTb = { {EventTypeTb.MonAttack,{1,{1},{aiType=1026} ,}, },},},
			--[1003] = { step = 3, num = 1, EventTb = { {EventTypeTb.MonRefresh,{1,102},},},},
			[1004] = { step = 4, num = 6, EventTb = { {EventTypeTb.MonRefresh,{1,103},},},},
			[1005] = { step = 5, num = 6, EventTb = { {EventTypeTb.Story,{1,1000122}}, {EventTypeTb.MonRefresh, {1,104},}, }, },
		},	
		MecOpens = {					-- ���ؿ��������¼��б�
			[500012] = { step = 3, num = 1,  EventTb = { {EventTypeTb.MonRefresh   ,{1,102}}, } },
		},
	
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1012, 		-- ��ͼ���		
            MecFlags = {[500004] = 1,[500012] = 1,},	-- ���س�ʼ״̬ 0 �����Կ��� 1 ���Կ���
			NPCList = {			-- ����NPC�б� ��������NPC					
				[500012] = {{26,20}},
			
			},
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 20, BRMONSTER = 1,  deadbody = 6 , centerX = 6 , centerY = 13 , BRArea = 3 , BRNumber =6 , deadScript=1001},
					{ controlId = 1 , name = 'ɺ��' , monAtt={[1]=6,} ,monsterId = 42,  imageID = 1149, headID = 1149,  x = 14 , y = 30 , aiType=0 , deadScript = 1002, },
					--{ name = '��������ͯ��' , monsterId = 42,  imageID = 1147, headID = 1147, level = 1 , x = 26 , y = 20 , aiType=2 , deadScript = 1003, },									
				},	
				[102] = {
					{ controlId = 100 , IdleTime = 10 ,monsterId = 20, x = 23 , y = 20 , deadbody = 6 , deadScript =1004},
					{ controlId = 101 , IdleTime = 10 ,monsterId = 20, x = 25 , y = 23 , deadbody = 6 , deadScript =1004},
					{ controlId = 102 , IdleTime = 10 ,monsterId = 20, x = 27 , y = 23 , deadbody = 6 , deadScript =1004},
					{ controlId = 103 , IdleTime = 10 ,monsterId = 20, x = 28 , y = 21 , deadbody = 6 , deadScript =1004},
					{ controlId = 104 , IdleTime = 10 ,monsterId = 20, x = 27 , y = 17 , deadbody = 6 , deadScript =1004},
					{ controlId = 105 , IdleTime = 10 ,monsterId = 20, x = 25 , y = 17 , deadbody = 6 , deadScript =1004},
				},	
				[103] = {
		   	    	{ monsterId = 21, BRMONSTER = 1,  deadbody = 6 , centerX = 21 , centerY = 63 , BRArea = 5 , BRNumber =6 , deadScript =1005},
				},
				[104] = {
					{ monsterId = 22,  x = 11 , y = 57 , isboss=1 , deadbody = 6 , deadScript = 1006  },								
			   },
			},			
			
			DynamicsBlock = {1},	-- ��̬�赲�б� 1 ���赲 0 ���赲			
			EnterPos = {{x = 16, y = 6}},		-- �����
			RelivePos = {1,16,6},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	
    CSAwards = {					-- �������ؽ���
		Exp = 15000,					-- ���� ÿ�վ����0.005
		Money = 10000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 10, CountList = { 10, 30 }, IsBind = 1 },
			
			{ Rate = { 1, 10000 }, ItemID = 602, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 600, CountList = { 1, 2 }, IsBind = 1 },
		},
		
		equip = {
			count = {[1] = 8000,[2] = 10000}, eqLV = 20, quality = {[1] = 10000,[2] = 0,[3] = 0,[4] = 0 },IsBind = 1,school =1 ,sex=1
		},
		
		
		--StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
 
 
 }
 

FBConfig[1][5] = {
	FBName = '��������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2019,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 20,		-- �Ƽ��ȼ�
	BackPos = {8,65,134},
	--StoryID = 1000123,			-- ���븱����������ID ���¼������ľ��飬�ڸ��¼��б����ã�
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 1, num = 5, },
			--[1002] = { num = 1, EventTb = { {EventTypeTb.MonRefresh,{1,102},},},},
			[1003] = { step = 3, num = 4, EventTb = { {EventTypeTb.MonRefresh,{1,103},},},},
			[1004] = { step = 4, num = 5, },
			--[1005] = { num = 1, EventTb = { {EventTypeTb.MonRefresh,{1,104},},},},
			[1006] = { step = 6, num = 4, },
			--[1007] = { num = 1, EventTb = { {EventTypeTb.MonRefresh,{1,105},},},},
			[1008] = { step = 8, num = 4, EventTb = { {EventTypeTb.MonRefresh,{1,106},},},},
			[1009] = { step = 9, num = 5, EventTb = { {EventTypeTb.MonRefresh,{1,107},},},},
			[1010] = { step = 10, num = 1, EventTb = { {EventTypeTb.Story,{1,1000108}},{EventTypeTb.Completion}, } ,},
		},	
		MecOpens = {					-- ���ؿ��������¼��б�
			[500009] = { step = 2, num = 1,  EventTb = { {EventTypeTb.MonRefresh   ,{1,102}}, } },
			[500011] = { step = 5, num = 1,  EventTb = { {EventTypeTb.MonRefresh   ,{1,104}}, } },
			[500010] = { step = 7, num = 1,  EventTb = { {EventTypeTb.MonRefresh   ,{1,105}}, } },
		},
		
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1011, 		-- ��ͼ���		
			MecFlags = {[500007] = 1,[500009] = 1,[500010] = 1,[500011] = 1,},	-- ���س�ʼ״̬ 0 �����Կ��� 1 ���Կ���
			NPCList = {			-- ����NPC�б� ��������NPC					
				[500009] = {{29,50}},
				[500010] = {{19,33}},
				[500011] = {{4,48}},
			
			},			
			
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 23, BRMONSTER = 1, centerX = 46 , centerY = 50 , BRArea = 5 , deadbody = 6 ,BRNumber = 5, deadScript = 1001, },
				},
				[102] = {
				    { controlId = 100,IdleTime = 10, monsterId = 24, x = 29 , y = 47 , deadbody = 6 , deadScript = 1003, },
					{ controlId = 101,IdleTime = 10, monsterId = 24, x = 26 , y = 50 , deadbody = 6 , deadScript = 1003, },
					{ controlId = 102,IdleTime = 10, monsterId = 24, x = 29 , y = 53 , deadbody = 6 , deadScript = 1003, },
					{ controlId = 103,IdleTime = 10, monsterId = 24, x = 31 , y = 50 , deadbody = 6 , deadScript = 1003, },
				},
				[103] = {
					{ monsterId = 23, BRMONSTER = 1, centerX = 11 , centerY = 55 , BRArea = 5 , deadbody = 6 ,BRNumber = 5, deadScript = 1004, },
				},
				[104] = {
					{ controlId = 104,IdleTime = 10, monsterId = 24, x = 4 , y = 44 , deadbody = 6 , deadScript = 1006, },
					{ controlId = 105,IdleTime = 10, monsterId = 24, x = 4 , y = 50 , deadbody = 6 , deadScript = 1006, },
					{ controlId = 106,IdleTime = 10, monsterId = 24, x = 2 , y = 47 , deadbody = 6 , deadScript = 1006, },
					{ controlId = 107,IdleTime = 10, monsterId = 24, x = 6 , y = 47 , deadbody = 6 , deadScript = 1006, },
				},
				[105] = {
					{ controlId = 108,IdleTime = 10, monsterId = 25, x = 19 , y = 30 , deadbody = 6 , deadScript = 1008, },
					{ controlId = 109,IdleTime = 10, monsterId = 25, x = 19 , y = 37 , deadbody = 6 , deadScript = 1008, },
					{ controlId = 110,IdleTime = 10, monsterId = 25, x = 17 , y = 34 , deadbody = 6 , deadScript = 1008, },
					{ controlId = 111,IdleTime = 10, monsterId = 25, x = 22, y = 34 , deadbody = 6 , deadScript = 1008, },
				},
				[106] = {
					{ monsterId = 26, BRMONSTER = 1, centerX = 35 , centerY = 22 , BRArea = 5 , deadbody = 6 , BRNumber = 5, deadScript = 1009, },
				},
				[107] = {
					{ controlId = 200,monsterId = 27,  x = 50 , y = 10 , isboss=1 , EventID = 1, eventScript = 1008,deadbody = 6 ,deadScript = 1010, },				    
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲	
			EnterPos = {{x = 57, y = 47}},		-- �����
			RelivePos = {1,57,47},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 20000,					-- ���� ÿ�վ����0.005
		Money = 15000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 11, CountList = { 10, 30 }, IsBind = 1 },
			
			{ Rate = { 1, 10000 }, ItemID = 602, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 600, CountList = { 1, 2 }, IsBind = 1 },
		},
		
		equip = {
			count = {[1] = 8000,[2] = 10000}, eqLV = 20, quality = {[1] = 10000,[2] = 0,[3] = 0,[4] = 0 },IsBind = 1,school =1 ,sex=1
		},
		
		
		--StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}

FBConfig[1][6] = {
    FBName = '��ȡ�ڵ�',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2013,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 20,		-- �Ƽ��ȼ�
	BackPos = {7,40,17},

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			--[1001] = { step = 1, num = 1, EventTb = { {EventTypeTb.MonRefresh   ,{1,102}}, } },
			[1002] = {  step = 1,num = 10, EventTb = { {EventTypeTb.MonRefresh   ,{1,103}}, } }, 
			[1003] = {  step = 2,num = 1, EventTb = { {EventTypeTb.DynBlock , {1,1,0}}, } },
			[1007] = {  step = 5,num = 1 ,EventTb = { {EventTypeTb.Completion}, }, },
			[1005] = {  step = 3,num = 20, EventTb = { {EventTypeTb.MonRefresh   ,{1,106}}, } }, 
			[1006] = {  step = 4,num = 20, EventTb = { {EventTypeTb.MonRefresh   ,{1,104}}, {EventTypeTb.UserDefined,{func = 'ud_1006_1',param = 1},},} }, 
		},	
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1004, 		-- ��ͼ���		
										
			MonsterList = {				-- �����б�
				[101] = {
				    --{ name = 'ʯ������' ,monsterId = 42, x = 29 , y = 32 ,  aiType = 2, imageID = 1145, headID = 1145, deadScript = 1001},
				    { monsterId = 31, BRMONSTER = 1, centerX = 29 , centerY = 11 , BRArea = 4 , deadbody = 6 , BRNumber = 20,  deadScript = 1005},
				    { controlId = 104,moveArea = 0 , IdleTime = 10 ,monsterId = 30, x = 33 , y = 35 ,  aiType = 3, deadbody = 6 , deadScript = 1002},
					{ controlId = 105,moveArea = 0 , IdleTime = 10 ,monsterId = 30, x = 32 , y = 34 ,  aiType = 3, deadbody = 6 , deadScript = 1002},
					{ controlId = 106,moveArea = 0 , IdleTime = 10 ,monsterId = 30, x = 31 , y = 33 ,  aiType = 3, deadbody = 6 , deadScript = 1002},
					{ controlId = 107,moveArea = 0 , IdleTime = 10 ,monsterId = 30, x = 30 , y = 32 ,  aiType = 3, deadbody = 6 , deadScript = 1002},
					{ controlId = 112,moveArea = 0 , IdleTime = 10 ,monsterId = 30, x = 29 , y = 31 ,  aiType = 3, deadbody = 6 , deadScript = 1002},
					{ controlId = 108,moveArea = 0 , IdleTime = 10 ,monsterId = 30, x = 32 , y = 36 ,  aiType = 3,  deadbody = 6 , deadScript = 1002},
					{ controlId = 109,moveArea = 0 , IdleTime = 10 ,monsterId = 30, x = 31 , y = 35 ,  aiType = 3,  deadbody = 6 , deadScript = 1002},
					{ controlId = 110,moveArea = 0 , IdleTime = 10 ,monsterId = 30, x = 30 , y = 34 ,  aiType = 3,  deadbody = 6 , deadScript = 1002},
					{ controlId = 111,moveArea = 0 , IdleTime = 10 ,monsterId = 30, x = 29 , y = 33 ,  aiType = 3,  deadbody = 6 , deadScript = 1002},
					{ controlId = 113,moveArea = 0 , IdleTime = 10 ,monsterId = 30, x = 28 , y = 32 ,  aiType = 3,  deadbody = 6 , deadScript = 1002},
				},	
				[103] = {	
                    { name = 'ʯ������' ,monsterId = 42, x = 34 , y = 27 ,  aiType = 2, imageID = 1145, headID = 1145, deadScript = 1003},			
                },				
				[104] = {	
                    { monsterId = 32,  x = 5 , y = 16 , isboss = 1 , aiType = 3, deadScript = 1007 , deadbody = 6 , searchArea = 8 },				
                },
				[106] = {
				    { monsterId = 31, BRMONSTER = 1, centerX = 9 , centerY = 22 , BRArea = 4 , deadbody = 6 , BRNumber = 20,  deadScript = 1006},
				},
			},			
			
			DynamicsBlock = {1},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 36, y = 39}},		-- �����
			RelivePos = {1,36,39},				-- �����
		},
	},		
	 CSAwards = {	
	  },
	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	 
 }
 
 FBConfig[1][7] = {
	FBName = 'Ѱ����¯',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2004,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 20,		-- �Ƽ��ȼ�
	BackPos = {7,40,17},
	--StoryID = 1000124,			-- ���븱����������ID ���¼������ľ��飬�ڸ��¼��б����ã�
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			--[1001] = { step = 1, num = 1, EventTb = { {EventTypeTb.MonRefresh   ,{1,102}}, } },
			[1002] = { step = 2, num = 8, EventTb = { {EventTypeTb.MonRefresh   ,{1,103}}, } },
			[1003] = { step = 3, num = 6, EventTb = { {EventTypeTb.Mechanism   ,{1,500016,1}}, } },
			--[1004] = { step = 4, num = 1, EventTb = { {EventTypeTb.MonRefresh   ,{1,105}}, } },
			[1005] = { step = 5, num = 6, EventTb = { {EventTypeTb.MonRefresh   ,{1,106}}, } },
			[1006] = { step = 6, num = 6, EventTb = { {EventTypeTb.MonRefresh   ,{1,107}}, } },
			[1007] = { step = 7, num = 1, EventTb = { {EventTypeTb.DynBlock , {1,1,0}}, } },
			[1008] = { step = 9, num = 1, EventTb = { {EventTypeTb.Story,{1,1000112}},{EventTypeTb.Completion}, }, },
		},	
		MecOpens = {					-- ���ؿ��������¼��б�
			[500001] = { step = 8, num = 1,  EventTb = { {EventTypeTb.Story,{1,1000111}},{EventTypeTb.MonRefresh   ,{1,108}}, } },
			[500015] = { step = 1, num = 1,  EventTb = { {EventTypeTb.MonRefresh   ,{1,102}}, } },
			[500016] = { step = 4, num = 1,  EventTb = { {EventTypeTb.MonRefresh   ,{1,105}}, } },
		},
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1005, 		-- ��ͼ���	
			MecFlags = {[500001] = 1,[500015] = 1,[500016] = 0,},	-- ���س�ʼ״̬ 0 �����Կ��� 1 ���Կ���
			NPCList = {			-- ����NPC�б� ��������NPC					
				[500001] = {{40,38}},
				[500015] = {{38,17}},
				[500016] = {{4,20}},
			},			
			
										
			MonsterList = {				-- �����б�
				--[101] = {
				--    { name = 'ʯ������' ,monsterId = 42, x = 38 , y = 17 ,  aiType = 2, imageID = 1146, headID = 1146, deadScript = 1001},
				--},
				[102] = {
				    { monsterId = 33, x = 39 , y = 12 ,  aiType = 3,  deadbody = 6 , controlId = 100,IdleTime = 10,deadScript = 1002},
					{ monsterId = 33, x = 36 , y = 12 ,  aiType = 3,  deadbody = 6 , controlId = 101,IdleTime = 10,deadScript = 1002},
					{ monsterId = 33, x = 33 , y = 15 ,  aiType = 3,  deadbody = 6 , controlId = 102,IdleTime = 10,deadScript = 1002},
					{ monsterId = 33, x = 33 , y = 20 ,  aiType = 3,  deadbody = 6 , controlId = 103,IdleTime = 10,deadScript = 1002},
					{ monsterId = 33, x = 36 , y = 22 ,  aiType = 3,  deadbody = 6 , controlId = 104,IdleTime = 10,deadScript = 1002},
					{ monsterId = 33, x = 39 , y = 22 ,  aiType = 3,  deadbody = 6 , controlId = 105,IdleTime = 10,deadScript = 1002},
					{ monsterId = 33, x = 42 , y = 20 ,  aiType = 3,  deadbody = 6 , controlId = 106,IdleTime = 10,deadScript = 1002},
					{ monsterId = 33, x = 42 , y = 15 ,  aiType = 3,  deadbody = 6 , controlId = 107,IdleTime = 10,deadScript = 1002},
				},
				[103] = {
					{ monsterId = 34, BRMONSTER = 1, deadbody = 6 ,  centerX = 23 , centerY = 8 , BRArea = 3 , BRNumber =3 , aiType = 3, searchArea = 8 ,deadScript = 1003},	
					{ monsterId = 34, BRMONSTER = 1, deadbody = 6 ,  centerX = 19 , centerY = 7 , BRArea = 3 , BRNumber =3 , aiType = 3, searchArea = 8 ,deadScript = 1003},	
				},
				--[104] = {
				--	 { name = 'ʯ������' ,monsterId = 42, x = 4 , y = 20 ,  aiType = 2, imageID = 1146, headID = 1146, deadScript = 1004},
				--},
				[105] = {
					{ monsterId = 33, x = 7 , y = 18 ,  aiType = 3,  deadbody = 6 , controlId = 108,IdleTime = 10,deadScript = 1005},
					{ monsterId = 33, x = 5 , y = 17 ,  aiType = 3,  deadbody = 6 , controlId = 109,IdleTime = 10,deadScript = 1005},
					{ monsterId = 33, x = 6 , y = 22 ,  aiType = 3,  deadbody = 6 , controlId = 110,IdleTime = 10,deadScript = 1005},
					{ monsterId = 33, x = 3 , y = 21 ,  aiType = 3,  deadbody = 6 , controlId = 111,IdleTime = 10,deadScript = 1005},
					{ monsterId = 33, x = 5 , y = 23 ,  aiType = 3,  deadbody = 6 , controlId = 112,IdleTime = 10,deadScript = 1005},
					{ monsterId = 33, x = 8 , y = 24 ,  aiType = 3,  deadbody = 6 , controlId = 113,IdleTime = 10,deadScript = 1005},
				},
				[106] = {
				    { monsterId = 33, BRMONSTER = 1, deadbody = 6 ,  centerX = 26 , centerY = 36 , BRArea = 5 , BRNumber =6 , deadScript = 1006},	
				},
				[107] = {
					{ name = 'ʯ������' ,monsterId = 42, x = 32 , y = 35 ,  aiType = 2, imageID = 1146, headID = 1146, deadScript = 1007},
				},
				[108] = {
                    { monsterId = 35,  x = 23 , y = 40 , isboss=1 , aiType = 3, deadScript = 1008 , deadbody = 6 , searchArea = 8 },				
				    
				},
				
            },			
			DynamicsBlock = {1},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			EnterPos = {{x = 44, y = 9}},		-- �����
			RelivePos = {1,44,9},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 40000,					-- ���� ÿ�վ����0.005
		Money = 30000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 610, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 611, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 612, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 600, CountList = { 1, 3 }, IsBind = 1 },
		},
		equip = {
			count = {[1] = 8000,[2] = 10000}, eqLV = 30, quality = {[1] = 10000,[2] = 0,[3] = 0,[4] = 0},IsBind = 1,school =1 ,sex=1
		},
		
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}

FBConfig[1][8] = {
	FBName = '���帴��',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2020,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 20,		-- �Ƽ��ȼ�
	BackPos = {8,66,134},
	--StoryID = 1000125,			-- ���븱����������ID ���¼������ľ��飬�ڸ��¼��б����ã�
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 1, num = 4, EventTb = { {EventTypeTb.MonRefresh   ,{1,102}}, } },
			[1002] = { step = 2, num = 4, EventTb = { {EventTypeTb.MonRefresh   ,{1,103}}, } },
			[1003] = { step = 3, num = 4, EventTb = { {EventTypeTb.MonRefresh   ,{1,104}}, } },
			[1004] = { step = 4, num = 4, EventTb = { {EventTypeTb.MonRefresh   ,{1,105}}, } },
			[1005] = { step = 5, num = 4, EventTb = { {EventTypeTb.MonRefresh   ,{1,106}}, } },
			[1006] = { step = 6, num = 1, EventTb = { {EventTypeTb.Story,{1,1000116}},{EventTypeTb.Completion}, }, },
			--[1006] = { step = 6, num = 1, EventTb = { {EventTypeTb.Completion}, }, },
		},	
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1013, 		-- ��ͼ���					
			
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 36 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 21 , centerY = 117 , aiType = 3, BRArea = 4 , BRNumber =4 ,deadScript = 1001},
				},
				[102] = {
					{ monsterId = 36 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 9 , centerY = 100 , aiType = 3, BRArea = 4 , BRNumber =4 ,deadScript = 1002},
				},
				[103] = {
					{ monsterId = 36 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 25 , centerY = 63 , aiType = 3, BRArea = 3 , BRNumber =4 ,deadScript = 1003},
				},
				[104] = {
					{ monsterId = 37 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 23 , centerY = 41 , aiType = 3, BRArea = 4 , BRNumber =4 ,deadScript = 1004},
				},
				[105] = {
					{ monsterId = 37 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 7 , centerY = 40 , aiType = 3, BRArea = 4 , BRNumber =4 ,deadScript = 1005},
				},
				[106] = {
				    { monsterId = 38,  x = 14 , y = 11 , isboss=1 , aiType = 3,  deadbody = 6 , deadScript = 1006  },	
                },
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			EnterPos = {{x = 28, y = 103}},		-- �����
			RelivePos = {1,28,103},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 50000,					-- ���� ÿ�վ����0.005
		Money = 40000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 610, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 611, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 612, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 600, CountList = { 1, 3 }, IsBind = 1 },

		},
		equip = {
			count = {[1] = 8000,[2] = 10000}, eqLV = 30, quality = {[1] = 7000,[2] = 10000,[3] = 0,[4] = 0},IsBind = 1,school =1 ,sex=1
		},
		
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}

FBConfig[1][9] = {
	FBName = '��ս����',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2020,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 20,		-- �Ƽ��ȼ�
	BackPos = {8,66,134},
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 3, num = 1, EventTb = { {EventTypeTb.Story,{1,1000116}},{EventTypeTb.Completion}, }},
			[1002] = { step = 1, num = 5, EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[1003] = { step = 2, num = 5, EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
			
		},			
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1016, 		-- ��ͼ���											
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 39, BRMONSTER = 1, centerX = 27 , centerY = 82 , BRArea = 4 , BRNumber =5 , deadbody = 6 , deadScript = 1002,  },					
				},
				[102] = {
					{ controlId = 100, name = 'Ѳ�߼ľ�з' ,IdleTime = 10, monsterId = 39,  x = 9 , y = 89 , deadbody = 6, },
					{ controlId = 101, name = 'Ѳ�߼ľ�з' ,IdleTime = 10, monsterId = 39,  x = 11 , y = 87 , deadbody = 6, },
					{ controlId = 102, name = 'Ѳ�߼ľ�з' ,IdleTime = 10, monsterId = 39,  x = 13 , y = 88 , deadbody = 6, },
				},
				[103] = {
					{ monsterId = 40, BRMONSTER = 1, centerX = 27 , centerY = 43 , BRArea = 4 , BRNumber =5 , deadbody = 6 , deadScript = 1003, },
				},
				[104] = {
					{ controlId = 200, monsterId = 41,  x = 15 , y = 27 , isboss=1 , EventID = 1, eventScript = 1007,deadbody = 6 , deadScript = 1001, },
				},
				[105] = {
					{ controlId = 103, name = 'Ѳ��ҹ��' ,IdleTime = 10, monsterId = 40,  x = 9 , y = 64 , deadbody = 6, },
					{ controlId = 104, name = 'Ѳ��ҹ��' ,IdleTime = 10, monsterId = 40,  x = 9 , y = 62 , deadbody = 6, },
					{ controlId = 105, name = 'Ѳ��ҹ��' ,IdleTime = 10, monsterId = 40,  x = 9 , y = 60 , deadbody = 6, },
				},					

            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			-- TrapPos = {					-- ������б�
				 -- [1001] = {1,8,90,4}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
				 -- [1002] = {1,9,67,4},
		    -- },			
			EnterPos = {{x = 3, y = 88}},		-- �����
			RelivePos = {1,3,88},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 60000,					-- ���� ÿ�վ����0.005
		Money = 30000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 610, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 611, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 612, CountList = { 1, 2 }, IsBind = 1 },
		},
		equip = {
			count = {[1] = 8000,[2] = 10000}, eqLV = 30, quality = {[1] = 7000,[2] = 10000,[3] = 0,[4] = 0},IsBind = 1,school =1 ,sex=1
		},
		

		
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}

FBConfig[1][10] = {
	FBName = '������1��',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2035,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 20,		-- �Ƽ��ȼ�	
	--StoryID = 1000126,			-- ���븱����������ID ���¼������ľ��飬�ڸ��¼��б����ã�
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 3, num = 1, info = 2, EventTb = { {EventTypeTb.Completion}, }, },
			[1002] = { step = 1, num = 5,},
			[1003] = { step = 2, num = 5,},
		},	
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1008, 		-- ��ͼ���					
			
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 49 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 8 , centerY = 25 , BRArea = 4 , BRNumber =5 ,deadScript = 1002 },		
					{ monsterId = 50 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 24 , centerY = 39 , BRArea = 3 , BRNumber =5 ,deadScript = 1003},
                    { monsterId = 51,  isboss=1 ,x = 40 , y = 12 , deadbody = 6 , deadScript = 1001 },							
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			-- TrapPos = {					-- ������б�
				-- [1001] = {0,28,59,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			-- },			
			EnterPos = {{x = 4, y = 9}},		-- �����
			RelivePos = {1,4,9},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 70000,					-- ���� ÿ�վ����0.005
		Money = 50000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 610, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 611, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 612, CountList = { 1, 2 }, IsBind = 1 },
		},
		
		equip = {
			count = {[1] = 8000,[2] = 10000}, eqLV = 40, quality = {[1] = 7000,[2] = 10000,[3] = 0,[4] = 0},IsBind = 1,school =1 ,sex=1
		},
		
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}

FBConfig[1][11] = {
	FBName = '������2��',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2014,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 20,		-- �Ƽ��ȼ�
	--StoryID = 1000127,			-- ���븱����������ID ���¼������ľ��飬�ڸ��¼��б����ã�
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 5, num = 1, info = 2, EventTb = { {EventTypeTb.Completion}, }, },
			[1002] = { step = 1, num = 6,},
			[1003] = { step = 2, num = 5,},
			[1004] = { step = 3, num = 5,},
			[1005] = { step = 4, num = 5,},
		},	
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1009, 		-- ��ͼ���					
			
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 52 , BRMONSTER = 1 ,  deadbody = 6 , refreshTime = 0 , centerX = 17 , centerY = 15 , BRArea = 4 , BRNumber =6 , deadScript = 1002},						
					{ monsterId = 52 , BRMONSTER = 1 ,  deadbody = 6 , refreshTime = 0 , centerX = 23 , centerY = 34 , BRArea = 3 , BRNumber =5 , deadScript = 1003},
					{ monsterId = 53 , BRMONSTER = 1 ,  deadbody = 6 , refreshTime = 0 , centerX = 9 , centerY = 43 , BRArea = 3 , BRNumber =5 , deadScript = 1004},
                    { monsterId = 53 , BRMONSTER = 1 ,  deadbody = 6 , refreshTime = 0 , centerX = 17 , centerY = 62 , BRArea = 4 , BRNumber =5 , deadScript = 1005},					
                    { monsterId = 54 , isboss=1 , x = 9 , y = 69 , deadbody = 6 , deadScript = 1001 },						
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			-- TrapPos = {					-- ������б�
				-- [1001] = {0,28,59,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			-- },			
			EnterPos = {{x = 6, y = 7}},		-- �����
			RelivePos = {1,6,7},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 80000,					-- ���� ÿ�վ����0.005
		Money = 60000,						-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 610, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 611, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 612, CountList = { 1, 2 }, IsBind = 1 },
		},
		
		equip = {
			count = {[1] = 8000,[2] = 10000}, eqLV = 40, quality = {[1] = 6000,[2] = 10000,[3] = 0,[4] = 0},IsBind = 1,school =1 ,sex=1
		},
		
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}

FBConfig[1][12] = {
	FBName = '����ħ��',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2044,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 20,		-- �Ƽ��ȼ�
	--StoryID = 1000130,			-- ���븱����������ID ���¼������ľ��飬�ڸ��¼��б����ã�
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1004] = { step = 4, num = 1, info = 2, EventTb = { {EventTypeTb.Completion}, }, },
			[1001] = { step = 1, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[1003] = { step = 3, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
		},	
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1017, 		-- ��ͼ���					
			
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 63 ,monAtt={[1] =4000,},searchArea = 8,  BRMONSTER = 1 ,  deadbody = 6 , centerX = 35 , centerY = 11 , BRArea = 4 , BRNumber =6 , deadScript = 1001},	
				},
				[102] = {	
					{ monsterId = 63 ,monAtt={[1] =4000,},searchArea = 8,  BRMONSTER = 1 ,  deadbody = 6 , centerX = 9 , centerY = 32 , BRArea = 4 , BRNumber =6 , deadScript = 1002},
				},
				[103] = {
					{ monsterId = 63 ,monAtt={[1] =4000,},searchArea = 8,  BRMONSTER = 1 ,  deadbody = 6 , centerX = 18 , centerY = 53 , BRArea = 3 , BRNumber =6 , deadScript = 1003},					
				},
				[104] = {
				{ monsterId = 79 , monAtt={[1] =30000,[3] =1000,[4] =400,},isboss=1 , x = 35 , y = 35 , deadbody = 6 , deadScript = 1004 },						
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			-- TrapPos = {					-- ������б�
				-- [1001] = {0,28,59,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			-- },			
			EnterPos = {{x = 13, y = 10}},		-- �����
			RelivePos = {1,13,10},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 90000,					-- ���� ÿ�վ����0.005
		Money = 70000,							-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 610, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 611, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 612, CountList = { 1, 2 }, IsBind = 1 },
		},
		
		equip = {
			count = {[1] = 8000,[2] = 10000}, eqLV = 40, quality = {[1] = 6000,[2] = 10000,[3] = 0,[4] = 0},IsBind = 1,school =1 ,sex=1
		},
		
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}

FBConfig[1][13] = {
	FBName = '����ħ��',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2045,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 20,		-- �Ƽ��ȼ�	
	--StoryID = 1000131,			-- ���븱����������ID ���¼������ľ��飬�ڸ��¼��б����ã�
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1004] = { step = 4, num = 1, info = 2, EventTb = { {EventTypeTb.Completion}, }, },
			[1001] = { step = 1, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[1003] = { step = 3, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
		},	
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1018, 		-- ��ͼ���					
			
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 63 ,monAtt={[1] =4000,},searchArea = 8, BRMONSTER = 1 ,  deadbody = 6 , centerX = 22 , centerY = 51 , BRArea = 3 , BRNumber =6 , deadScript = 1001},	
				},
				[102] = {	
					{ monsterId = 63 ,monAtt={[1] =4000,},searchArea = 8,  BRMONSTER = 1 ,  deadbody = 6 , centerX = 7 , centerY = 38 , BRArea = 3 , BRNumber =6 , deadScript = 1002},
				},
				[103] = {	
					{ monsterId = 63 ,monAtt={[1] =4000,},searchArea = 8,  BRMONSTER = 1 ,  deadbody = 6 , centerX = 37 , centerY = 22 , BRArea = 3 , BRNumber =6 , deadScript = 1003},					
				},
				[104] = {	
					{ monsterId = 80 , monAtt={[1] =40000,[3] =1100,[4] =400,},isboss=1 , x = 16 , y = 13 , deadbody = 6 , deadScript = 1004 },						
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			-- TrapPos = {					-- ������б�
				-- [1001] = {0,28,59,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			-- },			
			EnterPos = {{x = 40, y = 50}},		-- �����
			RelivePos = {1,40,50},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 100000,					-- ���� ÿ�վ����0.005
		Money = 80000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 610, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 611, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 612, CountList = { 1, 2 }, IsBind = 1 },
		},
		
		equip = {
			count = {[1] = 8000,[2] = 10000}, eqLV = 40, quality = {[1] = 6000,[2] = 10000,[3] = 0,[4] = 0},IsBind = 1,school =1 ,sex=1
		},
		
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}

FBConfig[1][14] = {
	FBName = '����ħ��',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2046,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 20,		-- �Ƽ��ȼ�	
	--StoryID = 1000128,			-- ���븱����������ID ���¼������ľ��飬�ڸ��¼��б����ã�
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1004] = { step = 4, num = 1, info = 2, EventTb = { {EventTypeTb.Completion}, }, },
			[1001] = { step = 1, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[1003] = { step = 3, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
		},	
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1020, 		-- ��ͼ���					
			
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 64 ,monAtt={[1] =4000,},searchArea = 8, BRMONSTER = 1 ,  deadbody = 6 , centerX = 23 , centerY = 19 , BRArea = 3 , BRNumber =6 , deadScript = 1001},	
				},
				[102] = {	
					{ monsterId = 64 ,monAtt={[1] =4000,},searchArea = 8, BRMONSTER = 1 ,  deadbody = 6 , centerX = 8 , centerY = 42 , BRArea = 3 , BRNumber =6 , deadScript = 1002},
				},
				[103] = {	
					{ monsterId = 64 ,monAtt={[1] =4000,},searchArea = 8, BRMONSTER = 1 ,  deadbody = 6 , centerX = 11 , centerY = 79 , BRArea = 3 , BRNumber =6 , deadScript = 1003},					
				},
				[104] = {	
					{ monsterId = 81 , monAtt={[1] =45000,[3] =1200,[4] =400,},isboss=1 , x = 24 , y = 58 , deadbody = 6 , deadScript = 1004 },						
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			-- TrapPos = {					-- ������б�
				-- [1001] = {0,28,59,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			-- },			
			EnterPos = {{x = 7, y = 10}},		-- �����
			RelivePos = {1,7,10},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 110000,					-- ���� ÿ�վ����0.005
		Money = 90000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 610, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 611, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 612, CountList = { 1, 2 }, IsBind = 1 },
		},
		
		equip = {
			count = {[1] = 8000,[2] = 10000}, eqLV = 40, quality = {[1] = 6000,[2] = 10000,[3] = 0,[4] = 0},IsBind = 1,school =1 ,sex=1
		},
		
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}

FBConfig[1][15] = {
	FBName = '����ħ��',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2047,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 20,		-- �Ƽ��ȼ�
	--StoryID = 1000129,			-- ���븱����������ID ���¼������ľ��飬�ڸ��¼��б����ã�
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1004] = { step = 4, num = 1, info = 2, EventTb = { {EventTypeTb.Completion}, }, },
			[1001] = { step = 1, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[1003] = { step = 3, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
		},	
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1019, 		-- ��ͼ���					
			
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 64 ,monAtt={[1] =4000,},searchArea = 8,  BRMONSTER = 1 ,  deadbody = 6 , centerX = 22 , centerY = 73 , BRArea = 3 , BRNumber =6 , deadScript = 1001},	
				},
				[102] = {	
					{ monsterId = 64 ,monAtt={[1] =4000,},searchArea = 8,  BRMONSTER = 1 ,  deadbody = 6 , centerX = 8 , centerY = 52 , BRArea = 3 , BRNumber =6 , deadScript = 1002},
				},
				[103] = {	
					{ monsterId = 64 ,monAtt={[1] =4000,},searchArea = 8,  BRMONSTER = 1 ,  deadbody = 6 , centerX = 24 , centerY = 32 , BRArea = 3 , BRNumber =6 , deadScript = 1003},					
				},
				[104] = {	
					{ monsterId = 82 , monAtt={[1] =5000,[3] =1300,[4] =400,},isboss=1 , x = 12 , y = 13 , deadbody = 6 , deadScript = 1004 },						
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			-- TrapPos = {					-- ������б�
				-- [1001] = {0,28,59,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			-- },			
			EnterPos = {{x = 5, y = 81}},		-- �����
			RelivePos = {1,5,81},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 120000,					-- ���� ÿ�վ����0.005
		Money = 100000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 610, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 611, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 612, CountList = { 1, 2 }, IsBind = 1 },
		},
		
		equip = {
			count = {[1] = 8000,[2] = 10000}, eqLV = 40, quality = {[1] = 6000,[2] = 10000,[3] = 0,[4] = 0},IsBind = 1,school =1 ,sex=1
		},
		
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}

FBConfig[1][16] = {
	FBName = '����ץ��',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 116,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 20,		-- �Ƽ��ȼ�
	BackPos = {8,15,93},
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 1, num = 5,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 5,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[1003] = { step = 3, num = 1,EventTb = { {EventTypeTb.Completion}, }, },
		},	
		
	},
	
	MapList = {				-- ��ͼ�б�
		[1] = {
			MapID = 1001, 		-- ��ͼ���				
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 93,BRMONSTER = 1, deadbody = 6 , centerX = 13 , centerY = 25 , BRArea = 2 , BRNumber =5 , deadScript = 1001},
				},
				[102] = {
					{ monsterId = 94,BRMONSTER = 1, deadbody = 6 , centerX = 30 , centerY = 25 , BRArea = 3 , BRNumber =5 , deadScript = 1002},
				},
				[103] = {
					{ monsterId = 88,BRMONSTER = 1, deadbody = 6 , centerX = 53 , centerY = 25 , BRArea = 4 , BRNumber =1 , deadScript = 1003},
				},	
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 6, y = 8}},		-- �����
			--RelivePos = {1,5,81},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 30000,					-- ���� ÿ�վ����0.005
		Money = 20000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 610, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 611, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 612, CountList = { 1, 2 }, IsBind = 1 },
		},
		equip = {
			count = {[1] = 8000,[2] = 10000}, eqLV = 30, quality = {[1] = 10000,[2] = 0,[3] = 0,[4] = 0},IsBind = 1,school =1 ,sex=1
		},
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	
	},
}

FBConfig[1][17] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2016,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1003] = { step = 3, num = 1, info = 2, EventTb = { {EventTypeTb.Completion}, }, },
			[1001] = { step = 1, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
		},	
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1022, 		-- ��ͼ���					
			
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 66 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 12 , centerY = 67 , BRArea = 3 , BRNumber =6 , deadScript = 1001},	
				},
				[102] = {	
					{ monsterId = 67 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 21 , centerY = 39 , BRArea = 3 , BRNumber =6 , deadScript = 1002},
				},
				[103] = {	
					{ monsterId = 83 , isboss=1 , x = 12 , y = 14 , deadbody = 6 , deadScript = 1003 },						
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 24, y = 81}},		-- �����
			RelivePos = {1,24,81},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 120000,					-- ���� ÿ�վ����0.005
		Money = 100000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 610, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 611, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 612, CountList = { 1, 2 }, IsBind = 1 },
		},
		
		equip = {
			count = {[1] = 8000,[2] = 10000}, eqLV = 40, quality = {[1] = 6000,[2] = 10000,[3] = 0,[4] = 0},IsBind = 1,school =1 ,sex=1
		},
		
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}

FBConfig[1][18] = {
	FBName = '�����',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2049,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1004] = { step = 4, num = 1,EventTb = { {EventTypeTb.Completion}, }, },
			[1001] = { step = 1, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[1003] = { step = 3, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
		},	
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1023, 		-- ��ͼ���					
			
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 66 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 41 , centerY = 37 , BRArea = 3 , BRNumber =6 , deadScript = 1001},	
				},
				[102] = {	
					{ monsterId = 67 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 38 , centerY = 12 , BRArea = 3 , BRNumber =6 , deadScript = 1002},
				},
				[103] = {	
					{ monsterId = 67 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 16 , centerY = 28 , BRArea = 3 , BRNumber =6 , deadScript = 1003},
				},
				[104] = {	
					{ monsterId = 84 , isboss=1 , x = 7 , y = 48 , deadbody = 6 , deadScript = 1004 },						
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 31, y = 64}},		-- �����
			RelivePos = {1,31,64},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 120000,					-- ���� ÿ�վ����0.005
		Money = 100000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 610, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 611, CountList = { 1, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 612, CountList = { 1, 2 }, IsBind = 1 },
		},
		
		equip = {
			count = {[1] = 8000,[2] = 10000}, eqLV = 40, quality = {[1] = 6000,[2] = 10000,[3] = 0,[4] = 0},IsBind = 1,school =1 ,sex=1
		},
		
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}


-----------------------------------------------------------------------------------------------


-- ���˸���
FBConfig[2] = {
}
--[[
FBConfig[2][1] = {
	FBName = '�Ͻ�����',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2005,			-- Сͼ�꣨����
	MaxPlayer = 3,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 35,		-- �Ƽ��ȼ�
	bossName = '��ħ����',		--����boss����
    showtype = 1,
	ClientItemList = {616,641,627,630,724,1097},  --ǰ̨��ʾ����Ʒ�б�
	
	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[10001] = { step = 2, num = 1, info = 2, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Lights = {
			[1001] = { num = 3, npcid = 500003, EventTb = {	{EventTypeTb.TimerTrigger,1,},},},			
		},
		Timers = {
			[1] = {num = 1,timer = 2, 
				EventTb = { 
					{
						EventTypeTb.UserDefined,
						{
							func = 'ud_2001_1',
							param = {
								item = {					-- ������Ʒ
									{ Rate = { 1, 10000 }, ItemID = 627, CountList = { 1, 1 }, IsBind = 0 },--���ǵ�
									{ Rate = { 1, 5000 }, ItemID = 627, CountList = { 1, 1 }, IsBind = 0 },--���ǵ�
									{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 1, 1 }, IsBind = 0 },--�ʺ�ʯ
									{ Rate = { 1, 5000 }, ItemID = 626, CountList = { 1, 1 }, IsBind = 0 },--�ʺ�ʯ
									{ Rate = { 1, 5000 }, ItemID = 641, CountList = { 1, 1 }, IsBind = 0 },--������
									{ Rate = { 1, 10000 }, ItemID = 630, CountList = { 1, 1 }, IsBind = 0 },--����ˢ����
									{ Rate = { 1, 5000 }, ItemID = 630, CountList = { 1, 1 }, IsBind = 0 },--����ˢ����
								},
								equip = {
									count = {[1] = 8000,[2] = 10000}, eqLV = 40,school = 1,sex = 1, quality = {[1] = 0,[2] = 10000,[3] = 0,[4] = 0,[5] = 0},IsBind = 0,
								},
								x = 36,
								y = 63,
							},
						},
					},
				},
			},
		},
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1027, 		-- ��ͼ���
            MecFlags = {[500003] = 1,},	-- ���س�ʼ״̬ 0 �����Կ��� 1 ���Կ���
			NPCList = {			-- ����NPC�б� ��������NPC					
				[500003] = {{36,63}},
			
			},			
			
										
			MonsterList = {				-- �����б�
				[101] = {	
                    { monsterId = 185, BRMONSTER = 1, deadbody = 6 , centerX = 35 , centerY = 14 , BRArea = 5 , BRNumber =10 },	
					{ monsterId = 186, BRMONSTER = 1, deadbody = 6 , centerX = 21 , centerY = 39 , BRArea = 5 , BRNumber =10 },	
					{ monsterId = 187, BRMONSTER = 1, deadbody = 6 , centerX = 13 , centerY = 52 , BRArea = 5 , BRNumber =10 },	
					{ monsterId = 188, BRMONSTER = 1, deadbody = 6 , centerX = 36 , centerY = 64 , BRArea = 5 , BRNumber =10 },
					{ monsterId = 189, BRMONSTER = 1, deadbody = 6 , centerX = 36 , centerY = 95 , BRArea = 5 , BRNumber =10 },
					{ monsterId = 190,  EventID = 1, eventScript = 1017,controlId = 1003,x = 11 , y = 94 , isboss=1 , deadbody =50, deadScript = 10001, },				
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			LightRound = {
				[1] = {1001,1,32,63,1},		-- ��̨��Ȧ������š�ǰ̨��Դ��š�x��y��len����ɫ
				[2] = {1001,1,40,63,1},
				[3] = {1001,1,36,57,1},
			},
			EnterPos = {{x = 16, y = 11}},		-- �����
			
			RelivePos = {1,16,11},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 35,				-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 100000,					-- ���� ÿ�վ����0.005
		Money = 10000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 627, CountList = { 5, 10 }, IsBind = 1 },--���ǵ�
			{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 5, 10 }, IsBind = 1 },--�ʺ�ʯ
			{ Rate = { 1, 10000 }, ItemID = 724, CountList = { 3, 3 }, IsBind = 1 },--��װ������Ƭ
			{ Rate = { 1, 10000 }, ItemID = 718, CountList = { 1, 1 }, IsBind = 1 },--��װ������Ƭ
		},
		
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}
]]--

FBConfig[2][2] = {
	FBName = '�����ؿ�',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2094,			-- Сͼ�꣨����
	MaxPlayer = 3,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 78,		-- �Ƽ��ȼ�
	bossName = '�����'	,	--����boss����
	ClientItemList = {722,728,627,626,724,641},  --ǰ̨��ʾ����Ʒ�б�
	showtype = 2,
	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[10001] = { step = 2, num = 1, info = 2, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Lights = {
			[1001] = { num = 3, npcid = 500004, EventTb = {	{EventTypeTb.TimerTrigger,1,},},},			
		},
		Timers = {
			[1] = {num = 1,timer = 2, 
				EventTb = { 
					{
						EventTypeTb.UserDefined,
						{
							func = 'ud_2001_1',
							param = {
								item = {					-- ������Ʒ
									{ Rate = { 1, 10000 }, ItemID = 627, CountList = { 1, 1 }, IsBind = 0 },--���ǵ�
									{ Rate = { 1, 5000 }, ItemID = 627, CountList = { 1, 1 }, IsBind = 0 },--���ǵ�
									{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 1, 1 }, IsBind = 0 },--�ʺ�ʯ
									{ Rate = { 1, 5000 }, ItemID = 626, CountList = { 1, 1 }, IsBind = 0 },--�ʺ�ʯ
									{ Rate = { 1, 5000 }, ItemID = 641, CountList = { 1, 1 }, IsBind = 0 },--������
									{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 1, 1 }, IsBind = 0 },--����ˢ����
									{ Rate = { 1, 5000 }, ItemID = 627, CountList = { 1, 1 }, IsBind = 0 },--����ˢ����
								},
								equip = {
									count = {[1] = 8000,[2] = 10000}, eqLV = 80,school = 1,sex = 1, quality = {[1] = 0,[2] = 10000,[3] = 0,[4] = 0,[5] = 0},IsBind = 0,
								},
								x = 8,
								y = 27,
							},
						},
					},
				},
			},
		},
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1010, 		-- ��ͼ���					
		    MecFlags = {[500004] = 1,},	-- ���س�ʼ״̬ 0 �����Կ��� 1 ���Կ���
			NPCList = {			-- ����NPC�б� ��������NPC					
				[500004] = {{8,27}},
			},		
			MonsterList = {				-- �����б�
				[101] = {	
                    { monsterId = 211, BRMONSTER = 1, deadbody = 6 , centerX = 44 , centerY = 46 , BRArea = 5 , BRNumber =12 },	
					{ monsterId = 211, BRMONSTER = 1, deadbody = 6 , centerX = 20 , centerY = 48 , BRArea = 5 , BRNumber =12 },	
					{ monsterId = 212, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 8 , BRArea = 5 , BRNumber =10 },
					{ monsterId = 212, BRMONSTER = 1, deadbody = 6 , centerX = 52 , centerY = 10 , BRArea = 5 , BRNumber =10 },
					{ monsterId = 213,  x = 32 , y = 31 , isboss=1 , EventID = 1, eventScript = 1018,controlId = 1004,deadbody =50, deadScript = 10001, },	    
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			LightRound = {
				[1] = {1001,1,5,27,1,1},		-- ��̨��Ȧ������š�ǰ̨��Դ��š�x��y��len����ɫ
				[2] = {1001,2,11,27,1,2},
				[3] = {1001,3,8,32,1,3},
			},			
			EnterPos = {{x = 55, y = 56}},		-- �����
			RelivePos = {1,55,56},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 78,				-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 450000,					-- ���� ÿ�վ����0.005
		Money = 20000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 627, CountList = { 5, 10 }, IsBind = 1 },--���ǵ�
			{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 5, 10 }, IsBind = 1 },--�ʺ�ʯ
			{ Rate = { 1, 10000 }, ItemID = 728, CountList = { 3, 3 }, IsBind = 1 },--��װ������Ƭ
			{ Rate = { 1, 10000 }, ItemID = 722, CountList = { 1, 1 }, IsBind = 1 },--��װ������Ƭ
		},
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}


FBConfig[2][3] = {
	FBName = '������ң��',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2019,			-- Сͼ�꣨����
	MaxPlayer = 3,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 40,		-- �Ƽ��ȼ�
	bossName = '��̫�Ӱ���'	,	--����boss����
	ClientItemList = {626,641,627,630,724,1097},  --ǰ̨��ʾ����Ʒ�б�
	showtype = 2,
	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[10001] = { step = 2, num = 1, info = 2, EventTb = { {EventTypeTb.Completion}, } },
		},
		Lights = {
			[1001] = { num = 3, npcid = 500004, EventTb = {	{EventTypeTb.TimerTrigger,1,},},},			
		}, -- num=1 �����  num=2 Կ���Լ��ɼ�  num=3 �Լ����ɼ�Կ��       ����ID
		Timers = {
			[1] = {num = 1,timer = 2, 
				EventTb = { 
					{
						EventTypeTb.UserDefined,
						{
							func = 'ud_2001_1',
							param = {
								item = {					-- ������Ʒ    --1-10000����  ����ID  �������   ��1 
									{ Rate = { 1, 10000 }, ItemID = 627, CountList = { 1, 1 }, IsBind = 0 },--���ǵ�
									{ Rate = { 1, 5000 }, ItemID = 627, CountList = { 1, 1 }, IsBind = 0 },--���ǵ�
									{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 1, 1 }, IsBind = 0 },--�ʺ�ʯ
									{ Rate = { 1, 5000 }, ItemID = 626, CountList = { 1, 1 }, IsBind = 0 },--�ʺ�ʯ
									{ Rate = { 1, 5000 }, ItemID = 641, CountList = { 1, 1 }, IsBind = 0 },--������
									{ Rate = { 1, 10000 }, ItemID = 630, CountList = { 1, 1 }, IsBind = 0 },--����ˢ����
									{ Rate = { 1, 5000 }, ItemID = 630, CountList = { 1, 1 }, IsBind = 0 },--����ˢ����
								},
								equip = {
									count = {[1] = 8000,[2] = 10000}, eqLV = 40,school = 1,sex = 1, quality = {[1] = 0,[2] = 10000,[3] = 0,[4] = 0,[5] = 0},IsBind = 0,
								},
								x = 34,
								y = 19,
							},
						},
					},
				},
			},
		},
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1011, 		-- ��ͼ���					
			MecFlags = {[500004] = 1,},	-- ���س�ʼ״̬ 0 �����Կ��� 1 ���Կ���
			NPCList = {			-- ����NPC�б� ��������NPC					
				[500004] = {{34,19}},
			},
										
			MonsterList = {				-- �����б�
				[101] = {	
                    { monsterId = 196, BRMONSTER = 1, deadbody = 6 , centerX = 44 , centerY = 49 , BRArea = 5 , BRNumber =10 },	
					{ monsterId = 197, BRMONSTER = 1, deadbody = 6 , centerX = 7 , centerY = 52 , BRArea = 5 , BRNumber =10 },
					{ monsterId = 198, BRMONSTER = 1, deadbody = 6 , centerX = 19 , centerY = 34 , BRArea = 5 , BRNumber =10 },						
					{ monsterId = 200,  x = 51 , y = 9 , EventID = 1, eventScript = 1021,controlId = 1004,isboss=1 , deadbody =50, deadScript = 10001, },	       			
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			LightRound = {
				[1] = {1001,1,37,19,1,1},		-- ��̨��Ȧ������š�ǰ̨��Դ��š�x��y��len����ɫ
				[2] = {1001,2,31,19,1,2},
				[3] = {1001,3,34,24,1,3},
			},		
			EnterPos = {{x = 57, y = 47}},		-- �����
			RelivePos = {1,57,47},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 40,				-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 200000,					-- ���� ÿ�վ����0.005
		Money = 30000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 627, CountList = { 5, 10 }, IsBind = 1 },--���ǵ�
			{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 5, 10 }, IsBind = 1 },--�ʺ�ʯ
			{ Rate = { 1, 10000 }, ItemID = 724, CountList = { 10, 10 }, IsBind = 1 },--��װ������Ƭ
			{ Rate = { 1, 10000 }, ItemID = 718, CountList = { 2, 2 }, IsBind = 1 },--��װ������Ƭ
		},
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}

FBConfig[2][4] = {
	FBName = '��Ԩ��Ѩ',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2070,			-- Сͼ�꣨����
	MaxPlayer = 3,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 48,		-- �Ƽ��ȼ�
	bossName = '������'	,	--����boss����
	ClientItemList = {626,641,627,630,725,1097},  --ǰ̨��ʾ����Ʒ�б�
	showtype = 3,
	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[10001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Lights = {
			[1001] = { num = 3, npcid = 500004, EventTb = {	{EventTypeTb.TimerTrigger,1,},},},			
		},
		Timers = {
			[1] = {num = 1,timer = 2, 
				EventTb = { 
					{
						EventTypeTb.UserDefined,
						{
							func = 'ud_2001_1',
							param = {
								item = {					-- ������Ʒ
									{ Rate = { 1, 10000 }, ItemID = 627, CountList = { 1, 1 }, IsBind = 0 },--���ǵ�
									{ Rate = { 1, 5000 }, ItemID = 627, CountList = { 1, 1 }, IsBind = 0 },--���ǵ�
									{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 1, 1 }, IsBind = 0 },--�ʺ�ʯ
									{ Rate = { 1, 5000 }, ItemID = 626, CountList = { 1, 1 }, IsBind = 0 },--�ʺ�ʯ
									{ Rate = { 1, 5000 }, ItemID = 641, CountList = { 1, 1 }, IsBind = 0 },--������
									{ Rate = { 1, 10000 }, ItemID = 630, CountList = { 1, 1 }, IsBind = 0 },--����ˢ����
									{ Rate = { 1, 5000 }, ItemID = 630, CountList = { 1, 1 }, IsBind = 0 },--����ˢ����
								},
								equip = {
									count = {[1] = 8000,[2] = 10000}, eqLV = 50,school = 1,sex = 1, quality = {[1] = 0,[2] = 10000,[3] = 0,[4] = 0,[5] = 0},IsBind = 0,
								},
								x = 9,
								y = 41,
							},
						},
					},
				},
			},
		},
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1014, 		-- ��ͼ���					
			MecFlags = {[500004] = 1,},	-- ���س�ʼ״̬ 0 �����Կ��� 1 ���Կ���
			NPCList = {			-- ����NPC�б� ��������NPC					
				[500004] = {{9,41}},
			},
										
			MonsterList = {				-- �����б�
				[101] = {	
                    { monsterId = 201, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 15 , BRArea = 4 , BRNumber =10 },	
					{ monsterId = 201, BRMONSTER = 1, deadbody = 6 , centerX = 7 , centerY = 12 , BRArea = 4 , BRNumber =10 },	
					{ monsterId = 202, BRMONSTER = 1, deadbody = 6 , centerX = 36 , centerY = 53 , BRArea = 4 , BRNumber =10 },	
					{ monsterId = 202, BRMONSTER = 1, deadbody = 6 , centerX = 27 , centerY = 29 , BRArea = 4 , BRNumber =10 },	
					{ monsterId = 203,  x = 56 , y = 42 , isboss=1 , EventID = 1, eventScript = 1006,deadbody =50, deadScript = 10001, },	       			
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			LightRound = {
				[1] = {1001,1,12,41,1,1},		-- ��̨��Ȧ������š�ǰ̨��Դ��š�x��y��len����ɫ
				[2] = {1001,2,7,38,1,2},
				[3] = {1001,3,7,44,1,3},
			},				
			EnterPos = {{x = 58, y = 5}},		-- �����
			RelivePos = {1,58,5},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 48,				-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 250000,					-- ���� ÿ�վ����0.005
		Money = 40000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 627, CountList = { 5, 10 }, IsBind = 1 },--���ǵ�
			{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 5, 10 }, IsBind = 1 },--�ʺ�ʯ
			{ Rate = { 1, 10000 }, ItemID = 725, CountList = { 8, 8 }, IsBind = 1 },--��װ������Ƭ
			{ Rate = { 1, 10000 }, ItemID = 719, CountList = { 2, 2 }, IsBind = 1 },--��װ������Ƭ
		},
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}

FBConfig[2][5] = {
	FBName = 'ǬԪ��ɽ',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2035,			-- Сͼ�꣨����
	MaxPlayer = 3,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 68,		-- �Ƽ��ȼ�
	bossName = '�綾����'	,	--����boss����
	ClientItemList = {626,641,627,630,725,1097},  --ǰ̨��ʾ����Ʒ�б�
	showtype = 3,
	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[10001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Lights = {
			[1001] = { num = 3, npcid = 500004, EventTb = {	{EventTypeTb.TimerTrigger,1,},},},			
		},
		Timers = {
			[1] = {num = 1,timer = 2, 
				EventTb = { 
					{
						EventTypeTb.UserDefined,
						{
							func = 'ud_2001_1',
							param = {
								item = {					-- ������Ʒ
									{ Rate = { 1, 10000 }, ItemID = 627, CountList = { 1, 1 }, IsBind = 0 },--���ǵ�
									{ Rate = { 1, 5000 }, ItemID = 627, CountList = { 1, 1 }, IsBind = 0 },--���ǵ�
									{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 1, 1 }, IsBind = 0 },--�ʺ�ʯ
									{ Rate = { 1, 5000 }, ItemID = 626, CountList = { 1, 1 }, IsBind = 0 },--�ʺ�ʯ
									{ Rate = { 1, 5000 }, ItemID = 641, CountList = { 1, 1 }, IsBind = 0 },--������
									{ Rate = { 1, 10000 }, ItemID = 630, CountList = { 1, 1 }, IsBind = 0 },--����ˢ����
									{ Rate = { 1, 5000 }, ItemID = 630, CountList = { 1, 1 }, IsBind = 0 },--����ˢ����
								},
								equip = {
									count = {[1] = 8000,[2] = 10000}, eqLV = 70,school = 1,sex = 1, quality = {[1] = 0,[2] = 10000,[3] = 0,[4] = 0,[5] = 0},IsBind = 0,
								},
								x = 21,
								y = 95,
							},
						},
					},
				},
			},
		},
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1006, 		-- ��ͼ���					
			MecFlags = {[500004] = 1,},	-- ���س�ʼ״̬ 0 �����Կ��� 1 ���Կ���
			NPCList = {			-- ����NPC�б� ��������NPC					
				[500004] = {{21,95}},
			},
										
			MonsterList = {				-- �����б�
				[101] = {	
                    { monsterId = 204, BRMONSTER = 1, deadbody = 6 , centerX = 38 , centerY = 37 , BRArea = 6 , BRNumber =12 },	
					{ monsterId = 204, BRMONSTER = 1, deadbody = 6 , centerX = 38 , centerY = 84 , BRArea = 6 , BRNumber =12 },
					{ monsterId = 205, BRMONSTER = 1, deadbody = 6 , centerX = 6 , centerY = 83 , BRArea = 4 , BRNumber =10 },	
					{ monsterId = 205, BRMONSTER = 1, deadbody = 6 , centerX = 11 , centerY = 51 , BRArea = 6 , BRNumber =12 },	
					{ monsterId = 206,  x = 8 , y = 20 , isboss=1 , EventID = 1, eventScript = 1006,deadbody =50, deadScript = 10001, },	       			
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			LightRound = {
				[1] = {1001,1,17,95,1,1},		-- ��̨��Ȧ������š�ǰ̨��Դ��š�x��y��len����ɫ
				[2] = {1001,2,25,95,1,2},
				[3] = {1001,3,21,99,1,3},
			},			
			EnterPos = {{x = 41, y = 16}},		-- �����
			RelivePos = {1,41,16},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 68,				-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 400000,					-- ���� ÿ�վ����0.005
		Money = 80000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 627, CountList = { 5, 10 }, IsBind = 1 },--���ǵ�
			{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 5, 10 }, IsBind = 1 },--�ʺ�ʯ
			{ Rate = { 1, 10000 }, ItemID = 727, CountList = { 3, 3 }, IsBind = 1 },--��װ������Ƭ
			{ Rate = { 1, 10000 }, ItemID = 721, CountList = { 1, 1 }, IsBind = 1 },--��װ������Ƭ
		},
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}

FBConfig[2][6] = {
	FBName = 'ˮ������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2020,			-- Сͼ�꣨����
	MaxPlayer = 3,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 58,		-- �Ƽ��ȼ�
	bossName = '��������'	,	--����boss����
    showtype = 3,
	ClientItemList = {626,641,627,630,726,1097},  --ǰ̨��ʾ����Ʒ�б�
	
	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[10001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},
		Lights = {
			[1001] = { num = 3, npcid = 500004, EventTb = {	{EventTypeTb.TimerTrigger,1,},},},			
		},
		Timers = {
			[1] = {num = 1,timer = 2, 
				EventTb = { 
					{
						EventTypeTb.UserDefined,
						{
							func = 'ud_2001_1',
							param = {
								item = {					-- ������Ʒ
									{ Rate = { 1, 10000 }, ItemID = 627, CountList = { 1, 1 }, IsBind = 0 },--���ǵ�
									{ Rate = { 1, 5000 }, ItemID = 627, CountList = { 1, 1 }, IsBind = 0 },--���ǵ�
									{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 1, 1 }, IsBind = 0 },--�ʺ�ʯ
									{ Rate = { 1, 5000 }, ItemID = 626, CountList = { 1, 1 }, IsBind = 0 },--�ʺ�ʯ
									{ Rate = { 1, 5000 }, ItemID = 641, CountList = { 1, 1 }, IsBind = 0 },--������
									{ Rate = { 1, 10000 }, ItemID = 630, CountList = { 1, 1 }, IsBind = 0 },--����ˢ����
									{ Rate = { 1, 5000 }, ItemID = 630, CountList = { 1, 1 }, IsBind = 0 },--����ˢ����
								},
								equip = {
									count = {[1] = 8000,[2] = 10000}, eqLV = 60,school = 1,sex = 1, quality = {[1] = 0,[2] = 10000,[3] = 0,[4] = 0,[5] = 0},IsBind = 0,
								},
								x = 23,
								y = 36,
							},
						},
					},
				},
			},
		},		
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1013, 		-- ��ͼ���					
			MecFlags = {[500004] = 1,},	-- ���س�ʼ״̬ 0 �����Կ��� 1 ���Կ���
			NPCList = {			-- ����NPC�б� ��������NPC					
				[500004] = {{23,36}},
			},
										
			MonsterList = {				-- �����б�
				[101] = {	
                    { monsterId = 207, BRMONSTER = 1, deadbody = 6 , centerX = 8 , centerY = 101 , BRArea = 5 , BRNumber =12 },	
					{ monsterId = 208, BRMONSTER = 1, deadbody = 6 , centerX = 25 , centerY = 65 , BRArea = 5 , BRNumber =12 },
					{ monsterId = 209, BRMONSTER = 1, deadbody = 6 , centerX = 6 , centerY = 44 , BRArea = 5 , BRNumber =12 },	
					{ monsterId = 210,  x = 13 , y = 13 , isboss=1 , EventID = 1, eventScript = 1006,deadbody =50, deadScript = 10001, },	       			
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			LightRound = {
				[1] = {1001,1,26,36,1,1},		-- ��̨��Ȧ������š�ǰ̨��Դ��š�x��y��len����ɫ
				[2] = {1001,2,20,36,1,2},
				[3] = {1001,3,23,40,1,3},
			},			
			EnterPos = {{x = 27, y = 107}},		-- �����
			RelivePos = {1,27,107},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 58,				-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 350000,					-- ���� ÿ�վ����0.005
		Money = 60000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 627, CountList = { 5, 10 }, IsBind = 1 },--���ǵ�
			{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 5, 10 }, IsBind = 1 },--�ʺ�ʯ
			{ Rate = { 1, 10000 }, ItemID = 726, CountList = { 5, 5 }, IsBind = 1 },--��װ������Ƭ
			{ Rate = { 1, 10000 }, ItemID = 720, CountList = { 1, 1 }, IsBind = 1 },--��װ������Ƭ
		},
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}
FBConfig[2][7] = {
	FBName = '��ԯ��',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2256,			-- Сͼ�꣨����
	MaxPlayer = 3,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 88,		-- �Ƽ��ȼ�
	bossName = '��β槼�'	,	--����boss����
    showtype = 3,
	ClientItemList = {626,641,627,630,729,1097},  --ǰ̨��ʾ����Ʒ�б�
	
	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[100026] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},
		Lights = {
			[1001] = { num = 3, npcid = 500004, EventTb = {	{EventTypeTb.TimerTrigger,1,},},},			
		},
		Timers = {
			[1] = {num = 1,timer = 2, 
				EventTb = { 
					{
						EventTypeTb.UserDefined,
						{
							func = 'ud_2001_1',
							param = {
								item = {					-- ������Ʒ
									{ Rate = { 1, 10000 }, ItemID = 627, CountList = { 1, 1 }, IsBind = 0 },--���ǵ�
									{ Rate = { 1, 5000 }, ItemID = 627, CountList = { 1, 1 }, IsBind = 0 },--���ǵ�
									{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 1, 1 }, IsBind = 0 },--�ʺ�ʯ
									{ Rate = { 1, 5000 }, ItemID = 626, CountList = { 1, 1 }, IsBind = 0 },--�ʺ�ʯ
									{ Rate = { 1, 5000 }, ItemID = 641, CountList = { 1, 1 }, IsBind = 0 },--������
									{ Rate = { 1, 10000 }, ItemID = 630, CountList = { 1, 1 }, IsBind = 0 },--����ˢ����
									{ Rate = { 1, 5000 }, ItemID = 630, CountList = { 1, 1 }, IsBind = 0 },--����ˢ����
								},
								equip = {
									count = {[1] = 8000,[2] = 10000}, eqLV = 90,school = 1,sex = 1, quality = {[1] = 0,[2] = 10000,[3] = 0,[4] = 0,[5] = 0},IsBind = 0,
								},
								x = 37,
								y = 47,
							},
						},
					},
				},
			},
		},		
		
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 531, 		-- ��ͼ���					
			MecFlags = {[500004] = 1,},	-- ���س�ʼ״̬ 0 �����Կ��� 1 ���Կ���
			NPCList = {			-- ����NPC�б� ��������NPC					
				[500004] = {{37,47}},
			},
										
			MonsterList = {				-- �����б�
				[101] = {	
                    { monsterId = 214, BRMONSTER = 1, deadbody = 6 , centerX = 71 , centerY = 46 , BRArea = 5 , BRNumber =12 },	
					{ monsterId = 214, BRMONSTER = 1, deadbody = 6 , centerX = 46 , centerY = 48 , BRArea = 5 , BRNumber =12 },
					{ monsterId = 214, BRMONSTER = 1, deadbody = 6 , centerX = 7 , centerY = 39 , BRArea = 5 , BRNumber =12 },	
					{ monsterId = 215,  x = 16 , y = 9 , isboss=1 , EventID = 1, eventScript = 1006,deadbody =50, deadScript = 100026, },	       			
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			LightRound = {
				[1] = {1001,1,37,42,1,1},		-- ��̨��Ȧ������š�ǰ̨��Դ��š�x��y��len����ɫ
				[2] = {1001,2,37,52,1,2},
				[3] = {1001,3,41,47,1,3},
			},			
			EnterPos = {{x = 78, y = 66}},		-- �����
			RelivePos = {1,78,66},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 88,				-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 500000,					-- ���� ÿ�վ����0.005
		Money = 100000,				-- ����
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 627, CountList = { 5, 10 }, IsBind = 1 },--���ǵ�
			{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 5, 10 }, IsBind = 1 },--�ʺ�ʯ
			{ Rate = { 1, 10000 }, ItemID = 729, CountList = { 3, 3 }, IsBind = 1 },--��װ������Ƭ
			{ Rate = { 1, 10000 }, ItemID = 723, CountList = { 1, 1 }, IsBind = 1 },--��װ������Ƭ
		},
		
		StarLvTime = 5 * 60,		-- �Ǽ�ʱ��
		SpecialProc = {
		},
	},
}

-------------------------------------------------��������---------------------------------------------------
FBConfig[3] = {
}


FBConfig[3][1] = {
	FBName = '��ʯ����',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 2,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,1}},{[1] = {{1,2}}}},},{EventTypeTb.MonRefresh,{1,102,nil,1},},},},
			[1002] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,1}},{[1] = {{1,3}}}},},{EventTypeTb.MonRefresh,{1,103,nil,2},},},},
			[1003] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,2}},{[1] = {{1,4}}}},},{EventTypeTb.MonRefresh,{1,104,nil,3},},},},
			[1004] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,2}},{[1] = {{1,5}}}},},{EventTypeTb.MonRefresh,{1,105,nil,4},},},},
			[1005] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,3}},{[1] = {{1,6}}}},},{EventTypeTb.MonRefresh,{1,106,nil,5},},},},
			[1006] = { num = 1, EventTb = { {EventTypeTb.GiveItems,{1,15,15,{{626,3}},{[1] = {{1,7}}}},},{EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	  
		[1] = {
			MapID = 516, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 225 , monAtt={[1] =5000,[3] =200,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1001},
				},
				[102]={ 
					{ monsterId = 230 , monAtt={[1] =10000,[3] =300,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1002},
				},	
				[103]={ 
					{ monsterId = 235 , monAtt={[1] =30000,[3] =500,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1003},
				},	
				[104]={ 
					{ monsterId = 240 , monAtt={[1] =50000,[3] =700,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1004},
				},	
				[105]={ 
					{ monsterId = 245 , monAtt={[1] =80000,[3] =1000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1005},
				},	
				[106]={ 
		            { monsterId = 228 , monAtt={[1] =400000,[3] =5000,},deadbody = 6 ,x = 13 , y = 15 , deadScript = 1006},
		        }, 					
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 15, y = 16}},		-- �����
			RelivePos = {1,15,16},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 38,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}

FBConfig[3][2] = {
	FBName = '��ʯ����',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 2,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,2}},{[1] = {{2,1}}}},},{EventTypeTb.MonRefresh,{1,102,nil,1},},},},
			[1002] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,2}},{[1] = {{1,2},{2,1}}}},},{EventTypeTb.MonRefresh,{1,103,nil,2},},},},
			[1003] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,3}},{[1] = {{2,2}}}},},{EventTypeTb.MonRefresh,{1,104,nil,3},},},},
			[1004] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,3}},{[1] = {{1,2},{2,2}}}},},{EventTypeTb.MonRefresh,{1,105,nil,4},},},},
			[1005] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,4}},{[1] = {{2,3}}}},},{EventTypeTb.MonRefresh,{1,106,nil,5},},},},
			[1006] = { num = 1, EventTb = { {EventTypeTb.GiveItems,{1,15,15,{{626,4}},{[1] = {{1,2},{2,3}}}},},{EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	  
		[1] = {
			MapID = 516, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 226 , monAtt={[1] =80000,[3] =2000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1001},
				},
				[102]={ 
					{ monsterId = 231 , monAtt={[1] =150000,[3] =2500,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1002},
				},	
				[103]={ 
					{ monsterId = 236 , monAtt={[1] =200000,[3] =3000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1003},
				},	
				[104]={ 
					{ monsterId = 241 , monAtt={[1] =300000,[3] =3500,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1004},
				},	
				[105]={ 
					{ monsterId = 246 , monAtt={[1] =380000,[3] =4000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1005},
				},	
				[106]={ 
		            { monsterId = 229 , monAtt={[1] =1800000,[3] =13000,},deadbody = 6 ,x = 13 , y = 15 , deadScript = 1006},
		        }, 					
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 15, y = 15}},		-- �����
			RelivePos = {1,15,15},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 50,					-- ����ȼ�����
	},	
	
	CSAwards = {
	},	
}

FBConfig[3][3] = {
	FBName = '��ʯ����',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 2,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,3}},{[1] = {{2,2}}}},},{EventTypeTb.MonRefresh,{1,102,nil,1},},},},
			[1002] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,4}},{[1] = {{1,2},{2,2}}}},},{EventTypeTb.MonRefresh,{1,103,nil,2},},},},
			[1003] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,5}},{[1] = {{2,3}}}},},{EventTypeTb.MonRefresh,{1,104,nil,3},},},},
			[1004] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,6}},{[1] = {{1,2},{2,3}}}},},{EventTypeTb.MonRefresh,{1,105,nil,4},},},},
			[1005] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,7}},{[1] = {{2,4}}}},},{EventTypeTb.MonRefresh,{1,106,nil,5},},},},
			[1006] = { num = 1, EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,8}},{[1] = {{1,2},{2,4}}}},}, {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	  
		[1] = {
			MapID = 516, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 227 , monAtt={[1] =200000,[3] =3000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1001},
				},
				[102]={ 
					{ monsterId = 232 , monAtt={[1] =400000,[3] =4000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1002},
				},	
				[103]={ 
					{ monsterId = 237 , monAtt={[1] =500000,[3] =5000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1003},
				},	
				[104]={ 
					{ monsterId = 242 , monAtt={[1] =600000,[3] =6000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1004},
				},	
				[105]={ 
					{ monsterId = 247 , monAtt={[1] =700000,[3] =7000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1005},
				},	
				[106]={ 
		            { monsterId = 233 , monAtt={[1] =5000000,[3] =30000,},deadbody = 6 ,x = 13 , y = 15 , deadScript = 1006},
		        }, 					
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 15, y = 15}},		-- �����
			RelivePos = {1,15,15},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 62,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}

FBConfig[3][4] = {
	FBName = '��ʯ����',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 2,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,3}},{[1] = {{2,4}}}},},{EventTypeTb.MonRefresh,{1,102,nil,1},},},},
			[1002] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,4}},{[1] = {{1,2},{2,4}}}},},{EventTypeTb.MonRefresh,{1,103,nil,2},},},},
			[1003] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,5}},{[1] = {{2,6}}}},},{EventTypeTb.MonRefresh,{1,104,nil,3},},},},
			[1004] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,6}},{[1] = {{1,2},{2,6}}}},},{EventTypeTb.MonRefresh,{1,105,nil,4},},},},
			[1005] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,7}},{[1] = {{2,8}}}},},{EventTypeTb.MonRefresh,{1,106,nil,5},},},},
			[1006] = { num = 1, EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,8}},{[1] = {{1,2},{2,8}}}},}, {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	  
		[1] = {
			MapID = 516, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 911 , monAtt={[1] =400000,[3] =3000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1001},
				},
				[102]={ 
					{ monsterId = 912 , monAtt={[1] =800000,[3] =4000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1002},
				},	
				[103]={ 
					{ monsterId = 913 , monAtt={[1] =1000000,[3] =5000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1003},
				},	
				[104]={ 
					{ monsterId = 914 , monAtt={[1] =1200000,[3] =6000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1004},
				},	
				[105]={ 
					{ monsterId = 915 , monAtt={[1] =1400000,[3] =7000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1005},
				},	
				[106]={ 
		            { monsterId = 916 , monAtt={[1] =10000000,[3] =30000,},deadbody = 6 ,x = 13 , y = 15 , deadScript = 1006},
		        }, 					
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 15, y = 15}},		-- �����
			RelivePos = {1,15,15},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 68,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}

FBConfig[3][5] = {
	FBName = '��ʯ����',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 2,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,3}},{[1] = {{3,1}}}},},{EventTypeTb.MonRefresh,{1,102,nil,1},},},},
			[1002] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,4}},{[1] = {{2,2},{3,1}}}},},{EventTypeTb.MonRefresh,{1,103,nil,2},},},},
			[1003] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,5}},{[1] = {{3,2}}}},},{EventTypeTb.MonRefresh,{1,104,nil,3},},},},
			[1004] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,6}},{[1] = {{2,2},{3,2}}}},},{EventTypeTb.MonRefresh,{1,105,nil,4},},},},
			[1005] = { num = 6,EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,7}},{[1] = {{3,2}}}},},{EventTypeTb.MonRefresh,{1,106,nil,5},},},},
			[1006] = { num = 1, EventTb = {{EventTypeTb.GiveItems,{1,15,15,{{626,8}},{[1] = {{2,2},{3,3}}}},}, {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	  
		[1] = {
			MapID = 516, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 917 , monAtt={[1] =600000,[3] =3000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1001},
				},
				[102]={ 
					{ monsterId = 918 , monAtt={[1] =1200000,[3] =4000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1002},
				},	
				[103]={ 
					{ monsterId = 919 , monAtt={[1] =1600000,[3] =5000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1003},
				},	
				[104]={ 
					{ monsterId = 920 , monAtt={[1] =2000000,[3] =6000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1004},
				},	
				[105]={ 
					{ monsterId = 921 , monAtt={[1] =2400000,[3] =7000,},BRMONSTER = 1 ,  deadbody = 6 , centerX = 15 , centerY = 15 , BRArea = 5 , BRNumber =6 , deadScript = 1005},
				},	
				[106]={ 
		            { monsterId = 922 , monAtt={[1] =8000000,[3] =30000,},deadbody = 6 ,x = 13 , y = 15 , deadScript = 1006},
		        }, 					
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 15, y = 15}},		-- �����
			RelivePos = {1,15,15},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}
------------------------------------------------------------------

FBConfig[4] = {
}

FBConfig[4][1] = {
	FBName = '��������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2048,			-- Сͼ�꣨����
	MaxPlayer = 3,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '̫ʦ����',
	RecommendLV = 50,		-- �Ƽ��ȼ�
	

	ClientItemList = {637,667},  --ǰ̨��ʾ����Ʒ�б�
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
			[1002] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 30, preTime = 5, timer = 30, EventTb = { {EventTypeTb.MonRefresh,{1,{102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,},},}, },},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 507, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 302, eventScript = 201, x = 16 , y = 31 , camp = 4, },
					{ monsterId = 302, eventScript = 201, x = 18 , y = 34 , camp = 4, },
					{ monsterId = 302, eventScript = 201, x = 21 , y = 37 , camp = 4, },
					{ monsterId = 302, eventScript = 201, x = 8 , y = 40 ,  camp = 4,},
					{ monsterId = 302, eventScript = 201, x = 10 , y = 43 , camp = 4,},
					{ monsterId = 302, eventScript = 201, x = 12 , y = 46 , camp = 4, },
					{ name = '槼�', mapIcon = 1 , monAtt={[1] =1000,[4] =2000000000,},eventScript = 202,monsterId = 337,x = 8,y = 23,camp = 4,deadScript = 1001,},								
				},
				[102] = {
					{ monsterId = 307, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 307, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 307, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[103] = {
					{ monsterId = 308, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 308, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 308, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[104] = {
					{ monsterId = 309, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 309, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 309, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[105] = {
					{ monsterId = 310, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 310, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 310, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[106] = {
					{ monsterId = 311, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 311, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 311, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[107] = {
					{ monsterId = 312, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =1 , deadScript = 4001, camp = 5,},	
				},
				[108] = {
					{ monsterId = 313, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 313, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 313, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[109] = {
					{ monsterId = 314, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 314, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 314, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[110] = {
					{ monsterId = 315, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 315, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 315, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[111] = {
					{ monsterId = 316, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 316, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 316, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[112] = {
					{ monsterId = 317, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 317, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 317, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[113] = {
					{ monsterId = 318, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =1 , deadScript = 4001, camp = 5,},	
				},
				[114] = {
					{ monsterId = 319, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 319, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 319, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[115] = {
					{ monsterId = 320, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 320, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 320, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[116] = {
					{ monsterId = 321, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 321, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 321, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[117] = {
					{ monsterId = 322, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 322, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 322, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[118] = {
					{ monsterId = 323, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 323, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 323, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[119] = {
					{ monsterId = 324, BRMONSTER = 1, EventID = 1, eventScript = 1006,deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =1 , deadScript = 4001, camp = 5,},	
				},
				[120] = {
					{ monsterId = 325, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 325, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 325, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[121] = {
					{ monsterId = 326, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 326, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 326, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[122] = {
					{ monsterId = 327, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 327, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 327, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[123] = {
					{ monsterId = 328, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 328, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 328, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[124] = {
					{ monsterId = 329, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 329, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 329, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[125] = {
					{ monsterId = 330, BRMONSTER = 1, EventID = 1, eventScript = 1006,deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =1 , deadScript = 4001, camp = 5,},	
				},
				[126] = {
					{ monsterId = 331, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 331, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 331, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[127] = {
					{ monsterId = 332, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 332, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 332, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[128] = {
					{ monsterId = 333, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 333, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 333, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[129] = {
					{ monsterId = 334, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 334, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 334, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[130] = {
					{ monsterId = 335, BRMONSTER = 1, deadbody = 6 , centerX = 43 , centerY = 83 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 335, BRMONSTER = 1, deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
					{ monsterId = 335, BRMONSTER = 1, deadbody = 6 , centerX = 18 , centerY = 91 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =10 , deadScript = 4001, camp = 5,},
				},
				[131] = {
					{ monsterId = 336, BRMONSTER = 1, EventID = 1, eventScript = 1006,deadbody = 6 , centerX = 50 , centerY = 53 , BRArea = 5 , targetX = 8, targetY = 23, BRNumber =1 , deadScript = 1002, camp = 5,},	
				},
			
					
					
					
			},			
			DynamicsBlock = {1},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			--TrapPos = {					-- ������б�
			--	[1001] = {1,21,49,3,3,{0,1,-10,}}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������	{[1]=�˺����ͣ�0 Ѫ�� 1 ŭ��;[2]=ֵ���ͣ� 0 ֵ 1 �ٷֱ�;[3]=��ֵ ����Ϊ�ӣ���Ϊ����;[4]=ǰ̨���ڱ���ʱ���õ�buffid}			
			--},			
			EnterPos = {{x = 14, y = 35}},		-- �����
			RelivePos = {1,14,35},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nLevel = 49,					-- ����ȼ�����
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		func = 'cs_award_4001',
		
		
	},
}

-------------------------------------------ͭǮ����--------------------------------

FBConfig[6] = {				-- ͭǮ����
}

FBConfig[6][1] = {
	FBName = 'ͭǮ����',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2044,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 20,		-- �Ƽ��ȼ�
		
	

	
	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 1, num = 24,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[1002] = { step = 2, num = 1,
				EventTb = {	
					{EventTypeTb.UserDefined,{func = 'ud_6001_1',param = 1},},
					{EventTypeTb.TimerTrigger,2,},
				},
			},
			[1003] = { step = 3, num = 30,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[1004] = { step = 4, num = 1, 
				EventTb = {
					{EventTypeTb.UserDefined,{func = 'ud_6001_1',param = 2},},
					{EventTypeTb.TimerTrigger,3,},
				},
			},
			[1005] = { step = 5, num = 36,EventTb = {{EventTypeTb.MonRefresh,{1,107},},},},
			[1006] = { step = 6, num = 1,
				EventTb = {
					{EventTypeTb.UserDefined,{func = 'ud_6001_1',param = 3},},
					{EventTypeTb.TimerTrigger,4,},
				},
			},
			[1007] = { step = 7, num = 42,EventTb = {{EventTypeTb.MonRefresh,{1,109},},},},
			[1008] = { step = 8, num = 1,
				EventTb = {
					
					{EventTypeTb.UserDefined,{func = 'ud_6001_1',param = 4},},
					{EventTypeTb.TimerTrigger,5,},
				},
			},
			[1009] = { step = 9, num = 48,EventTb = {{EventTypeTb.MonRefresh,{1,111},},},},
			[1010] = { step = 10, num = 1,
				EventTb = {
				    {EventTypeTb.Completion}, 
					{EventTypeTb.UserDefined,{func = 'ud_6001_1',param = 5},},
				},
			},
		},	
		Timers = {
			[1] = {num = 3,preTime = 3,timer = 5,
				EventTb = {
					{EventTypeTb.MonRefresh,{1,102,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*3) monatt[3] = math.floor(lv^2.2*0.05) monatt[4] = math.floor(lv^2.5*0.05) end},1},},
				},
				
			},
			[2] = {num = 3,timer = 5,
				EventTb = {
					{EventTypeTb.MonRefresh,{1,104,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*4) monatt[3] = math.floor(lv^2.2*0.06) monatt[4] = math.floor(lv^2.5*0.06) end},2},},
				},	
			},	
			
			[3] = {num = 3,timer = 5,
				EventTb = {
					{EventTypeTb.MonRefresh,{1,106,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*6) monatt[3] = math.floor(lv^2.2*0.07) monatt[4] = math.floor(lv^2.5*0.1) end},3},},
				},				
			},
			[4] = {num = 3,timer = 5,
				EventTb = {
					{EventTypeTb.MonRefresh,{1,108,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*8) monatt[3] = math.floor(lv^2.2*0.08) monatt[4] = math.floor(lv^2.5*0.2) end},4},},
				},				
			},
			[5] = { num = 3,timer = 5,
				EventTb = {
					{EventTypeTb.MonRefresh,{1,110,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*10) monatt[3] = math.floor(lv^2.2*0.1) monatt[4] = math.floor(lv^2.5*0.3) end},5},},
				},				
			},
			[6] = {num = 1,preTime = 600,EventTb = { {EventTypeTb.Failed,},},},
		},
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 518, 		-- ��ͼ���					
			
										
			MonsterList = {				-- �����б�
				[102] = {
					  {monsterId = 115, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 9 ,centerY = 14,BRArea = 2 , BRNumber =2 , targetX = 13, targetY = 18, deadScript = 1001},
                      {monsterId = 365, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 20 ,centerY = 14,BRArea = 2 , BRNumber =2 , targetX = 15, targetY = 18, deadScript = 1001},
                      {monsterId = 365, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 9 ,centerY = 26,BRArea = 2 , BRNumber =2 , targetX = 13, targetY = 20, deadScript = 1001},
                      {monsterId = 365, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 20 ,centerY = 26,BRArea = 2 , BRNumber =2 , targetX = 15, targetY = 20, deadScript = 1001},
					   -- {monsterId = 365, BRMONSTER = 1 ,  deadbody = 5 , centerX = 9 ,centerY = 14,BRArea = 2 , BRNumber =2 , deadScript = 1001},
                       -- {monsterId = 365, BRMONSTER = 1 ,  deadbody = 5 , centerX = 20 ,centerY = 14,BRArea = 2 , BRNumber =2 , deadScript = 1001},
                       -- {monsterId = 365, BRMONSTER = 1 ,  deadbody = 5 , centerX = 9 ,centerY = 26,BRArea = 2 , BRNumber =2 , deadScript = 1001},
                       -- {monsterId = 365, BRMONSTER = 1 ,  deadbody = 5 , centerX = 20 ,centerY = 26,BRArea = 2 , BRNumber =2 , deadScript = 1001},					  
				},
				[103] = {	
					{ monsterId = 370 ,  x = 13 , y = 18 , monAtt={[1] =20,},deadbody = 6 , EventID = 1, eventScript = 1010,deadScript = 1002 },		
				},
				[104] = {
					  {monsterId = 366, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 9 ,centerY = 14,BRArea = 2 , BRNumber =3 , targetX = 13, targetY = 18, deadScript = 1003},
                      {monsterId = 116, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 20 ,centerY = 14,BRArea = 2 , BRNumber =2 , targetX = 15, targetY = 18, deadScript = 1003},
                      {monsterId = 366, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 9 ,centerY = 26,BRArea = 2 , BRNumber =3 , targetX = 13, targetY = 20, deadScript = 1003},
                      {monsterId = 366, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 20 ,centerY = 26,BRArea = 2 , BRNumber =2 , targetX = 15, targetY = 20, deadScript = 1003},
					  -- {monsterId = 366, BRMONSTER = 1 ,  deadbody = 5 , centerX = 9 ,centerY = 14,BRArea = 2 , BRNumber =3 ,  deadScript = 1003},
                      -- {monsterId = 366, BRMONSTER = 1 ,  deadbody = 5 , centerX = 20 ,centerY = 14,BRArea = 2 , BRNumber =3 , deadScript = 1003},
                      -- {monsterId = 366, BRMONSTER = 1 ,  deadbody = 5 , centerX = 9 ,centerY = 26,BRArea = 2 , BRNumber =3 , deadScript = 1003},
                      -- {monsterId = 366, BRMONSTER = 1 ,  deadbody = 5 , centerX = 20 ,centerY = 26,BRArea = 2 , BRNumber =3 ,  deadScript = 1003},							  
				},
				[105] = {
					{ monsterId = 371 , x = 13 , y = 18 , monAtt={[1] =20,},deadbody = 6 , EventID = 1, eventScript = 1010,deadScript = 1004},			
				},
				[106] = {
                      {monsterId = 367, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 9 ,centerY = 14,BRArea = 2 , BRNumber =3, targetX = 13, targetY = 18, deadScript = 1005},
                      {monsterId = 367, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 20 ,centerY = 14,BRArea = 2 , BRNumber =3 , targetX = 15, targetY = 18, deadScript = 1005},
                      {monsterId = 117, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 9 ,centerY = 26,BRArea = 2 , BRNumber =3 , targetX = 13, targetY = 20, deadScript = 1005},
                      {monsterId = 367, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 20 ,centerY = 26,BRArea = 2 , BRNumber =3 , targetX = 15, targetY = 20, deadScript = 1005},					
				},
				[107] = {
					{ monsterId = 372 , x = 13 , y = 18 , monAtt={[1] =20,},deadbody = 6 , EventID = 1, eventScript = 1010,deadScript = 1006},			
				},
				[108] = {
					  {monsterId = 368, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 9 ,centerY = 14,BRArea = 2 , BRNumber =3, targetX = 13, targetY = 18, deadScript = 1007},
                      {monsterId = 368, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 20 ,centerY = 14,BRArea = 2 , BRNumber =4 , targetX = 15, targetY = 18, deadScript = 1007},
                      {monsterId = 118, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 9 ,centerY = 26,BRArea = 2 , BRNumber =3 , targetX = 13, targetY = 20, deadScript = 1007},
                      {monsterId = 368, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 20 ,centerY = 26,BRArea = 2 , BRNumber =4 , targetX = 15, targetY = 20, deadScript = 1007},					
				},
				[109] = {
					{ monsterId = 373 , x = 13 , y = 18 , monAtt={[1] =20,},deadbody = 6 , EventID = 1, eventScript = 1010,deadScript = 1008},			
				},
				[110] = {
					  {monsterId = 119, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 9 ,centerY = 14,BRArea = 2 , BRNumber =4 , targetX = 13, targetY = 18, deadScript = 1009},
                      {monsterId = 369, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 20 ,centerY = 14,BRArea = 2 , BRNumber =4, targetX = 15, targetY = 18, deadScript = 1009},
                      {monsterId = 369, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 9 ,centerY = 26,BRArea = 2 , BRNumber =4 , targetX = 13, targetY = 20, deadScript = 1009},
                      {monsterId = 369, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 20 ,centerY = 26,BRArea = 2 , BRNumber =4 , targetX = 15, targetY = 20, deadScript = 1009},				
				},
				[111] = {
					{ monsterId = 374 , x = 13 , y = 18 , monAtt={[1] =20,},deadbody = 6 , EventID = 1, eventScript = 1010,deadScript = 1010},			
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲			
			EnterPos = {{x = 14, y = 19}},		-- �����
			RelivePos = {1,14,19},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}

FBConfig[6][2] = {
	FBName = 'ͭǮ����',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2044,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 20,		-- �Ƽ��ȼ�
		
	

	
	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 1, num = 24,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[1002] = { step = 2, num = 1,
				EventTb = {	
					{EventTypeTb.Completion}, 
					{EventTypeTb.UserDefined,{func = 'ud_6001_1',param = 1},},
					{EventTypeTb.TimerTrigger,2,},
				},
			},
		},	
		Timers = {
			[1] = {num = 3,preTime = 3,timer = 5,
				EventTb = {
					{EventTypeTb.MonRefresh,{1,102,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*2) monatt[3] = math.floor(lv^2.2*0.05) monatt[4] = math.floor(lv^2.5*0.05) end},1},},
				},
				
			},
			[2] = {num = 1,preTime = 600,EventTb = { {EventTypeTb.Failed,},},},
		},
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 518, 		-- ��ͼ���						
										
			MonsterList = {				-- �����б�
				[102] = {
					  {monsterId = 115, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 9 ,centerY = 14,BRArea = 2 , BRNumber =2 , targetX = 13, targetY = 18,deadScript = 1001},
                      {monsterId = 365, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 20 ,centerY = 14,BRArea = 2 , BRNumber =2 , targetX = 15, targetY = 18,deadScript = 1001},
                      {monsterId = 365, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 9 ,centerY = 26,BRArea = 2 , BRNumber =2 , targetX = 13, targetY = 20,deadScript = 1001},
                      {monsterId = 365, IdleTime = 5,BRMONSTER = 1 ,  deadbody = 5 , centerX = 20 ,centerY = 26,BRArea = 2 , BRNumber =2 , targetX = 15, targetY = 20,deadScript = 1001},			  
				},
				[103] = {	
					{ monsterId = 370 ,  x = 13 , y = 18 , monAtt={[1] =20,},deadbody = 6 , EventID = 1, eventScript = 1010,deadScript = 1002 },		
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲			
			EnterPos = {{x = 14, y = 19}},		-- �����
			RelivePos = {1,14,19},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}



-----------------------------------------------------------------------------------

FBConfig[7] = {
}

FBConfig[7][1] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2026,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����1��',
	rid = 2027, --������ԴID
	pid = 1, --����ͼƬID
	


	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 390,monAtt={[1] =10000,[3] =560,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},		
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲				
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		giveGoods = {
			[3] = {
				[1] = {{5340,1,1}},	-- ������
				[2] = {{5377,1,1}},	-- ����
				[3] = {{5414,1,1}},	-- ����
			},
		},
		
	},
}

FBConfig[7][2] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2131,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����2��',
	rid = 2131, --������ԴID
	pid = 2, --����ͼƬID
	


	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 391,monAtt={[1] =25000,[3] =700,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		giveGoods = {
			[3] = {
				[1] = {{5229,1,1}},	-- ������
				[2] = {{5266,1,1}},	-- ����
				[3] = {{5303,1,1}},	-- ����
			},
		},
		
		
	},
}

FBConfig[7][3] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2028,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����3��',
	rid = 2043, --������ԴID
	pid = 3, --����ͼƬID
	


	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 392,monAtt={[1] =35000,[3] =900,},EventID = 1, eventScript = 1014,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		giveGoods = {
			[3] = {
				[1] = {{5451,1,1}},	-- ������
				[2] = {{5488,1,1}},	-- ����
				[3] = {{5525,1,1}},	-- ����
			},
		},				
	},
}

FBConfig[7][4] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2029,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����4��',
	rid = 2029, --������ԴID
	pid = 4, --����ͼƬID
	

	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 393,monAtt={[1] =60000,[3] =1200,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		giveGoods = {
			[2] = {
				[10] = {5044,1,1},	-- ������(Ů)
				[11] = {5007,1,1},	-- ������(��)
				[20] = {5118,1,1},	-- ����(Ů)
				[21] = {5081,1,1},	-- ����(��)
				[30] = {5192,1,1},	-- ����(Ů)
				[31] = {5155,1,1},	-- ����(��)	
			},
		},		
	},
}

FBConfig[7][5] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2028,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����5��',
	rid = 2067, --������ԴID
	pid = 5, --����ͼƬID
	


	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 394,monAtt={[1] =100000,[3] =1500,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 50, 50 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 604, CountList = { 30, 30 }, IsBind = 1 },	
		},
		
		
	},
}

FBConfig[7][6] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2041,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����6��',
	rid = 2041, --������ԴID
	pid = 6, --����ͼƬID
	

	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 395,monAtt={[1] =260000,[3] =1700,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 5593, CountList = { 1, 1 }, IsBind = 1 },	
			{ Rate = { 1, 10000 }, ItemID = 613, CountList = { 3, 3 }, IsBind = 1 },	
		},
		
		
	},
}

FBConfig[7][7] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2042,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����7��',
	rid = 2042, --������ԴID
	pid = 7, --����ͼƬID
	

	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 396,monAtt={[1] =270000,[3] =2000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ			
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 50, 50 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 614, CountList = { 5, 5 }, IsBind = 1 },	
		},	
	},
}

FBConfig[7][8] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2030,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����8��',
	rid = 2030, --������ԴID
	pid = 8, --����ͼƬID
	


	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 397,monAtt={[1] =280000,[3] =2500,},EventID = 1, eventScript = 1015,controlId = 1001,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 5657, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 615, CountList = { 2, 2 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][9] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2005,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����9��',
	rid = 2005, --������ԴID
	pid = 9, --����ͼƬID
	

	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 398,monAtt={[1] =350000,[3] =3000,},EventID = 1, eventScript = 1016,controlId = 1002,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		
		item = {					-- ������Ʒ		
			{ Rate = { 1, 10000 }, ItemID = 5561, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 50, 50 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][10] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2025,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '��ʿ1��',
	rid = 2025, --������ԴID
	pid = 10, --����ͼƬID
	

	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 2, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522,		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 399,monAtt={[1] =200000,[3] =3000,},BRMONSTER = 1,centerX = 18, centerY = 20 ,BRArea = 3 , BRNumber =2 ,deadbody = 6 ,  deadScript = 1001, dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 50, 50 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 624, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 718, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}


FBConfig[7][11] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2092,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '��ʿ2��',
	rid = 2092, --������ԴID
	pid = 11, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 400,monAtt={[1] =400000,[3] =4000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 50, 50 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 624, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 718, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][12] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2022,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '��ʿ3��',
	rid = 2022, --������ԴID
	pid = 12, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 401,monAtt={[1] =500000,[3] =4500,},EventID = 1, eventScript = 1016,controlId = 1002,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 50, 50 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 624, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 724, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][13] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2023,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '��ʿ4��',
	rid = 2023, --������ԴID
	pid = 13, --����ͼƬID
	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 402,monAtt={[1] =600000,[3] =5000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 50, 50 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 624, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 724, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][14] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2017,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '��ʿ5��',
	rid = 2017, --������ԴID
	pid = 14, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 403,monAtt={[1] =700000,[3] =5500,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 50, 50 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 624, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 724, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][15] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2038,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '��ʿ6��',
	rid = 2038, --������ԴID
	pid = 15, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 404,monAtt={[1] =800000,[3] =6000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 50, 50 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 624, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 724, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][16] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2040,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '��ʿ7��',
	rid = 2040, --������ԴID
	pid = 16, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 405,monAtt={[1] =900000,[3] =6500,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 50, 50 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 624, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 724, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][17] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2039,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '��ʿ8��',
	rid = 2039, --������ԴID
	pid = 17, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 406,monAtt={[1] =940000,[3] =7000,},EventID = 1, eventScript = 1015,controlId = 1001,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 50, 50 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 624, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 724, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][18] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2020,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '��ʿ9��',
	rid = 2020, --������ԴID
	pid = 18, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 407,monAtt={[1] =950000,[3] =7500,},EventID = 1, eventScript = 1014,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 50, 50 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 624, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 724, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][19] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2032,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '׼��1��',
	rid = 2032, --������ԴID
	pid = 19, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 2, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 408,monAtt={[1] =550000,[3] =5000,},BRMONSTER = 1,centerX = 18, centerY = 20 ,BRArea = 3 , BRNumber =2 ,deadbody = 6 ,  deadScript = 1001, dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 100, 100 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 625, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 725, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][20] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2033,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '׼��2��',
	rid = 2033, --������ԴID
	pid = 20, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 409,monAtt={[1] =1000000,[3] =8000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 100, 100 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 625, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 725, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][21] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2034,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '׼��3��',
	rid = 2034, --������ԴID
	pid = 21, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 410,monAtt={[1] =1100000,[3] =8600,},EventID = 1, eventScript = 1016,controlId = 1002,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 100, 100 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 625, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 725, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][22] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2036,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '׼��4��',
	rid = 2036, --������ԴID
	pid = 22, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 411,monAtt={[1] =1200000,[3] =9200,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 100, 100 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 625, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 725, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][23] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2015,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '׼��5��',
	rid = 2015, --������ԴID
	pid = 23, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 412,monAtt={[1] =1300000,[3] =9800,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 100, 100 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 625, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 725, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][24] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2037,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '׼��6��',
	rid = 2037, --������ԴID
	pid = 24, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 413,monAtt={[1] =1400000,[3] =10400,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 100, 100 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 625, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 725, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][25] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2014,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '׼��7��',
	rid = 2014, --������ԴID
	pid = 25, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 414,monAtt={[1] =1500000,[3] =11000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 100, 100 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 625, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 725, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][26] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2070,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '׼��8��',
	rid = 2070, --������ԴID
	pid = 26, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 415,monAtt={[1] =1600000,[3] =11600,},EventID = 1, eventScript = 1015,controlId = 1001,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 100, 100 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 625, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 725, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][27] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2034,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '׼��9��',
	rid = 2035, --������ԴID
	pid = 27, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 416,monAtt={[1] =1600000,[3] =12200,},EventID = 1, eventScript = 1014,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 100, 100 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 625, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 725, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][28] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2026,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����1��',
	rid = 2026, --������ԴID
	pid = 28, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 2, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 417,monAtt={[1] =1000000,[3] =6000,},BRMONSTER = 1,centerX = 18, centerY = 20 ,BRArea = 3 , BRNumber =2 ,deadbody = 6 ,  deadScript = 1001, dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 120, 120 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 725, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][29] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2131,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����2��',
	rid = 2131, --������ԴID
	pid = 29, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 418,monAtt={[1] =2000000,[3] =13400,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 120, 120 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 725, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][30] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2017,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����3��',
	rid = 2066, --������ԴID
	pid = 30, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 419,monAtt={[1] =2100000,[3] =14000,},EventID = 1, eventScript = 1016,controlId = 1002,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 120, 120 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 725, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][31] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2133,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����4��',
	rid = 2133, --������ԴID
	pid = 31, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 420,monAtt={[1] =2200000,[3] =14600,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 120, 120 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 725, CountList = { 5, 5 }, IsBind = 1 },
		},		
	},
}

FBConfig[7][32] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2134,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����5��',
	rid = 2134, --������ԴID
	pid = 32, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 421,monAtt={[1] =2300000,[3] =15200,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 120, 120 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 725, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][33] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2135,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����6��',
	rid = 2135, --������ԴID
	pid = 33, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 422,monAtt={[1] =2400000,[3] =15800,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 120, 120 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 725, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][34] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2136,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����7��',
	rid = 2136, --������ԴID
	pid = 34, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 423,monAtt={[1] =2500000,[3] =16400,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 120, 120 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 719, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][35] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2137,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����8��',
	rid = 2137, --������ԴID
	pid = 35, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 424,monAtt={[1] =2600000,[3] =17000,},EventID = 1, eventScript = 1015,controlId = 1001,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 120, 120 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 719, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][36] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2044,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����9��',
	rid = 2044, --������ԴID
	pid = 36, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 425,monAtt={[1] =2600000,[3] =17600,},EventID = 1, eventScript = 1014,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 120, 120 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 719, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][37] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2105,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����1��',
	rid = 2105, --������ԴID
	pid = 37, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 2, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 426,monAtt={[1] =1600000,[3] =9000,},BRMONSTER = 1,centerX = 18, centerY = 20 ,BRArea = 3 , BRNumber =2 ,deadbody = 6 ,  deadScript = 1001, dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 150, 150 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 726, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][38] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2107,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����2��',
	rid = 2107, --������ԴID
	pid = 38, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 427,monAtt={[1] =3000000,[3] =18800,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 150, 150 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 726, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][39] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2111,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����3��',
	rid = 2111, --������ԴID
	pid = 39, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 428,monAtt={[1] =3100000,[3] =19400,},EventID = 1, eventScript = 1016,controlId = 1002,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 150, 150 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 726, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][40] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2112,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����4��',
	rid = 2112, --������ԴID
	pid = 40, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 429,monAtt={[1] =3200000,[3] =20000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 150, 150 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 726, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][41] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2113,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����5��',
	rid = 2113, --������ԴID
	pid = 41, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 430,monAtt={[1] =3300000,[3] =20600,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 150, 150 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 726, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][42] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2114,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����6��',
	rid = 2114, --������ԴID
	pid = 42, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 431,monAtt={[1] =3400000,[3] =21200,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 150, 150 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 726, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][43] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2108,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����7��',
	rid = 2108, --������ԴID
	pid = 43, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 432,monAtt={[1] =3500000,[3] =21800,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 150, 150 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 726, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][44] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2109,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����8��',
	rid = 2109, --������ԴID
	pid = 44, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 433,monAtt={[1] =3600000,[3] =22400,},EventID = 1, eventScript = 1015,controlId = 1001,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 150, 150 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 726, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][45] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2115,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����9��',
	rid = 2115, --������ԴID
	pid = 45, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 434,monAtt={[1] =3900000,[3] =23000,},EventID = 1, eventScript = 1014,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 150, 150 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 726, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][46] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2110,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����1��',
	rid = 2110, --������ԴID
	pid = 46, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 2, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 435,monAtt={[1] =3000000,[3] =11000,},BRMONSTER = 1,centerX = 18, centerY = 20 ,BRArea = 3 , BRNumber =2 ,deadbody = 6 ,  deadScript = 1001, dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 726, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][47] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2116,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����2��',
	rid = 2116, --������ԴID
	pid = 47, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 436,monAtt={[1] =4400000,[3] =24200,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 726, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][48] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2014,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����3��',
	rid = 2014, --������ԴID
	pid = 48, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 437,monAtt={[1] =4800000,[3] =24800,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 726, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][49] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2003,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����4��',
	rid = 2003, --������ԴID
	pid = 49, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 438,monAtt={[1] =5300000,[3] =25400,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 726, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][50] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2106,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����5��',
	rid = 2106, --������ԴID
	pid = 50, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 439,monAtt={[1] =5600000,[3] =26000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 726, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][51] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2004,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����6��',
	rid = 2004, --������ԴID
	pid = 51, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 440,monAtt={[1] =6000000,[3] =26600,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 726, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][52] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2045,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����7��',
	rid = 2045, --������ԴID
	pid = 52, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 441,monAtt={[1] =6300000,[3] =27200,},deadbody = 6 ,  EventID = 1, eventScript = 1016,controlId = 1002,deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 720, CountList = { 5, 5 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[7][53] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2046,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����8��',
	rid = 2046, --������ԴID
	pid = 53, --����ͼƬID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 442,monAtt={[1] =6600000,[3] =27800,},EventID = 1, eventScript = 1015,controlId = 1001,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 720, CountList = { 5, 5 }, IsBind = 1 },
		},		
	},
}

FBConfig[7][54] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2047,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����9��',
	rid = 2047, --������ԴID
	pid = 54, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 443,monAtt={[1] =7000000,[3] =28400,},EventID = 1, eventScript = 1014,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 720, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][55] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2131,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����1��',
	rid = 2131, --������ԴID
	pid = 55, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 5, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 5,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 444,monAtt={[1] =3000000,[3] =20000,},BRMONSTER = 1,centerX = 18, centerY = 20 ,BRArea = 3 , BRNumber =5 ,deadbody = 6 ,  deadScript = 1001, dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 727, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][56] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2218,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����2��',
	rid = 2218, --������ԴID
	pid = 56, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 445,monAtt={[1] =10000000,[3] =30000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 727, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][57] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2219,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����3��',
	rid = 2219, --������ԴID
	pid = 57, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 446,monAtt={[1] =10000000,[3] =35000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 727, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][58] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2014,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����4��',
	rid = 2014, --������ԴID
	pid = 58, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 447,monAtt={[1] =12000000,[3] =40000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 727, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][59] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2221,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����5��',
	rid = 2221, --������ԴID
	pid = 59, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 448,monAtt={[1] =13000000,[3] =45000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 727, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][60] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2227,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����6��',
	rid = 2227, --������ԴID
	pid = 60, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 449,monAtt={[1] =15000000,[3] =50000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 727, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][61] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2228,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����7��',
	rid = 2228, --������ԴID
	pid = 61, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 450,monAtt={[1] =14000000,[3] =60000,},deadbody = 6 ,  EventID = 1, eventScript = 1016,controlId = 1002,deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 727, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][62] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2229,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����8��',
	rid = 2229, --������ԴID
	pid = 62, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 451,monAtt={[1] =15000000,[3] =70000,},deadbody = 6 ,  EventID = 1, eventScript = 1015,controlId = 1001,deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 727, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][63] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����9��',
	rid = 2233, --������ԴID
	pid = 63, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 452,monAtt={[1] =16000000,[3] =80000,},EventID = 1, eventScript = 1014,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 727, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][64] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2245,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '���1��',
	rid = 2245, --������ԴID
	pid = 64, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 5, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 5,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 453,BRMONSTER = 1,centerX = 18, centerY = 20 ,BRArea = 3 , BRNumber =5 ,deadbody = 6 ,  deadScript = 1001, dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 728, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][65] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2226,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '���2��',
	rid = 2226, --������ԴID
	pid = 65, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 454,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 728, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][66] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2232,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '���3��',
	rid = 2232, --������ԴID
	pid = 66, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 455,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 728, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][67] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2220,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '���4��',
	rid = 2220, --������ԴID
	pid = 67, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 456,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 728, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][68] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2222,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '���5��',
	rid = 2222, --������ԴID
	pid = 68, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 457,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 728, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][69] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2223,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '���6��',
	rid = 2223, --������ԴID
	pid = 69, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 458,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 728, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][70] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2224,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '���7��',
	rid = 2224, --������ԴID
	pid = 70, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 459,deadbody = 6 ,  EventID = 1, eventScript = 1016,controlId = 1002,deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 728, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][71] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2231,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '���8��',
	rid = 2231, --������ԴID
	pid = 71, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 460,deadbody = 6 ,  EventID = 1, eventScript = 1015,controlId = 1001,deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 728, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][72] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2230,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '���9��',
	rid = 2230, --������ԴID
	pid = 72, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 461,EventID = 1, eventScript = 1014,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 728, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}
FBConfig[7][73] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2241,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '������1��',
	rid = 2241, --������ԴID
	pid = 73, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 5, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 5,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 462,BRMONSTER = 1,centerX = 18, centerY = 20 ,BRArea = 3 , BRNumber =5 ,deadbody = 6 ,  deadScript = 1001, dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 729, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][74] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2244,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '������2��',
	rid = 2244, --������ԴID
	pid = 74, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 463,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 729, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][75] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2237,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '������3��',
	rid = 2237, --������ԴID
	pid = 75, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 464,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 729, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][76] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2238,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '������4��',
	rid = 2238, --������ԴID
	pid = 76, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 465,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 729, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][77] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2235,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '������5��',
	rid = 2235, --������ԴID
	pid = 77, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 466,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 729, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][78] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2243,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '������6��',
	rid = 2243, --������ԴID
	pid = 78, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 467,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 729, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][79] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2239,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '������7��',
	rid = 2239, --������ԴID
	pid = 79, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 468,deadbody = 6 ,  EventID = 1, eventScript = 1016,controlId = 1002,deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 729, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][80] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2094,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '������8��',
	rid = 2094, --������ԴID
	pid = 80, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 469,deadbody = 6 ,  EventID = 1, eventScript = 1015,controlId = 1001,deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 729, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}

FBConfig[7][81] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2115,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '������9��',
	rid = 2115, --������ԴID
	pid = 81, --����ͼƬID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},				
	MapList = {				-- ��ͼ�б�	
		[1] = {
			MapID = 522, 		-- ��ͼ���															 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 470,EventID = 1, eventScript = 1014,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},		
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 200, 200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 663, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 729, CountList = { 5, 5 }, IsBind = 1 },
		},	
	},
}
-----------------------------------------------------------------------------------
FBConfig[8] = {				-- ������Ӣ�۸���
}

FBConfig[8][1] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2005,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '��β����',
	rid = 2003, --������ԴID
	

	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 471,monAtt={[1] =1000000,[3] =6000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 300, 300 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 637, CountList = { 10, 10 }, IsBind = 1 },
		},				
	},
}

FBConfig[8][2] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2005,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '����̫��',
	rid = 2019, --������ԴID
	

	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 472,monAtt={[1] =2000000,[3] =9000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 300, 300 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 1, 1 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 637, CountList = { 10, 10 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[8][3] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2005,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '��ʯ����',
	rid = 2004, --������ԴID
	

	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 473,monAtt={[1] =3000000,[3] =12000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 500, 500 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 2, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 637, CountList = { 30, 30 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[8][4] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2005,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '��ɡ��',
	rid = 2014, --������ԴID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 474,monAtt={[1] =4000000,[3] =15000,},EventID = 1, eventScript = 1014,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 500, 500 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 2, 2 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 637, CountList = { 30, 30 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[8][5] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2005,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = 'ħ����',
	rid = 2044, --������ԴID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 475,monAtt={[1] =5000000,[3] =18000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 800, 800 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 3, 3 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 637, CountList = { 50, 50 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[8][6] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2005,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = 'ħ���',
	rid = 2045, --������ԴID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 476,monAtt={[1] =5500000,[3] =20000,},EventID = 1, eventScript = 1015,controlId = 1001,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 800, 800 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 3, 3 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 637, CountList = { 50, 50 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[8][7] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2005,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = 'ħ����',
	rid = 2046, --������ԴID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 477,monAtt={[1] =6000000,[3] =28000,},EventID = 1, eventScript = 1014,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 1200, 1200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 4, 4 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 637, CountList = { 80, 80 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[8][8] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2005,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = 'ħ��',
	rid = 2047, --������ԴID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 478,monAtt={[1] =6500000,[3] =30000,},EventID = 1, eventScript = 1014,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 1200, 1200 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 4, 4 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 637, CountList = { 80, 80 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[8][9] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2005,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = 'Ԭ���',
	rid = 2016, --������ԴID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 479,monAtt={[1] =8000000,[3] =38000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 1600, 1600 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 5, 5 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 637, CountList = { 80, 80 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[8][10] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2005,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '�����',
	rid = 2094, --������ԴID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 480,monAtt={[1] =9000000,[3] =45000,},deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 1600, 1600 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 5, 5 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 637, CountList = { 80, 80 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[8][11] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2005,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '���ʥĸ',
	rid = 2049, --������ԴID
	

	
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
			
										 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 481,monAtt={[1] =9000000,[3] =50000,},EventID = 1, eventScript = 1015,controlId = 1001,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 2000, 2000 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 666, CountList = { 5, 5 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 637, CountList = { 100, 100 }, IsBind = 1 },
		},
		
		
	},
}

FBConfig[8][12] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2005,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '̫ʦ����',
	rid = 2048, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 482,monAtt={[1] =10000000,[3] =55000,},EventID = 1, eventScript = 1014,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 2000, 2000 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 666, CountList = { 5, 5 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 637, CountList = { 100, 100 }, IsBind = 1 },
		},			
	},
}

FBConfig[8][13] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '�깫��',
	rid = 2234, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 483,imageID = 2234 ,monAtt={[1] =16000000,[3] =90000,},EventID = 1, eventScript = 1014,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 2000, 2000 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 666, CountList = { 5, 5 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 637, CountList = { 100, 100 }, IsBind = 1 },
		},			
	},
}

FBConfig[8][14] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2239,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '�����ħ',
	rid = 2239, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 484,imageID = 2239 ,EventID = 1, eventScript = 1014,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 2000, 2000 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 666, CountList = { 5, 5 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 637, CountList = { 100, 100 }, IsBind = 1 },
		},			
	},
}
FBConfig[8][15] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2243,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '��Ѫ����',
	rid = 2243, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 485,imageID = 2243 ,EventID = 1, eventScript = 1015,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 2000, 2000 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 666, CountList = { 5, 5 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 637, CountList = { 100, 100 }, IsBind = 1 },
		},			
	},
}
FBConfig[8][16] = {
	FBName = '������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2002,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '��β槼�',
	rid = 2256, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 150,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 522, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={  
		            boss = { monsterId = 486,imageID = 2256 ,EventID = 1, eventScript = 1014,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=18,y=20,dir=2}, 
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 20}},		-- �����
			RelivePos = {1,14,20},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	CSAwards = {					-- �������ؽ���
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 1052, CountList = { 2000, 2000 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 666, CountList = { 5, 5 }, IsBind = 1 },
			{ Rate = { 1, 10000 }, ItemID = 637, CountList = { 100, 100 }, IsBind = 1 },
		},			
	},
}
------------------------------------------------------------------------------------

FBConfig[9] = {				-- ���鸱��
}

FBConfig[9][1] = {
	FBName = '���鸱��',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2005,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = '̫ʦ����',
			
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1002] = { num = 10,EventTb = {{EventTypeTb.MonRefresh,{1,103,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*4) monatt[3] = math.floor(lv^2.2*0.08) monatt[4] = math.floor(lv^2.5*0.03) end},1},},},},
			[1003] = { num = 10,EventTb = {{EventTypeTb.MonRefresh,{1,104,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*4) monatt[3] = math.floor(lv^2.2*0.08) monatt[4] = math.floor(lv^2.5*0.03) end},1},},},},	
			[1004] = { num = 10,EventTb = {{EventTypeTb.MonRefresh,{1,105,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*30) monatt[3] = math.floor(lv^2.2*0.2) monatt[4] = math.floor(lv^2.5*0.05) end},1},},},},		
			[1005] = { num = 1,EventTb = {{EventTypeTb.TimerTrigger,2,},},},
			[1006] = { num = 10,EventTb = {{EventTypeTb.MonRefresh,{1,107,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*7) monatt[3] = math.floor(lv^2.2*0.1) monatt[4] = math.floor(lv^2.5*0.04) end},1},},},},
			[1007] = { num = 10,EventTb = {{EventTypeTb.MonRefresh,{1,108,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*7) monatt[3] = math.floor(lv^2.2*0.1) monatt[4] = math.floor(lv^2.5*0.04) end},1},},},},
			[1008] = { num = 10,EventTb = {{EventTypeTb.MonRefresh,{1,109,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*60) monatt[3] = math.floor(lv^2.2*0.3) monatt[4] = math.floor(lv^2.5*0.08) end},1},},},},
			[1009] = { num = 1,EventTb = {{EventTypeTb.TimerTrigger,3,},},},
			[1010] = { num = 10,EventTb = {{EventTypeTb.MonRefresh,{1,111,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*9) monatt[3] = math.floor(lv^2.2*0.15) monatt[4] = math.floor(lv^2.5*0.05) end},1},},},},
			[1011] = { num = 10,EventTb = {{EventTypeTb.MonRefresh,{1,112,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*9) monatt[3] = math.floor(lv^2.2*0.15) monatt[4] = math.floor(lv^2.5*0.05) end},1},},},},
			[1012] = { num = 10,EventTb = {{EventTypeTb.MonRefresh,{1,113,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*80) monatt[3] = math.floor(lv^2.2*0.4) monatt[4] = math.floor(lv^2.5*0.15) end},1},},},},
			[1013] = { num = 1,EventTb = {{EventTypeTb.TimerTrigger,4,},},},
			[1014] = { num = 10,EventTb = {{EventTypeTb.MonRefresh,{1,115,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*11) monatt[3] = math.floor(lv^2.2*0.2) monatt[4] = math.floor(lv^2.5*0.1) end},1},},},},
			[1015] = { num = 10,EventTb = {{EventTypeTb.MonRefresh,{1,116,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*11) monatt[3] = math.floor(lv^2.2*0.2) monatt[4] = math.floor(lv^2.5*0.1) end},1},},},},
			[1016] = { num = 10,EventTb = {{EventTypeTb.MonRefresh,{1,117,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*120) monatt[3] = math.floor(lv^2.2*0.6) monatt[4] = math.floor(lv^2.5*0.2) end},1},},},},
			[1017] = { num = 1,EventTb = {{EventTypeTb.TimerTrigger,5,},},},
			[1018] = { num = 10,EventTb = {{EventTypeTb.MonRefresh,{1,119,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*15) monatt[3] = math.floor(lv^2.2*0.25) monatt[4] = math.floor(lv^2.5*0.2) end},1},},},},
			[1019] = { num = 10,EventTb = {{EventTypeTb.MonRefresh,{1,120,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*15) monatt[3] = math.floor(lv^2.2*0.25) monatt[4] = math.floor(lv^2.5*0.2) end},1},},},},
			[1020] = { num = 10,EventTb = {{EventTypeTb.MonRefresh,{1,121,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*150) monatt[3] = math.floor(lv^2.2*0.8) monatt[4] = math.floor(lv^2.5*0.4) end},1},},},},
			-- [1021] = { num = 1, EventTb = {{EventTypeTb.MonRefresh,{1,122},},{EventTypeTb.Completion},},},
			[1021] = { num = 1, EventTb = {{EventTypeTb.Completion},},},
		},	
		Timers = {
			[1] = {num = 1,preTime = 1,
				EventTb = {
					{EventTypeTb.MonRefresh,{1,102,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*4) monatt[3] = math.floor(lv^2.2*0.08) monatt[4] = math.floor(lv^2.5*0.03) end},1},},			
				},	
			},
			[2] = {num = 1,timer = 10,
				EventTb = {					
					{EventTypeTb.MonRefresh,{1,106,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*7) monatt[3] = math.floor(lv^2.2*0.1) monatt[4] = math.floor(lv^2.5*0.04) end},1},},
				},	
			},
			[3] = {num = 1,timer = 10,
				EventTb = {					
					{EventTypeTb.MonRefresh,{1,110,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*9) monatt[3] = math.floor(lv^2.2*0.15) monatt[4] = math.floor(lv^2.5*0.05) end},1},},
				},	
			},
			[4] = {num = 1,timer = 10,
				EventTb = {					
					{EventTypeTb.MonRefresh,{1,114,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*11) monatt[3] = math.floor(lv^2.2*0.2) monatt[4] = math.floor(lv^2.5*0.1) end},1},},
				},	
			},
			[5] = {num = 1,timer = 10,
				EventTb = {					
					{EventTypeTb.MonRefresh,{1,118,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*15) monatt[3] = math.floor(lv^2.2*0.25) monatt[4] = math.floor(lv^2.5*0.2) end},1},},
				},	
			},
			[6] = {num = 1,preTime = 600,EventTb = { {EventTypeTb.Failed,},},},
		},	
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 517, 		-- ��ͼ���					
													 
			MonsterList = {				-- �����б�
				[102]={ 				
					{ monsterId = 500, BRMONSTER = 1, deadbody = 6 , centerX = 8 , centerY = 26 , BRArea = 3 , camp = 5,BRNumber =10 ,deadScript =1002},
				}, 
				[103]={ 
					{ monsterId = 500, BRMONSTER = 1, deadbody = 6 , centerX = 16 , centerY = 13 , BRArea = 3 , camp = 5,BRNumber =10 ,deadScript =1003},
		        }, 
				[104]={ 
					{ monsterId = 500, BRMONSTER = 1, deadbody = 6 , centerX = 24 , centerY = 26 , BRArea = 3 , camp = 5,BRNumber =10 ,deadScript =1004},
		        }, 
				[105]={ 
					{ monsterId = 505, deadbody = 6 , x = 15 , y = 22 , camp = 5,deadScript =1005},
		        }, 
			    [106]={  
		            { monsterId = 501, BRMONSTER = 1, deadbody = 6 , centerX = 8 , centerY = 26 , BRArea = 3 , camp = 5,BRNumber =10 ,deadScript =1006},
				}, 
				[107]={ 				
					{ monsterId = 501, BRMONSTER = 1, deadbody = 6 , centerX = 16 , centerY = 13 , BRArea = 3 , camp = 5,BRNumber =10 ,deadScript =1007},
				}, 
				[108]={ 
					{ monsterId = 501, BRMONSTER = 1, deadbody = 6 , centerX = 24 , centerY = 26 , BRArea = 3 , camp = 5,BRNumber =10 ,deadScript =1008},
		        }, 
				[109]={ 
					{ monsterId = 506, deadbody = 6 , x = 15 , y = 22 , camp = 5,deadScript =1009},
		        },	
			    [110]={  
		            { monsterId = 502, BRMONSTER = 1, deadbody = 6 , centerX = 8 , centerY = 26 , BRArea = 3 , camp = 5,BRNumber =10 ,deadScript =1010},
				}, 
				[111]={ 				
					{ monsterId = 502, BRMONSTER = 1, deadbody = 6 , centerX = 16 , centerY = 13 , BRArea = 3 , camp = 5,BRNumber =10 ,deadScript =1011},
				}, 
				[112]={ 
					{ monsterId = 502, BRMONSTER = 1, deadbody = 6 , centerX = 24 , centerY = 26 , BRArea = 3 , camp = 5,BRNumber =10 ,deadScript =1012},
		        }, 
				[113]={ 
					{ monsterId = 507, deadbody = 6 , x = 15 , y = 22 , camp = 5,deadScript =1013},
		        },	
			    [114]={  
		            { monsterId = 503, BRMONSTER = 1, deadbody = 6 , centerX = 8 , centerY = 26 , BRArea = 3 , camp = 5,BRNumber =10 ,deadScript =1014},
				}, 
				[115]={ 				
					{ monsterId = 503, BRMONSTER = 1, deadbody = 6 , centerX = 16 , centerY = 13 , BRArea = 3 , camp = 5,BRNumber =10 ,deadScript =1015},
				}, 
				[116]={ 
					{ monsterId = 503, BRMONSTER = 1, deadbody = 6 , centerX = 24 , centerY = 26 , BRArea = 3 , camp = 5,BRNumber =10 ,deadScript =1016},
		        }, 
				[117]={ 
					{ monsterId = 508, deadbody = 6 , x = 15 , y = 22 , camp = 5,deadScript =1017},
		        },	
			    [118]={  
		            { monsterId = 504, BRMONSTER = 1, deadbody = 6 , centerX = 8 , centerY = 26 , BRArea = 3 , camp = 5,BRNumber =10 ,deadScript =1018},
				}, 
				[119]={ 				
					{ monsterId = 504, BRMONSTER = 1, deadbody = 6 , centerX = 16 , centerY = 13 , BRArea = 3 , camp = 5,BRNumber =10 ,deadScript =1019},
				}, 
				[120]={ 
					{ monsterId = 504, BRMONSTER = 1, deadbody = 6 , centerX = 24 , centerY = 26 , BRArea = 3 , camp = 5,BRNumber =10 ,deadScript =1020},
		        }, 
				[121]={ 
					{ monsterId = 509, deadbody = 6 , x = 15 , y = 22 , camp = 5,deadScript =1021},
		        },			
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 15, y = 22}},		-- �����
			RelivePos = {1,15,22},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
				
	},
}

-----------------------------------------------------------------------------------
FBConfig[11] = {				-- �ڱ�����
}

FBConfig[11][1] = {
	FBName = '�̳Ǹ���',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2049,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 1, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
		},	
		Timers = {
			[1] = {num = 1,preTime = 1,
				EventTb = {
					{EventTypeTb.MonRefresh,{1,102,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*30) monatt[3] = math.floor(lv^2.2*0.1) monatt[4] = math.floor(lv^2.5*0.1) end},1},},			
				},	
			},
		},
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 513, 		-- ��ͼ���					
			
										
			MonsterList = {				-- �����б�
				[102] = {
					{ monsterId = 531 , bossType =1 ,BRMONSTER = 1 ,  centerX = 12 , centerY = 16 , BRArea = 3 , BRNumber =1 , deadScript = 1001},	
				},
				[103] = {	
					{ monsterId = 532 , imageID=1167 ,bossType =1 ,moveArea = 0 ,controlId = 103,IdleTime = 10, x = 14 , y = 19 , eventScript = 203},
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 14, y = 16}},		-- �����
			RelivePos = {1,14,16},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���

		SpecialProc = {
		},
	},
}

--------------------------------------------------------------------------

FBConfig[12] = {				-- VIP����
}

FBConfig[12][1] = {
	FBName = 'VIP����',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2049,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	

	EventList = {
		    MonDeads = {					-- �������������¼��б�
			[10001] = { step = 1, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
		},	

		Timers = {
			[1] = {num = 1,preTime = 1,
				EventTb = {
					{EventTypeTb.MonRefresh,{1,102,{[303] = function(monatt,lv) monatt[1] = math.floor(lv^2*30) monatt[3] = math.floor(lv^2.2*0.1) monatt[4] = math.floor(lv^2.5*0.1) end},1},},			
				},	
			},
		},
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 515, 		-- ��ͼ���					
			
										
			MonsterList = {				-- �����б�
				[102] = {
					{ monsterId = 533 , bossType =1 ,moveArea = 0 , x = 15 , y = 27 ,deadScript = 10001},	
				},
				[103] = {	
					{ monsterId = 534 , bossType =1 ,moveArea = 0 ,controlId = 104, x = 15 , y = 27 ,eventScript = 204},
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 11, y = 23}},		-- �����
			RelivePos = {1,11,23},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 1,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nVIPType = 2,
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���

		SpecialProc = {
		},
	},
}

--------------------------------------------------------------------------
FBConfig[13] = {				-- ����ֵ����
}

FBConfig[13][1] = {
	FBName = '����ֵ��������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2044,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 44,		-- �Ƽ��ȼ�

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 1, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[1003] = { step = 3, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},{EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 500},},},},
			[1004] = { step = 4, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[1005] = { step = 5, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,106},},},},
			[1006] = { step = 6, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,107},},{EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 600},},},},
			[1007] = { step = 7, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,108},},},},
			[1008] = { step = 8, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,109},},},},
			[1009] = { step = 9, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,110},},{EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 700},},},},
			[1010] = { step = 10, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,111},},},},
			[1011] = { step = 11, num = 1, EventTb = { {EventTypeTb.Completion}, {EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 800},},}, },
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},
	},
	
	MapList = {				-- ��ͼ�б�
		[1] = {
			MapID = 1017, 		-- ��ͼ���													
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 537 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 24 , centerY = 11 , BRArea = 4 , BRNumber =6 , deadScript = 1001},	
				},
				[102] = {
					{ monsterId = 537 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 35 , centerY = 12 , BRArea = 4 , BRNumber =6 , deadScript = 1002},	
				},
				[103] = {
					{ monsterId = 540 , monAtt={[1] =230000,[3] =3100,},isboss=1 , x = 35 , y = 12 , deadbody = 6 , deadScript = 1003 },						
				},
				[104] = {	
					{ monsterId = 537 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 22 , centerY = 24 , BRArea = 4 , BRNumber =6 , deadScript = 1004},
				},
				[105] = {	
					{ monsterId = 537 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 9 , centerY = 32 , BRArea = 4 , BRNumber =6 , deadScript = 1005},
				},
				[106] = {
					{ monsterId = 541 , monAtt={[1] =250000,[3] =3300,},isboss=1 , x = 9 , y = 32 , deadbody = 6 , deadScript = 1006 },						
				},
				[107] = {
					{ monsterId = 537 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 17 , centerY = 44 , BRArea = 4 , BRNumber =6 , deadScript = 1007},					
				},
				[108] = {
					{ monsterId = 537 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 18 , centerY = 53 , BRArea = 4 , BRNumber =6 , deadScript = 1008},					
				},
				[109] = {
					{ monsterId = 542 , monAtt={[1] =30000,[3] =3500,},isboss=1 , x = 18 , y = 53 , deadbody = 6 , deadScript = 1009 },						
				},
				[110] = {
					{ monsterId = 537 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 33 , centerY = 54 , BRArea = 4 , BRNumber =6 , deadScript = 1010},					
				},
				[111] = {
					{ monsterId = 543 , monAtt={[1] =34000,[3] =4000,},isboss=1 , x = 35 , y = 35 , deadbody = 6 , deadScript = 1011 },						
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			-- TrapPos = {					-- ������б�
				-- [1001] = {0,28,59,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			-- },			
			EnterPos = {{x = 13, y = 10}},		-- �����
			RelivePos = {1,13,10},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 44,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}

FBConfig[13][2] = {
	FBName = '����ֵ�м�����',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2045,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 48,		-- �Ƽ��ȼ�	
	--StoryID = 1000131,			-- ���븱����������ID ���¼������ľ��飬�ڸ��¼��б����ã�
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 1, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[1003] = { step = 3, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},{EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 900},},},},
			[1004] = { step = 4, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[1005] = { step = 5, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,106},},},},
			[1006] = { step = 6, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,107},},{EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 1000},},},},
			[1007] = { step = 7, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,108},},},},
			[1008] = { step = 8, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,109},},},},
			[1009] = { step = 9, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,110},},{EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 1100},},},},
			[1010] = { step = 10, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,111},},},},
			[1011] = { step = 11, num = 1, EventTb = { {EventTypeTb.Completion},{EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 1200},}, }, },
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},
	},
	
	MapList = {				-- ��ͼ�б�
		[1] = {
			MapID = 1018, 		-- ��ͼ���					
			
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 538 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 33 , centerY = 44 , BRArea = 3 , BRNumber =6 , deadScript = 1001},	
				},
				[102] = {	
					{ monsterId = 538 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 22 , centerY = 50 , BRArea = 3 , BRNumber =6 , deadScript = 1002},
				},
				[103] = {	
					{ monsterId = 544 , monAtt={[1] =400000,[3] =4500,},isboss=1 , x = 22 , y = 50 , deadbody = 6 , deadScript = 1003 },						
				},
				[104] = {
					{ monsterId = 538 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 13 , centerY = 44 , BRArea = 3 , BRNumber =6 , deadScript = 1004},	
				},
				[105] = {	
					{ monsterId = 538 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 7 , centerY = 38 , BRArea = 3 , BRNumber =6 , deadScript = 1005},
				},
				[106] = {	
					{ monsterId = 545 , monAtt={[1] =600000,[3] =5000,},isboss=1 , x = 7 , y = 38 , deadbody = 6 , deadScript = 1006 },						
				},
				[107] = {
					{ monsterId = 538 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 21 , centerY = 31 , BRArea = 3 , BRNumber =6 , deadScript = 1007},	
				},
				[108] = {	
					{ monsterId = 538 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 36 , centerY = 21 , BRArea = 3 , BRNumber =6 , deadScript = 1008},
				},
				[109] = {	
					{ monsterId = 546 , monAtt={[1] =800000,[3] =7000,},isboss=1 , x = 36 , y = 21 , deadbody = 6 , deadScript = 1009 },						
				},
				[110] = {	
					{ monsterId = 538 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 25 , centerY = 22 , BRArea = 3 , BRNumber =6 , deadScript = 1010},
				},
				[111] = {	
					{ monsterId = 547 , monAtt={[1] =1000000,[3] =10000,},isboss=1 , x = 17 , y = 13 , deadbody = 6 , deadScript = 1011 },						
				},				
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			-- TrapPos = {					-- ������б�
				-- [1001] = {0,28,59,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			-- },			
			EnterPos = {{x = 40, y = 50}},		-- �����
			RelivePos = {1,40,50},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 48,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}

FBConfig[13][3] = {
	FBName = '����ֵ�߼�����',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2046,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 52,		-- �Ƽ��ȼ�	
	--StoryID = 1000128,			-- ���븱����������ID ���¼������ľ��飬�ڸ��¼��б����ã�
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 1, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[1003] = { step = 3, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},{EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 1300},},},},
			[1004] = { step = 4, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[1005] = { step = 5, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,106},},},},
			[1006] = { step = 6, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,107},},{EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 1400},},},},
			[1007] = { step = 7, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,108},},},},
			[1008] = { step = 8, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,109},},},},
			[1009] = { step = 9, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,110},},{EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 1500},},},},
			[1010] = { step = 10, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,111},},},},
			[1011] = { step = 11, num = 1, EventTb = { {EventTypeTb.Completion}, {EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 1600},},}, },
		},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1020, 		-- ��ͼ���					
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 539 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 14 , centerY = 16 , BRArea = 3 , BRNumber =6 , deadScript = 1001},	
				},
				[102] = {	
					{ monsterId = 539 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 24 , centerY = 19 , BRArea = 3 , BRNumber =6 , deadScript = 1002},
				},
				[103] = {	
					{ monsterId = 548 , monAtt={[1] =800000,[3] =10000,},isboss=1 , x = 24 , y = 19 , deadbody = 6 , deadScript = 1003 },						
				},
				[104] = {
					{ monsterId = 539 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 17 , centerY = 32 , BRArea = 3 , BRNumber =6 , deadScript = 1004},	
				},
				[105] = {	
					{ monsterId = 539 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 8 , centerY = 42 , BRArea = 3 , BRNumber =6 , deadScript = 1005},
				},
				[106] = {	
					{ monsterId = 548 , monAtt={[1] =1200000,[3] =12000,},isboss=1 , x = 8 , y = 42 , deadbody = 6 , deadScript = 1006 },						
				},
				[107] = {
					{ monsterId = 539 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 6 , centerY = 64 , BRArea = 3 , BRNumber =6 , deadScript = 1007},	
				},
				[108] = {	
					{ monsterId = 539 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 11 , centerY = 79 , BRArea = 3 , BRNumber =6 , deadScript = 1008},
				},
				[109] = {	
					{ monsterId = 548 , monAtt={[1] =1400000,[3] =14000,},isboss=1 , x = 11 , y = 79 , deadbody = 6 , deadScript = 1009 },						
				},
				[110] = {
					{ monsterId = 539 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 22 , centerY = 79 , BRArea = 3 , BRNumber =6 , deadScript = 1010},	
				},
				[111] = {	
					{ monsterId = 548 , monAtt={[1] =1600000,[3] =16000,},isboss=1 , x = 23 , y = 59 , deadbody = 6 , deadScript = 1011 },						
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			-- TrapPos = {					-- ������б�
				-- [1001] = {0,28,59,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			-- },			
			EnterPos = {{x = 7, y = 10}},		-- �����
			RelivePos = {1,7,10},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 52,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}

FBConfig[13][4] = {
	FBName = '����ֵ�߼�����',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2046,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 52,		-- �Ƽ��ȼ�	
	--StoryID = 1000128,			-- ���븱����������ID ���¼������ľ��飬�ڸ��¼��б����ã�
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 1, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[1003] = { step = 3, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},{EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 1700},},},},
			[1004] = { step = 4, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[1005] = { step = 5, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,106},},},},
			[1006] = { step = 6, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,107},},{EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 1800},},},},
			[1007] = { step = 7, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,108},},},},
			[1008] = { step = 8, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,109},},},},
			[1009] = { step = 9, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,110},},{EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 1900},},},},
			[1010] = { step = 10, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,111},},},},
			[1011] = { step = 11, num = 1, EventTb = { {EventTypeTb.Completion}, {EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 2000},},}, },
		},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1020, 		-- ��ͼ���					
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 935 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 14 , centerY = 16 , BRArea = 3 , BRNumber =6 , deadScript = 1001},	
				},
				[102] = {	
					{ monsterId = 935 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 24 , centerY = 19 , BRArea = 3 , BRNumber =6 , deadScript = 1002},
				},
				[103] = {	
					{ monsterId = 936 , monAtt={[1] =1000000,[3] =10000,},isboss=1 , x = 24 , y = 19 , deadbody = 6 , deadScript = 1003 },						
				},
				[104] = {
					{ monsterId = 935 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 17 , centerY = 32 , BRArea = 3 , BRNumber =6 , deadScript = 1004},	
				},
				[105] = {	
					{ monsterId = 935 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 8 , centerY = 42 , BRArea = 3 , BRNumber =6 , deadScript = 1005},
				},
				[106] = {	
					{ monsterId = 936 , monAtt={[1] =1400000,[3] =12000,},isboss=1 , x = 8 , y = 42 , deadbody = 6 , deadScript = 1006 },						
				},
				[107] = {
					{ monsterId = 935 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 6 , centerY = 64 , BRArea = 3 , BRNumber =6 , deadScript = 1007},	
				},
				[108] = {	
					{ monsterId = 935 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 11 , centerY = 79 , BRArea = 3 , BRNumber =6 , deadScript = 1008},
				},
				[109] = {	
					{ monsterId = 936 , monAtt={[1] =1600000,[3] =14000,},isboss=1 , x = 11 , y = 79 , deadbody = 6 , deadScript = 1009 },						
				},
				[110] = {
					{ monsterId = 935 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 22 , centerY = 79 , BRArea = 3 , BRNumber =6 , deadScript = 1010},	
				},
				[111] = {	
					{ monsterId = 936 , monAtt={[1] =1800000,[3] =16000,},isboss=1 , x = 23 , y = 59 , deadbody = 6 , deadScript = 1011 },						
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			-- TrapPos = {					-- ������б�
				-- [1001] = {0,28,59,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			-- },			
			EnterPos = {{x = 7, y = 10}},		-- �����
			RelivePos = {1,7,10},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 55,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}

FBConfig[13][5] = {
	FBName = '����ֵ�߼�����',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2046,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 52,		-- �Ƽ��ȼ�	
	--StoryID = 1000128,			-- ���븱����������ID ���¼������ľ��飬�ڸ��¼��б����ã�
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 1, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[1003] = { step = 3, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},{EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 2000},},},},
			[1004] = { step = 4, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[1005] = { step = 5, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,106},},},},
			[1006] = { step = 6, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,107},},{EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 2200},},},},
			[1007] = { step = 7, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,108},},},},
			[1008] = { step = 8, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,109},},},},
			[1009] = { step = 9, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,110},},{EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 2300},},},},
			[1010] = { step = 10, num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,111},},},},
			[1011] = { step = 11, num = 1, EventTb = { {EventTypeTb.Completion}, {EventTypeTb.UserDefined,{func = 'ud_13001_1',param = 2400},},}, },
		},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1020, 		-- ��ͼ���					
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 935 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 14 , centerY = 16 , BRArea = 3 , BRNumber =6 , deadScript = 1001},	
				},
				[102] = {	
					{ monsterId = 935 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 24 , centerY = 19 , BRArea = 3 , BRNumber =6 , deadScript = 1002},
				},
				[103] = {	
					{ monsterId = 936 , monAtt={[1] =1200000,[3] =10000,},isboss=1 , x = 24 , y = 19 , deadbody = 6 , deadScript = 1003 },						
				},
				[104] = {
					{ monsterId = 935 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 17 , centerY = 32 , BRArea = 3 , BRNumber =6 , deadScript = 1004},	
				},
				[105] = {	
					{ monsterId = 935 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 8 , centerY = 42 , BRArea = 3 , BRNumber =6 , deadScript = 1005},
				},
				[106] = {	
					{ monsterId = 936 , monAtt={[1] =1600000,[3] =12000,},isboss=1 , x = 8 , y = 42 , deadbody = 6 , deadScript = 1006 },						
				},
				[107] = {
					{ monsterId = 935 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 6 , centerY = 64 , BRArea = 3 , BRNumber =6 , deadScript = 1007},	
				},
				[108] = {	
					{ monsterId = 935 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 11 , centerY = 79 , BRArea = 3 , BRNumber =6 , deadScript = 1008},
				},
				[109] = {	
					{ monsterId = 936 , monAtt={[1] =1800000,[3] =14000,},isboss=1 , x = 11 , y = 79 , deadbody = 6 , deadScript = 1009 },						
				},
				[110] = {
					{ monsterId = 935 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 22 , centerY = 79 , BRArea = 3 , BRNumber =6 , deadScript = 1010},	
				},
				[111] = {	
					{ monsterId = 936 , monAtt={[1] =2000000,[3] =16000,},isboss=1 , x = 23 , y = 59 , deadbody = 6 , deadScript = 1011 },						
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			-- TrapPos = {					-- ������б�
				-- [1001] = {0,28,59,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			-- },			
			EnterPos = {{x = 7, y = 10}},		-- �����
			RelivePos = {1,7,10},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 58,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}
--------------------------------------------------------------------------
FBConfig[14] = {				-- ����װ������
}

FBConfig[14][1] = {
	FBName = '����װ������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2046,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 50,		-- �Ƽ��ȼ�	
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 1, num = 15,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 1,EventTb = {{EventTypeTb.TimerTrigger,{1,1},},},},
			[1003] = { step = 4, num = 15,EventTb = {{EventTypeTb.MonRefresh,{2,104},},},},
			[1004] = { step = 5, num = 1,EventTb = {{EventTypeTb.TimerTrigger,{2,1},},},},
			[1005] = { step = 7, num = 15,EventTb = {{EventTypeTb.MonRefresh,{3,106},},},},
			[1006] = { step = 8, num = 1,EventTb = {{EventTypeTb.Completion},},},
		},
		Traps = {						-- ����㴥���¼��б� ����ID��֤����Ψһ ����ֻ�ǵ�ͼΨһ
			[1001] = { step = 3,num = -1, Con = {MonDeads = {[1002] = 0},tip = 1}, EventTb = { {EventTypeTb.JumpMap, 2},{EventTypeTb.MonRefresh,{2,103}},{EventTypeTb.TimerTrigger,2,}, } },
			[1002] = { step = 6,num = -1, Con = {MonDeads = {[1004] = 0},tip = 1}, EventTb = { {EventTypeTb.JumpMap, 3},{EventTypeTb.MonRefresh,{3,105}},{EventTypeTb.TimerTrigger,3,}, } },
		},
		Timers = {
			[1] = {num = 1,preTime = 120,EventTb = { {EventTypeTb.Failed,},},},
			[2] = {num = 1,timer = 120,EventTb = { {EventTypeTb.Failed,},},},
			[3] = {num = 1,timer = 120,EventTb = { {EventTypeTb.Failed,},},},
		},
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1032, 		-- ��ͼ���					
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 553 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 26 , centerY = 38 , BRArea = 6 , BRNumber =15 , deadScript = 1001},	
				},
				[102] = {
					{ monsterId = 562 ,  monAtt={[1] =800000,[3] =9000,},deadbody = 6 , x = 11 , y = 25 , deadScript = 1002},	
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲
			TrapPos = {					-- ������б�
				[1001] = {1,6,20,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			},			
			EnterPos = {{x = 41, y = 53}},		-- �����
			RelivePos = {1,41,53},				-- �����
		},
		[2] = {
		MapID = 1032, 		-- ��ͼ���		
										
			MonsterList = {				-- �����б�
				[103] = {
					{ monsterId = 554 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 26 , centerY = 38 , BRArea = 6 , BRNumber =15 , deadScript = 1003},	
				},
				[104] = {
					{ monsterId = 563 ,  monAtt={[1] =1500000,[3] =12000,},deadbody = 6 , x = 11 , y = 25 , deadScript = 1004},	
				},
            },			
	
			TrapPos = {					-- ������б�
				[1002] = {1,6,20,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			},				
			EnterPos = {{x = 41, y = 53}},		-- �����
			RelivePos = {1,41,53},				-- �����
		},
		[3] = {
		MapID = 1037, 		-- ��ͼ���		
										
			MonsterList = {				-- �����б�
				[105] = {
					{ monsterId = 555 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 26 , centerY = 38 , BRArea = 6 , BRNumber =15 , deadScript = 1005},	
				},
				[106] = {
					{ monsterId = 564 , monAtt={[1] =2000000,[3] =14000,},deadbody = 6 , x = 11 , y = 25 , deadScript = 1006},	
				},
            },			
			
			EnterPos = {{x = 41, y = 53}},		-- �����
			RelivePos = {1,41,53},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 51,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}

FBConfig[14][2] = {
	FBName = '����װ������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2046,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 50,		-- �Ƽ��ȼ�	
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 1, num = 15,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 1,EventTb = {{EventTypeTb.TimerTrigger,{1,1},},},},
			[1003] = { step = 4, num = 15,EventTb = {{EventTypeTb.MonRefresh,{2,104},},},},
			[1004] = { step = 5, num = 1,EventTb = {{EventTypeTb.TimerTrigger,{2,1},},},},
			[1005] = { step = 7, num = 15,EventTb = {{EventTypeTb.MonRefresh,{3,106},},},},
			[1006] = { step = 8, num = 1,EventTb = {{EventTypeTb.Completion},},},
		},
		Traps = {						-- ����㴥���¼��б� ����ID��֤����Ψһ ����ֻ�ǵ�ͼΨһ
			[1001] = { step = 3,num = -1, Con = {MonDeads = {[1002] = 0},tip = 1}, EventTb = { {EventTypeTb.JumpMap, 2},{EventTypeTb.MonRefresh,{2,103}},{EventTypeTb.TimerTrigger,2,}, } },
			[1002] = { step = 6,num = -1, Con = {MonDeads = {[1004] = 0},tip = 1}, EventTb = { {EventTypeTb.JumpMap, 3},{EventTypeTb.MonRefresh,{3,105}},{EventTypeTb.TimerTrigger,3,}, } },
		},
		Timers = {
			[1] = {num = 1,preTime = 120,EventTb = { {EventTypeTb.Failed,},},},
			[2] = {num = 1,timer = 120,EventTb = { {EventTypeTb.Failed,},},},
			[3] = {num = 1,timer = 120,EventTb = { {EventTypeTb.Failed,},},},
		},
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1033, 		-- ��ͼ���					
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 556 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 26 , centerY = 38 , BRArea = 6 , BRNumber =15 , deadScript = 1001},	
				},
				[102] = {
					{ monsterId = 565 ,  monAtt={[1] =1650000,[3] =14000,},deadbody = 6 , x = 11 , y = 25 , deadScript = 1002},	
				},
            },			

			TrapPos = {					-- ������б�
				[1001] = {1,6,20,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			},			
			EnterPos = {{x = 41, y = 53}},		-- �����
			RelivePos = {1,41,53},				-- �����
		},
		[2] = {
		MapID = 1033, 		-- ��ͼ���		
										
			MonsterList = {				-- �����б�
				[103] = {
					{ monsterId = 557 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 26 , centerY = 38 , BRArea = 6 , BRNumber =15 , deadScript = 1003},	
				},
				[104] = {
					{ monsterId = 566 ,  monAtt={[1] =1900000,[3] =16000,},deadbody = 6 , x = 11 , y = 25 , deadScript = 1004},	
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲	
			TrapPos = {					-- ������б�
				[1002] = {1,6,20,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			},				
			EnterPos = {{x = 41, y = 53}},		-- �����
			RelivePos = {1,41,53},				-- �����
		},
		[3] = {
		MapID = 1038, 		-- ��ͼ���		
										
			MonsterList = {				-- �����б�
				[105] = {
					{ monsterId = 558 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 26 , centerY = 38 , BRArea = 6 , BRNumber =15 , deadScript = 1005},	
				},
				[106] = {
					{ monsterId = 567 , monAtt={[1] =2300000,[3] =17000,},deadbody = 6 , x = 11 , y = 25 , deadScript = 1006},	
				},
            },			
			
			EnterPos = {{x = 41, y = 53}},		-- �����
			RelivePos = {1,41,53},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 55,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}

FBConfig[14][3] = {
	FBName = '����װ������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2046,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 50,		-- �Ƽ��ȼ�	
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 1, num = 15,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 1,EventTb = {{EventTypeTb.TimerTrigger,{1,1},},},},
			[1003] = { step = 4, num = 15,EventTb = {{EventTypeTb.MonRefresh,{2,104},},},},
			[1004] = { step = 5, num = 1,EventTb = {{EventTypeTb.TimerTrigger,{2,1},},},},
			[1005] = { step = 7, num = 15,EventTb = {{EventTypeTb.MonRefresh,{3,106},},},},
			[1006] = { step = 8, num = 1,EventTb = {{EventTypeTb.Completion},},},
		},
		Traps = {						-- ����㴥���¼��б� ����ID��֤����Ψһ ����ֻ�ǵ�ͼΨһ
			[1001] = { step = 3,num = -1, Con = {MonDeads = {[1002] = 0},tip = 1}, EventTb = { {EventTypeTb.JumpMap, 2},{EventTypeTb.MonRefresh,{2,103}},{EventTypeTb.TimerTrigger,2,}, } },
			[1002] = { step = 6,num = -1, Con = {MonDeads = {[1004] = 0},tip = 1}, EventTb = { {EventTypeTb.JumpMap, 3},{EventTypeTb.MonRefresh,{3,105}},{EventTypeTb.TimerTrigger,3,}, } },
		},
		Timers = {
			[1] = {num = 1,preTime = 120,EventTb = { {EventTypeTb.Failed,},},},
			[2] = {num = 1,timer = 120,EventTb = { {EventTypeTb.Failed,},},},
			[3] = {num = 1,timer = 120,EventTb = { {EventTypeTb.Failed,},},},
		},
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1034, 		-- ��ͼ���					
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 559 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 26 , centerY = 38 , BRArea = 6 , BRNumber =15 , deadScript = 1001},	
				},
				[102] = {
					{ monsterId = 568 ,  monAtt={[1] =1800000,[3] =17000,},deadbody = 6 , x = 11 , y = 25 , deadScript = 1002},	
				},
            },			

			TrapPos = {					-- ������б�
				[1001] = {1,6,20,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			},			
			EnterPos = {{x = 41, y = 53}},		-- �����
			RelivePos = {1,41,53},				-- �����
		},
		[2] = {
		MapID = 1034, 		-- ��ͼ���		
										
			MonsterList = {				-- �����б�
				[103] = {
					{ monsterId = 560 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 26 , centerY = 38 , BRArea = 6 , BRNumber =15 , deadScript = 1003},	
				},
				[104] = {
					{ monsterId = 569 ,  monAtt={[1] =2500000,[3] =19000,},deadbody = 6 , x = 11 , y = 25 , deadScript = 1004},	
				},
            },			

			TrapPos = {					-- ������б�
				[1002] = {1,6,20,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			},				
			EnterPos = {{x = 41, y = 53}},		-- �����
			RelivePos = {1,41,53},				-- �����
		},
		[3] = {
		MapID = 1039, 		-- ��ͼ���		
										
			MonsterList = {				-- �����б�
				[105] = {
					{ monsterId = 561 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 26 , centerY = 38 , BRArea = 6 , BRNumber =15 , deadScript = 1005},	
				},
				[106] = {
					{ monsterId = 570 , monAtt={[1] =3300000,[3] =25000,},deadbody = 6 , x = 11 , y = 25 , deadScript = 1006},	
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲			
			EnterPos = {{x = 41, y = 53}},		-- �����
			RelivePos = {1,41,53},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 58,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}

FBConfig[14][4] = {
	FBName = '����װ������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2046,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 50,		-- �Ƽ��ȼ�	
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 1, num = 15,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 1,EventTb = {{EventTypeTb.TimerTrigger,{1,1},},},},
			[1003] = { step = 4, num = 15,EventTb = {{EventTypeTb.MonRefresh,{2,104},},},},
			[1004] = { step = 5, num = 1,EventTb = {{EventTypeTb.TimerTrigger,{2,1},},},},
			[1005] = { step = 7, num = 15,EventTb = {{EventTypeTb.MonRefresh,{3,106},},},},
			[1006] = { step = 8, num = 1,EventTb = {{EventTypeTb.Completion},},},
		},
		Traps = {						-- ����㴥���¼��б� ����ID��֤����Ψһ ����ֻ�ǵ�ͼΨһ
			[1001] = { step = 3,num = -1, Con = {MonDeads = {[1002] = 0},tip = 1}, EventTb = { {EventTypeTb.JumpMap, 2},{EventTypeTb.MonRefresh,{2,103}},{EventTypeTb.TimerTrigger,2,}, } },
			[1002] = { step = 6,num = -1, Con = {MonDeads = {[1004] = 0},tip = 1}, EventTb = { {EventTypeTb.JumpMap, 3},{EventTypeTb.MonRefresh,{3,105}},{EventTypeTb.TimerTrigger,3,}, } },
		},
		Timers = {
			[1] = {num = 1,preTime = 120,EventTb = { {EventTypeTb.Failed,},},},
			[2] = {num = 1,timer = 120,EventTb = { {EventTypeTb.Failed,},},},
			[3] = {num = 1,timer = 120,EventTb = { {EventTypeTb.Failed,},},},
		},
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1034, 		-- ��ͼ���					
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 923 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 26 , centerY = 38 , BRArea = 6 , BRNumber =15 , deadScript = 1001},	
				},
				[102] = {
					{ monsterId = 924 ,  monAtt={[1] =4000000,[3] =30000,},deadbody = 6 , x = 11 , y = 25 , deadScript = 1002},	
				},
            },			

			TrapPos = {					-- ������б�
				[1001] = {1,6,20,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			},			
			EnterPos = {{x = 41, y = 53}},		-- �����
			RelivePos = {1,41,53},				-- �����
		},
		[2] = {
		MapID = 1034, 		-- ��ͼ���		
										
			MonsterList = {				-- �����б�
				[103] = {
					{ monsterId = 925 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 26 , centerY = 38 , BRArea = 6 , BRNumber =15 , deadScript = 1003},	
				},
				[104] = {
					{ monsterId = 926 ,  monAtt={[1] =6000000,[3] =30000,},deadbody = 6 , x = 11 , y = 25 , deadScript = 1004},	
				},
            },			

			TrapPos = {					-- ������б�
				[1002] = {1,6,20,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			},				
			EnterPos = {{x = 41, y = 53}},		-- �����
			RelivePos = {1,41,53},				-- �����
		},
		[3] = {
		MapID = 1039, 		-- ��ͼ���		
										
			MonsterList = {				-- �����б�
				[105] = {
					{ monsterId = 927 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 26 , centerY = 38 , BRArea = 6 , BRNumber =15 , deadScript = 1005},	
				},
				[106] = {
					{ monsterId = 928 , monAtt={[1] =8000000,[3] =40000,},deadbody = 6 , x = 11 , y = 25 , deadScript = 1006},	
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲			
			EnterPos = {{x = 41, y = 53}},		-- �����
			RelivePos = {1,41,53},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 68,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}

FBConfig[14][5] = {
	FBName = '����װ������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2046,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	RecommendLV = 50,		-- �Ƽ��ȼ�	
	

	EventList = {
	    MonDeads = {					-- �������������¼��б�
			[1001] = { step = 1, num = 15,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { step = 2, num = 1,EventTb = {{EventTypeTb.TimerTrigger,{1,1},},},},
			[1003] = { step = 4, num = 15,EventTb = {{EventTypeTb.MonRefresh,{2,104},},},},
			[1004] = { step = 5, num = 1,EventTb = {{EventTypeTb.TimerTrigger,{2,1},},},},
			[1005] = { step = 7, num = 15,EventTb = {{EventTypeTb.MonRefresh,{3,106},},},},
			[1006] = { step = 8, num = 1,EventTb = {{EventTypeTb.Completion},},},
		},
		Traps = {						-- ����㴥���¼��б� ����ID��֤����Ψһ ����ֻ�ǵ�ͼΨһ
			[1001] = { step = 3,num = -1, Con = {MonDeads = {[1002] = 0},tip = 1}, EventTb = { {EventTypeTb.JumpMap, 2},{EventTypeTb.MonRefresh,{2,103}},{EventTypeTb.TimerTrigger,2,}, } },
			[1002] = { step = 6,num = -1, Con = {MonDeads = {[1004] = 0},tip = 1}, EventTb = { {EventTypeTb.JumpMap, 3},{EventTypeTb.MonRefresh,{3,105}},{EventTypeTb.TimerTrigger,3,}, } },
		},
		Timers = {
			[1] = {num = 1,preTime = 120,EventTb = { {EventTypeTb.Failed,},},},
			[2] = {num = 1,timer = 120,EventTb = { {EventTypeTb.Failed,},},},
			[3] = {num = 1,timer = 120,EventTb = { {EventTypeTb.Failed,},},},
		},
	},
	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1034, 		-- ��ͼ���					
										
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 929 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 26 , centerY = 38 , BRArea = 6 , BRNumber =15 , deadScript = 1001},	
				},
				[102] = {
					{ monsterId = 930 ,  monAtt={[1] =8000000,[3] =60000,},deadbody = 6 , x = 11 , y = 25 , deadScript = 1002},	
				},
            },			

			TrapPos = {					-- ������б�
				[1001] = {1,6,20,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			},			
			EnterPos = {{x = 41, y = 53}},		-- �����
			RelivePos = {1,41,53},				-- �����
		},
		[2] = {
		MapID = 1034, 		-- ��ͼ���		
										
			MonsterList = {				-- �����б�
				[103] = {
					{ monsterId = 931 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 26 , centerY = 38 , BRArea = 6 , BRNumber =15 , deadScript = 1003},	
				},
				[104] = {
					{ monsterId = 932 ,  monAtt={[1] =10000000,[3] =80000,},deadbody = 6 , x = 11 , y = 25 , deadScript = 1004},	
				},
            },			

			TrapPos = {					-- ������б�
				[1002] = {1,6,20,5}, 	-- x,y,len ò��ֻ֧�������� 0 ����㲻���� 1 ��������
			},				
			EnterPos = {{x = 41, y = 53}},		-- �����
			RelivePos = {1,41,53},				-- �����
		},
		[3] = {
		MapID = 1039, 		-- ��ͼ���		
										
			MonsterList = {				-- �����б�
				[105] = {
					{ monsterId = 933 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 26 , centerY = 38 , BRArea = 6 , BRNumber =15 , deadScript = 1005},	
				},
				[106] = {
					{ monsterId = 934 , monAtt={[1] =12000000,[3] =100000,},deadbody = 6 , x = 11 , y = 25 , deadScript = 1006},	
				},
            },			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲			
			EnterPos = {{x = 41, y = 53}},		-- �����
			RelivePos = {1,41,53},				-- �����
		},
	},		

	NeedConditions = {				-- ������������
		nLevel = 75,					-- ����ȼ�����
		nMoney = 0,					-- ��Ҫ��������
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}
--------------------------------------------------------------------------
FBConfig[15] = {				-- ���޸���
}

FBConfig[15][1] = {
	FBName = '���޸���',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 2,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1040, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 571 , camp= 1,monAtt={[1] =80000,[3] =3000,},searchArea=0,BRMONSTER = 1 ,  deadbody = 6 , centerX = 12 , centerY = 28 , BRArea = 3 , BRNumber =3 , deadScript = 1001},
					{ monsterId = 572 , camp= 2,monAtt={[1] =80000,[3] =3000,},searchArea=0,BRMONSTER = 1 ,  deadbody = 6 , centerX = 19 , centerY = 34 , BRArea = 3 , BRNumber =3 , deadScript = 1001},
				},
				[102]={ 
		            { monsterId = 573 , monAtt={[1] =600000,[3] =5000,},deadbody = 6 ,x = 19 , y = 26 , deadScript = 1002},
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 8, y = 38}},		-- �����
			RelivePos = {1,8,38},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 39,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 100000,
		Money = 10000,		
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 790, CountList = { 5, 5 }, IsBind = 1 },--��Եʯ
			{ Rate = { 1, 10000 }, ItemID = 791, CountList = { 1, 1 }, IsBind = 1 },--ǧ�꺮̶ˮ
		},
	},
}

FBConfig[15][2] = {
	FBName = '���޸���',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 2,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1040, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 574 , camp= 1,monAtt={[1] =200000,[3] =6000,},searchArea=0,BRMONSTER = 1 ,  deadbody = 6 , centerX = 12 , centerY = 28 , BRArea = 3 , BRNumber =3 , deadScript = 1001},
					{ monsterId = 575 , camp= 2,monAtt={[1] =200000,[3] =6000,},searchArea=0,BRMONSTER = 1 ,  deadbody = 6 , centerX = 19 , centerY = 34 , BRArea = 3 , BRNumber =3 , deadScript = 1001},
				},
				[102]={ 
		            { monsterId = 576 , monAtt={[1] =2000000,[3] =10000,},deadbody = 6 ,x = 19 , y = 26 , deadScript = 1002},
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 8, y = 38}},		-- �����
			RelivePos = {1,8,38},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 39,					-- ����ȼ�����
	},
	CSAwards = {					-- �������ؽ���
		Exp = 200000,
		Money = 30000,		
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 790, CountList = { 8, 8 }, IsBind = 1 },--��Եʯ
			{ Rate = { 1, 10000 }, ItemID = 791, CountList = { 2, 2 }, IsBind = 1 },--ǧ�꺮̶ˮ
		},
	},	
}

FBConfig[15][3] = {
	FBName = '���޸���',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 2,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1040, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 577 , camp= 1, monAtt={[1] =320000,[3] =10000,},searchArea=0,BRMONSTER = 1 ,  deadbody = 6 , centerX = 12 , centerY = 28 , BRArea = 3 , BRNumber =3 , deadScript = 1001},
					{ monsterId = 578 , camp= 2, monAtt={[1] =320000,[3] =10000,},searchArea=0,BRMONSTER = 1 ,  deadbody = 6 , centerX = 19 , centerY = 34 , BRArea = 3 , BRNumber =3 , deadScript = 1001},
				},
				[102]={ 
		            { monsterId = 579 , monAtt={[1] =3200000,[3] =16000,},deadbody = 6 ,x = 19 , y = 26 , deadScript = 1002},
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 8, y = 38}},		-- �����
			RelivePos = {1,8,38},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 39,					-- ����ȼ�����
	},
	CSAwards = {					-- �������ؽ���
		Exp = 300000,
		Money = 50000,		
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 790, CountList = { 12, 12 }, IsBind = 1 },--��Եʯ
			{ Rate = { 1, 10000 }, ItemID = 791, CountList = { 3, 3 }, IsBind = 1 },--ǧ�꺮̶ˮ
		},
	},		
}

FBConfig[15][4] = {
	FBName = '���޸���',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 2,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1040, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 577 , camp= 1, monAtt={[1] =700000,[3] =10000,},searchArea=0,BRMONSTER = 1 ,  deadbody = 6 , centerX = 12 , centerY = 28 , BRArea = 3 , BRNumber =3 , deadScript = 1001},
					{ monsterId = 578 , camp= 2, monAtt={[1] =700000,[3] =10000,},searchArea=0,BRMONSTER = 1 ,  deadbody = 6 , centerX = 19 , centerY = 34 , BRArea = 3 , BRNumber =3 , deadScript = 1001},
				},
				[102]={ 
		            { monsterId = 579 , monAtt={[1] =7000000,[3] =16000,},deadbody = 6 ,x = 19 , y = 26 , deadScript = 1002},
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 8, y = 38}},		-- �����
			RelivePos = {1,8,38},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 39,					-- ����ȼ�����
	},
	CSAwards = {					-- �������ؽ���
		Exp = 1000000,
		Money = 500000,		
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 790, CountList = { 24, 24 }, IsBind = 1 },--��Եʯ
			{ Rate = { 1, 10000 }, ItemID = 791, CountList = { 3, 3 }, IsBind = 1 },--ǧ�꺮̶ˮ
		},
	},		
}

FBConfig[15][5] = {
	FBName = '���޸���',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 2,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 6,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[1002] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1040, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 577 , camp= 1, monAtt={[1] =1500000,[3] =10000,},searchArea=0,BRMONSTER = 1 ,  deadbody = 6 , centerX = 12 , centerY = 28 , BRArea = 3 , BRNumber =3 , deadScript = 1001},
					{ monsterId = 578 , camp= 2, monAtt={[1] =1500000,[3] =10000,},searchArea=0,BRMONSTER = 1 ,  deadbody = 6 , centerX = 19 , centerY = 34 , BRArea = 3 , BRNumber =3 , deadScript = 1001},
				},
				[102]={ 
		            { monsterId = 579 , monAtt={[1] =15000000,[3] =16000,},deadbody = 6 ,x = 19 , y = 26 , deadScript = 1002},
		        }, 						
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 8, y = 38}},		-- �����
			RelivePos = {1,8,38},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 39,					-- ����ȼ�����
	},
	CSAwards = {					-- �������ؽ���
		Exp = 1000000,
		Money = 500000,		
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 790, CountList = { 40, 40 }, IsBind = 1 },--��Եʯ
			{ Rate = { 1, 10000 }, ItemID = 791, CountList = { 3, 3 }, IsBind = 1 },--ǧ�꺮̶ˮ
		},
	},		
}
--------------------------------------------------------------------------
FBConfig[16] = {				-- װ�����Ǹ���
}

FBConfig[16][1] = {
	FBName = 'װ�����Ǹ���',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 2,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[8001] = { num = 20,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[8002] = { num = 20,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[8003] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
			[8004] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[8005] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,106},},},},
			[8006] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,107},},},},
			[8007] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1042, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 580, BRMONSTER = 1, monAtt={[1] =4000,[3] =300,},centerX = 7, centerY = 29 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , },
					{ monsterId = 580, BRMONSTER = 1, monAtt={[1] =4000,[3] =300,},centerX = 7, centerY = 13 , IdleTime = 5,targetX = 14, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , }, 	
                    { monsterId = 580, BRMONSTER = 1, monAtt={[1] =4000,[3] =300,},centerX = 23, centerY = 13 , IdleTime = 5,targetX = 16, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , }, 
					{ monsterId = 580, BRMONSTER = 1, monAtt={[1] =4000,[3] =300,},centerX = 23, centerY = 29 , IdleTime = 5,targetX = 16, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , }, 					
				},
				[102]={ 
					{ monsterId = 580, BRMONSTER = 1, monAtt={[1] =6000,[3] =500,},centerX = 7, centerY = 29 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , },
					{ monsterId = 580, BRMONSTER = 1, monAtt={[1] =6000,[3] =500,},centerX = 7, centerY = 13 , IdleTime = 5,targetX = 14, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , }, 	
                    { monsterId = 580, BRMONSTER = 1, monAtt={[1] =6000,[3] =500,},centerX = 23, centerY = 13 , IdleTime = 5,targetX = 16, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , }, 
					{ monsterId = 580, BRMONSTER = 1, monAtt={[1] =6000,[3] =500,},centerX = 23, centerY = 29 , IdleTime = 5,targetX = 16, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , }, 					
				},
				[103]={ 
		            { monsterId = 581 , monAtt={[1] =50000,[3] =2000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8003},
		        }, 	
				[104]={ 
		            { monsterId = 582 , monAtt={[1] =100000,[3] =2500,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8004},
		        }, 	
				[105]={ 
		            { monsterId = 583 , monAtt={[1] =150000,[3] =3000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8005},
		        }, 	
				[106]={ 
		            { monsterId = 584 , monAtt={[1] =200000,[3] =3500,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8006},
		        }, 	
				[107]={ 
		            { monsterId = 585 , monAtt={[1] =250000,[3] =6000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8007},
		        }, 					
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 15, y = 21}},		-- �����
			RelivePos = {1,15,21},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 46,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}

FBConfig[16][2] = {
	FBName = 'װ�����Ǹ���',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 2,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[8001] = { num = 20,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[8002] = { num = 20,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[8003] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
			[8004] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[8005] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,106},},},},
			[8006] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,107},},},},
			[8007] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1042, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 586, BRMONSTER = 1, monAtt={[1] =8000,[3] =1000,},centerX = 7, centerY = 29 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , },
					{ monsterId = 586, BRMONSTER = 1, monAtt={[1] =8000,[3] =1000,},centerX = 7, centerY = 13 , IdleTime = 5,targetX = 14, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , }, 	
                    { monsterId = 586, BRMONSTER = 1, monAtt={[1] =8000,[3] =1000,},centerX = 23, centerY = 13 , IdleTime = 5,targetX = 16, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , }, 
					{ monsterId = 586, BRMONSTER = 1, monAtt={[1] =8000,[3] =1000,},centerX = 23, centerY = 29 , IdleTime = 5,targetX = 16, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , }, 					
				},
				[102]={ 
					{ monsterId = 586, BRMONSTER = 1, monAtt={[1] =12000,[3] =1500,},centerX = 7, centerY = 29 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , },
					{ monsterId = 586, BRMONSTER = 1, monAtt={[1] =12000,[3] =1500,},centerX = 7, centerY = 13 , IdleTime = 5,targetX = 14, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , }, 	
                    { monsterId = 586, BRMONSTER = 1, monAtt={[1] =12000,[3] =1500,},centerX = 23, centerY = 13 , IdleTime = 5,targetX = 16, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , }, 
					{ monsterId = 586, BRMONSTER = 1, monAtt={[1] =12000,[3] =1500,},centerX = 23, centerY = 29 , IdleTime = 5,targetX = 16, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , }, 					
				},
				[103]={ 
		            { monsterId = 587 , monAtt={[1] =250000,[3] =4000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8003},
		        }, 	
				[104]={ 
		            { monsterId = 588 , monAtt={[1] =350000,[3] =5000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8004},
		        }, 	
				[105]={ 
		            { monsterId = 589 , monAtt={[1] =450000,[3] =6000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8005},
		        }, 	
				[106]={ 
		            { monsterId = 590 , monAtt={[1] =550000,[3] =7000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8006},
		        }, 	
				[107]={ 
		            { monsterId = 591 , monAtt={[1] =700000,[3] =11000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8007},
		        }, 					
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 15, y = 21}},		-- �����
			RelivePos = {1,15,21},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 50,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}


FBConfig[16][3] = {
	FBName = 'װ�����Ǹ���',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 2,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[8001] = { num = 20,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[8002] = { num = 20,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[8003] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
			[8004] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[8005] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,106},},},},
			[8006] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,107},},},},
			[8007] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1042, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 592, BRMONSTER = 1, monAtt={[1] =15000,[3] =2000,},centerX = 7, centerY = 29 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , },
					{ monsterId = 592, BRMONSTER = 1, monAtt={[1] =15000,[3] =2000,},centerX = 7, centerY = 13 , IdleTime = 5,targetX = 14, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , }, 	
                    { monsterId = 592, BRMONSTER = 1, monAtt={[1] =15000,[3] =2000,},centerX = 23, centerY = 13 , IdleTime = 5,targetX = 16, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , }, 
					{ monsterId = 592, BRMONSTER = 1, monAtt={[1] =15000,[3] =2000,},centerX = 23, centerY = 29 , IdleTime = 5,targetX = 16, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , }, 					
				},
				[102]={ 
					{ monsterId = 592, BRMONSTER = 1, monAtt={[1] =25000,[3] =4000,},centerX = 7, centerY = 29 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , },
					{ monsterId = 592, BRMONSTER = 1, monAtt={[1] =25000,[3] =4000,},centerX = 7, centerY = 13 , IdleTime = 5,targetX = 14, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , }, 	
                    { monsterId = 592, BRMONSTER = 1, monAtt={[1] =25000,[3] =4000,},centerX = 23, centerY = 13 , IdleTime = 5,targetX = 16, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , }, 
					{ monsterId = 592, BRMONSTER = 1, monAtt={[1] =25000,[3] =4000,},centerX = 23, centerY = 29 , IdleTime = 5,targetX = 16, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , }, 					
				},
				[103]={ 
		            { monsterId = 593 , monAtt={[1] =600000,[3] =8000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8003},
		        }, 	
				[104]={ 
		            { monsterId = 594 , monAtt={[1] =700000,[3] =9000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8004},
		        }, 	
				[105]={ 
		            { monsterId = 595 , monAtt={[1] =800000,[3] =11000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8005},
		        }, 	
				[106]={ 
		            { monsterId = 596 , monAtt={[1] =900000,[3] =13000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8006},
		        }, 	
				[107]={ 
		            { monsterId = 597 , monAtt={[1] =1200000,[3] =21000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8007},
		        }, 					
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 15, y = 21}},		-- �����
			RelivePos = {1,15,21},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 56,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}

FBConfig[16][4] = {
	FBName = 'װ�����Ǹ���',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 2,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[8001] = { num = 20,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[8002] = { num = 20,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[8003] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
			[8004] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[8005] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,106},},},},
			[8006] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,107},},},},
			[8007] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1042, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 899, BRMONSTER = 1, monAtt={[1] =60000,[3] =2000,},centerX = 7, centerY = 29 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , },
					{ monsterId = 899, BRMONSTER = 1, monAtt={[1] =60000,[3] =2000,},centerX = 7, centerY = 13 , IdleTime = 5,targetX = 14, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , }, 	
                    { monsterId = 899, BRMONSTER = 1, monAtt={[1] =60000,[3] =2000,},centerX = 23, centerY = 13 , IdleTime = 5,targetX = 16, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , }, 
					{ monsterId = 899, BRMONSTER = 1, monAtt={[1] =60000,[3] =2000,},centerX = 23, centerY = 29 , IdleTime = 5,targetX = 16, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , }, 					
				},
				[102]={ 
					{ monsterId = 899, BRMONSTER = 1, monAtt={[1] =80000,[3] =4000,},centerX = 7, centerY = 29 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , },
					{ monsterId = 899, BRMONSTER = 1, monAtt={[1] =80000,[3] =4000,},centerX = 7, centerY = 13 , IdleTime = 5,targetX = 14, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , }, 	
                    { monsterId = 899, BRMONSTER = 1, monAtt={[1] =80000,[3] =4000,},centerX = 23, centerY = 13 , IdleTime = 5,targetX = 16, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , }, 
					{ monsterId = 899, BRMONSTER = 1, monAtt={[1] =80000,[3] =4000,},centerX = 23, centerY = 29 , IdleTime = 5,targetX = 16, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , }, 					
				},
				[103]={ 
		            { monsterId = 900 , monAtt={[1] =1800000,[3] =8000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8003},
		        }, 	
				[104]={ 
		            { monsterId = 901 , monAtt={[1] =2100000,[3] =9000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8004},
		        }, 	
				[105]={ 
		            { monsterId = 902 , monAtt={[1] =2400000,[3] =11000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8005},
		        }, 	
				[106]={ 
		            { monsterId = 903 , monAtt={[1] =2700000,[3] =13000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8006},
		        }, 	
				[107]={ 
		            { monsterId = 904 , monAtt={[1] =3600000,[3] =21000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8007},
		        }, 					
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 15, y = 21}},		-- �����
			RelivePos = {1,15,21},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 68,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}

FBConfig[16][5] = {
	FBName = 'װ�����Ǹ���',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 2,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[8001] = { num = 20,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[8002] = { num = 20,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[8003] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
			[8004] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[8005] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,106},},},},
			[8006] = { num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,107},},},},
			[8007] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1042, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 905, BRMONSTER = 1, monAtt={[1] =150000,[3] =2000,},centerX = 7, centerY = 29 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , },
					{ monsterId = 905, BRMONSTER = 1, monAtt={[1] =150000,[3] =2000,},centerX = 7, centerY = 13 , IdleTime = 5,targetX = 14, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , }, 	
                    { monsterId = 905, BRMONSTER = 1, monAtt={[1] =150000,[3] =2000,},centerX = 23, centerY = 13 , IdleTime = 5,targetX = 16, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , }, 
					{ monsterId = 905, BRMONSTER = 1, monAtt={[1] =150000,[3] =2000,},centerX = 23, centerY = 29 , IdleTime = 5,targetX = 16, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8001 , }, 					
				},
				[102]={ 
					{ monsterId = 905, BRMONSTER = 1, monAtt={[1] =200000,[3] =4000,},centerX = 7, centerY = 29 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , },
					{ monsterId = 905, BRMONSTER = 1, monAtt={[1] =200000,[3] =4000,},centerX = 7, centerY = 13 , IdleTime = 5,targetX = 14, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , }, 	
                    { monsterId = 905, BRMONSTER = 1, monAtt={[1] =200000,[3] =4000,},centerX = 23, centerY = 13 , IdleTime = 5,targetX = 16, targetY = 20,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , }, 
					{ monsterId = 905, BRMONSTER = 1, monAtt={[1] =200000,[3] =4000,},centerX = 23, centerY = 29 , IdleTime = 5,targetX = 16, targetY = 22,BRArea = 1 , BRNumber =5 , deadbody = 3 ,deadScript = 8002 , }, 					
				},
				[103]={ 
		            { monsterId = 906 , monAtt={[1] =9600000,[3] =8000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8003},
		        }, 	
				[104]={ 
		            { monsterId = 907 , monAtt={[1] =11200000,[3] =9000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8004},
		        }, 	
				[105]={ 
		            { monsterId = 908 , monAtt={[1] =13600000,[3] =11000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8005},
		        }, 	
				[106]={ 
		            { monsterId = 909 , monAtt={[1] =15600000,[3] =13000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8006},
		        }, 	
				[107]={ 
		            { monsterId = 910 , monAtt={[1] =18200000,[3] =21000,},deadbody = 6 ,x = 13 , y = 21 , deadScript = 8007},
		        }, 					
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 15, y = 21}},		-- �����
			RelivePos = {1,15,21},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}
--------------------------------------------------------------------------
FBConfig[17] = {				-- Ԫ�񸱱�
}

FBConfig[17][1] = {
	FBName = 'Ԫ�񸱱�',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 616, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 120,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 524, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [102]={ 
					{ monsterId = 616, BRMONSTER = 1,centerX = 20, centerY = 24 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =1 , deadbody = 3 ,deadScript = 1001 , },
				},		
			},				
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 13, y = 28}},		-- �����
			RelivePos = {1,13,28},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 50,					-- ����ȼ�����
	},	

	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,		
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 812, CountList = { 30, 30 }, IsBind = 1 },--Ԫ����Ƭ
		},
	},
}

FBConfig[17][2] = {
	FBName = 'Ԫ�񸱱�',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 617, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 120,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 524, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [102]={ 
					{ monsterId = 617, BRMONSTER = 1,centerX = 20, centerY = 24 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =1 , deadbody = 3 ,deadScript = 1001 , },
				},		
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 13, y = 28}},		-- �����
			RelivePos = {1,13,28},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 50,					-- ����ȼ�����
	},	
 
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,		
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 812, CountList = { 31, 31 }, IsBind = 1 },--Ԫ����Ƭ
		},
	},
}

FBConfig[17][3] = {
	FBName = 'Ԫ�񸱱�',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 618, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 120,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 524, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [102]={ 
					{ monsterId = 618, BRMONSTER = 1,centerX = 20, centerY = 24 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =1 , deadbody = 3 ,deadScript = 1001 , },
				},		
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 13, y = 28}},		-- �����
			RelivePos = {1,13,28},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 50,					-- ����ȼ�����
	},	
 
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,		
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 812, CountList = { 32, 32 }, IsBind = 1 },--Ԫ����Ƭ
		},
	},
}

FBConfig[17][4] = {
	FBName = 'Ԫ�񸱱�',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 619, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 120,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 524, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [102]={ 
					{ monsterId = 619, BRMONSTER = 1,centerX = 20, centerY = 24 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =1 , deadbody = 3 ,deadScript = 1001 , },
				},		
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 13, y = 28}},		-- �����
			RelivePos = {1,13,28},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 50,					-- ����ȼ�����
	},	
 
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,		
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 812, CountList = { 33, 33 }, IsBind = 1 },--Ԫ����Ƭ
		},
	},
}

FBConfig[17][5] = {
	FBName = 'Ԫ�񸱱�',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 620, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 120,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 524, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [102]={ 
					{ monsterId = 620, BRMONSTER = 1,centerX = 20, centerY = 24 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =1 , deadbody = 3 ,deadScript = 1001 , },
				},		
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 13, y = 28}},		-- �����
			RelivePos = {1,13,28},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 50,					-- ����ȼ�����
	},	
 
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,		
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 812, CountList = { 34, 34 }, IsBind = 1 },--Ԫ����Ƭ
		},
	},
}

FBConfig[17][6] = {
	FBName = 'Ԫ�񸱱�',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 621, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 120,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 524, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [102]={ 
					{ monsterId = 621, BRMONSTER = 1,centerX = 20, centerY = 24 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =1 , deadbody = 3 ,deadScript = 1001 , },
				},		
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 13, y = 28}},		-- �����
			RelivePos = {1,13,28},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 50,					-- ����ȼ�����
	},	
 
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,		
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 812, CountList = { 35, 35 }, IsBind = 1 },--Ԫ����Ƭ
		},
	},
}

FBConfig[17][7] = {
	FBName = 'Ԫ�񸱱�',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 622, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 120,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 524, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [102]={ 
					{ monsterId = 622, BRMONSTER = 1,centerX = 20, centerY = 24 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =1 , deadbody = 3 ,deadScript = 1001 , },
				},		
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 13, y = 28}},		-- �����
			RelivePos = {1,13,28},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 50,					-- ����ȼ�����
	},	
 
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,		
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 812, CountList = { 36, 36 }, IsBind = 1 },--Ԫ����Ƭ
		},
	},
}

FBConfig[17][8] = {
	FBName = 'Ԫ�񸱱�',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 623,624,625, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 3, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 120,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 524, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 623, BRMONSTER = 1,centerX = 20, centerY = 24 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =1 , deadbody = 3 ,deadScript = 1001 , },
					{ monsterId = 624, BRMONSTER = 1,centerX = 20, centerY = 24 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =1 , deadbody = 3 ,deadScript = 1001 , },
					{ monsterId = 625, BRMONSTER = 1,centerX = 20, centerY = 24 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =1 , deadbody = 3 ,deadScript = 1001 , },
					},		
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 13, y = 28}},		-- �����
			RelivePos = {1,13,28},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 50,					-- ����ȼ�����
	},	
 
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,		
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 812, CountList = { 37, 37 }, IsBind = 1 },--Ԫ����Ƭ
		},
	},
}

FBConfig[17][9] = {
	FBName = 'Ԫ�񸱱�',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 626,627,628, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 3, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 120,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 524, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 626, BRMONSTER = 1,centerX = 20, centerY = 24 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =1 , deadbody = 3 ,deadScript = 1001 , },
					{ monsterId = 627, BRMONSTER = 1,centerX = 20, centerY = 24 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =1 , deadbody = 3 ,deadScript = 1001 , },
					{ monsterId = 628, BRMONSTER = 1,centerX = 20, centerY = 24 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =1 , deadbody = 3 ,deadScript = 1001 , },
					},		
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 13, y = 28}},		-- �����
			RelivePos = {1,13,28},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 50,					-- ����ȼ�����
	},	
 
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,		
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 812, CountList = { 38, 38 }, IsBind = 1 },--Ԫ����Ƭ
		},
	},
}
FBConfig[17][10] = {
	FBName = 'Ԫ�񸱱�',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 629,630,631, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 3, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 120,EventTb = { {EventTypeTb.Failed,},},},
		},		
	},	
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 524, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ monsterId = 629, BRMONSTER = 1,centerX = 20, centerY = 24 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =1 , deadbody = 3 ,deadScript = 1001 , },
					{ monsterId = 630, BRMONSTER = 1,centerX = 20, centerY = 24 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =1 , deadbody = 3 ,deadScript = 1001 , },
					{ monsterId = 631, BRMONSTER = 1,centerX = 20, centerY = 24 , IdleTime = 5,targetX = 14, targetY = 22,BRArea = 1 , BRNumber =1 , deadbody = 3 ,deadScript = 1001 , },
					},		
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 13, y = 28}},		-- �����
			RelivePos = {1,13,28},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 50,					-- ����ȼ�����
	},	
 
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,		
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 812, CountList = { 39, 39 }, IsBind = 1 },--Ԫ����Ƭ
		},
	},
}


--------------------------------------------------------------------------
FBConfig[18] = {				-- ������ս����
}

FBConfig[18][1] = {
	FBName = '������ս����',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2233,			-- Сͼ�꣨����
	MaxPlayer = 2,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID
		
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,102,nil,2},},{EventTypeTb.TimerTrigger,2},{EventTypeTb.TimerTrigger,{1,1},},},},
			[1002]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,103,nil,3},},{EventTypeTb.TimerTrigger,3},{EventTypeTb.TimerTrigger,{2,1},},},},
			[1003]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,104,nil,4},},{EventTypeTb.TimerTrigger,4},{EventTypeTb.TimerTrigger,{3,1},},},},
			[1004]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,105,nil,5},},{EventTypeTb.TimerTrigger,5},{EventTypeTb.TimerTrigger,{4,1},},},},
			[1005]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,106,nil,6},},{EventTypeTb.TimerTrigger,6},{EventTypeTb.TimerTrigger,{5,1},},},},
			[1006]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,107,nil,7},},{EventTypeTb.TimerTrigger,7},{EventTypeTb.TimerTrigger,{6,1},},},},
			[1007]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,108,nil,8},},{EventTypeTb.TimerTrigger,8},{EventTypeTb.TimerTrigger,{7,1},},},},
			[1008]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,109,nil,9},},{EventTypeTb.TimerTrigger,9},{EventTypeTb.TimerTrigger,{8,1},},},},
			[1009]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,110,nil,10},},{EventTypeTb.TimerTrigger,10},{EventTypeTb.TimerTrigger,{9,1},},},},
			[1010]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,111,nil,11},},{EventTypeTb.TimerTrigger,11},{EventTypeTb.TimerTrigger,{10,1},},},},
			[1011]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,112,nil,12},},{EventTypeTb.TimerTrigger,12},{EventTypeTb.TimerTrigger,{11,1},},},},
			[1012]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,113,nil,13},},{EventTypeTb.TimerTrigger,13},{EventTypeTb.TimerTrigger,{12,1},},},},
			[1013]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,114,nil,14},},{EventTypeTb.TimerTrigger,14},{EventTypeTb.TimerTrigger,{13,1},},},},
			[1014]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,115,nil,15},},{EventTypeTb.TimerTrigger,15},{EventTypeTb.TimerTrigger,{14,1},},},},
			[1015]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,116,nil,16},},{EventTypeTb.TimerTrigger,16},{EventTypeTb.TimerTrigger,{15,1},},},},
			[1016]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,117,nil,17},},{EventTypeTb.TimerTrigger,17},{EventTypeTb.TimerTrigger,{16,1},},},},
			[1017]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,118,nil,18},},{EventTypeTb.TimerTrigger,18},{EventTypeTb.TimerTrigger,{17,1},},},},
			[1018]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,119,nil,19},},{EventTypeTb.TimerTrigger,19},{EventTypeTb.TimerTrigger,{18,1},},},},
			[1019]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,120,nil,20},},{EventTypeTb.TimerTrigger,20},{EventTypeTb.TimerTrigger,{19,1},},},},
			[1020]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,121,nil,21},},{EventTypeTb.TimerTrigger,21},{EventTypeTb.TimerTrigger,{20,1},},},},
			[1021]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,122,nil,22},},{EventTypeTb.TimerTrigger,22},{EventTypeTb.TimerTrigger,{21,1},},},},
			[1022]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,123,nil,23},},{EventTypeTb.TimerTrigger,23},{EventTypeTb.TimerTrigger,{22,1},},},},
			[1023]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,124,nil,24},},{EventTypeTb.TimerTrigger,24},{EventTypeTb.TimerTrigger,{23,1},},},},
			[1024]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,125,nil,25},},{EventTypeTb.TimerTrigger,25},{EventTypeTb.TimerTrigger,{24,1},},},},
			[1025]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,126,nil,26},},{EventTypeTb.TimerTrigger,26},{EventTypeTb.TimerTrigger,{25,1},},},},
			[1026]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,127,nil,27},},{EventTypeTb.TimerTrigger,27},{EventTypeTb.TimerTrigger,{26,1},},},},
			[1027]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,128,nil,28},},{EventTypeTb.TimerTrigger,28},{EventTypeTb.TimerTrigger,{27,1},},},},
			[1028]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,129,nil,29},},{EventTypeTb.TimerTrigger,29},{EventTypeTb.TimerTrigger,{28,1},},},},
			[1029]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,130,nil,30},},{EventTypeTb.TimerTrigger,30},{EventTypeTb.TimerTrigger,{29,1},},},},
			[1030]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,131,nil,31},},{EventTypeTb.TimerTrigger,31},{EventTypeTb.TimerTrigger,{30,1},},},},
			[1031]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,132,nil,32},},{EventTypeTb.TimerTrigger,32},{EventTypeTb.TimerTrigger,{31,1},},},},
			[1032]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,133,nil,33},},{EventTypeTb.TimerTrigger,33},{EventTypeTb.TimerTrigger,{32,1},},},},
			[1033]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,134,nil,34},},{EventTypeTb.TimerTrigger,34},{EventTypeTb.TimerTrigger,{33,1},},},},
			[1034]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,135,nil,35},},{EventTypeTb.TimerTrigger,35},{EventTypeTb.TimerTrigger,{34,1},},},},
			[1035]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,136,nil,36},},{EventTypeTb.TimerTrigger,36},{EventTypeTb.TimerTrigger,{35,1},},},},
			[1036]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,137,nil,37},},{EventTypeTb.TimerTrigger,37},{EventTypeTb.TimerTrigger,{36,1},},},},
			[1037]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,138,nil,38},},{EventTypeTb.TimerTrigger,38},{EventTypeTb.TimerTrigger,{37,1},},},},
			[1038]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,139,nil,39},},{EventTypeTb.TimerTrigger,39},{EventTypeTb.TimerTrigger,{38,1},},},},
			[1039]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,140,nil,40},},{EventTypeTb.TimerTrigger,40},{EventTypeTb.TimerTrigger,{39,1},},},},
			[1040]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,141,nil,41},},{EventTypeTb.TimerTrigger,41},{EventTypeTb.TimerTrigger,{40,1},},},},
			[1041]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,142,nil,42},},{EventTypeTb.TimerTrigger,42},{EventTypeTb.TimerTrigger,{41,1},},},},
			[1042]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,143,nil,43},},{EventTypeTb.TimerTrigger,43},{EventTypeTb.TimerTrigger,{42,1},},},},
			[1043]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,144,nil,44},},{EventTypeTb.TimerTrigger,44},{EventTypeTb.TimerTrigger,{43,1},},},},
			[1044]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,145,nil,45},},{EventTypeTb.TimerTrigger,45},{EventTypeTb.TimerTrigger,{44,1},},},},
			[1045]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,146,nil,46},},{EventTypeTb.TimerTrigger,46},{EventTypeTb.TimerTrigger,{45,1},},},},
			[1046]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,147,nil,47},},{EventTypeTb.TimerTrigger,47},{EventTypeTb.TimerTrigger,{46,1},},},},
			[1047]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,148,nil,48},},{EventTypeTb.TimerTrigger,48},{EventTypeTb.TimerTrigger,{47,1},},},},
			[1048]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,149,nil,49},},{EventTypeTb.TimerTrigger,49},{EventTypeTb.TimerTrigger,{48,1},},},},
			[1049]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,150,nil,50},},{EventTypeTb.TimerTrigger,50},{EventTypeTb.TimerTrigger,{49,1},},},},
			[1050]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,151,nil,51},},{EventTypeTb.TimerTrigger,51},{EventTypeTb.TimerTrigger,{50,1},},},},
			[1051]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,152,nil,52},},{EventTypeTb.TimerTrigger,52},{EventTypeTb.TimerTrigger,{51,1},},},},
			[1052]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,153,nil,53},},{EventTypeTb.TimerTrigger,53},{EventTypeTb.TimerTrigger,{52,1},},},},
			[1053]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,154,nil,54},},{EventTypeTb.TimerTrigger,54},{EventTypeTb.TimerTrigger,{53,1},},},},
			[1054]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,155,nil,55},},{EventTypeTb.TimerTrigger,55},{EventTypeTb.TimerTrigger,{54,1},},},},
			[1055]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,156,nil,56},},{EventTypeTb.TimerTrigger,56},{EventTypeTb.TimerTrigger,{55,1},},},},
			[1056]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,157,nil,57},},{EventTypeTb.TimerTrigger,57},{EventTypeTb.TimerTrigger,{56,1},},},},
			[1057]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,158,nil,58},},{EventTypeTb.TimerTrigger,58},{EventTypeTb.TimerTrigger,{57,1},},},},
			[1058]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,159,nil,59},},{EventTypeTb.TimerTrigger,59},{EventTypeTb.TimerTrigger,{58,1},},},},
			[1059]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,160,nil,60},},{EventTypeTb.TimerTrigger,60},{EventTypeTb.TimerTrigger,{59,1},},},},
			[1060]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,161,nil,61},},{EventTypeTb.TimerTrigger,61},{EventTypeTb.TimerTrigger,{60,1},},},},
			[1061]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,162,nil,62},},{EventTypeTb.TimerTrigger,62},{EventTypeTb.TimerTrigger,{61,1},},},},
			[1062]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,163,nil,63},},{EventTypeTb.TimerTrigger,63},{EventTypeTb.TimerTrigger,{62,1},},},},
			[1063]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,164,nil,64},},{EventTypeTb.TimerTrigger,64},{EventTypeTb.TimerTrigger,{63,1},},},},
			[1064]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,165,nil,65},},{EventTypeTb.TimerTrigger,65},{EventTypeTb.TimerTrigger,{64,1},},},},
			[1065]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,166,nil,66},},{EventTypeTb.TimerTrigger,66},{EventTypeTb.TimerTrigger,{65,1},},},},
			[1066]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,167,nil,67},},{EventTypeTb.TimerTrigger,67},{EventTypeTb.TimerTrigger,{66,1},},},},
			[1067]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,168,nil,68},},{EventTypeTb.TimerTrigger,68},{EventTypeTb.TimerTrigger,{67,1},},},},
			[1068]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,169,nil,69},},{EventTypeTb.TimerTrigger,69},{EventTypeTb.TimerTrigger,{68,1},},},},
			[1069]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,170,nil,70},},{EventTypeTb.TimerTrigger,70},{EventTypeTb.TimerTrigger,{69,1},},},},
			[1070]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,171,nil,71},},{EventTypeTb.TimerTrigger,71},{EventTypeTb.TimerTrigger,{70,1},},},},
			[1071]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,172,nil,72},},{EventTypeTb.TimerTrigger,72},{EventTypeTb.TimerTrigger,{71,1},},},},
			[1072]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,173,nil,73},},{EventTypeTb.TimerTrigger,73},{EventTypeTb.TimerTrigger,{72,1},},},},
			[1073]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,174,nil,74},},{EventTypeTb.TimerTrigger,74},{EventTypeTb.TimerTrigger,{73,1},},},},
			[1074]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,175,nil,75},},{EventTypeTb.TimerTrigger,75},{EventTypeTb.TimerTrigger,{74,1},},},},
			[1075]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,176,nil,76},},{EventTypeTb.TimerTrigger,76},{EventTypeTb.TimerTrigger,{75,1},},},},
			[1076]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,177,nil,77},},{EventTypeTb.TimerTrigger,77},{EventTypeTb.TimerTrigger,{76,1},},},},
			[1077]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,178,nil,78},},{EventTypeTb.TimerTrigger,78},{EventTypeTb.TimerTrigger,{77,1},},},},
			[1078]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,179,nil,79},},{EventTypeTb.TimerTrigger,79},{EventTypeTb.TimerTrigger,{78,1},},},},
			[1079]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,180,nil,80},},{EventTypeTb.TimerTrigger,80},{EventTypeTb.TimerTrigger,{79,1},},},},
			[1080]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,181,nil,81},},{EventTypeTb.TimerTrigger,81},{EventTypeTb.TimerTrigger,{80,1},},},},
			[1081]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,182,nil,82},},{EventTypeTb.TimerTrigger,82},{EventTypeTb.TimerTrigger,{81,1},},},},
			[1082]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,183,nil,83},},{EventTypeTb.TimerTrigger,83},{EventTypeTb.TimerTrigger,{82,1},},},},
			[1083]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,184,nil,84},},{EventTypeTb.TimerTrigger,84},{EventTypeTb.TimerTrigger,{83,1},},},},
			[1084]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,185,nil,85},},{EventTypeTb.TimerTrigger,85},{EventTypeTb.TimerTrigger,{84,1},},},},
			[1085]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,186,nil,86},},{EventTypeTb.TimerTrigger,86},{EventTypeTb.TimerTrigger,{85,1},},},},
			[1086]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,187,nil,87},},{EventTypeTb.TimerTrigger,87},{EventTypeTb.TimerTrigger,{86,1},},},},
			[1087]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,188,nil,88},},{EventTypeTb.TimerTrigger,88},{EventTypeTb.TimerTrigger,{87,1},},},},
			[1088]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,189,nil,89},},{EventTypeTb.TimerTrigger,89},{EventTypeTb.TimerTrigger,{88,1},},},},
			[1089]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,190,nil,90},},{EventTypeTb.TimerTrigger,90},{EventTypeTb.TimerTrigger,{89,1},},},},
			[1090]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,191,nil,91},},{EventTypeTb.TimerTrigger,91},{EventTypeTb.TimerTrigger,{90,1},},},},
			[1091]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,192,nil,92},},{EventTypeTb.TimerTrigger,92},{EventTypeTb.TimerTrigger,{91,1},},},},
			[1092]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,193,nil,93},},{EventTypeTb.TimerTrigger,93},{EventTypeTb.TimerTrigger,{92,1},},},},
			[1093]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,194,nil,94},},{EventTypeTb.TimerTrigger,94},{EventTypeTb.TimerTrigger,{93,1},},},},
			[1094]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,195,nil,95},},{EventTypeTb.TimerTrigger,95},{EventTypeTb.TimerTrigger,{94,1},},},},
			[1095]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,196,nil,96},},{EventTypeTb.TimerTrigger,96},{EventTypeTb.TimerTrigger,{95,1},},},},
			[1096]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,197,nil,97},},{EventTypeTb.TimerTrigger,97},{EventTypeTb.TimerTrigger,{96,1},},},},
			[1097]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,198,nil,98},},{EventTypeTb.TimerTrigger,98},{EventTypeTb.TimerTrigger,{97,1},},},},
			[1098]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,199,nil,99},},{EventTypeTb.TimerTrigger,99},{EventTypeTb.TimerTrigger,{98,1},},},},
			[1099]={ num=20,EventTb={{EventTypeTb.MonRefresh,{1,200,nil,100},},{EventTypeTb.TimerTrigger,100},{EventTypeTb.TimerTrigger,{99,1},},},},

			[1100]={ num=20,EventTb={{EventTypeTb.Completion},},},
			[9999] = { num = 1,EventTb = { {EventTypeTb.Failed}, } },
		},	
		Timers = {
			[1]={num=1,preTime=60,EventTb = { {EventTypeTb.Failed,},},},
			[2]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[3]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[4]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[5]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[6]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[7]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[8]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[9]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[10]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[11]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[12]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[13]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[14]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[15]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[16]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[17]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[18]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[19]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[20]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[21]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[22]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[23]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[24]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[25]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[26]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[27]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[28]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[29]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[30]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[31]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[32]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[33]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[34]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[35]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[36]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[37]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[38]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[39]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[40]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[41]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[42]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[43]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[44]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[45]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[46]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[47]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[48]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[49]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[50]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[51]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[52]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[53]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[54]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[55]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[56]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[57]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[58]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[59]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[60]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[61]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[62]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[63]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[64]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[65]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[66]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[67]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[68]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[69]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[70]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[71]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[72]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[73]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[74]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[75]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[76]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[77]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[78]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[79]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[80]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[81]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[82]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[83]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[84]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[85]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[86]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[87]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[88]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[89]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[90]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[91]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[92]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[93]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[94]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[95]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[96]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[97]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[98]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[99]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},
			[100]={num=1,timer=60,EventTb = { {EventTypeTb.Failed,},},},

			
		},		
	},	

	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 1044, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			    [101]={ 
					{ name = '槼�', mapIcon = 1 , monAtt={[1] =150000,[4] = 99999999},monsterId = 337,x = 47,y = 16,camp = 4,deadScript = 9999,},								
					{ monsterId = 632, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript = 1001 ,camp = 5, },
					{ monsterId = 632, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript = 1001 ,camp = 5, }, 	
                     					
				},
				[102]={
					{ monsterId =633, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1002,camp=5},
					{ monsterId =633, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1002,camp=5},
					},[103]={
					{ monsterId =634, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1003,camp=5},
					{ monsterId =634, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1003,camp=5},
					},[104]={
					{ monsterId =635, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1004,camp=5},
					{ monsterId =635, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1004,camp=5},
					},[105]={
					{ monsterId =636, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1005,camp=5},
					{ monsterId =636, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1005,camp=5},
					},[106]={
					{ monsterId =637, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1006,camp=5},
					{ monsterId =637, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1006,camp=5},
					},[107]={
					{ monsterId =638, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1007,camp=5},
					{ monsterId =638, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1007,camp=5},
					},[108]={
					{ monsterId =639, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1008,camp=5},
					{ monsterId =639, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1008,camp=5},
					},[109]={
					{ monsterId =640, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1009,camp=5},
					{ monsterId =640, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1009,camp=5},
					},[110]={
					{ monsterId =641, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1010,camp=5},
					{ monsterId =641, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1010,camp=5},
					},[111]={
					{ monsterId =642, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1011,camp=5},
					{ monsterId =642, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1011,camp=5},
					},[112]={
					{ monsterId =643, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1012,camp=5},
					{ monsterId =643, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1012,camp=5},
					},[113]={
					{ monsterId =644, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1013,camp=5},
					{ monsterId =644, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1013,camp=5},
					},[114]={
					{ monsterId =645, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1014,camp=5},
					{ monsterId =645, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1014,camp=5},
					},[115]={
					{ monsterId =646, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1015,camp=5},
					{ monsterId =646, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1015,camp=5},
					},[116]={
					{ monsterId =647, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1016,camp=5},
					{ monsterId =647, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1016,camp=5},
					},[117]={
					{ monsterId =648, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1017,camp=5},
					{ monsterId =648, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1017,camp=5},
					},[118]={
					{ monsterId =649, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1018,camp=5},
					{ monsterId =649, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1018,camp=5},
					},[119]={
					{ monsterId =650, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1019,camp=5},
					{ monsterId =650, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1019,camp=5},
					},[120]={
					{ monsterId =651, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1020,camp=5},
					{ monsterId =651, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1020,camp=5},
					},[121]={
					{ monsterId =652, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1021,camp=5},
					{ monsterId =652, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1021,camp=5},
					},[122]={
					{ monsterId =653, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1022,camp=5},
					{ monsterId =653, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1022,camp=5},
					},[123]={
					{ monsterId =654, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1023,camp=5},
					{ monsterId =654, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1023,camp=5},
					},[124]={
					{ monsterId =655, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1024,camp=5},
					{ monsterId =655, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1024,camp=5},
					},[125]={
					{ monsterId =656, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1025,camp=5},
					{ monsterId =656, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1025,camp=5},
					},[126]={
					{ monsterId =657, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1026,camp=5},
					{ monsterId =657, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1026,camp=5},
					},[127]={
					{ monsterId =658, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1027,camp=5},
					{ monsterId =658, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1027,camp=5},
					},[128]={
					{ monsterId =659, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1028,camp=5},
					{ monsterId =659, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1028,camp=5},
					},[129]={
					{ monsterId =660, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1029,camp=5},
					{ monsterId =660, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1029,camp=5},
					},[130]={
					{ monsterId =661, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1030,camp=5},
					{ monsterId =661, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1030,camp=5},
					},[131]={
					{ monsterId =662, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1031,camp=5},
					{ monsterId =662, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1031,camp=5},
					},[132]={
					{ monsterId =663, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1032,camp=5},
					{ monsterId =663, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1032,camp=5},
					},[133]={
					{ monsterId =664, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1033,camp=5},
					{ monsterId =664, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1033,camp=5},
					},[134]={
					{ monsterId =665, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1034,camp=5},
					{ monsterId =665, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1034,camp=5},
					},[135]={
					{ monsterId =666, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1035,camp=5},
					{ monsterId =666, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1035,camp=5},
					},[136]={
					{ monsterId =667, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1036,camp=5},
					{ monsterId =667, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1036,camp=5},
					},[137]={
					{ monsterId =668, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1037,camp=5},
					{ monsterId =668, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1037,camp=5},
					},[138]={
					{ monsterId =669, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1038,camp=5},
					{ monsterId =669, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1038,camp=5},
					},[139]={
					{ monsterId =670, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1039,camp=5},
					{ monsterId =670, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1039,camp=5},
					},[140]={
					{ monsterId =671, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1040,camp=5},
					{ monsterId =671, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1040,camp=5},
					},[141]={
					{ monsterId =672, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1041,camp=5},
					{ monsterId =672, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1041,camp=5},
					},[142]={
					{ monsterId =673, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1042,camp=5},
					{ monsterId =673, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1042,camp=5},
					},[143]={
					{ monsterId =674, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1043,camp=5},
					{ monsterId =674, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1043,camp=5},
					},[144]={
					{ monsterId =675, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1044,camp=5},
					{ monsterId =675, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1044,camp=5},
					},[145]={
					{ monsterId =676, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1045,camp=5},
					{ monsterId =676, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1045,camp=5},
					},[146]={
					{ monsterId =677, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1046,camp=5},
					{ monsterId =677, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1046,camp=5},
					},[147]={
					{ monsterId =678, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1047,camp=5},
					{ monsterId =678, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1047,camp=5},
					},[148]={
					{ monsterId =679, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1048,camp=5},
					{ monsterId =679, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1048,camp=5},
					},[149]={
					{ monsterId =680, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1049,camp=5},
					{ monsterId =680, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1049,camp=5},
					},[150]={
					{ monsterId =681, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1050,camp=5},
					{ monsterId =681, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1050,camp=5},
					},[151]={
					{ monsterId =682, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1051,camp=5},
					{ monsterId =682, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1051,camp=5},
					},[152]={
					{ monsterId =683, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1052,camp=5},
					{ monsterId =683, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1052,camp=5},
					},[153]={
					{ monsterId =684, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1053,camp=5},
					{ monsterId =684, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1053,camp=5},
					},[154]={
					{ monsterId =685, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1054,camp=5},
					{ monsterId =685, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1054,camp=5},
					},[155]={
					{ monsterId =686, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1055,camp=5},
					{ monsterId =686, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1055,camp=5},
					},[156]={
					{ monsterId =687, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1056,camp=5},
					{ monsterId =687, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1056,camp=5},
					},[157]={
					{ monsterId =688, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1057,camp=5},
					{ monsterId =688, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1057,camp=5},
					},[158]={
					{ monsterId =689, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1058,camp=5},
					{ monsterId =689, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1058,camp=5},
					},[159]={
					{ monsterId =690, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1059,camp=5},
					{ monsterId =690, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1059,camp=5},
					},[160]={
					{ monsterId =691, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1060,camp=5},
					{ monsterId =691, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1060,camp=5},
					},[161]={
					{ monsterId =692, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1061,camp=5},
					{ monsterId =692, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1061,camp=5},
					},[162]={
					{ monsterId =693, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1062,camp=5},
					{ monsterId =693, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1062,camp=5},
					},[163]={
					{ monsterId =694, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1063,camp=5},
					{ monsterId =694, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1063,camp=5},
					},[164]={
					{ monsterId =695, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1064,camp=5},
					{ monsterId =695, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1064,camp=5},
					},[165]={
					{ monsterId =696, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1065,camp=5},
					{ monsterId =696, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1065,camp=5},
					},[166]={
					{ monsterId =697, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1066,camp=5},
					{ monsterId =697, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1066,camp=5},
					},[167]={
					{ monsterId =698, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1067,camp=5},
					{ monsterId =698, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1067,camp=5},
					},[168]={
					{ monsterId =699, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1068,camp=5},
					{ monsterId =699, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1068,camp=5},
					},[169]={
					{ monsterId =700, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1069,camp=5},
					{ monsterId =700, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1069,camp=5},
					},[170]={
					{ monsterId =701, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1070,camp=5},
					{ monsterId =701, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1070,camp=5},
					},[171]={
					{ monsterId =702, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1071,camp=5},
					{ monsterId =702, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1071,camp=5},
					},[172]={
					{ monsterId =703, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1072,camp=5},
					{ monsterId =703, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1072,camp=5},
					},[173]={
					{ monsterId =704, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1073,camp=5},
					{ monsterId =704, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1073,camp=5},
					},[174]={
					{ monsterId =705, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1074,camp=5},
					{ monsterId =705, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1074,camp=5},
					},[175]={
					{ monsterId =706, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1075,camp=5},
					{ monsterId =706, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1075,camp=5},
					},[176]={
					{ monsterId =707, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1076,camp=5},
					{ monsterId =707, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1076,camp=5},
					},[177]={
					{ monsterId =708, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1077,camp=5},
					{ monsterId =708, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1077,camp=5},
					},[178]={
					{ monsterId =709, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1078,camp=5},
					{ monsterId =709, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1078,camp=5},
					},[179]={
					{ monsterId =710, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1079,camp=5},
					{ monsterId =710, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1079,camp=5},
					},[180]={
					{ monsterId =711, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1080,camp=5},
					{ monsterId =711, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1080,camp=5},
					},[181]={
					{ monsterId =712, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1081,camp=5},
					{ monsterId =712, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1081,camp=5},
					},[182]={
					{ monsterId =713, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1082,camp=5},
					{ monsterId =713, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1082,camp=5},
					},[183]={
					{ monsterId =714, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1083,camp=5},
					{ monsterId =714, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1083,camp=5},
					},[184]={
					{ monsterId =715, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1084,camp=5},
					{ monsterId =715, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1084,camp=5},
					},[185]={
					{ monsterId =716, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1085,camp=5},
					{ monsterId =716, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1085,camp=5},
					},[186]={
					{ monsterId =717, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1086,camp=5},
					{ monsterId =717, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1086,camp=5},
					},[187]={
					{ monsterId =718, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1087,camp=5},
					{ monsterId =718, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1087,camp=5},
					},[188]={
					{ monsterId =719, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1088,camp=5},
					{ monsterId =719, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1088,camp=5},
					},[189]={
					{ monsterId =720, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1089,camp=5},
					{ monsterId =720, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1089,camp=5},
					},[190]={
					{ monsterId =721, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1090,camp=5},
					{ monsterId =721, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1090,camp=5},
					},[191]={
					{ monsterId =722, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1091,camp=5},
					{ monsterId =722, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1091,camp=5},
					},[192]={
					{ monsterId =723, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1092,camp=5},
					{ monsterId =723, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1092,camp=5},
					},[193]={
					{ monsterId =724, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1093,camp=5},
					{ monsterId =724, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1093,camp=5},
					},[194]={
					{ monsterId =725, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1094,camp=5},
					{ monsterId =725, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1094,camp=5},
					},[195]={
					{ monsterId =726, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1095,camp=5},
					{ monsterId =726, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1095,camp=5},
					},[196]={
					{ monsterId =727, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1096,camp=5},
					{ monsterId =727, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1096,camp=5},
					},[197]={
					{ monsterId =728, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1097,camp=5},
					{ monsterId =728, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1097,camp=5},
					},[198]={
					{ monsterId =729, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1098,camp=5},
					{ monsterId =729, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1098,camp=5},
					},[199]={
					{ monsterId =730, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1099,camp=5},
					{ monsterId =730, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1099,camp=5},
					},[200]={
					{ monsterId =731, BRMONSTER = 1, centerX = 14, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1100,camp=5},
					{ monsterId =731, BRMONSTER = 1, centerX = 81, centerY = 16 , targetX = 48,targetY = 16,BRArea = 1 , BRNumber =10 ,deadbody = 6 , deadScript =1100,camp=5},
					},
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 46, y = 16}},		-- �����
			RelivePos = {1,70,70},				-- �����
		},
	},		
	NeedConditions = {				-- ������������
	nLevel = 60,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
	},
}

FBConfig[19] = {				-- �����������
}

FBConfig[19][1] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2044,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2044, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 732,BRMONSTER = 1, centerX = 16, centerY = 23 , targetX = 16,targetY = 23,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 1001 ,camp = 5, },
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},		
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
		},
	},
}
FBConfig[19][2] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2045,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2045, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
				boss = { monsterId = 733, imageID = 2045 ,deadbody = 6 ,  deadScript = 1001, x=16,y=23,dir=2},
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 50, CountList = { 1, 1 }, IsBind = 1 },--1.2�������
		},
	},
}
FBConfig[19][3] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2046,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2046, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
			    boss = { monsterId = 734, imageID = 2046 ,EventID = 1, eventScript = 1025,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=16,y=23,dir=2},	
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 51, CountList = { 1, 1 }, IsBind = 1 },--1.5�������
		},
	},
}
FBConfig[19][4] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2047,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2047, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 735,  BRMONSTER = 1, centerX = 16, centerY = 23 , targetX = 16,targetY = 23,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 1001 ,camp = 5, },
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 52, CountList = { 1, 1 }, IsBind = 1 },--2�������
		},
	},
}
FBConfig[19][5] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2016,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2094, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
				boss = { monsterId = 736, imageID = 2094 ,EventID = 1, eventScript = 1026,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=16,y=23,dir=2},
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 1, 1 }, IsBind = 1 },--100W���鵤
		},
	},
}
FBConfig[19][6] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2049,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2049, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 737,  BRMONSTER = 1, centerX = 16, centerY = 23 , targetX = 16,targetY = 23,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 1001 ,camp = 5, },
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 1, 1 }, IsBind = 1 },--100W���鵤
		},
	},

}
FBConfig[19][7] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2048,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2048, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
				boss = { monsterId = 738, imageID = 2048 ,EventID = 1, eventScript = 1027,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=16,y=23,dir=2},
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 1, 1 }, IsBind = 1 },--100W���鵤
		},
	},

}
FBConfig[19][8] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2234,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 739,  BRMONSTER = 1, centerX = 16, centerY = 23 , targetX = 16,targetY = 23,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 1001 ,camp = 5, },
				},
			},		
				
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 1, 1 }, IsBind = 1 },--100W���鵤
		},
	},

}
FBConfig[19][9] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2252,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2252, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
				boss = { monsterId = 740,imageID = 2252 ,EventID = 1, eventScript = 1028,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=16,y=23,dir=2},
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 1, 1 }, IsBind = 1 },--100W���鵤
		},
	},
}
FBConfig[19][10] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2002,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2256, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
				boss = { monsterId = 741,imageID = 2256 ,EventID = 1, eventScript = 1028,controlId = 1000,deadbody = 6 ,  deadScript = 1001, x=16,y=23,dir=2},
				},
			},		
				
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 1, 1 }, IsBind = 1 },--100W���鵤
		},
	},
}
FBConfig[20] = {				-- �����������(������)
}

FBConfig[20][1] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2044,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2044, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 742, BRMONSTER = 1, centerX = 16, centerY = 23 , targetX = 16,targetY = 23,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 1001 ,camp = 5, },
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
		},
	},
}
FBConfig[20][2] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2045,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2045, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 743, BRMONSTER = 1, centerX = 16, centerY = 23 , targetX = 16,targetY = 23,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 1001 ,camp = 5, },
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 50, CountList = { 1, 1 }, IsBind = 1 },--1.2�������
		},
	},
}
FBConfig[20][3] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2046,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2046, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 744, BRMONSTER = 1, centerX = 16, centerY = 23 , targetX = 16,targetY = 23,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 1001 ,camp = 5, },
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 51, CountList = { 1, 1 }, IsBind = 1 },--1.5�������
		},
	},
}
FBConfig[20][4] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2047,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2047, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 745, BRMONSTER = 1, centerX = 16, centerY = 23 , targetX = 16,targetY = 23,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 1001 ,camp = 5, },
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},	
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 52, CountList = { 1, 1 }, IsBind = 1 },--2�������
		},
	},
}
FBConfig[20][5] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2016,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2094, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 746, BRMONSTER = 1, centerX = 16, centerY = 23 , targetX = 16,targetY = 23,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 1001 ,camp = 5, },
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 1, 1 }, IsBind = 1 },--100W���鵤
		},
	},

}
FBConfig[20][6] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2049,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2049, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 747, BRMONSTER = 1, centerX = 16, centerY = 23 , targetX = 16,targetY = 23,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 1001 ,camp = 5, },
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 1, 1 }, IsBind = 1 },--100W���鵤
		},
	},
}
FBConfig[20][7] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2048,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2048, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 748, BRMONSTER = 1, centerX = 16, centerY = 23 , targetX = 16,targetY = 23,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 1001 ,camp = 5, },
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 1, 1 }, IsBind = 1 },--100W���鵤
		},
	},
}
FBConfig[20][8] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2234,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 749, BRMONSTER = 1, centerX = 16, centerY = 23 , targetX = 16,targetY = 23,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 1001 ,camp = 5, },
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 1, 1 }, IsBind = 1 },--100W���鵤
		},
	},
}
FBConfig[20][9] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2252,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2252, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 750, BRMONSTER = 1, centerX = 16, centerY = 23 , targetX = 16,targetY = 23,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 1001 ,camp = 5, },
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 1, 1 }, IsBind = 1 },--100W���鵤
		},
	},
}
FBConfig[20][10] = {
	FBName = '�����������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2002,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2256, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 1,preTime = 90,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 525, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 751, BRMONSTER = 1, centerX = 16, centerY = 23 , targetX = 16,targetY = 23,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 1001 ,camp = 5, },
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 19, y = 24}},		-- �����
			RelivePos = {1,16,88},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 65,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		Exp = 0,
		Money = 0,	
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 803, CountList = { 50, 50 }, IsBind = 1 },--�ǳ���Ƭ
			{ Rate = { 1, 10000 }, ItemID = 673, CountList = { 1, 1 }, IsBind = 1 },--100W���鵤
		},
	},
}
FBConfig[21] = {				-- ������������
}

FBConfig[21][1] = {
	FBName = '������������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2005,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2005, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[14001] = { step = 1, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[14002] = { step = 2, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[14003] = { step = 3, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
			[14004] = { step = 4, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[14005] = { step = 5, num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 5,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 526, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 752, BRMONSTER = 1, centerX = 15, centerY = 15 , targetX = 15,targetY = 9,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14001 ,camp = 5, },
				},
			[102]={ 											
					{ monsterId = 753, BRMONSTER = 1, centerX = 55, centerY = 19 , targetX = 55,targetY = 19,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14002 ,camp = 5, },
				},
			[103]={ 											
					{ monsterId = 754, BRMONSTER = 1, centerX = 49, centerY = 76 , targetX = 49,targetY = 76,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14003 ,camp = 5, },
				},
			[104]={ 											
					{ monsterId = 755, BRMONSTER = 1, centerX = 10, centerY = 81 , targetX = 10,targetY = 81,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14004 ,camp = 5, },
				},
			[105]={ 											
					{ monsterId = 756, BRMONSTER = 1, centerX = 32, centerY = 47 , targetX = 32,targetY = 47,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14005 ,camp = 5, },
				},				
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 6, y = 33}},		-- �����
			RelivePos = {1,6,33},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 72,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		first={		--�״�--ͨ�ý�������
			[3]={{821,20,1},{52,1,1}},
		},
	},
}
FBConfig[21][2] = {
	FBName = '������������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2020,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2020, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[14006] = { step = 1, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[14007] = { step = 2, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[14008] = { step = 3, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
			[14009] = { step = 4, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[14010] = { step = 5, num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 5,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 526, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 757, BRMONSTER = 1, centerX = 15, centerY = 15 , targetX = 15,targetY = 9,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14006 ,camp = 5, },
				},
			[102]={ 											
					{ monsterId = 758, BRMONSTER = 1, centerX = 55, centerY = 19 , targetX = 55,targetY = 19,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14007 ,camp = 5, },
				},
			[103]={ 											
					{ monsterId = 759, BRMONSTER = 1, centerX = 49, centerY = 76 , targetX = 49,targetY = 76,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14008 ,camp = 5, },
				},
			[104]={ 											
					{ monsterId = 760, BRMONSTER = 1, centerX = 10, centerY = 81 , targetX = 10,targetY = 81,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14009 ,camp = 5, },
				},
			[105]={ 											
					{ monsterId = 761, BRMONSTER = 1, centerX = 32, centerY = 47 , targetX = 32,targetY = 47,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14010 ,camp = 5, },
				},				
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 6, y = 33}},		-- �����
			RelivePos = {1,6,33},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 72,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		first={		--�״�--ͨ�ý�������
			[3]={{821,30,1},{52,1,1}},
		},
	},
}
FBConfig[21][3] = {
	FBName = '������������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2035,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2035, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[14011] = { step = 1, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[14012] = { step = 2, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[14013] = { step = 3, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
			[14014] = { step = 4, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[14015] = { step = 5, num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 5,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 526, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 762, BRMONSTER = 1, centerX = 15, centerY = 15 , targetX = 15,targetY = 9,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14011 ,camp = 5, },
				},
			[102]={ 											
					{ monsterId = 763, BRMONSTER = 1, centerX = 55, centerY = 19 , targetX = 55,targetY = 19,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14012 ,camp = 5, },
				},
			[103]={ 											
					{ monsterId = 764, BRMONSTER = 1, centerX = 49, centerY = 76 , targetX = 49,targetY = 76,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14013 ,camp = 5, },
				},
			[104]={ 											
					{ monsterId = 765, BRMONSTER = 1, centerX = 10, centerY = 81 , targetX = 10,targetY = 81,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14014 ,camp = 5, },
				},
			[105]={ 											
					{ monsterId = 766, BRMONSTER = 1, centerX = 32, centerY = 47 , targetX = 32,targetY = 47,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14015 ,camp = 5, },
				},				
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 6, y = 33}},		-- �����
			RelivePos = {1,6,33},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 72,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���		
		first={		--�״�--ͨ�ý�������
			[3]={{821,40,1},{52,1,1}},
		},
	},
}
FBConfig[21][4] = {
	FBName = '������������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2016,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2016, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[14016] = { step = 1, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[14017] = { step = 2, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[14018] = { step = 3, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
			[14019] = { step = 4, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[14020] = { step = 5, num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 5,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 526, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 767, BRMONSTER = 1, centerX = 15, centerY = 15 , targetX = 15,targetY = 9,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14016 ,camp = 5, },
				},
			[102]={ 											
					{ monsterId = 768, BRMONSTER = 1, centerX = 55, centerY = 19 , targetX = 55,targetY = 19,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14017 ,camp = 5, },
				},
			[103]={ 											
					{ monsterId = 769, BRMONSTER = 1, centerX = 49, centerY = 76 , targetX = 49,targetY = 76,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14018 ,camp = 5, },
				},
			[104]={ 											
					{ monsterId = 770, BRMONSTER = 1, centerX = 10, centerY = 81 , targetX = 10,targetY = 81,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14019 ,camp = 5, },
				},
			[105]={ 											
					{ monsterId = 771, BRMONSTER = 1, centerX = 32, centerY = 47 , targetX = 32,targetY = 47,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14020 ,camp = 5, },
				},				
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 6, y = 33}},		-- �����
			RelivePos = {1,6,33},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 72,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		first={		--�״�--ͨ�ý�������
			[3]={{821,50,1},{52,1,1}},
		},
	},
}
FBConfig[21][5] = {
	FBName = '������������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2049,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2049, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[14021] = { step = 1, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[14022] = { step = 2, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[14023] = { step = 3, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
			[14024] = { step = 4, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[14025] = { step = 5, num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 5,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 526, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 772, BRMONSTER = 1, centerX = 15, centerY = 15 , targetX = 15,targetY = 9,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14021 ,camp = 5, },
				},
			[102]={ 											
					{ monsterId = 773, BRMONSTER = 1, centerX = 55, centerY = 19 , targetX = 55,targetY = 19,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14022 ,camp = 5, },
				},
			[103]={ 											
					{ monsterId = 774, BRMONSTER = 1, centerX = 49, centerY = 76 , targetX = 49,targetY = 76,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14023 ,camp = 5, },
				},
			[104]={ 											
					{ monsterId = 775, BRMONSTER = 1, centerX = 10, centerY = 81 , targetX = 10,targetY = 81,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14024 ,camp = 5, },
				},
			[105]={ 											
					{ monsterId = 776, BRMONSTER = 1, centerX = 32, centerY = 47 , targetX = 32,targetY = 47,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14025 ,camp = 5, },
				},				
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 6, y = 33}},		-- �����
			RelivePos = {1,6,33},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 72,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		first={		--�״�--ͨ�ý�������
			[3]={{821,60,1},{52,1,1}},
		},
	},
}
FBConfig[21][6] = {
	FBName = '������������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2048,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2048, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[14026] = { step = 1, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[14027] = { step = 2, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[14028] = { step = 3, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
			[14029] = { step = 4, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[14030] = { step = 5, num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 5,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 526, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 777, BRMONSTER = 1, centerX = 15, centerY = 15 , targetX = 15,targetY = 9,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14026 ,camp = 5, },
				},
			[102]={ 											
					{ monsterId = 778, BRMONSTER = 1, centerX = 55, centerY = 19 , targetX = 55,targetY = 19,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14027 ,camp = 5, },
				},
			[103]={ 											
					{ monsterId = 779, BRMONSTER = 1, centerX = 49, centerY = 76 , targetX = 49,targetY = 76,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14028 ,camp = 5, },
				},
			[104]={ 											
					{ monsterId = 780, BRMONSTER = 1, centerX = 10, centerY = 81 , targetX = 10,targetY = 81,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14029 ,camp = 5, },
				},
			[105]={ 											
					{ monsterId = 781, BRMONSTER = 1, centerX = 32, centerY = 47 , targetX = 32,targetY = 47,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14030 ,camp = 5, },
				},				
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 6, y = 33}},		-- �����
			RelivePos = {1,6,33},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 72,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���		
		first={		--�״�--ͨ�ý�������
			[3]={{821,70,1},{52,1,1}},
		},
	},
}
FBConfig[21][7] = {
	FBName = '������������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2234,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2234, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[14031] = { step = 1, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[14032] = { step = 2, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[14033] = { step = 3, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
			[14034] = { step = 4, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[14035] = { step = 5, num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 5,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 526, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 782, BRMONSTER = 1, centerX = 15, centerY = 15 , targetX = 15,targetY = 9,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14031 ,camp = 5, },
				},
			[102]={ 											
					{ monsterId = 783, BRMONSTER = 1, centerX = 55, centerY = 19 , targetX = 55,targetY = 19,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14032 ,camp = 5, },
				},
			[103]={ 											
					{ monsterId = 784, BRMONSTER = 1, centerX = 49, centerY = 76 , targetX = 49,targetY = 76,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14033 ,camp = 5, },
				},
			[104]={ 											
					{ monsterId = 785, BRMONSTER = 1, centerX = 10, centerY = 81 , targetX = 10,targetY = 81,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14034 ,camp = 5, },
				},
			[105]={ 											
					{ monsterId = 786, BRMONSTER = 1, centerX = 32, centerY = 47 , targetX = 32,targetY = 47,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14035 ,camp = 5, },
				},				
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 6, y = 33}},		-- �����
			RelivePos = {1,6,33},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 72,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		first={		--�״�--ͨ�ý�������
			[3]={{821,80,1},{52,1,1}},
		},
	},
}
FBConfig[21][8] = {
	FBName = '������������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON = 2002,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2256, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[14036] = { step = 1, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,102},},},},
			[14037] = { step = 2, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,103},},},},
			[14038] = { step = 3, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,104},},},},
			[14039] = { step = 4, num = 1,EventTb = {{EventTypeTb.MonRefresh,{1,105},},},},
			[14040] = { step = 5, num = 1, EventTb = { {EventTypeTb.Completion}, } },
		},	
		Timers = {
			[1] = {num = 5,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},			
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 526, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 787, BRMONSTER = 1, centerX = 15, centerY = 15 , targetX = 15,targetY = 9,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14036 ,camp = 5, },
				},
			[102]={ 											
					{ monsterId = 788, BRMONSTER = 1, centerX = 55, centerY = 19 , targetX = 55,targetY = 19,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14037 ,camp = 5, },
				},
			[103]={ 											
					{ monsterId = 789, BRMONSTER = 1, centerX = 49, centerY = 76 , targetX = 49,targetY = 76,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14038 ,camp = 5, },
				},
			[104]={ 											
					{ monsterId = 790, BRMONSTER = 1, centerX = 10, centerY = 81 , targetX = 10,targetY = 81,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14039 ,camp = 5, },
				},
			[105]={ 											
					{ monsterId = 791, BRMONSTER = 1, centerX = 32, centerY = 47 , targetX = 32,targetY = 47,BRArea = 1 , BRNumber =1 ,deadbody = 6 , deadScript = 14040 ,camp = 5, },
				},				
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 6, y = 33}},		-- �����
			RelivePos = {1,6,33},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 72,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		first={		--�״�--ͨ�ý�������
			[3]={{821,90,1},{52,1,1}},
		},
	},
}

FBConfig[22] = { --������������
}

FBConfig[22][1] = {
	FBName = '������������',	-- ��������	
	VictoryCondition = '��ɱBOSS',	--ʤ����������
	ICON= 2065,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	bossName = 'Ǳ����',
	RecommendLV = 60,		-- �Ƽ��ȼ�
	
	EventList = {
		MonDeads = {					-- �������������¼��б�
			[4601] = { step = 1, num = 20,EventTb = {{EventTypeTb.TimerTrigger,2,},},},
			[4602] = { step = 2, num = 20,EventTb = {{EventTypeTb.TimerTrigger,3,},},},
			[4603] = { step = 3, num = 20,EventTb = {{EventTypeTb.TimerTrigger,4,},},},
			[4604] = { step = 4, num = 20,EventTb = {{EventTypeTb.TimerTrigger,5,},},},
			[4605] = { step = 5, num = 20,EventTb = {{EventTypeTb.TimerTrigger,6,},},},
			[4606] = { step = 6, num = 20,EventTb = {{EventTypeTb.TimerTrigger,7,},},},
			[4607] = { step = 7, num = 20,EventTb = {{EventTypeTb.TimerTrigger,8,},},},
			[4608] = { step = 8, num = 20,EventTb = {{EventTypeTb.TimerTrigger,9,},},},
			[4609] = { step = 9, num = 20,EventTb = {{EventTypeTb.TimerTrigger,10,},},},
			[4610] = { step = 10, num = 20,EventTb = {{EventTypeTb.TimerTrigger,11,},},},
			[4611] = { step = 11, num = 20,EventTb = {{EventTypeTb.TimerTrigger,12,},},},
			[4612] = { step = 12, num = 20,EventTb = {{EventTypeTb.TimerTrigger,13,},},},
			[4613] = { step = 13, num = 20,EventTb = {{EventTypeTb.TimerTrigger,14,},},},
			[4614] = { step = 14, num = 20,EventTb = {{EventTypeTb.TimerTrigger,15,},},},
			[4615] = { step = 15, num = 20,EventTb = {{EventTypeTb.TimerTrigger,16,},},},
			[4616] = { step = 16, num = 20,EventTb = {{EventTypeTb.TimerTrigger,17,},},},	
			[4617] = { step = 17, num = 20,EventTb = {{EventTypeTb.TimerTrigger,18,},},},
			[4618] = { step = 18, num = 20,EventTb = {{EventTypeTb.TimerTrigger,19,},},},
			[4619] = { step = 19, num = 20,EventTb = {{EventTypeTb.TimerTrigger,20,},},},
			[4620] = { step = 20, num = 20,EventTb = {{EventTypeTb.TimerTrigger,21,},},},
			[4621] = { step = 21, num = 20,EventTb = {{EventTypeTb.TimerTrigger,22,},},},
			[4622] = { step = 22, num = 20,EventTb = {{EventTypeTb.TimerTrigger,23,},},},
			[4623] = { step = 23, num = 20,EventTb = {{EventTypeTb.TimerTrigger,24,},},},
			[4624] = { step = 24, num = 20,EventTb = {{EventTypeTb.TimerTrigger,25,},},},
			[4625] = { step = 25, num = 20,EventTb = {{EventTypeTb.TimerTrigger,26,},},},
			[4626] = { step = 26, num = 20,EventTb = {{EventTypeTb.TimerTrigger,27,},},},
			[4627] = { step = 27, num = 20,EventTb = {{EventTypeTb.TimerTrigger,28,},},},
			[4628] = { step = 28, num = 20,EventTb = {{EventTypeTb.TimerTrigger,29,},},},
			[4629] = { step = 29, num = 20,EventTb = {{EventTypeTb.TimerTrigger,30,},},},			
			[4630] = { step = 30, num = 20,EventTb = {{EventTypeTb.Completion},} },
		
		},	
		Timers = {
			[1] = {num = 20,timer = 1,preTime = 180, EventTb = {{EventTypeTb.MonRefresh,{1,{102},nil,1},}, },},
			[2] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{103},nil,2},}, },},
			[3] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{104},nil,3},}, },},
			[4] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{105},nil,4},}, },},
			[5] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{106},nil,5},}, },},
			[6] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{107},nil,6},}, },},
			[7] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{108},nil,7},}, },},
			[8] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{109},nil,8},}, },},
			[9] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{110},nil,9},}, },},
			[10] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{111},nil,10},}, },},
			[11] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{112},nil,11},}, },},
			[12] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{113},nil,12},}, },},
			[13] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{114},nil,13},}, },},
			[14] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{115},nil,14},}, },},
			[15] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{116},nil,15},}, },},
			[16] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{117},nil,16},}, },},
			[17] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{118},nil,17},}, },},
			[18] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{119},nil,18},}, },},
			[19] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{120},nil,19},}, },},
			[20] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{121},nil,20},}, },},
			[21] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{122},nil,21},}, },},
			[22] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{123},nil,22},}, },},
			[23] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{124},nil,23},}, },},
			[24] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{125},nil,24},}, },},
			[25] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{126},nil,25},}, },},
			[26] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{127},nil,26},}, },},
			[27] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{128},nil,27},}, },},
			[28] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{129},nil,28},}, },},
			[29] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{130},nil,29},}, },},
			[30] = {num = 20,timer = 1,EventTb = { {EventTypeTb.MonRefresh,{1,{131},nil,30},}, },},
		},		
	},			
			
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 528, 		-- ��ͼ���																		 
			MonsterList = {				-- �����б�
				[101] = {
					{ monsterId = 792, eventScript = 207,x = 11 , y = 45 , camp = 4,},
					{ monsterId = 792, eventScript = 207,x = 15 , y = 50 , camp = 4,},
					{ monsterId = 792, eventScript = 207,x = 20 , y = 54 , camp = 4,},
					{ monsterId = 792, eventScript = 207,x = 25 , y = 56 , camp = 4,},
					{ monsterId = 792, eventScript = 207,x = 35 , y = 58 , camp = 4,},
					{ monsterId = 792, eventScript = 207,x = 39 , y = 56 , camp = 4,},
					{ monsterId = 792, eventScript = 207,x = 43 , y = 55 , camp = 4,},
					{ monsterId = 792, eventScript = 207,x = 47 , y = 52 , camp = 4,},
					{ monsterId = 792, eventScript = 207,x = 51 , y = 46 , camp = 4,},
					{ monsterId = 792, eventScript = 207,x = 53 , y = 40 , camp = 4,},
					{ monsterId = 792, eventScript = 207,x = 31 , y = 57 , camp = 4,},					
				},
				[102] = {
					{ monsterId = 799, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4601,},
				},				                                                                                                                                                  
				[103] = {                                                                                                                                                         
					{ monsterId = 800, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4602,},
				},                                                                                                                                   
				[104] = {                                                                                                                            
					{ monsterId = 801, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4603,},
				},                                                                                                                                   
				[105] = {                                                                                                                            
				    { monsterId = 802, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4604,},
				},                                                                                                                                   
				[106] = {                                                                                                                            
					{ monsterId = 803, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4605,},
				},                                                                            
				[107] = {                                                                                                                            
					{ monsterId = 804, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4606,},	
				},                                                                                                                                   
				[108] = {                                                                                                                            
					{ monsterId = 805, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4607,},
				},                                                                                                                                   
				[109] = {                                                                                                                            
					{ monsterId = 806, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4608,},
				},                                                                                                                                   
				[110] = {                                                                                                                            
					{ monsterId = 807, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4609,},
				},                                                                                                       
				[111] = {                                                                                                                            
				    { monsterId = 808, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4610,},
				},                                                                                                                                                                
				[112] = {                                                                                                                                                         
					{ monsterId = 809, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4611,},
				},                                                                                                                                                 
				[113] = {                                                                                                                                          
					{ monsterId = 810, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4612,},	
				},                                                                                                                                                 
				[114] = {                                                                                                                                          
					{ monsterId = 811, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4613,},
				},                                                                                                                                                 
				[115] = {                                                                                                                                          
					{ monsterId = 812, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4614,},
				},                                                                                                                                   
				[116] = {                                                                                                                            
					{ monsterId = 813, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4615,},
				},	                                                                                                                                 
				[117] = {                                                                                                                            
					{ monsterId = 814, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4616,},
				},                                                                                                                                   
				[118] = {                                                                                                                            
					{ monsterId = 815, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4617,},
				},                                                                                                                                   
				[119] = {                                                                                                                            
				    { monsterId = 816, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4618,},
				},                                                                                                                                   
				[120] = {                                                                                                                            
					{ monsterId = 817, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4619,},
				},                                                                                         
				[121] = {                                                                                  
					{ monsterId = 818, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4620,},	
				},                                                                                                                                   
				[122] = {                                                                                                                            
					{ monsterId = 819, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4621,},
				},                                                                                                                                   
				[123] = {                                                                                                                            
					{ monsterId = 820, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4622,},
				},                                                                                                                                   
				[124] = {                                                                                                                            
					{ monsterId = 821, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4623,},
				},                                                                                                                                   
				[125] = {                                                                                                                            
				    { monsterId = 822, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4624,},
				},                                                                                                                                   
				[126] = {                                                                                                                            
					{ monsterId = 823, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4625,},
				},                                                                                                                                   
				[127] = {                                                                                                                            
					{ monsterId = 824, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4626,},	
				},                                                                                                                                   
				[128] = {                                                                                                                            
					{ monsterId = 825, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4627,},
				},                                                                                                                                   
				[129] = {                                                                                                                            
					{ monsterId = 826, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4628,},
				},                                                                                                                                   
				[130] = {                                                                                                                            
					{ monsterId = 827, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4629,},
				},						                                                          
				[131] = {                                                                         
					{ monsterId = 828, deadbody = 6 , x = 5 , y = 50 , targetX = 58, targetY =36, camp = 5,moveScript=22001 ,deadScript =4630,},
				},				                                                                  
			},			
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲			
			EnterPos = {{x = 12, y = 36}},		-- �����
			RelivePos = {1,12,36},				-- �����
		},
	},	
	

	NeedConditions = {				-- ������������
		nLevel = 60,					-- ����ȼ�����
		nItemList = {				-- ��Ҫ��Ʒ�б�����
			},
	},	
	
	CSAwards = {					-- �������ؽ���
		func = 'cs_award_22001',
	},
}
FBConfig[23] = {  				--һ�ﵱǧ����
}

yjdq_monster_count = 138

FBConfig[23][1] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2043,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2043, --������ԴID

	EventList = {
					MonDeads = 
					{					-- �������������¼��б�
							[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
					},
					
					Timers = 
					{
							[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
					},					
				},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,1,1}},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,2,1}},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,3,1}},
					},
				},	
			
			},	
		items_one = {{1521,1,1},{1536,1,1},{1551,1,1},},
		},
}
FBConfig[23][2] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2029,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2029, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},					
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
 
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,3,1}},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�����
					[1]=0,
					[3]={{1520,4,1}},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�����
					[1]=0,
					[3]={{1520,5,1}},
					},
				},				
			},	
		items_one = {{1521,1,1},{1536,1,1},{1551,1,1},},			
		},
}
FBConfig[23][3] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2067,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2067, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},					
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,5,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,6,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,7,1},},
					},
				},	
			},	
		items_one = {{1521,1,1},{1536,1,1},{1551,1,1},},			
		},
}
FBConfig[23][4] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2041,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2041, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,7,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,8,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,9,1},},
					},
				},	
			
			},		
		items_one = {{1521,1,1},{1536,1,1},{1551,1,1},},			
		},
}
FBConfig[23][5] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2042,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2042, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,9,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,10,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,11,1},},
					},
				},	
			
			},	
		items_one = {{1521,1,1},{1536,1,1},{1551,1,1},},			
		},
}
FBConfig[23][6] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2030,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2030, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},					
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,11,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,12,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,13,1},},
					},
				},	
			
			},	
		items_one = {{1521,1,1},{1536,1,1},{1551,1,1},},			
		},
}
FBConfig[23][7] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2022,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2022, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,13,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,14,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,15,1},},
					},
				},	
			
			},	
		items_one = {{1521,1,1},{1536,1,1},{1551,1,1},},			
		},
}
FBConfig[23][8] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2023,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2023, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,15,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,16,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,17,1},},
					},
				},	
			
			},	
		items_one = {{1521,1,1},{1536,1,1},{1551,1,1},},			
		},
}
FBConfig[23][9] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2017,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2017, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},					
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,17,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,18,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,19,1},},
					},
				},	
			
			},	
		items_one = {{1521,1,1},{1536,1,1},{1551,1,1},},			
		},
}
FBConfig[23][10] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2039,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2039, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},					
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,19,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,20,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,21,1},},
					},
				},	
			
			},	
		items_one = {{1522,1,1},{1537,1,1},{1552,1,1},},			
		},
}
FBConfig[23][11] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2034,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2034, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,21,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,22,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,23,1},},
					},
				},	
			
			},	
		items_one = {{1522,1,1},{1537,1,1},{1552,1,1},},			
		},
}
FBConfig[23][12] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2036,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2036, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,23,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,24,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,25,1},},
					},
				},	
			
			},	
		items_one = {{1522,1,1},{1537,1,1},{1552,1,1},},			
		},
}
FBConfig[23][13] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2015,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2015, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,25,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,26,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,27,1},},
					},
				},	
			
			},	
		items_one = {{1522,1,1},{1537,1,1},{1552,1,1},},			
		},
}
FBConfig[23][14] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2026,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2026, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,27,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,28,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,29,1},},
					},
				},	
			
			},
		items_one = {{1522,1,1},{1537,1,1},{1552,1,1},},			
		},
}
FBConfig[23][15] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2131,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2131, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,29,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,30,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,31,1},},
					},
				},	
			
			},	
		items_one = {{1522,1,1},{1537,1,1},{1552,1,1},},			
		},
}
FBConfig[23][16] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2134,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2134, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,31,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,32,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,33,1},},
					},
				},	
			
			},	
		items_one = {{1522,1,1},{1537,1,1},{1552,1,1},},			
		},
}
FBConfig[23][17] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2135,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2135, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,33,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,34,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,35,1},},
					},
				},	
			
			},	
		items_one = {{1522,1,1},{1537,1,1},{1552,1,1},},			
		},
}
FBConfig[23][18] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2137,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2137, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,35,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,36,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,37,1},},
					},
				},	
			
			},	
		items_one = {{1522,1,1},{1537,1,1},{1552,1,1},},			
		},
}
FBConfig[23][19] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2218,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2218, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,37,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,38,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,39,1},},
					},
				},	
			
			},
		items_one = {{1522,1,1},{1537,1,1},{1552,1,1},},			
		},
}
FBConfig[23][20] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2221,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2221, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,39,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,40,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,41,1},},
					},
				},	
			
			},	
		items_one = {{1523,1,1},{1538,1,1},{1553,1,1},},			
		},
}
FBConfig[23][21] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2227,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2227, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,41,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,42,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,43,1},},
					},
				},	
			
			},	
		items_one = {{1523,1,1},{1538,1,1},{1553,1,1},},			
		},
}
FBConfig[23][22] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2228,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2228, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,43,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,44,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,45,1},},
					},
				},	
			
			},	
		items_one = {{1523,1,1},{1538,1,1},{1553,1,1},},			
		},
}
FBConfig[23][23] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2229,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2229, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,45,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,46,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,47,1},},
					},
				},	
			
			},	
		items_one = {{1523,1,1},{1538,1,1},{1553,1,1},},			
		},
}
FBConfig[23][24] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2232,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2232, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,47,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,48,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,49,1},},
					},
				},	
			
			},	
		items_one = {{1523,1,1},{1538,1,1},{1553,1,1},},			
		},
}
FBConfig[23][25] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2220,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2220, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,49,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,50,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,51,1},},
					},
				},	
			
			},	
		items_one = {{1523,1,1},{1538,1,1},{1553,1,1},},			
		},
}
FBConfig[23][26] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2222,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2222, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,51,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,52,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,53,1},},
					},
				},	
			
			},	
		items_one = {{1523,1,1},{1538,1,1},{1553,1,1},},			
		},
}
FBConfig[23][27] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2223,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2223, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,53,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,54,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,55,1},},
					},
				},	
			
			},	
		items_one = {{1523,1,1},{1538,1,1},{1553,1,1},},			
		},
}
FBConfig[23][28] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2224,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2224, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,55,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,56,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,57,1},},
					},
				},	
			
			},	
		items_one = {{1523,1,1},{1538,1,1},{1553,1,1},},			
		},
}
FBConfig[23][29] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2231,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2231, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,57,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,58,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,59,1},},
					},
				},	
			
			},	
		items_one = {{1523,1,1},{1538,1,1},{1553,1,1},},			
		},
}
FBConfig[23][30] = {
	FBName = 'һ�ﵱǧ����',	-- ��������	
	VictoryCondition = '��ɱ���й���',	--ʤ����������
	ICON = 2230,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2230, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = yjdq_monster_count, EventTb = {{EventTypeTb.Completion},}, },
				},
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},				
},	
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 75,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		star={--�Ǽ����⽱��,�ȿ��������5�ǵ�����ʱ��,Ȼ��4��
			[1]={--1��
				_time=300,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,59,1},},
					},
				},
			[2]={--2��
				_time=240,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,60,1},},
					},
				},	
			[3]={--3��
				_time=180,
				award={--ͨ�ý�������
					[1]=0,
					[3]={{1520,61,1},},
					},
				},	
			
			},	
		items_one = {{1523,1,1},{1538,1,1},{1553,1,1},},			
		},
}

FBConfig[24] = {				-- ����󸱱�
}

FBConfig[24][1] = {
	FBName = '�����',	-- �������Q	
	VictoryCondition = '��ɱ��ħ',	--�����l������
	ICON= 2228,			-- С�D�ˣ�����
	MaxPlayer = 1,			-- ��������˔� ��Ҫ���څ^�ֆ���/�M꠸���
	bossName = '�Ļ���ħ',
	monsterNum = 22,
			
	EventList = {
		MonDeads = {					-- ���������|�l�¼��б�
			[1001] = { num = 22,EventTb = {{EventTypeTb.MonRefresh,{1,101},},},},
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},	
	},	
			
	MapList = {				-- �؈D�б�
	
		[1] = {
			MapID = 534, 		-- �؈D��̖					
													 
			MonsterList = {				-- �����б�
				[101]={ 				
					{ monsterId = 885, BRMONSTER = 1, deadbody = 6 , centerX = 11 , centerY = 27 , BRArea = 3 , camp = 5,BRNumber =20 ,deadScript =1001,},
					{ monsterId = 890, BRMONSTER = 1, deadbody = 6 , centerX = 11 , centerY = 27 , BRArea = 3 , camp = 5,BRNumber =2 ,deadScript =1001,},
					
				}, 		
			},			
			DynamicsBlock = {0},	-- �ӑB����б� 1 ����� 0 �o���		
			EnterPos = {{x = 16, y = 30}},		-- �M���c
			RelivePos = {1,15,22},				-- �}���c
		},
	},	
	

	NeedConditions = {				-- �����M��l��
		nLevel = 50,					-- ����ȼ�����			
	},	
	
	CSAwards = {					-- �����^�P����
				
	},
}

FBConfig[24][2] = {
	FBName = '�����',	-- �������Q	
	VictoryCondition = '��ɱ��ħ',	--�����l������
	ICON= 2232,			-- С�D�ˣ�����
	MaxPlayer = 1,			-- ��������˔� ��Ҫ���څ^�ֆ���/�M꠸���
	bossName = '�Ļ���ħ',
	monsterNum = 22,
			
	EventList = {
		MonDeads = {					-- ���������|�l�¼��б�
			[1001] = { num = 22,EventTb = {{EventTypeTb.MonRefresh,{1,101},},},},
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},	
	},	
			
	MapList = {				-- �؈D�б�
	
		[1] = {
			MapID = 534, 		-- �؈D��̖					
													 
			MonsterList = {				-- �����б�
				[101]={ 				
					{ monsterId = 886, BRMONSTER = 1, deadbody = 6 , centerX = 11 , centerY = 27 , BRArea = 3 , camp = 5,BRNumber =20 ,deadScript =1001,},
					{ monsterId = 891, BRMONSTER = 1, deadbody = 6 , centerX = 11 , centerY = 27 , BRArea = 3 , camp = 5,BRNumber =2 ,deadScript =1001,},
					
				}, 		
			},			
			DynamicsBlock = {0},	-- �ӑB����б� 1 ����� 0 �o���		
			EnterPos = {{x = 16, y = 30}},		-- �M���c
			RelivePos = {1,15,22},				-- �}���c
		},
	},	
	

	NeedConditions = {				-- �����M��l��
		nLevel = 61,					-- ����ȼ�����			
	},	
	
	CSAwards = {					-- �����^�P����
				
	},
}

FBConfig[24][3] = {
	FBName = '�����',	-- �������Q	
	VictoryCondition = '��ɱ��ħ',	--�����l������
	ICON= 2243,			-- С�D�ˣ�����
	MaxPlayer = 1,			-- ��������˔� ��Ҫ���څ^�ֆ���/�M꠸���
	bossName = '�Ļ���ħ',
	monsterNum = 25,
			
	EventList = {
		MonDeads = {					-- ���������|�l�¼��б�
			[1001] = { num = 25,EventTb = {{EventTypeTb.MonRefresh,{1,101},},},},
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},	
	},	
			
	MapList = {				-- �؈D�б�
	
		[1] = {
			MapID = 534, 		-- �؈D��̖					
													 
			MonsterList = {				-- �����б�
				[101]={ 				
					{ monsterId = 887, BRMONSTER = 1, deadbody = 6 , centerX = 11 , centerY = 27 , BRArea = 3 , camp = 5,BRNumber =22 ,deadScript =1001,},
					{ monsterId = 892, BRMONSTER = 1, deadbody = 6 , centerX = 11 , centerY = 27 , BRArea = 3 , camp = 5,BRNumber =3 ,deadScript =1001,},
					
				}, 		
			},			
			DynamicsBlock = {0},	-- �ӑB����б� 1 ����� 0 �o���		
			EnterPos = {{x = 16, y = 30}},		-- �M���c
			RelivePos = {1,15,22},				-- �}���c
		},
	},	
	

	NeedConditions = {				-- �����M��l��
		nLevel = 71,					-- ����ȼ�����			
	},	
	
	CSAwards = {					-- �����^�P����
				
	},
}

FBConfig[24][4] = {
	FBName = '�����',	-- �������Q	
	VictoryCondition = '��ɱ��ħ',	--�����l������
	ICON= 2226,			-- С�D�ˣ�����
	MaxPlayer = 1,			-- ��������˔� ��Ҫ���څ^�ֆ���/�M꠸���
	bossName = '�Ļ���ħ',
	monsterNum = 25,
			
	EventList = {
		MonDeads = {					-- ���������|�l�¼��б�
			[1001] = { num = 25,EventTb = {{EventTypeTb.MonRefresh,{1,101},},},},
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},	
	},	
			
	MapList = {				-- �؈D�б�
	
		[1] = {
			MapID = 534, 		-- �؈D��̖					
													 
			MonsterList = {				-- �����б�
				[101]={ 				
					{ monsterId = 888, BRMONSTER = 1, deadbody = 6 , centerX = 11 , centerY = 27 , BRArea = 3 , camp = 5,BRNumber =22 ,deadScript =1001,},
					{ monsterId = 893, BRMONSTER = 1, deadbody = 6 , centerX = 11 , centerY = 27 , BRArea = 3 , camp = 5,BRNumber =3 ,deadScript =1001,},
					
				}, 		
			},			
			DynamicsBlock = {0},	-- �ӑB����б� 1 ����� 0 �o���		
			EnterPos = {{x = 16, y = 30}},		-- �M���c
			RelivePos = {1,15,22},				-- �}���c
		},
	},	
	

	NeedConditions = {				-- �����M��l��
		nLevel = 81,					-- ����ȼ�����			
	},	
	
	CSAwards = {					-- �����^�P����
				
	},
}

FBConfig[24][5] = {
	FBName = '�����',	-- �������Q	
	VictoryCondition = '��ɱ��ħ',	--�����l������
	ICON= 2038,			-- С�D�ˣ�����
	MaxPlayer = 1,			-- ��������˔� ��Ҫ���څ^�ֆ���/�M꠸���
	bossName = '�Ļ���ħ',
	monsterNum = 25,
			
	EventList = {
		MonDeads = {					-- ���������|�l�¼��б�
			[1001] = { num = 25,EventTb = {{EventTypeTb.MonRefresh,{1,101},},},},
		},	
		Timers = {
			[1] = {num = 1,preTime = 300,EventTb = { {EventTypeTb.Failed,},},},
		},	
	},	
			
	MapList = {				-- �؈D�б�
	
		[1] = {
			MapID = 534, 		-- �؈D��̖					
													 
			MonsterList = {				-- �����б�
				[101]={ 				
					{ monsterId = 889, BRMONSTER = 1, deadbody = 6 , centerX = 11 , centerY = 27 , BRArea = 3 , camp = 5,BRNumber =22 ,deadScript =1001,},
					{ monsterId = 894, BRMONSTER = 1, deadbody = 6 , centerX = 11 , centerY = 27 , BRArea = 3 , camp = 5,BRNumber =3 ,deadScript =1001,},
					
				}, 		
			},			
			DynamicsBlock = {0},	-- �ӑB����б� 1 ����� 0 �o���		
			EnterPos = {{x = 16, y = 30}},		-- �M���c
			RelivePos = {1,15,22},				-- �}���c
		},
	},	
	

	NeedConditions = {				-- �����M��l��
		nLevel = 91,					-- ����ȼ�����			
	},	
	
	CSAwards = {					-- �����^�P����
				
	},
}

FBConfig[999] = {				-- ���Ը���
}

FBConfig[999][1] = {
	FBName = '���Ը���',	-- ��������	
	VictoryCondition = '���Ը���',	--ʤ����������
	ICON = 2044,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2044, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 1, EventTb = {{EventTypeTb.UserDefined,{func = 'ud_999001_1'},},}, },
		},				
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 504, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					{ monsterId = 38, x =81 , y=27,dir = 5 ,moveArea = 0,deadbody = 6 , deadScript = 1001 ,camp = 5, },
					
					{ monsterId = 38,imageID = 2082, x =22 , y=106,dir = 0 ,moveArea = 0,deadbody = 6 , camp = 4, },
					{ monsterId = 38,imageID = 2083, x =24 , y=106,dir = 0 ,moveArea = 0,deadbody = 6 , camp = 4, },
					{ monsterId = 38,imageID = 2084, x =26 , y=106,dir = 0 ,moveArea = 0,deadbody = 6 , camp = 4, },
					{ monsterId = 38,imageID = 2085, x =28 , y=106,dir = 0 ,moveArea = 0,deadbody = 6 , camp = 4, },
					{ monsterId = 38,imageID = 2086, x =30 , y=106,dir = 0 ,moveArea = 0,deadbody = 6 , camp = 4, },
					{ monsterId = 38,imageID = 2128, x =32 , y=104,dir = 0 ,moveArea = 0,deadbody = 6 , camp = 4, },
					{ monsterId = 38,imageID = 2129, x =34 , y=106,dir = 0 ,moveArea = 0,deadbody = 6 , camp = 4, },
					{ monsterId = 38,imageID = 2130, x =36 , y=106,dir = 0 ,moveArea = 0,deadbody = 6 , camp = 4, },
					{ monsterId = 38,imageID = 2161, x =38 , y=106,dir = 0 ,moveArea = 0,deadbody = 6 , camp = 4, },
					
					
					{ monsterId = 38,imageID = 2260, x =20 , y=115,dir = 0 ,moveArea = 0,deadbody = 6 , camp = 4, },
					{ monsterId = 38,imageID = 2261, x =22 , y=115,dir = 0 ,moveArea = 0,deadbody = 6 , camp = 4, },
					{ monsterId = 38,imageID = 2129, x =24 , y=115,dir = 0 ,moveArea = 0,deadbody = 6 , camp = 4, },
					{ monsterId = 38,imageID = 2130, x =26 , y=115,dir = 0 ,moveArea = 0,deadbody = 6 , camp = 4, },
					{ monsterId = 38,imageID = 2128, x =28 , y=115,dir = 0 ,moveArea = 0,deadbody = 6 , camp = 4, },
					{ monsterId = 38,imageID = 2262, x =30 , y=115,dir = 0 ,moveArea = 0,deadbody = 6 , camp = 4, },
					{ monsterId = 38,imageID = 2161, x =32 , y=115,dir = 0 ,moveArea = 0,deadbody = 6 , camp = 4, },
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 21, y = 99}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 1,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		item = {					-- ������Ʒ
			
		},
	},
}
FBConfig[999][2] = {
	FBName = '���Ը���2',	-- ��������	
	VictoryCondition = '���Ը���2',	--ʤ����������
	ICON = 2044,			-- Сͼ�꣨����
	MaxPlayer = 1,			-- ����������� ��Ҫ�������ֵ���/��Ӹ���
	rid = 2044, --������ԴID

	EventList = {
		MonDeads = {					-- �������������¼��б�
			[1001] = { num = 138, EventTb = {{EventTypeTb.Completion},}, },
		},				
	},		
	MapList = {				-- ��ͼ�б�
	
		[1] = {
			MapID = 527, 		-- ��ͼ���					
											 
			MonsterList = {				-- �����б�
			[101]={ 											
					
				},
			},		
					
			DynamicsBlock = {0},	-- ��̬�赲�б� 1 ���赲 0 ���赲		
			EnterPos = {{x = 2, y = 13}},		-- �����
			RelivePos = {1,2,13},				-- �����,Ϊ������ǰ����,������use = 1 ʱ��������Ч	
		},	
	},			
	NeedConditions = {				-- ������������
	nLevel = 1,					-- ����ȼ�����
	},	
	
	CSAwards = {					-- �������ؽ���	
		item = {					-- ������Ʒ
			
		},
	},
}
-------------------------------------------------------------------------
-- inner function:

-------------------------------------------------------------------------
--interface:




