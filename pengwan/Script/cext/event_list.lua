--[[
file: event_list.lua
desc: event_list module
]]--

--------------------------------------------------------
--include:

local pairs = pairs
local ipairs = ipairs
local setmetatable = setmetatable

local common_heap = require('Script.common.heap')
local heap 	= common_heap.heap

----------------------------------------------------------
--module:

module(...)

----------------------------------------------------------
--inner:
local function __sort_func( a, b)
	return a.ticks < b.ticks
end

local _event_list = {
    new = function(self, now )
        local o = {	events = heap:new( __sort_func ), tick_passed = 0, begin = now }
        setmetatable( o, self)
        self.__index = self
        return o
    end,

	add_event = function( self, ticks, data)
		self.events:insert{ticks = ticks, data = data}
    end,
	
	add_event_next = function( self, ticks, data)
		self:add_event( self.tick_passed + ticks, data)
    end,
	
	set_begin = function( self, bg)
		self.begin = bg
	end
}

--------------------------------------------------------------
--interface:
event_list = _event_list