--[[
file: ׯ԰�Ӷ�
]]--

-------------------------------------------------------------
--include:
local pairs,type,tostring,ipairs,rint = pairs,type,tostring,ipairs,rint
local CI_GetPlayerBaseData,SendLuaMsg = CI_GetPlayerBaseData,SendLuaMsg
local CI_OnSelectRelive,GetServerTime = CI_OnSelectRelive,GetServerTime
local CI_GetFactionInfo,LockPlayer = CI_GetFactionInfo,LockPlayer
local CI_GetPlayerData,PI_PayPlayer = CI_GetPlayerData,PI_PayPlayer
local tablelocate = table.locate
--local --look = --look
local RPCEx = RPCEx
local DegreeConfig = DegreeConfig
local robmailconf = MailConfig.RobMail
local call_monster_dead = call_monster_dead
local active_mgr_m = require('Script.active.active_mgr')
local active_marobb = active_mgr_m.active_marobb

--s2c_msg_def
local MRB_Times = msgh_s2c_def[35][1]	-- ʣ�����
local MRB_Data = msgh_s2c_def[35][2]	-- ׯ԰�Ӷ��б�����
local MRB_Enter = msgh_s2c_def[35][3]	-- �����Ӷ�
local MRB_Detl = msgh_s2c_def[35][4]	-- ׯ԰�Ӷ�������ϸ��Ϣ
local MRB_Show = msgh_s2c_def[35][5]	-- �鿴ս����
local MRB_Rept = msgh_s2c_def[35][6] 	-- ս��

local MAXTIMES = 30
local mapID = 2001
local _MinLV = 42
local PerPage_C = 12		-- ÿһҳ����

---------------------------------------------------------------
--data:

-- ͵Ϯ{���֣��ȼ���vip�����id��ս������ͷ��} --ͨ����/ׯ԰���
-- { ���֣��ȼ���vip�����ͣ����������id��ս������ͷ��}��	
-- [ pId, serverName, vipType, �ǳ��ز�ID, (ͨ����), || pID, Lv��(�����)��ս����, ͷ��ID, (����ʱ��) ]
local cachelist = {
	{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},
	{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},
	{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},
}

local SIDlist = {0,0,0,0,0,0,0,0,0,0,0,0}		-- SID�б� Ŀǰ֧��12��
local details = {0,0,0,0,0,0}					-- ��ϸ��Ϣ

-- �Ӷά����ʱ��
local gAward = {0,0,0}
local sAward = {0,0}
-- local ItemList = {}

---------------------------------------------------------------
--inner function:

-- �Ƿ��һ�δ��Ӷ�
local function MRB_IsFirst(sid)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	if pManorData.bFst == nil or rint(pManorData.bFst/2) % 2 == 0 then
		return true
	end
end

--[[
	@return:
		result ���ص�ǰҳ��sid�б�
		cPage  ���ص�ǰҳ
		tPage  ������ҳ��
	--  ���ε���ͬ����û�йܵ����
]]--
local function GetPageInfo(RobList,lv,sel,sid,result,index)
	local lower = _MinLV
	if lv - 5 > _MinLV then
		lower = lv - 5
	end
	local idx = index or 1
	local higher = lv + 5	
	local total = 0
	local left = PerPage_C
	local have = 0
	local cPage = nil	
	local tc = nil
	-- local my_fid = PI_GetPlayerFacID(sid)
	for i = lower, higher do		
		if sel == nil then
			if lv == i then		-- ����ǵ�ǰ�ȼ�ҳ
				if i == lower then
					cPage = 1
					for tc = 1, PerPage_C - have do
						if RobList[i] and RobList[i][tc] and RobList[i][tc] ~= sid then
							local pid = RobList[i][tc]						   
							if IsPlayerTSD(pid) then
								result[idx] = pid
								idx = idx + 1								
								left = left - 1
							else
								total = total - 1								
							end
						end
					end
				else
					cPage = rint(total / PerPage_C) + 1
					return GetPageInfo(RobList,lv,cPage,sid,result,idx)
				end		
			elseif i > lv and left > 0 then
				for tc = 1, PerPage_C - have do
					if RobList[i] and RobList[i][tc] and RobList[i][tc] ~= sid then
						local pid = RobList[i][tc]						
						if IsPlayerTSD(pid) then
							result[idx] = pid
							idx = idx + 1
							left = left - 1
						else
							total = total - 1
						end
					end
				end
			end
			have = PerPage_C - left
		else
			if RobList[i] then
				cPage = rint(total / PerPage_C) + 1
				if cPage < sel and i == higher then
					total = total + #RobList[i]	
					cPage = rint(total / PerPage_C) + 1
				end			
				if cPage >= sel and left > 0 then
					if sel == 1 then
						cPage = 1
						for tc = 1, PerPage_C - have do
							if RobList[i] and RobList[i][tc] and RobList[i][tc] ~= sid then
								local pid = RobList[i][tc]								
								if IsPlayerTSD(pid) then
									result[idx] = pid
									idx = idx + 1
									left = left - 1
								else
									total = total - 1
								end
							end
						end
					else
						tc = total - (sel - 1) * PerPage_C
						if RobList[i - 1] then
							if #RobList[i - 1] - tc > 0 then
								tc = #RobList[i - 1] - tc + 1
								for _ = 1, PerPage_C - have do
									if RobList[i - 1] and RobList[i - 1][tc] and RobList[i - 1][tc] ~= sid then
										local pid = RobList[i - 1][tc]										
										if IsPlayerTSD(pid) then
							            	result[idx] = pid
											idx = idx + 1
											tc = tc + 1
											left = left - 1
										else
											total = total - 1
										end
									end
								end
							else
								for tc = 1, PerPage_C - have do
									if RobList[i - 1] and RobList[i - 1][tc] and RobList[i - 1][tc] ~= sid then
										local pid = RobList[i - 1][tc]										
										if IsPlayerTSD(pid) then
							            	result[idx] = pid
											idx = idx + 1
											left = left - 1
										else
											total = total - 1
										end
									end
								end
							end
						end
					end
				end
				cPage = sel
				have = PerPage_C - left
			end
		end
		
		if i ~= higher and RobList[i] and type(RobList[i]) == type({}) then
			total = total + #RobList[i]
		end
	end
	--look('total:' .. tostring(total))
	if total > 1 then total = total - 1 end				-- ȥ���Լ�
	local tPage = rint((total - 1) / PerPage_C) + 1
	
	return cPage,tPage
