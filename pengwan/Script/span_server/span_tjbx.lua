--[[
file:	tjbx.lua
desc:	�콵����
author:	wk
update:	2013-12-16
]]--


local active_mgr_m = require('Script.active.active_mgr')
local activitymgr=active_mgr_m.activitymgr
local uv_TimesTypeTb = TimesTypeTb
local CheckTimes=CheckTimes
local define		= require('Script.cext.define')
local ProBarType = define.ProBarType
local BroadcastRPC=BroadcastRPC
local RegionRPC=RegionRPC
local TipCenter=TipCenter
local PI_PayPlayer=PI_PayPlayer
local SetEvent=SetEvent
local CI_SetReadyEvent=CI_SetReadyEvent
local call_npc_click = call_npc_click
local look = look
local SendLuaMsg=SendLuaMsg
local _random,_floor=math.random,math.floor
local CreateObjectIndirectEx=CreateObjectIndirectEx
local CI_GetCurPos=CI_GetCurPos
local CI_GetPlayerData=CI_GetPlayerData
local GetObjectUniqueId=GetObjectUniqueId
local GetServerTime=GetServerTime
local CI_SelectObject=CI_SelectObject
local RPC=RPC
local GetWorldLevel=GetWorldLevel
local GetStringMsg=GetStringMsg
local type=type
local pairs=pairs
local npclist = npclist
local table_locate = table.locate
local CreateObjectIndirect = CreateObjectIndirect
local call_OnMapEvent=call_OnMapEvent
local PI_MovePlayer=PI_MovePlayer
local call_npc_click=call_npc_click
local GI_GiveAward=GI_GiveAward
local RemoveObjectIndirect=RemoveObjectIndirect
local isFullNum=isFullNum
local GiveGoodsBatch=GiveGoodsBatch
local common_time = require('Script.common.time_cnt')
local GetTimeThisDay = common_time.GetTimeThisDay
local __G = _G
----------------------------------------------------------------------------
-- module:

module(...)

----------------------------------------------------------------------------

local t_conf = {
	-- �ɼ�npc
	npc_site ={400560,400584}, --ˢ��npc ��ʼ-����npcid

	refresh={---�ɼ�ʱ��,ˢ��ʱ��
		[1]={20,120},
		[2]={10,60},
		[3]={10,60},
		[4]={10,60},
		[5]={10,60},
		[6]={3,1},
	},

	--����--ͨ�ý�������
	awards={
		[1]={--���籦��
			[1]=100000,
			[5]=100000,
			[2]=250000,
			},
		[2]={--��������
			[5]=100000,
			},
		[3]={--�׻�����
			[1]=100000,
			},
		[4]={--��ȸ����
			[2]=200000,
			},
		[5]={--���䱦��
			[4]=100,
			},
		[6]={--��ͨ����
			[1]=30000,
			[5]=30000,
			},
	},
	luckAwards= { --10%���ʻ�ö��⽱��
		[1]={--���籦��
			{673,1,1}
			},
		[2]={--��������
			{603,20,1}
			},
		[3]={--�׻�����
			{601,20,1}
			},
		[4]={--��ȸ����
			{672,5,1}
			},
		[5]={--���䱦��
			{640,4,1}
			},
	
	},

}
------------------------------------------------------

local active_name = 'span_tjbx'

--�콵��������
local function tjbx_getactdata(gid)
	local Active_tjbx=activitymgr:get(active_name)
	if Active_tjbx==nil then return end 
	--[[
		[1]=111,���籦���´�ˢ��ʱ��
		[2]=111,���������´�ˢ��ʱ��
		[3]=111,�׻������´�ˢ��ʱ��
		[4]=111,��ȸ�����´�ˢ��ʱ��
		[5]=111,���䱦���´�ˢ��ʱ��
	]]
	return Active_tjbx:get_regiondata(gid)
end

--����NPC
local function _creat_npc_monster( mapGID )
	local npc_conf = t_conf.npc_site
	for i=npc_conf[1], npc_conf[2] do
		local t = npclist[i]		
		if type(t) == type({}) then
			t.NpcCreate.regionId = mapGID
			t.NpcCreate.clickScript = t.NpcCreate.clickScript or 30000
			CreateObjectIndirectEx(1,i,t.NpcCreate)		-- ����NPC
		end
	end
end

--��������ص�
local function _tjbx_regioncreate(slef,mapGID)
	local now = GetServerTime()
	local bt_1 = GetTimeThisDay(now,14,10,0) + 60
	local et_1 = GetTimeThisDay(now,16,0,0)
	local bt_2 = GetTimeThisDay(now,21,10,0) + 60

	if now < bt_1 then
		local sec = bt_1 - now
		if sec > 10 * 60 then return end
		SetEvent(sec, nil, 'GI_spantjbx_create', mapGID)
		return
	end
	if now > et_1 and now < bt_2 then
		local sec = bt_2 - now
		if sec > 10 * 60 then return end
		SetEvent(sec, nil, 'GI_spantjbx_create', mapGID)
		return
	end
	
	_creat_npc_monster( mapGID )
end
-- ��Ҹ����
local function _on_playerlive(self,sid)	
	look('_on_playerlive')
	local Active_tjbx = activitymgr:get(active_name)
	if Active_tjbx == nil then 
		look('_on_playerlive Active_tjbx == nil')
		return 
	end
	local _,_,_,mapGID = CI_GetCurPos()
	if not PI_MovePlayer(0,37,107,mapGID,2,sid) then
		look('_on_playerlive PI_MovePlayer erro')
		return
	end
	return 1
