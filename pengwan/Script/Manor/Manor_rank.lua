--[[
	file:	ׯ����λ��
	author:	csj
	update:	2013-3-11
	
notes:
	1��
--]]



local pairs,type,tostring,ipairs,rint = pairs,type,tostring,ipairs,rint
local mathrandom = math.random
local tablepush,tablemaxn = table.push,table.maxn
--local --look = --look
local SendLuaMsg,CI_GetPlayerData,GetServerTime = SendLuaMsg,CI_GetPlayerData,GetServerTime
local CI_SetPlayerData,CI_OnSelectRelive = CI_SetPlayerData,CI_OnSelectRelive
local GiveGoods,BroadcastRPC = GiveGoods,BroadcastRPC
local active_marank = active_marank
local uv_TimesTypeTb = TimesTypeTb
local MRankAwardConf = MRankAwardConf
local call_monster_dead = call_monster_dead
local PI_GetPlayerFight = PI_GetPlayerFight
local PI_GetPlayerVipType = PI_GetPlayerVipType

local db_module = require('Script.cext.dbrpc')
local manor_rank_report = db_module.manor_rank_report
local active_mgr_m = require('Script.active.active_mgr')
local active_marank = active_mgr_m.active_marank

--s2c_msg_def
local MRK_Data = msgh_s2c_def[32][1]	-- ��λ�б���Ϣ
local MRK_Enter = msgh_s2c_def[32][2]	-- ��λ�б���Ϣ
local MRK_Report = msgh_s2c_def[32][3]	-- ��λ��ս��
local MRK_Do = msgh_s2c_def[32][4]		-- �������֪ͨ��Ϣ
local MRK_ClrCD = msgh_s2c_def[32][5]	-- ����λ��CD
local MRK_Exit = msgh_s2c_def[32][6]	-- ��λ���˳�
local MRK_Award = msgh_s2c_def[32][7]	-- ��λ���˳�
local MRK_Ins = msgh_s2c_def[32][8]		-- ��λ������
local MRK_RY = msgh_s2c_def[32][9]		-- ��λ��2Сʱ����

local common_rnd = require('Script.common.random_norepeat')
local Get_num 			 = common_rnd.Get_num

MAXRANKNUM = 2000		-- ��λ����¼��(��ʱ���ø�ȫ��������Ϊ�й��ǻ��õ�)

local mapID = 512
local STAGE_ONE = 1000
local STAGE_TWO = 500
local STAGE_THREE = 200
local STAGE_FOUR = 100
local STAGE_FIVE = 50
local STAGE_SIX = 20
local STAGE_SEVEN = 10

----------------------------------------------------------
--data:
local cachelist = { {0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0}, }

----------------------------------------------------------
--inner function:

-- �Ƿ��ǵ�һ�δ���λ��
local function MR_IsFirst(sid)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	if pManorData.bFst == nil or pManorData.bFst % 2 == 0 then
		return true
	end
end

--[[
����б��㷨:
	i.	�������������200���Ժ������������Լ���1-10��11-20��21-30��31-40֮��ɸѡ4����
	ii.	�������������30���Ժ������������Լ���1-5��6-10��11-15��16-20֮��ɸѡ4����
	iii.�������������30�����ڣ���ֻ��ѡ����Լ������ߵ�����4����
	iv.	�������������4�����ڣ�����˱��Լ������ߵģ���Ҫ������Լ������͵�����Ķ��֡�
notes:
	500����������(rank == nil)�ȴӲ���Ծ����б����
]]--
local function MR_RandList(rank,lv,cacheData,bFirst)	
	if type(cacheData) ~= type({}) then return end		
	for i = 1, #cacheData do
		cacheData[i] = nil
	end
	rank = rank or MAXRANKNUM + 1
	local Need = 4
	if bFirst then			-- ��һ�����⴦��
		cacheData[1] = rank
		return
	end
	local count = 0
	if rank == nil or rank > MAXRANKNUM then
		rank = MAXRANKNUM
	end
	local start = rank - 1
	--look('start:' .. tostring(start))
	if rank > STAGE_ONE then
		local rd = mathrandom(start - 79, start - 39)
		tablepush(cacheData,rd)
		tablepush(cacheData,rd - 80)
		tablepush(cacheData,rd - 160)
		tablepush(cacheData,rd - 240)
	elseif rank > STAGE_TWO then
		local rd = mathrandom(start - 59, start - 29)
		tablepush(cacheData,rd)
		tablepush(cacheData,rd - 60)
		tablepush(cacheData,rd - 120)
		tablepush(cacheData,rd - 180)
	elseif rank > STAGE_THREE then
		local rd = mathrandom(start - 29, start - 14)
		tablepush(cacheData,rd)
		tablepush(cacheData,rd - 30)
		tablepush(cacheData,rd - 60)
		tablepush(cacheData,rd - 90)
	elseif rank > STAGE_FOUR then
		local rd = mathrandom(start - 9, start - 4)
		tablepush(cacheData,rd)
		tablepush(cacheData,rd - 10)
		tablepush(cacheData,rd - 20)
		tablepush(cacheData,rd - 30)
	elseif rank > STAGE_FIVE then
		local rd = mathrandom(start - 4, start - 1)
		tablepush(cacheData,rd)
		tablepush(cacheData,rd - 5)
		tablepush(cacheData,rd - 10)
		tablepush(cacheData,rd - 15)
	elseif rank > STAGE_SIX then
		local rd = mathrandom(start - 2, start - 0)
		tablepush(cacheData,rd)
		tablepush(cacheData,rd - 3)
		tablepush(cacheData,rd - 6)
		tablepush(cacheData,rd - 9)
	elseif rank > STAGE_SEVEN then
		local rd = mathrandom(start - 1, start - 0)
		tablepush(cacheData,rd)
		tablepush(cacheData,rd - 2)
		tablepush(cacheData,rd - 4)
		tablepush(cacheData,rd - 6)
	else
		for i = 1, Need - count do
			local rd = start
			if rd <= 0 then
				rd = rank - rd + 1
			end
			tablepush(cacheData,rd)
			start = start - 1
		end
	end
	return
