
--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local startVip_Lottery = startVip_Lottery
local getVip_Lottery = getVip_Lottery
local GETVipLottery = GETVipLottery
local Common_startLottery = Common_startLottery
local getCommon_Lottery = getCommon_Lottery
local ZY_startLottery = ZY_startLottery
local startCommon_Lottery = startCommon_Lottery
local Roll_start = Roll_start
local luck_rolling = luck_rolling

--------------------------------------------------------------------------
-- data:

-- �㿪vip�齱
msgDispatcher[24][0] = function ( playerid, msg)	
	startVip_Lottery(playerid,msg.itype)
end
--���vip�齱
msgDispatcher[24][1] = function ( playerid, msg)	
	getVip_Lottery(playerid,msg.itype)
end
--��ȡvip�齱
msgDispatcher[24][2] = function ( playerid, msg)	
	GETVipLottery(playerid)
end
--�㿪��ͳ�齱
msgDispatcher[24][3] = function ( playerid, msg)	
	Common_startLottery(playerid,msg.itype)
end
--��ȡ��ͳ�齱
msgDispatcher[24][4] = function ( playerid, msg)	
	getCommon_Lottery(playerid,msg.itype)
end
---��ʼ��ɽׯ��λ���齱
msgDispatcher[24][5] = function ( playerid)	
	ZY_startLottery(playerid)
end
--ɽׯ��λ���齱
msgDispatcher[24][6] = function ( playerid)	
	ZY_Lottery(playerid)
end
--��ͳ�������
msgDispatcher[24][7] = function ( playerid,msg)	
	startCommon_Lottery(playerid,msg.itype)
end
--------------------Ѱ�����--------------------------------
--����齱
msgDispatcher[24][8] = function ( playerid,msg)	
	fsb_lottery( playerid ,msg.itype,msg.money,msg.last,msg.index)
end
--�鿴�ֿ�
msgDispatcher[24][9] = function ( playerid,msg)	
	fsb_lookbox( playerid )
end
--ȡ����
msgDispatcher[24][10] = function ( playerid,msg)	
	fsb_boxtobody( playerid ,msg.id,msg.itype)
end
--�����콱
msgDispatcher[24][11] = function ( playerid,msg)	
	fsb_getawards( playerid,msg.itype ,msg.num)
end
--�����������־
msgDispatcher[24][12] = function ( playerid,msg)	
	fsb_openpanle(msg.itype)
end

--------------------�񴴱��任����------------------
--�񴴱��任����
msgDispatcher[24][13] = function ( playerid,msg)	
	sctx_changegoods(playerid ,msg.itype,msg.num)
end
--------------------�񴴱��任����------------------
--�����������������
msgDispatcher[24][14] = function ( playerid,msg)	
	fsb_openpanel(playerid,msg.itype)
end
--�䱦�һ�
msgDispatcher[24][15] = function ( playerid,msg)	
	fsb_zbduihuan(playerid,msg.index)
end

--����ת�̳�ʼ��
msgDispatcher[24][16] = function ( playerid,msg)	
		Roll_start(msg.itype)
end

--��ʼ����ת��
msgDispatcher[24][17] = function ( playerid,msg)	
	luck_rolling(playerid,msg.times,msg.itype,msg.buy)
end
--��ȡ���߽���
msgDispatcher[24][18] = function ( playerid,msg)	
	online_getawards(playerid,msg.index)
end

--��ȡ������Ѱ�����ֽ���
msgDispatcher[24][19] = function ( playerid,msg)	
	fsb_getawards_norank( playerid )
end

--�ϻ���
msgDispatcher[24][20] = function ( playerid,msg)	
	lhj_rolling(playerid,msg.level,msg.auto,msg.num)
end

--��ȡ�ϻ���ǰ10����
msgDispatcher[24][21] = function ( playerid,msg)	
	lhj_get_top10( playerid,msg.yesterday)
end

msgDispatcher[24][22] = function ( playerid,msg)	
	lhj_get_prize( playerid,msg.prize_type,msg.level)
end

msgDispatcher[24][23] = function ( playerid,msg)	
	dw_get_prize( playerid,msg.level)
end

------------------------------------------------
------------------------------------------------
--�λÿ���
msgDispatcher[24][24] = function ( playerid,msg)
	dcard_get_cards(playerid,msg.ctype,msg.buy)
end

msgDispatcher[24][25] = function ( playerid,msg)
	dcard_set_mode(playerid,msg.mode)
end

msgDispatcher[24][26] = function ( playerid,msg)
	dcard_pick_card(playerid,msg.index,icount)
end

msgDispatcher[24][27] = function ( playerid,msg)
	dcard_sel_card(playerid,msg.index)
end
msgDispatcher[24][28] = function ( playerid,msg)
	dcard_award_level(playerid)
end
-------------------------------------------------
--������ٻ��콱
msgDispatcher[24][29] = function ( playerid,msg)
	warrior_get_award(playerid)
end

msgDispatcher[24][30] = function ( playerid,msg)
	warrior_use_item(playerid,msg.itemid)
end

--------------------------------------------------
msgDispatcher[24][31] = function ( playerid,msg)
	pjj_get_prize( playerid,msg.level)
end

msgDispatcher[24][32] = function ( playerid,msg)
	zqj_get_prize( playerid,msg.level)
end
--------------------------------------------------
msgDispatcher[24][33] = function ( playerid,msg)
	gqj_get_prize( playerid,msg.level)
end

msgDispatcher[24][34] = function ( playerid,msg)
	sdj_get_prize( playerid,msg.level)
end

--------------------------------------------------
--------------------------------------------------
msgDispatcher[47][1] = function ( playerid,msg)	
	look(msg,2)
	fwc_team_bet( playerid,msg.mtype,msg.team,msg.bets)
end

msgDispatcher[47][2] = function ( playerid,msg)	
	look(msg,2)
	fwc_get_awards( playerid,msg.mtype,msg.team)
end

msgDispatcher[47][3] = function ( playerid,msg)	
	look(msg,2)
	fwc_get_results( playerid,msg.mtype)
end

msgDispatcher[47][4] = function ( playerid,msg)	
	look(msg,2)
	fwc_get_bettime( playerid)
end

