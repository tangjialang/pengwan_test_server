--[[
file: kf_chongzhi.lua
desc: 开服充值活动
autor: wk
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

local kf_chongzhiconf = {
	[2000005001] = {
		list = { title = '活动期间，每笔充值达到以下指定金额即可领取一份奖励，每笔充值按达到的最高奖励计算，该活动可以重复参加，单笔充值额度越大越划算。',vIcon = 903,ver = 0,pic = 998 },
		desc = '活动期间，每笔充值达到以下指定金额即可领取一份奖励，每笔充值按达到的最高奖励计算，该活动可以重复参加，单笔充值额度越大越划算。',
		cache = {
			tView = 0,tBegin = 2*24*3600,tEnd = 4*24*3600,tAward = 2*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [1701] = 500, [1702] =999,},
					num = 100,					
					awd = {
						[3] = {{636,10,1},{768,2,1},},
					},
				},
				[2] = {
					con ={ [1701] = 1000, [1702] =2999,},
					num = 100,					
					awd = {
						[3] = {{636,21,1},{768,5,1},{601,20,1},},
					},
				},
				[3] = {
					con ={ [1701] = 3000, [1702] =4999,},
					num = 100,					
					awd = {
						[3] = {{636,70,1},{768,15,1},{601,50,1},{652,1,1},{637,20,1},},
							},
				},
				[4] = {
					con ={ [1701] = 5000, [1702] =9999,},
					num = 100,					
					awd = {
						[3] = {{636,120,1},{768,25,1},{601,100,1},{652,2,1},{637,40,1},},
							},
				},
				[5] = {
					con ={ [1701] = 10000, [1702] =19999,},
					num = 100,					
					awd = {
						[3] = {{636,240,1},{768,50,1},{601,200,1},{647,1,1},{652,2,1},{637,80,1},},
							},
				},
			    [6] = {
					con ={ [1701] = 20000, [1702] =999999,},
					num = 100,					
					awd = {
						[3] = {{636,500,1},{768,50,1},{601,500,1},{647,2,1},{652,5,1},{637,100,1},},
							},
				},
			},
		},
	},
[2000005002] = {
		list = { title = '动期间，每笔充值达到以下指定金额即可领取一份奖励，每笔充值按达到的最高奖励计算，该活动可以重复参加，单笔充值额度越大越划算。',vIcon = 903,ver = 0,pic = 998 },
		desc = '活动期间，每笔充值达到以下指定金额即可领取一份奖励，每笔充值按达到的最高奖励计算，该活动可以重复参加，单笔充值额度越大越划算。',
		cache = {
			tView = 0,tBegin = 4*24*3600,tEnd = 5*24*3600,tAward = 4*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [1701] = 500, [1702] =999,},
					num = 100,					
					awd = {
						[3] = {{634,10,1},{768,2,1},},
					},
				},
				[2] = {
					con ={ [1701] = 1000, [1702] =2999,},
					num = 100,					
					awd = {
						[3] = {{634,21,1},{768,5,1},{601,20,1},{772,2,1},},
					},
				},
				[3] = {
					con ={ [1701] = 3000, [1702] =4999,},
					num = 100,					
					awd = {
						[3] = {{634,70,1},{768,15,1},{601,50,1},{652,1,1},{772,6,1},},
							},
				},
				[4] = {
					con ={ [1701] = 5000, [1702] =9999,},
					num = 100,					
					awd = {
						[3] = {{634,120,1},{768,25,1},{601,100,1},{652,2,1},{771,5,1},{772,12,1},},
							},
				},
				[5] = {
					con ={ [1701] = 10000, [1702] =19999,},
					num = 100,					
					awd = {
						[3] = {{634,240,1},{768,50,1},{601,200,1},{647,2,1},{771,10,1},{772,25,1},},
							},
				},
			    [6] = {
					con ={ [1701] = 20000, [1702] =999999,},
					num = 100,					
					awd = {
						[3] = {{634,500,1},{768,50,1},{601,500,1},{652,5,1},{771,25,1},{772,50,1},},
							},
				},
			},
		},
	},
