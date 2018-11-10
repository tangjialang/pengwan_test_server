--[[
file:	player_wage.lua
desc:	����
author:	xiao.Y
update:	2011-12-13
]]--
--------------------------------------------------------------------------
--include:
local GI_GetPlayerData = GI_GetPlayerData
local GetHangUpData = GetHangUpData
local mathfloor = math.floor
local osdate = os.date
local GetServerTime = GetServerTime
local Player_Wage = msgh_s2c_def[3][16]
local uv_TimesTypeTb = TimesTypeTb
local CheckTimes = CheckTimes
local look = look
local GiveGoods = GiveGoods
-------------------------------------------------------------------------
-- data:

--[[
�������ݽṹ
wage = {
	[1] = δ���ۼ�Ԫ��
	[2] = �����ѩ���Ԫ����
	[3] = ��������Ԫ����
	[4] = Ͷ�ʴ��������10��
	[5] = ��ȡ��н���·�
	[6]	= ǩ������
	[7]	= ��ǩ����
	[8] = ��ȡ�����ļ�¼
}
]]--

--ǩ����������
local wage_login_conf = {
	t = 3, --һ���¿����ǩ���Ĵ���
	cost = 10, --ǩ�����ѵ�Ԫ��
	[2] = {{601,10},{52,1},{612,1}},
	[5] = {{601,15},{636,10},{1,5}},
	[10] = {{601,20},{634,20},{635,3},{642,5}},
	[17] = {{601,25},{676,10},{51,3},{614,5},{2,5}},
	[26] = {{601,30},{640,20},{666,1},{621,1},{618,3}},
}

--��ȡ��������					  
local function _get_player_wage_data(sid)
	local data=GI_GetPlayerData( sid , 'wage' , 250 )
	if data == nil then return end
	return data
end

--���͸��˹�������
function send_player_wage(sid)
	local data = _get_player_wage_data(sid)
--[[
�������ݽṹ
wage = {
	[1] = δ���ۼ�Ԫ��
	[2] = �����ѩ���Ԫ����
	[3] = ��������Ԫ����
	[4] = Ͷ�ʴ��������10��
	[5] = ��ȡ��н���·�
	[6]	= ǩ������
	[7]	= ��ǩ����
	[8] = ��ȡ�����ļ�¼
	[9] = ǩ�����·�
}

	data[1] = 0
	data[2] = 0
	data[3] = 0
	data[4] = 0
	data[5] = nil
	data[6] = 0
	data[7] = 0
	data[8] = nil
	]]--
	
	local now = GetServerTime()
	local dt = osdate("*t", now)
	local d = dt.day
	
	local loginMonth = dt.year*100 + dt.month
	if(data and (data[9] == nil or data[9]~=loginMonth))then --�������ݳ�ʼ
		data[9] = loginMonth
		data[6] = 0
		data[7] = 0
		data[8] = nil
	end
	if(data and data[5] == nil)then data[5] = loginMonth end
	SendLuaMsg( 0, { ids = Player_Wage,data = data}, 9 )
end

--����������ӱ�������ʱ���ۼӵĹ��� times �����ۼ�����ʱ��
function add_player_wage(sid,times)
	if(times~=nil)then
		local hours = mathfloor(times/3600)
		if(hours>0)then
			if(hours>12)then hours = 12 end --���12Сʱ
			local data = _get_player_wage_data(sid)
			if(data)then
				if(data[1] == nil)then data[1] = 0 end
				if(data[3] == nil)then data[3] = 0 end
				--��ȡ����ʱ�䣬�����ۼӵ�Ԫ����
				local svrTime = GetServerOpenTime() --����ʱ��
				local now = GetServerTime()
				local temp_times = now - svrTime
				local svrDays = mathfloor(temp_times/(24*60*60))
				if(svrDays<=30)then --10Ԫ��
					data[1] = data[1] + 10*hours
					data[3] = data[3] + 10*hours
				elseif(svrDays<=60)then --15Ԫ��
					data[1] = data[1] + 15*hours
					data[3] = data[3] + 15*hours
				else --20Ԫ��
					data[1] = data[1] + 20*hours
					data[3] = data[3] + 20*hours
				end
				
				if(data[3]>0 and data[5] == nil)then
					local now = GetServerTime()
					local dt = osdate("*t", now)
					data[5] = dt.year*100 + dt.month
				end
			end
		end
	end
