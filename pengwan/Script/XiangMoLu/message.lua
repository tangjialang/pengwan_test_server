
--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local Enter_XMLfb=Enter_XMLfb
local XMLFb_Exit=XMLFb_Exit
local Chick_benginXML=Chick_benginXML
local XMLFBd_Start=XMLFBd_Start
--------------------------------------------------------------------------
-- data:

--���븱��
msgDispatcher[27][0] = function ( playerid ,msg )
	Enter_XMLfb(playerid,msg.num)
end


--�˸���
msgDispatcher[27][1] = function ( playerid ,msg )
	XMLFb_Exit(playerid)
end
--�������
msgDispatcher[27][2] = function ( playerid ,msg )
	Chick_benginXML(playerid)
end
--��ʼ��
msgDispatcher[27][3] = function ( playerid ,msg )
	XMLFBd_Start(playerid)
end