--[[
file:	player_events.lua
desc:	player events callback.
author:	chal
update:	2011-12-07
refix: done by chal
2014-08-23��add by sxj ,add bsmz,bsmz_online,bsmz_online(sid)
]]--

--------------------------------------------------------------------------
--include:
local Dead_UI		= msgh_s2c_def[3][1]
local Send_Wlevel	= msgh_s2c_def[3][4]
local Script_Init 	= msgh_s2c_def[3][8]
local Send_Login 	= msgh_s2c_def[3][22]
local time_ver 		= msgh_s2c_def[255][3]
local Faction_Build = msgh_s2c_def[7][4]
local show_equip 	= msgh_s2c_def[39][3]
local mathrandom,mathfloor,mathceil = math.random,math.floor,math.ceil
local type,tostring	= type,tostring
local pairs			= pairs
local define		= require('Script.cext.define')
local TaskTypeTb 	= define.TaskTypeTb
local Define_POS 	= define.Define_POS
local look 			= look
local TableHasKeys 	= table.has_keys
local TipCenterEx	= TipCenterEx
local GetStringMsg	= GetStringMsg
local SendLuaMsg	= SendLuaMsg
local active_mgr_m = require('Script.active.active_mgr')
local activitymgr = active_mgr_m.activitymgr
local lt_module = require('Script.active.lt')
local lt_exit = lt_module.lt_exit
local faction_monster = require('Script.active.faction_monster')
local ss_onlogin = faction_monster.ss_onlogin
local escort = require('Script.active.escort')
local escort_playerdead=escort.escort_playerdead
local escort_login=escort.escort_login
local db_module =require('Script.cext.dbrpc')
local db_lvup_log=db_module.db_lvup_log
local db_item_out=db_module.db_item_out

local get_login_info = db_module.get_login_info
local db_module = require('Script.cext.dbrpc')
local db_faction_yajin_back = db_module.db_faction_yajin_back
local db_marry_cost_back = db_module.db_marry_cost_back
local db_savelogouttime=db_module.db_savelogouttime

local CI_GetPlayerData 		= CI_GetPlayerData
local CI_RoleCreateInit 	= CI_RoleCreateInit
local MarkTaskKillMonster 	= MarkTaskKillMonster
local SyncTaskData			= SyncTaskData
local SendTaskMask			= SendTaskMask
local CI_GetCurPos			= CI_GetCurPos
local CheckGoods			= CheckGoods
local CI_OnSelectRelive		= CI_OnSelectRelive
local CI_SetPlayerIcon		= CI_SetPlayerIcon
local GetPlayerDayData		= GetPlayerDayData
local SetLogoutHangUpData	= SetLogoutHangUpData
local SetLoginHangUpData	= SetLoginHangUpData
local GetServerOpenTime		= GetServerOpenTime
local send_player_wage		= send_player_wage
local Ver					= __Ver
local shq_m = require('Script.ShenQi.shenqi_func')
local shenqi_dead_punishment = shq_m.shenqi_dead_punishment
local shenqi_login = shq_m.shenqi_login
local SetShenQiIcon = shq_m.SetShenQiIcon
local shenqi_get_ring = shq_m.shenqi_get_ring
local CI_HasBuff = CI_HasBuff

local wuzhuang = require('Script.wuzhuang.wuzhuang_fun')
local EquipItem= wuzhuang.EquipItem

local CI_GetFactionInfo = CI_GetFactionInfo
local bsmz			 = require ("Script.bsmz.bsmz_fun")
local bsmz_online	 = bsmz.bsmz_online
local bsmz_add		 = bsmz.bsmz_add
local donate = require("Script.Player.player_donate")		-- ��Ҿ��׾�λϵͳ
local donate_onlogin = donate.donate_onlogin

local chunjie_active = require("Script.Active.chunjie_active")
local online_chunjie_data = chunjie_active.online_chunjie_data

local dragon_module = require("Script.ShenBing.dragon_func")
local dragon_repair_bug = dragon_module.dragon_repair_bug
--------------------------------------------------------------------------
-- inner:

local uv_send_data = {}
 
 --���Ͱ汾������Ϣ
local function Check_vertime(sid)
	if sid==nil  then return end
	local level = CI_GetPlayerData(1)
	if level>1 then
		local dayData = GetPlayerDayData(sid)
		local ref = dayData.ref 
		if ref==nil or ref.day == nil or ref.day<Ver then
			SendLuaMsg( 0, { ids=time_ver }, 9 )
		end
	end
end

