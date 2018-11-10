--[[
file:	wenquan_Active.lua
desc:	瑶池温泉活动
author:	wk
update:	2013-06-18
]]--
--wenquan_gid=wenquan_gid or 0 --后面注销
local active_mgr_m = require('Script.active.active_mgr')
local activitymgr=active_mgr_m.activitymgr
local define		= require('Script.cext.define')
local ProBarType = define.ProBarType
local CreateObjectIndirect=CreateObjectIndirect
local BroadcastRPC=BroadcastRPC
local RegionRPC=RegionRPC
local TipCenter=TipCenter
local CheckGoods=CheckGoods
local CI_AreaAddExp=CI_AreaAddExp
local SI_AreaAddExp=SI_AreaAddExp
local AddDearDegree=AddDearDegree
local PI_PayPlayer=PI_PayPlayer
local SetEvent=SetEvent
local CI_SetReadyEvent=CI_SetReadyEvent
local call_npc_click = call_npc_click
local look = look
local wq_iteminfo = msgh_s2c_def[12][16]
local wq_end = msgh_s2c_def[12][31]
local SendLuaMsg=SendLuaMsg
local _random,_floor=math.random,math.floor
local call_npc_click=call_npc_click
local call_OnMapEvent=call_OnMapEvent
local npclist=npclist
local CreateObjectIndirectEx=CreateObjectIndirectEx
local CI_GetCurPos=CI_GetCurPos
local CI_GetPlayerData=CI_GetPlayerData
local GetObjectUniqueId=GetObjectUniqueId
local GetServerTime=GetServerTime
local PI_MovePlayer=PI_MovePlayer
local sc_add=sc_add
local AreaRPC=AreaRPC
local GetStringMsg=GetStringMsg
local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist = sclist_m.insert_scorelist
local get_scorelist_data = sclist_m.get_scorelist_data
local uv_TimesTypeTb=TimesTypeTb
local CheckTimes=CheckTimes
local SendSystemMail = SendSystemMail
local MailConfig=MailConfig
local type=type
local pairs=pairs
local CI_GetFactionInfo=CI_GetFactionInfo
local RPC=RPC
local CI_SelectObject=CI_SelectObject
local RemoveObjectIndirect=RemoveObjectIndirect
----------------------------------------------------------------------------
-- module:

module(...)

----------------------------------------------------------------------------
local _wq_conf = {
	 duckpos ={ -- 鸭子随机1,2号刷新点{x,y}--刚哥要求配置20个,2个配置个数必须一样
		[1]={{4,7},{6,21},{3,31},{10,38},{16,42},{16,29},{18,11},{11,26},{6,22},{4,10},{8,36},{14,42},{21,48},{31,36},{32,26},{25,33},{26,22},{17,18},{11,35},{16,39}},	
		[2]={{38,30},{31,43},{24,39},{22,27},{21,20},{16,29},{18,11},{11,26},{4,17},{8,31},{21,19},{18,24},{22,29},{26,22},{24,34},{31,44},{21,46},{23,31},{31,27},{31,35}},
	},
	-- duckpos ={ -- 鸭子随机1,2号刷新点{x,y}--刚哥要求配置20个,2个配置个数必须一样
	-- 	[1]={{4,7},{6,21}},	
	-- 	[2]={{38,30},{31,43}},	
	-- },
	Goods = {668,669}, --泡泡id
	pdtime=5,--排队时间
	retime=60,--采集完后刷新时间
}

local scoreid=1
------------------------------------------------------
local function wq_getplayerdata(playerid)		
	local Active_wenquan=activitymgr:get('wenquan')
	if Active_wenquan==nil then return end 
	return Active_wenquan:get_mydata(playerid)
	-- [1] = 1,	-- 泡泡-,接受
	-- [2] = {[1] = 0,[2] = 0,[3] = 0},	-- 搓背--时间,发送,接受
	-- [3] = 111111,	-- 上台时间
	-- [4] = 1,	-- 跳水类型

	--	[5]=1,--已采集鸭子个数
