--[[
		file: Factin_yunbiao.lua   
		desc:	�������
		author:	dl

]]--
--include 
--------------------------------------------------------------

local type = type
local tostring = tostring
local os_date = os.date
local GetFactionData = GetFactionData  --��ȡ��ǰ�������
local common_time_config = common_time_config  -- ÿ�� ���� ���� ʱ������
local GetFactionBootData = GetFactionBootData  -- ��ȡ�������
local GetServerTime = GetServerTime    ---��ȡ������ʱ��
local PI_GetPlayerFacID = PI_GetPlayerFacID --��ȡ��Ұ��ID
local define = require('Script.cext.define')  --����
local FACTION_BZ,FACTION_FBZ = define.FACTION_BZ,define.FACTION_FBZ  -- �����͸�����
local CI_GetMemberInfo = CI_GetMemberInfo
local CI_GetFactionInfo = CI_GetFactionInfo --��ȡ�����Ϣ
local CreateObjectIndirect = CreateObjectIndirect  --��������
local RemoveObjectIndirect = RemoveObjectIndirect
local msg_yajin = msgh_s2c_def[7][24]
local msg_start = msgh_s2c_def[7][25]
local msg_over = msgh_s2c_def[7][26]
local msg_lead = msgh_s2c_def[7][27]
local msg_lead_cancel = msgh_s2c_def[7][28]
local SendLuaMsg  = SendLuaMsg 
local CI_GetPlayerData = CI_GetPlayerData
local CI_AreaAddExp = CI_AreaAddExp
local SetEvent = SetEvent
local PlayerMonsterConf = PlayerMonsterConf
local CI_SetReadyEvent = CI_SetReadyEvent
local FactionRPC = FactionRPC
local MailConfig = MailConfig
local call_monster_dead = call_monster_dead
local CI_DelMonster = CI_DelMonster
local TimesTypeTb = TimesTypeTb
local define = require('Script.cext.define')
local ProBarType = define.ProBarType
local time_cnt = require('Script.common.time_cnt')
local GetTimeThisDay = time_cnt.GetTimeThisDay
local db_module = require('Script.cext.dbrpc')
local db_faction_yajin_record = db_module.db_faction_yajin_record
local db_faction_yajin_clear = db_module.db_faction_yajin_clear
local MonsterRegisterEventTrigger = MonsterRegisterEventTrigger

-- data
-------------------------------------------------------------
-- ��ͼid
local YB_mapID = 11		

local faction_ybconf = {
	-- �ڳ�
	monster = {monsterId = 521,monAtt={[1] =600,},imageID = 2168,headID = 2168,EventID = 1, eventScript = 1022,moveArea = 4,IdleTime = 5,objectType = 0,deadScript = 4301,aiType = 1034},	
}

--inner
----------------------------------------------------------------

--��ȡ�����������
-- [1] �������� [3 & 7] �������й� ���ڽ����������� [8] ÿ������ ���ڽ����������� [other] ���ڽ�������
function GetFaction_ybData(fid)     
    local data = GetFactionData(fid)
	if data == nil then return end
	if nil == data.yunb then
		data.yunb = {
			[1] = 2,		-- [1]����
			-- [2] = nil,	-- [2]����ʱ��
			-- [3]= 0,		-- [3]����
			-- [4] = {},	-- [4]����Ѻ�� key = sid, val = money
			-- [5] = nil,	-- [5]��ǰǣ��sid
			-- [6] = nil,	-- [6]�ڳ�GID
			-- [7] = nil,	-- [7]�ڳ������ [nil or 0] û���� [1] ���� [9] ������
			-- [8] = nil,	-- [8]�������ڴ���
			-- [9] = nil,	-- [9]��ǰ��Ѻ����
			-- [10] = nil,	-- [10]��Ѻ����(���ڼ��㽱��)
		}   
	end
    return data.yunb
end

function faction_is_yunbiao(fac_id)
	local data = GetFactionData(fac_id)
	if data.yunb == nil then
		return false
	end
	if data.yunb[2] or data.yunb[6] then
		return true
	end
	return false
end

