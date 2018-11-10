--[[
file:	sql_active.lua
desc:	注册事件配置表事件、初始化运营活动信息
author:	csj
]]--

----------------------------------------------------------------
--include:

local ActiveConf_InitIDS = msgh_s2c_def[12][4]
local Buyfill_Get = msgh_s2c_def[12][30]
local Regist_Time = msgh_s2c_def[12][36]
local ActRank_Get = msgh_s2c_def[12][37]
local pairs,ipairs,type = pairs,ipairs,type

local look = look
local RPC = RPC
local BroadcastRPC = BroadcastRPC
local setplat = setplat
local Log = Log
local common_log  = require('Script.common.Log')
local Log_Begin = common_log.Log_Begin
local Log_Save  = common_log.Log_Save
local Log_End 	= common_log.Log_End
local time_proc_m = require('Script.active.time_proc')
local active_dynamic_refresh = time_proc_m.active_dynamic_refresh
-- local g_active_dynamic_table = time_proc_m.g_active_dynamic_table
local active_gettable=time_proc_m.active_gettable
local regist_event_dynamic = time_proc_m.regist_event_dynamic
local db_module = require('Script.cext.dbrpc')
local db_active_detail = db_module.db_active_detail
local db_active_list=db_module.db_active_list
local time_cnt=require('Script.common.time_cnt')
local analyze_time=time_cnt.analyze_time
local getdatetime=time_cnt.getdatetime
local escort=require('Script.active.escort')
local escort_activecall=escort.escort_activecall
local event_module = require('Script.cext.event_list')
local event_list = event_module.event_list
local kfrank_module = require('Script.active.kf_ranklist')
local insert_rank_active = kfrank_module.insert_rank_active
local kfrank_module_2 = require('Script.active.kf_ranklist_2')
local insert_rank_active_2 = kfrank_module_2.insert_rank_active_2
local kfrank_module_3 = require('Script.active.kf_ranklist_3')
local insert_rank_active_3 = kfrank_module_3.insert_rank_active_3
local hfaward_module = require('Script.active.hf_award')
local insert_merge_award = hfaward_module.insert_merge_award
local hfrank_module = require('Script.active.hf_ranklist')
local insert_merge_active = hfrank_module.insert_merge_active
local kf_plat_module = require('Script.active.kf_plat')
local insert_plat_active = kf_plat_module.insert_plat_active
local kf_cz_module = require('Script.active.kf_chongzhi')
local insert_kfcz_active = kf_cz_module.insert_kfcz_active
local kf_lc_module = require('Script.active.kf_leichong')
local insert_kflc_active = kf_lc_module.insert_kflc_active
local kf_ed_module = require('Script.active.kf_everyday')
local insert_kfeday_active=kf_ed_module.insert_kfeday_active
local cj_module = require('Script.active.chunjie')
local insert_chunjie_active=cj_module.insert_chunjie_active
local module_51 = require('Script.active.51active')
local insert_51_active=module_51.insert_51_active

local sclist_m = require('Script.scorelist.sclist_func')
local get_scorelist_data = sclist_m.get_scorelist_data
local uv_CommonAwardTable=CommonAwardTable

local jj_module = require('Script.active.jijin')
local jj_active=jj_module.jj_active
local qzg = require('Script.qizhenge.qizhenge_fun')
local qzg_active=qzg.qzg_active

local chunjie_module = require('Script.active.chunjie_active')
local update_chunjie_data = chunjie_module.update_chunjie_data
-- local insert_active_chunjie = chunjie_module.insert_active_chunjie
------------------------------------------------------------------
--module:

--module(...)

------------------------------------------------------------------
--data:

--运营活动配置列表
AllActiveListConf = AllActiveListConf or {
	list = {},		-- 需要发送给前台的
	cache = {},		-- 后台缓存的
	--version = nil,
}   

-- 名人堂
function GetHallOfFame()
	local worldRank = GetWorldRankData()
	if worldRank == nil then return end
	if worldRank.fame == nil then
		worldRank.fame = {}
	end
	return worldRank.fame
end

-- 发送名人堂
function SendHallOfFame(sid)
	local fame = GetHallOfFame()
	RPC('get_fame',fame)
end

--单个活动状态更新
--若活动开始 则通知前端 若活动结束 则清除缓存, 并通知前端
-- itype == 0 活动结束 ~= 0 活动开始
--活动ID	mainID,
local function _active_notice_web(itype, version, mainID)
	local list = AllActiveListConf.list
	local flag = false
	if itype == 0 then	
		for k, vec in pairs(list) do
			if k == mainID then
				list[k] = nil
				flag = true
				break
			end
		end
	else
		flag = true
	end
	
	if flag then
		BroadcastRPC('Act_NoticeVer', version) 
	end
	--local cache = AllActiveListConf.cache
end

