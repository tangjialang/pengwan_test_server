--[[
file��	bsmz_fun.lua
desc:	��ʯ����
author: sxj
update: 2014-08-21
]]--
--------------------------------------------------------------------------
--include:
local os = os
local type = type
local pairs = pairs
local Faction_Build = msgh_s2c_def[7][4]
local SetEvent = SetEvent
local dbMgr = dbMgr
local GetWorldCustomDB = GetWorldCustomDB
local CI_GetPlayerData = CI_GetPlayerData
local CI_GetMemberInfo = CI_GetMemberInfo
local define		= require('Script.cext.define')
local FACTION_FBZ = define.FACTION_FBZ
local GetServerTime = GetServerTime
local GetWorldLevel = GetWorldLevel
local rint = rint
local conf = require ('Script.bsmz.bsmz_conf')
local CI_GetFactionInfo = CI_GetFactionInfo
local get_join_factiontime = get_join_factiontime
local FactionRPC = FactionRPC
local CheckCost = CheckCost
local CheckGoods = CheckGoods
local GiveGoods = GiveGoods
local RPC = RPC
local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist = sclist_m.insert_scorelist
local get_scorelist_data = sclist_m.get_scorelist_data
local MailConfig=MailConfig
local look = look
local SendSystemMail = SendSystemMail
local __G = _G
local RPCEx = RPCEx
local CI_SetFactionInfo = CI_SetFactionInfo
local SendLuaMsg = SendLuaMsg
---------------------------------------------------
module(...)

--[[	��ʯ�������ݽṹ
bsmz_data = {
	[fid] = {
		[1] = {���ʶ������ʱ�䣬����������Boss��ǰѪ��,��ɱ��,Boss��Ѫ��}
		[2] = {
			[sid] = {���˲��������˺�����ͼ}
			...
		}
	...
	}
}

]]--
	--��ӽ���������
local function get_in_data()
	local getwc_data = GetWorldCustomDB()
	if getwc_data == nil then 
		return 
	end
	if  getwc_data.bsmz_data == nil then
		getwc_data.bsmz_data = {}		
	end
	return getwc_data.bsmz_data
end
	--��ʯ����������
local function bsmz_facData(fid)
	local bsmz_data = get_in_data()
	if bsmz_data[fid] == nil then
		bsmz_data[fid] = {}					
	end
	return bsmz_data[fid]	
end	
	--��ʯ�����������
local function bsmz_perData(playerid)
	local fid = CI_GetPlayerData(23)	
		--��᲻����
	if fid == nil or fid == 0 then
		return	
	end
	local faction_data = bsmz_facData(fid)
		--������ݲ�����
	if faction_data == nil then
		return				
	end
	faction_data[2] = faction_data[2] or {}
	faction_data[2][playerid] = faction_data[2][playerid] or {}
	return faction_data[2][playerid]
end	
 	--���ݼ��
local function bsmz_check(fid)
		--��᲻����
	if fid == nil or fid == 0 then
		return false,0 --��᲻����
	end
		--����������
	local build = __G.fBuild_conf[7]
	if build == nil then
		return false,1 --����������
	end
		--����δ����
	local curLv = CI_GetFactionInfo(fid,12) --�����ݶ�Ϊ12
	if curLv == nil then
		return false,2 --����δ����
	end
		--�������ݱ�����
	local data = bsmz_facData(fid)
	if data == nil then 
		return false, 10	--��̨���ݴ���
	end
	return true
end  
   --����
		--open: nil �δ������1 ��Ѿ����� 2 ��Ѿ�����
local function _bsmz_open(playerid,num)
	local fid = CI_GetPlayerData(23)
	local result,redata = bsmz_check(fid)
	if result == false then
		return result,redata
	end
		--����ְλ����
	local title = CI_GetMemberInfo(1)
	if title < FACTION_FBZ then
		return false,3 --���������������ܿ���
	end
		--���ڹ涨ʱ����
	local endTime = GetServerTime()
		--date = {hour,min,wday,day,month,year,sec,yday,isdst}
	local date = os.date("*t",endTime)		
	if date.hour <12 or date.hour >=22 then
		return false,4 --���ڹ涨ʱ����
	end	
	local data = bsmz_facData(fid)
	data[1] = data[1] or {}			
	if data[1][1] == 2 then
		return false,5 --��Ѿ�����		
	elseif data[1][1] == 1 then
		return false,6 --��Ѿ�����
	elseif data[1][1] ~= nil then
		return false,11 --���ʶ����
	end		
		--��ȡ����ȼ� ֵΪ 50��60��70��80��90
	local wLevel = GetWorldLevel() or 50
	if wLevel < 50 then
		wLevel = 50
	elseif wLevel > 90 then
		wLevel = 90
	end
	wLevel = (rint(wLevel/10))*10	
	endTime = endTime + 2*60*60	
	local open = 1
	local curLv = CI_GetFactionInfo(nil,12) --�����ݶ�Ϊ12
	local step = 20+ curLv	
	local BossBlood = conf.bsmz_conf[wLevel]* (num)
				 --���ʶ������ʱ�䣬����������Boss��ǰѪ������ɱ��,Boss��Ѫ��
	data[1][1] = open
	data[1][2] = endTime
	data[1][3] = step
	data[1][4] = BossBlood
	data[1][5] = nil
	data[1][6] = BossBlood
		--�㲥 ����ʱ���ǰ��
	FactionRPC(fid,'ff_bsmz_open',data[1][2])	
		--ʱ�䵽���ص���������
	SetEvent(2*60*60,nil,"GI_bsmz_end",fid)			
	return true,open	--������ɹ�
end

    --��ʼ��Ϸ����ʼ����
local function _bsmz_begin(playerid)
	local fid = CI_GetPlayerData(23)
	local result,redata = bsmz_check(fid)
	if result == false then
		return result,redata
	end
		--��Ṳ�����ݲ�����
	local facData = bsmz_facData(fid)
	local shareData = facData[1]
	if shareData == nil then
		return false,10 --��̨���ݴ���
	end
		--�������ݱ�����	
	local perData = bsmz_perData(playerid)
	if perData == nil then 
		return false,11 --��̨���ݴ���
	end
		--����ǿ���״̬
	if shareData[1] ==nil then
		return false,3 -- �δ��ʼ
	end
		--��Ѿ�����
	if shareData[1] ~= 1 and shareData[1] ~= nil then
		return false,4 -- ��Ѿ�����
	end
		--���С��24Сʱ
	local join = __G.get_join_factiontime(playerid)
	local now = GetServerTime()
	if now - join < 24*60*60 then
		return false,5 	--���С��24Сʱ
	end
		--���а�
	local itype = 100000000 + fid	--�������а�itype, ����� + fid
	local sclist = get_scorelist_data(1,itype)
	look("��ʼ���а�")
	look(sclist)
	perData[1] = perData[1] or shareData[3]	--���˲���
	perData[2] = perData[2] or 0		--���˺�
	perData[3] = perData[3] or nil			--��ʯ�����ͼ
				--��ͼ��Boss��ǰѪ����Boss��Ѫ�������а񣬸��˲������������˺�	
	return true,perData[3],shareData[4],shareData[6],sclist,perData[1],perData[2]						
end
	--��ʼ��Ϸ���ͼ
local function _bsmz_save_map(playerid,map)
	local fid = CI_GetPlayerData(23)
	local result,redata = bsmz_check(fid)
	if result == false then
		return result,redata
	end
		--��Ṳ�����ݲ�����
	local facData = bsmz_facData(fid)
	local shareData = facData[1]
	if shareData == nil then
		return false,10 --��̨���ݴ���
	end
		--�������ݱ�����	
	local perData = bsmz_perData(playerid)
	if perData == nil then 
		return false,11 --��̨���ݴ���
	end
	if perData[3] ~= nil then 
		return
	end
	perData[3] = map
end
	--��Ϸ���̣��ƶ�+�˺���
