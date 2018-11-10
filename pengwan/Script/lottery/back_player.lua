--[[
file:	back_player.lua
desc:	找回老玩家（勇士）
author:	ZhouLei
update:	2014-07-10
refix:	
]]--

-------------------------------------------
--配置区
local config = 
{
		[1] = {{603,50,1},{601,50,1},{1515,1,1},{719,10,1},{725,20,1},{1509,1,1}},
		[2] = {{603,100,1},{601,100,1},{1515,1,1},{719,20,1},{725,50,1},{1511,1,1}},
		[3] = {{603,200,1},{601,200,1},{1515,1,1},{719,50,1},{725,100,1},{1513,1,1}},
		--每种类型的 三个礼包的id
		[4] = {{1506,1509,1510},{1507,1511,1512},{1508,1513,1514}},
	level_limit = 50,
	
	exp_add = 10000000,
	exp_goods_id = 1515,
	
	
	awards_bag = 
	{
		[1] = {{603,100,1},{601,100,1},{647,2,1},{652,5,1},{657,5,1},{637,50,1},{1510,1,1}},
		[2] = {{603,200,1},{601,200,1},{647,3,1},{652,8,1},{657,12,1},{637,100,1},{1512,1,1}},
		[3] = {{603,500,1},{601,500,1},{647,6,1},{652,18,1},{657,20,1},{637,200,1},{1514,1,1}},
	},
	
	awards_bag2 = 
	{
		[1] = {100,{{603,200,1},{601,200,1},{647,3,1},{652,8,1},{657,12,1},{636,30,1},{634,30,1}}},
		[2] = {500,{{603,500,1},{601,500,1},{647,5,1},{652,12,1},{657,20,1},{636,60,1},{634,60,1},{773,3,1}}},
		[3] = {1000,{{603,800,1},{601,800,1},{647,10,1},{652,30,1},{657,34,1},{636,120,1},{634,120,1},{773,8,1},{710,20,1}}},
	},
}

--------------------------------------------
--
--	[26] = {29,25}, --勇士领奖
--	[27] = {29,26}, --勇士使用宝箱
local 	msg_get_award = msgh_s2c_def[29][26]
local 	msg_use_item = msgh_s2c_def[29][27]
g_warrior_enable = g_warrior_enable or true
-------------------------------------------
--设置活动是否有效

function warrior_enable(enable)
	g_warrior_enable = enable
end

function warrior_get_award(sid)
	local cdata = GetDBCommonData(sid)
	if not cdata[1] then return end
	local goods_batch = config[cdata[1]]
	if not goods_batch then return end
	if isFullNum() < #goods_batch then
		TipCenter(GetStringMsg(14,#goods_batch))
		return
	end	
	cdata[1] = nil
	GiveGoodsBatch(goods_batch,"勇士回归")
	SendLuaMsg(0,{ids=msg_get_award},9)
end

--黄金首充礼盒
local function wrr_use_bag(sid,moneylv,level)
	if moneylv <= 0 then
		return -1
	end
	local goods_batch = config.awards_bag[level]
	if isFullNum() < #goods_batch then
		TipCenter(GetStringMsg(14,#goods_batch))
		return -2
	end	
	GiveGoodsBatch(goods_batch,"勇士回归")
	return 1
end

--礼盒
local function wrr_use_bag2(sid,moneylv,level)
	local pconfig = config.awards_bag2[level]
	if moneylv < pconfig[1] then 
		return -1
	end
	local goods_batch = pconfig[2]
	if isFullNum() < #goods_batch then
		TipCenter(GetStringMsg(14,#goods_batch))
		return -2
	end	
	GiveGoodsBatch(goods_batch,"勇士回归")
	return 1
end

local on_use_item_cb =
{
	[1509] = function(sid,moneylv)return wrr_use_bag(sid,moneylv,1)	end,
	[1510] = function(sid,moneylv)return wrr_use_bag2(sid,moneylv,1)end,
	[1511] = function(sid,moneylv)return wrr_use_bag(sid,moneylv,2)	end,
	[1512] = function(sid,moneylv)return wrr_use_bag2(sid,moneylv,2)end,
	[1513] = function(sid,moneylv)return wrr_use_bag(sid,moneylv,3)	end,
	[1514] = function(sid,moneylv)return wrr_use_bag2(sid,moneylv,3)end,
}

function CallBack_UseItem(sid,itemid,moneylv)
	if not IsPlayerOnline(sid) 
	or CheckGoods(itemid,1,1,sid,'勇士回归') ~= 1 then return end
	local fn_use_item = on_use_item_cb[itemid]
	if fn_use_item then	
		local ret = fn_use_item(sid,moneylv)
		if ret < 0 then
			SendLuaMsg(sid,{ids=msg_use_item,itemid=itemid,err=ret},10)
		else
			CheckGoods(itemid,1,0,sid,'勇士回归')
		end
	end
end

function warrior_use_item(sid,itemid)
	if on_use_item_cb[itemid] then
		local nowtime = GetServerTime()
		local begintime = os.date('%Y-%m-%d 00:00:00',nowtime)
		local endtime = os.date('%Y-%m-%d %H:%M:%S',nowtime)
		local call = { dbtype = 2, sp = 'N_ActivityPayBuyPoint',args = 5,[1] = sid,[2] = GetGroupID(),[3]=begintime,[4]=endtime,[5]=1}
		local callback = { callback = 'CallBack_UseItem', args = 3, [1] = sid,[2]=itemid,[3] = "?6",}
		DBRPC( call, callback )
	else
		if itemid == config.exp_goods_id 
		and CheckGoods(itemid,1,0,sid,'勇士回归') == 1 then --经验丹
			local playerlv = CI_GetPlayerData(1) --player level
			if playerlv >= config.level_limit then
				local worldlv = GetWorldLevel() - 4
				if playerlv < worldlv then
					CI_PayPlayer(2,worldlv-playerlv)
				else
					PI_PayPlayer(1,config.exp_add,0,0,'勇士经验丹')
				end
			end
		end
	end
end

function warrior_player_login(sid)
	if IsSpanServer() then
		return 
	end
	
	if not g_warrior_enable then return end
	local playerlv = CI_GetPlayerData(1)
	if playerlv < config.level_limit then return end

	local cdata = GetDBCommonData(sid)
	if not cdata[1] then
		local dayData = GetPlayerDayData(sid)
		if not (dayData and dayData.time) then return end
		local logouttime = dayData.time[3] or 0
		if logouttime > 0 then
			if GetServerTime() - logouttime > 3600 * 24 * 14 then
				local moneylv = CI_GetPlayerData(27) or 0
				if moneylv <= 2000 then 
					cdata[1] = 1
				elseif moneylv >= 10000 then
					cdata[1] = 3
				else 
					cdata[1] = 2
				end
			end
		end
	end
end
