--[[
file:	player_events.lua
desc:	player events callback.
author:	chal
update:	2011-12-07
refix: done by chal
2014-08-23：add by sxj ,add bsmz,bsmz_online,bsmz_online(sid)
]]--

--------------------------------------------------------------------------
--include:
local Dead_UI		= msgh_s2c_def[3][1]
local Send_Wlevel	= msgh_s2c_def[3][4]
local Script_Init 	= msgh_s2c_def[3][8]
local Send_Login 	= msgh_s2c_def[3][22]
local time_ver 		= msgh_s2c_def[255][3]
local Faction_Build = msgh_s2c_def[7][4]
local show_equip 	= msgh_s2c_def[39][3]
local mathrandom,mathfloor,mathceil = math.random,math.floor,math.ceil
local type,tostring	= type,tostring
local pairs			= pairs
local define		= require('Script.cext.define')
local TaskTypeTb 	= define.TaskTypeTb
local Define_POS 	= define.Define_POS
local look 			= look
local TableHasKeys 	= table.has_keys
local TipCenterEx	= TipCenterEx
local GetStringMsg	= GetStringMsg
local SendLuaMsg	= SendLuaMsg
local active_mgr_m = require('Script.active.active_mgr')
local activitymgr = active_mgr_m.activitymgr
local lt_module = require('Script.active.lt')
local lt_exit = lt_module.lt_exit
local faction_monster = require('Script.active.faction_monster')
local ss_onlogin = faction_monster.ss_onlogin
local escort = require('Script.active.escort')
local escort_playerdead=escort.escort_playerdead
local escort_login=escort.escort_login
local db_module =require('Script.cext.dbrpc')
local db_lvup_log=db_module.db_lvup_log
local db_item_out=db_module.db_item_out

local get_login_info = db_module.get_login_info
local db_module = require('Script.cext.dbrpc')
local db_faction_yajin_back = db_module.db_faction_yajin_back
local db_marry_cost_back = db_module.db_marry_cost_back
local db_savelogouttime=db_module.db_savelogouttime

local CI_GetPlayerData 		= CI_GetPlayerData
local CI_RoleCreateInit 	= CI_RoleCreateInit
local MarkTaskKillMonster 	= MarkTaskKillMonster
local SyncTaskData			= SyncTaskData
local SendTaskMask			= SendTaskMask
local CI_GetCurPos			= CI_GetCurPos
local CheckGoods			= CheckGoods
local CI_OnSelectRelive		= CI_OnSelectRelive
local CI_SetPlayerIcon		= CI_SetPlayerIcon
local GetPlayerDayData		= GetPlayerDayData
local SetLogoutHangUpData	= SetLogoutHangUpData
local SetLoginHangUpData	= SetLoginHangUpData
local GetServerOpenTime		= GetServerOpenTime
local send_player_wage		= send_player_wage
local Ver					= __Ver
local shq_m = require('Script.ShenQi.shenqi_func')
local shenqi_dead_punishment = shq_m.shenqi_dead_punishment
local shenqi_login = shq_m.shenqi_login
local SetShenQiIcon = shq_m.SetShenQiIcon
local shenqi_get_ring = shq_m.shenqi_get_ring
local CI_HasBuff = CI_HasBuff

local wuzhuang = require('Script.wuzhuang.wuzhuang_fun')
local EquipItem= wuzhuang.EquipItem

local CI_GetFactionInfo = CI_GetFactionInfo
local bsmz			 = require ("Script.bsmz.bsmz_fun")
local bsmz_online	 = bsmz.bsmz_online
local bsmz_add		 = bsmz.bsmz_add
local donate = require("Script.Player.player_donate")		-- 玩家捐献爵位系统
local donate_onlogin = donate.donate_onlogin

local chunjie_active = require("Script.Active.chunjie_active")
local online_chunjie_data = chunjie_active.online_chunjie_data

local dragon_module = require("Script.ShenBing.dragon_func")
local dragon_repair_bug = dragon_module.dragon_repair_bug
--------------------------------------------------------------------------
-- inner:

local uv_send_data = {}
 
 --发送版本更新消息
local function Check_vertime(sid)
	if sid==nil  then return end
	local level = CI_GetPlayerData(1)
	if level>1 then
		local dayData = GetPlayerDayData(sid)
		local ref = dayData.ref 
		if ref==nil or ref.day == nil or ref.day<Ver then
			SendLuaMsg( 0, { ids=time_ver }, 9 )
		end
	end
end

