--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher

local sclist_m = require('Script.scorelist.sclist_func')
--------------------------------------------------------------------------
-- data:

-- request enter cs.
msgDispatcher[33][1] = function ( playerid, msg )
	sclist_m.request_scorelist( playerid, msg.mode, msg.itype )
end