[2000005003] = {
		list = { title = '开动期间，每笔充值达到以下指定金额即可领取一份奖励，每笔充值按达到的最高奖励计算，该活动可以重复参加，单笔充值额度越大越划算。',vIcon = 903,ver = 0,pic = 998 },
		desc = '活动期间，每笔充值达到以下指定金额即可领取一份奖励，每笔充值按达到的最高奖励计算，该活动可以重复参加，单笔充值额度越大越划算。',
		cache = {
			tView = 0,tBegin = 5*24*3600,tEnd = 7*24*3600,tAward = 5*24*3600,
			AwardBuf = {
				[1] = {
					con ={ [1701] = 500, [1702] =999,},
					num = 100,					
					awd = {
						[3] = {{762,10,1},{768,2,1},},
					},
				},
				[2] = {
					con ={ [1701] = 1000, [1702] =2999,},
					num = 100,					
					awd = {
						[3] = {{762,21,1},{768,5,1},{601,20,1},},
					},
				},
				[3] = {
					con ={ [1701] = 3000, [1702] =4999,},
					num = 100,					
					awd = {
						[3] = {{762,70,1},{768,15,1},{601,50,1},{657,1,1},},
							},
				},
				[4] = {
					con ={ [1701] = 5000, [1702] =9999,},
					num = 100,					
					awd = {
						[3] = {{762,120,1},{768,25,1},{601,100,1},{657,1,1},{637,40,1},},
							},
				},
				[5] = {
					con ={ [1701] = 10000, [1702] =19999,},
					num = 100,					
					awd = {
						[3] = {{762,240,1},{768,50,1},{601,200,1},{657,2,1},{637,80,1},{666,2,1},},
							},
				},
			    [6] = {
					con ={ [1701] = 20000, [1702] =999999,},
					num = 100,					
					awd = {
						[3] = {{762,500,1},{768,50,1},{601,500,1},{657,5,1},{677,1,1},{763,1,1},},
							},
				},
			},
		},
	},	
	[2000005004] = {
		list = { title = '开动期间，每笔充值达到以下指定金额即可领取一份奖励，每笔充值按达到的最高奖励计算，该活动可以重复参加，单笔充值额度越大越划算。',vIcon = 903,ver = 0,pic = 998 },
		desc = '活动期间，每笔充值达到以下指定金额即可领取一份奖励，每笔充值按达到的最高奖励计算，该活动可以重复参加，单笔充值额度越大越划算。',
		cache = {
			tView = 0,tBegin = 0,tEnd = 2*24*3600,tAward = 0,
			AwardBuf = {
				[1] = {
					con ={ [1701] = 500, [1702] =999,},
					num = 100,					
					awd = {
						[3] = {{684,20,1},},
					},
				},
				[2] = {
					con ={ [1701] = 1000, [1702] =1999,},
					num = 100,					
					awd = {
						[3] = {{684,60,1},},
					},
				},
				[3] = {
					con ={ [1701] = 2000, [1702] =4999,},
					num = 100,					
					awd = {
						[3] = {{684,140,1},},
							},
				},
				[4] = {
					con ={ [1701] = 5000, [1702] =9999,},
					num = 100,					
					awd = {
						[3] = {{684,400,1},},
							},
				},
				[5] = {
					con ={ [1701] = 10000, [1702] =999999,},
					num = 100,					
					awd = {
						[3] = {{684,1000,1},},
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
function _insert_kfcz_active()
	local openTime = GetServerOpenTime()
	if openTime == 0 then return end
	--look(os_date('%Y-%m-%d %H:%M:%S', openTime),1)
	local now = GetServerTime()
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
	for k, v in pairs(kf_chongzhiconf) do
		-- look(k,1)
		local res=true
		if k==2000005004 then 
			local begintime = GetTimeToSecond(2014,4,22,0,0,0)
			if openTime<begintime then 
				res=nil
			end
		end
		if res then 
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
end

------------------------------------------------------------------------
--interface:

insert_kfcz_active = _insert_kfcz_active