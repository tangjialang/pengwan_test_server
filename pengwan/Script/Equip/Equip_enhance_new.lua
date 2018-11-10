--[[
file:	Equip_enhance_wk.lua
desc:	装备强化系统
author:	wk
update:	2012-12-26
refix:	done by wk
]]--
local rint = rint
local mathrandom = math.random
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local equip_up	 = msgh_s2c_def[23][2]	
local star_up	 = msgh_s2c_def[23][13]	
local TipCenter,GetStringMsg,isFullNum	 = TipCenter,GetStringMsg,isFullNum
local CI_GetEquipDetails = CI_GetEquipDetails
local CI_UpdateEquipDetails	 = CI_UpdateEquipDetails
local CheckGoods	 = CheckGoods
local CheckCost	 = CheckCost
local GiveGoods=GiveGoods
local look = look
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos
--==当前装备能强化最大级别
local lv_max={
[20]={9,9,9,12},
[25]={12,12,12,15},
[30]={12,12,12,15},
[35]={15,15,15,18},
[40]={15,15,15,18},
[45]={18,18,18,21},
[50]={18,18,18,21},
[55]={21,21,21,24},
[60]={21,21,21,24},
[65]={24,24,24,27},
[70]={24,24,24,27},
[75]={27,27,27,30},
[80]={27,27,27,30},
[85]={30,30,30,33},
[90]={30,30,30,33},
[95]={33,33,33,36},
[100]={33,33,33,36, 42},
}
local color={5,7,7.5, 12, 12}--消耗游戏币颜色基数
--强化基本成功率
local function Enhance_rate(lv)
	if lv>=11 then
		return 10
	elseif  lv>=3 then
		return 100-(lv-2)*10
	else
		return 100
	end
end
local function vipup( playerid )
	local viplv = GI_GetVIPLevel(playerid)
	if viplv<4 then 
		return 0
	elseif viplv<7 then 
		return 5
	else
		return 10
	end
end

--开始强化
function Enhance_Equip(playerid,enhance)

	if playerid==nil or enhance==nil then return end
	local site=enhance.site
	local equip=enhance.equip
	local stoneid=enhance.stoneid
	--look(enhance,1)
	if equip == nil or stoneid == nil or site== nil then
		look('EnhanceEquip:arg is nil.')
		return
	end
	local detail = CI_GetEquipDetails(site,equip)--=========获取装备值
	if detail == nil then
		look('EnhanceEquip:detail == nil.',1)
		return
	end
	if detail.type>108 then
		TipCenter( GetStringMsg(435))
		return
	end
