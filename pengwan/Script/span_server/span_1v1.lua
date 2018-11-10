local active_mgr_m = require('Script.active.active_mgr')
local activitymgr = active_mgr_m.activitymgr
local _insert=table.insert
local RegionRPC=RegionRPC
local GetServerTime = GetServerTime
local db_module = require('Script.cext.dbrpc')
local db_get_span_server = db_module.db_get_span_server
local _random=math.random
local _remove=table.remove

-------------------------------------------------------------
local SPAN_1v1_ID =  7 --跨服1v1活动id
local active_name = 'span_1v1_vs'
local v1_site={{4,38},{44,37}}
local info1={}--匹配对手信息
local info2={}
v1_mark=v1_mark or 1 --排名标志,一轮只排一次
-------------------------------------------------------------
-- 取v1数据(活动结束清除)
local function _v1_getpub()
	local active_lt = GetWorldCustomDB()
	if(active_lt.kf1v1 == nil) then
		active_lt.kf1v1 = {}
	end
	local pub_data = active_lt.kf1v1
	pub_data.room = pub_data.room or {}  --房间列表用于管理动态场景图
	--配对列表,玩家存储数据
	pub_data.sign = pub_data.sign or {}  --玩家所有的数据都存在里面
	--[[
		{
		pinfo.jf = 0           --初始积分,兼容以前功能,传过去
		pinfo.id = sid           --原服sid
		pinfo[2] = fight           --战斗力
		pinfo[3] = GetGroupID()	   --服务器serverid
		pinfo[4] = CI_GetPlayerData(3) --玩家名字
		pinfo[5] = basedata[4]     --衣服
		pinfo[6] = basedata[5] --武器
		pinfo.mark=true --发奖励标识
		},
	]]
	pub_data.save = pub_data.save or {}  --报名数据备份
	--玩家是否登录跨服标志
	pub_data.login = pub_data.login or {}  --玩家是否登录了跨服活动
	--索引1判断当前处于活动类型 值：2海选 3 预赛 4 半决赛 5决赛
	pub_data.type = pub_data.type or 0

	--表示每种活动进行的次数 索引2表示海选，3表示预赛 4表示半决赛 5决赛
	pub_data.times = pub_data.times or {}
	
	pub_data.quiz = pub_data.quiz or {}--竞猜数据
	
	-- pub_data.isenroll = pub_data.isenroll or {} -- 是否报名
	return pub_data
end
--排序判断
--[[local function compare(a,b)
	if(a.jf  == b.jf) then
		return a.fight > b.fight
	else		
		return  a.jf > b.jf
	end	
end--]]
--玩家排序
local function v1v_player_rank(signdata)
	--开始排序
	--table.bublesort(signdata,compare)
		table.sort(signdata, function (a,b)
			if(a.jf  == b.jf) then
				return a[2] > b[2]
			else		
				return  a.jf > b.jf
			end	
		end)--]]
		--[[for i = 1,#signdata do
			signdata[i].rank = i
		end--]]
end

--通过玩家id获得玩家排名
--[[local function getrank_byid(sid)
	local adata=_v1_getpub()
	if adata==nil then return end
	local signdata=adata.sign
	
	for k,v in pairs(signdata) do
		if(v.id == sid) then
			return k
		end
	end
	return 0
end--]]
--如果玩家已经报名，则不做保存
local function v1_have_enroll(id,svrid)
	local adata=_v1_getpub()
	if adata==nil or adata.sign == nil then return end
	local signinfo = adata.sign  
	-- local enroll = adata.isenroll
	-- local endid=id*1000+rint(svrid/10000)
	-- if(enroll[endid]) then
		-- return false
	-- else
		for k = 1,#signinfo do
			if(signinfo[k] and id == signinfo[k].id and svrid == signinfo[k][3] )  then
				return false
			end	
		end
		return true
	-- end
