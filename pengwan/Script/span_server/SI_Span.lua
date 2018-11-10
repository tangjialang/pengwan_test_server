
local spboss_m = require('Script.span_server.span_boss')
local monster_create = spboss_m.monster_create
local sb_enter = spboss_m.sb_enter
local spxunbao = require('Script.span_server.span_xunbao')
local spxb_enter = spxunbao.spxb_enter
local spxb_chick = spxunbao.spxb_chick
local spxb_box_refresh = spxunbao.spxb_box_refresh
local db_module = require('Script.cext.dbrpc')
local db_get_span_sinfo = db_module.db_get_span_sinfo
local spfish_m = require('Script.active.catch_fish')
local span_catchfish_enter = spfish_m.span_catchfish_enter
local active_mgr_m = require('Script.active.active_mgr')
local activitymgr = active_mgr_m.activitymgr
local span_tjbx = require('Script.span_server.span_tjbx')
local span_tjbx_enter = span_tjbx.span_tjbx_enter
local span_chick_tjbx = span_tjbx.span_chick_tjbx
local span_tjbx_refresh = span_tjbx.span_tjbx_refresh
local creat_npc_monster = span_tjbx.creat_npc_monster
local span_sjzc_module = require('Script.span_server.span_sjzc')
local span_sjzc_enter = span_sjzc_module.span_sjzc_enter
local span_sjzc_buff_refresh = span_sjzc_module.span_sjzc_buff_refresh
local span_sjzc_camp_sync = span_sjzc_module.span_sjzc_camp_sync
local span_sjzc_on_collect = span_sjzc_module.span_sjzc_on_collect
local span_sjzc_submit_res = span_sjzc_module.span_sjzc_submit_res
local span_sjzc_box_open = span_sjzc_module.span_sjzc_box_open
local span_sjzc_box_refresh = span_sjzc_module.span_sjzc_box_refresh

-- ��ʼ�������������Ϣ
function init_span_server()
	local serverid = GetGroupID()
	if IsSpanServer() then
		db_get_span_sinfo(serverid)
	end	
end

-- �뿪����ص��ű�����
function SI_LeaveSpanServer()
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then return end
	
	-- �������ͳһ����ӿ�
	activitymgr:on_logout(sid)
	
	SetLogoutHangUpData(sid)
	setMountsLogout(sid)
	
	local cUID = GetPlayerSpanUID(sid) or 0
	
	-- �����뿪�������BUFF
	local now = GetServerTime()
	if cUID == 1 then		-- ���BOSS�
		SetSpanLeaveTime(sid,cUID,now + 5*60)	-- 5��������BUFF(���������ǰֵΪ-1 ������Ϊ0)
	elseif cUID == 5 then	-- ����콵����
		SetSpanLeaveTime(sid,cUID,now + 5*60)	-- 5��������BUFF(���������ǰֵΪ-1 ������Ϊ0)
	end
	-- if cUID == 0 then
		-- local con = GetSpanServerInfo(1)
		-- if con then
			-- SetSpanLeaveTime(sid,1,now + 5*60)	-- 5��������BUFF(���������ǰֵΪ-1 ������Ϊ0)
		-- end
	-- end
end

------------------------------------���BOSS�---------------------------
function GI_spanboss_enter(sid)
	if sb_enter(sid) then
		return true
	end
	return false
end

-- �´�ˢ�»ص�
function GI_spanboss_next(mapGID,idx)
	monster_create(mapGID,idx)
end

------------------------------------���Ѱ���---------------------------
function GI_spanxb_enter(sid)
	if spxb_enter(sid) then
		return true
	end
	return false
end
--������ص�
function GI_spxb_chick( cid )
	return spxb_chick( cid )
end
--��ˢ����npc
function GI_spxb_box_refresh( npcid ,rgid )
	spxb_box_refresh( npcid ,rgid)
end

-----------------------------------���ץ��-------------------------------
function GI_span_catchfish_enter(sid)
	return span_catchfish_enter(sid)
end

-------------------------------------����콵����------------------------------------
function GI_span_tjbx_enter(sid)
	if span_tjbx_enter(sid) then
		return true
	end
	return false
end

function GI_span_chick_tjbx( cid )
	return span_chick_tjbx( cid )
end

function GI_span_tjbx_refresh( npcid ,rgid )
	span_tjbx_refresh( npcid ,rgid)
end

function GI_spantjbx_create(mapGID)
	creat_npc_monster(mapGID)
end


-----------------------------------�������ս��------------------------------------

function GI_span_sjzc_enter(sid)
	if span_sjzc_enter(sid) then
		return true
	end
	return false
end

-- ����ս��ˢ��buffer
function GI_span_sjzc_buff_refresh()	
	span_sjzc_buff_refresh()
end

-- ����ս��ˢ�±���
function GI_span_sjzc_box_refresh()
	span_sjzc_box_refresh()
end

-- ����ս��ÿ30�������Ӫ���ָ�ǰ̨
function GI_span_sjzc_camp_sync()
	local ret = span_sjzc_camp_sync()
	if ret == true then
		return 30
	end
end

-- ����ս���ɼ�������Ƭ
function GI_span_sjzc_on_collect(cid)
	span_sjzc_on_collect(cid)
	return 1
end

-- ����ս���ύNPC
function GI_span_sjzc_submit_res()
	local sid = CI_GetPlayerData(17)
	if sid and sid > 0 then
		span_sjzc_submit_res(sid)
	end
end

-- ���²ɼ�NPC״̬
function GI_span_sjzc_update_collect(cid,mapGID)

	local ret = CI_UpdateNpcData(2,false,6,cid,mapGID)
	AreaRPC(6,cid,mapGID,'update_npc_collect',cid,false)
end