end

-- �����б���Ϣ 4*6 { ����,����,�ȼ�,vip,����,����, }
local function MR_BuildCache(rands,rkList,bFirst,rank)
	-- ��������������
	for i=1 ,#(cachelist) do
		if type(cachelist[i]) == type({}) then
			for j = 1, #cachelist[i] do
				cachelist[i][j] = 0
			end
		end
	end	
	rank = rank or MAXRANKNUM + 1
	local pid = nil
	if bFirst then	-- ��һ���������⴦��
		pid = Robot_RandID(2)
		local pTBData = PI_GetTsBaseData(pid)
		if type(pTBData) == type({}) then 					
			cachelist[1][1] = rank
			cachelist[1][2] = pTBData[1]
			cachelist[1][3] = pTBData[2]
			cachelist[1][4] = pTBData[3]
			cachelist[1][5] = pTBData[4]
			cachelist[1][6] = pTBData[5]
			cachelist[1][7] = pid
		end
		return cachelist
	end
	for k, v in ipairs(rands) do
		pid = rkList[v]
		if pid ~= nil then
			if IsPlayerOnline(pid) == true then
				local pBaseData = CI_GetPlayerBaseData(pid)
				if pBaseData then
					cachelist[k][1] = v
					cachelist[k][2] = pBaseData[1]
					cachelist[k][3] = pBaseData[2]
					cachelist[k][4] = pBaseData[3]
					cachelist[k][5] = pBaseData[4]
					cachelist[k][6] = pBaseData[5]
				end
			else
				local pTBData = PI_GetTsBaseData(pid)
				if type(pTBData) == type({}) then 					
					cachelist[k][1] = v
					cachelist[k][2] = pTBData[1]
					cachelist[k][3] = pTBData[2]
					cachelist[k][4] = pTBData[3]
					cachelist[k][5] = pTBData[4]
					cachelist[k][6] = pTBData[5]
				end				
			end
		end		
	end
	
	return cachelist
end

-- ������λ��������Ϣ
local function MR_RandAward(sid,pManorTemp,res)
	if pManorTemp == nil or res == nil then return end
	local lv = CI_GetPlayerData(1,2,sid)
	local exps = nil
	local addRY = nil		-- ������
	local addSW = nil		-- ����
	if res == 1 then		-- Ӯ��
		exps = lv * 400
		addSW = 30
		addRY = 100
	else					-- ����
		exps = lv * 200
		addSW = 25
		addRY = 80
	end
	-- ������
	PI_PayPlayer(1,exps,0,0,'ׯ԰��λ������',2,sid)
	AddPlayerPoints(sid,7,addSW,nil,'ׯ԰��λ������')
	AddPlayerPoints(sid,10,addRY,nil,'ׯ԰��λ������')
	return
end

-- ��λ��ս��
local function MR_ReportProc(gSID,gRank,sRank,rankCD,bFirst)
	--look("MR_ReportProc")
	local pManorTemp = GetPlayerManorTemp(gSID)
	if pManorTemp == nil or pManorTemp.mrkSID == nil or pManorTemp.mrkRES == nil or pManorTemp.mrkSID_r == nil  then
		--look("MR_ReportProc2222")
		MR_ClearTemp(gSID)
		return 
	end	
	--look("MR_ReportProc11")
	local sName = PI_GetPlayerName(pManorTemp.mrkSID)
	-- local tsData = PI_GetTsBaseData(pManorTemp.mrkSID)
	SendLuaMsg( gSID, { ids = MRK_Report,Res = pManorTemp.mrkRES,sSID = pManorTemp.mrkSID,sName = sName,cRank = gRank,rkCD = rankCD,bFirst = bFirst}, 10 )
	if not bFirst and gRank and sRank then
		local gName = CI_GetPlayerData(5,2,gSID)
		if IsPlayerOnline(pManorTemp.mrkSID_r) then			
			SendLuaMsg( pManorTemp.mrkSID_r, { ids = MRK_Report,Res = pManorTemp.mrkRES,gSID = gSID,gName = gName,cRank = sRank}, 10 )
		end
		-- ���ô洢����дս����¼
		manor_rank_report(gSID,pManorTemp.mrkSID,gName,sName,gRank,sRank,pManorTemp.mrkSID_r,pManorTemp.mrkRES)		
	end
	-- ������ ����bFirst
	if bFirst then
		--look('PI_SetManorFirst')
		PI_SetManorFirst(gSID,1)
	end
	
	-- ���������������ж��Ƿ���Ҫ�й�,����Ҫ��ɾ���й�����
	-- ע�⣺�������Ҫȡ������������
	local fManorData = GetManorData_Interf(pManorTemp.mrkSID_r)
	if fManorData and fManorData.Rank == nil or fManorData.Rank > MAXRANKNUM then
		single_extra_del(pManorTemp.mrkSID_r)
	end
	MR_ClearTemp(gSID)
end

--[[
	��¼��λ��ս��
	@Res: [11] ������ʤ������������ [10] ������ʤ������������
		  [00] ������ʧ�ܡ���������
	@sSID: ���ط�SID�Ե�ǰ����ʵ�����SIDΪ׼(��֤ս����Ϣ��ȷ��)
	@sName: ���ط������Թ������������Ϊ׼(ʹ��ҿ�����ս����Ϣ�������)
]]--

