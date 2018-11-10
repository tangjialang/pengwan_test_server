--[[
����������� by chal
����˵��
CS_LoadScene��			���ظ���������
OnRegionChanged��		��ҳ����л�
CS_OnCheckTerminate��	��̬����ɾ��ʱ�ص�
]]--
local pairs,type = pairs,type
local ipairs = ipairs
local CreateObjectIndirectEx = CreateObjectIndirectEx
--local --look = --look
local tablecopy = table.copy
local active_mgr_m = require('Script.active.active_mgr')
local activitymgr = active_mgr_m.activitymgr
local uv_Trapinfo = {0,0,0,0}
--g_DRegionToDelete = g_DRegionToDelete or {}
-- ���ظ���������
-- ��������ֻ�����һ�ŵ�ͼ 
-- 1������������ͼ
-- 2�����ظ���NPC
-- 3��ע������㴥���¼�
-- 4����ʼ����̬�赲
function CS_LoadScene(copyScene, copySceneConfig, mSerialNum, fbID)
	-- ���ض�̬��ͼ��
	local mapConfig = copySceneConfig.MapList[mSerialNum]	
	if mapConfig == nil then
		--look("CS_LoadScene erro")
		return
	end
	
	-- ���ص�ͼ	
	local mapIdx = mapConfig.MapID
	--look("mapIdx:" .. mapIdx)
	-- ������̬����
	local dynamicMapGID = PI_CreateRegion( mapIdx, copyScene.CopySceneGID, 0)
	if dynamicMapGID == nil then 
		--look("PI_CreateRegion failed" .. tostring(mapIdx))
		return
	end
	-- ��ʼ��������Ϣ
	copyScene.DynamicSceneGIDList[mSerialNum] = {}	
	local DynmicSceneMap = copyScene.DynamicSceneGIDList[mSerialNum]
	DynmicSceneMap.dynamicMapGID = dynamicMapGID
	-- ���ع����б� �������Ӱ�����ܷ������
	DynmicSceneMap.MonsterList = mapConfig.MonsterList
	
	-- ��ʼ����ͼ������Ϣ �����ء����塢��̬�赲)
	copyScene.TraceList[mSerialNum] = {}
	local TraceMap = copyScene.TraceList[mSerialNum]
	
	-- ������NPC ��ʼ��״̬
	TraceMap.MechanismList = tablecopy(mapConfig.MecFlags)			
	-- ����NPC ������NPC
	local npclist = npclist
	local npcListConfig = mapConfig.NPCList
	if npcListConfig ~= nil then
		for npcid, info in pairs( npcListConfig ) do
			if type(npcid) == type(0) and type(info) ==type({}) then
				npcConfig = npclist[npcid]
				if npcConfig ~= nil then
					npcConfig.copySceneGID = copyScene.CopySceneGID
					npcConfig.NpcCreate.regionId = dynamicMapGID
					local GID,CID = CreateObjectIndirectEx(1,npcid,npcConfig.NpcCreate,#info,info)
					if copyScene.TraceList.MecOpens ~= nil and copyScene.TraceList.MecOpens[npcid] ~= nil then
						if type(GID) == type(0) and type(CID) == type(0) then
							copyScene.TraceList.MecOpens[npcid][CID] = {info[1][1],info[1][2],GID}
						elseif type(GID) == type({}) and  type(CID) == type({}) then
							for k,controlID in pairs(CID) do								
								copyScene.TraceList.MecOpens[npcid][controlID] = {info[k][1],info[k][2],GID[k]}
							end
						end
					end
				end
			end
		end
	end	

	TraceMap.TrapList = {}
	
	-- ע������㴥���ص����� ֻע���ʼ�����õ�
	if mapConfig.TrapPos ~= nil and type(mapConfig.TrapPos) == type({}) then
		for trapID, v in pairs(mapConfig.TrapPos) do
			if type(trapID) == type(0) and type(v) == type({}) then
				TraceMap.TrapList[trapID] = v[1]
				local TrapType = v[5] or 2
				
				if v[1] == 1 then
					uv_Trapinfo[2]=v[2]
					uv_Trapinfo[3]=v[3]
					uv_Trapinfo[4]=dynamicMapGID
					if TrapType == 2 then
						PI_MapTrap(TrapType,uv_Trapinfo,10005,v[4],trapID)
					else
						PI_MapTrap(TrapType,uv_Trapinfo,v[6],v[4],trapID)
					end										
				end
			end
		end
	end
	-- ��ʼ����̬�赲��
	TraceMap.BlockList = tablecopy(mapConfig.DynamicsBlock)	
	-- --look(copyScene.TraceList)
	return true
end

-- ����ҷŵ���������
-- ���ݴ�����ţ�����λ��
--Ĭ�ϸ����ڸ��������,copyScene=trueʱ�Ҹ��������use=1ʱʹ�ø����
function CS_PutPlayerTo(copySceneConfig, playerSID, mSerialNum, posIdx, copyScene,useRelivePos)
	
	local mapGID = copyScene.DynamicSceneGIDList[mSerialNum].dynamicMapGID
	if mapGID == nil then
		--rfalse('�޷��ҵ���Ӧ��̬����'..tostring(initPos.DiTuXuHao))
		return false
	end
	if useRelivePos then --�����������⴦��
		local RelivePos = copySceneConfig.MapList[mSerialNum].RelivePos
		if RelivePos and RelivePos.use then
			if not PI_MovePlayer( RelivePos[1], RelivePos[2], RelivePos[3], nil, 2, playerSID) then
				return false
			end
			return true
		end
	end

	local initPos = copySceneConfig.MapList[mSerialNum].EnterPos[posIdx]
	if not PI_MovePlayer( 0, initPos.x, initPos.y, mapGID, 2, playerSID) then
		--look('PI_MovePlayer err when CS_PutPlayerTo')
		return false
	end
	return true
end

--chal: ����������ڳ����л������е��õģ�����������治�������κε�����ҳ���ת������Ϊ������ᵼ�·�����������
--�����л��Ż���øýӿڣ����Ա�Ȼ�ǲ�ͬ�ĳ����������������ͬ�ĳ�����������ͬ�ĳ���id����ô����id
--��Ȼ�п���һ��������������ڲ�ͬ���ܵĳ�����ͬһ��id�ĵ�ͼ
function OnRegionChanged(playerSID,oldRegionID,regionID)
	if oldRegionID == regionID then
		--look("regionID is same when OnRegionChanged")
	end
	-- �л�����ʱ��ͳһȡ������
	CI_SetPlayerData(2,0)	
	-- �ͳһ����ӿ�
	activitymgr:on_regionchange(playerSID)
	
	--������Ӹ������⴦��
	if regionID == 1044 then
		cc_begin(playerSID)
	end
	if oldRegionID == 1044 then
		cc_endfail(playerSID)
	end
	
	-- �����л���������
	CS_OnRegionChange(playerSID)
	if oldRegionID==1 then
		CI_DelBuff(83)--����Ѳ��״̬
	end
	-- �л������Ƴ���������buffer
	if RegionTable[regionID] == nil or RegionTable[regionID].dbuf == nil then
		CI_DelBuff(242)
	end
	if oldRegionID == 522  then 		--�������г�����
		sctx_endfail(playerSID)	
	end
	
	if oldRegionID == 528 then 
		
		on_twone_complete(playerSID)
	end

	
	-- ����ϵ�ͼ�ǿ����ͼ�µ�ͼ���� ��ֱ�Ӵ��ر���
	if IsSpanServer() and IsSpanMap(oldRegionID) and not IsSpanMap(regionID) then
		CI_LeaveSpanServer(2,playerSID)
	end
end

-- ������̬�������Ϊ0ʱ�����ص�
-- ֻ�ж��������������������������Ӷ���ĳ���ָ������ڳ�����ɾ��ǰ���� - chal��������
function CS_OnPlayerAllOut(CopySceneGID)
	local copyScene = CS_GetTemp(CopySceneGID)
	if copyScene then
		if type(copyScene.DynamicSceneGIDList) == type({}) then
			local del = true
			for k, v in pairs(copyScene.DynamicSceneGIDList) do
				if type(k) == type(0) then
					local count = GetRegionPlayerCount(v.dynamicMapGID,0) or 0
					if count > 0 then
						del = false
						break
					end
				end
			end
			if del == true then
				CS_RemoveCopySence(CopySceneGID)
			end
		end
	end
end