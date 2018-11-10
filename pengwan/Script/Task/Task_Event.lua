--[[
file:	task_event.lua
desc:	task event handle(S&C)
author:	chal
update:	2011-12-01
]]--
--[[
local pairs,unpack = pairs,unpack
local look = look
local GiveGoodsBatch = GiveGoodsBatch
TaskEventTable = {
	-- do event already register
	OnEvent = function(events,taskData,taskid)
		for k,v in pairs(events) do
			local ok,retCode,nCount  = TaskEventTable[k](v,taskData,taskid)
			if not ok then
				return ok,retCode,nCount 
			end
		end
		
		return true
	end,
	-- give items when accept task
	items = function(opData,taskData,taskid)
		if opData == nil then
			look("opData is nil")
			return false
		end
	
		local addGood = {}
		if type(opData[1])~='table' then
			table.push( addGood, { opData[1],opData[2],0 } )
		end

		for k,v in pairs(opData) do
			table.push( addGood, { v[1], v[2],0 } )
		end	
		
		local succ,retCode,nCount = GiveGoodsBatch(addGood)
		if not succ then
			return false,retCode,nCount
		end
	
		return true
	end,
	-- call function given directly
	callFunction = function(functionName, ...)
		--rfalse('TaskEventTable::'..functionName)
		local f = _G[functionName]
		if f then
			if arg.n then
				f(unpack(arg) )
			else
				f()
			end
			return true
		else
			--rfalse( "***Config Error: callFunction Function not exist: " .. tostring(functionName) )
			return false
		end	
	end
}
]]--