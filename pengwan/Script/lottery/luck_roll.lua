--[[
file:	luck_roll.lua
desc:	幸运转盘
author:	JKQ
update:	2013-1-4
]]--


local Roll_begin  	=   msgh_s2c_def[29][14]
local Rool_res		=   msgh_s2c_def[29][15]

local msg_prize		=   msgh_s2c_def[29][20]
local msg_prize_pjj	=   msgh_s2c_def[29][28]
local msg_prize_zqj	=   msgh_s2c_def[29][29]
local msg_prize_gqj	=   msgh_s2c_def[29][30]
local msg_prize_sdj	=   msgh_s2c_def[29][32] --圣诞节
local SendLuaMsg	=	SendLuaMsg
local mathrandom = math.random
local GiveGoods	 = GiveGoods
local BroadcastRPC = BroadcastRPC
local ipairs = ipairs
local GetWorldCustomDB = GetWorldCustomDB
local _push = table.push
local CI_GetPlayerData = CI_GetPlayerData
local isFullNum = isFullNum
local TipCenter = TipCenter
local GetStringMsg = GetStringMsg
local look = look

--合服抽奖配置
local luck_rollgoodsconf ={
	[1] = {771,1,1,5000,0},--id, 数量，是否绑定,概率,贵重物品的标示
	[2] = {771,2,1,6000,0},
	[3] = {765,1,1,7500,0},
	[4] = {766,1,1,8000,0},
	[5] = {752,1,1,9000,0},
	[6] = {711,1,1,9200,0},
	[7] = {730,1,1,9500,0},
	[8] = {763,1,1,9800,0},
	[9] = {712,1,1,9850,1},
	[10] = {731,1,1,9900,1},
	[11] = {764,1,1,9950,1},
	[12] = {771,50,1,10000,1},
}

--1453 抽中50次，或者获得道具100个，就不再出了，改为出第一个道具
--春节活动配置 --id, 数量，是否绑定,概率,贵重物品的标示
local luck_rollgoodsconf_cj ={
	[50]={
		[1]={1474,1,1,5,1},
		[2]={803,20,1,10,1},
		[3]={763,1,1,11,1},
		[4]={778,2,1,1011,0},
		[5]={627,25,1,1511,0},
		[6]={1473,10,1,2011,0},
		[7]={1473,8,1,2811,0},
		[8]={1473,6,1,5311,0},
		[9]={1473,4,1,6311,0},
		[10]={691,5,1,8000,0},
		[11]={626,10,1,9500,0},
		[12]={636,5,1,10000,},


	},
	[60]={
		[1]={1474,1,1,5,1},
		[2]={763,1,1,6,1},
		[3]={627,25,1,506,0},
		[4]={778,2,1,1506,0},
		[5]={626,10,1,2300,0},
		[6]={803,25,1,2800,0},
		[7]={1473,10,1,3300,0},
		[8]={1473,8,1,4100,0},
		[9]={1473,6,1,6600,0},
		[10]={1473,4,1,7600,0},
		[11]={788,10,1,8600,0},
		[12]={803,10,1,10000,0},


	},
	[70]={
		[1]={1474,1,1,5,1},
		[2]={812,100,1,11,1},
		[3]={803,50,1,100,1},
		[4]={803,20,1,700,0},
		[5]={804,5,1,1700,0},
		[6]={788,2,1,2300,0},
		[7]={812,10,1,3300,0},
		[8]={812,5,1,5200,0},
		[9]={1473,10,1,5700,0},
		[10]={1473,8,1,6500,0},
		[11]={1473,6,1,9000,0},
		[12]={1473,4,1,10000,0},


	},
}

