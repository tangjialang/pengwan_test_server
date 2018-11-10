--[[
file:	wuzhuang_fun.lua
desc:	元神武装
author:	ct
update:	2014-6-16
]]--

local msgh_s2c_def	= msgh_s2c_def
local msg_wuzhuang_up =msgh_s2c_def[50][1]
local msg_check =msgh_s2c_def[50][2]
local conf=require("Script.wuzhuang.wuzhuang_conf")
local wuzhuang_conf=conf.wuzhuang_conf
local wuzhuang_zb_conf = conf.wuzhuang_zb_conf
local GetRWData = GetRWData
local rint = rint
local look = look
local GI_GetPlayerData = GI_GetPlayerData
local CI_GetPlayerData = CI_GetPlayerData
local CheckGoods = CheckGoods
local CheckCost = CheckCost
local SendLuaMsg = SendLuaMsg
local TipCenter = TipCenter
local pairs=pairs
local type=type
--local ScriptAttType = ScriptAttType
--local PI_UpdateScriptAtt = PI_UpdateScriptAtt
local __G = _G 
module(...)
--申请空间
local function wz_getwuzhuangdata(playerid)
	local data = GI_GetPlayerData(playerid,'wz',70)
		--[[	 data={	[1]={0,0}, 翅膀  ={等级，进度}	[2]={0,0}, 肩部	[3]={0,0}, 臀部	[4]={0,0}, 手腕	[5]={0,0}, 头部	[6]={0,0}, 躯干	[7]={0,0}  腿部	} ]]
	return data
end
--添加属性
local function _wz_attup(playerid,itype)
	local data=wz_getwuzhuangdata(playerid)
	if nil == data then
		return 
	end
	
	local att_type = wuzhuang_conf[1]
	local att_value= wuzhuang_conf[2]
	if nil == att_type then
		return
	end
	if nil == att_value then
		return
	end
	local AttTable =GetRWData(1)
	local lv = 0 --星的等级
	for i=1,7 do
		lv = type(data[i]) == type({}) and data[i][1] or 0
		att_type= wuzhuang_conf[1][i]
		for k,v in pairs(att_type) do
			att_value= wuzhuang_conf[2][v]
			AttTable[v]=(AttTable[v] or 0)+rint(lv*10+lv^2*att_value[1])*att_value[2]
		end
	end
	if itype == 1 then
		__G.PI_UpdateScriptAtt(playerid,__G.ScriptAttType.wuzhuang)
	end
	return true
end
--playerid 用户ID号码
--升级      
--[[     outfit表示那一个部分 1:翅膀 2:肩部	3:臀部 4:手腕 5:头部 6:躯干 7:腿部 num表示材料个数  
		 money  0 表示道具不足用钱买  1表示 不用钱买]]
local function _wuzhuang_up(playerid,outfit,num,money)	
	if nil == playerid or playerid <= 0 then
		return
	end
	if outfit<=0 or outfit >7 then
		return
	end
	if money >1 or money <0 then
		return
	end
	if num < 0 then
		return
	end
	
	local expend              --消耗数量
	local progress            --升级需要的进度
	local data = wz_getwuzhuangdata(playerid)
	if nil == data then
		return 
	end
	local money_num           --购买道具需要的钱
    data[outfit] = data[outfit] or {0,0}
	--单次消耗  INT((等级+1)/5*2)+1
	expend = rint((data[outfit][1]+1)/5*2) +1
	--计算升级需要的进度 INT(等级/15)*5+10
	progress = rint((data[outfit][1]+1)/15)*5+10
	if expend <= 0 then
		return
	end
