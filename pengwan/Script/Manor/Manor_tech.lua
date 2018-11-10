--[[
	file:庄园科技
	author:	csj
--]]
local pairs,type,rint = pairs,type,rint
local ipairs = ipairs
--local UpdateHeroFight = UpdateHeroFight
local SendLuaMsg = SendLuaMsg
--s2c_msg_def
local MAT_Data = msgh_s2c_def[36][1]	-- 科技数据
local MAT_UpLv = msgh_s2c_def[36][2] 	-- 科技升级

--------------------------------------------------------------
--data:

local ManorTechConf = {
	-- [needLV]: 需求庄园等级 [attr]: 增加属性比例
	[1] = {needLV = 1,attr = {[3] = 2,[8] = 1.5}},		-- 力量训练
	[2] = {needLV = 5,attr = {[5] = 1.5,[7] = 1.5}},		-- 敏捷训练
	[3] = {needLV = 10,attr = {[1] = 10,[6] = 1.5}},		-- 体质训练
	[4] = {needLV = 15,attr = {[4] = 2,[9] = 1.5}},		-- 耐力训练
	[5] = {needLV = 20,attr_D = {[1] = 15,[3] = 2,[4] = 3}},		-- 宠物训练
	[6] = {needLV = 25},		-- 摇钱树				
	[7] = {needLV = 30},		-- 掠夺术
	[8] = {needLV = 40},		-- 鼓舞术
}

------------------------------------------------------------------
--inner function:


------------------------------------------------------------------
--interface:

-- 升级庄园科技
function MTC_UpLevel(sid,index)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	if pManorData.Tech == nil then 
		pManorData.Tech = {}
	end
	if ManorTechConf[index] == nil then 
		return
	end
	--look(index)
	local tecLV = pManorData.Tech[index] or 0
	if tecLV >= (pManorData.mLv or 1) then
		SendLuaMsg( 0, { ids = MAT_UpLv, res = 1 }, 9 )
		return
	end
	if pManorData.mLv < ManorTechConf[index].needLV then
		SendLuaMsg( 0, { ids = MAT_UpLv, res = 2 }, 9 )
		return
	end
	-- 判断灵气
	tecLV = tecLV + 1
	local nCost = tecLV * tecLV * 100
	local cPoint = GetPlayerPoints(sid, 2)
	if cPoint == nil or cPoint < nCost then
		SendLuaMsg( 0, { ids = MAT_UpLv, res = 3 }, 9 )
		return
	end
	-- 扣灵气
	AddPlayerPoints(sid,2, - nCost,nil,'庄园科技')
	
	pManorData.Tech[index] = tecLV
	-- 更新随从属性
	--if ManorTechConf[index].attr then
	--	UpdateHeroFight(sid)
	--end
	-- look(pManorData.Tech)
	SendLuaMsg( 0, { ids = MAT_UpLv, res = 0, idx = index }, 9 )
end

-- 获取庄园科技等级
-- 注意：index为空的情况下会发消息给前台(现在登陆要发 这里就不发了)
function MTC_GetTecLv(sid,index)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	if pManorData.Tech == nil then 
		pManorData.Tech = {}
	end
	if index then		
		return pManorData.Tech[index]
	else
		-- SendLuaMsg( sid, { ids = MAT_Data, data = pManorData.Tech }, 10 )
		return pManorData.Tech
	end
end

-- 获取科技加成随从属性表
function MTC_GetHerosAttr(sid)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil or pManorData.Tech == nil then return end
	local tAttr = GetRWData(1)		-- 总属性表
	for k, tecLV in pairs(pManorData.Tech) do
		if type(k) == type(0) and type(tecLV) == type(0) and tecLV > 0 then
			if ManorTechConf[k] and ManorTechConf[k].attr then
				for m, n in pairs(ManorTechConf[k].attr) do
					if tecLV <= 20 then
						tAttr[m] = rint((tAttr[m] or 0) + (tecLV * 10) * n)
					elseif tecLV <= 50 then
						tAttr[m] = rint((tAttr[m] or 0) + (20 * 10 + (tecLV - 20) * 20) * n)
					elseif tecLV <= 80 then
						tAttr[m] = rint((tAttr[m] or 0) + (20 * 10 + 30 * 20 + (tecLV - 50) * 50) * n)
					elseif tecLV <= 100 then
						tAttr[m] = rint((tAttr[m] or 0) + (20 * 10 + 30 * 20 + 30 * 50 + (tecLV - 80) * 100) * n)
					end
				end
			end
		end
	end
	return tAttr
end

-- 获取科技加成宠物属性表
function MTC_GetPetAttr(sid)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil or pManorData.Tech == nil then return end
	local tAttr = GetRWData(1)		-- 总属性表
	local rint = rint
	local pairs = pairs
	for k, tecLV in pairs(pManorData.Tech) do
		if type(k) == type(0) and type(tecLV) == type(0) and tecLV > 0 then
			if ManorTechConf[k] and ManorTechConf[k].attr_D then
				for m, n in pairs(ManorTechConf[k].attr_D) do
					if tecLV <= 20 then
						tAttr[m] = rint((tAttr[m] or 0) + (tecLV * 10) * n)
					elseif tecLV <= 50 then
						tAttr[m] = rint((tAttr[m] or 0) + (20 * 10 + (tecLV - 20) * 20) * n)
					elseif tecLV <= 80 then
						tAttr[m] = rint((tAttr[m] or 0) + (20 * 10 + 30 * 20 + (tecLV - 50) * 50) * n)
					elseif tecLV <= 100 then
						tAttr[m] = rint((tAttr[m] or 0) + (20 * 10 + 30 * 20 + 30 * 50 + (tecLV - 80) * 100) * n)
					end
				end
			end
		end
	end
	return tAttr
end

