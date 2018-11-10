--[[
file: kf_ranklist.lua
desc: 开服排行榜活动
autor: csj
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


local time_ver = GetTimeToSecond(2013,12,12,0,0,0)

-------------------------------------------------------------------------
--module:

module(...)

------------------------------------------------------------------------
--inner:

local kf_rankconf = {
	[2000000001] = {
		list = { title = '等级排行榜活动',vIcon = 1024,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 1*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [307] = 1 },
					num = 1,					
					awd = {
						[3] = {{1133,1,1},{3003,1,1},{673,2,1},},
					},
				},
				[2] = {
					con ={ [307] = {2,10} },
					num = 1,					
					awd = {
						[3] = {{3003,1,1},{673,1,1},},
					},
				},
			},
			EventBuf = {
				arg = {
					[2] = {
						[307] = 10,
					},
				},
			},
		},
	},
	
	[2000000002] = {
		list = { title = '坐骑排行榜活动',vIcon = 1024,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 2*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [305] = 1 },
					num = 1,					
					awd = {
						[3] = {{1136,1,1},{3003,1,1},{627,300,1},},
					},
				},
				[2] = {
					con ={ [305] = {2,10} },
					num = 1,					
					awd = {
						[3] = {{3003,1,1},{627,200,1},},
					},
				},
			},
			EventBuf = {
				arg = {
					[2] = {
						[305] = 10,
					},
				},
			},
		},
	},
	
	[2000000003] = {
		list = { title = '锻造排行榜活动',vIcon = 1024,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 3*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [312] = 1 },
					num = 1,					
					awd = {
						[3] = {{1132,1,1},{3008,1,1},{601,500,1},},
					},
				},
				[2] = {
					con ={ [312] = {2,10} },
					num = 1,					
					awd = {
						[3] = {{3008,1,1},{601,300,1},},
					},
				},
			},
			EventBuf = {
				arg = {
					[2] = {
						[312] = 10,
					},
				},
			},
		},
	},
	[2000000004] = {
		list = { title = '排位赛排行榜活动',vIcon = 1024,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 4*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [314] = 1 },
					num = 1,					
					awd = {
						[3] = {{1138,1,1},{3008,1,1},{601,500,1},},
					},
				},
				[2] = {
					con ={ [314] = {2,10} },
					num = 1,					
					awd = {
						[3] = {{3008,1,1},{601,300,1},},
					},
				},
			},
			EventBuf = {
				arg = {
					[2] = {
						[314] = 10,
					},
				},
			},
		},
	},
	[2000000005] = {
		list = { title = '宝石排行榜活动',vIcon = 1024,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 5*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [313] = 1 },
					num = 1,					
					awd = {
						[3] = {{1134,1,1},{3005,1,1},{626,300,1},},
					},
				},
				[2] = {
					con ={ [313] = {2,10} },
					num = 1,					
					awd = {
						[3] = {{3005,1,1},{626,200,1},},
					},
				},
			},
			EventBuf = {
				arg = {
					[2] = {
						[313] = 10,
					},
				},
			},
		},
	},
	[2000000006] = {
		list = { title = '法宝排行榜活动',vIcon = 1024,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 6*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [310] = 1 },
					num = 1,					
					awd = {
						[3] = {{1137,1,1},{3005,1,1},{627,300,1},},
					},
				},
				[2] = {
					con ={ [310] = {2,10} },
					num = 1,					
					awd = {
						[3] = {{3005,1,1},{627,200,1},},
					},
				},
			},
			EventBuf = {
				arg = {
					[2] = {
						[310] = 10,
					},
				},
			},
		},
	},
	
	[2000000007] = {
		list = { title = '战力排行榜活动',vIcon = 1024,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 7*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [308] = 1 },
					num = 1,					
					awd = {
						[3] = {{1139,1,1},{3003,1,1},{637,80,1},},
					},
				},
				[2] = {
					con ={ [308] = {2,10} },
					num = 1,					
					awd = {
						[3] = {{3003,1,1},{637,40,1},},
					},
				},
			},
			EventBuf = {
				arg = {
					[2] = {
						[308] = 10,
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
function _insert_rank_active()
	local openTime = GetServerOpenTime()
	if openTime == 0 then return end
	-- look(os_date('%Y-%m-%d %H:%M:%S', openTime))
	local now = GetServerTime()
	-- look(os_date('%Y-%m-%d %H:%M:%S', now))
	if now >= openTime + 11*24*3600 then
		return
	end	
	if openTime > time_ver then
		return
	end
	local list = __G.AllActiveListConf.list
	local cache = __G.AllActiveListConf.cache
	if list == nil or cache == nil then return end
	for k, v in pairs(kf_rankconf) do
		list[k] = v.list
		cache[k] = {}
		-- look('v.cache.tView:' .. v.cache.tView)
		-- look('openTime:' .. openTime)
		cache[k].tView = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(openTime+v.cache.tView))
		cache[k].tBegin = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(openTime+v.cache.tBegin))
		cache[k].tEnd = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(openTime+v.cache.tEnd))
		cache[k].tAward = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(openTime+v.cache.tAward))
		cache[k].AwardBuf = v.cache.AwardBuf
		if v.cache.EventBuf then
			local t = v.cache.EventBuf
			local evtb = {}
			-- 这里延后一分钟等排行榜生成
			local begtm = os_date('*t', GetNaturalDay(openTime+v.cache.tBegin) + 60)	
			local awdtm = os_date('*t', GetNaturalDay(openTime+v.cache.tAward) + 60)
			local bt = {begtm.year,begtm.month,begtm.day,begtm.hour,begtm.min,begtm.sec}
			local at = {awdtm.year,awdtm.month,awdtm.day,awdtm.hour,awdtm.min,awdtm.sec}
			evtb.Date = {bt,at}
			evtb.arg = t.arg			
			regist_event_dynamic(evtb,now,k)
		end
	end
end

------------------------------------------------------------------------
--interface:

insert_rank_active = _insert_rank_active