-- սʤ:��������
local function MR_Win(sid)
	--look("MR_Win:" .. sid)
	local pManorTemp = GetPlayerManorTemp(sid)
	if pManorTemp == nil or pManorTemp.mrkSID == nil or pManorTemp.mrkRNK == nil then
		--look("MR_Win:1")
		MR_ClearTemp(sid)
		return 
	end	
	-- ����н����� ˵����û�콱(��֤�����ظ���/Ӯ)
	if pManorTemp and pManorTemp.mrkRES then
		--look("MR_Win:2")
		return 
	end
	
	local rkList = GetManorRankList()
	if rkList == nil then
		--look("MR_Win:2")
		MR_ClearTemp(sid)
		return 
	end	
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then 
		--look("MR_Win:3")
		MR_ClearTemp(sid)
		return 
	end
	-- ��һ�����⴦��
	local bFirst = MR_IsFirst(sid)
	if bFirst then
		pManorTemp.mrkSID_r = sid
		pManorTemp.mrkRES = 11
		MR_RandAward(sid,pManorTemp,1)
		MR_ReportProc(sid,pManorData.Rank,pManorData.Rank,nil,bFirst)
		return
	end

	local mRank = pManorTemp.mrkRNK
	if mRank == nil or rkList[mRank] == nil then
		--look("MR_Win:4")
		MR_ClearTemp(sid)
		return
	end
	local Res = nil	
	local sSID = rkList[mRank]			-- ���ط�SID �Ե�ǰ����ʵ�����SIDΪ׼(��֤ս����Ϣ��ȷ��)	
	local fManorData = GetManorData_Interf(sSID)
	if fManorData == nil or fManorData.Rank == nil then
		--look("MR_Win:fManorData == nil or fManorData.Rank == nil")		
		MR_ClearTemp(sid)
		return 
	end
	if fManorData.Rank ~= mRank then
		-- --look("MR_Win5:fManorData.Rank ~= mRank",1)
		-- --look(mRank)
		-- --look(fManorData.Rank)
		MR_ClearTemp(sid)
	end
	
	-- �����������ж��Ƿ��������Լ���
	if pManorData.Rank == nil or pManorData.Rank > mRank then
		-- ע�⣺�������ȡ�������ĵ�ǰ����������滻				
		rkList[mRank] = sid
		if pManorData.Rank then
			rkList[pManorData.Rank] = sSID
		end
		fManorData.Rank = pManorData.Rank or (MAXRANKNUM + 1)		
		pManorData.Rank = mRank		
		set_extra_rank(sSID,fManorData.Rank)
		set_extra_rank(sid,pManorData.Rank)		
		Res = 11
	else
		Res = 10
	end
	-- ��¼��ǰ����ʵ�����SID
	pManorTemp.mrkSID_r = sSID				
	-- ��¼���
	pManorTemp.mrkRES = Res		
	-- ���콱���б�
	MR_RandAward(sid,pManorTemp,1)		
	-- ����ս��
	MR_ReportProc(sid,pManorData.Rank,fManorData.Rank)
	-- ����ֱ�Ӹ��˽��� ����temp���������
	MR_ClearTemp(sid)
end

-- ս�ܣ�1���˳���Ϸ 2�������� 3��ʱ�䵽(���ط�ʤ) 4���л�����
local function MR_Lose(sid,iType)
	--look("MR_Lose")
	local pManorTemp = GetPlayerManorTemp(sid)
	if pManorTemp == nil or pManorTemp.mrkSID == nil or pManorTemp.mrkRNK == nil then
		--look("MR_Lose1")
		MR_ClearTemp(sid)
		return 
	end
	-- ����н����� ˵����û�콱(��֤�����ظ���/Ӯ)
	if pManorTemp and pManorTemp.mrkRES then
		--look("MR_Lose ++")
		return 
	end
	
	local rkList = GetManorRankList()
	if rkList == nil then
		--look("MR_Lose2")
		MR_ClearTemp(sid)
		return 
	end
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then 
		--look("MR_Lose3")
		MR_ClearTemp(sid)
		return 
	end
	-- ��һ�����⴦��
	local bFirst = MR_IsFirst(sid)
	if bFirst then
		pManorTemp.mrkSID_r = sid
		pManorTemp.mrkRES = 0
		MR_RandAward(sid,pManorTemp,0)
		MR_ReportProc(sid,pManorData.Rank,pManorData.Rank,nil,bFirst)
		return
	end
	
	local mRank = pManorTemp.mrkRNK
	if mRank == nil or rkList[mRank] == nil then
		--look("MR_Lose4")
		MR_ClearTemp(sid)
		return
	end
	-- ע�⣺�������ȡ�������ĵ�ǰ��ҷ���ս��
	local sSID = rkList[mRank]
	local fManorData = GetManorData_Interf(sSID)
	if fManorData == nil or fManorData.Rank == nil or fManorData.Rank ~= mRank then
		--look("MR_Lose5")
		MR_ClearTemp(sid)
		return 
	end
	-- ��¼��ǰ����ʵ�����SID
	pManorTemp.mrkSID_r = sSID
	-- ��¼���
	pManorTemp.mrkRES = 0		
	-- ���콱���б�
	MR_RandAward(sid,pManorTemp,0)
	-- ���˸�����ȴʱ��(5����)
	local vipLV = GI_GetVIPLevel(sid)
	if vipLV <= 1 then
		pManorData.rkCD = GetServerTime() + 5 * 60
	end
	-- ����ս��
	MR_ReportProc(sid,pManorData.Rank,fManorData.Rank,pManorData.rkCD)	
	-- ����ֱ�Ӹ��˽��� ����temp���������
	MR_ClearTemp(sid)
	-- �˳���Ϸ ���ͳ�ȥ
	if iType and iType == 1 then
		MR_Exit(sid,iType)		
	end
end

