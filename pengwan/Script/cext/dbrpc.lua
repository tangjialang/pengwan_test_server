--[[
file:	db_interface.lua
desc:	all db rpc call.
author:	chal
update:	2013-07-02
]]--
--[[
dbtype�Ķ��壺
0 	- DB�ⵥ�̲߳��ɲ���RPC
2 	- DB�Ⲣ��RPC

101	- ��־����־��¼

1	- ���Ŀⵥ�̲߳��ɲ���RPC
201	- ���ĿⲢ��RPC

202 - ���������DB

�ص� |100--����  #100--2ά���� ?4--��4����
]]--
--DBRPC( __call,__callback, 1 ),1Ϊȡ���洢���̷��س���1024�ֽ�����
--------------------------------------------------------------------------
--include:
local DBRPC = DBRPC
local look = look
local GetServerID = GetServerID
local GetGroupID = GetGroupID
local GetServerTime = GetServerTime
local CI_GetPlayerData = CI_GetPlayerData
local CI_GetPlayerIcon = CI_GetPlayerIcon
local tostring = tostring
local IsSpanServer = IsSpanServer
local __G=_G
--------------------------------------------------------------------------
--module:

module(...)

local __call 	 = { dbtype = 101, sp = 'p_default', args = 0 }
local __callback = { callback = 'CALLBACK_default',args = 0 }

-- ÿ����ô洢���̴�����
local function _db_day_refresh()
	local now = GetServerTime()
	local serverid = GetGroupID()
	__call.dbtype,__call.sp ,__call.args = 2,'p_ReSetDayData',2
	__call[1] = now
	__call[2] = serverid
	DBRPC( __call )
end

-- ÿСʱ���ô洢���̴�����
-- ����ֻ�����������а�ˢ��
local function _db_hour_refresh()
	local now = GetServerTime()
	__call.dbtype,__call.sp ,__call.args = 2,'p_rankingupdatelist',1
	__call[1] = now - 60
	__callback.callback,__callback.args = 'CALLBACK_UpdateWorldLevel',1
	__callback[1] = '?2'
	DBRPC( __call, __callback )
end

-- ��ȡ���ݿ����а�(get)
-- 101 ս����  102  ��ɫ�ȼ�  103 ս�� 104 ����   201 �ҽ�  301 ����  401 �����  
-- 402 ս������  501  ɽׯ�ȼ� 601 ����������
local function _db_get_rank_list(itype,limit)
	__call.dbtype,__call.sp ,__call.args = 0,'p_rankinggettoplist',2
	__call[1] = itype
	__call[2] = limit
	__callback.callback,__callback.args = 'CALLBACK_getranklist',1
	__callback[1] = '#100'
	DBRPC( __call,__callback )
end

-- ���ô洢����ȡ����ȼ�
local function _db_get_wlevel()
	__call.dbtype,__call.sp ,__call.args = 2,'p_rankinggetworldlevel',0
	__callback.callback,__callback.args = 'CALLBACK_UpdateWorldLevel',1
	__callback[1] = '?1'
	DBRPC( __call,__callback )
end

-- ��½ȡս��������
local function _get_fight_rank(sid,bonline)
	local login = bonline or 0
	__call.dbtype,__call.sp ,__call.args = 2,'p_PlayerInitDataPerDay',3
	__call[1] = sid
	__call[2] = login
	__call[3] = CI_GetPlayerData(1,2,sid)
	__callback.callback,__callback.args = 'CALLBACK_GetRoleRank',3
	__callback[1] = sid
	__callback[2] = bonline
	__callback[3] = '?4'
	DBRPC( __call,__callback )
end

--�����ݿ�����һ���µİ���ID checkID -1 ���������˰��(autoID �����˰����������)
local function _get_faction_id(name,checkID,autoID,sid)
	__call.dbtype,__call.sp ,__call.args = 0,'p_NewBuildingID',1
	__call[1] = name
	--look('**************'..name)
	if(checkID == -1)then
		__callback.callback,__callback.args = 'DBCALLBACK_CreateAutoFaction',3
		__callback[1] = '?2'
		__callback[2] = name
		__callback[3] = autoID
	else
		__callback.callback,__callback.args = 'DBCALLBACK_CreateFaction',3
		__callback[1] = '?2'
		__callback[2] = name
		__callback[3] = checkID
	end
	DBRPC( __call,__callback)
end

--�����ݿ��������һ�����
--_fid int, _roleid int, _rolename varchar(22), _vip int, _sex int, _rolelevel int, _school int, _head int, _ntime int
local function _apply_join_faction(fid,sid,name,vip,sex,level,school,head,ntime)
	--look(fid..','..sid..','..name..','..vip..','..sex..','..level..','..school..','..head..','..ntime)
	__call.dbtype,__call.sp ,__call.args = 0,'p_factionapply',9
	__call[1] = fid
	__call[2] = sid
	__call[3] = name
	__call[4] = vip
	__call[5] = sex
	__call[6] = level
	__call[7] = school
	__call[8] = head
	__call[9] = ntime
	DBRPC( __call)
