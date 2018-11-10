--[[
file:	time_cnt.lua
desc:	时间函数接口
author:	chal
update:	2013-07-01
module by chal
]]--

--------------------------------------------------------------------------
--include:
local __G = _G
local type = type
local tonumber = tonumber
local string = string
local osdate = os.date
local ostime = os.time
local GetServerTime = GetServerTime
local tablecopy = table.copy
local tableforeachi = table.foreachi
local look,Log = look,Log
local tostring = tostring
local math_floor = math.floor
--------------------------------------------------------------------------
--module:
module(...)

local w2c_weekday 	= { 7, 1, 2, 3, 4, 5, 6 }
local uv_dt 		= {year = 0, month = 0,day = 0,hour = 0, min =0, sec = 0}
local uv_x			= {0,31,28,31,30,31,30,31,31,30,31,30,31}
local uv_md			= {31,28,31,30,31,30,31,31,30,31,30,31}

local _DAY_TIME 	= 60*60*24

local function _GetTimeThisDay(now, h,m, s)
	local dt = osdate("*t", now)
	dt.hour = h
	dt.min = m
	dt.sec = s or 0
	return ostime(dt)
end

local function _GetTimeToSecond(y,mt,d,h,m,s)
	uv_dt.year = y
	uv_dt.month = mt
	uv_dt.day = d
	uv_dt.hour = h
	uv_dt.min = m
	uv_dt.sec = s
	return ostime(uv_dt)
end

--获取指定时间的n天后h:m:s 的 time值
local function GetNextNDayTime( tm, h, m, s, nday)
	local tm = tm + _DAY_TIME* (nday or 1)
	local dt = osdate( "*t", tm)
	dt.hour = h
	dt.min = m
	dt.sec = s
	return ostime( dt )
end

--获取week周后的星期wd h:m:s的time值
local function GetNextNWeekTime(tm, wd, h, m, s, week)
	local tm_dt = osdate("*t", tm)
	local days = week* 7 + (wd- w2c_weekday[tm_dt.wday])
	return GetNextNDayTime(tm, h, m, s, days )
end

local function _IsNewWeek( cur, last, week)
	return cur>=GetNextNWeekTime(last, 1, 0, 0, 0, (week or 1) )
end

local function _IsNewWeekDetail(cur, last, day, hour, min, sec, week)	
	return cur >= GetNextNWeekTime(last, day, hour, min, sec, (week or 1))
end

local function _GetMonthMaxDays(time)
	local dt = osdate("*t",time)
	local y = dt.year
	local m = dt.month
	if((y%4==0 and y%100~=0) or y%400==0)then
 		uv_md[2] = 29
	else
		uv_md[2] = 28
 	end	
	return uv_md[m]
end

local function __GetDiffDayFromBegin(time)
	local dt = osdate("*t",time)
	local y = dt.year
	local m = dt.month
	local d = dt.day
	
	local i = 0
	local s = 0
	  
	for i = 1, y do
		if((i%4==0 and i%100~=0) or i%400==0)then
			s = s + 366;
		else 
			s = s + 365;--整年份的天数
		end
	end

 	if((y%4==0 and y%100~=0) or y%400==0)then
 		uv_x[3] = 29
	else
		uv_x[3] = 28
 	end	
 	for	i = 1,m do
 		s = s + uv_x[i]--整月的天数
 	end	
	s = s + d--日的天数
 	return s;	--返回总天数,相对公元1年
end

-- local function _GetDiffDayFromTime(time)
	-- local diff1 = __GetDiffDayFromBegin(time)
	-- local Now = GetServerTime()
	-- local diff2 = __GetDiffDayFromBegin(Now) 
	-- local diffDay = diff1 - diff2
	-- if(diff2 >= diff1 )then
		-- diffDay = diff2 - diff1
	-- end	
	-- return diffDay
-- end

