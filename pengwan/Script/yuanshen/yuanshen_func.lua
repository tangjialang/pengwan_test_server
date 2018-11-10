--[[
file:	yuanshen_func.lua
desc:	元神系统
author:	dzq
update:	2014-4-8
refix:	done by dzq
]]--
local look = look
local table_insert = table.insert
local pairs,ipairs = pairs,ipairs
local CheckGoods	 = CheckGoods
local CheckCost	 = CheckCost
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
--local msg_yuanshen_init	 = msgh_s2c_def[45][1] ---   初始化信息	
local msg_yuanshen_up	 = msgh_s2c_def[45][2]--升级
local msg_yuanshen_all_up	 = msgh_s2c_def[45][3]--一键升级
local msg_yuanshen_normal_challenge	 = msgh_s2c_def[45][4]--普通挑战
local msg_yuanshen_all_challenge	 = msgh_s2c_def[45][5]--一键扫荡
local msg_yuanshen_one_challenge	 = msgh_s2c_def[45][6]--扫荡
local msg_yuanshen_buytimes	         = msgh_s2c_def[45][7]--次数购买
local msg_yuanshen_suc               = msgh_s2c_def[45][8]--副本挑战成功
local msg_yuanshen_refresh              = msgh_s2c_def[45][9]-- 元神每日重置
local CI_UpdateScriptAtt = CI_UpdateScriptAtt
local CI_GetPlayerData=CI_GetPlayerData
local ScriptAttType = ScriptAttType
local type=type
local rint = rint
local GiveGoods=GiveGoods
local __G = _G
local GI_GetPlayerData=GI_GetPlayerData
local TipCenter = TipCenter
local isFullNum = isFullNum
local IsSpanServer = IsSpanServer


--單次消耗 = INT(級別/3+2)*魂魄類型
--每級進度 = INT(級別^2/6+2)*魂魄類型^2
--氣血屬性 = INT(級別*10+級別^2)*5*魂魄類型
--攻擊/防禦 = INT(級別*10+級別^2)*魂魄類型
--屬性攻擊 = INT(級別*10+級別^2)*魂魄類型
--屬性抗性 = =INT(級別*10+級別^2*1.5)*魂魄類型
--开辟数据 元神等级 和 是否通过元神关卡
function yuanshen_getdata( playerid )
	local data=GI_GetPlayerData( playerid , 'yuanshen' , 200 )
	local fb_data = CS_GetPlayerData(playerid)
	local fb_type = 17 --元神副本为17
	if(data == nil) then 
		return
	end	

	if data.lv == nil or data.checkpoint == nil or data.gettimes== nil or data.usetimes == nil then 
	--初始化元神等级
		data.lv = {}
		data.gettimes = {} --现有次数
		data.usetimes = {} --使用次数
		data.progress = {}
		if(fb_data.pro and fb_data.pro[fb_type]) then	
			data.checkpoint = fb_data.pro[fb_type]	
		else
			data.checkpoint = 0
		end
		for i = 1,10 do
			data.lv[i] = 0--等级
			data.gettimes[i] = 1 --可用次数
			data.usetimes[i] = 0 --已经使用次数
			data.progress[i] = 0--进度条
		end
	end
	--挑战到哪个副本
	if(fb_data.pro and fb_data.pro[fb_type]) then
		data.checkpoint = fb_data.pro[fb_type]%17000	
	end
	return data
end

--每日重置数据
function refresh_yuanshen(playerid)
	local data=yuanshen_getdata(playerid)
	if(data.gettimes == nil or data.usetimes == nil) then
		return
	end
	for i = 1,10 do
		if( data.gettimes[i] < 1) then
			data.gettimes[i] = 1
		end	
		data.usetimes[i] = 0
	end
	SendLuaMsg(0,{ids=msg_yuanshen_refresh,have = data.gettimes,used = data.usetimes},9)
end
--元神初始化信息
--[[function yuanshen_init(playerid)
	local data=yuanshen_getdata( playerid)
	local lvlist = data.lv
	local point = data.checkpoint
	look(" 不可能是零"..point,1)
	--现有次数和已用次数
	local havetimes = data.gettimes
	local usedtimes  = data.usetimes
	local progressValue = data.progress
	--把所有信息发给客服端
	SendLuaMsg(0,{ids=msg_yuanshen_init,lv = lvlist,
	checkpoint = point,have =havetimes,used = usedtimes,progress = progressValue},9)
end--]]
-- 根据元神类型和等级获得属性值
local function get_attribute(atttype,lv,curtype,atttab)
	if(atttype == nil) then
		return
	end	
	local conftype = yuanshen_conf[curtype][3]
	if(conftype == nil) then
		return
	end	
	--气血属性 INT(級別*10+級別^2)*5*魂魄類型
	if(atttype == 1) then
		atttab[atttype] = (lv*10 + lv^2)*5*conftype + (atttab[atttype] or 0)
	--属性工具 NT(級別*10+級別^2)*魂魄類型	
    elseif(atttype == 2) then	
		atttab[atttype] = (lv*10 + lv^2)*conftype+ (atttab[atttype] or 0)	
	--攻击或防御 INT(級別*10+級別^2)*魂魄類型	
	elseif(atttype == 3 or atttype == 4) then
		atttab[atttype] = (lv*10 + lv^2)*conftype + (atttab[atttype] or 0)		
	--属性防御  INT(級別*10+級別^2*1.5)*魂魄類型	
	elseif(atttype == 10 or atttype  == 11 or atttype ==12) then
		atttab[atttype] = rint((lv*10 + lv^2*1.5)*conftype) + (atttab[atttype] or 0)
	end
	return 	atttab