end
--�����ʱע��
local function active_tjbx_regedit(Active_tjbx)
	Active_tjbx.on_regioncreate=_tjbx_regioncreate
	Active_tjbx.on_playerlive = _on_playerlive
end

-------------------------------------------------------------------------

--��ʼ
local function _span_tjbx_start()
	--local Active_tjbxold=activitymgr:get(active_name)
	-- if Active_tjbxold then
		-- look('�������')
		-- return
	-- end
	activitymgr:create(active_name)
	local Active_tjbx=activitymgr:get(active_name)
	active_tjbx_regedit(Active_tjbx)
	Active_tjbx:createDR(1)
	-- BroadcastRPC('tjbx_Start')
end
--����
local function _span_tjbx_enter(sid)
	local Active_tjbx=activitymgr:get(active_name)
	if Active_tjbx==nil then
		return
	end
	if Active_tjbx:is_active(sid) then
		return
	end
	local mapGID = __G.GetPlayerSpanGID(sid)
	if mapGID == nil then
		return
	end
	
	-- put player to region
	local ret, gid = Active_tjbx:add_player(sid, 1, 0, nil, nil, mapGID)
	if not ret then
		look('_span_tjbx_enter add_player erro',1)
		return
	end	
	
	local tdata=tjbx_getactdata(gid)
	if tdata==nil then return end
	RPC('tjbx_in',tdata)
	
	return true
end
--�˳�
local function _span_tjbx_exit(sid)
	local Active_tjbx=activitymgr:get(active_name)
	if Active_tjbx==nil then
		return
	end
	Active_tjbx:back_player(sid)
end


-- ����ñ���
call_npc_click[50023]=function ()	
	local sid= CI_GetPlayerData(17)
	local pakagenum = isFullNum()
	if pakagenum < 1 then --�жϱ����ռ��Ƿ��㹻
		TipCenter(GetStringMsg(14,1))
		return 
	end
	local res=CheckTimes(sid,uv_TimesTypeTb.tjbx,1,-1,1)
	if not res then  
		TipCenter(GetStringMsg(20))
		return 
	end
	local controlID,cid = GetObjectUniqueId()
	local npcid=controlID-100000
	local index=npcid-t_conf.npc_site[1]+1
	if index>6 then 
		index=6
	end
	local needtime=t_conf.refresh[index][1]
	CI_SetReadyEvent(controlID,ProBarType.collect,needtime,1,'GI_span_chick_tjbx')
end
--������ص�
local function _span_chick_tjbx(controlID )
	local sid= CI_GetPlayerData(17)
	local _,_,rid,mapGID = CI_GetCurPos(6,controlID)
	local a=CI_SelectObject(6, controlID, mapGID )
	if (not a ) or a<1 then
		TipCenter(GetStringMsg(436))
		return 0
	end

	local npcid=controlID-100000
	local index=npcid-t_conf.npc_site[1]+1
	if index>6 then 
		index=6
	end

	local res
	if index<6 then 
		local rannum=_random(1,100)
		if rannum<=10 then 
			res=true
			local goods=t_conf.luckAwards[index]
			GiveGoodsBatch(goods,'�콵����')
		end
	end

	local AwardTb=t_conf.awards[index]
	local now=GetServerTime()
	CheckTimes(sid,uv_TimesTypeTb.tjbx,1,-1)
	GI_GiveAward( sid, AwardTb, "�콵����" )
	local tdata=tjbx_getactdata(mapGID)
	local _time=t_conf.refresh[index][2]

	tdata[index]=now+_time
	if index<6 then 
		RegionRPC(mapGID,'tjbx_up',index,tdata[index],sid,res,CI_GetPlayerData(3))
	else
		RPC('tjbx_succ')
	end
	SetEvent(_time, nil, "GI_span_tjbx_refresh",npcid,mapGID) 
	RemoveObjectIndirect( mapGID, controlID )
	return 1
end

--��ˢnpc
local function _span_tjbx_refresh( npcid ,rgid)
	look('��ˢnpc')
	look(npcid)
	look(rgid)
	local npc = npclist[npcid]
	npc.NpcCreate.regionId=rgid
	CreateObjectIndirectEx(1,npcid,npc.NpcCreate)
end

local function _stjbx_get_rooms(svrid,uid,con,idx)
	if svrid == nil then return end
	local Active_tjbx = activitymgr:get(active_name)
	if Active_tjbx == nil then
		look('_stjbx_get_rooms Active_tjbx == nil')
		__G.PI_SendToLocalSvr(svrid, {ids = 5001, uid = uid, con = con, idx = idx })
		return
	end	
	local active_flags = Active_tjbx:get_state()
	if active_flags == 0 then
		look('_stjbx_get_rooms Active_tjbx has end')
		__G.PI_SendToLocalSvr(svrid, {ids = 5001, uid = uid, con = con, idx = idx })
		return
	end
	__G.PI_SendToLocalSvr(svrid, {ids = 5001, uid = uid, con = con, idx = idx, rooms = Active_tjbx.room })
end

-------------------------------------------------------------------
span_tjbx_start=_span_tjbx_start--��ʼ
span_tjbx_enter=_span_tjbx_enter--����
span_tjbx_exit=_span_tjbx_exit--�˳�
span_chick_tjbx=_span_chick_tjbx
span_tjbx_refresh=_span_tjbx_refresh
stjbx_get_rooms = _stjbx_get_rooms
creat_npc_monster = _creat_npc_monster