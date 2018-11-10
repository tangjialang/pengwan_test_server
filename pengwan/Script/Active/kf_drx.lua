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
local db_drx_award = db_module.db_drx_award
local db_drx_rollback = db_module.db_drx_rollback

-----------------------------------------------------------
--module:

module(...)

------------------------------------------------------------
--inner:

local drx_conf = {
	[1001] = {		-- 人物等级
		[1] = { plv = 40, num = 999, awards = {[4] = 200,},},
		[2] = { plv = 43, num = 288, awards = {[4] = 300,},}, 
        [3] = { plv = 46, num = 188, awards = {[4] = 500,},},
		[4] = { plv = 48, num = 88, awards = {[4] = 800,[1] = 1000000,},},
	    [5] = { plv = 52, num = 10, awards = {[4] = 1500,[1] = 2000000,[5] = 500000,},},
		[6] = { plv = 55, num = 1, awards = {[4] = 3000,[1] = 3000000,[5] = 1000000,[3] = {{3039,1,1}}},}, 
	},
	[1002] = {		-- 装备强化等级和
		[1] = { qhlv = 64, num = 488, awards = {[1] = 500000,},},
		[2] = { qhlv = 80, num = 188, awards = {[1] = 1000000,},},
		[3] = { qhlv = 120, num = 20, awards = {[1] = 1500000,},},
		[4] = { qhlv = 144, num = 10, awards = {[1] = 2000000,[3] = {{614,10,1}},},},
		[5] = { qhlv = 160, num = 3, awards = {[1] = 5000000,[3] = {{615,10,1},{616,10,1}},},},
		[6] = { qhlv = 168, num = 1, awards = {[1] = 10000000,[3] = {{617,10,1},{618,10,1},{436,1,1}},},},
	},
	[1003] = {		-- 坐骑阶数
		[1] = { zqlv = 20, num = 100, awards = {[3] = {{3037,1,1}}},},
		[2] = { zqlv = 30, num = 50, awards = {[3] = {{3038,1,1},{3002,1,1}}},},
		[3] = { zqlv = 40, num = 20, awards = {[3] = {{3039,1,1},{3003,1,1}}},},
		[4] = { zqlv = 50, num = 10, awards = {[3] = {{3040,1,1},{627,200,1}}},},
		[5] = { zqlv = 60, num = 3, awards = {[3] = {{3041,1,1},{627,300,1},{646,20,1}}},},
		[6] = { zqlv = 70, num = 1, awards = {[3] = {{3042,1,1},{627,400,1},{646,30,1},{437,1,1}}},},
	},
	[1004] = {		-- 装备宝石数量
		[1] = { bsnum = 72, num = 100, awards = {[3] = {{663,2,1}},},},
		[2] = { bsnum = 96, num = 50, awards = {[3] = {{666,1,1}},}, },
		[3] = { bsnum = 120, num = 20, awards = {[3] = {{677,1,1}},},},
		[4] = { bsnum = 144, num = 10, awards = {[3] = {{678,1,1}},[1] = 3000000,},},
		[5] = { bsnum = 168, num = 3, awards = {[3] = {{678,2,1},{626,500,1}},[1] = 5000000,},},
		[6] = { bsnum = 224, num = 1, awards = {[3] = {{427,1,1},{626,1000,1},{637,100,1}},[1] = 10000000,},},
	},
	[1005] = {		-- 法宝阶数
		[1] = { fblv = 20, num = 100, awards = {[3] = {{771,1,1},{732,1,1}}},},
		[2] = { fblv = 30, num = 50, awards = {[3] = {{771,2,1},{3004,1,1}}},},
		[3] = { fblv = 40, num = 20, awards = {[3] = {{771,5,1},{3005,1,1}}},},
		[4] = { fblv = 50, num = 10, awards = {[3] = {{771,10,1},{734,1,1}}},},
		[5] = { fblv = 60, num = 3, awards = {[3] = {{771,20,1},{730,1,1},{735,1,1}}},},
		[6] = { fblv = 70, num = 1, awards = {[3] = {{771,30,1},{730,1,1},{736,1,1},{731,1,1}}},},
	},
	
	[1006] = {		-- 战斗力
		[1] = { fight = 10000, num = 100, awards = {[1] = 500000,},},
		[2] = { fight = 20000, num = 50, awards = {[1] = 1000000,},},
		[3] = { fight = 40000, num = 20, awards = {[1] = 2000000,[3] = {{647,2,1}}},},
		[4] = { fight = 60000, num = 10, awards = {[1] = 5000000,[3] = {{647,3,1}},},},
		[5] = { fight = 80000, num = 3, awards = {[1] = 8000000,[3] = {{652,5,1},{678,1,1}},},},
		[6] = { fight = 90000, num = 1, awards = {[1] = 10000000,[3] = {{652,10,1},{437,1,1},{637,100,1}},},},
	},
	
	[1007] = {		-- 骑兵
		[1] = { qblv = 2, num = 100, awards = {[3] = {{3044,1,1}}},},
		[2] = { qblv = 3, num = 50, awards = {[3] = {{3045,1,1},{713,1,1}}},},
		[3] = { qblv = 4, num = 20, awards = {[3] = {{3046,1,1},{714,1,1}}},},
		[4] = { qblv = 5, num = 10, awards = {[3] = {{3047,1,1},{715,1,1}}},},
		[5] = { qblv = 6, num = 3, awards = {[3] = {{3048,1,1},{716,1,1},{711,1,1}}},},
		[6] = { qblv = 7, num = 1, awards = {[3] = {{717,1,1},{711,1,1},{712,1,1},{417,1,1}}},},
	},
	[1008] = {		-- 神翼
		[1] = { winglv = 2, num = 100, awards = {[3] = {{3058,1,1}}},},
		[2] = { winglv = 3, num = 50, awards = {[3] = {{3059,1,1},{765,5,1}}},},
		[3] = { winglv = 4, num = 20, awards = {[3] = {{3060,1,1},{765,10,1}}},},
		[4] = { winglv = 5, num = 10, awards = {[3] = {{3061,1,1},{765,15,1}}},},
		[5] = { winglv = 6, num = 3, awards = {[3] = {{3062,1,1},{765,20,1},{763,1,1}}},},
		[6] = { winglv = 7, num = 1, awards = {[3] = {{766,1,1},{764,1,1},{763,1,1},{678,2,1}}},},
	},
}