end
--属性增加 init 1表示初始化，0表示非初始化
function yuanshen_attribute(playerid,init)
	local atttab=GetRWData(1)
	local data=yuanshen_getdata(playerid)
	--增加什么属性从配置表读取
	for curtype = 1,10 do
		local lv = data.lv[curtype]
		local attr_first = yuanshen_conf[curtype][1][1]
		local attr_second = yuanshen_conf[curtype][1][2]
		local attr_third = yuanshen_conf[curtype][1][3]
		get_attribute(attr_first,lv,curtype,atttab)
		get_attribute(attr_second,lv,curtype,atttab)
		get_attribute(attr_third,lv,curtype,atttab)
	end
	if(init == 0) then
		PI_UpdateScriptAtt(playerid,ScriptAttType.yuanshen)
	end	
	return true
end
--元神升级模板
--curtype 元神类型 
local function  temp_yuanshen_up(playerid,curtype)
	if(playerid == nil or curtype == nil) then
		return 0
	end		
	-- 获得对应元神的等级
	local data = yuanshen_getdata(playerid)
	local lv = data.lv[curtype]
	local conftype = yuanshen_conf[curtype][3]
	--当次消耗的物品数量 單次消耗 = INT(級別/3+2)*魂魄類型
	local num = rint(lv/3 + 2 )*conftype
	local itemId = yuanshen_conf.cost_id --配置表读取
	if(data.lv[curtype] >= yuanshen_conf.ysmaxlv) then
		return 0
	end
	if(CheckGoods(itemId, num,0,playerid,'元神消耗物品') == 0) then
		return 0
	end	
	--进度条 每級進度 = INT(級別^2/6+2)*魂魄類型^2
	local progress = (rint(lv^2/6 + 2))*conftype^2
	--升级
	if(data.progress[curtype] + num >= progress) then
		data.progress[curtype] = data.progress[curtype] + num - progress
		data.lv[curtype] = data.lv[curtype] + 1
		yuanshen_attribute(playerid,0)
	else
		data.progress[curtype] =  data.progress[curtype] + num	
	end

	return 1
end
-- 普通升级
function yuanshen_normal_up(playerid,curtype)
	if IsSpanServer() then return end
	local Ret = temp_yuanshen_up(playerid,curtype)
	local data = yuanshen_getdata(playerid)
	local lv = data.lv[curtype]
	local progress = rint(data.progress[curtype])
	SendLuaMsg(0,{ids=msg_yuanshen_up,sendtype   = curtype,sendlv   = lv,succ = Ret,sendprogress = progress},9)
end
--一键升级
--策划更改需求 只升到下一级
function yuanshen_allup(playerid, curtype, num)
	if IsSpanServer() then return end
	if(playerid == nil or curtype == nil or num == nil) then
		return 0
	end		

	-- 获得对应元神的等级
	local data = yuanshen_getdata(playerid)
	local lv = data.lv[curtype]
	local isSucc = 1--是否一键升级成功
	local nextlv = lv + 1
	if(data.lv[curtype] == nil or data.lv[curtype] >= yuanshen_conf.ysmaxlv) then
		return
	end	
	
	local conftype = yuanshen_conf[curtype][3]
	--每次消耗的物品数量 單次消耗 = INT(級別/3+2)*魂魄類型
	local every_num = rint(lv/3 + 2 )*conftype		
	
	if every_num >  num then 
		return 
	end
	
	local itemId = yuanshen_conf.cost_id --配置表读取
	--进度条 每級進度 = INT(級別^2/6+2)*魂魄類型^2
	local need_pro = (rint(lv^2/6 + 2))*conftype^2
	local cur_pro = rint(data.progress[curtype])
	--升到下一级 需要多少ITEM 一个道具一个进度
	local need_num = (need_pro - cur_pro) ; 
	--持有物品不足
	if need_num > num then
		if(CheckGoods(itemId, num, 0, playerid,'元神消耗物品') == 0) then
			return 0
		end	
		data.progress[curtype] =  data.progress[curtype] + num	
	else 
		--持有道具数 足够升一级
		if(CheckGoods(itemId, need_num, 0, playerid,'元神消耗物品') == 0) then
			return 0
		end	
		data.progress[curtype] =  data.progress[curtype] + need_num - need_pro
		data.lv[curtype] = data.lv[curtype] + 1
		yuanshen_attribute(playerid,0)
	end

	--[[
	while(data.lv[curtype] < nextlv and data.lv[curtype] < 100) do
		local Ret = temp_yuanshen_up(playerid,curtype)
		if(Ret == 0) then
			break
		else
			isSucc = 1		
		end	
	end	
	--]]
	
	--发送消息
	local lvValue = data.lv[curtype]
	local progress = rint(data.progress[curtype])
	SendLuaMsg(0,{ids=msg_yuanshen_all_up,sendtype   = curtype,succ = isSucc,sendlv   = lvValue,sendprogress = progress},9)
	
