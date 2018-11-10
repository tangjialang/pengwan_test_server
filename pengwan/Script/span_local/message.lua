local tostring = tostring
local msgDispatcher = msgDispatcher
local look = look
local spboss_enter_server = spboss_enter_server
local spxb_enter_server = spxb_enter_server
local spxb_get_server = spxb_get_server
local spxb_get_rooms = spxb_get_rooms


--------------------------------------------------------------------------
-- data:

------------------------------���BOSS------------------------------
-- ������BOSS�
msgDispatcher[35][1] = function (playerid, msg)	
	spboss_enter_server(playerid, msg.pass, msg.localIP, msg.port, msg.entryid, msg.idx, msg.mapGID)
end

-- ���BOSS�ȡ������Ϣ
msgDispatcher[35][2] = function (playerid, msg)	
	spboss_get_server(playerid)
end

-- ���BOSS�������Ϣ
msgDispatcher[35][3] = function (playerid, msg)	
	spboss_get_rooms(playerid, msg.con, msg.idx)
end

------------------------------���Ѱ��------------------------------
-- ������Ѱ���
msgDispatcher[36][1] = function (playerid, msg)	
	spxb_enter_server(playerid, msg.pass, msg.localIP, msg.port, msg.entryid, msg.idx, msg.mapGID)
end

-- ���Ѱ���ȡ������Ϣ
msgDispatcher[36][2] = function (playerid, msg)	
	spxb_get_server(playerid)
end

-- ���Ѱ���������Ϣ
msgDispatcher[36][3] = function (playerid, msg)	
	spxb_get_rooms(playerid, msg.con, msg.idx)
end

------------------------------�������------------------------------
-- ����������
msgDispatcher[37][1] = function (playerid, msg)	
	spfish_enter_server(playerid, msg.pass, msg.localIP, msg.port, msg.entryid, msg.idx, msg.mapGID)
end

-- �������ȡ������Ϣ
msgDispatcher[37][2] = function (playerid, msg)	
	spfish_get_server(playerid)
end

-- �������������Ϣ
msgDispatcher[37][3] = function (playerid, msg)	
	spfish_get_rooms(playerid, msg.con, msg.idx)
end

------------------------------���3v3------------------------------
--���뱨��
msgDispatcher[37][4] = function (playerid, msg)	
	v3reg_enter(playerid)
end

--���ս�����
msgDispatcher[37][5] = function (playerid, msg)	
	-- look(msg,1)
	v3reg_endin(playerid,msg.pass, msg.localIP, msg.port, msg.entryid)
end

--�������鷿��
msgDispatcher[37][6] = function (playerid, msg)	
	reg_creatteam(playerid)
end
--���뱨������
msgDispatcher[37][7] = function (playerid, msg)	
	reg_inter( playerid)
end
--�������
msgDispatcher[37][8] = function (playerid, msg)	
	reg_intoteam(playerid,msg.osid,msg.mi)
end
--�߳���Ա
msgDispatcher[37][9] = function (playerid, msg)	
	reg_tplayer(playerid,msg.name)
end
--׼�����
msgDispatcher[37][10] = function (playerid, msg)	
	reg_reday(playerid,msg.itype)
end
--�����ŶӵȺ�ƥ��
msgDispatcher[37][11] = function (playerid, msg)	
	reg_sign(playerid)
end
--ȡ�����б���Ϣ
msgDispatcher[37][12] = function (playerid, msg)	
	reg_getteaminfo()
end
--���ٽ���
msgDispatcher[37][13] = function (playerid, msg)	
	v3_quick_in( playerid )
end
--�������
msgDispatcher[37][14] = function (playerid, msg)	
	v3_changemima( playerid,msg.mi )
end
------------------------------����콵����------------------------------
-- �������콵����
msgDispatcher[39][1] = function (playerid, msg)	
	sptjbx_enter_server(playerid, msg.pass, msg.localIP, msg.port, msg.entryid, msg.idx, msg.mapGID)
end

-- ����콵����ȡ������Ϣ
msgDispatcher[39][2] = function (playerid, msg)	
	sptjbx_get_server(playerid)
end

-- ����콵����������Ϣ
msgDispatcher[39][3] = function (playerid, msg)	
	sptjbx_get_rooms(playerid, msg.con, msg.idx)
end

------------------------------������а�------------------------------
msgDispatcher[39][4] = function (playerid, msg)	
	kfph_get_list(playerid,msg.l_type,msg.page,msg.pagesize)
end
msgDispatcher[39][5] = function (playerid, msg)	
	kfph_get_self_ranking(playerid,msg.l_type)
end