-- 设置游戏环境
-- mon_award = 1,		-- 杀怪经验倍数
--xunbao = 4,		-- 寻宝活动

function SetGameEnviro(state,stype, val, View, Begin, Award, End, mainId)
	--rfalse("SetGameEnviro:" .. stype .. "__" ..  val)
	-- look('设置游戏环境',1)
	-- look(stype,1)
	if stype == 1 then
		SetEnvironment(1,val)
	elseif stype == 4 then--有排行寻宝
		--fsb_active(val,Begin,Award,End,mainID,subID)
		fsb_active(val,Begin,Award,End)
	elseif stype == 5 then--大转盘
		if state == 0 then
			Setluck_roll_mark(0)
		elseif state == 1 then
			Setluck_roll_mark(val - 1)
		end
	elseif stype == 6 then--无排行寻宝
		--fsb_active(val,Begin,Award,End,mainID,subID)
		fsb_active(val,Begin,Award,End,1)
	elseif stype == 7 then--基金投资	
		jj_active(val,Begin,Award,End)
	elseif stype == 8 then--老虎机	
		lhj_active(val,Begin)
	elseif stype == 9 then--梦幻卡牌
		dcard_active(val,Begin)
	elseif stype == 10 then--奇珍阁
		qzg_active(val,Begin,Award,End)
	end
end
------------------------------------------------------------------
--inner:

-- script interface for c
-- 重新获取运营活动配置
local function _active_version_update(version)
	-- look('_active_version_update',1)
	-- 每天12点强制刷新

	if version == nil then 
		AllActiveListConf.version = nil
	end
	if version == nil or AllActiveListConf.version == nil or version ~= AllActiveListConf.version then
		-- look('调用sql_active_init,重刷新活动',1)
		active_dynamic_refresh()	-- 调用sql_active_init,重刷新活动-- 运营活动列表
	end
end

local function _active_version_check(version)
	if version == nil or AllActiveListConf.version == nil or AllActiveListConf.version ~= version then
		return 2
	end
	return 1
end

---------------------------------------------------------------------------
--callback:

-- 运营活动列表
function CALLBACK_InitActiveList(rs,version,opentime,plat,mergetime)
	--look('运营活动列表',2)
	-- look(version,1)
	-- look(rs,1)
	--look(mergetime,2)
	-- 这里设置开服时间
	SetServerOpenTime(opentime)
	-- 这里设置合服时间
	SetServerMergeTime(mergetime)
	-- 设置平台标识
	setplat(plat)
	local now = GetServerTime()
	local g_active_dynamic_table = active_gettable()
	g_active_dynamic_table:set_begin( now )	
	--if AllActiveListConf.version == nil or version ~= AllActiveListConf.version then--暂时不检测版本
		AllActiveListConf = {
			list = {},		-- 需要发送给前台的
			cache = {},		-- 后台缓存的
		}
		insert_rank_active()	--开服排行榜活动
		insert_rank_active_2()	--开服排行榜活动2
		insert_rank_active_3()	--开服排行榜活动3
		insert_merge_award()	--合服补偿
		insert_merge_active()	--合服活动
		insert_plat_active()	--各平台钻等级活动
		insert_kfcz_active()	--开服充值活动
		insert_kflc_active()	--开服累冲活动
		insert_kfeday_active()	--开服后每日充值,骑兵,神翼活动
		--insert_chunjie_active()	--春节活动
		update_chunjie_data() --春节活动
		--insert_51_active()      --51活动
		if rs == nil then
			BroadcastRPC('Act_NoticeVer',version) 
			return
		end
		AllActiveListConf.rows = rs.rows or 0
		AllActiveListConf.count = 0
		if type(rs) == type({}) and table.empty(rs) == false then			
			for k, mainID in pairs(rs) do
				if type(k) == type(0) then
					db_active_detail(mainID,version) ---- 运营活动详细信息
				end
			end
		else
			BroadcastRPC('Act_NoticeVer',version)
		end
	--end	
end
--look(act_getmaxnum( 55 ))
--取得排行榜最大人数
function act_getmaxnum( id )
	local cache = AllActiveListConf.cache
	local conf=cache[id].AwardBuf
	local maxnum=0
	for k,v in pairs(conf) do
		if v.con then
			for j,k in pairs(v.con) do
				if type(k)==type({}) then
					if maxnum<k[2] then
						maxnum=k[2]
					end
				elseif type(k)==type(0) then
					if maxnum<k then
						maxnum=k
					end
				end
			end
		end
	end
	return maxnum
