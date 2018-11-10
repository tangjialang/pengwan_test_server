--[[
file: expcs.lua
desc: 经验副本
autor: csj
]]--

local type,pairs = type,pairs
local table_insert = table.insert
local GetServerTime = GetServerTime
local RPC = RPC
local RPCEx = RPCEx

local monster_conf = {
	[1] = { monsterId = 513,deadbody = 6,IdleTime = 300,aiType = 1539,camp = 4 },
	[2] = { monsterId = 514,deadbody = 6,IdleTime = 300,aiType = 1539,camp = 4 },
	[3] = { monsterId = 515,deadbody = 6 },
	[9] = { monsterId = 536,x = 12,y = 20, deadScript = 9001 },
}

local function set_monster_attr(mc,lv,idx)
	if type(mc) ~= type({}) or lv == nil then return end
	if idx == 1 then			-- 旺财
		mc[3] = lv^2.2
	elseif idx == 2 then		-- 箭塔
		mc[3] = lv^2.2*0.5
	elseif idx == 3 then		-- 经验球
		mc[3] = lv^2.2*0.2
	end
end

-- 副本拾取技能
function _expfb_getskill(sid,skill_id)
	if sid == nil or skill_id == nil then return end
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp == nil then return end	
	local copyScene = CS_GetTemp(pCSTemp.CopySceneGID)
	if copyScene == nil then return end		
	pCSTemp.skills = pCSTemp.skills or {}
	if #pCSTemp.skills >= 4 then	-- 技能栏满了不能再装了
		return
	end
	table_insert(pCSTemp.skills,skill_id)
	RPC('expfb_skills',pCSTemp.skills)
end

local function _expfb_useskill(sid,idx,x,y)
	look('_expfb_useskill:' .. tostring(idx))
	if sid == nil or idx == nil then return end
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp == nil or pCSTemp.skills == nil then return end
	local fbID = pCSTemp.fbID
	local t = pCSTemp.skills
	local now = GetServerTime()
	local skill_id = t[idx]
	look('skill_id:' .. tostring(skill_id))
	if skill_id == nil then return end
	local _,_,rid,mapGID = CI_GetCurPos(2,sid)
	local lv = CI_GetPlayerData(1,2,sid)
	if skill_id == 1 then
		table.remove(t,idx)
		local mc = monster_conf[1]
		if mc then
			mc.x = x
			mc.y = y
			mc.regionId = mapGID
			mc.monAtt = mc.monAtt or {}
			set_monster_attr(mc.monAtt,lv,1)
			local mon_gid = CreateObjectIndirect(mc)
			if mon_gid and mon_gid > 0 then
				CI_UpdateMonsterData(4,sid,4,mon_gid)
			end
		end	
	elseif skill_id == 2 then
		table.remove(t,idx)
		local mc = monster_conf[2]
		if mc then
			mc.x = x
			mc.y = y
			mc.regionId = mapGID
			mc.monAtt = mc.monAtt or {}
			set_monster_attr(mc.monAtt,lv,2)
			local mon_gid = CreateObjectIndirect(mc)
			if mon_gid and mon_gid > 0 then
				CI_UpdateMonsterData(4,sid,4,mon_gid)
			end
		end
	elseif skill_id == 3 then	
		table.remove(t,idx)
		CI_AddBuff(248,0,1,false)
	elseif skill_id == 4 then		
		table.remove(t,idx)
		local mc = monster_conf[3]
		if mc then
			mc.x = x
			mc.y = y
			mc.regionId = mapGID
			mc.monAtt = mc.monAtt or {}
			set_monster_attr(mc.monAtt,lv,3)
			local GID = CreateObjectIndirect(mc)
			look('GID::::' .. tostring(GID))
		end
	end
	RPC('expfb_useskill',0,idx)
end

local function _expfb_create_boss(sid)
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp == nil then return end
	if pCSTemp.exp_c and pCSTemp.exp_c >= 1 then
		RPC('expfb_boss',1)
		return
	end
	local _,_,rid,mapGID = CI_GetCurPos(2,sid)
	if mapGID == nil or mapGID == 0 then
		return
	end
	if not CheckCost( sid, 20, 0, 1, "经验副本刷BOSS") then
		RPC('expfb_boss',2)
		return
	end
	local mc = monster_conf[9]
	if mc then
		mc.regionId = mapGID
		local GID = CreateObjectIndirect(mc)
		look('GID::::' .. tostring(GID))
	end
	pCSTemp.exp_c = 1
	RPC('expfb_boss',0)
end

-- 怪物死亡 发消息通知前台
cs_monster_dead[9001] = function(mapGID, copySceneGID)
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then
		return
	end
	local sid = CI_GetPlayerData(17)
	if sid and sid > 0 then
		RPCEx(sid,'expfb_dead')
	end
end

--------------------------------------------------------------
-- interface:

expfb_getskill = _expfb_getskill
expfb_useskill = _expfb_useskill
expfb_create_boss = _expfb_create_boss