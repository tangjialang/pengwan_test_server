--[[
file:	Monster_Event.lua
desc:	Monster events.
author:	chal
update:	2011-12-05
notes:
[1] monster be killed event	: OnMonsterKill
[2] monster dead event		: OnMonsterDead

-- 目的：事件触发时刻配置
--
-- 配置说明：
-- Type 字段：		事件类型名，目前支持的有 { HPNum, HPRate, AttackCount, BuffBegin, BuffEnd, }
-- ID 字段：		事件 ID 号
-- Fun：			事件回调方法名
-- TriggerCount：	事件触发次数，即事件回调方法调用次数
-- 参数项：			Rate：血量比例 / Value：血量 / AttackCount：攻击次数 / OP：0--小于 1--等于 2--大于 / BuffID： Buff 编号
-- 
-- 配置实例：
-- {
--		{ Type = "HPNum", ID = 1, Fun = "Fuck", Value = 100, OP = 0, },
--		{ Type = "HPRate", ID = 1, Fun = "HPRateCallback", TriggerCount = 1, Rate = 0.95, OP = 0, },
--		{ Type = "AttackCount", ID = 2, Fun = "AttackCountCallback", TriggerCount = 100, AttackCount = 3, OP = 2, },
--		{ Type = "BuffEnd", ID = 2, Fun = "BuffIsFucked", BuffID = 1, },
--		{ Type = "BuffBegin", ID = 3, Fun = "BuffIsComing", BuffID = 1, },
--	}


Type ：	event type name: { HPNum, HPRate, AttackCount, BuffBegin, BuffEnd, }.
ID	：	event ID.
Fun	：	callback function name.
TriggerCount：	callback times.
Rate：hp percent / Value：hp / AttackCount / OP：0--'<' 1--'=' 2--'>' / BuffID
e.g.:
{
	{ Type = "HPNum", ID = 1, Fun = "", Value = 100, OP = 0, },
	{ Type = "HPRate", ID = 1, Fun = "", TriggerCount = 1, Rate = 0.95, OP = 0, },
	{ Type = "AttackCount", ID = 2, Fun = "", TriggerCount = 100, AttackCount = 3, OP = 2, },
	{ Type = "BuffEnd", ID = 2, Fun = "", BuffID = 1, },
	{ Type = "BuffBegin", ID = 3, Fun = "", BuffID = 1, },
}

]]--
--------------------------------------------------------------------------
--include:

local look,pairs = look,pairs
local CI_AddMonsterHPEvent = CI_AddMonsterHPEvent
local GetMonsterData = GetMonsterData
local CI_UpdateMonsterData = CI_UpdateMonsterData
local rint = rint
local CI_AddMonsterAttackCountEvent = CI_AddMonsterAttackCountEvent
local CI_AddMonsterBuffEndEvent = CI_AddMonsterBuffEndEvent
local CI_AddMonsterBuffBeginEvent = CI_AddMonsterBuffBeginEvent

--------------------------------------------------------------------------
--inner:

local _MonsterEvents =
{
	--BOSS
	--百树鬼妖
	[1001] = 
	{
		{ Type = "HPRate", ID = 1, Fun = "OnMonsterTrigger", TriggerCount = 3, Rate = 0.5, OP = 0, },
	},
	--龙宫夺宝
	[1002] = 
	{
		{ Type = "HPRate", ID = 2, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.5, OP = 0, },
	},
	--东海逍遥阁
	[1003] = 
	{
		{ Type = "AttackCount", ID = 3, Fun = "OnMonsterTrigger", TriggerCount = 10, AttackCount = 3, OP = 2, },
	},
	--水晶龙宫 乾元后山 深渊洞穴 熔岩迷窟 九尾雉鸡精
	[1004] = 
	{
		{ Type = "HPRate", ID = 4, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.5, OP = 0, },
		{ Type = "HPRate", ID = 4, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.4, OP = 0, },
		{ Type = "HPRate", ID = 4, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.3, OP = 0, },
		{ Type = "HPRate", ID = 4, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.2, OP = 0, },
		{ Type = "HPRate", ID = 4, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.1, OP = 0, },
	},
	--龙王三太子
	[1005] = 
	{
		{ Type = "HPRate", ID = 5, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.9, OP = 0, },
		{ Type = "HPRate", ID = 5, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.8, OP = 0, },
		{ Type = "HPRate", ID = 5, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.7, OP = 0, },
		{ Type = "HPRate", ID = 5, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.6, OP = 0, },
		{ Type = "HPRate", ID = 5, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.5, OP = 0, },
		{ Type = "HPRate", ID = 5, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.4, OP = 0, },
		{ Type = "HPRate", ID = 5, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.3, OP = 0, },
		{ Type = "HPRate", ID = 5, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.2, OP = 0, },
		{ Type = "HPRate", ID = 5, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.1, OP = 0, },
	},
	--玉石琵琶精
	[1006] = 
	{
		{ Type = "AttackCount", ID = 6, Fun = "OnMonsterTrigger", TriggerCount = 1, AttackCount = 10, OP = 2, },
		{ Type = "AttackCount", ID = 6, Fun = "OnMonsterTrigger", TriggerCount = 1, AttackCount = 30, OP = 2, },
		{ Type = "AttackCount", ID = 6, Fun = "OnMonsterTrigger", TriggerCount = 1, AttackCount = 60, OP = 2, },
		{ Type = "AttackCount", ID = 6, Fun = "OnMonsterTrigger", TriggerCount = 1, AttackCount = 90, OP = 2, },
		{ Type = "AttackCount", ID = 6, Fun = "OnMonsterTrigger", TriggerCount = 1, AttackCount = 120, OP = 2, },
		{ Type = "AttackCount", ID = 6, Fun = "OnMonsterTrigger", TriggerCount = 1, AttackCount = 150, OP = 2, },
		{ Type = "HPRate", ID = 7, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.8, OP = 0, },
		{ Type = "HPRate", ID = 7, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.6, OP = 0, },
		{ Type = "HPRate", ID = 7, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.4, OP = 0, },
		{ Type = "HPRate", ID = 7, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.2, OP = 0, },
		{ Type = "HPRate", ID = 7, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.1, OP = 0, },
	},
	--激战龙王
	[1007] = 
	{
		{ Type = "HPRate", ID = 8, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.9, OP = 0, },
	},
	--东海救人
	[1008] = 
	{
		{ Type = "HPRate", ID = 9, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.9, OP = 0, },
	},
	--打钱副本
	[1010] = 
	{
		{ Type = "HPRate", ID = 10, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.9, OP = 0, },
		{ Type = "HPRate", ID = 10, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.8, OP = 0, },
		{ Type = "HPRate", ID = 10, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.7, OP = 0, },
		{ Type = "HPRate", ID = 10, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.6, OP = 0, },
		{ Type = "HPRate", ID = 10, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.5, OP = 0, },
		{ Type = "HPRate", ID = 10, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.4, OP = 0, },
		{ Type = "HPRate", ID = 10, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.3, OP = 0, },
		{ Type = "HPRate", ID = 10, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.2, OP = 0, },
		{ Type = "HPRate", ID = 10, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.1, OP = 0, },	
		{ Type = "HPRate", ID = 10, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0, OP = 0, },	
	},
		--宝箱
	[1011] = 
	{
		{ Type = "HPRate", ID = 11, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.8, OP = 0, },
		{ Type = "HPRate", ID = 11, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.3, OP = 0, },	
	},
	--帮会boss分身
	[1012] = 
	{
	    { Type = "HPRate", ID = 20, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.9, OP = 0, },
		{ Type = "HPRate", ID = 12, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.7, OP = 0, },
		{ Type = "HPRate", ID = 20, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.6, OP = 0, },
		{ Type = "HPRate", ID = 12, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.4, OP = 0, },
		{ Type = "HPRate", ID = 12, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.2, OP = 0, },
		{ Type = "HPRate", ID = 13, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.5, OP = 0, },
		{ Type = "HPRate", ID = 20, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.3, OP = 0, },
		{ Type = "HPRate", ID = 13, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.1, OP = 0, },
	},
	--神创治疗怪
	[1014] = 
	{
		{ Type = "HPRate", ID = 14, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.7, OP = 0, },
		{ Type = "HPRate", ID = 14, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.5, OP = 0, },
		{ Type = "HPRate", ID = 14, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.2, OP = 0, },	
	},
	--神创护主怪
	[1015] = 
	{
		{ Type = "HPRate", ID = 15, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.9, OP = 0, },
		{ Type = "HPRate", ID = 15, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.5, OP = 0, },
		{ Type = "HPRate", ID = 15, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.3, OP = 0, },	
	},
	--神创眩晕怪
	[1016] = 
	{
		{ Type = "HPRate", ID = 16, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.7, OP = 0, },
		{ Type = "HPRate", ID = 16, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.5, OP = 0, },
		{ Type = "HPRate", ID = 16, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.3, OP = 0, },	
	},
	--35组队加血怪
	[1017] = 
	{
		{ Type = "HPRate", ID = 17, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.9, OP = 0, },
		{ Type = "HPRate", ID = 17, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.7, OP = 0, },
		{ Type = "HPRate", ID = 17, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.5, OP = 0, },
		{ Type = "HPRate", ID = 17, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.3, OP = 0, },	
	},
	--40组队眩晕怪
	[1018] = 
	{
		{ Type = "HPRate", ID = 18, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.9, OP = 0, },
		{ Type = "HPRate", ID = 18, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.7, OP = 0, },
		{ Type = "HPRate", ID = 18, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.5, OP = 0, },
		{ Type = "HPRate", ID = 18, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.3, OP = 0, },	
	},
	--45组队怪
	[1021] = 
	{
		{ Type = "HPRate", ID = 21, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.7, OP = 0, },
		{ Type = "HPRate", ID = 21, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.5, OP = 0, },
		{ Type = "HPRate", ID = 21, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.3, OP = 0, },	
	},
	--帮派镖车
	[1022] = 
	{
		{ Type = "HPRate", ID = 22, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.7, OP = 0, },
	},
	--雕像
	[1023] = 
	{
		{ Type = "HPRate", ID = 23, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.01, OP = 0, },
	},
	--年兽
	[1024] = 
	{
		{ Type = "HPRate", ID = 24, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.7, OP = 0, },
		{ Type = "HPRate", ID = 24, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.4, OP = 0, },
		{ Type = "HPRate", ID = 24, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.1, OP = 0, },	
	},
    --试炼治疗怪
	[1025] = 
	{
		{ Type = "HPRate", ID = 14, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.5, OP = 0, },
	},	
	--试炼护主怪
	[1026] = 
	{
		{ Type = "HPRate", ID = 15, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.5, OP = 0, },	
	},
	--试炼眩晕怪
	[1027] = 
	{
		{ Type = "HPRate", ID = 16, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.5, OP = 0, },
	},
    --试炼三个怪
	[1028] = 
	{
		{ Type = "HPRate", ID = 16, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.9, OP = 0, },
		{ Type = "HPRate", ID = 15, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.5, OP = 0, },	
		{ Type = "HPRate", ID = 14, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.3, OP = 0, },
	},
	--三界至尊预赛boss
	[1029] = 
	{
		{ Type = "HPRate", ID = 34, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.9, OP = 0, },
		{ Type = "HPRate", ID = 34, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.8, OP = 0, },
		{ Type = "HPRate", ID = 33, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.7, OP = 0, },
		{ Type = "HPRate", ID = 30, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.6, OP = 0, },
		{ Type = "HPRate", ID = 33, Fun = "OnMonsterTrigger", TriggerCount = 1,Rate = 0.5, OP = 0, },
		{ Type = "HPRate", ID = 34, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.4, OP = 0, },
		{ Type = "HPRate", ID = 33, Fun = "OnMonsterTrigger", TriggerCount = 1,Rate = 0.3, OP = 0, },
		{ Type = "HPRate", ID = 34, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.2, OP = 0, },
		{ Type = "HPRate", ID = 34, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.1, OP = 0, },
	},
	[1030] = 
	{
		{ Type = "HPRate", ID = 33, Fun = "OnMonsterTrigger", TriggerCount = 1,Rate = 0.5, OP = 0, },
	--	{ Type = "HPRate", ID = 31, Fun = "OnMonsterTrigger", TriggerCount = 1,Rate = 0.4, OP = 0, },
		{ Type = "HPRate", ID = 33, Fun = "OnMonsterTrigger", TriggerCount = 1,Rate = 0.3, OP = 0, },
		{ Type = "HPRate", ID = 34, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.2, OP = 0, },
		{ Type = "HPRate", ID = 34, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.1, OP = 0, },
	},
	[1031] = 
	{
		{ Type = "HPRate", ID = 33, Fun = "OnMonsterTrigger", TriggerCount = 1,Rate = 0.3, OP = 0, },
		{ Type = "HPRate", ID = 32, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.2, OP = 0, },
		{ Type = "HPRate", ID = 34, Fun = "OnMonsterTrigger", TriggerCount = 1, Rate = 0.1, OP = 0, },
	},



}