-- 合服处理函数
local function MergeServer_Proc(sid)
	-- 首先判断是否是合服服务器
	local mergeTime = GetServerMergeTime() or 0
	if mergeTime <= 0 then
		return
	end	
	-- 返回帮会运镖押金
	db_faction_yajin_back(sid)
	-- 返回婚宴预约定金
	db_marry_cost_back(sid)
	--look('MergeServer_Proc')
	local lv = CI_GetPlayerData(1,2,sid)	
	-- 判断是否有托管数据
	-- 如果可以托管却没托管数据说明是合服第一次上线
	if not IsPlayerTSD(sid,1) then
		--look('MergeServer_Proc 1')
		local pManorData = GetManorData_Interf(sid)
		if pManorData == nil then return end
		-- 先去掉排名
		pManorData.Rank = nil
		-- 更新排位赛数据		
		if pManorData.bFst then
			--look('MergeServer_Proc 2')
			local rkList = GetManorRankList()
			if rkList == nil then return end
			pManorData.Rank = #rkList + 1
			if pManorData.Rank <= MAXRANKNUM then
				rkList[pManorData.Rank] = sid
				set_extra_rank(sid,pManorData.Rank)		-- 2000名以外的应该不用管
			else
				pManorData.Rank = MAXRANKNUM + 1
			end
		end
		-- 更新掠夺数据
		if lv >= 43 then
			--look('MergeServer_Proc 3')
			local roblist = GetManorRobberyList()
			if roblist == nil then return end
			if roblist[lv] == nil then
				roblist[lv] = {}
			end
			table.push(roblist[lv],sid)
		end
		-- 放托管
		if CheckNeedTs(sid) then
			--look('MergeServer_Proc 4')
			Player_to_World(sid)
		end
	end
	
end

-- 跨服服务器上线处理
local function SpanServer_Proc(sid)
	if sid == nil then return end
	if IsSpanServer() then
		--------------设置本服id
		CI_SetPlayerData(10,GetPlayerServerID(sid),sid)
		--------------
		--look(cUID,1)
		local cUID = GetPlayerSpanUID(sid) or 0

		if cUID == 1 then	-- 进入跨服BOSS活动		
			local ret = GI_spanboss_enter(sid)
			if not ret then	-- 进入不成功 直接丢回原服
				SetSpanLeaveTime(sid,cUID,-1)		-- 意外情况 保证不加逃跑BUFF
				CI_LeaveSpanServer()
				return
			end
		elseif cUID == 2 then	-- 进入跨服寻宝活动	
			local ret = GI_spanxb_enter(sid)
			if not ret then	-- 进入不成功 直接丢回原服
				-- SetSpanLeaveTime(sid,cUID,-1)		-- 意外情况 保证不加逃跑BUFF
				CI_LeaveSpanServer()
				return
			end
		elseif cUID == 3 then	-- 进入跨服捕鱼活动	
			local ret = GI_span_catchfish_enter(sid)
			if not ret then	-- 进入不成功 直接丢回原服
				-- SetSpanLeaveTime(sid,cUID,-1)		-- 意外情况 保证不加逃跑BUFF
				CI_LeaveSpanServer()
				return
			end
		elseif cUID == 4 then	-- 进入跨服3v3活动	
			local ret = v3_login(sid)
			if not ret then	-- 进入不成功 直接丢回原服
				-- SetSpanLeaveTime(sid,cUID,-1)		-- 意外情况 保证不加逃跑BUFF
				CI_LeaveSpanServer()
				return
			end
		elseif cUID == 5 then	-- 进入跨服天降宝箱活动	
			local ret = GI_span_tjbx_enter(sid)
			if not ret then	-- 进入不成功 直接丢回原服
				SetSpanLeaveTime(sid,cUID,-1)		-- 意外情况 保证不加逃跑BUFF
				CI_LeaveSpanServer()
				return
			end
		elseif cUID == 6 then	-- 进入跨服三界战场活动		
			local ret = GI_span_sjzc_enter(sid)
			if not ret then	-- 进入不成功 直接丢回原服
				-- SetSpanLeaveTime(sid,cUID,-1)		-- 意外情况 保证不加逃跑BUFF
				CI_LeaveSpanServer()
				return
			end	
		elseif cUID == 7 then   --进入跨服1v1活动
			local ret = v1_login(sid)
			if not ret then	-- 进入不成功 直接丢回原服
				CI_LeaveSpanServer()
				return
			end
		elseif cUID == 8 then   --进入三界至尊
			local ret = sjzz_js_enter(sid)
			if not ret then	-- 进入不成功 直接丢回原服
				CI_LeaveSpanServer()
				return
			end	
		-- else		
			-- -- 为了兼容老服BOSS活动加的逻辑 全服更新后去掉
			-- local con = GetSpanServerInfo(1)
			-- if con then
				-- local ret = GI_spanboss_enter(sid)
				-- if not ret then	-- 进入不成功 直接丢回原服
					-- SetSpanLeaveTime(sid,1,-1)		-- 意外情况 保证不加逃跑BUFF
					-- CI_LeaveSpanServer()
					-- return
				-- end
			-- end
		end
		
	end
	return true