--普通运营活动配置
local luck_rollgoodsconf_common={
	[50]={
		--id, 数量，是否绑定,概率,贵重物品的标示
		[1]={812,3000,1,80,1},
        [2]={1520,2000,1,90,1},
        [3]={711,2,1,110,1},
        [4]={730,1,1,140,1},
        [5]={763,1,1,170,1},
        [6]={1520,1000,1,270,1},
        [7]={627,100,1,770,0},
        [8]={625,2,1,1770,0},
        [9]={821,20,1,2850,0},
        [10]={812,80,1,4710,0},
        [11]={788,20,1,6560,0},
        [12]={803,60,1,10060,0},		
	},
	[60]={
		--id, 数量，是否绑定,概率,贵重物品的标示
		[1]={812,3000,1,80,1},
        [2]={1520,2000,1,90,1},
        [3]={711,2,1,110,1},
        [4]={730,1,1,140,1},
        [5]={763,1,1,170,1},
        [6]={1520,1000,1,270,1},
        [7]={627,100,1,770,0},
        [8]={625,2,1,1770,0},
        [9]={821,20,1,2850,0},
        [10]={812,80,1,4710,0},
        [11]={788,20,1,6560,0},
        [12]={803,60,1,10060,0},
	},
	
	[70]={
		--id, 数量，是否绑定,概率,贵重物品的标示
		[1]={812,3000,1,80,1},
        [2]={1520,2000,1,90,1},
        [3]={711,2,1,110,1},
        [4]={730,1,1,140,1},
        [5]={763,1,1,170,1},
        [6]={1520,1000,1,270,1},
        [7]={627,100,1,770,0},
        [8]={625,2,1,1770,0},
        [9]={821,20,1,2850,0},
        [10]={812,80,1,4710,0},
        [11]={788,20,1,6560,0},
        [12]={803,60,1,10060,0},
	},

}
---需求道具
local needitem={
	[1]=777,---合服
	[2]=1450,--春节
	[3]=811,--平时
	[4]=1480,--端午
	[5]= 1519,--啤酒节
	[6]= 1565,--中秋节
	[7]= 1573,--国庆节
	[8]= 1594,--圣诞节 雪锤
}
--对应次数单价
local need_money={
	[1]={[1]=10,[10]=10},---合服
	[2]={[1]=10,[10]=9,[20]=9,[30]=9,},--春节
	[3]={[1]=50,[10]=50},---平时
	[4]={[1]=20,[10]=20},---端午
	[5]={[1]=20,[10]=20},---啤酒节
	[6]={[1]=20,[10]=20},---啤酒节
	[7]={[1]=20,[10]=20},---国庆节
	[8]={[1]=20,[10]=20},---圣诞节
}

--端午活动道具配置
local luck_rollgoodsconf_dw ={
	timestart = '2014/05/29 00:00:00',
	timeend = '2014/06/2 23:59:59',
	[1]={627,15,1,1500,0},
	[2]={626,15,1,3000,0},
	[3]={804,5,1,4500,0},
	[4]={803,20,1,6000,0},
	[5]={812,20,1,7700,0},
	[6]={802,2,1,8700,0},
	[7]={710,5,1,9200,1},
	[8]={796,3,1,9400,0},
	[9]={778,5,1,9900,0},
	[10]={763,1,1,9950,1},
	[11]={711,1,1,9980,1},
	[12]={730,1,1,10000,1},
}

--端午积分奖励
local gifts_dw = {
	{100,{{803,50,1}}}, -- {分数界限，{{道具id，道具数量，是否绑定}，{}，{}}}
	{200,{{803,100,1}}},
	{500,{{803,200,1},{802,3,1}}},
	{1000,{{812,300,1},{802,10,1},{804,20,1}}},
	{3000,{{812,600,1},{802,40,1},{804,60,1}}},
	{5000,{{812,800,1},{802,50,1},{804,100,1},{2603,1,1}}},
}


local luck_rollgoodsconf_pjj ={
	timestart = '2014/09/05 00:00:00',
	timeend = '2014/09/08 23:59:59',
	
	[50] = {
		[1]={626,15,1,2300,0},
		[2]={627,15,1,4800,0},
		[3]={803,15,1,7300,0},
		[4]={691,5,1,7800,0},
		[5]={778,3,1,8700,0},
		[6]={802,3,1,9200,0},
		[7]={796,3,1,9500,1},
		[8]={752,1,1,9700,0},
		[9]={710,3,1,9950,0},
		[10]={763,1,1,9980,1},
		[11]={711,1,1,9990,1},
		[12]={730,1,1,10000,1},
	},
		
	[60] = {
		[1]={626,15,1,2500,0},
		[2]={627,15,1,5000,0},
		[3]={803,15,1,7500,0},
		[4]={788,10,1,8000,0},
		[5]={778,3,1,8500,0},
		[6]={802,3,1,9000,0},
		[7]={796,3,1,9400,1},
		[8]={752,1,1,9700,0},
		[9]={710,3,1,9950,0},
		[10]={763,1,1,9980,1},
		[11]={711,1,1,9990,1},
		[12]={730,1,1,10000,1},
	},
	
	[70] = {
		[1]={812,15,1,2000,0},
		[2]={1520,30,1,4500,0},
		[3]={803,15,1,6500,0},
		[4]={788,10,1,7000,0},
		[5]={821,10,1,8500,0},
		[6]={1520,200,1,8800,0},
		[7]={821,15,1,9300,1},
		[8]={802,3,1,9600,0},
		[9]={796,3,1,9950,0},
		[10]={763,1,1,9980,1},
		[11]={711,1,1,9990,1},
		[12]={730,1,1,10000,1},
	},
		
}

