--[[
	file:	ׯ԰ϵͳ
	author:	csj
	update:	2012-7-24
	notes: ��Ҫ�洢�����ݣ�ׯ԰��Ϣ����԰��Ϣ����ǰװ�����ϯ���ݡ�	
--]]

--s2c_msg_def
local MRD_Init = msgh_s2c_def[37][1]	-- ��½��ʼ������
local MRD_Exps = msgh_s2c_def[37][2]	-- ����ׯ԰�ȼ�������
local MRD_SetF = msgh_s2c_def[37][3]	-- ����ׯ԰��λ���Ӷ�����״ֵ̬
--local look = look
local uv_TimesTypeTb = TimesTypeTb
local SendLuaMsg = SendLuaMsg
local MANOR_MAXLV = 100

-- ��һ�԰��Ϣ(Ŀǰ��԰����ȫ�й�)
function GetPlayerGardenData(playerid)
	local extraData = GetDBExtraData(playerid)
	if extraData == nil then return end
	if extraData.garden == nil then
		extraData.garden = {
			opens = 2,				-- ��԰���������												
			-- [1 ~ 12] = {},		-- ��԰����
		}
	end
	return extraData.garden
end

-- ��������Ϣ
function GetPlayerHerosData(playerid)
	local extraData = GetDBExtraData(playerid)
	if extraData == nil then return end
	if extraData.heros == nil then
		extraData.heros = {			
		}
	end
	return extraData.heros			-- �ҽ����	(1)
end

-- ��Ұ�������Ϣ
function GetPlayerFacData(playerid)
	local extraData = GetDBExtraData(playerid)
	if extraData == nil then return end
	if extraData.facD == nil then
		extraData.facD = {			
		}
	end
	return extraData.facD		-- ��Ұ�������Ҫ�й�����	(2)
end

-- ���ׯ԰��Ϣ(data) 
-- ע�⣺����������ʱ��ǵü�¼�������� (0) or (1) or (2)
-- (0) ����Ҫ�йܵ����� (1) ��Ҫ�йܵ����� (2) ��Ҫ�йܲ�������������ڼ���ܻ�ı������
function GetPlayerManorData(playerid)
	local extraData = GetDBExtraData(playerid)
	if extraData == nil then return end
	if extraData.manor == nil then
		extraData.manor = {			
			-- rkCD = nil,		-- ��λ��cd	(0)
			-- lsRK = {},		-- ������λ��Ϣ [1] �������λ [2] �Ƿ���ȡ��λ����			
			-- rbTS = {},		-- �Ӷ���� [1] ʣ���Ӷ���� [2] �ϴθ���ʱ�� (0)
			-- rbPS = nil		-- �ڵ�ǰ�ȼ����λ�� (0)
			-- PetD = nil,		-- �������� (0) [��ǰ����������Ҫ�й�]
			-- bFst = nil,		-- ��ʼ����־ (0) [nil] û�г�ʼ�� [1] ��λ�� [2] �Ӷ� [3] ��λ�����Ӷ� 
			
			mLv = 1,			-- ׯ԰�ȼ� (1)
			mExp = 0,			-- ׯ԰����	(1)							
			-- Tech = {},		-- ׯ԰�Ƽ�	(1)
			-- rbPT = nil,		-- �Ӷᱣ��ʱ�� (2)
			-- Rank = 0,		-- ׯ԰����	(2)
			-- Degr = 0,		-- ׯ԰ͨ���� (2)
			-- MonT = {},		-- ҡǮ��(2) [1] ��ǰ���� [2] �ϴδ�������ʱ�� [3] �´ο�����ȡʱ�� [4] ���տ�Ǯ����
		}
	end
	return extraData.manor
end

-- ���ׯ԰��Ϣ(temp)
function GetPlayerManorTemp(playerid)
	local extraTemp = GetDBExtraTemp(playerid)
	if extraTemp == nil then return end
	if extraTemp.manor == nil then
		extraTemp.manor = {
			-- mrkName = nil,	-- ׯ԰��λ����������
			-- mrkRNK = nil,	-- ��ǰ��������
			-- mrkGID = nil,	-- ׯ԰��λ����ͼGID
			-- mrkAwards = nil,	-- ׯ԰��λ������
			
			-- mrbName = nil,	-- ׯ԰�Ӷ��������
			-- mrbSID = nil,	-- ׯ԰�Ӷ����SID
		}
	end
	return extraTemp.manor
