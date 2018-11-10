--[[
file:	Task_Init.lua
desc:	task data init.
author:	chal
update:	2011-12-01
]]--

----------------------------------------------------------
--include:
local define		= require('Script.cext.define')
local TaskTypeTb = define.TaskTypeTb
local TaskList = TaskList
local __G = _G
----------------------------------------------------------
--inner function:

--:first task set mannual.
local globalTaskRevId = {
}

--task id.
local TASK_ID_GAP = 1000		-- 这个值不能变 现在任务ID和副本ID都是 mainID * TASK_ID_GAP + subID

local TASK_ID_MAIN = 1000		-- 主线任务
local TASK_ID_SUB = 3000		-- 支线任务
local TASK_ID_DAY = 4000		-- 日常任务
local TASK_ID_RING = 5000		-- 悬赏任务
local TASK_ID_ACT = 6000		-- 活动任务
local TASK_ID_CIC = 7000		-- 跑环任务
local DYN_NPC_ID = 400000

-- 更新任务链接表
local function updateLinkTable( lst, tab, sop )
	for k,v in pairs(lst) do
		local str = nil
		if sop then 
			str = "entry:"..getTaskName(v)
		end
		local i = v
		
		while tab.unlink[i] ~= nil do
			if sop then 
				local tmp = "->" .. getTaskName(tab.unlink[i])
				if #str + #tmp > 78 then
					sop('78='..str)
					str=""
				end
				str = str..tmp
			end
			if type( tab.unlink[i] ) == "number" then
				tab.linked[i] = tab.unlink[i]
				tab.unlink[i] = nil
				i = tab.linked[i]
			else
				if sop then
					sop('table ='..str)
					str = nil
				end		
				updateLinkTable( tab.unlink[i], tab, sop )
				tab.linked[i] = tab.unlink[i]
				tab.unlink[i] = nil
				break
			end
		end
		if sop and str then
			sop('ssss='..str)
		end
	end
end

-- 生成子任务线
local function buildSubCache( compline, tab, taskid, nextid )
	local iter = nextid or taskid
	local last = nil
	if type( compline[taskid] ) == "nil" then
		compline[taskid] = {}
	elseif type( compline[taskid] ) ~= "table" then
		error( "buildSubCache error" )
	end
	while iter do
		if type( iter ) == "number" then
			compline[taskid][iter] = true
			last = iter
			iter = tab.linked[iter]
		else
			for k,v in pairs( iter ) do
				buildSubCache( compline, tab, taskid, v )
			end
			break
		end
	end
	if last and compline[last] == nil then
		compline[last] = { [last] = true }
	end
end

-- 生成任务线
local function buildCacheMap( compline, lst, tab )
	-- 为每一个节点生成数据表，外层循环
	for k,v in pairs( lst ) do
		buildSubCache( compline, tab, v )
	end
	for n,m in pairs( tab.linked ) do
		buildSubCache( compline, tab, n )
	end
end

local function getTaskName( taskid )
	if type( taskid ) == "number" then
		local main, sub = GetSubID( taskid )
		return taskid..TaskList[main][sub].TaskName
	else
		local str = "<<"
		for k,v in pairs( taskid ) do
			str = str .. getTaskName( v )
		end
		return str .. ">>"
	end
end
-----------------------------------------------------------------
--interface:

--:global task link line.
completed_line = {}

-- 获取任务ID
function GetTaskId(mainid, subid)
	return mainid* TASK_ID_GAP + subid
end

-- 获取主ID、子ID(副本和任务通用)
function GetSubID(taskid)
	if taskid == nil then
		Log('GetSubID.txt',debug.traceback())
		return
	end
	local mainid = rint( taskid / TASK_ID_GAP )
	local subid = rint( taskid%TASK_ID_GAP )

	return mainid,subid
end

-- 获取任务类型(1、主线任务 2、支线任务 3、日常任务 4、悬赏任务)
function GetTaskType(taskid)
	if taskid >= TASK_ID_MAIN and taskid < TASK_ID_SUB then
		return TaskTypeTb.TS_Main
	elseif taskid >= TASK_ID_SUB and taskid < TASK_ID_DAY then
		return TaskTypeTb.TS_SUB
	elseif taskid >= TASK_ID_DAY and taskid < TASK_ID_RING then
		return TaskTypeTb.TS_DAY
	elseif taskid >= TASK_ID_RING and taskid < TASK_ID_ACT then
		return TaskTypeTb.TS_Ring
	elseif taskid >= TASK_ID_ACT and taskid < TASK_ID_CIC then
		return TaskTypeTb.TS_ACT
	elseif taskid >= TASK_ID_CIC then
		return TaskTypeTb.TS_CIC
	end	
end