local gifts_pjj = {
 [50] = {
	{100,{{803,50,1}}}, -- {分数界限，{{道具id，道具数量，是否绑定}，{}，{}}}
	{200,{{803,100,1}}},
	{500,{{803,200,1},{802,3,1}}},
	{1000,{{803,300,1},{802,10,1},{796,6,1}}},
	{3000,{{803,600,1},{802,40,1},{796,20,1}}},
	{5000,{{803,800,1},{802,50,1},{796,30,1},{2709,1,1}}},
	},
 [60] = {
	{100,{{803,50,1}}}, -- {分数界限，{{道具id，道具数量，是否绑定}，{}，{}}}
	{200,{{803,100,1}}},
	{500,{{803,200,1},{802,3,1}}},
	{1000,{{803,300,1},{802,10,1},{796,6,1}}},
	{3000,{{803,600,1},{802,40,1},{796,20,1}}},
	{5000,{{803,800,1},{802,50,1},{796,30,1},{2709,1,1}}},
	},
 [70] = {
	{100,{{821,20,1}}}, -- {分数界限，{{道具id，道具数量，是否绑定}，{}，{}}}
	{200,{{821,40,1}}},
	{500,{{821,60,1},{812,100,1}}},
	{1000,{{821,120,1},{812,120,1},{1520,300,1}}},
	{3000,{{821,240,1},{812,300,1},{1520,1200,1}}},
	{5000,{{821,320,1},{812,450,1},{1520,1500,1},{2709,1,1}}},
	},
}	

-----------------------------------------------
-----------------------------------------------
local luck_rollgoodsconf_zqj ={
	timestart = '2014/09/05 00:00:00',
	timeend = '2014/09/08 23:59:59',
	
	[50] = {
		[1]={626,15,1,2300,0},
		[2]={627,15,1,4800,0},
		[3]={803,15,1,7300,0},
		[4]={691,5,1,7800,0},
		[5]={778,3,1,8700,0},
		[6]={802,3,1,9200,0},
		[7]={796,3,1,9500,1},
		[8]={752,1,1,9700,0},
		[9]={710,3,1,9950,0},
		[10]={763,1,1,9980,1},
		[11]={711,1,1,9990,1},
		[12]={730,1,1,10000,1},
	},
		
	[60] = {
		[1]={626,15,1,2500,0},
		[2]={627,15,1,5000,0},
		[3]={803,15,1,7500,0},
		[4]={788,10,1,8000,0},
		[5]={778,3,1,8500,0},
		[6]={802,3,1,9000,0},
		[7]={796,3,1,9400,1},
		[8]={752,1,1,9700,0},
		[9]={710,3,1,9950,0},
		[10]={763,1,1,9980,1},
		[11]={711,1,1,9990,1},
		[12]={730,1,1,10000,1},
	},
	
	[70] = {
		[1]={812,15,1,2000,0},
		[2]={1520,30,1,4500,0},
		[3]={803,15,1,6500,0},
		[4]={788,10,1,7000,0},
		[5]={821,10,1,8500,0},
		[6]={1520,200,1,8800,0},
		[7]={821,15,1,9300,1},
		[8]={802,3,1,9600,0},
		[9]={796,3,1,9950,0},
		[10]={763,1,1,9980,1},
		[11]={711,1,1,9990,1},
		[12]={730,1,1,10000,1},
	},
}

local gifts_zqj = {
 [50] = {
	{100,{{803,50,1}}}, -- {分数界限，{{道具id，道具数量，是否绑定}，{}，{}}}
	{200,{{803,100,1}}},
	{500,{{803,200,1},{802,3,1}}},
	{1000,{{803,300,1},{802,10,1},{796,6,1}}},
	{3000,{{803,600,1},{802,40,1},{796,20,1}}},
	{5000,{{803,800,1},{802,50,1},{796,30,1},{2709,1,1}}},
	},
 [60] = {
	{100,{{803,50,1}}}, -- {分数界限，{{道具id，道具数量，是否绑定}，{}，{}}}
	{200,{{803,100,1}}},
	{500,{{803,200,1},{802,3,1}}},
	{1000,{{803,300,1},{802,10,1},{796,6,1}}},
	{3000,{{803,600,1},{802,40,1},{796,20,1}}},
	{5000,{{803,800,1},{802,50,1},{796,30,1},{2709,1,1}}},
	},
 [70] = {
	{100,{{821,20,1}}}, -- {分数界限，{{道具id，道具数量，是否绑定}，{}，{}}}
	{200,{{821,40,1}}},
	{500,{{821,60,1},{812,100,1}}},
	{1000,{{821,120,1},{812,120,1},{1520,300,1}}},
	{3000,{{821,240,1},{812,300,1},{1520,1200,1}}},
	{5000,{{821,320,1},{812,450,1},{1520,1500,1},{2709,1,1}}},
	},
}	
-----------------------------------------------
-----------------------------------------------
local luck_rollgoodsconf_gqj ={
	timestart = '2014/09/30 00:00:00',
	timeend = '2014/10/07 23:59:59',
	
	[50] = {
		[1]={626,15,1,2300,0},
		[2]={627,15,1,4800,0},
		[3]={803,15,1,7300,0},
		[4]={691,5,1,7800,0},
		[5]={778,3,1,8700,0},
		[6]={802,3,1,9200,0},
		[7]={796,3,1,9500,1},
		[8]={752,1,1,9700,0},
		[9]={710,3,1,9950,0},
		[10]={763,1,1,9980,1},
		[11]={711,1,1,9990,1},
		[12]={730,1,1,10000,1},
	},
		
	[60] = {
		[1]={626,15,1,2500,0},
		[2]={627,15,1,5000,0},
		[3]={803,15,1,7500,0},
		[4]={788,10,1,8000,0},
		[5]={778,3,1,8500,0},
		[6]={802,3,1,9000,0},
		[7]={796,3,1,9400,1},
		[8]={752,1,1,9700,0},
		[9]={710,3,1,9950,0},
		[10]={763,1,1,9980,1},
		[11]={711,1,1,9990,1},
		[12]={730,1,1,10000,1},
	},
	
	[70] = {
		[1]={812,15,1,2000,0},
		[2]={1520,30,1,4500,0},
		[3]={803,15,1,6500,0},
		[4]={788,10,1,7000,0},
		[5]={821,10,1,8500,0},
		[6]={1520,200,1,8800,0},
		[7]={821,15,1,9300,1},
		[8]={802,3,1,9600,0},
		[9]={796,3,1,9950,0},
		[10]={763,1,1,9980,1},
		[11]={711,1,1,9990,1},
		[12]={730,1,1,10000,1},
	},
}