end
--活动数据
local function wq_getactdata(gid)
	local Active_wenquan=activitymgr:get('wenquan')
	if Active_wenquan==nil then return end 
	--time=1,排队时间
	--num=1,采集鸭子个数
	--nexttime=2,下次刷新鸭子时间
	return Active_wenquan:get_regiondata(gid)
end
--取活动结束时间
local function wq_getendtime()
	local Active_wenquan=activitymgr:get('wenquan')
	if Active_wenquan==nil then return end 
	local puddata=Active_wenquan:get_pub()
	if puddata==nil then return end
	return puddata.atm-GetServerTime()
end
--刷npc
local function wq_creatnpc(mapgid)
	local CreateObjectIndirectEx = CreateObjectIndirectEx
	for i=400201 ,400212 do
		local CreateInfo=npclist[i]
		if CreateInfo then
			CreateInfo.NpcCreate.regionId=mapgid
			CreateObjectIndirectEx(1,i,CreateInfo.NpcCreate)
		end
	end
end

-- 加经验和亲密度
local function addallproc(sid,othersid,per,sExp,sDear)
	PI_PayPlayer(1, sExp,0,0,'温泉功能')
	PI_PayPlayer(1, _floor(sExp * per),0,0,'温泉功能',2,othersid)
	AddDearDegree(sid,othersid,sDear)
	AddDearDegree(othersid,sid,sDear)
end

--跳水--前台动画
local function wq_jumpfunc()
	local playerid=CI_GetPlayerData(17) 
	local selfData = wq_getplayerdata(playerid)

	if selfData == nil then return end
	if selfData[4]~=nil then return end 
	local itype
	local rannum=_random(1,100)
	if rannum<31 then
		itype=0
	elseif rannum<71 then
		itype=1
	elseif rannum<91 then
		itype=2
	else
		itype=3
	end
	selfData[4]=itype
	local _,_,_,gid = CI_GetCurPos()
	local selfname = CI_GetPlayerData(5)
	local selfgid = CI_GetPlayerData(16)
	
	-- local score=itype
	-- local day_score,week_score=sc_add(playerid,scoreid,score)
	
	-- local school = CI_GetPlayerData(2)
	-- local name	= CI_GetPlayerData(3)
	-- local res=insert_scorelist(1,scoreid,10,day_score,name,school,playerid)		-- 更新每日排行榜
	-- insert_scorelist(2,scoreid,10,week_score,name,school,playerid)		-- 更新每周排行榜
	
	-- if res then
	-- 	local Active_wenquan=activitymgr:get('wenquan')
	-- 	if not Active_wenquan then return end
	-- 	local pubdata=Active_wenquan:get_pub()
	-- 	pubdata.sendmark=true
	-- end
	RegionRPC(gid,"WQ_Jump",selfgid,selfname,itype,day_score) --跳水,类型,落水点位
end
--采集鸭子倒计时上台
local function _wq_jump(playerid)
	local selfData=wq_getplayerdata(playerid)
	local caijinum=selfData[5] or 0
	if caijinum<1 then --采集两次才上台
		selfData[5]=caijinum+1
	else
		selfData[5]=0

		local endtime=wq_getendtime()
		if endtime>10 then --剩余时间不足10秒，则取消玩家跳水，直接给予一次跳水经验

			local _,_,_,gid = CI_GetCurPos()
			local wqdata=wq_getactdata(gid)
			if wqdata==nil then return end
			local now=GetServerTime()
			wqdata.time=wqdata.time or 0
			if wqdata.time<now then
				wqdata.time=now-4--没有排队,马上传送
			end
			selfData[3]=wqdata.time+_wq_conf.pdtime
			wqdata.time=wqdata.time+_wq_conf.pdtime
			local uptime=selfData[3]-now
			local selfname = CI_GetPlayerData(5)
			local selfgid = CI_GetPlayerData(16)
		
			SetEvent(uptime, nil, 'wq_Gotojump',playerid,gid,selfname,selfgid ) --10秒后上台
		else
			if CheckTimes(playerid,uv_TimesTypeTb.wq_exp,1,-1,1) then -- 温泉每日3次经验
				local lv=CI_GetPlayerData(1)
				local sExp=_floor(lv^2.4*2) ---------------------跳水经验
				PI_PayPlayer(1, sExp,0,0,'跳水')--加自己经验
				CheckTimes(playerid,uv_TimesTypeTb.wq_exp,1,-1) --10
			end
		end
	end
	SendLuaMsg( 0, { ids = wq_iteminfo, info = selfData }, 9 )
