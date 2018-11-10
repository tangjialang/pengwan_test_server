local pairs,ipairs,type = pairs,ipairs,type

local look = look
local CI_GetPlayerData = CI_GetPlayerData
local GetTaskType = GetTaskType
local define		= require('Script.cext.define')
local TaskTypeTb 	= define.TaskTypeTb

-- 活动任务
function ATS_AutoClear(sid)	
	local taskdata =  GetDBTaskData(sid)
	if taskdata == nil then return end
	local level = CI_GetPlayerData(1,2,sid)
	if level == nil or level <= 0 then
		return
	end

	-- 清除已完成的活动任务
	for tid in pairs(taskdata.completed) do
		if type(tid) == type(0) then
			local taskType = GetTaskType(tid)	
			if taskType == TaskTypeTb.TS_ACT then
				taskdata.completed[tid] = nil
			end
		end
	end
end