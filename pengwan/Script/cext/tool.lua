--[[
file:	tool.lua
desc:	用于全局的工具函数库
author:	chal
update:	2013-07-11
]]--

--------------------------------------------------------------------------
--include:
local error,pairs,type,tostring = error,pairs,type,tostring
local __G = _G
local common = require('Script.common.Log')
local Log_Begin,Log_Save,Log_End = common.Log_Begin,common.Log_Save,common.Log_End
local look = look
local CI_GetPlayerData = CI_GetPlayerData
--------------------------------------------------------------------------
--module:
module(...)

local function task_check()
	--check task's npc.
	
	local TaskList 	= __G.TaskList
	local npclist 	= __G.npclist
	local GetTaskId = __G.GetTaskId
	
	if nil==TaskList then
		error("TaskList no exists")
	end

	if nil==npclist then
		error("npclist no exists")
	end
	
	local function check_npc_exists( npcid, info)
		if npcid ~= 0 then
			if nil==npclist[npcid] then
				npcid = npcid or 0
				return false
			end			
		end
		return true
	end

	for mainid,t in pairs(TaskList) do
		for subid,conf in pairs(t) do
			if type(0) == type(mainid) and type(0) == type(subid) then
				local taskid = GetTaskId(mainid, subid)
				check_npc_exists( conf.AcceptNPC, " ERROR: task " .. taskid .. "AcceptNPC no exist." )
				check_npc_exists( conf.SubmitNPC, " ERROR: task " .. taskid .. "SubmitNPC no exist." )
			end
		end
	end
end

local function check_dynamic_region()

	local DRList = __G.DRList
	
	-- check DR's npc.
	if nil==DRList then
		error("DRList no exist.")
	end

	for id, config in pairs(DRList) do
		if config.npc then
			for _,npcid in pairs(config.npc) do
				if nil==npclist[npcid] then
					--rfalse( "DRList id: " .. id .. " NPC no exist: " .. npcid )
				end
			end
		end
	end
end

local function _check_config()
	task_check()
	check_dynamic_region()
end

-- check '_G'
local function _chk_g(maxLv,t)
	maxLv = maxLv or 1
	Log_Begin("check_table_g.lua")

	local function Save(key,Obj, Level)
		if Level > maxLv then return end
		
		local Blank = ""
		for i = 1, Level do
			Blank = Blank .. "   "
		end
		
		if type(Obj) == type({}) then			
			local x = 0
			for k,v in pairs(Obj) do
				x = x + 1
			end
			
			Log_Save(Blank..'['..tostring(key)..'('..tostring(x)..')]=\n')
			Log_Save(Blank..'{\n')

			for k,v in pairs(Obj) do
				if key == 'dbMgr' and type(k) == type(0) then
					--Log_Save(Blank..tostring(k)..'\n')
				elseif type(v) == type({}) and v ~= Obj then
					Save(k,v, Level + 1)
				end
			end
			
			Log_Save(Blank..'}\n')
		end
	end
	
	local ct,cf,cs,cn,cb,co = 0,0,0,0,0,0
	
	for n,m in pairs(__G) do
		if type(m) == type({}) and n ~= '_G' then
			if t== 1 then Save(n, m,1) end
			ct = ct + 1
		elseif type(m) == 'function' then
			if t == 2 then Log_Save('['..tostring(n)..']\n') end
			cf = cf + 1
		elseif type(m) == type('') then
			cs = cs + 1
			if t == 3 then Log_Save('['..tostring(n)..']\n') end
		elseif type(m) == type(0) then
			cn = cn + 1
			if t == 4 then Log_Save('['..tostring(n)..']\n') end
		elseif type(m) == type(true) then
			cb = cb + 1
			if t == 5 then Log_Save('['..tostring(n)..']\n') end
		else
			co = co + 1
			if t == 6 then Log_Save('['..tostring(n)..']\n') end
		end
	end
	
	Log_End()
	look('table	['..tostring(ct)..']\n')
	look('function	['..tostring(cf)..']\n')
	look('string	['..tostring(cs)..']\n')
	look('number	['..tostring(cn)..']\n')
	look('boolen	['..tostring(cb)..']\n')
	look('other	['..tostring(co)..']\n')
	look('shot done!\n')
end

-- check dbMgr player data
local function _chk_mgr()
	Log_Begin("check_count_mgr.txt")
	local count = 0
	for n,m in pairs(__G) do
		if n == "dbMgr" and type(m) == type({}) then
			for i,v in pairs(m) do
				if type(i) == type(0) and type(v) == type({}) then
					count = count + 1
					Log_Save('['..tostring(i)..']\n')
				end
			end
		end
	end
	Log_End()
	look("count_mgr = "..tostring(count))
end

local function chk_player_data(sid,file_name)
	Log_Begin(file_name)
	local function Save(Obj, Level)
		local Blank = ""
			for i = 1, Level do
				Blank = Blank .. "   "
			end
		if type(Obj) == "number" or type(Obj) == "string" then

			Log_Save(Blank.."   "..Obj..'\n')
		elseif type(Obj) == type({}) then
			
			Log_Save(Blank.."{\n")
			for k,v in pairs(Obj) do
				if tostring(k) ~= "" and v ~= Obj then
					Log_Save(Blank.. " [".. tostring(k).. "] = ")
					Save(v, Level + 1)
					--rfalse("\n")
				end
			end
			Log_Save(Blank.. "}\n")
		else
			Log_Save(Blank..'valve=='..tostring(Obj)..'\n')
		end
	end
	Save(__G.dbMgr[sid],1)
	
	local name = CI_GetPlayerData(5,2,sid)
	Log_Save('name='..tostring(name),1)
	Log_Save(tostring(__G.dbMgr[sid].data),1)
	Log_Save(tostring(__G.dbMgr[sid].temp),1)
	Log_Save("shot done xxx!",1)
	
	Log_End()
end

local function _chk_p(sid,lv)
	local level = CI_GetPlayerData(1,2,sid)
	local file_name = "trace_"..tostring(lv)..'_'..tostring(level)..".txt"
	local data,temp = chk_player_data(sid,file_name)
end

--------------------------------------------------------------------------
--interface:
check_config = _check_config	-- check config
chk_g = _chk_g					-- check _G
chk_mgr = _chk_mgr				-- check dbmgr
chk_p = _chk_p					-- check player					
