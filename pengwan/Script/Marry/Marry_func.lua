--[[
file:Marry_func.lua
name:结婚
]]--

local MAR_INIT = msgh_s2c_def[21][1]
local MarryResult = msgh_s2c_def[21][2]
local MarryReserve = msgh_s2c_def[21][3]
local WeddingNotice = msgh_s2c_def[21][4]
local ReserveList = msgh_s2c_def[21][5]


local EatFeast = msgh_s2c_def[21][9]
local feastdata = msgh_s2c_def[21][10]
local divorceVerify = msgh_s2c_def[21][11]
local DivorceRes = msgh_s2c_def[21][12]
local ForceVerify = msgh_s2c_def[21][13]
local Marryring = msgh_s2c_def[21][14]

local MarryBegin = msgh_s2c_def[21][17]
local SingleData = msgh_s2c_def[21][18]
local MarryTitle = msgh_s2c_def[21][19]

local Tran_Wait	= msgh_s2c_def[3][3]

local StringReplace = string.replace_ex
local marrymailconf = MailConfig.MarryNotice
local look = look
local common_time = require('Script.common.time_cnt')
local subTimeThisDay = common_time.subTimeThisDay
local isPassedThisDay = common_time.isPassedThisDay
local pos_conf_m = require('Script.active.random_pos_conf')
local rand_pos_config = pos_conf_m.rand_pos_config
local define = require('Script.cext.define')
local ProBarType = define.ProBarType
local db_module = require('Script.cext.dbrpc')
local db_marry_cost_record = db_module.db_marry_cost_record
local db_marry_cost_clear = db_module.db_marry_cost_clear

function GetPlayerMarryData(playerid)    --获取玩家结婚数据
	local marrydata=GI_GetPlayerData( playerid , 'marr' , 100 )
	if marrydata == nil then return end
		-- [1] = 0,			-- 是否办过宴席，0-未办   1-已办
		-- [2] = {},		-- 吃婚宴数据记录
		-- [3] = {},		-- 结婚属性
		-- [4] = couple,	-- 配偶sid
		-- [5] = {},		-- 结婚淬炼属性(当前等级,进度)
	--look(tostring(marrydata))
	
	if not marrydata[5] then 
		marrydata[5] = {1,0}
	end
	
	return marrydata
end

function GetCoupleSID(mplayerid)
	if mplayerid == nil then return end
	local mpMarryData = GetPlayerMarryData(mplayerid)
	if mpMarryData == nil then return end
	return mpMarryData[4]
end

function SetCouple(mplayerid,fplayerid)
	if mplayerid == nil or fplayerid == nil then return end
	local fName = CI_GetPlayerData(69,2,mplayerid)
	if type(fName) ~= type('') then
		return
	end
	local mpMarryData = GetPlayerMarryData(mplayerid)
	if mpMarryData == nil then return end
	mpMarryData[4] = fplayerid
end

function DelCouple(mplayerid)
	local mpMarryData = GetPlayerMarryData(mplayerid)
	if mpMarryData == nil then return end
	mpMarryData[4] = nil
end

-- 婚宴预约数据
function GetFeastData()
	local wcustom = GetWorldCustomDB()
	if nil == wcustom then return end
	if nil == wcustom.feastData then 
		wcustom.feastData = {		
		}
	end
	return wcustom.feastData
end

-- 未婚列表
function GetSingleData()
	local wcustom = GetWorldCustomDB()
	if nil == wcustom then return end
	if nil == wcustom.singleData then 
		wcustom.singleData = {
			[1] = {},		-- 单身女性
			[2] = {},		-- 单身男性
		}
	end
	return wcustom.singleData
end

-- 更新未婚列表(上线或等级提升调用)
function PushSigleList(sid,bCheck)
	--look('PushSigleList')
	if sid == nil then return end
	local sData = GetSingleData()
	if sData == nil then return end
	local lv = CI_GetPlayerData(1,2,sid)
	if bCheck and lv < 40 then 
		return
	end
	local fName = CI_GetPlayerData(69,2,sid)
	if type(fName) == type('') then
		return
	end
	local sex = CI_GetPlayerData(11,2,sid)
	if sData[sex+1] == nil then return end
	-- 先判断是否已经加入过
	for k, v in ipairs(sData[sex+1]) do
		if v[1] == sid then
			return
		end
	end
	
	local mName = CI_GetPlayerData(5,2,sid)
	local headID = CI_GetPlayerData(70,2,sid)
	local vipType = GI_GetVIPType(sid) or 0
	local fight = CI_GetPlayerData(62,2,sid)
	lv = math.max(lv,40)
	table.push(sData[sex+1],{sid,lv,sex,headID,vipType,fight,mName},30)
	-- look(sData,1)
end

-- 移除未婚列表(下线调用,结婚/变性时也可以调用)
function RemoveSigleList(sid)
	--look('RemoveSigleList')
	if sid == nil then return end
	local sData = GetSingleData()
	if sData == nil then return end
	if type(sData[1]) == type({}) then
		for k, v in ipairs(sData[1]) do
			if v[1] == sid then
				table.remove(sData[1],k)
				break
			end
		end
	end
	if type(sData[2]) == type({}) then
		for k, v in ipairs(sData[2]) do
			if v[1] == sid then
				table.remove(sData[2],k)
				break
			end
		end
	end
