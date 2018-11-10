--[[
file: span_3v3_l.lua
desc: 跨服3v3_本地版
autor: wk
time:2014-3-3
]]--
---------------------------------------------------------------
--include:
local reg_info = msgh_s2c_def[43][1]
local reg_creat = msgh_s2c_def[43][2]
local reg_succ = msgh_s2c_def[43][3]
local reg_mi = msgh_s2c_def[43][4]
local reg_fair = msgh_s2c_def[43][5]
local _random=math.random
local db_module = require('Script.cext.dbrpc')
local db_get_span_server = db_module.db_get_span_server

local SPAN_3v3_ID=4 --跨服3v3活动id
local LTRMAPID = 101 -- 擂台报名地图ID
local LTMapPos = { --进入点随机坐标
	{16, 21},
}

---------------------------------------------------------------
--module:

-- module(...)

---------------------------------------------------------------
--data:
--积分段档次
-- local score_conf={
-- 	[1]=-1000,
-- 	[2]=0,
-- 	[3]=1000,
-- 	[4]=1500,
-- 	[5]=2000,
-- 	[6]=2500,
-- 	[7]=3000,
-- }
-- local score_conf={
-- 	[1]=-1000,
-- 	[2]=5000,
-- 	[3]=1000,
-- 	[4]=1500,
-- 	[5]=2000,
-- 	[6]=2500,
-- 	[7]=3000,
-- }
---------------------------------------------------------------


-- 取公共数据(活动结束清除)
local function reg_getpub()
	local pub_data = GetWorldCustomDB()
	if pub_data ==nil then return end
	--pub_data.mark=1 --活动开启标识
	pub_data.room = pub_data.room or {}  --房间列表
	--[[
		[1]={ --编号1
			[1]=name,--房主姓名
			[2]	=lv,--等级
			[3]	=osid,--对手sid
			[4]	=fid,--帮会id,名字
			[5]=111--,密码
			[6]=11,队员1sid
			[7]=11,队员1
			[8]=sid,房主sid
			[9]=11,3个队员准备情况
			},

		]]
	return pub_data
end

--玩家永久数据
function v3_getplayerdata(sid)
	local act_data = GetDBActiveData(sid)
	if act_data == nil then return end
	if act_data.v3 == nil then
		act_data.v3 = {
		--[[
			[1]=1,胜利总次数
			[2]=1,失败总次数
			[3]=1,历史最大连胜
			[4]=1,当前连胜
			[5]=1,历史跨服荣誉
			[6]=1,今日跨服荣誉
			[7]=1,今日连胜跨服荣誉
			psid={sid1,sid2}---配对成功,自己队积分,对手队
			team={1,1}--房间编号,位置
			dead=1,玩家死亡次数
			jf=11,积分
			t={sid1,sid2,sid3}--3个人,回本服组队用
			tsid--队长sid
		]]--
		}
	end
	return act_data.v3
end

---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
--开始
function _v3reg_start()
	-- look('开启活动',1)
	local adata=reg_getpub()
	if adata==nil then return end
	adata.room=nil
	adata.mark=1--开启标识
	-- 获取跨服3v3活动大区列表(回调函数: CALLBACK_SpanServerGets)
	db_get_span_server(SPAN_3v3_ID,0)
	-- local spxb = GetSpanListData(SPAN_3v3_ID)
	-- look(spxb[1],1)
	BroadcastRPC('v3_reg_Start')

end
--结束
local function _v3reg_end()
	local adata=reg_getpub()
	if adata==nil then return end
	adata.room=nil
	adata.mark=nil
	BroadcastRPC('v3_reg_End')
end
--每日重置
function v3_reset( sid )
	local pdata=v3_getplayerdata(sid)
	if pdata==nil then return end
	pdata[6]=nil
	pdata[7]=nil