end
-- 运营活动详细信息
function CALLBACK_InitActiveConf(version,rs)
	--look('运营活动详细信息1111')
	--Log('active1.txt',rs)
	--look(rs)
	if type(rs) == type({}) and table.empty(rs) == false then			
		local list = AllActiveListConf.list
		local cache = AllActiveListConf.cache
		local now = GetServerTime()
		for _,v in pairs(rs) do
			
			if type(v) == type({}) then
				if #v >= 10 then
					list[v[1]] = { title = v[2],vIcon=v[7],ver = v[10],pic=v[11] }
					cache[v[1]] = { tView = v[3],tBegin = v[4],tEnd = v[5],tAward = v[6],AwardBuf = v[8] }
					-- 如果有EventBuf 注册事件
					if v[9] ~= nil then
						local begTb = analyze_time(v[4],0)
						local endTb = analyze_time(v[5],0)
						if v[9].arg == nil then
							for _, evtb in pairs(v[9]) do
								if evtb.Date == nil then									
									evtb.Date = {begTb,endTb}
								end
								regist_event_dynamic(evtb,now,v[1])
							end
						else
							if v[9].Date == nil then
								v[9].Date = {begTb,endTb}
							end
							regist_event_dynamic(v[9],now,v[1])
						end	
						-- evtb = { Date = {{2013,3,4,18,09,00},{2013,3,4,18,10,00}}, arg = { {[301] = 5}} }
					end					
				end
			end
		end
	end
	
	AllActiveListConf.count = (AllActiveListConf.count or 0) + 1
	-- 通过活动数量累加判断活动是否加载完成 并且在这里通知前台版本号
	if AllActiveListConf.count == AllActiveListConf.rows then
		AllActiveListConf.version = version
		AllActiveListConf.count = nil
		AllActiveListConf.rows = nil
		BroadcastRPC('Act_NoticeVer',version)		
	end	
		
end
--look(AllActiveListConf.cache[55].AwardBuf)
-- 没有第二个参数的过滤掉、因为有可能活动结束的时候不需要调用处理函数
-- 1、对于非充值消费排行榜类活动、由于是取的即时排行榜所以此种活动不能重复生成排行榜（目前是存储过程判断）
-- 2、而对于充值消费排行榜类活动则可以重复生成、只要保证传入的时间段是正确的
-- 3、对于即时排行榜、由于调用存储过程可能会失败所以需要同时记录在文本

