--[[
file:	stong_change.lua
desc:	宝石转换系统
author:	wk
update:	2012-12-26
refix:	done by wk
]]--
local type,pairs = type,pairs
local TipCenter,GetStringMsg	 = TipCenter,GetStringMsg
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local equip_ch	 = msgh_s2c_def[23][7]	
local isFullNum=isFullNum
local CheckGoods	 = CheckGoods
local CheckCost	 = CheckCost
local look = look
local money_base=2000 --转换需要钱的基数
local money_conf={270,1080,4320}--6级以上石头转换需要元宝
--开始宝石转换
function stong_chg(playerid,change)
	if  playerid==nil or change==nil then
		return
	end
	local beforeID=change.stongid1
	local afterID=change.stongid2
	local num=change.num
	if type(beforeID) ~= type(0)  or type(afterID) ~= type(0)  or type(num) ~= type(0) then
		look('stong_chg:arg is nil.')
		return
	end
	if beforeID<410 or beforeID>490 or afterID<410 or afterID >490 then
		return
	end
	local pakagenum = isFullNum()--====包裹满
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return
	end
	local stonglv1=(beforeID-400)%10+1
	local stonglv2=(afterID-400)%10+1
	if stonglv1~=stonglv2  then 
		return
	end
	
	if stonglv1<=5 then
		local money=money_base*4^(stonglv1-1)*num --转换宝石需要金钱
		if not CheckCost(playerid, money,1,3,'转换宝石') then--钱不够
			return
		end
		if CheckGoods( beforeID, num, 0, playerid,'转换宝石') == 0 then--查石头在不
			return
		else
			GiveGoods(afterID,num,1,'转换宝石')--给石头
			CheckCost(playerid, money,0,3,'转换宝石')--扣钱
		end
	else
		local money=money_conf[stonglv1-5]*num --转换宝石需要金钱
		look(money)
		if not CheckCost(playerid, money,1,1,'转换宝石') then--钱不够
			
			return
		end
		if CheckGoods( beforeID, num, 0, playerid,'转换宝石') == 0 then--查石头在不
			
			return
		else
			GiveGoods(afterID,num,1,'转换宝石')--给石头
			CheckCost(playerid, money,0,1,'转换宝石')--扣钱
		end
	end

	SendLuaMsg(0,{ids=equip_ch,succ=1},9)
end 