end
		
-- �����б���Ϣ
-- flags��־: [0] ������  [1] ������ [2] ͬ��� [3] ������ & ͬ���
local function MRB_BuildList(sid,result)
	-- ����������
	for i=1 ,#(cachelist) do
		if type(cachelist[i]) == type({}) then
			for j = 1, #cachelist[i] do
				cachelist[i][j] = 0
			end
		end
	end 	
	local my_fid = CI_GetPlayerData(23,2,sid) or 0
	local now = GetServerTime()
	for k, pid in ipairs(result) do
		if pid ~= nil and pid ~= 0 then
			--look('--------------------')
			--look(pid)
			local pManorData = GetManorData_Interf(pid)
			local pZSData = PI_GetCurGarniture(pid)
			if pManorData ~= nil and pZSData and pZSData[1] then							
				local bgID = pZSData[1]	-- ȡ������ԴID
				local fac_id = PI_GetPlayerFacID(pid) or 0
				local rbPT = pManorData.rbPT or 0
				local flags = 0
				if fac_id > 0 and my_fid > 0 and fac_id == my_fid then
					flags = flags + 2
				end
				if now < rbPT then
					flags = flags + 1
				end
				if IsPlayerOnline(pid) == true then
					local pBaseData = CI_GetPlayerBaseData(pid, 1)
					cachelist[k][1] = pid
					cachelist[k][2] = pBaseData[1]
					cachelist[k][3] = pBaseData[3]
					cachelist[k][4] = bgID
					cachelist[k][5] = pManorData.Degr
					cachelist[k][6] = flags
				else
					local pTBData = PI_GetTsBaseData(pid)
					if type(pTBData) == type({}) then 					
						cachelist[k][1] = pid
						cachelist[k][2] = pTBData[1]
						cachelist[k][3] = pTBData[3]
						cachelist[k][4] = bgID
						cachelist[k][5] = pManorData.Degr
						cachelist[k][6] = flags
					end					
				end
			end
		end
	end
	
	return cachelist
end

-- ��ȡս���ӳɸ���
local function GetZGRate(sid)
	local pMaData = GetManorData_Interf(sid)
	if pMaData == nil then return 1 end
	if DegreeConfig == nil then return 1 end	
	local degree = pMaData.Degr or 1
	
	local pos = tablelocate(DegreeConfig,degree,2)
	if pos == nil then return 1 end
	if DegreeConfig[pos] then
		return DegreeConfig[pos].swRadio or 1
	end
	return 1
end

-- ��ȡѫ�¼ӳ�(����)
local function GetXZRate(sid)
	local pMaData = GetManorData_Interf(sid)
	if pMaData == nil then return end
	if DegreeConfig == nil then return end	
	local degree = pMaData.Degr or 1
	
	local pos = tablelocate(DegreeConfig,degree,2)
	if pos == nil then return 0 end
	if DegreeConfig[pos] then
		return DegreeConfig[pos].nXZ or 0
	end
