--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local DJstart = DJstart
local DJbasegame = DJbasegame
local Buy_djenergy = Buy_djenergy
local DJlittlegame = DJlittlegame
local Garniture_start = Garniture_start
local Garniture_set = Garniture_set
local Garniture_cancel = Garniture_cancel
local EnterZY = EnterZY
local StartZYparty = StartZYparty
local InviteallZYparty = InviteallZYparty
local EnterZYparty = EnterZYparty
local look = look
local OutZYparty=OutZYparty
local ToastZYparty=ToastZYparty
local Send_patryinfo=Send_patryinfo
local RequestZYpeople=RequestZYpeople
local Lock_EnterZY=Lock_EnterZY
local Expel_ZY=Expel_ZY
local Get_partybuff=Get_partybuff
local GD_EnterGarden=GD_EnterGarden
local GD_OpenField=GD_OpenField
local GD_SowSeed=GD_SowSeed
local GD_Operations=GD_Operations
local GD_Escape=GD_Escape
local GD_FastOpt=GD_FastOpt
local GD_GetMoneyTree=GD_GetMoneyTree
local GD_AddLuck=GD_AddLuck
local GD_GetFriendList=GD_GetFriendList
local MR_SendRankList=MR_SendRankList
local MR_Fight=MR_Fight
local MR_AwardProc=MR_AwardProc
local MR_Exit=MR_Exit
local MR_ClearRankCD=MR_ClearRankCD
local MR_BuyTimes=MR_BuyTimes
local MRK_GiveAward=MRK_GiveAward
local MRB_PanelInfo=MRB_PanelInfo
local MRB_Robbery=MRB_Robbery
local MRB_Detail=MRB_Detail
local MRB_Attention=MRB_Attention
local MRB_CheckRobTimes=MRB_CheckRobTimes
local MRB_ShowFight=MRB_ShowFight
local MRB_Exit=MRB_Exit
local MTC_GetTecLv=MTC_GetTecLv
local MTC_UpLevel=MTC_UpLevel
local SendPetData=SendPetData
local SetPetStyle=SetPetStyle
local BuyPetStyle=BuyPetStyle

--------------------------------------------------------------------------
-- data:
--˫��
msgDispatcher[21][0] = function (playerid,msg)
	-- rfalse("槼���Ϸ��ʼ")
	-- local itype=msg.itype
	-- if itype==1 then --��ʼ��
	-- 	DJstart(playerid)
	-- elseif itype==2 then--�������Ϸ����Ϸ��Ӧ��1���Σ�2���裬3������4��Ħ,5��ԡ,6˫�ޡ�
	-- 	DJbasegame(playerid,msg.num,msg.index)
	-- elseif itype==3 then--����cd
	-- 	dj_passcd(playerid)
	-- elseif itype==4 then--���С��Ϸ
	-- 	DJlittlegame(playerid,msg.game,msg.num,msg.djnum)
	-- end
	np_shuangxiu(playerid,msg.index ,msg.itype )
end
--��cd
msgDispatcher[21][1] = function (playerid,msg)
	dj_passcd( playerid, msg.itype)
end
--����
msgDispatcher[21][2] = function (playerid,msg)
	DJitemaddliking( playerid ,msg.index,msg.num)
end
--����Ů��
msgDispatcher[21][3] = function (playerid,msg)
	np_opennvpu( playerid,msg.index )
end

------------------------------------------------------------------ װ����Ϣ
msgDispatcher[25][0]=function (playerid)
	Garniture_start(playerid)
end	
msgDispatcher[25][1]=function (playerid,msg)
	Garniture_set(playerid,msg.tag,msg.index)
end	
--ȡ��װ��
msgDispatcher[25][2]=function (playerid,msg)
	Garniture_cancel(playerid,msg.tag,msg.index)