local gifts_gqj = {
 [50] = {
	{100,{{803,50,1}}}, -- {分数界限，{{道具id，道具数量，是否绑定}，{}，{}}}
	{200,{{803,100,1}}},
	{500,{{803,200,1},{802,3,1}}},
	{1000,{{803,300,1},{802,10,1},{796,6,1}}},
	{3000,{{803,600,1},{802,40,1},{796,20,1}}},
	{5000,{{803,800,1},{802,50,1},{796,30,1},{2806,1,1}}},
	},
 [60] = {
	{100,{{803,50,1}}}, -- {分数界限，{{道具id，道具数量，是否绑定}，{}，{}}}
	{200,{{803,100,1}}},
	{500,{{803,200,1},{802,3,1}}},
	{1000,{{803,300,1},{802,10,1},{796,6,1}}},
	{3000,{{803,600,1},{802,40,1},{796,20,1}}},
	{5000,{{803,800,1},{802,50,1},{796,30,1},{2806,1,1}}},
	},
 [70] = {
	{100,{{821,20,1}}}, -- {分数界限，{{道具id，道具数量，是否绑定}，{}，{}}}
	{200,{{821,40,1}}},
	{500,{{821,60,1},{812,100,1}}},
	{1000,{{821,120,1},{812,120,1},{1520,300,1}}},
	{3000,{{821,240,1},{812,300,1},{1520,1200,1}}},
	{5000,{{821,320,1},{812,450,1},{1520,1500,1},{2806,1,1}}},
	},
}	

--圣诞节
local luck_rollgoodsconf_sdj ={
	timestart = '2014/12/24 00:00:00',
	timeend = '2014/12/26 23:59:59',
	
	[50] = {
		[1]={626,15,1,2300,0},
		[2]={627,15,1,4800,0},
		[3]={803,15,1,7300,0},
		[4]={691,5,1,7800,0},
		[5]={778,3,1,8700,0},
		[6]={802,3,1,9200,0},
		[7]={796,3,1,9500,0},
		[8]={752,1,1,9700,0},
		[9]={710,3,1,9950,0},
		[10]={763,1,1,9980,1},
		[11]={711,1,1,9990,1},
		[12]={730,1,1,10000,1},
	},
		
	[60] = {
		[1]={626,15,1,2500,0},
		[2]={627,15,1,5000,0},
		[3]={803,15,1,7500,0},
		[4]={788,10,1,8000,0},
		[5]={778,3,1,8500,0},
		[6]={802,3,1,9000,0},
		[7]={796,5,1,9400,0},
		[8]={752,1,1,9700,0},
		[9]={710,3,1,9950,0},
		[10]={763,1,1,9980,1},
		[11]={711,1,1,9990,1},
		[12]={730,1,1,10000,1},
	},
	
	[70] = {
		[1]={812,15,1,2000,0},
		[2]={1520,30,1,4500,0},
		[3]={803,15,1,6500,0},
		[4]={788,10,1,7000,0},
		[5]={821,10,1,8500,0},
		[6]={1520,200,1,8800,0},
		[7]={821,15,1,9300,0},
		[8]={802,3,1,9600,0},
		[9]={796,5,1,9950,0},
		[10]={763,1,1,9980,1},
		[11]={711,1,1,9990,1},
		[12]={730,1,1,10000,1},
	},
}

