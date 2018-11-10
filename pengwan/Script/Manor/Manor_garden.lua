--[[
	file:	��԰
	author:	csj
	update:	

notes:
	1����԰ϵͳ�Ĵ������Բ����������������� ��Ϊ���й����ݻ�ɾ�� û��Ҫ���Ѿ�ɾ���Ĺ�������������
--]]

local pairs,type,rint = pairs,type,rint
local ipairs = ipairs
local mathrandom = math.random
local db_module = require('Script.cext.dbrpc')
local garden_opt_record = db_module.garden_opt_record

local uv_TimesTypeTb = TimesTypeTb
local gardmailconf = MailConfig.GardenDB
--local --look = --look
local Garden_Conf,GetServerTime,GiveGoods = Garden_Conf,GetServerTime,GiveGoods
local Manor_PetConf,CI_GetPlayerData = Manor_PetConf,CI_GetPlayerData
local PI_PayPlayer,BroadcastRPC,SendLuaMsg = PI_PayPlayer,BroadcastRPC,SendLuaMsg
-- s2c_msg_def
local GD_Data = msgh_s2c_def[27][1]		-- ��԰����
local GD_Open = msgh_s2c_def[27][2]		-- �������
local GD_Sow = msgh_s2c_def[27][3]		-- ����
local GD_Opt = msgh_s2c_def[27][4]		-- ��԰��������
local GD_Bite = msgh_s2c_def[27][5]		-- ����ҧ
local GD_Record = msgh_s2c_def[27][6]	-- ��԰������¼
local GD_mTree = msgh_s2c_def[27][7]	-- ҡǮ����Ϣ
local GD_Luck = msgh_s2c_def[27][8]		-- ����ֵ
local GD_fList = msgh_s2c_def[27][9]	-- ����״̬
local GD_Land = msgh_s2c_def[27][10]	-- ������Ϣ
local Pet_Set = msgh_s2c_def[38][3]	-- �û�����

local BaseOpenNum = 2
local percent = 0.1		-- ÿ��͵ȡ10%

-------------------------------------------------------------------------
--data:
local fList = {0,0,0,0,0,0,0,0,0,0,0,0}
local StateTb = {{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},}

-------------------------------------------------------------------------
--inner function:

-- ����´γ��ݻ򳤳�ʱ��,��ֲ��ʱ����һ��������Ժ�ֻ����������ҳ��ݻ����ʱ�Żᴥ���´����	(30��50����)
-- Ϊ��ͳһ�жϹ��� ( ��󲻳���Ҳ�������ʱ���¼����������ʱ�� )
local function GetTimeAndType(ripeTime)
	local now = GetServerTime()	
	local nexttime = math.random(30 * 60,50 * 60)
	-- if __debug then
		-- nexttime = mathrandom(3,5)	-- ������
	-- end
	if now + nexttime >= ripeTime then	-- ��������ʱ�䲻�᳤�ݻ��
		nexttime = ripeTime		
	else
		nexttime = now + nexttime
	end
	-- ������������Ҫ������Ļ���ô�����û������͵������ ��Ҫ��������´�ʱ�估����( Ҳ����һ���ݹ���� )
	local itype = nil
	if nexttime ~= ripeTime then
		itype = mathrandom(1,2)
	else
		itype = 4
	end
	return nexttime,itype 
end

-- ��ó���ʱ�� (��槼��øжȼ����й�)
local function GetRipeTime(sid,seedID)	
	local now = GetServerTime()
	local seedTB = Garden_Conf.seeds[seedID]
	local waiteTime = seedTB.waiteTime
	if waiteTime == nil then 
		return
	end
	local res = GD_GetLandAdd(sid)
	if res and type(res) == type({}) and #res == 2 then
		waiteTime = rint(waiteTime -  waiteTime * res[2] / 100)
	end
	if waiteTime < 0 then
		return
	end
	local RipeTime = now + waiteTime
	return RipeTime
end

-- ��������
local function RandSpecial(seedID,luck)
	if Garden_Conf.seeds[seedID] == nil then
		return
	end
	
	local wTime = Garden_Conf.seeds[seedID].waiteTime
	local rd = mathrandom(1,10000)
	if rd <= (luck or 0) then	
		if wTime == 3600 * 1 then
			return 1081
		elseif wTime == 3600 * 4 then
			return 1082
		elseif wTime == 3600 * 12 then
			return 1083				
		end
		-- -- ������
		-- if __debug then
			-- if seedID == 1018 then
				-- return math.random(1081,1083)
			-- end
		-- end
	end
	return
end

-- ����������� �����Ӻ�槼��øж��й�
local function GetGains(sid,seedID)
	local stype = Garden_Conf.seeds[seedID].stype
	local awards = Garden_Conf.seeds[seedID].Awards
	local addExps = Garden_Conf.seeds[seedID].AddExps
	
	local res = GD_GetLandAdd(sid)
	if res and type(res) == type({}) and #res == 2 then
		--look(res[1])
		awards = rint(awards + awards * res[1] / 100)
	end

	return stype,awards,addExps
end