end
--玩家报名存储数据
function v1_savedata(info)
	local adata=_v1_getpub()
	local area = in1v1time_area(2)
	local svrid=info[3]
	if adata==nil or adata.sign == nil or area == false then 
		PI_SendToLocalSvr(svrid,{ids = 10001,id = info.id,ret = 0})--玩家报名
		return 
	end
	--避免延迟造成的多次报名
	local isenroll = v1_have_enroll(info.id,svrid)
	if(isenroll) then
		local signdata=adata.sign
		signdata[#signdata+1]=info
		adata.save[#signdata+1]=info
		--_insert(signdata,info)
		PI_SendToLocalSvr(svrid,{ids = 10001,id = info.id,ret = 1})--玩家报名
	end		
end

--通过玩家id获得玩家公共数据
local function get_1v1_data_byid(id,serverid)
	local adata=_v1_getpub()
	if(adata== nil  or adata.sign == nil) then
		return
	end	
	local signdata = adata.sign
	for k,v in pairs(signdata) do
		if(v.id == id) and (v[3] == serverid) then
			return v
			
		end	
	end
	return 0
end
--海选输赢积分处理itype=1输,2赢 3轮空 sid 玩家id  
local function _1v1_jifen_end( itype,sid,data)
		local adata=_v1_getpub()
		local pdata = v1_getplayerdata(sid)
		if(adata== nil or adata.sign == nil ) then
			return
		end
		
		local info
		--表示轮空
		if(itype == 3) then
			info =data
		else
			if(pdata == nil) then
				return
			end
			local id = pdata.id
			info = get_1v1_data_byid(id,pdata[3])
		end 
		if(info == nil or info == 0) then
			return
		end	
		local area = in1v1time_area(0)
		if(area == 0 or area == 1) then
			return
		end
		--当前进行的轮数
		local curtimes = adata.times[area] or 1
		--当前比赛的类型
		local timetype = adata.type
		--海选
		if(timetype == 2) then
		--1~5场	
			if(curtimes>=1 and curtimes<=5) then
				if(itype == 1) then
					info.jf = (info.jf or 0) + 2
				elseif(itype == 2) then
					info.jf = (info.jf or 0) + 4
				elseif(itype == 3) then
					info.jf = (info.jf or 0) + 4
				end			
		--6~10场		
			elseif(curtimes>=6 and curtimes<=10) then
				if(itype == 1) then
					info.jf = (info.jf or 0) + 3
				elseif(itype == 2) then
					info.jf = (info.jf or 0) + 5
				elseif(itype == 3) then
					info.jf = (info.jf or 0) + 5			
				end
		--11~15		
			elseif(curtimes>=11 and curtimes <=15) then
				if(itype == 1) then
					info.jf = (info.jf or 0) + 5
				elseif(itype == 2) then
					info.jf = (info.jf or 0) + 7
				elseif(itype == 3) then
					info.jf = (info.jf or 0) + 7	
				end
			end	
		--预赛	
		elseif (timetype == 3) then	
			if(itype == 1) then
				info.jf = (info.jf or 0) + 0
			elseif(itype == 2) then
				info.jf = (info.jf or 0) + 2
			elseif(itype == 3) then
				info.jf = (info.jf or 0) + 1
			end
			--半决赛
		elseif (timetype == 4) then	
			if(itype == 1) then
				info.jf = (info.jf or 0) + 0
			elseif(itype == 2) then
				info.jf = (info.jf or 0) + 2
			elseif(itype == 3) then
				info.jf = (info.jf or 0) + 1
			end
			--决赛
		elseif (timetype == 5) then	
			if(itype == 1) then
				info.jf = (info.jf or 0) + 0
			elseif(itype == 2) then
				info.jf = (info.jf or 0) + 2
			elseif(itype == 3) then
				info.jf = (info.jf or 0) + 1
			end
		else
		end	
		--更新玩家数据
		if(pdata) then
			local basedata = PI_GetTsBaseData(sid)
			info[2]=CI_GetPlayerData(62,2,sid)--战斗力
			--info[4]=CI_GetPlayerData(3,2,sid)--名字
			info[5]=basedata[4]--衣服
			info[6]=basedata[5]--武器
		end	
end
--判断玩家是否输赢
function iswin_1v1(sid,oid)
	local ret = {}
	local DamageA  = (DamageA or 0 )+CI_GetPlayerData(7,2,sid)
	local DamageB  = (DamageB or 0)+CI_GetPlayerData(7,2,oid)
	local pdata1=v1_getplayerdata(sid)
	local pdata2=v1_getplayerdata(oid)
	if(pdata1 == nil or pdata2 == nil) then
		return
	end
	local fight1 = CI_GetPlayerData(62,2,sid)
	local fight2 =  CI_GetPlayerData(62,2,oid)
	if DamageA==DamageB then
		if(fight1 > fight2) then
			ret.win = sid
			ret.fail = oid
		elseif(fight1 < fight2) then
			ret.win = oid
			ret.fail = sid
		elseif(fight1 == fight2) then
			ret.win = oid
			ret.fail = sid
		end
			--判断战斗力
	elseif(DamageA>DamageB) then
		ret.win = sid
		ret.fail = oid
	elseif(DamageA<DamageB)	then	
		ret.win = oid
		ret.fail = sid
	end
	return ret
end
--玩家死亡
local  function _on_playerdead(self,deader_sid,rid,mapGID,killer_sid)
	local adata=_v1_getpub()
	local jf2 = get_1v1_every_jf(2)
	local jf1 = get_1v1_every_jf(1)
	local info = adata.login[mapGID]
	CI_OnSelectRelive(0,3*5,2,deader_sid)--立即回城复活,3秒5帧
	
	if(info == nil or info[3] == nil) then
		leaveSpan_1v1(killer_sid,3,0,deader_sid,3,0)
		return
	end
	--获得积分
	if(info[3] == false) then
		_1v1_jifen_end( 1,deader_sid)
		_1v1_jifen_end( 2,killer_sid)		
		--local jf2 = get_1v1_every_jf(2)
		--local jf1 = get_1v1_every_jf(1)
		leaveSpan_1v1(killer_sid,2,jf2,deader_sid,1,jf1)
		adata.login[mapGID][3] = true
	else
		leaveSpan_1v1(killer_sid,3,0,deader_sid,3,0)
	end
end

-- 时间到处理
function SI_v1_timeout( mapGID )
	local adata=_v1_getpub()
	if(adata.login[mapGID]==nil) then
		return
	end
	local sid=adata.login[mapGID][1]
	local oid=adata.login[mapGID][2]
	local mark = adata.login[mapGID][3]
	if(sid == nil or oid == nil or mark == nil) then
		leaveSpan_1v1(sid,3,0,oid,3,0)
		return
	end	
	if(mark== false) then
		local ret = iswin_1v1(sid,oid)
		if(ret == nil) then
			leaveSpan_1v1(sid,3,0,oid,3,0)
		end
		--获得积分
		local jf2 = get_1v1_every_jf(2)
		local jf1 = get_1v1_every_jf(1)
		
		_1v1_jifen_end( 2,ret.win )
		_1v1_jifen_end( 1,ret.fail )
		--离开跨服
		leaveSpan_1v1(ret.win,2,jf2,ret.fail,1,jf1)
		--leaveSpan_1v1(ret.fail,1,jf1)
		adata.login[mapGID][3] = true
	else
		leaveSpan_1v1(sid,3,0,oid,3,0)
	end	
end
-- 下线处理
local function _on_logout(self,sid)
	local _,_,_,mapGID = CI_GetCurPos(2,sid)
	local adata=_v1_getpub()
	if(adata.login[mapGID]==nil) then
		return
	end
	local info = adata.login[mapGID]
	--如果时间到了，玩家还处于副本中
	local mark = adata.login[mapGID][3]
	local id = adata.login[mapGID][1] 
	local oid = adata.login[mapGID][2] 
	--是否获取了奖励 如果获取了奖励将不做处理
	if(mark == false) then
		--获取奖励
		--玩家逃出副本
		if(id ~= nil and oid ~= nil) then
			local jf2 = get_1v1_every_jf(2)
			local jf1 = get_1v1_every_jf(1)
			local winid
			local failid
			if(sid == id) then
				winid = oid
				failid = id
			elseif(sid == oid) then
				winid = id
				failid = oid
			else
			end
			_1v1_jifen_end( 2,winid )
			_1v1_jifen_end( 1,failid )
			leaveSpan_1v1(winid,2,jf2,failid,1,jf1)
			--leaveSpan_1v1(failid,1,jf1)
			info[3] = true
			--玩家下线把玩家sid置空
			if(info[1]~= nil and sid == info[1]) then
				info[1] = nil
			elseif(info[2]~= nil and sid == info[2]) then
				info[2] = nil
			end
		else
			leaveSpan_1v1(id,3,0,oid,3,0)
		end	
	else
		--leaveSpan_1v1(id,2,0,oid,1,0)
	end
end
--判断对手是否在活动中，如果没有，则退出场景
function no_player_1v1(sid,mapGID)
	local adata=_v1_getpub()
	local info = adata.login[mapGID]
	--异常情况
	if(info == nil) then
		return
	end	
	--异常情况
	if(info[1] == nil and info[2] == nil ) then
		return
	end	
	--玩家都在
	if(info[1] ~= nil and info[2] ~= nil ) then
		return
	end	
	--第一个玩家在
	if(info[1] ~= nil and info[3] == false) then
		_1v1_jifen_end(2,info[1])		
		--获取胜利积分
		local jf2 = get_1v1_every_jf(2)
		leaveSpan_1v1(info[1],2,jf2,nil,nil,nil)	
		info[3] = true
	end
	--第二个玩家在
	if(info[2] ~= nil and info[3] == false) then
		_1v1_jifen_end(2,info[2])		
		--获取胜利积分
		local jf2 = get_1v1_every_jf(2)
		leaveSpan_1v1(info[2],2,jf2,nil,nil,nil)	
		info[3] = true
	end
	return
end

--活动开启时注册:竞技
local function active_v1vs_regedit(span_1v1_vsdata)
	--span_1v1_vsdata.on_DRtimeout = _on_DRtimeout
	span_1v1_vsdata.on_playerdead=_on_playerdead
	span_1v1_vsdata.on_logout = _on_logout
end
--进入:竞技
local function v1vs_enter(sid, mapGID,x,y)
	local span_1v1_vsdata=activitymgr:get(active_name)
	if span_1v1_vsdata==nil then
		return
	end
	if  not span_1v1_vsdata:is_active(sid) then
		if not span_1v1_vsdata:add_player(sid, 1, 0, x, y, mapGID) then 
			return 
		end
	end
end
--玩家都进入场景5秒后显示头像数据 如果不延迟将会有人不会显示
function GI_show_1v1_ico(player1,player2,mapGID)
		local data1=v1_getplayerdata(player1)
		local data2=v1_getplayerdata(player2)
		if(data1 == nil or data2 == nil) then
			return
		end	
		local id1 = data1.id
		local TBData1 = PI_GetTsBaseData(player1)
		local name1 = CI_GetPlayerData(3,2,player1)
		local group1 = data1[3]
		local sex1 = CI_GetPlayerData(11,2,player1)
		
		local name2 = CI_GetPlayerData(3,2,player2)
		local group2 = data2[3]
		local id2 = data2.id
		local TBData2 = PI_GetTsBaseData(player2)
		local sex2 = CI_GetPlayerData(11,2,player2)
		--前六位表示第一位玩家的数据 7-12位表示第二位玩家数据
		local info = {player1,TBData1[2],TBData1[8],sex1,name1,group1,player2,TBData2[2],TBData2[8],sex2,name2,group2}
		RegionRPC(mapGID,'v1_mapbase',info)--参数为赢的队伍列表
end
--玩家登陆跨服
function v1_login(sid)
	local span_1v1_vsdata=activitymgr:get(active_name)
	local adata=_v1_getpub()
	local pdata=v1_getplayerdata(sid)
	if (span_1v1_vsdata==nil or pdata == nil)then
		return
	end

	--存储玩家的跨服id
	local oid = pdata[8]
	local id = pdata.id
	
	--设置玩家当前坐标
	local curpos
	local mapGID
	local roomdata=adata.room
	if roomdata[id]~=nil and roomdata[id][pdata[3]] then 	
		mapGID=roomdata[id][pdata[3]]
		curpos = 1
		--主要是判断玩家15秒之后进来的情况
		local info = adata.login[mapGID]
		if(info and info[3]) then	
			leaveSpan_1v1(sid,3,0,nil,nil,nil)
			return
		end		
	else	
		mapGID=span_1v1_vsdata:createDR(1)--第一个创建房间
		if(mapGID == nil) then
			leaveSpan_1v1(sid,3,0,nil,nil,nil)
			return
		end
		--以gid关联数据
		roomdata[id] =roomdata[id] or {}
		roomdata[oid]=roomdata[oid] or {}
		roomdata[id][pdata[3]]=mapGID
		roomdata[oid][pdata[20]]=mapGID			
		curpos = 2
		SetEvent(40, nil, "no_player_1v1",sid,mapGID)
		SetEvent(120, nil, "SI_v1_timeout",mapGID)
		--第一个玩家进来		
	end	
	local svrid = pdata[3]
	adata.login[mapGID]=adata.login[mapGID] or {}
	--索引1 2表示玩家id 3表示是否处理积分 4 表示第一个玩家进入时间 5表示第二个玩家进入时间
	if(adata.login[mapGID][1]) then
		adata.login[mapGID][2] = sid 
		--记录当前时间 便于玩家倒计时
		adata.login[mapGID][5] = GetServerTime()
		
		local seconds = {adata.login[mapGID][4],adata.login[mapGID][5]}
		RPCEx(sid,'kf_1v1_times',seconds)
	else
		adata.login[mapGID][4] = GetServerTime()
		adata.login[mapGID][1] = sid 
		
		local seconds = {adata.login[mapGID][4],nil}
		RPCEx(sid,'kf_1v1_times',seconds)
	end
	--表示未获取到奖励
	adata.login[mapGID][3] = false
	--玩家都登陆时判
	local player1 = adata.login[mapGID][1]
	local player2 = adata.login[mapGID][2]
	local x =v1_site[curpos][1]
	local y=v1_site[curpos][2]
	v1vs_enter(sid, mapGID,x,y)
	if(player1 and player2) then
		SetEvent(4, nil, "GI_show_1v1_ico",player1,player2,mapGID)	
	end
	return true
end
--活动开始前清空积分
local function clear_jf_1v1()
	local adata=_v1_getpub()
	if(adata==nil or adata.sign == nil ) then
		return
	end
	local signdata=adata.sign
	for k,v in pairs(signdata) do
		v.jf = 0
		v[21] = nil--清领奖标识
	end
end
--开启活动:
function v1vs_start(itype)	
	--不处于活动时间或处于报名时间
	local area = in1v1time_area(0)
	local adata=_v1_getpub()
	if(area == 0 or area == 1 or adata==nil ) then
		return
	end
	activitymgr:create(active_name)
	local span_1v1_vsdata=activitymgr:get(active_name)
	active_v1vs_regedit(span_1v1_vsdata)


	--初始化次数
	local signdata=adata.sign
	--活动轮数归1
	adata.times[itype] = 0
	--报名		
	if(itype == 2 and area == 2) then--海选
		--清空积分
		clear_jf_1v1()
		adata.type = 2
		GI_v1_noteam(2,0)
		--SetEvent(180, nil, "GI_v1_noteam",2,1)
		SetEvent(240, nil, "GI_v1_noteam",2,1)--海选修改为4分钟
	elseif (itype == 3 and area == 3) then --预赛
		clear_jf_1v1()
		adata.type  = 3
		GI_v1_noteam(3,0)
		SetEvent(240, nil, "GI_v1_noteam",3,1)
	elseif (itype == 4 and  area == 4) then --半决赛
		clear_jf_1v1()
		adata.type  = 4
		GI_v1_noteam(4,0)
		SetEvent(240, nil, "GI_v1_noteam",4,1)
	elseif (itype == 5 and  area == 5) then -- 决赛
		clear_jf_1v1()
		adata.type  = 5
		GI_v1_noteam(5,0)
		SetEvent(420, nil, "GI_v1_noteam",5,1)		
	end
	-- 获取跨服1v1活动大区列表(回调函数: CALLBACK_SpanServerGets)
	db_get_span_server(SPAN_1v1_ID,0)
	local spxb = GetSpanListData(SPAN_1v1_ID)
end
--活动结束 返回给本服需要奖励的玩家
--itype 比赛类型 list玩家列表
local function award_1v1_over(itype,list)
	for i = 1,#list do
		if list[i][21]==nil then--未发奖标识,防止多次发放
			local svrid = list[i][3]
			PI_SendToLocalSvr(svrid,{ids = 10008,itype = itype,info=list[i],rank = i})--自己
			list[i][21]=true
		end
	end
end
--活动结束
function v1vs_end(itype)
	local area = in1v1time_area(0)
	if( area== 0 or area~= itype) then
		return
	end	
	local adata=_v1_getpub()
	if adata==nil or adata.sign ==  nil  then return end
	local signdata=adata.sign
	--排序
	v1v_player_rank(signdata)
	--报名结束
	if(area == 1) then
		return
	else
		local areavalue
		--向本服发送奖励
		if itype>=2 and itype <=5 then 
			award_1v1_over(itype,signdata)
		end
		-- 取前一百名
		if(itype == 2) then
			areavalue = 100
		--取前32名
		elseif(itype == 3) then
			areavalue = 32
		--取前8名
		elseif(itype == 4) then
			areavalue = 8
		--取前3名	
		elseif(itype == 5) then
			areavalue = 3
		--活动全部结束
		elseif(itype == 6)	then
			local timesover = in1v1time_area(3)
			if(timesover) then
				--clear_1v1_kf()
			end
			return
		end
		--保留数据
		for i = 1,#signdata do
			if(i > areavalue) then
				signdata[i] = nil
			end
		end
	end	
end

--匹配逻辑,海选90秒内匹配,每秒20个,其他的一次性匹配
v1_mate_time=v1_mate_time or 0--匹配位置,海选时每次20个
function v1_mate(itype,thistype,times)
	local adata=_v1_getpub()
	local signdata=adata.sign
	local mimi
	local max
	if itype==2 then
		mimi=v1_mate_time*20+1
		max=v1_mate_time*20+20
		if v1_mate_time>= 90 then--90秒匹配所有剩下的
			max=#signdata
		end 
		v1_mate_time=v1_mate_time+1
	else
		mimi=1
		max=#signdata
	end
	local step,info,osid,svrid,dinfo,dsid,hsvrid

	for k=mimi,max do
		v=signdata[k]

		if type(k)==type(0) and  type(v)==type({}) then  		
			--如果排名区分奇数和偶数
			local res
			if thistype==1 then 
				if(k%2 == 1) then
					res=true
					st_num=1
				end
			else
				if(k%4 == 1) or (k%4 == 2)  then
					res=true
					st_num=2
				end
			end

			if res then
				step = k+st_num
				info=signdata[k] --第一个玩家信息
				osid=info.id --玩家id
				svrid= info[3] --服务器id

				if(signdata[step] == nil) then--轮空处理
					_1v1_jifen_end(3,nil,info)
					local jf = get_1v1_every_jf(3)
					PI_SendToLocalSvr(svrid,{ids = 10002,info=info,style = 0,jf = jf,times = times})
					return --海选匹配完成,终止循环

				else	--匹配到的玩家信息	
					dinfo=signdata[step]
					dsid=dinfo.id 
					hsvrid=dinfo[3]					

					info1.id=osid
					info1[8] = dsid
					info1[20] = hsvrid

					info2.id=dsid
					info2[8] = osid
					info2[20] = svrid

					PI_SendToLocalSvr(svrid,{ids = 10002,info=info1,style = 1,jf = jf,times = times})--自己
					PI_SendToLocalSvr(hsvrid,{ids = 10002,info=info2,style = 1,jf = jf,times = times})--对方
				
					if step>=#signdata and #signdata%2==0 then --匹配完成
					
						return 
					end
				end	
			end
		end

	end
	if itype==2 and  v1_mate_time<=90 then--海选1秒匹配一次
		return 1
	end
end

--每隔一段时间进行重新排名
--2代表海选 3 预赛 4 半决赛 5 决赛 0退出计时器 
--style表示是否轮空 0 为轮空 1不为轮空
--round 表示是否循环 0表示不循环 1表示循环
function GI_v1_noteam(itype,round)	

	local adata=_v1_getpub()
	--0表示终止计时器
	if adata==nil or itype == 0 then return end
	local signdata=adata.sign
	--排序

	--v1v_player_rank(signdata)
	v1_mark=2
	
	--记录战斗的次数 如果超过场数，将不会再循环
	adata.times[itype] = (adata.times[itype] or 0) + 1
	local times = adata.times[itype] 
	--排名
	local thistype=math.random(1,2)--匹配规则弄两套,一套1-2,3-4,一套1-3,2-4

	-- local step,info,osid,svrid,dinfo,dsid,hsvrid

	-- for k,v in pairs(signdata) do
	-- 	if type(k)==type(0) and  type(v)==type({}) then  		
	-- 		--如果排名区分奇数和偶数
	-- 		local res
	-- 		if thistype==1 then 
	-- 			if(k%2 == 1) then
	-- 				res=true
	-- 				st_num=1
	-- 			end
	-- 		else
	-- 			if(k%4 == 1) or (k%4 == 2)  then
	-- 				res=true
	-- 				st_num=2
	-- 			end
	-- 		end

	-- 		if res then
	-- 			step = k+st_num
	-- 			info=signdata[k] --第一个玩家信息
	-- 			osid=info.id --玩家id
	-- 			svrid= info[3] --服务器id

	-- 			if(signdata[step] == nil) then--轮空处理
	-- 				_1v1_jifen_end(3,nil,info)
	-- 				local jf = get_1v1_every_jf(3)
	-- 				PI_SendToLocalSvr(svrid,{ids = 10002,info=info,style = 0,jf = jf,times = times})
	-- 			else	--匹配到的玩家信息	
	-- 				dinfo=signdata[step]
	-- 				dsid=dinfo.id 
	-- 				hsvrid=dinfo[3]					

	-- 				info1.id=osid
	-- 				info1[8] = dsid
	-- 				info1[20] = hsvrid

	-- 				info2.id=dsid
	-- 				info2[8] = osid
	-- 				info2[20] = svrid

	-- 				PI_SendToLocalSvr(svrid,{ids = 10002,info=info1,style = 1,jf = jf,times = times})--自己
	-- 				PI_SendToLocalSvr(hsvrid,{ids = 10002,info=info2,style = 1,jf = jf,times = times})--对方
	-- 			end	
	-- 		end
	-- 	end
	-- end
	--v1_mate(itype,signdata,thistype,times)--执行一次

	v1_mate_time=0 --海选置0,确保下次安全

	SetEvent(1, nil, "v1_mate",itype,thistype,times)--1秒循环

	adata.room = {}
	adata.login = {}
	

	--不循环
	if(round == 0) then
		return
	end	
	if(itype == 2 and  round == 1) then		
		if(times >= 15) then--海选15轮
			return
		else
			--return 180--3分钟间隔
			return 240--4分钟间隔
		end	
	elseif(itype == 3 and round == 1) then	
		if(times >= 10 ) then--预选赛10轮
			return
		else	
			return 240 --4分钟间隔
		end	
	elseif(itype == 4 and round == 1) then		
		if(times >= 10) then--半决赛10轮
			return
		else	
			return 240--4分钟间隔
		end	
	elseif(itype == 5 and round == 1) then		
		if(times >= 6) then--决赛6轮
			return
		else	
			return 420--7分钟间隔
		end	
	end
	
end

function v1_setevent(svrid,times,num1,num2,mark)
	local pdata = _v1_getpub()
	if(pdata==nil or pdata.sign == nil) then
		return
	end
	local temptb={}
	for i=num1,num2 do
		temptb[i]=pdata.sign[i]
	end
	PI_SendToLocalSvr(svrid,{ids = 10003,times =times,list = temptb,mark=mark})
end


--跨服1v1每场活动结束后前20名排名信息
function askinfo_1v1_rank_kf(itype,group)
	local pdata = _v1_getpub()
	if(pdata==nil or pdata.sign == nil) then
		return
	end
	--排序
	if v1_mark==2 then 
		v1v_player_rank(pdata.sign)
		v1_mark=1
	end
	--获得玩家自己排名
	--local rank = getrank_byid(sid)
	local svrid = group
	local times = pdata.times[itype]
	--如果rank为0 则表示次玩家是非报名玩家
	
	local temptb={}
	-- for i=1,20 do
	-- 	temptb[i]=pdata.sign[i]
	-- end
	-- PI_SendToLocalSvr(svrid,{ids = 10003,times =times,list = temptb,mark=1})
	
	
	-- SetEvent(1, nil, "v1_setevent",svrid,times,21,40,2)
	-- SetEvent(2, nil, "v1_setevent",svrid,times,41,60,2)
	-- SetEvent(3, nil, "v1_setevent",svrid,times,61,80,2)
	-- SetEvent(4, nil, "v1_setevent",svrid,times,81,100,3)
	
	for i=1,50 do
		temptb[i]=pdata.sign[i]
	end
	PI_SendToLocalSvr(svrid,{ids = 10003,times =times,list = temptb,mark=1})
	
	
	SetEvent(1, nil, "v1_setevent",svrid,times,51,100,3)
	-- SetEvent(2, nil, "v1_setevent",svrid,times,41,60,2)
	-- SetEvent(3, nil, "v1_setevent",svrid,times,61,80,2)
	-- SetEvent(4, nil, "v1_setevent",svrid,times,81,100,3)
	
end

--玩家跨服膜拜
 function kf1v1_worship(desid,index)
	local pdata = _v1_getpub()
	if(pdata==nil) then
		return
	end
	--找到玩家
	local signinfo = pdata.sign
	if(signinfo[index] == nil) then return end
	if(signinfo[index].id~=desid) then
		return
	end
	signinfo[index][1] = (signinfo[index][1] or 0) + 1

end
--玩家跨服膜拜的信息
function ask_1v1_worship_kf(group)
	local pdata = _v1_getpub()
	if(pdata==nil or pdata.sign == nil) then
		return
	end
	local signdata=pdata.sign
	local list = {}
	for i = 1,3 do
		if(signdata[i] and signdata[i][1]) then
			list[i]=signdata[i][1]
		end
	end
	local svrid = group
	PI_SendToLocalSvr(svrid,{ids = 10005,list = list})
end
--活动结束后返回给玩家竞猜数据
 --[[function kf_quiz_lv1_save(sid,itype,sid1,sid2,sid3,num)
	local pdata = _v1_getpub()
	if(pdata==nil or pdata.sign == nil or pdata.show == nil) then
		return
	end
	local righttimes = 0 --猜对的次数
	local info = {playid,itype, sid1,ssid2,sid3,num,righttimes}
	if(pdata.quiz[itype] == nil) then
		pdata.quiz[itype] = {}
	end
	table.insert(pdata.quiz[itype],info)
end--]]

--竞猜结果 list为某种比赛类型存的数据
--[[function kf_quiz_lv1_ret(itype,group)
	local pdata = _v1_getpub()
	if(pdata==nil or pdata.sign == nil ) then
		return
	end
	local signinfo = pdata.sign
	local list = {}
	for i = 1,3 do
		if(signinfo[i]) then
			table.insert(list,signinfo[i].id)
		end
	end
	--向本服发信息
	PI_SendToLocalSvr(group,{ids = 10006,itype = itype,list = list})	
end--]]

--itype 2代表赢 1 代表输
function leaveSpan_1v1(sid,itype1,jf1,oid,itype2,jf2)
	--向本服发信息
	--local _,_,_,mapGID = CI_GetCurPos(2,sid)
	if sid then
		RPCEx(sid,'v1_leavespan',sid,itype1,jf1,oid,itype2,jf2)
	end
	if oid then
		RPCEx(oid,'v1_leavespan',sid,itype1,jf1,oid,itype2,jf2)
	end	
	--RegionRPC(mapGID,'v1_leavespan',sid,itype1,jf1,oid,itype2,jf2)--参数为赢的队伍列表--]]
