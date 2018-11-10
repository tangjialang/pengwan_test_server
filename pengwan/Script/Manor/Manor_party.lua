--[[
	file:	山庄宴会系统
	author:	wk
	update:	2013-2-7
	refix:	done by wk
--]]

--[[
	RPC('show_head',exp,qinmi)
	exp 经验
	qinmi亲密度
	
]]--
local active_mgr_m = require('Script.active.active_mgr')
local active_manor = active_mgr_m.active_manor
local SendLuaMsg,TipCenter,GetStringMsg 	 = SendLuaMsg,TipCenter,GetStringMsg
local CI_SetReadyEvent,CI_GetPlayerData,CI_AddBuff = CI_SetReadyEvent,CI_GetPlayerData,CI_AddBuff
local CI_SetDRDelMode,TipABrodCast = CI_SetDRDelMode,TipABrodCast
local msgh_s2c_def	 = msgh_s2c_def
local STARTParty	 = msgh_s2c_def[28][1]	
local BeginParty	 = msgh_s2c_def[28][2]	
local InviteParty	 = msgh_s2c_def[28][3]	
local ToastParty1	 = msgh_s2c_def[28][4]	
--local nextmonster	 = msgh_s2c_def[28][5]	
local ZYparty_info	 = msgh_s2c_def[28][6]	
local ZYpeople		 = msgh_s2c_def[28][7]	
local ZYwho			 = msgh_s2c_def[28][8]	
local ZYExpel		 = msgh_s2c_def[28][9]	
local Join_Party	 = msgh_s2c_def[28][10]	
local ZY_exit		 = msgh_s2c_def[28][11]	
local define		= require('Script.cext.define')
local ProBarType = define.ProBarType
local GI_GetPlayerData=GI_GetPlayerData
local GetServerTime=GetServerTime
local uv_TimesTypeTb = TimesTypeTb
local look = look
local pairs,tostring,type,rint =pairs,tostring,type,rint
local MailParty=MailConfig.Party
local common_rnd = require('Script.common.random_norepeat')
local Get_num 			 = common_rnd.Get_num
local uv_Trapinfo={0,0,0,0}
--[[注意：1增加地图及摇钱树需要添加修改,mapidconf,moneytree_conf]]--
--宴会需要食材
local needfood={
	[1] = {{1046,2},{1048,2},{1050,2},exp=1.8,caneat=3,canjoin=6,} ,
	[2] = {{1046,3},{1048,3},{1050,3},{1047,3},exp=3,caneat=3,canjoin=6,} ,
	[3] = {{1046,3},{1048,3},{1050,3},{1049,3},exp=3,caneat=3,canjoin=6,} ,
	[4] = {{1046,3},{1048,3},{1050,3},{1051,3},exp=3,caneat=3,canjoin=6,} ,
	[5] = {{1047,5},{1049,5},{1051,5},{645,1},exp=6,caneat=3,canjoin=6,} ,
}

local p_monster = {  
	zuozi={ --桌子配置
		[1]={monsterId = 510 ,eventScript=1 ,camp = 4,controlId = 20},--一般
		[2]={monsterId = 511 ,eventScript=1 ,camp = 4,controlId = 20},--豪华
		[3]={monsterId = 516 ,eventScript=2 ,camp = 4,controlId = 20},--宝箱
		},
	--daji={name='123',imageID = 1033,controlId=4,camp = 4,monsterId = 5,moveArea = 0,dir=5},
	
	}

local cdnum=5--敬酒冷却时间
local allnum1=30 --参加总人数
local buff_time=5*60 --buff持续时间
--local drink_downbuff=147 --醉酒buff
local drink_downbuff=147 --醉酒buff
local d_time=60--宴会等待时间
local a_time=6*60--宴会持续总时间
--进入最大人数 有neixin代表宴会状态
function party_maxnum_in( neixin )
	if not neixin then 
		return allnum1
	else
		return needfood[neixin].canjoin
	end
end
--可以吃宴席最大次数
function party_maxeat( neixin )
	if needfood[neixin]==nil then 
		return needfood[3].caneat
 	end
	return needfood[neixin].caneat
end
--[[活动管理中玩家数据存fbgid,fbgid下面存{sid,time,partytype,maxnum,drinktime}存放庄园gid，敬酒次数，宴会结束时删除]]
--定义庄园宴会世界数据
local function GETZYparty_Data(sid)
	if active_manor:get_mydata(sid)==nil then return end
	local gid=active_manor:get_mydata(sid)[1]
	-- gid={
		-- 	sid,--主人id
		-- 	starttime, 开始时间
		-- 	partytype 宴会类型
		--  cid={[20]=,[21]=} --每个吃5个换位置
		--  eatall=45 吃宴席总次数,总50次
		--	fbid
			----- maxnum,
			----- drinktime
	-- }
	return active_manor:get_regiondata(gid)
end

local function GETZYparty_playerData(sid)
	--fbgid=1111,
	return active_manor:get_mydata(sid)
