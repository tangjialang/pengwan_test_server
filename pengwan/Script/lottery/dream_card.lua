-------------------------------------------
--name : dream card
--code : cureko
--date : 2014-6
-------------------------------------------
local _random = math.random

local msg_cards = msgh_s2c_def[29][21]
local msg_mode	= msgh_s2c_def[29][22]
local msg_pick	= msgh_s2c_def[29][23]
local msg_sel	= msgh_s2c_def[29][24]
local msg_level	= msgh_s2c_def[29][25]

-------------------------------------------
--Config Table
local config = 
{
	--随机物品
	goods_lib = 
	{
		[1] = 
		{	
			{627,15,1},
			{626,15,1},
			{803,15,1},
			{710,1,1},
			{778,2,1},
			{691,4,1},
			{636,5,1},
			{710,3,1},
			{762,5,1},
			{634,5,1},
			{803,20,1},
			{817,400,1},
			{817,200,1},
			{817,300,1},
			{778,3,1},
			{751,2,1},
			{601,40,1},
			{603,40,1},
			{627,20,1},
			{626,20,1},
			{803,25,1},
			{601,30,1},
			{603,30,1},
			{691,3,1},
		},
		
		[2] = 
		{	
			{627,15,1},
			{626,15,1},
			{803,15,1},
			{812,15,1},
			{627,20,1},
			{626,20,1},
			{803,20,1},
			{812,20,1},
			{778,3,1},
			{778,2,1},
			{803,30,1},
			{691,4,1},
			{634,5,1},
			{788,8,1},
			{762,5,1},
			{710,2,1},
			{817,300,1},
			{751,2,1},
			{710,3,1},
			{710,1,1},
			{804,8,1},
			{804,4,1},
			{601,30,1},
			{603,30,1},
			{601,40,1},
			{603,40,1},
		},
		
		[3] = 
		{	
			{1520,30,1},
			{821,6,1},
			{803,15,1},
			{812,15,1},
			{627,20,1},
			{626,20,1},
			{803,20,1},
			{812,20,1},
			{778,4,1},
			{778,2,1},
			{1520,60,1},
			{691,4,1},
			{788,10,1},
			{821,8,1},
			{812,30,1},
			{817,400,1},
			{821,12,1},
			{751,2,1},
			{710,2,1},
			{796,1,1},
			{804,8,1},
			{804,4,1},
			{802,2,1},
			{796,2,1},
			{601,40,1},
			{603,40,1},
		}
	},
	ssel_lib = --自选数据
	{
		[1] = 
		{
			--{物品id,物品数量,是否绑定,积分需求,元宝消耗，限购次数}
			{626,50,1,10,20,9},
			{627,50,1,10,20,9},
			{803,50,1,10,20,9},
			{626,300,1,50,50,2},
			{627,300,1,50,50,2},
			{803,300,1,50,50,2},
			{627,500,1,80,50,1},
			{763,1,1,30,50,1},
			{803,500,1,80,50,1},
			{691,60,1,60,50,9},
			{752,3,1,70,100,3},
			{751,60,1,70,100,3},
			{778,70,1,100,100,6},
			{757,1,1,70,50,6},
			{710,80,1,150,300,3},
			{2603,1,1,1500,2000,1},
			{663,3,1,100,200,1},
			{730,1,1,80,50,3},
			{711,1,1,80,50,3},
			{2805,1,1,1850,3000,1},
		},
		[2] =
		{
			{627,90,1,10,20,9 },
			{803,90,1,10,20,9 },
			{812,90,1,10,20,9 },
			{626,400,1,50,50,9},
			{627,400,1,50,50,9},
			{803,400,1,50,50,9},
			{812,400,1,50,50,9},
			{752,3,1,70,100,3},
			{751,60,1,70,100,3},
			{778,80,1,100,100,6},
			{788,300,1,100,100,6},
			{691,100,1,50,50,5},
			{710,80,1,150,300,3 },
			{757,1,1,50,50,6},
			{804,80,1,50,50,3},
			{2603,1,1,1500,2000,1},
			{711,1,1,60,50,1},
			{730,1,1,60,50,1},
			{677,1,1,250,200,1},
			{2805,1,1,1850,3000,1},	
		},
		[3] = 
		{
			{803,100,1,10,20,9 },
			{812,100,1,10,20,9 },
			{627,100,1,10,20,9 },
			{803,500,1,50,50,9 },
			{812,500,1,50,50,9 },
			{1520,1000,1,70,100,3},
			{821,300,1,70,100,3},
			{778,50	,1,50,50,6},
			{788,500,1,100,100,6},
			{710,100,1,150,100,3},
			{802,100,1,150,100,3},
			{796,100,1,150,100,3},
			{804,100,1,50,50,3},
			{2603,1,1,1500,2000,1},
			{678,2,1,800,3000,1},
			{2805,1,1,1850,3000,1},
			{711,1,1,60,50,1},
			{731,1,1,250,100,1},
			{764,1,1,250,100,1},
			{712,1,1,250,100,1},		
		},
	},
	max_count = 16,
	goods_cost = {822,1},
	pick_yb_cost = 20,
	refresh_yb_cost = 10,
	
	refresh_time = 3600, --刷新时间
}