end

-- ��ȡ���ӱ���ʱ��
local function GetProTime(sid)
	local pMaData = GetManorData_Interf(sid)
	if pMaData == nil then return end	
	if DegreeConfig == nil then return end
	local degree = pMaData.Degr or 0
	
	local pos = tablelocate(DegreeConfig,degree,2)
	if pos == nil then return end
	if DegreeConfig[pos] then
		return DegreeConfig[pos].porT
	end
end

-- ׯ԰�Ӷ�ս��
-- Res [0] ����ʧ�� [1] ����ʤ��
local function MRB_Report(Res,gSID,gAward,sSID,sAward) 
	local tsData = PI_GetTsBaseData(sSID)
	-- --look(tsData)
	SendLuaMsg( gSID, { ids = MRB_Rept,Res = Res,gAward = gAward,sSID = sSID}, 10 )
	-- ���ط���ս���ʼ�
	if not MRB_IsFirst(gSID) then
		local sLv = PI_GetPlayerLevel(sSID)
		if sLv == nil or sLv < 43 then		-- 43�����²����ʼ�
			return
		end
		local tgData = PI_GetTsBaseData(gSID)
		-- --look(gAward)
		local Contents = {Res = Res,gSID = gSID,sAward = sAward,tsData = tsData,gAward = gAward,tgData = tgData}
		SendSystemMail(sSID,robmailconf,1,15,Contents)
		
		-- ��Ҫ�ӵ��Ĺ㲥���
		local Dfacid = PI_GetPlayerFacID(sSID)
		if Dfacid and Dfacid > 0 then
			local factemp = GetFactionTempData(Dfacid)
			factemp.rep = factemp.rep or {}
			table.push(factemp.rep,{res,tgData[1],tsData[1]},10)
		end
		
	else
		PI_SetManorFirst(gSID,2)
	end
end

-- �������ͳһ����
local function MRB_ResultProc(sid,othersid,res)
	for i = 1,#gAward do
		gAward[i] = 0
	end
	for i = 1,#sAward do
		sAward[i] = 0
	end

	local loseMon = 0
	local loseZG = 0
	local realMon,addZG,addXZ,bg = 0,0,0,0
	local otherLV = PI_GetPlayerLevel(othersid) or 0
	-- ���������������
	local rett = CI_OnSelectRelive(0,3*5,2,sid)
	if res == 0 then			
		-- ʧ��ֻ��ս��ֵ
		addZG = 15
		AddPosFeats(sid,addZG)				
		
		-- ����ս��
		gAward[1] = realMon
		gAward[2] = addZG
		sAward[1] = loseMon
		sAward[2] = loseZG
	elseif res == 1 then		
		if MRB_IsFirst(sid) then
			loseMon = 10000
			realMon = 10000
			addZG = 50
		else
			local selfMaData = GetManorData_Interf(sid)
			if selfMaData == nil then return end
			local otherMaData = GetManorData_Interf(othersid)
			if otherMaData == nil then return end
			-- ���ͭǮ	
			loseMon = GD_SetMoneyTree(othersid,-1,10)	-- �۵�ǰ������10% ����ʵ�ʿ�Ǯ				
			realMon = loseMon or 0
			local lv = CI_GetPlayerData(1,2,sid)
			if lv == nil or lv <= 0 then return end
			if realMon < rint(lv * 100) then		-- ��������
				realMon = lv * 100
			end
			-- ���ս�� 
			addZG = rint(otherLV * GetZGRate(othersid) * 1.5)	
			
			-- ����ǵж԰���Ա���Ӱﹱ			
			if isEnemyFaction(sid,othersid) then
				bg = rint(otherLV / 5)				
			end
									
			-- �Է�ʧ���� ���ս������6�����ս��			
			local curZG = PI_GetPlayerZG(othersid)
			local pos = GetPos(curZG) or 0
			-- if pos >= 6 then
				-- loseZG = (pos - 4) * 5				
			-- end
			-- �Է�ʧ���� ���¶Է��ı���ʱ��
			local porT = GetProTime(othersid)
			local now = GetServerTime()
			if otherMaData.rbPT and otherMaData.rbPT > now then
				otherMaData.rbPT = otherMaData.rbPT + (porT or 600)	-- Ĭ�ϸ�10����
			else
				otherMaData.rbPT = now + (porT or 600)				-- Ĭ�ϸ�10����
			end
			-- ����ͨ����
			if selfMaData.Degr == nil or selfMaData.Degr < 0 then
				selfMaData.Degr = 1
			else
				selfMaData.Degr = selfMaData.Degr + 1
			end
			otherMaData.Degr = (otherMaData.Degr or 0) - 1
		end
		
		-- ������
		-- addXZ = rint(otherLV/10) + GetXZRate(othersid)
		-- ItemList[1] = {1052,addXZ,1}
		-- PI_GiveGoodsEx(sid,robmailconf,2,2,addXZ,ItemList,nil,"�Ӷ��ѫ��")		-- ѫ��
		GiveGoods(0,realMon,1,"�Ӷ���ͭǮ")		-- ��ͭǮ
		AddPosFeats(sid,addZG)							-- ��ս��
		AddPlayerPoints(sid,4,bg,nil,'ׯ԰�Ӷ�')						-- �Ӱﹱ
		PI_GiveGoodsEx(sid,robmailconf,2,2,nil,{{691,1,1},},nil,'ׯ԰�Ӷ�')	-- ��ױ��
		-- �Է���ս��
		PI_AddPlayerZG(othersid, 0 - loseZG)
		
		-- ����ս��
		gAward[1] = realMon
		gAward[2] = addZG
		gAward[3] = bg
		sAward[1] = loseMon
		sAward[2] = loseZG
		
	end
	-- ��������
	MRB_ClearTemp(sid)
	
	MRB_Report(res,sid,gAward,othersid,sAward)		
