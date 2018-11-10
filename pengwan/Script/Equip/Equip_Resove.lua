--[[
file:	Equip_Resove.lua
desc:	装备分解系统
author:	wk
update:	2012-12-26
refix:	done by wk
]]--
local type,pairs = type,pairs
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local equip_resove	 = msgh_s2c_def[23][6]	
local ModifyItem	=  ModifyItem
local GetItemDetails=GetItemDetails
local CheckCost	 = CheckCost
local GiveGoods=GiveGoods
local TipCenter,GetStringMsg	 = TipCenter,GetStringMsg
local look = look

local uv_xlstong={ 	
	[604]={0,0},--[1]为不绑，[2]为绑定=====设为全局?
	[605]={0,0},
	[606]={0,0},
	}
local getxlstone={1,2,3,5} 
--需要金钱
local function money_Decompose(xlid,itemcolor)--xlid洗炼石等级，itemcolor装备颜色
	if xlid==604 then
		return itemcolor^2*1000*1
	elseif xlid==605 then
		return itemcolor^2*1000*5
	elseif xlid==606 then
		return itemcolor^2*1000*10
	end
end
--分解得到洗炼石id，个数
local function xlstongid_getnum(itemlv,itemcolor)--装备等级颜色,返回需要的洗炼石等级与个数

	local num=getxlstone[itemcolor]
	if itemlv>0 and itemlv<40 then
		return 604,num --1级洗炼石id
	elseif itemlv>=40 and itemlv<60 then
		return 605,num --2级洗炼石
	elseif itemlv>=60 and itemlv<=100 then
		return 606,num --3级洗炼石
	end
end	

-- 装备分解
function EquipDecompose(sid,indexFrom)
	if type(indexFrom) ~= type({}) then
		look("EquipDecompose erro")
		return
	end
	
	local succnum=0
	local allmoney=0
	--local need_equip={}
	--重置获得表
	for r,t in pairs (uv_xlstong) do
		t[1]=0 
		t[2]=0 
	end
	
	for k, equip in pairs(indexFrom) do	
		if type(equip)~="userdata" then look("EquipDecompose_equiperror") return end
		local detail = GetItemDetails(equip)
		if detail==nil then 
			SendLuaMsg(0,{ids=equip_resove,succ=succnum},9)
			return
		end
		if detail.type>108 then
			TipCenter( GetStringMsg(435))
			return
		end
		if detail then 
			local getlolor=detail.quality--颜色
			local getlv=detail.levelEM--取装备等级)
			local getbd=detail.flags--取绑定值
			if getlolor<1 or getlolor>4 or getlv>100  then
				return
			end
			local xlid,xlnum=xlstongid_getnum(getlv,getlolor)--得到石头与个数
			if xlid==nil or xlnum==nil  then return end
			local need_money=money_Decompose(xlid,getlolor)--需要钱
			for q,w in pairs(uv_xlstong) do
				if xlid==q then 	
					if getbd==0 then	
						uv_xlstong[q][1]=uv_xlstong[q][1]+xlnum
					else
						uv_xlstong[q][2]=uv_xlstong[q][2]+xlnum
					end
				end
			end	
			succnum=succnum+1
			allmoney=allmoney+need_money
		end 
	end
	if not CheckCost( sid , allmoney , 1 , 3, "装备分解") then
		--TipCenter("银子不够")
		return
	end

	for k, equip in pairs(indexFrom) do	
	  local result = ModifyItem(equip,'D','装备分解')
	  if result ~= 1 then
		look("ModifyItem del error!")
		return
	  end
	end
	for r,t in pairs (uv_xlstong) do
		if t[1]>0 then
			GiveGoods(r,t[1],0,"装备分解")
		end
		if t[2]>0 then
			GiveGoods(r,t[2],1,"装备分解")	
		end
	end
	CheckCost( sid ,allmoney, 0 , 3, "装备分解")
	SendLuaMsg(0,{ids=equip_resove,succ=succnum},9)
end
