--[[
file:	Faction_Treasure.lua
desc:	���ᱦ
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
local TreasureMaxTime = 3 --ÿ�նᱦ����
local TreasureLimit = 60*15 --ÿ��ѹ�����
--[[
�۱������ݽṹ
Treasure = {
	p = {[1] = Sid,[2] = ������,[3]���ֿ�ʼ��ʱʱ��,[4] = ���ֲ�������,[4]}
}
]]--

--��ȡ�����ճ��ᱦ��¼���ݣ�ÿ����Ҫ���) {����+���������ջ�ʤ��¼}
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

--��ȡ�ᱦ����
local function GetFactionTreasureData(fid)
	local fdata = GetFactionData(fid)
	if(fdata == nil)then return end
	
	if(fdata.Treasure == nil) then
		fdata.Treasure = {}
	end
	
	return fdata.Treasure
end

--��ȡ������ѹ������
local function GetFPlayerTData(sid)
	local data = GetFacData_Interf(sid)
	if(data == nil)then
		look(debug.traceback(),1)
		return
	end
	if(data~=nil and data.tcd == nil)then data.tcd = {} end
	return data.tcd
end

--��ǰ�Ƿ�ɶᱦ curdt.year,curdt.month,curdt.day,curdat.hour,curdat.min,curdat.sec
local function isTreasureStart(now)
	local curdt = os_date( "*t", now)
	return (curdt.hour>=TreasureStart and 1) or 0
end

--��ȡ��������
local function getTreasureRate(rand)
	local rand1,rand2,rand3
	local rate = 1 --����
	rand1 = math_floor(rand/100)
	rand2 = math_floor(rand/10)%10
	rand3 = rand%10
	if(rand1 == rand2 and rand1 == rand3)then --3��
		if(rand1 == 6)then
			rate = 5
		else
			rate = 4
		end
	else
		if(rand1 == rand2 or rand1 == rand3 or rand2 == rand3)then --2��
			rate = 2
		else
			local total = rand1+rand2+rand3
			if(total%3 == 0)then --˳��
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

--��ȡ���ᱦʱ��
function GetTreasureTime(sid)	
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0--��᲻����
	end
	--��ȡ�۱���ȼ�
	local lv = CI_GetFactionInfo(nil,9)
	if(lv == 0 or lv == nil)then return false,1 end --��ȡ�۱�������ʧ��
	
	local fname = CI_GetFactionInfo(nil,1)
	if(fname == nil or fname == 0)then return false,0 end --��ȡ�������ʧ��
	
	local Treasure = GetFactionTreasureData(fid)
	if Treasure == nil then
		return false,2 --��ȡ�ᱦ����ʧ��
	end
	
	local fTd = GetFactionDayData(fid)	
	if(fTd == nil)then return false,2 end --��ȡ�ᱦ����ʧ��
	
	local pTd = GetFPlayerTData(sid) --�ᱦ����
	if(pTd == nil)then return false,3 end --��ȡ���˶ᱦ����ʧ��
	
	local curdt = os_date( "*t", now)
	local dtVal = curdt.year*10000 + curdt.month * 100 + curdt.day
	if(pTd.fid ~= fid)then --������
		pTd.fid = fid
		pTd.sign = nil
		pTd.rnd = nil
	end
	local tcData = pTd.tc --���նᱦ����
	if(tcData ~= nil and math_floor(tcData/100) ~= dtVal)then
		pTd.tc = nil
		pTd.sign = nil
		pTd.rnd = nil
		tcData = nil
	end
	
	--look('------------------------')
	--look(pTd.tc)
	
	local count = 0 --�ᱦ����
	local tcount = 0 --���ֲ�������
	
	local Winner
	local isToday
	local issend = true
	if(Treasure.p~=nil)then --������Ͷע��δ�����ʼ�
		local now = GetServerTime()
		if((now - Treasure.p[3])>=TreasureLimit)then --�������			
			Winner = Treasure.p[1]
			local pTdWin = Winner == sid and pTd or GetFPlayerTData(Winner)
			if(dtVal == math_floor(fTd[1]/100))then --���Ϊ���죬���¼������ᱦ��¼�ΪʲôҪ��¼��
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
				fTd[2][#fTd[2]+1] = {Winner,Treasure.p[2],fTd[1]} --sid,����������
				fTd[1] = fTd[1] + 1 --��ǰ��������
			end
		end
	end
	
	if(Winner~=nil)then --�˴����ʼ�
		if(EnActiveConf~=nil and issend == true)then
			if(lv~=nil and lv~=0 and TreasureGoodID[lv]~=nil)then
				local goodRate = getTreasureRate(Treasure.p[2])
				SendSystemMail(Winner,EnActiveConf,1,2,{goodRate},{[3] = {{TreasureGoodID[lv],goodRate,1}}})
			end
		end
		if(isToday)then --����ǵ��죬��㲥
			FactionRPC(fid,'FF_TreasureMsg',1,Treasure.p[1],Treasure.p[2],fTd[1],count,isTreasureStart(now))
		end
		Treasure.p = nil
	elseif(Treasure.p~=nil)then
		tcount = Treasure.p[4] --��������
	end
	
	if(tcData~=nil)then
		count = tcData%100
	end
	
	--Treasure,count,isTreasureStart(now),ftcd,fTd[4],fTd[1]
	--�ᱦ���ݡ���ǰ�������ᱦ��ʼ��ʶ�����˶ᱦ��ʶ����ǰ���ᱦ��ʤ��¼����ǰ��
	SendLuaMsg( 0, { ids = Faction_Treasure,data = Treasure,times = count,isstart = isTreasureStart(now),ftcd = pTd,list = fTd[2],fidx = fTd[1]}, 9 )
end
--����ʱ���ж�����
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
				local pTd = GetFPlayerTData(Winner) --�ᱦ����
				if(pTd ~= nil)then --��ȡ���˶ᱦ����
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
				fTd[2][#fTd[2]+1] = {Winner,Treasure.p[2],fTd[1]} --sid,����������
				fTd[1] = fTd[1] + 1 --��ǰ��������
				
				if(pTd ~=nil and pTd.tc~=nil)then
					count = pTd.tc%100
				end
			end
		end
		if(Winner~=nil)then --�˴����ʼ�
			if(issend == true and EnActiveConf~=nil)then
				local lv = CI_GetFactionInfo(fid,9) --�۱���ȼ�
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

--�ᱦ����
function SendTreasure(sid)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --��᲻����
	end
	
	--��ȡ�۱���ȼ�
	local lv = CI_GetFactionInfo(nil,9)
	if(lv == 0 or lv == nil)then return false,1 end --��ȡ�۱�������ʧ��
	
	local fname = CI_GetFactionInfo(nil,1)
	if(fname == nil or fname == 0)then return false,0 end --��ȡ�������ʧ��
	
	local Treasure = GetFactionTreasureData(fid)
	if Treasure == nil then
		return false,2 --��ȡ�ᱦ����ʧ��
	end
	 
	local now = GetServerTime()
	local isStart = isTreasureStart(now)
	if(isStart == 0)then return false,4 end --�ᱦ��δ��ʼ,��Ϣ��
	
	local count = 0
	local fTd = GetFactionDayData(fid)
	if(fTd == nil)then return false,3 end --��ȡ�ᱦ����ʧ��
	local curSign = fTd[1] --���ֵı�ʶID
	
	local pTd = GetFPlayerTData(sid) --�ᱦ����
	if(pTd == nil)then return false,3 end --��ȡ���˶ᱦ����ʧ��
	
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

	if(count>=TreasureMaxTime)then return false,5 end --���նᱦ��������
	
	--pTd.fid = fid
	--pTd.sign = nil
	
	if(pTd.sign~=nil and pTd.fid~=nil and pTd.sign == curSign and pTd.fid == fid)then
		return false,7 --������Ͷ���ˣ���
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
	if(total == 18)then --ͨ��
		pTd.tc = pTd.tc + 1
		if(fTd[2] == nil)then fTd[2] = {} end
		fTd[2][#fTd[2]+1] = {sid,rand,fTd[1]} --sid,����������
		fTd[1] = curSign + 1 --��ǰ��������
		
		if(EnActiveConf~=nil)then
			local lv = CI_GetFactionInfo(fid,9) --�۱���ȼ�
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
		FactionRPC(fid,'FF_TreasureMsg',0,sid,rand,fTd[1],nil,1,now) --��һ��Ͷ���ˣ���ûͶ�����ӣ�
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
			FactionRPC(fid,'FF_TreasureMsg',0,sid,rand,fTd[1],lossID,p[4],p[3]) --���ID���������������������������������ˣ���������
		else
			FactionRPC(fid,'FF_TreasureMsg',0,sid,rand,fTd[1],nil,p[4],p[3]) --���ID���������������������������������ˣ���������
		end
	end
	return true
end
