--[[
file:	message.lua
desc:	player operation script messages.
author:	chal
update:	2011-12-02
]]--

--------------------------------------------------------------------------
--include:
local msgDispatcher = msgDispatcher
-- local Day_Login = msgh_s2c_def[1][11]
local BG_Time	= msgh_s2c_def[3][2]
local Player_PosFail	= msgh_s2c_def[3][12]
local Player_Salary	= msgh_s2c_def[3][13]
local Player_Spk = msgh_s2c_def[15][12]
local Player_wage_error = msgh_s2c_def[3][17]
local Player_Wage = msgh_s2c_def[3][16]
local Player_7day_error = msgh_s2c_def[3][19]
local Player_7day_data = msgh_s2c_def[3][18]
local AddPosFeats = AddPosFeats
local SendLuaMsg = SendLuaMsg
local TableHasKeys = table.has_keys
local define		 = require('Script.cext.define')
local Define_POS 	= define.Define_POS

local db_module = require('Script.cext.dbrpc')
local GiveMailItem = db_module.give_mail_item

local Touch_Start = Touch_Start
local Chickmoney = Chickmoney
local RequestWorldTransfer = RequestWorldTransfer
local ClickNPCFunciton = ClickNPCFunciton
local GetHangUpExp = GetHangUpExp
local SetShowTitle = SetShowTitle
local GetFriendLuck = GetFriendLuck
local GetLuckExp = GetLuckExp 
local SendFlower = SendFlower
local Flower_Buy = Flower_Buy
local p_GivecbExp = p_GivecbExp
local p_GetOutExpInfo = p_GetOutExpInfo
local Active_Skill = Active_Skill
local Set_Skill = Set_Skill
local Add_geniusnum = Add_geniusnum
local Skill_kill = Skill_kill
local GetSalary = GetSalary
-- local GetLoginAwords = GetLoginAwords
local getgift_serveropen=getgift_serveropen
local BuyPackage = BuyPackage
local Fast_Sale = Fast_Sale
local Face_Change = Face_Change
local SmallSpeak = SmallSpeak
local BroadcastRPC,CI_GetPlayerData = BroadcastRPC,CI_GetPlayerData
local GI_ViewOtherInfo = GI_ViewOtherInfo
local player_buytimes = player_buytimes
local invest = invest
local send_player_wage = send_player_wage
local player_client_login = player_client_login
local xinfa_training = xinfa_training
local xinfa_Start = xinfa_Start
local donate = require("Script.Player.player_donate")		-- ��Ҿ��׾�λϵͳ
local player_donate = donate.player_donate
local get_donate_award = donate.get_donate_award
local get_donate_panel = donate.get_donate_panel
local __G = _G

local awake_module = require('Script.Player.player_awake')
local player_awake_data = awake_module.player_awake_data
local player_get_equip = awake_module.player_get_equip
--------------------------------------------------------------------------
-- data:

--�������ʼ��
msgDispatcher[32][0] = function (playerid,msg)
	Touch_Start(msg.itype)
end
--������
msgDispatcher[32][1] = function (playerid,msg)
	Chickmoney(playerid,msg.itype)
end
--request world transfer
msgDispatcher[3][1] = function ( playerid, msg )
	RequestWorldTransfer( playerid, msg.iType, msg.rid, msg.x, msg.y )
end

-- click npc function step.
msgDispatcher[3][2] = function ( playerid, msg )
	--rfalse('click npc function step:'..msg.index)
	if nil==msg.index then
		return
	end
	if msg.func then
		_G[msg.func]( msg.sid , msg.tag , msg.index )
	end
	ClickNPCFunciton( playerid, msg.npcid , msg.index )
end

--[[
msgDispatcher[3][4] = function ( playerid, msg )
	--rfalse('msgDispatcher[3][4]')
	--OnPlayerBuy(playerid,msg.type,msg.arg)
end

msgDispatcher[3][5] = function ( playerid, msg )
	--rfalse('msgDispatcher[3][5]')
	--OnSelectRelive(playerid,msg.type,msg.check)
end
]]--
--��ȡ�չؾ���
msgDispatcher[3][6] = function ( playerid, msg )
	local result,data,times,times1 = GetHangUpExp(playerid,msg.idx)
	if(result)then
		SendLuaMsg( 0, { ids=BG_Time ,exp = data, t = times, t1 = times1 }, 9 )
	else
		SendLuaMsg( 0, { ids=BG_Time ,err = data }, 9 )
	end
