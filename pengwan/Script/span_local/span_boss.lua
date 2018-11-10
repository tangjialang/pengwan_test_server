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
local db_module = require('Script.cext.dbrpc')
local db_get_span_server = db_module.db_get_span_server

-- ����
local SPAN_BOSS_ID = 1

-- ���ʼ��ȡ���boss������б�
-- ÿ������120�������ӳ�(��������)
function spboss_start_proc()
	local state = GetSpanActiveState(SPAN_BOSS_ID)
	if state then
		look('spboss_start_proc active not end',1)
		return
	end
	-- ����ֵ �ǵ��޸�
	local rdsec = math.random(1,100)	
	SetEvent(rdsec, nil, 'Evt_SpanBoss_start')
end

function Evt_SpanBoss_start()
	local spBoss = GetSpanListData(SPAN_BOSS_ID)
	if spBoss == nil then return end
	-- ���ʼ ���ȼ�¼��ǰ��������ȼ� ��ֹ��ڼ� ����ȼ����
	local wLv = GetSpanLevelApart()
	look('GetWorldLevel:' .. tostring(wLv))
	spBoss.wLv = wLv	
	-- ���û��ʼ��־
	SetSpanActiveState(SPAN_BOSS_ID,1)
	-- ��ȡ���BOSS������б�(�ص�����: CALLBACK_SpanServerGets)
	db_get_span_server(SPAN_BOSS_ID,wLv)	
	-- �㲥���ʼ
	BroadcastRPC('spboss_start')
end

-- ÿ��ӿ��ȡ�������ݸ���
function Evt_spboss_rooms(uid,con)
	if uid == nil or con == nil then return end
	if uid ~= SPAN_BOSS_ID then return end
	local spBoss = GetSpanListData(uid)
	if spBoss == nil then return end
	local rs = spBoss[con]
	if rs == nil then
		return
	end
	
	for k, v in ipairs(rs) do
		PI_SendSpanMsg(v[1], {t = 2, ids = 1001, svrid = GetGroupID(), uid = uid, con = con, idx = k}, 0)
	end
	return 1
end

-- ȡ������ط�����Ϣ���±��ط�����������Ϣ
function spboss_set_rooms(uid,con,idx,rooms)
	if uid == nil or con == nil or idx == nil then return end
	if uid ~= SPAN_BOSS_ID then return end
	local spBoss = GetSpanListData(uid)
	if spBoss == nil or spBoss[con] == nil then return end
	local sInfo = spBoss[con][idx]
	if sInfo == nil then 
		return
	end	
	-- ���·�����Ϣ
	sInfo.rooms = rooms
end

-- ���ȡ��������б�
function spboss_get_server(sid)
	local lv = CI_GetPlayerData(1,2,sid) or 1
	if lv < 50 then
		return
	end
	local state = GetSpanActiveState(SPAN_BOSS_ID)
	if state == nil then
		look('spboss_get_server active has end',1)
		return
	end
	local spBoss = GetSpanListData(SPAN_BOSS_ID)
	if spBoss == nil then return end
	local con = spBoss.wLv
	if con == nil then return end
	local lst = spBoss[con]
	if type(lst) ~= type({}) then 
		return
	end
	local room_nums = {}
	for k, v in ipairs(lst) do
		if type(v) == type({}) and type(v.rooms) == type({}) then
			room_nums[k] = #(v.rooms)
		end
	end
	RPCEx(sid,'spboss_sList',1,con,#lst,room_nums)
end

-- ��ȡ�����б� idx --  ��������
function spboss_get_rooms(sid,con,idx)
	if sid == nil or con == nil or idx == nil then return end
	local lv = CI_GetPlayerData(1,2,sid) or 1
	if lv < 50 then
		look('spboss_get_server level < 50')
		return
	end
	local state = GetSpanActiveState(SPAN_BOSS_ID)
	if state == nil then
		look('spboss_get_rooms active has end',1)
		return
	end
	local spBoss = GetSpanListData(SPAN_BOSS_ID)
	if spBoss == nil or spBoss[con] == nil then return end
	local wLv = spBoss.wLv
	if wLv == nil or wLv ~= con then 
		look('spboss_get_server con not correct',1)
		return 
	end
	local sInfo = spBoss[con][idx]
	if sInfo == nil then 
		look('spboss_get_server idx error',1)
		return
	end	

	-- ���ͷ�����Ϣ��ǰ̨
	RPCEx(sid,'spboss_rooms',SPAN_BOSS_ID,con,idx,sInfo.rooms)
end

-- ���BOSS�������
-- mapGID = 0 ��̨ѡ�񷿼�
function spboss_enter_server(sid, pass, loc_ip, loc_port, loc_entryid, idx, mapGID)
	if pass == nil or loc_ip == nil or loc_port == nil or loc_entryid == nil or idx == nil or mapGID == nil then
		return
	end
	if loc_entryid == 0 then return end
	-- �жϻ�Ƿ���
	local state = GetSpanActiveState(SPAN_BOSS_ID)
	if state == nil then
		RPCEx(sid,'spboss_enter',3)		-- ��ѽ���
		return
	end
	-- �жϵȼ�
	local lv = CI_GetPlayerData(1,2,sid) or 1
	if lv < 50 then
		return
	end
	-- �ж��Ƿ��������BUFF 5����
	local now = GetServerTime()
	local lt = GetSpanLeaveTime(sid,SPAN_BOSS_ID) or 0		
	if now < lt then
		look('spboss_enter_server leavsp cd')
		return
	end
	
	local spBoss = GetSpanListData(SPAN_BOSS_ID)
	if spBoss == nil then return end
	local con = spBoss.wLv
	if con == nil or spBoss[con] == nil then 
		look('spboss_enter_server con not correct',1)
		return 
	end
	local sInfo = spBoss[con][idx]
	if sInfo == nil then 
		look('spboss_enter_server idx error',1)
		return
	end	
	local rooms = sInfo.rooms
	if type(rooms) ~= type({}) then
		RPCEx(sid,'spboss_enter',3)		-- ��ѽ���
		return
	end
	-- �жϷ����ͼGID����ȷ�Լ������Ƿ���
	local tagGID,roomid = GetSpanRoomGID(rooms,mapGID)
	if tagGID == -1 then	-- ���䱬��
		RPCEx(sid,'spboss_enter',1,idx,con,rooms)
		return
	elseif tagGID == 0 then	-- û�ҵ�����
		RPCEx(sid,'spboss_enter',2,idx,con,rooms)
		return
	else					-- �ҵ���Ӧ�ķ���
		RPCEx(sid,'spboss_enter',0,roomid)		-- ������
	end	
	-- �������ѡ����Ϣ(��ǰ���ź͵�ǰ��ͼ���)
	SetPlayerSpanUID(sid,SPAN_BOSS_ID)
	SetPlayerSpanGID(sid,tagGID)

	local svrid = GetTargetSvrID(sInfo[1])
	look('svrid:' .. tostring(svrid))
	-- ������������
	PI_EnterSpanServerEx(sid, svrid, sInfo[2], sInfo[3], pass, loc_ip, loc_port, loc_entryid)
end

-- �����[1�����û������־ 2��ɾ�������б������Ϣ]
function spboss_end_proc()
	-- ���û������־
	SetSpanActiveState(SPAN_BOSS_ID,nil)
	-- ������BOSS���Ϣ(ɾ�������б������Ϣ)
	ClrSpanListData(SPAN_BOSS_ID)
	-- �㲥�����
	BroadcastRPC('spboss_end')
end