end

--sid=0ʱ��ɾ������fid�������
--fidΪ0ʱɾ������_roleid�������¼
--get=1 ��ȡ��ɫ��Ϣ 0 ȡ��������� _roleid>0 and _fid>0ʱ ���ȡ��������� 
local function _delapply_join_faction(sid,fid,get,page)
	__call.dbtype,__call.sp ,__call.args = 0,'p_factionapplydel',3
	__call[1] = sid
	__call[2] = fid
	__call[3] = get
	--look(__callback)
	if(get == 1)then
		--roleId, roleName, vip, sex, roleLevel,school,head
		__callback.callback,__callback.args = 'DBCALLBACK_ApplyFaction',4
		__callback[1] = fid
		__callback[2] = page
		__callback[3] = sid
		__callback[4] = "#100"
		DBRPC( __call,__callback)
	else
		DBRPC( __call)
	end
	
end

--��ȡ��������¼ʱ�䣨���ڰ���������
local function _get_fheader_lastlogin(hsid,sid,fid)
	__call.dbtype,__call.sp ,__call.args = 2,'N_GetLastLoginSeconds',1
	__call[1] = hsid
	__callback.callback,__callback.args = 'CALLBACK_ImpeachFHeader',4
	__callback[1] = '?2'
	__callback[2] = sid
	__callback[3] = hsid
	__callback[4] = fid
	DBRPC( __call,__callback )
end

-- ȡ�ʼ�����
local function _give_mail_item(sid,MailID)	
	if sid == nil or MailID == nil then
		return
	end
	__call.dbtype,__call.sp ,__call.args = 0,'p_EmailGetItem',2
	__call[1] = sid
	__call[2] = MailID
	__callback.callback,__callback.args = 'CALLBACK_GetItemFromMail',8
	__callback[1] = sid
	__callback[2] = MailID
	__callback[3] = "?3"
	__callback[4] = "?4"
	__callback[5] = "?5"
	__callback[6] = "?6"
	__callback[7] = "?7"
	__callback[8] = "?8"
	DBRPC( __call,__callback )
end

--ȡ�ʼ������ع�
local function _rollback_give_mail_item(sid,MailID)
	__call.dbtype,__call.sp ,__call.args = 0,'p_EmailGetItemRollBackToDB',2
	__call[1] = sid
	__call[2] = MailID
	DBRPC( __call )
end

-- ��԰��־��¼
local function _garden_opt_record(sid,opName,opt,seedID,itype)
	__call.dbtype,__call.sp ,__call.args = 101,'N_HouseOprtLog',6
	__call[1] = sid
	__call[2] = opName
	__call[3] = opt
	__call[4] = seedID
	__call[5] = itype	
	__call[6] = GetGroupID()
	DBRPC( __call )
end

-- ��λ��ս��
local function _manor_rank_report(gSID,mrkSID,gName,sName,gRank,sRank,mrkSID_r,mrkRES)
	__call.dbtype,__call.sp ,__call.args = 2,'p_qualifying',8
	__call[1] = gSID
	__call[2] = mrkSID
	__call[3] = gName
	__call[4] = sName
	__call[5] = gRank	
	__call[6] = sRank
	__call[7] = mrkSID_r
	__call[8] = mrkRES
	DBRPC( __call )	
end

local function _update_role_info(pName,pSchool,pLevel,pExps,pFight,zgPoint,cjPoint,herosID,herosFight,MountID,MountFight,DefScore,FitStar,manorLv,manorExp,sid,swPoint,vipType,sex,headID,qhlv,bsnum,manorRank,qblv,qbfight,fid,FitFight,winglv,wingfight,equip,detail,attr,zml,spouse,zgpos,exdata,MountLV)
	if __G.IsSpanServer() then return end
	__call.dbtype,__call.sp ,__call.args = 2,'p_rankingupdateroleinfo',37
	__call[1] = pName
	__call[2] = pSchool
	__call[3] = pLevel
	__call[4] = pExps
	__call[5] = pFight	
	__call[6] = zgPoint
	__call[7] = cjPoint
	__call[8] = herosID
	__call[9] = herosFight
	__call[10] = MountID
	__call[11] = MountFight
	__call[12] = DefScore
	__call[13] = FitStar
	__call[14] = manorLv
	__call[15] = manorExp
	__call[16] = sid
	__call[17] = swPoint
	__call[18] = vipType
	__call[19] = sex
	__call[20] = headID
	__call[21] = qhlv
	__call[22] = bsnum
	__call[23] = manorRank
	__call[24] = qblv
	__call[25] = qbfight
	__call[26] = fid
	__call[27] = FitFight
	__call[28] = winglv
	__call[29] = wingfight
	__call[30] = equip
	__call[31] = detail
	__call[32] = attr
	__call[33] = zml
	__call[34] = spouse
	__call[35] = zgpos
	__call[36] = exdata	
	__call[37] = MountLV
	DBRPC( __call )		
