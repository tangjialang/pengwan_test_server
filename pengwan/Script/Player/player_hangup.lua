--[[
file:	player_hangup.lua
desc:	闭关修练
author:	xiao.Y
update:	2011-12-13
refix: done by chal
]]--
local tostring = tostring
local GetServerTime,PI_PayPlayer = GetServerTime,PI_PayPlayer
local BG_Time	= msgh_s2c_def[3][2]
local look = look
local mathfloor = math.floor
local common_time = require('Script.common.time_cnt')
local GetTimeThisDay = common_time.GetTimeThisDay
local CI_AddBuff = CI_AddBuff
local osdate = os.date

--发送闭关时间
-- function SendHangUp(sid)
	-- local data = GetHangUpData(sid)
	-- if(data~=nil and data[1]~=nil)then
		-- SendLuaMsg( 0, { ids=BG_Time ,t = data[1] }, 9 )
	-- end
-- end

--微端登录奖励
function player_client_login(sid)
	CI_AddBuff(95,0,1,true)
end

--获取闭关时间
function GetHangUpData(sid)
	local dayData 	= GetPlayerDayData(sid)
	--time 1 在线抽奖时间点,2 在经抽奖的阶段 3 记录下线时间 4 上线计算离线时长（正常时段） 5 最后一次上线时间 6 每日在线累计时长 7 上线计算离线时长（3倍时段）
	dayData.time = dayData.time or {}	-- 每日在线抽奖时间重置
	return dayData.time
end

--下线记录下线时间,计算本次累计在线时间
function SetLogoutHangUpData(sid)
	local dayData 	= GetPlayerDayData(sid)
	if(dayData~=nil)then
		dayData.time = dayData.time or {}	-- 每日在线抽奖时间重置
		dayData.time[3] = GetServerTime()
		--look('--下线记录下线时间')
		--look(dayData.time)
		if(dayData.time[5]~=nil)then
			if(dayData.time[6] == nil)then dayData.time[6] = 0 end 
			dayData.time[6] = dayData.time[6] + (dayData.time[3] - dayData.time[5])
		end
		return dayData.time
	end
end

--记录最后一次上线时间 t nil 要清除累计时间 1 不清累计时间
function set_login_time_last(sid,t)
	local dayData 	= GetPlayerDayData(sid)
	dayData.time = dayData.time or {}	-- 每日在线抽奖时间重置
	local srvTime = GetServerTime()
	if(t == nil)then --每日重置调用
		local temp = dayData.time[6]
		if(temp == nil)then temp = 0 end
		if(dayData.time[5]~=nil )then
			local tempSec = GetTimeThisDay( dayData.time[5], 23,59,59)
			if(tempSec<=srvTime)then
				temp = temp + tempSec - dayData.time[5]
				add_player_wage(sid,temp) --计算昨日需要的元宝
			end
		end
		dayData.time[6] = 0
	else
		if(dayData.time[6] == nil)then dayData.time[6] = 0 end
	end
	dayData.time[5] = srvTime
	--look('--上线记录上线时间')
	--look(dayData.time)
	return dayData.time
end

