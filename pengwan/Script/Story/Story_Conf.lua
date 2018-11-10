--[[
file:	Story_conf.lua
desc:	story config(S&C)
author:	chal1
update:	2011-12-01
version: 1.0.0

flynpc//����ȥ��npc
flyPos
׷���������õ���ţ�200084
ǿ��
0: ����
1���·�
2������
3��Ь��
4������
5����׹
6������
7����ָ

���Ա����: {Ů,��}
��ְҵ����:{����,����,����}
��ְҵ�Ա����:{����Ů,������,����Ů,������,����Ů,������}
]]--

talk = {}
talk.sex = function()
	return "{IF(Prop('sex')==1,'����','Ů��')}"
end
talk.name = function()
	return "<font color='#f8ee73' >{Prop('myname')}</font>"
end


storyList = {}

------------�״ν�����Ϸ��ʾ

storyList[100000] =
{

	TaskName = "Ӣ�۾���",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	AcceptInfo = "��ؼ�ɱ��ӿ�����ۿ���ٽ�������ȴ��5��ǰ<font color='#FFFF00' >��Խ</font>���ˣ�����������һ�߱���������֮����Ī���ڴˣ��ж����˵����˱������ı��أ�", --��������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {1,1},	-- ���͸���̨��������
	--onClick = 1,	-- ��̨��̶�����OnClickStory_storyid()
	
}
storyList[100001] =
{

	TaskName = "Ӣ�۾���",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,2},             --Ӣ�۾���
	TaskGuide=1,						-- ��������
	RS = {'DynamicSrc.swf'},
	TaskInfo = "���ű���Ļ���ȥ��������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >ͽ�ܣ�������˻��ţ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʦ������Ⱦ�槼��ɡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��Ů�Ļ����ѱ���ɢ������Ҫȥ�ռ���ɢ�Ĳ��ǲ����������ѣ� </font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҫȥ�������أ�</font>", --�������Ի�
	--HelpInfo = "",		��������
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
		
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		--[[
		kill = { "M_004", 1 ,{1 }},
		kill = { "M_004", 1 ,{3,2 }}, 
		equiplevel = {101,5}, 
		equipbs = 1,
		--herolevel = 10,
		--horselevel = 5,
		taskhuan = 3,
		mfb = 1,
		bfb = 1,
		pm =1,
		homebattle =1,
		homewar =1,
		husong = 1,
		daji = 1 			��ʾ   ��槼���Ϸһ��      ��������԰
		yaoqian =1        ��ʾ   ��ҡǮ���ջ�һ��    ��������԰
		zhenyao =1          ��ʾ ���һ�������� ����������������
		monsterList =111        ��ʾ ��ħ¼���3�ǹ���(0/1)������򿪽�ħ¼���
		kill = {1,3}		��ʾ ��������������3��   ����򿪼������
		]]--
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {1,2},	-- ���͸���̨��������
	--onClick = 1,	-- ��̨��̶�����OnClickStory_storyid()
	----ClientCompleteAwards = 1 , ��ʾ������Ľ���Ʒ����ʾ������׷�����
}
storyList[100002] =
{

	TaskName = "��ת��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,4},             --Ӣ�۾���
	TaskGuide=1,						-- ��������	
	
	RS = {'plot.swf'},		--Ԥ���ع����NPC��Դ
	TaskInfo = "�Ҷ�ʦ����ȡ��ת��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ȥ�����ʦ����Ҫ��ת���޸����ǣ�Ȼ���������㡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���Ͼ�ȥ��</font>", --��������Ի�
	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
		
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1001},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_004", 1 ,{3,88,142}},
	},
	AutoFindWay = { true, Position={3,88,142}},
	task = {1,3},	-- ���͸���̨��������
};

storyList[100003] =
{

	TaskName = "��ѵ���",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,6},             --Ӣ�۾���
	TaskGuide=1,						-- ��������	
	TaskInfo = "���ʦ���ѵ���\n����Z�����ɽ����Զ����",		-- ��������
	SubmitInfo = "\t<font color='#e6dfcf' >��Щ�ɶ��������͵��ҩ�� </font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ʦ�㣡</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
		
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1002},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_004", 1 ,{3,77,138}},
	},
	AutoFindWay = { true, Position={3,77,138}},
	task = {1,4},	-- ���͸���̨��������
};

storyList[100004] =
{

	TaskName = "�����ټ�",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,8},             --Ӣ�۾���
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��Сʦ���������������֪һö�л��ȥ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ҩ��������ˣ��ղ��ҿ�һĨ���ɹ���������һЩ�лꡣ</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����Ī���ǣ��ҸϽ�ȥ������</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ǰ�����Ҳ����һЩ�л�ɹ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���������ô��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�

	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
		
	},		
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1003},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {1,5},	-- ���͸���̨��������
};

storyList[100005] =
{

	TaskName = "ͻ���谭(һ)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,10},             --Ӣ�۾���
	TaskGuide=1,						-- ��������
	TaskInfo = "ͻ����·����ħ��׷Ѱ�л�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >����С�ģ�·����һȺ��ħ��·.</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ģ��Ѳ����ң�</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ô���ڲ��������Ȱ�ҩ���˰ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лʦ�㡣</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1004},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_005", 1 ,{3,56,155}},
	},
	AutoFindWay = { true, Position={3,56,155}},
	task = {1,6},	-- ���͸���̨��������
};

storyList[100006] =
{

	TaskName = "ͻ���谭(��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,12},             --Ӣ�۾���
	TaskGuide=1,						-- ��������
	TaskInfo = "ͻ����·����ħ��׷Ѱ�л�",		-- ��������
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1005},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_005", 2 ,{3,67,163}},
	},
	AutoFindWay = { true, Position={3,67,163}},
	task = {1,7},	-- ���͸���̨��������
};
storyList[100007] =
{

	TaskName = "ͻ���谭(��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,14},             --Ӣ�۾���
	TaskGuide=1,						-- ��������
	NoTransfer = 1,			
	TaskInfo = "ͻ����·����ħ��׷Ѱ�л�",		-- ��������
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1006},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_005", 2 ,{3,74,172}},
	},
	AutoFindWay = { true, Position={3,74,172}},
	task = {1,8},	-- ���͸���̨��������
};
storyList[100008] =
{

	TaskName = "ͻ���谭(��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,16},             --Ӣ�۾���
	TaskGuide=1,						-- ��������
	TaskInfo = "ͻ����·����ħ��׷Ѱ�л�",		-- ��������
	--AcceptInfo = "\t<font color='#e6dfcf' >������Ƭ֮�䶼�и�Ӧ����������᪽�Ұ��һ����ǬԪɽ������槼��ļ���������᪣��������ȥ�������ļ��ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ȥ��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�����������ȱ���ǵİɣ���˳·��������һ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ллʦ�㡣</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1007},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_047", 2 ,{3,84,179}},
	},
	AutoFindWay = { true, Position={3,84,179}},
	task = {1,9},	-- ���͸���̨��������
};

storyList[100009] =
{

	TaskName = "׼����ɽ",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,18},             --Ӣ�۾���
	TaskGuide=1,						-- ��������
	TaskInfo = "����Ĳл��������᪷���׼����ɽ׷Ѱ",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���⣬�ҿ�������Ļ�����Ƭ�����������᪷���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ͳ�����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��Ҫ��ɽô��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǰ������ʦ������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1008},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {1,10},	-- ���͸���̨��������
};
storyList[100010] =
{

	TaskName = "ǰ�����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,20},             --Ӣ�۾���
	TaskGuide=1,						-- ��������
	TaskInfo = "Ϊ��׷Ѱ����Ļ��ǣ������ǰ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >·����С�ģ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��ʦ�֣�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >����ֹ���������ʾ֤����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������ı������Ҳ��רҵŶ��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1009},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {1,50},	-- ���͸���̨��������
};
--���ִ��������
storyList[100050] =
{

	TaskName = "������Ϣ",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,22},             --Ӫ���ջ�
	TaskGuide=1,						-- ��������
	RS = {'H_06_0_01','H_06_0_02'},	--Ԥ���ع����NPC��Դ
	TaskInfo = "����᪴���槼�����-���ݺ��ջ�����Ϣ",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���ݺ��ջ����ˣ���һ��С����ô֪��������������ո�����Ůһֱ�ڽ�Ұ��ڸ����������ȥ��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��磡</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >С��ʧ���ˣ���үҲ���������������Ǻã�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ʲô���ˣ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1010},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {1,51},	-- ���͸���̨��������
};
storyList[100051] =
{

	TaskName = "�������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,27},             --Ӫ���ջ�
	TaskGuide=1,						-- ��������
	RS = {'plot_1000134.dat'},
	TaskInfo = "��ѵ����������ջ������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >����ү����������ķ��ڿ�ջ��ȥ��С���ˣ���һȺ������ռ�˿�ջ���Ҷ�����ȥ�չ����ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�Ұ���������ǣ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >лл���ˣ�����һ��Ҳ����������æ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��˵��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1050},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_095", 2 ,{1,24,156}},
	},
	AutoFindWay = { true, Position={1,24,156}},
	task = {1,54},	-- ���͸���̨��������
};

storyList[100054] =
{

	TaskName = "Ӫ���ջ�",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,30},             --Ӫ���ջ�
	TaskGuide=1,						-- ��������
	RS = {'N_2028_0_01','N_2028_0_04','N_2005_0_01','N_2005_0_02','N_2005_0_04','N_2005_0_10','openUI.swf'},	--Ԥ���ع����NPC��Դ
	
	TaskInfo = "���ȱ�а�鸽����ջ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��үȥ��᪽�ҰѰ��С��ʱʧ���ˣ��ҽ���ү��������㣬������ȥ������ү�ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�岻�ݴǣ����̳�����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��л�����Ȼ����ջ����ˣ��������˻������ظ���Ϣ��������������������һƥ��Ϊл��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���˿����ˣ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1051},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_097", 1,{1,36,169,1},"槼�����"},
	},
	--AutoFindWay = { true,  Position2={1,36,169}},
	task = {1,58},	-- ���͸���̨��������
};

storyList[100058] =
{

	TaskName = "�����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,36},             --����֮��
	TaskGuide=1,						-- ��������
	RS = {'H_01_0_01','H_01_0_02','plot_1000002.dat'},
	TaskInfo = "������ټ���ȥ��������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�ղ���������������㣬��ȥ�������ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ŷ�������ȥ��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >Ӣ�۹�Ȼ�Ǳ��������ܹ�����������ʿ��"..talk.name().."������Ȥ�����ҹ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >лл������Ҫ������ʦ����</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1054},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		horselevel = 3,
	},
	--AutoFindWay = { true, SubmitNPC = true},
	task = {1,60},	-- ���͸���̨��������
};

--�޸ľ���
storyList[100060] =
{

	TaskName = "�ر�ʦ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,38},             --����֮��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "����������ļ�Լ�����Ҫ���ʹ�ʦ����������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ʦ��������Ҳ���ҳ�Ϊ�٣���Ӧ�û�ͬ��ġ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ʾʦ��������������</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >���´��ң�����Ŀǰ��ʵ���������Ծ�����ˮ��֮�а���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�Ǹ�����Ǻã�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1058},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {2,33},	-- ���͸���̨��������
};

storyList[200033] =
{

	TaskName = "��������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,39},             --Ӫ���ջ�
	TaskGuide=1,						-- ��������
	RS = {{'N_9031_0_10','N_9030_0_10','N_9033_0_10','N_9032_0_10','N_9035_0_10','N_9034_0_10'}},
	TaskInfo = "ѧϰ�ڶ������ܲ���������1��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�ȼ���������Ի�ü��ܵ㣬���似�ܵ�����ѧϰ����ļ��ܡ� </font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��֪���ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��ô������û�о����Լ��������ˣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ǲ�����</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1060},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		skill = {2,1},
	},
	--AutoFindWay = { true, SubmitNPC = true},
	task = {2,1},	-- ���͸���̨��������
};

storyList[200001] =
{

	TaskName = "ѧ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,40},             --����֮��
	TaskGuide=1,						-- ��������
	
	
	TaskInfo = "��̫��������̱�ǿ�ķ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ʦ��̫�����˴�ʱ��ǬԪɽ��������ȥ����ѧϰ����ķ����ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лʦ����</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >������ѧϰǿ���ļ��ܣ���Ҫͨ���ҵĿ�����С�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʦ����Ը���</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		"PlayerTip(45)"
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2033},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	},
	--AutoFindWay = { true, SubmitNPC = true},
	task = {2,2},	-- ���͸���̨��������
};

storyList[200002] =
{

	TaskName = "���",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,46},             --����֮��
	TaskGuide=1,						-- ��������
	RS = {{'N_9025_0_02','N_9024_0_02','N_9027_0_02','N_9026_0_02','N_9029_0_02','N_9028_0_02'}},
	TaskInfo = "��ɱ3ֻ���ռ��㹻�����Ѫ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�������ȥɱ��ֻ���ɣ��ռ����ǵ�Ѫ��Ȼ�󽻸���������ʦ�֡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >��ô��ͻ��������ռ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʦ�����Ŀ��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2001},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_028", 3 ,{7,40,35}},
	},
	AutoFindWay = { true,  Position={7,40,35}},
	task = {2,3},	-- ���͸���̨��������
};
storyList[200003] =
{

	TaskName = "��¹",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,48},             --����֮��
	TaskGuide=1,						-- ��������
	RS = {'plot_1000008.dat'},
	TaskInfo = "��ɱ3ֻ��¹���ռ��㹻��¹�ס�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���Ĳ������ɾ�ʿ��ҪһЩ¹�ף���ȥ����һ�°ɣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >Ŷ�������Ϻõ�¹�װ�����ֻҪһ���־Ϳ����ˣ����������Լ��պã�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >֪���ˡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2002},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_029",3 ,{7,33,58}},
	},
	AutoFindWay = { true,  Position={7,33,58}},
	task = {2,12},	-- ���͸���̨��������
};

storyList[200012] =
{

	TaskName = "������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,50},             --����֮��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "���ϼͯ��ѯ������ҵ���������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�ղ����˴�����˵��Ҫһ�����������㵽�ٲ��߽�ϼͯ���������ʡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ȥ��</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >����������֪��������Ŷ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������ҡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2003},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		--items = {{10005,1,{7,43,95,100026}}},
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {2,4},	-- ���͸���̨��������
};

storyList[200004] =
{

	TaskName = "��������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,52},             --����֮��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "������У��ҵ���������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�ٲ��µĺ��о��У�������ȥ�Ϳ��Կ����ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������£����Ѷ��е���˰ɡ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >���ǵģ�ͻȻ������������һ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����һ��֪����������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2012},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		jump = {7,39,68,1}

	},
	AutoFindWay = {true,Position2={7,39,68,1}},
	task = {2,32},	-- ���͸���̨��������
};

storyList[200032] =
{

	TaskName = "�ɼ�����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,54},             --����֮��
	TaskGuide=1,						-- ��������
	
	RS = {{'N_9901_0_01','N_9902_0_01','N_9903_0_01'},'N_9997_0_01'},
	TaskInfo = "�ɼ�һ����������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���������Ƕ�����������ˣ�������������ߣ������Ӽǵø��ҡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�����Ӹ��Ұɣ���Ҫ�����µ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ȫ�����㡣</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2004},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10005,1,{7,43,95,100026}}},
	},
	AutoFindWay = { true,   Collection={7,43,95,100026}},
	task = {2,5},	-- ���͸���̨��������
};

storyList[200005] =
{

	TaskName = "��֮����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,56},             --����֮��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��ɿ��飬̫�����˽��ھ��Ѿ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >̫�����������õ������͸Ͽ��ȥ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ͻ�ȥ��</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >���ռ���������Ʒ��ѧϰ�����ı�Ҫ���ߣ������Ҿʹ������������֮���ѡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лʦ�塣</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		"PlayerTip(45)"
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2032},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	--AutoFindWay = { true, SubmitNPC = true},
	task = {2,11},	-- ���͸���̨��������
};

storyList[200011] =
{

	TaskName = "ʦ��ѵ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,58},             --����֮��
	TaskGuide=1,						-- ��������
	RS = {'N_2038_0_01','N_2039_0_01','N_2013_0_99'},
	TaskInfo = "̫���������㽻�����Ѽ��ܵ�ע�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���Ѽ���Ҫ���ʹ�ã����ܵ���Ӧ�֣���������������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >֪���ˣ�ʦ�塣</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���Ѿ�ѧ�����µļ��ܣ��ɸ�ȥ��ⶴһ�㣬���������ǧ���������û������ڵ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�кβ��ҡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2005},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},

	AutoFindWay = { true, SubmitNPC = true},
	task = {2,13},	-- ���͸���̨��������
};
storyList[200013] =
{

	TaskName = "��ⶴ",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,60},             --����֮��
	TaskGuide=1,						-- ��������
	RS = {'N_2013_0_01'},
	TaskInfo = "���ض�ͯ����̽����ⶴ�ķ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�õ�ɫ��ȥ���ض�ͯ�Ӱɣ��������������ⶴ�ķ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ȥ��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������ⶴ��ռ��������������Ǻ�������Ŷ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������Ҳ�������ſ�¡�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		"PlayerTip(46)"
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2011},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},

	--AutoFindWay = { true, SubmitNPC = true},
	task = {2,6},	-- ���͸���̨��������
};


storyList[200006] =
{

	TaskName = "������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,62},             --����֮��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�����ⶴ1���һֻ��������ȡ�������ڵ�����ػ�����Ƭ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >֮ǰ��˵�������õ���һ��Ů�ӻ�����Ƭ����Ҫ����Ϊ���ܡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ů�ӻ��ǣ��ѵ���槼��ġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�úúã���Ȼû�й����ҵ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����һ���ͿɾȻ�槼��ˡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2013},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "B_032", 1 ,{7,6,19,1},"槼�����"},
	},

	AutoFindWay = { true,   Position2={7,6,19}},
	task = {2,7},	-- ���͸���̨��������
};


storyList[200007] =
{

	TaskName = "ǰ����Ұ",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,64},             --����֮��
	TaskGuide=1,						-- ��������
	RS = {'N_2042_0_01'},
	TaskInfo = "���¾߱�������ǰ����᪽�Ұ",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�������ڵ�ʵ����ǰ����᪽�Ұ��ȫ����Ӧ���ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʦ���ټ���</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��������˭���Ⱦ��ң�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ô���£�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		"PlayerTip(43)"
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2006},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	},
	--AutoFindWay = { true, SubmitNPC = true},
	task = {1,100},	-- ���͸���̨��������
};

--��᪽�Ұ����ʼ
storyList[100100] =
{

	TaskName = "������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,67},             --����֮��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "����Ұ�����˶��\n����Z�����ɽ����Զ����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >һȺ����ں��棬�Һú��£�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���Ǻ��ˣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����������У���Ϊ�λ������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2007},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		kill = { "M_009", 4 ,{6,29,135}},
	},
	AutoFindWay = { true, Position={6,29,135}},
	task = {1,99},	-- ���͸���̨��������
};

storyList[100099] =
{

	TaskName = "���ȴ峤",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,70},             --����֮��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�ҵ��ϴ峤����������ȫ�ĵط�ȥ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�ϴ峤ˤ�����ȣ�����Ҫ�ҵ��ӹǲݲ����κ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����̫Σ�գ��Ұ���ȥ�ɡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�����˿��뿪����ɣ������Ѿ����ʺ���ס���ˣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ү�����������뿪�ɡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1100},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10007,1,{6,64,107,100011}}},
	},
	AutoFindWay = {true,Collection={6,64,107,100011}},
	task = {1,101},	-- ���͸���̨��������
};
storyList[100101] =
{

	TaskName = "���Թ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,74},             --����֮��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�����ε��ڴ����Թ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�������ҵļ��磬����Ҳ�����뿪����Ҫ����Щ����ͬ���ھ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ү���ģ�������Ϊ�������������ｻ�����ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��������ﰡ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ô�ˣ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1099},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		kill = { "M_010", 4 ,{6,44,97}},
	},
	AutoFindWay = { true, Position={6,44,97}},
	task = {1,98},	-- ���͸���̨��������
};

storyList[100098] =
{

	TaskName = "Ѱ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,77},             --����֮��
	TaskGuide=1,						-- ��������
	RS = {'N_2031_0_01'},
	TaskInfo = "�ڽ�Ұ�ҵ���ʧ�������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >����������ʱ������ɢ�ˣ�������ô������ҵ��������˼Ұ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ȵ���᪳�ȥ���Ұ������ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�����������õļ�԰������Щ�����ƻ��Ĳ��������ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������������ѱ�����������������ǰ�����ؼҡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1101},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {1,102},	-- ���͸���̨��������
};

storyList[100102] =
{

	TaskName = "������ʿ",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,82},             --����֮��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "������˵��һ����������ȥ׷��ħ�������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >̫��л�ˡ����ˣ��ղ��и�С����˵ҪȥѰ��ħ�����Դ�������������ġ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ŷ����������������ʿ����ȥ֧Ԯ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��������һ�¾Ͱ���Щ�������仨��ˮ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' > ��������Ҳ�����</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1098},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		kill = { "M_011", 4 ,{6,59,31}},
	},
	AutoFindWay = { true, Position={6,59,31}},
	task = {1,103},	-- ���͸���̨��������
};
storyList[100103] =
{

	TaskName = "���ƹű�",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,84},             --����֮��
	TaskGuide=1,						-- ��������
	RS = {'N_2042_0_01','N_2042_0_04','N_2042_0_10'},
	TaskInfo = "������ʿ˵���ﶼ�Ǵ�һ�����ƵĹű���ð�����ģ�ȥ����һ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ѧ�ղ������Ѿ�����ǰ���ˣ������ҷ��ֹ�����Դ���Ǵ�һ���ű���ð�����ģ�����Ͱ������ˣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ģ������������ҾͿ����ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��ű���Ϊ��ѹ�»�Ұ���޽��ģ����ű�����ǰ���ƻ��ˣ�����Թ��ŷ׷׳��֡� </font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ħ�������ұ���ְ����ȥ������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1102},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		items = {{10003,1,{6,32,63,100010}}},
	},
	AutoFindWay = { true, Collection={6,32,63,100010}},
	task = {2,14},	-- ���͸���̨��������
};
--��������
storyList[200014] =
{

	TaskName = "����ǿ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,88},             --����֮��
	TaskGuide=1,						-- ��������
	RS = {'diceEffect.swf'},	
	TaskInfo = "������ǿ����3��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�Եȣ�֮����ܻ�Ҫ�Ը���ǿ�ĵ��ˣ�����ǿ��һ������Ϊ�ã�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ҳ�á�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >ϣ�����ܽ��ű����ƻ��������������� </font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ʲô������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1103},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		equiplevel = {0,3},
	},
	--AutoFindWay = { true, Collection={6,32,63,100010}},
	task = {1,104},	-- ���͸���̨��������
};


storyList[100104] =
{

	TaskName = "�����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,90},             --����֮��
	TaskGuide=1,						-- ��������
	
	RS = {'N_2062_0_01','N_2062_0_02'},	--Ԥ���ع����NPC��Դ
	TaskInfo = "ԭ����Ұ���������ڣ������˴���ԩ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���ֵ�ԩ�궼Χ������������ĵľ����������������ػ���ʲô��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ǰȥ��̽һ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��...... </font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ԩ��ö࣬�о��е��ľ��֧��!</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2014},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		kill = { "M_012", 5 ,{6,10,48}},
	},
	AutoFindWay = { true,  Position={6,10,48}},
	task = {1,115},	-- ���͸���̨��������
};
storyList[100115] =
{

	TaskName = "ʦ������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,92},             --����֮��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "���ҽ����е�3�ף�Э����һ����ս��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��.......</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���Һ�ʦ��һ����������ǡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���˵�ζ��������û�л��Ǻã���ϧû�гԵ��� </font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ǣ�˵�����￴���ģ���˵��һ�������㣡</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1104},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{	
		herolevel = 3,
	},
	--AutoFindWay = { true,  Position={6,10,48}},
	task = {1,105},	-- ���͸���̨��������
};
storyList[100105] =
{

	TaskName = "�ٹ�����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,94},             --����֮��
	TaskGuide=1,						-- ��������
	
	RS = {'N_2003_0_01','N_2003_0_04','N_2003_0_10'},	--Ԥ���ع����NPC��Դ
	TaskInfo = "����ٹ������ϵ���ħͷĿ",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >����Ϣŭ���Ҹյõ����ǣ��ͱ�ͷĿ�����ˣ���������ʲô����֪����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ɶ������Ȼ���򵥡�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."����л��Ѱ��槼��Ļ��ǣ��븴�����ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1115},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		kill = { "B_015", 1 ,{6,41,13,1},"槼�����"},
	},
	AutoFindWay = { true,  Position2 ={6,41,13}},
	task = {1,56},	-- ���͸���̨��������
};

storyList[100056] =
{

	TaskName = "��Ů�ط�",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,96},             --Ӫ���ջ�
	TaskGuide=1,						-- ��������
	RS = {'N_1033_0_01','N_1120_0_01'},	--Ԥ���ع����NPC��Դ
	TaskInfo = "�ջ�����槼���Ů�����ط�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��л"..talk.name().."�����Ҹ�Ů�ط꣬����ΪСŮ�İ�ȫ����Ը����һ��ׯ԰�������չ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����̫�����ˣ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��ׯ԰���˰���СŮ���⣬����һ����Ҫ�Ĺ��ܡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ŷ��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1105},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		daji = 3,
	},
	
	task = {1,57},	-- ���͸���̨��������
};

storyList[100057] =
{

	TaskName = "�ɼҹ�԰",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskTrack = {1004,5,100},             --Ӫ���ջ�
	TaskGuide=1,						-- ��������
	
	
	TaskInfo = "��԰��ֲ���Ի��ͭǮ������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�Ǿ���ׯ԰�Դ��Ĺ�԰����԰�п�����ֲ�ɼ�ֲ�������ͭǮ��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ۣ�����������Ȼ�Ǻñ�����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������"..talk.name().."������������´��ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ħ�����������ұ�ְ��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1056},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {1,106},	-- ���͸���̨��������
};
storyList[100106] =
{

	TaskName = "�ټ������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,1},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "������������㣬��ȥ�������ɡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���������������������ȥ������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õģ������Ͼ�ȥ��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."����л�����˽�Ұ�Ļ����������Ǻ�����ǡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ұ�Ӧ�����¡�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1057},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,107},	-- ���͸���̨��������
};
storyList[100107] =
{

	TaskName = "�ݼ�ʦ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,2},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	RS = {'H_21_0_01'},
	TaskInfo = "�ٴμ���ʦ��������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��Σ����Ը��Ϊ����Ч���������������ʰ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҫ�ʹ�ʦ�����ܾ�����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >ͽ������ɽ������һ�����о���Σ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������Ű���������࣬�������ԣ��ΰ����ð���</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1106},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,108},	-- ���͸���̨��������
};
storyList[100108] =
{

	TaskName = "�������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,3},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "����ʦ����������ܳ�",		-- ��������
	RS = {'H_21_0_01'},	--Ԥ���ع����NPC��Դ
	AcceptInfo = "\t<font color='#e6dfcf' >��᪵�������һ���˽ܣ�Ϊʦ�������������Ʒ��������������Ը������һ��֮����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ȼ��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."��������ͬ���ˣ�������������ú�����ء�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ɽ��������������֮��ҲҪ����Ӧ�٣�ԸЧȫ����</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1107},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,109},	-- ���͸���̨��������
};
storyList[100109] =
{

	TaskName = "������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,5},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "һֱƣ�ڱ��������������һ���䣬����������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >̫���ˣ�����һҪ��Ҫ�и�����������������ƣ�����棬��������Ϣ���ա�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ҳ�ã��������зԸ�����ֱ�Ӵ������ջ������ɡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ع���𣚣�ں�֮�ޣ�����Ů�����Ӻ��ϡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�˴����������쵽��......</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1108},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		
	},
	AutoFindWay = { true,  flynpc = true},
	task = {1,110},	-- ���͸���̨��������
};
storyList[100110] =
{

	TaskName = "����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,7},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�������һ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >ǧ����Եһ��ǣ���ҵ���Ե���������أ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ե�������ޱȣ�Ҳ��������֮�˾��������ߡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��λ"..talk.sex().."������棬������Ե��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ե������Ī����......</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1109},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,112},	-- ���͸���̨��������
};
storyList[100112] =
{

	TaskName = "����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,9},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��������һ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >����Ϊ�ѵ����ӣ�����Ҫ�Ұ���ǣ�ߣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������л�ˣ��ҽ���һ���������㡣</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >Ը�����������ճɾ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����Ϊ���׿ɾ����������ˡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1110},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,113},	-- ���͸���̨��������
};

storyList[100113] =
{

	TaskName = "�µ�����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,13},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "���ܵ��µ�����׼���ٴγ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�Ƿ���������Ĵ����㣡</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����Ͼ�ȥ��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."���������ã������������Ÿ��㡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����뽲��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1112},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,114},	-- ���͸���̨��������
};

storyList[100114] =
{

	TaskName = "ǰ��������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,15},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "������������ǰ��ǰ��������˵���ܱ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�����������ܱ���������������д�ţ�����ϣ����ǰȥ˵������˳�ҹ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >û���⣬�����̳�����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�Եȣ����������µ��鱨������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʲô�鱨��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1113},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {2,17},	-- ���͸���̨��������
};

storyList[200017] =
{

	TaskName = "�ҽ�����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,18},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "���ҽ����е�5�ף�����ս��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������ļҽ���������5����ȥ�����ذɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������Ҫ��˭��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ã�����ר�����ݷ��ܱ�����˵ġ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1114},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		herolevel = 5 
	},
	--AutoFindWay = { true,  SubmitNPC = true},
	
	task = {1,150},	-- ���͸���̨��������
};

