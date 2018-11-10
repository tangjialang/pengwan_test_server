--[[
file��	.lua
desc:	ͭǮ����
author: wjl
update: 2014-11-12
]]--
--------------------------------------------------------------------------
--include:
local look = look
local type = type
local tostring = tostring
local pairs = pairs
local __G = _G
local CI_GetPlayerData = CI_GetPlayerData
local GiveGoods = GiveGoods
local GiveGoodsBatch = GiveGoodsBatch
local TipCenter = TipCenter
local SendLuaMsg = SendLuaMsg
local BroadcastRPC=BroadcastRPC
local isFullNum = isFullNum
local GetStringMsg = GetStringMsg
local CheckCost = CheckCost
local GetServerTime = GetServerTime
local GetServerID = GetServerID
local CI_AddBuff = CI_AddBuff
local CI_DelBuff = CI_DelBuff
local CI_HasBuff = CI_HasBuff

local SetPlayerTitle = SetPlayerTitle
local SetShowTitle = SetShowTitle

local msgh_s2c_def = msgh_s2c_def
local player_donate_result = msgh_s2c_def[3][27]					-- ��Ҿ��׽��	
local player_donate_award = msgh_s2c_def[3][28]				-- �����콱���
local player_donate_rank = msgh_s2c_def[3][29]					-- ���ؾ������а���Ϣ
local player_donate_login = msgh_s2c_def[3][30]					-- ������ߴ�����ʾĳĳ��λ���ߣ�
local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist = sclist_m.insert_scorelist
local get_scorelist_data = sclist_m.get_scorelist_data
local get_score_rank = sclist_m.get_score_rank
local Log = Log

module(...)
-----------------------------------------------------------------------------------------------------

local donate_conf = {
	itype = 12,				-- ���а�����
	maxrank = 5,			-- �ɻ�ȡ�ƺŵ��������
	
	condition = {			-- ��ȡ������ͭǮ����������
		[1] = 1000000,
	},
	award = {				-- �������ã�{item,num,binding}��
		[1] = {{1586,1,1},},
	},
	title = {						-- �ƺ�����
		[1] = 67,[2] = 68,[3] = 69,[4] = 70,[5] = 71,			-- title����,titleID
	},
	buff = {					
		[1] = 261,[2] = 262,[3] = 263,[4] = 264,[5] = 265,			-- buff����,buffid
	},
}

--[[	ͭǮ�������� -- ÿ�����
	jx_data = {
		sclist = {�������а�},
		[sid] = {���վ���ͭǮ��, ����콱����}
		...
	}
--]]

-- ��ӽ���������
local function get_donate_wcdata()
	local getwc_data = __G.GetWorldCustomDB()
	if getwc_data == nil then 
		return 
	end
	if  getwc_data.jx_data == nil then
		getwc_data.jx_data = {}	
	end
	return getwc_data.jx_data
end

-- ��Ҿ�����������
local function get_player_wcdata(sid)
	local jx_data = get_donate_wcdata()
	if jx_data == nil then return end
	if jx_data[sid] == nil then
		jx_data[sid] ={}
	end
	return jx_data[sid]
end

-- ��Ҿ���ÿ������
local function get_player_day_data(sid)
	local day_data = __G.GetPlayerDayData(sid)
	if day_data == nil then return end
	if day_data.donate == nil then
		day_data.donate = {}
	end
	--[[
	data = {
		[1] = {����ͭǮ����},
		[2] = {�콱����},
		[3] = {ˢ��ʱ��},
	}
	]]
	return day_data.donate
end

-- ��Ҿ��״���
local function _player_donate(sid, money)
	if sid == nil or sid == 0 then return end
	if money == nil then return end
	if money < 10000 then return end						-- ÿ������1W
	local day_data = get_player_day_data(sid)		-- ���ÿ�վ�������
	local wc_data = get_player_wcdata(sid)				-- ��Ҿ�����������
	if day_data == nil or wc_data == nil then return end
	if not __G.CheckCost(sid,money,0,3,"����") then	-- ͭǮ�۳����
		TipCenter("ͭǮ����")
		return
	end
	wc_data[1] = (wc_data[1]	or 0	) + money	-- ������Ҿ�����������
	day_data[1] = (wc_data[1] or 0) 				-- �������ÿ�վ�������
	-- ��������ݲ������а�
	local itype = donate_conf.itype
	local name = CI_GetPlayerData(3)
	local school = CI_GetPlayerData(2)
	insert_scorelist(1,itype,30,wc_data[1],name,school,sid)
	SendLuaMsg(0,{ids = player_donate_result, wc_data[1]},9)