end

msgDispatcher[3][7] = function ( playerid , msg )
	--rfalse('msgDispatcher[3][7]')
	SetShowTitle(playerid,msg.tidList)
end
msgDispatcher[3][10] = function ( playerid , msg )
	 new_bindCodeFromDB(msg.code) 
end
--[[
msgDispatcher[3][8] = function ( playerid , msg )
	--rfalse('msgDispatcher[3][8]')
	GetbackRingExp(msg.type)
end

msgDispatcher[3][9] = function ( playerid , msg )
	--rfalse('msgDispatcher[3][9]')
	--GetNewPlayerGift( playerid )
end



msgDispatcher[3][11] = function ( playerid , msg )
	--rfalse('msgDispatcher[3][9]')
	DR_RequestOut(playerid)
end

msgDispatcher[3][12] = function ( playerid , msg )
	--rfalse('msgDispatcher[3][12]')
	if(msg.cardid~=nil)then GetCardGoods(msg.cardid) end
end

--���߿�ǽ�����ˣ�ֱ�Ӵ�����
msgDispatcher[3][13] = function ( playerid , msg )
	local num = math.random(2,10)
	PI_MovePlayer(Define_POS[num][1],Define_POS[num][2],Define_POS[num][3])
end

]]--

--����ף��
msgDispatcher[3][14] = function ( playerid , msg )
	GetFriendLuck(playerid,msg.selfname,msg.friendname,msg.level,msg.type)
end

--[[�ղ�
msgDispatcher[3][15] = function ( playerid , msg )
	SetCollectFlags(playerid)
end

--���밲ȫ��
msgDispatcher[3][16] = function ( playerid , msg )
	Enteranquanguaji1()
end


]]--
msgDispatcher[3][17] = function ( playerid , msg )
	enemy_find( playerid,msg.osid ,msg.itype)
end

--��ȡ������ף������
msgDispatcher[3][18] = function ( playerid , msg )
	GetLuckExp(playerid)
end

--�ͻ�
msgDispatcher[3][19] = function ( playerid , msg )
	SendFlower(playerid,msg.othername,msg.iType,msg.autobuy,msg.info)
end

--��
msgDispatcher[3][20] = function ( playerid , msg )
	Flower_Buy(playerid,msg.iType,msg.iCount)
end

-- �������а�
msgDispatcher[3][21] = function ( playerid , msg )
	Flower_Buy(playerid,msg.iType,msg.iCount)
end

--[[�ڱ�����
msgDispatcher[3][22] = function ( playerid , msg )
	-- local sData = getEscortData(playerid)
	-- if(sData~=nil and sData.status~=nil and sData.status == 1)then
		-- TipCenter( GetStringMsg(572))
		-- return
	-- end
	freeTransfer(playerid,msg.mapID)
end
]]--
-- msgDispatcher[3][23] = function ( playerid , msg )
	-- p_GivecbExp(playerid,msg.day,msg.buseitem)
-- end

-- msgDispatcher[3][24] = function ( playerid , msg )
	-- p_GetOutExpInfo(playerid)
-- end

msgDispatcher[3][25] = function ( playerid , msg )
	GiveMailItem(playerid,msg.MailID)
end

msgDispatcher[3][26] = function ( playerid , msg )
	onekey_skill(playerid, msg.msg )
end

msgDispatcher[3][27] = function ( playerid , msg )--�����
	Active_Skill(playerid,msg.mark,msg.itype,msg.skillid)
end

msgDispatcher[3][28] = function ( playerid , msg )--�ı似��
	Set_Skill(playerid,msg.mark,msg.itype,msg.skillid)
end
msgDispatcher[3][29] = function ( playerid , msg )--���츳
	Add_geniusnum(playerid)
end