end

-- 发送未婚列表
function SendSingleData(sid)
	if sid == nil then return end
	local sData = GetSingleData()
	if sData == nil then return end
	local lv = CI_GetPlayerData(1,2,sid)
	-- if lv < 40 then 
		-- return
	-- end
	local fName = CI_GetPlayerData(69,2,sid)
	if type(fName) == type('') then
		return
	end

	local sex = CI_GetPlayerData(11,2,sid)
	if sex == 0 then
		SendLuaMsg(0,{ids = SingleData, dt = sData[2]},9)
	elseif sex == 1 then
		SendLuaMsg(0,{ids = SingleData, dt = sData[1]},9)
	end
end

-- 发送结婚数据
function SendMarryData(sid,othername)
	local pMarryData = GetPlayerMarryData(sid)
	if othername ~= nil then
		local othersid = GetPlayer(othername,false)
		if othersid == nil then
			TipCenter(GetStringMsg(683))
			return
		end
		local fName = CI_GetPlayerData(othersid,69)		
		local degree =  GetFriendDegree(fName,othersid)	
		pMarryData = GetPlayerMarryData(othersid)
		if pMarryData == nil then return end
		SendLuaMsg(0,{ids = MarryData, mData = pMarryData,fName = (fName or ""),degree = degree},9)
	else
		if pMarryData == nil then return end
		SendLuaMsg(0,{ids = MarryData, mData = pMarryData},9)
	end	
end

-- 发送当前婚宴的信息
function SendFeastData(sid)
	local FeastData = GetFeastData()
	if FeastData == nil or FeastData.CurFeast == nil then
		return
	end
	local cf = FeastData.CurFeast
	local pMarryData = GetPlayerMarryData(sid)
	if pMarryData == nil then return end
	local ec = 0
	if pMarryData[2] and pMarryData[2][cf] then
		ec = pMarryData[2][cf]
	end
	SendLuaMsg(0,{ids = feastdata, fData = FeastData[cf], eCount = ec},9)
end

-- 申请结婚
function Marry_Init(mplayerid,fplayerid,content)
	if mplayerid == nil or fplayerid == nil then return end
	-- 1、判断等级
	if CI_GetPlayerData(1) < 40 then
		SendLuaMsg(0,{ids = MAR_INIT, res = 1},9)		-- 等级不够
		return
	end
	-- 2、对方是否在线
	if not IsPlayerOnline(fplayerid) then
		SendLuaMsg(0,{ids = MAR_INIT, res = 2},9)		-- 对方不在线
		return
	end
	-- 3、自己是否已婚
	if CI_GetPlayerData(69) ~= nil then
		SendLuaMsg(0,{ids = MAR_INIT, res = 3},9)		-- 自己已婚
		return
	end
	-- 4、对方是否已婚
	if CI_GetPlayerData(69,2,fplayerid) ~= nil then
		SendLuaMsg(0,{ids = MAR_INIT, res = 4},9)		-- 对方已婚
		return
	end
	-- 5、判断亲密度
	local mName = CI_GetPlayerData(5,2,mplayerid)
	local fName = CI_GetPlayerData(5,2,fplayerid)
	local mDegree = GetFriendDegree(fplayerid,mplayerid) or 0
	local fDegree = GetFriendDegree(mplayerid,fplayerid) or 0
	if mDegree < 99 then
		SendLuaMsg(0,{ids = MAR_INIT, res = 5},9)			-- 双方亲密度不足
		return
	end
	if fDegree < 0 then
		SendLuaMsg(0,{ids = MAR_INIT, res = 9},9)			-- 对方不是好友
		return
	end
	-- 6、是否是异性
	local mSex = CI_GetPlayerData(11,2,mplayerid)
	local fSex = CI_GetPlayerData(11,2,fplayerid)
	if mSex == fSex then
		SendLuaMsg(0,{ids = MAR_INIT, res = 6},9)			-- 同性恋就算了吧
		return
	end
	-- 7、对方等级
	if CI_GetPlayerData(1,2,fplayerid) < 40 then
		SendLuaMsg(0,{ids = MAR_INIT, res = 8},9)		-- 对方等级不够
		return
	end
	if type(content) == type('') then
		if not CheckCost(mplayerid,18,0,1,'求婚宣言') then
			SendLuaMsg(0,{ids = MAR_INIT, res = 7},9)		-- 元宝不足
			return
		end
		BroadcastRPC('Marry_Promise',mName,fName,content)
	end
	
	-- 通知对方
	SendLuaMsg(fplayerid,{ids = MAR_INIT, mName = mName},10)
	SendLuaMsg(mplayerid,{ids = MAR_INIT, res = 0},10)
end