local function _GetDiffDayFromTime(time,noAbsolute)	--减少循环量
	local now = GetServerTime()
	local time_date = osdate("*t",time)
	local now_date =osdate("*t",now)
	time_date.hour = 0
	time_date.min = 0
	time_date.sec = 0
	now_date.hour = 0
	now_date.min = 0
	now_date.sec = 0

	local time_temp = ostime(time_date) 
	local now_temp = ostime(now_date)
	
	if(time_temp)then
		local sub = now_temp - time_temp
		if sub <0 and not(noAbsolute and noAbsolute == 1) then
			sub = 0 - sub
		end
		return math_floor(sub/_DAY_TIME)
	end
end

local function isPassedCurDay(h, m, tm)
	if h == nil or m == nil or tm == nil then return end
	return _GetTimeThisDay(tm,h,m) < tm
end

local function _GetDiffDayEx(last,now,h,m)
	local intervalDay = _GetDiffDayFromTime(last)	
	if not isPassedCurDay(h,m,last) then 				-- 没过h点相当于起始时间是前一天 所以天数加1
		intervalDay = intervalDay + 1		
	end
	if not isPassedCurDay(h,m,now) then					-- 没过h点相当于终止时间是前一天 所以天数减1
		intervalDay = intervalDay - 1
	end
	return intervalDay
end

local function _subTimeThisDay(h, m, s)
	local now = GetServerTime()
	return _GetTimeThisDay(now, h, m, s) - now
end

local function _isPassedThisDay(h, m, tm)
	local now = GetServerTime()
	return _GetTimeThisDay(now, h,m) < tm
end

local function _getdatetime( dt)
	return _GetTimeToSecond( dt[1], dt[2], dt[3], dt[4], dt[5], dt[6] )
end

local function _getdatetimeex( dt, tm, offset )
	local dt2 = tablecopy( dt )
	
	offset = offset or 3	
	tableforeachi( tm, function( k, v )
							dt2[ k+ offset ] = v
						end )
	return _getdatetime( dt2 )
end

-- 解析字符串时间
function _analyze_time(strtime,iType)
	if type(strtime) ~= type('') or type(iType) ~= type(0) then
		look('_analyze_time param erro')
		return
	end
	local strDate = string.gsplit(strtime,' ')
	local dd = string.gsplit(strDate[1],'-')
	local tt = string.gsplit(strDate[2],':')
	local Date
	if iType == 0 then
		Date = {tonumber(dd[1]), tonumber(dd[2]),tonumber(dd[3]),
					tonumber(tt[1]), tonumber(tt[2]), tonumber(tt[3])}
	elseif iType == 1 then
		Date = {year = tonumber(dd[1]), month = tonumber(dd[2]),day = tonumber(dd[3]),
					hour = tonumber(tt[1]), min = tonumber(tt[2]), sec = tonumber(tt[3])}
	end
						
	return Date
end

--------------------------------------------------------------------------
--interface:
DAY_TIME			= _DAY_TIME
GetTimeThisDay 		= _GetTimeThisDay		--今天的h,m是什么时间
GetTimeToSecond 	= _GetTimeToSecond		--返回当前时间为秒为单位的Number
IsNewWeek 			= _IsNewWeek			--是否过了下周一0点
IsNewWeekDetail 	= _IsNewWeekDetail		--是否过了下周的某个时刻
GetDiffDayEx 		= _GetDiffDayEx			--距离上一个时间过了多少天
GetMonthMaxDays 	= _GetMonthMaxDays		--获取当月最大天数
subTimeThisDay		= _subTimeThisDay		--据今天的 h:m 还有多久
isPassedThisDay 	= _isPassedThisDay		--now是否过了 h:m这时间
getdatetime			= _getdatetime			--获取某个时刻的秒数
getdatetimeex 		= _getdatetimeex		--获取某个时刻的秒数（相对时间）
analyze_time		= _analyze_time			--字符串时间解析
GetDiffDayFromTime = _GetDiffDayFromTime	--获取天数间隔