-- data 1 û�� 2 �������� 3 ���ȼ����� 4 ���Ȩ�޲��� 5 ��������
local function check_start(sid)  --�����������
	-- ������3��  ����
	-- local svrTime = GetServerOpenTime() --����ʱ��
	-- if GetServerTime()-svrTime <= 72*3600 then --72Сʱ����
	-- 	look('ʱ��û��')
	-- 	return
	-- end
	local fac_id = CI_GetPlayerData(23,2,sid)
	if fac_id == nil or fac_id <= 0 then 					--û��
		SendLuaMsg(0,{ ids = msg_start,res = 1},9) 			-- msg_start 
		return 								   
	end 
	local ybData = GetFaction_ybData(fac_id) 	   			--��ȡ��������
	if ybData == nil then return end
	look(ybData)
	if ybData[2] then            			   				--��������
		SendLuaMsg(0,{ids = msg_start,res = 2},9)   
		return
	end  
	local fac_lv = CI_GetFactionInfo(nil,2) or 0
	look('fac_lv:' .. tostring(fac_lv))
	if fac_lv < 4 then 							   			-- ���ȼ�����
		SendLuaMsg(0,{ids = msg_start,res = 3},9)	
		return 
	end  
	local title = CI_GetMemberInfo(1)
	--look('title:' .. tostring(title))
	if(title ~= FACTION_BZ and title ~= FACTION_FBZ)then  	-- ���ǰ����򸱰���
		SendLuaMsg(0,{ids = msg_start,res = 4},9)    
		return  
	end  
	-- if ybData[1] <= 0 then     						 		-- ���ڴ�������
		-- SendLuaMsg(0,{ids = msg_start,res = 5},9)	
		-- return 
	-- end 
	if ybData[8] and ybData[8] >= 1 then					-- �����Ѿ�Ѻ����
		SendLuaMsg(0,{ids = msg_start,res = 6},9)    
		return
	end

	local now = GetServerTime()
	local begtm = GetTimeThisDay(now,12,0,0)
	local endtm = GetTimeThisDay(now,23,0,0)
	local double_beg = GetTimeThisDay(now,19,10,0)
	local double_end = GetTimeThisDay(now,22,0,0)
	if now < begtm or now >= endtm then
		SendLuaMsg(0,{ids = msg_start,res = 7},9)		-- ��������ʱ��
		return
	end	
	 
	local multi = 1                              		-- ����
	if now >= double_beg and now < double_end then
		multi = 1.5										-- �౶
	end
	--�¼���������,�۳�20000����ʽ�,��ɻ������,�𻵷�һ��
	local money = CI_GetFactionInfo(nil,3)
	if(20000>money)then
		TipCenter(GetStringMsg(464))
		return --����ʽ���
	end

	factionMoneyAdd(-20000,fac_id)
	ybData[2] = now + 30*60     		--��������ʱ��
	ybData[3] = multi   					--�������ڱ���		
	return true
end