-- 数据库排行榜类型
-- 101 战斗力  102  角色等级  103 战功 104 声望   201 家将  301 坐骑 302 骑兵  401 护身符  
-- 402 战斗法宝  501  山庄等级 601 竞技场排名
local sql_ranknum={
	[5]=301,
	[6]=201,
	[7]=102,
	[8]=101,
	[9]=401,		
	[10]=402,		-- 女神
	[12]=701,
	[13]=702,
	[14]=703,
	[15]=302,		-- 骑兵
	[16]=704,
	[17]=106,		-- 神翼
}
function OnActiveEvent(args)
	-- look("OnActiveEvent---------------------:" .. tostring(args[1]))
	-- look(args)
	--look(debug.traceback())
	-- look(args[2])
	-- look('OnActiveEvent',1)
	--look("OnActiveEvent:" .. args[1])
	if args == nil or args[2] == nil then return end
	local list = AllActiveListConf.list
	local cache = AllActiveListConf.cache
	local mainID = args[1]
	if mainID == nil then return end
	local serverid = GetGroupID()
	local now = GetServerTime()
	for key, val in pairs(args[2]) do
		local mainType = rint(key / 100)
		local subType = rint(key % 100)
		if mainType == 3 then		-- 排行榜类活动
			if subType == 1 or subType == 2 or subType == 19 then		-- 充值类
				-- rfalse(serverid)
				-- rfalse(cache[mainID].tBegin)
				-- rfalse(cache[mainID].tEnd)
				-- rfalse(val)
				-- rfalse(mainID)
				-- rfalse(key)
				local call = { dbtype = 2, sp = 'N_ActivityPayBuyRanking' , args = 8, [1] = serverid,[2] = cache[mainID].tBegin,[3] = cache[mainID].tEnd,[4] = val,[5] = 1,[6] = mainID,[7] = key,[8]=now}
				DBRPC( call )	
			elseif subType == 3 or subType == 4 then	-- 消费类
				local call = { dbtype = 2, sp = 'N_ActivityPayBuyRanking' , args = 8, [1] = serverid,[2] = cache[mainID].tBegin,[3] = cache[mainID].tEnd,[4] = val,[5] = 2,[6] = mainID,[7] = key,[8]=now}
				DBRPC( call )
			elseif (subType >=5 and subType <=10) or (subType >=12 and subType <=13) or subType == 15 or subType == 17  then-- 存储过程排行榜

				local maxnum=act_getmaxnum( mainID ) or 10
				-- look("注册排行活动---------------maxnum------:" .. maxnum)
				local call = { dbtype = 2, sp = 'N_ActivityUpdateRanking' , args = 7, [1] = serverid,[2] = mainID,[3] = '',[4] = 0,[5]=sql_ranknum[subType],[6]=now,[7]=maxnum,}
				local callback = { callback = 'CALLBACK_HallOfFame',args = 4, [1] = mainID, [2] = '?8', [3] = '?9', [4] = '?10' }
				DBRPC( call, callback )
			elseif subType == 11 then					-- 魅力排行类
				local scorelist = get_scorelist_data(2,5)										
				if scorelist and table.maxn(scorelist) >=1 then					
					for rank, v in pairs(scorelist) do
						if type(rank) == type(0) and type(v) == type({}) then
							local call = { dbtype = 2, sp = 'N_ActivityUpdateRanking' , args = 7, [1] = serverid,[2] = mainID,[3] = v[2],[4] = rank,[5]=0,[6]=now,[7]=0,}
							DBRPC( call )
						end
					end
				end
			elseif subType == 14 then					-- 排位赛排行榜
				local rkList = GetManorRankList()
				local maxnum = act_getmaxnum( mainID ) or 10
				if rkList and table.maxn(rkList) >=1 then
					for rank, pid in ipairs(rkList) do							
						if rank <= maxnum then
							local pname = PI_GetPlayerName(pid)		-- 排位赛前十 肯定有托管
							local call = { dbtype = 2, sp = 'N_ActivityUpdateRanking' , args = 7, [1] = serverid,[2] = mainID,[3] = pname,[4] = rank,[5]=0,[6]=now,[7]=0,}
							local callback = { callback = 'CALLBACK_HallOfFame',args = 4, [1] = mainID, [2] = '?8', [3] = '?9', [4] = '?10' }
							DBRPC( call, callback )
						end
					end
				end
			elseif subType == 16 then					-- 国王
				local owner_fid = getCityOwner()
				local pname = CI_GetFactionLeaderInfo(owner_fid,3)
				if type(pname) == type('') then
					local call = { dbtype = 2, sp = 'N_ActivityUpdateRanking' , args = 7, [1] = serverid,[2] = mainID,[3] = pname,[4] = 1,[5]=0,[6]=now,[7]=0,}
					local callback = { callback = 'CALLBACK_HallOfFame',args = 4, [1] = mainID, [2] = '?8', [3] = '?9', [4] = '?10' }
					DBRPC( call, callback )
				end
			elseif subType == 18 then					-- 国王帮会
				local owner_fid = getCityOwner()
				local fac_name = CI_GetFactionInfo(owner_fid,1)
				if type(fac_name) == type('') then
					local call = { dbtype = 2, sp = 'N_ActivityUpdateRanking' , args = 7, [1] = serverid,[2] = mainID,[3] = fac_name,[4] = 1,[5]=0,[6]=now,[7]=owner_fid,}					
					DBRPC( call )
				end
			end
		elseif mainType == 9 then	-- 改变游戏环境
			-- look('改变游戏环境')
			-- look(cache[mainID].tBegin)
			local View = getdatetime(analyze_time(cache[mainID].tView,0))
			local Begin=getdatetime(analyze_time(cache[mainID].tBegin,0))
			local Award=getdatetime(analyze_time(cache[mainID].tAward,0))
			local End=getdatetime(analyze_time(cache[mainID].tEnd,0))
			--local subID
			-- for j=1,10 do
			-- 	if cache[mainID].AwardBuf and cache[mainID].AwardBuf[j] then 
			-- 		if cache[mainID].AwardBuf[j].con then
			-- 			if cache[mainID].AwardBuf[j].con[1]==904 then 
			-- 				subID=j
			-- 				break
			-- 			end
			-- 		end
			-- 	end
			-- end
			-- look("这个活动开始了吗?---------------- "..mainID)

			SetGameEnviro(args[3],subType,val, View,Begin,Award,End, mainID)
			--SetGameEnviro(subType,val,Begin,Award,End,mainID,subID)
		elseif mainType == 11 then	-- 镖车活动
			--look(args)
			--look(val)
			escort_activecall(args[3],val)			
		elseif mainType == 12 then	-- BOSS活动
			dofile('cext\\dyn_drop.lua')
			DynDropTable.Boss_activecall(args[3],val)
		end
	end
