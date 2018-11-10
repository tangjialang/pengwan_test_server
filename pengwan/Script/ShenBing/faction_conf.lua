--[[
file:	Faction_Conf.lua
desc:	帮会神兵配置
author:	zhongsx
update:	2014-11-13
version: 1.0.0
]]--

local rint = rint
local look = look
module(...)

-- 次数 费用 进度下上限 
NumFeeProgress_Conf = { 
	[1] = {20, 6, 10},
	[2] = {30, 10, 15},
	[3] = {40, 11,	 16},
	[4] = {50, 12, 16},
	[5] =	{70, 14, 17},
	[6] = {90, 18, 22},
	[7] = {120, 20, 24},
	[8] = {150, 25, 30},
	[9] = {190, 27, 31},
	[10] = {230, 32, 38},
	[11] = {280, 35, 40},
	[12] = {330, 41,	 47},
	[13] = {390, 43, 48},
	[14] = {450, 50,56},
	[15] = {520, 57, 65}
}

--其它配置
Other_Conf = {
	--升级道具ID,  突破道具ID  单价
	items = {{1585, 2},  {1585, 2} },
	--限制帮会等级
	limit_faction_level = 7,
	--define from player_attribute.lua
	CAT_MAX_HP		= 1,		-- 血量上限
	CAT_S_DEF1	  	= 10,		-- 火系抗性
	CAT_S_DEF2	  	= 11,		-- 冰系抗性
	CAT_S_DEF3	  	= 12,		-- 木系抗性
	CAT_ICE_ATC  	= 2,		-- 职业攻击
	--tain type
	TAIN_TYPE_YB	= 1,		--使用元宝培育
	TAIN_TYPE_ITEM	= 2,   --使用道具培育

	break_exp = 1,
	--最大阶位20
	Max_Class_Level = 20,
	--神兵所能达到的最大等级
	Max_Level = 200,
}

--帮会神兵  气血, 攻击, 防御, 升阶进度, 突破几率,当前阶位最大/小等级 算法配置
Func_Conf = {}

--气血 hp
Func_Conf[Other_Conf.CAT_MAX_HP] = function (level)
	return rint((level * 200 + level ^ 2 ) * 8)
end
--属性攻击 atttack
Func_Conf[Other_Conf.CAT_ICE_ATC]	= function(level)
	return rint(level * 200 + level  ^ 2)
end
--属性防御
Func_Conf[Other_Conf.CAT_S_DEF1]  = function(level)
	return rint((level * 200 + level  ^ 2 ) *0.8)
end

Func_Conf[Other_Conf.CAT_S_DEF2] = Func_Conf[Other_Conf.CAT_S_DEF1]  
Func_Conf[Other_Conf.CAT_S_DEF3] = Func_Conf[Other_Conf.CAT_S_DEF1]  

--每级的进度
Func_Conf.progress = function(level)
	return rint( level * 10  + (level ^ 2 ) / 10 )
end
--单次培育需消耗道具数量
Func_Conf.get_train_cost = function (level)
	return 5
end
--单次消耗增加的进度
Func_Conf.get_train_proc = function(level)
	return 1
end
--单次突破增加的进度
Func_Conf.get_break_proc = function(level)
	return 1
end
--突破消耗的数量
--当前阶数
Func_Conf.get_break_cost = function(class)
	return rint(class * 2 + 2)
end


--成功基础几率, 突破次数
Func_Conf.get_probability = function(break_num)
	--break_num = (((break_num - 50) > 0) and (break_num - 50) ) or 0
	--local  base_prob = 50 + (rint(break_num / 5) * 10 )+ rint(break_num % 5)	
	return (((break_num - 50) * 2) and ((break_num - 50) * 2)) or 0
end	
--获取当前阶位下最大等级和最小等级
Func_Conf.get_maxmin_level = function(level)
	local tmp = Other_Conf.Max_Level / Other_Conf.Max_Class_Level 
	--local max_lv, min_lv = (rint(level % tmp) + 1) * tmp,  rint(level % tmp) * tmp
	local max_lv = (rint(level/tmp) + 1)*tmp
	local min_lv = (rint(level/tmp))*tmp
	
	--look("get_maxmin_level----"..level.."-----"..tmp.."----"..max_lv.."---"..min_lv)
	return max_lv, min_lv
end


	