end

-- ʤ��
local function MRB_Win(sid)	
	--look("MRB_Win:" .. sid)
	local pManorTemp = GetPlayerManorTemp(sid)
	if pManorTemp == nil or pManorTemp.mrbName == nil or pManorTemp.mrbSID == nil then
		MRB_ClearTemp(sid)
		return 
	end	

	local othersid = pManorTemp.mrbSID
	local robList = GetManorRobberyList()
	if robList == nil then
		--look("MRB_Win:1")
		MRB_ClearTemp(sid)
		return 
	end	
	local selfMaData = GetManorData_Interf(sid)
	if selfMaData == nil then 
		--look("MRB_Win:2")
		MRB_ClearTemp(sid)
		return 
	end
	local otherMaData = GetManorData_Interf(othersid)
	if otherMaData == nil then 
		--look("MRB_Win:3")
		MRB_ClearTemp(sid)
		return 
	end
	-- �������
	MRB_ResultProc(sid,othersid,1)
end

-- ʧ��
local function MRB_Lose(sid,iType)	
	--look("MRB_Lose:" .. sid)
	local pManorTemp = GetPlayerManorTemp(sid)
	----look(pManorTemp)
	if pManorTemp == nil or pManorTemp.mrbName == nil or pManorTemp.mrbSID == nil then
		--look("MRB_Lose1:" .. sid)
		MRB_ClearTemp(sid)
		return 
	end	

	local othersid = pManorTemp.mrbSID
	local robList = GetManorRobberyList()
	if robList == nil then
		--look("MRB_Lose2:" .. sid)
		MRB_ClearTemp(sid)
		return 
	end	
	local selfMaData = GetManorData_Interf(sid)
	if selfMaData == nil then 
		--look("MRB_Lose3:" .. sid)
		MRB_ClearTemp(sid)
		return 
	end
	local otherMaData = GetManorData_Interf(othersid)
	if otherMaData == nil then 
		--look("MRB_Lose4:" .. sid)
		MRB_ClearTemp(sid)
		return 
	end
	-- �������
	MRB_ResultProc(sid,othersid,0)
end

------------------------------------------------------------
--interface:

function MRB_GetTempData()
	local w_custmpdata = GetWorldCustomTempDB()
	if w_custmpdata == nil then
		return
	end
	if w_custmpdata.MRBData == nil then
		w_custmpdata.MRBData = {			
		}
	end
	return w_custmpdata.MRBData
end

-- ��ע
function MRB_Attention(sid,othersid)
	if sid == nil or othersid == nil or sid == othersid then return end
	if othersid == 1001 then return end		-- ���⴦������ ���ܹ�ע
	local ret
	if IsPlayerOnline(othersid) then
		ret = CI_AddEnemy(othersid)
	else		
		local headID = PI_GetPlayerHeadID(othersid)
		local pName = PI_GetPlayerName(othersid)
		local school = 0
		local Level = PI_GetPlayerLevel(othersid)
		ret = CI_AddEnemy(othersid,headID,pName,school,Level)
	end	
end

