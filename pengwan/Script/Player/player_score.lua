--[[

file:	player_score.lua

desc:	各种积分数据

author:	wk

update:	2013-7-17

]]--

local active_mgr_m = require('Script.active.active_mgr')
local activitymgr=active_mgr_m.activitymgr
local GetPlayerDayData=GetPlayerDayData
local type,pairs=type,pairs

local TP_FUNC = type( function() end)

local db_module = require('Script.cext.dbrpc')

local db_active_score = db_module.db_active_score



local daysclist={0,0,0,0}--每日有没领奖的记录日志



--活动类型,索引和排行榜对应,名字和dr_conf对应

-- 奖励表为统一奖励类型

local _active_type={
	[1] = {
		name = 'wenquan',		
	},
	[2] = {
		name = 'qsls',
	},
	[3] = {
		name = 'hunting',
		awards = {
			-- [1] = {},		-- 每日排行榜排名奖励
			[2] = {				-- 每周排行榜排名奖励
				[1] = {			-- 第1名奖励  称号，秒
					[9] = {
						[1] = {13,7*24*3600},
					},
				},	
				[1] = {			-- 第2~10名奖励  称号，秒
					[9] = {
						[1] = {14,7*24*3600},
					},
				},		
			},	
		},
	},
	[4] = {
		name = 'catch_fish',
		awards = {
			-- [1] = {},		-- 每日排行榜排名奖励
			[2] = {				-- 每周排行榜排名奖励
				[1] = {			-- 第1名奖励  称号，秒
					[9] = {
						[1] = {15,7*24*3600},
					},
				},	
				[1] = {			-- 第2~10名奖励  称号，秒
					[9] = {
						[1] = {16,7*24*3600},
					},
				},		
			},	
		},
	},
	[5] = {
		name = nil,				-- 魅力,只有周积分
		awards = {
			-- [1] = {},		-- 每日排行榜排名奖励
			[2] = {				-- 每周排行榜排名奖励
				[1] = {			-- 第一名奖励  称号，秒
					[9] = {
						[2] = {{26,7*24*3600},{24,7*24*3600}},	-- 分性别
					},
				},	
				[2] = {
					[9] = {
						[2] = {{27,7*24*3600},{25,7*24*3600}},	-- 分性别
					},
				},	
			},	
		},
	},
	[6] = {
		name = 'sjzc',			-- 三界战场
		awards = {
			-- [1] = {},		-- 每日排行榜排名奖励
			[2] = {				-- 每周排行榜排名奖励
				[1] = {			-- 第1名奖励  称号，秒
					[9] = {
						[1] = {19,7*24*3600},
					},
				},	
				[2] = {			-- 第2~10名奖励  称号，秒
					[9] = {
						[1] = {20,7*24*3600},
					},
				},		
			},	
		},
	},
	[7] = {
		name = nil,				-- 神兽
	},
	[8] = {
		name = 'jjc',			-- 竞技场
		awards = {
			-- [1] = {},		-- 每日排行榜排名奖励
			[2] = {				-- 每周排行榜排名奖励
				[1] = {			-- 第1名奖励  称号，秒
					[9] = {
						[1] = {22,7*24*3600},
					},
				},	
				[2] = {			-- 第2~10名奖励  称号，秒
					[9] = {
						[2] = {23,7*24*3600},
					},
				},		
			},	
		},
	},
	[9] = {						-- 帮会战(只针对排行榜用、跟个人无关)
		name = 'ff',
		awards = {	
			[2] = {				-- 每月排行榜排名奖励
				[1] = {			-- 第1名奖励  称号，秒
					[9] = {
						[1] = {21,7*24*3600},
					},
				},		
			},	
		},
	},
	[10] = {
		name = 'afight',			-- 三界战场
		awards = {
			-- [1] = {},		-- 每日排行榜排名奖励
			[2] = {				-- 每周排行榜排名奖励
				[1] = {			-- 第1名奖励  称号，秒
					[9] = {
						[1] = {19,7*24*3600},
					},
				},	
				[2] = {			-- 第2~10名奖励  称号，秒
					[9] = {
						[1] = {20,7*24*3600},
					},
				},		
			},	
		},
	},
	[11] = {
		name = 'cf',			-- 帮会攻城战
	},
	[12] = {
		name = nil,				-- 铜钱捐献
	},
}



