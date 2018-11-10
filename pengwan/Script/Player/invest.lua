--[[
  file:	invest.lua
  desc:	player touzi data init interface
  author:	dl
  update:	 2013-10-21

--]]
--include
---------------------------------------
local look = look
local rint = rint
local type = type
local mathfloor = math.floor
local next = next
local ipairs = ipairs
local SendLuaMsg = SendLuaMsg
local GetServerTime = GetServerTime
local GetPlayerDayData = GetPlayerDayData
local CheckCost = CheckCost
local DGiveP = DGiveP
local AddPlayerPoints = AddPlayerPoints
local GiveGoods = GiveGoods
local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond
local invest_msg = msgh_s2c_def[3][15]
---------------------------------------
--data
-----------------------------------------

----------------------------------------------
--inner function
----------------------------------------

local function day_money(PlayerID,day1,day2) --day1前10天内有几天没领，day2前11--30天内有几天没领 然后领取
		look('day1:' .. day1)
		look('day2:' .. day2)
	   if type(day1)~=type(0) and type(day2)~=type(0) then return  end
       local yuanbao,bangyuan,tongqian = 0,0,0
	   if day1>0 then 
		   yuanbao = 50*day1
		   bangyuan = 500*day1
		   tongqian = 200000*day1      
	   end
	   if day2>0 then 
		   bangyuan = bangyuan + 250*day2
		   tongqian = tongqian + 200000*day2 
	   end
	   if yuanbao>0 then 
 	      DGiveP(yuanbao,'awards_投资领取元宝')  
 	   end  
	   if bangyuan>0 then
	      AddPlayerPoints(PlayerID,3,bangyuan,nil,'投资领取绑元')
	   end
	   if tongqian>0 then
	      GiveGoods(0,tongqian,0,'投资领取铜钱')
	   end
end
--------------
function GetPlayerDayTouZiData(playerID)
	local DayData = GetPlayerDayData( playerID )
	if DayData == nil then return end
	if nil == DayData.tz then
		DayData.tz = {}
	end
	return DayData.tz
end

function IsPlayerInvest(PlayerID)
	local DayData = GetPlayerDayData( playerID )
	if DayData == nil then 
		return false
	end
	if DayData.tz == nil or DayData.tz[1] == nil then
		return false
	end
	local now = GetServerTime()
	local tm = DayData.tz[1]
	if rint((now - tm) / 24*3600) >= 30 then
		return false
	end
	return true
end

local time_ver = GetTimeToSecond(2014,4,11,0,0,0)

----------------
local function _invest(PlayerID) -------投资
	local openTime = GetServerOpenTime()
	if openTime == 0 then return end
	-- look(os_date('%Y-%m-%d %H:%M:%S', openTime))
	if __plat == 101 and openTime > time_ver then
		return
	end
	
    local res = 0
    if PlayerID == nil then  return end
    local tz = GetPlayerDayTouZiData(PlayerID)
    if tz[1] == nil then 
		if not CheckCost(PlayerID,500,0,1,'100028_使用投资') then
		   SendLuaMsg(0,{ids=invest_msg,res=0},9)  ---投资失败
		   return 
		else
		   tz[1] = GetServerTime()  --投资时间 
		   tz[2] = 0                --领取时间，第一次投资成功的领取时间设为了投资时间
		   SendLuaMsg(0,{ids=invest_msg,res=1,data=tz[1]},9)  ---投资成功
		   BroadcastRPC('tip_notice',2,CI_GetPlayerData(5))
		   return 
		end
	else
		local day1,day2 = 0,0
		local tzsj = tz[1]
		local old_lqsj = tz[2]
		if old_lqsj==0 then  
		  day1 = 1
		  old_lqsj = tzsj
		end
		local now = GetServerTime()
		local new_times = mathfloor(now/(24*3600)) - mathfloor(tzsj/(24*3600)) + 1
		local old_times = mathfloor(old_lqsj/(24*3600)) - mathfloor(tzsj/(24*3600)) + 1 - day1
		look('new_times:' .. new_times)
		look('old_times:' .. old_times)
		local day = new_times - old_times
		if old_times>30 then return  end
		if new_times>30 then new_times=30 end
		if day>0 or day1 >= 1 then
			if old_times<10 then
				if new_times<10 then
					day1 = new_times - old_times
					day2 = 0
				else
					day1 = 10 - old_times
					day2 = new_times - 10
				end
			else
				day1 = 0
				day2 = new_times - old_times  
			end
			tz[2] = now
			day_money(PlayerID,day1,day2)
			SendLuaMsg(0,{ids=invest_msg,res=2,data=tz[2]},9) ---领取成功
		end
	end
end
--interface
-------------------------------------------
invest = _invest




