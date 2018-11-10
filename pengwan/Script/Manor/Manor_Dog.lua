--[[
Manor_Dog.lua
庄园狗功能
xiao.y
]]--

--s2c_msg_def
local Pet_Data = msgh_s2c_def[38][1]	-- 宠物数据
local Pet_Buy = msgh_s2c_def[38][2]	-- 购买宠物
local Pet_Set = msgh_s2c_def[38][3]	-- 幻化宠物
local look = look
local pairs,type = pairs,type
local Manor_PetConf,GiveGoods,SendLuaMsg = Manor_PetConf,GiveGoods,SendLuaMsg

----------------------------------------------------------------------------
--inner function:


----------------------------------------------------------------------------
--interface:

--获取宠物数据	(在线数据)				  
function GetPetData(sid)
	if( sid == nil or sid == 0 )then return end
	
	local pManorData = GetPlayerManorData(sid)
	if pManorData == nil then return end
	
	return pManorData.PetD
end

-- 发送宠物数据
function SendPetData(sid)
	look("SendPetData:" .. sid)
	if( sid == nil or sid == 0 )then return end
	local pManorData = GetPlayerManorData(sid)
	if pManorData == nil then return end
	SendLuaMsg( 0, { ids=Pet_Data, data = pManorData.PetD }, 9 )
end

--购买宠物形象 idx 狗幻化索引
function BuyPetStyle(sid,idx)
	if idx == nil then return end
	local petData = GetPetData(sid)
	if petData == nil then return end --获取狗数据失败
	
	local conf = Manor_PetConf[idx]
	if(conf == nil or conf.cost == nil or conf.day == nil) then return end --获取狗配置失败(花钱是必须的,不过期是不行的）

	-- 判断是否过期
	if petData[idx] and petData[idx] > 0 then
		SendLuaMsg( 0, { ids = Pet_Buy, res = 1, idx = idx }, 9 )
		return
	end
	
	local cost = conf.cost
	local day = conf.day
	
	if not CheckCost(sid,cost,0,1,"100024_购买宠物形象") then	--元宝不足
		SendLuaMsg( 0, { ids = Pet_Buy, res = 2, idx = idx }, 9 )
		return  
	end
	
	petData[idx] = day
	SendLuaMsg( 0, { ids = Pet_Buy, res = 0, idx = idx }, 9 )
	return
end

--设置狗幻化
function SetPetStyle(sid,idx)
	if idx == nil then return end
	local petData = GetPetData(sid)
	if petData == nil then return end
	if petData.id == idx then			--当前形象就是这个
		SendLuaMsg( 0, { ids = Pet_Set, res = 1, idx = idx }, 9 )
		return 
	end 
	if idx ~= 1 and petData[idx] == nil then
		SendLuaMsg( 0, { ids = Pet_Set, res = 2, idx = idx }, 9 )
		return
	end
	
	petData.id = idx
	look(petData.id)
	SendLuaMsg( 0, { ids = Pet_Set, res = 0, idx = idx }, 9 )
	return
end

-- 每日重置时减少狗的时效天数
function checkPetTime(sid,days)
	if days == nil or type(days) ~= type(0) then return end
	local petData = GetPetData(sid)
	if petData == nil then return end
	
	for idx,left in pairs(petData) do
		if type(idx) == type(0) and type(left) == type(0) then
			left = left - days
			if left <= 0 then
				petData[idx] = nil
				if petData.id == idx then
					petData.id = 1
				end
			else
				petData[idx] = left
			end			
		end
	end
		
	SendLuaMsg( 0, { ids=Pet_Data, data = petData }, 9 )
end

-- 获取宠物信息统一接口 (用于庄园掠夺)
function PI_GetPetInfo(sid)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	local petID = PI_GetPetID(sid)
	if petID == nil then return end
	local petConf = Manor_PetConf[petID]
	if petConf == nil then return end
	local mLv = pManorData.mLv
	
	local PetInfo = GetRWData(2)

	PetInfo.n = petConf.name
	PetInfo.lv = petConf.mLv
	PetInfo.id = petConf.rid					
	PetInfo.skid = petConf.skill
	PetInfo.sklv = petConf.skilllevel

	for k, v in pairs(Manor_PetConf.attr) do
		if type(k) == type(0) and type(v) == type({}) and #v == 2 then
			PetInfo.att[k] = rint((PetInfo.att[k] or 0) + v[1] + mLv * mLv * 1.2 * 1.2 * v[2])
		end
	end
	return true
end