--卡牌库
local	goods_tl = 
{
	[1] = 
		{
			{1,2,4,5,6,9,10,11,13,14,15,16,19,20,22,23},
			{7,8,9,10,3,12,13,14,5,16,17,18,1,20,21,24},
			{3,4,5,6,7,9,10,15,16,17,18,19,20,21,22,23},
			{1,2,3,4,5,6,7,9,10,11,15,16,17,18,19,12},
			{5,7,8,9,10,11,13,14,15,16,19,20,21,22,23,24},
			{1,2,3,5,8,11,13,14,15,16,19,20,21,22,23,24},
		},
	
	[2] = 
		{
			{5,6,7,8,9,11,12,13,14,15,16,17,20,22,25,26},
			{1,2,3,4,9,10,11,13,14,15,16,17,18,19,23,24},
			{3,4,5,6,9,11,12,13,14,15,16,17,20,22,25,26},
			{1,2,3,5,6,7,8,10,11,13,14,15,16,17,18,22},
			{1,2,3,4,9,10,11,12,14,16,17,18,20,22,23,24},
			{5,6,7,8,9,10,11,13,14,15,17,18,20,22,25,26},		
		},
		
	[3] = 
		{
			{6,7,8,10,11,12,14,15,17,18,19,22,23,24,25,26},
			{1,2,3,4,10,11,12,13,15,16,18,19,20,21,23,24},
			{1,2,7,8,10,11,12,13,15,17,18,19,20,22,23,24},
			{3,4,5,6,7,8,11,12,13,14,15,17,18,20,22,25},
			{3,4,9,11,12,13,15,17,18,19,20,22,23,24,5,8},
			{5,6,7,8,9,11,14,15,17,18,19,20,23,24,25,26},		
		},
}
---------3个位操作函数
local function _bit_tst(v,pos)
	if (rint(v / (2 ^ pos)) % 2) ==  1 then return true else return false end end
local function _bit_set(v,pos) if _bit_tst(v,pos) then return v else return v + (2 ^ pos) end end
local function _bit_cln(v,pos) if not _bit_tst(v,pos) then return v else return v - (2 ^ pos) end end

local function _table_len(t)
	if not t then return 0 end
	
	local sum = 0
	for k,v in pairs(t) do
		if type(k) == type(0) then
			sum = sum + 1
		end
	end
	return sum
end
---------------------
local function _dcard_get_world_data()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then
		return
	end
	
	if w_customdata.dcard == nil then
		w_customdata.dcard = {}
		--[1] = 0	--活动版本
	end
	return w_customdata.dcard
end

local function _dcard_get_player_data(sid)
	local pdata = GI_GetPlayerData(sid,"dcard",160)
	--[1] 模板序号
	--[2] 翻牌信息
	--[3] 自选卡牌
	
	--[4] 时间
	--[5] 模式
	--[6] 选购次数记录
	--[7] 活动开始时间（标识）
	
	--[8] 积分
	--[9] 已翻牌数量
	--[10] 已翻牌位标识
	return pdata