end

--副本过关获得奖励 c_type 0表示扫荡，1表示挑战
function yuanshen_getaward(playerid,curtype,c_type)
	-- 获得奖励
	local data = yuanshen_getdata(playerid)
	local cursize = #yuanshen_conf[curtype][2]
	local itemid
	local itemnum
	local isbind
	for i = 1,cursize do 
		itemid = yuanshen_conf[curtype][2][i][1] --物品id
		itemnum = yuanshen_conf[curtype][2][i][2] --物品数量
		isbind = yuanshen_conf[curtype][2][i][3] --是否绑定
		if(itemid == nil or itemnum == nil or isbind == nil) then
			return 
		end	
		--GiveGoods(itemid,itemnum,isbind,'进入元神副本获得物品')
	end
	if(c_type == 1) then 
		--并且累计使用次数
		data.lv[curtype] = data.lv[curtype]  + 1     --送玩家一级并且不消耗物品
		yuanshen_attribute(playerid,0)
		data.usetimes[curtype] = data.usetimes[curtype] + 1	
		data.gettimes[curtype]  = data.gettimes[curtype] -1
		SendLuaMsg(0,{ids=msg_yuanshen_suc,ctype = curtype,succ = 1},9)
	else
		
		GiveGoods(itemid,itemnum,isbind,'进入元神副本获得物品')	
	end
end
--副本进入模板
--参数1表示玩家id 2表示类型 3表示是否挑战 0表示不是，1表示是
--返回值0表示进入失败， 1表示进入成功
local function temp_challenge(playerid,curtype,ctype)
	local vipLv = __G.GI_GetVIPLevel(playerid)
	local conf_times = yuanshen_conf.times[vipLv] --配置次数
	if(conf_times == nil) then
		return 0
	end	
	local data = yuanshen_getdata(playerid)
	local usetimes = data.usetimes[curtype] --使用的次数
	local gettimes = data.gettimes[curtype] --获得的次数
	if(gettimes <= 0 ) then
		return 0
	end	
	--并且累计使用次数
	if(ctype == 0 ) then
		data.usetimes[curtype] = data.usetimes[curtype] + 1	
		data.gettimes[curtype]  = data.gettimes[curtype] -1
	end	
	return 1
end
--副本挑战
function normal_challenge(playerid,curtype)
	--能否挑战
	local data = yuanshen_getdata(playerid)
	if(curtype ~= data.checkpoint + 1) then
		return
	end	
	local Ret = temp_challenge(playerid,curtype,1)
	--告诉客服端是否可以进入
	SendLuaMsg(0,{ids=msg_yuanshen_normal_challenge,ctype = curtype,succ = Ret},9)
	if(Ret == 1) then
		local curvalue = 17000 + curtype 
		CS_RequestEnter(playerid,curvalue)
	end
end
--副本扫荡
function one_challenge(playerid,curtype)
	local pakagenum = isFullNum()
	if(pakagenum < 1) then
		TipCenter(GetStringMsg(14,1))
		return
	end	
	local Ret = temp_challenge(playerid,curtype,0)
	if(Ret == 1) then
		yuanshen_getaward(playerid,curtype,0)
	end	
	SendLuaMsg(0,{ids=msg_yuanshen_one_challenge,ctype = curtype,succ = Ret},9)
end

local function all_challenge_type(playerid,curtype)
	local data = yuanshen_getdata(playerid)
	local gettimes = data.gettimes[curtype] --获得的次数
	while(gettimes > 0) do
		temp_challenge(playerid,curtype,0)
		gettimes = gettimes -1
		yuanshen_getaward(playerid,curtype,0)
	end