-- ������ڿ�ʼ
function faction_yunbiao_start(sid)	
	local fac_id = CI_GetPlayerData(23,2,sid)
	if fac_id == nil or fac_id <= 0 then return end
	local ybData = GetFaction_ybData(fac_id)
	if ybData == nil then return end
	local rx,ry,rid,mapGID = CI_GetCurPos(2,sid)
	if mapGID and mapGID > 0 then return end
	if rid ~= YB_mapID then return end	
	look('rx:' .. tostring(rx))
	look('ry:' .. tostring(ry))
	if (rx < 2 or rx > 15) or (ry < 103 or ry > 114) then
		TipCenter(GetStringMsg(700))
		return
	end
	
	-- �������
	if not check_start(sid) then return end	
	
	-- ȡ���GID
	local plaGID = CI_GetPlayerData(16,2,sid)
	look('plaGID:' .. tostring(plaGID))
	local conf = faction_ybconf.monster
	conf.regionId = YB_mapID
	conf.x = 7
	conf.y = 109
	conf.targetID = plaGID						-- ���ø������
	conf.headID = 1								-- Ĭ��ûԪ�����ڳ�
	local total = ybData[9] or 0
	local wLevel = GetWorldLevel() or 1	
	-- ���þ���	
	-- local extra = 1 + total * 0.002		-- 0.002�� / 1Ԫ��
	-- if extra > 2 then
		-- extra = 2
	-- end
	-- local exps = rint( ((wLevel^2.4)*100 + 500000) * 0.5 * extra * 0.5)		-- ���佱�������50%
	-- conf.exp = exps
	-- �����ڳ�Ԫ����ʾ
	if total > 0 then
		conf.headID = 2
	end
	-- �����ڳ��ȼ�
	conf.level = wLevel
	look(conf)
	local monGID = CreateObjectIndirect(conf)   	-- �����ڳ�
	if monGID == nil or monGID <= 0 then return end	
	local fac_name = CI_GetFactionInfo(fac_id,1)		-- �����ڳ����
	CI_UpdateMonsterData(2,fac_name,4,monGID)
	-- ���ô���
	if monGID and conf.EventID and conf.eventScript and conf.eventScript >= 1 then
		MonsterRegisterEventTrigger(YB_mapID,monGID,MonsterEvents[conf.eventScript])
	end
	look('monGID:' .. tostring(monGID))
	-- ����ǣ�����
	ybData[5] = sid
	CI_UpdateMonsterData(4,sid,4,monGID)
	AreaRPC(4,monGID,YB_mapID,'faction_yunb_lead',monGID,plaGID)
	SetTempTitle(sid,2,1,1,0)	
	-- ���õ�ǰ�ڳ�GID
	ybData[6] = monGID
	-- �����ڳ������
	ybData[7] = 0
	--�������ڴ���
	-- ybData[1] = ybData[1] - 1
	ybData[8] = 1	
	-- ����һ����������¼�ϴ���Ѻ����(���ڽ��㽱��)
	ybData[10] = ybData[9] or 0
	-- 30���Ӻ�ʧ��
	SetEvent(30*60,nil,'faction_yunbiao_over',fac_id,monGID)
	-- ȫ��֪ͨ
	local fac_name = CI_GetFactionInfo(fac_id,1)
	BroadcastRPC('faction_yb_start', fac_id, fac_name,ybData[10])	--ȫ��ͨ��
end

-- ǣ���ڳ�
function faction_yunbiao_lead(sid,monGID)
	if sid == nil or monGID == nil then return end
	local fac_id = CI_GetPlayerData(23,2,sid)
	if fac_id == nil or fac_id <= 0 then	-- û�а��
		SendLuaMsg(0,{ids = msg_lead,res = 1},9)
		return  
	end
	local ybData = GetFaction_ybData(fac_id)
	if ybData == nil then return end
	if ybData[5] then			
		SendLuaMsg(0,{ids = msg_lead,res = 2},9)		-- �Ѿ�����ǣ����
		return
	end
	if ybData[6] == nil or ybData[6] ~= monGID then
		SendLuaMsg(0,{ids = msg_lead,res = 3},9)		-- ���Ǳ����ڳ� ǣ��ë��
		return
	end
	CI_SetReadyEvent(0,ProBarType.lead,1,0,'GI_lead_biaoche')
end

function GI_lead_biaoche()
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then return end
	local fac_id = CI_GetPlayerData(23,2,sid)
	if fac_id == nil or fac_id <= 0 then	-- û�а��
		SendLuaMsg(0,{ids = msg_lead,res = 1},9)
		return 0
	end
	local ybData = GetFaction_ybData(fac_id)
	if ybData == nil then return end
	if ybData[5] then			
		SendLuaMsg(0,{ids = msg_lead,res = 2},9)		-- �Ѿ�����ǣ����
		return 0
	end
	if ybData[6] == nil then
		SendLuaMsg(0,{ids = msg_lead,res = 3},9)		-- ���Ǳ����ڳ� ǣ��ë��
		return
	end 
	local monGID = ybData[6]
	local plaGID = CI_GetPlayerData(16,2,sid)
	-- ����ǣ�����
	ybData[5] = sid
	CI_UpdateMonsterData(1,{targetID = plaGID,moveArea = 4},nil,4,monGID)
	CI_UpdateMonsterData(4,sid,4,monGID)				-- ����ǣ��		
	AreaRPC(4,monGID,YB_mapID,'faction_yunb_lead',monGID,plaGID)
	SetTempTitle(sid,2,1,1,0)
	-- ������Ϣ
	look('lead success')
	SendLuaMsg(0,{ids = msg_lead,res = 0},9)
	return 1
