--[[
file: hf_ranklist.lua
desc: 合服排行榜活动
autor: csj
]]--

local pairs,ipairs,type = pairs,ipairs,type
local os_date = os.date
local GetServerOpenTime = GetServerOpenTime
local GetServerMergeTime = GetServerMergeTime
local GetServerTime = GetServerTime
local rint = rint
local look = look
local __G = _G

local time_proc_m = require('Script.active.time_proc')
local regist_event_dynamic = time_proc_m.regist_event_dynamic


-------------------------------------------------------------------------
--module:

module(...)

------------------------------------------------------------------------
--inner:

local hf_rankconf = {
	[2100001101] = {
		list = { title = '充值排行榜',vIcon = 1017,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 7*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [319] = {1,1,8000} },
					num = 1,					
					awd = {
						[3] = {{606,400,1},{601,1000,1},{627,500,1},},
					},
					etc = {
						[3] = {{712,1,1},{731,1,1},},
					},
				},
				[2] = {
					con ={ [319] = {2,2,4000} },
					num = 1,					
					awd = {
						[3] = {{606,300,1},{601,800,1},{627,400,1},},
					},
					etc = {
						[3] = {{712,1,1},{730,1,1},},
					},
				},
				[3] = {
					con ={ [319] = {3,3,2000} },
					num = 1,					
					awd = {
						[3] = {{606,200,1},{601,500,1},{627,300,1},},
					},
					etc = {
						[3] = {{711,30,1},{730,1,1},},
					},
				},
				[4] = {
					con ={ [319] = {4,10} },
					num = 1,					
					awd = {
						[3] = {{606,100,1},{601,300,1},{627,200,1},},
					},
				},
				[5] = {
					con ={ [319] = {11,20} },
					num = 1,					
					awd = {
						[3] = {{606,50,1},{601,200,1},{627,100,1},},
					},
				},
			},
			EventBuf = {
				arg = {
					[2] = {
						[319] = 20,
					},
				},
			},
		},
	},
	
	[2100001102] = {
		list = { title = '欢乐寻宝',vIcon = 1017,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 1*24*3600,tEnd = 10*24*3600,tAward = 4*24*3600,
			AwardBuf = {				
			},
			EventBuf = {
				Date = {
					[1] = 1*24*3600,
					[2] = 10*24*3600,
				},
				arg = {
					[1] = {
						[904] = 2,
					},
					[2] = {
						[904] = 1,
					},
				},
			},
		},
	},
	
	[2100001103] = {
		list = { title = '第一任国王',vIcon = 1017,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 3*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [316] = 1 },
					num = 1,					
					awd = {
						[3] = {{1132,1,1},{3008,1,1},{3048,1,1},{618,20,1},},
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
	[2100001104] = {
		list = { title = '第一任国王帮会',vIcon = 1017,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 3*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [318] = 1 },
					num = 1,					
					awd = {
						[3] = {{601,50,1},{603,50,1},{614,10,1},},
					},
				},				
			},
			EventBuf = {
				arg = {
					[2] = {
						[318] = 1,
					},
				},
			},
		},
	},
	[2100001105] = {
		list = { title = '超级大转盘',vIcon = 1017,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 3*24*3600,tEnd = 10*24*3600,tAward = 7*24*3600,
			AwardBuf = {				
			},
			EventBuf = {
				arg = {
					[1] = {
						[905] = 2,
					},
					[2] = {
						[905] = 1,
					},
				},
			},
		},
	},
	[2100001106] = {
		list = { title = '稀有道具限时购买',vIcon = 1017,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 5*24*3600,tEnd = 10*24*3600,tAward = 5*24*3600,
			AwardBuf = {
				[1] = {
					con ={ 
						[1601] = 10,--全服限购数量
						[1602] = 14888,--原价
						[1603] = 6899,--现价						
					},
					num = 10,--全服限购数量					
					awd = {
						[3] = {{1446,1,1},},--奖励
					},
				},
				[2] = {
					con ={ 
						[1601] = 30,
						[1602] = 1000,
						[1603] = 798,						
					},
					num = 30,					
					awd = {
						[3] = {{1447,1,1},},
					},
				},
				[3] = {
					con ={ 
						[1601] = 100,
						[1602] = 1488,
						[1603] = 698,						
					},
					num = 100,					
					awd = {
						[3] = {{1448,1,1},},
					},
				},
				[4] = {
					con ={ 
						[1601] = 30,
						[1602] = 5120,
						[1603] = 1988,						
					},
					num = 30,					
					awd = {
						[3] = {{677,1,1},},
					},
				},
			},			
		},
	},	
  [2100001107] = {
		list = { title = '战力排行榜活动',vIcon = 1017,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 10*24*3600,tAward = 7*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [308] = 1 },
					num = 1,					
					awd = {
						[3] = {{1139,1,1},{637,100,1},{648,5,1},{657,20,1},},
					},
				},
				[2] = {
					con ={ [308] = {2,5} },
					num = 1,					
					awd = {
						[3] = {{637,80,1},{648,3,1},{657,10,1},},
					},
				},
				[3] = {
					con ={ [308] = {6,20} },
					num = 1,					
					awd = {
						[3] = {{637,50,1},{657,5,1},},
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
function _insert_merge_active()
	look('_insert_merge_active')
	local mergeTime = GetServerMergeTime()
	if mergeTime == 0 then return end
	look(os_date('%Y-%m-%d %H:%M:%S', mergeTime))
	local now = GetServerTime()
	look(os_date('%Y-%m-%d %H:%M:%S', now))
	if now >= mergeTime + 10*24*3600 then
		return
	end	
	local list = __G.AllActiveListConf.list
	local cache = __G.AllActiveListConf.cache
	if list == nil or cache == nil then return end
	for k, v in pairs(hf_rankconf) do
		list[k] = v.list
		cache[k] = {}
		-- look('v.cache.tView:' .. v.cache.tView)
		-- look('mergeTime:' .. mergeTime)
		cache[k].tView = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(mergeTime+v.cache.tView))
		cache[k].tBegin = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(mergeTime+v.cache.tBegin))
		cache[k].tEnd = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(mergeTime+v.cache.tEnd))
		cache[k].tAward = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(mergeTime+v.cache.tAward))
		cache[k].AwardBuf = v.cache.AwardBuf
		if v.cache.EventBuf then
			local t = v.cache.EventBuf
			local evtb = {}
			-- 这里延后一分钟等排行榜生成			
			local begtm = os_date('*t', GetNaturalDay(mergeTime+v.cache.tBegin) + 60)	
			local awdtm = os_date('*t', GetNaturalDay(mergeTime+v.cache.tAward) + 60)
			if t.Date then
				if type(t.Date[1]) == type(0) then
					begtm = os_date('*t', GetNaturalDay(mergeTime+t.Date[1]))
				end
				if type(t.Date[2]) == type(0) then
					awdtm = os_date('*t', GetNaturalDay(mergeTime+t.Date[2]))
				end
			end
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

insert_merge_active = _insert_merge_active