-- ����Ӷ��б�(�ȼ�����)
function MRB_PushList(sid,newLV,oldLV)	
	if sid == nil or newLV == nil or oldLV == nil then
		--look('MRB_PushList erro param', 1)
		return
	end
	local pManorData = GetManorData_Interf(sid)	
	if pManorData == nil then
		--look('MRB_PushList pManorData erro', 1)
		return
	end
	local roblist = GetManorRobberyList()
	if roblist == nil then return end
	if roblist[newLV] == nil then
		roblist[newLV] = {}
	end

	if roblist[oldLV] then
		for k, v in ipairs(roblist[oldLV]) do	-- �Ӿɵĵȼ���������Ҳ�remove
			if v == sid then
				table.remove(roblist[oldLV],k)
				break
			end
		end
	end
	
	table.push(roblist[newLV],sid)

	-- local rbPS = pManorData.rbPS
	-- if rbPS == nil then		
		-- table.push(roblist[newLV],sid)
		-- pManorData.rbPS = #roblist[newLV]
	-- else
		-- if roblist[oldLV] then
			-- if roblist[oldLV][rbPS] and roblist[oldLV][rbPS] == sid then
				-- table.remove(roblist[oldLV],rbPS)
			-- else
				-- if __debug then
					-- local common_log  = require('Script.common.Log')
					-- common_log.Log("robbery.txt",{sid,oldLV,rbPS})
				-- end
			-- end			
		-- end
		
		-- table.push(roblist[newLV],sid)
		-- pManorData.rbPS = #roblist[newLV]
	-- end
end

-- opt: [0] ��ʼ����� [1] ������ [2] ��鲢�۳����� [3] ������� [4] �������Ӵ���
-- �Ӷ�������¼���飺��Сʱ�ָ�һ��
-- function MRB_CheckRobTimes(sid,opt)
	-- local pManorData = GetManorData_Interf(sid)
	-- if pManorData == nil then return end
	-- local now = GetServerTime()
	-- if pManorData.rbTS == nil then
		-- pManorData.rbTS = {5, now}
	-- else
		-- local addTimes = rint((now - pManorData.rbTS[2]) / (2*60*60))
		-- if addTimes > 0 then
			-- pManorData.rbTS[1] = (pManorData.rbTS[1] or 0) + addTimes
			-- if pManorData.rbTS[1] > 50 then
				-- pManorData.rbTS[1] = 50
				-- pManorData.rbTS[2] = now
			-- else
				-- pManorData.rbTS[2] = pManorData.rbTS[2] + addTimes * (2*60*60)
			-- end			
		-- end
	-- end

	-- if opt == 1 then		-- ������
		-- if pManorData.rbTS[1] < 1 then
			-- return false
		-- end
	-- end
	-- if opt == 2 then		-- �۳�����
		-- if pManorData.rbTS[1] < 1 then
			-- return false
		-- end
		-- pManorData.rbTS[1] = pManorData.rbTS[1] - 1	
		
		-- -- ���»�Ծ��
		-- CheckTimes(sid,TimesTypeTb.HomePlunder_Time,1)
	-- end
	-- if opt == 3 then
		-- if pManorData.rbTS[1] >= 50 then
			-- --look("�������޲��ܹ���")
			-- return false
		-- end
		-- if not CheckCost(sid,50,0,1,'100011_�����Ӷ����') then
			-- --look("Ǯ����")
			-- return false
		-- end
		-- pManorData.rbTS[1] = pManorData.rbTS[1] + 1
	-- end
	-- if opt == 4 then
		-- if pManorData.rbTS[1] >= 50 then
			-- --look("�������޵��߲�������")
			-- return false
		-- end		
		-- pManorData.rbTS[1] = pManorData.rbTS[1] + 1
	-- end

	-- SendLuaMsg( 0, { ids = MRB_Times, ts = pManorData.rbTS,opt=opt }, 9 )
	
	-- return true
-- end

-- �鿴ս����
function MRB_ShowFight(sid)
	local isby = baoyue_getpower(sid, 3)
	if not isby then
		if not CheckCost(sid,10,0,1,'100027_�鿴ս����') then
			SendLuaMsg( 0, { ids = MRB_Show, res = 1 }, 9 )
			return
		end
	end
	SendLuaMsg( 0, { ids = MRB_Show, res = 0 }, 9 )
end

