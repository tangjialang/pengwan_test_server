--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local Wing_Data = msgh_s2c_def[20][11]
local Wing_Err = msgh_s2c_def[20][12]
local Expupbatt=Expupbatt
local Batuplv=Batuplv
local firstbatt_look=firstbatt_look
local SendLuaMsg = SendLuaMsg

local fasb = require('Script.ShenBing.faction_func')
local fasb_break_shenbing	= fasb.fasb_break_shenbing
local fasb_train_shenbing 	= fasb.fasb_train_shenbing
local dragon = require('Script.ShenBing.dragon_func')
local dragon_get_data = dragon.dragon_get_data
local dragon_up_data = dragon.dragon_up_data
--------------------------------------------------------------------------
-- data:

-- 初始化战斗法宝数据
msgDispatcher[16][0] = function ( playerid)	
	-- look('初始化战斗法宝数据',1)
	firstbatt(playerid)
end
-- 强化 
msgDispatcher[16][1] = function ( playerid, msg )	
	-- look(444)
	Expupbatt(playerid,msg.autobuy,msg.num,msg.itype,msg.useluck,msg.leixin)
end
-- 前台开法宝
msgDispatcher[16][2] = function ( playerid, msg )	
	-- look('前台开法宝',1)
	firstbatt(playerid)
end
-- 查看法宝
msgDispatcher[16][3] = function ( playerid, msg )	
	firstbatt_look(msg.sid,msg.name,msg.type,msg.s)
end

--------------骑兵相关-------------------------

-- 激活骑兵
msgDispatcher[16][4] = function ( playerid, msg )	
	sowar_begin( playerid )
end
-- 骑兵升阶
msgDispatcher[16][5] = function ( playerid, msg )	
	sowar_intensify(playerid,msg.buy,msg.lastnum,msg.itype,msg.leixin)
end
-- 学习技能
msgDispatcher[16][6] = function ( playerid, msg )	
	 sowar_learnskill(playerid,msg.num)
end
-- 骑兵查看
msgDispatcher[16][8] = function ( playerid, msg )	
	sowar_look(msg.sid,msg.name,msg.type,msg.s)
end
--------------法宝相关-------------------------
-- 学习法宝技能
msgDispatcher[16][7] = function ( playerid, msg )	
	 gem_learnskill(playerid,msg.num)
end

---------------翅膀消息---------------------------
--翅膀学习技能
msgDispatcher[16][9] = function ( playerid,msg)
	local result,data,skillid,lv = wing_learn_skill(playerid,msg.goodid,msg.pos)
	if(result)then
		SendLuaMsg( 0, { ids = Wing_Data, data = data,t = 1, skillid = skillid, lv = lv}, 9 )
	else
		SendLuaMsg( 0, { ids = Wing_Err, t = 1, data = data}, 9 )
	end
end

--翅膀遗忘、封印技能
msgDispatcher[16][10] = function ( playerid,msg)
	local result,data = wing_remove_skill(playerid,msg.tp,msg.pos,msg.skillid,msg.lv)
	if(result)then
		SendLuaMsg( 0, { ids = Wing_Data, data = data, t = 2, tp = msg.tp, skillid = msg.skillid, lv = msg.lv}, 9 )
	else
		SendLuaMsg( 0, { ids = Wing_Err, t = 2, data = data}, 9 )
	end
end

--升级翅膀技能
msgDispatcher[16][11] = function ( playerid,msg)
	local result,data,lv = wing_up_skill(playerid,msg.skillid,msg.lv,msg.pos)
	if(result)then
		SendLuaMsg( 0, { ids = Wing_Data, data = data, t = 3, skillid = msg.skillid, lv = lv}, 9 )
	else
		SendLuaMsg( 0, { ids = Wing_Err, t = 3, data = data}, 9 )
	end
end

--升级翅膀
msgDispatcher[16][12] = function ( playerid,msg)
	--wingdata,isup,errIdx,tempned
	local result,data,isup,errIdx,add = wing_up_proc(playerid,msg.type,msg.num,msg.itype, msg.stype, msg.num2)
	if(result)then
		SendLuaMsg( 0, { ids = Wing_Data, data = data, t = 4, isup = isup, errIdx = errIdx, add = add}, 9 )
	else
		SendLuaMsg( 0, { ids = Wing_Err, t = 4, data = data}, 9 )
	end
end

--查看其它玩家的翅膀
msgDispatcher[16][13] = function ( playerid,msg)
	wing_get_other_date(msg.sid,msg.name,msg.t)
end

--创建翅膀
msgDispatcher[16][14] = function ( playerid,msg)
	wing_create(playerid)
end
--骑兵开光
msgDispatcher[16][15] = function ( playerid,msg)
	sowar_kaiguang( playerid,msg.buy,msg.lastnum)
end
--显示夫妻名字
msgDispatcher[16][16] = function ( playerid,msg)
	marry_see( playerid,msg.itype)
end

---------------------------帮会神兵-----------------
----道具/元宝培育帮会神兵
msgDispatcher[16][17] = function(playerid, msg)
	fasb_train_shenbing(playerid, msg.itype, msg.atype, msg.lastnum)
end
--道具突破帮会神兵
msgDispatcher[16][18] = function(playerid)
	--fasb_break_shenbing(playerid)
end

---------------------------龙脉系统------------------
--获取data 
msgDispatcher[16][19] = function(playerid)
	dragon_get_data(playerid)
end

--龙脉升级
msgDispatcher[16][20] = function(playerid, msg)
	dragon_up_data(playerid, msg.itype, msg.num)
end