end
--刷新上线调用
local function _wenquan_on_login(slef,playerid)

	local selfData = wq_getplayerdata(playerid)
	if selfData == nil then return end
	selfData[4]=nil
	SendLuaMsg( 0, { ids = wq_iteminfo, info = selfData }, 9 )

	local wqdata=wq_getactdata(mapGID)
	if wqdata==nil then return end
	if wqdata.nexttime>GetServerTime() then 
		look('发送刷鸭子时间倒计时')
		RPC("WQ_duck",1,wqdata.nexttime)
	end
end
--创建房间回调
local function _wenquan_regioncreate(slef,mapGID)

	SetEvent(120, nil, 'GI_wq_refreshduck',mapGID ) --120秒后循环刷鸭子
	--SetEvent(20, nil, 'GI_wq_refreshduck',mapGID ) --120秒后循环刷鸭子
	wq_creatnpc(mapGID)
	local wqdata=wq_getactdata(mapGID)
	if wqdata==nil then return end
	local now=GetServerTime()
	wqdata.nexttime=GetServerTime()+120
	--RegionRPC(mapGID,"WQ_duck",1,wqdata.nexttime)
end
--切换地图
local function _wenquan_regionchange(slef,playerid)
	local selfData=wq_getplayerdata(playerid)
	if selfData==nil then return end
	selfData[3]=nil
	selfData[4]=nil
end

-- 活动结束
local function _on_active_end(self)
	look('_on_active_end')
	-- 排行榜
	local sclist = get_scorelist_data(1,scoreid)
	-- 发送邮件
	if type(sclist) == type({}) then
		
		for k, v in pairs(sclist) do
			if type(k) == type(0) and type(v) == type({}) then
				if k<4 then
					SendSystemMail(v[2],MailConfig.WQMail,k,2) 
				else
					SendSystemMail(v[2],MailConfig.WQMail,4,2) 
				end
			end
		end
	end
end
--活动开启时注册
local function active_wenquan_regedit(Active_wenquan)

	Active_wenquan.on_login=_wenquan_on_login
	Active_wenquan.on_regioncreate=_wenquan_regioncreate
	Active_wenquan.on_regionchange=_wenquan_regionchange
	Active_wenquan.on_active_end=_on_active_end
end

-------------------------------------------------------------------------


--开始
local function _wq_start()

	--local Active_wenquanold=activitymgr:get('wenquan')
	-- if Active_wenquanold then
		-- look('活动开启中')
		-- return
	-- end
	activitymgr:create('wenquan')
	local Active_wenquan=activitymgr:get('wenquan')
	active_wenquan_regedit(Active_wenquan)
	Active_wenquan:createDR(1)
	BroadcastRPC('WQ_Start')

	SetEvent(30, nil, "GI_wq_sc_sync",'wenquan',scoreid)   		-- 排行数据
end
--进入
local function _wq_enter(sid,mapGID)

	local Active_wenquan=activitymgr:get('wenquan')
	if Active_wenquan==nil then

		return
	end
	if  not Active_wenquan:is_active(sid) then
		if not Active_wenquan:add_player(sid, 1, 0, nil, nil, mapGID) then 
			return 
		end
	end
	local selfData = wq_getplayerdata(sid)
	if selfData == nil then return end

	SendLuaMsg( 0, { ids = wq_iteminfo, info = selfData }, 9 )

	local wqdata=wq_getactdata(mapGID)
	if wqdata==nil then return end
	if wqdata.nexttime>GetServerTime() then 
		look('发送刷鸭子时间倒计时')
		RPC("WQ_duck",1,wqdata.nexttime)
	end

	CheckTimes(sid,uv_TimesTypeTb.wq_Time,1)
end
--退出
local function _wq_exit(sid)

	local Active_wenquan=activitymgr:get('wenquan')
	if Active_wenquan==nil then

		return
	end
	Active_wenquan:back_player(sid)
