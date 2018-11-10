--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local Faction_Fail = msgh_s2c_def[7][1]
local Faction_UpdateSizelevel = msgh_s2c_def[7][2]
local Faction_Donate = msgh_s2c_def[7][3]
local Faction_Build = msgh_s2c_def[7][4]
local Faction_Soul = msgh_s2c_def[7][5]
local Faction_Skill = msgh_s2c_def[7][6]
local Faction_Sign = msgh_s2c_def[7][7]
local Faction_Buff = msgh_s2c_def[7][12]
local Faction_Rep = msgh_s2c_def[7][14]
local Faction_ApplySuccess = msgh_s2c_def[7][16]
local Faction_AbortApply = msgh_s2c_def[7][17]
local Faction_ApplyResult = msgh_s2c_def[7][19]
local SendLuaMsg = SendLuaMsg
local CreateFaction_Apply = CreateFaction_Apply
local DonateFaction = DonateFaction
local DeleteFaction = DeleteFaction
local UpdateSizeLevel = UpdateSizeLevel
local FactionLuck = FactionLuck
local upFactionBuild = upFactionBuild
local FeedSoul = FeedSoul
local upFSkill = upFSkill
local upFSign = upFSign
local SendFactionData = SendFactionData
local SetFactionEnemy = SetFactionEnemy
local SendFactionEnemy = SendFactionEnemy
local SetFactionBuff = SetFactionBuff
local GetTreasureTime = GetTreasureTime
local SendTreasure = SendTreasure
local ClearFactionBuildCD = ClearFactionBuildCD
local uv_TimesTypeTb = TimesTypeTb
local CheckTimes = CheckTimes
local ImpeachFHeader = ImpeachFHeader
local GetFactionTempData = GetFactionTempData
local faction_monster = require('Script.active.faction_monster')
local ss_onlogin = faction_monster.ss_onlogin
local join_auto_faction = join_auto_faction
local faction_in_region = faction_in_region
--------------------------------------------------------------------------
-- data:
--�������
msgDispatcher[7][1] = function (sid,msg)
	CreateFaction_Apply(sid,msg.name,msg.check)
end

--��ȡ��������Ϣ
msgDispatcher[7][2] = function ( playerid,msg)
	--return true,fmoney,pVal
	local result,data,val,isfull = DonateFaction(playerid,msg.val,msg.mtype)
	if(result)then
		SendLuaMsg( 0, { ids= Faction_Donate, fval = data, val = val}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 2, data = data}, 9 )
	end
end

--��ɢ���
msgDispatcher[7][3] = function ( playerid)
	local result,data = DeleteFaction(playerid)
	if(result == false)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 8, data = data}, 9 )
	end
end

--donate for faction
msgDispatcher[7][4] = function ( playerid,msg)
	if(msg.money~=nil)then DonateFaction(msg.money) end
end

--���׿�ʯ 
--msgDispatcher[7][5] = function ( playerid,msg)
	-- local sData = GetDaySpendData( playerid ,SpendType.Fction_Donate )
	-- if(nil == sData)then
		-- return
	-- end
	-- SendLuaMsg( 0, { ids=Faction_DonateItem, count=sData.count,icount = 10,maxCount = 3,camp = CI_GetPlayerData(1),fScores=5,fMoney=300,Member=15 }, 9 )
--end

-- msgDispatcher[7][6] = function ( playerid,msg)
	-- DonateFactionItem(msg.id)
-- end

-- msgDispatcher[7][7] = function ( playerid,msg)
	-- FF_SignUp()
-- end

-- msgDispatcher[7][8] = function ( playerid,msg)
	-- FF_RequstFList(msg.bAll,msg.index)
-- end

-- msgDispatcher[7][9] = function ( playerid,msg)
	-- FF_Enter(playerid)
-- end

-- msgDispatcher[7][10] = function ( playerid,msg)
	-- FF_GetAword(playerid)
-- end

-- msgDispatcher[7][11] = function ( playerid,msg)
	-- FF_GetLastWinFaction()