------------------------------�������ս��------------------------------
-- ����������ս���
msgDispatcher[40][1] = function (playerid, msg)	
	spsjzc_enter_server(playerid, msg.pass, msg.localIP, msg.port, msg.entryid, msg.idx, msg.mapGID)
end

-- �������ս���ȡ������Ϣ
msgDispatcher[40][2] = function (playerid, msg)	
	spsjzc_get_server(playerid)
end

-- �������ս���������Ϣ
msgDispatcher[40][3] = function (playerid, msg)	
	spsjzc_get_rooms(playerid, msg.con, msg.idx)
end

-- �������ս���������Ϣ
msgDispatcher[40][4] = function (playerid, msg)	
	spsjzc_give_award(playerid)
end
--1v1�������
--��ұ���
msgDispatcher[45][1] = function (playerid, msg)	
	reg_1v1_sign(playerid)
end
--���ս�����
msgDispatcher[45][2] = function (playerid, msg)	
	-- look(msg,1)
	v1reg_endin(playerid,msg.pass, msg.localIP, msg.port, msg.entryid)
end
--���������˿�������Ϣ
--[[msgDispatcher[45][3] = function (playerid)	
	askinfo_1v1_one(playerid)
end--]]
--ÿ����������������ǰ20����Ϣ������3��������һ�Σ�
--online 
msgDispatcher[45][4] = function (playerid,msg)
	askinfo_1v1_front20(playerid,msg.itype)
end
--ÿ�����͵Ļ�����󷵻ظ�������е���Ϣ
msgDispatcher[45][5] = function (playerid)
	askinfo_1v1_all(playerid)
end
--����������Ĥ��
msgDispatcher[45][6] = function (playerid,msg)
	worship_lv1(playerid,msg.id,msg.index)
end
--�������Ĥ����Ϣ
msgDispatcher[45][7] = function (playerid)	
	ask_worship_lv1(playerid)
end
--�ͷ�����������Ƿ���
msgDispatcher[45][8] = function (playerid)
	enroll_lv1_isnot(playerid)
end
--��Ҿ���
--�������� 1���id �������ͣ���һ��id���ڶ���id��������id ��ע����
msgDispatcher[45][9] = function (playerid,msg)	
	quiz_lv1_quiz(playerid,msg.itype,msg.sid1,msg.sid2,msg.sid3,msg.num,msg.svrid1,msg.svrid2,msg.svrid3)
end
--��Ҿ�����������
msgDispatcher[45][10] = function (playerid,msg)	
	ask_lv1_quiz(playerid,msg.itype)
end
--��Ҿ��½��
--msgDispatcher[45][11] = function (playerid,msg)	
	--ask_lv1_quiz_ret(playerid,msg.itype)
--end

--------------------------------------------
--------------------------------------------
--���뺣ѡ
msgDispatcher[53][1] = function(playerid,msg)
	sjzz_hx_enter(playerid) 
end
--�뿪��ѡ
msgDispatcher[53][2] = function(playerid,msg)
	sjzz_hx_leave(playerid) 
end
--����ͬ������
msgDispatcher[53][3] = function(playerid,msg)	
	sjzz_hx_get_info(playerid)
end
--�������������(Ԥ��)
msgDispatcher[53][4] = function(playerid,msg)	
	RPCEx(playerid,'sjzz_res',3, sjzz_getwdata('sjzz_hx_ranks'))
end
--------------------------------------------
--------------------------------------------
--����Ԥ��
msgDispatcher[53][11] = function(playerid,msg)
	sjzz_ys_enter(playerid) 
end
--�뿪Ԥ��
msgDispatcher[53][12] = function(playerid,msg)
	sjzz_ys_leave(playerid) 
end
--����ͬ������
msgDispatcher[53][13] = function(playerid,msg)	
	sjzz_ys_get_info(playerid)
end
--�������������(Ԥ��)
msgDispatcher[53][14] = function(playerid,msg)	
	RPCEx(playerid,'sjzz_res2',3,sjzz_getwdata('sjzz_ys_ranks'))
end
msgDispatcher[53][15] = function(sid,msg)
	sjzz_get_js_ranks(sid)
end

--����������
msgDispatcher[53][20] = function(sid,msg)
	sjzz_enter_span_server(sid,msg)
end

--Ĥ��
msgDispatcher[53][21] = function(sid,msg)
	sjzz_span_mb(sid,msg.index)
end

--��ȡĤ����Ϣ
msgDispatcher[53][22] = function(sid,msg)
	sjzz_get_kings(sid)
end

msgDispatcher[53][23] = function(sid,msg)
	sjzz_get_mb_info(sid)
end


