--[[
file: monster_dead.lua
desc: deadscript proc
]]--
--------------------------------------------------------
-- include:
local type = type
local look = look
local GetPlayerDayData = GetPlayerDayData
local xtg = require("Script.CopyScene.xtg")		-- �����
local refresh_xtg_player_data = xtg.refresh_xtg_player_data
--------------------------------------------------------
-- inner:

-- �������������
local _call_monster_dead = noassign{
	-- [deadscriptid] = function () ... end
}

-- �����������������
local _cs_monster_dead = noassign{
}

local _monster_kill_award = noassign{
}

--------------------------------------------------------
--interface:
local function InitMonsNum(MonDeadEvent,num)
	if MonDeadEvent == nil or num == nil then return end
	
	MonDeadEvent.num = num
end

-- ��������������Ļص�����
function SI_OnMonsterDead( param, regionID, deadScriptID, copySceneGID, mon_name, take_exp )
	if param == nil or (param ~= 0 and param ~= 1) then
		return
	end
	if param == 0 and deadScriptID > 10000 then
		return
	end
	if param == 1 and deadScriptID <= 10000 then
		return
	end
	if param == 0 then
		OnTaskKillMonster(mon_name)			-- ����ִ���
		HeroAddExp(take_exp)					-- ����ӼӾ���
	end	
	if copySceneGID == 0 then		
		local func = _call_monster_dead[deadScriptID]
		if type(func) == 'function' then
			func( regionID )
		end
	else
		-- look('SI_OnMonsterDead fb deadScriptID:' .. deadScriptID)
		local copyScene = CS_GetTemp(copySceneGID)
		if copyScene == nil then
			look("SI_OnMonsterDead" .. deadScriptID)
			return
		end
		
		local fbID = copyScene.fbID
		local mainID ,subID = GetSubID(fbID)
		local csEventTb = FBConfig[mainID][subID].EventList
		-- �����������������¼�
		local func = _cs_monster_dead[deadScriptID]
		if type(func) == 'function' then
			func( regionID, copySceneGID )
		end
		
		-- �������������¼�
		if copyScene.TraceList ~= nil and copyScene.TraceList.MonDeads ~= nil then
			local MonDeadEvent = copyScene.TraceList.MonDeads[deadScriptID]
			-- look("deadScriptID:" .. deadScriptID )
			-- look("MonDeadEvent.num = " .. tostring(MonDeadEvent.num))
			if MonDeadEvent ~= nil and  MonDeadEvent.num ~= nil and MonDeadEvent.num ~= 0 then
				MonDeadEvent.num = MonDeadEvent.num - 1			
				-- look("MonDeadEvent.num = " .. tostring(MonDeadEvent.num))
				-- ����������������
				if fbID >= 24001 and fbID < 25000 then
					local sid = CI_GetPlayerData(17)
					refresh_xtg_player_data(sid)
				end
				if MonDeadEvent.num == 0 and csEventTb.MonDeads[deadScriptID].EventTb then		-- ������㴥������ ����������һ��������					
					look("ˢ�¹����������")
					if fbID >= 24001 and fbID < 25000 then
						GetCSMonstrtNum = GetCSMonstrtNum or __G.GetCSMonstrtNum
						local num = GetCSMonstrtNum(fbID)
						InitMonsNum(MonDeadEvent,num)
					end
					CS_EventProc(copySceneGID,csEventTb.MonDeads[deadScriptID].EventTb)
				end						
				CS_SendTraceInfo( copyScene, TraceTypeTb.MonDeads, {deadScriptID,MonDeadEvent.num} )		--����׷����Ϣ
			end
		end		
	end	
end

-- boss���˺�������(�ص��ű�����)
-- Ŀǰ��ControlID������ ������������ظ�
function SI_OnBossKillAwards(sid,dmgval,dmgper)
	--look('SI_OnBossKillAwards:' .. tostring(sid) .. '___' .. tostring(dmgval),1)
	local _,ControlID = GetObjectUniqueId()
	if ControlID == nil then return end
	local func = _monster_kill_award[ControlID]
	
	if type(func) == 'function' then
		func( sid, dmgval, dmgper )
	end
end


------------------------��������������������װ��------------------
------------------------��������������������װ��------------------
------------------------��������������������װ��------------------
------------------------��������������������װ��------------------
------------------------��������������������װ��------------------
------------------------��������������������װ��------------------
--[[
	�񴴶�Ϊϴ��4��λ��Ϊ��������
]]
local dead_drop_eqconf=dead_drop_equipconf
local dead_drop_attconf=dead_drop_attconf
local common_rnd = require('Script.common.random_norepeat')
local Get_num 			 = common_rnd.Get_num
local mathrandom=math.random

local detailEquip ={index =0 ,qualitys={},}
local atttable={}

local function _get_detaildata( id ,color)

	for i=1,5  do--��������
		detailEquip.qualitys[i]=nil
		atttable[i]=nil
	end

	detailEquip.index = id
	if color~=0 then --��ɫû������
		local endnum=dead_drop_attconf[color].num
		local atttype=Get_num(atttable,endnum,{2,13})--��Ҫ1,13������
		local minivalue,maxvalue,endvalue,atype
		for i=1,endnum do
			atype=atttype[i]
			if atype==13 then 
				atype=14
			end
			minivalue=dead_drop_attconf[color][atype][1]
			maxvalue=dead_drop_attconf[color][atype][2]
			endvalue=mathrandom(minivalue,maxvalue)

			detailEquip.qualitys[i]=(atype-1)*10000+endvalue
		end
	end
	local data = GenerateItemDetails(detailEquip)
	-- look(data,1)
	return data
end
local function _dead_equip( deadid, copySceneGID ,regionID)
	-- look('����.����',1)
	-- look(deadid,1)
	-- look(regionID,1)
	-- look(copySceneGID,1)
	

	if dead_drop_eqconf[deadid]==nil then return end
	--if  (GetMonsterData(30,3) or 0)<1 then return end--����boss
	local rannum=mathrandom(1,10000)
	local probability=dead_drop_eqconf[deadid].gl

	if rannum>probability then return end --δ����
	local get_equip=dead_drop_eqconf[deadid].goods[mathrandom(1,#dead_drop_eqconf[deadid].goods)]

	local data=_get_detaildata(get_equip[1],get_equip[2])
	if copySceneGID and  copySceneGID>0 then 
		regionID=copySceneGID
	end
	local cx, cy, rid,isdy = CI_GetCurPos(3)--��ǰ��
	local res=ModifyItem(data,'G','boss����'..tostring(deadid),{regionId=regionID,x=cx,y=cy})
end

---�������ù�������id
for k,v in pairs(dead_drop_eqconf) do
	if type(k)==type(0) and type(v)==type({}) then 
		-- ----look(k,1)
		_call_monster_dead[k]=function (regionID, copySceneGID )
			_dead_equip(k, regionID, copySceneGID )
		end

		_cs_monster_dead[k]=function (regionID, copySceneGID )
			_dead_equip(k, regionID, copySceneGID )
		end
	end
end


------------------------��������������������װ��------------------
------------------------��������������������װ��------------------
------------------------��������������������װ��------------------
------------------------��������������������װ��------------------




call_monster_dead = _call_monster_dead
cs_monster_dead = _cs_monster_dead
monster_kill_award = _monster_kill_award