end
--point��¼
local function _db_point(serverID,account,rolename,sid,rolelevel,val,info ,pType,aData)
	__call.dbtype,__call.sp ,__call.args = 101,'N_PointBuyLog',9
	__call[1] = serverID
	__call[2] = account
	__call[3] = rolename
	__call[4] = sid
	__call[5] = rolelevel	
	__call[6] = val
	__call[7] = info or " "
	__call[8] = pType
	__call[9] = aData
	DBRPC( __call )
end
-- ���������а�(insert)
local function _lt_insert_list(sid,score,winning)
	__call.dbtype,__call.sp ,__call.args = 2,'p_arenapointsupdate',7
	__call[1] = sid
	__call[2] = CI_GetPlayerData(5,2,sid)
	__call[3] = score
	__call[4] = CI_GetPlayerData(1,2,sid)
	__call[5] = winning
	__call[6] = CI_GetPlayerData(2,2,sid)
	__call[7] = CI_GetPlayerIcon(0,0,2,sid)
	DBRPC( __call )
end

-- ����
local function _db_change_name(id,optype,newname,sid)
	__call.dbtype,__call.sp ,__call.args = 0,'CheckOrUpdateRoleName',3
	__call[1] = optype
	__call[2] = newname
	__call[3] = id
	__callback.callback,__callback.args = 'CALLBACK_changename',5
	__callback[1] = id
	__callback[2] = optype
	__callback[3] = newname
	__callback[4] = sid
	__callback[5] = '?4'
	DBRPC( __call,__callback )
end

--�����ع�
local function _db_change_name_rollback(id,optype,newname)
	__call.dbtype,__call.sp ,__call.args = 0,'CheckOrUpdateRoleName_RollBack',3
	__call[1] = optype
	__call[2] = newname
	__call[3] = id
	DBRPC( __call )
end

-- ��Ӫ��б�
local function _db_active_list()
	--look('��Ӫ��б�111',2)
	local serverid = GetGroupID()
	local now = GetServerTime()
	__call.dbtype,__call.sp ,__call.args = 201,'N_InitActiveConf',3
	__call[1] = serverid
	__call[2] = 0
	__call[3] = GetServerTime()
	-- __call[3] = now
	__callback.callback,__callback.args = 'CALLBACK_InitActiveList',5
	__callback[1] = "|100"
	__callback[2] = "?4"
	__callback[3] = "?5"
	__callback[4] = "?6"
	__callback[5] = "?7"
	DBRPC( __call,__callback, 1 )
end

-- ��Ӫ���ϸ��Ϣ
local function _db_active_detail(mainid,version)
	local now = GetServerTime()
	__call.dbtype,__call.sp ,__call.args = 201,'N_InitActiveConf',3
	__call[1] = mainid
	__call[2] = 1
	__call[3] = now
	__callback.callback,__callback.args = 'CALLBACK_InitActiveConf',2
	__callback[1] = version
	__callback[2] = "#100"
	DBRPC( __call,__callback, 1 )
end

-- ��ȡ����
local function _db_get_public()
	local serverid = GetGroupID()
	__call.dbtype,__call.sp ,__call.args = 201,'N_GetAnnouncement',1
	__call[1] = serverid
	__callback.callback,__callback.args = 'CALLBACK_GetPublic',1
	__callback[1] = '#100'
	DBRPC( __call,__callback, 1 )
end
--�����û�콱��־

local function _db_active_score(sid,_time,sc_table)
	local serverid = GetGroupID()
	__call.dbtype,__call.sp ,__call.args = 101,'N_gameactivelog',14
	__call[1] = serverid
	__call[2] = sid
	__call[3] =  CI_GetPlayerData(5,2,sid)
	__call[4] = _time
	__call[5] = sc_table[1] or 0
	__call[6] = sc_table[2] or 0
	__call[7] = sc_table[3] or 0
	__call[8] = sc_table[4] or 0
	__call[9] = sc_table[5] or 0
	__call[10] = sc_table[6] or 0
	__call[11] = sc_table[7] or 0
	__call[12] = sc_table[8] or 0
	__call[13] = sc_table[9] or 0
	__call[14] = sc_table[10] or 0

	DBRPC( __call )
end