end
-- iType == 0 取活动列表
-- iType == 1 取详细信息
-- iType == 2 取奖励名单
-- iType == 3 能领奖时显示领奖次数
function Active_SendData(playerid,iType,mainID,ver)	
	-- look('取活动列表',1)
	-- look(iType,1)
	-- look(mainID,1)
	-- look(ver,1)
	local list = AllActiveListConf.list
	local cache = AllActiveListConf.cache
	local version = AllActiveListConf.version
	local serverid = GetGroupID()
	-- look(list)
	if iType == 0 then		-- iType == 0 取活动列表
		SendLuaMsg( 0, { ids = ActiveConf_InitIDS,iType = iType,conf = AllActiveListConf.list,ver = version }, 9 )
	elseif iType == 1 then	-- iType == 1 取详细信息		
		if cache[mainID] == nil then
			return
		end
		
		if ver == nil or ver ~= list[mainID].ver then	
			-- look('取详细信息222'..tostring(mainID))		
			local call = { dbtype = 201, sp = 'N_GetActiveInfo' , args = 1, [1] = mainID}
			local callback = { callback = 'CALLBACK_GetActiveInfo', args = 4, [1] = playerid,[2] = mainID,[3] = iType,[4] = "?2" }
			DBRPC( call, callback )
		end	
	elseif iType == 2 then-- iType == 2 取奖励名单
		--look('取奖励名单')
		local call = { dbtype = 0, sp = 'N_ActivityGetRankingList' , args = 4, [1] = serverid,[2] = mainID,[3] = playerid,[4] = 1,}
		DBRPC( call, { callback = 'CALLBACK_GetRankingList', args = 5, [1] = playerid,[2] = mainID,[3] = iType,[4] = "|100",[5] = "?5" } )
	elseif iType == 3 then	-- iType == 3 能领奖时显示领奖次数
		-- look(cache[mainID],1)
		if cache[mainID] == nil or cache[mainID].AwardBuf == nil then
			return
		end
		-- look(1111,1)
		local account = CI_GetPlayerData(15)
		local beg_time = cache[mainID].tBegin
		local end_time = cache[mainID].tEnd
		for k, AwardTb in pairs(cache[mainID].AwardBuf) do
			if type(k) == type(0) then
				if AwardTb.con then
					for key, _ in pairs(AwardTb.con) do
						if type(key) == type(0) then
							stype = key							
							local mainType = rint(key / 100)
							local subType = rint(key % 100)	
							if mainType == 8 then	-- 充值消费类
								if subType == 4 or subType == 5 then	-- 每日充值消费
									local dt = os.date( "*t" )
									beg_time = dt.year.."-"..dt.month.."-"..dt.day
									end_time = dt.year.."-"..dt.month.."-"..dt.day.." 23:59:59"
								end
							elseif mainType == 10 then	-- 特殊类
								if subType == 2 or subType == 4 or subType == 6  then	-- 每日相关
									local dt = os.date( "*t" )
									beg_time = dt.year.."-"..dt.month.."-"..dt.day
									end_time = dt.year.."-"..dt.month.."-"..dt.day.." 23:59:59"
								end
							elseif mainType == 15 then	-- 次数
								local dt = os.date( "*t" )
								beg_time = dt.year.."-"..dt.month.."-"..dt.day
								end_time = dt.year.."-"..dt.month.."-"..dt.day.." 23:59:59"
							end
						end
					end
				end
			end
		end

		local call = { dbtype = 2, sp = 'N_ActivityParticipateNums' , args = 5, [1] = account,[2] = playerid,[3] = mainID,[4] = beg_time,[5] = end_time}

		DBRPC( call, { callback = 'CALLBACK_GetPartiNums', args = 4, [1] = playerid,[2] = mainID,[3] = iType,[4] = "#100" } )
	elseif iType == 4 then	-- iType == 4 只返回详细信息 不取描述(减轻中心DB的压力)
		if cache[mainID] == nil then
			return
		end
		
		if ver == nil or ver ~= list[mainID].ver then
			SendLuaMsg( playerid, { ids = ActiveConf_InitIDS,iType = iType,mainID = mainID,ver = list[mainID].ver,cache = cache[mainID] }, 10 )
		end
	end
end
--活动详细信息
function CALLBACK_GetActiveInfo(playerid,mainID,iType,rs)
	if not IsPlayerOnline(playerid) then 
		return 
	end
	local list = AllActiveListConf.list
	local cache = AllActiveListConf.cache
	if cache[mainID] == nil then
		return
	end
	--if type(rs) == type('') then
		SendLuaMsg( playerid, { ids = ActiveConf_InitIDS,iType = iType,mainID = mainID,ver = list[mainID].ver,cache = cache[mainID],desc = rs }, 10 )
	--end
end
--奖励名单-- iType == 2 取奖励名单
function CALLBACK_GetRankingList(playerid,mainID,iType,rklist,rank)	
	-- look(mainID)
	-- look(rklist)
	-- look(rank)
	-- look('取到奖励名单')
	if not IsPlayerOnline(playerid) then 
		return 
	end
	SendLuaMsg( playerid, { ids = ActiveConf_InitIDS,iType = iType,mainID = mainID,rank = rank,rklist = rklist }, 10 )
end
--领奖记录
function CALLBACK_GetPartiNums(playerid,mainID,iType,rs)
	-- look('领奖记录',1)
	-- look(mainID,1)
	-- look(rs,1)
	local list = AllActiveListConf.list
	local cache = AllActiveListConf.cache
	if cache[mainID] == nil then
		return
	end
	
	SendLuaMsg( playerid, { ids = ActiveConf_InitIDS, iType = iType,mainID = mainID,rs = rs }, 10 )
