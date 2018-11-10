--[[
file:	Equip_xl.lua
desc:	װ��ϴ��ϵͳ
author:	wk
update:	2013-1-7
refix:	done by wk
]]--
local rint = rint
local type,pairs = type,pairs
local mathrandom = math.random
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local Equip_xlres	 = msgh_s2c_def[23][8]	
local equip_xlend	 = msgh_s2c_def[23][9]	
local equip_comi	 = msgh_s2c_def[23][10]	
local look = look
local CI_GetEquipDetails = CI_GetEquipDetails
local CI_UpdateEquipDetails	 = CI_UpdateEquipDetails
local CheckGoods	 = CheckGoods
local CheckCost	 = CheckCost
local TipCenter,GetStringMsg	 = TipCenter,GetStringMsg
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos

local common_rnd = require('Script.common.random_norepeat')
local Get_num 			 = common_rnd.Get_num

local basehp=10--��������
local baseact=2--��������������
local basedodge=1--���ܣ����������У��ֿ����񵲻���
local xlmoney={2,4,8}
local useitemid=635 --ϴ��������id
--ϴ����Ҫϴ��ʯid������
local function xlstongid_num(itemlv,itemcolor)--װ���ȼ���ɫ,������Ҫ��ϴ��ʯ�ȼ������
	if type(itemlv)~=type(0) or type(itemcolor)~=type(0) then 
		return 
	end
	local getxlstone={1,3,9,9, 9} 
	local num=getxlstone[itemcolor]
	if itemlv>0 and itemlv<40 then
		return 604,num --1��ϴ��ʯid
	elseif itemlv>=40 and itemlv<60 then
		return 605,num --2��ϴ��ʯ
	elseif itemlv>=60 and itemlv<=100 then
		return 606,num --3��ϴ��ʯ
	end
end

--����װ���ȼ�����������,���ؾ�����ֵ(��������������ֵ)
local function getnewval(itemlv,itype,mark)
	if itemlv==nil then return end
	local num=0
	local lv10=false
	local chense=false
	local rannum=mathrandom(1,100)
	if itype==1 then
		local lvahp=rint(itemlv*basehp*3/2)
		local lvahp_mini=rint(lvahp*0.35)
		--local lv9=rint((lvahp-lvahp_mini)*0.8+lvahp_mini)
		local lv9=rint((lvahp-lvahp_mini)*0.5+lvahp_mini)--�޸�Ϊ678910ֻ��һ��20131219
		if  mark then
			num=mathrandom(lvahp_mini,lv9)
		else
			--if rannum<=96 then
			if rannum<=94 then
				num=mathrandom(lvahp_mini,lv9)
			else
				num=mathrandom(lv9+1,lvahp)
				lv10=true
				if num>=rint((lvahp-lvahp_mini)*0.8+lvahp_mini) then 
					chense=true
				end
			end
		end
		return (itype-1)*10000+num,lv10,chense
	elseif itype==2 or itype==3 then
		local lva1act
		if itype==2 then
			 lva1act=rint(itemlv*baseact*3/2)
		else
			 lva1act=rint(itemlv*baseact*3*0.8/2)
		end
		local lvahp_mini=rint(lva1act*0.35)
		--local lv9=rint((lva1act-lvahp_mini)*0.8+lvahp_mini)
		local lv9=rint((lva1act-lvahp_mini)*0.5+lvahp_mini)
		if  mark then
			num=mathrandom(lvahp_mini,lv9)
		else
			--if rannum<=96 then
			if rannum<=94 then
				num=mathrandom(lvahp_mini,lv9)
			else
				num=mathrandom(lv9+1,lva1act)
				lv10=true
				if num>=rint((lva1act-lvahp_mini)*0.8+lvahp_mini) then 
					chense=true
				end
			end
		end
		return itype*10000+num,lv10,chense
	elseif itype>=4 and itype<=8 then	
		local lva1do=rint(itemlv*basedodge*3/1.5)
		local lvahp_mini=rint(lva1do*0.35)
		--local lv9=rint((lva1do-lvahp_mini)*0.8+lvahp_mini)
		local lv9=rint((lva1do-lvahp_mini)*0.5+lvahp_mini)
		if  mark then
			num=mathrandom(lvahp_mini,lv9)
		else
			--if rannum<=96 then
			if rannum<=94 then
				num=mathrandom(lvahp_mini,lv9)
			else
				num=mathrandom(lv9+1,lva1do)
				lv10=true
				if num>=rint((lva1do-lvahp_mini)*0.8+lvahp_mini) then 
					chense=true
				end
			end
		end
		return itype*10000+num,lv10,chense
	else 
		return false
	end
end
--�õ�ϴ������,����װ����ɫ,��������
local function getmaxxl(equipcolor,locknum)
	if equipcolor==1 then 
		if locknum<3 then 
			return mathrandom(locknum+1,3)
		else 
			return false
		end
	elseif equipcolor==2 then 
		if locknum<2 then 
			return mathrandom(locknum+2,4)
		elseif locknum>=2 and locknum<4 then
			return mathrandom(locknum+1,4)
		else 
			return false	
		end
	elseif equipcolor==3 then 
		if locknum<3 then 
			return mathrandom(3,5)
		elseif locknum>=3 and locknum<5 then
			return mathrandom(locknum+1,5)
		else 
			return false
		end
	elseif equipcolor==4 or equipcolor== 5 then 
		if locknum<4 then 
			return mathrandom(4,5)
		elseif locknum==4 then
			return 5
		else 
			return false
		end
	end
