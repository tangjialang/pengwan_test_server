------------------------------
--Program: FIFA World Cup 2014
--Author: ZL
----------------

local matchs_table = 
{
	--赛程表,球队编号（按照小组赛的比赛顺序依次编号）
	[1] = {1,2,3,4, 5,6,7,8, 9,10,11,12, 13,14,15,16, 17,18,19,20, 21,22,23,24, 25,26,27,28, 29,30,31,32},
	[2] = {1,7, 9,13, 6,3, 16,10, 19,23, 25,31, 21,20, 29,28}, --1/8赛，小组赛结果
	[3] = {1,9, 19,25, 6,16, 21,29},--1/4赛，1/8赛结果
	[4] = {1,25, 6,21}, --半决赛，1/4赛结果
	[5] = {25,21}, --半决赛结果
	[6] = {1,6, 25,21},--决赛
	[7] = {6,25},--决赛结果

	--整个活动的开启时间 和结束时间
	[15] = {
			{2014,6,13,0,0,0},
			{2014,7,20,23,59,59},
		 },
	--显示时间 [1]每两组的投注截至时间
	[16] = {
			{"2014年6月23日23：59：59","2014年6月24日23：59：59","2014年6月25日23：59：59","2014年6月26日23：59：59"},
			{"2014年6月13日 00:00:00","2014年6月28日 00:00:00","2014年7月20日 23:59:59"}
		  },
	[17] = {
			{{2014,6,12,0,0,0},{2014,6,28,0,0,0},{2014,7,3,0,0,0},{2014,7,7,0,0,0},{2014,7,11,0,0,0},{2014,7,15,0,0,0}},
			{{{2014,6,28,0,0,0},{2014,7,20,23,59,0}},{{2014,7,3,0,0,0},{2014,7,20,23,59,0}},{{2014,7,7,0,0,0},{2014,7,20,23,59,0}},{{2014,7,11,0,0,0},{2014,7,20,23,59,0}},{{2014,7,15,0,0,0},{2014,7,20,23,59,0}}}
		  },
	cost_yb = 20,
	cost_goods = {818,1},
	awards_table ={		
				{{819,40},{{820,1,1},}},--小组赛
				{{819,40},{{820,1,1},}},--1/8
				{{819,40},{{820,1,1},}},--1/4
				{{819,40},{{820,2,1},}},--半决赛
				{},
				{{819,40},{{820,3,1},}},--决赛
				},	
	bets_max = 20,

		
	bets_time = --押注时间
	{
		[1] = --小组赛
		{	
			{2014,6,23,23,59,59},
			{2014,6,23,23,59,59},
			{2014,6,24,23,59,59},
			{2014,6,24,23,59,59},
			{2014,6,25,23,59,59},
			{2014,6,25,23,59,59},
			{2014,6,26,23,59,59},
			{2014,6,26,23,59,59},
		},
		[2] = -- 1/8
		{
			{{2014,6,28,0,0,0},{2014,6,28,23,59,0}},
			{{2014,6,28,0,0,0},{2014,6,28,23,59,0}},
			{{2014,6,28,0,0,0},{2014,6,29,23,59,0}},
			{{2014,6,28,0,0,0},{2014,6,29,23,59,0}},
			{{2014,6,28,0,0,0},{2014,6,30,23,59,0}},
			{{2014,6,28,0,0,0},{2014,6,30,23,59,0}},
			{{2014,6,28,0,0,0},{2014,7,1,23,59,0}},
			{{2014,6,28,0,0,0},{2014,7,1,23,59,0}},
		},
		[3] = -- 1/4
		{
			{{2014,7,3,0,0,0},{2014,7,4,23,59,0}},--1
			{{2014,7,3,0,0,0},{2014,7,4,23,59,0}},--2
			{{2014,7,3,0,0,0},{2014,7,5,23,59,0}},--3
			{{2014,7,3,0,0,0},{2014,7,5,23,59,0}},--4
		},
		[4] = --半决赛
		{
			{{2014,7,7,0,0,0},{2014,7,8,23,59,0}},
			{{2014,7,7,0,0,0},{2014,7,9,23,59,0}},
		},
		[5] = {},
		[6] = --决赛
		{
		
			{{2014,7,11,0,0,0},{2014,7,12,23,59,0}},
			{{2014,7,11,0,0,0},{2014,7,13,23,59,0}},
		}
	}
}

