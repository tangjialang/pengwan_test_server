--[[
file:	Stong_Purify.lua
desc:	��ʯ����
author:	wk
update:	2013-4-28
refix:	done by wk
]]--
local tostring = tostring
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local equip_Purify1	 = msgh_s2c_def[23][11]	
local equip_addlight	 = msgh_s2c_def[23][12]	
local CI_AddBuff=CI_AddBuff
local CI_GetPlayerData,CI_SetPlayerData=CI_GetPlayerData,CI_SetPlayerData
local CheckGoods	 = CheckGoods
local look = look
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos

local maxlevel = 200
local needid=626 --�ʺ�ʯ
local needid_addlight=643 --����ʯ
local function GetDBPurifyData(playerid)
	local Purifydata=GI_GetPlayerData( playerid , 'puri' , 20 )
	if Purifydata == nil then return end
	if Purifydata.nexp==nil then 
		Purifydata.nexp=0
	end

	return Purifydata
end
-- --��ʼ��
-- function Purify_start(playerid)
-- look('��ʼ��')
	-- local Pdata=GetDBPurifyData(playerid)
	-- if Pdata and Pdata.nexp then
		-- local nexp=Pdata.nexp
		-- SendLuaMsg(0,{ids=equip_Purify1,nowexp=nexp},9)	
	-- end
-- end

--����
function stone_enhance(playerid,num)
	local Pdata=GetDBPurifyData(playerid)
	if Pdata and Pdata.nexp then
		local nexp=Pdata.nexp
		if not (CheckGoods(needid, num,1,playerid,'����') == 1) then
			return
		end
		local nowlv
		local get_exp=nexp+num
		local lvup_need
		nowlv=CI_GetPlayerData(29)--���ڵȼ�
		if nowlv>=maxlevel then return end
		repeat
			--look('����ѭ��',1)
			nowlv=CI_GetPlayerData(29)--���ڵȼ�
			if nowlv>=maxlevel then return end
			lvup_need=((nowlv or 0 )+1)*20
			if get_exp>=lvup_need then
				local a=CI_SetPlayerData(0,nowlv+1)
				if a ~=0 then return end
				nowlv=nowlv+1
				get_exp=get_exp-lvup_need
				if nowlv==10 then 
					set_obj_pos(playerid,3001)
				end
			end
		until get_exp<lvup_need or nowlv>=maxlevel
		Pdata.nexp=get_exp
		CheckGoods(needid, num,0,playerid,'����')
		SendLuaMsg(0,{ids=equip_Purify1,nowexp=get_exp,nowlv=nowlv},9)	

	end
end
--ȡ�����ȼ�
function purify_getlv( playerid)
	local Pdata=GetDBPurifyData(playerid)
	if Pdata==nil then return end
	return Pdata.nexp
end
-- ��������
function Weapon_addlight(playerid)
	if playerid==nil then return end
	local noweqlv=CI_GetPlayerData(1)
	if noweqlv<50 then 
		return
	end
	if not (CheckGoods(needid_addlight, 100,1,playerid,'��������') == 1) then
		return
	end
	local a=CI_AddBuff(126,0,1,false)
	if a then
		CheckGoods(needid_addlight, 100,0,playerid,'��������')
	end
	SendLuaMsg(0,{ids=equip_addlight},9)	
end