--[[ 
	�й���غ���
--]]

--------------------------------------------------------------------------
--include:
local type,tostring,pairs = type,tostring,pairs
local TSS_Config = TSS_Config
--local --look = --look
local IsPlayerOnline = IsPlayerOnline
local AddPlayerPoints = AddPlayerPoints
local CI_GetPlayerBaseData = CI_GetPlayerBaseData
local GetHeroInfo = GetHeroInfo
local GetServerTime = GetServerTime

--------------------------------------------------------------------------
-- data:
-- ����������� ���ڵ�һ�δ���λ��
local monBaseAttr = { monAtt = {9000,0,200,400,200,100,100,100,100}, }

--------------------------------------------------------------------------
-- inner function:

function GetWorldExtraData()
	dbMgr.extra_data.data = dbMgr.extra_data.data or {
		-- �Ӷ�
		[2001] = TSS_Config[2001],
		[2002] = TSS_Config[2002],
		[2003] = TSS_Config[2003],
		[2004] = TSS_Config[2004],
		[2005] = TSS_Config[2005],
		[2006] = TSS_Config[2006],
	}	

	return dbMgr.extra_data.data
end

function GetWorldDelData()
	dbMgr.del_data.data = dbMgr.del_data.data or {}	

	return dbMgr.del_data.data
end

local function GetWorldExtraTemp()
	dbMgr.extra_data.temp = dbMgr.extra_data.temp or {}
	return dbMgr.extra_data.temp
end

local function GetSingleExtraData(playerid)
	local wExtra = GetWorldExtraData()
	if wExtra[playerid] == nil then
		return
	end
	return wExtra[playerid]
end

local function GetSingleExtraTemp(playerid)
	local wExtra = GetWorldExtraTemp()
	if wExtra[playerid] == nil then		
		wExtra[playerid] = {}
	end
	return wExtra[playerid]
end

--------------------------------------------------------------------------
-- interface:

-- ��ȡ����й�������
function GetDBExtraData(playerid)
	local extra_data=GI_GetPlayerData( playerid , 'etcD' , 1250 )
	if extra_data == nil then return end
	----look(tostring(extra_data))
--	--look(extra_data)
	return extra_data
end

function GetDBExtraTemp(playerid)
	local extra_tempdata=GI_GetPlayerTemp( playerid , 'etcT' )
	if extra_tempdata == nil then return end
	----look(tostring(extra_tempdata))
	return extra_tempdata
end

-- ��������ļ����ׯ԰͵Ϯ����λ���������������Ҫ�ű���������а���ϢҲ���Դ�ţ�
-- �����ʱ��д���а�ͨ�ú�����ʱ������Ƕ�
function GetWorldRankData()	
	dbMgr.world_rank_data.data = dbMgr.world_rank_data.data or {}
	return dbMgr.world_rank_data.data
end

-- ��һ�δ���λ����ʱ���¼(��֤崻���ʱ��������й�����)
function set_extra_rank(playerid,rank)
	local wExtra = GetWorldExtraData()
	if wExtra == nil then return end
	if wExtra[playerid] == nil then
		if rank > MAXRANKNUM then 
			--look('sererr:' .. tostring(rank).."  __"..tostring(playerid),1)
			return 
		end
		wExtra[playerid] = {}
		wExtra.num = (wExtra.num or 0) + 1
		
		wExtra[playerid].logout = GetServerTime()
		wExtra[playerid].acct = wExtra[playerid].logout
		--look('set_extra_rank:' .. tostring(rank).."  __"..tostring(wExtra.num))
	end
	local worldExtra = wExtra[playerid]
	worldExtra.manor = worldExtra.manor or {}
	worldExtra.manor.Rank = rank
end