end
--玩家跳下来
local function _wq_endjump(playerid)

	local selfData = wq_getplayerdata(playerid)
	if selfData == nil then return end
	local _,_,_,gid = CI_GetCurPos()
	local itype=selfData[4]
	if itype ==nil then return end
	
	PI_MovePlayer(0, 16, 25, gid, 2,playerid)
	if itype>0 then
		if CheckTimes(playerid,uv_TimesTypeTb.wq_exp,1,-1,1) then -- 温泉每日3次经验
			local lv=CI_GetPlayerData(1)
			local sExp=_floor(lv^2*20*itype) ---------------------跳水经验
			PI_PayPlayer(1, sExp,0,0,'跳水')--加自己经验

			RPC('show_head',sExp)
			look(111111)
			look(sExp)
			-- local fid= CI_GetPlayerData(23)
			-- if fid and fid>0 then 
			-- 	CI_AreaAddExp(playerid,8,1,0,sExp*0.2,'跳水')	--范围经验8格,1代表帮会
			-- 	AreaRPC(0,nil,nil,"wq_f_get", CI_GetFactionInfo(fid,1),sExp*0.2) --前台放特效
			-- end
			CheckTimes(playerid,uv_TimesTypeTb.wq_exp,1,-1) --10
		end

	end

	local selfname = CI_GetPlayerData(5)
	local selfgid = CI_GetPlayerData(16)
	local score=itype
	local day_score,week_score=sc_add(playerid,scoreid,score)
	
	local school = CI_GetPlayerData(2)
	local name	= CI_GetPlayerData(3)
	local res=insert_scorelist(1,scoreid,10,day_score,name,school,playerid)		-- 更新每日排行榜
	insert_scorelist(2,scoreid,10,week_score,name,school,playerid)		-- 更新每周排行榜
	
	if res then
		local Active_wenquan=activitymgr:get('wenquan')
		if not Active_wenquan then return end
		local pubdata=Active_wenquan:get_pub()
		pubdata.sendmark=true
	end
	--SendLuaMsg( 10, { ids = wq_end, sc=score }, playerid )
	RegionRPC(gid,"WQ_Jump_end",selfgid,selfname,itype,day_score)
	selfData[3]=nil
	selfData[4]=nil
end


--活动功能使用(泡泡,搓背,按摩)
local function _wq_useitem(sid,othersid,index,ftype)
	local Active_wenquan=activitymgr:get('wenquan')
	if Active_wenquan==nil then return end 
	if not  Active_wenquan:is_active(sid) then
		return
	end
	
	local selfData = wq_getplayerdata(sid)
	if selfData == nil then return end
	local otherData = wq_getplayerdata(othersid)
	if otherData == nil then return end
	if index == nil or index <= 0 or index > 3 then return end
	selfData[index]=selfData[index] or {}
	otherData[index]=otherData[index] or {}
	local s_ItemInfo = selfData[index]
	local o_ItemInfo = otherData[index]
	local nowtime = GetServerTime()
	if index == 2 then
		if nowtime - (s_ItemInfo[1] or 0)< 60 then	-- 冷却时间1分钟	
			return
		end
		if( s_ItemInfo[2] or 0)>= 5 then  -- 今日5次使用次数已用完
			return
		end
	end
	if (o_ItemInfo[3] or 0) >= 10 then -- 对方接收次数达到10次 不能再接受
		TipCenter(GetStringMsg(439))
		return
	end
	if index == 2 then -- 搓背
		s_ItemInfo[1] = nowtime					-- 更新道具冷却时间
		s_ItemInfo[2] =( s_ItemInfo[2] or 0) + 1		-- 道具使用次数加1
	end
	o_ItemInfo[3] = (o_ItemInfo[3] or 0) + 1		-- 对方接受次数加1
	local level = CI_GetPlayerData(1)
	local bExp = (level + 10) * 2.4
	-- 道具使用效果
	if index == 1 then						-- 泡泡
		if ftype == nil then return end
		local goodID = _wq_conf.Goods[ftype]
		if not (CheckGoods(goodID, 1,0,sid,'泡泡')==1)then			-- 扣道具
			return
		end
		if ftype == 1 then	--小泡泡				
			-- 加经验和亲密度
			local sExp = 200 * bExp
			addallproc(sid,othersid,0.2,sExp,5)
		elseif ftype == 2 then --大泡泡
			local sExp = 600 * bExp
			addallproc(sid,othersid,0.2,sExp,10)
			SetEvent(6, nil, 'SI_AreaAddExp',othersid,3,0,0,_floor(sExp * 0.05),'泡泡')	--3格		
		end
	elseif index == 2 then					
		local sExp = 100 * bExp
		addallproc(sid,othersid,0.5,sExp,2)
	end	
	local selfname = CI_GetPlayerData(5)
	local othername = CI_GetPlayerData(5, 2,othersid)
	local selfgid = CI_GetPlayerData(16)
	local othergid = CI_GetPlayerData(16, 2,othersid)	
	
	AreaRPC(0,nil,nil,"WQ_UseItem",selfgid,selfname,othergid,othername,index,ftype)
	SendLuaMsg( 0, { ids = wq_iteminfo, info = selfData }, 9 )
