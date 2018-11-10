--[[
file: tower.lua
desc: 塔防副本
autor: csj
update: 2013-8-2
]]--

-----------------------------------------------------
--include:

local table_insert = table.insert
local tostring = tostring
local RPC = RPC
local RPCEx = RPCEx
local AreaRPC = AreaRPC
local CI_AddBuff = CI_AddBuff
local CS_GetTemp = CS_GetTemp
local CS_GetPlayerTemp = CS_GetPlayerTemp
local CI_UpdateMonsterData = CI_UpdateMonsterData
local GetServerTime = GetServerTime
local CreateObjectIndirect = CreateObjectIndirect

------------------------------------------------------
--inner:

local tower_image = {2083,2084,2085,2086}
local tower_skill = {101,100,102,103}
local tower_attack = {95,94,96,97}
local monster_conf = {}

local function _tw_getskill(sid,skill_id)
	if sid == nil or skill_id == nil then return end
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp == nil then return end	
	if pCSTemp.skills then
		if #pCSTemp.skills >= 4 then	-- 技能栏满了不能再装了
			return
		end
		table_insert(pCSTemp.skills,skill_id)
		RPC('tw_skills',pCSTemp.skills)
	end		
end

local function _tw_useskill(sid,idx)
	if sid == nil or idx == nil then return end
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp == nil or pCSTemp.skills == nil then return end
	local fbID = pCSTemp.fbID
	local t = pCSTemp.skills
	local now = GetServerTime()
	if idx == 1 then
		if now < t[idx] then
			RPC('tw_useskill',1)
			return
		end		
		t[idx] = now + 30	-- 30秒冷却时间
		CreateObjectIndirect(monster_conf)
	elseif idx == 2 then
		if now < t[idx] then
			RPC('tw_useskill',2)
			return
		end	
		t[idx] = now + 30	-- 30秒冷却时间
		CI_AddBuff(147,0,1,false)
	elseif idx == 3 then		
		if t[idx] then
			CI_AddBuff(t[idx],0,1,false)
		end
	elseif idx == 4 then		
		if t[idx] then
			CI_AddBuff(t[idx],0,1,false)
		end
	end
	RPC('tw_useskill',0,idx)
end

local function _tw_npcbuff(sid,mon_gid)
	local _,copySceneGID = GetMonsterData(27,4,mon_gid)
	if copySceneGID == nil or copySceneGID == 0 then
		return
	end
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then
		return
	end
	if (copyScene.score or 0) < 500 then
		RPC('tw_npcbuff',1)			-- 积分不够
		return
	end
	local now = GetServerTime()
	if copyScene.tw_cd then
		if now < copyScene.tw_cd then
			RPC('tw_npcbuff',2)			-- CD中
			return
		end
	end
	copyScene.tw_cd = now + 30
	copyScene.score = copyScene.score - 500
	-- 妲己加无敌buff
	local ret = CI_AddBuff(220,0,1,false,4,mon_gid)
	look(ret)
	-- 同步积分
	if copyScene.PlayerSIDList then
		for sid in pairs(copyScene.PlayerSIDList) do
			if type(sid) == type(0) then
				RPCEx(sid,'tw_score',copyScene.score,copyScene.tw_cd)
			end
		end
	end
end

-- 升级/降级箭塔
local function _tw_uplevel(sid,mon_gid,ud,idx)
	look('_tw_uplevel:' .. idx)
	if sid == nil or mon_gid == nil or ud == nil or idx == nil then
		return
	end
	if ud ~= -1 and ud ~= 1 then
		return
	end
	local _,copySceneGID = GetMonsterData(27,4,mon_gid)
	if copySceneGID == nil or copySceneGID == 0 then
		return
	end
	look('_tw_uplevel 1')
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then
		return
	end
	local mon_lv = GetMonsterData(1,4,mon_gid)
	if mon_lv <= 0 then return end
	if ud == -1 and mon_lv > 1 then	-- 还原
		local n = mon_lv - 1
		local backscore = rint((n*100 + (n*(n-1))*100/2) * 0.8)		-- 返还80%
		copyScene.score = (copyScene.score or 0) + backscore		
		CI_UpdateMonsterData(1,{level = 1,imageID = 2082,skillID = {atc_id},skillLevel = {1},monAtt = {[3] = 400}},nil,4,mon_gid)
		AreaRPC(2,sid,nil,'tw_update_monter',mon_gid,1,2082)
		RPCEx(sid,'tw_score',copyScene.score)
		return
	end
	look('_tw_uplevel 2')
	
	if mon_lv >= 7 then
		RPC('tw_uplevel',1)			-- 等级上限了
		return
	end
	look('_tw_uplevel 3')
	local imageid = tower_image[idx]
	if imageid == nil then return end
	local skill_id = tower_skill[idx]
	if skill_id == nil then return end
	local atc_id = tower_attack[idx]
	if atc_id == nil then return end
	local needs = mon_lv * 100
	if (copyScene.score or 0) < needs then
		RPC('tw_uplevel',2)			-- 积分不够
		return
	end
	-- 扣积分
	copyScene.score = (copyScene.score or 0) - needs
	-- 提升防御塔等级		
	CI_UpdateMonsterData(1,{level = mon_lv + 1,imageID = imageid,skillID = {atc_id,skill_id},skillLevel = {1,mon_lv},monAtt = {[3] = rint(mon_lv*mon_lv*100+400)}, },nil,4,mon_gid)
	AreaRPC(2,sid,nil,'tw_update_monter',mon_gid,mon_lv + 1,imageid)
	-- 同步积分
	if copyScene.PlayerSIDList then
		for sid in pairs(copyScene.PlayerSIDList) do
			if type(sid) == type(0) then
				RPCEx(sid,'tw_score',copyScene.score)
			end
		end
	end
end

local function _tw_awards(sid,result,fbID)
	if sid == nil or fbID == nil or type(result) ~= type({}) then return end
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp == nil then return end
	if fbID ~= pCSTemp.fbID then return end
	local copySceneGID = pCSTemp.copySceneGID
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then return end
	local wLevel = GetWorldLevel() or 1
	local turns = copyScene.turns
	local exps = rint((wLevel^2) *22 + (turns^2) * 1000)
	local num = rint(turns)
	result[2] = exps
	if num >= 1 then
		result[3] = {{637,num,1}}
	end
end

-- 怪物死亡 +15分
cs_monster_dead[4001] = function(mapGID, copySceneGID)
	local copyScene = CS_GetTemp(copySceneGID)
	if copyScene == nil then
		return
	end
	copyScene.score = (copyScene.score or 0) + 10
	if copyScene.PlayerSIDList then
		for sid in pairs(copyScene.PlayerSIDList) do
			if type(sid) == type(0) then
				RPCEx(sid,'tw_score',copyScene.score)
			end
		end
	end
end

-------------------------------------------------------------
--interface:

tw_uplevel = _tw_uplevel
tw_npcbuff = _tw_npcbuff
tw_awards = _tw_awards