--ǰ������������
storyList[100150] =
{

	TaskName = "��Ӱ����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,19},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	RS = {'N_2025_0_01','N_2025_0_02','N_2025_0_03','N_2025_0_04','N_2025_0_10'},
	TaskInfo = "�㷢�ֳ�����������һ����Ӱ����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�ҼҴ��˳�ȥѲ���ˣ����ڸ��С�����ԵȻ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ǲ��ɣ�Ҳ�ã��Ҿ�ȥ���תת��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�������ڵ����ⲻ��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ϰ�������ô�ˣ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2017},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{	
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,151},	-- ���͸���̨��������
};
storyList[100151] =
{

	TaskName = "�ٹ�ҹ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,20},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	--TIPtype = 3,
	
	TaskInfo = "����Ƶ��Ϸ���а��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >����������ô���ҾƵ������и��ײ��̣�������Ǵ������µ��������鷳�����ȥ������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >С��һ׮��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >лл���ˣ��㲻�ó����ص����߾�����Щ����ɢ����ȥ�ġ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʲô���ߣ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1150},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		kill = { "M_016", 5 ,{8,16,17}},
	},
	AutoFindWay = { true,  Position={8,16,17}},
	task = {1,152},	-- ���͸���̨��������
};
storyList[100152] =
{

	TaskName = "��������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,22},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	TIPtype = 3,
	TaskInfo = "�Ƶ��ϰ�����㣬��������������˿��µ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��������������˿��µ����ߣ����˲����ˣ��Ƿ��ӳ���ͷ�����ء�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���д��£���ȥ������</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�����ص�������������ֵģ��������ڣ�����ҽ�Ρ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ī�������߲�����Ȼ���ֵģ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1151},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		
	},
	--AutoFindWay = { true,  SubmitNPC = true},
	task = {1,153},	-- ���͸���̨��������
};
storyList[100153] =
{

	TaskName = "Ѱ��ҩ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,23},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	TIPtype = 3,
	TaskInfo = "ȥ��ҩ���ϰ�ѯ���Ƿ���ҽ�����ߵ�ҩ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�鷳������ȥ��ҩ���ϰ壬�����Ƿ��о���ҽ�����ߵ�ҩ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ã�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�������߲�ͬѰ����ҩ�ﾹȻ��ȫ��Ч����֡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǿ�����Ǻã�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1152},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		
	},
	--AutoFindWay = { true,  SubmitNPC = true},
	task = {1,154},	-- ���͸���̨��������
};
storyList[100154] =
{

	TaskName = "���ȴ�ʦ",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,24},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	TIPtype = 3,
	TaskInfo = "�����ȴ�ʦ����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�鷳��ȥ�����ȴ�ʦ����ʦ����ҽ��������ͬʱ������������ҳ�����ԭ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������˸��ˣ����Ե�ȥ�ݷá�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��ʩ���������Ӧ��Ҳ���쵽�ⳡ���ߵĲ�ͬѰ���ɣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ʦ��Ȼ������������Ϊ�����߶�����</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1153},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		
	},
	--AutoFindWay = { true,  SubmitNPC = true},
	task = {1,155},	-- ���͸���̨��������
};
storyList[100155] =
{

	TaskName = "а��ݹ�",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,25},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	--TIPtype = 3,
	TaskInfo = "ȡ��а��Ŀݹǣ��������ȴ�ʦ",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�����������ð�����Թ�飬�鷳��ȡЩ���������һ������ߺ�Թ���йء�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��Ȼ�������д���Թ�����е�һ��ʬ������������Ȼ֪��ԭ��ͺð��ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ʦ��Ȼ������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1154},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
		kill = { "M_017", 5 ,{8,9,46},"Թ��ݹ�"},
	},
	AutoFindWay = { true,  Position={8,9,46}},
	task = {1,156},	-- ���͸���̨��������
};
storyList[100156] =
{

	TaskName = "�������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,27},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	TIPtype = 3,
	TaskInfo = "���߳Ƿ��ӳ��������֮��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�㽫��Щ��ˮ�����Ƿ��ӳ������÷�ˮ�γ�ʬ����Ȼ���ҩ������ҩ��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >̫���ˣ������ȥ��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >̫���ˣ����Ǹ�лӢ�ۡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1155},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
	
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,157},	-- ���͸���̨��������
};

storyList[100157] =
{

	TaskName = "��������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,30},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�Ƿ��ӳ��������ߵı������������йء�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���ߵı���Ӧ������е��������йء�����������ѹ�˺ܶ���ħ������˴˿���������鿴��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���Ǻ��ˣ��ѵ�������������й¶�йأ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ˣ��������ʹ�ߣ����ռ����������������᪡�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1156},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,158},	-- ���͸���̨��������
};

storyList[100158] =
{

	TaskName = "������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,33},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��ս�������¡���һ�أ����չ��һ��ʵ����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�����Ҽ��룬�������ֳ����ʵ��������ȥ��ս�����µ�һ�ظ��ҿ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >û�����⡣</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�������ܹ�Ȼ��ʵ���������������������й©���������ߡ���������ҲͻȻ�ϰ����ˣ����������뿪����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ҳ�գ��ҾͰ���Ѻ���֮��һ�����˰ɡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1157},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		monsterList = 1,
	},
	--AutoFindWay = { true,  SubmitNPC = true},
	task = {2,18},	-- ���͸���̨��������
};

storyList[200018] =
{

	TaskName = "װ��ǿ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	
	TaskGuide=1,						-- ��������

	TaskInfo = "������ǿ����5������װ����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >֮��Ӧ�û��и��ѵ�ս�����ҽ����㽫����ǿ����5��������������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ɶ������Щ��������ô�ˣ���˿񱩡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ô�ˣ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1158},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		equiplevel = {1,5},
	},
	--AutoFindWay = { true,   SubmitNPC = true},
	task = {1,159},	-- ���͸���̨��������
};
storyList[100159] =
{

	TaskName = "��ѵϺ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,36},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	RS = {'N_2066_0_01','N_2066_0_02','N_1025_0_01'},	--Ԥ���ع����NPC��Դ
	TaskInfo = "���������ѵϺ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��������ں����˷����˲�˵�����ϰ����ˣ������Ƕ�û�������ˡ��鷳Ӣ�۰����ǽ�ѵһ����Щ���塣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >С���⡣</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�����ܱ��֮�ӣ���߸�����Ǻ��ˣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ۣ�ԭ���������߸��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2018},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_018", 8 ,{8,64,106}},
	},
	AutoFindWay = { true,  Position={8,64,106}},
	task = {1,160},	-- ���͸���̨��������
};
storyList[100160] =
{

	TaskName = "����֮��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,39},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�������-��߸��Ҳ��Ϊ����֮������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���ˣ������ȥ����һ�¡��ҿ���ͷ�ľ���һ�����ݣ������־��������С�����ϸ����ң�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õģ��ұ�����Ϊ���¶�����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ҵ�Ů���������ǿ����ĵ��ö���~ </font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ɩ����ô�ˣ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1159},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,161},	-- ���͸���̨��������
};
storyList[100161] =
{

	TaskName = "��������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,42},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�񱩵ĺ��岻���ϰ����ˣ���°���˲���ͯ��ͯŮ��Ϊ��Ʒ",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���Ǽҵĵ��ã�������ץ���ˣ�˵����Ϊ�����ļ�Ʒ�����أ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���д���������Ҵ��뺣��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�����޷�������������ô���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ϰ壬�贬һ�ã���Ҫ�������ˡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1160},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		horselevel = 4,
	},
	--AutoFindWay = { true,  SubmitNPC = true},
	task = {1,162},	-- ���͸���̨��������
};
storyList[100162] =
{

	TaskName = "����з��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,45},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "������ͷ��з��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�ҵĴ�����ͷ���Ѿ���з����ռ�ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������ȥ����з����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�����ҿ������ϻ�ư����⴬��������Ū���ˣ�û��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҫ��ô�죿</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1161},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_019", 8 ,{8,39,110}},
	},
	AutoFindWay = { true,   Position={8,39,110}},
	task = {1,163},	-- ���͸���̨��������
};
storyList[100163] =
{

	TaskName = "ľ��Фʦ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,48},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��ľ��Фʦ��ȥ����ֻ",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ȥ��ľ��Фʦ���ɣ�ֻ�������޴���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�š�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >Ҫ�޴��������㲻�����ں���������İ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������������......</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1162},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,164},	-- ���͸���̨��������
};
storyList[100164] =
{

	TaskName = "�ռ�ľ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,51},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�ռ�ľ��������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >ԭ����ˣ��Ҿ���Ѱ�������ɡ�����֣�ȡЩľ���������Ǿ����޺á�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���ˣ��󹦸�ɣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�޺�����</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1163},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10004,1,{8,41,83,100020}}},
	},
	AutoFindWay = { true,   Collection={8,41,83,100020}},
	task = {1,165},	-- ���͸���̨��������
};
storyList[100165] =
{

	TaskName = "����׼��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,54},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "���Ѿ��޺ã�׼�������ַ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���˳���һ��������ֻҪ�㲻���ټ�ʻ�������Բ���ɢ�ܵġ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >......</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ۣ����Ѿ��޺��ˣ����������ڵķ���̫�󣬿����߲��˶�Զ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ô�졣</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1164},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,166},	-- ���͸���̨��������
};
storyList[100166] =
{

	TaskName = "������ί��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,57},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "������ٴ�����ȳ����б�����ץ�ߵ�С��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��������취�ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ţ���������Բߡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >Ӣ�ۣ�������ͷһ���кü���С������ץ���ˣ�����Ӣ�۾Ⱦ����ǡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������ڷ���̫���޷�������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1165},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,167},	-- ���͸���̨��������
};
storyList[100167] =
{

	TaskName = "��߸�ķ���",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,60},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	RS = {'yinyan2.swf'},
	TaskInfo = "��˵��߸�Ļ���籿���ƽϢ���ˣ������뺣",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���ˣ�����˵�ܱ�֮�ӣ���߸�м��������Իζ���ˮ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�԰�����߸�ķ������٣��ҿ���������æ��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���д��£���ɷ��Ҳ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���а취ƽϢ����ô��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1166},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,168},	-- ���͸���̨��������
};
storyList[100168] =
{

	TaskName = "Ѳ��ҹ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,70},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	RS = {'N_2017_0_01','N_2017_0_02','N_2017_0_03','N_2017_0_04','N_2017_0_10'},	--Ԥ���ع����NPC��Դ
	TaskInfo = "��������ȷ��-Ѳ��ҹ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���з�������籣����ǿ���һ���̶ȿ��Ʒ��ˣ������д���������ͳ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ɣ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ɶ�Ѳ��ҹ��Ҳֻ��ආ����ѣ�����Ҫ�ҵ�������̫�ӵ�λ�ò��ܾȳ������ǡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǰ���</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1167},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "B_022", 1 ,{8,44,138,1}},
	},
	AutoFindWay = { true,   Position2={8,44,138}},
	task = {1,169},	-- ���͸���̨��������
};
storyList[100169] =
{

	TaskName = "����λ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,73},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ѯ������˵����֪��������̫�ӵ�λ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���ߵ�����Ժ���Ƚ���Ϥ��˵����֪��������̫�ӵ�λ�ã�������ȥ����һ�£�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ã�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������̫�ӣ���˵��ס�ڶ�����ң��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����֪����ôȥ��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1168},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,170},	-- ���͸���̨��������
};
storyList[100170] =
{

	TaskName = "��Ѱ��ͼ",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,76},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��������㣬��Ҫ��ͼ�����ҵ�������ң��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���ϲ���½�أ�����֪����ź���û�к�ͼ��Ҳ�޷��ﵽ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ԭ����ˣ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >֪����ŵط����У���ͼ�����Һ���Ҫ�������ʹ����Ǹ�Ϊֹ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >.......</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1169},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,171},	-- ���͸���̨��������
};
storyList[100171] =
{

	TaskName = "��ͼ�Ͼ�",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,79},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��Ϻ���ռ���ͼ�Ͼ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ȥ����ЩϺ�����ݺݵĽ�ѵ���ǣ��ػύ����ͼ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >û���⣡</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���ţ���Щֻ�Ǻ�ͼ�Ͼ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�¾���ʲô�ط���</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1170},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_018", 1 ,{8,70,112},"��ͼ�Ͼ���Ƭ"},
	},
	AutoFindWay = { true,  Position={8,70,112}},
	task = {1,172},	-- ���͸���̨��������
};
storyList[100172] =
{

	TaskName = "��ͼ�¾�",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,82},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��з���ռ���ͼ�¾�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >Ϻ��з����¾�϶���з�����С�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ȥ��з����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���ţ��¾�ͼҲ�����ˣ�����ƴ��һ�¡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ô����</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1171},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_019", 1 ,{8,36,120},"��ͼ�¾���Ƭ"},
	},
	AutoFindWay = { true,  Position={8,36,120}},
	task = {1,173},	-- ���͸���̨��������
};
storyList[100173] =
{

	TaskName = "��ս��ң��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,90},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	RS = {'N_2019_0_01','N_2019_0_02','N_2019_0_03','N_2019_0_04','N_2019_0_10'},	--Ԥ���ع����NPC��Դ
	TaskInfo = "���붫����ң�󣬻���������̫��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���ˣ��Ѿ��ҵ�·�ߣ����ϳ�����ǰ��������ң��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�߰ɣ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >����������С���Ľ�����Ը��ҵ�������������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ƥ��̫���ˣ��˲��𰡣�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1172},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "B_027", 1 ,{8,44,138,1}},
	},
	AutoFindWay = { true,  Position2={8,44,138}},
	task = {1,175},	-- ���͸���̨��������
};

storyList[100175] =
{

	TaskName = "��������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,96},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "���ߴ��񣬺����Ѿ�������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ȥ��С���ͻ����Ǹ�ĸ�����ȥ���Ҹ�лһ�½贬�ĺ��̡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��˵С���Ƕ��Ѿ��Ȼ����ˣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������Ĵ���Ҫ��Ȼ��ʲô�������ˡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1173},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,176},	-- ���͸���̨��������
};
storyList[100176] =
{

	TaskName = "�����ܲ�",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,97},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "������ͻȻ�����ܲ����������Ӱ�ƽ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��������һ�������ѣ�����Ӧ���ġ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�������������ﰡ�������ܱ��������㡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʲô���飿</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1175},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,177},	-- ���͸���̨��������
};
storyList[100177] =
{

	TaskName = "��������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,98},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "����Ϊ����̫�ӳ�����ȫ�庣�����ֳ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�����������ܲ����������죬�����������������ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʲô��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."������Ϊ�θ��Ҷ�һ�𷸺�Ϳ����Ȼɱ��������̫�ӡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ʱ���Σ��������Ҳ���ò�......</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1176},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,178},	-- ���͸���̨��������
};
storyList[100178] =
{

	TaskName = "��̬����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,99},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	RS = {'N_1038_0_01','N_2020_0_01'},	--Ԥ���ع����NPC��Դ
	TaskInfo = "����׼��ˮ�ͳ����أ���̬�Ѿ�������Σ����ʱ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��߸һ����ȥӦ�������ˣ�����ȥ�����������������Ǻã�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ˣ�����߸����Ƣ�����ػ���£������ȥ��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�����������ˣ������Ϊ��������������������������������Ҫ�������ҡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��߸�ȵȣ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1177},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,179},	-- ���͸���̨��������
};
storyList[100179] =
{

	TaskName = "��߸��ɱ",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskTrack = {2052,4,100},             --��߸�ֺ�
	TaskGuide=1,						-- ��������
	
	TaskInfo = "Ϊ�˱��������أ���߸���ò���ɱ�������������˱�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >һ������һ�˵�������߸�����ڴ�һ����һ�������ˣ����������û��������ء�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҫ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."�������������Ҷ����࣬�ֲ�������!��......</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������������Σ��ұض�Ҫ�ҵ�������߸�İ취��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1178},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,180},	-- ���͸���̨��������
};
storyList[100180] =
{

	TaskName = "�س����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	TIPtype = 3,
	TaskInfo = "��߸��ɱ������������Ѱ�����֮��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ģ�������������߸���������������������һ�У������˳���ܣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ã�һ��Ϊ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >ͽ������ȥ�����أ��Ƿ�˳����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >һ���Ѿ���......</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1179},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,258},	-- ���͸���̨��������
};

storyList[100258] =
{

	TaskName = "��ս��λ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�μ�һ����λ����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >����֪���Լ������������ߵĲ���𣿲μ�һ����λ�������ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ã���Ҳ���ʶһ�¸�·Ӣ�ۡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������֪������˰ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����֮�󣬹�Ȼ���˱�������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1180},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		homebattle =1--��λ��
	},
	--AutoFindWay = { true,  SubmitNPC = true},
	
	task = {1,181},	-- ���͸���̨��������
};


storyList[100181] =
{

	TaskName = "ͭǮ����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������

	TaskInfo = "���һ��ͭǮ����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >ԭ����ˣ������㸴���ǰ���㻹��Ҫ��װ������ǿ�����ǲ��Ƿ���ͭǮ�����ˣ���һ�����ǲ���֮�ƣ�����ȡ֮��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ֱ̫���˰ɡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������Σ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ö಻��֮�ơ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1258},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		tfb = 1
	},
	AutoFindWay = {true,Collection={1,58,66,59}},
	task = {1,256},	-- ���͸���̨��������
};

storyList[100256] =
{

	TaskName = "��ʯ�ɽ�",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��ʯ�ɽ�1�Ρ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���˻���һ���������Ի��ͭǮ�����Ƿ���������ʯ�ɽ������ھʹ��㡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лʦ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ɼҷ�����ʯ�ɽ𣬿��Ի�ô���ͭǮ��ÿ�մ������ޣ��ɱ��˷��ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >֪���ˡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1181},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		dj = 1			--���3��
	},
	--AutoFindWay = { true,  SubmitNPC = true},
	
	task = {1,182},	-- ���͸���̨��������
};


storyList[100182] =
{

	TaskName = "ǰ��ǬԪɽ",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	TIPtype = 3,
	TaskInfo = "ǰ��ǬԪɽ����߸��ʦ��̫���������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >̫����������߸��ʦ��������Ȼ�а취����߸������ȥǬԪɽ��ȣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ã�����ͳ�����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������Զ�����������ֺ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������������ˡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		"showWorldTip()"
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1256},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,200},	-- ���͸���̨��������
};
--ǬԪɽ����ʼ

storyList[100200] =
{

	TaskName = "����ǬԪɽ",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "������;���棬���ڴﵽ��ǬԪɽ",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�����糾���ͣ������ȵ�����̨������Ϣ����ʦ�ֻ�Ӵ��㡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лͯ�ӡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�������к��£�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���������̫�����ˣ��鷳ʦ��ͨ��һ�¡�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1182},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,201},	-- ���͸���̨��������
};
storyList[100201] =
{

	TaskName = "̫������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��ǬԪɽ������̫������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >ʦ���Ѿ��㵽������ˣ����������µ����ˣ���ȥ�ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лʦ�֡�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�������������ˣ��������ͽ����߸�Ѿ����������˰ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ˣ����о���߸֮����</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1200},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},

	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,202},	-- ���͸���̨��������
};
storyList[100202] =
{

	TaskName = "����֮��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "̫�������Ѿ�׼���˸�����߸֮����������Ҫ��İ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��֪���������д�һ�١�����������ת��֮�����������ҵ�����ȥȡ���������ϡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >����ƣ����ˣ��Ҳ�֪��ʦ��Ҫ�ã�һʱ����ȹ��ˣ� </font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����������Ǻ�? </font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1201},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},

	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,203},	-- ���͸���̨��������
};
storyList[100203] =
{

	TaskName = "ȡ�����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��ɽ�ϵ����ȡ�ú����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������˼���鷳�����Һ����Ū��ɣ�����С�ĺ���Ƿ�ŭ���ٺ١�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >û�취���������졣</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ۣ��������ӣ���ɰѺ���Ƕ�������ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�³���������Ҳ�����Ρ� </font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1202},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_028", 5 ,{7,50,42},"�����"},
	},
	AutoFindWay = { true,   Position={7,50,42}},
	task = {1,204},	-- ���͸���̨��������
};
storyList[100204] =
{

	TaskName = "���ɾ�ʿ",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ȡ���˺���ƣ���ȥ�����ɾ�ʿȡ�����ĩ",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�ҿ��������������ĩҪȥ��ɽ���ɾ�ʿ����ȥ�á� </font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��档</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�����ĩ�������ȡ����ʹҩЧ��� </font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������ȡ�����أ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1203},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},

	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,205},	-- ���͸���̨��������
};
storyList[100205] =
{

	TaskName = "ȡ������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "����¹����ȡ������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >ɽ���������¹�������ȥ��ȡ�������мǣ����������¹��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����֪���ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ã��Ұ��㴦��һ�£��Ե�Ƭ�̡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��ʿ��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1204},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_029", 5 ,{7,14,57},"��¹����"},
	},

	AutoFindWay = { true,   Position={7,16,56}},
	task = {1,206},	-- ���͸���̨��������
};
storyList[100206] =
{

	TaskName = "�����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "���ƾ�ת�𵤣���Ҫ�������ʦ�ð�æ",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�����ĩ������ˣ�������ȥ�������Ƴɾ�ת�𵤣���Ҫȥ��Сʦ������Ӱ�æ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��ʿ��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���ƾ�ת����Ҫ��ⶴ����������¯���������ڽ�ⶴ�������ȡ���������¯����ɸ�ȥȡ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�кβ��ң�Ϊ�˾���߸����Σ��ҲҪȥ��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1205},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},

	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,212},	-- ���͸���̨��������
};

storyList[100212] =
{

	TaskName = "����Կ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��ؽ�ⶴ�����Կ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�����ⶴ�����Կ�ױ���ū�����ˣ���ȥ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >Կ���õ��ˣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǵġ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1206},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{		
		kill = { "M_096", 10 ,{7,17,26}},
	},
	AutoFindWay = { true,   Position={7,17,26}},
	task = {1,213},	-- ���͸���̨��������
};
storyList[100213] =
{

	TaskName = "�������¯",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��ȥ��ⶴ2�㣬ȡ���������¯",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��һ·С�ģ���ⶴ2���ƺ�Ҳ��̫ƽ������İ��������������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лʦ�����ѡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�úúã����¾߱����ҿ��Ϸ�ʩ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ŀ�Դ���</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1212},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "B_035", 1 ,{7,6,19,1},"�������¯"},
	},
	AutoFindWay = { true,   Position2={7,6,19}},
	
	task = {1,214},	-- ���͸���̨��������
};
storyList[100214] =
{

	TaskName = "��߸����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��߸�Ѿ������������ȥ�������ɡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��������߸�Ѿ���������ȥ�������ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >̫���ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�⼸�����ǻ�Ȼ���Σ�"..talk.name().."����л��Ϊ�����౼�ߣ����������и���֮�ա�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��߸�ֵܣ�����ʲô����</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1213},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	
	task = {1,215},	-- ���͸���̨��������
};
storyList[100215] =
{

	TaskName = "��߸����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	TIPtype = 3,
	TaskInfo = "�������߸������Ȼ���ң����鷵�ض�������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >����֮�𣬲��ɲ�������һ�̶��޷������ͣ���Ҫȥ��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������Ҹ���һ��ȥ��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��߸���ӣ���Ȼû������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���Ǵ˴λ����������������˵ģ��鷳��ˮ�ֵ��ٴΰ����Ǽݴ���</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1214},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	
	task = {2,19},	-- ���͸���̨��������
};

storyList[200019] =
{

	TaskName = "��������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��ȡ����Ƥ�ӹ̴��塣",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���������ڸ�Զ�ĵط�����Ҫ����Ƥ�ӹ̴�����ܴﵽ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����Ұɡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >����������Ƥ�����������������Σ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������ϳ����ɡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1215},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_088", 1 ,{8,14,123},"����Ƥ"},
	},
	AutoFindWay = { true,   Position2={8,14,123}},
	--AutoFindWay = { true,   SubmitNPC = true},
	task = {2,20},	-- ���͸���̨��������
};
storyList[200020] =
{

	TaskName = "����ǿ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "������ǿ����5�ǡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���������ɲ��öԸ������Ȱ�����ǿ����5����ȥΪ�á�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��˵�Ķԡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ã��������������׼��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2019},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		horselevel = 5,
	},
	--AutoFindWay = { true,   Position2={8,14,123}},
	--AutoFindWay = { true,   SubmitNPC = true},
	task = {1,216},	-- ���͸���̨��������
};


storyList[100216] =
{

	TaskName = "��ս����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ɱ�����������������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >׼�����ˣ����Ǿͳ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������л��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��������ʹ�죬�������һ��Թ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ñ�������Ҳ��ȥ�ɡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2020},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "B_038", 1 ,{8,14,123,1}},
	},
	AutoFindWay = { true,   Position2={8,14,123}},
	
	task = {1,218},	-- ���͸���̨��������
};

storyList[100218] =
{

	TaskName = "�����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�ص������أ����������߸�����������������顣",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >"..talk.name().."����л��һ·���ҵ����ڣ��鷳���Ȼ����ҵĸ��װɣ����Ժ������ǰ����᪡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������̫���ˣ�������Ҳ��������������и��ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��˴��������ҵ������Ե�ǰ����᪣���Ч������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >̫���ˡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1216},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	
	task = {1,219},	-- ���͸���̨��������
};
storyList[100219] =
{

	TaskName = "�Ͷ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������

	TaskInfo = "����ڴ�Ӧ�㣬Ͷ����᪡�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������һ�����������ʰ��װ��������ǰ����᪡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õģ���������ټ���</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."������ϲɫ���棬��ش󹦸���˰ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����������£����ܱ��Ѿ���Ӧ����ǰ����᪡�</font>", --�������Ի�

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1218},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	
	task = {1,220},	-- ���͸���̨��������
};
storyList[100220] =
{

	TaskName = "�ؼ�ʦ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������

	TaskInfo = "��������ܣ�����ʦ����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >̫���ˣ���Ҫʲô�ʹͣ�Ҫ��������һЩ�����ź����ң�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л�����ʹͣ������������м��ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."������ܣ������´�һ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʦ�������ˡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1219},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		--daji = 1,
	},
	AutoFindWay = { true,   SubmitNPC = true},
	
	task = {1,224},	-- ���͸���̨��������
};

storyList[100224] =
{

	TaskName = "Ϊ������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������

	TaskInfo = "ȥ����������������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�ţ�����Խǿ������Խ��ȥ������������˵������㡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���������������������"..talk.name().."�ɣ���Ȼ����Ӣ�ۡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ʢ���ˡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1220},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	
	task = {1,250},	-- ���͸���̨��������
};

storyList[100250] =
{

	TaskName = "����������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������

	TaskInfo = "�����������ر�ʦ����������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��������᪵�������Խ��Խ�࣬�ַ�����ָ�տɴ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����������ұ����е�Ŀ�ġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."�������Ϊ�������º����ͣ����мǲ���������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʦ����ѵ���ǡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1224},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	
	task = {2,27},	-- ���͸���̨��������
};


storyList[200027] =
{
	TaskName = "���ͺ�����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "����1�κ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��һ����Ҫ��ȥ��������Ҫ�˰��һ���һ���������˷���������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ŷ������֮�£�����֮������</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�����ˣ�һ·�ɰ��á�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���о��գ������ڰ�ȫ���</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{	
		completed={1250},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		husong = 1 , --���һ�λ���
	},
	AutoFindWay = {true,Collection={1,86,78,53}},	
	task = {1,300},	-- ���͸���̨��������
};


storyList[100300] =
{

	TaskName = "ǬԪ֮��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��˵ǬԪɽ������ͻ�䣬ʦ������ȥ������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��˵ǬԪɽ������һЩ���õ������ǬԪɽ���Ҳ����صأ�������ʧ�������ȥ������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лʦ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���������ã������������һ¯�ǳ���Ҫ�ĵ�ҩ���޷��뿪�����Ը�����һ��æ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >̫��ʦ�壬��ʲô�����ˣ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2027},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,301},	-- ���͸���̨��������
};
storyList[100301] =
{

	TaskName = "��ľ�ɾ�",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ȥ������ѯ�ʲ�ľ�ɾ��������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >ǬԪɽ�Ĳ�ľ���鱾���Ը��ºͣ������֪��Ϊ���궯��������ȥ���������ʡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�������þò�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >̫��ʦ��������������ô���¡�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1300},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,302},	-- ���͸���̨��������
};
storyList[100302] =
{

	TaskName = "������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "���ǬԪɽ�Ļ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��Ҳ��֪����ǬԪɽ�ľ����ÿ񱩣���ʼ���ˡ�������Σ�����ѹ��ȥ��˵��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������ˣ�������������������</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��л��æ�����ǬԪɽ�������������֪���ǲ������������Ļ�����ɵġ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳ��ʦ��˵��ش�ٽ�����</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1301},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_043", 12 ,{7,77,91}},
	},
	AutoFindWay = { true,  Position={7,77,91}},
	task = {1,303},	-- ���͸���̨��������
};

storyList[100303] =
{

	TaskName = "��������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "���ǬԪɽ��������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >����һ��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ȥ�ɡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�����徲�ˣ���֪�������ط���Ρ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ȥ�ٿ�����</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1302},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_044", 12 ,{7,64,120}},
	},
	AutoFindWay = { true,  Position={7,64,120}},
	task = {1,304},	-- ���͸���̨��������
};

storyList[100304] =
{

	TaskName = "��ϼͯ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��߸����ȥѰ�ҽ�ϼͯ�ӡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ȥ��ϼͯ�����￴����Ҳ����������Ҫ���æ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�����ˣ�ǬԪɽ�ϵľ��ֱ����Խ��Խ�࣬���ǿ�æ�������ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������æ�㡣</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1303},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,306},	-- ���͸���̨��������
};

storyList[100306] =
{

	TaskName = "���¹��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "���ǬԪɽ��¹����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >ԭ������¹��Ҳ�в��ٱ��¹������û���ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����Ұɡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��ƫƧ���䣬����һЩ�߹޾���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�߹�Ҳ�ܳɾ����������治�а���</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1304},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_045", 12 ,{7,23,128}},
	},
	AutoFindWay = { true,  Position={7,23,128}},
	task = {1,307},	-- ���͸���̨��������
};

storyList[100307] =
{

	TaskName = "����߹޾�",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "���ǬԪɽ���߹޾���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >ǬԪɽ�����Ӵ󣬾�������Ѭ��ʱ�䳤�ˣ�Ҳ���Գɾ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ðɣ���ȥ�����߹޾���</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��������۲��˺ܾã���һ�������Ǵ�������Ʈɢ�����ġ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ţ�Ҳ�������֢�����ڣ���ȥ������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1306},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_046", 12 ,{7,4,98}},
	},
	AutoFindWay = { true,  Position={7,4,98}},
	task = {1,308},	-- ���͸���̨��������
};

storyList[100308] =
{

	TaskName = "�����֣�һ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ͨ��������һ�㡣",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >С�ģ��������Ǻܾ���ǰʦ�ų������еĵط����ܾ�û���˽�ȥ���ˣ�˭Ҳ��֪������������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�һ�С�ĵġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ɶ񣬿������㱻���˷�ӡ������Ҫ�ҵ����·�ӡ���˲��ܽ��롣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�Ǹ���ô��?</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1307},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "B_051", 1 ,{7,9,133,1}},
	},
	AutoFindWay = { true,  Position2={7,9,133}},
	task = {1,309},	-- ���͸���̨��������
};

storyList[100309] =
{
	TaskName = "ǰ����ɽ",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ǰ����ɽѰ��ǬԪɽ���ҵĸ�Դ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ȥ��ɽ�����ɾ�ʿ������Ҳ����������һЩ������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�������������ã���֪��������ɽ�Ѿ����������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ô��������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1308},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,310},	-- ���͸���̨��������
};
storyList[100310] =
{
	TaskName = "��ɽ���",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��ɽ�Ѿ������˸������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >һ����ħ����ʿǱ��ǬԪɽ������ǬԪɽ�����������ٻ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ȸɵ���Щ���</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�������β���Ҳ���а���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ô˵��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1309},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_102", 12 ,{34,5,42}},
	},
	AutoFindWay = {true,Position={34,5,42}},
	task = {1,311},	-- ���͸���̨��������
};
storyList[100311] =
{
	TaskName = "ƽ����ɽ",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��ƽ����ɽ���������ҡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������ô�࣬��ƽ����ɽ��ɧ�ң���Ѱ��������ס�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��������ô���ˣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������æ�������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1310},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,312},	-- ���͸���̨��������
};

storyList[100312] =
{
	TaskName = "����Թ��(һ)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��˺�ɽ��Թ�顣",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������ã������ڶ࣬�����о��������ġ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >����������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ˡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1311},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_103", 12 ,{34,22,8}},
	},
	AutoFindWay = {true,Position={34,22,8}},
	task = {1,313},	-- ���͸���̨��������
};
storyList[100313] =
{
	TaskName = "����Թ��(��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��˺�ɽ��Թ�顣",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�����ٽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >̫�����������Ҳ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ʵʦ��Ҳͦ������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1312},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_104", 12 ,{34,22,28}},
	},
	AutoFindWay = {true,Position={34,22,28}},
	task = {1,314},	-- ���͸���̨��������
};
storyList[100314] =
{
	TaskName = "����Թ��(��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��˺�ɽ��Թ�顣",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >����������һ���˳����ˣ���Ҳ�����㡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ã�����һ��������Щ���</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������డ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʦ�ֵķ�������������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1313},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_105", 12 ,{34,39,33}},
	},
	AutoFindWay = {true,Position={34,39,33}},
	task = {1,315},	-- ���͸���̨��������
};
storyList[100315] =
{
	TaskName = "����Թ��(��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��˺�ɽ��Թ�顣",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >����һ�����������������Щ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ã�����һ��������Щ���</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�������ˣ���֪������ʦ�ֵ�����ô���ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������Ҳ������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1314},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_106", 12 ,{34,39,54}},
	},
	AutoFindWay = {true,Position={34,39,54}},
	task = {1,316},	-- ���͸���̨��������
};