end

--刷新鸭子
local function _wq_refreshduck(fbid)
	look('刷新鸭子')
	local Active_wenquan=activitymgr:get('wenquan')
	if Active_wenquan==nil then return end 
	local wqstate=Active_wenquan:get_state()
	if wqstate~=1 then return end
	local poslist=wq_conf.duckpos[_random(1,#wq_conf.duckpos)]
	local CreateInfo=npclist[703000]
	CreateInfo.NpcCreate.regionId=fbid
	CreateObjectIndirectEx(1,703000,CreateInfo.NpcCreate,#poslist,poslist)
	RegionRPC(fbid,"WQ_duck",2,#_wq_conf.duckpos[1])
--	return 10*60--间隔10分钟循环刷
end
--采集鸭子
call_npc_click[60008] = function ()
	local playerid=CI_GetPlayerData(17) 
	local selfData = wq_getplayerdata(playerid)

	if selfData == nil then return end
	if selfData[3]~=nil then return end
	local ControlID = GetObjectUniqueId()
	CI_SetReadyEvent(ControlID,ProBarType.collect,3,0,'GI_wq_collectduck')
end

--采集鸭子回调
local function _wq_collectduck(controlId)
	--look('采集鸭子回调')
	local _, _, rid,gid= CI_GetCurPos()
	local a=CI_SelectObject(6, controlId, gid )
	if (not a ) or a<1 then
		TipCenter(GetStringMsg(436))
		return 0
	end
	
	local playerid=CI_GetPlayerData(17) 
	_wq_jump(playerid)
	RemoveObjectIndirect(gid,controlId)

	local wqdata=wq_getactdata(gid)
	if wqdata==nil then return 0 end
	-- look(wqdata)
	wqdata.num=(wqdata.num or 0) +1
	local ducknum=wqdata.num
	-- look(ducknum)
	-- look(#_wq_conf.duckpos[1])
	if ducknum>=#_wq_conf.duckpos[1] then 
		-- look('1采集完1111')
		local endtime=wq_getendtime()
		-- look(endtime)
		if endtime>90 then --活动剩余时间低于90秒，不再刷新

			wqdata.nexttime=GetServerTime()+_wq_conf.retime
			RegionRPC(gid,"WQ_duck",1,wqdata.nexttime)

			wqdata.num=0
			-- look('采集完')
			-- look(_wq_conf.retime)
			SetEvent(_wq_conf.retime, nil, "GI_wq_refreshduck",gid)  --60秒后刷鸭子
		end
	else
		-- look('公告下一个'..#_wq_conf.duckpos[1] -wqdata.num)
		RegionRPC(gid,"WQ_duck",2,#_wq_conf.duckpos[1] -wqdata.num)
	end

	return 1
end

--中陷阱回调
call_OnMapEvent[100101]=function() 

	wq_jumpfunc()
end

-------------------------------------------------------------------
wq_start=_wq_start--开始
wq_enter=_wq_enter--进入
wq_exit=_wq_exit--退出
wq_endjump=_wq_endjump
wq_useitem=_wq_useitem
wq_conf=_wq_conf
wq_collectduck=_wq_collectduck
wq_refreshduck=_wq_refreshduck
