--[[
file:	TimesMgr_func.lua
desc:	�����������ӿ�
author:	csj
update:	

notes:
	1���������������������仯��ʱ���߼������Ͻ� ��ֹ�������޴���
	2������������������ʱ������������������ʵʱͬ�� ������һ���Ժܶ��ֶλ�仯�����ݲ��˷�������������ʵʱͬ�� ��Ϊ��������ɷ��ͺܶ���Ƭ��Ϣ��

���Ż�:
	1����ҳ�ʼ��ʱ��������λ��������֤����ҵĴ���������������С
	2��������αȽϼ򵥵��������VIP�ȼ��仯ʱ������ʱ����
]]--

local pairs,tostring,type = pairs,tostring,type
local ipairs = ipairs
local look = look
local achieve = require('Script.achieve.fun')
local set_data = achieve.set_data
local db_module = require('Script.cext.dbrpc')
local db_times_log = db_module.db_times_log

--s2c_msg_def
local TMS_Data = msgh_s2c_def[25][1]	-- ���д�������
local TMS_Sync = msgh_s2c_def[25][2]	-- ������������


local uv_TimesConfig = TimesConfig

-------------------------------------------------------------------
--inner function:

-- ��������������
local function GetDBTimesMgrData( playerid )
	local TimesMgr_data=GI_GetPlayerData( playerid , 'Tmgr' , 700 )
	if TimesMgr_data == nil then return end
	if TimesMgr_data.tc==nil then
		TimesMgr_data.tc={}		-- [1] ÿ��ͳ��ʹ�ô��� [2] ����ʣ����� [3] �ѹ������
		TimesMgr_data.ts={}		-- ���ü�¼ͳ�ƴ��� ��Ҫ���ڳɾʹ���	
	end
	--look(tostring(TimesMgr_data))
	--look(TimesMgr_data)
	return TimesMgr_data
end

-- ��ȡ���ô���
-- vipLv VIP�ȼ�
-- ctype ��������
-- ����ֵ�����ô��� �ɹ������
local function GetResetTimes(sid,ctype,vipLv)
	local tconf = uv_TimesConfig[ctype]
	if tconf == nil then return end
	-- Ĭ�ϸ���VIPLV����
	local cond = vipLv or GI_GetVIPLevel(sid)
	
	if tconf.setType == 1 then		--���ݰ��ɽ���(8)�ȼ�����
		cond = CI_GetFactionInfo(nil,8)
	elseif tconf.setType == 2 then		--������������ȼ���������
		cond = get_preslv(sid) or 0
	end
	if cond == nil then return end
	local lower = table.locate(tconf, cond, 1)
	if lower == nil then return end
	
	return tconf[lower][1], tconf[lower][2]
end

local function ResetTimes(sid,ctype,tconf)	
	if tconf == nil or tconf.countType == nil then return end
	-- �жϵȼ�
	-- if tconf.nlv then
		-- local level = CI_GetPlayerData(1,2,sid)
		-- if level < tconf.nlv then
			-- return
		-- end
	-- end
	local pTimesMgr = GetDBTimesMgrData(sid)
	if pTimesMgr == nil or pTimesMgr.tc == nil then 
		return
	end 
	local timesCache = pTimesMgr.tc
	if timesCache[ctype] == nil then
		timesCache[ctype] = {}
	end
	
	-- Ĭ�ϸ���VIPLV����
	local cond = GI_GetVIPLevel(sid)
	-- look('cond'..ctype..':'..cond)
	if tconf.setType == 1 then			--���ݰ��ɽ���(8)�ȼ�����
		cond = CI_GetFactionInfo(nil,8)
		if cond == nil then cond=0 end
	elseif tconf.setType == 2 then		--������������ȼ���������
		cond = get_preslv(sid) or 0
	end
	if cond == nil then return end

	local lower = nil
	-- ����ÿ��ͳ�ƴ���
	if tconf.countType >= 0 and tconf.countType ~= 1 then		
		timesCache[ctype][1] = nil								-- ����ͳ�� ÿ�����ó� nil
	end
	-- ����ʣ�����
	local lower = table.locate(tconf, cond, 1)
	-- look('lower'..ctype..':'..lower)
	-- ʣ����� ͬ��ǰ���߼�С�ڲ����� �ܱ�֤��������²�����յ��ѹ���Ĵ���
	if lower ~= nil and tconf[lower] ~= nil then				
		if tconf[lower][1] ~= nil then		
			if timesCache[ctype][2] == nil or timesCache[ctype][2] < tconf[lower][1] then
				timesCache[ctype][2] = tconf[lower][1]	 		
			end
		end
		-- ���ù������
		if tconf[lower][2] ~= nil then		
			timesCache[ctype][3] = nil
		end
	end
