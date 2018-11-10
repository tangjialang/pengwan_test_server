--[[
file:	Trap_Proc.lua
desc:	副本陷阱处理函数
author:	csj
update:	2011-11-23
]]--

local pairs = pairs
local ipairs = ipairs
local CreateObjectIndirectEx = CreateObjectIndirectEx
local uv_FBConfig = FBConfig
local CI_GetPlayerData = CI_GetPlayerData
-- 副本陷阱点处理函数
call_OnMapEvent[10005]=function (trapID)
	local sid = CI_GetPlayerData(17)
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp.CopySceneGID == nil then return end
	local copyScene = CS_GetTemp(pCSTemp.CopySceneGID)
	if copyScene == nil then return end
	
	local fbID = copyScene.fbID
	local mainID ,subID = GetSubID(fbID)
	local csEventTb = uv_FBConfig[mainID][subID].EventList	
	local TrapsEvent = csEventTb.Traps[trapID]
	
	if TrapsEvent == nil then
		return
	end
	
	-- -1 无限触发次数
	if copyScene.TraceList ~= nil and copyScene.TraceList.Traps ~= nil then
		local TrapsInfo = copyScene.TraceList.Traps[trapID]
		if TrapsInfo ~= nil and  TrapsInfo.num ~= nil then
			if TrapsInfo.num > 0 then
				TrapsInfo.num = TrapsInfo.num - 1
				CS_EventProc(pCSTemp.CopySceneGID,TrapsEvent.EventTb,sid)
			elseif TrapsInfo.num == -1 then			
				if TrapsEvent.Con then
					local conTb = TrapsEvent.Con
					if type(conTb.MonDeads) == type({}) then
						local md = copyScene.TraceList.MonDeads
						for k, v in pairs(conTb.MonDeads) do
							if md == nil or md[k] == nil or md[k].num == nil or md[k].num > 0 then
								RPCEx(sid,'Trap_Tip',conTb.tip)
								return
							end
						end
					end
				end
				CS_EventProc(pCSTemp.CopySceneGID,TrapsEvent.EventTb,sid)
			end
		end
	end	
end