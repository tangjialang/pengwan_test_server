local tostring = tostring
local msgDispatcher = msgDispatcher
local look = look
local spboss_enter_server = spboss_enter_server
local spxb_enter_server = spxb_enter_server
local spxb_get_server = spxb_get_server
local spxb_get_rooms = spxb_get_rooms


--------------------------------------------------------------------------
-- data:

------------------------------跨服BOSS------------------------------
-- 进入跨服BOSS活动
msgDispatcher[35][1] = function (playerid, msg)	
	spboss_enter_server(playerid, msg.pass, msg.localIP, msg.port, msg.entryid, msg.idx, msg.mapGID)
end

-- 跨服BOSS活动取大区信息
msgDispatcher[35][2] = function (playerid, msg)	
	spboss_get_server(playerid)
end

-- 跨服BOSS活动房间信息
msgDispatcher[35][3] = function (playerid, msg)	
	spboss_get_rooms(playerid, msg.con, msg.idx)
end

------------------------------跨服寻宝------------------------------
-- 进入跨服寻宝活动
msgDispatcher[36][1] = function (playerid, msg)	
	spxb_enter_server(playerid, msg.pass, msg.localIP, msg.port, msg.entryid, msg.idx, msg.mapGID)
end

-- 跨服寻宝活动取大区信息
msgDispatcher[36][2] = function (playerid, msg)	
	spxb_get_server(playerid)
end

-- 跨服寻宝活动房间信息
msgDispatcher[36][3] = function (playerid, msg)	
	spxb_get_rooms(playerid, msg.con, msg.idx)
end

------------------------------跨服捕鱼------------------------------
-- 进入跨服捕鱼活动
msgDispatcher[37][1] = function (playerid, msg)	
	spfish_enter_server(playerid, msg.pass, msg.localIP, msg.port, msg.entryid, msg.idx, msg.mapGID)
end

-- 跨服捕鱼活动取大区信息
msgDispatcher[37][2] = function (playerid, msg)	
	spfish_get_server(playerid)
end

-- 跨服捕鱼活动房间信息
msgDispatcher[37][3] = function (playerid, msg)	
	spfish_get_rooms(playerid, msg.con, msg.idx)
end

------------------------------跨服3v3------------------------------
--进入报名
msgDispatcher[37][4] = function (playerid, msg)	
	v3reg_enter(playerid)
end

--最终进入跨服
msgDispatcher[37][5] = function (playerid, msg)	
	-- look(msg,1)
	v3reg_endin(playerid,msg.pass, msg.localIP, msg.port, msg.entryid)
end

--创建队伍房间
msgDispatcher[37][6] = function (playerid, msg)	
	reg_creatteam(playerid)
end
--进入报名场景
msgDispatcher[37][7] = function (playerid, msg)	
	reg_inter( playerid)
end
--申请加入
msgDispatcher[37][8] = function (playerid, msg)	
	reg_intoteam(playerid,msg.osid,msg.mi)
end
--踢出队员
msgDispatcher[37][9] = function (playerid, msg)	
	reg_tplayer(playerid,msg.name)
end
--准备完成
msgDispatcher[37][10] = function (playerid, msg)	
	reg_reday(playerid,msg.itype)
end
--报名排队等候匹配
msgDispatcher[37][11] = function (playerid, msg)	
	reg_sign(playerid)
end
--取队伍列表信息
msgDispatcher[37][12] = function (playerid, msg)	
	reg_getteaminfo()
end
--快速进入
msgDispatcher[37][13] = function (playerid, msg)	
	v3_quick_in( playerid )
end
--添加密码
msgDispatcher[37][14] = function (playerid, msg)	
	v3_changemima( playerid,msg.mi )
end
------------------------------跨服天降宝箱------------------------------
-- 进入跨服天降宝箱活动
msgDispatcher[39][1] = function (playerid, msg)	
	sptjbx_enter_server(playerid, msg.pass, msg.localIP, msg.port, msg.entryid, msg.idx, msg.mapGID)
end

-- 跨服天降宝箱活动取大区信息
msgDispatcher[39][2] = function (playerid, msg)	
	sptjbx_get_server(playerid)
end

-- 跨服天降宝箱活动房间信息
msgDispatcher[39][3] = function (playerid, msg)	
	sptjbx_get_rooms(playerid, msg.con, msg.idx)
end

------------------------------跨服排行榜------------------------------
msgDispatcher[39][4] = function (playerid, msg)	
	kfph_get_list(playerid,msg.l_type,msg.page,msg.pagesize)
end
msgDispatcher[39][5] = function (playerid, msg)	
	kfph_get_self_ranking(playerid,msg.l_type)
