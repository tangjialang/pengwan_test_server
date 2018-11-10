--[[
file: span_3v3.lua
desc: 跨服3v3
autor: wk
time:2014-3-3
]]--


---------------------------------------------------------------
--include:
local reg_info = msgh_s2c_def[43][1]
local reg_creat = msgh_s2c_def[43][2]
local reg_in = msgh_s2c_def[43][3]
local reg_zb = msgh_s2c_def[43][4]
local reg_bm = msgh_s2c_def[43][5]
local active_mgr_m = require('Script.active.active_mgr')
local activitymgr = active_mgr_m.activitymgr
local _insert=table.insert
local RegionRPC=RegionRPC
local GetServerTime = GetServerTime
local db_module = require('Script.cext.dbrpc')
local db_get_span_server = db_module.db_get_span_server
local _random=math.random
local _remove=table.remove
---------------------------------------------------------------
--module:

-- module(...)
local active_name = 'span_3v3_vs'
V3_upnum=V3_upnum or 1  --跨服管理房间数
local SPAN_3v3_ID=4 --跨服3v3活动id
local v3_site={ {17,19} ,{15,24} , {13,32}, {29,34} , {27,38 } ,{25,43},}
---------------------------------------------------------------
--data:
--积分段档次
local score_conf={
	[1]=-9000,
	[2]=0,
	[3]=500,
	[4]=1000,
	[5]=1300,
	[6]=1500,
	[7]=1700,
	[8]=1950,
	[9]=2200,
	[10]=2500,
	[11]=3000,
	[12]=3500,
	[13]=100000,
}
--每日,赢,输,连胜,基数
local v3_conf={1000,100,50,1000,5}
---------------------------------------------------------------
--inner:

-- 取v3数据(活动结束清除)
local function _v3_getpub()
	local active_lt = activitymgr:get(active_name)
	if active_lt == nil then			
		return
	end	
	local pub_data = active_lt:get_pub()
	if pub_data then
		pub_data.room = pub_data.room or {}  --房间列表
		--[[
			[sid]=mapgid --队长或对手队长id对应地图gid
			]]
		pub_data.map = pub_data.map or {}  --gid对应V3_upnum
		--[[
			[mapgid]=V3_upnum --地图对应房间编号
			]]
		pub_data.team = pub_data.team or {}  --队伍列表
		--[[
			[V3_upnum]={{1,2,3},{1,2,3}}--两组人
			]]

		--配对列表,只有配对服务器有这个数据
		pub_data.sign = pub_data.sign or {}  
		--[[
			[1]={ -1000-0积分段
				{sid1,sid2,sid3,score},
				{sid1,sid2,sid3,score},
				}
			]]
	end
	return pub_data
end
------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
--[[
			[1]=1,胜利总次数
			[2]=1,失败总次数
			[3]=1,历史最大连胜
			[4]=1,当前连胜
			[5]=1,历史跨服荣誉
			[6]=1,今日跨服荣誉
			[7]=1,今日连胜跨服荣誉
			psid={sid1,sid2}---配对成功,自己组长,对方组长
			team={1,1}--房间编号,位置
			dead=1
			jf=111,
		]]--
