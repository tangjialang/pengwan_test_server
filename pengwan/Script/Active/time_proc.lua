--
--	ͨ��ʱ�䴦��ϵͳ
--	Ŀ�ģ�ͳһ��������ʱ����ص��߼�
----------------------------------------

--[[
����˵��:
]]

-----------------------------------------------------------------
--include:
local TP_FUNC = type( function() end )
local pairs,ipairs,type ,tostring= pairs,ipairs,type,tostring
local os = os
local math_min,math_max = math.min,math.max

local _G = _G
local look = look
local SetEvent = SetEvent
local GetServerTime = GetServerTime
local GetServerID = GetServerID

local define = require('Script.cext.define')
local Server_Event = define.Server_Event
local common_time = require('Script.common.time_cnt')
local DAY_TIME = common_time.DAY_TIME
local GetTimeThisDay = common_time.GetTimeThisDay
local subTimeThisDay = common_time.subTimeThisDay
local getdatetime 	 = common_time.getdatetime
local getdatetimeex	 = common_time.getdatetimeex
local time_conf_m = require('Script.active.time_conf')
local common_time_config = time_conf_m.common_time_config
local common_time_config_kuafu = time_conf_m.common_time_config_kuafu
local event_module = require('Script.cext.event_list')
local event_list = event_module.event_list
local db_module = require('Script.cext.dbrpc')
local db_active_list = db_module.db_active_list
local IsSpanServer=IsSpanServer

------------------------------------------------------------------
--module:

module(...)

------------------------------------------------------------------
--inner:

-- ��ʼ����̬�¼���
local _g_active_static_table = event_list:new()

-- ��ʼ����̬�¼���
g_active_dynamic_table = g_active_dynamic_table or event_list:new()

-- ��Ӫ���ˢ����
is_init_active_dynamic = is_init_active_dynamic or 0


function active_gettable(  )
	g_active_dynamic_table = event_list:new()
	return g_active_dynamic_table
end
-- ʱ���ۼ��� ��������
local function _active_actives( event_list, trigger_func, this_tick_cnt )
	----look('_active_actives')
	if event_list == nil then return end
	event_list.tick_passed = event_list.tick_passed + this_tick_cnt 
	--look(event_list.tick_passed )
	while not event_list.events:empty() do
		local top = event_list.events:top()
		if top.ticks - event_list.tick_passed <=0 then
			event_list.events:pop()
			trigger_func( event_list, top, event_list.tick_passed)			
		else
			break
		end
	end
end

-- ��װ�¼����ú���
local function CallFun(event)
	local func = _G[event.data.func]
	if type(func) ~= TP_FUNC then
		return
	end
	func( event.data.arg )		
end

-- �����¼�������
local function _trigger_active_static( list, event, passed_ticks)
	----look('_trigger_active_static')
	----look(event)
	local flags = true
	if event.data.wLevel then
		local wLv = GetWorldLevel()
		if wLv < event.data.wLevel then
			flags = false
		end
	end
	
	if flags then
		-- �����Ƿ�������ĳһ�ܵ����ڼ���ִ�д����߼�
		if event.data.WeekDay and type(event.data.WeekDay) == type({}) then	-- ����ÿ�ܵ�ָ��������
			local CurTime = os.date("*t", GetServerTime())
			CurTime.wday = CurTime.wday - 1
			if CurTime.wday == 0 then
				CurTime.wday = 7
			end
			for _,v in pairs(event.data.WeekDay) do
				if CurTime.wday == v then
					CallFun(event)
					break
				end
			end
		else																-- ÿ�춼����
			CallFun(event)
		end
	end

	--�����������
	if event.data.everyday then
		local next_ticks = passed_ticks + DAY_TIME
		
		local valid = true
		local dateex = event.data.dateex
		if dateex then
			valid =  next_ticks <= ( getdatetime( dateex[2]) - list.begin )
		end
		
		if valid then
			list:add_event( next_ticks, event.data )
		end
	end
end