-- end

-- msgDispatcher[7][12] = function ( playerid,msg)
	-- FF_NoticeToPlayer(playerid,msg.bClient)
-- end

-- msgDispatcher[7][13] = function ( playerid,msg)
	-- FF_Leave(playerid)
-- end

--���뾺��
-- msgDispatcher[7][14] = function ( playerid,msg)
	
-- end

--��ͨ�������
-- msgDispatcher[7][15] = function ( playerid,msg)

-- end

--�����Ὰ�۱�
-- msgDispatcher[7][16] = function ( playerid,msg)

-- end

-- ��������
msgDispatcher[7][17] = function ( playerid,msg)
	ImpeachFHeader(playerid)
end

-- ��չ����
msgDispatcher[7][18] = function ( playerid,msg)
	local result,data = UpdateSizeLevel(playerid)
	if(result)then
		SendLuaMsg( 0, { ids = Faction_UpdateSizelevel, level = data}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 1, data = data}, 9 )
	end
end

--���ף��
msgDispatcher[7][19] = function (playerid,msg)
	FactionLuck(msg.fsid,msg.sid)
end

--������Ὠ��
msgDispatcher[7][20] = function (playerid,msg)
	local result,data,lv = upFactionBuild(playerid,msg.index)
	if(result)then
		SendLuaMsg( 0, { ids = Faction_Build,idx = msg.index,lv = lv}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 3, data = data}, 9 )
	end
end

--ι������
msgDispatcher[7][21] = function (playerid,msg)
	local result,data = FeedSoul(playerid)
	if(result)then
		SendLuaMsg( 0, { ids = Faction_Soul,data = data}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 4, data = data}, 9 )
	end
end

--��Ἴ������
msgDispatcher[7][22] = function (playerid,msg)
	local result,data = upFSkill(playerid,msg.index)
	if(result)then
		SendLuaMsg( 0, { ids = Faction_Skill,lv = data,idx = msg.index}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 5, data = data}, 9 )
	end
end

--��ȡ��Ἴ������
--msgDispatcher[7][23] = function ( playerid,msg)
	--SendFSkillData(playerid)
--end

--�������ձ�
msgDispatcher[7][24] = function(playerid,msg)
	local result,data,lv = upFSign(playerid)
	if(result)then
		SendLuaMsg( 0, { ids = Faction_Sign,money = data,lv = lv}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 6, data = data}, 9 )
	end
end

--��ȡ���lua����
msgDispatcher[7][25] = function(playerid,msg)
	SendFactionData(msg.fid)
end

--����Ƴ��ж԰��
msgDispatcher[7][26] = function(playerid,msg)
	local result,data = SetFactionEnemy(msg.fid,msg.type)
	if(result == false)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 7, data = data}, 9 )
	end
end

--��ȡ�ж԰���б�
msgDispatcher[7][27] = function(playerid,msg)
	local result = SendFactionEnemy(msg.fid)
	if(result~=nil)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 7, data = result}, 9 )
	end
end

--������
msgDispatcher[7][28] = function(playerid,msg)
	local result,data = SetFactionBuff(playerid)
	if(result)then
		SendLuaMsg( 0, { ids = Faction_Buff}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 9, data = data}, 9 )
	end
end

--��ȡ���ᱦ����
msgDispatcher[7][29] = function(playerid,msg)
	local result,data = GetTreasureTime(playerid)
	if(result == false)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 10, data = data}, 9 )
	end
end

--���жᱦ
msgDispatcher[7][30] = function(playerid,msg)
	local result,data = SendTreasure(playerid)
	if(result == true)then
		CheckTimes(sid,uv_TimesTypeTb.FactionDB_Time,1,-1) --���Ӷᱦ����
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 10, data = data}, 9 )
	end
end

--��CD
msgDispatcher[7][31] = function(playerid,msg)
	local result,data = ClearFactionBuildCD(playerid)
	if(result == false)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 11, data = data}, 9 )
	end