--输赢积分处理itype=1输,2赢,_table为sid表
local function _jifen_end( itype,_table )
	if itype==1 then
		for k,v in pairs(_table) do--输
			local pdata=v3_getplayerdata(v)
			if pdata then 
				pdata[2]=(pdata[2] or 0)+1--失败总次数
				pdata[4]=0--当前连胜数
				if (pdata[6] or 0)<v3_conf[1] then --没超过1000
					pdata[6]=(pdata[6] or 0)+v3_conf[3]--今日荣誉
					-- pdata[5]=(pdata[5] or 0)+v3_conf[3]--历史最大值
					local add_end=v3_conf[3]
					if pdata[6]>v3_conf[1] then --超过1000
						add_end=add_end-(pdata[6]-v3_conf[1])
						pdata[6]=v3_conf[1]
					end

					AddPlayerPoints( v , 13 , add_end, nil, '跨服3v3' )
				end
				local Ra=pdata.psid[1]
				local Rb=pdata.psid[2]
				local Ea=1/(1+10^((Rb-Ra)/400))
				pdata.jf=(pdata.jf or 1000) + 32*(0.5-Ea)
				pdata.dead=nil
			end
		end
	elseif itype==2 then 
		for k,v in pairs(_table) do--赢
			local pdata=v3_getplayerdata(v)
			if pdata then 
				pdata[1]=(pdata[1] or 0)+1--赢总次数
				pdata[4]=(pdata[4] or 0)+1--当前连胜数
				if pdata[4]>(pdata[3] or 0) then
					pdata[3]=pdata[4]
				end
				local addry=0 ---连胜加荣誉
				if pdata[4]>=2 then 
					addry=pdata[4]*5
					if addry>v3_conf[4] then 
						addry=v3_conf[4]
					end
				end
				local add_end=0
				--今日荣誉
				if (pdata[6] or 0)<v3_conf[1] then --今日荣誉没超过1000
					pdata[6]=(pdata[6] or 0)+v3_conf[2]--今日荣誉
					-- pdata[5]=(pdata[5] or 0)+v3_conf[2]--历史最大值
					add_end=add_end+v3_conf[2]
					-- AddPlayerPoints( v , 13 , v3_conf[2], nil, '跨服3v3' )
					if pdata[6]>v3_conf[1] then --超过1000
						add_end=add_end-(pdata[6]-v3_conf[1])
						pdata[6]=v3_conf[1]
					end
				end
				--连胜荣誉
				if (pdata[7] or 0)<v3_conf[4] then --连胜荣誉没超过1000
					pdata[7]=(pdata[7] or 0)+addry--今日连胜荣誉
					-- pdata[5]=(pdata[5] or 0)+addry--历史最大值
					add_end=add_end+addry
					-- AddPlayerPoints( v , 13 , addry, nil, '跨服3v3' )
					if pdata[7]>v3_conf[4] then --超过1000
						add_end=add_end-(pdata[7]-v3_conf[4])
						pdata[7]=v3_conf[4]
					end
				end
				AddPlayerPoints( v , 13 , add_end, nil, '跨服3v3' )
				--积分处理
				local Ra=pdata.psid[1]
				local Rb=pdata.psid[2]
				local Ea=1/(1+10^((Rb-Ra)/400))
				pdata.jf=(pdata.jf or 1000) + 32*(1-Ea)
				pdata.dead=nil
			end
		end
	end
end

--玩家死亡
local  function _on_playerdead(self,deader_sid,rid,mapGID,killer_sid)
	-- look('玩家死亡',1)
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then return end
	local pdata=v3_getplayerdata(sid)
	local deadnum=pdata.dead or 10

	local tid=pdata.team[1]
	local tnum=pdata.team[2]
	local adata=_v3_getpub()

	adata.team[tid][tnum].dead=(adata.team[tid][tnum].dead or 0)+1
	if adata.team[tid][tnum].dead>=#adata.team[tid][tnum] then --死完,判断输赢
		if adata.team[tid].mark~=1 then
			_jifen_end( 1,adata.team[tid][tnum] )--输
			
			local other=1
			if tnum==1 then 
				other=2
			end
			_jifen_end( 2,adata.team[tid][other] )--赢
			adata.team[tid].mark=1--结算了奖励
			-- look('发送结算消息-玩家死亡',1)
			RegionRPC(mapGID,'v3_end',adata.team[tid][other])--参数为输的队伍列表
		end
		CI_OnSelectRelive(0,1*5,2,deader_sid)--立即回城复活,3秒5帧
		pdata.dead=deadnum+1
		return
	end

	CI_OnSelectRelive(0,deadnum*5,2,deader_sid)--立即回城复活,3秒5帧
	pdata.dead=deadnum+1