-- 对方确认 
-- result: [0]拒绝 [1]同意
function MarryConfirmResult(fplayerid,mplayerid,result)
	if fplayerid == nil or mplayerid == nil or result == nil then return end
	-- 1、对方是否在线
	if not IsPlayerOnline(mplayerid) then 
		SendLuaMsg(0,{ids = MarryResult,res = 4},9)       -- 对方不在线
		return 
	end		
	-- 2、判断亲密度
	local mName = CI_GetPlayerData(5,2,mplayerid)
	local fName = CI_GetPlayerData(5,2,fplayerid)
	local mDegree = GetFriendDegree(fplayerid,mplayerid) or 0
	local fDegree = GetFriendDegree(mplayerid,fplayerid) or 0
	if mDegree < 99 then
		SendLuaMsg(0,{ids = MarryResult, res = 5},9)		-- 双方亲密度不足
		return
	end
	if fDegree < 0 then
		SendLuaMsg(0,{ids = MarryResult, res = 2},9)		-- 双方亲密度不足
		return
	end
	-- 3、自己是否已婚
	if CI_GetPlayerData(69) ~= nil then
		SendLuaMsg(0,{ids = MarryResult, res = 7},9)		-- 自己已婚
		return
	end
	-- 4、对方是否已婚
	if CI_GetPlayerData(69,2,mplayerid) ~= nil then
		SendLuaMsg(0,{ids = MarryResult, res = 8},9)		-- 对方已婚
		return
	end
	-- 6、是否是异性
	local mSex = CI_GetPlayerData(11,2,mplayerid)
	local fSex = CI_GetPlayerData(11,2,fplayerid)
	if mSex == fSex then
		SendLuaMsg(0,{ids = MarryResult, res = 6},9)			-- 同性恋就算了吧
		return
	end

	if 0 == result then 		-- 拒绝		
		SendLuaMsg(mplayerid,{ids = MarryResult,res = 1},10)
		return
	else						-- 同意		
		-- 更新婚姻状态
		SetSpouse(mplayerid,fName)	
		SetSpouse(fplayerid,mName)
		SetCouple(mplayerid,fplayerid)
		SetCouple(fplayerid,mplayerid)
		CI_SetRelation(mplayerid,3,2,fplayerid)
		CI_SetRelation(fplayerid,3,2,mplayerid)
		-- 更新属性
		-- Marry_GetAttribute(mplayerid)
		-- Marry_GetAttribute(fplayerid)
		
		-- 结婚成功(广播)
		BroadcastRPC('MarrySuccess',mName,fName)		
		-- 这里应该可以不用再单独发消息了
		SendLuaMsg(mplayerid,{ids = MarryResult,res = 0},10)
		SendLuaMsg(fplayerid,{ids = MarryResult,res = 0},10)	
		-- 双方发邮件 提示预约婚宴
		SendSystemMail(mplayerid,marrymailconf,11,2)
		SendSystemMail(fplayerid,marrymailconf,11,2)
		-- 从未婚列表移除
		RemoveSigleList(mplayerid)
		RemoveSigleList(fplayerid)
	end
end

local function GetTeam(mplayerid)     --返回队员id,队伍人数
	local TeamInfo = GetTeamInfo()
	local fplayerid
	local TeamCount = 0
	if nil == TeamInfo then 
		return 0,0
	end
	for _,v in pairs(TeamInfo) do
		TeamCount = TeamCount + 1
		if v.staticId ~= nil and v.staticId ~= mplayerid then
			fplayerid = v.staticId
		end
	end
	return fplayerid,TeamCount
end

-- 获取玩家预约index
function GetReserveIndex(playerid)
	if playerid == nil then return end
	local FeastData = GetFeastData()
	if nil == FeastData then return end
	for k, v in pairs(FeastData) do
		if type(k) == type(0) and type(v) == type({}) then
			if v[4] == playerid or v[5] == playerid then				
				return k
			end
		end
	end
end

-- 当前预约列表
function GetReserveList(sid)
	local feastData = GetFeastData()
	if nil == feastData then return end
	local mName = CI_GetPlayerData(5,2,sid)
	local fName = CI_GetPlayerData(69,2,sid)
	local index = GetReserveIndex(sid)
	local tmp = {}
	for k, v in pairs(feastData) do
		if type(k) == type(0) and type(v) == type({}) then
			table.push(tmp,k)
		end
	end
	SendLuaMsg(0,{ids = ReserveList,data = tmp,index = index},9)
end

