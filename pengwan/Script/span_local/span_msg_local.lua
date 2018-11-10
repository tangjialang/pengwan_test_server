local tostring = tostring
local s2s_def_local = s2s_def_local
local spxb_set_rooms = spxb_set_rooms

-- 跨服BOSS房间列表
s2s_def_local[1001] = function(msg)
	spboss_set_rooms(msg.uid,msg.con,msg.idx,msg.rooms)
end
-- 跨服寻宝房间列表
s2s_def_local[2001] = function(msg)
	spxb_set_rooms(msg.uid,msg.con,msg.idx,msg.rooms)
end
-- 跨服捕鱼房间列表
s2s_def_local[3001] = function(msg)
	spfish_set_rooms(msg.uid,msg.con,msg.idx,msg.rooms)
end

--跨服3v3配对成功
s2s_def_local[4001] = function(msg)
	v3reg_get_kfref(msg.res,msg.osid,msg.info,msg.id,msg.num,msg.kfnum)
end
--跨服3v3配对失败
s2s_def_local[4002] = function(msg)
	v3reg_fair_kf(msg.info)
end


-- 跨服天降宝箱房间列表
s2s_def_local[5001] = function(msg)
	sptjbx_set_rooms(msg.uid,msg.con,msg.idx,msg.rooms)
end

-- 跨服三界战场房间列表
s2s_def_local[6001] = function(msg)
	spsjzc_set_rooms(msg.uid,msg.con,msg.idx,msg.rooms)
end

-- 跨服帮会聊天
s2s_def_local[7001] = function(msg)
	FactionChat_s2c(msg.fac_id,msg.name,msg.contents,msg.icon)
end
--玩家报名回复
s2s_def_local[10001] = function(msg)
	receive_1v1_sign(msg.id,msg.ret)
end
--跨服1v1配对成功
s2s_def_local[10002] = function(msg)
	v1reg_get_kfref(msg.info,msg.style,msg.jf,msg.times)
end
--玩家接收跨服1v1每场活动结束后前20名排名信息
s2s_def_local[10003] = function(msg)
	save_1v1_front20(msg.times,msg.list,msg.mark)
end
--活动结束后收到跨服所有排名信息
s2s_def_local[10004] = function(msg)
	--repley_1v1_all(msg.sid,msg.list)
end
--返回玩家请求的膜拜信息
s2s_def_local[10005] = function(msg)
	--repley_1v1_worship(msg.sid,msg.list)
	save_1v1_worship(msg.list)
end
--活动结束后返回的竞猜结果获取奖励
s2s_def_local[10006] = function(msg)
	repley_1v1_quiz(msg.itype,msg.list)
end
--玩家请求离开跨服
s2s_def_local[10007] = function(msg)
	--repley_leaveSpan_1v1(msg.list)
end
----活动结束 返回给本服需要奖励的玩家
s2s_def_local[10008] = function(msg)
	gameover_1v1_award(msg.itype,msg.info,msg.rank)
end
--告诉本服一轮比赛结束
--s2s_def_local[10009] = function(msg)
	--oneround_1v1_over()
--end

s2s_def_local[11002] = function(msg)
	sjzz_hx_on_read_ranks(msg.ranks)
end

s2s_def_local[11003] = function(msg)
	sjzz_ys_on_read_ranks(msg.ranks)
end

s2s_def_local[11004] = function(msg)
	sjzz_set_mb_info(msg.info)
end

s2s_def_local[11005] = function(msg)
	sjzz_get_kings_info(msg.svrid,msg.res)
end

s2s_def_local[11006] = function(msg)
	sjzz_set_js_res(msg.sid,msg.js_res)
end
