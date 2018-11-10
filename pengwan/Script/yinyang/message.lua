
--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local Judge_getskill=Judge_getskill
local lock_skill=lock_skill
local fuseskill=fuseskill
local fuseskill_all=fuseskill_all
local sale_one=sale_one
local sale_all=sale_all
local pick_one=pick_one
local pick_all=pick_all
local get_yypackage=get_yypackage

--------------------------------------------------------------------------
-- data:

--启灵
msgDispatcher[18][1] = function (playerid,msg)
	Judge_getskill(playerid,msg.five)
end
--锁定
msgDispatcher[18][2] = function (playerid,msg)	
	lock_skill(playerid,msg.site,msg.lock)
end
-- 融合
msgDispatcher[18][3] = function (playerid,msg)
	fuseskill(playerid,msg.a_site,msg.b_site)
end
-- 一键融合
msgDispatcher[18][4] = function (playerid,msg)
	fuseskill_all(playerid,msg.site)
end
-- --卖掉技能
-- msgDispatcher[18][5] = function (playerid,msg)
-- 	sale_one(playerid,msg.site)
-- end
-- --积分兑换
-- msgDispatcher[18][6] = function (playerid,msg)
	-- yy_exchange(playerid,msg.id)
-- end

-- -- 初始化
-- msgDispatcher[18][7] = function (playerid)
	-- start_yy( playerid )
-- end
--一键出售
-- msgDispatcher[18][8] = function (playerid,msg)
-- 	sale_all( playerid,msg.range)
-- end
--拾取
-- msgDispatcher[18][9] = function (playerid,msg)
-- 	pick_one( playerid,msg.site)
-- end
--一键拾取
-- msgDispatcher[18][10] = function (playerid)
-- 	pick_all( playerid)
-- end
-- 请求一键融合
-- msgDispatcher[18][11] = function (playerid,msg)
-- --	fuseskill_allback(playerid,msg.site)
-- end
-- 请求请求开启包裹
-- msgDispatcher[18][12] = function (playerid,msg)
-- 	get_yypackage(playerid,msg.site)
-- end