-- ������������
local function BaseMath(stage,wLevel,itype)
	if stage == nil or itype == nil or wLevel == nil or wLevel < 30 then 
		return 0
	end

	if stage == 1 then
		if itype == 1 then
			return rint(500000 + (wLevel - 30) * 20000)
		elseif itype == 2 then
			return rint(300000 + (wLevel - 30) * 6000)
		end		
	elseif stage == 2 then
		if itype == 1 then
			return rint(380000 + (wLevel - 30) * 15000)
		elseif itype == 2 then
			return rint(240000 + (wLevel - 30) * 3000)
		end			
	elseif stage == 3 then
		if itype == 1 then
			return rint(300000 + (wLevel - 30) * 12000)
		elseif itype == 2 then
			return rint(200000 + (wLevel - 30) * 2000)
		end			
	elseif stage == 4 then
		if itype == 1 then
			return rint(200000 + (wLevel - 30) * 8000)
		elseif itype == 2 then
			return rint(150000 + (wLevel - 30) * 1000)
		end			
	elseif stage == 5 then
		if itype == 1 then
			return rint(80000 + (wLevel - 30) * 5000)
		elseif itype == 2 then
			return rint(60000 + (wLevel - 30) * 500)
		end	
	else
		return 0
	end
end


----------------------------------------------------------
--interface:

function ClearNActList()
	local worldRank = GetWorldRankData()
	if worldRank == nil then return end
	worldRank.NActList = nil
end

-- ���ߵ��� --> ��Ӳ���Ծ����б�
function PushNActList(sid)
	--[[
	local NActList = GetNonActiveList()
	if NActList == nil then return end
	local lv = CI_GetPlayerData(17,2,sid)
	NActList[lv] = NActList[lv] or {}
	NActList[lv][sid] = 1
	]]--
end
local scList = {{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0}}
-- ����ׯ����λ����Ϣ(���4��)
function MR_SendRankList(sid)
	--look("MR_SendRankList")
	local rkList = GetManorRankList()
	if rkList == nil then return end
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	local pManorTemp = GetPlayerManorTemp(sid)
	if pManorTemp == nil then return end
	if pManorTemp.rands == nil then
		pManorTemp.rands = {}
	end
	local bFirst = MR_IsFirst(sid)
	if bFirst then
		if pManorData.Rank == nil then
			pManorData.Rank = #rkList + 1
			if pManorData.Rank <= MAXRANKNUM then
				rkList[pManorData.Rank] = sid
				set_extra_rank(sid,pManorData.Rank)		-- 500�������Ӧ�ò��ù�
			else
				pManorData.Rank = MAXRANKNUM + 1
			end			
		end
	end
	MR_RandList(pManorData.Rank,CI_GetPlayerData(1),pManorTemp.rands,bFirst)
	--look(pManorTemp.rands)
	-- ��������б�������һ�����Ϣ��
	local buildlist = MR_BuildCache(pManorTemp.rands,rkList,bFirst,pManorData.Rank)
	-- �������а�ǰ10��ǰ̨	
	for i = 1, 10 do
		scList[i][1] = 0
		scList[i][2] = 0
		scList[i][3] = 0
		scList[i][4] = 0
		if rkList[i] then
			scList[i][1] = PI_GetPlayerName(rkList[i])
			scList[i][2] = PI_GetPlayerLevel(rkList[i])
			scList[i][3] = PI_GetPlayerFight(rkList[i])
			scList[i][4] = PI_GetPlayerVipType(rkList[i])
		end
	end

	--look(buildlist)
	-- ��� bFirst == true ǰ̨���⴦���������Լ���������ʾ����
	SendLuaMsg( 0, { ids = MRK_Data, rank = pManorData.Rank, scList = scList, data = buildlist, rkCD = pManorData.rkCD, bFirst = bFirst }, 9 )
end

-- �����λ�б�(�ȼ�����)
function MR_PushRank(sid)	
	local pManorData = GetManorData_Interf(sid)	
	-- ���������������
	-- --look("Rank:" .. tostring(pManorData.Rank))
	if pManorData == nil or pManorData.Rank ~= nil then
		return
	end
	-- --look("MR_PushRank:" .. sid)
	local ranklist = GetManorRankList()
	if #ranklist < MAXRANKNUM then
		tablepush(ranklist,sid)
		pManorData.Rank = #ranklist
	end
end

-- ��CD
function MR_ClearRankCD(sid,iType)
	if iType == nil then return end
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	local now = GetServerTime()
	if pManorData.rkCD and now < pManorData.rkCD then
		local yb = rint((pManorData.rkCD - now) / 60) + 1
		-- ��Ǯ
		if iType == 0 then
			if not CheckCost(sid,yb,0,1,"100018_��λ����CD") then
				SendLuaMsg( 0, { ids = MRK_ClrCD, res = 1 }, 9 )	
				return
			end
		elseif iType == 1 then
			local bdyb = GetPlayerPoints(sid,3)
			if bdyb < yb*5 then
				SendLuaMsg( 0, { ids = MRK_ClrCD, res = 1 }, 9 )	
				return
			end
			AddPlayerPoints(sid,3, -(yb*5), nil,"��λ����CD",true)			
		else
			return
		end
	end
	
	pManorData.rkCD = nil
	SendLuaMsg( 0, { ids = MRK_ClrCD }, 9 )	
end

local ABornPos = {{13,31,2},{11,28,2}}
local DBornPos = {{17,31,6},{19,28,6}}
local ATargPos = {{14,31},{14,28}}
local DTargPos = {{16,31},{16,28}}

