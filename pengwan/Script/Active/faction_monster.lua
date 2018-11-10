--[[
file:	faction_monster.lua
desc:	帮会神兽
author:	wk
update:	2013-07-9
]]--

local active_mgr_m = require('Script.active.active_mgr')
local active_ss = active_mgr_m.active_ss
local CreateObjectIndirect=CreateObjectIndirect
local FactionRPC=FactionRPC
local look=look
local PI_MovePlayer=PI_MovePlayer
local CI_GetCurPos=CI_GetCurPos
-- local GetFactionSoulCDData=GetFactionSoulCDData
local TipCenter=TipCenter
local GiveGoods=GiveGoods
local _floor=math.floor
local GetStringMsg=GetStringMsg
local sc_add=sc_add
local sc_reset_getawards=sc_reset_getawards
local AddPlayerPoints=AddPlayerPoints
local SetEvent=SetEvent
local sc_getdaydata=sc_getdaydata
local CI_GetPlayerData=CI_GetPlayerData
local RegionRPC=RegionRPC
local PI_PayPlayer=PI_PayPlayer
local GetServerTime=GetServerTime
local CI_GetFactionInfo=CI_GetFactionInfo
local CI_GetMemberInfo=CI_GetMemberInfo
local scoreid=7
local RPC=RPC
local __G=_G
local call_monster_dead=call_monster_dead
local GI_GetPlayerData=GI_GetPlayerData
local DRList=DRList
local MonsterEvents=MonsterEvents
local MonsterRegisterEventTrigger=MonsterRegisterEventTrigger
local cTimer=DRList.ss[1].cTimer --副本持续时间
local GetWorldLevel=GetWorldLevel
local define = require('Script.cext.define')
local FACTION_BZ = define.FACTION_BZ
local FACTION_FBZ=define.FACTION_FBZ
----------------------------------------------------------------------------
-- module:

module(...)

----------------------------------------------------------------------------

--神兽等级={神兽祭坛等级	帮贡奖励	经验奖励	铜钱奖励}
local baesconf={
	[55]={1,100,8000,100000},
	[60]={2,150,10000,200000},
	[65]={3,200,12000,300000},
	[70]={4,250,15000,400000},
	[75]={5,300,16000,500000},
	[80]={6,350,17000,550000},
	[85]={7,400,20000,600000},
	[90]={8,450,25000,650000},
	[95]={9,500,30000,700000},
	[100]={10,550,40000,750000},	
}


local boss_temp = {
	[55]={
		[1]={ monsterId = 270,x=17,y=33,deadbody = 6 , deadScript = 4101,},
		[2]={ monsterId = 270,x=36,y=15,deadbody = 6 , deadScript = 4102,}, 
		[3]={ monsterId = 280,x=11,y=11,dir=6,EventID = 1, eventScript = 1012,controlId = 1005,deadScript = 4103,},
		},
	[60]={
		[1]={ monsterId = 271,x=17,y=33,deadbody = 6 , deadScript = 4101,},
		[2]={ monsterId = 271,x=36,y=15,deadbody = 6 , deadScript = 4102,}, 
		[3]={ monsterId = 281,x=11,y=11,dir=6,EventID = 1, eventScript = 1012,controlId = 1005,deadScript = 4103,},
		},
	[65]={
		[1]={ monsterId = 272,x=17,y=33,deadbody = 6 , deadScript = 4101,},
		[2]={ monsterId = 272,x=36,y=15,deadbody = 6 , deadScript = 4102,}, 
		[3]={ monsterId = 282,x=11,y=11,dir=6,EventID = 1, eventScript = 1012,controlId = 1005,deadScript = 4103,},
		},
	[70]={
		[1]={ monsterId = 273,x=17,y=33,deadbody = 6 , deadScript = 4101,},
		[2]={ monsterId = 273,x=36,y=15,deadbody = 6 , deadScript = 4102,}, 
		[3]={ monsterId = 283,x=11,y=11,dir=6,EventID = 1, eventScript = 1012,controlId = 1005,deadScript = 4103,},
		},
	[75]={
		[1]={ monsterId = 274,x=17,y=33,deadbody = 6 , deadScript = 4101,},
		[2]={ monsterId = 274,x=36,y=15,deadbody = 6 , deadScript = 4102,}, 
		[3]={ monsterId = 284,x=11,y=11,dir=6,EventID = 1, eventScript = 1012,controlId = 1005,deadScript = 4103,},
		},
	[80]={
		[1]={ monsterId = 275,x=17,y=33,deadbody = 6 , deadScript = 4101,},
		[2]={ monsterId = 275,x=36,y=15,deadbody = 6 , deadScript = 4102,}, 
		[3]={ monsterId = 285,x=11,y=11,dir=6,EventID = 1, eventScript = 1012,controlId = 1005,deadScript = 4103,},
		},
	[85]={
		[1]={ monsterId = 276,x=17,y=33,deadbody = 6 , deadScript = 4101,},
		[2]={ monsterId = 276,x=36,y=15,deadbody = 6 , deadScript = 4102,}, 
		[3]={ monsterId = 286,x=11,y=11,dir=6,EventID = 1, eventScript = 1012,controlId = 1005,deadScript = 4103,},
		},
	[90]={
		[1]={ monsterId = 277,x=17,y=33,deadbody = 6 , deadScript = 4101,},
		[2]={ monsterId = 277,x=36,y=15,deadbody = 6 , deadScript = 4102,}, 
		[3]={ monsterId = 287,x=11,y=11,dir=6,EventID = 1, eventScript = 1012,controlId = 1005,deadScript = 4103,},
		},
	[95]={
		[1]={ monsterId = 278,x=17,y=33,deadbody = 6 , deadScript = 4101,},
		[2]={ monsterId = 278,x=36,y=15,deadbody = 6 , deadScript = 4102,}, 
		[3]={ monsterId = 288,x=11,y=11,dir=6,EventID = 1, eventScript = 1012,controlId = 1005,deadScript = 4103,},
		},
	[100]={
		[1]={ monsterId = 279,x=17,y=33,deadbody = 6 , deadScript = 4101,},
		[2]={ monsterId = 279,x=36,y=15,deadbody = 6 , deadScript = 4102,}, 
		[3]={ monsterId = 289,x=11,y=11,dir=6,EventID = 1, eventScript = 1012,controlId = 1005,deadScript = 4103,},
		},
	}
