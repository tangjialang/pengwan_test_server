--[[
file: span_active.lua
desc: �����ı�����ش�����
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

-- ��ҿ������
function GetPlayerSpanData(playerID)
	local spanData = GI_GetPlayerData( playerID , "span" , 100 )
	if nil == spanData then
		return
	end
	--[[
		spanData = {
			[1] = {	-- ���BOSS�			
				[1] = mapGID,	-- ѡ�񷿼��ͼGID
			},
			cGID = 0,			-- ��¼�������(���ֻ�ǽ���ǰ��¼�ģ�����������������ĵ�ͼGID���ܻ��)
			cUID = 1,			-- ��¼���� 
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

-- ��ȡ��ҿ����ǰ����
function GetPlayerSpanUID(sid)
	local spdata = GetPlayerSpanData(sid)
	if spdata == nil then return end
	return spdata.cUID
end

-- ������ҿ����ǰ����
function SetPlayerSpanUID(sid,uid)
	if sid == nil or uid == nil then return end
	local spdata = GetPlayerSpanData(sid)
	if spdata == nil then return end
	spdata.cUID = uid
end

-- ��ȡ��ҿ����ǰ�ѡ���ͼ���
function GetPlayerSpanGID(sid)
	local spdata = GetPlayerSpanData(sid)
	if spdata == nil then return end
	return spdata.cGID
end

-- ������ҿ����ǰ���ͼ���
function SetPlayerSpanGID(sid,mapGID)
	if sid == nil or mapGID == nil then return end
	local spdata = GetPlayerSpanData(sid)
	if spdata == nil then return end
	spdata.cGID = mapGID
end

-- �����������
function GetSpanServerData()
	if nil == dbMgr.span_server_data.data then
		dbMgr.span_server_data.data = {
			sList = {},			-- �����б�
			sflags = {},		-- �״̬
		}
	end
	return dbMgr.span_server_data.data
end

-- ȡ�����Ŀ������������ ���ֻ
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

-- �������Ŀ�������
function ClrSpanListData(uid)
	if uid == nil then return end
	local spdata = GetSpanServerData()
	if spdata == nil then return end
	spdata.sList = spdata.sList or {}
	
	-- ��������
	spdata.sList[uid] = nil
end

-- ���߷��ͻ״̬
function SendSpanActiveState(sid)
	local spdata = GetSpanServerData()
	if spdata == nil then return end
	RPCEx(sid,'sp_active_state',spdata.sflags)
end

-- ȡ�״̬
function GetSpanActiveState(uid)
	local spdata = GetSpanServerData()
	if spdata == nil then return end
	spdata.sflags = spdata.sflags or {}
	return spdata.sflags[uid]
end

-- ���û״̬
function SetSpanActiveState(uid,state)
	local spdata = GetSpanServerData()
	if spdata == nil then return end
	spdata.sflags = spdata.sflags or {}
	spdata.sflags[uid] = state
end

-- ��ȡ������������ID
function GetTargetSvrID(serverid)
	if serverid == nil then 
		return 0
	end
	local svrid = serverid % 9990000
	return svrid
end

-- ��ȡ�ϴ��뿪���ʱ��(����м�¼)
function GetSpanLeaveTime(sid,uid)
	if sid == nil or uid == nil then return end
	local dayData = GetPlayerDayData(sid)
	if dayData == nil then return end
	dayData.leavsp = dayData.leavsp or {}
	return dayData.leavsp[uid]
end

-- �����뿪���ʱ��
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

-- ��ȡ�ȼ��ָ�
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

-- ��ȡ��������ͼGID(ֻ���ͨ���������ģ�崴���ķ��䴦��)
function GetSpanRoomGID(rooms,mapGID)
	if mapGID == nil or type(rooms) ~= type({}) then 
		return 0
	end
	if mapGID == 0 then	-- ��̨����Ѱ�ҿշ���
		for k, v in ipairs(rooms) do
			if type(v) == type({}) then
				if v[2] == 0 then	-- �ҵ���ֱ�ӷ��ص�ͼGID��������
					return v[1],k
				end
			end
		end			
	else				-- ���ݴ���mapGID�ж��Ƿ���ڴ˷���������δ��
		for k, v in ipairs(rooms) do
			if type(v) == type({}) then
				if v[1] == mapGID then	-- �ҵ���ֱ�ӷ��ص�ͼGID
					if v[2] == 1 then
						return -1,k		-- ���ص�ǰ���䱬��
					else
						return mapGID,k	-- ˵���÷�������δ���ɽ���
					end
				end
			end
		end
	end	
	
	-- ������˵��û�ҵ��շ������mapGID��Ӧ����
	return 0
end

-- �洢���̷��ش����б�
-- ��ʽ:
--[[
	rs = {
		[1] = {		-- 1��
			[1] = serverid
			[2] = ip
			[3] = port		
		}
		[2] = {		-- 2��
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
	if uid == -1 then		-- ȡ���п��������
		SetAllSpanServer(rs)
		return
	end
	--���BOSS�
	if uid == 1 then
		if con == nil then return end
		local spBoss = GetSpanListData(uid)
		if spBoss == nil then return end
		spBoss[con] = rs

		for k, v in ipairs(rs) do
			PI_SendSpanMsg(v[1], {t = 2, ids = 1001, svrid = GetGroupID(), uid = uid, con = con, idx = k}, 0)
		end
		-- ÿ��ӿ�����󷿼���Ϣ
		SetEvent(1,nil,'Evt_spboss_rooms',uid,con)
	-- ���Ѱ���
	elseif uid == 2 then
		if con == nil then return end
		local spxb = GetSpanListData(uid)
		if spxb == nil then return end
		spxb[con] = rs
		
		for i, v in ipairs(rs) do
			PI_SendSpanMsg(v[1], {t = 2, ids = 2001, svrid = GetGroupID(), uid = uid, con = con, idx = i}, 0)
		end
		-- ÿ��ӿ�����󷿼���Ϣ
		-- SetEvent(1,nil,'Evt_spxb_rooms',uid,con)
	elseif uid == 3 then
		if con == nil then return end
		local spxb = GetSpanListData(uid)
		if spxb == nil then return end
		spxb[con] = rs
		
		for i, v in ipairs(rs) do
			PI_SendSpanMsg(v[1], {t = 2, ids = 3001, svrid = GetGroupID(), uid = uid, con = con, idx = i}, 0)
		end
		-- ÿ��ӿ�����󷿼���Ϣ
		SetEvent(1,nil,'Evt_spfish_rooms',uid,con)
	elseif uid == 4 then ---���3v3
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
		-- ÿ��ӿ�����󷿼���Ϣ
		SetEvent(1,nil,'Evt_sptjbx_rooms',uid,con)
	elseif uid == 6 then
		if con == nil then return end
		local spSjzc = GetSpanListData(uid)
		if spSjzc == nil then return end
		spSjzc[con] = rs

		for k, v in ipairs(rs) do
			PI_SendToSpanSvr(v[1], {ids = 6001, svrid = GetGroupID(), uid = uid, con = con, idx = k}, 0)
		end
		-- ÿ��ӿ�����󷿼���Ϣ
		SetEvent(1,nil,'Evt_spsjzc_rooms',uid,con)
	elseif uid == 7 then ---���1v1
		if con == nil then return end
		local spxb = GetSpanListData(uid)
		if spxb == nil then return end
		spxb [1]= rs
	end	
end


-- ������������
function PI_EnterSpanServerEx(sid, span_id, span_ip, span_port, pass, loc_ip, loc_port, loc_entryid)
	-- ��������ж�
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
	-- **����Ҫ�޸ĵ�������Ҫ���������һ��**
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

