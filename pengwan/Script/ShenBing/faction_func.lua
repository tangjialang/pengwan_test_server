--[[
file:	Faction_Func.lua
desc:	帮会神兵
author:	zhongsx
update:	2014-11-13
version: 1.0.0
]]--
fasb_identiy = fasb_identiy or 1

--------------------------------------------------------------------------
--Config: 
local conf  					= require('Script.ShenBing.faction_conf')
local NumFee_Conf 				= conf.NumFeeProgress_Conf
local Func_Conf					= conf.Func_Conf
local Other_Conf 				= conf.Other_Conf
local CAT_MAX_HP				= Other_Conf.CAT_MAX_HP
local CAT_ICE_ATC  				= Other_Conf.CAT_ICE_ATC
local CAT_S_DEF1	  			= Other_Conf.CAT_S_DEF1
local CAT_S_DEF2	  			= Other_Conf.CAT_S_DEF2
local CAT_S_DEF3	  			= Other_Conf.CAT_S_DEF3
local TAIN_TYPE_ITEM 			= Other_Conf.TAIN_TYPE_ITEM
local TAIN_TYPE_YB 				= Other_Conf.TAIN_TYPE_YB
local Max_Class_Level			= Other_Conf.Max_Class_Level
local Max_Level					= Other_Conf.Max_Level

--msg:
local msgh_s2c_def  			= msgh_s2c_def
local msg_fasb_train      		= msgh_s2c_def[20][18] 
local msg_fasb_break      		= msgh_s2c_def[20][19] 	


--include:
local rint 						=  rint
local look 					=  look
local fasb_TimesTypeTb 	=  TimesTypeTb
local CheckCost   	 			=  CheckCost
local CheckTimes					=  CheckTimes
local GetTimesInfo				=  GetTimesInfo
local CheckGoods					=  CheckGoods
local SendLuaMsg				=  SendLuaMsg
local Log 						=  Log
local look						=  look
local GetRWData			= GetRWData
local ScriptAttType		= ScriptAttType
local tostring,random,randomseed,type,math,os,reverse,pairs,clock,sub = tostring,math.random,math.randomseed, type, math, os, reverse, pairs, os.clock, sub

--[[local random				=  math.random
local randomseed			= math.randomseed
local type						=  type
local math					= math
local os						= os
local reverse				= reverse
local pairs					= pairs
local clock						= os.clock
local sub					    = sub
]]--
local CI_GetFactionInfo 		= CI_GetFactionInfo
local GI_GetVIPLevel 			= GI_GetVIPLevel 
local GI_GetPlayerData			= GI_GetPlayerData
local __G = _G
module(...)
--------------------------------------------------------------------------
--在一定时间内 只设置一次
--inner:

--数据区
local function get_fasb_data(playerid) 
    local fasb_data = GI_GetPlayerData(playerid,"fasb", 20)
	if fasb_data == nil then return end
	local i 
	if nil == fasb_data[1] then 
		for i =1, 4 do
			fasb_data[i] = 0
		end
		--look("初始化: "..fasb_data[1].."--"..fasb_data[2].."--"..fasb_data[3])
	end
	--[[
		[1] -- proc 当前进度
		[2] -- lv 当前等级
		[3] -- break_proc 累计突破进度
		[4] -- 阶数
	]]--
	----设置随机数种子
	if __G.fasb_identiy == 1 then 
		__G.fasb_identiy = 2 
		randomseed(clock()*10000)
	end
    return fasb_data
end

--获取当前阶位和星位
local function get_class_star(playerid, level)
	local fasb_data =  get_fasb_data(playerid)
	if nil == fasb_data then return end
	local tmp = rint(Max_Level / Max_Class_Level )
	--[[
	if 100  == fasb_data[2] then 
		class = rint(level / tmp) - 1
	else 
		class = rint(level / tmp) 
	end
	]]--
	local star = (level - (fasb_data[4] * tmp)) or 0
	--look("get_class_star---"..level.."-----"..fasb_data[4].."---"..tmp)
	return fasb_data[4], star
end


--------------------------------------------------------------------------
--检测玩家帮会\等级 是否满足条件
local function check_faction_level(playerid)
	--获取帮会ID
	local fid = CI_GetPlayerData(23, 2, playerid) or 0
	if fid == 0 then
		return false--帮会不存在
	end
	--获取当前玩家的帮会等级
	local fac_level =  CI_GetFationInfo(fid, 2) or 0
	if fac_level < Other_Conf.Limit_Faction_Level then 
		return false--帮会等级不够
	end
	return true 