---------------------------------------------------------------

-- 玩家每日活动积分数据

local function _sc_getdaydata(playerid,index)

	if playerid == nil or playerid == 0 then return end

	local dayData 	= GetPlayerDayData(playerid)

	if dayData==nil then  return end

	if dayData.days==nil then

		dayData.days={}

	end

	if index==nil then

		return dayData.days

	else

		return dayData.days[index]

	end

end

-- 玩家每周活动积分数据

local function _sc_getweekdata(playerid,index)

	if playerid == nil or playerid == 0 then return end

	local dayData 	= GetPlayerDayData(playerid)

	if dayData==nil then return end

	if dayData.weeks==nil then

		dayData.weeks={}

	end

	if index==nil then

		return dayData.weeks

	else

		return dayData.weeks[index]

	end

end



--增加积分

--itype=nil,日积分和周积分同时加,1只加日积分,2只加周积分

local function _sc_add(playerid,index,val,itype)

	local scdaydata=_sc_getdaydata(playerid)

	local scweekdata=_sc_getweekdata(playerid)
	if scdaydata==nil or scweekdata==nil then return end
	if itype==nil then

		scdaydata[index]=(scdaydata[index] or 0)+val

		scweekdata[index]=(scweekdata[index] or 0)+val

		return scdaydata[index],scweekdata[index]

	elseif itype==1 then

		scdaydata[index]=(scdaydata[index] or 0)+val

		return scdaydata[index]

	elseif itype==2 then

		scweekdata[index]=(scweekdata[index] or 0)+val

		return scweekdata[index]

	end

end

--上线查询有没该领奖没领的情况

local function _active_getawards(playerid)
	-- 跨服不处理这个逻辑
	if IsSpanServer() then
		return
	end
	local dayData 	= GetPlayerDayData(playerid)
	if dayData==nil then return end
	if type(dayData.days) ~= type({}) then return end 

	for k,v in pairs(dayData.days) do

		if type(k)==type(0) and type(v)==type(0) then

			local _name=_active_type[k].name

			if _name~=nil then 

				local mark=false

				local Active_name=activitymgr:get(_name)

				if Active_name==nil then

					mark=true

				else

					local res=Active_name:get_state()

					if res==0 then

						mark=true

					end

				end

				if mark then

					RPC('active_awards',k)

				end

			end

		end

	end

end





--领奖后清0

local function _sc_reset_getawards(playerid,index)

	local dayData 	= GetPlayerDayData(playerid)

	dayData.days[index]=nil

end

--日积分清0

local function _sc_reset_day(playerid)

	local dayData 	= GetPlayerDayData(playerid)

	

	if dayData.days==nil  then return end

	local mark=false

	for k,v in pairs(daysclist) do

		daysclist[k]=nil

	end

	if dayData.days[3]~=nil and dayData.days[3]>=1000 then --抓马

		daysclist[1]=dayData.days[3]

		mark=true

	end

	if dayData.days[4]~=nil and dayData.days[4]>=1000  then--抓鱼

		daysclist[2]=dayData.days[4]

		mark=true

	end

	if dayData.days[6]~=nil and dayData.days[6]>=100  then--三界

		daysclist[3]=dayData.days[6]

		mark=true

	end

	if dayData.days[9]~=nil and dayData.days[9]>=100  then--帮会

		daysclist[4]=dayData.days[9]

		mark=true

	end

	if mark then --有没领奖的,记录

		db_active_score(playerid,GetServerTime(),daysclist)

	end



	dayData.days=nil --清数据



end

--周积分清0

local function _sc_reset_week(playerid)

	local dayData 	= GetPlayerDayData(playerid)

	dayData.weeks=nil

end



--------------------------------

sc_getdaydata=_sc_getdaydata

sc_getweekdata=_sc_getweekdata

sc_add=_sc_add

sc_reset_day=_sc_reset_day

sc_reset_week=_sc_reset_week

sc_reset_getawards=_sc_reset_getawards

active_getawards=_active_getawards

active_type = _active_type