end
-- 玩家复活处理
local function _on_playerlive(self,sid)	
	-- look('_on_playerlive')
	-- local Active_tjbx = activitymgr:get('tjbx')
	-- if Active_tjbx == nil then 
	-- 	look('_on_playerlive Active_tjbx == nil')
	-- 	return 
	-- end
	local x,y,_,mapGID = CI_GetCurPos()
	if not PI_MovePlayer(0,x,y,mapGID,2,sid) then
		look('_on_playerlive PI_MovePlayer erro')
		return
	end
	local pdata=v3_getplayerdata(sid)
	local tid=pdata.team[1]
	local tnum=pdata.team[2]
	local adata=_v3_getpub()
	adata.team[tid][tnum].dead=(adata.team[tid][tnum].dead or 0)-1
	return 1
end
--请求伤害信息
function v3_getdamage( sid )
	-- look('请求伤害信息',1)
	local pdata=v3_getplayerdata(sid)
	local tid=pdata.team[1]
	-- local tnum=pdata.team[2]
	local adata=_v3_getpub()
	local teaminfo=adata.team[tid]
	local DamageA =0
	local DamageB =0
	local site=2
	for k,v in pairs(teaminfo[1]) do
		if type(k)==type(0) and type(v)==type(0) then 
			if sid==v then 
				site=1
			end
			DamageA = DamageA+CI_GetPlayerData(7,2,v)
		end
	end
	-- look(teaminfo[2],1)
	for k,v in pairs(teaminfo[2]) do
		if type(k)==type(0) and type(v)==type(0) then 
			DamageB = DamageB+CI_GetPlayerData(7,2,v)
		end
	end
	RPC('v3_damage',DamageA,DamageB,site)
end
--10秒后判断场上的人,没到做失败处理
function GI_v3_nopeople( tid ,mapGID)
	local adata=_v3_getpub()
	if adata==nil then return end
	local teaminfo=adata.team[tid]
	if teaminfo.mark==1 then return end--打完结算了
	if #teaminfo[1]==0 and #teaminfo[2]>0 then --1队没人,2对赢
		_jifen_end( 2,teaminfo[2] )--赢
		RegionRPC(mapGID,'v3_end',teaminfo[2])--参数为赢的队伍列表
		teaminfo.mark=1
	elseif #teaminfo[2]==0 and #teaminfo[1]>0 then --2队没人,1对赢
		_jifen_end( 2,teaminfo[1] )--赢
		RegionRPC(mapGID,'v3_end',teaminfo[1])--参数为赢的队伍列表
		teaminfo.mark=1
	end

end

-- 时间到处理
local function _on_DRtimeout(self, mapGID, args)
	local adata=_v3_getpub()
	local tid=adata.map[mapGID][1]
	local teaminfo=adata.team[tid]

	local DamageA =0
	local DamageB =0
	if teaminfo.mark~=1 then
		for k,v in pairs(teaminfo[1]) do
			if type(k)==type(0) and type(v)==type(0) then 
				DamageA = DamageA+CI_GetPlayerData(7,2,v)
			end
		end
		for k,v in pairs(teaminfo[2]) do
			if type(k)==type(0) and type(v)==type(0) then 
				DamageB = DamageB+CI_GetPlayerData(7,2,v)
			end
		end
		if DamageA<DamageB then
			_jifen_end( 1,teaminfo[1] )--输
			_jifen_end( 2,teaminfo[2] )--赢
			RegionRPC(mapGID,'v3_end',teaminfo[2])--参数为赢的队伍列表
		else
			_jifen_end( 2,teaminfo[1] )--赢
			_jifen_end( 1,teaminfo[2] )--输
			RegionRPC(mapGID,'v3_end',teaminfo[1])--参数为赢的队伍列表
		end
		teaminfo.mark=1--结算了奖励
		-- look('发送结算消息-时间到处理',1)
		
	end