end

--��ȡ�չ��� t 0 ȫ���� 1 ��һ�� 2 ����н
function  get_player_wage_day(sid,t)
	if(t == 0 or t == 1)then
		if(not CheckTimes(sid,uv_TimesTypeTb.wage,1,-1,1))then
			return false,1
		end
	end

	local money = 0
	local svrTime = GetServerOpenTime() --����ʱ��
	local now = GetServerTime()
	local temp_times = now - svrTime
	local temp_days = 0
	if(temp_times>=0)then --��ǰ�����Աȿ���ʱ��С��
		temp_days = mathfloor(temp_times/(24*60*60))
		if(temp_days<1)then
			--�������죬��120��Ԫ��
			local dt = osdate("*t", now)
			local dt1 = osdate("*t", svrTime)
			if(dt.day == dt1.day)then
				money = 120
			end
		end
	end
	
	local data = _get_player_wage_data(sid)
	if(data == nil)then return false,0 end --�޹��ʿ���
	if(data[1]~=nil)then
		money = money + data[1]
	end
	if(t == 0)then --ȫ����
		if(data[2]~=nil)then --Ͷ�ʵ�Ԫ����2.5��
			money = money + mathfloor(2.5*data[2])
		end
		
		if(money == 0)then return false,0 end
		if(money > 6000)then money = 6000 end --���յ��ж�
		
		AddPlayerPoints(sid,3,money,nil,'�չ�����ȡ')
		data[1] = 0
		data[2] = nil
		
		CheckTimes(sid,uv_TimesTypeTb.wage,1,-1)
	elseif(t == 1)then --��һ��
		if(money == 0)then
			return false,0
		end

		if(temp_days>10)then
			return false,10
		end
		
		if(data[4]~=nil and data[4]>=10)then
			return false,1 --��ѩ�򳬹�10��
		end
		if(data[2] == nil)then data[2] = 0 end
		money = mathfloor((money+mathfloor(data[2]*2.5))/2)
		
		if(money == 0)then return false,0 end
		
		AddPlayerPoints(sid,3,money,nil,'�չ�����һ��')
		data[1] = 0
		data[2] = money
		data[4] = data[4] == nil and 1 or data[4]+1
		
		CheckTimes(sid,uv_TimesTypeTb.wage,1,-1)
	else
		local now = GetServerTime()
		local dt = osdate("*t", now)
		if(data[5] ~= nil)then
			if(data[5] == (dt.year*100 + dt.month))then
				return false,2 --���µ���н�¸�����
			end
		end
		
		if(data[3] == nil or data[3] == 0)then return false,3 end --û����н
		
		AddPlayerPoints(sid,3,data[3]*3,nil,'��ȡ��')
		
		data[3] = nil
		data[5] = dt.year*100 + dt.month
	end
	
	SendLuaMsg( 0, { ids = Player_Wage,data = data, t = 2, tp = t}, 9 )
end

--�Ƿ�bit����ǩ����
local function _is_login_day(data,bit)
	local val = mathfloor(data/(2^(bit-1)))
	--look('-------------------------')
	--look('data'..data)
	--look('val'..(2^(bit-1)))
	--look(val)
	local val = mathfloor(val%2)
	--look(val)
	return val == 1 
end

--ͳ��ǩ���˶�����
local function _total_login_day(data)
	local days = 0
	local val
	for i =1,31 do
		val = mathfloor(mathfloor(data/(2^(i-1)))%2)
		if(val == 1)then
			days = days + 1
		end
	end
	return days
end