-- ������ߵ���
-- �й�����ͬ�����������(ֻͬ�����ߺ��仯����)
-- �����ҳ�ʱ�䲻���� �����й��������Ѿ������ɾ������
function World_to_Player(playerid)
	--look('World_to_Player:' .. tostring(playerid))
	-- ���������
	if IsSpanServer() then
		return
	end
	local playerExtra = GetDBExtraData(playerid)
	if playerExtra == nil then
		--look('World_to_Player playerExtra == nil')
		return 
	end
	local worldExtra = GetSingleExtraData(playerid)	-- ���Ϊnil˵��û�йܻ�ɾ��(���û�������ݿ��ֱ�ӷ���)
	if worldExtra == nil then
		if playerExtra.manor and playerExtra.manor.Rank then
			playerExtra.manor.Rank = nil
		end
		--look('World_to_Player worldExtra == nil')
		return 
	end
	
	--look(playerExtra.manor)
	--look(worldExtra.manor)
	-- ͬ��{ׯ԰��λ��ͨ���ȡ��Ӷᱣ��ʱ�䡢ҡǮ��, ������λ}
	if playerExtra.manor ~= nil and worldExtra.manor ~= nil then
		playerExtra.manor.Rank = worldExtra.manor.Rank
		playerExtra.manor.Degr = worldExtra.manor.Degr
		playerExtra.manor.rbPT = worldExtra.manor.rbPT
		playerExtra.manor.MonT = worldExtra.manor.MonT
		playerExtra.manor.lsRK = worldExtra.manor.lsRK		-- �������Ҫ����Ϊ��Ҳ�����߻��޸ĵ�����
	end
	-- ��������������ȷ(��ֹ������崻�������ݲ�һ��)
	if playerExtra.manor ~= nil and worldExtra.manor == nil then
		playerExtra.manor.Rank = nil
	end
	-- ͬ����԰����(ֻ��ͬ����͵��������ʱȫ��ͬ��)
	if playerExtra.garden ~= nil and worldExtra.garden ~= nil then
		playerExtra.garden = worldExtra.garden						
	end
	-- ͬ��ս��
	-- local zgValue = worldExtra.zgValue or 0
	-- AddPlayerPoints(playerid,6,zgValue,1,'ͬ��ս��')
	-- ͬ������ֵ
	local ryval = worldExtra.ryval or 0
	AddPlayerPoints(playerid,10,ryval,1,'ͬ������ֵ')
	-- ͬ������������
	if playerExtra.facD ~= nil and worldExtra.facD ~= nil then
		playerExtra.facD = worldExtra.facD					
	end
	-- ���ð��ID
	local tsData = worldExtra.tsData
	if tsData and tsData[1] and tsData[1][6] and tsData[1][6] > 0 then
		CI_SetPlayerData(5,tsData[1][6]) 
	end
	--look('World_to_Player:' .. tostring(playerid) .. '__complete')
end

-- ������(��λ��ǰ500��) or ��԰��ֲ or ����͵Ϯ(lv >= 43)
function CheckNeedTs(playerid)
	local playerExtra = GetDBExtraData(playerid)
	if playerExtra == nil then return false end	
	local lv = CI_GetPlayerData(1)
	-- if lv < 34 then return false end		-- ���Ǹ��ĵȼ���̫���� ���׳����� ������ʱ���ж���
	if lv >= 43 then return true end
	if playerExtra.garden then
		for k, v in pairs(playerExtra.garden) do
			if v ~= nil then
				return true
			end
		end
	end
	if playerExtra.manor and playerExtra.manor.Rank and playerExtra.manor.Rank <= MAXRANKNUM then
		return true
	end
	
	return false
end

-- ɾ����ʱ�� t = nil ins = -1
local function set_extra_debug(t,ins)
	local wExtra = GetWorldExtraData()
	if wExtra == nil then return end
	--[[
	if t then
		local s = t[''].__s
		if wExtra.single == nil then
			wExtra.single = s
		else
			wExtra.single = (wExtra.single < s and s) or wExtra.single
		end
	end
	]]--
	wExtra.num = (wExtra.num or 0) + ins
end

-- ������ߵ���
-- ������(��λ��ǰ500��) or ��԰��ֲ or ����͵Ϯ(lv >= 43)
-- �������ͬ�����й�����
function Player_to_World(playerid)	
	-- --look('Player_to_World:' .. tostring(playerid))
	-- ���������
	if IsSpanServer() then
		return
	end
	local playerExtra = GetDBExtraData(playerid)
	if playerExtra == nil then return end	
	-- �ж��й�����
	if not CheckNeedTs(playerid) then
		-- --look("�������й�����")
		return
	end		
	local lv = CI_GetPlayerData(1)
	-- �����й�������������ж��Ƿ�Ϊ�ǻ�Ծ���
	--if lv < 40 then
		--PushNActList(playerid)
	--end		

	-- �����й�������ʼ���й�����
	local wExtra = GetWorldExtraData()
	if wExtra == nil then return end
	local ins = 0
	if wExtra[playerid] == nil then
		ins = 1
		wExtra[playerid] = {}
	end
	local worldExtra = wExtra[playerid]
	-- --look(playerExtra)
	-- --look(worldExtra)
	-- �й�ׯ԰����
	if playerExtra.manor ~= nil then
		if worldExtra.manor == nil then
			worldExtra.manor = {}
		end
		worldExtra.manor.mLv = playerExtra.manor.mLv		-- ׯ԰�ȼ� (1)
		worldExtra.manor.mExp = playerExtra.manor.mExp		-- ׯ԰���� (1)
		worldExtra.manor.Tech = playerExtra.manor.Tech		-- ׯ԰�Ƽ� (1)
		worldExtra.manor.ins = playerExtra.manor.ins		-- ��λ������(1)
		
		worldExtra.manor.Rank = playerExtra.manor.Rank		-- ׯ԰��λ (2)
		worldExtra.manor.lsRK = playerExtra.manor.lsRK		-- ׯ԰������λ (2)
		worldExtra.manor.Degr = playerExtra.manor.Degr		-- ׯ԰ͨ���� (2)
		worldExtra.manor.rbPT = playerExtra.manor.rbPT		-- ׯ԰�Ӷᱣ��ʱ�� (2)
		worldExtra.manor.MonT = playerExtra.manor.MonT		-- ҡǮ�� (2)
	end
	-- �йܲ�԰����
	if playerExtra.garden ~= nil then
		worldExtra.garden = playerExtra.garden						-- ��԰����(2)
	end		
	-- �й�ս��(Ŀǰ���ߺ�ս��ֻ����ٲ������ӡ�������ʱû�й��ۼ�ս��)
	local zgPoint = GetPlayerPoints(playerid,6)
	if zgPoint then													-- ս��(2)
		worldExtra.zgValue = zgPoint
	end
	
	-- �й�������(ÿ��Сʱ����)
	local ryval = GetPlayerPoints(playerid,10)
	if ryval then													-- ����ֵ(2)
		worldExtra.ryval = ryval
	end

	-- �йܰ���������
	if playerExtra.facD ~= nil then
		worldExtra.facD = playerExtra.facD							-- ����������(2)
	end
	-- �й��������
	if playerExtra.heros ~= nil then
		worldExtra.heros = playerExtra.heros						-- �������(1)
	end
	-- �й����������Ϣ����������
	-- ( { ���֣��ȼ���vip�����ͣ����������id��ս������ͷ��},{13����������}, {8����������ID/LV} )
	local tsData = CI_GetPlayerTSData(playerid)
	if tsData ~= nil then
		worldExtra.tsData = tsData											-- �����������(1)
	end	
	
	-- --look(tsData,2)
	
	-- �йܳ�������
	local petID = PI_GetPetID(playerid)										-- ��������(1)
	worldExtra.petID = petID
	
	-- �й�ׯ԰װ��	
	local pZSData = PI_GetCurGarniture(playerid)							-- ׯ԰װ��(1)
	worldExtra.zsDT = pZSData
	
	-- ��������ʱ��(�����й�ɾ��)
	worldExtra.logout = GetServerTime()
	worldExtra.acct = worldExtra.logout
	
	-- �����ͳ��
	set_extra_debug(worldExtra,ins)
	-- --look('Player_to_World:' .. tostring(playerid) .. '__complete')
