--[[
file:	Task_CCCT.lua
desc:	All task conditions check.
author:	chal
update:	2011-12-02

notes: 	1、任务通用条件检查表包含检查接受条件、完成条件、及获得任务状态（已接、未接、已完成）
		2、完成或接受任务需要删除道具的在道具条件里面配置
]]--
local pairs,tostring = pairs,tostring
local ipairs = ipairs
local mathabs = math.abs
local TableHasKeys,tableempty = table.has_keys,table.empty
local TaskList = TaskList
-- local completed_line = completed_line
local CI_GetPlayerData,CheckGoods,CI_GetCurPos = CI_GetPlayerData,CheckGoods,CI_GetCurPos
CommonConditionCheckTable = {

	----------------------------------------------- 检查任务条件----------------------------------
	
	CheckConditions = function ( conditions, taskData, taskid, dodel )
		if type( conditions ) == 'table' then 					-- conditions = {}
			local ck = nil
			for k,v in pairs( conditions ) do
				if CommonConditionCheckTable[k] ~= nil then	-- k is table's key.
					ck = CommonConditionCheckTable[k]( v, taskData, taskid, dodel)
				else
					ck = true			-- 前台判断的条件后台现在就不判断了 免得忘了加
				end
				if ck ~= true then
					return 0
				end
			end
			return 1
		else
			return 0
		end
		return 1
	end,
	
	-- check task had been completed.
	-- __check_completed = function( completed, taskid, ismuilt )
		-- if completed[taskid] then
			-- return true
		-- else			
			-- if completed_line[taskid] == nil then
				-- return false
			-- else
				-- for id in pairs(completed) do
					-- if completed_line[taskid][id] then
						-- return true
					-- end
				-- end
			-- end
		-- end
		-- return false
	-- end,
	__check_completed = function( taskData, taskid, ismuilt )
		local completed = taskData.completed or {}
		local current = taskData.current or {}
		if completed[taskid] then
			return true
		else			
			if completed_line[taskid] == nil then
				return false
			else
				for id in pairs(completed) do
					if type(id) == type(0) and completed_line[taskid][id] then
						return true
					end
				end
				for id in pairs(current) do
					if type(id) == type(0) and completed_line[taskid][id] then
						return true
					end
				end
			end
		end
		return false
	end,
	-- check task complete state.
	completed = function ( condition, taskData )
		if tableempty(condition) then
			return true
		end
		if taskData == nil then
			return false
		end
		for _, tids in pairs( condition ) do
			if type(0)==type(tids) then
				if not CommonConditionCheckTable.__check_completed( taskData, tids) then				
					return false
				end
			elseif type{} == type(tids) then		-- 多选一的情况（表里面任意任务ID完成）
				local ok = false
				for _, id in pairs(tids) do
					if CommonConditionCheckTable.__check_completed( taskData, id ) then
						ok = true
						break
					end
				end

				if not ok then				
					return false
				end
			end			
		end
		return true
	end,

	-- conditions: check task not complete.
	notCompleted = function ( condition, taskData, taskid )
		if tableempty(condition) then
			return true
		end
		if taskData == nil then
			return false
		end
		for _, tids in pairs( condition ) do
			if type(0)==type(tids) then
				if  CommonConditionCheckTable.__check_completed( taskData, tids) then				
					return false
				end
			else
				return false
			end			
		end
		return true
	end,
	
	-- condition: some tasks are current task.
	current = function ( condition, taskData, taskid )
		if tableempty(condition) then
			return true
		end
		
		if taskData == nil or taskData.current == nil then
			return false
		end
		local current = taskData.current
		if type( condition ) == type({}) then
			for _,v in pairs(condition) do 
				if type(0)==type(v) then
					if current[v] == nil then
						return false
					end
				else
					return false
				end
			end
			return true
		end
		return false
	end,
	
	-- condition: some tasks are not current task.
	nocurrent = function( condition, taskData, taskid)
		if tableempty(condition) then
			return true
		end
		if taskData == nil or taskData.current == nil then
			return false
		end
		local current = taskData.current
		for _, tid in pairs(condition) do
			if current[ tid ] then
				return false
			end
		end
		return true
	end,
	
	-- interface:could accept one task.
	CouldAccept = function(condition, taskData, taskid)		
		for _,TaskID in pairs(condition) do
			local TaskInfo = GetTaskConfig(TaskID)
			local ok = CommonConditionCheckTable.CheckConditions(TaskInfo.AcceptCondition, taskData, TaskID)
			if ok == 1 then
				return true
			end
		end
		
		return false			
	end,
	-- interface:could not accept one task.
	NCouldAccept = function(condition, taskData, taskid)		
		return not CommonConditionCheckTable.CouldAccept( condition, taskData, taskid)
	end,
	
	--condition: level
	level = function ( condition )
		----rfalse(condition[1]..','..condition[2])
		local lev = CI_GetPlayerData( 1 )
		if lev == nil or lev <= 0 then 
			return false
		end
		if type( condition ) == 'number' then
			return lev >= condition or false
		elseif type(condition ) == 'table' and condition[1] ~= nil then
			if condition[2] == nil then
				return lev >= condition[1] or false
			else
				return lev >= condition[1] and lev <= condition[2]
			end
		end
		return false
	end,
	
	--condition: vip level
	vip = function( condition )
		if type(condition) ~= type(0) then
			return false
		end
		local sid = CI_GetPlayerData( 17 )
		if sid == nil or sid <= 0 then 
			return false
		end
		local viplv = GI_GetVIPLevel(sid) or 0
		if viplv >= condition then
			return true
		end
		return false
	end,
	
	--condition: camp
	camp = function ( condition )
		local playerCamp = GetDBPlayerCampData(GetCurPlayerID())
		if type( condition ) == 'number' then
			return playerCamp.campID  == condition
		end
		if type(condition) == 'table' then
			for k,v in ipairs(condition) do
				if playerCamp.campID  == v then
					return true
				end
			end
		end
		return false
	end,
	
	--condition: faction
	faction = function ( condition )
		local bFaction = CI_GetPlayerData(23)
		if bFaction == nil or bFaction <= 0 then
			return false
		end
		return true
	end,
	
	--condition:friend
	friend = function( condition )		
		return true
	end,
	
	--condition:chongzhi
	cz = function( condition )
		if type( condition ) ~= 'number' then return false end
		local bHas = CI_GetPlayerData(27)
		if bHas >= condition then return true end
		return false
	end,
	
	--condition:hero 后台暂时不判断
	hero = function( condition )		
		return true
	end,
	
	--condition:mount 后台暂时不判断
	mount = function( condition )		
		return true
	end,
	
	--condition: school
	school = function ( condition )
		local zschool = CI_GetPlayerData( 2 )
		if type( condition ) == 'number' then
			return zschool == condition or false
		end
		if type(condition) == 'table' then
			for k,v in ipairs(condition) do
				if zschool == v then
					return true
				end
			end
		end
		return false
	end,

	--condition: items 是否删除配在condition里面
	items = function ( condition, taskData, taskid, dodel )
		if type( condition ) == 'table' then
			-- 检查任务道具
			for k,v in ipairs( condition ) do
				if CheckGoods( v[1], v[2], 1 ) == 0 then
					return false	
				end
			end
			
			-- 扣除任务道具
			if dodel == 1 then
				for k,v in ipairs( condition ) do
					-- local num = GetItemNum(v[1],1)
					if CheckGoods( v[1], v[2], 0 ) == 0 then
						return false
					end
				end
			end
			return true
		end
		return false
	end,
	--condition: one of items.
	OneOfItems = function(condition, taskData, taskid, dodel)
		if type(condition) == type({}) then
			for k,v in pairs(condition) do
				if CheckGoods(v[1], v[2], 1) == 1 then
					if v[3] == 0 then						-- 扣除任务道具
						if CheckGoods( v[1], v[2], v[3] ) == 0 then
							return false	
						end
					end
					return true
				end
			end
			return false
		end
		return false
	end,
	
	--condition: kill monsters.
	kill = function ( condition, taskData, taskid )
		if taskData == nil or taskData.current == nil or 
			taskData.current[taskid] == nil or taskData.current[taskid].kill == nil then
			return false
		end
		local kill = taskData.current[taskid].kill
		if type(condition[1])==type({}) then
			for k,v in pairs( condition ) do
				local num = kill[ v[1] ]
				
				if num == nil then
					return false
				end
				
				if num < v[2] then
					return false
				end
			end
		else
			local mon_name = condition[1]
			if condition[1] == 0 then
				mon_name = CI_GetPlayerData(5)
			end
			local num = kill[ mon_name ]
			
			if num == nil then
				return false
			end

			if num < condition[2] then
				return false
			end
		end
		return true
	end,

	--condition: player's distance with pos given.
	area = function( condition, taskData,taskid )
		if taskData == nil or taskData.current == nil or taskData.current[taskid]==nil then
			return false
		end

		if(taskData.current[taskid]["area"] ~= nil) then
			return true
		end

		local mainid, subid= GetSubID(taskid)
		local area = TaskList[mainid][subid].CompleteCondition.area
		local regionid
		local x
		local y

		x,y,regionid = CI_GetCurPos()
		local radius = area[4]
		local distance = mathabs(area[2]-x)+mathabs(area[3]-y)

		if( distance <= radius ) then
			taskData.current[taskid]["area"] = 1
			return true
		else
			return false
		end
			
	end,
	--condition: player operation
	op = function(condition,taskData,taskid,opkey)
		if(taskData.current == nil or taskData.current[taskid] == nil) then
			return false
		end

		local taskConf = GetTaskConfig(taskid)
		if taskConf == nil then
			return false
		end

		for k,_ in pairs(taskConf.CompleteCondition[opkey]) do
			if not TableHasKeys( taskData,{"current",taskid,opkey, k}) then
				return false 
			end
		end
		return true
	end,

	-- click UI
	click = function( condition,taskData,taskid )
		return CommonConditionCheckTable.op(condition,taskData,taskid,"click")
	end,

	--condition: money.
	money = function( condition,taskData,taskid )
		return true
	end,
	--condition: click npc.
	npc = function( condition, taskdata, taskid )
		if not TableHasKeys( taskdata, {"current", taskid, "npc"} ) then
			return false
		end
		
		local npcs = taskdata.current[taskid].npc
		if type(condition)==type({}) then
			for _,id in pairs(condition) do
				if npcs[id] == nil then
					return false
				end
			end			
			return true
		else
			return npcs[id] ~= nil
		end
	end,
	
	--Collection 非实物收集
	col = function ( conditions, taskdata, taskid)
		return CommonConditionCheckTable.op(condition,taskdata,taskid,"col")
	end,
	
	-- 每日获得威望
	eGetWW = function(conditions, taskdata, taskid)
		--look('eGetWW',1)
		--look(conditions,1)
		if type(conditions) ~= type(0) then
			return false
		end
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <= 0 then
			return false
		end
		local info = GetTimesInfo(sid,TimesTypeTb.span_pres)
		if type(info) ~= type({}) then
			return false
		end
		--look(info,1)
		local cgWW = info[1] or 0
		if cgWW < conditions then
			return false
		end
		return true
	end,
}