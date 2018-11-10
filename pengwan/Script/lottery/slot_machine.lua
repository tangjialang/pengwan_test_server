--[[
file:	SlotMachine.lua
desc:	老虎机
author:	ZhouLei
update:	2012-12-20
refix:	
]]--
local _random = math.random
local isFullNum = isFullNum
local GiveGoods	 = GiveGoods
local SendLuaMsg = SendLuaMsg
local GetWorldCustomDB = GetWorldCustomDB
local GI_GetPlayerData = GI_GetPlayerData

local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist_ex = sclist_m.insert_scorelist_ex--(t,num,val,name,school,id,vt)

local msg_result = msgh_s2c_def[29][17]	
local msg_top10	 = msgh_s2c_def[29][18]	
local msg_prize = msgh_s2c_def[29][19]	

--昨日排名领奖 
local prize_table = {
	{803,100,1},
	{803,90,1},
	{803,80,1},
	{803,70,1}, 
	{803,60,1},
	{803,50,1},
	{803,40,1},
	{803,30,1},
	{803,20,1},
	{803,10,1},
}

--总积分奖励 only once {积分界限,{{物品1,数量},{物品2,数量}}}
local reward_once_table = {
	[5] = {
			[1] = {100,{{810,10,1}}},
			[2] = {200,{{810,20,1},{803,10,1}}},
			[3] = {500,{{810,30,1},{803,25,1},{778,5,1}}},
			[4] = {1000,{{810,50,1},{803,50,1},{778,10,1},{763,1,1}}},
			[5] = {2000,{{810,100,1},{803,100,1},{778,20,1},{691,50,1},{730,1,1}}},
			[6] = {5000,{{810,200,1},{803,300,1},{778,50,1},{691,120,1},{711,1,1}}},
			[7] = {10000,{{691,200,1},{803,600,1},{778,100,1},{731,1,1},{764,1,1},{712,1,1}}},
		},
	[6] = {
			[1] = {100,{{810,10,1}}},
			[2] = {200,{{810,20,1},{803,10,1}}},
			[3] = {500,{{810,30,1},{803,25,1},{802,5,1}}},
			[4] = {1000,{{810,50,1},{803,50,1},{802,10,1},{763,1,1}}},
			[5] = {2000,{{810,100,1},{803,100,1},{802,20,1},{778,10,1},{730,1,1}}},
			[6] = {5000,{{810,200,1},{803,300,1},{802,50,1},{778,25,1},{711,1,1}}},
			[7] = {10000,{{778,50,1},{803,600,1},{802,100,1},{731,1,1},{764,1,1},{712,1,1}}},
		},
	[7] = {
			[1] = {100,{{810,10,1}}},
			[2] = {200,{{810,20,1},{812,10,1}}},
			[3] = {500,{{810,30,1},{812,25,1},{778,5,1}}},
			[4] = {1000,{{810,50,1},{812,50,1},{778,10,1},{763,1,1}}},
			[5] = {2000,{{810,100,1},{812,100,1},{778,20,1},{803,100,1},{730,1,1}}},
			[6] = {5000,{{810,200,1},{812,300,1},{778,50,1},{803,250,1},{711,1,1}}},
			[7] = {10000,{{803,500,1},{812,600,1},{778,100,1},{731,1,1},{764,1,1},{712,1,1}}},
		},
}

--{结果,概率,{道具id,数量},{},{}}	低 中 高
local slots_table = {
	[5] = {
		{111,40,{{627,500,1,1},{711,1,1,1}}},
		{222,40,{{803,250,1,1},{763,1,1,1}}},
		{333,40,{{752,2,1,1},{730,1,1,1}}},
		{112,1680,{{626,5,1,0},{626,25,1,0}}},
		{113,1000,{{802,1,1,0},{802,5,1,0}}},
		{221,1000,{{710,1,1,0},{710,5,1,0}}},
		{223,1000,{{778,1,1,0},{778,5,1,0}}},
		{331,1000,{{691,2,1,0},{691,10,1,0}}},
		{332,2000,{{627,5,1,0},{627,25,1,0}}},
		{123,2200,{{803,5,1,0},{803,25,1,0}}},
	},
	[6] = {
		{111,30,{{627,600,1,1},{711,1,1,1}}},
		{222,30,{{803,300,1,1},{763,1,1,1}}},
		{333,30,{{752,1,1,1},{730,1,1,1}}},
		{112,1000,{{626,8,1,0},{626,40,1,0}}},
		{113,3000,{{802,1,1,0},{802,5,1,0}}},
		{221,1000,{{710,1,1,0},{710,5,1,0}}},
		{223,1000,{{778,1,1,0},{778,5,1,0}}},
		{331,10,{{691,3,1,0},{752,5,1,0}}},
		{332,1000,{{627,8,1,0},{627,40,1,0}}},
		{123,2900,{{803,8,1,0},{803,40,1,0}}},
	},
	[7] = {
		{111,10,{{812,500,1,1},{711,2,1,1}}},	
		{222,10,{{803,500,1,1},{763,2,1,1}}},	
		{333,10,{{796,6,1,1},{730,2,1,1}}},	
		{112,100,{{1520,60,1,0},{796,500,1,1}}},	
		{113,1000,{{710,2,1,0},{821,100,1,0}}},	
		{221,1400,{{821,10,1,0},{1520,300,1,0}}},	
		{223,4400,{{812,5,1,0},{812,16,1,0}}},	
		{331,500,{{778,2,1,0},{1520,150,1,0}}},	
		{332,500,{{1520,30,1,0},{821,30,1,0}}},	
		{123,2070,{{803,15,1,0},{803,75,1,0}}},	
	},
}

