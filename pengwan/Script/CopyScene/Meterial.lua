--[[
file: Meterial.lua
autor: csj
desc: 材料副本
]]--

local pairs,type = pairs, type
local look = look
local RPCEx = RPCEx
local math_random = math.random
local CI_GetPlayerData = CI_GetPlayerData
local CI_GetCurPos = CI_GetCurPos

local monster_list = {
	[1] = { monsterId = 411,deadbody = 6 },
	[2] = { monsterId = 411,deadbody = 6 },
}

function GI_Meterial_refresh(mapGID,x,y,copySceneGID)
	look('GI_Meterial_refresh')
	if mapGID == nil or copySceneGID == nil then return end
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then
		return
	end
	if copyScene.ksnum and copyScene.ksnum >= 20 then
		look('GI_Meterial_refresh logic erro')
		return
	end
	local DynmicSceneMap = copyScene.DynamicSceneGIDList[1]
	if DynmicSceneMap == nil then return end
	local mon_list
	if DynmicSceneMap.MonsterList then	
		mon_list = DynmicSceneMap.MonsterList[102]		-- 取102波怪
	end
	if mon_list == nil then return end
	local mon_conf	
	local rd  = math_random(1,10000)
	if rd <= 5000 then
		mon_conf = mon_list[1]				
	elseif rd <= 8000 then
		mon_conf = mon_list[2]
	elseif rd <= 10000 then
		mon_conf = mon_list[3]
	end
	mon_conf.copySceneGID = copySceneGID
	mon_conf.regionId = mapGID
	mon_conf.x = x
	mon_conf.y = y
	local GID = CreateObjectIndirect(mon_conf)
	look('mon_gid:' .. tostring(GID))
end

-- 矿石死亡
cs_monster_dead[4002] = function(mapGID, copySceneGID)
	look('cs_monster_dead 4002')
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then
		return
	end
	look('cs_monster_dead 4002')
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then return end
	look('cs_monster_dead 4002')
	local lv = CI_GetPlayerData(1)
	local x,y = CI_GetCurPos(3)
	look('x:' .. x .. ' y:' .. y)
	local rd = math_random(1,10000)
	if rd <= 2000 then		
		local dropn = math_random(1,2)
		for i = 1, dropn do
			CreateGroundItem(0,mapGID,604,1,x,y,i)
		end
	elseif rd <= 4000 then
		local dropn = math_random(1,2)
		for i = 1, dropn do
			CreateGroundItem(0,mapGID,610,1,x,y,i)
		end
	elseif rd <= 6000 then			-- 小怪
		local t = monster_list[1]
		t.copySceneGID = copySceneGID
		t.regionId = mapGID
		t.x = x
		t.y = y
		t.level = lv
		t.monAtt = t.monAtt or {}
		t.monAtt[1] = lv*10000
		t.monAtt[3] = lv*100	
		look(t)
		local GID = CreateObjectIndirect(t)	
		look('GID:' .. tostring(GID))
	elseif rd <= 10000 then			-- Boss
		local t = monster_list[2]
		t.copySceneGID = copySceneGID
		t.regionId = mapGID
		t.x = x
		t.y = y
		t.level = lv
		t.monAtt = t.monAtt or {}
		t.monAtt[1] = lv*20000
		t.monAtt[3] = lv*200
		look(t)
		local GID = CreateObjectIndirect(t)
		look('GID:' .. tostring(GID))
	end
	copyScene.ksnum = (copyScene.ksnum or 0) + 1
	if copyScene.PlayerSIDList then
		for sid in pairs(copyScene.PlayerSIDList) do
			if type(sid) == type(0) then
				RPCEx(sid,'Met_ksnum',copyScene.ksnum)
			end
		end
	end
	if copyScene.ksnum < 20 then
		SetEvent(5,nil,'GI_Meterial_refresh',mapGID,x,y,copySceneGID)
	else
		CI_AddBuff(247,0,1,false,2,sid)	--不能攻击了
	end
end