-- �Ϸ�������
local function MergeServer_Proc(sid)
	-- �����ж��Ƿ��ǺϷ�������
	local mergeTime = GetServerMergeTime() or 0
	if mergeTime <= 0 then
		return
	end	
	-- ���ذ������Ѻ��
	db_faction_yajin_back(sid)
	-- ���ػ���ԤԼ����
	db_marry_cost_back(sid)
	--look('MergeServer_Proc')
	local lv = CI_GetPlayerData(1,2,sid)	
	-- �ж��Ƿ����й�����
	-- ��������й�ȴû�й�����˵���ǺϷ���һ������
	if not IsPlayerTSD(sid,1) then
		--look('MergeServer_Proc 1')
		local pManorData = GetManorData_Interf(sid)
		if pManorData == nil then return end
		-- ��ȥ������
		pManorData.Rank = nil
		-- ������λ������		
		if pManorData.bFst then
			--look('MergeServer_Proc 2')
			local rkList = GetManorRankList()
			if rkList == nil then return end
			pManorData.Rank = #rkList + 1
			if pManorData.Rank <= MAXRANKNUM then
				rkList[pManorData.Rank] = sid
				set_extra_rank(sid,pManorData.Rank)		-- 2000�������Ӧ�ò��ù�
			else
				pManorData.Rank = MAXRANKNUM + 1
			end
		end
		-- �����Ӷ�����
		if lv >= 43 then
			--look('MergeServer_Proc 3')
			local roblist = GetManorRobberyList()
			if roblist == nil then return end
			if roblist[lv] == nil then
				roblist[lv] = {}
			end
			table.push(roblist[lv],sid)
		end
		-- ���й�
		if CheckNeedTs(sid) then
			--look('MergeServer_Proc 4')
			Player_to_World(sid)
		end
	end
	
end

-- ������������ߴ���
local function SpanServer_Proc(sid)
	if sid == nil then return end
	if IsSpanServer() then
		--------------���ñ���id
		CI_SetPlayerData(10,GetPlayerServerID(sid),sid)
		--------------
		--look(cUID,1)
		local cUID = GetPlayerSpanUID(sid) or 0

		if cUID == 1 then	-- ������BOSS�		
			local ret = GI_spanboss_enter(sid)
			if not ret then	-- ���벻�ɹ� ֱ�Ӷ���ԭ��
				SetSpanLeaveTime(sid,cUID,-1)		-- ������� ��֤��������BUFF
				CI_LeaveSpanServer()
				return
			end
		elseif cUID == 2 then	-- ������Ѱ���	
			local ret = GI_spanxb_enter(sid)
			if not ret then	-- ���벻�ɹ� ֱ�Ӷ���ԭ��
				-- SetSpanLeaveTime(sid,cUID,-1)		-- ������� ��֤��������BUFF
				CI_LeaveSpanServer()
				return
			end
		elseif cUID == 3 then	-- ����������	
			local ret = GI_span_catchfish_enter(sid)
			if not ret then	-- ���벻�ɹ� ֱ�Ӷ���ԭ��
				-- SetSpanLeaveTime(sid,cUID,-1)		-- ������� ��֤��������BUFF
				CI_LeaveSpanServer()
				return
			end
		elseif cUID == 4 then	-- ������3v3�	
			local ret = v3_login(sid)
			if not ret then	-- ���벻�ɹ� ֱ�Ӷ���ԭ��
				-- SetSpanLeaveTime(sid,cUID,-1)		-- ������� ��֤��������BUFF
				CI_LeaveSpanServer()
				return
			end
		elseif cUID == 5 then	-- �������콵����	
			local ret = GI_span_tjbx_enter(sid)
			if not ret then	-- ���벻�ɹ� ֱ�Ӷ���ԭ��
				SetSpanLeaveTime(sid,cUID,-1)		-- ������� ��֤��������BUFF
				CI_LeaveSpanServer()
				return
			end
		elseif cUID == 6 then	-- ����������ս���		
			local ret = GI_span_sjzc_enter(sid)
			if not ret then	-- ���벻�ɹ� ֱ�Ӷ���ԭ��
				-- SetSpanLeaveTime(sid,cUID,-1)		-- ������� ��֤��������BUFF
				CI_LeaveSpanServer()
				return
			end	
		elseif cUID == 7 then   --������1v1�
			local ret = v1_login(sid)
			if not ret then	-- ���벻�ɹ� ֱ�Ӷ���ԭ��
				CI_LeaveSpanServer()
				return
			end
		elseif cUID == 8 then   --������������
			local ret = sjzz_js_enter(sid)
			if not ret then	-- ���벻�ɹ� ֱ�Ӷ���ԭ��
				CI_LeaveSpanServer()
				return
			end	
		-- else		
			-- -- Ϊ�˼����Ϸ�BOSS��ӵ��߼� ȫ�����º�ȥ��
			-- local con = GetSpanServerInfo(1)
			-- if con then
				-- local ret = GI_spanboss_enter(sid)
				-- if not ret then	-- ���벻�ɹ� ֱ�Ӷ���ԭ��
					-- SetSpanLeaveTime(sid,1,-1)		-- ������� ��֤��������BUFF
					-- CI_LeaveSpanServer()
					-- return
				-- end
			-- end
		end
		
	end
	return true
