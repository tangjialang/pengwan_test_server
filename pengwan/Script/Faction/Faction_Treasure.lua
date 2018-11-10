--[[
file:	Faction_Treasure.lua
desc:	帮会夺宝
update:2013-7-1
refix:	done by xy
]]--
--------------------------------------------------------------------------
--include:
local Faction_Treasure = msgh_s2c_def[7][13]
local GetFactionData = GetFactionData
local math_floor = math.floor
local math_random = math.random
local os_date = os.date
local CI_GetPlayerData = CI_GetPlayerData
local CI_GetFactionInfo = CI_GetFactionInfo
local GetServerTime = GetServerTime
local FactionRPC = FactionRPC
local SendSystemMail = SendSystemMail
local SendLuaMsg = SendLuaMsg
local EnActiveConf = MailConfig.FactionDB
local SetEvent = SetEvent
local uv_TimesTypeTb = TimesTypeTb
local CheckTimes = CheckTimes
--------------------------------------------------------------------------
-- data:
local TreasureStart = 8
local TreasureGoodID = {1086,1087,1088,1089,1090,1091,1092,1093,1094,1095}
local TreasureMaxTime = 3 --每日夺宝次数
local TreasureLimit = 60*15 --每日压宝间隔
--[[
聚宝盆数据结构
Treasure = {
	p = {[1] = Sid,[2] = 骰子数,[3]本轮开始计时时间,[4] = 本轮参与人数,[4]}
}
]]--

--获取帮会的日常夺宝记录数据（每日需要清除) {日期+轮数，本日获胜记录}
local function GetFactionDayData(fid)
	local fdata = GetFactionData(fid)
	if(fdata == nil)then return end
	
	local curdt = os_date( "*t", now)
	local dtVal = curdt.year*1000000 + curdt.month * 10000 + curdt.day*100
	if(dbMgr.faction.data[fid].day ~= nil)then
		if(math_floor(dtVal/100)~=math_floor(dbMgr.faction.data[fid].day[1]/100))then
			dbMgr.faction.data[fid].day[1] = dtVal+1
			dbMgr.faction.data[fid].day[2] = nil 
		end
	else
		dbMgr.faction.data[fid].day = {dtVal+1}
	end
	
	return dbMgr.faction.data[fid].day
end

--获取夺宝数据
local function GetFactionTreasureData(fid)
	local fdata = GetFactionData(fid)
	if(fdata == nil)then return end
	
	if(fdata.Treasure == nil) then
		fdata.Treasure = {}
	end
	
	return fdata.Treasure
end

--获取帮会个人压宝数据
local function GetFPlayerTData(sid)
	local data = GetFacData_Interf(sid)
	if(data == nil)then
		look(debug.traceback(),1)
		return
	end
	if(data~=nil and data.tcd == nil)then data.tcd = {} end
	return data.tcd
end

--当前是否可夺宝 curdt.year,curdt.month,curdt.day,curdat.hour,curdat.min,curdat.sec
local function isTreasureStart(now)
	local curdt = os_date( "*t", now)
	return (curdt.hour>=TreasureStart and 1) or 0
end

--获取奖励倍数
local function getTreasureRate(rand)
	local rand1,rand2,rand3
	local rate = 1 --倍数
	rand1 = math_floor(rand/100)
	rand2 = math_floor(rand/10)%10
	rand3 = rand%10
	if(rand1 == rand2 and rand1 == rand3)then --3条
		if(rand1 == 6)then
			rate = 5
		else
			rate = 4
		end
	else
		if(rand1 == rand2 or rand1 == rand3 or rand2 == rand3)then --2条
			rate = 2
		else
			local total = rand1+rand2+rand3
			if(total%3 == 0)then --顺子
				local theMin,theMax = rand1,rand1
				if(theMin>rand2)then theMin = rand2 end
				if(theMin>rand3)then theMin = rand3 end
				
				if(theMax<rand2)then theMax = rand2 end
				if(theMax<rand3)then theMax = rand3 end
				
				if((theMax-theMin) == 2)then rate = 3 end
			end
		end
	end
	return rate
end