end

--检测玩家元宝培育神兵的次数 
--次数满足条件返回 	true
local function check_fasb_num(playerid)
	local vip_lv = GI_GetVIPLevel(playerid) or 0
	if 0 == vip_lv then return false end --不是VIP
	local limit_num_type = fasb_TimesTypeTb.Faction_Shenbin
	if not CheckTimes(playerid, limit_num_type, 1, -1, 1) then
		--SendLuaMsg(0, {ids=msg_fasb_tnum}, 9)
		return false 
	end
	return true
end

--检测神兵等级 
local function check_shenbing_level(playerid, itype)
	 --取数据
	 local fasb_data = get_fasb_data(playerid)
	 if nil == fasb_data then return false end 
	 local cur_class, cur_star = get_class_star(playerid, fasb_data[2])
	 --look("check_shenbing_level------2----"..cur_class.."---3----"..cur_star)
	 if Max_Class_Level == cur_class then return  false end
	 if 10 == cur_star then return false end
	return true
end

--花费元宝检测
--返回 需要花费的元宝数量  和当前次数  or nil
local function check_fasb_yb(playerid)
	local limit_num_type = fasb_TimesTypeTb.Faction_Shenbin
	local time_info = GetTimesInfo(playerid, limit_num_type)
	--统计当日使用次数
	local  cur_time = time_info[1]  or 0
	--下一次需花费的元宝数
	local  yb_cost = NumFee_Conf[cur_time + 1][1]
	if nil == yb_cost  then return end
	if not CheckCost(playerid, yb_cost, 1, 1, '帮会神兵升级使用') then return end
	return yb_cost, (cur_time + 1)
end

local function pre_check_proc()

end

--检测/更新进度
	--nil 			满级 // 等级达到10星上限 需突破
	--1			等级有变动,需更新玩家属性
local function update_proc(fasb_data)
	--[[
	hlv 	= 101,  -- 自定义阶位星级   前两位表示阶位 后两位表示当前阶位星级, eg: 101  1阶1星 
	proc = 0,	  -- 累积进度 . lv 		= 1	  -- 当前等级
	]]--
	local func_proc = Func_Conf.progress
	local func_get_level = Func_Conf.get_maxmin_level
	--当前阶位 和当前星级
	local cur_class, cur_star = get_class_star(playerid, fasb_data[2])
	--已满级 不能在升级了 
	if Max_Class_Level == cur_class then
		fasb_data[1] = func_proc(fasb_data[2])
		return 
	end
	--local max_lv, min_lv = JwDj_Conf[cur_class + 1], JwDj_Conf[cur_class]
	--rint( ((fasb_data.lv / 10 ) + 1) * 10),  rint((fasb_data.lv / 10) * 10)	
	--当前阶位最大等级,最小等级
	local max_lv, min_lv = func_get_level(fasb_data[2])
	
	--下一个等级的最大进度
	local lv_proc = func_proc(fasb_data[2] + 1)
	local ret_att
	while fasb_data[1] >=  lv_proc do
		--扣除本级进度  //升一级
		fasb_data[1] = fasb_data[1] - lv_proc
		fasb_data[2] = fasb_data[2] + 1
		ret_att = 1
		--突破升阶
		if  fasb_data[2] == max_lv then
			fasb_data[4] = fasb_data[4] + 1
			break 
		end
		
		lv_proc = func_proc(fasb_data[2] + 1) 
	end
	--look("update_proc----"..fasb_data[1].."-----"..fasb_data[2].."---"..fasb_data[3].."---"..fasb_data[4])
	return ret_att
end

--更新玩家属性/战斗力 PI_UpdateScriptAtt(playerid,ScriptAttType.fasb)
local	function _update_att(playerid, init)
	local fasb_data = get_fasb_data(playerid)
	if nil == fasb_data then return end
	local AttTb = GetRWData(1)
	local att_func = Func_Conf
	local curlv = fasb_data[2]
	--hp
	AttTb[CAT_MAX_HP] = att_func[CAT_MAX_HP](curlv)
	AttTb[CAT_ICE_ATC] = att_func[CAT_ICE_ATC](curlv)
	AttTb[CAT_S_DEF1] = att_func[CAT_S_DEF1](curlv)
	AttTb[CAT_S_DEF2] = att_func[CAT_S_DEF2](curlv)
	AttTb[CAT_S_DEF3] = att_func[CAT_S_DEF3](curlv)
	
	--属性变动
	if init ~= 1 then 
		__G.PI_UpdateScriptAtt(playerid, ScriptAttType.fasb)
	end
	return true 
