--[[
file: DayTask_System.lua
desc: 日常任务系统
]]--

local pairs,ipairs,type = pairs,ipairs,type

local look = look
local table_locate = table.locate
local CanAcceptConf = CanAcceptConf
local CI_GetPlayerData = CI_GetPlayerData
local GetTaskType = GetTaskType
local MarkKillInfo = MarkKillInfo
local define		= require('Script.cext.define')
local TaskTypeTb 	= define.TaskTypeTb

-- 日常任务每天自动接
function DTS_AutoAccept(sid)
	
	local taskdata =  GetDBTaskData(sid)
	if taskdata == nil then return end
	local level = CI_GetPlayerData(1,2,sid)
	if level == nil or level <= 0 then
		return
	end

	-- 清除已完成的日常任务
	for tid in pairs(taskdata.completed) do
		if type(tid) == type(0) then
			local taskType = GetTaskType(tid)	
			if taskType == TaskTypeTb.TS_DAY then
				taskdata.completed[tid] = nil
			end
		end
	end
	-- 清除已接未完成的日常任务
	for tid in pairs(taskdata.current) do
		if type(tid) == type(0) then
			local taskType = GetTaskType(tid)	
			if taskType == TaskTypeTb.TS_DAY then
				taskdata.current[tid] = nil
			end
		end
	end
	-- 自动接收可接的日常任务
	local curtask = taskdata.current
	if type(curtask) ~= type({}) then
		return
	end
	local pos = table_locate(CanAcceptConf,level,1)
	if pos == nil then return end
	local t = CanAcceptConf[pos]
	if type(t) ~= type({}) then 
		return
	end
		
	for _, tid in ipairs(t) do
		if curtask[tid] == nil then		
			TS_AcceptTask(sid,tid,0)
		end
	end
	
end

-- 是否是帮会日常
function DTS_FactionTaskIdx(tid)
	local taskInfo = GetTaskConfig(tid)
	if( taskInfo == nil or taskInfo.facidx == nil ) then
		return 0
	end
	return taskInfo.facidx
end

-- 帮会日常一键完成
function DTS_DirectComplete(sid)
	if type(sid) ~= type(0) then return end	
	local taskdata =  GetDBTaskData(sid)
	if taskdata == nil then return end
	local level = CI_GetPlayerData(1,2,sid)
	if level == nil or level < 30 then
		return
	end
	local rest = 0
	taskdata.current = taskdata.current or {}
	taskdata.completed = taskdata.completed or {}
	for tid in pairs(taskdata.current) do
		if type(tid) == type(0) then
			local taskType = GetTaskType(tid)	
			if taskType == TaskTypeTb.TS_DAY and DTS_FactionTaskIdx(tid) > 0 then
				rest = 20 - DTS_FactionTaskIdx(tid) + 1
			end
		end
	end
	look('DTS_DirectComplete rest:' .. tostring(rest))
	if rest <= 0 or rest > 20 then
		look('DTS_DirectComplete rest erro',1)
		return
	end
	-- 取最后一环任务
	local lastID = nil
	local exps = 0
	if level >= 30 and level < 40 then
		lastID = 4174
		exps = 30000
	elseif level >= 40 and level < 45 then
		lastID = 4194
		exps = 40000
	elseif level >= 45 and level < 50 then
		lastID = 4214
		exps = 50000
	elseif level >= 50 and level < 60 then
		lastID = 4234
		exps = 80000
	elseif level >= 60 and level < 100 then
		lastID = 4254
		exps = 100000
	end
	if lastID == nil then
		return
	end
	-- 检查背包
	local pakagenum = isFullNum()
	if pakagenum < 2 then
		TipCenter(GetStringMsg(14,2))
		return
	end
	local cost = rint(rest * 3)
	if cost <= 0 then return end
	if not CheckCost(sid,cost,0,1,"帮会日常一键完成") then
		return
	end
		
	-- 清除完成
	for tid in pairs(taskdata.completed) do
		if type(tid) == type(0) then
			local taskType = GetTaskType(tid)	
			if taskType == TaskTypeTb.TS_DAY and DTS_FactionTaskIdx(tid) > 0 then
				taskdata.completed[tid] = nil
			end
		end
	end
	
	-- 清除当前
	for tid in pairs(taskdata.current) do
		if type(tid) == type(0) then
			local taskType = GetTaskType(tid)	
			if taskType == TaskTypeTb.TS_DAY and DTS_FactionTaskIdx(tid) > 0 then
				taskdata.current[tid] = nil
			end
		end
	end
	-- 设置最后一环完成
	if lastID then
		taskdata.completed[lastID] = 1
	end
	-- 给奖励
	exps = rint(exps * rest)
	CI_PayPlayer(1,exps,0,0,"一键帮会日常")
	GiveGoods(682,rest,1,"一键帮会日常")
	GiveGoods(749,1,1,"一键帮会日常")
end