--[[�˺�����

--]]

--called by c++
--[mapGID] = func
_player_damage_proc = _player_damage_proc or {}
_monster_damage_proc = _monster_damage_proc or {}
--ͨ��SI_getgid_Object���ж�GID��Ӧ������һ��ǹ���
--return �µ��˺�ֵ������0��ʾ������������Ὣ�˺�����Ϊ���ֵ��
function SI_OnDamage(from_gid,dest_gid,damage)
	local obj_type = SI_getgid_Object(from_gid)
	if  obj_type == 1 then
		local sid = CI_GetPlayerData(17,1,from_gid)
		local rx,ry,rid,mapGID = CI_GetCurPos(2,sid)
		local func = _player_damage_proc[mapGID]
		if func then
			if not func(sid,dest_gid,damage) then 
				_player_damage_proc[mapGID] = nil
			end
		end
	elseif obj_type == 3 then
		local func = _monster_damage_proc[mapGID]
		if func then
			if not func(from_gid,dest_gid,damage) then 
				_monster_damage_proc[mapGID] = nil
			end
		end
	end
	return 0
end

function SI_RegPlayerDamageProc(mapGID,func)
	_player_damage_proc[mapGID] = func
end

function SI_RegMonsterDamageProc(mapGID,func)
	_monster_damage_proc[mapGID] = func
end