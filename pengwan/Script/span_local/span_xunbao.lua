--[[
file: span_xunbao.lua
desc: ���Ѱ���
autor: zld
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
local SPAN_XUNBAO_ID = 2

-- ���ʼ��ȡ���Ѱ��������б�
-- ÿ������120�������ӳ�(��������)
function spxb_start_proc()
	-- look('spxb start proc', 1)
	local state = GetSpanActiveState(SPAN_XUNBAO_ID)
	if state then
		-- look('spxb_start_proc active not end', 1)
		return
	end
	-- ����ֵ �ǵ��޸�
	local rdsec = math.random(1,100)	
	SetEvent(rdsec, nil, 'Evt_SpanXunbao_start')
end

function Evt_SpanXunbao_start()
	local spXunbao = GetSpanListData(SPAN_XUNBAO_ID)
	if spXunbao == nil then return end
	-- ���ʼ ���ȼ�¼��ǰ��������ȼ� ��ֹ��ڼ� ����ȼ����
	local wLv = GetSpanLevelApart()
	-- wLv = 50
	spXunbao.wLv = wLv	
	-- look('GetWorldLevel:' .. tostring(spXunbao.wLv),1)
	-- ���û��ʼ��־
	SetSpanActiveState(SPAN_XUNBAO_ID,1)
	-- ��ȡ���Ѱ��������б�(�ص�����: CALLBACK_SpanServerGets)
	db_get_span_server(SPAN_XUNBAO_ID,wLv)	
	-- �㲥���ʼ
	BroadcastRPC('spxb_start')
end

-- ÿ��ӿ��ȡ�������ݸ���
function Evt_spxb_rooms(uid,con)
	-- look('Evt_spxb_rooms start')
	if uid == nil or con == nil then return end
	if uid ~= SPAN_XUNBAO_ID then return end
	local spXunbao = GetSpanListData(uid)
	if spXunbao == nil then return end
	local rs = spXunbao[con]
	if rs == nil then
		return
	end
	
	for k, v in ipairs(rs) do
		PI_SendSpanMsg(v[1], {t = 2, ids = 2001, svrid = GetGroupID(), uid = uid, con = con, idx = k}, 0)
	end
	-- look('Evt_spxb_rooms end')
	return 1
end

-- ȡ������ط�����Ϣ���±��ط�����������Ϣ
function spxb_set_rooms(uid,con,idx,rooms)
	if uid == nil or con == nil or idx == nil then return end
	if uid ~= SPAN_XUNBAO_ID then return end
	local spXunbao = GetSpanListData(uid)
	if spXunbao == nil or spXunbao[con] == nil then return end
	local sInfo = spXunbao[con][idx]
	if sInfo == nil then 
		return
	end	
	-- ���·�����Ϣ
	sInfo.rooms = rooms
end

-- ���ȡ��������б�
function spxb_get_server(sid)
	local lv = CI_GetPlayerData(1,2,sid) or 1
	if lv < 50 then
		return
	end
	local state = GetSpanActiveState(SPAN_XUNBAO_ID)
	if state == nil then
		-- look('spxb_get_server active has end')
		return
	end
	local spXunbao = GetSpanListData(SPAN_XUNBAO_ID)
	if spXunbao == nil then return end
	local conLv = spXunbao.wLv
	if conLv == nil then return end
	local lst = spXunbao[conLv] --�����б�
	if type(lst) ~= type({}) then 
		return
	end
	local room_nums = {}
	for k, v in ipairs(lst) do
		if type(v) == type({}) and type(v.rooms) == type({}) then
			room_nums[k] = #(v.rooms) --������������
		end
	end
	RPCEx(sid,'spxb_sList',1,conLv,#lst,room_nums)
end

-- ��ȡ�����б� idx --  ��������
function spxb_get_rooms(sid,con,idx)
	if sid == nil or con == nil or idx == nil then return end
	local lv = CI_GetPlayerData(1,2,sid) or 1
	if lv < 50 then
		-- look('spxb_get_server level < 50')
		return
	end
	local state = GetSpanActiveState(SPAN_XUNBAO_ID)
	if state == nil then
		-- look('spxb_get_rooms active has end')
		return
	end
	local spXunbao = GetSpanListData(SPAN_XUNBAO_ID)
	if spXunbao == nil or spXunbao[con] == nil then return end
	local wLv = spXunbao.wLv
	if wLv == nil or wLv ~= con then 
		-- look('spxb_get_server con not correct')
		return 
	end
	local sInfo = spXunbao[con][idx]
	if sInfo == nil then 
		-- look('spxb_get_server idx error')
		return
	end	

	-- ���ͷ�����Ϣ��ǰ̨
	RPCEx(sid,'spxb_rooms',SPAN_XUNBAO_ID,con,idx,sInfo.rooms)
end

-- ���Ѱ���������
-- mapGID = 0 ��̨ѡ�񷿼�
function spxb_enter_server(sid, pass, loc_ip, loc_port, loc_entryid, idx, mapGID)
	-- if pass == nil or loc_ip == nil or loc_port == nil or loc_entryid == nil or idx == nil or mapGID == nil then
	if pass == nil or loc_ip == nil or loc_port == nil or loc_entryid == nil or mapGID == nil then
		return
	end
	mapGID = 0
	if loc_entryid == 0 then return end
	-- �жϻ�Ƿ���
	local state = GetSpanActiveState(SPAN_XUNBAO_ID)
	if state == nil then
		RPCEx(sid,'spxb_enter',3)		-- ��ѽ���
		return
	end
	-- �жϵȼ�
	local lv = CI_GetPlayerData(1,2,sid) or 1
	if lv < 50 then
		return
	end
	--[[
	-- �ж��Ƿ��������BUFF 5����
	local now = GetServerTime()
	local lt = GetSpanLeaveTime(sid) or 0	
	look('lt = ' .. lt,1)
	if now < lt then
		look('spxb_enter_server leavsp cd',1)
		return
	end
	--]]
	local spXunbao = GetSpanListData(SPAN_XUNBAO_ID)
	if spXunbao == nil then return end
	local con = spXunbao.wLv
	if con == nil or spXunbao[con] == nil then 
		-- look('spxb_enter_server con not correct')
		return 
	end
	-- local sInfo = spXunbao[con][idx]
	local sInfo = spXunbao[con][1]
	if sInfo == nil then 
		-- look('spxb_enter_server idx error')
		return
	end	
	-- local rooms = sInfo.rooms
	-- if type(rooms) ~= type({}) then
		-- RPCEx(sid,'spxb_enter',3)		-- ��ѽ���
		-- return
	-- end
	--[[
	-- �жϷ����ͼGID����ȷ�Լ������Ƿ���
	local tagGID,roomid = GetSpanRoomGID(rooms,mapGID)
	if tagGID == -1 then	-- ���䱬��
		RPCEx(sid,'spxb_enter',1,idx,con,rooms)
		return
	elseif tagGID == 0 then	-- û�ҵ�����
		RPCEx(sid,'spxb_enter',2,idx,con,rooms)
		return
	else					-- �ҵ���Ӧ�ķ���
		RPCEx(sid,'spxb_enter',0,roomid)		-- ������
	end	
	--]]
	-- local tagGID,roomid = GetSpanRoomGID(rooms,mapGID)
	-- �������ѡ����Ϣ(��ǰ���ź͵�ǰ��ͼ���)
	SetPlayerSpanUID(sid,SPAN_XUNBAO_ID)
	SetPlayerSpanGID(sid,0)

	local svrid = GetTargetSvrID(sInfo[1])
	-- look('svrid:' .. tostring(svrid))
	-- ������������
	PI_EnterSpanServerEx(sid, svrid, sInfo[2], sInfo[3], pass, loc_ip, loc_port, loc_entryid)
end

-- �����[1�����û������־ 2��ɾ�������б������Ϣ]
function spxb_end_proc()
	-- ���û������־
	SetSpanActiveState(SPAN_XUNBAO_ID,nil)
	-- ������Ѱ�����Ϣ(ɾ�������б������Ϣ)
	ClrSpanListData(SPAN_XUNBAO_ID)
	-- �㲥�����
	BroadcastRPC('spxb_end')
	-- look('spxb loc end', 1)
end