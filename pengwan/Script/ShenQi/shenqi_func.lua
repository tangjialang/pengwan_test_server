--[[
file: shenqi_func.lua
desc: 神戒
autor: zld
]]--

--------------------------------------------------------
--include:
local __G = _G
local pairs, ipairs = pairs, ipairs
local math_floor, math_random = math.floor, math.random
local IsSpanServer = IsSpanServer
local CheckCost, CheckGoods, GiveGoods = CheckCost, CheckGoods, GiveGoods
local CI_GetCurPos = CI_GetCurPos
local CI_GetEquipDetails = CI_GetEquipDetails
local CI_GetPlayerData = CI_GetPlayerData
local CreateGroundItem = CreateGroundItem
local GI_GetPlayerData = GI_GetPlayerData
local RPC = RPC
local GetServerTime = GetServerTime
local look = look
local TipCenter, isFullNum = TipCenter, isFullNum
local _add_score = pres_add_score
local _get_preslv = get_preslv
local Getbuyfillinfo = Getbuyfillinfo
local CI_GetPlayerIcon = CI_GetPlayerIcon
local CI_SetPlayerIcon = CI_SetPlayerIcon
local bits = bits
local DBRPC = DBRPC
local GetGroupID = GetGroupID
local BroadcastRPC = BroadcastRPC
local os_date = os.date
local RegionTable = RegionTable
local GetStringMsg = GetStringMsg
db_module = require('Script.cext.dbrpc')
local db_log_shenqi_fight = db_module.db_log_shenqi_fight
local SendLuaMsg = SendLuaMsg
local GetRWData = GetRWData
local PI_UpdateScriptAtt = PI_UpdateScriptAtt
local GiveGoods = GiveGoods
local CheckGoods = CheckGoods
local ScriptAttType = ScriptAttType
--戒指返回
local jiezhi_ret = msgh_s2c_def[20][24]
local jiezhi_equip = msgh_s2c_def[20][25]
----------------------------------------------------------
--module:

module(...)

----------------------------------------------------------
--inner:
local needednum_conf = {1,1,1,1,1,1,1,1,2,3,4,5,6,7,8,10,12,14,16,18,20,25}
local drop_conf = {1,1,1,1,1,1,1,1,1,2,2,3,3,4,4,5,5,6,6,7,7}
local drop_yb_conf = {
	[1] = {1, 685},
	[2] = {4, 809},
	[3] = {20, 684},
}

local jiezhiConf= {
	[9915] = {
		[1]=1080000,        -- 气血数值
		[2]=456000,	    --属性攻击
		[3]=386000,	    --攻击
		[4]=270000,		--防御
		[5]=300000,	    -- 命中
		[6]=300000,        --闪避
		[7]=200000,	    --暴击
		[8]=182000,	    --抗暴
		[9]=176000,	    --格挡
		[10]=25800,		--火系抗击
		[11]=25800,		--冰系抗击
		[12]=25800,		--木系抗击
		[13]=0,  	    --移动速度
		[14]=9100,	    --抗性减免
	},
}


function GetPlayerShenQiData(sid)
	local shqdata=GI_GetPlayerData( sid , 'shq' , 150 )
	if shqdata == nil then return end
	--[[
		shqdata[806] = {	--左戒
			[1] = 0, 	--投保次数
			[2] = 0, 	--神器等级
			[3] = -1, 	--是否装备 0：未装备 1：已装备 其它：未获得
			[4] = 0,	--是否自动投保 0：不是  1：是
		},
		shqdata[807] = {	--右戒
			[1] = 0,	--投保次数
			[2] = 0,	--神器等级
			[3] = -1,	--是否装备 0：未装备 1：已装备
			[4] = 0,	--是否自动投保
		},
		[戒指ID] ={
				[3] = 1 or  0 | nil ---- 1 表示戴上了该戒指
		},
		shqdata.starttime = 0,  --记录开启时间
		shqdata.dts = 0,
	--]]
	return shqdata
end

