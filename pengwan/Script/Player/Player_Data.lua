--[[
file:	Player_Data.lua
desc:	player data init interface
author:	chal
update:	2013-05-20
refix : done by chal
]]--
--------------------------------------------------------------------------
--include:
-- 对玩家数据进行统一管理和分配，防止对dbMgr的随意操作
local bDebugInit = true
local type,tostring = type,tostring
local common 		 = require('Script.common.Log')
local Lua_Debug 	 = common.Lua_Debug
local look = look
local GetObjectUniqueId = GetObjectUniqueId

local Log = Log

local print = print
local tconcat = table.concat
local tinsert = table.insert
local srep = string.rep
local type = type
local pairs = pairs
local tostring = tostring
local next = next
--------------------------------------------------------------------------
--inner:
-- 扩展数据尺寸
local function ResizePlayerData( base_data , key , size )
	if size and base_data[''].__s + size > base_data.__x then
		Lua_Debug( "[数据扩展失败] : "..tostring(key) )
		if bDebugInit then 
			look( "ResizePlayerData Error : "..tostring(key) )
			look(debug.traceback())
		end
		return
	end
	base_data[key].__x = base_data[key].__x + size
end

--------------------------------------------------------------------------
--interface:

-- key : 目前只接受字符串和数字两种key类型
-- size: 为该数据预留的最大长度限制（请务必指定该数值，并趋于保守，不够时扩展）
-- 一期版本的玩家脚本数据大小为5120
function GI_GetPlayerData( sid , key , size )
	-- 基本判断[不记录错误信息]
	if nil==sid or type(sid) ~= type(0) or 0 == sid then return end
	if nil==dbMgr[ sid ] then return end
	-- 目前只接受两种key类型
	if type(key) ~= type("") and type(key) ~= type(0) then
		return
	end
	if key == '' then
		return
	end
	-- 初始化[一期限制为4096]
	if dbMgr[ sid ].data == nil then
		dbMgr[ sid ].data = { __x = 6000 }
	end
	dbMgr[ sid ].data.__x = 6000--=============后面删除
	local base_data = dbMgr[ sid ].data
	if base_data[key] == nil then
		-- 如果期望的数据预留空间不能满足，则申请失败
		if size and base_data[''].__s + size > base_data.__x then
			Lua_Debug( "[数据申请失败] : "..tostring(key) )
			if bDebugInit then 
				look( "GI_GetPlayerData Error : "..tostring(key) )
				look(debug.traceback())
			end
			return
		end
		base_data[key] = {
			__x = size,
		}
	end 
	if base_data[key].__x==nil then
		base_data[key].__x= size
	end
	-- 是否尝试扩展
	if size and base_data[key].__x < size then
		ResizePlayerData( base_data , key , ( size - base_data[key].__x ) )
	end
	return base_data[key]
end

-- 获取临时数据
function GI_GetPlayerTemp( sid , key )
	-- 基本判断[不记录错误信息]
	if nil==sid or 0 == sid then return end
	if nil==dbMgr[ sid ] then return end
	-- 目前只接受两种key类型
	if type(key) ~= type("") and type(key) ~= type(0) then
		return
	end
	if key == '' then
		return
	end
	-- 初始化[限制为1024]
	if dbMgr[ sid ].temp == nil then
		dbMgr[ sid ].temp = { __x = 1024 }
	end

	if dbMgr[ sid ].temp[key] == nil then
		dbMgr[ sid ].temp[key] = {}
	end 
	return dbMgr[ sid ].temp[key]
end

-- 查看数据表
function GI_LookData( sid , key )
	local pdata = GI_GetPlayerData( sid , key )
	if pdata == nil then return end
	look("pdata.__x = "..tostring(pdata.__x))
	look(tostring(pdata))
end

-- 查看临时表
function GI_LookTemp( sid , key )
	local ptemp = GI_GetPlayerTemp( sid , key )
	if ptemp == nil then return end
	look("ptemp.__x = "..tostring(ptemp.__x))
	look(tostring(ptemp))
end

--统计玩家数据区大小
function Getplayerdata_all(sid)
	--looktxt(dbMgr[ sid ].data)
	local playerdata=dbMgr[ sid ].data[''].__s or 0
	look('Alldata='..tostring(playerdata))
end

--统计玩家临时数据区大小
function GetPlayertmp_all(sid)
	local playerdata=dbMgr[ sid ].temp[''].__s or 0
	look('Alldata='..tostring(playerdata))