end
--定义庄园宴会个人数据
local function GetDBZYpartyData( playerid )
	local zyparty=GI_GetPlayerData( playerid , 'zypa' , 150 )
	if zyparty == nil then return end
	-- if zyparty.lock==nil then
			-- -- zyparty.lock=nil--锁定进入按钮
			-- -- zyparty.last=nil--敬酒cd时间
			-- -- zyparty.free=nil--敬酒次数
			-- -- zyparty.pt=nil--吃宴席次数
			-- -- zyparty.pexp=nil--吃宴席得经验
			-- -- zyparty.kexp=nil--开宴席得到经验
			-- -- zyparty.eexp=nil--主人才有,为宴席结束得到经验
			-- -- zyparty.dexp=nil--灌醉得经验
			-- --zyparty.box=cc--开宝箱1次,开后数据为主人id
			-- -- zyparty.cc=nil--绑定场次
		-- end
	return zyparty
end
--庄园临时数据
local function GetDBZYtempdata(playerid)
	if playerid == nil then return nil end
	local cData = GetPlayerTemp_custom(playerid)
	if cData == nil  then return end
	if cData.zy_data == nil then
		cData.zy_data = {
			-- in_=nil--是否在宴会场景中
			-- enter=nil --上次进入时间
		}
	end
	return cData.zy_data

end
--退出庄园
--itype=1为退出后直接进入另一个庄园，0为普通退出
function OutZYparty(playerid,nplayerid,itype,otherplayerid)
	if playerid==nil then return end
	local tempdata=GetDBZYtempdata(playerid) 
	local nplayerid=tempdata.in_
	if nplayerid==nil then return end
	local worlddata=GETZYparty_Data(nplayerid)
	if worlddata==nil then 
		look('worlddata--error')
		return
	end
	
	if itype==0 then 
		SendLuaMsg(playerid,{ids=ZY_exit},10)
		active_manor:back_player(playerid)
		tempdata.in_=nil--状态置0
	elseif itype==1 then 

		EnterZY(playerid,otherplayerid,0)--进入庄园
	else
		return
	end
	
end


----------------------------------------------------------------------------------
--进入庄园【itype=0为邀请进入，1为好友列表进入】
function EnterZY(playerid,nplayerid,itype)
	-- look('进入庄园【itype')
	local cx, cy, rid,isdy = CI_GetCurPos()
	
	if isdy then
		if rid>2100 or rid<2001 then --除庄园地图外动态图不能直接传入庄园
			TipCenter( GetStringMsg(431))
			return
		end
	end
	if escort_not_trans(playerid) then --护送状态不能传动态图
		return
	end
	local pTemp = GetDBTaskTemp(playerid)
	if type(nplayerid)==type(" ") then
		nplayerid= GetPlayer(nplayerid, 0)
		if type(nplayerid)~=type(0) or nplayerid<0 then
			TipCenter(GetStringMsg(664))--不在线
			return
		end
	end
	if pTemp  then
		pTemp.ZYdata = pTemp.ZYdata or {}
		pTemp.ZYdata[1] = nplayerid
		pTemp.ZYdata[2] = itype
	end
	-- if RegionTable[rid]==nil then  --地图配置,后期删除
	-- 	EnterZY_final()
	-- 	return 
	-- end
	local ispk=RegionTable[rid].PKType
	
	if ispk==1 then
		EnterZY_final()
	else
		-- look('pk地图')
		local nowlv=CI_GetPlayerData(1)--现在人物等级
		if nowlv>40 then
			CI_SetReadyEvent(0,ProBarType.trans,3,1,'EnterZY_final')
		else
			EnterZY_final()
		end
		
	end
end


