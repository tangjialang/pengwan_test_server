--[[
file:	Equip_inset_wk.lua
desc:	装备镶嵌系统
author:	wk
update:	2013-1-5
refix:	done by wk
]]--
local rint = rint
local type,pairs = type,pairs
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local equip_open	 = msgh_s2c_def[23][3]	
local equip_in	 = msgh_s2c_def[23][4]	
local equip_out	 = msgh_s2c_def[23][5]	
local CI_UpdateEquipDetails	 = CI_UpdateEquipDetails
local CI_GetEquipDetails = CI_GetEquipDetails
local UpdateItemDetails=UpdateItemDetails
local GetItemDetails=GetItemDetails
local CheckGoods	 = CheckGoods
local CheckCost	 = CheckCost
local GiveGoods=GiveGoods
local TipCenter,GetStringMsg	 = TipCenter,GetStringMsg
local look = look
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos
local out_needmoney={5000,10000,20000,30000,50000,80000,100000,150000,200000,300000} --10级宝石对应拆除需要铜币

--装备打孔
function Equip_drill(playerid,holedata)
	look('装备打孔',1)
	if playerid==nil or holedata==nil or type(holedata)~=type({}) then
		look("data_inerror")
		return
	end
	local i_type=holedata.itype
	if i_type==nil then
		return
	end
	if i_type~=0 and  i_type~=1 then
		return
	end
	local site
	local detail
	-- if i_type == 1 then
		-- TipCenter('对不起，只能对身上的装备进行此操作')
		-- return
	-- end
	if i_type==1 then--包裹里的装备
		local e_quip=holedata.equip
		if e_quip == nil  then
			look('holedata.equip:arg is nil.')
			return
		end
		if type(e_quip)~="userdata" then 
			return
		end
		detail = GetItemDetails(e_quip)--=========获取装备值-包裹
		look(detail,1)
	elseif i_type==0 then--身上的装备
		local e_quip=holedata.equip
		site=holedata.site
		if e_quip == nil or site == nil then
			look('EnhanceEquip:arg is nil.')
			return
		end
		 detail = CI_GetEquipDetails(site,e_quip)--=========获取装备值-身上
	end
	if detail == nil or detail.slots == nil then
		look('INSET_detail_error',1)
		return
	end
	if detail.type>108 then
		TipCenter( GetStringMsg(435))
		return
	end
	local validSlots=0
	for i=1, 4 do
		if (400 ~= detail.slots[i]) then	
			validSlots = validSlots+1
		end
	end
	local hole=validSlots+1
	local auto_buy=holedata.autobuy
	if auto_buy==nil then return end
	local itemid
	if hole==1 then
		itemid=607
	elseif hole==2 then
		itemid=607
	elseif hole==3 then
		itemid=608
	elseif hole==4 then
		itemid=609
		if detail.quality<4 then --====橙色
			SendLuaMsg(0,{ids=equip_open,succ=0},9)
			return
		end
	else
		SendLuaMsg(0,{ids=equip_open,succ=0},9)
		return
	end
	if auto_buy==0 then
		if not (CheckGoods(itemid, 1,0,playerid,'打孔') == 1) then --=================减去一个初级金刚钻石
			SendLuaMsg(0,{ids=equip_open,succ=0},9)
			return
		end
	elseif auto_buy==1 then
		if not (CheckGoods(itemid, 1,0,playerid,'打孔') == 1) then
			local needmoney=10
			if hole==3 then 
				needmoney=20
			elseif hole==4 then 	
				needmoney=50
			end
			if not (CheckCost(playerid, needmoney,0,1,'买打孔石')) then --=================减钱
				SendLuaMsg(0,{ids=equip_open,succ=0},9)
				return
			end
		end
	end
	detail.slots[hole] = 1+400
	detail.flags = 1
	if i_type==1 then
		UpdateItemDetails(holedata.equip, detail)--===更新装备属性
	else
		CI_UpdateEquipDetails(site, detail)
	end
	SendLuaMsg(0,{ids=equip_open,succ=1},9)
end

