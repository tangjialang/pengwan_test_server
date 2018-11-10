--[[
file��	xtg.lua
desc:	�����
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
local GetWorldCustomDB = GetWorldCustomDB
local CI_GetPlayerData = CI_GetPlayerData
local GiveGoods = GiveGoods
local get_join_factiontime = get_join_factiontime
local GetServerTime = GetServerTime
local TipCenter = TipCenter
local SendLuaMsg = SendLuaMsg
local TimesTypeTb = TimesTypeTb
local GetTimesInfo = GetTimesInfo
local isFullNum = isFullNum
local RPCEx = RPCEx
local FactionRPC = FactionRPC
local GetStringMsg = GetStringMsg
local GetFactionBootData = GetFactionBootData
local msgh_s2c_def = msgh_s2c_def
local cs_xtg_panel = msgh_s2c_def[4][14]					-- ������������
local cs_xtg_award_result = msgh_s2c_def[4][15]		-- ������콱���
local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist = sclist_m.insert_scorelist
local get_scorelist_data = sclist_m.get_scorelist_data
module(...)
-----------------------------------------------------------------------------------------------------

--[[	��������� -- ÿ�����
	-- ����������������������գ����������������һ��
	xtg_data = {
		[1] = {		--	�������
			[fid] = {
				kill = ���ɱ������,
				[sid] = {����ɱ������,��Ұ�ά������ȡ����}
				......
			}
		}
		[2] = {
			[sid] = {����ɱ������,��Ұ�ά������ȡ����}
		}
	}
--]]

--��ӽ���������
local function get_xtg_data(idx)		-- idx = 1 �������	idx = 2 ��������
	local getwc_data = GetWorldCustomDB()
	if getwc_data == nil then 
		return 
	end
	if  getwc_data.xtg_data == nil then
		getwc_data.xtg_data = {}		
	end
	if  getwc_data.xtg_data[idx] == nil then
		getwc_data.xtg_data[idx] = {}					--�������(������һ���������)
	end
	return getwc_data.xtg_data[idx]
end

--�����������
local function _xtg_faction_data(fid)
	local xtg_data = get_xtg_data(1)
	if xtg_data[fid] == nil then
		xtg_data[fid] = {}					
	end
	look("��ȡ�������-- _xtg_faction_data")
	return xtg_data[fid]	
end

--�����������ݣ������ڰ�����ݴ��ڣ�
local function _xtg_player_data(sid)
	local xtg_data = get_xtg_data(2)
	if xtg_data[sid] == nil then
		xtg_data[sid] = {}					
	end
	look("��ȡ�������--_xtg_player_dat")
	return xtg_data[sid]	
end
	
--������������е��������
local function _xtg_faction_player_data(sid)
	local fid = CI_GetPlayerData(23,2,sid)	
	--��᲻����
	if fid == nil or fid == 0 then
		return	
	end
	local faction_data = _xtg_faction_data(fid)
	--������ݲ�����
	if faction_data == nil then
		return				
	end
	if faction_data[sid] == nil then
		faction_data[sid] = {}
	end
	look("��ȡ����������--_xtg_faction_player_data")
	return faction_data[sid]
end

-- ����󵥴θ�������
local function _xtg_getplayerdata(playerid)
	local csdata=__G.CS_GetPlayerTemp(playerid)
	if csdata==nil then return end
	if csdata.xtg==nil then 
		csdata.xtg={}
		--[[
			[1] = ɱ����
		]]
	end
	return csdata.xtg
end

-- �����������������/��ᵱ��ɱ������
local function _xtg_data_deal(sid)
	-- look("ɱ����������-----------------------1")
	local cs_xtg_data = xtg_getplayerdata(sid)
	if cs_xtg_data == nil or cs_xtg_data[1] == nil or cs_xtg_data[1] == 0 then return end
	local increace_num = cs_xtg_data[1]									-- ����ɱ������
	cs_xtg_data[1] = 0																-- �����ɱ����������
	-- look("ɱ����������-----------------------2")
	local data = xtg_player_data(sid)									-- ��Ҹ������ݣ������ڰ�����ݣ�
	if data ~= nil then
		data[1] = (data[1] or 0) + increace_num
		-- look("data[1] = " .. tostring(data[1]))
	end
	local pf_data = _xtg_faction_player_data(sid)								-- ��ȡ������ݣ������ڰ�������У�
	if pf_data == nil then return end
	if ( increace_num == nil ) or ( increace_num == 0 ) then return end
	local fid = CI_GetPlayerData(23,2,sid)	
	--��᲻����
	if fid == nil or fid == 0 then
		return	
	end
	look("fid = " .. tostring(fid))
	local fac_data = _xtg_faction_data(fid)
	if fac_data == nil then return end
	-- look("fac_data.kill = " .. tostring(fac_data.kill))
	-- look("increace_num = " .. tostring(increace_num))
	look("ɱ����������-----------------------3")
	look("����ǰ pf_data[1] = " .. tostring(pf_data[1]))
	look(fac_data)
	look("����ǰ fac_data.kill = " .. tostring(fac_data.kill))
	fac_data.kill = (fac_data.kill or 0)+ increace_num						-- ����������������°��ɱ������
	pf_data[1] = (pf_data[1] or 0) + increace_num							-- ����������������¸���ɱ������
	look("increace_num = " .. tostring(increace_num))
	look("data[1] = " .. tostring(data[1]))
	look("�����  pf_data[1] = " .. tostring(pf_data[1]))
	look("�����  fac_data.kill= " .. tostring(fac_data.kill))
	look("ɱ����������-----------------------4")
	-- �������а�
	local itype = 200000000 + fid																--�������а�itype, ����� + fid
	local name = CI_GetPlayerData(5,2,sid)
	local school = CI_GetPlayerData(2,2,sid)
	insert_scorelist(1,itype,10,pf_data[1],name,school,sid)
	FactionRPC(fid,'xtg_gang',fac_data.kill, pf_data[1])														-- ͬ�����ɱ�ֺ͸���ɱ����ǰ̨
end

-- �������������
local function _clear_xtg_data()
	look("�������������---------------------------------------------------1")
	local getwc_data = GetWorldCustomDB()
	if getwc_data == nil then 
		return 
	end
	if  getwc_data.xtg_data ~= nil then
		getwc_data.xtg_data = nil	
	end
	look("�������������---------------------------------------------------2")
end

-- ����������������	-- GM������
local function _clear_player_data(sid)
	look("����������������")
	local data = xtg_player_data(sid)									-- ��Ҹ������ݣ������ڰ�����ݣ�
	if data ~= nil then
		data[1] = nil
		data[2] = nil
	end
end

-- ��ȡ��һ�ɱ������ɱ�����������
local function xtg_data_request(sid)
	-- look("xtg_data_request-----------------------------------------------1")
	if sid == nil or sid == 0 then return end
	local data = xtg_player_data(sid)	
	-- look("xtg_data_request-----------------------------------------------2")
	if data == nil then return end
	local player_kill = data[1] or 0						-- ����ɱ������
	-- look("xtg_data_request-----------------------------------------------3")
	local fid = CI_GetPlayerData(23,2,sid)	
	--��᲻����
	if fid == nil or fid == 0 then return	end
	-- look("xtg_data_request-----------------------------------------------4")
	local fkill_data = _xtg_faction_data(fid)
	if fkill_data  == nil then return end
	-- look("xtg_data_request-----------------------------------------------5")
	local faction_kill = fkill_data.kill or 0				-- ���ɱ������
	local itype = 200000000 + fid									--�������а�itype, ����� + fid
	local sclist = get_scorelist_data(1,itype)					--�������
	local player_idx = data[2] or 0					--��������ȡ��������
	local player_data = _xtg_faction_player_data(sid)
	local faction_idx = player_data[2] or 0
	-- look("player_kill = " .. tostring(player_kill))
	-- look("faction_kill = " .. tostring(faction_kill))
	-- look(sclist)
	-- look("player_idx = " .. tostring(player_idx))
	-- look("faction_idx = " .. tostring(faction_idx))
	return player_kill,faction_kill, sclist, player_idx, faction_idx
end

-- ��ȡ������������(���˻�ɱ������ɱ������ͭǮ)
local function _get_xtg_panel(sid)
	local player_kill, faction_kill, sclist,player_idx, faction_idx= xtg_data_request(sid)
	look("player_kill = " .. tostring(player_kill))
	look("faction_kill = " .. tostring(faction_kill))
	look(sclist)
	local res = SendLuaMsg( 0, { ids = cs_xtg_panel, player_kill, faction_kill, sclist,player_idx, faction_idx}, 9)
	look("res = " .. tostring(res))
end

-- ��¼���ɱ��������ͬ����ǰ̨
local function _refresh_xtg_player_data(sid)
	if sid ~= nil then
		-- ������������ɱ������
		local cs_xtg_data = _xtg_getplayerdata(sid)
		if cs_xtg_data ~= nil then
			cs_xtg_data[1] = (cs_xtg_data[1] or 0) + 1
			RPCEx(sid,'xtg_num',cs_xtg_data[1])				-- ��ǰ̨ͬ��ɱ������
			look("cs_xtg_data[1] = " .. tostring(cs_xtg_data[1]))
		end
	end
end

-- ɱ����������
local xtg_conf = { 	--[1] ����  [2] ���
	condition = {		-- �콱����
		[1] = 1000,	
		[2] = 30000,
	},
	Award = {
		[1] = 30,
		[2] = 20,
	}
}

-- ������콱 itype 1 ���� 2 ���
local function _get_xtg_award(sid, itype, idx)
	if sid == nil or sid == 0 then return end
	if idx == nil or idx > 30 then return end
	local num
	if itype == 1 then
		-- �ж��Ƿ������콱����
		local data = xtg_player_data(sid)	
		if data == nil then return end
		local player_kill = data[1] or 0		-- ���˻�ɱ
		if player_kill < xtg_conf.condition[itype] * idx then
			TipCenter("����ɱ������δ�ﵽ�콱����")
			return
		end
		num = xtg_conf.Award[itype] * idx
		if type(Award) == type({}) then
			local pakagenum = isFullNum()
			if pakagenum < #Award then
				TipCenter(GetStringMsg(14,#Award))
				return
			end
		end
		local old_idx = data[2] or 0
		if  idx<= old_idx then
			TipCenter("������ȡ���˽���")
		end
		GiveGoods(1585,num,1,"�������˽�����ȡ")
		look("�����콱����= " .. tostring(idx))
		data[2] = idx					-- 	������Ҹ��˽�������ȡ����
		SendLuaMsg(0,{ids = cs_xtg_award_result, itype = itype, idx = idx},9)
	elseif itype == 2 then
		-- �ж��Ƿ������콱����
		local fid = CI_GetPlayerData(23,2,sid)	
		--��᲻����
		if fid == nil or fid == 0 then
			TipCenter("����û�м�����")
			return
		end
		-- �ж����ʱ��
		local jointime= __G.get_join_factiontime(sid)
		if jointime==nil or GetServerTime()-jointime<24*3600 then
			TipCenter("���ʱ�䲻��24Сʱ��������ȡ����")
			return 
		end
		-- �ж������Ƿ���ȷ
		local player_data = _xtg_faction_player_data(sid)
		if player_data == nil then return end
		local old_idx = player_data[2] or 0
		if  idx<= old_idx then
			TipCenter("������ȡ���˽���")
		end
		local fac_data = _xtg_faction_data(fid)
		if fac_data == nil then return end
		local faction_kill = fac_data.kill or 0	-- ����������������°��ɱ������
		look("faction_kill = " .. tostring(faction_kill))
		if faction_kill < xtg_conf.condition[itype] * idx then
			TipCenter("���ɱ������δ�ﵽ�콱����")
			return
		end
		num = xtg_conf.Award[itype] * idx
		if type(Award) == type({}) then
			local pakagenum = isFullNum()
			if pakagenum < #Award then
				TipCenter(GetStringMsg(14,#Award))
				return
			end
		end
		GiveGoods(1585,num,1,"������ά����ȡ")
		look("����콱���� = " .. tostring(idx))
		SendLuaMsg(0,{ids = cs_xtg_award_result, itype = itype, idx = idx},9)
		player_data[2] = idx		-- 	������Ұ�ά������ȡ����
		look("������ά����ȡ�ɹ�")
	end
end

-- GM�����ɱ�ָ���
local function _GM_add_kills(sid, num)
	look("num ========== " .. tostring(num))
	local data = xtg_player_data(sid)									-- ��Ҹ������ݣ������ڰ�����ݣ�
	if data ~= nil then
		look("data[1] before add = " .. tostring(data[1]))
		data[1] = (data[1] or 0) + num
		look("data[1] after add = " .. tostring(data[1]))
	end
	local pf_data = _xtg_faction_player_data(sid)								-- ��ȡ������ݣ������ڰ�������У�
	if pf_data == nil then return end
	look("pf_data[1] before add = " .. tostring(pf_data[1]))
	pf_data[1] = (pf_data[1] or 0) + num							-- ����������������¸���ɱ������
	look("pf_data[1] after add = " .. tostring(pf_data[1]))
	local fid = CI_GetPlayerData(23,2,sid)	
	local fac_data = _xtg_faction_data(fid)
	if fac_data == nil then return end
	look("fac_data.kill before add = " .. tostring(fac_data.kill))
	fac_data.kill = (fac_data.kill or 0)+ num						-- ����������������°��ɱ������
	look("fac_data.kill after add = " .. tostring(fac_data.kill))
	local itype = 200000000 + fid																--�������а�itype, ����� + fid
	local name = CI_GetPlayerData(5,2,sid)
	local school = CI_GetPlayerData(2,2,sid)
	insert_scorelist(1,itype,10,pf_data[1],name,school,sid)
end


-- ������ߣ�ͬ���������Ϣ��ǰ̨
-- ������ɱ�����������ɱ����������ǰ���콱���������ˡ���ᣩ�������ǰ�ȼ������׽��ȡ�ͻ�ƽ��ȣ�
--[[
local function _xtg_online(sid)
	look("-------------------------------------------------------------------xtg_online")
	local player_kill,faction_kill, sclist, player_idx, faction_idx = xtg_data_request(sid)
	-- look("player_kill = " .. tostring(player_kill))
	-- look("faction_kill = " .. tostring(faction_kill))
	-- look("player_idx = " .. tostring(player_idx))
	-- look("faction_idx = " .. tostring(faction_idx))
	RPCEx(sid,'xtg_online',player_kill, faction_kill, sclist,player_idx, faction_idx)
	-- look("res = " .. tostring(res))
	-- look(sclist)
	look("-------------------------------------------------------------------xtg_online")
end
--]]
--------------------------------------------------------------------------------------------------------
--interface:
xtg_faction_data 	= _xtg_faction_data
xtg_player_data 	= _xtg_player_data
xtg_faction_player_data 	= _xtg_faction_player_data
xtg_data_deal 		= _xtg_data_deal
get_xtg_panel 		= _get_xtg_panel
get_xtg_award 	= _get_xtg_award
xtg_getplayerdata = _xtg_getplayerdata
refresh_xtg_player_data 	= _refresh_xtg_player_data
get_xtg_rank 		= _get_xtg_rank
clear_xtg_data 	= _clear_xtg_data
clear_player_data = _clear_player_data
GM_add_kills = _GM_add_kills