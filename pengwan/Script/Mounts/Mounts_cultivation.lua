--[[
file:Mounts_cultivation.lua
desc:坐骑进化
author:xiao.y
update:2013-7-1
refix:	done by xy
]]--
--------------------------------------------------------------------------
--include:
local uv_TimesTypeTb = TimesTypeTb
local MouseChgeConf = MouseChgeConf
local GetMountsData = GetMountsData
local AddMountsAtt = AddMountsAtt
local MouseChangeProc = MouseChangeProc
local addMountPt = addMountPt
local CheckUnlockStyle = CheckUnlockStyle
local math_floor = math.floor
local math_random = math.random
local CheckGoods = CheckGoods
local CheckCost = CheckCost
local CheckTimes = CheckTimes
local CI_GetPlayerData = CI_GetPlayerData
local BroadcastRPC = BroadcastRPC
local GI_GetVIPLevel = GI_GetVIPLevel
local look = look
--------------------------------------------------------------------------
-- data:

local mount_goodconf = {
	--[道具ID] = ｛等级下限，等级上限，经验值｝
	[3074] = {30,40,0},
	[3075] = {40,50,0},
	[3076] = {50,60,0},
	[3077] = {60,70,0},
	[3078] = {70,80,0},
	[3079] = {80,90,0},
	[3080] = {90,100,0},
	[3011] = {20,30,110}, --20<=lv<30
	[3012] = {30,40,210},
	[3013] = {40,50,400},
	[3014] = {50,60,600},
	[3015] = {60,70,800},
	
	[3037] = {30,40,210}, --20<=lv<30
	[3038] = {40,50,400},
	[3039] = {50,60,600},
	[3040] = {60,70,800},
	[3041] = {70,80,1000},
	[3042] = {80,90,1200},
	[3043] = {90,100,1400},
	
}

local tempexp={nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}---进阶到下一阶得到经验
local tempned={nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}---加的幸运点数

function MountUpFromGoodsExp(sid,goodid)
	local data = GetMountsData(sid)
	if(nil == data)then
		return false,1  --没有坐骑数据
	end
	local lv = data.lv --进化等级
	local oldlv = lv
	if(lv>=MouseChgeConf.mxlv)then
		return false,2 --坐骑达到进化上限
	end
	
	local tb = mount_goodconf[goodid]
	if(tb == nil)then
		return false,3 --道具非法
	end
	if(lv<tb[1])then
		return false,4 --等级不足
	end
	local isup = 0
	local cidx = 0 --新解锁的幻化形象
	
	if(lv>=tb[2])then --高于加经验
		if(tb[3] == 0)then
			return false,5
		end
	
		local isElse = 0
		local isChg = 0
		local proc = (data.proc == nil and 0) or data.proc  --进化进度
		local nextproc
		if(lv<33)then
			nextproc = math_floor(lv/3+2)
		elseif(lv<46)then
			nextproc = math_floor(lv^3/2770)
		else
			nextproc = math_floor(32+(lv-45)*2)
		end
		nextproc = nextproc * 10
		proc = proc + tb[3]
		while(proc>=nextproc and nextproc>0)do
			proc = proc - nextproc
			lv = lv + 1
			if(lv>=MouseChgeConf.mxlv)then
				isElse = 1
				break
			end
			if(lv<33)then
				nextproc = math_floor(lv/3+2)
			elseif(lv<46)then
				nextproc = math_floor(lv^3/2770)
			else
				nextproc = math_floor(32+(lv-45)*2)
			end
			nextproc = nextproc * 10
		end
		if(isElse == 1)then
			data.proc = nil
		else
			data.proc = proc
		end
		if(lv>oldlv)then --升级了
			data.lv = lv
		end
	else --区间中直接升星
		data.lv = lv + 1
	end
	
	if(data.lv>oldlv)then --升级了
		if(data.lv>=MouseChgeConf.mxlv)then --到头了，清除进度
			data.proc = nil
		end
		AddMountsAtt(sid)
		if(data.lv%10 == 0)then
			cidx = CheckUnlockStyle(sid,data.lv)
		end
		isup = 1
	end
	
	return true,data,isup,cidx
end

function MountUpFromGoods(sid)
	local data = GetMountsData(sid)
	local goodid = 3000 --进阶丹
	if(nil == data)then
		return false,1  --没有坐骑数据
	end
	
	local lv = data.lv --进化等级
	if(lv>=MouseChgeConf.mxlv)then
		return false,2 --坐骑达到进化上限
	end
	
	if(data.lv<20)then
		return false,3 --坐骑阶数不足20阶
	end
	
	data.lv = lv + 1
	
	local isup = 0
	local cidx = 0 --新解锁的幻化形象
	if(data.lv>lv)then --升级了
		if(data.lv>=MouseChgeConf.mxlv)then --到头了，清除进度
			data.proc = nil
		end
		AddMountsAtt(sid)
		if(data.lv%10 == 0)then
			cidx = CheckUnlockStyle(sid,data.lv)
		end
		isup = 1
	end
	
	return true,data,isup,cidx
end
					  
