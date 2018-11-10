--[[
file:	player_refresh.lua
desc:	玩家每日重置
author:	csj
]]--
--------------------------------------------------------------------------
--include:
local pairs,type = pairs,type
local ipairs = ipairs
local SendDayData = msgh_s2c_def[3][14]
local uv_TimesTypeTb = TimesTypeTb
local CI_GetPlayerData,GetServerTime = CI_GetPlayerData,GetServerTime
local common_time = require('Script.common.time_cnt')
local IsNewWeekDetail = common_time.IsNewWeekDetail
local GetDiffDayEx = common_time.GetDiffDayEx
local db_module = require('Script.cext.dbrpc')
local update_role_info = db_module.update_role_info
local get_fight_rank = db_module.get_fight_rank
local SendLuaMsg = SendLuaMsg
local faction_monster = require('Script.active.faction_monster')
local ss_reset=faction_monster.ss_reset
local catch_fish 		= require('Script.active.catch_fish')
local fish_reset = catch_fish.fish_reset
local day_delete_pres = day_delete_pres
local shq_m = require('Script.ShenQi.shenqi_func')
local GetPlayerShenQiData = shq_m.GetPlayerShenQiData
local qzg = require('Script.qizhenge.qizhenge_fun')  --奇珍阁玩家数据重置
local qzg_num_clear =qzg.qzg_num_clear
local hunting_m = require('Script.Active.hunting')
local zm_day_reset = hunting_m.zm_day_reset
local fasb_m = require('Script.ShenBing.faction_func')
local fasb_reset_tpproc = fasb_m.fasb_reset_tpproc
local donate = require("Script.Player.player_donate")		-- 玩家捐献爵位系统
local clear_donate_buff = donate.clear_donate_buff
local chunjie_module = require('Script.Active.chunjie_active')
local day_reset_cjdata = chunjie_module.day_reset_cjdata

--------------------------------------------------------------------------
-- data:

-- 更新玩家数据(玩家下线、及在线的时候每日重置刷新)
function GI_UpdatePlayerScore(sid)
	if sid == nil then return end
	local pLevel 	= CI_GetPlayerData(1)		-- 玩家等级
	if pLevel == nil or pLevel < 30 then		-- 30级及以上玩家才有排行榜
		return
	end
	local pName 	= CI_GetPlayerData(5)		-- 玩家名字
	local pSchool 	= CI_GetPlayerData(2)		-- 玩家职业	
	local headID 	= CI_GetPlayerData(70)		-- 玩家头像
	local sex 		= CI_GetPlayerData(11)		-- 玩家性别
	local pExps 	= CI_GetPlayerData(4)		-- 玩家当前经验
	local pFight 	= CI_GetPlayerData(62)		-- 玩家战斗力
	
	local vipType 	= CI_GetPlayerIcon(0,0)		-- vip类型
	local zgPoint 	= GetPlayerPoints(sid,6) or 0	-- 玩家战功
	local cjPoint 	= GetPlayerPoints(sid,1) or 0	-- 玩家成就	
	local swPoint 	= GetPlayerPoints(sid,7) or 0	-- 玩家声望	
	local qhlv 		= CI_GetPlayerData(38) or 0		-- 装备强化等级和	
	local bsnum 	= CI_GetPlayerData(40) or 0		-- 宝石和
	local fid 		= CI_GetPlayerData(23) or 0		-- 帮会id
	local fname 	= CI_GetFactionInfo(fid,1)		-- 帮会名字

	local manorLv = 0						-- 山庄等级
	local manorExp = 0						-- 山庄经验	
	local manorRank = 0						-- 庄园排位
	local pManorData = GetManorData_Interf(sid)
	if pManorData then
		manorLv = pManorData.mLv or 0
		manorExp = pManorData.mExp or 0
		manorRank = pManorData.Rank or 0
	end
	-- 周魅力
	local zml = 0
	local p_MLData = ML_GetPlayerData(sid)
	if p_MLData then 
		zml = p_MLData.zml or 0
	end
	-- 配偶
	local spouse = CI_GetPlayerData(69)
	-- 爵位
	local zgpos = GetPos(zgPoint) or 0
	-- 最高战斗力随从名字、战斗力
	local herosID,herosFight,herosInfo = GetHeroFPoint(sid)
	
	-- 取坐骑名字、战斗力
	local MountID,MountFight = GetMountsFPoint(sid)
	local MountLV = get_mounts_lv(sid)
	-- 护身法宝
	local DefScore = YY_Getallscore(sid) or 0
	-- 女神
	local FitFight,FitStar = BATT_Getallscore(sid)
	-- 骑兵阶数、战斗力
	local qblv = sowar_getlv(sid) or 0
	local qbfight = sowar_getfight(sid) or 0
	-- 神翼等级、战斗力
	local winglv,wingfight = wing_get_fpt(sid)
	-- 装备
	local equip = CI_GetPlayerData(14,2,sid)
	-- 脚本详细数据
	local detail = {}
	detail[1] = GetDBBATTGEMData(sid)
	detail[2] = sowar_getdata(sid)
	detail[3] = wing_get_other_date(sid,nil,nil,1)
	detail[4] = SendMouseData(sid,nil,nil,nil,1)
	detail[5] = herosInfo
	if table.empty(detail) then
		detail = nil
	end
	local exdata = {}
	exdata[1] = app_logout( sid )		-- 时装
	exdata[2] = marry_logour( sid)			-- 结婚戒指
	exdata[3] = GetPlayerShenQiData( sid)			-- 神器戒指
	if table.empty(exdata) then
		exdata = nil
	end
	-- 调用存储过程更新角色信息
	--look('update_role_info')
	update_role_info(pName,pSchool,pLevel,pExps,pFight,zgPoint,cjPoint,herosID,herosFight,MountID,MountFight,
						DefScore,FitStar,manorLv,manorExp,sid,swPoint,vipType,sex,headID,qhlv,bsnum,manorRank,
						qblv,qbfight,fid,FitFight,winglv,wingfight,equip,detail,nil,zml,spouse,zgpos,exdata,MountLV)