--装备镶嵌宝石
function Equip_instone(playerid,inset)
	if  playerid==nil or inset==nil or type(inset)~=type({}) then return end
	local i_type=inset.itype
	if i_type==nil then
		look("i_type is error")
		return
	end
	if i_type~=0 and  i_type~=1 then
		look("i_type is error")
		return
	end
	-- if i_type == 1 then
		-- TipCenter('对不起，只能对身上的装备进行此操作')
		-- return
	-- end
	local site
	local detail
	if i_type==1 then
		local e_quip=inset.equip
		if e_quip == nil  then
				look('inset.equip:arg is nil.')
				return
		end
		if type(e_quip)~="userdata" then return end
		detail = GetItemDetails(e_quip)--=========获取装备值-包裹
	elseif i_type==0 then
		local e_quip=inset.equip
		site=inset.site

		if e_quip == nil or site == nil then
			look('EnhanceEquip:arg is nil.')
			return
		end
		detail = CI_GetEquipDetails(site,e_quip)--=========获取装备值-身上
		end
	if detail == nil or detail.slots == nil then
		look('EnhanceEquip:detail == nil.')
		return
	end
	if detail.type>108 then
		TipCenter( GetStringMsg(435))
		return
	end
	local stoneid=inset.stoneid
	if stoneid == nil or stoneid<410 or stoneid>490 then
		look('stoneid is nil.')
		return
	end
	local validSlots=0
	for i=1, 4 do
		if detail.slots[i] == 1 + 400 then	
			validSlots=i
			break
		end
	end

	if validSlots == 0  then
		SendLuaMsg(0,{ids=equip_in,succ=0},9)
		return
	end
	local stonetype=rint((stoneid-400)/10)--宝石类型
	for k,v in pairs(detail.slots) do
		if rint((v-400)/10)==stonetype then
			SendLuaMsg(0,{ids=equip_in,succ=0},9)
			return
		end
	end
	if not (CheckGoods(stoneid, 1,0,playerid,'镶嵌')==1) then
		return
	end
	detail.slots[validSlots] = stoneid
	detail.flags = 1
	if i_type==1 then
		UpdateItemDetails(inset.equip, detail)--===更新装备属性
	else
		CI_UpdateEquipDetails(site, detail)
	end
	SendLuaMsg(0,{ids=equip_in,succ=1},9)
	local stone_end=stoneid%10
	-- look(stone_end,1)
	if stone_end>=7 then
		set_obj_pos(playerid,5004)
		set_obj_pos(playerid,2001)
	elseif stone_end>=2 then
		set_obj_pos(playerid,2001)
	end
end
--拆除宝石
function Equip_outstone(playerid,outst)
	local pakagenum = isFullNum()--====包裹满
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return
	end
	if  playerid==nil or outst==nil or type(outst)~=type({}) then return end

	local i_type=outst.itype
	if i_type==nil then
		look("i_type is error")
		return
	end
	if i_type~=0 and  i_type~=1 then
		look("i_type is error")
		return
	end
	-- if i_type == 1 then
		-- TipCenter('对不起，只能对身上的装备进行此操作')
		-- return
	-- end
	local site
	local detail
	if i_type==1 then
		local e_quip=outst.equip
		if e_quip == nil  then
			look('outst.equip:arg is nil.')
			return
		end
		if type(e_quip)~="userdata" then 
			return
		end
		
			detail = GetItemDetails(e_quip)--=========获取装备值-包裹
	elseif i_type==0 then
		local e_quip=outst.equip
		site=outst.site

			if e_quip == nil or site == nil then
				look('EnhanceEquip:arg is nil.')
				return
			end
			 detail = CI_GetEquipDetails(site,e_quip)--=========获取装备值-身上
		end
	if detail == nil or detail.slots == nil then
		look('EnhanceEquip:detail == nil.')
		return
	end
	if detail.type>108 then
		TipCenter( GetStringMsg(435))
		return
	end
	local num=outst.index
	if num == nil  then
		look('num is nil.')
		return
	end
	if num > 4 or num < 0  then
		look('num nil.')
		return
	end
	local stoneid=detail.slots[num]
	if stoneid==nil or stoneid<410 or stoneid>490 then 
		look("stoneid_error")
		return 
	end

	local needmoney=out_needmoney[stoneid%400%10+1]
	if not CheckCost( playerid , needmoney , 1 , 3, "宝石拆解") then
		--TipCenter("银子不够")
		return
	end
	detail.slots[num] = 401
	if i_type==1 then
		UpdateItemDetails(outst.equip, detail)--===更新装备属性
	else
		CI_UpdateEquipDetails(site, detail)
	end
	GiveGoods(stoneid,1,1,'拆除宝石')--给宝石
	CheckCost( playerid , needmoney , 0 , 3, "宝石拆解")
	SendLuaMsg(0,{ids=equip_out,succ=1},9)
end