-- ��λ
function MR_Fight(sid,idx,fid)
	if sid == nil or idx == nil then return end
	local rkList = GetManorRankList()
	if rkList == nil then return end
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	local pManorTemp = GetPlayerManorTemp(sid)
	if pManorTemp == nil or pManorTemp.mrkSID ~= nil then		
		return
	end
	-- 1���ж��Ƿ�������б�
	if pManorTemp.rands == nil then
		return
	end
	-- 2����֤ǰ̨���͵�idx��ȷ��
	--look("MR_Fight 4")
	local ck = 0
	for k, v in pairs(pManorTemp.rands) do
		if idx == v then
			ck = 1
			break
		end
	end
	if ck == 0 then
		--look("idx is erro")
		return
	end
	-- 3���жϴ���
	if not CheckTimes(sid,uv_TimesTypeTb.MK_Attack,1,-1,1) then
		--look("��λ�������������ޣ��ף�")			
		return
	end
	-- 4���ж�CD
	if pManorData.rkCD ~= nil then
		if GetServerTime() < pManorData.rkCD then
			--look("��ȴʱ��δ��")			
			return
		end
	end
	local bFirst = MR_IsFirst(sid)
	local pid = fid or rkList[idx]
	if pid == nil then return end
	if sid == pid then
		--look("�������Լ�Ŷ")
		return
	end	
	local fManorData = GetManorData_Interf(pid)
	if fManorData == nil then
		return 
	end
	--5������PK���� (�Զ�ɾ������)	
	local mapGID = active_marank:createDR(1,nil,sid,sid)
	if mapGID == nil then
		--look("active_marank:createDR err when MR_Fight")
		return
	end
	
	local mrkDRData = active_marank:get_regiondata(mapGID)
	if mrkDRData == nil or type(mrkDRData) ~= type({}) then return end
	
	local Aobj = 0		-- ��������������
	local Dobj = 0		-- ���ط���������
	local AheroGID = nil
	local DheroGID = nil
	
	local spfobj = 10		-- ���ȹ���Ĭ��ֵ
	local shfobj = 11
	local gpfobj = 9
	local ghfobj = 12
	local spftag = DTargPos[1]
	local shftag = DTargPos[2]
	local gpftag = ATargPos[1]
	local ghftag = ATargPos[2]
	-- ���÷��ط����ȹ���
	if fManorData.pfobj and fManorData.pfobj == 1 then
		spfobj = 11
		-- spftag = DTargPos[2]
	end
	if fManorData.hfobj and fManorData.hfobj == 1 then
		shfobj = 10
		-- shftag = DTargPos[1]
	end
	-- ���ù��������ȹ���
	if pManorData.pfobj and pManorData.pfobj == 1 then
		gpfobj = 12
		-- gpftag = ATargPos[2]
	end
	if pManorData.hfobj and pManorData.hfobj == 1 then
		ghfobj = 9
		-- ghftag = ATargPos[1]
	end	
	-- ȡ��ҹ�����ֵ
	local gIns = pManorData.ins or 0
	local sIns = fManorData.ins or 0
	--6����������(����)	
	local monsterConf = PlayerMonsterConf[1]
	local ret, monGID = CreatePlayerMonster(1,pid,monsterConf,mapGID,DBornPos[1],5,spfobj,spftag)
	if ret == nil then return end
	if sIns > 0 then
		CI_AddBuff(9,0,sIns,false,4,monGID)
	end
	local herosConf = PlayerMonsterConf[9]
	Dobj, DheroGID = CreateRankHeros(pid,herosConf,mapGID,DBornPos[2],5,shfobj,shftag)
	Dobj = (Dobj or 0) + 1
	--look('Dobj' .. Dobj)
	--7�������Լ�(����)
	monsterConf = PlayerMonsterConf[7]
	local res, plaGID = CreatePlayerMonster(1,sid,monsterConf,mapGID,ABornPos[1],6,gpfobj,gpftag)
	if res == nil then return end
	if gIns > 0 then
		CI_AddBuff(9,0,gIns,false,4,plaGID)
	end
	herosConf = PlayerMonsterConf[8]
	Aobj, AheroGID = CreateRankHeros(sid,herosConf,mapGID,ABornPos[2],6,ghfobj,ghftag)
	Aobj = (Aobj or 0) + 1
	--look('Aobj' .. Aobj)
	--8��PutPlayerTo	
	if not active_marank:add_player(sid, 1, 0, nil, nil, mapGID) then
		--look("PI_MovePlayer err when MR_Fight")
		return
	end
	
	--9�� �����������
	local rset = CI_SetPlayerData(2,1)
	--look('rset:' .. rset)
	
	--10������������۴���(��Ϊǰ���Ѿ����ù������ ��������Ӧ�ò���ʧ����)	
	if not CheckTimes(sid,uv_TimesTypeTb.MK_Attack,1,-1) then
		--look("��λ�������������ޣ��ף�")			
		return
	end
	
	-- 11������Ѫ��
	-- PI_PayPlayer(3,1000000)
	
	mrkDRData.gSID = sid			-- ���ù�����SID
	mrkDRData.record = {}
	mrkDRData.record[1] = {Aobj,plaGID,AheroGID}
	mrkDRData.record[2] = {Dobj,monGID,DheroGID}
	
	pManorTemp.mrkSID = pid			-- ����SID(���ʱ��ǰ��λ��sid) 
	pManorTemp.mrkBEG = GetServerTime()		-- ��λ����ʼʱ��
	pManorTemp.mrkRNK = idx			-- ��������
	pManorTemp.mrkGID = mapGID		-- ����GID
	
	SendLuaMsg( 0, { ids = MRK_Enter, tm = 3*60, record = mrkDRData.record }, 9 )
end

local function GetPerHP(mon_gid)
	local curHP = GetMonsterData(6,4,mon_gid)
	if curHP == nil or curHP < 0 then
		return 0
	end
	local totalHP = GetMonsterData(7,4,mon_gid)
	if totalHP == nil or curHP < 0 then
		return 0
	end
	local perHP = rint((curHP / totalHP) * 100)
	return perHP
end

