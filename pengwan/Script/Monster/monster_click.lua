--[[
file: OnClickMonster .lua
desc:--点击回调
]]--
--------------------------------------------------------
local TP_FUNC = type( function() end)

--点击回调
local _call_monster_chick = noassign{
	-- [deadscriptid] = function () ... end
	-- [7]=function (itemid)	--主线抓鱼
	-- 	CI_MoveMonster(0,0,1,3) --移到出生点
	-- end,
}

--------------------------------------------------------
--interface:
function SI_OnClickMonster(id,arg)
	look('SI_OnClickMonster')
	local funname=_call_monster_chick[id]
	if type(funname)~=TP_FUNC then
		return
	end
	funname(arg)
end
------------------------------------------------------
call_monster_chick = _call_monster_chick