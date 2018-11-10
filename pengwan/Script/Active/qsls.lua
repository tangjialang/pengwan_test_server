--[[
file:	Active_qsls.lua
desc:	瑶池曲水流觞活动
author:	wk
update:	2012-07-25
]]--

local AreaRPC=AreaRPC
local active_mgr_m = require('Script.active.active_mgr')
local activitymgr=active_mgr_m.activitymgr
local define		= require('Script.cext.define')
local ProBarType = define.ProBarType
local BroadcastRPC=BroadcastRPC
local RegionRPC=RegionRPC
local TipCenter=TipCenter
local AddDearDegree=AddDearDegree
local PI_PayPlayer=PI_PayPlayer
local SetEvent=SetEvent
local CI_SetReadyEvent=CI_SetReadyEvent
local call_npc_click = call_npc_click
local look = look
local SendLuaMsg=SendLuaMsg
local _random,_floor=math.random,math.floor
local npclist=npclist
local CreateObjectIndirectEx=CreateObjectIndirectEx
local CI_GetCurPos=CI_GetCurPos
local CI_GetPlayerData=CI_GetPlayerData
local GetObjectUniqueId=GetObjectUniqueId
local GetServerTime=GetServerTime
local CI_SelectObject=CI_SelectObject
local RPC=RPC
local uv_TimesTypeTb = TimesTypeTb
local RemoveObjectIndirect=RemoveObjectIndirect
local CheckTimes=CheckTimes
local CI_AddBuff=CI_AddBuff
local CI_HasBuff=CI_HasBuff
local GetWorldLevel=GetWorldLevel
local GetStringMsg=GetStringMsg
local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist = sclist_m.insert_scorelist
local get_scorelist_data = sclist_m.get_scorelist_data
local sc_add=sc_add
local SendSystemMail = SendSystemMail
local MailConfig=MailConfig
local type=type
local pairs=pairs
local GetMonsterData=GetMonsterData
local CI_UpdateNpcData=CI_UpdateNpcData
----------------------------------------------------------------------------
-- module:

module(...)

----------------------------------------------------------------------------

local scoreid=2
local qs_conf = {
	duckpos ={ -- 荷叶随机刷新点{x,y};1,2,3分别代表3种荷叶外形706000,707000,708000
		[1]={ {19,16},{29,12},{33,19},{35,20},{30,33},{35,21},{35,22},{23,34},{18,33},{11,40},{34,19},{19,58},{28,59},{32,56},{36,66},{34,70},{32,72},{28,78},{15,78},{10,87},{27,95},{20,90},{20,87}},
		[2]={ {21,12},{26,12},{34,14},{35,23},{37,20},{26,34},{24,34},{20,33},{14,39},{9,38},{6,42},{8,50},{20,55},{25,55},{35,62},{31,67},{28,71},{17,75},{13,80},{19,98},{26,91},{19,97},{32,105}},
		[3]={ {22,15},{27,16},{32,16},{37,22},{33,33},{28,34},{24,38},{15,38},{12,35},{8,42},{4,44},{23,57},{28,56},{30,56},{32,65},{32,75},{23,74},{24,83},{11,83},{35,20},{22,92},{22,85},{24,95}},
	}

}
------------------------------------------------------
local function qs_getplayerdata(playerid)		
	local Active_qsls=activitymgr:get('qsls')
	if Active_qsls==nil then return end 
	
	return Active_qsls:get_mydata(playerid)
	-- [1] = 1,	--持酒状态

	-- [3] = 111111,	-- 采集npc---cid
end


-- 加经验和亲密度
local function add_allproc(sid,othersid,per,sExp,sDear)
	PI_PayPlayer(1, sExp,0,0,'曲水流觞')
	--PI_PayPlayer(1, _floor(sExp * per),0,0,'曲水流觞',2,othersid)
	local a=AddDearDegree(sid,othersid,sDear)
	AddDearDegree(othersid,sid,sDear)
	return a
end

