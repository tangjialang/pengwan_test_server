--[[
file: span_active.lua
desc: 跨服活动的本服相关处理函数
autor: csj
]]--

--------------------------------------------------------------
-- include:

local pairs,ipairs,type = pairs,ipairs,type
local tostring = tostring
local look = look
local GetServerTime = GetServerTime
local GetGroupID = GetGroupID
local db_module = require('Script.cext.dbrpc')
local db_get_span_server = db_module.db_get_span_server
local common_time = require('Script.common.time_cnt')
local GetDiffDayFromTime = common_time.GetDiffDayFromTime

-- 玩家跨服数据
function GetPlayerSpanData(playerID)
	local spanData = GI_GetPlayerData( playerID , "span" , 100 )
	if nil == spanData then
		return
	end
	--[[
		spanData = {
			[1] = {	-- 跨服BOSS活动			
				[1] = mapGID,	-- 选择房间地图GID
			},
			cGID = 0,			-- 记录场景编号(这个只是进入前记录的，进入跨服后玩家真正的地图GID可能会变)
			cUID = 1,			-- 记录活动编号 
		}
	]]--
	-- look(tostring(spanData))
	return spanData
end

function GetPlayerSpanInfo(sid,uid)
	if sid == nil or uid == nil then return end
	local spdata = GetPlayerSpanData(sid)
	if spdata == nil then return end
	spdata[uid] = spdata[uid] or {}
	
	return spdata[uid]
end

-- 获取玩家跨服当前活动编号
function GetPlayerSpanUID(sid)
	local spdata = GetPlayerSpanData(sid)
	if spdata == nil then return end
	return spdata.cUID
end

-- 设置玩家跨服当前活动编号
function SetPlayerSpanUID(sid,uid)
	if sid == nil or uid == nil then return end
	local spdata = GetPlayerSpanData(sid)
	if spdata == nil then return end
	spdata.cUID = uid
end

-- 获取玩家跨服当前活动选择地图编号
function GetPlayerSpanGID(sid)
	local spdata = GetPlayerSpanData(sid)
	if spdata == nil then return end
	return spdata.cGID
end

-- 设置玩家跨服当前活动地图编号
function SetPlayerSpanGID(sid,mapGID)
	if sid == nil or mapGID == nil then return end
	local spdata = GetPlayerSpanData(sid)
	if spdata == nil then return end
	spdata.cGID = mapGID
end

-- 跨服世界数据
function GetSpanServerData()
	if nil == dbMgr.span_server_data.data then
		dbMgr.span_server_data.data = {
			sList = {},			-- 大区列表
			sflags = {},		-- 活动状态
		}
	end
	return dbMgr.span_server_data.data
end

-- 取本服的跨服服务器数据 区分活动
function GetSpanListData(uid)
	if uid == nil then return end
	local spdata = GetSpanServerData()
	if spdata == nil then return end
	spdata.sList = spdata.sList or {}
	if spdata.sList[uid] == nil then
		spdata.sList[uid] = {}
	end
	
	return spdata.sList[uid]
end

-- 清理本服的跨服活动数据
function ClrSpanListData(uid)
	if uid == nil then return end
	local spdata = GetSpanServerData()
	if spdata == nil then return end
	spdata.sList = spdata.sList or {}
	
	-- 清除活动数据
	spdata.sList[uid] = nil
end

-- 上线发送活动状态
function SendSpanActiveState(sid)
	local spdata = GetSpanServerData()
	if spdata == nil then return end
	RPCEx(sid,'sp_active_state',spdata.sflags)
end

-- 取活动状态
function GetSpanActiveState(uid)
	local spdata = GetSpanServerData()
	if spdata == nil then return end
	spdata.sflags = spdata.sflags or {}
	return spdata.sflags[uid]
end

-- 设置活动状态
function SetSpanActiveState(uid,state)
	local spdata = GetSpanServerData()
	if spdata == nil then return end
	spdata.sflags = spdata.sflags or {}
	spdata.sflags[uid] = state
end

-- 获取进入跨服服务器ID
function GetTargetSvrID(serverid)
	if serverid == nil then 
		return 0
	end
	local svrid = serverid % 9990000
	return svrid
end

-- 获取上次离开跨服时间(如果有记录)
function GetSpanLeaveTime(sid,uid)
	if sid == nil or uid == nil then return end
	local dayData = GetPlayerDayData(sid)
	if dayData == nil then return end
	dayData.leavsp = dayData.leavsp or {}
	return dayData.leavsp[uid]
end

-- 设置离开跨服时间
function SetSpanLeaveTime(sid,uid,val)
	if sid == nil or uid == nil then return end
	local dayData = GetPlayerDayData(sid)
	if dayData then
		dayData.leavsp = dayData.leavsp or {}
		if dayData.leavsp[uid] == -1 then
			dayData.leavsp[uid] = 0
		else
			dayData.leavsp[uid] = val
		end		
	end
end

-- 获取等级分割
function GetSpanLevelApart()
	local wLv = GetWorldLevel() or 1	
	if wLv <= 52 then
		wLv = 50
	elseif wLv <= 55 then
		wLv = 53
	elseif wLv <= 59 then
		wLv = 56
	elseif wLv <= 64 then
		wLv = 60
	elseif wLv <= 69 then
		wLv = 65
	elseif wLv <= 79 then
		wLv = 70
	else
		wLv = 80
	end
	
	return wLv
end