end
--��ʼϴ��
function Enhance_XL(playerid,xl)
	-- look(xl,1)
	if playerid==nil or xl==nil or type(xl)~=type({}) then
		look("XLdata_inerror")
		return
	end
	local site=xl.site
	local equip=xl.equip
	local lock=xl.lock
	local usemoney=xl.autobuy
	local useitem=xl.useitem--ʹ�ö��ٸ�ϴ��������
	local left_xlst=0---��Ǯϴ��ʯ��Ҫ�۳�����ʣ��ʯͷ
	local need=1-----1Ϊ����ϴ��ʯ��2Ϊ����Ԫ��
	local lock_num=0--��������
	
	if equip == nil  or site== nil  or lock==nil or usemoney==nil or useitem==nil  then
		look('EnhanceEquip:arg is nil.')
		return
	end
	local detail = CI_GetEquipDetails(site,equip)--=========��ȡװ��ֵ
	if detail == nil then
		look('EnhanceEquip:detail == nil.')
		return
	end
	if detail.type>108 then
		TipCenter( GetStringMsg(435))
		return
	end
	local noweqlv=detail.levelEM--ȡװ���ȼ�
	local nowcolor=detail.quality--ȡ��ɫ
	if  noweqlv==nil or nowcolor==nil then 
		return 
	end
	local xlid,xlnum=xlstongid_num(noweqlv,nowcolor)--�õ�ʯͷ�����)
	local need_xlmoney=xlmoney[xlid-603]--��Ҫϴ��ʯ��Ǯ
	if xlid==nil or xlnum==nil or xlid<604 or xlid>606  then 
		return 
	end
	local need_lock_num=0
	for i=1,5 do
		if lock[i] == true then 
			lock_num=lock_num+1
			detail.properties[lock_num]=detail.properties[i]
		end
	end
	if useitem <=lock_num then
		need_lock_num=lock_num-useitem
		if useitem>0 then
			if CheckGoods( useitemid, useitem, 1, playerid)==0 then--��ϴ��������
				return
			end
		end
	end
	if not CheckCost( playerid , need_lock_num*10 , 1 , 1, "װ��ϴ��") then
		--look('Ǯ����')
		return
	end
	local left_xl
	if CheckGoods( xlid, xlnum, 1, playerid,'��ʯͷ����') == 0 then--��ʯͷ�ڲ�(����)
		if usemoney==false then--����Ǯ
			return
		else
			left_xl=xl.left
			if left_xl==nil then return end
			left_xlst=xlnum-left_xl
			if CheckGoods( xlid, left_xl, 1, playerid,'ϴ��ʯ') == 0 then
				return
			end
			
			need_xlmoney=need_xlmoney*left_xlst+need_lock_num*10
			if not CheckCost( playerid , need_xlmoney , 1 , 1, "װ��ϴ��") then--�ö���Ǯ��ȷ��
				TipCenter(GetStringMsg(144))
				return
			end
			need=2
		end
	end
	local v_itype={}----��Ҫ����������
	for i=1,lock_num do--�õ�����װ����������ֵ
		v_itype[i]=rint(detail.properties[i]/10000)
		if v_itype[i]==0 then
			v_itype[i]=1
		end
	end
	
	local xlmax=getmaxxl(nowcolor,lock_num)--ϴ���ܵõ��������
	if xlmax==false then 
		rflase("xlmax_error") 
		return 
	end
	local endtab=Get_num(v_itype,xlmax,{1,8})--���õ�����ֵ
	if type(endtab)~=type({}) then 
		return
	end
 
	detail.flags = 1
	local maxlv=false
	local chense=false
	for i = lock_num+1 , xlmax do
		local data,lv10,cs=getnewval(noweqlv,endtab[i],maxlv)
		if lv10 then
			maxlv=true
		end
		if cs then 
			chense=true
		end
		if data then
			detail.properties[i]=data	
		end
	end
	if xlmax<5 then
		for i=xlmax+1,5  do
			detail.properties[i]=0
		end
	end
	if need==1 then
		CheckGoods( xlid, xlnum, 0, playerid,'ϴ��ʯ����')
		if need_lock_num >0 then
			CheckCost( playerid , need_lock_num*10 , 0 , 1,'100004_װ��ϴ��',xlid,left_xl)
		end
	elseif need==2 then
		CheckGoods( xlid, left_xl, 0, playerid,'ϴ��ʯ����')

		CheckCost( playerid ,  need_xlmoney , 0 , 1,'100004_װ��ϴ��',xlid,left_xl)
	end
	if useitem>0 then
		CheckGoods( useitemid, useitem, 0, playerid,'װ��ϴ��')--��ϴ��������
	end
	CI_UpdateEquipDetails(site, detail)
	SendLuaMsg( 0, { ids = Equip_xlres, result = 1 }, 9 )
	-- look(chense,1)
	if chense then
		set_obj_pos(playerid,2005)
	end
	set_obj_pos(playerid,1004)
end
