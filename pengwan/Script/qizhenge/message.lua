
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


--����� ��Ʒ�״�ˢ����Ϣ
msgDispatcher[50][1] = function(playerid,msg)
	look("��Ʒ�״�ˢ����Ϣ")
	local qzg_data = get_af_data(playerid)
	if   nil == qzg_data[3] or 0 == #qzg_data[3] then
		local index = qzg_goodsRandom(playerid,msg)
		if nil ==index or index > 7 then look(index) return end
	else
		look('�ͻ���ˢ��')
		qzg_Client(playerid)
	end
end
--�ۿ�ˢ��
msgDispatcher[50][2] = function(playerid,msg)
	look("�ۿ�ˢ��")
	commodities_Refresh(playerid,msg.spid)
end
--��Ʒ����
msgDispatcher[50][3] = function(playerid,msg)
	look("��Ʒ����")
	goods_buying(playerid,msg.spid)
end
--��Ʒˢ��
msgDispatcher[50][4] = function(playerid,msg)
	look("��Ʒˢ��")
	qzg_goodsRandom(playerid,msg.spid)
end