end	
------------------------------------------------------------------ �����Ϣ
--����ɽׯ
msgDispatcher[23][0]=function (playerid,msg)
	look('����ɽׯ')
	-- look(msg)
	-- local nplayerid= GetPlayer(msg.nplayerid, 0)
	-- if type(nplayerid)~=type(0) or nplayerid<0 then
		-- TipCenter(GetStringMsg(664))--������
		-- return
	-- end
	-- look(playerid)
	-- look(nplayerid)
	EnterZY(playerid,msg.nplayerid,1)
end	
--����ϯ
msgDispatcher[23][1]=function (playerid,msg)
	StartZYparty(playerid,msg.num)
end	
--�������
msgDispatcher[23][2]=function (playerid,msg)
look('�������')
look(msg)
	-- local msg1={}
	-- for k,v in pairs(msg.msg1) do
		-- if type(v)==type("") then
			-- local id=GetPlayer(v, 0)
			-- if type(id)==type(0) and  id>0 then
				-- msg1[k]=id
			-- end
		-- end
	-- end
	InviteallZYparty(playerid,msg.msg1)
end	
--�������
msgDispatcher[23][3]=function (playerid,msg)
	-- look('�������')
	-- local nplayerid= GetPlayer(msg.nplayerid, 0)
	-- if type(nplayerid)~=type(0) or nplayerid<0 then
		-- return
	-- end
	EnterZYparty(playerid,msg.nplayerid)
end	
--�˳����
msgDispatcher[23][4]=function (playerid,msg)
	OutZYparty(playerid,nil,0)
end	

--����
msgDispatcher[23][5]=function (playerid,msg)
look(msg)
	ToastZYparty(playerid,msg.nplayerid)
end	
--���������Ϣ
msgDispatcher[23][6]=function (playerid)
look('���������Ϣ')
	Send_patryinfo(playerid)
end	
--����ׯ԰������Ϣ
msgDispatcher[23][7]=function (playerid)
	RequestZYpeople(playerid)
end	
--ׯ԰������
msgDispatcher[23][8]=function (playerid,msg)
	Lock_EnterZY(playerid,msg.itype)
end	
--����ׯ԰���
msgDispatcher[23][9]=function (playerid,msg)
-- look('����ׯ԰���')
	-- local nplayerid= GetPlayer(msg.nplayerid, 0)
	-- if type(nplayerid)~=type(0) or nplayerid<0 then
		-- return
	-- end
	Expel_ZY(playerid,msg.nplayerid)
end	

--����μ����
msgDispatcher[23][10]=function (playerid,msg)
	Get_partybuff()
end	
--���������
msgDispatcher[23][11]=function (playerid,msg)
	party_getendinfo(playerid)
end	
------------------------------------------------------------------ ��԰��Ϣ ------------------------------------------------

-- ��ȡ��԰����
msgDispatcher[22][1] = function (playerid,msg)
	rfalse("GD_EnterGarden")
	GD_EnterGarden(playerid, msg.othersid)
end

-- �������
msgDispatcher[22][2] = function (playerid,msg)
	GD_OpenField(playerid, msg.index)
end

-- �ֲ�
msgDispatcher[22][3] = function (playerid,msg)	
	GD_SowSeed(playerid, msg.index, msg.seedID)
end

-- ��԰����(1 ���� 2 ���� 3 ��ˮ 4 ͵ȡ/�ջ�)
msgDispatcher[22][4] = function (playerid,msg)
	GD_Operations(playerid, msg.othersid, msg.index, msg.opt)
end

-- ��ҧ����
msgDispatcher[22][5] = function (playerid,msg)
	GD_Escape(playerid, msg.othersid, msg.index)
end

-- һ������
msgDispatcher[22][6] = function (playerid,msg)
	GD_FastOpt(playerid, msg.othersid, msg.iType, msg.param)
end

-- ��ȡҡǮ����Ϣ
msgDispatcher[22][7] = function (playerid,msg)
	GD_GetMoneyTree(playerid,msg.iType)
end

-- ʹ������ҩ
msgDispatcher[22][8] = function (playerid,msg)
	GD_AddLuck(playerid, msg.index, msg.luckid)
