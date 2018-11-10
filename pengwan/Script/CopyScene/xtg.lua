--[[
file：	xtg.lua
desc:	玄天阁
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
local GetWorldCustomDB = GetWorldCustomDB
local CI_GetPlayerData = CI_GetPlayerData
local GiveGoods = GiveGoods
local get_join_factiontime = get_join_factiontime
local GetServerTime = GetServerTime
local TipCenter = TipCenter
local SendLuaMsg = SendLuaMsg
local TimesTypeTb = TimesTypeTb
local GetTimesInfo = GetTimesInfo
local isFullNum = isFullNum
local RPCEx = RPCEx
local FactionRPC = FactionRPC
local GetStringMsg = GetStringMsg
local GetFactionBootData = GetFactionBootData
local msgh_s2c_def = msgh_s2c_def
local cs_xtg_panel = msgh_s2c_def[4][14]					-- 玩家玄天阁数据
local cs_xtg_award_result = msgh_s2c_def[4][15]		-- 玄天阁领奖结果
local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist = sclist_m.insert_scorelist
local get_scorelist_data = sclist_m.get_scorelist_data
module(...)
-----------------------------------------------------------------------------------------------------

--[[	玄天阁数据 -- 每日清空
	-- 由于玩家数据在脱离帮会后不清空，所以玩家数据需多存一份
	xtg_data = {
		[1] = {		--	帮会数据
			[fid] = {
				kill = 帮会杀怪总数,
				[sid] = {当日杀怪总数,玩家帮会奖励已领取索引}
				......
			}
		}
		[2] = {
			[sid] = {当日杀怪总数,玩家帮会奖励已领取索引}
		}
	}
--]]

--添加进世界数据
local function get_xtg_data(idx)		-- idx = 1 帮会数据	idx = 2 个人数据
	local getwc_data = GetWorldCustomDB()
	if getwc_data == nil then 
		return 
	end
	if  getwc_data.xtg_data == nil then
		getwc_data.xtg_data = {}		
	end
	if  getwc_data.xtg_data[idx] == nil then
		getwc_data.xtg_data[idx] = {}					--帮会数据(其中有一份玩家数据)
	end
	return getwc_data.xtg_data[idx]
end

--玄天阁帮会数据
local function _xtg_faction_data(fid)
	local xtg_data = get_xtg_data(1)
	if xtg_data[fid] == nil then
		xtg_data[fid] = {}					
	end
	look("获取帮会数据-- _xtg_faction_data")
	return xtg_data[fid]	
end

--玄天阁个人数据（独立于帮会数据存在）
local function _xtg_player_data(sid)
	local xtg_data = get_xtg_data(2)
	if xtg_data[sid] == nil then
		xtg_data[sid] = {}					
	end
	look("获取玩家数据--_xtg_player_dat")
	return xtg_data[sid]	
end
	
--玄天阁帮会数据中的玩家数据
local function _xtg_faction_player_data(sid)
	local fid = CI_GetPlayerData(23,2,sid)	
	--帮会不存在
	if fid == nil or fid == 0 then
		return	
	end
	local faction_data = _xtg_faction_data(fid)
	--帮会数据不存在
	if faction_data == nil then
		return				
	end
	if faction_data[sid] == nil then
		faction_data[sid] = {}
	end
	look("获取帮会玩家数据--_xtg_faction_player_data")
	return faction_data[sid]
end

-- 玄天阁单次副本数据
local function _xtg_getplayerdata(playerid)
	local csdata=__G.CS_GetPlayerTemp(playerid)
	if csdata==nil then return end
	if csdata.xtg==nil then 
		csdata.xtg={}
		--[[
			[1] = 杀死数
		]]
	end
	return csdata.xtg
end

-- 更新世界数据中玩家/帮会当日杀怪总数
local function _xtg_data_deal(sid)
	-- look("杀怪数量结算-----------------------1")
	local cs_xtg_data = xtg_getplayerdata(sid)
	if cs_xtg_data == nil or cs_xtg_data[1] == nil or cs_xtg_data[1] == 0 then return end
	local increace_num = cs_xtg_data[1]									-- 新增杀怪数量
	cs_xtg_data[1] = 0																-- 将玩家杀怪数量清零
	-- look("杀怪数量结算-----------------------2")
	local data = xtg_player_data(sid)									-- 玩家个人数据（独立于帮会数据）
	if data ~= nil then
		data[1] = (data[1] or 0) + increace_num
		-- look("data[1] = " .. tostring(data[1]))
	end
	local pf_data = _xtg_faction_player_data(sid)								-- 获取玩家数据（存在于帮会数据中）
	if pf_data == nil then return end
	if ( increace_num == nil ) or ( increace_num == 0 ) then return end
	local fid = CI_GetPlayerData(23,2,sid)	
	--帮会不存在
	if fid == nil or fid == 0 then
		return	
	end
	look("fid = " .. tostring(fid))
	local fac_data = _xtg_faction_data(fid)
	if fac_data == nil then return end
	-- look("fac_data.kill = " .. tostring(fac_data.kill))
	-- look("increace_num = " .. tostring(increace_num))
	look("杀怪数量结算-----------------------3")
	look("处理前 pf_data[1] = " .. tostring(pf_data[1]))
	look(fac_data)
	look("处理前 fac_data.kill = " .. tostring(fac_data.kill))
	fac_data.kill = (fac_data.kill or 0)+ increace_num						-- 更新玄天阁帮会数据下帮会杀怪数量
	pf_data[1] = (pf_data[1] or 0) + increace_num							-- 更新玄天阁帮会数据下个人杀怪总数
	look("increace_num = " .. tostring(increace_num))
	look("data[1] = " .. tostring(data[1]))
	look("处理后  pf_data[1] = " .. tostring(pf_data[1]))
	look("处理后  fac_data.kill= " .. tostring(fac_data.kill))
	look("杀怪数量结算-----------------------4")
	-- 插入排行榜
	local itype = 200000000 + fid																--定义排行榜itype, 活动类型 + fid
	local name = CI_GetPlayerData(5,2,sid)
	local school = CI_GetPlayerData(2,2,sid)
	insert_scorelist(1,itype,10,pf_data[1],name,school,sid)
	FactionRPC(fid,'xtg_gang',fac_data.kill, pf_data[1])														-- 同步帮会杀怪和个人杀怪至前台
end

-- 清理玄天阁数据
local function _clear_xtg_data()
	look("清理玄天阁数据---------------------------------------------------1")
	local getwc_data = GetWorldCustomDB()
	if getwc_data == nil then 
		return 
	end
	if  getwc_data.xtg_data ~= nil then
		getwc_data.xtg_data = nil	
	end
	look("清理玄天阁数据---------------------------------------------------2")
end

-- 清理玩家玄天阁数据	-- GM测试用
local function _clear_player_data(sid)
	look("清理玩家玄天阁数据")
	local data = xtg_player_data(sid)									-- 玩家个人数据（独立于帮会数据）
	if data ~= nil then
		data[1] = nil
		data[2] = nil
	end
end

-- 获取玩家击杀、帮会击杀、帮会排名表
local function xtg_data_request(sid)
	-- look("xtg_data_request-----------------------------------------------1")
	if sid == nil or sid == 0 then return end
	local data = xtg_player_data(sid)	
	-- look("xtg_data_request-----------------------------------------------2")
	if data == nil then return end
	local player_kill = data[1] or 0						-- 个人杀怪数量
	-- look("xtg_data_request-----------------------------------------------3")
	local fid = CI_GetPlayerData(23,2,sid)	
	--帮会不存在
	if fid == nil or fid == 0 then return	end
	-- look("xtg_data_request-----------------------------------------------4")
	local fkill_data = _xtg_faction_data(fid)
	if fkill_data  == nil then return end
	-- look("xtg_data_request-----------------------------------------------5")
	local faction_kill = fkill_data.kill or 0				-- 帮会杀怪数量
	local itype = 200000000 + fid									--定义排行榜itype, 活动类型 + fid
	local sclist = get_scorelist_data(1,itype)					--帮会排名
	local player_idx = data[2] or 0					--个人已领取奖励索引
	local player_data = _xtg_faction_player_data(sid)
	local faction_idx = player_data[2] or 0
	-- look("player_kill = " .. tostring(player_kill))
	-- look("faction_kill = " .. tostring(faction_kill))
	-- look(sclist)
	-- look("player_idx = " .. tostring(player_idx))
	-- look("faction_idx = " .. tostring(faction_idx))
	return player_kill,faction_kill, sclist, player_idx, faction_idx
end

-- 获取玩家玄天阁数据(个人击杀，帮会击杀，所需铜钱)
local function _get_xtg_panel(sid)
	local player_kill, faction_kill, sclist,player_idx, faction_idx= xtg_data_request(sid)
	look("player_kill = " .. tostring(player_kill))
	look("faction_kill = " .. tostring(faction_kill))
	look(sclist)
	local res = SendLuaMsg( 0, { ids = cs_xtg_panel, player_kill, faction_kill, sclist,player_idx, faction_idx}, 9)
	look("res = " .. tostring(res))
end

-- 记录玩家杀怪数量并同步至前台
local function _refresh_xtg_player_data(sid)
	if sid ~= nil then
		-- 更新玩家玄天阁杀怪数量
		local cs_xtg_data = _xtg_getplayerdata(sid)
		if cs_xtg_data ~= nil then
			cs_xtg_data[1] = (cs_xtg_data[1] or 0) + 1
			RPCEx(sid,'xtg_num',cs_xtg_data[1])				-- 向前台同步杀怪数量
			look("cs_xtg_data[1] = " .. tostring(cs_xtg_data[1]))
		end
	end
end

-- 杀怪数量配置
local xtg_conf = { 	--[1] 个人  [2] 帮会
	condition = {		-- 领奖条件
		[1] = 1000,	
		[2] = 30000,
	},
	Award = {
		[1] = 30,
		[2] = 20,
	}
}

-- 玄天阁领奖 itype 1 个人 2 帮会
local function _get_xtg_award(sid, itype, idx)
	if sid == nil or sid == 0 then return end
	if idx == nil or idx > 30 then return end
	local num
	if itype == 1 then
		-- 判断是否满足领奖条件
		local data = xtg_player_data(sid)	
		if data == nil then return end
		local player_kill = data[1] or 0		-- 个人击杀
		if player_kill < xtg_conf.condition[itype] * idx then
			TipCenter("个人杀怪数量未达到领奖条件")
			return
		end
		num = xtg_conf.Award[itype] * idx
		if type(Award) == type({}) then
			local pakagenum = isFullNum()
			if pakagenum < #Award then
				TipCenter(GetStringMsg(14,#Award))
				return
			end
		end
		local old_idx = data[2] or 0
		if  idx<= old_idx then
			TipCenter("你已领取过此奖励")
		end
		GiveGoods(1585,num,1,"玄天阁个人奖励领取")
		look("个人领奖索引= " .. tostring(idx))
		data[2] = idx					-- 	更新玩家个人奖励已领取索引
		SendLuaMsg(0,{ids = cs_xtg_award_result, itype = itype, idx = idx},9)
	elseif itype == 2 then
		-- 判断是否满足领奖条件
		local fid = CI_GetPlayerData(23,2,sid)	
		--帮会不存在
		if fid == nil or fid == 0 then
			TipCenter("您还没有加入帮会")
			return
		end
		-- 判断入帮时间
		local jointime= __G.get_join_factiontime(sid)
		if jointime==nil or GetServerTime()-jointime<24*3600 then
			TipCenter("入帮时间不足24小时，不能领取奖励")
			return 
		end
		-- 判断索引是否正确
		local player_data = _xtg_faction_player_data(sid)
		if player_data == nil then return end
		local old_idx = player_data[2] or 0
		if  idx<= old_idx then
			TipCenter("你已领取过此奖励")
		end
		local fac_data = _xtg_faction_data(fid)
		if fac_data == nil then return end
		local faction_kill = fac_data.kill or 0	-- 更新玄天阁帮会数据下帮会杀怪数量
		look("faction_kill = " .. tostring(faction_kill))
		if faction_kill < xtg_conf.condition[itype] * idx then
			TipCenter("帮会杀怪数量未达到领奖条件")
			return
		end
		num = xtg_conf.Award[itype] * idx
		if type(Award) == type({}) then
			local pakagenum = isFullNum()
			if pakagenum < #Award then
				TipCenter(GetStringMsg(14,#Award))
				return
			end
		end
		GiveGoods(1585,num,1,"玄天阁帮会奖励领取")
		look("帮会领奖索引 = " .. tostring(idx))
		SendLuaMsg(0,{ids = cs_xtg_award_result, itype = itype, idx = idx},9)
		player_data[2] = idx		-- 	更新玩家帮会奖励已领取索引
		look("玄天阁帮会奖励领取成功")
	end
end

-- GM命令加杀怪个数
local function _GM_add_kills(sid, num)
	look("num ========== " .. tostring(num))
	local data = xtg_player_data(sid)									-- 玩家个人数据（独立于帮会数据）
	if data ~= nil then
		look("data[1] before add = " .. tostring(data[1]))
		data[1] = (data[1] or 0) + num
		look("data[1] after add = " .. tostring(data[1]))
	end
	local pf_data = _xtg_faction_player_data(sid)								-- 获取玩家数据（存在于帮会数据中）
	if pf_data == nil then return end
	look("pf_data[1] before add = " .. tostring(pf_data[1]))
	pf_data[1] = (pf_data[1] or 0) + num							-- 更新玄天阁帮会数据下个人杀怪总数
	look("pf_data[1] after add = " .. tostring(pf_data[1]))
	local fid = CI_GetPlayerData(23,2,sid)	
	local fac_data = _xtg_faction_data(fid)
	if fac_data == nil then return end
	look("fac_data.kill before add = " .. tostring(fac_data.kill))
	fac_data.kill = (fac_data.kill or 0)+ num						-- 更新玄天阁帮会数据下帮会杀怪数量
	look("fac_data.kill after add = " .. tostring(fac_data.kill))
	local itype = 200000000 + fid																--定义排行榜itype, 活动类型 + fid
	local name = CI_GetPlayerData(5,2,sid)
	local school = CI_GetPlayerData(2,2,sid)
	insert_scorelist(1,itype,10,pf_data[1],name,school,sid)
end


-- 玩家上线，同步玄天阁信息到前台
-- （个人杀怪数量、帮会杀怪数量、当前已领奖索引（个人、帮会）、神兵当前等级、升阶进度、突破进度）
--[[
local function _xtg_online(sid)
	look("-------------------------------------------------------------------xtg_online")
	local player_kill,faction_kill, sclist, player_idx, faction_idx = xtg_data_request(sid)
	-- look("player_kill = " .. tostring(player_kill))
	-- look("faction_kill = " .. tostring(faction_kill))
	-- look("player_idx = " .. tostring(player_idx))
	-- look("faction_idx = " .. tostring(faction_idx))
	RPCEx(sid,'xtg_online',player_kill, faction_kill, sclist,player_idx, faction_idx)
	-- look("res = " .. tostring(res))
	-- look(sclist)
	look("-------------------------------------------------------------------xtg_online")
end
--]]
--------------------------------------------------------------------------------------------------------
--interface:
xtg_faction_data 	= _xtg_faction_data
xtg_player_data 	= _xtg_player_data
xtg_faction_player_data 	= _xtg_faction_player_data
xtg_data_deal 		= _xtg_data_deal
get_xtg_panel 		= _get_xtg_panel
get_xtg_award 	= _get_xtg_award
xtg_getplayerdata = _xtg_getplayerdata
refresh_xtg_player_data 	= _refresh_xtg_player_data
get_xtg_rank 		= _get_xtg_rank
clear_xtg_data 	= _clear_xtg_data
clear_player_data = _clear_player_data
GM_add_kills = _GM_add_kills