end
--一键扫荡
function all_challenge(playerid)
	local pakagenum = isFullNum()
	if(pakagenum < 1) then
		TipCenter(GetStringMsg(14,1))
		return
	end	
	local data = yuanshen_getdata(playerid)
	local msg = {}
	local check = data.checkpoint
	for ctype = 1,check do
		all_challenge_type(playerid,ctype)
		local value = data.usetimes[ctype]
		table_insert(msg,value)
		--yuanshen_getaward(playerid,ctype,0)			
	end
	--判断一键扫荡是否成功
	local allRet
	if(#msg == 0) then
		allRet = 0
	else
		allRet = 1
	end	
	SendLuaMsg(0,{ids=msg_yuanshen_all_challenge,succ = allRet,list = msg},9)
end
--次数购买  
function yuanshen_buytimes(playerid,curtype)
	local vipLv = __G.GI_GetVIPLevel(playerid)
	local conf_times = yuanshen_conf.times[vipLv]
	local no_cost_times = 1 ---免费次数
	if(conf_times == nil) then 
		return 
	end	
	local data = yuanshen_getdata(playerid)
	local curtimes = data.gettimes[curtype] + data.usetimes[curtype]
	local buytimes = data.gettimes[curtype] + data.usetimes[curtype] - 1
	if( buytimes > conf_times ) then
		return
	end	
	local cost_yb = 20*curtimes 
	if not CheckCost(playerid, cost_yb,0,1,'元神副本购买') then
		return  0
	end	
	data.gettimes[curtype] = data.gettimes[curtype] + 1
	
	SendLuaMsg(0,{ids=msg_yuanshen_buytimes,ctype = curtype,have = data.gettimes[curtype],used = data.usetimes[curtype]},9)
	
end


--试炼副本相关--------------------后面移动到试炼文件区

--数据区
function sl_getpdata( playerid )
	local pdata=GI_GetPlayerData( playerid , 'sl' , 50 )
		--[[
			[3]=当前关
		]]
	return pdata
end

--判断玩家可以打本关不 index=关数
local function sl_canplay( playerid,index )
	local pdata=sl_getpdata( playerid )
	if  pdata==nil then return end
	local nowlv=pdata[3] or 0
	if index~=nowlv+1 then 
		return 
	end
	return true
end
--取帮会是否有大神通过本关
local function sl_canplayeasy(index)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return  --帮会不存在
	end
	local fcdata=GetFactionData(fid) --帮会数据
	fcdata.slmax=fcdata.slmax or {}
	local nowmaxlv=fcdata.slmax[1] or 0
	if nowmaxlv>=index then 
		return true
	end
	return false
end
--副本完成处理--本人奖励,困难副本帮会更新,itype=1困难模式
function sl_fbsucc(playerid,fbID,itype)
	look('副本完成处理')
	local mainid,index = GetSubID(fbID)
	local pdata=sl_getpdata( playerid )
	if  pdata==nil then return end
	local nowlv=pdata[3] or 0
	if index>nowlv then
		pdata[3]=nowlv+1
		RPC('sl_succ',pdata[3])
	end
	if itype~=1 then return end
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return  --帮会不存在
	end
	local fcdata=GetFactionData(fid) --帮会数据
	fcdata.slmax=fcdata.slmax or {}
	local nowmaxlv=fcdata.slmax[1] or 0
	look(nowmaxlv)
	look(index)
	if index>nowmaxlv then 
		local name=CI_GetPlayerData(3)
		local school=CI_GetPlayerData(2)
		local sex=CI_GetPlayerData(11)
		local head=CI_GetPlayerData(70)
		fcdata.slmax[1] =index
		fcdata.slmax[2] =name
		fcdata.slmax[3] =sex
		fcdata.slmax[4] =head
		fcdata.slmax[5] =playerid
		FactionRPC( fid, 'sl_max',fcdata.slmax[1],name,sex,head,playerid)
	end
end
--试炼副本挑战
function sl_challenge(playerid,fbID)
	--look(fbID,1)
	local rx, ry, rid, mapGID = CI_GetCurPos(2,playerid)
	if mapGID then 
		TipCenter(GetStringMsg(17))
		return 
	end
	local jointime= __G.get_join_factiontime(playerid)
	if jointime==nil or GetServerTime()-jointime<24*3600 then 
		return 
	end
	if fbID<19000 or fbID>20000 then return end
	local mainid,index = GetSubID(fbID)
	--能否挑战
	local canplay=sl_canplay( playerid,index )
	if  not canplay then return end
	--有人打过没
	local canplayeasy=sl_canplayeasy(index)
	if canplayeasy then 
		fbID=20000+index
	end
	CS_RequestEnter(playerid,fbID)
end
--玩家每日重置
function sl_fbreset( playerid )
	local pdata=sl_getpdata( playerid )
	if  pdata==nil then return end
	pdata[3]=nil
end








