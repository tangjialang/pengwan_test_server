--[[
file:	message.lua
desc:	VIP
author:	csj
]]--

--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local VIP_BuyLv = VIP_BuyLv
local VIP_GetDayGift = VIP_GetDayGift


--------------------------------------------------------------------------
-- data:

-- 购买VIP等级
msgDispatcher[29][1] = function (playerid, msg)
	VIP_BuyLv(playerid,msg.fName,msg.iType)
end

--领取VIP每日礼包
msgDispatcher[29][2] = function ( playerid, msg )
	VIP_GetDayGift(playerid)
end

--领取VIP xxx礼包
msgDispatcher[29][3] = function ( playerid, msg )
	VIP_GetFirstGift(playerid)
end
--购买包月
msgDispatcher[29][4] = function ( playerid, msg )
	by_buy(playerid,msg.itype,msg.name)
end