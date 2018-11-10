--[[
file:	Hunting_Active.lua
desc:	����
author:	wk
update:	2013-06-20
]]--
local active_mgr_m = require('Script.active.active_mgr')
local activitymgr=active_mgr_m.activitymgr
local look = look
local CreateObjectIndirect=CreateObjectIndirect
local BroadcastRPC=BroadcastRPC
local AreaRPC=AreaRPC
local TipCenter=TipCenter
local isFullNum=isFullNum
local GiveGoods=GiveGoods
local CheckGoods=CheckGoods
local GetMonsterData=GetMonsterData
local CI_UpdateMonsterData=CI_UpdateMonsterData
local CI_MoveMonster=CI_MoveMonster
local sc_reset_getawards=sc_reset_getawards
local sc_getdaydata=sc_getdaydata
local sc_add=sc_add
local uv_TimesTypeTb = TimesTypeTb
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
local CheckTimes=CheckTimes
local scoreid=3-----���ִ洢λ��
local sc_getdaydata=sc_getdaydata
local sc_getweekdata=sc_getweekdata
local sc_reset_getawards=sc_reset_getawards
local RandomInt=RandomInt
local db_module = require('Script.cext.dbrpc')
local db_active_getaward = db_module.db_active_getaward
local GetServerTime=GetServerTime
local CheckCost=CheckCost
local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist = sclist_m.insert_scorelist
local IsSpanServer = IsSpanServer
local GI_GetPlayerData = GI_GetPlayerData
local db_module =require('Script.cext.dbrpc')
local db_point=db_module.db_point
local GetGroupID=GetGroupID
----------------------------------------------------------------------
local temp_monAtt={[13] = 300 }
local mount_tempete = { regionId = 501,name = '������',monsterId = 22 ,camp = 4, school = 4,  monAtt={[13] = 300 }, targetX = 36 , targetY = 20,eventScript=5,moveScript=10005}
local hunt_Item = 674	 --���Ե���

local config = 
{
	yb_cost = 10,
	level_limit = 60,

	times_limit = 100,
}

function zm_add_score(sid,score)
	local pdata = GI_GetPlayerData(sid,'zm',32)
	pdata[2] = (pdata[2] or 0 )+ score
	RPC('ZM_update',pdata[2])
end


----------------------------------------------------------------------------
-- module:

module(...)

----------------------------------------------------------------------------
local born_pos = { 		--���������,������,-----��ǰ̨���θ�������,��ʼ��ͽ�����Ҫ����1��,Լ16��
	{{15,25},{61,25},},
	{{31,25},{2,25},},
	{{31,25},{61,25},},
	{{45,25},{2,25},},
	{{15,26},{61,26},},
	{{31,26},{2,26},},
	{{31,26},{61,26},},
	{{45,26},{2,26},},
	{{15,27},{61,27},},
	{{31,27},{2,27},},
	{{31,27},{61,27},},
	{{45,27},{2,27},},
}

--rate_a�������,get_rate1��Ѹ���,get_rate2���Ƽ�����
local mount_rate = {
	[1] = {imageID = 1191,rate_a = 5000,rate1 = 2000,rate2 = 0,name='Script_1',speed = 150,score=5,exp=0},
	[2] = {imageID = 1192,rate_a = 8000,rate1 = 1000,rate2 = 0,name='Script_2',speed = 120,score=10,exp=0},
	[3] = {imageID = 1193,rate_a = 9700,rate1 = 100,rate2 = 0,name='Script_3',speed = 100,score=50,exp=0},
	[4] = {imageID = 1194,rate_a = 9950,rate1 = 50,rate2 = 0,name='Script_4',speed = 80,score=100,exp=0},
	[5] = {imageID = 1195,rate_a = 10000,rate1 = 20,rate2 = 0,name='Script_5',speed = 50,score=500,exp=0},
}
--���ֽ��� 3��
local zm_scoreaward={
	--[1]={{636,5},},
	--[2]={{636,10},{646,1}},
	--[3]={{636,20},{646,3},},
}
--------------------------------------------------------
local function zm_get_player_data(sid)
	return GI_GetPlayerData(sid,'zm',32)
	--[1] �������� 
	--[2] ���� 
end

function zm_day_reset(sid)
	local pdata = zm_get_player_data(sid)
	pdata[1] = config.times_limit
