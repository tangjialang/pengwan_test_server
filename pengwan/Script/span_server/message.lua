local tostring = tostring
local msgDispatcher = msgDispatcher
local look = look
local CI_LeaveSpanServer = CI_LeaveSpanServer
local spboss_m = require('Script.span_server.span_boss')
local sb_enter = spboss_m.sb_enter
local spxunbao_m = require("Script.span_server.span_xunbao")
local spxb_enter = spxunbao_m.spxb_enter
local spsjzc_m = require("Script.span_server.span_sjzc")
local span_sjzc_give_award = spsjzc_m.span_sjzc_give_award
local span_sjzc_report_result = spsjzc_m.span_sjzc_report_result
local span_sjzc_get_list = spsjzc_m.span_sjzc_get_list


--------------------------------------------------------------------------
-- data:

-- �뿪���������
msgDispatcher[151][1] = function (playerid)	
	CI_LeaveSpanServer()
end

--------------------------------------���BOSS�-------------------------

-- ������BOSS�����
msgDispatcher[152][1] = function (playerid, msg)	
	sb_enter(playerid, msg.mapGID)
end

--------------------------------------���Ѱ���-------------------------
-- ������Ѱ�������
-- msgDispatcher[153][1] = function (playerid, msg)	
	-- spxb_enter(playerid, msg.mapGID)
-- end
--------------------------------------���3v3�-------------------------
--�����˺���Ϣ
msgDispatcher[154][1] = function (playerid, msg)	
	v3_getdamage(playerid)
end

--------------------------------------�������ս��-------------------------
---�������ս��������
msgDispatcher[155][1] = function (playerid, msg)	
	span_sjzc_report_result(playerid)
end

---�������ս���콱
msgDispatcher[155][2] = function (playerid, msg)	
	span_sjzc_give_award(playerid)
end

---����������а�
msgDispatcher[155][3] = function (playerid, msg)	
	span_sjzc_get_list(playerid)
end

--------------------------------------�����������-------------------------
msgDispatcher[156][1] = function (playerid, msg)
	sjzz_js_click_flag(playerid,msg.gid)
end

msgDispatcher[156][2] = function (playerid, msg)
	sjzz_js_sync(playerid)
end