msgDispatcher[3][30] = function ( playerid , msg  )--�������
	friend_special(msg.osid,msg.itype)
end

msgDispatcher[3][31] = function ( playerid , msg )--ϴ��
	Skill_kill(playerid, msg.mark,msg.money)
end
--���ù�ְ��ѫֵ
msgDispatcher[3][32] = function ( playerid, msg )
	AddPosFeats(sid,msg.val)
end
--��ȡٺ»
msgDispatcher[3][33] = function ( playerid, msg )
	local result,data = GetSalary(playerid)
	if(result)then
		SendLuaMsg( 0, { ids = Player_Salary, addpt = data}, 9 )
	else
		SendLuaMsg( 0, { ids = Player_PosFail, t = 2, data = data}, 9 )
	end
end
-- --ÿ��ǩ��
-- msgDispatcher[3][34] = function ( playerid, msg )
-- 	local t,data = GetLoginAwords(playerid)
-- 	SendLuaMsg( 0, { ids = Day_Login, t = t,data = data}, 9 )
-- end
--��7�콱��
msgDispatcher[3][34] = function ( playerid, msg )
	getgift_serveropen(playerid)
end

--�������
msgDispatcher[3][35] = function ( playerid, msg )
	BuyPackage(playerid,msg.itype,msg.index)
end
--��ݳ���
msgDispatcher[3][36] = function ( playerid, msg )
	Fast_Sale(playerid,msg.id,msg.num,msg.x,msg.y)
end
--����ʹ��
msgDispatcher[3][37] = function ( playerid, msg )
	OnUseItem_batch(msg.scriptId , msg.num,msg.bding,msg.nbind)
end
--����ͷ��
msgDispatcher[3][38] = function ( playerid, msg )
	 Face_Change(playerid,msg.num)
end

--������
msgDispatcher[3][39] = function ( playerid, msg )
	 local ret = SmallSpeak(playerid,msg.iType,msg.content)
	 SendLuaMsg( 0, { ids = Player_Spk, res = ret }, 9 )
	 if ret == 0 then
		 local name = CI_GetPlayerData(5)
		 local icon = CI_GetPlayerIcon(0,0)
		 BroadcastRPC('SmallSpeak',name,msg.content,icon)
	 end
end
--���
msgDispatcher[3][40] = function ( playerid )
	Chickmoney(playerid)
end

-- �鿴������Ϣ
msgDispatcher[3][41] = function ( playerid, msg )
	GI_ViewOtherInfo(playerid,msg.other,msg.iType)
end

-- �������ͳһ����
msgDispatcher[3][42] = function ( playerid, msg )
	player_buytimes(playerid,msg.ctype,msg.num)
end

-- ��������
msgDispatcher[3][43] = function ( playerid, msg )
	change_name(playerid,msg.optype,msg.newname)
end
-- ��ʼѲ��
msgDispatcher[3][44] = function ( playerid )
	patrol_on()
end
-- ����Ѳ��
msgDispatcher[3][45] = function ( playerid )
	patrol_off()
end
-- ����PKģʽ
msgDispatcher[3][46] = function ( playerid, msg )
	SetPlayerPKMode(playerid,msg.mode)
end
-- ��ȡ�����һ�
msgDispatcher[3][47] = function ( playerid, msg )
	p_GivecbExp(playerid, msg.idx, msg.opt)
end
-- Ͷ�ʼ����Ǯ
msgDispatcher[3][48] = function ( playerid )
	invest( playerid )
end
-- ���͹�������
msgDispatcher[3][49] = function ( playerid, msg)
	send_player_wage(playerid)
end
-- ��ȡ����
msgDispatcher[3][50] = function ( playerid, msg)
	local result,data = get_player_wage_day(playerid,msg.t)
	if(result == false)then
		SendLuaMsg( 0, { ids = Player_wage_error,data = data}, 9 )
	end
end 
-- ǩ��
msgDispatcher[3][51] = function ( playerid, msg)
	local result,data,days = get_player_wage_login(playerid,msg.d,msg.t)
	look(result)
	look(data)
	if(result)then
		SendLuaMsg( 0, { ids = Player_Wage,data = data, t = 1,days = days}, 9 )
	else
		SendLuaMsg( 0, { ids = Player_wage_error,data = data}, 9 )
	end