-- 预约婚宴
-- TB_Index 预约时间段的索引
-- weddingTp  预约宴席类型 0 免费 1 普通 2 豪华
function ReserveWedding(mplayerid,TB_Index,weddingTp)
	local WedingInfo = GetWeddingInfo()
	if nil == WedingInfo then return end
	local feastData = GetFeastData()
	if nil == feastData then return end
	local mpMarryData = GetPlayerMarryData(mplayerid)
	if nil == mpMarryData then return end
	local mName = CI_GetPlayerData(5)
	local fName = CI_GetPlayerData(69)	
	if fName == nil then		-- 没有结婚 不能办婚宴
		SendLuaMsg( 0, { ids = MarryReserve,res = 1 }, 9 )
		return
	end
	if mpMarryData[1] and mpMarryData[1] == 1 then			-- 已经办过婚宴了
		SendLuaMsg( 0, { ids = MarryReserve,res = 2 }, 9 )
		return
	end
	-- 判断组队对象是否正确
	local fplayerid,TeamCount = GetTeam(mplayerid)                         
	if TeamCount ~= 2 or fName ~= CI_GetPlayerData(5,2,fplayerid) then
		SendLuaMsg(mplayerid,{ids = MarryReserve,res = 8},10)       -- 组队人数不对或对象不对
		return 
	end		
	local fpMarryData = GetPlayerMarryData(fplayerid)
	if nil == fpMarryData then return end
	-- 判断是否预约过了 需要遍历预约表
	local index = GetReserveIndex(mplayerid)
	if index ~= nil then
		SendLuaMsg( 0, { ids = MarryReserve,res = 7 }, 9 )		-- 已经预约过了
		return
	end
	
	-- 免费宴席
	if weddingTp == 0 then
		if CheckGoods(0, 201314, 0, mplayerid, "私人宴会") == 0 then
			SendLuaMsg( 0, { ids = MarryReserve,res = 6 }, 9 )		-- 钱不够
			return
		end
		-- 设置标志
		mpMarryData[1] = 1
		fpMarryData[1] = 1
		-- 加亲密度
		-- AddDearDegree(fplayerid,mplayerid,500)
		-- AddDearDegree(mplayerid,fplayerid,500)
		-- 发邮件
		local mSex = CI_GetPlayerData(11,2,mplayerid)
		local fSex = CI_GetPlayerData(11,2,fplayerid)
		if mSex == 0 then
			SendSystemMail(mplayerid,marrymailconf,9,2,nil,WedingInfo.level[weddingTp].awards)
			SendSystemMail(fplayerid,marrymailconf,10,2,nil,WedingInfo.level[weddingTp].awards)
		else
			SendSystemMail(mplayerid,marrymailconf,10,2,nil,WedingInfo.level[weddingTp].awards)
			SendSystemMail(fplayerid,marrymailconf,9,2,nil,WedingInfo.level[weddingTp].awards)
		end
		return
	end
	
	if feastData[TB_Index] ~= nil then		-- 该时段已经被人预约了	
		SendLuaMsg( 0, { ids = MarryReserve,res = 3 }, 9 )
		GetReserveList(mplayerid)			-- 更新预约时间列表面板
		return
	end
	local TimeBucket = WedingInfo.TimeBucket 
	if TimeBucket[TB_Index] == nil then		-- 没有这档预约时间
		SendLuaMsg( 0, { ids = MarryReserve,res = 4 }, 9 )
		return
	end
	local now = GetServerTime()
	if isPassedThisDay(TimeBucket[TB_Index][1],TimeBucket[TB_Index][2],now) then	-- 预约时间已经过了
		SendLuaMsg( 0, { ids = MarryReserve,res = 5 }, 9 )
		return
	end
	--根据玩家预约的婚宴类型扣元宝
	local cost = WedingInfo.level[weddingTp].Cost        
	if not CheckCost(mplayerid, cost, 0, 1, "预约婚宴") then
		TipCenter(GetStringMsg(144))
		return
	end
	
	-- 预约表 存 婚宴级别 名字 性别 头像编号 结缘类型
	feastData[TB_Index] = {weddingTp,mName,fName,mplayerid,fplayerid}	
	-- 发送全服邮件
	local contentTB = {mName,fName,TimeBucket[TB_Index][1],TimeBucket[TB_Index][2]}
	SendSystemMail(nil,marrymailconf,1,2,contentTB,nil,24*60)
	
	SendLuaMsg( 0, { ids = MarryReserve,res = 0 }, 9 )		-- 预约成功
	local SubTime = subTimeThisDay(TimeBucket[TB_Index][1],TimeBucket[TB_Index][2],TimeBucket[TB_Index][3])
	SubTime = SubTime - 5 * 60	-- 提前5分钟通知
	if SubTime <= 0 then
		WeddingInform(TB_Index,mplayerid,mName,fplayerid,fName,5 * 60 - (math.abs(SubTime)))
	else
		SetEvent(SubTime,nil,'WeddingInform',TB_Index,mplayerid,mName,fplayerid,fName,SubTime)       --婚宴前五分钟
	end		
	-- 记录到数据库
	db_marry_cost_record(mplayerid,cost)
end

function WeddingInform(TB_Index,mplayerid,mName,fplayerid,fName,SubTime)           --5分钟通知
	SendLuaMsg(mplayerid,{ids = WeddingNotice,SubTime = SubTime},10)
	SendLuaMsg(fplayerid,{ids = WeddingNotice,SubTime = SubTime},10)	
end

local function FeastInit(iType,mName,fName)
	local index = 21
	local npcid = 711000
	if iType == 2 then
		index = 22
		npcid = 712000
	end
	local npclist = npclist
	for k, v in pairs(rand_pos_config[index]) do
		if type(k) == type(0) and type(v) == type({}) then	
			local npc = npclist[npcid]
			npc.NpcCreate.controlId = npcid + 100000 + k
			npc.NpcCreate.regionId= v.R
			npc.NpcCreate.x = v.X
			npc.NpcCreate.y = v.Y
			local GID = CreateObjectIndirect(npc.NpcCreate)		
			if GID == nil then
				look("FeastInit GID == nil")
			end
		end
	end
end