-- >>create task link line start.
-- 1、不支持多项满足分支 
-- 2、直接判断completed如果等于一个表就说明配置错误 可以省掉 unlink 到 linked 的转换 但是必须先判断completed 不能等于任务ID
-- 3、只是在服务器启动和脚本刷新的时候调用 对性能影响不大 而且目前使用比较稳定 不考虑优化
function taskid_check( sop )
	local tab = { entry={}, linked={}, unlink={} }
	local count = 0
	local len = 0
	local lst = {}
	local compline = {}

	if nil==TaskList then
		error("TaskList 不存在")
	end

	for mainid,t in pairs(TaskList) do
		for subid,conf in pairs(t) do
			if type(subid) == 'number' then
				local taskid = GetTaskId(mainid, subid)
				if conf.SubmitTimes~=nil then
					if conf.SubmitTimes ~= -1 then
						error("目前暂时不支持限定指定次数的的任务配置")
					else
						if sop then
							sop( "无限重复任务！ "..tostring(taskid).." "..conf.TaskName )
						end
					end
				elseif conf.AcceptCondition==nil or conf.AcceptCondition.completed==nil or globalTaskRevId[taskid] then
					if sop then
						sop( "独立任务线，需永久占用存储位！ "..tostring(taskid).." "..conf.TaskName )
					end
					if tab.entry[taskid] ~= nil then
						error( "任务ID重复配置A " .. conf.TaskName )
					end
					tab.entry[taskid]=conf
					count = count + 1
				else
					count = count + 1
					if conf.AcceptCondition.completed[2]~=nil then
						error("目前暂时不接受多选分支任务id配置")
					end
					if type(conf.AcceptCondition.completed[1])=="table" then
						for k,v in ipairs(conf.AcceptCondition.completed[1]) do
							if type(v)~="number" then
								error("错误的多项满足分支配置")
							end
							if tab.unlink[v] ~= nil then
								error( "任务ID重复配置B " .. conf.TaskName.."  id= "..taskid )
							end
							tab.unlink[v] = taskid
						end
					elseif type(conf.AcceptCondition.completed[1])=="number" then
						if tab.unlink[conf.AcceptCondition.completed[1]] ~= nil then
							--error( "任务ID重复配置B " .. conf.TaskName )
							local subt = tab.unlink[conf.AcceptCondition.completed[1]]
							if sop then
								sop( "注意，存在分支任务配置！ " .. tostring(subt) .. "<->" .. taskid .. " ".. conf.TaskName )
							end
							if type( subt ) == "number" then
								tab.unlink[conf.AcceptCondition.completed[1]] = { subt }
								subt = tab.unlink[conf.AcceptCondition.completed[1]]
							end
							local isSame = false
							for k,v in pairs( subt ) do
								if v == taskid then
									isSame = true
									error( "发现重复的的分支选项" )
									break
								end
							end
							if not isSame then
								subt[1+#subt] = taskid
							end
						else
							tab.unlink[conf.AcceptCondition.completed[1]] = taskid
						end
					else
						error("任务接受条件配置错误！")
					end
				end
			end
		end
	end

	for k,v in pairs(tab.entry) do
		lst[#lst+1]=k
	end

	for i1=1,#lst do
		for i2=i1+1,#lst do
			if tonumber(lst[i2])<tonumber(lst[i1]) then
				local tmp = lst[i2]
				lst[i2]=lst[i1]
				lst[i1]=tmp
			end
		end
	end
	
	
	-- 用于去掉配置错误的任务（tab.unlink - tab.linked）
	updateLinkTable( lst, tab, sop )

	-- 生成任务线 
	buildCacheMap( compline, lst, tab )

	for k,v in pairs( compline ) do
		len = len + 1
	end

	if count ~= len then
		-- error( "不匹配的节点数量 "..count.." "..len )
	end
	
	completed_line = compline
end

-- 玩家登陆或完成任务数据变更时做压缩
function compzip( taskData )	
	local lst = {}
	-- 压缩已完成任务
	local completed = taskData.completed
	if type(completed) == type({}) then
		for k in pairs( completed ) do
			if type(k) == "number" then
				lst[k] = 1
			end
		end
		local str="completed删除["
		for k,v in pairs( completed ) do
			if type(k) == "number" then
				if completed_line[k] == nil then
					str = str..k..","
					lst[k] = nil
				else
					local finded = nil
					for i in pairs( lst ) do
						if i ~= k and completed_line[k][i] then
							finded = i
							break
						end
					end
					if finded then
						str = str..k..","
						lst[k] = nil
					end
				end
			end
		end
		str = str.."]剩余["
		for i in pairs( lst ) do
			str = str..i..","
		end
		--look( str )
		taskData.completed = lst
	end
	
	-- 压缩当前任务	
	lst = {}	
	local current = taskData.current
	local del = {}
	if type(current) == type({}) then	
		for k in pairs( current ) do
			if type(k) == "number" then
				lst[k] = 1
			end
		end
		str="current删除["
		for k,v in pairs( current ) do
			if type(k) == "number" then
				if completed_line[k] == nil then
					str = str..k..","
					lst[k] = nil
				else
					local finded = nil
					for i in pairs( lst ) do
						if i ~= k and completed_line[k][i] then
							finded = i
							break
						end
					end
					if finded then
						str = str..k..","
						lst[k] = nil
						del[k] = 1
					end
				end
			end
		end
		str = str.."]剩余["
		for i in pairs( lst ) do
			str = str..i..","			
		end
		--look( str )
		for i in pairs(del) do
			if taskData.current[i] then
				taskData.current[i] = nil
			end
		end
	end
	
	-- 删除current中与completed重复的任务
	for k, v in pairs(taskData.current) do
		if type(k) == "number" then
			if type(taskData.completed) == type({}) then
				if taskData.completed[k] then	-- 说明在完成里面已经有了
					taskData.current[k] = nil
				end
			end
		end
	end
end
--360平台标示
local function Is360plat(NpcCreate)
	local plat=__G.__plat
	if NpcCreate.plat then
		if(plat == NpcCreate.plat) then
			return true
		else
			return false
		end
	end
	return true
end
-- >>create task link line over.
-- create all npc.
-- 服务器启动或sreset时创建静态NPC(npcid < DYN_NPC_ID)
-- 静态NPC尽量不要配置controlID和clickScript
function InitTaskNpc()
	if  IsSpanServer() then--跨服不创建npc
		return
	end
	if RemoveObjectIndirect == nil then
		return
	end
	for k,v in pairs( npclist ) do
		if k<DYN_NPC_ID and v.NpcCreate.regionId>0 and Is360plat(v.NpcCreate) then
			v.NpcCreate.controlId = v.NpcCreate.controlId or 100000 + k
			v.NpcCreate.clickScript = v.NpcCreate.clickScript or 30000
			local a=RemoveObjectIndirect( v.NpcCreate.regionId, v.NpcCreate.controlId )
			-- if a==nil then 
			-- 	-- look(v.NpcCreate.regionId,1)
			-- 	-- look(v.NpcCreate.controlId,1)
			-- end
			CreateObjectIndirect( v.NpcCreate )
		end
	end
end



--任务回档模板配置
local task_del_resolve_conf={
	[55]={
		completed= {
       [3120] = 1,
       [3001] = 1,
       [3114] = 1,
       [3017] = 1,
       [3040] = 1,
       [3030] = 1,
       [3005] = 1,
       [3125] = 1,
       [3103] = 1,
       [3009] = 1,
       [2054] = 1,
       [3007] = 1,
       [3045] = 1,
     },
 	current = {
       [7001] = {
             kill = {
                   G_267 = 0
                 },
           },
       [6002] = {
             kill = {
                   M_122 = 0
                 },
           },
       [4016] = {
             kill = {
                   GJ_353 = 0
                 },
           },
       [4900] = {
           },
       [4116] = {
             kill = {
                   G_262 = 0
                 },
           },
       [2055] = {
             kill = {
                   M_112 = 0
                 },
           },
        },
	},
	[60]= {
    	completed = {
         [3045] = 1,
         [3031] = 1,
         [3009] = 1,
         [3017] = 1,
         [3040] = 1,
         [3001] = 1,
         [2067] = 1,
         [3035] = 1,
         [3103] = 1,
         [3005] = 1,
         [3114] = 1,
         [3007] = 1,
         [3042] = 1,
       },
  	 current = {
         [7001] = {
             },
         [4900] = {
             },
         [4021] = {
               kill = {
                     GJ_354 = 0
                   },
             },
         [2068] = {
             },
       },
       },
      [65]= {
    completed = {
          [3045] = 1,
          [3001] = 1,
          [3009] = 1,
          [3122] = 1,
          [3116] = 1,
          [3017] = 1,
          [3005] = 1,
          [3103] = 1,
          [3030] = 1,
          [1467] = 1,
          [3007] = 1,
          [3114] = 1,
        },
    current= {
          [3040] = {
              },
          [3123] = {
                kill = {
                      M_041 = 3,
                    },
              },
          [2074] = {
              },
          [3117] = {
                kill = {
                      M_039 = 0,
                    },
              },
          [4900] = {
              },
          [4121] = {
                kill = {
                      G_266 = 0,
                    },
              },
          [4026] = {
                kill = {
                      GJ_355 = 0,
                    },
              },
          [7001] = {
                kill = {
                      M_076 = 0,
                    },
              },
        },
       },

     [70]={
    	completed = {
         [3045] = 1,
         [3031] = 1,
         [3009] = 1,
         [3017] = 1,
         [3040] = 1,
         [3114] = 1,
         [3001] = 1,
         [3042] = 1,
         [3035] = 1,
         [3103] = 1,
         [1469] = 1,
         [3005] = 1,
         [3007] = 1,
         [3030] = 1,
       },
  	 current = {
         [7001] = {
             },
         [4031] = {
               kill = {
                     GJ_356 = 0
                   },
             },
         [4900] = {
             },
         [1470] = {
             },
       },
     },
    [75]={
    completed = {
          [3017] = 1,
          [4950] = 1,
          [3114] = 1,
          [3120] = 1,
          [3103] = 1,
          [4254] = 1,
          [3045] = 1,
          [3030] = 1,
          [3125] = 1,
          [1533] = 1,
          [3005] = 1,
          [3007] = 1,
          [3040] = 1,
          [3001] = 1,
          [4038] = 1,
          [3009] = 1,
        },
    current = {
          [1534] = {
              },
        },
     },
	[80]={--81
		completed = {
          [3017] = 1,
          [3114] = 1,
          [3120] = 1,
          [3031] = 1,
          [3035] = 1,
          [3103] = 1,
          [3045] = 1,
          [1555] = 1,
          [3030] = 1,
          [3125] = 1,
          [3005] = 1,
          [3007] = 1,
          [3009] = 1,
          [3042] = 1,
          [3040] = 1,
          [3001] = 1,
        },
    current = {
          [7001] = {
                kill = {
                      M_132 = 0
                    },
              },
          [4121] = {
                kill = {
                      G_266 = 0
                    },
              },
          [4900] = {
              },
          [1556] = {
              },
          [6038] = {
              },
          [4041] = {
                kill = {
                      GJ_358 = 0
                    },
              },
          [6039] = {
              },
        },
    },
    [85]={
    	completed = {
         [3045] = 1,
         [3031] = 1,
         [3009] = 1,
         [3017] = 1,
         [3040] = 1,
         [3114] = 1,
         [3030] = 1,
         [1577] = 1,
         [3042] = 1,
         [3035] = 1,
         [4048] = 1,
         [3005] = 1,
         [3103] = 1,
         [3007] = 1,
         [3001] = 1,
       },
   current = {
         [4950] = {
             },
         [4121] = {
               kill = {
                     G_266 = 0
                   },
             },
         [4900] = {
             },
         [1578] = {
             },
         [6048] = {
             },
       },
    },
}
--运维使用:用于玩家完成任务数据被删除情况,做几个模板,入60级,70,80
--lv=任务等级,回档任务时需要玩家在线
function task_del_resolve( playerid,lv )
	if task_del_resolve_conf[lv]==nil then
		look("task_del_resolve_conf====nil",1)
		return
	end
	local taskData = GetDBTaskData(playerid)


	-- look(taskData)
	if taskData==nil then 
		look("taskData1====nil",1)
		return
	end
	taskData.completed=task_del_resolve_conf[lv].completed
	taskData.current=task_del_resolve_conf[lv].current

	look("task_del_resolve====succeed")

end















-- make npc and task's relations. 用于同步前台(任务跟NPC的关联现在是前台做，所以这个不需要执行了、逻辑保留)
--[[
local function InitTaskNpcRelations()
	local taskCount = 0
	for k,v in ipairs( TaskList ) do 
		for sk,sv in pairs( v ) do 
			taskCount = taskCount+1
			if( type(sk) == "number" and type(sv) == "table" )then
				if sv.AcceptNPC ~= 0 then
					npc = npclist[sv.AcceptNPC]
					if( npc ~= nil )then
						local tabName, taskKey
						tabName = 'taskRelation'
						taskKey = k * TASK_ID_GAP + sk

						if npc[tabName] == nil then
							npc[tabName] = {}
						end

						npc[tabName][ taskKey ] = 1
					else
						--rfalse( "No AcceptNPC: taskid="..k.." npcid="..tostring(sv.npcid).." subid="..sk )
					end
				end
				if sv.SubmitNPC ~= nil then
					npc = npclist[sv.SubmitNPC]
					if( npc ~= nil )then
						local tabName, taskKey
						tabName = 'taskRelation'
						taskKey = k * TASK_ID_GAP + sk

						if npc[tabName] == nil then
							npc[tabName] = {}
						end

						npc[tabName][ taskKey ] = 1
					else
						--rfalse( "No SubmitNPC:taskid="..k.." npcid="..tostring(sv.npcid).." subid="..sk )
					end
				end
			end
		end
	end
	--rfalse("Task Numbers="..taskCount)
end
]]--