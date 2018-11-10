--[[
author:	csj
update:	2011-12-13
notes: 
[1] all checked file marked with 'done'.
]]--

Setboss_mark=Setboss_mark or 1 --服务器启动时执行一次标识
--------------------------------------------------------------
--include

local look = look
local pairs,ipairs,type = pairs,ipairs,type
local MonsterRegisterEventTrigger = MonsterRegisterEventTrigger
local common_time = require('Script.common.time_cnt')
local GetTimeThisDay = common_time.GetTimeThisDay
local GetWorldLevel=GetWorldLevel
local rand_mgr_m = require('Script.active.random_pos_manager')
local RandPosSys_Get = rand_mgr_m.RandPosSys_Get
local RandPosSys_GetAll = rand_mgr_m.RandPosSys_GetAll
local CI_SelectObject=CI_SelectObject
local RemoveObjectIndirect=RemoveObjectIndirect
local GetMonsterData=GetMonsterData
local tonumber=tonumber
local CreateObjectIndirect=CreateObjectIndirect
local MonsterEvents=MonsterEvents
local call_monster_dead=call_monster_dead
local GetWorldCustomDB=GetWorldCustomDB
local BroadcastRPC=BroadcastRPC
local CI_GetPlayerData=CI_GetPlayerData
local GetObjectUniqueId=GetObjectUniqueId
local RPC=RPC
local _G=_G
local UpdateChunJieData=UpdateChunJieData
---------------------------------------------------------------
--module:

module(...)

---------------------------------------------------------------
--data:

local WORLD_BOSS_ID = 10
local BOSS_DEAD_SCRIPT = 8

-- --boss 时间要同时配置在boss_time_conf和通用时间配置表
-- local boss_time_conf = 
-- {	
	-- [1] = {				-- 世界BOSS
		-- {11,0,0},
		-- {16,0,0},
		-- {22,0,0},
	-- },
-- }

-- RefreshNeedWLevel = {40,50} 世界等级 在 40，50之间才刷这种怪
-- 预留[1 ~ 10] 给世界Boss
local monster_group = { 
	--世界BOSS
	[1] = {												
			{ RandPosID = 1,extraScriptId=11, monsterId = 55, EventID = 1, eventScript = 1006,controlId = 10001,deadbody =6,  }, 										
			{ RandPosID = 2,extraScriptId=12, monsterId = 56, EventID = 1, eventScript = 1006,controlId = 10002,deadbody =6, }, 	
			{ RandPosID = 3,extraScriptId=12, monsterId = 57, EventID = 1, eventScript = 1006,controlId = 10003,deadbody =6, }, 
			{ RandPosID = 5,extraScriptId=12, monsterId = 60, EventID = 1, eventScript = 1006,controlId = 10004,deadbody =6, }, 
			{ RandPosID = 23,extraScriptId=12, monsterId = 61, EventID = 1, eventScript = 1006,controlId = 10005,deadbody =6, }, 
			{ RandPosID = 24,extraScriptId=12, monsterId = 62, EventID = 1, eventScript = 1006,controlId = 10006,deadbody =6, }, 
	},	
	
	--精英怪
	[2] = {												
			{ RandPosID = 6, monsterId = 375,controlId = 10011,deadbody =6,  }, 										
			{ RandPosID = 11, monsterId = 375,controlId = 10012,deadbody =6, }, 	
			{ RandPosID = 7, monsterId = 376,controlId = 10013,deadbody =6,  }, 										
			{ RandPosID = 12, monsterId = 376,controlId = 10014,deadbody =6, }, 	
			{ RandPosID = 8, monsterId = 377,controlId = 10015,deadbody =6,  }, 										
			{ RandPosID = 13, monsterId = 377,controlId = 10016,deadbody =6, }, 	
			{ RandPosID = 9, monsterId = 378,controlId = 10017,deadbody =6,  }, 										
			{ RandPosID = 14, monsterId = 378,controlId = 10018,deadbody =6, }, 	
			{ RandPosID = 10, monsterId = 379,controlId = 10019,deadbody =6,  }, 										
			{ RandPosID = 15, monsterId = 379,controlId = 10020,deadbody =6, }, 
			{ RandPosID = 16, monsterId = 380,controlId = 10021,deadbody =6, }, 	
			{ RandPosID = 17, monsterId = 381,controlId = 10022,deadbody =6, }, 	
			{ RandPosID = 18, monsterId = 382,controlId = 10023,deadbody =6, }, 	
			{ RandPosID = 19, monsterId = 383,controlId = 10024,deadbody =6, }, 				
			{ RandPosID = 25, monsterId = 384,controlId = 10025,deadbody =6, }, 				
			{ RandPosID = 26, monsterId = 385,controlId = 10026,deadbody =6, }, 
			{ RandPosID = 27, monsterId = 386,controlId = 10027,deadbody =6, }, 				
			{ RandPosID = 28, monsterId = 387,controlId = 10028,deadbody =6, }, 			
	},

}