--升级
	--只用道具升级
	if 1 == money then
		if CheckGoods(821,expend,0,playerid,"元神武装部位强化") ~= 1  then
			SendLuaMsg(0,{ids=msg_wuzhuang_up,lv = data[outfit][1],outfit=outfit,step= data[outfit][2]},9)
			return
		end
	--道具不足的时候用钱购买
	elseif 0 == money then
		--道具足 只用道具升级
		if num >= expend then
			if CheckGoods(821,expend,0,playerid,"元神武装部位强化") ~= 1  then
				SendLuaMsg(0,{ids=msg_wuzhuang_up,lv = data[outfit][1],outfit=outfit,step= data[outfit][2]},9)
				return
			end
		--道具不足 扣道具 扣钱
		elseif num < expend then
			money_num=(expend-num)*5
			if money_num < 0 then
				return
			end
			if CheckCost (playerid,money_num,1,1,"元神武装部位强化") == false or CheckGoods(821,num,1,playerid,"元神武装部位强化") ~= 1 then
				SendLuaMsg(0,{ids=msg_wuzhuang_up,lv = data[outfit][1],outfit=outfit,step= data[outfit][2]},9)
				return
			end
			CheckCost (playerid,money_num,0,1,"元神武装部位强化")
			CheckGoods(821,num,0,playerid,"元神武装部位强化")
		end
	end
	data[outfit][2] = data[outfit][2]+1
	--进度满   升级  进度归零
	if data[outfit][2] >= progress then
		data[outfit][1] = data[outfit][1] +1
		data[outfit][2] =0
		--升级加属性
		_wz_attup(playerid,1)		
	end	
	SendLuaMsg(0,{ids=msg_wuzhuang_up,lv = data[outfit][1],outfit=outfit,step= data[outfit][2]},9)
	return true
end

local function wuzhuang_check(playerid,id,name)
	local look_attribute = true
	if type(id)~= type(0) or id < 1 or nil == id then
		look_attribute = false
	end
	if type(name) ~= type('') then
		name=CI_GetPlayerData(5,2,id)
		if type(name) ~= type('') then
			look_attribute = false
		end
	end
	if not look_attribute then
		SendLuaMsg(0,{ids=msg_check,name=name,data=0},9)
		return
	end
	local data_attribute = wz_getwuzhuangdata(id)
	SendLuaMsg(0,{ids=msg_check,name=name,data=data_attribute},9)
end
   --装备id   outfit_id 
--SI_EquipItem（装备id） 穿上装备
--[[
	70级 绿色 10级,蓝色 20级, 紫色 30级,橙色 40级,红色 50级, 
	80级 红色 60级
	90级 红色 70级

]]
local function _EquipItem(outfit_id)
	local grade      --物品对应的部件等级
	local location   --物品部件
	if nil == wuzhuang_zb_conf[outfit_id] then
		return 0
	end
	local playerid = CI_GetPlayerData(17)
	local data=wz_getwuzhuangdata(playerid)
	if nil == data then
		return 1
	end
 	grade = wuzhuang_zb_conf[outfit_id][1]
	location = wuzhuang_zb_conf[outfit_id][2]
	local curlv = data[location] and data[location][1] or 0 
	if curlv >= grade then
		return 0
	end
	return 1
end
--SI_UnEquipItem（装备id） 脱下装备
--[[local function _UnEquipItem(outfit_id)
	return 0
end]]

--GM命令 直接设置当前等级
local function _gm_set_level(sid, outfit, level)
	local pdata = wz_getwuzhuangdata(sid)
	if pdata == nil then return end
	if type(outfit) ~= type(0) then return end
	if outfit > 7 or outfit < 1 then return end
	pdata[outfit] = pdata[outfit] or {0,0}
	pdata[outfit][1] = (pdata[outfit][1] or 0) + level
	pdata[outfit][2] =0
	_wz_attup(sid,1)
	SendLuaMsg(0, {ids=msg_wuzhuang_up,lv = pdata[outfit][1], outfit=outfit, step= pdata[outfit][2]}, 9)
end

-----------------------------------------
wuzhuang_up = _wuzhuang_up
wz_attup    = _wz_attup
EquipItem   = _EquipItem
--UnEquipItem = _UnEquipItem
wz_check       = wuzhuang_check
gm_set_level = _gm_set_level