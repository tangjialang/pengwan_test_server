--[[
file: plant_tree.lua
desc: 植树节活动
autor: csj
]]--

---------------------------------------------------------------------------
-- include:

local look = look
local pairs,ipairs,type = pairs,ipairs,type
local tostring = tostring
local GetServerTime = GetServerTime
local GetPlayerDayData = GetPlayerDayData
local isFullNum = isFullNum
local TipCenter = TipCenter
local GetStringMsg = GetStringMsg
local GiveGoods = GiveGoods
local RPC = RPC
local CheckCost = CheckCost

local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond
local GetDiffDayFromTime = common_time.GetDiffDayFromTime

local pt_beg_tm = GetTimeToSecond(2014,3,12,0,0,0)
local pt_end_tm = GetTimeToSecond(2014,3,12,23,59,59)

local aw_beg_tm = GetTimeToSecond(2014,3,13,0,0,0)
local aw_end_tm = GetTimeToSecond(2014,3,23,23,59,59)

------------------------------------------------------------------
--module

module(...)

-- 植树节奖励
local tree_conf = {
	[1] = {
		{803,5,1},{604,10,1},
	},
	[2] = {
		{803,10,1},{636,5,1},{604,20,1},
	},
	[3] = {
		{803,50,1},{796,10,1},{802,10,1},{789,3,1},
	},
	[4] = {
		{803,300,1},{796,50,1},{802,20,1},{801,3,1},{752,1,1},
	},
}


function _plant_tree(sid,index)
	if sid == nil or index == nil then return end
	local DayData = GetPlayerDayData(sid)
	if DayData == nil then return end
	if DayData.tree == nil then
		DayData.tree = {}		
	end
	-- 判断时间
	local now = GetServerTime()
	if now < pt_beg_tm or now >= pt_end_tm then
		RPC('plant_tree',1)
		return
	end
	-- 判断是否种植过
	if DayData.tree[1] then
		RPC('plant_tree',2)
		return
	end
	-- 判断相应条件
	if index == 1 then
		if not CheckCost(sid, 1000000, 0, 3, '种树') then
			return
		end
	elseif index == 2 then
		if not CheckCost(sid, 488, 0, 1, '种树') then
			return
		end
	elseif index == 3 then
		if not CheckCost(sid, 4888, 0, 1, '种树') then
			return
		end
	elseif index == 4 then
		if not CheckCost(sid, 20000, 0, 1, '种树') then
			return
		end
	else
		return
	end
	-- 设置种树
	DayData.tree[1] = index
	RPC('plant_tree',0,index)	
end

function _gather_tree(sid)
	if sid == nil then return end
	local DayData = GetPlayerDayData(sid)
	if DayData == nil then return end
	if DayData.tree == nil then
		return		
	end
	-- 判断时间
	local now = GetServerTime()
	if now < aw_beg_tm or now >= aw_end_tm then
		RPC('gather_tree',1)
		return
	end
	-- 判断是否种植过
	local index = DayData.tree[1] 
	if index == nil then
		RPC('gather_tree',2)
		return
	end
	-- 取已领取
	local hasget = DayData.tree[2] or 0
	if hasget >= 10 then
		RPC('gather_tree',1)
		return
	end
	-- 取能领取次数
	local canget_all = GetDiffDayFromTime(aw_beg_tm) + 1
	if canget_all > 10 then
		canget_all = 10
	end	
	local curget = canget_all - hasget
	if curget <= 0 then
		RPC('gather_tree',3)
		return
	end
	local award = tree_conf[index]
	if award == nil then return end
	local pakagenum = isFullNum()
	if pakagenum < #award then
		TipCenter(GetStringMsg(14,#award))
		return
	end		
	
	-- 设置领奖次数
	DayData.tree[2] = canget_all
	
	-- 给奖励	
	for k, v in pairs(award) do
		GiveGoods(v[1],v[2]*curget,v[3],'植树节奖励')
	end
	RPC('gather_tree',0,canget_all)
end

------------------------------------------------------------
-- interface:

plant_tree = _plant_tree
gather_tree = _gather_tree