--------------------------------------------------------

ss_alldata=ss_alldata or {}

--取神兽数据--帮会数据下
local function ss_getdata(fid)
	local fdata=__G.GetFactionData(fid)
	if fdata==nil then return end
	if fdata.ss==nil then
		fdata.ss={

			-- [2]=nil ,--nil为未招,1为招过

		}
	end
	return fdata.ss

end
--取神兽数据--全局数据,宕机等情况用
local function ss_getalldata(fid,itype)
	if itype==1 then
		if ss_alldata[fid]==nil then 
			ss_alldata[fid]={
				-- [1]=nil ,--判断活动开否,存储副本gid
				-- [3]=nil	,--小boss死亡总次数
				-- [4]=nil	,--小boss1死亡时间
				-- [5]=nil	,--小boss2死亡时间
				-- [6]=nil	,--召唤神兽等级
				-- [7]=nil	,--帮贡奖励
				-- [8]=nil	,--经验奖励
				-- [9]=nil	,--铜钱奖励
				-- [10]=cTimer+now--副本结束时间
			}
		end
	end
	return ss_alldata[fid]
end
--玩家数据
local function ss_getpdata( playerid )
	local ssdata=GI_GetPlayerData( playerid , 'ss' , 20 )
	if ssdata == nil then return end 
	--ssdata[1]=fid--有值说明打过,值不一样说明换帮,不能再打
	return ssdata
end
--创建boss----itype=1刷1boss,2刷2boss,3刷3boss,4刷两个,创建时用
local function _ss_creatboss(mapgid,lv,itype,fid)

	if lv==nil then return end
	if itype==1 or itype==2 then 
		local ssdata=ss_getalldata(fid)
		if ssdata==nil then return end
		if (ssdata[4] or 0)==1 or (ssdata[5] or 0)==1 then
			return
		end
	end
	local bossdata
	if itype==4 then
		for i=1,2 do
			bossdata=boss_temp[lv][i]
			bossdata.regionId=mapgid
			CreateObjectIndirect(bossdata)
		end
	else
		bossdata=boss_temp[lv][itype]
		bossdata.regionId=mapgid
		local mon_gid = CreateObjectIndirect(bossdata)
		if mon_gid and bossdata.EventID and bossdata.eventScript and bossdata.eventScript > 0 then
			look("触发怪物变身:" .. bossdata.eventScript)
			MonsterRegisterEventTrigger( bossdata.regionId, mon_gid, MonsterEvents[bossdata.eventScript])
		end
	end

	

	if  itype==2 or itype==1 then
		RegionRPC(mapgid,'ss_rpc', 2) 
	end
