--[[
file:	Event_CallBack.lua
desc:	monster's event callback conf.
author:	chal
update:	2011-12-05
update: clear 2013-05-25 
]]--

--[[
	动态修改怪物数据
	CI_UpdateMonsterData (type,...)
	1: 更新属性 参数就是上面那些
	2: 指定怪物帮派 - factonname
	3：给怪物指定一个临时技能 skillid, count(连续触发次数)
]]--

--------------------------------------------------------------------------
--include:
local mathrandom = math.random
local look = look
local CreateObjectIndirect = CreateObjectIndirect
local CI_UpdateMonsterData = CI_UpdateMonsterData
local CI_GetCurPos = CI_GetCurPos
--------------------------------------------------------------------------
--inner:
local monster_event_trigger = {
	
}

local Boss_Call_Monster = {
	[1] = { 
			{ controlId = 103, IdleTime = 10, monsterId = 47, BRMONSTER = 1, centerX = 14 , centerY = 28 , BRArea = 4 , BRNumber =5 , deadbody = 6 },	
	},	
	--1009哪吒
	[2] = { 
			{ monsterId = 59, BRMONSTER = 1 ,  deadbody = 6 , centerX = 27 ,centerY = 22,BRArea = 1 , BRNumber =1 , camp = 4, targetX = 18, targetY = 24, controlId = 201, },	
	},	
	--1005哪吒
	[3] = { 
			{ monsterId = 59, BRMONSTER = 1 ,  deadbody = 6 , centerX = 37 ,centerY = 19,BRArea = 1 , BRNumber =1 , camp = 4, targetX = 46, targetY = 10, controlId = 201, },	
	},	
	--帮会神兽召唤
	[4] = { 
			{ monsterId = 270, monAtt={[1] =3,[3] =30000},aiType = 1027 , BRMONSTER = 1 ,  deadbody = 6 , centerX = 14 ,centerY = 12,BRArea = 5 , BRNumber =5 , },	
	},
	--帮会神兽召唤
	[5] = { 
			{ monsterId = 270, monAtt={[1] =3,[3] =30000},aiType = 1027 ,BRMONSTER = 1 ,  deadbody = 6 , centerX = 14 ,centerY = 12,BRArea = 5 , BRNumber =5 , },	
	},
	--神创加血怪
	[6] = { 
			{ monsterId = 512, BRMONSTER = 1 ,  Priority_Except ={ selecttype = 1 , type = 4 , target = 1000 } ,deadbody = 6 , centerX = 15 ,centerY = 24,BRArea = 2 , BRNumber =1 , },	
	},
	--神创护主怪
	[7] = { 
			{ monsterId = 491, BRMONSTER = 1 ,  Priority_Except ={ selecttype = 1 , type = 4 , target = 1001 } ,deadbody = 6 , centerX = 15 ,centerY = 24,BRArea = 2 , BRNumber =1 , },	
	},
	--神创眩晕怪
	[8] = { 
			{ monsterId = 493, BRMONSTER = 1 ,  Priority_Except ={ selecttype = 1 , type = 5 , target = 1002 } ,deadbody = 6 , centerX = 15 ,centerY = 24,BRArea = 2 , BRNumber =1 , },	
	},
	--35组队加血怪
	[9] = { 
			{ monsterId = 512, BRMONSTER = 1 ,  controlId=100,Priority_Except ={ selecttype = 1 , type = 4 , target = 1003 } ,deadbody = 6 , centerX = 10 ,centerY = 93,BRArea = 4 , BRNumber =2 , },	
	},
	--40组队眩晕怪
	[10] = { 
			{ monsterId = 493, BRMONSTER = 1 ,  Priority_Except ={ selecttype = 1 , type = 5 , target = 1004 } ,deadbody = 6 , centerX = 32 ,centerY = 26,BRArea = 2 , BRNumber =1 , },	
	},
		--帮会boss加血怪
	[11] = { 
			{ monsterId = 512, BRMONSTER = 1 ,  Priority_Except ={ selecttype = 1 , type = 4 , target = 1005 } ,deadbody = 6 , centerX = 14 ,centerY = 12,BRArea = 4 , BRNumber =3 , },	
	},
	--45组队召唤
	[12] = { 
			{ monsterId = 197, monAtt={[1] =5,[3] =1000},aiType = 1027 , controlId=100,BRMONSTER = 1 ,  deadbody = 6 , centerX = 49 ,centerY = 12,BRArea = 4 , BRNumber =5 , },	
	},
		--神创加血怪
	[13] = { 
			{ monsterId = 512, BRMONSTER = 1 ,  Priority_Except ={ selecttype = 1 , type = 4 , target = 1006 } ,deadbody = 6 , centerX = 15 ,centerY = 24,BRArea = 2 , BRNumber =2 , },	
	},
}