end

--������ս��
msgDispatcher[7][32] = function(playerid,msg)
	local data = GetFactionTempData(msg.fid)
	if(data~=nil)then
		SendLuaMsg( 0, { ids = Faction_Rep, data = data.rep}, 9 )
	end
end

--����������
msgDispatcher[7][33] = function(playerid,msg)
	ss_onlogin(playerid)
end

--���������
msgDispatcher[7][34] = function(playerid,msg)
	local result,data = FactionApplyJoin(playerid,msg.fid)
	if(result)then
		SendLuaMsg( 0, { ids = Faction_ApplySuccess, fid = msg.fid}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 12, data = data}, 9 )
	end
end

--����������
msgDispatcher[7][35] = function(playerid,msg)
	local result,data = FactionAskJoin(playerid,msg.sid,msg.t,msg.page)
	if(result)then 
		SendLuaMsg( 0, { ids = Faction_ApplyResult, page = msg.page, t = msg.t, sid = msg.sid}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 13, data = data, page = msg.page, sid = msg.sid}, 9 )
	end
end

--ȡ������������
msgDispatcher[7][36] = function(playerid,msg)
	FactionAbortJoin(playerid,msg.fid)
	SendLuaMsg( 0, { ids = Faction_AbortApply, fid = msg.fid}, 9 )
end

--���������б�
msgDispatcher[7][37] = function(playerid,msg)
	FactionJoinList(playerid,msg.fid,msg.idx)
end

--����ͬ������
msgDispatcher[7][38] = function(playerid,msg)
	sendFactionUnion(playerid)
end

--����ͬ������
msgDispatcher[7][39] = function(playerid,msg)
	local result,data = applyFactionUnion(playerid,msg.fid)
	if(result==false)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 14, data = data,fid = msg.fid}, 9 )
	end
end

--����ͬ������
msgDispatcher[7][40] = function(playerid,msg)
	local result,data = checkFactionUnion(playerid,msg.fid,msg.c)
	if(result == false)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 15, data = data}, 9 )
	end
end

--���ͬ��
msgDispatcher[7][41] = function(playerid,msg)
	local result,data = delFactionUnion(playerid)
	if(result == false)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 16, data = data}, 9 )
	end
end
--����פ��
msgDispatcher[7][42] = function(playerid,msg)
	faction_in_region(msg.itype)
end

--�����������˰��
msgDispatcher[7][43] = function(playerid,msg)
	local result,data = join_auto_faction(playerid,msg.fid)
	if(result == false)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 17, data = data}, 9 )
	end
end

--�����ؾ�
msgDispatcher[7][44] = function(playerid,msg)

	faction_in_mijing()
end

--����T��
msgDispatcher[7][45] = function(playerid,msg)
	local result,data = leave_faction(playerid,msg.sid)
	if(result == false)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 18, data = data}, 9 )
	end
end
--���ڽ�����Ѻ���(����� meony == nil)
msgDispatcher[7][46] = function(playerid,msg)
  faction_yunbiao_yajin(playerid,msg.money)
end
--������ڿ�ʼ
msgDispatcher[7][47] = function(playerid,msg)
  faction_yunbiao_start(playerid)
end
--����������
msgDispatcher[7][48] = function(playerid,msg)
  faction_yunbiao_submit(playerid)
end
--�������ǣ��
msgDispatcher[7][49] = function(playerid,msg)
  faction_yunbiao_lead(playerid,msg.monGID)
end
--ȡ���������ǣ��
msgDispatcher[7][50] = function(playerid,msg)
  faction_cancel_lead(playerid)
end
--������ڽ���
msgDispatcher[7][51] = function(playerid,msg)
  faction_yb_award(playerid,msg.fac_id)
end
--������Ȩ
msgDispatcher[7][52] = function(playerid,msg)
  tq_guowang( playerid,msg.osid,msg.itype )
end
--����_�����ټ�
msgDispatcher[7][53] = function(playerid,msg)
  trance_p( playerid )
end