--获取帮会夺宝时间
function GetTreasureTime(sid)	
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0--帮会不存在
	end
	--获取聚宝盆等级
	local lv = CI_GetFactionInfo(nil,9)
	if(lv == 0 or lv == nil)then return false,1 end --获取聚宝盆数据失败
	
	local fname = CI_GetFactionInfo(nil,1)
	if(fname == nil or fname == 0)then return false,0 end --获取帮会名字失败
	
	local Treasure = GetFactionTreasureData(fid)
	if Treasure == nil then
		return false,2 --获取夺宝数据失败
	end
	
	local fTd = GetFactionDayData(fid)	
	if(fTd == nil)then return false,2 end --获取夺宝数据失败
	
	local pTd = GetFPlayerTData(sid) --夺宝次数
	if(pTd == nil)then return false,3 end --获取个人夺宝数据失败
	
	local curdt = os_date( "*t", now)
	local dtVal = curdt.year*10000 + curdt.month * 100 + curdt.day
	if(pTd.fid ~= fid)then --换帮了
		pTd.fid = fid
		pTd.sign = nil
		pTd.rnd = nil
	end
	local tcData = pTd.tc --当日夺宝次数
	if(tcData ~= nil and math_floor(tcData/100) ~= dtVal)then
		pTd.tc = nil
		pTd.sign = nil
		pTd.rnd = nil
		tcData = nil
	end
	
	--look('------------------------')
	--look(pTd.tc)
	
	local count = 0 --夺宝次数
	local tcount = 0 --本轮参与人数
	
	local Winner
	local isToday
	local issend = true
	if(Treasure.p~=nil)then --已有人投注且未发送邮件
		local now = GetServerTime()
		if((now - Treasure.p[3])>=TreasureLimit)then --出结果了			
			Winner = Treasure.p[1]
			local pTdWin = Winner == sid and pTd or GetFPlayerTData(Winner)
			if(dtVal == math_floor(fTd[1]/100))then --如果为当天，则记录到当天夺宝记录里（为什么要记录）
				isToday = 1
				if(pTdWin ~= nil)then
					if(pTdWin.tc==nil)then
						pTdWin.tc = dtVal * 100 + 1
					else
						if(math_floor(pTdWin.tc/100) ~= dtVal)then
							pTdWin.tc = dtVal * 100
							pTdWin.sign = nil
							pTdWin.rnd = nil
						end
						local count1 = pTdWin.tc%100
						if(count1>=TreasureMaxTime)then
							issend = false
						else
							pTdWin.tc = pTdWin.tc + 1
						end
						--pTdWin.tc = pTd.tc + 1
					end
				end
				if(Winner == sid)then
					tcData = pTdWin.tc
				end
				
				if(fTd[2] == nil)then fTd[2] = {} end
				fTd[2][#fTd[2]+1] = {Winner,Treasure.p[2],fTd[1]} --sid,点数、轮数
				fTd[1] = fTd[1] + 1 --当前轮数更新
			end
		end
	end
	
	if(Winner~=nil)then --此处发邮件
		if(EnActiveConf~=nil and issend == true)then
			if(lv~=nil and lv~=0 and TreasureGoodID[lv]~=nil)then
				local goodRate = getTreasureRate(Treasure.p[2])
				SendSystemMail(Winner,EnActiveConf,1,2,{goodRate},{[3] = {{TreasureGoodID[lv],goodRate,1}}})
			end
		end
		if(isToday)then --如果是当天，则广播
			FactionRPC(fid,'FF_TreasureMsg',1,Treasure.p[1],Treasure.p[2],fTd[1],count,isTreasureStart(now))
		end
		Treasure.p = nil
	elseif(Treasure.p~=nil)then
		tcount = Treasure.p[4] --参与人数
	end
	
	if(tcData~=nil)then
		count = tcData%100
	end
	
	--Treasure,count,isTreasureStart(now),ftcd,fTd[4],fTd[1]
	--夺宝数据、当前次数、夺宝开始标识、个人夺宝标识、当前帮会夺宝获胜记录、当前轮
	SendLuaMsg( 0, { ids = Faction_Treasure,data = Treasure,times = count,isstart = isTreasureStart(now),ftcd = pTd,list = fTd[2],fidx = fTd[1]}, 9 )
end
--倒计时到判断正负
function onTreasureTime(fid)
	local Treasure = GetFactionTreasureData(fid)
	if(Treasure == null)then return end
	local count = 0
	local now
	local issend = true
	if(Treasure.p~=nil)then
		now = GetServerTime()
		local Winner
		local fTd
		if((now - Treasure.p[3])>=TreasureLimit)then
			Winner = Treasure.p[1]
			fTd = GetFactionDayData(fid)
			if(fTd ~=nil)then
				local pTd = GetFPlayerTData(Winner) --夺宝次数
				if(pTd ~= nil)then --获取个人夺宝数据
					local curdt = os_date( "*t", now)
					local dtVal = curdt.year*10000 + curdt.month * 100 + curdt.day
					if(pTd.tc==nil)then
						pTd.tc = dtVal * 100 + 1
					else
						local count = pTd.tc%100
						if(count>=TreasureMaxTime)then
							issend = false
						else
							pTd.tc = pTd.tc + 1
						end
					end
				end

				if(fTd[2] == nil)then fTd[2] = {} end
				local fLen = #fTd[2]
				if(fLen>20)then
					for i=(fLen - 20),1 do
						if(fTd[2][i]~=nil and type(fTd[2][i])==type({}))then
							fTd[2][i] = 0
						end
					end
				end
				fTd[2][#fTd[2]+1] = {Winner,Treasure.p[2],fTd[1]} --sid,点数、轮数
				fTd[1] = fTd[1] + 1 --当前轮数更新
				
				if(pTd ~=nil and pTd.tc~=nil)then
					count = pTd.tc%100
				end
			end
		end
		if(Winner~=nil)then --此处发邮件
			if(issend == true and EnActiveConf~=nil)then
				local lv = CI_GetFactionInfo(fid,9) --聚宝盆等级
				if(lv~=nil and lv~=0 and TreasureGoodID[lv]~=nil)then
					local goodRate = getTreasureRate(Treasure.p[2])
					SendSystemMail(Winner,EnActiveConf,1,2,{goodRate},{[3] = {{TreasureGoodID[lv],goodRate,1}}})
				end
			end
			FactionRPC(fid,'FF_TreasureMsg',1,Treasure.p[1],Treasure.p[2],fTd[1],count,isTreasureStart(now))
			Treasure.p = nil
		end
	end
end

--夺宝发送
function SendTreasure(sid)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --帮会不存在
	end
	
	--获取聚宝盆等级
	local lv = CI_GetFactionInfo(nil,9)
	if(lv == 0 or lv == nil)then return false,1 end --获取聚宝盆数据失败
	
	local fname = CI_GetFactionInfo(nil,1)
	if(fname == nil or fname == 0)then return false,0 end --获取帮会名字失败
	
	local Treasure = GetFactionTreasureData(fid)
	if Treasure == nil then
		return false,2 --获取夺宝数据失败
	end
	 
	local now = GetServerTime()
	local isStart = isTreasureStart(now)
	if(isStart == 0)then return false,4 end --夺宝尚未开始,休息中
	
	local count = 0
	local fTd = GetFactionDayData(fid)
	if(fTd == nil)then return false,3 end --获取夺宝次数失败
	local curSign = fTd[1] --本轮的标识ID
	
	local pTd = GetFPlayerTData(sid) --夺宝次数
	if(pTd == nil)then return false,3 end --获取个人夺宝数据失败
	
	if(pTd.tc ~= nil)then
		if(math_floor(pTd.tc/100) ~= math_floor(curSign/100))then
			count = 0
			pTd.tc = math_floor(curSign/100) * 100
		else
			count = pTd.tc%100
		end
	else
		pTd.tc = math_floor(curSign/100) * 100
		count = 0
	end

	if(count>=TreasureMaxTime)then return false,5 end --今日夺宝次数已满
	
	--pTd.fid = fid
	--pTd.sign = nil
	
	if(pTd.sign~=nil and pTd.fid~=nil and pTd.sign == curSign and pTd.fid == fid)then
		return false,7 --本轮已投过了，你
	else
		pTd.sign = curSign
		pTd.fid = fid
	end
	
	local rand1,rand2,rand3
	local rand
	rand1 = math_random(1,6)
	rand2 = math_random(1,6)
	rand3 = math_random(1,6)
	--rand1,rand2,rand3 = 6,6,6
	rand = rand1*100+rand2*10+rand3
	total = rand1 + rand2 +rand3
	CheckTimes(sid,uv_TimesTypeTb.FactionDB_Time,1,-1)
	local now = GetServerTime()
	if(total == 18)then --通吃
		pTd.tc = pTd.tc + 1
		if(fTd[2] == nil)then fTd[2] = {} end
		fTd[2][#fTd[2]+1] = {sid,rand,fTd[1]} --sid,点数、轮数
		fTd[1] = curSign + 1 --当前轮数更新
		
		if(EnActiveConf~=nil)then
			local lv = CI_GetFactionInfo(fid,9) --聚宝盆等级
			if(lv~=nil and lv~=0 and TreasureGoodID[lv]~=nil)then
				local goodRate = getTreasureRate(rand)
				--look('TreasureGoodID[lv],goodRate'..','..TreasureGoodID[lv]..','..goodRate)
				SendSystemMail(sid,EnActiveConf,1,2,{goodRate},{[3] = {{TreasureGoodID[lv],goodRate,1}}})
			end
		end
		
		FactionRPC(fid,'FF_TreasureMsg',1,sid,rand,fTd[1],count,isTreasureStart(now))
		Treasure.p = nil
		return true
	end
	
	pTd.rnd = rand
	
	if(Treasure.p ==nil)then
		Treasure.p = {sid,rand,now,1}
		SetEvent(TreasureLimit, nil, 'onTreasureTime', fid )
		FactionRPC(fid,'FF_TreasureMsg',0,sid,rand,fTd[1],nil,1,now) --第一个投的人（且没投出豹子）
	else
		local p = Treasure.p
		rand1 = math_floor(p[2]/100)%10
		rand2 = math_floor(p[2]/10)%10
		rand3 = p[2]%10
		p[4] = p[4]+1
		if((rand1 + rand2 +rand3)<total)then
			local lossID = p[1]
			p[1] = sid
			p[2] = rand
			FactionRPC(fid,'FF_TreasureMsg',0,sid,rand,fTd[1],lossID,p[4],p[3]) --玩家ID，丢出的骰子数，本轮轮数，超过的人，参与人数
		else
			FactionRPC(fid,'FF_TreasureMsg',0,sid,rand,fTd[1],nil,p[4],p[3]) --玩家ID，丢出的骰子数，本轮轮数，超过的人，参与人数
		end
	end
	return true
end
