--[[
file: kf_everyday.lua
desc: 开服天后每日充值活动
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
local ceil=math.ceil
local time_proc_m = require('Script.active.time_proc')
local regist_event_dynamic = time_proc_m.regist_event_dynamic
local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond
local GetDiffDayFromTime=common_time.GetDiffDayFromTime


-- local time_ver = GetTimeToSecond(2013,12,12,0,0,0)

-------------------------------------------------------------------------
--module:

module(...)

------------------------------------------------------------------------
--inner:
-----开服后8天开始,4天循环
local kf_everydayconf1 = {
	[2000005211] = {--每日充值特惠
		list = { title = '活动期间，每日充值达到指定元宝即可领取一份奖励，奖励可以兼得，例如充值5000元宝可以获得200至5000元宝所有奖励一份。',vIcon = 903,ver = 0,pic = 999 },
		desc = '活动期间，每日充值达到指定元宝即可领取一份奖励，奖励可以兼得，例如充值5000元宝可以获得200至5000元宝所有奖励一份。',
    cache = {
			tView = 0,tBegin =0,tEnd = 2*24*3600,tAward =0,
			AwardBuf = {
           		[1] = {--每日充值
               		con = {[804] = 200},
            	   	num = 1,
					awd = {
                 	 	[3] = {{710,2,1},{776,2,1},{803,10,1},{761,1,1},},
                 	},
                },
				[2] = {--每日充值
               		con = {[804] = 500},
            	   	num = 1,
					awd = {
                 	 	[3] = {{710,3,1},{776,3,1},{803,20,1},{758,1,1},},
                 	},
                },
				[3] = {--每日充值
               		con = {[804] = 1000},
            	   	num = 1,
					awd = {
                 	 	[3] = {{710,3,1},{776,5,1},{803,40,1},{760,1,1},{796,3,1},},
                 	},
                },
				[4] = {--每日充值
               		con = {[804] = 2000},
            	   	num = 1,
					awd = {
                 	 	[3] = {{710,5,1},{776,10,1},{803,80,1},{759,1,1},{796,6,1},},
                 	},
                },
				[5] = {--每日充值
               		con = {[804] = 5000},
            	   	num = 1,
					awd = {
                 	 	[3] = {{710,10,1},{776,30,1},{803,180,1},{757,1,1},{796,15,1},{802,50,1},},
                 	},
                },
				[6] = {--每日充值
               		con = {[804] = 10000},
            	   	num = 1,
					awd = {
                 	 	[3] = {{710,20,1},{776,50,1},{803,300,1},{778,20,1},{796,30,1},{802,100,1},},
                 	},
                },
				[7] = {--每日充值
               		con = {[804] = 20000},
            	   	num = 1,
					awd = {
                 	 	[3] = {{710,30,1},{776,100,1},{803,500,1},{778,40,1},{796,60,1},{802,200,1},},
                 	},
                },
				[8] = {--每日充值
               		con = {[804] = 50000},
            	   	num = 1,
					awd = {
                 	 	[3] = {{710,100,1},{776,300,1},{803,1000,1},{778,100,1},{796,150,1},{802,500,1},{766,2,1},},
                 	},
                },
				[9] = {--每日充值
               		con = {[804] = 100000},
            	   	num = 1,
					awd = {
                 	 	[3] = {{710,170,1},{776,500,1},{803,2000,1},{778,200,1},{796,300,1},{802,1000,1},{712,1,1},{783,1,1},},
                 	},
                },
            },
		},
	},
	[2000005212] = {--活动期间，骑兵达到指定等阶即可领取对应等阶的完美神铁1，提升对应等阶的祝福值15%，让你升阶骑兵更容易。
		list = { title = '升级骑兵送好礼',vIcon = 1011,ver = 0,pic = 4006 },
		desc = '活动期间，骑兵达到指定等阶即可领取对应等阶的完美神铁1，提升对应等阶的祝福值15%，让你升阶骑兵更容易。',
    cache = {
			tView = 0,tBegin =0,tEnd = 2*24*3600,tAward =0,
			AwardBuf = {
           		[1] = {
               		con = {[1301] = 2},
            	   	num = 1,
					awd = {
                 	 	[3] = {{3044,1,1}},
                 	},
                },
				[2] = {
               		con = {[1301] = 3},
            	   	num = 1,
					awd = {
                 	 	[3] = {{3045,1,1}},
                 	},
                },
				[3] = {
               		con = {[1301] = 4},
            	   	num = 1,
					awd = {
                 	 	[3] = {{3046,1,1}},
                 	},
                },
				[4] = {
               		con = {[1301] = 5},
            	   	num = 1,
					awd = {
                 	 	[3] = {{3047,1,1}},
                 	},
                },
				[5] = {
               		con = {[1301] = 6},
            	   	num = 1,
					awd = {
                 	 	[3] = {{3048,1,1}},
                 	},
                },
            },
		},
	},
}

-----开服后10天开始,4天循环
local kf_everydayconf2 = {
	[2000005221] = {--每日充值特惠--神翼
		list = { title = '活动期间，每日充值达到指定元宝即可领取一份奖励，奖励可以兼得，例如充值5000元宝可以获得200至5000元宝所有奖励一份。',vIcon = 903,ver = 0,pic = 999 },
		desc = '活动期间，每日充值达到指定元宝即可领取一份奖励，奖励可以兼得，例如充值5000元宝可以获得200至5000元宝所有奖励一份。',
    cache = {
			tView = 0,tBegin =0,tEnd = 2*24*3600,tAward =0,
			AwardBuf = {
           		[1] = {--每日充值
               		con = {[804] = 200},
            	   	num = 1,
					awd = {
                 	 	[3] = {{762,6,1},{776,2,1},{803,10,1},{761,1,1},},
                 	},
                },
				[2] = {--每日充值
               		con = {[804] = 500},
            	   	num = 1,
					awd = {
                 	 	[3] = {{762,9,1},{776,3,1},{803,20,1},{758,1,1},},
                 	},
                },
				[3] = {--每日充值
               		con = {[804] = 1000},
            	   	num = 1,
					awd = {
                 	 	[3] = {{762,9,1},{776,5,1},{803,40,1},{760,1,1},{796,3,1},},
                 	},
                },
				[4] = {--每日充值
               		con = {[804] = 2000},
            	   	num = 1,
					awd = {
                 	 	[3] = {{762,15,1},{776,10,1},{803,80,1},{759,1,1},{796,6,1},},
                 	},
                },
				[5] = {--每日充值
               		con = {[804] = 5000},
            	   	num = 1,
					awd = {
                 	 	[3] = {{762,30,1},{776,30,1},{803,180,1},{757,1,1},{796,15,1},{802,50,1},},
                 	},
                },
				[6] = {--每日充值
               		con = {[804] = 10000},
            	   	num = 1,
					awd = {
                 	 	[3] = {{762,60,1},{776,50,1},{803,300,1},{778,20,1},{796,30,1},{802,100,1},},
                 	},
                },
				[7] = {--每日充值
               		con = {[804] = 20000},
            	   	num = 1,
					awd = {
                 	 	[3] = {{762,90,1},{776,100,1},{803,500,1},{778,40,1},{796,60,1},{802,200,1},},
                 	},
                },
				[8] = {--每日充值
               		con = {[804] = 50000},
            	   	num = 1,
					awd = {
                 	 	[3] = {{762,300,1},{776,300,1},{803,1000,1},{778,100,1},{796,150,1},{802,500,1},{731,1,1},},
                 	},
                },
				[9] = {--每日充值
               		con = {[804] = 100000},
            	   	num = 1,
					awd = {
                 	 	[3] = {{762,510,1},{776,500,1},{803,2000,1},{778,200,1},{796,300,1},{802,1000,1},{764,1,1},{783,1,1},},
                 	},
                },
            },
		},
	},
	[2000005222] = {--活动期间，神翼达到指定等阶即可领取对应等阶的七彩羽毛1，提升对应等阶的祝福值15%，让你升阶神翼更容易。
		list = { title = '升级神翼送好礼',vIcon = 1011,ver = 0,pic = 4001 },
		desc = '活动期间，神翼达到指定等阶即可领取对应等阶的七彩羽毛1，提升对应等阶的祝福值15%，让你升阶神翼更容易。',
    cache = {
			tView = 0,tBegin =0,tEnd = 2*24*3600,tAward =0,
			AwardBuf = {
           		[1] = {
               		con = {[1801] = 2},
            	   	num = 1,
					awd = {
                 	 	[3] = {{3058,1,1},},
                 	},
                },
				[2] = {
               		con = {[1801] = 3},
            	   	num = 1,
					awd = {
                 	 	[3] = {{3059,1,1}},
                 	},
                },
				[3] = {
               		con = {[1801] = 4},
            	   	num = 1,
					awd = {
                 	 	[3] = {{3060,1,1}},
                 	},
                },
				[4] = {
               		con = {[1801] = 5},
            	   	num = 1,
					awd = {
                 	 	[3] = {{3061,1,1}},
                 	},
                },
				[5] = {
               		con = {[1801] = 6},
            	   	num = 1,
					awd = {
                 	 	[3] = {{3062,1,1}},
                 	},
                },
				[6] = {
               		con = {[1801] = 7},
            	   	num = 1,
					awd = {
                 	 	[3] = {{3068,1,1}},
                 	},
                },
				[7] = {
               		con = {[1801] = 8},
            	   	num = 1,
					awd = {
                 	 	[3] = {{3069,1,1}},
                 	},
                },
				[8] = {
               		con = {[1801] = 9},
            	   	num = 1,
					awd = {
                 	 	[3] = {{3070,1,1}},
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

-- 插入活动
function _insert_kfeday_active()
  -- look('插入活动',1)
	local openTime = GetServerOpenTime()
	if openTime == 0 then return end
	--look(os_date('%Y-%m-%d %H:%M:%S', openTime),1)
	--local now = GetServerTime()
	local day=GetDiffDayFromTime(openTime)+1
  -- look(day,1)
	if day < 8 then--开服8天内不出活动
		-- look(222,1)
		return
	end	
	-- if openTime > time_ver then
	 	-- look(111,1)
	-- 	return
	-- end
	local list = __G.AllActiveListConf.list
	local cache = __G.AllActiveListConf.cache
	if list == nil or cache == nil then return end

	local kf_conf
	local res=0
	if (day-8)%4==0 or (day-8)%4==1  then 
		res=(day-8)%4
		kf_conf=kf_everydayconf1
	elseif (day-10)%4==0 or (day-10)%4==1 then 
		res=(day-10)%4
		kf_conf=kf_everydayconf2
	else
		return
	end
  -- look(333,1)
	local Begin=(day-1-res)*24*3600
	local _end=(day+1-res)*24*3600

	for k, v in pairs(kf_conf) do
		 -- look(k,1)
		list[k] = v.list
		cache[k] = {}
		-- look('v.cache.tView:' .. v.cache.tView)
		-- look('openTime:' .. openTime)
		cache[k].tView = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(openTime+Begin))
		cache[k].tBegin = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(openTime+Begin))
		cache[k].tEnd = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(openTime+_end))
		cache[k].tAward = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(openTime+Begin))
		cache[k].AwardBuf = v.cache.AwardBuf
		-- look(cache[k].tBegin,1)
	end
end

------------------------------------------------------------------------
--interface:

insert_kfeday_active = _insert_kfeday_active