end

-- ȡ��ǣ��
function faction_cancel_lead(sid)
	if sid == nil then return end
	local fac_id = CI_GetPlayerData(23,2,sid)
	if fac_id == nil or fac_id <= 0 then			-- û�а��
		SendLuaMsg(0,{ ids = msg_lead_cancel, res = 1 },9)
		return  
	end
	local ybData = GetFaction_ybData(fac_id)
	if ybData == nil then return end
	if ybData[6] == nil then						-- û���ڳ���
		SendLuaMsg(0,{ ids = msg_lead_cancel, res = 2 },9)
		return
	end
	local monGID = ybData[6]
	look('monGID:' .. tostring(monGID))	
	if ybData[5] == nil or ybData[5] ~= sid then	-- ������ǣ����
		SendLuaMsg(0,{ ids = msg_lead_cancel, res = 3 },9)
		return
	end
	-- ȡ��ǣ��
	ybData[5] = nil
	local ret1 = CI_UpdateMonsterData(1,{targetID = 0,moveArea = 0,},nil,4,monGID,YB_mapID)
	look('ret1:' .. tostring(ret1))
	local ret2 = CI_UpdateMonsterData(4,0,4,monGID,YB_mapID)
	look('ret2:' .. tostring(ret2))
	AreaRPC(4,monGID,YB_mapID,'faction_yunb_lead',monGID,0)
	SetTempTitle(sid,2,1,0,0)
	-- ������Ϣ
	look('lead cancel success')
	SendLuaMsg(0,{ ids = msg_lead_cancel, res = 0 },9)
end

-- ������ڳ�ʱ
function faction_yunbiao_over(fac_id,monGID)
	local ybData = GetFaction_ybData(fac_id)
	if ybData == nil then return end
	look(ybData)
	if ybData[2] == nil or ybData[6] == nil then
		return
	end
	if ybData[6] ~= monGID then
		return
	end
	-- ��ʱ���򱬴���
	ybData[7] = 9
	-- �������	
	FactionRPC(fac_id,'faction_yb_submit',fac_id,ybData[7],ybData[3],ybData[10])
	-- �Ƴ��ڳ�
	CI_DelMonster(YB_mapID,ybData[6])					
	-- �������� (������Ѻ��)
	clear_faction_ybdata(fac_id)
end

-- ����������
function faction_yunbiao_submit(sid) 
	look('faction_yunbiao_submit')
	local fac_id = CI_GetPlayerData(23,2,sid)
	if fac_id == nil or fac_id <= 0 then return end
	local ybData = GetFaction_ybData(fac_id)
	if ybData == nil then return end
	look(ybData)
	if ybData[2] == nil or ybData[6] == nil then
		return
	end
	if ybData[5] == nil or ybData[5] ~= sid then		-- ����ǣ���� ���ܽ��ڳ�
		return
	end
	local mon_gid = ybData[6]
	local x,y = CI_GetCurPos(4,mon_gid,YB_MapID)
	if x == nil or x < 0 then return end
	if (x < 115 or x > 133) or (y < 15 or y > 35) then
		return
	end
	
	-- ȡ��ǣ��
	-- ybData[5] = nil
	-- CI_UpdateMonsterData(1,{targetID = 0,moveArea = 0,},nil,4,monGID)
	-- CI_UpdateMonsterData(4,0,4,monGID)
	-- AreaRPC(4,monGID,YB_mapID,'faction_yunb_lead',monGID,0)
	-- SetTempTitle(sid,2,1,0,0)				
	
	local now = GetServerTime()
	if ybData[2] < now then 							-- �����ڳ�ʱ��
		look('faction_yunbiao_submit logic erro',1)
		return 
	end 
	look('faction_yunbiao_submit over')
	local multi = ybData[3] or 1
	-- ���Ӱ���ʽ�
	local fac_zj = 0
	local wLevel = GetWorldLevel() or 1
	if ybData[7] then
		if ybData[7] == 0 then
			-- fac_zj = rint(wLevel * 100 * multi)
			fac_zj = rint(wLevel * 100 * multi)+20000--����ʽ�Ѻ�𷵻�
		elseif ybData[7] == 1 then
			-- fac_zj = rint(wLevel * 100 * multi * 0.5)
			fac_zj = rint(wLevel * 100 * multi * 0.5)+10000
		end
	end
	look('fac_zj:' .. tostring(fac_zj))
	if fac_zj > 0 then
		factionMoneyAdd(fac_zj,fac_id)
	end	
	-- �������	
	look('ybData[9]:' .. tostring(ybData[9]))
	FactionRPC(fac_id,'faction_yb_submit',fac_id,ybData[7],ybData[3],ybData[10])
	-- �Ƴ��ڳ�
	CI_DelMonster(YB_mapID,ybData[6])	
	-- �������� (���ܷ���Ѻ��)
	clear_faction_ybdata(fac_id,1)
