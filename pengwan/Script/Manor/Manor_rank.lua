--[[
	file:	庄主排位赛
	author:	csj
	update:	2013-3-11
	
notes:
	1、
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
local MRK_Data = msgh_s2c_def[32][1]	-- 排位列表信息
local MRK_Enter = msgh_s2c_def[32][2]	-- 排位列表信息
local MRK_Report = msgh_s2c_def[32][3]	-- 排位赛战报
local MRK_Do = msgh_s2c_def[32][4]		-- 点击奖励通知消息
local MRK_ClrCD = msgh_s2c_def[32][5]	-- 秒排位赛CD
local MRK_Exit = msgh_s2c_def[32][6]	-- 排位赛退出
local MRK_Award = msgh_s2c_def[32][7]	-- 排位赛退出
local MRK_Ins = msgh_s2c_def[32][8]		-- 排位赛鼓舞
local MRK_RY = msgh_s2c_def[32][9]		-- 排位赛2小时结算

local common_rnd = require('Script.common.random_norepeat')
local Get_num 			 = common_rnd.Get_num

MAXRANKNUM = 2000		-- 排位赛记录数(暂时就用个全局量，因为托管那会用到)

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

-- 是否是第一次打排位赛
local function MR_IsFirst(sid)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	if pManorData.bFst == nil or pManorData.bFst % 2 == 0 then
		return true
	end
end

--[[
随机列表算法:
	i.	如果自身排名在200名以后，在排名高于自己的1-10，11-20，21-30，31-40之间筛选4个。
	ii.	如果自身排名在30名以后，在排名高于自己的1-5，6-10，11-15，16-20之间筛选4个。
	iii.如果自身排名在30名以内，则只能选择比自己排名高的最新4个。
	iv.	如果自身排名在4名以内，则除了比自己排名高的，还要补充比自己排名低的最近的对手。
notes:
	500名以外的玩家(rank == nil)先从不活跃玩家列表随机
]]--
local function MR_RandList(rank,lv,cacheData,bFirst)	
	if type(cacheData) ~= type({}) then return end		
	for i = 1, #cacheData do
		cacheData[i] = nil
	end
	rank = rank or MAXRANKNUM + 1
	local Need = 4
	if bFirst then			-- 第一次特殊处理
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

-- 构造列表信息 4*6 { 排名,名字,等级,vip,外型,武器, }
local function MR_BuildCache(rands,rkList,bFirst,rank)
	-- 必须先清理数据
	for i=1 ,#(cachelist) do
		if type(cachelist[i]) == type({}) then
			for j = 1, #cachelist[i] do
				cachelist[i][j] = 0
			end
		end
	end	
	rank = rank or MAXRANKNUM + 1
	local pid = nil
	if bFirst then	-- 第一次引导特殊处理
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

-- 构造排位赛奖励信息
local function MR_RandAward(sid,pManorTemp,res)
	if pManorTemp == nil or res == nil then return end
	local lv = CI_GetPlayerData(1,2,sid)
	local exps = nil
	local addRY = nil		-- 荣誉点
	local addSW = nil		-- 声望
	if res == 1 then		-- 赢了
		exps = lv * 400
		addSW = 30
		addRY = 100
	else					-- 输了
		exps = lv * 200
		addSW = 25
		addRY = 80
	end
	-- 给奖励
	PI_PayPlayer(1,exps,0,0,'庄园排位赛奖励',2,sid)
	AddPlayerPoints(sid,7,addSW,nil,'庄园排位赛奖励')
	AddPlayerPoints(sid,10,addRY,nil,'庄园排位赛奖励')
	return
end

-- 排位赛战报
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
		-- 调用存储过程写战报记录
		manor_rank_report(gSID,pManorTemp.mrkSID,gName,sName,gRank,sRank,pManorTemp.mrkSID_r,pManorTemp.mrkRES)		
	end
	-- 打完了 设置bFirst
	if bFirst then
		--look('PI_SetManorFirst')
		PI_SetManorFirst(gSID,1)
	end
	
	-- 如果被打出排名则判断是否需要托管,不需要就删除托管数据
	-- 注意：这里必须要取真正被打得玩家
	local fManorData = GetManorData_Interf(pManorTemp.mrkSID_r)
	if fManorData and fManorData.Rank == nil or fManorData.Rank > MAXRANKNUM then
		single_extra_del(pManorTemp.mrkSID_r)
	end
	MR_ClearTemp(gSID)
end

--[[
	记录排位赛战报
	@Res: [11] 攻击方胜利、排名上升 [10] 攻击方胜利、排名不变
		  [00] 攻击方失败、排名不变
	@sSID: 防守方SID以当前排名实际玩家SID为准(保证战报消息正确性)
	@sName: 防守方名字以攻击方点击名字为准(使玩家看到的战报消息不会奇怪)
]]--

-- 战胜:更新排名
local function MR_Win(sid)
	--look("MR_Win:" .. sid)
	local pManorTemp = GetPlayerManorTemp(sid)
	if pManorTemp == nil or pManorTemp.mrkSID == nil or pManorTemp.mrkRNK == nil then
		--look("MR_Win:1")
		MR_ClearTemp(sid)
		return 
	end	
	-- 如果有奖励了 说明还没领奖(保证不能重复输/赢)
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
	-- 第一次特殊处理
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
	local sSID = rkList[mRank]			-- 防守方SID 以当前排名实际玩家SID为准(保证战报消息正确性)	
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
	
	-- 更新排名：判断是否排名比自己低
	if pManorData.Rank == nil or pManorData.Rank > mRank then
		-- 注意：这里必须取此排名的当前玩家做排名替换				
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
	-- 记录当前排名实际玩家SID
	pManorTemp.mrkSID_r = sSID				
	-- 记录结果
	pManorTemp.mrkRES = Res		
	-- 构造奖励列表
	MR_RandAward(sid,pManorTemp,1)		
	-- 发送战报
	MR_ReportProc(sid,pManorData.Rank,fManorData.Rank)
	-- 现在直接给了奖励 所以temp可以清除了
	MR_ClearTemp(sid)
end

-- 战败：1、退出游戏 2、被打死 3、时间到(防守方胜) 4、切换场景
local function MR_Lose(sid,iType)
	--look("MR_Lose")
	local pManorTemp = GetPlayerManorTemp(sid)
	if pManorTemp == nil or pManorTemp.mrkSID == nil or pManorTemp.mrkRNK == nil then
		--look("MR_Lose1")
		MR_ClearTemp(sid)
		return 
	end
	-- 如果有奖励了 说明还没领奖(保证不能重复输/赢)
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
	-- 第一次特殊处理
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
	-- 注意：这里必须取此排名的当前玩家发送战报
	local sSID = rkList[mRank]
	local fManorData = GetManorData_Interf(sSID)
	if fManorData == nil or fManorData.Rank == nil or fManorData.Rank ~= mRank then
		--look("MR_Lose5")
		MR_ClearTemp(sid)
		return 
	end
	-- 记录当前排名实际玩家SID
	pManorTemp.mrkSID_r = sSID
	-- 记录结果
	pManorTemp.mrkRES = 0		
	-- 构造奖励列表
	MR_RandAward(sid,pManorTemp,0)
	-- 输了更新冷却时间(5分钟)
	local vipLV = GI_GetVIPLevel(sid)
	if vipLV <= 1 then
		pManorData.rkCD = GetServerTime() + 5 * 60
	end
	-- 发送战报
	MR_ReportProc(sid,pManorData.Rank,fManorData.Rank,pManorData.rkCD)	
	-- 现在直接给了奖励 所以temp可以清除了
	MR_ClearTemp(sid)
	-- 退出游戏 传送出去
	if iType and iType == 1 then
		MR_Exit(sid,iType)		
	end
end

-- 基本奖励处理
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

-- 下线调用 --> 添加不活跃玩家列表
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
-- 发送庄主排位赛信息(随机4个)
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
				set_extra_rank(sid,pManorData.Rank)		-- 500名以外的应该不用管
			else
				pManorData.Rank = MAXRANKNUM + 1
			end			
		end
	end
	MR_RandList(pManorData.Rank,CI_GetPlayerData(1),pManorTemp.rands,bFirst)
	--look(pManorTemp.rands)
	-- 构造随机列表（加入玩家基本信息）
	local buildlist = MR_BuildCache(pManorTemp.rands,rkList,bFirst,pManorData.Rank)
	-- 发送排行榜前10给前台	
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
	-- 如果 bFirst == true 前台特殊处理根据玩家自己的排名显示排名
	SendLuaMsg( 0, { ids = MRK_Data, rank = pManorData.Rank, scList = scList, data = buildlist, rkCD = pManorData.rkCD, bFirst = bFirst }, 9 )
end

-- 添加排位列表(等级触发)
function MR_PushRank(sid)	
	local pManorData = GetManorData_Interf(sid)	
	-- 已有排名不会添加
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

-- 秒CD
function MR_ClearRankCD(sid,iType)
	if iType == nil then return end
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	local now = GetServerTime()
	if pManorData.rkCD and now < pManorData.rkCD then
		local yb = rint((pManorData.rkCD - now) / 60) + 1
		-- 扣钱
		if iType == 0 then
			if not CheckCost(sid,yb,0,1,"100018_排位赛秒CD") then
				SendLuaMsg( 0, { ids = MRK_ClrCD, res = 1 }, 9 )	
				return
			end
		elseif iType == 1 then
			local bdyb = GetPlayerPoints(sid,3)
			if bdyb < yb*5 then
				SendLuaMsg( 0, { ids = MRK_ClrCD, res = 1 }, 9 )	
				return
			end
			AddPlayerPoints(sid,3, -(yb*5), nil,"排位赛秒CD",true)			
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

-- 排位
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
	-- 1、判断是否有随机列表
	if pManorTemp.rands == nil then
		return
	end
	-- 2、验证前台发送的idx正确性
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
	-- 3、判断次数
	if not CheckTimes(sid,uv_TimesTypeTb.MK_Attack,1,-1,1) then
		--look("排位赛次数用完了噢，亲！")			
		return
	end
	-- 4、判断CD
	if pManorData.rkCD ~= nil then
		if GetServerTime() < pManorData.rkCD then
			--look("冷却时间未到")			
			return
		end
	end
	local bFirst = MR_IsFirst(sid)
	local pid = fid or rkList[idx]
	if pid == nil then return end
	if sid == pid then
		--look("对手是自己哦")
		return
	end	
	local fManorData = GetManorData_Interf(pid)
	if fManorData == nil then
		return 
	end
	--5、创建PK场景 (自动删除场景)	
	local mapGID = active_marank:createDR(1,nil,sid,sid)
	if mapGID == nil then
		--look("active_marank:createDR err when MR_Fight")
		return
	end
	
	local mrkDRData = active_marank:get_regiondata(mapGID)
	if mrkDRData == nil or type(mrkDRData) ~= type({}) then return end
	
	local Aobj = 0		-- 攻击方怪物数量
	local Dobj = 0		-- 防守方怪物数量
	local AheroGID = nil
	local DheroGID = nil
	
	local spfobj = 10		-- 优先攻击默认值
	local shfobj = 11
	local gpfobj = 9
	local ghfobj = 12
	local spftag = DTargPos[1]
	local shftag = DTargPos[2]
	local gpftag = ATargPos[1]
	local ghftag = ATargPos[2]
	-- 设置防守方优先攻击
	if fManorData.pfobj and fManorData.pfobj == 1 then
		spfobj = 11
		-- spftag = DTargPos[2]
	end
	if fManorData.hfobj and fManorData.hfobj == 1 then
		shfobj = 10
		-- shftag = DTargPos[1]
	end
	-- 设置攻击方优先攻击
	if pManorData.pfobj and pManorData.pfobj == 1 then
		gpfobj = 12
		-- gpftag = ATargPos[2]
	end
	if pManorData.hfobj and pManorData.hfobj == 1 then
		ghfobj = 9
		-- ghftag = ATargPos[1]
	end	
	-- 取玩家鼓舞数值
	local gIns = pManorData.ins or 0
	local sIns = fManorData.ins or 0
	--6、创建对手(怪物)	
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
	--7、创建自己(怪物)
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
	--8、PutPlayerTo	
	if not active_marank:add_player(sid, 1, 0, nil, nil, mapGID) then
		--look("PI_MovePlayer err when MR_Fight")
		return
	end
	
	--9、 设置玩家隐身
	local rset = CI_SetPlayerData(2,1)
	--look('rset:' .. rset)
	
	--10、这里才真正扣次数(因为前面已经调用过检查了 所以这里应该不会失败了)	
	if not CheckTimes(sid,uv_TimesTypeTb.MK_Attack,1,-1) then
		--look("排位赛次数用完了噢，亲！")			
		return
	end
	
	-- 11、加满血量
	-- PI_PayPlayer(3,1000000)
	
	mrkDRData.gSID = sid			-- 设置攻击方SID
	mrkDRData.record = {}
	mrkDRData.record[1] = {Aobj,plaGID,AheroGID}
	mrkDRData.record[2] = {Dobj,monGID,DheroGID}
	
	pManorTemp.mrkSID = pid			-- 对手SID(点击时当前排位的sid) 
	pManorTemp.mrkBEG = GetServerTime()		-- 排位赛开始时间
	pManorTemp.mrkRNK = idx			-- 攻打排名
	pManorTemp.mrkGID = mapGID		-- 场景GID
	
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

-- 快速查看结果
-- 这个应该不用考虑是否是第一次打 因为40级才开放查看功能
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

	-- 移除怪物
	RemoveObjectIndirect(mapGID,9)
	RemoveObjectIndirect(mapGID,10)
	RemoveObjectIndirect(mapGID,11)
	RemoveObjectIndirect(mapGID,12)
end

-- 鼓舞
function MR_Inspire(sid,iType)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	local ins = pManorData.ins or 0
	if ins >= 20 then
		SendLuaMsg( 0, { ids = MRK_Ins, res = 1 }, 9 )
		return
	end
	local yb = 2
	-- 扣钱
	if iType == 0 then
		if not CheckCost(sid,yb,0,1,"排位赛鼓舞") then
			SendLuaMsg( 0, { ids = MRK_Ins, res = 2 }, 9 )	
			return
		end
	elseif iType == 1 then
		local bdyb = GetPlayerPoints(sid,3)
		if bdyb < yb*5 then
			SendLuaMsg( 0, { ids = MRK_Ins, res = 2 }, 9 )	
			return
		end
		AddPlayerPoints(sid,3, -(yb*5), nil,"排位赛鼓舞",true)			
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

-- 排位赛奖励处理
function MR_AwardProc(sid)
	-- --look("MR_AwardProc")
	
	-- local pManorTemp = GetPlayerManorTemp(sid)
	-- if pManorTemp == nil or pManorTemp.mrkAwards == nil then
		-- MR_ClearTemp(sid)
		-- return 
	-- end
	
	-- SendLuaMsg( 0, { ids = MRK_Do, awd = pManorTemp.mrkAwards}, 9 )
end

-- 排位赛退出消息处理
-- 需判断当前所在场景是否为战斗场景、如果不是就不用传送了
function MR_Exit(sid,iType)
	--look("MR_Exit")
	-- 将玩家移出场景
	active_marank:back_player(sid)
	
	-- 清理临时数据
	MR_ClearTemp(sid)
	
	SendLuaMsg( 0, { ids = MRK_Exit }, 9 )
end

-- 对象死亡处理
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
	
	if bside == 0 then			-- 防守方死亡对象数量 +1		
		record[2][1] = (record[2][1] or 0) - 1
		if record[2][1] <= 0 then
			MR_Win(sid)
		end	
	elseif bside == 1 then		-- 攻击方死亡对象数量 +1		
		record[1][1] = (record[1][1] or 0) - 1
		if record[1][1] <= 0 then			
			MR_Lose(sid)
		end	
	end
end

-- 防守方怪物死亡
call_monster_dead[1] = function (mapGID)
	--look('AddDeadObj 0')
	AddDeadObj(mapGID,0)
end

-- 攻击方怪物死亡
call_monster_dead[7] = function (mapGID)
	--look('AddDeadObj 1')
	AddDeadObj(mapGID,1)
end

-- 排位赛购买次数
function MR_BuyTimes(sid,num)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then 		
		return 
	end
	if num <= 0 then return end
	if not CheckTimes(sid,uv_TimesTypeTb.MK_Attack,num,1,1) then
		--look("购买次数不足！")
		return
	end
	if not CheckCost(sid,rint(20*num),0,1,'排位赛购买次数') then
		--look("钱都木有啊，买个铲铲！")			
		return
	end
	if not CheckTimes(sid,uv_TimesTypeTb.MK_Attack,num,1) then
		--look("购买都买不了，你人品有问题啊！亲！")			
		return
	end
end

-- 设置优先攻击目标
-- 家将：默认优先攻击家将
-- 玩家：默认优先攻击玩家
-- obj: [nil or 0] 默认值 [1] 优先攻击反转
function set_fight_obj(sid,setv)
	if sid == nil or type(setv) ~= type({}) then return end
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then 		
		return 
	end
	
	pManorData.hfobj = setv[1]	-- 设置家将优先攻击对象			
	pManorData.pfobj = setv[2]	-- 设置玩家优先攻击对象		
end

-- 排位赛上线奖励处理函数
-- function MRK_OnlineProc(sid)
	-- local pManorTemp = GetPlayerManorTemp(sid)
	-- if pManorTemp == nil then return end
	-- if pManorTemp.mrkRES and pManorTemp.mrkRDList and pManorTemp.mrkSID_r and pManorTemp.mrkAwards then
		-- MR_ReportProc(sid)
	-- end
-- end

-- 死亡处理
function active_marank:on_playerdead(sid,rid,mapGID)
	--look('MaRank_playerdead')	
	CI_OnSelectRelive(0,3*5,2,sid)
	return 1
end

-- 场景切换处理
function active_marank:on_regionchange(sid)
	--look('MaRank_regionchange')
	-- 取消玩家隐身
	local rset = CI_SetPlayerData(2,0)
	MR_Lose(sid)
end

-- 排位赛下线处理
function active_marank:on_logout(sid)
	--look('MaRank_logout')	
	MR_Lose(sid,1)
end

-- 排位赛上线处理
function active_marank:on_login(sid)
	--look('MaRank_login')	
	local pManorTemp = GetPlayerManorTemp(sid)
	if pManorTemp == nil then return end
	-- 这说明已经出结果了、但是既然进了这个函数就说明玩家在还排位赛场景那就需要踢出去
	if pManorTemp.mrkSID == nil or pManorTemp.mrkGID == nil then		
		-- 将玩家移出场景
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

-- 倒计时结束处理
function active_marank:on_DRtimeout(mapGID, args)
	if args == nil or type(args) ~= type(0) then
		return
	end
	local sid = args
	MR_Lose(sid)
end

-- 每天清理鼓舞值
function MR_ClearInspire(sid)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then 		
		return 
	end
	pManorData.ins = 0
end

-- 清理庄园排位赛临时数据
function MR_ClearTemp(sid)
	local pManorTemp = GetPlayerManorTemp(sid)
	if pManorTemp == nil then
		return
	end
	-- 进入时就有的临时数据
	pManorTemp.mrkSID = nil	
	pManorTemp.mrkGID = nil
	pManorTemp.mrkRNK = nil
	pManorTemp.mrkBEG = nil
	
	-- 出结果了才有的临时数据
	pManorTemp.mrkRES = nil		
	pManorTemp.mrkSID_r = nil
	-- pManorTemp.mrkRDList = nil
	-- pManorTemp.mrkAwards = nil
	
	-- CI_SetPlayerData(2,0)	-- 这里暂时不要设置取消隐身
end


-------------------------------------------------排位赛每日排位奖励-------------------------------------

-- 需要时间配置表配置调用
function MRK_RankAward()
	--look('------------MRK_RankAward 1----------------')
	local rkList = GetManorRankList()
	if rkList == nil then return end
	--look('------------MRK_RankAward 2----------------')
	local pManorData
	local wLevel = GetWorldLevel() or 1
	--if __debug then wLevel = 50 end			--测试用、后续删除
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
	-- 广播消息 提示玩家领奖
	--look('------------MRK_RankAward 3----------------')
	BroadcastRPC('MRK_Award')
end

-- 领取排位奖励
function MRK_GiveAward(sid)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	if pManorData.lsRK == nil then		-- 说明没排名奖励
		--look('pManorData.lsRK == nil')
		return
	end
	if CI_GetPlayerData(1) < 35 then
		--look("小伙子！等级不够哇！")
		SendLuaMsg( 0, { ids=MRK_Award, res = 1 }, 9 )
		return
	end	
	local wLevel = GetWorldLevel() or 1
	--if __debug then wLevel = 50 end			--测试用、后续删除
	if wLevel < 30 then 
		wLevel = 30
	end
	--look(pManorData.lsRK)
	if not CheckTimes(sid,uv_TimesTypeTb.MK_Get,1,-1) then		
		--look("领过奖励了，贪心了哈~")
		SendLuaMsg( 0, { ids=MRK_Award, res = 2 }, 9 )
		return
	end
	-- 3、根据排名领取奖励
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
	
	-- 给奖励
	GiveGoods(0,sMoney,1,'排位赛排位奖励')
	AddPlayerPoints( sid, 2, sLQ, nil, "排位赛排位奖励" )
	AddPlayerPoints( sid, 7, sSW, nil, "排位赛排位奖励" )
	AddPlayerPoints( sid, 10, sRY, nil, "排位赛排位奖励" )
	
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

-- 排位赛前100名 每两小时增加荣誉值
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

--检查排位赛与玩家托管数据的排行是否一致
function MRK_LoginCheckRankData(sid)	
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	--玩家未参加过排位赛
	if pManorData.bFst == nil or pManorData.bFst % 2 == 0  then return end
	local rkList = GetManorRankList()
	local rank = pManorData.Rank 
	--检查玩家数据里的rank是否正确
	--排位在2000以外 不处理
	--检查是否在排行中 
	if rank ~= nil then  
		if rank > MAXRANKNUM then return end
		if rkList[rank] ~= nil and rkList[rank] == sid then return end
		--玩家托管数据错误
		rank = nil 
	end

	--已经参加过排位赛 而 玩家排行为空 则数据错误
	if rank == nil then
		--给玩家排位信息重新赋值 (如果在排行榜里有数据的话)
		for k, v in ipairs(rkList) do
			if sid == v then 
				pManorData.Rank  = k
				set_extra_rank(sid, pManorData.Rank)	
				rank = k
				break;
			end
		end
		--rank为空, 而且不在排行榜上..
		if rank == nil then 
			--重置玩家 为第一次参加排位赛
			pManorData.bFst = nil
			pManorData.Rank = nil
		end
	end
end