end
--通过比赛类型btype  轮数times 结果ret 获得积分显示

function get_1v1_every_jf(ret)
	local adata=_v1_getpub()
	local btype = in1v1time_area(0)
	if(adata == nil or btype == 0 or btype == 1) then
		return
	end	
	local times = adata.times[btype] or 1
	if(btype == 2) then
		if(times >= 0 and times <= 5) then
			if(ret == 1) then
				return 2
			elseif(ret == 2) then
				return 4
			elseif(ret == 3) then
				return 4
			end				
		elseif(times>=6 and times<=10) then
			if(ret == 1) then
				return 3
			elseif(ret == 2) then
				return 5
			elseif(ret == 3) then
				return 5
			end	
		elseif(times>=11 and times <= 15) then
			if(ret == 1) then
				return 5
			elseif(ret == 2) then
				return 7
			elseif(ret == 3) then
				return 7
			end	
		end
	elseif(btype == 3) then
		if(times>=1 and times<=10) then
			if(ret == 1) then
				return 0
			elseif(ret == 2) then
				return 2
			elseif(ret == 3) then
				return 1
			end	
		end
	elseif(btype == 4) then
		if(times>=1 and times<=10) then
			if(ret == 1) then
				return 0
			elseif(ret == 2) then
				return 2
			elseif(ret == 3) then
				return 1
			end	
		end
	elseif(btype == 5) then
		if(times>=1 and times<=6) then
			if(ret == 1) then
				return 0
			elseif(ret == 2) then
				return 2
			elseif(ret == 3) then
				return 1
			end	
		end
	end
end
--清空跨服数据
function clear_1v1_kf()
	local active_lt = GetWorldCustomDB()
	active_lt.kf1v1 = {}
end
--查看数据
--[[function test2(itype)
	local adata=_v1_getpub()
	if adata==nil then return end
	local times = adata.times[2]
	local list  = adata.sign
	look(adata,1)
	look(times,1)
	--look(adata.times,1)
end --]]
function get100_1v1()
	local adata=_v1_getpub()
	if adata==nil or adata.sign ==  nil  then return end
	local info=adata.sign
	local temp = {}
	for i = 1,#info do
		if type(info[i]) == type({}) then
			temp[i] = info[i]
		end
	end
	adata.sign = temp
	
	--开始取晋级数据
	local signdata = adata.sign
	for i = 1,#signdata do
		if(i > 100) then
			signdata[i] = nil
		end
	end
end