end

-- ��ȡ���ױ���
local function _get_donate_award(sid, idx)		-- idx �콱����
	if sid == nil or sid == 0 then return end
	local wc_data = get_player_wcdata(sid)			-- ��ȡ��Ҿ�������
	local condition = donate_conf.condition[idx]
	if wc_data == nil or wc_data[1] < condition then
		return
	end
	if idx <= (wc_data[2] or 0) then return end				-- �˽�������ȡ
	local award = donate_conf.award[idx]
	local pakagenum = isFullNum()
	if pakagenum < #award then							-- �����ж�
		TipCenter(GetStringMsg(14,#award))
		return
	end
	GiveGoodsBatch( award,"���ױ���")
	wc_data[2] = idx												-- ��������콱����
	local day_data = get_player_day_data(sid)	-- ���ÿ�վ�������
	if day_data == nil then return end
	day_data[2] = idx												-- ��������콱����
	SendLuaMsg(0,{ids = player_donate_award, idx},9)
end

-- ÿСʱ������ͭǮ��������buff
local function _clear_donate_buff(sid)
	local buffid = nil
	local titleID = nil
	for i =1, #donate_conf.buff do
		buffid = donate_conf.buff[i]
		CI_DelBuff(buffid,2,sid)						-- ֱ��ɾ���������ж�
	end	
	for i =1, #donate_conf.title do
		titleID = donate_conf.title[i]
		__G.RemovePlayerTitle(sid,titleID)						-- ֱ��ɾ���������ж�
	end
	look("������ͭǮ����buff�ͳƺ�")
end

-- ÿ��Сʱ���»�ȡ���а��ڴ�֮ǰ�ѽ�buff������ƺ�ʱ�����д��������գ�
local function _donate_rank_refresh()

	local itype = donate_conf.itype
	local donate_wcdata = get_donate_wcdata()		-- �����а���µ���������
	donate_wcdata.rtime = GetServerTime()			-- ��¼ˢ��ʱ��
	if donate_wcdata then
		donate_wcdata.sclist = donate_wcdata.sclist or {}
	end
	donate_wcdata.sclist = get_scorelist_data(1,itype)
	local scorelist = donate_wcdata.sclist
	BroadcastRPC('donate_rank',scorelist)				-- ȫ�ֹ㲥��ͬ�����а���ǰ̨
	-- �������������ҷ��ͳƺ�
	local buffid = nil 
	for i=1,donate_conf.maxrank do
		if scorelist[i] and type(scorelist[i]) == type({}) and scorelist[i][4] then
			if donate_wcdata.rank == nil then
				donate_wcdata.rank = {}
			end
			sid = scorelist[i][4]
			donate_wcdata.rank[i] = sid
			titleID = donate_conf.title[i]
			__G.SetPlayerTitle(sid,titleID,donate_wcdata.rtime + 3600)		-- ��ӳƺ�����ҳƺ��б�
			__G.SetShowTitle(sid,{titleID,0,0,0})					-- ���óƺ���ʾ					
			

			buffid = donate_conf.buff[i]
			CI_AddBuff(buffid,0,1,false,2,sid)				-- �������buff
			
			local day_data = get_player_day_data(sid)		-- �����ÿ�վ������ݼ�¼ˢ��ʱ��
			if day_data ~= nil then
				day_data[3] = donate_wcdata.rtime
			end
		end
	end

end

-- ǰ̨���������������
local function _get_donate_panel(sid)
	local day_data = get_player_day_data(sid)		-- ���ÿ�վ�������
	if day_data == nil then return end
	num = day_data[1] or 0
	idx = day_data[2] or 0
	local donate_wcdata = get_donate_wcdata()
	local scorelist = {}
	if donate_wcdata and donate_wcdata.sclist then
		scorelist = donate_wcdata.sclist
	end
	SendLuaMsg(0,{ids = player_donate_rank, sclist = scorelist, num = num, idx = idx},9)
end

-- ÿ����վ�������
local function _donate_day_clear()
	local getwc_data = __G.GetWorldCustomDB()
	if getwc_data and getwc_data.jx_data ~= nil then
		getwc_data.jx_data = nil
	end

end

-- ������ߴ�����ҳƺţ��Ϸ�ʱ������ݴ���
local function _donate_onlogin(sid)
	--look("ͭǮ����������ߴ���")
	if sid == nil or sid <= 0 then return end
	if __G.IsSpanServer() then return end		-- ��ҽ��������������
	-- �����ҽ�������������������ݶ�ʧ��˵�������˺Ϸ����������������д�벢����
	local day_data = get_player_day_data(sid)		-- ���ÿ�վ�������
	local wc_data = get_player_wcdata(sid)				-- ��Ҿ�����������
	if day_data == nil or wc_data == nil then return end
	if day_data[1] and wc_data[1] == nil then			-- �Ϸ�ʱ���д˴���
		wc_data[1] = day_data[1]									-- ��Ҿ�����������Ϊ��ʱ�������ÿ�վ�������д��(��������)
		local itype = donate_conf.itype
		local name = CI_GetPlayerData(3)
		local school = CI_GetPlayerData(2)
		local serverID = GetServerID()
		insert_scorelist(1,itype,30,wc_data[1],name,school,sid)		-- �������а�
	end
	--
	if day_data[2] and wc_data[2] == nil then			-- �Ϸ�ʱ���д˴���
		wc_data[2] = day_data[2]									-- ��Ҿ�����������Ϊ��ʱ�������ÿ�վ�������д��(�콱����)
	end
	--
	local donate_wcdata = get_donate_wcdata()		-- �����а���µ���������
	if donate_wcdata == nil or donate_wcdata.rtime == nil or donate_wcdata.sclist == nil or donate_wcdata.rank == nil then return end		-- �ж�ˢ��ʱ��

	local refresh_time = donate_wcdata.rtime 
	
	-- ���������ݼ�¼ˢ��ʱ����������ݼ�¼ˢ��ʱ����ͬ��������д���
	if day_data[3] and day_data[3] == donate_wcdata.rtime then return end			
	day_data[3] = donate_wcdata.rtime						-- ����������ݼ�¼��ˢ��ʱ��
	--�ж�����Ƿ���������
	local scorelist = donate_wcdata.sclist 
	local continue = false
	for i=1,#donate_wcdata.rank do
		if sid == donate_wcdata.rank[i] then
			continue = true
		end
	end
	if continue == false then return end
	-- ɾ�����buff(if has buff)
	local buffid = nil
	for i =1, #donate_conf.buff do						
		buffid = donate_conf.buff[i]
		--look("��ҵ�¼�����buff")
		CI_DelBuff(buffid,2,sid)									-- ֱ��ɾ���������ж�
	end
	-- �����Ҵ���ǰ������Ϊ�����ӳƺź�buff
	for i=1,donate_conf.maxrank do
		if scorelist[i] and type(scorelist[i]) == type({}) and scorelist[i][4] and sid == scorelist[i][4] then
			titleID = donate_conf.title[i]
			__G.SetPlayerTitle(sid,titleID,refresh_time + 3600)		-- ��ӳƺ�����ҳƺ��б�
			__G.SetShowTitle(sid,{titleID,0,0,0})					-- װ����ҳƺ�
			buffid = donate_conf.buff[i]
			--look("add buff buffid = " .. tostring(buffid))
			CI_AddBuff(buffid,0,1,false,2,sid)				-- �������buff
		end
	end	
end

------------------------------------------------------------------------------------------------------------------
--interface��
player_donate 			= _player_donate
get_donate_award 	=_get_donate_award
clear_donate_buff 	= _clear_donate_buff
donate_rank_refresh = _donate_rank_refresh
get_donate_panel 	= _get_donate_panel
donate_day_clear 		= _donate_day_clear
donate_onlogin 			= _donate_onlogin