end

-------------------------------------------------------------------
--interface:


local function GetDBTimesCache( playerid )
	local TimesMgr = GetDBTimesMgrData( playerid )
	if TimesMgr.tc == nil then
		TimesMgr.tc = {}
	end
	
	return TimesMgr.tc
end

local function GetDBTimesStore( playerid )
	local TimesMgr = GetDBTimesMgrData( playerid )
	if TimesMgr.ts == nil then
		TimesMgr.ts = {}
	end
	
	return TimesMgr.ts
end

-- ����ͬ��������Ϣ
-- function TM_SyncData(sid,ctype)
	-- local timesCache
	-- local timesStore
	-- timesCache, timesStore = GetTimesInfo(sid,ctype)
	-- SendLuaMsg( 0, { ids = TMS_Data, tc = timesCache, ts = timesStore }, 9 )
-- end

-- ��ȡ������Ϣ
function GetTimesInfo(sid,ctype)
	local pTimesMgr = GetDBTimesMgrData(sid)
	if pTimesMgr == nil or pTimesMgr.tc == nil or pTimesMgr.ts == nil then 
		return false
	end 
	local timesCache = pTimesMgr.tc
	local timesStore = pTimesMgr.ts
	if ctype ~= nil then
		return timesCache[ctype],timesStore[ctype]
	else
		return timesCache,timesStore
	end
end

-- ���Ӵ��� ͳ������������Ϊ׼ ��ͨ����ǰֵ�Ƿ�Ϊ���ж�
-- opt == nil ֻ������ͳ��
-- opt = -1 ����ʣ������� ��������ͳ�� �������� ��
-- opt = 0 ������������ʣ����� �� ����������ͳ�� ��
-- opt = 1 ��ʾ���� �������жϹ������ �� ����������ͳ�� ��
-- bCheck ֻ��� opt = -1 & 1ʱ��Ч [1] check only [...] check and del
function CheckTimes(sid,ctype,count,opt,bCheck)
	local pTimesMgr = GetDBTimesMgrData(sid)
	if pTimesMgr == nil or pTimesMgr.tc == nil or pTimesMgr.ts == nil then 
		return false
	end	
	local timesCache = pTimesMgr.tc
	local timesStore = pTimesMgr.ts
	local tconf = uv_TimesConfig[ctype]
	if tconf == nil then
		return false
	end
	
	--look(pTimesMgr.tc[ctype])	
	local ResetCount, BuyCount = GetResetTimes(sid,ctype)
	-- ��¼����֮ǰ�Ľӿ�
	local preTimes = 0
	if timesCache[ctype] then
		preTimes = timesCache[ctype][1] or 0
	end
		
	if opt == -1 then
		-- ��¼ÿ��ʣ�����
		if ResetCount == nil then
			return false
		end
		if timesCache[ctype] == nil or timesCache[ctype][2] == nil then 
			return false
		end
		if timesCache[ctype][2] < count then
			return false
		end
		if bCheck and bCheck == 1 then	-- ���������͵Ĳ���ͳ�ƴ���
			return true
		end
		-- ����ʣ�����
		timesCache[ctype][2] = timesCache[ctype][2] - count					
	-- ��������ʣ�����
	elseif opt == 0 then
		if timesCache[ctype] == nil or timesCache[ctype][2] == nil then 
			return false
		end				
		timesCache[ctype][2]  =  timesCache[ctype][2] + count 		-- ����ʣ�����
		SendLuaMsg( 0, { ids = TMS_Sync, ctype = ctype, tc = timesCache[ctype], opt = opt }, 9 )
		return true	
	-- ��¼������� ���򲻻�������ͳ�Ƶ�������ÿ�չ������(���乺��������Ƶ�Ĭ��������)
	elseif opt == 1 then	
		if timesCache[ctype] == nil or timesCache[ctype][2] == nil then 
			return false
		end				
		timesCache[ctype][3] = timesCache[ctype][3] or 0
		if BuyCount and timesCache[ctype][3] + count >  BuyCount then
			return false
		end
		if bCheck and bCheck == 1 then								-- ��鹺�����
			return timesCache[ctype][3]								-- ���ص�ǰ�������
		end
		timesCache[ctype][3] = timesCache[ctype][3] + count			-- ���ӹ������
		timesCache[ctype][2] = timesCache[ctype][2] + count			-- ����ʣ�����
		SendLuaMsg( 0, { ids = TMS_Sync, ctype = ctype, tc = timesCache[ctype] }, 9 )
		return true	
	end
	
	-- �ߵ�����˵������ʹ�ô���-->д��־(���ڼ�¼���ݿ���־�����ر�����ͳ������)
	if (ctype >= 1 and ctype <= 4) or ctype == 43 then
		db_times_log(sid,ctype)
	end
	
	-- ��¼ÿ��ͳ�ƴ���
	if tconf.countType >= 0 and tconf.countType ~= 1 then		
		if timesCache[ctype] == nil then 
			return false
		end
		timesCache[ctype][1] = (timesCache[ctype][1] or 0) + (count or 0)
	end

	-- ��¼����ͳ�ƴ��� ����������óɾͽӿں������� �������������������
	if tconf.countType >= 1 then
		timesStore[ctype] = (timesStore[ctype] or 0) + (count or 0)
		if timesStore[ctype] > 50000 then
			timesStore[ctype] = 50000
		end
	end

	SendLuaMsg( sid, { ids = TMS_Sync, ctype = ctype, tc = timesCache[ctype], ts = timesStore[ctype] }, 10 )
	-- ���û�Ծ�ȡ�Ŀ�ꡢ�ɾ�
	set_data(sid, ctype, timesCache[ctype][1], timesStore[ctype], preTimes)
	return true
