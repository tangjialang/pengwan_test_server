--[[
file:	RPC.lua
desc:	RPC from server ro client.
author:	chal
update:	2011-12-07
]]--

--------------------------------------------------------------------------
--include:
local type = type
local SendLuaMsg = SendLuaMsg

--------------------------------------------------------------------------
--inner:

local uv_rpc_msg = { ids = {10}, f = nil, arg = nil, }

local function __RPC(a1, a2, f, ag)
	if type(f)==type('') then

		uv_rpc_msg.f = f
		
		if #ag>0 then
			ag.n = nil
			uv_rpc_msg.arg = ag
			SendLuaMsg( a1, uv_rpc_msg, a2 )
		else
			uv_rpc_msg.arg = nil
			SendLuaMsg( a1, uv_rpc_msg, a2 )
		end
	end
end
local function __RPCEx(a1, a2, ex, f, ag)
	if type(f)==type('') then
	
		uv_rpc_msg.f = f
		
		if #ag>0 then
			ag.n = nil
			uv_rpc_msg.arg = ag
			SendLuaMsg( a1, uv_rpc_msg, a2, ex )
		else
			uv_rpc_msg.arg = nil
			SendLuaMsg( a1, uv_rpc_msg, a2, ex )
		end
	end
end

--------------------------------------------------------------------------
--interface:
-- RPC to cur player.
function RPC( f, ...)
	__RPC( 0, 9, f, arg)
end

function RPCEx( sid,f, ...)
	__RPC(sid, 10, f, arg)
end

--RPC to team.
function TeamRPC( tid , f, ...)
	__RPC( tid, 15, f, arg)
end

-- RPC broadcast global.
function BroadcastRPC( f, ...)
	__RPC( 0, 11, f, arg)
end
-- RPC region.
function RegionRPC( regionId, f, ...)
	__RPC( regionId, 8, f, arg )
end

-- RPC area.[以对象为中心进行区域广播]
function AreaRPC( a1,a2,a3, f, ...)
	uv_rpc_msg.f = f
	uv_rpc_msg.arg = arg
	SendLuaMsg( 0, uv_rpc_msg, 14, a1 , a2 , a3 )
end

-- RPC Faction.
function FactionRPC( faction, f, ...)
	if type{}==type(faction) then
		__RPCEx( faction[1], 13, faction[2], f, arg )
	else
		__RPCEx( faction, 13, nil, f, arg )	
	end
end