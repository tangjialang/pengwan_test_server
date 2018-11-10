--[[
file:	Region_Create.lua
desc:	region create conf.
author:	chal
update:	2011-12-05
refix: done by chal
]]--

----------------------------------------------------------------
--include:
local type,pairs = type,pairs
local CI_CreateRegion = CI_CreateRegion
----------------------------------------------------------------
--inner:

--[[	 
	 MapID-��ͼ���(���ֵһ��) ,
	 property - ��������(1 ��ͨ 2 ���������꣨���س����㣩4 ������ص�  8 Ҫ���������Ʒ)  �������������ֵ���
	,limit - �������� (1 �������� 2 ���Ʒ��� 4 �ȼ�pk���� 8 ���ƹһ� 16 ���ƻ�װ��,32 �����Զ�ʹ�õ���  64 �����ٻ����,128 ���Ʊ��� 256 ŭ������)
	,rid - ������ͼ,rx - ��������,ry- ��������,level - �ȼ����� ,multi - �����౶����(1=�������飬1.5=1.5�����飬2=2������) ,
	PKType - PK���� (0 ���� 1 ��ֹ 2 ����),
	PKMode - PKģʽ,(0x00 ���п�PK  0x01 �ر�ͬ��Ӫ 0x02 �ر�����Ӫ 0x04 �ر����� 0x08�ر�ְͬҵ 0x10 �ر���ְҵ 0x20 �ر�ͬ��� 0x40 �ر����� 0xFF �ر�����)
	PKLvDiff - ����PK�����ȼ���
	dbuf = 1  ��ͼ���ü�����ֶα�ʾ������ӱ���buffer
	PKLost = 1   --���������������Ƭ��Ԫ��
	PKValue=1,   --ɱ�˻��PKֵ
	
	
]]--
local _RegionTable = {
[1] = { dbuf = 1,MapID = 1,MapName = "��᪳�",property = 1,limit = 0 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0,Monster = {1}}, --����
--[2] = { MapID = 2,MapName = "���ִ�",property = 5,limit = 0 ,rid = 2,rx = 80,ry = 120,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, --���ִ�
[3] = { MapID = 3,MapName = "����ɽ",property = 5,limit = 0 ,rid = 3,rx = 100,ry = 159,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0,Monster = {3}}, --���ִ�
--[4] = { MapID = 4,MapName = "���ִ�",property = 5,limit = 0 ,rid = 4,rx = 80,ry = 120,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, --���ִ�
--[5] = { MapID = 5,MapName = "���ִ�",property = 5,limit = 0 ,rid = 5,rx = 80,ry = 120,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, --���ִ�
[6] = { MapID = 6,PKLost =1,PKValue=1, MapName = "��᪽�Ұ",property = 1,limit = 4 ,rid = 6,rx = 10,ry = 116,level= 10,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, --��᪽�Ұ
[7] = { MapID = 7,PKLost =1,PKValue=1, MapName = "ǬԪɽ",property = 1,limit = 4 ,rid = 7,rx = 87,ry = 24,level= 10,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, --ǬԪɽ
[8] = { MapID = 8,PKLost =1,PKValue=1, MapName = "������",property = 1,limit = 4 ,rid = 8,rx = 54,ry = 12,level= 20,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[10] = { MapID = 10,PKLost =1,PKValue=1, MapName = "μˮ",property = 9,limit = 4 ,rid = 10,rx = 18,ry = 151,level= 35,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[11] = { MapID = 11,PKLost =1,MapName = "�������",property = 1,limit = 2 ,rid = 11,rx = 20,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=32 , PKLvDiff = 0}, 
[12] = { MapID = 12,PKLost =1,PKValue=1, MapName = "��Ұ",property = 9,limit = 4 ,rid = 12,rx = 18,ry = 151,level= 50,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[13] = { MapID = 13,PKLost =1,PKValue=1, MapName = "����",property = 9,limit = 4 ,rid = 12,rx = 18,ry = 151,level= 50,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},

[22] = { MapID = 22,PKLost =1,PKValue=1,MapName = "��������",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 30,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[23] = { MapID = 23,PKLost =1,PKValue=1,MapName = "�ٹ�����",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 30,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[24] = { MapID = 24,PKLost =1,PKValue=1,MapName = "��ⶴ1��",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[25] = { MapID = 25,PKLost =1,PKValue=1,MapName = "��ⶴ2��",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[28] = { MapID = 28,PKLost =1,PKValue=1,MapName = "������1��",property = 1,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 50,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[29] = { MapID = 29,PKLost =1,PKValue=1,MapName = "������2��",property = 1,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 50,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[30] = { MapID = 30,PKLost =1,PKValue=1,MapName = "�����",property = 1,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[31] = { MapID = 31,PKLost =1,PKValue=1,MapName = "��������",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[32] = { MapID = 32,PKLost =1,PKValue=1,MapName = "������ң��",property = 1,limit = 6 ,rid = 1,rx = 60,ry = 90,level= 20,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[33] = { MapID = 33,PKLost =1,PKValue=1,MapName = "��������",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[34] = { MapID = 34,PKLost =1,PKValue=1,MapName = "ǬԪ��ɽ",property = 1,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 30,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[100] = { MapID = 100,MapName = "����ɳ̲",property = 1,limit = 195 ,rid = 1,rx = 60,ry = 90,level= 30,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[101] = { MapID = 101,MapName = "�����ռ�",property = 1,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 30,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  

[200] = {dbuf = 1, MapID = 200,PKValue=1,MapName = "�һ�����1��",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 37,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[201] = {dbuf = 1, MapID = 201,PKValue=1,MapName = "�һ�����2��",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 37,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[202] = {dbuf = 1, MapID = 202,PKValue=1,MapName = "�һ�����3��",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[203] = {dbuf = 1, MapID = 203,PKValue=1,MapName = "�һ�����4��",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[204] = {dbuf = 1, MapID = 204,PKValue=1,MapName = "�һ�����5��",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[205] = {dbuf = 1, MapID = 205,PKValue=1,MapName = "�һ�����6��",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[206] = {dbuf = 1, MapID = 206,PKValue=1,MapName = "�һ�����7��",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[207] = {dbuf = 1, MapID = 207,PKValue=1,MapName = "�һ�����8��",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 

[500] = { MapID = 500,MapName = "��ˮ����",property = 2,limit = 195 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[501] = { MapID = 501,MapName = "�칬����",property = 2,limit = 195 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[502] = { MapID = 502,MapName = "�����",property = 2,limit = 195 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[503] = { MapID = 503,PKLost =1,MapName = "����ս��",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=1 , PKLvDiff = 0}, 
[504] = { MapID = 504,PKLost =1,MapName = "���ս��",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=32 , PKLvDiff = 0}, 
[505] = { MapID = 505,MapName = "���BOSS",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[506] = { MapID = 506,MapName = "����",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[507] = { MapID = 507,MapName = "��������",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0}, 
[508] = { MapID = 508,MapName = "������Ȫ",property = 2,limit = 195 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[509] = { MapID = 509,MapName = "ˮ����",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[510] = { MapID = 510,MapName = "������",property = 2,limit = 2 ,rid = 101,rx = 16,ry = 10,level= 0,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[512] = { MapID = 512,MapName = "��λ��",property = 2,limit = 98 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0}, 
[513] = { MapID = 513,MapName = "����",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[514] = { MapID = 514,MapName = "ɭ��",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[515] = { MapID = 515,MapName = "����",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[516] = { MapID = 516,MapName = "��ʯ����",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[517] = { MapID = 517,MapName = "���鸱��",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0},  
[518] = { MapID = 518,MapName = "ͭǮ����",property = 6,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[519] = { MapID = 519,MapName = "Զ���ż�",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[520] = { MapID = 520,MapName = "���פ��",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[521] = { MapID = 521,MapName = "����ؾ�",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[522] = { MapID = 522,MapName = "������",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[523] = { MapID = 523,PKLost =1,MapName = "��������",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=32 , PKLvDiff = 0},  
[524] = { MapID = 524,MapName = "Ԫ�񸱱�",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[525] = { MapID = 525,MapName = "�����������",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[526] = { MapID = 526,MapName = "������������",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[527] = { MapID = 527,MapName = "��������",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},
[528] = { MapID = 528,MapName = "��������",property = 4,limit = 238 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},
[530] = { MapID = 530,MapName = "����������",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0},
[531] = { MapID = 531,MapName = "��ԯ��",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},
[532] = { MapID = 532,MapName = "����������2",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0},
[533] = { MapID = 533,PKLost =1,MapName = "����������3",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=21 , PKLvDiff = 0},
[534] = { MapID = 534,MapName = "�����",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0}, 

[1001] = { MapID = 1001,MapName = "�����",property = 2,limit = 195 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1002] = { MapID = 1002,MapName = "����Ұ",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1003] = { MapID = 1003,MapName = "�ٹ�����",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1004] = { MapID = 1004,MapName = "��ⶴ1��",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1005] = { MapID = 1005,MapName = "��ⶴ2��",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1006] = { MapID = 1006,MapName = "ǬԪ��ɽ",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 

[1008] = { MapID = 1008,MapName = "������1��",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1009] = { MapID = 1009,MapName = "������2��",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1010] = { MapID = 1010,MapName = "�����ؿ�",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},
[1011] = { MapID = 1011,MapName = "������ң��",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},
[1012] = { MapID = 1012,MapName = "����1��",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[1013] = { MapID = 1013,MapName = "ˮ������",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[1014] = { MapID = 1014,MapName = "��Ԩ��Ѩ",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1015] = { MapID = 1015,MapName = "��Ұ����",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1016] = { MapID = 1016,MapName = "��������",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1017] = { MapID = 1017,MapName = "����",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1018] = { MapID = 1018,MapName = "����",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1019] = { MapID = 1019,MapName = "����",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1020] = { MapID = 1020,MapName = "����",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1021] = { MapID = 1021,MapName = "��ľ��",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0}, 
[1022] = { MapID = 1022,MapName = "������",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1023] = { MapID = 1023,MapName = "�����",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1027] = { MapID = 1027,MapName = "��������",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[1032] = { MapID = 1032,MapName = "����װ������1",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[1033] = { MapID = 1033,MapName = "����װ������2",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[1034] = { MapID = 1034,MapName = "����װ������3",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  

[1036] = { MapID = 1036,PKLost =1,MapName = "�콵����",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[1037] = { MapID = 1037,MapName = "����װ������1",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[1038] = { MapID = 1038,MapName = "����װ������2",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[1039] = { MapID = 1039,MapName = "����װ������3",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[1040] = { MapID = 1040,MapName = "���޸���",property = 2,limit = 66 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0},  
[1041] = { MapID = 1041,PKLost =1,MapName = "���BOSS",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[1042] = { MapID = 1042,MapName = "���Ǹ���",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0},  
[1043] = { MapID = 1043,PKLost =1,MapName = "���Ѱ��",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[1044] = { MapID = 1044,MapName = "����ͬ��",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0}, 
[1045] = { MapID = 1045,MapName = "���1v1",property = 2,limit = 2 ,rid = 1,rx = 70,ry = 70,level= 0,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[2000] = { MapID = 2000,MapName = "ׯ԰����",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0}, 
[2001] = { MapID = 2001,MapName = "ׯ԰",property = 2,limit = 98 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0}, 
[2002] = { MapID = 2002,MapName = "ׯ԰",property = 2,limit = 98 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0}, 
}

-- --�������������ʱ��Ҫ�����ĵ�ͼ
-- local _RegionTable_kuafu = {
-- 	[1] = { dbuf = 1,MapID = 1,MapName = "��᪳�",property = 1,limit = 0 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0,Monster = {1}}, --����
-- }

-- �����ͼ
local span_maps = {1041,1043,502,503,1045}

function IsSpanMap(MapID)
	for k, id in ipairs(span_maps) do
		if MapID == id then
			return true
		end
	end
	return false
end


-- local r_id={200 ,201 ,202 ,203 ,204 ,205 ,518,22, 23 , 24, 25,   31 , 33}
local r_id={200 ,201 ,202 ,203 ,204 ,205 ,518}
if __plat==101 then 
	for k,v in pairs(r_id) do
		if _RegionTable[v] then 
			if  _RegionTable[v].property==1 then 
				_RegionTable[v].property=5
			elseif  _RegionTable[v].property==2 then 
				_RegionTable[v].property=6
			end
		end
	end
end
----------------------------------------------------------------
--interface:

-- ��װC���������ӿ�
-- @regionType [0] ��ͨ���� [-1] ��̬���� [> 0] ����GID
-- @Manual [0] �Զ�������ɾ�� [1] �ֶ�������ɾ��
function PI_CreateRegion(MapID,regionType,Manual,name)
	local mapTb = _RegionTable[MapID]
	if mapTb == nil or type(mapTb) ~= type({}) then
		return
	end
	local gid = CI_CreateRegion( mapTb, regionType, Manual, name)
	if gid then	
		-- ���س��������ļ�
		LoadRegionConfEx(MapID,gid)
	end
	return gid
end


--��������
function GI_CreateMap()
	-- local r_table=_RegionTable
	-- if  IsSpanServer() then
	-- 	r_table=_RegionTable_kuafu
	-- end
	for MapID, MapConf in pairs( _RegionTable ) do
		if MapID < 500 then
			local ck = PI_CreateRegion(MapID, 0, 0)
			-- ����0��ʾ�ó����Ѵ���
			if ck and ck ~= 0 then
				-- ��������				
				if type(MapConf.Monster) == type({}) then
					for _,id in pairs(MapConf.Monster) do
						CreateMonsterByID(id,MapID)
					end
				end
			end
		end
	end
end

RegionTable = _RegionTable