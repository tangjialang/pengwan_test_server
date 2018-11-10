--[[
file: item.lua
desc: 升星副本
author: zld
]]--

-----------------------------------------------------
--include:

local CS_GetPlayerTemp = CS_GetPlayerTemp
local CI_GetPlayerData = CI_GetPlayerData
local CI_AddBuff = CI_AddBuff
local RPC = RPC
local RPCEx = RPCEx

------------------------------------------------------
--inner:

local buff_conf = {
	[1] = 114,
	[2] = 115,
	[3] = 116,
	[4] = 117,
}

local function _itemfb_useskill( sid, buff_idx, mon_gid )
	if sid == nil or buff_idx == nil or mon_gid == nil then return end
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp == nil then return end
	local copyScene = CS_GetTemp(pCSTemp.CopySceneGID)
	if copyScene == nil then return end	
	local needscore = 50
	if (copyScene.score or 0) < needscore then--积分不足
		RPC('it_useskill', buff_idx)
		return
	end
	copyScene.score = (copyScene.score or 0) - needscore--扣积分
	local ret = CI_AddBuff(buff_conf[buff_idx], 0, 1, false, 4, mon_gid)
	look(ret)
	
	-- 同步积分
	if sid > 0 then
		RPC('it_score', copyScene.score)
	end
	
	-- RPC('it_useskill',0,buff_idx)
end

-- 怪物死亡 发消息通知前台
cs_monster_dead[8001] = function( mapGID, copySceneGID )
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then
		return
	end
	copyScene.score = (copyScene.score or 0) + 10--击杀一个怪加10点积分
	local sid = CI_GetPlayerData(17)
	if sid and sid > 0 then
		RPCEx(sid,'it_score',copyScene.score)
	end
end
cs_monster_dead[8002] = function( mapGID, copySceneGID )
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then
		return
	end
	copyScene.score = (copyScene.score or 0) + 10--击杀一个怪加10点积分
	local sid = CI_GetPlayerData(17)
	if sid and sid > 0 then
		RPCEx(sid,'it_score',copyScene.score)
	end
end
cs_monster_dead[8003] = function( mapGID, copySceneGID )
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then
		return
	end
	copyScene.score = (copyScene.score or 0) + 10--击杀一个怪加10点积分
	local sid = CI_GetPlayerData(17)
	if sid and sid > 0 then
		RPCEx(sid,'it_score',copyScene.score)
	end
end
cs_monster_dead[8004] = function( mapGID, copySceneGID )
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then
		return
	end
	copyScene.score = (copyScene.score or 0) + 10--击杀一个怪加10点积分
	local sid = CI_GetPlayerData(17)
	if sid and sid > 0 then
		RPCEx(sid,'it_score',copyScene.score)
	end
end
cs_monster_dead[8005] = function( mapGID, copySceneGID )
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then
		return
	end
	copyScene.score = (copyScene.score or 0) + 10--击杀一个怪加10点积分
	local sid = CI_GetPlayerData(17)
	if sid and sid > 0 then
		RPCEx(sid,'it_score',copyScene.score)
	end
end
cs_monster_dead[8006] = function( mapGID, copySceneGID )
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then
		return
	end
	copyScene.score = (copyScene.score or 0) + 10--击杀一个怪加10点积分
	local sid = CI_GetPlayerData(17)
	if sid and sid > 0 then
		RPCEx(sid,'it_score',copyScene.score)
	end
end
cs_monster_dead[8007] = function( mapGID, copySceneGID )
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then
		return
	end
	copyScene.score = (copyScene.score or 0) + 10--击杀一个怪加10点积分
	local sid = CI_GetPlayerData(17)
	if sid and sid > 0 then
		RPCEx(sid,'it_score',copyScene.score)
	end
end

-------------------------------------------------------------
--interface:
itemfb_useskill = _itemfb_useskill