--上线计算离线时间(24点至8点，3倍经验）
function SetLoginHangUpData(sid)
	local dayData 	= GetPlayerDayData(sid)
	dayData.time = dayData.time or {}	-- 每日在线抽奖时间重置
	if(dayData.time[3] ~= nil and dayData.time[3]>0)then
		local oldsec = dayData.time[3]
		local olddt = osdate("*t", oldsec)
		local cursec = GetServerTime()
		local curdt = osdate("*t", cursec)
		local elsesec = 0
		if((cursec - oldsec)>(24*60*60))then --超过一天
			local leaveDays = mathfloor((cursec - oldsec)/(24*60*60))
			if(dayData.time[4] == nil)then
				dayData.time[4] = leaveDays*16*24*60*60
			else
				dayData.time[4] = dayData.time[4] + leaveDays*16*60*60
			end
			if(dayData.time[7] == nil)then
				dayData.time[7] = leaveDays*8*24*60*60
			else
				dayData.time[7] = dayData.time[7] + leaveDays*8*60*60
			end
			elsesec = mathfloor((cursec - oldsec)%(24*60*60))
		else
			elsesec = cursec - oldsec
		end
		local curHours = curdt.hour
		local curMins = curdt.min
		local curSecs = curdt.sec
		local totalSecs
		if(curHours<8)then --在3倍时间内上线
			totalSecs = curHours*60*60 + curMins*60 + curSecs
			--look('---'..totalSecs)
			if(totalSecs>=elsesec)then --全是3倍离线时间
				if(dayData.time[7] == nil)then
					dayData.time[7] = elsesec
				else
					dayData.time[7] = dayData.time[7] + elsesec
				end
			else --有1倍的时间
				if(dayData.time[4] == nil)then
					dayData.time[4] = elsesec - totalSecs
				else
					dayData.time[4] = dayData.time[4] + elsesec - totalSecs
				end
				if(dayData.time[7] == nil)then
					dayData.time[7] = totalSecs
				else
					dayData.time[7] = dayData.time[7] + totalSecs
				end
			end
		else --在1倍时间内上线
			totalSecs = (curHours-8)*60*60 + curMins*60 + curSecs
			if(totalSecs>=elsesec)then --全是1倍离线时间
				if(dayData.time[4] == nil)then
					dayData.time[4] = elsesec
				else
					dayData.time[4] = dayData.time[4] + elsesec
				end
			else --有3倍的时间
				if(dayData.time[7] == nil)then
					dayData.time[7] = elsesec - totalSecs
				else
					dayData.time[7] = dayData.time[7] + elsesec - totalSecs
				end
				if(dayData.time[4] == nil)then
					dayData.time[4] = totalSecs
				else
					dayData.time[4] = dayData.time[4] + totalSecs
				end
			end
		end
		if(dayData.time[4] == nil or dayData.time[4]<0)then dayData.time[4] = 0 end
		if(dayData.time[7] == nil or dayData.time[7]<0)then dayData.time[7] = 0 end
	elseif(dayData.time[4]~=nil or dayData.time[7]~=nil)then
		dayData.time[4] = 0
		dayData.time[7] = 0
	end
	dayData.time[3] = 0
	--look('--上线计算离线时间')
	--look(dayData.time)
	return dayData.time
end

--type 0 免费 1 铜钱 2 元宝
function GetHangUpExp( sid , type )
	local data = GetHangUpData(sid)
	if(data == nil or (data[4] == nil and data[7] == nil))then return false,0 end --获取闭关数据失败
	local times = data[4] or 0 --1倍时间
	local times1 = data[7] or 0 --3倍时间
	if(times == 0 and times1 == 0)then return false,1 end
	
	local mins = mathfloor(times/60)
	local mins1 = mathfloor(times1/60)
	if(mins<0)then mins = 0 end
	if(mins1<0)then mins1 = 0 end
	if(mins==0 and mins1==0)then return false,1 end --时间有误
	
	if(mins>168*60)then mins = 168*60 end --最多累积24小时
	if(mins1>=168*60)then
		mins1 = 168*60
		mins = 0
	elseif(mins1>0 and (mins+mins1)>168*60)then
		mins = 168*60 - mins1
	end --最多累积24小时
	
	--look('mins='..mins)
	
	local level = CI_GetPlayerData(1)
	local tempExp = mathfloor((level^2.7)/28) --等级^1.6*1.2*6
	if(tempExp<50)then tempExp = 50 end
	local hangupExp = mathfloor(tempExp*mins*2)
	local hangupExp1 = mathfloor(tempExp*mins1*2*3)
	hangupExp = hangupExp + hangupExp1
	if(hangupExp>130000000)then
		hangupExp = 130000000
	end
	local needMoney = 0
	if(type == 1)then
		--hangupExp = mathfloor(hangupExp * 2) --铜钱
		needMoney = 4*level*mins
		if not CheckCost(sid,needMoney,1,3,"闭关铜钱领取") then
			return false,2 --铜钱不足
		end
	elseif(type == 2)then
		--hangupExp = mathfloor(hangupExp * 2) --元宝
		needMoney = mathfloor(hangupExp/100000)
		if(needMoney == 0)then needMoney = 1 end
		if not CheckCost(sid,needMoney,1,1,"闭关元宝领取") then
			return false,3 --元宝不足
		end
	else
		hangupExp = mathfloor(hangupExp/2)
	end
	PI_PayPlayer(1,hangupExp)
	
	if(type == 1)then
		CheckCost(sid,needMoney,0,3,"闭关铜钱领取")
	elseif(type == 2)then
		CheckCost(sid,needMoney,0,1,"100029_闭关元宝领取")
	end
	
	data[3] = 0
	data[4] = 0
	data[7] = 0
	return true,hangupExp,data[4],data[7]
end