--[[
file: monster_move.lua
desc: movescript proc
]]--
--------------------------------------------------------
-- include:
local type,rint = type,rint
local CI_UpdateMonsterData = CI_UpdateMonsterData
--------------------------------------------------------
-- inner:

-- 巡逻怪物移动路径(每个路径最多支持99个点)
local MonsterMoves = 
{
	[1100] = {{29,111},{40,100}},
	[1200] = {{31,50},{16,35}},
	[1300] = {{43,30},{54,42}},
	[1400] = {{81,43},{98,60}},
	[1500] = {{53,156},{96,113},{85,102},{96,113}},
	[1600] = {{74,98},{64,98},{55,89},{48,82},{60,70},{70,70},{86,86}},
}
--怪物移动回调各功能
call_monster_move = {
	-- [movescriptid] = function () ... end
	[10007]=function ()--主线抓鱼
		CI_UpdateMonsterData(1,{moveScript=10007,},nil,3)
		CI_MoveMonster(0,0,1,3) --移到出生点
	end,
}

local uv_mPropertyTb = {}
--------------------------------------------------------
--interface:
-- 怪物移动回调
function SI_OnMonsterMove( copySceneGID, moveScriptID, monGID, deadScriptID )
	--look('SI_OnMonsterMove:' .. moveScriptID)
	if moveScriptID > 10000 then
		local func = call_monster_move[moveScriptID]
		if type(func) == 'function' then
			func( monGID, copySceneGID, deadScriptID )
		end
	else
		local MainK = rint(moveScriptID / 100) * 100
		local SubK = moveScriptID % 100
		if MonsterMoves[MainK] and MonsterMoves[MainK][SubK] then						
			local target = MonsterMoves[MainK][SubK]
			uv_mPropertyTb.targetX = target[1]
			uv_mPropertyTb.targetY = target[2]
			uv_mPropertyTb.IdleTime = 5*5
			if MonsterMoves[MainK][SubK + 1] then
				uv_mPropertyTb.moveScript = moveScriptID + 1							
			else
				uv_mPropertyTb.moveScript = MainK + 1				
			end
			CI_UpdateMonsterData(1,uv_mPropertyTb,nil,3)
		end
	end
end