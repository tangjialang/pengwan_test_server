--[[
	file:	庄园系统
	author:	csj
	update:	2012-7-24
	notes: 需要存储的内容：庄园信息、菜园信息、当前装饰物、宴席数据、	
--]]

--s2c_msg_def
local MRD_Init = msgh_s2c_def[37][1]	-- 登陆初始化数据
local MRD_Exps = msgh_s2c_def[37][2]	-- 更新庄园等级、经验
local MRD_SetF = msgh_s2c_def[37][3]	-- 更新庄园排位和掠夺引导状态值
--local look = look
local uv_TimesTypeTb = TimesTypeTb
local SendLuaMsg = SendLuaMsg
local MANOR_MAXLV = 100

-- 玩家花园信息(目前果园数据全托管)
function GetPlayerGardenData(playerid)
	local extraData = GetDBExtraData(playerid)
	if extraData == nil then return end
	if extraData.garden == nil then
		extraData.garden = {
			opens = 2,				-- 菜园开启田地数												
			-- [1 ~ 12] = {},		-- 菜园数据
		}
	end
	return extraData.garden
end

-- 玩家随从信息
function GetPlayerHerosData(playerid)
	local extraData = GetDBExtraData(playerid)
	if extraData == nil then return end
	if extraData.heros == nil then
		extraData.heros = {			
		}
	end
	return extraData.heros			-- 家将随从	(1)
end

-- 玩家帮会相关信息
function GetPlayerFacData(playerid)
	local extraData = GetDBExtraData(playerid)
	if extraData == nil then return end
	if extraData.facD == nil then
		extraData.facD = {			
		}
	end
	return extraData.facD		-- 玩家帮会相关需要托管数据	(2)
end

-- 玩家庄园信息(data) 
-- 注意：添加数据项的时候记得记录数据类型 (0) or (1) or (2)
-- (0) 不需要托管的数据 (1) 需要托管的数据 (2) 需要托管并且在玩家下线期间可能会改变的数据
function GetPlayerManorData(playerid)
	local extraData = GetDBExtraData(playerid)
	if extraData == nil then return end
	if extraData.manor == nil then
		extraData.manor = {			
			-- rkCD = nil,		-- 排位赛cd	(0)
			-- lsRK = {},		-- 昨天排位信息 [1] 昨天的排位 [2] 是否领取排位奖励			
			-- rbTS = {},		-- 掠夺次数 [1] 剩余掠夺次数 [2] 上次更新时间 (0)
			-- rbPS = nil		-- 在当前等级表的位置 (0)
			-- PetD = nil,		-- 宠物数据 (0) [当前宠物形象需要托管]
			-- bFst = nil,		-- 初始化标志 (0) [nil] 没有初始化 [1] 排位赛 [2] 掠夺 [3] 排位赛和掠夺 
			
			mLv = 1,			-- 庄园等级 (1)
			mExp = 0,			-- 庄园经验	(1)							
			-- Tech = {},		-- 庄园科技	(1)
			-- rbPT = nil,		-- 掠夺保护时间 (2)
			-- Rank = 0,		-- 庄园排名	(2)
			-- Degr = 0,		-- 庄园通缉度 (2)
			-- MonT = {},		-- 摇钱树(2) [1] 当前存量 [2] 上次存量更新时间 [3] 下次可以领取时间 [4] 今日扣钱数量
		}
	end
	return extraData.manor
end

-- 玩家庄园信息(temp)
function GetPlayerManorTemp(playerid)
	local extraTemp = GetDBExtraTemp(playerid)
	if extraTemp == nil then return end
	if extraTemp.manor == nil then
		extraTemp.manor = {
			-- mrkName = nil,	-- 庄园排位赛对手名字
			-- mrkRNK = nil,	-- 当前攻打排名
			-- mrkGID = nil,	-- 庄园排位赛地图GID
			-- mrkAwards = nil,	-- 庄园排位赛奖励
			
			-- mrbName = nil,	-- 庄园掠夺对手名字
			-- mrbSID = nil,	-- 庄园掠夺对手SID
		}
	end
	return extraTemp.manor
end

-- 庄园排位赛 暂存排名前500位的玩家
function GetManorRankList()
	local worldRank = GetWorldRankData()
	if worldRank == nil then return end
	if worldRank.manorRank == nil then
		worldRank.manorRank = {}
	end
	
	return worldRank.manorRank
end

-- 庄园偷袭列表(以等级为Key的sid列表)
function GetManorRobberyList()
	local worldRank = GetWorldRankData()
	if worldRank == nil then return end
	if worldRank.manorRobbery == nil then
		worldRank.manorRobbery = {}
	end
	
	return worldRank.manorRobbery
end

-- 用于调试
function CL_ManorRobbery()
	local worldRank = GetWorldRankData()
	if worldRank == nil then return end
	worldRank.manorRobbery = nil
end

-- 用于调试
function CL_ManorRank()
	local worldRank = GetWorldRankData()
	if worldRank == nil then return end
	worldRank.manorRank = nil
end

-- 非活跃玩家、但是有排名的( 提供给500名以外的活跃玩家 )
-- outline and lv >= 30 and rank <= 500 and  lv < 40
function GetNonActiveList()
	local worldRank = GetWorldRankData()
	if worldRank == nil then return end
	if worldRank.NActList == nil then
		worldRank.NActList = {}
	end
	
	return worldRank.NActList
end 

--------------------------------------------庄园相关-----------------------------------------------

-- othersid == nil 取自己庄园数据/暂时不用了(等级、经验、宠物)
-- othersid ~= nil 取别人庄园数据(等级、经验、宠物)
-- iType: [1] 进入别人庄园 [2] 打开别人果园
function SyncManorData(sid,othersid,iType)
	-- look("SyncManorData:" .. sid)
	local playerid = othersid or sid
	local pManorData = GetManorData_Interf(playerid)
	if othersid then
		if pManorData == nil then		-- 需要默认给个数据
			SendLuaMsg( sid, { ids = MRD_Init, lv = 1, exps = 1, othersid = othersid, iType = iType}, 10 )
		else
			local petID = PI_GetPetID(playerid)
			SendLuaMsg( sid, { ids = MRD_Init, lv = pManorData.mLv, exps = pManorData.mExp, petID = petID, othersid = othersid, iType = iType}, 10 )
		end		
	end
end

-- 增加庄园经验
-- opt: [nil] 道具增加经验 [1] 功能增加经验(限制每日可获得最大值)
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

-- 设置初始化标志
function PI_SetManorFirst(sid,val)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	-- look(pManorData.bFst)
	if val == 1 then		-- 设置排位赛
		if pManorData.bFst == nil or pManorData.bFst % 2 == 0 then	-- 先判断以免出错
			pManorData.bFst = (pManorData.bFst or 0) + 1
		end
	elseif val == 2 then	-- 设置掠夺
		if pManorData.bFst == nil or rint(pManorData.bFst/2) % 2 == 0 then	-- 先判断以免出错
			pManorData.bFst = (pManorData.bFst or 0) + 2
		end
	end
	SendLuaMsg(sid, { ids = MRD_SetF, fst = pManorData.bFst }, 10)
end