-- ����Ƿ�ɲ��� max = 17
local function GD_CheckState(sid,othersid,index,opt)
	local playerid = othersid or sid
	local pGardenData = GetGardenData_Interf(playerid)
	if pGardenData == nil or pGardenData[index] == nil then
		--look("�˵�Ϊ��")
		return 1
	end
	local now = GetServerTime()
	
	-- ��������
	if opt == -1 then
		if othersid ~= nil then
			--look("���ܲ������˵Ĳ˵�")
			return 16
		end
		if now >= pGardenData[index][2] then
			--look("�ѳ��첻�ܲ���")
			return 2
		end
		
	-- ���ٲ���
	elseif opt == 0 then
		if othersid ~= nil then
			--look("���ܼ��ٱ��˵Ĳ˵�")
			return 4
		end
		if pGardenData[index][4] > 0 then
			--look("�Ѿ����ٹ�һ���� ���ܼ�����")
			return 5
		end
		if now >= pGardenData[index][2] then
			--look("�Ѿ����첻�ܼ�����")
			return 6
		end
		local isby = baoyue_getpower(sid, 5)
		local ct = CheckTimes(sid,uv_TimesTypeTb.GD_Speed,1,-1)
		if not isby or not ct then
			if not CheckCost(sid,10,0,1,'100018_���ٲ���') then
				--look("ǮǮ���������ף�")
				return 17
			end
		end
		
	-- ���ݻ������� ( �����´γ��ݻ��߳���ʱ�� )
	elseif opt == 1 or opt == 2 then			
		if now >= pGardenData[index][2] then
			--look("�ѳ��첻�ܲ���")
			return 7
		end
		if pGardenData[index][5] == nil or pGardenData[index][6] == nil then
			--look("�ɲ�������Ϊ��")
			return 8
		end
		if now < pGardenData[index][5] or opt ~= pGardenData[index][6] then
			--look("�������Ͳ�ƥ��[" .. pGardenData[index][6] .. "]" )
			return 9
		end		
		
	--  ��ˮ���� ( �����´ο�ήʱ�� )
	elseif opt == 3 then
		if now < pGardenData[index][2] then
			--look("û���첻�ܽ�ˮ")
			return 10 
		end
		if pGardenData[index][5] == nil or pGardenData[index][6] == nil then
			--look("�ɲ�������Ϊ��")
			return 11
		end
		if now < pGardenData[index][5] or opt ~= pGardenData[index][6] then
			--look("�������Ͳ�ƥ��[" .. pGardenData[index][6] .. "]" )
			return 12
		end		
	
	-- ͵��/�ջ� ���� ( ����ֻ�ж��Ƿ���첢��û�п�ή )
	elseif opt == 4 then
		if pGardenData[index][5] == nil or pGardenData[index][6] == nil then
			--look("�ɲ�������Ϊ��")
			return 13
		end
		
		if now < pGardenData[index][2] then
			--look("û���첻��͵ȡ/�ջ�")
			return 14
		else
			if othersid == nil then		-- �ջ�
				if pGardenData[index][6] == 3 and now >= pGardenData[index][5] then
					--look("�ѿ�ή�����ջ�")
					return 15
				end
			else						-- ͵ȡ				
				if pGardenData[index][6] == 3 then		-- �ý�������״̬�ж��Ƿ�͵��
					--look("��͵�겻����͵")
					return 18
				end
				local pGardenTemp = GetExtraTemp_Garden(othersid)
				if pGardenTemp == nil then 
					return 19
				end
				if pGardenTemp[index] and pGardenTemp[index][sid] == 1 then
					return 20			-- �Ѿ�͵��������
				end
			end
		end			
	end
	
	return 0
end

-- ��԰������¼
-- opt [4] ��͵ [5] ��ץ seedID=money
local function GD_RecordOpt(sid,othersid,opt,seedID)
	if othersid == nil then return end
	local playerid = othersid or sid
	-- local pGardenData = GetGardenData_Interf(playerid)
	-- if pGardenData == nil then return end
	local opName = CI_GetPlayerData(5,2,sid)
	
	-- ���ô洢����д��־
	garden_opt_record(othersid,opName,opt,seedID,0)
	if IsPlayerOnline(othersid) then
		SendLuaMsg( othersid, { ids = GD_Record,opName = opName,opt = opt,seedID = seedID }, 10 )
	end
end

-- ����б���� ��Ҫ�жϰ���
-- ����ֵ: [0] δ͵�������  [1] ͵�������ջ�����
local function GD_DoAward(sid,othersid,stype,gains,SpecID)
	-- ������
	if stype == 1 then				-- ������
		PI_PayPlayer(1,gains,0,0,'��ֲ�����')
	elseif stype == 2 then			-- ��ͭǮ
		GiveGoods(0,gains,1,"��԰���")
	elseif stype == 3 then			-- ������
		AddPlayerPoints(sid,2,gains,nil,'��԰')
	end
	local selfName = PI_GetPlayerName(sid)
	-- �б��컨
	if SpecID ~= nil then
		local ItemList = {{SpecID,1,1}}		
		if othersid then			-- ����͵ȡ���컨
			local LogInfo = "͵ȡ���컨"
			local rd = mathrandom(1,10000)
			if rd <= 2000 then
				--look("�н���,͵�����컨��")				
				local otherName = PI_GetPlayerName(othersid)				
				-- �����컨 �������Ļ����ʼ�				
				PI_GiveGoodsEx(sid,gardmailconf,2,2,SpecID,ItemList,nil,LogInfo)
				BroadcastRPC('GD_Notice',selfName,otherName,SpecID)
				GD_RecordOpt(sid,othersid,4,SpecID)		--͵���������¼��־
				return 1
			end
		else						-- �Լ��ջ���컨
			-- �����컨 �������Ļ����ʼ�
			local LogInfo = "�ջ���컨"
			PI_GiveGoodsEx(sid,gardmailconf,1,2,SpecID,ItemList,nil,LogInfo)
			BroadcastRPC('GD_Notice',selfName,nil,SpecID)
			return 1
		end		
	end
	
	return 0
