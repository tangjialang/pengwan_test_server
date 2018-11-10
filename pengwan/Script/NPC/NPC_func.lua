--[[
file:	NPC_func.lua
desc:	npc functions( only common functions here )
author:	chal
update:	2011-11-30
]]--
local TP_FUNC = type( function() end)
local type = type
local call_npc_click = call_npc_click
local CommonConditionCheckTable = CommonConditionCheckTable
local TableHasKeys = table.has_keys
local look,GetObjectUniqueId = look,GetObjectUniqueId

--:npc click interface
function SI_OnClickNPC( scriptId )
	look("SI_OnClickNPC" .. scriptId)
	local npcid = GetObjectUniqueId()
	npcid = npcid - 100000
	local func = call_npc_click[scriptId]
	if "function" ~= type(func) then
		look("SI_OnClickNPC不是一个函数scriptId="..tostring(scriptId))
		return
	end
	func()
end

-- click npc's funciton step.
function ClickNPCFunciton( playerid, npcid , index )	
	local taskData = GetDBTaskData( playerid )
	local taskTemp = GetPlayerTemp_custom(playerid)
	local storyid = nil
	if TableHasKeys(npclist, {npcid, "NpcFunction", index}) then
		local FunItem = npclist[npcid].NpcFunction[index]		
		if FunItem[3] and type(FunItem[3]) == type({}) then
			local ok = CommonConditionCheckTable.CheckConditions(FunItem[3], taskData, 0)
			if ok == 1 then
				storyid = FunItem[1]
			end
		else
			storyid = FunItem[1]
		end	
		
		if storyid =="call" then
			if FunItem.func and TP_FUNC==type( _G[FunItem.func]) then
				_G[FunItem.func](playerid, npcid)
			end
		end
	end

	if storyid ~= nil then
		--SendStoryData(storyid, npcid)
		taskTemp.storyid = storyid
		taskTemp.npcid = npcid
	end
end

