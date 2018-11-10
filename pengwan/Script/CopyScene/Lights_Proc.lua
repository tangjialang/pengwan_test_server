--[[
file: Lights_Proc.lua
desc: ��Ȧ����
autor: csj
]]--

local FBConfig = FBConfig
local RPCEx = RPCEx
local TeamRPC = TeamRPC

-- �ȹ�Ȧ(Ŀǰֻ֧��һ����ͼһ���Ȧ)
-- ��̨��ʱ���ж��Ƿ��ڹ�Ȧ��
function CS_StepLights(sid,inout,idx,round,x,y)
look(inout)
look(idx)
look(round)
	if sid == nil or idx == nil or round == nil or inout == nil then return end
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp == nil or pCSTemp.CopySceneGID == nil then return end
	local copyScene = CS_GetTemp(pCSTemp.CopySceneGID)
	if copyScene == nil then return end
	local mSerialNum = pCSTemp.mSerialNum
	local fbID = copyScene.fbID
	local mainID,subID = GetSubID(fbID)
	if FBConfig[mainID] == nil or FBConfig[mainID][subID] == nil then
		return
	end
	look('CS_StepLights 1')
	local csEventTb = FBConfig[mainID][subID].EventList
	if csEventTb == nil then return end
	if csEventTb.Lights == nil or csEventTb.Lights[idx] == nil then return end
	look('CS_StepLights 2')
	look(mainID)
	look(subID)
	look(mSerialNum)
	local MapInfo = FBConfig[mainID][subID].MapList[mSerialNum]
	if MapInfo == nil or MapInfo.LightRound == nil then return end
	local t = MapInfo.LightRound
	if t[round] == nil then return end
	local plist = copyScene.PlayerSIDList
	if plist == nil then return end
	look('CS_StepLights 3')
	-- �ȹ�Ȧ����
	look(copyScene.TraceList)
	if copyScene.TraceList ~= nil and copyScene.TraceList.Lights ~= nil then
		local LightsInfo = copyScene.TraceList.Lights[idx]
		if LightsInfo ~= nil and LightsInfo.num ~= nil then
			if inout == 1 then		-- �����Ȧ
				if LightsInfo[round] then		
					RPC('step_lights',1)		-- �Ѿ����˲���
					return
				end				
				LightsInfo[round] = sid
				LightsInfo.num = LightsInfo.num - 1
			else					-- �뿪��Ȧ
				if LightsInfo[round] and LightsInfo[round] == sid then
					LightsInfo.num = LightsInfo.num + 1
					LightsInfo[round] = nil
				end
			end
			-- ��ֻ֤�ܱ�����һ��
			if LightsInfo.num <= 0 and LightsInfo.triged == nil then
				-- �����ж���ɫ�Ƿ���ȷ
				local correct = true
				local count = #t
				for i = 1, count do
					if LightsInfo[i] == nil then
						correct = false
						break
					end					
					local pid = LightsInfo[i]
					local pt = CS_GetPlayerTemp(pid)
					if pt == nil then
						correct = false
						break
					end
					if t[i][6] and (plist[pid] == nil or t[i][6] ~= plist[pid]) then
						correct = false
						break
					end
				end
				if correct then
					CS_EventProc(pCSTemp.CopySceneGID,csEventTb.Lights[idx].EventTb)
					LightsInfo.triged = 1
				end
			end
			look('CS_StepLights 3333')
			look(LightsInfo)
			CS_SendTraceInfo( copyScene, TraceTypeTb.LightState, LightsInfo ) --����׷����Ϣ
		end
	end
end