--[[
file: span_boss.lua
desc: ���BOSS�
autor: csj
]]--

--------------------------------------------------------------
-- include:

local pairs,ipairs,type = pairs,ipairs,type
local tostring = tostring
local look = look
local rint = rint
local GetServerTime = GetServerTime
local GetGroupID = GetGroupID
local PI_SendToSpanSvr = PI_SendToSpanSvr
local db_module = require('Script.cext.dbrpc')
local db_get_span_server = db_module.db_get_span_server
local GetServerOpenTime = GetServerOpenTime
local common_time = require('Script.common.time_cnt')
local GetDiffDayFromTime=common_time.GetDiffDayFromTime


-- ����
local SPAN_TJBX_ID = 5

-- ���ʼ��ȡ���boss������б�
-- ÿ������120�������ӳ�(��������)
function sptjbx_start_proc()	
	local openTime = GetServerOpenTime()
	local days = GetDiffDayFromTime(openTime) + 1
	if days <= 7 then	-- ����7��֮�ڲ������
		return
	end
	local state = GetSpanActiveState(SPAN_TJBX_ID)
	if state then
		look('sptjbx_start_proc active not end',1)
		return
	end
	-- ����ֵ �ǵ��޸�
	local rdsec = math.random(1,100)	
	SetEvent(rdsec, nil, 'Evt_SpanTjbx_start')
end

function Evt_SpanTjbx_start()
	local sptjbx = GetSpanListData(SPAN_TJBX_ID)
	if sptjbx == nil then return end
	-- ���ʼ ���ȼ�¼��ǰ��������ȼ� ��ֹ��ڼ� ����ȼ����
	local wLv = GetSpanLevelApart()
	look('GetWorldLevel:' .. tostring(wLv))
	sptjbx.wLv = wLv	
	-- ���û��ʼ��־
	SetSpanActiveState(SPAN_TJBX_ID,1)
	-- ��ȡ���BOSS������б�(�ص�����: CALLBACK_SpanServerGets)
	db_get_span_server(SPAN_TJBX_ID,wLv)	
	-- �㲥���ʼ
	BroadcastRPC('sptjbx_start')
end

-- ÿ��ӿ��ȡ�������ݸ���
function Evt_sptjbx_rooms(uid,con)
	if uid == nil or con == nil then return end
	if uid ~= SPAN_TJBX_ID then return end
	local sptjbx = GetSpanListData(uid)
	if sptjbx == nil then return end
	local rs = sptjbx[con]
	if rs == nil then
		return
	end
	-- look(rs,1)
	for k, v in ipairs(rs) do
		PI_SendToSpanSvr(v[1], {ids = 5001, svrid = GetGroupID(), uid = uid, con = con, idx = k}, 0)
	end
	return 1
end

-- ȡ������ط�����Ϣ���±��ط�����������Ϣ
function sptjbx_set_rooms(uid,con,idx,rooms)
	-- look('sptjbx_set_rooms',1)
	-- look(con,1)
	-- look(idx,1)
	if uid == nil or con == nil or idx == nil then return end
	if uid ~= SPAN_TJBX_ID then return end
	local sptjbx = GetSpanListData(uid)
	if sptjbx == nil or sptjbx[con] == nil then return end
	local sInfo = sptjbx[con][idx]
	if sInfo == nil then 
		return
	end	
	-- ���·�����Ϣ
	sInfo.rooms = rooms
	-- look(sInfo.rooms,1)
end