end

-- ���ջ���
-- ����seedID �� ��͵���� ���㽱��
local function GD_GainsProc(sid,othersid,index)
	local playerid = othersid or sid
	local pGardenData = GetGardenData_Interf(playerid)
	if pGardenData == nil then return end
	local pSelfData = GetGardenData_Interf(sid)
	if pSelfData == nil then return end
	local pGardenTemp = GetExtraTemp_Garden(playerid)
	if pGardenTemp == nil then return end
	local seedID = pGardenData[index][1]
	local stype = Garden_Conf.seeds[seedID].stype
	local color = Garden_Conf.seeds[seedID].color
	local addexps = Garden_Conf.seeds[seedID].AddExps
	local exps = 0
	if othersid == nil then		-- �Լ���԰ �ջ�
		-- �����������ͺ�Ʒ�ʸ�����(��ȥ��͵��)	
		exps = AddManorExp(sid,addexps,1) or 0
		--look(pGardenData[index][7])
		local gains = rint( pGardenData[index][7] * ( 1 - pGardenData[index][3] * percent ) )
		GD_DoAward(sid,othersid,stype,gains,pGardenData[index][9])
		--look("�ջ�ɹ�")
		pGardenData[index] = nil
		pGardenTemp[index] = nil
		-- ���»�Ծ��
		CheckTimes(sid,uv_TimesTypeTb.Garden_Time,1)
	else
		-- �ж��Ƿ��Ѿ�͵����		
		local stcount = 5		-- ȡ��͵����(�̶ֹ�5��)
		
		-- ��Ϊ͵���˲Ż��ή���Բ���Ҫ�ж��Ƿ��ή��
		if (pGardenData[index][3] or 0) >= stcount then
			--look("͵���˲�����͵��")
			return 91
		end
		-- �жϽ���͵�˴��� ( ���� 300 ��)
		if not CheckTimes(sid,uv_TimesTypeTb.GD_Steal,1,-1,1) then
			--look("����͵��������")
			return 92
		end
		
		-- ÿ���ÿ����ֻ��͵һ��(�����Ƿ�������temp�µ� �������رվͻ�����)		
		if pGardenTemp[index] == nil or pGardenTemp[index][sid] == nil then
			pGardenTemp[index] = pGardenTemp[index] or {}
			pGardenTemp[index][sid] = 1
		else			
			--look("���Ѿ�͵��������")
			return 93			
		end
		
		-- �ж϶Է���԰�Ƿ��й�		
		local bite = 0
		local now = GetServerTime()
		local petID = PI_GetPetID(othersid)
		if petID and Manor_PetConf[petID] then
			local Rate = Manor_PetConf[petID].rate or 5000 		-- û���50%���ʴ�����
			-- ֱ�ӿ����ϵ�Ǯ �ж��ٿ۶���
			--look("��������")
			local rd = mathrandom(1,10000)
			if rd <= Rate then				-- ������ץ
				local nPaths = Manor_PetConf[petID].paths or 2		-- û���Ĭ��2��·
				local rdEx = mathrandom(1,10000)
				-- ������Ƿ�ץ�Ľ��
				if rdEx <= rint(10000 / nPaths) then
					--look("��ϲ�㣬����ҧ�ˣ������Լ���͵Ŷ����~")
					local pGardenTemp = GetExtraTemp_Garden(playerid)
					if pGardenTemp == nil then return end
					if pGardenTemp[index] and pGardenTemp[index][sid] then
						pGardenTemp[index][sid] = nil		-- ����͵ȡ�б� ���Լ���͵
					end
					local money = mathrandom(500,1000)
					CheckCostAll(sid,money,'����ҧ')					-- ��������ϵ�ͭǮǮ �ж��ٿ۶��� ����Ϊֹ
					GD_SetMoneyTree(othersid,1,money)		-- �Է���Ǯ���ӵ�ҡǮ����
					GD_RecordOpt(sid,othersid,5,money)
					SendLuaMsg( 0, { ids = GD_Bite, idx = index, dtype = petID, money = money, pid = playerid }, 9 )
					return -1	
				end	
				bite = -1
			end
		end
		
		-- �۴���
		CheckTimes(sid,uv_TimesTypeTb.GD_Steal,1,-1,0)		
		
		-- û�й���û��ץ �����������ͺ�Ʒ�ʸ�����
		local gains = rint( pGardenData[index][7] * percent )
		local ret = GD_DoAward(sid,othersid,stype,gains,pGardenData[index][9])
		if ret == 1 then
			pGardenData[index][9] = nil
		end
		--look("͵ȡ�ɹ�" .. pGardenData[index][3])
		pGardenData[index][3] = pGardenData[index][3] + 1
		-- ���͵���� ������ή
		if pGardenData[index][3] == stcount then
			pGardenData[index][5] = now + 8 * 60 * 60
			-- --look("������ή:" .. index)
			-- if __debug then
				-- pGardenData[index][5] = now + 20
			-- end
			pGardenData[index][6] = 3
		end
		if bite == -1 then
			SendLuaMsg( 0, { ids = GD_Bite, idx = index, dtype = petID, dt = pGardenData[index], pid = playerid }, 9 )
			return -1
		end
	end
	return 0,exps