end

-- ������ߵ���(������)
-- ������(lv >= 30 and ��λ��ǰ500��) or ��԰��ֲ(lv >= 40 and ��ֲ) or ����͵Ϯ(lv >= 43)
-- �������ͬ�����й�����
function Player_to_World_Debug(playerid)
	-- �����й�������ʼ���й�����
	local wExtra = GetWorldExtraData()
	if wExtra == nil then return end
	local ins = 0
	if wExtra[playerid] == nil then
		ins = 1
	end
	wExtra[playerid] = table.copy(TSS_Config[1001])
	-- �ÿ���λ�����������λ��
	wExtra[playerid].manor.Rank = nil
	-- ѹ���Ӷ��б�
	local lv = math.random(45,65)
	MRB_PushList(playerid,lv,1)
	-- ѹ����λ��
	MR_PushRank(playerid)
	-- �����ͳ��
	set_extra_debug(wExtra[playerid],ins)
end

-- ����ͬ���������ݵ��й�
function set_extra_backup(sid)
	local delData = GetWorldDelData()
	if delData == nil then return end
	local playerExtra = GetDBExtraData(sid)
	if playerExtra == nil then return end
	if delData[sid] then
		local dd = delData[sid]
		playerExtra.manor = playerExtra.manor or {}
		playerExtra.manor.lsRK = dd[1]
		playerExtra.manor.Degr = dd[2]
		playerExtra.manor.rbPT = dd[3]
		playerExtra.manor.MonT = dd[4]

		playerExtra.zgValue = dd[5]
		-- ���°��ID
		if dd[6] and dd[6] > 0 then		
			CI_SetPlayerData(5,dd[6])
		end
		--look('set_extra_backup:' .. tostring(sid))
	end
	delData[sid] = nil
end

function set_last_access(sid)
	local playerExtra = GetSingleExtraData(sid)
	if playerExtra then
		playerExtra.acct = GetServerTime()
	end
end

function Run_Extra_Del()
	local mergeTime = GetServerMergeTime() or 0
	if mergeTime <= 0 then
		return
	end
	local wExtra = GetWorldExtraData()
	if wExtra == nil then return end
	--look('Run_Extra_Del' .. tostring(wExtra.num),1)
	World_Extra_Del(1)	
	--look('World_Extra_Del[1]:' .. tostring(wExtra.num),1)
	if wExtra.num and wExtra.num > 10000 then
		--look('Run_Extra_Del 2')
		World_Extra_Del(2)
	end
	--look('World_Extra_Del[2]:' .. tostring(wExtra.num),1)
end

