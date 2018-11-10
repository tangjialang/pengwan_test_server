--[[
file: hf_award.lua
desc: 合服补偿
autor: csj
]]--

--------------------------------------------------------
--include:

local pairs,ipairs,type = pairs,ipairs,type
local os_date = os.date
local GetServerOpenTime = GetServerOpenTime
local GetServerMergeTime = GetServerMergeTime
local GetServerTime = GetServerTime
local rint = rint
local look = look
local __G = _G

-------------------------------------------------------------------------
--module:

module(...)

------------------------------------------------------------------------
--inner:

-- 合服补偿配置
local merge_active_conf = {
	[2100000101] = {
		list = { title = '合服补偿',vIcon = 0,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 7*24*3600,tAward = 0,
			AwardBuf = {
				[1] = {
					con ={ [1401] = 40 },
					num = 1,					
					awd = {
						[3] = {{636,50,1},{803,200,1},{601,200,1},},
					},
				},
				[2] = {
					con ={ [1401] = 50, [1402] = 10 },
					num = 1,					
					awd = {
						[3] = {{673,5,1},{601,200,1},{52,2,1},},
					},
				},
				[3] = {
					con ={ [1401] = 50, [1402] = 20 },
					num = 1,					
					awd = {
						[3] = {{673,10,1},{601,400,1},{738,50,1},},
					},
				},
				[4] = {
					con ={ [1401] = 50, [1402] = 30 },
					num = 1,					
					awd = {
						[3] = {{673,30,1},{601,800,1},{738,100,1},},
					},
				},
			},			
		},
	},
}

-- 取自然天秒数
-- function GetNaturalDay(t)
	-- local sec = rint(t/(24*3600)) * 24 * 3600 - 8*3600
	-- return sec
-- end

-- 插入排行榜活动
function _insert_merge_award()
	look('_insert_merge_award')
	local mergeTime = GetServerMergeTime() or 0
	if mergeTime == 0 then return end
	look(os_date('%Y-%m-%d %H:%M:%S', mergeTime))
	local now = GetServerTime()
	look(os_date('%Y-%m-%d %H:%M:%S', now))
	if now >= mergeTime + 7*24*3600 then
		return
	end	
	local list = __G.AllActiveListConf.list
	local cache = __G.AllActiveListConf.cache
	if list == nil or cache == nil then return end
	for k, v in pairs(merge_active_conf) do
		list[k] = v.list
		cache[k] = {}
		cache[k].tView = os_date('%Y-%m-%d %H:%M:%S', mergeTime+v.cache.tView)
		cache[k].tBegin = os_date('%Y-%m-%d %H:%M:%S', mergeTime+v.cache.tBegin)
		cache[k].tEnd = os_date('%Y-%m-%d %H:%M:%S', mergeTime+v.cache.tEnd)
		cache[k].tAward = os_date('%Y-%m-%d %H:%M:%S', mergeTime+v.cache.tAward)
		cache[k].AwardBuf = v.cache.AwardBuf
		-- if v.cache.EventBuf then
			-- local t = v.cache.EventBuf
			-- local evtb = {}
			-- -- 这里延后一分钟等排行榜生成
			-- local begtm = os_date('*t', GetNaturalDay(mergeTime+v.cache.tBegin) + 60)	
			-- local awdtm = os_date('*t', GetNaturalDay(mergeTime+v.cache.tAward) + 60)
			-- local bt = {begtm.year,begtm.month,begtm.day,begtm.hour,begtm.min,begtm.sec}
			-- local at = {awdtm.year,awdtm.month,awdtm.day,awdtm.hour,awdtm.min,awdtm.sec}
			-- evtb.Date = {bt,at}
			-- evtb.arg = t.arg			
			-- regist_event_dynamic(evtb,now,k)
		-- end
	end
end

------------------------------------------------------------------------
--interface:

insert_merge_award = _insert_merge_award