-- 开始婚宴
function WeddingBegin(mplayerid)	
	local WedingInfo = GetWeddingInfo()
	if nil == WedingInfo then return end
	local mName = CI_GetPlayerData(5)
	local fName = CI_GetPlayerData(69)
	if fName == nil then 
		SendLuaMsg(0,{ids = MarryBegin,res = 1},9)
		return
	end
	
	local fplayerid,TeamCount = GetTeam(mplayerid)	
	if TeamCount ~= 2 or fName ~= CI_GetPlayerData(5,2,fplayerid) then
		SendLuaMsg(0,{ids = MarryBegin,res = 1},9)		
		return
	end
	local FeastData = GetFeastData()
	if nil == FeastData then return end
	-- 判断是否预约过了 需要遍历预约表	
	local index = GetReserveIndex(mplayerid)
	if index == nil or FeastData[index] == nil then
		SendLuaMsg(0,{ids = MarryBegin,res = 2},9)
		return
	end
		
	local mpMarryData = GetPlayerMarryData(mplayerid)
	if nil == mpMarryData then return end
	local fpMarryData = GetPlayerMarryData(fplayerid)
	if nil == fpMarryData then return end
	-- 判断已经举办过婚宴了
	if (mpMarryData[1] and mpMarryData[1] == 1) or (fpMarryData[1] and fpMarryData[1] == 1) then		
		SendLuaMsg(0,{ids = MarryBegin,res = 3},9)
		return
	end
	
	local TimeBucket = WedingInfo.TimeBucket
	local now = GetServerTime()
	local SubTime = subTimeThisDay(TimeBucket[index][1],TimeBucket[index][2],TimeBucket[index][3])
	if SubTime > 0 then
		SendLuaMsg(0,{ids = MarryBegin,res = 4},9)
		return
	end
	if SubTime + 5*60 < 0 then
		SendLuaMsg(0,{ids = MarryBegin,res = 5},9)
		return
	end	
	if FeastData.CurFeast ~= nil then					-- 当前已经有人办婚宴
		SendLuaMsg(0,{ids = MarryBegin,res = 6},9)
		return
	end
	local tp = 1            	--广播消息的类型       1 - 喜结良缘    2 - 义结金兰
	local mImageID = CI_GetPlayerData(70,2,mplayerid)
	local fImageID = CI_GetPlayerData(70,2,fplayerid)
	local mSex = CI_GetPlayerData(11,2,mplayerid)
	local fSex = CI_GetPlayerData(11,2,fplayerid)
	table.push(FeastData[index],mImageID)
	table.push(FeastData[index],fImageID)
	table.push(FeastData[index],mSex)
	table.push(FeastData[index],fSex)
	table.push(FeastData[index],tp)
	table.push(FeastData[index],now)
	
	-- 婚宴初始化
	local WeddingData = FeastData[index]
	local weddingTp = WeddingData[1]
	FeastInit(weddingTp,WeddingData[2],WeddingData[3])
	FeastData.CurFeast = index						-- 点击开始才置位	
	-- 设置标志
	mpMarryData[1] = 1
	fpMarryData[1] = 1
		
	-- 发开宴席礼包
	local NoticeID = 5
	local degree = 500
	if WeddingData[1] == 2 then
		NoticeID = 7
		degree = 3000
	end
	-- 加亲密度	
	AddDearDegree(fplayerid,mplayerid,degree)
	AddDearDegree(mplayerid,fplayerid,degree)
	if mSex == 0 then
		SendSystemMail(mplayerid,marrymailconf,NoticeID + 1,2,nil,WedingInfo.level[weddingTp].awards)
	else
		SendSystemMail(mplayerid,marrymailconf,NoticeID,2,nil,WedingInfo.level[weddingTp].awards)
	end
	if fSex == 0 then
		SendSystemMail(fplayerid,marrymailconf,NoticeID + 1,2,nil,WedingInfo.level[weddingTp].awards)
	else
		SendSystemMail(fplayerid,marrymailconf,NoticeID,2,nil,WedingInfo.level[weddingTp].awards)
	end
	CI_AddBuff(308,0,1,false,2,mplayerid)
	CI_AddBuff(308,0,1,false,2,fplayerid)
	BroadcastRPC('BR_WeddingBegin',WeddingData) -- 广播 喜结良缘/义结金兰 婚宴开始消息
	SetEvent(20 * 60,nil,'WeddingEnd',mplayerid,fplayerid)
	
	-- 只要开过婚宴
	db_marry_cost_clear(FeastData[index][4])
end

local function FeastRemove(iType,mName,fName)
	if iType == nil then return end
	local index = 21
	local npcid = 711000
	if iType == 2 then
		index = 22
		npcid = 712000
	end
	local npclist = npclist
	for k, v in pairs(rand_pos_config[index]) do
		if type(k) == type(0) and type(v) == type({}) then			
			local controlId = npcid + 100000 + k					
			local GID = RemoveObjectIndirect(v.R,controlId)			
			if GID == nil then
				look("FeastRemove GID == nil")
			end
		end
	end
end

--婚宴结束 清理相关数据
function WeddingEnd(mplayerid,fplayerid) 
	BroadcastRPC('WeddingEnd')
	local FeastData = GetFeastData()
	if nil == FeastData then return end
	if FeastData.CurFeast == nil then					--当前没有人办婚宴
		return
	end	
	-- 清理相关数据
	local iType = FeastData[FeastData.CurFeast][1]	
	FeastRemove(iType)
	FeastData[FeastData.CurFeast] = nil
	FeastData.CurFeast = nil		
end

