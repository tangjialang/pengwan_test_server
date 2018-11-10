--[[
file:	tasksystem.lua
desc:	Task Systems
author:	chal
update:	2011-11-28
notes:
[1] All interfaces here will use "TS_" tags.
���ӹ�����Ӫ���׽���  ����ȼ�����ӳ� liyi 2011-12-13
]]--

--------------------[[inner function]]--------------------
--:
local pairs,type = pairs,type
local ipairs,tostring = ipairs,tostring
local TP_FUNC = type( function() end)
local define = require('Script.cext.define')
local TaskTypeTb = define.TaskTypeTb
local TaskList 	= TaskList
local look = look
local uv_TimesTypeTb = TimesTypeTb
local uv_CommonAwardTable = CommonAwardTable
local call_accept_task,call_submit_task = call_accept_task,call_submit_task
local CommonConditionCheckTable = CommonConditionCheckTable
local uv_RingTaskConfig = RingTaskConfig
local TableHasKeys = table.has_keys
local uv_RingTaskLib = RingTaskLib
local Task_Info = msgh_s2c_def[1][3] 
local Task_Proc	= msgh_s2c_def[1][5]
local GetTaskType,SendLuaMsg = GetTaskType,SendLuaMsg
local GiveGoods = GiveGoods
local TipCenter,GetStringMsg = TipCenter,GetStringMsg
---------------------------------------------------------------
--inner function:

local function GetPrevTask( taskid, taskconf )
	local comp = taskconf.AcceptCondition.completed
	if nil==comp or nil==comp[1] then
		return
	end
	return comp
end
-- :
local function task_clear_prev_completed( taskid, config, taskdata)
	local prev = GetPrevTask( taskid, config )
	if prev then
		if type( prev) then
			for _, tid in pairs(prev) do
				if type({}) == type(tid) then
					for _, one_taskid in pairs(tid) do
						taskdata.completed[one_taskid] = nil
					end					
				else
					taskdata.completed[tid] = nil
				end
			end
		end
	end
end

--------------------[[Interface]]--------------------

--ĳ����Ƿ��Ѿ�����������
function HasTask(playerid,taskid)
	local taskData = GetDBTaskData(playerid)
	return TableHasKeys(taskData, {"current", taskid})
end

--��ǰ����Ƿ��Ѿ�����������
function CurPlayerHasTask(taskid)
	return HasTask(GetCurPlayerID(),taskid)
end

--:Get task config.
function GetTaskConfig( taskid )
	if type(taskid) ~= type(0) then
		--rfalse('taskid is not number')
		return
	end

	local mainid,subid = GetSubID(taskid)
	if TableHasKeys( TaskList, { mainid, subid} ) then
		--look('TableHasKeys')
		return TaskList[mainid][subid]
	end
end

-- send task info if client asks.
function SendTaskInfo( playerid , taskid )
	if playerid == nil or taskid == nil then
		return
	end
	local taskData = GetDBTaskData( playerid )
	local taskInfo = GetTaskConfig( taskid )
	if ( taskInfo ~= nil ) then
		SendLuaMsg( 0, { ids = Task_Info , id = taskid , task=taskInfo }, 9 )
	end
end

