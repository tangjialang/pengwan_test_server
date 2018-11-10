--[[
file:	message.lua
desc:	achieve messages.
author:	xiao.y
]]--

--------------------------------------------------------------------------
--include:
local achieve = require('Script.achieve.fun')
local get_fun_gift = achieve.get_fun_gift
local get_obj_item = achieve.get_obj_item
local get_sc_item = achieve.get_sc_item
local get_lv_item = achieve.get_lv_item
local get_dl_item = achieve.get_dl_item
local get_obj_finish_item = achieve.get_obj_finish_item
local EveryDay_Actibe_msg = msgh_s2c_def[13][1]
local EveryDay_Error = msgh_s2c_def[13][2]
local Object_Success_msg = msgh_s2c_def[13][3]
local Object_Error = msgh_s2c_def[13][4]
local SendLuaMsg = SendLuaMsg
local fun_module = require('Script.Achieve.fun')
local giveplayer_jihuogift = fun_module.giveplayer_jihuogift
--------------------------------------------------------------------------
-- data:

--领取活跃度奖励
msgDispatcher[13][1] = function ( playerid, msg )
	local result,data,id = get_fun_gift(playerid,msg.idx)
	if(result)then
		SendLuaMsg( 0, { ids=EveryDay_Actibe_msg, data = data, idx = msg.idx }, 9 )
	else 
		SendLuaMsg( 0, { ids=EveryDay_Error, err = data }, 9 )
	end
end

--领取目标奖励
msgDispatcher[13][2] = function ( playerid, msg )
	local result,data = get_obj_item(playerid,msg.oid)
	if(result)then
		SendLuaMsg( 0, { ids=Object_Success_msg, data = data, t = 1, idx = msg.oid }, 9 )
	else 
		SendLuaMsg( 0, { ids=Object_Error, err = data, t = 1 }, 9 )
	end
end

--领取目标大奖励
msgDispatcher[13][3] = function ( playerid, msg )
	local result,data,id = get_obj_finish_item(playerid,msg.ot)
	if(result)then
		SendLuaMsg( 0, { ids=Object_Success_msg, data = data, t = 2, idx = msg.ot }, 9 )
	else 
		SendLuaMsg( 0, { ids=Object_Error, err = data, t = 2 }, 9 )
	end
end

--领取收藏奖励
msgDispatcher[13][4] = function ( playerid, msg )
	local result = get_sc_item(playerid,msg.ot)
	if(result)then
		SendLuaMsg( 0, { ids=Object_Error, err = result, t = 3 }, 9 )
	end
end

--领取礼包奖励
msgDispatcher[13][5] = function ( playerid, msg )
	local result = get_lv_item(playerid,msg.idx)
	if(result)then
		SendLuaMsg( 0, { ids=Object_Error, err = result, t = 4 }, 9 )
	else
		SendLuaMsg( 0, { ids=Object_Success_msg, t = 4, idx = msg.idx }, 9 )
	end
end

--领取下载登录器奖励
msgDispatcher[13][6] = function ( playerid, msg )
local result = get_dl_item(playerid)
	if(result)then
		SendLuaMsg( 0, { ids=Object_Success_msg, t = 5 }, 9 )
	else
		SendLuaMsg( 0, { ids=Object_Error, err = result, t = 5 }, 9 )
	end
end


--领取激活码奖励奖励
msgDispatcher[13][7] = function ( playerid, msg )
		--look('start')
	local result = giveplayer_jihuogift(playerid,msg.iType)
	--look(msg.iType)
end
