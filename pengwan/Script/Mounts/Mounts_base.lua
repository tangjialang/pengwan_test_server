 --[[
file:Mounts_conf.lua
desc:����ͨ�����÷���
author:xiao.y
update:2013-7-1
refix:	done by xy
]]--
--[[����û�����
  	CAT_MAX_HP	= 0,		// Ѫ������ 1
	CAT_MAX_MP,				// ְҵ���� 2
	CAT_ATC,				// ���� 3
	CAT_DEF,				// ���� 4
	CAT_HIT,				// ���� 5
	CAT_DUCK,				// ���� 6
	CAT_CRIT,				// ���� 7
	CAT_RESIST,				// �ֿ� 8
	CAT_BLOCK,				// �� 9
	CAT_AB_ATC,				// ְҵ����1����ϵ���ԣ� 10
	CAT_AB_DEF,				// ְҵ����2����ϵ���ԣ� 11
	CAT_CritDam,			// ְҵ����3��ľϵ���ԣ�12
	CAT_MoveSpeed,			// �ƶ��ٶ�(Ԥ��) 13
	CAT_S_REDUCE,			// ���Լ���	      14
]]--

--------------------------------------------------------------------------
--include:

local Horse_Data = msgh_s2c_def[17][1]
local Horse_Att = msgh_s2c_def[17][5]
local Horse_Luck = msgh_s2c_def[17][6]
local GetPlayer = GetPlayer
local SendLuaMsg = SendLuaMsg
local CI_GetPlayerData = CI_GetPlayerData
local pairs = pairs
local CI_OperateMounts = CI_OperateMounts
local GetRidingMountId = GetRidingMountId
local math_floor = math.floor
local GetRWData = GetRWData
local PI_UpdateScriptAtt = PI_UpdateScriptAtt
local table_copy = table.copy
local CI_SetSkillLevel = CI_SetSkillLevel
local BroadcastRPC = BroadcastRPC
local look = look
local Horsebuchang = MailConfig.Horsebuchang
local IsPlayerOnline = IsPlayerOnline
--------------------------------------------------------------------------
-- data:
--[[  CAT_MAX_HP,	1	// Ѫ������1
CAT_MAX_MP,	2	// ŭ������(Ԥ��)
CAT_ATC,	3	// ����2
CAT_DEF,	4	// ����3
CAT_HIT,	5	// ����4
CAT_DUCK,	6	// ����5
CAT_CRIT,	7	// ����6
CAT_RESIST,	8	// �ֿ�7
CAT_BLOCK,	9	// ��8]]--

MouseIsLuck = 1 --�Ƿ񿪷ų齫��1 ���� 0 �ر�

MouseChgeConf = {
	speed = 60, --�����ʼ�ٶ�
	att = {10,nil,2,1.6,1.5,nil,nil,nil,nil}, --���Լ���ϵ��
	mxlv = 120, --�������ȼ�
	good = {636,10}, --{�����������,ÿ����ֵԪ����}
	good1 = 627, --100��������������
	uplv = 100, --�����̬����ģʽ�ĵȼ�Ҫ��
	[1] = { --��ͨ(�Զ�����)
		[1] = {level = 0,ico = 421,skill = 125,name = '����ս��',rid = 1,txt = '���ż���������ؼ׵ı�׼����ս�'}, --[����ID] = {level�����ȼ� ico��ʾͼ�� name���� att���Լӳ� speed�ٶȼӳ� dayʱЧ����λ�죩,addLv��������ȼ����޵�ֵ}
		[2] = {level = 10,ico = 422,skill = 113,name = '��Ѫ����',speed = 2,rid = 2,txt = '������һ������ս���������������Ѱ��������֮����������ǲ��ס�'},
		[3] = {level = 20,ico = 423,skill = 114,name = '��������',speed = 2,rid = 3,txt = '��˵�������ѱ����������ᣬ�������ԣ��ҳ϶Ȳ������ɣ������������ɻ���ǵ����ơ�'},
		[4] = {level = 30,ico = 425,skill = 115,name = '̫�����',speed = 2,rid = 5,txt = '�ഫ����ʥɽ���أ�������������ס����ʵ������˳�����ڵ�����ǰȴ�Ǳ뺷�˵á�'},
		[5] = {level = 40,ico = 424,skill = 116,name = '��Ӱ�鱪',speed = 2,rid = 4,txt = '���������Ĳ�ë֮�ص��鱪������Ұ�ԣ�����ѱ���Ǹ������Ҽ����Ĺ��̡�'},
		[6] = {level = 50,ico = 426,skill = 117,name = '�����컢',speed = 3,rid = 6,txt = '������ʥɽ����֮�۵��컢����������ף���������˵�֮Ч��'},		
		[7] = {level = 60,ico = 428,skill = 118,name = '��������',speed = 3,rid = 8,txt = '����֮�ӣ�Ѫͳ�߹�������桢����ʮ�㣬���������ϵĻ���'},
		[8] = {level = 70,ico = 427,skill = 119,name = '��������',speed = 3,rid = 7,txt = 'Ҫ��Ԧ����һͷƢ�������������Ҫ�൱�����������޵��ҳ�������ִ��һ�������������'},
		[9] = {level = 80,ico = 430,skill = 120,name = '�˻�����',speed = 4,rid = 10,txt = '̫��ʱ����ʥ��֮һ����������ʺ�ǿ�������Ǳ��������������'},		
		[10] = {level = 90,ico = 429,skill = 121,name = '�̾�����',speed = 4,rid = 9,txt = '����ƫ��������˷����ˡ���ȥ���磬�ٶ��뼤���������ϡ�'},
		[11] = {level = 100,ico = 431,skill = 122,name = '��������',speed = 5,rid = 11,txt = '�����еľ������ߣ�����Ԧ֮�������κ���'},
		[12] = {level = 110,ico = 431,skill = 122,name = '��������',speed = 5,rid = 26,txt = '�����еľ������ߣ�����Ԧ֮�������κ���'},
		[13] = {level = 120,ico = 431,skill = 122,name = '��������',speed = 5,rid = 27,txt = '�����еľ������ߣ�����Ԧ֮�������κ���'},
	},
	[2] = { --���� h = 24  limit = 20, �ﵽ20�����û�ã����h����
		[1] = {ico = 434,name = '��������',att = {100,nil,nil,nil,nil,nil,nil,nil},rid = 14,txt = '̫��ʱ�����������Ĺ������֣�����Ϊ��������֮������ʥ֮���˵�ܴ������ˡ�'}, --{cardid �û���ID h ʱЧ����Сʱ}		
		[2] = {ico = 432,name = '½�л���',att = {2000,nil,nil,nil,200,200,nil,nil},rid = 12,txt = '�����ڻ���֮����������θ�ڼ����������ˣ���������ô���˸е����á�'},		
		[3] = {ico = 436,name = 'Ѹ�Ϳ���',att = {3000,nil,300,300},rid = 16,txt = '��������������Ĺ������������ʱ��Щ����ͳ�����������磬���ȴֻ���ڵ��Ĺ��'},
		[4] = {ico = 435,name = '��Ӱ��Ы',att = {5000,nil,1000,1000},rid = 15,txt = '������������������ڰ�Ϊ��ľ綾��Ы����ͬ��Ӱһ����������׽�������١�'},
		[5] = {ico = 438,name = '����Ϭţ',att = {nil,nil,1000,800,nil,nil,500},rid = 18,txt = '���ǲ�ʳ���ȴ���ű����Ƣ����ǧ�����ŭ���������ı뺷�������������ð��֮�١�'},
		[6] = {ico = 632,name = 'ʥ����¹',att = {nil,nil,200,nil,nil,100},rid = 19,txt = 'ʥ���ڵļ����ӵ����������һ�궼���к��ˣ�'},
		[7] = {ico = 572,name = '����½��',att = {nil,nil,1000,1000,nil,nil,nil,nil,500},rid = 17,txt = '����ɽɽ���ƹ���֮�Ų������԰�Ե�ʱ�ڣ���һ��ǿ������ޡ�'},
		[8] = {ico = 726,name = '���������',att = {nil,nil,500,400,nil,nil,300},rid = 23,txt = '���꼪������汼�ڵĿ�������������ҵ�����������������ϡ�'},
		[9] = {ico = 728,name = 'ͨ����è',att = {nil,nil,500,400,nil,nil,300},rid = 24,txt = '����һֻ�������Ե���è��'},
		[10] = {ico = 802,name = 'ѩɽ�̽���',h = 168,att = {nil,nil,nil,nil,nil,nil,nil},rid = 25,txt = '����һֻ����һ�Դ�ǵ�ѩɽ�̽��������º͡�'},
		[11] = {ico = 727,name = 'ȭ���з',att = {2000,nil,300,300,nil,nil,nil},rid = 22,txt = '���������ó�ȭ���������з��'},
		[12] = {ico = 861,name = '��ħʨЫ',att = {2000,nil,500,500,nil,nil,nil},rid = 28,txt = 'ʨ��Ыצ���ж�������ı��ֹ��ޣ�����ɢ���Ŷ�ħ����Ϣ��'},
		[13] = {ico = 871,name = '����Ȯ',att = {2000,nil,500,500,nil,nil,nil},rid = 29,txt ='��ͷȮ�����������ϵĶ�ħ���������ŵ��ػ��ߡ�'},
		[14] = {ico = 906,name = '����',att = {nil,nil,500,400,nil,nil,300},rid = 30,txt ='���գ��Ϲ�ʱ�ڵ����ޣ�ֻ�д�˵�е��˲���ӵ������'},
		[15] = {ico = 931,name = '��������',att = {nil,nil,1000,800,nil,nil,500},rid = 31,txt ='�����������������Ի�������ӵ��ʮ���������Ϲ�������'},
		[16] = {ico = 936,name = 'аɷ������',att = {3000,nil,1000,1000},rid = 32,txt = '��û�ڼ���֮�ص�ʥ�ޣ�ӵ������һ����ٶȡ�'},
		[17] = {ico = 947,name = '��������',att = {nil,nil,1000,800,nil,nil,500},rid = 33,txt = '�����������ع��ȵļ�����ܸ����Ǵ������ֺ�ף����'},
		[18] = {ico = 952,name = '����ҹ��',att = {200000,nil,200000,200000,200000,200000,200000},rid = 35,txt = '�Ϲ�а������ҹ�ʣ������Ϲ�Թ����ǵļ����壬������а��������ԴȪ��'},
	},
}

local mount_buchang = {
	[46]=3,	
	[47]=6,	
	[48]=9,	
	[49]=17,	
	[50]=26,
	[51]=37,	
	[52]=52,
	[53]=70,
	[54]=92,
	[55]=121,	
	[56]=157,	
	[57]=197,	
	[58]=244,	
	[59]=300,	
	[60]=359,	
	[61]=432,	
	[62]=519,	
	[63]=613,	
	[64]=717,	
	[65]=833,	
	[66]=967,	
	[67]=1116,	
	[68]=1278,	
	[69]=1454,	
	[70]=1644,	
	[71]=1868,	
	[72]=2106,	
	[73]=2364,	
	[74]=2642,	
	[75]=2940,	
	[76]=3279,	
	[77]=3640,	
	[78]=4027,	
	[79]=4434,	
	[80]=4869,	
	[81]=5359,	
	[82]=5882,	
	[83]=6434,	
	[84]=7014,	
	[85]=7627,	
	[86]=8313,	
	[87]=9034,	
	[88]=9797,	
	[89]=10595,	
	[90]=11436,	
	[91]=12367,	
	[92]=13342,	
	[93]=14362,	
	[94]=15425,	
	[95]=16538,	
	[96]=17763,	
	[97]=19042,	
	[98]=20373,	
	[99]=21764,	
	[100]=23214,
}

--����װ������
MouseEquipConf = {
	maxnum = 8, --װ���ĸ���
	lv = {10,10,20,20,30, 800}, --��Ʒ��ǿ������
	openLevel = {51,20}, --���ŵȼ� ��51�� ����2��
	mxlv = 6, --���Ʒ��
	kwGoodid = 796, --����ʯID
	kwmxlv = 800, --�������ȼ�
	uplv = {--��Ʒ
		[1] = {lv = 30,up = {{795,10},30},}, --lv ��Ʒ�����Ƶȼ� up {��Ʒ��Ҫ�Ĳ���,����,���ϼ�ֵԪ������}
		[2] = {lv = 40,up = {{795,20},30},},
		[3] = {lv = 50,up = {{795,30},30},},
		[4] = {lv = 60,up = {{795,40},30},},
		[5] = {lv = 70,up = {{795,50},30},},
	},
	hardlv = {
		--[[
		��ɫƷ�� �C �����ڵ����Ʒ
		��ɫƷ�� �C �����ڵ�����Ʒ
		��ɫƷ�� �C �����ڵ�����Ʒ
		��ɫƷ�� �C �����ڵ�����Ʒ
		��ɫƷ�� �C �����ڵ���Ʒ
		��ɫƷ�� �C �����ڵ�������
		]]--
		goodid1 = {788,788}, --ǿ������1
		cost1 = {5,5}, --���ϼ�ֵԪ��
		goodid2 = {789,789,789,789,789,789}, --ǿ������2
		num1 = {10,20,35,50,65,80}, --����1��Ҫ����
		num2 = {1,2,3,4,5,6}, --����2��Ҫ����
		money = {50000,100000,150000,200000,250000,300000}, --����ͭǮ��
	},
	extra = { --ȫƷ�����Լӳ�
		[2]={300,nil,100,80,50,30,50,30,20},
		[3]={900,nil,300,240,150,90,150,90,60},
		[4]={1800,nil,600,480,300,180,300,180,120},
		[5]={3000,nil,1000,800,500,300,500,300,200},
		[6]={4500,nil,1500,1200,750,450,750,450,300},
	},
	Kwextra = { --ȫ�������Լӳ�
		[1]={300,nil,100,80,50,30,50,30,20},
		[2]={900,nil,300,240,150,90,150,90,60},
		[3]={1800,nil,600,480,300,180,300,180,120},
		[4]={3000,nil,1000,800,500,300,500,300,200},
		[5]={4500,nil,1500,1200,750,450,750,450,300},
		[6]={6000,nil,2000,1500,900,600,900,600,400},
		[7]={7500,nil,2500,1800,1100,750,1100,750,500},
		[8]={9000,nil,3000,2100,1300,900,1300,900,600},
		[9]={10500,nil,3500,2400,1500,1050,1500,1050,700},
		[10]={12000,nil,4000,2700,1700,1200,1700,1200,800},
		[11]={13500,nil,4500,3000,1900,1350,1900,1350,900},
		[12]={15000,nil,5000,3300,2100,1500,2100,1500,1000},
		[13]={16500,nil,5500,3600,2300,1650,2300,1650,1100},
		[14]={18000,nil,6000,3900,2500,1800,2500,1800,1200},
		[15]={19500,nil,6500,4200,2700,1950,2700,1950,1300},
		[16]={21000,nil,7000,4500,2900,2100,2900,2100,1400},
		[17]={22500,nil,7500,4800,3100,2250,3100,2250,1500},
		[18]={24000,nil,8000,5100,3300,2400,3300,2400,1600},
		[19]={25500,nil,8500,5400,3500,2550,3500,2550,1700},
		[20]={27000,nil,9000,5700,3700,2700,3700,2700,1800},
		[21]={28500,nil,9500,6000,3900,2850,3900,2850,1900},
		[22]={30000,nil,10000,6300,4100,3000,4100,3000,2000},
		[23]={31500,nil,10500,6600,4300,3150,4300,3150,2100},
		[24]={33000,nil,11000,6900,4500,3300,4500,3300,2200},
		[25]={34500,nil,11500,7200,4700,3450,4700,3450,2300},
		[26]={36000,nil,12000,7500,4900,3600,4900,3600,2400},
		[27]={37500,nil,12500,7800,5100,3750,5100,3750,2500},
		[28]={39000,nil,13000,8100,5300,3900,5300,3900,2600},
		[29]={40500,nil,13500,8400,5500,4050,5500,4050,2700},
		[30]={42000,nil,14000,8700,5700,4200,5700,4200,2800},
		[31]={43000,nil,14500,9000,5900,4350,5900,4350,2900},
		[32]={44000,nil,15000,9300,6100,4500,6100,4500,3000},
		[33]={45000,nil,15500,9600,6300,4650,6300,4650,3100},
		[34]={46000,nil,16000,9900,6500,4800,6500,4800,3200},
		[35]={47000,nil,16500,10200,6700,4950,6700,4950,4300},
		[36]={48000,nil,17000,10500,6900,5100,6900,5100,4400},
		[37]={49000,nil,17500,10800,7100,5250,7100,5250,4500},
		[38]={50000,nil,18000,11100,7300,5400,7300,5400,4600},
		[39]={51000,nil,18500,11400,7500,5550,7500,5550,4700},
		[40]={52000,nil,19000,11700,7700,5700,7700,5700,4800},
		[41]={53000,nil,19500,12000,7900,5850,7900,5850,4900},
		[42]={54000,nil,20000,12300,8100,6000,8100,6000,5000},
		[43]={55000,nil,20500,12600,8300,6150,8300,6150,6100},
		[44]={56000,nil,21000,12900,8500,6300,8500,6300,6200},
		[45]={57000,nil,21500,13200,8700,6450,8700,6450,6300},
		[46]={58000,nil,22000,13500,8900,6600,8900,6600,6400},
		[47]={59000,nil,22500,13800,9100,6750,9100,6750,6500},
		[48]={60000,nil,23000,14100,9300,6900,9300,6900,6600},
		[49]={61000,nil,23500,14400,9500,7050,9500,7050,6700},
		[50]={62000,nil,24000,14700,9700,7200,9700,7200,6800},
		[51]={65000,nil,25000,16000,10000,7500,10000,7500,7000},
		[52]={68000,nil,26000,17000,10500,8000,10500,8000,7200},
		[53]={71000,nil,27000,18000,11000,8500,11000,8500,7400},
		[54]={74000,nil,28000,19000,11500,9000,11500,9000,7600},
		[55]={77000,nil,29000,20000,12000,9500,12000,9500,7800},
		[56]={80000,nil,30000,21000,12500,10000,12500,10000,8000},
		[57]={83000,nil,31000,22000,13000,10500,13000,10500,8200},
		[58]={86000,nil,32000,23000,13500,11000,13500,11000,8400},
		[59]={89000,nil,33000,24000,14000,11500,14000,11500,8600},
		[60]={92000,nil,34000,25000,14500,12000,14500,12000,8800},
		[61]={95000,nil,35000,26000,15000,12500,15000,12500,9000},
		[62]={98000,nil,36000,27000,15500,13000,15500,13000,9200},
		[63]={101000,nil,37000,28000,16000,13500,16000,13500,9400},
		[64]={104000,nil,38000,29000,16500,14000,16500,14000,9600},
		[65]={107000,nil,39000,30000,17000,14500,17000,14500,9800},
		[66]={110000,nil,40000,31000,17500,15000,17500,15000,10000},
		[67]={113000,nil,41000,32000,18000,15500,18000,15500,10200},
		[68]={116000,nil,42000,33000,18500,16000,18500,16000,10400},
		[69]={119000,nil,43000,34000,19000,16500,19000,16500,10600},
		[70]={122000,nil,44000,35000,19500,17000,19500,17000,10800},
		[71]={125000,nil,55000,36000,20000,17500,20000,17500,11000},
		[72]={128000,nil,56000,37000,20500,18000,20500,18000,11200},
		[73]={131000,nil,57000,38000,21000,18500,21000,18500,11400},
		[74]={134000,nil,58000,39000,21500,19000,21500,19000,11600},
		[75]={137000,nil,59000,40000,22000,19500,22000,19500,11800},
		[76]={140000,nil,60000,41000,22500,20000,22500,20000,12000},
		[77]={143000,nil,61000,42000,23000,20500,23000,20500,12200},
		[78]={146000,nil,62000,43000,23500,21000,23500,21000,12400},
		[79]={149000,nil,63000,44000,24000,21500,24000,21500,12600},
		[80]={152000,nil,64000,45000,24500,22000,24500,22000,12800},
	

	},
	att = {
		[1]={100,nil,30,24,20,16,20,20,20},
		[2]={150,nil,45,36,30,24,30,30,30},
		[3]={200,nil,60,48,50,40,50,50,50},
		[4]={300,nil,80,64,60,48,60,60,60},
		[5]={400,nil,100,80,75,60,75,75,75},
		[6]={500,nil,120,96,90,72,90,90,90},

	},
	[1] = {
		name = {'��������','��䰰��','��������','���񰰾�','���𰰾�','�񻰰���'},
		ico = {730,731,732,733,734,735},
		att = {1,8},
		t = 2, --t װ������ 1 ������ 2 ������
		--[[
		������װ������Ҫ���ϡ�����צ����
		������װ������Ҫ���ϡ�����Ƥë��
		]]--
	},
	[2] = {
		name = {'��������','�������','��������','��������','��������','������'},
		ico = {736,737,738,739,740,741},
		att = {7,9},
		t = 1, --t װ������ 1 ������ 2 ������
	},
	[3] = {
		name = {'��������','�������','��������','��������','��������','������'},
		ico = {742,743,744,745,746,747},
		att = {3,5},
		t = 1, --t װ������ 1 ������ 2 ������
	},
	[4] = {
		name = {'��������','�������','��������','��������','��������','������'},
		ico = {748,749,750,751,752,753},
		att = {4,6},
		t = 2, --t װ������ 1 ������ 2 ������
	},
	[5] = {
		name = {'��������','��令��','��������','���񻤼�','���𻤼�','�񻰻���'},
		ico = {754,755,756,757,758,759},
		att = {4,9},
		t = 2, --t װ������ 1 ������ 2 ������
	},
	[6] = {
		name = {'�����޿�','����޿�','�����޿�','�����޿�','�����޿�','���޿�'},
		ico = {760,761,762,763,764,765},
		att = {1,6},
		t = 2, --t װ������ 1 ������ 2 ������
	},
	[7] = {
		name = {'��������','������','��������','�������','�������','�񻰹���'},
		ico = {766,767,768,769,770,771},
		att = {3,8},
		t = 1, --t װ������ 1 ������ 2 ������
	},
	[8] = {
		name = {'�������','������','�������','�������','�������','�����'},
		ico = {772,773,774,775,776,777},
		att = {7,5},
		t = 1, --t װ������ 1 ������ 2 ������
	},
}

--�������ݽṹ					  
local MountsTb = { 
	id = 1001, --����û�ID(����*1000+index)
	lv = 1, --������ǰ�ȼ�
	new = 1,
	--bone = {0,0}, --�������ǵȼ�(��ǰ�ȼ�����ǰ����)
	--pt = {�齱�������������} -- ��ʼ��û��{�齱����,��ȡ�����ʶ11111111} �����Ҫ���
	--luck ={0,0} --��ʼ��û�� {�ӳɳɹ���,����ֵ} �����Ҫ���
	--extra = {[id]=[time,limit]}(Ҫ�ж��Ƿ����) �� {[id] = 1}(��������)
	--����û� ��ʼ��û�� id����û�������time����ʱ��, limit �����Ϊ�գ�����ʱ����ȼ�δ��20������ڣ��������ò�����
	__x = 250--��ʼ������ʱ�����������ж�ֵ
}

--��ȡ��������					  
local function _GetMountsData(sid)
	local mountsdata=GI_GetPlayerData( sid , 'mount' , 250 )
	if mountsdata == nil or mountsdata.id == nil then return end
	return mountsdata
end

--��������ȼ�
function get_mounts_lv(sid)
	local data = _GetMountsData(sid)
	if(data)then
		return data.lv
	end
end

--����ӳ����Բ����¸�������
local function _AddMountsAtt(sid)
	local data = _GetMountsData(sid)
	if(nil == data)then
		return  --û����������
	end
	local AttTb = GetRWData(1)
	local Temp = MouseChgeConf.att --���Լ���ϵ��
	local lv = data.lv
	--ROUND(C5^1.2*0.45,2)
	for i = 1,12 do
		if(Temp[i] ~= nil)then
			AttTb[i] = math_floor((10+(lv^1.7)*1.8) * Temp[i])
		end
	end
	
	--�Ƿ�������û�
	if(data.extra~=nil)then
		local tb
		local tbatt
		for cidx,v in pairs (data.extra) do
			tb = MouseChgeConf[2][cidx]
			if(tb~=nil and tb.att~= nil)then --����Ͳ��ж�ʱЧ���ˣ��˲��� 
				for i = 1,12 do
					if(tb.att[i]~=nil)then
						if(AttTb[i] == nil)then AttTb[i] = 0 end
						AttTb[i] = AttTb[i] + tb.att[i]
					end
				end
			end
		end
	end
	
	local addRate = 0 --���ǵİٷֱȼӳ�
	if(data.bone~=nil and data.bone[1]>0)then
		addRate = data.bone[1]/100
	end
	--���Ǽӳ�
	for i = 1,12 do
		if(AttTb[i]~=nil)then
			AttTb[i] = math_floor(AttTb[i]*(1+addRate))
		end
	end
	
	--��������װ���ӳ�
	if(data.equ~=nil)then
		local mq
		local mlv
		local mklv
		local equlv
		local q = 6
		local kw = MouseEquipConf.kwmxlv
		local attconf
		for i = 1,8 do
			equlv = data.equ[i]
			if(equlv~=nil)then
				mq = math_floor(equlv/1000000) --Ʒ��
				mlv = math_floor(equlv%1000) --ǿ���ȼ�
				mklv = math_floor(math_floor(equlv/1000)%1000) --���Ƶȼ�

				attconf = MouseEquipConf[i].att
				if(attconf)then
					for _,v in pairs(attconf) do
						if(v~=nil)then
							--ǿ����
							if(AttTb[v] == nil)then AttTb[v] = 0 end
							for j = 1,mq do
								if(j<mq)then
									AttTb[v] = AttTb[v] + MouseEquipConf.att[j][v]*MouseEquipConf.lv[j]
								else
									AttTb[v] = AttTb[v] + MouseEquipConf.att[j][v]*mlv
								end
							end
							--���Ƶ�
							if(v == 1)then
								AttTb[v] = AttTb[v] + 100*mklv + math_floor(mklv*(mklv+1)/2/10*20)
							elseif(v == 3 or v == 4)then
								AttTb[v] = AttTb[v] + 40*mklv + math_floor(mklv*(mklv+1)/2/10*6)
							else
								AttTb[v] = AttTb[v] + 20*mklv + math_floor(mklv*(mklv+1)/2/10*4)
							end
						end
					end
				end
				if(mq<q)then q = mq end
				if(mklv<kw)then kw = mklv end
			else
				q = 0
				kw = 0
			end
		end
		
		if(MouseEquipConf.extra[q]~=nil)then
			attconf = MouseEquipConf.extra[q]
			for idx,v in pairs(attconf) do
				if(AttTb[idx] == nil)then AttTb[idx] = 0 end
				AttTb[idx] = AttTb[idx] + v
			end
		end
		
		if(kw>9)then
			local kwidx = math_floor(kw/10)
			if(MouseEquipConf.Kwextra[kwidx]~=nil)then
				attconf = MouseEquipConf.Kwextra[kwidx]
				for idx,v in pairs(attconf) do
					if(AttTb[idx] == nil)then AttTb[idx] = 0 end
					AttTb[idx] = AttTb[idx] + v
				end
			end
		end
	end
	
	PI_UpdateScriptAtt(sid,1)
	
	SendLuaMsg( 0, { ids = Horse_Att}, 9 )
end

--��ǰ̨������������ sid ���ID
local function _SendMouseData(sid,isupdate,name,type,r)
	if(sid == nil and name~=nil)then
		sid = GetPlayer(name) or 0
	end
	if(not IsPlayerOnline(sid))then
		SendLuaMsg( 0, { ids = Horse_Data, t = 0, sid = sid, leave = 1}, 9 )
		return
	end
	local data = _GetMountsData(sid)
	if(r == nil)then
		if(data~=nil)then 
			if(isupdate and CI_GetPlayerData(17) == sid)then _AddMountsAtt(sid) end 
			SendLuaMsg( 0, { ids = Horse_Data, t = 0, data = data, sid = sid, type = type, name = name}, 9 )
		else
			SendLuaMsg( 0, { ids = Horse_Data, t = 0, sid = sid}, 9 )
		end
	else
		return data
	end
end

--��¼ʱ����ӳɻ����ս����ʱ���ã��������ٶ�
local function _LoginMountsAtt(sid)
	local data = _GetMountsData(sid)
	if(nil == data)then
		return  --û����������
	end
	local AttTb = GetRWData(1)
	local Temp = MouseChgeConf.att --���Լ���ϵ��
	local lv = data.lv
	--ROUND(C5^1.2*0.45,2)
	for i = 1,12 do
		if(Temp[i] ~= nil)then
			AttTb[i] = math_floor((10+(lv^1.7)*1.8) * Temp[i])
		end
	end
	
	--�Ƿ�������û�
	if(data.extra~=nil)then
		local tb
		local tbatt
		for cidx,v in pairs (data.extra) do
			tb = MouseChgeConf[2][cidx]
			if(tb~=nil and tb.att~= nil)then --����Ͳ��ж�ʱЧ���ˣ��˲��� 
				for i = 1,12 do
					if(tb.att[i]~=nil)then
						if(AttTb[i] == nil)then AttTb[i] = 0 end
						AttTb[i] = AttTb[i] + tb.att[i]
					end
				end
			end
		end
	end
	
	local addRate = 0 --���ǵİٷֱȼӳ�
	if(data.bone~=nil and data.bone[1]>0)then
		addRate = data.bone[1]/100
	end
	--���Ǽӳ�
	for i = 1,14 do
		if(AttTb[i]~=nil)then
			AttTb[i] = math_floor(AttTb[i]*(1+addRate))
		else
			AttTb[i] = 0
		end
	end
	
	--��������װ���ӳ�
	if(data.equ~=nil)then
		local mq
		local mlv
		local mklv
		local equlv
		local q = 6
		local kw = MouseEquipConf.kwmxlv
		local attconf
		for i = 1,8 do
			equlv = data.equ[i]
			if(equlv~=nil)then
				mq = math_floor(equlv/1000000) --Ʒ��
				mlv = math_floor(equlv%1000) --ǿ���ȼ�
				mklv = math_floor(math_floor(equlv/1000)%1000) --���Ƶȼ�
				
				attconf = MouseEquipConf[i].att
				if(attconf)then
					for _,v in pairs(attconf) do
						if(v~=nil)then
							--ǿ����
							if(AttTb[v] == nil)then AttTb[v] = 0 end
							for j = 1,mq do
								if(j<mq)then
									AttTb[v] = AttTb[v] + MouseEquipConf.att[j][v]*MouseEquipConf.lv[j]
								else
									AttTb[v] = AttTb[v] + MouseEquipConf.att[j][v]*mlv
								end
							end
							--���Ƶ�
							if(v == 1)then
								AttTb[v] = AttTb[v] + 100*mklv + math_floor(mklv*(mklv+1)/2/10*20)
							elseif(v == 3 or v == 4)then
								AttTb[v] = AttTb[v] + 40*mklv + math_floor(mklv*(mklv+1)/2/10*6)
							else
								AttTb[v] = AttTb[v] + 20*mklv + math_floor(mklv*(mklv+1)/2/10*4)
							end
						end
					end
				end
				if(mq<q)then q = mq end
				if(mklv<kw)then kw = mklv end
			else
				q = 0
				kw = 0
			end
		end
		
		if(MouseEquipConf.extra[q]~=nil)then
			attconf = MouseEquipConf.extra[q]
			for idx,v in pairs(attconf) do
				if(AttTb[idx] == nil)then AttTb[idx] = 0 end
				AttTb[idx] = AttTb[idx] + v
			end
		end
		
		if(kw>9)then
			local kwidx = math_floor(kw/10)
			if(MouseEquipConf.Kwextra[kwidx]~=nil)then
				attconf = MouseEquipConf.Kwextra[kwidx]
				for idx,v in pairs(attconf) do
					if(AttTb[idx] == nil)then AttTb[idx] = 0 end
					AttTb[idx] = AttTb[idx] + v
				end
			end
		end
	end
	
	return true
end

--��������
local function _UpDownMount(sid,isride)
	look('_UpDownMount'..isride)
	local data = _GetMountsData(sid)
	if(nil == data)then return end
	
	if(isride>0)then --����
		look('����')
		if(CI_OperateMounts(2))then
		end
	else --����
		local SpeedVal = MouseChgeConf.speed
		for id,v in pairs (MouseChgeConf[1]) do
			if(v~=nil and v.speed~=nil and v.level~=nil and data.lv>=v.level)then --�ѽ����Ļû�
				SpeedVal = SpeedVal + v.speed
			end
		end
		--�Ƿ�������û�
		if(data.extra~=nil)then
			local tb
			for cidx,v in pairs (data.extra) do
				tb = MouseChgeConf[2][cidx]
				if(tb~=nil and tb.speed~=nil)then
					SpeedVal = SpeedVal + tb.speed
				end
			end
		end
		
		local id = data.id
		if(CI_OperateMounts(1,id,SpeedVal))then
			look('����ID'..id)
		end
	end
end

--������
function GiveMounts(sid)
	local tb
	local hid
	local hlv
	local data = _GetMountsData(sid)
	if(data~=nil)then
		hlv = data.lv
		if(hlv~=nil)then
			tb = MouseChgeConf[1]
			local len = #tb
			local curIdx
			for i = 1,len do
				if(tb[i]~=nil and tb[i].level~=nil)then
					if(tb[i].level<=hlv)then
						curIdx = i
					else
						break
					end
				end
			end
			if(curIdx~=nil and tb[curIdx]~=nil and tb[curIdx].skill~=nil)then
				CI_SetSkillLevel(1,tb[curIdx].skill,1,13) --�������＼
			end
			--_UpDownMount(sid,1)
			_UpDownMount(sid,0)
		end
		return -1 --�Ѿ���������
	end
	dbMgr[sid].data.mount = table_copy(MountsTb)
	tb = MouseChgeConf[1]
	hid = MountsTb.id%100
	if(tb and tb[hid] and tb[hid].skill)then
		CI_SetSkillLevel(1,tb[hid].skill,1,13) --�������＼
	end
	--_UpDownMount(sid,1)
	_UpDownMount(sid,0)
	_SendMouseData(sid,true)
	return 0
end

--��¼����Ƿ�Ҫ����
function LoginCheckRide(sid)
	local data = _GetMountsData(sid)
	if(data~=nil)then
		if(data.ride~=nil)then
			_UpDownMount(sid,0)
			data.ride = nil
		end
	end
end

--��������ս����
function GetMountsFPoint(sid)
	local mountsdata = _GetMountsData(sid)
	if(mountsdata == nil)then return 0,0 end --���ﲻ����
	if(_LoginMountsAtt(sid))then
		local attTb = GetRWData(1,true)
		if(attTb == nil)then return 0,0 end
		local mountID = mountsdata.id
		local fightPoint = math_floor(attTb[3]+attTb[4]+attTb[10]+attTb[11]+attTb[12]+attTb[1]*0.2+(attTb[5]+attTb[6]+attTb[7]+attTb[8]+attTb[9])*1.3 + attTb[2]*2 + attTb[14]*1.5)
		return mountID,fightPoint
	end
	return 0,0 
end

--����
function setMountsLogout(sid)
	local data = _GetMountsData(sid)
	if(nil == data)then return end
	local rid = GetRidingMountId()
	if(rid>0)then
		data.ride = 1
	else
		data.ride = nil
	end
end

--���
function clearMount(sid)
	local data = _GetMountsData(sid)
	if(data~=nil)then
		data.pt = nil
		SendLuaMsg( 0, { ids = Horse_Data, t = 0, data = data, sid = sid}, 9 )
	end
end

--��������齱��ʶ
function sendMountLuck()
	SendLuaMsg( 0, { ids = Horse_Luck, isluck = MouseIsLuck, dt = MouseActiveData()}, 9 )
end

--���¹㲥 sign 1 ���� 0 ����
function sendMountLuckRPC(sign)
	MouseIsLuck = sign
	BroadcastRPC('Mouse_UpdateLuck',MouseIsLuck,MouseActiveData())
end

--y,mt,d,h,m,s ����齱��ĵ���ʱ��
--GetTimeToSecond(2013,11,10,0,0,0)
function MouseActiveData()
	local openTime = GetServerOpenTime()
	--look('����ʱ����'..openTime)
	if(openTime>0)then openTime = openTime + 7*24*60*60 end
	return openTime
end

--�������
function set_mouse_new_id(lv)
	local sid = CI_GetPlayerData(17)
	if(sid == nil or sid == 0)then return end
	local mountsData = _GetMountsData(sid)
	if(mountsData~=nil)then
		local hid = mountsData.id
		local ctype = math_floor(hid/1000)
		local id = math_floor(hid%100)
		mountsData.id = ctype*1000 + lv*100 + id
		local mountid = GetRidingMountId()
		if(mountid>0)then --��������Ͼͻ���������
			--UpDownMount(sid,1)
			UpDownMount(sid,0)
		else
			CI_OperateMounts(1,-mountsData.id,0)
		end
	end
end

--�޸ľ��鲹��---20131122
function horse_login_makeup(playerid)
	if playerid==nil or playerid<1 then return end
	local data=_GetMountsData(playerid)
	if data==nil then 
		return
	end
	if data.new ~= nil then return end
	if data.lv == nil or data.lv<=45 then 
		data.new = 1
		return 
	end
	
	local lv=data.lv
	local goods={[3] = {{636,mount_buchang[lv],1},}}
	local arg={rint(lv/10),lv%10,mount_buchang[lv]}
	SendSystemMail(playerid,Horsebuchang,1,2,arg,goods)
	data.new = 1
end

GetMountsData = _GetMountsData
SendMouseData = _SendMouseData
LoginMountsAtt = _LoginMountsAtt
AddMountsAtt = _AddMountsAtt
UpDownMount = _UpDownMount