local score_add = {1,5,10}
local items_cost = {1,5}
local money_cost = {10,50,90}

local function lhj_gettable(stable)
		local lvl = math.floor((GetWorldLevel() or 1)/10)
		if lvl < 5 then 
			lvl = 5 
		elseif lvl > 7 then
			lvl = 7 
		end
		return stable[lvl]
end

local function lhj_getwdata()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then
		return
	end
	
	if w_customdata.lhjw == nil then
		w_customdata.lhjw =
		{[1] = {}	--今日排行
		,[2] = {}	--昨日排行
		,[3] = 0	    --活动版本
		,[4] = {}	--昨日领奖记录
		}
	end
	return w_customdata.lhjw
end

local function lhj_getpdata(sid)
	local w_customdata = GetWorldCustomDB()
	if not w_customdata.lhjw then return end
	
	local pdata = GI_GetPlayerData(sid,'lhj', 400)
	if pdata == nil then
		return
	end
	--把旧数据 改为新格式数据
	if not pdata[10] then
		if pdata.geted_prize_level then
			pdata[1] = pdata.geted_prize_level
			pdata.geted_prize_level = nil
		end
		
		if pdata.h_score then
			pdata[2] = pdata.h_score
			pdata.h_score = nil
		end
		
		if pdata.yscore then
			pdata[3] = pdata.yscore
			pdata.yscore = nil
		end
		
		if pdata.score then
			pdata[4] = pdata.score
			pdata.score = nil
		end
		
		if pdata.aid then
			pdata[5] = pdata.aid
			pdata.aid = nil
		end
		
		if pdata.total_score then
			pdata[6] = pdata.total_score
			pdata.total_score = nil
		end
		
		pdata[10] = true
	end
	
	local wdata = lhj_getwdata()
	if wdata[3]~= pdata[5] and not IsSpanServer() then
		--look('活动清除数据',2)
		pdata[1] = 0   -- geted_prize_level
		pdata[2] = 0   -- h_score
		pdata[3] = 0   -- yscore
		pdata[4] = 0   -- score
		pdata[5] = wdata[3]   -- aid 活动版本
		pdata[6] = 0   --  total_score
		--
	end 
	return pdata
end

function lhj_day_reset(sid)
	local player_data = lhj_getpdata(sid)
	if player_data == nil then
		return
	end
	player_data[3] = player_data[4]
	player_data[4] = 0
	--look('刷新玩家数据',2)
end

function lhj_rank_refresh()
	local wdata = lhj_getwdata()
	wdata[2] = {}	--昨日排行清空
	wdata[4] = {}	--昨日领奖记录清空
	for k,v in pairs(wdata[1]) do
		if type(k)==type(0) and type(v)==type({}) then 
			wdata[2][k] = v
			wdata[1][k] = nil
		end
	end
	--look('生成昨日排行',2)
end

function lhj_active(val,tBegin,tAward,tEnd)--val 通知类型 1: 活动开启 2:活动结束
	local wdata = lhj_getwdata()
	if val == 2 then	--活动开启
		if wdata[3] == tBegin then
			return
		end
		wdata[0] = {}
		wdata[1] = {}
		wdata[2] = {}	
		wdata[3] = tBegin
	elseif val == 1 then
		local w_customdata = GetWorldCustomDB()
		w_customdata.lhjw = nil
	end
end

local function insert_to_top10(sid,score)
	local name = CI_GetPlayerData(5)
	local wdata = lhj_getwdata()
	return insert_scorelist_ex(wdata[1],10,score,name,0,sid)
end

local function get_prize_index(sid)
	local wdata = lhj_getwdata()
	local top10=wdata[2]
	for i=1,#top10 do
		if top10[i][4] == sid then
			if wdata[4][i] == true then
				return 0
			else
				return i
			end
		end 
	end
end

local function get_a_roll(level)
	local i
	local left = 0
	local right = 0
	local num = _random(0,9999);
	local rtable = lhj_gettable(slots_table)
	for i = 1,#rtable do
		local chance = rtable[i][2];
		right = left + chance; 
		if num >= left and num < right then
			return rtable[i]
		end
		left = right
	end
end

