--[[
file:	player_ExpFindBack.lua
desc:	
author:	
update:	
refix: done by chal
]]--

--------------------------------------------------------------------------
--include:
local Player_GivecbExp = msgh_s2c_def[15][8]

local pairs,type = pairs,type
local math_ceil = math.ceil
local table_locate = table.locate

local TP_FUNC = type(function() end)
local look = look
local TimesTypeTb = TimesTypeTb
local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond
local GetDiffDayEx = common_time.GetDiffDayEx


--------------------------------------------------------------------------
--inner:

local MAX_DAY = 7		-- 最大累计天数

local expcb_config = {
	[1] = {					-- 悬赏任务
		needlv = 35,
		tt = TimesTypeTb.TS_Ring,
		fv = {
			[35] = 1600000,
			[39] = 1800000,
			[44] = 2200000,
			[49] = 2400000,
			[54] = 2600000,
			[59] = 3000000,
			[64] = 3500000,
		},
	},		
	[2] = {					-- 护送海美人
		needlv = 35,
		tt = TimesTypeTb.Escort_time,
		fv = function (sid,lv) return lv^2.4 *51  end,
	},
	[3] = {					-- 组队副本
		needlv = 35,
		tt = TimesTypeTb.CS_Multi,
		fv = {
			[35] = 200000,
			[44] = 300000,
			[49] = 400000,
			[54] = 500000,
			[59] = 600000,
			[64] = 700000,
		},
	},
	[4] = {					-- 温泉
		needlv = 35,
		tt = TimesTypeTb.wq_Time,
		fv = function (sid,lv) return lv^2.7 *18  end,
	},
	[5] = {					-- 曲水
		needlv = 35,
		tt = TimesTypeTb.Noon_Time,
		fv = function (sid,lv) return lv^2.7 *18  end,
	},
	[6] = {					-- 神创天下
		needlv = 35,		
		tt = TimesTypeTb.SC_award,
		itemid = 690,
		fv = function (sid,lv) 
			local dt = sctx_getdbdata(sid)
			if dt == nil then return 0 end
			local canget=dt[1]
			if canget==nil then 
				return 0
			end
			if  canget > 50 then
				canget = 50
			end

			return canget-(dt[5] or 0  )
		end,
	},
	[7] = {					-- 经验本
		needlv = 39,
		tt = TimesTypeTb.CS_Exps,
		fv = function (sid,lv) return lv^2.1 *800  end,
	},
	
}

--Get OutData from playerSid
function GetDBPlayerOutData(playerid)
	local dayData = GetPlayerDayData(playerid)
	if dayData == nil then
		return
	end
	if dayData.cbdt == nil then
		dayData.cbdt = {
			-- cbday = 0,		
			-- cbexp = 0,
		}
	end
	return dayData.cbdt
end

local function GetEDayBackExp(sid)
	local lv = CI_GetPlayerData(1,2,sid)
	if lv == nil or lv <= 0 then return end
	local dayexps = 0
	for k, v in pairs(expcb_config) do
		if lv >= v.needlv then
			if type(v.fv) == type(0) then
				dayexps = dayexps + v.fv
			elseif type(v.fv) == type({}) then
				local pos = table_locate(v.fv,lv,1)
				--look('pos:' .. pos)
				if pos and type(v.fv[pos]) == type(0) then
					dayexps = dayexps + v.fv[pos]
				end
			elseif type(v.fv) == TP_FUNC then
				dayexps = dayexps + (v.fv(lv) or 0)
			end
		end
	end
	return dayexps
end

local function get_singleexp(sid,lv,fv)
	local sigexp = 0
	if type(fv) == type(0) then
		sigexp = sigexp + fv
	elseif type(fv) == type({}) then
		local pos = table_locate(fv,lv,1)
		if pos and type(fv[pos]) == type(0) then
			sigexp = sigexp + fv[pos]
		end
	elseif type(fv) == TP_FUNC then
		sigexp = sigexp + (fv(sid,lv) or 0)
	end
	return rint(sigexp)
end

--------------------------------------------------------------------------
--interface:

function p_ExpFindBack(sid,intervalDay)
	--look('p_ExpFindBack enter:' .. tostring(sid))
	if sid == nil or intervalDay == nil then return end
	-- 判断是否超过7天 超过就不累计了	
	local cbData = GetDBPlayerOutData(sid)
	if cbData == nil then return end 
	if intervalDay <= 0 then return end
	if intervalDay > MAX_DAY then 
		intervalDay = MAX_DAY
	end	
	
	local plevel = CI_GetPlayerData(1)	
	local cb_exp = 0	
	for k, v in pairs(expcb_config) do
		if plevel >= v.needlv then
			cbData[k] = cbData[k] or {}	
			-- 处理老号问题
			local curExp = cbData[k][1] or 0
			local curDay = cbData[k][2] or 0
			if curExp == 0 and curDay > 0 then
				cbData[k][2] = 0
			end
			local exps = 0
			local days = cbData[k][2] or 0			
			if days < MAX_DAY then
				local realDay = intervalDay
				local tm = days + realDay
				if tm > MAX_DAY then
					realDay = MAX_DAY - days
				end					
				local tc = GetTimesInfo(sid,v.tt)
				local sigexp = get_singleexp(sid,plevel,v.fv)
				if tc == nil or tc[1] == nil or tc[1] <= 0 then				
					exps = exps + (sigexp or 0)
				end
				if realDay > 1 then
					exps = exps + rint(sigexp * (realDay - 1))
				end				
				cbData[k][1] = (cbData[k][1] or 0) + exps
				cbData[k][2] = (cbData[k][2] or 0) + realDay
			end				
		end
	end 
	--look(cbData)
end

-- 领取离线经验
function p_GivecbExp(sid,idx,opt)
	local cbData = GetDBPlayerOutData(sid)
	if cbData == nil then return end 
	if cbData[idx] == nil or cbData[idx][1] == nil then
		return
	end
	if expcb_config[idx] == nil then 
		return
	end
	local t = expcb_config[idx]
	local bitem = false
	if t.itemid then
		bitem = true
	end
	local cbexp = cbData[idx][1] or 0
	local yb = 0
	if bitem then
		yb = math_ceil(cbexp * 2)
	else
		yb = math_ceil(cbexp / 100000)
	end
	if bitem then		-- 先判断次包裹
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return
		end
	end
	if opt == 1 then
		if not CheckCost(sid,yb,0,1,"100029_经验找回") then
			SendLuaMsg( 0, { ids = Player_GivecbExp, res = 1 }, 9 )
			return
		end
	end	
	if opt == 0 then
		cbexp = math_ceil(cbexp*0.5)		-- 数量向上取整		
	end
	if cbexp < 0 then cbexp = 0 end
	-- 先清理数据
	cbData[idx] = nil
	-- 给补偿
	if bitem then
		GiveGoods(t.itemid,cbexp,1,'经验找回')
	else
		PI_PayPlayer(1,cbexp,0,0,'经验找回')
	end
		
	SendLuaMsg( 0, { ids = Player_GivecbExp, res = 0, idx = idx, opt = opt }, 9 )
end