-- ע�ᾲ̬ʱ�����ñ��¼�
local function regist_event_static(et_table,now)
	local serverID = GetServerID()
	local belongThis = true
	if et_table.serverID and type(et_table.serverID) == type({}) then
		belongThis = false
		for _, id in pairs(et_table.serverID) do
			if id == serverID then
				belongThis = true
				break
			end
		end
	end
	if belongThis then
		if et_table.everyday then
			local ticks
			local dateex = et_table.dateex
			if dateex then
				local end_date_time = getdatetime( dateex[2] )							
				local first_trigger_time = math_max( getdatetimeex( dateex[1], et_table.everyday ),
												 GetTimeThisDay( now, et_table.everyday[1], et_table.everyday[2], et_table.everyday[3]) )
				if now > first_trigger_time then
					if et_table.keepTime and first_trigger_time + et_table.keepTime > now then --�������������ʱ���ڻ��ʼ�ͽ���ʱ��֮�䣬�����������¼�
						local func = _G[et_table.func]
						if "function" ~= type(func) then
							--rfalse(et_table.func.."����һ������")
						end
						func(et_table.arg)
					end
					first_trigger_time = first_trigger_time + DAY_TIME
				end
							
				if now <=first_trigger_time and first_trigger_time<=end_date_time then		
					ticks = first_trigger_time - now
				end
				-- look('ticks::' .. tostring(ticks),1)
			else
				ticks = subTimeThisDay( et_table.everyday[1], et_table.everyday[2], et_table.everyday[3] )
			end
			if ticks and type('')==type(et_table.func) then
				if ticks<0 then
					ticks = ticks + DAY_TIME
				end
				_g_active_static_table:add_event( ticks, et_table )
			end
		elseif et_table.Date then
			if type('')==type(et_table.func) then
				if et_table.Date[1] and et_table.Date[2] and et_table.Date[3] and et_table.Date[4] and et_table.Date[5] and et_table.Date[6] then
					local ConfigTick = getdatetime( et_table.Date )
					local Ticks = ConfigTick - now
					if Ticks >= 0 then						
						_g_active_static_table:add_event(Ticks, et_table)
					elseif et_table.keepTime and Ticks + et_table.keepTime >= 0 then --�������������ʱ���ڻ��ʼ�ͽ���ʱ��֮�䣬�����������¼�
						local func = _G[et_table.func]
						if "function" ~= type(func) then
							--rfalse(et_table.func.."����һ������")
						end
						func(et_table.arg)
					end
				end
			end
		end
	end
end

-- ��ʼ����̬ʱ���
local function _init_active_static()
	local now = GetServerTime()
	_g_active_static_table:set_begin( now )
	
	local time_conf_use
	if not IsSpanServer() then
		time_conf_use=common_time_config
	else
		time_conf_use=common_time_config_kuafu
	end

	for k, v in pairs(time_conf_use) do
		regist_event_static(v,now)
	end
end

-- ��Ӫ��¼���������
local function _trigger_active_dynamic( list, event, passed_ticks)
	-- �����Ƿ�������ĳһ�ܵ����ڼ���ִ�д����߼�
	if event.data.WeekDay and type(event.data.WeekDay) == type({}) then			-- ����ÿ�ܵ�ָ��������
		local CurTime = os.date("*t", GetServerTime())
		CurTime.wday = CurTime.wday - 1
		if CurTime.wday == 0 then
			CurTime.wday = 7
		end
		for _,v in pairs(event.data.WeekDay) do
			if CurTime.wday == v then
				CallFun(event)
				break
			end
		end
	elseif event.data.MonthDay and type(event.data.MonthDay) == type({}) then	-- ÿ��ָ������
		local CurTime = os.date("*t", GetServerTime())
		for _,v in pairs(event.data.MonthDay) do
			if CurTime.day == v then
				CallFun(event)
				break
			end
		end
	else																-- ÿ�춼����
		CallFun(event)
	end

	--�����������
	if event.data.eday then
		local next_ticks = passed_ticks + DAY_TIME		
		local valid = true
		local dateex = event.data.Date
		if dateex and dateex[2] then
			valid =  next_ticks <= ( getdatetimeex( dateex[2], event.data.eday ) - list.begin )
		end
		
		if valid then
			list:add_event( next_ticks, event.data )
		end
	end