end
 
-- 取出生时的武器ID
local function GetFirstWeaponID(sid)
	local school = CI_GetPlayerData(2,2,sid)
	local sex = CI_GetPlayerData(11,2,sid)
	if school == 1 then
		if sex == 0 then
			return 5037
		elseif sex == 1 then
			return 5000
		end
	elseif school == 2 then
		if sex == 0 then
			return 5111
		elseif sex == 1 then
			return 5074
		end
	elseif school == 3 then
		if sex == 0 then
			return 5185
		elseif sex == 1 then
			return 5148
		end
	end
end

local function PlayerInit(sid)	
	-- 判断是否是第一次登录
	local taskData = GetDBTaskData(sid)
	if taskData and taskData.binit == nil then--第一次登录
		local wID = GetFirstWeaponID(sid)
		if wID then
			CI_RoleCreateInit(1,wID)
		end
		taskData.binit = 1
		CS_RequestEnter(sid,1001)
		TS_AcceptTask( sid, 1001)
	end
	-- 如果没有接受过第一个任务 发送第一个剧情给前台
	if taskData and taskData.binit == 1 then
		local _,_,cj = CI_GetPlayerData(56)
		--look("cj:" .. cj)
		local storyID = 0
		if cj == 3 then
			storyID = 100000
		else
			return
		end
		--look("storyID:" .. storyID)
		SendStoryData(storyID)
	end  
end

local function InitTaskWhenLogin(sid)
end

-- 玩家上线时需要同步给客户端的数据，统一由此消息发出

local function SendScriptInit(sid)
	-- 世界等级加成
	local playerTemp = GetCurTaskTemp()
	local wAddNew = GetWorldExpAdd(sid)
	local svrTime = GetServerOpenTime() 	--开服时间
	local mergeTime = GetServerMergeTime()	-- 合服时间
	if playerTemp==nil then return end
	playerTemp.wAdd = wAddNew
	
	uv_send_data[1] = wAddNew
	uv_send_data[2] = GetWorldLevel()
	uv_send_data[3] = svrTime
	uv_send_data[4] = mergeTime
	
	SendLuaMsg( 0, { ids = Script_Init, d = uv_send_data}, 9 )
end

-- 未领取的奖励上线处理
local function Awd_OnlineProc(sid)
	-- MRK_OnlineProc(sid)		-- 排位赛奖励处理
end

--------------------------------------------------------------------------
-- interface:

-- 玩家每次上线时调用（登陆/断线重连/换机器登陆等等）
-- 这里主要处理的是需要初始化给前台的数据；服务器端的初始化在OnPlayerLogin中进行
-- check1：初始化时整个脚本数据都序列化发给了前台（SyncTaskData），所以里面的数据不需要二次发送。如果需要处理放到OnPlayerLogin里面
-- check2：是否有是否零碎的数据放到SendScriptInit中
-- check3：是否有可以在玩家操作（如打开面板时）才需要发送给玩家的数据
function OnPlayerOnline(binit)	
	look('OnPlayerOnline',2)
	
	local sid = CI_GetPlayerData(17)
