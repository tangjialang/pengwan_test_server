--[[
file: span_1v1_l.lua
desc: 跨服1v1_本地版
autor: dzq
time:2014-5-4
]]--
local _random=math.random
local db_module = require('Script.cext.dbrpc')
local db_get_span_server = db_module.db_get_span_server
local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond
local msg_1v1_rank	 = msgh_s2c_def[47][1]--每场比赛结束玩家请求前20排名消息回复
local msg_matesucc = msgh_s2c_def[47][2]  --告诉客服端匹配成功
local msg_1v1_all = msgh_s2c_def[47][3] 
local msg_isnot_enroll = msgh_s2c_def[47][4]--是否已经报名
local msg_worship_info = msgh_s2c_def[47][5]--返回给客服端的膜拜信息
local msg_one_info = msgh_s2c_def[47][6]--返回玩家个人跨服信息
local msg_quiz_ret = msgh_s2c_def[47][7] 
--local msg_leaveSpan_1v1 = msgh_s2c_def[47][8] --玩家离开跨服
local msg_lv1_quiz = msgh_s2c_def[47][9] --请求玩家竞猜数据
local msg_lv1_recive = msgh_s2c_def[47][10] --玩家竞猜后返回的数据
local msg_worship = msgh_s2c_def[47][11]--玩家膜拜返回的信息
local SetEvent = SetEvent
local SPAN_1v1_ID= 7 --跨服1v1活动id

local conf_1v1 = 
{
	-- enroll报名
	[1] = 
	{
		tBegin = 0,tEnd = 3*24*3600,	
		--用于判断玩家是否处于报名时间
		enstart = 3600*8,
		endsign_time=2.5*24*3600,---23.59调用时大于2天小于3天时通知前台结束报名
		--[[{
			{3600*8,3600*24},
			{24*3600 + 3600*8,3600*24*2},
			{3600*24*2 + 3600*8,3600*24*3},
		}--]]
	},
	--audition--海选
	[2] = 
	{
		tBegin = 3*24*3600 + 1,tEnd = 4*24*3600,
	}, 
	--preliminary预赛
	[3] = 
	{
		tBegin = 4*24*3600 + 1,tEnd = 5*24*3600,
		--竞猜时间范围
		quizBegin = (4*24 + 8)*3600,quizEnd = (4*24+ 20)*3600 + 30*60,
	},
	--semifinals半决赛	
	[4] = 
	{
		tBegin = 5*24*3600 + 1,tEnd = 6*24*3600,
		--竞猜时间范围
		quizBegin = (5*24 + 8)*3600,quizEnd = (5*24+ 20)*3600 + 30*60,
	}, 
	--finals 决赛
	[5] = 
	{
		tBegin = 6*24*3600 + 1,tEnd = 7*24*3600,
		--竞猜时间范围
		quizBegin = (6*24 + 8)*3600,quizEnd = (6*24+ 20)*3600 + 30*60,
		--决赛期间膜拜范围
		worshipBg = 6*24*3600 + 21*3600 + 22*60,
	},
	--炫耀三天
	[6] = 
	{
		tBegin = 7*24*3600 + 1,tEnd = 10*24*3600,
	}, 
}
local award_1v1_conf = 
{
	--海选奖励
	[2] = {813},
	--预赛奖励
	[3] = 
	{
		--第1，2个参数为等级范围，后面表为物品id  为数量
		{1,10,{813,300}},
		{11,30,{813,200}},
		{31,100,{813,100}},
	},
	--半决赛奖励
	[4] = 
	{	--第1，2个参数为等级范围，后面表为物品id  为数量
		{1,3,{813,600}},
		{4,10,{813,500}},
		{11,32,{813,400}},
	},
	--决赛奖励
	[5] = 
	{
		--第1，2个参数为等级范围，后面表为物品id  为数量
		{1,1,{1495,1}},
		{2,2,{813,900},{1517,1}},
		{3,3,{813,800},{1518,1}},
		{4,10,{813,700}},
	},
	
--以下是客服端用的
	--决赛123名的奖励
	[6] =
	{
		--第一个参数为道具id 第二个参数为数量
		[1] = {{813,1000},{1516,1},{312,1}},
		[2] = {{813,900},{1517,1}},
		[3] = {{813,800},{1518,1}},
	},
	--比赛的时间段
	[7] =
	{
		--每个阶段的时间
		[1] = {"2014/07/12 00:00:00"},
		---每晚开赛的时间段
		[2] = {{"20:40:00","21:25:00"},{"20:40:00","21:20:00"},
                       {"20:40:00","21:20:00"},{"20:40:00","21:20:00"}},
		-- 每晚的比赛开始时间(面板上要显示开始时间)
		[3] = {"2014/05/19 20:40-21:25","2014/05/20 20:40-21:20","2014/05/21 20:40-21:20","2014/05/22 20:40-21:20"},
	},
	--比赛的名字
	[8] = {"海选赛","预赛","半决赛","决赛"},
	--获得的物品id
	[9] = {813},
}
--初始化时间
local initTime = GetTimeToSecond(2014,7,19,0,0,0)
--获得跨服id
local function getspx_id()
	local spxb = GetSpanListData(SPAN_1v1_ID)
	if spxb == nil or spxb[1]==nil then return end
	local value = spxb[1][1]
	if(value) then
		return value[1]
	else
		return nil
	end	