end
 
-- ȡ����ʱ������ID
local function GetFirstWeaponID(sid)
	local school = CI_GetPlayerData(2,2,sid)
	local sex = CI_GetPlayerData(11,2,sid)
	if school == 1 then
		if sex == 0 then
			return 5037
		elseif sex == 1 then
			return 5000
		end
	elseif school == 2 then
		if sex == 0 then
			return 5111
		elseif sex == 1 then
			return 5074
		end
	elseif school == 3 then
		if sex == 0 then
			return 5185
		elseif sex == 1 then
			return 5148
		end
	end
end

local function PlayerInit(sid)	
	-- �ж��Ƿ��ǵ�һ�ε�¼
	local taskData = GetDBTaskData(sid)
	if taskData and taskData.binit == nil then--��һ�ε�¼
		local wID = GetFirstWeaponID(sid)
		if wID then
			CI_RoleCreateInit(1,wID)
		end
		taskData.binit = 1
		CS_RequestEnter(sid,1001)
		TS_AcceptTask( sid, 1001)
	end
	-- ���û�н��ܹ���һ������ ���͵�һ�������ǰ̨
	if taskData and taskData.binit == 1 then
		local _,_,cj = CI_GetPlayerData(56)
		--look("cj:" .. cj)
		local storyID = 0
		if cj == 3 then
			storyID = 100000
		else
			return
		end
		--look("storyID:" .. storyID)
		SendStoryData(storyID)
	end  
end

local function InitTaskWhenLogin(sid)
end

-- �������ʱ��Ҫͬ�����ͻ��˵����ݣ�ͳһ�ɴ���Ϣ����

local function SendScriptInit(sid)
	-- ����ȼ��ӳ�
	local playerTemp = GetCurTaskTemp()
	local wAddNew = GetWorldExpAdd(sid)
	local svrTime = GetServerOpenTime() 	--����ʱ��
	local mergeTime = GetServerMergeTime()	-- �Ϸ�ʱ��
	if playerTemp==nil then return end
	playerTemp.wAdd = wAddNew
	
	uv_send_data[1] = wAddNew
	uv_send_data[2] = GetWorldLevel()
	uv_send_data[3] = svrTime
	uv_send_data[4] = mergeTime
	
	SendLuaMsg( 0, { ids = Script_Init, d = uv_send_data}, 9 )
end

-- δ��ȡ�Ľ������ߴ���
local function Awd_OnlineProc(sid)
	-- MRK_OnlineProc(sid)		-- ��λ����������
end

--------------------------------------------------------------------------
-- interface:

-- ���ÿ������ʱ���ã���½/��������/��������½�ȵȣ�
-- ������Ҫ���������Ҫ��ʼ����ǰ̨�����ݣ��������˵ĳ�ʼ����OnPlayerLogin�н���
-- check1����ʼ��ʱ�����ű����ݶ����л�������ǰ̨��SyncTaskData����������������ݲ���Ҫ���η��͡������Ҫ����ŵ�OnPlayerLogin����
-- check2���Ƿ����Ƿ���������ݷŵ�SendScriptInit��
-- check3���Ƿ��п�������Ҳ�����������ʱ������Ҫ���͸���ҵ�����
function OnPlayerOnline(binit)	
	look('OnPlayerOnline',2)
	
	local sid = CI_GetPlayerData(17)
