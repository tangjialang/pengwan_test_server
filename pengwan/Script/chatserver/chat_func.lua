--[[
file: chat_func.lua
desc: 聊天功能处理
auto: csj
]]--

local CI_GetPlayerData = CI_GetPlayerData
local db_module = require('Script.cext.dbrpc')
local db_get_span_server = db_module.db_get_span_server

-- 服务器启动时获取所有跨服服务器
function db_get_allspanserver()
	db_get_span_server(-1,0)
end

-- 获取跨服服务器
function GetAllSpanServer()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then return end
	
	w_customdata.allspan = w_customdata.allspan or {}
	
	return w_customdata.allspan
end

function SetAllSpanServer(rs)
	if rs == nil then return end
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then return end
	
	w_customdata.allspan = rs
	-- look(w_customdata.allspan,1)
end

-- 帮会聊天处理
function FactionChatProc(sid,fac_id,loc_svrid,contents)
	local canchat=CI_GetPlayerData(68)
	if canchat==0 then--1 可以发言  0 被禁言不能发言
		return 
	end
	if sid == nil or loc_svrid == nil or contents == nil then return end
	-- local fac_id = CI_GetPlayerData(23,2,sid)
	if fac_id == nil or fac_id <= 0 then
		return
	end
	local name = CI_GetPlayerData(5,2,sid)
	local icon = CI_GetPlayerIcon(0,0,2,sid)	
		
	if IsSpanServer() then		-- 如果在跨服 消息将会发回本服
		PI_SendToLocalSvr(loc_svrid, {ids = 7001, fac_id = fac_id, name = name, contents = contents, icon = icon})
		-- 同步到所有跨服
		local alls = GetAllSpanServer()
		if type(alls) == type({}) then
			for k, v in ipairs(alls) do
				PI_SendToSpanSvr(v[1], {ids = 7001, fac_id = fac_id, name = name, contents = contents, icon = icon,loc_svrid=loc_svrid})
			end
		end
	else						-- 如果在本服 消息遍历发送到所有跨服
		-- 正常帮会处理
		FactionRPC(fac_id,'fac_chatrpc',name,contents,icon)
		-- 同步到所有跨服
		local alls = GetAllSpanServer()
		if type(alls) == type({}) then
			for k, v in ipairs(alls) do
				PI_SendToSpanSvr(v[1], {ids = 7001, fac_id = fac_id, name = name, contents = contents, icon = icon,loc_svrid=loc_svrid})
			end
		end
	end
	
end

function FactionChat_c2s(fac_id,name,contents,icon,loc_svrid)
	if fac_id == nil or name == nil or contents == nil then
		return
	end
	BroadcastRPC('fac_chatrpc_br',fac_id,name,contents,icon,loc_svrid)
end

function FactionChat_s2c(fac_id,name,contents,icon)
	if fac_id == nil or name == nil or contents == nil then
		return
	end
	FactionRPC(fac_id,'fac_chatrpc',name,contents,icon)
end