end-- 取v1数据(活动结束清除)
--参数itype表示清除数据 itype  1清除报名数据 2清除竞猜数据  3 清除所有玩家 4清除轮数
local function v1_getlocal_pub(itype)
	local active_lt = GetWorldCustomDB()
	if(active_lt.local1v1 == nil) then
		active_lt.local1v1 = {}
	end
	local pub_data = active_lt.local1v1
	if(itype) then
		--清除相关数据
		if(itype == 1) then
			pub_data.enroll1v1 = {}
		elseif(itype == 2) then
			pub_data.quiz1v1  = {}
		elseif(itype == 3) then
			pub_data.allplayer = {}
		elseif(itype == 4) then
			pub_data.times = 0
		end
	end	
	pub_data.quiz1v1 = pub_data.quiz1v1 or {}  --缓存竞猜数据
	
	pub_data.enroll1v1 = pub_data.enroll1v1 or {}  --缓存报名数据
	
	pub_data.allplayer = pub_data.allplayer or {} --缓存所有玩家信息
	
	pub_data.times = pub_data.times or 0          -- 比赛的轮数
		
	pub_data.showtime = pub_data.showtime or 0      --玩家膜拜定时触发的时间
	
	--pub_data.isfirst = pub_data.isfirst or true  
	 
	return pub_data
end

--玩家跨服1v1永久数据
function v1_getplayerdata(sid)
	local act_data = GetDBActiveData(sid)
	if act_data == nil then return end
	if act_data.v1 == nil then
		act_data.v1 = {}
	end
	return act_data.v1
end
--通过玩家id获得玩家排名
local function getinfo_byid(sid,servid)
	local adata=v1_getlocal_pub()
	if adata==nil or adata.allplayer == nil then return end
	local allplayer =adata.allplayer

	for k,v in pairs(allplayer) do
		if(v.id == sid and v[3] == servid) then
			return k,v
		end
	end
	return 0,0
end
--玩家上线通知玩家
function online_1v1(sid)
	--报名具体时间段
	--[[local enrollarea = in1v1time_area(3)
	 if(area == 1 and enrollarea) then
		RPCEx(sid,'enroll1v1_start')
	 elseif(area == 2 ) then
		 RPCEx(sid,'1v1audition_start')
	 elseif(area == 3) then
		 RPCEx(sid,'1v1preliminary_start')
	 elseif(area == 4) then	
		 RPCEx(sid,'1v1semifinals_start ')
	 elseif(area == 5) then
		 RPCEx(sid,'1v1semifinals_start')
	end--]]
	--时间大体范围
	local area = in1v1time_area(0)
	local spx_value = getspx_id()
	if(spx_value == nil) then
		return
	end	
	if(area == 0) then
		RPCEx(sid,'close_1v1_pic')
	elseif(area == 1) then
		local value = in1v1time_area(2)
		if(value == false) then
			RPCEx(sid,'close_1v1_pic')
		else
			RPCEx(sid,'open_1v1_pic')
		end
	else
		RPCEx(sid,'open_1v1_pic')
	end
end

--判断当前时间处于活动的哪个时间段
--返回值 0不在活动期间 1 报名 2海选 3 预赛 4半决赛 5 决赛  6 炫耀时间
--itype 为0表示当前处于比赛哪个阶段 1表示是否处于竞猜时间范围 2表示是否处于报名时间范围 3表示是否活动全部结束
--4表示活动是否处于可膜拜范围
function in1v1time_area(itype)
	local now = GetServerTime()
	if(itype == 0) then
		for i = 1,#conf_1v1 do
			if(now  > conf_1v1[i].tBegin + initTime and now  <= conf_1v1[i].tEnd + initTime) then
				if i==1 then
					if (now  > conf_1v1[i].endsign_time + initTime and now  <= conf_1v1[i].tEnd + initTime) then
					 	return i,true---报名结束
					end
				end
				return i
			end
		end
		return 0
	--判断是否处于竞猜时间范围	
	elseif(itype == 1) then
		for i = 1,#conf_1v1 do
			if(conf_1v1[i].quizBegin and  conf_1v1[i].quizEnd ) then
				if(now  > conf_1v1[i].quizBegin + initTime and now  <= conf_1v1[i].quizEnd + initTime) then
					return true
				end
			end	
		end
		return false
	--判断是否处于报名时间范围	
	elseif(itype == 2) then
		--local list = conf_1v1[1][1]
		--local length = #list

		--for i = 1,length do
			--if(now > initTime + list[i][1] and now < list[i][2] + initTime) then
				--return true
			--end	
		--end
		--return false
		if(now >= initTime + conf_1v1[1].enstart and now < conf_1v1[2].tBegin + initTime) then
			return true
		else
			return false
		end
		
	--活动是否全部结束	
	elseif(itype == 3) then
		if(now > initTime + conf_1v1[6].tEnd) then
			return true
		else
			return false
		end
	--活动是否处于炫耀可膜拜范围
	elseif(itype == 4) then
		if(now > initTime + conf_1v1[5].worshipBg and now < initTime + conf_1v1[6].tEnd) then
			return true
		else
			return false
		end
	else
		return false
	end
