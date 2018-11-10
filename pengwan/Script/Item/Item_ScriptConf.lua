--[[
file:	Item_ScriptConf.lua
desc:	item used by script conf.
author:	chal
update:	2011-12-07
]]--
--:Interface call by server.
--[[
 GiveGoods(����ID���������Ƿ�󶨣�ע��)
  ��������ֵ��
�ɹ�ʧ��  true  false
ʧ�ܴ��룺
// ��Ч�ĵ��߱��    0
// ��Ҫ��ӵĵ���̫����  1
// �����ռ䲻��  2
// ��������ʧ��		 3
// �����б��еĵ����ظ� 4
// ������ϵ�Ǯ̫���� 5
ʵ�ʸ��ĸ���    
װ������
101: ����
102���·�
103������
104��Ь��
105������
106������
107������
108����ָ
109��Ԫ��ͷ��
110��Ԫ������
111��ӡ��
112��Ԫ����
113��Ԫ�����
114:  Ԫ�񻤼�
115:  Ԫ������
116��Ԫ������
130������
150��Ԫ��
]]
local card_=require("Script.card.card_func")
local card_useitem=card_.card_useitem
--------------------------------------------------------------------------
--include:
local TP_FUNC = type( function() end)
local GetWorldLevel=GetWorldLevel
local Hero_Data = msgh_s2c_def[9][1]
local Hero_Fail = msgh_s2c_def[9][2]
local Horse_Data = msgh_s2c_def[17][1]
local Horse_Fail = msgh_s2c_def[17][2]
local MRB_Data = msgh_s2c_def[35][2]	-- ׯ԰�Ӷ��б�����
local Wing_Err = msgh_s2c_def[20][12]
local pairs,type,tostring = pairs,type,tostring
local ipairs = ipairs
local mathfloor,mathrandom = math.floor,math.random
local GiveGoods,CheckGoods,isFullNum,PI_PayPlayer = GiveGoods,CheckGoods,isFullNum,PI_PayPlayer
local look = look
local CI_AddMulExpTicks,CI_GetPlayerData = CI_AddMulExpTicks,CI_GetPlayerData
local SendLuaMsg,TipCenter,GetStringMsg = SendLuaMsg,TipCenter,GetStringMsg
local GiveGoodsBatch,CI_GetCurPos,CI_AddBuff = GiveGoodsBatch,CI_GetCurPos,CI_AddBuff
local wbao = require('Script.active.wabao')
local wb_usebu=wbao.wb_usebu
local escort = require('Script.active.escort')
local es_ueslibao=escort.es_ueslibao
local BroadcastRPC=BroadcastRPC
local item_getnumactive=item_getnumactive

local shq_m = require('Script.ShenQi.shenqi_func')
local equip_jiezhi = shq_m.equip_jiezhi

--------------------------------------------------------------------------
-- data:
--���߱����ƺű�Ŷ�Ӧ��
local TitleItemList = {
	[103] = 1, --ϵͳָ��Ա
	[1132] = 4,
	[1133] = 5,
	[1134] = 6,
	[1135] = 7,
	[1136] = 8,
	[1137] = 9,
	[1138] = 10,
	[1139] = 11,
	[1140] = 12,
	[1113] = 118,
	[1116] = 33,
	[1117] = 40,
	[1118] = 46,
	[1119] = 116,
	[1120] = 117,
	[1121] = 105,
	[1122] = 106,
	[1123] = 107,
	[1124] = 108,
	[1125] = 109,
	[1126] = 110,
	[1127] = 111,
	[1128] = 112,
	[1129] = 113,
	[1130] = 114,
	[1131] = 115,
	[1174] = 47,
	[1250] = 48,
	[1251] = 49,
	[1252] = 59,
	[1253] = 55,
	[1254] = 56,
	[1255] = 57,
	[1278] = 35,
	[1279] = 36,
	[1280] = 37,
	[1281] = 38,
	[1282] = 58,
	[1475] = 50,
	[1476] = 51,
	[1477] = 52,
	[1478] = 53,
	[1479] = 54,
	[1485] = 14,
	[1486] = 16,
	[1497] = 60,
	[1498] = 61,
	[1499] = 62,
	[1500] = 63,
	[1516] = 64,
	[1517] = 65,
	[1518] = 66,
	[1567] = 32,
}
--���ᱦ����
local FactionLuckItem = {668,664,638,620,601,603,624}
--槼�������
local SeedItem = {1021,1022,1024,1025,1036,1037,1039,1040} -- ����

--ս������
local WarLuckItem = {{710,2,1},{51,2,1},{710,1,1},{624,3,1},{635,2,1},{621,1,1} ,{629,1,1} ,{51,1,1} ,{636,5,1},{634,5,1}}
--װ������	
local ItemScript_equipType = {101,102,103,104,105,106,107,108}
--ʱЧ���������Ʒ
local TimeItemConf = {
	[3016]={[1]=88, [2] = {{710,20,1},{673,2,1},{676,2,1},{3017,1,1}}},
	[3017]={[1]=488, [2] = {{710,30,1},{673,2,1},{618,5,1},{3018,1,1}}},
	[3018]={[1]=888, [2] = {{710,40,1},{673,2,1},{627,300,1},{3019,1,1}}},
	[3019]={[1]=1688, [2] = {{710,80,1},{711,1,1},{673,3,1},{3020,1,1}}},
	[3020]={[1]=4888, [2] = {{712,1,1},{715,1,1},{673,5,1}}},
	[3021]={[1]=88, [2] = {{710,5,1},{3022,1,1}}},
	[3022]={[1]=488, [2] = {{710,20,1},{713,3,1},{3023,1,1}}},
	[3023]={[1]=888, [2] = {{710,30,1},{714,1,1}}},
	[3024]={[1]=88, [2] = {{636,15,1},{3025,1,1}}},
	[3025]={[1]=288, [2] = {{636,40,1},{627,20,1},{3026,1,1}}},
	[3026]={[1]=588, [2] = {{636,100,1},{627,100,1}}},
	[3027]={[1]=88, [2] = {{634,15,1},{3028,1,1}}},
	[3028]={[1]=488, [2] = {{634,60,1},{732,3,1},{3029,1,1}}},
	[3029]={[1]=888, [2] = {{634,100,1},{733,1,1}}},
	[3030]={[1]=88, [2] = {{625,2,1},{3031,1,1}}},
	[3031]={[1]=488, [2] = {{625,8,1},{626,30,1},{3032,1,1}}},
	[3032]={[1]=888, [2] = {{625,12,1},{626,100,1}}},
	[3056]={[1]=700, [2] = {{710,33,1}}},
	[3057]={[1]=3500, [2] = {{710,166,1}}},
	[3063]={[1]=700, [2] = {{762,100,1}}},
	[3064]={[1]=3500, [2] = {{762,500,1}}},
	[3065]={[1]=88, [2] = {{762,15,1},{3066,1,1}}},
	[3066]={[1]=488, [2] = {{762,60,1},{765,3,1},{3067,1,1}}},
	[3067]={[1]=888, [2] = {{762,100,1},{766,1,1}}},
}
--����ʯ����
local XINYUNSHIBAOXIANG =  {
{614,5,1,3000},{614,6,1,5000},{614,7,1,6500},{614,8,1,7500},{614,9,1,8500},{614,10,1,9000},{615,5,1,9500},{615,6,1,9600},{615,7,1,9700},{616,5,1,9800},{616,6,1,9900},{616,7,1,10000},
}
--��װ��Ƭ����
local CHENGSESUIPIANBAOXIANG = {
{601,5,1,2400,0},{601,10,1,2850,0},{601,20,1,3000,0},{710,1,1,3560,0},{710,2,1,3630,0},{636,2,1,5630,0},{636,3,1,6005,0},{636,5,1,6130,0},{624,1,1,7180,0},{625,1,1,7555,0},{634,2,1,9400,0},{634,3,1,9625,0},{634,5,1,9700,0},{647,1,0,9740,1},{652,1,0,9840,1},{657,1,0,9900,1},{648,1,0,9920,1},{653,1,0,9970,1},{658,1,0,10000,1},
}
--������ٱ���
local BAIBAOXIANG = {
	[1]  = {{0,0,0,5000},{768,1,1,7900},{636,2,1,8900},{710,1,1,9900},{52,1,1,10000},},
	[2]	 = {{0,0,0,3000},{768,1,1,7900},{636,2,1,8900},{710,1,1,9900},{52,1,1,10000},},
	[3]	 = {{0,0,0,1000},{768,1,1,7900},{636,2,1,8900},{710,1,1,9900},{52,1,1,10000},},
	[4]	 = {{0,0,0,100},{768,1,1,7900},{636,2,1,8900},{710,1,1,9900},{52,1,1,10000},},
}
--�´����
local XINCHUNLIBAO = {
	{711,1,1,1000},{730,1,1,2500},{763,1,1,5500},{783,1,1,8500},{677,1,1,9000},{717,1,1,10000},
}

