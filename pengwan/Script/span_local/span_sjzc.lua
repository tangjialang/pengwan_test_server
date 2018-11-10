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
local SPAN_SJZC_ID = 6
local NeedLV = 35

-- 活动开始获取跨服boss活动大区列表
-- 每个服做120秒的随机延迟(分流作用)
function spsjzc_start_proc()
	local state = GetSpanActiveState(SPAN_SJZC_ID)
	if state then
		look('spsjzc_start_proc active not end',1)
		return
	end
	-- 测试值 记得修改
	local rdsec = math.random(1,100)	
	SetEvent(rdsec, nil, 'Evt_SpanSjzc_start')
end

function Evt_SpanSjzc_start()
	local spsjzc = GetSpanListData(SPAN_SJZC_ID)
	if spsjzc == nil then return end
	-- 活动开始 首先记录当前服的世界等级 防止活动期间 世界等级变更
	local wLv = GetSpanLevelApart()
	-- look('GetWorldLevel:' .. tostring(wLv),1)
	spsjzc.wLv = wLv	
	-- 设置活动开始标志
	SetSpanActiveState(SPAN_SJZC_ID,1)
	-- 获取跨服BOSS活动大区列表(回调函数: CALLBACK_SpanServerGets)
	db_get_span_server(SPAN_SJZC_ID,wLv)	
	-- 广播活动开始
	BroadcastRPC('spsjzc_start')
end

-- 每秒从跨服取房间数据更新
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

-- 取跨服返回房间信息更新本地服务器房间信息
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
	-- 更新房间信息
	sInfo.rooms = rooms
	-- look(rooms,1)
end

-- 玩家取跨服大区列表
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

-- 获取房间列表 idx --  大区索引
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

	-- 发送房间信息到前台
	RPCEx(sid,'spsjzc_rooms',SPAN_SJZC_ID,con,idx,sInfo.rooms)
end

-- 跨服BOSS进入大区
-- mapGID = 0 后台选择房间
function spsjzc_enter_server(sid, pass, loc_ip, loc_port, loc_entryid, idx, mapGID)
	-- look('spsjzc_enter_server',1)
	if pass == nil or loc_ip == nil or loc_port == nil or loc_entryid == nil or idx == nil or mapGID == nil then
		return
	end
	if loc_entryid == 0 then return end
	-- 判断活动是否开启
	local state = GetSpanActiveState(SPAN_SJZC_ID)
	if state == nil then
		RPCEx(sid,'spsjzc_enter',3)		-- 活动已结束
		return
	end
	-- 判断等级
	local lv = CI_GetPlayerData(1,2,sid) or 1
	if lv < NeedLV then
		return
	end
	-- 判断是否带有逃跑BUFF 5分钟
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
		RPCEx(sid,'spsjzc_enter',3)		-- 活动已结束
		return
	end
	-- 判断之前是否已经进入过房间
	local spsjzc_info = GetPlayerSpanInfo(sid,SPAN_SJZC_ID)
	if spsjzc_info == nil then return end
	if spsjzc_info[1] and spsjzc_info[2] and spsjzc_info[3] then
		if spsjzc_info[1] ~= idx or spsjzc_info[3] ~= mapGID then
			RPCEx(sid,'spsjzc_enter',4)			-- 选择房间不对
			return
		end
	end
	
	--如果没选择过房间
	if spsjzc_info[1] == nil or spsjzc_info[3] == nil then
		local tagGID,roomid = GetSpanRoomGID(rooms,mapGID)	
		if tagGID == -1 then	-- 房间爆满
			RPCEx(sid,'spsjzc_enter',1,idx,con,rooms)
			return
		elseif tagGID == 0 then	-- 没找到房间
			RPCEx(sid,'spsjzc_enter',2,idx,con,rooms)
			return
		else					-- 找到相应的房间
			RPCEx(sid,'spsjzc_enter',0,roomid)		-- 房间编号			
		end
		
		-- 设置进入的房间信息(需每日重置)
		spsjzc_info[1] = idx
		spsjzc_info[2] = roomid
		spsjzc_info[3] = tagGID
	end	
	
	-- 保存玩家选择信息(当前活动编号和当前地图编号)
	SetPlayerSpanUID(sid,SPAN_SJZC_ID)
	SetPlayerSpanGID(sid,spsjzc_info[3])

	local svrid = GetTargetSvrID(sInfo[1])
	-- look('svrid:' .. tostring(svrid),1)
	-- 进入跨服服务器
	PI_EnterSpanServerEx(sid, svrid, sInfo[2], sInfo[3], pass, loc_ip, loc_port, loc_entryid)
end

local _awards = {}
-- 跨服三界战场领奖
function spsjzc_give_award(sid)
	local state = GetSpanActiveState(SPAN_SJZC_ID)
	if state then
		look('spsjzc_give_award active not end',1)
		RPC('span_sjzc_award',1)		-- 活动未结束不能领奖
		return
	end
	
	local dayscore = sc_getdaydata(sid,6) or 0
	if dayscore <= 0 then
		sc_reset_getawards(sid,6)		-- 积分清0
		RPC('span_sjzc_award',2)
		return
	end
		-- 清理奖励表
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
	-- 只做统计(用于活跃度)
	CheckTimes(sid,TimesTypeTb.Fight_Time,1)			
	-- 设置领奖标志(积分清0)
	sc_reset_getawards(sid,6)
	local ret = GI_GiveAward(sid,_awards,"三界战场奖励")
	RPC('span_sjzc_award',0)
end

-- 每日重置房间信息
function spsjzc_clear_data(sid)
	local spsjzc_info = GetPlayerSpanInfo(sid,SPAN_SJZC_ID)
	if spsjzc_info == nil then return end
	spsjzc_info[1] = nil
	spsjzc_info[2] = nil
	spsjzc_info[3] = nil
end

-- 活动结束[1、设置活动结束标志 2、删除大区列表相关信息]
function spsjzc_end_proc()
	-- 设置活动结束标志
	SetSpanActiveState(SPAN_SJZC_ID,nil)
	-- 清理跨服BOSS活动信息(删除大区列表相关信息)
	ClrSpanListData(SPAN_SJZC_ID)
	-- 广播活动结束
	BroadcastRPC('spsjzc_end')
end