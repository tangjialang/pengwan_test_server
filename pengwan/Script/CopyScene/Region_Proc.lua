--[[
副本场景相关 by chal
函数说明
CS_LoadScene：			加载副本场景组
OnRegionChanged：		玩家场景切换
CS_OnCheckTerminate：	动态场景删除时回调
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
-- 加载副本场景组
-- 现在这里只会加载一张地图 
-- 1、创建副本地图
-- 2、加载副本NPC
-- 3、注册陷阱点触发事件
-- 4、初始化动态阻挡
function CS_LoadScene(copyScene, copySceneConfig, mSerialNum, fbID)
	-- 加载动态地图组
	local mapConfig = copySceneConfig.MapList[mSerialNum]	
	if mapConfig == nil then
		--look("CS_LoadScene erro")
		return
	end
	
	-- 加载地图	
	local mapIdx = mapConfig.MapID
	--look("mapIdx:" .. mapIdx)
	-- 创建动态场景
	local dynamicMapGID = PI_CreateRegion( mapIdx, copyScene.CopySceneGID, 0)
	if dynamicMapGID == nil then 
		--look("PI_CreateRegion failed" .. tostring(mapIdx))
		return
	end
	-- 初始化场景信息
	copyScene.DynamicSceneGIDList[mSerialNum] = {}	
	local DynmicSceneMap = copyScene.DynamicSceneGIDList[mSerialNum]
	DynmicSceneMap.dynamicMapGID = dynamicMapGID
	-- 加载怪物列表 加这个不影响性能方便查找
	DynmicSceneMap.MonsterList = mapConfig.MonsterList
	
	-- 初始化地图跟踪信息 （机关、陷阱、动态阻挡)
	copyScene.TraceList[mSerialNum] = {}
	local TraceMap = copyScene.TraceList[mSerialNum]
	
	-- 机关类NPC 初始化状态
	TraceMap.MechanismList = tablecopy(mapConfig.MecFlags)			
	-- 加载NPC 副本类NPC
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
	
	-- 注册陷阱点触发回调函数 只注册初始化可用的
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
	-- 初始化动态阻挡表
	TraceMap.BlockList = tablecopy(mapConfig.DynamicsBlock)	
	-- --look(copyScene.TraceList)
	return true
end

-- 把玩家放到副本场景
-- 根据传入序号，决定位置
--默认复活在副本进入点,copyScene=true时且复活点配置use=1时使用复活点
function CS_PutPlayerTo(copySceneConfig, playerSID, mSerialNum, posIdx, copyScene,useRelivePos)
	
	local mapGID = copyScene.DynamicSceneGIDList[mSerialNum].dynamicMapGID
	if mapGID == nil then
		--rfalse('无法找到对应动态场景'..tostring(initPos.DiTuXuHao))
		return false
	end
	if useRelivePos then --死亡复活特殊处理
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

--chal: 这个函数是在场景切换过程中调用的，所以这个里面不能在有任何导致玩家场景转换的行为，否则会导致服务器崩溃。
--场景切换才会调用该接口，所以必然是不同的场景，但如果两个不同的场景配置了相同的场景id，那么场景id
--仍然有可能一样，尽量避免对于不同功能的场景用同一个id的地图
function OnRegionChanged(playerSID,oldRegionID,regionID)
	if oldRegionID == regionID then
		--look("regionID is same when OnRegionChanged")
	end
	-- 切换场景时先统一取消隐身
	CI_SetPlayerData(2,0)	
	-- 活动统一处理接口
	activitymgr:on_regionchange(playerSID)
	
	--夫妻组队副本特殊处理
	if regionID == 1044 then
		cc_begin(playerSID)
	end
	if oldRegionID == 1044 then
		cc_endfail(playerSID)
	end
	
	-- 副本切换场景处理
	CS_OnRegionChange(playerSID)
	if oldRegionID==1 then
		CI_DelBuff(83)--结束巡防状态
	end
	-- 切换场景移除死亡保护buffer
	if RegionTable[regionID] == nil or RegionTable[regionID].dbuf == nil then
		CI_DelBuff(242)
	end
	if oldRegionID == 522  then 		--神创天下切出处理
		sctx_endfail(playerSID)	
	end
	
	if oldRegionID == 528 then 
		
		on_twone_complete(playerSID)
	end

	
	-- 如果老地图是跨服地图新地图不是 就直接传回本服
	if IsSpanServer() and IsSpanMap(oldRegionID) and not IsSpanMap(regionID) then
		CI_LeaveSpanServer(2,playerSID)
	end
end

-- 副本动态场景玩家为0时产生回调
-- 只判断玩家数而不管其他对象，所以随从对象的场景指针必须在场景被删除前重置 - chal崩溃点标记
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