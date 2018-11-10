--[[
file:	sql_active.lua
desc:	ע���¼����ñ��¼�����ʼ����Ӫ���Ϣ
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

--��Ӫ������б�
AllActiveListConf = AllActiveListConf or {
	list = {},		-- ��Ҫ���͸�ǰ̨��
	cache = {},		-- ��̨�����
	--version = nil,
}   

-- ������
function GetHallOfFame()
	local worldRank = GetWorldRankData()
	if worldRank == nil then return end
	if worldRank.fame == nil then
		worldRank.fame = {}
	end
	return worldRank.fame
end

-- ����������
function SendHallOfFame(sid)
	local fame = GetHallOfFame()
	RPC('get_fame',fame)
end

--�����״̬����
--�����ʼ ��֪ͨǰ�� ������� ���������, ��֪ͨǰ��
-- itype == 0 ����� ~= 0 ���ʼ
--�ID	mainID,
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

-- ������Ϸ����
-- mon_award = 1,		-- ɱ�־��鱶��
--xunbao = 4,		-- Ѱ���

function SetGameEnviro(state,stype, val, View, Begin, Award, End, mainId)
	--rfalse("SetGameEnviro:" .. stype .. "__" ..  val)
	-- look('������Ϸ����',1)
	-- look(stype,1)
	if stype == 1 then
		SetEnvironment(1,val)
	elseif stype == 4 then--������Ѱ��
		--fsb_active(val,Begin,Award,End,mainID,subID)
		fsb_active(val,Begin,Award,End)
	elseif stype == 5 then--��ת��
		if state == 0 then
			Setluck_roll_mark(0)
		elseif state == 1 then
			Setluck_roll_mark(val - 1)
		end
	elseif stype == 6 then--������Ѱ��
		--fsb_active(val,Begin,Award,End,mainID,subID)
		fsb_active(val,Begin,Award,End,1)
	elseif stype == 7 then--����Ͷ��	
		jj_active(val,Begin,Award,End)
	elseif stype == 8 then--�ϻ���	
		lhj_active(val,Begin)
	elseif stype == 9 then--�λÿ���
		dcard_active(val,Begin)
	elseif stype == 10 then--�����
		qzg_active(val,Begin,Award,End)
	end
end
------------------------------------------------------------------
--inner:

-- script interface for c
-- ���»�ȡ��Ӫ�����
local function _active_version_update(version)
	-- look('_active_version_update',1)
	-- ÿ��12��ǿ��ˢ��

	if version == nil then 
		AllActiveListConf.version = nil
	end
	if version == nil or AllActiveListConf.version == nil or version ~= AllActiveListConf.version then
		-- look('����sql_active_init,��ˢ�»',1)
		active_dynamic_refresh()	-- ����sql_active_init,��ˢ�»-- ��Ӫ��б�
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

-- ��Ӫ��б�
function CALLBACK_InitActiveList(rs,version,opentime,plat,mergetime)
	--look('��Ӫ��б�',2)
	-- look(version,1)
	-- look(rs,1)
	--look(mergetime,2)
	-- �������ÿ���ʱ��
	SetServerOpenTime(opentime)
	-- �������úϷ�ʱ��
	SetServerMergeTime(mergetime)
	-- ����ƽ̨��ʶ
	setplat(plat)
	local now = GetServerTime()
	local g_active_dynamic_table = active_gettable()
	g_active_dynamic_table:set_begin( now )	
	--if AllActiveListConf.version == nil or version ~= AllActiveListConf.version then--��ʱ�����汾
		AllActiveListConf = {
			list = {},		-- ��Ҫ���͸�ǰ̨��
			cache = {},		-- ��̨�����
		}
		insert_rank_active()	--�������а�
		insert_rank_active_2()	--�������а�2
		insert_rank_active_3()	--�������а�3
		insert_merge_award()	--�Ϸ�����
		insert_merge_active()	--�Ϸ��
		insert_plat_active()	--��ƽ̨��ȼ��
		insert_kfcz_active()	--������ֵ�
		insert_kflc_active()	--�����۳�
		insert_kfeday_active()	--������ÿ�ճ�ֵ,���,����
		--insert_chunjie_active()	--���ڻ
		update_chunjie_data() --���ڻ
		--insert_51_active()      --51�
		if rs == nil then
			BroadcastRPC('Act_NoticeVer',version) 
			return
		end
		AllActiveListConf.rows = rs.rows or 0
		AllActiveListConf.count = 0
		if type(rs) == type({}) and table.empty(rs) == false then			
			for k, mainID in pairs(rs) do
				if type(k) == type(0) then
					db_active_detail(mainID,version) ---- ��Ӫ���ϸ��Ϣ
				end
			end
		else
			BroadcastRPC('Act_NoticeVer',version)
		end
	--end	
end
--look(act_getmaxnum( 55 ))
--ȡ�����а��������
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
-- ��Ӫ���ϸ��Ϣ
function CALLBACK_InitActiveConf(version,rs)
	--look('��Ӫ���ϸ��Ϣ1111')
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
					-- �����EventBuf ע���¼�
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
	-- ͨ��������ۼ��жϻ�Ƿ������� ����������֪ͨǰ̨�汾��
	if AllActiveListConf.count == AllActiveListConf.rows then
		AllActiveListConf.version = version
		AllActiveListConf.count = nil
		AllActiveListConf.rows = nil
		BroadcastRPC('Act_NoticeVer',version)		
	end	
		
end
--look(AllActiveListConf.cache[55].AwardBuf)
-- û�еڶ��������Ĺ��˵�����Ϊ�п��ܻ������ʱ����Ҫ���ô�����
-- 1�����ڷǳ�ֵ�������а�����������ȡ�ļ�ʱ���а����Դ��ֻ�����ظ��������а�Ŀǰ�Ǵ洢�����жϣ�
-- 2�������ڳ�ֵ�������а���������ظ����ɡ�ֻҪ��֤�����ʱ�������ȷ��
-- 3�����ڼ�ʱ���а����ڵ��ô洢���̿��ܻ�ʧ��������Ҫͬʱ��¼���ı�

-- ���ݿ����а�����
-- 101 ս����  102  ��ɫ�ȼ�  103 ս�� 104 ����   201 �ҽ�  301 ���� 302 ���  401 �����  
-- 402 ս������  501  ɽׯ�ȼ� 601 ����������
local sql_ranknum={
	[5]=301,
	[6]=201,
	[7]=102,
	[8]=101,
	[9]=401,		
	[10]=402,		-- Ů��
	[12]=701,
	[13]=702,
	[14]=703,
	[15]=302,		-- ���
	[16]=704,
	[17]=106,		-- ����
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
		if mainType == 3 then		-- ���а���
			if subType == 1 or subType == 2 or subType == 19 then		-- ��ֵ��
				-- rfalse(serverid)
				-- rfalse(cache[mainID].tBegin)
				-- rfalse(cache[mainID].tEnd)
				-- rfalse(val)
				-- rfalse(mainID)
				-- rfalse(key)
				local call = { dbtype = 2, sp = 'N_ActivityPayBuyRanking' , args = 8, [1] = serverid,[2] = cache[mainID].tBegin,[3] = cache[mainID].tEnd,[4] = val,[5] = 1,[6] = mainID,[7] = key,[8]=now}
				DBRPC( call )	
			elseif subType == 3 or subType == 4 then	-- ������
				local call = { dbtype = 2, sp = 'N_ActivityPayBuyRanking' , args = 8, [1] = serverid,[2] = cache[mainID].tBegin,[3] = cache[mainID].tEnd,[4] = val,[5] = 2,[6] = mainID,[7] = key,[8]=now}
				DBRPC( call )
			elseif (subType >=5 and subType <=10) or (subType >=12 and subType <=13) or subType == 15 or subType == 17  then-- �洢�������а�

				local maxnum=act_getmaxnum( mainID ) or 10
				-- look("ע�����л---------------maxnum------:" .. maxnum)
				local call = { dbtype = 2, sp = 'N_ActivityUpdateRanking' , args = 7, [1] = serverid,[2] = mainID,[3] = '',[4] = 0,[5]=sql_ranknum[subType],[6]=now,[7]=maxnum,}
				local callback = { callback = 'CALLBACK_HallOfFame',args = 4, [1] = mainID, [2] = '?8', [3] = '?9', [4] = '?10' }
				DBRPC( call, callback )
			elseif subType == 11 then					-- ����������
				local scorelist = get_scorelist_data(2,5)										
				if scorelist and table.maxn(scorelist) >=1 then					
					for rank, v in pairs(scorelist) do
						if type(rank) == type(0) and type(v) == type({}) then
							local call = { dbtype = 2, sp = 'N_ActivityUpdateRanking' , args = 7, [1] = serverid,[2] = mainID,[3] = v[2],[4] = rank,[5]=0,[6]=now,[7]=0,}
							DBRPC( call )
						end
					end
				end
			elseif subType == 14 then					-- ��λ�����а�
				local rkList = GetManorRankList()
				local maxnum = act_getmaxnum( mainID ) or 10
				if rkList and table.maxn(rkList) >=1 then
					for rank, pid in ipairs(rkList) do							
						if rank <= maxnum then
							local pname = PI_GetPlayerName(pid)		-- ��λ��ǰʮ �϶����й�
							local call = { dbtype = 2, sp = 'N_ActivityUpdateRanking' , args = 7, [1] = serverid,[2] = mainID,[3] = pname,[4] = rank,[5]=0,[6]=now,[7]=0,}
							local callback = { callback = 'CALLBACK_HallOfFame',args = 4, [1] = mainID, [2] = '?8', [3] = '?9', [4] = '?10' }
							DBRPC( call, callback )
						end
					end
				end
			elseif subType == 16 then					-- ����
				local owner_fid = getCityOwner()
				local pname = CI_GetFactionLeaderInfo(owner_fid,3)
				if type(pname) == type('') then
					local call = { dbtype = 2, sp = 'N_ActivityUpdateRanking' , args = 7, [1] = serverid,[2] = mainID,[3] = pname,[4] = 1,[5]=0,[6]=now,[7]=0,}
					local callback = { callback = 'CALLBACK_HallOfFame',args = 4, [1] = mainID, [2] = '?8', [3] = '?9', [4] = '?10' }
					DBRPC( call, callback )
				end
			elseif subType == 18 then					-- �������
				local owner_fid = getCityOwner()
				local fac_name = CI_GetFactionInfo(owner_fid,1)
				if type(fac_name) == type('') then
					local call = { dbtype = 2, sp = 'N_ActivityUpdateRanking' , args = 7, [1] = serverid,[2] = mainID,[3] = fac_name,[4] = 1,[5]=0,[6]=now,[7]=owner_fid,}					
					DBRPC( call )
				end
			end
		elseif mainType == 9 then	-- �ı���Ϸ����
			-- look('�ı���Ϸ����')
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
			-- look("������ʼ����?---------------- "..mainID)

			SetGameEnviro(args[3],subType,val, View,Begin,Award,End, mainID)
			--SetGameEnviro(subType,val,Begin,Award,End,mainID,subID)
		elseif mainType == 11 then	-- �ڳ��
			--look(args)
			--look(val)
			escort_activecall(args[3],val)			
		elseif mainType == 12 then	-- BOSS�
			dofile('cext\\dyn_drop.lua')
			DynDropTable.Boss_activecall(args[3],val)
		end
	end
end
-- iType == 0 ȡ��б�
-- iType == 1 ȡ��ϸ��Ϣ
-- iType == 2 ȡ��������
-- iType == 3 ���콱ʱ��ʾ�콱����
function Active_SendData(playerid,iType,mainID,ver)	
	-- look('ȡ��б�',1)
	-- look(iType,1)
	-- look(mainID,1)
	-- look(ver,1)
	local list = AllActiveListConf.list
	local cache = AllActiveListConf.cache
	local version = AllActiveListConf.version
	local serverid = GetGroupID()
	-- look(list)
	if iType == 0 then		-- iType == 0 ȡ��б�
		SendLuaMsg( 0, { ids = ActiveConf_InitIDS,iType = iType,conf = AllActiveListConf.list,ver = version }, 9 )
	elseif iType == 1 then	-- iType == 1 ȡ��ϸ��Ϣ		
		if cache[mainID] == nil then
			return
		end
		
		if ver == nil or ver ~= list[mainID].ver then	
			-- look('ȡ��ϸ��Ϣ222'..tostring(mainID))		
			local call = { dbtype = 201, sp = 'N_GetActiveInfo' , args = 1, [1] = mainID}
			local callback = { callback = 'CALLBACK_GetActiveInfo', args = 4, [1] = playerid,[2] = mainID,[3] = iType,[4] = "?2" }
			DBRPC( call, callback )
		end	
	elseif iType == 2 then-- iType == 2 ȡ��������
		--look('ȡ��������')
		local call = { dbtype = 0, sp = 'N_ActivityGetRankingList' , args = 4, [1] = serverid,[2] = mainID,[3] = playerid,[4] = 1,}
		DBRPC( call, { callback = 'CALLBACK_GetRankingList', args = 5, [1] = playerid,[2] = mainID,[3] = iType,[4] = "|100",[5] = "?5" } )
	elseif iType == 3 then	-- iType == 3 ���콱ʱ��ʾ�콱����
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
							if mainType == 8 then	-- ��ֵ������
								if subType == 4 or subType == 5 then	-- ÿ�ճ�ֵ����
									local dt = os.date( "*t" )
									beg_time = dt.year.."-"..dt.month.."-"..dt.day
									end_time = dt.year.."-"..dt.month.."-"..dt.day.." 23:59:59"
								end
							elseif mainType == 10 then	-- ������
								if subType == 2 or subType == 4 or subType == 6  then	-- ÿ�����
									local dt = os.date( "*t" )
									beg_time = dt.year.."-"..dt.month.."-"..dt.day
									end_time = dt.year.."-"..dt.month.."-"..dt.day.." 23:59:59"
								end
							elseif mainType == 15 then	-- ����
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
	elseif iType == 4 then	-- iType == 4 ֻ������ϸ��Ϣ ��ȡ����(��������DB��ѹ��)
		if cache[mainID] == nil then
			return
		end
		
		if ver == nil or ver ~= list[mainID].ver then
			SendLuaMsg( playerid, { ids = ActiveConf_InitIDS,iType = iType,mainID = mainID,ver = list[mainID].ver,cache = cache[mainID] }, 10 )
		end
	end
end
--���ϸ��Ϣ
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
--��������-- iType == 2 ȡ��������
function CALLBACK_GetRankingList(playerid,mainID,iType,rklist,rank)	
	-- look(mainID)
	-- look(rklist)
	-- look(rank)
	-- look('ȡ����������')
	if not IsPlayerOnline(playerid) then 
		return 
	end
	SendLuaMsg( playerid, { ids = ActiveConf_InitIDS,iType = iType,mainID = mainID,rank = rank,rklist = rklist }, 10 )
end
--�콱��¼
function CALLBACK_GetPartiNums(playerid,mainID,iType,rs)
	-- look('�콱��¼',1)
	-- look(mainID,1)
	-- look(rs,1)
	local list = AllActiveListConf.list
	local cache = AllActiveListConf.cache
	if cache[mainID] == nil then
		return
	end
	
	SendLuaMsg( playerid, { ids = ActiveConf_InitIDS, iType = iType,mainID = mainID,rs = rs }, 10 )
end

-- Ϊ�˱���ع�����̫�� ���ж�һ�ΰ���
function award_check_goods( awardInfo )	
	if nil == awardInfo or table.empty(awardInfo) then
		return true
	end

	-- ��������
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

	-- ����װ��
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

-- ������
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

-- ��Ӫ��콱
function ActiveAwardCheck(playerid,mainID,subID)
	 look('�洢�ж�',1)
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

	-- �ж��콱ʱ��
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
	-- �ж��콱����
	local ck, info = ActiveConditionConf.CheckConditions(playerid,AwardTb.con)
	if ck == 0 then
		RPC("ACT_DoAward",2)
		-- look('2222',1)
		return
	end
	-- Ϊ�˱���ع�����̫�� ���ж�һ�ΰ���
	local AwardTb_ = uv_CommonAwardTable.AwardProc(playerid,AwardTb.awd)
	--check awards ��鱳��
	local getok = award_check_items(AwardTb_,AwardTb.etc) 

	--local getok = award_check_goods(AwardTb.awd)

	if not getok then
		-- look('1111',1)
		RPC("ACT_DoAward",3)
		return		
	end
	
	-- �洢���������ж�
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
			if mainType == 3 then		-- ���а��� 
				if type(v) == type({}) then
					beg_val = v[1]
					end_val = v[2]					
				end
				if subType == 18 then	-- ������
					con_val = CI_GetPlayerData(23)
				elseif subType == 19 then	-- ��ֵ����	+ ���⽱��
					con_val = v[3]
				end
			elseif mainType == 4 then	-- �����ռ���
				beg_val = 0
				end_val = 0
			elseif mainType == 8 then	-- ��ֵ������
				if subType == 4 or subType == 5 then	-- ÿ�ճ�ֵ����
					local dt = os.date( "*t" )
					beg_time = dt.year.."-"..dt.month.."-"..dt.day
					end_time = dt.year.."-"..dt.month.."-"..dt.day.." 23:59:59"
				end
			elseif mainType == 10 then	-- ������
				if subType == 2 or subType == 4 or subType == 6  then	-- ÿ�ջ�Ծ��/ƽ̨��ש
					local dt = os.date( "*t" )
					beg_time = dt.year.."-"..dt.month.."-"..dt.day
					end_time = dt.year.."-"..dt.month.."-"..dt.day.." 23:59:59"
				end
			elseif mainType == 14 then	-- �Ϸ��
				end_val = GetServerOpenTime()
			elseif mainType == 15 then	-- ������
				
				local dt = os.date( "*t" )
				beg_time = dt.year.."-"..dt.month.."-"..dt.day
				end_time = dt.year.."-"..dt.month.."-"..dt.day.." 23:59:59"
			elseif mainType == 19 then	-- ����������
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
	if AwardTb.con[1601]~=nil then --�޹����⴦��,����ȫ��������
		beg_val=AwardTb.con[1601]
	elseif AwardTb.con[1701]~=nil then --�޹����⴦��,����ȫ��������
		beg_val=AwardTb.con[1701]
		end_val=AwardTb.con[1702]
	end
	-- look('��ʼ�콱',1)
	local call = { dbtype = 0, sp = 'N_ActivityParticipate' , args=14, [1]=serverid,[2]=account,[3]=playerid,[4]=mainID,
						[5]=subID,[6]=stype,[7]=beg_time,[8]= end_time,[9]=awd_time,[10]=AwardTb.num,[11]=beg_val,[12]=end_val,[13]=con_val,[14]=GetServerTime()}
						
	local callback = { callback = 'CALLBACK_ActiveCheck', args = 5, [1] = playerid,[2] = mainID,[3] = subID,[4] = "?15",[5]="?16" }
	DBRPC( call, callback )	
	
end

function CALLBACK_ActiveCheck(playerid,mainID,subID,check,num)
	--look('�콱���',1)
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
	--check awards ��鱳��
	local getok = award_check_items(AwardTb_,AwardTb.etc) 		
	if not getok then
		RPC("ACT_DoAward",3)
		-- �ع���¼
		local call = { dbtype = 0, sp = 'N_ActivityPartRollback' , args = 1, [1] = num}			
		DBRPC( call )
		return
	end		

	-- -- �ٴ��жϰ���
	-- local getok = award_check_goods(AwardTb.awd)
	-- if not getok then
	-- 	RPC("ACT_DoAward",3)
	-- 	-- �ع���¼
	-- 	local call = { dbtype = 0, sp = 'N_ActivityPartRollback' , args = 1, [1] = num}			
	-- 	DBRPC( call )
	-- 	return
	-- end
	
	-- ����ſ۳�����
	local ck, info = ActiveConditionConf.CheckConditions(playerid,AwardTb.con,1)
	if ck == 0 then
		RPC("ACT_DoAward",2)
		-- �ع���¼
		local call = { dbtype = 0, sp = 'N_ActivityPartRollback' , args = 1, [1] = num}			
		DBRPC( call )
		return
	end
	
	if AwardTb.con[1603]~=nil then
		if not  CheckCost( playerid , AwardTb.con[1603] , 0 , 1, "�޹�") then
			return 
		end
	end
	-- ������
	local _,retCode = GI_GiveAward(playerid,AwardTb_,"��Ӫ�����[" .. tostring(mainID) .. "]__[" .. tostring(subID) .. "]")
	-- ���⽱���ж�
	if check == 2 and AwardTb.etc then
		ActiveExtraAward(playerid,mainID,subID,AwardTb.etc)
	end
	RPC("ACT_DoAward",0,mainID,subID)
	-- look(mainID,1)
	-- look(subID,1)
end

-- ����⽱��
function ActiveExtraAward(playerid,mainID,subID,etc)
	if playerid == nil or mainID == nil or subID == nil or etc == nil then return end
	local _,retCode = GI_GiveAward(playerid,etc,"��Ӫ�����[" .. tostring(mainID) .. "]__[" .. tostring(subID) .. "]")
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


--ȡ�ô���ʱ����ڳ�ֵ������Ϣ[itype=1Ϊ��ֵ��Ϣ��2Ϊ������Ϣ,3ÿ�ճ�ֵ,4Ϊÿ��������Ϣ,5��ʷ�ܳ�ֵ,6ÿ�ճ�ֵ(ÿ���׳�)]
function Getbuyfillinfo(sid,begintime,endtime,itype)
	if sid==nil or begintime==nil or endtime==nil or itype==nil then return end
	local serverid = GetGroupID()
	local call
	if itype==1 or itype==3 or itype == 6 then --��ֵ
		 call = { dbtype = 2, sp = 'N_ActivityPayBuyPoint' , args = 5, [1] = sid,[2] = serverid,[3] = begintime,[4] = endtime,[5]=1}
	elseif itype==2 or itype==4 then --����
		 call = { dbtype = 2, sp = 'N_ActivityPayBuyPoint' , args = 5, [1] = sid,[2] = serverid,[3] = begintime,[4] = endtime,[5]=2}
	else
		return
	end
	local callback = { callback = 'CALLBACK_Getbuyfillinfo', args = 5, [1] = sid,[2] = itype,[3] = "?6",[4] = begintime, [5] = endtime }
	DBRPC( call, callback )
end

-- ����а���Ϣ
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

-- ȡ���ע��ʱ��(��һ�ε�¼)
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

---ȡʱ����ڵ��ʳ�ֵ��¼,�id,��ʼʱ��,����ʱ��--���ʳ�ֵ������С���
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
--ȡ��ֵ�ص�
function CALLBACK_act_getsolochongzhi(sid,rs)
	-- look(rs,1)
	RPC('a_chongzhi',rs)
end
-------------------------------------------------------
--interface:

active_version_update = _active_version_update
active_version_check = _active_version_check
active_notice_web = _active_notice_web