--��콱��־
local function _db_active_getaward(sid,_time,sc,_type)
	local serverid = GetGroupID()
	__call.dbtype,__call.sp ,__call.args = 101,'N_gameactivegetawardlog',6
	__call[1] = serverid
	__call[2] = sid
	__call[3] =  CI_GetPlayerData(5,2,sid)
	__call[4] = _time
	__call[5] = sc 
	__call[6] = _type

	DBRPC( __call )
end
--������������־
local function _db_times_log(sid,_type)
	local serverid = GetGroupID()
	__call.dbtype,__call.sp ,__call.args = 101,'N_gamecopy',6
	__call[1] = serverid
	__call[2] = sid
	__call[3] = CI_GetPlayerData(5,2,sid)
	__call[4] = CI_GetPlayerData(1,2,sid)
	__call[5] = GetServerTime()
	__call[6] = _type

	DBRPC( __call )
end
--������־
local function _db_lvup_log(sid , roleLevel )
	local serverid = GetGroupID()
	local pSchool 	= CI_GetPlayerData(2)		-- ���ְҵ
	local pFight 	= CI_GetPlayerData(62)		-- ���ս����
	local account = CI_GetPlayerData(15)
	local sex = CI_GetPlayerData(11)
	__call.dbtype,__call.sp ,__call.args = 2,'p_LogPlayerUpgrade',9
	__call[1] = serverid
	__call[2] = sid
	__call[3] = CI_GetPlayerData(5,2,sid)
	__call[4] = roleLevel
	__call[5] = GetServerTime()
	__call[6] = account
	__call[7] = pFight
	__call[8] = sex
	__call[9] = pSchool
	DBRPC( __call )
end
--���
local function _db_bury_id(sid,id ,lv)
	local serverid = GetGroupID()
	 __call.dbtype,__call.sp ,__call.args = 101,'N_usersetplog',6
	__call[1] = CI_GetPlayerData(15)
	__call[2] = serverid
	__call[3] = sid
	__call[4] = GetServerTime()-60--����ʱ��֤�洢ͳ��Ϊ����ʱ������
	__call[5] = id
	__call[6] = lv
	DBRPC( __call )
end
--ǰ̨��shareд�洢
local function _db_openshare()
	local serverid = GetGroupID()
	local account = CI_GetPlayerData(15)
	local lv = CI_GetPlayerData(1)
	 __call.dbtype,__call.sp ,__call.args = 101,'N_openshare',3
	__call[1] = serverid
	__call[2] = account
	__call[3] = lv
	DBRPC( __call )
end

-- �������콱
local function _db_drx_award(sid,mainid,subid,maxnum)
	local serverid = GetGroupID()
	local account = CI_GetPlayerData(15)
	local now = GetServerTime()
	 __call.dbtype,__call.sp ,__call.args = 0,'N_SvrActivityParticipate',7
	__call[1] = serverid
	__call[2] = account
	__call[3] = sid
	__call[4] = mainid
	__call[5] = subid
	__call[6] = maxnum
	__call[7] = now
	__callback.callback,__callback.args = 'CALLBACK_DrxGiveAwards',5
	__callback[1] = sid
	__callback[2] = mainid
	__callback[3] = subid
	__callback[4] = '?8'
	__callback[5] = '?9'
	DBRPC( __call, __callback )
end

-- �������콱
local function _db_drx2_award(sid,mainid,subid,maxnum)
	local serverid = GetGroupID()
	local account = CI_GetPlayerData(15)
	local now = GetServerTime()
	 __call.dbtype,__call.sp ,__call.args = 0,'N_SvrActivityParticipate',7
	__call[1] = serverid
	__call[2] = account
	__call[3] = sid
	__call[4] = mainid
	__call[5] = subid
	__call[6] = maxnum
	__call[7] = now
	__callback.callback,__callback.args = 'CALLBACK_Drx2GiveAwards',5
	__callback[1] = sid
	__callback[2] = mainid
	__callback[3] = subid
	__callback[4] = '?8'
	__callback[5] = '?9'
	DBRPC( __call, __callback )
end

local function _db_drx_rollback(aid)
	__call.dbtype,__call.sp ,__call.args = 0,'N_SvrActivityPartRollback',1
	__call[1] = aid
	DBRPC( __call )
end

local function _db_drx2_rollback(aid)
	__call.dbtype,__call.sp ,__call.args = 0,'N_SvrActivityPartRollback',1
	__call[1] = aid
	DBRPC( __call )
end

--��Ӫ���Ҫ��Ϣ��¼
local function _db_operationsactivity(sid,aname,info)
	local serverid = GetGroupID()
	local now = GetServerTime()
	local name =CI_GetPlayerData(5,2,sid)
	__call.dbtype,__call.sp ,__call.args = 101,'N_log_operationsactivity',5
	__call[1] = name
	__call[2] = serverid
	__call[3] = aname
	__call[4] = info
	__call[5] = now
	DBRPC( __call )