end

------------------------------跨服三界战场------------------------------
-- 进入跨服三界战场活动
msgDispatcher[40][1] = function (playerid, msg)	
	spsjzc_enter_server(playerid, msg.pass, msg.localIP, msg.port, msg.entryid, msg.idx, msg.mapGID)
end

-- 跨服三界战场活动取大区信息
msgDispatcher[40][2] = function (playerid, msg)	
	spsjzc_get_server(playerid)
end

-- 跨服三界战场活动房间信息
msgDispatcher[40][3] = function (playerid, msg)	
	spsjzc_get_rooms(playerid, msg.con, msg.idx)
end

-- 跨服三界战场活动房间信息
msgDispatcher[40][4] = function (playerid, msg)	
	spsjzc_give_award(playerid)
end
--1v1跨服副本
--玩家报名
msgDispatcher[45][1] = function (playerid, msg)	
	reg_1v1_sign(playerid)
end
--最终进入跨服
msgDispatcher[45][2] = function (playerid, msg)	
	-- look(msg,1)
	v1reg_endin(playerid,msg.pass, msg.localIP, msg.port, msg.entryid)
end
--玩家请求个人跨服玩家信息
--[[msgDispatcher[45][3] = function (playerid)	
	askinfo_1v1_one(playerid)
end--]]
--每场比赛结束后请求前20名信息（例如3分钟请求一次）
--online 
msgDispatcher[45][4] = function (playerid,msg)
	askinfo_1v1_front20(playerid,msg.itype)
end
--每种类型的活动结束后返回给玩家所有的信息
msgDispatcher[45][5] = function (playerid)
	askinfo_1v1_all(playerid)
end
--活动结束后玩家膜拜
msgDispatcher[45][6] = function (playerid,msg)
	worship_lv1(playerid,msg.id,msg.index)
end
--请求玩家膜拜信息
msgDispatcher[45][7] = function (playerid)	
	ask_worship_lv1(playerid)
end
--客服端请求玩家是否报名
msgDispatcher[45][8] = function (playerid)
	enroll_lv1_isnot(playerid)
end
--玩家竞猜
--参数接收 1玩家id 比赛类型，第一名id，第二名id，第三名id 下注数量
msgDispatcher[45][9] = function (playerid,msg)	
	quiz_lv1_quiz(playerid,msg.itype,msg.sid1,msg.sid2,msg.sid3,msg.num,msg.svrid1,msg.svrid2,msg.svrid3)
end
--玩家竞猜请求数据
msgDispatcher[45][10] = function (playerid,msg)	
	ask_lv1_quiz(playerid,msg.itype)
end
--玩家竞猜结果
--msgDispatcher[45][11] = function (playerid,msg)	
	--ask_lv1_quiz_ret(playerid,msg.itype)
--end

--------------------------------------------
--------------------------------------------
--进入海选
msgDispatcher[53][1] = function(playerid,msg)
	sjzz_hx_enter(playerid) 
end
--离开海选
msgDispatcher[53][2] = function(playerid,msg)
	sjzz_hx_leave(playerid) 
end
--请求同步数据
msgDispatcher[53][3] = function(playerid,msg)	
	sjzz_hx_get_info(playerid)
end
--请求服务器排行(预赛)
msgDispatcher[53][4] = function(playerid,msg)	
	RPCEx(playerid,'sjzz_res',3, sjzz_getwdata('sjzz_hx_ranks'))
end
--------------------------------------------
--------------------------------------------
--进入预赛
msgDispatcher[53][11] = function(playerid,msg)
	sjzz_ys_enter(playerid) 
end
--离开预赛
msgDispatcher[53][12] = function(playerid,msg)
	sjzz_ys_leave(playerid) 
end
--请求同步数据
msgDispatcher[53][13] = function(playerid,msg)	
	sjzz_ys_get_info(playerid)
end
--请求服务器排行(预赛)
msgDispatcher[53][14] = function(playerid,msg)	
	RPCEx(playerid,'sjzz_res2',3,sjzz_getwdata('sjzz_ys_ranks'))
end
msgDispatcher[53][15] = function(sid,msg)
	sjzz_get_js_ranks(sid)
end

--决赛进入跨服
msgDispatcher[53][20] = function(sid,msg)
	sjzz_enter_span_server(sid,msg)
end

--膜拜
msgDispatcher[53][21] = function(sid,msg)
	sjzz_span_mb(sid,msg.index)
end

--获取膜拜信息
msgDispatcher[53][22] = function(sid,msg)
	sjzz_get_kings(sid)
end

msgDispatcher[53][23] = function(sid,msg)
	sjzz_get_mb_info(sid)
end


