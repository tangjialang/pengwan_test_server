--[[
file:	Monster_Create.lua
desc:	Monster create functions.
author:	chal
update:	2011-12-05
notes:
tool function:
GetMonsterCurPos
CI_GetCurPos
]]--
-- create monster by ID in MonsterConfList.

--------------------------------------------------------------------------
--include:
local type,pairs = type,pairs
local MonsterConfList = MonsterConfList
local MonsterEvents = MonsterEvents
local MonsterRegisterEventTrigger = MonsterRegisterEventTrigger
local CreateObjectIndirect = CreateObjectIndirect

--------------------------------------------------------------------------
--interface:
function CreateMonsterByID(ID, RegionID)  
	local wlevel = GetWorldLevel() or 1
	if RegionID and type(RegionID) == type(0) then
		local RefreshNeedWLevel = MonsterConfList[ID].RefreshNeedWLevel
			local id = 0
			if RefreshNeedWLevel and type(RefreshNeedWLevel) == type({}) then  --是否有世界等级限制
				for _,level in pairs(RefreshNeedWLevel) do
					if wlevel >= level then
						id = id + 1
					end
				end
			end
		for k,v in pairs(MonsterConfList[ID]) do
			if v.monsterId then
				v.regionId = RegionID
				v.monsterId = v.monsterId + id
				local GID = CreateObjectIndirect(v)
				--register event.
				if GID and v.EventID and v.eventScript and v.eventScript > 0 then
					MonsterRegisterEventTrigger( v.regionId, GID, MonsterEvents[v.eventScript])				
				end
			end
		end
	end
end