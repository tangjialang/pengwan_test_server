--[[
file:	events.lua
desc:	global events register.
author:	chal
update:	2011-12-10
refix: done by chal
]]--

--------------------------------------------------------------------------
--include:
local uv_TimesTypeTb = TimesTypeTb
local collectgarbage = collectgarbage
local look = look
local common 			= require('Script.common.Log')
local Log 				= common.Log
local define 			= require('Script.cext.define')
local Server_Event 		= define.Server_Event

--------------------------------------------------------------------------
--inner:
mem_use_log = mem_use_log or {0,0,0,0,0,0,0}
login_num = login_num or 0
logout_num = logout_num or 0
local function MannulGC()
	
	collectgarbage("step",320)

	local _log = mem_use_log
	local curMem = collectgarbage("count")
	_log[1] = curMem - _log[2]
	_log[2] = curMem
	_log[3] = ((_log[3] < curMem) and curMem) or _log[3]
	_log[4] = (((_log[4] > curMem) or (_log[4] == 0)) and curMem) or _log[4]
	local wExtra = GetWorldExtraData()
	if wExtra then
		_log[5] = wExtra.num
	end
	_log[6] = login_num
	_log[7] = logout_num
	login_num = 0
	logout_num = 0
	local info = tostring(_log[1])..'  '..tostring(_log[2])..'  '..tostring(_log[3])..'  '..tostring(_log[4]) .. '	' .. tostring(_log[5]) .. '	' .. tostring(_log[6]) .. '	' .. tostring(_log[7])
	Log('lua_mem.txt',info)
	--local result = collectgarbage("step",456)
	--look(result)
	--collectgarbage("collect")
	--count = collectgarbage("count")
	--look('end count = '..tostring(count))
end

--------------------------------------------------------------------------
--interface:

LOOP_TIME = 60
hourtime =hourtime or GetServerTime()
__eventtime = __eventtime or 0
function MainLoop() --每分钟调一次
	MannulGC()
	local now=GetServerTime()
	if now-hourtime>=60*60 then 
		faction_clc_region()--驻地
		faction_clc_mijing()--秘境
		
		hourtime=now
	end
	
	local RecTime = now - (__eventtime or 0)
	if RecTime >= 10 then
		__eventtime = GetServerTime()
		PassTime(RecTime)
		SetEvent( 1,Server_Event.Actives, "SI_UpdateActiveTimer",1)
		Log('SetEvent.txt','SetEvent pause')
	end
end