end
--上线判断
function _v3reg_online( sid )
	-- look('上线判断',1)
	local x, y, rid, mapgid = CI_GetCurPos()
	local adata=reg_getpub()
	if adata==nil then return end
	if adata.mark==nil  then return end

	if rid==101 then 
		if  adata.room==nil then return end
		local teamID = CI_GetPlayerData(12)
		local bLeader
		if teamID and teamID ~= 0 then
			-- look('有队伍',1)
			local TeamInfo = GetTeamInfo()	
			local leaderSID
		  	for k,v in pairs(TeamInfo) do
		  		if k==1 then 
		  			leaderSID=v.staticId
		  		end			
			end
			if adata.room[leaderSID]~=nil then 
					-- look(111,1)
				SendLuaMsg(0,{ids=reg_creat,tinfo=adata.room[leaderSID]},9)
			end
		else
			if adata.room[sid]~=nil then --自己一个人创建状态
				-- look(111,1)
				SendLuaMsg(0,{ids=reg_creat,tinfo=adata.room[sid]},9)
			else --查是不是跨服回来,继续组队
				local pdata=v3_getplayerdata(sid)
				if pdata~=nil and pdata.t~=nil then 
					local sid1=pdata.t[1]
					local sid2=pdata.t[2]
					local sid3=pdata.t[3]
					if sid==sid3 then --队长
						if sid1 then
							AskJoinTeam(sid1,sid3)--第2个参数为队长
						end
						if sid2 then
							AskJoinTeam(sid2,sid3)--第2个参数为队长
						end
					else --队员
						AskJoinTeam(sid,sid3)--第2个参数为队长
					end
				end
			end
		end

	end
	-- look('上线判断完成',1)
	RPC('v3_reg_Start',1)
	