end

----------------------------------------------------------------------
--interface:
local stealtb = {0,0,0,0,0,0,0,0}
local default = {opens = 2}
-- othersid == nil �����Լ���԰
-- othersid ~= nil ������Ѳ�԰
function GD_EnterGarden(sid,othersid)	
	-- ���жϵȼ�
	local playerid = othersid or sid
	--look("GD_EnterGarden:" .. playerid)
	local pGardenData = GetGardenData_Interf(playerid)
	if pGardenData == nil then
		SendLuaMsg( 0, { ids = GD_Data, fields = default, pid = playerid, }, 9 )
		return 
	end
	-- ��һ�ν��Լ��Ĺ�԰ ��ʼ��������Ϣ
	if othersid == nil then
		local pManorData = GetManorData_Interf(sid)
		if pManorData == nil then return end
		if pManorData.PetD == nil then
			pManorData.PetD = {
				id = 1,
			}
			SendLuaMsg( 0, { ids = Pet_Set, res = 0, idx = 1 }, 9 )
		end	
		SendLuaMsg( 0, { ids = GD_Data, fields = pGardenData, pid = playerid, }, 9 )
	else
		local pGardenTemp = GetExtraTemp_Garden(othersid)
		if pGardenTemp then 
			-- clear
			for i = 1, #stealtb do
				stealtb[i] = 0
			end
			for k, v in pairs(pGardenTemp) do
				if type(k) == type(0) and type(v) == type({}) then
					if v[sid] == 1 then	-- �Ѿ�͵��
						stealtb[k] = 1
					end
				end
			end
		end
		SendLuaMsg( 0, { ids = GD_Data, fields = pGardenData, stb = stealtb, pid = playerid, }, 9 )
		-- �������˹�԰ ����ׯ԰��Ϣ(�ȼ������顢����)
		SyncManorData(sid,othersid,2)
		-- ����������ʱ��
		set_last_access(sid)
	end
end

-- ��ȡ��԰���״̬(��ׯ԰������ʾ��Դ) 8*2
function GD_GetFieldState(sid)
	local pGardenData = GetGardenData_Interf(sid)
	if pGardenData == nil then return end
	for i=1 ,#(StateTb) do
		if type(StateTb[i]) == type({}) then
			for j = 1, #StateTb[i] do
				StateTb[i][j] = 0
			end
		end
	end
	StateTb.opens = pGardenData.opens or BaseOpenNum
	for k, v in pairs(pGardenData) do
		if type(k) == type(0) and type(v) == type({}) then
			StateTb[k][1] = v[1]
			StateTb[k][2] = v[2]
		end
	end
	
	return StateTb
end

-- ȡ���ѹ�԰״̬
function GD_GetFriendList(sid,page,pidList)	
	--look("GD_GetFriendList")
	if pidList == nil or type(pidList) ~= type({}) then
		return
	end
	for i=1 ,#(fList) do
		fList[i] = 0
	end
	local state = nil
	for k, pid in ipairs(pidList) do
		state = nil
		local pGardenData = GetGardenData_Interf(pid)
		if pGardenData then
			for index, v in pairs(pGardenData) do
				if type(index) == type(0) and v ~= nil then
					for opt = 1, 4 do		
						if GD_CheckState(sid,pid,index,opt) == 0 then
							if opt > (state or  0) then
								state = opt
							end
							break	-- ͬʱֻ����һ��״̬
						end						
					end
					if state == 4 then
						break
					end
				end
			end			
		end	
		fList[k] = state or 0		-- ����stateΪnilҲҪռ��λ
	end
	SendLuaMsg( 0, { ids = GD_fList, page = page, fList = fList }, 9 )	
end

-- ��һ�ν���ɽׯ��ʼ��ҡǮ��
function GD_InitMoneyTree(sid)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	local now = GetServerTime()
	if pManorData.MonT == nil then
		pManorData.MonT = {
			20000,					-- ��ǰ����
			now,					-- �����ϴθ���ʱ��
			0,						-- �´���ȡʱ��
			0,						-- ÿ�ձ��Ӷ��ֵ
		}
		SendLuaMsg( sid, { ids = GD_mTree, mt = pManorData.MonT, iType = 0 }, 10 )
	end	