end
--��ץ�͵��յ���ˢ
local function hunt_refreshagain()

	local rannum=_random(1,10000)
	local imageID1
	local name
	local speed
	for i=1,#mount_rate do
		local v = mount_rate[i]
		if type(v) == type({}) and v.rate_a then
			if rannum<v.rate_a then
				imageID1=v.imageID
				name=v.name
				speed=v.speed
				break
			end
		end
	end
	temp_monAtt[13]=speed
	CI_UpdateMonsterData(1,{camp = 5,imageID=imageID1,headID =imageID1,name=name,monAtt=temp_monAtt,moveScript=10005,},nil,3) --��������
	--CI_MoveMonster(0,0,1,3) --�Ƶ�������
	local oldx,oldy=GetMonsterData(28,3)
	oldx=oldx+_random(-15,15)
	if oldx<2 then
		oldx=3
	elseif oldx>60 then
		oldx=58

	end
	CI_MoveMonster(oldx,oldy,0,3)
	return imageID1,speed
end
--ץ���Ԫ��
-- local function zm_getyb(playerid)
-- 	if CheckTimes(playerid,uv_TimesTypeTb.Hunt_fish_yb,1,-1,1) then
-- 		local rannum=_random(100,500)
-- 		if rannum<140 then
-- 			local getnum=_random(300,500)
-- 			AddPlayerPoints( playerid , 3 , getnum , nil,'ץ��')
-- 			CheckTimes(playerid,uv_TimesTypeTb.Hunt_fish_yb,1,-1)
-- 			return getnum
-- 		end
-- 	end
-- end
--��������ص�
local function _hunting_regioncreate(slef,mapGID)

	for i =1,#born_pos do 
		SetEvent(2, nil, 'GI_hunt_refreshmonster' ,i,mapGID) --10���ѭ��ˢѼ��
	end
end
--�����ʱע��
local function Active_hunting_regedit(Active_hunting)

	Active_hunting.on_regioncreate=_hunting_regioncreate
end

------------------------------------------------------------------
--ѭ������
 function _hunt_refreshmonster(posIndex,gid)
	local Active_hunting=activitymgr:get('hunting')
	if Active_hunting==nil then
		return
	end
	local bPos = born_pos[posIndex]
	if bPos == nil then return end
	local mData = mount_tempete
	mData.x = bPos[1][1]
	mData.y = bPos[1][2]
	mData.targetX = bPos[2][1]
	mData.targetY = bPos[2][2]
	local getIndex
	local rate = RandomInt(1,10000)
	for i=1,#mount_rate do
		local v = mount_rate[i]
		if type(v) == type({}) then
			if rate <= v.rate_a then
				getIndex = v.imageID
				mData.regionId=gid
				mData.imageID = v.imageID
				mData.headID = v.imageID
				mData.name = v.name
				mData.monAtt[13] = v.speed
				break
			end
		end
	end

	if getIndex then
		local gid = CreateObjectIndirect(mData)
	end

end

----------------------------------------------------------------------
--��ʼ
function _hunt_start()
	if IsSpanServer() then return end
	--local Active_huntingold=activitymgr:get('hunting')
	-- if Active_huntingold then
		-- look('�������')
		-- return
	-- end
	activitymgr:create('hunting')
	local Active_hunting=activitymgr:get('hunting')
	Active_hunting_regedit(Active_hunting)
	Active_hunting:createDR(1)
	
	BroadcastRPC('Hunt_Start')
end
--����
function _hunt_enter(sid,mapGID)
	look('_hunt_enter',2)
	local playerlv = CI_GetPlayerData(1)
	if playerlv < config.level_limit then return end

	local Active_hunting=activitymgr:get('hunting')
	if Active_hunting==nil then
		return
	end
	if  not Active_hunting:is_active(sid) then
		Active_hunting:add_player(sid, 1, 0, nil, nil, mapGID)
		
		--Active_hunting:add_player(sid, 1, 0, nil, nil, hunting_gid)
	end
end
--�˳�
function _hunt_exit(sid)
	local Active_hunting=activitymgr:get('hunting')
	if Active_hunting==nil then
		return
	end
	Active_hunting:back_player(sid)

	local serverID = GetGroupID()
	local account=CI_GetPlayerData(15,2,sid)
	local rolename=CI_GetPlayerData(5,2,sid)
	local rolelevel=CI_GetPlayerData(1,2,sid)
	
	local pdata = zm_get_player_data(sid)
	local nowvalue=pdata[2] or 0

	if type(serverID)~=type(0) or type(account)~=type('') or type(rolename)~=type('') or type(rolelevel)~=type(0) then
		Log('�洢ת��ʧ��.txt','-----------start---------')
		Log('�洢ת��ʧ��.txt',info)
	
		Log('�洢ת��ʧ��.txt',account)
		Log('�洢ת��ʧ��.txt',rolename)
		Log('�洢ת��ʧ��.txt',debug.traceback())
		Log('�洢ת��ʧ��.txt','-----------end---------')
	end 
	db_point(serverID,account,rolename,sid,rolelevel,1,"���Ի���" ,20,nowvalue)