end
-- 下线处理
local function _on_logout(self,sid)
	local pdata=v3_getplayerdata(sid)
	local _,_,_,mapGID = CI_GetCurPos()
	local tid=pdata.team[1]
	local tnum=pdata.team[2]
	local adata=_v3_getpub()
	local tinfo=adata.team[tid][tnum]
	local onum=1
	if tnum==1 then
		onum=2
	end
	for i=1,3 do
		if tinfo[i]==sid then 
			if #tinfo==1 then --没人了
				if adata.team[tid].mark~=1 then
					-- look('发送结算消息-下线处理',1)
					-- look(adata.team[tid],1)
					-- look(tnum,1)
					-- look(onum,1)
					_jifen_end( 1,adata.team[tid][tnum] )--输
					_jifen_end( 2,adata.team[tid][onum] )
					RegionRPC(mapGID,'v3_end',adata.team[tid][onum])--参数为赢的队伍列表
					
					adata.team[tid].mark=1 
				end
			else
				_remove(tinfo,i)
			end 
			break
		end
	end
end
--活动开启时注册:竞技
local function active_v3vs_regedit(span_3v3_vsdata)

	-- span_3v3_vsdata.on_login=_qsls_on_login
	-- span_3v3_vsdata.on_regioncreate=_qsls_regioncreate
	-- span_3v3_vsdata.on_regionchange=_qsls_regionchange
	-- span_3v3_vsdata.on_active_end=_on_active_end
	span_3v3_vsdata.on_DRtimeout = _on_DRtimeout
	span_3v3_vsdata.on_playerlive = _on_playerlive
	span_3v3_vsdata.on_playerdead=_on_playerdead
	span_3v3_vsdata.on_logout = _on_logout
end


--开启活动:竞技
local function _v3vs_start()
	-- look('开启活动:竞技',1)
	activitymgr:create(active_name)
	local span_3v3_vsdata=activitymgr:get(active_name)
	active_v3vs_regedit(span_3v3_vsdata)

	V3_upnum=1 ---活动开始时房间复位
	local adata=_v3_getpub()--临时
	if adata==nil then return end
	adata.room={}
	adata.team={}
	adata.map={}
	SetEvent(10, nil, "GI_v3_noteam")

	-- 获取跨服3v3活动大区列表(回调函数: CALLBACK_SpanServerGets)
	db_get_span_server(SPAN_3v3_ID,0)
	local spxb = GetSpanListData(SPAN_3v3_ID)
	-- look(spxb[1],1)