-- ���ȡ��������б�
function sptjbx_get_server(sid)
	local lv = CI_GetPlayerData(1,2,sid) or 1
	if lv < 40 then
		return
	end
	local state = GetSpanActiveState(SPAN_TJBX_ID)
	if state == nil then
		look('sptjbx_get_server active has end',1)
		return
	end
	local sptjbx = GetSpanListData(SPAN_TJBX_ID)
	if sptjbx == nil then return end
	local con = sptjbx.wLv
	if con == nil then return end
	local lst = sptjbx[con]
	if type(lst) ~= type({}) then 
		return
	end
	local room_nums = {}
	for k, v in ipairs(lst) do
		if type(v) == type({}) and type(v.rooms) == type({}) then
			room_nums[k] = #(v.rooms)
		end
	end
	RPCEx(sid,'sptjbx_sList',1,con,#lst,room_nums)
end

-- ��ȡ�����б� idx --  ��������
function sptjbx_get_rooms(sid,con,idx)
	if sid == nil or con == nil or idx == nil then return end
	local lv = CI_GetPlayerData(1,2,sid) or 1
	if lv < 40 then
		look('sptjbx_get_server level < 50')
		return
	end
	local state = GetSpanActiveState(SPAN_TJBX_ID)
	if state == nil then
		look('sptjbx_get_rooms active has end',1)
		return
	end
	local sptjbx = GetSpanListData(SPAN_TJBX_ID)
	if sptjbx == nil or sptjbx[con] == nil then return end
	local wLv = sptjbx.wLv
	if wLv == nil or wLv ~= con then 
		look('sptjbx_get_server con not correct',1)
		return 
	end
	local sInfo = sptjbx[con][idx]
	if sInfo == nil then 
		look('sptjbx_get_server idx error',1)
		return
	end	
	-- ���ͷ�����Ϣ��ǰ̨
	RPCEx(sid,'sptjbx_rooms',SPAN_TJBX_ID,con,idx,sInfo.rooms)
end

-- ���BOSS�������
-- mapGID = 0 ��̨ѡ�񷿼�
function sptjbx_enter_server(sid, pass, loc_ip, loc_port, loc_entryid, idx, mapGID)
	if pass == nil or loc_ip == nil or loc_port == nil or loc_entryid == nil or idx == nil or mapGID == nil then
		return
	end
	if loc_entryid == 0 then return end
	-- �жϻ�Ƿ���
	local state = GetSpanActiveState(SPAN_TJBX_ID)
	if state == nil then
		RPCEx(sid,'sptjbx_enter',3)		-- ��ѽ���
		return
	end
	-- �жϵȼ�
	local lv = CI_GetPlayerData(1,2,sid) or 1
	if lv < 40 then
		return
	end
	-- �ж��Ƿ��������BUFF 5����
	local now = GetServerTime()
	local lt = GetSpanLeaveTime(sid,SPAN_TJBX_ID) or 0		
	if now < lt then
		look('sptjbx_enter_server leavsp cd')
		return
	end
	
	local sptjbx = GetSpanListData(SPAN_TJBX_ID)
	if sptjbx == nil then return end
	local con = sptjbx.wLv
	if con == nil or sptjbx[con] == nil then 
		look('sptjbx_enter_server con not correct',1)
		return 
	end
	local sInfo = sptjbx[con][idx]
	if sInfo == nil then 
		look('sptjbx_enter_server idx error',1)
		return
	end	
	local rooms = sInfo.rooms
	if type(rooms) ~= type({}) then
		RPCEx(sid,'sptjbx_enter',3)		-- ��ѽ���
		return
	end
	-- �жϷ����ͼGID����ȷ�Լ������Ƿ���
	local tagGID,roomid = GetSpanRoomGID(rooms,mapGID)
	if tagGID == -1 then	-- ���䱬��
		RPCEx(sid,'sptjbx_enter',1,idx,con,rooms)
		return
	elseif tagGID == 0 then	-- û�ҵ�����
		RPCEx(sid,'sptjbx_enter',2,idx,con,rooms)
		return
	else					-- �ҵ���Ӧ�ķ���
		RPCEx(sid,'sptjbx_enter',0,roomid)		-- ������
	end	
	-- �������ѡ����Ϣ(��ǰ���ź͵�ǰ��ͼ���)
	SetPlayerSpanUID(sid,SPAN_TJBX_ID)
	SetPlayerSpanGID(sid,tagGID)

	local svrid = GetTargetSvrID(sInfo[1])
	look('svrid:' .. tostring(svrid))
	-- ������������
	PI_EnterSpanServerEx(sid, svrid, sInfo[2], sInfo[3], pass, loc_ip, loc_port, loc_entryid)
end

-- �����[1�����û������־ 2��ɾ�������б������Ϣ]
function sptjbx_end_proc()
	-- ���û������־
	SetSpanActiveState(SPAN_TJBX_ID,nil)
	-- ������BOSS���Ϣ(ɾ�������б������Ϣ)
	ClrSpanListData(SPAN_TJBX_ID)
	-- �㲥�����
	BroadcastRPC('sptjbx_end')
end