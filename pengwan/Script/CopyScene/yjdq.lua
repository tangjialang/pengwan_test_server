local uv_FBConfig = FBConfig
local uv_TimesTypeTb = TimesTypeTb

local fb_fun_m   = require("Script.fabao.fabao_fun")
local fb_activated     = fb_fun_m.fb_activated

local fb_conf_m   = require("Script.fabao.fabao_conf")
local xing_conf   = fb_conf_m.Xing_conf

local msg_star 		=  msgh_s2c_def[53][6]	--一骑当千同步副本星数
local msg_awards 	=  msgh_s2c_def[53][7]	--一骑当千领取盒子
local msg_saodang 	=  msgh_s2c_def[53][8]	--一骑当千扫荡
local msg_buytimes 	=  msgh_s2c_def[53][9]	--一骑当千购买次数
local msg_buysaodang =  msgh_s2c_def[53][10]	--一骑当千购买清除扫荡cd
		
local config = 
{
	[23001] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 829,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},
	},
	[23002] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 830,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23003] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 831,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23004] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 832,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23005] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 833,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23006] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 834,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23007] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 835,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23008] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 836,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23009] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 837,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23010] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 838,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23011] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 839,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23012] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 840,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23013] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 841,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23014] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 842,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23015] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 843,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23016] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 844,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23017] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 845,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23018] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 846,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23019] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 847,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23020] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 848,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23021] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 849,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23022] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 850,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23023] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 851,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23024] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 852,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23025] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 853,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23026] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 854,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23027] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 855,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23028] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 856,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23029] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 857,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
	[23030] = {
		{start_pos = { 8, 8},pitch = 23,monster = { monsterId = 858,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},	
	},
}

--[[
config = 
{
	[23001] = {
		{start_pos = { 8, 8},total = 1,pitch = 23,monster = { monsterId = 829,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }},
	},
}
]]--

local awards = 
{
		[5]={{1520,50,1}},
		[10]={{1520,100,1}},
		[15]={{1520,150,1}},
		[20]={{1520,200,1}},
		[25]={{1520,250,1}},
		[30]={{1520,300,1}},
		[35]={{1520,350,1}},
		[40]={{1520,400,1}},
		[45]={{1520,450,1}},
		[50]={{1520,500,1}},
		[55]={{1520,550,1}},
		[60]={{1520,600,1}},
		[65]={{1520,650,1}},
		[70]={{1520,700,1}},
		[75]={{1520,750,1}},
		[80]={{1520,800,1}},
		[85]={{1520,850,1}},
		[90]={{1520,900,1}},
}

local dist = 2
local fbType = 23

function yjdq_on_start(fbID,copyScene)
	look('yjdq_on_start',2)
	local DynmicSceneMap = copyScene.DynamicSceneGIDList[1]
	local conf = config[fbID]
		
	for k,v in pairs(conf) do
		local pitch = v.pitch
		local monster = v.monster
		local x,y = v.start_pos[1],v.start_pos[2]
		for i=1,yjdq_monster_count do
			monster.copySceneGID = copyScene.CopySceneGID
			monster.regionId = DynmicSceneMap.dynamicMapGID	
			monster.x = x + ((i-1) % pitch) * dist
			monster.y = y + rint((i-1) / pitch) * dist
	
			monster.controlID = 1000+i
			CreateObjectIndirect(monster)
		end
	end
end

for i=1,30 do
	csBeginProcTb[23000+i] = yjdq_on_start
end

function yjdq_get_player_data(sid)
	local pData = CS_GetPlayerData(sid)
	pData.yjdq = pData.yjdq or {}
	pData.yjdq[0] = pData.yjdq[0] or {}
	return pData.yjdq
end

function yjdq_get_save_data(sid) 
	--[2] 已领星数
	--[3] 扫荡时间
	--[4] 总星数
	return yjdq_get_player_data(sid)[0] 
end

function yjdq_on_complete(sid,copyScene)
	look('yjdq_on_complete',2)
	local pdata = yjdq_get_player_data(sid)
	local fbID = copyScene.fbID
	local index = fbID % 1000
	local sdata = pdata[0]
	local pCSData = CS_GetPlayerData(sid)
	local star = pCSData.Awd.Award.star
	if not pdata[index] or star > pdata[index] then
		pdata[index] = star
		local total = 0
		for k,v in pairs(pdata) do
			if type(v) == type(0) then
				total = total + v
			end
		end
		local level
		for i=#xing_conf,1,-1 do
			local top = xing_conf[i]
			if total >= top then level = i;break end
		end
		sdata[4] = total
		if level then 
			fb_activated(sid,total) 
			SendLuaMsg(0,{ids=msg_star,fbID=index,star=star,total=total},9)
		end
	end
end

function yjdq_get_award(sid,star)
	look('yjdq_get_award',2)
	look(star,2)
	
	local sdata = yjdq_get_save_data(sid)
	look(sdata,2)
	if not sdata[4] or star > sdata[4] then return end
	if sdata[2] and star <= sdata[2] then return end
	local goods_batch = awards[star]
	if not goods_batch then return end
	sdata[2] = star
	GiveGoodsBatch(goods_batch,"一骑当千宝箱")
	SendLuaMsg(0,{ids=msg_awards,star = star},9)
end

function yjdq_saodang(sid,index)
	if IsSpanServer() then return end
	local pdata = yjdq_get_player_data(sid)
	if index < 1 or not pdata[index] then
		SendLuaMsg(0,{ids=msg_saodang,res = -1},9)
		return 
	end
	local now = GetServerTime()
	local sdata = pdata[0]
	if now - (sdata[3] or 0) < 15 * 60 then
		SendLuaMsg(0,{ids=msg_saodang,res = -2},9)
		return 
	end
	if not CheckTimes(sid,uv_TimesTypeTb.CS_yjdq,1,-1) then
		return false
	end	
	sdata[3] = now

	local CSAwards = uv_FBConfig[fbType][index].CSAwards
	local aw1 = CSAwards.star[pdata[index]].award[3]
	local aw2 = {CSAwards.items_one[math.random(1,#CSAwards.items_one)]}
	GiveGoodsBatch(aw1,"一骑当千扫荡")
	GiveGoodsBatch(aw2,"一骑当千扫荡")

	SendLuaMsg(0,{ids=msg_saodang,sd_time = now,aw1 = aw1,aw2 = aw2},9)
end

function yjdq_times_buy(sid)
	local timeinfo = GetTimesInfo(sid,uv_TimesTypeTb.CS_yjdq)
	local buytime_yb = ((timeinfo[3] or 0) + 1) * 10
	if not CheckCost(sid,buytime_yb,1,1,'一骑当千次数购买') then return end
	if not CheckTimes(sid,uv_TimesTypeTb.CS_yjdq,1,1) then return end
	CheckCost(sid,buytime_yb,0,1,'一骑当千次数购买')
end

function yjdq_saodang_buy(sid,btype,value)
	local sdata = yjdq_get_save_data(sid)
	if btype == 1 then
		if value < 0 or value >  10 * 15 then return end
	
		bdyb = GetPlayerPoints(sid,3)
		if bdyb < value then return end
		AddPlayerPoints(sid,3,-value,nil,'一骑当千扫荡CD',true)	
	else
		if value < 0 or value >  2 * 15 then return end
		if not CheckCost(sid,value,0,1,'一骑当千扫荡CD') then return end
	end
	sdata[3] = nil
	SendLuaMsg(0,{ids=msg_buysaodang,res = 0},9)
end