-- 神器投保
local function _shenqi_PICC(itype, shqid, times)
	-- look('**************_shenqi_PICC start*********')
	local sid = CI_GetPlayerData(17)
	if sid == nil or shqid == nil or itype == nil or times == nil then return end
	local shqdata = GetPlayerShenQiData(sid)
	if shqdata == nil then return end
	if shqdata[shqid] == nil then return end
	if itype == 1 then
		if times > 0 then
			if not __G.CheckCost( sid, 99*times, 0, 1, "神器投保") then return end
		end
		-- 投保次数
		shqdata[shqid][1] = (shqdata[shqid][1] or 0) + times
		if shqdata[shqid][1] <= 0 then
			shqdata[shqid][1] = 0
		end
		RPC('ring_picc', 1, shqid, shqdata[shqid][1])
	end
	-- look('**************_shenqi_PICC end*********')
end

local function _shenqi_PICC_aoto(shqid, isAoto)
	-- look('************isAoto start************')
	local sid = CI_GetPlayerData(17)
	if sid == nil or shqid == nil then return end
	local shqdata = GetPlayerShenQiData(sid)
	if shqdata == nil then return end
	if shqdata[shqid] == nil then return end
	if isAoto and isAoto == 1 then
		shqdata[shqid][4] = 1
	else
		shqdata[shqid][4] = 0
	end
	-- look(isAoto)
	-- look('***********isAoto end************')
end

-- 神器强化
local function _shenqi_enhance(itype, shqid)
	local sid = CI_GetPlayerData(17)
	if sid == nil and itype == nil then return end
	local shqdata = GetPlayerShenQiData(sid)
	if shqdata == nil then return end
	if shqdata[shqid] == nil then return end
	look('**********_shenqi_enhance start************',2)
	if shqdata[shqid][2] == nil then return end
	 
	 
	local oldlv = shqdata[shqid][2] --取强化等级
	if oldlv >= 250 then return end
	local newlv = oldlv + 1
	if itype == 1 then
		local templv = math_floor((oldlv - 50)/10) + 2
		if templv <= 0 then
			templv = 1
		end
		local needednum = needednum_conf[templv + 1]
		look(newlv,1)
		look(templv,1)
		look(needednum,1)
		if CheckGoods(805, needednum, 0, sid, '神器强化') == 1 then
			look('CheckGoods',2)	
			shqdata[shqid][2] = newlv
			RPC('ring_enhc', shqid, newlv)
			SetShenQiIcon(sid)
		end
	end
	look('**********_shenqi_enhance end************',2)
end

-- 获得神器
local function _shenqi_get_ring(sid, itype, shqid)
	-- look('*********_shenqi_get_ring start***********',1)
	if sid == nil or itype == nil or shqid == nil then return end
	local shqdata = GetPlayerShenQiData(sid)
	if shqdata == nil then return end
	shqdata[shqid] = shqdata[shqid] or {}
	if shqdata[shqid][3] and shqdata[shqid][3] ~= -1 then return end
	if itype == 1 then
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		GiveGoods(shqid, 1, 1, "给戒指")
		
		if shqdata[shqid][2] then
			if shqdata[shqid][2] < 100 then
				shqdata[shqid][2] = 100
			else
				shqdata[shqid][2] = shqdata[shqid][2]
			end
		else
			shqdata[shqid][2] = 100
		end
		if shqdata[shqid][3] == nil or shqdata[shqid][3] == -1 then
			shqdata[shqid][3] = 0
		elseif shqdata[shqid][3] == 1 then
			shqdata[shqid][3] = 1
		end
		RPC('ring_have', shqid, shqdata[shqid][2], shqdata[shqid][3])
		-- look(shqdata,1)
		-- look('*********_shenqi_get_ring end***********',1)
	end
end