end
----------------------------------------------------------------------
------------清除废旧活动数据----------------------------------
function Clear_player_old_data(sid)
	if dbMgr[sid] ~= nil and  dbMgr[sid].data ~= nil then
		dbMgr[sid].data['dwhd'] = nil
		dbMgr[sid].data['pjj'] = nil
		dbMgr[sid].data['zqj'] = nil
		dbMgr[sid].data['gqj'] = nil
		dbMgr[sid].data['sdj'] = nil
	end
end

---------------------- 功能数据定义接口 ----------------------
--：零碎数据
function GetPlayerTemp_custom( sid )
	local customdata =GI_GetPlayerTemp( sid , 'cust' )--零碎数据
	if customdata==nil then return end
	return customdata
end

--：活动类数据组成:1临时数据,2永久数据,3放在task下的同步数据
function GetActiveTemp( sid )
	local customdata =GI_GetPlayerTemp( sid , 'acti' )--零碎数据
	if customdata==nil then return end
	return customdata
end

--活动类永久数据
function GetDBActiveData( sid )
	local ActiveData=GI_GetPlayerData( sid , 'acti' , 1000 )
	if ActiveData==nil then return end
	return ActiveData
end

function GetDBCommonData( sid )
	--[1] 回归勇士等级 (1，2，3)
	return GI_GetPlayerData(sid,'comm', 100)
end

--活动类task同步数据
function GetDBCustomData( sid )
	local taskData=GetDBTaskData( sid )
	if taskData==nil then return end
	if taskData.cust == nil then
		taskData.cust = {}
	end
	return taskData.cust
end

--：玩家每日数据
function GetPlayerDayData(playerID)
	local DayData = GI_GetPlayerData( playerID , "day" , 300 )
	if nil == DayData then
		return
	end
	--look(tostring(DayData))
	return DayData
end

--:直接换取当前玩家的封装
function GetCurPlayerID()
	local npcid, monid, playerid = GetObjectUniqueId()
	--look(11111111)
	--look(playerid)
	return playerid
end

function GetCurDBCustomData()
	return GetDBCustomData(GetCurPlayerID())
end
--=====================================================----
-- 判断玩家是否在线
function IsPlayerOnline(sid)
	if dbMgr[ sid ] == nil then
		return false
	end
	return true
end

function GetPlayerServerID(sid)
	return GI_GetPlayerData(sid,'ccfb',80).lsid
end

function SetPlayerServerID(sid)
	local pdata = GI_GetPlayerData(sid,'ccfb',80)
	if pdata then pdata.lsid = GetGroupID() end
end

function ClearPlayerData(sid,...)
	if dbMgr[sid] == nil then return end
	local base_data = dbMgr[ sid ].data
	if not base_data then return end
	local i = 1
	while(arg[i + 1]) do
		base_data = base_data[arg[i]]
		if not base_data then return end
		i = i+1
	end
	base_data[arg[i]] = nil
end

function SetPlayerData(sid,data,...)
	if dbMgr[sid] == nil then return end
	local base_data = dbMgr[ sid ].data
	if not base_data then return end
	local i = 1
	while(arg[i + 1]) do
		base_data = base_data[arg[i]]
		if not base_data then return end
		i = i+1
	end
	base_data[arg[i]] = data
end
---------------------- test ---------------------- 

function LogPlayerData(sid, key)
	if dbMgr[sid] ~= nil  then 
		if key == nil then 
			Log("LogPlayerData.txt", dbMgr[ sid ].data)	
		elseif key ~= nil and dbMgr[ sid ].data[key] ~= nil then 
			Log("LogPlayerData.txt", dbMgr[ sid ].data)	
		end
	end
end



--[[
function GetPlayerTestData( sid )
	local pdata = GI_GetPlayerData( sid , "test" , 128 )
	if pdata == nil then return end
	return pdata
end

function GetPlayerTestTemp( sid )
	local ptemp = GI_GetPlayerTemp( sid , "test" )
	if ptemp == nil then return end
	return ptemp
end

TRACE_BEGIN() - TRACE_END() test spend time
collectgarbage("count") test spend memory

function Test_PD( sid )
	dbMgr[ sid ].data = nil
	dbMgr[ sid ].temp = nil
	local testData = GetPlayerTestData( sid )
	if testData then
		testData.t = {1}
		GI_LookData( sid , "test" )
		look(testData)
	end
	local testTemp= GetPlayerTestTemp( sid )
	if testTemp then
		testTemp.t = {1}
		GI_LookData( sid , "test" )
		look(testTemp)
	end
	look(tostring(dbMgr[ sid ].temp))
end
]]--