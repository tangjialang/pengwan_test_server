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
local SPAN_SJZC_ID = 6
local NeedLV = 35

-- ���ʼ��ȡ���boss������б�
-- ÿ������120�������ӳ�(��������)
function spsjzc_start_proc()
	local state = GetSpanActiveState(SPAN_SJZC_ID)
	if state then
		look('spsjzc_start_proc active not end',1)
		return
	end
	-- ����ֵ �ǵ��޸�
	local rdsec = math.random(1,100)	
	SetEvent(rdsec, nil, 'Evt_SpanSjzc_start')
end

function Evt_SpanSjzc_start()
	local spsjzc = GetSpanListData(SPAN_SJZC_ID)
	if spsjzc == nil then return end
	-- ���ʼ ���ȼ�¼��ǰ��������ȼ� ��ֹ��ڼ� ����ȼ����
	local wLv = GetSpanLevelApart()
	-- look('GetWorldLevel:' .. tostring(wLv),1)
	spsjzc.wLv = wLv	
	-- ���û��ʼ��־
	SetSpanActiveState(SPAN_SJZC_ID,1)
	-- ��ȡ���BOSS������б�(�ص�����: CALLBACK_SpanServerGets)
	db_get_span_server(SPAN_SJZC_ID,wLv)	
	-- �㲥���ʼ
	BroadcastRPC('spsjzc_start')
end

-- ÿ��ӿ��ȡ�������ݸ���
function Evt_spsjzc_rooms(uid,con)
	-- look('Evt_spsjzc_rooms',1)
	if uid == nil or con == nil then return end
	if uid ~= SPAN_SJZC_ID then return end
	local spsjzc = GetSpanListData(uid)
	if spsjzc == nil then return end
	local rs = spsjzc[con]
	if rs == nil then
		return
	end
	
	for k, v in ipairs(rs) do
		PI_SendToSpanSvr(v[1], {ids = 6001, svrid = GetGroupID(), uid = uid, con = con, idx = k}, 0)
	end
	return 1
end

-- ȡ������ط�����Ϣ���±��ط�����������Ϣ
function spsjzc_set_rooms(uid,con,idx,rooms)	
	-- look('spsjzc_set_rooms',1)
	if uid == nil or con == nil or idx == nil then return end
	if uid ~= SPAN_SJZC_ID then return end
	local spsjzc = GetSpanListData(uid)
	if spsjzc == nil or spsjzc[con] == nil then return end
	local sInfo = spsjzc[con][idx]
	if sInfo == nil then 
		return
	end	
	-- ���·�����Ϣ
	sInfo.rooms = rooms
	-- look(rooms,1)
end