end
--循环判断排队列表,到30秒就近匹配,匹配不到通知原服
function GI_v3_noteam( )
	-- look('10秒循环',1)
	local span_3v3_vsdata=activitymgr:get(active_name)
	if span_3v3_vsdata==nil then
		return
	end
	local adata=_v3_getpub()
	if adata==nil then return end
	local signdata=adata.sign
	for k,v in pairs(signdata) do
		if type(k)==type(0) and  type(v)==type({}) then 
			if type(v[1])==type({}) then 
				if GetServerTime()- v[1][6]>30 then --超过30秒
					if  signdata[k+1] and signdata[k+1][1]  then --向上1
						local step=k+1
						local info=v[1]
						local svrid= info[5]
						local osid=info[4]

						local dinfo=signdata[step][1]
						local dsid=dinfo[4] --成功,对方队长sid
						local hsvrid=dinfo[5]
						-- look('配对成功',1)
						--[[
						local spxb = GetSpanListData(SPAN_3v3_ID)
						if spxb == nil or spxb[1]==nil then return end
						local kfnum=_random(1,#spxb[1]) --分配在哪个服务器
						]]--
						--简体合跨服 固定使用第一服
						local kfnum = 1
						-- look(kfnum,1)
						PI_SendToLocalSvr(svrid,{ids = 4001,res=1,info=info,osid=dsid,id=V3_upnum,num=1,kfnum=kfnum})--自己
						PI_SendToLocalSvr(hsvrid,{ids = 4001,res=1,info=dinfo,osid=osid,id=V3_upnum,num=2,kfnum=kfnum})--对方
						V3_upnum=V3_upnum+1
						signdata[step][1]=nil

					elseif signdata[k-1] and signdata[k-1][1]  then --向下1
						local step=k-1
						local info=v[1]
						local svrid= info[5]
						local osid=info[4]

						local dinfo=signdata[step][1]
						local dsid=dinfo[4] --成功,对方队长sid
						local hsvrid=dinfo[5]
						-- look('配对成功',1)
						--[[
						local spxb = GetSpanListData(SPAN_3v3_ID)
						if spxb == nil or spxb[1]==nil then return end
						local kfnum=_random(1,#spxb[1]) --分配在哪个服务器
						]]--
						--简体合跨服 固定使用第一服
						local kfnum = 1
						-- look(kfnum,1)
						PI_SendToLocalSvr(svrid,{ids = 4001,res=1,info=info,osid=dsid,id=V3_upnum,num=1,kfnum=kfnum})--自己
						PI_SendToLocalSvr(hsvrid,{ids = 4001,res=1,info=dinfo,osid=osid,id=V3_upnum,num=2,kfnum=kfnum})--对方
						V3_upnum=V3_upnum+1
						signdata[step][1]=nil
					else --没匹配到
						local hsvrid=v[1][5]
						-- look('超过30秒',1)
						PI_SendToLocalSvr(hsvrid,{ids = 4002,info=v[1]})--匹配失败
						v[1]=nil
					end
				end
			end
		end
	end
	-- look(22111,1)
	return 10
end
--活动结束:竞技
local function _on_active_end(self)
	-- look('活动结束:竞技',1)

end

--进入:竞技

local function _v3vs_enter(sid, mapGID,x,y)
	-- look('进入:竞技:竞技',1)
	local span_3v3_vsdata=activitymgr:get(active_name)
	if span_3v3_vsdata==nil then
		return
	end
	-- local mapGID=span_3v3_vsdata:createDR(1)
	if  not span_3v3_vsdata:is_active(sid) then
		-- if not span_3v3_vsdata:add_player(sid, 1, 0, nil, nil, mapGID) then 
		-- 	return 
		-- end
		if not span_3v3_vsdata:add_player(sid, 1, 0, x, y, mapGID) then 
			return 
		end
	end

end
--退出:竞技

local function _v3vs_exit(sid)
	-- look('退出:竞技',1)
	local span_3v3_vsdata=activitymgr:get(active_name)
	if span_3v3_vsdata==nil then
		return
	end
	span_3v3_vsdata:back_player(sid)
end

---------------------------------------------------------------------
---------------------------------------------------------------------

--开始匹配
local function _v3_mate(svrid, info)
	-- look('开始匹配',1)
	local adata=_v3_getpub()
	if adata==nil then return end
	local signdata=adata.sign
	-- look(11,1)
	local osid=info[4]--队长
	local score=info[4]--积分
	local step=2
	for i=1 ,#score_conf do --遍历各档次	
		if score<score_conf[i] then 
			step=i
			break
		end
	end
	if signdata[step]==nil then 
		signdata[step]={}
	end
	if  signdata[step][1]==nil  then --配对失败
		-- look('配对失败',1)

		info[6]=GetServerTime()
		signdata[step][1]=info
		-- look(222,1)
		return 
	end
	-- look('123123',1) 
	local dinfo=signdata[step][1]
	local dsid=dinfo[4] --成功,对方队长sid
	local hsvrid=dinfo[5]
	-- look('配对成功',1)
	--[[
	local spxb = GetSpanListData(SPAN_3v3_ID)
	if spxb == nil or spxb[1]==nil then return end
	local kfnum=_random(1,#spxb[1]) --分配在哪个服务器
	]]--
	--简体合跨服 固定使用第一服
	local kfnum = 1
	-- look(kfnum,1)
	PI_SendToLocalSvr(svrid,{ids = 4001,res=1,info=info,osid=dsid,id=V3_upnum,num=1,kfnum=kfnum})--自己
	PI_SendToLocalSvr(hsvrid,{ids = 4001,res=1,info=dinfo,osid=osid,id=V3_upnum,num=2,kfnum=kfnum})--对方
	V3_upnum=V3_upnum+1
	
	signdata[step][1]=nil

	-- look('最终完成',1)
	-- look(signdata,1)
end



--玩家登陆跨服
local function _v3_login(sid)
	-- look('玩家登陆跨服',1)
	-- look(sid,1)
	local span_3v3_vsdata=activitymgr:get(active_name)
	if span_3v3_vsdata==nil then
		return
	end
	local pdata=v3_getplayerdata(sid)
	if pdata==nil then return end
	-- local info=pdata.psid
	local teaminfo=pdata.team
	local tid=pdata.team[1]
	local tnum=pdata.team[2]
	-- look(info,1)
	-- local sid1=info[1]
	-- local sid2=info[2]
	local adata=_v3_getpub()
	if adata==nil then return end
	local roomdata=adata.room
	local mapGID
	if roomdata[tid]~=nil then 
		mapGID=roomdata[tid]
	else
		
		mapGID=span_3v3_vsdata:createDR(1)--第一个创建房间
		roomdata[tid]=mapGID
		SetEvent(10, nil, "GI_v3_nopeople",tid,mapGID)--10秒后判断如果没来人直接结束
	end

	local teamdata=adata.team
	if teamdata[tid]==nil then 
		teamdata[tid]={}
	end
	-- if teamdata[tid][tnum]==nil then 
	-- 	teamdata[tid][tnum]={}
	-- end
	if teamdata[tid][1]==nil then --两组一起初始化
		teamdata[tid][1]={}
	end
	if teamdata[tid][2]==nil then 
		teamdata[tid][2]={}
	end

	adata.map[mapGID]={tid,GetServerTime()}---存一个地图对应编号表
	-- look('进入',1)
	-- look(mapGID,1)
	local x,y
	if tnum==1 then 
		x=v3_site[#teamdata[tid][tnum]+1][1]
		y=v3_site[#teamdata[tid][tnum]+1][2]
	else
		x=v3_site[#teamdata[tid][tnum]+4][1]
		y=v3_site[#teamdata[tid][tnum]+4][2]
	end
		
	_v3vs_enter(sid, mapGID,x,y)

	RPC('v3_time',adata.map[mapGID][2])
	-- look(adata.map[mapGID][2],1)
	-- look(1111,1)
	
	if teamdata[tid][tnum][1]==nil then --第一个
		teamdata[tid][tnum][1]=sid
	else
		_insert(teamdata[tid][tnum],sid)
		AskJoinTeam(sid,teamdata[tid][tnum][1])--第2个参数为队长
		if #teamdata[tid][tnum]==3 then --3个人了,判断通帮会
			local fid1=CI_GetPlayerData(23,2,teamdata[tid][tnum][1]) or 0
			local fid2=CI_GetPlayerData(23,2,teamdata[tid][tnum][2]) or 1
			local fid3=CI_GetPlayerData(23,2,teamdata[tid][tnum][3]) or 2
			if fid1==fid2 and fid2==fid3 and fid1>0 then 
				for i=1,3 do
					-- look('同帮会',1)
					-- look(fid1,1)
					-- look(fid2,1)
					-- look(fid3,1)
					CI_AddBuff(367,0,1,false,2,teamdata[tid][tnum][i])
				end
			end
		end	
	end
	
	return true
end

----------------------------------
v3vs_start=_v3vs_start
-- v3vs_enter=_v3vs_enter
v3_mate=_v3_mate
v3_login=_v3_login