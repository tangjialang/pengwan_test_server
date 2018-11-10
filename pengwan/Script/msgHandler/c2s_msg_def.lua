--[[
file:	msgDefine.lua
desc:	difine 1st msg idx & given common interface to c++.
author:	chal
update:	2011-11-30
refix:	done by chal
2014-08-21: update by sxj, add _msgDispatcher[54]
]]--

--------------------------------------------------------------------------
--include:

local jextype = jex.ttype
local look = look
local tostring = tostring

--------------------------------------------------------------------------
-- data:

-- 1st def. Please given the 2nd def  in per functional files ,not here
local _msgDispatcher = {
	[1] = {},
	[2] = {},
	[3] = {},
	[4] = {},
	[5] = {},	
	[6] = {},
	[7] = {},
	[8] = {},
	[9] = {},
	[10] = {},
	[11] = {},	
	[12] = {},
	[13] = {}, --成就、活跃、目标
	[14] = {},
	[15] = {},
	[16] = {},
	[17] = {},	-- 结婚系统
	[18] = {},
	[19] = {},
	[20] = {},
	[21] = {},	-- 山庄妲己消息
	[22] = {},	-- 果园信息
	[23] = {},	-- 庄园宴会
	[24] = {},	-- 抽奖
	[25] = {},	-- 装饰
	[26] = {},	-- 庄园排位
	[27] = {},	-- 降魔录
	[28] = {},	-- 庄园掠夺
	[29] = {},	-- VIP
	[30] = {},	-- 庄园科技
	[31] = {},	-- 庄园宠物
	[32] = {},	-- 点金聚灵
	[33] = {},	-- 排行榜数据
	[34] = {},	-- 封神榜
	[35] = {},	-- 跨服BOSS活动的本服消息
	[36] = {},	-- 跨服寻宝活动的本服消息
	[37] = {},	-- 跨服捕鱼活动的本服消息
	[38] = {},  -- 神器
	[39] = {},  -- 跨服天降宝箱
	[40] = {},  -- 跨服三界战场
	[41] = {},	-- 聊天系统
	[42] = {},  -- 元神
	[43] = {},  -- 跨服组队副本
	[44] = {},  -- 神器印章显示
	[45] = {},  --1v1跨服副本
	
	[46] = {},  --夫妻组队副本
	[47] = {},  --FIFA World Cup
	[48] = {},  --元神武装
    [49] = {},  --经验神树
	[50] = {},   --奇珍阁
    [51] = {},   --本命法宝
	[52] = {},
	[53] = {},	--三界至尊
	[54] = {},	--帮会宝石迷阵
	--[[
		151 ~ 254 段预留给跨服消息
	]]--
	[151] = {},
	[152] = {},	-- 跨服BOSS活动
	[153] = {},	-- 跨服寻宝活动
	[154] = {},	-- 跨服3v3活动
	[155] = {},	-- 跨服三界战场
	[156] = {},	-- 跨服三界至尊
}

--------------------------------------------------------------------------
-- inner function:
-- msg interface
-- msg is a table from client
local function _OnLuaMessage( playerid, msg )	
	local idx = 1
	local func = _msgDispatcher
	local msgids = msg.ids	
	--look('msg_coming:{' .. tostring(msgids[1]) .. "," .. tostring(msgids[2])..'}')
	while jextype( func ) == 5 do
		func = func[msgids[idx]]
		idx = idx + 1
	end
	if ( jextype( func ) == 6 ) then
		local mainid = msgids[1]
		if mainid >= 151 then
			if not IsSpanServer() then	-- 只有跨服才会处理消息ID大于151的消息
				look('local server msg_coming:{' .. tostring(msgids[1]) .. "," .. tostring(msgids[2])..'}',1)
				return
			end
		end
		func( playerid, msg )
	end
	--look('OnLuaMessage complete')
end

local function _OnLuaCheck( playerid, msg)
	look("timeout lua msg:"..tostring(msg.ids[1])..","..tostring(msg.ids[2]),1)
	if msg.ids[1] == 4 and (msg.ids[2] == 1 or msg.ids[2] == 2 )then
		look("fbID:"..tostring(msg.fbID),1)
	elseif msg.ids[1] == 2 and msg.ids[2] == 1 then
		look("storyid:"..tostring(msg.storyid),1)
	elseif msg.ids[1] == 1 and ( msg.ids[2] == 2 or msg.ids[2] == 3 or msg.ids[2] == 5 ) then
		look("taskid:"..tostring(msg.taskid),1)
	end
end

--------------------------------------------------------------------------
-- interface:
msgDispatcher 	= _msgDispatcher

-- for C:
SI_OnLuaMessage = _OnLuaMessage
SI_OnLuaCheck 	= _OnLuaCheck