end

--��Ӫ���Ҫ��Ϣ��¼
local function _db_show_girl(sid)
	local serverid = GetGroupID()
	__call.dbtype,__call.sp ,__call.args = 201,'p_GetShowGirlSetting',1
	__call[1] = serverid
	__callback.callback,__callback.args = 'CALLBACK_ShowGirl',3
	__callback[1] = sid
	__callback[2] = '?2'
	__callback[3] = '?3'
	DBRPC( __call, __callback )
end

-- ��½ȡս��������
local function _get_login_info(sid)
	if __G.IsSpanServer() then return end
	__call.dbtype,__call.sp ,__call.args = 2,'p_LoginInitData',3
	__call[1] = CI_GetPlayerData(15,2,sid)
	__call[2] = sid
	__call[3] = GetGroupID()
	__callback.callback,__callback.args = 'CALLBACK_GetLoginInfo',2
	__callback[1] = sid
	__callback[2] = '#100'
	DBRPC( __call,__callback )
end

--���ս
local function _db_get_city_info(fac_id,bzsid,fbzsid,bzfrsid)
	__call.dbtype,__call.sp ,__call.args = 2,'p_factiongetfightinglist',4
	__call[1] = fac_id
	__call[2] = bzsid or 0
	__call[3] = fbzsid or 0
	__call[4] = bzfrsid or 0
	__callback.callback,__callback.args = 'CALLBACK_GetCityInfo',5
	__callback[1] = fac_id
	__callback[2] = bzsid
	__callback[3] = fbzsid
	__callback[4] = bzfrsid
	__callback[5] = '#100'
	DBRPC( __call,__callback )
end

-- ���Ѻ���¼
local function _db_faction_yajin_record(sid,point,fac_id)
	__call.dbtype,__call.sp ,__call.args = 2,'N_Faction_YaBiao_Record',3
	__call[1] = sid
	__call[2] = point
	__call[3] = fac_id		
	DBRPC( __call )
end

-- ���Ѻ������
local function _db_faction_yajin_clear(fac_id,back)
	__call.dbtype,__call.sp ,__call.args = 2,'N_Faction_YaBiao_Clear',2
	__call[1] = 0
	__call[2] = fac_id	
	__callback.callback,__callback.args = 'CALLBACK_ClearFacYaJin',3
	__callback[1] = fac_id
	__callback[2] = back
	__callback[3] = '?3'
	DBRPC( __call,__callback )
end

-- �Ϸ�����Ѻ��(�ڶ��������������0)
local function _db_faction_yajin_back(sid)
	__call.dbtype,__call.sp ,__call.args = 2,'N_Faction_YaBiao_BackDeposit',2
	__call[1] = sid
	__call[2] = 1000		
	__callback.callback,__callback.args = 'CALLBACK_BackDeposit',2
	__callback[1] = sid
	__callback[2] = '#100'
	DBRPC( __call,__callback )
end

-- ����ԤԼ��¼(factionid = 0)
local function _db_marry_cost_record(sid,point)
	__call.dbtype,__call.sp ,__call.args = 2,'N_Faction_YaBiao_Record',3
	__call[1] = sid
	__call[2] = point
	__call[3] = 0		
	DBRPC( __call )
end

-- �������ԤԼ��¼
local function _db_marry_cost_clear(sid)
	__call.dbtype,__call.sp ,__call.args = 2,'N_Faction_YaBiao_Clear',2
	__call[1] = sid
	__call[2] = 0	
	__callback.callback,__callback.args = 'CALLBACK_ClearMarrCost',3
	__callback[1] = sid
	__callback[2] = '?3'
	DBRPC( __call,__callback )
end

-- �Ϸ���������ԤԼ����(�ڶ�����������Ϊ0)
local function _db_marry_cost_back(sid)
	__call.dbtype,__call.sp ,__call.args = 2,'N_Faction_YaBiao_BackDeposit',2
	__call[1] = sid
	__call[2] = 0	
	__callback.callback,__callback.args = 'CALLBACK_BackMarrCost',2
	__callback[1] = sid
	__callback[2] = '#100'
	DBRPC( __call,__callback )
end

--����ʹ�ô����洢--ʥ�����ʹ��
local function _db_item_in(sid,itype,num)
	__call.dbtype,__call.sp ,__call.args = 0,'N_ActivityPartTimesRecord',3
	__call[1] = sid
	__call[2] = itype
	__call[3] = num
	DBRPC( __call )
