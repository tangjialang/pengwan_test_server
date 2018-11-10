--[[
file：	.lua
desc:	铜钱捐献
author: wjl
update: 2014-11-12
]]--
--------------------------------------------------------------------------
--include:
local look = look
local type = type
local tostring = tostring
local pairs = pairs
local __G = _G
local CI_GetPlayerData = CI_GetPlayerData
local GiveGoods = GiveGoods
local GiveGoodsBatch = GiveGoodsBatch
local TipCenter = TipCenter
local SendLuaMsg = SendLuaMsg
local BroadcastRPC=BroadcastRPC
local isFullNum = isFullNum
local GetStringMsg = GetStringMsg
local CheckCost = CheckCost
local GetServerTime = GetServerTime
local GetServerID = GetServerID
local CI_AddBuff = CI_AddBuff
local CI_DelBuff = CI_DelBuff
local CI_HasBuff = CI_HasBuff

local SetPlayerTitle = SetPlayerTitle
local SetShowTitle = SetShowTitle

local msgh_s2c_def = msgh_s2c_def
local player_donate_result = msgh_s2c_def[3][27]					-- 玩家捐献结果	
local player_donate_award = msgh_s2c_def[3][28]				-- 捐献领奖结果
local player_donate_rank = msgh_s2c_def[3][29]					-- 返回捐献排行榜信息
local player_donate_login = msgh_s2c_def[3][30]					-- 玩家上线处理（提示某某爵位上线）
local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist = sclist_m.insert_scorelist
local get_scorelist_data = sclist_m.get_scorelist_data
local get_score_rank = sclist_m.get_score_rank
local Log = Log

module(...)
-----------------------------------------------------------------------------------------------------

local donate_conf = {
	itype = 12,				-- 排行榜类型
	maxrank = 5,			-- 可获取称号的最大排名
	
	condition = {			-- 领取条件（铜钱捐献数量）
		[1] = 1000000,
	},
	award = {				-- 奖励配置（{item,num,binding}）
		[1] = {{1586,1,1},},
	},
	title = {						-- 称号配置
		[1] = 67,[2] = 68,[3] = 69,[4] = 70,[5] = 71,			-- title配置,titleID
	},
	buff = {					
		[1] = 261,[2] = 262,[3] = 263,[4] = 264,[5] = 265,			-- buff配置,buffid
	},
}

--[[	铜钱捐献数据 -- 每日清空
	jx_data = {
		sclist = {捐献排行榜},
		[sid] = {今日捐献铜钱数, 玩家领奖索引}
		...
	}
--]]

-- 添加进世界数据
local function get_donate_wcdata()
	local getwc_data = __G.GetWorldCustomDB()
	if getwc_data == nil then 
		return 
	end
	if  getwc_data.jx_data == nil then
		getwc_data.jx_data = {}	
	end
	return getwc_data.jx_data
end

-- 玩家捐献世界数据
local function get_player_wcdata(sid)
	local jx_data = get_donate_wcdata()
	if jx_data == nil then return end
	if jx_data[sid] == nil then
		jx_data[sid] ={}
	end
	return jx_data[sid]
end

-- 玩家捐献每日数据
local function get_player_day_data(sid)
	local day_data = __G.GetPlayerDayData(sid)
	if day_data == nil then return end
	if day_data.donate == nil then
		day_data.donate = {}
	end
	--[[
	data = {
		[1] = {捐献铜钱数量},
		[2] = {领奖索引},
		[3] = {刷新时间},
	}
	]]
	return day_data.donate
end

-- 玩家捐献处理
local function _player_donate(sid, money)
	if sid == nil or sid == 0 then return end
	if money == nil then return end
	if money < 10000 then return end						-- 每次最少1W
	local day_data = get_player_day_data(sid)		-- 玩家每日捐献数据
	local wc_data = get_player_wcdata(sid)				-- 玩家捐献世界数据
	if day_data == nil or wc_data == nil then return end
	if not __G.CheckCost(sid,money,0,3,"捐献") then	-- 铜钱扣除检查
		TipCenter("铜钱不足")
		return
	end
	wc_data[1] = (wc_data[1]	or 0	) + money	-- 更新玩家捐献世界数据
	day_data[1] = (wc_data[1] or 0) 				-- 更新玩家每日捐献数据
	-- 将玩家数据插入排行榜
	local itype = donate_conf.itype
	local name = CI_GetPlayerData(3)
	local school = CI_GetPlayerData(2)
	insert_scorelist(1,itype,30,wc_data[1],name,school,sid)
	SendLuaMsg(0,{ids = player_donate_result, wc_data[1]},9)
