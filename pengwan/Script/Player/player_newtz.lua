--[[
]]--

local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond

local time_ver_1 = GetTimeToSecond(2014,4,11,0,0,0)
local time_ver_2 = GetTimeToSecond(2014,4,22,0,0,0)

function GiveNewTouziAward(sid)
	look('GiveNewTouziAward',1)
	local openTime = GetServerOpenTime()
	if openTime == 0 then return end
	
	if __plat ~= 101 then 
		if openTime <= time_ver_2 then return end
	else
		if openTime <= time_ver_1 then return end
	end
	
	local DayData = GetPlayerDayData( sid )
	if DayData == nil then return end
	local lv = CI_GetPlayerData(1)
	-- look(lv,1)
	--[[
	if lv < 45 then
		return
	end
	--]]
	local cz = CI_GetPlayerData(27) or 0
	if cz <=0 then
		return
	end
	local bdyb = 0 
	local cur = DayData.curtz
	if cur == nil then
		--bdyb = (lv - 44) * 188
		if(lv>60)then lv = 60 end
		bdyb = lv * 188
	else
		if cur >= 60 then return end
		bdyb = (lv - cur) * 188
	end
	if bdyb <= 0 then return end
	-- look(bdyb,1)
	DayData.curtz = lv
	AddPlayerPoints( sid , 3 , bdyb ,nil,'360ÐÂÍ¶×Ê')
	-- RPC('new_touzi',0)
end