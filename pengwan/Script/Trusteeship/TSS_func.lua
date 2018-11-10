--[[ 
	托管相关函数
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
-- 怪物基本属性 用于第一次打排位赛
local monBaseAttr = { monAtt = {9000,0,200,400,200,100,100,100,100}, }

--------------------------------------------------------------------------
-- inner function:

function GetWorldExtraData()
	dbMgr.extra_data.data = dbMgr.extra_data.data or {
		-- 掠夺
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

-- 获取玩家托管类数据
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

-- 单独起个文件存放庄园偷袭表及排位赛表（如果有其他需要脚本缓存的排行榜信息也可以存放）
-- 这个到时候写排行榜通用函数的时候放在那儿
function GetWorldRankData()	
	dbMgr.world_rank_data.data = dbMgr.world_rank_data.data or {}
	return dbMgr.world_rank_data.data
end

-- 第一次打排位赛的时候记录(保证宕机的时候玩家有托管数据)
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

-- 玩家上线调用
-- 托管数据同步到玩家数据(只同步下线后会变化数据)
-- 如果玩家长时间不上线 可能托管数据中已经将玩家删除掉了
function World_to_Player(playerid)
	--look('World_to_Player:' .. tostring(playerid))
	-- 跨服不处理
	if IsSpanServer() then
		return
	end
	local playerExtra = GetDBExtraData(playerid)
	if playerExtra == nil then
		--look('World_to_Player playerExtra == nil')
		return 
	end
	local worldExtra = GetSingleExtraData(playerid)	-- 如果为nil说明没托管或被删除(如果没保存数据库就直接返回)
	if worldExtra == nil then
		if playerExtra.manor and playerExtra.manor.Rank then
			playerExtra.manor.Rank = nil
		end
		--look('World_to_Player worldExtra == nil')
		return 
	end
	
	--look(playerExtra.manor)
	--look(worldExtra.manor)
	-- 同步{庄园排位、通缉度、掠夺保护时间、摇钱树, 昨日排位}
	if playerExtra.manor ~= nil and worldExtra.manor ~= nil then
		playerExtra.manor.Rank = worldExtra.manor.Rank
		playerExtra.manor.Degr = worldExtra.manor.Degr
		playerExtra.manor.rbPT = worldExtra.manor.rbPT
		playerExtra.manor.MonT = worldExtra.manor.MonT
		playerExtra.manor.lsRK = worldExtra.manor.lsRK		-- 这个很重要：因为这也是下线会修改的数据
	end
	-- 排名必须重置正确(防止服务器宕机造成数据不一致)
	if playerExtra.manor ~= nil and worldExtra.manor == nil then
		playerExtra.manor.Rank = nil
	end
	-- 同步菜园数据(只需同步被偷次数、暂时全部同步)
	if playerExtra.garden ~= nil and worldExtra.garden ~= nil then
		playerExtra.garden = worldExtra.garden						
	end
	-- 同步战功
	-- local zgValue = worldExtra.zgValue or 0
	-- AddPlayerPoints(playerid,6,zgValue,1,'同步战功')
	-- 同步荣誉值
	local ryval = worldExtra.ryval or 0
	AddPlayerPoints(playerid,10,ryval,1,'同步荣誉值')
	-- 同步帮会相关数据
	if playerExtra.facD ~= nil and worldExtra.facD ~= nil then
		playerExtra.facD = worldExtra.facD					
	end
	-- 设置帮会ID
	local tsData = worldExtra.tsData
	if tsData and tsData[1] and tsData[1][6] and tsData[1][6] > 0 then
		CI_SetPlayerData(5,tsData[1][6]) 
	end
	--look('World_to_Player:' .. tostring(playerid) .. '__complete')
end

-- 条件：(排位赛前500名) or 菜园种植 or 开放偷袭(lv >= 43)
function CheckNeedTs(playerid)
	local playerExtra = GetDBExtraData(playerid)
	if playerExtra == nil then return false end	
	local lv = CI_GetPlayerData(1)
	-- if lv < 34 then return false end		-- 他们给的等级不太靠谱 容易出问题 这里暂时不判断了
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

-- 删除的时候 t = nil ins = -1
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

-- 玩家下线调用
-- 条件：(排位赛前500名) or 菜园种植 or 开放偷袭(lv >= 43)
-- 玩家数据同步到托管数据
function Player_to_World(playerid)	
	-- --look('Player_to_World:' .. tostring(playerid))
	-- 跨服不处理
	if IsSpanServer() then
		return
	end
	local playerExtra = GetDBExtraData(playerid)
	if playerExtra == nil then return end	
	-- 判断托管条件
	if not CheckNeedTs(playerid) then
		-- --look("不满足托管条件")
		return
	end		
	local lv = CI_GetPlayerData(1)
	-- 满足托管条件的情况下判断是否为非活跃玩家
	--if lv < 40 then
		--PushNActList(playerid)
	--end		

	-- 满足托管条件初始化托管数据
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
	-- 托管庄园数据
	if playerExtra.manor ~= nil then
		if worldExtra.manor == nil then
			worldExtra.manor = {}
		end
		worldExtra.manor.mLv = playerExtra.manor.mLv		-- 庄园等级 (1)
		worldExtra.manor.mExp = playerExtra.manor.mExp		-- 庄园经验 (1)
		worldExtra.manor.Tech = playerExtra.manor.Tech		-- 庄园科技 (1)
		worldExtra.manor.ins = playerExtra.manor.ins		-- 排位赛鼓舞(1)
		
		worldExtra.manor.Rank = playerExtra.manor.Rank		-- 庄园排位 (2)
		worldExtra.manor.lsRK = playerExtra.manor.lsRK		-- 庄园昨日排位 (2)
		worldExtra.manor.Degr = playerExtra.manor.Degr		-- 庄园通缉度 (2)
		worldExtra.manor.rbPT = playerExtra.manor.rbPT		-- 庄园掠夺保护时间 (2)
		worldExtra.manor.MonT = playerExtra.manor.MonT		-- 摇钱树 (2)
	end
	-- 托管菜园数据
	if playerExtra.garden ~= nil then
		worldExtra.garden = playerExtra.garden						-- 菜园数据(2)
	end		
	-- 托管战功(目前下线后战功只会减少不会增加、所以暂时没托管累计战功)
	local zgPoint = GetPlayerPoints(playerid,6)
	if zgPoint then													-- 战功(2)
		worldExtra.zgValue = zgPoint
	end
	
	-- 托管荣誉点(每两小时会涨)
	local ryval = GetPlayerPoints(playerid,10)
	if ryval then													-- 荣誉值(2)
		worldExtra.ryval = ryval
	end

	-- 托管帮会相关数据
	if playerExtra.facD ~= nil then
		worldExtra.facD = playerExtra.facD							-- 帮会相关数据(2)
	end
	-- 托管随从数据
	if playerExtra.heros ~= nil then
		worldExtra.heros = playerExtra.heros						-- 随从数据(1)
	end
	-- 托管人物基本信息、属性数据
	-- ( { 名字，等级，vip，外型，武器，帮会id，战斗力，头像},{13个二级属性}, {8个主动技能ID/LV} )
	local tsData = CI_GetPlayerTSData(playerid)
	if tsData ~= nil then
		worldExtra.tsData = tsData											-- 人物基本数据(1)
	end	
	
	-- --look(tsData,2)
	
	-- 托管宠物形象
	local petID = PI_GetPetID(playerid)										-- 宠物形象(1)
	worldExtra.petID = petID
	
	-- 托管庄园装饰	
	local pZSData = PI_GetCurGarniture(playerid)							-- 庄园装饰(1)
	worldExtra.zsDT = pZSData
	
	-- 更新下线时间(用于托管删除)
	worldExtra.logout = GetServerTime()
	worldExtra.acct = worldExtra.logout
	
	-- 最后做统计
	set_extra_debug(worldExtra,ins)
	-- --look('Player_to_World:' .. tostring(playerid) .. '__complete')
end

-- 玩家下线调用(测试用)
-- 条件：(lv >= 30 and 排位赛前500名) or 菜园种植(lv >= 40 and 种植) or 开放偷袭(lv >= 43)
-- 玩家数据同步到托管数据
function Player_to_World_Debug(playerid)
	-- 满足托管条件初始化托管数据
	local wExtra = GetWorldExtraData()
	if wExtra == nil then return end
	local ins = 0
	if wExtra[playerid] == nil then
		ins = 1
	end
	wExtra[playerid] = table.copy(TSS_Config[1001])
	-- 置空排位、方便插入排位赛
	wExtra[playerid].manor.Rank = nil
	-- 压入掠夺列表
	local lv = math.random(45,65)
	MRB_PushList(playerid,lv,1)
	-- 压入排位赛
	MR_PushRank(playerid)
	-- 最后做统计
	set_extra_debug(wExtra[playerid],ins)
end

-- 上线同步备份数据到托管
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
		-- 更新帮会ID
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
	if sid <= 10000 then		-- 保留机器人
		return
	end
	-- 1、如果在线就不管
	if IsPlayerOnline(sid) then
		return 4
	end
	-- 2、排位赛有名次
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
	
	-- bDel == nil 只做统计
	-- bDel == 1 删除deltype == 1 or deltype == 3
	-- bDel == 2 删除deltype == 2
	if deltype > 0 and bDel then
		if ( bDel == 1 and (deltype == 1 or deltype == 3) ) or
		   ( bDel == 2 and (deltype == 2 ) ) then
			-- 先备份
			if deltype ~= 1 then
				delData[sid] = delData[sid] or {}
				local dd = delData[sid]
				if t.manor then				
					dd[1] = t.manor.lsRK	-- 庄园昨日排位 (2)
					dd[2] = t.manor.Degr	-- 庄园通缉度 (2)
					dd[3] = t.manor.rbPT	-- 庄园掠夺保护时间 (2)
					dd[4] = t.manor.MonT	-- 摇钱树 (2)
				end
				if t.zgValue then
					dd[5] = t.zgValue
				end
				if t.tsData and t.tsData[1] then	-- 保留帮会ID数据
					dd[6] = t.tsData[1][6]
				end
				
				dd.dtm = now				-- 记录删除时间
			end
			wExtraData[sid] = nil
			wExtraData.num = (wExtraData.num or 0) - 1
			wExtraTemp[sid] = nil
			--look('del sid:' .. tostring(sid) .. '__acct:' .. tostring(acct) .. '__logout:' .. tostring(logout), 1)		
		end
	end

	return deltype
end

-- 删除单人托管数据(现在只针对只是因为排位赛排名而托管的玩家)
function single_extra_del(sid)
	local mergeTime = GetServerMergeTime() or 0
	if mergeTime <= 0 then
		return
	end
	local wExtraData = GetWorldExtraData()
	if wExtraData == nil then return end
	local wExtraTemp = GetWorldExtraTemp()
	if wExtraTemp == nil then return end
	-- 如果不需要托管了
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



----------------------------------------XXX_Interf类接口----------------------------------------

-- 获取庄园数据接口 (如果返回nil 说明玩家既不在线也没托管数据(可能被删除))
function GetManorData_Interf(playerid)
	local pManorData = GetPlayerManorData(playerid)
	if pManorData == nil then		-- 不在线取托管数据
		local extraData = GetSingleExtraData(playerid)
		if extraData == nil then
			return
		end
		return extraData.manor
	end
	return pManorData	 
end

-- 获取菜园数据接口 (如果返回nil 说明玩家既不在线也没托管数据(可能被删除))
function GetGardenData_Interf(playerid)
	local pGardenData = GetPlayerGardenData(playerid)
	if pGardenData == nil then		-- 不在线取托管数据
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

-- 获取家将数据接口 (如果返回nil 说明玩家既不在线也没托管数据(可能被删除))
function GetHerosData_Interf(playerid)
	local pHerosData = GetPlayerHerosData(playerid)
	if pHerosData == nil then		-- 不在线取托管数据
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
	if pFacData == nil then		-- 不在线取托管数据
		local extraData = GetSingleExtraData(playerid)
		if extraData == nil then
			return
		end
		return extraData.facD
	end
	return pFacData	
end

-- 只取托管数据
local function GetTsData_Interf(playerid)
	if IsPlayerOnline(playerid) then		-- 在线应该不会来取这个、这里加个判断防止外面没判断
		return
	end
	local worldExtra = GetSingleExtraData(playerid)
	if worldExtra == nil then return end
	
	return worldExtra.tsData
end

-- 获取战斗结果面板信息统一接口
-- ( { 名字，等级，vip，外型，武器，帮会id，战斗力，头像} )
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

-- 取玩家名字接口
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

-- 取玩家等级接口
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

-- 取玩家战斗力
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

-- 获取VIP类型
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

-- 取玩家HeadID
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

-- 取玩家ImageID
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

-- 取玩家帮会ID
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

-- 设置帮会ID(用于玩家下线被加入帮会)
-- 注意：如果玩家现在还不满足托管条件 这里也会生成托管数据
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
		if param == 1 then	-- 取等级
			return worldExtra.tsData[1][2]
		elseif param == 5 then	-- 取名字
			return worldExtra.tsData[1][1]
		end
	end	
end

-- 判断玩家是否在线或托管
-- flags [nil] 在线或托管 [not nil] 有托管才返回true 否则返回false
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

-- 获得战功接口
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

-- 增加战功接口
function PI_AddPlayerZG(sid, val)
	if sid == nil or val == nil then return end
	if IsPlayerOnline(sid) then
		AddPlayerPoints(sid,6,val,nil,'增加战功')
	else
		local worldExtra = GetSingleExtraData(sid)
		if worldExtra == nil then return end
		worldExtra.zgValue = (worldExtra.zgValue or 0) + val
		if worldExtra.zgValue < 0 then
			worldExtra.zgValue = 0
		end
	end
end

-- 获得荣誉点接口
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

-- 增加荣誉点
function PI_AddPlayerRY(sid, val)
	if sid == nil or val == nil then return end
	if IsPlayerOnline(sid) then
		AddPlayerPoints(sid,10,val,nil,'增加荣誉点_2')
	else
		local worldExtra = GetSingleExtraData(sid)
		if worldExtra == nil then return end
		worldExtra.ryval = (worldExtra.ryval or 0) + val
		if worldExtra.ryval < 0 then
			worldExtra.ryval = 0
		end
	end
end

-- 取庄园当前装饰接口
function PI_GetCurGarniture(playerid)
	if IsPlayerOnline(playerid) then
		return Garniture_interZY(playerid)
	else
		local worldExtra = GetSingleExtraData(playerid)
		if worldExtra == nil then return end
		return worldExtra.zsDT
	end
end

-- 获取当前选择宠物形象接口
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

------------------------------------------------特殊怪物创建----------------------------------------------

-- 随机一个机器人ID
-- @iType: [1] 排位赛 [2] 掠夺
function Robot_RandID(iType)
	if iType == 1 then
		return 1001
	elseif iType == 2 then
		return math.random(2001,2006)
	end
end

-- 重设机器人相关属性
function Robot_Reset()
	--look('Robot_Reset')
	local worldExtra = GetWorldExtraData()			
	-- 排位赛、掠夺
	worldExtra[2001] = TSS_Config[2001]		
	worldExtra[2002] = TSS_Config[2002]
	worldExtra[2003] = TSS_Config[2003]
	worldExtra[2004] = TSS_Config[2004]
	worldExtra[2005] = TSS_Config[2005]
	worldExtra[2006] = TSS_Config[2006]		
end

-- -- 获取机器人数据
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

-- 创建人物怪
-- @itype: [1] 庄园排位赛 [2] 庄园掠夺
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
			--look("玩家没有托管数据")
			return
		end
		-- --look(pTSData)
		local MaxHP = pTSData[2][1]		-- 记录原始血量
		monsterConf.name = pTSData[1][1]
		monsterConf.level = pTSData[1][2]
		monsterConf.imageID = pTSData[1][4]
		monsterConf.headID = pTSData[1][5]
		monsterConf.bossType = pTSData[1][8]
		monsterConf.monAtt = pTSData[2]
		if itype == 1 then	-- 庄园排位赛3倍血量
			monsterConf.monAtt[1] = rint(pTSData[2][1] * 1)			
		end
		monsterConf.skillID = pTSData[3][1]
		monsterConf.skillLevel = pTSData[3][2]		
			
		ret = CreateObjectIndirect(monsterConf)
		-- 重要！！！如果不还原血量就会一直 *3 下去
		pTSData[2][1] = MaxHP			-- 还原原始血量
		-- --look(monsterConf)
	end	
	if ret then
		return 1,ret
	end
end

-- 排位赛创建出战随从
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

-- 创建掠夺时的随从怪
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

-- 创建宠物怪
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

-- 进入庄园创建随从
-- 设置ControlID == {5,6,7,8} 名字后面带(家将)
function CreateManorHeros(playerid,mapGID,posList)
	if mapGID == nil or posList == nil or type(posList) ~= type({}) or #posList ~= 4 then 
		--look("CreateManorHeros param erro")
		return
	end	
	local pHerosData = GetHerosData_Interf(playerid)
	if pHerosData == nil then return end
	-- 读取随从怪物配置
	local monsterConf = PlayerMonsterConf[5] 
	if monsterConf == nil or type(monsterConf) ~= type({}) then return end
	monsterConf.regionId = mapGID
	monsterConf.camp = 4					-- 玩家友好怪
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
				-- if index ~= fight then		-- 进庄园 不创建出战随从
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