end
--清空积分
--[[local function clear_jf_1v1_l()
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.allplayer == nil) then
		return
	end	
	local allplayer = local_pub.allplayer
	for k,v in pairs(allplayer) do
		if(v) then
			v.jf = 0
		end	
	end
end	--]]
--活动开始延时器
function after_start_1v1(itype)
	 local area = in1v1time_area(0)
	 local spx_value = getspx_id()
	 if spx_value == nil or timearea == 0 then return end
	  
	  if(area == 1) then
		BroadcastRPC('enroll1v1_start')
	  elseif(area == 2 and itype == 2) then
		--请求跨服数据
		--请求跨服数据 所以不用清理数据
		--GI_1v1_local_times()
	 	BroadcastRPC('1v1audition_start')
	  elseif(area == 3 and itype == 3) then
		--GI_1v1_local_times()
	 	BroadcastRPC('1v1preliminary_start')
	  elseif(area == 4 and itype == 4) then	
		--GI_1v1_local_times()
	 	 BroadcastRPC('1v1semifinals_start ')
	  elseif(area == 5 and itype == 5) then
		--GI_1v1_local_times()
	 	BroadcastRPC('1v1semifinals_start')
	  else
	 	return
	  end
end
--活动开始
function start_1v1(itype)
	-- -- 获取跨服1v1活动大区列表(回调函数: CALLBACK_SpanServerGets)
	--清除本服缓存
	db_get_span_server(SPAN_1v1_ID,0)
	SetEvent(5, nil, 'after_start_1v1',itype) --5秒后调用数据
end
--本服取晋级的玩家数据
local function _1v1_getsave_number(itype)
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.allplayer == nil) then
		return
	end	
	local allplayer = local_pub.allplayer
	local value
	if(itype == 2) then
		value = 100
	elseif(itype == 3) then
		value = 32
	elseif(itype == 4) then
		value = 8
	elseif(itype == 5) then
		value = 3
	end
	for k = 1,#allplayer do
		if(k > value) then
			allplayer[k] = nil
		else
			allplayer[k].jf = 0
		end
	end
end
 function end_1v1(itype)
	--判断不处于当前时间或处于报名时间
	local timearea,isend = in1v1time_area(0)
	local timesover = in1v1time_area(3)
	local spx_value = getspx_id()
	local local_pub = v1_getlocal_pub()
	if spx_value == nil or local_pub == nil then return end
	if(timearea == 1) then
		if  isend then 
			BroadcastRPC('enroll1v1_end')
		end
	elseif(timearea == 2 and itype == 2) then
		BroadcastRPC('1v1audition_end')
		--_1v1_getsave_number(itype)
		GI_1v1_local_times()

	elseif(timearea == 3 and itype == 3) then
		BroadcastRPC('1v1preliminary_end')
		--_1v1_getsave_number(itype)
		GI_1v1_local_times()

		--请求竞猜结果
		--ask_lv1_quiz_ret(itype)
		--repley_1v1_quiz()
		SetEvent(15, nil,"repley_1v1_quiz")--15秒后发竞猜奖励

	elseif(timearea == 4 and itype == 4) then	
		
		BroadcastRPC('1v1semifinals_end')
		--_1v1_getsave_number(itype)
		GI_1v1_local_times()

		--repley_1v1_quiz()
		SetEvent(15, nil,"repley_1v1_quiz")--15秒后发竞猜奖励
		--请求竞猜结果
		--ask_lv1_quiz_ret(itype)
	elseif(timearea == 5 and itype == 5) then
		BroadcastRPC('1v1finals_end')
		--_1v1_getsave_number(itype)
		GI_1v1_local_times()

		--repley_1v1_quiz()
		SetEvent(15, nil,"repley_1v1_quiz")--15秒后发竞猜奖励
		--请求竞猜结果	
		--ask_lv1_quiz_ret(itype)

		--每十分钟触发一次膜拜更新定时器
		--GI_show_1v1_times()
		--SetEvent(600, nil,"GI_show_1v1_times",1)
		--记录一下时间 便于定时触发
		local_pub.showtime = GetServerTime()
	elseif(timesover and itype == 6) then
		BroadcastRPC('1v1show_end')	
		--活动完全结束后清空本服数据
		--clear_1v1_local()		
	else
		return
	end
end
--本服做定时器及时清理缓存数据
--function GI_1v1_local_time()
	
