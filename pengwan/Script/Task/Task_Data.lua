--[[
file:	Task_Data.lua
desc:	Player's task data.
author:	chal
update:	2011-12-01
]]--
--:Get player task save data.
function GetDBTaskData( playerid )
	if playerid == nil or playerid == 0 then
		return
	end
	local data = GI_GetPlayerData( playerid , "task" , 1024 )
	if nil == data then
		--look("task data init error! ")
		return
	end
	-- sth. have to be inited.
	data.current = data.current or {}
	data.completed = data.completed or {}
	return data
end

-- Get player task temp data.
function GetDBTaskTemp( playerid )
	if playerid == nil or playerid == 0 then
		return
	end	
	local temp = GI_GetPlayerTemp( playerid , "task" )
	if nil == temp then
		--look("task temp init error! ")
		return
	end
	return temp
end

--:Get cur player's task data.
function GetCurDBTaskData()
	return GetDBTaskData(GetCurPlayerID())
end

--:Get cur player's task temp data.
function GetCurTaskTemp()
	return GetDBTaskTemp(GetCurPlayerID())
end
