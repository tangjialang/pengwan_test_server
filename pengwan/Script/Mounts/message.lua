--[[
file:	message.lua
desc:	Mounts messages.
author:	chal
update:	2011-12-07
refix:	done by xy
]]--

--------------------------------------------------------------------------
--include:
local new_guide = require('Script.new_guide.fun')
local set_guide = new_guide.set_guide

local msgDispatcher = msgDispatcher
local Horse_Data = msgh_s2c_def[17][1]
local Horse_Fail = msgh_s2c_def[17][2]
local Horse_SetStyle = msgh_s2c_def[17][4]
local Horse_EquipData = msgh_s2c_def[17][7]
local Horse_EquipErr = msgh_s2c_def[17][8]

local CultivateProc = CultivateProc
local MouseBoneProc = MouseBoneProc
local getMountPtGift = getMountPtGift
local SetMouseStyle = SetMouseStyle
local SendOtherMouseData = SendOtherMouseData
local UpDownMount = UpDownMount
local SendMouseData = SendMouseData
local SendLuaMsg = SendLuaMsg
local GetMountsData = GetMountsData
local new_guide = require('Script.new_guide.fun')
local set_guide = new_guide.set_guide
local CI_OperateMounts = CI_OperateMounts
local mount_equip_up = mount_equip_up
--------------------------------------------------------------------------
-- data:

--培养坐骑
msgDispatcher[14][1] = function ( playerid,msg)
	--true,data,isup,cidx,addproc,isBVal
	--return true,data,isup,cidx,tempned,tempexp,errIdx
	local result,data,isup,cidx,add,isb,errIdx = CultivateProc(playerid,msg.type,msg.num,msg.itype)
	if(result)then
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 1,up = isup, add = add, cidx = cidx, isb = isb, errIdx = errIdx}, 9 )
	else
		SendLuaMsg( 0, { ids = Horse_Fail, t = 1, data = data}, 9 )
	end
end
--坐骑炼骨
msgDispatcher[14][2] = function ( playerid,msg)
	local result,data,datagoodsNum,isup = MouseBoneProc(playerid,msg.num)
	if(result)then
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 2, num = datagoodsNum, up = isup}, 9 )
	else
		SendLuaMsg( 0, { ids = Horse_Fail, t = 2, data = data}, 9 )
	end
end
--抽奖
msgDispatcher[14][3] = function ( playerid,msg)
	local result,data,idx,goodid = getMountPtGift(playerid)
	if(result)then
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 5, idx = idx,goodid = goodid}, 9 )
	else
		SendLuaMsg( 0, { ids = Horse_Fail, t = 5, data = data}, 9 )
	end
end
--坐骑幻化形象设置
msgDispatcher[14][4] = function ( playerid,msg)
	local result,data = SetMouseStyle(playerid,msg.index,msg.ctype)
	if(result)then
		SendLuaMsg( 0, { ids = Horse_SetStyle, i = msg.index , ct = msg.ctype}, 9 )
	else
		SendLuaMsg( 0, { ids = Horse_Fail, t = 4, data = data}, 9 )
	end
end
--获取坐骑数据
msgDispatcher[14][5] = function ( playerid,msg)
	SendOtherMouseData(msg.pid)
end
--上下坐骑
msgDispatcher[14][6] = function ( playerid,msg)
	UpDownMount(playerid,msg.isride)
end
--请求其它在线玩家的坐骑数据
msgDispatcher[14][7] = function ( playerid,msg)
	SendMouseData(msg.sid,nil,msg.name,msg.type)
end
--请求设置体验坐骑
msgDispatcher[14][8] = function ( playerid,msg)
	local data = GetMountsData(playerid)
	if(data == nil)then
		set_guide(CI_GetPlayerData(17),0,1,1006,112) --体验坐骑
	end
end
--假坐骑
msgDispatcher[14][9] = function ( playerid,msg)
	set_guide(playerid,0,1,1006,112)
end

--假坐骑
msgDispatcher[14][10] = function ( playerid,msg)
	CI_OperateMounts(2)
end

--坐骑装备的(强化/升品/刻纹)
msgDispatcher[14][11] = function ( playerid,msg)
	local result,data,lv,isq = mount_equip_up(playerid,msg.idx,msg.tp,msg.goodid1,msg.num1,msg.goodid2,msg.num2,msg.ism)
	if(result)then
		SendLuaMsg( 0, { ids = Horse_EquipData, t = msg.tp, data = data, lv = lv, isq = isq, idx = msg.idx}, 9 )
	else
		look('error = '..data)
		SendLuaMsg( 0, { ids = Horse_EquipErr, t = msg.tp, data = data}, 9 )
	end
end