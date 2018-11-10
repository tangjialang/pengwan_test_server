--[[
file:	NPC_conf.lua
desc:	npc config(S&C)1
author:	chal
update:	2011-11-30
version: 1.0.0

NPC���øĶ�˵��:
	1������ͨ����NPC���������һ��NpcType�ֶ�������ǰ̨��δ���
	2��NpcType: 
		[nil] ��Ĭ����� (��Ҫ��������NPC�͹�����NPC)
		NpcFunction = {
				{"clientFunc", "��Ӹ���(35��)",type=4},	-- NPCѡ��1
				{"clientFunc", "��������(50��)",type=5},	-- NPCѡ��2
			},
		},
		[1] ���Զ������ (��Ҫ�������⴦��NPC������:ҡǮ��)
		NpcFunction = {
				panel = 1,	-- ҡǮ�����
				panel = 2,	-- ������
				panel = 3,	-- �������
				panel = 4,	-- 槼����
				panel = 17,	-- ��Ӹ���
				panel = 25,	-- �������������
			},
		},
		[2] ����click��Ϣ (��Ҫ���ڶ�̬NPC������:�ռ���NPC����������NPC)
		Refresh=2,�ɼ����Ƴ�,2�����ˢ
�̶�NPC�������ڸ�����NPC������Ŀ���������400000���£�
	(1 ~ 399999)
	��ͨ������NPC�͹���NPC���Լ��ֶ�
	(100000 ~ 200000)--�ɼ�,regonid=0Ϊ��̬����

��̬NPC:
	(400000 ~ 699999) 

ѭ��������NPC��
	(701000 ~ 999999)��1000������  	ǧʵ����NPC ��ͬһ��NPC���ѭ������1000����
	(100000 ~ +oo)��10000������ 	��ʵ����NPC	��ͬһ��NPC���ѭ������10000����

]]--

npclist = {}

