--[[
file: chunjie.lua
desc: 春节活动
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
local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond

local initTime = GetTimeToSecond(2014,2,2,0,0,0) + 8*3600

-------------------------------------------------------------------------
--module:

module(...)

------------------------------------------------------------------------
--inner:

local cj_activeconf = {
	[2000001101] = {
		list = { title = '福红包过大年',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 14*24*3600,tAward = 0,
			AwardBuf = {
				[1] = {
					con ={ [708] = 1 },
					num = 1,					
					awd = {
						[3] = {{1452,2,1},{1450,5,1},},
					},					
				},	
				[2] = {
					con ={ [708] = 2 },
					num = 1,					
					awd = {
						[3] = {{1452,3,1},{1450,10,1},},
					},					
				},	
				[3] = {
					con ={ [708] = 3 },
					num = 1,					
					awd = {
						[3] = {{1452,5,1},{1450,20,1},},
					},					
				},
				[4] = {
					con ={ [708] = 4 },
					num = 1,					
					awd = {
						[3] = {{1452,15,1},{1450,30,1},},
					},					
				},	
				[5] = {
					con ={ [708] = 5 },
					num = 1,					
					awd = {
						[3] = {{1452,20,1},{1450,50,1},},
					},					
				},	
				[6] = {
					con ={ [708] = 6 },
					num = 1,					
					awd = {
						[3] = {{1452,60,1},{1450,80,1},},
					},					
				},	
				[7] = {
					con ={ [708] = 7},
					num = 1,					
					awd = {
						[3] = {{1452,100,1},{1450,100,1},},
					},					
				},	
			
			},			
		},
	},
	
	[2000001102] = {
		list = { title = '充值送大礼',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 14*24*3600,tAward = 0,
			AwardBuf = {
				[1] = {
					con ={ [1701] = 1000,[1702] = 2499 },
					num = 999,					
					awd = {
						[3] = {{686,1,1},{1450,5,1},{1456,5,1},},
					      },
					},
				[2] = {
					con ={ [1701] = 2500,[1702] = 4999 },
					num = 999,					
					awd = {
						[3] = {{686,3,1},{1450,12,1},{1456,10,1},},
					},
				},
				[3] = {
					con ={ [1701] = 5000,[1702] = 9999 },
					num = 999,					
					awd = {
						[3] = {{686,6,1},{1450,25,1},{1456,20,1},},
					},
				},
				[4] = {
					con ={ [1701] = 10000,[1702] = 19999 },
					num = 999,					
					awd = {
						[3] = {{686,13,1},{1450,50,1},{1456,40,1},{1455,5,1},},
					},
				},
				[5] = {
					con ={ [1701] = 20000,[1702] = 49999 },
					num = 999,					
					awd = {
						[3] = {{686,28,1},{1450,100,1},{1456,80,1},{1455,10,1},},
					},
				},
				[6] = {
					con ={ [1701] = 50000,[1702] = 99999 },
					num = 999,					
					awd = {
						[3] = {{686,75,1},{1450,200,1},{1456,200,1},{1455,25,1},},
					},
				},
				[7] = {
					con ={ [1701] = 100000,[1702] = 999999 },
					num = 999,					
					awd = {
						[3] = {{686,160,1},{1450,500,1},{1456,400,1},{1455,50,1},},
					},
		
				},
			},			
		},
	},
	
	[2000001103] = {
		list = { title = '新年祝福福气到',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 14*24*3600,tAward = 0,
			AwardBuf = {
				[1] = {
					con ={ [707] = 1 },
					num = 1,					
					awd = {
						[3] = {{1454,5,1},{1450,5,1},},
					},					
				},	
				[2] = {
					con ={ [707] = 2 },
					num = 1,					
					awd = {
						[3] = {{1454,5,1},{1450,10,1},},
					},					
				},	
				[3] = {
					con ={ [707] = 3 },
					num = 1,					
					awd = {
						[3] = {{1454,5,1},{1450,20,1},},
					},					
				},	
				[4] = {
					con ={ [707] = 4 },
					num = 1,					
					awd = {
						[3] = {{1454,10,1},{1450,30,1},},
					},					
				},	
				[5] = {
					con ={ [707] = 5 },
					num = 1,					
					awd = {
						[3] = {{1454,10,1},{1450,50,1},},
					},					
				},	
				[6] = {
					con ={ [707] = 6 },
					num = 1,					
					awd = {
						[3] = {{1454,15,1},{1450,80,1},},
					},					
				},	
				[7] = {
					con ={ [707] = 7 },
					num = 1,					
					awd = {
						[3] = {{1454,20,1},{1450,100,1},},
					},					
				},	
				[8] = {
					con ={ [707] = 8 },
					num = 1,					
					awd = {
						[3] = {{1454,30,1},{1450,200,1},},
					},					
				},	
			},			
		},
	},
	
	[2000001104] = {
		list = { title = '完成目标礼包',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 14*24*3600,tAward = 0,
			AwardBuf = {
				[1] = {
					con ={ [1518] = 10 },
					num = 1,					
					awd = {
						[3] = {{1451,3,1},{1457,1,1},},
					},					
				},
                [2] = {
					con ={ [1518] = 20 },
					num = 1,					
					awd = {
						[3] = {{1451,5,1},{1457,2,1},},
					},					
				},
				[3] = {
					con ={ [1518] = 30 },
					num = 1,					
					awd = {
						[3] = {{1451,10,1},{1457,3,1},},
					},					
				},
				[4] = {
					con ={ [1502] = 2 },
					num = 1,					
					awd = {
						[3] = {{1451,2,1},{1457,1,1},},
					},					
				},
				[5] = {
					con ={ [1506] = 20 },
					num = 1,					
					awd = {
						[3] = {{1451,3,1},{1457,2,1},},
					},					
				},
				[6] = {
					con ={ [1505] = 10 },
					num = 1,					
					awd = {
						[3] = {{1451,10,1},{1457,1,1},},
					},					
				},
				[7] = {
					con ={ [1505] = 20 },
					num = 1,					
					awd = {
						[3] = {{1451,20,1},{1457,2,1},},
					},					
				},
				[8] = {
					con ={ [1525] = 3 },
					num = 1,					
					awd = {
						[3] = {{1451,2,1},{1457,2,1},},
					},					
				},
			},			
		},
	},
	
	[2000001105] = {
		list = { title = '好礼大放送',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 14*24*3600,tAward = 0,
			AwardBuf = {
				[1] = {
					con ={ [1006] = 40 },		-- 参数代表等级限制
					num = 1,					
					awd = {
						[3] = {{1456,1,1},{1450,5,1},{1457,5,1},},
					},					
				},		
			},			
		},
	},
	
	[2000001106] = {
		list = { title = '限量大抢购',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 14*24*3600,tAward = 0,
			AwardBuf = {
				[1] = {
					con ={ 
						[1601] = 10,
						[1602] = 15880, 
						[1603] = 9980 
					},
					num = 10,					
					awd = {
						[3] = {{1446,1,1}},
					},					
				},	
				[2] = {
					con ={ 
						[1601] = 100,
						[1602] = 1000, 
						[1603] = 888 
					},
					num = 100,					
					awd = {
						[3] = {{1447,1,1}},
					},					
				},
				[3] = {
					con ={ 
						[1601] = 9999,
						[1602] = 300, 
						[1603] = 188 
					},
					num = 9999,					
					awd = {
						[3] = {{1458,1,1}},
					},					
				},
				[4] = {
					con ={ 
						[1601] = 100,
						[1602] = 1250, 
						[1603] = 888 
					},
					num = 100,					
					awd = {
						[3] = {{1448,1,1}},
					},					
				},	
			},			
		},
	},
	
	[2000001107] = {
		list = { title = '开年大礼包',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 10*24*3600,tEnd = 14*24*3600,tAward = 10*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [1006] = 40 },		-- 参数代表等级限制
					num = 1,					
					awd = {
						[3] = {{1460,1,1},{1052,500,1},{797,1,1},{683,1,1}},
					},					
				},		
			},			
		},
	},
	
	[2000001108] = {
		list = { title = '收集道具兑时装',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 14*24*3600,tAward = 0,
			AwardBuf = {
				[1] = {
					con ={ [401] = {[1451] = 10,} },
					num = 50,					
					awd = {
						[3] = {{636,6,1},},
					},					
				},	
      			[2] = {
					con ={ [401] = {[1451] = 50,} },
					num = 50,					
					awd = {
						[3] = {{762,20,1},},
					},					
				},	
				[3] = {
					con ={ [401] = {[1451] = 100,} },
					num = 50,					
					awd = {
						[3] = {{710,20,1},},
					},					
				},
				[4] = {
					con ={ [401] = {[1451] = 1588,[1455] = 100,} },
					num = 1,					
					awd = {
						[3] = {{2801,1,1},},
					},					
				},	
				[5] = {
					con ={ [401] = {[1451] = 1288,[1454] = 100,} },
					num = 1,					
					awd = {
						[3] = {{307,1,1},},
					},					
				},	
				[6] = {
					con ={ [401] = {[1451] = 888,[1452] = 100,} },
					num = 1,					
					awd = {
						[3] = {{2701,1,1},},
					},					
				},	
				[7] = {
					con ={ [401] = {[1451] = 288,[1453] = 100,} },
					num = 1,					
					awd = {
						[3] = {{2601,1,1},},
					},					
				},
				[8] = {
					con ={ [401] = {[1452] = 1,} },
					num = 99,					
					awd = {
						[3] = {{1461,1,1},},
					},					
				},
				[9] = {
					con ={ [401] = {[1453] = 1,} },
					num = 99,					
					awd = {
						[3] = {{1461,1,1},},
					},					
				}, 
				[10] = {
					con ={ [401] = {[1454] = 1,} },
					num = 99,					
					awd = {
						[3] = {{1461,1,1},},
					},					
				}, 
				[11] = {
					con ={ [401] = {[1455] = 1,} },
					num = 99,					
					awd = {
						[3] = {{1461,1,1},},
					},					
				},
			},			
		},
	},
	
	[2000001109] = {
		list = { title = '超级大转盘',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 14*24*3600,tAward = 14*24*3600,
			AwardBuf = {				
			},
			EventBuf = {
				arg = {
					[1] = {
						[905] = 3,
					},
					[2] = {
						[905] = 1,
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

-- 插入春节活动
local function _insert_chunjie_active()
	-- look('_insert_chunjie_active',1)
	local baseTime = initTime
	if baseTime == nil or baseTime == 0 then return end
	local active_conf = cj_activeconf
	if active_conf == nil then return end
	-- look(os_date('%Y-%m-%d %H:%M:%S', baseTime),1)
	local now = GetServerTime()
	-- look(os_date('%Y-%m-%d %H:%M:%S', now),1)
	if now < baseTime - 8*3600 or now >= baseTime + 14*24*3600 then
		return
	end	
	local list = __G.AllActiveListConf.list
	local cache = __G.AllActiveListConf.cache
	if list == nil or cache == nil then return end
	for k, v in pairs(active_conf) do
		list[k] = v.list
		cache[k] = {}
		-- look('v.cache.tView:' .. v.cache.tView,1)
		-- look('baseTime:' .. baseTime,1)
		cache[k].tView = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(baseTime+v.cache.tView))
		cache[k].tBegin = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(baseTime+v.cache.tBegin))
		cache[k].tEnd = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(baseTime+v.cache.tEnd))
		cache[k].tAward = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(baseTime+v.cache.tAward))
		cache[k].AwardBuf = v.cache.AwardBuf
		if v.cache.EventBuf then
			local t = v.cache.EventBuf
			local evtb = {}
			-- 这里延后一分钟等排行榜生成			
			local begtm = os_date('*t', GetNaturalDay(baseTime+v.cache.tBegin) + 60)	
			local awdtm = os_date('*t', GetNaturalDay(baseTime+v.cache.tAward) + 60)
			if t.Date then
				if type(t.Date[1]) == type(0) then
					begtm = os_date('*t', GetNaturalDay(baseTime+t.Date[1]))
				end
				if type(t.Date[2]) == type(0) then
					awdtm = os_date('*t', GetNaturalDay(baseTime+t.Date[2]))
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

insert_chunjie_active = _insert_chunjie_active