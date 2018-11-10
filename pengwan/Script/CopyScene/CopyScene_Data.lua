--[[
file:	CopySence_Data.lua
desc:	副本数据管理
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

-- 初始化临时副本池
local function GetCopyScenePoolTemp()
	dbMgr.CopySceneDataPool.temp = dbMgr.CopySceneDataPool.temp or {
		CopySceneList = {},			-- 当前副本列表
		RoomList = {},				-- 多人副本房间列表
		__IDG = 0,					-- 副本GID
	}
	return dbMgr.CopySceneDataPool.temp
end

-- 获得副本列表
local function _CS_GetCSListTemp()
	local CSPoolTemp = GetCopyScenePoolTemp()
	return CSPoolTemp.CopySceneList
end

-- 获取组队副本列表
local function _CS_GetRoomListTemp()
	local CSPoolTemp = GetCopyScenePoolTemp()
	return CSPoolTemp.RoomList
end

-- 获得副本数据
local function _CS_GetTemp(ID)
	local copySceneList = _CS_GetCSListTemp()
	return copySceneList[ID]
end

-- 删除副本数据
local function _CS_RemoveCopySence(GID)
	-- look('_CS_RemoveCopySence')
	-- look(debug.traceback())
	if type(GID) == type(0) then
		local copySceneList = _CS_GetCSListTemp()
		copySceneList[GID] = nil
	end
end

-- 生成新副本
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
		-- startTime = 0，		-- 副本开始时间
		-- getm = 0,			-- 铜钱副本获得钱数
	}
	return gid
end



----------------------------------------------------[[玩家副本数据相关]]--------------------------------------------
-- 获得玩家副本临时数据
-- CopySceneGID 副本GID
-- fbID			副本ID
-- mSerialNum	当前副本地图序号
-- roomdata		房间信息
local function _CS_GetPlayerTemp(playerSID) 			
	local CopySceneData=GI_GetPlayerTemp(playerSID,'csTP')
	if CopySceneData==nil then return end
	return CopySceneData
end

-- 取得玩家副本保存数据
local function _CS_GetPlayerData(playerSID)	
	local CopySceneData=GI_GetPlayerData( playerSID , 'csDT' , 250 )
	if CopySceneData == nil then return end
	-- if CopySceneData.star==nil then
		-- CopySceneData.Awd = nil 		-- 副本奖励
		-- CopySceneData.cZYT = nil		-- 镇妖塔当前进度
	-- end
	--look(tostring(CopySceneData))
	return CopySceneData
end

-- 删除玩家临时副本数据
local function _CS_RemovePlayer(playerSID)		
	--删除临时数据
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
			copyScene.color = pcol - 1	-- 这样新进来的人就可以补这个颜色了
		end
		copyScene.PlayerSIDList[playerSID] = nil
		copyScene.PlayerCount = (copyScene.PlayerCount or 0) - 1

		--夫妻挑战副本特殊处理:一个退全出来
		fuqifb_exit( copyScene )
	end	
end

--清理玩家副本临时数据。(external use)
local function _CS_DelPlayerTempData( sid )
	--rfalse('清理玩家副本临时数据。')
	if sid==nil then return end
	_CS_RemovePlayer( sid )
end

-- 获取准备进入副本的数据
local function _CS_GetCopySceneInfo( fbID )
	local sid = CI_GetPlayerData(17)
	local pCSTemp = _CS_GetPlayerTemp(sid)

	-- 如果已经进入副本 先删除玩家临时数据
	if pCSTemp.CopySceneGID ~= nil then
		 _CS_DelPlayerTempData( sid )
	end

	-- 创建副本数据 生成副本GID
	local csgid = _CreateCopyScene( fbID )		
	pCSTemp.CopySceneGID = csgid
	pCSTemp.fbID = fbID
	return pCSTemp
end

--获得角色临时副本数据
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