end

-- ע����Ӫ� �ʱ�䴥���¼�
-- Ŀǰ�����ִ����¼�:
-- 1�����а��� (�콱ʱ�䴥��)
-- 2���ı���Ϸ������ (��ʼ������ʱ�䴥��)
local function _regist_event_dynamic(et_table,now,mainID)
	-- look(et_table)
	local serverID = GetServerID()
	local belongThis = true
	if et_table.serverID and type(et_table.serverID) == type({}) then
		belongThis = false
		for _, id in pairs(et_table.serverID) do
			if id == serverID then
				belongThis = true
				break
			end
		end
	end
	if belongThis == false then
		return
	end
	local Date = et_table.Date
	local ticks = nil
	if Date then
		-- ����������ӱ� ֱ��ע��(��������±�֤û��everyday�ֶ�)
		if type(Date[1]) == type(0) then	
			if et_table.Date[1] == nil or et_table.Date[2] == nil or et_table.Date[3] == nil or et_table.Date[4] == nil or et_table.Date[5] == nil or et_table.Date[6] == nil then
				return
			end
			local ConfigTick = getdatetime( et_table.Date )
			local Ticks = ConfigTick - now
			--rfalse("Ticks:" .. Ticks)
			if Ticks >= 0 then				
				g_active_dynamic_table:add_event(Ticks, et_table)
			end		
		-- ��������ӱ� ��Ҫע������ʱ�� ���Ա���ֳ��������ñ�
		elseif type(Date[1]) == type({}) then
			-- �����ÿ����� ������ʱֻ����edayҲ���ӱ�����
			local eDay = et_table.eday
			local ticks_beg = nil
			local ticks_end = nil
			-- --look(11111111)
			-- if et_table.arg==nil then
			-- 	--look(et_table)
			-- end
			if et_table.arg==nil then
				--look('et_table.arg error_mainID='..tostring(mainID),1)
				return
			end
			local arg_beg = {mainID,et_table.arg[1],1}
			local arg_end = {mainID,et_table.arg[2],0}
			if eDay then
				if type(eDay[1]) == type({}) then		-- eday ��Ҫע�������¼�
					local beg_table = { eday = eDay[1], Date = Date, func = "OnActiveEvent", arg = arg_beg }
					local end_table = { eday = eDay[2], Date = Date, func = "OnActiveEvent", arg = arg_end }
					
					local end_trigger_time = math_min( getdatetimeex( Date[2], eDay[2] ),
													 GetTimeThisDay( now, eDay[2][1], eDay[2][2], eDay[2][3]) )
					local beg_trigger_time = math_min( math_max( getdatetimeex( Date[1], eDay[1] ),
													 GetTimeThisDay( now, eDay[1][1], eDay[1][2], eDay[1][3]) ),
														getdatetimeex( Date[2], eDay[1] ) )
					
					-- �Ѿ���������ʱ�� ����ע��
					-- �ȼ�����ж��ܱ�֤������õ�end_trigger_time > end_date_time ����ע���¼�
					local end_date_time = getdatetime( Date[2] )
					if now >= end_date_time then
						return
					end
					
					-- �����û����ʼʱ�� (ע�Ὺʼ�ͽ����¼�)
					if now <= beg_trigger_time then
						ticks_beg = beg_trigger_time - now
						-- rfalse("ticks_beg:" .. ticks_beg)
						g_active_dynamic_table:add_event( ticks_beg, beg_table )
						ticks_end = end_trigger_time - now
						-- rfalse("ticks_end:" .. ticks_end)
						g_active_dynamic_table:add_event( ticks_end, end_table )
					-- ʱ�����ÿ��Ŀ�ʼ�ͽ���ʱ��֮�� (ֱ�ӵ��ÿ�ʼ�¼�������ע������¼�)
					elseif beg_trigger_time < now and now < end_trigger_time then
						local func = _G[beg_table.func]
						if TP_FUNC ~= type(func) then
							-- rfalse(beg_table.func.."����һ������")
						end
						func(arg_beg)
						beg_trigger_time = beg_trigger_time + DAY_TIME
						
						-- �����������ʱ��û���� ��ôע�Ὺʼ�¼�
						if beg_trigger_time >= now and beg_trigger_time <= end_trigger_time then
							ticks_beg = beg_trigger_time - now
							g_active_dynamic_table:add_event( ticks_beg, beg_table )
						end
						
						-- ע������¼�
						ticks_end = end_trigger_time - now
						-- rfalse("ticks_end:" .. ticks_end)
						g_active_dynamic_table:add_event( ticks_end, end_table )
					end	
				else				-- eday ֻ��Ҫע��һ���¼�
					local beg_table = { eday = eDay, Date = Date, func = "OnActiveEvent", arg = arg_beg }
										
					local beg_trigger_time = math_min( math_max( getdatetimeex( Date[1], eDay ),
													 GetTimeThisDay( now, eDay[1], eDay[2], eDay[3]) ),
														getdatetimeex( Date[2], eDay ) )
					
					local end_date_time = getdatetime( Date[2] )
					if now >= end_date_time then
						return
					end
					
					if now <= beg_trigger_time then
						ticks_beg = beg_trigger_time - now
						-- rfalse("ticks_beg:" .. ticks_beg)
						g_active_dynamic_table:add_event( ticks_beg, beg_table )
					else
						beg_trigger_time = beg_trigger_time + DAY_TIME
						if beg_trigger_time >= now and beg_trigger_time <= end_date_time then
							ticks_beg = beg_trigger_time - now
							g_active_dynamic_table:add_event( ticks_beg, beg_table )
						end
					end
				end
			else
				local beg_table = { Date = Date, func = "OnActiveEvent", arg = arg_beg }
				local end_table = { Date = Date, func = "OnActiveEvent", arg = arg_end }
				ticks_beg = getdatetime( Date[1] )
				ticks_end = getdatetime( Date[2] )
				if now <= ticks_beg then
					ticks_beg = ticks_beg - now
					--look(ticks_beg..'_���ע���¼�---------')
					g_active_dynamic_table:add_event( ticks_beg, beg_table )
					ticks_end = ticks_end - now
					g_active_dynamic_table:add_event( ticks_end, end_table )
					----look(g_active_dynamic_table)
				elseif ticks_beg < now and now < ticks_end then
					--look('����ע��')
					local func = _G[beg_table.func]
					if TP_FUNC ~= type(func) then
						-- rfalse(beg_table.func.."����һ������")
					end
					func(arg_beg)
					ticks_end = ticks_end - now
					look('ticks_end:' .. tostring(ticks_end))
					g_active_dynamic_table:add_event( ticks_end, end_table )
				end
			end
		end
	else
		-- ������Լ���ֻ��everyday ����� ��ʱ��д��
	end	
end

local function _active_dynamic_refresh()
--	g_active_dynamic_table = event_list:new( )
	db_active_list()
end

local function _init_active_dynamic()			
	if is_init_active_dynamic == 0 then
		_active_dynamic_refresh()
		is_init_active_dynamic = 1
	end
end

--�������ʱ��
local function _start_active_timer()	
	local timer_tick = 1
	SetEvent( timer_tick,Server_Event.Actives, "SI_UpdateActiveTimer",timer_tick)
end

----------------------------------------------------------------
--interface:

-- ��ʼ��ʱ�����ñ����¼�
g_active_static_table = _g_active_static_table
init_active_static = _init_active_static
init_active_dynamic = _init_active_dynamic
active_dynamic_refresh = _active_dynamic_refresh
regist_event_dynamic = _regist_event_dynamic
trigger_active_static = _trigger_active_static
trigger_active_dynamic = _trigger_active_dynamic
start_active_timer = _start_active_timer
active_actives = _active_actives