-- 获取跨服房间地图GID(只针对通过活动管理器模板创建的房间处理)
function GetSpanRoomGID(rooms,mapGID)
	if mapGID == nil or type(rooms) ~= type({}) then 
		return 0
	end
	if mapGID == 0 then	-- 后台遍历寻找空房间
		for k, v in ipairs(rooms) do
			if type(v) == type({}) then
				if v[2] == 0 then	-- 找到后直接返回地图GID及房间编号
					return v[1],k
				end
			end
		end			
	else				-- 根据传入mapGID判断是否存在此房间且人数未满
		for k, v in ipairs(rooms) do
			if type(v) == type({}) then
				if v[1] == mapGID then	-- 找到后直接返回地图GID
					if v[2] == 1 then
						return -1,k		-- 返回当前房间爆满
					else
						return mapGID,k	-- 说明该房间人数未满可进入
					end
				end
			end
		end
	end	
	
	-- 到这里说明没找到空房间或者mapGID对应房间
	return 0
end

-- 存储过程返回大区列表
-- 格式:
--[[
	rs = {
		[1] = {		-- 1区
			[1] = serverid
			[2] = ip
			[3] = port		
		}
		[2] = {		-- 2区
			[1] = serverid
			[2] = ip
			[3] = port		
		}
	}
]]--
function CALLBACK_SpanServerGets(uid,con,rs)
	-- look('CALLBACK_SpanServerGets',1)
	-- look(uid,1)
	-- look(con,1)
	-- look(rs,1)

	if uid == nil or rs == nil then return end
	if uid == -1 then		-- 取所有跨服服务器
		SetAllSpanServer(rs)
		return
	end
	--跨服BOSS活动
	if uid == 1 then
		if con == nil then return end
		local spBoss = GetSpanListData(uid)
		if spBoss == nil then return end
		spBoss[con] = rs

		for k, v in ipairs(rs) do
			PI_SendSpanMsg(v[1], {t = 2, ids = 1001, svrid = GetGroupID(), uid = uid, con = con, idx = k}, 0)
		end
		-- 每秒从跨服请求房间信息
		SetEvent(1,nil,'Evt_spboss_rooms',uid,con)
	-- 跨服寻宝活动
	elseif uid == 2 then
		if con == nil then return end
		local spxb = GetSpanListData(uid)
		if spxb == nil then return end
		spxb[con] = rs
		
		for i, v in ipairs(rs) do
			PI_SendSpanMsg(v[1], {t = 2, ids = 2001, svrid = GetGroupID(), uid = uid, con = con, idx = i}, 0)
		end
		-- 每秒从跨服请求房间信息
		-- SetEvent(1,nil,'Evt_spxb_rooms',uid,con)
	elseif uid == 3 then
		if con == nil then return end
		local spxb = GetSpanListData(uid)
		if spxb == nil then return end
		spxb[con] = rs
		
		for i, v in ipairs(rs) do
			PI_SendSpanMsg(v[1], {t = 2, ids = 3001, svrid = GetGroupID(), uid = uid, con = con, idx = i}, 0)
		end
		-- 每秒从跨服请求房间信息
		SetEvent(1,nil,'Evt_spfish_rooms',uid,con)
	elseif uid == 4 then ---跨服3v3
		if con == nil then return end
		local spxb = GetSpanListData(uid)
		if spxb == nil then return end
		spxb [1]= rs
	elseif uid == 5 then
		if con == nil then return end
		local spTjbx = GetSpanListData(uid)
		if spTjbx == nil then return end
		spTjbx[con] = rs

		for k, v in ipairs(rs) do
			PI_SendToSpanSvr(v[1], {ids = 5001, svrid = GetGroupID(), uid = uid, con = con, idx = k}, 0)
		end
		-- 每秒从跨服请求房间信息
		SetEvent(1,nil,'Evt_sptjbx_rooms',uid,con)
	elseif uid == 6 then
		if con == nil then return end
		local spSjzc = GetSpanListData(uid)
		if spSjzc == nil then return end
		spSjzc[con] = rs

		for k, v in ipairs(rs) do
			PI_SendToSpanSvr(v[1], {ids = 6001, svrid = GetGroupID(), uid = uid, con = con, idx = k}, 0)
		end
		-- 每秒从跨服请求房间信息
		SetEvent(1,nil,'Evt_spsjzc_rooms',uid,con)
	elseif uid == 7 then ---跨服1v1
		if con == nil then return end
		local spxb = GetSpanListData(uid)
		if spxb == nil then return end
		spxb [1]= rs
	end	
end


-- 进入跨服服务器
function PI_EnterSpanServerEx(sid, span_id, span_ip, span_port, pass, loc_ip, loc_port, loc_entryid)
	-- 传入参数判断
	if sid == nil or span_id == nil or span_ip == nil or span_port == nil or pass == nil or loc_ip == nil or loc_port == nil then
		-- look('PI_EnterSpanServerEx param error')
		return
	end
	if loc_entryid == nil or loc_entryid == 0 then
		-- look('PI_EnterSpanServerEx loc_entryid error')
		return 
	end
	
	-- look('CI_EnterSpanServer')
	-- look(sid,1)
	-- look(pass,1)
	-- look(loc_ip,1)
	-- look(loc_port,1)
	-- look(loc_entryid,1)	
	-- **下线要修改的数据需要在这里调用一次**
	SetLogoutHangUpData(sid)
	setMountsLogout(sid)
	CI_EnterSpanServer(span_id,span_ip,span_port,pass,loc_ip,loc_port,loc_entryid,2,sid)
end

function SpanActiveNotice()
	local openTime = GetServerOpenTime()
	if openTime == nil then return end
	local day = GetDiffDayFromTime(openTime) + 1
	if day == 8 then
		SendSystemMail(nil,MailConfig.Activetip,1,2)
	end
end

