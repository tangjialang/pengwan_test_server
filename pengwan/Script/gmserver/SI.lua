
-----------------------------------------------
--include:

-- local slq_active_m = require('Script.active.sql_active')
-- local active_version_check = slq_active_m.active_version_check
-- local active_version_update = slq_active_m.active_version_update
local public_m = require('Script.gmserver.public')
local on_public_rpc = public_m.on_public_rpc
local on_public_event = public_m.on_public_event
local callback_get_public = public_m.callback_get_public
local BroadcastRPC = BroadcastRPC
local GetWorldCustomDB=GetWorldCustomDB
local type = type

function SI_NoticeRefresh()
	BroadcastRPC('notice_refresh')
end

function SI_SetNoticeEquip(rs)
	if type(rs) ~= type(0) then return end
	--
	local wdata = GetWorldCustomDB()
	wdata.show_equip = wdata.show_equip or {
		index = 0,
	}
	if rs == 1 then 
		wdata.show_equip.index = 1
		BroadcastRPC('show_equip', 1)
	else
		wdata.show_equip.index = 0
		BroadcastRPC('show_equip', 0)
	end
end

function SI_OnRPCCMD(stype,args)
	look("SI_OnRPCCMD:" .. tostring(stype) .. "__" .. tostring(args))
	local ret
	if stype == 1 then		-- 同步活动信息
		active_version_update(args)
		return 0
	elseif stype == 2 then	-- 检测活动信息
		return active_version_check(args)
	elseif stype == 3 then	-- 更新公告
		return on_public_rpc()
	elseif stype == 5 then	-- 设置指导员
		return set_vip_icon(args,2,1,1)
	elseif stype == 6 then	-- 取消指导员
		return set_vip_icon(args,2,0,1)
	elseif stype == 7 then	-- 设置GM
		return set_vip_icon(args,3,1,1)
	elseif stype == 8 then	-- 取消GM
		return set_vip_icon(args,3,0,1)
	elseif stype == 9 then
		BroadcastRPC('show_girl')
		return 0
	end	
end

function SI_public_event(tick)
	on_public_event()
	return tick
end

function CALLBACK_GetPublic(rs)
	callback_get_public(rs)
end