--�����������
local DUANWUZONGZI = {
	{601,5,1,3000},{603,5,1,5500},{626,5,1,6500},{627,5,1,7500},{762,2,1,8000},{803,10,1,8500},{812,10,1,9000},{778,1,1,10000},
}
--���ﶹɳ�±�
local ZHONGQIUYUEBING = {
	{1570,1,1,5000},{1571,1,1,10000},
}
--���챦��
local GuoQingBaoXiang = {
	[1] = {{803,1000,1},{812,1000,1},{601,1000,1}},
    [2] = {678,1,1,50},
}
--��ʥ���ձ���
local Wanshengbaoxiang = {
	[1] = {{803,500,1},{812,500,1},{601,200,1},{603,200,1}},
    [2] = {309,1,1,50},
}
--�������
local Gongxian = {
	{803,100,1,2000},{812,100,1,4000},{636,10,1,6000},{1585,50,1,8000},{603,100,1,10000},
}
--�������
local Xuantian = {
	{1585,400,1,2500},{1585,350,1,6000},{1585,250,1,10000},
}
--���
local Hongbao = {
	{603,200,1,3000},{601,100,1,6000},{803,50,1,7600},{812,50,1,9200},{711,1,1,10000},
}

--��ʯ��
local bsx = 
{
	[1] = {{410,1,1},{420,1,1},{430,1,1},{440,1,1},{450,1,1},{460,1,1},{470,1,1},{480,1,1},},
	[2] = {{411,1,1},{421,1,1},{431,1,1},{441,1,1},{451,1,1},{461,1,1},{471,1,1},{481,1,1},},
	[3] = {{412,1,1},{422,1,1},{432,1,1},{442,1,1},{452,1,1},{462,1,1},{472,1,1},{482,1,1},},
	[4] = {{413,1,1},{423,1,1},{433,1,1},{443,1,1},{453,1,1},{463,1,1},{473,1,1},{483,1,1},},
	[5] = {{414,1,1},{424,1,1},{434,1,1},{444,1,1},{454,1,1},{464,1,1},{474,1,1},{484,1,1},},
	[6] = {{415,1,1},{425,1,1},{435,1,1},{445,1,1},{455,1,1},{465,1,1},{475,1,1},{485,1,1},},
	[7] = {{416,1,1},{426,1,1},{436,1,1},{446,1,1},{456,1,1},{466,1,1},{476,1,1},{486,1,1},},
	[8] = {{417,1,1},{427,1,1},{437,1,1},{447,1,1},{457,1,1},{467,1,1},{477,1,1},{487,1,1},},
	[9] = {{418,1,1},{428,1,1},{438,1,1},{448,1,1},{458,1,1},{468,1,1},{478,1,1},{488,1,1},},
}

