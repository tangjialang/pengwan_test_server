
--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher

--------------------------------------------------------------------------
-- data:
--Ԫ���ʼ����Ϣ
--msgDispatcher[42][0] = function (playerid,msg)
	--yuanshen_init(playerid)
--end
--Ԫ������
msgDispatcher[42][1] = function (playerid,msg)
	yuanshen_normal_up(playerid,msg.curtype)
end
--һ������
msgDispatcher[42][2] = function (playerid,msg)
	yuanshen_allup(playerid,msg.curtype, msg.num)
end
--������ս
msgDispatcher[42][3] = function (playerid,msg)
	normal_challenge(playerid,msg.curtype)
end
--һ��ɨ��
msgDispatcher[42][4] = function (playerid,msg)
	all_challenge(playerid)
end
--ɨ��
msgDispatcher[42][5] = function (playerid,msg)
	one_challenge(playerid,msg.curtype)
end
--��������
msgDispatcher[42][6] = function (playerid,msg)
	yuanshen_buytimes(playerid,msg.curtype)
end
--������ͨ����
msgDispatcher[42][7]=function (playerid,msg)
	lianshen_normal_up(playerid)
end
--����һ������
msgDispatcher[42][8] = function (playerid,msg)
	lianshen_all_up(playerid,msg.num)
end

--���񸱱���ս
msgDispatcher[42][9] = function (playerid,msg)
	sl_challenge(playerid,msg.fbID)
end

msgDispatcher[42][10] = function (playerid,msg)
	ysfs_lvl_up(playerid,msg.num,msg.buy)
end

msgDispatcher[42][11] = function (playerid,msg)
	ysfs_use_skill(playerid)
end

msgDispatcher[42][12] = function (playerid,msg)
	ysfs_learn_skill(playerid,msg.level)
end





