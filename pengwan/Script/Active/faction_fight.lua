--[[
file: faction_fight.lua
desc: ���ս
autor: csj
update: 2013-7-27
note:
	1��
]]--

---------------------------------------------------------
--include:

local pairs,ipairs,type = pairs,ipairs,type
local tostring = tostring
local math_random = math.random
local table_insert,table_remove,table_empty,table_sort = table.insert,table.remove,table.empty,table.sort

local look = look
local rint = rint
local RPC = RPC
local RPCEx = RPCEx
local RegionRPC = RegionRPC
local AreaRPC = AreaRPC
local FactionRPC = FactionRPC
local BroadcastRPC = BroadcastRPC
local GiveGoods = GiveGoods
local isFullNum = isFullNum
local GetStringMsg = GetStringMsg
local TipCenter = TipCenter
local CI_GetPKList = CI_GetPKList
local CI_GetCurPos = CI_GetCurPos
local CI_GetPlayerData = CI_GetPlayerData
local CI_GetFactionInfo = CI_GetFactionInfo
local CI_GetMemberInfo = CI_GetMemberInfo
local CI_UpdateNpcData = CI_UpdateNpcData
local CI_UpdateMonsterData = CI_UpdateMonsterData
local GetFactionData = GetFactionData
local define = require('Script.cext.define')
local ProBarType = define.ProBarType
local sc_add = sc_add
local sc_getdaydata = sc_getdaydata
local sc_reset_getawards = sc_reset_getawards
local get_faction_union = get_faction_union
local npclist = npclist
local call_npc_click = call_npc_click
local call_monster_dead = call_monster_dead
local call_monster_chick = call_monster_chick
local SetEvent = SetEvent
local CI_AddBuff = CI_AddBuff
local CI_DelBuff = CI_DelBuff
local CI_HasBuff = CI_HasBuff
local GetTempTitle = GetTempTitle
local SetTempTitle = SetTempTitle
local ClrTempTitle = ClrTempTitle
local CI_SetReadyEvent = CI_SetReadyEvent
local award_check_items = award_check_items
local GI_GiveAward = GI_GiveAward
local PI_MovePlayer = PI_MovePlayer
local GetWorldLevel = GetWorldLevel
local GetWorldCustomDB = GetWorldCustomDB
local CheckTimes = CheckTimes
local TimesTypeTb = TimesTypeTb
local MailConfig = MailConfig
local SendSystemMail = SendSystemMail
local GetNpcidByUID = GetNpcidByUID
local GetObjectUniqueId = GetObjectUniqueId
local CreateObjectIndirectEx = CreateObjectIndirectEx
local CreateObjectIndirect = CreateObjectIndirect
local RemoveObjectIndirect = RemoveObjectIndirect
local active_mgr_m = require('Script.active.active_mgr')
local activitymgr = active_mgr_m.activitymgr
local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist = sclist_m.insert_scorelist
local get_scorelist_data = sclist_m.get_scorelist_data
local insert_scorelist_ex = sclist_m.insert_scorelist_ex
local define = require('Script.cext.define')
local FACTION_XZ = define.FACTION_XZ
local db_module = require('Script.cext.dbrpc')
local db_active_getaward = db_module.db_active_getaward
---------------------------------------------------------
--module

module(...)

---------------------------------------------------------
--inner:

local BASEID = 20001

local ff_config = {
	monster = {
		-- ����ˮ��
		[1] = {		
			{ monsterId = 517, x = 43, y = 69, controlId = 20001, camp = 4,eventScript = 10 }, --��ɫˮ��
			{ monsterId = 518, x = 75, y = 73, controlId = 20002, camp = 4,eventScript = 10 },	--��ɫˮ��
			{ monsterId = 519, x = 59, y = 132, controlId = 20003, camp = 4,eventScript = 10 },  --��ɫˮ��
			{ monsterId = 520, x = 22, y = 118, controlId = 20004, camp = 4,eventScript = 10 }, --��ɫˮ��
		},
		-- �м�����
		[2] = { monsterId = 8, x = 49, y = 97, deadScript = 4201 },
	},
	enter_pos = {
		{82,155},{10,161},{22,42},{80,165},{4,165},{16,41},{88,160},{4,174},{25,34},{88,170},{10,171},{18,33},{88,180},{4,184},{23,24},{75,179},{10,181},{15,25},{81,183},{17,175},{11,33},{81,174},{16,184},{7,21},{22,183},{12,15},{12,5},{18,10},{18,18},{23,14}
	},
	relive_pos = {
		[1] = {43,68},
		[2] = {75,72},
		[3] = {59,132},
		[4] = {23,119},		
	},
}


local active_name = 'ff'
local active_type = 9
local min_player = 1		-- ��С��������

local function get_ff_data()
	local custom = GetWorldCustomDB()
	if custom == nil then return end
	if custom.ffdt == nil then
		custom.ffdt = {}
	end
	return custom.ffdt
end

local function get_active_flags()
	local active_ff = activitymgr:get(active_name)
	if active_ff == nil then 
		return 0
	end
	return active_ff:get_state()
