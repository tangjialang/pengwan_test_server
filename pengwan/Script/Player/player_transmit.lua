--[[
file:	player_op.lua
desc:	all client operation request.
author:	chal
update:	2011-12-02
refix: done by chal
]]--

local define		= require('Script.cext.define')
local ProBarType = define.ProBarType
local look = look
local CI_GetPlayerData,CI_GetCurPos = CI_GetPlayerData,CI_GetCurPos
local TipCenter,GetStringMsg = TipCenter,GetStringMsg
local CheckGoods,CI_SetReadyEvent = CheckGoods,CI_SetReadyEvent
local RegionTable = RegionTable
-- 传送处理函数
function OnTransmit()
	local playerid = CI_GetPlayerData(17)
	local pTemp = GetPlayerTemp_custom(playerid)
	if pTemp then
		if pTemp.transD == nil or type(pTemp.transD) ~= type({}) then
			return 0
		end
	end
	
	local vid = pTemp.transD[1]
	local vx = pTemp.transD[2]
	local vy = pTemp.transD[3]
	local t = pTemp.transD[4]
	local val = pTemp.transD[5]

	local rx, ry , r = CI_GetCurPos(playerid)
	local level = CI_GetPlayerData(1)
	if (r == 3 or r == 10 or r == 11) and (vid ~=3 and vid~=10 and vid~=11) then
		local taskData = GetDBTaskData( playerid )
		if taskData.current[1015] == nil and taskData.current[4015] == nil and taskData.current[4035] == nil and level < 35 then
			TipCenter( GetStringMsg(268))
			return 0
		end	
	end

	if t == 1 then
		local vipLv = GI_GetVIPLevel(playerid)
		look(vipLv)
		if vipLv <= 0 then
			if CheckGoods(100,1,0,playerid,'飞行符') == 0 then
				TipCenter(GetStringMsg(240))
				return 0
			end
		end
	elseif t == 3 then
		if not CheckCost( playerid , 5 , 0 , 1, "挖宝传送") then				
			return 0
		end
	end	
	
	local bret = PI_MovePlayer(vid, vx, vy, 0, 2, playerid)
	if bret == false then
		look('PI_MovePlayer false when OnTransmit')
		return 0
	end
	
	return 1
	
end
--: type is not null for world transfer
-- iType: [0] 免费传送 [1] 扣道具(VIP不扣道具) [2] 免费传送且不判断读条 [3] 挖宝传送(扣5元宝、不读条)
-- 这里只检查 回调里面才扣道具
function RequestWorldTransfer( playerid, iType, rid, x, y )
	look('RequestWorldTransfer:'..tostring(iType))
	if playerid == nil or iType == nil or rid == nil or x == nil or y == nil then return end
	if rid >= 500 or RegionTable[rid] == nil then return end
	local putItem
	local level = CI_GetPlayerData(1)
	local LimitLv = RegionTable[rid].level or 0	
	if level < LimitLv then
		TipCenter(GetStringMsg(5))
		return
	else
		if iType == 1 then
			local vipLv = GI_GetVIPLevel(playerid)
			if vipLv <= 0 then
				if CheckGoods(100,1,1,playerid,'飞行符') == 0 then
					TipCenter(GetStringMsg(6))
					return
				end
			end
		elseif iType == 3 then
			if not CheckCost( playerid , 5 , 1 , 1, "挖宝传送") then				
				return
			end
		end
	end
	
	local pTemp = GetPlayerTemp_custom(playerid)
	if pTemp then
		pTemp.transD = pTemp.transD or {}
		pTemp.transD[1] = rid
		pTemp.transD[2] = x
		pTemp.transD[3] = y
		pTemp.transD[4] = iType
	end
		
	-- 检查地图PK类型(玩家等级>= 45才读条)
	local rx, ry, r = CI_GetCurPos()
	if iType < 2  and RegionTable[r] and RegionTable[r].PKType and RegionTable[r].PKType ~= 1 and level >= 40 then		
		local ret = CI_SetReadyEvent(0,ProBarType.trans,2,1,'OnTransmit')		-- 2秒后传送
	else
		OnTransmit()
	end
end
