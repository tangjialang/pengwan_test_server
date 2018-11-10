--[[
file:	player_flower.lua
desc:	送花
author:	wk
update:	2013-06-01
refix:	done by wk
]]--
local type = type
local Player_SendFlower = msgh_s2c_def[15][6]
local uv_TimesTypeTb = TimesTypeTb
local isFullNum=isFullNum
local GetStringMsg=GetStringMsg
local GiveGoods=GiveGoods
local CheckCost=CheckCost
local TipCenter=TipCenter
local PI_PayPlayer=PI_PayPlayer
local BroadcastRPC,RPC=BroadcastRPC,RPC
local AddDearDegree=AddDearDegree
local AddMeiLiValue=AddMeiLiValue
local look,GetPlayer = look,GetPlayer

-- 1 花编号 2-- 购买需要的钱 3 --增加经验 4-- 亲密度 5 --魅力值  6 玫瑰花朵数
local FlowerList = {
	{620,9 ,2000,1,1,1},			
	{621,99 ,5000,9,9,99},
	{622,999 ,20000,99,99,999},
	{792,999 ,20000,199,199,999},
}
-- 送花增加的相关属性 亲密度 魅力值 收花朵数
local function Flower_AddValue(sid,othersid,sDear,sMeiLi,sFlowers)
	--look('亲密度',1)
	--look(sDear,1)
	AddDearDegree(sid,othersid,sDear)				-- 加亲密度	
	AddDearDegree(othersid,sid,sDear)
	AddMeiLiValue(sid,sMeiLi)						-- 加魅力值
	AddMeiLiValue(othersid,sMeiLi,sFlowers)			-- 加对方魅力值 只增加对方收花数
end
----------------------------------------
--买花
function Flower_Buy(sid,iType,iCount)	
	if type(iType) ~= type(0) or type(iCount) ~= type(0) then return end
	local cost = FlowerList[iType][2]*iCount	
	local pakagenum = isFullNum()		-- 首先检查背包格数
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return
	end 		
	if iType == 1 then			
		if not CheckCost(sid,cost,0,1,"100010_送一朵玫瑰") then
			TipCenter(GetStringMsg(144))
			return
		end
		GiveGoods(FlowerList[iType][1],iCount,1,"商店购买")
	elseif iType == 2 then
		if not CheckCost(sid,cost,0,1,"100010_送99朵玫瑰") then
			TipCenter(GetStringMsg(144))
			return
		end
		GiveGoods(FlowerList[iType][1],iCount,1,"商店购买")
	elseif iType == 3 then
		if not CheckCost(sid,cost,0,1,"100010_送999朵玫瑰") then
			TipCenter(GetStringMsg(144))
			return
		end
		GiveGoods(FlowerList[iType][1],iCount,1,"商店购买")
	elseif iType == 4 then
		if not CheckCost(sid,cost,0,1,"100010_蓝色妖姬") then
			TipCenter(GetStringMsg(144))
			return
		end
		GiveGoods(FlowerList[iType][1],iCount,1,"商店购买")
	end
end

-- iType 3种花类型 
function SendFlower(sid,othername,iType,autobuy,info)
	local FlowerList = FlowerList
	-- local bAdd = false	
	-- if CheckTimes(sid,uv_TimesTypeTb.Flower_Exp,1,-1) then
	-- 	bAdd = true
	-- end
	local othersid = GetPlayer(othername,0)
	if othersid == nil or type(othersid) ~= type(0) then
		TipCenter(GetStringMsg(7))
		
		return
	end
	local selfname = CI_GetPlayerData(5)
	local othername = CI_GetPlayerData(5,2,othersid)
	local cost = FlowerList[iType][2]
	if iType == 1 then
		if not (CheckGoods( FlowerList[iType][1] , 1,0,sid,'送9朵花') == 1) then
			if autobuy==0 then
				--TipCenter(GetStringMsg(427,FlowerList[iType][1],1))		
				return
			elseif autobuy==1 then
				if not CheckCost(sid,cost,0,1,"100010_送9朵玫瑰") then
					TipCenter(GetStringMsg(144))
					return
				end
			else
				look('error')
				return
			end
		end
		-- if bAdd then PI_PayPlayer(1,FlowerList[iType][3],0,0,'送花') end	-- 加经验
		Flower_AddValue(sid,othersid,FlowerList[iType][4],FlowerList[iType][5],FlowerList[iType][6])
	elseif iType == 2 then
		if not (CheckGoods( FlowerList[iType][1] , 1,0,sid,'送99朵玫瑰') == 1) then
			if autobuy==0 then
			--	TipCenter(GetStringMsg(427,FlowerList[iType][1],1))		
				return
			elseif autobuy==1 then
				if not CheckCost(sid,cost,0,1,"100010_送99朵玫瑰") then
					TipCenter(GetStringMsg(144))
					return
				end
			else
				look('error')
				return
			end
		end	
		-- if bAdd then PI_PayPlayer(1,FlowerList[iType][3],0,0,'送花') end
		Flower_AddValue(sid,othersid,FlowerList[iType][4],FlowerList[iType][5],FlowerList[iType][6])
	elseif iType == 3 then
		if not (CheckGoods( FlowerList[iType][1] , 1,0,sid,'送999朵玫瑰') == 1) then
			if autobuy==0 then
			--	TipCenter(GetStringMsg(427,FlowerList[iType][1],1))		
				return
			elseif autobuy==1 then
				if not CheckCost(sid,cost,0,1,"100010_送999朵玫瑰") then
					TipCenter(GetStringMsg(144))
					return
				end
			else
				look('error')
				return
			end
		end	
		-- if bAdd then PI_PayPlayer(1,FlowerList[iType][3],0,0,'送花') end
		Flower_AddValue(sid,othersid,FlowerList[iType][4],FlowerList[iType][5],FlowerList[iType][6])
		if type(info)==type('') then 
			 if string.len(info)<100 then 
				BroadcastRPC('BroadCast_Flower',iType,selfname,othername,info)		-- 999朵 全服广播
			end
		end
	elseif iType == 4 then
		if not (CheckGoods( FlowerList[iType][1] , 1,0,sid,'送蓝色妖姬') == 1) then
			if autobuy==0 then
			--	TipCenter(GetStringMsg(427,FlowerList[iType][1],1))		
				return
			elseif autobuy==1 then
				if not CheckCost(sid,cost,0,1,"送蓝色妖姬") then
					TipCenter(GetStringMsg(144))
					return
				end
			else
				look('error')
				return
			end
		end	
		-- if bAdd then PI_PayPlayer(1,FlowerList[iType][3],0,0,'送花') end
		Flower_AddValue(sid,othersid,FlowerList[iType][4],FlowerList[iType][5],FlowerList[iType][6])
		if type(info)==type('') then 
			 if string.len(info)<100 then 
				BroadcastRPC('BroadCast_Flower',iType,selfname,othername,info)		-- 999朵 全服广播
			end
		end
	end
	RPC('Flower_Show',iType,selfname,othername)	
	SendLuaMsg( othersid, { ids=Player_SendFlower, itype = iType, s_name = selfname, o_name = othername, o_sid = othersid }, 10 )	
end

