--------------------------------------------------------------------------
--include:
local _debug 		= __debug
local tostring 		= tostring
local jextype 		= jex.ttype
local look 			= look
local common 		= require('Script.common.Log')
local Log 			= common.Log

--------------------------------------------------------------------------
-- data:

-- ����������Ϣ����
local _s2s_def_local = noassign{
	-- [1001] = function () end,			-- ���BOSS�
	-- [2001] = function () end,			-- ���Ѱ���
	-- [3001] = function () end,			-- �������
	-- [4001] = function () end,			-- ���3v3�
	-- [5001] = function () end,			-- ����콵����
	-- [6001] = fucntion () end,			-- �������ս��
	-- [7001] = function () end,			-- ����������
	-- [8001] = function () end,			-- �����Ӹ���
}

-- ���������Ϣ����
local _s2s_def_server = noassign{
	-- [1001] = function () end,			-- ���BOSS�
	-- [2001] = function () end,			-- ���Ѱ���
	-- [3001] = function () end,			-- �������
	-- [4001] = function () end,			-- ���3v3�
	-- [5001] = function () end,			-- ����콵����
	-- [6001] = fucntion () end,			-- �������ս��
	-- [7001] = function () end,			-- ����������
	-- [8001] = function () end,			-- �����Ӹ���
}

-- ��װ���ط���������������֮�����Ϣ���ͺ���
local function _PI_SendSpanMsg(serverid,msg,subID)
	if type(serverid) ~= type(0) or type(msg) ~= type({}) then
		look('_PI_SendSpanMsg param error',1)
		return		
	end
	subID = subID or 0
	-- look('PI_SendSpanMsg:' .. tostring(serverid))
	CI_SendSpanMsg(serverid,msg,subID)
end

-- ��װ��������������ط���������Ϣ���ͺ���
local function _PI_SendToLocalSvr(serverid,msg,subID)
	if type(serverid) ~= type(0) or type(msg) ~= type({}) then
		look('_PI_SendSpanMsg param error',1)
		return		
	end
	subID = subID or 0
	msg.t = 1
	-- look('PI_SendSpanMsg:' .. tostring(serverid))
	CI_SendSpanMsg(serverid,msg,subID)
end

-- ��װ���ط��������������������Ϣ���ͺ���
local function _PI_SendToSpanSvr(serverid,msg,subID)
	if type(serverid) ~= type(0) or type(msg) ~= type({}) then
		look('_PI_SendSpanMsg param error',1)
		return		
	end
	subID = subID or 0
	msg.t = 2
	-- look('PI_SendSpanMsg:' .. tostring(serverid))
	CI_SendSpanMsg(serverid,msg,subID)
end

-- ��������������ط�������Ϣ������
-- ��Ҫ����ϢID�ж�
-- [local] msg.t = 1
-- [server] msg.t = 2
local function _OnSpanMessage(subID,msg)
	if subID == nil or subID ~= 0 or type(msg) ~= type({}) then
		look('_OnSpanMessage param error',1)
		return
	end
	local tp = msg.t
	if tp == nil then
		look('_OnSpanMessage msg type error 1',1)
		return
	end
	local func = nil
	if tp == 1 then
		func = _s2s_def_local
	elseif tp == 2 then
		func = _s2s_def_server
	end
	if func == nil then 
		look('_OnSpanMessage msg type error 2',1)
		return 
	end
	local msgids = msg.ids	
	--look('OnSpanMessage:' .. tostring(msgids))
	while jextype( func ) == 5 do
		func = func[msgids]
	end
	if ( jextype( func ) == 6 ) then
		func( msg )
	end
	-- look('OnSpanMessage complete')
end

--------------------------------------------------------------------------
-- interface:

s2s_def_local = _s2s_def_local
s2s_def_server = _s2s_def_server
PI_SendSpanMsg = _PI_SendSpanMsg
PI_SendToLocalSvr = _PI_SendToLocalSvr
PI_SendToSpanSvr = _PI_SendToSpanSvr
SI_OnSpanMessage = _OnSpanMessage