end

local function get_pub_data()
	local active_ff = activitymgr:get(active_name)
	if active_ff == nil then return end
	local pub_data =  active_ff:get_pub()
	if pub_data == nil then return end
	return pub_data
end

-- ��ȡ�����б�
local function get_sign_list()
	local active_ff = activitymgr:get(active_name)
	if active_ff == nil then return end
	local pub_data =  active_ff:get_pub()
	if pub_data == nil then return end
	if pub_data.sign_list == nil then
		pub_data.sign_list = {}
	end
	return pub_data.sign_list
end

-- ���ø����λ��
local function set_cur_pos(fid)
	local active_ff = activitymgr:get(active_name)
	if active_ff == nil then return end
	local pub_data =  active_ff:get_pub()
	if pub_data == nil then return end
	local sign_list = get_sign_list()
	if sign_list == nil then return end
	sign_list[fid] = sign_list[fid] or {}
	pub_data.cpos = pub_data.cpos or 1
	if sign_list[fid].side == nil then
		sign_list[fid].side = pub_data.cpos
		pub_data.cpos = pub_data.cpos + 1
		if pub_data.cpos > 30 then
			pub_data.cpos = 1
		end
	end
	return pub_data.cpos
end

-- ��ȡ��̬�赲��־
local function _ff_get_block()
	local active_ff = activitymgr:get(active_name)
	if active_ff == nil then return end
	local pub_data =  active_ff:get_pub()
	if pub_data == nil then return end
	return pub_data.block
end

-- ���ö�̬�赲��־
local function _ff_set_block(state)
	local active_ff = activitymgr:get(active_name)
	if active_ff == nil then return end
	local pub_data =  active_ff:get_pub()
	if pub_data == nil then return end
	pub_data.block = state	
	if pub_data.gid and state == 1 then
		-- ɾ��դ��
		for i = 400430, 400447 do
			if npclist[i] then
				local controlId = i + 100000
				RemoveObjectIndirect(pub_data.gid,controlId)
			end
		end
		RegionRPC(pub_data.gid,'ff_block',state)
	end
end

-- ���°�������
-- @itype: [1] ���� [2] ��Դ
-- return: [false] ʧ�� [true,��ǰֵ] �ɹ�,��ǰֵ
local function update_faction_data(fac_id,itype,val)
	local sign_list = get_sign_list()
	if sign_list == nil or sign_list[fac_id] == nil then 
		return
	end
	local fac_data = GetFactionData(fac_id)
	if fac_data == nil then return end
	if itype == 1 then
		fac_data.c_score = (fac_data.c_score or 0) + val		
	end
	local fac_name = CI_GetFactionInfo(fac_id,1)
	if fac_name == nil or fac_name == 0 then return end
	local fac_lv = CI_GetFactionInfo(fac_id,2)
	if fac_lv == nil or fac_lv == 0 then return end
	-- ����ÿ�ջ��ֱ�
	insert_scorelist(1,active_type,10,fac_data.c_score,fac_name,fac_lv,fac_id)
end

-- ���������ս�����(ǰʮ�����а��ս����)
local function set_fight_result()
	local sclist = get_scorelist_data(1,active_type)
	if sclist == nil then return end
	for k, v in pairs(sclist) do
		if type(k) == type(0) and type(v) == type({}) and k <= 10 then
			local fac_id = v[4]
			local fac_data = GetFactionData(fac_id) 
			if fac_data then
				local score = 12 - k
				if score < 0 then
					score = 0
				end
				-- ���°��ս����
				fac_data.f_score = (fac_data.f_score or 0) + score	
				-- ����������
				local fname = CI_GetFactionInfo(fac_id,1)
				local flv = CI_GetFactionInfo(fac_id,2)
				insert_scorelist(2,active_type,10,fac_data.f_score,fname,flv,fac_id)
			end
		end
	end
end


-- ��ȡ�����
local function get_tops()
	local common_data = get_ff_data()
	if common_data then
		return common_data.tops
	end
end

-- ���������
local function update_tops(itype,val,sid)
	if itype == nil or val == nil or sid == nil then
		return
	end
	local name = CI_GetPlayerData(5,2,sid)
	local common_data = get_ff_data()
	if common_data then
		common_data.tops = common_data.tops or {}
		common_data.tops[itype] = common_data.tops[itype] or {}
		local t = common_data.tops[itype]
		if val > (t[1] or 0) then
			t[1] = val
			t[2] = name
		end
	end
end

-- ��ȡ��ն�׶����ϵ�� (�����Է��ӷ�,ɱ���Լ�����)
local function get_kills_pos(kill_c)
	if kill_c == nil or kill_c <= 10 then
		return 10,1
	end
	if kill_c > 10 and kill_c <= 30 then
		return 20,1.2
	elseif kill_c > 30 and kill_c <= 50 then
		return 30,1.5
	elseif kill_c > 50 then
		return 40,2
	end
end