--刷新荷叶酒
local function _qs_refresh(fbid)

	local Active_qsls=activitymgr:get('qsls')
	if Active_qsls==nil then return end 
	local wqstate=Active_qsls:get_state()
	if wqstate~=1 then return end
	local poslist
	local CreateInfo
	local npcid
	for i =1 ,3 do
		npcid=705000+i*1000
		poslist=qs_conf.duckpos[i]
		CreateInfo=npclist[npcid]
		CreateInfo.NpcCreate.regionId=fbid
	
		CreateObjectIndirectEx(1,npcid,CreateInfo.NpcCreate,#poslist,poslist)
	end
	--return 10*60--间隔10分钟循环刷
end



--刷新上线调用
local function _qsls_on_login(slef,playerid)

	local selfData = qs_getplayerdata(playerid)
	if selfData == nil then return end
	selfData[1]=nil
	selfData[3]=nil
end
--创建房间回调
local function _qsls_regioncreate(slef,mapGID)
	SetEvent(10, nil, 'GI_qs_refresh',mapGID ) --10秒后循环刷荷叶
end
--切换地图
local function _qsls_regionchange(slef,playerid)
	
	local selfData=qs_getplayerdata(playerid)
	if selfData==nil then return end
	selfData[3]=nil
	selfData[1]=nil

end
-- 活动结束处理
local function _on_active_end(self)
	look('_on_active_end')
	-- 排行榜
	local sclist = get_scorelist_data(1,scoreid)
	-- 发送邮件
	if type(sclist) == type({}) then
		
		for k, v in pairs(sclist) do
			if type(k) == type(0) and type(v) == type({}) then
				if k<4 then
					SendSystemMail(v[2],MailConfig.QSMail,k,2) 
				else
					SendSystemMail(v[2],MailConfig.QSMail,4,2) 
				end
			end
		end
	end
end
--活动开启时注册
local function active_qsls_regedit(Active_qsls)

	Active_qsls.on_login=_qsls_on_login
	Active_qsls.on_regioncreate=_qsls_regioncreate
	Active_qsls.on_regionchange=_qsls_regionchange
	Active_qsls.on_active_end=_on_active_end
end

-------------------------------------------------------------------------


--开始
local function _qs_start()

	--local Active_qslsold=activitymgr:get('qsls')
	-- if Active_qslsold then
		-- look('活动开启中')
		-- return
	-- end
	activitymgr:create('qsls')
	local Active_qsls=activitymgr:get('qsls')
	active_qsls_regedit(Active_qsls)
	Active_qsls:createDR(1)
	BroadcastRPC('qs_Start')
	SetEvent(30, nil, "GI_qs_sc_sync",'qsls',scoreid)   		-- 排行数据
end
--进入
local function _qs_enter(sid,mapGID)

	local Active_qsls=activitymgr:get('qsls')
	if Active_qsls==nil then

		return
	end
	if  not Active_qsls:is_active(sid) then
		if not Active_qsls:add_player(sid, 1, 0, nil, nil, mapGID) then 
			return 
		end
	end
	local selfData = qs_getplayerdata(sid)
	if selfData == nil then return end

	--SendLuaMsg( 0, { ids = qs_iteminfo, info = selfData }, 9 )
	CheckTimes(sid,uv_TimesTypeTb.Noon_Time,1)
end
--退出
local function _qs_exit(sid)

	local Active_qsls=activitymgr:get('qsls')
	if Active_qsls==nil then

		return
	end
	Active_qsls:back_player(sid)
end




--敬酒
local function _qs_drunktop(playerid,nplayerid)
	look('敬酒')
	if playerid ==nil or nplayerid ==nil then return end
	local pdata= qs_getplayerdata(playerid)
	local odata= qs_getplayerdata(nplayerid)
	if pdata==nil or odata==nil then  return end
	if pdata[1]==nil then  return end --持酒
	look(222)
	local worldlv=GetWorldLevel()
	if worldlv<40 then
		worldlv=40
	end
	local sExp=_floor(worldlv^2.5*0.4)
	local sDear=1
	local per=0.5
	local res=2  --1成功2失败3都不醉
	local rannum=_random(1,100)
	if rannum<70 then 
		res=1
		CI_AddBuff(148,0,1,false,2,nplayerid)--醉酒
	elseif rannum<90 then 
		res=3
		--CI_AddBuff(148,0,1,false,2,nplayerid)--醉酒
	else
		--sExp=sExp*0.5
		--per=0.5
		CI_AddBuff(148,0,1,false)--醉酒
	end
	local day_score,week_score
	if res==1 then
		day_score,week_score=sc_add(playerid,scoreid,1)

		local school = CI_GetPlayerData(2)
		local name	= CI_GetPlayerData(3)
		local scres=insert_scorelist(1,scoreid,10,day_score,name,school,playerid)		-- 更新每日排行榜
		insert_scorelist(2,scoreid,10,week_score,name,school,playerid)		-- 更新每周排行榜

		if CheckTimes(playerid,uv_TimesTypeTb.qs_exp,1,-1,1) then 
			local a=add_allproc(playerid,nplayerid,per,sExp,sDear)
			if a then 
				RPC('show_head',sExp,sDear)
			else
				RPC('show_head',sExp)
			end
			CheckTimes(playerid,uv_TimesTypeTb.qs_exp,1,-1) --10
		end

		if scres then
			local Active_qs=activitymgr:get('qsls')
			if not Active_qs then return end
			local pubdata=Active_qs:get_pub()
			pubdata.sendmark=true
		end
	else --对方加分
		-- day_score,week_score=sc_add(nplayerid,scoreid,1)

		-- local school = CI_GetPlayerData(2,2,nplayerid)
		-- local name	= CI_GetPlayerData(3,2,nplayerid)
		-- local scres=insert_scorelist(1,scoreid,10,day_score,name,school,nplayerid)		-- 更新每日排行榜
		-- insert_scorelist(2,scoreid,10,week_score,name,school,nplayerid)		-- 更新每周排行榜
		-- if scres then
		-- 	local Active_qs=activitymgr:get('qsls')
		-- 	if not Active_qs then return end
		-- 	local pubdata=Active_qs:get_pub()
		-- 	pubdata.sendmark=true
		-- end	
	end
	
	local _, _, rid,gid= CI_GetCurPos()
	AreaRPC(0,nil,nil,"drink_res",CI_GetPlayerData(16),CI_GetPlayerData(16,2,nplayerid),res,day_score) --敬酒结果
	pdata[1]=nil
	look('敬酒完成')
end
--采集荷叶酒回调
local function _qs_collect(controlId)
	look('采集荷叶酒回调')
	local _, _, rid,gid= CI_GetCurPos()
	local a=CI_SelectObject(6, controlId, gid )
	if (not a ) or a<1 then
		TipCenter(GetStringMsg(436))
		return
	end
	local playerid=CI_GetPlayerData(17) 
	local pdata=qs_getplayerdata(playerid)
	pdata[3]=controlId
	
	RPC('qs_answer')
	return 1
end

--点击采集荷叶酒
call_npc_click[60009] = function ()
	look('点击采集荷叶酒')
	local playerid=CI_GetPlayerData(17) 
	local selfData = qs_getplayerdata(playerid)

	if selfData == nil then return end
	if selfData[3]~=nil or selfData[1]~=nil then
		--TipCenter(GetStringMsg(440))
		return
	end
	
	local ControlID = GetObjectUniqueId()
	_qs_collect(ControlID)
	--CI_SetReadyEvent(ControlID,ProBarType.collect,3,1,'GI_qs_collect')
end


--答题结果
local function _qs_answerback(playerid,num,isuse)

	if playerid ==nil or num ==nil then return end
	local pdata=qs_getplayerdata(playerid)
	if pdata==nil then return end
	if num then --答题正确
		local _, _, rid,gid= CI_GetCurPos()
		local controlId=pdata[3]
		--RemoveObjectIndirect(gid,controlId)

		CI_UpdateNpcData(2,true,6,controlId)	
		AreaRPC(6,controlId,gid,'update_npc_collect',controlId,true)
		SetEvent(10, nil, "qs_relook",controlId,gid) 
		--look('隐藏npc')
		RPC("qs_instate")--发送持酒状态(答题正确和完美灌酒用)
		pdata[3]=nil
		pdata[1]=1
		if isuse then
			CheckTimes(playerid,uv_TimesTypeTb.Qsls_answer,1,-1) --答题使用锤子
		end
	else
		pdata[3]=nil
	end
end



-------------------------------------------------------------------
qs_start=_qs_start--开始
qs_enter=_qs_enter--进入
qs_exit=_qs_exit--退出
qs_answerback=_qs_answerback
qs_drunktop=_qs_drunktop
qs_refresh=_qs_refresh
qs_collect=_qs_collect