function EnterZY_final()
	local playerid=CI_GetPlayerData(17) 
	local pTemp = GetDBTaskTemp(playerid)
	if pTemp ==nil  then return 0 end
	local nplayerid=pTemp.ZYdata[1]
	local itype=pTemp.ZYdata[2]
	if nplayerid==nil or playerid==nil or itype==nil then
		look('EnterZYerror',1)
		return 0
	end
	--CI_SelectObject(2,playerid)
	if playerid~=nplayerid then 
		local nowlv=CI_GetPlayerData(1)--现在人物等级
		if nowlv<38 then

			SendLuaMsg(0,{ids=STARTParty,result=11},9)
			return 0
		end
	end
	local partydata=0
	local partydata1=GetDBZYpartyData( playerid )

	if partydata1==nil then return 0 end
	local tempdata=GetDBZYtempdata(playerid)
	if  GetServerTime()-(tempdata.enter or 0)<3 then
		TipCenter(GetStringMsg(696))
		return 0
	end
	tempdata.enter=GetServerTime()

	if playerid==nplayerid then
		if tempdata.in_ then 
			if tempdata.in_==playerid then
				TipCenter(GetStringMsg(693))
				return 0
			end
		end
	end
	local mapinfo=GetZY_mapinfo(nplayerid)--地图信息
	if mapinfo==nil or type(mapinfo)~=type({}) then
		look('EnterZY_maperror',1)
		return 0
	end
	local mapid=mapinfo[1]
	local x
	local y
	local treezuobiao=mapinfo[4]
	if playerid~=nplayerid then
		x=mapinfo[3][1]
		y=mapinfo[3][2]
	else
		x=mapinfo[2][1]
		y=mapinfo[2][2]
	end
	if  nplayerid==playerid then
		partydata=partydata1
	else
		partydata=GetDBZYpartyData( nplayerid )
		if partydata==nil then
			TipCenter(GetStringMsg(664))--不在线
			SendLuaMsg(0,{ids=STARTParty,result=5},9)
			return 0
		end
		if itype==1 then
			local lock=partydata.lock or 0
			if lock==1 then
				TipCenter(GetStringMsg(665))--对方锁定，不允许进入
				SendLuaMsg(0,{ids=STARTParty,result=9},9)
				return 0
			end
		end
		
	end

	local worlddata=GETZYparty_Data(nplayerid)

	if itype==0 then
		if  worlddata==nil then 
			TipCenter(GetStringMsg(452)) 
			return
		end
			
		if not worlddata.starttime then --宴会结束
			TipCenter(GetStringMsg(452)) 
			return
		end
	end

	if worlddata==nil then
		tempid=active_manor:createDR(1,mapid)
		local moneytree=GetZY_moneytreeinfo(playerid)--摇钱树npc
		if moneytree then 
			local CreateInfo=npclist[400001]
			CreateInfo.NpcCreate.regionId=tempid
			CreateInfo.NpcCreate.x=treezuobiao[1]
			CreateInfo.NpcCreate.y=treezuobiao[2]
			CreateInfo.NpcCreate.imageId=moneytree[1]
			CreateInfo.NpcCreate.headID=moneytree[2]
			CreateObjectIndirectEx(1,400001,CreateInfo.NpcCreate)
		end
		local dajizuobiao=mapinfo[7]--妲己
		local posList = mapinfo[6]--家将
		party_creatdaji( dajizuobiao, tempid)--妲己
		CreateManorHeros(nplayerid,tempid,posList)
		if not active_manor:add_player(playerid, 1, 0,x,y, tempid) then  return end
		local pdata=GETZYparty_playerData(nplayerid)		
		pdata[1]=tempid
		worlddata=GETZYparty_Data(nplayerid)
		worlddata.fbid=tempid
		worlddata.sid=nplayerid
		
	end
	
	local tempid=worlddata.fbid


	if tempid~=nil then
		local all_num=GetRegionPlayerCount(tempid)
		if type(all_num)==type(0) then
			local maxnu=party_maxnum_in( worlddata.partytype )
			if all_num>=maxnu then
				SendLuaMsg(0,{ids=STARTParty,result=4},9)
				return 0
			end
		end
		if not active_manor:add_player(playerid, 1, 0,x,y, tempid) then
			return 0
		end
	end
	if itype==0 then--从自己庄园跳别人庄园,能跳时才发退出
		SendLuaMsg(playerid,{ids=ZY_exit},10)
	end
	local people=CI_GetPlayerData(5,2,nplayerid)
	local Garniture=Garniture_interZY(nplayerid)--装饰资源
	local Gardeninfo=GD_GetFieldState(nplayerid)--果园资源
	if  worlddata.starttime then 
		look('发送宴会信息1111')
		SendLuaMsg(playerid,{ids=BeginParty,starttime=worlddata.starttime,num=worlddata.partytype},10)
	end
	SendLuaMsg(playerid,{ids=ZYwho,people=people,Garniture=Garniture,Gardeninfo=Gardeninfo,starttime=worlddata.starttime},10)
	
	tempdata.in_=nplayerid
	if playerid==nplayerid then
		GD_InitMoneyTree(playerid)				-- 初始化摇钱树
	else
		SyncManorData(playerid,nplayerid,1)--取庄园基本信息
	end
	
	uv_Trapinfo[1]=mapid
	uv_Trapinfo[2]=mapinfo[10][1]
	uv_Trapinfo[3]=mapinfo[10][2]
	uv_Trapinfo[4]=tempid
	PI_MapTrap(2,uv_Trapinfo,10006)


	return 1
end

--锁定进入庄园
function Lock_EnterZY(playerid,itype)
	local partydata=GetDBZYpartyData( playerid )
	if partydata==nil then return end
	if itype==1 then 
		partydata.lock=1
	else 
		partydata.lock=nil
	end
end

--移除动态场景回调

function active_manor:on_regiondelete(RegionID, fbid)
	-- look('zy移除动态场景回调')
	local giddata=active_manor:get_regiondata(fbid)
	if giddata==nil then return end
	local sid=giddata.sid
	active_manor:clear_mydata(sid)
end