-- ����ׯ԰�Ӷ��б�
-- iType [0] Ĭ�ϵȼ���� [1] �ж԰������(param = ��Ա�б�) [2] ��ע���(param = ��ע�б�)
function MRB_PanelInfo(sid,iType,param,nPage)
	local lv = CI_GetPlayerData(1)
	if lv < _MinLV then return end
	--look("MRB_PanelInfo:" .. iType .. tostring(nPage))
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	local result,cPage,tPage	
	local now = GetServerTime()	
	local bFirst = MRB_IsFirst(sid)
	if bFirst then
		cPage = 1
		nPage = nil
		tPage = 1
		local pid = Robot_RandID(2)
		result = {pid}
	else
		if iType == 0 then			-- Ĭ�ϵȼ����	
			local RobList = GetManorRobberyList()
			if RobList == nil then return end
			for i=1 ,#(SIDlist) do
				SIDlist[i] = 0
			end
			result = SIDlist
			cPage,tPage = GetPageInfo(RobList,lv,nPage,sid,result)

		elseif iType == 1 then		-- �������
			if param == nil or type(param) ~= type({}) then return end
			result = param
			cPage = nPage
			
		elseif iType == 2 then		-- ��ע���
			if param == nil or type(param) ~= type({}) then return end
			result = param
			cPage = nPage
		end	
	end
	--look(cPage)
	--look(tPage)
	--look(result)
	if result == nil then return end
	if nPage and nPage ~= cPage then return end	
	
	-- ���쵱ǰҳ��Ϣ
	local cachelist = MRB_BuildList(sid,result)
	-- ���²������Ӷ�ʣ�����
	-- if nPage == nil then
		-- MRB_CheckRobTimes(sid,0)
	-- end
	-- --look(cachelist)
	-- �����б���Ϣ
	SendLuaMsg( 0, { ids = MRB_Data,iType = iType,data = cachelist,rpCD = pManorData.rbPT,cPage = cPage,tPage = tPage,bFirst = bFirst }, 9 )
end

-- function MRB_PanelInfo(sid,iType,param,nPage)
	-- local lv = CI_GetPlayerData(1)
	-- if lv < _MinLV then return end
	-- --look("MRB_PanelInfo:" .. iType .. tostring(nPage))
	-- local pManorData = GetManorData_Interf(sid)
	-- if pManorData == nil then return end
	-- local result,cPage,tPage	
	-- local now = GetServerTime()	
	-- if iType == 0 then			-- Ĭ�ϵȼ����	
		-- local RobList = GetManorRobberyList()
		-- if RobList == nil then return end
		-- if param == nil then
		-- for i=1 ,#(SIDlist) do
		-- 	  SIDlist[i] = 0
		-- end
		-- result = SIDlist
			-- cPage,tPage = GetPageInfo(RobList,lv,nPage,sid,result)
		-- else			
			-- result = param
			-- cPage = nPage
		-- end
		
	-- elseif iType == 1 then		-- �������
		-- if param == nil or type(param) ~= type({}) then return end
		-- result = param
		-- cPage = nPage
		
	-- elseif iType == 2 then		-- ��ע���
		-- if param == nil or type(param) ~= type({}) then return end
		-- result = param
		-- cPage = nPage
	-- end
	
	-- if result == nil then return end
	-- if nPage and nPage ~= cPage then return end	
	-- -- ���²������Ӷ�ʣ�����
	-- if nPage == nil then
		-- MRB_CheckRobTimes(sid,0)
	-- end
	
	-- if param then 
		-- local cachelist = MRB_BuildList(result)
		-- SendLuaMsg( 0, { ids = MRB_Data,iType = iType,data = cachelist,cPage = cPage }, 9 )
	-- else
		-- SendLuaMsg( 0, { ids = MRB_Data,iType = iType,list = result,rpCD = pManorData.rbPT,cPage = cPage,tPage = tPage }, 9 )
	-- end
-- end

-- ����ǳ�ȡ��ϸ��Ϣ
-- ͵Ϯ{���֣��ȼ���vip�����id��ս������ͷ��} --ͨ����/ׯ԰���
-- { ���֣��ȼ���vip�����ͣ����������id��ս������ͷ��}��	
-- [ pId, serverName, vipType, �ǳ��ز�ID, (ͨ����), || pID, Lv��(�����)��ս����, ͷ��ID, (����ʱ��) ]
function MRB_Detail(sid,othersid)
	--look("MRB_Detail:" .. othersid)
	local pManorData = GetManorData_Interf(othersid)
	if pManorData == nil then return end
	for i=1 ,#(details) do
		details[i] = 0
	end
	if IsPlayerOnline(othersid) == true then
		local pBaseData = CI_GetPlayerBaseData(othersid, 1)
		if pBaseData then
			local facID = pBaseData[4] or 0
			details[1] = othersid
			details[2] = pBaseData[2]
			details[3] = CI_GetFactionInfo(facID,1)
			details[4] = pBaseData[5]
			details[5] = pBaseData[6]
			details[6] = pManorData.rbPT
		end
	else
		local pTBData = PI_GetTsBaseData(othersid)
		if type(pTBData) == type({}) then 
			local facID = pTBData[6] or 0
			details[1] = othersid
			details[2] = pTBData[2]
			details[3] = CI_GetFactionInfo(facID,1)
			details[4] = pTBData[7]
			details[5] = pTBData[8]
			details[6] = pManorData.rbPT
		end	
	end
	
	SendLuaMsg( 0, { ids = MRB_Detl,data = details }, 9 )
end