-- ���ӻ����(���˻���/������)
local function add_score(sid,val)
	if sid == nil or val == nil then
		return
	end
	-- ��ѽ�������ӷ�����
	local active_ff = activitymgr:get(active_name)
	if active_ff == nil then			
		return
	end	
	-- ��ѽ�������ӷ�����
	local active_flags = active_ff:get_state()
	if active_flags == 0 then	
		return
	end	
	local my_data = active_ff:get_mydata(sid)
	if my_data == nil then
		look('add_score get_mydata erro')
		return
	end
	-- ���»����
	look('val:' .. tostring(val))
	local day_score = sc_add(sid,9,val,1)
	look('day_score:' .. tostring(day_score))
	-- �������������
	local name = CI_GetPlayerData(5,2,sid)
	update_tops(1,day_score,sid)	
	-- ���°��ɻ���	(�ӵ��������)
	local fac_id = get_faction_union(sid,1)	
	if fac_id and fac_id > 0 then
		update_faction_data(fac_id,1,val)	
	end
	-- ͬ����ҵ�ǰ���ָ�ǰ̨
	RPCEx(sid,'ff_player_score',day_score)
end

-- �����������
local function _on_playerdead(self,deader_sid,rid,mapGID,killer_sid)
	look('active_ff _on_playerdead')
	if deader_sid == nil or mapGID == nil then 
		look('_on_playerdead callback param erro')
		return
	end	
	-- ��ѽ�������ӷ�����
	local active_ff = activitymgr:get(active_name)
	if active_ff == nil then			
		return
	end	
	-- ��ѽ�������ӷ�����
	local active_flags = active_ff:get_state()
	if active_flags == 0 then	
		return
	end
	local deader_data = active_ff:get_mydata(deader_sid)
	if deader_data == nil then
		look('active_ff _on_playerdead get get_mydata erro')
		return
	end
	-- �������� +2 ���·���
	add_score(deader_sid,2)
	-- ������������ +1 (���¸���buff)
	if not CI_HasBuff(241,2,deader_sid) then		-- ����Ѿ�û��Buff�˾��ִ�0��ʼ
		deader_data.dead_c = 0
	end
	deader_data.dead_c = (deader_data.dead_c or 0) + 1
	if deader_data.dead_c > 10 then deader_data.dead_c = 10 end
	-- ���� +buffer
	CI_AddBuff(241,0,deader_data.dead_c,false,2,deader_sid)
	-- ���λ���������� +1 (�����ù���)
	deader_data.dead_m = (deader_data.dead_m or 0) + 1
	update_tops(4,deader_data.dead_m,deader_sid)
	-- �������ս���ն��
	local deader_kill_c = GetTempTitle(deader_sid,1,1) or 0		-- ��ȡ�������˵ĵ�ǰ��ն��
	SetTempTitle(deader_sid,1,1,0,0)
	-- �����������Ůbuff
	if deader_data.buff then
		CI_DelBuff(deader_data.buff,2,deader_sid)
		deader_data.buff = nil
	end	
	
	-- ɱ���� 
	if killer_sid and killer_sid > 0 then
		local killer_data = active_ff:get_mydata(killer_sid)
		if killer_data == nil then
			look('_on_playerdead get killer data erro')
			return
		end
		-- �Է���ն����Ӧ���� * �Լ���նϵ��
		local base = get_kills_pos(deader_kill_c) 					-- ���������ߵ�ǰ��ն��û�������
		local killer_kill_c = GetTempTitle(killer_sid,1,1) or 0
		local _, radio = get_kills_pos(killer_kill_c) 				-- ����ɱ���ߵ�ǰ��ն��û��ֱ���
		local score = (base or 10) * (radio or 1)
		add_score(killer_sid,score)		-- ���·���
		-- ��նɱ���� +1
		SetTempTitle(killer_sid,1,1,1,1)
		-- ������ɱ���� +1 (�������������)
		killer_data.kill_m = (killer_data.kill_m or 0) + 1
		update_tops(2,killer_data.kill_m,killer_sid)
		-- ����и���buff �Ƴ�֮��
		CI_DelBuff(241,2,killer_sid)
		killer_data.dead_c = 0	-- ���������λɱ����������������
		if deader_kill_c >= 5 then
			local killer_name = CI_GetPlayerData(5,2,killer_sid)
			local deader_name = CI_GetPlayerData(5,2,deader_sid)
			RegionRPC(mapGID,'ff_notice',1,killer_name,deader_name,deader_kill_c)
		end
	end
	-- ȡ�������б� +1��
	local zglist = CI_GetPKList(20,5)
	look('zglist++++++++++++++++')
	look(zglist)
	if type(zglist) == type({}) then
		for _, pid in pairs(zglist) do			
			if pid ~= killer_sid then		-- ��ɱ���߲żӻ���
				add_score(pid,1)
			end
		end
	end
end

