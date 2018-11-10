 --[[
file:Mounts_Equip.lua
desc:����װ��
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

--����װ����(ǿ��/��Ʒ/����)
--idx װ������ goodid ���� num�����в��ϸ��� tp 1 ǿ�� 2 ��Ʒ 3 ���� ism �Ƿ�Ԫ�� 0 �� 1 Ҫ����Ʒ��
function mount_equip_up(sid,idx,tp,goodid1,num1,goodid2,num2,ism)
	--look('*****************************************************'..idx..','..tp..','..goodid1..','..num1)
	local data = GetMountsData(sid)
	if(nil == data)then
		return false,1  --û����������
	end
	
	local playerLv=CI_GetPlayerData(1)
	if(playerLv<MouseEquipConf.openLevel[1])then --��ɫ�ȼ�����
		return false,2
	end
	
	--look('****5*****')
	
	local lv = data.lv --�����ȼ�
	if(lv<MouseEquipConf.openLevel[2])then --�����������
		return false,3
	end
	
	if(idx<1 or idx>MouseEquipConf.maxnum)then
		return false,12 --�޴�װ��
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
	
	if(equlv == nil)then return false,12 end --װ��������
	
	local mq = math_floor(equlv/1000000) --Ʒ��
	local mlv = math_floor(equlv%1000) --ǿ���ȼ�
	local mklv = math_floor(math_floor(equlv/1000)%1000) --���Ƶȼ�
	--look('****3*****')
	local conf = MouseEquipConf[mq]
	if(conf == nil)then return false,4 end --���ó���
	local maxlv = MouseEquipConf.lv[mq]
	if(maxlv == nil)then return false,4 end --���ó���
	
	if(tp == 1)then --ǿ��
		--look('****1*****')
		if(mlv>=maxlv)then return false,5 end --ǿ������߼�
		local t = conf.t
		local good1 = MouseEquipConf.hardlv.goodid1[t]
		local cost = MouseEquipConf.hardlv.cost1[t]
		local good2 = MouseEquipConf.hardlv.goodid2[mq]
		if(goodid1 ~= good1 or goodid2 ~= good2)then return false,6 end --���ϲ���
		local need1 = MouseEquipConf.hardlv.num1[mq] --��û�й�ʽ
		local need2 = MouseEquipConf.hardlv.num2[mq] --ͬ��
		local needMoney = MouseEquipConf.hardlv.money[mq]
		local needYB = 0
		if(need1 == nil or need1<=0 or need2 == nil or need1<=0)then return false,4 end
		if(need1>num1)then --����������Ǯ
			if(ism == 1)then
				needYB = (need1 - num1)*cost
			else
				return false,7 --ǿ�����ϲ���
			end
		else
			num1 = need1
		end
		if(needYB>0 and (not CheckCost(sid, needYB,1,1,"����װ��ǿ��")))then return false,10 end --Ԫ������
		if(need2>num2)then
			return false,7 --ǿ�����ϲ���
		end
		if((num1>0 and CheckGoods(goodid1,num1,1,sid,'����װ��ǿ��')==0) or (need2>0 and CheckGoods(goodid2,need2,1,sid,'����װ��ǿ��')==0))then
			return false,7 --���ϲ���
		end
		--look('****2*****')
		if(not CheckCost(sid, needMoney,1,3,"����װ��ǿ��"))then return false,14 end --ͭǮ����
		mlv =  mlv+1
		equdata[idx] = mq*1000000 + mklv*1000 + mlv
		CheckGoods(goodid1,num1,0,sid,"����װ��ǿ��")
		CheckGoods(goodid2,need2,0,sid,"����װ��ǿ��")
		CheckCost(sid, needMoney,0,3,"����װ��ǿ��")
		if(needYB>0)then
			CheckCost(sid,needYB,0,1,"����װ��ǿ��")
		end
		--look(mlv..'*****************************************************')
		
		AddMountsAtt(sid)
		
		local isq
		
		if(mlv>=maxlv and mq<MouseEquipConf.mxlv)then
			isq = 1
		end
		
		return true,equdata,mlv,isq
	elseif(tp == 2)then --��Ʒ 
		if(mq>=MouseEquipConf.mxlv)then return false,8 end --Ʒ���Ѵ����
		if(mlv<maxlv)then return false,11 end --��������Ʒ
		local conf1 = MouseEquipConf.uplv[mq]
		if(conf1 == nil)then return false,4 end
		--{lv = 30,up = {{21,10},10},}
		if(lv<conf1.lv)then return false,9 end --����ȼ�����
		local good1 = conf1.up[1][1]
		local need1 = conf1.up[1][2]
		local cost = conf1.up[2]
		local needMoney = 0
		if(good1~=goodid1)then return false,6 end --���ϲ���
		if(need1 == nil or need1<=0)then return false,4 end
		if(need1>num1)then
			if(ism == 0)then return false,7 end --��Ʒ���ϲ��㻹����Ǯ
			needMoney = (need1 - num1)*cost --��Ҫ����Ǯ
			need1 = num1
		end
		
		if((need1>0 and CheckGoods(goodid1,need1,1,sid,'����װ����Ʒ')==0))then
			return false,7 --���ϲ���
		end
		
		if(needMoney>0 and (not CheckCost(sid, needMoney,1,1,"����װ����Ʒ")))then return false,10 end --Ԫ������
		
		mq = mq + 1
		equdata[idx] = mq*1000000 + mklv*1000 + 1
		if(need1>0)then
			CheckGoods(goodid1,need1,0,sid,"����װ����Ʒ")
		end
		if(needMoney>0)then
			CheckCost(sid,needMoney,0,1,"����װ����Ʒ")
		end
		
		AddMountsAtt(sid)
		
		return true,equdata,mq
	elseif(tp == 3)then --����
		if(mklv>=MouseEquipConf.kwmxlv)then return false,13 end --���Ƶȼ�������
		if(MouseEquipConf.kwGoodid~=goodid1)then return false,6 end --���ϲ���
		local need1 = math_floor(mklv/5+5) --�ȹ�ʽ
		if(need1<=0)then return false,4 end
		local needMoney = mklv == 0 and 50000 or (40000 + mklv*10000)
		--look('needmoney='..needMoney)
		if(need1>num1)then return false,7 end --���Ʋ��ϲ���
		if(not CheckCost(sid, needMoney,1,3,"����װ��ǿ��"))then return false,14 end --ͭǮ����
		if(need1>0 and CheckGoods(goodid1,need1,1,sid,'����װ������')==0)then
			return false,7
		end
		mklv = mklv+1
		equdata[idx] = mq*1000000 + mklv*1000 + mlv
		CheckGoods(goodid1,need1,0,sid,"����װ������")
		CheckCost(sid, needMoney,0,3,"����װ������")
		
		AddMountsAtt(sid)
		
		return true,equdata,mklv
	end
end