--驱逐
function Expel_ZY(playerid,_nplayerid)
	local nplayerid= GetPlayer(_nplayerid, 0)
	if type(nplayerid)~=type(0) or nplayerid<0 then
		return
	end
	if playerid==nplayerid then
		return
	end
	local tempdata=GetDBZYtempdata(playerid)
	if tempdata and tempdata.in_ then 
		if tempdata.in_~=playerid then

			return
		end
	end
	SendLuaMsg(0,{ids=ZYExpel,itype=1,name=CI_GetPlayerData(5,2,nplayerid)},9)
	OutZYparty(nplayerid,playerid,0)--被驱逐者退出
	SendLuaMsg(nplayerid,{ids=ZYExpel,itype=2,name=CI_GetPlayerData(5),},10)
end
--切场景调用
function active_manor:on_regionchange(playerid)
	if playerid==nil then return end
	local tempdata=GetDBZYtempdata(playerid)
	local nplayerid=tempdata.in_
	if nplayerid==nil then return end
	tempdata.in_=nil
	CI_DelBuff(84)
	CI_DelBuff(85)
	CI_DelBuff(96)
	SendLuaMsg(playerid,{ids=ZY_exit},10)
end
--刷新上线调用
function active_manor:on_login(playerid)
	look('11111刷新上线调用')
	if playerid==nil then return end
	local partydata=GetDBZYpartyData( playerid )
	local tempdata=GetDBZYtempdata(playerid)
	local nplayerid=tempdata.in_
	if nplayerid==nil then return end
	local people=CI_GetPlayerData(5,2,nplayerid)
	local Garniture=Garniture_interZY(nplayerid)--装饰资源
	if playerid~=nplayerid then
		SyncManorData(playerid,nplayerid,1)--取庄园基本信息
	end
	local Gardeninfo=GD_GetFieldState(nplayerid)--果园资源
	local worlddata=GETZYparty_Data(nplayerid)
	if  worlddata.starttime then 
		SendLuaMsg(playerid,{ids=BeginParty,starttime=worlddata.starttime,num=worlddata.partytype},10)
	end
	SendLuaMsg(0,{ids=ZYwho,people=people,Garniture=Garniture,Gardeninfo=Gardeninfo,starttime=worlddata.starttime},9)
	
end
--请求现在庄园里面人物列表
function RequestZYpeople(playerid)
	local partydata=GetDBZYpartyData( playerid )
	if partydata==nil then return end
	local tempdata=GetDBZYtempdata(playerid)
	local nplayerid=tempdata.in_
	local worlddata=GETZYparty_Data(nplayerid)
	if worlddata==nil then return end
	CI_SendDRPlayerList(worlddata.fbid)
	--SendLuaMsg(0,{ids=ZYpeople,people=temp},9)
end

----------------------------------宴会相关--------------------------------------------------------
----------------------------------宴会相关--------------------------------------------------------
----------------------------------宴会相关--------------------------------------------------------
----------------------------------宴会相关--------------------------------------------------------
----------------------------------宴会相关--------------------------------------------------------

--是否有资格操作
local function can_useparty( playerid )
	local tempdata=GetDBZYtempdata(playerid)
	if tempdata ==nil  or  tempdata.in_==nil  then  return end
	local nplayerid=tempdata.in_
	local worlddata=GETZYparty_Data(nplayerid)
	local neixin=worlddata.partytype
	if neixin then
		local buffid
		if neixin==1 then
			buffid=84
		elseif neixin>1 and neixin<5 then 
			buffid=85
		else
			buffid=96
		end
		if CI_HasBuff(buffid) then 
			return true
		end
	end
	SendLuaMsg(0,{ids=STARTParty,result=14},9)
end
--邀请单个好友
local function InviteZYparty(playerid,nplayerid)
	if nplayerid==nil or playerid==nil then return end
	local partydata=GetDBZYpartyData( playerid )
	local othername= CI_GetPlayerData(5)

	local worlddata=GETZYparty_Data(playerid)

	SendLuaMsg( nplayerid, { ids=InviteParty,playerid=othername,num=worlddata.partytype }, 10 )-- 发送给其他玩家邀请

end
--邀请所有好友/密友
function InviteallZYparty(playerid,msg)
	if playerid==nil or type(msg)~=type({}) or #msg>30 then return end
	for k ,v in pairs (msg) do
		if type(v)==type(0) then
			--look(v)
			InviteZYparty(playerid,v)
		end
	end
end
	
--进入好友宴会
function EnterZYparty(playerid,_nplayerid)
	local nplayerid= GetPlayer(_nplayerid, 0)
	if type(nplayerid)~=type(0) or nplayerid<0 then
		return
	end
	local partydata=GetDBZYpartyData( playerid )
	local worlddata=GETZYparty_Data(nplayerid)
	local tempdata=GetDBZYtempdata(playerid)
	--if tempdata  and tempdata.in_ then 
	 if not partydata.cc or  partydata.cc~=nplayerid then 
		if not CheckTimes(playerid,uv_TimesTypeTb.ZY_Partyenter,1,-1,1) then
			SendLuaMsg(0,{ids=STARTParty,result=3},9)
			return
		end
	end
	--end
	if tempdata.in_==nil then
		EnterZY(playerid,nplayerid,0)--进入庄园
	else
		if tempdata.in_==nplayerid then
			SendLuaMsg(0,{ids=STARTParty,result=8},9)
		else
			OutZYparty(playerid,tempdata.in_,1,nplayerid)
		end
	end
	