--ǩ������
local function _set_login_day(data,bit)
	local val = mathfloor((2^(bit-1)))
	--look('data'..data)
	--look('val'..val)
	data = data + val
	return data
end

function clear_wage_data(sid)
	local data = _get_player_wage_data(sid)
	if(data ~= nil)then
		data[6] = 0
		data[7] = 0
		data[8] = nil
	end
end

--��ռ�����ʱ����
function set_login_fun(sid)
	local data = _get_player_wage_data(sid)
	if(data == nil)then return end
	local loginData = data[6]
	if(loginData~=nil)then
		local now = GetServerTime()
		local dt = osdate("*t", now)
		local d = dt.day
		if(_is_login_day(loginData,d))then
			CheckTimes(sid,uv_TimesTypeTb.Login_Time,1,-1)
		end
	end
end

--ǩ�� d ǩ������ t ��Ԫ�� 0 ��� 1 ��Ԫ��
function get_player_wage_login(sid,cd,t)
	--clear_wage_data(sid)
	--look('---------------------------'..cd..','..t)
	local data = _get_player_wage_data(sid)
	--look(data)
	if(data == nil)then return false,4 end --�������� 

	if(data[6] == nil)then data[6] = 0 end
	local now = GetServerTime()
	local dt = osdate("*t", now)
	local d = dt.day
	local newData
	
	local loginMonth = dt.year*100 + dt.month
	if(data[9] == nil or data[9]~=loginMonth)then 
		data[9] = loginMonth
		data[6] = 0
		data[7] = 0
		data[8] = nil
	end
	local loginData = data[6]
	
	if(cd>d)then return false,5 end --����ǩδ���ĵ�
	
	if(cd<d)then --��ǩ
		if(_is_login_day(loginData,cd))then return false,6 end --�����Ѿ�ǩ����
		local vipLv = GI_GetVIPLevel(sid)
		local viptime = 0
		if(vipLv == 2 or vipLv == 3)then
			viptime = 1
		elseif(vipLv>=4)then
			viptime = 2
		end
		--look('t===='..t)
		if(data[7]>=(wage_login_conf.t+viptime))then
			if(t == 1)then
				if(not CheckCost(sid,wage_login_conf.cost,0,1,'100031_Ԫ��ǩ��'))then
					return false,7 --Ԫ������
				end
			else
				return false,9 --��Ѳ�ǩ��������
			end
		else
			data[7] = data[7] + 1
		end
		loginData = _set_login_day(loginData,cd)
	else
		if(_is_login_day(loginData,d))then return false,6 end --�����Ѿ�ǩ����
		loginData = _set_login_day(loginData,cd)
	end
	local days = _total_login_day(loginData)
	if(wage_login_conf[days]==nil)then
		days = nil
	end
	CheckTimes(sid,uv_TimesTypeTb.Login_Time,1,-1) --ÿ��ǩ��ÿ����������
	data[6] = loginData
	
	return true,data,days
end

--��ȡǩ���Ľ���
function get_player_wage_goods(sid,t)
	local data = _get_player_wage_data(sid)
	if(data == nil)then return false,4 end --��������
	local now = GetServerTime()
	local dt = osdate("*t", now)
	local d = dt.day
	local loginMonth = dt.year*100 + dt.month
	if(data[9] == nil or data[9]~=loginMonth)then 
		data[9] = loginMonth
		data[6] = 0
		data[7] = 0
		data[8] = nil
		return false,11 --�޽�������
	end
	
	local loginData = data[6]
	local days = _total_login_day(loginData)
	if(days<t or wage_login_conf[t] == nil or (data[8]~=nil and data[8][t]~=nil))then return false,11 end --�޽�������
	
	local pakagenum = isFullNum()
	if pakagenum < #wage_login_conf[t] then return false,8 end --�����ո���
	if(data[8] == nil)then data[8] = {} end
	data[8][t] = 1
	for _,v in pairs(wage_login_conf[t]) do
		GiveGoods(v[1],v[2],1,"ǩ������")
	end
	
	return true,data
end

