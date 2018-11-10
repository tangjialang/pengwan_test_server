--[[
file:	player_openget.lua
desc:	七天累积登陆奖励 & 每日首充
author:	xy
]]--
--------------------------------------------------------------------------
--include:
local Player_7day_data = msgh_s2c_def[3][18]
local Player_everyday_sc = msgh_s2c_def[3][20]
local Player_everyday_sc_err = msgh_s2c_def[3][21]
local isFullNum = isFullNum
local SendLuaMsg = SendLuaMsg
local GetDBActiveData = GetDBActiveData
local GiveGoodsBatch = GiveGoodsBatch
local GI_GetVIPType = GI_GetVIPType
local osdate = os.date
local GetServerOpenTime = GetServerOpenTime
local GetServerTime = GetServerTime
local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond
local mathfloor = math.floor
local uv_TimesTypeTb = TimesTypeTb
local CheckTimes = CheckTimes
local award_check_items = award_check_items
local GI_GiveAward = GI_GiveAward
--------------------------------------------------------------------------
-- data:
--七天奖励配置
local sevenLoginConf = {
	[1] = {
		[1] = {{601,10,1},{644,20,1},{638,20,1},{768,1,1}}, --普通
		[2] = {{625,1,1},{636,10,1},{601,50,1},}, --VIP
	},
	[2] = {
		[1] = {{601,15,1},{603,15,1},{605,10,1},{768,1,1}}, --普通
		[2] = {{625,1,1},{636,10,1},{601,50,1},}, --VIP
	},
	[3] = {
		[1] = {{601,20,1},{603,20,1},{51,3,1},{199,1,1}}, --普通
		[2] = {{625,1,1},{636,10,1},{601,50,1},}, --VIP
	},
	[4] = {
		[1] = {{601,25,1},{603,25,1},{636,10,1},{634,10,1},{768,1,1}}, --普通
		[2] = {{625,1,1},{636,10,1},{601,50,1},}, --VIP
	},
	[5] = {
		[1] = {{601,30,1},{603,30,1},{693,10,1},{692,10,1},{768,1,1}}, --普通
		[2] = {{625,1,1},{636,10,1},{601,50,1},}, --VIP
	},
	[6] = {
		[1] = {{601,35,1},{603,35,1},{691,10,1},{642,1,1},{768,1,1}}, --普通
		[2] = {{625,1,1},{636,10,1},{601,50,1},}, --VIP
	},
	[7] = {
		[1] = {{601,50,1},{603,50,1},{663,1,1},{302,1,1},{768,1,1}}, --普通
		[2] = {{625,1,1},{636,10,1},{601,50,1},}, --VIP
	},
}

--每日首充配置 	1绑银2经验3道具4绑定元宝5灵气6帮会贡献7战功
local sc_every_cof = {
	[1] = {
		[3] = {{710,2,1},{713,1,1},{3021,1,1},{52,1,1}},
		[1] = 300000,
		[5] = 300000,
	},
	[2] = {
		[3] = {{636,5,1},{627,20,1},{3024,1,1},{52,1,1}},
		[1] = 300000,
		[5] = 300000,
	},
	[3] = {
		[3] = {{625,1,1},{626,20,1},{3030,1,1},{52,1,1}},
		[1] = 300000,
		[5] = 300000,
	},
	[4] = {
		[3] = {{634,5,1},{635,5,1},{3027,1,1},{52,1,1}},
		[1] = 300000,
		[5] = 300000,
	},
	[5] = {
		[3] = {{762,5,1},{765,2,1},{3065,1,1},{52,1,1}},
		[1] = 300000,
		[5] = 300000,
	}
}

--获取7天登录奖励数据,放在活动数据下
function login_7day_getdata(sid)
	local adata=GetDBActiveData( sid )
	if adata==nil then return end
	if adata.kflog==nil then
		adata.kflog={} 
		--[1] 当前领取的奖励类型 1 普通 2 VIP 
		--[2] 已经领取了几天
	end
	return adata.kflog