function check_extra_del(sid,t,wExtraData,wExtraTemp,delData,now,bDel)
	if sid == nil or now == nil or type(t) ~= type({}) then
		return
	end	
	if sid <= 10000 then		-- ����������
		return
	end
	-- 1��������߾Ͳ���
	if IsPlayerOnline(sid) then
		return 4
	end
	-- 2����λ��������
	if t.manor and t.manor.Rank and t.manor.Rank <= MAXRANKNUM then
		return 5
	end
	local deltype = 0
	local acct
	local logout
	if t.acct then
		acct = rint((now - t.acct)/24*3600)
		----look('acct interval:' .. tostring(acct),1)
	end
	if t.logout then
		logout = rint((now - t.logout)/24*3600)
		----look('logout interval:' .. tostring(logout),1)
	end
	
	if t.acct == nil or t.logout == nil then
		deltype = 3
	elseif now > t.acct + 24*3600 then
		deltype = 1
		if t.acct then
			acct = rint((now - t.acct)/24*3600)
		end
	elseif (wExtraData.num or 0) > 10000 and now > t.logout + 12*3600 then	
		deltype = 2
		if t.logout then
			logout = rint((now - t.logout)/24*3600)
		end
	end
	
	-- bDel == nil ֻ��ͳ��
	-- bDel == 1 ɾ��deltype == 1 or deltype == 3
	-- bDel == 2 ɾ��deltype == 2
	if deltype > 0 and bDel then
		if ( bDel == 1 and (deltype == 1 or deltype == 3) ) or
		   ( bDel == 2 and (deltype == 2 ) ) then
			-- �ȱ���
			if deltype ~= 1 then
				delData[sid] = delData[sid] or {}
				local dd = delData[sid]
				if t.manor then				
					dd[1] = t.manor.lsRK	-- ׯ԰������λ (2)
					dd[2] = t.manor.Degr	-- ׯ԰ͨ���� (2)
					dd[3] = t.manor.rbPT	-- ׯ԰�Ӷᱣ��ʱ�� (2)
					dd[4] = t.manor.MonT	-- ҡǮ�� (2)
				end
				if t.zgValue then
					dd[5] = t.zgValue
				end
				if t.tsData and t.tsData[1] then	-- �������ID����
					dd[6] = t.tsData[1][6]
				end
				
				dd.dtm = now				-- ��¼ɾ��ʱ��
			end
			wExtraData[sid] = nil
			wExtraData.num = (wExtraData.num or 0) - 1
			wExtraTemp[sid] = nil
			--look('del sid:' .. tostring(sid) .. '__acct:' .. tostring(acct) .. '__logout:' .. tostring(logout), 1)		
		end
	end

	return deltype
end

-- ɾ�������й�����(����ֻ���ֻ����Ϊ��λ���������йܵ����)
function single_extra_del(sid)
	local mergeTime = GetServerMergeTime() or 0
	if mergeTime <= 0 then
		return
	end
	local wExtraData = GetWorldExtraData()
	if wExtraData == nil then return end
	local wExtraTemp = GetWorldExtraTemp()
	if wExtraTemp == nil then return end
	-- �������Ҫ�й���
	if not CheckNeedTs(sid) then 
		if wExtraData[sid] then
			wExtraData[sid] = nil
		end
		if wExtraTemp[sid] then
			wExtraTemp[sid] = nil
		end
	end
end

function World_Extra_Del(bDel)
	local wExtraData = GetWorldExtraData()
	if wExtraData == nil then return end
	local wExtraTemp = GetWorldExtraTemp()
	if wExtraTemp == nil then return end
	local delData = GetWorldDelData()
	if delData == nil then return end
	local now = GetServerTime()
	local dc0 = 0
	local dc1 = 0
	local dc2 = 0
	local dc3 = 0
	local dc4 = 0
	local dc5 = 0
	local dc6 = 0
	local all = 0
	for pid, v in pairs(wExtraData) do
		if type(pid) == type(0) and type(v) == type({}) then
			local dtype = check_extra_del(pid,v,wExtraData,wExtraTemp,delData,now,bDel)
			if dtype == 0 then
				dc0 = dc0 + 1
			end
			if dtype == 1 then
				dc1 = dc1 + 1
			end
			if dtype == 2 then
				dc2 = dc2 + 1
			end
			if dtype == 3 then
				dc3 = dc3 + 1
			end
			if dtype == 4 then
				dc4 = dc4 + 1
			end
			if dtype == 5 then
				dc5 = dc5 + 1
			end
			if dtype == nil then
				dc6 = dc6 + 1
			end
			all = all + 1
		end
	end
	--look('World_Extra_Del deltype[0]:' .. tostring(dc0),1)
	--look('World_Extra_Del deltype[1]:' .. tostring(dc1),1)
	--look('World_Extra_Del deltype[2]:' .. tostring(dc2),1)
	--look('World_Extra_Del deltype[3]:' .. tostring(dc3),1)
	--look('World_Extra_Del deltype[4]:' .. tostring(dc4),1)
	--look('World_Extra_Del deltype[5]:' .. tostring(dc5),1)
	--look('World_Extra_Del deltype[6]:' .. tostring(dc6),1)
	--look('World_Extra_Del all:' .. tostring(all),1)
end

function get_extra_debug()
	local wExtra = GetWorldExtraData()
	if wExtra == nil then return end
	--look(tostring(wExtra),1)
	if wExtra.single then
		--look('[extra_single]__' .. wExtra.single,1)
	end
	if wExtra.num then
		--look('[extra_num]__' .. wExtra.num,1)
	end
end

function get_world_del()
	local delData = GetWorldDelData()
	if delData == nil then return end
	--look('get_world_del')
	--look(delData,1)
end

function insert_rebot_extra()
	for i = 1,20000 do
		local sid = 1000110000 + i
		Player_to_World_Debug(sid)
	end
end



