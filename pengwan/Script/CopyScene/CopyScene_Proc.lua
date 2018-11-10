--[[
file:	���̴���.lua
desc:	�������̴���
author:	csj
update:	2013-5-21
	DeleteTeamMember(leaderSID,name)	-- �Ƴ���Ա
	AskJoinTeam(sid,leaderSID)			-- ����������
	
��Ӹ������̣�
һ.��������
	1.�����ö����
	1����Ա�������������ʾ��������ʾֻ�жӳ����ܴ������䣡������������
	2���ӳ�����������䣬����Աȫ���ھ��ǣ��򷿼䴴���ɹ���ͬʱ�����������˵�������ui����ʱ��Ա�����npc�����뷿�伴 �ɵ��׼����
	3���ӳ�����������䣬���ж�Ա���ھ��ǣ�����������������ʾ�ж�Ա������᪣���������ʧ�ܣ�����������
	2.���δ���
	1������������䣬�򷿼䴴���ɹ�����Ϊ����
	*�ڷ��������뿪���ǣ���ر�ui���Զ��˶�
��.���뷿��
	1.����ж��飨�����Ƕӳ����Ƕ�Ա��
	������뷿�䣬���˳�ԭ���飬���뷿�����ڶ���
	2.���δ���
	������뷿�䣬���뷿�����ڶ���
	*����������ʱ��������ʾ�÷�����������ѡ������������룡
	*������ټ���ʱ�����û�з����п�λ�����Զ�����һ���µķ���
��.׼��
	1.������δ��׼��ʱ�����������ʼ����ʾ��������Xλ��Աδ���׼����
	2.��Ա��׼�����������������ʼ�������������������˴��븱����ͼ
]]--
--------------------------------------------------------------------------
--include:
local type = type
local TP_FUNC = type( function() end)
local pairs = pairs
local ipairs = ipairs
local __G = _G
local math_max,math_random = math.max,math.random
local table_empty,table_maxn = table.empty,table.maxn
--local ----look = ----look
local csBeginProcTb = csBeginProcTb
local CI_GetPlayerData,SendLuaMsg =CI_GetPlayerData,SendLuaMsg
local tablelocate = table.locate
local uv_FBConfig,CreateGroundItem = FBConfig,CreateGroundItem
local uv_CommonAwardTable,ClrEvent = CommonAwardTable,ClrEvent
local uv_TimesTypeTb,GetStringMsg = TimesTypeTb,GetStringMsg
local ScriptAttType,RegionRPC = ScriptAttType,RegionRPC
local TraceTypeTb,CI_DeleteDRegion = TraceTypeTb,CI_DeleteDRegion
local EventTypeTb,GetServerTime,DeleteTeamMember = EventTypeTb,GetServerTime,DeleteTeamMember
local GetPlayerDayData = GetPlayerDayData
local GetSubID,CI_GetCurPos,TeamRPC,RPCEx = GetSubID,CI_GetCurPos,TeamRPC,RPCEx
local CheckTimes,SetEvent,LockPlayer = CheckTimes,SetEvent,LockPlayer
local CreateObjectIndirect,CI_UpdateMonsterData = CreateObjectIndirect,CI_UpdateMonsterData
local GetTimesInfo = GetTimesInfo
local get_join_factiontime = get_join_factiontime
local define = require('Script.cext.define')
local EquipItemInfo = define.EquipItemInfo
local giveitem_conf = define.giveitem_conf
local common = require('Script.common.Log')
local Log = common.Log
local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist_ex = sclist_m.insert_scorelist_ex
local xtg = require("Script.CopyScene.xtg")		-- �����
local xtg_faction_data = xtg.xtg_faction_data
local xtg_player_data = xtg.xtg_player_data
local xtg_data_deal = xtg.xtg_data_deal
local xtg_getplayerdata = xtg.xtg_getplayerdata

-- s2c_msg_def
local cs_check	= msgh_s2c_def[4][1]		-- ���������������	
local cs_progress	= msgh_s2c_def[4][2]		-- ��������
local cs_tips		= msgh_s2c_def[4][3]		-- ����׷��
local cs_awards	= msgh_s2c_def[4][4]		-- ��������
local cs_roomlist	= msgh_s2c_def[4][5]		-- ��Ӹ��������б�
local cs_ctroom	= msgh_s2c_def[4][6]		-- ��������
local cs_joinroom	= msgh_s2c_def[4][7]		-- ���뷿��
local cs_quitroom	= msgh_s2c_def[4][8]		-- �˳�����
local cs_passinfo = msgh_s2c_def[4][9]		-- ������Ϣ
-- local cs_allstar = msgh_s2c_def[4][10]		-- �ܹ����Ǽ�
local cs_invite = msgh_s2c_def[4][11]		-- ��Ӹ�������
local cs_sd = msgh_s2c_def[4][12]		-- ɨ��
local cs_ly = msgh_s2c_def[4][13]		-- ��������������������


--------------------------------------------------------------------------
-- data:
-- �������ͱ�(Ŀǰ�����߸������񴴸�������Ҫ��������)
local CSTypeTb = {
	CS_Main = 1,		-- ���߸���
	CS_Multi = 2,		-- ���˸���
	CS_Jewel = 3,		-- ��ʯ����
	CS_Tower = 4,		-- ��������
	CS_ZYT = 5,			-- ����������
	CS_Money = 6,		-- ͭǮ����
	CS_SCNormal = 7,	-- �񴴸���(��ͨģʽ)
	CS_SCHero = 8,		-- �񴴸���(Ӣ��ģʽ)
	CS_Exps = 9,		-- ���鸱��
	CS_Card = 10,		-- ���Ƹ���
	CS_WaBao = 11,		-- �ڱ�����
	CS_Vip = 12,   		-- VIP����
	CS_LL = 13,   		-- ����ֵ����
	CS_ZQZB = 14,   	-- ����װ������
	CS_Couple = 15,   	-- ���޸���
	CS_Equip = 16,		-- װ������
	CS_YuanShen = 17,	-- Ԫ�񸱱�
	CS_CoupleChallenge = 18,-- ������ս����
	CS_sl_hard = 19,		-- �������Ѹ���
	CS_sl_easy = 20,		-- �����򵥸���
	CS_lianyu = 21,		-- ��������
	CS_twone = 22,		-- ��������
	CS_YJDQ = 23,		-- һ�ﵱǧ
	CS_XTG = 24,			-- �����
	
	CS_test = 999,		-- ���Ը���

} 
local uv_Trapinfo = {0,0,0,0}

--------------------------------------------------------------------------
-- inner function:

-- ��ȡ��������(internal use)
function GetCSType(fbID)
	----look('GetCSType:' .. fbID)
	if fbID == nil or type(fbID) ~= type(0) then return end
	if fbID >= 1001 and fbID < 2000 then		-- ���߸���
		return CSTypeTb.CS_Main
	elseif fbID >= 2001 and fbID < 3000 then	-- ���˸���
		return CSTypeTb.CS_Multi
	elseif fbID >= 3001 and fbID < 4000 then	-- ��ʯ����
		return CSTypeTb.CS_Jewel
	elseif fbID >= 4001 and fbID < 5000 then	-- ��������
		return CSTypeTb.CS_Tower
	elseif fbID >= 5001 and fbID < 6000 then	-- ����������
		return CSTypeTb.CS_ZYT
	elseif fbID >= 6001 and fbID < 7000 then	-- ͭǮ����
		return CSTypeTb.CS_Money
	elseif fbID >= 7001 and fbID < 8000 then	-- �񴴸���(��ͨģʽ)
		return CSTypeTb.CS_SCNormal
	elseif fbID >= 8001 and fbID < 9000 then	-- �񴴸���(Ӣ��ģʽ)
		return CSTypeTb.CS_SCHero
	elseif fbID >= 9001 and fbID < 10000 then	-- ���鸱��
		return CSTypeTb.CS_Exps
	elseif fbID >= 10001 and fbID < 11000 then	-- ���Ƹ���
		return CSTypeTb.CS_Card
	elseif fbID >= 11001 and fbID < 12000 then	-- �ڱ�����
		return CSTypeTb.CS_WaBao
	elseif fbID >= 12001 and fbID < 13000 then	-- VIP����
		return CSTypeTb.CS_Vip
	elseif fbID >= 13001 and fbID < 14000 then	-- ����ֵ����
		return CSTypeTb.CS_LL
	elseif fbID >= 14001 and fbID < 15000 then	-- ����װ������
		return CSTypeTb.CS_ZQZB	
	elseif fbID >= 15001 and fbID < 16000 then	-- ���޸���
		return CSTypeTb.CS_Couple
	elseif fbID >= 16001 and fbID < 17000 then	-- װ������
		return CSTypeTb.CS_Equip
	elseif fbID >= 17001 and fbID < 18000 then	-- Ԫ�񸱱�
		return CSTypeTb.CS_YuanShen
	elseif fbID >= 18001 and fbID < 19000 then	-- ������ս����
		return CSTypeTb.CS_CoupleChallenge
	elseif fbID >= 19001 and fbID < 20000 then	-- �������Ѹ���
		return CSTypeTb.CS_sl_hard		
	elseif fbID >= 20001 and fbID < 21000 then	-- �����򵥸���
		return CSTypeTb.CS_sl_easy	
	elseif fbID >= 21000 and fbID < 22000 then	-- ��������
		return CSTypeTb.CS_lianyu	
	elseif fbID >= 22000 and fbID < 23000 then	-- ��������
		return CSTypeTb.CS_twone	
	elseif fbID >= 23000 and fbID < 24000 then	-- һ�ﵱǧ
		return CSTypeTb.CS_YJDQ	
	elseif fbID >= 24000 and fbID < 25000 then	-- �����
		return CSTypeTb.CS_XTG
		
	elseif fbID >= 999001 and fbID < 999999 then	-- ���Ը���
		return CSTypeTb.CS_test		
	end
end

-- ��ȡ��������(internal use)
local function GetCSConfig(fbID)
	local mainID,subID = GetSubID(fbID)
	if uv_FBConfig[mainID] and uv_FBConfig[mainID][subID] then
		return uv_FBConfig[mainID][subID]
	end
end	

-- ��ȡ����������������
function GetCSMonstrtNum(fbID)
	local FbCfg = GetCSConfig(fbID)
	local monsterNum = FbCfg.monsterNum
	
	return monsterNum
end

-- ��鸱�������ӿ�(internal use)
-- (Ŀǰ�����߸������񴴸�������Ҫ��������)
local function CS_CheckFBTimes(sid,fbID,bCheck)
	local csType = GetCSType(fbID)
	if csType == nil then return false end	
	if csType == CSTypeTb.CS_Multi then
		if not CheckTimes(sid,uv_TimesTypeTb.CS_Multi,1,-1,bCheck) then
			return false
		end
	elseif csType == CSTypeTb.CS_Jewel then
		if not CheckTimes(sid,uv_TimesTypeTb.CS_Jewel,1,-1,bCheck) then
			return false
		end
	elseif csType == CSTypeTb.CS_Tower then
		if not CheckTimes(sid,uv_TimesTypeTb.CS_Tower,1,-1,bCheck) then
			return false
		end
	elseif csType == CSTypeTb.CS_ZYT then
		if not CheckTimes(sid,uv_TimesTypeTb.CS_Single,1,-1,bCheck) then
			return false
		end
	elseif csType == CSTypeTb.CS_Money then
		if not CheckTimes(sid,uv_TimesTypeTb.CS_Money,1,-1,bCheck) then
			return false
		end
	elseif csType == CSTypeTb.CS_Exps then
		if not CheckTimes(sid,uv_TimesTypeTb.CS_Exps,1,-1,bCheck) then
			return false
		end
	elseif csType == CSTypeTb.CS_Card then
		if not CheckTimes(sid,uv_TimesTypeTb.CS_Card,1,-1,bCheck) then
			return false
		end
	elseif csType == CSTypeTb.CS_WaBao then
		if not CheckTimes(sid,uv_TimesTypeTb.wabao,1,-1,bCheck) then
			return false
		end
	elseif csType == CSTypeTb.CS_Vip then
		if not CheckTimes(sid,uv_TimesTypeTb.vip_fuben,1,-1,bCheck) then
			return false
		end
	elseif csType == CSTypeTb.CS_LL then
		if not CheckTimes(sid,uv_TimesTypeTb.CS_LL,1,-1,bCheck) then
			return false
		end
	elseif csType == CSTypeTb.CS_ZQZB then
		if not CheckTimes(sid,uv_TimesTypeTb.CS_ZQZB,1,-1,bCheck) then
			return false
		end	
	elseif csType == CSTypeTb.CS_Couple then
		if not CheckTimes(sid,uv_TimesTypeTb.CS_Couple,1,-1,bCheck) then
			return false
		end	
	elseif csType == CSTypeTb.CS_Equip then
		if not CheckTimes(sid,uv_TimesTypeTb.CS_Equip,1,-1,bCheck) then
			return false
		end	
	elseif csType == CSTypeTb.CS_lianyu then
		
		if IsSpanServer() then return false end
		if not CheckTimes(sid,uv_TimesTypeTb.CS_lianyu,1,-1,bCheck) then
			return false
		end	
	elseif csType == CSTypeTb.CS_twone then
		if IsSpanServer() then return false end
		if not CheckTimes(sid,uv_TimesTypeTb.CS_twone,1,-1,bCheck) then
			return false
		end	
	elseif csType == CSTypeTb.CS_YJDQ then
		if IsSpanServer() then return false end
		if not CheckTimes(sid,uv_TimesTypeTb.CS_yjdq,1,-1,bCheck) then
			return false
		end	
	elseif csType == CSTypeTb.CS_XTG then
		if IsSpanServer() then return false end
		if not CheckTimes(sid,uv_TimesTypeTb.CS_XTG,1,-1,bCheck) then
			return false
		end
	end
	return true
