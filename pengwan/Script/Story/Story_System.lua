--[[
file:	Story_System.lua
desc:	story systems
author:	chal
update:	2011-12-01
]]--
local type = type
local Play_Story 	= msgh_s2c_def[2][1]
local SendLuaMsg = SendLuaMsg
local LockPlayer,CI_GetPlayerData = LockPlayer,CI_GetPlayerData
--Send story id to notice client play a story.
function SendStoryData(storyid, npcid)
	if type (storyid)~=type(0) then return end
	
	-- local taskTemp = GetPlayerTemp_custom(CI_GetPlayerData(17))
	-- taskTemp.storyid = storyid
	-- CG类剧情需锁定玩家
	if storyid > 1000000 then
		LockPlayer( 60000, CI_GetPlayerData(17) )
	end
	--look(" 这是剧情 storyid = [ " .. storyid .. "] ")
	SendLuaMsg( 0, { ids = Play_Story, npcid = npcid, id = storyid }, 9 )
end
--[[
-- click story's function step.
function ClickStoryStep(playerid, npcid, step,storyid)
	----rfalse('step='..step)
	local temp = GetPlayerTemp_custom(playerid)
	if storyid == nil then
		storyid =  temp.storyid
	end
	----rfalse('storyid='..tostring(storyid))
	local story = table.has_keys(storyList, storyid)
	if nil==story then
		return		
	end
	if npcid == nil or npcid == 0 then
		npcid = GetObjectUniqueId()
	end
	local onclick = table.has_keys( story, {step, "onClick"} )
	--rfalse('onclick   npcid='..tostring(npcid))
	if type(_G[onclick])==TP_FUNC then
		_G[onclick]( npcid, step )
	end
end
]]--