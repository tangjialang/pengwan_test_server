--[[
file:	Catch_fish_Active.lua
desc:	深海捕鱼
author:	wk
update:	2013-06-27
]]--

local SendLuaMsg=SendLuaMsg
local active_mgr_m = require('Script.active.active_mgr')
local activitymgr=active_mgr_m.activitymgr
local CreateObjectIndirect=CreateObjectIndirect
local BroadcastRPC=BroadcastRPC
local AreaRPC=AreaRPC
local TipCenter=TipCenter
local isFullNum=isFullNum
local GiveGoods=GiveGoods
local CheckGoods=CheckGoods
local CI_UpdateMonsterData=CI_UpdateMonsterData
local GetMonsterData=GetMonsterData
local CI_MoveMonster=CI_MoveMonster
local uv_TimesTypeTb = TimesTypeTb
local CheckTimes=CheckTimes
local AddPlayerPoints=AddPlayerPoints
local RegionRPC=RegionRPC
local active_get_exp=active_get_exp
local _random=math.random
local SetEvent=SetEvent
local call_monster_move=call_monster_move
local call_monster_chick=call_monster_chick
local CI_GetPlayerData=CI_GetPlayerData
local look=look
local type,pairs=type,pairs
local PI_PayPlayer=PI_PayPlayer
local sc_add=sc_add
local RPC=RPC
local CI_GetCurPos=CI_GetCurPos
local scoreid=4
local sc_getdaydata=sc_getdaydata
local sc_reset_getawards=sc_reset_getawards
local db_module = require('Script.cext.dbrpc')
local db_active_getaward = db_module.db_active_getaward
local GetServerTime=GetServerTime
local CheckCost=CheckCost
local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist = sclist_m.insert_scorelist
local sc_getweekdata=sc_getweekdata
local call_monster_dead=call_monster_dead
local CI_SetPlayerData=CI_SetPlayerData
local CI_PayPlayer=CI_PayPlayer
local GetDBActiveData=GetDBActiveData
local rint=rint
local baoyue_getpower=baoyue_getpower
local GiveGoodsBatch=GiveGoodsBatch
local GetStringMsg=GetStringMsg
local Log=Log
local __G = _G
local PI_SendSpanMsg = PI_SendSpanMsg
----------------------------------------------------------------------
-- local mount_youyu = { monsterId = 5 , aiType = 257 , moveArea = 0 ,}--诱鱼怪
local mount_tempete = { deadScript =4200,name = '三河马',monsterId = 5 , aiType=1026,school = 4,  monAtt={[13] = 300 }, targetX = 36 , targetY = 20,moveScript=10006}


local temp_monAtt={[13] = 300 }
--local hunt_Item = 674	 --狩猎道具
----------------------------------------------------------------------------
-- module:

module(...)

----------------------------------------------------------------------------
local born_pos = { 		--猎物出生点,结束点,-----因前台外形更新需求,起始点和结束点要超过1屏,约16格
	{{15,20},{61,20},},
	{{31,20},{2,20},},
	{{31,20},{61,20},},
	{{45,20},{2,20},},
	
	{{15,25},{61,25},},
	{{31,25},{2,25},},
	{{31,25},{61,25},},
	{{45,25},{2,25},},
	
	{{15,32},{61,32},},
	{{31,32},{2,32},},
	{{31,32},{61,32},},
	{{45,32},{2,32},},
	
	
	{{15,20},{61,32},},
	{{31,20},{2,32},},
	{{31,20},{61,32},},
	{{45,20},{2,32},},
	
	{{15,25},{61,20},},
	{{31,25},{2,20},},
	{{31,25},{61,20},},
	{{45,25},{2,20},},
	
	{{15,25},{61,32},},
	{{31,25},{2,32},},
	{{31,25},{61,32},},
	{{45,25},{2,32},},
	
	{{15,32},{61,20},},
	{{31,32},{2,20},},
	{{31,32},{61,20},},
	{{45,32},{2,20},},
}
--Y坐标各区域刷新鱼概率
--Y坐标0-20,5种鱼出现概率
local fish_erearate={
		[1]={[1]=2500,[2]=5000,[3]=7500,[4]=9500,[5]=10000,},
}
--get_rate1免费概率,get_rate2穿云箭概率
local mount_rate = {
	[1] = {imageID = 2087 ,rate1 = 2000,rate2 = 10000,name='Script_6',speed = 150,score=5,exp=1,nuqi=1,life={3,6}},
	[2] = {imageID = 2088,rate1 = 1500,rate2 = 8000,name='Script_7',speed = 120,score=10,exp=2,nuqi=2,life={5,8}},
	[3] = {imageID = 2089,rate1 = 1000,rate2 = 5000,name='Script_8',speed = 100,score=20,exp=3,nuqi=3,life={7,13}},
	[4] = {imageID = 2090,rate1 = 10,rate2 = 2000,name='Script_9',speed = 80,score=30,exp=5,nuqi=4,life={10,17}},
	[5] = {imageID = 2091,rate1 = 0,rate2 = 1000,name='Script_10',speed = 50,score=50,exp=10,nuqi=5,life={16,25}},
}