end

-- ��½���ô��� ֻ�����¹���
function LoginResetTimes(sid)
	local pTimesMgr = GetDBTimesMgrData(sid)
	if pTimesMgr == nil or pTimesMgr.tc == nil then 
		return
	end 
	local timesCache = pTimesMgr.tc	
	for ctype, v in pairs(uv_TimesConfig) do
		if timesCache[ctype] == nil then
			ResetTimes(sid,ctype,v)
		end
	end

	-- Log_Begin("times_log.txt")
	-- Log_Save(timesCache)
	-- Log_End()
	SendLuaMsg( 0, { ids = TMS_Data, tc = timesCache, ts = pTimesMgr.ts }, 9 )
end

-- ÿ�����ô��� 
function DayResetTimes(sid,iType)
	-- look('ÿ�����ô���',1)
	-- look(iType,1)
	local pTimesMgr = GetDBTimesMgrData(sid)
	if pTimesMgr == nil or pTimesMgr.tc == nil then 
		-- look(11,1)
		return
	end 
	if iType == nil then							-- �������д�����Ϣ
		for ctype, v in pairs(uv_TimesConfig) do
			if v.resetTM == nil then
				ResetTimes(sid,ctype,v)
			end
		end
	else		
		-- look(uv_TimesConfig[iType],1)-- ����ĳ�����ܴ�����Ϣ
		if uv_TimesConfig[iType] ~= nil then
			ResetTimes(sid,iType,uv_TimesConfig[iType])
			-- look('����ĳ�����ܴ�����Ϣ',1)
			-- look(uv_TimesConfig[iType],1)
		end
		SendLuaMsg( 0, { ids = TMS_Data, ctype = iType, tc = pTimesMgr.tc[iType] }, 9 )
	end	
	--rfalse("DayResetTimes")
	-- Log_Begin("times_log.txt")
	-- Log_Save(timesCache)
	-- Log_End()
	SendLuaMsg( 0, { ids = TMS_Data, tc = pTimesMgr.tc  }, 9 )	
end

-- vip�ȼ����������仯
function vip_timesreset(sid,oldLv,newLv)
	look('vip_timesreset:' .. oldLv .. '___' .. newLv)
	if sid == nil or oldLv == nil or newLv == nil then
		return
	end
	if oldLv >= newLv then return end
	local pTimesMgr = GetDBTimesMgrData(sid)
	if pTimesMgr == nil or pTimesMgr.tc == nil then 
		return
	end 
	local t = pTimesMgr.tc
	for ctype, v in pairs(uv_TimesConfig) do
		if type(ctype) == type(0) then
			local oldrc,oldbc = GetResetTimes(sid,ctype,oldLv)
			-- look(oldrc)
			-- look(oldbc)
			local newrc,newbc = GetResetTimes(sid,ctype,newLv)
			t[ctype] = t[ctype] or  {}
			if (newrc or 0) > (oldrc or 0) then				
				t[ctype][2] = (t[ctype][2] or 0) + (newrc - oldrc)	-- ���ӿ�ʹ��ʣ�����
			end
			if (newbc or 0) > (oldbc or 0) then
				t[ctype][3] = (t[ctype][3] or 0) + (newbc - oldbc)	-- ���ӹ���ʣ�����
			end
		end
	end
end

return DayResetTimes