--	look(sid,2)
--	g_chk(3,sid)
	
	if sid == nil or sid <= 0 then return end
	PlayerInit(sid)				-- ��һ�ε�½��ʼ������
	-- δ��ֹ����Ĳ��������½���ִ�в������ڷ���ǰ��
	UnLockPlayer(sid)			-- ���߽������
	if binit ~= 1 then
		return
	end
	if not IsSpanServer() then
		--------------��¼����ID
		SetPlayerServerID(sid)
		--------------
	end
	-- ������ߴ���
	--look('OnPlayerOnline',1)
	-- look(sid,1)
	if not SpanServer_Proc(sid)	then
		return
	end
	--����BUG�޸�
	dragon_repair_bug(sid)
	--�����λ������
	MRK_LoginCheckRankData(sid)
	--����Ͼ�����
	Clear_player_old_data(sid)
	--���ڻ���ߴ���
	online_chunjie_data(sid)
	
	-- �������ýű�����
	SyncTaskData()		
	-- �������ñ����Ϣ	
	SendTaskMask()
	-- ���ͽű�ͨ�ó�ʼ����Ϣ
	SendScriptInit(sid)
	-- ��ʱVIP���ߴ���
	VIP_OnlineProc(sid)
	-- �������ߴ���
	CS_OnLineProc(sid)					
	-- �����ͳһ����ӿ�
	activitymgr:on_login(sid)
	-- ����ͳһ����ӿ�
	Awd_OnlineProc(sid)
	-- ��̨�����ߴ���
	lt_exit(sid,5)		

	bsmz_online(sid)	--��ʯ��������
	--ss_onlogin(sid)	--���޻����
	active_getawards(sid)		--�����δ�콱���ߴ���
	
	HeroAutoFight(sid)			-- ����Զ���ս
	Active_SendData(sid,0)		-- ���ͻ�б�
	
	-- ��������µ�����ͬ��	
	escort_login()				-- ����
	sendMountLuck()				-- �������ﵱǰ�齱��ʶ	
	sendFactionUnion(sid) --���Ͱ��ͬ������
	send_auto_faction()	--���ͻ����˰������
	sendCityOwner(sid)	-- ���͵�ǰ���������
	send_player_wage(sid) --����ÿ��ǩ������
	online_leave_faction(sid)	-- ���߱��߰����ȥ�����ս�ƺ�
	fsb_lookbox(sid) --Ѱ���ֿ�����
	get_login_info(sid)		-- ȡ�洢���̵�½�����Ϣ (���磺�ֻ���֤)	
	clear_player_ff_week(sid)-- ����ܰﹱ
	wing_reset(sid)
	MarryOnlineProc(sid)		-- ���͵�ǰ������Ϣ
	SendSpanActiveState(sid)	-- ���Ϳ�����Ϣ
	v3reg_online(sid)			--���Ϳ��3v3������Ϣ
	-- shenqi_login(sid)			--����������Ϣ
	SetShenQiIcon(sid)			-- ����������ָ��ʾ
	online_1v1(sid)             --�������1v1
	tired_getonlinetime(sid)    --������
	v1_clearnotusedata( sid )	--���v1��Ҫ����

	dcard_player_online(sid) --�λÿ���
	-- �����Ҵ�������״̬���Ҳ���ׯ԰�Ӷ��ͼ������UI���
	local _,_,rid ,mapGID= CI_GetCurPos()
	if CI_GetPlayerData(25) == 0 and (rid ~= 2001 and rid ~= 512) then 	
		SendLuaMsg( 0, { ids=Dead_UI, tm = 60 }, 9 )
	end
	if mapGID and rid==1044 then --���޸������������ڸ���ǿ���Ƴ�
		--look('���޸������������ڸ���ǿ���Ƴ�',1)
		local res=PI_MovePlayer( 1, 74, 97)
		--look(res,1)
	end
	-- ���Ը����������
	local taskData = GetDBTaskData(sid)
	if taskData then
		compzip(taskData)
	end	
	TS_AcceptTask(sid,4900,0)
	-- test
	--Getplayerdata_all(sid)				--ͳ�������������С
	donate_onlogin(sid)				-- ͭǮ���׵�¼����
	--
	login_show_equip(sid)
end

