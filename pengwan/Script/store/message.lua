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

--���򣬶һ�
msgDispatcher[20][0] = function (playerid,msg)
	look(msg,2)
	
	mainstore(playerid,msg.storeid,msg.tag,msg.index,msg.num,msg.itemid,msg.name)
end
--�����ʼ����ˢ��
msgDispatcher[20][1] = function (playerid,msg)
	local itype=msg.id
	if itype==1 then --��ʼ���̳�+�޹�
		limit_store(playerid,msg.t,msg.ver) --msg.t ����ʶ
	elseif itype==2 then--��ʼ�������̵�
		vip_store(playerid)
	elseif itype==3 then--ˢ�������̵�
		--rfalse("ˢ�������̵�")
		re_vipstore(playerid,1)
	elseif itype==4 then--��ʼ�����������̵�
		vip_store2(playerid)
	elseif itype==5 then--ˢ�����������̵�10��
		--rfalse("ˢ�����������̵�10��")
		re_vipstore(playerid,2,10)
	elseif itype==6 then--ˢ�����������̵�30��
		--rfalse("ˢ�����������̵�30��")
		re_vipstore(playerid,2,30)
	end
end
--��ݹ���
msgDispatcher[20][2] = function (playerid,msg)
	Quickbuy(playerid,msg.id,msg.num,msg.itype)
end
-- ----------------ȫ���޹�------------
-- --�鿴
-- msgDispatcher[20][3] = function (playerid,msg)
-- 	server_limitlook()
-- end

-- --����
-- msgDispatcher[20][4] = function (playerid,msg)
-- 	server_limitbuy(playerid,msg.itype)
-- end
-------------------------------------------------
--���߻�����
msgDispatcher[20][5] = function (playerid,msg)
	change_goods( playerid,msg.itemid,msg.itype )
end
-------------------ȫ���޹�---------------------
--�鿴
msgDispatcher[20][6] = function (playerid,msg)
	getworld_lidata(msg.itype)
end