--------------------------------------------------------------------
--inner:
--世界数据
local function getboss_worlddata()
	local wdata=GetWorldCustomDB()
	if wdata.boss==nil then
		wdata.boss={}
	end
	return wdata.boss
end

-- 怪物生成(时间配置表调用)
function Monster_Create( OBJ_Type )
	-- look('怪物生成(时间配置表调用)',1)
	if OBJ_Type==1 then 
		local wdata=GetWorldCustomDB()
		wdata.boss={}
	end
	
	local wlevel = GetWorldLevel() or 1
	local ok = true
	local monsters = monster_group[OBJ_Type]
	if monsters== nil then return end
	for k,v in ipairs(monsters) do	
		local isAlive = false
		local AllConf = RandPosSys_GetAll(v.RandPosID)
		for m, conf in ipairs(AllConf) do
			--look('conf.R:' .. conf.R)
			if (CI_SelectObject(6,v.controlId,conf.R) ~= nil and GetMonsterData( 6 ) == 0) then
				RemoveObjectIndirect(conf.R, v.controlId)
			end
			local a=CI_SelectObject(6,v.controlId,conf.R)
			if a >0 then
				isAlive = true
				break
			end
		end
		-- look('chulai ',1)
		-- 如果被杀了重新刷新
		if isAlive == false then
			-- look('如果被杀了重新刷新',1)
			if v.RefreshNeedWLevel and type(v.RefreshNeedWLevel) == type({}) then  --是否有世界等级限制
				if wlevel >= tonumber(v.RefreshNeedWLevel[1]) and wlevel < tonumber(v.RefreshNeedWLevel[2])	then
					ok = true
				else
					ok = false
				end
			else
				ok = true
			end
			if ok then
				local R, X, Y, Rnd = RandPosSys_Get(v.RandPosID, false)
				if v.BRMONSTER then
					v.centerX = X
					v.centerY = Y
				else
					-- look(123,1)
					-- look(X,1)
					-- look(Y,1)
					-- look(regionId,1)
					v.x = X
					v.y = Y
				end
				v.regionId = R
				
				-- 统一世界BOSS死亡脚本ID 8
				if tonumber(OBJ_Type) < WORLD_BOSS_ID then									
					v.deadScript = BOSS_DEAD_SCRIPT
				end
				-- look('Monster_Create',1)
				-- look(v,1)
				local GID = CreateObjectIndirect(v)
				-- look(GID,1)
				if GID and v.EventID and v.eventScript and v.eventScript >= 1 then
					MonsterRegisterEventTrigger(v.regionId, GID, MonsterEvents[v.eventScript])
				end
			end
		end	
		-- look('完成',1)
		if OBJ_Type==1 then 
			local wdata=GetWorldCustomDB()
			wdata.boss={}
			BroadcastRPC('boss_info',nil,nil,wdata.boss)
		end
		
	end
end

-- 移除BOSS(时间配置表调用)
function Monster_Remove( OBJ_Type )

	local monsters = monster_group[OBJ_Type]
	-- look(monsters)
	if monsters~= nil then
		for k,v in ipairs(monsters) do
		   --移除怪物
		  	local AllConf = RandPosSys_GetAll(v.RandPosID)
			for m, conf in ipairs(AllConf) do
				if CI_SelectObject(6, v.controlId, conf.R ) ~= nil  then	
					RemoveObjectIndirect(conf.R, v.controlId)
				end	
			end
		end
	end
end



--boss死亡回调
call_monster_dead[8]=function ()
	local _,ControlID= GetObjectUniqueId()
	local pname=CI_GetPlayerData(3)
	local bdata=getboss_worlddata()
	for k,v in pairs(monster_group[1]) do
		if ControlID==v.controlId then
			bdata[k]=1
			BroadcastRPC('boss_info',pname,k,bdata)
			break
		end
	end
	
end
--年兽boss死亡回调
call_monster_dead[9]=function ()
	local playerid=CI_GetPlayerData(17)
	local pname=CI_GetPlayerData(3)
	
	BroadcastRPC('ns_boss',pname)
	UpdateChunJieData(playerid,1,30)
end

--请求boss数据
function _getbossdata()
	local bdata=getboss_worlddata()
	RPC('boss_info',nil,nil,bdata)
end

--开服时数据清空--击杀状态
function _boss_serverstart(itype)
	if itype==1 then
		if  _G.Setboss_mark==1 then
			_G.Setboss_mark=2
		else
			return
		end	
	end
	local bdata=getboss_worlddata()
	local a=#monster_group[1]
	for i=1,a do
		bdata[i]=1
	end
end
------------------------------------------------------
--interface:
getbossdata=_getbossdata
boss_serverstart=_boss_serverstart