storyList[100316] =
{
	TaskName = "��������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�����ɽ��Ѱ��������ʦ�ֵܡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�ǰ�������ȥ�������ӣ������������Ρ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��������ô���ˣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ôվ�����</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1315},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,317},	-- ���͸���̨��������
};
storyList[100317] =
{
	TaskName = "��������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�����ɽ��Ѱ��������ʦ�ֵܡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�����ʦ�ó��ȥ�ˣ���Ҫ���������������롣��ɼ�һ��������ϣ����������ж���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ã���ȥ������</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�����������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������һ��֮����</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1316},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10005,1,{34,31,73,100025}}},
	},
	AutoFindWay = {true,Collection={34,31,73,100025}},
	task = {1,318},	-- ���͸���̨��������
};
storyList[100318] =
{
	TaskName = "����Թ��(��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��˺�ɽ��Թ�顣",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >С�ģ���Щ���ﶼ���ж���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >û�£��Ҳ��˱��������ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ɶ񣬶���̫�أ����޷���ǰ���ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʦ������Ϣһ�ᣬ���潻�����ˡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1317},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_107", 12 ,{34,39,97}},
	},
	AutoFindWay = {true,Position={34,39,97}},
	task = {1,319},	-- ���͸���̨��������
};
storyList[100319] =
{
	TaskName = "�������(һ)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�����ҵ�������ǬԪɽ��������ס�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >����һ��ҪС�ģ�����Ԥ�У�������׾���ǰ�档</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�һ�С�ĵġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ٺ٣���������Ȼ�ҵ������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ʲô�ˣ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1318},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_108", 12 ,{34,14,102}},
	},
	AutoFindWay = {true,Position={34,14,102}},
	task = {1,320},	-- ���͸���̨��������
};

storyList[100320] =
{
	TaskName = "�������(��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�����ҵ�������ǬԪɽ��������ס�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��֪������˭������������һ��ħ���������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ɶ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ٺ٣������������������������С�����˽����ʿ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������־��ܣ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1319},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_109", 12 ,{34,7,81}},
	},
	AutoFindWay = {true,Position={34,7,81}},
	task = {1,321},	-- ���͸���̨��������
};

storyList[100321] =
{
	TaskName = "�����֣�����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ͨ�������ֶ��㡣",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >����������������׼����һ��С�������ȥ�������������鷳�ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʲô��Ī�ǣ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ÿ��µ��������ҿ�������ˣ��Ҷ����Ŵ��ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ϧ�������Ǹ�ħ�������ˡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1320},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "B_054", 1 ,{7,9,133,1}},
	},
	AutoFindWay = { true,  Position2={7,9,133}},
	task = {1,322},	-- ���͸���̨��������
};
storyList[100322] =
{
	TaskName = "̫������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�ٴλ�ȥ�ݼ�̫�����ˡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ƕ�л���ˣ�ʦ�����������㣬����ȥ��ʦ���ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >С�ѣ�û�뵽�ұչ���ҩ�ڼ䣬ǬԪɽ������ô������ӣ����Ƕ�����ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ǻ�����������������ˡ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1321},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,323},	-- ���͸���̨��������
};
storyList[100323] =
{

	TaskName = "����ʦ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "����������ǬԪɽ���������顣",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���Ѿ����ĺܺ��ˣ��Ϸ��ǵ���������顣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʦ��̫����������ͻ�ȥ��ʦ�������ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >ͽ����ǬԪɽ�����Σ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ǬԪɽ��Ȼ��������......</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1322},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,324},	-- ���͸���̨��������
};
storyList[100324] =
{

	TaskName = "��ʯ����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��ʯ����ÿ�տ�����ѻ�ñ�ʯ",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��������һ�£������㽫װ����Ƕ��ʯ�������Լ���ս������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���õ��ı�ʯ��Ƕ��װ���ϲ������ֳ���ֵ����������һ�¡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǵġ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1323},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		--bfb = 1,  --���һ�α�ʯ����
	},

	--AutoFindWay = {true,Collection={1,64,64,51}},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,350},	-- ���͸���̨��������
};


storyList[100350] =
{

	TaskName = '��������',
	TaskInfo = '����������������������������ԣ���ȡ����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >������°��տ಻���ԣ���ʱ�������������������У������ַ�ϭ�ģ�����ȡ���ġ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�Ұ�ȥ�㴫����</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��ة����֮����������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ü��������ܴ�ս��Ҫ�����ˡ�</font>',
	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		"showWorldTip()"
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1324},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,351},	-- ���͸���̨��������
};
storyList[100351] =
{

	TaskName = '�̾���Ϯ',
	TaskInfo = '��֪���������ַ�ϭ�ģ�������ŭ����ħ���Ľ��ַ��ܹ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�������ã�ħ���Ľ�ǰ���ַ��ҹ����������Ǻã�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�𼱣�ʦ�����жԲߣ���ȥ����ʦ����</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�������ϵ�����μˮ��ǰ���°��š�ֻҪ�����˽٣��ܹ���������Ʋ��ɵ���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����Ҫ����ʲô��</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1350},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,352},	-- ���͸���̨��������
};

storyList[100352] =
{

	TaskName = 'ǰ��μˮ',
	TaskInfo = '������������ǰ��μˮ',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���Ѱ��ŵ�����������ǰ��μˮ����ȥЭ�����ǰɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�Ͽ�����š�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ϴ�ү����Ϊ����˻��ң�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1351},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,353},	-- ���͸���̨��������
};
storyList[100353] =
{

	TaskName = '�󷽻���',
	TaskInfo = 'μˮս�½��𣬺�ȴ������ҡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >ԭ���Ǵ��ˣ��м���һ������ͽ���ң����˲��ٰ��ա�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���д���</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >̫���ˣ���л���ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����������Щ��ͽ̫����ˡ�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1352},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_065", 12 ,{10,12,83}},
	},
	AutoFindWay = { true,  Position={10,12,83}},
	task = {1,354},	-- ���͸���̨��������
};
storyList[100354] =
{

	TaskName = '�������ص�',
	TaskInfo = 'μˮս�½���Ѹ����ѹ�󷽵Ļ��ҡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���ˣ��Ϸ�˽�ӻ���һ�����ҵı���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ߣ������ȥ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�������������ˣ����Ӷ��ڲ����ְ���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�Ǻǡ�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1353},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_039", 12 ,{10,18,157}},
	},
	AutoFindWay = { true,  Position={10,18,157}},
	task = {1,355},	-- ���͸���̨��������
};
storyList[100355] =
{

	TaskName = 'ƽ������',
	TaskInfo = 'μˮս�½���Ѹ����ѹ�󷽵Ļ��ҡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���˼�Ц�ˣ������˾������޸���֮��֮������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���ò����������ӵ�Ҳ�Ǻܸ��е�ְҵ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ô�ˣ�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1354},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,356},	-- ���͸���̨��������
};
storyList[100356] =
{

	TaskName = 'μˮ����(һ)',
	TaskInfo = 'μˮ�������ң�Ѹ�ٲ���ԭ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�������Ӷ�������������Ҫʳ����Դ�����������Һþ�û�������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ȥ���㿴����</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ô�ˣ�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1355},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,357},	-- ���͸���̨��������
};
storyList[100357] =
{

	TaskName = 'μˮ����(��)',
	TaskInfo = 'μˮ�������ң�Ѹ�ٲ���ԭ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���ɷ�ȥ���㣬�þö�û��������Զ���������������о޴����Ӱ�ζ�...</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >Ī�����������</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��Ȼ�����֣������ô�찡��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������ţ�����ȥ������</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1356},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_040", 12 ,{10,50,123}},
	},
	AutoFindWay = { true,  Position={10,50,123}},
	task = {1,358},	-- ���͸���̨��������
};
storyList[100358] =
{

	TaskName = 'μˮ����(��)',
	TaskInfo = 'μˮ�������ң�Ѹ�ٲ���ԭ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���д��ˣ�����Ұ��ɷ������������...</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���ġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >̫���ˣ����ھ�Ԯ���ˣ��Ҷ���������ü����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��š�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1357},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_072", 12 ,{10,43,101}},
	},
	AutoFindWay = { true,  Position={10,43,101}},
	task = {1,359},	-- ���͸���̨��������
};
storyList[100359] =
{

	TaskName = 'μˮ����(��)',
	TaskInfo = 'μˮ�������ң�Ѹ�ٲ���ԭ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >������ɢ�����������ȥ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����С�ġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���ˣ�������û�з���һ����ֵ����飿</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >ʲô���飿</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1358},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_073", 12 ,{10,60,145}},
	},
	AutoFindWay = { true,  Position={10,60,145}},
	task = {1,360},	-- ���͸���̨��������
};
storyList[100360] =
{

	TaskName = 'μˮ����(��)',
	TaskInfo = 'μˮ�������ң�Ѹ�ٲ���ԭ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��ǰμ��û���������飬�ҷ����Ժ�û��þͳ����˺�����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ȥ������</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����к������Ϸ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��������������û�У�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1359},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10006,1,{10,54,152,100015}}},
	},
	AutoFindWay = {true,Collection={10,54,152,100015}},
	task = {1,361},	-- ���͸���̨��������
};
storyList[100361] =
{

	TaskName = '��������',
	TaskInfo = '��������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�Ϸ��û�������ֹ�������顣</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ʦ�����ʶ�㣬Ҳ����֪����</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����������ħ����ʿһ���ٻ�ħ��ĵ��ߣ������̳�����ʿҲ��Ļ���º����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��Ȼ����ƽ�񣬿ɶ�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1360},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,362},	-- ���͸���̨��������
};
storyList[100362] =
{

	TaskName = '�����ȷ��(һ)',
	TaskInfo = '��ͬ������ϣ������̳����ȷ���ӡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����ʦ���Իᰲ�źú󷽵ģ����ǵ������Ǿѻ��о��ȷ沿�֡�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���ҵ��ֶΡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���ֶΣ�����Ϊ������ҫ�۵����н����ǡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >ʦ������ˡ�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1361},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_066", 12 ,{10,39,72}},
	},
	AutoFindWay = { true,  Position={10,39,72}},
	task = {1,363},	-- ���͸���̨��������
};
storyList[100363] =
{

	TaskName = '�����ȷ��(��)',
	TaskInfo = '��ͬ������ϣ������̳����ȷ���ӡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����ɳ����ɱ��ͬ�����˶�����С��Ϊ�ϡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ס�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >Ҫ��Ҫ��Ϣһ�£�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ʿ�ǻ��ڷ�ս������ô����Ϣ��</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1362},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_041", 12 ,{10,37,54}},
	},
	AutoFindWay = { true,  Position={10,37,54}},
	task = {1,364},	-- ���͸���̨��������
};
storyList[100364] =
{

	TaskName = '�����ȷ��(��)',
	TaskInfo = '��ͬ������ϣ������̳����ȷ���ӡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�ðɣ�����һ��ս����ȥ���߸��ϡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����������Ҳ������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��߸��������һ�����������</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1363},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_069", 12 ,{10,40,38}},
	},
	AutoFindWay = { true,  Position={10,40,38}},
	task = {1,365},	-- ���͸���̨��������
};
storyList[100365] =
{

	TaskName = '�����ȷ��(��)',
	TaskInfo = '��ͬ������ϣ������̳����ȷ���ӡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�ϻ���˵������ɱ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >ʦ�����Ǹ������ӡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�������һ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�š�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1364},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_070", 12 ,{10,42,20}},
	},
	AutoFindWay = { true,  Position={10,42,20}},
	task = {1,366},	-- ���͸���̨��������
};
storyList[100366] =
{

	TaskName = '�����ȷ��(��)',
	TaskInfo = '��ͬ������ϣ������̳����ȷ���ӡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >ɱ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >ɱ����</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�������о���ɢ�ˡ���ȥ׷������ȥ��ɨս����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ðɡ�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1365},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_071", 12 ,{10,59,6}},
	},
	AutoFindWay = { true,  Position={10,59,6}},
	task = {1,367},	-- ���͸���̨��������
};
storyList[100367] =
{

	TaskName = 'Ӫ���˱�(һ)',
	TaskInfo = '��ս��ݣ���ɨս�����������˵�ʿ����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >ע�⿴����û�����˵�ʿ����������Ρ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���ס�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >.......</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����˵Ĳ��ᰡ��</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1366},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,368},	-- ���͸���̨��������
};
storyList[100368] =
{

	TaskName = 'Ӫ���˱�(��)',
	TaskInfo = '��ս��ݣ���ɨս�����������˵�ʿ����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >.......</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >ֻ������ҽ���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >ʿ���ǵ����ƺ��ذ���Ҫ���찲����Ϣ��Ѱ��ҩ�ġ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ȥ���š�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1367},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,369},	-- ���͸���̨��������
};
storyList[100369] =
{

	TaskName = 'Ӫ���˱�(��)',
	TaskInfo = '��ս��ݣ���ɨս�����������˵�ʿ����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���鷳������ɢ��Χ�ĵо����������û���������ơ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��Щʿ��Ѫ����ֹ�����еĽ�ҩ�����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��Ҫ��ô�죿</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1368},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_074", 12 ,{10,54,52}},
	},
	AutoFindWay = { true,  Position={10,54,52}},
	task = {1,370},	-- ���͸���̨��������
};
storyList[100370] =
{

	TaskName = 'Ӫ���˱�(��)',
	TaskInfo = '��ս��ݣ���ɨս�����������˵�ʿ����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����ڵ�������Ѱ��һ�£�Ҳ���б��õĽ�ҩ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����⡣</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >̫���ˣ�Ѫ��ֹס�ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����Ҫʲô��</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1369},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_067", 12 ,{10,61,28},"��ҩ"},
	},
	AutoFindWay = { true,  Position={10,61,28}},
	task = {1,371},	-- ���͸���̨��������
};
storyList[100371] =
{

	TaskName = 'Ӫ���˱�(��)',
	TaskInfo = '��ս��ݣ���ɨս�����������˵�ʿ����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����ҪһЩ�ӹǲݣ��������ƹ��۵����ơ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���ˣ��˱��ǵ����ƶ��ȶ������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Ҿͷ����ˡ�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1370},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10007,1,{10,74,63,100012}}},
	},
	AutoFindWay = {true,Collection={10,74,63,100012}},
	task = {1,372},	-- ���͸���̨��������
};
storyList[100372] =
{

	TaskName = '�µ���в',
	TaskInfo = '�������ȷ����ħ���Ľ����ڳ��֣��γ����µ���в��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��л�����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����������Ҳ�����ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������ˣ�����ʦ�崫�½���������ȳ��󣬿���ħ���ֵܵ�������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1371},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,373},	-- ���͸���̨��������
};
storyList[100373] =
{

	TaskName = 'ħ����(һ)',
	TaskInfo = 'ɱ��ħ���Ľ�֮һ��ħ����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����ɢħ�ҵ�ආ����������ӻ�ϡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��Ҳ�������ˣ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Σ�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1372},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_063", 12 ,{10,18,40}},
	},
	AutoFindWay = { true,  Position={10,18,40}},
	task = {1,374},	-- ���͸���̨��������
};
storyList[100374] =
{

	TaskName = 'ħ����(��)',
	TaskInfo = 'ɱ��ħ���Ľ�֮һ��ħ����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >ħ���ֵ��ھ��������󷨣�����Ҫ�Ȼ�����Χ������������ȥ��һ��������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���ҵġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��Ҳ�������ˣ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Σ�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1373},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_064", 12 ,{10,17,15}},
	},
	AutoFindWay = { true,  Position={10,17,15}},
	task = {1,375},	-- ���͸���̨��������
};
storyList[100375] =
{

	TaskName = 'ħ����(��)',
	TaskInfo = 'ɱ��ħ���Ľ�֮һ��ħ����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���־���������ˣ����ǽ�ȥ��һ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ã�һ��ȥ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��Ҳ�������ˣ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Σ�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1374},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "B_079", 1 ,{10,12,12,1}},
	},
	AutoFindWay = { true,  Position2={10,12,12}},
	task = {1,376},	-- ���͸���̨��������
};
storyList[100376] =
{

	TaskName = '�������',
	TaskInfo = '��ȥ�����һ������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >ħ���ֵܹ�Ȼ�������������������������������㣬���������ʦ�ְ�æ���С�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >Ҳ�ã��һ����һ�ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >ħ���ֵܣ������ĸ�������ͨ����ȷ���öԸ���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�������ʦ������һ��֮����</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1375},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,377},	-- ���͸���̨��������
};
storyList[100377] =
{

	TaskName = '���鸱��',
	TaskInfo = '���һ�ξ��鸱��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����ҿ�����Ϊ���в��㣬�Ƽ���ȥ���鸱��������һ�¡�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >Ŷ���������ֵط���</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�о���Σ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��������Ĺ����Ȼ������</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1376},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		jyfb = 1
	},
	AutoFindWay = {true,Collection={1,46,86,61}},
	task = {1,378},	-- ���͸���̨��������
};
storyList[100378] =
{

	TaskName = "�����ȼ���40��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "������ȼ�������40����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������������Ȱѵȼ�������40����Ȼ������һ������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ðɡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >����������һ�������ȥ����ħ���Ľ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������</font>", --�������Ի�
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		"showWorldTip()"
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1377},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 40,
	},
	task = {1,400},	-- ���͸���̨��������
};
storyList[100400] =
{

	TaskName = "ħ���(һ)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ɱ��ħ���Ľ�֮һ��ħ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >ħ�������߹��ڶ࣬������ϵ������ɢ���ǣ����Խ���ħ���󷨵�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ðɡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���úã����Ǽ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1378},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_066", 15 ,{10,42,73}},
	},
	AutoFindWay = { true,  Position={10,42,73}},
	task = {1,401},	-- ���͸���̨��������
};
storyList[100401] =
{

	TaskName = "ħ���(��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ɱ��ħ���Ľ�֮һ��ħ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������ǰ����ɢ��Щ�����߹���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���úã����Ǽ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1400},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_041", 15 ,{10,37,54}},
	},
	AutoFindWay = { true,  Position={10,37,54}},
	task = {1,402},	-- ���͸���̨��������
};
storyList[100402] =
{

	TaskName = "ħ���(��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ɱ��ħ���Ľ�֮һ��ħ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�����������󷨶�ҡ�ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ч���ˣ��ټӰѾ���</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�����󷨳������������û��ᡣ</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ȥ��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1401},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_069", 15 ,{10,41,34}},
	},
	AutoFindWay = { true,  Position={10,41,34}},
	task = {1,403},	-- ���͸���̨��������
};
storyList[100403] =
{

	TaskName = "ħ���(��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ɱ��ħ���Ľ�֮һ��ħ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >ħ��죬�����ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ܣ���ҲҪ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���ڻ�����ħ��졣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǲ���һ��������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1402},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "B_080", 1 ,{10,12,12,1}},
	},
	AutoFindWay = { true,  Position2={10,12,12}},
	task = {1,404},	-- ���͸���̨��������
};

storyList[100404] =
{

	TaskName = "�����ȼ���41��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "������ȼ�������41����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�������Ƚ��ȼ�������41�����Ÿ��а��ա�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ðɡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�����ֹر��ˣ�����ħ���ֵܹ��������ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ô�죿</font>", --�������Ի�
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1403},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 41,
	},
	task = {2,28},	-- ���͸���̨��������
};
storyList[200028] =
{

	TaskName = "�ػ�ͨ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ͨ�鲢װ��һ���ػ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >����Ŀǰ��ʵ�����ƺ�����ƿ���˰ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǰ�����ָ��һ�¡�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�����ͨ�飬��װ���ػ����ܣ������Ӳ���ս����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1404},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		sh = 1,
	},
	--AutoFindWay = { true,  Position={10,52,45}},
	task = {1,405},	-- ���͸���̨��������
};
storyList[100405] =
{

	TaskName = "ħ����(һ)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ɱ��ħ���Ľ�֮һ��ħ����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�����߸ʦ����ϣ����׻����̳����ӣ��ҾͲ�������һֱ����������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����⡣</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�Ǻǣ��Ҿ�˵��ô�о���Ŵ��ң�ԭ������ɱ�����ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������������......</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2028},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_074", 15 ,{10,52,45}},
	},
	AutoFindWay = { true,  Position={10,52,45}},
	task = {1,406},	-- ���͸���̨��������
};
storyList[100406] =
{

	TaskName = "ħ����(��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ɱ��ħ���Ľ�֮һ��ħ����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��������͵ȵò��ͷ��ˣ�ʿ���ǣ����ҳ�档</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��߸ʦ�����Ǹ������Ӱ���</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >Ч����Σ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������������󷨻�û�ж�����</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1405},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_070", 15 ,{10,43,20}},
	},
	AutoFindWay = { true,  Position={10,43,20}},
	task = {1,407},	-- ���͸���̨��������
};
storyList[100407] =
{

	TaskName = "ħ����(��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ɱ��ħ���Ľ�֮һ��ħ����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�����Ǿʹ���һ�������׳�ɢ�о���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��֣�Ϊʲô��û�з�Ӧ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǰ���</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1406},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_071", 15 ,{10,64,7}},
	},
	AutoFindWay = { true,  Position={10,64,7}},
	task = {1,408},	-- ���͸���̨��������
};
storyList[100408] =
{

	TaskName = "ħ����(��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ɱ��ħ���Ľ�֮һ��ħ����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >Ī������Ϊ������Ԯ���ϵ���һ����ɢ���ǡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��Ȼ��������������ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ϸϹ�ȥ��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1407},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_067", 15 ,{10,59,28}},
	},
	AutoFindWay = { true,  Position={10,59,28}},
	task = {1,409},	-- ���͸���̨��������
};
storyList[100409] =
{

	TaskName = "ħ����(��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ɱ��ħ���Ľ�֮һ��ħ����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�ȵ��ң���������ն���Ĺ��Ϳɲ���������һ�ݡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�Ǻǣ�ͬȥ��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ɵúã�ֻʣ��ħ��һ�����ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������ǵĽ�ʿҲ���˲��ذ���</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1408},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "B_081", 1 ,{10,12,12,1}},
	},
	AutoFindWay = { true,  Position2={10,12,12}},
	task = {1,410},	-- ���͸���̨��������
};

storyList[100410] =
{

	TaskName = '�����ȼ�42��',
	TaskInfo = '���ȼ�������42��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�Ҿ�Ҳ��Ҫ����ʱ�䣬�㽫�ȼ�������42����������һ������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��ȼ�������졣</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����õ��ˣ����ǳ����ɡ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1409},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 42,
	},

	task = {1,411},	-- ���͸���̨��������
};
storyList[100411] =
{

	TaskName = "ħ��(һ)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ɱ��ħ���Ľ�֮һ��ħ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��������ħ�ҵ��ӣ�ħ�񺣾Ͷ�ľ��֧�ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�尡��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����������֮������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1410},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_063", 15 ,{10,17,40}},
	},
	AutoFindWay = { true,  Position={10,17,40}},
	task = {1,412},	-- ���͸���̨��������
};
storyList[100412] =
{

	TaskName = "ħ��(��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ɱ��ħ���Ľ�֮һ��ħ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�������һ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >����ҡҡ��׹�ˣ����Ѿ�����ħ�񺣵ľ����������ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�š�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1411},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_064", 15 ,{10,17,16}},
	},
	AutoFindWay = { true,  Position={10,17,16}},
	task = {1,413},	-- ���͸���̨��������
};
storyList[100413] =
{

	TaskName = "ħ��(��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "ɱ��ħ���Ľ�֮һ��ħ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���һս�����׻����̾���ʤ���ڴ�һ�١�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���ڽ����ˣ����������ǻ�ʤ�ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1412},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "B_082", 1 ,{10,12,12,1}},
	},
	AutoFindWay = { true,  Position2={10,12,12}},
	task = {1,414},	-- ���͸���̨��������
};
storyList[100414] =
{

	TaskName = '�ر��ݱ�',
	TaskInfo = '���ݱ���֪������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�Ͻ���ȥ�����ݱ���������ة�ࡣ</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�������������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >Ϊ�����°��գ������ࡣ</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1413},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,415},	-- ���͸���̨��������
};
storyList[100415] =
{

	TaskName = '�����ȼ�43��',
	TaskInfo = '���ȼ�������43��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��������һ�£����ȼ�������43����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�̳���֯��һ�ι��ƣ���Ȼ����һ��ʱ�䡣</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����һ�������Ϣһ��ʱ�䡣</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1414},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 43,
	},

	task = {1,416},	-- ���͸���̨��������
};


storyList[100416] =
{

	TaskName = "ҡǮ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������	
	TaskInfo = "��԰�����ҡǮ�������ˣ��ؼ��ջ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ׯ԰���ҡǮ��Ӧ�ó����ˣ��������ȥ��ȡ��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������ҵ����ϻ�ȥ��</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��⣬�յ�һ�����õ���Ϣ���ƺ��������߶����ׯ԰������ͼ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʲô?</font>", --�������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >�����ˣ������Ǽ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ס�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1415},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		yaoqian =1 
	},
	--AutoFindWay = { true,   Position={7,6,19}},
	
	task = {1,417},	-- ���͸���̨��������
};

storyList[100417] =
{

	TaskName = "�Ӷ�ׯ԰",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "���һ���Ӷ�ׯ԰��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������֮���ׯ԰�ǿ��Ա˴˹����ģ�ƽʱһ��ҪС�ġ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ԭ�������������顣</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������ҪŬ�����У���Ҫ��ʱ��ע�����������ߡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ȥ�鿴�¡�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1416},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		homewar =1 ,
	},
--	AutoFindWay = {true,SubmitNPC = true},
	task = {1,418},	-- ���͸���̨��������
};
storyList[100418] =
{

	TaskName = "����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	TaskGuide=1,						-- ��������
	
	TaskInfo = "������ô���ˣ�ȥ����ٰ������������Լ��ɡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�𼱣�Ҫ���ݽ�ϡ�ȥ����ٰ�һ�����ɣ�Ҳ�ɰ�������Ҳ��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ҳ�ԡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��Ϣ���˰ɣ�Ҫ������ʼ�����ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		--"PlayerTip(44)"
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1417},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		fish2 = 1,
	},
	AutoFindWay = {true,Collection={1,47,77,54}},
	task = {1,419},	-- ���͸���̨��������
};

storyList[100419] =
{

	TaskName = '�����ȼ�44��',
	TaskInfo = '���ȼ�������44��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��ε�Ŀ�꣬Ҫ���ȼ�������44����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�и��µ������Ÿ��㣬μˮ��Ϊ��ʳ�����أ����Ҳ�������ա�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >Ϊʲô��</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1418},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 44,
	},

	task = {1,420},	-- ���͸���̨��������
};
storyList[100420] =
{

	TaskName = '�ֹ�ũׯ(һ)',
	TaskInfo = 'ȥμˮ���ũׯ�ֹ��¼����ָ���ʳ������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��˵�ǳ����ֹ�Ĵ��ţ��һ����ǵз���ʿ�ڵ�����ȥ������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��~</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ˣ����ǹ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1419},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,421},	-- ���͸���̨��������
};
storyList[100421] =
{

	TaskName = '�ֹ�ũׯ(��)',
	TaskInfo = 'ȥμˮ���ũׯ�ֹ��¼����ָ���ʳ������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��������ˣ��Ҳ��ţ�������ɱ��������Щ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����������ة����������ģ�������Щ��ʲô������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����һЩ���ֺ�ɽ����</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1420},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_068", 15 ,{10,75,35}},
	},
	AutoFindWay = { true,  Position={10,75,35}},
	task = {1,422},	-- ���͸���̨��������
};
storyList[100422] =
{

	TaskName = '�ֹ�ũׯ(��)',
	TaskInfo = 'ȥμˮ���ũׯ�ֹ��¼����ָ���ʳ������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����Ϊʲô��ũׯ�����ǻ������ڳ���ĵ��ȶ�û���ո</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������Ϊ���¶�����</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��ô����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��Щɽ����ʧȥ���ǡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1421},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_110", 15 ,{10,87,24}},
	},
	AutoFindWay = { true,  Position={10,87,24}},
	task = {2,37},	-- ���͸���̨��������
};

storyList[200037] =
{

	TaskName = '�����ȼ�45��',
	TaskInfo = '���ȼ�������45��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����ô�죿</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���ҽ���Ϊ������45�����ܸ��õĽ����</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����ڻ����ˣ������Ұɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���İ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1422},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 45,
	},

	task = {1,423},	-- ���͸���̨��������
};




storyList[100423] =
{

	TaskName = '�ֹ�ũׯ(��)',
	TaskInfo = 'ȥμˮ���ũׯ�ֹ��¼����ָ���ʳ������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >������Ҫ��ô����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����ȥץ������������</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�ۣ��ÿ��µ����֡�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��Щ����Ҳʧȥ����ʶ��</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2037},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_111", 15 ,{10,91,45}},
	},
	AutoFindWay = { true,  Position={10,91,45}},
	task = {1,424},	-- ���͸���̨��������
};
storyList[100424] =
{

	TaskName = '�ֹ�ũׯ(��)',
	TaskInfo = 'ȥμˮ���ũׯ�ֹ��¼����ָ���ʳ������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��ͻȻ��������ũׯ�������ǳ���һ����ֵ�Ĺ����Ȼ��ų�����Щ����ġ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >Ŷ��������Ǹ�������</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��������Ĺ�����ҵ�ʱ�����Ͷ������£�Ȼ��ڶ������ͳ����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����沼��а������Ȼ�����Ρ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1423},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10003,1,{10,100,8,100013}}},
	},
	AutoFindWay = {true,Collection={10,100,8,100013}},
	task = {1,425},	-- ���͸���̨��������
};
storyList[100425] =
{

	TaskName = '�ֹ�ũׯ(��)',
	TaskInfo = 'ȥμˮ���ũׯ�ֹ��¼����ָ���ʳ������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����а취����������Щ������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���԰����꣬���Ȼ�ȥ���ʦ����</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������һ��ħ���󷨵�ʩ�����ϣ������ٻ�а�ﲢ�Ի������ǡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��Ҫ��ν������а����</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1424},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,426},	-- ���͸���̨��������
};
storyList[100426] =
{

	TaskName = '�����ȼ�46��',
	TaskInfo = '���ȼ�������46��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��εĵ��˲��򵥣���Ҫ���ȼ�������46������ȥ�űȽϱ��ա�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >Ҫ�������а��������ɱ��ʩ���ߡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���Ѱ���ͷ����أ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1425},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 46,
	},

	task = {1,427},	-- ���͸���̨��������
};
storyList[100427] =
{

	TaskName = 'ƽ��ũׯ(һ)',
	TaskInfo = '�����ƻ�ũׯ������Ļ�����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�ͷ�������ǰ��������һ����ħ���Ĳ�ľ��������Ⱦ���������������ͨ�صס�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >Ӣ�ۣ������Σ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���Ѿ��ҵ�Ļ������ˡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1426},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_120", 15 ,{10,101,31}},
	},
	AutoFindWay = { true,  Position={10,101,31}},
	task = {1,428},	-- ���͸���̨��������
};
storyList[100428] =
{

	TaskName = 'ƽ��ũׯ(��)',
	TaskInfo = '�����ƻ�ũׯ������Ļ�����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >̫���ˣ�һ�оͰ������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���ġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����ũׯ�Ĺ��ﲻ�ڳ����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ţ����Ѿ��ƽ��а����</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1427},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_112", 15 ,{10,118,43}},
	},
	AutoFindWay = { true,  Position={10,118,43}},
	task = {2,38},	-- ���͸���̨��������
};