-- accept a task
function TS_AcceptTask( playerid, taskid, npcid, nSelect)
	--look('TS_AcceptTask,taskid='..tostring(taskid))
	local taskData = GetDBTaskData( playerid )
	local taskInfo = GetTaskConfig( taskid )  --also get ring task here
	if taskData == nil or taskInfo == nil then
		look( "taskData == nil or taskInfo == nil��" )
		return false
	end
	-- ��������жϷ�ֹ����һЩ���벻���������(�������Ҫ���ϸ��ȽϺ�)	
	if taskInfo.AcceptNPC ~= npcid then
		--look('logic error: AcceptNPC='..tostring(taskInfo.AcceptNPC)..',npcid='..tostring(npcid))
		return false
	end
	-- �ж��Ƿ��ѽ�
	if taskData.current[taskid] ~= nil then
		--look('task has accept!')
		return false
	end
	-- �ж��Ƿ��Ѿ���ɹ�
	if CommonConditionCheckTable.completed( {taskid}, taskData ) then
		-- look('task has completed!')
		return false
	end
	-- ����������
	local failInfo = nil
	local actionIndex = nil
	local fkey = nil
	if taskInfo.AcceptCondition then
		actionIndex = CommonConditionCheckTable.CheckConditions( taskInfo.AcceptCondition, taskData, taskid )
		if actionIndex ~= 1 then
			--look('task do not reach AcceptCondition! failInfo = ' .. tostring(failInfo))
			return false
		end
	end
	-- ��ȡ��������
	local ringCache = nil
	local cctData = nil
	local taskType = GetTaskType(taskid)
	if taskType == TaskTypeTb.TS_Ring then
		if nSelect == nil then
			return false
		end
		ringCache = GetRingTaskCache(playerid)
		if ringCache[nSelect][1] ~= 0 then
			return false
		end
		-- ���ʣ����� 
		if not CheckTimes(playerid,uv_TimesTypeTb.TS_Ring,1,-1,1) then
			-- look("ring count over")
			return false
		end		
	elseif taskType == TaskTypeTb.TS_CIC then
		-- look('TaskTypeTb.TS_CIC')
		cctData = GetCircleTaskData(playerid)
		if cctData == nil then
			return false
		end
		if (cctData.num or 0) >= MAXCIRCLE then		-- ��黷��
			-- look("circle count over")
			return false
		end
		-- �����ܻ�����
		local ret = CCT_RandSystem(playerid)
		if ret == nil then
			-- look("CCT_RandSystem error")
			return false
		end
	end
	-- ��������Ʒ
	if taskInfo.TaskItemGiven then
		local pakagenum = isFullNum()
		if pakagenum > 0  then				
			GiveGoods(taskInfo.TaskItemGiven,1,1,"�����������Ʒ")
		else
			TipCenter(GetStringMsg(14,1))
			return false
		end
	end

	-- ���÷��������������¼�
	if taskInfo.ServerAcceptEvent ~= nil then
		local func = call_accept_task[taskid]
		if type(func) == TP_FUNC then
			func(taskid,taskData)
		end
	end
	--����������������
	if  taskInfo.AcceptOtherTask ~= nil and type({}) == type(taskInfo.AcceptOtherTask) then
		for k,tid in pairs(taskInfo.AcceptOtherTask) do
			-- local ret = true
			-- local tt = GetTaskType(tid)
			-- if tt == TaskTypeTb.TS_CIC then
				-- look('TaskTypeTb.TS_CIC')
				-- cctData = GetCircleTaskData(playerid)
				-- if cctData and ((cctData.num or 0) < 200) then
					-- ret = CCT_RandSystem(playerid)
				-- else
					-- ret = false
				-- end				
			-- end
			-- if ret then
				-- taskData.current[tid] = {}
				-- MarkKillInfo( taskData, tid )			
			-- end
			if type(tid) == type(0) then
				local tk = GetTaskConfig( tid )
				if type(tk) == type({}) then
					TS_AcceptTask( playerid, tid, tk.AcceptNPC)
				end
			end
		end
	end
	taskData.current[taskid] = {}	
	-- �����������
	if taskType == TaskTypeTb.TS_Ring then
		ringCache[nSelect][1] = 1
		taskData.current[taskid].rich = ringCache[nSelect]
	end
	-- kill monster info.
	MarkKillInfo( taskData, taskid )

	SendLuaMsg( 0, { ids = Task_Proc, step = 1, tid = taskid, nSelect = nSelect, cic = cctData }, 9 )

	-- ���;���ID
	local storyid = taskInfo.AcceptStoryID
	if type(storyid) == type(0) then			
		SendStoryData(storyid, npcid)
	elseif type(storyid) == type({}) then	-- ����ְҵ
		local school = CI_GetPlayerData(2,2,playerid)
		SendStoryData(storyid[school], npcid)
	end
	-- look(taskData.current)
	-- ��������˵�һ������ ���ó�ʼ��״̬
	if taskid == 1001 then
		taskData.binit = 2
	end
	return false
