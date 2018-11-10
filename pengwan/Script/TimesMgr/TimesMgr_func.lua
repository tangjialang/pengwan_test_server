--[[
file:	TimesMgr_func.lua
desc:	次数管理器接口
author:	csj
update:	

notes:
	1、次数管理器在做次数变化的时候逻辑必须严谨 防止出现无限次数
	2、次数管理器数据暂时不放在任务数据下做实时同步 （对于一次性很多字段会变化的数据不宜放在人物数据做实时同步 因为这样会造成发送很多碎片消息）

可优化:
	1、玩家初始的时候尽量不置位次数、保证新玩家的次数管理器数据最小
	2、考虑如何比较简单的做到玩家VIP等级变化时次数及时更新
]]--

local pairs,tostring,type = pairs,tostring,type
local ipairs = ipairs
local look = look
local achieve = require('Script.achieve.fun')
local set_data = achieve.set_data
local db_module = require('Script.cext.dbrpc')
local db_times_log = db_module.db_times_log

--s2c_msg_def
local TMS_Data = msgh_s2c_def[25][1]	-- 所有次数数据
local TMS_Sync = msgh_s2c_def[25][2]	-- 次数更新数据


local uv_TimesConfig = TimesConfig

-------------------------------------------------------------------
--inner function:

-- 次数管理器数据
local function GetDBTimesMgrData( playerid )
	local TimesMgr_data=GI_GetPlayerData( playerid , 'Tmgr' , 700 )
	if TimesMgr_data == nil then return end
	if TimesMgr_data.tc==nil then
		TimesMgr_data.tc={}		-- [1] 每日统计使用次数 [2] 今日剩余次数 [3] 已购买次数
		TimesMgr_data.ts={}		-- 永久记录统计次数 主要用于成就触发	
	end
	--look(tostring(TimesMgr_data))
	--look(TimesMgr_data)
	return TimesMgr_data
end

-- 获取重置次数
-- vipLv VIP等级
-- ctype 功能类型
-- 返回值：重置次数 可购买次数
local function GetResetTimes(sid,ctype,vipLv)
	local tconf = uv_TimesConfig[ctype]
	if tconf == nil then return end
	-- 默认根据VIPLV重置
	local cond = vipLv or GI_GetVIPLevel(sid)
	
	if tconf.setType == 1 then		--根据帮派建筑(8)等级重置
		cond = CI_GetFactionInfo(nil,8)
	elseif tconf.setType == 2 then		--根据玩家威望等级重置上限
		cond = get_preslv(sid) or 0
	end
	if cond == nil then return end
	local lower = table.locate(tconf, cond, 1)
	if lower == nil then return end
	
	return tconf[lower][1], tconf[lower][2]
end

local function ResetTimes(sid,ctype,tconf)	
	if tconf == nil or tconf.countType == nil then return end
	-- 判断等级
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
	
	-- 默认根据VIPLV重置
	local cond = GI_GetVIPLevel(sid)
	-- look('cond'..ctype..':'..cond)
	if tconf.setType == 1 then			--根据帮派建筑(8)等级重置
		cond = CI_GetFactionInfo(nil,8)
		if cond == nil then cond=0 end
	elseif tconf.setType == 2 then		--根据玩家威望等级重置上限
		cond = get_preslv(sid) or 0
	end
	if cond == nil then return end

	local lower = nil
	-- 重置每日统计次数
	if tconf.countType >= 0 and tconf.countType ~= 1 then		
		timesCache[ctype][1] = nil								-- 次数统计 每日重置成 nil
	end
	-- 重置剩余次数
	local lower = table.locate(tconf, cond, 1)
	-- look('lower'..ctype..':'..lower)
	-- 剩余次数 同以前的逻辑小于才重置 能保证部分情况下不会清空掉已购买的次数
	if lower ~= nil and tconf[lower] ~= nil then				
		if tconf[lower][1] ~= nil then		
			if timesCache[ctype][2] == nil or timesCache[ctype][2] < tconf[lower][1] then
				timesCache[ctype][2] = tconf[lower][1]	 		
			end
		end
		-- 重置购买次数
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

-- 上线同步次数信息
-- function TM_SyncData(sid,ctype)
	-- local timesCache
	-- local timesStore
	-- timesCache, timesStore = GetTimesInfo(sid,ctype)
	-- SendLuaMsg( 0, { ids = TMS_Data, tc = timesCache, ts = timesStore }, 9 )
-- end

-- 获取次数信息
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

