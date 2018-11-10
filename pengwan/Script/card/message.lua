--------------------------------------------------------------------------
--include:

local card 		= require('Script.card.card_func')
local card_getattaward 	= card.card_getattaward
local card_useitem 	= card.card_useitem
local card_activate=card.card_activate
local card_useskill=card.card_useskill
local card_upbuff=card.card_upbuff
local card_upgl=card.card_upgl
local card_gorget=card.card_gorget
local card_addskill=card.card_addskill
local card_enhange=card.card_enhange
local card_bag_give = card.card_bag_give
--------------------------------------------------------------------------
-- data:

-- ��ȡ�������װ����
msgDispatcher[34][0] = function ( playerid,msg )	
	card_getattaward(playerid,msg.num)
end
-- ����
msgDispatcher[34][1] = function ( playerid,msg )	
	card_activate(playerid,msg.id,msg.num)
end

-- ʹ�ü���
msgDispatcher[34][2] = function ( playerid,msg )	
	card_useskill(playerid,msg.index,msg.x,msg.y,msg.gid)
end

-- ��������
msgDispatcher[34][3] = function ( playerid,msg )	
	card_upbuff( playerid,msg.buffid )
end
-- ��������
msgDispatcher[34][4] = function ( playerid,msg )	
	card_upgl( playerid,msg.index  )
end
-- �����ϴ��
msgDispatcher[34][5] = function ( playerid,msg )	
	 card_gorget( playerid ,msg.money)
end
-- װ������
msgDispatcher[34][6] = function ( playerid,msg )	
	card_addskill( playerid,msg.index,msg.buffid )
end
-- ǿ������
msgDispatcher[34][7] = function ( playerid,msg )	
	card_enhange( playerid,msg.zhang,msg.jie,msg.buy,msg.lastnum,msg.auto )
end
-- ��ȡ����
msgDispatcher[34][8] = function ( playerid,msg )
	card_bag_give( msg.index, msg.itype, msg.itemid )
end