--[[
file: kf_drx.lua
desc: 开服达人秀
autor: csj
]]--

-----------------------------------------------------------
--include:
local type = type
local tostring = tostring
local __G = _G
local CI_GetPlayerData = CI_GetPlayerData
local award_check_items = award_check_items
local GI_GiveAward = GI_GiveAward
local BroadcastRPC = BroadcastRPC
local look = look
local RPC = RPC
local RPCEx = RPCEx
local rint = rint
local get_mounts_lv = get_mounts_lv
local GetServerTime = GetServerTime
local GetServerOpenTime = GetServerOpenTime


local db_module = require('Script.cext.dbrpc')
local db_drx2_award = db_module.db_drx2_award
local db_drx2_rollback = db_module.db_drx2_rollback

-----------------------------------------------------------
--module:

module(...)

------------------------------------------------------------
--inner:

local drx_conf = {
	[1] = {		-- 人物等级
		[1] = { plv = 38, num = -1, awards = {[3] = {{3002,1,1}},[4] = 200,}},
		[2] = { plv = 44, num = -1, awards = {[3] = {{3002,1,1},{672,5,1}},}},   
	},
	[2] = {		-- 坐骑阶数
		[1] = { zqlv = 10, num = -1, awards = {[3] = {{3009,1,1}},[4] = 200,}},
		[2] = { zqlv = 30, num = -1, awards = {[3] = {{3010,1,1},{627,50,1}},}}, 
	},
	[3] = {		-- 装备强化等级和
		[1] = { qhlv = 60, num = -1, awards = {[3] = {{3007,1,1}},[4] = 200,}},
		[2] = { qhlv = 120, num = -1, awards = {[3] = {{3007,1,1},{601,100,1}},}}, 
	},
	[4] = {		-- 战斗力
		[1] = { fight = 10000, num = -1, awards = {[3] = {{3002,1,1}},[4] = 200,}},
		[2] = { fight = 30000, num = -1, awards = {[3] = {{3007,1,1},{601,100,1}},}}, 
	},
	[5] = {		-- 装备宝石数量
		[1] = { bsnum = 30, num = -1, awards = {[3] = {{3004,1,1}},[4] = 200,}},
		[2] = { bsnum = 70, num = -1, awards = {[3] = {{3004,1,1},{626,50,1}},}}, 
	},
	[6] = {		-- 法宝阶数
		[1] = { fblv = 10, num = -1, awards = {[3] = {{3004,1,1}},[4] = 200,}},
		[2] = { fblv = 30, num = -1, awards = {[3] = {{3004,1,1},{627,50,1}},}}, 
	},
	[7] = {		-- 战斗力
		[1] = { fight = 20000, num = -1, awards = {[3] = {{3002,1,1}},[4] = 200,}},
		[2] = { fight = 40000, num = -1, awards = {[3] = {{3002,1,1},{637,20,1}},}}, 
	},
}

local function _drx2_give_award(sid,itype,idx)
	if sid == nil or itype == nil or idx == nil then
		return
	end
	if drx_conf[itype] == nil or drx_conf[itype][idx] == nil then
		return
	end
	local now = GetServerTime()
	local openTime = GetServerOpenTime()
	if rint(now/(24*3600)) - rint(openTime/(24*3600)) >= 10 then
		look('_drx_give_award time out')
		return
	end
	local t = drx_conf[itype][idx]
	if not award_check_items(t.awards) then
		return
	end
	local maxnum = t.num
	local cond = true
	if itype == 1 then			-- 玩家等级
		local lv = CI_GetPlayerData(1)
		look('lv:' .. tostring(lv))
		if lv == nil or lv <= 0 then return end
		if lv < t.plv then				
			cond = false
		end
	elseif itype == 2 then		-- 坐骑阶数
		local zqlv = get_mounts_lv(sid) or 0
		look('zqlv:' .. tostring(zqlv))
		if zqlv < t.zqlv then
			cond = false
		end
	elseif itype == 3 then		-- 装备强化等级和
		local qhlv = CI_GetPlayerData(38)
		look('qhlv:' .. tostring(qhlv))
		if qhlv == nil or qhlv <= 0 then return end
		if qhlv < t.qhlv then				
			cond = false
		end	
	elseif itype == 4 then		-- 战斗力
		local fight = CI_GetPlayerData(62)
		look('fight:' .. tostring(fight))
		if fight == nil or fight <= 0 then return end
		if fight < t.fight then				
			cond = false
		end
	elseif itype == 5 then		-- 装备宝石数量
		local bsnum = CI_GetPlayerData(40)
		look('bsnum:' .. tostring(bsnum))
		if bsnum == nil or bsnum <= 0 then return end
		if bsnum < t.bsnum then				
			cond = false
		end
	elseif itype == 6 then		-- 法宝阶数
		local batlv = __G.get_battlelv( sid ) or 0
		look('batlv:' .. tostring(batlv))
		if batlv < t.fblv then
			cond = false
		end
	elseif itype == 7 then		-- 战斗力
		local fight = CI_GetPlayerData(62)
		look('fight:' .. tostring(fight))
		if fight == nil or fight <= 0 then return end
		if fight < t.fight then				
			cond = false
		end
	else
		cond = false
	end
	if cond then
		db_drx2_award(sid,itype,idx,maxnum)
	else
		RPC('drx_awards2', -2)		-- 条件不足
	end
end

local function _call_drx2_award(sid,itype,idx,rs,aid)
	look('_call_drx_award')
	look(sid)
	look(itype)
	look(idx)
	look(rs)
	look(aid)
	if sid == nil or itype == nil or idx == nil or rs == nil then
		return
	end
	look('_call_drx_award111')
	if drx_conf[itype] == nil or drx_conf[itype][idx] == nil then
		return
	end
	look('_call_drx_award222')
	local t = drx_conf[itype][idx]
	look(t.awards)
	if rs == 1 then		
		if not award_check_items(t.awards) then
			-- 回滚
			db_drx2_rollback(aid)
			return
		end	
		local ret = GI_GiveAward(sid,t.awards,'开服达人秀活动')
		BroadcastRPC('tip_notice',3,CI_GetPlayerData(5,2,sid),itype)
	end
	
	RPCEx(sid,'drx_awards2', rs)
end


--------------------------------------------------------------
--interface:

drx2_give_award = _drx2_give_award
call_drx2_award = _call_drx2_award