storyList[200038] =
{

	TaskName = 'ƽ��ũׯ(��)',
	TaskInfo = '������ħ���ָ�����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����������������Ѿ����ֵ���ħ��������ǾͿ����ո��ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���ġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������������ħ��Ҳ���������֡�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1428},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_068", 20 ,{10,75,35}},
	},
	AutoFindWay = { true,  Position={10,75,35}},
	task = {2,39},	-- ���͸���̨��������
};
storyList[200039] =
{

	TaskName = 'ƽ��ũׯ(��)',
	TaskInfo = '������ħ���ָ�����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����뽫���ҵ�ɽ�����𣬴�ͨ���͵ĵ�·��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��������������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ˡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2038},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_110", 20 ,{10,87,24}},
	},
	AutoFindWay = { true,  Position={10,87,24}},
	task = {2,40},	-- ���͸���̨��������
};
storyList[200040] =
{

	TaskName = '�����ȼ�47��',
	TaskInfo = '���ȼ�������47��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�ҿ�����Ҳ�����ˣ�������Ϣһ�£����ȼ�������47���ټ�����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��������Ҳ����</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�������������Ȼ�������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��˵��</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2039},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 47,
	},
	--AutoFindWay = { true,  Position={10,87,24}},
	task = {2,41},	-- ���͸���̨��������
};
storyList[200041] =
{

	TaskName = 'ƽ��ũׯ(��)',
	TaskInfo = '������ħ���ָ�����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�뽫�񱩵���������������������˺��ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����Ҫ����Ϣһ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ˣ�������</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2040},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_111", 20 ,{10,91,45}},
	},
	AutoFindWay = { true,  Position={10,91,45}},
	task = {2,42},	-- ���͸���̨��������
};
storyList[200042] =
{

	TaskName = 'ƽ��ũׯ(��)',
	TaskInfo = '������ħ���ָ�����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >֮��ֻҪ�������������𣬾Ϳ����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�������ǾͿ��԰����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >̫���ˡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2041},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_120", 20 ,{10,101,31}},
	},
	AutoFindWay = { true,  Position={10,101,31}},
	task = {1,429},	-- ���͸���̨��������
};

storyList[100429] =
{

	TaskName = 'ƽ��ũׯ(��)',
	TaskInfo = '������������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���¿����ո�ȣ��ָ������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ͺã�������������ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�ɵĲ�����ʳ�Ѿ��������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Ч�ʺܸ߰ɡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2042},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,430},	-- ���͸���̨��������
};
storyList[100430] =
{

	TaskName = '�����ȼ�48��',
	TaskInfo = '���ȼ�������48��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��Ҫ������ǰ�������ܱ����̳��ִ��������ˣ��㽫�ȼ�������48�����������ҡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�̳���ʿ����ʮ���������׷�ɱ�Ҿ���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������Ҫ��ô����</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1429},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 48,
	},

	task = {1,431},	-- ���͸���̨��������
};
storyList[100431] =
{

	TaskName = '������(һ)',
	TaskInfo = 'ͻ�ƺ�����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >ȥǰ���������ϣ��Ƴ�ʮ�����еĺ�������������������а��š�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����ʦ�彫�������񽻸����ǣ����ǿɲ��ܹ�����������ô����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ҿ����ƺ�����ɡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1430},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,432},	-- ���͸���̨��������
};
storyList[100432] =
{

	TaskName = '������(��)',
	TaskInfo = 'ͻ�ƺ�����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����������Ԭ���ʵ���������������ֱȽϺá�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����ȥ���󿴿���</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���˺���̫ǿ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ǰ��������鷳�����󷨡�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1431},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_114", 15 ,{10,102,71}},
	},
	AutoFindWay = { true,  Position={10,102,71}},
	task = {1,433},	-- ���͸���̨��������
};
storyList[100433] =
{

	TaskName = '������(��)',
	TaskInfo = 'ͻ�ƺ�����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�������ռ�һ���鱨��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�㿴���.......</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >ԭ�����������ġ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1432},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_113", 15 ,{10,87,71},"�������鱨"},
	},
	AutoFindWay = { true,  Position={10,87,71}},
	task = {2,43},	-- ���͸���̨��������
};
storyList[200043] =
{

	TaskName = '�����ȼ�49��',
	TaskInfo = '���ȼ�������49��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���ڷ����󷨵�����������Ŀǰ��Ϊ���㣬������49�Ͳ�ȥ����ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ǵġ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1433},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 49,
	},

	task = {1,434},	-- ���͸���̨��������
};


storyList[100434] =
{

	TaskName = '������(��)',
	TaskInfo = 'ͻ�ƺ�����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�������׹����֣������˺�����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�Ǻǡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2043},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "B_083", 1 ,{10,122,94,1}},
	},
	AutoFindWay = { true,  Position2={10,122,94}},
	task = {2,44},	-- ���͸���̨��������
};
storyList[200044] =
{

	TaskName = '����׼����һ��',
	TaskInfo = 'Ϊͻ�ƽ������׼��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����ͻ���󷨺�Χ���������Ƚ���Χ�ĵ���������ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�������������Ǽ�����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�Ǻǡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1434},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_114", 20 ,{10,102,71}},
	},
	AutoFindWay = { true,  Position2={10,102,71}},
	task = {2,45},	-- ���͸���̨��������
};
storyList[200045] =
{

	TaskName = '����׼��������',
	TaskInfo = 'Ϊͻ�ƽ������׼��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�ٽ�������������Ϳ����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�ܺã����������Ǿ�׼���ƽ����ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2044},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_113", 20 ,{10,87,71}},
	},
	AutoFindWay = { true,  Position2={10,87,71}},
	task = {1,435},	-- ���͸���̨��������
};




storyList[100435] =
{

	TaskName = '�����ȼ�50��',
	TaskInfo = '���ȼ�������50��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���Ƭ�̣�������ȥ�ƽ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����ϰ취���ȳ��ҵ������Σ���������û��������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2045},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 50,
	},

	task = {1,436},	-- ���͸���̨��������
};
storyList[100436] =
{

	TaskName = '�����(һ)',
	TaskInfo = 'ͻ�ƽ����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�尡��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ǿ����󷨡�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1435},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_113", 15 ,{10,87,71}},
	},
	AutoFindWay = { true,  Position={10,87,71}},
	task = {1,437},	-- ���͸���̨��������
};
storyList[100437] =
{

	TaskName = '�����(��)',
	TaskInfo = 'ͻ�ƽ����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���ǿ϶�Ӧ����������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >ץ�������������¡�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >ԭ����Щ�����ר�Ź��˻��ǣ�����������������������Ҵ�ͷ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ã����ں����ڻ��㡣</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1436},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_114", 15 ,{10,102,71},"������鱨"},
	},
	AutoFindWay = { true,  Position={10,102,71}},
	task = {1,438},	-- ���͸���̨��������
};
storyList[100438] =
{

	TaskName = '�����(��)',
	TaskInfo = 'ͻ�ƽ����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >׼��������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������˳���������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��������ʹ�졣</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1437},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "B_084", 1 ,{10,122,94,1}},
	},
	AutoFindWay = { true,  Position2={10,122,94}},
	task = {1,439},	-- ���͸���̨��������
};

storyList[100439] =
{

	TaskName = '�ر�ʦ��',
	TaskInfo = '����������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����������ʦ�帴���ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����ĺܺã���μ����������׹���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�Ǻǡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1438},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},	
	task = {2,46},	-- ���͸���̨��������
};
--51����������
storyList[200046] =
{

	TaskName = '�����ȼ���51��',
	TaskInfo = '���ȼ�������51��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����Ϣһ�£����콫�ȼ�������51�ɣ��������Ĵ�ս����Ҫ���������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���죬μˮ�����ǰ������˵�̾��Ĳб���μˮΪ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ô��������</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1439},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 51,
	},
	--AutoFindWay = {true,SubmitNPC = true},	
	task = {2,47},	-- ���͸���̨��������
};

storyList[200047] =
{

	TaskName = '����о�(һ)',
	TaskInfo = '��μˮ�����̳��Ĳб����¡�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��ȥ��Ͻ�߸������ȫ������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˣ�ʦ����</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���������ã��о��Ƚ϶࣬��һ����æ�������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��Ҫ��ʲô��</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2046},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_066", 30 ,{10,39,72}},
	},
	AutoFindWay = { true,  Position2={10,39,72}},
	task = {2,48},	-- ���͸���̨��������
};
storyList[200048] =
{

	TaskName = '����о�(��)',
	TaskInfo = '��μˮ�����̳��Ĳб����¡�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >������ͣ��ɧ��μˮ���գ��Ƚ����������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����μˮ���ϰ��տ���ƽ���������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ǰ���</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2047},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_041", 30 ,{10,37,54}},
	},
	AutoFindWay = { true,  Position2={10,37,54}},
	task = {2,49},	-- ���͸���̨��������
};
storyList[200049] =
{

	TaskName = '����о�(��)',
	TaskInfo = '��μˮ�����̳��Ĳб����¡�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����������̾�ʿ���ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >û�����⡣</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�ܺã�׼����һ��Ŀ�ꡣ</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ʲô��</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2048},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_069", 30 ,{10,40,38}},
	},
	AutoFindWay = { true,  Position2={10,40,38}},
	task = {2,50},	-- ���͸���̨��������
};
storyList[200050] =
{

	TaskName = '����о�(��)',
	TaskInfo = '��μˮ�����̳��Ĳб����¡�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�̾������������Ϯ�����ݲ��ӣ������ǵĽ��������˲����鷳��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ǻ���ʲô����ȥ����������</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����Ĳ�������������ϵ��·��ͬ����������ʱ��Ϣһ�¡�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2049},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_070", 30 ,{10,42,20}},
	},
	AutoFindWay = { true,  Position2={10,42,20}},
	task = {2,51},	-- ���͸���̨��������
};
storyList[200051] =
{

	TaskName = '�����ȼ���52��',
	TaskInfo = '���ȼ�������52��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���콫�ȼ�������53�ɣ��������Ĵ�ս����Ҫ���������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >ͬ�����黹Ҫ����һ��ʱ�䣬��Ҳ������ô���š�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������ʲô��</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2050},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 52,
	},
	--AutoFindWay = {true,SubmitNPC = true},	
	task = {2,52},	-- ���͸���̨��������
};

storyList[200052] =
{

	TaskName = '����о�(��)',
	TaskInfo = '������μˮ�����̳��Ĳб����¡�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��߸����˵μˮ���̾����м���ļ�������ȥ���������̾��������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ȥ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������Ҫ�鷳���ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����Ϊ���°��ա�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2051},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_074", 30 ,{10,54,52}},
	},
	AutoFindWay = { true,  Position2={10,54,52}},
	task = {2,53},	-- ���͸���̨��������
};
storyList[200053] =
{

	TaskName = '����о�(��)',
	TaskInfo = '������μˮ�����̳��Ĳб����¡�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��������һ��ȥ����а����ʿ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >û���⡣</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��������Щ�̳������治����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���ǡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2052},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_067", 30 ,{10,61,28}},
	},
	AutoFindWay = { true,  Position2={10,61,28}},
	task = {2,54},	-- ���͸���̨��������
};
storyList[200054] =
{

	TaskName = '����о�(��)',
	TaskInfo = '������μˮ�����̳��Ĳб����¡�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���о����̾�������ˣ������ǵĺ���ߴ����˲������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���Ľ����Ұɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����û��ʲô�¿�����ס���ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2053},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_071", 30 ,{10,64,7}},
	},
	AutoFindWay = { true,  Position2={10,64,7}},
	task = {2,55},	-- ���͸���̨��������
};
storyList[200055] =
{

	TaskName = '����о�(��)',
	TaskInfo = '������μˮ�����̳��Ĳб����¡�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >������ʦ��ʹ�ø��ַ�����˼��а��Ҳ�����Ǵ����˲������⡣</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ɱ���Ǿ�û�������ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����Ѿ���˵����¼��ˣ����ǳ��ж���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ⶼ������Ӧ�����ġ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2054},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_112", 30 ,{10,118,43}},
	},
	AutoFindWay = { true,  Position2={10,118,43}},
	task = {1,440},	-- ���͸���̨��������
};

storyList[100440] =
{

	TaskName = '�����ȼ���53��',
	TaskInfo = '���ȼ�������53��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����Ϣһ�£����콫�ȼ�������53�ɣ��������Ĵ�ս����������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������ǲ������Ʒɻ����·�����أ��㾡��ȥЭ������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2055},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 53,
	},
	--AutoFindWay = {true,SubmitNPC = true},	
	task = {1,450},	-- ���͸���̨��������
};

storyList[100450] =
{

	TaskName = '��ͨͨ��',
	TaskInfo = '��ս�Ѿ���ʼ��ǰ��μˮЭ��������Ʒɻ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���ˣ�������ü���û�д�����Ϣ�����ˣ�����·���⵽�˵��˵ķ�������һ·С�ġ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >û���⡣</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���ǣ�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1440},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_113", 15 ,{10,87,71}},
	},
	AutoFindWay = { true,  Position={10,87,71}},
	task = {1,451},	-- ���͸���̨��������
};
storyList[100451] =
{

	TaskName = '������̽',
	TaskInfo = '������̽������ˣ�����ͨѶ��ͨ',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����������ɳ�����̽�����ǵ�·����������һֱ�����������Ϣû���ͻ���᪡�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >ԭ����ˣ���������һ�ѡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����������ڸ����ˣ�������û���ȷ�󽫣�ȥ��һ����˵�������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��л�����Ϊ�������ȷ�ٵ�λ�á�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1450},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_114", 15 ,{10,102,71}},
	},
	AutoFindWay = { true,  Position={10,102,71}},
	task = {1,452},	-- ���͸���̨��������
};
storyList[100452] =
{

	TaskName = '��ս���',
	TaskInfo = '����ħ�����죬��һ����˵�����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�̳��ľ������������죬������ħ�ڶ࣬���öԸ�����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���İɣ�������ħ���������ó���</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�������ɵúã����µ��˲����������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������˳����µ���ħ�ˡ�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1451},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_075", 15 ,{10,99,119}},
	},
	AutoFindWay = { true,  Position={10,99,119}},
	task = {1,453},	-- ���͸���̨��������
};
storyList[100453] =
{

	TaskName = 'ħ�����',
	TaskInfo = '����ħ���ޱ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�⣬����ħ��ľ��Ӱ���Ī���̳�ð����֮��踣�����ħ��ͨ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������ô�࣬���ȳ�ս��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >Ӧ����ħ����ӣ���������ϻ�ȥ����ة�ࡣ</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ã��Ҿ��Ȼ�ȥһ�ˡ�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1452},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_076", 15 ,{10,84,133}},
	},
	AutoFindWay = { true,  Position={10,84,133}},
	task = {2,56},	-- ���͸���̨��������
};
storyList[200056] =
{

	TaskName = '�����ȼ���54��',
	TaskInfo = '���ȼ�������54��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����Ŀǰ��ʵ���Ը�ħ����ӱȽϳ��������ȼ�������54�ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >μˮ��ũ������Ϣ��ħ���ֳ����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ȥ��</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1453},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 54,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,57},	-- ���͸���̨��������
};
storyList[200057] =
{

	TaskName = 'μˮ������һ��',
	TaskInfo = '��ħ�ٴ���Űμˮ��ȥ�������ǰɡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��ʲô�����²��Ҳ��ܳɴ��¡�����ȥ����ħ���ľ�з����ȥ��ũ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���ˣ����������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��������ȫ�����Ұɡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2056},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_040", 30 ,{10,50,123}},
	},
	AutoFindWay = { true,  Position={10,50,123}},
	task = {2,58},	-- ���͸���̨��������
};
storyList[200058] =
{

	TaskName = 'μˮ����������',
	TaskInfo = '��ħ�ٴ���Űμˮ��ȥ�������ǰɡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����ȥ����ħ��з����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���ˣ������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ûʲô��</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2057},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_072", 30 ,{10,43,101}},
	},
	AutoFindWay = { true,  Position={10,43,101}},
	task = {2,59},	-- ���͸���̨��������
};
storyList[200059] =
{

	TaskName = 'μˮ����������',
	TaskInfo = '��ħ�ٴ���Űμˮ��ȥ�������ǰɡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�߹���ʹ�ö�ˮ��Ⱦ���أ������������Ժ󽫿������ա�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�汲���������������ڱ�ס�ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ͺá�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2058},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_068", 30 ,{10,75,35}},
	},
	AutoFindWay = { true,  Position={10,75,35}},
	task = {2,62},	-- ���͸���̨��������
};

storyList[200062] =
{

	TaskName = '�����ȼ���55��',
	TaskInfo = '���ȼ�������55��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >Ϊ�˸����ɵĶԸ���Щħ����Ƚ��ȼ�������55�ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�������о����ǿ�˺ܶడ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�һ���Ҫ����Ŭ����</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2059},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 55,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,60},	-- ���͸���̨��������
};


storyList[200060] =
{

	TaskName = 'μˮ�������ģ�',
	TaskInfo = '��ħ�ٴ���Űμˮ��ȥ�������ǰɡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >������������˱��񱩵�����Ϯ���ˣ��������ǡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��л���ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Ҹ����ġ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2062},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_111", 30 ,{10,91,45}},
	},
	AutoFindWay = { true,  Position={10,91,45}},
	task = {2,61},	-- ���͸���̨��������
};
storyList[200061] =
{

	TaskName = 'μˮ�������壩',
	TaskInfo = '��ħ�ٴ���Űμˮ��ȥ�������ǰɡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����������ͣ����������е����֣�ʹ����ʳ��������ֻҪ��������Ǿ������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ȥ�������ǡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��˵��������ħ��Ű�����⣬�ǳ�����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���������ˡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2060},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_120", 30 ,{10,101,31}},
	},
	AutoFindWay = { true,  Position={10,101,31}},
	task = {1,454},	-- ���͸���̨��������
};



storyList[100454] =
{

	TaskName = '�����漱',
	TaskInfo = '��Ȼ���Сʤ�����Ǿ������㣬�����˲���Σ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >������û���˵�����ȥ�����ҵĸ��٣�������ʣ�¶��١�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���ˣ�����ֻ��10���յ��ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >ʲô����ô������ô�죿</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2061},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,455},	-- ���͸���̨��������
};
storyList[100455] =
{

	TaskName = '����ة��',
	TaskInfo = '����������о�����ħ����Ӻ;����������Ϣ',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���˱�������ǿ��Ϊ�˱���ʿ����ս����ʿ������ʳ����Ҳ����һ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ðɣ��һ������ة��ġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���ţ��������㣬ħ��ı�����ս��������ȥ�����ǲ�������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�Ǹ���ô��?</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1454},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,456},	-- ���͸���̨��������
};
storyList[100456] =
{

	TaskName = '�����ȼ���56��',
	TaskInfo = '���ȼ�������56��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >Ψһ�İ취��ն���ж������ܵо�������������ĵȼ��Եͣ�������56���������ҡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���Ѿ�������һ��������ȥ����Ż���֧��30�����ң�ֻ�ܽ�ȼü֮����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >Ŷ��</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1455},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 56,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,457},	-- ���͸���̨��������
};
storyList[100457] =
{

	TaskName = 'ȫ���ս',
	TaskInfo = '��Ʒɻ�������ȫ���ս������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�㴫�ҽ�����Ʒɻ�ȫ���ս���������˴��ע�⣬Ȼ����Ѱ�һ����������������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ش󰡣���ʦ�����ġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��ô����ة����ô˵��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ʦ��˵����</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1456},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,458},	-- ���͸���̨��������
};
storyList[100458] =
{

	TaskName = 'ħ�纷��',
	TaskInfo = '����ħ�纷��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����ðɣ�����������ǰ����Ϊ��Ѱ��һ��ʤ�����һ�������������ע�⣬ʣ�µľ�ȫ�����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��л�������������ҡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���Ѿ�������һ���ֵо��������㻹��Ҫ�Լ�ͻ��һ����������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ס�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1457},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_077", 15 ,{10,113,138}},
	},
	AutoFindWay = { true,  Position={10,113,138}},
	task = {1,459},	-- ���͸���̨��������
};
storyList[100459] =
{

	TaskName = 'ħ�����',
	TaskInfo = '����ħ�����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����һ��ħ����ף��������������л��ᡣ</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��̽������Ϣ���о��������Ӿ���ǰ�档</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >̫���ˣ������ѵã������̳�����</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1458},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_078", 15 ,{10,97,155}},
	},
	AutoFindWay = { true,  Position={10,97,155}},
	task = {1,460},	-- ���͸���̨��������
};
storyList[100460] =
{

	TaskName = '��������',
	TaskInfo = '����о�������ʿ���ӣ�ȡ�����ʤ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >ף��һ·˳�磡</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���Һ���Ϣ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���ã������÷����ִ�����һ�������ӡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ɶ񣬹���һ������</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1459},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_078", 20 ,{10,97,155}},
	},
	AutoFindWay = { true,  Position={10,97,155}},
	task = {1,461},	-- ���͸���̨��������
};

storyList[100461] =
{

	TaskName = '�����ȼ���57��',
	TaskInfo = '���ȼ�������57��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >û�а취��ֻ��ҧ��ƴ���ˡ�������ĵȼ��Եͣ�������57���������ҡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >ɱ�ɣ���ҲҪ����ʿ�䣬���ʿ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��Ҳһ����</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1460},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 57,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,462},	-- ���͸���̨��������
};
storyList[100462] =
{

	TaskName = '����ս(һ)',
	TaskInfo = 'ƴ����ս��һ��Ҫ�������ʤ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�尡��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�尡��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������࣡</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ⲻ��ʲô��</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1461},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_075", 20 ,{10,97,115}},
	},
	AutoFindWay = { true,  Position={10,97,115}},
	task = {2,63},	-- ���͸���̨��������
};

storyList[200063] =
{

	TaskName = '�����ȼ���58��',
	TaskInfo = '���ȼ�������58��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��Ȼ����ô˵����Ϊ����İ�ȫ��������58���������ҡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��Ȼ�����ˣ����Ǿͼ����ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1462},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 58,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,463},	-- ���͸���̨��������
};

storyList[100463] =
{

	TaskName = '����ս(��)',
	TaskInfo = 'ƴ����ս��һ��Ҫ�������ʤ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >������������ǿ�˭ɱ�Ŀ죡</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ã�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��������ô�����һ������ϰɣ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�������Ȼ���͡�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2063},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_076", 20 ,{10,80,131}},
	},
	AutoFindWay = { true,  Position={10,80,131}},
	task = {2,64},	-- ���͸���̨��������
};

storyList[200064] =
{

	TaskName = '�����ȼ���59��',
	TaskInfo = '���ȼ�������59��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��Ȼ��ô˵�ˣ����������Ǹ������ˡ�ȫ��Ҳ��Ҫ��������˻����ȼ�������59�ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�ܺã�ȫ������������ڵȴ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���ǵľ���ʿ����硣</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1463},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 59,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,65},	-- ���͸���̨��������
};

storyList[200065] =
{

	TaskName = 'ѯ�ʽ�������',
	TaskInfo = '������ѯ�ʺ�����������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >Ŀǰǰ�ߣ�ս�¸��ӣ���ȥ����ة�࣬����ʲô�µİ��š�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������ˣ�����������������֮��Ľ����ƻ���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������ϸ�ļƻ���</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2064},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {2,66},	-- ���͸���̨��������
};

storyList[200066] =
{

	TaskName = '�����ȼ���60��',
	TaskInfo = '���ȼ�������60��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >������ô�죬һ��С�ľͻ�ȫ����û����Ҳ�����ţ���ȥ���ȼ�����60����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���ˣ����µĽ����ƻ�ȫ����������С�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���ܿ�����</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2065},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 60,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,67},	-- ���͸���̨��������
};

storyList[200067] =
{

	TaskName = '�����ƻ�',
	TaskInfo = '�����µĽ����ƻ������Ʒɻ���',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���»��ܲ���й¶������뾡�콻���Ʒɻ�������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���µļƻ��������Ͽ�����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ô���ŵģ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2066},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {2,68},	-- ���͸���̨��������
};

storyList[200068] =
{

	TaskName = '�����ȼ���61��',
	TaskInfo = '���ȼ�������61��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���հ��ź�����кܶ�Ӳ��Ҫ����ȥ������61�����ܸ��õ��������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���ˣ���ʼ�����ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2067},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 61,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,464},	-- ���͸���̨��������
};

storyList[100464] =
{

	TaskName = '����ս(��)',
	TaskInfo = 'ƴ����ս��һ��Ҫ�������ʤ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >ǰ�����ֵ��˿��׺��أ������ʱҪС�ġ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��л���ġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�������������һ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���������Ϣһ�£������Ұɡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2068},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_077", 20 ,{10,118,142}},
	},
	AutoFindWay = { true,  Position={10,118,142}},
	task = {2,69},	-- ���͸���̨��������
};

storyList[200069] =
{

	TaskName = '�����ȼ���62��',
	TaskInfo = '���ȼ�������62��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����һ��Ҳ����ǿ�Ĳ��ӣ��㻹��������62��Ϊ�á�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�ҹ�Ȼû�����ˣ������˺ܴ��������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����ʢ���ˣ����Ǽ�������ɡ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1464},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 62,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,465},	-- ���͸���̨��������
};

storyList[100465] =
{

	TaskName = '����ս(��)',
	TaskInfo = 'ƴ����ս��һ��Ҫ�������ʤ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��......�ðɣ�����Ͱ������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����ġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���ڽ����ˣ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ˣ�����ʤ���ˡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2069},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_078", 30 ,{10,98,159}},
	},
	AutoFindWay = { true,  Position={10,98,159}},
	task = {2,70},	-- ���͸���̨��������
};
storyList[200070] =
{

	TaskName = '�����ȼ���63��',
	TaskInfo = '���ȼ�������63��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��Ȼ��ս��������ʤ���ˣ������кܶ�б���Ҫ��������ȥ������63����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���ˣ����ڿ�ʼ��ɨս��������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1465},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 63,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,71},	-- ���͸���̨��������
};
storyList[200071] =
{

	TaskName = '��ɨս����һ��',
	TaskInfo = '����μˮ��ħ��о���',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�ȴ�ħ�����쿪ʼ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���Ĳ�������Ҫ����Ŭ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2070},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_075", 50 ,{10,107,115}},
	},
	AutoFindWay = { true,  Position={10,107,115}},
	task = {2,72},	-- ���͸���̨��������
};

storyList[200072] =
{

	TaskName = '�����ȼ���64��',
	TaskInfo = '���ȼ�������64��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >������ة�໹�ڵȴ�����ʤ������Ϣ����ȥ������64�������ܸ�������о�.</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���Ĳ����������Ͽ�ʼ��һ���ж���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2071},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 64,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,73},	-- ���͸���̨��������
};
storyList[200073] =
{

	TaskName = '��ɨս��������',
	TaskInfo = '����μˮ��ħ��о���',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����ȥ��ħ���ޱ��������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������ʱӦ��û�����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2072},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_076", 50 ,{10,89,132}},
	},
	AutoFindWay = { true,  Position={10,89,132}},
	task = {1,466},	-- ���͸���̨��������
};
storyList[100466] =
{

	TaskName = '�����ȼ���65��',
	TaskInfo = '���ȼ�������65��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����������ʤ���ˣ�������ʤ���������Ѿ�ƣ����������Ϣһ�°ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��ô�����ָ�����Σ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����ˡ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2073},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 65,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,467},	-- ���͸���̨��������
};


storyList[100467] =
{

	TaskName = '���ݽݱ�',
	TaskInfo = '�ַ��ٴ�ʧ�ܣ��̳��Ѿ�������ֹ�ܹ�������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����ϢҪ�Ͻ�����ة��֪�������Ȼ�ȥ�ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����ɽ�з���֮������֪���к���Ϣ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����������Ѿ����ȫʤ��</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1466},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {2,74},	-- ���͸���̨��������
};

storyList[200074] =
{

	TaskName = '�����ȼ���66��',
	TaskInfo = '���ȼ�������66��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��Ȼ���ǽ��̾����������������ˣ���μˮ��û���ȶ�����������66�������°�����ȥ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����ˣ�μˮ���в��ٵ��̳��о���Ϊ���Ժ������ȫ����Ҫ��ȥ�������ǡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ʦ���Ը���</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1467},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 66,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,75},	-- ���͸���̨��������
};
storyList[200075] =
{

	TaskName = '��ɨս��������',
	TaskInfo = '����μˮ��ħ��о���',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��ȥ��ħ�纷���������Ȼ��ȥ���Ʒɻ��İ��š�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����յ�ة�����������ֿ�Я��ɱ���ˣ�������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��Ҳ�ǳ����ˡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2074},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_077", 50 ,{10,113,140}},
	},
	AutoFindWay = { true,  Position={10,113,140}},
	task = {2,76},	-- ���͸���̨��������
};
storyList[200076] =
{

	TaskName = '�����ȼ���67��',
	TaskInfo = '���ȼ�������67��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >Ϊ�˸��õ�����о�����ȥ���ȼ�������67�ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�о��м����̬�ƣ�������ֹ���ǡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >Ҫ��ô����</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2075},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 67,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,77},	-- ���͸���̨��������
};
storyList[200077] =
{

	TaskName = '��ɨս�����ģ�',
	TaskInfo = '����μˮ��ħ��о���',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >ħ���������֯�ߣ�ȥ��������������Ϳ����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������ʱӦ��û�����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2076},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_078", 50 ,{10,98,163}},
	},
	AutoFindWay = { true,  Position={10,98,163}},
	task = {2,78},	-- ���͸���̨��������
};

storyList[200078] =
{

	TaskName = '�����ȼ���68��',
	TaskInfo = '���ȼ�������68��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��Ȼ�����˹��ף����о����Ǽ�����һ����ˣ�����Ҫ�������������ﵽ68����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��Щ����о����ҷ�ɱ���ǵ��������ӣ�ʵ�ڿɶ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ô�ˣ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2077},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 68,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,79},	-- ���͸���̨��������
};
storyList[200079] =
{

	TaskName = '��ɨս�����壩',
	TaskInfo = '����μˮ��ħ��о���',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >ħ�纷������һȺ�ޱ���ɱ������һ���������ӣ���ȥ����������Ϊ���ǵ�ʿ������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��������в����ʿ�������˰���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������������</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2078},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_077", 50 ,{10,113,140}},
	},
	AutoFindWay = { true,  Position={10,113,140}},
	task = {2,80},	-- ���͸���̨��������
};
storyList[200080] =
{

	TaskName = '�����ȼ���69��',
	TaskInfo = '���ȼ�������69��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���ڲ���������ʱ�򣬻��д�����ħ���ޱ�����������69��ȥ������ȫ���������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >׼�������𣿡�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���׼�����ˡ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2079},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 69,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,81},	-- ���͸���̨��������
};
storyList[200081] =
{

	TaskName = '��ɨս��������',
	TaskInfo = '����μˮ��ħ��о���',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�Ǿ�ȥ��ħ���ޱ�ȫ�������������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����μˮ�Ͱ�ȫ�ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ǰ���</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2080},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_076", 50 ,{10,80,131}},
	},
	AutoFindWay = { true,  Position={10,80,131}},
	task = {1,468},	-- ���͸���̨��������
};