end

-- 为了避免回滚次数太多 先判断一次包裹
function award_check_goods( awardInfo )	
	if nil == awardInfo or table.empty(awardInfo) then
		return true
	end

	-- 奖励道具
	if( awardInfo[3] ~= nil ) then
		local succ,retCode,nCount = CheckGiveGoods(awardInfo[3])
		if not succ then
			if (retCode == 3) then					
				local info =GetStringMsg(14,nCount)
				TipCenter(info) 	
			end
			return false
		end
	end

	-- 奖励装备
	if( awardInfo[4] ~= nil ) then
		local needNum = #awardInfo[4]
		local pakagenum = isFullNum()
		if pakagenum < needNum then
			TipCenter(GetStringMsg(14,needNum))
			return false
		end
	end

	return true
end

-- 名人堂
function CALLBACK_HallOfFame(mainID,name,headID,sex)
	-- look('CALLBACK_HallOfFame')
	-- look(mainID)
	-- look(name)
	-- look(headID)
	-- look(sex)
	local fames = GetHallOfFame()
	if fames == nil then return end
	if mainID and mainID > 2000000000 and mainID < 2100000000 and name and headID and sex then
		fames[mainID] = fames[mainID] or {}
		fames[mainID][1] = name
		fames[mainID][2] = sex*100 + headID
	end
end

-- 运营活动领奖
function ActiveAwardCheck(playerid,mainID,subID)
	 look('存储判断',1)
	 look(mainID,1)
	 look(subID,1)
	local list = AllActiveListConf.list
	local cache = AllActiveListConf.cache
	if list[mainID] == nil or cache[mainID] == nil then 
		return 
	end
	
	
	if cache[mainID].AwardBuf==nil then return end
	local AwardTb = cache[mainID].AwardBuf[subID]
	if AwardTb == nil or AwardTb.con == nil then 
		return 
	end

	-- 判断领奖时间
	 --look('cache[mainID].tAward:' .. tostring(cache[mainID].tAward),1)
	 --look('cache[mainID].tAward:' .. tostring(cache[mainID].tEnd),1)
	local awardTime = os.time( analyze_time(cache[mainID].tAward,1) )
	local endTime = os.time( analyze_time(cache[mainID].tEnd,1) )
	-- --look(os.date('%Y-%m-%d %H:%M:%S', awardTime),1)
	if GetServerTime() < awardTime or GetServerTime() >= endTime then
		RPC("ACT_DoAward",1)
		-- look('333',1)
		return
	end
	-- --look(AwardTb.con)
	-- 判断领奖条件
	local ck, info = ActiveConditionConf.CheckConditions(playerid,AwardTb.con)
	if ck == 0 then
		RPC("ACT_DoAward",2)
		-- look('2222',1)
		return
	end
	-- 为了避免回滚次数太多 先判断一次包裹
	local AwardTb_ = uv_CommonAwardTable.AwardProc(playerid,AwardTb.awd)
	--check awards 检查背包
	local getok = award_check_items(AwardTb_,AwardTb.etc) 

	--local getok = award_check_goods(AwardTb.awd)

	if not getok then
		-- look('1111',1)
		RPC("ACT_DoAward",3)
		return		
	end
	
	-- 存储过程条件判断
	local serverid = GetGroupID()
	local account = CI_GetPlayerData(15)	
	local stype = nil
	local beg_val = nil
	local end_val = nil
	local con_val = nil
	local beg_time = cache[mainID].tBegin
	local end_time = cache[mainID].tEnd
	local awd_time = cache[mainID].tAward
	for key, v in pairs(AwardTb.con) do
		if type(key) == type(0) then
			stype = key
			beg_val = v
			end_val = v
			local mainType = rint(key / 100)
			local subType = rint(key % 100)				
			if mainType == 3 then		-- 排行榜类 
				if type(v) == type({}) then
					beg_val = v[1]
					end_val = v[2]					
				end
				if subType == 18 then	-- 国王帮
					con_val = CI_GetPlayerData(23)
				elseif subType == 19 then	-- 充值排行	+ 额外奖励
					con_val = v[3]
				end
			elseif mainType == 4 then	-- 道具收集类
				beg_val = 0
				end_val = 0
			elseif mainType == 8 then	-- 充值消费类
				if subType == 4 or subType == 5 then	-- 每日充值消费
					local dt = os.date( "*t" )
					beg_time = dt.year.."-"..dt.month.."-"..dt.day
					end_time = dt.year.."-"..dt.month.."-"..dt.day.." 23:59:59"
				end
			elseif mainType == 10 then	-- 特殊类
				if subType == 2 or subType == 4 or subType == 6  then	-- 每日活跃度/平台红砖
					local dt = os.date( "*t" )
					beg_time = dt.year.."-"..dt.month.."-"..dt.day
					end_time = dt.year.."-"..dt.month.."-"..dt.day.." 23:59:59"
				end
			elseif mainType == 14 then	-- 合服活动
				end_val = GetServerOpenTime()
			elseif mainType == 15 then	-- 次数类
				
				local dt = os.date( "*t" )
				beg_time = dt.year.."-"..dt.month.."-"..dt.day
				end_time = dt.year.."-"..dt.month.."-"..dt.day.." 23:59:59"
			elseif mainType == 19 then	-- 道具消耗类
				if type(v) == type({}) then
					beg_val = v[1]
					end_val = v[2]					
				end
			end
			break
		end
	end
	-- look("call N_ActiveParticipate",1)
	-- look(serverid,1)
	-- look(account,1)
	-- look(playerid,1)
	-- look(mainID,1)
	-- look(subID,1)
	-- look(stype,1)
	-- look(beg_time,1)
	-- look(end_time,1)
	-- look(AwardTb.num,1)
	-- look(beg_val,1)
	-- look(end_val,1)
	if AwardTb.con[1601]~=nil then --限购特殊处理,代表全服最大次数
		beg_val=AwardTb.con[1601]
	elseif AwardTb.con[1701]~=nil then --限购特殊处理,代表全服最大次数
		beg_val=AwardTb.con[1701]
		end_val=AwardTb.con[1702]
	end
	-- look('开始领奖',1)
	local call = { dbtype = 0, sp = 'N_ActivityParticipate' , args=14, [1]=serverid,[2]=account,[3]=playerid,[4]=mainID,
						[5]=subID,[6]=stype,[7]=beg_time,[8]= end_time,[9]=awd_time,[10]=AwardTb.num,[11]=beg_val,[12]=end_val,[13]=con_val,[14]=GetServerTime()}
						
	local callback = { callback = 'CALLBACK_ActiveCheck', args = 5, [1] = playerid,[2] = mainID,[3] = subID,[4] = "?15",[5]="?16" }
	DBRPC( call, callback )	
	
