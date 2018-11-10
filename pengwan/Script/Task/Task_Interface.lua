--[[
file:	Task_Interface.lua
desc:	Task interface for server with script.
author:	chal
update:	2011-12-01
]]--
local type ,pairs,ipairs= type,pairs,ipairs
local tostring = tostring
local define		= require('Script.cext.define')
local TaskTypeTb = define.TaskTypeTb
local look = look
local CI_GetCurPos = CI_GetCurPos
local CI_GetPlayerData,MarkTaskKillMonster = CI_GetPlayerData,MarkTaskKillMonster
local GetTaskType = GetTaskType
local RT_GetConditionConf,GetDBTaskData = RT_GetConditionConf,GetDBTaskData




--: get server open time
function GetServerOpenTime()
	local world_data = GetWorldCustomDB()
	if world_data == nil then
		return 0
	end
	return world_data.opentime or 0
end

--: set server open time
function SetServerOpenTime(tm)
	local world_data = GetWorldCustomDB()
	if world_data == nil then
		return
	end	
	
	if tm and tm > 0 then
		world_data.opentime = tm
		if __debug then
			look('set opentime:' .. tostring(os.date('%c',tm)))
		end
	end
end

function GetServerMergeTime()
	local world_data = GetWorldCustomDB()
	if world_data == nil then
		return 0
	end
	return world_data.mergetime or 0
end

function SetServerMergeTime(tm)
	local world_data = GetWorldCustomDB()
	if world_data == nil then
		return
	end	
	world_data.mergetime = tm
	if __debug then
		look('set mergetime:' .. tostring(os.date('%c',tm)))
	end
end

--:Get World Level
function GetWorldLevel()
	local world_data = GetWorldCustomDB()
	if world_data == nil then
		return 1
	end
	return world_data.wLevel or 1
end

--:Set World Level
-- ��Ϊ������Ϸ�߼��кܶ�ط��Ĺ�ʽ����ʦ��ȼ��йء�
-- ���Ա���Ҫ��֤�����ֵ��Χ����ȷ�ԡ������������
-- Ŀǰ���÷�Χ [1,100] �Ժ�������ȼ�������ֵ **�ǵ��޸�**
function SetWorldLevel(wLevel)
	if wLevel == nil then return end
	local world_data = GetWorldCustomDB()
	if world_data == nil then
		return
	end
	-- ����Ӹ�����Ƚϱ���
	if wLevel <= 0 then
		wLevel = 1
	end
	if wLevel > 100 then
		wLevel = 100
	end
	if wLevel > 1 then
		world_data.wLevel = wLevel
	end
end

--��������ȼ�����ӳ�
function GetWorldExpAdd(sid)
	local rate = 1
	local level = CI_GetPlayerData(1)
	local wlevel = GetWorldLevel()
	local vip = GI_GetVIPLevel()
	
	--rfalse('GetWorldLevel='..wlevel)
	if level < 40 or wlevel == nil then return 1  end
	
	if wlevel - level >= 15 or ( vip>=9 and wlevel - level >= 11) then
		if vip >= 4 then rate = 2.50 
		elseif vip >= 2 then rate = 2.25
		else rate = 2.0
		end
	elseif wlevel - level >= 10 or ( vip>=9 and wlevel - level >= 6) then
		if vip >= 4 then rate = 2.0
		elseif vip >= 2 then rate = 1.75
		else rate = 1.5
		end
	elseif wlevel - level >= 5 or ( vip>=9 and wlevel - level >= 1) then
		if vip >= 4 then rate = 1.80
		elseif vip >= 2 then rate = 1.55
		else rate = 1.3
		end
	end
	return rate
	--if rate > 1 then
		--TipNormal("���������ľ��齱�����������ȼ��ӳ�")
	--end
	--�жϣ�������������ټӳ�0.2
	--[[
	if vip >= 4 then rate = rate+1 
	elseif vip >= 2 then rate = rate+0.5 end
	return rate
	]]--
end

--:
local function IncMonsterKilled( sid, name )
	-- look('IncMonsterKilled:' .. tostring(name))
	local taskData = GetDBTaskData(sid)
	if taskData == nil or taskData.current == nil then return end
	for k, v in pairs(taskData.current) do
		if type(k) == type(0) and type(v) == type({}) then
			if v.kill and v.kill[name] then
				v.kill[name] = v.kill[name] + 1
			end
		end
	end
	--look(taskData.current)
end

--:Regedit monster info task needs when task accept.
function MarkKillInfo( taskdata, taskid )	
	local taskInfo = GetTaskConfig(taskid)
	if taskInfo == nil then 
		look('taskInfo == nil:' .. tostring(taskid))
		return
	end
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then return end
	local name = CI_GetPlayerData(5)
	local curtask = taskdata.current[taskid]
	local completeCondition = taskInfo.CompleteCondition
	local taskType = GetTaskType(taskid)
	if taskType == TaskTypeTb.TS_Ring then		
		completeCondition = RT_GetConditionConf(sid)
	elseif taskType == TaskTypeTb.TS_CIC then
		completeCondition = CCT_BuildComplete(sid)
	end
	if ( taskInfo ~= nil and completeCondition ~= nil ) then
		local kill = completeCondition.kill
		if ( kill ~= nil ) then
			curtask.kill = {}
			if type(kill[1])==type({}) then
				for k,v in ipairs( kill ) do
					if v[1] == 0 then
						curtask.kill[name] = 0
					else
						curtask.kill[v[1]] = 0
					end
											
				end
			else
				if kill[1] == 0 then
					curtask.kill[ name ] = 0
				else
					curtask.kill[ kill[1] ] = 0
				end							
			end
		end
	end
end

--: server calls when task monster killed.
function OnTaskKillMonster( name )
	-- look('OnTaskKillMonster:' .. name)
	local teamInfo = GetTeamInfo()
	if teamInfo then
		local cx, cy, rid, mapGID = CI_GetCurPos()
		if mapGID == nil or rid == 519 then
			for k, v in pairs(teamInfo) do
				if v.regionId == rid then
					IncMonsterKilled(v.staticId,name)					
				end
			end
			return
		end
	end
    local sid = CI_GetPlayerData( 17 )
	IncMonsterKilled(sid,name)   
end

-- ���ñ��������Ϣ
--[[
	sp_info = {
		[1] = 50,		-- ���BOSS	
		[2] = 50,		-- ����ճ�
		[3] = 50,		-- ���ץ��
	}
]]--

-- ���ÿ����Ϣ
function GI_set_span_info(info)
	look('GI_set_span_info',1)
	look(info,1)
	if info == nil then return end
	local world_data = GetWorldCustomDB()
	if world_data == nil then
		return
	end
	-- ������������ã���Ȼ�ı������ܺ��������ԭ����Ϣ
	world_data.sp_info = {}
	for k, v in ipairs(info) do
		if type(v) == type({}) then
			world_data.sp_info[v[1]] = v[2]
		end
	end
end

function GetSpanServerInfo(uid)
	local world_data = GetWorldCustomDB()
	if world_data == nil or world_data.sp_info == nil then
		return
	end
	local info = world_data.sp_info
	if type(info) ~= type({}) then
		return
	end
	-- uid=nil �����������������Ϣ�б�
	if uid == nil then 
		return info
	end
	return info[uid]
end

-- ���ڱ���������ܴ���
function TraverseSpanInfo(func,args)
	if type(func) ~= type(function () end) then return end
	local info = GetSpanServerInfo()
	if type(info) ~= type({}) then
		return
	end
	for k, v in pairs(info) do
		if type(k) == type(0) then
			func(k,v,args)
		end
	end
end