local function _bsmz_play(playerid,allmultiple,sub,map)
	local fid = CI_GetPlayerData(23)
	local result,redata = bsmz_check(fid)
	if result == false then
		return result,redata
	end
	--��Ṳ�����ݲ�����
	local facData = bsmz_facData(fid)
	local shareData = facData[1]
	if shareData == nil then	
		return false,10	--��̨���ݴ���
	end
	--�������ݱ�����	
	local perData = bsmz_perData(playerid)
	if perData == nil then 
		return false,11 --��̨���ݴ���
	end		
	--���С��24Сʱ
	local join = __G.get_join_factiontime(playerid)
	local now = GetServerTime()
	if now - join < 24*60*60 then
		return false,5 	--���С��24Сʱ
	end
	
	--����ǿ���״̬
	if shareData[1] ==nil then
		return false,3 -- �δ��ʼ
	end
		--��Ѿ�����
	if shareData[1] ~= 1 and shareData[1] ~= nil then
		return false,4 -- ��Ѿ�����
	end
	local canContinue = nil 
	if perData[1] >0 then 
		canContinue = 1				--�۲���
	else
		if sub ==1 and CheckGoods(825,1,1,playerid,"��ʯ��������") == 1 then 
			canContinue = 2			--�۲�����
		else
			if sub ==1 and CheckCost(playerid,1,1,1,"��ʯ�����ƶ�")  then
				canContinue = 3 	--��Ԫ��
			else
				return false,5	--Ԫ������
			end
		end
	end
	if canContinue ==1 or canContinue ==2 or canContinue == 3 then
		if canContinue == 1 then
			perData[1] = perData[1] - 1
		elseif canContinue == 2 then
			CheckGoods(825,1,0,playerid,"��ʯ�����ƶ��۲�����")
		elseif canContinue ==3 then
			CheckCost(playerid,1,0,1,"��ʯ�����ƶ���Ԫ��")
		end
		local fight = CI_GetPlayerData(62)	--���ս��		
		if allmultiple > 8 then	--�������ƣ�
			allmultiple = 8
		end
		if allmultiple < 0 then	
			allmultiple = 0
		end
		if allmultiple ~= 0 then
			local name = CI_GetPlayerData(3)
			local itype = 100000000 + fid	--�������а�itype, ����� + fid
			local name = CI_GetPlayerData(3)
			local school = CI_GetPlayerData(2)
			local harm = rint(allmultiple * fight)	--�������˺�	
			if shareData[4] <=harm then	--Bosss����
				harm = shareData[4]			
				shareData[4] = 0
				shareData[5] = playerid
				perData[2] = perData[2] + harm			
																
			else
				shareData[4] = shareData[4] - harm
				perData[2] = perData[2] + harm										
			end			
			local money = rint(harm/20)	
			if money < 10000 then
				money = 10000
			elseif money > 1000000 then
				money = 1000000			
			end	
			insert_scorelist(1,itype,10,perData[2],name,school,playerid)
			local sclist = get_scorelist_data(1,itype)				
			GiveGoods(0,money,1,"��ʯ���󵥲��˺�ͭǮ")
			perData[3] = map
				--�㲥 BossѪ�������а��ǰ��
			FactionRPC(fid,'ff_bsmz_playing',shareData[4],sclist)
			if 	shareData[4] == 0 then
					--���ý�������
				bsmz_end(fid)
			end
		end
	end	
	return true,perData[1],perData[2]	
end

	--��Ϸ����������
local function _bsmz_end(fid)
	local result,redata = bsmz_check(fid)
	if result == false then
		return result,redata
	end
		--��Ṳ�����ݲ�����
	local facData = bsmz_facData(fid)
	local shareData = facData[1]
	if shareData == nil then
		return
	end
		--����ǿ���״̬
	if shareData[1] ~= 1 then
		return
	end	
	shareData[1] = 2	
	local kname = nil
	if shareData[5] then
		kname = CI_GetPlayerData(3,2,shareData[5])	--��ɱ������ û�л�ɱΪnil
	end
	if shareData[4] == 0 then 	--Boss����ɱ	
			--���һ������
		SendSystemMail(kname,MailConfig.Bsmzkill,1,2) 
			-- ���а�
		local itype = 100000000 + fid	--�������а�itype, ����� + fid
		-- �����ʼ�
		local sclist = get_scorelist_data(1,itype)
		sclist[11] = kname

		local BsmzMail = MailConfig.Bsmz
		local award = MailConfig.Bsmz[1].award
		for k,tb in pairs(facData[2]) do
			if type(k) == type(0) and tb[2] ~=0 and tb[2] ~= nil then
				local name = CI_GetPlayerData(3,2,k)
				if name ~= nil then
					if sclist[1] ~= nil and name == sclist[1][2] then		--��1��
						SendSystemMail(name,BsmzMail,1,2,sclist,award[1])
					
					elseif sclist[2] ~= nil and name ==sclist[2][2] then	--��2��
						SendSystemMail(name,BsmzMail,1,2,sclist,award[2])
						
					elseif sclist[3] ~= nil and name == sclist[3][2] then	--��3��
						SendSystemMail(name,BsmzMail,1,2,sclist,award[2])
					elseif  (sclist[4] ~= nil and name == sclist[4][2]) or (sclist[5] ~= nil and name == sclist[5][2]) or
							(sclist[6] ~= nil and name == sclist[6][2]) or (sclist[7] ~= nil and name == sclist[7][2]) or
							(sclist[8] ~= nil and name == sclist[8][2]) or (sclist[9] ~= nil and name == sclist[9][2]) or
							(sclist[10] ~= nil and name == sclist[10][2]) then	--��4-10��
						SendSystemMail(name,BsmzMail,1,2,sclist,award[3])
						
					else 
						SendSystemMail(name,BsmzMail,1,2,sclist,award[4])
						
					end
				end
			end
		end
	end
	look("������Ϣ")
	look(shareData[1])
		--�㲥 ���ʶ��BossѪ�������а񣬻�ɱ�߸�ǰ��
	FactionRPC(fid,'ff_bsmz_end',shareData[1],shareData[4],sclist,kname)
end

	--ˢ�����ߵ���
local function _bsmz_online(playerid)
	local fid = CI_GetPlayerData(23)
		--��Ҳ�����
	if playerid == nil then	
		return 
	end	
		--��᲻����
	if fid == nil or fid == 0 then	
		
		return 
	end	
		--������ݱ�����	
	local bsmz_data = get_in_data()
	if bsmz_data[fid] == nil or bsmz_data[fid][1] == nil then
		return
	end
		--����ʱ��,������ʶ
	RPCEx(playerid,'bsmz_online',bsmz_data[fid][1][2],bsmz_data[fid][1][1])	
end

	--�ϰ��ɱ�ʯ������½���
local function _bsmz_add()
	local lv = CI_GetFactionInfo(nil,2)
	local buildLv = CI_GetFactionInfo(nil,12)
	if (lv ~= nil and lv >=5) and (buildLv == nil or buildLv == 0 ) then
		CI_SetFactionInfo(nil,12,1)
		SendLuaMsg( 0, { ids = Faction_Build,idx = 7,lv = 1}, 9 )
	end
end

local function _bsmz_refresh()
	dbMgr.world_custom_data.data.bsmz_data = nil
	look("bsmz_data_after:")
	look(dbMgr.world_custom_data.data.bsmz_data)
end

local function _bsmz_clear()
	local fid = CI_GetPlayerData(23)
	dbMgr.world_custom_data.data.bsmz_data[fid] = nil 
	look("bsmz_data_after singer:")
	look(dbMgr.world_custom_data.data.bsmz_data[fid])
end
--------------------------------------------------------------------------
--interface:

bsmz_open = _bsmz_open
bsmz_begin = _bsmz_begin
bsmz_save_map = _bsmz_save_map
bsmz_play = _bsmz_play
bsmz_end = _bsmz_end
bsmz_online = _bsmz_online
bsmz_refresh = _bsmz_refresh
bsmz_save_map = _bsmz_save_map
bsmz_clear = _bsmz_clear
bsmz_add = _bsmz_add