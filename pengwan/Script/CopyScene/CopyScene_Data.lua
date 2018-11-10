--[[
file:	CopySence_Data.lua
desc:	�������ݹ���
author:	csj
update:
]]--

--------------------------------------------------------------------------
--include:
local look,type,tostring = look,type,tostring
local CI_GetPlayerData = CI_GetPlayerData
--------------------------------------------------------------------------
-- data:

--------------------------------------------------------------------------
-- inner function:

-- ��ʼ����ʱ������
local function GetCopyScenePoolTemp()
	dbMgr.CopySceneDataPool.temp = dbMgr.CopySceneDataPool.temp or {
		CopySceneList = {},			-- ��ǰ�����б�
		RoomList = {},				-- ���˸��������б�
		__IDG = 0,					-- ����GID
	}
	return dbMgr.CopySceneDataPool.temp
end

-- ��ø����б�
local function _CS_GetCSListTemp()
	local CSPoolTemp = GetCopyScenePoolTemp()
	return CSPoolTemp.CopySceneList
end

-- ��ȡ��Ӹ����б�
local function _CS_GetRoomListTemp()
	local CSPoolTemp = GetCopyScenePoolTemp()
	return CSPoolTemp.RoomList
end

-- ��ø�������
local function _CS_GetTemp(ID)
	local copySceneList = _CS_GetCSListTemp()
	return copySceneList[ID]
end

-- ɾ����������
local function _CS_RemoveCopySence(GID)
	-- look('_CS_RemoveCopySence')
	-- look(debug.traceback())
	if type(GID) == type(0) then
		local copySceneList = _CS_GetCSListTemp()
		copySceneList[GID] = nil
	end
end

-- �����¸���
local function _CreateCopyScene( fbID )
	local CSPoolTemp = GetCopyScenePoolTemp()
	CSPoolTemp.__IDG = CSPoolTemp.__IDG + 1
	local gid = CSPoolTemp.__IDG

	local copySceneList = _CS_GetCSListTemp()
	copySceneList[gid] = {
		CopySceneGID = gid,
		fbID = fbID,
		DynamicSceneGIDList={},	
		PlayerSIDList = {},
		TraceList = {},
		PlayerCount = 0,
		-- startTime = 0��		-- ������ʼʱ��
		-- getm = 0,			-- ͭǮ�������Ǯ��
	}
	return gid
end



----------------------------------------------------[[��Ҹ����������]]--------------------------------------------
-- �����Ҹ�����ʱ����
-- CopySceneGID ����GID
-- fbID			����ID
-- mSerialNum	��ǰ������ͼ���
-- roomdata		������Ϣ
local function _CS_GetPlayerTemp(playerSID) 			
	local CopySceneData=GI_GetPlayerTemp(playerSID,'csTP')
	if CopySceneData==nil then return end
	return CopySceneData
end

-- ȡ����Ҹ�����������
local function _CS_GetPlayerData(playerSID)	
	local CopySceneData=GI_GetPlayerData( playerSID , 'csDT' , 250 )
	if CopySceneData == nil then return end
	-- if CopySceneData.star==nil then
		-- CopySceneData.Awd = nil 		-- ��������
		-- CopySceneData.cZYT = nil		-- ��������ǰ����
	-- end
	--look(tostring(CopySceneData))
	return CopySceneData
end

-- ɾ�������ʱ��������
local function _CS_RemovePlayer(playerSID)		
	--ɾ����ʱ����
	local pCSTemp = _CS_GetPlayerTemp(playerSID)
	local CopySceneGID = pCSTemp.CopySceneGID
	if pCSTemp ~= nil then		
		pCSTemp.CopySceneGID = nil	
		pCSTemp.fbID = nil	
		pCSTemp.mSerialNum = nil
		pCSTemp.roomdata = nil
		pCSTemp.skills = nil
		pCSTemp.vip_c = nil
		pCSTemp.vip_c2 = nil
		pCSTemp.exp_c = nil
	end
	
	local copyScene = _CS_GetTemp( CopySceneGID )
	if copyScene ~= nil then
		local pcol = copyScene.PlayerSIDList[playerSID]
		if pcol and pcol >= 1 then
			copyScene.color = pcol - 1	-- �����½������˾Ϳ��Բ������ɫ��
		end
		copyScene.PlayerSIDList[playerSID] = nil
		copyScene.PlayerCount = (copyScene.PlayerCount or 0) - 1

		--������ս�������⴦��:һ����ȫ����
		fuqifb_exit( copyScene )
	end	
end

--������Ҹ�����ʱ���ݡ�(external use)
local function _CS_DelPlayerTempData( sid )
	--rfalse('������Ҹ�����ʱ���ݡ�')
	if sid==nil then return end
	_CS_RemovePlayer( sid )
end

-- ��ȡ׼�����븱��������
local function _CS_GetCopySceneInfo( fbID )
	local sid = CI_GetPlayerData(17)
	local pCSTemp = _CS_GetPlayerTemp(sid)

	-- ����Ѿ����븱�� ��ɾ�������ʱ����
	if pCSTemp.CopySceneGID ~= nil then
		 _CS_DelPlayerTempData( sid )
	end

	-- ������������ ���ɸ���GID
	local csgid = _CreateCopyScene( fbID )		
	pCSTemp.CopySceneGID = csgid
	pCSTemp.fbID = fbID
	return pCSTemp
end

--��ý�ɫ��ʱ��������
local function _CS_GetCopyScene(sid)
	local pCSTemp = _CS_GetPlayerTemp(sid)
	if pCSTemp == nil or pCSTemp.CopySceneGID==nil then 
		return nil
	end	
	return CS_GetTemp(pCSTemp.CopySceneGID)
end

-------------------------------------------------------------------------
--interface:

--CS_GetCSListTemp = _CS_GetCSListTemp
CS_GetRoomListTemp = _CS_GetRoomListTemp
CS_GetTemp = _CS_GetTemp
CS_RemoveCopySence = _CS_RemoveCopySence
--CreateCopyScene = _CreateCopyScene
CS_GetPlayerTemp = _CS_GetPlayerTemp
CS_GetPlayerData = _CS_GetPlayerData
CS_GetCopySceneInfo = _CS_GetCopySceneInfo
CS_GetCopyScene = _CS_GetCopyScene
CS_DelPlayerTempData = _CS_DelPlayerTempData