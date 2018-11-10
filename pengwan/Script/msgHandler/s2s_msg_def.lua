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

-- 本服请求消息定义
local _s2s_def_local = noassign{
	-- [1001] = function () end,			-- 跨服BOSS活动
	-- [2001] = function () end,			-- 跨服寻宝活动
	-- [3001] = function () end,			-- 跨服捕鱼活动
	-- [4001] = function () end,			-- 跨服3v3活动
	-- [5001] = function () end,			-- 跨服天降宝箱活动
	-- [6001] = fucntion () end,			-- 跨服三界战场
	-- [7001] = function () end,			-- 跨服帮会聊天
	-- [8001] = function () end,			-- 跨服组队副本
}

-- 跨服返回消息定义
local _s2s_def_server = noassign{
	-- [1001] = function () end,			-- 跨服BOSS活动
	-- [2001] = function () end,			-- 跨服寻宝活动
	-- [3001] = function () end,			-- 跨服捕鱼活动
	-- [4001] = function () end,			-- 跨服3v3活动
	-- [5001] = function () end,			-- 跨服天降宝箱活动
	-- [6001] = fucntion () end,			-- 跨服三界战场
	-- [7001] = function () end,			-- 跨服帮会聊天
	-- [8001] = function () end,			-- 跨服组队副本
}

-- 封装本地服务器与跨服服务器之间的消息发送函数
local function _PI_SendSpanMsg(serverid,msg,subID)
	if type(serverid) ~= type(0) or type(msg) ~= type({}) then
		look('_PI_SendSpanMsg param error',1)
		return		
	end
	subID = subID or 0
	-- look('PI_SendSpanMsg:' .. tostring(serverid))
	CI_SendSpanMsg(serverid,msg,subID)
end

-- 封装跨服服务器到本地服务器的消息发送函数
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

-- 封装本地服务器到跨服服务器的消息发送函数
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

-- 跨服服务器到本地服务器消息处理函数
-- 需要做消息ID判断
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