-- 死亡惩罚
local function _shenqi_dead_punishment(rid, sid, mapGID, killerid)
	-- look('*********_shenqi_dead_punishment start***********',1)
	if rid == nil or sid == nil or mapGID == nil then return end
	local PKLost = RegionTable[rid].PKLost
	if PKLost == nil then return end
	local shqdata = GetPlayerShenQiData(sid)
	if shqdata == nil then return end
	local shqid = 806
	local rd = math_random(10)
	if rd <= 5 then
		shqid = 806
	else
		shqid = 807
	end
	if shqdata[806] and shqdata[806][3] and shqdata[806][3] == 1 and (shqdata[807] == nil or shqdata[807][3] == nil or shqdata[807][3] == -1) then
		shqid = 806
	elseif shqdata[807] and shqdata[807][3] and shqdata[807][3] == 1 and (shqdata[806] == nil or shqdata[806][3] == nil or shqdata[806][3] == -1) then
		shqid = 807
	end
	-- look('shqid = ' .. shqid, 1)
	if shqdata[shqid] == nil then return end
	if shqdata[shqid][3] == nil or shqdata[shqid][3] == 0 or shqdata[shqid][3] == -1 then return end

	local px, py = CI_GetCurPos(2, sid)
	local isAoto = shqdata[shqid][4] or 0
	local oldlv = shqdata[shqid][2] or 0 --取强化等级
	local newlv = oldlv - 1
	if newlv <= 49 then
		newlv = 49
	end
	local prob = math_floor(oldlv/5)
	if oldlv < 50 then
		prob = 0 
	end
	local rand = math_random(100)
	-- prob = 10
	-- rand = 10
	-- look('********************prob = ' .. prob, 1)
	-- look('********************rand = ' .. rand, 1)
	shqdata.dts = (shqdata.dts or 0) - 1
	
	if shqdata.dts < 0 and rand <= prob then
		local picc_times = shqdata[shqid][1] or 0	--这里取已有的投保次数
		if picc_times <= 0 then
			if isAoto == 1 and __G.CheckCost( sid, 99, 1, 1, "神器投保") then
				__G.CheckCost( sid, 99, 0, 1, "神器投保")
				local killername = CI_GetPlayerData(5, 2, killerid)
				RPC('ring_pdead', 1, shqid, killername, shqdata[shqid][1])
				local count = 0
				for i = 1, 3 do	--掉元宝
					for k = 1, drop_yb_conf[i][1] do
						CreateGroundItem(0, mapGID, drop_yb_conf[i][2], 1, px, py, count)
						count = count + 1
					end
				end
			else 
				local delnum = math_floor((oldlv - 50)/10) + 1
				shqdata[shqid][2] = newlv
				if delnum < 1 then return end
				local killername = CI_GetPlayerData(5, 2, killerid)
				RPC('ring_pdead', 0, shqid, killername, newlv)
				local count = 0
				for i = 1, drop_conf[delnum] do	--掉碎片
					CreateGroundItem(0, mapGID, 805, 1, px, py, count)
					count = count + 1
				end
				SetShenQiIcon(sid)
			end
		else
			-- 减少投保次数
			picc_times = picc_times - 1
			shqdata[shqid][1] = picc_times
			local killername = CI_GetPlayerData(5, 2, killerid)
			RPC('ring_pdead', 1, shqid, killername, shqdata[shqid][1])
			local count = 0
			
			for i = 1, 3 do	--掉元宝
				for k = 1, drop_yb_conf[i][1] do
					CreateGroundItem(0, mapGID, drop_yb_conf[i][2], 1, px, py, count)
					count = count + 1
				end
			end
		end
		shqdata.dts = 5
	end
	-- look('*********_shenqi_dead_punishment end***********')
end

-- 装备神器
local function _shenqi_equip(sid, itype, shqid, isequip)
	if sid == nil or itype == nil or shqid == nil then return end
	local shqdata = GetPlayerShenQiData(sid)
	if shqdata == nil then return end
	if shqdata[shqid] == nil then return end
	-- look('*********_shenqi_equip start*********')
	if itype == 1 then
		if isequip == 0 then
			if shqdata[shqid][3] and shqdata[shqid][3] ~= 0 then return end
			if 0 == CheckGoods(shqid, 1, 0, sid, '扣戒指') then return end
			if shqdata[shqid][3] == nil or shqdata[shqid][3] == 0 then
				shqdata[shqid][3] = 1
			end
			local shqlv = shqdata[shqid][2] or 0
			if shqlv <= 0 then
				shqdata[shqid][2] = 100
				shqlv = 100
			end
			RPC('ring_equip', isequip, shqid, shqlv)
		else
			if shqdata[shqid][3] ~= 1 then return end
			local pakagenum = isFullNum()
			if pakagenum < 1 then
				TipCenter(GetStringMsg(14,1))
				return 0
			end
			GiveGoods(shqid, 1)
			if shqdata[shqid][3] == nil or shqdata[shqid][3] == 1 then
				shqdata[shqid][3] = 0
			end		
			RPC('ring_equip', isequip, shqid, shqlv)
		end
		SetShenQiIcon(sid)
	end
	-- look('*********_shenqi_equip end*********')
