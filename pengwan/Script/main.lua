--[[
	*****Lua systems*****
	Game scripts using lua.
	Copyright(C) 2011 Pengwan.
]]--

local rfalse,DoFile,pairs = rfalse,DoFile,pairs

--[[
	__debug打开时目前用于:
	1: 错误提示类打印
	2: SendLuaMsg错误和长度大于300时记录日志
	3: 更新属性后,判断c++置位属性表成功否 
	
]]--

--__plat=101为360
__debug = true  
__plat 	= __plat or 0 

-- -- sreset前先进行一次对比
-- if TI_Snapshot and __debug then
-- 	TI_Snapshot()
-- end

--register dofile function.
function dofile(filename)
	local newstring = filename;
	local ret = DoFile(newstring)
	if (ret == nil) then
		rfalse(2,"error in DoFile!");
	end
	
	if(ret == 0) then
		--rfalse(2,"load "..newstring.." OK!")
	elseif(ret == 1) then
		rfalse(2,"load "..newstring..", Error run!")
	elseif(ret == 2) then
		rfalse(2,"load "..newstring..", Error lua file!")
	elseif(ret == 3) then
		rfalse(2,"load "..newstring..", Error syntax!" )
	elseif(ret == 4) then
		rfalse(2,"load "..newstring..", Error lua memory!")
	elseif(ret == 5) then
		rfalse(2,"load "..newstring..", Error user error error!")
	else
		rfalse(2,"load "..newstring.." don't known!!")
	end  
end

local ro = {
	__newindex = function(t,k,v) 
		look('read only:' .. tostring(k) '__'.. tostring(v),1) 
	end
}

local eq = {
	__assign = function(t,k,v)
		look('__assign:' .. tostring(k).. '__'.. tostring(v),1)
	end
}

local rw = {}

-- 只读表
function readonly(t)
	setmetatable(t,ro)
	return t
end
-- 读写表
function readwrite(t)
	rw[#rw+1] = t
	return t
end
-- 不能覆盖值
function noassign(t)
	setmetatable(t,eq)
	return t
end

function setplat(plat)
	__plat = plat or 0
end

local function module_reset()
	for _name,v in pairs(package.loaded) do
		package.loaded[_name] = nil
	end
end

module_reset()

--load all script files.
require('Script.common') --导入通用模块库

local common 			= require('Script.common.Log')
Log 				= common.Log ---全局,不要修改

local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond
__Ver	= GetTimeToSecond(2014,8,8,10,00,00) 

dofile("Core\\include.lua") --数据管理模块 
dofile("msgHandler\\include.lua") --消息处理者模块 待看 神树
require('Script.cext') --游戏通用功能扩展模块 待看 神树
dofile("TimesMgr\\include.lua") --次数管理器 待看 神树
dofile("world\\include.lua") --世界功能模块(世界数据接口和循环) 待看 神树
dofile("NPC\\include.lua") --NPC模块 待看
dofile("Monster\\Include.lua") --怪物模块 待看
dofile("Story\\init.lua") --故事剧情模块 待看
dofile("Task\\include.lua") --任务模块 待看
dofile("Region\\include.lua") --区域场景模块 待看
dofile("VIP\\include.lua") --VIP模块 待看
dofile("Player\\include.lua") --玩家模块 待看
dofile("store\\include.lua") --商店模块 待看
dofile("Item\\Include.lua") --项目模块 待看
dofile("Hero\\Include.lua") --英雄模块 待看
dofile("Trusteeship\\include.lua") --托管 挂机模块 待看
dofile("sctx\\include.lua") --降魔录系统模块 待看
dofile("CopyScene\\include.lua") --副本模块 待看
dofile("Faction\\include.lua") --帮派模块 待看
dofile("Mounts\\include.lua") --坐骑抽奖池模块 待看
require('Script.achieve') --成就活跃 待看
require("Script.active")		-- 活动模块 待看
dofile("ShenBing\\include.lua") -- 神兵 待看
dofile("yinyang\\include.lua") --阴阳珠 待看
dofile("Equip\\include.lua") --装备 待看
dofile("Manor\\include.lua") --庄园 待看
dofile("lottery\\include.lua") --幸运转盘等抽奖活动 待看
dofile("Marry\\include.lua") --结婚系统 待看
require('Script.new_guide') --设置临时坐骑等 待看
require("Script.card") --卡牌系统 待看
require('Script.scorelist') --得分系统 待看
require('Script.gmserver') --公告系统 待看
require('Script.ShenQi') --神器 待看
dofile("span_server\\include.lua") --跨服活动 待看
dofile("span_local\\include.lua") --跨服 待看
dofile("chatserver\\include.lua") --聊天功能处理 待看
dofile("yuanshen\\include.lua") --元神 待看
require("Script.wuzhuang") --武装 待看
require("Script.shenshu")   --经验神树 
require("Script.qizhenge")   --奇珍阁 待看
require("Script.fabao")     --本命法宝 待看
require("Script.bsmz")	--宝石迷阵 待看
dofile("snapshot.lua") --快照
dofile('gm_cmd.lua') --gm指令
dofile("check.lua") --检查
dofile("ServerStart.lua") --服务器开始
rfalse(2,"load main.lua OK!")