local call_OnUseItem={
	
	--СѪ��
	[25]=function ()
		local sid = CI_GetPlayerData(17)
		return xb_useitem( sid,300000 )
	end,
	--��Ѫ��
	[26]=function ()
		local sid = CI_GetPlayerData(17)
		return xb_useitem( sid,600000 )
	end,
	--1.2�������
	[50]=function ()
		CI_AddMulExpTicks(2,60*30)
	end,
	--1.5�������
	[51]=function ()
		CI_AddMulExpTicks(5,60*30)
	end,
	--2�������
	[52]=function ()
		CI_AddMulExpTicks(10,60*30)
	end,

	--ȫ���书 1 ��ͨ����  4 �ķ�
	[101]=function ()
		local sid = CI_GetPlayerData(17)
		local CI_LearnSkill = CI_LearnSkill
		local GetLevelUpEquip = GetLevelUpEquip
		
		local school = CI_GetPlayerData(2)
		----rfalse("ְҵ"..school)
		--PI_PayPlayer(1,1000000000)
		local level = CI_GetPlayerData(1)
		level = mathfloor(level/10)
		if level < 3 then level = 2 end
		if level > 9 then level = 9 end
		for k,v in pairs( ItemScript_equipType ) do
			GetLevelUpEquip(v,school,level*10,0,3,1,1)
		end
		GiveMounts(CI_GetPlayerData(17))

		if school == 1 then
			local a=CI_SetSkillLevel(1,108,1,12)
			
		elseif school == 2 then
			CI_SetSkillLevel(1,123,1,12)
		elseif school == 3 then
			CI_SetSkillLevel(1,124,1,12)
		end

		--GiveGoods(0,90000000)
		--DGiveP(99999999,'101')
		--GiveGoods(102,1)
		--AddPlayerPoints( sid , 3 , 9000000,nil,'101' )
		--AddPlayerPoints( sid , 2 , 90000000,nil,'101' )

		TipCenter("hey brother, you're NB now !")
	end,
	--GMר������
	[104]=function ()
		local sid = CI_GetPlayerData(17)
		--��������
		GiveMounts(sid)
		--����
		PI_PayPlayer(1, 28000000,0,0,'GMר������')

		local taskData = GetDBTaskData(sid)
		if taskData then
			taskData.completed = {}
			taskData.current = {}
			taskData.current[1376] = {}
			MarkKillInfo( taskData, 1376 )
		end		
		--ŭ������
		local school = CI_GetPlayerData(2)
		if school == 1 then
			CI_SetSkillLevel(1,108,1,12)
		elseif school == 2 then
			CI_SetSkillLevel(1,123,1,12)
		elseif school == 3 then
			CI_SetSkillLevel(1,124,1,12)
		end
	end,	
		
	--��ʹ�üҽ�������
	[200]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data,hid = HeroActiveProc(sid,index)
		if(result == 0)then --ʧ��
			SendLuaMsg( 0, { ids = Hero_Fail, t = 4, data = data}, 9 )
			return 0
		end
		
		SendLuaMsg( 0, { ids = Hero_Data, data = data, t = 4, hid = hid}, 9 )
	end,
	--����û���
	[300]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = MouseChangeProc(sid,index)
		if(result == 0)then --ʧ��
			SendLuaMsg( 0, { ids = Horse_Fail, t = 3, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 3}, 9 )
	end,
	--�����������
	[674]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch({{636,10,1},{634,10,1}},"�����������")
	end,
	
	--�����������
	[675]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 6 then
			TipCenter(GetStringMsg(14,6))
			return 0
		end
		GiveGoodsBatch({{636,80,1},{634,80,1},{710,20,1},{626,100,1},{627,100,1},{646,1,1}},"�����������")
	end,


	--����ͭǮ�� ˫��ʹ�ú󣬿ɻ��2000ͭ��  ��4��Ҫ֧������ʹ�õ���
	[600]=function (index)
		GiveGoods(0,2000,1,"ͭǮ��")
	end,

	--�߼�ͭǮ�� ˫��ʹ�ú󣬿ɻ��10000ͭ��
	[601]=function (index)
		GiveGoods(0,10000,1,"ͭǮ��")
	end,

	--���������� ˫��ʹ�ú󣬿ɻ��2000����
	[602]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 2 , 2000 ,nil,'����������')
	end,

	--�߼������� ˫��ʹ�ú󣬿ɻ��10000����
	[603]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 2 , 10000 ,nil,'�߼�������')
	end,
	
	
	
	--�����ʯ����
	[625]=function (index)
		local blv = 0  --1����ʯ
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		if index == 624 then
			blv = 1  --2����ʯ
		elseif index == 625 then
			blv = 2  --3����ʯ
		elseif index == 663 then
			blv = 3  --4����ʯ
		elseif index == 666 then
			blv = 4  --5����ʯ
		elseif index == 677 then
			blv = 5  --6����ʯ
		elseif index == 678 then
			blv = 6  --7����ʯ
		elseif index == 1582 then
			blv = 7  --8����ʯ
		elseif index == 1592 then
			blv = 8  --9����ʯ
		end
		local r = mathrandom(0,7)
		local id = 410 + r*10 + blv
		GiveGoods(id,1,1,"��ʯ��")
	end,

	--��ս�ƣ�˫��ʹ�ú�8Сʱ�ڱ�������ɽׯ���˹��� ,�õ����ظ�ʹ��ʱ������ۼ�
	[629]=function (index)
		local sid = CI_GetPlayerData(17)
		local selfMaData = GetManorData_Interf(sid)
		if selfMaData == nil then return 0 end
		local now = GetServerTime()
		if selfMaData.rbPT and selfMaData.rbPT > now then
			selfMaData.rbPT = selfMaData.rbPT + 8*60*60
		else
			selfMaData.rbPT = now + 8*60*60
		end
		SendLuaMsg( 0, { ids = MRB_Data,rpCD = selfMaData.rbPT }, 9 )
	end,

	--�������ӣ�Ҫ�ж�����Կ�� 631�Ƿ���ڣ��еĻ���ɾһ��Կ��Ȼ��齱
	[632]=function (index)
		--ǰֱ̨��

	end,
	

	--�����
	[639]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		GiveGoods(638,10,1,"�����")
	end,

	--��Ԫ����ʹ�ú���50����Ԫ����֧������ʹ��
	[640]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 3 , 50,nil,'��Ԫ��' )
	end,
	--С��Ԫ����ʹ�ú���10����Ԫ����֧������ʹ��
	[739]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 3 , 10,nil,'С��Ԫ��' )
	end,
	--ʹ�ú���1����Ԫ����֧������ʹ��
	[817]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 3 , 1,nil,'��Ԫ��' )
	end,
	
	--�����ʯ �̺������������ʯ��ʹ�ú�ɽׯ�ɻ�þ���50�㡣
	[642]=function (index)
		if index == 633 then
			AddManorExp(CI_GetPlayerData(17),10)
			TipCenter(GetStringMsg(13,10))
		elseif index == 643 then
			AddManorExp(CI_GetPlayerData(17),30)
			TipCenter(GetStringMsg(13,30))
		elseif index == 642 then
			AddManorExp(CI_GetPlayerData(17),50)
			TipCenter(GetStringMsg(13,50))
		end
	end,

	--VIP���ƣ�����VIP�齱��
	[644]=function (index)
		--ǰֱ̨��
		return 0
	end,
	--��˵֮ʯ��
	[662]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		GiveGoods(637,50,1,"��˵֮ʯ��")
	end,

	--�ַ��� ˫��ʹ�ú�����1��ɽׯ�Ӷ�Ĵ�����
	[670]=function (index)
		local sid = CI_GetPlayerData(17)
		local ret = CheckTimes(sid,TimesTypeTb.rob_fight,1,0)
		if not ret then
			return 0
		end
	end,

	--����10W����
	[672]=function (index)
		
		PI_PayPlayer(1, 100000,0,0,'���鵤')
	end,
	--����100W����
	[673]=function (index)
		PI_PayPlayer(1, 1000000,0,0,'���鵤')
	end,
	--����1W����
	[679]=function (index)
		PI_PayPlayer(1, 10000,0,0,'���鵤')
	end,
	--��Ԫ��
	[684]=function (index)
		DGiveP(1,'awards_Ԫ������')
	end,
	--��Ԫ��
	[809]=function (index)
		DGiveP(5,'awards_Ԫ������')
	end,
	--��Ԫ��
	[685]=function (index)
		DGiveP(10,'awards_Ԫ������')
	end,
	--��Ԫ��
	[686]=function (index)
		DGiveP(100,'awards_Ԫ������')
	end,
	--��Ԫ��
	[687]=function (index)
		DGiveP(1000,'awards_Ԫ������')
	end,
	--ս������
	 
	[689]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end				
		GiveGoodsBatch({WarLuckItem[mathrandom(1,#WarLuckItem)]},"ս������")
	end,
	
	--��ױ�У�����槼��øж�20�� 
	[691]=function (index)
		local sid = CI_GetPlayerData(17)
		DJitemaddliking(sid,20,1)
		TipCenter(GetStringMsg(450))  --Ҫ����ʾ
	end,
	
	--�������ƣ���������100�� 
	[692]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 7 , 100 ,nil,'��������')
		TipCenter(GetStringMsg(19,100))  --Ҫ����ʾ
	end,
	
	--ս���ƣ�����ս��100�� 
	[693]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 6 , 100 ,nil,'ս����')
		TipCenter(GetStringMsg(10,100))  --Ҫ����ʾ
	end,
	
	--˫��ʹ�ú󣬿ɻ��һ�������ɫ�ػ�֮�ꡣ
	[694]=function (index)
		local sid = CI_GetPlayerData(17)
		return yy_item_getskill( sid,2 )
	end,
	
	--˫��ʹ�ú󣬿ɻ��һ�������ɫ�ػ�֮�ꡣ
	[695]=function (index)
		local sid = CI_GetPlayerData(17)
		return yy_item_getskill( sid,3 )
	end,
	--˫��ʹ�ú󣬿ɻ��һ���ػ�֮��-������
	[696]=function (index)
		local sid = CI_GetPlayerData(17)
		local res=yy_item_getskill( sid,1,100 )
		if res==0 then return 0 end
		TipCenter(GetStringMsg(451))  --Ҫ����ʾ
		return 
	end,
	

	--���ǵ���� ���ǵ�*100
	[697]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end				
		GiveGoods(627,100,1,"���ǵ����")
	end,
	
	--4����ʯ���  ˫��ʹ�ú󣬿ɻ�ù�������������Ѫ4����ʯ��8����
	[698]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end				
		GiveGoodsBatch({{413,8,1},{423,8,1},{433,8,1},},"4����ʯ���")

	end,

	--���￨,��10�����ֵ
	[699]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 9 , -10 , nil,'���￨',true)
		TipCenter(GetStringMsg(454))
	end,

	--VIPʮ�쿨
	[700]=function (index)
		local sid = CI_GetPlayerData(17)		
		VIP_BuyLv(sid,nil,2,1)
	end,
	--VIP�¿�
	[701]=function (index)
		local sid = CI_GetPlayerData(17)		
		VIP_BuyLv(sid,nil,3,1)
	end,
	--VIP���꿨
	[702]=function (index)
		local sid = CI_GetPlayerData(17)		
		VIP_BuyLv(sid,nil,4,1)
	end,
	-- ����
	[703]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
		if school == 1 then
			GiveGoodsBatch({{5233,1,1,1,10},},'�۳䱦��')			
		elseif school == 2 then
			GiveGoodsBatch({{5270,1,1,1,10},},'�۳䱦��')
		elseif school == 3 then
			GiveGoodsBatch({{5307,1,1,1,10},},'�۳䱦��')
		end
	end,
	
	[704]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
		if school == 1 then
			GiveGoodsBatch({{5344,1,1,1,10},},'�۳䱦��')			
		elseif school == 2 then
			GiveGoodsBatch({{5381,1,1,1,10},},'�۳䱦��')
		elseif school == 3 then
			GiveGoodsBatch({{5418,1,1,1,10},},'�۳䱦��')
		end
	end,
	
	[705]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
		if school == 1 then
			GiveGoodsBatch({{5455,1,1,1,10},},'�۳䱦��')			
		elseif school == 2 then
			GiveGoodsBatch({{5492,1,1,1,10},},'�۳䱦��')
		elseif school == 3 then
			GiveGoodsBatch({{5529,1,1,1,10},},'�۳䱦��')
		end
	end,
	
	[706]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
			GiveGoodsBatch({{5629,1,1,1,10},},'�۳䱦��')			
	end,
	
	[707]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
			GiveGoodsBatch({{5597,1,1,1,10},},'�۳䱦��')			
	end,
	
	[708]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
			GiveGoodsBatch({{5661,1,1,1,10},},'�۳䱦��')			
	end,
	
	[709]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
			GiveGoodsBatch({{5565,1,1,1,10},},'�۳䱦��')			
	end,
	--����
	[711]=function (index)
		local sid = CI_GetPlayerData(17)	
		return sowar_usebhun( sid)		
	end,
	--����
	[712]=function (index)
		local sid = CI_GetPlayerData(17)	
		return sowar_usebling( sid)	
	end,
	--����
	[730]=function (index)
		local sid = CI_GetPlayerData(17)	
		return gem_usebhun( sid)		
	end,
	--����
	[731]=function (index)
		local sid = CI_GetPlayerData(17)	
		return gem_usebling( sid)	
	end,
	--���
	[763]=function (index)
		local sid = CI_GetPlayerData(17)	
		return wing_use_yh( sid)		
	end,
	--����
	[764]=function (index)
		local sid = CI_GetPlayerData(17)	
		return wing_use_yl( sid)	
	end,
	
	--�ػ�������  +1000 ����
	[737]=function (index)
		local sid = CI_GetPlayerData(17)
		local res=yy_item_getskill( sid,1,1000 )
		if res==0 then return 0 end
		TipCenter(GetStringMsg(451))  --Ҫ����ʾ
		return 
	end,
	
	--��Ϊ������ñ��������1%
	[738] = function(index)	
		--��ǰ���� 52 ����������53
		local mexp = CI_GetPlayerData(53)  
		--local level = CI_GetPlayerData(1)
		mexp = mathfloor(mexp/100)
		if mexp < 500000 then
			mexp = 500000
		end
		PI_PayPlayer(1, mexp,0,0,'��Ϊ��')
		
	end,
	
	--��ɫ����
	[740]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
		if school == 1 then
			GiveGoodsBatch({{5234,1,1},},'�۳䱦��')			
		elseif school == 2 then
			GiveGoodsBatch({{5271,1,1},},'�۳䱦��')
		elseif school == 3 then
			GiveGoodsBatch({{5308,1,1},},'�۳䱦��')
		end
	end,
	
	[741]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
		if school == 1 then
			GiveGoodsBatch({{5345,1,1},},'�۳䱦��')			
		elseif school == 2 then
			GiveGoodsBatch({{5382,1,1},},'�۳䱦��')
		elseif school == 3 then
			GiveGoodsBatch({{5419,1,1},},'�۳䱦��')
		end
	end,
	
	[742]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
		if school == 1 then
			GiveGoodsBatch({{5456,1,1},},'�۳䱦��')			
		elseif school == 2 then
			GiveGoodsBatch({{5493,1,1},},'�۳䱦��')
		elseif school == 3 then
			GiveGoodsBatch({{5530,1,1},},'�۳䱦��')
		end
	end,
	
	[743]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
			GiveGoodsBatch({{5630,1,1},},'�۳䱦��')			
	end,
	
	[744]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
			GiveGoodsBatch({{5598,1,1},},'�۳䱦��')			
	end,
	
	[745]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
			GiveGoodsBatch({{5662,1,1},},'�۳䱦��')			
	end,
	
	[746]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
			GiveGoodsBatch({{5566,1,1},},'�۳䱦��')			
	end,
	--�Ե�ҩ
	[754]=function (index)
		local sid = CI_GetPlayerData(17)
		return dy_usegoods( sid,index )		
	end,
	
	--������ٱ���
	[774] = function (index)
		local sid = CI_GetPlayerData(17)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		--�������������10����ȡ1��10~20��ȡ2��20~30��ȡ3��30������ȡ4
		local tb
		local  nownum=item_getnumactive( sid ,2)+1
		if nownum<10 then
			tb = BAIBAOXIANG[1]
		elseif nownum<20 then
			tb = BAIBAOXIANG[2]
		elseif nownum<30 then
			tb = BAIBAOXIANG[3]
		else
			tb = BAIBAOXIANG[4]
		end
		
		local num = mathrandom(1,10000)
		for k,v in pairs( tb ) do
			if num < v[4] then
				if v[1] > 0 then				
					GiveGoods(v[1],v[2],v[3],"�ٱ���")
				else
					PI_PayPlayer(1,500000,0,0,'�ٱ���')
					--��¼����
					item_addnumactive( sid ,2)
				end
				break
			end		
		end
	end,
	
	
	--������װ����
	[775] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 7 then
			TipCenter(GetStringMsg(14,7))
			return 0
		end
		local school = CI_GetPlayerData(2)		
		if school == 1 then
			GiveGoodsBatch({{5341,1,1},{5226,1,1},{5448,1,1},{5558,1,1},{5590,1,1},{5622,1,1},{5654,1,1},},'������װ����')			
		elseif school == 2 then
			GiveGoodsBatch({{5378,1,1},{5263,1,1},{5485,1,1},{5558,1,1},{5590,1,1},{5622,1,1},{5654,1,1},},'������װ����')
		elseif school == 3 then
			GiveGoodsBatch({{5415,1,1},{5300,1,1},{5522,1,1},{5558,1,1},{5590,1,1},{5622,1,1},{5654,1,1},},'������װ����')
		end	
	end,
	
	--˫��ʹ�ÿ��Ի��500������ֵ��
	[778] = function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 11 , 500 ,nil,'��������')
		TipCenter(GetStringMsg(29,500))  --Ҫ����ʾ		
	end,
	--˫��ʹ�ÿ��Ի��100�������㡣
	[779] = function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 10 , 100 ,nil,'����ѫ��')
		TipCenter(GetStringMsg(30,100))  --Ҫ����ʾ				
	end,
	--���
	[787] = function (index)
		local sid = CI_GetPlayerData(17)
		return marry_usering( sid )			
	end,
	-- --����ĥ��������
	-- [791] = function (index)
	-- 	local sid = CI_GetPlayerData(17)
	-- 	return marry_timereset( sid)		
	-- end,
	--��԰�ɳ���
	[797] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,2))
			return 0
		end
		
		GiveGoodsBatch({{642,10,1},{1028,12,1}},"��԰�ɳ���")
	end,
	
	
	--�»��������
	[798] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,5))
			return 0
		end
		
		GiveGoodsBatch({{792,1,1},{790,13,1},{791,1,1},{1465,5,1},{2602,1,1}},"�»��������")
	end,
	
	--�ʺ�ʯ���
	[799] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		
		GiveGoodsBatch({{626,100,1}},"�ʺ�ʯ���")
	end,
	--�»����
	[800] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		
		GiveGoodsBatch({{622,1,1},{790,9,1},{1465,3,1}},"�»����")
	end,
	--���100��������
	[808] = function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 13 , 100 ,nil,'�������')
		TipCenter(GetStringMsg(30,100))  --Ҫ����ʾ			
	end,
	--˫��ʹ�ú󣬿ɻ��һ�������ɫ�ػ�֮�ꡣ
	[823]=function (index)
		local sid = CI_GetPlayerData(17)
		return yy_item_getskill( sid,4 )
	end,
    --˫��ʹ�ú󣬿ɻ��һ�������ɫ�ػ�֮�ꡣ
	[826]=function (index)
		local sid = CI_GetPlayerData(17)
		return yy_item_getskill( sid,5 )
	end,	
	--ʰȡͭǮ
	[1000]=function (index)
		local num = 500
		if index == 1001 then
			num = 1000
		elseif index == 1002 then	
			num = 2000
		elseif index == 1003 then	
			num = 3000
		elseif index == 1004 then	
			num = 5000
		end
		GiveGoods(0,num,1,"ʰȡͭǮ")
	end,
	--����ʰȡ50����ɫ������Ƭ
	[1005] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		GiveGoods(652,1,1,"VIP����ʰȡ")
		
	end,
	--����ʰȡ5������ֵ
	[1006] = function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 11 , 5 ,nil,'��������ʰȡ')
		
	end,
	--����ʰȡ100������ֵ
	[1007] = function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 11 , 100 ,nil,'��������ʰȡ')		
	end,
	--������ǳ���Ƭ
	[1008] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		GiveGoods(803,1,1,"����ʰȡ")	
	end,
	
		--��Ԫ��
	[1009]=function (index)
		--DGiveP(1,'ɱ�˱�Ԫ��')
	end,
		--��Ԫ��
	[1010]=function (index)
		--DGiveP(5,'ɱ�˱�Ԫ��')
	end,
		--��Ԫ��
	[1011]=function (index)
		--DGiveP(10,'ɱ�˱�Ԫ��')
	end,
	--��з ������ɽׯ�ٰ캣�ʴ�ͣ���ֱ��ʹ�ã��������2000     ��6�����߿�������ʹ��
	[1046]=function (index)  
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 2 , 2000 ,nil,'��з')
	end,
	--����Ϻ ������ɽׯ�ٰ캣�ʴ�ͣ���ֱ��ʹ�ã��������6000
	[1047]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 2 , 6000 ,nil,'����Ϻ')
	end,
	--ɳ���� ������ɽׯ�ٰ캣�ʴ�ͣ���ֱ��ʹ�ã����ͭǮ3000
	[1048]=function (index)
		GiveGoods(0,3000,1,"ͭǮ��")
	end,
	--ʯ���� ������ɽׯ�ٰ캣�ʴ�ͣ���ֱ��ʹ�ã����ͭǮ9000
	[1049]=function (index)
		GiveGoods(0,9000,1,"ͭǮ��")
	end,
	--���� ������ɽׯ�ٰ캣�ʴ�ͣ���ֱ��ʹ�ã���þ���5000
	[1050]=function (index)
		PI_PayPlayer(1, 5000,0,0,'ʹ�ú���')
	end,
	--���� ������ɽׯ�ٰ캣�ʴ�ͣ���ֱ��ʹ�ã���þ���15000
	[1051]=function (index)
		PI_PayPlayer(1, 15000,0,0,'ʹ�ñ���')
	end,

	--ѫ�°� ������ɻ��100��ѫ��
	[1053]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		GiveGoods(1052,100,1,"ѫ�°�")
	end,

	--BUG����������� BUG����������ң�ר�����������
	[1575]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		GiveGoodsBatch({{710,1,1},{601,50,1},{603,50,1},{803,50,1}},"BUG�����������")
	end,
	
	--BUG����������� BUG����������ң�ר�����������
	[1576]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		GiveGoodsBatch({{710,3,1},{601,100,1},{603,100,1},{803,100,1}},"BUG�����������")
	end,
	
	--ս����������
	[1074]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		GiveGoodsBatch({{1052,500,1},{670,3,1},{669,3,1}},"ս����������")
		
	end,
	--ս����Ӣ����
	[1075]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		GiveGoodsBatch({{1052,300,1},{670,1,1},{669,1,1}},"ս����Ӣ����")
	end,
	--ʤ���߱���
	[1076]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch({{1052,300,1},{668,3,1}},"ʤ���߱���")
	end,
	--�¸��߱���
	[1077]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch({{1052,200,1},{668,1,1}},"�¸��߱���")

	end,

	--�ھ�����
	[1078]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		GiveGoodsBatch({{669,3,1},{638,20,1},{682,15,1},{634,10,1}},"�ھ�����")
	end,
	--�Ǿ�����
	[1079]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		GiveGoodsBatch({{669,1,1},{638,10,1},{682,10,1},{634,8,1}},"�Ǿ�����")
	end,
	--��������
	[1080]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		GiveGoodsBatch({{668,3,1},{638,5,1},{682,5,1},{634,5,1}},"�Ǿ�����")
	end,

	-- --���������
	-- [1084]=function (index)
	-- 	local sid = CI_GetPlayerData(17)
	-- 	return es_ueslibao( sid )
	-- end,
	
	--���ᱦ����
	[1090]=function (index)
		local fid = CI_GetPlayerData(23)
		if fid == nil or fid == 0 then
			TipCenter(GetStringMsg(207))
			return 0						--��᲻����
		end
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,2))
			return 0
		end
		
		local num = 1086
		num = index - num + 1 
		if num > 0 and num < 11 then
			GiveGoods(FactionLuckItem[mathrandom(1,#FactionLuckItem)],1,1,"���ᱦ����")
			--AddPlayerPoints( CI_GetPlayerData(17) , 4 , num*100 ,nil,'���ᱦ����')
			GiveGoods(682,num,1,"���ᱦ����") --�ƺ�
		end
		if mathrandom(0,10000) < num then
			GiveGoods(1125,1,1,"���ᱦ����") --�ƺ�
		end
	end,

	
	--槼�������
	[1110]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		local num = 1
		local stone = 633
		if index == 1107 then
			num = 2
		elseif index == 1108 then 
			num = 3
		elseif index == 1109 then
			stone = 643
			num = 4
		elseif index == 1110 then
			stone = 643
			num = 5
		elseif index == 1111 then
			stone = 643
			num = 6
		elseif index == 1112 then
			stone = 642
			num = 7
		elseif index == 1113 then
			stone = 642
			num = 8
		end
		
		GiveGoodsBatch({{SeedItem[mathrandom(1,#SeedItem)],num,1},{stone,1,1}},"槼�����")
		if mathrandom(0,10000) < (index - 1105) then
			GiveGoods(1122,1,1,"槼�����") --�ƺ�
		end
	end,

	--�����
	[1105]=function (index)
		if escort_not_trans() then
			TipCenter(GetStringMsg(11))
			return 0
		end
		local x,y,r = CI_GetCurPos()
		if r < 200 or r > 210 then
			if r > 99 then
				TipCenter(GetStringMsg(12))
				return 0
			end
		end
		CI_AddBuff(mathrandom(200,215),0,1,false)
	end,

	
	--ʹ�ú��óƺ�
	[1120]=function (index)
		local sid = CI_GetPlayerData(17)
		local tid = TitleItemList[index]
		if tid == nil then 
			return 0
		end
		
		local tm
		if tid == 32 then tm = GetServerTime() + 24*3600*30 end
		if  SetPlayerTitle(sid,tid,tm) == 1 then  --�Ѿ��гƺ�
			TipCenter(GetStringMsg(15))
			return 0
		end
		TipCenter(GetStringMsg(16))
	end,
	
	--ս��BUFF
	[1141]=function (index)
		CI_AddBuff(mathrandom(142,146),0,1,false)
	end,
	--ս������BUFF
	[1142]=function (index)
		CI_AddBuff(229,0,1,false)
	end,
	
	--��ȡ����
	[1100]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		if index == 1099 then	
			GiveGoods(mathrandom(1162,1167),1,1,"��ȡ����") --3��
		elseif index == 1100 then
			GiveGoods(mathrandom(1168,1173),1,1,"��ȡ����") --4��
		end
	end,
	
	
	--�������ʹ��
	[1150]=function (index)
		local sid = CI_GetPlayerData(17)
		local res=card_useitem(sid,index)
		return res
	end,
	
	
	
	-- ���鸱��ʰȡ����
	[1266]=function (index)
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <=0 then 
			return 0
		end
		expfb_getskill(sid,1)
	end,
	
	[1267]=function (index)
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <=0 then 
			return 0
		end
		expfb_getskill(sid,2)
	end,
	
	[1268]=function (index)
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <=0 then 
			return 0
		end
		expfb_getskill(sid,3)
	end,
	
	[1269]=function (index)
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <=0 then 
			return 0
		end
		expfb_getskill(sid,4)
	end,
	
	--���㱦��
	[1270]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		
		if index == 1270 then
			AddPlayerPoints( sid , 2 , 100000,nil,'���㱦��' )
			
		elseif index == 1271 then 
			AddPlayerPoints( sid , 2 , 150000,nil,'���㱦��' )
			GiveGoods(WarLuckItem[mathrandom(1,#WarLuckItem)][1],1,1,"���㱦��")
		elseif index == 1272 then
			AddPlayerPoints( sid , 2 , 200000,nil,'���㱦��' )
			GiveGoods(WarLuckItem[mathrandom(1,#WarLuckItem)][1],1,1,"���㱦��")
		elseif index == 1273 then
			AddPlayerPoints( sid , 2 , 300000,nil,'���㱦��' )
			GiveGoods(WarLuckItem[mathrandom(1,#WarLuckItem)][1],1,1,"���㱦��")
		elseif index == 1274 then
			AddPlayerPoints( sid , 2 , 500000,nil,'���㱦��' )
			GiveGoods(WarLuckItem[mathrandom(1,#WarLuckItem)][1],2,1,"���㱦��")
		end
		
		--GiveGoodsBatch({{SeedItem[mathrandom(1,#SeedItem)],num,1},{stone,1,1}},"槼�����")
		--if mathrandom(0,10000) < (index - 1105) then
		--	GiveGoods(1122,1,1,"槼�����") --�ƺ�
		--end
	end,
	
	--�������
	[1275]=function()
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <=0 then 
			return 0
		end
		local level = CI_GetPlayerData(1,2,sid)
		local addexp = mathfloor(level^2.6)*2
		PI_PayPlayer(1,addexp,0,0,'ʰȡ������1')
		HeroAddExp(addexp)
	end,
	
	--�������2
	[1449]=function()
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <=0 then 
			return 0
		end
		local level = CI_GetPlayerData(1,2,sid)
		local addexp = mathfloor(level*350+15000)
		PI_PayPlayer(1,addexp,0,0,'ʰȡ������2')
		HeroAddExp(addexp)
	end,
	
	-- ����
	[1457]=function()
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <=0 then 
			return 0
		end
		UpdateChunJieData(sid,1,5,2)	
	end,
	
	-- �̻�
	[1458]=function()
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <=0 then 
			return 0
		end
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return
		end
		UpdateChunJieData(sid,1,20,1)
		GiveGoods(1451,40,1,"�̻�")
	end,
	
	--��װǿ�����
	[1276]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local num = mathrandom(1,10000)
		for k,v in pairs( XINYUNSHIBAOXIANG ) do
			if num < v[4] then
				GiveGoods(v[1],v[2],v[3],"��װǿ�����")
				TipCenter(GetStringMsg(42,v[2],v[1]))
				break
			end		
		end
		
	end,
	
	--���˹ι���
	[1277]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local num = mathrandom(1,10000)
		for k,v in pairs( CHENGSESUIPIANBAOXIANG ) do
			if num < v[4] then
				GiveGoods(v[1],v[2],v[3],"���˹ι���")
				TipCenter(GetStringMsg(42,v[2],v[1]))
				if v[5] == 1 then
					--����
					BroadcastRPC('ggl_notice',CI_GetPlayerData(5),v[1])
				end
				break
			end		
		end
	end,
	
	--�ر�ͼ
	[1283]=function (index)
		local sid = CI_GetPlayerData(17)
		return wb_usebu( sid,1 )
	end,
	
	--����������
	[1401]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		local zhanli = CI_GetPlayerData(62)
		if zhanli < 100000 then
			TipCenter(GetStringMsg(26,100000))
			return 0
		end
		GiveGoodsBatch({{417,1,1},{3062,1,1},{3042,1,1},{3048,1,1}},"����������")
	end,
	--�����������
	[1402]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		local zhanli = CI_GetPlayerData(62)
		if zhanli < 70000 then
			TipCenter(GetStringMsg(26,70000))
			return 0
		end
		GiveGoodsBatch({{416,1,1},{3060,1,1},{3040,1,1},{3046,1,1}},"�����������")
	end,
	--�ƽ�������
	[1403]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		local zhanli = CI_GetPlayerData(62)
		if zhanli < 50000 then
			TipCenter(GetStringMsg(26,50000))
			return 0
		end
		GiveGoodsBatch({{415,1,1},{3059,1,1},{3039,1,1},{3045,1,1}},"�ƽ�������")
	end,
	--�������
	[1404]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch({{626,10,1},{413,1,1}},"�������")
	end,
		--�������
	[1405]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch({{626,10,1},{423,1,1}},"�������")
	end,
		--��Ѫ���
	[1406]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch({{626,10,1},{433,1,1}},"��Ѫ���")
	end,
	--ʥ�����
	[1407]=function (index)
		-- look('ʥ�����',1)
		local sid = CI_GetPlayerData(17)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoods(1408,mathrandom(4,10),1,"ʥ�����")
		
		if mathrandom(1,10000) >9990 then
			GiveGoods(711,1,1,"ʥ�����")

			BroadcastRPC('sdlb_notice',CI_GetPlayerData(5),711)
		end
		--ʥ�����ӹ��ܣ�30��80��130��180�γ�4��
		local  nownum=item_getnumactive( sid ,1)+1
		--look(nownum,1)
		if nownum then 
			if nownum==22 or nownum==51 or nownum==97 or nownum==168 then
				GiveGoods(1410,1,1,"ʥ�����")
				BroadcastRPC('sdlb_notice',CI_GetPlayerData(5),1410)
			end
		end
		item_addnumactive( sid ,1)
	end,
	--Ԫ�����
	[1409]=function (index)
		local sid = CI_GetPlayerData(17)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		
		local tb = {1442,1444,1445}
		--������������ 23 �򿪵��� 1443
		local  nownum=item_getnumactive( sid ,3)+1
		if nownum%23==0 then
			GiveGoods(1443,mathrandom(4,10),1,"Ԫ�����")
		else
			GiveGoods(tb[mathrandom(1,#tb)],mathrandom(4,10),1,"Ԫ�����")
		end		
		item_addnumactive( sid ,3)
		--��¼����
	end,
	--������
	[1446] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,2))
			return 0
		end
		
		GiveGoodsBatch({{710,400,1},{711,1,1}},"������")
	end,
	--�������
	[1447] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		
		GiveGoodsBatch({{762,100,1}},"�������")
	end,
	--Ů�����
	[1448] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,2))
			return 0
		end
		
		GiveGoodsBatch({{634,100,1},{771,3,1}},"Ů�����")
	end,
	
	--�´���������
	[1459] = function (index)
	
		--2014-2-11 �ռ��Ժ���ܿ���
		
			
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,5))
			return 0
		end
		
		GiveGoodsBatch({{0,1000000,1},{603,100,1},{691,20,1},{778,10,1}},"�´���������")
		local num = mathrandom(1,10000)
		for k,v in pairs( XINCHUNLIBAO ) do
			if num < v[4] then
				GiveGoods(v[1],v[2],v[3],"�´���������")
				RPC('GetRandomprops',k,1459)
				break
			end		
		end
	end,
	
	--�´�ף�����鵤
	[1460] = function (index)
		--��ǰ���� 52 ����������53
		local mexp = CI_GetPlayerData(53)  
		local level = CI_GetPlayerData(1)
		local wlevel = GetWorldLevel() or 40
		
		if level - wlevel >= 2 then
			--�ȼ�������ȼ���2�����ϣ�10%����
			mexp = mathfloor(mexp/10)
		elseif level - wlevel >= 0 then
			--�ȼ���������ȼ����1����20%����
			mexp = mathfloor(mexp/5)
		elseif level - wlevel >= -2  then
			--�ȼ�������ȼ���ͬ��2���ڣ�33%����
			mexp = mathfloor(mexp/3)
		end
			--������1���������������1KW�İ�1KW����
		if mexp < 10000000 then
			mexp = 10000000
		end		
		PI_PayPlayer(1, mexp,0,0,'�´�ף�����鵤')
	end,
	
	--�´����
	[1461] = function (index)
			
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		
		GiveGoodsBatch({{1052,100,1},{626,20,1},{627,20,1}},"�´����")
	end,
	--�����̻�
	[1465] = function (index)
		local wlevel = GetWorldLevel() or 40
		local sid = CI_GetPlayerData(17)
		local name = CI_GetPlayerData(5)
		AddPlayerPoints( sid , 2 , wlevel*1000,nil,'�����̻�' )
		BroadcastRPC('marry_brcast',name)
	end,
	--�»���
	[1466] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,2))
			return 0
		end
		
		GiveGoodsBatch({{622,1,1},{778,1,1}},"�»���")
	end,
	--Ԫ��
	[1470] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		
		GiveGoodsBatch({{796,2,1},{789,2,1},{778,3,1}},"Ԫ��")
	end,
	--�ٷ�����
	[1471] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,2))
			return 0
		end
		GiveGoods(1464,mathrandom(5,10),1,"�ٷ�����")
		if mathrandom(0,10000) < 125 then 
			GiveGoods(1463,1,1,"�ٷ�����")		
		end
	end,
	--��һ�ǹ�
	[1483] = function (index)
		PI_PayPlayer(1, 100000,0,0,'��һ�ǹ�')
	end,
	--�����������
	[1484]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local num = mathrandom(1,10000)
		for k,v in pairs( DUANWUZONGZI ) do
			if num < v[4] then
				GiveGoods(v[1],v[2],v[3],"�����������")
				TipCenter(GetStringMsg(42,v[2],v[1]))
				break
			end		
		end
		
	end,
	--���ﶹɳ�±�
	[1572]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local num = mathrandom(1,10000)
		for k,v in pairs( ZHONGQIUYUEBING ) do
			if num < v[4] then
				GiveGoods(v[1],v[2],v[3],"���ﶹɳ�±�")
				TipCenter(GetStringMsg(42,v[2],v[1]))
				break
			end		
		end
		
	end,
	--�������
	[1586]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local num = mathrandom(1,10000)
		for k,v in pairs( Gongxian ) do
			if num < v[4] then
				GiveGoods(v[1],v[2],v[3],"�������")
				TipCenter(GetStringMsg(42,v[2],v[1]))
				break
			end		
		end
		
	end,
	--�������
	[1593]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local num = mathrandom(1,10000)
		for k,v in pairs( Xuantian ) do
			if num < v[4] then
				GiveGoods(v[1],v[2],v[3],"�������")
				TipCenter(GetStringMsg(42,v[2],v[1]))
				break
			end		
		end
		
	end,
	--���
	[1600]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local num = mathrandom(1,10000)
		for k,v in pairs( Hongbao ) do
			if num < v[4] then
				GiveGoods(v[1],v[2],v[3],"���")
				TipCenter(GetStringMsg(42,v[2],v[1]))
				break
			end		
		end
		
	end,
	--�����������߱���
	[1597] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		
		GiveGoodsBatch({{731,1,1},{712,1,1},{764,1,1}},"�����������߱���")
	end,
	--��������ս����
	[1598] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		
		GiveGoodsBatch({{730,1,1},{711,1,1},{763,1,1}},"��������ս����")
	end,
	--�ǳ���Ƭ���䣨����
	[827] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		
		GiveGoodsBatch({{803,40,1}},"�ǳ���Ƭ����")
	end,
	--�ǳ���Ƭ���䣨�ϣ�
	[828] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		
		GiveGoodsBatch({{803,60,1}},"�ǳ���Ƭ����")
	end,
	--����Ƥë��
	[829] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,2))
			return 0
		end
		
		GiveGoodsBatch({{788,40,1},{789,5,1}},"����Ƥë��")
	end,
	
	--����8����Ȩ���
	[1487]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,5))
			return 0
		end
		GiveGoodsBatch({{603,100,1},{601,30,1},{762,20,1},{634,20,1},{639,3,1}},"360�������")
	end,
	--����8����Ȩ���
	[1488]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,5))
			return 0
		end
		GiveGoodsBatch({{603,100,1},{3,10,1},{710,10,1},{778,20,1},{1485,1,1}},"360�������")
	end,
	--����8����Ȩ���
	[1489]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,5))
			return 0
		end
		GiveGoodsBatch({{601,100,1},{778,100,1},{634,100,1},{639,10,1},{1486,1,1}},"360�������")
	end,
	--����8����Ȩ���
	[1490]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,5))
			return 0
		end
		GiveGoodsBatch({{601,500,1},{710,20,1},{3,10,1},{634,48,1},{309,1,1}},"360�������")
	end,
	--����8����Ȩ���
	[1491]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,5))
			return 0
		end
		GiveGoodsBatch({{603,50,1},{601,50,1},{778,10,1},{762,30,1},{789,10,1}},"360�������")
	end,
	--����8����Ȩ���
	[1492]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,5))
			return 0
		end
		GiveGoodsBatch({{601,50,1},{636,50,1},{627,250,1},{639,6,1},{640,40,1}},"360�������")
	end,
	--�ڶ�������֮ս�ھ����
	[1495]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch({{813,1000,1},{1516,1,1},{312,1,1}},"�ڶ�������֮ս�ھ����")
	end,	
	--����֮ս�ھ����
	[1496]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch({{813,1000,1},{1253,1,1},{2802,1,1}},"����֮ս�ھ����")
	end,
	--ʱװ
	[2601] = function (index)
		local sid = CI_GetPlayerData(17)
		return app_getone( sid,index )
	end,
	
	--���� ��ʹ�ú����ﵱǰ�޽�ֱ������1����Ҫ�Զ���������������
	[3000]=function (index)
		
		local result,data,isup,cidx = MountUpFromGoods(sid)
		if(result == false)then --ʧ��
			SendLuaMsg( 0, { ids = Horse_Fail, t = 6, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 6,up = isup, add = add, cidx = cidx}, 9 )
	end,

	--���ɵ���ʹ�ú�ֱ������1��
	[3001]=function (index)
		--��ǰ���� 52 ����������53
		local mexp = CI_GetPlayerData(53)  
		local level = CI_GetPlayerData(1)
		if level < 100 then
			if level > 80 then  
				--���80������ҝM���������̫��,
				--���ԸĞ�ÿ�μ�500000000
				local num = rint(mexp / 500000000) 
				local less = rint(mexp % 500000000)
				for i = 1, num do
					PI_PayPlayer(1, 500000000, 0,0,'������')	
				end	
				PI_PayPlayer(1, less, 0,0,'������')
			else 
				PI_PayPlayer(1, mexp,0,0,'������')
			end
		else
			PI_PayPlayer(1, 50000000,0,0,'������')
		end
	end,
	--���ﵤ�Ż�����
	[3002]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 700 , 0 , 1, "���ﵤ�Ż�����") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(636,100,1,"���ﵤ�Ż�����")
	end,
	--���ﵤ�Żݽ�
	[3003]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 3500 , 0 , 1, "���ﵤ�Żݽ�") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(636,500,1,"���ﵤ�Żݽ�")
	end,
	--�����Ż�����
	[3004]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 700 , 0 , 1, "�����Ż�����") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(634,100,1,"�����Ż�����")
	end,
	--�����Żݽ�
	[3005]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 3500 , 0 , 1, "�����Żݽ�") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(634,500,1,"�����Żݽ�")
	end,
	--ϴ��ʯ�Żݿ�
	[3006]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 500 , 0 , 1, "ϴ��ʯ�Żݿ�") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(605,250,1,"ϴ��ʯ�Żݿ�")
	end,
	--��ʯ�Ż�����
	[3007]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 240 , 0 , 1, "��ʯ�Ż�����") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(412,2,1,"��ʯ�Ż�����")
		GiveGoods(422,2,1,"��ʯ�Ż�����")
		GiveGoods(432,2,1,"��ʯ�Ż�����")
	end,
		--��ʯ�Żݽ�
	[3008]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 3840 , 0 , 1, "��ʯ�Żݽ�") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(414,2,1,"��ʯ�Żݽ�")
		GiveGoods(424,2,1,"��ʯ�Żݽ�")
		GiveGoods(434,2,1,"��ʯ�Żݽ�")
	end,
		--ͭǮ�Żݿ�
	[3009]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 288 , 0 , 1, "ͭǮ�Żݿ�") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(601,100,1,"ͭǮ�Żݿ�")
	end,
		--����ʯ�Żݿ�
	[3010]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 960 , 0 , 1, "����ʯ�Żݿ�") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(616,30,1,"����ʯ�Żݿ�")
	end,
	
	--�������2~3��֮��ʱ��˫��ʹ�ú�����������������1�ǡ�<br/>���ﵱǰ��������ﵽ2�ײ���ʹ��
	--���ﳬ��3��ʱ���̶�������þ��顣
	[3074]=function (index) --ֻ��3��ʹ��
		local sid = CI_GetPlayerData(17)
		local result,data,isup,cidx = MountUpFromGoodsExp(sid,index)
		if(result == false)then --ʧ��
			SendLuaMsg( 0, { ids = Horse_Fail, t = 7, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 6,up = isup, add = add, cidx = cidx}, 9 )
	end,
	
	[3011]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data,isup,cidx = MountUpFromGoodsExp(sid,3011)
		if(result == false)then --ʧ��
			SendLuaMsg( 0, { ids = Horse_Fail, t = 7, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 6,up = isup, add = add, cidx = cidx}, 9 )
	end,
	--�������3~4��֮��ʱ��˫��ʹ�ú�����������������1�ǡ�<br/>���ﵱǰ��������ﵽ3�ײ���ʹ��
	--���ﳬ��4��ʱ���̶���� 230 �㾭�顣
	[3012]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data,isup,cidx = MountUpFromGoodsExp(sid,3012)
		if(result == false)then --ʧ��
			SendLuaMsg( 0, { ids = Horse_Fail, t = 7, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 6,up = isup, add = add, cidx = cidx}, 9 )
	end,
	--�������4~5��֮��ʱ��˫��ʹ�ú�����������������1�ǡ�<br/>���ﵱǰ��������ﵽ4�ײ���ʹ��
	--���ﳬ��5��ʱ���̶���� 450 �㾭�顣
	[3013]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data,isup,cidx = MountUpFromGoodsExp(sid,3013)
		if(result == false)then --ʧ��
			SendLuaMsg( 0, { ids = Horse_Fail, t = 7, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 6,up = isup, add = add, cidx = cidx}, 9 )
	end,
	--�������5~6��֮��ʱ��˫��ʹ�ú�����������������1�ǡ�<br/>���ﵱǰ��������ﵽ5�ײ���ʹ��
	--���ﳬ��6��ʱ���̶���� 770 �㾭�顣
	[3014]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data,isup,cidx = MountUpFromGoodsExp(sid,3014)
		if(result == false)then --ʧ��
			SendLuaMsg( 0, { ids = Horse_Fail, t = 7, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 6,up = isup, add = add, cidx = cidx}, 9 )
	end,
	--�������6~7��֮��ʱ��˫��ʹ�ú�����������������1�ǡ�<br/>���ﵱǰ��������ﵽ6�ײ���ʹ��
	--���ﳬ��7��ʱ���̶���� 1230 �㾭�顣
	[3015]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data,isup,cidx = MountUpFromGoodsExp(sid,3015)
		if(result == false)then --ʧ��
			SendLuaMsg( 0, { ids = Horse_Fail, t = 7, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 6,up = isup, add = add, cidx = cidx}, 9 )
	end,
	
	--[[
	3058 	2���߲���ë	
	3059 	3���߲���ë	
	3060 	4���߲���ë	
	3061 	5���߲���ë	
	3062 	6���߲���ë	
	]]--
	
	[3058]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = wing_use_item(sid,3058)
		look('##############################')
		if(result == false)then --ʧ��
			look('data'..data);
			SendLuaMsg( 0, { ids = Wing_Err, t = 6, data = data}, 9 )
			return 0
		end
	end,
	
	[3059]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = wing_use_item(sid,3059)
		if(result == false)then --ʧ��
			SendLuaMsg( 0, { ids = Wing_Err, t = 6, data = data}, 9 )
			return 0
		end
	end,
	
	[3060]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = wing_use_item(sid,3060)
		if(result == false)then --ʧ��
			SendLuaMsg( 0, { ids = Wing_Err, t = 6, data = data}, 9 )
			return 0
		end
	end,
	
	[3061]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = wing_use_item(sid,3061)
		if(result == false)then --ʧ��
			SendLuaMsg( 0, { ids = Wing_Err, t = 6, data = data}, 9 )
			return 0
		end
	end,
	
	[3062]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = wing_use_item(sid,3062)
		if(result == false)then --ʧ��
			SendLuaMsg( 0, { ids = Wing_Err, t = 6, data = data}, 9 )
			return 0
		end
	end,
	
	[3068]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = wing_use_item(sid,3068)
		if(result == false)then --ʧ��
			SendLuaMsg( 0, { ids = Wing_Err, t = 6, data = data}, 9 )
			return 0
		end
	end,
	
	[3069]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = wing_use_item(sid,3069)
		if(result == false)then --ʧ��
			SendLuaMsg( 0, { ids = Wing_Err, t = 6, data = data}, 9 )
			return 0
		end
	end,
	
	[3070]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = wing_use_item(sid,3070)
		if(result == false)then --ʧ��
			SendLuaMsg( 0, { ids = Wing_Err, t = 6, data = data}, 9 )
			return 0
		end
	end,
	
	[3038]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data,isup,cidx = MountUpFromGoodsExp(sid,index)
		if(result == false)then --ʧ��
			SendLuaMsg( 0, { ids = Horse_Fail, t = 7, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 6,up = isup, add = add, cidx = cidx}, 9 )
	end,
	
	--����
	[3020] = function(index)	
		local item = TimeItemConf[index]
		if item == nil then 
			return 0 
		end 
		local num = #item[2]		
		local pakagenum = isFullNum()
		if pakagenum < num then
			TipCenter(GetStringMsg(14,num))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , item[1] , 0 , 1, "ÿ���׳����_"..tostring(index)) then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoodsBatch(item[2],"ÿ���׳����"..tostring(index))
	end,
	--�����߲�����
	[3033] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,2 )
	end,
	--�м��߲�����
	[3034] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,3 )
	end,
	--�߼��߲�����
	[3035] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,4 )
	end,
	--�����߲�����
	[3036] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,5 )
	end,
	
	--2���߲ʿ�
	[3044] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,2,1 )
	end,
	
	--3���߲ʿ�
	[3045] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,3,1 )
	end,
	--4���߲ʿ�
	[3046] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,4,1 )
	end,
	--5���߲ʿ�
	[3047] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,5,1 )
	end,
	--6���߲ʿ�
	[3048] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,6,1 )
	end,


	
	--3��Ů��ף��
	[3049] = function(index)	
		local sid = CI_GetPlayerData(17)
		return gem_uselvup( sid,3 )
	end,
	--4��Ů��ף��
	[3050] = function(index)	
		local sid = CI_GetPlayerData(17)
		return gem_uselvup( sid,4 )
	end,
	--5��Ů��ף��
	[3051] = function(index)	
		local sid = CI_GetPlayerData(17)
		return gem_uselvup( sid,5 )
	end,
	--6��Ů��ף��
	[3052] = function(index)	
		local sid = CI_GetPlayerData(17)
		return gem_uselvup( sid,6 )
	end,
	--7��Ů��ף��
	[3053] = function(index)	
		local sid = CI_GetPlayerData(17)
		return gem_uselvup( sid,7 )
	end,
	--8��Ů��ף��
	[3054] = function(index)	
		local sid = CI_GetPlayerData(17)
		return gem_uselvup( sid,8 )
	end,
	--9��Ů��ף��
	[3055] = function(index)	
		local sid = CI_GetPlayerData(17)
		return gem_uselvup( sid,9 )
	end,
	
	--˫��ʹ�ÿ��Ի��100�����Ի��֡�
	[824] = function (num)
		local sid = CI_GetPlayerData(17)
		zm_add_score(sid,100)
		TipCenter(GetStringMsg(31,100))  --Ҫ����ʾ	
	end,	
	
		--˫��ʹ�ÿ��Ի��100�����Ի��֡�
	[1580] = function (num)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch(GuoQingBaoXiang[1],"����������")
		local goods  = GuoQingBaoXiang[2]
		if math.random(1,100) < goods[4] then
			GiveGoods(goods[1],goods[2],goods[3],"����������")
			local name = CI_GetPlayerData(3)
			BroadcastRPC('gqbx_tip',name,goods[1],goods[2])  --ȫ���㲥
			
			--TipCenter(GetStringMsg(42,goods[2],goods[1]))
		end
	end,
    [1584] = function (num)
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch(Wanshengbaoxiang[1],"��ʥ�ڱ���")
		local goods  = Wanshengbaoxiang[2]
		if math.random(1,100) < goods[4] then
			GiveGoods(goods[1],goods[2],goods[3],"��ʥ�ڱ���")
			local name = CI_GetPlayerData(3)
			BroadcastRPC('gqbx_tip',name,goods[1],goods[2])  --ȫ���㲥
			
			--TipCenter(GetStringMsg(42,goods[2],goods[1]))
		end
	end,	
	[9915] = function (inedex)
		local sid = CI_GetPlayerData(17)
		equip_jiezhi(sid, 9915)
	end,
}