end

-- ��������ˢ���¼�����(internal use)
-- args:
--	[1] ��ͼ���
--	[2] �������α��(1�����Ϊ����ֱ�Ӿ������α�� 2������Ǳ�Ҫͨ��variant�����Ʋ���)
--  [variant] ���ڵ�[2]��һ�����ʱ����Ʋ���,Ҳ����Ϊ������Ϣ����ǰ̨ 
-- 	[3] [101] = ϵ�� ���ݸ�����������ƹ���ˢ��·(�����*ϵ��)
--		(������������ʱ��֧��) 
--		[102] = function (num) return �������ع�ʽ(��:num*2/9) end ����������������ˢ������(BRNum)
--		[202] = function (fval) return ս������ع�ʽ(��:fval*2/9) end �������ս����/ƽ��ս��������ˢ������(BRNum)
--		[302] = function (lv) return �ȼ���ع�ʽ(��:lv*2/9) end ������ҵȼ�/ƽ���ȼ�����ˢ������(BRNum)
--		[303] = function (monatt,lv) monatt[1] = �ȼ���ع�ʽ... end ������ҵȼ�/ƽ���ȼ����ƹ�������
--		[901] = ��� �ⲿ�Զ���ˢ�����
--		[902] = {[���]=num} �ⲿ�Զ���ˢ������(���������ⲿ�������������������ⲿ�����ֱ�Ӵ�����)
local function CS_MonRefreshProc(copyScene,args,variant)
	look("1111____________")
	if copyScene == nil or args == nil then return end	
	local mSerialNum = args[1]
	local mControl
	if type(variant) == type(0) and type(args[2]) == type({}) then 
		mControl = args[2][variant]
	end

	mControl = mControl or args[2]		-- ���ﲻ�ж�mControl�Ƿ���ȷ ������汨��˵������������
	if GetCSType(copyScene.fbID) == CSTypeTb.CS_twone then mControl = args[2][1] end

	if csType == CSTypeTb.CS_XTG then	-- ����󸱱���������ˢ�¹���
		local csStatus = GetCSStatus(copyScene.CopySceneGID)
		look("csStatus =")
		look(csStatus)
		if csStatus == nil or csStatus == CS_Status.CS_COMPLETE then	--�����Ѿ�����
			return
		end	
	end
	
	local t = args[3]
	local DynmicSceneMap = copyScene.DynamicSceneGIDList[mSerialNum]
	
	if DynmicSceneMap.MonsterList and DynmicSceneMap.MonsterList[mControl] then
		local monsterListConfig = DynmicSceneMap.MonsterList[mControl]
		local roads = #monsterListConfig	-- ����ˢ������
		local pn = copyScene.PlayerCount	-- �����������
		if pn < 0 then 
			--look('copyScene.PlayerCount error!',1)
			return
		end
		local monud,lvsum,lvave
		local func_att_3
		if t then			
			if type(t[101]) == type(0) then			-- ����·��				
				roads = rint(pn*t[101])
			end
			if type(t[303]) == TP_FUNC then	-- ������ҵȼ�/ƽ���ȼ���������
				------look('111111111111111111')
				for pid in pairs(copyScene.PlayerSIDList) do
					if type(pid) == type(0) then
						lvsum = (lvsum or 0) + CI_GetPlayerData(1,2,pid)
					end
				end
				if lvsum > 0 then
					lvave = rint(lvsum / pn)
				end
				func_att_3 = t[303]				
			end
		end
		for i = 1, roads do
			local mc = monsterListConfig[i]
			if type(mc) == type({}) and mc.monsterId ~= nil then
				mc.copySceneGID = copyScene.CopySceneGID
				mc.regionId = DynmicSceneMap.dynamicMapGID
				if lvave and lvave > 0 then
					mc.level = lvave
				end
				if type(func_att_3) == TP_FUNC then
					mc.monAtt = mc.monAtt or {}
					func_att_3(mc.monAtt,lvave)
					-- look(mc.monAtt)
				end			
				local GID = CreateObjectIndirect(mc)
				if GID and mc.EventID and mc.eventScript and mc.eventScript > 0 then
					----look("�����������"..GID.." = "..mc.eventScript)
					MonsterRegisterEventTrigger( mc.regionId, GID, MonsterEvents[mc.eventScript])
				end
			end
		end
	end	
	if variant then
		copyScene.turns = variant		-- ���¹��ﲨ��(���ڽ���)		
	else
		copyScene.turns = (copyScene.turns or 0) + 1
	end

	if type(args[4]) == type(0) then
		copyScene.turns = args[4]		-- ���¹��ﲨ��(���ڽ���)���ȼ�����variant(�Ḳ�ǵ�variant����)
	end
		
	if copyScene.turns then
		CS_SendTraceInfo( copyScene, TraceTypeTb.MonControl, copyScene.turns ) 	-- ����׷����Ϣ(��ǰ���ﲨ��)
	end
	return true
end

-- �������﹥��״̬����(Ŀǰinternal use)
-- args:
--	[1] ��ͼ���
--	[2] �������α��
local function CS_MonAttackProc(copyScene,args)	
	for k, mcid in pairs(args[2]) do
		-- look(mcid)
		CI_UpdateMonsterData(1,args[3],nil, 6, mcid)
	end
	
	return true
end

-- ������̬�赲����(����֧��ͬʱ���������̬�赲��ʧ)(Ŀǰinternal use)
-- args:
--	[1] ��ͼ���
--	[2] �赲���
--  [3] ���ö�̬�赲��״̬ 0 �赲��Ч 1 �赲��Ч 
local function CS_DynBlockProc(copyScene,args)
	----look("CS_DynBlockProc")
	if copyScene == nil or args == nil or type(args) ~= type({}) then return end
	local mSerialNum = args[1]
	local TraceMap = copyScene.TraceList[mSerialNum]
	if type(args[2]) == type(0) then
		local BlockID = args[2]		
		if type(TraceMap.BlockList) == type({}) then
			TraceMap.BlockList[BlockID] = args[3]
		end	
	elseif type(args[2]) == type({}) then
		for k, bid in ipairs(args[2]) do			
			if type(TraceMap.BlockList) == type({}) then
				TraceMap.BlockList[bid] = args[3][k]
			end
		end
	end
	CS_SendTraceInfo( copyScene, TraceTypeTb.BlockState, args ) --����׷����Ϣ
	return true
end

-- �������ؿ���״̬����(Ŀǰinternal use)
-- args:
--	[1] ��ͼ���
--	[2] ���ر�� NPCID
--  [3] ���û���״̬  0 �����Կ��� 1 ���Կ���
local function CS_MechanismProc(copyScene,args)
	----look("CS_MechanismProc")
	if copyScene == nil or args == nil or #args ~= 3 then return end
	local mSerialNum = args[1]
	local mNpcID = args[2]
	local TraceMap = copyScene.TraceList[mSerialNum]
	if TraceMap.MechanismList ~= nil then
		TraceMap.MechanismList[mNpcID] = args[3]
	end
	CS_SendTraceInfo( copyScene, TraceTypeTb.MecState, args ) --����׷����Ϣ
	return true
end

-- ��������״̬����(Ŀǰinternal use)
-- args:
--	[1] ��ͼ���
--	[2] ������
--  [3] ��������״̬  0 �������Ч 1 �������Ч 
local function CS_TrapValidProc(copyScene,args)
	----look("CS_TrapValidProc")
	if copyScene == nil or args == nil or #args ~= 3 then return end
	local mSerialNum = args[1]
	local trapID = args[2]
	local TraceMap = copyScene.TraceList[mSerialNum]
	if TraceMap.TrapList ~= nil then
		TraceMap.TrapList[trapID] = args[3]
	end	
	
	-- ע��������¼�
	local fbID = copyScene.fbID
	local mainID ,subID = GetSubID(fbID)
	
	local MapInfo = uv_FBConfig[mainID][subID].MapList[mSerialNum]
	local TrapPos = MapInfo.TrapPos
	if TrapPos == nil or TrapPos[trapID] == nil then return end
	local TrapType = TrapPos[trapID][5] or 2
	if args[3] == 1 then
		local DynmicSceneMap = copyScene.DynamicSceneGIDList[mSerialNum]
		local dynamicMapGID = DynmicSceneMap.dynamicMapGID
		
		uv_Trapinfo[2]=TrapPos[trapID][2]
		uv_Trapinfo[3]=TrapPos[trapID][3]
		uv_Trapinfo[4]=dynamicMapGID
		if TrapType == 2 then
			PI_MapTrap(TrapType,uv_Trapinfo,10005,TrapPos[trapID][4],trapID)
		else
			PI_MapTrap(TrapType,uv_Trapinfo,TrapPos[trapID][6],TrapPos[trapID][4],trapID)
		end
	end
	CS_SendTraceInfo( copyScene, TraceTypeTb.TrapState, args ) --����׷����Ϣ
	return true
end

-- �����������鴦��(Ŀǰinternal use)
-- args:
--	[1] ��ͼ���
--	[2] ����ID
local function CS_StoryProc(copyScene,args)
	----look("CS_StoryProc")
	if copyScene == nil or args == nil or #args ~= 2 then return end
	local mSerialNum = args[1]
	local StoryID = args[2]
	
	-- ----look(StoryID)
	-- SendStoryData(StoryID)
	-- -- ���;���ID��ǰ̨
	CS_SendTraceInfo( copyScene, TraceTypeTb.StoryBegin, StoryID ) 
	-- �Ƿ���Ҫ������ұ���״̬ �����ھ�����ʾʱ���������
	return true
end

