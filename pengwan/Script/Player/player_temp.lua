--[[
file:	player_temp.lua
desc:	common temp proc
author:	csj
update:	2013-7-3
]]--

--------------------------------------------------------------------------
--include:
local type = type
local CI_GetCurPos,ClrEvent = CI_GetCurPos,ClrEvent
local GI_GetPlayerTemp = GI_GetPlayerTemp
local mathrandom = math.random
local define		 = require('Script.cext.define')
local Define_POS 	= define.Define_POS

--------------------------------------------------------------------------
--interface:
-- ������ҽ��붯̬����֮ǰ��λ��
function GI_SetPlayerPrePos(sid,rid,x,y)
	local prePos = GI_GetPlayerTemp(sid,'pPos')
	if prePos == nil then return end
	
	if rid == nil and x == nil and y == nil then
		local x,y,rid,mapGID = CI_GetCurPos(2,sid)
		if mapGID then return end
		prePos[1] = rid
		prePos[2] = x
		prePos[3] = y
	else
		prePos[1] = rid
		prePos[2] = x
		prePos[3] = y
	end
end

-- �˳���֮ǰ��¼��λ��
function GI_ExitToPrePos(sid)
	local prePos = GI_GetPlayerTemp(sid,'pPos')
	local rx, ry, rid, mapGID = CI_GetCurPos(2,sid)
	if rid == 1016 then
		prePos[1] = 3
		prePos[2] = 100
		prePos[3] = 159
	end
	--look(prePos)
	if prePos == nil or type(prePos) ~= type({}) or #prePos < 3 or not PI_MovePlayer(prePos[1],prePos[2],prePos[3],nil,2,sid) then 
		local num = mathrandom(1,#Define_POS)
		PI_MovePlayer(Define_POS[num][1],Define_POS[num][2],Define_POS[num][3],nil,2,sid)
	end

	-- �����¼
	prePos[1] = nil
	prePos[2] = nil
	prePos[3] = nil
end

-----------------------------------------[��̬��������ʱ]------------------------------------

-- cTimer: [nil] ���֮ǰ��¼��timer [~nil] ���֮ǰ��¼��timer and ����cTimerΪ��ǰtimer
function GI_SetPlayerTimer(sid,cTimer,bTimeOut)
	local prePos = GI_GetPlayerTemp(sid,'pPos')
	if prePos == nil then return end
	if cTimer then 			-- �����¼�ʱ��
		if prePos[4] then	-- ���֮ǰ�м�ʱ��û�����(���ܻ�������)
			look("GI_SetPlayerTimer pre_timer not clear")
		end
		prePos[4] = cTimer
	else					-- ���֮ǰ�ļ�ʱ��
		if prePos[4] then
			if not bTimeOut then
				ClrEvent(prePos[4])
			end
			prePos[4] = nil
		end
	end	
end