storyList[100468] =
{

	TaskName = '��ϲ����',
	TaskInfo = '��ʤ����ϲѶ��������ǵ���������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�Ǻǣ���Ȼ�������������ܹ�һ������ȥ��ϲѶ�����������°ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >ս������ˣ�����ÿ������������ȴ��Ҫǿ���򶨣����Ǽ����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���Ǵ��ȫʤ���о��군�ˡ�</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2081},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,469},	-- ���͸���̨��������
};
storyList[100469] =
{

	TaskName = '�ٹ�����',
	TaskInfo = '��������������ٹ��������գ���ףʤ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��ģ�������̫���ˣ���Ҫ����ٹ��������գ���ףʤ��������ǵ�һ��������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���ҵ���</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�̳��Ѿ���������ɽ���ܹ��������ѳɴ��ơ�������Ϣ�����Ǿ�Ҫ׼�������̳���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ô�죿</font>',

	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1468},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,470},	-- ���͸���̨��������
};
storyList[100470] =
{

	TaskName = '�����ȼ���70��',
	TaskInfo = '���ȼ�������70��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����˳�ƶ�Ϊ��Ҫץ�����ᡣ��ҲҪץ�����������ȼ���70��������ս�ۻ���Ҫ���������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����ˣ��Ҿ��Ѿ�����Ұ��������Ҳǰȥ��æ�ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ȥ��</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1469},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 70,
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,500},	-- ���͸���̨��������
};

--��Ұ����
storyList[100500] =
{

	TaskName = '������Ұ',
	TaskInfo = 'ǰ����Ұ������Ʒɻ���ǲ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�Ʒɻ�Ŀǰ����һ�����ֵ�����Ҫ�������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������ū���ɵ�ǰ�����ֵ��Ҿ������Ƕ��ǿ���֮�ˣ��Ҳ��������������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������Ǻá�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1470},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,501},	-- ���͸���̨��������
};
storyList[100501] =
{

	TaskName = '����ū��',
	TaskInfo = '��ɢū�����˻��ҵ��������ǵ��̳������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >������֣�����Щū������ɢ��Ȼ����������ҵ��������ǵļ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Ұѡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�ܺã���Щū����ɢ�Ӵܣ����������˸������ǡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���������</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1500},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_127", 50 ,{12,26,220}},
	},
	AutoFindWay = { true,  Position={12,26,220}},
	task = {1,502},	-- ���͸���̨��������
};
storyList[100502] =
{

	TaskName = '����ū��������',
	TaskInfo = '��ɱ��������ū����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�Ѿ��ҵ���������ڵأ�����ȥ���ǻ�ɱ�������Щ������ū���ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ȥ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�ܺã��������ǾͿ��Լ��������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >ף������ս��ʤ��</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1501},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_128", 50 ,{12,14,170}},
	},
	AutoFindWay = { true,  Position={12,14,170}},
	task = {1,503},	-- ���͸���̨��������
};
storyList[100503] =
{

	TaskName = '�����ȼ���71��',
	TaskInfo = '���ȼ�������71��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��Ҫ����һ���Ժ�Ľ����ƻ�����Ҳȥ���ȼ�������71���ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����ˣ��и�������㡣</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��˭��</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1502},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 71,
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,504},	-- ���͸���̨��������
};

storyList[100504] =
{

	TaskName = '����',
	TaskInfo = '��ū��ͷ����档',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�Ǳ����ǾȻ�����һ��ū����������������ѡ������ͷ�졣˵����Ҫ����ֻ�ܸ��߾������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����ȥ�������ɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���ˣ���л��������ǣ������ǻ��ǻ�˶�á�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >Ϊʲô��</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1503},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,505},	-- ���͸���̨��������
};
storyList[100505] =
{

	TaskName = '�ж�',
	TaskInfo = 'ū���Ƕ��ж��ˣ���취�����ǽⶾ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����Ϊ�˿������ǣ����������˶���û�н�ҩ�ͻ�˶�á�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���İɣ��һ�����ǽⶾ�ġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����ʲô�������û�¾ͱ�����Ҿ��ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����������ġ���</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1504},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,506},	-- ���͸���̨��������
};
storyList[100506] =
{

	TaskName = '��ҩ�䷽',
	TaskInfo = '��ɱ��ҩʦ����ö�ҩ���䷽��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����еĶ������أ����û���䷽�ҽⲻ�ˡ�����취���䷽���������ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ȥ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���Ĳ��������ȥ�о�һ�¡�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1505},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_129", 50 ,{12,20,135},"��ҩ�䷽"},
	},
	AutoFindWay = { true,  Position={12,20,135}},
	task = {1,507},	-- ���͸���̨��������
};
storyList[100507] =
{

	TaskName = '��ʱ��ҩ',
	TaskInfo = '��ɱ��������ʱ��ҩ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >Ϊ�˱������ƽ�ҩ�ڼ䣬ū���Ƕ�������������ȥ�������Ū����ʱ��ҩ��ū�����͹�ȥ�ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ȥ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�ǳ���л�������Һ��ֵ��ǾͿ��Զ��һ��ʱ�䡣</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1506},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_128", 50 ,{12,23,179},"��ʱ��ҩ"},
	},
	AutoFindWay = { true,  Position={12,23,179}},
	task = {1,508},	-- ���͸���̨��������
};
storyList[100508] =
{

	TaskName = '�ɼ������',
	TaskInfo = '�����ҽʦ�ɼ�������ҩ������ݡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����͵������ҩʦ�Ի�����ҩ�ɷ�������Ҫ�ľ�������ݺ�ħ�����顣</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >Ŷ��������ȥ�ɼ���</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�������ݸ��ҡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1507},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10001,1,{3,58,155,100001}}},
	},
	AutoFindWay = {true,Collection={3,58,155,100001}},
	task = {1,509},	-- ���͸���̨��������
};
storyList[100509] =
{

	TaskName = '�ɼ�ħ������',
	TaskInfo = '�����ҽʦ�ɼ�������ҩ��ħ�����顣',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�ã������Ͳ�ħ�����飬��ȥ�ɼ�������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Ͼ�ȥ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�ã������Ͼ����������Ľ�ҩ�����Ե�һ�ᡣ</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1508},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10006,1,{10,55,153,100015}}},
	},
	AutoFindWay = {true,Collection={10,55,153,100015}},
	task = {1,510},	-- ���͸���̨��������
};
storyList[100510] =
{

	TaskName = '������ҩ',
	TaskInfo = '�������Ľ�ҩ����ū��ͷ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��ҩ�������ˣ�����ū�����͹�ȥ�ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ǳ���л��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���ˣ��ҵ������������ȣ������ҵ�һ�ݡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����������Ҳ������һ�˵Ĺ��͡�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1509},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,511},	-- ���͸���̨��������
};
storyList[100511] =
{

	TaskName = 'ʧ�ٵ�ū��',
	TaskInfo = '��һ����ū���������ˣ�����Ҫȥ�ҵ����ǡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���ˣ����ǻ���һ�����ֵ�֮ǰ�������ˣ����ܲ���Ҳ�Ⱦ����ǡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Ұɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������˵����Ҫ���ұ�¶�ˣ���Ȼ�Ժ�Ͳ��ô�̽��Ϣ�ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��֪�������ߵ�ū��ȥ��������</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1510},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,512},	-- ���͸���̨��������
};
storyList[100512] =
{

	TaskName = '�����ȼ���72��',
	TaskInfo = '���ȼ�������72��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���ǰ������������������ܲ��ˣ���ȥ���ȼ�������72�����ҲŻ�����㡣</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���Ǳ���ȥ������ʦ��ħ��ʵ���ˣ����ݲеĲ������Ρ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ɶ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1511},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 72,
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,513},	-- ���͸���̨��������
};
storyList[100513] =
{

	TaskName = 'ج��',
	TaskInfo = '��ج�Ĵ���ū��ͷ�졣',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�������Զ�ʧȥ�ˣ����˾�ɱ��������������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�Ҹ���ζ�ū��ͷ��˵�ء�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���ˣ�������ô���ˣ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����������ġ���</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1512},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,514},	-- ���͸���̨��������
};
storyList[100514] =
{

	TaskName = '����',
	TaskInfo = 'ħ����ū����������Ҳ��ʹ�࣬�����ǽ��Ѱɣ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�ֵ��ǰ���Ϊʲô������������˰����ǽ��Ѱɣ�������Ǽ���ʹ�ࡣ</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Ұѡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���ˣ����Ƕ�ȥ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ǵġ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1513},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_130", 50 ,{12,15,102}},
	},
	AutoFindWay = { true,  Position={12,15,102}},
	task = {1,515},	-- ���͸���̨��������
};
storyList[100515] =
{

	TaskName = '����',
	TaskInfo = '��ū���Ǳ����ȴ���ҩʦ��ʼ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��ҩʦҲ���������֮һ������������ֻ���鷳�����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Ұѡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��л���ˣ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����֮�͡�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1514},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_129", 50 ,{12,25,149}},
	},
	AutoFindWay = { true,  Position={12,25,149}},
	task = {1,516},	-- ���͸���̨��������
};
storyList[100516] =
{

	TaskName = '�ؼ��Ʒɻ�',
	TaskInfo = 'ū���������Ѿ��������Ʒɻ����档',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�������ֵ��Ǳ�ʬ��Ұ���������¾���ȥæ�ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >Ҳ�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�Ҽ�ū���������ˣ��Ƿ񶼽���ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >һ���Ѿ�����</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1515},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,517},	-- ���͸���̨��������
};
storyList[100517] =
{

	TaskName = '�������',
	TaskInfo = '����Ұ�����������������㱨��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���ɥ������֮�¶������������������ݡ����Ȼ�ȥ�������������ʦ�㱨һ�¡�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ðɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >ͽ������ô������˵��䣿</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >Ϊʲô�ܿ�����ǰ��ա�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1516},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,518},	-- ���͸���̨��������
};
storyList[100518] =
{

	TaskName = '�����ȼ���73��',
	TaskInfo = '���ȼ�������73��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�ˣ����տࣻ����������ࡣ������鲻�ã�������Ϣһ�£����ȼ�������73����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >ͽ�����ָ�����ô���ˣ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >ʦ��������û�����⡣</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1517},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 73,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,519},	-- ���͸���̨��������
};
storyList[100519] =
{

	TaskName = '����ս��',
	TaskInfo = '��֪����ʦ���鱨������ǰ��ս����',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >ǰ���������Ѿ���������ʦ�����ڵأ���ȥ��֮��ɱ��Ϊ��Щū������ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Ͼ�ȥ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����ˣ���Ȼ֪������ʦ����������ɱ���ǲ������ס�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ô�ˣ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1518},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,520},	-- ���͸���̨��������
};
storyList[100520] =
{

	TaskName = 'ǰ�����',
	TaskInfo = '�ҵ��ȷ�٣�ѯ���鱨��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��ֱ��ȥ��ǰ��ٰɣ���֪���ĸ���ϸһЩ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õģ������ȥ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����ʦ����ǰ���ļ�̳�����������Ǳ����ֻ��ؿ��ܱ����š�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���ƹ�ȥ��</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1519},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,521},	-- ���͸���̨��������
};
storyList[100521] =
{

	TaskName = 'ľ������',
	TaskInfo = 'Ϊ����������ʦ���ͱ�����ƿ��ܵ��谭��������ľ�����ܡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���У�ֻ��ǿ��ͻ�ƣ�����ȥ����һ���ľ�������������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Ұѡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�ܺã������Ǽ�����һ��Ŀ�ꡣ</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ʲô��</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1520},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_131", 50 ,{12,57,220}},
	},
	AutoFindWay = { true,  Position={12,57,220}},
	task = {1,522},	-- ���͸���̨��������
};
storyList[100522] =
{

	TaskName = '��������',
	TaskInfo = '����������ʦ�ĵ��������������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����ڶ���ĵ������ܣ������������Ǿ�������ʦ����һ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Ұѡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�ã�ֻҪ���������һ��Ŀ��ܾͿ����ҵ�����ʦ�ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ǻ���ʲô��</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1521},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_132", 50 ,{12,91,224}},
	},
	AutoFindWay = { true,  Position={12,91,224}},
	task = {1,523},	-- ���͸���̨��������
};
storyList[100523] =
{

	TaskName = '��ͭ����',
	TaskInfo = '����������ʦ����ͭ�����������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���һ�����������ͭ���ܣ���С�ġ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���İɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����ǰ���ĵ�·�ʹ�ͨ�ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����ʦ�����ˡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1522},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_133", 50 ,{12,72,184}},
	},
	AutoFindWay = { true,  Position={12,72,184}},
	task = {1,524},	-- ���͸���̨��������
};
storyList[100524] =
{

	TaskName = '�����ȼ���74��',
	TaskInfo = '���ȼ�������74��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >Ϊ�˸��а�����������ʦ������ý��ȼ�������74������ȥ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����ˣ���ô��������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ʲô���ˣ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1523},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 74,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,525},	-- ���͸���̨��������
};
storyList[100525] =
{

	TaskName = '����Ŀ���',
	TaskInfo = '������������ʦ�����ܾͻ����޸������꯰�æ�ҵ�����ʦ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����Ŀ���ȫ�������ˣ�������ҵ�����ʦ��֮ǰ���������׷ѡ���ȥ����꯰�æ�ҵ�����ʦ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����ż�����ʲô����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��Ҫ����ʦ�ְ�æ��</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1524},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,526},	-- ���͸���̨��������
};
storyList[100526] =
{

	TaskName = '����֮�ģ�һ��',
	TaskInfo = 'ͨ���������ϵĿ���ʯ���ҵ�����ʦ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����ʦ�����������˲鿴����������ͨ������ʯ�����ƿ��ܵġ�ֻҪ����㹻�Ŀ���ʯ�Ϳɷ����ҵ����ǡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Ͼ�ȥ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���õ��Ŀ���ʯ�Ƚ����Ұɣ�������ȥ�������ȥ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1525},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_131", 50 ,{12,54,225},"ľ������ʯ"},
	},
	AutoFindWay = { true,  Position={12,54,225}},
	task = {1,527},	-- ���͸���̨��������
};
storyList[100527] =
{

	TaskName = '����֮�ģ�����',
	TaskInfo = '����ʯ���㣬����Ҫ�����Ŀ���ʯ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��꯴�����Ϣ˵��ֻ��ľţ�Ŀ���ʯ������������Ҫ����Ŀ���ʯ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������ȥŪЩ�����Ŀ���ʯ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����Ұɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1526},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_132", 50 ,{12,89,213},"��������ʯ"},
	},
	AutoFindWay = { true,  Position={12,89,213}},
	task = {1,528},	-- ���͸���̨��������
};
storyList[100528] =
{

	TaskName = '����֮�ģ�����',
	TaskInfo = '����ʯ���㣬����Ҫ�����Ŀ���ʯ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >ֻҪ������ͭ���ܵĿ���ʯ�Ϳ����ҵ�����ʦ�ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ȥ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�ܺã��콫����ʯ���ҡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���������ˡ�</font>',--�����
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1527},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_133", 50 ,{12,68,184},"��ͭ����ʯ"},
	},
	AutoFindWay = { true,  Position={12,68,184}},
	task = {1,529},	-- ���͸���̨��������
};
storyList[100529] =
{

	TaskName = '�����ȼ���75��',
	TaskInfo = '���ȼ�������75��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�Ѿ��ҵ�����ʦ�������Ƿǳ�ǿ���㻹�ǽ��ȼ�������75����ȥ�ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����˰����������������˺ܶࡣ</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >ʦ�ֹ����ˡ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1528},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 75,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,530},	-- ���͸���̨��������
};
storyList[100530] =
{

	TaskName = '����ʦ',
	TaskInfo = '������ʦ���������ͨ������ʦ֮���ͨ·��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����ʦ��û����ʶ���Լ���λ���Ѿ���¶�������ھ�ȥ����������ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Ͼ�ȥ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >̫���ˣ��������ǾͿ���������ʦ���������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ϳ����ɡ�</font>',--��ǰ���
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1529},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_134", 50 ,{12,113,231}},
	},
	AutoFindWay = { true,  Position={12,113,231}},
	task = {1,531},	-- ���͸���̨��������
};
storyList[100531] =
{

	TaskName = '�ڹ�Ѫ',
	TaskInfo = 'ȥμˮũ������Ҫ�ڹ�Ѫ���Ƴ�����ʦ�Ļ��֡�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�ɶ񣬾�Ȼ�л��֡��ڹ�ѪӦ�ÿ����Ƴ�����ȥμˮũ������ҪһЩ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Ͼ�ȥ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��ү�������к��¡�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���кڹ�Ѫ��</font>',--��ũ��
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1530},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,532},	-- ���͸���̨��������
};
storyList[100532] =
{

	TaskName = '���ٳ���',
	TaskInfo = 'ũ�򽫺ڹ�Ѫ�����˳����صľ�¥�ϰ塣',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����������صľ�¥�ϰ��ˣ�˵������ȥȥ֮ǰ�Ļ�����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�͹٣����ǳԷ�����ס���أ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�������Һڹ�Ѫ�ġ�</font>',--�������پƵ��ϰ�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1531},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,533},	-- ���͸���̨��������
};
storyList[100533] =
{

	TaskName = '��֮��',
	TaskInfo = '��ʳ�˻��Ļ�����Ƶ��ϰ廻�ڹ�Ѫ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�ڹ�Ѫ���һ���Ǯ�ģ�����ƽ�׸��㡣��˵��Ұ����ʳ�˻��Ļ��Ŀ������ƣ����û����������ɣ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����Ľ����Ұɣ�������Ϣһ�¡�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',--��ǰ���
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1532},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_135", 50 ,{12,98,141},"����"},
	},
	AutoFindWay = { true,  Position={12,98,141}},
	task = {1,534},	-- ���͸���̨��������
};
storyList[100534] =
{

	TaskName = '�����ȼ���76��',
	TaskInfo = '���ȼ�������76��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�ڹ�Ѫ�����ˣ�������ý��ȼ�������76����ȥ��������ʦ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����Ӧ�þ�û�������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��Ҳ��ô���á�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1533},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 76,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,535},	-- ���͸���̨��������
};
storyList[100535] =
{

	TaskName = '����ʦ',
	TaskInfo = '������ʦ�������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����ȥ������ʦ����ɣ�Ϊ���ѵ�ū���Ǳ���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������������Ұս���Ͼͽ�ռ��������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ǰ���</font>',--��ǰ���
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1534},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_136", 50 ,{12,119,168}},
	},
	AutoFindWay = { true,  Position={12,119,168}},
	task = {1,536},	-- ���͸���̨��������
};
storyList[100536] =
{

	TaskName = '��ɨս����һ��',
	TaskInfo = 'Ϊ��û�к��֮�ǣ�����ͭ����ȫ���������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����ͭ���ܺͿ���ʦ���в��࣬���Ǳ��뽫����ȫ������ȥ�����֮�ǡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����ȥ����ͭ���������</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���Ĳ���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������</font>',--��ǰ���
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1535},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_133", 50 ,{12,92,179}},
	},
	AutoFindWay = { true,  Position={12,92,179}},
	task = {1,537},	-- ���͸���̨��������
};
storyList[100537] =
{

	TaskName = '��ɨս��������',
	TaskInfo = 'Ϊ��û�к��֮�ǣ�������ʦȫ���������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����ʦ���������Ǿ���ԴԴ���ϵ�������ֿ��ܣ��������������á�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����Ұ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���Ĳ���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������</font>',--��ǰ���
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1536},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_134", 50 ,{12,115,212}},
	},
	AutoFindWay = { true,  Position={12,115,212}},
	task = {1,538},	-- ���͸���̨��������
};
storyList[100538] =
{

	TaskName = '�ټ�����',
	TaskInfo = '����Ұ��ս����������������ѯ�ʺ����ƻ���',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���Ȼ���᪣��������������������»㱨һ�£�������ʲô�µİ���û�С�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������������Ļ�Ծ���ű�֤����Ұս�µ�˳����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������Ӧ���ġ�</font>',--������
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1537},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,539},	-- ���͸���̨��������
};
storyList[100539] =
{

	TaskName = '�����ȼ���77��',
	TaskInfo = '���ȼ�������77��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����Ľ����ƻ������ƶ��У���ɳ˻�ȥ���ȼ�������77����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����ڹ����ϣ���ô��������¡�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ô�ˣ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1538},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 77,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,540},	-- ���͸���̨��������
};
storyList[100540] =
{

	TaskName = '��������',
	TaskInfo = '������ͻȻ���ԣ���취���Ρ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���ʦ��ͻȻ���ԣ���ôҲ�����ѣ�ȫ��Ҳ���ò�ԭ��פ����һ��Ҫ���������ʦ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ȥ�������ʦ�֡�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�Ҳ鿴��ʦ���ˣ���ȫ�Ҳ���ʦ����Ե�ԭ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�Ǹ�����Ǻá�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1539},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,541},	-- ���͸���̨��������
};
storyList[100541] =
{

	TaskName = '����̫��',
	TaskInfo = '��̫������������ϣ�����ܾ��ν�������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��ţ�̫�����˷������Ӧ���з�������ʦ�塣</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�Ҿ�ȥ��̫�����ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���������д�һ�ٰ���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�˽ٸ�����Ƴ���</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1540},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,542},	-- ���͸���̨��������
};
storyList[100542] =
{

	TaskName = '����ԭ��',
	TaskInfo = '��̫������������ϣ�����ܾ��ν�������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����Ǳ��깫���Ŀ�ͷ����а��²ȥ�������ǲŻ��Եģ��粻�һر�²ȥ�����ǲ������ѵġ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��Ҫ������ȥ�ҡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���ѣ������Ļ��Ǳ��깫�������ٻ�ħ����ӣ�������ħ����ӾͲ���ȡ�ػ��ǡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�������Ͼ�ȥ�������ǡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1541},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,543},	-- ���͸���̨��������
};
storyList[100543] =
{

	TaskName = '�����ȼ���78��',
	TaskInfo = '���ȼ�������78��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��ţ���������߸����Ұ���ۻ�֮�󡣲����ڼ���ȥ���ȼ�������78�����Ա���õ�����ħ����ӡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����ˣ����Ѳ��þۻ���ֻҪ������ħ����ӣ�ʦ��Ļ�����Ȼ��ص����С�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',--����߸
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1542},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 78,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,544},	-- ���͸���̨��������
};
storyList[100544] =
{

	TaskName = '�ռ����ǣ�һ��',
	TaskInfo = '����ħ���ħ�ǲ��ӡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�������㹻��ħ�ǲ��ӣ���ʦ�����л����һ���һ���֡�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���Ĳ���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������</font>',--��ǰ���
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1543},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_137", 50 ,{12,69,162}},
	},
	AutoFindWay = { true,  Position={12,69,162}},
	task = {1,545},	-- ���͸���̨��������
};
storyList[100545] =
{

	TaskName = '�ռ����ǣ�����',
	TaskInfo = '����ħ����������ӡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����������ҪС��һЩ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���Ĳ���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������</font>',--��ǰ���
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1544},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_138", 50 ,{12,58,130}},
	},
	AutoFindWay = { true,  Position={12,58,130}},
	task = {1,546},	-- ���͸���̨��������
};
storyList[100546] =
{

	TaskName = '�����ȼ���79��',
	TaskInfo = '���ȼ�������79��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�Ѿ���ʦ��Ļ������һ�һ�룬����Ҫ�޲�һ���󷨡�����ȥ���ȼ�����79��Ϊ֮����׼����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���Ѿ��޲���ϣ����Ǽ�����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1545},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 79,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,547},	-- ���͸���̨��������
};
storyList[100547] =
{

	TaskName = '�ռ����ǣ�����',
	TaskInfo = '����ħ���ħ�ױ����ӡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����ħ�ױ������ǵķ�������ǿ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���Ĳ������Ǹ�����һ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������</font>',--��ǰ���
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1546},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_139", 50 ,{12,34,100}},
	},
	AutoFindWay = { true,  Position={12,34,100}},
	task = {1,548},	-- ���͸���̨��������
};
storyList[100548] =
{

	TaskName = '�ռ����ǣ��ģ�',
	TaskInfo = '����ħ���ħ�鲿�ӡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����ħ�飬���ǵĹ�������ʤ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����ʦ��Ļ��Ƕ��һ����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >̫���ˡ�</font>',--��ǰ���
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1547},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_141", 50 ,{12,16,71}},
	},
	AutoFindWay = { true,  Position={12,16,71}},
	task = {1,549},	-- ���͸���̨��������
};
storyList[100549] =
{

	TaskName = '��������',
	TaskInfo = '���������Ļ����ͻ�ȥ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >����ǽ�ʦ�屻²ȥ�Ļ��ǣ���커�ͻ�ȥ�ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >ͽ������ζ���㣬Ϊʦ���ܱ�ס������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >ʦ���������Ҹ����ġ�</font>',--��������
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1548},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,550},	-- ���͸���̨��������
};
storyList[100550] =
{

	TaskName = "�����ȼ���80��",
	TaskInfo = "���ȼ�������80��",
	AcceptInfo = "\t<font color='#e6dfcf' >�ɶ���깫����а�����ң���ȥ���ȼ�������80����Ϊʦ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�Ҿ��Ѿ���ʼȫ��ǿ������Ҳ�����ȥ��æ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >֪���ˡ�</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1549},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 80,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,551},	-- ���͸���̨��������
};
storyList[100551] =
{

	TaskName = 'ȫ�����',
	TaskInfo = 'ȥ��Ұ���ӻƷɻ��İ��š�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >������ŵĲ����⵽��ħ����ӵ�ǿ���ֿ�����ȥ��Ұ���ӻƷɻ��İ��š�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >֪���ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����������ã����������������ʱ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��Ը���</font>',--���Ʒɻ�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1550},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,552},	-- ���͸���̨��������
};
storyList[100552] =
{

	TaskName = '�������ᣨһ��',
	TaskInfo = '������س��ŵ��Ļ꣬�������������Ҿ����С�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�Ҿ�����ҪĿ���Ƕ��³��ţ������س��ŵ��Ļ�ǳ��Ѳ�����ͨʿ�������˺��������ǣ�ֻ�п����ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���İɡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�ܺã��������ž��������֡�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ǵġ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1551},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_140", 50 ,{12,75,62}},
	},
	AutoFindWay = { true,  Position={12,75,62}},
	task = {1,553},	-- ���͸���̨��������
};
storyList[100553] =
{

	TaskName = '�������ᣨ����',
	TaskInfo = '����ǰ����س��ŵ���ħ��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >ǰ��������ħ�����ħ�������س��ţ��������ֹ���ǡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ȥ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��������и������һ��Ҫ��������ס���󷽲��Ӳ��ܼ���������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >һ��Ŭ����</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1552},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_142", 50 ,{12,40,25}},
	},
	AutoFindWay = { true,  Position={12,40,25}},
	task = {1,554},	-- ���͸���̨��������
};
storyList[100554] =
{

	TaskName = '�������ᣨ����',
	TaskInfo = '��ֹ��ħʹ�÷�����³��š�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�鱨��ʾ��ħ���ı�ħ�����ͷŴ��ͷ�����׼��������ţ���Ҫ�����ƻ�����ʩ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ȥ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���Ȼ����������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ûʲô��</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1553},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_143", 50 ,{12,81,29}},
	},
	AutoFindWay = { true,  Position={12,81,29}},
	task = {1,555},	-- ���͸���̨��������
};
storyList[100555] =
{

	TaskName = '�������ᣨ�ģ�',
	TaskInfo = 'ʤ��������ǰ����������ħ����Ӱɡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >ֻҪ������ħ������������ž���ȫ�������������С�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���ɸ㶨��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������������ĵ�·�ʹ�ͨ�ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >̫���ˡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1554},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_144", 50 ,{12,112,63}},
	},
	AutoFindWay = { true,  Position={12,112,63}},
	task = {1,556},	-- ���͸���̨��������
};
storyList[100556] =
{

	TaskName = '�����ȼ���81��',
	TaskInfo = '���ȼ�������81��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�깫���ڵ㽫̨�����»��֣���ʱ�޷����ơ����ڼ���ȥ���ȼ�����81����������취��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�깫���ڻ��ֵı����£��ƺ������ٻ�ǿ���ħ����Ǳ�����ֹ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��Ҫ��ô���ƻ����أ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1555},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 81,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,557},	-- ���͸���̨��������
};
storyList[100557] =
{

	TaskName = '�Ƴ����֣�һ��',
	TaskInfo = 'Э����߸�Ƴ����֡�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�⻤������ħ��ľ���ά�֣�ֻҪ����Ұ�ϵ�ħ��������Ͳ������ơ���߸���������£���ȥ������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����ˣ����Ǳȱ�˭ɱ�Ŀ졣</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�кβ��ɡ�</font>',--����߸
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1556},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,558},	-- ���͸���̨��������
};
storyList[100558] =
{

	TaskName = '�Ƴ����֣�����',
	TaskInfo = 'Ϊ�Ƴ����֣�����Ұ�ϵ�ħ�ﶼ������ɡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >������ħ��ʳ�˻���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�õġ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�ٺ٣������Ҫɱ�Ķ�һЩ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >������һ�Ρ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1557},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_135", 50 ,{12,87,131}},
	},
	AutoFindWay = { true,  Position={12,87,131}},
	task = {1,559},	-- ���͸���̨��������
};
storyList[100559] =
{

	TaskName = '�Ƴ����֣�����',
	TaskInfo = 'Ϊ�Ƴ����֣�����Ұ�ϵ�ħ�ﶼ������ɡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����������������ħ�����ȱȡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��������</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������Ҫ��һЩ����θ÷��˰ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ߡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1558},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_137", 50 ,{12,63,144}},
	},
	AutoFindWay = { true,  Position={12,63,144}},
	task = {1,560},	-- ���͸���̨��������
};
storyList[100560] =
{

	TaskName = '�Ƴ����֣��ģ�',
	TaskInfo = 'Ϊ�Ƴ����֣�����Ұ�ϵ�ħ�ﶼ������ɡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >������������ε�Ŀ����������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���ȳ����ˡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�����Ҷ࣬�㻹��������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ɶ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1559},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_138", 50 ,{12,71,118}},
	},
	AutoFindWay = { true,  Position={12,71,118}},
	task = {1,561},	-- ���͸���̨��������
};

storyList[100561] =
{

	TaskName = '�����ȼ���82��',
	TaskInfo = '���ȼ�������82��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����������´��������㡣</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >���ã�����ȥ������82�������ȹ���</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >Ŷ���������������������Ҳ���ܵ������ġ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����һ��Ӯ��</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1560},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 82,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,562},	-- ���͸���̨��������
};

storyList[100562] =
{

	TaskName = '�Ƴ����֣��壩',
	TaskInfo = 'Ϊ�Ƴ����֣�����Ұ�ϵ�ħ�ﶼ������ɡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�����ٱ�˭ɱ��ħ�ױ��ࡣ</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >������α��Ҷ�ʮ������ô���ܣ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����֪���ҵ������˰ɡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1561},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_139", 50 ,{12,42,89}},
	},
	AutoFindWay = { true,  Position={12,42,89}},
	task = {1,563},	-- ���͸���̨��������
};
storyList[100563] =
{

	TaskName = '�Ƴ����֣�����',
	TaskInfo = 'Ϊ�Ƴ����֣�����Ұ�ϵ�ħ�ﶼ������ɡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >֮ǰ��δ��ȫ�����������ħ��ȹ���</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�������Ҷ������㣬����ô�����ô������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ȼ������ĺô���</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1562},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_141", 50 ,{12,24,65}},
	},
	AutoFindWay = { true,  Position={12,24,65}},
	task = {1,564},	-- ���͸���̨��������
};
storyList[100564] =
{

	TaskName = '�Ƴ����֣��ߣ�',
	TaskInfo = 'Ϊ�Ƴ����֣�����Ұ�ϵ�ħ�ﶼ������ɡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >���������Ļ����ԡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���Ǳ��Ҷ࣬������ʲô������</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ʵ����</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1563},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_140", 50 ,{12,87,44}},
	},
	AutoFindWay = { true,  Position={12,87,44}},
	task = {1,565},	-- ���͸���̨��������
};
storyList[100565] =
{

	TaskName = '�����ȼ���83��',
	TaskInfo = '���ȼ�������83��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��Ҳȥ����һ�£����������ȱȡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��Ҳ�ÿ��������83�����������䡣</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����������˲��٣����¿�˭��Ӯ��</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��Ҳ������Ŷ��</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1564},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 83,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,566},	-- ���͸���̨��������
};