-- ���ٲ鿴���
-- ���Ӧ�ò��ÿ����Ƿ��ǵ�һ�δ� ��Ϊ40���ſ��Ų鿴����
function MR_FastView(sid)
	local pManorTemp = GetPlayerManorTemp(sid)
	if pManorTemp == nil or pManorTemp.mrkSID == nil or pManorTemp.mrkGID == nil then		
		return
	end
	if pManorTemp.mrkRES then
		--look("MR_FastView fight has end")
		return 
	end
	local sSID = pManorTemp.mrkSID
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	local fManorData = GetManorData_Interf(sSID)
	if fManorData == nil then return end
	
	local mapGID = pManorTemp.mrkGID
	
	local gFight = CI_GetPlayerData(62,2,sid) or 0
	local sFight = PI_GetPlayerFight(sSID) or 0
	local gIns = pManorData.ins or 0
	local sIns = fManorData.ins or 0
	gFight = rint(gFight * (1 + gIns*0.01))
	sFight = rint(sFight * (1 + sIns*0.01))
	-- local fper = math.abs(gFight - sFight) / (gFight)
	-- local alpha = (gFight + sFight < 160000 and 36) or 13
	-- local beta = (gFight + sFight < 160000 and 2.5) or 3 
	-- local gamma = (gFight + sFight < 160000 and 16000) or 5200
	-- local winper = rint((fper * 100 + alpha)^beta / gamma * 10000)
	-- if gFight < sFight then
		-- winper = 10000 - winper
	-- end
	-- if winper < 0 then
		-- winper = 0
	-- end
	
	
	-- local mrkDRData = active_marank:get_regiondata(mapGID)
	-- if mrkDRData == nil or type(mrkDRData) ~= type({}) then 
		-- return 
	-- end
	-- local record = mrkDRData.record
	-- local Aper = GetPerHP(record[1][2])
	-- local Dper = GetPerHP(record[2][2])
	-- if Dper == 0 then
		-- winper = 10000
	-- else
		-- winper = winper + rint(Aper - Dper) * 100
	-- end
	-- --look('winper:' .. tostring(winper))
	-- local rd = math.random(1,10000)
	if gFight >= sFight then
		MR_Win(sid)
	else
		MR_Lose(sid)
	end

	-- �Ƴ�����
	RemoveObjectIndirect(mapGID,9)
	RemoveObjectIndirect(mapGID,10)
	RemoveObjectIndirect(mapGID,11)
	RemoveObjectIndirect(mapGID,12)
end

-- ����
function MR_Inspire(sid,iType)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	local ins = pManorData.ins or 0
	if ins >= 20 then
		SendLuaMsg( 0, { ids = MRK_Ins, res = 1 }, 9 )
		return
	end
	local yb = 2
	-- ��Ǯ
	if iType == 0 then
		if not CheckCost(sid,yb,0,1,"��λ������") then
			SendLuaMsg( 0, { ids = MRK_Ins, res = 2 }, 9 )	
			return
		end
	elseif iType == 1 then
		local bdyb = GetPlayerPoints(sid,3)
		if bdyb < yb*5 then
			SendLuaMsg( 0, { ids = MRK_Ins, res = 2 }, 9 )	
			return
		end
		AddPlayerPoints(sid,3, -(yb*5), nil,"��λ������",true)			
	else
		return
	end
		
	local rate = 0
	if ins >= 0 and ins <= 8 then
		rate = 10000 - ins * 1000
	else
		rate = 2000
	end
	local rd = mathrandom(1,10000)
	if rd <= rate then
		ins = ins + 1
	end
	pManorData.ins = ins
	SendLuaMsg( 0, { ids = MRK_Ins, res = 0, ins = ins }, 9 )
end

-- ��λ����������
function MR_AwardProc(sid)
	-- --look("MR_AwardProc")
	
	-- local pManorTemp = GetPlayerManorTemp(sid)
	-- if pManorTemp == nil or pManorTemp.mrkAwards == nil then
		-- MR_ClearTemp(sid)
		-- return 
	-- end
	
	-- SendLuaMsg( 0, { ids = MRK_Do, awd = pManorTemp.mrkAwards}, 9 )
end

-- ��λ���˳���Ϣ����
-- ���жϵ�ǰ���ڳ����Ƿ�Ϊս��������������ǾͲ��ô�����
function MR_Exit(sid,iType)
	--look("MR_Exit")
	-- ������Ƴ�����
	active_marank:back_player(sid)
	
	-- ������ʱ����
	MR_ClearTemp(sid)
	
	SendLuaMsg( 0, { ids = MRK_Exit }, 9 )
end

-- ������������
local function AddDeadObj(mapGID,bside)
	--look('rank AddDeadObj:' .. mapGID .. ':' .. bside)
	local mrkDRData = active_marank:get_regiondata(mapGID)
	if mrkDRData == nil or type(mrkDRData) ~= type({}) then return end
	local sid = mrkDRData.gSID
	if sid == nil then
		--look("manor rank AddDeadObj logic erro")
		return
	end
	local pManorTemp = GetPlayerManorTemp(sid)
	if pManorTemp == nil or pManorTemp.mrkSID == nil or pManorTemp.mrkRNK == nil then
		--look("OnMonsteDead_MR_ClearTemp")
		MR_ClearTemp(sid)
		return
	end
	local record = mrkDRData.record
	--look(record)
	if record == nil or record[1] == nil or record[2] == nil then return end
	--look('record')
	
	if bside == 0 then			-- ���ط������������� +1		
		record[2][1] = (record[2][1] or 0) - 1
		if record[2][1] <= 0 then
			MR_Win(sid)
		end	
	elseif bside == 1 then		-- ������������������ +1		
		record[1][1] = (record[1][1] or 0) - 1
		if record[1][1] <= 0 then			
			MR_Lose(sid)
		end	
	end
end

-- ���ط���������
call_monster_dead[1] = function (mapGID)
	--look('AddDeadObj 0')
	AddDeadObj(mapGID,0)
end

-- ��������������
call_monster_dead[7] = function (mapGID)
	--look('AddDeadObj 1')
	AddDeadObj(mapGID,1)
end

-- ��λ���������
function MR_BuyTimes(sid,num)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then 		
		return 
	end
	if num <= 0 then return end
	if not CheckTimes(sid,uv_TimesTypeTb.MK_Attack,num,1,1) then
		--look("����������㣡")
		return
	end
	if not CheckCost(sid,rint(20*num),0,1,'��λ���������') then
		--look("Ǯ��ľ�а������������")			
		return
	end
	if not CheckTimes(sid,uv_TimesTypeTb.MK_Attack,num,1) then
		--look("�������ˣ�����Ʒ�����Ⱑ���ף�")			
		return
	end