end

--获取当前神兵 进度 阶位 星级, 等级
local function get_fasb_info(playerid)
	local fasb_data = get_fasb_data(playerid)
	if nil == fasb_data then return end
	
	local class, star = get_class_star(playerid, fasb_data[2])
	
	return fasb_data[1], class, star, fasb_data[2]
end

----------------------------------------------------------------------------------------
--元宝培育神兵
local function yb_shenbing(playerid)
	if nil == playerid then return end
	 --检测 是否能升级
	if not check_shenbing_level(playerid, TAIN_TYPE_YB) then return end
	local fasb_data = get_fasb_data(playerid) 
	if fasb_data == nil then return end
	 --次数检测
	if not check_fasb_num(playerid) then return  end
	--元宝检测 获得本次培育所需YB 和 本次为第几次
	local yb_cost,  curnum = check_fasb_yb(playerid)
	--本次加的进度
	local step_exp = random(NumFee_Conf[curnum][2],  NumFee_Conf[curnum][3])
	--DEBUG
	--扣除次数/YB , 加上进度 , 更新属性 
	CheckTimes(playerid, fasb_TimesTypeTb.Faction_Shenbin, 1, -1)
	CheckCost(playerid, yb_cost, 0, 1, '帮会神兵法宝升级使用')
	fasb_data[1] = fasb_data[1] + step_exp
	--检测进度 
	local ret_att = update_proc(fasb_data) 
	local msg = { ids=msg_fasb_train, itype = TAIN_TYPE_YB, proc = fasb_data[1], curlv = fasb_data[2] }
	--更新属性
	if 1 == ret_att then 
		_update_att(playerid)  
		msg.flag = 0
	end 
	SendLuaMsg(0,  msg, 9)
end

--道具培育帮会神兵
--playerid 	玩家ID
local function item_shenbing(playerid, atype, lastnum)
	local atype = atype
	if nil == playerid then return end
	--检测神兵等级
	if not check_shenbing_level(playerid, TAIN_TYPE_ITEM) then return end
	--取数据
	local fasb_data = get_fasb_data(playerid)
	if nil == fasb_data then return end 
	--道具
	local item = Other_Conf.items[1]
	--每次耗材
	local step_item_cost = Func_Conf.get_train_cost(fasb_data[2])
	local step_exp = Func_Conf.get_train_proc(fasb_data[2])   --每次消耗增加的进度
	local item_cost, max_proc, next_proc 
	local flag = 2 --下发到客户端消息中标志 
	--0 升级了
	--1  道具不足 以自动升级
	
	if 1 == atype then --是否自动升级
		--升级所需总进度
		max_proc = Func_Conf.progress(fasb_data[2] + 1)
		next_proc = max_proc - fasb_data[1] 	--升级所需剩余进度
		item_cost = step_item_cost * rint( next_proc / step_exp)
		
		if 0 == CheckGoods(item[1], item_cost, 1, playerid,"用道具培育帮会神兵法宝") then 
			item_cost = step_item_cost * rint(lastnum / step_item_cost) 
			next_proc = step_exp * rint(lastnum / step_item_cost)
			flag = 1
		end
	else --only one 
		next_proc = step_exp
		item_cost = step_item_cost * rint( next_proc / step_exp)
	end
	--Check 道具所需消耗数量
	if 0 == CheckGoods(item[1], item_cost, 1, playerid, "用道具培育帮会神兵法宝") then return end
	--扣除道具 / 加进度
	CheckGoods(item[1], item_cost, 0, "用道具培育帮会神兵法宝")
	fasb_data[1] =  fasb_data[1] + next_proc
	--检测进度 
	local ret = update_proc(fasb_data) 
	local msg = { ids=msg_fasb_train, itype = TAIN_TYPE_ITEM, proc = fasb_data[1], 
							curlv = fasb_data[2] , flag = flag}
	if 1 == ret then 
		_update_att(playerid)   
		msg.flag = 0
	end
	SendLuaMsg(0, msg, 9)
