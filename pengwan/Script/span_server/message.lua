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

-- 离开跨服服务器
msgDispatcher[151][1] = function (playerid)	
	CI_LeaveSpanServer()
end

--------------------------------------跨服BOSS活动-------------------------

-- 进入跨服BOSS活动房间
msgDispatcher[152][1] = function (playerid, msg)	
	sb_enter(playerid, msg.mapGID)
end

--------------------------------------跨服寻宝活动-------------------------
-- 进入跨服寻宝活动房间
-- msgDispatcher[153][1] = function (playerid, msg)	
	-- spxb_enter(playerid, msg.mapGID)
-- end
--------------------------------------跨服3v3活动-------------------------
--请求伤害信息
msgDispatcher[154][1] = function (playerid, msg)	
	v3_getdamage(playerid)
end

--------------------------------------跨服三界战场-------------------------
---跨服三界战场面板结算
msgDispatcher[155][1] = function (playerid, msg)	
	span_sjzc_report_result(playerid)
end

---跨服三界战场领奖
msgDispatcher[155][2] = function (playerid, msg)	
	span_sjzc_give_award(playerid)
end

---跨服三界排行榜
msgDispatcher[155][3] = function (playerid, msg)	
	span_sjzc_get_list(playerid)
end

--------------------------------------跨服三界至尊-------------------------
msgDispatcher[156][1] = function (playerid, msg)
	sjzz_js_click_flag(playerid,msg.gid)
end

msgDispatcher[156][2] = function (playerid, msg)
	sjzz_js_sync(playerid)
end