end

--检查食材够不
local function Checkfood(playerid,num)
	if num and  playerid then
		local need=needfood[num]
		for k,v in pairs(need) do
			if type(k)==type(0) and type(v)==type({}) then
				if CheckGoods( v[1] ,v[2], 1, playerid,'检查食材') == 0 then
					SendLuaMsg(0,{ids=STARTParty,result=2},9)
					return false
				end
			end
		end
		for k,v in pairs(need) do
			if type(k)==type(0) and type(v)==type({}) then
				 CheckGoods( v[1] ,v[2],0, playerid,'扣除食材') 
			end
		end
		return true
	end
end


--点击发送宴会信息（时间，人数，宴会类型）
function Send_patryinfo(playerid)
	if playerid==nil then return end
	local tempdata=GetDBZYtempdata(playerid)
	if tempdata and tempdata.in_ then 
		local nplayerid=tempdata.in_
		local worlddata=GETZYparty_Data(nplayerid)
		local tempid=worlddata.fbid
		local all_num=GetRegionPlayerCount(tempid)
		SendLuaMsg(0,{ids=ZYparty_info,lasttime=worlddata.starttime,num=worlddata.partytype,people=all_num},9)

	else
		--SendLuaMsg(0,{ids=STARTParty,result=7},9)
		return
	end
end


--宴会敬酒得到经验
local function getexp_ZYparty(playerid,nplayerid,itype)--[得经验本人id，宴会主人id]
	look('宴会敬酒得到经验')
	local lv=CI_GetPlayerData(1,2,playerid)
	local worlddata=GETZYparty_Data(nplayerid)
	if worlddata==nil then 
		return
	end
	local partylv=worlddata.partytype
	if partylv==nil or partylv==0 then 
		return 
	end
	local cangetexp
	if itype then --宴会, 吃宴席用
		 cangetexp=(lv)^2.5*needfood[partylv].exp
	end
	return rint(cangetexp)
end

--交互：敬酒(敬酒人，被敬酒人)
function ToastZYparty(playerid1,playerid2)
	look('交互：敬酒(敬酒人，被敬酒人)')
	if not  can_useparty( playerid1 ) then return end
	if type(playerid2)~=type(0) or playerid2<0 then
		return
	end
	local partydata=GetDBZYpartyData( playerid1 )
	if partydata==nil   then   
		return 
	end
	local partydata2=GetDBZYpartyData( playerid2 )
	if partydata2==nil   then 
		return 
	end
	local now=GetServerTime()
	if now-(partydata.last or 0)<cdnum then--5秒cd
		SendLuaMsg(0,{ids=STARTParty,result=6},9)
		return
	end
	local tempdata=GetDBZYtempdata(playerid1)
	local nplayerid=tempdata.in_
	if nplayerid==nil then return end

	local drink=10
	-- if playerid1==nplayerid then 
	-- 	drink=15
	-- end
	if (partydata.free or 0)>=drink then--10次敬酒
		SendLuaMsg(0,{ids=STARTParty,result=7},9)
		return
	end
	if CI_HasBuff(drink_downbuff) then--醉酒状态
		TipCenter(GetStringMsg(22)) 
		return 
	end
	partydata.last=now
	


	local rannum=math.random(1,100)
	local res=3 --1成功2失败3都不醉
	if rannum<=70 then --60%对方醉
		local lv=CI_GetPlayerData(1)
		local cangetexp=rint(lv^2.5*0.8)
		CI_AddBuff(drink_downbuff,0,1,false,2,playerid2)
		--CI_CancelReadyEvent(2,playerid2)
		PI_PayPlayer(1,cangetexp,0,0,'宴会敬酒')--加自己经验
		partydata.dexp =(partydata.dexp or 0)+cangetexp
		partydata.free=(partydata.free or 0)+1
		local a=AddDearDegree(playerid1,playerid2,1)--加亲密度
		AddDearDegree(playerid2,playerid1,1)--加亲密度
		
		res=1
		if a then 
			RPC('show_head',cangetexp,1)
		else
			RPC('show_head',cangetexp)
		end
	elseif rannum<=80 then --10%自己醉
		CI_AddBuff(drink_downbuff,0,1,false)
		res=2
	end
	AreaRPC(0,nil,nil,"party_drink",CI_GetPlayerData(16),CI_GetPlayerData(16,2,playerid2),now,partydata.free,res)
	
end

