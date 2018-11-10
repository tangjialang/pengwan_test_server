--[[
file:	Equip_Resove.lua
desc:	װ���ֽ�ϵͳ
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
	[604]={0,0},--[1]Ϊ����[2]Ϊ��=====��Ϊȫ��?
	[605]={0,0},
	[606]={0,0},
	}
local getxlstone={1,2,3,5} 
--��Ҫ��Ǯ
local function money_Decompose(xlid,itemcolor)--xlidϴ��ʯ�ȼ���itemcolorװ����ɫ
	if xlid==604 then
		return itemcolor^2*1000*1
	elseif xlid==605 then
		return itemcolor^2*1000*5
	elseif xlid==606 then
		return itemcolor^2*1000*10
	end
end
--�ֽ�õ�ϴ��ʯid������
local function xlstongid_getnum(itemlv,itemcolor)--װ���ȼ���ɫ,������Ҫ��ϴ��ʯ�ȼ������

	local num=getxlstone[itemcolor]
	if itemlv>0 and itemlv<40 then
		return 604,num --1��ϴ��ʯid
	elseif itemlv>=40 and itemlv<60 then
		return 605,num --2��ϴ��ʯ
	elseif itemlv>=60 and itemlv<=100 then
		return 606,num --3��ϴ��ʯ
	end
end	

-- װ���ֽ�
function EquipDecompose(sid,indexFrom)
	if type(indexFrom) ~= type({}) then
		look("EquipDecompose erro")
		return
	end
	
	local succnum=0
	local allmoney=0
	--local need_equip={}
	--���û�ñ�
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
			local getlolor=detail.quality--��ɫ
			local getlv=detail.levelEM--ȡװ���ȼ�)
			local getbd=detail.flags--ȡ��ֵ
			if getlolor<1 or getlolor>4 or getlv>100  then
				return
			end
			local xlid,xlnum=xlstongid_getnum(getlv,getlolor)--�õ�ʯͷ�����
			if xlid==nil or xlnum==nil  then return end
			local need_money=money_Decompose(xlid,getlolor)--��ҪǮ
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
	if not CheckCost( sid , allmoney , 1 , 3, "װ���ֽ�") then
		--TipCenter("���Ӳ���")
		return
	end

	for k, equip in pairs(indexFrom) do	
	  local result = ModifyItem(equip,'D','װ���ֽ�')
	  if result ~= 1 then
		look("ModifyItem del error!")
		return
	  end
	end
	for r,t in pairs (uv_xlstong) do
		if t[1]>0 then
			GiveGoods(r,t[1],0,"װ���ֽ�")
		end
		if t[2]>0 then
			GiveGoods(r,t[2],1,"װ���ֽ�")	
		end
	end
	CheckCost( sid ,allmoney, 0 , 3, "װ���ֽ�")
	SendLuaMsg(0,{ids=equip_resove,succ=succnum},9)
end
