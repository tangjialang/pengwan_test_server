local tostring = tostring
local s2s_def_server = s2s_def_server
local look = look

local spboss_m = require('Script.span_server.span_boss')
local sb_get_rooms = spboss_m.sb_get_rooms
local spxb_m = require('Script.span_server.span_xunbao')
local spxb_get_rooms = spxb_m.spxb_get_rooms
local spfish_m = require('Script.active.catch_fish')
local sf_get_rooms = spfish_m.sf_get_rooms
local sptjbx_m = require('Script.span_server.span_tjbx')
local stjbx_get_rooms = sptjbx_m.stjbx_get_rooms
local spsjzc_m = require('Script.span_server.span_sjzc')
local ssjzc_get_rooms = spsjzc_m.ssjzc_get_rooms


-----------------------------------------���BOSS�-------------------------------------

-- ���BOSS�����б�
s2s_def_server[1001] = function(msg)
	sb_get_rooms(msg.svrid, msg.uid, msg.con, msg.idx)
end

-----------------------------------------���Ѱ���-------------------------------------

-- ���Ѱ�������б�
s2s_def_server[2001] = function(msg)
	spxb_get_rooms(msg.svrid, msg.uid, msg.con, msg.idx)
end

-----------------------------------------�������-------------------------------------

-- ������㷿���б�
s2s_def_server[3001] = function(msg)
	sf_get_rooms(msg.svrid, msg.uid, msg.con, msg.idx)
end
-----------------------------------------���3v3�-------------------------------------

-- �����ȴ�ƥ��
s2s_def_server[4001] = function(msg)
	v3_mate(msg.svrid, msg.info)
end

-----------------------------------------����콵����-------------------------------------

-- ����콵���䷿���б�
s2s_def_server[5001] = function(msg)
	stjbx_get_rooms(msg.svrid, msg.uid, msg.con, msg.idx)
end

-----------------------------------------�������ս���-------------------------------------

-- ����콵���䷿���б�
s2s_def_server[6001] = function(msg)
	ssjzc_get_rooms(msg.svrid, msg.uid, msg.con, msg.idx)
end

-----------------------------------------����������-----------------------------------------

-- ����������
s2s_def_server[7001] = function(msg)
	FactionChat_c2s(msg.fac_id,msg.name,msg.contents,msg.icon,msg.loc_svrid)
end

-----------------------------------------���GM����-------------------------------------
-- ���GM����
s2s_def_server[9001] = function(msg)
	Span_ScriptGMCMD(msg.gCMD, msg.args)
end
-----------------------------------------���1v1�-------------------------------------

-- ���1v1�����洢����
s2s_def_server[10001] = function(msg)
	v1_savedata(msg.info)
end
-- ���1v1ÿ���������ǰ20��������Ϣ
s2s_def_server[10002] = function(msg)
	askinfo_1v1_rank_kf(msg.itype,msg.group)
end
-- ���1v1���������������Ϣ
s2s_def_server[10003] = function(msg)
	--askinfo_1v1_all_kf(msg.playid,msg.group)
end
-- ���1v1�������Ĥ��
s2s_def_server[10004] = function(msg)
	kf1v1_worship(msg.desid,msg.index)
end
-- ���1v1�������Ĥ����Ϣ
s2s_def_server[10005] = function(msg)
	ask_1v1_worship_kf(msg.group)
end
--��������
s2s_def_server[10006] = function(msg)
	--kf_quiz_lv1_save(msg.playid,msg.itype,msg.sid1,msg.sid2,msg.sid3,msg.num)
end
--������Ҿ��½��
s2s_def_server[10007] = function(msg)
	kf_quiz_lv1_ret(msg.itype,msg.group)
end

s2s_def_server[11001] = function(msg)
	sjzz_hx_score(msg.svrid,msg.score,msg.king_name,msg.king_fight)
end

s2s_def_server[11002] = function(msg)
	sjzz_get_hx_rank(msg.svrid)
end

s2s_def_server[11003] = function(msg)
	sjzz_add_mb_info(msg.svrid,msg.index)
end

s2s_def_server[12001] = function(msg)
	sjzz_ys_score(msg.svrid,msg.score,msg.king_name,msg.king_fight)
end

s2s_def_server[12002] = function(msg)
	sjzz_get_ys_rank(msg.svrid)
end

s2s_def_server[11005] = function(msg)
	sjzz_set_kings_info(msg.svrid,msg.kings)
end

s2s_def_server[11006] = function(msg)
	sjzz_get_js_res(msg.svrid)
end