-- ��ҵ�һ�ε�½ʱ���ã�������ҽű����ݵĳ�ʼ��
function OnPlayerLogin( )
	look('OnPlayerLogin',2)
	login_num = login_num + 1
	local sid = CI_GetPlayerData(17)
	if sid == nil then return end
	
	--�ϰ��ɱ�ʯ������½���
	bsmz_add()
	
	-- �Ϸ����ݴ���
	if not IsSpanServer() then
		MergeServer_Proc(sid)
	end
	SetLoginHangUpData(sid)			-- �չس�ʼ��
	
	Check_vertime(sid)			-- ��ⵯ���������
	
	--PlayerInit(sid)				-- ��һ�ε�½��ʼ������	
	DayRefresh(1)				-- ÿ������				
	InitTaskWhenLogin(sid)		-- �����ʼ��	
	World_to_Player(sid)		-- ���й����ݸ�������й�����
	set_extra_backup(sid)		-- ���йܱ������ݸ����������
	LoginResetTimes(sid)		-- ��½��ʼ���¼ӹ��ܴ���
	
	LoginCheckRide(sid)			-- ��¼����Ƿ���Ҫ����	
	set_last_access(sid)
	--batt_login_makeup(sid )     --�����޸Ĳ���20131122
	horse_login_makeup(sid)		--���ﲹ��20131122
	CityOwnerLogin(sid)			-- �������߹���
	bat_reset( sid,1)			-- ��½���Ů����ֵ
	
	GD_SyncLandLv(sid)			-- ͬ�����صȼ�

	facskill_OnLogin(sid)	--���Ἴ�ܳ�ʼ��

	GI_SetScriptAttr(sid)		-- ���ýű���ӵ���������
	vip_login_addbuff(sid)		-- vip4��½��buff
	app_login(sid)				-- ʱװ��½��������
	sowar_login(sid)			-- ������⼰�������ֵ�½��������
	SetPresIcon(sid)			-- ���������ȼ���ʾ
	SetShenQiIcon(sid)			-- ����������ָ��ʾ
	MarryDataSync(sid)			-- ����ͬ���������
	PushSigleList(sid,1)		-- ����δ���б�
	db_item_out(sid ,4)			-- ��ת�̴���
	set_join_factionDate(sid)	-- �ж����ʱ��
	
	cc_on_player_login(sid)
	lhj_on_player_login(sid)
	look(GI_GetPlayerData(sid,'zm',32),2)
	
--	GI_GetPlayerData(sid,'gpid',12) = GetGroupID(sid);

	-- test
	-- MR_PushRank(sid)			-- �����λ�б�[can del?]
	-- Player_to_World(sid)		-- ��ӵ��й�����[can del?]
	-- CF_LoginOut(sid)			-- ���ʱ����
	--���ĳɾ͸Ķ�
	temp_achieve(sid)
	--���ڻ���ߴ���
	online_chunjie_data(sid)
end

-- call when online player login .
-- ��ʱû�д������д�����OnPlayerOnline��
-- function OnPlayerReLogin( gid )
-- end

function OnPlayerLogout()
	logout_num = logout_num + 1
	--look('���߱�������')
	local sid = CI_GetPlayerData(17)
	if sid == nil then return end
	
	SetLogoutHangUpData(sid)
	
	-- ����ͬ�����й�����
	Player_to_World(sid) 
	-- �������ߴ���(�������䴦��)
	CS_OutLineProc(sid)
	-- �������ͳһ����ӿ�
	activitymgr:on_logout(sid)	
			
	-- ����ȫ����ʱ��������������ص�����
	--CF_Leave( sid )			-- ���ʱ���Σ���Ӫս
	--FF_Leave( sid )			-- ���ʱ���Σ����ս
	faction_yb_logout(sid)		-- ��������״̬
	GI_UpdatePlayerScore(sid)	-- ��������й�����
	setMountsLogout(sid)		-- ���߱���������״̬
	bury_onlive( sid )			-- ���߱������
	item_innumactive( sid )     -- ���߱�������ʹ������
	RemoveSigleList( sid )		-- ���ߴ�δ���б��Ƴ�
	v3reg_logout( sid )			-- ����������3v3����
	tired_logout() 				--������
	--db_savelogouttime(sid)		--����дdb�洢��¼ʱ���
	--look('end')
end