-- ׯ԰�Ӷ�
function MRB_Robbery(sid,othersid)
	--look("MRB_Robbery")
	if sid == nil or othersid == nil then return end
	local selfMaData = GetManorData_Interf(sid)
	if selfMaData == nil then return end
	local selfMaTemp = GetPlayerManorTemp(sid)
	if selfMaTemp == nil or selfMaTemp.mrbSID ~= nil or selfMaTemp.mrbName ~= nil then
		--look("MRB_Robbery11")
		return
	end
	local otherMaData = GetManorData_Interf(othersid)
	if otherMaData == nil then 
		--look("otherMaData == nil")
		return 
	end		
		
	-- 1���жϴ���
	if not CheckTimes(sid,TimesTypeTb.rob_fight,1,-1,1) then
		SendLuaMsg( 0, { ids = MRB_Enter, res = 1  }, 9 )
		return
	end
	local now = GetServerTime()
	-- 2���ж϶Է��Ƿ��ڱ���CD
	if otherMaData.rbPT and now < otherMaData.rbPT then
		SendLuaMsg( 0, { ids = MRB_Enter, res = 2  }, 9 )
		return
	end
	-- -- 3���ж��Ƿ��Ǳ����
	local selfFacID = PI_GetPlayerFacID(sid) or 0
	local otherFacID = PI_GetPlayerFacID(othersid) or 0
	if selfFacID ~= 0 and otherFacID ~= 0 and selfFacID == otherFacID then
		SendLuaMsg( 0, { ids = MRB_Enter, res = 3  }, 9 )
		return
	end
	
	-- -- 4���жϵȼ�����С���Լ�10��
	local selfLV = CI_GetPlayerData(1)
	local otherLV = PI_GetPlayerLevel(othersid)
	if not MRB_IsFirst(sid) then
		if otherLV == nil or otherLV < _MinLV or selfLV < _MinLV or otherLV < selfLV - 10 then
			SendLuaMsg( 0, { ids = MRB_Enter, res = 4  }, 9 )
			return
		end
	end
	-- �����ׯ԰�ȵ���һ���˳�ׯ԰����
	OutZYparty(sid,nil,0)
	--5�����ݷ��ط�װ�δ���PK���� (�Զ�ɾ������)
	local pZSData = PI_GetCurGarniture(othersid)
	if pZSData == nil or pZSData[1] == nil then return end
	local bgID = pZSData[1]	-- ȡ������ԴID
	if bgID == nil then return end
	local mapInfo = Get_mapinfo(bgID)
	if mapInfo == nil or mapInfo[1] == nil or mapInfo[8] == nil or mapInfo[9] == nil then return end
	if type(mapInfo[8]) ~= type({}) or type(mapInfo[9]) ~= type({}) or #mapInfo[8] ~= 2 or #mapInfo[9] ~= 3 then return end
	local APos = mapInfo[8]
	local DPos = mapInfo[9]
	local mapGID = active_marobb:createDR(1,mapInfo[1],sid,sid)	
	if mapGID == nil then
		--look("PI_CreateRegion err when MR_Fight")
		return
	end
	--look('mapGID:' .. mapGID)
	local mrbDRData = active_marobb:get_regiondata(mapGID)
	if mrbDRData == nil or type(mrbDRData) ~= type({}) then return end
	
	--6���������ط�(�������Ӻͳ���)	
	local PlayerMonsterConf = PlayerMonsterConf
	local monsterConf = PlayerMonsterConf[2]
	local Dobj = CreatePlayerMonster(2,othersid,monsterConf,mapGID,DPos[1],5) or 0
	local heroConf = PlayerMonsterConf[3]
	Dobj = Dobj + (CreateHerosMonster(othersid,heroConf,mapGID,DPos[2],5) or 0)
	local petConf = PlayerMonsterConf[6]
	Dobj = Dobj + (CreatePetMonster(othersid,petConf,mapGID,DPos[3],5) or 0)
	
	--7��PutPlayerTo
	if not active_marobb:add_player(sid, 1, 0, APos[1][1], APos[1][2], mapGID) then
		--look("PI_MovePlayer err when MRB_Fight")
		return
	end
	
	LockPlayer( 3000, sid )		-- ����3���ſ�ʼ����
	
	-- 8�����������������
	heroConf = PlayerMonsterConf[4]
	local camp = CI_GetPlayerData(39,2,sid) or 0
	local Aobj = (CreateHerosMonster(sid,heroConf,mapGID,APos[2],camp,DPos[1]) or 0) + 1
	--look(heroConf)
	-- 9���۴���
	CheckTimes(sid,TimesTypeTb.rob_fight,1,-1)
	
	-- 10�����������CD
	selfMaData.rbPT = nil
	
	-- 11������Ѫ��
	PI_PayPlayer(3,1000000)
	
	-- ��¼˫��������������Ū���������
	mrbDRData[1] = sid	
	mrbDRData[2] = Aobj
	mrbDRData[3] = Dobj
	
	-- ȡ��԰���ݸ�ǰ̨��ʾ��Դ
	local StateTb = GD_GetFieldState(othersid)

	-- �洢��ʱ����
	selfMaTemp.mrbName = PI_GetPlayerName(othersid)
	selfMaTemp.mrbSID = othersid
	selfMaTemp.mrbBEG = GetServerTime()
	-- ����������ʱ��
	set_last_access(othersid)
	-- SendLuaMsg( 0, { ids = MRB_Enter, res = 0, zs = pZSData, gd = StateTb, tm = 3*60 }, 9 )
	SendLuaMsg( 0, { ids = MRB_Enter, res = 0, zs = pZSData, gd = StateTb, Aobj = Aobj, Dobj = Dobj, tm = 3*60 }, 9 )		