end

--- ���ڽ�����Ѻ���(����� money == nil)
-- 	data 1 û�� 2 �������� 3 ���ȼ����� 4 Ѻ�𲻶� 5 �ܽ�Ѻ�����100
function faction_yunbiao_yajin(sid,money)
	local fac_id = CI_GetPlayerData(23,2,sid)
	local ybData = GetFaction_ybData(fac_id)
	if fac_id == nil or fac_id <= 0 then   --û��
		SendLuaMsg(0,{ids = msg_yajin, res = 1},9) 
		return 								  
	end 
	local lv = CI_GetPlayerData(1,2,sid)
	if lv == nil or lv <= 0 then return end
	
    if money == nil then
		SendLuaMsg(0,{ ids = msg_yajin, data = ybData[4], count = ybData[8] or 0 },9) -- ����Ѻ�������
	else
		if type(money) ~= type(0) then return end
		if money <= 0 then return end
		if ybData[2] then  
			SendLuaMsg(0,{ids = msg_yajin, res = 2},9)  --��������
			return  
		end  	
		local flv = CI_GetFactionInfo(nil,2)
		if flv < 4 then 
			SendLuaMsg(0,{ids = msg_yajin, res = 3},9)	-- ���ȼ�����
			return 
		end  
		 
		if money <= 0 or money > 100 then 
			SendLuaMsg(0,{ids = msg_yajin, res = 4},9)   --4 Ѻ�𲻶�
			return 
		end 
		ybData[4] = ybData[4] or {}
		ybData[4][sid] = ybData[4][sid] or {}
		local t = ybData[4][sid]
		local oldmoney = t[1] or 0
		if oldmoney + money > 100 then
			SendLuaMsg(0,{ids = msg_yajin, res = 5},9)    --5 �ܽ�Ѻ�����100
			return 
		end
		-- �ж�ÿ��Ѻ������(�������Ƶ��ת���)
		if not CheckTimes(sid,TimesTypeTb.yb_yajin,money,-1,1) then
			SendLuaMsg(0,{ids = msg_yajin, res = 5},9)    --5 ÿ���ܽ�Ѻ�����100
			return
		end
		if not CheckCost( sid, money, 0, 1, "�������Ѻ��") then
			return false
		end
		-- ��������
		CheckTimes(sid,TimesTypeTb.yb_yajin,money,-1)
		-- ���¸���Ѻ�������ȼ�
		t[1] = (t[1] or 0) + money
		t[2] = lv
		-- �����ܵ�Ѻ����
		ybData[9] = (ybData[9] or 0) + money
		-- ���µ����ݿ�
		db_faction_yajin_record(sid,t[1],fac_id)
		SendLuaMsg(0,{ids = msg_yajin,res = 0,data = ybData[4][sid]},9)
	end
end