end

function CALLBACK_ActiveCheck(playerid,mainID,subID,check,num)
	--look('领奖结果',1)
	--look(check,1)
	--look(num,1)
	local list = AllActiveListConf.list
	local cache = AllActiveListConf.cache
	if list[mainID] == nil or cache[mainID] == nil then 
		return 
	end
	if cache[mainID].AwardBuf==nil then return end
	local AwardTb = cache[mainID].AwardBuf[subID]
	if AwardTb == nil or AwardTb.con == nil then 
		return 
	end
	
	if check == nil or check == 0 then		
		RPC("ACT_DoAward",2)
		return
	end
	
	local AwardTb_ = uv_CommonAwardTable.AwardProc(playerid,AwardTb.awd)
	--check awards 检查背包
	local getok = award_check_items(AwardTb_,AwardTb.etc) 		
	if not getok then
		RPC("ACT_DoAward",3)
		-- 回滚记录
		local call = { dbtype = 0, sp = 'N_ActivityPartRollback' , args = 1, [1] = num}			
		DBRPC( call )
		return
	end		

	-- -- 再次判断包裹
	-- local getok = award_check_goods(AwardTb.awd)
	-- if not getok then
	-- 	RPC("ACT_DoAward",3)
	-- 	-- 回滚记录
	-- 	local call = { dbtype = 0, sp = 'N_ActivityPartRollback' , args = 1, [1] = num}			
	-- 	DBRPC( call )
	-- 	return
	-- end
	
	-- 这里才扣除道具
	local ck, info = ActiveConditionConf.CheckConditions(playerid,AwardTb.con,1)
	if ck == 0 then
		RPC("ACT_DoAward",2)
		-- 回滚记录
		local call = { dbtype = 0, sp = 'N_ActivityPartRollback' , args = 1, [1] = num}			
		DBRPC( call )
		return
	end
	
	if AwardTb.con[1603]~=nil then
		if not  CheckCost( playerid , AwardTb.con[1603] , 0 , 1, "限购") then
			return 
		end
	end
	-- 给奖励
	local _,retCode = GI_GiveAward(playerid,AwardTb_,"运营活动奖励[" .. tostring(mainID) .. "]__[" .. tostring(subID) .. "]")
	-- 额外奖励判断
	if check == 2 and AwardTb.etc then
		ActiveExtraAward(playerid,mainID,subID,AwardTb.etc)
	end
	RPC("ACT_DoAward",0,mainID,subID)
	-- look(mainID,1)
	-- look(subID,1)
end

-- 活动额外奖励
function ActiveExtraAward(playerid,mainID,subID,etc)
	if playerid == nil or mainID == nil or subID == nil or etc == nil then return end
	local _,retCode = GI_GiveAward(playerid,etc,"运营活动奖励[" .. tostring(mainID) .. "]__[" .. tostring(subID) .. "]")
end

