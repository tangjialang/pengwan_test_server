--[[
file: Begin_Proc.lua
desc: 副本开始处理函数
]]--

local pairs,type = pairs,type
local look = look
local math_random = math.random
local CreateObjectIndirect = CreateObjectIndirect

-- 材料副本初始怪物坐标点
local cl_random_pos = {
	{12,19},
	{14,19},
	{16,19},
	{13,29},
	{19,25},
}

local _csBeginProcTb = {
	[1001] = function(fbID,copyScene)
		RPC('showNewTalk',1)
		CI_AddBuff(351,0,1,false)
	end,
	[1006] = function(fbID,copyScene)
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <= 0 then return end
		local ret = PI_PayPlayer(4,300,0,0,'副本演示',2,sid)
	end,
	
	[10001] = function(fbID,copyScene)
		if fbID == nil or copyScene == nil then return end
		local DynmicSceneMap = copyScene.DynamicSceneGIDList[1]
		if DynmicSceneMap == nil then return end
		local mon_list
		if DynmicSceneMap.MonsterList then	
			mon_list = DynmicSceneMap.MonsterList[102]		-- 取102波怪
		end
		if mon_list == nil then return end
		local mon_conf
		for i = 1, 5 do
			local rd  = math_random(1,10000)
			if rd <= 5000 then
				mon_conf = mon_list[1]				
			elseif rd <= 8000 then
				mon_conf = mon_list[2]
			elseif rd <= 10000 then
				mon_conf = mon_list[3]
			end
			mon_conf.copySceneGID = copyScene.CopySceneGID
			mon_conf.regionId = DynmicSceneMap.dynamicMapGID
			mon_conf.x = cl_random_pos[i][1]
			mon_conf.y = cl_random_pos[i][2]
			local GID = CreateObjectIndirect(mon_conf)
			look('mon_gid:' .. tostring(GID))
		end
	end,
	[17001] = function(fbID,copyScene) ysfb_begin(fbID,copyScene,1) end,
	[17002] = function(fbID,copyScene) ysfb_begin(fbID,copyScene,2) end,
	[17003] = function(fbID,copyScene) ysfb_begin(fbID,copyScene,3) end,
	[17004] = function(fbID,copyScene) ysfb_begin(fbID,copyScene,4) end,
	[17005] = function(fbID,copyScene) ysfb_begin(fbID,copyScene,5) end,
	[17006] = function(fbID,copyScene) ysfb_begin(fbID,copyScene,6) end,
	[17007] = function(fbID,copyScene) ysfb_begin(fbID,copyScene,7) end,
	
	
	
	--测试副本
	[999001] = function(fbID,copyScene) 
		local _monster = {
				{ monsterId = 9,monAtt={[1] =99999999,},moveArea = 0,searchArea=0 ,refreshTime=1,deadbody = 0 ,camp = 4, },
				{ monsterId = 12,monAtt={[1] =99999999,},moveArea = 0,searchArea=0 ,refreshTime=1,deadbody = 0,camp = 4, },
				{ monsterId = 10,monAtt={[1] =99999999,},moveArea = 0,searchArea=10 ,refreshTime=1,deadbody = 0,camp = 4, },
				
				{ monsterId = 20,monAtt={[1] =99999999,},moveArea = 0,searchArea=0 ,refreshTime=1,deadbody = 0,camp = 5, },
				{ monsterId = 18,monAtt={[1] =99999999,},moveArea = 0,searchArea=0 ,refreshTime=1,deadbody = 0,camp = 5, },
				{ monsterId = 19,monAtt={[1] =99999999,},moveArea = 0,searchArea=0 ,refreshTime=1,deadbody = 0,camp = 5, },
			}
		local _mon
		if fbID == nil or copyScene == nil then return end
		local DynmicSceneMap = copyScene.DynamicSceneGIDList[1]

		
		for i = 1, 10 do
			_mon = _monster[1]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 16+i*2
			_mon.y = 93
			_mon.dir = 0
			_mon.controlID = 1000+i
			CreateObjectIndirect(_mon)
		end
		for i = 1, 10 do
			_mon = _monster[2]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 16+i*2
			_mon.y = 95
			_mon.dir = 0
			_mon.controlID = 1015+i
			CreateObjectIndirect(_mon)
		end
		for i = 1, 10 do
			_mon = _monster[3]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 16+i*2
			_mon.y = 97
			_mon.dir = 0
			_mon.controlID = 1030+i
			CreateObjectIndirect(_mon)
		end
		for i = 1, 10 do
			_mon = _monster[4]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 16+i*2
			_mon.y = 85
			_mon.dir = 4
			_mon.controlID = 1045+i
			CreateObjectIndirect(_mon)
		end
		for i = 1, 10 do
			_mon = _monster[5]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 16+i*2
			_mon.y = 83
			_mon.dir = 4
			_mon.controlID = 1060+i
			CreateObjectIndirect(_mon)
		end
		for i = 1, 10 do
			_mon = _monster[6]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 16+i*2
			_mon.y = 81
			_mon.dir = 4
			_mon.controlID = 1075+i
			CreateObjectIndirect(_mon)
		end
		--------------------------
		for i = 1, 10 do
			_mon = _monster[1]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 48
			_mon.y = 123+i*2
			_mon.dir = 2
			_mon.controlID = 1100+i
			CreateObjectIndirect(_mon)
		end
		for i = 1, 10 do
			_mon = _monster[2]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 46
			_mon.y = 123+i*2
			_mon.dir = 2
			_mon.controlID = 1115+i
			CreateObjectIndirect(_mon)
		end
		for i = 1, 10 do
			_mon = _monster[3]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 44
			_mon.y = 123+i*2
			_mon.dir = 2
			_mon.controlID = 1130+i
			CreateObjectIndirect(_mon)
		end
		for i = 1, 10 do
			_mon = _monster[4]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 52
			_mon.y = 123+i*2
			_mon.dir = 6
			_mon.controlID = 1145+i
			CreateObjectIndirect(_mon)
		end
		for i = 1, 10 do
			_mon = _monster[5]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 54
			_mon.y = 123+i*2
			_mon.dir = 6
			_mon.controlID = 1160+i
			CreateObjectIndirect(_mon)
		end
		for i = 1, 10 do
			_mon = _monster[6]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 56
			_mon.y = 123+i*2
			_mon.dir = 6
			_mon.controlID = 1175+i
			CreateObjectIndirect(_mon)
		end
		
		--------------------------
		for i = 1, 10 do
			_mon = _monster[1]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 61+i
			_mon.y = 71+i
			_mon.dir = 1
			_mon.controlID = 1200+i
			CreateObjectIndirect(_mon)
		end
		for i = 1, 10 do
			_mon = _monster[2]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 59+i
			_mon.y = 73+i
			_mon.dir = 1
			_mon.controlID = 1215+i
			CreateObjectIndirect(_mon)
		end
		for i = 1, 10 do
			_mon = _monster[3]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 57+i
			_mon.y = 75+i
			_mon.dir = 1
			_mon.controlID = 1230+i
			CreateObjectIndirect(_mon)
		end
		for i = 1, 10 do
			_mon = _monster[4]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 65+i
			_mon.y = 67+i
			_mon.dir = 5
			_mon.controlID = 1245+i
			CreateObjectIndirect(_mon)
		end
		for i = 1, 10 do
			_mon = _monster[5]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 67+i
			_mon.y = 65+i
			_mon.dir = 5
			_mon.controlID = 1260+i
			CreateObjectIndirect(_mon)
		end
		for i = 1, 10 do
			_mon = _monster[6]
			_mon.copySceneGID = copyScene.CopySceneGID
			_mon.regionId = DynmicSceneMap.dynamicMapGID	
			_mon.x = 69+i
			_mon.y = 63+i
			_mon.dir = 5
			_mon.controlID = 1275+i
			CreateObjectIndirect(_mon)
		end
		
	end,
	
	--测试副本
	[999002] = function(fbID,copyScene) 
		if fbID == nil or copyScene == nil then return end
		local DynmicSceneMap = copyScene.DynamicSceneGIDList[1]
		local _mon = { monsterId = 9,searchArea=7 ,moveArea = 5,deadbody = 5 ,targetID = 1,deadScript = 1001,dir = 6 }
		local _x = 60
		
		_mon.copySceneGID = copyScene.CopySceneGID
		_mon.regionId = DynmicSceneMap.dynamicMapGID	
		
		for ix = 1, 30 do
			for iy = 1, 6 do
				_mon.x = 14 + (ix - 1)*2
				_mon.y = 10 + (iy - 1)*2	
				if _mon.x >= _x then
					break
				else
					CreateObjectIndirect(_mon)
				end
			end
		end
		
	end,
}