--end
--活动竞猜开始
function quiz_lv1_start(itype)
	local curtype = in1v1time_area(1)
	if(curtype == false) then
		return
	end	
	--预赛时间
	if(itype == curtype == 3) then
		--清除竞猜数据
		v1_getlocal_pub(2)
		BroadcastRPC('quiz1v1_preliminary_start ')
	--半决赛时间
	elseif(itype == curtype == 4) then
		--清除竞猜数据
		v1_getlocal_pub(2)
		BroadcastRPC('quiz1v1_semifinals_start')
	--决赛时间
	elseif(itype == curtype == 5) then
		--清除竞猜数据
		v1_getlocal_pub(2)
		BroadcastRPC('quiz1v1_finals_start') 
	end
end
--活动竞猜结束
function quiz_lv1_end(itype)
	local curtype = in1v1time_area(1)
	if(curtype == false) then
		return
	end	
	--预赛时间
	if(itype == curtype == 3) then
		BroadcastRPC('quiz1v1_preliminary_end  ')
	--半决赛时间
	elseif(itype == curtype == 4) then
		BroadcastRPC('quiz1v1_semifinals_end ')
	--决赛时间
	elseif(itype == curtype == 5) then
		BroadcastRPC('quiz1v1_finals_end') 
	end
end	
--玩家是否报名
function enroll_lv1_isnot(sid)
	local pdata=v1_getplayerdata(sid)
	if(pdata == nil) then
		return
	end		
	--通过活动开始时间判断是否清楚报名信息
	if(pdata[7] ~= nil and pdata[7]~= initTime) then
		pdata[10] = false
	end
	local ret
	if(pdata[10]) then
		ret = 1
	else
		ret = 0
	end	

	local spx_value = getspx_id()
	if(spx_value == nil) then
		return
	end	
	--告诉客服端玩家是否报名 itype 0玩家报名的回复  1告诉玩家是否报名 ret表示是否报名 1 为报了 0为没有
	SendLuaMsg(0, {ids=msg_isnot_enroll, ret=ret,itype = 1,spx_value = spx_value}, 9)
end
local function have_1v1_enroll(sid)
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.enroll1v1 == nil) then
		return
	end	
	local endata = local_pub.enroll1v1
	for k,v in pairs(endata) do
		if(v.id == sid) then
			return false
		end
	end
	return true
end
--玩家报名
function reg_1v1_sign(sid )
	--判断战斗力和等级
	local level = CI_GetPlayerData(1)
	local fight =  CI_GetPlayerData(62) --战斗力
	local area = in1v1time_area(2)
	if(level < 55 or fight <50000 or area == false) then
		return
	end
	local pdata=v1_getplayerdata(sid)
	if pdata == nil then return end
	
	--通过活动开始时间判断是否清楚报名信息
	if(pdata[7] ~= nil and pdata[7]~= initTime) then
		pdata[10] = false
	end
	local local_pub = v1_getlocal_pub()
	local endata = local_pub.enroll1v1
	local isenroll = have_1v1_enroll(sid)
	if(isenroll == false) then
		return
	end	
	if(pdata[10])then return end
	local basedata = PI_GetTsBaseData(sid)
	pdata.id = sid
	pdata.jf =pdata.jf or 0
	--玩家报名
	-- pdata[1] = pdata[1] or 0   --所受到的膜拜次数
	-- pdata[2] = fight           --战斗力
	pdata[3] = GetGroupID()	   --服务器serverid 进跨服后找不到自己跨服
	-- pdata[4] = CI_GetPlayerData(3) --玩家名字
	-- pdata[5] = basedata[4]     --衣服
	-- pdata[6] = basedata[5] --武器
	pdata[7] = initTime  --把初始化时间记录到玩家数据下
	--pdata[8] --玩家匹配到的对手id
	--pdata[9] --玩家是否轮空
	--pdata[10] -- 玩家是否报名
	--pdata[11] --玩家剩余膜拜次数
	--[20]--   对方服务器id
	local svrid =getspx_id()
	if(svrid == nil) then
		return
	end	
	local pinfo={}

	pdata[1] = nil
	pdata[2] = nil           --战斗力
	--pdata[3] = nil	   --服务器serverid
	pdata[4] = nil --玩家名字
	pdata[5] = nil    --衣服
	pdata[6] = nil --武器

	pinfo.jf = 0           --初始积分,兼容以前功能,传过去
	pinfo.id = sid           --原服sid
	pinfo[2] = fight           --战斗力
	pinfo[3] = GetGroupID()	   --服务器serverid
	pinfo[4] = CI_GetPlayerData(3) --玩家名字
	pinfo[5] = basedata[4]     --衣服
	pinfo[6] = basedata[5] --武器
	PI_SendToSpanSvr(svrid,{ ids = 10001,info=pinfo})
		
end