-- ��Ҹ����
local function _on_playerlive(self,sid)
	look('active_ff:_on_playerlive')
	local active_ff = activitymgr:get(active_name)
	if active_ff == nil then 
		look('active_ff:_on_playerlive active_ff == nil')
		return 
	end
	local fac_id = get_faction_union(sid,1)
	if fac_id == nil or fac_id <= 0 then		
		return 
	end
	local sign_list = get_sign_list()
	if sign_list == nil or sign_list[fac_id] == nil or sign_list[fac_id].side == nil then 
		return 
	end	
	local t = sign_list[fac_id]	
	local poslist
	-- ȡ����� �ж��Ƿ��Ѿ�ռ�츴���
	if t.hold then
		poslist = ff_config.relive_pos[t.hold]
	else
		poslist = ff_config.enter_pos[t.side]
	end
	if poslist == nil then
		look('active_ff:_on_playerlive relive_pos erro')
		return 
	end
	-- local idx = math_random(1,#poslist)
	local x = poslist[1]
	local y = poslist[2]
	local _,_,_,mapGID = CI_GetCurPos()
	if not PI_MovePlayer(0,x,y,mapGID,2,sid) then
		look('active_ff:_on_playerlive PI_MovePlayer erro')
		return
	end
	return 1
end

-- �����ϴλ����
local function clear_active_common()
	local common_data = get_ff_data()
	if common_data == nil then
		look('ff clear_active_common get_common erro')
		return
	end	
	common_data.tops = nil
end

-- ����npc
local function npc_create(mapGID)
	local CreateObjectIndirectEx = CreateObjectIndirectEx
	-- ��������ܹ�
	for i = 400401, 400403 do
		if npclist[i] then
			npclist[i].NpcCreate.regionId = mapGID
			CreateObjectIndirectEx(1,i,npclist[i].NpcCreate)			
		end
	end
	-- ���������İ���
	for i = 400410, 400417 do
		if npclist[i] then
			npclist[i].NpcCreate.regionId = mapGID
			CreateObjectIndirectEx(1,i,npclist[i].NpcCreate)
		end
	end
	-- ����դ��
	for i = 400430, 400447 do
		if npclist[i] then
			npclist[i].NpcCreate.regionId = mapGID
			CreateObjectIndirectEx(1,i,npclist[i].NpcCreate)
		end
	end
end

-- ��������(����ˮ��(�����ﴦ��))
local function monster_create(mapGID)	
	local monster_conf = ff_config.monster[1]
	for _, conf in pairs(monster_conf) do
		conf.regionId = mapGID
		local mon_gid  = CreateObjectIndirect(conf)	
		look(mon_gid)		
	end
end

-- ��������
local function _on_regioncreate(slef,mapGID,args)
	look('mapGID:' .. mapGID)
	npc_create(mapGID)		-- ����npc
	monster_create(mapGID)	-- ��������
end

-- �����л�
local function _on_regionchange(slef,sid)
	look('active_ff:_on_regionchange')
	-- �����ն
	ClrTempTitle(sid)
	local buffid = 152
	if buffid then
		CI_DelBuff(buffid,2,sid)
	end
end

-- ���������
local function _on_active_end()
	-- ����ʤ����Ӫ
	set_fight_result()
	-- ����XX��ҷ��Ͷ��⽱���ʼ�
	local tops = get_tops()
	if type(tops) == type({}) then
		local SendSystemMail = SendSystemMail
		for k, v in pairs(tops) do
			if type(k) == type(0) and type(v) == type({}) then
				look(v[2])
				look(k)
				SendSystemMail(v[2],MailConfig.ff,k,2) 
			end
		end
	end
end

-- ������ߴ���
local function _on_login(self,sid)
	local block = _ff_get_block()	
	RPC('ff_online',0,block)
end

-- ��Զ���ӿڴ�����ע��
local function ff_register_func(active_ff)
	active_ff.on_regioncreate = _on_regioncreate
	active_ff.on_regionchange = _on_regionchange
	active_ff.on_playerdead = _on_playerdead
	active_ff.on_playerlive = _on_playerlive
	active_ff.on_login = _on_login
	active_ff.on_active_end = _on_active_end	
end

-- ���սͬ������
local function _ff_sync_data()
	local flags = get_active_flags()
	if flags ~= 3 then
		return false
	end
	local pub_data = get_pub_data()
	if pub_data == nil then 
		return false
	end
	local sclist = get_scorelist_data(1,active_type)
	if pub_data.gid then
		RegionRPC(pub_data.gid,'ff_sync_data',0,pub_data.qz,sclist)
	end	
	return true
end

-- ÿ2��ռ�����ļӷ�
local function _ff_flags_score()
	local flags = get_active_flags()
	if flags ~= 3 then
		return false
	end
	local pub_data = get_pub_data()
	if pub_data == nil then 
		return false
	end	
	if pub_data.qz then
		local fac_id = pub_data.qz
		local ple_id = get_faction_union(nil,2,fac_id)
		update_faction_data(fac_id,1,20)
		FactionRPC(fac_id,'ff_flags_score',20)
		if ple_id and fac_id ~= ple_id then
			FactionRPC(ple_id,'ff_flags_score',20)
		end
	end
	return true
end

-- @flags: [1] signing [2] matcahing [3] fighting
local function _ff_start(flags)
	if flags == nil then return end
	local active_ff = activitymgr:get(active_name)
	
	-- [1] ���ʼ(����)
	if flags == 1 then		
		if active_ff then
			look('ff_start1: active_ff has not end')
			return
		end
		-- �����
		active_ff = activitymgr:create(active_name)
		if active_ff == nil then
			look('ff_start1: create active erro')
			return
		end
		-- �����ϴλ����
		clear_active_common()
		-- ע���ຯ��(internal use)
		ff_register_func(active_ff)
		BroadcastRPC('ff_start',1)
	-- [2] ��ʼƥ��(����û��ƥ���ˡ�ֻ������������)
	elseif flags == 2 then
		-- �����
		local active_ff = activitymgr:create(active_name)
		if active_ff == nil then
			look('ff_start1: create active erro')
			return
		end
		-- �����ϴλ����
		clear_active_common()
		-- ע���ຯ��(internal use)
		ff_register_func(active_ff)
		
		-- ��������
		local gid = active_ff:createDR(1)
		if gid then
			local pub_data = active_ff:get_pub()
			if pub_data then
				pub_data.gid = gid
			end
		end
		active_ff:set_state(2)
		_ff_set_block(0)
		BroadcastRPC('ff_start',2)
		SetEvent(30,nil,'GI_ff_set_block',1)
		-- do_match()
	-- [2] ��ʼս��
	elseif flags == 3 then
		if active_ff == nil then 
			look('ff_start2: active_ff == nil')
			return
		end
		active_ff:set_state(3)
		BroadcastRPC('ff_start',3)
		-- ÿ10����ͬ�����ս�����Ϣ(���֡���Դ������)
		SetEvent(10,nil,'GI_ff_sync_data')
		-- ÿ����ȡ������ļӻ���
		SetEvent(2,nil,'GI_ff_flags_score')
	end
end

-- ��Ҵ򿪱������
local function _ff_panel_sign(sid)
	local fac_id = get_faction_union(sid,1)
	if fac_id == nil or fac_id <= 0 then	
		RPC('ff_panel_sign',1)				-- �ް��
		return 
	end
	local flags = get_active_flags()
	if flags == 0 then
		RPC('ff_panel_sign',2)				-- ��ѽ���
		return 
	end
	local sign_list = get_sign_list()
	if sign_list == nil then
		return
	end	
	if sign_list[fac_id] == nil then
		sign_list[fac_id] = {}
	end	
	local t = sign_list[fac_id]
	RPC('ff_panel_sign',0,flags,t.ct,t[sid])
end

-- ����
local function _ff_sign_up(sid)
	-- assert: �Ƿ��а��
	local myfid = CI_GetPlayerData(23)
	if myfid == nil or myfid <= 0 then	-- �ް��
		RPC('ff_sign',1)
		return 
	end
	look('myfid:' .. tostring(myfid))
	local fac_id = get_faction_union(sid,1,myfid)
	if fac_id == nil or fac_id <= 0 then	
		RPC('ff_sign',1)				-- �ް��
		return 
	end
	--look('fac_id:' .. tostring(fac_id))
	-- assert: �Ƿ��ڱ���״̬
	local flags = get_active_flags()
	if flags ~= 1 then
		RPC('ff_sign',2)
		return 
	end
	local sign_list = get_sign_list()
	if sign_list == nil then
		return
	end	
	if sign_list[fac_id] == nil then
		sign_list[fac_id] = {}
	end	
	local t = sign_list[fac_id]
	-- assert: �Ƿ��Ѿ������ɹ�
	if t.ct and t.ct >= min_player then
		RPC('ff_sign',3)
		return
	end
	-- assert: ������Ƿ��Ѿ�����
	if t[sid] == 1 then
		RPC('ff_sign',4)
		return
	end	
	-- ������ұ���״̬
	t[sid] = 1
	t.ct = (t.ct or 0) + 1				-- ��������+1
	-- �Ƿ��Ѿ��ﵽ�ɹ���������
	if t.ct >= min_player then
		local fac_data = GetFactionData(fac_id)		-- �����ϴΰ��ս����
		if fac_data then
			fac_data.c_score = nil
		end
		FactionRPC(fac_id,'ff_success')		-- ֪ͨ������ᱨ���ɹ�
		if myfid ~= fac_id then
			FactionRPC(myfid,'ff_success')	-- ֪ͨ�Լ���ᱨ���ɹ�
		end
		set_cur_pos(fac_id)				-- ���ý����
	end
	
	RPC('ff_sign',0,t.ct)				-- ��ұ����ɹ�
end

-- ��ҽ�����ս
local function _ff_enter(sid,enterX,enterY)
	local active_ff = activitymgr:get(active_name)
	if active_ff == nil then
		look('_ff_enter active_ff == nil')
		return
	end
	local fac_id = get_faction_union(sid,1)
	if fac_id == nil or fac_id <= 0 then	
		RPC('ff_enter',1)					-- �ް��
		return 
	end	
	local flags = get_active_flags()
	if flags ~= 3 then
		RPC('ff_enter',2)					-- ��û����ʼ���ʱ��
		return 
	end
	-- ��һ�������ʱ�����ø����
	set_cur_pos(fac_id)
	local sign_list = get_sign_list()
	if sign_list == nil then return end
	local t = sign_list[fac_id]		
	
	if t.side == nil then
		look('set_cur_pos error')
		return
	end
	local pub_data = active_ff:get_pub()
	if pub_data == nil then return end
	-- ��ȡ���ս��ͼGID
	local gid = pub_data.gid
	if gid == nil then
		look('active_ff create region error')
		return
	end
	local poslist
	-- ���ý���� �ж��Ƿ��Ѿ�ռ�츴���
	if t.hold then
		poslist = ff_config.relive_pos[t.hold]
	else
		poslist = ff_config.enter_pos[t.side]
	end
	if poslist == nil then return end
	-- local idx = math_random(1,#poslist)
	local x = enterX or poslist[1]
	local y = enterY or poslist[2]
	if not active_ff:add_player(sid,1,0,x,y,gid) then
		look('active_ff:add_player erro')
		return
	end
	local block = _ff_get_block()
	RPC('ff_enter',0,block)
end

-- �˳������
local function _ff_exit(sid)
	look('_ff_exit')
	local active_ff = activitymgr:get(active_name)
	if active_ff == nil then	
		look('_ff_exit active_ff == nil')
		return
	end	
	active_ff:back_player(sid)
end

local _awards = {}

-- ��ȡ������������
local function get_faction_rank(fac_id)
	look('get_faction_rank')
	local sclist = get_scorelist_data(1,active_type)
	look(sclist)
	look(fac_id)
	if sclist then
		for k, v in ipairs(sclist) do
			if v[4] == fac_id then
				return k
			end
		end
	end
end

-- ���ɽ��������Ϣ
local function _ff_build_award(dayscore,frank,tops,pname)
	if dayscore <= 0 then
		return
	end
	-- ��������
	for k, v in pairs(_awards) do
		_awards[k] = nil
	end
	local wlevel = GetWorldLevel() or 1
	if wlevel < 30 then wlevel = 30 end
	look('_ff_build_award wlevel: ' .. tostring(wlevel))
	local field = (rint(dayscore / 100) + 4) / 10
	if field > 1 then field = 1 end
	local exps = rint( (wlevel ^ 2.2 * 27 * 9 * 7 / 8) * field )
	local bg = rint( (wlevel * 8) * field )		
	
	-- for k, v in pairs(tops) do
		-- if type(k) == type(0) and type(v) == type({}) then
			-- if pname == v[2] then
				-- if k == 1 then
					-- bg = bg + 100
				-- elseif k == 2 then
					-- bg = bg + 100
				-- elseif k == 3 then
					-- bg = bg + 100
				-- elseif k == 4 then
					-- bg = bg + 100
				-- end
			-- end
		-- end
	-- end 
	
	local box_id
	if frank then		
		if frank == 1 then
			box_id = 1078
		elseif frank >= 2 and frank <= 3 then
			box_id = 1079
		elseif frank >= 4 and frank <= 10 then
			box_id = 1080
		end
	end
	
	_awards[2] = exps
	_awards[3] = {}
	_awards[6] = bg
	
	if box_id then
		table_insert(_awards[3],{box_id,1,1})
	end		
	
	return _awards
end

-- ���ͽ����Ϣ
local function _ff_report_result(sid,bget)
	look('_ff_report_result')
	local active_ff = activitymgr:get(active_name)
	-- ������û����,�����콱
	if active_ff then 
		local active_flags = active_ff:get_state()
		if active_flags ~= 0 then
			look('_ff_report_result active_ff is alive:' .. tostring(sid),1)
			return
		end		
	end
	local fac_id = get_faction_union(sid,1)
	if fac_id == nil or fac_id <= 0 then
		look('_ff_report_result error 2:' .. tostring(sid),1)
		return
	end
	local fac_data = GetFactionData(fac_id)
	if fac_data == nil then
		look('_ff_report_result error 3:' .. tostring(sid),1)
		return
	end
	local pname = CI_GetPlayerData(5,2,sid)
	local dayscore = sc_getdaydata(sid,active_type) or 0		-- ÿ�ջ���	
	local tops = get_tops()									-- ȡ����֮��
	local frank = get_faction_rank(fac_id) or 0
	local award = _ff_build_award(dayscore,frank,tops,pname)	-- ���콱��
	look('award-------------')
	look(award)
	look('frank:' .. tostring(frank))
	if bget then
		return award
	else
		RPC('ff_result_panel',dayscore,tops,award,frank,fac_data.c_score)
	end
end

-- ������
local function _ff_give_award(sid)
	look('_ff_give_award')
	local dayscore = sc_getdaydata(sid,active_type) or 0
	if dayscore <= 0 then		
		RPC('ff_award',1)
		return
	end
	local award = _ff_report_result(sid,1)
	look(award)
	if award == nil then return end
	local getok = award_check_items(award)
	if not getok then
		return
	end
	-- ֻ��ͳ��(���ڻ�Ծ��)
	CheckTimes(sid,TimesTypeTb.Fight_Time,1)
	-- �����콱��־(������0)
	sc_reset_getawards(sid,active_type)
	local ret = GI_GiveAward(sid,award,"���ս����")
	RPC('ff_award',0)
	-- ���������
	_ff_exit(sid)
end

-- ռ�츴���(���ø�����������)
local function _ff_owner_relive(cid)
	local flags = get_active_flags()
	if flags ~= 3 then
		return
	end
	local pub_data = get_pub_data()
	if pub_data == nil then
		return
	end
	local sign_list = get_sign_list()
	if sign_list == nil then
		return
	end
	local sid = CI_GetPlayerData(17) or 0
	if sid <= 0 then
		return
	end
	local idx = cid - BASEID + 1
	if idx <= 0 then 
		return 
	end
	look('_ff_owner_relive idx:' .. tostring(idx))
	local fac_id = get_faction_union(sid,1)
	if fac_id == nil or fac_id <= 0 then return end
	if sign_list[fac_id] == nil then
		return
	end
	if sign_list[fac_id].hold then			-- �Ѿ�ռ����Ͳ�����ռ����
		RPCEx(sid,'ff_owner_relive',1)
		return
	end
	pub_data.relives = pub_data.relives or {}
	local oldfid = pub_data.relives[idx]	
	pub_data.relives[idx] = fac_id 			-- ����Ϊ�µ�factionid	
	if sign_list[oldfid] then				-- ɾ���ɵ�
		sign_list[oldfid].hold = nil
	end
	sign_list[fac_id].hold = idx			-- ����ռ��ˮ��
	-- ���¸���ˮ���������(���¹���������)
	local fac_name = CI_GetFactionInfo(fac_id,1)
	look('owner fac_name:' .. fac_name)
	CI_UpdateMonsterData(2,fac_name,6,cid)

	-- ռ�츴���ɹ�(+100����)	
	RPCEx(sid,'ff_owner_relive',0)
	-- �㲥
	if pub_data.gid then
		RegionRPC(pub_data.gid,'ff_broadcast',1,fac_name,idx)
	end
end

-- ռ������(ˢһ��������)
local function _ff_occupy_flags(sid)
	if sid == nil then return end
	local flags = get_active_flags()
	if flags ~= 3 then
		return
	end
	local fac_id = get_faction_union(sid,1)
	if fac_id == nil or fac_id <= 0 then return end
	local pub_data = get_pub_data()
	if pub_data == nil then
		return
	end
	if pub_data.qz then				-- �Ѿ�����ռ������
		if pub_data.qz == fac_id then
			RPCEx(sid,'ff_occupy_flags',1)
		else
			RPCEx(sid,'ff_occupy_flags',2)
		end
		return
	end
	
	-- �����ж���������
	local x,y,rid,mapGID = CI_GetCurPos(2,sid)
	if x and y then
		if x < 42 or x > 55 or y < 90 or y > 103 then
			RPCEx(sid,'ff_occupy_flags',3)
			return
		end
	end
	
	-- ����ʱ����
	CI_SetReadyEvent(0,ProBarType.hold,3,1,'GI_ff_Owner_flags')		
end

local function _ff_owner_flags()
	look('_ff_owner_flags')
	local flags = get_active_flags()
	if flags ~= 3 then
		return
	end
	local sid = CI_GetPlayerData(17)
	local fac_id = get_faction_union(sid,1)
	if fac_id == nil or fac_id <= 0 then return end
	local pub_data = get_pub_data()
	if pub_data == nil then
		return
	end
	if pub_data.qz then				-- �Ѿ�����ռ������
		if pub_data.qz == fac_id then
			RPCEx(sid,'ff_occupy_flags',1)
		else
			RPCEx(sid,'ff_occupy_flags',2)
		end
		return
	end
	
	local sign_list = get_sign_list()
	if sign_list == nil or sign_list[fac_id] == nil then
		return
	end
	local mon_conf = ff_config.monster[2]
	if mon_conf == nil then
		return
	end
	local monhp = 500
	if pub_data.bfirst == nil then 		-- ��һ��ս��
		monhp = 100
		pub_data.bfirst = 1
	else
		local frank = get_faction_rank(fac_id)
		if frank then
			if frank == 1 then
				monhp = 30
			elseif frank == 2 then
				monhp = 80
			elseif frank == 3 then
				monhp = 200
			elseif frank == 4 then
				monhp = 300
			end
		end
	end
	mon_conf.regionId = pub_data.gid
	mon_conf.x = 49
	mon_conf.y = 96
	mon_conf.monAtt = mon_conf.monAtt or {}
	mon_conf.monAtt[1] = monhp							-- ������������Ѫ����ͬ
	local mon_gid = CreateObjectIndirect(mon_conf)
	look('mon_gid:' .. mon_gid)
	local fac_name = CI_GetFactionInfo(fac_id,1)
	if mon_gid then					 
		CI_UpdateMonsterData(2,fac_name,4,mon_gid)		-- ���¹���������
	end
	pub_data.qz = fac_id			-- ���������������
	-- ռ��ɹ�(+100����)
	add_score(sid,100)
	RPCEx(sid,'ff_occupy_flags',0)
	-- �㲥����ɹ�
	if pub_data.gid then
		RegionRPC(pub_data.gid,'ff_broadcast',2,fac_name)
	end
end

-- �ύ��Դ
local function _ff_submit_res(sid)
	look('_ff_submit_res 1')
	local flags = get_active_flags()
	if flags ~= 3 then
		RPC('ff_submit_res',1)
		return
	end
	look('_ff_submit_res 2')
	local fac_id = get_faction_union(sid,1)
	if fac_id == nil or fac_id <= 0 then			
		return 
	end	
	local buffid
	if CI_HasBuff(152,2,sid) then
		buffid = 152
	end	
	if buffid then
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			local info = GetStringMsg(14,1)
			TipCenter(info) 
			return
		end
		GiveGoods(688,2,1,"���ս")
		
		CI_DelBuff(buffid,2,sid)
		local res = 1					-- ��Դ�� ���ڸ������������
		add_score(sid,10)								-- ���Ӹ��˻���/������
		-- �������������
		local active_ff = activitymgr:get(active_name)
		if active_ff == nil then return end
		local my_data = active_ff:get_mydata(sid)
		if my_data == nil then return end
		my_data.col_m = (my_data.col_m or 0) + res
		update_tops(3,my_data.col_m,sid)
	end
end

-- ���
local function _ff_rescue(cid)
	look('_ff_rescue 1')
	local flags = get_active_flags()
	if flags ~= 3 then
		return
	end
	look('_ff_rescue 2')
	local npcid = GetNpcidByUID(cid)
	if npclist[npcid] == nil then		
		return
	end
	look('_ff_rescue 3')
	local sid = CI_GetPlayerData(17) or 0
	if sid <=0 then
		return
	end
	look('_ff_rescue 4')
	if CI_HasBuff(152,2,sid) then
		return
	end
	local buffid = 152
	CI_AddBuff(buffid,0,1,false,2,sid)
end

local function _ff_get_score(sid)
	local fac_id = get_faction_union(sid,1)
	if fac_id == nil or fac_id <= 0 then return end
	local fac_data = GetFactionData(fac_id)
	if fac_data == nil then return end
	RPC('ff_score_c',fac_data.c_score or 0)
end

-- call_npc_click[50010] = function ()
	-- local cid = GetObjectUniqueId()
	-- local npcid = GetNpcidByUID(cid)
	-- if npclist[npcid] == nil then
		-- look('call_npc_click 50010 npcid erro')
		-- return
	-- end
	-- local pb_type = npclist[npcid].PBType or 1
	-- CI_SetReadyEvent( cid,pb_type,5,0,"GI_ff_owner_relive" )
-- end

-- ���
call_npc_click[50011] = function ()
	local cid = GetObjectUniqueId()
	local npcid = GetNpcidByUID(cid)
	if npclist[npcid] == nil then
		look('call_npc_click 50011 npcid erro')
		return
	end
	local pb_type = npclist[npcid].PBType or 1
	CI_SetReadyEvent( cid,pb_type,3,0,"GI_ff_rescue" )
end

-- ���Ĺ�������
call_monster_dead[4201] = function(mapGID)
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then
		return
	end
	local pub_data = get_pub_data()
	if pub_data == nil then
		return
	end
	pub_data.qz = nil		-- ���ı�����
	-- ��������(+100����)
	add_score(sid,100)
	-- �㲥��������
	local pname = CI_GetPlayerData(5)
	if pub_data.gid then
		RegionRPC(pub_data.gid,'ff_broadcast',3,pname)
	end
end

-- ռ�츴��ˮ��
call_monster_chick[10] = function()
	local _,cid = GetObjectUniqueId()
	if cid == nil then return end
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then
		return
	end
	local fac_id = get_faction_union(sid,1)
	if fac_id == nil then return end
	local sign_list = get_sign_list()
	if sign_list == nil or sign_list[fac_id] == nil then return end
	local t = sign_list[fac_id]
	if t.hold then
		RPCEx(sid,'ff_owner_relive',1)
		return
	end
	
	CI_SetReadyEvent( cid,ProBarType.hold,5,0,"GI_ff_owner_relive" )
end

------------------------------------------------------
--interface:

ff_start = _ff_start
ff_panel_sign = _ff_panel_sign
ff_sign_up = _ff_sign_up
ff_enter = _ff_enter
ff_exit = _ff_exit
ff_build_tower = _ff_build_tower
ff_sync_data = _ff_sync_data
ff_owner_relive = _ff_owner_relive
ff_rescue = _ff_rescue
ff_submit_res = _ff_submit_res
ff_report_result = _ff_report_result
ff_give_award = _ff_give_award
ff_occupy_flags = _ff_occupy_flags
ff_owner_flags = _ff_owner_flags
ff_get_score = _ff_get_score
ff_set_block = _ff_set_block
ff_flags_score = _ff_flags_score