end
--[[
	ҡǮ��������
	@iType: [nil] ��ȡҡǮ����ǰ����(������Ϣ)  [0] ��ȡҡǮ����Ϣ(����Ϣ) [1] ��ȡҡǮ������(����Ϣ) 
			[2] ��CD(��Ԫ��) [3] ��CD(Ԫ��)
]]--
function GD_GetMoneyTree(sid,iType)
	if IsSpanServer() then
		return
	end
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil or pManorData.MonT == nil then return end
	local mtTable = pManorData.MonT	
	local level = PI_GetPlayerLevel(sid)
	if level == nil then return end
	local now = GetServerTime()
	local interval = now - mtTable[2]	
	local yield = rint(level*200)		-- ÿСʱ����
	local limit = yield * 24		-- ����			
		
	-- ���´���
	local addMoneys = rint(interval * (yield / 3600))
	if mtTable[1] + addMoneys > limit then
		mtTable[1] = limit
	else
		mtTable[1] = mtTable[1] + addMoneys
	end	
	mtTable[2] = now
	
	if iType == nil then		
		return mtTable[1]
	end
	-- ��ȡҡǮ����Ϣ(����Ϣ)
	if iType == 0 then
		SendLuaMsg( sid, { ids = GD_mTree, mt = mtTable, iType = iType }, 10 )
		return 
	end
	-- ��ȡҡǮ��
	if iType == 1 then
		if now < mtTable[3] then	-- ��ȴʱ��δ��
			SendLuaMsg( sid, { ids = GD_mTree, iType = iType, res = 1 }, 10 )
			return
		end
		local store = mtTable[1]
		GiveGoods(0, mtTable[1], 1, "ҡǮ����ȡ",sid)
		mtTable[1] = 0
		mtTable[2] = now
		mtTable[3] = now + 8 * 60 * 60
		mtTable[4] = 0
		-- ���»�Ծ��
		CheckTimes(sid,uv_TimesTypeTb.MoneyTree_Time,1)
		
		SendLuaMsg( sid, { ids = GD_mTree, mt = mtTable, iType = iType, res = 0, store = store }, 10 )
		return
	end	
	-- ��CD(�۰�Ԫ��)
	if iType == 2 then
		if now < mtTable[3] then
			local yb = rint((mtTable[3] - now) / 300) + 1
			if not CheckCost(sid,yb * 5,1,1,"ҡǮ����CD") then
				SendLuaMsg( sid, { ids = GD_mTree, iType = iType, res = 1 }, 10 )
				return
			end
		end
		mtTable[3] = 0
		SendLuaMsg( sid, { ids = GD_mTree, iType = iType, res = 0 }, 10 )
	end
	-- ��CD(��Ԫ��)
	if iType == 3 then
		if now < mtTable[3] then
			local yb = rint((mtTable[3] - now) / 300) + 1
			if not CheckCost(sid,yb,0,1,"100025_ҡǮ����CD") then
				SendLuaMsg( sid, { ids = GD_mTree, iType = iType, res = 1 }, 10 )
				return
			end
		end
		mtTable[3] = 0
		SendLuaMsg( sid, { ids = GD_mTree, iType = iType, res = 0 }, 10 )
	end
end

--[[
	ҡǮ��������
	@iType: 
			[1] ��Ǯ(��ֵ) [-1] ��Ǯ(�ٷֱ�)	
]]--

function GD_SetMoneyTree(sid,iType,money)
	if iType == nil then return end
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil or pManorData.MonT == nil then return end
	local mtTable = pManorData.MonT	
	local level = PI_GetPlayerLevel(sid)
	if level == nil then return end
	local now = GetServerTime()
	local interval = now - mtTable[2]		
	local yield = rint(level*200)		-- ÿСʱ����
	local limit = yield * 24		-- ����
	if interval >= 60 then									
		local addMoneys = rint(rint(interval / 60) * (yield / 60))
		if mtTable[1] + addMoneys > limit then
			mtTable[1] = limit
		else
			mtTable[1] = mtTable[1] + addMoneys
		end	
		mtTable[2] = now
	end		
	-- ��Ǯ (�ж��Ƿ���ҡǮ���������� ����ʵ�ʼ�Ǯ��)
	if iType == 1 then
		if money == nil or type(money) ~= type(0) or money < 0 then
			return 0
		end
		mtTable[1] = mtTable[1] + money
		if mtTable[1] + money > limit then
			money = limit - mtTable[1]
			mtTable[1] = limit
		end	
		if IsPlayerOnline(sid) then
			SendLuaMsg( sid, { ids = GD_mTree, mt = mtTable, iType = 0 }, 10 )		
		end
		return money
	end
	-- ��Ǯ(�ж��Ƿ�۵���ÿ������ ����ʵ�ʿ۳�Ǯ��)
	if iType == -1 then
		--look(mtTable)
		if money == nil or type(money) ~= type(0) or money < 0 then
			return 0
		end
		money = rint(mtTable[1] * money / 100)
		-- ÿ�տ�Ǯ����
		local prot = level * level * 5
		if (mtTable[4] or 0) + money > prot then
			money = prot - (mtTable[4] or 0)		-- ȡʵ�ʱ���Ǯ��
		end
		if money < 0 then
			money = 0
		end
		-- ����Ϊֹ
		if (mtTable[1] or 0) < money then
			mtTable[1] = 0
			money = money - (mtTable[1] or 0) 
		else
			mtTable[1] = (mtTable[1] or 0) - money
		end
		if mtTable[1] < 0 then			
			mtTable[1] = 0 
		end
		if money < 0 then
			money = 0
		end
		mtTable[4] = (mtTable[4] or 0) + money
		if IsPlayerOnline(sid) then
			SendLuaMsg( sid, { ids = GD_mTree, mt = mtTable, iType = 0 }, 10 )
		end
		return money
	end			
end

-- ����һ�����
function GD_OpenField(sid,index)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	local pGardenData = GetGardenData_Interf(sid)
	if pGardenData == nil then return end
	local opens = pGardenData.opens	or BaseOpenNum
	if index <= opens or index ~= opens + 1 then 
		SendLuaMsg( 0, { ids = GD_Open, res = 1 }, 9 )		-- �Ѿ����������˻������ſ�
		return
	end
	local mLv = pManorData.mLv or 1
	local maxOpens = rint(mLv / 5) + BaseOpenNum			-- ׯ԰�ȼ� ÿ5����һ���
	if index > maxOpens then
		SendLuaMsg( 0, { ids = GD_Open, res = 2 }, 9 )		-- ׯ԰�ȼ�����
		return
	end
	-- ��Ǯ���߿�Ԫ��(����δ��)
	pGardenData.opens = (pGardenData.opens or BaseOpenNum) + 1
	SendLuaMsg( 0, { ids = GD_Open, res = 0, idx = index }, 9 )	