-- 点击吃宴席
call_monster_chick[1]=function ()	
	look('点击吃宴席')
	local playerid= CI_GetPlayerData(17)
	if playerid==nil then  return end

	if CI_HasBuff(drink_downbuff) then--醉酒状态
		TipCenter(GetStringMsg(25)) 
		return 
	end

	local partydata=GetDBZYpartyData( playerid )
	if partydata==nil then 
		return
	end
	local tempdata=GetDBZYtempdata(playerid)
	if tempdata ==nil  or  tempdata.in_==nil  then   return end
	local nplayerid=tempdata.in_
	if nplayerid==playerid then 
		TipCenter(GetStringMsg(68)) 
		return 
	end
	

	local worlddata=GETZYparty_Data(nplayerid)
	local neixin=worlddata.partytype
	local stime=worlddata.starttime
	if GetServerTime()-stime<d_time or GetServerTime()-stime>a_time then 
		SendLuaMsg(0,{ids=STARTParty,result=18,time=d_time-GetServerTime()+stime},9)
		return 
	end


	if not  can_useparty( playerid ) then return end
	if (partydata.pt or 0)>=5 then 
		SendLuaMsg(0,{ids=STARTParty,result=17},9)
		return
	end
	
	local _,cid = GetObjectUniqueId()

	CI_SetReadyEvent(cid,ProBarType.party,3,0,'party_chick_back')