--	look(detail)
	local nowlv=detail.level--取强化等级
	local noweqlv=detail.levelEM--取装备等级
	local nowcolor=detail.quality--取颜色
	if nowlv==nil or noweqlv==nil or nowcolor==nil then return end
	local maxlv
	if nowcolor~=0 then  
		maxlv=lv_max[noweqlv][nowcolor]
	else 
		maxlv=6 --白色统一最大强化到5级
		nowcolor=1
	end
	-- look(maxlv)
	-- look(nowcolor)
	-- look(detail)
	local need_money=rint((noweqlv+15)*(nowlv+1)^2*color[nowcolor]^1.2/1.5)
	if maxlv<=nowlv then 
		return
	end
	if not CheckCost(playerid, need_money,1,3) then
		return
	end

	if stoneid>=610 and stoneid<=618 then 
		if not (CheckGoods(stoneid, 1,0,playerid,'强化') == 1) then
			return
		else
			local vip=vipup( playerid )
			local ratenum=Enhance_rate(nowlv)+(stoneid-609)*10+vip--强化石增加成功率
			-- if nowcolor==4 and ratenum<100 then 
				-- if noweqlv>=10 then 
				-- 	ratenum=ratenum-15
				-- 	if ratenum<5 then 
				-- 		ratenum=5
				-- 	end
				-- end
			-- end

			local num=mathrandom(1,100)
			if num<=ratenum then
				detail.level=nowlv+1
				CI_UpdateEquipDetails(site, detail)--===更新装备属性
				SendLuaMsg(0,{ids=equip_up,succ=1},9)
				if nowlv+1==10 then
					set_obj_pos(playerid,1003)
				-- elseif nowlv+1==15 then
				-- 	set_obj_pos(playerid,2005)
				end
			else 
				SendLuaMsg(0,{ids=equip_up,succ=0},9)
				
			end
		end
	elseif stoneid==0 then 
		local vip=vipup( playerid )
		local ratenum=Enhance_rate(nowlv)+vip

		-- if nowcolor==4 and ratenum<100 then 
		-- 	if noweqlv>=10 then 
		-- 		ratenum=ratenum-15
		-- 		if ratenum<5 then 
		-- 			ratenum=5
		-- 		end
		-- 	end
		-- end

		local num=mathrandom(1,100)
		if num<=ratenum then
			detail.level=nowlv+1
			local ww=CI_UpdateEquipDetails(site, detail)--===更新装备属性
			SendLuaMsg(0,{ids=equip_up,succ=1},9)
			if nowlv+1==10 then
				set_obj_pos(playerid,1003)
			elseif nowlv+1==15 then
				set_obj_pos(playerid,2005)
			end
		else 
			SendLuaMsg(0,{ids=equip_up,succ=0},9)
		
		end
	end
	if nowcolor==4 then
		set_obj_pos(playerid,3002)
	end
	CheckCost(playerid, need_money,0,3,'强化')
	
end		
--装备还原
function Restore_Equip(playerid,outst,id,x,y)

	if  playerid==nil or outst==nil or type(outst)~=type({}) then  return end
	local i_type=outst.itype
	if i_type==nil then
		look("i_type is error")
		return
	end
	if i_type~=0 and  i_type~=1 then
		look("i_type is error")
		return
	end
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
	local nowlv=detail.level--取强化等级
	local noweqlv=detail.levelEM--取装备等级
	local nowcolor=detail.quality--取颜色
	if nowcolor==0 then 
		nowcolor=1
	end
	if nowlv==nil or noweqlv==nil or nowcolor==nil then return end

	local need_money=rint((noweqlv+15)*(nowlv*(nowlv+1)*(2*nowlv+1)/6)*color[nowcolor]^1.2/1.5)
	detail.level=0

	if id~=nil then
		Fast_Sale(playerid,id,1,x,y)
	else
		if i_type==1 then
			UpdateItemDetails(outst.equip, detail)--===更新装备属性
		else
			CI_UpdateEquipDetails(site, detail)
		end
		SendLuaMsg(0,{ids=equip_up,succ=3},9)
	end
	GiveGoods(0,need_money,0,'强化还原')	
	
end

---------装备升星------------------
function equip_starup( playerid,enhance )
	-- body
	-- levelEx

	if playerid==nil or enhance==nil then return end
	local site=enhance.site
	local equip=enhance.equip
	
	--look(enhance,1)
	if equip == nil  or site== nil then
		look('EnhanceEquip:arg is nil.')
		return
	end
	local detail = CI_GetEquipDetails(site,equip)--=========获取装备值
	if detail == nil then
		look('EnhanceEquip:detail == nil.',1)
		return
	end
	if detail.type>108 then
		TipCenter( GetStringMsg(435))
		return
	end

	-- local nowlv=detail.level--取强化等级
	-- local noweqlv=detail.levelEM--取装备等级

	local nowcolor=detail.quality--取颜色
	if nowcolor<3 then return end
	local levelEx=detail.levelEx---星级
	if levelEx>=500 then return end

	local neednum=(rint((levelEx+1)/3)+1)*3
	if not (CheckGoods(803, neednum,0,playerid,'装备升星') == 1) then
		return
	end

	detail.levelEx=levelEx+1
	CI_UpdateEquipDetails(site, detail)--===更新装备属性
	
	SendLuaMsg(0,{ids=star_up,res=1},9)
end

