--[[
file:	Faction_System.lua
desc:	���ϵͳ����
update:2013-7-1
refix:	done by xy
2014-8-21:add by sxj, update fBuild_conf.limit, add fBuild_conf[7], function update _upMainBuild()
]]--

--------------------------------------------------------------------------
--include:
local uv_TimesTypeTb = TimesTypeTb
local Faction_Fail = msgh_s2c_def[7][1]
local Faction_Build = msgh_s2c_def[7][4]
local Faction_Data = msgh_s2c_def[7][8]
local Faction_Buff = msgh_s2c_def[7][12]
local Faction_newJoin = msgh_s2c_def[7][15]
local Faction_SuccessJoin = msgh_s2c_def[7][18]
local Faction_ApplyResult = msgh_s2c_def[7][19]
local Faction_CityOwner = msgh_s2c_def[7][29]
local CI_GetPlayerData = CI_GetPlayerData
local SendLuaMsg = SendLuaMsg
local CheckCost = CheckCost
local CheckGoods = CheckGoods
local CI_CreateFaction = CI_CreateFaction
local CI_GetFactionInfo = CI_GetFactionInfo
local CheckTimes = CheckTimes
local CI_AddBuff = CI_AddBuff
local CI_GetMemberInfo = CI_GetMemberInfo
local CI_DeleteFaction = CI_DeleteFaction
local GetPlayerPoints = GetPlayerPoints
local AddPlayerPoints = AddPlayerPoints
local CI_GetFactionLeaderInfo = CI_GetFactionLeaderInfo
local GetServerTime = GetServerTime
local ReplaceFactionLeader = ReplaceFactionLeader
local CI_SetFactionInfo = CI_SetFactionInfo
local tostring = tostring
local db_module = require('Script.cext.dbrpc')
local GI_GetFactionID = db_module.get_faction_id
local GI_ApplyJoinFaction = db_module.apply_join_faction
local GI_DelApplyJoinFaction = db_module.delapply_join_faction
local GI_GetFHeaderLastLogin = db_module.get_fheader_lastlogin
local PI_PayPlayer = PI_PayPlayer
local define		= require('Script.cext.define')
local FACTION_BZ,FACTION_FBZ,FACTION_ZL,FACTION_XZ = define.FACTION_BZ,define.FACTION_FBZ,define.FACTION_ZL,define.FACTION_XZ
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos
local math_ceil = math.ceil
local math_floor = math.floor
local IsPlayerOnline = IsPlayerOnline
local CI_JoinFaction = CI_JoinFaction
local PI_GetPlayerName = PI_GetPlayerName
local PI_GetPlayerVipType = PI_GetPlayerVipType
local PI_GetPlayerLevel = PI_GetPlayerLevel
local PI_GetPlayerHeadID = PI_GetPlayerHeadID
local PI_SetPlayerFacID = PI_SetPlayerFacID
local define		= require('Script.cext.define')
local ProBarType = define.ProBarType
local table_locate = table.locate
local CI_LeaveFaction = CI_LeaveFaction
local time_cnt = require('Script.common.time_cnt')
local GetDiffDayFromTime = time_cnt.GetDiffDayFromTime
local os_date = os.date
local GetTimesInfo = GetTimesInfo
local bsmz = require ("Script.bsmz.bsmz_fun")
local bsmz_online = bsmz.bsmz_online
--------------------------------------------------------------------------
-- data:

--�������
faction_conf = {
	create = {50,628},
	donate = {{682,20,20},{683,500,500}}, --���ߡ����˰ﹱ������ʽ�
	createlv = 30,
	union = 1000, --���˷���
	clear = 500,--���˷���
}

fBuild_conf = {
	soul = {1084,100,1,100}, --����ι��(���ߡ��ɳ������ޡ��ɳ����������ﹱ����)
	yb = 10, --10����10Ԫ��
	limit = {nil,2,1,4,3,1,5}, --�����������ƣ�����ȼ�),��1�⣬��������Ϊ��
	[1] = {
		name = '�������',maxlv = 10, --���֡���ߵȼ�
		ico = 11,
		t = {20*60*60,24*60*60,30*60*60,38*60*60,48*60*60,60*60*60,74*60*60,90*60*60,108*60*60}, --CDʱ��
		m = {2000,4000,10000,20000,40000,100000,200000,400000,800000}, --���Ѱ���ʽ�
		dec = '�����������������ȼ�����������ȼ��������𽥼������������������������ø������',
	},
	[2] = {
		name = '�ﹱ�̵�',maxlv = 10, --limit ������ȼ�����
		ico = 12,
		t = {3*60*60,6*60*60,10*60*60,15*60*60,21*60*60,28*60*60,36*60*60,45*60*60,55*60*60},
		m = {1000,2000,4000,10000,20000,40000,100000,200000,400000},
		dec = '�ﹱ�̵�ȼ�Խ�ߣ��ڰﹱ�̵��п��Զһ����Ķ���Խ�á�',
	},
	[3] = {
		name = '������Ժ',maxlv = 10,
		ico = 13,
		t = {3*60*60,6*60*60,10*60*60,15*60*60,21*60*60,28*60*60,36*60*60,45*60*60,55*60*60},
		m = {500,1000,2000,5000,10000,20000,50000,100000,200000},
		dec = '������Ժ�ȼ�Խ�ߣ�����Ա��ѧϰ�İ�Ἴ�ܵȼ�Խ�ߡ�',
	},
	[4] = {
		name = '���޼�̳',maxlv = 10,
		ico = 14,
		t = {3*60*60,6*60*60,10*60*60,15*60*60,21*60*60,28*60*60,36*60*60,45*60*60,55*60*60},
		m = {1000,2000,4000,10000,20000,40000,100000,200000,400000},
		dec = '���޼�̳�ȼ�Խ�ߣ��ٻ�����ʱ����ѡ��ĵȼ���Խ�ࡣ',
	},
	[5] = {
		name = '�����',maxlv = 10,
		ico = 15,
		t = {3*60*60,6*60*60,10*60*60,15*60*60,21*60*60,28*60*60,36*60*60,45*60*60,55*60*60},
		m = {1000,2000,4000,10000,20000,40000,100000,200000,400000},
		dec = '�����ȼ�Խ�ߣ�ÿ�հ���Ա�ܽ��а��齱�Ĵ���Խ�ࡣ(������Ч)',
	},
	[6] = {
		name = '�۱���',maxlv = 10,
		ico = 16,
		t = {3*60*60,6*60*60,10*60*60,15*60*60,21*60*60,28*60*60,36*60*60,45*60*60,55*60*60},
		m = {500,1000,2000,5000,10000,20000,50000,100000,200000},
		dec = '�۱���ȼ�Խ�ߣ��ᱦ��з��ŵĽ���Խ�ߡ�(������Ч)',
	},
	[7] = {
		name = '��ʯ����',maxlv = 10,
		ico = 17,
		t = {20*60*60,24*60*60,30*60*60,38*60*60,48*60*60,60*60*60,74*60*60,90*60*60,108*60*60},
		m = {500000,1000000,1500000,2000000,2500000,3000000,3500000,4000000,5000000},
		dec = '�������ĵȼ�Խ�ߣ�ÿ�ջ�������Ҳ������',
	},
}