npclist = {
--���ִ�1
	[1] = {
	NpcCreate = { regionId = 3 , name = "������" , title = '������' , npcimg=11006, imageId = 1006,headID=1006, x = 95 , y = 154 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '̫��δ�л��ѹ������Ů�ʯ������������ۼ����ࡣ������ԴӦ������������һͳ�ܡ��������°˰��', },
	},
	-- [2] = {
	-- NpcCreate = { regionId = 3 , name = "��ϼͯ��" , title = '��ϼͯ��' ,  npcimg=11016, imageId = 1016,headID=1016, x = 91 , y = 139 , dir = 5, objectType = 1 , mType = 0,},
	-- NpcInfo = { talk = 'ʦ�����ڴ��������Ҷ�Զ�㣡', },
	-- },
	-- [3] = {
	-- NpcCreate = { regionId = 3 , name = "̫������" , title = '̫������' , npcimg=12050, imageId = 1231, headID=2050, x = 81 , y = 129 , dir = 4 , objectType = 1 , mType = 0,},
	-- NpcInfo = { talk = '���ڴ�ɽ�У����֪����', },
	-- },
	[4] = {
	NpcCreate = { regionId = 3 , name = "Сʦ������" , title = 'Сʦ������' , npcimg=11007, imageId = 1007,headID=1007, x = 54 , y = 151 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '����ҩ��Ҫ�����ˣ��Ҳɰ��ɰ��ɰ��ɡ�������', },
	},
	[5] = {
	NpcCreate = { regionId = 3 , name = "ͮ������" , title = 'ͮ������' , npcimg=12062, imageId = 1232,headID=2062, x = 91 , y = 175 ,  dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�����������һЩ��ͽ����Ȼ��������ɽ���ƣ��������ᡣ', },
	},
	[6] = {
	NpcCreate = { regionId = 3 , name = "������-���" , title = '������-���' , npcimg=12058, imageId = 1233,headID=2058, x = 104 , y = 201 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�����������Ȼ���أ��ҵ������ߣ��ص���ǿ��Ϣ��', },
	},
	-- [7] = {
	-- NpcCreate = { regionId = 3 , name = "а����ͷĿ" , title = 'а����ͷĿ' , npcimg=12026, imageId = 1234,headID=2026, x = 71 , y = 164 , dir = 5 , objectType = 1 , mType = 0,},
	-- NpcInfo = { talk = '��˵����ɽ���ɵ�������͵��һ�ſ������ٰ��꣬������û�л���,�ٺ�......', },
	-- },
	[8] = {
	NpcCreate = { regionId = 3 , name = "��ʦ��" , title = '��ʦ��' , npcimg=11008, imageId = 1008,headID=1008, x = 67 , y = 143 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '����ɽ�ľ�ɫ�������ƺ���Ư����', },
	},
	-- [9] = {
	-- NpcCreate = { regionId = 3 , name = "��ʦ��" , title = '��ʦ��' , npcimg=11008, imageId = 1008,headID=1008, x = 91 , y = 175 , dir = 5, objectType = 1 , mType = 0,},
	-- NpcInfo = { talk = '���ٲ���׳�ۡ�', },
	-- },
	-- [29] = {
	-- NpcCreate = { plat = 101 , regionId = 1 , name = "360��Ա��Ȩʹ��" , title = '360��Ա��Ȩʹ��' ,  npcimg=12061,imageId = 1215,headID=1021, x = 37 , y = 107 , dir = 5, objectType = 1 , mType = 10,},
	-- NpcInfo = { talk = '��¼360��ȫ��ʿ�����ɳ�Ϊ����360��Ա����ȡר����Ȩ������ȼ�Խ�ߣ�����Խ���Ŷ~', },
	-- NpcFunction = {
				-- {"clientFunc", "������ȡ",type=26},
			-- },
	-- },
--����NPC
	[30] = {
	NpcCreate = { regionId = 1 , name = "�Ƿ�ʿ��" ,  npcimg=11011, imageId = 1011,headID=1011, x = 16 , y = 137 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '����ֹ�������ʾ֤����', },
	},
	[31] = {
	NpcCreate = { regionId = 1 , name = "�ӳ���С��" ,  npcimg=11011, imageId = 1011,headID=1011, x = 45 , y = 105 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '������С�Ļ���', },
	},
	[32] = {
	NpcCreate = { regionId = 1 , name = "ҩƷ��" , title = 'ҩƷ��' , npcimg=11015, imageId = 1022,headID=1022, x = 73 , y = 150 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�����ҩ�ɣ����ڽ���Ʈ�����ܲ���������', },
	NpcFunction = {
				{"clientFunc", "����ҩƷ",type=8},
			},
	},
	[33] = {
	NpcCreate = { regionId = 1 , name = "�Ƿ����" ,  npcimg=11012, imageId = 1012,headID=1012, x = 36 , y = 55 , dir = 4 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ֻҪ����һ�����ڣ���Ҫ��֤��᪹�����������ȫ���ݡ�', },
	},
	[34] = {
	NpcCreate = { regionId = 1 , name = "�ո���Ժ" ,  npcimg=11011, imageId = 1011,headID=1011, x = 39 , y = 26 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ά���ո��İ�ȫ���ҵ�ְ��', },
	},
	[35] = {
	NpcCreate = { regionId = 1 , name = "�ո���Ů" ,  npcimg=11021, imageId = 1021,headID=1021, x = 30 , y = 153 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ϣ����ү�ܿ���һ�槼�С�㡣', },
	},
	[36] = {
	NpcCreate = { regionId = 1 , name = "�ջ�" , title = '�ջ�' , npcimg=12053, imageId = 2054,headID=2054, x = 58 , y = 24 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�����������������һ����Բ��', },
	},
	[37] = {
	NpcCreate = { regionId = 1 , name = "�ո��ܼ�" ,  npcimg=11015, imageId = 1015,headID=1015, x = 44 , y = 10 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�ո���Կ�׶������⣬��һ��Ҫ����ү���òֿ⡣', },
	},
	[38] = {
	NpcCreate = { regionId = 1 , name = "�����-�Ʒɻ�" , title = '�����-�Ʒɻ�' , npcimg=12056, imageId = 2056,headID=2056, x = 81 , y = 61 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = "����Ӹ����п��ܻ�á�<font color='#f8ee73' >������ʯ</font>��,������ܽ����ң��Ҿͽ�����<font color='#f8ee73' >��������</font>��\n    ����ͭǮ���ɻ��ÿ�ս��������л����á�<font color='#f8ee73' >��λ�ƺ�</font>����", },
	NpcFunction = {
					{"clientFunc", "��Ҫ����ͭǮ",type=17},
			},
	},
	[39] = {
	NpcCreate = { regionId = 1 , name = "�ֿ����Ա" , title = '�ֿ�' ,iconID = 2, npcimg=11015, imageId = 1015,headID=1015, x = 85 , y = 94 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�ҵı��չ񣬿��Ǿ�������ISO��N����֤��Ŷ��', },
	NpcFunction = {
					{"clientFunc", "�򿪲ֿ�",type=2},
			},
	},
	[40] = {
	NpcCreate = { regionId = 1 , name = "��߸" ,  npcimg=12059, imageId = 2059,headID=2059, x = 108 , y = 95 , dir = 4 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ƽʱ����һ��,սʱ����һ��Ѫ!', },
	},
	[41] = {
	NpcCreate = { regionId = 1 , name = "���ϰ�" , npcimg=11214,imageId = 1214,headID=1008, x = 91 , y = 130 , dir = 4 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��������ȫ�ֹ���������Ʒ����ȫ�ֻ棬���ɴ����', },
	},
	[42] = {
	NpcCreate = { regionId = 1 , name = "����ҽ" ,  npcimg=11014, imageId = 1014,headID=1014, x = 52 , y = 141 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '����С��棬�����շѣ�ר�θ���������ͯ�����ۣ�', },
	},
	[43] = {
	NpcCreate = { regionId = 1 , name = "������-����" , title = '������-����' , npcimg=11003, imageId = 1003,headID=1003, x = 109 , y = 24 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�����Ⱦ�̫��Ի������ʥ�����ܣ������ˡ���������а����̫�����Ӿ��ӡ�', },
	},

	[45] = {
	NpcCreate = { regionId = 1 , name = "����С��" ,npcimg=11021, imageId = 1021,headID=1021, x = 17 , y = 99 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�ع���𣚣�ں�֮�ޣ�����Ů�����Ӻ��ϡ�', },
	},
	[46] = {
	NpcCreate = { regionId = 1 , name = "����" , title = '����' ,npcimg=11222, imageId = 1222,headID=1222, x = 13 , y = 74 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'Ը��������ģ������˾�������ǰ��ע���£�Ī�����Ե��', },
	NpcFunction = {
				{"clientFunc", "��ȡ�ƺ�",type=14},
			},
	},
	[47] = {
	NpcCreate = { regionId = 1 , name = "����" , title = '����' , npcimg=11211,imageId = 1211,headID=1014, x = 5 , y = 60 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '���޳���׾����,ǧ����Եʹ��ǣ�����¶��ӳ����,�����޺��³�Բ��', },
	NpcFunction = {
				{"clientFunc", "�ٿ�����",type=13},
				{"clientFunc", "Э�����",type=15},
				{"clientFunc", "ǿ�����",type=16},				
			},
	},
	[48] = {
	NpcCreate = { regionId = 1 , name = "������" , title = '������' , npcimg=11006, imageId = 1034,headID=1006, x = 101 , y = 31 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '̫��δ�л��ѹ������Ů�ʯ������������ۼ����ࡣ������ԴӦ������������һͳ�ܡ��������°˰��', },
	},
	[49] = {
	NpcCreate = { regionId = 1 , name = "������-����" , title = '������-����' , npcimg=11002, imageId = 1002,headID=1002, x = 106 , y = 39 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�����޵������ٹ���֮!', },
	},
	[50] = {
	NpcCreate = { regionId = 1 , name = "���Ͱ�" , title = '���Ͱ�' ,iconID=7, imageId = 1031,headID=1031, x = 70 , y = 61 , dir = 0 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��������', },
	NpcType = 1,
	NpcFunction = {
				panel = 3,
			},
	},
	[51] = {
	NpcCreate = { regionId = 1 , name = "��ʯ����" , title = '��ʯ' ,iconID=5,  imageId = 2061,headID=2061, x = 61 , y = 63 , dir = 4 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '����ʢ����ʯ��ÿ��һ�β��ɴ����', },
	NpcType = 1,
	NpcFunction = {
				panel = 6,
			},
	},
	[52] = {
	NpcCreate = { regionId = 1 , name = "��Ӹ���" , title = '���' ,iconID=4, npcimg=12055, imageId = 2055,headID=2055, x = 67 , y = 106 , dir = 4 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��Ӹ��������񣬿��Ի�ô����ǰ󶨵Ĺ���Ʒ��ÿ�ղ��ɴ����', },
	NpcFunction = {
				{"clientFunc", "��Ӹ���",type=4},
			},
	},
	[53] = {
	NpcCreate = { regionId = 1 , name = "���ͺ�����" , title = '����' ,iconID = 1, npcimg=12061, imageId = 2002,headID=2002, x = 86 , y = 77 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�������ˣ�˭�ܰ����ͻض�������', },
	NpcType = 1,
	NpcFunction = {
				panel = 5,
			},
	},
	[54] = {
	NpcCreate = { regionId = 1 , name = "ɳ̲��Ů" , title = 'ɳ̲' ,iconID=8, npcimg=11039, imageId = 1039,headID=1039, x = 46 , y = 77 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '����ɳ̲����Ů���Ŷ��', },
	NpcFunction = {
				{"call", "ɳ̲����",func = "EnterDongHai"},
			},
	},
	[55] = {
	NpcCreate = { regionId = 1 , name = "Զ���ż�" , title = 'Զ���ż�' , iconID=13, npcimg=11008, imageId = 1008,headID=1008, x = 17 , y = 9 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��ӭ���٣�', },
	NpcType = 1,
	NpcFunction = {
				panel = 16,
			},
	},
	[56] = {
	NpcCreate = { regionId = 1 , name = "������-���" ,title = '������-���' ,  npcimg=12058, imageId = 2058,headID=2058, x = 69 , y = 36 , dir = 4 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'Ը������ʦ���ַ�������������ɷ����ҵ!', },
	},
	
	[57] = {
	NpcCreate = { regionId = 1 , name = "����ʹ��" ,title = '�һ�����' , npcimg=12059, imageId = 1219,headID=1219, x = 9 , y = 98 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��������һ������������񣬻�����������ص���!', },
	NpcFunction = {
				{"call", "�һ�����",func = "EnterGuajia"},
			},
	},
	[58] = {
	NpcCreate = { regionId = 1 , name = "���ܻ�����",title = '���ܻ�����' , iconID=14, npcimg=12062, imageId = 1232,headID=2062, x = 70 , y = 137 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '���ܻ����񣬽����ǳ����Ŷ��', },
	},		
	[59] = {
	NpcCreate = { regionId = 1 , name = "ͭǮ����" , title = 'ͭǮ' , iconID=10, imageId = 1232,headID=2062, x = 55 , y = 66 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ͭǮ��࣬ÿ�ղ��ɴ��!', },
	NpcType = 1,
	NpcFunction = {
				panel = 7,
			},
	},
	
	[60] = {
	NpcCreate = { regionId = 1 , name = "��������" , title = '����' , iconID=3, imageId = 2052,headID=2052, x = 76 , y = 105 , dir = 4 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '���Ѷȿ��飬���ǵ��������˵֮ʯ�����Ժϳɳ�ɫװ��Ŷ!', },
	NpcType = 1,
	NpcFunction = {
				panel = 8,
			},
	},
	[61] = {
	NpcCreate = { regionId = 1 , name = "���鸱��" , title = '���鸱��',iconID=12, npcimg=12050,imageId = 2051,headID=2051, x = 45 , y = 86 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '���鸱���У�ÿ�տ��Ի�ô�������!', },
	NpcType = 1,
	NpcFunction = {
				panel = 15,
			},
	},
	[62] = {
	NpcCreate = { regionId = 1 , name = "ˮ����" ,   npcimg=11021,imageId = 1025,headID=1025, x = 56 , y = 133 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '���ʵ�ˮ����!', },
	},
	[63] = {
	NpcCreate = { regionId = 1 , name = "�޹���" ,   npcimg=11020, imageId = 1020,headID=1020, x = 83 , y = 124 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�Ⲽƥ����Ҫ��Ҫ�������������·��أ�', },
	},
	[64] = {
	NpcCreate = { regionId = 1 , name = "�η�" ,  npcimg=11017,  imageId = 1017,headID=1017, x = 22 , y = 97 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�͹�Ҫ��Ҫ���Σ�100�ľͿ���������᪳ǣ�', },
	},
	[65] = {
	NpcCreate = { regionId = 1 , name = "���޸���", title = '���޸���',iconID=22,  imageId = 1020,headID=1020, x = 16 , y = 69 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 23,
			},
	},
	[66] = {
	NpcCreate = { regionId = 1 , name = "��ؤ" ,   npcimg=11026, imageId = 1026,headID=1026, x = 6 , y = 164 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '���ž������·�ж����ǰ���', },
	},
	
	[68] = {
	NpcCreate = { regionId = 1 , name = "лС��" ,  npcimg=11021, imageId = 1025,headID=1025, x = 14 , y = 46 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '����ɡ�����������������ɡ����', },
	},
	[69] = {
	NpcCreate = { regionId = 1 , name = "���ֹ�" ,    npcimg=11013, imageId = 1013,headID=1013, x = 90 , y = 26 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '˵�����֣�����ܹ�֮�񣬴�����׵İɣ�', },
	},
	[70] = {
	NpcCreate = { regionId = 1 , name = "���ֹ�" ,  npcimg=11013, imageId = 1013,headID=1013, x = 107 , y = 49 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�����û���������������ֹ�Ҳ�Ǹ��������', },
	},
	[71] = {
	NpcCreate = { regionId = 1 , name = "��������" , title = '��������',iconID=20, imageId = 2063,headID=2063, x = 46 , y = 94 , dir = 3 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 21,
			},
	},
	[72] = {
	NpcCreate = { regionId = 1 , name = "����װ��" , title = '����װ��',iconID=21, imageId = 2060,headID=2060, x = 88 , y = 85 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 22,
			},
	},
	[73] = {
	NpcCreate = { regionId = 1 , name = "���Ǹ���", title = '���Ǹ���',iconID=23, imageId = 2057,headID=2057,  x = 66 , y = 63 , dir = 4 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 24,
			},
	},
	[74] = {
	NpcCreate = { regionId = 1 , name = "��������", title = '��������',iconID=24, imageId = 2065,headID=2065,  x = 60 , y = 104 , dir = 4 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 26,
			},
	},	
	
--��᪽�ҰNPC	
	[101] = {
	NpcCreate = { regionId = 6 , name = "���˵Ĵ���" , title = '���˵Ĵ���' , npcimg=11209,  imageId = 1209,headID=1024, x = 22 , y = 124 , dir = 4 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�ö����ְ���˭���Ⱦ��ң�', },
	},
	[102] = {
	NpcCreate = { regionId = 6 , name = "�ϴ峤" , title = '�ϴ峤' , npcimg=11023, imageId = 1023,headID=1023, x = 59 , y = 86 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'Ҷ����������������Ҳ���������뿪��������ţ���ӻ���', },
	},
	[103] = {
	NpcCreate = { regionId = 6 , name = "������" , title = '������' ,npcimg=11200,  imageId = 1200,headID=1200, x = 61 , y = 49 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '���ֱ���Ұ����Ҷ�һ���Ϲ�ͷ�ˣ�ҧ��������', },
	},
	[104] = {
	NpcCreate = { regionId = 6 , name = "������ʿ" , title = '������ʿ' , npcimg=11217,  imageId = 1217,headID=1217, x = 48 , y = 49 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '����̫�࣬�ɺ���ѧ�ղ���������������������', },
	},
	[105] = {
	NpcCreate = { regionId = 6 , name = "������" , title = '������' , npcimg=11009, imageId = 1009,headID=1009, x = 5 , y = 69 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '����Խ��Խ�أ�ԩ�궼�ܳ����ˣ�', },
	},
	[106] = {
	NpcCreate = { regionId = 6 , name = "ԩ��ͳ��" ,  npcimg=11010, imageId = 1010,headID=1010, x = 16 , y = 40 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'Ѫ......��......����......', },
	},
	[107] = {
	NpcCreate = { regionId = 6 , name = "�����Ĵ���" , npcimg=11201,  imageId = 1201,headID=1024, x = 56 , y = 126 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '���������ӿ���ô����~', },
	},
	[108] = {
	NpcCreate = { regionId = 6 , name = "���ֵĴ���" ,  npcimg=11024, imageId = 1024,headID=1024, x = 38 , y = 82 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�ö࣬�ö����ְ�!������~', },
	},
	
	--������NPC
	[150] = {
	NpcCreate = { regionId = 8 , name = "�ܱ����ܼ�" , title = '�ܱ����ܼ�' , npcimg=11015, imageId = 1015,headID=1015, x = 67 , y = 15 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��ã����Ǽ���ү���ڼң�', },
	},
	[151] = {
	NpcCreate = { regionId = 8 , name = "��¥�ϰ�" , title = '��¥�ϰ�' ,npcimg=11022, imageId = 1022,headID=1022, x = 30 , y = 24 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�������ڵ����ⲻ��������', },
	},
	[152] = {
	NpcCreate = { regionId = 8 , name = "�Ƿ��ӳ�" , title = '�Ƿ��ӳ�' ,npcimg=11210,  imageId = 1210,headID=1011, x = 30 , y = 63 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��Ҳ�Ҫ�������ߣ�ע��ʯ����������ǰ����ϴ��......', },
	},
	[153] = {
	NpcCreate = { regionId = 8 , name = "ҩ���ϰ�" , title = 'ҩ���ϰ�' , npcimg=11014, imageId = 1014,headID=1014, x = 47 , y = 74 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�������߲�ͬѰ����ҩ�ﾹȻ��ȫ��Ч����֡�', },
	},
	[154] = {
	NpcCreate = { regionId = 8 , name = "���ȴ�ʦ" , title = '���ȴ�ʦ' , npcimg=11205, imageId = 1205,headID=1205, x = 8 , y = 43 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ʩ�����������࣬���ҷ���Ե����', },
	},
	[155] = {
	NpcCreate = { regionId = 8 , name = "��������-�" , title = '�������ܱ�' , npcimg=12051, imageId = 2051,headID=2051, x = 57 , y = 55 , dir = 4, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�ɶ��������������Ϊ��ɢ�������ˣ�', },
	},
	[156] = {
	NpcCreate = { regionId = 8 , name = "ʧҵ������" , title = 'ʧҵ������' , npcimg=11026, imageId = 1026,headID=1026, x = 64 , y = 99 , dir = 4, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�ɶ������Щ��������ô�ˣ���˿񱩡�', },
	},
	[157] = {
	NpcCreate = { regionId = 8 , name = "��߸" , title = '��߸' , npcimg=12052, imageId = 2052,headID=2052, x = 67 , y = 134 , dir = 4, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��������С�������ó��˽���ҵ�������������', },
	},
	[158] = {
	NpcCreate = { regionId = 8 , name = "���ɩ" , title = '���ɩ' , npcimg=11200,  imageId = 1200,headID=1200, x = 31 , y = 127 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '���ǿ����ĵ��ð�~', },
	},
	[159] = {
	NpcCreate = { regionId = 8 , name = "����" , title = '����' ,npcimg=11013, imageId = 1207,headID=1013, x = 42 , y = 114 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�����޷�������������ô���', },
	},
	[160] = {
	NpcCreate = { regionId = 8 , name = "������ˮ" , title = '������ˮ' , npcimg=11017, imageId = 1017,headID=1017, x = 14 , y = 94 , dir = 4, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ʲôʱ����ܳ�������', },
	},
	[161] = {
	NpcCreate = { regionId = 8 , name = "ľ��Фʦ��" , title = 'ľ��Фʦ��' , npcimg=11017, imageId = 1206,headID=1017, x = 53 , y = 85 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��Ҫ�ż�����������', },
	},
	

	
	--ǬԪɽNPC
	[200] = {
	NpcCreate = { regionId = 7 , name = "����ͯ��" , title = '����ͯ��' , npcimg=11016, imageId = 1016,headID=1016, x = 80 , y = 26 , dir = 4, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '������Զ�����������ֺ���', },
	},
	[201] = {
	NpcCreate = { regionId = 7 , name = "�����" , title = '�����' , npcimg=12060, imageId = 1203,headID=1020, x = 71 , y = 53 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ʦ���������������У�������ȥ�Ϳ��Լ�������', },
	},
	[202] = {
	NpcCreate = { regionId = 7 , name = "̫������" , title = '̫������' ,npcimg=12050,  imageId = 2050,headID=2050, x = 41 , y = 17 , dir = 4, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��ͽ����߸�����д�һ�٣���������Υ��', },
	},
	[203] = {
	NpcCreate = { regionId = 7 , name = "������" , title = '������' , npcimg=11218, imageId = 1218,headID=1218, x = 42 , y = 44 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '���ղͷ���¶��Ҫ���������͸����ˡ�', },
	},
	[204] = {
	NpcCreate = { regionId = 7 , name = "��߸" , title = '����ͯ��' , npcimg=12052, imageId = 2052,headID=2052, x = 54 , y = 78 , dir = 4, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '���������ֻ������������������������������������̤��ϼ����֡���Ƥ���ڰ����£������и���������ʥ��Ϊ��һ��ʷ���ű������¡�', },
	},
	[205] = {
	NpcCreate = { regionId = 7 , name = "���ɾ�ʿ" , title = '���ɾ�ʿ' , npcimg=11013, imageId = 1207,headID=1013, x = 28 , y = 54 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ǬԪɽ�Ͻ������ޣ��ǲ����ѣ���������ɱ����', },
	},
	[206] = {
	NpcCreate = { regionId = 7 , name = "��ϼͯ��" , title = '��ϼͯ��' , npcimg=11016, imageId = 1016,headID=1016, x = 28 , y = 77 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ǬԪ��ɽ�������̫�Ծ���Ī������ʲô�ɾ��ˣ�', },
	},
	[207] = {
	NpcCreate = { regionId = 7 , name = "�����" , title = '�����' , npcimg=11008, imageId = 1008,headID=1008, x = 7 , y = 44 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ʦ��˵��ش�ٽ��������˻��ң���������ǬԪɽҲ�������������', },
	},
	[208] = {
	NpcCreate = { regionId = 7 , name = "�ض�ͯ��" ,  npcimg=11016, imageId = 1016,headID=1016, x = 10 , y = 20 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��ⶴ����������󣬹���Ǻ���Ī��������Ǳ���ˣ�', },
	},
	--[[
	[209] = {
	NpcCreate = { regionId = 32 , name = "������ʹ��" , title = '������ʹ��' , npcimg=12061,imageId = 1215,headID=1021, x = 50 , y = 48 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��лӢ�ۣ��ͻ���������', },
	NpcFunction = {
				{"call", "��ɻ���",func = "GI_endescortnpc"},
			},
	},
	]]--
	[210] = {
	NpcCreate = { regionId = 32 , name = "���������ʹ" , title = '���������ʹ' , npcimg=12061,imageId = 1221,headID=1021, x = 49 , y = 9 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��лӢ�ۣ��ͻ���������', },
	NpcFunction = {
				{"call", "��ɻ���",func = "GI_endescortnpc"},
			},
	},
	
	[211] = {
		NpcCreate = { regionId = 7 , name = "��������" , npcimg=11008,imageId = 1164,headID=1164, x = 46 , y = 96 , dir = 0 , objectType = 1 , mType = 0},		
		NpcInfo = { talk = '���������Ⱦ���������������', },	
		},	
	[212] = {
		NpcCreate = { regionId = 7 , name = "�ɻ�����Ů" , imageId = 1163,headID=1163, x = 43 , y = 87 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[213] = {
		NpcCreate = { regionId = 7 , name = "�ɻ�����Ů" , imageId = 1169,headID=1169, x = 51 , y = 93 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	--ǬԪ��ɽ	
	[215] = {
	NpcCreate = { regionId = 34 , name = "���ɾ�ʿ" , title = '���ɾ�ʿ' , npcimg=11013, imageId = 1207,headID=1013, x = 8 , y = 18 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ǬԪɽ�Ͻ������ޣ��ǲ����ѣ���������ɱ����', },
	},	
	[216] = {
	NpcCreate = { regionId = 34 , name = "�����" , title = '�����' , npcimg=12060, imageId = 1203,headID=1020, x = 32 , y = 22 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '������ô��ù���ɭɭ��һ�������Ρ�', },
	},
	[217] = {
	NpcCreate = { regionId = 34 , name = "������" , title = '������' , npcimg=11218, imageId = 1218,headID=1218, x = 11 , y = 50 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�������У��þò������֣������Ƕ��������ˣ�', },
	},
	[218] = {
	NpcCreate = { regionId = 34 , name = "�����" , title = '�����' , npcimg=11008, imageId = 1008,headID=1008, x = 39 , y = 90 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�������գ��ҽ�����Ҫմ����ħ����Ѫ�ˡ�', },
	},
	[219] = {
	NpcCreate = { regionId = 34 , name = "ħ����ʿ" , title = 'ħ����ʿ' ,  npcimg=11010, imageId = 1010,headID=1010, x = 4 , y = 75 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ǬԪɽ�Ǻõط������������棬�����Ϊ������......�ٺ�......', },
	},
	
	--ɳ̲NPC
	[250] = {
	NpcCreate = { regionId = 100 , name = "��������" , imageId = 1152,headID=1152, x = 28 , y = 29, dir = 0 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 11,
			},
	},
	[251] = {
	NpcCreate = { regionId = 100 ,  name = "���ݹ���" , imageId = 1153,headID=1153, x = 38 , y = 18 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 11,
			},
	},
	[252] = {
	NpcCreate = { regionId = 100 , name = "������" , imageId = 1154,headID=1154, x = 34 , y = 28 , dir = 0 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 11,
			},
	},
	[253] = {
	NpcCreate = { regionId = 100 , name = "С��Ů" , imageId = 1155,headID=1155, x = 38 , y = 23 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 11,
			},
	},
	[254] = {
	NpcCreate = { regionId = 100 , name = "������" , imageId = 1156,headID=1156, x = 20 , y = 42 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 11,
			},
	},
	[255] = {
	NpcCreate = { regionId = 100 , name = "��������" , imageId = 1157,headID=1157, x = 19 , y = 40 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 11,
			},
	},
	[256] = {
	NpcCreate = { regionId = 100 , name = "������" , imageId = 1158,headID=1158, x = 16 , y = 37 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 11,
			},
	},
	[257] = {
	NpcCreate = { regionId = 100 ,  name = "������Ů" , imageId = 1159,headID=1159, x = 28 , y = 22 , dir = 0 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 11,
			},
	},
		--����
	[258] = {
	NpcCreate = { regionId = 11 , name = "����ܹ�" ,iconID=15, title = '����ܹ�' , npcimg=11013, imageId = 1013,headID=1013, x = 6 , y = 104 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '����������Ի���������ǰ����ͥ��', },
	NpcFunction = {
			{"clientFunc", "��ʼ����(�����򸱰���)",type=9},
			{"clientFunc", "ͶעѺ��",type=11},
		},
	},
	[259] = {
	NpcCreate = { regionId = 11 , name = "�칬����" , iconID=15, title = '�칬����' ,npcimg=11013, imageId = 1013,headID=1013, x = 123 , y = 25 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��ͥѡ�㿪ʼ�ˣ��ټ���������������ͥ��', },
	NpcFunction = {
			{"clientFunc", "��ɻ���",type=10},
		},
	},
	
	[260] = {
	NpcCreate = { regionId = 100 , name = "����һ�" , title = '����һ�',iconID=19,npcimg=11039, imageId = 1039,headID=1039, x = 23 , y = 35 , dir = 3 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 20,
			},
	},


	--������NPC
	[280] = {
	NpcCreate = { regionId = 101 ,  name = "����������" ,iconID=9, imageId = 2058,headID=2058, x = 16 , y = 9 , dir = 4 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 25,
			},
	},
	[281] = {
	NpcCreate = { regionId = 101 ,  name = "����������" ,iconID=9, imageId = 1012,headID=1012, x = 10 , y = 10 , dir = 3 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 25,
			},
	},
	[282] = {
	NpcCreate = { regionId = 101 ,  name = "����������" ,iconID=9, imageId = 1012,headID=1012, x = 5 , y = 15 , dir = 3 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 25,
			},
	},
	[283] = {
	NpcCreate = { regionId = 101 ,  name = "����������" ,iconID=9, imageId = 1012,headID=1012, x = 4 , y = 24 , dir = 3 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 25,
			},
	},
	[284] = {
	NpcCreate = { regionId = 101 ,  name = "����������" ,iconID=9, imageId = 1012,headID=1012, x = 27 , y = 24 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 25,
			},
	},
	[285] = {
	NpcCreate = { regionId = 101 ,  name = "����������" ,iconID=9, imageId = 1012,headID=1012, x = 26 , y = 15 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 25,
			},
	},
	[286] = {
	NpcCreate = { regionId = 101 ,  name = "����������" ,iconID=9, imageId = 1012,headID=1012, x = 22 , y = 10 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 25,
			},
	},
	--μˮNPC
	[300] = {
	NpcCreate = { regionId = 10 , name = "���ү" , title = '���ү',  npcimg=11023, imageId = 1023,headID=1023, x = 11 , y = 120 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '����������ҵģ�С���ӻ������ڼ���Ƚϰ�ȫ.', },
	},
	[301] = {
	NpcCreate = { regionId = 10 , name = "С����" ,   npcimg=11007, imageId = 1007,headID=1007, x = 12 , y = 118 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '����ȥ���飬����үү˵�����Σ��.', },
	},
	[302] = {
	NpcCreate = { regionId = 10 , name = "��������" , title = '��������',  npcimg=11013, imageId = 1207,headID=1013, x = 30 , y = 159 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '����ѧ���Ƕ��ؼң��������Ͽ��ˣ������ô�찡.', },
	},
	[303] = {
	NpcCreate = { regionId = 10 , name = "��ͯ" , title = '��ͯ',  npcimg=11016, imageId = 1016,headID=1016, x = 41 , y = 165 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��˽�ӽ�����μˮ�����������ﵷ�ң�С�������ܲ�����ô�����Զ�������������.', },
	},
	[304] = {
	NpcCreate = { regionId = 10 , name = "�Ƶ��ϰ�" , title = '�Ƶ��ϰ�', npcimg=11022, imageId = 1022,headID=1022, x = 10 , y = 149 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��Щ����֮ͽһֱ��ռ�г������ⶼû�����ˣ���!', },
	},
	[305] = {
	NpcCreate = { regionId = 10 , name = "μˮ���" , title = 'μˮ���' , npcimg=11017, imageId = 1017,headID=1017, x = 48 , y = 100 , dir = 4, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '������ô��ͻȻ����һЩ�����������Ժ���ô�����Ӱ���', },
	},
	[306] = {
	NpcCreate = { regionId = 10 , name = "�����" , title = '�����' , npcimg=11008, imageId = 2057,headID=2057, x = 25 , y = 70 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ħ�����ֵܸ����������棬���ɴ���!', },
	},
	[307] = {
	NpcCreate = { regionId = 10 , name = "������" , title = '������' , npcimg=12055, imageId = 2055,headID=2055, x = 8 , y = 31 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�������о��ٶ඼���£�ͨͨ������!', },
	},
	[308] = {
	NpcCreate = { regionId = 10 ,  name = "��߸",title = "��߸" ,  npcimg=12059, imageId = 2059,headID=2059, x = 39 , y = 20 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�������о��ٶ඼���£�ͨͨ������!', },
	},
	[309] = {
	NpcCreate = { regionId = 10 , name = "����" ,title = "����" ,npcimg=11202, imageId = 1202,headID=1202, x = 29 , y = 126 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '������ɽ�������ι��!', },
	},
	[310] = {
	NpcCreate = { regionId = 10 , name = "��������" , npcimg=11024, imageId = 1024,headID=1024, x = 64 , y = 79 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '����Ը��������!', },
	},
	[311] = {
	NpcCreate = { regionId = 10 , name = "����Ů��" , npcimg=11021, imageId = 1025,headID=1025, x = 65 , y = 79 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�ڵ�ԸΪ����֦!', },
	},
	[312] = {
	NpcCreate = { regionId = 10 , name = "С����" ,title = 'С����' , npcimg=11021, imageId = 1021,headID=1021, x = 68 , y = 75 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'Ϊʲô�¸绹û�����ǲ���·�ϳ����ˣ�', },
	},
	[313] = {
	NpcCreate = { regionId = 10 , name = "���˵�ʿ��" , title = '���˵�ʿ��' ,npcimg=11209,  imageId = 1209,headID=1024, x = 54 , y = 38 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '.......', },
	},
	[314] = {
	NpcCreate = { regionId = 10 , name = "���ҽʦ" ,  npcimg=11014, imageId = 1014,headID=1014,x = 52 , y = 38 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '���Ҷ�������һ���˿ɲ��ᰡ!', },
	},
	[315] = {
	NpcCreate = { regionId = 10 , name = "ũ��" , title = 'ũ��' , imageId = 1201,headID=1024, x = 119 , y = 15 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '������ũ��ɽȪ���е������ȫ����������ˣ�����', },
	},
	[316] = {
	NpcCreate = { regionId = 10 , name = "��ؤ" , title = '��ؤ' ,  npcimg=11026, imageId = 1026,headID=1026, x = 118 , y = 66 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ս��ʲôʱ����ܽ�������', },
	},
	[317] = {
	NpcCreate = { regionId = 10 , name = "�Ʒɻ�" ,title = '�Ʒɻ�' ,  npcimg=12056, imageId = 2056,headID=2056, x = 73 , y = 110 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��λ������񣬲������̾���������', },
	},
	[318] = {
	NpcCreate = { regionId = 10 , name = "����" ,title = '����' ,  npcimg=11012, imageId = 1012,headID=1012, x = 73 , y = 105 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�����޵У�', },
	},
	[319] = {
	NpcCreate = { regionId = 10 , name = "��߸" ,title = '��߸' , npcimg=12052, imageId = 2052,headID=2052, x = 106 , y = 82 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ʮ�����ͬС�ɣ����治��!', },
	},
	[320] = {
	NpcCreate = { regionId = 10 , name = "�ܾ�ʿ��" ,   npcimg=11011, imageId = 1011,headID=1011, x = 83 , y = 112 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�ȣ�����ɱ�У�', },
	},
	[321] = {
	NpcCreate = { regionId = 10 , name = "�ܾ�ʿ��" ,   npcimg=11011, imageId = 1011,headID=1011, x = 86 , y = 110 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�ȣ�����ɱ�У�', },
	},
	[322] = {
	NpcCreate = { regionId = 10 , name = "�ܾ�ʿ��" ,   npcimg=11011, imageId = 1011,headID=1011, x = 73 , y = 121 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�ȣ�����ɱ�У�', },
	},
	[323] = {
	NpcCreate = { regionId = 10 , name = "�ܾ�ʿ��" ,   npcimg=11011, imageId = 1011,headID=1011, x = 70 , y = 124 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�ȣ�����ɱ�У�', },
	},
	[324] = {
	NpcCreate = { regionId = 10 , name = "�ܾ�ʿ��" ,   npcimg=11011, imageId = 1011,headID=1011, x = 65 , y = 121 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�ȣ�����ɱ�У�', },
	},
	[325] = {
	NpcCreate = { regionId = 10 , name = "�ܾ�ʿ��" ,   npcimg=11011, imageId = 1011,headID=1011, x = 61 , y = 117 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�ȣ�����ɱ�У�', },
	},
	[326] = {
	NpcCreate = { regionId = 10 , name = "�ܾ�ʿ��" ,   npcimg=11011, imageId = 1011,headID=1011, x = 57 , y = 113 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�ȣ�����ɱ�У�', },
	},
	[327] = {
	NpcCreate = { regionId = 10 , name = "�ܾ�ʿ��" ,   npcimg=11011, imageId = 1011,headID=1011, x = 54 , y = 110 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�ȣ�����ɱ�У�', },
	},
	
	--��ҰNPC
	
	[350] = {
	NpcCreate = { regionId = 12 , name = "�Ʒɻ�" ,title = '�Ʒɻ�' ,  npcimg=12056, imageId = 2056,headID=2056, x = 4 , y = 212 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��λ�����ƴɱ��ʤ��������ǰ��', },
	},
	[351] = {
	NpcCreate = { regionId = 12 , name = "ū��ͷ��" ,title = 'ū��ͷ��' ,  npcimg=12131, imageId = 2131,headID=2131, x = 7 , y = 190 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ʲôʱ���Ҳ��ܰ����Ɐ�ҵ����ˣ�', },
	},
	[352] = {
	NpcCreate = { regionId = 12 , name = "���ҽʦ" ,title = '���ҽʦ' ,  npcimg=11014, imageId = 1014,headID=1014, x = 4 , y = 198 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '������ս�����治ֵǮ���ܾ�һ����һ���ɣ�', },
	},
	[353] = {
	NpcCreate = { regionId = 12 , name = "ǰ���" ,title = 'ǰ���' ,  npcimg=11012, imageId = 1012,headID=1012, x = 79 , y = 212 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '����ǰ����ʲô���裬���޷��赲�Ҿ�ǰ���Ĳ�����', },
	},
	[354] = {
	NpcCreate = { regionId = 12 , name = "��߸" ,title = '��߸' ,  npcimg=12059, imageId = 2059,headID=2059, x = 34 , y = 117 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��һ��Ҫ�Ȼʦ�壡', },
	},
	[355] = {
	NpcCreate = { regionId = 12 , name = "��̽" ,title = '��̽' ,  npcimg=12137, imageId = 2137,headID=2137, x = 6 , y = 146 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�㿴�����ң��㿴�����ң�', },
	},
	[356] = {
	NpcCreate = { regionId = 12 , name = "�깫��" ,title = '�깫��' ,  npcimg=12233, imageId = 2233,headID=2233, x = 110 , y = 25 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '�ҽ����ҵķ����ɾ����ϴ����', },
	},
	[357] = {
	NpcCreate = { regionId = 12 , name = "Ͷ��������" ,title = 'Ͷ��������' ,  npcimg=12229, imageId = 2229,headID=2229, x = 76, y = 108 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��������������ɣ�', },
	},
	
	--����NPC
	[370] = {
	NpcCreate = { regionId = 13 , name = "�Ʒɻ�" ,title = '�Ʒɻ�' ,  npcimg=12056, imageId = 2056,headID=2056, x = 41 , y = 153 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��λ�����ƴɱ��ʤ��������ǰ��', },
	},
	[371] = {
	NpcCreate = { regionId = 13 , name = "�����Ա" ,title = '�����Ա' ,  npcimg=11209, imageId = 1209,headID=1209, x = 11 , y = 137 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��һ��Ҫ�ȳ��ӳ���', },
	},
	[372] = {
	NpcCreate = { regionId = 13 , name = "���ӳ�" ,title = '���ӳ�' ,  npcimg=11012, imageId = 1012,headID=1012, x = 53 , y = 129 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��һ��Ҫ���ֵ��Ǿȳ�ȥ��', },
	},
	[373] = {
	NpcCreate = { regionId = 13 , name = "���" ,title = '���' ,  npcimg=12058, imageId = 2058,headID=2058, x = 37 , y = 157 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '����һ��Ҫ�����Ǳ���������', },
	},
	[374] = {
	NpcCreate = { regionId = 13 , name = "���ͷ��" ,title = '���ͷ��' ,  npcimg=11012, imageId = 1012,headID=1012, x = 82 , y = 129 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '������ڵ���������ħ�����Ʒǳ�Σ����', },
	},
	[375] = {
	NpcCreate = { regionId = 13 , name = '����ԩ��', title = "����ԩ��" , imageId = 2244,headID=2244, x = 57 , y = 41 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'һ���ƾɵ�Ĺ��', },
	},
	[376] = {
	NpcCreate = { regionId = 13 , name = '������Ů', title = "������Ů" , npcimg=11021, imageId = 1021,headID=1021, x = 64 , y = 19 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '������������͵£�ȴ������������', },
	},
	[377] = {
	NpcCreate = { regionId = 13 , name = '�ƾɵ�Ĺ��', title = "�ƾɵ�Ĺ��" , imageId = 1029,headID=1029, x = 43 , y = 8 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'һ���ƾɵ�Ĺ��', },
	},
	[378] = {
	NpcCreate = { regionId = 32 , name = '������ʹ��', title = "������ʹ��" , npcimg=12061,imageId = 1221,headID=1021, x = 5 , y = 17 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'ϣ�����˶���ƽ����', },
	},
	
	
	
	
	
	
	--װ����NPC
	[1000] = {
	NpcCreate = { regionId = 1 , name = "����" ,  npcimg=11011, imageId = 1011,headID=1011, x = 51 , y = 25 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��᪵İ�ȫ�����������ػ���', },
	},
	[1001] = {
	NpcCreate = { regionId = 1 , name = "����" ,  npcimg=11011, imageId = 1011,headID=1011, x = 58 , y = 32 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��᪵İ�ȫ�����������ػ���', },
	},
	[1002] = {
	NpcCreate = { regionId = 1 , name = "����" ,  npcimg=11011, imageId = 1011,headID=1011, x = 18 , y = 31 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��᪵İ�ȫ�����������ػ���', },
	},
	[1003] = {
	NpcCreate = { regionId = 1 , name = "����" ,  npcimg=11011, imageId = 1011,headID=1011, x = 76 , y = 57 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��᪵İ�ȫ�����������ػ���', },
	},
	[1004] = {
	NpcCreate = { regionId = 1 , name = "����" ,  npcimg=11011, imageId = 1011,headID=1011, x = 85 , y = 64 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��᪵İ�ȫ�����������ػ���', },
	},
	[1005] = {
	NpcCreate = { regionId = 1 , name = "����" ,  npcimg=11011, imageId = 1011,headID=1011, x = 94 , y = 52 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��᪵İ�ȫ�����������ػ���', },
	},
	[1006] = {
	NpcCreate = { regionId = 1 , name = "����" , npcimg=11011, imageId = 1011,headID=1011, x = 86 , y = 44 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��᪵İ�ȫ�����������ػ���', },
	},
	[1007] = {
	NpcCreate = { regionId = 1 , name = "������" ,  npcimg=11012, imageId = 1012,headID=1012, x = 92 , y = 36 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��᪵İ�ȫ�����������ػ���', },
	},
	[1008] = {
	NpcCreate = { regionId = 1 , name = "������" ,  npcimg=11012, imageId = 1012,headID=1012, x = 101 , y = 45 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��᪵İ�ȫ�����������ػ���', },
	},
	[1009] = {
	NpcCreate = { regionId = 1 , name = "����" ,  npcimg=11011, imageId = 1011,headID=1011, x = 76 , y = 26 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��᪵İ�ȫ�����������ػ���', },
	},
	[1010] = {
	NpcCreate = { regionId = 1 , name = "����" ,  npcimg=11011, imageId = 1011,headID=1011, x = 71 , y = 31 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��᪵İ�ȫ�����������ػ���', },
	},
	[1011] = {
	NpcCreate = { regionId = 1 , name = "����" ,  npcimg=11011, imageId = 1011,headID=1011, x = 66 , y = 39 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��᪵İ�ȫ�����������ػ���', },
	},
	[1012] = {
	NpcCreate = { regionId = 1 , name = "����" ,  npcimg=11011, imageId = 1011,headID=1011, x = 106 , y = 59 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��᪵İ�ȫ�����������ػ���', },
	},
	[1013] = {
	NpcCreate = { regionId = 1 , name = "����" ,  npcimg=11011, imageId = 1011,headID=1011, x = 100 , y = 75 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '��᪵İ�ȫ�����������ػ���', },
	},
	[1014] = {
	NpcCreate = { regionId = 1 , name = "����" ,  npcimg=11011, imageId = 1011,headID=1011, x = 111 , y = 123 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'MerryChristmas��', },
	},
	
	--�Ի������NPC
	
	[1020] = {
	NpcCreate = { regionId = 22 , name = "���ӵ�ͨ����" , imageId = 2030,headID=2030, x = 11 , y = 82 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '������ץ�ҵ��𣿺ٺ٣�', },
	},
	[1021] = {
	NpcCreate = { regionId = 31 , name = "���ӵ�ͨ����" , imageId = 2066,headID=2017, x = 7 , y = 6 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '������ץ�ҵ��𣿺ٺ٣�', },
	},
	[1022] = {
	NpcCreate = { regionId = 10 , name = "���ӵ�ͨ����" , imageId = 2136,headID=2136, x = 111 , y = 10 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '������ץ�ҵ��𣿺ٺ٣�', },
	},
	[1023] = {
	NpcCreate = { regionId = 7 , name = "���ӵ�ͨ����" , imageId = 2133,headID=2133, x = 47 , y = 113 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '������ץ�ҵ��𣿺ٺ٣�', },
	},
	
	
	----�ɼ���NPC
	[100001] = {
			NpcCreate = {  regionId = 3, name = '�����', title = "" , imageId = 1027,headID=1027,  x = 58, y = 155, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10001,1,1}}},
			action = { 995, 4},
			PreTaskID={1004,1508,1590},
			NoDel=1,
			ProgressTips=1,
		},
	[100002] = {
			NpcCreate = {  regionId = 3, name = '�����', title = "" , imageId = 1027,headID=1027,  x = 56, y = 154, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10001,1,1}}},
			action = { 995, 4},
			PreTaskID={1004,1508,1590},
			NoDel=1,
			ProgressTips=1,
		},
	[100003] = {
			NpcCreate = {  regionId = 3, name = '�����', title = "" , imageId = 1027,headID=1027,  x = 56, y = 161, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10001,1,1}}},
			action = { 995, 4},
			PreTaskID={1261,1508,1590},
			NoDel=1,
			ProgressTips=1,
		},
	[100004] = {
			NpcCreate = {  regionId = 3, name = '�����', title = "" , imageId = 1027,headID=1027,  x = 58, y = 161, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10001,1,1}}},
			action = { 995, 4},
			PreTaskID=1261,
			NoDel=1,
			ProgressTips=1,
		},
	----�ɼ���NPC
	[100005] = {
			NpcCreate = {  regionId = 1, name = 'ɹ�ɵ�ҩ��', title = "" , imageId = 1028,headID=1028,  x = 70, y = 154, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10002,1,1}}},
			action = { 995, 4},
			PreTaskID={1063,1625},
			NoDel=1,
			ProgressTips=1,
		},	
	[100006] = {
			NpcCreate = {  regionId = 1, name = 'ɹ�ɵ�ҩ��', title = "" , imageId = 1028,headID=1028,  x = 68, y = 151, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10002,1,1}}},
			action = { 995, 4},
			PreTaskID={1063,1625},
			NoDel=1,
			ProgressTips=1,
		},		
	[100007] = {
			NpcCreate = {  regionId = 1, name = 'ɹ�ɵ�ҩ��', title = "" , imageId = 1028,headID=1028,  x = 68, y = 156, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10002,1,1}}},
			action = { 995, 4},
			PreTaskID={1063,1625},
			NoDel=1,
			ProgressTips=1,
		},	
	[100008] = {
			NpcCreate = {  regionId = 1, name = 'ɹ�ɵ�ҩ��', title = "" , imageId = 1028,headID=1028,  x = 73, y = 157, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10002,1,1}}},
			action = { 995, 4},
			PreTaskID={1063,1625},
			NoDel=1,
			ProgressTips=1,
		},	
	----�ɼ���NPC
	[100010] = {
			NpcCreate = {  regionId = 6, name = '���ƹű�', title = "" , imageId = 1029,headID=1029,  x = 30, y = 61, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10003,1,1}}},
			action = { 995, 4},
			PreTaskID=1103,
			NoDel=1,
			ProgressTips=1,
		},	
	[100011] = {
			NpcCreate = {  regionId = 6, name = '�ӹǲ�', title = "" , imageId = 1027,headID=1027,  x = 64, y = 107, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10007,1,1}}},
			action = { 995, 4},
			PreTaskID=1099,
			NoDel=1,
			ProgressTips=1,
		},
	[100012] = {
			NpcCreate = {  regionId = 10, name = '�ӹǲ�', title = "" , imageId = 1027,headID=1027,  x = 75, y = 63, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10007,1,1}}},
			action = { 995, 4},
			PreTaskID=1371,
			NoDel=1,
			ProgressTips=1,
		},
	[100013] = {
			NpcCreate = {  regionId = 10, name = '��ֵ�Ĺ��', title = "" , imageId = 1029,headID=1029,  x = 101, y = 7, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10003,1,1}}},
			action = { 995, 4},
			PreTaskID=1424,
			NoDel=1,
			ProgressTips=1,
		},		
	[100014] = {
			NpcCreate = {  regionId = 10, name = 'ħ������', title = "" , imageId = 1150,headID=1150,  x = 52, y = 150, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10006,1,1}}},
			action = { 995, 4},
			PreTaskID={1360,1509,1592,1626},
			NoDel=1,
			ProgressTips=1,
		},	
	[100015] = {
			NpcCreate = {  regionId = 10, name = 'ħ������', title = "" , imageId = 1150,headID=1150,  x = 55, y = 153, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10006,1,1}}},
			action = { 995, 4},
			PreTaskID={1360,1509,1592,1626},
			NoDel=1,
			ProgressTips=1,
		},	
	[100016] = {
			NpcCreate = {  regionId = 10, name = 'ħ������', title = "" , imageId = 1150,headID=1150,  x = 58, y = 156, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10006,1,1}}},
			action = { 995, 4},
			PreTaskID={1360,1509,1592,1626},
			NoDel=1,
			ProgressTips=1,
		},	
----�ɼ���NPC
	[100020] = {
			NpcCreate = {  regionId = 8, name = 'ľ��', title = "" , imageId = 1030,headID=1030,  x = 41, y = 83, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10004,1,1}}},
			action = { 995, 4},
			PreTaskID=1164,
			NoDel=1,
			ProgressTips=1,
		},	
	[100021] = {
			NpcCreate = {  regionId = 8, name = 'ľ��', title = "" , imageId = 1030,headID=1030,  x = 44, y = 79, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10004,1,1}}},
			action = { 995, 4},
			PreTaskID=1164,
			NoDel=1,
			ProgressTips=1,
		},	
	[100022] = {
			NpcCreate = {  regionId = 8, name = 'ľ��', title = "" , imageId = 1030,headID=1030,  x = 41, y = 88, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10004,1,1}}},
			action = { 995, 4},
			PreTaskID=1164,
			NoDel=1,
			ProgressTips=1,
		},	
	[100023] = {
			NpcCreate = {  regionId = 8, name = 'ľ��', title = "" , imageId = 1030,headID=1030,  x = 47, y = 81, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10004,1,1}}},
			action = { 995, 4},
			PreTaskID=1164,
			NoDel=1,
			ProgressTips=1,
		},	
	[100024] = {
			NpcCreate = {  regionId = 8, name = 'ľ��', title = "" , imageId = 1030,headID=1030,  x = 52, y = 89, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10004,1,1}}},
			action = { 995, 4},
			PreTaskID=1164,
			NoDel=1,
			ProgressTips=1,
		},	
		----�ɼ���NPC
	[100025] = {
			NpcCreate = {  regionId = 34, name = '������', title = "" , imageId = 1143,headID=1143,  x = 31, y = 72, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10005,1,1}}},
			action = { 995, 4},
			PreTaskID={1317},
			NoDel=1,
			ProgressTips=1,
		},		
	[100026] = {
			NpcCreate = {  regionId = 7, name = '������', title = "" , imageId = 1143,headID=1143,  x = 43, y = 95, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10005,1,1}}},
			action = { 995, 4},
			PreTaskID={1263,2032},
			NoDel=1,
			ProgressTips=1,
		},	
	[100027] = {
			NpcCreate = {  regionId = 8, name = '�����', title = "" , imageId = 1150,headID=1150,  x = 74, y = 127, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10006,1,1}}},
			action = { 995, 4},
			PreTaskID={1262,1623},
			NoDel=1,
			ProgressTips=1,
		},	
	[100028] = {
			NpcCreate = {  regionId = 8, name = '�����', title = "" , imageId = 1150,headID=1150,  x = 72, y = 128, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10006,1,1}}},
			action = { 995, 4},
			PreTaskID={1262,1623},
			NoDel=1,
			ProgressTips=1,
		},
	[100029] = {
			NpcCreate = {  regionId = 8, name = '�����', title = "" , imageId = 1150,headID=1150,  x = 76, y = 125, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10006,1,1}}},
			action = { 995, 4},
			PreTaskID={1262,1623},
			NoDel=1,
			ProgressTips=1,
		},	
	[100030] = {
			NpcCreate = {  regionId = 8, name = '�����', title = "" , imageId = 1150,headID=1150,  x = 70, y = 130, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10006,1,1}}},
			action = { 995, 4},
			PreTaskID={1262,1623},
			NoDel=1,
			ProgressTips=1,
		},	
	[100031] = {
			NpcCreate = {  regionId = 0, name = 'ǧ����֥',imageId = 1240,headID=1240,  x = 12, y = 17, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=3,	
			NpcType = 2,
			product={ [3] = {{10008,1,1}}},
			action = { 995, 4},	
			PreTaskID={6003,6008,6013,6018,6023,6028,6033,6038,6043,6048,6053,6058},
			ProgressTips=1,
		},	
	[100032] = {
			NpcCreate = {  regionId = 0, name = 'ǧ����֥',imageId = 1240,headID=1240,  x = 8, y = 19, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=3,	
			NpcType = 2,
			product={ [3] = {{10008,1,1}}},
			action = { 995, 4},	
			PreTaskID={6003,6008,6013,6018,6023,6028,6033,6038,6043,6048,6053,6058},
			ProgressTips=1,
		},	
	[100033] = {
			NpcCreate = {  regionId = 0, name = 'ǧ����֥',imageId = 1240,headID=1240,  x = 5, y = 24, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=3,	
			NpcType = 2,
			product={ [3] = {{10008,1,1}}},
			action = { 995, 4},	
			PreTaskID={6003,6008,6013,6018,6023,6028,6033,6038,6043,6048,6053,6058},
			ProgressTips=1,
		},	
	[100034] = {
			NpcCreate = {  regionId = 0, name = 'ǧ����֥',imageId = 1240,headID=1240,  x = 8, y = 29, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=3,	
			NpcType = 2,
			product={ [3] = {{10008,1,1}}},
			action = { 995, 4},	
			PreTaskID={6003,6008,6013,6018,6023,6028,6033,6038,6043,6048,6053,6058},
			ProgressTips=1,
		},	
	[100035] = {
			NpcCreate = {  regionId = 0, name = 'ǧ����֥',imageId = 1240,headID=1240,  x = 12, y = 32, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=3,	
			NpcType = 2,
			product={ [3] = {{10008,1,1}}},
			action = { 995, 4},	
			PreTaskID={6003,6008,6013,6018,6023,6028,6033,6038,6043,6048,6053,6058},
			ProgressTips=1,
		},		
	[100036] = {
			NpcCreate = {  regionId = 0, name = 'ǧ����֥',imageId = 1240,headID=1240,  x = 16, y = 29, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=3,	
			NpcType = 2,
			product={ [3] = {{10008,1,1}}},
			action = { 995, 4},	
			PreTaskID={6003,6008,6013,6018,6023,6028,6033,6038,6043,6048,6053,6058},
			ProgressTips=1,
		},	
	[100037] = {
			NpcCreate = {  regionId = 0, name = 'ǧ����֥',imageId = 1240,headID=1240,  x = 18, y = 24, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=3,	
			NpcType = 2,
			product={ [3] = {{10008,1,1}}},
			action = { 995, 4},	
			PreTaskID={6003,6008,6013,6018,6023,6028,6033,6038,6043,6048,6053,6058},
			ProgressTips=1,
		},	
	[100038] = {
			NpcCreate = {  regionId = 0, name = 'ǧ����֥',imageId = 1240,headID=1240,  x = 16, y = 19, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=3,	
			NpcType = 2,
			product={ [3] = {{10008,1,1}}},
			action = { 995, 4},	
			PreTaskID={6003,6008,6013,6018,6023,6028,6033,6038,6043,6048,6053,6058},
			ProgressTips=1,
		},	
    [100039] = {
			NpcCreate = {  regionId = 0, name = 'Զ������¯',imageId = 1241,headID=1241,  x = 54, y = 53, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=12,	
			NpcType = 2,
			product={ [3] = {{10009,1,1}}},
			action = { 995, 4},	
			PreTaskID={6004,6009,6014,6019,6024,6029,6034,6039,6044,6049,6054,6059},
			ProgressTips=1,
		},	
    [100040] = {
			NpcCreate = {  regionId = 0, name = 'Զ������¯',imageId = 1241,headID=1241,  x = 54, y = 63, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=15,	
			NpcType = 2,
			product={ [3] = {{10009,1,1}}},
			action = { 995, 4},	
			PreTaskID={6004,6009,6014,6019,6024,6029,6034,6039,6044,6049,6054,6059},
			ProgressTips=1,
		},	
    [100041] = {
			NpcCreate = {  regionId = 0, name = 'Զ������¯',imageId = 1241,headID=1241,  x = 58, y = 58, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=18,	
			NpcType = 2,
			product={ [3] = {{10009,1,1}}},
			action = { 995, 4},	
			PreTaskID={6004,6009,6014,6019,6024,6029,6034,6039,6044,6049,6054,6059},
			ProgressTips=1,
		},	
    [100042] = {
			NpcCreate = {  regionId = 0, name = 'Զ������¯',imageId = 1241,headID=1241,  x = 62, y = 53, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=20,	
			NpcType = 2,
			product={ [3] = {{10009,1,1}}},
			action = { 995, 4},	
			PreTaskID={6004,6009,6014,6019,6024,6029,6034,6039,6044,6049,6054,6059},
			ProgressTips=1,
		},		
    [100043] = {
			NpcCreate = {  regionId = 0, name = 'Զ������¯',imageId = 1241,headID=1241,  x = 62, y = 63, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=15,	
			NpcType = 2,
			product={ [3] = {{10009,1,1}}},
			action = { 995, 4},	
			PreTaskID={6004,6009,6014,6019,6024,6029,6034,6039,6044,6049,6054,6059},
			ProgressTips=1,
		},		

	[400001] = {
		NpcCreate = { regionId = 0 , name = "ҡǮ��" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400002] = {
		NpcCreate = { regionId = 0 , name = "ҡǮ��" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400003] = {
		NpcCreate = { regionId = 0 , name = "ҡǮ��" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400004] = {
		NpcCreate = { regionId = 0 , name = "ҡǮ��" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400005] = {
		NpcCreate = { regionId = 0 , name = "ҡǮ��" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400006] = {
		NpcCreate = { regionId = 0 , name = "ҡǮ��" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400007] = {
		NpcCreate = { regionId = 0 , name = "ҡǮ��" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400008] = {
		NpcCreate = { regionId = 0 , name = "ҡǮ��" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400009] = {
		NpcCreate = { regionId = 0 , name = "ҡǮ��" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400010] = {
		NpcCreate = { regionId = 0 , name = "ҡǮ��" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400100] = {--Ĭ��ҡǮ��
		NpcCreate = { regionId = 0 , name = "ҡǮ��" , title = '' , imageId = 1120,headID=1120, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400101] = {--槼�
		NpcCreate = { regionId = 0 , name = "槼�(Ů��)" , title = 'Ů��' ,npcimg=11004, imageId = 1033,headID=1004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '��ӭ���˻ؼң�', },
		NpcType = 1,
		NpcFunction = {
				panel = 4,
			},
		},
	[400201] = {
		NpcCreate = { regionId = 0 , name = "������Ů" , imageId = 1172,headID=1172, x = 8 , y = 9 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[400202] = {
		NpcCreate = { regionId = 0 , name = "������Ů" , imageId = 1171,headID=1171, x = 11 , y = 7 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[400203] = {
		NpcCreate = { regionId = 0 , name = "������Ů"  ,imageId = 1168,headID=1168, x = 11 , y = 12 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[400204] = {
		NpcCreate = { regionId = 0 , name = "������Ů" , imageId = 1170,headID=1170, x = 22 , y = 15 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[400205] = {
		NpcCreate = { regionId = 0 , name = "������Ů"  ,imageId = 1162,headID=1162, x = 26 , y = 16 , dir = 5 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[400206] = {
		NpcCreate = { regionId = 0 , name = "������Ů" , imageId = 1157,headID=1157, x = 29 , y = 17 , dir = 5 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[400207] = {
		NpcCreate = { regionId = 0 , name = "������Ů" , imageId = 1156,headID=1156, x = 30 , y = 22 , dir = 5 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[400208] = {
		NpcCreate = { regionId = 0 , name = "������Ů" , imageId = 1160,headID=1160, x = 34 , y = 25 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},
	[400209] = {
		NpcCreate = { regionId = 0 , name = "������Ů" , imageId = 1161,headID=1161, x = 39 , y = 36 , dir = 6 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},
	[400210] = {
		NpcCreate = { regionId = 0 , name = "������Ů" , imageId = 1163,headID=1163, x = 25 , y = 48 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},		
	[400211] = {
		NpcCreate = { regionId = 0 , name = "������Ů" , imageId = 1169,headID=1169, x = 20 , y = 37 , dir = 5 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[400212] = {
		NpcCreate = { regionId = 0 , name = "������Ů" , imageId = 1164,headID=1164, x = 13 , y = 33 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	
	[400301] = {
		NpcCreate = { regionId = 0 , name = "����ȷ��" , title = '����ȷ��' , npcimg=12052, imageId = 1165,headID=2052, x = 85 , y = 15 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '������ύˮ���󣬿�����������һ���ս�����֣�', },
			NpcFunction = {
						{"call", "�ύ��ʯ",func = "GI_sjzc_submit_res"},
					},
			},
	[400302] = {
		NpcCreate = { regionId = 0 , name = "�˽��ȷ��" , title = '�˽��ȷ��' , npcimg=12056, imageId = 1166,headID=2056, x = 6 , y = 81 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '������ύˮ���󣬿�����������һ���ս�����֣�', },
			NpcFunction = {
						{"call", "�ύ��ʯ",func = "GI_sjzc_submit_res"},
					},
			},	
	[400303] = {
		NpcCreate = { regionId = 0 , name = "ħ���ȷ��" , title = 'ħ���ȷ��' , npcimg=11010, imageId = 1167,headID=1010, x = 90 , y = 148 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '������ύˮ���󣬿�����������һ���ս�����֣�', },
			NpcFunction = {
						{"call", "�ύ��ʯ",func = "GI_sjzc_submit_res"},
					},
			},
	[400304] = {
		NpcCreate = { regionId = 0 , name = "ͭ����" , title = 'ͭ����' , imageId = 2119,headID=1144, x = 56 , y = 73 , dir = 5, objectType = 1 , mType = 0,clickScript = 50002,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 2,
		ProgressTips = 1,	
	},		
	[400305] = {
		NpcCreate = { regionId = 0 , name = "������" , title = '������' , imageId = 2118,headID=1144, x = 56 , y = 73 , dir = 5, objectType = 1 , mType = 0,clickScript = 50002,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 2,
		ProgressTips = 1,	
	},
	[400306] = {
		NpcCreate = { regionId = 0 , name = "����" , title = '����' , imageId = 2117,headID=1144, x = 56 , y = 73 , dir = 5, objectType = 1 , mType = 0,clickScript = 50002,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 2,
		ProgressTips = 1,	
	},
	
	[400401] = {
		NpcCreate = { regionId = 0 , name = "����ܹ�" , title = '����ܹ�' , npcimg=11032, imageId = 1032,headID=1032,x = 19 , y = 14 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = 'ս�����飬����������ѵİ��գ���ʩ��Ԯ�֣����лر���', },
			NpcFunction = {
						{"call", "��ɻ���",func = "GI_ff_submit_res"},
					},
		},
	[400402] = {
		NpcCreate = { regionId = 0 , name = "����ܹ�" , title = '����ܹ�' , npcimg=11032, imageId = 1032,headID=1032,x = 3 , y = 168 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = 'ս�����飬����������ѵİ��գ���ʩ��Ԯ�֣����лر���', },
			NpcFunction = {
						{"call", "��ɻ���",func = "GI_ff_submit_res"},
					},
		},
	[400403] = {
		NpcCreate = { regionId = 0 , name = "����ܹ�" , title = '����ܹ�' , npcimg=11032, imageId = 1032,headID=1032,x = 88 , y = 159 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = 'ս�����飬����������ѵİ��գ���ʩ��Ԯ�֣����лر���', },
			NpcFunction = {
						{"call", "��ɻ���",func = "GI_ff_submit_res"},
					},
		},	
		
	
	[400410] = {
		NpcCreate = { regionId = 0 , name = "��������Ů" , title = '��������Ů' , imageId = 1137,headID=1137, x = 49 , y = 82 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		PBType=3,	
		NpcType = 2,
		ProgressTips = 1,	
	},
	[400411] = {
		NpcCreate = { regionId = 0 , name = "��������Ů" , title = '��������Ů' , imageId = 1137,headID=1137, x = 65 , y = 99 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		PBType=3,	
		NpcType = 2,
		ProgressTips = 1,	
	},
	[400412] = {
		NpcCreate = { regionId = 0 , name = "��������Ů" , title = '��������Ů' , imageId = 1137,headID=1137, x = 49 , y = 116 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		PBType=3,
		NpcType = 2,
		ProgressTips = 1,	
	},
	[400413] = {
		NpcCreate = { regionId = 0 , name = "��������Ů" , title = '��������Ů' , imageId = 1137,headID=1137, x = 34 , y = 98 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		PBType=3,
		NpcType = 2,
		ProgressTips = 1,	
	},
	[400430] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 7 , y = 156 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400431] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 8 , y = 157 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400432] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 9 , y = 158 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400433] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 10 , y = 159 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400434] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 23 , y = 49 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400435] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 24 , y = 48 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400436] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 25 , y = 47 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400437] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 26 , y = 46 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400438] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 78 , y = 154 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400439] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 79 , y = 153 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400440] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 80 , y = 152 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400441] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 81 , y = 151 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400442] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 82 , y = 150 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400443] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 83 , y = 149 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400444] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 11 , y = 160 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400445] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 12 , y = 161 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400446] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 13 , y = 162 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400447] = {
		NpcCreate = { regionId = 0 , name = "դ��" ,imageId = 1239,headID=1137, x = 14 , y = 163 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},	
	----����
	[400500] = {
		NpcCreate = {  regionId = 0, name = '����', title = "����" ,iconID=18, imageId = 1181,headID=1181,  x = 56, y = 69, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50020},
		NpcType = 2,
		ProgressTips = 1,	
		PBType=5,		
	},
	----��е�ܹ�
	[400501] = {
		NpcCreate = { regionId = 0 , name = "��е�ܹ�" ,iconID=17, title = '��е�ܹ�' , npcimg=11013, imageId = 1013,headID=1013, x = 12 , y = 112 , dir = 3 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '����������Թ��򹥳Ǵ������ƻ�������ٶȻ�ӿ�ܶ࣡', },
		NpcFunction = {
				{"clientFunc", "���򹥳Ǵ���",type=12},
			},	
	},
	[400502] = {
		NpcCreate = { regionId = 0 , name = "��������" ,   imageId = 1013,headID=1013, x = 67 , y = 84 , dir = 0 , objectType = 1 , mType = 0,},
		NpcType = 1,
		NpcFunction = {
				panel = 19,
			},		
	},
	-----�콵����400510-400550
	[400510] = {
			NpcCreate = {  regionId = 0, name = '����������',imageId = 1244,headID=1244,  x = 37, y = 54, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=20,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400511] = {
			NpcCreate = {  regionId = 0, name = '��������',imageId = 1245,headID=1245,  x = 15, y = 23, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400512] = {
			NpcCreate = {  regionId = 0, name = '�׻�����',imageId = 1246,headID=1246,  x = 65, y = 74, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400513] = {
			NpcCreate = {  regionId = 0, name = '��ȸ����',imageId = 1247,headID=1247,  x = 58, y = 27, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400514] = {
			NpcCreate = {  regionId = 0, name = '���䱦��',imageId = 1248,headID=1248,  x = 10, y = 74, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400515] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 13, y = 102, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400516] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 14 ,y = 80, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400517] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 5, y = 80, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400518] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 5, y = 70, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400519] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 12, y = 70, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400520] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 4, y = 47, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400521] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 8, y = 33, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400522] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 19, y = 33, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400523] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 20, y = 19, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400524] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 9, y = 22, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400525] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 38, y = 16, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400526] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 52, y = 23, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400527] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 64, y = 25, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400528] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 63, y = 33, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400529] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 53, y = 32, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400530] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 70, y = 51, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400531] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 69, y = 69, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400532] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 60, y = 70, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400533] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 62, y = 80, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400534] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 70, y = 79, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	--���Ѱ�� 400550 - 400553
	
	[400550] = {
			NpcCreate = {  regionId = 0, name = '��������',imageId = 1245,headID=1245,  x = 72, y = 108, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50022},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400551] = {
			NpcCreate = {  regionId = 0, name = '������',imageId = 1246,headID=1246,  x = 68, y = 58, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50022},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400552] = {
			NpcCreate = {  regionId = 0, name = '��챦��',imageId = 1247,headID=1247,  x = 98, y = 150, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50022},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400553] = {
			NpcCreate = {  regionId = 0, name = '��䱦��',imageId = 1248,headID=1248,  x = 37, y = 137, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50022},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	
	--��� �콵����
	-----�콵����400510-400550
	[400560] = {
			NpcCreate = {  regionId = 0, name = '����������',imageId = 1244,headID=1244,  x = 37, y = 54, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=20,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400561] = {
			NpcCreate = {  regionId = 0, name = '��������',imageId = 1245,headID=1245,  x = 15, y = 23, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400562] = {
			NpcCreate = {  regionId = 0, name = '�׻�����',imageId = 1246,headID=1246,  x = 65, y = 74, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400563] = {
			NpcCreate = {  regionId = 0, name = '��ȸ����',imageId = 1247,headID=1247,  x = 58, y = 27, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400564] = {
			NpcCreate = {  regionId = 0, name = '���䱦��',imageId = 1248,headID=1248,  x = 10, y = 74, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400565] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 13, y = 102, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400566] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 14 ,y = 80, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400567] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 5, y = 80, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400568] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 5, y = 70, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400569] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 12, y = 70, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400570] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 4, y = 47, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400571] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 8, y = 33, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400572] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 19, y = 33, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400573] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 20, y = 19, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400574] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 9, y = 22, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400575] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 38, y = 16, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400576] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 52, y = 23, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400577] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 64, y = 25, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400578] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 63, y = 33, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400579] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 53, y = 32, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400580] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 70, y = 51, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400581] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 69, y = 69, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400582] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 60, y = 70, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400583] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 62, y = 80, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400584] = {
			NpcCreate = {  regionId = 0, name = '����',imageId = 1249,headID=1249,  x = 70, y = 79, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	
	--��� ����ս�� 400601 ~ 400603
	[400601] = {
		NpcCreate = { regionId = 0 , name = "����ȷ��" , title = '����ȷ��' , npcimg=12052, imageId = 1165,headID=2052, x = 85 , y = 15 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '������ύˮ���󣬿�����������һ���ս�����֣�', },
			NpcFunction = {
						{"call", "�ύ��ʯ",func = "GI_span_sjzc_submit_res"},
					},
			},
	[400602] = {
		NpcCreate = { regionId = 0 , name = "�˽��ȷ��" , title = '�˽��ȷ��' , npcimg=12056, imageId = 1166,headID=2056, x = 6 , y = 81 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '������ύˮ���󣬿�����������һ���ս�����֣�', },
			NpcFunction = {
						{"call", "�ύ��ʯ",func = "GI_span_sjzc_submit_res"},
					},
			},	
	[400603] = {
		NpcCreate = { regionId = 0 , name = "ħ���ȷ��" , title = 'ħ���ȷ��' , npcimg=11010, imageId = 1167,headID=1010, x = 90 , y = 148 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '������ύˮ���󣬿�����������һ���ս�����֣�', },
			NpcFunction = {
						{"call", "�ύ��ʯ",func = "GI_span_sjzc_submit_res"},
					},
			},
	
	
	----���˸���NPC
	 ----��ⶴ����   --Nodel=1 �ɼ�����ʧ ProBarType = 1�ռ� 2���� 3��� 4���ؿ��� fight = 1 �ɼ��������Զ��һ�
	[500001] = {
		NpcCreate = { regionId = 0 , name = "����Ů����" , title = '����Ů����' , npcimg=11052, imageId = 1007,headID=1007, x = 40 , y = 38 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 2,
	},
	[500015] = {
		NpcCreate = { regionId = 0 , name = "��¯" , title = '��¯' , npcimg=11052, imageId = 1151,headID=1151, x = 24 , y = 61 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 2,
		ProgressTips = 1,	
		PBType=4,	 
  		fight = 1,
    },
	[500016] = {
		NpcCreate = { regionId = 0 , name = "��¯" , title = '��¯' , npcimg=11052, imageId = 1151,headID=1151, x = 24 , y = 61 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 2,
		ProgressTips = 1,	
		PBType=4,     
		fight = 1,
	
    },
   	
	 ----��ⶴһ��
	[500002] = {
		NpcCreate = { regionId = 0 , name = "Ů����" , title = 'Ů����' , npcimg=11052, imageId = 1221,headID=1221, x = 11 , y = 26 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 2,
	},
	[500003] = {
		NpcCreate = { regionId = 0 , name = "����" , title = '����' , npcimg=11052, imageId = 1144,headID=1144, x = 43 , y = 15 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 1,
		NpcFunction = {
				panel = 17,
			},
	},
	[500004] = {
		NpcCreate = { regionId = 0 , name = "����" , title = '����' , npcimg=11052, imageId = 1144,headID=1144, x = 5 , y = 69 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 1,
		NpcFunction = {
				panel = 18,
			},
	},
	[500014] = {
		NpcCreate = { regionId = 0 , name = "��¯" , title = '��¯' , npcimg=11052, imageId = 1151,headID=1151, x = 24 , y = 61 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 2,
		ProgressTips = 1,	
		PBType=4,
		fight = 1,
		
    },
    ----����һ��
	
	[500012] = {
		NpcCreate = { regionId = 0 , name = "��ͯ" , title = '��ͯ' , npcimg=11052, imageId = 1147,headID=1147, x = 12 , y = 8 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 2,
		ProgressTips = 1,	
		PBType=3,	
		fight = 1,
	},
	 ----��������
	[500005] = {
		NpcCreate = { regionId = 0 , name = "����" , title = '����' , npcimg=11052, imageId = 1144,headID=1144, x = 43 , y = 15 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 2,
		ProgressTips = 1,
		NoDel=1,		
	},
	 ----��������1
	[500006] = {
		NpcCreate = { regionId = 0 , name = "����" , title = '����' , npcimg=11052, imageId = 1144,headID=1144, x = 2 , y = 36 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 2,
		ProgressTips = 1,
		NoDel=1,
	},
	 ----��������
	[500007] = {
		NpcCreate = { regionId = 0 , name = "����" , title = '����' , npcimg=11052, imageId = 1144,headID=1144, x = 12 , y = 8 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 2,
		ProgressTips = 1,
		NoDel=1,		
	},
	[500009] = {
		NpcCreate = { regionId = 0 , name = "��ͯ" , title = '��ͯ' , npcimg=11052, imageId = 1147,headID=1147, x = 12 , y = 8 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 2,
		ProgressTips = 1,	
		PBType=3,	
		fight = 1,	
	},
	[500010] = {
		NpcCreate = { regionId = 0 , name = "��ͯ" , title = '��ͯ' , npcimg=11052, imageId = 1147,headID=1147, x = 12 , y = 8 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 2,
		ProgressTips = 1,	
		PBType=3,
		fight = 1,
	},
	[500011] = {
		NpcCreate = { regionId = 0 , name = "Ůͯ" , title = 'Ůͯ' , npcimg=11052, imageId = 1148,headID=1148, x = 12 , y = 8 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 2,
		ProgressTips = 1,	
		PBType=3,	
		fight = 1,
	},
	----��߸����
	[500008] = {
		NpcCreate = { regionId = 0 , name = "����" , title = '����' , npcimg=11052, imageId = 1144,headID=1144, x = 12 , y = 8 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 2,
		ProgressTips = 1,
		NoDel=1,	
	},
	----�����ջ�
	[500013] = {
		NpcCreate = { regionId = 0 , name = "ʯ��" , title = 'ʯ��' , npcimg=11052, imageId = 1029,headID=1029, x = 24 , y = 61 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = 'ף��һ·˳�磡', },
		NpcType = 2,
		ProgressTips = 1,	
		PBType=4,
		fight = 1,
    },
		
	[701000] = {
		NpcCreate = { regionId = 0 , name = "��ϯ" , title = '���Ծ�' ,npcimg=11052, imageId = 1130,headID=1130, x = 21 , y = 47 , dir = 0 , objectType = 1 , mType = 0},
		NpcInfo = { talk = '��ϯ��Ϣ', },	
		NpcType = 1,
		NpcFunction = {
			panel = 2,
		},
	},
	[702000] = {
		NpcCreate = { regionId = 0 , name = "������ϯ" , title = '���Ծ�' ,npcimg=11052, imageId = 1131,headID=1131, x = 21 , y = 47 , dir = 0 , objectType = 1 , mType = 0},
		NpcInfo = { talk = '��ϯ��Ϣ', },		
		NpcType = 1,
		NpcFunction = {
			panel = 2,
		},
	},
	[703000] = {
		NpcCreate = { regionId = 0 , name = "Ѽ��" , imageId = 1141,headID=1141, x = 21 , y = 47 , dir = 5 , objectType = 1 , mType = 0,clickScript = 60008,},
		NpcInfo = { talk = '��ϯ��Ϣ', },		
		NpcType = 2,
		ProgressTips = 1,
	},
	
	[704000] = {
		NpcCreate = {  regionId = 0, name = 'ˮ����', title = "ˮ����" ,layered = true, imageId = 1180,headID=1180,  x = 85, y = 96, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50001},
		NpcType = 2,
		action = { 995, 4},
		ProgressTips=1,	
		
	},	
	[705000] = {
		NpcCreate = {  regionId = 0, name = 'ˮ����', title = "ˮ����" ,layered = true, imageId = 1178,headID=1178,  x = 86, y = 103, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50001},
		NpcType = 2,
		action = { 995, 4},
		ProgressTips=1,
	},	
			
	[706000] = {
		NpcCreate = { regionId = 0 , name = "��Ҷ��" , imageId = 1138,headID=1138, x = 21 , y = 47 , dir = 5 , objectType = 1 , mType = 0,clickScript = 60009,},
		NpcInfo = { talk = '��ϯ��Ϣ', },		
		NpcType = 1,
		ProgressTips = 1,
		NpcFunction = {
				panel = 12,
		},
	},
	[707000] = {
		NpcCreate = { regionId = 0 , name = "��Ҷ��" , imageId = 1139,headID=1139, x = 21 , y = 47 , dir = 5 , objectType = 1 , mType = 0,clickScript = 60009,},
		NpcInfo = { talk = '��ϯ��Ϣ', },		
		NpcType = 1,
		ProgressTips = 1,
		NpcFunction = {
			panel = 12,
		},
	},
	[708000] = {
		NpcCreate = { regionId = 0 , name = "��Ҷ��" , imageId = 1140,headID=1140, x = 21 , y = 47 , dir = 5 , objectType = 1 , mType = 0,clickScript = 60009,},
		NpcInfo = { talk = '��ϯ��Ϣ', },		
		NpcType = 1,
		ProgressTips = 1,
		NpcFunction = {
			panel = 12,
		},
	},
	[709000] = {
			NpcCreate = {  regionId = 0, name = 'ˮ����', title = "ˮ����" , layered = true,imageId = 1178,headID=1178,  x = 86, y = 103, dir = 7, objectType = 1,dir = 0 , mType = 10,clickScript = 50001},
			NpcType = 2,
			action = { 995, 4},
			ProgressTips=1,
	},	
	[711000] = {
		NpcCreate = { regionId = 0 , name = "��ͨ����" , title = '���Ծ�' ,npcimg=11052, imageId = 1130,headID=1130, x = 21 , y = 47 , dir = 0 , objectType = 1 , mType = 0,clickScript = 60040},
		NpcInfo = { talk = '��ϯ��Ϣ', },	
		NpcType = 2,		
	},
	[712000] = {
		NpcCreate = { regionId = 0 , name = "��������" , title = '���Ծ�' ,npcimg=11052, imageId = 1131,headID=1131, x = 21 , y = 47 , dir = 0 , objectType = 1 , mType = 0,clickScript = 60040},
		NpcInfo = { talk = '��ϯ��Ϣ', },		
		NpcType = 2,		
	},
	[713000] = {
		NpcCreate = {  regionId = 0, name = 'ˮ����', title = "ˮ����" ,layered = true, imageId = 1180,headID=1180,  x = 85, y = 96, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50003},
		NpcType = 2,
		action = { 995, 4},
		ProgressTips=1,	
		
	},	
	[714000] = {
		NpcCreate = {  regionId = 0, name = 'ˮ����', title = "ˮ����" ,layered = true, imageId = 1178,headID=1178,  x = 86, y = 103, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50003},
		NpcType = 2,
		action = { 995, 4},
		ProgressTips=1,
	},	
	[715000] = {
			NpcCreate = {  regionId = 0, name = 'ˮ����', title = "ˮ����" , layered = true,imageId = 1178,headID=1178,  x = 86, y = 103, dir = 7, objectType = 1,dir = 0 , mType = 10,clickScript = 50003},
			NpcType = 2,
			action = { 995, 4},
			ProgressTips=1,
	},
	-- --�������������
	-- [713000] = {
	-- NpcCreate = { regionId = 101 ,  name = "����������" ,iconID=9, imageId = 1012,headID=1012, x = 27 , y = 24 , dir = 5 , objectType = 1 , mType = 0,},
	-- NpcType = 1,
	-- NpcFunction = {
	-- 			panel = 25,
	-- 		},
	-- },
}	