--进化坐骑
--sid人物ID
--ctype 进化类型 0 花道具 1 道具不足花元宝
--num	道具个数
function CultivateProc(sid,ctype,num1,itype)	
	look('CultivateProc')
	local data = GetMountsData(sid)
	local isBT = false
	if(nil == data)then
		return false,1  --没有坐骑数据
	end
	
	local lv = data.lv --进化等级
	--[[
	if(lv>=70)then
		TipCenter('坐骑8阶暂未开放！')
		return false,5
	end
	]]--
	local oldlv = lv
	if(lv>=MouseChgeConf.mxlv)then
		return false,2 --坐骑达到进化上限
	end
	
	if(lv>=MouseChgeConf.uplv)then --开始进入变态模式
		isBT = true
	end
	
	for j=1,#tempexp do
		tempexp[j]=nil
		tempned[j]=nil
	end
	local maxTime=1
	if itype then
		maxTime=4
	end
	
	local proc
	local isfree
	local needs
	local needsB --需要的炼骨丹数量
	local goodid
	local cost
	local spend
	local nextproc
	local addproc
	local isup
	local cidx = 0 --新解锁的幻化形象
	local isBVal
	local vipLv = GI_GetVIPLevel(sid)
	local isElse = 0
	local isChg = 0
	local num
	local errIdx
	for i=1,maxTime do
		num = num1	
		proc = (data.proc == nil and 0) or data.proc  --进化进度
		isfree = CheckTimes(sid,uv_TimesTypeTb.MOUNT_Free,1,-1,1)
		
		goodid = MouseChgeConf.good[1] --道具ID
		cost = MouseChgeConf.good[2] --花费元宝数
		bgoodid = MouseChgeConf.good1
		if(isBT)then
			needs = math_floor(lv/4)
			needsB = math_floor(lv/3)
		else
			-- INT((兽阶-1)/5)+1
			needs = math_floor(lv/5)+1 --需要的道具数
			needsB = null
		end
		
		spend = 0 --需要花费的元宝数
		if(not isfree)then
			if(needsB~=nil)then
				if(CheckGoods(bgoodid,needsB,1,sid,'坐骑进化')==0)then
					if(i == 1)then
						return false,5 --需要炼骨丹数量不足
					else
						errIdx = 5
						break
					end
				end
			end
		
			--要花钱了
			if(ctype == 0)then --不花元宝
				if(CheckGoods(goodid,needs,1,sid,'坐骑进化')==0)then
					if(i == 1)then
						return false,3 --没有足够道具
					else
						errIdx = 3
						break
					end
				end
			else --道具不足扣元宝
				if(num<needs)then
					spend = (needs - num)*cost
					if(num>0 and CheckGoods(goodid,num,1,sid,'坐骑进化')==0)then
						if(i == 1)then
							return false,3 --没有足够道具
						else
							errIdx = 3
							break
						end
					end
					if(not CheckCost(sid, spend,1,1,"坐骑进化"))then
						if(i == 1)then
							return false,4 --元宝不足
						else
							errIdx = 4
							break
						end
					end
				else
					if(CheckGoods(goodid,needs,1,sid,"坐骑进化")==0)then
						if(i == 1)then
							return false,3 --没有足够道具
						else
							errIdx = 3
							break
						end
					end
				end
			end
		end
		
		--nextproc = (lv<33 and math_floor(lv/3+2)) or math_floor(lv^3/2770)
		if(lv<33)then
			nextproc = math_floor(lv/3+2)
		elseif(lv<46)then
			nextproc = math_floor(lv^3/2770)
		else
			nextproc = math_floor(32+(lv-45)*2)
		end
		nextproc = nextproc * 10
		isBVal = 1
		
		if(vipLv>3)then --vip4才会有爆击
			local val = RandomInt(1,1000)
			if(val<=300)then
				isBVal = 2
			elseif(val<=330)then
				isBVal = 5
			elseif(val<=340)then
				isBVal = 10
			end			
		end
		-- if __debug then
			-- isBVal = 10
		-- end
		proc = proc + 10*isBVal
		isElse = 0
		isChg = 0
		while(proc>=nextproc and nextproc>0)do
			proc = proc - nextproc
			lv = lv + 1
			if(lv%10 == 0)then
				isChg = lv
			end
			if(lv>=MouseChgeConf.mxlv)then
				isElse = 1
				break
			end
			--nextproc = (lv<33 and math_floor(lv/3+2)) or math_floor(lv^3/2770)
			if(lv<33)then
				nextproc = math_floor(lv/3+2)
			elseif(lv<46)then
				nextproc = math_floor(lv^3/2770)
			else
				nextproc = math_floor(32+(lv-45)*2)
			end
			nextproc = nextproc * 10
		end
		if(isElse == 1)then
			data.proc = nil
		else
			data.proc = proc
		end	
		addproc = 1
		if(isfree)then
			addMountPt(sid,addproc) --加抽奖点
			CheckTimes(sid,uv_TimesTypeTb.MOUNT_Free,1,-1)
		else
			if(needsB~=nil)then
				CheckGoods(bgoodid,needsB,0,sid,'100002_坐骑进化')
			end
		
			--扣东西了
			if(spend>0)then --要扣元宝
				if(num>0)then
					CheckGoods(goodid,num,0,sid,'100002_坐骑进化'..isBVal)
					num1 = 0
				end
				CheckCost(sid,spend,0,1,"100002_坐骑进化"..isBVal)
			else
				CheckGoods(goodid,needs,0,sid,"100002_坐骑进化"..isBVal)
				num1 = num1 - needs
				if(num1<0)then num1 = 0 end
			end
			addproc = needs
			addMountPt(sid,addproc) --加抽奖点
		end
		
		tempexp[i]=isBVal
		tempned[i]=addproc
		cidx = 0
		
		if(isBVal == 10)then
			BroadcastRPC('BJ_Notice',0,CI_GetPlayerData(3),isBVal,sid)
		end
		
		if(lv>oldlv)then --升级了
			data.lv = lv
			AddMountsAtt(sid)
			if(isChg>0)then
				cidx = CheckUnlockStyle(sid,isChg)
			end
			isup = 1
			break
		end
	end
	return true,data,isup,cidx,tempned,tempexp,errIdx
end