function OnPlayerRelive( bUseItemTo , CopySceneGID )
	local sid = CI_GetPlayerData(17)
	local x, y,regionId,mapGID = CI_GetCurPos()
	--look('bUseItemTo='..bUseItemTo..',bInFB='..CopySceneGID)
	--look('regionId='..regionId..',x='..x)

	
	-- �����������buff(��ұ���Ϊ��ƽģʽ)
	local mode = CI_GetPlayerData(8,2,sid)
	if RegionTable[regionId] and RegionTable[regionId].dbuf and mode == 0xff then
		CI_AddBuff(242,0,5,false,2,sid)		
	end
	--���������мҽ�
	HeroAutoFightForRelive(sid)

	-- ԭ�ظ���
	if bUseItemTo ~= 0 then			-- relive from dead pos.		
		local d_gid = 0
		if mapGID then
			d_gid = mapGID
		end
		if not PI_MovePlayer(regionId, x, y,d_gid)	then
			rfalse('PI_MovePlayer err when OnPlayerRelive 1')
		end
		return 1
	end
	-- goback to home.
	if CopySceneGID and CopySceneGID ~= 0 then 
		CS_ReliveProc(sid)		-- ���������
		return 1
	end
	-- active relive proc
	if activitymgr:on_playerlive(sid) == 1 then
		return 1
	end
	
	if regionId == 3 then	--���ִ�
		PI_MovePlayer(3, 100, 159)
		return 1
	elseif regionId == 521 then	--����ؾ�
		PI_MovePlayer(0, 28, 65,mapGID)
		return 1
	elseif regionId == 11 then	--�������
		PI_MovePlayer(11, 8, 104)
		return 1
	else 
		--rfalse('1112233')
		local num = mathrandom(1,#Define_POS)
		if not PI_MovePlayer(Define_POS[num][1],Define_POS[num][2],Define_POS[num][3]) then
			look('PI_MovePlayer err when OnPlayerRelive 3')
		end
		return 1
	end
	
	return 0 -- return 0 means relive from normal steps.
end

-- [0] �سǸ��� 
-- [1] ԭ�ظ���(ֻ�۵���) 
-- [2] ԭ�ظ���(�ȼ����ߣ��ټ���Ԫ���������Ԫ��)
-- [3] ԭ�ظ���(�ȼ�鸴��������ȼ����ߣ��ټ���Ԫ���������Ԫ��)
function OnSelectRelive( playerid, stype )
	--look('OnSelectRelive=' .. tostring(stype))
	if stype == 0 then
		
	elseif stype == 1 then
		if CheckGoods( 676, 1, 0, playerid ,'����') == 0 then
			--look("���߲��㡢���ܸ���")
			return
		end			
	elseif stype == 2 then
		if CheckGoods( 676, 1, 0, playerid,'����' ) == 0 then
			local bdyb = GetPlayerPoints(playerid,3) or 0
			if bdyb < 50 then
				if not CheckCost( playerid, 10, 0, 1,"100019_��������_"..tostring(stype)) then
					--look("Ǯ�������ܸ���")
					return
				end
			else
				AddPlayerPoints( playerid, 3, -50, nil, '100019_��������_ ' .. tostring(stype), true)
			end
		end
	elseif stype == 3 then
		if not CheckTimes(playerid,TimesTypeTb.relive,1,-1) then
			if CheckGoods( 676, 1, 0, playerid,'����' ) == 0 then
				local bdyb = GetPlayerPoints(playerid,3) or 0
				if bdyb < 50 then
					if not CheckCost( playerid, 10, 0, 1,"100019_��������_"..tostring(stype)) then
						CI_OnSelectRelive(0,3*5,2,playerid)		-- Ǯ�����سǸ���
						return
					end
				else					
					AddPlayerPoints( playerid, 3, -50, nil, '100019_��������_ ' .. tostring(stype), true)
				end
			end
		end
	else
		return
	end
	CI_OnSelectRelive(stype,3*5,2,playerid)
end

function SI_OnPlayerDead(rid, mapGID, deadSID, killerSID )
	-- -- �������⴦������
	-- if rid ~= nil and (rid == 512 or rid == 2001)  then
		-- SetEvent( 3, nil, 'OnDeadProcEx', sid, rid, mapGID )
		-- return
	-- end
	-- look('SI_OnPlayerDead',1)
	-- look(rid)
	-- look(mapGID)
	-- look(deadSID)
	-- look(killerSID)
	local sid = CI_GetPlayerData(17) 
	-- �����������ͳһ�ӿ�
	if activitymgr:on_playerdead(deadSID,rid,mapGID,killerSID) == 1 then
		return
	end	
	
	 escort_playerdead(sid,killerSID) ---Ѻ���ж� 
	 HeroAutoBackFight(sid) --�������Զ��ٻؼҽ�
	 faction_yb_dead(sid)			-- ��������ж�
	
	-- ȡɱ������Ϣ
	local killerName,killerLv
	killerName = CI_GetPlayerData(5,2,killerSID)
	killerLv = CI_GetPlayerData(1,2,killerSID)
	
	-- �����������buff(��ұ���Ϊ��ƽģʽ)
	if killerSID > 0 then
		--look(rid)		
		
		-- ɱ���߸���PKֵ
		if RegionTable[rid] and RegionTable[rid].PKValue then
			AddPlayerPoints( killerSID, 9, 1, false, 'ɱ��')	
		end
	end

	shenqi_dead_punishment(rid, deadSID, mapGID, killerSID)
	
	SendLuaMsg( 0, { ids=Dead_UI, tm = 60, kName = killerName, kLV = killerLv  }, 9 )

end

function OnPlayerLevelup(newLevel,oldLevel)
	local playerid=CI_GetPlayerData( 17 )
	-- if newLevel >= 10 then
		-- checkPlayerData(playerid,newLevel)
	-- end
	if newLevel >= 40 then
		PushSigleList(playerid)
	end
	if newLevel >= 42 then
		MRB_PushList(playerid,newLevel,oldLevel)	-- ����ǼǱ� Ŀǰ����û�жϵȼ�
	end
	if newLevel == 60 then
		TipCenterEx(GetStringMsg(296,CI_GetPlayerData(3),60))
	end
	if newLevel == 65 then
		TipCenterEx(GetStringMsg(296,CI_GetPlayerData(3),60))
	end
	if newLevel == 70 then
		
		TipCenterEx(GetStringMsg(296,CI_GetPlayerData(3),70))
	end
	if newLevel == 80 then
		TipCenterEx(GetStringMsg(296,CI_GetPlayerData(3),80))
	end
	if newLevel == 90 then
		TipCenterEx(GetStringMsg(296,CI_GetPlayerData(3),90))
	end
	local playerTemp = GetCurTaskTemp()
	local wAddNew = GetWorldExpAdd(CI_GetPlayerData(17))
	if playerTemp.wAdd == nil or playerTemp.wAdd ~= wAddNew then
		playerTemp.wAdd = wAddNew
		SendLuaMsg( 0, { ids=Send_Wlevel, wAdd = wAddNew }, 9 )
	end
	local lv_balance=newLevel-oldLevel	
	if lv_balance>1 then
		local num=0
		if	oldLevel%2==0 then
			num=mathfloor(lv_balance/2)
		else
			num=mathceil(lv_balance/2)
		end
		Add_Skillnum(playerid,num)
	elseif lv_balance==1 then
		if newLevel%2==0 then
			Add_Skillnum(playerid,1)
		end
	end
	db_lvup_log(playerid,newLevel)
end

function OnQuitTeam( )
end


-- ��½����ս���������ƺ�(�ж�: ���߲���Ҫ�㲥)
function CALLBACK_GetRoleRank(sid,bonline,frank)
	--look('CALLBACK_GetRoleRank:' .. tostring(sid)..'__'..tostring(frank))
	if sid == nil or frank == nil then return end
	local br = (bonline and 0) or 1
	
	if frank == 1 then
		CI_SetPlayerIcon(0,1,2,br)
	elseif frank >= 2 and frank <= 10 then
		CI_SetPlayerIcon(0,1,3,br)
	else
		CI_SetPlayerIcon(0,1,0,br)
	end
end

function CALLBACK_GetLoginInfo(sid,rs)
	if sid == nil or rs == nil then return end
	if type(rs) == type({}) then
		SendLuaMsg( sid, { ids=Send_Login, rs = rs }, 10 )
	end
end

local function GetPlayerShenQiData(sid)
	local shqdata=GI_GetPlayerData( sid , 'shq' , 150 )
	if shqdata == nil then return end
	return shqdata
end

function SI_OnPVPDamage(enemyid, damage)
	-- look('**************SI_OnPVPDamage start******************',1)
	if enemyid == nil or damage == nil or damage < 0 then return 0 end
	-- look('damage = ' .. damage,1)
	local fixdmg = damage
	local sid = CI_GetPlayerData(17)
	local blood = CI_GetPlayerData(25)
	if sid == nil or blood == nil then return 0 end
	-- look('blood = ' .. blood)
	local shqdata_en = GetPlayerShenQiData(enemyid)
	local shqdata_se = GetPlayerShenQiData(sid)
	if shqdata_en == nil or shqdata_se == nil then return damage end
	if shqdata_en[807] == nil and shqdata_se[806] == nil and shqdata_se[807] == nil then
		return damage
	end
	
	local en_level_r  --�����ҽ�ȼ�
	local en_state_r  --�����ҽ�״̬
	local se_level_l  --�Լ����ȼ�
	local se_state_l  --�Լ����״̬
	local se_level_r  --�Լ��ҽ�ȼ�
	local se_state_r  --�Լ��ҽ�״̬
	
	if shqdata_en[807] and shqdata_en[807][2] and shqdata_en[807][3] then
		en_level_r = shqdata_en[807][2] --�����ҽ�ȼ�
		en_state_r = shqdata_en[807][3] --�����ҽ�״̬
	end
	if shqdata_se[806] and shqdata_se[806][2] and shqdata_se[806][3] then
		se_level_l = shqdata_se[806][2] --�Լ����ȼ�
		se_state_l = shqdata_se[806][3] --�Լ����״̬
	end
	if shqdata_se[807] and shqdata_se[807][2] and shqdata_se[807][3] then
		se_level_r = shqdata_se[807][2] --�Լ��ҽ�ȼ�
		se_state_r = shqdata_se[807][3] --�Լ��ҽ�״̬
	end
	
	local now = GetServerTime()
	if en_state_r and en_level_r and en_state_r == 1 and en_level_r >= 50 then
		if se_state_l and se_level_l then
			if se_state_l == 1 and se_level_l >= 50 then
				fixdmg = damage*(1 + (mathfloor(en_level_r/10)/100 - mathfloor(se_level_l/10)/100))
				if fixdmg >= blood then
					local rand_se = mathrandom(100)
					if rand_se <= 50 then
						shqdata_se.skcd = shqdata_se.skcd or {}
						if now >= (shqdata_se.skcd[2] or 0) then
							fixdmg = blood - 1
							CI_AddBuff(365,0,1,false,2,sid) -- �����̾Ϣ
							shqdata_se.skcd[2] = now + 600
						end
					end
				end
			else
				fixdmg = damage*(1 + (mathfloor(en_level_r/10)/100))
			end
		else
			fixdmg = damage*(1 + (mathfloor(en_level_r/10)/100))
		end
		
		local rand_en = mathrandom(100)
		if rand_en <= 10 then
			shqdata_en.skcd = shqdata_en.skcd or {}
			if now >= (shqdata_en.skcd[1] or 0) then
				if not CI_HasBuff(366,2,sid) then
					CI_AddBuff(366,0,1,false,2,sid) -- ����Ĳþ�
					SetEvent(12, nil, "shenqi_buffer_end", sid)
				end
				shqdata_en.skcd[1] = now + 180
			end
		end
	else
		if se_state_l and se_level_l then
			if se_state_l == 1 and se_level_l >= 50 then
				fixdmg = damage*(1 - (mathfloor(se_level_l/10)/100))
				if fixdmg >= blood then
					local rand_se = mathrandom(100)
					if rand_se <= 50 then
						shqdata_se.skcd = shqdata_se.skcd or {}
						if now >= (shqdata_se.skcd[2] or 0) then
							fixdmg = blood - 1
							CI_AddBuff(365,0,1,false,2,sid) -- �����̾Ϣ
							shqdata_se.skcd[2] = now + 600
						end
					end
				end
			end
		end
	end
	if se_state_l and se_level_l and se_state_r and se_level_r then
		if se_state_l == 1 and se_level_l >= 50 and se_state_r == 1 and se_level_r >= 50 then
			local rand = mathrandom(100)
			if rand <= 10 then
				shqdata_se.skcd = shqdata_se.skcd or {}
				if now >= (shqdata_se.skcd[3] or 0) then
					CI_AddBuff(364,0,1,false,2,sid) -- ��ŭ����־
					shqdata_se.skcd[3] = now + 90
				end
			end
		end
	end
	-- look('fixdmg = ' .. mathfloor(fixdmg),1)
	-- look('**************SI_OnPVPDamage end******************',1)
	return mathfloor(fixdmg)
end

function CALLBACK_GetRinginfo(sid,val,index)
	-- look('*****************CALLBACK_GetRinginfo start******************',1)
	if sid == nil or index == nil then return end
	val = val or 0
	if index == 806 then
		if val > 10000 then
			shenqi_get_ring(sid, 1, index)
		end
	elseif index == 807 then
		if val > 20000 then
			shenqi_get_ring(sid, 1, index)
		end
	end
	-- look('*****************CALLBACK_GetRinginfo end******************',1)
end

function shenqi_buffer_end(sid)
	if sid == nil then return end
	if CI_HasBuff(366,2,sid) then
		CI_AddBuff(368,0,1,false,2,sid)
	end
end

--�ɾ���ʱ����
function temp_achieve(sid)
	temp_mounts(sid)
	temp_mounts_bone(sid)
	sowar_chengjiu(sid)
	temp_wing(sid)
	temp_fskill(sid)
	skill_chengjiu(sid)
	vip_tempfun(sid)
end

--outfit_id����id
--����װ��
--[[
	res  Ϊ1 ��ʾ���ܴ���
		 Ϊ0 ��ʾ���Դ���
]]
function SI_EquipItem(outfit_id)
	local res = EquipItem(outfit_id)
	return res
end
--ж��װ��
--[[function SI_UnEquipItem(outfit_id)
	--local res = UnEquipItem(outfit_id)
	return 0
end]]

function SI_OnSkillEnd(skill_id)
	-- look("SI_OnSkillEnd",2)
	-- look(skill_id,2)
	
	if CI_HasBuff(260) then
		ysfs_on_attack(CI_GetPlayerData(17))
	end
end
 
--100��װ��չʾ
function login_show_equip(sid)
	local wdata = GetWorldCustomDB()
	wdata.show_equip = wdata.show_equip or {
		index = 0,
	}
	
	if wdata.show_equip.index == 1 then 
		SendLuaMsg(0, { ids=show_equip }, 9 )
	end
end