local teams_num = {4,2,2,2,0,2,0}

local msg_bets = msgh_s2c_def[49][1]	
local msg_awards = msgh_s2c_def[49][2]
local msg_results = msgh_s2c_def[49][3]
local msg_bettime = msgh_s2c_def[49][4]
local isFullNum = isFullNum
local GiveGoods	 = GiveGoods
local math_floor = math.floor
local common_time=require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond

local function fwc_getpdata(sid)
	local pdata = GI_GetPlayerData(sid,"fwc",120)
	--玩家数据结构：fwc = 
	--{
	--[1] = {[1] = 3,[4] = 5,[6] = 4,[球队编号] = 注数,...}, --小组赛 
	--[2] = {[1] = 3,[4] = 5,...},--1/16
	--[3] = {[1] = 3,...},--1/8
	--}
	return pdata
end

--押注
--sid
--mtype 赛程
--team	押注球队（序号）
--bets	押注注数
local function _fwc_team_bet(sid,mtype,team,bets)
	if not bets or bets < 1 then return end
	local tnum = teams_num[mtype]
	if not tnum or tnum<= 0 then return end
	local index = math_floor((team-1)/tnum)
	local nowTime = GetServerTime()
	if mtype == 1 then
		local t = matchs_table.bets_time[mtype][index+1]
		if nowTime > GetTimeToSecond(t[1],t[2],t[3],t[4],t[5],t[6]) then
			look("time error",2)
			SendLuaMsg(0,{ids = msg_bets,res = 4},9)
			return 
		end
	else
		local t1 = matchs_table.bets_time[mtype][index+1][1]
		local t2 = matchs_table.bets_time[mtype][index+1][2]
		if nowTime < GetTimeToSecond(t1[1],t1[2],t1[3],t1[4],t1[5],t1[6]) 
		or nowTime > GetTimeToSecond(t2[1],t2[2],t2[3],t2[4],t2[5],t2[6])  then
			look("time error",2)
			SendLuaMsg(0,{ids = msg_bets,res = 4},9)
			return 
		end
	end
	local i,iStart
	iStart = tnum * index + 1 
	local iEnd = iStart + tnum -1
	local tmax = tnum / 2                                                       
	local pdata = fwc_getpdata(sid)
	if not pdata then return end
	pdata[mtype]= pdata[mtype]or{}
	local pbets = pdata[mtype]
	local team_id = matchs_table[mtype][team]
	if not team_id then return end
	---判断能不能押注
	for i = iStart,iEnd do
		local tid = matchs_table[mtype][i]
		if pbets[tid] then
			if team_id ~= tid then
				tmax = tmax - 1
			else break end
		end
	end
	if tmax <= 0 then
		SendLuaMsg(0,{ids = msg_bets,res = 1},9)
		look('不能再压注了!',2)
		return
	end
	-----------------
	
	--判断超过最大押注没有
	local last = pbets[team_id] or 0
	local curr = last + bets
	if curr > matchs_table.bets_max then
		if last < matchs_table.bets_max then
			curr = matchs_table.bets_max
		else
			SendLuaMsg(0,{ids = msg_bets,res = 2},9)
			return
		end
	end
	------------------
	
	--物品元宝消耗
	bets = curr - last
	if 0 == CheckGoods(	matchs_table.cost_goods[1],
						matchs_table.cost_goods[2] * bets,0,sid,'世界杯竞猜') then
		if not CheckCost(sid ,matchs_table.cost_yb * bets,0,1,"世界杯竞猜") then
			SendLuaMsg(0,{ids = msg_bets,res = 3},9)
			return
		end
	end 
	---------------------
	
	--记录押注数
	pbets[team_id] = curr
	---------------------
	SendLuaMsg(0,{ids = msg_bets,mtype=mtype,team = team_id,bets = curr},9)
