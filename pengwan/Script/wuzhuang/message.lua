
--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local wuzhuang = require('Script.wuzhuang.wuzhuang_fun')
local wuzhuang_up = wuzhuang.wuzhuang_up
local wz_check       = wuzhuang.wz_check
--------------------------------------------------------------------------
-- data:
--元神初始化信息
--msgDispatcher[42][0] = function (playerid,msg)
	--yuanshen_init(playerid)
--end
--元神升级

--元神武装升级
msgDispatcher[48][1] = function(playerid,msg)
	wuzhuang_up(playerid,msg.outfit,msg.num,msg.money)
end
msgDispatcher[48][2] = function(playerid,msg)
	wz_check(playerid,msg.playerid,msg.name)
end