end

local function _dcard_get_award_level()
	local wdata=_dcard_get_world_data()
	if not wdata[1] then return end
	if not wdata[2] or wdata[2]  < 1 or wdata[2] > #config.goods_lib then
		return
	end
	return wdata[2]
end
--获取那16张牌
--ctype nil()
local function _dcard_get_cards(sid,ctype,buy)
	local pdata = _dcard_get_player_data(sid)
	look(pdata,2)
	local award_lvl = _dcard_get_award_level()
	if not award_lvl or not pdata then return end
	
	
	look("size:",2)
	look(Getplayerdata_all(sid),2)
	
	if not ctype then
		pdata[4] = pdata[4] or 0
		pdata[9] = pdata[9] or 0
		local nowTime = GetServerTime()
		if buy or (pdata[9] < config.max_count and nowTime - pdata[4] < config.refresh_time)then
			if not (buy and CheckCost(sid,config.refresh_yb_cost,0,1,'梦幻卡牌')) then
				return
			end
		end
		pdata[2] = nil
		pdata[9] = nil
		pdata[10] = nil
		
		pdata[4] = nowTime
		pdata[1] = _random(1,#goods_tl[award_lvl])
	end
	if not pdata[1]	then
		pdata[2] = nil
		pdata[9] = nil
		pdata[10] = nil
		
		pdata[4] = GetServerTime()
		pdata[1] = _random(1,#goods_tl[award_lvl])
	end
	SendLuaMsg(0,{ids = msg_cards,res = goods_tl[award_lvl][pdata[1]],level=award_lvl},9)
end
local function _dcard_set_mode(sid,mode)
	local pdata = _dcard_get_player_data(sid)
	local award_lvl = _dcard_get_award_level()
	if not award_lvl or not pdata then return end
	pdata[5] = mode
	SendLuaMsg(0,{ids = msg_mode,mode = mode},9)
end
--选牌 index 自选物品序号
local function _dcard_sel_card(sid,index)
	local pdata = _dcard_get_player_data(sid)
	local award_lvl = _dcard_get_award_level()
	if not award_lvl or not pdata then return end
	if not index or index < 1 or index > #config.ssel_lib[award_lvl] then return end
	pdata[3] = pdata[3] or {}
	pdata[6] = pdata[6] or {}
	look(pdata,2)
		
	local st = pdata[3] --已选表
	if _table_len(st) >= 3 then return end
	local goods = config.ssel_lib[award_lvl][index]
	
	--购买次数表
	local srt = pdata[6] 
	srt[index] = srt[index] or 0

	if not goods --无物品
	or pdata[8] < goods[4] --积分不足
	or srt[index] >= goods[6] --限购次数
	or not CheckCost(sid,goods[5],1,1,'梦幻卡牌') then 
		look("Check Failed")
		return 
	end

	srt[index] = srt[index]+1
	pdata[8] = pdata[8]-goods[4]
	CheckCost(sid,goods[5],0,1,'梦幻卡牌')
	
	local maxl = config.max_count
	local rpos = _random(1,maxl)
	for i = rpos,rpos + maxl do
		local pos=(i % maxl)+1
		if not st[pos] then 
			st[pos] = index
			look(index,2)
			look(srt[index],2)
			SendLuaMsg(0,{ids = msg_sel,pos = pos,index = index,count=srt[index],score=pdata[8]},9)
			return
		end
	end
end

--前台请求 翻牌
--index 牌序号
local function _do_pick_card(sid,pdata,index,award_lvl)
	local maxl = config.max_count
	if pdata[9] >= maxl then return false end

	if isFullNum() < 1 then
		TipCenter(GetStringMsg(14,1))
		return false
	end	
	if 1 ~= CheckGoods(config.goods_cost[1],config.goods_cost[2],0,sid,'梦幻卡牌')
	and not CheckCost(sid,config.pick_yb_cost,0,1,'梦幻卡牌') then
		SendLuaMsg(0,{ids=msg_pick,err=1},9)
		look("道具元宝不足",2)
		return false
	end
	pdata[8] = pdata[8] + 1
	pdata[9] = pdata[9] + 1
		
	local rpos = _random(1,maxl)
	local ptbl = pdata[2]--翻牌表
	local pos=-1
	if pdata[9] < 11 then
		for i = rpos,rpos + maxl do
			pos=(i % maxl)+1
			if not _bit_tst(pdata[10],pos) and not pdata[3][pos] then
				break
			end
		end
	else
		for i = rpos,rpos + maxl do
			pos=(i % maxl)+1
			if not _bit_tst(pdata[10],pos) then 
				break
			end
		end
	end
	----------------------------------
	--ASSERT(pos ~=-1)
	----------------------------------
	local selpos = pdata[3][pos]
	local goods
	--如果是自选模式 自选牌 
	if selpos and pdata[5]  == 2 then
		pdata[3][pos] = nil
		pdata[2][index] = selpos + 100
		pdata[10] = _bit_set(pdata[10],pos)
		goods = config.ssel_lib[award_lvl][selpos]
	else
		local tl = goods_tl[award_lvl][pdata[1]]
		
		pdata[2][index] = tl[pos]
		pdata[10] = _bit_set(pdata[10],pos)
		goods = config.goods_lib[award_lvl][tl[pos]]
	end
	------------------------------------------------
	GiveGoods(goods[1],goods[2],goods[3],'梦幻卡牌')
	SendLuaMsg(0,{ids = msg_pick,pos = pdata[2][index],index = index,score=pdata[8]},9)
	return true
end

local function _dcard_pick_card(sid,index,icount)
	local maxl = config.max_count
	local pdata = _dcard_get_player_data(sid)
	local award_lvl = _dcard_get_award_level()
	if not award_lvl or not pdata then return false end
	
	pdata[2] = pdata[2] or {}
	pdata[3] = pdata[3] or {}
	pdata[8] = pdata[8] or 0
	pdata[9] = pdata[9] or 0
	pdata[10] = pdata[10] or 0	

	if index then
		if index < 1 or index > config.max_count or pdata[2][index] then
			return
		end
		_do_pick_card(sid,pdata,index,award_lvl)
	else
		for index = 1,config.max_count do
			if not pdata[2][index] then
				if not _do_pick_card(sid,pdata,index,award_lvl) then break end
			end
		end
	end
	
	look(pdata,2)
end

function _dcard_award_level(sid)
	SendLuaMsg(0,{ids = msg_level,level=_dcard_get_award_level()},9)
end
----
----Message Dispatch
dcard_get_cards = _dcard_get_cards
dcard_set_mode = _dcard_set_mode
dcard_pick_card = _dcard_pick_card
dcard_sel_card = _dcard_sel_card
dcard_award_level = _dcard_award_level
----------------------------------------------------
function dcard_active(atype,tBegin)
	if IsSpanServer() then return end
	look('dcard_active start',2)
	local wdata = _dcard_get_world_data()
	if atype == 2 then
		local wlvl = GetWorldLevel()
		wdata[1] = tBegin
		if wlvl < 60 then 
			wdata[2] = 1
		elseif wlvl > 80 then
			wdata[2] = 3
		else
			wdata[2] = 2
		end
	else if atype == 1 then 
		wdata[1] = nil
		end
	end
	look(wdata,2)
end

function dcard_player_online(sid)
	local pdata = _dcard_get_player_data(sid)
	local wdata = _dcard_get_world_data()
	if wdata[1] then
		if wdata[1] ~=  pdata[7] then 
			for i=1,10 do 
				pdata[i] =nil 
			end
		end
		pdata[7] = wdata[1]
		SendLuaMsg(0,{ids = msg_online},9)
	end
end

function dcard_dayreset(sid)
	look('dcard_dayreset',2)
	local pdata = _dcard_get_player_data(sid)
	if pdata then pdata[6] = nil end
end

function dcard_add_score(sid,score)
	--look('dcard_add_score',2)
	local pdata = _dcard_get_player_data(sid)
	pdata[8] = score
end