local gifts_sdj = {
  [50] = {
	{100,{{803,50,1}}}, -- {分数界限，{{道具id，道具数量，是否绑定}，{}，{}}}
	{200,{{803,100,1}}},
	{500,{{803,200,1},{802,3,1}}},
	{1000,{{803,300,1},{802,10,1},{796,6,1}}},
	{3000,{{803,600,1},{802,40,1},{796,20,1}}},
	{5000,{{803,2000,1},{802,50,1},{796,50,1},{712,1,1}}},
	},
 [60] = {
	{100,{{803,50,1}}}, -- {分数界限，{{道具id，道具数量，是否绑定}，{}，{}}}
	{200,{{803,100,1}}},
	{500,{{803,200,1},{802,3,1}}},
	{1000,{{803,300,1},{802,10,1},{796,6,1}}},
	{3000,{{803,600,1},{802,40,1},{796,20,1}}},
	{5000,{{803,2000,1},{802,50,1},{796,100,1},{712,1,1}}},
	},
 [70] = {
	{100,{{812,50,1}}}, -- {分数界限，{{道具id，道具数量，是否绑定}，{}，{}}}
	{200,{{812,100,1}}},
	{500,{{812,200,1},{821,100,1}}},
	{1000,{{812,500,1},{821,200,1},{1520,1000,1}}},
	{3000,{{812,1000,1},{821,500,1},{1520,3000,1}}},
	{5000,{{821,3000,1},{712,1,1},{1520,5000,1},{1593,2,1}}},
	},
}	
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
local function luckroll_getplayerdata(playerid)
	local pdata = GI_GetPlayerData(playerid,'dwhd',30)
		--[[
			score=1--端午积分
			lv=1 --端午积分奖励领取档次
		]]
	return pdata
end

local function luckroll_getplayerdata_pjj(playerid)
	local pdata = GI_GetPlayerData(playerid,'pjj',30)
		--[[
			[1]=1--啤酒节积分
			[2]=1--啤酒节积分奖励领取档次
		]]
	return pdata
end

local function luckroll_getplayerdata_zqj(playerid)
	local pdata = GI_GetPlayerData(playerid,'zqj',30)
		--[[
			[1]=1--中秋节积分
			[2]=1--中秋节积分奖励领取档次
		]]
	return pdata
end

local function luckroll_getplayerdata_gqj(playerid)
	local pdata = GI_GetPlayerData(playerid,'gqj',30)
		--[[
			[1]=1--国庆节积分
			[2]=1--国庆节积分奖励领取档次
		]]
	return pdata
end

local function luckroll_getplayerdata_sdj(playerid)
	local pdata = GI_GetPlayerData(playerid,'sdj',30)
		--[[
			[1]=1--圣诞节积分
			[2]=1--圣诞节积分奖励领取档次
		]]
	return pdata
end
-- 获得幸运转盘世界数据
local function Get_luckroll_worldData()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then
		return
	end
	--look('获取')
	if w_customdata.luck_roll == nil then
		w_customdata.luck_roll = {}
	end
	return w_customdata.luck_roll
end
-- 获得幸运转盘世界数据--平时
local function Get_luckroll_worldData3()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then
		return
	end
	
	if w_customdata.luck_roll3 == nil then
		w_customdata.luck_roll3 = {}
	end
	--look('获取')
	return w_customdata.luck_roll3
end
-- 获得幸运转盘世界数据--端午
local function Get_luckroll_worldData4()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then
		return
	end
	
	if w_customdata.luck_roll4 == nil then
		w_customdata.luck_roll4 = {}
	end
	--look('获取')
	return w_customdata.luck_roll4
end

local function Get_luckroll_worldData5()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then
		return
	end
	
	if w_customdata.luck_roll5== nil then
		w_customdata.luck_roll5 = {}
	end
	--look('获取')
	return w_customdata.luck_roll5
end

local function Get_luckroll_worldData6()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then
		return
	end
	
	if w_customdata.luck_roll6== nil then
		w_customdata.luck_roll6 = {}
	end
	--look('获取')
	return w_customdata.luck_roll6
end
--更新幸运转盘世界数据
local function Addawad_luckroll(name,goodsid,count,itype)
	if itype ==3 then
		local luckroll_data=Get_luckroll_worldData3()
		if luckroll_data == nil then
			return
		end
		_push(luckroll_data, {goodsid,name,count}, 10)
	elseif itype ==4 then
		local luckroll_data=Get_luckroll_worldData4()
		if luckroll_data == nil then
			return
		end
		_push(luckroll_data, {goodsid,name,count}, 10)
	elseif itype ==5 then
		local luckroll_data=Get_luckroll_worldData5()
		if luckroll_data == nil then
			return
		end
		_push(luckroll_data, {goodsid,name,count}, 10)
	else
		local luckroll_data=Get_luckroll_worldData()
		if luckroll_data == nil then
			return
		end
		_push(luckroll_data, {goodsid,name,count}, 10)
	end
end

local function _Roll_start(itype)        --结果初始化
	-- look('结果初始化',1)
	local luckroll_data
	if itype and itype==3 then 
		luckroll_data=Get_luckroll_worldData3()
	elseif itype==4 then
		luckroll_data=Get_luckroll_worldData4()
	elseif itype==5 then
		luckroll_data=Get_luckroll_worldData5()
	elseif itype==6 then
		luckroll_data=Get_luckroll_worldData6()
	else
		luckroll_data=Get_luckroll_worldData()
	end

	if luckroll_data == nil then
		return 
	end
	-- look(itype,1)
	SendLuaMsg(0,{ids=Roll_begin,enddata=luckroll_data,itype=itype},9)
