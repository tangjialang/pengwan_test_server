--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher

local shq_m = require('Script.ShenQi.shenqi_func')
local shenqi_PICC = shq_m.shenqi_PICC
local shenqi_PICC_aoto = shq_m.shenqi_PICC_aoto
local shenqi_enhance = shq_m.shenqi_enhance
local shenqi_equip = shq_m.shenqi_equip
local shenqi_get = shq_m.shenqi_get
local shenqi_get_starttime = shq_m.shenqi_get_starttime
local jiezhi_unload = shq_m.jiezhi_unload

local look = look
--------------------------------------------------------------------------
-- data:

-- request enter cs.
msgDispatcher[38][1] = function ( playerid, msg )
	shenqi_PICC( msg.itype, msg.shqid, msg.times )
end

msgDispatcher[38][2] = function ( playerid, msg )
	shenqi_enhance( msg.itype, msg.shqid )
end

msgDispatcher[38][3] = function ( playerid, msg )
	shenqi_get( playerid, msg.itype, msg.shqid )
end

msgDispatcher[38][4] = function ( playerid, msg )
	shenqi_equip( playerid, msg.itype, msg.shqid, msg.isequip)
end

msgDispatcher[38][5] = function ( playerid, msg )
	shenqi_PICC_aoto( msg.shqid, msg.isAoto)
end

msgDispatcher[38][6] = function ( playerid )
	shenqi_get_starttime()
end

------
--傲世戒指
---------------------------------------------------
--脱下戒指
msgDispatcher[38][7] = function ( playerid, msg)
	jiezhi_unload(playerid, msg.id)
end



