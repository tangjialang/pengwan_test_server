
--------------------------------------------------------------------------
--include:

-- local msgDispatcher = msgDispatcher
-- local Enter_XMLfb=Enter_XMLfb
-- local XMLFb_Exit=XMLFb_Exit
-- local Chick_benginXML=Chick_benginXML
-- local XMLFBd_Start=XMLFBd_Start
--------------------------------------------------------------------------
-- data:

--进入副本
msgDispatcher[27][0] = function ( playerid ,msg )
	sctx_enter(playerid,msg.num,msg.itype)
end

--退副本
msgDispatcher[27][1] = function ( playerid ,msg )
	sctx_exit(playerid)
end
--领奖
msgDispatcher[27][2] = function ( playerid ,msg )
	sctx_getaward(playerid)
end
--请求本关上次通关玩家信息
msgDispatcher[27][3] = function ( playerid ,msg )
	sctx_getsuccdata(msg.num,msg.itype)
end
