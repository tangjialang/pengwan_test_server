--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local mainstore=mainstore
local limit_store=limit_store
local vip_store=vip_store
local re_vipstore=re_vipstore
local vip_store2=vip_store2
local Quickbuy=Quickbuy
--------------------------------------------------------------------------
-- data:

--购买，兑换
msgDispatcher[20][0] = function (playerid,msg)
	look(msg,2)
	
	mainstore(playerid,msg.storeid,msg.tag,msg.index,msg.num,msg.itemid,msg.name)
end
--请求初始化及刷新
msgDispatcher[20][1] = function (playerid,msg)
	local itype=msg.id
	if itype==1 then --初始化商城+限购
		limit_store(playerid,msg.t,msg.ver) --msg.t 面板标识
	elseif itype==2 then--初始化神秘商店
		vip_store(playerid)
	elseif itype==3 then--刷新神秘商店
		--rfalse("刷新神秘商店")
		re_vipstore(playerid,1)
	elseif itype==4 then--初始化批量神秘商店
		vip_store2(playerid)
	elseif itype==5 then--刷新批量神秘商店10次
		--rfalse("刷新批量神秘商店10次")
		re_vipstore(playerid,2,10)
	elseif itype==6 then--刷新批量神秘商店30次
		--rfalse("刷新批量神秘商店30次")
		re_vipstore(playerid,2,30)
	end
end
--快捷购买
msgDispatcher[20][2] = function (playerid,msg)
	Quickbuy(playerid,msg.id,msg.num,msg.itype)
end
-- ----------------全服限购------------
-- --查看
-- msgDispatcher[20][3] = function (playerid,msg)
-- 	server_limitlook()
-- end

-- --购买
-- msgDispatcher[20][4] = function (playerid,msg)
-- 	server_limitbuy(playerid,msg.itype)
-- end
-------------------------------------------------
--道具换东西
msgDispatcher[20][5] = function (playerid,msg)
	change_goods( playerid,msg.itemid,msg.itype )
end
-------------------全服限购---------------------
--查看
msgDispatcher[20][6] = function (playerid,msg)
	getworld_lidata(msg.itype)
end