--玩家报名回复 
function receive_1v1_sign(sid,ret)
	local pdata=v1_getplayerdata(sid)
	if(pdata==nil) then
		return
	end
	--报名成功
	pdata[10] = true
	--本地缓存报名信息
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.enroll1v1 == nil) then
		return
	end	
	local endata = local_pub.enroll1v1
	local isenroll = have_1v1_enroll(sid)
	if(isenroll) then
		--table.insert(local_pub.enroll1v1,pdata)
		local_pub.enroll1v1[#local_pub.enroll1v1+1]=pdata
	else
		Log('本服报名异常.txt',pdata)
		Log('本服报名异常.txt',"本服报名异常")
	end
	local spx_value = getspx_id()
	if(spx_value == nil) then
		return
	end	
	--告诉客服端玩家是否报名 itype 0玩家报名的回复  1告诉玩家是否报名 ret表示是否报名 1 为报了 0 为没有
	SendLuaMsg(sid, {ids=msg_isnot_enroll, ret=ret,itype = 0,spx_value = spx_value}, 10)
end

--收到跨服服务器回复,res=1配对成功,osid=另一组队长id
--style 为1表示匹配到了玩家 0表示轮空
function v1reg_get_kfref(info,style,jf,times)

	local pdata=v1_getplayerdata(info.id)
	local adata = v1_getlocal_pub()
	if(pdata == nil or adata == nil) then
		return
	end	
	--玩家每匹配成功一次清除本服缓存数据
	if(adata.isfirst == nil) then
		--广播消息 便于前端倒计时
		BroadcastRPC('1v1count_time',times)
		local curtimes = GetServerTime()
		SetEvent(60*3+48, nil,"GI_1v1_local_times")--2分钟18秒取最新排名数据
		adata.isfirst  = true		
	end
	
	pdata[8] = info[8] --对手id
	pdata[20] = info[20] --对手serverid
	pdata.id = info.id
	pdata[9]  = 0
	--轮空的时候做处理便于进入跨服的判断
	if(style == 0) then
		pdata[9] = 1
	end
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.enroll1v1 == nil) then
		return
	end	
	local_pub.times = times
	--这里新增添了一个参数style，需前台处理
	SendLuaMsg(info.id,{ids=msg_matesucc,info=info,style = style,times = times,jf = jf},10)
end

--前台确认请求
function v1reg_endin(sid,pass, localIP, port, entryid)
	local spxb = GetSpanListData(SPAN_1v1_ID)
	--轮空判断
	local pdata=v1_getplayerdata(sid)
	if(pdata == nil) then 
		return 
	end
	if(pdata[9] == 1) then
		pdata[9]  = nil
		return
	end

	if spxb == nil or spxb[1]==nil or spxb[1][1] == nil then
		return
	end
	local sInfo = spxb[1][1]
	SetPlayerSpanUID(sid,SPAN_1v1_ID)
	local span_id = GetTargetSvrID(sInfo[1])
	local span_ip= sInfo[2]
	local span_port=sInfo[3]
	PI_PayPlayer(3,1000000,nil,nil,'跨服1v1')
	PI_EnterSpanServerEx(sid, span_id, span_ip, span_port, pass, localIP, port, entryid)
end
--保存缓存数据
function save_1v1_front20(times,list,mark)
	local local_pub = v1_getlocal_pub()
	local allplayer = local_pub.allplayer
	if mark and mark == 1 then
		local_pub.allplayer = list
	else
		for k,v in pairs(list) do
			allplayer[k]=v
		end
	end
	--local_pub.allplayer = list
	--广播前台，让前台请求消息
	if mark and mark == 3 and #local_pub.allplayer>0 then
	
		BroadcastRPC('1v1askinfo_20')
	end
	
	--local_pub.times = times