--	look(sid,2)
--	g_chk(3,sid)
	
	if sid == nil or sid <= 0 then return end
	PlayerInit(sid)				-- 第一次登陆初始化数据
	-- 未防止后面的操作报错导致解锁执行不到现在放最前面
	UnLockPlayer(sid)			-- 上线解锁玩家
	if binit ~= 1 then
		return
	end
	if not IsSpanServer() then
		--------------记录本服ID
		SetPlayerServerID(sid)
		--------------
	end
	-- 跨服上线处理
	--look('OnPlayerOnline',1)
	-- look(sid,1)
	if not SpanServer_Proc(sid)	then
		return
	end
	--龙脉BUG修复
	dragon_repair_bug(sid)
	--检查排位赛数据
	MRK_LoginCheckRankData(sid)
	--清除废旧数据
	Clear_player_old_data(sid)
	--春节活动上线处理
	online_chunjie_data(sid)
	
	-- 发送永久脚本数据
	SyncTaskData()		
	-- 发送永久标记信息	
	SendTaskMask()
	-- 发送脚本通用初始化消息
	SendScriptInit(sid)
	-- 临时VIP上线处理
	VIP_OnlineProc(sid)
	-- 副本上线处理
	CS_OnLineProc(sid)					
	-- 活动上线统一处理接口
	activitymgr:on_login(sid)
	-- 奖励统一处理接口
	Awd_OnlineProc(sid)
	-- 擂台赛上线处理
	lt_exit(sid,5)		

	bsmz_online(sid)	--宝石迷阵活动上线
	--ss_onlogin(sid)	--神兽活动上线
	active_getawards(sid)		--活动积分未领奖上线处理
	
	HeroAutoFight(sid)			-- 随从自动出战
	Active_SendData(sid,0)		-- 发送活动列表
	
	-- 特殊情况下的上线同步	
	escort_login()				-- 运镖
	sendMountLuck()				-- 发送坐骑当前抽奖标识	
	sendFactionUnion(sid) --发送帮会同盟数据
	send_auto_faction()	--发送机器人帮会数据
	sendCityOwner(sid)	-- 发送当前城主帮会名
	send_player_wage(sid) --发送每日签到数据
	online_leave_faction(sid)	-- 离线被踢帮的人去掉帮会战称号
	fsb_lookbox(sid) --寻宝仓库数据
	get_login_info(sid)		-- 取存储过程登陆相关信息 (比如：手机验证)	
	clear_player_ff_week(sid)-- 清除周帮贡
	wing_reset(sid)
	MarryOnlineProc(sid)		-- 发送当前婚宴信息
	SendSpanActiveState(sid)	-- 发送跨服活动信息
	v3reg_online(sid)			--发送跨服3v3报名信息
	-- shenqi_login(sid)			--发送神器消息
	SetShenQiIcon(sid)			-- 设置神器戒指显示
	online_1v1(sid)             --玩家上线1v1
	tired_getonlinetime(sid)    --防沉迷
	v1_clearnotusedata( sid )	--清除v1不要数据

	dcard_player_online(sid) --梦幻卡派
	-- 如果玩家处于死亡状态并且不在庄园掠夺地图弹死亡UI面板
	local _,_,rid ,mapGID= CI_GetCurPos()
	if CI_GetPlayerData(25) == 0 and (rid ~= 2001 and rid ~= 512) then 	
		SendLuaMsg( 0, { ids=Dead_UI, tm = 60 }, 9 )
	end
	if mapGID and rid==1044 then --夫妻副本如果处理后还在副本强行移除
		--look('夫妻副本如果处理后还在副本强行移除',1)
		local res=PI_MovePlayer( 1, 74, 97)
		--look(res,1)
	end
	-- 测试更新玩家任务
	local taskData = GetDBTaskData(sid)
	if taskData then
		compzip(taskData)
	end	
	TS_AcceptTask(sid,4900,0)
	-- test
	--Getplayerdata_all(sid)				--统计玩家数据区大小
	donate_onlogin(sid)				-- 铜钱捐献登录处理
	--
	login_show_equip(sid)
end

-- 玩家第一次登陆时调用，进行玩家脚本数据的初始化
function OnPlayerLogin( )
	look('OnPlayerLogin',2)
	login_num = login_num + 1
	local sid = CI_GetPlayerData(17)
	if sid == nil then return end
	
	--老帮派宝石迷阵更新建筑
	bsmz_add()
	
	-- 合服数据处理
	if not IsSpanServer() then
		MergeServer_Proc(sid)
	end
	SetLoginHangUpData(sid)			-- 闭关初始化
	
	Check_vertime(sid)			-- 检测弹出更新面板
	
	--PlayerInit(sid)				-- 第一次登陆初始化数据	
	DayRefresh(1)				-- 每日重置				
	InitTaskWhenLogin(sid)		-- 任务初始化	
	World_to_Player(sid)		-- 用托管数据更新玩家托管数据
	set_extra_backup(sid)		-- 用托管备份数据更新玩家数据
	LoginResetTimes(sid)		-- 登陆初始化新加功能次数
	
	LoginCheckRide(sid)			-- 登录检查是否需要上马	
	set_last_access(sid)
	--batt_login_makeup(sid )     --法宝修改补偿20131122
	horse_login_makeup(sid)		--坐骑补偿20131122
	CityOwnerLogin(sid)			-- 城主上线公告
	bat_reset( sid,1)			-- 登陆检测女神经验值
	
	GD_SyncLandLv(sid)			-- 同步土地等级

	facskill_OnLogin(sid)	--工会技能初始化

	GI_SetScriptAttr(sid)		-- 设置脚本添加的人物属性
	vip_login_addbuff(sid)		-- vip4登陆加buff
	app_login(sid)				-- 时装登陆设置外形
	sowar_login(sid)			-- 骑兵开光及夫妻名字登陆设置外形
	SetPresIcon(sid)			-- 设置威望等级显示
	SetShenQiIcon(sid)			-- 设置神器戒指显示
	MarryDataSync(sid)			-- 上线同步离婚数据
	PushSigleList(sid,1)		-- 加入未婚列表
	db_item_out(sid ,4)			-- 大转盘次数
	set_join_factionDate(sid)	-- 判断入帮时间
	
	cc_on_player_login(sid)
	lhj_on_player_login(sid)
	look(GI_GetPlayerData(sid,'zm',32),2)
	
