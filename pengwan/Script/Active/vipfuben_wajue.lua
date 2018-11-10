 --[[
file:	vipfuben_wajue.lua
desc:	vip����BOSSʬ���ھ�
author:	jkq
update:	2013-12-23
notes:
	wajue_conf:�ھ������Ӧ�����Ԫ���Լ����ֹ�����Ʒ�ĸ���
	
]]--

local active_mgr_m = require('Script.active.active_mgr')
local activitymgr=active_mgr_m.activitymgr
local CheckTimes=CheckTimes
local GetWorldLevel=GetWorldLevel
local uv_TimesTypeTb = TimesTypeTb
local mathrandom = math.random
local CheckCost=CheckCost
local isFullNum = isFullNum
local _CS_GetPlayerTemp = CS_GetPlayerTemp
local GiveGoods = GiveGoods
local RPC = RPC
local ipairs = ipairs
local look = look
local GetStringMsg = GetStringMsg
local TipCenter = TipCenter
local vipwajue_goodsconf = {
	[1] = {								--��ͨ��Ʒ
		[1] = { --����ȼ�0~50
		{738,1,1,1000},{673,1,1,6000},{673,2,1,6010},{673,3,1,6020},{637,10,1,10000},
		},
		[2] = { --����ȼ�50~70
		{738,1,1,1000},{673,1,1,4000},{673,2,1,8000},{673,3,1,8100},{637,10,1,10000},
		},
		[3] = {  --����ȼ�70~����
		{738,1,1,1000},{673,1,1,1100},{673,2,1,4100},{673,3,1,8100},{637,10,1,10000},
		},
	},
	[2] = {								--������Ʒ
		{757,1,1,500},{758,1,1,1500},{759,1,1,2500},{760,1,1,3500},{647,1,1,5000},{652,1,1,9000},{761,1,1,10000},
	},	
	[3] = {								--5�α��ڳ���Ʒ
		{647,1,1,2000},{652,1,1,10000},
	},
}

--�ھ�������ñ�[1] = {0,1}��ʾ��һ���ھ��������Ԫ������   ��  ��ù�����Ʒ�ĸ���
local wajue_conf = {
	[1] = {20,500},
	[2] = {20,500},
	[3] = {20,500},
	[4] = {20,1000},
	[5] = {20,1000},
}

local count = 5 --���w�ھ�����Δ�
local randAdd = 600  --ÿ���ھ��ۼ����Ӹ���

----------------------------------------------------------------------------
-- module:

module(...)

----------------------------------------------------------------------------

local function _boss_wajue(playerid)
		local needMoney = 0   		-- Ҫ���ѵ�Ԫ��
		local wajue_times  	  		-- ���ھ�Ĵ���
		local wajue_times2 = 0			-- ����������Ӵ���
		local rand    		 		-- ��ù�����Ʒ�����
		local needpakage  = 1 	  	-- ��Ҫ�Ŀռ�
		local probalilty      		-- ������Ʒ�ĸ���
		local commongood_id  = 0	-- �����ͨ��Ʒ���
		local preciousgood_id = 0 	-- ��ù�����Ʒ���
		local must_goodid = 0       --����λ�ñ���Ʒ���
		local pCSTemp = _CS_GetPlayerTemp(playerid) 
		 --look('1111111111111')     
		if pCSTemp == nil then return end
		wajue_times = (pCSTemp.vip_c or 0) + 1
		wajue_times2 = (pCSTemp.vip_c2 or 0 ) + 1
		
		if wajue_times > count then 	 -- ʬ���ھ����
			RPC('wajue_getgoods',-1) 	 -- ʬ���ھ����������
			return
		end
		needMoney =  wajue_conf[wajue_times][1]--��Ҫ��Ԫ������
		--look(needMoney)
		if not CheckCost(playerid,needMoney,1,1,'VIP����BOSS�ھ�') then --�ж����Ԫ���Ƿ��㹻
			return 
		end	
		probalilty = wajue_times2 * randAdd
		look("����Ʒ���� = "..probalilty)
		rand = mathrandom(1,10000)
		--look(rand)
		if rand <= probalilty then  --��ָ���ĸ���֮�У����Ը����ص���
			--look("need2")
			needpakage = 2
			pCSTemp.vip_c2 = 0
		else
			pCSTemp.vip_c2 = (pCSTemp.vip_c2 or 0 ) + 1
		end
		if wajue_times == 5 then
			needpakage = needpakage + 1
		end
		--�жϱ����ռ��Ƿ��㹻
		--look('222222222222')
		local pakagenum = isFullNum()
		--look(pakagenum)
		if needpakage > pakagenum  then
			TipCenter(GetStringMsg(14,needpakage))
			return 
		end
		if wajue_times == 5 then  --��������Ʒ
			local Rand_must = mathrandom(10000)
			--look('5555555555555555')
			--look(Rand_must)
			for i,v in ipairs(vipwajue_goodsconf[3]) do
				must_goodid = must_goodid + 1
				look(v[4])
				if Rand_must < v[4] then
					GiveGoods(v[1],v[2],v[3],'VIP����BOSS�ھ�')
					break
				end
			end
			needpakage = needpakage - 1
		end
	
		if needpakage == 2 then--��Ҫ�o���F����Ʒ
			--look('4444444444444')
			--��������
			--���ص��߸���ĸ��ʴ���
			local Rand = mathrandom(10000)
			for i,v in ipairs(vipwajue_goodsconf[2]) do
				preciousgood_id = preciousgood_id + 1
				if(Rand < v[4]) then
					GiveGoods(v[1],v[2],v[3],'VIP����BOSS�ھ�')
					break
				end
			end
		end
		local wlevel = GetWorldLevel() or 40
		local itemlist = vipwajue_goodsconf[1][3]
		if wlevel < 50 then
			itemlist = vipwajue_goodsconf[1][1]
		elseif  wlevel < 70 then
			itemlist = vipwajue_goodsconf[1][2]
		
		end
		
		--��ͨ����������
		local Rand_commom= mathrandom(10000)
		for j,k in ipairs(itemlist) do
			commongood_id = commongood_id + 1
			if(Rand_commom < k[4]) then
				GiveGoods(k[1],k[2],k[3],'VIP����BOSS�ھ�')
				break
			end
		end

		--�۳�Ԫ���͵���
		CheckCost(playerid,needMoney,0,1,'VIP����BOSS�ھ�')
		pCSTemp.vip_c = (pCSTemp.vip_c or 0) + 1
		RPC('wajue_getgoods',preciousgood_id,commongood_id,must_goodid)--ʬ���ھ�ɹ� 1 ,2 �ֱ��ǹ�����Ʒ����ͨ��Ʒ��id��
end
--------------------------------
boss_wajue = _boss_wajue
 