end
--请求每场活动结束的前20排名
function askinfo_1v1_front20(sid,itype)
	local area = in1v1time_area(0)
	local local_pub = v1_getlocal_pub()
	--处于报名或者其他时间范围内
	if(local_pub == nil or local_pub.allplayer == nil or area == 0 or area == 1) then
		return
	end	
	local allplayer = local_pub.allplayer
	if(#allplayer ~= 0) then
		local times = local_pub.times
		repley_1v1_front20(sid,times,allplayer)
	else
		local pdata=v1_getplayerdata(sid)
		local group = GetGroupID()
		local serverid=getspx_id()
		if(serverid == nil) then
			return
		end	
		local_pub.allplayer[1]={}
		PI_SendToSpanSvr(serverid,{ ids = 10002,itype = itype,group = group})
	end	
end
--请求活动结束后的排名信息
function askinfo_1v1_all(sid)
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.allplayer == nil) then
		return
	end
	local allplayer = local_pub.allplayer
	if(#allplayer == 0) then
		return
	end
	repley_1v1_all(sid,allplayer)	
	--如果等于不等于0表示缓存了数据
	--[[if(#allplayer ~= 0) then
		repley_1v1_all(sid,allplayer)	
	else
	--表示没有缓存数据
		local pdata=v1_getplayerdata(sid)
		local group = pdata.group
		local serverid=getspx_id()
		PI_SendToSpanSvr(serverid,{ ids = 10003, playid = sid,group = group})
	end	--]]
end
--定时器向跨服请求信息
function GI_1v1_local_times()
	local data = v1_getlocal_pub()
	local times = data.times
	local area = in1v1time_area(0)
	if(area == nil or area == 0) then
		return
	end
	--向跨服请求数据
	local group = GetGroupID()
	local serverid=getspx_id()
	if(serverid == nil) then
		return
	end	
	PI_SendToSpanSvr(serverid,{ ids = 10002,itype = itype,group = group})
	data.isfirst = nil	
end

--返回玩家请求前20名信息的回复
 function repley_1v1_front20(sid,times,list)
	local pdata=v1_getplayerdata(sid)
	local local_pub = v1_getlocal_pub()
	local allplayer = local_pub.allplayer
	--缓存数据到本服
	if(#allplayer == 0) then
		-- local group = GetGroupID()
		-- local serverid=getspx_id()
		-- PI_SendToSpanSvr(serverid,{ ids = 10002,itype = itype,group = group})
		-- return
	end	
	local rank,info = getinfo_byid(sid,GetGroupID())
	local jf
	if(type(info) == type(0)) then
		jf = 0
	else
		jf = info.jf
	end
	local value = {}
	
	for k = 1,20 do
		if(list[k]) then
			--table.insert(value,list[k])
			value[k] = list[k]
		end
	end
	SendLuaMsg(sid,{ids=msg_1v1_rank,rank = rank,times = times,list=value,jf = jf},10)
end
--返回活动结束后跨服所有数据
function repley_1v1_all(sid,list)
	SendLuaMsg(sid,{ids=msg_1v1_all,list=list},10)
end

--玩家请求竞猜数据
function ask_lv1_quiz(sid,itype)
	local area = in1v1time_area(1)
	
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.quiz1v1 == nil or area == false) then
		return 
	end
	local quizdata = local_pub.quiz1v1
	local info = quizdata[sid]

	SendLuaMsg(0,{ids=msg_lv1_quiz,info=info},9)
	
end
--请求玩家竞猜结果
--function ask_lv1_quiz_ret(itype)
	--local sever =getspx_id()
	--local group = GetGroupID()
	--PI_SendToSpanSvr(sever,{ ids = 10007,itype = itype,group = group})
--end
--玩家重复下注
local function findData(id,sid1,sid2,sid3,num,itype,name,svrid1,svrid2,svrid3)
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.quiz1v1==nil) then
		return 
	end
	local quizdata = local_pub.quiz1v1
	
	if(quizdata[id]) then
		if quizdata[id].num + num>1000 then 
			return 
		end
		quizdata[id].sid1 =sid1
		quizdata[id].sid2 =sid2
		quizdata[id].sid3 =sid3
		quizdata[id].svrid1=svrid1--押注3名的服务器id
		quizdata[id].svrid2=svrid2
		quizdata[id].svrid3=svrid3
		quizdata[id].num = quizdata[id].num + num
		return quizdata[id]
	end
	local info ={id = id,itype = itype,sid1 = sid1,sid2 = sid2,sid3 = sid3,num = num,name = name,svrid1 = svrid1,svrid2 = svrid2,svrid3 = svrid3}
	quizdata[id] = info
	return info
end
--收到玩家竞猜数据处理 
function quiz_lv1_quiz(id,itype,sid1,sid2,sid3,num,svrid1,svrid2,svrid3)
	--判断玩家的下注的数目
	if(type(num) ~= type(0) or num == 0 ) then
		return
	end
	local area = in1v1time_area(1)
	--不在时间范围内
	if(area == false) then
		SendLuaMsg(id,{ids=msg_lv1_recive,info=nil,ret = 0},10)
		return
	end	
	--玩家没有选择竞猜玩家
	if(sid1 == nil and sid2 == nil and sid3 == nil) then
		SendLuaMsg(id,{ids=msg_lv1_recive,info=nil,ret = 0},10)
		return
	end	
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.quiz1v1==nil) then
		SendLuaMsg(id,{ids=msg_lv1_recive,info=nil,ret = 0},10)
		return 
	end
	--竞猜数目超过一万
	if(num*10 > 10000) then
		SendLuaMsg(id,{ids=msg_lv1_recive,info=nil,ret = 0},10)
		return  
	end
	--判断金钱是否足够
	if not CheckCost(id, num*10,1,1,'竞猜扣除元宝')  then
		SendLuaMsg(id,{ids=msg_lv1_recive,info=nil,ret = 0},10)
		return  
	end
	local name =  CI_GetPlayerData(3)
	--local quizdata = local_pub.quiz1v1
	local info = findData(id,sid1,sid2,sid3,num,itype,name,svrid1,svrid2,svrid3) 
	if(info == nil) then
		return
	end
	--竞猜扣除金钱
	if not CheckCost(id, num*10,0,1,'竞猜扣除元宝')  then
		SendLuaMsg(id,{ids=msg_lv1_recive,info=nil,ret = 0},10)
		return  
	end
	SendLuaMsg(id,{ids=msg_lv1_recive,info=info,ret = 1},10)			
