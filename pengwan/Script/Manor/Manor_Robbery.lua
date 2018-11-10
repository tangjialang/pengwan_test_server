--[[
file: 庄园掠夺
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
local MRB_Times = msgh_s2c_def[35][1]	-- 剩余次数
local MRB_Data = msgh_s2c_def[35][2]	-- 庄园掠夺列表数据
local MRB_Enter = msgh_s2c_def[35][3]	-- 进入掠夺
local MRB_Detl = msgh_s2c_def[35][4]	-- 庄园掠夺所需详细信息
local MRB_Show = msgh_s2c_def[35][5]	-- 查看战斗力
local MRB_Rept = msgh_s2c_def[35][6] 	-- 战报

local MAXTIMES = 30
local mapID = 2001
local _MinLV = 42
local PerPage_C = 12		-- 每一页数量

---------------------------------------------------------------
--data:

-- 偷袭{名字，等级，vip，帮会id，战斗力，头像} --通缉度/庄园外观
-- { 名字，等级，vip，外型，武器，帮会id，战斗力，头像}，	
-- [ pId, serverName, vipType, 城池素材ID, (通缉度), || pID, Lv，(帮会名)，战斗力, 头像ID, (保护时间) ]
local cachelist = {
	{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},
	{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},
	{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},
}

local SIDlist = {0,0,0,0,0,0,0,0,0,0,0,0}		-- SID列表 目前支持12个
local details = {0,0,0,0,0,0}					-- 详细信息

-- 掠夺奖励临时表
local gAward = {0,0,0}
local sAward = {0,0}
-- local ItemList = {}

---------------------------------------------------------------
--inner function:

-- 是否第一次打掠夺
local function MRB_IsFirst(sid)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	if pManorData.bFst == nil or rint(pManorData.bFst/2) % 2 == 0 then
		return true
	end
end

--[[
	@return:
		result 返回当前页的sid列表
		cPage  返回当前页
		tPage  返回总页数
	--  屏蔽掉了同帮会和没托管的玩家
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
			if lv == i then		-- 如果是当前等级页
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
	if total > 1 then total = total - 1 end				-- 去掉自己
	local tPage = rint((total - 1) / PerPage_C) + 1
	
	return cPage,tPage
end
		
-- 构造列表信息
-- flags标志: [0] 都不是  [1] 保护中 [2] 同帮会 [3] 保护中 & 同帮会
local function MRB_BuildList(sid,result)
	-- 先清理数据
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
				local bgID = pZSData[1]	-- 取背景资源ID
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

-- 获取战功加成概率
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

-- 获取勋章加成(个数)
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

-- 获取增加保护时间
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

-- 庄园掠夺战报
-- Res [0] 攻方失败 [1] 攻方胜利
local function MRB_Report(Res,gSID,gAward,sSID,sAward) 
	local tsData = PI_GetTsBaseData(sSID)
	-- --look(tsData)
	SendLuaMsg( gSID, { ids = MRB_Rept,Res = Res,gAward = gAward,sSID = sSID}, 10 )
	-- 防守方发战报邮件
	if not MRB_IsFirst(gSID) then
		local sLv = PI_GetPlayerLevel(sSID)
		if sLv == nil or sLv < 43 then		-- 43级以下不发邮件
			return
		end
		local tgData = PI_GetTsBaseData(gSID)
		-- --look(gAward)
		local Contents = {Res = Res,gSID = gSID,sAward = sAward,tsData = tsData,gAward = gAward,tgData = tgData}
		SendSystemMail(sSID,robmailconf,1,15,Contents)
		
		-- 还要坑爹的广播帮会
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

-- 结果现在统一处理
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
	-- 如果死亡帮他复活
	local rett = CI_OnSelectRelive(0,3*5,2,sid)
	if res == 0 then			
		-- 失败只有战功值
		addZG = 15
		AddPosFeats(sid,addZG)				
		
		-- 发送战报
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
			-- 获得铜钱	
			loseMon = GD_SetMoneyTree(othersid,-1,10)	-- 扣当前存量的10% 返回实际扣钱				
			realMon = loseMon or 0
			local lv = CI_GetPlayerData(1,2,sid)
			if lv == nil or lv <= 0 then return end
			if realMon < rint(lv * 100) then		-- 保底收益
				realMon = lv * 100
			end
			-- 获得战功 
			addZG = rint(otherLV * GetZGRate(othersid) * 1.5)	
			
			-- 如果是敌对帮会成员增加帮贡			
			if isEnemyFaction(sid,othersid) then
				bg = rint(otherLV / 5)				
			end
									
			-- 对方失败了 如果战功超过6级会掉战功			
			local curZG = PI_GetPlayerZG(othersid)
			local pos = GetPos(curZG) or 0
			-- if pos >= 6 then
				-- loseZG = (pos - 4) * 5				
			-- end
			-- 对方失败了 更新对方的保护时间
			local porT = GetProTime(othersid)
			local now = GetServerTime()
			if otherMaData.rbPT and otherMaData.rbPT > now then
				otherMaData.rbPT = otherMaData.rbPT + (porT or 600)	-- 默认给10分钟
			else
				otherMaData.rbPT = now + (porT or 600)				-- 默认给10分钟
			end
			-- 更新通缉度
			if selfMaData.Degr == nil or selfMaData.Degr < 0 then
				selfMaData.Degr = 1
			else
				selfMaData.Degr = selfMaData.Degr + 1
			end
			otherMaData.Degr = (otherMaData.Degr or 0) - 1
		end
		
		-- 给奖励
		-- addXZ = rint(otherLV/10) + GetXZRate(othersid)
		-- ItemList[1] = {1052,addXZ,1}
		-- PI_GiveGoodsEx(sid,robmailconf,2,2,addXZ,ItemList,nil,"掠夺给勋章")		-- 勋章
		GiveGoods(0,realMon,1,"掠夺获得铜钱")		-- 给铜钱
		AddPosFeats(sid,addZG)							-- 给战功
		AddPlayerPoints(sid,4,bg,nil,'庄园掠夺')						-- 加帮贡
		PI_GiveGoodsEx(sid,robmailconf,2,2,nil,{{691,1,1},},nil,'庄园掠夺')	-- 梳妆盒
		-- 对方扣战功
		PI_AddPlayerZG(othersid, 0 - loseZG)
		
		-- 发送战报
		gAward[1] = realMon
		gAward[2] = addZG
		gAward[3] = bg
		sAward[1] = loseMon
		sAward[2] = loseZG
		
	end
	-- 清理数据
	MRB_ClearTemp(sid)
	
	MRB_Report(res,sid,gAward,othersid,sAward)		
end

-- 胜利
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
	-- 结果处理
	MRB_ResultProc(sid,othersid,1)
end

-- 失败
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
	-- 结果处理
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

-- 关注
function MRB_Attention(sid,othersid)
	if sid == nil or othersid == nil or sid == othersid then return end
	if othersid == 1001 then return end		-- 特殊处理人物 不能关注
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

-- 添加掠夺列表(等级触发)
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
		for k, v in ipairs(roblist[oldLV]) do	-- 从旧的等级表遍历查找并remove
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

-- opt: [0] 初始化面板 [1] 检查次数 [2] 检查并扣除次数 [3] 购买次数 [4] 道具增加次数
-- 掠夺次数更新及检查：两小时恢复一次
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

	-- if opt == 1 then		-- 检查次数
		-- if pManorData.rbTS[1] < 1 then
			-- return false
		-- end
	-- end
	-- if opt == 2 then		-- 扣除次数
		-- if pManorData.rbTS[1] < 1 then
			-- return false
		-- end
		-- pManorData.rbTS[1] = pManorData.rbTS[1] - 1	
		
		-- -- 更新活跃度
		-- CheckTimes(sid,TimesTypeTb.HomePlunder_Time,1)
	-- end
	-- if opt == 3 then
		-- if pManorData.rbTS[1] >= 50 then
			-- --look("超过上限不能购买")
			-- return false
		-- end
		-- if not CheckCost(sid,50,0,1,'100011_购买掠夺次数') then
			-- --look("钱不够")
			-- return false
		-- end
		-- pManorData.rbTS[1] = pManorData.rbTS[1] + 1
	-- end
	-- if opt == 4 then
		-- if pManorData.rbTS[1] >= 50 then
			-- --look("超过上限道具不能增加")
			-- return false
		-- end		
		-- pManorData.rbTS[1] = pManorData.rbTS[1] + 1
	-- end

	-- SendLuaMsg( 0, { ids = MRB_Times, ts = pManorData.rbTS,opt=opt }, 9 )
	
	-- return true
-- end

-- 查看战斗力
function MRB_ShowFight(sid)
	local isby = baoyue_getpower(sid, 3)
	if not isby then
		if not CheckCost(sid,10,0,1,'100027_查看战斗力') then
			SendLuaMsg( 0, { ids = MRB_Show, res = 1 }, 9 )
			return
		end
	end
	SendLuaMsg( 0, { ids = MRB_Show, res = 0 }, 9 )
end

-- 发送庄园掠夺列表
-- iType [0] 默认等级面板 [1] 敌对帮派面板(param = 成员列表) [2] 关注面板(param = 关注列表)
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
		if iType == 0 then			-- 默认等级面板	
			local RobList = GetManorRobberyList()
			if RobList == nil then return end
			for i=1 ,#(SIDlist) do
				SIDlist[i] = 0
			end
			result = SIDlist
			cPage,tPage = GetPageInfo(RobList,lv,nPage,sid,result)

		elseif iType == 1 then		-- 帮派面板
			if param == nil or type(param) ~= type({}) then return end
			result = param
			cPage = nPage
			
		elseif iType == 2 then		-- 关注面板
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
	
	-- 构造当前页信息
	local cachelist = MRB_BuildList(sid,result)
	-- 更新并发送掠夺剩余次数
	-- if nPage == nil then
		-- MRB_CheckRobTimes(sid,0)
	-- end
	-- --look(cachelist)
	-- 发送列表信息
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
	-- if iType == 0 then			-- 默认等级面板	
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
		
	-- elseif iType == 1 then		-- 帮派面板
		-- if param == nil or type(param) ~= type({}) then return end
		-- result = param
		-- cPage = nPage
		
	-- elseif iType == 2 then		-- 关注面板
		-- if param == nil or type(param) ~= type({}) then return end
		-- result = param
		-- cPage = nPage
	-- end
	
	-- if result == nil then return end
	-- if nPage and nPage ~= cPage then return end	
	-- -- 更新并发送掠夺剩余次数
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

-- 点击城池取详细信息
-- 偷袭{名字，等级，vip，帮会id，战斗力，头像} --通缉度/庄园外观
-- { 名字，等级，vip，外型，武器，帮会id，战斗力，头像}，	
-- [ pId, serverName, vipType, 城池素材ID, (通缉度), || pID, Lv，(帮会名)，战斗力, 头像ID, (保护时间) ]
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

-- 庄园掠夺
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
		
	-- 1、判断次数
	if not CheckTimes(sid,TimesTypeTb.rob_fight,1,-1,1) then
		SendLuaMsg( 0, { ids = MRB_Enter, res = 1  }, 9 )
		return
	end
	local now = GetServerTime()
	-- 2、判断对方是否处于保护CD
	if otherMaData.rbPT and now < otherMaData.rbPT then
		SendLuaMsg( 0, { ids = MRB_Enter, res = 2  }, 9 )
		return
	end
	-- -- 3、判断是否是本帮的
	local selfFacID = PI_GetPlayerFacID(sid) or 0
	local otherFacID = PI_GetPlayerFacID(othersid) or 0
	if selfFacID ~= 0 and otherFacID ~= 0 and selfFacID == otherFacID then
		SendLuaMsg( 0, { ids = MRB_Enter, res = 3  }, 9 )
		return
	end
	
	-- -- 4、判断等级不能小于自己10级
	local selfLV = CI_GetPlayerData(1)
	local otherLV = PI_GetPlayerLevel(othersid)
	if not MRB_IsFirst(sid) then
		if otherLV == nil or otherLV < _MinLV or selfLV < _MinLV or otherLV < selfLV - 10 then
			SendLuaMsg( 0, { ids = MRB_Enter, res = 4  }, 9 )
			return
		end
	end
	-- 如果在庄园先调用一次退出庄园场景
	OutZYparty(sid,nil,0)
	--5、根据防守方装饰创建PK场景 (自动删除场景)
	local pZSData = PI_GetCurGarniture(othersid)
	if pZSData == nil or pZSData[1] == nil then return end
	local bgID = pZSData[1]	-- 取背景资源ID
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
	
	--6、创建防守方(人物和随从和宠物)	
	local PlayerMonsterConf = PlayerMonsterConf
	local monsterConf = PlayerMonsterConf[2]
	local Dobj = CreatePlayerMonster(2,othersid,monsterConf,mapGID,DPos[1],5) or 0
	local heroConf = PlayerMonsterConf[3]
	Dobj = Dobj + (CreateHerosMonster(othersid,heroConf,mapGID,DPos[2],5) or 0)
	local petConf = PlayerMonsterConf[6]
	Dobj = Dobj + (CreatePetMonster(othersid,petConf,mapGID,DPos[3],5) or 0)
	
	--7、PutPlayerTo
	if not active_marobb:add_player(sid, 1, 0, APos[1][1], APos[1][2], mapGID) then
		--look("PI_MovePlayer err when MRB_Fight")
		return
	end
	
	LockPlayer( 3000, sid )		-- 锁定3秒后才开始攻击
	
	-- 8、创建攻击方的随从
	heroConf = PlayerMonsterConf[4]
	local camp = CI_GetPlayerData(39,2,sid) or 0
	local Aobj = (CreateHerosMonster(sid,heroConf,mapGID,APos[2],camp,DPos[1]) or 0) + 1
	--look(heroConf)
	-- 9、扣次数
	CheckTimes(sid,TimesTypeTb.rob_fight,1,-1)
	
	-- 10、清除自身保护CD
	selfMaData.rbPT = nil
	
	-- 11、加满血量
	PI_PayPlayer(3,1000000)
	
	-- 记录双方死亡对象数、弄死完才算输
	mrbDRData[1] = sid	
	mrbDRData[2] = Aobj
	mrbDRData[3] = Dobj
	
	-- 取果园数据给前台显示资源
	local StateTb = GD_GetFieldState(othersid)

	-- 存储临时数据
	selfMaTemp.mrbName = PI_GetPlayerName(othersid)
	selfMaTemp.mrbSID = othersid
	selfMaTemp.mrbBEG = GetServerTime()
	-- 更新最后访问时间
	set_last_access(othersid)
	-- SendLuaMsg( 0, { ids = MRB_Enter, res = 0, zs = pZSData, gd = StateTb, tm = 3*60 }, 9 )
	SendLuaMsg( 0, { ids = MRB_Enter, res = 0, zs = pZSData, gd = StateTb, Aobj = Aobj, Dobj = Dobj, tm = 3*60 }, 9 )		
end

-- 庄园掠夺退出
function MRB_Exit(sid)
	active_marobb:back_player(sid)
end

-- 对象死亡处理
function AddDeadObj(mapGID,bside)
	--look(mapGID .. ':' .. bside)
	local mrbDRData = active_marobb:get_regiondata(mapGID)
	if mrbDRData == nil or type(mrbDRData) ~= type({}) then return end
	local Asid = mrbDRData[1]
	if bside == 0 then			-- 防守方死亡对象数量 +1		
		mrbDRData[3] = (mrbDRData[3] or 0) - 1
		if mrbDRData[3] <= 0 then
			MRB_Win(Asid)
		end	
	elseif bside == 1 then		-- 攻击方死亡对象数量 +1		
		mrbDRData[2] = (mrbDRData[2] or 0) - 1
		if mrbDRData[2] <= 0 then			
			MRB_Lose(Asid)
		end	
	end
	--look('AddDeadObj:' .. bside)
	RPCEx(Asid,'MRB_AddDeadObj',bside)
end

-- 防守方人物死亡
call_monster_dead[2] = function (regionID)
	--look("OnMonsteDead_2")
	AddDeadObj(regionID,0)
end

-- 防守方随从死亡
call_monster_dead[3] = function (regionID)
	--look("OnMonsteDead_3")
	AddDeadObj(regionID,0)
end

-- 防守方宠物死亡
call_monster_dead[6] = function (regionID)
	--look("OnMonsteDead_6")
	AddDeadObj(regionID,0)
end

-- 攻击方随从死亡
call_monster_dead[4] = function (regionID)
	--look("OnMonsteDead_4")
	AddDeadObj(regionID,1)
end

-- 死亡处理(攻击方死亡数+1)
function active_marobb:on_playerdead(sid, rid, mapGID)
	--look('MaRobb_playerdead')	
	AddDeadObj(mapGID, 1)
	return 1
end

-- 场景切换处理
function active_marobb:on_regionchange(sid)
	--look('MaRobb_regionchange')	
	MRB_Lose(sid)
end

-- 庄园掠夺下线处理
function active_marobb:on_logout(sid)
	--look('MaRobb_logout')	
	MRB_Lose(sid)
end

-- 庄园掠夺上线处理
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

-- 倒计时结束处理
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
