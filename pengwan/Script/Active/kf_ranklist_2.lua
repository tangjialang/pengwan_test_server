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


local time_ver_1 = GetTimeToSecond(2013,12,12,0,0,0)
local time_ver_2 = GetTimeToSecond(2013,12,27,0,0,0)

-------------------------------------------------------------------------
--module:

module(...)

------------------------------------------------------------------------
--inner:

local kf_rankconf = {
	[2000001001] = {
		list = { title = '等级排行榜活动',vIcon = 1016,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 1*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [307] = 1 },
					num = 1,					
					awd = {
						[3] = {{1135,1,1},{3057,1,1},{3001,1,1},{673,2,1},},
					},
				},
				[2] = {
					con ={ [307] = {2,5} },
					num = 1,					
					awd = {
						[3] = {{3057,1,1},{673,2,1},{52,5,1},},
					},
				},
				[3] = {
					con ={ [307] = {6,20} },
					num = 1,					
					awd = {
						[3] = {{3056,1,1},{673,1,1},},
					},
				},
			},
			EventBuf = {
				arg = {
					[2] = {
						[307] = 20,
					},
				},
			},
		},
	},
	
	[2000001002] = {
		list = { title = '骑兵排行榜活动',vIcon = 1016,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 2*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [315] = 1 },
					num = 1,					
					awd = {
						[3] = {{1133,1,1},{3003,1,1},{3048,1,1},{712,1,1},},
					},
				},
				[2] = {
					con ={ [315] = {2,5} },
					num = 1,					
					awd = {
						[3] = {{3003,1,1},{3047,1,1},{711,1,1},},
					},
				},
				[3] = {
					con ={ [315] = {6,20} },
					num = 1,					
					awd = {
						[3] = {{3002,1,1},{3046,1,1},},
					},
				},
			},
			EventBuf = {
				arg = {
					[2] = {
						[315] = 20,
					},
				},
			},
		},
	},
	
	[2000001003] = {
		list = { title = '第一任国王',vIcon = 1016,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 3*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [316] = 1 },
					num = 1,					
					awd = {
						[3] = {{1132,1,1},{3008,1,1},{3048,1,1},{3042,1,1},},
					},
				},				
			},
			EventBuf = {
				arg = {
					[2] = {
						[316] = 1,
					},
				},
			},
		},
	},
	[2000001004] = {
		list = { title = '坐骑排行榜活动',vIcon = 1016,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 4*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [305] = 1 },
					num = 1,					
					awd = {
						[3] = {{1136,1,1},{3040,1,1},{3008,1,1},{627,1000,1},},
					},
				},
				[2] = {
					con ={ [305] = {2,5} },
					num = 1,					
					awd = {
						[3] = {{3039,1,1},{3008,1,1},{627,500,1},},
					},
				},
				[3] = {
					con ={ [305] = {6,20} },
					num = 1,					
					awd = {
						[3] = {{3038,1,1},{627,200,1},},
					},
				},
			},
			EventBuf = {
				arg = {
					[2] = {
						[305] = 20,
					},
				},
			},
		},
	},
	[2000001005] = {
		list = { title = '家将排行榜活动',vIcon = 1016,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 5*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [306] = 1 },
					num = 1,					
					awd = {
						[3] = {{1134,1,1},{3005,1,1},{603,1000,1},{692,100,1},},
					},
				},
				[2] = {
					con ={ [306] = {2,5} },
					num = 1,					
					awd = {
						[3] = {{3005,1,1},{603,500,1},{692,50,1},},
					},
				},
				[3] = {
					con ={ [306] = {6,20} },
					num = 1,					
					awd = {
						[3] = {{3004,1,1},{603,200,1},},
					},
				},
			},
			EventBuf = {
				arg = {
					[2] = {
						[306] = 20,
					},
				},
			},
		},
	},
	[2000001006] = {
		list = { title = '女神排行榜活动',vIcon = 1016,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 6*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [310] = 1 },
					num = 1,					
					awd = {
						[3] = {{1137,1,1},{3053,1,1},{693,100,1},{731,1,1},},
					},
				},
				[2] = {
					con ={ [310] = {2,5} },
					num = 1,					
					awd = {
						[3] = {{3052,1,1},{693,50,1},{730,1,1},},
					},
				},
				[3] = {
					con ={ [310] = {6,20} },
					num = 1,					
					awd = {
						[3] = {{3051,1,1},{693,20,1},},
					},
				},
			},
			EventBuf = {
				arg = {
					[2] = {
						[310] = 20,
					},
				},
			},
		},
	},
  [2000001007] = {
		list = { title = '战力排行榜活动',vIcon = 1016,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 7*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [308] = 1 },
					num = 1,					
					awd = {
						[3] = {{1139,1,1},{1401,1,1},{648,5,1},{657,20,1},},
					},
				},
				[2] = {
					con ={ [308] = {2,5} },
					num = 1,					
					awd = {
						[3] = {{1402,1,1},{648,3,1},{657,10,1},},
					},
				},
				[3] = {
					con ={ [308] = {6,20} },
					num = 1,					
					awd = {
						[3] = {{1403,1,1},{657,5,1},},
					},
				},
			},
			EventBuf = {
				arg = {
					[2] = {
						[308] = 20,
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
function _insert_rank_active_2()
	local openTime = GetServerOpenTime()
	if openTime == 0 then return end
	-- look(os_date('%Y-%m-%d %H:%M:%S', openTime))
	local now = GetServerTime()
	-- look(os_date('%Y-%m-%d %H:%M:%S', now))
	if now >= openTime + 10*24*3600 then
		return
	end	
	if openTime < time_ver_1 or openTime >= time_ver_2 then
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

insert_rank_active_2 = _insert_rank_active_2