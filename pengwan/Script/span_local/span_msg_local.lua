local tostring = tostring
local s2s_def_local = s2s_def_local
local spxb_set_rooms = spxb_set_rooms

-- ���BOSS�����б�
s2s_def_local[1001] = function(msg)
	spboss_set_rooms(msg.uid,msg.con,msg.idx,msg.rooms)
end
-- ���Ѱ�������б�
s2s_def_local[2001] = function(msg)
	spxb_set_rooms(msg.uid,msg.con,msg.idx,msg.rooms)
end
-- ������㷿���б�
s2s_def_local[3001] = function(msg)
	spfish_set_rooms(msg.uid,msg.con,msg.idx,msg.rooms)
end

--���3v3��Գɹ�
s2s_def_local[4001] = function(msg)
	v3reg_get_kfref(msg.res,msg.osid,msg.info,msg.id,msg.num,msg.kfnum)
end
--���3v3���ʧ��
s2s_def_local[4002] = function(msg)
	v3reg_fair_kf(msg.info)
end


-- ����콵���䷿���б�
s2s_def_local[5001] = function(msg)
	sptjbx_set_rooms(msg.uid,msg.con,msg.idx,msg.rooms)
end

-- �������ս�������б�
s2s_def_local[6001] = function(msg)
	spsjzc_set_rooms(msg.uid,msg.con,msg.idx,msg.rooms)
end

-- ����������
s2s_def_local[7001] = function(msg)
	FactionChat_s2c(msg.fac_id,msg.name,msg.contents,msg.icon)
end
--��ұ����ظ�
s2s_def_local[10001] = function(msg)
	receive_1v1_sign(msg.id,msg.ret)
end
--���1v1��Գɹ�
s2s_def_local[10002] = function(msg)
	v1reg_get_kfref(msg.info,msg.style,msg.jf,msg.times)
end
--��ҽ��տ��1v1ÿ���������ǰ20��������Ϣ
s2s_def_local[10003] = function(msg)
	save_1v1_front20(msg.times,msg.list,msg.mark)
end
--��������յ��������������Ϣ
s2s_def_local[10004] = function(msg)
	--repley_1v1_all(msg.sid,msg.list)
end
--������������Ĥ����Ϣ
s2s_def_local[10005] = function(msg)
	--repley_1v1_worship(msg.sid,msg.list)
	save_1v1_worship(msg.list)
end
--������󷵻صľ��½����ȡ����
s2s_def_local[10006] = function(msg)
	repley_1v1_quiz(msg.itype,msg.list)
end
--��������뿪���
s2s_def_local[10007] = function(msg)
	--repley_leaveSpan_1v1(msg.list)
end
----����� ���ظ�������Ҫ���������
s2s_def_local[10008] = function(msg)
	gameover_1v1_award(msg.itype,msg.info,msg.rank)
end
--���߱���һ�ֱ�������
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