-- 增加次数 统计类型以配置为准 不通过当前值是否为空判断
-- opt == nil 只做次数统计
-- opt = -1 减少剩余次数（ 会做次数统计 根据配置 ）
-- opt = 0 其他道具增加剩余次数 （ 不会做次数统计 ）
-- opt = 1 表示购买 购买需判断购买次数 （ 不会做次数统计 ）
-- bCheck 只针对 opt = -1 & 1时有效 [1] check only [...] check and del
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
	-- 记录增加之前的接口
	local preTimes = 0
	if timesCache[ctype] then
		preTimes = timesCache[ctype][1] or 0
	end
		
	if opt == -1 then
		-- 记录每日剩余次数
		if ResetCount == nil then
			return false
		end
		if timesCache[ctype] == nil or timesCache[ctype][2] == nil then 
			return false
		end
		if timesCache[ctype][2] < count then
			return false
		end
		if bCheck and bCheck == 1 then	-- 检查次数类型的不能统计次数
			return true
		end
		-- 减少剩余次数
		timesCache[ctype][2] = timesCache[ctype][2] - count					
	-- 道具增加剩余次数
	elseif opt == 0 then
		if timesCache[ctype] == nil or timesCache[ctype][2] == nil then 
			return false
		end				
		timesCache[ctype][2]  =  timesCache[ctype][2] + count 		-- 增加剩余次数
		SendLuaMsg( 0, { ids = TMS_Sync, ctype = ctype, tc = timesCache[ctype], opt = opt }, 9 )
		return true	
	-- 记录购买次数 购买不会做次数统计但会增加每日购买次数(不配购买次数限制的默认无限制)
	elseif opt == 1 then	
		if timesCache[ctype] == nil or timesCache[ctype][2] == nil then 
			return false
		end				
		timesCache[ctype][3] = timesCache[ctype][3] or 0
		if BuyCount and timesCache[ctype][3] + count >  BuyCount then
			return false
		end
		if bCheck and bCheck == 1 then								-- 检查购买次数
			return timesCache[ctype][3]								-- 返回当前购买次数
		end
		timesCache[ctype][3] = timesCache[ctype][3] + count			-- 增加购买次数
		timesCache[ctype][2] = timesCache[ctype][2] + count			-- 增加剩余次数
		SendLuaMsg( 0, { ids = TMS_Sync, ctype = ctype, tc = timesCache[ctype] }, 9 )
		return true	
	end
	
	-- 走到这里说明是在使用次数-->写日志(对于记录数据库日志不用特别配置统计类型)
	if (ctype >= 1 and ctype <= 4) or ctype == 43 then
		db_times_log(sid,ctype)
	end
	
	-- 记录每日统计次数
	if tconf.countType >= 0 and tconf.countType ~= 1 then		
		if timesCache[ctype] == nil then 
			return false
		end
		timesCache[ctype][1] = (timesCache[ctype][1] or 0) + (count or 0)
	end

	-- 记录永久统计次数 这里最好是用成就接口函数处理 以免造成数据无限增加
	if tconf.countType >= 1 then
		timesStore[ctype] = (timesStore[ctype] or 0) + (count or 0)
		if timesStore[ctype] > 50000 then
			timesStore[ctype] = 50000
		end
	end

	SendLuaMsg( sid, { ids = TMS_Sync, ctype = ctype, tc = timesCache[ctype], ts = timesStore[ctype] }, 10 )
	-- 设置活跃度、目标、成就
	set_data(sid, ctype, timesCache[ctype][1], timesStore[ctype], preTimes)
	return true
end

-- 登陆重置次数 只重置新功能
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

-- 每日重置次数 
function DayResetTimes(sid,iType)
	-- look('每日重置次数',1)
	-- look(iType,1)
	local pTimesMgr = GetDBTimesMgrData(sid)
	if pTimesMgr == nil or pTimesMgr.tc == nil then 
		-- look(11,1)
		return
	end 
	if iType == nil then							-- 重置所有次数信息
		for ctype, v in pairs(uv_TimesConfig) do
			if v.resetTM == nil then
				ResetTimes(sid,ctype,v)
			end
		end
	else		
		-- look(uv_TimesConfig[iType],1)-- 重置某个功能次数信息
		if uv_TimesConfig[iType] ~= nil then
			ResetTimes(sid,iType,uv_TimesConfig[iType])
			-- look('重置某个功能次数信息',1)
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

-- vip等级升级次数变化
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
				t[ctype][2] = (t[ctype][2] or 0) + (newrc - oldrc)	-- 增加可使用剩余次数
			end
			if (newbc or 0) > (oldbc or 0) then
				t[ctype][3] = (t[ctype][3] or 0) + (newbc - oldbc)	-- 增加购买剩余次数
			end
		end
	end
end

return DayResetTimes