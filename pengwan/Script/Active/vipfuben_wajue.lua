 --[[
file:	vipfuben_wajue.lua
desc:	vip副本BOSS尸体挖掘
author:	jkq
update:	2013-12-23
notes:
	wajue_conf:挖掘次数对应所需的元宝以及出现贵重物品的概率
	
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
	[1] = {								--普通物品
		[1] = { --世界等级0~50
		{738,1,1,1000},{673,1,1,6000},{673,2,1,6010},{673,3,1,6020},{637,10,1,10000},
		},
		[2] = { --世界等级50~70
		{738,1,1,1000},{673,1,1,4000},{673,2,1,8000},{673,3,1,8100},{637,10,1,10000},
		},
		[3] = {  --世界等级70~以上
		{738,1,1,1000},{673,1,1,1100},{673,2,1,4100},{673,3,1,8100},{637,10,1,10000},
		},
	},
	[2] = {								--贵重物品
		{757,1,1,500},{758,1,1,1500},{759,1,1,2500},{760,1,1,3500},{647,1,1,5000},{652,1,1,9000},{761,1,1,10000},
	},	
	[3] = {								--5次必挖出物品
		{647,1,1,2000},{652,1,1,10000},
	},
}

--挖掘次数配置表[1] = {0,1}表示第一次挖掘是所需的元宝数量   和  获得贵重物品的概率
local wajue_conf = {
	[1] = {20,500},
	[2] = {20,500},
	[3] = {20,500},
	[4] = {20,1000},
	[5] = {20,1000},
}

local count = 5 --屍體挖掘的最大次數
local randAdd = 600  --每次挖掘累计增加概率

----------------------------------------------------------------------------
-- module:

module(...)

----------------------------------------------------------------------------

local function _boss_wajue(playerid)
		local needMoney = 0   		-- 要花费的元宝
		local wajue_times  	  		-- 已挖掘的次数
		local wajue_times2 = 0			-- 计算概率增加次数
		local rand    		 		-- 获得贵重物品随机数
		local needpakage  = 1 	  	-- 需要的空间
		local probalilty      		-- 贵重物品的概率
		local commongood_id  = 0	-- 获得普通物品编号
		local preciousgood_id = 0 	-- 获得贵重物品编号
		local must_goodid = 0       --第五次获得必须品编号
		local pCSTemp = _CS_GetPlayerTemp(playerid) 
		 --look('1111111111111')     
		if pCSTemp == nil then return end
		wajue_times = (pCSTemp.vip_c or 0) + 1
		wajue_times2 = (pCSTemp.vip_c2 or 0 ) + 1
		
		if wajue_times > count then 	 -- 尸体挖掘次数
			RPC('wajue_getgoods',-1) 	 -- 尸体挖掘次数用完了
			return
		end
		needMoney =  wajue_conf[wajue_times][1]--需要的元宝数量
		--look(needMoney)
		if not CheckCost(playerid,needMoney,1,1,'VIP副本BOSS挖掘') then --判断玩家元宝是否足够
			return 
		end	
		probalilty = wajue_times2 * randAdd
		look("贵重品概率 = "..probalilty)
		rand = mathrandom(1,10000)
		--look(rand)
		if rand <= probalilty then  --在指定的概率之中，可以给贵重道具
			--look("need2")
			needpakage = 2
			pCSTemp.vip_c2 = 0
		else
			pCSTemp.vip_c2 = (pCSTemp.vip_c2 or 0 ) + 1
		end
		if wajue_times == 5 then
			needpakage = needpakage + 1
		end
		--判断背包空间是否足够
		--look('222222222222')
		local pakagenum = isFullNum()
		--look(pakagenum)
		if needpakage > pakagenum  then
			TipCenter(GetStringMsg(14,needpakage))
			return 
		end
		if wajue_times == 5 then  --给出必须品
			local Rand_must = mathrandom(10000)
			--look('5555555555555555')
			--look(Rand_must)
			for i,v in ipairs(vipwajue_goodsconf[3]) do
				must_goodid = must_goodid + 1
				look(v[4])
				if Rand_must < v[4] then
					GiveGoods(v[1],v[2],v[3],'VIP副本BOSS挖掘')
					break
				end
			end
			needpakage = needpakage - 1
		end
	
		if needpakage == 2 then--需要給予貴重物品
			--look('4444444444444')
			--给出道具
			--贵重道具给予的概率处理
			local Rand = mathrandom(10000)
			for i,v in ipairs(vipwajue_goodsconf[2]) do
				preciousgood_id = preciousgood_id + 1
				if(Rand < v[4]) then
					GiveGoods(v[1],v[2],v[3],'VIP副本BOSS挖掘')
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
		
		--普通道具随机编号
		local Rand_commom= mathrandom(10000)
		for j,k in ipairs(itemlist) do
			commongood_id = commongood_id + 1
			if(Rand_commom < k[4]) then
				GiveGoods(k[1],k[2],k[3],'VIP副本BOSS挖掘')
				break
			end
		end

		--扣除元宝和道具
		CheckCost(playerid,needMoney,0,1,'VIP副本BOSS挖掘')
		pCSTemp.vip_c = (pCSTemp.vip_c or 0) + 1
		RPC('wajue_getgoods',preciousgood_id,commongood_id,must_goodid)--尸体挖掘成功 1 ,2 分别是贵重物品和普通物品的id号
end
--------------------------------
boss_wajue = _boss_wajue
 
