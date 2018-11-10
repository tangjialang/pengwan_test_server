--[[
file:	message.lua
desc:	hero messages.
author:	chal
update:	2011-12-07
]]--

--------------------------------------------------------------------------
--include:
local msgDispatcher = msgDispatcher


msgDispatcher[41][1] = function (playerid, msg)
	FactionChatProc(playerid, msg.fac_id, msg.svrid, msg.contents)
end