end
--返回竞猜结果
 function repley_1v1_quiz()	
	local local_pub = v1_getlocal_pub()
	
	--取前三名信息
	local allplayer = local_pub.allplayer
	if( allplayer == nil or local_pub == nil or local_pub.quiz1v1==nil) then
		return 
	end
	local sid1 = 0
	local sid2 = 0
	local sid3 = 0
	
	if type( allplayer[1] ) == type({}) and type(allplayer[1].id) == type(0) then sid1 = allplayer[1].id end
	if type( allplayer[2] ) == type({}) and type(allplayer[2].id) == type(0) then sid2 = allplayer[2].id end
	if type( allplayer[3] ) == type({}) and type(allplayer[3].id) == type(0) then sid3 = allplayer[3].id end
	
	local svrid1=  0
	local svrid2 = 0
	local svrid3 = 0
	
	if type( allplayer[1] ) == type({}) and type(allplayer[1][3]) == type(0) then svrid1 = allplayer[1][3] end
	if type( allplayer[2] ) == type({}) and type(allplayer[2][3]) == type(0) then svrid2 = allplayer[2][3] end
	if type( allplayer[3] ) == type({}) and type(allplayer[3][3]) == type(0) then svrid3 = allplayer[3][3] end
	local quizdata = local_pub.quiz1v1
	--比较函数
	for k,v in pairs(quizdata) do
		if type(k)==type(0) and  type(v)==type({}) then  
			if(sid1 and sid1 ~= 0 and sid1 == v.sid1 and svrid1 == v.svrid1) then
				v.times = (v.times or 0) + 1
			end	
			if(sid2 and sid2 ~= 0 and sid2 == v.sid2 and svrid2 == v.svrid2) then
				v.times = (v.times or 0)+ 1
			end	
			if(sid3 and sid3 ~= 0 and sid3 == v.sid3 and svrid3 == v.svrid3) then
				v.times = (v.times or 0) + 1
			end	
			if(v.times == nil) then
				v.times = 0
			end
			--统计下注数
			local num  = v.num
			local value
			if(v.times == 0) then
				value = rint(num*1*10)
			elseif(v.times  == 1) then
				value = rint(num*1.5*10)
			elseif(v.times  == 2) then
				value = rint(num*2*10)
			elseif(v.times  == 3) then
				value = rint(num*3*10)
			end	
			--发邮件
			local name = v.name
			if(name ~= nil)  then
				local AwardList={[3]={{813,value,1},}}
				SendSystemMail(name,MailConfig.Kf1v1_quiz,1,2,{v.times},AwardList)	
				SendLuaMsg(v.id,{ids=msg_quiz_ret,info=v},10)
				quizdata[k] = nil
			end	
		end		
	end
	--清除竞猜数据
	local_pub.quiz1v1 = {}
end
--获得物品排名奖励
--sid 玩家id
--itype 竞赛类型
--rank 排名次数
local function get_1v1_rankaward(sid,itype,rank,jf)
	if(itype < 2 or itype > 5 or sid == nil or rank == 0) then
		return
	end	
	local AwardList
	if(itype == 2) then
		if(jf > 80) then
			jf = 80
		elseif(jf < 50 ) then
			jf = 50
		end	
		AwardList={[3]={{award_1v1_conf[2][1],jf,1},}}
		return AwardList
	end
	local length = #award_1v1_conf[itype]
	for i = 1,length do
		local down = award_1v1_conf[itype][i][1]
		local up = award_1v1_conf[itype][i][2]
		if(down == nil or up == nil ) then
			return
		end	
		if(rank >= down and rank <= up) then
			local num = 3
			local list = award_1v1_conf[itype][i]
			AwardList={[3]={}}
			while(list[num]) do		
				local id = list[num][1]
				local number = list[num][2]
				local temp = {id,number,1}
				table.insert(AwardList[3],temp)
				num = num +1
			end
			return AwardList
		end
	end
end
--跨服活动结束消息回来,本服发奖励
function gameover_1v1_award(itype,info,rank)
	--发送邮件
	if(info == nil or info[4] == nil) then
		return
	end	
	local name = info[4]
	local AwardList = get_1v1_rankaward(info.id,itype,rank,info.jf)
	if(name ~= nil) then
		local areavalue
		if(itype == 2) then--取前100名
			areavalue = 100
		elseif(itype == 3) then--取前32名
			areavalue = 32
		elseif(itype == 4) then--取前8名	
			areavalue = 8
		elseif(itype == 5) then	--3
			areavalue = 3
		end
		if rank<=areavalue then --晋级,提示不同
			SendSystemMail(name,MailConfig.Kf1v1_over_award_jj,1,2,{rank},AwardList)
		else
			SendSystemMail(name,MailConfig.Kf1v1_over_award,1,2,{rank},AwardList)
		end  
	end	
end
--[[function repley_leaveSpan_1v1(info)
	SendLuaMsg(info.id,{ids=msg_leaveSpan_1v1,info=info},10)
end--]]
--玩家膜拜
function worship_lv1(sid,id,index)
	--worship
	local pdata=v1_getplayerdata(sid)
	local area = in1v1time_area(4)
	if(area == false) then
		SendLuaMsg(sid,{ids=msg_worship,times = pdata[11],ret = ret},10)
		return
	end
	--记录每个玩家的膜拜次数
	if(pdata[11] == nil) then
		pdata[11] = 3
	end	
	local ret 
	if(pdata[11] <= 0) then
		--返回给客服端
		ret = 0
		SendLuaMsg(sid,{ids=msg_worship,times = pdata[11],ret = ret},10)
		return
	else
		--返回给客服端
		pdata[11] = pdata[11] -1
		ret = 1
		--玩家膜拜获得奖励
		local level = CI_GetPlayerData(1)
		GiveGoods(0,1000*level,1,'点击膜拜获得奖励')	
		SendLuaMsg(sid,{ids=msg_worship,times = pdata[11],ret = ret},10)		
	end	
	local serverid = getspx_id()
	if(serverid == nil) then
		return
	end	
	PI_SendToSpanSvr(serverid,{ ids = 10004,desid = id,index = index})