end
--领取7天登录奖励
function login_7day_get_gift(sid)
	local data = login_7day_getdata(sid)
	if(data == nil)then return false,0 end --获取数据出错
	
	local vip = GI_GetVIPType(sid)
	
	local giftTb
	local giftIdx
	if(vip == 0 or vip == 1)then
		giftIdx = 1 --奖励索引
	else
		giftIdx = 2
	end
	
	local curGet = data[2] == nil and 0 or data[2]
	if(data[1] == nil)then --当天第一次领
		curGet = curGet + 1
	else
		if(data[1]>=giftIdx)then return false,1 end --已领取过
	end
	
	local first = data[1] == nil and 1 or data[1]+1
	local giftTb
	local pakagenum
	local issend = false
	while(first<=giftIdx)do
		if(sevenLoginConf[curGet] == nil or sevenLoginConf[curGet][first] == nil)then
			if(issend)then
				SendLuaMsg( 0, { ids = Player_7day_data,data = data}, 9 )
			end
			return false,2 
		end --没有奖励可以领取
		giftTb = sevenLoginConf[curGet][first]
		pakagenum = isFullNum()
		if pakagenum < #giftTb then
			if(issend)then
				SendLuaMsg( 0, { ids = Player_7day_data,data = data}, 9 )
			end
			return false,3 
		end --背包空格不足
		
		GiveGoodsBatch(giftTb,"新写的登陆7天奖励")
		data[1] = first
		data[2] = curGet
		issend = true
		first = first+1
	end

	SendLuaMsg( 0, { ids = Player_7day_data,data = data}, 9 )
	
	return true
end
--每日重置领取
function login_7day_reset(sid)
	local data = login_7day_getdata(sid)
	if data == nil or data[1] == nil then return end
	data[1] = nil
	SendLuaMsg( 0, { ids = Player_7day_data,data = data}, 9 )
end

--每日重置领取
function login_7day_clear(sid)
	local data = login_7day_getdata(sid)
	if data ~= nil then
		data[1] = nil
		data[2] = nil
	end
	SendLuaMsg( 0, { ids = Player_7day_data,data = data}, 9 )
end

---------------------每日首充---------------------------
--领取取每日首充奖励
function get_sc_everyday(sid)
	local isget = CheckTimes(sid,uv_TimesTypeTb.sc_everyday,1,-1,1)
	if(not isget)then --今日已领取过
		--今日已领取过
		SendLuaMsg( 0, { ids = Player_everyday_sc_err,err = 1}, 9 )
		return
	end

	local svrTime = GetServerOpenTime() --开服时间
	local dt = osdate("*t", svrTime)
	local sec = GetTimeToSecond(dt.year,dt.month,dt.day,0,0,0)
	local now = GetServerTime()
	dt = osdate("*t", now)
	local days = mathfloor((now - sec)/(24*60*60))
	if(days <= 0)then
		--开服第2天才有
		SendLuaMsg( 0, { ids = Player_everyday_sc_err,err = 2}, 9 )
		return
	end
	
	local today = dt.year..'-'..dt.month..'-'..dt.day
	Getbuyfillinfo(sid,today..' 00:00:00',today..' 23:59:59',6)
end
--领取每日首充奖励
function get_sc_everyday_gift(sid,num)
	if(num<=0)then
		--今日是否充值
		SendLuaMsg( 0, { ids = Player_everyday_sc_err,err = 5}, 9 )
		return
	end

	local isget = CheckTimes(sid,uv_TimesTypeTb.sc_everyday,1,-1,1)
	if(not isget)then --今日已领取过
		--今日已领取过
		SendLuaMsg( 0, { ids = Player_everyday_sc_err,err = 1}, 9 )
		return
	end
	
	local svrTime = GetServerOpenTime() --开服时间
	local dt = osdate("*t", svrTime)
	local sec = GetTimeToSecond(dt.year,dt.month,dt.day,0,0,0)
	local now = GetServerTime()
	local days = mathfloor((now - sec)/(24*60*60))
	if(days <= 0)then
		--开服第2天才有
		SendLuaMsg( 0, { ids = Player_everyday_sc_err,err = 2}, 9 )
		return
	end
	local len = #sc_every_cof
	local idx = mathfloor((days-1)%len)+1
	local giftTb = sc_every_cof[idx]
	if(giftTb==nil)then
		--配置出错
		SendLuaMsg( 0, { ids = Player_everyday_sc_err,err = 3}, 9 )
		return
	end
	
	if(giftTb[3]~=nil)then --有道具奖励
		if(not award_check_items( giftTb ))then
			SendLuaMsg( 0, { ids = Player_everyday_sc_err,err = 4}, 9 )
			return
		end
	end
	
	--1绑银2经验3道具4绑定元宝5灵气6帮会贡献7战功
	GI_GiveAward(sid, giftTb, '每日首充奖励'..idx)
	CheckTimes(sid,uv_TimesTypeTb.sc_everyday,1,-1)
	SendLuaMsg( 0, { ids = Player_everyday_sc,data = idx}, 9 )
end