-- �콱
function faction_yb_award(sid,fac_id)
	look('faction_yb_award:' .. tostring(fac_id))
	if sid == nil or fac_id == nil then return end
	local fid = CI_GetPlayerData(23,2,sid)
	if fid == nil or fid <= 0 then return end
	if fid ~= fac_id then
		look('faction_yb_award not the same faction',1)
		return
	end
	local ybData = GetFaction_ybData(fac_id)
	if ybData == nil then return end
	local multi = ybData[3]
	local degree = ybData[7]
	if multi == nil or degree == nil then
		look('faction_yb_award multi == nil or degree == nil',1)
		return
	end	
	-- �жϴ���
	if not CheckTimes(sid,TimesTypeTb.fac_yb,1,-1) then
		look('CheckTimes fac_yb not enough')
		return
	end
	-- �����ϵ��
	local per = 1
	if degree == 1 then
		per = 0.7
	elseif degree == 9 then
		per = 0.3
	end	
	-- ��Ѻ��ϵ��
	local total = ybData[10] or 0
	local extra = 1 + total * 0.002		-- 0.002�� / 1Ԫ��
	if extra > 2 then
		extra = 2
	end
	-- ���������
	local lv = CI_GetPlayerData(1,2,sid)
	if lv == nil or lv <= 0 then return end
	local exps = rint( ((lv^2.4)*100 + 500000) * 0.5 * multi * per * extra )
	local money = rint( (lv*5000 + 100000) * 0.5 * multi * per * extra )
	if exps < 0 then exps = 0 end
	if money < 0 then money = 0 end
	look('exps:' .. tostring(exps))
	look('money:' .. tostring(money))
	PI_PayPlayer(1,exps,0,0,'������ھ���')
	GiveGoods(0,money,1,'�������ͭǮ')
end

-- local function GetPerHP(mon_gid)
	-- local curHP = GetMonsterData(6,4,mon_gid)
	-- if curHP == nil or curHP < 0 then
		-- return 0
	-- end
	-- local totalHP = GetMonsterData(7,4,mon_gid)
	-- if totalHP == nil or curHP < 0 then
		-- return 0
	-- end
	-- local perHP = rint((curHP / totalHP) * 100)
	-- return perHP
-- end

--������ڽ�����������
function clear_faction_ybdata(fac_id,back)
	look('clear_yunbdata:' .. tostring(fac_id))
	local ybData = GetFaction_ybData(fac_id)
	if ybData == nil then return end
	-- ���ô洢����������
	db_faction_yajin_clear(fac_id,back)	
end

function CALLBACK_ClearFacYaJin(fac_id,back,ret)
	look('CALLBACK_ClearFacYaJin')
	if fac_id == nil or ret == nil then
		return
	end
	if ret == 0 then
		look('CALLBACK_ClearFacYaJin ret == 0')
		return
	end
	local ybData = GetFaction_ybData(fac_id)
	if ybData == nil then return end
	
	ybData[2] = nil
	local monGID = ybData[6]
	local per = ybData[7]
	local multi = ybData[3] or 1
	-- Ѻ��������
	if back and monGID then		
		if type(ybData[4]) == type({}) then			
			for pid, v in pairs(ybData[4]) do
				if type(pid) == type(0) and type(v) == type({}) then
					local num = v[1] or 0
					local lv = v[2] or 1
					-- local exps = 0		-- ���鵤
					local money = 0		-- ͭǮ��
					num = rint(num/10)
					if num > 0 then
						-- exps = rint( ((lv + 20)/5*2 + 30)*num*0.1 * multi )
						money = rint(num * 5)
						-- look('exps:' .. tostring(exps))
						look('money:' .. tostring(money))
						-- if exps < 0 then exps = 0 end
						if money < 0 then money = 0 end
						if per == 0 then		-- ���ʣ��Ѫ������70% (����Ѻ��ȫ���)											
							SendSystemMail(pid,MailConfig.YaJinMail,1,2,nil,{[3] = {{685,num,1},},})
							SendSystemMail(pid,MailConfig.YaJinMail,2,2,nil,{[3] = {{601,money,1},},})
						elseif per == 1 then	-- ���ʣ��Ѫ������70%����û���� (������Ѻ�𼰽��� * 70%)
							-- exps = rint(exps * 0.7)
							money = rint(money * 0.7)
							SendSystemMail(pid,MailConfig.YaJinMail,2,2,nil,{[3] = {{601,money,1},},})
						end
					end
				end
			end
		end
	end
	ybData[4] = nil
	-- ͳһ����������ǣ����־
	if ybData[5] then
		SetTempTitle(ybData[5],2,1,0,0)
	end
	ybData[5] = nil
	ybData[6] = nil
	ybData[9] = nil
