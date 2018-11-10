--[[
file:	playerMeLi.lua
desc:	�������ֵ �� ���а�
author:	
update:	2012-07-25
]]--
local ML_ScoreList = msgh_s2c_def[3][9]
local ML_Award = msgh_s2c_def[3][10]
local CI_GetPlayerData = CI_GetPlayerData
local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist = sclist_m.insert_scorelist
local RPCEx=RPCEx

-- �������ֵ
function ML_GetPlayerData(playerid)
	local dayData = GetPlayerDayData(playerid)
	if dayData == nil then return end
	if dayData.meili == nil then
		dayData.meili = {
			val = nil,			-- ���������ֵ			
			zml = nil,			-- ������ֵ
		}
	end
	return dayData.meili
end

-- ��������ֵ �������а�
function AddMeiLiValue(sid,value)
	local p_MLData = ML_GetPlayerData(sid)
	if p_MLData == nil then return end
	p_MLData.val = (p_MLData.val or 0) + value
	p_MLData.zml = (p_MLData.zml or 0) + value
	local pName = CI_GetPlayerData(5,2,sid)
	local school = CI_GetPlayerData(2,2,sid)
	-- �������а�
	insert_scorelist(2,5,10,p_MLData.zml,pName,school,sid)
	RPCEx(sid,'meili',p_MLData.zml)
end

-- ÿ�����������ֵ
function ClearMeiLiValue(sid)
	look('ClearMeiLiValue')
	local p_MLData = ML_GetPlayerData(sid)
	if p_MLData == nil then return end
	p_MLData.zml = 0
	RPCEx(sid,'meili',0)
	look('ClearMeiLiValue over')
end