end

----------------------------------------------------------------------


--召唤神兽
local function _ss_call(playerid,lv)

	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return  --帮会不存在
	end
	
	local pdata=ss_getpdata( playerid )
	if pdata ==nil then return end
	if pdata[1]==nil then 
		pdata[1]=fid
	else
		if pdata[1]~=fid then 
			TipCenter(GetStringMsg(441))	
			return 
		end
	end

	local title = CI_GetMemberInfo(1)
	if title~=FACTION_BZ and title~=FACTION_FBZ  then  return  end --不是帮主
	-- local _,_,_,gid = CI_GetCurPos()
	-- if gid then
	-- 	TipCenter(GetStringMsg(17))
	-- 	return
	-- end
	if baesconf[lv]==nil then  return end
	local needflv=baesconf[lv][1]
	local nowflv=CI_GetFactionInfo(nil,7)  -----------------神兽祭坛等级

	if nowflv<needflv then  return end
	
	local _ssdata=ss_getdata(fid)
	local ssdata=ss_getalldata(fid,1)
	if ssdata==nil then return end
	local now= GetServerTime()
	
	if ssdata[1]~=nil then --已经召唤了
		return 
	end 
	--if now<(_ssdata[2] or 0) then  return end---时间不到
	if _ssdata[2]  and _ssdata[2]==1  then  
		TipCenter(GetStringMsg(441))
		return 
	end
	local fbid=active_ss:createDR(1)
	ssdata[1]=fbid
	--_ssdata[2]=now+24*3600--48小时后可以召唤
	_ssdata[2]=1
	ssdata[6]=lv
	_ss_creatboss(fbid,lv,4,fid)
	local giddata=active_ss:get_regiondata(fbid)
	
	if giddata==nil then  return end
	giddata.fid=fid
	
	active_ss:add_player(playerid, 1, 0,nil,nil, fbid) 
	


	FactionRPC( fid, 'ss_start', lv,_ssdata[2])
	sc_add(playerid,scoreid,1,1)---神兽积分加1,用作参加标识,领奖后清除
	RPC('ss_rpc', 1)
	ssdata[10]=cTimer+now--副本结束时间
	SetEvent(cTimer-5, nil, 'GI_ss_endfail',fid) --提前5秒失败

	RPC('ss_time', ssdata[10])
end
--进入神兽地图
local function _ss_enter(playerid)

	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
	
		return  --帮会不存在
	end
	-- local _,_,_,gid = CI_GetCurPos()
	-- if gid then
	-- 	TipCenter(GetStringMsg(17))
	-- 	return
	-- end

	local ssdata=ss_getalldata(fid)
	if ssdata==nil then return end
	if ssdata[1]==nil then
		TipCenter(GetStringMsg(437))
		return 
	end
	local pdata=ss_getpdata( playerid )
	if pdata ==nil then return end
	if pdata[1]==nil then 
		pdata[1]=fid
	else
		if pdata[1]~=fid then 
			TipCenter(GetStringMsg(441))	
			return 
		end
	end

	local tempid=ssdata[1]

	active_ss:add_player(playerid, 1, 0,nil,nil, tempid) 
	RPC('ss_time', ssdata[10])
	if (ssdata[5] or 0)~=1 and (ssdata[4] or 0)~=1 then--已经出大boss
		RPC('ss_rpc', 1)
	end
	sc_add(playerid,scoreid,1,1)---神兽积分加1,用作参加标识,领奖后清除
end
--退出
local function _ss_exit(playerid)

	active_ss:back_player(playerid)
end
--移除动态场景回调

 function active_ss:on_regiondelete(RegionID, fbid)
 	 look('移除动态场景回调')
	local giddata=active_ss:get_regiondata(fbid)
	if giddata==nil then return end

	local fid=giddata.fid
	-- look(RegionID)
	-- look(fbid)
	-- look(ss_alldata[fid])
	-- if ss_alldata[fid][1]~=nil then
	-- 	RegionRPC(ss_alldata[fid][1],'ss_fail')
	-- 	look('发送失败信息')
	-- end
	look('置空')
	ss_alldata[fid]=nil
end
function _ss_endfail( fid )

	if ss_alldata[fid]==nil then return end
	if ss_alldata[fid][1]~=nil then
		RegionRPC(ss_alldata[fid][1],'ss_fail')
		look('发送失败信息')
	end
end