end

-- �ֲ� ��Ϊ�����ʼ������ ����û�и�������������һ��
-- Ϊ�˷���seedID = ItemID ����Ϊʵ�����
function GD_SowSeed(sid,index,seedID)
	local pGardenData = GetGardenData_Interf(sid)
	if pGardenData == nil then return end
	if index > (pGardenData.opens or BaseOpenNum) then
		SendLuaMsg( 0, { ids = GD_Sow, res = 1 }, 9 )	-- ��û��
		return
	end
	if pGardenData[index] ~= nil then
		SendLuaMsg( 0, { ids = GD_Sow, res = 2 }, 9 )	-- �Ѿ���������
		return
	end
	
	if Garden_Conf.seeds[seedID] == nil then
		SendLuaMsg( 0, { ids = GD_Sow, res = 3 }, 9 )	-- ������������
		return
	end
	-- ��鱳���Ƿ�������
	if CheckGoods(seedID, 1, 0, sid,'��鱳���Ƿ�������') == 0 then
		SendLuaMsg( 0, { ids = GD_Sow, res = 4 }, 9 )	-- û������
		return
	end
	-- ��ȡ����ʱ��
	local ripeTime = GetRipeTime(sid,seedID)
	if ripeTime == nil then return end
	-- ����´γ��ݻ򳤳�ʱ��
	local nexttime,itype = GetTimeAndType(ripeTime)
	-- ��ȡ��������
	local _,awards = GetGains(sid,seedID)
	-- ����Ƿ�������(�ֵ�ʱ����������˽���԰�ı���, �����Ӻ�����ֵ)�й�)
	local now = GetServerTime()
	-- ��ʼ����ֵ 1%
	local luck = 100
	local SpecID = RandSpecial(seedID,luck)
	pGardenData[index] = {
		seedID,				-- ����ID	[1]		
		ripeTime,			-- ����ʱ�� [2]
		0,					-- ��͵���� [3]
		0,					-- ���ٴ��� [4]
		nexttime,			-- �´γ��ݻ򳤳���ήʱ�� [5]
		itype,				-- �´γ��ݻ��߳��� 1 �ɳ��� 2 �ɳ��� 3 �ɽ�ˮ 4 ��͵ȡ/���ջ�  [6]
		awards,				-- ����		[7]
		luck,				-- ����ֵ	[8]
		SpecID,				-- �Ƿ��������	[9]
	}
	SendLuaMsg( 0, { ids = GD_Sow, res = 0, idx = index, dt = pGardenData[index] }, 9 )
	AddManorExp(sid,1,1)	-- ���ּ�ׯ԰����
end

-- ʹ������ҩˮ(ÿ��ʹ�ü����Ƿ��������,�Ḳ���ϴν��)
function GD_AddLuck(sid,index,luckid)
	local pGardenData = GetGardenData_Interf(sid)
	if pGardenData == nil or pGardenData[index] == nil then
		SendLuaMsg( 0, { ids = GD_Luck, res = 1 }, 9 )		-- �˵�Ϊ�ղ��ܲ���
		return
	end
	
	local now = GetServerTime()
	if now >= pGardenData[index][2] then
		SendLuaMsg( 0, { ids = GD_Luck, res = 2 }, 9 )		-- �Ѿ����첻��ʹ������ҩ
		return
	end 
	-- ���˸��ʴ���80%������ʹ��
	if pGardenData[index][8] >= 8000 then
		SendLuaMsg( 0, { ids = GD_Luck, res = 3 }, 9 )		-- ����ֵ�Ѵﵽ�������ʹ��
		return
	end
	
	-- ��鱳���Ƿ�������ҩ
	if CheckGoods(luckid, 1, 0, sid,'��鱳���Ƿ�������ҩ') == 0 then
		SendLuaMsg( 0, { ids = GD_Luck, res = 4 }, 9 )		-- û������ҩ
		return
	end
	
	if luckid == 664 then		-- ��������ҩ
		pGardenData[index][8] = (pGardenData[index][8] or 0) + 1000
	elseif luckid == 665 then	-- �߼�����ҩ
		pGardenData[index][8] = (pGardenData[index][8] or 0) + 2000
	end
	pGardenData[index][9] = RandSpecial(pGardenData[index][1],pGardenData[index][8])
	SendLuaMsg( 0, { ids = GD_Luck, res = 0, idx = index, luck = pGardenData[index][8], specid = pGardenData[index][9] }, 9 )
end