----------------------------------------XXX_Interf��ӿ�----------------------------------------

-- ��ȡׯ԰���ݽӿ� (�������nil ˵����ҼȲ�����Ҳû�й�����(���ܱ�ɾ��))
function GetManorData_Interf(playerid)
	local pManorData = GetPlayerManorData(playerid)
	if pManorData == nil then		-- ������ȡ�й�����
		local extraData = GetSingleExtraData(playerid)
		if extraData == nil then
			return
		end
		return extraData.manor
	end
	return pManorData	 
end

-- ��ȡ��԰���ݽӿ� (�������nil ˵����ҼȲ�����Ҳû�й�����(���ܱ�ɾ��))
function GetGardenData_Interf(playerid)
	local pGardenData = GetPlayerGardenData(playerid)
	if pGardenData == nil then		-- ������ȡ�й�����
		local extraData = GetSingleExtraData(playerid)
		if extraData == nil then
			return
		end
		return extraData.garden
	end
	return pGardenData
end

function GetExtraTemp_Garden(playerid)
	local extraTemp = GetSingleExtraTemp(playerid)
	if extraTemp == nil then
		return
	end
	extraTemp.garden = extraTemp.garden or {}
	
	return extraTemp.garden
end

-- ��ȡ�ҽ����ݽӿ� (�������nil ˵����ҼȲ�����Ҳû�й�����(���ܱ�ɾ��))
function GetHerosData_Interf(playerid)
	local pHerosData = GetPlayerHerosData(playerid)
	if pHerosData == nil then		-- ������ȡ�й�����
		local extraData = GetSingleExtraData(playerid)
		if extraData == nil then
			return
		end
		return extraData.heros
	end
	return pHerosData
end

function GetFacData_Interf(playerid)
	local pFacData = GetPlayerFacData(playerid)
	if pFacData == nil then		-- ������ȡ�й�����
		local extraData = GetSingleExtraData(playerid)
		if extraData == nil then
			return
		end
		return extraData.facD
	end
	return pFacData	
end

-- ֻȡ�й�����
local function GetTsData_Interf(playerid)
	if IsPlayerOnline(playerid) then		-- ����Ӧ�ò�����ȡ���������Ӹ��жϷ�ֹ����û�ж�
		return
	end
	local worldExtra = GetSingleExtraData(playerid)
	if worldExtra == nil then return end
	
	return worldExtra.tsData
end

-- ��ȡս����������Ϣͳһ�ӿ�
-- ( { ���֣��ȼ���vip�����ͣ����������id��ս������ͷ��} )
function PI_GetTsBaseData(playerid)	
	if IsPlayerOnline(playerid) then
		local tsData = CI_GetPlayerBaseData(playerid, 2)
		return tsData
	else
		local worldExtra = GetSingleExtraData(playerid)
		if worldExtra == nil then return end
		if worldExtra.tsData and worldExtra.tsData[1] then
			return worldExtra.tsData[1]
		end
	end	
end

-- ȡ������ֽӿ�
function PI_GetPlayerName(playerid)
	if IsPlayerOnline(playerid) then
		return CI_GetPlayerData(5,2,playerid)
	else
		local worldExtra = GetSingleExtraData(playerid)
		if worldExtra == nil then return end
		if worldExtra.tsData ~= nil and worldExtra.tsData[1] ~= nil then
			return worldExtra.tsData[1][1]
		end
	end	
end

-- ȡ��ҵȼ��ӿ�
function PI_GetPlayerLevel(playerid)
	if IsPlayerOnline(playerid) then
		return CI_GetPlayerData(1,2,playerid)
	else
		local worldExtra = GetSingleExtraData(playerid)
		if worldExtra == nil then return end
		if worldExtra.tsData ~= nil and worldExtra.tsData[1] ~= nil then
			return worldExtra.tsData[1][2]
		end
	end	
end

-- ȡ���ս����
function PI_GetPlayerFight(playerid)
	if IsPlayerOnline(playerid) then
		return CI_GetPlayerData(62,2,playerid)
	else
		local worldExtra = GetSingleExtraData(playerid)
		if worldExtra == nil then return end
		if worldExtra.tsData ~= nil and worldExtra.tsData[1] ~= nil then
			return worldExtra.tsData[1][7]
		end
	end	
end

-- ��ȡVIP����
function PI_GetPlayerVipType(playerid)
	if IsPlayerOnline(playerid) then
		return CI_GetPlayerIcon(0,0,2,playerid)
	else
		local worldExtra = GetSingleExtraData(playerid)
		if worldExtra == nil then return end
		if worldExtra.tsData ~= nil and worldExtra.tsData[1] ~= nil then
			return worldExtra.tsData[1][3]
		end
	end		
end

-- ȡ���HeadID
function PI_GetPlayerHeadID(playerid)
	if IsPlayerOnline(playerid) then
		return CI_GetPlayerData(70,2,playerid)
	else
		local worldExtra = GetSingleExtraData(playerid)
		if worldExtra == nil then return end
		if worldExtra.tsData ~= nil and worldExtra.tsData[1] ~= nil then
			return worldExtra.tsData[1][8]
		end
	end	
