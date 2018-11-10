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
local GetServerOpenTime = GetServerOpenTime
local common_time = require('Script.common.time_cnt')
local GetDiffDayFromTime=common_time.GetDiffDayFromTime
local Log = Log
local PI_GiveGoodsEx = PI_GiveGoodsEx
local MailConfig = MailConfig
----------------------------------------------------------------------------
-- module:

module(...)
mapGID1=mapGID1 or 0
----------------------------------------------------------------------------

local t_conf = {
	-- �ɼ�npc
	npc_site ={400510,400534}, --ˢ��npc ��ʼ-����npcid

	refresh={---�ɼ�ʱ��,ˢ��ʱ��
		[1]={20,180},
		[2]={10,90},
		[3]={10,90},
		[4]={10,90},
		[5]={10,90},
		[6]={3,5},
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

--�콵��������
local function tjbx_getactdata(gid)
	local Active_tjbx=activitymgr:get('tjbx')
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
local function creat_npc_monster( mapGID )
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
	look('��������ص�')
	mapGID1=mapGID
	creat_npc_monster( mapGID )
end
-- ��Ҹ����
local function _on_playerlive(self,sid)	
	look('_on_playerlive')
	local Active_tjbx = activitymgr:get('tjbx')
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
local function _tjbx_start()
	--local Active_tjbxold=activitymgr:get('tjbx')
	-- if Active_tjbxold then
		-- look('�������')
		-- return
	-- end
	-- local openTime = GetServerOpenTime()
	-- local days = GetDiffDayFromTime(openTime) + 1
	-- if days > 7 then	-- 7��֮�󲻿�������
		-- return
	-- end
	activitymgr:create('tjbx')
	local Active_tjbx=activitymgr:get('tjbx')
	active_tjbx_regedit(Active_tjbx)
	Active_tjbx:createDR(1)
	BroadcastRPC('tjbx_Start')
end
--����
local function _tjbx_enter(sid,mapGID)
	look('����')
	mapGID=mapGID or mapGID1
	look(mapGID)
	local Active_tjbx=activitymgr:get('tjbx')
	if Active_tjbx==nil then
		look('������')
		return
	end
	if   Active_tjbx:is_active(sid) then
		look(111)
		return
	end
	if not Active_tjbx:add_player(sid, 1, 0, nil, nil, mapGID) then 
		look(222)
		return 
	end
	local tdata=tjbx_getactdata(mapGID)
	if tdata==nil then look(333) return end
	RPC('tjbx_in',tdata)
end
--�˳�
local function _tjbx_exit(sid)
	local Active_tjbx=activitymgr:get('tjbx')
	if Active_tjbx==nil then
		return
	end
	Active_tjbx:back_player(sid)
end


-- ����ñ���
call_npc_click[50021]=function ()	
	look('����ñ���')
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
	CI_SetReadyEvent(controlID,ProBarType.collect,needtime,1,'GI_chick_tjbx')
end
--������ص�
local function _chick_tjbx(controlID )
	look('������ص�')
	local sid= CI_GetPlayerData(17)
	look(controlID)

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
			GiveGoodsBatch(goods,'�콵���䱩�����')
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
	SetEvent(_time, nil, "GI_tjbx_refresh",npcid,mapGID) 
	RemoveObjectIndirect( mapGID, controlID )
	return 1
end

--��ˢnpc
local function _tjbx_refresh( npcid ,rgid)
	look('��ˢnpc')
	look(npcid)
	look(rgid)
	local npc = npclist[npcid]
	npc.NpcCreate.regionId=rgid
	CreateObjectIndirectEx(1,npcid,npc.NpcCreate)
end

-------------------------------------------------------------------
tjbx_start=_tjbx_start--��ʼ
tjbx_enter=_tjbx_enter--����
tjbx_exit=_tjbx_exit--�˳�
chick_tjbx=_chick_tjbx
tjbx_refresh=_tjbx_refresh