end
--ȡ����ʹ�ô���--ʥ�����ʹ��
local function _db_item_out(sid,itype)
	if __G.IsSpanServer() then return end
	__call.dbtype,__call.sp ,__call.args = 0,'N_ActivityPartTimesGet',2
	__call[1] = sid
	__call[2] = itype
	__callback.callback,__callback.args = 'CALLBACK_item_out',3
	__callback[1] = sid
	__callback[2] = itype
	__callback[3] = '?3'
	DBRPC( __call,__callback  )
end
--д�����а�--���ص�
local function _db_RANK_in(mainID,pname,rank)
	local serverid = GetGroupID()
	__call.dbtype,__call.sp ,__call.args = 2,'N_ActivityUpdateRanking',7
	__call[1] = serverid
	__call[2] = mainID
	__call[3] = pname
	__call[4] = rank
	__call[5] = 0
	__call[6] = GetServerTime()
	__call[7] = 0
	DBRPC( __call )
end
--Ѱ�����а��콱д��
local function _db_RANK_getaward(playerid,mainID,subID,stype)
	local serverid = GetGroupID()
	local account = CI_GetPlayerData(15)
	__call.dbtype,__call.sp ,__call.args = 0,'N_ActivityParticipate',12
	__call[1]=serverid
	__call[2]=account
	__call[3]=playerid
	__call[4]=mainID
	__call[5]=subID
	__call[6]=stype
	__call[7]=0
	__call[8]= 0
	__call[9]=1000
	__call[10]=0
	__call[11]=0
	__call[12]=GetServerTime()
	DBRPC( __call )
end
--�������ֵ�����־
local function _db_sowar_xy(qblv,qbxy)
	local lv = CI_GetPlayerData(1)
	local name = CI_GetPlayerData(3)
	__call.dbtype,__call.sp ,__call.args = 101,'N_cavalrylevelup',4
	__call[1] = name
	__call[2] = qblv
	__call[3] = lv
	__call[4] = qbxy
	DBRPC( __call )
end

-- ���ݻ���ͻ�ȡ��������б�
-- uid: [1] ���BOSS� con : 50\60\70 
local function _db_get_span_server(uid,con)
	__call.dbtype,__call.sp ,__call.args = 201,'p_SpanServerGet',3
	__call[1] = uid
	__call[2] = con
	__call[3] = GetGroupID()
	__callback.callback,__callback.args = 'CALLBACK_SpanServerGets',3
	__callback[1] = uid
	__callback[2] = con
	__callback[3] = '#100'
	DBRPC( __call,__callback, 1 )
end

-- ��ȡ���������;
local function _db_get_span_sinfo(serverid)
	__call.dbtype,__call.sp ,__call.args = 201,'p_SpanServerGetEx',1
	__call[1] = serverid
	__callback.callback,__callback.args = 'GI_set_span_info',1
	__callback[1] = '#100'
	DBRPC( __call,__callback )
end

local function _db_log_shenqi_fight(serverid, account, sid, rolename, level, fight, currtime)
	__call.dbtype, __call.sp, __call.args = 101, 'N_log_rolefighting', 7
	__call[1] = serverid
	__call[2] = account
	__call[3] = sid
	__call[4] = rolename
	__call[5] = level
	__call[6] = fight
	__call[7] = currtime
	DBRPC( __call)
end

local function _db_kfph_read(l_type,page,pagesize)
	__call.dbtype, __call.sp, __call.args = 202, 'p_Ranking_GetList',4
	__call[1] = l_type	--�������� (1:ս�� 2:���� 3:������ʤ)
	__call[2] = page	--ҳ
	__call[3] = pagesize	--ҳ��С
	__call[4] = GetGroupID()	
	__callback.callback,__callback.args = 'CALL_BACK_KfphRead',5	
	__callback[1] = '#100'	
	__callback[2] = l_type
	__callback[3] = page
	__callback[4] = pagesize
	__callback[5] = '?5'
	DBRPC( __call,__callback)
end

local function _db_kfph_write(sid,zl_s,ww_s,jjls_s,vip_level)
	__call.dbtype, __call.sp, __call.args = 202, 'p_rolefighting_Update',9
	__call[1] = GetGroupID()	--server id
	__call[2] = sid	--sid
	__call[3] = CI_GetPlayerData(3)	--player name
	__call[4] = CI_GetPlayerData(2) --player school
	__call[5] = CI_GetPlayerData(1) --player level
	
	__call[6] = zl_s or 0	--ս��
	__call[7] = ww_s or 0	--����
	__call[8] = jjls_s or 0	--������ʤ
	__call[9] = vip_level or 0
	DBRPC( __call)
end

local function _db_kfph_update()
	__call.dbtype, __call.sp, __call.args = 202, 'p_Ranking_UpdateList',0
	DBRPC( __call)
end

