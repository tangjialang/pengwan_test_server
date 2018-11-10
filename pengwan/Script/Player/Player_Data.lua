--[[
file:	Player_Data.lua
desc:	player data init interface
author:	chal
update:	2013-05-20
refix : done by chal
]]--
--------------------------------------------------------------------------
--include:
-- ��������ݽ���ͳһ����ͷ��䣬��ֹ��dbMgr���������
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
-- ��չ���ݳߴ�
local function ResizePlayerData( base_data , key , size )
	if size and base_data[''].__s + size > base_data.__x then
		Lua_Debug( "[������չʧ��] : "..tostring(key) )
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

-- key : Ŀǰֻ�����ַ�������������key����
-- size: Ϊ������Ԥ������󳤶����ƣ������ָ������ֵ�������ڱ��أ�����ʱ��չ��
-- һ�ڰ汾����ҽű����ݴ�СΪ5120
function GI_GetPlayerData( sid , key , size )
	-- �����ж�[����¼������Ϣ]
	if nil==sid or type(sid) ~= type(0) or 0 == sid then return end
	if nil==dbMgr[ sid ] then return end
	-- Ŀǰֻ��������key����
	if type(key) ~= type("") and type(key) ~= type(0) then
		return
	end
	if key == '' then
		return
	end
	-- ��ʼ��[һ������Ϊ4096]
	if dbMgr[ sid ].data == nil then
		dbMgr[ sid ].data = { __x = 6000 }
	end
	dbMgr[ sid ].data.__x = 6000--=============����ɾ��
	local base_data = dbMgr[ sid ].data
	if base_data[key] == nil then
		-- �������������Ԥ���ռ䲻�����㣬������ʧ��
		if size and base_data[''].__s + size > base_data.__x then
			Lua_Debug( "[��������ʧ��] : "..tostring(key) )
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
	-- �Ƿ�����չ
	if size and base_data[key].__x < size then
		ResizePlayerData( base_data , key , ( size - base_data[key].__x ) )
	end
	return base_data[key]
end

-- ��ȡ��ʱ����
function GI_GetPlayerTemp( sid , key )
	-- �����ж�[����¼������Ϣ]
	if nil==sid or 0 == sid then return end
	if nil==dbMgr[ sid ] then return end
	-- Ŀǰֻ��������key����
	if type(key) ~= type("") and type(key) ~= type(0) then
		return
	end
	if key == '' then
		return
	end
	-- ��ʼ��[����Ϊ1024]
	if dbMgr[ sid ].temp == nil then
		dbMgr[ sid ].temp = { __x = 1024 }
	end

	if dbMgr[ sid ].temp[key] == nil then
		dbMgr[ sid ].temp[key] = {}
	end 
	return dbMgr[ sid ].temp[key]
end

-- �鿴���ݱ�
function GI_LookData( sid , key )
	local pdata = GI_GetPlayerData( sid , key )
	if pdata == nil then return end
	look("pdata.__x = "..tostring(pdata.__x))
	look(tostring(pdata))
end

-- �鿴��ʱ��
function GI_LookTemp( sid , key )
	local ptemp = GI_GetPlayerTemp( sid , key )
	if ptemp == nil then return end
	look("ptemp.__x = "..tostring(ptemp.__x))
	look(tostring(ptemp))
end

--ͳ�������������С
function Getplayerdata_all(sid)
	--looktxt(dbMgr[ sid ].data)
	local playerdata=dbMgr[ sid ].data[''].__s or 0
	look('Alldata='..tostring(playerdata))
end

--ͳ�������ʱ��������С
function GetPlayertmp_all(sid)
	local playerdata=dbMgr[ sid ].temp[''].__s or 0
	look('Alldata='..tostring(playerdata))
end
----------------------------------------------------------------------
------------����Ͼɻ����----------------------------------
function Clear_player_old_data(sid)
	if dbMgr[sid] ~= nil and  dbMgr[sid].data ~= nil then
		dbMgr[sid].data['dwhd'] = nil
		dbMgr[sid].data['pjj'] = nil
		dbMgr[sid].data['zqj'] = nil
		dbMgr[sid].data['gqj'] = nil
		dbMgr[sid].data['sdj'] = nil
	end
end

---------------------- �������ݶ���ӿ� ----------------------
--����������
function GetPlayerTemp_custom( sid )
	local customdata =GI_GetPlayerTemp( sid , 'cust' )--��������
	if customdata==nil then return end
	return customdata
end

--������������:1��ʱ����,2��������,3����task�µ�ͬ������
function GetActiveTemp( sid )
	local customdata =GI_GetPlayerTemp( sid , 'acti' )--��������
	if customdata==nil then return end
	return customdata
end

--�����������
function GetDBActiveData( sid )
	local ActiveData=GI_GetPlayerData( sid , 'acti' , 1000 )
	if ActiveData==nil then return end
	return ActiveData
end

function GetDBCommonData( sid )
	--[1] �ع���ʿ�ȼ� (1��2��3)
	return GI_GetPlayerData(sid,'comm', 100)
end

--���taskͬ������
function GetDBCustomData( sid )
	local taskData=GetDBTaskData( sid )
	if taskData==nil then return end
	if taskData.cust == nil then
		taskData.cust = {}
	end
	return taskData.cust
end

--�����ÿ������
function GetPlayerDayData(playerID)
	local DayData = GI_GetPlayerData( playerID , "day" , 300 )
	if nil == DayData then
		return
	end
	--look(tostring(DayData))
	return DayData
end

--:ֱ�ӻ�ȡ��ǰ��ҵķ�װ
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
-- �ж�����Ƿ�����
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