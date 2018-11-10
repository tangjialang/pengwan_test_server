
--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local CS_RequestEnter = CS_RequestEnter
local CS_DoAward = CS_DoAward
local CS_LeaveFB = CS_LeaveFB
local CS_SendRoomList = CS_SendRoomList
local CS_CreateTeam = CS_CreateTeam
local CS_FastJoin = CS_FastJoin
local CS_QuitTeam = CS_QuitTeam
local CS_OnTeamProc = CS_OnTeamProc
local CS_SetRoomKey = CS_SetRoomKey
local CS_GetPassinfo = CS_GetPassinfo
local CS_GetSecAward = CS_GetSecAward
local CS_InvitePlayer = CS_InvitePlayer
local CS_Refuse = CS_Refuse
local CS_SaoDang = CS_SaoDang
local xtg = require("Script.CopyScene.xtg")		-- �����
local get_xtg_panel = xtg.get_xtg_panel
local get_xtg_award = xtg.get_xtg_award

--------------------------------------------------------------------------
-- data:

-- request enter cs.
msgDispatcher[4][1] = function ( playerid, msg )
	CS_RequestEnter( playerid,msg.fbID )
end

-- ������ܸ���JiangLi����Ϣ
msgDispatcher[4][2] = function ( playerid, msg )
	CS_DoAward(playerid)
end

-- �뿪����
msgDispatcher[4][3] = function ( playerid, msg )
	CS_LeaveFB( playerid )
end

-- ���Ͷ��˸�������
msgDispatcher[4][4] = function ( playerid, msg )
	CS_SendRoomList( playerid,msg.roomLV )
end

-- ��Ӹ�����������
msgDispatcher[4][5] = function ( playerid, msg )
	CS_CreateTeam( playerid, msg.fbID, msg.roomLV )
end

-- ���븱������
msgDispatcher[4][6] = function ( playerid, msg )
	CS_FastJoin( playerid, msg.roomLV, msg.leaderSID, msg.fbID, msg.pass, msg.bInvite )
end

-- �뿪����
msgDispatcher[4][7] = function ( playerid, msg )
	CS_QuitTeam( playerid, msg.name, msg.roomLV, msg.leaderSID )
end

-- ��Ӹ���׼�����߿�ʼ
msgDispatcher[4][8] = function ( playerid, msg )
	CS_OnTeamProc( playerid, msg.roomLV, msg.leaderSID )
end

-- ���÷�������
msgDispatcher[4][9] = function ( playerid, msg )
	CS_SetRoomKey( playerid, msg.roomLV, msg.password )
end

-- ��ȡ��������
msgDispatcher[4][10] = function ( playerid, msg )
	CS_GetPassinfo( playerid, msg.SectionID )
end

-- ��ȡ��ǰ���Ǽ�(���÷���)
-- msgDispatcher[4][11] = function ( playerid, msg )
	-- CS_GetAllStar( playerid )
-- end

-- ��ȡ�½ڽ���
msgDispatcher[4][12] = function ( playerid, msg )
	CS_GetSecAward( playerid, msg.SectionID )
end

-- �������
msgDispatcher[4][13] = function ( playerid, msg )
	CS_InvitePlayer( playerid, msg.pName )
end

-- �ܾ�����
msgDispatcher[4][14] = function ( playerid, msg )
	CS_Refuse( playerid, msg.othersid )
end

-- ����ɨ��
msgDispatcher[4][15] = function ( playerid, msg )
	CS_SaoDang( playerid, msg.fbID )
end

-- ������������������
msgDispatcher[4][16] = function ( playerid, msg )
	tw_uplevel( playerid, msg.gid, msg.ud, msg.idx )
end

-- ����������npcbuff
msgDispatcher[4][17] = function ( playerid, msg )
	tw_npcbuff( playerid, msg.gid )
end

-- ���鸱��: ʹ�ü���
msgDispatcher[4][18] = function ( playerid, msg )
	expfb_useskill( playerid, msg.idx, msg.x, msg.y )
end

-- �ȹ�Ȧ
msgDispatcher[4][19] = function ( playerid, msg )
	CS_StepLights( playerid, msg.inout, msg.idx, msg.round, msg.x, msg.y )
end

-- ���鸱��ˢBOSS
msgDispatcher[4][20] = function ( playerid, msg )
	expfb_create_boss( playerid )
end

-- ���߸�����ʹ�ü���
msgDispatcher[4][22] = function ( playerid, msg )
	itemfb_useskill( playerid, msg.idx, msg.monid )
end

-- ɨ��
msgDispatcher[4][23] = function ( playerid, msg )
	cs_saodang( playerid,msg.csType,msg.num )
end
-------------------------------------------------
-- ����������������
msgDispatcher[4][29] = function ( playerid, msg )
	twone_uplevel(playerid,msg.mon_gid)
end

-- ��ȡ����
msgDispatcher[4][30] = function ( playerid, msg )
	twone_getexp(playerid,msg.num)
end

--һ��ͨ��
msgDispatcher[4][31] = function ( playerid, msg )
	twone_pass(playerid)
end

--�������
msgDispatcher[4][32] = function ( playerid, msg )
	twone_buytime(playerid)
end

-- ��������������ʼ
msgDispatcher[4][34] = function ( playerid, msg )
	twone_go(playerid)
end

-- һ�ﵱ�ȱ���
msgDispatcher[4][35] = function ( playerid, msg )
	yjdx_get_awards(playerid,msg.level)
end

--������ս����--

--��ȡ�����б�
msgDispatcher[46][1] = function ( playerid, msg )
	cc_get_rank_list(playerid,msg.page,msg.pagesize)
end
--��ȡ��������
msgDispatcher[46][2] = function ( playerid, msg )
	SendLuaMsg(0,{ids={48,2},ranking = cc_get_player_ranking(playerid)},9)
end
--�콱
msgDispatcher[46][3] = function ( playerid, msg )
	cc_player_get_award(playerid,msg.ntype,msg.level)
end
--����
msgDispatcher[46][4] = function ( playerid, msg )
	marry_quenching(playerid,msg.num)
end
--����
msgDispatcher[46][5] = function ( playerid, msg )
	cc_player_use_skill(playerid,msg.index)
end

--Buy Skill
msgDispatcher[46][6] = function ( playerid, msg )
	cc_player_buy_skill(playerid)
end

--��������������������
msgDispatcher[46][7] = function ( playerid, msg )
	lianyu_buytimes(playerid)
end

--������������ȡ������������
msgDispatcher[46][8] = function ( playerid, msg )
	lianyu_getworlddata( playerid ,msg.fbid)
end

--һ�ﵱǧ��ȡ����
msgDispatcher[46][10] = function ( playerid, msg )
	yjdq_get_award(playerid,msg.star)
end

--һ�ﵱǧɨ��
msgDispatcher[46][11] = function ( playerid, msg )
	yjdq_saodang(playerid,msg.index,msg.value)
end

--һ�ﵱǧ�������
msgDispatcher[46][12] = function ( playerid, msg )
	yjdq_times_buy(playerid)
end

--һ�ﵱǧ�������ɨ��cd
msgDispatcher[46][13] = function ( playerid, msg )
	yjdq_saodang_buy(playerid,msg.btype,msg.value)
end

-- ����������Ϣ
msgDispatcher[46][14] = function ( playerid, msg )
	get_xtg_panel(playerid)
end

-- ������콱
msgDispatcher[46][15] = function ( playerid, msg )
	get_xtg_award(playerid,msg.itype, msg.idx)
end