local function _db_kfph_ranking_list(l_type)
	__call.dbtype, __call.sp, __call.args = 202, 'p_Ranking_GetServerList',2
	__call[1] = l_type	
	__call[2] = GetGroupID()

	__callback.callback,__callback.args = 'CALL_BACK_RankingList',2
	__callback[1] = '#100'	
	__callback[2] = l_type

	DBRPC( __call,__callback,1)
end

--������--ȡ���֤��Ϣ,����ʱ��
local function _db_tired_getinfo(sid)
	-- look(22,1)
	local serverid = GetGroupID()
	local account = CI_GetPlayerData(15)
	__call.dbtype,__call.sp ,__call.args = 201,'p_fcmgettime',2
	__call[1] = account
	__call[2] = serverid
	__callback.callback,__callback.args = 'tired_getcallback',3
	__callback[1] = sid
	__callback[2] = '?3'
	__callback[3] = '?4'
	DBRPC( __call,__callback  )
end

--������--��д���֤��Ϣ
local function _db_tired_writeid(sid,id,name)
	local serverid = GetGroupID()
	local account = CI_GetPlayerData(15)
	__call.dbtype,__call.sp ,__call.args = 201,'p_fcmupdateinfo',4
	__call[1] = account
	__call[2] = serverid
	__call[3] = id
	__call[4] = name
	__callback.callback,__callback.args = 'tired_writecallback',3
	__callback[1] = sid
	__callback[2] = '?5'
	__callback[3] = '?6'
	DBRPC( __call,__callback  )
end
--������--����
local function _db_tired_logout()
	local serverid = GetGroupID()
	local account = CI_GetPlayerData(15)
	__call.dbtype, __call.sp, __call.args = 201, 'p_fcmlogout',2
	__call[1] = account
	__call[2] = serverid
	DBRPC( __call)
end

local function _db_cc_save(	hroleid,hrolename,hfighting,
							wroleid,wrolename,wfighting,score)
							
	
	__call.dbtype, __call.sp, __call.args = 202, 'p_couples_Update',8
	__call[1] = GetGroupID()	--server id
	__call[2] = hroleid
	__call[3] = hrolename
	__call[4] = hfighting
	__call[5] = wroleid
	__call[6] = wrolename
	__call[7] = wfighting
	__call[8] = score
	DBRPC( __call)

end

local function _db_cc_gen_ranks()

	__call.dbtype, __call.sp, __call.args = 202, 'p_couples_updateranking',0
	DBRPC( __call)
end

local function _db_cc_get_ranks_list(sid,page,pagesize)
	__call.dbtype, __call.sp, __call.args = 202,'p_couples_Ranking_GetList',3
	__call[1] = page
	__call[2] = pagesize
	__call[3] = GetGroupID()

	__callback.callback,__callback.args = 'cc_on_read_ranks_list',5
	__callback[1] = '#100'	
	__callback[2] = '?4'
	__callback[3] = sid
	__callback[4] = page		
	__callback[5] = pagesize
	DBRPC( __call,__callback)
end

local function _db_cc_get_local_ranking()
	--look('_db_cc_get_local_ranking',2)
	__call.dbtype, __call.sp, __call.args = 202, 'p_couples_Ranking_GetServerList',1
	__call[1] = GetGroupID() 

	__callback.callback,__callback.args = 'cc_on_read_local_ranking',2
	__callback[1] = '#200'	
	__callback[2] = '?2'
	DBRPC( __call,__callback,1)
end

local function _db_cc_divorce(sid)
	__call.dbtype, __call.sp, __call.args = 202, 'p_couples_divorce',4
	__call[1] = sid
	__call[2] = CI_GetPlayerData(3,2,sid)
	__call[3] = GetGroupID()
	__call[4] =	CI_GetPlayerData(11,2,sid)
	DBRPC( __call )
end


---ȡʱ����ڵ��ʳ�ֵ��¼,�id,��ʼʱ��,����ʱ��--���ʳ�ֵ������С���
--- flag 1 ��ʾ �践����Ϣ��ǰ��
function _db_cj_get_recharge_record(serverid, sid, account, minpay, btime, etime, flag)	
	__call.dbtype, __call.sp, __call.args =  0, 'N_ActivityGetPayRecords', 5
	__call[1] = account
	__call[2] = serverid
	__call[3] = minpay
	__call[4] = btime
	__call[5] = etime
	
	__callback.callback,__callback.args = 'CALLBACK_GetPayRecords', 3
	__callback[1] = sid
	__callback[2] = flag
	__callback[3] = '#1000'

	DBRPC( __call,__callback, 1)
end

