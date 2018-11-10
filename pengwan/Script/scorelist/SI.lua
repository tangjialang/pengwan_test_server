--------------------------------------
--include:

local pairs,type = pairs,type

local sclist_m = require('Script.scorelist.sclist_func')
local refresh_scorelist = sclist_m.refresh_scorelist

function SI_refresh_scorelist(mode)
	refresh_scorelist(mode)
end