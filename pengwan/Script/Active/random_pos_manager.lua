--
--	随机坐标处理系统
--	目的：处理怪物刷新的逻辑，主要是防止在同一坐标点刷新怪物或者 NPC
--

-- 表中数据结构
-- RandPosSys_Open = { [RandPosID] = { Key1, Key2, ... }, }
-- RandPosSys_Close = { [RandPosID] = { Key1, Key2, ... }, }

-------------------------------------------------------------
--include:
local pairs,ipairs,type ,tostring= pairs,ipairs,type,tostring
local mathrandom = math.random
local tableremove,tableinsert,tableempty = table.remove,table.insert,table.empty

local look = look
local pos_conf_m = require('Script.active.random_pos_conf')
local rand_pos_config = pos_conf_m.rand_pos_config

-------------------------------------------------------------
--module:

module(...)

RandPosSys_Flag = RandPosSys_Flag or 0		-- 防刷处理！

RandPosSys_Open = RandPosSys_Open or {}
RandPosSys_Close = RandPosSys_Close or {}
	
local RandPosSys_Open = RandPosSys_Open
local RandPosSys_Close = RandPosSys_Close

---------------------------------------------------------
--inner:

-- 随机坐标系统初始化
local function RandPosSys_Init()
	for ID,v in pairs(rand_pos_config) do
		RandPosSys_Open[ID] = {}
		RandPosSys_Close[ID] = {}
		for Key, _ in pairs(v) do
			tableinsert(RandPosSys_Open[ID], Key)
		end
	end
end

-- 防刷处理
local function _RandPosSys_AvoidRef()
	if RandPosSys_Flag == 0 then
		----rfalse("初始化！")
		RandPosSys_Init()
		RandPosSys_Flag = 1
	end
end

-- 返回 rand_pos_config[ID] 的所有regionID
local function _RandPosSys_GetAll(ID)
	if type(rand_pos_config) == type({}) then
		return rand_pos_config[ID]
	end
end

-- 从 rand_pos_config[ID] 中随机取出一个可用的坐标
-- 返回值：场景号，X坐标，Y坐标，该位置在 rand_pos_config[ID] 表中的索引, dir
local function _RandPosSys_Get(ID,isSave)
	-- look(RandPosSys_Open,1)
	if RandPosSys_Open[ID] == nil then
		look("RandPosSys_Get invalid ID:" .. tostring(ID),1)
		return
	end

	if tableempty(RandPosSys_Open[ID]) then
		look("RandPosSys_Open empty",1)
		return
	end
	local Rand = mathrandom(#RandPosSys_Open[ID])
	-- look(2222,1)
	-- look(ID,1)
	local Index = RandPosSys_Open[ID][Rand]
	local R = rand_pos_config[ID][Index].R
	local X = rand_pos_config[ID][Index].X
	local Y = rand_pos_config[ID][Index].Y
	-- look(Rand,1)
	-- look(R,1)
	-- look(Y,1)
	-- look(3333,1)
	if isSave == nil then 
		tableremove(RandPosSys_Open[ID], Rand)		-- 从 Open 表中移除 Rand 位置的位置索引
		tableinsert(RandPosSys_Close[ID], Index)	-- 将位置索引 Index 加入 Close 表
	end

	if rand_pos_config[ID][Index].Dir then
		return R, X, Y, Index, rand_pos_config[ID][Index].Dir
	else
		return R, X, Y, Index
	end
end

-- 从 rand_pos_config[ID] 中随机取出一个可用的坐标，排除第 ExIndex 号坐标
-- 返回值：场景号，X坐标，Y坐标，该位置在 rand_pos_config[ID] 表中的索引
-- 这个函数可能会出现死循环!!!暂时没用先注释掉
-- function RandPosSys_GetExcept(ID, ExIndex)

	-- if RandPosSys_Open[ID] == nil then
		-- --rfalse("RandPosSys_GetExcept 无效的 ID:" .. tostring(ID))
		-- return
	-- end
	
	-- if table.empty(RandPosSys_Open[ID]) then
		-- --rfalse("已经没有可以使用的位置了...")
		-- return
	-- end

	-- if #(RandPosSys_Open[ID]) == 1 and RandPosSys_Open[ID][1] == ExIndex then
		-- --rfalse("RandPosSys_Open 表中只含有一个不能使用的位置...")
		-- return
	-- end

	-- local Rand = mathrandom(#RandPosSys_Open[ID])
	-- while RandPosSys_Open[ID][Rand] == ExIndex do
		-- Rand = mathrandom(#RandPosSys_Open[ID])
	-- end

	-- local Index = RandPosSys_Open[ID][Rand]
	-- local R = rand_pos_config[ID][Index].R
	-- local X = rand_pos_config[ID][Index].X
	-- local Y = rand_pos_config[ID][Index].Y

	-- tableremove(RandPosSys_Open[ID], Rand)		-- 从 Open 表中移除 Rand 位置的位置索引
	-- tableinsert(RandPosSys_Close[ID], Index)	-- 将位置索引 Index 加入 Close 表

-- --	return R, X, Y, Index

	-- -- 添加 方向...= =
	-- if rand_pos_config[ID][Index].Dir then
		-- return R, X, Y, Index, rand_pos_config[ID][Index].Dir
	-- else
		-- return R, X, Y, Index
	-- end
-- end

-- 标志 rand_pos_config[ID][Index] 号坐标可用
-- 实际上将该坐标索引从 CLose[ID] 表中删除，加入 Open[ID] 表
local function RandPosSys_Reuse(ID, Index)
	if RandPosSys_Close[ID] then
		for k,v in pairs(RandPosSys_Close[ID]) do
			if v == Index then
				tableremove(RandPosSys_Close[ID], k)
				tableinsert(RandPosSys_Open[ID], Index)
				break
			end
		end
	end
end

-- 标志 rand_pos_config[ID] 的所有坐标可用
local function _RandPosSys_ReuseAll(ID)
	if RandPosSys_Close[ID] then
		for k in pairs(RandPosSys_Close[ID]) do
			RandPosSys_Close[ID][k] = nil			
		end
	end
	if rand_pos_config[ID] then
		for Key, _ in pairs(rand_pos_config[ID]) do
			tableinsert(RandPosSys_Open[ID], Key)
		end
	end
end

-----------------------------------------------------------
--interface:

RandPosSys_Get = _RandPosSys_Get
RandPosSys_AvoidRef = _RandPosSys_AvoidRef
RandPosSys_GetAll = _RandPosSys_GetAll
RandPosSys_ReuseAll = _RandPosSys_ReuseAll
