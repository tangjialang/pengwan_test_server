--[[
file:	player_hangup.lua
desc:	�չ�����
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

--���ͱչ�ʱ��
-- function SendHangUp(sid)
	-- local data = GetHangUpData(sid)
	-- if(data~=nil and data[1]~=nil)then
		-- SendLuaMsg( 0, { ids=BG_Time ,t = data[1] }, 9 )
	-- end
-- end

--΢�˵�¼����
function player_client_login(sid)
	CI_AddBuff(95,0,1,true)
end

--��ȡ�չ�ʱ��
function GetHangUpData(sid)
	local dayData 	= GetPlayerDayData(sid)
	--time 1 ���߳齱ʱ���,2 �ھ��齱�Ľ׶� 3 ��¼����ʱ�� 4 ���߼�������ʱ��������ʱ�Σ� 5 ���һ������ʱ�� 6 ÿ�������ۼ�ʱ�� 7 ���߼�������ʱ����3��ʱ�Σ�
	dayData.time = dayData.time or {}	-- ÿ�����߳齱ʱ������
	return dayData.time
end

--���߼�¼����ʱ��,���㱾���ۼ�����ʱ��
function SetLogoutHangUpData(sid)
	local dayData 	= GetPlayerDayData(sid)
	if(dayData~=nil)then
		dayData.time = dayData.time or {}	-- ÿ�����߳齱ʱ������
		dayData.time[3] = GetServerTime()
		--look('--���߼�¼����ʱ��')
		--look(dayData.time)
		if(dayData.time[5]~=nil)then
			if(dayData.time[6] == nil)then dayData.time[6] = 0 end 
			dayData.time[6] = dayData.time[6] + (dayData.time[3] - dayData.time[5])
		end
		return dayData.time
	end
end

--��¼���һ������ʱ�� t nil Ҫ����ۼ�ʱ�� 1 �����ۼ�ʱ��
function set_login_time_last(sid,t)
	local dayData 	= GetPlayerDayData(sid)
	dayData.time = dayData.time or {}	-- ÿ�����߳齱ʱ������
	local srvTime = GetServerTime()
	if(t == nil)then --ÿ�����õ���
		local temp = dayData.time[6]
		if(temp == nil)then temp = 0 end
		if(dayData.time[5]~=nil )then
			local tempSec = GetTimeThisDay( dayData.time[5], 23,59,59)
			if(tempSec<=srvTime)then
				temp = temp + tempSec - dayData.time[5]
				add_player_wage(sid,temp) --����������Ҫ��Ԫ��
			end
		end
		dayData.time[6] = 0
	else
		if(dayData.time[6] == nil)then dayData.time[6] = 0 end
	end
	dayData.time[5] = srvTime
	--look('--���߼�¼����ʱ��')
	--look(dayData.time)
	return dayData.time
end

--���߼�������ʱ��(24����8�㣬3�����飩
function SetLoginHangUpData(sid)
	local dayData 	= GetPlayerDayData(sid)
	dayData.time = dayData.time or {}	-- ÿ�����߳齱ʱ������
	if(dayData.time[3] ~= nil and dayData.time[3]>0)then
		local oldsec = dayData.time[3]
		local olddt = osdate("*t", oldsec)
		local cursec = GetServerTime()
		local curdt = osdate("*t", cursec)
		local elsesec = 0
		if((cursec - oldsec)>(24*60*60))then --����һ��
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
		if(curHours<8)then --��3��ʱ��������
			totalSecs = curHours*60*60 + curMins*60 + curSecs
			--look('---'..totalSecs)
			if(totalSecs>=elsesec)then --ȫ��3������ʱ��
				if(dayData.time[7] == nil)then
					dayData.time[7] = elsesec
				else
					dayData.time[7] = dayData.time[7] + elsesec
				end
			else --��1����ʱ��
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
		else --��1��ʱ��������
			totalSecs = (curHours-8)*60*60 + curMins*60 + curSecs
			if(totalSecs>=elsesec)then --ȫ��1������ʱ��
				if(dayData.time[4] == nil)then
					dayData.time[4] = elsesec
				else
					dayData.time[4] = dayData.time[4] + elsesec
				end
			else --��3����ʱ��
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
	--look('--���߼�������ʱ��')
	--look(dayData.time)
	return dayData.time
end

--type 0 ��� 1 ͭǮ 2 Ԫ��
function GetHangUpExp( sid , type )
	local data = GetHangUpData(sid)
	if(data == nil or (data[4] == nil and data[7] == nil))then return false,0 end --��ȡ�չ�����ʧ��
	local times = data[4] or 0 --1��ʱ��
	local times1 = data[7] or 0 --3��ʱ��
	if(times == 0 and times1 == 0)then return false,1 end
	
	local mins = mathfloor(times/60)
	local mins1 = mathfloor(times1/60)
	if(mins<0)then mins = 0 end
	if(mins1<0)then mins1 = 0 end
	if(mins==0 and mins1==0)then return false,1 end --ʱ������
	
	if(mins>168*60)then mins = 168*60 end --����ۻ�24Сʱ
	if(mins1>=168*60)then
		mins1 = 168*60
		mins = 0
	elseif(mins1>0 and (mins+mins1)>168*60)then
		mins = 168*60 - mins1
	end --����ۻ�24Сʱ
	
	--look('mins='..mins)
	
	local level = CI_GetPlayerData(1)
	local tempExp = mathfloor((level^2.7)/28) --�ȼ�^1.6*1.2*6
	if(tempExp<50)then tempExp = 50 end
	local hangupExp = mathfloor(tempExp*mins*2)
	local hangupExp1 = mathfloor(tempExp*mins1*2*3)
	hangupExp = hangupExp + hangupExp1
	if(hangupExp>130000000)then
		hangupExp = 130000000
	end
	local needMoney = 0
	if(type == 1)then
		--hangupExp = mathfloor(hangupExp * 2) --ͭǮ
		needMoney = 4*level*mins
		if not CheckCost(sid,needMoney,1,3,"�չ�ͭǮ��ȡ") then
			return false,2 --ͭǮ����
		end
	elseif(type == 2)then
		--hangupExp = mathfloor(hangupExp * 2) --Ԫ��
		needMoney = mathfloor(hangupExp/100000)
		if(needMoney == 0)then needMoney = 1 end
		if not CheckCost(sid,needMoney,1,1,"�չ�Ԫ����ȡ") then
			return false,3 --Ԫ������
		end
	else
		hangupExp = mathfloor(hangupExp/2)
	end
	PI_PayPlayer(1,hangupExp)
	
	if(type == 1)then
		CheckCost(sid,needMoney,0,3,"�չ�ͭǮ��ȡ")
	elseif(type == 2)then
		CheckCost(sid,needMoney,0,1,"100029_�չ�Ԫ����ȡ")
	end
	
	data[3] = 0
	data[4] = 0
	data[7] = 0
	return true,hangupExp,data[4],data[7]
end