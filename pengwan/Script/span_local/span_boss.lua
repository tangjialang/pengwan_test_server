--[[
file: span_boss.lua
desc: 跨服BOSS活动
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

-- 活动编号
local SPAN_BOSS_ID = 1

-- 活动开始获取跨服boss活动大区列表
-- 每个服做120秒的随机延迟(分流作用)
function spboss_start_proc()
	local state = GetSpanActiveState(SPAN_BOSS_ID)
	if state then
		look('spboss_start_proc active not end',1)
		return
	end
	-- 测试值 记得修改
	local rdsec = math.random(1,100)	
	SetEvent(rdsec, nil, 'Evt_SpanBoss_start')
end

function Evt_SpanBoss_start()
	local spBoss = GetSpanListData(SPAN_BOSS_ID)
	if spBoss == nil then return end
	-- 活动开始 首先记录当前服的世界等级 防止活动期间 世界等级变更
	local wLv = GetSpanLevelApart()
	look('GetWorldLevel:' .. tostring(wLv))
	spBoss.wLv = wLv	
	-- 设置活动开始标志
	SetSpanActiveState(SPAN_BOSS_ID,1)
	-- 获取跨服BOSS活动大区列表(回调函数: CALLBACK_SpanServerGets)
	db_get_span_server(SPAN_BOSS_ID,wLv)	
	-- 广播活动开始
	BroadcastRPC('spboss_start')
end

-- 每秒从跨服取房间数据更新
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

-- 取跨服返回房间信息更新本地服务器房间信息
function spboss_set_rooms(uid,con,idx,rooms)
	if uid == nil or con == nil or idx == nil then return end
	if uid ~= SPAN_BOSS_ID then return end
	local spBoss = GetSpanListData(uid)
	if spBoss == nil or spBoss[con] == nil then return end
	local sInfo = spBoss[con][idx]
	if sInfo == nil then 
		return
	end	
	-- 更新房间信息
	sInfo.rooms = rooms
end

-- 玩家取跨服大区列表
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

-- 获取房间列表 idx --  大区索引
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

	-- 发送房间信息到前台
	RPCEx(sid,'spboss_rooms',SPAN_BOSS_ID,con,idx,sInfo.rooms)
end

-- 跨服BOSS进入大区
-- mapGID = 0 后台选择房间
function spboss_enter_server(sid, pass, loc_ip, loc_port, loc_entryid, idx, mapGID)
	if pass == nil or loc_ip == nil or loc_port == nil or loc_entryid == nil or idx == nil or mapGID == nil then
		return
	end
	if loc_entryid == 0 then return end
	-- 判断活动是否开启
	local state = GetSpanActiveState(SPAN_BOSS_ID)
	if state == nil then
		RPCEx(sid,'spboss_enter',3)		-- 活动已结束
		return
	end
	-- 判断等级
	local lv = CI_GetPlayerData(1,2,sid) or 1
	if lv < 50 then
		return
	end
	-- 判断是否带有逃跑BUFF 5分钟
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
		RPCEx(sid,'spboss_enter',3)		-- 活动已结束
		return
	end
	-- 判断房间地图GID的正确性及房间是否爆满
	local tagGID,roomid = GetSpanRoomGID(rooms,mapGID)
	if tagGID == -1 then	-- 房间爆满
		RPCEx(sid,'spboss_enter',1,idx,con,rooms)
		return
	elseif tagGID == 0 then	-- 没找到房间
		RPCEx(sid,'spboss_enter',2,idx,con,rooms)
		return
	else					-- 找到相应的房间
		RPCEx(sid,'spboss_enter',0,roomid)		-- 房间编号
	end	
	-- 保存玩家选择信息(当前活动编号和当前地图编号)
	SetPlayerSpanUID(sid,SPAN_BOSS_ID)
	SetPlayerSpanGID(sid,tagGID)

	local svrid = GetTargetSvrID(sInfo[1])
	look('svrid:' .. tostring(svrid))
	-- 进入跨服服务器
	PI_EnterSpanServerEx(sid, svrid, sInfo[2], sInfo[3], pass, loc_ip, loc_port, loc_entryid)
end

-- 活动结束[1、设置活动结束标志 2、删除大区列表相关信息]
function spboss_end_proc()
	-- 设置活动结束标志
	SetSpanActiveState(SPAN_BOSS_ID,nil)
	-- 清理跨服BOSS活动信息(删除大区列表相关信息)
	ClrSpanListData(SPAN_BOSS_ID)
	-- 广播活动结束
	BroadcastRPC('spboss_end')
end