end

--活动设置是否进行 --0结束,1合服 2为新春配置表,3平时
local function _Setluck_roll_mark(iType)
	-- look('活动设置是否进行',1)
	-- look(iType,1)
	local luckroll_data
	if iType==3 then
	 	luckroll_data=Get_luckroll_worldData3()
	 	-- look(123,1)
	else
		luckroll_data=Get_luckroll_worldData()
		-- look(456,1)
	end
	 
	if iType==0 then --结束清数据
		local w_customdata = GetWorldCustomDB()
		if w_customdata == nil then
			return
		end
		w_customdata.luck_roll = {}
	end
	luckroll_data.mark = iType
	local luckroll_data=Get_luckroll_worldData3()
	-- look(luckroll_data,1)
end

--itype=1合服,2春节,3平时，4端午
local function _luck_rolling(playerid,times,itype,buy) -- 开始抽奖

	if IsSpanServer() then return end
	-- look('开始抽奖'..tostring(itype),2)	
	-- look(times,1)
	-- look(itype,1)
	-- look(buy,1)
	
	local luckroll_data
	 -- look(luckroll_data,1)
	 if itype==3 then
	 	luckroll_data=Get_luckroll_worldData3()
	elseif itype==4 then
	 	luckroll_data=Get_luckroll_worldData4()
	 else
	 	luckroll_data=Get_luckroll_worldData()
	 end
	 -- look(luckroll_data,1)
	 local mark=(luckroll_data.mark or 0)
	 --look('mark = '..mark,1)
	 -- if mark == 0 and itype ~= 4 then--判断活动是否是正确的时间进行
		--  return
	 -- end
	if times == nil then 
		return 
	end
	local id,needmoney,goodsconf
	if itype==1 then
		-- if mark~=1 then return end
		id=needitem[1]
		needmoney=need_money[1][times]
		goodsconf=luck_rollgoodsconf
	elseif itype==2 then
		-- if mark~=2 then return end
		id=needitem[2]
		needmoney=need_money[2][times]
		--goodsconf=luck_rollgoodsconf_cj
		local worldlv=rint(GetWorldLevel()/10)*10
		if worldlv<50 then
			worldlv=50
		end
		if  luck_rollgoodsconf_cj[worldlv]==nil then
			worldlv=70
		end
		goodsconf=luck_rollgoodsconf_cj[worldlv]
	elseif itype==3 then--平时开的活动,与世界等级有关
		-- if mark~=3 then return end
		id=needitem[3]
		needmoney=need_money[3][times]
		--look('开始抽奖',2)
		local worldlv=rint(GetWorldLevel()/10)*10
		if worldlv<50 then
			worldlv=50
		end
		if  luck_rollgoodsconf_common[worldlv]==nil then
			worldlv=70
		end
		goodsconf=luck_rollgoodsconf_common[worldlv]
		
	elseif itype==4 then--端午活动，不判断条件
		--look("dw slot",2)
		id=needitem[4]
		needmoney=need_money[4][times]
		goodsconf=luck_rollgoodsconf_dw
	elseif itype==5 then
		look("pjj slot",2)
		id=needitem[5]
		needmoney=need_money[5][times]
	
		local worldlv=rint(GetWorldLevel()/10)*10
		if worldlv<50 then
			worldlv=50
		end
		if  luck_rollgoodsconf_pjj[worldlv]==nil then
			worldlv=70
		end
		goodsconf=luck_rollgoodsconf_pjj[worldlv]
	elseif itype==6 then
		look("zqj slot",2)
		id=needitem[6]
		needmoney=need_money[6][times]
	
		local worldlv=rint(GetWorldLevel()/10)*10
		if worldlv<50 then
			worldlv=50
		end
		if  luck_rollgoodsconf_zqj[worldlv]==nil then
			worldlv=70
		end
		goodsconf=luck_rollgoodsconf_zqj[worldlv]
	elseif itype==7 then
		look("gqj slot",2)
		id=needitem[7]
		needmoney=need_money[7][times]
	
		local worldlv=rint(GetWorldLevel()/10)*10
		if worldlv<50 then
			worldlv=50
		end
		if  luck_rollgoodsconf_gqj[worldlv]==nil then
			worldlv=70
		end
		goodsconf=luck_rollgoodsconf_gqj[worldlv]
	elseif itype==8 then
		--look("sqj slot",2)
		id=needitem[8]
		needmoney=need_money[8][times]
	
		local worldlv=rint(GetWorldLevel()/10)*10
		if worldlv<50 then
			worldlv=50
		end
		if  luck_rollgoodsconf_sdj[worldlv]==nil then
			worldlv=70
		end
		goodsconf=luck_rollgoodsconf_sdj[worldlv]
	else
		return
	end
	local name
	local goodsid
	local finaldata={}
	local flag = 0
	if buy==nil then 
		buy=0 
	end
	--look(times,1)
	for i =1,times do
		local pakagenum = isFullNum()  --判断背包空间
		if 1 > pakagenum  then 
			TipCenter(GetStringMsg(14,1))
			break
		end

		if buy==0 then 
			if 0 == CheckGoods(id,1,0,playerid,'幸运转盘')  then 
				break
			end
		elseif buy==1 then 
			if not id or 0 == CheckGoods(id,1,0,playerid,'幸运转盘')  then 
				if not (CheckCost(playerid, needmoney,0,1,'幸运转盘')) then 
					break
				end
			end	
		else
			break
		end

		local Rand = mathrandom(10000)
		for j,k in ipairs(goodsconf) do
			if Rand <= k[4] then
				goodsid = k[1]
				if goodsid == 1453 then
					local  nownum=item_getnumactive( playerid ,4)+1
					 look('nownum=='..nownum,1)
					if nownum<=50 then 
						item_addnumactive( playerid ,4)
					else
						goodsid=goodsconf[1][1]
						k=goodsconf[1]
						j=1
					end
				end
				GiveGoods(goodsid,k[2],k[3],'幸运转盘')
				if k[5] == 1 then							--判断是否是贵重物品
					name = CI_GetPlayerData(3)				--获取玩家姓名
					local count = k[2]						--物品数量
					Addawad_luckroll(name,goodsid,count,itype)	--更新数据
					BroadcastRPC('luck_roll',goodsid,name,count,itype)  --全服广播
				end
				local inx = j   --传索引
				finaldata[inx] = k[2] + (finaldata[inx] or 0)
				break
			end
		end
		flag = flag + 1   --标记实际抽奖的次数
	end	
	
	if 	flag >0	then
		if itype == 4 then
			local pdata =luckroll_getplayerdata(playerid)
			pdata.score = (pdata.score or 0) + flag * 2
			SendLuaMsg(0,{ids=Rool_res,finaldata,itype=itype,score = pdata.score},9)--端午返回消息					
		elseif itype == 5 then
			local pdata =luckroll_getplayerdata_pjj(playerid)
			pdata[1] = (pdata[1] or 0) + flag * 2
			SendLuaMsg(0,{ids=Rool_res,finaldata,itype=itype,score = pdata[1]},9)				
		elseif itype == 6 then
			look('毛燕飞要的消息',2)
			local pdata =luckroll_getplayerdata_zqj(playerid)
			pdata[1] = (pdata[1] or 0) + flag * 2
			SendLuaMsg(0,{ids=Rool_res,finaldata,itype=itype,score = pdata[1]},9)
		elseif itype == 7 then
			look('毛燕飞要的消息7',2)
			local pdata =luckroll_getplayerdata_gqj(playerid)
			pdata[1] = (pdata[1] or 0) + flag * 2
			SendLuaMsg(0,{ids=Rool_res,finaldata,itype=itype,score = pdata[1]},9)	
		elseif itype == 8 then
			look('毛燕飞要的消息',2)
			local pdata =luckroll_getplayerdata_sdj(playerid)
			pdata[1] = (pdata[1] or 0) + flag * 2
			SendLuaMsg(0,{ids=Rool_res,finaldata,itype=itype,score = pdata[1]},9)			
		else
			SendLuaMsg(0,{ids=Rool_res,finaldata,itype=itype},9)--返回消息
							
							
		end
		--if itype==2 then
		--	UpdateChunJieData(playerid,1,flag)
		--end
	end