end

-- ׯ԰�Ӷ��˳�
function MRB_Exit(sid)
	active_marobb:back_player(sid)
end

-- ������������
function AddDeadObj(mapGID,bside)
	--look(mapGID .. ':' .. bside)
	local mrbDRData = active_marobb:get_regiondata(mapGID)
	if mrbDRData == nil or type(mrbDRData) ~= type({}) then return end
	local Asid = mrbDRData[1]
	if bside == 0 then			-- ���ط������������� +1		
		mrbDRData[3] = (mrbDRData[3] or 0) - 1
		if mrbDRData[3] <= 0 then
			MRB_Win(Asid)
		end	
	elseif bside == 1 then		-- ������������������ +1		
		mrbDRData[2] = (mrbDRData[2] or 0) - 1
		if mrbDRData[2] <= 0 then			
			MRB_Lose(Asid)
		end	
	end
	--look('AddDeadObj:' .. bside)
	RPCEx(Asid,'MRB_AddDeadObj',bside)
end

-- ���ط���������
call_monster_dead[2] = function (regionID)
	--look("OnMonsteDead_2")
	AddDeadObj(regionID,0)
end

-- ���ط��������
call_monster_dead[3] = function (regionID)
	--look("OnMonsteDead_3")
	AddDeadObj(regionID,0)
end

-- ���ط���������
call_monster_dead[6] = function (regionID)
	--look("OnMonsteDead_6")
	AddDeadObj(regionID,0)
end

-- �������������
call_monster_dead[4] = function (regionID)
	--look("OnMonsteDead_4")
	AddDeadObj(regionID,1)
end

-- ��������(������������+1)
function active_marobb:on_playerdead(sid, rid, mapGID)
	--look('MaRobb_playerdead')	
	AddDeadObj(mapGID, 1)
	return 1
end

-- �����л�����
function active_marobb:on_regionchange(sid)
	--look('MaRobb_regionchange')	
	MRB_Lose(sid)
end

-- ׯ԰�Ӷ����ߴ���
function active_marobb:on_logout(sid)
	--look('MaRobb_logout')	
	MRB_Lose(sid)
end

-- ׯ԰�Ӷ����ߴ���
function active_marobb:on_login(sid)
	local pManorTemp = GetPlayerManorTemp(sid)
	if pManorTemp == nil then return end
	local _,_,_,mapGID = CI_GetCurPos()
	local mrbDRData = active_marobb:get_regiondata(mapGID)
	if mrbDRData == nil or type(mrbDRData) ~= type({}) then return end
	local Aobj = mrbDRData[2]
	local Dobj = mrbDRData[3]
	if pManorTemp.mrbSID and pManorTemp.mrbBEG then
		local interval = GetServerTime() - pManorTemp.mrbBEG
		if interval < 3 * 60 then
			local pZSData = PI_GetCurGarniture(pManorTemp.mrbSID)
			local StateTb = GD_GetFieldState(pManorTemp.mrbSID)
			SendLuaMsg( 0, { ids = MRB_Enter, zs = pZSData, gd = StateTb, Aobj = Aobj, Dobj = Dobj, tm = 3*60 - interval }, 9 )
		end
	else
		MRB_Exit(sid)
	end		
end

-- ����ʱ��������
function active_marobb:on_DRtimeout(mapGID, args)
	if args == nil or type(args) ~= type(0) then
		return
	end
	local sid = args
	MRB_Lose(sid)
end

function MRB_ClearTemp(sid)
	local pManorTemp = GetPlayerManorTemp(sid)
	if pManorTemp == nil then
		return
	end
	pManorTemp.mrbName = nil
	pManorTemp.mrbSID = nil
	pManorTemp.mrbBEG = nil
end