end
-- submit a task
function TS_SubmitTask( playerid, taskid, npcid, subDirect )
	-- look('TS_SubmitTask,taskid='..tostring(taskid))
	local taskData = GetDBTaskData( playerid )
	local taskInfo = GetTaskConfig(taskid)
	if( taskInfo == nil or taskData.current[taskid] == nil ) then
		look( "check err 0��" )
		return
	end
	if ( taskInfo.CompleteCondition == nil ) then
		look( "check err 1��" )
		return
	end
	if taskInfo.SubmitNPC and npcid and taskInfo.SubmitNPC ~= npcid then
		look( "check err 2��" )
		return
	end
	
	local ringCache = nil
	local nSelect = nil
	local taskColor = nil
	local CompleteCondition = taskInfo.CompleteCondition
	local CompleteAwards = taskInfo.CompleteAwards
	local taskType = GetTaskType(taskid)
	-- �����������⴦��
	if taskType == TaskTypeTb.TS_Ring then
		nSelect = RT_GetCurTask(playerid)
		if nSelect == nil then
			return
		end
		ringCache = GetRingTaskCache(playerid)
		local idx = ringCache[nSelect][2]
		local tp = uv_RingTaskConfig[idx].TaskTemplate
		local com = ringCache[nSelect][3]
		taskColor = ringCache[nSelect][4]
		if taskColor == 1 then
			taskColor = 1
		elseif taskColor == 2 then
			taskColor = 1.5
		elseif taskColor == 3 then
			taskColor = 2
		elseif taskColor == 4 then
			taskColor = 4
		elseif taskColor == 5 then
			taskColor = 6
		end
		CompleteCondition = uv_RingTaskLib[tp][com]
		CompleteAwards = uv_RingTaskConfig[idx].CompleteAwards
	elseif taskType == TaskTypeTb.TS_CIC then
		CompleteCondition = CCT_BuildComplete(playerid)
		CompleteAwards = CCT_BuildAwards(playerid)
	end
	if CompleteCondition == nil or CompleteAwards == nil then
		look('TS_SubmitTask check error 3')		
	end
	-- ��������������
	local failInfo = nil
	local actionIndex = nil
	local bDirect = false
	-- ������� ֻҪ����QuickClear �����Կ������
	if subDirect and taskInfo.QuickClear then
		local isby = baoyue_getpower(playerid,1)
		if not isby then
			local cost = taskInfo.QuickClear
			if not CheckCost(playerid,cost,0,1,'100022_�ճ��������') then
				TipCenter( GetStringMsg(144))
				return
			end
		else
			if taskType ~= TaskTypeTb.TS_Ring then
				local cost = taskInfo.QuickClear
				if not CheckCost(playerid,cost,0,1,'100022_�ճ��������') then
					TipCenter( GetStringMsg(144))
					return
				end
			end
		end
		bDirect = true
		actionIndex = 1
	else			
		actionIndex = CommonConditionCheckTable.CheckConditions( CompleteCondition, taskData, taskid )
	end
					
	if actionIndex == nil or actionIndex ~= 1 then
		look( "completeConditon check fail��actionIndex = " .. tostring(actionIndex ) .. ", failInfo = " .. tostring(failInfo),1)
		return
	else
		-- ����������ɽ�����
		local AwardTb = uv_CommonAwardTable.AwardProc(playerid,CompleteAwards,nil,taskColor)
		--check awards ��鱳��
		local getok = award_check_items(AwardTb) 		
		if not getok then
			return
		end		

		-- �۳��������
		if not bDirect then
			CommonConditionCheckTable.CheckConditions( CompleteCondition, taskData, taskid,1 )
		end
	
		--reset current task.
		taskData.current[taskid] = nil
		--do ServerCompleteEvent of taskInfo
		if taskInfo.ServerCompleteEvent ~= nil then
			local func = call_submit_task[taskid]
			if type(func) == TP_FUNC then
				func(taskid,taskData)
			end
		end

		-- give award
		local _,retCode = GI_GiveAward( playerid,AwardTb, '������' )
		
		if taskType == TaskTypeTb.TS_Ring then		-- ��������
			CheckTimes(playerid,uv_TimesTypeTb.TS_Ring,1,-1)
			ringCache[nSelect][1] = 2		
		elseif taskType == TaskTypeTb.TS_CIC then	-- �ܻ�����
			local cctData = GetCircleTaskData(playerid)
			cctData.num = (cctData.num or 0) + 1
		else
			taskData.completed = taskData.completed or {}			
			-- set completed
			-- ���������������״̬			
			taskData.completed[taskid] = 1	
			-- clear prev
			task_clear_prev_completed(taskid,taskInfo,taskData)
			-- look(taskData.completed)
		end		
		
		-- if taskType == TaskTypeTb.TS_DAY then	-- �ճ�����
			-- if taskInfo.LinkEnd then
				-- taskData.completed[taskid] = nil
			-- end
		-- end

		--send task submit msg.
		SendLuaMsg( 0, { ids = Task_Proc, step = 2, tid = taskid, nSelect = nSelect }, 9 )

		-- --send story if has
		local storyid = taskInfo.SubmitStoryID
		if type(storyid) == type(0) then			
			SendStoryData(storyid, npcid)
		elseif type(storyid) == type({}) then	-- ����ְҵ
			local school = CI_GetPlayerData(2,2,playerid)
			SendStoryData(storyid[school], npcid)
		end
		
		-- �ճ�������ܻ������̨�Զ�����һ������
		if taskType == TaskTypeTb.TS_DAY then			
			if type(taskInfo.task) == type({}) then
				local newtid = taskInfo.task[1] * 1000 + taskInfo.task[2]
				local newinfo = GetTaskConfig(newtid)
				if newinfo then
					TS_AcceptTask(playerid,newtid,newinfo.AcceptNPC)
				end
			end
		elseif taskType == TaskTypeTb.TS_CIC then
			TS_AcceptTask(playerid,taskid,taskInfo.AcceptNPC)
		end
		
		return true
	end