end

-- 领取捐献宝箱
local function _get_donate_award(sid, idx)		-- idx 领奖索引
	if sid == nil or sid == 0 then return end
	local wc_data = get_player_wcdata(sid)			-- 获取玩家捐献数据
	local condition = donate_conf.condition[idx]
	if wc_data == nil or wc_data[1] < condition then
		return
	end
	if idx <= (wc_data[2] or 0) then return end				-- 此奖励已领取
	local award = donate_conf.award[idx]
	local pakagenum = isFullNum()
	if pakagenum < #award then							-- 包裹判断
		TipCenter(GetStringMsg(14,#award))
		return
	end
	GiveGoodsBatch( award,"捐献宝箱")
	wc_data[2] = idx												-- 更新玩家领奖索引
	local day_data = get_player_day_data(sid)	-- 玩家每日捐献数据
	if day_data == nil then return end
	day_data[2] = idx												-- 更新玩家领奖索引
	SendLuaMsg(0,{ids = player_donate_award, idx},9)
end

-- 每小时清除玩家铜钱捐献所获buff
local function _clear_donate_buff(sid)
	local buffid = nil
	local titleID = nil
	for i =1, #donate_conf.buff do
		buffid = donate_conf.buff[i]
		CI_DelBuff(buffid,2,sid)						-- 直接删除，无需判断
	end	
	for i =1, #donate_conf.title do
		titleID = donate_conf.title[i]
		__G.RemovePlayerTitle(sid,titleID)						-- 直接删除，无需判断
	end
	look("清除玩家铜钱捐献buff和称号")
end

-- 每个小时重新获取排行榜（在此之前已将buff清除，称号时间可重写，无需清空）
local function _donate_rank_refresh()

	local itype = donate_conf.itype
	local donate_wcdata = get_donate_wcdata()		-- 将排行榜更新到世界数据
	donate_wcdata.rtime = GetServerTime()			-- 记录刷新时间
	if donate_wcdata then
		donate_wcdata.sclist = donate_wcdata.sclist or {}
	end
	donate_wcdata.sclist = get_scorelist_data(1,itype)
	local scorelist = donate_wcdata.sclist
	BroadcastRPC('donate_rank',scorelist)				-- 全局广播，同步排行榜至前台
	-- 向符合条件的玩家发送称号
	local buffid = nil 
	for i=1,donate_conf.maxrank do
		if scorelist[i] and type(scorelist[i]) == type({}) and scorelist[i][4] then
			if donate_wcdata.rank == nil then
				donate_wcdata.rank = {}
			end
			sid = scorelist[i][4]
			donate_wcdata.rank[i] = sid
			titleID = donate_conf.title[i]
			__G.SetPlayerTitle(sid,titleID,donate_wcdata.rtime + 3600)		-- 添加称号至玩家称号列表
			__G.SetShowTitle(sid,{titleID,0,0,0})					-- 设置称号显示					
			

			buffid = donate_conf.buff[i]
			CI_AddBuff(buffid,0,1,false,2,sid)				-- 增加玩家buff
			
			local day_data = get_player_day_data(sid)		-- 在玩家每日捐献数据记录刷新时间
			if day_data ~= nil then
				day_data[3] = donate_wcdata.rtime
			end
		end
	end

end

-- 前台请求捐献排行数据
local function _get_donate_panel(sid)
	local day_data = get_player_day_data(sid)		-- 玩家每日捐献数据
	if day_data == nil then return end
	num = day_data[1] or 0
	idx = day_data[2] or 0
	local donate_wcdata = get_donate_wcdata()
	local scorelist = {}
	if donate_wcdata and donate_wcdata.sclist then
		scorelist = donate_wcdata.sclist
	end
	SendLuaMsg(0,{ids = player_donate_rank, sclist = scorelist, num = num, idx = idx},9)
end

-- 每日清空捐献数据
local function _donate_day_clear()
	local getwc_data = __G.GetWorldCustomDB()
	if getwc_data and getwc_data.jx_data ~= nil then
		getwc_data.jx_data = nil
	end

end

-- 玩家上线处理玩家称号（合服时玩家数据处理）
local function _donate_onlogin(sid)
	--look("铜钱捐献玩家上线处理")
	if sid == nil or sid <= 0 then return end
	if __G.IsSpanServer() then return end		-- 玩家进跨服，不做处理
	-- 如果玩家进本服，但玩家世界数据丢失，说明进行了合服，将玩家数据重新写入并排名
	local day_data = get_player_day_data(sid)		-- 玩家每日捐献数据
	local wc_data = get_player_wcdata(sid)				-- 玩家捐献世界数据
	if day_data == nil or wc_data == nil then return end
	if day_data[1] and wc_data[1] == nil then			-- 合服时进行此处理
		wc_data[1] = day_data[1]									-- 玩家捐献世界数据为空时，将玩家每日捐献数据写入(捐献数量)
		local itype = donate_conf.itype
		local name = CI_GetPlayerData(3)
		local school = CI_GetPlayerData(2)
		local serverID = GetServerID()
		insert_scorelist(1,itype,30,wc_data[1],name,school,sid)		-- 插入排行榜
	end
	--
	if day_data[2] and wc_data[2] == nil then			-- 合服时进行此处理
		wc_data[2] = day_data[2]									-- 玩家捐献世界数据为空时，将玩家每日捐献数据写入(领奖索引)
	end
	--
	local donate_wcdata = get_donate_wcdata()		-- 将排行榜更新到世界数据
	if donate_wcdata == nil or donate_wcdata.rtime == nil or donate_wcdata.sclist == nil or donate_wcdata.rank == nil then return end		-- 判断刷新时间

	local refresh_time = donate_wcdata.rtime 
	
	-- 如果玩家数据记录刷新时间和世界数据记录刷新时间相同（无需进行处理）
	if day_data[3] and day_data[3] == donate_wcdata.rtime then return end			
	day_data[3] = donate_wcdata.rtime						-- 更新玩家数据记录的刷新时间
	--判断玩家是否在排行中
	local scorelist = donate_wcdata.sclist 
	local continue = false
	for i=1,#donate_wcdata.rank do
		if sid == donate_wcdata.rank[i] then
			continue = true
		end
	end
	if continue == false then return end
	-- 删除玩家buff(if has buff)
	local buffid = nil
	for i =1, #donate_conf.buff do						
		buffid = donate_conf.buff[i]
		--look("玩家登录，清除buff")
		CI_DelBuff(buffid,2,sid)									-- 直接删除，无需判断
	end
	-- 如果玩家处于前五名，为玩家添加称号和buff
	for i=1,donate_conf.maxrank do
		if scorelist[i] and type(scorelist[i]) == type({}) and scorelist[i][4] and sid == scorelist[i][4] then
			titleID = donate_conf.title[i]
			__G.SetPlayerTitle(sid,titleID,refresh_time + 3600)		-- 添加称号至玩家称号列表
			__G.SetShowTitle(sid,{titleID,0,0,0})					-- 装备玩家称号
			buffid = donate_conf.buff[i]
			--look("add buff buffid = " .. tostring(buffid))
			CI_AddBuff(buffid,0,1,false,2,sid)				-- 增加玩家buff
		end
	end	
end

------------------------------------------------------------------------------------------------------------------
--interface：
player_donate 			= _player_donate
get_donate_award 	=_get_donate_award
clear_donate_buff 	= _clear_donate_buff
donate_rank_refresh = _donate_rank_refresh
get_donate_panel 	= _get_donate_panel
donate_day_clear 		= _donate_day_clear
donate_onlogin 			= _donate_onlogin