-------------------------[[common Config end,]]-------------------------

-------------------------[[Batch Config Begin]]-------------------------
local call_OnUseItem_batch={
	--СѪ��
	[25]=function (num)
		local sid = CI_GetPlayerData(17)
		return xb_useitem( sid,300000*num )
	end,
	--��Ѫ��
	[26]=function (num)
		local sid = CI_GetPlayerData(17)
		return xb_useitem( sid,600000*num )
	end,
	--��з ������ɽׯ�ٰ캣�ʴ�ͣ���ֱ��ʹ�ã��������2000     ��6�����߿�������ʹ��
	[1046]=function (num)  
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 2 , 2000*num ,nil,'��з')
	end,
	--����Ϻ ������ɽׯ�ٰ캣�ʴ�ͣ���ֱ��ʹ�ã��������6000
	[1047]=function (num)  
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 2 , 6000*num,nil,'����Ϻ' )
	end,
	--ɳ���� ������ɽׯ�ٰ캣�ʴ�ͣ���ֱ��ʹ�ã����ͭǮ3000
	[1048]=function (num)  
		GiveGoods(0,3000*num,1,"ɳ����")
	end,
	--ʯ���� ������ɽׯ�ٰ캣�ʴ�ͣ���ֱ��ʹ�ã����ͭǮ9000
	[1049]=function (num)  
	
		GiveGoods(0,9000*num,1,"ʯ����")
	end,
	--���� ������ɽׯ�ٰ캣�ʴ�ͣ���ֱ��ʹ�ã���þ���5000
	[1050]=function (num)  
		PI_PayPlayer(1, 5000*num,0,0,'����')
	end,
	--���� ������ɽׯ�ٰ캣�ʴ�ͣ���ֱ��ʹ�ã���þ���15000
	[1051]=function (num)  
		PI_PayPlayer(1, 15000*num,0,0,'����')
	end,
	--ѫ�°� ������ɻ��100��ѫ��
	[1053]=function (num)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		GiveGoods(1052,100*num,1,"ѫ�°�")
	end,
	
	--����ͭǮ�� ˫��ʹ�ú󣬿ɻ��2000ͭ��  ��4��Ҫ֧������ʹ�õ���
	[600]=function (num)
		GiveGoods(0,2000*num,1,"ͭǮ��")
	end,

	--�߼�ͭǮ�� ˫��ʹ�ú󣬿ɻ��10000ͭ��
	[601]=function (num)
		GiveGoods(0,10000*num,1,"ͭǮ��")
	end,

	--���������� ˫��ʹ�ú󣬿ɻ��1000����
	[602]=function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 2 , 2000*num,nil,'��������������' )
	end,

	--���������� ˫��ʹ�ú󣬿ɻ��5000����
	[603]=function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 2 , 10000*num ,nil,'��������������')
	end,
	
	--��Ԫ��,ʹ�ú���50����Ԫ����֧������ʹ��
	[640]=function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 3 , 50*num ,nil,'��Ԫ������')
	end,
	--С��Ԫ����ʹ�ú���10����Ԫ����֧������ʹ��
	[739]=function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 3 , 10*num,nil,'С��Ԫ��' )
	end,
	--ʹ�ú���1����Ԫ����֧������ʹ��
	[817]=function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 3 , 1*num,nil,'1��Ԫ��' )
	end,
	--����10W����
	[672]=function (num)
		
		PI_PayPlayer(1, 100000*num,0,0,'���鵤')
	end,
	--����100W����
	[673]=function (num)
		PI_PayPlayer(1, 1000000*num,0,0,'���鵤')
	end,
	--����1W����
	[679]=function (num)
		PI_PayPlayer(1, 10000*num,0,0,'���鵤')
	end,
	
		--��Ԫ��
	[684]=function (num)
		DGiveP(1*num,'awards_Ԫ������')
	end,
	--��Ԫ��
	[809]=function (num)
		DGiveP(5*num,'awards_Ԫ������')
	end,
	--��Ԫ��
	[685]=function (num)
		DGiveP(10*num,'awards_Ԫ������')
	end,
	--��Ԫ��
	[686]=function (num)
		DGiveP(100*num,'awards_Ԫ������')
	end,
	--��Ԫ��
	[687]=function (num)
		DGiveP(1000*num,'awards_Ԫ������')
	end,
	
	--�������ƣ���������100�� 
	[692]=function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 7 , 100*num ,nil,'��������')
		TipCenter(GetStringMsg(19,100*num))  --Ҫ����ʾ
	end,
	
	--ս���ƣ�����ս��100�� 
	[693]=function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 6 , 100*num ,nil,'ս����')
		TipCenter(GetStringMsg(10,100*num))  --Ҫ����ʾ
	end,
	
	[738] = function(num)	
		--��ǰ���� 52 ����������53
		local mexp = CI_GetPlayerData(53)  
		mexp = mathfloor(mexp/100)
		if mexp < 500000 then
			mexp = 500000
		end
		local total = mexp*num
		look(total,2)
		
		local hi = total / 0xFFFFFFF 
		for i=1,hi do
			PI_PayPlayer(1, 0xFFFFFFF,0,0,'��Ϊ��')
		end
		local odd = total % 0xFFFFFFF
		PI_PayPlayer(1, odd,0,0,'��Ϊ��')
	end,
	
	--˫��ʹ�ÿ��Ի��500������ֵ��
	[778] = function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 11 , 500*num ,nil,'��������')
		TipCenter(GetStringMsg(29,500*num))  --Ҫ����ʾ		
	end,
	--˫��ʹ�ÿ��Ի��100�������㡣
	[779] = function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 10 , 100*num ,nil,'����ѫ��')
		TipCenter(GetStringMsg(30,100*num))  --Ҫ����ʾ				
	end,
	
	--1����ʯ��
	[623] = function (num)
			for i = 1,num do
				GiveGoodsBatch({bsx[1][math.random(1,#bsx[1])]},"��ʯ��")
			end
	end,
	
	--2����ʯ��
	[624] = function (num)
		for i = 1,num do
			GiveGoodsBatch({bsx[2][math.random(1,#bsx[2])]},"��ʯ��")
		end
	end,
	
	--3����ʯ��
	[625] = function (num)
		for i = 1,num do
			GiveGoodsBatch({bsx[3][math.random(1,#bsx[3])]},"��ʯ��")
		end
	end,
	
	--4����ʯ��
	[663] = function (num)
		for i = 1,num do
			GiveGoodsBatch({bsx[4][math.random(1,#bsx[4])]},"��ʯ��")
		end
	end,
	
	--5����ʯ��
	[666] = function (num)
		for i = 1,num do
			GiveGoodsBatch({bsx[5][math.random(1,#bsx[5])]},"��ʯ��")
		end
	end,
	
	--6����ʯ��
	[677] = function (num)
		for i = 1,num do
			GiveGoodsBatch({bsx[6][math.random(1,#bsx[6])]},"��ʯ��")
		end
	end,
	
	--7����ʯ��
	[678] = function (num)
		for i = 1,num do
			GiveGoodsBatch({bsx[7][math.random(1,#bsx[7])]},"��ʯ��")
		end
	end,
	
	--8����ʯ��
	[1582] = function (num)
		for i = 1,num do
			GiveGoodsBatch({bsx[8][math.random(1,#bsx[8])]},"��ʯ��")
		end
	end,
	
	--9����ʯ��
	[1592] = function (num)
		for i = 1,num do
			GiveGoodsBatch({bsx[9][math.random(1,#bsx[9])]},"��ʯ��")
		end
	end,

}
-------------------------[[Batch Config end,]]-------------------------

--��ͨ����ʹ�ã����������ã�
function OnUseItem(scriptId, index, handle, useType)
	local func = call_OnUseItem[scriptId]
	if type(func) ~= TP_FUNC then
		return 0
	end

	local retValue = 0
	local ret = func(index, handle, useType)
	if ret == nil then
		retValue = 1
	else
		retValue = ret
	end

	if( ret == -1 )then
		return 0
	end

	return retValue
end

--��ʯ�����⴦��
local batch_conf = {623,624,625,663,666,677,678,1582,}
--����ʹ�õ��ߣ�ֻ�߽ű���scriptIdΪ����id
--Ŀǰ֧��ʹ���������߱�[ǰ̨��Ҫ](1046,1047,1048,1049,1050,1051,600,601,602,603)
--itype=trueΪ����ʹ��,ֱ�ӿ�Ǯ,��������
function OnUseItem_batch(scriptId , num,bding,nbind,itype)
	if type(scriptId)~=type(0) or type(num)~=type(0) or num<0 then return end
	local func =call_OnUseItem_batch[scriptId]
	for k,v in pairs(batch_conf) do		--����������ʯ�����⴦��
		if v == scriptId then
			local packagenum = isFullNum()
			local packageneed = 0
			if num and num > 0 then
				if num > 8 then
					packageneed = 8
				else
					packageneed = num
				end
			end
			if packagenum < packageneed then
				TipCenter(GetStringMsg(14, packageneed))
				return
			end
		end
	end
	if type(func) ~= TP_FUNC then
		look('OnUseItem_batch id error id=='..tostring(scriptId),1)
		return 
	end
	if not itype then 
		if num~=bding+nbind then
			return
		end
		if bding>0 then
			if not (CheckGoods(scriptId, bding,2)==1) then
				return
			end
		end
		if nbind>0 then
			if not (CheckGoods(scriptId, nbind,5)==1) then
				return
			end
		end
	end
	local ret = func(num)
	return true
end