--	GI_GetPlayerData(sid,'gpid',12) = GetGroupID(sid);

	-- test
	-- MR_PushRank(sid)			-- 添加排位列表[can del?]
	-- Player_to_World(sid)		-- 添加到托管数据[can del?]
	-- CF_LoginOut(sid)			-- 活动暂时屏蔽
	--万恶的成就改动
	temp_achieve(sid)
	--春节活动上线处理
	online_chunjie_data(sid)
end

-- call when online player login .
-- 暂时没有处理，所有处理在OnPlayerOnline中
-- function OnPlayerReLogin( gid )
-- end

function OnPlayerLogout()
	logout_num = logout_num + 1
	--look('下线保存数据')
	local sid = CI_GetPlayerData(17)
	if sid == nil then return end
	
	SetLogoutHangUpData(sid)
	
	-- 下线同步到托管数据
	Player_to_World(sid) 
	-- 副本下线处理(包括房间处理)
	CS_OutLineProc(sid)
	-- 活动下线线统一处理接口
	activitymgr:on_logout(sid)	
			
	-- 清理全局临时数据中与该玩家相关的数据
	--CF_Leave( sid )			-- 活动暂时屏蔽：阵营战
	--FF_Leave( sid )			-- 活动暂时屏蔽：帮会战
	faction_yb_logout(sid)		-- 清理运镖状态
	GI_UpdatePlayerScore(sid)	-- 更新玩家托管数据
	setMountsLogout(sid)		-- 下线保存上下马状态
	bury_onlive( sid )			-- 下线保存埋点
	item_innumactive( sid )     -- 下线保存活动道具使用数量
	RemoveSigleList( sid )		-- 下线从未婚列表移除
	v3reg_logout( sid )			-- 下线清除跨服3v3数据
	tired_logout() 				--防沉迷
	--db_savelogouttime(sid)		--下线写db存储记录时间等
	--look('end')
end