-- 矿石死亡
cs_monster_dead[4003] = function(mapGID, copySceneGID)
	look('cs_monster_dead 4003')
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then
		return
	end
	look('cs_monster_dead 4003')
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then return end
	look('cs_monster_dead 4003')
	local lv = CI_GetPlayerData(1)
	local x,y = CI_GetCurPos(3)
	look('x:' .. x .. ' y:' .. y)
	local rd = math_random(1,10000)
	if rd <= 2000 then
		look('111')
		local dropn = math_random(2,3)
		for i = 1, dropn do
			CreateGroundItem(0,mapGID,604,1,x,y,i)
		end
	elseif rd <= 4000 then
		look('222')
		local dropn = math_random(1,2)
		for i = 1, dropn do
			CreateGroundItem(0,mapGID,611,1,x,y,i)
		end
	elseif rd <= 6000 then			-- 小怪
		look('333')
		local t = monster_list[1]
		t.copySceneGID = copySceneGID
		t.regionId = mapGID
		t.x = x
		t.y = y
		t.level = lv
		t.monAtt = t.monAtt or {}
		t.monAtt[1] = lv*10000
		t.monAtt[3] = lv*100
		look(t)
		local GID = CreateObjectIndirect(t)
	elseif rd <= 10000 then			-- Boss
		look('333')
		local t = monster_list[2]
		t.copySceneGID = copySceneGID
		t.regionId = mapGID
		t.x = x
		t.y = y
		t.level = lv
		t.monAtt = t.monAtt or {}
		t.monAtt[1] = lv*20000
		t.monAtt[3] = lv*200
		look(t)
		local GID = CreateObjectIndirect(t)
	end
	copyScene.ksnum = (copyScene.ksnum or 0) + 1
	if copyScene.PlayerSIDList then
		for sid in pairs(copyScene.PlayerSIDList) do
			if type(sid) == type(0) then
				RPCEx(sid,'Met_ksnum',copyScene.ksnum)
			end
		end
	end
	if copyScene.ksnum < 20 then
		SetEvent(5,nil,'GI_Meterial_refresh',mapGID,x,y,copySceneGID)
	else
		CI_AddBuff(247,0,1,false,2,sid)	--不能攻击了
	end
end

-- 矿石死亡
cs_monster_dead[4004] = function(mapGID, copySceneGID)
	look('cs_monster_dead 4004')
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then
		return
	end
	look('cs_monster_dead 4004')
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then return end
	look('cs_monster_dead 4004')
	local lv = CI_GetPlayerData(1)
	local x,y,rid,mapGID = CI_GetCurPos(3)
	local rd = math_random(1,10000)
	if rd <= 2000 then
		local dropn = math_random(3,5)
		for i = 1, dropn do
			CreateGroundItem(0,mapGID,604,1,x,y,i)
		end
	elseif rd <= 4000 then
		local dropn = math_random(2,3)
		for i = 1, dropn do
			CreateGroundItem(0,mapGID,612,1,x,y,i)
		end
	elseif rd <= 6000 then			-- 小怪
		local t = monster_list[1]
		t.copySceneGID = copySceneGID
		t.regionId = mapGID
		t.x = x
		t.y = y
		t.level = lv
		t.monAtt = t.monAtt or {}
		t.monAtt[1] = lv*10000
		t.monAtt[3] = lv*100		
		look(t)
		local GID = CreateObjectIndirect(t)
	elseif rd <= 10000 then			-- Boss
		local t = monster_list[2]
		t.copySceneGID = copySceneGID
		t.regionId = mapGID
		t.x = x
		t.y = y
		t.level = lv
		t.monAtt = t.monAtt or {}
		t.monAtt[1] = lv*20000
		t.monAtt[3] = lv*200
		look(t)
		local GID = CreateObjectIndirect(t)
	end
	copyScene.ksnum = (copyScene.ksnum or 0) + 1
	if copyScene.PlayerSIDList then
		for sid in pairs(copyScene.PlayerSIDList) do
			if type(sid) == type(0) then
				RPCEx(sid,'Met_ksnum',copyScene.ksnum)
			end
		end
	end
	if copyScene.ksnum < 20 then
		SetEvent(5,nil,'GI_Meterial_refresh',mapGID,x,y,copySceneGID)
	else
		CI_AddBuff(247,0,1,false,2,sid)	--不能攻击了
	end
end