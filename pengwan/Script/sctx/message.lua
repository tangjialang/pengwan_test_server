
--------------------------------------------------------------------------
--include:

-- local msgDispatcher = msgDispatcher
-- local Enter_XMLfb=Enter_XMLfb
-- local XMLFb_Exit=XMLFb_Exit
-- local Chick_benginXML=Chick_benginXML
-- local XMLFBd_Start=XMLFBd_Start
--------------------------------------------------------------------------
-- data:

--���븱��
msgDispatcher[27][0] = function ( playerid ,msg )
	sctx_enter(playerid,msg.num,msg.itype)
end

--�˸���
msgDispatcher[27][1] = function ( playerid ,msg )
	sctx_exit(playerid)
end
--�콱
msgDispatcher[27][2] = function ( playerid ,msg )
	sctx_getaward(playerid)
end
--���󱾹��ϴ�ͨ�������Ϣ
msgDispatcher[27][3] = function ( playerid ,msg )
	sctx_getsuccdata(msg.num,msg.itype)
end