end
-- ��ȡ����
msgDispatcher[3][52] = function ( playerid, msg)
	local result,data = get_player_wage_goods(playerid,msg.t)
	if(result)then
		SendLuaMsg( 0, { ids = Player_Wage,data = data, t = 3}, 9 )
	else
		SendLuaMsg( 0, { ids = Player_wage_error,data = data}, 9 )
	end
end

-- ΢�˵�¼����
msgDispatcher[3][53] = function ( playerid, msg)
	player_client_login(playerid)
end

-- 7���¼��ȡ����
msgDispatcher[3][54] = function ( playerid, msg)
	local result,data = login_7day_get_gift(playerid)
	if(result == false)then
		SendLuaMsg( 0, { ids = Player_7day_error,err = data}, 9 )
	end
end

--ÿ���׳��콱
msgDispatcher[3][55] = function ( playerid, msg)
	get_sc_everyday(playerid)
end

-- ս����ƴ
msgDispatcher[3][56] = function ( sname, msg)
	fightcompare(sname)
end

-- -- �ķ��ھ���ʼ��
-- msgDispatcher[3][57] = function ( playerid, msg)
	-- xinfa_Start(playerid)
-- end

--��ʼ�����ķ�
msgDispatcher[3][57] = function ( playerid, msg)
	xinfa_training(playerid)
end
--ʹ��ʱװ
msgDispatcher[3][58] = function ( playerid, msg)
	app_use( playerid,msg.data )
end
--ǿ��ʱװ
msgDispatcher[3][59] = function ( playerid, msg)
	app_enhance( playerid ,msg.index,msg.num ,msg.buy,msg.lastnum)
end

-- ����Ѫ����ֵ
msgDispatcher[3][60] = function ( playerid, msg)
	xb_setvalue( playerid,msg.value )
end
-- ʹ��Ѫ��
msgDispatcher[3][61] = function ( playerid, msg)
	xb_buffback( playerid)
end
-- ���ڸ�ѹ��Ǯ
msgDispatcher[3][62] = function ( playerid, msg)
	CJ_GiveHB( playerid, msg.num )
end
-- ����
msgDispatcher[3][63] = function ( playerid, msg)
	change_sex(playerid,msg.sex,msg.equip)
end
-- תְ
msgDispatcher[3][64] = function ( playerid, msg)
	change_school(playerid,msg.school,msg.equip)
end
-- ս�����Ա�
msgDispatcher[3][65] = function ( playerid, msg)
	att_look( msg.osid,msg.itype )
end

-- 360��Ͷ��
msgDispatcher[3][66] = function ( playerid, msg)
	GiveNewTouziAward(playerid)
end
-- ��������� �����֤
msgDispatcher[3][67] = function ( playerid, msg)
	tired_getnum( playerid ,msg.num,msg.name,msg.isup)
end

-- ��Ҿ��׾�λϵͳ----------------------------------------
-- ����ͭǮ��num ����������
msgDispatcher[3][68] = function ( playerid, msg)
	player_donate(playerid, msg.num)
end
-- ��ȡ���׽�����idx ����������
msgDispatcher[3][69] = function ( playerid, msg)
	get_donate_award(playerid, msg.idx)
end
-- ����������а�
msgDispatcher[3][70] = function ( playerid, msg)
	get_donate_panel(playerid)
end

--��Ҫ����
msgDispatcher[3][71] = function(playerid, msg)
	player_awake_data(playerid, msg.itype)
end

--��ȡ���ѳɹ�
msgDispatcher[3][72] = function(playerid, msg)
	player_get_equip(playerid)
end


-- GM����
msgDispatcher[3][255] = function ( playerid, msg )
	--rfalse('msgDispatcher[3][255]:'..playerid)
	__G.ScriptGMCMD(playerid,msg.gCMD,msg.args)
end

msgDispatcher[44][1] = function ( playerid, msg )
	shenqi_stamp_visible(playerid,msg.val);
end


