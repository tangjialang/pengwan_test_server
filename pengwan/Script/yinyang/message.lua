
--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local Judge_getskill=Judge_getskill
local lock_skill=lock_skill
local fuseskill=fuseskill
local fuseskill_all=fuseskill_all
local sale_one=sale_one
local sale_all=sale_all
local pick_one=pick_one
local pick_all=pick_all
local get_yypackage=get_yypackage

--------------------------------------------------------------------------
-- data:

--����
msgDispatcher[18][1] = function (playerid,msg)
	Judge_getskill(playerid,msg.five)
end
--����
msgDispatcher[18][2] = function (playerid,msg)	
	lock_skill(playerid,msg.site,msg.lock)
end
-- �ں�
msgDispatcher[18][3] = function (playerid,msg)
	fuseskill(playerid,msg.a_site,msg.b_site)
end
-- һ���ں�
msgDispatcher[18][4] = function (playerid,msg)
	fuseskill_all(playerid,msg.site)
end
-- --��������
-- msgDispatcher[18][5] = function (playerid,msg)
-- 	sale_one(playerid,msg.site)
-- end
-- --���ֶһ�
-- msgDispatcher[18][6] = function (playerid,msg)
	-- yy_exchange(playerid,msg.id)
-- end

-- -- ��ʼ��
-- msgDispatcher[18][7] = function (playerid)
	-- start_yy( playerid )
-- end
--һ������
-- msgDispatcher[18][8] = function (playerid,msg)
-- 	sale_all( playerid,msg.range)
-- end
--ʰȡ
-- msgDispatcher[18][9] = function (playerid,msg)
-- 	pick_one( playerid,msg.site)
-- end
--һ��ʰȡ
-- msgDispatcher[18][10] = function (playerid)
-- 	pick_all( playerid)
-- end
-- ����һ���ں�
-- msgDispatcher[18][11] = function (playerid,msg)
-- --	fuseskill_allback(playerid,msg.site)
-- end
-- ��������������
-- msgDispatcher[18][12] = function (playerid,msg)
-- 	get_yypackage(playerid,msg.site)
-- end