local define = require('Script.cext.define')
local EquipItemInfo = define.EquipItemInfo

local skillIDs = {
	[1] = {0,1,2,5},
	[2] = {0,11,12,15},
	[3] = {0,21,22,25},
}

local skillLVs = {
	[1] = {1,3,4,5},
	[2] = {1,3,4,5},
	[3] = {1,3,4,5},
}

function ysfb_begin(fbID,copyScene,level)
		if fbID == nil or copyScene == nil then return end
		local DynmicSceneMap = copyScene.DynamicSceneGIDList[1]
		if DynmicSceneMap == nil then return end
		local mon_conf = DynmicSceneMap.MonsterList[102][1]
		mon_conf.copySceneGID = copyScene.CopySceneGID
		mon_conf.regionId = DynmicSceneMap.dynamicMapGID
		
		local sid = CI_GetPlayerData(17)
		local sex = CI_GetPlayerData(11)
		local school=CI_GetPlayerData(2)
		local tsData = CI_GetPlayerTSData(sid)
		mon_conf.level = tsData[1][2]
		local equip = EquipItemInfo[20 + (level-1)*10][1][school]
		if sex == 0 then
			mon_conf.headID = equip[2]
		else
			mon_conf.headID = equip[1]
		end
		mon_conf.imageID = equip[3]

		-- local skillIDs = {0}
		-- local skillLVs = {1}
		-- for k, v in pairs(tsData[3][1]) do
			-- if type(v) == type(0) and v ~= 0 then
				-- table.insert(skillIDs,v)
				-- table.insert(skillLVs,tsData[3][2][k])
			-- end
		-- end
		
		mon_conf.bossType =tsData[1][8]
		mon_conf.skillID = skillIDs[school]
		mon_conf.skillLevel = skillLVs[school]
		mon_conf.aiType = 71
		local GID = CreateObjectIndirect(mon_conf)
		-- look(mon_conf,1)
		
end
csBeginProcTb = _csBeginProcTb