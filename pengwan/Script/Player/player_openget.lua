--[[
file:	player_openget.lua
desc:	�����ۻ���½���� & ÿ���׳�
author:	xy
]]--
--------------------------------------------------------------------------
--include:
local Player_7day_data = msgh_s2c_def[3][18]
local Player_everyday_sc = msgh_s2c_def[3][20]
local Player_everyday_sc_err = msgh_s2c_def[3][21]
local isFullNum = isFullNum
local SendLuaMsg = SendLuaMsg
local GetDBActiveData = GetDBActiveData
local GiveGoodsBatch = GiveGoodsBatch
local GI_GetVIPType = GI_GetVIPType
local osdate = os.date
local GetServerOpenTime = GetServerOpenTime
local GetServerTime = GetServerTime
local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond
local mathfloor = math.floor
local uv_TimesTypeTb = TimesTypeTb
local CheckTimes = CheckTimes
local award_check_items = award_check_items
local GI_GiveAward = GI_GiveAward
--------------------------------------------------------------------------
-- data:
--���콱������
local sevenLoginConf = {
	[1] = {
		[1] = {{601,10,1},{644,20,1},{638,20,1},{768,1,1}}, --��ͨ
		[2] = {{625,1,1},{636,10,1},{601,50,1},}, --VIP
	},
	[2] = {
		[1] = {{601,15,1},{603,15,1},{605,10,1},{768,1,1}}, --��ͨ
		[2] = {{625,1,1},{636,10,1},{601,50,1},}, --VIP
	},
	[3] = {
		[1] = {{601,20,1},{603,20,1},{51,3,1},{199,1,1}}, --��ͨ
		[2] = {{625,1,1},{636,10,1},{601,50,1},}, --VIP
	},
	[4] = {
		[1] = {{601,25,1},{603,25,1},{636,10,1},{634,10,1},{768,1,1}}, --��ͨ
		[2] = {{625,1,1},{636,10,1},{601,50,1},}, --VIP
	},
	[5] = {
		[1] = {{601,30,1},{603,30,1},{693,10,1},{692,10,1},{768,1,1}}, --��ͨ
		[2] = {{625,1,1},{636,10,1},{601,50,1},}, --VIP
	},
	[6] = {
		[1] = {{601,35,1},{603,35,1},{691,10,1},{642,1,1},{768,1,1}}, --��ͨ
		[2] = {{625,1,1},{636,10,1},{601,50,1},}, --VIP
	},
	[7] = {
		[1] = {{601,50,1},{603,50,1},{663,1,1},{302,1,1},{768,1,1}}, --��ͨ
		[2] = {{625,1,1},{636,10,1},{601,50,1},}, --VIP
	},
}

--ÿ���׳����� 	1����2����3����4��Ԫ��5����6��ṱ��7ս��
local sc_every_cof = {
	[1] = {
		[3] = {{710,2,1},{713,1,1},{3021,1,1},{52,1,1}},
		[1] = 300000,
		[5] = 300000,
	},
	[2] = {
		[3] = {{636,5,1},{627,20,1},{3024,1,1},{52,1,1}},
		[1] = 300000,
		[5] = 300000,
	},
	[3] = {
		[3] = {{625,1,1},{626,20,1},{3030,1,1},{52,1,1}},
		[1] = 300000,
		[5] = 300000,
	},
	[4] = {
		[3] = {{634,5,1},{635,5,1},{3027,1,1},{52,1,1}},
		[1] = 300000,
		[5] = 300000,
	},
	[5] = {
		[3] = {{762,5,1},{765,2,1},{3065,1,1},{52,1,1}},
		[1] = 300000,
		[5] = 300000,
	}
}

--��ȡ7���¼��������,���ڻ������
function login_7day_getdata(sid)
	local adata=GetDBActiveData( sid )
	if adata==nil then return end
	if adata.kflog==nil then
		adata.kflog={} 
		--[1] ��ǰ��ȡ�Ľ������� 1 ��ͨ 2 VIP 
		--[2] �Ѿ���ȡ�˼���
	end
	return adata.kflog