storyList[100566] =
{

	TaskName = '�Ƴ����֣��ˣ�',
	TaskInfo = 'Ϊ�Ƴ����֣�����Ұ�ϵ�ħ�ﶼ������ɡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >��һ��������ǿ���ķ����������Ҳ�ã���˭������Ŀ��Ͷ���ħ���ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >����ν��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��δ�ƽ����Ҫ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��Ȼ�������������ʤ����</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1565},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_142", 50 ,{12,56,40}},
	},
	AutoFindWay = { true,  Position={12,56,40}},
	task = {1,567},	-- ���͸���̨��������
};
storyList[100567] =
{

	TaskName = '�Ƴ����֣��ţ�',
	TaskInfo = 'Ϊ�Ƴ����֣�����Ұ�ϵ�ħ�ﶼ������ɡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�ã���ε�Ŀ���Ǳ�ħ����һ��Ӯ�㡣</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ɲ���˵��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�ִ�ƽ�ˣ���������ʵ���൱����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�������˭��˵��׼��</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1566},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_143", 50 ,{12,96,20}},
	},
	AutoFindWay = { true,  Position={12,96,20}},
	task = {1,568},	-- ���͸���̨��������
};
storyList[100568] =
{

	TaskName = '�Ƴ����֣�ʮ��',
	TaskInfo = 'Ϊ�Ƴ����֣�����Ұ�ϵ�ħ�ﶼ������ɡ�',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >������ħ������ʤ����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >һ�����㡣</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >�������࣬��Ӯ�ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >ʦ�֣������ˡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1567},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_144", 50 ,{12,111,96}},
	},
	AutoFindWay = { true,  Position={12,111,96}},
	task = {1,569},	-- ���͸���̨��������
};
storyList[100569] =
{

	TaskName = '�ؼ��Ʒɻ�',
	TaskInfo = 'ת��Ʒɻ����㽫̨�Ļ����Ѿ��Ƴ���',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >ħ�ﶼ������ˣ��㽫̨�ϵĻ���Ҳ�Ѿ��Ƴ�����ȥ��Ʒɻ���������ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��ǡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >���Ĳ������¿��깫������ô�ܡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��һ��ҪΪʦ������</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1568},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,570},	-- ���͸���̨��������
};
storyList[100570] =
{

	TaskName = '�����ȼ���84��',
	TaskInfo = '���ȼ�������84��',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�깫��̫�����ˣ��ӽ��㽫̨��ʿ��������ɱ�ˣ��㻹�ǽ��ȼ�������84����ȥ�Ը�����</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >Ҳ�á�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >����Ӧ��û�������ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ǵġ�</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1569},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		level = 84,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,571},	-- ���͸���̨��������
};
storyList[100571] =
{

	TaskName = "�깫��",
	TaskInfo = "�ҵ��깫����׼����ս��",
	AcceptInfo = "\t<font color='#e6dfcf' >�깫���Ѿ���Χ�ڵ㽫̨��ʣ�µľͿ����ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���İɡ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >û�뵽���һᱻ�Ƶ���˾��ء�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�깫���������˵�ʱ���ˡ�</font>",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1570},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,572},	-- ���͸���̨��������
};

storyList[100572] =
{

	TaskName = '��Ұ����',
	TaskInfo = '�깫�����ܣ�Ҳ��������Ұ֮սʤ��������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >�ߣ���ƾ�㻹����ס�ҡ���ȥ���߽��������Ҳ�����ô���װ��ݵ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >��С�����ܡ�</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��Ȼû��ץ���깫���ܿ�ϧ����������Ұ֮ս��ʤ���ˣ�ȫ�������ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >̫���ˡ�</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1571},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,573},	-- ���͸���̨��������
};


storyList[100573] =
{

	TaskName = 'ʤ����Ϣ',
	TaskInfo = '����Ұ֮ս��ʤ����Ϣ���߽�������',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >ȫ����Ҫ����һ�£���ȥ��ʤ������Ϣ���߾�ʦ�ɡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�����ȥ��</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >��������ϲ�⣬��֪����Ұ֮ս�Ѿ�ʤ���ˡ�</font>\n\n<font color=\'#f8ee73\' ><b>��:</b></font><font color=\'#6cd763\' >�ǵģ�ʦ����</font>',
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1572},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,574},	-- ���͸���̨��������
};

storyList[100574] = {
	TaskName = "�����ȼ���85��",
	--TaskTrack = {1004,5,27},
	TaskInfo = "���ȼ�������85��",
	AcceptInfo = "\t<font color='#e6dfcf' >���ڻ����Ǹ��˵�ʱ�򣬲����³���Ͳ�������ʤ����Ϊ���Ժ��ս������ȥ���ȼ�������85����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >���ܹ�����֮ǰ��Ϊʦ��Ҫ�������Ұ�������Ծ��󻼡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǣ�ʦ����</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1573},
	},
	ClientCompleteCondition = {
		level = 85,
	},
	task = {1,575},
}
storyList[100575] = {
	TaskName = "����ħ�һ��",
	--TaskTrack = {1004,5,27},
	TaskInfo = "ǰ����ҰЭ����߸����ħ�",
	AcceptInfo = "<font color='#e6dfcf' >ǰ��������������Ұ����ħ�︴�ռ��󣬽�߸���ڵ��飬��ȥ��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "<font color='#e6dfcf' >����ħ�ﲻ֪Ϊ�����Ҹ�ȼ�����ܷ�����һ��֮����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >û���⡣</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1574},
	},
	ClientCompleteCondition = {},
	AutoFindWay = {[1] = true,SubmitNPC = true,},
	task = {1,576},
}
storyList[100576] = {
	TaskName = "����ħ�����",
	--TaskTrack = {1004,5,27},
	TaskInfo = "����ʳ�˻�Ѱ������",
	AcceptInfo = "\t<font color='#e6dfcf' >����ǰȥ����ʳ�˻�������֪�ܷ��ҵ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >���з��֣�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������ħ���йء�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1575},
	},
	ClientCompleteCondition = {
		kill = {"M_135",50,{12,87,131,},},
	},
	AutoFindWay = {Position = {12,87,131,},[1] = true,},
	task = {1,577},
}
storyList[100577] = {
	TaskName = "����ħ�����",
	--TaskTrack = {1004,5,27},
	TaskInfo = "����ħ��Ѱ������",
	AcceptInfo = "\t<font color='#e6dfcf' >�ðɣ�ǰȥ����ħ�ǡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >��ô����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������������ļ���</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1576},
	},
	ClientCompleteCondition = {
		kill = {"M_137",50,{12,63,144,},},
	},
	AutoFindWay = {Position = {12,63,144,},[1] = true,},
	task = {1,578},
}
storyList[100578] = {
	TaskName = "�����ȼ���86��",
	--TaskTrack = {1004,5,27},
	TaskInfo = "���ȼ�������86",
	AcceptInfo = "\t<font color='#e6dfcf' >�������������顣����ڼ��㽫�ȼ�������86����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >��������ȡħ���ħ�ױ��Ļ��ǣ�����ʲôԭ�����Ǳ�����ֹ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����Ұɡ�</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1577},
	},
	ClientCompleteCondition = {
		level = 86,
	},
	task = {1,579},
}
storyList[100579] = {
	TaskName = "����ħ��ģ�",
	--TaskTrack = {1004,5,27},
	TaskInfo = "����ħ�ױ����ƻ������ƻ�",
	AcceptInfo = "\t<font color='#e6dfcf' >ɱ��ħ���ħ�ױ��ж�������ȡ������Դ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ȥ����ħ�ױ���</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >��ô������˳��ô��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���á�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1578},
	},
	ClientCompleteCondition = {
		kill = {"M_139",50,{12,42,89,},},
	},
	AutoFindWay = {Position = {12,42,89,},[1] = true,},
	task = {1,580},
}
storyList[100580] = {
	TaskName = "����ħ��壩",
	--TaskTrack = {1004,5,27},
	TaskInfo = "����ħ�飬�ƻ������ƻ�",
	AcceptInfo = "\t<font color='#e6dfcf' >��������ħ�顣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����Ұɡ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >���ɴ��⡣���ǻ���֪��������ȡ��������Ŀ�ġ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >˵���ǡ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1579},
	},
	ClientCompleteCondition = {
		kill = {"M_141",50,{12,24,65,},},
	},
	AutoFindWay = {Position = {12,24,65,},[1] = true,},
	task = {1,581},
}
storyList[100581] = {
	TaskName = "����ħ�����",
	--TaskTrack = {1004,5,27},
	TaskInfo = "��������",
	AcceptInfo = "\t<font color='#e6dfcf' >��������������������ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >����������С���ٲ����ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����һ����ɱ������ɡ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1580},
	},
	ClientCompleteCondition = {
		kill = {"M_138",50,{12,71,118,},},
	},
	AutoFindWay = {Position = {12,71,118,},[1] = true,},
	task = {1,582},
}
storyList[100582] = {
	TaskName = "����ħ��ߣ�",
	--TaskTrack = {1004,5,27},
	TaskInfo = "ͨ����������֪Ļ����ʹ���Ļ�",
	AcceptInfo = "\t<font color='#e6dfcf' >С��Ϊ�Ļ����ȣ�Ϊ����������������������������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ˣ��ҵ����ϸ��߽�߸��������С����</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�Ļ�к����鲻�����ġ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >û��</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1581},
	},
	ClientCompleteCondition = {},
	task = {1,583},
}
storyList[100583] = {
	TaskName = "�����ȼ���87��",
	--TaskTrack = {1004,5,27},
	TaskInfo = "���ȼ�������87��",
	AcceptInfo = "\t<font color='#e6dfcf' >�Ļ���ȡ���Ǻ���������Ϊ����ȫ�����Ƚ��ȼ�������87����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >֪���ˡ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >���������ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����Ӧ��û�����ˡ�</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1582},
	},
	ClientCompleteCondition = {
		level = 87,
	},
	task = {1,584},
}
storyList[100584] = {
	TaskName = "����󻼣�һ��",
	--TaskTrack = {1004,5,27},
	TaskInfo = "�����Ļ�",
	AcceptInfo = "\t<font color='#e6dfcf' >�Ļ�Ϳ����ˣ�ɱ�����ǡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >��ȡ���ǹ�����Ļ��Ȼ��������ʹ�����ɢҲ�ܺܿ츴ԭ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�Ǹ�����Ǻá�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1583},
	},
	ClientCompleteCondition = {
		kill = {"M_140",50,{12,87,44,},},
	},
	AutoFindWay = {Position = {12,87,44,},[1] = true,},
	task = {1,585},
}
storyList[100585] = {
	TaskName = "����󻼣�����",
	--TaskTrack = {1004,5,27},
	TaskInfo = "Ѱ���������ҵ����������Ļ�İ취",
	AcceptInfo = "\t<font color='#e6dfcf' >���ʦ���������˱�������һ���а취��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�Ҿ�ȥ��ʦ����</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >���㽹�������ӣ���Ұ֮����ز�˳�ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������ġ�����</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1584},
	},
	ClientCompleteCondition = {},
	AutoFindWay = {[1] = true,SubmitNPC = true,},
	task = {1,586},
}
storyList[100586] = {
	TaskName = "����󻼣�����",
	--TaskTrack = {1004,5,27},
	TaskInfo = "Ѱ������ҵ����������Ļ�İ취",
	AcceptInfo = "\t<font color='#e6dfcf' >ͽ���𼱣��Ը��Ļ���������а취��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ȥ��</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >���˻���֮�¹�Ȼ�ɶ񣬵�Ҳ����������ı��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >˵���ǡ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1585},
	},
	ClientCompleteCondition = {},
	AutoFindWay = {[1] = true,SubmitNPC = true,},
	task = {1,587},
}
storyList[100587] = {
	TaskName = "�����ȼ���88��",
	--TaskTrack = {1004,5,27},
	TaskInfo = "���ȼ�������88��",
	AcceptInfo = "\t<font color='#e6dfcf' >�Ļ�������������������ұ����������ҵ�����֢����С�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ҳû��ѵȼ�������88����</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >������ˣ���������Ҫ����������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�뽲��</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1586},
	},
	ClientCompleteCondition = {
		level = 88,
	},
	task = {1,588},
}
storyList[100588] = {
	TaskName = "����󻼣��ģ�",
	--TaskTrack = {1004,5,10},
	TaskInfo = "�ص���Ұ���߸�غ�",
	AcceptInfo = "\t<font color='#e6dfcf' >��߸���ڵ����Ļ�֮�£����ǰ����Ұ������ϡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ȥ��</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�Ļ���ǰԭ�ǵ��ش�����ħ������������Ҳ��ū�ۣ�Ϊ���Ǳ��������ǰ�Ϣ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����Ұɡ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1587},
	},
	ClientCompleteCondition = {},
	AutoFindWay = {[1] = true,SubmitNPC = true,},
	task = {1,589},
}
storyList[100589] = {
	TaskName = "����󻼣��壩",
	--TaskTrack = {1004,5,10},
	TaskInfo = "������ħ���߸����",
	AcceptInfo = "\t<font color='#e6dfcf' >����������ħ��ǰȥ��ѵ���ǡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >����ѧ�ղ�������㱻��ħ�ճ�����ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�㲻������</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1588},
	},
	ClientCompleteCondition = {
		kill = {"M_142",50,{12,56,40,},},
	},
	AutoFindWay = {Position = {12,56,40,},[1] = true,},
	task = {1,590},
}
storyList[100590] = {
	TaskName = "����󻼣�����",
	--TaskTrack = {1004,5,10},
	TaskInfo = "�ɼ����ϲ�Ϊ��߸����",
	AcceptInfo = "\t<font color='#e6dfcf' >���ܲɼ����ϲݰ�������������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >û���⣬�����š�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�������ҵ����ʺܿ���ָܻ��ġ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1589},
	},
	ClientCompleteCondition = {
		items = {{10001,1,{3,58,155,100001,},},},
	},
	AutoFindWay = {Collection = {3,58,155,100001,},[1] = true,},
	task = {1,591},
}
storyList[100591] = {
	TaskName = "�����ȼ���89��",
	--TaskTrack = {1004,5,10},
	TaskInfo = "���ȼ�������89��",
	AcceptInfo = "\t<font color='#e6dfcf' >���ǵ���ȡ��ѵ��Ŭ������Լ�ʵ������Ҳ�Ƚ��ȼ�������89����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�����������ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������С��</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1590},
	},
	ClientCompleteCondition = {
		level = 89,
	},
	task = {1,592},
}
storyList[100592] = {
	TaskName = "����󻼣��ߣ�",
	--TaskTrack = {1004,5,10},
	TaskInfo = "�ɼ���������Ƴɿ���ҩ��",
	AcceptInfo = "\t<font color='#e6dfcf' >Ϊ�ⱻ��ħ�����������ˣ��ɼ�ħ�����齻�����Ƴɿ���ҩ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�����Ͳ��ص��ı�ħ��в�ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǵġ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1591},
	},
	ClientCompleteCondition = {
		items = {{10006,1,{10,55,153,100015,},},},
	},
	AutoFindWay = {Collection = {10,55,153,100015,},[1] = true,},
	task = {1,593},
}
storyList[100593] = {
	TaskName = "����󻼣��ˣ�",
	--TaskTrack = {1004,5,10},
	TaskInfo = "�����ħ",
	AcceptInfo = "\t<font color='#e6dfcf' >�����ħ��������ħ������˼䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ϡ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >���Ȼ������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����������</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1592},
	},
	ClientCompleteCondition = {
		kill = {"M_143",50,{12,96,20,},},
	},
	AutoFindWay = {Position = {12,96,20,},[1] = true,},
	task = {1,594},
}
storyList[100594] = {
	TaskName = "����󻼣��ţ�",
	--TaskTrack = {1004,5,10},
	TaskInfo = "����ħ��",
	AcceptInfo = "\t<font color='#e6dfcf' >���ǰȥ����ħ���������ǵ���Ѫ�������ߵ���ꡣ</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >���������ܹ�ƽϢ���ߵ�Թ�������Ǿ����ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >û�����Ǿ����ˡ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1593},
	},
	ClientCompleteCondition = {
		kill = {"M_144",50,{12,111,96,},},
	},
	AutoFindWay = {Position = {12,111,96,},[1] = true,},
	task = {1,595},
}
storyList[100595] = {
	TaskName = "�����ȼ���90��",
	--TaskTrack = {1004,5,10},
	TaskInfo = "���ȼ�������90��",
	AcceptInfo = "\t<font color='#e6dfcf' >��Ұ�Ѿ����������ȼ�������90�������ý��������׼����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ܺã�������Ϳ��Ե�������Ҫ�������ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >̫���ˡ�</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1594},
	},
	ClientCompleteCondition = {
		level = 90,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,596},	-- ���͸���̨��������
}

--��������

storyList[100596] = {
	TaskName = "�µ�����",
	--TaskTrack = {1004,5,10},
	TaskInfo = "���������µ����񽻸��㡣",
	AcceptInfo = "\t<font color='#e6dfcf' >��ʦ���Ѿ��ƶ��˽�������ƻ�����ȥ������ǲ�ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ȥ��</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >���������ã��и����񽻸��㡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʲô����</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1595},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,597},	-- ���͸���̨��������
}
storyList[100597] = {
	TaskName = "Ǳ�볯��",
	--TaskTrack = {1004,5,10},
	TaskInfo = "ȥ�����ҵ����С�ӡ�",
	AcceptInfo = "\t<font color='#e6dfcf' >������һֻ���С��ǰ�����裬�������Ѿ��ܾ�û����Ϣ���أ�������Ǳ�볯��ȥ�ҵ����ǡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�����ˣ���ϧ̫���ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������ʲô�£�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1596},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,598},	-- ���͸���̨��������
}
storyList[100598] = {
	TaskName = "Ѱ��",
	--TaskTrack = {1004,5,10},
	TaskInfo = "�ҵ����С�ӵĶӳ���",
	AcceptInfo = "\t<font color='#e6dfcf' >����С��һ���볯�����ʧ�����У��ӳ���ȥ�������ֵ��ˣ�����һ��Ҫ�ҵ��ӳ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���İɡ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ҵ��ֵ��ǰ�����һ����Ϊ���Ǳ���ġ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ʲô���ˡ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1597},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,600},	-- ���͸���̨��������
}

storyList[100600] = {
	TaskName = "����������",
	--TaskTrack = {1004,5,10},
	TaskInfo = "������᪳ǣ�������������",
	AcceptInfo = "\t<font color='#e6dfcf' >�����Ѿ���ħ��ռ�ݣ�����һ�����ͱ�������ס�ˣ��ֵ��Ƕ������ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >û�뵽�������������ȥ��ʦ������</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >ԭ����������������������Ӧ���������Ի��������Ƴ��󷨺���ܼ���������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1598},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,601},	-- ���͸���̨��������
}
storyList[100601] = {
	TaskName = "���ȼ�������91��",
	--TaskTrack = {1004,5,10},
	TaskInfo = "���ȼ�������91����",
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҫ��Щ׼�������Ƚ��ȼ�������91��Ȼ��ȥ��������ꯣ��������ķԸ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >��Ҫ���󣬱���ѭ�򽥽���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ҫ�������</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1600},
	},
	ClientCompleteCondition = {
		level = 91,
	},
	task = {1,602},	-- ���͸���̨��������
}
storyList[100602] = {
	TaskName = "������",
	--TaskTrack = {1004,5,10},
	TaskInfo = "����Ұ��ɱ����ʦ�ռ�ľ֮�顣",
	AcceptInfo = "\t<font color='#e6dfcf' >Ҫ���Ƴ��������Ի��󣬱����Ƴ���������֮���ҷ��Ľ����Ż��Ч����Ҫ������Ҫľ֮�飬�쵽��Ұȥɱ����ʦ�ռ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������ȥ��</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >������Щľ֮�飬�Ϳ��Ƴ����˵�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >̫���ˡ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1601},
	},
	ClientCompleteCondition = {
		kill = { "M_134", 50 ,{12,115,212},"ľ֮��"},
	},
	AutoFindWay = { true,  Position={12,115,212}},
	task = {1,603},	-- ���͸���̨��������
}
storyList[100603] = {
	TaskName = "�ƽ���",
	--TaskTrack = {1004,5,10},
	TaskInfo = "����Ұ��ɱ��ħ�ռ���֮�顣",
	AcceptInfo = "\t<font color='#e6dfcf' >�������������ơ�������ӭ�ж��⡣��Ҫ������Ҫ��֮�飬�쵽��Ұȥɱ��ħ�ռ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������ȥ��</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ɵúã�������Щ��֮�飬�Ϳ��Ƴ����˵Ľ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >С��һ����</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1602},
	},
	ClientCompleteCondition = {
		kill = { "M_142", 50 ,{12,56,40},"��֮��"},
	},
	AutoFindWay = { true,  Position={12,56,40}},
	task = {1,604},	-- ���͸���̨��������
}
storyList[100604] = {
	TaskName = "��ˮ��",
	--TaskTrack = {1004,5,10},
	TaskInfo = "����Ұ��ɱħ�ױ��ռ���֮�顣",
	AcceptInfo = "\t<font color='#e6dfcf' >����ˮ��ˮ�������½�����ȥ��Ұ��ɱħ�ױ��ռ���֮�飬���ɻ���ˮ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ɵúã�ˮ��������ơ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ҫ�ѵ���ɱ��Ƭ�ײ�����</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1603},
	},
	ClientCompleteCondition = {
		kill = { "M_139", 50 ,{12,42,89},"��֮��"},
	},
	AutoFindWay = { true,  Position={12,42,89}},
	task = {1,605},	-- ���͸���̨��������
}
storyList[100605] = {
	TaskName = "���ȼ�������92��",
	--TaskTrack = {1004,5,10},
	TaskInfo = "���ȼ�������92����",
	AcceptInfo = "\t<font color='#e6dfcf' >�����ս�������Ӽ��ѣ����Ƚ��ȼ�������92����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >׼�����������Ǽ���ɱ�С�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ը���</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1604},
	},
	ClientCompleteCondition = {
		level = 92,
	},
	task = {1,606},	-- ���͸���̨��������
}
storyList[100606] = {
	TaskName = "��ľ��",
	--TaskTrack = {1004,5,10},
	TaskInfo = "����Ұ��ɱħ���ռ���֮�顣",
	AcceptInfo = "\t<font color='#e6dfcf' >ˮ��ľ��ľ�����������������Ҫ��֮�飬��ȥ��Ұɱħ���ռ���֮�顣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����������</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ɵúã�ľ��������ơ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ҫ�ѵ���ɱ��Ƭ�ײ�����</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1605},
	},
	ClientCompleteCondition = {
		kill = { "M_144", 50 ,{12,111,96},"��֮��"},
	},
	AutoFindWay = { true,  Position={12,111,96}},
	task = {1,607},	-- ���͸���̨��������
}

storyList[100607] = {
	TaskName = "�ƻ���",
	--TaskTrack = {1004,5,10},
	TaskInfo = "����Ұ��ɱ��ħ�ռ�ˮ֮�顣",
	AcceptInfo = "\t<font color='#e6dfcf' >ľ���𣬻��������½�����ȥ��Ұ��ɱ��ħ�ռ�ˮ֮�飬����ˮ֮�鷽������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����������</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ɵúã�����������ơ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >̫���ˣ��������˴���</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1606},
	},
	ClientCompleteCondition = {
		kill = { "M_143", 50 ,{12,96,20},"ˮ֮��"},
	},
	AutoFindWay = { true,  Position={12,96,20}},
	task = {2,82},	-- ���͸���̨��������
}

storyList[200082] = {
	TaskName = "����",
	--TaskTrack = {1004,5,10},
	TaskInfo = "�������Ի��󼴽����Ƶ���Ϣ������������",
	AcceptInfo = "\t<font color='#e6dfcf' >�ܺã�������׼���������Ի�����ȥת�潪ʦ�壬��ȫ��׼��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����������</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�����ˣ������Ի�����ƣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ʦ���Ѿ�������</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1607},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,608},	-- ���͸���̨��������
}

storyList[100608] = {
	TaskName = "���ȼ�������93��",
	--TaskTrack = {1004,5,10},
	TaskInfo = "���ȼ�������93����",
	AcceptInfo = "\t<font color='#e6dfcf' >����󼴿�ȫ������������Ҫ����ǲ��������ȥ����һ�£����ȼ�������93����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >׼����������׼������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {2082},
	},
	ClientCompleteCondition = {
		level = 93,
	},
	task = {1,609},	-- ���͸���̨��������
}
storyList[100609] = {
	TaskName = "�Ƴ�����",
	--TaskTrack = {1004,5,10},
	TaskInfo = "��ɱ���󻤷����Ƴ�����",
	AcceptInfo = "\t<font color='#e6dfcf' >���������ƣ���ȥ����Ŧ������ɱ���������޸��󷨡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ɵúã�����һ�ƣ��Ҿ���ɳ���ֱ�룬���Ƴ���!</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ҪΪ��ȥ��ս�ѱ���!</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1608},
	},
	ClientCompleteCondition = {
		kill = {"M_146",50,{13,9,109}},
	},
	AutoFindWay = { true,  Position={13,9,109}},
	task = {1,610},	-- ���͸���̨��������
}
storyList[100610] = {
	TaskName = "��������",
	--TaskTrack = {1004,5,10},
	TaskInfo = "�������裬�����ſڵ�ħ����",
	AcceptInfo = "\t<font color='#e6dfcf' >�򳯸������Ҫ��ȥ�����ſڵ���ħ�����������Ҿ��ܹ�����ֱ�롣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ը���ȷ����</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ɵ�Ư���������Ҿ��Ϳ��Լ���ǰ���ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʤ��ָ�տɴ��ˡ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1609},
	},
	ClientCompleteCondition = {
		kill = {"M_147",50,{13,40,124}},
	},
	AutoFindWay = { true,  Position={13,40,124}},
	task = {1,611},	-- ���͸���̨��������
}
storyList[100611] = {
	TaskName = "�������",
	--TaskTrack = {1004,5,10},
	TaskInfo = "���볯����ڣ��ҵ����ڳ��ͷ�졣",
	AcceptInfo = "\t<font color='#e6dfcf' >��������Ҫ���볯�裬�ҵ����ڳ��ͷ�죬�˽���������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����Ͷ���</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >���������ã������Ѿ�����ħռ�ݡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ô���ˡ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1610},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,612},	-- ���͸���̨��������
}
storyList[100612] = {
	TaskName = "�����鱨",
	--TaskTrack = {1004,5,10},
	TaskInfo = "��������ڵ�ħ���鱨�����Ʒɻ���",
	AcceptInfo = "\t<font color='#e6dfcf' >������ڵ���ħ�ֲ��鱨����������ٻر���������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ʹ���ȥ��</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >��������鱨���ҾͿ��԰��Ž��������ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǵġ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1611},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,613},	-- ���͸���̨��������
}
storyList[100613] = {
	TaskName = "�����ȼ���94",
	--TaskTrack = {1004,5,10},
	TaskInfo = "�����ȼ���94��",
	AcceptInfo = "\t<font color='#e6dfcf' >����ȥ���ȼ�������94�����������ҡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�����������ء�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����������ô�졣</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1612},
	},
	ClientCompleteCondition = {
		level = 94,
	},
	task = {1,614},	-- ���͸���̨��������
}
storyList[100614] = {
	TaskName = "��ȡ������",
	--TaskTrack = {1004,5,10},
	TaskInfo = "ȥ�����ȡ��������",
	AcceptInfo = "\t<font color='#e6dfcf' >���ڳ�����ڶ�����ħ����Ҫ����������������������������ǡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ȥ�������������</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >��������ȡ�������İɣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǵġ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1613},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,615},	-- ���͸���̨��������
}
storyList[100615] = {
	TaskName = "����֮��",
	--TaskTrack = {1004,5,10},
	TaskInfo = "ȥ�����ɼ�����֮����",
	AcceptInfo = "\t<font color='#e6dfcf' >������μˮʱʹ�ù����������ڵ���ħ�ַǳ�ǿ���ٴ�ʹ�ÿ��ܻ�ų��������ħ��Ψ���ö���֮����ǿ����������������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ȥ�ҡ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >��л���˶�ξ�������֮�ˣ�����һ���ᱨ����ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����һ����Ҫ��İ�����</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1614},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {2,83},	-- ���͸���̨��������
}

storyList[200083] = {
	TaskName = "����֮��",
	--TaskTrack = {1004,5,10},
	TaskInfo = "ȥ�����ɼ�����֮����",
	AcceptInfo = "\t<font color='#e6dfcf' >ԭ����ˣ��ܰ������˽�����ħҲ���������ҫ���ⶫ��֮�����պá�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ɵõ�����֮����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�Ҳ�������</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1615},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,616},	-- ���͸���̨��������
}

