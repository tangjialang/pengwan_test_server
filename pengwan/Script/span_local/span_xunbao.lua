--[[
file: span_xunbao.lua
desc: 跨服寻宝活动
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

-- 活动编号
local SPAN_XUNBAO_ID = 2

-- 活动开始获取跨服寻宝活动大区列表
-- 每个服做120秒的随机延迟(分流作用)
function spxb_start_proc()
	-- look('spxb start proc', 1)
	local state = GetSpanActiveState(SPAN_XUNBAO_ID)
	if state then
		-- look('spxb_start_proc active not end', 1)
		return
	end
	-- 测试值 记得修改
	local rdsec = math.random(1,100)	
	SetEvent(rdsec, nil, 'Evt_SpanXunbao_start')
end

function Evt_SpanXunbao_start()
	local spXunbao = GetSpanListData(SPAN_XUNBAO_ID)
	if spXunbao == nil then return end
	-- 活动开始 首先记录当前服的世界等级 防止活动期间 世界等级变更
	local wLv = GetSpanLevelApart()
	-- wLv = 50
	spXunbao.wLv = wLv	
	-- look('GetWorldLevel:' .. tostring(spXunbao.wLv),1)
	-- 设置活动开始标志
	SetSpanActiveState(SPAN_XUNBAO_ID,1)
	-- 获取跨服寻宝活动大区列表(回调函数: CALLBACK_SpanServerGets)
	db_get_span_server(SPAN_XUNBAO_ID,wLv)	
	-- 广播活动开始
	BroadcastRPC('spxb_start')
end

-- 每秒从跨服取房间数据更新
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

-- 取跨服返回房间信息更新本地服务器房间信息
function spxb_set_rooms(uid,con,idx,rooms)
	if uid == nil or con == nil or idx == nil then return end
	if uid ~= SPAN_XUNBAO_ID then return end
	local spXunbao = GetSpanListData(uid)
	if spXunbao == nil or spXunbao[con] == nil then return end
	local sInfo = spXunbao[con][idx]
	if sInfo == nil then 
		return
	end	
	-- 更新房间信息
	sInfo.rooms = rooms
end

-- 玩家取跨服大区列表
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
	local lst = spXunbao[conLv] --大区列表
	if type(lst) ~= type({}) then 
		return
	end
	local room_nums = {}
	for k, v in ipairs(lst) do
		if type(v) == type({}) and type(v.rooms) == type({}) then
			room_nums[k] = #(v.rooms) --各大区房间数
		end
	end
	RPCEx(sid,'spxb_sList',1,conLv,#lst,room_nums)
end

-- 获取房间列表 idx --  大区索引
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

	-- 发送房间信息到前台
	RPCEx(sid,'spxb_rooms',SPAN_XUNBAO_ID,con,idx,sInfo.rooms)
end

-- 跨服寻宝进入大区
-- mapGID = 0 后台选择房间
function spxb_enter_server(sid, pass, loc_ip, loc_port, loc_entryid, idx, mapGID)
	-- if pass == nil or loc_ip == nil or loc_port == nil or loc_entryid == nil or idx == nil or mapGID == nil then
	if pass == nil or loc_ip == nil or loc_port == nil or loc_entryid == nil or mapGID == nil then
		return
	end
	mapGID = 0
	if loc_entryid == 0 then return end
	-- 判断活动是否开启
	local state = GetSpanActiveState(SPAN_XUNBAO_ID)
	if state == nil then
		RPCEx(sid,'spxb_enter',3)		-- 活动已结束
		return
	end
	-- 判断等级
	local lv = CI_GetPlayerData(1,2,sid) or 1
	if lv < 50 then
		return
	end
	--[[
	-- 判断是否带有逃跑BUFF 5分钟
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
		-- RPCEx(sid,'spxb_enter',3)		-- 活动已结束
		-- return
	-- end
	--[[
	-- 判断房间地图GID的正确性及房间是否爆满
	local tagGID,roomid = GetSpanRoomGID(rooms,mapGID)
	if tagGID == -1 then	-- 房间爆满
		RPCEx(sid,'spxb_enter',1,idx,con,rooms)
		return
	elseif tagGID == 0 then	-- 没找到房间
		RPCEx(sid,'spxb_enter',2,idx,con,rooms)
		return
	else					-- 找到相应的房间
		RPCEx(sid,'spxb_enter',0,roomid)		-- 房间编号
	end	
	--]]
	-- local tagGID,roomid = GetSpanRoomGID(rooms,mapGID)
	-- 保存玩家选择信息(当前活动编号和当前地图编号)
	SetPlayerSpanUID(sid,SPAN_XUNBAO_ID)
	SetPlayerSpanGID(sid,0)

	local svrid = GetTargetSvrID(sInfo[1])
	-- look('svrid:' .. tostring(svrid))
	-- 进入跨服服务器
	PI_EnterSpanServerEx(sid, svrid, sInfo[2], sInfo[3], pass, loc_ip, loc_port, loc_entryid)
end

-- 活动结束[1、设置活动结束标志 2、删除大区列表相关信息]
function spxb_end_proc()
	-- 设置活动结束标志
	SetSpanActiveState(SPAN_XUNBAO_ID,nil)
	-- 清理跨服寻宝活动信息(删除大区列表相关信息)
	ClrSpanListData(SPAN_XUNBAO_ID)
	-- 广播活动结束
	BroadcastRPC('spxb_end')
	-- look('spxb loc end', 1)
end