--回城复活回调
function  active_ss:on_playerlive( sid )

	local x, y,regionId,mapGID = CI_GetCurPos()
	PI_MovePlayer(0, 39, 38,mapGID)
	return 1
end
--刷新上线调用
local function _ss_onlogin(playerid)

	if playerid==nil then return end
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return  --帮会不存在
	end
	local ssdata=ss_getalldata(fid)
	if ssdata==nil then return end
	if ssdata[1]~=nil then
		RPC('ss_start', ssdata[6])
		RPC('ss_time', ssdata[10])
	end
end
--杀死小boss回调
call_monster_dead[4101]=function ()
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return  --帮会不存在
	end
	local ssdata=ss_getalldata(fid)
	if ssdata==nil then return end
	ssdata[3]=(ssdata[3] or 0 )+1
	local now=GetServerTime()
	local last=ssdata[5] or 0
	local lv=ssdata[6]
	local fbid=ssdata[1]
	if now<last+60 or ssdata[3]==5 then --刷大boss
		_ss_creatboss(fbid,lv,3,fid)
		ssdata[4]=1--用以标识另个小boss不刷新
		RegionRPC(ssdata[1],'ss_come')
	else
		ssdata[4]=GetServerTime()
		SetEvent(60, nil, 'GI_ss_creatboss',fbid,lv,1,fid ) --60秒后复活
	end
end
call_monster_dead[4102]=function ()
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return  --帮会不存在
	end
	local ssdata=ss_getalldata(fid)
	if ssdata==nil then return end
	ssdata[3]=(ssdata[3] or 0 )+1
	local now=GetServerTime()
	local last=ssdata[4] or 0
	local lv=ssdata[6]
	local fbid=ssdata[1]
	if now<last+60 or ssdata[3]==5 then --刷大boss
		_ss_creatboss(fbid,lv,3,fid)
		ssdata[5]=1--用以标识另个小boss不刷新
		RegionRPC(ssdata[1],'ss_come')
	else
		ssdata[5]=GetServerTime()
		SetEvent(60, nil, 'GI_ss_creatboss',fbid,lv,2,fid ) --60秒后复活
	end
end
--杀死大boss回调
call_monster_dead[4103]=function ()
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return  --帮会不存在
	end
	local ssdata=ss_getalldata(fid)
	if ssdata==nil then return end
	local lv=ssdata[6]
	local gid=ssdata[1]
	local award=baesconf[lv]
	local  data = __G.GetFactionSoulCDData(fid)
	local ss_up=(data[1]+100)/100
	
	local bg=_floor(award[2]*ss_up)
	local _exp=_floor(award[3]*ss_up*GetWorldLevel())
	local money=_floor(award[4]*ss_up)
	
	ssdata[7]=bg
	ssdata[8]=_exp
	ssdata[9]=money
	
	data[1]=0---成长度清0
	RegionRPC(gid,'ss_succ',bg,_exp,money)
	
	ssdata[1]=nil
	ssdata[3]=nil
	ssdata[4]=nil
	ssdata[5]=nil
	ssdata[6]=nil
end
--领奖
local function _ss_getaward(playerid)

	local getmark=sc_getdaydata(playerid,scoreid)
	if getmark==nil then  return end
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return  --帮会不存在
	end
	local ssdata=ss_getalldata(fid)
	if ssdata==nil then return end
	local bg=ssdata[7]
	if bg==nil then return end
	local _exp=ssdata[8]
	local money=ssdata[9]
	
	AddPlayerPoints( playerid , 4 , bg , nil,'神兽')
	GiveGoods(0,money,1,"神兽")
	PI_PayPlayer(1, _exp,0,0,'神兽')
	sc_reset_getawards(playerid,scoreid)

	RPC('ss_getaward')
	--active_ss:back_player(playerid)
end

--清零数据
local function _ss_reset( playerid )
	local pdata=ss_getpdata( playerid )
	if pdata ==nil then return end
	 pdata[1]=nil  
end

local function _ss_clcd(playerid)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return  --帮会不存在
	end
	local ssdata=ss_getdata(fid)
	ssdata[2]=0
	
end
--------------------------------------------------------
ss_call=_ss_call
ss_enter=_ss_enter
ss_exit=_ss_exit
ss_onlogin=_ss_onlogin
ss_getaward=_ss_getaward
ss_creatboss=_ss_creatboss
ss_clcd=_ss_clcd
ss_reset=_ss_reset
ss_endfail=_ss_endfail