storyList[100616] = {
	TaskName = "���ȼ�������95",
	--TaskTrack = {1004,5,10},
	TaskInfo = "���ȼ�������95��",
	AcceptInfo = "\t<font color='#e6dfcf' >�����ⶫ��֮����������������������ǿ������Ҫʱ������ǿ������ȥ������95�ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >��ѽ�����������������׼��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��һ����߾�ȫ����</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {2083},
	},
	ClientCompleteCondition = {
		level = 95,
	},
	task = {1,617},	-- ���͸���̨��������
}
storyList[100617] = {
	TaskName = "������ħ",
	--TaskTrack = {1004,5,10},
	TaskInfo = "��ɱ������ڵ���ħ��",
	AcceptInfo = "\t<font color='#e6dfcf' >���������������Ҿ��绢������ȥ���𳯸���ڵ���ħ���ñ��ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ȴ��ľ�����һ�졣</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ܺã�����һ��ս�ֽ����Ҿ�����������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�Ҿ���ʤ��</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1616},
	},
	ClientCompleteCondition = {
		kill = {"M_148",50,{13,13,71}},
	},
	AutoFindWay = { true,  Position={13,13,71}},
	task = {1,618},	-- ���͸���̨��������
}
storyList[100618] = {
	TaskName = "������ħ2",
	--TaskTrack = {1004,5,10},
	TaskInfo = "��ɱ������ڵ���ħ��",
	AcceptInfo = "\t<font color='#e6dfcf' >ս����������ȥǰ�߼���ɱ�аɣ����ȥ����������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ɱ����Щ��ħ��</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ܺã�����һ���ҷ�������ս��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ʿ�Ƿ���ɱ�С�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1617},
	},
	ClientCompleteCondition = {
		kill = {"M_149",50,{13,24,230}},
	},
	AutoFindWay = { true,  Position={13,24,230}},
	task = {1,619},	-- ���͸���̨��������
}
storyList[100619] = {
	TaskName = "������ħ3",
	--TaskTrack = {1004,5,10},
	TaskInfo = "��ɱ������ڵ���ħ��",
	AcceptInfo = "\t<font color='#e6dfcf' >�о���Ҫ�ֵ���ס�ˣ���ȥ����ʬ���������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����̶���</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >̫���ˣ��Ҿ���ʤ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʤ���ս��������ǡ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1618},
	},
	ClientCompleteCondition = {
		kill = {"M_150",50,{13,119,193}},
	},
	AutoFindWay = { true,  Position={13,119,193}},
	task = {1,620},	-- ���͸���̨��������
}
storyList[100620] = {
	TaskName = "����������",
	--TaskTrack = {1004,5,10},
	TaskInfo = "�����ǰ������ħ�Ѿ����𣬿����������档",
	AcceptInfo = "\t<font color='#e6dfcf' >�����ǰ������ħ�Ѿ����𣬿�ȥ���ʦ���档</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >̫���ˣ������˳���ǰ������ħ��ʤ��֮��ָ�տɴ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ʤ���ս��������ǡ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1619},
	},
	ClientCompleteCondition = {
	
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,621},	-- ���͸���̨��������
}
storyList[100621] = {
	TaskName = "�����ȼ���96",
	--TaskTrack = {1004,5,10},
	TaskInfo = "�����ȼ���96��",
	AcceptInfo = "\t<font color='#e6dfcf' >��һ��׼�����𳯸���ڵ������Ƴ������е���ħ����ȥ�ǳ����գ�����������96���ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >׼��������������Ҫ�����㡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�š�</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1620},
	},
	ClientCompleteCondition = {
		level = 96,
	},
	task = {1,622},	-- ���͸���̨��������
}
storyList[100622] = {
	TaskName = "��ҩ",
	--TaskTrack = {1004,5,10},
	TaskInfo = "��ҩ���ϰ�ҪһЩ�������Ч����ҩ��",
	AcceptInfo = "\t<font color='#e6dfcf' >��踽���������ƣ�����ȥ��������ҩ���ϰ�ҪһЩȥ������Ч����ҩ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >��ʲô�£�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��踽���������ƣ�����ҪһЩȥ������Ч����ҩ��</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1621},
	},
	ClientCompleteCondition = {
	
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,623},	-- ���͸���̨��������
}
storyList[100623] = {
	TaskName = "�ɼ������",
	--TaskTrack = {1004,5,10},
	TaskInfo = "ȥ���߲ɼ�һЩ�������",
	AcceptInfo = "\t<font color='#e6dfcf' >��踽��������̫��������Ҫ��ǿҩЧ���С�������Ҫ���ߵ������������ȥ�ɼ�һЩ�ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >������������ҾͿ��Լ�ǿҩЧ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >̫���ˡ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1622},
	},
	ClientCompleteCondition = {
	      items = {{10006,1,{8,74,127,100027,}}},
	},
	AutoFindWay = {Collection = {8,74,127,100027,},[1] = true,},
	task = {1,624},	-- ���͸���̨��������
}
storyList[100624] = {
	TaskName = "����ҩ��",
	--TaskTrack = {1004,5,10},
	TaskInfo = "ȥ�����ҩ������һЩҩ�ġ�",
	AcceptInfo = "\t<font color='#e6dfcf' >��Ҫ��ҩ�߲�������ȥ�����ҩ��������Ҫ��ҩ�İɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����Ͷ���</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >������Ҫ��ʲô��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������Ҫ����һЩȥ��������ҩ��ҩ�ġ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1623},
	},
	ClientCompleteCondition = {
	
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,625},	-- ���͸���̨��������
}
storyList[100625] = {
	TaskName = "����ҩ��",
	--TaskTrack = {1004,5,10},
	TaskInfo = "ȡһЩҩ�Ĵ���ҩ���ϰ塣",
	AcceptInfo = "\t<font color='#e6dfcf' >ԭ����������ҩ�������Ӣ�������ȡ�ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǳ���л��</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >����������ء�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�Ͽ���ҩ�ɡ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1624},
	},
	ClientCompleteCondition = {
	    items = {{10002,1,{1,70,154,100005,}}},
	},
	AutoFindWay = {Collection = {1,70,154,100005,},[1] = true,},
	task = {1,626},	-- ���͸���̨��������
}
storyList[100626] = {
	TaskName ="�ɼ�һЩħ������� ",
	--TaskTrack = {1004,5,10},
	TaskInfo = "ȥμˮ�ɼ�һЩħ�������",
	AcceptInfo = "\t<font color='#e6dfcf' >���У���ͨ�����ҩЧ����������Ҫ������ȥμˮ�ɼ�һЩħ����������С�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����Ͷ���</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >��������͹��ˣ����Ͼ�������ҩ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >̫���ˡ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1625},
	},
	ClientCompleteCondition = {
	    items = {{10006,1,{10,52,150,100014,},},},
	},
	AutoFindWay = {Collection = {10,52,150,100014,},[1] = true,},
	task = {1,627},	-- ���͸���̨��������
}
storyList[100627] = {
	TaskName ="�����������",
	--TaskTrack = {1004,5,10},
	TaskInfo = "ȥ������������������",
	AcceptInfo = "\t<font color='#e6dfcf' >ҩ���������ˣ��Ͽ�ȥ������������������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����Ͷ���</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�����ô���ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Щ������������һ�����ѱ��Ҽ���</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1626},
	},
	ClientCompleteCondition = {
	    kill = {"M_151",50,{13,47,224}},
	},
	AutoFindWay = { true,  Position={13,47,224}},
	task = {1,628},	-- ���͸���̨��������
}
storyList[100628] = {
	TaskName ="����Ƴ��е���ħ",
	--TaskTrack = {1004,5,10},
	TaskInfo = "����Ƴ��е���ħ��",
	AcceptInfo = "\t<font color='#e6dfcf' >�����Ѿ��ڽڰ��ˣ���ȥ��ɱ�Ƴ��е���ħ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >һ��Ҫ�ѵо�������</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ǳ��ã�ʤ��֮��ָ�տɴ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���˸�����������֮����</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1627},
	},
	ClientCompleteCondition = {
	    kill = {"M_152",50,{13,75,212}},
	},
	AutoFindWay = { true,  Position={13,75,212}},
	task = {1,629},	-- ���͸���̨��������
}
storyList[100629] = {
	TaskName ="���������е���ħ",
	--TaskTrack = {1004,5,10},
	TaskInfo = "���������е���ħ��",
	AcceptInfo = "\t<font color='#e6dfcf' >��ȥ������������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >һ��Ҫ�ѵо�������</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ǳ��ã��о��Ѿ������ǻ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >һ��Ҫ���Ƴ��衣</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1628},
	},
	ClientCompleteCondition = {
	    kill = {"M_153",50,{13,98,227}},
	},
	AutoFindWay = { true,  Position={13,98,227}},
	task = {1,630},	-- ���͸���̨��������
}
storyList[100630] = {
	TaskName ="���ȼ�������97��",
	--TaskTrack = {1004,5,10},
	TaskInfo = "���ȼ�������97����",
	AcceptInfo = "\t<font color='#e6dfcf' >������ս���Ҿ�Ҳ�ǳ�ƣ������ȥ����һ�£����ȼ�������97�ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >���������𣬺���ĵ��˽����ѶԸ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������η�塣</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1629},
	},
	ClientCompleteCondition = {
	    level = 97,
	},
	task = {1,631},	-- ���͸���̨��������
}
storyList[100631] = {
	TaskName ="��������",
	--TaskTrack = {1004,5,10},
	TaskInfo = "����һ�����ӡ�",
	AcceptInfo = "\t<font color='#e6dfcf' >���Ӵ�����ԩ�꣬ҹ��������ޣ��ŵþ�ʿ�޷���Ϣ����ǰȥ����һ�¡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�����̳����󣬱���������������˫�֣���ȥһĿ������������ʩа���л����ڴ˵��޷�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ԭ����������</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1630},
	},
	ClientCompleteCondition = {
	   
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,632},	-- ���͸���̨��������
}
storyList[100632] = {
	TaskName ="����",
	--TaskTrack = {1004,5,10},
	TaskInfo = "����������������ԩ�ꡣ",
	AcceptInfo = "\t<font color='#e6dfcf' >������Щ��������������ǣ�۱�������������Ӣ�۰����ǽ��ʹ��ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ðɡ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >��лӢ�ۡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ҫ��β��ܾ��㣿</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1631},
	},
	ClientCompleteCondition = {
	   kill = {"M_154",50,{13,50,33}},
	},
	AutoFindWay = { true,  Position={13,50,33}},
	task = {1,633},	-- ���͸���̨��������
}
storyList[100633] = {
	TaskName ="��������",
	--TaskTrack = {1004,5,10},
	TaskInfo = "Ѱ�������������",
	AcceptInfo = "\t<font color='#e6dfcf' >ֻҪ�ҵ��ұ���ȥ�����飬ȫ��֮�����ɽ��ѡ������ȥ�����ҵ�������Ů��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ðɡ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >����������Ů��������ʲô��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ܽ���������Ѱ���������顣</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1632},
	},
	ClientCompleteCondition = {
	   
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,634},	-- ���͸���̨��������
}
storyList[100634] = {
	TaskName ="�ҵ�����(1)",
	--TaskTrack = {1004,5,10},
	TaskInfo = "Ѱ��Ĺ��ȡ�����顣",
	AcceptInfo = "\t<font color='#e6dfcf' >ԭ�������������ѽ����������������ӳ����Ĺ���£�Ӣ�����ȥȡ�ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >һ���ƾɵ�Ĺ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ӧ�þ�������ˡ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1633},
	},
	ClientCompleteCondition = {
	   
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {2,84},	-- ���͸���̨��������
}

storyList[200084] = {
	TaskName ="�ҵ�����(2)",
	--TaskTrack = {1004,5,10},
	TaskInfo = "ȥ�����ҵ�˫Ŀ��",
	AcceptInfo = "\t<font color='#e6dfcf' >��Ĺ�����ڳ���װ�������̳�ӡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ҵ��ˡ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >��лӢ�ۣ������ڿ��԰�Ϣ�ˣ������Ӣ��һ��Ҫ����槼��Ǹ���������������ͷ֮�ޡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���İɣ�槼������ұؽ���նɱ��</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1634},
	},
	ClientCompleteCondition = {
	   
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,635},	-- ���͸���̨��������
}

storyList[100635] = {
	TaskName ="���ȼ�������98��",
	--TaskTrack = {1004,5,10},
	TaskInfo = "���ȼ�������98����",
	AcceptInfo = "\t<font color='#e6dfcf' >槼����ڵ�¹̨����ħ���ر���������ý��ȼ�������98����ȥ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >׼�����������ľ�ս�������졣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���Ѿ�������׼����</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {2084},
	},
	ClientCompleteCondition = {
	   level = 98,
	},
	task = {1,636},	-- ���͸���̨��������
}
storyList[100636] = {
	TaskName ="����ս��",
	--TaskTrack = {1004,5,10},
	TaskInfo = "ȥ�һƷɻ���",
	AcceptInfo = "\t<font color='#e6dfcf' >��սһ����������ȥǰ�߰����Ʒɻ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >���������ˣ�ս���ǳ����š�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���������������һ����</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1635},
	},
	ClientCompleteCondition = {
	   
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,637},	-- ���͸���̨��������
}
storyList[100637] = {
	TaskName ="��ɱ����",
	--TaskTrack = {1004,5,10},
	TaskInfo = "��ɱ¹̨����ħ������",
	AcceptInfo = "\t<font color='#e6dfcf' >���������������˴�������ħ����¹̨����ȥ��ɱ���ǡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����һ��Ҫ����������</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ܺã�����һ���Ҿ�������������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Щ��ħ������ˡ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1636},
	},
	ClientCompleteCondition = {
	   kill = {"M_155",50,{13,24,42}},
	},
	AutoFindWay = { true,  Position={13,24,42}},
	task = {1,638},	-- ���͸���̨��������
}
storyList[100638] = {
	TaskName ="��ɱ����2",
	--TaskTrack = {1004,5,10},
	TaskInfo = "��ɱ¹̨����ħ������",
	AcceptInfo = "\t<font color='#e6dfcf' >��ħ���������ڶ࣬��ȥ����ǰ�߻�ɱ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����Ѳ���</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ܺã��Ҿ�������ݣ�ʿ�����ǣ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ʿ�Ƿ���ɱ�С�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1637},
	},
	ClientCompleteCondition = {
	   kill = {"M_156",50,{13,48,77}},
	},
	AutoFindWay = { true,  Position={13,48,77}},
	task = {1,639},	-- ���͸���̨��������
}
storyList[100639] = {
	TaskName ="��ɱ����3",
	--TaskTrack = {1004,5,10},
	TaskInfo = "��ɱ¹̨����ħ������",
	AcceptInfo = "\t<font color='#e6dfcf' >�ٽ�������һ�ٽ��о����壡</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ɱ�����ǣ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ܺã��о��Ѿ�����ƣ̬�����������ֵ��Ƿ���ɱ��!</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������н�ʿ�ǵĹ��͡�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1638},
	},
	ClientCompleteCondition = {
	   kill = {"M_157",50,{13,95,60}},
	},
	AutoFindWay = { true,  Position={13,95,60}},
	task = {1,640},	-- ���͸���̨��������
}
storyList[100640] = {
	TaskName ="���ȼ�������99",
	--TaskTrack = {1004,5,10},
	TaskInfo = "���ȼ�������99��",
	AcceptInfo = "\t<font color='#e6dfcf' >�˴�ս�ۣ��Ҿ�����ͬ�����ء���ͽ�ʿ����ȥ����һ�°ɣ����ȼ�������99</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >׼�������𣿾�սһ��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ȴ��ľ�����һ�졣</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1639},
	},
	ClientCompleteCondition = {
	   level = 99,
	},
	task = {1,641},	-- ���͸���̨��������
}
storyList[100641] = {
	TaskName ="��ɱ����4",
	--TaskTrack = {1004,5,10},
	TaskInfo = "��ɱ¹̨����ħ����",
	AcceptInfo = "\t<font color='#e6dfcf' >��ս�Ѿ����죬��ȥǰ����Ԯ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ܺã��о��Ѿ�������֮����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ؽ�����ɱ��Ƭ�ײ�����</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1640},
	},
	ClientCompleteCondition = {
	   kill = {"M_158",50,{13,106,83}},
	},
	AutoFindWay = { true,  Position={13,106,83}},
	task = {1,643},	-- ���͸���̨��������
}

storyList[100643] = {
	TaskName ="��ɱ����5",
	--TaskTrack = {1004,5,10},
	TaskInfo = "��ɱ¹̨����ħ����",
	AcceptInfo = "\t<font color='#e6dfcf' >�о�ֻʣ��һЩ���ಿ�ӣ�ȥ������ȫ������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����Ҫ�����ˡ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ܺã����ڴ�Ӯ���ⳡ�̣��������ǵ�Ӣ�ۡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��ϧ������Ȼ�����˺ܶཫʿ��</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1641},
	},
	ClientCompleteCondition = {
	   kill = {"M_159",50,{13,112,129}},
	},
	AutoFindWay = { true,  Position={13,112,129}},
	task = {1,646},	-- ���͸���̨��������
}

storyList[100646] = {
	TaskName ="��������",
	--TaskTrack = {1004,5,10},
	TaskInfo = "��ʤ������Ϣ���������",
	AcceptInfo = "\t<font color='#e6dfcf' >����¹̨ʱ���֣������������Ѿ������ˡ��������Ѿ��������֣�����ʤ���ˡ���ȥ������Ϣ��֪������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >ս������ˣ����䣬�������������Ѱ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�Ҿ����ȫʤ��������ҵ�ѳɣ��������ߣ�����̫ƽ�ˣ�</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1643},
	},
	ClientCompleteCondition = {
	   
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,647},	-- ���͸���̨��������
}
storyList[100647] = {
	TaskName ="���ȼ�������100",
	--TaskTrack = {1004,5,10},
	TaskInfo = "���ȼ�������100",
	AcceptInfo = "\t<font color='#e6dfcf' >��������̫ƽ��,��������ٹ����졣���������������ߣ����ò���������ȥ�ѵȼ�������100���ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ֻ���������ˡ�</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >�ҡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ң�</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>���<font color='#3cff00'>��Ծ��</font>�ú���<font color='#ff00ff'>����,��Ʒ</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1646},
	},
	ClientCompleteCondition = {
	   level = 100,
	},
	--task = {1,648},	-- ���͸���̨��������
}









storyList[300001] =
{

	TaskName = "������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 1,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "���������ᣬ�����Լ�������ᡣ",		-- ��������
	--AcceptInfo = "\t<font color='#e6dfcf' >����֮ս������������ҲҪ����׼�������ȼ�������50�������Ұɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��ϲ������ᣬ��ϸ��עһ�¹��ܣ����кܶྪϲŶ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = 999,
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		faction = 1
	},

};
storyList[300002] =
{

	TaskName = "��ʯ��Ƕ[ս��]",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 14,	--֧����������
	TaskGuide=1,						-- ��������
	
	TaskInfo = "������װ������Ƕһ�ű�ʯ��",		-- ��������
	--AcceptInfo = "\t<font color='#e6dfcf' >����֮ս������������ҲҪ����׼�������ȼ�������50�������Ұɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��ʯ��ս���кܴ�İ���������ռ���ʯ�ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1324},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		equipbs = 1,		--����װ����Ƕһ�ű�ʯ
	},
	task = {3,3},
};

storyList[300003] =
{
	TaskName = "װ��ǿ��[ս��]",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 14,	--֧����������
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�����ϵ�����ǿ����12����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >װ��������֮�أ�ǿ����Ҫ����ͭǮ����ĳ�ֽǶ���˵��ͭǮ=ս����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ס�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ۣ������������⣬��������Ľ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����������</font>", --�������Ի�
	HelpInfo = "(<a href='event:faction'><u><font color='#3cff00'>����̵�</font>�ɶһ�<font color='#ff00ff'>����ʯ</font></u></a>)",	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3002},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		equiplevel = {0,12},
	},
	task = {3,4},	-- ���͸���̨��������
};
storyList[300004] =
{
	TaskName = "�ҽ�����[ս��]",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 14,	--֧����������
	TaskGuide=1,						-- ��������
	
	TaskInfo = "���ҽ����е�10�ס�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >һ���ú�������ҽ�Ҳ��ս������Ҫ��ɲ��֡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳ���������ҽ���</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������ļҽ���������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����������</font>", --�������Ի�
	HelpInfo = "(<a href='event:garden.DGardenPanel'><u><font color='#3cff00'>��԰��ֲ</font>���ջ�<font color='#ff00ff'>������ͭǮ</font></u></a>)",	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3003},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		herolevel2 = 10
	},
	task = {3,5},	-- ���͸���̨��������	
};

storyList[300005] =
{

	TaskName = "�������[ս��]",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 14,	--֧����������
	TaskGuide=1,						-- ��������
	
	TaskInfo = "��������׵�1�ס�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�������ŵ�˵������������������Ҫս����ս����Ҫ���������Σ��������г齱���ᡣ</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������ȥ�������</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ۣ������������硣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����������</font>", --�������Ի�
	HelpInfo = "(<a href='event:shop.DMallPanel 3'><u><font color='#3cff00'>��Ԫ���̳�</font>�ɹ���<font color='#ff00ff'>���׵�</font></u></a>)",	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3004},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		horselevel = 10  
	},

};
storyList[300006] =
{

	TaskName = "װ���ֽ�[ս��]",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 14,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "�ֽ�����һ��װ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�ֽ�װ���󣬿��Ի��ϴ��ʯ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҫ������ȥŪװ���أ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��̭�����ľ�װ�������߹һ���ֿ��Ի�õ�Ʒ��װ��.</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ��.</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1203},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		fanjie = 1
	},
	task = {3,7},	
};
storyList[300007] =
{

	TaskName = "װ��ϴ��[ս��]",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 14,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "��������һ��ϴ������װ��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >ϴ��ʯ������ϴ��װ���ġ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ϴ����ʲô�ã�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >װ��ϴ��֮�󣬿��Է��ӳ�ȫ����Ǳ������ǿ���ս����.</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ��.</font>", --�������Ի�
	HelpInfo = "(<a href='event:equip.DEquipPanel 3'><u>ͨ��<font color='#3cff00'>�ֽ�װ��</font>�ɵõ�<font color='#ff00ff'>ϴ��ʯ</font></u></a>)",	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3006},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		xilian = 1
	},
	
};

storyList[300008] =
{

	TaskName = "��Ӹ���[����]",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 15,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "�����1����Ӹ�����",		-- ��������
	ClientCompleteAwards = 1 ,
	--AcceptInfo = "\t<font color='#e6dfcf' >�������ŵ�˵������������������Ҫս����ս����Ҫ���������Σ��������г齱���ᡣ</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������ȥ�������</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�������Ӹ������ǲ����в����ջ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǰ���</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1378},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		mfb = 1
	},
	task = {3,9},	-- ���͸���̨��������
};
storyList[300009] =
{

	TaskName = "������[����]",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 15,	--֧����������
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�����1���������������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��Ӹ�����������ٿ���������Ʒ���ǽ��׻��Ԫ�������;����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ԭ����ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��ô����ѧ��ʹ������������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >ѧ���ˣ���лָ�㡣</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3008},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		pm =1
	},
	
};

storyList[300010] =
{

	TaskName = "������(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 10,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "ͨ�������µĵ�2��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��׼�����ٴ���ս��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǵġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������Ҫ������ս��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ȼ��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		--level = 999,
		completed={1256},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		monsterList = 2,
	},
	task = {3,11},	-- ���͸���̨��������
};
storyList[300011] =
{

	TaskName = "������(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 10,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "ͨ�������µĵ�3��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��׼�����ٴ���ս��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǵġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������Ҫ������ս��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ȼ��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3010},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		monsterList = 3,
	},
	task = {3,12},	-- ���͸���̨��������
};
storyList[300012] =
{

	TaskName = "������(4��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 10,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "ͨ�������µĵ�4��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��׼�����ٴ���ս��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǵġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������Ҫ������ս��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ȼ��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3011},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		monsterList = 4,
	},
	task = {3,13},	-- ���͸���̨��������
};
storyList[300013] =
{

	TaskName = "������(5��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 10,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "ͨ�������µĵ�5��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��׼�����ٴ���ս��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǵġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������Ҫ������ս��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ȼ��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3012},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		monsterList = 5,
	},
	task = {3,14},	-- ���͸���̨��������
};
storyList[300014] =
{

	TaskName = "������(6��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 10,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "ͨ�������µĵ�6��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��׼�����ٴ���ս��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǵġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������Ҫ������ս��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ȼ��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3013},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		monsterList = 6,
	},
	task = {3,15},	-- ���͸���̨��������
};
storyList[300015] =
{

	TaskName = "������(7��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 10,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "ͨ�������µĵ�7��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��׼�����ٴ���ս��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǵġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������Ҫ������ս��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ȼ��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3014},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		monsterList = 7,
	},
	task = {3,16},	-- ���͸���̨��������
};
storyList[300016] =
{

	TaskName = "������(8��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 10,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "ͨ�������µĵ�8��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��׼�����ٴ���ս��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǵġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������Ҫ������ս��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ȼ��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3015},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		monsterList = 8,
	},
	task = {3,17},	-- ���͸���̨��������
};
storyList[300017] =
{

	TaskName = "������(9��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 10,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "ͨ�������µĵ�9��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��׼�����ٴ���ս��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǵġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������Ҫ������ս��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ȼ��</font>", --�������Ի�
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3016},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		monsterList = 9,
	},
	--task = {3,17},	-- ���͸���̨��������
};


storyList[300030] =
{

	TaskName = "��λ��[����]",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 13,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "�����4����λ������ս��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��׼������ս��λ������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������ԡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >ͨ����λ��������֪���Լ�����ʵʵ���������Լ��Ķ�λ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǰ���</font>", --�������Ի�
	HelpInfo = "(<a href='event:DHeroRecruitPanel'><u>��λ����<font color='#3cff00'>����</font>����ļ<font color='#ff00ff'>ǿ���ҽ�</font></u></a>)",	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = 999,
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		homebattle2 =4--��λ��
	},
	--task = {3,31},	-- ���͸���̨��������
};
storyList[300031] =
{

	TaskName = "��λ��[����]",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 13,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "�����10����λ������ս��",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��׼������ս��λ������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�������ԡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >ͨ����λ��������֪���Լ�����ʵʵ���������Լ��Ķ�λ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ǰ���</font>", --�������Ի�
	HelpInfo = "(<a href='event:DHeroRecruitPanel'><u>��λ����<font color='#3cff00'>����</font>����ļ<font color='#ff00ff'>ǿ���ҽ�</font></u></a>)",	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = 999,
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		homebattle2 =10--��λ��
	},	
};



storyList[300035] =
{

	TaskName = "��ɻ���[����]",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 11,	--֧����������
	TaskGuide=1,						-- ��������
	
	TaskInfo = "�����3�λ��ͺ����ˡ�",		-- ��������
	
	SubmitInfo = "\t<font color='#e6dfcf' >����ʱ����ܵ��˲��ǹؼ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={2027},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		husong = 3 , --���һ�λ���
	},
};
storyList[300040] =
{

	TaskName = "�������[����]",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 12,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "�����20����������",		-- ��������
	
	SubmitInfo = "\t<font color='#e6dfcf' >��������ÿ����ö�Ҫ��ɣ���Ϊ�ά���������顣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = 999,
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		taskhuan = 20  --���3����������
	},
	
};

storyList[300042] =
{

	TaskName = "��½����½",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 17,	--֧����������
	TaskGuide=1,						-- ��������
	ClientCompleteAwards = 1 ,
	TaskInfo = "��ʹ�õ�½����½��",		-- ��������
	
	SubmitInfo = "\t<font color='#e6dfcf' >ʹ�õ�½����½����Ϸ����������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		--level = 999,
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		dlq = 1 , 
	},
	
};
storyList[300045] =
{

	TaskName = "Ů�ͳ谮[����]",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 16,	--֧����������
	TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�谮����Ů��5��",		-- ��������
	
	SubmitInfo = "\t<font color='#e6dfcf' >����Ů�ͣ����������Լ���ս������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1377},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		daji = 5,
	},
	
};

storyList[300046] =
{

	TaskName = "��������[ս��]",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 16,	--֧����������
	TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "������������һ��",		-- ��������
	
	SubmitInfo = "\t<font color='#e6dfcf' >�����������������ԡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = 999,
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		magicFight = 1,
	},
	
};


storyList[300100] =
{

	TaskName = "�������һ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 4,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "ȥѰ������Ұ��������ʿ��",		-- ��������
	
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."���þò����������������ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ּ����ˣ�������������</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1377},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	task = {3,101},	-- ���͸���̨��������
};
storyList[300101] =
{

	TaskName = "������󣨶���",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 4,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "�����������������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������������ֳ����˺ܶ�����ñ��ؾ�������ţ������ٰ��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�岻�ݴǡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��Ȼ�������������������ǡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3100},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_259", 20 ,{22,28,12}},
	},
	AutoFindWay = { true,  Position={22,28,12}},
	task = {3,102},	-- ���͸���̨��������
};
storyList[300102] =
{

	TaskName = "�����������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 4,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "�����������������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >С�������е����������Ҫ��������һЩ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�һ�С�ĵġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���ˣ�ֻʣ��һЩͳ��֣���Ҫ�����㲻��ʱ�䣬�汧Ǹ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ÿ�����</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3101},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_260", 20 ,{22,19,51}},
	},
	AutoFindWay = { true,  Position={22,19,51}},
	task = {3,103},	-- ���͸���̨��������
};
storyList[300103] =
{

	TaskName = "��������ģ�",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 4,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "�����������������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >ע�ⲻҪ���뵽�������������������п��ܳ������ص�ǿ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ŷ���п��ҵ����ʶһ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >��������������ɢ����࣬���ºܾö����������������ˣ�̫��л���ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���ؿ�����</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3102},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_261", 20 ,{22,36,67}},
	},
	AutoFindWay = { true,  Position={22,36,67}},
	
};



storyList[300111] =
{

	TaskName = "��ѹ���壨һ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 5,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "�����ص���߸����������",		-- ��������
	--AcceptInfo = "\t<font color='#e6dfcf' >ע�ⲻҪ���뵽�������������������п��ܳ������ص�ǿ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ŷ���п��ҵ����ʶһ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���������ã���������ִ���������������Ƥ���ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������Ҫȥ�����忪սô��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1403},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	task = {3,112},
	
};
storyList[300112] =
{

	TaskName = "��ѹ���壨����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 5,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "��ѹ����������������ĺ��壬���ϳ����صİ�ȫ",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���а������Ѿ��ֹ�һ���ˣ���ȥ����Ӱ��̫������ֻ���鷳���ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����Ҿ�֪����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >������ʹ�졣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ʹ�죬������ȫ�Ҹ��ˡ�</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3111},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_255", 20 ,{31,10,96}},
	},
	AutoFindWay = { true,  Position={31,10,96}},
	task = {3,113},
	
};
storyList[300113] =
{

	TaskName = "��ѹ���壨����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 5,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "��ѹ����������������ĺ��壬���ϳ����صİ�ȫ",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >���������ǹ�ϵ��ô�����㲻�᲻���Ұɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����ˣ��Ҽ����ɡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���������º���Ӧ��֪��ʹ�˰ɡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳδ�أ��һ�û���뺣���ء�</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3112},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_256", 20 ,{31,24,63}},
	},
	AutoFindWay = { true,  Position={31,24,63}},
	task = {3,114},
};
storyList[300114] =
{

	TaskName = "��ѹ���壨�ģ�",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 5,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "��ѹ����������������ĺ��壬���ϳ����صİ�ȫ",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�Ǿͳ����񾡣�������һ���ݺݵĽ�ѵ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����Ұɡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���������³����ذ�ȫ�ˣ������������Ⱦơ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�á�</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3113},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_257", 20 ,{31,6,42}},
	},
	AutoFindWay = { true,  Position={31,6,42}},
	
};

--45������������
storyList[300115] =
{

	TaskName = "���μˮ��һ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 5,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "μˮ�ĵ��������������",		-- ��������
	--AcceptInfo = "\t<font color='#e6dfcf' >ע�ⲻҪ���뵽�������������������п��ܳ������ص�ǿ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ŷ���п��ҵ����ʶһ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >Ϊ��ǰ�����ӵİ�ȫ������Ҫ������ǵĺ��֮�ǡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�����Ұɣ�</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1422},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	task = {3,116},
	
};
storyList[300116] =
{

	TaskName = "���μˮ������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 5,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "���μˮ�Ĳ�����ˡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ȥ������������ͽ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���������Ĳ���</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >������</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3115},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_065",30,{10,12,83}},
	},
	AutoFindWay = { true,  Position={10,12,83}},
	task = {3,117},
	
};
storyList[300117] =
{

	TaskName = "���μˮ������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 5,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "���μˮ�Ĳ�����ˡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ȥ����������֪����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ġ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ֽ�ͦ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >С��һ����</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3116},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_039",30,{10,18,157}},
	},
	AutoFindWay = { true,  Position={10,18,157}},
	task = {3,118},
	
};
storyList[300118] =
{

	TaskName = "���μˮ���ģ�",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 5,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "���μˮ�Ĳ�����ˡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >Ӵ����΢����һ�¾ͽ��������ˣ�����ȥ��ħ���ľ�з���������ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�㻹����ʹ���ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ܺã������ٽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�Ҿ�֪����û���ꡣ</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3117},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_040",30,{10,50,123}},
	},
	AutoFindWay = { true,  Position={10,50,123}},
	task = {3,119},
	
};
storyList[300119] =
{

	TaskName = "���μˮ���壩",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 5,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "���μˮ�Ĳ�����ˡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�����ȥ����ħ��з����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >֪���ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���Ȼֵ��������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >����ô˵���в��õ�Ԥ�С�</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3118},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_072",30,{10,43,101}},
	},
	AutoFindWay = { true,  Position={10,43,101}},
	task = {3,120},
	
};
storyList[300120] =
{

	TaskName = "���μˮ������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 5,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "���μˮ�Ĳ�����ˡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ʲô������ȥ��ħ��ҹ����������ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�Ҿ�֪����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���ˣ������ȥ��Ϣ�ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >˵�õĸ����أ���</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3119},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_073",30,{10,60,145}},
	},
	AutoFindWay = { true,  Position={10,60,145}},
	--task = {3,120},
	
};
--49��֧��
storyList[300121] =
{

	TaskName = "ƽ��μˮ��һ��",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 5,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "μˮ�ĵ��������������",		-- ��������
	--AcceptInfo = "\t<font color='#e6dfcf' >ע�ⲻҪ���뵽�������������������п��ܳ������ص�ǿ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >Ŷ���п��ҵ����ʶһ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >ǰ�����Ӹ߸��ͽ�������Ҳ��������ˣ���������󻼡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�ã�</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={1433},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},
	task = {3,122},
	
};
storyList[300122] =
{

	TaskName = "ƽ��μˮ������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 5,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "���μˮ�Ĳ�����ˡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ε�Ŀ�����̾����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >֪���ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ܺã��¸�Ŀ�ꡣ</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3121},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_066",40,{10,39,72}},
	},
	AutoFindWay = { true,  Position={10,39,72}},
	task = {3,123},
	
};
storyList[300123] =
{

	TaskName = "ƽ��μˮ������",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 5,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "���μˮ�Ĳ�����ˡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ε�Ŀ���Ǿ�����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >֪���ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ܺã��¸�Ŀ�ꡣ</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3122},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_041",40,{10,37,54}},
	},
	AutoFindWay = { true,  Position={10,37,54}},
	task = {3,124},
	
};
storyList[300124] =
{

	TaskName = "ƽ��μˮ���ģ�",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 5,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "���μˮ�Ĳ�����ˡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ε�Ŀ�����̾�ʿ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >֪���ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�ܺã��¸�Ŀ�ꡣ</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >�õġ�</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3123},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_069",40,{10,40,38}},
	},
	AutoFindWay = { true,  Position={10,40,38}},
	task = {3,125},
	
};
storyList[300125] =
{

	TaskName = "ƽ��μˮ���壩",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	index = 5,	--֧����������
	TaskGuide=1,						-- ��������
	TaskInfo = "���μˮ�Ĳ�����ˡ�",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >��ε�Ŀ�����̾����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >֪���ˡ�</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >���ˣ���ʱ����������������Ϣһ���ˡ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >̫���ˡ�</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={3124},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_070",40,{10,42,20}},
	},
	AutoFindWay = { true,  Position={10,42,20}},
	--task = {3,125},
	
};



