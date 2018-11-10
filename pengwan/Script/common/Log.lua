--[[
file:	log.lua
desc:	文本日志接口
author:	chal
update:	2013-07-01
module by chal
]]--
--------------------------------------------------------------------------
--include:
local tostring = tostring
local type = type
local pairs = pairs
local ioopen = io.open
local osdate = os.date
local ostime = os.time
local look = look
--------------------------------------------------------------------------
-- module:
module(...)

g_LogFile = g_LogFile or nil

-- 打开一个文件，准备记录日志
local function _Log_Begin(FilePath)
	g_LogFile = ioopen(FilePath, "a")
	if not g_LogFile then
		look("日志文件打开失败！")
	end
end

-- 保存日志到打开的文件中
local function _Log_Save(Obj,bLogTime)
	local function Save(Obj, Level)
		if not g_LogFile then
			return
		end
		if type(Obj) == "number" or type(Obj) == "string" then
			if bLogTime then
				local Date = osdate("*t", ostime())
				local Fmt = "[" .. Date.year .. "-" .. Date.month .. "-" .. Date.day .. "-" .. Date.hour .. "-" .. Date.min .. "-" .. Date.sec .. "]\n"
				g_LogFile:write(Obj..Fmt)
			else
				g_LogFile:write(Obj)
			end
		elseif type(Obj) == type({}) then
			local Blank = ""
			for i = 1, Level do
				Blank = Blank .. "   "
			end
			g_LogFile:write("{\n")
			for k,v in pairs(Obj) do
				if tostring(k) ~= "" and v ~= Obj then
					g_LogFile:write(Blank, "[", tostring(k), "] = ")
					Save(v, Level + 1)
					g_LogFile:write("\n")
				end
			end
			g_LogFile:write(Blank, "}\n")
		else	 
			g_LogFile:write(type(Obj))
		end
	end
	
	-- 调用 Save 方法进行日志的记录
	Save(Obj, 1)
end

-- 关闭文件句柄，写文件
local function _Log_End()
	if g_LogFile then
		g_LogFile:close()
		g_LogFile = nil
	end
end

local function _Log(filename,t)
	_Log_Begin(filename)
	_Log_Save(t,1)
	_Log_End()
end

local function _Lua_Debug(info)
	_Log("Lua_Debug.txt",info)
end

--------------------------------------------------------------------------
-- interface:

Log_Begin 	= _Log_Begin	--open file to log.
Log_Save 	= _Log_Save		--log a log.
Log_End 	= _Log_End		--close file.
Log 		= _Log			--interface for above.
Lua_Debug 	= _Lua_Debug	--lua debug to file.