end

-- ȡ���ImageID
local function PI_GetPlayerImageID(playerid)
	if IsPlayerOnline(playerid) then
		return CI_GetPlayerData(23,2,playerid)
	else
		local worldExtra = GetSingleExtraData(playerid)
		if worldExtra == nil then return end
		if worldExtra.tsData ~= nil and worldExtra.tsData[1] ~= nil then
			return worldExtra.tsData[1][4]
		end
	end	
end

-- ȡ��Ұ��ID
function PI_GetPlayerFacID(playerid)
	if IsPlayerOnline(playerid) then
		return CI_GetPlayerData(23,2,playerid)
	else
		local worldExtra = GetSingleExtraData(playerid)
		if worldExtra == nil then return end
		if worldExtra.tsData ~= nil and worldExtra.tsData[1] ~= nil then
			return worldExtra.tsData[1][6]
		end
	end	
end

-- ���ð��ID(����������߱�������)
-- ע�⣺���������ڻ��������й����� ����Ҳ�������й�����
function PI_SetPlayerFacID(playerid,facid)
	local wExtra = GetWorldExtraData()
	if wExtra[playerid] == nil then
		wExtra[playerid] = {}
	end
	local we = wExtra[playerid]
	we.tsData = we.tsData or {}
	we.tsData[1] = we.tsData[1] or {}
	we.tsData[1][6] = facid
end

local function PI_GetPlayerData(playerid,param)
	if param == nil or type(param) ~= type(0) then return end
	if IsPlayerOnline(playerid) then
		return CI_GetPlayerData(param,2,playerid)
	else
		local worldExtra = GetSingleExtraData(playerid)
		if worldExtra == nil or worldExtra.tsData == nil or worldExtra.tsData[1] == nil then return end
		if param == 1 then	-- ȡ�ȼ�
			return worldExtra.tsData[1][2]
		elseif param == 5 then	-- ȡ����
			return worldExtra.tsData[1][1]
		end
	end	
end

-- �ж�����Ƿ����߻��й�
-- flags [nil] ���߻��й� [not nil] ���йܲŷ���true ���򷵻�false
function IsPlayerTSD(playerid,flags)
	if flags == nil then
		if IsPlayerOnline(playerid) then
			return true
		else
			local worldExtra = GetSingleExtraData(playerid)
			if worldExtra and worldExtra.tsData then
				return true
			end
		end
	else
		local worldExtra = GetSingleExtraData(playerid)
		if worldExtra and worldExtra.tsData then
			return true
		end
	end
	return false
end

-- ���ս���ӿ�
function PI_GetPlayerZG(playerid)
	if IsPlayerOnline(playerid) then
		local zgPoint = GetPlayerPoints(playerid,6)
		return zgPoint or 0
	else
		local worldExtra = GetSingleExtraData(playerid)
		if worldExtra == nil then return 0 end
		return worldExtra.zgValue or 0
	end
end

-- ����ս���ӿ�
function PI_AddPlayerZG(sid, val)
	if sid == nil or val == nil then return end
	if IsPlayerOnline(sid) then
		AddPlayerPoints(sid,6,val,nil,'����ս��')
	else
		local worldExtra = GetSingleExtraData(sid)
		if worldExtra == nil then return end
		worldExtra.zgValue = (worldExtra.zgValue or 0) + val
		if worldExtra.zgValue < 0 then
			worldExtra.zgValue = 0
		end
	end
end

-- ���������ӿ�
function PI_GetPlayerRY(playerid)
	if IsPlayerOnline(playerid) then
		local ryval = GetPlayerPoints(playerid,10)
		return ryval or 0
	else
		local worldExtra = GetSingleExtraData(playerid)
		if worldExtra == nil then return 0 end
		return worldExtra.ryval or 0
	end
end

-- ����������
function PI_AddPlayerRY(sid, val)
	if sid == nil or val == nil then return end
	if IsPlayerOnline(sid) then
		AddPlayerPoints(sid,10,val,nil,'����������_2')
	else
		local worldExtra = GetSingleExtraData(sid)
		if worldExtra == nil then return end
		worldExtra.ryval = (worldExtra.ryval or 0) + val
		if worldExtra.ryval < 0 then
			worldExtra.ryval = 0
		end
	end
end

-- ȡׯ԰��ǰװ�νӿ�
function PI_GetCurGarniture(playerid)
	if IsPlayerOnline(playerid) then
		return Garniture_interZY(playerid)
	else
		local worldExtra = GetSingleExtraData(playerid)
		if worldExtra == nil then return end
		return worldExtra.zsDT
	end
end

-- ��ȡ��ǰѡ���������ӿ�
function PI_GetPetID(playerid)
	if IsPlayerOnline(playerid) then
		local petData = GetPetData(playerid)
		if petData == nil then return end
		return petData.id
	else
		local worldExtra = GetSingleExtraData(playerid)
		if worldExtra == nil then return end		
		return worldExtra.petID
	end
end

------------------------------------------------������ﴴ��----------------------------------------------