end
--吃宴席回调 --判断桌子刷新
function party_chick_back( cid )
	look('吃宴席回调')
	local playerid= CI_GetPlayerData(17)
	if playerid==nil then return 0 end
	local tempdata=GetDBZYtempdata(playerid)
	local nplayerid=tempdata.in_
	local worlddata=GETZYparty_Data(nplayerid)

	local _, _, rid,gid= CI_GetCurPos()
	local a=CI_SelectObject(6, cid, gid )
	if (not a ) or a<1 then
		TipCenter(GetStringMsg(436))
		return 0
	end

	if not worlddata.cid then 
		worlddata.cid={}
	end
	worlddata.cid[cid]=(worlddata.cid[cid] or 0) +1
	worlddata.eatall=(worlddata.eatall or 0) +1
	if worlddata.cid[cid]>=party_maxeat( worlddata.partytype ) then 
		local poslist=worlddata.poslist
		local endpos=poslist[math.random(1,#poslist)]
		--CI_MoveMonster(endpos[1],endpos[2],0,6,cid)
		worlddata.cid[cid]=0
		RemoveObjectIndirect(worlddata.fbid, 20)
		if worlddata.eatall<party_maxeat( worlddata.partytype )*6 then
			look('30秒后重刷')
			SetEvent(30,nil,'StartZYparty_npc',nplayerid)--30秒后重刷
			RegionRPC(worlddata.fbid,'party_next',1)
		else
			party_cbaoxiang( nplayerid )
			RegionRPC(worlddata.fbid,'party_next',2)
		end
	end

	local partydata=GetDBZYpartyData( playerid )
	if partydata==nil then 
		return 0
	end
	local cangetexp= rint(getexp_ZYparty(playerid,nplayerid,1) /6)
	
	PI_PayPlayer(1,cangetexp,0,0,'吃宴会')--加自己经验
	partydata.pexp =(partydata.pexp or 0)+cangetexp
	partydata.pt=(partydata.pt or 0)+1
	RPC('show_head1',cangetexp,partydata.pt)
	return 1
end

--宴会开始，创建npc--创建桌子,怪物处理
function StartZYparty_npc(playerid,itype)
	look('创建npc--创建桌子,怪物处理')
	local worlddata=GETZYparty_Data(playerid)
	if worlddata==nil then return end
	local fbid=worlddata.fbid
	local num=worlddata.partytype
	if num==nil then return end
	local poslist=worlddata.poslist
	local aPos=poslist[1]
	if itype==nil then
		aPos=poslist[math.random(2,#poslist)]
	end
	local mData
	if num==5 then
		mData=p_monster.zuozi[2]
	else
		mData=p_monster.zuozi[1]
	end
	mData.regionId=fbid
	mData.x = aPos[1]
	mData.y =aPos[2]
	CreateObjectIndirect(mData)
end
--创建宝箱
function party_cbaoxiang( playerid )
	look('创建宝箱')
	local worlddata=GETZYparty_Data(playerid)
	local fbid=worlddata.fbid
	local poslist=worlddata.poslist
	local mData=p_monster.zuozi[3]
	mData.regionId=fbid
	mData.x = poslist[1][1]
	mData.y = poslist[1][2]
	CreateObjectIndirect(mData)
end


--开启宴会
function StartZYparty(playerid,num)
	local worlddata=GETZYparty_Data(playerid)
	if worlddata==nil then return end
	local partydata=GetDBZYpartyData( playerid )
	if partydata==nil then 
		return
	end
	if worlddata.partytype then  --开启中
		TipCenter(GetStringMsg(433)) 
		return 
	end
	local nowlv=CI_GetPlayerData(1)--现在人物等级
	if nowlv<30 then

		SendLuaMsg(0,{ids=STARTParty,result=11},9)
		return
	end
	if not CheckTimes(playerid,uv_TimesTypeTb.ZY_Partyputout,1,-1,1) then --检测次数
			SendLuaMsg(0,{ids=STARTParty,result=1},9)
		 	return
	end
	local tempdata=GetDBZYtempdata(playerid)
	if tempdata.in_~=playerid then
		look('not in your house')
		return
	end
	
	if 	Checkfood(playerid,num)==nil  then return end--检测食材

	worlddata.partytype=num
	CheckTimes(playerid,uv_TimesTypeTb.ZY_Partyputout,1,-1)
	local  temptime=GetServerTime()
	
	local mapinfo=GetZY_mapinfo(playerid)--地图信息
	if mapinfo==nil or type(mapinfo)~=type({}) then
		look('EnterZY_maperror',1)
		return
	end
	
	worlddata.poslist=mapinfo[5]
	worlddata.starttime=temptime

	StartZYparty_npc(playerid,1)

	SetEvent(a_time,nil,'EndZYparty',playerid)--6分钟后结束
	tempdata.in_=playerid

	local cangetexp=getexp_ZYparty(playerid,playerid,1)
	if num==5 then 
		cangetexp=rint(nowlv^2.5*25)
	end
	PI_PayPlayer(1,cangetexp,0,0,'宴会开启')--加自己经验
	partydata.kexp =cangetexp

	RegionRPC(worlddata.fbid,'party_start',temptime,num)
	CI_SetDRDelMode(worlddata.fbid,0)--转为手动清除)
	partydata.free =nil--5次敬酒
	party_movemonster(playerid,1,worlddata.fbid)-- 列队欢迎

end
--宴会经验结束--定时回调,需全局
function EndZYparty(playerid)
	look('宴会经验结束--定时回调,需全局')
	local worlddata=GETZYparty_Data(playerid)
	if worlddata==nil then return end
	local rID=worlddata.fbid

	RemoveObjectIndirect(rID, 20)


	--给主人+经验,不在线不加
	if IsPlayerOnline(playerid) then
		if  (worlddata.eatall or 0)>=party_maxeat( worlddata.partytype )*6 then 
			local cangetexp=getexp_ZYparty(playerid,playerid,1)
		
			local a=PI_PayPlayer(1,cangetexp,0,0,'宴会开启',2,playerid)--加主人经验

			local partydata=GetDBZYpartyData( playerid )
			partydata.eexp =(partydata.eexp or 0)+cangetexp

		end
	end

	worlddata.starttime=nil
	worlddata.partytype=nil
	worlddata.cid=nil
	worlddata.eatall=nil

	local peoplenum=GetRegionPlayerCount(rID)
	if peoplenum==0 or peoplenum==nil then 
		local a=CI_DeleteDRegion(rID,false)
	else 
		CI_SetDRDelMode(rID,1)--转为自动清除
		party_movemonster(playerid,rID,rID)--家将等移动回原位
	end


end



--点击参加宴会加buff
function Get_partybuff()
	-- look('点击参加宴会加buff')

	local playerid= CI_GetPlayerData(17)
	if playerid==nil then return end
	local nowlv=CI_GetPlayerData(1)--现在人物等级
	if nowlv<38 then
		SendLuaMsg(0,{ids=STARTParty,result=11},9)
		return
	end
	local partydata=GetDBZYpartyData( playerid )
	local tempdata=GetDBZYtempdata(playerid)
	if tempdata ==nil  or  tempdata.in_==nil  then  return end

	local nplayerid=tempdata.in_
	local worlddata=GETZYparty_Data(nplayerid)
	local neixin=worlddata.partytype
	local stime=worlddata.starttime
	if stime==nil then return end 
	if GetServerTime()-stime<d_time-5 or GetServerTime()-stime>a_time then 
			
		SendLuaMsg(0,{ids=STARTParty,result=18,time=d_time-GetServerTime()+stime},9)
		return 
	end
	if neixin==nil then return end
	if (partydata.cc or  0)~=nplayerid then
		if playerid~=nplayerid then 
			if not CheckTimes(playerid,uv_TimesTypeTb.ZY_Partyenter,1,-1,1) then
				OutZYparty(playerid,nil,0)
				SendLuaMsg(0,{ids=STARTParty,result=3},9)
				return
			end
		end
	end
	local buffid,bufftime
	if neixin==1 then
		buffid=84
	elseif neixin>1 and neixin<5 then 
		buffid=85
	else
		buffid=96
	end
	bufftime=math.ceil((buff_time-(GetServerTime()-stime-d_time))/10)

	CI_AddBuff(buffid,0,bufftime,false)
	if (partydata.cc or  0)~=nplayerid then --不同场
		if playerid~=nplayerid then  
			CheckTimes(playerid,uv_TimesTypeTb.ZY_Partyenter,1,-1)
		end
		SendLuaMsg(0,{ids=Join_Party},9)
		partydata.free =nil--10次敬酒
		partydata.pt =nil--吃宴席次数
		partydata.cc=nplayerid--绑定场次
		partydata.pexp =nil--吃宴席得经验
		partydata.dexp =nil--灌醉得经验
		partydata.box=nil
		partydata.eexp=nil
	else
		SendLuaMsg(0,{ids=Join_Party,free=partydata.free},9)
	end
	
end

--------------------完成--------------------------------------
--------------------完成--------------------------------------
--------------------完成--------------------------------------
--------------------完成--------------------------------------
--------------------完成--------------------------------------
--请求宴会结果
function party_getendinfo( playerid )
	local partydata=GetDBZYpartyData( playerid )
	if partydata==nil then 
		return
	end
	partydata.cc=nil
	
	local tempdata=GetDBZYtempdata(playerid)
	if tempdata ==nil  or  tempdata.in_==nil  then  return end

	local nplayerid=tempdata.in_
	local pexp
	if nplayerid==playerid then 
		pexp=partydata.kexp
	else
		pexp=partydata.pexp
	end
	SendLuaMsg(0,{ids=ToastParty1,pexp=pexp,dexp= partydata.dexp,eexp=partydata.eexp,enum=partydata.pt},9)
	partydata.free=nil--敬酒次数
	partydata.pt=nil--吃宴席次数
	partydata.pexp=nil--吃宴席得经验
	partydata.kexp=nil--开宴席得到经验
	partydata.eexp=nil--主人才有,为宴席结束得到经验
	partydata.dexp=nil--灌醉得经验

end

--开宴会时移动怪物
function party_movemonster(playerid,itype,tempid)
	local mapinfo=GetZY_mapinfo(playerid)--地图信息
	if mapinfo==nil or type(mapinfo)~=type({}) then
		look('EnterZY_maperror',1)
		return
	end
	local poslist
	if itype==1 then --开宴会
		poslist=mapinfo[11]
		for i=2,5 do --cid--家将
			CI_UpdateMonsterData(1,{dir=poslist[i][3]},nil,6,i+3) --设置外形
			CI_MoveMonster(poslist[i][1],poslist[i][2],0,6,i+3) --cid 4-8
		end
		party_creatdaji(poslist[1],tempid)
	else --宴会结束


		poslist=mapinfo[6]
		for i=1,4 do --cid--家将
			CI_UpdateMonsterData(1,{dir=poslist[i][3]},nil,6,i+4) --设置外形
			CI_MoveMonster(poslist[i][1],poslist[i][2],0,6,i+4,tempid) --cid 5-8
		end

		poslist=mapinfo[7] --妲己
		party_creatdaji(poslist,tempid)
	end
	
end


--创建妲己怪
function party_creatdaji(pos,tempid)
	local npcid=400101
		RemoveObjectIndirectEx(1,tempid,npcid)
		local CreateInfo=npclist[npcid]
		CreateInfo.NpcCreate.regionId=tempid
		CreateInfo.NpcCreate.x=pos[1]
		CreateInfo.NpcCreate.y=pos[2]
		CreateObjectIndirectEx(1,npcid,CreateInfo.NpcCreate)
end

-- 点击拿宝箱
call_monster_chick[2]=function ()	
	look('点击拿宝箱')
	local playerid= CI_GetPlayerData(17)

	if CI_HasBuff(drink_downbuff) then--醉酒状态
		TipCenter(GetStringMsg(25)) 
		return 
	end

	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return 0
	end		
	if playerid==nil then  return end
	if not  can_useparty( playerid ) then  return end
	local partydata=GetDBZYpartyData( playerid )
	

	local tempdata=GetDBZYtempdata(playerid)
	if tempdata ==nil  or  tempdata.in_==nil  then   return end
	local nplayerid=tempdata.in_
	local worlddata=GETZYparty_Data(nplayerid)
	--local neixin=worlddata.partytype
	local stime=worlddata.starttime
	if GetServerTime()-stime<a_time-30 then  --时间不到
		SendLuaMsg(0,{ids=STARTParty,result=19},9)
		return 
	end
	if partydata.box==nplayerid  then    --本场吃过
		SendLuaMsg(0,{ids=STARTParty,result=20},9)
		return 
	end
	local _,cid = GetObjectUniqueId()
	CI_SetReadyEvent(cid,ProBarType.box,3,0,'party_chick_baoxiang')
end
--开宝箱回调
function party_chick_baoxiang(cid )
	local playerid= CI_GetPlayerData(17)
	local partydata=GetDBZYpartyData( playerid )
	local tempdata=GetDBZYtempdata(playerid)
	if tempdata ==nil  or  tempdata.in_==nil  then   return end
	local nplayerid=tempdata.in_
	partydata.box=nplayerid
	local ran=math.random(1,3)
	local id
	if ran==1 then 
		id=691
		GiveGoods(691,1,1,' 宴会宝箱')--梳妆盒
	elseif ran==2 then 
		id=601
		GiveGoods(601,1,1,' 宴会宝箱')--高级铜钱
	else
		id=1073
		GiveGoods(640,1,1,' 宴会宝箱')--绑定元宝
	end
	local oldx,oldy=GetMonsterData(28,6,cid)
	RPC('party_getbox',id,oldx,oldy)
end
 

