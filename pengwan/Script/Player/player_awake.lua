--[[
file:	player_awake.lua
desc:	玩家100级觉醒
author:	zhongsx
update:	2015-04-22
]]--

local msg_awake =  msgh_s2c_def[3][31]
local msg_equip =  msgh_s2c_def[3][32]

local GI_GetPlayerData = GI_GetPlayerData
local SendLuaMsg = SendLuaMsg
local CI_GetPlayerData = CI_GetPlayerData
local PI_PayPlayer = PI_PayPlayer
local CI_PayPlayer = CI_PayPlayer
local  GiveGoodsBatch = GiveGoodsBatch
local TipCenter = TipCenter
local RPCEx = RPCEx
local look = look
local type = type
local CheckCost = CheckCost
local isFullNum = isFullNum
local GiveGoods  = GiveGoods
--------------------------
module(...)
--------------------------
--配置
local awakeconf ={
	limitlevel = 100, --限制最小等级
	maxproc = 100, --最大觉醒进度
	equip = {
		[1] = 5257,  --将军装备
		[2] = 5294,  --修仙装备
		[3] = 5331,   --九黎装备
	}, --觉醒成功后, 赠送的装备 分职业
	--每一进度 需要消耗 proc * 400000 exp
	needexp = function(proc)
		return ((proc + 1) * 400000)
	end,
	needyb = 20, --每一进度需要消耗1000YB
}
	
--[[
	awake={
		[1] = 0~100; ---觉醒进度
		[2] = 1 or 0;  --是否已领取装备
	}
]]--
local function GetAwakeData(sid)
	local pdata = GI_GetPlayerData(sid, 'awake', 16)
	if pdata == nil then return end
	if pdata[1] == nil then 
		pdata[1] = 0
	end
	return pdata
end

--玩家觉醒飞升
local function _awake_data(sid, itype)
	if type(itype) ~= type(0) then return end

	local pdata = GetAwakeData(sid)
	if pdata == nil then return end

	--已成功觉醒或者觉醒度已达MAX
	if pdata[1] >= awakeconf.maxproc then 
		SendLuaMsg(0, {ids=msg_awake, itype=itype, err = 8}, 9)
		return 
	end

	local lv = CI_GetPlayerData(1)		-- 玩家等级
	if lv < awakeconf.limitlevel then 
		SendLuaMsg(0, {ids=msg_awake,  itype=itype, err = 5}, 9)
		return 
	end
	
	--觉醒方式
	local pExps, needexp 
	if itype == 1 then 
		 pExps = CI_GetPlayerData(4)		-- 玩家当前经验
		 needexp = awakeconf.needexp(pdata[1]) 
		if pExps < needexp  then 
			SendLuaMsg(0, {ids=msg_awake,  itype=itype,  err = 6}, 9)
			return 
		end
		--加一个进度 扣除经验
		PI_PayPlayer(1,-needexp,0,0,'购买觉醒进度消耗')
		pdata[1] = pdata[1] + 1
	elseif itype == 2 then 
		if not CheckCost( sid , awakeconf.needyb,  1 , 1, "购买觉醒进度消耗") then
			SendLuaMsg(0, {ids=msg_awake,  itype=itype, err = 7}, 9)
			return
		end
		--加一个进度 扣除经验
		CheckCost( sid , awakeconf.needyb,  0, 1, "购买觉醒进度消耗") 
		pdata[1] = pdata[1] + 1
	end
	
	--检查进度 --进度已满
	local  needexp
	if pdata[1] == awakeconf.maxproc  then 
		RPCEx(sid, 'awake_succ')
	end
	--
	SendLuaMsg(0, {ids=msg_awake,  itype=itype, proc=pdata[1]}, 9)
end

--玩家飞升成功获取装备
local function _get_equip(sid)
	local pdata = GetAwakeData(sid)
	if pdata == nil then return end
	
	local lv = CI_GetPlayerData(1)		-- 玩家等级
	if lv < awakeconf.limitlevel then 
		SendLuaMsg(0, {ids=msg_equip, err = 9}, 9)
		return 
	end
	---
	if pdata[1] ~= awakeconf.maxproc then 
		SendLuaMsg(0, {ids=msg_equip, err = 9}, 9)
		return 
	end
	
	--装备是否已领取
	if pdata[2] == 1 then 
		SendLuaMsg(0, {ids=msg_equip, err = 10}, 9)
		return 
	end

	-- 检查背包
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,2))
		return
	end
	---
	local school =   CI_GetPlayerData(2)  --获取玩家职业
	local ret = GiveGoods(awakeconf.equip[school], 1, 1, '觉醒成功赠送的装备')
	if ret then 
		pdata[2] = 1
		SendLuaMsg(0, {ids=msg_equip}, 9)
	end
end

---
player_awake_data = _awake_data
player_get_equip = _get_equip