end

-- �Ϸ�Ѻ�𷵻�
function CALLBACK_BackDeposit(sid,rs)
	if sid and type(rs) == type({}) then
		for k, v in pairs(rs) do
			if type(k) == type(0) and type(v) == type({}) then
				local pid = v[1] or 0
				local num = rint((v[2] or 0) / 10)
				if pid > 0 and num > 0 then
					SendSystemMail(pid,MailConfig.YaJinMail,3,2,nil,{[3] = {{685,num,1},},})
				end
			end
		end
	end
end

-- ����
function faction_yb_logout(sid)
	-- ���������ȡ��ǣ��
	local fac_id = CI_GetPlayerData(23,2,sid)
	if fac_id == nil or fac_id <= 0 then return end	
	local ybData = GetFaction_ybData(fac_id)
	if ybData == nil then return end
	if ybData[2] and ybData[6] then		-- ���������״̬
		if ybData[5] and ybData[5] == sid then		-- �����ǣ��״̬
			local monGID = ybData[6]
			-- ȡ��ǣ��
			ybData[5] = nil
			CI_UpdateMonsterData(1,{targetID = 0,moveArea = 0,},nil,4,monGID,YB_mapID)
			CI_UpdateMonsterData(4,0,4,monGID,YB_mapID)
			AreaRPC(4,monGID,YB_mapID,'faction_yunb_lead',monGID,0)
			SetTempTitle(sid,2,1,0,0)
		end
	end
end

-- ����ǣ���������
function faction_yb_dead(sid)	
	local fac_id = CI_GetPlayerData(23,2,sid)
	if fac_id == nil or fac_id <= 0 then return end
	local ybData = GetFaction_ybData(fac_id)
	if ybData == nil then return end
	if ybData[2] and ybData[6] then		-- ���������״̬
		if ybData[5] and ybData[5] == sid then		-- �����ǣ��״̬
			local monGID = ybData[6]
			-- ȡ��ǣ��
			ybData[5] = nil
			local ret1 = CI_UpdateMonsterData(1,{targetID = 0,moveArea = 0,},nil,4,monGID,YB_mapID)
			look('ret1:' ..tostring(ret1))
			local ret2 = CI_UpdateMonsterData(4,0,4,monGID,YB_mapID)
			look('ret2:' ..tostring(ret2))
			AreaRPC(4,monGID,YB_mapID,'faction_yunb_lead',monGID,0)
			SetTempTitle(sid,2,1,0,0)
		end
	end
end

-- �ڳ�����
call_monster_dead[4301] = function ()
	local monGID = GetMonsterData(27,3)
	if monGID == nil or monGID <= 0 then return end
	-- ȡ�ڳ��������
	local fac_id = GetMonsterData(29,3)
	if fac_id == nil or fac_id <= 0 then return end
	local fac_name = GetMonsterData(9,3)
	if type(fac_name) ~= type('') then return end
	look('fac_name:' .. tostring(fac_name))
	local ybData = GetFaction_ybData(fac_id)
	if ybData == nil then return end
	if ybData[6] == nil or ybData[6] ~= monGID then
		look('not your biaoche')
		return
	end
	-- ��������� [9] ����
	ybData[7] = 9
	-- �������	
	FactionRPC(fac_id,'faction_yb_submit',fac_id,ybData[7],ybData[3],ybData[10])		
	-- ����ͭǮ
	local x,y,rid,mapGID = CI_GetCurPos(3)
	local total = ybData[10] or 0
	total = rint(total/10)*5
	if total < 0 then total = 0 end	
	if rid and rid > 0 then
		local num = 50 + total
		if num > 200 then num = 200 end
		for i = 1,num do		
			CreateGroundItem(rid,0,0,10000,x,y,i)
		end
	end
	-- �������� (������Ѻ��)
	clear_faction_ybdata(fac_id)
	-- ������
	local pname = CI_GetPlayerData(5)
	if type(pname) ~= type('') then
		return
	end
	RegionRPC(rid,'faction_yb_damage',2,fac_name,pname)
end