end

--对外接口 神兵
local function _train_shenbing(playerid, itype, atype, lastnum)
	if type(playerid) ~= "number"  or type(itype) ~= "number"  then return end
	if type(atype) ~= "number" or type(lastnum) ~= type(0) then return end
	--帮会等级检测
	--if not check_faction_level(playerid) then return end
	--使用道具
	 if TAIN_TYPE_ITEM == itype then 
		item_shenbing(playerid, atype, lastnum)
	 elseif TAIN_TYPE_YB == itype  then --使用元宝
		yb_shenbing(playerid)
	 end
end

--道具突破帮会神兵
--playerid 	玩家ID
local function _break_shenbing(playerid)
	--暂时不用
	if type(playerid) ~= "number" then return end
	--帮会等级检测
	--if not check_faction_level(playerid) then return end
	--取数据
	local fasb_data = get_fasb_data(playerid)
	if nil == fasb_data then return end 
	--当前阶位 和当前星级
	local cur_class, cur_star = get_class_star(playerid, fasb_data[2])
	--已满级 或者 星级没有到10星 不能在升级了 
	if Max_Level == fasb_data[2] then return end
	if 10 ~= cur_star then return end
	--检测道具
	local item = Other_Conf.items[2]
	local item_num = Func_Conf.get_break_cost(cur_class)
	if item_num == nil then return end
	--突破次数
	--[[
	当突破进度达到50 后 开始以50%的几率进行随机突破
	每点增加1%的几率, 每增加5%的几率额外再增加5%
	]]--
	if not (CheckGoods(item[1], item_num, 1, "用道具进行突破") == 1)then return end
	--look("_break_shenbing---probability--------")
	CheckGoods(item[1], item_num, 0, "用道具进行突破")
		
	local probability = 0
	fasb_data[3] = fasb_data[3] + Func_Conf.get_break_proc(fasb_data[2]) 
	local msg = {ids=msg_fasb_break, flag=1 }
	--look("_break_shenbing---probability-------1-"..fasb_data[3])
	if  fasb_data[3] >= 100 then 
		fasb_data[3] = 100 
		fasb_data[4] = fasb_data[4] + 1
		--下发突破进度 突破阶数
		msg.tpproc,  msg.tplv =fasb_data[3], fasb_data[4]
		SendLuaMsg(0, msg, 9)
		fasb_data[3] = 0 
		return 
	elseif fasb_data[3] >= 50 then 
		probability = Func_Conf.get_probability(fasb_data[3])
		--fasb_data[3] = fasb_data[3] + 1
		--根据突破进度设置随机数种子
		if 0 == rint(fasb_data[3] % 5)  then 			
			randomseed(tostring(clock()*10000):reverse():sub(1, 6)) 
			look("----------------------------------")
		end
		--随机突破
		local tmp = random(20,100)
		look("_break_shenbing---"..fasb_data[3].."probability--"..probability.."   tmp  "..tmp)
		if (probability >= tmp )  then --突破成功
			--重置突破次数
			probability = 0
			fasb_data[3] = 100 
			fasb_data[4] = fasb_data[4] + 1
			--下发突破进度 突破阶数
			msg.tpproc, msg.tplv =fasb_data[3], fasb_data[4]
			SendLuaMsg(0, msg, 9)
			fasb_data[3] = 0 
			
			return
		end
	end
	--probability = probability + fasb_data[3]
	SendLuaMsg(0, {ids=msg_fasb_break, flag=0, tpproc= fasb_data[3], tplv=fasb_data[4] }, 9)
end


--突破进度每日清0
local function _reset_tpproc(playerid)
	local fasb_data = get_fasb_data(playerid)
	if nil == fasb_data then return end
	fasb_data[3] = 0
end

----test
local function _clear_data(sid)
	local fasb_data = get_fasb_data(sid)
	local i 
	for i =1, 4 do
		fasb_data[i] = nil
	end
end
--------------------------------------------------------------------------
--interface:
fasb_train_shenbing		=  _train_shenbing
fasb_break_shenbing		=  _break_shenbing
fasb_reset_tpproc		=  _reset_tpproc
fasb_clear_data			=  _clear_data
fasb_att				=  _update_att
 