-- ���һ��������ID
-- @iType: [1] ��λ�� [2] �Ӷ�
function Robot_RandID(iType)
	if iType == 1 then
		return 1001
	elseif iType == 2 then
		return math.random(2001,2006)
	end
end

-- ����������������
function Robot_Reset()
	--look('Robot_Reset')
	local worldExtra = GetWorldExtraData()			
	-- ��λ�����Ӷ�
	worldExtra[2001] = TSS_Config[2001]		
	worldExtra[2002] = TSS_Config[2002]
	worldExtra[2003] = TSS_Config[2003]
	worldExtra[2004] = TSS_Config[2004]
	worldExtra[2005] = TSS_Config[2005]
	worldExtra[2006] = TSS_Config[2006]		
end

-- -- ��ȡ����������
-- function Robot_GetData(ID,dtype)
	-- if TSS_Config == nil or TSS_Config[ID] == nil then return end
	-- if dtype == 1 then
		-- if TSS_Config[ID].tsData then
			-- return TSS_Config[ID].tsData[1]
		-- end
	-- elseif dtype == 2 then
		-- return TSS_Config[ID].tsData
	-- elseif dtype == 3 then
		-- return TSS_Config[ID].heros
	-- end
-- end

-- ���������
-- @itype: [1] ׯ԰��λ�� [2] ׯ԰�Ӷ�
function CreatePlayerMonster(itype,playerid,monsterConf,mapGID,pos,camp,controlId,tagpos)
	if itype == nil or monsterConf == nil or type(monsterConf) ~= type({}) then return end
	if pos and type(pos) == type({}) and #pos == 3 then
		monsterConf.x = pos[1]
		monsterConf.y = pos[2]
		monsterConf.dir = pos[3]
	end	
	monsterConf.regionId = mapGID
	monsterConf.camp = camp
	if controlId then
		monsterConf.Priority_Except = monsterConf.Priority_Except or {}
		local t = monsterConf.Priority_Except
		t.selecttype = 3
		t.type = 4
		t.target = controlId
	end
	if type(tagpos) == type({}) then
		monsterConf.targetX = tagpos[1]
		monsterConf.targetY = tagpos[2]
	end
	--look(monsterConf)
	local ret
	if IsPlayerOnline(playerid) == true then
		ret = CreateObjectIndirect(monsterConf,playerid)
	else	
		local pTSData = GetTsData_Interf(playerid)	
		if pTSData == nil or type(pTSData) ~= type({}) then
			--look("���û���й�����")
			return
		end
		-- --look(pTSData)
		local MaxHP = pTSData[2][1]		-- ��¼ԭʼѪ��
		monsterConf.name = pTSData[1][1]
		monsterConf.level = pTSData[1][2]
		monsterConf.imageID = pTSData[1][4]
		monsterConf.headID = pTSData[1][5]
		monsterConf.bossType = pTSData[1][8]
		monsterConf.monAtt = pTSData[2]
		if itype == 1 then	-- ׯ԰��λ��3��Ѫ��
			monsterConf.monAtt[1] = rint(pTSData[2][1] * 1)			
		end
		monsterConf.skillID = pTSData[3][1]
		monsterConf.skillLevel = pTSData[3][2]		
			
		ret = CreateObjectIndirect(monsterConf)
		-- ��Ҫ�������������ԭѪ���ͻ�һֱ *3 ��ȥ
		pTSData[2][1] = MaxHP			-- ��ԭԭʼѪ��
		-- --look(monsterConf)
	end	
	if ret then
		return 1,ret
	end
end

-- ��λ��������ս���
function CreateRankHeros(playerid,monsterConf,mapGID,posList,camp,controlId,tagpos)
	if monsterConf == nil or type(monsterConf) ~= type({}) then return end
	if posList == nil then return end
	local pHerosData = GetHerosData_Interf(playerid)
	if pHerosData == nil then return end		
	monsterConf.regionId = mapGID
	monsterConf.camp = camp
	local ObjCount = 0
	local heroInfo = nil
	local monGID = nil
	local index = 0
	if IsPlayerOnline(playerid) then
		index = get_cur_hero_fight(playerid) or 0
		--look('index' .. index)
	else		
		index = pHerosData.fight or 0
	end
	if index > 0 then
		if(GetHeroInfo(playerid,index))then
			heroInfo = GetRWData(2,true)
		end
		if heroInfo then
			monsterConf.name = heroInfo.n
			monsterConf.level = heroInfo.lv
			monsterConf.imageID = heroInfo.id					
			monsterConf.monAtt = heroInfo.att
			monsterConf.skillID = heroInfo.skid
			monsterConf.skillLevel = heroInfo.sklv
			if type(posList) == type({}) then
				monsterConf.x = posList[1]
				monsterConf.y = posList[2]
				monsterConf.dir = posList[3]
			end			
			if controlId then
				monsterConf.Priority_Except = monsterConf.Priority_Except or {}
				local t = monsterConf.Priority_Except
				t.selecttype = 3
				t.type = 4
				t.target = controlId
			end
			if type(tagpos) == type({}) then
				monsterConf.targetX = tagpos[1]
				monsterConf.targetY = tagpos[2]
			end
			
			-- --look(monsterConf)
			monGID = CreateObjectIndirect(monsterConf)
			if monGID then
				ObjCount = ObjCount + 1
			end
		end
	end
	return ObjCount,monGID