-- ��������Ʒ����(Ŀǰinternal use)
-- args:
--	[1] ��ͼ���
--	[2] x
-- 	[3] y
--	[4] ��Ʒ�б�{{��ƷID,��Ʒ����},{��ƷID,��Ʒ����}}
--	[5] ��Ʒ�б�{{��Ʒtype,��Ʒ����},{��Ʒtype,��Ʒ����}}
local function CS_GiveItemsProc(copyScene,args)
	----look("CS_GiveItemsProc")
	-- if copyScene == nil or args == nil or #args ~= 4 then return end
	if copyScene == nil or args == nil then return end
	local mSerialNum = args[1]
	local itemlist = args[4]
	local itemrand_type = args[5]
	if itemlist == nil or type(itemlist) ~= type({}) then
		return
	end
	local DynmicSceneMap = copyScene.DynamicSceneGIDList[mSerialNum]
	local iCount = 0 
	local x,y,mapGID = CI_GetCurPos()
	for _, v in pairs(itemlist) do
		CreateGroundItem(0,DynmicSceneMap.dynamicMapGID,v[1],v[2],args[2],args[3],iCount)
		iCount = iCount + 1
	end
	local rCount = 0
	local randnum = 0
	if itemrand_type ~= nil and type(itemrand_type) == type({}) then
		for i, v in pairs(itemrand_type) do
			if type(v) == type({}) then
				for _, u in pairs(v) do
					if type(u) == type({}) then
						for j = 1, u[2] do
							if type(u[1]) == type(0) then
								randnum = math_random(#giveitem_conf[i][u[1]])
								CreateGroundItem(0,DynmicSceneMap.dynamicMapGID,giveitem_conf[i][u[1]][randnum],1,args[2],args[3],rCount)
								rCount = rCount + 1
							end
						end
					end
				end
			end
		end
	end
	return true
end

-- ������ʱ��������(Ŀǰinternal use)
-- args:
--	[1] ��ʱ�����
local function CS_TimerProc(copyScene,args)
	local TimerID
	local cancel = 0
	if type(args) == type(0) then
		TimerID = args
	elseif type(args) == type({}) then
		TimerID = args[1]
		cancel = 1
	end
	if TimerID == nil then return end
	local fbID = copyScene.fbID
	local mainID ,subID = GetSubID(fbID)
	local EventList = uv_FBConfig[mainID][subID].EventList
	if EventList.Timers == nil or EventList.Timers[TimerID] == nil then
		return
	end
	if cancel == 1 then		-- ȡ����ʱ��
		if copyScene.Timers and copyScene.Timers[TimerID] then
			ClrEvent(copyScene.Timers[TimerID])
			CS_SendTraceInfo( copyScene, TraceTypeTb.ClrTimer, TimerID )
		end
		return
	end
	local t = EventList.Timers[TimerID]
	if copyScene.TraceList ~= nil and copyScene.TraceList.Timers ~= nil then
		local TimersEvent = copyScene.TraceList.Timers[TimerID]		
		if TimersEvent ~= nil and TimersEvent.num ~= nil then						
			if TimersEvent.num > 0 and t.timer and t.timer > 0 then
				copyScene.Timers[TimerID] = SetEvent( t.timer, nil, 'SI_cs_timer', fbID, copyScene.CopySceneGID, TimerID )	
			end
		end
	end
end

-- ������ʱ��������(Ŀǰinternal use)
-- args: ��ͼ���
 
local function CS_JumpMapProc(copyScene,args,variant)
	if copyScene == nil or args == nil then return end
	local fbID = copyScene.fbID
	local copySceneConfig = GetCSConfig(fbID)
	if copySceneConfig == nil then return end
	if copyScene.DynamicSceneGIDList[args] == nil then
		CS_LoadScene(copyScene, copySceneConfig, args, fbID)
	end
	local sid = variant
	if CS_PutPlayerTo(copySceneConfig, sid, args, 1, copyScene) ~= true then
		----look('Put player to copy scene failed',1)
	else
		local pCSTemp = CS_GetPlayerTemp(sid)
		pCSTemp.mSerialNum = args				
	end
	CS_SendTraceInfo( copyScene, TraceTypeTb.JumpMap, copyScene.TraceList ) 
end

-- timeCost ʱ�仨��(not use)
local function CS_GetStarLv( timeCost,StarLvTime)
	if timeCost == nil then
		return 0
	end
	if timeCost < StarLvTime * 0.2 then
		return 5
	elseif timeCost < StarLvTime * 0.4 then
		return 4
	elseif timeCost < StarLvTime * 0.6 then
		return 3
	elseif timeCost < StarLvTime * 0.8 then
		return 2
	elseif timeCost < StarLvTime * 1.0 then
		return 1
	else
		return 1
	end
end

-- ���¸��������Ǽ�(not use)
local function CS_SetStarLv(sid,fbID,timeCost,StarLvTime)
	-- if sid == nil or timeCost == nil or StarLvTime == nil then
		-- return
	-- end
	-- local mainID,subID = GetSubID(fbID)
	-- local pCSData = CS_GetPlayerData(sid)
	-- if pCSData == nil then return end
	-- pCSData.star = pCSData.star or {}
	-- local oldStarLv = CS_GetStarLv(pCSData.star[fbID],StarLvTime)
	-- local starLv = CS_GetStarLv(timeCost,StarLvTime)
	-- if pCSData.star[fbID] == nil or timeCost < pCSData.star[fbID] then
		-- pCSData.star[fbID] = timeCost
		-- local addStar = starLv - oldStarLv
		-- if addStar < 0 then addStar = 0 end
		-- local oldPos = tablelocate(uv_FBConfig[mainID].StarAward, pCSData.Astar, 1) or 0		
		-- pCSData.Astar = (pCSData.Astar or 0) + addStar
		-- local newPos = tablelocate(uv_FBConfig[mainID].StarAward, pCSData.Astar, 1) or 0
		-- if newPos > oldPos then
			-- PI_UpdateScriptAtt(sid,ScriptAttType.StarLv,uv_FBConfig[mainID].StarAward[newPos])
		-- end
	-- end
	
	-- -- ���µ�ǰ��������
	-- local csList = CS_GetDataList()
	-- if csList[fbID] == nil or timeCost < csList[fbID][2] then
		-- csList[fbID] = csList[fbID] or {}
		-- local name = CI_GetPlayerData(5,2,sid)
		-- csList[fbID][1] = name
		-- csList[fbID][2] = timeCost
	-- end
end

-- ����������(internal use)
local function CS_OnProcAward( sid )
	--look('CS_OnProcAward',1)
	local pCSData = CS_GetPlayerData(sid)
	--look(pCSData,1)
	if pCSData == nil or pCSData.Awd == nil then
		return
	end
	--look('CS_OnProcAward11')
	local award = pCSData.Awd.Award	
	local ret = SendLuaMsg( sid, { ids = cs_awards, res = 1, fbID = pCSData.Awd.fbID, awardInfo = award }, 10 )	
	if award == nil or table_maxn(award) <= 0 then	
		----look('pCSData.Awd = nil')
		pCSData.Awd = nil
	end
end

-- ������ɴ���(internal use)
function CS_Complete( copyScene, result )
	--look('----CS Complete--------' .. tostring(result))	
	
	--ȡ����ʱ
 	if copyScene.Timers ~= nil and type(copyScene.Timers) == type({}) then
 		----look('�����ʱ��')
		for _, timer in pairs(copyScene.Timers) do
			ClrEvent(timer)
		end		
	end
	
	-- local timeCost = GetServerTime() - copyScene.startTime
	-- look('timeCost��'..timeCost)
	
	local fbID = copyScene.fbID
	local mainID ,subID = GetSubID(copyScene.fbID)

	local copySceneConfig = uv_FBConfig[mainID][subID]
	if copySceneConfig == nil then
		-- rfalse('uv_FBConfig������')
		return
	end		
	local csType = GetCSType(fbID)
	if csType == CSTypeTb.CS_twone then
		result = false
	end
	-- ������� ������
	if result == true then
		for sid in pairs(copyScene.PlayerSIDList) do
			if type(sid) == type(0) then								
				-- ȡ����������Ϣ(�Ǽ�Ӧ������ɺ�͸����������ڲ����ڽ������洦����)
				-- if copySceneConfig.StarLvTime then
					-- CS_SetStarLv(sid,fbID,timeCost,copySceneConfig.CSAwards.StarLvTime)
				-- end
				local pCSData = CS_GetPlayerData(sid)			
				-- �������������µ�ǰ����
				if csType == CSTypeTb.CS_ZYT then
					pCSData.cZYT = math_max(fbID,pCSData.cZYT or 0)
				-- �����¸�����ɴ���
				elseif csType == CSTypeTb.CS_SCNormal or csType == CSTypeTb.CS_SCHero then
					sctx_succ(sid,fbID)
				-- ����ֵ�������½���
				elseif csType == CSTypeTb.CS_LL then
					pCSData.pro = pCSData.pro or {}
					pCSData.pro[csType] = math_max(fbID,pCSData.pro[csType] or 0)
				-- ���︱�����½���
				elseif csType == CSTypeTb.CS_ZQZB then
					pCSData.pro = pCSData.pro or {}
					pCSData.pro[csType] = math_max(fbID,pCSData.pro[csType] or 0)
				-- װ�����Ǹ������½���
				elseif csType == CSTypeTb.CS_Equip then
					pCSData.pro = pCSData.pro or {}
					pCSData.pro[csType] = math_max(fbID,pCSData.pro[csType] or 0)
				-- ��ʯ����11111	
				elseif csType == CSTypeTb.CS_Jewel then
					pCSData.pro = pCSData.pro or {}
					pCSData.pro[csType] = math_max(fbID,pCSData.pro[csType] or 0)
				-- ͭǮ����111
				elseif csType == CSTypeTb.CS_Money then
					pCSData.pro = pCSData.pro or {}
					pCSData.pro[csType] = math_max(fbID,pCSData.pro[csType] or 0)
				--Ԫ�񸱱�1111
				elseif csType == CSTypeTb.CS_YuanShen then
					pCSData.pro = pCSData.pro or {}
					pCSData.pro[csType] = math_max(fbID,pCSData.pro[csType] or 0)
					local curtype = pCSData.pro[csType]%17000
					--��ý����ʹ洢��ս��������λ��
					yuanshen_getaward(sid,curtype,1)
				--��������
				elseif csType == CSTypeTb.CS_sl_hard then
					sl_fbsucc(sid,fbID,1)
				--������
				elseif csType == CSTypeTb.CS_sl_easy then
					sl_fbsucc(sid,fbID)
				-- �����
				elseif csType == CSTypeTb.CS_XTG then
					-- ��������������ݺ͸�������
					-- xtg_data_deal(sid)
					-- pCSData.pro = pCSData.pro or {}
					-- pCSData.pro[csType] = math_max(fbID,pCSData.pro[csType] or 0)
				end
				-- ������Ϣ,���״�ͨ�ؽ������ڽ�������������½���
				--look("FBAwardTable.Award",1)
				local ret = uv_CommonAwardTable.AwardProc(sid,copySceneConfig.CSAwards,pCSData,nil,fbID)				
				-- ���ͽ�����Ϣ
				CS_OnProcAward( sid )

				--�״�ͨ�ظ������ȸ���,�����ڽ�����������ٸ���,��Ȼ����ȡ�����ݲ���
				if csType == CSTypeTb.CS_lianyu then--��������,����������
					pCSData.pro = pCSData.pro or {}
					pCSData.pro[csType] = math_max(fbID,pCSData.pro[csType] or 0)
				
					local usetime=GetServerTime()-  (copyScene.startTime or 0)
					lianyu_updataworlddata(sid,fbID,usetime)
				elseif csType == CSTypeTb.CS_YJDQ then
					pCSData.pro = pCSData.pro or {}
					pCSData.pro[csType] = math_max(fbID,pCSData.pro[csType] or 0)
					yjdq_on_complete(sid,copyScene)
				end
				
			end
		end
	else	-- ����ʧ�� ֪ͨǰ̨�˳�����
		for sid in pairs(copyScene.PlayerSIDList) do
			if type(sid) == type(0) then
				-- if csType == CSTypeTb.CS_SCNormal or csType == CSTypeTb.CS_SCHero then
					-- sctx_endfail(sid,fbID)
				-- end
				SendLuaMsg( sid, { ids = cs_awards, res = 0, fbID = fbID }, 10 )
				SetEvent(5,nil,'SI_PutPlayerBack',sid,copyScene.CopySceneGID)
			end
		end	
	end	
end

-- ����ʧ�ܴ�����(Ŀǰinternal use)
-- args:

local function CS_FailedProc(copyScene,args)
	--look('CS_FailedProc',2)
	CS_Complete(copyScene,false)
end

-- ������ɴ�����(Ŀǰinternal use)
-- args:

local function CS_CompletionProc(copyScene,args)
	CS_Complete(copyScene,true)
end

-- �����Զ��崦����(Ŀǰinternal use)
-- args: 
--	func �Զ��庯����
--	param �Զ������
local function CS_UserDefineProc(copyScene,args)
	if copyScene == nil or args == nil then return end	
	if type(args) == type({}) and args.func ~= nil then
		local func = _G[args.func]
		if type(func) == TP_FUNC then
			func(copyScene,args.param)
		end
	end
end

--  ֪ͨ����������뿪��Ϣ(internal use)
local function CS_NoticeOtherPlayer()
	--local teamID = CI_GetPlayerData(12)
	--if teamID == 0 then return end
	local sid = CI_GetPlayerData(17)
	local copyScene = CS_GetCopyScene(sid)
	if copyScene == nil then return end
	if copyScene.PlayerSIDList == nil or #copyScene.PlayerSIDList == 1 then return end	
	-- �����㲥
	-- local _,_,_,mapGID = CI_GetCurPos()
	-- local info =  GetStringMsg(170,CI_GetPlayerData(3)) 
	-- if mapGID and mapGID > 0 then
		-- RegionRPC(mapGID,"ShowMsg",info,0,2)
	-- end
end

-- ִ��TuiChuFB(internal use)
local function CS_Exit(sid)
	-- CS_NoticeOtherPlayer()						--֪ͨ�������������
	CS_DelPlayerTempData( sid )	--ɾ��������ʱ����
end

-- ������ͨ������֪ͨ�ͻ������ظ�����壩(internal use)
-- ǰ̨Ҫ���ȷ���Ϣ���ٴ��ͳ�ȥ
local function CS_Back( sid )				
--	look('CS_Back',2)
	SendLuaMsg( sid, { ids = cs_progress , progress = 3 }, 10 )
	local rx, ry, rid, mapGID = CI_GetCurPos(2,sid)
--	look(mapGID,2)
	if not mapGID then return end
	GI_ExitToPrePos(sid)
end

-- ��鵥�������ӿ� ��ȷ���Ƿ��ǵ�ǰ��� ������ò�Ҫ�õ�ǰ���(internal use)
local function CS_CheckPlayer(sid, copySceneConfig, fbID)	
	if sid == nil or copySceneConfig == nil or fbID == nil then
		return 1
	end
	
	-- ȡ��Ҹ�������
	local pCSTemp = CS_GetPlayerTemp(sid)					
	if pCSTemp == nil then 
		return 2
	end		
	
	local pCSData = CS_GetPlayerData(sid)
	if pCSData == nil then 
		return 2
	end	
	pCSData.pro = pCSData.pro or {}
		
	-- ��鸱���������� �ɵ�������һ������(Ŀǰֻ�ж��˵ȼ�)
	if copySceneConfig.NeedConditions then
		local needlevel = copySceneConfig.NeedConditions.nLevel		
		if needlevel then
			local plevel = CI_GetPlayerData(1,2,sid)
			if plevel < needlevel then
				return 3
			end
		end
		local nType = copySceneConfig.NeedConditions.nVIPType
		if nType then
			local vipType = GI_GetVIPType(sid) or 0
			if vipType < nType then
				return 8
			end
		end
	end		

	-- Check Times(check only)
	if not CS_CheckFBTimes(sid,fbID,1) then		
		return 4
	end

	-- �������ǰ������
	local csType = GetCSType(fbID)
	-- ������ǰ���������
	if csType == CSTypeTb.CS_ZYT then				
		if fbID > 5001 then			
			if pCSData.cZYT == nil or fbID > pCSData.cZYT + 1 then
				return 5
			end
		end
	-- �����¸����������
	elseif csType == CSTypeTb.CS_SCNormal or csType == CSTypeTb.CS_SCHero then		
		local ret = sctx_enter(sid,fbID)
		if not ret then
			return 6
		end
	-- ��������
	elseif csType == CSTypeTb.CS_LL then
		local baseID = csType * 1000 + 1
		if fbID > baseID then
			local curID = pCSData.pro[csType]
			if curID == nil or fbID > curID + 1 then
				return 5
			end
		end
	-- ���︱��
	elseif csType == CSTypeTb.CS_ZQZB then
		local baseID = csType * 1000 + 1
		if fbID > baseID then
			local curID = pCSData.pro[csType]
			if curID == nil or fbID > curID + 1 then
				return 5
			end
		end
	-- ���Ǹ���
	elseif csType == CSTypeTb.CS_Equip then
		local baseID = csType * 1000 + 1
		if fbID > baseID then
			local curID = pCSData.pro[csType]
			if curID == nil or fbID > curID + 1 then
				return 5
			end
		end
	-- ��ʯ����
	elseif csType == CSTypeTb.CS_Jewel then
		local baseID = csType * 1000 + 1
		if fbID > baseID then
			local curID = pCSData.pro[csType]
			if curID == nil or fbID > curID + 1 then
				return 5
			end
		end	
	-- ����lianyu
	elseif csType == CSTypeTb.CS_lianyu then
		local rx, ry, rid, mapGID = CI_GetCurPos()
		if mapGID then 
			TipCenter(GetStringMsg(17))
			return 8
		end
	elseif csType == CSTypeTb.CS_YJDQ then
		local baseID = csType * 1000 + 1
		if fbID > baseID then
			local curID = pCSData.pro[csType]
			if curID == nil or fbID > curID + 1 then
				return 5
			end
		end	
	elseif csType == CSTypeTb.CS_XTG then
		-- �����ǰ���������
		local mainLv = CI_GetFactionInfo(nil,2)
		if mainLv ~= nil then
			if mainLv < 7 then
				look("mainLv = " .. tostring(mainLv))
				TipCenter("���ɵȼ�����")
				return 9
			end
		end
		-- �ж����ʱ��
		local jointime=__G.get_join_factiontime(sid)
		if jointime==nil or GetServerTime()-jointime<24*3600 then
			TipCenter("���ʱ�䲻��24Сʱ�����ܽ��и�����ս")
			return 
		end
		local pCSTemp = CS_GetPlayerTemp(sid)
		-- �ж�����Ƿ��Ѿ��ڵ�ǰ����
		if pCSTemp ~= nil and pCSTemp.CopySceneGID ~= nil and pCSTemp.fbID ~= nil and (pCSTemp.fbID >24000 and pCSTemp.fbID <=25000) then
			TipCenter("���Ѿ�������󸱱���")
			return
		end
		local times_info = GetTimesInfo(sid,TimesTypeTb.CS_XTG)		-- ����ʣ�����
		times = times_info[1] or 0							-- ��������ս����
		if times > 20 then times = 20 end				-- ÿ������2000W
		local needMoney = 1000000 * times			-- ����ͭǮ�� = 100W * n (�ڼ���)
		look("needMoney = " .. tostring(needMoney))
		if not CheckCost(sid,needMoney,0,3,"�����") then
			look("needMoney = " .. tostring(needMoney))
			TipCenter("ͭǮ����")
			return 10
		end
	end
	if escort_not_trans(sid) then 
		return 7
	end
	-- �Զ���������麯��
	if copySceneConfig.nFunc then
		local func = copySceneConfig.nFunc.func
		local args = copySceneConfig.nFunc.args
		if type(_G[func]) == TP_FUNC then
			local ret = _G[func](sid,args)
			if ret ~= true then
				return 99
			end
		end
	end

	return 0
end

-- �����뿪�������ֵ�
local function CS_SetOutPos(sid,Config,copyScene)
	if sid == nil or type(sid) ~= type(0) then return end
	local pData = CS_GetPlayerData(sid)
	if pData == nil then return end
	if Config.BackPos == nil then
		GI_SetPlayerPrePos(sid)
	else
		GI_SetPlayerPrePos(sid,Config.BackPos[1],Config.BackPos[2],Config.BackPos[3])
	end	
	
	return true
end

-- ���븱��
local function CS_DoEnter(sid, copySceneConfig, copyScene)	
	-- Set out pos
	local SPres = CS_SetOutPos(sid,copySceneConfig,copyScene)
	if SPres == nil then
		----look('CS_SetOutPos erro:' .. tostring(sid),1)
		CS_DelPlayerTempData(sid)
		return false
	end			
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp == nil then
		return false
	end
	-- ----look('���븱��------------------------------------')
	-- ----look(pCSTemp)
	if CS_PutPlayerTo(copySceneConfig, sid, 1, 1, copyScene) ~= true then
		----look('Put player to copy scene failed',1)
	else		
		pCSTemp.CopySceneGID = copyScene.CopySceneGID
		pCSTemp.fbID = copyScene.fbID
		pCSTemp.mSerialNum = 1		
		copyScene.PlayerCount = (copyScene.PlayerCount or 0) + 1
		copyScene.PlayerSIDList[sid] = 0	
		-- ��Ӹ���(�����ɫ)
		local csType = GetCSType(copyScene.fbID)
		if csType == CSTypeTb.CS_Multi then
			if copyScene.color == nil then
				copyScene.color = math_random(1,3)
			end
			local color = (copyScene.color % 3) + 1
			copyScene.PlayerSIDList[sid] = color
			copyScene.color = copyScene.color + 1
			local teamID = CI_GetPlayerData(12,2,sid)
			TeamRPC(teamID,"TeamNotice",6,copyScene.PlayerSIDList)
		-- ���޸���������Ӫ
		elseif csType == CSTypeTb.CS_Couple then
			local sex = CI_GetPlayerData(11,2,sid) or 0
			SetCamp(sex+1,2,sid)
			RPCEx(sid,'set_camp',sex+1)
		end
		--��¼���븱��������� ����ÿ�ջ�Ծ �۴���
		CS_CheckFBTimes(sid,copyScene.fbID)
	end

	--cs start.
	SendLuaMsg( sid, { ids = cs_progress, progress = 1, psct = pCSTemp, tracelist = copyScene.TraceList, stime = copyScene.startTime, truns = copyScene.turns }, 10  )		

	return true
end

-- ����ͨ�ÿ�ʼ������
-- Ŀǰֻ����ˢ�� �̶����������ֻ�����101
local function CS_BeginCommonProc(copyScene)	
	local DynmicSceneMap = copyScene.DynamicSceneGIDList[1]
	local monsterListConfig = DynmicSceneMap.MonsterList[101]
	if monsterListConfig ~= nil then
		for _, monsterConfig in pairs(monsterListConfig) do		
			if type(monsterConfig) == type({}) and monsterConfig.monsterId ~= nil then
				monsterConfig.copySceneGID = copyScene.CopySceneGID
				monsterConfig.regionId = DynmicSceneMap.dynamicMapGID					
				local GID = CreateObjectIndirect(monsterConfig)
				
				if GID and monsterConfig.EventID and monsterConfig.eventScript and monsterConfig.eventScript > 0 then
					----look("�����������:" .. monsterConfig.eventScript)
					MonsterRegisterEventTrigger( monsterConfig.regionId, GID, MonsterEvents[monsterConfig.eventScript])
				end
			end
		end
	end
end

function SI_cs_timer(fbID,copySceneGID,TimerID)
	if fbID == nil or copySceneGID == nil or TimerID == nil then return end
	local copyScene = CS_GetTemp( copySceneGID )
	if copyScene==nil then		
		return
	end
	local mainID ,subID = GetSubID(fbID)
	local copySceneConfig = uv_FBConfig[mainID][subID]
	if copySceneConfig == nil then
		return 
	end
	local EventList = copySceneConfig.EventList
	if EventList == nil then 
		return
	end
	if copyScene.Timers and copyScene.Timers[TimerID] then
		copyScene.Timers[TimerID] = nil
	end
	if copyScene.TraceList ~= nil and copyScene.TraceList.Timers ~= nil then
		local TimersEvent = copyScene.TraceList.Timers[TimerID]		
		if TimersEvent ~= nil and TimersEvent.num ~= nil and TimersEvent.num ~= 0 then
			TimersEvent.num = TimersEvent.num - 1			
			local mControl = EventList.Timers[TimerID].num - TimersEvent.num	-- ȡ�õ�ǰ���ﲨ��
			CS_EventProc(copyScene.CopySceneGID,EventList.Timers[TimerID].EventTb,mControl)
			if TimersEvent.num > 0 and EventList.Timers[TimerID].timer then
				copyScene.Timers[TimerID] = SetEvent( EventList.Timers[TimerID].timer, nil, 'SI_cs_timer', fbID, copyScene.CopySceneGID, TimerID )	
			end
		end
	end
	
	-- CS_EventProc(copySceneGID,{{EventTypeTb.TimerTrigger, timerID}})
end

-- ������ʼ
function OnCSStart( fbID, copySceneGID )
	--rfalse('������ʼ.'..taskid)
	--look('������ʼ',2)
	local copyScene = CS_GetTemp( copySceneGID )
	if copyScene==nil then
	--	look('copyScene==nil when OnCSStart')
		return
	end
	local mainID ,subID = GetSubID(fbID)
	local copySceneConfig = uv_FBConfig[mainID][subID]
	if copySceneConfig == nil then
	--	look('copySceneConfig==nil when OnCSStart')
		CS_RemoveCopySence(CopySceneGID)
		for k, DynmicSceneMap in pairs(copyScene.DynamicSceneGIDList) do
			if type(k) == type(0) and type(DynmicSceneMap) == type({}) then
				CI_DeleteDRegion(DynmicSceneMap.dynamicMapGID,false)
			end
		end	
		return
	end
		
	-- ���鴦��
	if copySceneConfig.StoryID ~= nil then
		CS_StoryProc(copyScene,{1,copySceneConfig.StoryID})
	end
	
	-- ���ÿ�ʼͨ�ô�����
	CS_BeginCommonProc(copyScene)
	
	-- �����Զ��忪ʼ����
	--look(csBeginProcTb,2)
	if type(csBeginProcTb) == type({}) then
		local func = csBeginProcTb[fbID]
		if type(func) == TP_FUNC then
		--	look('fb BeginProc:' .. fbID)
			func(fbID,copyScene)
		end
	end	
		
	-- ��ʱ������
	if copySceneConfig.EventList.Timers ~= nil then
		local csTimers = copySceneConfig.EventList.Timers
		if copyScene.Timers == nil then
			copyScene.Timers = {}
		end
		for k, v in pairs(csTimers) do
			if type(v.preTime) == type(0) then		-- ������ʼ����׼��ʱ���¼�				
				--look('-----------------111111111')
				copyScene.Timers[k] = SetEvent( v.preTime, nil, 'SI_cs_timer', fbID, copySceneGID, k )
			end
		end
	end		
end

-- �����¼��б� ��Ҫ�ڼ��ظ�����ͼ֮���ʼ��
local function CS_LoadEvents(sid,copySceneConfig,copyScene)	
	copyScene.TraceList = {}
	if copySceneConfig.EventList then
		for k, v in pairs(copySceneConfig.EventList) do
			if k ~= '' and type(v) == type({}) then
				copyScene.TraceList[k] = {}
				for n, t in pairs(v) do
					if type(n) == type(0) and type(t) == type({}) then							
						if t.num then
							copyScene.TraceList[k][n] = {num = t.num}
						end
					end
				end					
			end
		end
	end	
	return true
end

-- �������� ���س���
local function CS_LoadAll(sid, fbID)
	local copySceneConfig = GetCSConfig(fbID)
	if copySceneConfig == nil then
		return
	end

	-- Get copysence data.
	local pCSTemp = CS_GetCopySceneInfo( fbID )
	if pCSTemp == nil then
		return
	end
	local copyScene = CS_GetTemp(pCSTemp.CopySceneGID)
	if copyScene==nil or copyScene.CopySceneGID == nil then
		--look('invalid CopySceneGID',1)
		CS_DelPlayerTempData(sid)
		return
	end

	-- Load Event
	local LEres = CS_LoadEvents(sid,copySceneConfig,copyScene)
	if LEres == nil then
		--look('CS_LoadEvents erro',1)
		CS_DelPlayerTempData(sid)
		return
	end

	-- load Scene ���ص�һ�ŵ�ͼ
	local LSres = CS_LoadScene(copyScene, copySceneConfig, 1, fbID)
	if LSres == nil then 
		--look('CS_LoadScene error',1)
		CS_DelPlayerTempData(sid)
		CS_RemoveCopySence(pCSTemp.CopySceneGID)
		for k, DynmicSceneMap in pairs(copyScene.DynamicSceneGIDList) do
			if type(k) == type(0) and type(DynmicSceneMap) == type({}) then
				CI_DeleteDRegion(DynmicSceneMap.dynamicMapGID,false)
			end
		end	
		return
	end
	
	return copyScene.CopySceneGID
end

-- ���븱��������
local function CS_EnterProc(sid,fbID,roomInfo)
	-- ��ȡ��������
	--look('CS_EnterProc...')
	local copySceneConfig = GetCSConfig(fbID) 				
	if copySceneConfig == nil then
		return false
	end		
	--look('CS_EnterProc.1111')
	-- �ж�����Ƿ��Ѿ��ڵ�ǰ����(ֻ��Ҫ�ж�fbID�Ƿ���Ⱦ�����)
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp and pCSTemp.fbID and pCSTemp.fbID == fbID then
		return false
	end
	-- �������� ���س���
	local CopySceneGID = CS_LoadAll(sid, fbID)
	if CopySceneGID == nil then
		CS_DelPlayerTempData(sid)
		return false
	end
	
	--look("CS_LoadAll success " .. CopySceneGID)
		
	local copyScene = CS_GetTemp(CopySceneGID)
	if copyScene==nil or copyScene.CopySceneGID == nil then
	--	look("copyScene==nil " .. CopySceneGID)
		CS_DelPlayerTempData(sid)
		return false
	end
	-- ��ʼʱ�������������λ��Ϊֻ��DoEnter�ᷢ��Ϣ��ǰ̨
	copyScene.startTime = GetServerTime() 
	-- ����������� ���븱�� �������ֵ��˺Ͷ��˸���
	if roomInfo == nil then
		CS_DoEnter(sid, copySceneConfig, copyScene)
	else
		for pid, _ in pairs(roomInfo) do
			if pid ~= '' and type(pid) == type(0) then
				CS_DoEnter(pid, copySceneConfig, copyScene)
			end
		end
	end
	--look("CS_DoEnter success")

	-- ���û��һ�����������븱����ɾ����ǰ����
	if copyScene.PlayerCount == 0 then
	--	look('copyScene.PlayerCount == 0')
		CS_DelPlayerTempData(sid)
		CS_RemoveCopySence(copyScene.CopySceneGID)
		for k, DynmicSceneMap in pairs(copyScene.DynamicSceneGIDList) do
			if type(k) == type(0) and type(DynmicSceneMap) == type({}) then
				CI_DeleteDRegion(DynmicSceneMap.dynamicMapGID,false)
			end
		end	
		return
	end	
	
--	look("OnCSStart")
	
	-- ������ʼ
	local csType = GetCSType(copyScene.fbID)
	if csType == CSTypeTb.CS_twone then--����������������
		twone_firstin( sid,copyScene.fbID, copyScene.CopySceneGID)--��������
	else
		OnCSStart(copyScene.fbID, copyScene.CopySceneGID)
	end
end

-- �������
local function CS_JoinTeam(sid,roomLV,leaderSID,pass,bInvite)
	--look("CS_JoinTeam:" .. roomLV .. "__" .. leaderSID)
	if sid == nil or roomLV == nil or leaderSID == nil or sid == leaderSID then
		return 99
	end
	-- 1��check room
	local roomlist = CS_GetRoomListTemp()
	if roomlist == nil or roomlist[roomLV] == nil or roomlist[roomLV][leaderSID] == nil then 
		-- SendLuaMsg( 0, { ids=cs_joinroom,res = 1,leaderSID = leaderSID}, 9 )		-- ���䲻����
		return 1
	end		
	
	local roomInfo = roomlist[roomLV][leaderSID]
	local fbID = roomInfo.fbID
	local copySceneConfig = GetCSConfig(fbID)
	if copySceneConfig == nil then
		return 99
	end

	local csType = GetCSType(fbID)
	if csType == CSTypeTb.CS_CoupleChallenge then
		if GetCoupleSID(sid) ~= leaderSID then
			return 7
		end
	end
	
	-- 2��Check Times
	if not CS_CheckFBTimes(sid,fbID,1) then
		-- SendLuaMsg( 0, { ids=cs_joinroom,res = 2}, 9 )	-- ��������
		return 2
	end
	
	-- 3��Check PlayerCount		
	if roomInfo.PlayerCount >= (copySceneConfig.MaxPlayer or 3) then
		-- SendLuaMsg( 0, { ids=cs_joinroom,res = 3,leaderSID = leaderSID}, 9 )		-- ��������
		return 3
	end
	
	-- 4��Check Room
	local pCSTemp = CS_GetPlayerTemp(pid)
	if pCSTemp and pCSTemp.roomdata then
		-- SendLuaMsg( 0, { ids=cs_joinroom,res = 4}, 9 )		-- ���з���
		return 4
	end
	if roomlist[roomLV][sid] then
		-- SendLuaMsg( 0, { ids=cs_joinroom,res = 4}, 9 )		-- ���з���
		return 4
	end
	
	-- 5��check password
	if roomInfo.password and bInvite == nil then
		if pass == nil or pass ~= roomInfo.password then
			return 5
		end
	end
			
	-- 6��join team
	local ret = AskJoinTeam(sid,leaderSID)
	if ret == false then
	--	look("AskJoinTeam:" .. tostring(ret))
		return 6
	end
	
	local pCSTemp = CS_GetPlayerTemp(sid)
	pCSTemp.roomdata = pCSTemp.roomdata or {}
	pCSTemp.roomdata[1] = roomLV
	pCSTemp.roomdata[2] = leaderSID
	
	roomInfo.PlayerCount = (roomInfo.PlayerCount or 0) + 1
	roomInfo[sid] = 0
	-- SendLuaMsg( 0, { ids=cs_joinroom,res = 0,roomLV = roomLV,leaderSID = leaderSID,rminfo = roomInfo}, 9 )
	
	return 0,roomInfo
end

-- ���˸����Ľ���ǰ��� ֻ����׼����������Ϊ׼��ʱ�Ѿ��ж��˶�Ա�����н�������
local function CS_CheckEnter( sid,copySceneConfig, roomInfo )
	-- local teamID = CI_GetPlayerData(12)
	-- look(copySceneConfig.MaxPlayer)
	if copySceneConfig.MaxPlayer == nil or copySceneConfig.MaxPlayer <= 1 then
		--look("CS_CheckEnter erro 1")
		return false
	end	
	-- -- [1]leader check
	-- local bLeader = CI_GetPlayerData(13)
	-- if bLeader == 0 then
		-- look("CS_CheckEnter erro 2")
		-- return false
	-- end
	-- -- [2]max members check
	-- local teamInfo = GetTeamInfo()
	-- if teamInfo == nil or type(teamInfo) ~= type({}) or #teamInfo > copySceneConfig.MaxPlayer then
		-- look("CS_CheckEnter erro 3")
		-- return false
	-- end
	--  ����Ƿ�������׼�����
	for pid, state in pairs(roomInfo) do
		if type(pid) == type(0) and type(state) == type(0) then
			if state == nil or state == 0 then
			--	look("CS_CheckEnter erro 4")
				return false
			end
		end
	end
	return true
end

-- �����¼�������(external use)
function CS_EventProc(copySceneGID,EventTb,variant)
	if EventTb == nil then return end
	local copyScene = CS_GetTemp( copySceneGID )
	if copyScene == nil then return end
	local fbID = copyScene.fbID
	local mainID,subID = GetSubID(fbID)
	if uv_FBConfig[mainID] == nil or uv_FBConfig[mainID][subID] == nil then return end
	local ret
	-- v[1] �¼����� v[2] ������
	for k, v in ipairs(EventTb) do
		--look("CS_EventProc:" .. "__" .. v[1])
		if v[1] == EventTypeTb.MonRefresh then
			ret = CS_MonRefreshProc(copyScene,v[2],variant)
		elseif v[1] == EventTypeTb.MonAttack then
			ret = CS_MonAttackProc(copyScene,v[2],variant)
		elseif v[1] == EventTypeTb.DynBlock then
			ret = CS_DynBlockProc(copyScene,v[2],variant)
		elseif v[1] == EventTypeTb.Mechanism then
			ret = CS_MechanismProc(copyScene,v[2],variant)
		elseif v[1] == EventTypeTb.TrapValid then
			ret = CS_TrapValidProc(copyScene,v[2],variant)
		elseif v[1] == EventTypeTb.Story then
			ret = CS_StoryProc(copyScene,v[2],variant)
		elseif v[1] == EventTypeTb.GiveItems then
			ret = CS_GiveItemsProc(copyScene,v[2],variant)
		elseif v[1] == EventTypeTb.TimerTrigger then
			ret = CS_TimerProc(copyScene,v[2],variant)
		elseif v[1] == EventTypeTb.JumpMap then
			ret = CS_JumpMapProc(copyScene,v[2],variant)
		elseif v[1] == EventTypeTb.Lights then
			ret = CS_LightsProc(copyScene,v[2],variant)			
		elseif v[1] == EventTypeTb.Failed then
			ret = CS_FailedProc(copyScene,v[2],variant)			
		elseif v[1] == EventTypeTb.Completion then
			ret = CS_CompletionProc(copyScene,v[2],variant)
		elseif v[1] == EventTypeTb.UserDefined then
			ret = CS_UserDefineProc(copyScene,v[2],variant)
		end
	end	
end

-- ȡ�ý���(external use)
function CS_DoAward( sid )
	--look('CS_DoAward')		
	local pCSData = CS_GetPlayerData(sid)
	if pCSData == nil or pCSData.Awd == nil then		
		return
	end	
	-- ���轱��
	local award = pCSData.Awd.Award
	local getok = award_check_items(award)
	if not getok then
		return
	end
	--look(award)
	local ret = GI_GiveAward(sid,award,"��������")
	local fbID = pCSData.Awd.fbID
	-- ��Ӹ���֪ͨ����	
	if GetCSType(fbID) == CSTypeTb.CS_Multi then
		local teamID = CI_GetPlayerData(12)
		if teamID ~= nil and teamID ~= 0 then
			TeamRPC(teamID,"TeamNotice",3, CI_GetPlayerData(5,2,sid), award[3])
		end
	end
	pCSData.Awd = nil
	
	SendLuaMsg( sid, { ids = cs_progress, progress = 2, fbID = fbID }, 10 )	
end

-- ���͸���������Ϣ
function CS_SendTraceInfo( copyScene, iType, args )
	if copyScene == nil or iType == nil then
		return
	end	
	for sid, _ in pairs(copyScene.PlayerSIDList) do
		if sid ~= '' then
			if iType == TraceTypeTb.StoryBegin then	-- ���;����ʱ�������(��������Ӧ�ö��Ǵ���1000000��)
				LockPlayer( 60000, sid )
			end
			SendLuaMsg( sid, { ids = cs_tips , iType = iType, args = args }, 10 )
		end
	end	
end

-- ���˸�������
function CS_RequestEnter (playerid,fbID)
	-- look("")
	if playerid == nil or playerid == 0 then
		return
	end	
		
	look("fbID:" .. fbID)
	local copySceneConfig = GetCSConfig(fbID) 				-- ��ȡ��������
	if copySceneConfig == nil then
		return false
	end		
	
	-- ��鸱�����������ʹ��� �������жԵ��˵ļ�� �������������
	local check = CS_CheckPlayer( playerid, copySceneConfig, fbID )
	----look('check' .. tostring(check))
	if check ~= 0 then
		SendLuaMsg( playerid, { ids = cs_check, ck = check }, 10 )
		return
	end
	
	-- look("CS_EnterProc")
	-- ���븱��������
	CS_EnterProc(playerid,fbID)
end

-- ������Ӹ��� C++�ص�
--[[ 
�����������:
	1�������޶��ھ��ǵ�ͼ
	2������ж��������¡��ж��Ƿ����ж�Ա���ھ��ǳ�����������������򴴽�����֪ͨ���ж�Ա��������UI
	3����������Ա�뿪���ǳ�����ǰ̨���˳����䴦��(���۶ӳ����߶�Ա)
	4���ж��������¶ӳ����ܴ�������
]]--
function CS_CreateTeam(sid,fbID,roomLV,password)
	----look("CS_CreateTeam",2)
	local roomlist = CS_GetRoomListTemp()
	if roomlist == nil then 
		return 
	end
	local copySceneConfig = GetCSConfig(fbID)
	if copySceneConfig == nil then
		return
	end	
	
	-- [1] common Check 
	local check = CS_CheckPlayer( sid, copySceneConfig, fbID )
	if check ~= 0 then
		SendLuaMsg( sid, { ids = cs_check, ck = check }, 10 )
		return
	end
	
	-- [3] check team leader
	local teamID = CI_GetPlayerData(12)
	----look("teamID:" .. teamID,2)
	if teamID and teamID ~= 0 then
		local bLeader = CI_GetPlayerData(13)
		if bLeader and bLeader == 0 then
			SendLuaMsg( 0, { ids=cs_ctroom,res = 3}, 9 )		-- �ж���ȴ���Ƕӳ����ܴ�������
			return
		end
	end	
	-- ��ȡ�����Ϣ
	local TeamInfo = GetTeamInfo()		
		
	-- [4] check room
	if roomlist[roomLV] == nil then
		roomlist[roomLV] = {}
	end
	
	if roomlist[roomLV][sid] then
		SendLuaMsg( 0, { ids=cs_ctroom,res = 4}, 9 )		-- ���з��䲻�ܴ�������
		return
	end
	
	-- [5] ���޸������
	local csType = GetCSType(fbID)
	if csType == CSTypeTb.CS_Couple then
		local fName = CI_GetPlayerData(69,2,sid)
		if type(fName) ~= type('') then
			SendLuaMsg( 0, { ids=cs_ctroom,res = 4}, 9 )		-- û�н�鲻�ܿ������޸���
			return
		end
		-- �ж��Ƿ��Ƿ������
		if type(TeamInfo) == type({}) then
			
		end
	elseif csType == CSTypeTb.CS_CoupleChallenge then
		------look('������Ӹ������',2)
		local fName = CI_GetPlayerData(69,2,sid)
		if type(fName) ~= type('') then
			SendLuaMsg( 0, { ids=cs_ctroom,res = 5}, 9 )		-- û�н�鲻�ܿ������޸���
			return
		end
	
		-- �ж��Ƿ��Ƿ������
		if type(TeamInfo) == type({}) then
			
		end
	end 
			
	local pCSTemp = CS_GetPlayerTemp(sid)
	pCSTemp.roomdata = {roomLV,sid}
	roomlist[roomLV][sid] = {
		leaderName = CI_GetPlayerData(5,2,sid),
		fbID = fbID,
		PlayerCount = 1,
		password = password,
		[sid] = 1,
	}
	local roomInfo = roomlist[roomLV][sid]	
	if TeamInfo then
		for _,v in pairs(TeamInfo) do			
			if v.staticId ~= nil and v.staticId ~= sid then
				roomInfo[v.staticId] = 0
				roomInfo.PlayerCount = roomInfo.PlayerCount + 1
				local pidTemp = CS_GetPlayerTemp(v.staticId)
				pidTemp.roomdata = pidTemp.roomdata or {}
				pidTemp.roomdata[1] = roomLV
				pidTemp.roomdata[2] = sid
			end
		end
		if teamID and teamID ~= 0 then
			TeamRPC(teamID,"TeamNotice",5,roomLV,sid,roomInfo)
		end
	end
	----look('CS_CreateTeam over')
	SendLuaMsg( 0, { ids=cs_ctroom,res = 0,roomLV = roomLV}, 9 )	
end

-- ���ټ���
function CS_FastJoin(sid,roomLV,leaderSID,fbID,pass,bInvite)
	if sid == nil or roomLV == nil then return end
	local roomlist = CS_GetRoomListTemp()
	if roomlist == nil then return end
	local bFind = false
	local ret
	local roomInfo
	if leaderSID == nil then	-- ���ټ���
		if roomlist[roomLV] and fbID then
			for k, _ in pairs(roomlist[roomLV]) do
				if type(k) == type(0) then
					ret,roomInfo = CS_JoinTeam(sid,roomLV,k)
					if ret == 0 then
						leaderSID = k
						bFind = true
						break
					elseif ret == 2 then		-- ��������ֱ���˳�
						break
					end
				end
			end
		end
		if not bFind and ret ~= 2 then
			CS_CreateTeam(sid,fbID,roomLV)
			return
		end
	else
		ret,roomInfo = CS_JoinTeam(sid,roomLV,leaderSID,pass,bInvite)		
	end
	SendLuaMsg( 0, { ids=cs_joinroom,res = ret,roomLV = roomLV,leaderSID = leaderSID,rminfo = roomInfo}, 9 )		-- ���䲻����
end

-- �ܾ�����
function CS_Refuse(sid,othersid)
	if IsPlayerOnline(othersid) then
		RPCEx(othersid,'Ref_Invite',1,CI_GetPlayerData(3,2,sid))
	end
end

-- �뿪����
-- ����Ƕӳ��뿪���顢ǰ̨��֪ͨ��ʣ���Ա�뿪����
function CS_QuitTeam(sid,name,roomLV,leaderSID)
	----look("CS_QuitTeam:" .. tostring(name) .. '__' .. tostring(roomLV))
	local roomlist = CS_GetRoomListTemp()
	if roomlist == nil or roomlist[roomLV] == nil or roomlist[roomLV][leaderSID] == nil then 
		SendLuaMsg( 0, { ids=cs_quitroom,res = 1}, 9 )
		return 
	end
		
	local roomInfo = roomlist[roomLV][leaderSID]
	local pid = GetPlayer(name)
	if pid == nil or roomInfo[pid] == nil then 
		SendLuaMsg( 0, { ids=cs_quitroom,res = 2}, 9 )
		return 
	end
	-- �ӳ��˳�ֱ��ɾ��������Ϣ
	if pid == leaderSID then
		for k, v in pairs(roomInfo) do
			if type(k) == type(0) and type(v) == type({}) then
				local pCSTemp = CS_GetPlayerTemp(pid)
				pCSTemp.roomdata = nil
				roomInfo[k] = nil
				roomInfo.PlayerCount = roomInfo.PlayerCount - 1
			end						
		end
		roomlist[roomLV][leaderSID] = nil
		local teamID = CI_GetPlayerData(12,2,leaderSID)
		if teamID and teamID ~= 0 then
			TeamRPC(teamID,"TeamNotice",4)		-- ֪ͨ��Ա�ر����
		end
		DeleteTeamMember(leaderSID,name)	
	else
		local pCSTemp = CS_GetPlayerTemp(pid)
		pCSTemp.roomdata = nil
		roomInfo[pid] = nil
		roomInfo.PlayerCount = roomInfo.PlayerCount - 1
		if roomInfo.PlayerCount == 0 then
			roomlist[roomLV][leaderSID] = nil
		end
		DeleteTeamMember(leaderSID,name)
		SendLuaMsg( pid, { ids=cs_quitroom,res = 0}, 10 )
	end
end

-- �����ɢ����ʱû����Ҫ����ģ�
function OnReleaseTeam( teamID )
	--rfalse('--�����ɢ')
end

-- ��Ӹ��� ��ҵ��׼����ť �����鲢�ж�����
-- ����Ƕӳ����ǿ�ʼ
function CS_OnTeamProc(sid,roomLV,leaderSID)		
	-- ��ȡ��Ӹ����б�
	local roomlist = CS_GetRoomListTemp()
	if roomlist == nil or roomlist[roomLV] == nil or roomlist[roomLV][leaderSID] == nil then 
		return
	end
	-- ������Ƿ����������
	local roomInfo = roomlist[roomLV][leaderSID]
	if roomInfo[sid] == nil then
		return
	end
	local fbID = roomInfo.fbID
	local copySceneConfig = GetCSConfig(fbID) 				-- ��ȡ��������
	if copySceneConfig == nil then
		return
	end
	
	local csType = GetCSType(fbID)
	if csType == CSTypeTb.CS_CoupleChallenge then
		if sid == leaderSID then
			if roomInfo.PlayerCount ~= 2 then
				SendLuaMsg( sid, { ids = cs_check, ck = 10 }, 10 )
				return
			end
		else
			if GetCoupleSID(sid) ~= leaderSID then
				SendLuaMsg( sid, { ids = cs_check, ck = 11 }, 10 )
				return
			end
		end
	end 
	
	local teamID = CI_GetPlayerData(12)
	----look("fbID:" .. fbID)
	-- ����Ƕӳ� ���ǿ�ʼ
	if leaderSID == sid then
		if not CS_CheckEnter(sid, copySceneConfig, roomInfo) then
			return
		end
		CS_EnterProc(sid,fbID,roomInfo)
		roomlist[roomLV][leaderSID] = nil
		if teamID and teamID ~= 0 then
			TeamRPC(teamID,"TeamNotice",2)
		end
	else
		-- ����Ƕ�Ա ���������� ����׼����־
		local check = CS_CheckPlayer( sid, copySceneConfig, fbID)
		if check ~= 0 then
			SendLuaMsg( sid, { ids = cs_check, ck = check }, 10 )
			return
		end
		----look("TeamNotice")
		if roomInfo[sid] == 1 then
			roomInfo[sid] = 0
		else
			roomInfo[sid] = 1
		end
		if teamID and teamID ~= 0 then
			TeamRPC(teamID,"TeamNotice",1,sid,roomInfo[sid])
		end
	end
	
end

-- ���÷�������
function CS_SetRoomKey( sid, roomLV, password )
	local roomlist = CS_GetRoomListTemp()
	if roomlist == nil or roomlist[roomLV] == nil or roomlist[roomLV][sid] == nil then 
		----look("roomlist == nil")
		return
	end
	local roomInfo = roomlist[roomLV][sid]
	roomInfo.password = password	
end

-- ������ѽ�����
function CS_InvitePlayer(sid, pName)
	local roomlist = CS_GetRoomListTemp()
	if roomlist == nil then 
		----look("roomlist == nil")
		return
	end
	local pCSTemp = CS_GetPlayerTemp(sid)
	local friendSID = GetPlayer(pName)
	if friendSID == nil then
		-- ��Ҳ�����
		TipCenter(GetStringMsg(7))
		return
	end
	if pCSTemp.roomdata ~= nil then
		local roomLV = pCSTemp.roomdata[1]
		local leaderSID = pCSTemp.roomdata[2]
		if sid == leaderSID then		-- �ӳ���������
			if roomlist[roomLV][leaderSID] ~= nil then
				SendLuaMsg( friendSID, { ids=cs_invite,roomLV = roomLV,leaderSID = sid,name = CI_GetPlayerData(5,2,sid),fbID = roomlist[roomLV][sid].fbID}, 10 )
			end
		end		
	end
end

-- ������ӷ����б�
function CS_SendRoomList( sid, roomLV )
	local roomlist = CS_GetRoomListTemp()
	if roomlist == nil then 
		rfalse("roomlist == nil")
		return
	end

	local ret = SendLuaMsg( 0, { ids=cs_roomlist,roomLV = roomLV,rmlist = roomlist[roomLV]}, 9 )
	if ret >= 1000 then	
		----look(roomlist[roomLV],1)
		Log('cs_roomlist.txt',roomlist[roomLV])
	end
end

-- ����ͬ�������������
function CS_OnLineProc(sid)
	local roomlist = CS_GetRoomListTemp()
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp == nil then return end
	-- �������Ӹ������� ���ͷ�����Ϣ
	if pCSTemp.roomdata ~= nil then
		local roomLV = pCSTemp.roomdata[1]
		local leaderSID = pCSTemp.roomdata[2]
		if roomlist and roomlist[roomLV] and roomlist[roomLV][leaderSID] then
			SendLuaMsg( sid, { ids=cs_joinroom,res = 0,roomLV = roomLV,leaderSID = leaderSID,rminfo = roomlist[roomLV][leaderSID]}, 10 )
		else
			pCSTemp.roomdata = nil
		end
	end
	-- ����ڸ��� ���͸�����Ϣ
	if pCSTemp.CopySceneGID ~= nil and pCSTemp.fbID ~= nil then
		local copyScene = CS_GetCopyScene(sid)
		if copyScene then 
			SendLuaMsg( sid, { ids = cs_progress, progress = 1, psct = pCSTemp,tracelist = copyScene.TraceList, stime = copyScene.startTime, truns = copyScene.turns, plist = copyScene.PlayerSIDList }, 10  )		
		end
	end
	
	-- ����н��� ���ͽ�����Ϣ
	local pCSData = CS_GetPlayerData(sid)
	if pCSData.Awd ~= nil then
		----look('CS_OnLineProc CS_OnProcAward')
		CS_OnProcAward(sid)
	end	
end

-- �������ߴ���(�������䴦��)
function CS_OutLineProc(sid)
	local roomlist = CS_GetRoomListTemp()
	local pCSTemp = CS_GetPlayerTemp(sid)
	-- �˳����䴦��
	if pCSTemp and pCSTemp.roomdata then
		local roomLV = pCSTemp.roomdata[1]
		local leaderSID = pCSTemp.roomdata[2]
		if roomlist and roomlist[roomLV] and roomlist[roomLV][leaderSID] then
			CS_QuitTeam(sid,CI_GetPlayerData(5),roomLV,leaderSID)	-- �˳�����
		end
	end
	-- ������������(������ܿ���Ӧ�û��ð�)
	if type(roomlist) == type({}) then
		for k, v in pairs(roomlist) do
			if type(k) == type(0) and type(v) == type({}) then
				if v[sid] then
					CS_QuitTeam(sid,CI_GetPlayerData(5),k,sid)	-- �˳�����
				end
			end
		end
	end
	-- �˳���������
	if pCSTemp and pCSTemp.CopySceneGID then
		CS_LeaveFB(sid)
	end
end

-- �����л���������
function CS_OnRegionChange(sid)
	--���и�������look
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp == nil or pCSTemp.CopySceneGID == nil then
		return
	end
	-- ����жϲ�Ҫ��(��Ϊ�͵��˸������Դ�ʱ���������Ѿ���������)
	-- local copyScene = CS_GetTemp( pCSTemp.CopySceneGID )
	-- if copyScene == nil then return end
	-- ����Ǹ�����������ô sceneGID == pCSTemp.CopySceneGID �Ͳ��������������
	local sceneGID = GetCurCopyScenesGID(sid)
	----look('sceneGID:' .. sceneGID,2)
	----look('CopySceneGID:' .. pCSTemp.CopySceneGID,2)
	if sceneGID ~= pCSTemp.CopySceneGID then
		----look('OnRegionChanged CS_DelPlayerTempData')
        CS_DelPlayerTempData( sid )
		-- �����һ����Ϣ ֪ͨǰ̨�����ݹ����
		SendLuaMsg( sid, { ids = cs_progress , progress = 3 }, 10 )
	end
end

-- �����ڸ����
function CS_ReliveProc(sid)
	----look("CS_ReliveProc")
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp.CopySceneGID then
		----look("CS_ReliveProc")
		local mSerialNum = pCSTemp.mSerialNum or 1
		local copyScene = CS_GetTemp(pCSTemp.CopySceneGID)
		local fbID = pCSTemp.fbID
		local copySceneConfig = GetCSConfig(fbID)

		local csType = GetCSType(fbID)
		if csType == CSTypeTb.CS_lianyu then
			CI_OnSelectRelive(1,0*5,2,sid)
		else

			if CS_PutPlayerTo(copySceneConfig, sid, mSerialNum, 1, copyScene,true) ~= true then
				--Ĭ�ϸ����ڸ��������,���������use=1ʱʹ�ø����
			end
		end
	end
end

-- ����ɨ��
function CS_SaoDang(sid,fbID)
	local pCSData = CS_GetPlayerData(sid)
	if pCSData == nil then return end
	local copySceneConfig = GetCSConfig(fbID)
	if copySceneConfig == nil then return end
	local ret = CS_CheckPlayer(sid, copySceneConfig, fbID)
	if ret ~= 0 then		-- ��������
		return
	end
	-- local isby = baoyue_getpower(sid, 4)
	-- if not isby then
		if not CheckCost( sid, 5, 0, 1,'100014_����ɨ��') then
			return
		end
	-- end
	if not CS_CheckFBTimes(sid,fbID) then
		return
	end
	ret = uv_CommonAwardTable.AwardProc(sid,copySceneConfig.CSAwards,pCSData,nil,fbID)				
	-- ���ͽ�����Ϣ
	CS_OnProcAward( sid )
end

-- �����������Ӹ������˳�(���뿪����)(external use)
function CS_LeaveFB(playerSID)
	--look('CS_LeaveFB')
	local sid = playerSID or CI_GetPlayerData(17)	
	-- ��������ݸ���
	xtg_data_deal(sid)
	
	CS_Exit(sid)
	CS_Back(sid)
	return
end

-- �����������⽱������(��ʱ����) 
function cs_award_4001(sid,result,fbID)
	----look('cs_award_4001:' .. tostring(fbID))
	local copyScene = CS_GetCopyScene(sid)
	if copyScene == nil then return end
	if copyScene.fbID ~= fbID then return end
	local turns = copyScene.turns or 0
	if turns > 0 then	
		local wlevel = GetWorldLevel() or 1
		local exps = rint(wlevel^3 + (turns^2) * 1300)
		local num = rint(turns)
		result[2] = exps
		-- result[12] = rint(turns*200)
		if num > 0 then
			result[3] = {{637,num,1}}	--��˵֮ʯ
		end
	end
end

function SI_PutPlayerBack(sid,CopySceneGID)
	--look('SI_PutPlayerBack:' .. tostring(sid),1)
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp == nil or pCSTemp.CopySceneGID == nil then
		return
	end
	--look('SI_PutPlayerBack:1',1)
	-- �����ǰ��û�˳�ȥ����̨ǿ�ƴ���ȥ(��������)
	if CopySceneGID == nil or pCSTemp.CopySceneGID == CopySceneGID then
		--look('SI_PutPlayerBack:2',1)
		CS_LeaveFB(sid)
	end
	local rx,ry,rid,mapGID = CI_GetCurPos(2,sid)
	if mapGID and rid==1044 then --���޸������������ڸ���ǿ���Ƴ�
		----look('���޸������������ڸ���ǿ���Ƴ�',1)
		local res=PI_MovePlayer( 1, 74, 97, nil, 2, sid)
		----look(res,1)
	end
end

function DropItemProc(sid,config,x,y,bprotect)
	----look('DropItemProc')
	if sid == nil or config == nil then return end
	local rx,ry,rid,mapGID = CI_GetCurPos(2,sid)
	local progid
	if bprotect then
		progid = CI_GetPlayerData(16,2,sid)
	end
	local i = 1
	local param = config.item
	if param and not table_empty( param ) then
		local r = math_random(1, 10000)			-- �������Ϊ��ֱ�
		local count = nil		
		for _, itemconf in pairs(param) do
			local chance = itemconf.Rate
			if chance ~= nil and r >= chance[1] and r <= chance[2] then					
				if type(itemconf.CountList) == type({}) then
					count = math_random(itemconf.CountList[1], itemconf.CountList[2])
				else
					count = itemconf.CountList
				end
				----look('mapGID:' .. mapGID)
				----look('itemconf.ItemID:' .. itemconf.ItemID)
				----look(x)
				----look(y)
				----look(progid)
				CreateGroundItem(0,mapGID,itemconf.ItemID,count,x or rx,y or ry,i,progid)
				i = i + 1
			end
		end
	end
	param = config.equip
	if param == nil or type(param) ~= type({}) or table_empty( param ) then return end
	if param.count == nil then return end
	-- 1��ȡ����װ������
	local count = 0
	if type(param.count) == type(0) then
		count = param.count
	elseif type(param.count) == type({}) then
		local rd = math_random(1,10000)
		for k, v in ipairs(param.count) do
			if type(v) == type(0) and rd <= v then
				count = k
				break
			end
		end
	end
	if count == 0 then return end	
	for i = 1, count do
		-- 2��ȡװ���ȼ�
		local eqLV = nil
		if param.eqLV == nil then
			eqLV = CI_GetPlayerData(1,2,sid)
		elseif type(param.eqLV) == type(0) then
			eqLV = param.eqLV
		end
		eqLV = tablelocate(EquipItemInfo, eqLV, 1)
		if eqLV == nil or EquipItemInfo[eqLV] == nil then
			return
		end
		-- 3��ȡװ��Ʒ��
		local quality = nil
		if param.quality == nil then return end
		if type(param.quality) == type(0) then
			quality = param.quality
		elseif type(param.quality) == type({}) then
			local rd = math_random(1,10000)
			for k, v in ipairs(param.quality) do
				if type(v) == type(0) and rd <= v then
					quality = k
					break
				end
			end
		end
		if quality == nil or EquipItemInfo[eqLV][quality] == nil then 
			return
		end
		-- 4��ȡװ��ְҵ
		local school = nil
		if param.school == nil then
			school = CI_GetPlayerData(2,2,sid)
		elseif type(param.school) == type(0) and param.school == 1 then
			school = math_random(1,3)
		end
		if school == nil or EquipItemInfo[eqLV][quality][school] == nil then
			return
		end
		local equipTable = EquipItemInfo[eqLV][quality][school]		-- ����װ���ȼ� Ʒ�� ְҵ��λװ��ID��
		-- 5��ȡװ����λ
		local eqType = nil
		if param.eqType == nil then
			eqType = math_random(1,9)
		elseif type(param.eqType) == type(0) then
			eqType = param.eqType
		elseif type(param.eqType) == type({}) then
			eqType = math_random(param.eqType[1],param.eqType[2])
		end
		if eqType == nil then
			return
		end
		-- 6��ȡװ���Ա�
		local sex = nil
		if param.sex == nil then
			sex = CI_GetPlayerData(11,2,sid)
			if sex == nil then return end
			if eqType == 1 or eqType == 2 then		-- �Ա�ֻ���������Ч
				if sex == 0 then
					eqType = 2
				elseif sex == 1 then
					eqType = 1
				end
			end
		end
		-- 7����λװ��ID
		local equipID = equipTable[eqType]
		-- 8������װ��
		----look('mapGID:' .. mapGID)
		----look('equipID:' .. equipID)
		----look(x)
		----look(y)
		----look(progid)
		CreateGroundItem(0,mapGID,equipID,1,x or rx,y or ry,i,progid)
		i = i + 1		
	end	
end

-- -- �½����ֻ֧��6������
-- local function CS_GetSectionID(fbID)
	-- local mainID,subID = GetSubID(fbID)
	-- local secID = rint(subID / 6)
	-- local num = subID % 6
	-- if num == 0 then num = 6 end
	-- return secID,num
-- end

-- local uv_Kinginfo = {}
-- -- ��ȡ�������ؼ�������Ϣ
-- function CS_GetPassinfo( sid, secID )
	-- local csList = CS_GetDataList()
	-- if csList == nil then return end
	-- local secKing = CS_GetSecKing()
	-- if secKing == nil then return end

	-- local base = 5000 + (secID - 1) * 6
	-- for i = 1, 6 do
		-- local fbID = base + i
		-- uv_Kinginfo[i] = csList[fbID]
	-- end
	-- SendLuaMsg( sid, { ids = cs_passinfo, secID = secID, secking = secKing[secID], king = uv_Kinginfo }, 10 )
-- end

-- -- ��ȡ�½ڹ��ؽ���
-- function CS_GetSecAward(sid,secID)
	-- local pCSData = CS_GetPlayerData(sid)	
	-- if pCSData == nil then return end
	-- if pCSData.secA == nil then
		-- pCSData.secA = {}
	-- end
	-- rfalse("CS_GetSecAward" .. secID)
	-- -- �ж���ȡ����
	-- local maxfbID = 5000 + (secID - 1) * 6 + 6		-- ���½����ĸ���ID
	-- if pCSData.star == nil or pCSData.star[maxfbID] == nil then
		-- -- û��ͨ�ز�����ȡ����
		-- rfalse("CS_GetSecAward no pass")
		-- return
	-- end
	-- if pCSData.secA[secID] == nil then
		-- rfalse("CS_GetSecAward")
		-- if uv_FBConfig[1].SectionAward == nil or uv_FBConfig[1].SectionAward[secID] == nil then return end
		-- local pakagenum = isFullNum()
		-- if pakagenum < 3 then
			-- TipCenter(GetStringMsg(14,3))
			-- return
		-- end
		-- rfalse("CS_GetSecAward")
		-- local _award = uv_FBConfig[1].SectionAward[secID]
		-- GiveGoodsBatch( _award,"ս�۸������")	
		-- pCSData.secA[secID] = 1
	-- end
-- end

-- -- ÿ��ˢ���½ڰ���
-- function CS_RefreshKing()
	-- local csList = CS_GetDataList()
	-- if csList == nil then return end
	-- local secKing = CS_GetSecKing()
	-- if secKing == nil then return end	
	-- for secID = 1, 4 do
		-- local kingName = GetSecKing(secID,csList)
		-- if kingName ~= nil then
			-- secKing[secID] = kingName
		-- end
	-- end	
-- end

-- -- ��ȡ�½ڰ���
-- -- ����1������������������
-- --		 2����������������ͬ���Ը���ID������Ϊ�½ڰ���
-- -- ���������ÿ�յ���һ��������ʱ���ý� tmpKing = {}��Ϊupvalue
-- function GetSecKing(secID,csList)
	-- local tmpKing = {}			-- ��¼��Ϣ {[����] = {���½ڸ�������������������������󸱱�ID}}
	-- local base = 5000 + (secID - 1) * 6
	-- for i = 1, 6 do
		-- local fbID = base + i
		-- if csList[fbID] ~= nil then
			-- local name = csList[fbID][1]
			-- if tmpKing[name] == nil then
				-- tmpKing[name] = {1,fbID}				
			-- else
				-- tmpKing[name][1] = tmpKing[name][1] + 1
				-- if fbID > tmpKing[name][2] then
					-- tmpKing[name][2] = fbID
				-- end
			-- end
		-- end
	-- end
	
	-- -- �½ڰ���
	-- local count = 0
	-- local fbID
	-- local kingName
	-- for name, v in pairs(tmpKing) do
		-- rfalse(name)
		-- rfalse(v[1])
		-- rfalse(v[2])
		-- if v[1] > count then
			-- count = v[1]
			-- kingName = name
			-- fbID = v[2]
		-- elseif v[1] == count then
			-- if v[2] > fbID then
				-- kingName = name
				-- fbID = v[2]
			-- end
		-- end
	-- end

	-- return kingName
-- end

-- -- ��ȡ�Ǽ�����
-- function GetStarAttr(sid)
	-- local pCSData = CS_GetPlayerData(sid)	
	-- if pCSData == nil then return end
	-- if uv_FBConfig[5] and type(uv_FBConfig[5]) == type({}) then
		-- local pos = table.locate(uv_FBConfig[5].StarAward, pCSData.Astar, 1)
		-- if pos then
			-- return uv_FBConfig[5].StarAward[pos]
		-- end
	-- end
	-- return
-- end

-- ֻ��һ���ǳ�Σ�յ�GM���� ��ȥ֮��û���˳� ֻ��/mt ��ȥ �����ڸ�������ˢ�� ����žͷ���
function CS_GMMT(sid,mapID,x,y)
	local pCSTemp = CS_GetCopySceneInfo( 99001 )
	if pCSTemp == nil then
		return
	end
	local copyScene = CS_GetTemp(pCSTemp.CopySceneGID)
	if copyScene==nil or copyScene.CopySceneGID == nil then
		----look('invalid CopySceneGID')
		CS_DelPlayerTempData(sid)
		return
	end

	local dynamicMapGID = PI_CreateRegion( mapID, copyScene.CopySceneGID, 0)
	if not PI_MovePlayer( 0, x, y, dynamicMapGID, 2, sid) then
		----look('PI_MovePlayer err when CS_PutPlayerTo')
	end	
end

--ɨ������
local cssd_conf={
	[13001] = {--����ֵ����1
		name = "��������",--��������
		Price = 10,--ɨ���۸�
		goods={
		[12] = 2700,--Ԥ����Ʒ
		},
	},
	
	[13002] = {--����ֵ����2
		name = "����ɱ��",--��������
		Price = 10,--ɨ���۸�
		goods={
			[12] = 4400,--Ԥ����Ʒ
		},
	},
	
	[13003] = {--����ֵ����3
		name = "����ħ��",--��������
		Price = 10,--ɨ���۸�
		goods={
			[12] = 6000,--Ԥ����Ʒ
		},
	},
	
	[13004] = {--����ֵ����4
		name = "��Ϣ����",--��������
		Price = 10,--ɨ���۸�
		goods={
			[12] = 6500,--Ԥ����Ʒ
		},
	},
	
	[13005] = {--����ֵ����5
		name = "ħ��Ѫ��",--��������
		Price = 10,--ɨ���۸�
		goods={
			[12] = 9000,--Ԥ����Ʒ
		},
	},
	
	[14001] = {--����װ������1
		name = "��ħ��",--��������
		Price = 10,--ɨ���۸�
		goods={
			[3] = {{788,22,1},{789,6,1},},--Ԥ����Ʒ
		},
	},
	
	[14002] = {--����װ������2
		name = "��ԯ��",--��������
		Price = 10,--ɨ���۸�
		goods={
			[3] = {{788,37,1},{789,9,1},{795,1,1}},--Ԥ����Ʒ
		},
	},
	
	[14003] = {--����װ������3
		name = "����",--��������
		Price = 10,--ɨ���۸�
		goods={
			[3] = {{788,52,1},{789,12,1},{795,1,1}},--Ԥ����Ʒ
		},
	},
	
	[14004] = {--����װ������4
		name = "�ɻ긮",--��������
		Price = 10,--ɨ���۸�
		goods={
			[3] = {{788,104,1},{789,24,1},{795,2,1}},--Ԥ����Ʒ
		},
	},
	
	[14005] = {--����װ������5
		name = "������",--��������
		Price = 10,--ɨ���۸�
		goods={
			[3] = {{788,240,1},{789,30,1}},--Ԥ����Ʒ
		},
	},
	
	[16001] = {--װ�����Ǹ���1
		name = "��ͨģʽ",--��������
		Price = 10,--ɨ���۸�
		goods={
			[3] = {{803,15,1}},--Ԥ����Ʒ
		},
	},
	
	[16002] = {--װ�����Ǹ���2
		name = "����ģʽ",--��������
		Price = 10,--ɨ���۸�
		goods={
			[3] = {{803,20,1}},--Ԥ����Ʒ
		},
	},
	[16003] = {--װ�����Ǹ���3
		name = "��Ӣģʽ",--��������
		Price = 10,--ɨ���۸�
		goods={
			[3] = {{803,30,1}},--Ԥ����Ʒ
		},
	},
	
	[16004] = {--װ�����Ǹ���4
		name = "Ӣ��ģʽ",--��������
		Price = 10,--ɨ���۸�
		goods={
			[3] = {{803,120,1}},--Ԥ����Ʒ
		},
	},
	[16005] = {--װ�����Ǹ���5
		name = "����ģʽ",--��������
		Price = 10,--ɨ���۸�
		goods={
			[3] = {{803,300,1}},--Ԥ����Ʒ
		},
	},
}

-----ɨ��
function cs_saodang( sid,fbID )
	-- ----look('ɨ��',1)
	-- ----look(fbID,1)
	local csType=GetCSType(fbID)
	local pCSData = CS_GetPlayerData(sid)
	pCSData.pro = pCSData.pro or {}	
	
	if pCSData.pro[csType]==nil  then return end--û���,����ɨ��
	local needyb=cssd_conf[fbID].Price
	local award=cssd_conf[fbID].goods

	local time_type
	-- ͭǮ����
	if csType == CSTypeTb.CS_Money then
		time_type=uv_TimesTypeTb.CS_Money
	-- ����ֵ�������½���
	elseif csType == CSTypeTb.CS_LL then
		time_type=uv_TimesTypeTb.CS_LL
	-- װ�����Ǹ������½���
	elseif csType == CSTypeTb.CS_Equip then
		time_type=uv_TimesTypeTb.CS_Equip
	-- ��ʯ����11111	
	elseif csType == CSTypeTb.CS_Jewel then
		time_type=uv_TimesTypeTb.CS_Jewel
	-- ���︱�����½���
	elseif csType == CSTypeTb.CS_ZQZB then
		time_type=uv_TimesTypeTb.CS_ZQZB
	end

	-- ----look(111,1)
	if not CheckTimes(sid,time_type,1,-1,1) then
		return false
	end
	-- ----look(444,1)
	if not CheckCost(sid, needyb,1,1,'ɨ��') then
		return
	end
	-- ----look(333,1)
	local getok = award_check_items(award)
	if not getok then
		return
	end
	-- ----look(222,1)
	CheckCost(sid, needyb,0,1,'ɨ��')
	CheckTimes(sid,time_type,1,-1)
	local ret = GI_GiveAward(sid,award,"ɨ��")
	SendLuaMsg( 0, { ids=cs_sd,res = 1,csType = fbID}, 9 )
end

--������ս�������⴦��:һ����ȫ����
function fuqifb_exit( copyScene )
	local fbID = copyScene.fbID
	local csType = GetCSType(fbID)
	if csType == CSTypeTb.CS_CoupleChallenge then
		for sid in pairs(copyScene.PlayerSIDList) do
			if type(sid)==type(0) then
				CS_Exit(sid)
				CS_Back(sid)
			end
		end
	end
end


--�������������������
function lianyu_buytimes(sid)
	local timeinfo=GetTimesInfo(sid,uv_TimesTypeTb.CS_lianyu)
	if timeinfo==nil then return end
	local surplus_time=(timeinfo[3] or 0)+ 1
	local needmoney=surplus_time*500000
	local needexp=surplus_time*500000
	if not CheckCost(sid,needmoney,1,3,'����������������') then
		return 
	end
	local nowexp=CI_GetPlayerData( 4 )
	if nowexp<needexp then  return end

	PI_PayPlayer(1,-needexp,0,0,'����������������')
	CheckCost(sid,needmoney,0,3,'����������������')
	CheckTimes(sid,uv_TimesTypeTb.CS_lianyu,1,1)
end

--������������	������������
local function lianyu_GetwData()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then
		return
	end
	if w_customdata.lianyu == nil then
		w_customdata.lianyu = {
			--[fbid]={},--������� [fbid]={,name,time}
		}
	end
	return w_customdata.lianyu
end
--��ȡ��������������������
function lianyu_getworlddata( sid ,fbid)
	local wdata=lianyu_GetwData()
	if wdata==ni then return end
	SendLuaMsg(0,{ids=cs_ly,data=wdata[fbid],fbid=fbid},9)
end

--������������������������
function lianyu_updataworlddata(sid,fbid,usetime)
	local wdata=lianyu_GetwData()
	if wdata==ni then return end
	wdata[fbid]=wdata[fbid] or {}

	local name=CI_GetPlayerData(5)
	--local school=CI_GetPlayerData(2)
	local res1=insert_scorelist_ex(wdata[fbid],3,usetime,name,fbid,sid,nil,1)
	if res1 then --��������
		BroadcastRPC('LY_up',fbid,usetime,name,sid)
	end
end