end
--玩家膜拜炫耀
local function show_1v1_times()
	local area = in1v1time_area(4)
	local serverid=getspx_id()
	if(serverid == nil or area == false) then
		return
	end	
	local group = GetGroupID()
	--向跨服请求信息
	PI_SendToSpanSvr(serverid,{ ids = 10005,group = group})
end
--保存膜拜信息缓存
function save_1v1_worship(list)
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.showtime == nil) then
		return
	end	
	--把膜拜的次数赋值给本服缓存
	local allplayer = local_pub.allplayer
	for k = 1,3 do
		if(allplayer[k] and list[k]) then
			allplayer[k][1] = list[k]
		end
	end
	--BroadcastRPC('1v1_worship',list)
	
end
--请求跨服玩家膜拜信息
function ask_worship_lv1(sid)
	local area = in1v1time_area(4)
	local data = v1_getplayerdata(sid)
	local wtimes = data[11]
	if(area == false) then
		return
	end	
	local local_pub = v1_getlocal_pub()
	--处于报名或者其他时间范围内
	if(local_pub == nil or local_pub.showtime == nil) then
		return
	end	
	local list = {}
	for k = 1,3 do
		if(local_pub.allplayer[k]) then
			list[k] = local_pub.allplayer[k]
		end
	end
	SendLuaMsg(sid,{ids=msg_worship_info,wtimes = wtimes,list= list},10)
	--如果现在和时间和记录的时间超过10分钟，向跨服申请数据
	local curtimes = GetServerTime()
	if(curtimes - local_pub.showtime > 60*10) then
		show_1v1_times()
		local_pub.showtime = curtimes
	end
end
--清除报名信息
function clear_1v1_enroll(sid)
	local pdata=v1_getplayerdata(sid)
	if(pdata == nil) then return end
	pdata[10] = false
end
--膜拜次数重置
function refresh_worship_lv1(sid)
	local area = in1v1time_area(4)
	if(area == false) then
		return
	end
	local pdata=v1_getplayerdata(sid)
	if(pdata == nil) then
		return
	end	
	pdata[11] = 3
end
--清空本服数据
function clear_1v1_local()
	local active_lt = GetWorldCustomDB()
	active_lt.local1v1 = {}
end

--查看数据
--[[function test1()
	--local pdata=v1_getplayerdata(sid)
	local local_pub = v1_getlocal_pub()
	local allplayer = local_pub.quiz1v1
	look(allplayer,1)
end--]]


--上线清除以前不需要数据
function v1_clearnotusedata( sid )
	local pdata=v1_getplayerdata(sid)
	if pdata==nil then return end
	pdata.name=nil
	pdata.opposite=nil
	pdata.fight=nil
	pdata.cloth=nil
	pdata.group=nil
	pdata.weapon=nil

	pdata[1] = nil
	pdata[2] = nil           --战斗力
	--pdata[3] = nil	   --服务器serverid
	pdata[4] = nil --玩家名字
	pdata[5] = nil    --衣服
	pdata[6] = nil --武器

end

--清除玩家本服key缓存数据
function v1_clearkeylocal()
	local local_pub = v1_getlocal_pub()
	local allplayer = local_pub.allplayer
	for k,v in pairs(allplayer) do
		if type(k) == type(0) and type(v) == type({}) then
			v.weapon = nil
			v.group = nil
			v.cloth = nil
			v.fight = nil
			v.opposite = nil
			v.name = nil
			v.num = nil
			v.enroll = nil
		end
	end
end

------测试报名2000个玩家-----
function sign_1v1_2000(sid)
	local basedata = PI_GetTsBaseData(sid)
	local svrid =getspx_id()
	if(svrid == nil) then
		return
	end	
	local pinfo={}
	pinfo.jf = 0           --初始积分,兼容以前功能,传过去
	pinfo.id = 12345678           --原服sid
	pinfo[2] = 8235789           --战斗力
	pinfo[3] = GetGroupID()	   --服务器serverid
	pinfo[4] = CI_GetPlayerData(3)..tostring(i) --玩家名字
	pinfo[5] = basedata[4]     --衣服
	pinfo[6] = basedata[5] --武器
	for i=1,2000 do
		pinfo.id=pinfo.id+1
		pinfo[2]=pinfo[2]+1
		pinfo[4] = CI_GetPlayerData(3)..tostring(i)
		PI_SendToSpanSvr(svrid,{ ids = 10001,info=pinfo})
	end
	
end