--db_cj_get_active_info
--serverid, sid, account, mainId, subId, stype, beg_time, end_time, awd_time, 
--limitnum, beg_val, end_val, con_val
local function _db_cj_award(msg, serverid, sid, account, mainId, subId, stype, beg_time, end_time, awd_time, limitnum, beg_val, end_val, con_val)
	__call.dbtype, __call.sp, __call.args =  0,'N_ActivityParticipate', 14
	__call[1] = serverid
	__call[2] = account
	__call[3] = sid
	__call[4] = mainId
	__call[5] = subId
	__call[6] = stype or 0
	__call[7] = beg_time or 0
	__call[8] =  end_time or 0
	__call[9] =  awd_time or 0
	__call[10] = limitnum or 0
	__call[11] =  beg_val or 0
	__call[12] = end_val or 0
	__call[13] = con_val
	__call[14] = GetServerTime()

	__callback.callback,__callback.args = 'CALLBACK_CheckAwardInfo', 8
	__callback[1] = msg['ids'][1]
	__callback[2] = msg['ids'][2] + 1
	__callback[3] = msg['index']
	__callback[4] = sid
	__callback[5] = mainId		
	__callback[6] = subId
	__callback[7] = '?15'
	__callback[8] = '?16'	
	
	DBRPC( __call,__callback)
end

--��ȡ�������
local function _db_cj_get_award_num(msg, account, sid, mainId, beg_time, end_time)
	__call.dbtype, __call.sp, __call.args =  0,'N_ActivityParticipateNums', 5
	__call[1] = account
	__call[2] = sid
	__call[3] = mainId
	__call[4] = beg_time
	__call[5] = end_time


	__callback.callback,__callback.args = 'CALLBACK_GetAwardNum', 7
	__callback[1] = msg['ids'][1]
	__callback[2] = msg['ids'][2] + 1
	__callback[3] = msg['index']
	__callback[4] = sid
	__callback[5] = mainId		
	__callback[6] = subId
	__callback[7] = '#100'

	DBRPC( __call,__callback)
end
--------------------------------------------------------------------------
--interface:
db_day_refresh = _db_day_refresh	-- GI_RefreshScoreList
db_hour_refresh = _db_hour_refresh
get_fight_rank = _get_fight_rank
get_faction_id = _get_faction_id	-- GI_GetFactionID
get_fheader_lastlogin = _get_fheader_lastlogin -- GI_GetFHeaderLastLogin
give_mail_item = _give_mail_item
rollback_give_mail_item = _rollback_give_mail_item
garden_opt_record = _garden_opt_record
manor_rank_report = _manor_rank_report
update_role_info = _update_role_info
db_point=_db_point
lt_insert_list = _lt_insert_list
db_get_wlevel = _db_get_wlevel
db_change_name = _db_change_name
db_change_name_rollback = _db_change_name_rollback
db_active_list = _db_active_list
db_active_detail = _db_active_detail
db_get_public = _db_get_public
db_active_score=_db_active_score
db_active_getaward=_db_active_getaward
db_times_log = _db_times_log
db_lvup_log=_db_lvup_log
db_bury_id=_db_bury_id
apply_join_faction=_apply_join_faction
delapply_join_faction=_delapply_join_faction
db_openshare=_db_openshare
db_drx_award = _db_drx_award
db_drx_rollback = _db_drx_rollback
db_drx2_award = _db_drx2_award
db_drx2_rollback = _db_drx2_rollback
db_operationsactivity=_db_operationsactivity
db_show_girl = _db_show_girl
get_login_info = _get_login_info
db_get_city_info = _db_get_city_info
db_faction_yajin_record = _db_faction_yajin_record
db_faction_yajin_clear = _db_faction_yajin_clear
db_faction_yajin_back = _db_faction_yajin_back
db_item_in=_db_item_in
db_item_out=_db_item_out
db_RANK_in=_db_RANK_in
db_sowar_xy=_db_sowar_xy
db_marry_cost_record = _db_marry_cost_record
db_marry_cost_clear = _db_marry_cost_clear
db_marry_cost_back = _db_marry_cost_back
db_get_span_server = _db_get_span_server
db_get_span_sinfo = _db_get_span_sinfo
db_log_shenqi_fight = _db_log_shenqi_fight

db_kfph_read = _db_kfph_read
db_kfph_write = _db_kfph_write
db_kfph_update = _db_kfph_update
db_kfph_ranking_list = _db_kfph_ranking_list
-- the callback function can code in self module.
db_tired_getinfo=_db_tired_getinfo
db_tired_writeid=_db_tired_writeid
db_tired_logout=_db_tired_logout

--������ս����
db_cc_save =  _db_cc_save
db_cc_gen_ranks =  _db_cc_gen_ranks
db_cc_get_ranks_list =  _db_cc_get_ranks_list
db_cc_get_local_ranking =  _db_cc_get_local_ranking
db_cc_divorce =  _db_cc_divorce

--
-- db_cj_award = _db_cj_award
-- db_cj_get_award_num = _db_cj_get_award_num
db_cj_get_recharge_record = _db_cj_get_recharge_record