--�����˰������
fAuto_conf = {
	maxnum = 2, --���ɴ��������˰����
	fnum = 30, --��������ƣ��ﵽ�����������������˰�ᣩ
	wlv = 0, --����ȼ�����(��ǰ�������ã������������˰�ᣩ
	num	= 20, --�ﵽת�õ�����(���ô���30)
	[1]={n='��Եɲ',h='��»�',lv=34,sex=1,head=0,vip=4,school=1},
	[2]={n='������',h='Ȩ�Ǻ�',lv=36,sex=1,head=0,vip=4,school=2},
	[3]={n='�����',h='����ܰ',lv=37,sex=0,head=0,vip=4,school=3},
	[4]={n='��ѩɽ',h='������',lv=34,sex=0,head=0,vip=4,school=1},
	[5]={n='������',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[6]={n='������',h='�����',lv=37,sex=1,head=0,vip=4,school=3},
	[7]={n='��ӥ��',h='�����',lv=34,sex=1,head=0,vip=4,school=1},
	[8]={n='���׳�',h='�Ժ��',lv=36,sex=1,head=0,vip=4,school=2},
	[9]={n='�ɻ���Ժ',h='������',lv=37,sex=0,head=0,vip=4,school=3},
	[10]={n='��ɽ��',h='�ʸ���־',lv=34,sex=0,head=0,vip=4,school=1},
	[11]={n='��צ��',h='�޽���',lv=36,sex=0,head=0,vip=4,school=2},
	[12]={n='��ϼ��',h='Ľ�ݺ���',lv=37,sex=1,head=0,vip=4,school=3},
	[13]={n='��������',h='����ѩ��',lv=34,sex=1,head=0,vip=4,school=1},
	[14]={n='���ι�',h='������',lv=36,sex=1,head=0,vip=4,school=2},
	[15]={n='������',h='����',lv=37,sex=0,head=0,vip=4,school=3},
	[16]={n='������',h='᯺�ΰ',lv=34,sex=0,head=0,vip=4,school=1},
	[17]={n='÷����',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[18]={n='������',h='»����',lv=37,sex=1,head=0,vip=4,school=3},
	[19]={n='���ի',h='�ֺ���',lv=34,sex=1,head=0,vip=4,school=1},
	[20]={n='��ɱ',h='��������',lv=36,sex=1,head=0,vip=4,school=2},
	[21]={n='�������',h='������',lv=37,sex=0,head=0,vip=4,school=3},
	[22]={n='������',h='˾ͽ����',lv=34,sex=0,head=0,vip=4,school=1},
	[23]={n='���ɵ�',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[24]={n='����¥',h='Ī�껪',lv=37,sex=1,head=0,vip=4,school=3},
	[25]={n='������',h='��˧־��',lv=34,sex=1,head=0,vip=4,school=1},
	[26]={n='ǧ����',h='���ͼ',lv=36,sex=1,head=0,vip=4,school=2},
	[27]={n='���ǵ�',h='������',lv=37,sex=0,head=0,vip=4,school=3},
	[28]={n='������',h='������',lv=34,sex=0,head=0,vip=4,school=1},
	[29]={n='����',h='�����',lv=36,sex=0,head=0,vip=4,school=2},
	[30]={n='�����',h='�ܼ�ܲ',lv=37,sex=1,head=0,vip=4,school=3},
	[31]={n='����',h='·����',lv=34,sex=1,head=0,vip=4,school=1},
	[32]={n='�����',h='���ְ�',lv=36,sex=1,head=0,vip=4,school=2},
	[33]={n='���ǽ�',h='������',lv=37,sex=0,head=0,vip=4,school=3},
	[34]={n='�����',h='���̺�',lv=34,sex=0,head=0,vip=4,school=1},
	[35]={n='����',h='�����',lv=36,sex=0,head=0,vip=4,school=2},
	[36]={n='���˸�',h='κ����',lv=37,sex=1,head=0,vip=4,school=3},
	[37]={n='���Է',h='������',lv=34,sex=1,head=0,vip=4,school=1},
	[38]={n='����',h='Ԫ���',lv=36,sex=1,head=0,vip=4,school=2},
	[39]={n='�޺���',h='½����',lv=37,sex=0,head=0,vip=4,school=3},
	[40]={n='����',h='���ں���',lv=34,sex=0,head=0,vip=4,school=1},
	[41]={n='ī���',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[42]={n='������',h='ٹΰ��',lv=37,sex=1,head=0,vip=4,school=3},
	[43]={n='�׹���',h='��Ԫ��',lv=34,sex=1,head=0,vip=4,school=1},
	[44]={n='������',h='����Ӣ',lv=36,sex=1,head=0,vip=4,school=2},
	[45]={n='ʥ����',h='������',lv=37,sex=0,head=0,vip=4,school=3},
	[46]={n='��˼��',h='������',lv=34,sex=0,head=0,vip=4,school=1},
	[47]={n='������',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[48]={n='�޺���',h='ӡ��־',lv=37,sex=1,head=0,vip=4,school=3},
	[49]={n='���е�',h='������',lv=34,sex=1,head=0,vip=4,school=1},
	[50]={n='��Ԫɽ',h='��̩��',lv=36,sex=1,head=0,vip=4,school=2},
	[51]={n='���߸�',h='����ʤ',lv=37,sex=0,head=0,vip=4,school=3},
	[52]={n='����¥',h='ۣ����',lv=34,sex=0,head=0,vip=4,school=1},
	[53]={n='������',h='����Ȼ',lv=36,sex=0,head=0,vip=4,school=2},
	[54]={n='������',h='������',lv=37,sex=1,head=0,vip=4,school=3},
	[55]={n='������',h='Σ����',lv=34,sex=1,head=0,vip=4,school=1},
	[56]={n='��Ƿ�',h='����ï',lv=36,sex=1,head=0,vip=4,school=2},
	[57]={n='�j��ɽׯ',h='ݷ����',lv=37,sex=0,head=0,vip=4,school=3},
	[58]={n='Ѫ����',h='����־',lv=34,sex=0,head=0,vip=4,school=1},
	[59]={n='������',h='�����',lv=36,sex=0,head=0,vip=4,school=2},
	[60]={n='���Ϲ�',h='��Ԫ��',lv=37,sex=1,head=0,vip=4,school=3},
	[61]={n='�ռ���',h='�º���',lv=34,sex=1,head=0,vip=4,school=1},
	[62]={n='������',h='�´Ͻ�',lv=36,sex=1,head=0,vip=4,school=2},
	[63]={n='��ѻ��',h='������',lv=37,sex=0,head=0,vip=4,school=3},
	[64]={n='������',h='���츳',lv=34,sex=0,head=0,vip=4,school=1},
	[65]={n='�����',h='�ӳ���Ծ',lv=36,sex=0,head=0,vip=4,school=2},
	[66]={n='�»���',h='�ڿ���',lv=37,sex=1,head=0,vip=4,school=3},
	[67]={n='������',h='������',lv=34,sex=1,head=0,vip=4,school=1},
	[68]={n='Ѫ���',h='�����d',lv=36,sex=1,head=0,vip=4,school=2},
	[69]={n='�Ⱥ���',h='�̨����',lv=37,sex=0,head=0,vip=4,school=3},
	[70]={n='��ɲ��',h='������',lv=34,sex=0,head=0,vip=4,school=1},
	[71]={n='ʪ�Ž�',h='ͨ���',lv=36,sex=0,head=0,vip=4,school=2},
	[72]={n='���׷�',h='������',lv=37,sex=1,head=0,vip=4,school=3},
	[73]={n='Ǭ����',h='�˼���',lv=34,sex=1,head=0,vip=4,school=1},
	[74]={n='���ϵ�',h='������',lv=36,sex=1,head=0,vip=4,school=2},
	[75]={n='ī˪����',h='Ľ�ݵº�',lv=37,sex=0,head=0,vip=4,school=3},
	[76]={n='�����',h='Ԫ���k',lv=34,sex=0,head=0,vip=4,school=1},
	[77]={n='������',h='����',lv=36,sex=0,head=0,vip=4,school=2},
	[78]={n='������',h='�ӳ�����',lv=37,sex=1,head=0,vip=4,school=3},
	[79]={n='������',h='���컪',lv=34,sex=1,head=0,vip=4,school=1},
	[80]={n='����',h='�ɸ߾�',lv=36,sex=1,head=0,vip=4,school=2},
	[81]={n='������',h='����־',lv=37,sex=0,head=0,vip=4,school=3},
	[82]={n='�����',h='�ں��',lv=34,sex=0,head=0,vip=4,school=1},
	[83]={n='������',h='ȽԪ��',lv=36,sex=0,head=0,vip=4,school=2},
	[84]={n='������',h='����ͬ',lv=37,sex=1,head=0,vip=4,school=3},
	[85]={n='��浺',h='������',lv=34,sex=1,head=0,vip=4,school=1},
	[86]={n='������',h='�ڼ���',lv=36,sex=1,head=0,vip=4,school=2},
	[87]={n='����ɽ',h='�˸���',lv=37,sex=0,head=0,vip=4,school=3},
	[88]={n='ˮ����',h='�಩��',lv=34,sex=0,head=0,vip=4,school=1},
	[89]={n='���˳�',h='棺����',lv=36,sex=0,head=0,vip=4,school=2},
	[90]={n='����ի',h='������',lv=37,sex=1,head=0,vip=4,school=3},
	[91]={n='����¥',h='������',lv=34,sex=1,head=0,vip=4,school=1},
	[92]={n='���λ�',h='³����',lv=36,sex=1,head=0,vip=4,school=2},
	[93]={n='��ɷ��',h='������',lv=37,sex=0,head=0,vip=4,school=3},
	[94]={n='���Կ�ջ',h='��ΰ��',lv=34,sex=0,head=0,vip=4,school=1},
	[95]={n='��ħɲ',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[96]={n='����ɲ',h='������',lv=37,sex=1,head=0,vip=4,school=3},
	[97]={n='�����',h='ϯ����',lv=34,sex=1,head=0,vip=4,school=1},
	[98]={n='���˾�',h='쯺���',lv=36,sex=1,head=0,vip=4,school=2},
	[99]={n='���ε�',h='������',lv=37,sex=0,head=0,vip=4,school=3},
	[100]={n='��Ӱ��',h='������',lv=34,sex=0,head=0,vip=4,school=1},
	[101]={n='���߸�',h='�����컪',lv=36,sex=0,head=0,vip=4,school=2},
	[102]={n='��Ů��',h='��۳����',lv=37,sex=1,head=0,vip=4,school=3},
	[103]={n='���ڵ�',h='Ƥ�콾',lv=34,sex=1,head=0,vip=4,school=1},
	[104]={n='���ɽׯ',h='��ұ�ų�',lv=36,sex=1,head=0,vip=4,school=2},
	[105]={n='������',h='������',lv=37,sex=0,head=0,vip=4,school=3},
	[106]={n='�޼�Է',h='������',lv=34,sex=0,head=0,vip=4,school=1},
	[107]={n='������',h='�ڸ߷�',lv=36,sex=0,head=0,vip=4,school=2},
	[108]={n='а����',h='�ٲ���',lv=37,sex=1,head=0,vip=4,school=3},
	[109]={n='�칷��',h='ͨ���',lv=34,sex=1,head=0,vip=4,school=1},
	[110]={n='������',h='������',lv=36,sex=1,head=0,vip=4,school=2},
	[111]={n='��㵳',h='��ͬ��',lv=37,sex=0,head=0,vip=4,school=3},
	[112]={n='���',h='�θɲ���',lv=34,sex=0,head=0,vip=4,school=1},
	[113]={n='������',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[114]={n='�����',h='��˷�',lv=37,sex=1,head=0,vip=4,school=3},
	[115]={n='ī���',h='̸̩��',lv=34,sex=1,head=0,vip=4,school=1},
	[116]={n='Ԫʼ��',h='���ǽ�',lv=36,sex=1,head=0,vip=4,school=2},
	[117]={n='Ѫ����',h='��������',lv=37,sex=0,head=0,vip=4,school=3},
	[118]={n='����',h='���Ԫ',lv=34,sex=0,head=0,vip=4,school=1},
	[119]={n='����',h='���겮',lv=36,sex=0,head=0,vip=4,school=2},
	[120]={n='�𻢽�',h='������',lv=37,sex=1,head=0,vip=4,school=3},
	[121]={n='�����ջ',h='����ī',lv=34,sex=1,head=0,vip=4,school=1},
	[122]={n='�޻���',h='�����',lv=36,sex=1,head=0,vip=4,school=2},
	[123]={n='��Ӱ����',h='˾��ʯ',lv=37,sex=0,head=0,vip=4,school=3},
	[124]={n='������',h='�ò���',lv=34,sex=0,head=0,vip=4,school=1},
	[125]={n='����Է',h='Ī��Ϊ',lv=36,sex=0,head=0,vip=4,school=2},
	[126]={n='������',h='�潨��',lv=37,sex=1,head=0,vip=4,school=3},
	[127]={n='�����',h='������',lv=34,sex=1,head=0,vip=4,school=1},
	[128]={n='�޶���',h='ղ����',lv=36,sex=1,head=0,vip=4,school=2},
	[129]={n='ͯ������',h='�����',lv=37,sex=0,head=0,vip=4,school=3},
	[130]={n='а������',h='������',lv=34,sex=0,head=0,vip=4,school=1},
	[131]={n='�ֹ�ɲ',h='��ΰ��',lv=36,sex=0,head=0,vip=4,school=2},
	[132]={n='���ǰ�',h='�������',lv=37,sex=1,head=0,vip=4,school=3},
	[133]={n='��׽���',h='�°���',lv=34,sex=1,head=0,vip=4,school=1},
	[134]={n='���췻',h='������',lv=36,sex=1,head=0,vip=4,school=2},
	[135]={n='������',h='������',lv=37,sex=0,head=0,vip=4,school=3},
	[136]={n='������',h='»�߸�',lv=34,sex=0,head=0,vip=4,school=1},
	[137]={n='ն����',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[138]={n='ն����',h='���Ƶ�',lv=37,sex=1,head=0,vip=4,school=3},
	[139]={n='���ո�',h='�ʺ�ԥ',lv=34,sex=1,head=0,vip=4,school=1},
	[140]={n='��̥��',h='����Ԩ',lv=36,sex=1,head=0,vip=4,school=2},
	[141]={n='�׷��',h='������',lv=37,sex=0,head=0,vip=4,school=3},
	[142]={n='������',h='�͵���',lv=34,sex=0,head=0,vip=4,school=1},
	[143]={n='���¿�ջ',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[144]={n='ʴ����',h='������',lv=37,sex=1,head=0,vip=4,school=3},
	[145]={n='������',h='����־ҵ',lv=34,sex=1,head=0,vip=4,school=1},
	[146]={n='���յ�',h='�ڽ���',lv=36,sex=1,head=0,vip=4,school=2},
	[147]={n='�»���',h='˾�ܻ���',lv=37,sex=0,head=0,vip=4,school=3},
	[148]={n='����ʥ��',h='������',lv=34,sex=0,head=0,vip=4,school=1},
	[149]={n='�Ϻ縮',h='����Ӣ��',lv=36,sex=0,head=0,vip=4,school=2},
	[150]={n='������',h='��Ӣ��',lv=37,sex=1,head=0,vip=4,school=3},
	[151]={n='����Ժ',h='̫������',lv=34,sex=1,head=0,vip=4,school=1},
	[152]={n='ն��¥',h='������',lv=36,sex=1,head=0,vip=4,school=2},
	[153]={n='�ʼ���',h='����ɽ',lv=37,sex=0,head=0,vip=4,school=3},
	[154]={n='������',h='������',lv=34,sex=0,head=0,vip=4,school=1},
	[155]={n='������',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[156]={n='������',h='�����',lv=37,sex=1,head=0,vip=4,school=3},
	[157]={n='����ʥ��',h='�ɿ�̩',lv=34,sex=1,head=0,vip=4,school=1},
	[158]={n='����ɲ',h='Ȩ�ɺ�',lv=36,sex=1,head=0,vip=4,school=2},
	[159]={n='������',h='������',lv=37,sex=0,head=0,vip=4,school=3},
	[160]={n='ն����',h='�ֹ���',lv=34,sex=0,head=0,vip=4,school=1},
	[161]={n='�ٱ���',h='����ˮ',lv=36,sex=0,head=0,vip=4,school=2},
	[162]={n='����ի',h='����Ǭ',lv=37,sex=1,head=0,vip=4,school=3},
	[163]={n='����',h='�����Ž�',lv=34,sex=1,head=0,vip=4,school=1},
	[164]={n='������',h='ʦ�ж�',lv=36,sex=1,head=0,vip=4,school=2},
	[165]={n='������',h='������',lv=37,sex=0,head=0,vip=4,school=3},
	[166]={n='ϴ�跻',h='�̨����',lv=34,sex=0,head=0,vip=4,school=1},
	[167]={n='������',h='ǿ����',lv=36,sex=0,head=0,vip=4,school=2},
	[168]={n='�����',h='�����',lv=37,sex=1,head=0,vip=4,school=3},
	[169]={n='������',h='���ټ���',lv=34,sex=1,head=0,vip=4,school=1},
	[170]={n='Ѫ���',h='�꾰��',lv=36,sex=1,head=0,vip=4,school=2},
	[171]={n='ʪ����',h='ëԪ��',lv=37,sex=0,head=0,vip=4,school=3},
	[172]={n='���Ƶ�',h='����˫',lv=34,sex=0,head=0,vip=4,school=1},
	[173]={n='�����',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[174]={n='��Ԫ��',h='ȫ�칤',lv=37,sex=1,head=0,vip=4,school=3},
	[175]={n='����',h='ݷ����',lv=34,sex=1,head=0,vip=4,school=1},
	[176]={n='������',h='�����',lv=36,sex=1,head=0,vip=4,school=2},
	[177]={n='׷��կ',h='�ɺ�ʤ',lv=37,sex=0,head=0,vip=4,school=3},
	[178]={n='��׹�',h='��ѩ��',lv=34,sex=0,head=0,vip=4,school=1},
	[179]={n='а�Ɽ',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[180]={n='������',h='�׺���',lv=37,sex=1,head=0,vip=4,school=3},
	[181]={n='̫����',h='����Τ',lv=34,sex=1,head=0,vip=4,school=1},
	[182]={n='������',h='��������',lv=36,sex=1,head=0,vip=4,school=2},
	[183]={n='Ѫ����',h='����Զ',lv=37,sex=0,head=0,vip=4,school=3},
	[184]={n='��ľ����',h='Σΰ��',lv=34,sex=0,head=0,vip=4,school=1},
	[185]={n='����',h='��Ԫѫ',lv=36,sex=0,head=0,vip=4,school=2},
	[186]={n='�ղ���',h='ʩ ����',lv=37,sex=1,head=0,vip=4,school=3},
	[187]={n='ʥ��¥',h='���',lv=34,sex=1,head=0,vip=4,school=1},
	[188]={n='���',h='������',lv=36,sex=1,head=0,vip=4,school=2},
	[189]={n='�����',h='�Ȼ���',lv=37,sex=0,head=0,vip=4,school=3},
	[190]={n='ī��Ժ',h='��־��',lv=34,sex=0,head=0,vip=4,school=1},
	[191]={n='������',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[192]={n='������',h='ͨѩ��',lv=37,sex=1,head=0,vip=4,school=3},
	[193]={n='ɭ�޳�',h='�Ʒ�����',lv=34,sex=1,head=0,vip=4,school=1},
	[194]={n='���η�',h='��Խ��',lv=36,sex=1,head=0,vip=4,school=2},
	[195]={n='�����',h='̷����',lv=37,sex=0,head=0,vip=4,school=3},
	[196]={n='�����',h='�����',lv=34,sex=0,head=0,vip=4,school=1},
	[197]={n='�����',h='��̩��',lv=36,sex=0,head=0,vip=4,school=2},
	[198]={n='��������',h='��������',lv=37,sex=1,head=0,vip=4,school=3},
	[199]={n='׼�ὣ��',h='���˰�',lv=34,sex=1,head=0,vip=4,school=1},
	[200]={n='���e��',h='��̩��',lv=36,sex=1,head=0,vip=4,school=2},
	[201]={n='������',h='�����',lv=37,sex=0,head=0,vip=4,school=3},
	[202]={n='ϴ��ͤ',h='����',lv=34,sex=0,head=0,vip=4,school=1},
	[203]={n='�����',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[204]={n='Ѫ�籤',h='�ʸ�����',lv=37,sex=1,head=0,vip=4,school=3},
	[205]={n='��ϼ��',h='Ԭ����',lv=34,sex=1,head=0,vip=4,school=1},
	[206]={n='������',h='������',lv=36,sex=1,head=0,vip=4,school=2},
	[207]={n='����ɽׯ',h='�ྭ��',lv=37,sex=0,head=0,vip=4,school=3},
	[208]={n='����ի',h='������',lv=34,sex=0,head=0,vip=4,school=1},
	[209]={n='�����',h='����',lv=36,sex=0,head=0,vip=4,school=2},
	[210]={n='����Է',h='��ľӽ˼',lv=37,sex=1,head=0,vip=4,school=3},
	[211]={n='��Ԫ��Ժ',h='���º�',lv=34,sex=1,head=0,vip=4,school=1},
	[212]={n='���쵺',h='��Ӣ��',lv=36,sex=1,head=0,vip=4,school=2},
	[213]={n='������',h='������',lv=37,sex=0,head=0,vip=4,school=3},
	[214]={n='��β��',h='��Ԫ��',lv=34,sex=0,head=0,vip=4,school=1},
	[215]={n='����ͤ',h='���º�',lv=36,sex=0,head=0,vip=4,school=2},
	[216]={n='Ѫ����',h='����Ȼ',lv=37,sex=1,head=0,vip=4,school=3},
	[217]={n='����ի',h='ۣ����',lv=34,sex=1,head=0,vip=4,school=1},
	[218]={n='��˪��',h='������',lv=36,sex=1,head=0,vip=4,school=2},
	[219]={n='���鷿',h='������',lv=37,sex=0,head=0,vip=4,school=3},
	[220]={n='������',h='������',lv=34,sex=0,head=0,vip=4,school=1},
	[221]={n='��ӥ��',h='��٦�ͳ�',lv=36,sex=0,head=0,vip=4,school=2},
	[222]={n='������',h='ʱ����',lv=37,sex=1,head=0,vip=4,school=3},
	[223]={n='���䵺',h='��������',lv=34,sex=1,head=0,vip=4,school=1},
	[224]={n='���e��',h='���콾',lv=36,sex=1,head=0,vip=4,school=2},
	[225]={n='����ի',h='Ǯ����',lv=37,sex=0,head=0,vip=4,school=3},
	[226]={n='����ͤ',h='������',lv=34,sex=0,head=0,vip=4,school=1},
	[227]={n='��Ե��',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[228]={n='���ɽׯ',h='׿����',lv=37,sex=1,head=0,vip=4,school=3},
	[229]={n='���˵�',h='�찲��',lv=34,sex=1,head=0,vip=4,school=1},
	[230]={n='ǧ����',h='�Ԫ��',lv=36,sex=1,head=0,vip=4,school=2},
	[231]={n='������',h='�갮����',lv=37,sex=0,head=0,vip=4,school=3},
	[232]={n='�����',h='ʩ��ҵ',lv=34,sex=0,head=0,vip=4,school=1},
	[233]={n='������',h='�Ϲ��ǻ�',lv=36,sex=0,head=0,vip=4,school=2},
	[234]={n='��צ��Ժ',h='���ǻ�',lv=37,sex=1,head=0,vip=4,school=3},
	[235]={n='ī����',h='ŷ������',lv=34,sex=1,head=0,vip=4,school=1},
	[236]={n='���',h='�ֽ���',lv=36,sex=1,head=0,vip=4,school=2},
	[237]={n='��˪��',h='���ǹ�',lv=37,sex=0,head=0,vip=4,school=3},
	[238]={n='�������',h='�̿���',lv=34,sex=0,head=0,vip=4,school=1},
	[239]={n='���ճ�',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[240]={n='��ѻ��',h='갿�ˬ',lv=37,sex=1,head=0,vip=4,school=3},
	[241]={n='ʥ��¥',h='��٦����',lv=34,sex=1,head=0,vip=4,school=1},
	[242]={n='�����',h='·ΰ��',lv=36,sex=1,head=0,vip=4,school=2},
	[243]={n='������',h='������',lv=37,sex=0,head=0,vip=4,school=3},
	[244]={n='ʮ����',h='��Ӣ��',lv=34,sex=0,head=0,vip=4,school=1},
	[245]={n='�Իʹ�',h='�����',lv=36,sex=0,head=0,vip=4,school=2},
	[246]={n='������',h='������',lv=37,sex=1,head=0,vip=4,school=3},
	[247]={n='��˪��',h='Ľ�ݲ���',lv=34,sex=1,head=0,vip=4,school=1},
	[248]={n='��˼ʥ��',h='��ԯ����',lv=36,sex=1,head=0,vip=4,school=2},
	[249]={n='��˪��Ժ',h='���ѩ',lv=37,sex=0,head=0,vip=4,school=3},
	[250]={n='Ե����',h='�������',lv=34,sex=0,head=0,vip=4,school=1},
	[251]={n='��յ�',h='¡����',lv=36,sex=0,head=0,vip=4,school=2},
	[252]={n='�׺���',h='�Ʒ�����',lv=37,sex=1,head=0,vip=4,school=3},
	[253]={n='���ի',h='½����',lv=34,sex=1,head=0,vip=4,school=1},
	[254]={n='������',h='л����',lv=36,sex=1,head=0,vip=4,school=2},
	[255]={n='���⹬',h='�����',lv=37,sex=0,head=0,vip=4,school=3},
	[256]={n='ǧɽ��',h='��������',lv=34,sex=0,head=0,vip=4,school=1},
	[257]={n='����ʥ��',h='�Ͽ���',lv=36,sex=0,head=0,vip=4,school=2},
	[258]={n='������',h='������',lv=37,sex=1,head=0,vip=4,school=3},
	[259]={n='��Ԫ��',h='�����칤',lv=34,sex=1,head=0,vip=4,school=1},
	[260]={n='������',h='�����',lv=36,sex=1,head=0,vip=4,school=2},
	[261]={n='��ޒ��',h='Ҷ����',lv=37,sex=0,head=0,vip=4,school=3},
	[262]={n='������',h='Խ����',lv=34,sex=0,head=0,vip=4,school=1},
	[263]={n='���᷿',h='�¿���',lv=36,sex=0,head=0,vip=4,school=2},
	[264]={n='�����',h='����ӽ',lv=37,sex=1,head=0,vip=4,school=3},
	[265]={n='���ؽ�',h='���Ǻ�',lv=34,sex=1,head=0,vip=4,school=1},
	[266]={n='˫����',h='ղ����',lv=36,sex=1,head=0,vip=4,school=2},
	[267]={n='��ң��',h='˫Ӣ��',lv=37,sex=0,head=0,vip=4,school=3},
	[268]={n='������',h='�ȿ���',lv=34,sex=0,head=0,vip=4,school=1},
	[269]={n='�������',h='��Ӣ��',lv=36,sex=0,head=0,vip=4,school=2},
	[270]={n='�����',h='ǿ�ĺ�',lv=37,sex=1,head=0,vip=4,school=3},
	[271]={n='�켫��',h='�������',lv=34,sex=1,head=0,vip=4,school=1},
	[272]={n='������',h='������',lv=36,sex=1,head=0,vip=4,school=2},
	[273]={n='������',h='��ұԪ��',lv=37,sex=0,head=0,vip=4,school=3},
	[274]={n='��ʬ��',h='��١����',lv=34,sex=0,head=0,vip=4,school=1},
	[275]={n='��ɳ��',h='���ź�',lv=36,sex=0,head=0,vip=4,school=2},
	[276]={n='ն����',h='ëïѫ',lv=37,sex=1,head=0,vip=4,school=3},
	[277]={n='������',h='׿����',lv=34,sex=1,head=0,vip=4,school=1},
	[278]={n='��˪��',h='̨�',lv=36,sex=1,head=0,vip=4,school=2},
	[279]={n='�����',h='Ӧ�',lv=37,sex=0,head=0,vip=4,school=3},
	[280]={n='�����',h='���ͺƵ�',lv=34,sex=0,head=0,vip=4,school=1},
	[281]={n='Ѫħ��Ժ',h='��١����',lv=36,sex=0,head=0,vip=4,school=2},
	[282]={n='��ӥկ',h='��ӽ˼',lv=37,sex=1,head=0,vip=4,school=3},
	[283]={n='÷����',h='΢�����',lv=34,sex=1,head=0,vip=4,school=1},
	[284]={n='�޹���ջ',h='�����',lv=36,sex=1,head=0,vip=4,school=2},
	[285]={n='���߸�',h='��Զ��',lv=37,sex=0,head=0,vip=4,school=3},
	[286]={n='������',h='����̩��',lv=34,sex=0,head=0,vip=4,school=1},
	[287]={n='�ɻ�ͤ',h='�����',lv=36,sex=0,head=0,vip=4,school=2},
	[288]={n='�ɺ���',h='����',lv=37,sex=1,head=0,vip=4,school=3},
	[289]={n='����ի',h='�ھ�ɽ',lv=34,sex=1,head=0,vip=4,school=1},
	[290]={n='��Ե��',h='�����',lv=36,sex=1,head=0,vip=4,school=2},
	[291]={n='������',h='����Զ',lv=37,sex=0,head=0,vip=4,school=3},
	[292]={n='������',h='������',lv=34,sex=0,head=0,vip=4,school=1},
	[293]={n='�Ļþ�',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[294]={n='�׻���',h='˾ͽ����',lv=37,sex=1,head=0,vip=4,school=3},
	[295]={n='��ɱɽ',h='������',lv=34,sex=1,head=0,vip=4,school=1},
	[296]={n='���������',h='��Ӣ��',lv=36,sex=1,head=0,vip=4,school=2},
	[297]={n='�޺�կ',h='Ƚ����',lv=37,sex=0,head=0,vip=4,school=3},
	[298]={n='��׹�',h='嵸���',lv=34,sex=0,head=0,vip=4,school=1},
	[299]={n='�����',h='������',lv=36,sex=0,head=0,vip=4,school=2},
	[300]={n='����ʥ��',h='������',lv=37,sex=1,head=0,vip=4,school=3},

}

---פ������
local zhudi_conf={
	enter={
		[1]={25,33},--����
		[2]={50,60},--���
	},
}
local mijing_conf={
	opentime = {1200,2400},--�ؾ�����ʱ��
	box={monsterId = 126 ,eventScript=3 ,camp = 4,x=6,y=48,},--����
	f_monster={ --�ؾ���������
		[2]={monsterId = 123 ,BRMONSTER = 1, centerX = 41 , centerY = 36 , BRArea = 6 , BRNumber =8 , deadbody = 6 ,refreshTime =50, },--С��
		[3]={monsterId = 124 ,BRMONSTER = 1, centerX = 41 , centerY = 36 , BRArea = 6 , BRNumber =1 , deadbody = 6 ,refreshTime =100, },--С��
		[4]={monsterId = 123 ,BRMONSTER = 1, centerX = 38 , centerY = 12 , BRArea = 6 , BRNumber =8 , deadbody = 6 ,refreshTime =50, },--С��
		[5]={monsterId = 124 ,BRMONSTER = 1, centerX = 38 , centerY = 12 , BRArea = 6 , BRNumber =1 , deadbody = 6 ,refreshTime =100, },--С��
		[6]={monsterId = 123 ,BRMONSTER = 1, centerX = 16 , centerY = 28 , BRArea = 6 , BRNumber =8 , deadbody = 6 ,refreshTime =50, },--С��
		[7]={monsterId = 124 ,BRMONSTER = 1, centerX = 16 , centerY = 28 , BRArea = 6 , BRNumber =1 , deadbody = 6 ,refreshTime =100, },--С��
		[8]={monsterId = 123 ,BRMONSTER = 1, centerX = 11 , centerY = 51 , BRArea = 6 , BRNumber =8 , deadbody = 6 ,refreshTime =150, },--С��
		[9]={monsterId = 124 ,BRMONSTER = 1, centerX = 11 , centerY = 51 , BRArea = 6 , BRNumber =2 , deadbody = 6 ,refreshTime =150, },--С��
		[10]={monsterId = 125 ,x= 40 , y =7 ,},--ˮ��
		[11]={monsterId = 125 ,x= 34 , y =11 ,},--ˮ��
		[12]={monsterId = 125 ,x= 37 , y =17 ,},--ˮ��
		[13]={monsterId = 125 ,x= 43 , y =13 ,},--ˮ��
	},
	wlevel = {		-- ����ȼ��Թ�������Ӱ��
		[30] = {
			[2] = {[1] = 24000 , [3] = 800,[4] = 800 , [5] = 1000,[6] = 400 , [7] = 400,[8] = 400 , [9] = 400, },
			[3] = {[1] = 48000 , [3] = 1500,[4] = 1500 , [5] = 2000,[6] = 700 , [7] = 700,[8] = 700 , [9] = 700,},
			[4] = {[1] = 24000 , [3] = 800,[4] = 800 , [5] = 1000,[6] = 400 , [7] = 400,[8] = 400 , [9] = 400, },
			[5] = {[1] = 48000 , [3] = 1500,[4] = 1500 , [5] = 2000,[6] = 700 , [7] = 700,[8] = 700 , [9] = 700,},
			[6] = {[1] = 24000 , [3] = 800,[4] = 800 , [5] = 1000,[6] = 400 , [7] = 400,[8] = 400 , [9] = 400, },
			[7] = {[1] = 48000 , [3] = 1500,[4] = 1500 , [5] = 2000,[6] = 700 , [7] = 700,[8] = 700 , [9] = 700,},
			[8] = {[1] = 24000 , [3] = 800,[4] = 800 , [5] = 1000,[6] = 400 , [7] = 400,[8] = 400 , [9] = 400, },
			[9] = {[1] = 48000 , [3] = 1500,[4] = 1500 , [5] = 2000,[6] = 700 , [7] = 700,[8] = 700 , [9] = 700,},
		},
		[40] = {
			[2] = {[1] = 38000 , [3] = 1300,[4] = 1300 , [5] = 2000,[6] = 600 , [7] = 600,[8] = 600 , [9] = 600,},
			[3] = {[1] = 80000 , [3] = 2600,[4] = 2600 , [5] = 3000,[6] = 1300 , [7] = 1300,[8] = 1300 , [9] = 1300, },
			[4] = {[1] = 38000 , [3] = 1300,[4] = 1300 , [5] = 2000,[6] = 600 , [7] = 600,[8] = 600 , [9] = 600,},
			[5] = {[1] = 80000 , [3] = 2600,[4] = 2600 , [5] = 3000,[6] = 1300 , [7] = 1300,[8] = 1300 , [9] = 1300, },
			[6] = {[1] = 38000 , [3] = 1300,[4] = 1300 , [5] = 2000,[6] = 600 , [7] = 600,[8] = 600 , [9] = 600,},
			[7] = {[1] = 80000 , [3] = 2600,[4] = 2600 , [5] = 3000,[6] = 1300 , [7] = 1300,[8] = 1300 , [9] = 1300, },
			[8] = {[1] = 38000 , [3] = 1300,[4] = 1300 , [5] = 2000,[6] = 600 , [7] = 600,[8] = 600 , [9] = 600,},
			[9] = {[1] = 80000 , [3] = 2600,[4] = 2600 , [5] = 3000,[6] = 1300 , [7] = 1300,[8] = 1300 , [9] = 1300, },			
		},
		[45] = {
			[2] = {[1] = 48000 , [3] = 1600,[4] = 1300 , [5] = 2500,[6] = 800 , [7] = 800,[8] = 800 , [9] = 800,},
			[3] = {[1] = 100000 , [3] = 3300,[4] = 3000 , [5] = 4000,[6] = 1600 , [7] = 1600,[8] = 1600 , [9] = 1600, },
		    [4] = {[1] = 48000 , [3] = 1600,[4] = 1300 , [5] = 2500,[6] = 800 , [7] = 800,[8] = 800 , [9] = 800,},
			[5] = {[1] = 100000 , [3] = 3300,[4] = 3000 , [5] = 4000,[6] = 1600 , [7] = 1600,[8] = 1600 , [9] = 1600, },
			[6] = {[1] = 48000 , [3] = 1600,[4] = 1300 , [5] = 2500,[6] = 800 , [7] = 800,[8] = 800 , [9] = 800,},
			[7] = {[1] = 100000 , [3] = 3300,[4] = 3000 , [5] = 4000,[6] = 1600 , [7] = 1600,[8] = 1600 , [9] = 1600, },
			[8] = {[1] = 48000 , [3] = 1600,[4] = 1300 , [5] = 2500,[6] = 800 , [7] = 800,[8] = 800 , [9] = 800,},
			[9] = {[1] = 100000 , [3] = 3300,[4] = 3000 , [5] = 4000,[6] = 1600 , [7] = 1600,[8] = 1600 , [9] = 1600, },
		},
		[50] = {
			[2] = {[1] = 56000 , [3] = 1900,[4] = 1600 , [5] = 2500,[6] = 950 , [7] = 950,[8] = 950 , [9] = 950,},
			[3] = {[1] = 120000 , [3] = 3900,[4] = 3200 , [5] = 4500,[6] = 3000 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[4] = {[1] = 56000 , [3] = 1900,[4] = 1600 , [5] = 2500,[6] = 950 , [7] = 950,[8] = 950 , [9] = 950,},
			[5] = {[1] = 120000 , [3] = 3900,[4] = 3200 , [5] = 4500,[6] = 3000 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[6] = {[1] = 56000 , [3] = 1900,[4] = 1600 , [5] = 2500,[6] = 950 , [7] = 950,[8] = 950 , [9] = 950,},
			[7] = {[1] = 120000 , [3] = 3900,[4] = 3200 , [5] = 4500,[6] = 3000 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[8] = {[1] = 56000 , [3] = 1900,[4] = 1600 , [5] = 2500,[6] = 950 , [7] = 950,[8] = 950 , [9] = 950,},
			[9] = {[1] = 120000 , [3] = 3900,[4] = 3200 , [5] = 4500,[6] = 3000 , [7] = 1800,[8] = 1800 , [9] = 1800, },
		},
		[55] = {
			[2] = {[1] = 60000 , [3] = 2400,[4] = 2000 , [5] = 3000,[6] = 1200 , [7] = 1200,[8] = 1200 , [9] = 1200, },
			[3] = {[1] = 130000 , [3] = 4800,[4] = 4000 , [5] = 5200,[6] = 2400 , [7] = 2400,[8] = 2400 , [9] = 2400, },
			[4] = {[1] = 60000 , [3] = 2400,[4] = 2000 , [5] = 3000,[6] = 1200 , [7] = 1200,[8] = 1200 , [9] = 1200, },
			[5] = {[1] = 130000 , [3] = 4800,[4] = 4000 , [5] = 5200,[6] = 2400 , [7] = 2400,[8] = 2400 , [9] = 2400, },
			[6] = {[1] = 60000 , [3] = 2400,[4] = 2000 , [5] = 3000,[6] = 1200 , [7] = 1200,[8] = 1200 , [9] = 1200, },
			[7] = {[1] = 130000 , [3] = 4800,[4] = 4000 , [5] = 5200,[6] = 2400 , [7] = 2400,[8] = 2400 , [9] = 2400, },
			[8] = {[1] = 60000 , [3] = 2400,[4] = 2000 , [5] = 3000,[6] = 1200 , [7] = 1200,[8] = 1200 , [9] = 1200, },
			[9] = {[1] = 130000 , [3] = 4800,[4] = 4000 , [5] = 5200,[6] = 2400 , [7] = 2400,[8] = 2400 , [9] = 2400, },
		},
		[60] = {
			[2] = {[1] = 70000 , [3] = 2700,[4] = 2300 , [5] = 3500,[6] = 1800 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[3] = {[1] = 140000 , [3] = 5500,[4] = 4800 , [5] = 6000,[6] = 2700 , [7] = 2700,[8] = 2700 , [9] = 2700, },
			[4] = {[1] = 70000 , [3] = 2700,[4] = 2300 , [5] = 3500,[6] = 1800 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[5] = {[1] = 140000 , [3] = 5500,[4] = 4800 , [5] = 6000,[6] = 2700 , [7] = 2700,[8] = 2700 , [9] = 2700, },
			[6] = {[1] = 70000 , [3] = 2700,[4] = 2300 , [5] = 3500,[6] = 1800 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[7] = {[1] = 140000 , [3] = 5500,[4] = 4800 , [5] = 6000,[6] = 2700 , [7] = 2700,[8] = 2700 , [9] = 2700, },
			[8] = {[1] = 70000 , [3] = 2700,[4] = 2300 , [5] = 3500,[6] = 1800 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[9] = {[1] = 140000 , [3] = 5500,[4] = 4800 , [5] = 6000,[6] = 2700 , [7] = 2700,[8] = 2700 , [9] = 2700, },
		},
		[65] = {
			[2] = {[1] = 80000 , [3] = 3300,[4] = 2800 , [5] = 4000,[6] = 1600 , [7] = 1600,[8] = 1600 , [9] = 1600, },
			[3] = {[1] = 160000 , [3] = 6600,[4] = 6000 , [5] = 7000,[6] = 3300 , [7] = 3300,[8] = 3300 , [9] = 3300, },
			[4] = {[1] = 80000 , [3] = 3300,[4] = 2800 , [5] = 4000,[6] = 1600 , [7] = 1600,[8] = 1600 , [9] = 1600, },
			[5] = {[1] = 160000 , [3] = 6600,[4] = 6000 , [5] = 7000,[6] = 3300 , [7] = 3300,[8] = 3300 , [9] = 3300, },
			[6] = {[1] = 80000 , [3] = 3300,[4] = 2800 , [5] = 4000,[6] = 1600 , [7] = 1600,[8] = 1600 , [9] = 1600, },
			[7] = {[1] = 160000 , [3] = 6600,[4] = 6000 , [5] = 7000,[6] = 3300 , [7] = 3300,[8] = 3300 , [9] = 3300, },
			[8] = {[1] = 80000 , [3] = 3300,[4] = 2800 , [5] = 4000,[6] = 1600 , [7] = 1600,[8] = 1600 , [9] = 1600, },
			[9] = {[1] = 160000 , [3] = 6600,[4] = 6000 , [5] = 7000,[6] = 3300 , [7] = 3300,[8] = 3300 , [9] = 3300, },
		},
		[70] = {
			[2] = {[1] = 100000 , [3] = 3700,[4] = 3000 , [5] = 4000,[6] = 1800 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[3] = {[1] = 310000 , [3] = 7400,[4] = 6500 , [5] = 8000,[6] = 3700 , [7] = 3700,[8] = 3700 , [9] = 3700, },
			[4] = {[1] = 100000 , [3] = 3700,[4] = 3000 , [5] = 4000,[6] = 1800 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[5] = {[1] = 310000 , [3] = 7400,[4] = 6500 , [5] = 8000,[6] = 3700 , [7] = 3700,[8] = 3700 , [9] = 3700, },
			[6] = {[1] = 100000 , [3] = 3700,[4] = 3000 , [5] = 4000,[6] = 1800 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[7] = {[1] = 310000 , [3] = 7400,[4] = 6500 , [5] = 8000,[6] = 3700 , [7] = 3700,[8] = 3700 , [9] = 3700, },
			[8] = {[1] = 100000 , [3] = 3700,[4] = 3000 , [5] = 4000,[6] = 1800 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[9] = {[1] = 310000 , [3] = 7400,[4] = 6500 , [5] = 8000,[6] = 3700 , [7] = 3700,[8] = 3700 , [9] = 3700, },
		},
	},
	award={--����,�԰��ȼ�Ϊkey
		fmoney=100,--����ʽ�
		fss=2,--���޳ɳ�
		[1]={{601,10,1},{605,50,1},{615,3,1}},
		[2]={{601,10,1},{605,50,1},{615,3,1}},
		[3]={{601,10,1},{605,60,1},{615,3,1}},
		[4]={{601,10,1},{605,60,1},{615,3,1}},
		[5]={{601,10,1},{605,70,1},{615,3,1}},
		[6]={{601,10,1},{605,70,1},{615,3,1}},
		[7]={{601,10,1},{605,80,1},{615,3,1}},
		[8]={{601,10,1},{605,80,1},{615,3,1}},
		[9]={{601,10,1},{605,100,1},{615,3,1}},
		[10]={{601,10,1},{605,100,1},{615,3,1}},
	},
}

--��ȡ���˰������					  
local function get_faction_data(sid)
	local fdata=GI_GetPlayerData( sid , 'faction' , 250 )
	if fdata == nil then return end
	return fdata
end

--�жϰ�������Ƿ�ͻ����˰����������
local function _is_auto_faction_name(name)
	for _,v in pairs(fAuto_conf) do
		if(type(v) == type({}) and v.n~=nil and v.n == name)then
			return true
		end
	end
	return false
end

--����������ͬʱ�ж��Ƿ񼤻���������,ע�⣺��ᴴ��ʱҪ���ã���ʼ������1����������ؽ������
local function _upMainBuild()
	local lv = CI_GetFactionInfo(nil,2)
	local limit
	local buildLv
	--[[sxj,2014-08-21 update start]]-- 
	for i = 2,7 do	
		limit = fBuild_conf.limit[i]
		if i == 7 then
			buildLv = CI_GetFactionInfo(nil,12)		--ǿ����Ϊ12
		else	
			buildLv = CI_GetFactionInfo(nil,3+i)
		end
		if(limit~=nil and buildLv~=nil and buildLv == 0 and limit<=lv)then
			if i == 7 then
				CI_SetFactionInfo(nil,12,1)		--ǿ����Ϊ12
			else	
				CI_SetFactionInfo(nil,3+i,1)
			end	
		end
	end
	--[[sxj,2014-08-21 update end]]--
	
	--[[ older
	for i = 2,6 do
		limit = fBuild_conf.limit[i]
		buildLv = CI_GetFactionInfo(nil,3+i)
		if(limit~=nil and buildLv~=nil and buildLv == 0 and limit<=lv)then
			CI_SetFactionInfo(nil,3+i,1)
		end
	end
	]]--
end

--��Ӱ���ʽ�
local function _factionMoneyAdd(addmoney,fid)
	local money 
	if fid ~= nil then
		money = CI_GetFactionInfo(fid,3)
	else
		money = CI_GetFactionInfo(nil,3)
	end
	if money == nil then
		return --δ�鵽���
	end
	--look('money='..money)
	money = money + addmoney
	--look('money='..money)
	CI_SetFactionInfo(fid,3,money)
end

--��ȡ�������
function GetFactionData(fid)
	local hsid = CI_GetFactionLeaderInfo(fid,0)
	if(hsid == nil)then
		return 
	end

	if(__debug and nil==dbMgr.faction.data)then
		if __debug then 
			look(debug.traceback())
			look( "GetFactionData Error, fid:" .. tostring(fid) ) 
		end
	end
	
	if(dbMgr.faction.data == nil)then
		dbMgr.faction.data = {}
	end
	
	if(dbMgr.faction.data[fid] == nil)then 
		dbMgr.faction.data[fid] = {} 
	end
	
	if(dbMgr.faction.data[fid].soul == nil)then
		dbMgr.faction.data[fid].soul = {0} --{�ɳ��ȡ�CDʱ��}
	end
	--[[
		slmax={2,name}--����������������¼,����
	]]
	
	return dbMgr.faction.data[fid]
end

--�����ʱ����
function GetFactionTempData(fid)
	if(fid == nil)then return end
	if(__debug and nil==dbMgr.faction.temp)then
		if __debug then 
			look(debug.traceback())
			look( "GetFactionTempData Error, fid:" .. tostring(fid) ) 
		end
	end
	
	if(dbMgr.faction.temp == nil)then
		dbMgr.faction.temp = {}
	end
	
	if(dbMgr.faction.temp[fid] == nil)then 
		dbMgr.faction.temp[fid] = {} 
	end
	
	return dbMgr.faction.temp[fid]
end

--��ȡ�������
function GetFactionBootData()
	if(__debug and nil==dbMgr.faction.data)then
		if __debug then 
			look(debug.traceback())
			look( "GetFactionData Error, fid:" .. tostring(fid)) 
		end
	end
	
	if(dbMgr.faction.data == nil)then
		dbMgr.faction.data = {num = 0}
	end
	
	return dbMgr.faction.data
end

--����ս����
function clear_ff_score()
	local data = GetFactionBootData()
	if(data~=nil)then
		for i,v in pairs(data) do
			if(type(i) == type(0) and type(v) == type({}))then
				v.f_score = nil
			end
		end
	end
end

--�������ܰﹱ��ʶ
function set_player_ff_week_sign(sid,bOnline)
	--[[
	--look('=================================================')
	if(bOnline~=nil)then
		look('bOnline = '..bOnline)
	else
		look('bOnline is nil')
	end
	]]--
	if(bOnline == 1)then
		local temp = GetPlayerTemp_custom(sid)
		if(temp ~= nil)then
			temp.ff_cls = 1
		end
	else
		local fid = CI_GetPlayerData(23)
		if fid == nil or fid == 0 then
			return
		end
		CI_SetMemberInfo(0,2)
	end
end

--��������ܰﹱ
function clear_player_ff_week(sid)
	local temp = GetPlayerTemp_custom(sid)
	if(temp~=nil and temp.ff_cls ~= nil)then
		temp.ff_cls = nil
		local fid = CI_GetPlayerData(23)
		if fid == nil or fid == 0 then
			return
		end
		CI_SetMemberInfo(0,2)
	end
end

-- ÿ�ձ����������
function faction_eday_refresh()
	local data = GetFactionBootData()
	-- ������ÿ����ָ�һ�����ڴ���
	local openTime = GetServerOpenTime()
	-- local now = GetServerTime()
	if type(data) == type({}) then
		for i,v in pairs(data) do
			if(type(i) == type(0) and type(v) == type({}))then
				-- 1��������ս����
				v.c_score = nil
				--������������������
				v.slmax = nil

				-- 2��������������
				if v.ss then ---׷��,����������
					v.ss[2]=nil
				end
				-- 3����������������
				v.yunb = v.yunb or { [1] = 2, }		-- ��ʼ��2��
				if v.yunb then
					local ybData = v.yunb
					ybData[2] = nil
					ybData[3] = nil
					-- ybData[4] = nil
					ybData[5] = nil
					ybData[6] = nil
					ybData[7] = nil
					ybData[8] = nil
					-- ybData[9] = nil
					ybData[10] = nil
					-- �ָ����ڴ���(����5��)
					-- if ybData[1] < 5 then
						-- local days = GetDiffDayFromTime(openTime)
						-- look('faction_eday_refresh:' .. tostring(days))
						-- if days > 0 and days % 2 == 0 then
							-- ybData[1] = (ybData[1] or 0) + 1
						-- end
					-- end
				end
			end
		end
	end
end

--���Ͱ���lua��������
function SendFactionData(fid)
	if(fid~=nil)then
		local data = GetFactionData(fid)
		if(data~=nil)then
			--look(data[fid])
			GetFaction_ybData(fid)
			SendLuaMsg( 0, { ids = Faction_Data, data = data}, 9 )
		end
	end
end

--���봴�����
function CreateFaction_Apply(sid,name,checkID)
	if(type(name) ~= type(""))then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = 6}, 9 )
		return
	end
	
	if(_is_auto_faction_name(name))then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = -6}, 9 )
		return
	end

	local level=CI_GetPlayerData(1) --23���ID
	if(faction_conf.createlv>level)then --�ȼ�����
		SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = 5}, 9 )
		return
	end
	
	if(checkID~=1 and checkID~=2)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = 2}, 9 )
		return
	end
	
	local creatData = faction_conf.create
	if(checkID == 1 and not CheckCost( sid , creatData[1],1,1 ))then --Ԫ������
		SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = 3}, 9 )
		return
	elseif(checkID == 2 and CheckGoods(creatData[2],1,1,sid,'���봴�����')==0)then --���߲���
		SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = 4}, 9 )
		return
	end

	--�����ݿ�����һ���µİ���ID
	GI_GetFactionID(name,checkID)
end

--������᷵����ID������
function DBCALLBACK_CreateFaction(factionId, name, checkID)
	if(type(name) ~= type(""))then
		look('create factionName is not string') 
		return
	end
	if(factionId~=nil and factionId>0)then
		if(checkID==1 or checkID==2)then
			local result = CI_CreateFaction(name,factionId)
			if(result == nil)then
				SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = 7}, 9 )
			elseif(result == 0)then
				local data = GetFactionBootData()
				if(data)then
					if(data.num == nil)then 
						data.num = 1
					else
						data.num = data.num + 1
					end
				end
				local playerid = CI_GetPlayerData(17)
				local creatData = faction_conf.create
				if(checkID == 1)then
					CheckCost(playerid,creatData[1],0,1,"100009_�������")
					_upMainBuild()
					SendLuaMsg( 0, { ids = Faction_Build,idx = 1,lv = 1}, 9 )
				elseif(checkID == 2)then
					if(CheckGoods(creatData[2],1,0,playerid,'�������')==1)then
						local upResult = CI_SetFactionInfo(nil,2,2)
						if(upResult == 1)then
							_upMainBuild()
							SendLuaMsg( 0, { ids = Faction_Build,idx = 1,lv = 2}, 9 )
						end
					end
				end
				local newFid = ((GetGroupID()%10000)*2^16)+factionId
				GetFaction_ybData(newFid)
				set_join_factionDate(playerid)
				SendLuaMsg(0, { ids=Faction_SuccessJoin,fn = name,t=2, fid = newFid}, 9 )
				GI_DelApplyJoinFaction(playerid,0,0)
			else
				SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = result}, 9 )
			end
		end
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = -6}, 9 )
	end
end
--�Ӱ��buff �ӻ�
function SetFactionBuff(sid)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --��᲻����
	end
	
	local lv = CI_GetFactionInfo(nil,4)
	if(lv<=0)then return false,1 end --���ձ�δ����
	
	if(not CheckTimes(sid,uv_TimesTypeTb.FACTION_Buff,1,-1))then
		return false,3 --�����������
	end
	
	CI_AddBuff(125,0,lv,false)
	
	return true
end
--[[
function SendFactionBuffTimes(sid)
	local times = 0
	local tb = GetDaySpendData(sid,SpendType.Faction_Buff)
	if(tb ~= nil)then
		times = tb.count
	end
	SendLuaMsg( 0, { ids = Faction_Buff, times = times}, 9 )
end
]]--

--��ɢ���
function DeleteFaction(sid)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,-4 --��᲻����
	end
	
	local title = CI_GetMemberInfo(1)
	if(title~=FACTION_BZ)then return false,-3 end --���ǰ���
	
	if(faction_is_yunbiao(fid))then return false,-5 end --�˱��ڼ䲻�ܽ�ɢ���
	
	local fdata  = get_faction_data()
	fdata.jt = nil
	
	local result = CI_DeleteFaction(fid)
	if(result == nil)then return false,-4 end --��᲻����
	if(result == 0)then
		return true
	else
		return false,result
	end
end

--��ɢ����C++�ص�
function OnFactionClear(fid)
	if(fid~=nil and fid>0)then
		local data = GetFactionBootData()
		if(data)then
			if(data.num ~= nil)then 
				data.num = data.num - 1
			end
		end
		if(dbMgr.faction~=nil)then --������lua����
			if(dbMgr.faction.data~=nil and dbMgr.faction.data[fid]~=nil)then
				dbMgr.faction.data[fid] = nil
			end
			if(dbMgr.faction.temp~=nil)then
				if(dbMgr.faction.temp[fid]~=nil)then
					dbMgr.faction.temp[fid] = nil
				end
			end
		end
		
		--���ͬ�˹�ϵ
		delFactionUnion(nil,fid)
	end
end

--�����뿪���C++�ص�



--������ mtype 0 Ԫ�� 1 ����1 2 ����2 3 ͭǮ money Ԫ����/������
function DonateFaction(sid,money,mtype)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --�����Ϣ��ȡʧ��
	end--��᲻����
	
	local bp = GetPlayerPoints(sid,4)
	local curVal = 0
	if(bp ~= nil)then
		curVal = bp
	end
	if(curVal>=999999)then
		return false,4 --���˰ﹱ�Ѵ�����
	end
	
	local item
	local addVal
	if(mtype == 1 or mtype == 2)then
		item = faction_conf.donate[mtype]
		if(item == nil)then return 5 end --���߷Ƿ�
		addVal = money * item[2]
	elseif(mtype == 3)then
		addVal = math_floor(money/1000)
	else
		addVal = money
	end
	
	local isfull
	if((addVal+curVal)>999999)then 
		addVal = 999999 - curVal
		isfull = 1
	end
	
	if(addVal<0)then
		return false,4 --���˰ﹱ�Ѵ�����
	end
	
	local fmoney --���ӵİ���ʽ�
	local pVal --�������ӵİ�ṱ��
	--{{682,20,20},{683,500,500}} --���ߡ����˰ﹱ������ʽ�
	if(mtype == 0)then --Ԫ��
		if not CheckCost( sid , addVal , 0 , 1 ,"100017_�����˾���") then
			return false,3 --Ԫ������
		end
		pVal = addVal*10
		fmoney = addVal*10
	elseif(mtype == 3)then --ͭǮ
		local dayDonate = 0
		local timesF = GetTimesInfo(sid,uv_TimesTypeTb.donate_F)
		if(timesF and timesF[1])then
			dayDonate = timesF[1]
		end
		if((dayDonate + addVal*1000)>5000000)then
			return false,8
		end
	
		if(addVal<=0)then
			return false,7 --ͭǮ����1000
		end
		if(CheckGoods(0,addVal*1000,0,sid,'������')==0)then
			return false,2 --û���㹻����
		end
		CheckTimes(sid,uv_TimesTypeTb.donate_F,addVal*1000,-1)
		pVal = addVal
		fmoney = addVal
	else
		money = math_ceil(addVal/item[2])
		if(CheckGoods(item[1],money,0,sid,'������')==0)then
			return false,6 --û���㹻����
		end
		pVal = addVal 
		fmoney = money * item[3]
	end
	
	set_obj_pos(sid,1001) --���һ�ΰ�����
	
	_factionMoneyAdd(fmoney)
	AddPlayerPoints(sid,4,pVal,nil,'������')
	if(fmoney>=100)then
		FactionRPC(fid,'FF_TreasureMsg',3,CI_GetPlayerData(5),fmoney)
	end
	return true,fmoney,pVal,isfull
end

--[[
function SetPlayerFactionVal(sid,val)
	local ffData = FF_GetPlayerData(sid)
	if ffData then
		ffData.fVal = val
	end
	SendLuaMsg( 0, { ids=Faction_GetFactionVal, fbg = ffData.fVal }, 9 )
end
function GetPlayerFactionVal(sid)
	local ffData = FF_GetPlayerData(sid)
	if ffData then
		return ffData.fVal 
	end
	return 0
end
--:Faction LeveUp
function FactionLevelUp()
	local factionData = GetFactionInfo()
	if(nil == factionData) then
		--rfalse('��ȡ�����Ϣʧ��')	
		return false,'��ȡ�����Ϣʧ��'		
	end
	
	local level = factionData.level
	if(level >= 5)then
		--rfalse('�Ѿ������ȼ�')
		return false,'�Ѿ������ȼ�'			
	end
	
	level = level + 1
	
	--�������ȼ�
	--rfalse(factionData.factionName..','..level)
	if(SetFactionInfo(factionData.factionName,{level=level}))then
		SendLuaMsg( 0, { ids=Faction_LvUp, data ={ level=level} }, 9 )
		TipCenter( GetStringMsg(206))
		return true
	else
		return false,'�������ȼ�ʧ��'
	end
end
]]--

-- ����ɾ�������
--DeleteFaction("11")

--[[��Ӱ�����
function factionScoresAdd(addscores,fid)
	local faction 
	if fid ~= nil then
		faction = GetFactionInfo(fid)
	else
		faction = GetFactionInfo()
	end
	if faction == nil then
		return
	end
	--rfalse(" faction.scores:"..tostring(faction.scores).."   faction.factionName .."..tostring(faction.factionName))
	SetFactionInfo(faction.factionName,{ scores = addscores })
	SendLuaMsg( 0, { ids=Faction_UpdateScore, score = addscores }, 9 )
end

function factionPersonScoreAdd(addscores)
	local sid = CI_GetPlayerData(17) 
end

function AddPlayerFactionVal(sid,val)
	
	local ffData = FF_GetPlayerData(sid)
	if ffData then
		ffData.fVal = ( ffData.fVal or 0 ) + val
	end
	if(__plat == 4 and ffData.fVal>=9000)then
		Achieve_Default(sid,6011)
	end
	
	local old_sid = CI_GetPlayerData(17)	
	if 1==SetPlayer( sid, 1, 1 ) then
		SetMemberInfo(val)
		TipNormal( GetStringMsg(1,val))
		SendLuaMsg( 0, { ids=Faction_GetFactionVal, fbg = ffData.fVal }, 9 )
	end
	SetPlayer( old_sid, 1, 1)
	
	
end
]]--

--��������
function ImpeachFHeader(sid)
	local isFF = GI_Is_Active_Live('cf')
	if(isFF)then return end

	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then return end--��᲻����
	local title = CI_GetMemberInfo(1)
	if(title == FACTION_BZ)then return end --�Լ����ǰ���������ë��
	
	local hsid,seconds = CI_GetFactionLeaderInfo(fid,0)
	if(hsid == nil or seconds ==nil or seconds == 0)then
		TipCenter('��������ʱ���в��㵯��������')
		return 
	end
	
	if(IsPlayerOnline(hsid))then --�������
		return
	end
	
	local now = GetServerTime()
	local times = now - seconds
	if title == FACTION_FBZ then
		if(times<60*60*24*3)then return end
	elseif title == FACTION_ZL then
		if(times<60*60*24*4)then return end
	elseif title == FACTION_XZ then
		if(times<60*60*24*5)then return end
	else
		if(times<60*60*24*6)then return end
	end
	
	ReplaceFactionLeader()
	
	-- ����ǹ������������¹�����Ϣ
	local owner_fid = getCityOwner()
	if owner_fid and owner_fid == fid then
		SetPlayerTitle(sid,39)
		CI_AddBuff(304,0,1,true,2,sid)
		UpdateCityImageID(fid)
		BroadcastRPC('Set_King',CI_GetPlayerData(5,2,sid))
	end
	--GI_GetFHeaderLastLogin(hsid,sid,fid)
end

function CALLBACK_ImpeachFHeader(seconds,sid,hsid,fid)
	--local nhsid = CI_GetFactionLeaderInfo(fid,0)
	--if(nhsid == nil or nhsid ~= hsid)then return end
	
	--if not CheckCost( sid , 100 , 1 , 1 ,'��������') then return endReplaceFactionLeader()
	--if(ReplaceFactionLeader()==nil)then
	--	CheckCost( sid , 100 , 0 , 1,'100016_��������' )
	--end
end

--�����������
function UpdateSizeLevel(sid)
	local sizelevel = CI_GetFactionInfo(nil,10)
	if(sizelevel == nil)then --��ȡ�����Ϣ
		return false,0
	end
	
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --��᲻����
	end
	
	if(sizelevel>=2)then
		--�ﵽ�����������ֵ
		--TipCenter(GetStringMsg(574))
		return false,1
	end
	
	sizelevel = sizelevel + 1
	
	local cost = sizelevel*100
	if(cost == nil)then return false end
	
	if CheckCost( sid , cost, 1 , 1 ) then
		if(CI_SetFactionInfo(nil,10,sizelevel) == 1)then
			CheckCost( sid , cost , 0 , 1 ,'100020_�����������')
			FactionRPC(fid,'FF_TreasureMsg',2,sid,CI_GetPlayerData(5))
			return true,sizelevel
		else
			return false,2
		end
	else
		--����
		return false,3
	end
end

--���ף��
function FactionLuck(psid,sid)
	PI_PayPlayer(1,188,0,0,'���ף��',2,psid)
end

--���������
function FactionApplyJoin(sid,fid)
	local level = CI_GetPlayerData(1)
	if(level<30)then
		return false,4 --�ȼ�����30��
	end

	local myfid = CI_GetPlayerData(23)
	if myfid>0 then
		return false,1 --�Ѿ��а����
	end
	--�Ƿ��ǻ����˰��
	local autoID = is_auto_faction(fid)
	if(autoID)then
		join_auto_faction(autoID,sid)
		return true
	end
	local flv = CI_GetFactionInfo(fid,2)
	if(flv == nil)then
		return false,2 --��᲻����
	end
	
	local lv = CI_GetFactionInfo(fid,10)
	local totalnum = 30 + lv*6 + (flv-1)*2
	local num = CI_GetFactionInfo(fid,11)
	if(totalnum<=num)then
		return false,3 --��������Ѵ�����
	end
	
	--p_factionapply`(_fid int, _roleid int, _rolename varchar(22), 
	--_vip int, _sex int, _rolelevel int, _ntime int)
	local bzid,fbzid = CI_GetFactionLeaderInfo(fid,1)
	local sex = CI_GetPlayerData(11)
	local school = CI_GetPlayerData(2)
	local name = PI_GetPlayerName(sid)
	local vip = PI_GetPlayerVipType(sid)
	local level = PI_GetPlayerLevel(sid)
	local head = PI_GetPlayerHeadID(sid)
	local ntime = GetServerTime()
	--fid,sid,name,vip,sex,level,school,head,ntime
	GI_ApplyJoinFaction(fid,sid,name,vip,sex,level,school,head,ntime)
	if(bzid~=nil and IsPlayerOnline(bzid))then
		SendLuaMsg( bzid, { ids=Faction_newJoin}, 10 )
	end
	if(fbzid~=nil and IsPlayerOnline(fbzid))then
		SendLuaMsg( fbzid, { ids=Faction_newJoin}, 10 )
	end
	return true
end

--�������������� t 0 �ܾ� 1 ͬ��
function FactionAskJoin(sid,dsid,t,page)
	--look(sid..'....'..dsid..','..t..','..page)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --��᲻����
	end
	
	local title = CI_GetMemberInfo(1)
	if(title ~= FACTION_BZ and title ~= FACTION_FBZ)then return false,1 end --ֻ�а����͸�����������Ȩ��
	
	local fname = CI_GetFactionInfo(fid,1)
	if(t == 1)then
		local dfid = PI_GetPlayerFacID(dsid)
		if(dfid~=nil and dfid>0)then
			GI_DelApplyJoinFaction(dsid,0,0)
			if(fid == dfid)then
				return false,2 --�Ѿ��ڱ�����
			else
				return false,5 --�ڱ��˵İ��
			end
		end
		
		local flv = CI_GetFactionInfo(fid,2)
		if(flv == nil)then
			return false,0 --��᲻����
		end
		local lv = CI_GetFactionInfo(fid,10)
		local totalnum = 30 + lv*6 + (flv-1)*2
		local num = CI_GetFactionInfo(fid,11)
		if(totalnum<=num)then
			return false,3 --��������Ѵ�����
		end
		
		if(IsPlayerOnline(dsid))then
			local result = CI_JoinFaction(fid,dsid)
			if(result == 0)then --�ɹ�������
				set_join_factionDate(dsid)
				if(type(fname) == type(""))then
					SendLuaMsg(dsid, { ids=Faction_SuccessJoin,fn = fname,t=t, fid = fid}, 10 )
					sendFactionUnion(dsid)
				end
				GI_DelApplyJoinFaction(dsid,0,0)
				bsmz_online(dsid)
			end
		else
			GI_DelApplyJoinFaction(dsid,fid,1,page)
		end
	else
		if(IsPlayerOnline(dsid) and type(fname) == type(""))then
			local dfid = PI_GetPlayerFacID(dsid)
			if(dfid == nil or dfid == 0)then
				SendLuaMsg(dsid, { ids=Faction_SuccessJoin,fn = fname,t=t, fid = fid}, 10 )
			end
		end
		GI_DelApplyJoinFaction(dsid,0,0)
	end
	
	return true
end

--�������ߵ����ݿ�ص�
function DBCALLBACK_ApplyFaction(fid,page,sid,rs)
	if type(rs) == type({}) and table.empty(rs) == false then
		local v = rs[1]
		if(v~=nil and type(v) == type({}) and #v==7)then
			--roleId, roleName, vip, sex, roleLevel,school,head
			--CI_JoinFaction(factionid , playersid,level,school,head,sex,name)
			--look(v)
			local result = CI_JoinFaction(fid,sid,v[5],v[6],v[7],v[4],v[3],v[2])
			if(result == 0)then
				PI_SetPlayerFacID(sid,fid)
				SendLuaMsg( 0, { ids = Faction_ApplyResult, page = page, t = 1, sid = sid}, 9 )
			end
		end
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 13, data = 4, page = page, sid = sid}, 9 )
	end
end

--ȡ������������
function FactionAbortJoin(sid,fid)
	GI_DelApplyJoinFaction(sid,fid,0)
end

factionMoneyAdd = _factionMoneyAdd
upMainBuild = _upMainBuild

-------------------------------���פ����� by wk--------------------------------------
-------------------------------���פ����� by wk--------------------------------------
--���פ������--ȫ
function GetFactionTempregionData()
	if(dbMgr.faction.temp == nil)then
		dbMgr.faction.temp = {}
	end
	
	if(dbMgr.faction.temp.region == nil)then 
		dbMgr.faction.temp.region = {
			--[fid]=gid
		} 
	end
	return dbMgr.faction.temp.region 
end

--������פ�ص�ͼ--1Сʱһ��
function faction_clc_region( )
	local fadta=GetFactionTempregionData()
	for k,v in pairs(fadta) do
		if type(k)==type(0) and type(v)==type(0) then 
			local peoplenum=GetRegionPlayerCount(v)
			
			if peoplenum==0 or peoplenum==nil then 
				CI_DeleteDRegion(v,false)
				fadta[k]=nil
			end
		end
	end
end
--������פ��
function faction_in_region(itype)
	
	local _,_,_,gid = CI_GetCurPos()
	if gid then
		TipCenter(GetStringMsg(17))
		return
	end
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return  --��᲻����
	end
	local fadta=GetFactionTempregionData()
	if fadta[fid]==nil then
		local gid=PI_CreateRegion( 520, -1, 1)
		
		fadta[fid]=gid
	end 
	if itype==1 then
		PI_MovePlayer(0,zhudi_conf.enter[1][1],zhudi_conf.enter[1][2],fadta[fid]) 
	elseif itype==2 then
		PI_MovePlayer(0,zhudi_conf.enter[2][1],zhudi_conf.enter[2][2],fadta[fid]) 
	end
end
-------------------------------����ؾ���� by wk--------------------------------------
-------------------------------����ؾ���� by wk--------------------------------------
--����ؾ�����--ȫ
function GetFactionTemp_mijingData()

	if(dbMgr.faction.temp == nil)then
		dbMgr.faction.temp = {}
	end
	
	if(dbMgr.faction.temp.mijing == nil)then 
		dbMgr.faction.temp.mijing = {
			--[fid]=gid
		} 
	end
	return dbMgr.faction.temp.mijing 
end

--�������ؾ���ͼ--1Сʱһ��
function faction_clc_mijing( )
	local fadta=GetFactionTemp_mijingData()
	for k,v in pairs(fadta) do
		if type(k)==type(0) and type(v)==type(0) then 
			local peoplenum=GetRegionPlayerCount(v)
			if peoplenum==0 or peoplenum==nil then 
				CI_DeleteDRegion(v,false)
				fadta[k]=nil
			end
		end
	end
end
--ÿ�չ̶��ʱ��12��00 �C 24:00��

--�����ؾ�
function faction_in_mijing( )
	-- look('�����ؾ�')

	local opentime =mijing_conf.opentime
	local curdt = os.date( "*t", GetServerTime())
	local now=curdt.hour*100+curdt.min
	if  now< opentime[1] or now > opentime[2] then
		TipCenter(GetStringMsg(21))
		
		return
	end

	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		
		return  --��᲻����
	end
	local fadta=GetFactionTemp_mijingData()
	if fadta[fid]==nil then
		local gid=PI_CreateRegion( 521, -1, 1)
		
		fadta[fid]=gid

		mijing_conf.box.regionId=gid --ˢ����
		CreateObjectIndirect(mijing_conf.box)

		local wlevel_conf = mijing_conf.wlevel --ˢ��
		local world_lv = GetWorldLevel() or 1 
		local tpos = table_locate(wlevel_conf,world_lv,2)
		if tpos == nil or wlevel_conf[tpos] == nil then	
			look('fff monster config erro')
			return
		end
		local f_monster=mijing_conf.f_monster
		for k,v in pairs (f_monster) do 
			f_monster[k].regionId=gid
			f_monster[k].level = tpos
			f_monster[k].monAtt = wlevel_conf[tpos][k]	
			local a=CreateObjectIndirect(f_monster[k])
		end
	end 
	
	PI_MovePlayer(0,28,65,fadta[fid]) 
end


--�ؾ��ɼ�����ص�
call_monster_chick[3]=function ()	
	
	local playerid= CI_GetPlayerData(17)
	local fid= CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return  --��᲻����
	end
	local flv=CI_GetFactionInfo(fid,2)
	local award=mijing_conf.award[flv]
	local pakagenum = isFullNum()
	if pakagenum < #award then
		TipCenter(GetStringMsg(14,#award))
		return 0
	end		

	local timeinfo=GetTimesInfo(playerid,uv_TimesTypeTb.Faction_box)
	

	if not CheckTimes(playerid,uv_TimesTypeTb.Faction_box,1,-1,1) then
		TipCenter(GetStringMsg(20))
		return
	end
	
	CI_SetReadyEvent(nil,ProBarType.open,3,0,'faction_openbox')
end
--������ص�
function faction_openbox()
	
	local playerid= CI_GetPlayerData(17)
	local fid= CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		
		return  --��᲻����
	end
	local flv=CI_GetFactionInfo(fid,2)
	local award=mijing_conf.award[flv]
	 CheckTimes(playerid,uv_TimesTypeTb.Faction_box,1,-1)
	GiveGoodsBatch( award,"�ؾ�����")

	factionMoneyAdd(mijing_conf.award.fmoney,fid)--�Ӱ���ʽ�
	set_soul_group(playerid,mijing_conf.award.fss)--�����޳ɳ�
	RPC('f_box',flv) --�ڱ���ɹ�,�����
	return 1
end
--��� lsid �뿪�˵�ID
function leave_faction(sid,lsid)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then return false,0 end --�ް��
	
	local isFF = GI_Is_Active_Live('cf')
	if(isFF)then
		if(sid == lsid)then
			return false,10
		else
			return false,11
		end
	end
	
	isFF = GI_Is_Active_Live('ff')
	if(isFF)then 
		if(sid == lsid)then
			return false,12
		else
			return false,13
		end
	end
	
	if(faction_is_yunbiao(fid))then --����ʱ�����˰�
		if(sid == lsid)then
			return false,8
		else
			return false,9
		end
	end
	
	local pos = CI_GetMemberInfo(1)
	local result
	if(sid == lsid)then --���
		if(pos>=FACTION_XZ)then return false,1 end --��ְλ�������
		result = CI_LeaveFaction(fid,lsid,1)
		if(result == 0)then
			RemovePlayerTitle(sid,21)
		end
		set_join_factionDate(sid)
	else --����
		if(pos<FACTION_FBZ)then return false,2 end --Ȩ�޲���,��������������
		local hsid = CI_GetFactionLeaderInfo(fid,0)
		if(hsid == nil)then return false,3 end --δȡ��������Ϣ
		if(hsid == lsid)then return false,4 end --�����߰���
		
		local fdata = GetFactionData(fid)
		if(fdata == nil)then
			return false,5 --��ȡ�������ʧ��
		end
		
		look('�������==========')
		look(fdata)
		local flv = CI_GetFactionInfo(nil,2)
		if(flv~=nil and flv>=4)then
			fdata.tnum = nil
			fdata.tdata = nil
		else
			if(IsPlayerOnline(lsid))then
				local dt = os_date("*t", now)
				local tdate = dt.year*10000 + dt.month * 100 + dt.day
				if(fdata.tdata == nil or fdata.tdata~= tdate)then
					fdata.tnum = 0
					fdata.tdata = tdate	
				end

				if(flv == nil or flv<=2)then
					if(fdata.tnum ~= nil and fdata.tnum>=3)then
						return false,7 --ÿ��ֻ��T3���������
					end
				elseif(flv<=3)then
					if(fdata.tnum ~= nil and fdata.tnum>=5)then
						return false,6 --ÿ��ֻ��T5���������
					end
				end
			end
		end
		
		result = CI_LeaveFaction(fid,lsid,0)
		if(result == 0 and IsPlayerOnline(lsid))then
			set_join_factionDate(lsid)
			if(flv==nil or flv<3)then
				fdata.tnum = fdata.tnum == nil and 1 or fdata.tnum+1
			end
			RemovePlayerTitle(lsid,21)
		end
	end
end
--�����˰�������ж�
function online_leave_faction(sid)
	local fid = CI_GetPlayerData(23)
	--look('fid:' .. fid)
	if fid == nil or fid == 0 then
		RemovePlayerTitle(sid,21)
	end --�ް��
	--�������ʱ��
	set_join_factionDate(sid)
end

-- ��ṥ��ս����
function GetCityFightData()
	if dbMgr.city_fight.data == nil then
		dbMgr.city_fight.data =  {
		--city_fac==fid--�������id
	}	
	end
	return dbMgr.city_fight.data
end

-- -- ��¼�����
-- function King_activecall(state,subType)
	-- local cfData = GetCityFightData()
	-- if cfData == nil then return end
	-- local fac_id = cfData.city_fac
	-- if fac_id == nil then return end
	-- local king_sid = CI_GetFactionLeaderInfo(fid,1)
	-- if king_sid == nil or king_sid <= 0 then return end
	-- local king_name = CI_GetFactionLeaderInfo(fac_id,3)
	-- if type(king_name) ~= type('') then return end
	-- if subType == 1 then	-- �Ϸ���һ�ι���
		-- cfData.hf_king_fac = fac_id
		-- cfData.hf_king_sid = king_sid
		-- cfData.hf_king_name = king_name
	-- end
-- end

-- function King_activeinfo(sid)
	-- local cfData = GetCityFightData()
	-- if cfData == nil then return end
	-- local fac_id = cfData.hf_king_fac
	-- if fac_id == nil then return end
	-- local king_name = cfData.king_name
	-- local fac_name = CI_GetFactionInfo(fac_id,1)
	-- if type(fac_name) ~= type('') then return end
	-- RPC('king_info',0)
-- end

function getCityOwner()
	local cfData = GetCityFightData()
	if cfData == nil then return end
	return cfData.city_fac
end

function sendCityOwner(sid)
	local cfData = GetCityFightData()
	if cfData == nil then return end
	local have = false
	local fac_id = cfData.city_fac
	--look('sendCityOwner fac_id' .. tostring(fac_id))
	if fac_id and fac_id > 0 then
		local fac_name = CI_GetFactionInfo(fac_id,1)
		local name = CI_GetFactionLeaderInfo(fac_id,3)
		if type(fac_name) == type('') and type(name) == type('') then
			SendLuaMsg( sid, { ids = Faction_CityOwner, owner = fac_name, cz = name}, 10 )
		end
		
		-- ����³����ƺš�buff
		local bzsid = CI_GetFactionLeaderInfo(fac_id,1)
		if bzsid and bzsid == sid then
			SetPlayerTitle(bzsid,39)
			CI_AddBuff(304,0,1,true,2,bzsid)
			have = true
		end
	end
	if not have then
		RemovePlayerTitle(sid,39)
		CI_DelBuff(304,2,sid)
	end
end

-- ��½����
function CityOwnerLogin(sid)
	local cfData = GetCityFightData()
	if cfData == nil then return end
	local fac_id = cfData.city_fac
	if fac_id and fac_id > 0 then
		local bzsid = CI_GetFactionLeaderInfo(fac_id,1)		
		if bzsid and bzsid == sid then
			local name = CI_GetPlayerData(5,2,sid)
			BroadcastRPC('city_owner_login',name)
		end
	end
end

-- ���³�������
function UpdateCityImageID(fac_id,idx)
	local npcid = 400502	
	local controlID = npcid + 100000
	local index
	if idx then
		index = idx
	else
		local name,sex,sch = CI_GetFactionLeaderInfo(fac_id,3)
		if type(name) ~= type('') then return end
		 index = sch*10 + sex
	end
	if index == nil then return end
	local ImageID = 2159
	if index == 10 then
		ImageID = 2163
	elseif index == 11 then
		ImageID = 2162
	elseif index == 20 then
		ImageID = 2165
	elseif index == 21 then
		ImageID = 2164
	elseif index == 30 then
		ImageID = 2167
	elseif index == 31 then
		ImageID = 2166
	end	
	--look('UpdateCityImageID: ' .. tostring(ImageID))
	local ret = CI_UpdateNpcData(1,{imageId = ImageID,headID = ImageID},6,controlID,1)
end

function UpdateCityImageIDEx(sid)
	local owner_fid = getCityOwner()
	if owner_fid == nil then return end
	local bzsid = CI_GetFactionLeaderInfo(owner_fid,1)
	if bzsid and bzsid == sid then
		local cfData = GetCityFightData()
		if cfData == nil then return end
		cfData.sex = CI_GetPlayerData(11,2,sid)
		cfData.sch = CI_GetPlayerData(2,2,sid)
		local sex = cfData.sex
		local sch = cfData.sch
		if sex and sch then
			local index = sch*10 + sex
			UpdateCityImageID(owner_fid,index)
		end
	end
end

-- ������������
function CreateCityOwner()
	local npcid = 400502
	local controlID = npcid+100000
	local v = npclist[npcid]	
	if type(v) == type({}) then		
		v.NpcCreate.regionId = 1
		v.NpcCreate.imageId = 2159
		v.NpcCreate.headID = 2159
		v.NpcCreate.controlId = controlID
		local ret = RemoveObjectIndirect( 1, controlID )
		CreateObjectIndirect( v.NpcCreate )
		-- ���µ���
		local cfData = GetCityFightData()
		if cfData == nil then return end
		local fac_id = cfData.city_fac
		if fac_id == nil then return end
		--look('fac_id:' .. tostring(fac_id))
		local sex = cfData.sex
		local sch = cfData.sch
		if sex and sch then
			local index = sch*10 + sex
			UpdateCityImageID(fac_id,index)
		end
	end	
end

is_auto_faction_name = _is_auto_faction_name


--���ս����Ȩ��
function tq_guowang( sid,osid,itype )
	
	local fdata=GetCityFightData()
	local fid=fdata.city_fac
	if fid==nil then return end
	local Leader =CI_GetFactionLeaderInfo(fid,0)---����
	if sid~=Leader then return end
	local name
	if type(osid)==type(0) and osid>0 then 
		name=CI_GetPlayerData(5,2,osid)
	elseif type(osid)==type('') then
		name=osid
		osid=GetPlayer(name, 0)
		if type(osid)~=type(0) or osid<=0 then return end
	end
	
	if itype==1 then --����--301
		if(not CheckTimes(sid,uv_TimesTypeTb.city_JY,1,-1))then
			return 
		end
		CI_AddBuff(301,0,1,false,2,osid)
		BroadcastRPC('gwtq',itype,CI_GetPlayerData(5),name)
	elseif itype==2 then  --�乷--302
		if(not CheckTimes(sid,uv_TimesTypeTb.city_BG,1,-1))then
			return 
		end
		CI_AddBuff(302,0,1,false,2,osid)
		BroadcastRPC('gwtq',itype,CI_GetPlayerData(5),name)
	elseif itype==3 then --����--303
		if(not CheckTimes(sid,uv_TimesTypeTb.city_TP,1,-1))then
			return 
		end
		CI_AddBuff(303,0,1,false,2,osid)
		BroadcastRPC('gwtq',itype,CI_GetPlayerData(5),name)
	elseif itype==4 then --�ټ�
		local cx, cy, rid,isdy = CI_GetCurPos()
		if isdy then 
			if rid~=504 and rid~=523 then 
				TipCenter(GetStringMsg(455))
				return 
			end
		end
		if(not CheckTimes(sid,uv_TimesTypeTb.city_ZJ,1,-1))then
			return 
		end
		FactionRPC( fid, 'gwtq_zj',cx, cy, rid,isdy)
	else
		return
	end
end

--�����Ӧ�ټ�
function trance_p( sid )
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return  --��᲻����
	end

	local fdata=GetCityFightData()
	local cfid=fdata.city_fac
	if cfid==nil then return end
	if cfid~=fid then return end
	local Leadersid =CI_GetFactionLeaderInfo(fid,0)---����
	if Leadersid==nil then return end

	if not IsPlayerOnline(Leadersid) then 
		TipCenter(GetStringMsg(7))--������
		return
	end
	local cx, cy, rid,isdy = CI_GetCurPos(2,Leadersid)

	local res=limit_lv_zl( rid)--ս���ȼ�����
	if not res then return end
	if escort_not_trans(sid) then --����״̬���ܴ�
		look('escort_not_trans')
		return
	end
	if isdy then 
		if rid==504 then
			GI_Active_Enter(1,sid,rid,cx,cy,isdy)
		elseif rid==523 then 
			GI_Active_Enter(2,sid,rid,cx,cy,isdy)
		else
			return 
		end
	end
	PI_MovePlayer(rid, cx, cy, isdy)
end

--���ü������ʱ��
function set_join_factionDate(sid)
	--look('���ü������ʱ��')
	local fid = CI_GetPlayerData(23,2,sid)
	local fdata=GI_GetPlayerData( sid , 'faction' , 250 )
	if fdata == nil then return end
	--look(fid)

	if fid ~= nil and fid > 0 then
		if(fdata.jt == nil)then fdata.jt = GetServerTime() end
	else
		if(fdata.jt ~= nil)then fdata.jt = nil end
	end
	RPCEx(sid,'join_fac',fdata.jt)
	--look(fdata.jt)
end
--��ȡ�������ʱ��
function get_join_factiontime(sid)
	local fid = CI_GetPlayerData(23,2,sid)
	if fid ~= nil and fid > 0 then
		local fdata=GI_GetPlayerData( sid , 'faction' , 250 )
		if fdata == nil then return end
		if(fdata.jt == nil)then fdata.jt = GetServerTime() end
		return fdata.jt
	else
		return nil
	end
end