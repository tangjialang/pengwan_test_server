--[[
file: 51active.lua
desc: 51活动
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

local initTime = GetTimeToSecond(2014,12,24,0,0,0) + 8*3600

-------------------------------------------------------------------------
--module:

module(...)

------------------------------------------------------------------------
--inner:
--登陆
local activeconf_51 = {
	[2000001701] = {
		list = { title = '登陆送礼',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			--可见时间,开始时间，结束时间，领奖时间
			tView = 0,tBegin = 0,tEnd = 3*24*3600,tAward = 0,
			AwardBuf = {
				[1] = {
					con ={ [1006] = 0 }, --判断条件 值为最低等级
					num = 1,	         --次数				
					awd = {
						--获取物品奖励key必须为3表示物品
						--表里依次是物品id，数量，是否绑定
						[3] = {{1594,2,1},{803,50,1},{601,20,1},{603,20,1},{1595,1,1},{1596,1,1}},
					},					
				},	
						
			},			
		},
	},
	--完成指标送礼
	[2000001702] = {
		list = { title = '完成指标送礼',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 3*24*3600,tAward = 0,
			AwardBuf = {
			--点金10次
				[1] = {
					con ={ [1518] = 10 },
					num = 1,					
					awd = {
						[3] = {{1595,2,1},{1596,2,1}},
					},					
				},
			--点金20次	
                [2] = {
					con ={ [1518] = 20 },
					num = 1,					
					awd = {
						[3] = {{1595,4,1},{1596,4,1}},
					},					
				},
				--点金30次
				[3] = {
					con ={ [1518] = 30 },
					num = 1,					
					awd = {
						[3] = {{1595,10,1},{1596,10,1}},
					},					
				},
				--组队副本2次
				[4] = {
					con ={ [1502] = 2 },
					num = 1,					
					awd = {
						[3] = {{1595,4,1},{1596,4,1}},
					},					
				},
				--悬赏任务20次
				[5] = {
					con ={ [1506] = 20 },
					num = 1,					
					awd = {
						[3] = {{1595,4,1},{1596,4,1}},
					},					
				},
				--活跃度达到80
				[6] = {
					con ={ [1002] = 80 },
					num = 1,					
					awd = {
						[3] = {{1595,3,1},{1596,3,1}},
					},					
				},
				--活跃度到达100
				[7] = {
					con ={ [1002] = 100 },
					num = 1,					
					awd = {
						[3] = {{1595,4,1},{1596,4,1}},
					},					
				},
				--护送美人鱼1次
				[8] = {
					con ={ [1525] = 1 },
					num = 1,					
					awd = {
						[3] = {{1595,3,1},{1596,3,1}},
					},					
				},
			},			
		},
	},
	
	--51奖章兑换
	[2000001703] = {
		list = { title = '51奖章兑换',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 3*24*3600,tAward = 0,
			AwardBuf = {
			
				[1] = {
					--con 中表里面key值为id，值为数量
					con ={ [401] = {[1595] = 1,[1596] = 1,} },
					num = 99, --次数
					--key值为3表示奖励物品 ，表里面依次为id 数量 是否绑定
					awd = {
						[3] = {{601,10,1}},
					},					
				},	

      			[2] = {
					con ={ [401] = {[1595] = 1,[1596] = 1,} },
					num = 99, --次数
					awd = {
						[3] = {{636,1,1}},
					},					
				},	
				--五一劳动奖章*10 彩虹石*10
				[3] = {
					con ={ [401] = {[1595] = 1,[1596] = 1,} },
					num = 99, --次数
					awd = {
						[3] = {{634,1,1}},
					},					
				},
				--五一劳动奖章*10 强化卡*3
				[4] = {
					con ={ [401] = {[1595] = 2,[1596] = 2,} },
					num = 99, --次数
					awd = {
						[3] = {{803,10,1}},
					},				
				},	
				--五一劳动奖章*100 称号-劳动光荣
				[5] = {
					con ={ [401] = {[1595] = 50,[1596] = 50,} },
					num = 1, --次数
					awd = {
						[3] = {{763,1,1}},
					},						
				},	
				--五一劳动奖章*200 五一劳动奖状*1
				[6] = {
					con ={ [401] = {[1595] = 100,[1596] = 100,} },
					num = 1, --次数
					awd = {
						[3] = {{415,1,1}},
					},					
				},	
				
			},			
		},
	},
	--限时抢购
	-- [2000001204] = {
		-- list = { title = '限量大抢购',vIcon = 1030,ver = 0,pic = 0 },
		-- cache = {
			-- tView = 0,tBegin = 0,tEnd = 4*24*3600,tAward = 0,
			-- AwardBuf = {
			-- --强化卡*5
				-- [1] = {
					-- con ={ 
						-- [1601] = 999, --全服限购个数
						-- [1602] = 50, --原价 
						-- [1603] = 25   --现价
					-- },
					-- num = 999,		--个人限购			
					-- awd = {
						-- [3] = {{804,5,1}},
					-- },					
				-- },	
			-- --炼骨丹*100
				-- [2] = {
					-- con ={ 
						-- [1601] = 666,
						-- [1602] = 200, 
						-- [1603] = 120 
					-- },
					-- num = 666,					
					-- awd = {
						-- [3] = {{627,100,1}},
					-- },					
				-- },
			-- --彩虹石*100
				-- [3] = {
					-- con ={ 
						-- [1601] = 666,
						-- [1602] = 200, 
						-- [1603] = 120 
					-- },
					-- num = 666,					
					-- awd = {
						-- [3] = {{626,100,1}},
					-- },					
				-- },
			-- --七级攻击宝石*1
				-- [4] = {
					-- con ={ 
						-- [1601] = 8,
						-- [1602] = 20000, 
						-- [1603] = 7000 
					-- },
					-- num = 8,					
					-- awd = {
						-- [3] = {{416,1,1}},
					-- },					
				-- },	
			-- },			
		-- },
	-- },	
	--击杀boss
	[2000001705] = {
		list = { title = '击杀boss',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 3*24*3600,tAward = 0,
			AwardBuf = {
					[3] = {{1594,1,1},{1595,1,1},{1596,1,1},{765,1,1},{766,1,1},{802,1,1}},		
			},
		},
	},
	--51充值送礼
	[2000001706] = {
		list = { title = '51充值送礼',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 3*24*3600,tAward = 0,
			AwardBuf = {
			--200元宝
				[1] = {
				--里面的值表示范围
					con ={ [1701] = 200,[1702] = 499 },
					num = 999,					
					awd = {
						[3] = {{1594,5,1},},
					      },
					},
				[2] = {
					con ={ [1701] = 500,[1702] = 999 },
					num = 999,					
					awd = {
						[3] = {{1594,12,1},},
					},
				},
				[3] = {
					con ={ [1701] = 1000,[1702] = 1999 },
					num = 999,					
					awd = {
						[3] = {{1594,25,1},{803,50,1},{601,50,1},},
					},
				},
				[4] = {
					con ={ [1701] = 2000,[1702] = 4999 },
					num = 999,					
					awd = {
						[3] = {{1594,55,1},{803,120,1},{601,120,1},},
					},
				},
				[5] = {
					con ={ [1701] = 5000,[1702] = 9999 },
					num = 999,					
					awd = {
						[3] = {{1594,120,1},{803,300,1},{601,300,1},},
					},
				},
				[6] = {
					con ={ [1701] = 10000,[1702] = 19999 },
					num = 999,					
					awd = {
						[3] = {{1594,250,1},{803,800,1},{601,800,1},},
					},
				},
				[7] = {
					con ={ [1701] = 20000,[1702] = 9999999 },
					num = 999,					
					awd = {
						[3] = {{1594,550,1},{803,2000,1},{601,2000,1},},
					},
				},
			},			
		},
	},
	-- [2000001207] = {
		-- list = { title = '超级大转盘',vIcon = 1030,ver = 0,pic = 0 },
		-- cache = {
			-- tView = 0,tBegin = 0,tEnd = 4*24*3600,tAward = 3*24*3600,
			-- AwardBuf = {				
			-- },
			-- EventBuf = {
				-- arg = {
					-- [1] = {
						-- [905] = 3,
					-- },
					-- [2] = {
						-- [905] = 1,
					-- },
				-- },
			-- },
		-- },

	-- }
--},
}
-- 取自然天秒数
function GetNaturalDay(t)
	local sec = rint(t/(24*3600)) * 24 * 3600 - 8*3600
	return sec
end

-- 插入51活动活动
local function _insert_51_active()
	look('_insert_51_active',2)
	
	local baseTime = initTime
	if baseTime == nil or baseTime == 0 then return end
	local active_conf = activeconf_51
	if active_conf == nil then return end
	local now = GetServerTime()
	if now < baseTime - 8*3600 or now >= baseTime + 8*24*3600 then
		return
	end	
	look('_insert_51_active11',2)
	
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

insert_51_active = _insert_51_active