end

----------------------[[Player Day Refresh]]------------------------
-- --累计登陆天数
-- local function add_login_day(dayData,count)
-- 	if dayData == nil then return end
	
-- 	-- 间隔一天或者大于5天清0
-- 	if(dayData.dc)then
-- 		dayData.dc[1] =  ((( count > 2 ) or ( dayData.dc[1] >= 5 )) and 1 ) or ( dayData.dc[1] + 1 )
-- 		dayData.dc[2] = nil
-- 	else
-- 		dayData.dc = {1,nil}
-- 	end
	
-- end
--每日重置内容
local function clearRecord( key , now , dcount , IsNewWeek , bOnline )
	
	local playerID	= CI_GetPlayerData(17)
	local dayData 	= GetPlayerDayData(playerID)
	if dayData==nil then return end
	-- 先重置时间，避免在后续重置中途出错而导致时间未被重置，造成反复重置
	dayData.ref[key] = now
	dayData.fun = nil
	dayData.donate = nil					-- 清空玩家每日捐献数据
	
	p_ExpFindBack(playerID,dcount)
	VIP_DayReset(playerID,dcount)			-- VIP day set
	by_reset( playerID ,dcount)				-- 包月设置
	checkPetTime(playerID,dcount)			-- 判断宠物是否过期
	-- if bOnline == nil then					-- 更新生成排行榜数据
		-- GI_UpdatePlayerScore(playerID)
	-- end
	DayResetTimes(playerID)					-- 每日重置次数
	checkTitleTime(playerID)				-- 检查时效性称号过期时间
	checkMouseEndTime(playerID)				-- 每日判断幻化特殊坐骑是否过期
	clearMount(playerID)					-- 每日坐骑清除数据
	lot_reset2(playerID)					-- 在线抽奖清零
	sc_reset_day(playerID)					-- 每日活动积分数据
	ss_reset(playerID)						-- 每日神兽数据清零
	--add_login_day(dayData,dcount)    		-- 累积登陆天数
	get_fight_rank(playerID,bOnline)		-- 取战斗力排名设置称号
	sctx_reset_award( playerID )			-- 神创天下领奖数据清空
	bury_onlive( playerID )					-- 下线保存埋点(重置时强行写入)
	resetget_serveropen( playerID )			-- 开服7日领奖状态恢复
	login_7day_reset(playerID)
	fish_reset( playerID )					-- 捕鱼积分
	DTS_AutoAccept(playerID)				-- 每天自动接日常任务
	ATS_AutoClear(playerID)					-- 每天自动清理已完成活动任务
	fshop_reset( playerID )					-- 帮会商店限购重置
	sowar_reset( playerID )					-- 骑兵清理幸运值和过期处理
	set_login_fun(playerID)					-- 签到
	wing_reset(playerID,true)				-- 翅膀更新
	--add by zhongsx in 20141117
	fasb_reset_tpproc(playerID)			-- 帮会神兵突破进度每日清0
	fsb_preset( playerID )					-- 寻宝积分清空
	bat_reset( playerID )					-- 女神重置
	MR_ClearInspire( playerID )				-- 清理鼓舞值
	np_reset( playerID )					-- 女仆重置
	MarryRefresh( playerID )				-- 婚姻重置
	v3_reset( playerID )					-- 跨服3v3重置
	spsjzc_clear_data( playerID )			-- 跨服三界战场重置
	sl_fbreset( playerID )					--试炼副本重置
	qzg_num_clear(playerID)                 --奇珍阁玩家数据重置
	
	lhj_day_reset(playerID)	--老虎机 玩家重置
	kfph_player_refresh(playerID) --跨服排行榜写入玩家数据
	cc_player_day_refresh(playerID)	--夫妻组队副本 玩家重置
	dcard_dayreset(playerID) --梦幻卡牌每日
	zm_day_reset(playerID)

	refresh_yuanshen(playerID)--元神副本次数重置
	
	refresh_worship_lv1(playerID) --跨服1v1膜拜次数重置
		
	day_delete_pres(playerID)				-- 威望级别16级以后，每日自动损失威望值
	
	-- 每天减10点PK值
	day_reset_cjdata(playerID)
	
	
	AddPlayerPoints( playerID, 9, -10 * dcount, false, '杀人',true)

	SendLuaMsg( 0, { ids=SendDayData, time = dayData.time, fun = dayData.fun, dc = dayData.dc, cbdt = dayData.cbdt }, 9 )
	
	ClearByDay()							-- 回调C重置
	
	-- 每周重置
	if IsNewWeek then	
		look('IsNewWeek == true')
		sc_reset_week(playerID)	 			-- 每周活动积分数据
		CCT_WeekReset(playerID)				-- 跑环任务重置
		set_player_ff_week_sign(playerID,bOnline)	-- 设置周帮贡清除标识
		ClearMeiLiValue(playerID)			-- 清除周魅力
	end
	--look('每日重置完成111111')
end

--:Refresh Day data of player.
function DayRefresh(bOnline)
	local playerID 	= CI_GetPlayerData(17)
	local dayData 	= GetPlayerDayData(playerID)
	if dayData == nil then return end
	
	dayData.ref = dayData.ref or {}
	
	local now = GetServerTime()
	
	local dcount,newWeek = 0,false
	if dayData.ref.day then
		dcount 	= GetDiffDayEx(dayData.ref.day, now, 0, 0 )
		newWeek = IsNewWeekDetail(now, dayData.ref.day, 1, 0, 0, 0, 1)
	end
	if dayData.ref.day == nil or dcount > 0 then		
		clearRecord( "day" , now , dcount , newWeek , bOnline )
		set_login_time_last(playerID)
	else
		set_login_time_last(playerID,1)
	end

	return true
end

-- 玩家每小时回调脚本的接口
-- 目前用于: 更新玩家排行榜数据
function HourRefresh()
	local playerID 	= CI_GetPlayerData(17)
	if playerID == nil or playerID <= 0 then 
		return
	end
	-- 更新生成排行榜数据
	GI_UpdatePlayerScore(playerID)
	-- 清除所用玩家铜钱捐献所获buff
	clear_donate_buff(playerID)
end