end
--��ȡ7���¼����
function login_7day_get_gift(sid)
	local data = login_7day_getdata(sid)
	if(data == nil)then return false,0 end --��ȡ���ݳ���
	
	local vip = GI_GetVIPType(sid)
	
	local giftTb
	local giftIdx
	if(vip == 0 or vip == 1)then
		giftIdx = 1 --��������
	else
		giftIdx = 2
	end
	
	local curGet = data[2] == nil and 0 or data[2]
	if(data[1] == nil)then --�����һ����
		curGet = curGet + 1
	else
		if(data[1]>=giftIdx)then return false,1 end --����ȡ��
	end
	
	local first = data[1] == nil and 1 or data[1]+1
	local giftTb
	local pakagenum
	local issend = false
	while(first<=giftIdx)do
		if(sevenLoginConf[curGet] == nil or sevenLoginConf[curGet][first] == nil)then
			if(issend)then
				SendLuaMsg( 0, { ids = Player_7day_data,data = data}, 9 )
			end
			return false,2 
		end --û�н���������ȡ
		giftTb = sevenLoginConf[curGet][first]
		pakagenum = isFullNum()
		if pakagenum < #giftTb then
			if(issend)then
				SendLuaMsg( 0, { ids = Player_7day_data,data = data}, 9 )
			end
			return false,3 
		end --�����ո���
		
		GiveGoodsBatch(giftTb,"��д�ĵ�½7�콱��")
		data[1] = first
		data[2] = curGet
		issend = true
		first = first+1
	end

	SendLuaMsg( 0, { ids = Player_7day_data,data = data}, 9 )
	
	return true
end
--ÿ��������ȡ
function login_7day_reset(sid)
	local data = login_7day_getdata(sid)
	if data == nil or data[1] == nil then return end
	data[1] = nil
	SendLuaMsg( 0, { ids = Player_7day_data,data = data}, 9 )
end

--ÿ��������ȡ
function login_7day_clear(sid)
	local data = login_7day_getdata(sid)
	if data ~= nil then
		data[1] = nil
		data[2] = nil
	end
	SendLuaMsg( 0, { ids = Player_7day_data,data = data}, 9 )
end

---------------------ÿ���׳�---------------------------
--��ȡȡÿ���׳佱��
function get_sc_everyday(sid)
	local isget = CheckTimes(sid,uv_TimesTypeTb.sc_everyday,1,-1,1)
	if(not isget)then --��������ȡ��
		--��������ȡ��
		SendLuaMsg( 0, { ids = Player_everyday_sc_err,err = 1}, 9 )
		return
	end

	local svrTime = GetServerOpenTime() --����ʱ��
	local dt = osdate("*t", svrTime)
	local sec = GetTimeToSecond(dt.year,dt.month,dt.day,0,0,0)
	local now = GetServerTime()
	dt = osdate("*t", now)
	local days = mathfloor((now - sec)/(24*60*60))
	if(days <= 0)then
		--������2�����
		SendLuaMsg( 0, { ids = Player_everyday_sc_err,err = 2}, 9 )
		return
	end
	
	local today = dt.year..'-'..dt.month..'-'..dt.day
	Getbuyfillinfo(sid,today..' 00:00:00',today..' 23:59:59',6)
end
--��ȡÿ���׳佱��
function get_sc_everyday_gift(sid,num)
	if(num<=0)then
		--�����Ƿ��ֵ
		SendLuaMsg( 0, { ids = Player_everyday_sc_err,err = 5}, 9 )
		return
	end

	local isget = CheckTimes(sid,uv_TimesTypeTb.sc_everyday,1,-1,1)
	if(not isget)then --��������ȡ��
		--��������ȡ��
		SendLuaMsg( 0, { ids = Player_everyday_sc_err,err = 1}, 9 )
		return
	end
	
	local svrTime = GetServerOpenTime() --����ʱ��
	local dt = osdate("*t", svrTime)
	local sec = GetTimeToSecond(dt.year,dt.month,dt.day,0,0,0)
	local now = GetServerTime()
	local days = mathfloor((now - sec)/(24*60*60))
	if(days <= 0)then
		--������2�����
		SendLuaMsg( 0, { ids = Player_everyday_sc_err,err = 2}, 9 )
		return
	end
	local len = #sc_every_cof
	local idx = mathfloor((days-1)%len)+1
	local giftTb = sc_every_cof[idx]
	if(giftTb==nil)then
		--���ó���
		SendLuaMsg( 0, { ids = Player_everyday_sc_err,err = 3}, 9 )
		return
	end
	
	if(giftTb[3]~=nil)then --�е��߽���
		if(not award_check_items( giftTb ))then
			SendLuaMsg( 0, { ids = Player_everyday_sc_err,err = 4}, 9 )
			return
		end
	end
	
	--1����2����3����4��Ԫ��5����6��ṱ��7ս��
	GI_GiveAward(sid, giftTb, 'ÿ���׳佱��'..idx)
	CheckTimes(sid,uv_TimesTypeTb.sc_everyday,1,-1)
	SendLuaMsg( 0, { ids = Player_everyday_sc,data = idx}, 9 )
end