function GetStoneNum(cost,iType)
	local big = 0
	local small = 0
	big = rint(rint(cost / 120) / 2)
	local rest = cost - big * 2 * 120
	small = rint(rint(rest / 50) / 2)
	
	if iType == 1 then
		big = big + 1
		small = small + 1
	elseif iType == 2 then
		big = big + 1
		small = small + 1
	end
	
	return big,small
end

function OnEatFeast()
	local playerid = CI_GetPlayerData(17)
	local pGuestData = GetPlayerMarryData(playerid)
	if nil == pGuestData then return end
	local FeastData = GetFeastData()
	if nil == FeastData then return end
	if FeastData.CurFeast == nil then	--当前没人办婚宴
		SendLuaMsg(playerid,{ids = EatFeast,res = 1},10)
		return
	end
	local index = FeastData.CurFeast
	local GuestName = CI_GetPlayerData(5)
	-- if GuestName == FeastData[index][2] or GuestName == FeastData[index][3] then	-- 自己的婚宴不能吃
		-- SendLuaMsg(playerid,{ids = EatFeast,res = 2},10))
		-- return
	-- end
	if FeastData[index] == nil then
		return
	end
	local feastLv = FeastData[index][1]	-- 当前婚宴级别 普通OR豪华
	local pLevel = CI_GetPlayerData(1)
	if pLevel < 30 then 				-- 等级不够不能吃
		SendLuaMsg(playerid,{ids = EatFeast,res = 2},10)
		return
	end
	if pGuestData[2] == nil then
		pGuestData[2] = {}
	end
	if pGuestData[2][index] == nil then
		pGuestData[2][index] = 0
	end
	local wLevel = GetWorldLevel()
	if pGuestData[2][index] <= 4 then
		pGuestData[2][index] = pGuestData[2][index] + 1
		local exps = rint(wLevel*1000 + 9000)
		if feastLv == 2 then
			exps = exps * 2
		end
		PI_PayPlayer(1, exps,0,0,'吃婚宴')
	elseif pGuestData[2][index] < 10 then
		local cost = 2 + 2 * (pGuestData[2][index] - 5)
		if cost <= 0 then return end
		if not CheckCost(playerid,cost,0,1,"吃宴席") then
			TipCenter(GetStringMsg(144))
			return
		end
		pGuestData[2][index] = pGuestData[2][index] + 1
		local exps = rint(wLevel*1000 + 9000) * 2
		if feastLv == 2 then
			exps = exps * 2
		end
		PI_PayPlayer(1, exps,0,0,'吃婚宴')	
	else
		SendLuaMsg(playerid,{ids = EatFeast,res = 3},10)
	end
	
	SendLuaMsg(playerid,{ids = EatFeast,res = 0},10)
	return 1
end

-- 点击吃酒席
call_npc_click[60040] = function ()	
	local sid = CI_GetPlayerData(17)
	local cid = GetObjectUniqueId()	
	CI_SetReadyEvent( cid,ProBarType.party,5,0,"OnEatFeast" )
end

-- function CoupleAward(mplayerid,fplayerid)
	-- AddDearDegree(fplayerid,mplayerid,50)
	-- AddDearDegree(mplayerid,fplayerid,50)
-- end

----------------------离婚---------
function TreatyDivorce(mplayerid)       --1双方协议离婚/解除结拜关系
	local mName = CI_GetPlayerData(5)
	local fName = CI_GetPlayerData(69)
	if fName == nil then
		TipCenter(GetStringMsg(677))
		return
	end

	local fplayerid,count = GetTeam()
	if count ~= 2 or fplayerid == nil or mplayerid == fplayerid or fName ~= CI_GetPlayerData(5,2,fplayerid) then
		TipCenter(GetStringMsg(679))
		return 
	end
	local fMarryData = GetPlayerMarryData(fplayerid)
	if nil == fMarryData then return end
	local mMarryData = GetPlayerMarryData(mplayerid)
	if nil == mMarryData then return end
	local index = GetReserveIndex(mplayerid)
	if index ~= nil then
		TipCenter(GetStringMsg(678))
		return
	end
	
	SendLuaMsg(fplayerid,{ids= divorceVerify,mplayerid = mplayerid },10)
end

--result是玩家确认的结果 1--同意离婚  0--不同意离婚
function DivorceConfirm(fplayerid,mplayerid,result)      
	local fMarryData = GetPlayerMarryData(fplayerid)
	if nil == fMarryData then return end
	local mMarryData = GetPlayerMarryData(mplayerid)
	if nil == mMarryData then return end
	local fName = CI_GetPlayerData(5,2,fplayerid)
	local mName = CI_GetPlayerData(5,2,mplayerid)
	if result == 1 then
		-- 清理结婚数据
		ClearMarryData(mplayerid)
		ClearMarryData(fplayerid)		

		--广播消息，XXX与XXX感情破裂，分道扬镳
		SendLuaMsg(mplayerid,{ids= DivorceRes,res = 1 },10)
		BroadcastRPC('DivorceSuccess',mName,fName)
		return
	elseif result == 0 then
		TipCenter(GetStringMsg(680))
		SendLuaMsg(mplayerid,{ids= DivorceRes,res = 0 },10)
		return
	end
end

