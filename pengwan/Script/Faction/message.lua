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
--创建帮会
msgDispatcher[7][1] = function (sid,msg)
	CreateFaction_Apply(sid,msg.name,msg.check)
end

--获取帮会捐献信息
msgDispatcher[7][2] = function ( playerid,msg)
	--return true,fmoney,pVal
	local result,data,val,isfull = DonateFaction(playerid,msg.val,msg.mtype)
	if(result)then
		SendLuaMsg( 0, { ids= Faction_Donate, fval = data, val = val}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 2, data = data}, 9 )
	end
end

--解散帮会
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

--捐献矿石 
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

--申请竞价
-- msgDispatcher[7][14] = function ( playerid,msg)
	
-- end

--普通申请进入
-- msgDispatcher[7][15] = function ( playerid,msg)

-- end

--请求帮会竞价表
-- msgDispatcher[7][16] = function ( playerid,msg)

-- end

-- 弹劾帮主
msgDispatcher[7][17] = function ( playerid,msg)
	ImpeachFHeader(playerid)
end

-- 扩展人数
msgDispatcher[7][18] = function ( playerid,msg)
	local result,data = UpdateSizeLevel(playerid)
	if(result)then
		SendLuaMsg( 0, { ids = Faction_UpdateSizelevel, level = data}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 1, data = data}, 9 )
	end
end

--帮会祝福
msgDispatcher[7][19] = function (playerid,msg)
	FactionLuck(msg.fsid,msg.sid)
end

--升级帮会建筑
msgDispatcher[7][20] = function (playerid,msg)
	local result,data,lv = upFactionBuild(playerid,msg.index)
	if(result)then
		SendLuaMsg( 0, { ids = Faction_Build,idx = msg.index,lv = lv}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 3, data = data}, 9 )
	end
end

--喂养神兽
msgDispatcher[7][21] = function (playerid,msg)
	local result,data = FeedSoul(playerid)
	if(result)then
		SendLuaMsg( 0, { ids = Faction_Soul,data = data}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 4, data = data}, 9 )
	end
end

--帮会技能升级
msgDispatcher[7][22] = function (playerid,msg)
	local result,data = upFSkill(playerid,msg.index)
	if(result)then
		SendLuaMsg( 0, { ids = Faction_Skill,lv = data,idx = msg.index}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 5, data = data}, 9 )
	end
end

--获取帮会技能数据
--msgDispatcher[7][23] = function ( playerid,msg)
	--SendFSkillData(playerid)
--end

--升级帮会徽标
msgDispatcher[7][24] = function(playerid,msg)
	local result,data,lv = upFSign(playerid)
	if(result)then
		SendLuaMsg( 0, { ids = Faction_Sign,money = data,lv = lv}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 6, data = data}, 9 )
	end
end

--获取帮会lua数据
msgDispatcher[7][25] = function(playerid,msg)
	SendFactionData(msg.fid)
end

--添加移除敌对帮会
msgDispatcher[7][26] = function(playerid,msg)
	local result,data = SetFactionEnemy(msg.fid,msg.type)
	if(result == false)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 7, data = data}, 9 )
	end
end

--获取敌对帮会列表
msgDispatcher[7][27] = function(playerid,msg)
	local result = SendFactionEnemy(msg.fid)
	if(result~=nil)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 7, data = result}, 9 )
	end
end

--帮会庇佑
msgDispatcher[7][28] = function(playerid,msg)
	local result,data = SetFactionBuff(playerid)
	if(result)then
		SendLuaMsg( 0, { ids = Faction_Buff}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 9, data = data}, 9 )
	end
end

--获取帮会夺宝数据
msgDispatcher[7][29] = function(playerid,msg)
	local result,data = GetTreasureTime(playerid)
	if(result == false)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 10, data = data}, 9 )
	end
end

--进行夺宝
msgDispatcher[7][30] = function(playerid,msg)
	local result,data = SendTreasure(playerid)
	if(result == true)then
		CheckTimes(sid,uv_TimesTypeTb.FactionDB_Time,1,-1) --增加夺宝次数
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 10, data = data}, 9 )
	end
end