local function Boss_Call_MonsterFun(num,x,y,r)
	local mon = Boss_Call_Monster[num][mathrandom(1,#Boss_Call_Monster[num])]
	if mon then
		mon.regionId = r
		mon.centerX = x
		mon.centerY = y
		look(mon)
		local GID = CreateObjectIndirect(mon)
		look(GID)
	end
end

monster_event_trigger[1] = function ()
	look('OnMonsterTrigger1')
	local ret = CI_UpdateMonsterData(3,48,1,1,3)
end

monster_event_trigger[2] = function ()
	look('OnMonsterTrigger2')
	local ret = CI_UpdateMonsterData(3,56,1,1,3)
end

monster_event_trigger[3] = function ()
	look('OnMonsterTrigger3')
	local ret = CI_UpdateMonsterData(3,56,1,3,3) 
end

monster_event_trigger[4] = function ()
	look('OnMonsterTrigger4')
	local ret = CI_UpdateMonsterData(3,85,1,1,3)
end

monster_event_trigger[5] = function ()
	look('OnMonsterTrigger5')
	local ret = CI_UpdateMonsterData(3,86,1,1,3) 
end

monster_event_trigger[6] = function ()
	look('OnMonsterTrigger6')
	local ret = CI_UpdateMonsterData(3,88,1,1,3) 
end

monster_event_trigger[7] = function ()
	look('OnMonsterTrigger7')
	local ret = CI_UpdateMonsterData(3,87,1,1,3) 
end

monster_event_trigger[8] = function ()
	look('OnMonsterTrigger8')
	local x,y,rid,mapGID = CI_GetCurPos(3)
	look(x)
	look(y)
	look(rid)
	look(mapGID)
	if mapGID then
		Boss_Call_MonsterFun(2,27,22,mapGID)
	else
		Boss_Call_MonsterFun(2,27,22,rid)
	end
end

monster_event_trigger[9] = function ()
	look('OnMonsterTrigger9')
	local x,y,rid,mapGID = CI_GetCurPos(3)
	look(x)
	look(y)
	look(rid)
	look(mapGID)
	if mapGID then
		Boss_Call_MonsterFun(3,37,19,mapGID)
	else
		Boss_Call_MonsterFun(3,37,19,rid)
	end
end

monster_event_trigger[10] = function ()
	local x,y,rid,mapGID = CI_GetCurPos(3)
	if mapGID == nil then return end
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then return end
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp == nil or pCSTemp.CopySceneGID == nil then return end
	local copyScene = CS_GetTemp(pCSTemp.CopySceneGID)
	if copyScene==nil then return end
	local money = math.random(501,2600)
	RPC('met_givemoney',money)
	copyScene.getm = (copyScene.getm or 0) + money
	GiveGoods(0,money,0,'宝箱掉落')
	-- look('copyScene.getm:' .. copyScene.getm)
end



monster_event_trigger[11] = function ()
	look('OnMonsterTrigger11')
	local x,y,rid,mapGID = CI_GetCurPos(3)
	look(x)
	look(y)
	look(rid)
	look(mapGID)
	for i = 1,50 do
		if mapGID then
			CreateGroundItem(0,mapGID,0,10000,x,y,i)
		end
	end
end


monster_event_trigger[12] = function ()
	look('OnMonsterTrigger12')
	local x,y,rid,mapGID = CI_GetCurPos(3)
	look(x)
	look(y)
	look(rid)
	look(mapGID)
	if mapGID then
		Boss_Call_MonsterFun(4,14,12,mapGID)
	else
		Boss_Call_MonsterFun(4,14,12,rid)
	end
end

monster_event_trigger[14] = function ()
	look('OnMonsterTrigger14')
	local x,y,rid,mapGID = CI_GetCurPos(3)
	look(x)
	look(y)
	look(rid)
	look(mapGID)
	if mapGID then
		Boss_Call_MonsterFun(6,x,y,mapGID)
	else
		Boss_Call_MonsterFun(6,x,y,rid)
	end
end

monster_event_trigger[15] = function ()
	look('OnMonsterTrigger15')
	local x,y,rid,mapGID = CI_GetCurPos(3)
	look(x)
	look(y)
	look(rid)
	look(mapGID)
	if mapGID then
		Boss_Call_MonsterFun(7,15,24,mapGID)
	else
		Boss_Call_MonsterFun(7,15,24,rid)
	end
end

monster_event_trigger[16] = function ()
	look('OnMonsterTrigger16')
	local x,y,rid,mapGID = CI_GetCurPos(3)
	look(x)
	look(y)
	look(rid)
	look(mapGID)
	if mapGID then
		Boss_Call_MonsterFun(8,15,24,mapGID)
	else
		Boss_Call_MonsterFun(8,15,24,rid)
	end
end

monster_event_trigger[17] = function ()
	look('OnMonsterTrigger17')
	local x,y,rid,mapGID = CI_GetCurPos(3)
	look(x)
	look(y)
	look(rid)
	look(mapGID)
	if mapGID then
		Boss_Call_MonsterFun(9,10,93,mapGID)
	else
		Boss_Call_MonsterFun(9,10,93,rid)
	end
end

monster_event_trigger[18] = function ()
	look('OnMonsterTrigger18')
	local x,y,rid,mapGID = CI_GetCurPos(3)
	look(x)
	look(y)
	look(rid)
	look(mapGID)
	if mapGID then
		Boss_Call_MonsterFun(10,32,26,mapGID)
	else
		Boss_Call_MonsterFun(10,32,26,rid)
	end
end

monster_event_trigger[20] = function ()
	look('OnMonsterTrigger20')
	local x,y,rid,mapGID = CI_GetCurPos(3)
	look(x)
	look(y)
	look(rid)
	look(mapGID)
	if mapGID then
		Boss_Call_MonsterFun(11,14,12,mapGID)
	else
		Boss_Call_MonsterFun(11,14,12,rid)
	end
end

monster_event_trigger[21] = function ()
	look('OnMonsterTrigger21')
	local x,y,rid,mapGID = CI_GetCurPos(3)
	look(x)
	look(y)
	look(rid)
	look(mapGID)
	if mapGID then
		Boss_Call_MonsterFun(12,49,12,mapGID)
	else
		Boss_Call_MonsterFun(12,49,12,rid)
	end
end

monster_event_trigger[22] = function ()
	look('OnMonsterTrigger22')
	local x,y,rid,mapGID = CI_GetCurPos(3)
	look(x)
	look(y)
	look(rid)
	look(mapGID)
	local fac_id = GetMonsterData(29,3)
	if fac_id == nil or fac_id <= 0 then return end
	local fac_name = GetMonsterData(9,3)
	if type(fac_name) ~= type('') then return end
	--look('fac_id:' .. tostring(fac_id))
	local ybData = GetFaction_ybData(fac_id)
	if ybData == nil then return end
	-- 设置镖车破损度
	ybData[7] = 1
	
	-- 掉落铜钱
	local total = ybData[10] or 0
	total = rint(total/10)
	if total < 0 then total = 0 end	
	if rid and rid > 0 then
		local num = 20 + total
		if num > 100 then num = 100 end
		for i = 1,num do		
			CreateGroundItem(rid,0,0,10000,x,y,i)
		end
	end
	-- 发公告
	local pname = CI_GetPlayerData(5)
	if type(pname) ~= type('') then
		return
	end
	RegionRPC(rid,'faction_yb_damage',1,fac_name,pname)
end

-- 雕像快死的时候不让攻城车打了
monster_event_trigger[23] = function ()
	look('OnMonsterTrigger23')
	GI_Set_Car_AI()
end
--年兽爆东西
monster_event_trigger[24] = function ()
	local x,y,rid,mapGID = CI_GetCurPos(3)
	if rid and rid > 0 then
		for i = 1,49 do		
			CreateGroundItem(rid,0,627,1,x,y,i)
		end
	end
	
end

monster_event_trigger[30] = function ()
	local x,y,rid,mapGID = CI_GetCurPos(3)
	local monGID=GetMonsterData(27,3)
	CI_UpdateMonsterData(3,266,1,1,3) 
	sjzz_boss_mirrors(mapGID,monGID,x,y,1030)
end

monster_event_trigger[31] = function ()
	local x,y,rid,mapGID = CI_GetCurPos(3)
	local monGID=GetMonsterData(27,3)
	CI_UpdateMonsterData(3,266,1,1,3) 
	sjzz_boss_mirrors(mapGID,monGID,x,y,1031)
end

monster_event_trigger[32] = function ()
	local x,y,rid,mapGID = CI_GetCurPos(3)
	local monGID=GetMonsterData(27,3)
	CI_UpdateMonsterData(3,266,1,1,3) 
	sjzz_boss_mirrors(mapGID,monGID,x,y,nil)
end

monster_event_trigger[33] = function ()
	look('OnMonsterTrigger33')
	local x,y,rid,mapGID = CI_GetCurPos(3)
	Boss_Call_MonsterFun(13,x,y,mapGID)
	CI_UpdateMonsterData(3,266,1,1,3) 
end

monster_event_trigger[34] = function ()
	CI_UpdateMonsterData(3,266,1,1,3) 
end
--------------------------------------------------------------------------
--interface:

function OnMonsterTrigger(id)
	look('OnMonsterTrigger',2)
	look(id,2)
	local func = monster_event_trigger[id]
	if type(func) == 'function' then
		func()
	end
end