end

-- ׯ԰��λ�� �ݴ�����ǰ500λ�����
function GetManorRankList()
	local worldRank = GetWorldRankData()
	if worldRank == nil then return end
	if worldRank.manorRank == nil then
		worldRank.manorRank = {}
	end
	
	return worldRank.manorRank
end

-- ׯ԰͵Ϯ�б�(�Եȼ�ΪKey��sid�б�)
function GetManorRobberyList()
	local worldRank = GetWorldRankData()
	if worldRank == nil then return end
	if worldRank.manorRobbery == nil then
		worldRank.manorRobbery = {}
	end
	
	return worldRank.manorRobbery
end

-- ���ڵ���
function CL_ManorRobbery()
	local worldRank = GetWorldRankData()
	if worldRank == nil then return end
	worldRank.manorRobbery = nil
end

-- ���ڵ���
function CL_ManorRank()
	local worldRank = GetWorldRankData()
	if worldRank == nil then return end
	worldRank.manorRank = nil
end

-- �ǻ�Ծ��ҡ�������������( �ṩ��500������Ļ�Ծ��� )
-- outline and lv >= 30 and rank <= 500 and  lv < 40
function GetNonActiveList()
	local worldRank = GetWorldRankData()
	if worldRank == nil then return end
	if worldRank.NActList == nil then
		worldRank.NActList = {}
	end
	
	return worldRank.NActList
end 

--------------------------------------------ׯ԰���-----------------------------------------------

-- othersid == nil ȡ�Լ�ׯ԰����/��ʱ������(�ȼ������顢����)
-- othersid ~= nil ȡ����ׯ԰����(�ȼ������顢����)
-- iType: [1] �������ׯ԰ [2] �򿪱��˹�԰
function SyncManorData(sid,othersid,iType)
	-- look("SyncManorData:" .. sid)
	local playerid = othersid or sid
	local pManorData = GetManorData_Interf(playerid)
	if othersid then
		if pManorData == nil then		-- ��ҪĬ�ϸ�������
			SendLuaMsg( sid, { ids = MRD_Init, lv = 1, exps = 1, othersid = othersid, iType = iType}, 10 )
		else
			local petID = PI_GetPetID(playerid)
			SendLuaMsg( sid, { ids = MRD_Init, lv = pManorData.mLv, exps = pManorData.mExp, petID = petID, othersid = othersid, iType = iType}, 10 )
		end		
	end
end

-- ����ׯ԰����
-- opt: [nil] �������Ӿ��� [1] �������Ӿ���(����ÿ�տɻ�����ֵ)
function AddManorExp(sid,exps,opt,index)
	if sid == nil or exps == nil then return end
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	if opt and opt == 1 then
		local tm = GetTimesInfo(sid,uv_TimesTypeTb.GD_InExp)
		if tm == nil or tm[2] == nil or tm[2] <= 0 then
			return
		end
		exps = math.min(exps,tm[2])
		if not CheckTimes(sid,uv_TimesTypeTb.GD_InExp,exps,-1) then
			return
		end
	end
	local mLv = pManorData.mLv or 1
	local mExp = pManorData.mExp or 0
	mExp = (mExp or 0) + exps
	for lv = mLv, MANOR_MAXLV do
		if mExp < (lv * lv + 35) then
			break
		end
		mExp = mExp - (lv * lv + 35)
		mLv = lv + 1
	end
	if mLv > MANOR_MAXLV then mLv = MANOR_MAXLV end
	pManorData.mLv = mLv
	pManorData.mExp = mExp
	SendLuaMsg( sid, { ids = MRD_Exps, lv = mLv, exps = mExp }, 10 )
	return exps
end

-- ���ó�ʼ����־
function PI_SetManorFirst(sid,val)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	-- look(pManorData.bFst)
	if val == 1 then		-- ������λ��
		if pManorData.bFst == nil or pManorData.bFst % 2 == 0 then	-- ���ж��������
			pManorData.bFst = (pManorData.bFst or 0) + 1
		end
	elseif val == 2 then	-- �����Ӷ�
		if pManorData.bFst == nil or rint(pManorData.bFst/2) % 2 == 0 then	-- ���ж��������
			pManorData.bFst = (pManorData.bFst or 0) + 2
		end
	end
	SendLuaMsg(sid, { ids = MRD_SetF, fst = pManorData.bFst }, 10)
end