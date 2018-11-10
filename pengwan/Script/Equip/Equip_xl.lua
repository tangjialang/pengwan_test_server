--[[
file:	Equip_xl.lua
desc:	装备洗炼系统
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

local basehp=10--生命基数
local baseact=2--攻击，防御基数
local basedodge=1--闪避，暴击，命中，抵抗，格挡基数
local xlmoney={2,4,8}
local useitemid=635 --洗练锁道具id
--洗练需要洗炼石id，个数
local function xlstongid_num(itemlv,itemcolor)--装备等级颜色,返回需要的洗炼石等级与个数
	if type(itemlv)~=type(0) or type(itemcolor)~=type(0) then 
		return 
	end
	local getxlstone={1,3,9,9, 9} 
	local num=getxlstone[itemcolor]
	if itemlv>0 and itemlv<40 then
		return 604,num --1级洗炼石id
	elseif itemlv>=40 and itemlv<60 then
		return 605,num --2级洗炼石
	elseif itemlv>=60 and itemlv<=100 then
		return 606,num --3级洗炼石
	end
end

--传入装备等级，属性类型,返回具体数值(包含类型与属性值)
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
		local lv9=rint((lvahp-lvahp_mini)*0.5+lvahp_mini)--修改为678910只出一个20131219
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
--得到洗练条数,传入装备颜色,锁定数量
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
--开始洗炼
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
	local useitem=xl.useitem--使用多少个洗练锁道具
	local left_xlst=0---用钱洗练石需要扣除身上剩余石头
	local need=1-----1为消耗洗炼石，2为消耗元宝
	local lock_num=0--锁定条数
	
	if equip == nil  or site== nil  or lock==nil or usemoney==nil or useitem==nil  then
		look('EnhanceEquip:arg is nil.')
		return
	end
	local detail = CI_GetEquipDetails(site,equip)--=========获取装备值
	if detail == nil then
		look('EnhanceEquip:detail == nil.')
		return
	end
	if detail.type>108 then
		TipCenter( GetStringMsg(435))
		return
	end
	local noweqlv=detail.levelEM--取装备等级
	local nowcolor=detail.quality--取颜色
	if  noweqlv==nil or nowcolor==nil then 
		return 
	end
	local xlid,xlnum=xlstongid_num(noweqlv,nowcolor)--得到石头与个数)
	local need_xlmoney=xlmoney[xlid-603]--需要洗炼石的钱
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
			if CheckGoods( useitemid, useitem, 1, playerid)==0 then--查洗练锁道具
				return
			end
		end
	end
	if not CheckCost( playerid , need_lock_num*10 , 1 , 1, "装备洗练") then
		--look('钱不够')
		return
	end
	local left_xl
	if CheckGoods( xlid, xlnum, 1, playerid,'查石头数量') == 0 then--查石头在不(不够)
		if usemoney==false then--不用钱
			return
		else
			left_xl=xl.left
			if left_xl==nil then return end
			left_xlst=xlnum-left_xl
			if CheckGoods( xlid, left_xl, 1, playerid,'洗炼石') == 0 then
				return
			end
			
			need_xlmoney=need_xlmoney*left_xlst+need_lock_num*10
			if not CheckCost( playerid , need_xlmoney , 1 , 1, "装备洗练") then--用多少钱再确定
				TipCenter(GetStringMsg(144))
				return
			end
			need=2
		end
	end
	local v_itype={}----需要锁定的类型
	for i=1,lock_num do--得到现在装备属性类型值
		v_itype[i]=rint(detail.properties[i]/10000)
		if v_itype[i]==0 then
			v_itype[i]=1
		end
	end
	
	local xlmax=getmaxxl(nowcolor,lock_num)--洗炼能得到最多条数
	if xlmax==false then 
		rflase("xlmax_error") 
		return 
	end
	local endtab=Get_num(v_itype,xlmax,{1,8})--最后得到类型值
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
		CheckGoods( xlid, xlnum, 0, playerid,'洗炼石个数')
		if need_lock_num >0 then
			CheckCost( playerid , need_lock_num*10 , 0 , 1,'100004_装备洗炼',xlid,left_xl)
		end
	elseif need==2 then
		CheckGoods( xlid, left_xl, 0, playerid,'洗炼石个数')

		CheckCost( playerid ,  need_xlmoney , 0 , 1,'100004_装备洗炼',xlid,left_xl)
	end
	if useitem>0 then
		CheckGoods( useitemid, useitem, 0, playerid,'装备洗炼')--查洗练锁道具
	end
	CI_UpdateEquipDetails(site, detail)
	SendLuaMsg( 0, { ids = Equip_xlres, result = 1 }, 9 )
	-- look(chense,1)
	if chense then
		set_obj_pos(playerid,2005)
	end
	set_obj_pos(playerid,1004)
end
