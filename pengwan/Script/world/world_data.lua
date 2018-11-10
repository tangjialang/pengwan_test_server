--[[
file:	world_data.lua
desc:	script global data(common data area except certain function's data,e.g.faction fight)
author:	chal
update:	2013-05-21
refix: done by chal
]]--

--------------------------------------------------------------------------
--include:
local look = look
--------------------------------------------------------------------------
--inner:

local attnum = 14
-- reuse world data
local r_w_d = {
	{},
	{
		n 		= "",
		att 	= {0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		skid 	= nil,
		sklv	= nil,
		id		= 0,
		lv		= 0,
	},
}

local function ClrRWData(t)
	local td = r_w_d[t]
	if td == nil then return end
	
	if t == 1 then
		for i=1 ,attnum do
			if td[i]~=nil then
				--look('[r_w_d]check error when t == 1 ',1)
				--if __debug then ShowCallStack() end
				td[i]=nil
			end
		end
	elseif t == 2 then
		for i=1 ,attnum do
			td.att[i]=0
		end
		td.n 	= nil
		td.skid	= nil
		td.sklv	= nil
		td.id	= nil
		td.lv	= nil
	end
end

--保险起见，每次调用前进行一次数据检查重置，必要时打印提示信息，除非显式指定notclear
local function _GetRWData(t,notclear)
	if notclear == nil then
		ClrRWData(t)
	end
	return r_w_d[t]
end

local function _GetWorldCustomDB()
	if nil==dbMgr.world_custom_data.data then
		dbMgr.world_custom_data.data = {}
	end
	return dbMgr.world_custom_data.data
end

local function _GetWorldCustomTempDB()
	if nil==dbMgr.world_custom_data.temp then
		dbMgr.world_custom_data.temp = {}
	end
	return dbMgr.world_custom_data.temp
end
--------------------------------------------------------------------------
--interface:
GetRWData = _GetRWData							--get global reuse data
GetWorldCustomDB = _GetWorldCustomDB			--get global save data
GetWorldCustomTempDB = _GetWorldCustomTempDB	--get global temp data