end

-- ��ȡ�����б���Ϣ
msgDispatcher[22][9] = function (playerid,msg)
	GD_GetFriendList(playerid, msg.page, msg.pidList)
	-- test(playerid, msg.pidList)
end

-- �������صȼ�
msgDispatcher[22][10] = function (playerid,msg)
	GD_UpLandLv(playerid, msg.iType)
	-- test(playerid, msg.pidList)
end


------------------------------------------------------ ׯ԰��λ����Ϣ ------------------------------------------------

-- ��ȡ��λ�б���Ϣ
msgDispatcher[26][1] = function (playerid,msg)
	MR_SendRankList(playerid)
end

-- ��ȡ��λ
msgDispatcher[26][2] = function (playerid,msg)
	MR_Fight(playerid, msg.idx, msg.fid)
end

-- ��λ����������
msgDispatcher[26][3] = function (playerid,msg)
	MR_AwardProc(playerid)
end

-- ��λ���˳���Ϣ����
msgDispatcher[26][4] = function (playerid,msg)
	MR_Exit(playerid)
end

-- ��λ���˳���Ϣ����
msgDispatcher[26][5] = function (playerid,msg)
	MR_ClearRankCD(playerid,msg.iType)
end

-- ��λ�����������Ϣ����
msgDispatcher[26][6] = function (playerid,msg)
	MR_BuyTimes(playerid,msg.num)
end

-- ��λ���콱��Ϣ����
msgDispatcher[26][7] = function (playerid,msg)
	MRK_GiveAward(playerid)
end

-- ��λ�����ٲ鿴
msgDispatcher[26][8] = function (playerid,msg)
	MR_FastView(playerid)
end

-- ��λ�����ٲ鿴
msgDispatcher[26][9] = function (playerid,msg)
	set_fight_obj(playerid, msg.setv)
end

-- ��λ������
msgDispatcher[26][10] = function (playerid,msg)
	MR_Inspire(playerid, msg.iType)
end



---------------------------------------------ׯ԰�Ӷ�-----------------------------------------------

-- ��ȡ�Ӷ��б���Ϣ
msgDispatcher[28][1] = function (playerid,msg)
	MRB_PanelInfo(playerid,msg.iType,msg.param,msg.nPage)
end

-- ׯ԰�Ӷ�
msgDispatcher[28][2] = function (playerid,msg)
	MRB_Robbery(playerid, msg.othersid)
end

-- ��ȡ�Ӷ���ϸ��Ϣ
msgDispatcher[28][3] = function (playerid,msg)
	MRB_Detail(playerid, msg.othersid)
end

-- ��ע
msgDispatcher[28][4] = function (playerid,msg)
	MRB_Attention(playerid, msg.othersid)
end

-- �������
-- msgDispatcher[28][5] = function (playerid,msg)
	-- MRB_CheckRobTimes(playerid, 3)
-- end

-- �鿴ս����
msgDispatcher[28][6] = function (playerid,msg)
	MRB_ShowFight(playerid)
end

-- �˳�
msgDispatcher[28][7] = function (playerid,msg)
	MRB_Exit(playerid)
end

-------------------------------------------------ׯ԰�Ƽ�---------------------------------------

-- ��ȡׯ԰�Ƽ�����
msgDispatcher[30][1] = function (playerid,msg)
	MTC_GetTecLv(playerid)
end

-- ׯ԰�Ƽ�����
msgDispatcher[30][2] = function (playerid,msg)
	MTC_UpLevel(playerid,msg.index)
end

-------------------------------------------------���ﴦ��---------------------------------------

-- ��ȡ��������
msgDispatcher[31][1] = function (playerid,msg)
	SendPetData(playerid)
end

-- �������
msgDispatcher[31][2] = function (playerid,msg)
	BuyPetStyle(playerid,msg.idx)
end

-- �û�����
msgDispatcher[31][3] = function (playerid,msg)
	SetPetStyle(playerid,msg.idx)
end


