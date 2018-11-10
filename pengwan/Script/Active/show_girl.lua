--[[
file: show_girl.lua
desc: show girl
autor: csj
]]--

--------------------------------------------------------
--include:
local db_module = require('Script.cext.dbrpc')
local db_show_girl = db_module.db_show_girl
local look = look

--------------------------------------------------------
--module:

module(...)


---------------------------------------------------------
--inner:

function _get_show_girl(sid)
	db_show_girl(sid)
end

---------------------------------------------------------
--interface:

get_show_girl = _get_show_girl