-- ��԰���� (-1 ���� 0 ���� 1 ���� 2 ���� 3 ��ˮ 4 ͵ȡ/�ջ�) ������ʾ���ȼ�����
-- ���ǰ̨���жϺ�̨�ɲ������Ƿ����Լ���԰���ж�
function GD_Operations(sid,othersid,index,opt,bFast)
	local playerid = othersid or sid
	local pGardenData = GetGardenData_Interf(playerid)
	if pGardenData == nil then return end
	local pSelfData = GetGardenData_Interf(sid)
	if pSelfData == nil then return end
	
	-- ÿ�β���ǰ �ж��Ƿ��Ѿ�����
	local now = GetServerTime()		
	local exps = 0
	local check = GD_CheckState(sid,othersid,index,opt)
	if check == 0 then
		if opt == -1 then				-- ����			
			local pGardenTemp = GetExtraTemp_Garden(sid)
			if pGardenTemp == nil then return end
			pGardenData[index] = nil
			pGardenTemp[index] = nil
		elseif opt == 0 then			-- ����
			local ripeTime = pGardenData[index][2]
			ripeTime = rint((ripeTime + now) / 2)
			-- ������Ҫ�ж��´γ��ݻ򳤳�ʱ���Ƿ���ڼ��ٺ��ʱ�� ����������ٳ��ݻ��
			if pGardenData[index][5] ~= nil and pGardenData[index][5] > ripeTime then
				pGardenData[index][5] = ripeTime
				pGardenData[index][6] = 4
			end
			pGardenData[index][2] = ripeTime
			pGardenData[index][4] = 1
			
		-- ���ݻ������� ( �����´γ��ݻ��߳���ʱ�� )
		elseif opt == 1 or opt == 2 then					
			-- �ж��Ƿ�ɻ�ü�԰���� ÿ��100��
			exps = AddManorExp(sid,1,1) or 0		-- ���ݳ����ׯ԰����
			-- if othersid then
				-- AddDearDegree(sid,othersid,1)				-- �����ܶ�
			-- end
			-- ����´γ��ݻ򳤳�ʱ��
			local ripeTime = pGardenData[index][2]
			local nexttime,itype = GetTimeAndType(ripeTime)
			pGardenData[index][5] = nexttime
			pGardenData[index][6] = itype
			
		--  ��ˮ���� ( �����´ο�ήʱ�� )
		elseif opt == 3 then			
			exps = AddManorExp(sid,1,1) or 0		-- ��ˮ��ׯ԰����
			-- if othersid then
				-- AddDearDegree(sid,othersid,1)				-- �����ܶ�
			-- end
			-- �����´ο�ήʱ�� ( �̶�8Сʱ )
			pGardenData[index][5] = now + 8 * 60 * 60
			pGardenData[index][6] = 3
		
		-- ͵��/�ջ���� ( ���͵���˻ᴥ���´ο�ήʱ�� )
		elseif opt == 4 then			
			local ret,ret2 = GD_GainsProc(sid,othersid,index)
			exps = ret2 or 0
			if ret == nil or ret < 0 then	-- �����쳣�򱻹�ҧ
				return ret
			else
				check = ret
			end
		end
	end
	
	-- ��¼����(ֻ��¼���˵�͵�˲���)
	if check == 0 and opt == 4 and othersid ~= nil then
		local seedID = pGardenData[index][1]
		GD_RecordOpt(sid,othersid,opt,seedID)
	end
	--look('check:' .. check)
	-- ����һ�� ʧ�ܵĲ�������ʾ
	if bFast then
		if check == 0 then
			SendLuaMsg( 0, { ids = GD_Opt, idx = index, opt = opt, res = check, dt = pGardenData[index], pid = playerid, exps = exps }, 9 )
		end
	else		
		SendLuaMsg( 0, { ids = GD_Opt, idx = index, opt = opt, res = check, dt = pGardenData[index], pid = playerid, exps = exps }, 9 )
	end
	
	return check
end

-- ͵�˱�ץ����
-- function GD_Escape(sid,othersid,index)
	-- if othersid == nil then return end
	-- local playerid = othersid or sid
	-- local pGardenData = GetGardenData_Interf(playerid)
	-- if pGardenData == nil then return end
	-- local pSelfData = GetGardenData_Interf(sid)
	-- if pSelfData == nil then return end
	-- if pSelfData.bite == nil then
		-- --look("û��ҧ�ܸ�ë")
		-- return
	-- end
	-- -- ѡ�����ܵ�ʱ����ܱ�͵�� ���� ���ջ�
	-- if pGardenData[index] == nil then
		-- --look("�˵ر��ջ���")
		-- SendLuaMsg( 0, { ids = GD_Opt, idx = index, opt = 4, res = 94, pid = playerid }, 9 )
		-- pSelfData.bite = nil
		-- return
	-- end
	
	-- local seedID = pGardenData[index][1]
	-- local stype = Garden_Conf.seeds[seedID].stype
	-- local color = Garden_Conf.seeds[seedID].color
	-- -- �ж��Ƿ��Ѿ�͵����			
	-- local stcount = 5			-- ȡ��͵����(�̶ֹ�5��)
	-- local Paths = Manor_PetConf[pSelfData.bite].paths or 2		-- û���Ĭ��2��·
	-- local rd = math.random(1,10000)
	-- -- ͵���˾͵�����ҧ����
	-- if (pGardenData[index][3] or 0) >= stcount or rd <= rint(10000 / Paths) then
		-- --look("��ϲ�㣬����ҧ�ˣ������Լ���͵Ŷ����~")
		-- local pGardenTemp = GetExtraTemp_Garden(playerid)
		-- if pGardenTemp == nil then return end
		-- if pGardenTemp[index] and pGardenTemp[index][sid] then
			-- pGardenTemp[index][sid] = nil		-- ����͵ȡ�б� ���Լ���͵
		-- end
		-- local money = math.random(500,1000)
		-- CheckCostAll(0,money)					-- ��������ϵ�ͭǮǮ �ж��ٿ۶��� ����Ϊֹ
		-- GD_SetMoneyTree(othersid,1,money)		-- �Է���Ǯ���ӵ�ҡǮ����
		-- GD_RecordOpt(sid,othersid,5,money)
		-- SendLuaMsg( 0, { ids = GD_Opt, idx = index, opt = 4, res = -1, money = money, pid = playerid }, 9 )
	-- else
		-- local gains = rint( pGardenData[index][7] * percent )
		-- GD_DoAward(sid,othersid,stype,gains,pGardenData[index][9])
		-- --look("͵ȡ�ɹ�:" .. pGardenData[index][3])
		-- pGardenData[index][3] = pGardenData[index][3] + 1
		-- -- ���͵���� ������ή
		-- local now = GetServerTime()
		-- if pGardenData[index][3] == stcount then
			-- pGardenData[index][5] = now + 8 * 60 * 60
			-- --look("������ή:" .. index)
			-- if __debug then
				-- pGardenData[index][5] = now + 20
			-- end
			-- pGardenData[index][6] = 3
		-- end		
		-- GD_RecordOpt(sid,othersid,4,seedID)
		-- SendLuaMsg( 0, { ids = GD_Opt, idx = index, opt = 4, res = 0, dt = pGardenData[index], pid = playerid }, 9 )
	-- end		
	-- pSelfData.bite = nil	