end

-- �����Ӷ�ʱ����ӹ�
function CreateHerosMonster(playerid,monsterConf,mapGID,posList,camp,target)
	if monsterConf == nil or type(monsterConf) ~= type({}) then return end
	if posList == nil or #posList ~= 4 then return end
	local pHerosData = GetHerosData_Interf(playerid)
	if pHerosData == nil then return end		
	monsterConf.regionId = mapGID
	monsterConf.camp = camp
	local ObjCount = 0
	local heroInfo = nil
	for index, v in pairs(pHerosData) do
		if type(index) == type(0) and type(v) == type({}) then
			if(GetHeroInfo(playerid,index))then
				heroInfo = GetRWData(2,true)
			end
			if heroInfo then				
				monsterConf.name = heroInfo.n
				monsterConf.level = heroInfo.lv
				monsterConf.imageID = heroInfo.id					
				monsterConf.monAtt = heroInfo.att
				monsterConf.skillID = heroInfo.skid
				monsterConf.skillLevel = heroInfo.sklv
				if posList[index] and type(posList[index]) == type({}) then
					monsterConf.x = posList[index][1]
					monsterConf.y = posList[index][2]
					monsterConf.dir = posList[index][3]
				end			
				if target and type(target) == type({}) then
					monsterConf.targetX = target[1]
					monsterConf.targetY = target[2]
				end
				-- --look(monsterConf)
				local ret = CreateObjectIndirect(monsterConf)
				if ret then
					ObjCount = ObjCount + 1
				end
			end
		end
	end
	return ObjCount
end

-- ���������
function CreatePetMonster(playerid,monsterConf,mapGID,pos,camp)	
	local PetInfo = nil
	if PI_GetPetInfo(playerid) then
		PetInfo = GetRWData(2,true)
	end
	if PetInfo == nil then return end
	if pos and type(pos) == type({}) and #pos == 3 then
		monsterConf.x = pos[1]
		monsterConf.y = pos[2]
		monsterConf.dir = pos[3]
	end
	monsterConf.regionId = mapGID
	monsterConf.camp = camp

	monsterConf.name = PetInfo.n
	monsterConf.level = PetInfo.lv
	monsterConf.imageID = PetInfo.id					
	monsterConf.monAtt = PetInfo.att
	monsterConf.skillID = PetInfo.skid
	monsterConf.skillLevel = PetInfo.sklv						
	-- --look(monsterConf)
	local ret = CreateObjectIndirect(monsterConf)
	if ret then
		return 1
	end

end

-- ����ׯ԰�������
-- ����ControlID == {5,6,7,8} ���ֺ����(�ҽ�)
function CreateManorHeros(playerid,mapGID,posList)
	if mapGID == nil or posList == nil or type(posList) ~= type({}) or #posList ~= 4 then 
		--look("CreateManorHeros param erro")
		return
	end	
	local pHerosData = GetHerosData_Interf(playerid)
	if pHerosData == nil then return end
	-- ��ȡ��ӹ�������
	local monsterConf = PlayerMonsterConf[5] 
	if monsterConf == nil or type(monsterConf) ~= type({}) then return end
	monsterConf.regionId = mapGID
	monsterConf.camp = 4					-- ����Ѻù�
	local ObjCount = 0
	local controlId = 4
	local heroInfo = nil
	-- local fight = pHerosData.fight or 0
	for index, v in pairs(pHerosData) do
		if type(index) == type(0) and type(v) == type({}) then	
			if(GetHeroInfo(playerid,index))then
				heroInfo = GetRWData(2,true)
			end
			if heroInfo then
				-- if index ~= fight then		-- ��ׯ԰ ��������ս���
					monsterConf.name = heroInfo.n
					monsterConf.level = heroInfo.lv
					monsterConf.imageID = heroInfo.id					
					monsterConf.monAtt = heroInfo.att
					monsterConf.skillID = heroInfo.skid
					monsterConf.skillLevel = heroInfo.sklv
					monsterConf.controlId = controlId + index
					if posList[index] and type(posList[index]) == type({}) then
						monsterConf.x = posList[index][1]
						monsterConf.y = posList[index][2]
						monsterConf.dir=posList[index][3]
					end
					-- --look(monsterConf)
					local ret = CreateObjectIndirect(monsterConf)
					if ret then
						ObjCount = ObjCount + 1
					end
				-- end
			end
		end
	end
	return ObjCount
end

function logout_to_lacc()
	local wExtraData = GetWorldExtraData()
	if wExtraData == nil then return end
	local wExtraTemp = GetWorldExtraTemp()
	if wExtraTemp == nil then return end
	local num = 0
	local total = 0
	for pid, v in pairs(wExtraTemp) do
		if type(pid) == type(0) then
			if wExtraData[pid] == nil then
				wExtraTemp[pid] = nil
				num = num + 1
			end
			total = total + 1
		end
	end
	--look('logout_to_lacc: num = ' .. tostring(num) .. '__total = ' .. tostring(total),1)
end