local function _lhj_rolling(sid,level,auto,inum)
	if IsSpanServer() then return end
	
	if level < 1 or level > 2 then
		return nil
	end
	
	local count
	if auto == 1 then 
		count = 10	
	else
		count = 1
	end
			
	if isFullNum() < count then
		TipCenter(GetStringMsg(14,count))
		return
	end	
	
	local item_need = items_cost[level] * count
	if inum < item_need then
		local mcost = money_cost[level]*(count-inum/items_cost[level])
		if not CheckCost(sid,mcost,1,1,'老虎机')
			or CheckGoods(810,inum,1,sid,'老虎机') ~= 1 then
			return
		end
		CheckCost(sid,mcost,0,1,'老虎机')
		CheckGoods(810,inum,0,sid,'老虎机')
	else
		if CheckGoods(810,item_need,0,sid,'老虎机') ~= 1 then
			return
		end
	end
		
	local i
	local tbl = {}
	tbl.ids = msg_result
	tbl.auto = auto
	tbl.level = level
	tbl.result = {}
	local player_data = lhj_getpdata(sid)
	
	local s_add = count * score_add[level];
	player_data[4] = (player_data[4] or 0) + s_add
	player_data[6] = (player_data[6] or 0) + s_add
	
	if player_data[2] == nil then
		player_data[2] = player_data[6]
	else
		player_data[2] = player_data[2] + s_add
	end
	
	for i = 1,count do
		local rtable = get_a_roll()
		tbl.result[i] = rtable[1]
		local goods = rtable[3][level]
		GiveGoods(goods[1],goods[2],goods[3],'老虎机')
		if goods[4] == 1 then
			BroadcastRPC('LOT_special',9,CI_GetPlayerData(5),{goods[1],goods[2]})
		end
	end
	insert_to_top10(sid,player_data[4])
	
	tbl[2] = player_data[2]
	tbl[4] = player_data[4]
	tbl[6] = player_data[6]
	
	if auto ~= 1 then
		tbl.result = tbl.result[1]	--与先前消息兼容
	end
	SendLuaMsg(0,tbl,9)
end

local function _lhj_get_top10(sid,yd)
	if IsSpanServer() then return end
		
	local wdata = lhj_getwdata()
	if yd then
		local prize_index = get_prize_index(sid)
		SendLuaMsg(0,{ids=msg_top10,top20=wdata[2],yesterday=yd,_self = prize_index},9)
	else
		SendLuaMsg(0,{ids=msg_top10,top20=wdata[1]},9)
	end
end

function _lhj_get_prize(sid,prize_type,level)
	if IsSpanServer() then return end
	
	if prize_type == 1 then	--昨日排行领奖
		if isFullNum() < 1 then
			TipCenter(GetStringMsg(14,1))
			return
		end
		local i=get_prize_index(sid)
		if i > 0 then		
			local v=prize_table[i]
			look('Give Goods'..tostring(v[1])..' '..tostring(v[2]),2)
			SendLuaMsg(0,{ids=msg_prize,prize_type=1},9)
			GiveGoods(v[1],v[2],v[3],'老虎机')
			local wdata = lhj_getwdata()
			wdata[4][i] = true
			return
		end		
	elseif prize_type == 2 then	--总积分领奖
		local player_data = lhj_getpdata(sid)
		player_data[1] = player_data[1] or 0
		if level < player_data[1] then
			return 
		end

		local rtable = lhj_gettable(reward_once_table)
		if rtable == nil then return end
		
		for i = level,#rtable do
			local t = rtable[i]
			if player_data[2] >= t[1] then
				if isFullNum() < #t[2] then
					TipCenter(GetStringMsg(14,1))
					return
				end	
				for k,v in ipairs(t[2]) do
					--look('Give Goods'..tostring(v[1])..' '..tostring(v[2]),2)
					GiveGoods(v[1],v[2],v[3],'老虎机')
				end
				player_data[1] = i
				SendLuaMsg(0,{ids=msg_prize,prize_type=2,level=i},9)
				return 
			end
		end
	end
end

function _lhj_get_score(sid)
	if IsSpanServer() then return end
				
	local player_data = lhj_getpdata(sid)
	if player_data == nil then return end
	return player_data[6] 
end

function _lhj_cost_score(sid,score)
	local player_data = lhj_getpdata(sid)
	if player_data == nil then return false end
	if player_data[6] == nil then return false end
	if score > player_data[6] then return false end
	player_data[6] = player_data[6] - score
	--SendLuaMsg(0,{ids = msg_result,auto=2,total_score = player_data[6]},9)
	SendLuaMsg(0,{ids = msg_result,auto=2, [6]= player_data[6] },9)
	return true
end

function lhj_on_player_login(sid)
	local player_data = lhj_getpdata(sid)
end
--interface and message response
lhj_rolling = _lhj_rolling
lhj_get_top10 = _lhj_get_top10
lhj_get_prize = _lhj_get_prize
lhj_get_score = _lhj_get_score
lhj_cost_score = _lhj_cost_score