--积分奖励-5档
local scoreaward={
	[1]={{1270,1,1},},
	[2]={{1271,1,1},},
	[3]={{1272,1,1},},
	[4]={{1273,1,1},},
	[5]={{1274,1,1},},
	}
--------------------------------------------------------

--数据
local function fish_getdata( sid )
	local adata=GetDBActiveData( sid )
	if adata==nil then return end
	if adata.fishg==nil then 
		adata.fishg={
			[1]=0,--现在金币量
			[2]=0,--历史捕鱼获得金币量
			[3]=nil,--积分
			[4]=nil,--领奖标示
			[5]=nil,--领金币标识,nil未领,1领过
		}
	end
	return adata.fishg
end
------------------------------怒气相关-------------------------------------
--进场景转换
function fish_in( sid )
	-- look('进场景转换')
	local gdata=fish_getdata(sid )
	local nowgold=gdata[1]
	CI_SetPlayerData(6,nowgold,60000)--初始化：CI_SetPlayerData(6,当前怒气，最大怒
	gdata[1]=0
	RPC('ZY_aexp',nowgold)
	--local nuqi=CI_GetPlayerData(24)-- 取当前怒气
end
--出场景,下线转换
function fish_out(sid)
	 look('出场景,下线转换')
	local nuqi=CI_GetPlayerData(24)-- 取当前怒气
	local gdata=fish_getdata( sid )
	gdata[1]=gdata[1]+nuqi
	CI_SetPlayerData(6) --还原
	look(nuqi)
	look(CI_GetPlayerData(24))
end
--抓鱼得金币加怒气_场景里,转化为怒气
function fish_getgold( value )
	local sid=CI_GetPlayerData(17)
	CI_PayPlayer(4,value)
	local gdata=fish_getdata( sid )
	gdata[2]=gdata[2]+value
end
--购买怒气--只能在场景里面购买
function fish_buygold( sid )
	look('购买怒气')
	if not CheckCost( sid , 20 , 1 , 1, "购买怒气") then
		SendLuaMsg(0,{ids=storeend,succ=1},9)
		return
	end
	fish_getgold( 50 )
	CheckCost( sid , 20 , 0 , 1, "100013_购买捕鱼金币")
end
---积分清0
function _fish_reset( sid )
	local gdata=fish_getdata( sid )
	gdata[3]=nil
	gdata[4]=nil
	gdata[5]=nil
	gdata[1]=0
	RPC('fgold_everyday',gdata)--重置完成
end
--每日加金币--可能按熟练度加
function _fish_getgold_everyday( sid )
	local cx, cy, rid, isdy = CI_GetCurPos()
	if rid~=502 then return end
	local gdata=fish_getdata( sid )
	if gdata[5]~= nil then return end
	local bylv=0
	local t=0
	for i = 0, 100 do
		if (t > gdata[2]) then 
			bylv = i
			break
		end
		t =t+ 100 + i * 100;
	end

	local money=bylv*5+195
	local isby = baoyue_getpower(sid, 4)
	if isby then 
		money=money+100 --包月+100
	end
	fish_getgold( money )
	gdata[5]=1
	RPC('fgold_everyday')--领取完成
end
------------------------
--加积分
local function f_addscore( sid,value )	
	local gdata=fish_getdata( sid )
	gdata[3]=(gdata[3] or 0)+value
	return  gdata[3]
end
-------------------------------------------------------------------
--出怪概率
local function ch_getmount_rate(y)
	local rannum=_random(1,10000)
	local index=1
	-- local rate
	-- if y<25 then
	-- 	index=1
	-- elseif y<32 then
	-- 	index=2
	-- else
	-- 	index=3
	-- end
	local rateconf=fish_erearate[index]
	for i=1,#rateconf do
		if rannum<=rateconf[i] then
			rate=i
			break
		end
	end
	return rate
end

--被抓和到终点重刷
local function _catchfish_refreshagain()

	-- local imageID1
	-- local name
	-- local speed
	-- local _,y = CI_GetCurPos(3)--取当前怪坐标
	-- local rate=ch_getmount_rate(y)
	-- local endrate=mount_rate[rate]
	-- if endrate ==nil then return end
	-- local imageID1=endrate.imageID
	-- local name=endrate.name
	-- local speed=endrate.speed		
	-- temp_monAtt[13]=speed
	-- CI_UpdateMonsterData(1,{camp = 5,imageID=imageID1,headID =imageID1,name=name,monAtt=temp_monAtt,moveScript=10006,},nil,3) --设置外形
	-- --CI_MoveMonster(0,0,1,3) --移到出生点
	-- local oldx,oldy=GetMonsterData(28,3)
	-- oldx=oldx+_random(-15,15)
	-- if oldx<2 then
	-- 	oldx=3
	-- elseif oldx>60 then
	-- 	oldx=58

	-- end
	-- CI_MoveMonster(oldx,oldy,0,3)
	-- return imageID1,speed

	CI_UpdateMonsterData(1,{moveScript=10006,},nil,3) --
	CI_MoveMonster(0,0,1,3)
end


----------------------------------------------------------------------

--循环出怪
local function _catchfish_refreshmonster(posIndex,gid,itype)

	local Active_catch_fish=activitymgr:get('catch_fish')
	if Active_catch_fish==nil then

		return
	end
	if itype then 
		posIndex=_random(1,#born_pos)
	end
	local bPos = born_pos[posIndex]
	if bPos == nil then return end
	local mData = mount_tempete
	mData.x = bPos[1][1]
	mData.y = bPos[1][2]
	mData.targetX = bPos[2][1]
	mData.targetY = bPos[2][2]
	local rate=ch_getmount_rate(bPos[1][2])
	local endrate=mount_rate[rate]

	if endrate ==nil then return end
	mData.regionId=gid
	mData.imageID = endrate.imageID
	mData.headID = endrate.imageID
	mData.name = endrate.name
	mData.monAtt[13] = endrate.speed
	mData.monAtt[1] = _random(endrate.life[1],endrate.life[2])
	local gid = CreateObjectIndirect(mData)

end
--切换地图
local function _fish_regionchange(slef,playerid)
	fish_out(playerid)
end
-- 下线处理
local function _on_logout(self,sid)
	fish_out(sid)
end
--创建房间回调
local function _catch_fish_regioncreate(slef,mapGID)

	for i =1,#born_pos do 
		SetEvent(2, nil, 'GI_catchfish_refreshmonster' ,i,mapGID) --10秒后循环刷鸭子
	end
end
--活动开启时注册
local function Active_catch_fish_regedit(Active_catch_fish)
	Active_catch_fish.on_regionchange=_fish_regionchange
	Active_catch_fish.on_regioncreate=_catch_fish_regioncreate
	Active_catch_fish.on_logout=_on_logout
	
end
--开始
function _catchfish_start()
	activitymgr:create('catch_fish')
	local Active_catch_fish=activitymgr:get('catch_fish')
	if Active_catch_fish==nil then
		look('11')
		return
	end
	Active_catch_fish_regedit(Active_catch_fish)
	Active_catch_fish:createDR(1)
	BroadcastRPC('Catchfish_Start')
end
--进入
function _catchfish_enter(sid,mapGID)
	if mapGID==0 then 
		return
	end
	local Active_catch_fish=activitymgr:get('catch_fish')
	if Active_catch_fish==nil then
		return
	end
	if  Active_catch_fish:is_active(sid) then return end
	local res=Active_catch_fish:add_player(sid, 1, 0, nil, nil, mapGID)
	if res then 
		fish_in( sid )
	end
end
--跨服进入
function _span_catchfish_enter(sid)
	local Active_catch_fish=activitymgr:get('catch_fish')
	if Active_catch_fish==nil then
		return
	end
	if  Active_catch_fish:is_active(sid) then 
		return 
	end
	-- 获取进入跨服前保存的房间地图GID信息
	local mapGID = __G.GetPlayerSpanGID(sid)
	if mapGID == nil then
		look('_span_catchfish_enter mapGID == nil')
		return
	end
		
	-- put player to region
	local ret, gid = Active_catch_fish:add_player(sid, 1, 0, nil, nil, mapGID)
	if not ret then
		look('_span_catchfish_enter add_player erro')
		return
	end	
	-- 调用进入相关处理
	fish_in( sid )
	
	return true
end
--退出
function _catchfish_exit(sid)
	local Active_catch_fish=activitymgr:get('catch_fish')
	if Active_catch_fish==nil then
		return
	end
	Active_catch_fish:back_player(sid)
end

--怪物移动到一个点回调
call_monster_move[10006]=function ()
	_catchfish_refreshagain()
end
--点击抓鱼回调
-- call_monster_chick[6]=function (itemid)	

-- 	local imageID=GetMonsterData(24,3)
-- 	local monstergid=GetMonsterData(27,3)

-- 	local mConf
-- 	local rateD
-- 	for i=1,#mount_rate do
-- 		local v = mount_rate[i]
-- 		if type(v) == type({}) and v.imageID == imageID then
-- 			mConf = v
-- 			break
-- 		end
-- 	end
-- 	if mConf == nil then
-- 		look('SI_OnClickMonster1 err:mConf == nil',1)
-- 		return
-- 	end
-- 	local sid=CI_GetPlayerData(17)
-- 	if itemid  then --用穿云箭否
-- 		if itemid> 0 then 
-- 			if hunt_Item~=itemid then return end
-- 			if CheckGoods(itemid, 1,0,0,'抓鱼')==0 then return end
-- 		elseif itemid< 0 then 
-- 			if not CheckCost(sid,5,0,1,"抓鱼") then
-- 				return
-- 			end
-- 		end	
-- 		rateD = mConf.rate2
-- 	else
-- 		rateD = mConf.rate1
-- 	end
-- 	local rateG = _random(1,10000)
-- 	local canGet = false
-- 	if rateG < rateD then
-- 		canGet = true
-- 	end

-- 	if canGet then
-- 		AreaRPC(0,nil,nil,"ZY_GMount",CI_GetPlayerData(16),monstergid,canGet,ybend,itemid)
-- 		local score=mConf.score
-- 		local _exp=mConf.exp 
		
-- 		local getexp=active_get_exp(_exp,1)
-- 		PI_PayPlayer(1, getexp,0,0,'抓马')

-- 		local score_end=sc_add(sid,scoreid,score)
-- 		RPC('ZY_update',score_end)
-- 		local nextimageid,nextspeed=_catchfish_refreshagain()
-- 		AreaRPC(3,nil,nil,"ZY_refresh",monstergid,nextimageid,nextspeed)--当前怪物
-- 		if imageID == 2090  then
-- 			local _,_,_,gid = CI_GetCurPos()
-- 			RegionRPC(gid,'ZY_GetEx',imageID,CI_GetPlayerData(3))
-- 		end
-- 		if imageID == 2091  then
-- 			BroadcastRPC('ZY_GetEx',imageID,CI_GetPlayerData(3))
-- 		end
-- 	else
-- 		AreaRPC(0,nil,nil,"ZY_GMount",CI_GetPlayerData(16),monstergid,canGet,nil,itemid)
-- 	end
-- end



--死亡回调
call_monster_dead[ 4200]=function ( )
	look('死亡回调')
	local imageID=GetMonsterData(24,3)
	local monstergid=GetMonsterData(27,3)

	local mConf
	-- local rateD
	for i=1,#mount_rate do
		local v = mount_rate[i]
		if type(v) == type({}) and v.imageID == imageID then
			mConf = v
			break
		end
	end
	if mConf == nil then
		look('SI_OnClickMonster1 err:mConf == nil',1)
		return
	end
	local sid=CI_GetPlayerData(17)
	fish_getgold( mConf.nuqi )--加怒气
	local gdata=fish_getdata( sid )
	
	local score=mConf.score
	--local score_end=sc_add(sid,scoreid,score)
	local score_end=f_addscore( sid,score )
	RPC('ZY_update',score_end)
	look('更新积分=='..score_end)

	AreaRPC(0,nil,nil,"ZY_GMount",CI_GetPlayerData(16),monstergid,gdata[2],mConf.nuqi)
	
	local _,_,_,gid = CI_GetCurPos()
	-- if imageID == 2090  then
		
	-- 	RegionRPC(gid,'ZY_GetEx',imageID,CI_GetPlayerData(3))
	-- end
	if imageID == 2091  then
		RegionRPC(gid,'ZY_GetEx',imageID,CI_GetPlayerData(3))
	end

	_catchfish_refreshmonster(posIndex,gid,1)
end


-- --领取积分奖励
-- function _get_fishaward(sid)
-- 	local score = sc_getdaydata(sid,scoreid)
-- 	if score==nil then return  end
-- 	local school = CI_GetPlayerData(2)
-- 	local name	= CI_GetPlayerData(3)
-- 	local week_score=sc_getweekdata(sid,scoreid)
-- 	insert_scorelist(2,scoreid,10,week_score,name,school,sid)
-- 	local itype
-- 	local cangetexp
-- 	if score>=5000 then
-- 		itype=3
-- 		cangetexp=7
-- 	elseif score>=2000 then
-- 		itype=2
-- 		cangetexp=5
-- 	elseif score>=1000 then
-- 		itype=1
-- 		cangetexp=3
-- 	else
-- 		sc_reset_getawards(sid,scoreid)
-- 		return
-- 	end
	
-- 	local award=zy_scoreaward[itype]
-- 	local pakagenum = isFullNum()
-- 	if pakagenum < #award then
-- 		TipCenter(GetStringMsg(14,#award))
-- 		return
-- 	end
-- 	for k,v in pairs(award) do
-- 		if type(v)==type({}) then
-- 			GiveGoods(v[1],v[2],1,"抓鱼积分奖励")
-- 		end
-- 	end
-- 	local getexp=active_get_exp(cangetexp,2)
-- 	PI_PayPlayer(1, getexp,0,0,'抓马')
-- 	sc_reset_getawards(sid,scoreid)
-- 	RPC('ZY_update',0)
-- 	CheckTimes(sid,uv_TimesTypeTb.Hurt_Time,1)

-- 	db_active_getaward(sid,GetServerTime(),score,scoreid)
-- end
-- --诱鱼怪
-- local function _catchfish_youyu(x,y)

-- 	local Active_catch_fish=activitymgr:get('catch_fish')
-- 	if Active_catch_fish==nil then
-- 		return
-- 	end
-- 	local _,_,_,gid = CI_GetCurPos()
-- 	local mData = mount_youyu
-- 	mData.x =x
-- 	mData.y =y
-- 	mData.regionId=gid
-- 	CreateObjectIndirect(mData)
-- end
----------------------------完成----------------------------------
----------------------------完成----------------------------------
----------------------------完成----------------------------------
----------------------------完成----------------------------------

--领取积分奖励
local function _get_fishaward(sid,itype)
	local pData = fish_getdata(sid)
	if itype<1 or itype>5 then return end
	if pData == nil or pData[3]==nil then return end
	local  getnum=pData[4] or 0
	if itype-getnum~=1 then 
		return 
	end
	local score=pData[3] 
	if itype==1 then 
		if score<500  then return end
	elseif itype==2 then 
		if score<1000  then return end
	elseif itype==3 then 
		if score<3000  then return end
	elseif itype==4 then 
		if score<5000  then return end
	elseif itype==5 then 
		if score<8000  then return end
	else 
		return
	end
	local award=scoreaward[itype]
	local pakagenum = isFullNum()
	if pakagenum < #award then
		TipCenter(GetStringMsg(14,#award))
		return
	end
	GiveGoodsBatch(award,"捕鱼积分奖励")
	pData[4]=itype
	CheckTimes(sid,uv_TimesTypeTb.Hurt_Time,1)
	RPC('ZY_update',nil,itype)
end

local function _sf_get_rooms(svrid,uid,con,idx)
	if svrid == nil then return end
	local Active_catch_fish = activitymgr:get('catch_fish')
	if Active_catch_fish == nil then
		look('_sf_get_rooms Active_catch_fish == nil')
		PI_SendSpanMsg(svrid, {t = 1, ids = 3001, uid = uid, con = con, idx = idx })
		return
	end	
	local active_flags = Active_catch_fish:get_state()
	if active_flags == 0 then
		look('_sf_get_rooms Active_catch_fish has end')
		PI_SendSpanMsg(svrid, {t = 1, ids = 3001, uid = uid, con = con, idx = idx })
		return
	end
	PI_SendSpanMsg(svrid, {t = 1, ids = 3001, uid = uid, con = con, idx = idx, rooms = Active_catch_fish.room })
end

---------------------------interface------------------------------
catchfish_start=_catchfish_start
catchfish_enter=_catchfish_enter
catchfish_exit=_catchfish_exit
get_fishaward=_get_fishaward
catchfish_refreshmonster=_catchfish_refreshmonster
fish_reset=_fish_reset
fish_getgold_everyday=_fish_getgold_everyday
sf_get_rooms = _sf_get_rooms
span_catchfish_enter = _span_catchfish_enter
-- catchfish_youyu=_catchfish_youyu