--------------------------------------------------------------------------
--interface:

--: register monster event function.
function MonsterRegisterEventTrigger(RegionID, GID, Config)
	if Config == nil then
		look("Config is nil!",2)
		return
	end
	for _, v in pairs(Config) do
		if v.Type == "HPNum" then
			CI_AddMonsterHPEvent(v.ID, v.Fun, v.TriggerCount, v.Value, v.OP, 4, GID, RegionID )
		elseif v.Type == "HPRate" then
			look(v.Type,2)
			look(GID,2)
			local MaxHP = GetMonsterData(7, 4, GID, RegionID)
			look(MaxHP,2)
			local Value = MaxHP * v.Rate
			look(Value,2)
			CI_AddMonsterHPEvent(v.ID, v.Fun, v.TriggerCount, Value, v.OP, 4, GID, RegionID)
		elseif v.Type == "AttackCount" then
			CI_AddMonsterAttackCountEvent(v.ID, v.Fun, v.TriggerCount, v.AttackCount, v.OP, 4, GID, RegionID)
		elseif v.Type == "BuffEnd" then
			CI_AddMonsterBuffEndEvent(v.ID, v.Fun, v.BuffID, 4, GID, RegionID)
		elseif v.Type == "BuffBegin" then
			CI_AddMonsterBuffBeginEvent(v.ID, v.Fun, v.BuffID, 4, GID, RegionID)
		end
	end
end

MonsterEvents = _MonsterEvents