-- ���ȡ��������б�
function spsjzc_get_server(sid)
	local lv = CI_GetPlayerData(1,2,sid) or 1
	if lv < NeedLV then
		return
	end
	local state = GetSpanActiveState(SPAN_SJZC_ID)
	if state == nil then
		look('spsjzc_get_server active has end',1)
		return
	end
	local spsjzc = GetSpanListData(SPAN_SJZC_ID)
	if spsjzc == nil then return end
	local con = spsjzc.wLv
	if con == nil then return end
	local lst = spsjzc[con]
	if type(lst) ~= type({}) then 
		return
	end
	local room_nums = {}
	for k, v in ipairs(lst) do
		if type(v) == type({}) and type(v.rooms) == type({}) then
			room_nums[k] = #(v.rooms)
		end
	end
	RPCEx(sid,'spsjzc_sList',1,con,#lst,room_nums)
end

-- ��ȡ�����б� idx --  ��������
function spsjzc_get_rooms(sid,con,idx)
	if sid == nil or con == nil or idx == nil then return end
	local lv = CI_GetPlayerData(1,2,sid) or 1
	if lv < NeedLV then
		look('spsjzc_get_server level < 35')
		return
	end
	local state = GetSpanActiveState(SPAN_SJZC_ID)
	if state == nil then
		look('spsjzc_get_rooms active has end',1)
		return
	end
	local spsjzc = GetSpanListData(SPAN_SJZC_ID)
	if spsjzc == nil or spsjzc[con] == nil then return end
	local wLv = spsjzc.wLv
	if wLv == nil or wLv ~= con then 
		look('spsjzc_get_server con not correct',1)
		return 
	end
	local sInfo = spsjzc[con][idx]
	if sInfo == nil then 
		look('spsjzc_get_server idx error',1)
		return
	end	

	-- ���ͷ�����Ϣ��ǰ̨
	RPCEx(sid,'spsjzc_rooms',SPAN_SJZC_ID,con,idx,sInfo.rooms)
end

-- ���BOSS�������
-- mapGID = 0 ��̨ѡ�񷿼�
function spsjzc_enter_server(sid, pass, loc_ip, loc_port, loc_entryid, idx, mapGID)
	-- look('spsjzc_enter_server',1)
	if pass == nil or loc_ip == nil or loc_port == nil or loc_entryid == nil or idx == nil or mapGID == nil then
		return
	end
	if loc_entryid == 0 then return end
	-- �жϻ�Ƿ���
	local state = GetSpanActiveState(SPAN_SJZC_ID)
	if state == nil then
		RPCEx(sid,'spsjzc_enter',3)		-- ��ѽ���
		return
	end
	-- �жϵȼ�
	local lv = CI_GetPlayerData(1,2,sid) or 1
	if lv < NeedLV then
		return
	end
	-- �ж��Ƿ��������BUFF 5����
	-- local now = GetServerTime()
	-- local lt = GetSpanLeaveTime(sid,SPAN_SJZC_ID) or 0		
	-- if now < lt then
		-- look('spsjzc_enter_server leavsp cd')
		-- return
	-- end
	
	local spsjzc = GetSpanListData(SPAN_SJZC_ID)
	if spsjzc == nil then return end
	local con = spsjzc.wLv
	if con == nil or spsjzc[con] == nil then 
		look('spsjzc_enter_server con not correct',1)
		return 
	end
	local sInfo = spsjzc[con][idx]
	if sInfo == nil then 
		look('spsjzc_enter_server idx error',1)
		return
	end	
	local rooms = sInfo.rooms
	if type(rooms) ~= type({}) then
		RPCEx(sid,'spsjzc_enter',3)		-- ��ѽ���
		return
	end
	-- �ж�֮ǰ�Ƿ��Ѿ����������
	local spsjzc_info = GetPlayerSpanInfo(sid,SPAN_SJZC_ID)
	if spsjzc_info == nil then return end
	if spsjzc_info[1] and spsjzc_info[2] and spsjzc_info[3] then
		if spsjzc_info[1] ~= idx or spsjzc_info[3] ~= mapGID then
			RPCEx(sid,'spsjzc_enter',4)			-- ѡ�񷿼䲻��
			return
		end
	end
	
	--���ûѡ�������
	if spsjzc_info[1] == nil or spsjzc_info[3] == nil then
		local tagGID,roomid = GetSpanRoomGID(rooms,mapGID)	
		if tagGID == -1 then	-- ���䱬��
			RPCEx(sid,'spsjzc_enter',1,idx,con,rooms)
			return
		elseif tagGID == 0 then	-- û�ҵ�����
			RPCEx(sid,'spsjzc_enter',2,idx,con,rooms)
			return
		else					-- �ҵ���Ӧ�ķ���
			RPCEx(sid,'spsjzc_enter',0,roomid)		-- ������			
		end
		
		-- ���ý���ķ�����Ϣ(��ÿ������)
		spsjzc_info[1] = idx
		spsjzc_info[2] = roomid
		spsjzc_info[3] = tagGID
	end	
	
	-- �������ѡ����Ϣ(��ǰ���ź͵�ǰ��ͼ���)
	SetPlayerSpanUID(sid,SPAN_SJZC_ID)
	SetPlayerSpanGID(sid,spsjzc_info[3])

	local svrid = GetTargetSvrID(sInfo[1])
	-- look('svrid:' .. tostring(svrid),1)
	-- ������������
	PI_EnterSpanServerEx(sid, svrid, sInfo[2], sInfo[3], pass, loc_ip, loc_port, loc_entryid)
end

local _awards = {}
-- �������ս���콱
function spsjzc_give_award(sid)
	local state = GetSpanActiveState(SPAN_SJZC_ID)
	if state then
		look('spsjzc_give_award active not end',1)
		RPC('span_sjzc_award',1)		-- �δ���������콱
		return
	end
	
	local dayscore = sc_getdaydata(sid,6) or 0
	if dayscore <= 0 then
		sc_reset_getawards(sid,6)		-- ������0
		RPC('span_sjzc_award',2)
		return
	end
		-- ��������
	for k, v in pairs(_awards) do
		_awards[k] = nil
	end
	
	local lv = CI_GetPlayerData(1,2,sid)
	if lv < 30 then lv = 30 end
	local field = (rint(dayscore / 100) + 4) / 10
	if field > 1 then field = 1 end
	local exps = rint( (lv ^ 2.2 * 27 * 9 * 7 / 8) * field )
	local zg = rint( ((lv ^ 2) / 4) * field )
	
	_awards[2] = exps
	_awards[7] = zg
	
	local getok = award_check_items(_awards)
	if not getok then
		return
	end
	-- ֻ��ͳ��(���ڻ�Ծ��)
	CheckTimes(sid,TimesTypeTb.Fight_Time,1)			
	-- �����콱��־(������0)
	sc_reset_getawards(sid,6)
	local ret = GI_GiveAward(sid,_awards,"����ս������")
	RPC('span_sjzc_award',0)
end

-- ÿ�����÷�����Ϣ
function spsjzc_clear_data(sid)
	local spsjzc_info = GetPlayerSpanInfo(sid,SPAN_SJZC_ID)
	if spsjzc_info == nil then return end
	spsjzc_info[1] = nil
	spsjzc_info[2] = nil
	spsjzc_info[3] = nil
end

-- �����[1�����û������־ 2��ɾ�������б������Ϣ]
function spsjzc_end_proc()
	-- ���û������־
	SetSpanActiveState(SPAN_SJZC_ID,nil)
	-- ������BOSS���Ϣ(ɾ�������б������Ϣ)
	ClrSpanListData(SPAN_SJZC_ID)
	-- �㲥�����
	BroadcastRPC('spsjzc_end')
end