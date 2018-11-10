 --[[
file:Mounts_Equip.lua
desc:坐骑装备
author:xiao.y
]]--
--------------------------------------------------------------------------
--include:
local GetMountsData = GetMountsData
local CI_GetPlayerData = CI_GetPlayerData
local math_floor = math.floor
local CheckGoods = CheckGoods
local CheckCost = CheckCost
local AddMountsAtt = AddMountsAtt
--------------------------------------------------------------------------
-- data:

function mount_equip_clr(sid)
	local data = GetMountsData(sid)
	if(data~=nil and data.equ~=nil)then
		data.equ = nil
	end
end

--坐骑装备的(强化/升品/刻纹)
--idx 装备索引 goodid 材料 num背包中材料个数 tp 1 强化 2 升品 3 刻纹 ism 是否花元宝 0 不 1 要（升品）
function mount_equip_up(sid,idx,tp,goodid1,num1,goodid2,num2,ism)
	--look('*****************************************************'..idx..','..tp..','..goodid1..','..num1)
	local data = GetMountsData(sid)
	if(nil == data)then
		return false,1  --没有坐骑数据
	end
	
	local playerLv=CI_GetPlayerData(1)
	if(playerLv<MouseEquipConf.openLevel[1])then --角色等级不足
		return false,2
	end
	
	--look('****5*****')
	
	local lv = data.lv --进化等级
	if(lv<MouseEquipConf.openLevel[2])then --坐骑阶数不足
		return false,3
	end
	
	if(idx<1 or idx>MouseEquipConf.maxnum)then
		return false,12 --无此装备
	end
	
	--look('****4*****')
	
	if(data.equ == nil)then
		data.equ = {}
	end
	
	local equdata = data.equ
	local equlv
	
	if(tp == 1 or tp == 3)then
		equlv = equdata[idx] or 1000000
	else
		equlv = equdata[idx]
	end
	
	if(equlv == nil)then return false,12 end --装备不存在
	
	local mq = math_floor(equlv/1000000) --品质
	local mlv = math_floor(equlv%1000) --强化等级
	local mklv = math_floor(math_floor(equlv/1000)%1000) --刻纹等级
	--look('****3*****')
	local conf = MouseEquipConf[mq]
	if(conf == nil)then return false,4 end --配置出错
	local maxlv = MouseEquipConf.lv[mq]
	if(maxlv == nil)then return false,4 end --配置出错
	
	if(tp == 1)then --强化
		--look('****1*****')
		if(mlv>=maxlv)then return false,5 end --强化到最高级
		local t = conf.t
		local good1 = MouseEquipConf.hardlv.goodid1[t]
		local cost = MouseEquipConf.hardlv.cost1[t]
		local good2 = MouseEquipConf.hardlv.goodid2[mq]
		if(goodid1 ~= good1 or goodid2 ~= good2)then return false,6 end --材料不对
		local need1 = MouseEquipConf.hardlv.num1[mq] --还没有公式
		local need2 = MouseEquipConf.hardlv.num2[mq] --同上
		local needMoney = MouseEquipConf.hardlv.money[mq]
		local needYB = 0
		if(need1 == nil or need1<=0 or need2 == nil or need1<=0)then return false,4 end
		if(need1>num1)then --不够还不花钱
			if(ism == 1)then
				needYB = (need1 - num1)*cost
			else
				return false,7 --强化材料不足
			end
		else
			num1 = need1
		end
		if(needYB>0 and (not CheckCost(sid, needYB,1,1,"坐骑装备强化")))then return false,10 end --元宝不足
		if(need2>num2)then
			return false,7 --强化材料不足
		end
		if((num1>0 and CheckGoods(goodid1,num1,1,sid,'坐骑装备强化')==0) or (need2>0 and CheckGoods(goodid2,need2,1,sid,'坐骑装备强化')==0))then
			return false,7 --材料不足
		end
		--look('****2*****')
		if(not CheckCost(sid, needMoney,1,3,"坐骑装备强化"))then return false,14 end --铜钱不足
		mlv =  mlv+1
		equdata[idx] = mq*1000000 + mklv*1000 + mlv
		CheckGoods(goodid1,num1,0,sid,"坐骑装备强化")
		CheckGoods(goodid2,need2,0,sid,"坐骑装备强化")
		CheckCost(sid, needMoney,0,3,"坐骑装备强化")
		if(needYB>0)then
			CheckCost(sid,needYB,0,1,"坐骑装备强化")
		end
		--look(mlv..'*****************************************************')
		
		AddMountsAtt(sid)
		
		local isq
		
		if(mlv>=maxlv and mq<MouseEquipConf.mxlv)then
			isq = 1
		end
		
		return true,equdata,mlv,isq
	elseif(tp == 2)then --升品 
		if(mq>=MouseEquipConf.mxlv)then return false,8 end --品质已达最高
		if(mlv<maxlv)then return false,11 end --还不能升品
		local conf1 = MouseEquipConf.uplv[mq]
		if(conf1 == nil)then return false,4 end
		--{lv = 30,up = {{21,10},10},}
		if(lv<conf1.lv)then return false,9 end --坐骑等级不足
		local good1 = conf1.up[1][1]
		local need1 = conf1.up[1][2]
		local cost = conf1.up[2]
		local needMoney = 0
		if(good1~=goodid1)then return false,6 end --材料不对
		if(need1 == nil or need1<=0)then return false,4 end
		if(need1>num1)then
			if(ism == 0)then return false,7 end --升品材料不足还不花钱
			needMoney = (need1 - num1)*cost --需要花的钱
			need1 = num1
		end
		
		if((need1>0 and CheckGoods(goodid1,need1,1,sid,'坐骑装备升品')==0))then
			return false,7 --材料不足
		end
		
		if(needMoney>0 and (not CheckCost(sid, needMoney,1,1,"坐骑装备升品")))then return false,10 end --元宝不足
		
		mq = mq + 1
		equdata[idx] = mq*1000000 + mklv*1000 + 1
		if(need1>0)then
			CheckGoods(goodid1,need1,0,sid,"坐骑装备升品")
		end
		if(needMoney>0)then
			CheckCost(sid,needMoney,0,1,"坐骑装备升品")
		end
		
		AddMountsAtt(sid)
		
		return true,equdata,mq
	elseif(tp == 3)then --刻纹
		if(mklv>=MouseEquipConf.kwmxlv)then return false,13 end --刻纹等级达上限
		if(MouseEquipConf.kwGoodid~=goodid1)then return false,6 end --材料不对
		local need1 = math_floor(mklv/5+5) --等公式
		if(need1<=0)then return false,4 end
		local needMoney = mklv == 0 and 50000 or (40000 + mklv*10000)
		--look('needmoney='..needMoney)
		if(need1>num1)then return false,7 end --刻纹材料不足
		if(not CheckCost(sid, needMoney,1,3,"坐骑装备强化"))then return false,14 end --铜钱不足
		if(need1>0 and CheckGoods(goodid1,need1,1,sid,'坐骑装备刻纹')==0)then
			return false,7
		end
		mklv = mklv+1
		equdata[idx] = mq*1000000 + mklv*1000 + mlv
		CheckGoods(goodid1,need1,0,sid,"坐骑装备刻纹")
		CheckCost(sid, needMoney,0,3,"坐骑装备刻纹")
		
		AddMountsAtt(sid)
		
		return true,equdata,mklv
	end
end
