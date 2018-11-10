local msg_lvl_up = msgh_s2c_def[45][12]--升级
local msg_skill_level = msgh_s2c_def[45][13]--技能等级
local msg_attack = msgh_s2c_def[45][14]--分身攻击
local LEVEL_COST = 10


function ysfs_get_pdata(playerid)
	return GI_GetPlayerData( playerid , 'ysfs' , 40 )
	--{[1] =  lvl
	-- [2] = prg
	-- [3] = skill_level
	-- [4] = skill_spell
	--}
end

function ysfs_lvl_up(playerid,num,buy)
	local pdata = ysfs_get_pdata(playerid)
	pdata[1] = pdata[1] or 0
	local per_cost = rint((pdata[1]+1)/2)+1
	local yb_cost 
	if num < per_cost then
		if not buy then return end
		yb_cost = (per_cost - num) * 10
		per_cost = num
	end

	if CheckGoods(1581,per_cost,1,"元神分身") == 0 
	or (yb_cost and not CheckCost(playerid,yb_cost,1,1,"元神分身"))then
		look("道具或者元宝不足")
		return
	end
	CheckGoods(1581,per_cost,0,"元神分身");
	if yb_cost then CheckCost(playerid,yb_cost,0,1,"元神分身") end
		
	pdata[2] = (pdata[2] or 0) + 1
	if pdata[2] >= LEVEL_COST then 
		pdata[1] = pdata[1] + 1
		pdata[2] = 0
	end
	ysfs_attribute(playerid,0)
	SendLuaMsg(0,{ids=msg_lvl_up,lvl = pdata[1],prg = pdata[2]},9)
end

function ysfs_attribute(playerid,init)
	local pdata = ysfs_get_pdata(playerid)
	local level = pdata[1]
	if not level then return false end
	local atttab=GetRWData(1)
	atttab[1] = rint(level*100+level^2)*8
	atttab[3] = rint(level*100+level^2)
	atttab[4] = rint(level*100+level^2*0.8)
	atttab[2] = rint(level*100+level^2*0.8)
	local temp= rint(level*100+level^2*0.6)
	atttab[10] = temp
	atttab[11] = temp
	atttab[12] = temp
	
	if(init == 0) then
		PI_UpdateScriptAtt(playerid,ScriptAttType.ysfs)
	end
	return true
end

function ysfs_use_skill(playerid)
	local pdata = ysfs_get_pdata(playerid)
	if(pdata[3]) then
		local succ = CI_AddBuff(260,false,pdata[3],false,2,playerid)
		pdata[4] = GetServerTime()
	end
end

local level_limit = {0,30,50,70,90}

function ysfs_learn_skill(playerid,level)
	local pdata = ysfs_get_pdata(playerid)
	if not level_limit[level] or pdata[1] < level_limit[level]	then
		return 
	end
	pdata[3] = level
	SendLuaMsg(0,{ids=msg_skill_level,level=pdata[3] },9)
end

local atk_rate = {0.2,0.24,0.30,0.38,0.50}

local function _bit_tst(v,pos)
	if (rint(v / (2 ^ pos)) % 2) ==  1 then 
		return true 
	else 
		return false 
	end 
end
	
function ysfs_on_attack(sid)
	local pdata = ysfs_get_pdata(sid)
	if not pdata[3] then return end
	local target = CI_GetPlayerData(57)
	
	if not target then return end
	local obj_type = SI_getgid_Object(target)
	look(target)
	local from_atk =  CI_GetPlayerData(102)
	local target_def 
	
	if obj_type == 1 then
		target_def	= CI_GetPlayerData(103,1,target) or 0
	else
		target_def	= GetMonsterData(13,4,target) or 0
	end
	
	local real_damage = from_atk * atk_rate[pdata[3]] 
	local damage = real_damage-target_def
	local damage_min = real_damage* 0.1
	if damage < damage_min then
		damage = damage_min
	end
		
	if  obj_type == 3 then
		local aiType = GetMonsterData(30,4,target)
		if _bit_tst(aiType,10) then damage = 1 end
	end
	damage = -damage;
	PI_PayPlayer(3,damage,0,0,'元神分身',1,target)
	AreaRPC(2,sid,nil,'ysfs_atk',CI_GetPlayerData(16),target,damage)
end