end
--进入报名场景
function _v3reg_enter( sid)
	-- local lv = CI_GetPlayerData(1)
	-- if lv and lv < 35 then
	-- 	return
	-- end
	local adata=reg_getpub()
	if adata==nil then return end
	if adata.mark~=1 then --开启标识
		return
	end

	local rd = _random(1, #LTMapPos)
	local pos = LTMapPos[rd]
	if not PI_MovePlayer(LTRMAPID,pos[1],pos[2],0,2,sid) then
		look("_lt_putinto_map faild")
	end
end

--请求组队列表 
local function _reg_getteaminfo( )
	-- look('请求组队列表',1)
	local adata=reg_getpub()
	if adata==nil then return end
	local roomdata=adata.room
	SendLuaMsg(0,{ids=reg_info,info=roomdata},9)
end
--创建3v3房间
local function _reg_creatteam( sid ,mi)
	-- look('创建3v3房间',1)
	local adata=reg_getpub()
	-- local pdata=reg_get_mydata(sid)
	if adata==nil then return end
	local roomdata=adata.room
	  -- [3] check team leader
	local teamID = CI_GetPlayerData(12)
	-- look("teamID:" .. teamID,1)
	local bLeader
	if teamID and teamID ~= 0 then
		bLeader = CI_GetPlayerData(13)
		if bLeader and bLeader == 0 then-- 有队伍却不是队长不能创建房间	
			return
		end
	end

	if roomdata[sid]~=nil then 
		-- TipCenter('已创建')
		return
	end

	local tinfo={
		[1]=CI_GetPlayerData(5),--房主姓名
		[2]	=CI_GetPlayerData(1),--等级
		-- [3]	=CI_GetPlayerData(23),--帮会名字,改成对手sid了
		-- [4]	=CI_GetPlayerData(23),--帮会id,名字
		[4]=CI_GetFactionInfo(nil,1),
		-- [5]=mi,--,密码

		[8]=sid,
		}
	if bLeader then
		local TeamInfo = GetTeamInfo()	
		local ti=6
	  	for _,v in pairs(TeamInfo) do			
			if v.staticId ~= nil and v.staticId ~= sid then
				tinfo[ti]=v.staticId
				ti=ti+1
			end
		end	
	end
	-- _insert(roomdata,tinfo)
	roomdata[sid]=tinfo
	-- pdata.id=#roomdata
	-- look(#roomdata,1)
	-- look(pdata,1)
	local teamID = CI_GetPlayerData(12)
	if teamID and teamID ~= 0 then
		local att={}
		for i=6,8 do
			if roomdata[sid][i] then 
				att[i]=CI_GetPlayerData(62,2,roomdata[sid][i])
			end
		end
		TeamRPC(teamID,"reg_in",tinfo,att)
	else

		SendLuaMsg(0,{ids=reg_creat,tinfo=tinfo},9)
	end
	-- look(roomdata,1)
end

--进入组队
local function _reg_intoteam( sid,osid,mi )
	-- look('进入组队',1)
	-- look(sid,1)
	-- look(osid,1)
	-- look(CI_GetPlayerData(5,2,osid),1)
	local index=osid
	local adata=reg_getpub()
	if adata==nil then return end
	local roomdata=adata.room
	
	if roomdata[index]==nil then 
		SendLuaMsg(0,{ids=reg_mi,res=3},9)
		return 
	end
	if roomdata[index][5] then --密码
		if mi~=roomdata[index][5] then 
			SendLuaMsg(0,{ids=reg_mi,res=2},9)
			return 
		end
	end

	local ret = AskJoinTeam(sid,osid)
	-- look(ret,1)
	if ret == false then 
		-- look(333,1)
		return 
	end

	if roomdata[index][6]==nil then
		roomdata[index][6]=sid
	elseif roomdata[index][7]==nil then
		roomdata[index][7]=sid
	else
		return
	end

	local att={}
	for i=6,8 do
		if roomdata[index][i] then 
			att[i]=CI_GetPlayerData(62,2,roomdata[index][i])
		end
	end

	local teamID = CI_GetPlayerData(12)
	TeamRPC(teamID,"reg_in",roomdata[index],att)
	-- look(555,1)
end
--快速进入
function v3_quick_in( sid )
	-- look('快速进入',1)
	local adata=reg_getpub()
	if adata==nil then return end
	local roomdata=adata.room
	local mark
	for k,v in pairs(roomdata) do
		if (v[6]==nil or v[7]==nil) and type(v[8])==type(0) then 
			if v[5]==nil then --未加密
				-- look(111,1)
				_reg_intoteam( sid,v[8] )
				mark=1
				break
			end
		end
	end
	if not mark then 
		-- look(222,1)
		_reg_creatteam( sid )
	end
end
--修改密码
function v3_changemima( sid,mi )
	-- look('修改密码',1)
	-- look(mi,1)
	local adata=reg_getpub()
	if adata==nil then return end
	local roomdata=adata.room
	if roomdata[sid]==nil then return end
	roomdata[sid][5]=mi
	SendLuaMsg(0,{ids=reg_mi,res=1},9)
	-- look(1111,1)
end
--踢出队员 t队长是解散队伍
local function _reg_tplayer( sid,name )
	-- look('踢出队员',1)
	-- look(sid,1)
	-- look(name,1)
	local adata=reg_getpub()
	if adata==nil then return end
	local roomdata=adata.room

	local TeamInfo = GetTeamInfo()	
	local leaderSID
	
	if TeamInfo then
	  	for k,v in pairs(TeamInfo) do
	  		if k==1 then 
	  			leaderSID=v.staticId
	  		end			
		end
	else
		leaderSID=sid
	end
	-- look(1111,1)
	-- local osid=GetPlayer(name)
	local osid=name
	local teamID = CI_GetPlayerData(12)
	if roomdata[leaderSID]==nil then return end
	local info=roomdata[leaderSID]
	if info[6]==osid then ---个位
		-- look(222,1)
		info[6]=nil
		info[9]= rint((info[9] or 0)/10)*10--将个位去掉
		-- look(roomdata[leaderSID],1)
		--如果7有人移到6来
		if info[7] then
			info[6]=info[7]
			info[9]= rint((info[9] or 0)/10)---将十位转化为个位
			info[7]=nil
		end

		TeamRPC(teamID,"reg_in",roomdata[leaderSID]) --组队广播
	elseif info[7]==osid then ---十位
		-- look(3333,1)
		info[7]=nil
		info[9]= (info[9] or 0)%10--将十位去掉
		-- look(roomdata[leaderSID],1)
		TeamRPC(teamID,"reg_in",roomdata[leaderSID]) --组队广播
	elseif info[8]==osid then 
		-- look(4444,1)
		roomdata[leaderSID]=nil --解散
		-- local teamID = CI_GetPlayerData(12)
		-- if teamID and teamID ~= 0 then
		-- 	TeamRPC(teamID,"reg_js") --解散
		-- else
		-- 	RPC("reg_js")
		-- end
		TeamRPC(teamID,"reg_in",roomdata[leaderSID]) --组队广播
	end
	-- DeleteTeamMember(leaderSID,name)
	DeleteTeamMember(leaderSID,CI_GetPlayerData(5,2,name))
end

--下线
function v3reg_logout( sid )
	-- look('下线',1)
	local adata=reg_getpub()
	if adata==nil then return end
	if  adata.room==nil then return end ---跨服不处理
	if adata.room[sid]~=nil then --队长下线
		if adata.room[sid][6] then
			_reg_tplayer( sid,adata.room[sid][6] )
		end
		if adata.room[sid][7] then
			_reg_tplayer( sid,adata.room[sid][7] )
		end
		adata.room[sid]=nil
		return
	end
	--队员下线
	local TeamInfo = GetTeamInfo()	
	-- look(99,1)
	if TeamInfo==nil then return end
	local tsid
	-- look(88,1)
  	for k,v in pairs(TeamInfo) do			
		if k==1 then 
			tsid=v.staticId
			break
		end
	end	
	if tsid==nil then return end 
	-- look(sid,1)
	-- look(tsid,1)
	-- look(adata.room,1)
	if adata.room[tsid]~=nil then 
		-- look(00,1)
		_reg_tplayer( sid,sid ) --t自己
		local pdata=v3_getplayerdata(sid)
		if pdata==nil then return end
		pdata.t=nil --本服下线,去掉上线重组功能
	end
	-- pdata.psid=nil---配对成功,自己队积分,对手队
	-- pdata.team=nil--房间编号,位置
	-- pdata.dead=nil--,玩家死亡次数

end
--准备完成,itype=1取消准备
local function _reg_reday( sid,itype )
	-- look('准备完成',1)
	-- look(itype,1)
	local adata=reg_getpub()
	if adata==nil then return end
	local roomdata=adata.room

	local TeamInfo = GetTeamInfo()	
	local leaderSID
	if TeamInfo==nil then return end
  	for k,v in pairs(TeamInfo) do
  		if k==1 then 
  			leaderSID=v.staticId
  		end			
	end
	if leaderSID==nil then return end
	local info=roomdata[leaderSID]
	if info==nil then return end
	if  sid==info[6] then
		if itype==1 then
			info[9]= rint((info[9] or 0)/10)*10
		else
			info[9]= (info[9] or 0) +1
		end
	elseif  sid==info[7] then
		if itype==1 then--quxiao
			info[9]= (info[9] or 0)%10
		else
			info[9]= (info[9] or 0)%10 +10
		end
	end
	-- look(info[9],1)
	local teamID = CI_GetPlayerData(12) 
	TeamRPC(teamID,"reg_in",roomdata[leaderSID]) --进入组队广播
	--SendLuaMsg(osid,{ids=reg_zb,osid=sid},10)
end
--队长报名
local function _reg_sign(sid )
	-- look('队长报名',1)
	local adata=reg_getpub()
	if adata==nil then return end
	local roomdata=adata.room
	-- local signdata=adata.sign
	-- local pdata=reg_get_mydata(sid)
	-- local id=pdata.id
	local id=sid
	-- local jifen=333
	local jifen=0
	local num=0
	if roomdata[id]==nil then return end
	local sid1=roomdata[id][6]
	local sid2=roomdata[id][7]
	local sid3=roomdata[id][8]
	local neednum=0
	for i=6,8 do
		
		if roomdata[id][i] then 
			local pdata=v3_getplayerdata(roomdata[id][i])
			if pdata then 
				pdata.t={sid1,sid2,sid3}
				pdata.deadnum=nil
				jifen=jifen+(pdata.jf or 1000)
				num=num+1
				if i==6 then 
					neednum=1
				elseif i==7 then
					neednum=neednum+10
				end
			end
		end
		
	end

	if (roomdata[id][9] or 0)~=neednum then 

		return 
	end

	jifen=jifen/num
	-- look(jifen,1)
	

	local teaminfo={sid1,sid2,sid3,jifen,GetGroupID()}
	roomdata[id]=nil
	local teamID = CI_GetPlayerData(12) 
	if teamID and teamID ~= 0 then
		TeamRPC(teamID,"v3_lock") --报名跨服中,锁定界面
	else
		RPC("v3_lock") --报名跨服中,锁定界面
	end

	--37玩103,360 101,多玩102
	local serverid=9990001
	-- if __plat == 101 or __plat == 102 or __plat == 103 then
	-- 	serverid = 9990101
	-- end
	--合跨服后 使用9990001
	-- if  __plat == 103 then
		-- serverid = 9990101
	-- elseif __plat == 101 then
		-- serverid = 9990111
	-- end
	-- look(GetGroupID(),1)
	PI_SendToSpanSvr(serverid,{ ids = 4001, svrid = GetGroupID(),info=teaminfo})
end

--收到跨服服务器回复,res=1配对成功,osid=另一组队长id
function _v3reg_get_kfref(res,ojf,info,id,num,kfnum)
	-- look('收到跨服服务器回复',1)
	-- look(res,1)
	-- look(osid,1)
	-- look(info,1)
	if res~=1 then return end
	local jf=info[4]
	for i=1,3 do
		if info[i] then 
			local pdata=v3_getplayerdata(info[i])
			if pdata then 
				pdata.psid={jf,ojf,kfnum}
				pdata.team={id,num}
				-- look('发送给前台确认',1)
				SendLuaMsg(info[i],{ids=reg_succ,info=info},10)
			end
		end
	end
end
--前台确认请求
local function _v3reg_endin(sid,pass, localIP, port, entryid)
	-- look('前台确认请求',1)
	local pdata=v3_getplayerdata(sid)
	local spxb = GetSpanListData(SPAN_3v3_ID)
	if spxb == nil or spxb[1]==nil then return end
	local kfnum=pdata.psid[3]
	local sInfo=spxb[1][kfnum]
	SetPlayerSpanUID(sid,SPAN_3v3_ID)
	local span_id = GetTargetSvrID(sInfo[1])
	local span_ip= sInfo[2]
	local span_port=sInfo[3]
	-- look(sid,1)
	-- look(span_id,1)
	-- look(span_ip,1)
	-- look(span_port,1)
	-- look(pass,1)
	-- look(localIP,1)
	-- look(port,1)
	-- look(entryid,1)
	-- 进入加满血量
	PI_PayPlayer(3,1000000,nil,nil,'跨服3v3')
	PI_EnterSpanServerEx(sid, span_id, span_ip, span_port, pass, localIP, port, entryid)
end

--配对失败
function v3reg_fair_kf(info)
	-- look('配对失败',1)
	for i=1,3 do
		if info[i] then 
			local pdata=v3_getplayerdata(info[i])
			if pdata then 
				SendLuaMsg(info[i],{ids=reg_fair},10)
			end
		end
	end
end
--取最大连胜数
function v3_getmaxwin( sid )
	local pdata=v3_getplayerdata(sid)
	if pdata==nil then return end
	return pdata[3]
end
---------------------------------------------
v3reg_start=_v3reg_start
v3reg_enter=_v3reg_enter
v3reg_online=_v3reg_online
reg_inter=_reg_inter
reg_creatteam=_reg_creatteam
reg_intoteam=_reg_intoteam
reg_tplayer=_reg_tplayer
reg_reday=_reg_reday
reg_sign=_reg_sign
reg_getteaminfo=_reg_getteaminfo
v3reg_get_kfref=_v3reg_get_kfref
v3reg_endin=_v3reg_endin
v3reg_end=_v3reg_end
