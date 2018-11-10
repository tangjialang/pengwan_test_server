--[[
file:	message.lua
desc:	hero messages.
author:	chal
update:	2011-12-07
]]--

--------------------------------------------------------------------------
--include:
local msgDispatcher = msgDispatcher
local Hero_Data = msgh_s2c_def[9][1]
local Hero_Fail = msgh_s2c_def[9][2]
local HeroFeedProc = HeroFeedProc
local HeroFireProc = HeroFireProc
local HeroRecruitProc = HeroRecruitProc
local HeroFight = HeroFight
local SendHeroData = SendHeroData
local HeroFHProc = HeroFHProc
local SendLuaMsg = SendLuaMsg
--------------------------------------------------------------------------
-- data:

--培养武将
msgDispatcher[9][1] = function ( playerid,msg)
	local result,data,isup,isb,lv = HeroFeedProc(playerid,msg.index)
	if(result)then
		SendLuaMsg( 0, { ids = Hero_Data, data = data, t = 1, isup = isup,isb = isb, lv = lv, idx = msg.index}, 9 )
	else
		SendLuaMsg( 0, { ids = Hero_Fail, t = 1, data = data}, 9 )
	end
end
--解雇武将
msgDispatcher[9][2] = function ( playerid,msg)
	local result,data,hid = HeroFireProc(playerid,msg.index)
	if(result)then
		SendLuaMsg( 0, { ids = Hero_Data, data = data, t = 2, index = msg.index, hid = hid}, 9 )
	else
		SendLuaMsg( 0, { ids = Hero_Fail, t = 2, data = data}, 9 )
	end
end
--[[武将卡激活武将
msgDispatcher[8][3] = function ( playerid,msg)
	local result,data,hid = HeroActiveProc(playerid,msg.goodid)
	if(result)then
		SendLuaMsg( 0, { ids = Hero_Data, data = data, t = 4, hid = hid}, 9 )
	else
		SendLuaMsg( 0, { ids = Hero_Fail, t = 4, data = data}, 9 )
	end
end
]]--
--招募武将
msgDispatcher[9][3] = function ( playerid,msg)
	local result,data,hid = HeroRecruitProc(playerid,msg.index,msg.htype)
	if(result)then
		SendLuaMsg( 0, { ids = Hero_Data, data = data, t = 3,hid = hid}, 9 )
	else
		SendLuaMsg( 0, { ids = Hero_Fail, t = 3, data = data}, 9 )
	end
end

--家将出战
msgDispatcher[9][5] = function ( playerid,msg)
	local result,data = HeroFight(playerid,msg.index,msg.isfight,nil,msg.auto)
	if(result)then
		SendLuaMsg( 0, { ids = Hero_Data, data = data, t = 5}, 9 )
	else
		SendLuaMsg( 0, { ids = Hero_Fail, t = 5, data = data}, 9 )
	end
end

--查看其它玩家家将
msgDispatcher[9][6] = function ( playerid,msg)
	SendHeroData(msg.sid,msg.name,msg.type)
end

--家将法化
msgDispatcher[9][7] = function ( playerid,msg)
	local result,data,isup,isb,lv = HeroFHProc(playerid,msg.index,msg.ctype,msg.num)
	if(result)then
		SendLuaMsg( 0, { ids = Hero_Data, data = data,isup = isup,isb = isb,lv = lv,idx = msg.index, t = 6}, 9 )
	else
		SendLuaMsg( 0, { ids = Hero_Fail, t = 6, data = data}, 9 )
	end
end

--家将继承
msgDispatcher[9][8] = function ( playerid,msg)
	local result,data = HeroAvertProc(playerid,msg.idx,msg.idx1)
	if(result)then
		SendLuaMsg( 0, { ids = Hero_Data, data = data,idx = msg.idx,idx1 = msg.idx1, t = 7}, 9 )
	else
		SendLuaMsg( 0, { ids = Hero_Fail, t = 7, data = data}, 9 )
	end
end

--家将学习技能
msgDispatcher[9][9] = function ( playerid,msg)
	--(sid,index,goodid,pos)
	local result,data,skillid,lv = learn_hero_skill(playerid,msg.idx,msg.goodid,msg.pos)
	if(result)then
		SendLuaMsg( 0, { ids = Hero_Data, data = data,idx = msg.idx,t = 8, skillid = skillid, lv = lv}, 9 )
	else
		SendLuaMsg( 0, { ids = Hero_Fail, t = 8, data = data}, 9 )
	end
end

--家将遗忘、封印技能
msgDispatcher[9][10] = function ( playerid,msg)
	--(sid,tp,index,pos,skillid)
	local result,data = remove_hero_skill(playerid,msg.tp,msg.idx,msg.pos,msg.skillid,msg.lv)
	if(result)then
		SendLuaMsg( 0, { ids = Hero_Data, data = data,idx = msg.idx, t = 9, tp = msg.tp, skillid = msg.skillid, lv = msg.lv}, 9 )
	else
		SendLuaMsg( 0, { ids = Hero_Fail, t = 9, data = data}, 9 )
	end
end

--点亮星盘
msgDispatcher[9][11] = function ( playerid,msg)
	local result,data,isfail = set_player_star(playerid,msg.index,msg.idx,msg.bit,msg.t)
	if(result)then
		SendLuaMsg( 0, { ids = Hero_Data, data = data,idx = msg.idx, t = 10, tp = msg.t, bit = msg.bit, isfail = isfail}, 9 )
	else
		SendLuaMsg( 0, { ids = Hero_Fail, t = 10, data = data}, 9 )
	end
end

--点亮本命星
msgDispatcher[9][12] = function ( playerid,msg)
	local result,data = set_player_boss(playerid,msg.index)
	if(result)then
		SendLuaMsg( 0, { ids = Hero_Data, data = data, t = 11}, 9 )
	else
		SendLuaMsg( 0, { ids = Hero_Fail, t = 11, data = data}, 9 )
	end
end

--升级家将技能
msgDispatcher[9][13] = function ( playerid,msg)
	local result,data = up_hero_skill(playerid,msg.idx,msg.skillid,msg.pos)
	if(result)then
		SendLuaMsg( 0, { ids = Hero_Data, data = data, t = 12}, 9 )
	else
		SendLuaMsg( 0, { ids = Hero_Fail, t = 12, data = data}, 9 )
	end
end