--[[
file:	player_menu_op.lua
desc:	all client menu op request.
author:	
update:	2013-06-01
refix: done by chal
]]--
local type = type
local RegionTable = RegionTable
local RPC,GetPlayer = RPC,GetPlayer
local CI_GetCurPos = CI_GetCurPos
local CI_GetPlayerData = CI_GetPlayerData
local CI_SetPlayerData = CI_SetPlayerData
local shq_m = require('Script.ShenQi.shenqi_func')
local GetPlayerShenQiData = shq_m.GetPlayerShenQiData
local zhanli_bipin = msgh_s2c_def[3][23]

-- �鿴������Ϣ
function GI_ViewOtherInfo(sid,other,iType)
	if type(other) == type(0) then		-- sid
		if IsPlayerOnline(other) then
			local pName = CI_GetPlayerData(5,2,other)
			local MLData = ML_GetPlayerData(other)				-- ����
			local CJ = GetPlayerPoints(other,1) or 0		-- �ɾ�
			local ZG = GetPlayerPoints(other,6) or 0		-- ս��
			local pManorData = GetManorData_Interf(other)	-- ׯ԰
			local mdata=GetPlayerMarryData(other) --��ָ
			local rdata = GetPlayerShenQiData(other)			-- ���
			RPC("ViewOhter",other,iType,MLData.zml or 0,CJ,ZG,pManorData.mLv or 0,pName,mdata[3],rdata)
		end
	elseif type(other) == type("") then -- name
		local playerid = GetPlayer(other)
		if playerid then
			local MLData = ML_GetPlayerData(playerid)					-- ����
			local CJ = GetPlayerPoints(playerid,1) or 0			-- �ɾ�
			local ZG = GetPlayerPoints(playerid,6) or 0 		-- ս��
			local pManorData = GetManorData_Interf(playerid)	-- ׯ԰
			local mdata=GetPlayerMarryData(playerid) --��ָ
			local rdata = GetPlayerShenQiData(playerid)			-- ���
			RPC("ViewOhter",other,iType,MLData.zml or 0,CJ,ZG,pManorData.mLv or 0,nil,mdata[3],rdata)
		end
	end
end

function SetPlayerPKMode(sid,mode)
	if type(sid) ~= type(0) or type(mode) ~= type(0) then
		return
	end
	local level = CI_GetPlayerData(1,2,sid)
	if level < 30 then
		RPC('player_setpk',1)
		return
	end
	local _,_,rid = CI_GetCurPos(2,sid)
	if RegionTable[rid] == nil then
		return
	end
	local mapPK = RegionTable[rid].PKType or 1
	if mapPK == 1 and mode ~= 0xff then		-- ��PK������Ҳ�������Ϊ�Ǻ�ƽģʽ������PKģʽ
		--RPC('player_setpk',2)
		return
	end
	if mode ~= 0xff then	-- ����л����Ǻ�ƽģʽʱ�Ƴ�����buff
		CI_DelBuff(242,2,sid)
	end
	CI_SetPlayerData(4,mode,2,sid)
	RPC('player_setpk',0,mode)
end

function  fightcompare(sname)
	local horse = 5  		--����5
	local weapon = 6 		--���6
	local god = 7    		--������7
	local amulet = 8 		--�ػ�ͨ��8
	local goddess = 10 		--Ů��10
	local hero = 11   	 	--�ҽ�11
	local wing = 13  	  	--����13
	
	SendLuaMsg( 0, {ids = zhanli_bipin,[5] = horse,[6] = weapon,[7] = god,[8] = amulet,
							[10] = goddess,[11] = hero,[13] = wing},9 )
end

--����360ѫ��
function  shenqi_stamp_visible(playerid,val)
	local srcIcon = CI_GetPlayerIcon(3,4)
	srcIcon = bits.set(srcIcon,4,4,val)
	CI_SetPlayerIcon(3,4,srcIcon)
end