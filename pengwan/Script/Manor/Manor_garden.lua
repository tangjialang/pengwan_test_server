--[[
	file:	菜园
	author:	csj
	update:	

notes:
	1、菜园系统的次数可以不用做到次数管理器 因为纯托管数据会删除 没必要对已经删除的功能做次数管理
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
local GD_Data = msgh_s2c_def[27][1]		-- 菜园数据
local GD_Open = msgh_s2c_def[27][2]		-- 开启田地
local GD_Sow = msgh_s2c_def[27][3]		-- 播种
local GD_Opt = msgh_s2c_def[27][4]		-- 菜园互动操作
local GD_Bite = msgh_s2c_def[27][5]		-- 被狗咬
local GD_Record = msgh_s2c_def[27][6]	-- 菜园操作记录
local GD_mTree = msgh_s2c_def[27][7]	-- 摇钱树信息
local GD_Luck = msgh_s2c_def[27][8]		-- 幸运值
local GD_fList = msgh_s2c_def[27][9]	-- 好友状态
local GD_Land = msgh_s2c_def[27][10]	-- 土地信息
local Pet_Set = msgh_s2c_def[38][3]	-- 幻化宠物

local BaseOpenNum = 2
local percent = 0.1		-- 每次偷取10%

-------------------------------------------------------------------------
--data:
local fList = {0,0,0,0,0,0,0,0,0,0,0,0}
local StateTb = {{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},}

-------------------------------------------------------------------------
--inner function:

-- 随机下次长草或长虫时间,种植的时候做一次随机，以后只有在其他玩家除草或除虫时才会触发下次随机	(30到50分钟)
-- 为了统一判断规则 ( 最后不长草也不长虫的时候记录了两个成熟时间 )
local function GetTimeAndType(ripeTime)
	local now = GetServerTime()	
	local nexttime = math.random(30 * 60,50 * 60)
	-- if __debug then
		-- nexttime = mathrandom(3,5)	-- 测试用
	-- end
	if now + nexttime >= ripeTime then	-- 超过成熟时间不会长草或虫
		nexttime = ripeTime		
	else
		nexttime = now + nexttime
	end
	-- 如果这里的类型要做随机的话那么在这次没随出类型的情况下 需要重新随机下次时间及类型( 也就是一个递归调用 )
	local itype = nil
	if nexttime ~= ripeTime then
		itype = mathrandom(1,2)
	else
		itype = 4
	end
	return nexttime,itype 
end

-- 获得成熟时间 (跟妲己好感度级别有关)
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

-- 随机变异果
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
		-- -- 调试用
		-- if __debug then
			-- if seedID == 1018 then
				-- return math.random(1081,1083)
			-- end
		-- end
	end
	return
end

-- 计算成熟收益 跟种子和妲己好感度有关
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

-- 检查是否可操作 max = 17
local function GD_CheckState(sid,othersid,index,opt)
	local playerid = othersid or sid
	local pGardenData = GetGardenData_Interf(playerid)
	if pGardenData == nil or pGardenData[index] == nil then
		--look("菜地为空")
		return 1
	end
	local now = GetServerTime()
	
	-- 铲除操作
	if opt == -1 then
		if othersid ~= nil then
			--look("不能铲除别人的菜地")
			return 16
		end
		if now >= pGardenData[index][2] then
			--look("已成熟不能操作")
			return 2
		end
		
	-- 加速操作
	elseif opt == 0 then
		if othersid ~= nil then
			--look("不能加速别人的菜地")
			return 4
		end
		if pGardenData[index][4] > 0 then
			--look("已经加速过一次了 不能加速了")
			return 5
		end
		if now >= pGardenData[index][2] then
			--look("已经成熟不能加速了")
			return 6
		end
		local isby = baoyue_getpower(sid, 5)
		local ct = CheckTimes(sid,uv_TimesTypeTb.GD_Speed,1,-1)
		if not isby or not ct then
			if not CheckCost(sid,10,0,1,'100018_加速操作') then
				--look("钱钱不够哈！亲！")
				return 17
			end
		end
		
	-- 除草或除虫操作 ( 触发下次长草或者长虫时间 )
	elseif opt == 1 or opt == 2 then			
		if now >= pGardenData[index][2] then
			--look("已成熟不能操作")
			return 7
		end
		if pGardenData[index][5] == nil or pGardenData[index][6] == nil then
			--look("可操作类型为空")
			return 8
		end
		if now < pGardenData[index][5] or opt ~= pGardenData[index][6] then
			--look("操作类型不匹配[" .. pGardenData[index][6] .. "]" )
			return 9
		end		
		
	--  浇水操作 ( 触发下次枯萎时间 )
	elseif opt == 3 then
		if now < pGardenData[index][2] then
			--look("没成熟不能浇水")
			return 10 
		end
		if pGardenData[index][5] == nil or pGardenData[index][6] == nil then
			--look("可操作类型为空")
			return 11
		end
		if now < pGardenData[index][5] or opt ~= pGardenData[index][6] then
			--look("操作类型不匹配[" .. pGardenData[index][6] .. "]" )
			return 12
		end		
	
	-- 偷菜/收获 操作 ( 这里只判断是否成熟并且没有枯萎 )
	elseif opt == 4 then
		if pGardenData[index][5] == nil or pGardenData[index][6] == nil then
			--look("可操作类型为空")
			return 13
		end
		
		if now < pGardenData[index][2] then
			--look("没成熟不能偷取/收获")
			return 14
		else
			if othersid == nil then		-- 收获
				if pGardenData[index][6] == 3 and now >= pGardenData[index][5] then
					--look("已枯萎不能收获")
					return 15
				end
			else						-- 偷取				
				if pGardenData[index][6] == 3 then		-- 用接下来的状态判断是否偷完
					--look("已偷完不能再偷")
					return 18
				end
				local pGardenTemp = GetExtraTemp_Garden(othersid)
				if pGardenTemp == nil then 
					return 19
				end
				if pGardenTemp[index] and pGardenTemp[index][sid] == 1 then
					return 20			-- 已经偷过这块地了
				end
			end
		end			
	end
	
	return 0
end

-- 菜园操作记录
-- opt [4] 被偷 [5] 被抓 seedID=money
local function GD_RecordOpt(sid,othersid,opt,seedID)
	if othersid == nil then return end
	local playerid = othersid or sid
	-- local pGardenData = GetGardenData_Interf(playerid)
	-- if pGardenData == nil then return end
	local opName = CI_GetPlayerData(5,2,sid)
	
	-- 调用存储过程写日志
	garden_opt_record(othersid,opName,opt,seedID,0)
	if IsPlayerOnline(othersid) then
		SendLuaMsg( othersid, { ids = GD_Record,opName = opName,opt = opt,seedID = seedID }, 10 )
	end
end

-- 如果有变异果 需要判断包裹
-- 返回值: [0] 未偷到变异果  [1] 偷到或者收获变异果
local function GD_DoAward(sid,othersid,stype,gains,SpecID)
	-- 给奖励
	if stype == 1 then				-- 给经验
		PI_PayPlayer(1,gains,0,0,'种植变异果')
	elseif stype == 2 then			-- 给铜钱
		GiveGoods(0,gains,1,"菜园获得")
	elseif stype == 3 then			-- 给灵气
		AddPlayerPoints(sid,2,gains,nil,'果园')
	end
	local selfName = PI_GetPlayerName(sid)
	-- 有变异花
	if SpecID ~= nil then
		local ItemList = {{SpecID,1,1}}		
		if othersid then			-- 概率偷取变异花
			local LogInfo = "偷取变异花"
			local rd = mathrandom(1,10000)
			if rd <= 2000 then
				--look("中奖了,偷到变异花了")				
				local otherName = PI_GetPlayerName(othersid)				
				-- 给变异花 包裹满的话发邮件				
				PI_GiveGoodsEx(sid,gardmailconf,2,2,SpecID,ItemList,nil,LogInfo)
				BroadcastRPC('GD_Notice',selfName,otherName,SpecID)
				GD_RecordOpt(sid,othersid,4,SpecID)		--偷到变异果记录日志
				return 1
			end
		else						-- 自己收获变异花
			-- 给变异花 包裹满的话发邮件
			local LogInfo = "收获变异花"
			PI_GiveGoodsEx(sid,gardmailconf,1,2,SpecID,ItemList,nil,LogInfo)
			BroadcastRPC('GD_Notice',selfName,nil,SpecID)
			return 1
		end		
	end
	
	return 0
end

-- 给收获奖励
-- 根据seedID 和 被偷次数 计算奖励
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
	if othersid == nil then		-- 自己菜园 收获
		-- 根据种子类型和品质给奖励(减去被偷的)	
		exps = AddManorExp(sid,addexps,1) or 0
		--look(pGardenData[index][7])
		local gains = rint( pGardenData[index][7] * ( 1 - pGardenData[index][3] * percent ) )
		GD_DoAward(sid,othersid,stype,gains,pGardenData[index][9])
		--look("收获成功")
		pGardenData[index] = nil
		pGardenTemp[index] = nil
		-- 更新活跃度
		CheckTimes(sid,uv_TimesTypeTb.Garden_Time,1)
	else
		-- 判断是否已经偷完了		
		local stcount = 5		-- 取可偷次数(现固定5次)
		
		-- 因为偷完了才会枯萎所以不需要判断是否枯萎了
		if (pGardenData[index][3] or 0) >= stcount then
			--look("偷完了不能再偷了")
			return 91
		end
		-- 判断今日偷菜次数 ( 上限 300 次)
		if not CheckTimes(sid,uv_TimesTypeTb.GD_Steal,1,-1,1) then
			--look("今日偷菜上限了")
			return 92
		end
		
		-- 每块地每个人只能偷一次(现在是放在世界temp下的 服务器关闭就会重置)		
		if pGardenTemp[index] == nil or pGardenTemp[index][sid] == nil then
			pGardenTemp[index] = pGardenTemp[index] or {}
			pGardenTemp[index][sid] = 1
		else			
			--look("您已经偷过这块地了")
			return 93			
		end
		
		-- 判断对方菜园是否有狗		
		local bite = 0
		local now = GetServerTime()
		local petID = PI_GetPetID(othersid)
		if petID and Manor_PetConf[petID] then
			local Rate = Manor_PetConf[petID].rate or 5000 		-- 没配就50%概率处理先
			-- 直接扣身上的钱 有多少扣多少
			--look("遇到狗了")
			local rd = mathrandom(1,10000)
			if rd <= Rate then				-- 触发被抓
				local nPaths = Manor_PetConf[petID].paths or 2		-- 没配就默认2条路
				local rdEx = mathrandom(1,10000)
				-- 先随机是否被抓的结果
				if rdEx <= rint(10000 / nPaths) then
					--look("恭喜你，被狗咬了，还可以继续偷哦，亲~")
					local pGardenTemp = GetExtraTemp_Garden(playerid)
					if pGardenTemp == nil then return end
					if pGardenTemp[index] and pGardenTemp[index][sid] then
						pGardenTemp[index][sid] = nil		-- 重置偷取列表 可以继续偷
					end
					local money = mathrandom(500,1000)
					CheckCostAll(sid,money,'被狗咬')					-- 扣玩家身上的铜钱钱 有多少扣多少 扣完为止
					GD_SetMoneyTree(othersid,1,money)		-- 对方加钱、加到摇钱树上
					GD_RecordOpt(sid,othersid,5,money)
					SendLuaMsg( 0, { ids = GD_Bite, idx = index, dtype = petID, money = money, pid = playerid }, 9 )
					return -1	
				end	
				bite = -1
			end
		end
		
		-- 扣次数
		CheckTimes(sid,uv_TimesTypeTb.GD_Steal,1,-1,0)		
		
		-- 没有狗或没被抓 根据种子类型和品质给奖励
		local gains = rint( pGardenData[index][7] * percent )
		local ret = GD_DoAward(sid,othersid,stype,gains,pGardenData[index][9])
		if ret == 1 then
			pGardenData[index][9] = nil
		end
		--look("偷取成功" .. pGardenData[index][3])
		pGardenData[index][3] = pGardenData[index][3] + 1
		-- 如果偷完了 触发枯萎
		if pGardenData[index][3] == stcount then
			pGardenData[index][5] = now + 8 * 60 * 60
			-- --look("触发枯萎:" .. index)
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
-- othersid == nil 进入自己菜园
-- othersid ~= nil 进入好友菜园
function GD_EnterGarden(sid,othersid)	
	-- 先判断等级
	local playerid = othersid or sid
	--look("GD_EnterGarden:" .. playerid)
	local pGardenData = GetGardenData_Interf(playerid)
	if pGardenData == nil then
		SendLuaMsg( 0, { ids = GD_Data, fields = default, pid = playerid, }, 9 )
		return 
	end
	-- 第一次进自己的果园 初始化宠物信息
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
					if v[sid] == 1 then	-- 已经偷过
						stealtb[k] = 1
					end
				end
			end
		end
		SendLuaMsg( 0, { ids = GD_Data, fields = pGardenData, stb = stealtb, pid = playerid, }, 9 )
		-- 进入他人果园 发送庄园信息(等级、经验、宠物)
		SyncManorData(sid,othersid,2)
		-- 更新最后访问时间
		set_last_access(sid)
	end
end

-- 获取果园田地状态(进庄园所需显示资源) 8*2
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

-- 取好友果园状态
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
							break	-- 同时只能有一种状态
						end						
					end
					if state == 4 then
						break
					end
				end
			end			
		end	
		fList[k] = state or 0		-- 就算state为nil也要占个位
	end
	SendLuaMsg( 0, { ids = GD_fList, page = page, fList = fList }, 9 )	
end

-- 第一次进入山庄初始化摇钱树
function GD_InitMoneyTree(sid)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	local now = GetServerTime()
	if pManorData.MonT == nil then
		pManorData.MonT = {
			20000,					-- 当前存量
			now,					-- 存量上次更新时间
			0,						-- 下次领取时间
			0,						-- 每日被掠夺的值
		}
		SendLuaMsg( sid, { ids = GD_mTree, mt = pManorData.MonT, iType = 0 }, 10 )
	end	
end
--[[
	摇钱树处理函数
	@iType: [nil] 获取摇钱树当前存量(不发消息)  [0] 获取摇钱树信息(发消息) [1] 领取摇钱树操作(发消息) 
			[2] 秒CD(绑定元宝) [3] 秒CD(元宝)
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
	local yield = rint(level*200)		-- 每小时产量
	local limit = yield * 24		-- 上限			
		
	-- 更新存量
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
	-- 获取摇钱树信息(发消息)
	if iType == 0 then
		SendLuaMsg( sid, { ids = GD_mTree, mt = mtTable, iType = iType }, 10 )
		return 
	end
	-- 领取摇钱树
	if iType == 1 then
		if now < mtTable[3] then	-- 冷却时间未到
			SendLuaMsg( sid, { ids = GD_mTree, iType = iType, res = 1 }, 10 )
			return
		end
		local store = mtTable[1]
		GiveGoods(0, mtTable[1], 1, "摇钱树领取",sid)
		mtTable[1] = 0
		mtTable[2] = now
		mtTable[3] = now + 8 * 60 * 60
		mtTable[4] = 0
		-- 更新活跃度
		CheckTimes(sid,uv_TimesTypeTb.MoneyTree_Time,1)
		
		SendLuaMsg( sid, { ids = GD_mTree, mt = mtTable, iType = iType, res = 0, store = store }, 10 )
		return
	end	
	-- 秒CD(扣绑定元宝)
	if iType == 2 then
		if now < mtTable[3] then
			local yb = rint((mtTable[3] - now) / 300) + 1
			if not CheckCost(sid,yb * 5,1,1,"摇钱树秒CD") then
				SendLuaMsg( sid, { ids = GD_mTree, iType = iType, res = 1 }, 10 )
				return
			end
		end
		mtTable[3] = 0
		SendLuaMsg( sid, { ids = GD_mTree, iType = iType, res = 0 }, 10 )
	end
	-- 秒CD(扣元宝)
	if iType == 3 then
		if now < mtTable[3] then
			local yb = rint((mtTable[3] - now) / 300) + 1
			if not CheckCost(sid,yb,0,1,"100025_摇钱树秒CD") then
				SendLuaMsg( sid, { ids = GD_mTree, iType = iType, res = 1 }, 10 )
				return
			end
		end
		mtTable[3] = 0
		SendLuaMsg( sid, { ids = GD_mTree, iType = iType, res = 0 }, 10 )
	end
end

--[[
	摇钱树处理函数
	@iType: 
			[1] 加钱(数值) [-1] 扣钱(百分比)	
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
	local yield = rint(level*200)		-- 每小时产量
	local limit = yield * 24		-- 上限
	if interval >= 60 then									
		local addMoneys = rint(rint(interval / 60) * (yield / 60))
		if mtTable[1] + addMoneys > limit then
			mtTable[1] = limit
		else
			mtTable[1] = mtTable[1] + addMoneys
		end	
		mtTable[2] = now
	end		
	-- 加钱 (判断是否到了摇钱树存量上限 返回实际加钱数)
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
	-- 扣钱(判断是否扣到了每日上限 返回实际扣除钱数)
	if iType == -1 then
		--look(mtTable)
		if money == nil or type(money) ~= type(0) or money < 0 then
			return 0
		end
		money = rint(mtTable[1] * money / 100)
		-- 每日扣钱上限
		local prot = level * level * 5
		if (mtTable[4] or 0) + money > prot then
			money = prot - (mtTable[4] or 0)		-- 取实际被扣钱数
		end
		if money < 0 then
			money = 0
		end
		-- 扣完为止
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

-- 开启一块菜田
function GD_OpenField(sid,index)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	local pGardenData = GetGardenData_Interf(sid)
	if pGardenData == nil then return end
	local opens = pGardenData.opens	or BaseOpenNum
	if index <= opens or index ~= opens + 1 then 
		SendLuaMsg( 0, { ids = GD_Open, res = 1 }, 9 )		-- 已经开过这块地了或不能跳着开
		return
	end
	local mLv = pManorData.mLv or 1
	local maxOpens = rint(mLv / 5) + BaseOpenNum			-- 庄园等级 每5级开一块地
	if index > maxOpens then
		SendLuaMsg( 0, { ids = GD_Open, res = 2 }, 9 )		-- 庄园等级不够
		return
	end
	-- 扣钱或者扣元宝(规则未定)
	pGardenData.opens = (pGardenData.opens or BaseOpenNum) + 1
	SendLuaMsg( 0, { ids = GD_Open, res = 0, idx = index }, 9 )	
end

-- 种菜 因为这里初始化数据 所以没有跟其他操作放在一起
-- 为了方便seedID = ItemID 种子为实体道具
function GD_SowSeed(sid,index,seedID)
	local pGardenData = GetGardenData_Interf(sid)
	if pGardenData == nil then return end
	if index > (pGardenData.opens or BaseOpenNum) then
		SendLuaMsg( 0, { ids = GD_Sow, res = 1 }, 9 )	-- 地没开
		return
	end
	if pGardenData[index] ~= nil then
		SendLuaMsg( 0, { ids = GD_Sow, res = 2 }, 9 )	-- 已经有种子了
		return
	end
	
	if Garden_Conf.seeds[seedID] == nil then
		SendLuaMsg( 0, { ids = GD_Sow, res = 3 }, 9 )	-- 种子配置有误
		return
	end
	-- 检查背包是否有种子
	if CheckGoods(seedID, 1, 0, sid,'检查背包是否有种子') == 0 then
		SendLuaMsg( 0, { ids = GD_Sow, res = 4 }, 9 )	-- 没有种子
		return
	end
	-- 获取成熟时间
	local ripeTime = GetRipeTime(sid,seedID)
	if ripeTime == nil then return end
	-- 随机下次长草或长虫时间
	local nexttime,itype = GetTimeAndType(ripeTime)
	-- 获取成熟收益
	local _,awards = GetGains(sid,seedID)
	-- 随机是否出变异果(种的时候随机避免了进菜园的遍历, 跟种子和幸运值)有关)
	local now = GetServerTime()
	-- 初始幸运值 1%
	local luck = 100
	local SpecID = RandSpecial(seedID,luck)
	pGardenData[index] = {
		seedID,				-- 种子ID	[1]		
		ripeTime,			-- 成熟时间 [2]
		0,					-- 被偷次数 [3]
		0,					-- 加速次数 [4]
		nexttime,			-- 下次长草或长虫或枯萎时间 [5]
		itype,				-- 下次长草或者长虫 1 可除草 2 可除虫 3 可浇水 4 可偷取/可收获  [6]
		awards,				-- 收益		[7]
		luck,				-- 幸运值	[8]
		SpecID,				-- 是否会出变异果	[9]
	}
	SendLuaMsg( 0, { ids = GD_Sow, res = 0, idx = index, dt = pGardenData[index] }, 9 )
	AddManorExp(sid,1,1)	-- 播种加庄园经验
end

-- 使用幸运药水(每次使用计算是否会出变异果,会覆盖上次结果)
function GD_AddLuck(sid,index,luckid)
	local pGardenData = GetGardenData_Interf(sid)
	if pGardenData == nil or pGardenData[index] == nil then
		SendLuaMsg( 0, { ids = GD_Luck, res = 1 }, 9 )		-- 菜地为空不能操作
		return
	end
	
	local now = GetServerTime()
	if now >= pGardenData[index][2] then
		SendLuaMsg( 0, { ids = GD_Luck, res = 2 }, 9 )		-- 已经成熟不能使用幸运药
		return
	end 
	-- 幸运概率大于80%不能再使用
	if pGardenData[index][8] >= 8000 then
		SendLuaMsg( 0, { ids = GD_Luck, res = 3 }, 9 )		-- 幸运值已达到最大不能再使用
		return
	end
	
	-- 检查背包是否有幸运药
	if CheckGoods(luckid, 1, 0, sid,'检查背包是否有幸运药') == 0 then
		SendLuaMsg( 0, { ids = GD_Luck, res = 4 }, 9 )		-- 没有幸运药
		return
	end
	
	if luckid == 664 then		-- 初级幸运药
		pGardenData[index][8] = (pGardenData[index][8] or 0) + 1000
	elseif luckid == 665 then	-- 高级幸运药
		pGardenData[index][8] = (pGardenData[index][8] or 0) + 2000
	end
	pGardenData[index][9] = RandSpecial(pGardenData[index][1],pGardenData[index][8])
	SendLuaMsg( 0, { ids = GD_Luck, res = 0, idx = index, luck = pGardenData[index][8], specid = pGardenData[index][9] }, 9 )
end

-- 菜园操作 (-1 铲除 0 加速 1 除草 2 除虫 3 浇水 4 偷取/收获) 按照显示优先级排列
-- 如果前台能判断后台可不用做是否是自己菜园的判断
function GD_Operations(sid,othersid,index,opt,bFast)
	local playerid = othersid or sid
	local pGardenData = GetGardenData_Interf(playerid)
	if pGardenData == nil then return end
	local pSelfData = GetGardenData_Interf(sid)
	if pSelfData == nil then return end
	
	-- 每次操作前 判断是否已经成熟
	local now = GetServerTime()		
	local exps = 0
	local check = GD_CheckState(sid,othersid,index,opt)
	if check == 0 then
		if opt == -1 then				-- 铲除			
			local pGardenTemp = GetExtraTemp_Garden(sid)
			if pGardenTemp == nil then return end
			pGardenData[index] = nil
			pGardenTemp[index] = nil
		elseif opt == 0 then			-- 加速
			local ripeTime = pGardenData[index][2]
			ripeTime = rint((ripeTime + now) / 2)
			-- 这里需要判断下次长草或长虫时间是否大于加速后的时间 如果是则不能再长草或虫
			if pGardenData[index][5] ~= nil and pGardenData[index][5] > ripeTime then
				pGardenData[index][5] = ripeTime
				pGardenData[index][6] = 4
			end
			pGardenData[index][2] = ripeTime
			pGardenData[index][4] = 1
			
		-- 除草或除虫操作 ( 触发下次长草或者长虫时间 )
		elseif opt == 1 or opt == 2 then					
			-- 判断是否可获得家园经验 每日100点
			exps = AddManorExp(sid,1,1) or 0		-- 除草除虫加庄园经验
			-- if othersid then
				-- AddDearDegree(sid,othersid,1)				-- 加亲密度
			-- end
			-- 随机下次长草或长虫时间
			local ripeTime = pGardenData[index][2]
			local nexttime,itype = GetTimeAndType(ripeTime)
			pGardenData[index][5] = nexttime
			pGardenData[index][6] = itype
			
		--  浇水操作 ( 触发下次枯萎时间 )
		elseif opt == 3 then			
			exps = AddManorExp(sid,1,1) or 0		-- 浇水加庄园经验
			-- if othersid then
				-- AddDearDegree(sid,othersid,1)				-- 加亲密度
			-- end
			-- 设置下次枯萎时间 ( 固定8小时 )
			pGardenData[index][5] = now + 8 * 60 * 60
			pGardenData[index][6] = 3
		
		-- 偷菜/收获操作 ( 如果偷完了会触发下次枯萎时间 )
		elseif opt == 4 then			
			local ret,ret2 = GD_GainsProc(sid,othersid,index)
			exps = ret2 or 0
			if ret == nil or ret < 0 then	-- 出现异常或被狗咬
				return ret
			else
				check = ret
			end
		end
	end
	
	-- 记录操作(只记录别人的偷菜操作)
	if check == 0 and opt == 4 and othersid ~= nil then
		local seedID = pGardenData[index][1]
		GD_RecordOpt(sid,othersid,opt,seedID)
	end
	--look('check:' .. check)
	-- 对于一键 失败的不能有提示
	if bFast then
		if check == 0 then
			SendLuaMsg( 0, { ids = GD_Opt, idx = index, opt = opt, res = check, dt = pGardenData[index], pid = playerid, exps = exps }, 9 )
		end
	else		
		SendLuaMsg( 0, { ids = GD_Opt, idx = index, opt = opt, res = check, dt = pGardenData[index], pid = playerid, exps = exps }, 9 )
	end
	
	return check
end

-- 偷菜被抓逃跑
-- function GD_Escape(sid,othersid,index)
	-- if othersid == nil then return end
	-- local playerid = othersid or sid
	-- local pGardenData = GetGardenData_Interf(playerid)
	-- if pGardenData == nil then return end
	-- local pSelfData = GetGardenData_Interf(sid)
	-- if pSelfData == nil then return end
	-- if pSelfData.bite == nil then
		-- --look("没被咬跑个毛")
		-- return
	-- end
	-- -- 选择逃跑的时候可能被偷完 或者 被收获
	-- if pGardenData[index] == nil then
		-- --look("菜地被收获了")
		-- SendLuaMsg( 0, { ids = GD_Opt, idx = index, opt = 4, res = 94, pid = playerid }, 9 )
		-- pSelfData.bite = nil
		-- return
	-- end
	
	-- local seedID = pGardenData[index][1]
	-- local stype = Garden_Conf.seeds[seedID].stype
	-- local color = Garden_Conf.seeds[seedID].color
	-- -- 判断是否已经偷完了			
	-- local stcount = 5			-- 取可偷次数(现固定5次)
	-- local Paths = Manor_PetConf[pSelfData.bite].paths or 2		-- 没配就默认2条路
	-- local rd = math.random(1,10000)
	-- -- 偷完了就当被狗咬处理
	-- if (pGardenData[index][3] or 0) >= stcount or rd <= rint(10000 / Paths) then
		-- --look("恭喜你，被狗咬了，还可以继续偷哦，亲~")
		-- local pGardenTemp = GetExtraTemp_Garden(playerid)
		-- if pGardenTemp == nil then return end
		-- if pGardenTemp[index] and pGardenTemp[index][sid] then
			-- pGardenTemp[index][sid] = nil		-- 重置偷取列表 可以继续偷
		-- end
		-- local money = math.random(500,1000)
		-- CheckCostAll(0,money)					-- 扣玩家身上的铜钱钱 有多少扣多少 扣完为止
		-- GD_SetMoneyTree(othersid,1,money)		-- 对方加钱、加到摇钱树上
		-- GD_RecordOpt(sid,othersid,5,money)
		-- SendLuaMsg( 0, { ids = GD_Opt, idx = index, opt = 4, res = -1, money = money, pid = playerid }, 9 )
	-- else
		-- local gains = rint( pGardenData[index][7] * percent )
		-- GD_DoAward(sid,othersid,stype,gains,pGardenData[index][9])
		-- --look("偷取成功:" .. pGardenData[index][3])
		-- pGardenData[index][3] = pGardenData[index][3] + 1
		-- -- 如果偷完了 触发枯萎
		-- local now = GetServerTime()
		-- if pGardenData[index][3] == stcount then
			-- pGardenData[index][5] = now + 8 * 60 * 60
			-- --look("触发枯萎:" .. index)
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

-- 菜园收获
-- 如果前台能判断后台可不用做是否是自己菜园的判断
-- iType 0-- 一键收获/偷取 1-- 一键打理  2-- 一键种植
function GD_FastOpt(sid,othersid,iType,param)
	local playerid = othersid or sid
	local pGardenData = GetGardenData_Interf(playerid)
	if pGardenData == nil then return end
	local opens = pGardenData.opens or BaseOpenNum
	local ret = nil
	if iType == 0 then			-- 一键收获/偷取 
		for index = 1, opens do
			if pGardenData[index] ~= nil and pGardenData[index][1] ~= nil then
				ret = GD_Operations(sid,othersid,index,4,true)
				-- 被狗咬 中断
				if ret ~= nil and ret == -1 then
					break
				end
			end
		end
	elseif iType == 1 then		-- 一键打理
		for index = 1, opens do
			if pGardenData[index] ~= nil and pGardenData[index][1] ~= nil then
				for i = 1, 3 do
					ret = GD_Operations(sid,othersid,index,i,true)
					-- 因为可操作类型是互斥的 所以为空或者某种操作成功就可以不用循环了
					if ret == nil or ret == 0 then
						break
					end
				end
			end
		end
	elseif iType == 2 then		-- 一键种植
		if othersid or param == nil or type(param) ~= type({}) or #param ~= 5 then return end
		--look(opens)
		for index = 1, opens do
			if pGardenData[index] == nil then		-- 先找到空地
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

-- 获取土地等级加成
function GD_GetLandAdd(sid)
	local pGardenData = GetGardenData_Interf(sid)
	if pGardenData == nil then return end
	local lv = pGardenData.land or 1
	local conf = land_conf[lv]
	if conf == nil or type(conf) ~= type({}) then return end
	return conf[1]
end

-- 提升土地等级
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
		if not CheckCost( sid , yb , 0 , 1, "提升土地等级") then
			SendLuaMsg( 0, { ids = GD_Land, res = 2 }, 9 )
			return
		end
	elseif iType == 1 then
		local bdyb = GetPlayerPoints(sid,3) or 0
		if bdyb < yb*10 then
			SendLuaMsg( 0, { ids = GD_Land, res = 3 }, 9 )	
			return
		end
		AddPlayerPoints(sid,3, -(yb*10), nil,"提升土地等级",true)
	else
		return
	end
	pGardenData.land = (pGardenData.land or 1) + 1
	SendLuaMsg( 0, { ids = GD_Land, res = 0, land = pGardenData.land }, 9 )
end

-- 登陆将亲密度赋值给土地等级
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