local function _drx_give_award(sid,itype,idx)
	if sid == nil or itype == nil or idx == nil then
		return
	end
	if drx_conf[itype] == nil or drx_conf[itype][idx] == nil then
		return
	end
	local now = GetServerTime()
	local openTime = GetServerOpenTime()
	-- if rint(now/(24*3600)) - rint(openTime/(24*3600)) >= 7 then
		-- look('_drx_give_award time out')
		-- return
	-- end
	if now - openTime >= 7*24*3600 then
		look('_drx_give_award time out')
		return
	end
	local t = drx_conf[itype][idx]
	if not award_check_items(t.awards) then
		return
	end
	local maxnum = t.num
	local cond = true
	if itype == 1001 then			-- 玩家等级
		local lv = CI_GetPlayerData(1)
		look('lv:' .. tostring(lv))
		if lv == nil or lv <= 0 then return end
		if lv < t.plv then				
			cond = false
		end
	elseif itype == 1002 then		-- 装备强化等级和
		local qhlv = CI_GetPlayerData(38)
		look('qhlv:' .. tostring(qhlv))
		if qhlv == nil or qhlv <= 0 then return end
		if qhlv < t.qhlv then				
			cond = false
		end
	elseif itype == 1003 then		-- 坐骑阶数
		local zqlv = get_mounts_lv(sid) or 0
		look('zqlv:' .. tostring(zqlv))
		if zqlv < t.zqlv then
			cond = false
		end
	elseif itype == 1004 then		-- 装备宝石数量
		local bsnum = CI_GetPlayerData(40)
		look('bsnum:' .. tostring(bsnum))
		if bsnum == nil or bsnum <= 0 then return end
		if bsnum < t.bsnum then				
			cond = false
		end
	elseif itype == 1005 then		-- 法宝阶数
		local batlv = __G.get_battlelv( sid ) or 0
		look('batlv:' .. tostring(batlv))
		if batlv < t.fblv then
			cond = false
		end
	-- elseif itype == 6 then		-- 充值
		-- local cz = CI_GetPlayerData(27)
		-- look('cz:' .. tostring(cz))
		-- if cz == nil or cz <= 0 then return end
		-- if cz < t.cz then
			-- cond = false
		-- end
	elseif itype == 1006 then		-- 战斗力
		local fight = CI_GetPlayerData(62)
		look('fight:' .. tostring(fight))
		if fight == nil or fight <= 0 then return end
		if fight < t.fight then				
			cond = false
		end
	elseif itype == 1007 then		-- 骑兵
		local qblv = __G.sowar_getlv(sid)
		look('qblv:' .. tostring(qblv))
		if qblv == nil or qblv <= 0 then return end
		if qblv < t.qblv then				
			cond = false
		end
	elseif itype == 1008 then		-- 神翼
		local winglv = __G.wing_get_info(sid,1) or 0
		look('winglv:' .. tostring(winglv))
		if winglv == nil or winglv <= 0 then return end
		if winglv < t.winglv then				
			cond = false
		end
	else
		cond = false
	end
	if cond then
		db_drx_award(sid,itype,idx,maxnum)
	else
		RPC('drx_awards', -2)		-- 条件不足
	end
end

local function _call_drx_award(sid,itype,idx,rs,aid)
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
			db_drx_rollback(aid)
			return
		end	
		local ret = GI_GiveAward(sid,t.awards,'开服达人秀活动')
		BroadcastRPC('tip_notice',3,CI_GetPlayerData(5,2,sid),itype)
	end
	
	RPCEx(sid,'drx_awards', rs)
end


--------------------------------------------------------------
--interface:

drx_give_award = _drx_give_award
call_drx_award = _call_drx_award