end

--端午积分领奖
function dw_get_prize(playerid,level)
	if IsSpanServer() then return end
	
	local pdata =luckroll_getplayerdata(playerid)
	local awards = gifts_dw[level]
	
	if not awards then
		SendLuaMsg(0,{ids=msg_prize,err = 0},9)---参数错误
		return 
	end
	
	pdata.score = pdata.score or 0
	if pdata.score < awards[1] then
		SendLuaMsg(0,{ids=msg_prize,err = 2},9)--分数未达到
		return
	end

	if isFullNum() < #awards[2] then
		TipCenter(GetStringMsg(14,#awards[2]))
		return
	end	
				
	pdata.lv = pdata.lv or 0
	if level == pdata.lv + 1 then
		pdata.lv = level
		GiveGoodsBatch(awards[2],"端午积分领奖")
		SendLuaMsg(0,{ids=msg_prize,level=level},9)--返回消息
	else
		SendLuaMsg(0,{ids=msg_prize,err = 1},9)--返回消息
	end
end

--啤酒节积分领奖
function pjj_get_prize(playerid,level)
	if IsSpanServer() then return end
	
	local pdata =luckroll_getplayerdata_pjj(playerid)
	
	local worldlv=rint(GetWorldLevel()/10)*10
	if worldlv<50 then
		worldlv=50
	end
	if luck_rollgoodsconf_pjj[worldlv]==nil then
		worldlv=70
	end
	
	local awards = gifts_pjj[worldlv][level]
	

	if not awards then
		SendLuaMsg(0,{ids=msg_prize_pjj,err = 0},9)---参数错误
		return 
	end
	
	pdata[1] = pdata[1] or 0
	if pdata[1] < awards[1] then
		SendLuaMsg(0,{ids=msg_prize_pjj,err = 2},9)--分数未达到
		return
	end

	if isFullNum() < #awards[2] then
		TipCenter(GetStringMsg(14,#awards[2]))
		return
	end	
	
	pdata[2] = pdata[2] or 0
	if level == pdata[2] + 1 then
		pdata[2] = level
		GiveGoodsBatch(awards[2],"啤酒节积分领奖")
		SendLuaMsg(0,{ids=msg_prize_pjj,level=level},9)--返回消息
	else
		SendLuaMsg(0,{ids=msg_prize_pjj,err = 1},9)--返回消息
	end
end

--中秋节积分领奖
function zqj_get_prize(playerid,level)
	if IsSpanServer() then return end
	local pdata =luckroll_getplayerdata_zqj(playerid)
	local worldlv=rint(GetWorldLevel()/10)*10
	if worldlv<50 then worldlv=50 end
	if luck_rollgoodsconf_zqj[worldlv]==nil then worldlv=70 end
	local awards = gifts_zqj[worldlv][level]
	if not awards then
		SendLuaMsg(0,{ids=msg_prize_zqj,err = 0},9)---参数错误
		return 
	end
	pdata[1] = pdata[1] or 0
	if pdata[1] < awards[1] then
		SendLuaMsg(0,{ids=msg_prize_zqj,err = 2},9)--分数未达到
		return
	end

	if isFullNum() < #awards[2] then
		TipCenter(GetStringMsg(14,#awards[2]))
		return
	end	

	pdata[2] = pdata[2] or 0
	if level == pdata[2] + 1 then
		pdata[2] = level
		
		look('zqj_get_prize',2)

		GiveGoodsBatch(awards[2],"中秋节积分领奖")
		SendLuaMsg(0,{ids=msg_prize_zqj,level=level},9)--返回消息
	else
		SendLuaMsg(0,{ids=msg_prize_zqj,err = 1},9)--返回消息
	end
end

--中秋节积分领奖
function gqj_get_prize(playerid,level)
	if IsSpanServer() then return end
	local pdata =luckroll_getplayerdata_gqj(playerid)
	local worldlv=rint(GetWorldLevel()/10)*10
	if worldlv<50 then worldlv=50 end
	if luck_rollgoodsconf_gqj[worldlv]==nil then worldlv=70 end
	local awards = gifts_gqj[worldlv][level]
	if not awards then
		SendLuaMsg(0,{ids=msg_prize_gqj,err = 0},9)---参数错误
		return 
	end
	pdata[1] = pdata[1] or 0
	if pdata[1] < awards[1] then
		SendLuaMsg(0,{ids=msg_prize_gqj,err = 2},9)--分数未达到
		return
	end

	if isFullNum() < #awards[2] then
		TipCenter(GetStringMsg(14,#awards[2]))
		return
	end	

	pdata[2] = pdata[2] or 0
	if level == pdata[2] + 1 then
		pdata[2] = level
		
		look('zqj_get_prize',2)

		GiveGoodsBatch(awards[2],"中秋节积分领奖")
		SendLuaMsg(0,{ids=msg_prize_gqj,level=level},9)--返回消息
	else
		SendLuaMsg(0,{ids=msg_prize_gqj,err = 1},9)--返回消息
	end
end

--圣诞节积分领奖
function sdj_get_prize(playerid,level)
	if IsSpanServer() then return end
	local pdata =luckroll_getplayerdata_sdj(playerid)
	local worldlv=rint(GetWorldLevel()/10)*10
	if worldlv<50 then worldlv=50 end
	if luck_rollgoodsconf_sdj[worldlv]==nil then worldlv=70 end
	local awards = gifts_sdj[worldlv][level]
	if not awards then
		SendLuaMsg(0,{ids=msg_prize_sdj,err = 0},9)---参数错误
		return 
	end
	pdata[1] = pdata[1] or 0
	if pdata[1] < awards[1] then
		SendLuaMsg(0,{ids=msg_prize_sdj,err = 2},9)--分数未达到
		return
	end

	if isFullNum() < #awards[2] then
		TipCenter(GetStringMsg(14,#awards[2]))
		return
	end	

	pdata[2] = pdata[2] or 0
	if level == pdata[2] + 1 then
		pdata[2] = level
		
		--look('sdj_get_prize',2)

		GiveGoodsBatch(awards[2],"圣诞节积分领奖")
		SendLuaMsg(0,{ids=msg_prize_sdj,level=level},9)--返回消息
	else
		SendLuaMsg(0,{ids=msg_prize_sdj,err = 1},9)--返回消息
	end
end

--------------------------interface--------------------
Roll_start   = _Roll_start
luck_rolling = _luck_rolling
Setluck_roll_mark=_Setluck_roll_mark