end

local function _fwc_addgoods(ttable,goodsid,goodscount,isgoodsbind)
	ttable[goodsid] = ttable[goodsid] or {}
	local pgoods = ttable[goodsid]
	pgoods[1] = goodsid
	pgoods[3] = isgoodsbind
	pgoods[2] = (pgoods[2] or 0 ) + goodscount
end

local function _fwc_gettable_len(ttable)
	local count = 0
	for k,v in pairs(ttable) do count = count + 1 end return count
end
--领奖
--sid
--mtype 赛程
--team	押注球队（编号）
local function _fwc_get_awards(sid,mtype,team)
	local pres = matchs_table[mtype+1]
	if not pres then
		SendLuaMsg(0,{ids = msg_awards,mtype=mtype,res = 1},9) --结果未出来
		return
	end
	local pdata = fwc_getpdata(sid)
	if not pdata then return end
	local pbets = pdata[mtype]
	if not pbets then return end
	
	local goods = matchs_table.awards_table[mtype][1]
	local k,v
	if team then --分组领奖
		if pbets[team] then 
			local bbet = false
			for k,v in pairs(pres) do
				if v == team then	--押中奖励
					------
					local batch_goods = matchs_table.awards_table[mtype][2]
					local goods_count = 1 + #batch_goods
					if isFullNum() < goods_count then
						TipCenter(GetStringMsg(14,goods_count))
						return
					end
					------					
					local count = pbets[team] 
					pbets[team] = nil
					
					GiveGoods(goods[1],goods[2] * count,1,"世界杯竞猜")
					GiveGoodsBatch(batch_goods,"世界杯竞猜")
					
					bbet = true
					break
				end
			end
			if not bbet then --未押中奖励 
				-------
				if isFullNum() < 1 then
					TipCenter(GetStringMsg(14,1))
					return
				end
				-------                      

				local count = pbets[team] 
				pbets[team] = nil
				GiveGoods(	goods[1],
							goods[2] * count / 2,1,"世界杯竞猜")
			end
			SendLuaMsg(0,{ids = msg_awards,mtype=mtype,team = team},9)
		else
			SendLuaMsg(0,{ids = msg_awards,mtype=mtype,team = team,res = 2},9) 
		end
	else --一键领奖
		local gots_flag = {}
		local goods_batch = {}
		
		for k,v in pairs(pres) do	--押中奖励
			if pbets[v] then
				local count = pbets[v]
				gots_flag[v]=true
				
				local k1,v1
				for k1,v1 in pairs(matchs_table.awards_table[mtype][2]) do
					_fwc_addgoods(goods_batch,v1[1],v1[2],v1[3])
				end
				_fwc_addgoods(goods_batch,goods[1],goods[2] * count,1)
			end
		end
		
		for k,v in pairs(pbets) do	--未押中奖励 
			if(type(k) == type(0)) and not gots_flag[k] then
				_fwc_addgoods(goods_batch,goods[1],goods[2] * v / 2,1)
			end
		end
		
		local goods_count = _fwc_gettable_len(goods_batch)
		if isFullNum() < goods_count then
			TipCenter(GetStringMsg(14,goods_count))
			return
		end
		
		pdata[mtype] = nil
		--look(goods_batch,2)
		
		for k,v in pairs(goods_batch) do
			GiveGoods(v[1],v[2],v[3],"世界杯竞猜")
		end
		SendLuaMsg(0,{ids = msg_awards,mtype=mtype},9) 
	end
end

local function _fwc_get_results( playerid,mtype)
	look("_fwc_get_results",2)
	SendLuaMsg(0,{ids = msg_results,mtype = mtype,res = matchs_table[mtype]},9) 
end

local function _fwc_get_bettime( playerid)
	SendLuaMsg(0,{ids = msg_bettime,res = matchs_table.bets_time},9) 
end

fwc_team_bet = _fwc_team_bet
fwc_get_awards = _fwc_get_awards
fwc_get_results = _fwc_get_results
fwc_get_bettime = _fwc_get_bettime