storyList[400001] =
{

	TaskName = "�ַ�����(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�������һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = {40,44},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_350", 1000 ,{200,33,115}},
	},	
	task = {4,2},
};
storyList[400002] =
{

	TaskName = "�ַ�����(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�������һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4001},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_350", 1500 ,{200,58,138}},
	},	
	task = {4,3},
};
storyList[400003] =
{

	TaskName = "�ַ�����(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�������һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4002},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_350", 2000 ,{200,25,68}},
	},	
	
};

storyList[400006] =
{

	TaskName = "�ַ�����(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�������һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = {45,49},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_351", 1000 ,{201,33,115}},
	},	
	task = {4,7},
};
storyList[400007] =
{

	TaskName = "�ַ�����(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�������һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4006},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_351", 1500 ,{201,17,94}},
	},	
	task = {4,8},
};
storyList[400008] =
{

	TaskName = "�ַ�����(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�������һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4007},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_351", 2000 ,{201,15,43}},
	},	
	
};


storyList[400011] =
{

	TaskName = "�ַ�����(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = {50,54},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_352", 1000 ,{202,8,94}},
	},	
	task = {4,12},
};
storyList[400012] =
{

	TaskName = "�ַ�����(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4011},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_352", 1500 ,{202,8,94}},
	},	
	task = {4,13},
};
storyList[400013] =
{

	TaskName = "�ַ�����(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4012},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_352", 2000 ,{202,8,94}},
	},	
	
};


storyList[400016] =
{

	TaskName = "�ַ�����(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = {55,59},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_353", 1000 ,{203,20,46}},
	},	
	task = {4,17},
};
storyList[400017] =
{

	TaskName = "�ַ�����(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4016},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_353", 1500 ,{203,17,76}},
	},	
	task = {4,18},
};
storyList[400018] =
{

	TaskName = "�ַ�����(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4017},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_353", 2000 ,{203,35,80}},
	},	
	
};


storyList[400021] =
{

	TaskName = "�ַ�����(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = {60,64},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_354", 1000 ,{204,14,49}},
	},	
	task = {4,22},
};
storyList[400022] =
{

	TaskName = "�ַ�����(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4021},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_354", 1500 ,{204,34,55}},
	},	
	task = {4,23},
};
storyList[400023] =
{

	TaskName = "�ַ�����(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4022},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_354", 2000 ,{204,23,74}},
	},	
	
};


storyList[400026] =
{

	TaskName = "�ַ�����(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = {65,69},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_355", 1000 ,{205,68,161}},
	},	
	task = {4,27},
};
storyList[400027] =
{

	TaskName = "�ַ�����(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4026},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_355", 1500 ,{205,68,161}},
	},	
	task = {4,28},
};
storyList[400028] =
{

	TaskName = "�ַ�����(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4027},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_355", 2000 ,{205,68,161}},
	},	
	
};


storyList[400031] =
{

	TaskName = "�ַ�����(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = {70,74},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_356", 1000 ,{205,40,127}},
	},	
	task = {4,32},
};
storyList[400032] =
{

	TaskName = "�ַ�����(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4031},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_356", 1500 ,{205,40,127}},
	},	
	task = {4,33},
};
storyList[400033] =
{

	TaskName = "�ַ�����(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4032},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_356", 2000 ,{205,40,127}},
	},	
	
};

storyList[400036] =
{

	TaskName = "�ַ�����(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = {75,79},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_357", 1000 ,{205,58,67}},
	},	
	task = {4,37},
};
storyList[400037] =
{

	TaskName = "�ַ�����(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4036},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_357", 1500 ,{205,58,67}},
	},	
	task = {4,38},
};
storyList[400038] =
{

	TaskName = "�ַ�����(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4037},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_357", 2000 ,{205,58,67}},
	},	
	
};

storyList[400041] =
{

	TaskName = "�ַ�����(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = {80,84},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_358", 1000 ,{205,105,119}},
	},	
	task = {4,42},
};
storyList[400042] =
{

	TaskName = "�ַ�����(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4041},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_358", 1500 ,{205,105,119}},
	},	
	task = {4,43},
};
storyList[400043] =
{

	TaskName = "�ַ�����(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4042},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_358", 2000 ,{205,105,119}},
	},	
	
};
storyList[400046] =
{

	TaskName = "�ַ�����(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = {85,89},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_359", 1000 ,{206,23,99}},
	},	
	task = {4,47},
};
storyList[400047] =
{

	TaskName = "�ַ�����(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4046},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_359", 1500 ,{206,23,99}},
	},	
	task = {4,48},
};
storyList[400048] =
{

	TaskName = "�ַ�����(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4047},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_359", 2000 ,{206,23,99}},
	},	
	
};
storyList[400051] =
{

	TaskName = "�ַ�����(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = {90,94},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_360", 1000 ,{206,46,62}},
	},	
	task = {4,52},
};
storyList[400052] =
{

	TaskName = "�ַ�����(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4051},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_360", 1500 ,{206,46,62}},
	},	
	task = {4,53},
};
storyList[400053] =
{

	TaskName = "�ַ�����(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4052},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_360", 2000 ,{206,46,62}},
	},	
	
};
storyList[400056] =
{

	TaskName = "�ַ�����(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = {95,99},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_361", 1000 ,{207,21,73}},
	},	
	task = {4,57},
};
storyList[400057] =
{

	TaskName = "�ַ�����(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4056},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_361", 1500 ,{207,21,73}},
	},	
	task = {4,58},
};
storyList[400058] =
{

	TaskName = "�ַ�����(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�����һ��ؾ�����ɹ����ַ���",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >�һ��ؾ���ѹ�Ÿ�����ħ�����ڸ�������ʿͨ��ս����ĥ���Լ�������ʵ����</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��Ҳȥ����һ�ᡣ</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >����ж����ʱ�䣬�������ڹһ��ؾ����������������񣬻����и��ֹ�����Ʒ���䡣</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��лָ�㡣</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4057},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "GJ_361", 2000 ,{207,21,73}},
	},	
	
};
storyList[400101] =
{

	TaskName = "����ճ�(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		faction = 1,
		level = {30,39},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_018", 20 ,{8,57,124}},
	},	
	
};
storyList[400102] =
{

	TaskName = "����ճ�(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4101},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_019", 20 ,{8,25,95}},
	},	
	
};
storyList[400103] =
{

	TaskName = "����ճ�(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4102},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_017", 20 ,{8,14,50}},
	},	
	
};
storyList[400104] =
{

	TaskName = "����ճ�(4��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4103},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_018", 20 ,{8,57,124}},
	},	
	
};
storyList[400105] =
{

	TaskName = "����ճ�(5��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4104},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_019", 20 ,{8,25,95}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};
storyList[400160] =
{

	TaskName = "����ճ�(6��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4105},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_017", 20 ,{8,14,50}},
	},	
	
};
storyList[400161] =
{

	TaskName = "����ճ�(7��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4160},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_018", 20 ,{8,57,124}},
	},	
	
};
storyList[400162] =
{

	TaskName = "����ճ�(8��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4161},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_019", 20 ,{8,25,95}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};
storyList[400163] =
{

	TaskName = "����ճ�(9��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4162},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_017", 20 ,{8,14,50}},
	},	
	
};
storyList[400164] =
{

	TaskName = "����ճ�(10��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4163},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_018", 20 ,{8,57,124}},
	},	
	
};
storyList[400165] =
{

	TaskName = "����ճ�(11��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4164},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_019", 20 ,{8,25,95}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};
storyList[400166] =
{

	TaskName = "����ճ�(12��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4165},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_017", 20 ,{8,14,50}},
	},	
	
};
storyList[400167] =
{

	TaskName = "����ճ�(13��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4166},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_018", 20 ,{8,57,124}},
	},	
	
};
storyList[400168] =
{

	TaskName = "����ճ�(14��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4167},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_019", 20 ,{8,25,95}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};
storyList[400169] =
{

	TaskName = "����ճ�(15��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4168},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_017", 20 ,{8,14,50}},
	},	
	
};
storyList[400170] =
{

	TaskName = "����ճ�(16��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4169},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_018", 20 ,{8,57,124}},
	},	
	
};
storyList[400171] =
{

	TaskName = "����ճ�(17��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4170},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_019", 20 ,{8,25,95}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};
storyList[400172] =
{

	TaskName = "����ճ�(18��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4171},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_017", 20 ,{8,14,50}},
	},	
	
};
storyList[400173] =
{

	TaskName = "����ճ�(19��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4172},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_018", 20 ,{8,57,124}},
	},	
	
};
storyList[400174] =
{

	TaskName = "����ճ�(20��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	--SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4173},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_019", 20 ,{8,25,95}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};

--40~44
storyList[400106] =
{

	TaskName = "����ճ�(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "������ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		faction = 1,
		level = {40,44},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_259", 20 ,{22,27,10}},
	},	
	
};
storyList[400107] =
{

	TaskName = "����ճ�(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4106},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_260", 20 ,{22,16,43}},
	},	
	
};
storyList[400108] =
{

	TaskName = "����ճ�(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4107},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_261", 20 ,{22,34,67}},
	},	
	
};
storyList[400109] =
{

	TaskName = "����ճ�(4��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4108},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_259", 20 ,{23,11,70}},
	},	

};
storyList[400110] =
{

	TaskName = "����ճ�(5��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4109},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_261", 20 ,{22,34,67}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};
storyList[400180] =
{

	TaskName = "����ճ�(6��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "������ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4110},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_259", 20 ,{22,27,10}},
	},	
	
};
storyList[400181] =
{

	TaskName = "����ճ�(7��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4180},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_260", 20 ,{22,16,43}},
	},	
	
};
storyList[400182] =
{

	TaskName = "����ճ�(8��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4181},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_261", 20 ,{22,34,67}},
	},	
	
};
storyList[400183] =
{

	TaskName = "����ճ�(9��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "������ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4182},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_259", 20 ,{22,27,10}},
	},	
	
};
storyList[400184] =
{

	TaskName = "����ճ�(10��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4183},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_260", 20 ,{22,16,43}},
	},	
	
};
storyList[400185] =
{

	TaskName = "����ճ�(11��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4184},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_261", 20 ,{22,34,67}},
	},	
	
};
storyList[400186] =
{

	TaskName = "����ճ�(12��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "������ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4185},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_259", 20 ,{22,27,10}},
	},	
	
};
storyList[400187] =
{

	TaskName = "����ճ�(13��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4186},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_260", 20 ,{22,16,43}},
	},	
	
};
storyList[400188] =
{

	TaskName = "����ճ�(14��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4187},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_261", 20 ,{22,34,67}},
	},	
	
};
storyList[400189] =
{

	TaskName = "����ճ�(15��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "������ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4188},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_259", 20 ,{22,27,10}},
	},	
	
};
storyList[400190] =
{

	TaskName = "����ճ�(16��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4189},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_260", 20 ,{22,16,43}},
	},	
	
};
storyList[400191] =
{

	TaskName = "����ճ�(17��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4190},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_261", 20 ,{22,34,67}},
	},	
	
};
storyList[400192] =
{

	TaskName = "����ճ�(18��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "������ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4191},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_259", 20 ,{22,27,10}},
	},	
	
};
storyList[400193] =
{

	TaskName = "����ճ�(19��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4192},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_260", 20 ,{22,16,43}},
	},	
	
};
storyList[400194] =
{

	TaskName = "����ճ�(20��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4193},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_261", 20 ,{22,34,67}},
	},	
	
};







--45~49
storyList[400111] =
{

	TaskName = "����ճ�(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		faction = 1,
		level = {45,49},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_255", 20 ,{31,23,116}},
	},	
	
};
storyList[400112] =
{

	TaskName = "����ճ�(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4111},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_256", 20 ,{31,26,59}},
	},	
	
};
storyList[400113] =
{

	TaskName = "����ճ�(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4112},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_257", 20 ,{31,8,41}},
	},	
	
};
storyList[400114] =
{

	TaskName = "����ճ�(4��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4113},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_257", 20 ,{30,7,12}},
	},	
	
};
storyList[400115] =
{

	TaskName = "����ճ�(5��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4114},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_258", 20 ,{33,26,81}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};
storyList[400200] =
{

	TaskName = "����ճ�(6��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4115},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_255", 20 ,{31,23,116}},
	},	
	
};
storyList[400201] =
{

	TaskName = "����ճ�(7��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4200},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_256", 20 ,{31,26,59}},
	},	
	
};
storyList[400202] =
{

	TaskName = "����ճ�(8��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4201},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_257", 20 ,{31,8,41}},
	},	
	
};
storyList[400203] =
{

	TaskName = "����ճ�(9��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4202},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_257", 20 ,{30,7,12}},
	},	
	
};
storyList[400204] =
{

	TaskName = "����ճ�(10��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4203},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_258", 20 ,{33,26,81}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};
storyList[400205] =
{

	TaskName = "����ճ�(11��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4204},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_255", 20 ,{31,23,116}},
	},	
	
};
storyList[400206] =
{

	TaskName = "����ճ�(12��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4205},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_256", 20 ,{31,26,59}},
	},	
	
};
storyList[400207] =
{

	TaskName = "����ճ�(13��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4206},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_257", 20 ,{31,8,41}},
	},	
	
};
storyList[400208] =
{

	TaskName = "����ճ�(14��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4207},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_257", 20 ,{30,7,12}},
	},	
	
};
storyList[400209] =
{

	TaskName = "����ճ�(15��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4208},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_258", 20 ,{33,26,81}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};
storyList[400210] =
{

	TaskName = "����ճ�(16��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4209},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_255", 20 ,{31,23,116}},
	},	
	
};
storyList[400211] =
{

	TaskName = "����ճ�(17��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4210},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_256", 20 ,{31,26,59}},
	},	
	
};
storyList[400212] =
{

	TaskName = "����ճ�(18��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4211},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_257", 20 ,{31,8,41}},
	},	
	
};
storyList[400213] =
{

	TaskName = "����ճ�(19��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4212},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_257", 20 ,{30,7,12}},
	},	
	
};
storyList[400214] =
{

	TaskName = "����ճ�(20��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4213},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_258", 20 ,{33,26,81}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};


--50~59
storyList[400116] =
{

	TaskName = "����ճ�(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		faction = 1,
		level = {50,59},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_262", 20 ,{24,51,40}},
	},	
	
};
storyList[400117] =
{

	TaskName = "����ճ�(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4116},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_263", 20 ,{24,6,41}},
	},	
	
};
storyList[400118] =
{

	TaskName = "����ճ�(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4117},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_264", 20 ,{25,20,47}},
	},	
	
};
storyList[400119] =
{

	TaskName = "����ճ�(4��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4118},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_265", 20 ,{25,15,7}},
	},	
	
};
storyList[400120] =
{

	TaskName = "����ճ�(5��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4119},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_265", 20 ,{25,58,28}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};
storyList[400220] =
{

	TaskName = "����ճ�(6��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4120},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_262", 20 ,{24,51,40}},
	},	
	
};
storyList[400221] =
{

	TaskName = "����ճ�(7��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4220},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_263", 20 ,{24,6,41}},
	},	
	
};
storyList[400222] =
{

	TaskName = "����ճ�(8��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4221},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_264", 20 ,{25,20,47}},
	},	
	
};
storyList[400223] =
{

	TaskName = "����ճ�(9��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4222},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_265", 20 ,{25,15,7}},
	},	
	
};
storyList[400224] =
{

	TaskName = "����ճ�(10��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4223},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_265", 20 ,{25,58,28}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};
storyList[400225] =
{

	TaskName = "����ճ�(11��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4224},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_262", 20 ,{24,51,40}},
	},	
	
};
storyList[400226] =
{

	TaskName = "����ճ�(12��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4225},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_263", 20 ,{24,6,41}},
	},	
	
};
storyList[400227] =
{

	TaskName = "����ճ�(13��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4226},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_264", 20 ,{25,20,47}},
	},	
	
};
storyList[400228] =
{

	TaskName = "����ճ�(14��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4227},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_265", 20 ,{25,15,7}},
	},	
	
};
storyList[400229] =
{

	TaskName = "����ճ�(15��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4228},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_265", 20 ,{25,58,28}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};
storyList[400230] =
{

	TaskName = "����ճ�(16��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4229},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_262", 20 ,{24,51,40}},
	},	
	
};
storyList[400231] =
{

	TaskName = "����ճ�(17��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4230},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_263", 20 ,{24,6,41}},
	},	
	
};
storyList[400232] =
{

	TaskName = "����ճ�(18��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4231},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_264", 20 ,{25,20,47}},
	},	
	
};
storyList[400233] =
{

	TaskName = "����ճ�(19��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4232},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_265", 20 ,{25,15,7}},
	},	
	
};
storyList[400234] =
{

	TaskName = "����ճ�(20��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4233},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_265", 20 ,{25,58,28}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};


--60~100
storyList[400121] =
{

	TaskName = "����ճ�(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		faction = 1,
		level = {60,100},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_266", 20 ,{28,8,27}},
	},	
	
};
storyList[400122] =
{

	TaskName = "����ճ�(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4121},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_266", 20 ,{28,30,24}},
	},	
	
};
storyList[400123] =
{

	TaskName = "����ճ�(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4122},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_267", 20 ,{29,14,13}},
	},	
	
};
storyList[400124] =
{

	TaskName = "����ճ�(4��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4123},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_268", 20 ,{29,9,46}},
	},	
	
};
storyList[400125] =
{

	TaskName = "����ճ�(5��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4124},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_269", 20 ,{29,15,70}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};
storyList[400240] =
{

	TaskName = "����ճ�(6��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4125},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_266", 20 ,{28,8,27}},
	},	
	
};
storyList[400241] =
{

	TaskName = "����ճ�(7��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4240},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_266", 20 ,{28,30,24}},
	},	
	
};
storyList[400242] =
{

	TaskName = "����ճ�(8��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4241},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_267", 20 ,{29,14,13}},
	},	
	
};
storyList[400243] =
{

	TaskName = "����ճ�(9��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4242},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_268", 20 ,{29,9,46}},
	},	
	
};
storyList[400244] =
{

	TaskName = "����ճ�(10��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4243},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_269", 20 ,{29,15,70}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};
storyList[400245] =
{

	TaskName = "����ճ�(11��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4244},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_266", 20 ,{28,8,27}},
	},	
	
};
storyList[400246] =
{

	TaskName = "����ճ�(12��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4245},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_266", 20 ,{28,30,24}},
	},	
	
};
storyList[400247] =
{

	TaskName = "����ճ�(13��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4246},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_267", 20 ,{29,14,13}},
	},	
	
};
storyList[400248] =
{

	TaskName = "����ճ�(14��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4247},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_268", 20 ,{29,9,46}},
	},	
	
};
storyList[400249] =
{

	TaskName = "����ճ�(15��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4248},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_269", 20 ,{29,15,70}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};
storyList[400250] =
{

	TaskName = "����ճ�(16��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4249},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_266", 20 ,{28,8,27}},
	},	
	
};
storyList[400251] =
{

	TaskName = "����ճ�(17��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4250},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_266", 20 ,{28,30,24}},
	},	
	
};
storyList[400252] =
{

	TaskName = "����ճ�(18��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4251},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_267", 20 ,{29,14,13}},
	},	
	
};
storyList[400253] =
{

	TaskName = "����ճ�(19��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},		
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4252},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_268", 20 ,{29,9,46}},
	},	
	
};
storyList[400254] =
{

	TaskName = "����ճ�(20��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "����ɰ���ճ�����",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҽң���Ҫ��ҽ�������</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	----SubmitInfo = "\t<font color='#e6dfcf' >���������Ի�ù����ƣ����׺���Ի�ðﹱ�����Ҳ���ð���ʽ�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��л��</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4253},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "G_269", 20 ,{29,15,70}},
	},	
	--task = {4,3},	-- ���͸���̨��������
};














storyList[400150] =
{

	TaskName = "VIP����(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "���VIP����ɻ�ô�������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҫ��ҵ�֧�֡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�Ҵ�����Ҹ�л���֧Ԯ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������</font>", --�������Ի�	
	HelpInfo = "(<a href='event:auction.DAuctionPanel'><u>ͨ��<font color='#3cff00'>��Ӹ���</font>��<font color='#ff00ff'>������</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = 999,
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{641,5}},
	},	
	
};
storyList[400151] =
{

	TaskName = "VIP����(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "���VIP����ɻ�ô�������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҫ��ҵ�֧�֡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�Ҵ�����Ҹ�л���֧Ԯ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������</font>", --�������Ի�	
	HelpInfo = "(<a href='event:auction.DAuctionPanel'><u>ͨ��<font color='#3cff00'>��Ӹ���</font>��<font color='#ff00ff'>������</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4150},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{641,10}},
	},	
	
};
storyList[400152] =
{

	TaskName = "VIP����(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "���VIP����ɻ�ô�������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҫ��ҵ�֧�֡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�Ҵ�����Ҹ�л���֧Ԯ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������</font>", --�������Ի�	
	HelpInfo = "(<a href='event:auction.DAuctionPanel'><u>ͨ��<font color='#3cff00'>��Ӹ���</font>��<font color='#ff00ff'>������</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4151},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{641,20}},
	},	

};

storyList[400900] =
{

	TaskName = "����ճ�",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "�ڿ����л�ȡ20������ֵ",		-- ��������
	--AcceptInfo = "\t<font color='#e6dfcf' >������Ҫ��ҵ�֧�֡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�Ҵ�����Ҹ�л���֧Ԯ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������</font>", --�������Ի�	
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = 50 ,
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		eGetWW = 20,
	},	

};



storyList[400950] =
{

	TaskName = "VIP����(1��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "���VIP����ɻ�ô�������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҫ��ҵ�֧�֡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�Ҵ�����Ҹ�л���֧Ԯ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������</font>", --�������Ի�	
	HelpInfo = "(<a href='event:auction.DAuctionPanel'><u>ͨ��<font color='#3cff00'>��Ӹ���</font>��<font color='#ff00ff'>������</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		level = 35,
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{641,5}},
	},	
	
};
storyList[400951] =
{

	TaskName = "VIP����(2��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "���VIP����ɻ�ô�������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҫ��ҵ�֧�֡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�Ҵ�����Ҹ�л���֧Ԯ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������</font>", --�������Ի�	
	HelpInfo = "(<a href='event:auction.DAuctionPanel'><u>ͨ��<font color='#3cff00'>��Ӹ���</font>��<font color='#ff00ff'>������</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4950},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{641,10}},
	},	
	
};
storyList[400952] =
{

	TaskName = "VIP����(3��)",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	--TaskGuide=1,						-- ��������
	--ClientCompleteAwards = 1 ,
	TaskInfo = "���VIP����ɻ�ô�������",		-- ��������
	AcceptInfo = "\t<font color='#e6dfcf' >������Ҫ��ҵ�֧�֡�</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >���һ��Ŭ����</font>", --��������Ի�
	SubmitInfo = "\t<font color='#e6dfcf' >�Ҵ�����Ҹ�л���֧Ԯ��</font>\n\n<font color='#f8ee73' ><b>��:</b></font><font color='#6cd763' >��������</font>", --�������Ի�	
	HelpInfo = "(<a href='event:auction.DAuctionPanel'><u>ͨ��<font color='#3cff00'>��Ӹ���</font>��<font color='#ff00ff'>������</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		completed={4951},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{641,20}},
	},	

};



storyList[400999] =
{

	TaskName = "���ͺ�����",		-- ��������
   	-- nocancel=1,						-- ����ȡ��
	NoTransfer = 1,					--���ܴ���
	TaskInfo = "�뽫��Ů���͵�������ң��·;ңԶ��������һ·����������ɹ��ʡ�",		-- ��������
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
		
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		  level = {35,999},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		
	},	
	AutoFindWay = {true,SubmitNPC = true},
};
--�����

storyList[600001] =
{

	TaskName = "��ɱ����",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��ɱԶ���ż�������",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		-- level = {40,45},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_121", 30 ,{519,31,125}},
		
	},
};
storyList[600002] =
{

	TaskName = "�ռ�����",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż������������ռ�Զ�ŷ�����Ƭ",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		-- level = {40,45},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_122", 10 ,{519,43,30}},
		
	},
};
storyList[600003] =
{

	TaskName = "�ռ���ҩ",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż��ɼ�ǧ����֥ҩ��",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		-- level = {40,45},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10008,20,{519,9,29,100034}}},
	},
};
storyList[600004] =
{

	TaskName = "�ռ�����¯",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż��ɼ�Զ����ʿ����������¯",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		-- level = {40,45},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10009,10,{519,58,59,100041}}},
	},
};
storyList[600006] =
{

	TaskName = "��ɱ����",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��ɱԶ���ż�������",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		-- level = {46,50},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_121", 30 ,{519,31,125}},
		
	},
};
storyList[600007] =
{

	TaskName = "�ռ�����",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż������������ռ�Զ�ŷ�����Ƭ",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		 -- level = {46,50},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_122", 10 ,{519,43,30}},
		
	},
};
storyList[600008] =
{

	TaskName = "�ռ���ҩ",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż��ɼ�ǧ����֥ҩ��",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		-- level = {46,50},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10008,20,{519,9,29,100034}}},
	},
};
storyList[600009] =
{

	TaskName = "�ռ�����¯",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż��ɼ�Զ����ʿ����������¯",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		 -- level = {46,50},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10009,10,{519,58,59,100041}}},
	},
};

storyList[600011] =
{

	TaskName = "��ɱ����",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��ɱԶ���ż�������",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		-- level = {51,55},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_121", 30 ,{519,31,125}},
		
	},
};
storyList[600012] =
{

	TaskName = "�ռ�����",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż������������ռ�Զ�ŷ�����Ƭ",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		-- level = {51,55},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_122", 10 ,{519,43,30}},
		
	},
};
storyList[600013] =
{

	TaskName = "�ռ���ҩ",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż��ɼ�ǧ����֥ҩ��",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		-- level = {51,55},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10008,20,{519,9,29,100034}}},
	},
};
storyList[600014] =
{

	TaskName = "�ռ�����¯",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż��ɼ�Զ����ʿ����������¯",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		-- level = {51,55},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10009,10,{519,58,59,100041}}},
	},
};
storyList[600016] =
{

	TaskName = "��ɱ����",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��ɱԶ���ż�������",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		-- level = {56,60},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_121", 30 ,{519,31,125}},
		
	},
};
storyList[600017] =
{

	TaskName = "�ռ�����",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż������������ռ�Զ�ŷ�����Ƭ",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		 -- level = {56,60},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_122", 10 ,{519,43,30}},
		
	},
};
storyList[600018] =
{

	TaskName = "�ռ���ҩ",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż��ɼ�ǧ����֥ҩ��",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		 -- level = {56,60},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10008,20,{519,9,29,100034}}},
	},
};
storyList[600019] =
{

	TaskName = "�ռ�����¯",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż��ɼ�Զ����ʿ����������¯",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		 -- level = {56,60},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10009,10,{519,58,59,100041}}},
	},
};

storyList[600021] =
{

	TaskName = "��ɱ����",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��ɱԶ���ż�������",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		 -- level = {61,65},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_121", 30 ,{519,31,125}},
		
	},
};
storyList[600022] =
{

	TaskName = "�ռ�����",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż������������ռ�Զ�ŷ�����Ƭ",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		 -- level = {61,65},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_122", 10 ,{519,43,30}},
		
	},
};
storyList[600023] =
{

	TaskName = "�ռ���ҩ",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż��ɼ�ǧ����֥ҩ��",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		 -- level = {61,65},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10008,20,{519,9,29,100034}}},
	},
};
storyList[600024] =
{

	TaskName = "�ռ�����¯",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż��ɼ�Զ����ʿ����������¯",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		 -- level = {61,65},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10009,10,{519,58,59,100041}}},
	},
};
storyList[600026] =
{

	TaskName = "��ɱ����",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��ɱԶ���ż�������",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		--	level = {66,100},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_121", 30 ,{519,31,125}},
		
	},
};
storyList[600027] =
{

	TaskName = "�ռ�����",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż������������ռ�Զ�ŷ�����Ƭ",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		-- level = {66,100},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		kill = { "M_122", 10 ,{519,43,30}},
		
	},
};
storyList[600028] =
{

	TaskName = "�ռ���ҩ",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż��ɼ�ǧ����֥ҩ��",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		 -- level = {66,100},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10008,20,{519,9,29,100034}}},
	},
};
storyList[600029] =
{

	TaskName = "�ռ�����¯",		-- ��������
	TaskGuide=1,						-- ��������
	TaskInfo = "��Զ���ż��ɼ�Զ����ʿ����������¯",		-- ��������
	NoTransfer = 1,						--���ܴ���
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>Զ���ż�ֻ��<font color='#3cff00'>�ʱ��</font>����</u></a>)",
	ClientAcceptEvent = {				-- �ͻ��˽��������¼�
	},	
	ClientSumitEvent = {				-- �ͻ����ύ�����¼�
	},	
	CleintAcceptCondition = 			-- �ͻ��˽�����������
	{
		 -- level = {66,100},
	},
	ClientCompleteCondition = 			-- �ͻ��������������
	{
		items = {{10009,10,{519,58,59,100041}}},
	},
};



--���߾��������Ļص�ִ��
storyEvent = {
--�������
--[1000002] = "SubmitNPC=37",
[1000132] = "Position2=1,36,169",
--��߸����
[1000005] = "SubmitNPC=155",
--������ʾ
[1000007] = "SubmitNPC=202",
[1000009] = "SubmitNPC=202",
[1000010] = "SubmitNPC=202",
[1000136] = "trans=3,90,175,9",
};