-- 单人强制离婚/解除结拜关系 
function ForceDivorce(mplayerid)      
	local mMarryData = GetPlayerMarryData(mplayerid)
	if nil == mMarryData then return end
	local mName = CI_GetPlayerData(5)
	local fName = CI_GetPlayerData(69)
	if fName == nil then
		TipCenter(GetStringMsg(677))
		return
	end

	local index = GetReserveIndex(mplayerid)
	if index ~= nil then
		TipCenter(GetStringMsg(678))
		return
	end
	
	local call = { dbtype = 2, sp = 'N_GetLastLoginSeconds' , args = 1, [1] = fName }
	DBRPC( call , {callback = 'CALLBACK_ForceDivorce', args = 2, [1] = "?2",[2] = mplayerid })		
end

function CALLBACK_ForceDivorce(rs,mplayerid)	
	if rs ~= nil and type(rs) == type(0) then
		local mMarryData = GetPlayerMarryData(mplayerid)
		if nil == mMarryData then return end
		if rs < 7 * 24 * 3600 then
			SendLuaMsg( mplayerid, { ids = ForceVerify, cost = 99 }, 10 )
		else
			SendLuaMsg( mplayerid, { ids = ForceVerify, cost = 0 }, 10 )
		end
	else
		look("CALLBACK_ForceDivorce rs:" .. tostring(rs))
	end
end

function ForceDivorceConfirm(mplayerid,iType)
	local mMarryData = GetPlayerMarryData(mplayerid)
	if nil == mMarryData then return end
	local mName = CI_GetPlayerData(5)
	local fName = CI_GetPlayerData(69)
	if fName == nil then
		TipCenter(GetStringMsg(677))
		return
	end
	if iType == 1 then
		--扣除99两银子，向对方发送邮件通知
		if not CheckCost(mplayerid,99,0,1,"强制离婚") then
			TipCenter("银子不足")
			return
		end	
	end
	ClearMarryData(mplayerid)		
	BroadcastRPC('DivorceSuccess',mName,fName)
	-- 发邮件 通知对方	
	SendSystemMail(fName,marrymailconf,3,2,mName)
	
	local fplayerid = GetPlayer(fName,false)
	look('fplayerid:' .. tostring(fplayerid))
	if fplayerid == nil or type(fplayerid) ~= type(0) then	-- 对方不在线 暂时不能设置其属性 调用存储过程写记录
		local call = { dbtype = 2, sp = 'p_devorceplayer' , args = 3, [1] = 0, [2] = fName, [3] = GetGroupID() }
		DBRPC( call )	
		return
	end
	
	ClearMarryData(fplayerid)
end

-- 清理结婚数据
function ClearMarryData(playerid)
	local pMarryData = GetPlayerMarryData(playerid)
	if nil == pMarryData then return end
	local fName = CI_GetPlayerData(69,2,playerid)
	if fName == nil then return end
	DelSpouse(playerid,fName)
	if pMarryData[4] then
		CI_SetRelation(pMarryData[4],0,2,playerid)	
	end
	DelCouple(playerid)	
	pMarryData[1] = 0	

	--夫妻挑战清理结婚数据
	cc_divorce(playerid)
	
end

-- 每日重置
function MarryRefresh(playerid)
	local pMarryData = GetPlayerMarryData(playerid)
	if nil == pMarryData then return end
	pMarryData[2] = {}				-- 今日吃酒席次数 需每日重置
end

-- 玩家上线时同步离婚数据
function MarryDataSync(mplayerid)
	local fName = CI_GetPlayerData(69,2,mplayerid)
	if type(fName) ~= type('') then return end
	local mpMarryData = GetPlayerMarryData(mplayerid)
	if mpMarryData == nil then return end
	local fplayerid = mpMarryData[4]
	if fplayerid == nil then return end	
	
	-- 判断是否离婚
	local mName = CI_GetPlayerData(5,2,mplayerid)
	if not IsPlayerOnline(fplayerid) then	-- 对方玩家不在线 调用存储过程判断是否已经离婚
		local call = { dbtype = 2, sp = 'p_devorceplayer' , args = 3, [1] = mplayerid, [2] = mName, [3] = GetGroupID() }
		DBRPC( call , {callback = 'CALLBACK_GetDivorce', args = 2, [1] = "?4",[2] = mplayerid })	
	else
		local fpMarryData = GetPlayerMarryData(fplayerid)
		if fpMarryData == nil then return end
		if fpMarryData[4] == nil or fpMarryData[4] ~= mplayerid then		
			ClearMarryData(mplayerid)
		end
	end
end

-- 更改夫/妻名字
function MarryReNameCP(mplayerid)
	local fName = CI_GetPlayerData(69,2,mplayerid)
	if type(fName) ~= type('') then return end
	local call = { dbtype = 2, sp = 'p_Devorce_GetLatestRoleName' , args = 1, [1] = fName }
	DBRPC( call , {callback = 'CALLBACK_UpdateCPName', args = 2, [1] = mplayerid, [2] = "?2", })	
end

function CALLBACK_UpdateCPName(mplayerid,newName)
	-- 这里一定要注意：必须先判断是否已经离婚
	local fName = CI_GetPlayerData(69,2,mplayerid)
	if type(fName) ~= type('') then return end
	if type(newName) == type('') and newName ~= '' then
		SetSpouse(mplayerid,newName)
	end