end

-- �������ȹ���Ŀ��
-- �ҽ���Ĭ�����ȹ����ҽ�
-- ��ң�Ĭ�����ȹ������
-- obj: [nil or 0] Ĭ��ֵ [1] ���ȹ�����ת
function set_fight_obj(sid,setv)
	if sid == nil or type(setv) ~= type({}) then return end
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then 		
		return 
	end
	
	pManorData.hfobj = setv[1]	-- ���üҽ����ȹ�������			
	pManorData.pfobj = setv[2]	-- ����������ȹ�������		
end

-- ��λ�����߽���������
-- function MRK_OnlineProc(sid)
	-- local pManorTemp = GetPlayerManorTemp(sid)
	-- if pManorTemp == nil then return end
	-- if pManorTemp.mrkRES and pManorTemp.mrkRDList and pManorTemp.mrkSID_r and pManorTemp.mrkAwards then
		-- MR_ReportProc(sid)
	-- end
-- end

-- ��������
function active_marank:on_playerdead(sid,rid,mapGID)
	--look('MaRank_playerdead')	
	CI_OnSelectRelive(0,3*5,2,sid)
	return 1
end

-- �����л�����
function active_marank:on_regionchange(sid)
	--look('MaRank_regionchange')
	-- ȡ���������
	local rset = CI_SetPlayerData(2,0)
	MR_Lose(sid)
end

-- ��λ�����ߴ���
function active_marank:on_logout(sid)
	--look('MaRank_logout')	
	MR_Lose(sid,1)
end

-- ��λ�����ߴ���
function active_marank:on_login(sid)
	--look('MaRank_login')	
	local pManorTemp = GetPlayerManorTemp(sid)
	if pManorTemp == nil then return end
	-- ��˵���Ѿ�������ˡ����Ǽ�Ȼ�������������˵������ڻ���λ�������Ǿ���Ҫ�߳�ȥ
	if pManorTemp.mrkSID == nil or pManorTemp.mrkGID == nil then		
		-- ������Ƴ�����
		--look('active_marank on_login back_player')
		active_marank:back_player(sid)
		return
	end
	--look('MaRank_login111')
	local mrkDRData = active_marank:get_regiondata(pManorTemp.mrkGID)
	if mrkDRData == nil then return end
	if pManorTemp.mrkSID and pManorTemp.mrkRNK and pManorTemp.mrkBEG then
		local interval = GetServerTime() - pManorTemp.mrkBEG
		if interval < 3 * 60 then
			SendLuaMsg( 0, { ids = MRK_Enter, tm = 3*60 - interval, record = mrkDRData.record }, 9 )
		end	
	end
end

-- ����ʱ��������
function active_marank:on_DRtimeout(mapGID, args)
	if args == nil or type(args) ~= type(0) then
		return
	end
	local sid = args
	MR_Lose(sid)
end

-- ÿ���������ֵ
function MR_ClearInspire(sid)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then 		
		return 
	end
	pManorData.ins = 0
end

-- ����ׯ԰��λ����ʱ����
function MR_ClearTemp(sid)
	local pManorTemp = GetPlayerManorTemp(sid)
	if pManorTemp == nil then
		return
	end
	-- ����ʱ���е���ʱ����
	pManorTemp.mrkSID = nil	
	pManorTemp.mrkGID = nil
	pManorTemp.mrkRNK = nil
	pManorTemp.mrkBEG = nil
	
	-- ������˲��е���ʱ����
	pManorTemp.mrkRES = nil		
	pManorTemp.mrkSID_r = nil
	-- pManorTemp.mrkRDList = nil
	-- pManorTemp.mrkAwards = nil
	
	-- CI_SetPlayerData(2,0)	-- ������ʱ��Ҫ����ȡ������
end


-------------------------------------------------��λ��ÿ����λ����-------------------------------------

-- ��Ҫʱ�����ñ����õ���
function MRK_RankAward()
	--look('------------MRK_RankAward 1----------------')
	local rkList = GetManorRankList()
	if rkList == nil then return end
	--look('------------MRK_RankAward 2----------------')
	local pManorData
	local wLevel = GetWorldLevel() or 1
	--if __debug then wLevel = 50 end			--�����á�����ɾ��
	if wLevel < 30 then 
		wLevel = 30
	end
	for rk, pid in ipairs(rkList) do
		pManorData = GetManorData_Interf(pid)
		if pManorData and pManorData.Rank then
			--look('pid:' .. pid)
			pManorData.lsRK = pManorData.Rank			
		end
	end
	-- �㲥��Ϣ ��ʾ����콱
	--look('------------MRK_RankAward 3----------------')
	BroadcastRPC('MRK_Award')
end

