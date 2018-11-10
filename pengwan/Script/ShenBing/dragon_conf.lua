--[[
file:	dragon_conf.lua
desc:	龙脉系统 配置文件
author:	zhongsx
update:	2015-3-16
]]--

local rint = rint
local look = look

---------------
module(...)
-----------------
--[[
单次消耗	INT(当前等级+3)		
进度	固定10		
气血	INT(等级*100+等级^2)*48		
攻击	INT(等级*100+等级^2)*6		
防御	INT(等级*100+等级^2*0.8)*6		
属性攻击	INT(等级*100+等级^2*0.8)*6		
抗性类	INT(等级*100+等级^2*0.6)*6		
]]--


local CAT_MAX_HP	= 1		-- 血量上限
local CAT_S_ATC  	= 2		-- 职业攻击
local CAT_ATC  		= 3		-- 攻击
local CAT_DEF		= 4		-- 防御
local CAT_S_DEF1	= 10		-- 火系抗性
local CAT_S_DEF2	= 11		-- 冰系抗性
local CAT_S_DEF3	= 12		-- 木系抗性

conf = {
	[1] = 90, --maxlv
	[2] = 10, --多少等级分一阶
	[3] = 1601, --龙魂精魄 道具ID		
}

--每一个进度需要多少道具
each_item = function(lv)
	return (lv + 1 + 3)
end

--当前lv等级升到下一级总共需要多少进度
max_proc = function(lv)
	return 20
end

att_func = {
	--血量上限
	[CAT_MAX_HP] = function(lv)
		return rint((lv * 100 + lv ^ 2) * 48)
	end,
	--职业攻击
	[CAT_S_ATC] = function(lv)
		return rint( (lv * 100 + (lv ^ 2) * 0.8) *6)
	end,
	--攻击
	[CAT_ATC] = function(lv)
		return rint( (lv * 100 + lv ^ 2) * 6)
	end,
	--防御
	[CAT_DEF] = function(lv)
		return rint( (lv * 100 + (lv ^ 2) * 0.8) *6)	
	end,
	--火系抗性
	[CAT_S_DEF1] = function(lv)
		return rint( (lv * 100 + (lv ^ 2) * 0.6) *6)
	end,
	--冰系抗性
	[CAT_S_DEF2] = function(lv)
		return rint( (lv * 100 + (lv ^ 2) * 0.6) *6)
	end,
	--木系抗性
	[CAT_S_DEF3] = function(lv)
		return rint( (lv * 100 + (lv ^ 2) * 0.6) *6)
	end,
}