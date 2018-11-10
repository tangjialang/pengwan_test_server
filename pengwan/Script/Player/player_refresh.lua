--[[
file:	player_refresh.lua
desc:	���ÿ������
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
local qzg = require('Script.qizhenge.qizhenge_fun')  --����������������
local qzg_num_clear =qzg.qzg_num_clear
local hunting_m = require('Script.Active.hunting')
local zm_day_reset = hunting_m.zm_day_reset
local fasb_m = require('Script.ShenBing.faction_func')
local fasb_reset_tpproc = fasb_m.fasb_reset_tpproc
local donate = require("Script.Player.player_donate")		-- ��Ҿ��׾�λϵͳ
local clear_donate_buff = donate.clear_donate_buff
local chunjie_module = require('Script.Active.chunjie_active')
local day_reset_cjdata = chunjie_module.day_reset_cjdata

--------------------------------------------------------------------------
-- data:

-- �����������(������ߡ������ߵ�ʱ��ÿ������ˢ��)
function GI_UpdatePlayerScore(sid)
	if sid == nil then return end
	local pLevel 	= CI_GetPlayerData(1)		-- ��ҵȼ�
	if pLevel == nil or pLevel < 30 then		-- 30����������Ҳ������а�
		return
	end
	local pName 	= CI_GetPlayerData(5)		-- �������
	local pSchool 	= CI_GetPlayerData(2)		-- ���ְҵ	
	local headID 	= CI_GetPlayerData(70)		-- ���ͷ��
	local sex 		= CI_GetPlayerData(11)		-- ����Ա�
	local pExps 	= CI_GetPlayerData(4)		-- ��ҵ�ǰ����
	local pFight 	= CI_GetPlayerData(62)		-- ���ս����
	
	local vipType 	= CI_GetPlayerIcon(0,0)		-- vip����
	local zgPoint 	= GetPlayerPoints(sid,6) or 0	-- ���ս��
	local cjPoint 	= GetPlayerPoints(sid,1) or 0	-- ��ҳɾ�	
	local swPoint 	= GetPlayerPoints(sid,7) or 0	-- �������	
	local qhlv 		= CI_GetPlayerData(38) or 0		-- װ��ǿ���ȼ���	
	local bsnum 	= CI_GetPlayerData(40) or 0		-- ��ʯ��
	local fid 		= CI_GetPlayerData(23) or 0		-- ���id
	local fname 	= CI_GetFactionInfo(fid,1)		-- �������

	local manorLv = 0						-- ɽׯ�ȼ�
	local manorExp = 0						-- ɽׯ����	
	local manorRank = 0						-- ׯ԰��λ
	local pManorData = GetManorData_Interf(sid)
	if pManorData then
		manorLv = pManorData.mLv or 0
		manorExp = pManorData.mExp or 0
		manorRank = pManorData.Rank or 0
	end
	-- ������
	local zml = 0
	local p_MLData = ML_GetPlayerData(sid)
	if p_MLData then 
		zml = p_MLData.zml or 0
	end
	-- ��ż
	local spouse = CI_GetPlayerData(69)
	-- ��λ
	local zgpos = GetPos(zgPoint) or 0
	-- ���ս����������֡�ս����
	local herosID,herosFight,herosInfo = GetHeroFPoint(sid)
	
	-- ȡ�������֡�ս����
	local MountID,MountFight = GetMountsFPoint(sid)
	local MountLV = get_mounts_lv(sid)
	-- ������
	local DefScore = YY_Getallscore(sid) or 0
	-- Ů��
	local FitFight,FitStar = BATT_Getallscore(sid)
	-- ���������ս����
	local qblv = sowar_getlv(sid) or 0
	local qbfight = sowar_getfight(sid) or 0
	-- ����ȼ���ս����
	local winglv,wingfight = wing_get_fpt(sid)
	-- װ��
	local equip = CI_GetPlayerData(14,2,sid)
	-- �ű���ϸ����
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
	exdata[1] = app_logout( sid )		-- ʱװ
	exdata[2] = marry_logour( sid)			-- ����ָ
	exdata[3] = GetPlayerShenQiData( sid)			-- ������ָ
	if table.empty(exdata) then
		exdata = nil
	end
	-- ���ô洢���̸��½�ɫ��Ϣ
	--look('update_role_info')
	update_role_info(pName,pSchool,pLevel,pExps,pFight,zgPoint,cjPoint,herosID,herosFight,MountID,MountFight,
						DefScore,FitStar,manorLv,manorExp,sid,swPoint,vipType,sex,headID,qhlv,bsnum,manorRank,
						qblv,qbfight,fid,FitFight,winglv,wingfight,equip,detail,nil,zml,spouse,zgpos,exdata,MountLV)
end

----------------------[[Player Day Refresh]]------------------------
-- --�ۼƵ�½����
-- local function add_login_day(dayData,count)
-- 	if dayData == nil then return end
	
-- 	-- ���һ����ߴ���5����0
-- 	if(dayData.dc)then
-- 		dayData.dc[1] =  ((( count > 2 ) or ( dayData.dc[1] >= 5 )) and 1 ) or ( dayData.dc[1] + 1 )
-- 		dayData.dc[2] = nil
-- 	else
-- 		dayData.dc = {1,nil}
-- 	end
	
-- end
--ÿ����������
local function clearRecord( key , now , dcount , IsNewWeek , bOnline )
	
	local playerID	= CI_GetPlayerData(17)
	local dayData 	= GetPlayerDayData(playerID)
	if dayData==nil then return end
	-- ������ʱ�䣬�����ں���������;���������ʱ��δ�����ã���ɷ�������
	dayData.ref[key] = now
	dayData.fun = nil
	dayData.donate = nil					-- ������ÿ�վ�������
	
	p_ExpFindBack(playerID,dcount)
	VIP_DayReset(playerID,dcount)			-- VIP day set
	by_reset( playerID ,dcount)				-- ��������
	checkPetTime(playerID,dcount)			-- �жϳ����Ƿ����
	-- if bOnline == nil then					-- �����������а�����
		-- GI_UpdatePlayerScore(playerID)
	-- end
	DayResetTimes(playerID)					-- ÿ�����ô���
	checkTitleTime(playerID)				-- ���ʱЧ�ԳƺŹ���ʱ��
	checkMouseEndTime(playerID)				-- ÿ���жϻû����������Ƿ����
	clearMount(playerID)					-- ÿ�������������
	lot_reset2(playerID)					-- ���߳齱����
	sc_reset_day(playerID)					-- ÿ�ջ��������
	ss_reset(playerID)						-- ÿ��������������
	--add_login_day(dayData,dcount)    		-- �ۻ���½����
	get_fight_rank(playerID,bOnline)		-- ȡս�����������óƺ�
	sctx_reset_award( playerID )			-- �������콱�������
	bury_onlive( playerID )					-- ���߱������(����ʱǿ��д��)
	resetget_serveropen( playerID )			-- ����7���콱״̬�ָ�
	login_7day_reset(playerID)
	fish_reset( playerID )					-- �������
	DTS_AutoAccept(playerID)				-- ÿ���Զ����ճ�����
	ATS_AutoClear(playerID)					-- ÿ���Զ���������ɻ����
	fshop_reset( playerID )					-- ����̵��޹�����
	sowar_reset( playerID )					-- �����������ֵ�͹��ڴ���
	set_login_fun(playerID)					-- ǩ��
	wing_reset(playerID,true)				-- ������
	--add by zhongsx in 20141117
	fasb_reset_tpproc(playerID)			-- ������ͻ�ƽ���ÿ����0
	fsb_preset( playerID )					-- Ѱ���������
	bat_reset( playerID )					-- Ů������
	MR_ClearInspire( playerID )				-- �������ֵ
	np_reset( playerID )					-- Ů������
	MarryRefresh( playerID )				-- ��������
	v3_reset( playerID )					-- ���3v3����
	spsjzc_clear_data( playerID )			-- �������ս������
	sl_fbreset( playerID )					--������������
	qzg_num_clear(playerID)                 --����������������
	
	lhj_day_reset(playerID)	--�ϻ��� �������
	kfph_player_refresh(playerID) --������а�д���������
	cc_player_day_refresh(playerID)	--������Ӹ��� �������
	dcard_dayreset(playerID) --�λÿ���ÿ��
	zm_day_reset(playerID)

	refresh_yuanshen(playerID)--Ԫ�񸱱���������
	
	refresh_worship_lv1(playerID) --���1v1Ĥ�ݴ�������
		
	day_delete_pres(playerID)				-- ��������16���Ժ�ÿ���Զ���ʧ����ֵ
	
	-- ÿ���10��PKֵ
	day_reset_cjdata(playerID)
	
	
	AddPlayerPoints( playerID, 9, -10 * dcount, false, 'ɱ��',true)

	SendLuaMsg( 0, { ids=SendDayData, time = dayData.time, fun = dayData.fun, dc = dayData.dc, cbdt = dayData.cbdt }, 9 )
	
	ClearByDay()							-- �ص�C����
	
	-- ÿ������
	if IsNewWeek then	
		look('IsNewWeek == true')
		sc_reset_week(playerID)	 			-- ÿ�ܻ��������
		CCT_WeekReset(playerID)				-- �ܻ���������
		set_player_ff_week_sign(playerID,bOnline)	-- �����ܰﹱ�����ʶ
		ClearMeiLiValue(playerID)			-- ���������
	end
	--look('ÿ���������111111')
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

-- ���ÿСʱ�ص��ű��Ľӿ�
-- Ŀǰ����: ����������а�����
function HourRefresh()
	local playerID 	= CI_GetPlayerData(17)
	if playerID == nil or playerID <= 0 then 
		return
	end
	-- �����������а�����
	GI_UpdatePlayerScore(playerID)
	-- ����������ͭǮ��������buff
	clear_donate_buff(playerID)
end