--清CD
msgDispatcher[7][31] = function(playerid,msg)
	local result,data = ClearFactionBuildCD(playerid)
	if(result == false)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 11, data = data}, 9 )
	end
end

--请求帮会战报
msgDispatcher[7][32] = function(playerid,msg)
	local data = GetFactionTempData(msg.fid)
	if(data~=nil)then
		SendLuaMsg( 0, { ids = Faction_Rep, data = data.rep}, 9 )
	end
end

--请求帮会神兽
msgDispatcher[7][33] = function(playerid,msg)
	ss_onlogin(playerid)
end

--请求加入帮会
msgDispatcher[7][34] = function(playerid,msg)
	local result,data = FactionApplyJoin(playerid,msg.fid)
	if(result)then
		SendLuaMsg( 0, { ids = Faction_ApplySuccess, fid = msg.fid}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 12, data = data}, 9 )
	end
end

--审批加入帮会
msgDispatcher[7][35] = function(playerid,msg)
	local result,data = FactionAskJoin(playerid,msg.sid,msg.t,msg.page)
	if(result)then 
		SendLuaMsg( 0, { ids = Faction_ApplyResult, page = msg.page, t = msg.t, sid = msg.sid}, 9 )
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 13, data = data, page = msg.page, sid = msg.sid}, 9 )
	end
end

--取消加入帮会申请
msgDispatcher[7][36] = function(playerid,msg)
	FactionAbortJoin(playerid,msg.fid)
	SendLuaMsg( 0, { ids = Faction_AbortApply, fid = msg.fid}, 9 )
end

--请求申请列表
msgDispatcher[7][37] = function(playerid,msg)
	FactionJoinList(playerid,msg.fid,msg.idx)
end

--请求同盟数据
msgDispatcher[7][38] = function(playerid,msg)
	sendFactionUnion(playerid)
end

--发起同盟请求
msgDispatcher[7][39] = function(playerid,msg)
	local result,data = applyFactionUnion(playerid,msg.fid)
	if(result==false)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 14, data = data,fid = msg.fid}, 9 )
	end
end

--审批同盟请求
msgDispatcher[7][40] = function(playerid,msg)
	local result,data = checkFactionUnion(playerid,msg.fid,msg.c)
	if(result == false)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 15, data = data}, 9 )
	end
end

--解除同盟
msgDispatcher[7][41] = function(playerid,msg)
	local result,data = delFactionUnion(playerid)
	if(result == false)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 16, data = data}, 9 )
	end
end
--进入驻地
msgDispatcher[7][42] = function(playerid,msg)
	faction_in_region(msg.itype)
end

--请求加入机器人帮会
msgDispatcher[7][43] = function(playerid,msg)
	local result,data = join_auto_faction(playerid,msg.fid)
	if(result == false)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 17, data = data}, 9 )
	end
end

--进入秘境
msgDispatcher[7][44] = function(playerid,msg)

	faction_in_mijing()
end

--离帮或T人
msgDispatcher[7][45] = function(playerid,msg)
	local result,data = leave_faction(playerid,msg.sid)
	if(result == false)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 18, data = data}, 9 )
	end
end
--运镖交个人押金或(打开面板 meony == nil)
msgDispatcher[7][46] = function(playerid,msg)
  faction_yunbiao_yajin(playerid,msg.money)
end
--帮会运镖开始
msgDispatcher[7][47] = function(playerid,msg)
  faction_yunbiao_start(playerid)
end
--帮会运镖完成
msgDispatcher[7][48] = function(playerid,msg)
  faction_yunbiao_submit(playerid)
end
--帮会运镖牵引
msgDispatcher[7][49] = function(playerid,msg)
  faction_yunbiao_lead(playerid,msg.monGID)
end
--取消帮会运镖牵引
msgDispatcher[7][50] = function(playerid,msg)
  faction_cancel_lead(playerid)
end
--帮会运镖奖励
msgDispatcher[7][51] = function(playerid,msg)
  faction_yb_award(playerid,msg.fac_id)
end
--国王特权
msgDispatcher[7][52] = function(playerid,msg)
  tq_guowang( playerid,msg.osid,msg.itype )
end
--传送_国王召集
msgDispatcher[7][53] = function(playerid,msg)
  trance_p( playerid )
end

