--[[
file: kf_leichong.lua
desc: 开服累冲活动
autor: wk
update:	2014-1-3
]]--

local pairs,ipairs,type = pairs,ipairs,type
local os_date = os.date
local GetServerOpenTime = GetServerOpenTime
local GetServerTime = GetServerTime
local rint = rint
local look = look
local __G = _G

local time_proc_m = require('Script.active.time_proc')
local regist_event_dynamic = time_proc_m.regist_event_dynamic
local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond


-- local time_ver = GetTimeToSecond(2013,12,12,0,0,0)

-------------------------------------------------------------------------
--module:

module(...)

------------------------------------------------------------------------
--inner:

local kf_leichongconf = {
	[2000005201] = {
		list = { title = '活动期间，累计充值达到以下金额，即可领取一份奖励，奖励可以兼得。例如充值5000元宝可以领取1000-5000元宝的所有奖励一次。高级宝石、特殊家将、特殊坐骑、绝版红色神装任你拿！',vIcon = 903,ver = 0,pic = 997 },
		desc = '活动期间，累计充值达到以下金额，即可领取一份奖励，奖励可以兼得。例如充值5000元宝可以领取1000-5000元宝的所有奖励一次。高级宝石、特殊家将、特殊坐骑、绝版红色神装任你拿',
		cache = {
			tView = 0,tBegin =0,tEnd = 7*24*3600,tAward =0,
			AwardBuf = {
           		[1] = {
	               	con = {[802] = 1000 },
					num = 1,
					awd = {
	                  [3] = {{773,5,1 },{768,5,1},{601,100,1},},
	               		},
					},
				[2] = {
	               	con = {[802] = 3000 },
					num = 1,
					awd = {
	                  [3] = {{3044,1,1 },{673,2,1},{768,10,1 },{710,10,1},},
	               	},
				},	
				[3] = {
	               	con = {[802] = 5000 },
					num = 1,
					awd = {
	                  [3] = {{773,20,1 },{673,3,1},{768,20,1 },{710,10,1},{713,2,1},},
	               	},
				},	
				[4] = {
	               	con = {[802] = 10000 },
					num = 1,
					awd = {
	                  [3] = {{1140,1,1 },{3045,1,1},{673,5,1 },{769,20,1},{710,15,1},{714,1,1},},
	               	},
				},
				[5] = {
	               	con = {[802] = 20000 },
					num = 1,
					awd = {
	                  [3] = {{201,1,1 },{695,1,1},{711,1,1 },{673,5,1},{710,20,1},{601,200,1},},
	               	},
				},
				[6] = {
	               	con = {[802] = 50000 },
					num = 1,
					awd = {
	                  [3] = {{304,1,1 },{711,1,1},{695,1,1 },{637,50,1},{710,60,1},{601,200,1},{603,300,1},},
	               	},
				},
				[7] = {
	               	con = {[802] = 100000 },
					num = 1,
					awd = {
	                  [3] = {{210,1,1 },{3001,1,1},{9909,1,1 },{712,1,1},{711,1,1},{677,4,1},{637,100,1},{601,500,1},},
	               	},
				},
			},
		},
	},
}


-- 取自然天秒数
function GetNaturalDay(t)
	local sec = rint(t/(24*3600)) * 24 * 3600 - 8*3600
	return sec
end

-- 插入排行榜活动
function _insert_kflc_active()
	local openTime = GetServerOpenTime()
	if openTime == 0 then return end
	--look(os_date('%Y-%m-%d %H:%M:%S', openTime),1)
	local now = GetServerTime()
	local panduan=GetTimeToSecond(2014,1,6,23,00,00)
	if openTime<panduan then 
		return
	end
	if now >= openTime + 8*24*3600 then
		--look(222,1)
		return
	end	
	-- if openTime > time_ver then
	-- 	look(111,1)
	-- 	return
	-- end
	local list = __G.AllActiveListConf.list
	local cache = __G.AllActiveListConf.cache
	if list == nil or cache == nil then return end
	for k, v in pairs(kf_leichongconf) do
		-- look(k,1)
		list[k] = v.list
		cache[k] = {}
		-- look('v.cache.tView:' .. v.cache.tView)
		-- look('openTime:' .. openTime)
		cache[k].tView = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(openTime+v.cache.tView))
		cache[k].tBegin = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(openTime+v.cache.tBegin))
		cache[k].tEnd = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(openTime+v.cache.tEnd))
		cache[k].tAward = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(openTime+v.cache.tAward))
		cache[k].AwardBuf = v.cache.AwardBuf
		-- look(cache[k].tBegin,1)
	end
end

------------------------------------------------------------------------
--interface:

insert_kflc_active = _insert_kflc_active