end

local function _shenqi_get_starttime()
	-- look('**********_shenqi_get_starttime start**************',1)
	local sid = CI_GetPlayerData(17)
	if sid == nil then return end
	local shqdata = GetPlayerShenQiData(sid)
	if shqdata == nil then return end
	local tm = GetServerTime()
	-- look(tm,1)
	if shqdata.starttime == nil then
		shqdata.starttime = tm - 60
		local serverid = GetGroupID()
		local accout = CI_GetPlayerData(15)
		local rolename = CI_GetPlayerData(5)
		local level = CI_GetPlayerData(1)
		local fight = CI_GetPlayerData(62)
		db_log_shenqi_fight(serverid, accout, sid, rolename,level, fight, shqdata.starttime)
	end
	-- look(shqdata.starttime,1)
	return shqdata.starttime
end

local function _SetShenQiIcon(sid)
	-- look('**********_SetShenQiIcon***************')
	if sid == nil then return end
	local shqdata = GetPlayerShenQiData(sid)
	if shqdata == nil then return end
	local num = 0
	if shqdata[806] and shqdata[806][3] and shqdata[806][3] == 1 then
		if shqdata[806][2] and shqdata[806][2] >= 50 then
			num = num + 1
		end			
	end
	if shqdata[807] and shqdata[807][3] and shqdata[807][3] == 1 then
		if shqdata[807][2] and shqdata[807][2] >= 50 then
			num = num + 1
		end
	end	
	-- look(num)
	local srcIcon = CI_GetPlayerIcon(3,4)
	srcIcon = bits.set(srcIcon, 1, 3, num)
	
	CI_SetPlayerIcon(3,4,srcIcon)
end

local function _shenqi_init(sid, shqid)
	if sid == nil or shqid == nil then return end
	if shqid == 806 or shqid == 807 then
		local shqdata = GetPlayerShenQiData(sid)
		if shqdata == nil then return end
		shqdata[shqid] = shqdata[shqid] or {}
		if shqdata[shqid][3] and shqdata[shqid][3] ~= -1 then return end
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		
		if shqdata[shqid][2] then
			if shqdata[shqid][2] < 100 then
				shqdata[shqid][2] = 100
			else
				shqdata[shqid][2] = shqdata[shqid][2]
			end
		else
			shqdata[shqid][2] = 100
		end
		if shqdata[shqid][3] == nil or shqdata[shqid][3] == -1 then
			shqdata[shqid][3] = 0
		elseif shqdata[shqid][3] == 1 then
			shqdata[shqid][3] = 1
		end
		-- look('******************_shenqi_init start*****************',1)
		-- look(shqid,1)
		-- look(shqdata[shqid][2],1)
		-- look(shqdata[shqid][3],1)
		RPC('ring_have', shqid, shqdata[shqid][2], shqdata[shqid][3])
		-- look('******************_shenqi_init end*****************',1)
	end
end

local function _shenqi_get(sid,itype,index)
	-- look('***********_shenqi_get start*********',1)
	if sid == nil or index == nil then return end
	local begintime = _shenqi_get_starttime()
	local endtime = GetServerTime()
	if begintime == nil or endtime == nil then
		look('shenqi get time error')
		return
	end
	local serverid = GetGroupID()
	local begintime = os_date("%Y/%m/%d  %H:%M:%S", begintime)
	local endtime = os_date("%Y/%m/%d  %H:%M:%S", endtime)
	-- look('get_shenqi_ring',1)
	-- look(begintime,1)
	-- look(endtime,1)
	local call = { dbtype = 2, sp = 'N_ActivityPayBuyPoint' , args = 5, [1] = sid,[2] = serverid,[3] = begintime,[4] = endtime,[5]=1}
	local callback = { callback = 'CALLBACK_GetRinginfo', args = 3, [1] = sid,[2] = "?6", [3] = index }
	DBRPC( call, callback )
	-- look('***********_shenqi_get end*********',1)
