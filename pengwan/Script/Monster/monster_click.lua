--[[
file: OnClickMonster .lua
desc:--����ص�
]]--
--------------------------------------------------------
local TP_FUNC = type( function() end)

--����ص�
local _call_monster_chick = noassign{
	-- [deadscriptid] = function () ... end
	-- [7]=function (itemid)	--����ץ��
	-- 	CI_MoveMonster(0,0,1,3) --�Ƶ�������
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