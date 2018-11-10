--[[
file:	����NPC.lua
desc:	�����ھ������⹦�ܵ�NPC���ɼ�/����/����
author:	chal
update:	2011-11-23
]]--
-- �ɼ�NPC�ű�ID��40005
local pairs = pairs
local ipairs = ipairs
local call_npc_click = call_npc_click
local CreateObjectIndirectEx,CI_GetPlayerData = CreateObjectIndirectEx,CI_GetPlayerData
local TraceTypeTb,GetObjectUniqueId = TraceTypeTb,GetObjectUniqueId
local uv_FBConfig,CI_SetReadyEvent = FBConfig,CI_SetReadyEvent
local uv_npclist,rint,CI_UpdateNpcData = npclist,rint,CI_UpdateNpcData
local RemoveObjectIndirectEx = RemoveObjectIndirectEx
local look = look

local function _GetNpcidByUID(controlID)
	local npcid = 0
	if controlID < 801000 then
		npcid = controlID - 100000
	elseif controlID >= 801000 and controlID <= 1100000 then
		npcid = rint((controlID - 100000)/1000) * 1000
	elseif controlID > 1100000 then
		npcid = rint((controlID - 100000)/10000) * 10000
	else
		rfalse("controlID erro")
	end
	return npcid
end

-- ����NPC���ͳһ�ӿ�
call_npc_click[40005] = function ()
	look("OnClick40005")
	local sid = CI_GetPlayerData(17)
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp.CopySceneGID == nil then return end
	local copyScene = CS_GetTemp(pCSTemp.CopySceneGID)
	if copyScene == nil then return end
	local fbID = copyScene.fbID
	local mainID ,subID = GetSubID(fbID)
	local csEventTb = uv_FBConfig[mainID][subID].EventList
	
	-- ����ͳһ�ӿڸ���ControlIDȡNPCID
	local ControlID = GetObjectUniqueId()
	local npcid = _GetNpcidByUID(ControlID)
	if uv_npclist[npcid] == nil then
		return
	end
		
	-- ȡ��ҵ�ǰ���ڸ�����ͼ���
	local mSerialNum =  pCSTemp.mSerialNum
	
	-- ȡ���ص�ǰ״̬ �Ƿ�ɿ���(��������ʼ״̬ Ĭ�Ͽ��Կ���)
	local MechanismList = copyScene.TraceList[mSerialNum].MechanismList
	if MechanismList ~= nil and MechanismList[npcid] ~= nil then
		if MechanismList[npcid] == 0 then
			-- ��ʾ���ɿ���
			look("npcid:" .. npcid .. " ���ɿ���")
			return
		else
			-- ���ؿ���ǰ�����¼�����ʱû����
			look("npcid:" .. npcid)
		end
	end		
	if uv_npclist[npcid].ProgressTips then
		local PBType = uv_npclist[npcid].PBType or 1
		CI_SetReadyEvent( ControlID,PBType,3,0,"CS_OnCollectItem" )
	else
		CS_OnCollectItem(ControlID)
	end	
end
-- �ɼ���ɻص�
function CS_OnCollectItem(ControlID)
	look("CS_OnCollectItem:" .. ControlID)
	local sid = CI_GetPlayerData(17)
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp.CopySceneGID == nil then 
		return 0
	end
	
	local copyScene = CS_GetTemp(pCSTemp.CopySceneGID)
	if copyScene == nil then 
		return 0
	end
	
	local fbID = copyScene.fbID
	local mainID,subID = GetSubID(fbID)
	local csEventTb = uv_FBConfig[mainID][subID].EventList	
	
	local npcid = _GetNpcidByUID(ControlID)
	look("CS_OnCollectItem")
	-- ���ؿ��������¼�
	if copyScene.TraceList ~= nil and copyScene.TraceList.MecOpens ~= nil then
		local MecNpcOpen = copyScene.TraceList.MecOpens[npcid]
		if MecNpcOpen ~= nil and MecNpcOpen.num ~= nil and MecNpcOpen.num ~= 0 then
			MecNpcOpen.num = MecNpcOpen.num - 1
			if MecNpcOpen.num == 0 then
				CS_EventProc(pCSTemp.CopySceneGID,csEventTb.MecOpens[npcid].EventTb)
			end	
			MecNpcOpen[ControlID] = nil
			CS_SendTraceInfo( copyScene, TraceTypeTb.MecOpens, {npcid,MecNpcOpen.num,ControlID} )		--����׷����Ϣ
		end
	end
	
	if uv_npclist[npcid] == nil then
		return 0
	end
	
	local mSerialNum = pCSTemp.mSerialNum
	if uv_npclist[npcid].NoDel then
		-- ���Ƴ���̬NPC ���¿���״̬
		look('CI_UpdateNpcData')
		local ret = CI_UpdateNpcData(2,true,6,ControlID)		-- �Ѳɼ�
		look(ret)
	else
		-- �Ƴ���̬NPC		
		local DynmicSceneMap = copyScene.DynamicSceneGIDList[mSerialNum]
		local dynamicMapGID = DynmicSceneMap.dynamicMapGID
		RemoveObjectIndirectEx(1,dynamicMapGID,npcid)
	end
			
	return 1
end

------------------------------------------------------------------
--interface:

GetNpcidByUID = _GetNpcidByUID
