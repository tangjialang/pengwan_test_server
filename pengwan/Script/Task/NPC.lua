--[[
file:	NPC.lua
desc:	task npc functions
author:	chal
update:	2011-11-30
]]--

local TableHasKeys = table.has_keys
local look = look
local call_npc_click = call_npc_click
local GetObjectUniqueId = GetObjectUniqueId
local GetDBTaskData,GetTaskConfig,CollectItem = GetDBTaskData,GetTaskConfig,CollectItem
local type,pairs = type,pairs
-- 标记任务NPC
local function _markTaskNpc( taskid, taskData, npcid )
	if nil==taskdata.current[taskid].npc then
		taskdata.current[taskid].npc = {}
	end
	look('_markTaskNpc='..npcid)
	taskdata.current[taskid].npc[npcid] = 1
end

-- task npc scriptID：30000
-- task npc interface
call_npc_click[30000] = function ()	

	local npcid, _, playerid = GetObjectUniqueId()
	npcid = npcid - 100000
	
	if npcid>=100000 and npcid<200000 then -- collection
		--local taskData = GetDBTaskData( playerid)
		CollectItem(npcid,playerid)
		return
	end
end

--:tasks with completed conditon 'click npc'
local function TaskClickNpc( taskid, taskData, npcid, _handler)	
	if 	taskdata == nil or npcid == nil or taskid == nil or taskdata.current[taskid] == nil then		
		return
	end
	local taskInfo = GetTaskConfig(taskid)
	if taskInfo then
		if TableHasKeys(taskInfo, {"CompleteCondition",'npc'}) then
			--rfalse('TaskClickNpc')
			local condition = taskInfo.CompleteCondition.npc
			if type(condition)==type({}) then
				for _, npc in pairs(condition) do
					if npc==npcid then
						--rfalse('npc==npcid,'..npcid)
						_handler(taskid, taskData, npcid)
						return
					end
				end
			else
				if npcid==condition then
					--rfalse('npc==condition,'..npcid)
					_handler(taskid, taskData, npcid)
					return
				end
			end
		end				
	end
	return
end