end
-- Drop a task
function TS_DropTask( playerid, taskid )
	-- look("TS_DropTask:" .. taskid)
	local taskData = GetDBTaskData( playerid )
	local taskConf = GetTaskConfig(taskid)
	if nil==taskConf or taskConf.NoDrop then
		-- look( "task ID="..tostring(taskid).."cannot drop!" )
		return false
	end

	if taskid and TableHasKeys(taskData, {"current", taskid} ) then
		taskData.current[taskid] = nil
		-- look("TS_DropTask 1")
		local taskType = GetTaskType(taskid)
		if taskType == TaskTypeTb.TS_Ring then
			local nSelect = RT_GetCurTask(playerid)
			if nSelect == nil then
				look("TS_DropTask 11")
				return false
			end
			local ringCache = GetRingTaskCache(playerid)
			ringCache[nSelect][1] = 0
			SendLuaMsg( 0, { ids = Task_Proc, step = 0, tid = taskid, nSelect = nSelect }, 9 )
		end

		return true
	end
	--rfalse( "Task ID="..tostring(taskid).."drop fail��" );
end

-- system sets player's task fail (not use)
local function TS_TaskFail(PlayerID,taskid)
	local taskdata =  GetDBTaskData( PlayerID )
	local task = table.has_keys( taskdata , {"current", taskid} )
	if task then
		task.failed = 1
	end
end