--[[
file:	player_xinfa.lua
desc:	�ķ��ھ�
author:	JKQ
update:	2013-1-6
]]--

--realxing
local xinfa_res   =  msgh_s2c_def[30][5]
local GI_GetPlayerData = GI_GetPlayerData
local SendLuaMsg = SendLuaMsg
local GetPlayerPointData = GetPlayerPointData
local TipCenter , GetStringMsg = TipCenter ,GetStringMsg
local AddPlayerPoints = AddPlayerPoints  
local mathfloor = math.floor  
local GetRWData = GetRWData
local PI_UpdateScriptAtt=PI_UpdateScriptAtt
local ScriptAttType = ScriptAttType
local GetPlayerPoints = GetPlayerPoints
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos
-----��ȡ����ķ�����
local function GetDBxinfaDate(playerid)
	local xinfaData = GI_GetPlayerData(playerid, 'xinfa',50)
	if nil == xinfaData then
		return 
	end
	--if xinfaData[1] == nil then 
		-- xinfaData[1] = 0	--��Ѫ�� �������㹫ʽ 50 + mathfloor(�ȼ���/9)*5
		-- xinfaData[3] = 0	--������ �������㹫ʽ mathfloor(15 + mathfloor(�ȼ���/14)*2.5)
		-- xinfaData[3] = 0	--������ �������㹫ʽ mathfloor(12 + mathfloor(�ȼ���/14)*2)	
		-- xinfaData[4] = 0	--������  4-8:��ʽ  10 + mathfloor(�ȼ���/14)*1
		-- xinfaData[5] = 0	--�ر���
		-- xinfaData[6] = 0	--������
		-- xinfaData[7] = 0	--������
		-- xinfaData[9] = 0	--����
	--end
	return xinfaData
end

local function GetneedLilianPoint(xlv)
	local needPoint = 500 + 23 * xlv
	return needPoint
end


local function  AddPlayeraAtt(lv,idx) -- ���Եĵȼ�  ��������(�����Ӧ���ԵĴ�С)
	local num 
	if  idx == 1 then
		num = 50 * lv + mathfloor( lv * (lv + 1)/2/9*5)
	elseif idx == 2 then
		num = 15 * lv + mathfloor( lv * (lv + 1)/2/14*2.5)
	elseif idx == 3 then
		num = 12 * lv + mathfloor(lv * (lv + 1)/2/14*2)
	else	
		num = 10 * lv + mathfloor(lv * (lv + 1)/2/14)
	end	
	return num  --�õȼ����ԵĴ�С
end


function AddRWAttvalue(playerid,itype)         --id   ���ӵ���ֵ���Ǳ�
	local xinfaData = GetDBxinfaDate(playerid)
	if xinfaData==nil then return end
	local AttTable =GetRWData(1)
	local t = 1
	for i=1,8 do 
		local tlv = xinfaData[i] or 0
			if i >= 2 then
				 t = i+1
			end
			AttTable[t] =  AddPlayeraAtt(tlv,i)
	end
	if itype then 
		PI_UpdateScriptAtt(playerid,ScriptAttType.jingmai)--  ���½ű����ӵ��������
	end
	return true
end

local function _xinfa_training(playerid) 		--�����ȼ� 
	local xinfaData = GetDBxinfaDate(playerid)
	if xinfaData == nil then
		return 
	end	
	--�жϸø����Ǹ���������
	local temp = xinfaData[1] or 0  --�������
	local last = xinfaData[8] or 0

	local goal
	if temp == 0 or last == temp then 
		goal = 1
	else	
		for i = 1,7 do
			local now = xinfaData[i] or 0
			local nnext = (xinfaData[i+1] or 0)
			if (now - nnext) == 1 then
				  goal = i + 1			--������������
				break
			end
		end
	end	
	if (xinfaData[goal] or 0) > 299 then
		return
	end	
	local lv = xinfaData[goal] or 0  		--	��ǰ���Եĵȼ�
	needLilianPoint = GetneedLilianPoint(lv)	--�������������ֵ
	--��ȡ��ҵ�����ֵ
	local playerLilianPoint = GetPlayerPoints(playerid,11)
	if needLilianPoint > playerLilianPoint  then--������ʾ����������
		TipCenter(GetStringMsg(459))
		return
	end
	xinfaData[goal]	= (xinfaData[goal] or 0) + 1     --�������Գɹ�
	--���Ӿ������������
	-- if  goal==8 and xinfaData[goal]==1 then
	-- 	set_obj_pos(playerid,1004)
	-- end
	AddRWAttvalue(playerid,1)
	AddPlayerPoints( playerid , 11 , -needLilianPoint ,nil,'�ķ��ھ�')	--�۳�����ֵ
	SendLuaMsg(0,{ids=xinfa_res,xinfaData=xinfaData,goal = goal},9)--������Ϣ
end
------------interface----------------

xinfa_training = _xinfa_training


-----------gm----
function xinfa_lvup( playerid ,index,num)
	-- look(1,1)
	local xinfaData = GetDBxinfaDate(playerid)
	if xinfaData == nil then
		return 
	end	
	for i=1,8 do 
		if i<=index then 
			xinfaData[i]=num
		else
			xinfaData[i]=num-1
		end
	end
	-- look(xinfaData,1)
	AddRWAttvalue(playerid,1)
	SendLuaMsg(0,{ids=xinfa_res,xinfaData=xinfaData,goal=index},9)
end
