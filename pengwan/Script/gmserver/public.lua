--[[
file: public.lua
desc: 公告系统
autor: csj
update: 2013-8-17
]]--

-----------------------------------------------------
--include:
local pairs,type = pairs,type
local tostring = tostring
local os_time = os.time

local look = look
local GetServerTime = GetServerTime
local TipCBrodCast = TipCBrodCast
local TipABrodCast = TipABrodCast
local TipChatBar = TipChatBar
local SetEvent = SetEvent

local define = require('Script.cext.define')
local Server_Event = define.Server_Event
local db_module = require('Script.cext.dbrpc')
local db_get_public = db_module.db_get_public
local common_time = require('Script.common.time_cnt')
local analyze_time = common_time.analyze_time

-----------------------------------------------------
--module:

module(...)

-----------------------------------------------------
--inner:

public_tb = public_tb or {}

local function _public_timer()
	SetEvent(30,Server_Event.public,'SI_public_event',30)
end

local function _on_public_rpc()
	db_get_public()
	return 0
end

-- [1] 公告内容 [2] 类型 [3] 次数 [4] 间隔(分钟) [5] 开始时间 [6] 结束时间
local function _on_public_event()
	local now = GetServerTime()
	for k, v in pairs(public_tb) do
		if type(v) == type({}) then
			local con,tp,ct,seq,bt,et = v[1],v[2],v[3],v[4],v[5],v[6]
			if now >= bt and now < et and ct > (v.pass or 0) and now >= (v.next or 0) then
				if tp == 0 then
					TipCBrodCast(con)
				elseif tp == 1 then
					TipABrodCast(con)
				elseif tp == 2 then
					TipChatBar(con)
				end
				v.next = now + seq*60			-- 下次发送时间
				v.pass = (v.pass or 0) + 1		-- 已发送次数
				if v.pass >= ct then
					public_tb[k] = nil			-- 发完了就清空
				end
			end
		end
	end
end

-- [1] 公告id [2] 公告内容 [3] 类型 [4] 次数 [5] 间隔(分钟) [6] 开始时间 [7] 结束时间
function _callback_get_public(rs)
	look('_callback_get_public')
	look(rs)
	if type(rs) ~= type({}) then
		return
	end
	for k, v in pairs(rs) do
		if type(v) == type({}) then
			local bt = os_time(analyze_time(v[6],1))
			local et = os_time(analyze_time(v[7],1))
			if public_tb[v[1]] == nil then
				public_tb[v[1]] = {v[2],v[3],v[4],v[5],bt,et}
			else
				local t = public_tb[v[1]]
				t[1] = v[2]
				t[2] = v[3]
				t[3] = v[4]
				t[4] = v[5]
				t[5] = bt
				t[6] = et
			end
		end
	end
	for k, v in pairs(public_tb) do
		if type(k) == type(0) and type(v) == type({}) then
			local res
			for h,j in pairs(rs) do
				if type(j) == type({}) then
					if j[1]==k then 
						res=true
					end
				end
			end
			if not res then 
				public_tb[k] = nil
			end
			-- if rs[k] == nil then
			-- 	public_tb[k] = nil
			-- end
		end
	end
end

--------------------------------------------------
--interface:

public_timer = _public_timer
on_public_rpc = _on_public_rpc
on_public_event = _on_public_event
callback_get_public = _callback_get_public

-- on_public_rpc()