end

function CALLBACK_GetDivorce(rs,mplayerid)
	look("CALLBACK_GetDivorce rs__" .. tostring(rs))
	if rs ~= nil and type(rs) == type(0) then
		if rs == 1 then
			ClearMarryData(mplayerid)
		end
	end
end

-- 结婚上线处理
function MarryOnlineProc(sid)
	SendFeastData(sid)			-- 发送当前婚宴信息
	MarryDataSync(sid)			-- 同步离婚数据
	MarryReNameCP(sid)			-- 如果对方改名，需要同步更新
end

-- 每天凌晨12点调用
-- 预约后没开宴席的返回钱
function Marry_ReserveBack()
	local FeastData = GetFeastData()
	if FeastData == nil then
		return
	end
	local wedConfig = GetWeddingInfo()
	if wedConfig == nil then return end
	
	for k, v in pairs(FeastData) do
		if type(k) == type(0) and type(v) == type({}) then
			local num = 0
			if v[1] == 1 then
				num = 40
			elseif v[1] == 2 then
				num = 100
			end
			-- 发送邮件
			SendSystemMail(v[4],marrymailconf,2,2,nil,{[3] = {{685,num,1},},})
			db_marry_cost_clear(v[4])
		end
	end
	
	-- 清除所有婚宴预约数据
	local wcustom = GetWorldCustomDB()
	if nil == wcustom then return end
	wcustom.feastData = {}
end

-- 领取称号
function Marry_GetTitle(mplayerid,idx)
	local fName = CI_GetPlayerData(69)
	if type(fName) ~= type('') then
		SendLuaMsg( 0, { ids = MarryTitle,res = 1 }, 9 )
		return
	end
	local WedingInfo = GetWeddingInfo()
	if WedingInfo == nil or WedingInfo.titles == nil then return end
	if WedingInfo.titles[idx] == nil then
		return
	end
	local tit = WedingInfo.titles[idx]
	local mpMarryData = GetPlayerMarryData(mplayerid)
	if mpMarryData[4] == nil then
		SendLuaMsg( 0, { ids = MarryTitle,res = 1 }, 9 )
		return 
	end
	local fplayerid = mpMarryData[4]
	local mDegree = GetFriendDegree(fplayerid,mplayerid) or 0
	if mDegree < tit[1] then
		SendLuaMsg( 0, { ids = MarryTitle,res = 2 }, 9 )
		return
	end
	SetPlayerTitle(mplayerid,tit[2])
	SendLuaMsg( 0, { ids = MarryTitle,res = 0 }, 9 )
end

function CALLBACK_ClearMarrCost(sid,ret)
	if sid == nil or ret == nil then
		return
	end
	look('CALLBACK_ClearMarrCost:' .. tostring(sid) .. '__' .. tostring(ret))
	if ret == 0 then
		look('CALLBACK_ClearMarrCost:' .. tostring(sid) .. '__' .. tostring(ret),1)
	end
end

-- 合服宴席预约定金返还
function CALLBACK_BackMarrCost(sid,rs)
	-- look('CALLBACK_BackMarrCost:' .. tostring(sid) .. '___' .. tostring(rs),1)
	if sid and type(rs) == type({}) then
		for k, v in pairs(rs) do
			if type(k) == type(0) and type(v) == type({}) then
				local pid = v[1] or 0
				local num = v[2] or 0
				if pid > 0 and num > 0 then
					SendSystemMail(pid,marrymailconf,12,2,nil,{[3] = {{684,num,1},},})
				end
			end
		end
	end
end

function GiveMarryAward()
	local sid = CI_GetPlayerData(17)
	if sid == nil then return end
	local fName = CI_GetPlayerData(sid,69)
	if fName == nil then 
		TipCenter(GetStringMsg(688))
		return		
	end
	local ActiveData = GetDBActiveData(sid)
	if ActiveData.ActTempData == nil then
		ActiveData.ActTempData = {}
	end
	if ActiveData.ActTempData[116] ~= nil then
		TipCenter(GetStringMsg(689))
		return
	end
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return
	end 
	GiveGoods(7210,1,1,"末日结缘活动奖励")
	ActiveData.ActTempData[116] = (ActiveData.ActTempData[116] or 0) + 1
	TipCenter(GetStringMsg(690))
end

function PrintRingExp(playerid)
	local pMarryData = GetPlayerMarryData(playerid)
	if nil == pMarryData then return end
	for k, v in pairs(pMarryData.ringAttr) do
		if type(k) == type(0) and type(v) == type({}) then
			rfalse(v[1] .. ":" .. v[2])
		end
	end
end

function PrintFeastData()
	local FeastData = GetFeastData()
	if nil == FeastData then return end
	for k, v in pairs(FeastData) do
		if type(k) == type(0) and type(v) == type({}) then
			rfalse(tostring(v[2]) .. ":" .. tostring(v[3]))		
		end
	end
end

function ClearFeastData()
	local FeastData = GetFeastData()
	if nil == FeastData then return end
	for k, v in pairs(FeastData) do
		if type(k) == type(0) then
			FeastData[k] = nil		
		end
	end
	FeastData.CurFeast = nil
end

