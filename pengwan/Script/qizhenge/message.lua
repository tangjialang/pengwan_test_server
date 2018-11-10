
--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local qizhenge = require('Script.qizhenge.qizhenge_fun')
local qzg_goodsRandom = qizhenge.qzg_goodsRandom
local goods_buying = qizhenge.goods_buying
local commodities_Refresh = qizhenge.commodities_Refresh
local qzg_goods = qizhenge.qzg_goods
local get_af_data = qizhenge.get_af_data
local qzg_Client = qizhenge.qzg_Client
--------------------------------------------------------------------------


--珍珠阁 物品首次刷新消息
msgDispatcher[50][1] = function(playerid,msg)
	look("物品首次刷新消息")
	local qzg_data = get_af_data(playerid)
	if   nil == qzg_data[3] or 0 == #qzg_data[3] then
		local index = qzg_goodsRandom(playerid,msg)
		if nil ==index or index > 7 then look(index) return end
	else
		look('客户端刷新')
		qzg_Client(playerid)
	end
end
--折扣刷新
msgDispatcher[50][2] = function(playerid,msg)
	look("折扣刷新")
	commodities_Refresh(playerid,msg.spid)
end
--商品购买
msgDispatcher[50][3] = function(playerid,msg)
	look("商品购买")
	goods_buying(playerid,msg.spid)
end
--物品刷新
msgDispatcher[50][4] = function(playerid,msg)
	look("物品刷新")
	qzg_goodsRandom(playerid,msg.spid)
end