function OnPlayerRelive( bUseItemTo , CopySceneGID )
	local sid = CI_GetPlayerData(17)
	local x, y,regionId,mapGID = CI_GetCurPos()
	--look('bUseItemTo='..bUseItemTo..',bInFB='..CopySceneGID)
	--look('regionId='..regionId..',x='..x)

	
	-- 添加死亡保护buff(玩家必须为和平模式)
	local mode = CI_GetPlayerData(8,2,sid)
	if RegionTable[regionId] and RegionTable[regionId].dbuf and mode == 0xff then
		CI_AddBuff(242,0,5,false,2,sid)		
	end
	--复活主动招家将
	HeroAutoFightForRelive(sid)

	-- 原地复活
	if bUseItemTo ~= 0 then			-- relive from dead pos.		
		local d_gid = 0
		if mapGID then
			d_gid = mapGID
		end
		if not PI_MovePlayer(regionId, x, y,d_gid)	then
			rfalse('PI_MovePlayer err when OnPlayerRelive 1')
		end
		return 1
	end
	-- goback to home.
	if CopySceneGID and CopySceneGID ~= 0 then 
		CS_ReliveProc(sid)		-- 副本复活处理
		return 1
	end
	-- active relive proc
	if activitymgr:on_playerlive(sid) == 1 then
		return 1
	end
	
	if regionId == 3 then	--新手村
		PI_MovePlayer(3, 100, 159)
		return 1
	elseif regionId == 521 then	--帮会秘境
		PI_MovePlayer(0, 28, 65,mapGID)
		return 1
	elseif regionId == 11 then	--帮会运镖
		PI_MovePlayer(11, 8, 104)
		return 1
	else 
		--rfalse('1112233')
		local num = mathrandom(1,#Define_POS)
		if not PI_MovePlayer(Define_POS[num][1],Define_POS[num][2],Define_POS[num][3]) then
			look('PI_MovePlayer err when OnPlayerRelive 3')
		end
		return 1
	end
	
	return 0 -- return 0 means relive from normal steps.
end

-- [0] 回城复活 
-- [1] 原地复活(只扣道具) 
-- [2] 原地复活(先检查道具，再检查绑定元宝，最后检查元宝)
-- [3] 原地复活(先检查复活次数，先检查道具，再检查绑定元宝，最后检查元宝)
function OnSelectRelive( playerid, stype )
	--look('OnSelectRelive=' .. tostring(stype))
	if stype == 0 then
		
	elseif stype == 1 then
		if CheckGoods( 676, 1, 0, playerid ,'复活') == 0 then
			--look("道具不足、不能复活")
			return
		end			
	elseif stype == 2 then
		if CheckGoods( 676, 1, 0, playerid,'复活' ) == 0 then
			local bdyb = GetPlayerPoints(playerid,3) or 0
			if bdyb < 50 then
				if not CheckCost( playerid, 10, 0, 1,"100019_死亡复活_"..tostring(stype)) then
					--look("钱不够不能复活")
					return
				end
			else
				AddPlayerPoints( playerid, 3, -50, nil, '100019_死亡复活_ ' .. tostring(stype), true)
			end
		end
	elseif stype == 3 then
		if not CheckTimes(playerid,TimesTypeTb.relive,1,-1) then
			if CheckGoods( 676, 1, 0, playerid,'复活' ) == 0 then
				local bdyb = GetPlayerPoints(playerid,3) or 0
				if bdyb < 50 then
					if not CheckCost( playerid, 10, 0, 1,"100019_死亡复活_"..tostring(stype)) then
						CI_OnSelectRelive(0,3*5,2,playerid)		-- 钱不够回城复活
						return
					end
				else					
					AddPlayerPoints( playerid, 3, -50, nil, '100019_死亡复活_ ' .. tostring(stype), true)
				end
			end
		end
	else
		return
	end
	CI_OnSelectRelive(stype,3*5,2,playerid)
end

function SI_OnPlayerDead(rid, mapGID, deadSID, killerSID )
	-- -- 死亡特殊处理类型
	-- if rid ~= nil and (rid == 512 or rid == 2001)  then
		-- SetEvent( 3, nil, 'OnDeadProcEx', sid, rid, mapGID )
		-- return
	-- end
	-- look('SI_OnPlayerDead',1)
	-- look(rid)
	-- look(mapGID)
	-- look(deadSID)
	-- look(killerSID)
	local sid = CI_GetPlayerData(17) 
	-- 活动管理器死亡统一接口
	if activitymgr:on_playerdead(deadSID,rid,mapGID,killerSID) == 1 then
		return
	end	
	
	 escort_playerdead(sid,killerSID) ---押镖判断 
	 HeroAutoBackFight(sid) --死亡，自动召回家将
	 faction_yb_dead(sid)			-- 帮会运镖判断
	
	-- 取杀人者信息
	local killerName,killerLv
	killerName = CI_GetPlayerData(5,2,killerSID)
	killerLv = CI_GetPlayerData(1,2,killerSID)
	
	-- 添加死亡保护buff(玩家必须为和平模式)
	if killerSID > 0 then
		--look(rid)		
		
		-- 杀人者更新PK值
		if RegionTable[rid] and RegionTable[rid].PKValue then
			AddPlayerPoints( killerSID, 9, 1, false, '杀人')	
		end
	end

	shenqi_dead_punishment(rid, deadSID, mapGID, killerSID)
	
	SendLuaMsg( 0, { ids=Dead_UI, tm = 60, kName = killerName, kLV = killerLv  }, 9 )

end

function OnPlayerLevelup(newLevel,oldLevel)
	local playerid=CI_GetPlayerData( 17 )
	-- if newLevel >= 10 then
		-- checkPlayerData(playerid,newLevel)
	-- end
	if newLevel >= 40 then
		PushSigleList(playerid)
	end
	if newLevel >= 42 then
		MRB_PushList(playerid,newLevel,oldLevel)	-- 放入登记表 目前测试没判断等级
	end
	if newLevel == 60 then
		TipCenterEx(GetStringMsg(296,CI_GetPlayerData(3),60))
	end
	if newLevel == 65 then
		TipCenterEx(GetStringMsg(296,CI_GetPlayerData(3),60))
	end
	if newLevel == 70 then
		
		TipCenterEx(GetStringMsg(296,CI_GetPlayerData(3),70))
	end
	if newLevel == 80 then
		TipCenterEx(GetStringMsg(296,CI_GetPlayerData(3),80))
	end
	if newLevel == 90 then
		TipCenterEx(GetStringMsg(296,CI_GetPlayerData(3),90))
	end
	local playerTemp = GetCurTaskTemp()
	local wAddNew = GetWorldExpAdd(CI_GetPlayerData(17))
	if playerTemp.wAdd == nil or playerTemp.wAdd ~= wAddNew then
		playerTemp.wAdd = wAddNew
		SendLuaMsg( 0, { ids=Send_Wlevel, wAdd = wAddNew }, 9 )
	end
	local lv_balance=newLevel-oldLevel	
	if lv_balance>1 then
		local num=0
		if	oldLevel%2==0 then
			num=mathfloor(lv_balance/2)
		else
			num=mathceil(lv_balance/2)
		end
		Add_Skillnum(playerid,num)
	elseif lv_balance==1 then
		if newLevel%2==0 then
			Add_Skillnum(playerid,1)
		end
	end
	db_lvup_log(playerid,newLevel)
end

function OnQuitTeam( )
end


-- 登陆设置战斗力排名称号(判断: 上线才需要广播)
function CALLBACK_GetRoleRank(sid,bonline,frank)
	--look('CALLBACK_GetRoleRank:' .. tostring(sid)..'__'..tostring(frank))
	if sid == nil or frank == nil then return end
	local br = (bonline and 0) or 1
	
	if frank == 1 then
		CI_SetPlayerIcon(0,1,2,br)
	elseif frank >= 2 and frank <= 10 then
		CI_SetPlayerIcon(0,1,3,br)
	else
		CI_SetPlayerIcon(0,1,0,br)
	end
end

function CALLBACK_GetLoginInfo(sid,rs)
	if sid == nil or rs == nil then return end
	if type(rs) == type({}) then
		SendLuaMsg( sid, { ids=Send_Login, rs = rs }, 10 )
	end
end

local function GetPlayerShenQiData(sid)
	local shqdata=GI_GetPlayerData( sid , 'shq' , 150 )
	if shqdata == nil then return end
	return shqdata
end

function SI_OnPVPDamage(enemyid, damage)
	-- look('**************SI_OnPVPDamage start******************',1)
	if enemyid == nil or damage == nil or damage < 0 then return 0 end
	-- look('damage = ' .. damage,1)
	local fixdmg = damage
	local sid = CI_GetPlayerData(17)
	local blood = CI_GetPlayerData(25)
	if sid == nil or blood == nil then return 0 end
	-- look('blood = ' .. blood)
	local shqdata_en = GetPlayerShenQiData(enemyid)
	local shqdata_se = GetPlayerShenQiData(sid)
	if shqdata_en == nil or shqdata_se == nil then return damage end
	if shqdata_en[807] == nil and shqdata_se[806] == nil and shqdata_se[807] == nil then
		return damage
	end
	
	local en_level_r  --敌人右戒等级
	local en_state_r  --敌人右戒状态
	local se_level_l  --自己左戒等级
	local se_state_l  --自己左戒状态
	local se_level_r  --自己右戒等级
	local se_state_r  --自己右戒状态
	
	if shqdata_en[807] and shqdata_en[807][2] and shqdata_en[807][3] then
		en_level_r = shqdata_en[807][2] --敌人右戒等级
		en_state_r = shqdata_en[807][3] --敌人右戒状态
	end
	if shqdata_se[806] and shqdata_se[806][2] and shqdata_se[806][3] then
		se_level_l = shqdata_se[806][2] --自己左戒等级
		se_state_l = shqdata_se[806][3] --自己左戒状态
	end
	if shqdata_se[807] and shqdata_se[807][2] and shqdata_se[807][3] then
		se_level_r = shqdata_se[807][2] --自己右戒等级
		se_state_r = shqdata_se[807][3] --自己右戒状态
	end
	
	local now = GetServerTime()
	if en_state_r and en_level_r and en_state_r == 1 and en_level_r >= 50 then
		if se_state_l and se_level_l then
			if se_state_l == 1 and se_level_l >= 50 then
				fixdmg = damage*(1 + (mathfloor(en_level_r/10)/100 - mathfloor(se_level_l/10)/100))
				if fixdmg >= blood then
					local rand_se = mathrandom(100)
					if rand_se <= 50 then
						shqdata_se.skcd = shqdata_se.skcd or {}
						if now >= (shqdata_se.skcd[2] or 0) then
							fixdmg = blood - 1
							CI_AddBuff(365,0,1,false,2,sid) -- 死神的叹息
							shqdata_se.skcd[2] = now + 600
						end
					end
				end
			else
				fixdmg = damage*(1 + (mathfloor(en_level_r/10)/100))
			end
		else
			fixdmg = damage*(1 + (mathfloor(en_level_r/10)/100))
		end
		
		local rand_en = mathrandom(100)
		if rand_en <= 10 then
			shqdata_en.skcd = shqdata_en.skcd or {}
			if now >= (shqdata_en.skcd[1] or 0) then
				if not CI_HasBuff(366,2,sid) then
					CI_AddBuff(366,0,1,false,2,sid) -- 雷神的裁决
					SetEvent(12, nil, "shenqi_buffer_end", sid)
				end
				shqdata_en.skcd[1] = now + 180
			end
		end
	else
		if se_state_l and se_level_l then
			if se_state_l == 1 and se_level_l >= 50 then
				fixdmg = damage*(1 - (mathfloor(se_level_l/10)/100))
				if fixdmg >= blood then
					local rand_se = mathrandom(100)
					if rand_se <= 50 then
						shqdata_se.skcd = shqdata_se.skcd or {}
						if now >= (shqdata_se.skcd[2] or 0) then
							fixdmg = blood - 1
							CI_AddBuff(365,0,1,false,2,sid) -- 死神的叹息
							shqdata_se.skcd[2] = now + 600
						end
					end
				end
			end
		end
	end
	if se_state_l and se_level_l and se_state_r and se_level_r then
		if se_state_l == 1 and se_level_l >= 50 and se_state_r == 1 and se_level_r >= 50 then
			local rand = mathrandom(100)
			if rand <= 10 then
				shqdata_se.skcd = shqdata_se.skcd or {}
				if now >= (shqdata_se.skcd[3] or 0) then
					CI_AddBuff(364,0,1,false,2,sid) -- 愤怒的意志
					shqdata_se.skcd[3] = now + 90
				end
			end
		end
	end
	-- look('fixdmg = ' .. mathfloor(fixdmg),1)
	-- look('**************SI_OnPVPDamage end******************',1)
	return mathfloor(fixdmg)
end

function CALLBACK_GetRinginfo(sid,val,index)
	-- look('*****************CALLBACK_GetRinginfo start******************',1)
	if sid == nil or index == nil then return end
	val = val or 0
	if index == 806 then
		if val > 10000 then
			shenqi_get_ring(sid, 1, index)
		end
	elseif index == 807 then
		if val > 20000 then
			shenqi_get_ring(sid, 1, index)
		end
	end
	-- look('*****************CALLBACK_GetRinginfo end******************',1)
end

function shenqi_buffer_end(sid)
	if sid == nil then return end
	if CI_HasBuff(366,2,sid) then
		CI_AddBuff(368,0,1,false,2,sid)
	end
end

--成就临时处理
function temp_achieve(sid)
	temp_mounts(sid)
	temp_mounts_bone(sid)
	sowar_chengjiu(sid)
	temp_wing(sid)
	temp_fskill(sid)
	skill_chengjiu(sid)
	vip_tempfun(sid)
end

--outfit_id道具id
--穿上装备
--[[
	res  为1 表示不能穿戴
		 为0 表示可以穿戴
]]
function SI_EquipItem(outfit_id)
	local res = EquipItem(outfit_id)
	return res
end
--卸下装备
--[[function SI_UnEquipItem(outfit_id)
	--local res = UnEquipItem(outfit_id)
	return 0
end]]

function SI_OnSkillEnd(skill_id)
	-- look("SI_OnSkillEnd",2)
	-- look(skill_id,2)
	
	if CI_HasBuff(260) then
		ysfs_on_attack(CI_GetPlayerData(17))
	end
end
 
--100级装备展示
function login_show_equip(sid)
	local wdata = GetWorldCustomDB()
	wdata.show_equip = wdata.show_equip or {
		index = 0,
	}
	
	if wdata.show_equip.index == 1 then 
		SendLuaMsg(0, { ids=show_equip }, 9 )
	end
end
