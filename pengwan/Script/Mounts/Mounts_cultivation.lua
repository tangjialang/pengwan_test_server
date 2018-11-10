--[[
file:Mounts_cultivation.lua
desc:�������
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
	--[����ID] = ���ȼ����ޣ��ȼ����ޣ�����ֵ��
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

local tempexp={nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}---���׵���һ�׵õ�����
local tempned={nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}---�ӵ����˵���

function MountUpFromGoodsExp(sid,goodid)
	local data = GetMountsData(sid)
	if(nil == data)then
		return false,1  --û����������
	end
	local lv = data.lv --�����ȼ�
	local oldlv = lv
	if(lv>=MouseChgeConf.mxlv)then
		return false,2 --����ﵽ��������
	end
	
	local tb = mount_goodconf[goodid]
	if(tb == nil)then
		return false,3 --���߷Ƿ�
	end
	if(lv<tb[1])then
		return false,4 --�ȼ�����
	end
	local isup = 0
	local cidx = 0 --�½����Ļû�����
	
	if(lv>=tb[2])then --���ڼӾ���
		if(tb[3] == 0)then
			return false,5
		end
	
		local isElse = 0
		local isChg = 0
		local proc = (data.proc == nil and 0) or data.proc  --��������
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
		if(lv>oldlv)then --������
			data.lv = lv
		end
	else --������ֱ������
		data.lv = lv + 1
	end
	
	if(data.lv>oldlv)then --������
		if(data.lv>=MouseChgeConf.mxlv)then --��ͷ�ˣ��������
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
	local goodid = 3000 --���׵�
	if(nil == data)then
		return false,1  --û����������
	end
	
	local lv = data.lv --�����ȼ�
	if(lv>=MouseChgeConf.mxlv)then
		return false,2 --����ﵽ��������
	end
	
	if(data.lv<20)then
		return false,3 --�����������20��
	end
	
	data.lv = lv + 1
	
	local isup = 0
	local cidx = 0 --�½����Ļû�����
	if(data.lv>lv)then --������
		if(data.lv>=MouseChgeConf.mxlv)then --��ͷ�ˣ��������
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
					  
--��������
--sid����ID
--ctype �������� 0 ������ 1 ���߲��㻨Ԫ��
--num	���߸���
function CultivateProc(sid,ctype,num1,itype)	
	look('CultivateProc')
	local data = GetMountsData(sid)
	local isBT = false
	if(nil == data)then
		return false,1  --û����������
	end
	
	local lv = data.lv --�����ȼ�
	--[[
	if(lv>=70)then
		TipCenter('����8����δ���ţ�')
		return false,5
	end
	]]--
	local oldlv = lv
	if(lv>=MouseChgeConf.mxlv)then
		return false,2 --����ﵽ��������
	end
	
	if(lv>=MouseChgeConf.uplv)then --��ʼ�����̬ģʽ
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
	local needsB --��Ҫ�����ǵ�����
	local goodid
	local cost
	local spend
	local nextproc
	local addproc
	local isup
	local cidx = 0 --�½����Ļû�����
	local isBVal
	local vipLv = GI_GetVIPLevel(sid)
	local isElse = 0
	local isChg = 0
	local num
	local errIdx
	for i=1,maxTime do
		num = num1	
		proc = (data.proc == nil and 0) or data.proc  --��������
		isfree = CheckTimes(sid,uv_TimesTypeTb.MOUNT_Free,1,-1,1)
		
		goodid = MouseChgeConf.good[1] --����ID
		cost = MouseChgeConf.good[2] --����Ԫ����
		bgoodid = MouseChgeConf.good1
		if(isBT)then
			needs = math_floor(lv/4)
			needsB = math_floor(lv/3)
		else
			-- INT((�޽�-1)/5)+1
			needs = math_floor(lv/5)+1 --��Ҫ�ĵ�����
			needsB = null
		end
		
		spend = 0 --��Ҫ���ѵ�Ԫ����
		if(not isfree)then
			if(needsB~=nil)then
				if(CheckGoods(bgoodid,needsB,1,sid,'�������')==0)then
					if(i == 1)then
						return false,5 --��Ҫ���ǵ���������
					else
						errIdx = 5
						break
					end
				end
			end
		
			--Ҫ��Ǯ��
			if(ctype == 0)then --����Ԫ��
				if(CheckGoods(goodid,needs,1,sid,'�������')==0)then
					if(i == 1)then
						return false,3 --û���㹻����
					else
						errIdx = 3
						break
					end
				end
			else --���߲����Ԫ��
				if(num<needs)then
					spend = (needs - num)*cost
					if(num>0 and CheckGoods(goodid,num,1,sid,'�������')==0)then
						if(i == 1)then
							return false,3 --û���㹻����
						else
							errIdx = 3
							break
						end
					end
					if(not CheckCost(sid, spend,1,1,"�������"))then
						if(i == 1)then
							return false,4 --Ԫ������
						else
							errIdx = 4
							break
						end
					end
				else
					if(CheckGoods(goodid,needs,1,sid,"�������")==0)then
						if(i == 1)then
							return false,3 --û���㹻����
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
		
		if(vipLv>3)then --vip4�Ż��б���
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
			addMountPt(sid,addproc) --�ӳ齱��
			CheckTimes(sid,uv_TimesTypeTb.MOUNT_Free,1,-1)
		else
			if(needsB~=nil)then
				CheckGoods(bgoodid,needsB,0,sid,'100002_�������')
			end
		
			--�۶�����
			if(spend>0)then --Ҫ��Ԫ��
				if(num>0)then
					CheckGoods(goodid,num,0,sid,'100002_�������'..isBVal)
					num1 = 0
				end
				CheckCost(sid,spend,0,1,"100002_�������"..isBVal)
			else
				CheckGoods(goodid,needs,0,sid,"100002_�������"..isBVal)
				num1 = num1 - needs
				if(num1<0)then num1 = 0 end
			end
			addproc = needs
			addMountPt(sid,addproc) --�ӳ齱��
		end
		
		tempexp[i]=isBVal
		tempned[i]=addproc
		cidx = 0
		
		if(isBVal == 10)then
			BroadcastRPC('BJ_Notice',0,CI_GetPlayerData(3),isBVal,sid)
		end
		
		if(lv>oldlv)then --������
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