end


--------------------------------------------------
--获取玩家二级属性
local function get_attup(sid)
	local pdata = GetPlayerShenQiData(sid)
	if pdata == nil then return end 
	--戒指临时属性
	local attTb = {}
	for key, value in pairs(pdata) do 
		if jiezhiConf[key] ~= nil and value ~= nil and value[3] == 1 then 
			if jiezhiConf[key] ~= nil  then 
				for k, v in pairs(jiezhiConf[key]) do 
					attTb[k] = (attTb[k] or 0) + v
				end
			end
		end
	end
	return attTb
end

--玩家上线时 获取二级属性
local function _login_get_attup(sid)
	local attTb = get_attup(sid)
	if attTb == nil then return false end
	local AttTb = GetRWData(1)
	--属性
	for key, value in pairs(attTb) do
		AttTb[key] = (AttTb[key] or 0)  + value
	end
	return true
end

--更新玩家属性
local  function update_attup(sid)
	local ret = _login_get_attup(sid)
	if ret then 
		__G.PI_UpdateScriptAtt(sid, __G.ScriptAttType.jiezhi)
	end
end

--装备戒指
local function _equip_jiezhi(sid, id)
	local pdata = GetPlayerShenQiData(sid)
	if pdata == nil then return end 
	
	--检查是否已装备
	--检查是否符合配置里的道具ID
	if pdata[id] ~= nil and (pdata[id][3] or 0)  == 1 then 
		SendLuaMsg(0, {ids=jiezhi_equip, id=id, err= 12 }, 9)
		return 
	end
	--- 
	if jiezhiConf[id] == nil then  return end
	
	--
	if 0 == CheckGoods(id,1,1, sid, "装备傲视戒指消耗") then return end
	--扣除道具
	local ret = CheckGoods(id,1,0, sid, "装备傲视戒指消耗")
	if  ret then 
		--装备成功 更新玩家属性
		SendLuaMsg(0, {ids=jiezhi_equip, id=id}, 9)
		pdata[id] = pdata[id] or {}
		pdata[id][3] = 1
		update_attup(sid)
	end
end

--脱下傲视戒指
local function _jiezhi_unload(sid, id)
	local pdata = GetPlayerShenQiData(sid)
	if pdata == nil then return end 
	--检查是否已装备
	--检查背包是否已满
	--脱下成功, 更新属性
	--- 
	if jiezhiConf[id] == nil then  return end
	if pdata[id] ~= nil and (pdata[id][3] or 0)  ~= 1 then  
		SendLuaMsg(0, {ids=jiezhi_ret, id=id, err= 11}, 9)
		return 
	end
	--
	local pakagenum = isFullNum()
	if 1 > pakagenum then 
		TipCenter(GetStringMsg(14,1))
		return 
	end
	local ret = GiveGoods(id, 1, 1, sid, "脱下傲视戒指获得")
	if ret then 
		SendLuaMsg(0, {ids=jiezhi_ret, id=id}, 9)
		pdata[id][3] = 0
		update_attup(sid)
	end
end
--------------------------------------------------------------------------
-- interface:

shenqi_PICC = _shenqi_PICC
shenqi_PICC_aoto = _shenqi_PICC_aoto
shenqi_enhance = _shenqi_enhance
shenqi_get = _shenqi_get
shenqi_init = _shenqi_init
shenqi_get_ring = _shenqi_get_ring
shenqi_equip = _shenqi_equip
shenqi_get_starttime = _shenqi_get_starttime
SetShenQiIcon = _SetShenQiIcon
shenqi_dead_punishment = _shenqi_dead_punishment
--
login_get_attup = _login_get_attup
equip_jiezhi = _equip_jiezhi
jiezhi_unload = _jiezhi_unload