end

--�����ƶ���һ����ص�
call_monster_move[10005]=function ()
	hunt_refreshagain()
end

--���ץ��ص�
call_monster_chick[5]=function (itemid)	
	local imageID=GetMonsterData(24,3)
	local monstergid=GetMonsterData(27,3)

	local mConf
	local rateD
	for i=1,#mount_rate do
		local v = mount_rate[i]
		if type(v) == type({}) and v.imageID == imageID then
			mConf = v
			break
		end
	end
	if mConf == nil then
		look(' err:mConf == nil')
		return
	end
	local sid=CI_GetPlayerData(17)
	local pdata = zm_get_player_data(sid)
	pdata[1] = pdata[1] or config.times_limit
	
	if pdata[1] and pdata[1] > 0 then 
		pdata[1] = pdata[1]-1
	else
		if not CheckCost(sid,10000,0,3,"ץ��") then
			return
		end
	end
	rateD = mConf.rate1

	local rateG = RandomInt(1,10000)
	local canGet = false
	if rateG < rateD then
		canGet = true
	end
	
	if canGet then

		-- local ybend=zm_getyb(sid)
		-- if ybend then
		-- 	AreaRPC(0,nil,nil,"AM_GMount",CI_GetPlayerData(16),monstergid,canGet,ybend,itemid)
		-- 	BroadcastRPC('zmfish_getyb',1,ybend,CI_GetPlayerData(3))
		-- else
			
		-- end
		local score=mConf.score
		local _exp=mConf.exp 
		
		--local getexp=active_get_exp(_exp,1)
		--PI_PayPlayer(1, getexp,0,0,'ץ��')
		local s_add 
		if itemid == 1 and CheckCost(sid,config.yb_cost,0,1,'ץ��˫������') then 
			s_add = score * 2
		else
			s_add = score
		end
		pdata[2] = (pdata[2] or 0) + s_add
		
		RPC('ZM_update',pdata[2])
		AreaRPC(0,nil,nil,"AM_GMount",CI_GetPlayerData(16),monstergid,canGet,ybend,itemid,s_add,imageID)
		
		local nextimageid,nextspeed=hunt_refreshagain()
		--AreaRPC(3,nil,nil,"AM_refresh",monstergid,nextimageid,nextspeed)--ͬ������,��Ϊ�����㲥
		local _,_,_,gid = CI_GetCurPos()
		RegionRPC(gid,"AM_refresh",monstergid,nextimageid,nextspeed)

		if imageID == 1194  then
			
			RegionRPC(gid,'AM_GetEx',imageID,CI_GetPlayerData(3))
		end
		if imageID == 1195 then
			BroadcastRPC('AM_GetEx',imageID,CI_GetPlayerData(3))
		end
	else
		AreaRPC(0,nil,nil,"AM_GMount",CI_GetPlayerData(16),monstergid,canGet,nil,itemid,nil,imageID)
	end
end


--��ȡ���ֽ���
function _get_zmaward(sid)
	--[[
	local score = sc_getdaydata(sid,scoreid)

	if score==nil then return end
	local school = CI_GetPlayerData(2)
	local name	= CI_GetPlayerData(3)
	local week_score=sc_getweekdata(sid,scoreid)
	insert_scorelist(2,scoreid,10,week_score,name,school,sid)
	local itype
	local cangetexp
	if score>=5000 then
		itype=3
		cangetexp=7
	elseif score>=2000 then
		itype=2
		cangetexp=5
	elseif score>=1000 then
		itype=1
		cangetexp=3
	else
		sc_reset_getawards(sid,scoreid)
		return
	end
	
	local award=zm_scoreaward[itype]
	local pakagenum = isFullNum()
	if pakagenum < #award then
		TipCenter(GetStringMsg(14,#award))
		return
	end
	for k,v in pairs(award) do
		if type(v)==type({}) then
			GiveGoods(v[1],v[2],1,"ץ����ֽ���")
		
		end
	end
	local getexp=active_get_exp(cangetexp,2)
	PI_PayPlayer(1, getexp,0,0,'ץ��')
	sc_reset_getawards(sid,scoreid)
	RPC('ZM_update',0)
	CheckTimes(sid,uv_TimesTypeTb.Hurt_Time,1)
	
	db_active_getaward(sid,GetServerTime(),score,scoreid)
	]]--
end

--------------------------------------
hunt_start=_hunt_start
hunt_enter=_hunt_enter
hunt_exit=_hunt_exit
get_zmaward=_get_zmaward
hunt_refreshmonster=_hunt_refreshmonster