-- end

-- ��԰�ջ�
-- ���ǰ̨���жϺ�̨�ɲ������Ƿ����Լ���԰���ж�
-- iType 0-- һ���ջ�/͵ȡ 1-- һ������  2-- һ����ֲ
function GD_FastOpt(sid,othersid,iType,param)
	local playerid = othersid or sid
	local pGardenData = GetGardenData_Interf(playerid)
	if pGardenData == nil then return end
	local opens = pGardenData.opens or BaseOpenNum
	local ret = nil
	if iType == 0 then			-- һ���ջ�/͵ȡ 
		for index = 1, opens do
			if pGardenData[index] ~= nil and pGardenData[index][1] ~= nil then
				ret = GD_Operations(sid,othersid,index,4,true)
				-- ����ҧ �ж�
				if ret ~= nil and ret == -1 then
					break
				end
			end
		end
	elseif iType == 1 then		-- һ������
		for index = 1, opens do
			if pGardenData[index] ~= nil and pGardenData[index][1] ~= nil then
				for i = 1, 3 do
					ret = GD_Operations(sid,othersid,index,i,true)
					-- ��Ϊ�ɲ��������ǻ���� ����Ϊ�ջ���ĳ�ֲ����ɹ��Ϳ��Բ���ѭ����
					if ret == nil or ret == 0 then
						break
					end
				end
			end
		end
	elseif iType == 2 then		-- һ����ֲ
		if othersid or param == nil or type(param) ~= type({}) or #param ~= 5 then return end
		--look(opens)
		for index = 1, opens do
			if pGardenData[index] == nil then		-- ���ҵ��յ�
				ret = mainstore(sid,param[1],param[2],param[3],param[4],param[5])	
				--look(ret)
				if ret then
					--look(param[5])
					GD_SowSeed(sid,index,param[5])
				else
					break
				end
			end
		end
	else
		return
	end
end

-- ��ȡ���صȼ��ӳ�
function GD_GetLandAdd(sid)
	local pGardenData = GetGardenData_Interf(sid)
	if pGardenData == nil then return end
	local lv = pGardenData.land or 1
	local conf = land_conf[lv]
	if conf == nil or type(conf) ~= type({}) then return end
	return conf[1]
end

-- �������صȼ�
function GD_UpLandLv(sid,iType)
	if iType == nil or type(iType) ~= type(0) then return end
	local pGardenData = GetGardenData_Interf(sid)
	if pGardenData == nil then return end
	local lv = pGardenData.land or 1
	if lv >= 10 then
		SendLuaMsg( 0, { ids = GD_Land, res = 1 }, 9 )
		return
	end
	local conf = land_conf[lv + 1]
	if conf == nil or type(conf) ~= type({}) then return end
	local yb = conf[2]
	if yb <= 0 then return end
	if iType == 0 then
		if not CheckCost( sid , yb , 0 , 1, "�������صȼ�") then
			SendLuaMsg( 0, { ids = GD_Land, res = 2 }, 9 )
			return
		end
	elseif iType == 1 then
		local bdyb = GetPlayerPoints(sid,3) or 0
		if bdyb < yb*10 then
			SendLuaMsg( 0, { ids = GD_Land, res = 3 }, 9 )	
			return
		end
		AddPlayerPoints(sid,3, -(yb*10), nil,"�������صȼ�",true)
	else
		return
	end
	pGardenData.land = (pGardenData.land or 1) + 1
	SendLuaMsg( 0, { ids = GD_Land, res = 0, land = pGardenData.land }, 9 )
end

-- ��½�����ܶȸ�ֵ�����صȼ�
function GD_SyncLandLv(sid)
	local pGardenData = GetGardenData_Interf(sid)
	if pGardenData == nil then return end	
	if pGardenData.land == nil then
		local degree = GETDJ_gardenadd_one(sid) or 1
		pGardenData.land = degree
		if pGardenData.land == 0 then
			pGardenData.land = 1
		end
	end
end