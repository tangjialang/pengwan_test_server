--[[
file:	player_patrol.lua
desc:	主城巡防
author:	wk
update:	2013-8-26

]]--
--------------------------------------------------------------------------
local function patrol_gettempdata( sid )
	if sid == nil then return nil end
	local cData = GetPlayerTemp_custom(sid)
	if cData == nil  then return end
	if cData.zxfb == nil then
		cData.zxfb = {
			--[1]=111,上次开始巡防时间
		}
	end
	return cData.zxfb
end
--开始巡防
function patrol_on()
	local _, _, rid, _ = CI_GetCurPos()
	if rid~=1 then return end
	local sid=CI_GetPlayerData(17)
	local ldata=patrol_gettempdata(sid)
	if ldata==nil then return end
	local now=GetServerTime()
	if now-(ldata[1] or 0)<10 then return end
	ldata[1]=now
	CI_AddBuff(83,0,1,1)
end
--结束巡防
function patrol_off()
	CI_DelBuff(83)
end
--------------------------------------------------------------------------