function CALLBACK_ActiveExtra(sid,mainID,subID,rs)
	if sid == nil or mainID == nil or subID == nil or rs == nil then return end
	local list = AllActiveListConf.list
	local cache = AllActiveListConf.cache
	if list[mainID] == nil or cache[mainID] == nil then 
		return 
	end
	if cache[mainID].AwardBuf==nil then return end
	local AwardTb = cache[mainID].AwardBuf[subID]
	if AwardTb == nil or AwardTb.awd == nil then 
		return 
	end
	if AwardTb.etc == nil then return end
	local etcTb = AwardTb.etc
	if type(etcTb.awd) ~= type({}) then 
		return 
	end
end


--取得传入时间段内充值消费信息[itype=1为充值信息，2为消费信息,3每日充值,4为每日消费信息,5历史总充值,6每日充值(每日首充)]
function Getbuyfillinfo(sid,begintime,endtime,itype)
	if sid==nil or begintime==nil or endtime==nil or itype==nil then return end
	local serverid = GetGroupID()
	local call
	if itype==1 or itype==3 or itype == 6 then --充值
		 call = { dbtype = 2, sp = 'N_ActivityPayBuyPoint' , args = 5, [1] = sid,[2] = serverid,[3] = begintime,[4] = endtime,[5]=1}
	elseif itype==2 or itype==4 then --消费
		 call = { dbtype = 2, sp = 'N_ActivityPayBuyPoint' , args = 5, [1] = sid,[2] = serverid,[3] = begintime,[4] = endtime,[5]=2}
	else
		return
	end
	local callback = { callback = 'CALLBACK_Getbuyfillinfo', args = 5, [1] = sid,[2] = itype,[3] = "?6",[4] = begintime, [5] = endtime }
	DBRPC( call, callback )
end

-- 活动排行榜信息
function GetActiveRanklist(sid,mainID,itype,begintime,endtime,num)
	if sid == nil or mainID == nil or itype == nil or begintime == nil or endtime == nil then return end
	local call = { dbtype = 2, sp = 'N_ActivityGetPayBuyRanking' , args = 4, [1] = begintime,[2] = endtime,[3] = itype,[4] = num}
	local callback = { callback = 'CALLBACK_GetActiveRanklist', args = 4, [1] = sid,[2] = mainID,[3] = itype,[4] = '#100' }
	DBRPC( call, callback )
end

function CALLBACK_GetActiveRanklist(sid,mainID,itype,rs)
	if sid == nil or rs == nil then return end
	SendLuaMsg( sid, { ids = ActRank_Get,mainID = mainID,itype = itype,rs = rs}, 10 )
end

function CALLBACK_Getbuyfillinfo(sid,itype,num,begintime,endtime)
	if sid==nil  or itype==nil then return end 
	-- look(11111,1)
	-- look(itype,1)
	-- look(num,1)
	if(itype == 6)then
		get_sc_everyday_gift(sid,num)
	else
		SendLuaMsg( 0, { ids = Buyfill_Get,itype = itype,num = num,begt = begintime,endt = endtime}, 9 )
	end
	if itype == 1 then
		-- if  then return end
	end
end

-- 取玩家注册时间(第一次登录)
function GetRegistTime(sid)	
	if sid == nil then return end
	-- look('GetRegistTime')
	local call = { dbtype = 2, sp = 'N_GetFirstLoginSeconds' , args = 1, [1] = sid }
	local callback = { callback = 'CALLBACK_GetFistLogin', args = 2, [1] = sid,[2] = "?2" }
	DBRPC( call, callback )
end

function CALLBACK_GetFistLogin(sid,seconds)
	-- look('CALLBACK_GetFistLogin')
	-- look(seconds)
	if seconds and seconds > 0 then
		SendLuaMsg( sid, { ids = Regist_Time,tm = seconds}, 10 )
	end
end

---取时间段内单笔充值记录,活动id,开始时间,结束时间--单笔充值满足最小金额
function act_getsolochongzhi( sid ,paypoints,btime,etime)
	-- look(paypoints,1)
	-- look(btime,1)
	-- look(etime,1)
	if sid == nil then return end
	local serverID = GetGroupID()
	local account=CI_GetPlayerData(15)
	local call = { dbtype = 0, sp = 'N_ActivityGetPayRecords' , args = 5, [1] = account,[2]=serverID,[3]=paypoints,[4]=btime,[5]=etime }
	local callback = { callback = 'CALLBACK_act_getsolochongzhi', args = 2, [1] = sid,[2] = '#100' }
	DBRPC( call, callback,1 )
end
--取充值回调
function CALLBACK_act_getsolochongzhi(sid,rs)
	-- look(rs,1)
	RPC('a_chongzhi',rs)
end
-------------------------------------------------------
--interface:

active_version_update = _active_version_update
active_version_check = _active_version_check
active_notice_web = _active_notice_web

