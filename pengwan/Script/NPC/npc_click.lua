--[[
file: npc_click.lua
desc: npc click event proc
]]--

--------------------------------------------------
--inner:

local _call_npc_click = noassign{
	-- [clickscriptid] = function() 
	-- 	... 
	-- end		-- ��ʽ
}

--------------------------------------------------
--interface:

call_npc_click = _call_npc_click