-- ��ȡ��λ����
function MRK_GiveAward(sid)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	if pManorData.lsRK == nil then		-- ˵��û��������
		--look('pManorData.lsRK == nil')
		return
	end
	if CI_GetPlayerData(1) < 35 then
		--look("С���ӣ��ȼ������ۣ�")
		SendLuaMsg( 0, { ids=MRK_Award, res = 1 }, 9 )
		return
	end	
	local wLevel = GetWorldLevel() or 1
	--if __debug then wLevel = 50 end			--�����á�����ɾ��
	if wLevel < 30 then 
		wLevel = 30
	end
	--look(pManorData.lsRK)
	if not CheckTimes(sid,uv_TimesTypeTb.MK_Get,1,-1) then		
		--look("��������ˣ�̰���˹�~")
		SendLuaMsg( 0, { ids=MRK_Award, res = 2 }, 9 )
		return
	end
	-- 3������������ȡ����
	local sMoney,sLQ,sSW,sRY = 0, 0, 0, 0
	if pManorData.lsRK == 1 then
		sMoney = BaseMath(1,wLevel,1)
		sLQ = BaseMath(1,wLevel,2)
		sSW = 3000
		sRY = 4000
	elseif pManorData.lsRK == 2 then
		sMoney = BaseMath(2,wLevel,1)
		sLQ = BaseMath(2,wLevel,2)
		sSW = 2200
		sRY = 3000
	elseif pManorData.lsRK == 3 then
		sMoney = BaseMath(3,wLevel,1)
		sLQ = BaseMath(3,wLevel,2)
		sSW = 1600
		sRY = 2500
	elseif pManorData.lsRK >= 4 and pManorData.lsRK <= 10 then
		sMoney = BaseMath(3,wLevel,1) - rint( (BaseMath(3,wLevel,1) - BaseMath(4,wLevel,1)) * (pManorData.lsRK - 3) / 7 )
		sLQ = BaseMath(3,wLevel,2) - rint( (BaseMath(3,wLevel,2) - BaseMath(4,wLevel,2)) * (pManorData.lsRK - 3) / 7 )
		sSW = 1200 - rint((pManorData.lsRK - 4) * 50)
		sRY = 2000
	elseif pManorData.lsRK >= 11 and pManorData.lsRK <= 500 then
		sMoney = BaseMath(4,wLevel,1) - rint( (BaseMath(4,wLevel,1) - BaseMath(5,wLevel,1)) * (pManorData.lsRK - 10) / 490 )
		sLQ = BaseMath(4,wLevel,2) - rint( (BaseMath(4,wLevel,2) - BaseMath(5,wLevel,2)) * (pManorData.lsRK - 10) / 490 )
		sSW = rint((970 / (pManorData.lsRK ^ 0.2)) + 200)
		sRY = rint((160 - (pManorData.lsRK / 5)) * 10)
	elseif pManorData.lsRK > 500 then
		sMoney = BaseMath(4,wLevel,1) - rint(BaseMath(4,wLevel,1) - BaseMath(5,wLevel,1))
		sLQ = BaseMath(4,wLevel,2) - rint(BaseMath(4,wLevel,2) - BaseMath(5,wLevel,2))
		sSW = rint((970 / (pManorData.lsRK ^ 0.2)) + 200)
		sRY = 500
	end	
	if sMoney < 0 then sMoney = 0 end
	if sLQ < 0 then sLQ = 0 end
	if sSW < 0 then sSW = 0 end
	if sRY < 0 then sRY = 0 end
	
	-- ������
	GiveGoods(0,sMoney,1,'��λ����λ����')
	AddPlayerPoints( sid, 2, sLQ, nil, "��λ����λ����" )
	AddPlayerPoints( sid, 7, sSW, nil, "��λ����λ����" )
	AddPlayerPoints( sid, 10, sRY, nil, "��λ����λ����" )
	
	SendLuaMsg( 0, { ids=MRK_Award, res = 0, sMoney = sMoney, sLQ = sLQ, sSW = sSW, sRY = sRY, lsRK = pManorData.lsRK }, 9 )	
	pManorData.lsRK = nil
	-- local index = table.locate(EDayRKAwardConf,pManorData.lsRK,1)
	-- if index then
		-- local conf = EDayRKAwardConf[index]
		-- if conf and conf.Mon and conf.LQ then
			-- local addMoney = (conf.Mon[1] + (wLevel - 30) * conf.Mon[2]) * 10000
			-- local addLQ = (conf.LQ[1] + (wLevel - 30) * conf.LQ[2]) * 10000
			-- GiveGoods(0,addMoney)
			-- AddPlayerPoints( sid, 2 , addLQ )
		-- end
	-- end
end

-- ��λ��ǰ100�� ÿ��Сʱ��������ֵ
function MRK_AddHonor()
	local tm = os.date('*t',GetServerTime())
	if tm.hour >= 9 and tm.hour % 2 == 1 then
		local rkList = GetManorRankList()
		if rkList == nil then return end
		local honor = 0
		for i = 1, 100 do
			local pid = rkList[i]
			if i == 1 then
				honor = 700
			elseif i == 2 then
				honor = 560
			elseif i == 3 then
				honor = 500
			elseif i >= 4 and i <= 10 then
				honor = rint(500 - (i*8))
			elseif i >= 11 and i <= 20 then
				honor = rint(420 - 5*(i - 10))
			elseif i >= 21 and i <= 50 then
				honor = rint(370 - 3*(i - 20))
			elseif i >= 51 and i <= 100 then
				honor = rint(280 - 2*(i - 50))
			elseif i >= 101 and i <= 200 then
				honor = rint(180 - 1*(i - 100))
			end	
			if honor > 0 then
				PI_AddPlayerRY(pid,honor)
				if IsPlayerOnline(pid) then
					SendLuaMsg( pid, { ids = MRK_RY, rk = i }, 10 )
				end
			end
		end
	end
end

--�����λ��������й����ݵ������Ƿ�һ��
function MRK_LoginCheckRankData(sid)	
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	--���δ�μӹ���λ��
	if pManorData.bFst == nil or pManorData.bFst % 2 == 0  then return end
	local rkList = GetManorRankList()
	local rank = pManorData.Rank 
	--�������������rank�Ƿ���ȷ
	--��λ��2000���� ������
	--����Ƿ��������� 
	if rank ~= nil then  
		if rank > MAXRANKNUM then return end
		if rkList[rank] ~= nil and rkList[rank] == sid then return end
		--����й����ݴ���
		rank = nil 
	end

	--�Ѿ��μӹ���λ�� �� �������Ϊ�� �����ݴ���
	if rank == nil then
		--�������λ��Ϣ���¸�ֵ (��������а��������ݵĻ�)
		for k, v in ipairs(rkList) do
			if sid == v then 
				pManorData.Rank  = k
				set_extra_rank(sid, pManorData.Rank)	
				rank = k
				break;
			end
		end
		--rankΪ��, ���Ҳ������а���..
		if rank == nil then 
			--������� Ϊ��һ�βμ���λ��
			pManorData.bFst = nil
			pManorData.Rank = nil
		end
	end
end