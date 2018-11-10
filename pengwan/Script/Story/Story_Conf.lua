--[[
file:	Story_conf.lua
desc:	story config(S&C)
author:	chal1
update:	2011-12-01
version: 1.0.0

flynpc//飞行去找npc
flyPos
追加任务已用到编号：200084
强化
0: 武器
1：衣服
2：裤子
3：鞋子
4：项链
5：挂坠
6：手链
7：戒指

分性别加载: {女,男}
分职业加载:{将军,修仙,九黎}
分职业性别加载:{将军女,将军男,修仙女,修仙男,九黎女,九黎男}
]]--

talk = {}
talk.sex = function()
	return "{IF(Prop('sex')==1,'少侠','女侠')}"
end
talk.name = function()
	return "<font color='#f8ee73' >{Prop('myname')}</font>"
end


storyList = {}

------------首次进入游戏提示

storyList[100000] =
{

	TaskName = "英雄救美",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	AcceptInfo = "天地间杀机涌动，眼看大劫将至。你却于5年前<font color='#FFFF00' >穿越</font>至此，带来天机外的一线变数。命运之奇妙莫过于此，有多少人的命运被你所改变呢？", --接受任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {1,1},	-- 发送给后台接受任务
	--onClick = 1,	-- 后台会固定调用OnClickStory_storyid()
	
}
storyList[100001] =
{

	TaskName = "英雄救美",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,2},             --英雄救美
	TaskGuide=1,						-- 任务引导
	RS = {'DynamicSrc.swf'},
	TaskInfo = "带着冰封的魂魄去见姜子牙",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >徒弟，何事如此慌张？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >师傅，请救救妲己吧。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >此女的魂魄已被打散，你需要去收集飞散的残魄才能让她苏醒！ </font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我要去哪里找呢？</font>", --完成任务对话
	--HelpInfo = "",		帮助文字
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
		
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
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
		daji = 1 			显示   与妲己游戏一次      点击进入家园
		yaoqian =1        显示   在摇钱树收获一次    点击进入家园
		zhenyao =1          显示 完成一次镇妖塔 ，点击打开镇妖塔面板
		monsterList =111        显示 降魔录金刚3星过关(0/1)，点击打开降魔录面板
		kill = {1,3}		显示 将寒冰刺提升到3级   点击打开技能面板
		]]--
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {1,2},	-- 发送给后台接受任务
	--onClick = 1,	-- 后台会固定调用OnClickStory_storyid()
	----ClientCompleteAwards = 1 , 表示该任务的奖励品会显示在任务追踪面板
}
storyList[100002] =
{

	TaskName = "九转金丹",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,4},             --英雄救美
	TaskGuide=1,						-- 任务引导	
	
	RS = {'plot.swf'},		--预加载怪物或NPC资源
	TaskInfo = "找二师姐索取九转金丹",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >先去找你二师姐索要九转金丹修复魂魄，然后再做打算。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >马上就去。</font>", --接受任务对话
	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
		
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1001},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_004", 1 ,{3,88,142}},
	},
	AutoFindWay = { true, Position={3,88,142}},
	task = {1,3},	-- 发送给后台接受任务
};

storyList[100003] =
{

	TaskName = "教训顽猴",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,6},             --英雄救美
	TaskGuide=1,						-- 任务引导	
	TaskInfo = "帮二师姐教训顽猴\n按“Z”键可进行自动打怪",		-- 任务描述
	SubmitInfo = "\t<font color='#e6dfcf' >这些可恶的顽猴，又来偷丹药。 </font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >二师姐！</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
		
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1002},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_004", 1 ,{3,77,138}},
	},
	AutoFindWay = { true, Position={3,77,138}},
	task = {1,4},	-- 发送给后台接受任务
};

storyList[100004] =
{

	TaskName = "魂魄踪迹",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,8},             --英雄救美
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "在小师妹宁宁口中意外得知一枚残魂的去向",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >丹药在这里。对了，刚才我看一抹灵光飞过，好像是一些残魂。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >啊？莫非是？我赶紧去看看。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >是啊，我也看到一些残魂飞过。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是这个方向么？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件

	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
		
	},		
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1003},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {1,5},	-- 发送给后台接受任务
};

storyList[100005] =
{

	TaskName = "突破阻碍(一)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,10},             --英雄救美
	TaskGuide=1,						-- 任务引导
	TaskInfo = "突破拦路的妖魔，追寻残魂",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >不过小心，路上有一群妖魔拦路.</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >放心，难不倒我！</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >你怎么现在才来啊，先把药吃了吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢师姐。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1004},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_005", 1 ,{3,56,155}},
	},
	AutoFindWay = { true, Position={3,56,155}},
	task = {1,6},	-- 发送给后台接受任务
};

storyList[100006] =
{

	TaskName = "突破阻碍(二)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,12},             --英雄救美
	TaskGuide=1,						-- 任务引导
	TaskInfo = "突破拦路的妖魔，追寻残魂",		-- 任务描述
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1005},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_005", 2 ,{3,67,163}},
	},
	AutoFindWay = { true, Position={3,67,163}},
	task = {1,7},	-- 发送给后台接受任务
};
storyList[100007] =
{

	TaskName = "突破阻碍(三)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,14},             --英雄救美
	TaskGuide=1,						-- 任务引导
	NoTransfer = 1,			
	TaskInfo = "突破拦路的妖魔，追寻残魂",		-- 任务描述
	ClientAcceptEvent = {				-- 客户端接受任务事件
	
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1006},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_005", 2 ,{3,74,172}},
	},
	AutoFindWay = { true, Position={3,74,172}},
	task = {1,8},	-- 发送给后台接受任务
};
storyList[100008] =
{

	TaskName = "突破阻碍(四)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,16},             --英雄救美
	TaskGuide=1,						-- 任务引导
	TaskInfo = "突破拦路的妖魔，追寻残魂",		-- 任务描述
	--AcceptInfo = "\t<font color='#e6dfcf' >魂魄碎片之间都有感应，有两块西岐郊野，一块在乾元山。正好妲己的家人已在西岐，你可以先去见见他的家人。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我这就去！</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >你是来找这残缺魂魄的吧，我顺路拦了下来一个。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >啊，谢谢师姐。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1007},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_047", 2 ,{3,84,179}},
	},
	AutoFindWay = { true, Position={3,84,179}},
	task = {1,9},	-- 发送给后台接受任务
};

storyList[100009] =
{

	TaskName = "准备下山",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,18},             --英雄救美
	TaskGuide=1,						-- 任务引导
	TaskInfo = "其余的残魂飞向了西岐方向，准备下山追寻",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >另外，我看到其余的魂魄碎片好像飞往了西岐方向。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我这就出发。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >你要下山么？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是啊，请大师兄允许。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1008},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {1,10},	-- 发送给后台接受任务
};
storyList[100010] =
{

	TaskName = "前往西岐",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,20},             --英雄救美
	TaskGuide=1,						-- 任务引导
	TaskInfo = "为了追寻其余的魂魄，你决定前往西岐",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >路上请小心！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢大师兄！</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >来人止步！，请出示证件！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >呃，这里的保安大哥也好专业哦！</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1009},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {1,50},	-- 发送给后台接受任务
};
--新手村任务结束
storyList[100050] =
{

	TaskName = "打听消息",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,22},             --营救苏护
	TaskGuide=1,						-- 任务引导
	RS = {'H_06_0_01','H_06_0_02'},	--预加载怪物或NPC资源
	TaskInfo = "在西岐打听妲己父亲-冀州候苏护的消息",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >冀州候苏护大人？我一个小兵怎么知道。不过，最近苏府的侍女一直在郊野入口附近，你可以去问问她？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢大哥！</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >小姐失踪了，老爷也不回来，这可如何是好？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >发生什么事了？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1010},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {1,51},	-- 发送给后台接受任务
};
storyList[100051] =
{

	TaskName = "夺回坐骑",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,27},             --营救苏护
	TaskGuide=1,						-- 任务引导
	RS = {'plot_1000134.dat'},
	TaskInfo = "教训无赖，夺回苏护的坐骑。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >苏老爷将他的坐骑寄放在客栈就去找小姐了，但一群无赖霸占了客栈，我都不能去照顾它了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我帮你赶走他们！</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >谢谢你了，还有一事也想请少侠帮忙！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >请说。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1050},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_095", 2 ,{1,24,156}},
	},
	AutoFindWay = { true, Position={1,24,156}},
	task = {1,54},	-- 发送给后台接受任务
};

storyList[100054] =
{

	TaskName = "营救苏护",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,30},             --营救苏护
	TaskGuide=1,						-- 任务引导
	RS = {'N_2028_0_01','N_2028_0_04','N_2005_0_01','N_2005_0_02','N_2005_0_04','N_2005_0_10','openUI.swf'},	--预加载怪物或NPC资源
	
	TaskInfo = "拯救被邪灵附身的苏护",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >老爷去西岐郊野寻找小姐时失踪了，我将老爷的坐骑借你，请少侠去找找老爷吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >义不容辞，立刻出发。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >多谢少侠救回了苏护大人，我已派人护送他回府休息。大人命我送少侠坐骑一匹作为谢礼。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大人客气了！</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1051},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_097", 1,{1,36,169,1},"妲己魂魄"},
	},
	--AutoFindWay = { true,  Position2={1,36,169}},
	task = {1,58},	-- 发送给后台接受任务
};

storyList[100058] =
{

	TaskName = "武成王",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,36},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	RS = {'H_01_0_01','H_01_0_02','plot_1000002.dat'},
	TaskInfo = "武成王召见，去见见他！",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >刚才武成王派人来找你，先去见见他吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哦，我这就去。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >英雄果然仪表不凡，我周国正在招贤纳士，"..talk.name().."可有兴趣加入我国？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >谢谢，但我要先问问师傅。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1054},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		horselevel = 3,
	},
	--AutoFindWay = { true, SubmitNPC = true},
	task = {1,60},	-- 发送给后台接受任务
};

--修改剧情
storyList[100060] =
{

	TaskName = "回报师尊",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,38},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "周文王想招募自己，但要先问过师傅姜子牙。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你师傅姜子牙也在我朝为官，他应该会同意的。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >请示师傅后，再做决定。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >天下大乱，以你目前的实力还不足以救民于水火之中啊。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >那该如何是好？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1058},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {2,33},	-- 发送给后台接受任务
};

storyList[200033] =
{

	TaskName = "提升技能",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,39},             --营救苏护
	TaskGuide=1,						-- 任务引导
	RS = {{'N_9031_0_10','N_9030_0_10','N_9033_0_10','N_9032_0_10','N_9035_0_10','N_9034_0_10'}},
	TaskInfo = "学习第二个技能并且提升到1级",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >等级提升后可以获得技能点，分配技能点后可以学习更多的技能。 </font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我知道了。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >怎么样？有没有觉得自己变厉害了！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >但还是不够！</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1060},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		skill = {2,1},
	},
	--AutoFindWay = { true, SubmitNPC = true},
	task = {2,1},	-- 发送给后台接受任务
};

storyList[200001] =
{

	TaskName = "学艺",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,40},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	
	
	TaskInfo = "向太乙真人请教变强的方法。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >我师兄太乙真人此时在乾元山，我送你去向他学习高深的法术吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢师傅。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >想向我学习强力的技能，需要通过我的考验才行。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >师叔请吩咐？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		"PlayerTip(45)"
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2033},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	},
	--AutoFindWay = { true, SubmitNPC = true},
	task = {2,2},	-- 发送给后台接受任务
};

storyList[200002] =
{

	TaskName = "灵猴",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,46},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	RS = {{'N_9025_0_02','N_9024_0_02','N_9027_0_02','N_9026_0_02','N_9029_0_02','N_9028_0_02'}},
	TaskInfo = "击杀3只灵猴，收集足够的灵猴血。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >那你就先去杀三只灵猴吧，收集它们的血，然后交给你天星子师兄。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >领命。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >这么快就回来，有收集齐吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >师兄请过目。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2001},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_028", 3 ,{7,40,35}},
	},
	AutoFindWay = { true,  Position={7,40,35}},
	task = {2,3},	-- 发送给后台接受任务
};
storyList[200003] =
{

	TaskName = "灵鹿",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,48},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	RS = {'plot_1000008.dat'},
	TaskInfo = "击杀3只灵鹿，收集足够的鹿茸。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >做的不错，青松居士想要一些鹿茸，你去帮他一下吧！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >领命。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >哦，真是上好的鹿茸啊，我只要一部分就可以了，其他的你自己收好！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >知道了。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2002},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_029",3 ,{7,33,58}},
	},
	AutoFindWay = { true,  Position={7,33,58}},
	task = {2,12},	-- 发送给后台接受任务
};

storyList[200012] =
{

	TaskName = "镇魂冰莲",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,50},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "向金霞童子询问如何找到镇魂冰莲。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >刚才真人传话来说需要一株镇魂冰莲，你到瀑布边金霞童子那里问问。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我这就去。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >镇魂冰莲？我知道哪里有哦。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >快告诉我。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2003},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		--items = {{10005,1,{7,43,95,100026}}},
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {2,4},	-- 发送给后台接受任务
};

storyList[200004] =
{

	TaskName = "胆量考验",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,52},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "跳入湖中，找到镇魂冰莲。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >瀑布下的湖中就有，你跳下去就可以看到了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >啊，跳崖，这难度有点高了吧。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >真是的，突然跳下来吓了我一跳。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >请问一下知道镇魂冰莲吗？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2012},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		jump = {7,39,68,1}

	},
	AutoFindWay = {true,Position2={7,39,68,1}},
	task = {2,32},	-- 发送给后台接受任务
};

storyList[200032] =
{

	TaskName = "采集冰莲",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,54},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	
	RS = {{'N_9901_0_01','N_9902_0_01','N_9903_0_01'},'N_9997_0_01'},
	TaskInfo = "采集一株镇魂冰莲。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >镇魂冰莲？那朵大莲花就是了，莲花你可以拿走，但莲子记得给我。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >将莲子给我吧，我要培育新的莲花。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >全都给你。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2004},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10005,1,{7,43,95,100026}}},
	},
	AutoFindWay = { true,   Collection={7,43,95,100026}},
	task = {2,5},	-- 发送给后台接受任务
};

storyList[200005] =
{

	TaskName = "神之觉醒",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,56},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "完成考验，太乙真人教授觉醒绝技。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >太乙真人让你拿到莲花就赶快回去。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我这就回去。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >你收集的三样物品是学习绝技的必要道具，现在我就传你绝技——神之觉醒。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢师叔。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		"PlayerTip(45)"
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2032},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	--AutoFindWay = { true, SubmitNPC = true},
	task = {2,11},	-- 发送给后台接受任务
};

storyList[200011] =
{

	TaskName = "师叔训话",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,58},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	RS = {'N_2038_0_01','N_2039_0_01','N_2013_0_99'},
	TaskInfo = "太乙真人向你交代觉醒技能的注意事项。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >觉醒技能要多加使用，才能得心应手，发挥最大的威力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >知道了，师叔。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >你已经学会了新的技能，可敢去金光洞一层，消灭那里的千年狼妖，拿回它的内丹！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >有何不敢。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2005},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},

	AutoFindWay = { true, SubmitNPC = true},
	task = {2,13},	-- 发送给后台接受任务
};
storyList[200013] =
{

	TaskName = "金光洞",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,60},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	RS = {'N_2013_0_01'},
	TaskInfo = "向守洞童子请教进入金光洞的方法。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >好胆色，去找守洞童子吧，他会告诉你进入金光洞的方法。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我这就去。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >想进入金光洞？占领那里的狼妖可是很厉害的哦。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >在厉害我也会把它揍趴下。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		"PlayerTip(46)"
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2011},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},

	--AutoFindWay = { true, SubmitNPC = true},
	task = {2,6},	-- 发送给后台接受任务
};


storyList[200006] =
{

	TaskName = "狼妖王",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,62},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "消灭金光洞1层的一只狼妖王，取得它的内丹，夺回魂魄碎片。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >之前听说，狼妖得到了一个女子魂魄碎片，想要炼化为傀儡。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >女子魂魄？难道是妲己的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >好好好，果然没有辜负我的期望。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >还差一个就可救回妲己了。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2013},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "B_032", 1 ,{7,6,19,1},"妲己魂魄"},
	},

	AutoFindWay = { true,   Position2={7,6,19}},
	task = {2,7},	-- 发送给后台接受任务
};


storyList[200007] =
{

	TaskName = "前往郊野",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,64},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	RS = {'N_2042_0_01'},
	TaskInfo = "万事具备，出发前往西岐郊野",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >以你现在的实力，前往西岐郊野完全可以应付了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >师叔再见。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >救命啊，谁来救救我！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >怎么回事？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		"PlayerTip(43)"
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2006},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	},
	--AutoFindWay = { true, SubmitNPC = true},
	task = {1,100},	-- 发送给后台接受任务
};

--西岐郊野任务开始
storyList[100100] =
{

	TaskName = "清除恶鬼",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,67},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "消灭郊野的伤人恶鬼\n按“Z”键可进行自动打怪",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >一群恶鬼在后面，我好害怕！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >交给我了。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >你是何人？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >这里妖物横行，你为何还在这里？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2007},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		kill = { "M_009", 4 ,{6,29,135}},
	},
	AutoFindWay = { true, Position={6,29,135}},
	task = {1,99},	-- 发送给后台接受任务
};

storyList[100099] =
{

	TaskName = "拯救村长",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,70},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "找到老村长，带他到安全的地方去。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >老村长摔断了腿，我需要找到接骨草才能治好他。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >这里太危险，我帮你去吧。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >年轻人快离开这里吧，这里已经不适合再住人了！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大爷，我先送你离开吧。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1100},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10007,1,{6,64,107,100011}}},
	},
	AutoFindWay = {true,Collection={6,64,107,100011}},
	task = {1,101},	-- 发送给后台接受任务
};
storyList[100101] =
{

	TaskName = "清除怨灵",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,74},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "消灭游荡在村落的怨灵",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >这里是我的家乡，我死也不会离开，我要和这些妖物同归于尽！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大爷放心，我正是为除妖而来，这里交给我了。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >娘，你在哪里啊？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大哥怎么了？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1099},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		kill = { "M_010", 4 ,{6,44,97}},
	},
	AutoFindWay = { true, Position={6,44,97}},
	task = {1,98},	-- 发送给后台接受任务
};

storyList[100098] =
{

	TaskName = "寻人",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,77},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	RS = {'N_2031_0_01'},
	TaskInfo = "在郊野找到走失的刘大娘。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >我娘在逃离时和我走散了，这里这么多妖物，我担心她老人家啊。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >你先到西岐城去，我帮你找人。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >唉，本来美好的家园，被这些妖物破坏的不成样子了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大娘，村里妖物已被我驱除，您儿子在前面等你回家。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1101},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {1,102},	-- 发送给后台接受任务
};

storyList[100102] =
{

	TaskName = "无名侠士",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,82},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "刘大娘说有一个无名侠客去追踪魔物的行踪",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >太感谢了。对了，刚才有个小伙子说要去寻找魔物的来源，我真替他担心。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哦？还有这种热心侠士，我去支援他。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >好厉害，一下就把这些怪物打的落花流水。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' > 客气，你也不差啊。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1098},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		kill = { "M_011", 4 ,{6,59,31}},
	},
	AutoFindWay = { true, Position={6,59,31}},
	task = {1,103},	-- 发送给后台接受任务
};
storyList[100103] =
{

	TaskName = "残破古碑",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,84},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	RS = {'N_2042_0_01','N_2042_0_04','N_2042_0_10'},
	TaskInfo = "无名侠士说怪物都是从一个残破的古碑下冒出来的，去调查一下",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >我学艺不精，已经无力前进了，不过我发现怪物来源都是从一个古碑下冒出来的，后面就拜托你了！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >放心，接下来交给我就可以了。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >这古碑是为镇压孤魂野鬼修建的，但古碑不久前被破坏了，所以怨灵才纷纷出现。 </font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >除魔卫道乃我辈本职，我去看看。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1102},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		items = {{10003,1,{6,32,63,100010}}},
	},
	AutoFindWay = { true, Collection={6,32,63,100010}},
	task = {2,14},	-- 发送给后台接受任务
};
--插入任务
storyList[200014] =
{

	TaskName = "武器强化",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,88},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	RS = {'diceEffect.swf'},	
	TaskInfo = "将武器强化到3级",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >稍等，之后可能还要对付更强的敌人，你先强化一下武器为好！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >也好。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >希望你能将古碑被破坏的事情调查清楚。 </font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >你有什么线索吗？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1103},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		equiplevel = {0,3},
	},
	--AutoFindWay = { true, Collection={6,32,63,100010}},
	task = {1,104},	-- 发送给后台接受任务
};


storyList[100104] =
{

	TaskName = "乱葬岗",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,90},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	
	RS = {'N_2062_0_01','N_2062_0_02'},	--预加载怪物或NPC资源
	TaskInfo = "原来郊野深处，是乱葬岗，积蓄了大量冤魂",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >出现的冤魂都围绕在乱葬岗中心的巨树附近，像是在守护着什么？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我前去打探一番。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >吼...... </font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >这里的冤魂好多，感觉有点独木难支啊!</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2014},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		kill = { "M_012", 5 ,{6,10,48}},
	},
	AutoFindWay = { true,  Position={6,10,48}},
	task = {1,115},	-- 发送给后台接受任务
};
storyList[100115] =
{

	TaskName = "师姐相助",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,92},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "将家将修行到3阶，协助你一起作战。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >吼.......</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >待我和师姐一起来解决你们。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >活人的味道，可是没有魂魄好，可惜没有吃到！ </font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >魂魄？说在哪里看见的，不说我一雷劈死你！</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1104},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{	
		herolevel = 3,
	},
	--AutoFindWay = { true,  Position={6,10,48}},
	task = {1,105},	-- 发送给后台接受任务
};
storyList[100105] =
{

	TaskName = "百鬼妖树",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,94},             --妖树之迷
	TaskGuide=1,						-- 任务引导
	
	RS = {'N_2003_0_01','N_2003_0_04','N_2003_0_10'},	--预加载怪物或NPC资源
	TaskInfo = "消灭百鬼妖树上的妖魔头目",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >上仙息怒，我刚得到魂魄，就被头目抢走了，其他的我什么都不知道。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >可恶，事情果然不简单。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."，多谢你寻回妲己的魂魄，请复活她吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >待我做法。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1115},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		kill = { "B_015", 1 ,{6,41,13,1},"妲己魂魄"},
	},
	AutoFindWay = { true,  Position2 ={6,41,13}},
	task = {1,56},	-- 发送给后台接受任务
};

storyList[100056] =
{

	TaskName = "父女重逢",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,96},             --营救苏护
	TaskGuide=1,						-- 任务引导
	RS = {'N_1033_0_01','N_1120_0_01'},	--预加载怪物或NPC资源
	TaskInfo = "苏护与苏妲己父女终于重逢",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >多谢"..talk.name().."，让我父女重逢，但是为小女的安全，我愿送您一座庄园，请您照顾她。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >真是太客气了！</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >此庄园除了安置小女以外，还有一个重要的功能。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哦？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1105},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		daji = 3,
	},
	
	task = {1,57},	-- 发送给后台接受任务
};

storyList[100057] =
{

	TaskName = "仙家果园",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskTrack = {1004,5,100},             --营救苏护
	TaskGuide=1,						-- 任务引导
	
	
	TaskInfo = "果园种植可以获得铜钱和灵气",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >那就是庄园自带的果园，果园中可以种植仙家植物，生长出铜钱和灵气。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哇，好厉害，果然是好宝贝。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >哈哈，"..talk.name().."，这次你又立下大功了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >除魔卫道，本是我辈职责。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1056},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true, SubmitNPC = true},
	task = {1,106},	-- 发送给后台接受任务
};
storyList[100106] =
{

	TaskName = "再见武成王",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,1},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "武成王有事找你，快去见见他吧。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >武成王有令，让你回来就立即去见他。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的，我马上就去。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."，感谢你解决了郊野的祸患，让我们后顾无忧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >这是我辈应做的事。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1057},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,107},	-- 发送给后台接受任务
};
storyList[100107] =
{

	TaskName = "拜见师傅",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,2},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	RS = {'H_21_0_01'},
	TaskInfo = "再次见到师傅姜子牙",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >如何？你可愿意为我王效力，我王求贤若渴啊。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我要问过师傅才能决定。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >徒儿，下山历练了一番，感觉如何？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >妖物肆虐，百姓困苦，乱象已显，治安不好啊。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1106},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,108},	-- 发送给后台接受任务
};
storyList[100108] =
{

	TaskName = "加入西岐",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,3},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "跟随师傅加入西岐周朝",		-- 任务描述
	RS = {'H_21_0_01'},	--预加载怪物或NPC资源
	AcceptInfo = "\t<font color='#e6dfcf' >西岐的文王乃一代人杰，为师决定辅助周王推翻商纣暴政，你可愿意助我一臂之力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >当然。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."，你终于同意了，我盼先生犹如久旱逢甘霖。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >凤鸣岐山，民心所向。修行之人也要出世应劫，愿效全力。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1107},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,109},	-- 发送给后台接受任务
};
storyList[100109] =
{

	TaskName = "休憩几日",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,5},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "一直疲于奔波，终于事情告一段落，可以休憩几日",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >太好了，本来一要事要托付先生，不过看先生疲容满面，不如先休息几日。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >也好，将军若有吩咐，请直接传话给苏护府即可。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >关关雎鸠，在河之洲，窈窕淑女，君子好逑。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >此处真美，春天到了......</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1108},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		
	},
	AutoFindWay = { true,  flynpc = true},
	task = {1,110},	-- 发送给后台接受任务
};
storyList[100110] =
{

	TaskName = "红娘",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,7},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "与红娘聊一聊",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >千里姻缘一线牵，我的姻缘又在哪里呢？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >缘分奇妙无比，也许你命中之人就在你的身边。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >这位"..talk.sex().."红光满面，看来姻缘将近啊。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >姻缘将近，莫非是......</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1109},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,112},	-- 发送给后台接受任务
};
storyList[100112] =
{

	TaskName = "月老",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,9},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "与月老聊一聊",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >看你为难的样子，可需要我帮你牵线？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哈哈，多谢了，我将来一定会来找你。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >愿天下有情人终成眷属！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >不愧为可亲可敬的月下老人。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1110},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,113},	-- 发送给后台接受任务
};

storyList[100113] =
{

	TaskName = "新的任务",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,13},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "接受到新的任务，准备再次出发",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >城防武官正在四处找你！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我马上就去！</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."，来的正好，王上有任务安排给你。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大人请讲。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1112},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,114},	-- 发送给后台接受任务
};

storyList[100114] =
{

	TaskName = "前往陈塘关",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,15},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "周文王安排你前往前往陈塘关说服总兵李靖",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >东海陈塘关总兵，名叫李靖，此人有大才，王上希望你前去说服他归顺我国。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >没问题，我立刻出发。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >稍等，陈塘关有新的情报送来。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >什么情报。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1113},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {2,17},	-- 发送给后台接受任务
};

storyList[200017] =
{

	TaskName = "家将修行",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,18},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "将家将修行到5阶，并出战。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >培养你的家将，提升到5阶再去陈塘关吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >请问你要找谁？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >你好，我是专程来拜访总兵李靖大人的。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1114},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		herolevel = 5 
	},
	--AutoFindWay = { true,  SubmitNPC = true},
	
	task = {1,150},	-- 发送给后台接受任务
};

--前往陈塘关任务
storyList[100150] =
{

	TaskName = "阴影笼罩",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,19},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	RS = {'N_2025_0_01','N_2025_0_02','N_2025_0_03','N_2025_0_04','N_2025_0_10'},
	TaskInfo = "你发现陈塘关笼罩在一层阴影当中",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >我家大人出去巡查了，不在府中。你可以等会再来。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >真是不巧，也好，我就去随便转转。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >唉，现在的生意不好做啊！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >老板这是怎么了？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2017},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{	
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,151},	-- 发送给后台接受任务
};
storyList[100151] =
{

	TaskName = "百鬼夜行",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,20},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	--TIPtype = 3,
	
	TaskInfo = "消灭酒店上方的邪灵",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你是修行者么？我酒店上面有个棺材铺，最近总是传来可怕的声音，麻烦你帮我去看看。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >小事一桩。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >谢谢你了，搞不好陈塘关的瘟疫就是这些怪物散布出去的。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >什么瘟疫？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1150},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		kill = { "M_016", 5 ,{8,16,17}},
	},
	AutoFindWay = { true,  Position={8,16,17}},
	task = {1,152},	-- 发送给后台接受任务
};
storyList[100152] =
{

	TaskName = "可怕瘟疫",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,22},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	TIPtype = 3,
	TaskInfo = "酒店老板告诉你，陈塘关最近出现了可怕的瘟疫",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >陈塘关最近出现了可怕的瘟疫，死了不少人，城防队长正头疼着呢。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >竟有此事？我去看看。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >陈塘关的瘟疫是最近出现的，来势汹汹，很难医治。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >莫非这瘟疫不是自然出现的？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1151},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		
	},
	--AutoFindWay = { true,  SubmitNPC = true},
	task = {1,153},	-- 发送给后台接受任务
};
storyList[100153] =
{

	TaskName = "寻找药方",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,23},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	TIPtype = 3,
	TaskInfo = "去向药店老板询问是否有医治瘟疫的药方",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >麻烦您帮我去找药店老板，看他是否研究出医治瘟疫的药方。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好！</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >这种瘟疫不同寻常，药物竟然完全无效，奇怪。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >那可如何是好？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1152},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		
	},
	--AutoFindWay = { true,  SubmitNPC = true},
	task = {1,154},	-- 发送给后台接受任务
};
storyList[100154] =
{

	TaskName = "玄慈大师",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,24},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	TIPtype = 3,
	TaskInfo = "向玄慈大师求助",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >麻烦你去找玄慈大师，大师不但医术高明，同时法力高深，定能找出瘟疫原因！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >竟有如此高人？我自当去拜访。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >看施主法力高深，应该也觉察到这场瘟疫的不同寻常吧？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大师果然高明，我正是为这瘟疫而来。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1153},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		
	},
	--AutoFindWay = { true,  SubmitNPC = true},
	task = {1,155},	-- 发送给后台接受任务
};
storyList[100155] =
{

	TaskName = "邪灵枯骨",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,25},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	--TIPtype = 3,
	TaskInfo = "取来邪灵的枯骨，交给玄慈大师",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >最近陈塘关中冒出许多怨灵，麻烦你取些样本来，我怀疑瘟疫和怨灵有关。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >果然，瘟疫中带有怨灵特有的一种尸毒。不过，既然知道原因就好办了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大师果然高明。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1154},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
		kill = { "M_017", 5 ,{8,9,46},"怨灵枯骨"},
	},
	AutoFindWay = { true,  Position={8,9,46}},
	task = {1,156},	-- 发送给后台接受任务
};
storyList[100156] =
{

	TaskName = "清除瘟疫",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,27},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	TIPtype = 3,
	TaskInfo = "告诉城防队长清除瘟疫之法",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你将这些符水带给城防队长，先用符水拔除尸毒，然后服药，定会药到病除。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >太好了，我这就去。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >太好了，真是感谢英雄。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >不客气。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1155},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
	
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,157},	-- 发送给后台接受任务
};

storyList[100157] =
{

	TaskName = "瘟疫由来",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,30},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "城防队长怀疑瘟疫的爆发与镇妖塔有关。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >瘟疫的爆发应该与城中的镇妖塔有关。镇妖塔下镇压了很多妖魔，李靖大人此刻正在哪里查看。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >镇妖塔？</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >你是何人，难道与镇妖塔妖气泄露有关？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >李大人，我乃西岐使者，今日见你是想请你加入西岐。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1156},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,158},	-- 发送给后台接受任务
};

storyList[100158] =
{

	TaskName = "神创天下",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,33},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "挑战“神创天下”第一关，向李靖展现一下实力。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >想让我加入，你必须表现出你的实力来。你去挑战神创天下第一关给我看看。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >没有问题。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >不错，西周果然有实力。但是最近镇妖塔妖气泄漏，导致瘟疫。东海海族也突然上岸伤人，让我怎能离开啊。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >也罢，我就帮你把海族之事一起处理了吧。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1157},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		monsterList = 1,
	},
	--AutoFindWay = { true,  SubmitNPC = true},
	task = {2,18},	-- 发送给后台接受任务
};

storyList[200018] =
{

	TaskName = "装备强化",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	
	TaskGuide=1,						-- 任务引导

	TaskInfo = "将防具强化到5级，并装备。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >之后应该还有更难的战斗，我建议你将防具强化到5级，增加能力！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >可恶，最近这些海族是怎么了？如此狂暴。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >怎么了？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1158},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		equiplevel = {1,5},
	},
	--AutoFindWay = { true,   SubmitNPC = true},
	task = {1,159},	-- 发送给后台接受任务
};
storyList[100159] =
{

	TaskName = "教训虾兵",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,36},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	RS = {'N_2066_0_01','N_2066_0_02','N_1025_0_01'},	--预加载怪物或NPC资源
	TaskInfo = "帮助渔民教训虾兵",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >最近海族在海里兴风作浪不说，还上岸伤人，让我们都没法过活了。麻烦英雄帮我们教训一下这些海族。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >小问题。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >我乃总兵李靖之子，哪吒，你是何人？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哇，原来你就是哪吒。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2018},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_018", 8 ,{8,64,106}},
	},
	AutoFindWay = { true,  Position={8,64,106}},
	task = {1,160},	-- 发送给后台接受任务
};
storyList[100160] =
{

	TaskName = "海族之患",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,39},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "李靖的三子-哪吒，也在为海族之患担忧",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >对了，你帮我去打听一下。我看码头的居民都一脸愁容，但是又觉得我年纪小，不肯告诉我！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的，我本来就为此事而来。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >我的女儿啊，我那可怜的丹妹儿啊~ </font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大嫂，怎么了？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1159},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,  SubmitNPC = true},
	task = {1,161},	-- 发送给后台接受任务
};
storyList[100161] =
{

	TaskName = "百姓遭难",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,42},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "狂暴的海族不但上岸伤人，还掳走了不少童男童女作为祭品",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >我们家的丹妹，被海族抓走了，说是作为龙王的祭品，呜呜！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >岂有此理，我这就找船入海。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >唉，无法出海，让人怎么活啊！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >老板，借船一用，我要出海救人。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1160},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		horselevel = 4,
	},
	--AutoFindWay = { true,  SubmitNPC = true},
	task = {1,162},	-- 发送给后台接受任务
};
storyList[100162] =
{

	TaskName = "驱逐蟹将",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,45},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "驱逐码头的蟹将",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >我的船在码头，已经被蟹将霸占了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >那我先去赶走蟹将。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >啊，我可怜的老伙计啊，这船都被海族弄破了，没法出海。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >那要怎么办？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1161},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_019", 8 ,{8,39,110}},
	},
	AutoFindWay = { true,   Position={8,39,110}},
	task = {1,163},	-- 发送给后台接受任务
};
storyList[100163] =
{

	TaskName = "木工肖师傅",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,48},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "找木工肖师傅去修理船只",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你去找木工肖师傅吧，只有他能修船！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >嗯。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >要修船啊，看你不像是在海边讨生活的啊？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >事情是这样的......</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1162},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,164},	-- 发送给后台接受任务
};
storyList[100164] =
{

	TaskName = "收集木材",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,51},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "收集木材来修理船",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >原来如此，我就免费帮你修理吧。帮把手，取些木材来，我们尽快修好。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >好了，大功告成！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >修好了吗？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1163},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10004,1,{8,41,83,100020}}},
	},
	AutoFindWay = { true,   Collection={8,41,83,100020}},
	task = {1,165},	-- 发送给后台接受任务
};
storyList[100165] =
{

	TaskName = "出海准备",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,54},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "船已经修好，准备出海讨伐海族",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >本人出马，一个顶俩！只要你不超速驾驶，船绝对不会散架的。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >......</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >哇，船已经修好了，不过，现在的风浪太大，恐怕走不了多远。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >这可怎么办。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1164},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,166},	-- 发送给后台接受任务
};
storyList[100166] =
{

	TaskName = "大婶的委托",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,57},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "马大婶再次求你救出所有被海族抓走的小孩",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你先想想办法吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >嗯，我先想想对策。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >英雄，我们码头一共有好几个小孩都被抓走了，求求英雄救救他们。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >可是现在风浪太大，无法出海。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1165},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,167},	-- 发送给后台接受任务
};
storyList[100167] =
{

	TaskName = "哪吒的法宝",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,60},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	RS = {'yinyan2.swf'},
	TaskInfo = "据说哪吒的混天绫可以平息风浪，方便入海",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >对了，我听说总兵之子，哪吒有件法宝可以晃动海水！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >对啊，哪吒的法宝不少，我可以找他帮忙。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >竟有此事，气煞我也！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >你有办法平息风浪么？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1166},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,168},	-- 发送给后台接受任务
};
storyList[100168] =
{

	TaskName = "巡海夜叉",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,70},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	RS = {'N_2017_0_01','N_2017_0_02','N_2017_0_03','N_2017_0_04','N_2017_0_10'},	--预加载怪物或NPC资源
	TaskInfo = "消灭海族的先锋大将-巡海夜叉",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >我有法宝混天绫，倒是可以一定程度控制风浪，足以行船，我们这就出发。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >出发吧！</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >可恶，巡海夜叉也只是喽啰而已，必须要找到龙王三太子的位置才能救出孩子们。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是啊！</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1167},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "B_022", 1 ,{8,44,138,1}},
	},
	AutoFindWay = { true,   Position2={8,44,138}},
	task = {1,169},	-- 发送给后台接受任务
};
storyList[100169] =
{

	TaskName = "打听位置",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,73},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "询问渔民，说不定知道龙王三太子的位置",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >海边的渔民对海域比较熟悉，说不定知道龙王三太子的位置，不如你去打听一下！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好！</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >龙王三太子？据说他住在东海逍遥阁。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >那你知道怎么去吗？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1168},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,170},	-- 发送给后台接受任务
};
storyList[100170] =
{

	TaskName = "搜寻海图",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,76},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "渔民告诉你，需要海图才能找到东海逍遥阁",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >海上不比陆地，就算知道大概海域，没有海图，也无法达到！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >原来如此！</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >知道大概地方就行，海图可以找海族要，不给就打到它们给为止。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >.......</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1169},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,171},	-- 发送给后台接受任务
};
storyList[100171] =
{

	TaskName = "海图上卷",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,79},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "找虾兵收集海图上卷",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >先去找那些虾兵，狠狠的教训它们，必会交出海图。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >没问题！</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >嗯嗯，这些只是海图上卷啊。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >下卷在什么地方？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1170},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_018", 1 ,{8,70,112},"海图上卷碎片"},
	},
	AutoFindWay = { true,  Position={8,70,112}},
	task = {1,172},	-- 发送给后台接受任务
};
storyList[100172] =
{

	TaskName = "海图下卷",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,82},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "找蟹将收集海图下卷",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >虾兵蟹将嘛，下卷肯定在蟹将手中。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我这就去找蟹将！</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >嗯嗯，下卷海图也到手了，我来拼合一下。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >怎么样？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1171},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_019", 1 ,{8,36,120},"海图下卷碎片"},
	},
	AutoFindWay = { true,  Position={8,36,120}},
	task = {1,173},	-- 发送给后台接受任务
};
storyList[100173] =
{

	TaskName = "激战逍遥阁",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,90},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	RS = {'N_2019_0_01','N_2019_0_02','N_2019_0_03','N_2019_0_04','N_2019_0_10'},	--预加载怪物或NPC资源
	TaskInfo = "冲入东海逍遥阁，击败龙王三太子",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >对了，已经找到路线，马上出发，前往东海逍遥阁！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >走吧！</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >哈哈，这条小龙的筋不错，可以给我爹爹做条腰带！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >扒皮抽筋，太狠了，伤不起啊！</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1172},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "B_027", 1 ,{8,44,138,1}},
	},
	AutoFindWay = { true,  Position2={8,44,138}},
	task = {1,175},	-- 发送给后台接受任务
};

storyList[100175] =
{

	TaskName = "消除海患",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,96},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "告诉村民，海患已经被消除",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >我去将小孩送回他们父母哪里，你去帮我感谢一下借船的海商。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >听说小孩们都已经救回来了？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多亏有你的船，要不然我什么都做不了。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1173},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,176},	-- 发送给后台接受任务
};
storyList[100176] =
{

	TaskName = "阴云密布",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,97},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "陈塘关突然阴云密布，不详的阴影逼近",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >不客气，一条船而已，这我应做的。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哈哈！</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >少侠，你在这里啊，我们总兵正在找你。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >什么事情？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1175},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,177},	-- 发送给后台接受任务
};
storyList[100177] =
{

	TaskName = "海族入侵",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,98},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "龙王为报三太子仇，率领全体海族入侵陈塘关",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >陈塘关阴云密布，巨浪滔天，好像是龙王亲自来了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >什么？</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."啊，你为何跟我儿一起犯糊涂，竟然杀了龙王三太子。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >当时情况危急，我们也不得不......</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1176},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,178},	-- 发送给后台接受任务
};
storyList[100178] =
{

	TaskName = "事态紧急",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,99},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	RS = {'N_1038_0_01','N_2020_0_01'},	--预加载怪物或NPC资源
	TaskInfo = "龙王准备水淹陈塘关，事态已经到了最危机的时刻",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >哪吒一人跑去应对龙王了，你速去帮他！唉，这可如何是好？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >糟了，以哪吒那种脾气，必会出事，我这就去。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >老泥鳅听好了，你儿子为非作歹，祸害陈塘，是我手刃了他，要算账找我。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哪吒等等！</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1177},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,179},	-- 发送给后台接受任务
};
storyList[100179] =
{

	TaskName = "哪吒自杀",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskTrack = {2052,4,100},             --哪吒闹海
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "为了保护陈塘关，哪吒不得不自杀，换来龙王的退兵",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >一人做事一人当，我哪吒今日在此一命抵一命就是了，老泥鳅不得祸害陈塘关。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >不要啊！</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."，无需自责，是我儿命苦，怪不得他人!唉......</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >此事我亦有责任，我必定要找到复活哪吒的办法！</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1178},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,180},	-- 发送给后台接受任务
};
storyList[100180] =
{

	TaskName = "回城求救",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	TIPtype = 3,
	TaskInfo = "哪吒自杀，你决定回西岐寻求救他之法",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >真的？若你真能让哪吒死而复生，我李靖立刻抛下一切，随你归顺西周！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好，一言为定！</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >徒儿，此去陈塘关，是否顺利？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >一言难尽啊......</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1179},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,258},	-- 发送给后台接受任务
};

storyList[100258] =
{

	TaskName = "挑战排位赛",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "参加一次排位赛。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你想知道自己与其他修行者的差距吗？参加一次排位赛看看吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好，我也想见识一下各路英雄。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >现在你知道差距了吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >天下之大，果然能人辈出啊。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1180},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		homebattle =1--排位赛
	},
	--AutoFindWay = { true,  SubmitNPC = true},
	
	task = {1,181},	-- 发送给后台接受任务
};


storyList[100181] =
{

	TaskName = "铜钱副本",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导

	TaskInfo = "完成一次铜钱副本",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >原来如此，告诉你复活方法前，你还需要将装备继续强化。是不是发现铜钱不足了，有一处尽是不义之财，不妨取之。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >汗，太直接了吧。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >收益如何？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >额，好多不义之财。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1258},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		tfb = 1
	},
	AutoFindWay = {true,Collection={1,58,66,59}},
	task = {1,256},	-- 发送给后台接受任务
};

storyList[100256] =
{

	TaskName = "点石成金",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "点石成金1次。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >对了还有一个方法可以获得铜钱，就是法术——点石成金，我现在就传你。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢师傅。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >仙家法术点石成金，可以获得大量铜钱，每日次数有限，可别浪费了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >知道了。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1181},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		dj = 1			--点金3次
	},
	--AutoFindWay = { true,  SubmitNPC = true},
	
	task = {1,182},	-- 发送给后台接受任务
};


storyList[100182] =
{

	TaskName = "前往乾元山",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	TIPtype = 3,
	TaskInfo = "前往乾元山向哪吒的师傅太乙真人求救",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >太乙真人是哪吒的师傅，他必然有办法救哪吒，你速去乾元山求救！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好，我这就出发！</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >有朋自远方来，不亦乐乎！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哈哈，我又来了。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		"showWorldTip()"
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1256},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,200},	-- 发送给后台接受任务
};
--乾元山任务开始

storyList[100200] =
{

	TaskName = "再入乾元山",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "经过长途跋涉，终于达到了乾元山",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >看您风尘仆仆，可以先到接引台稍事休息，我师兄会接待你。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢童子。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >请问您有何事？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我有事求见太乙真人，麻烦师兄通报一下。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1182},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,201},	-- 发送给后台接受任务
};
storyList[100201] =
{

	TaskName = "太乙真人",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "在乾元山，见到太乙真人",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >师傅已经算到你会来此，早在棋盘崖等你了，速去吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢师兄。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >唉，看到你来此，想必我那徒儿哪吒已经不在人世了吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >真人，可有救哪吒之法？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1200},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},

	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,202},	-- 发送给后台接受任务
};
storyList[100202] =
{

	TaskName = "复生之法",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "太乙真人已经准备了复活哪吒之法，不过需要你的帮助",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >我知道他命中有此一劫。复活还需借助九转金丹之力，你且拿我丹方，去取来炼丹材料。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >猴儿酒？糟了，我不知道师傅要用，一时嘴馋喝光了！ </font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >啊？那如何是好? </font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1201},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},

	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,203},	-- 发送给后台接受任务
};
storyList[100203] =
{

	TaskName = "取猴儿酒",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "找山上的灵猴取得猴儿酒",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >不好意思，麻烦你再找猴儿们弄点吧，不过小心猴儿们发怒，嘿嘿。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >没办法，人命关天。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >哇，看这样子，你可把猴儿们都得罪惨了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >事出有因，在下也很无奈。 </font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1202},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_028", 5 ,{7,50,42},"猴儿酒"},
	},
	AutoFindWay = { true,   Position={7,50,42}},
	task = {1,204},	-- 发送给后台接受任务
};
storyList[100204] =
{

	TaskName = "青松居士",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "取得了猴儿酒，再去找青松居士取麝香粉末",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >我看看丹方，麝香粉末要去西山青松居士那里去拿。 </font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢相告。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >麝香粉末？最好新取才能使药效最大。 </font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >在哪里获取麝香呢？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1203},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},

	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,205},	-- 发送给后台接受任务
};
storyList[100205] =
{

	TaskName = "取得麝香",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "在灵鹿身上取得麝香",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >山间有许多灵鹿，你可以去自取，不过切记，最好勿伤灵鹿的性命。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >在下知道了。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >好，我帮你处理一下，稍等片刻。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢居士。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1204},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_029", 5 ,{7,14,57},"灵鹿麝香"},
	},

	AutoFindWay = { true,   Position={7,16,56}},
	task = {1,206},	-- 发送给后台接受任务
};
storyList[100206] =
{

	TaskName = "天虹子",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "炼制九转金丹，需要找天虹子师妹帮忙",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >麝香粉末处理好了，你且拿去，想炼制成九转金丹，你要去找小师妹天虹子帮忙。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢居士。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >炼制九转金丹需要金光洞深处的阴阳神火炉来炼丹，在金光洞二层可以取得阴阳神火炉，你可敢去取。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >有何不敢？为了救哪吒，再危险也要去。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1205},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},

	AutoFindWay = { true,   SubmitNPC = true},
	task = {1,212},	-- 发送给后台接受任务
};

storyList[100212] =
{

	TaskName = "二层钥匙",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "夺回金光洞二层的钥匙",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >进入金光洞二层的钥匙被金丹奴抢走了，你去夺回来。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >钥匙拿到了？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是的。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1206},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{		
		kill = { "M_096", 10 ,{7,17,26}},
	},
	AutoFindWay = { true,   Position={7,17,26}},
	task = {1,213},	-- 发送给后台接受任务
};
storyList[100213] =
{

	TaskName = "阴阳神火炉",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "进去金光洞2层，取得阴阳神火炉",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >请一路小心，金光洞2层似乎也不太平静，有陌生的妖力波动。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢师妹提醒。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >好好好，万事具备，且看老夫施法！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >拭目以待。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1212},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "B_035", 1 ,{7,6,19,1},"阴阳神火炉"},
	},
	AutoFindWay = { true,   Position2={7,6,19}},
	
	task = {1,214},	-- 发送给后台接受任务
};
storyList[100214] =
{

	TaskName = "哪吒复生",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "哪吒已经以莲花化身复活，去看看他吧。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >哈哈，哪吒已经复生，你去看看他吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >太好了。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >这几日真是恍然若梦，"..talk.name().."，多谢你为我辛苦奔走，否则我哪有复活之日。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哪吒兄弟，这是什么话。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1213},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	
	task = {1,215},	-- 发送给后台接受任务
};
storyList[100215] =
{

	TaskName = "哪吒复仇",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	TIPtype = 3,
	TaskInfo = "复活的哪吒性情依然刚烈，决议返回东海复仇。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >东海之仇，不可不报，我一刻都无法再忍耐，我要去东海复仇。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哈哈，我跟你一起去。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >哪吒公子，竟然没有死？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我们此次回来是找老龙王算账的，麻烦三水兄弟再次帮我们驾船。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1214},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	
	task = {2,19},	-- 发送给后台接受任务
};

storyList[200019] =
{

	TaskName = "海底猎鲨",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "获取鲨鱼皮加固船体。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >东海龙宫在更远的地方，需要鲨鱼皮加固船身才能达到。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >交给我吧。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >有了这鲨鱼皮，万里汪洋任我遨游！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我们马上出发吧。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1215},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_088", 1 ,{8,14,123},"鲨鱼皮"},
	},
	AutoFindWay = { true,   Position2={8,14,123}},
	--AutoFindWay = { true,   SubmitNPC = true},
	task = {2,20},	-- 发送给后台接受任务
};
storyList[200020] =
{

	TaskName = "坐骑强化",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "将坐骑强化到5星。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >东海龙王可不好对付，你先把坐骑强化到5阶再去为好。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >你说的对。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >好，来帮我杨帆，我们准备出发！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2019},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		horselevel = 5,
	},
	--AutoFindWay = { true,   Position2={8,14,123}},
	--AutoFindWay = { true,   SubmitNPC = true},
	task = {1,216},	-- 发送给后台接受任务
};


storyList[100216] =
{

	TaskName = "激战龙王",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "杀入龙宫，打败龙王。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >准备好了，我们就出发。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哈哈，多谢。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >哈哈，真痛快，总算出了一口怨气！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大仇得报，我们也回去吧。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2020},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "B_038", 1 ,{8,14,123,1}},
	},
	AutoFindWay = { true,   Position2={8,14,123}},
	
	task = {1,218},	-- 发送给后台接受任务
};

storyList[100218] =
{

	TaskName = "回禀李靖",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "回到陈塘关，向李靖禀报哪吒复活与打败龙王的事情。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >"..talk.name().."，多谢你一路陪我到现在，麻烦你先回禀我的父亲吧，我稍后就启程前往西岐。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哈哈，太好了，这样我也总算完成周王的托付了。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >如此大恩，李靖怎敢怠慢，自当前往西岐，报效周王！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >太好了。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1216},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	
	task = {1,219},	-- 发送给后台接受任务
};
storyList[100219] =
{

	TaskName = "李靖投周",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导

	TaskInfo = "李靖终于答应你，投奔西岐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >请先行一步，我这就收拾行装，带家人前往西岐。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的，我们西岐再见。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."，看你喜色满面，想必大功告成了吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >启禀周王殿下，李总兵已经答应马上前来西岐。</font>", --完成任务对话

	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1218},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	
	task = {1,220},	-- 发送给后台接受任务
};
storyList[100220] =
{

	TaskName = "回见师傅",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导

	TaskInfo = "已让李靖归周，回禀师傅。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >太好了，你要什么赏赐？要不我送你一些美人伺候左右？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢周王赏赐，但我心中已有佳人。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."，李靖归周，你立下大功一件。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >师傅过奖了。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1219},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		--daji = 1,
	},
	AutoFindWay = { true,   SubmitNPC = true},
	
	task = {1,224},	-- 发送给后台接受任务
};

storyList[100224] =
{

	TaskName = "为国出力",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导

	TaskInfo = "去见见周武王姬发。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >嗯，力量越强，责任越大。去见见姬发，他说想见见你。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >你就是最近父王经常提起的"..talk.name().."吧，果然少年英雄。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >殿下盛赞了。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1220},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	
	task = {1,250},	-- 发送给后台接受任务
};

storyList[100250] =
{

	TaskName = "周武王姬发",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导

	TaskInfo = "见过姬发，回报师傅姜子牙。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >加入我西岐的修行者越来越多，讨伐商纣指日可待。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >匡扶正义是我辈修行的目的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."，你最近为西周立下汗马功劳，但切记不可自满。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >师傅教训的是。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1224},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = { true,   SubmitNPC = true},
	
	task = {2,27},	-- 发送给后台接受任务
};


storyList[200027] =
{
	TaskName = "护送海美人",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "护送1次海美人",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >有一事需要你去做，我需要人帮我护送一批海族美人返回龙宫。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哦，护花之事，乐意之至啊。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >回来了，一路可安好。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >虽有惊险，但好在安全到达。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{	
		completed={1250},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		husong = 1 , --完成一次护送
	},
	AutoFindWay = {true,Collection={1,86,78,53}},	
	task = {1,300},	-- 发送给后台接受任务
};


storyList[100300] =
{

	TaskName = "乾元之变",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "听说乾元山出现了突变，师傅让你去看看。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >据说乾元山出现了一些不好的情况，乾元山乃我阐教重地，不容有失，你帮我去看看。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢师傅。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >你来的正好，我最近在炼制一炉非常重要的丹药，无法离开，你可愿意帮我一个忙？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >太乙师叔，出什么事情了？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2027},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,301},	-- 发送给后台接受任务
};
storyList[100301] =
{

	TaskName = "草木成精",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "去向哪咤询问草木成精的情况。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >乾元山的草木精灵本来性格温和，最近不知道为何躁动起来，你去找哪咤问问。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >哈哈，好久不见。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >太乙师叔让我来看看怎么回事。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1300},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,302},	-- 发送给后台接受任务
};
storyList[100302] =
{

	TaskName = "剿灭花妖",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "清剿乾元山的花妖。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >我也不知道，乾元山的精灵变得狂暴，开始伤人。不管如何，先镇压下去再说。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我明白了，我且先消灭花妖再来。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >多谢帮忙，最近乾元山诞生不少妖物。不知道是不是天地灵气变的混乱造成的。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也听师傅说天地大劫将近。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1301},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_043", 12 ,{7,77,91}},
	},
	AutoFindWay = { true,  Position={7,77,91}},
	task = {1,303},	-- 发送给后台接受任务
};

storyList[100303] =
{

	TaskName = "剿灭树妖",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "清剿乾元山的树妖。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >还有一批树妖。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我去吧。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >终于清静了，不知道其他地方如何。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我去再看看。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1302},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_044", 12 ,{7,64,120}},
	},
	AutoFindWay = { true,  Position={7,64,120}},
	task = {1,304},	-- 发送给后台接受任务
};

storyList[100304] =
{

	TaskName = "金霞童子",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "哪吒让你去寻找金霞童子。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你去金霞童子哪里看看，也许他有事需要你帮忙。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >你来了，乾元山上的精怪变异的越来越多，我们快忙不过来了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我来帮忙你。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1303},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,306},	-- 发送给后台接受任务
};

storyList[100306] =
{

	TaskName = "清剿鹿精",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "清剿乾元山的鹿精。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >原来的灵鹿，也有不少变成鹿精，出没伤人。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >交给我吧。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >在偏僻角落，还有一些瓦罐精。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >瓦罐也能成精？真是无奇不有啊。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1304},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_045", 12 ,{7,23,128}},
	},
	AutoFindWay = { true,  Position={7,23,128}},
	task = {1,307},	-- 发送给后台接受任务
};

storyList[100307] =
{

	TaskName = "清剿瓦罐精",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "清剿乾元山的瓦罐精。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >乾元山灵气庞大，就算死物熏陶时间长了，也可以成精。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好吧，我去看看瓦罐精。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >我在这里观察了很久，有一股妖气是从听风林飘散出来的。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >嗯，也许这就是症结所在，我去看看。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1306},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_046", 12 ,{7,4,98}},
	},
	AutoFindWay = { true,  Position={7,4,98}},
	task = {1,308},	-- 发送给后台接受任务
};

storyList[100308] =
{

	TaskName = "听风林（一）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "通关听风林一层。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >小心，听风林是很久以前师门长辈修行的地方，很久没有人进去过了，谁也不知道里面的情况。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我会小心的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >可恶，看来二层被下了封印，看来要找到布下封印的人才能进入。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >那该怎么办?</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1307},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "B_051", 1 ,{7,9,133,1}},
	},
	AutoFindWay = { true,  Position2={7,9,133}},
	task = {1,309},	-- 发送给后台接受任务
};

storyList[100309] =
{
	TaskName = "前往后山",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "前往后山寻找乾元山混乱的根源。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你去后山找青松居士看看，也许他发现了一些线索。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >啊，你来的正好，不知不觉，后山已经布满了妖物。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >怎么会这样？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1308},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,310},	-- 发送给后台接受任务
};
storyList[100310] =
{
	TaskName = "后山异变",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "后山已经布满了各种妖物。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >一定有魔界修士潜入乾元山，利用乾元山的灵气布阵召唤妖物。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我先干掉这些妖物。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >看来放任不管也不行啊。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >这么说？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1309},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_102", 12 ,{34,5,42}},
	},
	AutoFindWay = {true,Position={34,5,42}},
	task = {1,311},	-- 发送给后台接受任务
};
storyList[100311] =
{
	TaskName = "平定后山",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "先平定后山的妖物作乱。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >不管那么多，先平定后山的骚乱，再寻找罪魁祸首。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >啊，你怎么来了？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我来帮忙剿灭妖物。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1310},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,312},	-- 发送给后台接受任务
};

storyList[100312] =
{
	TaskName = "剿灭怨灵(一)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "清剿后山的怨灵。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >来的真好，妖物众多，我正感觉力不从心。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >交给我了。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >真厉害啊！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >客气了。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1311},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_103", 12 ,{34,22,8}},
	},
	AutoFindWay = {true,Position={34,22,8}},
	task = {1,313},	-- 发送给后台接受任务
};
storyList[100313] =
{
	TaskName = "剿灭怨灵(二)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "清剿后山的怨灵。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >还请再接再厉。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >交给我了。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >太厉害，真让我惭愧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >其实师兄也挺厉害。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1312},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_104", 12 ,{34,22,28}},
	},
	AutoFindWay = {true,Position={34,22,28}},
	task = {1,314},	-- 发送给后台接受任务
};
storyList[100314] =
{
	TaskName = "剿灭怨灵(三)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "清剿后山的怨灵。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >不让再让你一个人出力了，我也来帮你。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好，我们一起消灭这些妖物。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >妖物真多啊。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >师兄的法术很厉害啊。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1313},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_105", 12 ,{34,39,33}},
	},
	AutoFindWay = {true,Position={34,39,33}},
	task = {1,315},	-- 发送给后台接受任务
};
storyList[100315] =
{
	TaskName = "剿灭怨灵(四)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "清剿后山的怨灵。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >我们一鼓作气，消灭最后这些妖物。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好，我们一起消灭这些妖物。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >累死我了，不知道其他师兄弟们怎么样了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >其他人也来了吗？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1314},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_106", 12 ,{34,39,54}},
	},
	AutoFindWay = {true,Position={34,39,54}},
	task = {1,316},	-- 发送给后台接受任务
};

storyList[100316] =
{
	TaskName = "继续深入",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "深入后山，寻找其他的师兄弟。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >是啊，你先去找天星子，看看他情况如何。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >啊，你怎么来了？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >你怎么站在这里？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1315},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,317},	-- 发送给后台接受任务
};
storyList[100317] =
{
	TaskName = "继续深入",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "深入后山，寻找其他的师兄弟。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >天虹子师妹冲进去了，我要镇守这里，不方便进入。你采集一朵冰莲带上，避免瘴气中毒。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好，我去找她。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >好厉害的妖物。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我来助你一臂之力。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1316},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10005,1,{34,31,73,100025}}},
	},
	AutoFindWay = {true,Collection={34,31,73,100025}},
	task = {1,318},	-- 发送给后台接受任务
};
storyList[100318] =
{
	TaskName = "剿灭怨灵(五)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "清剿后山的怨灵。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >小心，这些妖物都带有毒雾。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >没事，我采了冰莲带上了。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >可恶，毒雾太重，我无法再前进了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >师姐先休息一会，后面交给我了。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1317},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_107", 12 ,{34,39,97}},
	},
	AutoFindWay = {true,Position={34,39,97}},
	task = {1,319},	-- 发送给后台接受任务
};
storyList[100319] =
{
	TaskName = "罪魁祸首(一)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "终于找到了扰乱乾元山的罪魁祸首。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >那你一定要小心，我又预感，罪魁祸首就在前面。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我会小心的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >嘿嘿，不错不错，居然找到了这里。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >你是什么人？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1318},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_108", 12 ,{34,14,102}},
	},
	AutoFindWay = {true,Position={34,14,102}},
	task = {1,320},	-- 发送给后台接受任务
};

storyList[100320] =
{
	TaskName = "罪魁祸首(二)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "终于找到了扰乱乾元山的罪魁祸首。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >想知道我是谁？先让你体验一下魔界的力量。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >可恶。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >嘿嘿，不错的力量啊。看来我真是小看了人界的修士。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >还不束手就擒？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1319},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_109", 12 ,{34,7,81}},
	},
	AutoFindWay = {true,Position={34,7,81}},
	task = {1,321},	-- 发送给后台接受任务
};

storyList[100321] =
{
	TaskName = "听风林（二）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "通关听风林二层。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >哈哈，我在听风林准备了一个小礼物，你先去看看再来找我麻烦吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >什么？莫非？</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >好可怕的妖力，幸亏你赶来了，我都被吓呆了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >可惜还是让那个魔人逃走了。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1320},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "B_054", 1 ,{7,9,133,1}},
	},
	AutoFindWay = { true,  Position2={7,9,133}},
	task = {1,322},	-- 发送给后台接受任务
};
storyList[100322] =
{
	TaskName = "太乙真人",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "再次回去拜见太乙真人。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >这次真是多谢您了，师傅传话在找你，你先去见师傅吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >小友，没想到我闭关炼药期间，乾元山出了这么大的乱子，这是多亏你了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >但是还是让罪魁祸首逃走了。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1321},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,323},	-- 发送给后台接受任务
};
storyList[100323] =
{

	TaskName = "回禀师傅",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "向姜子牙回禀乾元山发生的事情。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你已经做的很好了，老夫会记得你这个人情。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >师叔太客气，我这就回去向师傅复命了。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >徒儿，乾元山情况如何？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >乾元山果然出了问题......</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1322},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,324},	-- 发送给后台接受任务
};
storyList[100324] =
{

	TaskName = "宝石副本",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "宝石副本每日可以免费获得宝石",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你先休整一下，建议你将装备镶嵌宝石，提升自己的战斗力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >将得到的宝石镶嵌到装备上才能体现出价值，亲身体验一下。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是的。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1323},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		--bfb = 1,  --完成一次宝石副本
	},

	--AutoFindWay = {true,Collection={1,64,64,51}},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,350},	-- 发送给后台接受任务
};


storyList[100350] =
{

	TaskName = '伐商宣言',
	TaskInfo = '姜子牙觐见周文王，发出伐商宣言，争取民心',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >如今天下百姓苦不堪言，是时候向天下宣告商纣暴行，发出讨伐檄文，以争取民心。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我帮去你传话。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >姜丞相言之有理，正当如此。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好激动，商周大战就要开启了。</font>',
	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		"showWorldTip()"
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1324},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,351},	-- 发送给后台接受任务
};
storyList[100351] =
{

	TaskName = '商军来袭',
	TaskInfo = '得知周王发出讨伐檄文，纣王大怒，命魔家四将讨伐周国',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >啊，不好，魔家四将前来讨伐我国。这可如何是好？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >别急，师傅必有对策，我去问问师傅。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >我早已料到，在渭水提前做下安排。只要挡过此劫，周国的崛起就势不可挡。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >那需要我做什么？</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1350},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,352},	-- 发送给后台接受任务
};

storyList[100352] =
{

	TaskName = '前往渭水',
	TaskInfo = '姜子牙安排你前往渭水',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >我已安排邓婵玉和雷震子前往渭水，你去协助他们吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >赶快关上门。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >老大爷，你为何如此慌乱？</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1351},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,353},	-- 发送给后台接受任务
};
storyList[100353] =
{

	TaskName = '后方混乱',
	TaskInfo = '渭水战事将起，后方却陷入混乱。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >原来是大人，市集有一批亡命徒作乱，伤了不少百姓。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >岂有此理。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >太好了，多谢大人。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >不客气，这些匪徒太猖獗了。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1352},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_065", 12 ,{10,12,83}},
	},
	AutoFindWay = { true,  Position={10,12,83}},
	task = {1,354},	-- 发送给后台接受任务
};
storyList[100354] =
{

	TaskName = '乱世用重典',
	TaskInfo = '渭水战事将起，迅速镇压后方的混乱。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >对了，南方私塾还有一批作乱的暴民。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >哼，我这就去。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >唉唉，吓死我了，君子动口不动手啊！</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >呵呵。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1353},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_039", 12 ,{10,18,157}},
	},
	AutoFindWay = { true,  Position={10,18,157}},
	task = {1,355},	-- 发送给后台接受任务
};
storyList[100355] =
{

	TaskName = '平定混乱',
	TaskInfo = '渭水战事将起，迅速镇压后方的混乱。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >大人见笑了，读书人就是手无缚鸡之力之力啊。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >不用惭愧，育人子弟也是很高尚的职业。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >唉！</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >怎么了？</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1354},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,356},	-- 发送给后台接受任务
};
storyList[100356] =
{

	TaskName = '渭水河妖(一)',
	TaskInfo = '渭水河妖作乱，迅速查明原因。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >我们依河而生，捕鱼是主要食物来源。但是最近渔家好久没送鱼来了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我去帮你看看。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >唉！</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >怎么了？</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1355},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,357},	-- 发送给后台接受任务
};
storyList[100357] =
{

	TaskName = '渭水河妖(二)',
	TaskInfo = '渭水河妖作乱，迅速查明原因。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >我丈夫去捕鱼，好久都没回来。我远处隐隐看见河里有巨大的阴影游动...</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >莫非有妖物作祟？</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >果然有妖怪，这可怎么办啊？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >大婶别慌，我再去看看。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1356},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_040", 12 ,{10,50,123}},
	},
	AutoFindWay = { true,  Position={10,50,123}},
	task = {1,358},	-- 发送给后台接受任务
};
storyList[100358] =
{

	TaskName = '渭水河妖(三)',
	TaskInfo = '渭水河妖作乱，迅速查明原因。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >拜托大人，请帮我把丈夫带回来。呜呜...</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >放心。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >太好了，终于救援来了，我都被困这里好几天了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >别慌。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1357},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_072", 12 ,{10,43,101}},
	},
	AutoFindWay = { true,  Position={10,43,101}},
	task = {1,359},	-- 发送给后台接受任务
};
storyList[100359] =
{

	TaskName = '渭水河妖(四)',
	TaskInfo = '渭水河妖作乱，迅速查明原因。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >我先驱散河妖，送你回去。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >大人小心。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >对了，大人有没有发现一种奇怪的珍珠？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >什么珍珠？</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1358},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_073", 12 ,{10,60,145}},
	},
	AutoFindWay = { true,  Position={10,60,145}},
	task = {1,360},	-- 发送给后台接受任务
};
storyList[100360] =
{

	TaskName = '渭水河妖(五)',
	TaskInfo = '渭水河妖作乱，迅速查明原因。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >以前渭河没有这种珍珠，我发现以后，没多久就出现了河妖。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我去看看。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >大人有何事找老夫？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >您见过这种珍珠没有？</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1359},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10006,1,{10,54,152,100015}}},
	},
	AutoFindWay = {true,Collection={10,54,152,100015}},
	task = {1,361},	-- 发送给后台接受任务
};
storyList[100361] =
{

	TaskName = '与邓婵玉汇合',
	TaskInfo = '与邓婵玉汇合',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >老夫从没见过这种光泽的珍珠。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >邓婵玉师姐见多识广，也许她知道。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >这种珍珠是魔道修士一种召唤魔物的道具，看来商朝的修士也在幕后下黑手了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >竟然波及平民，可恶。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1360},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,362},	-- 发送给后台接受任务
};
storyList[100362] =
{

	TaskName = '击溃先锋军(一)',
	TaskInfo = '与同伴们配合，击溃商朝的先锋军队。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >子牙师叔自会安排好后方的，我们的任务是狙击敌军先锋部分。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >看我的手段。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >好手段，不愧为近来最耀眼的修行界新星。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >师姐过誉了。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1361},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_066", 12 ,{10,39,72}},
	},
	AutoFindWay = { true,  Position={10,39,72}},
	task = {1,363},	-- 发送给后台接受任务
};
storyList[100363] =
{

	TaskName = '击溃先锋军(二)',
	TaskInfo = '与同伴们配合，击溃商朝的先锋军队。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >不过沙场厮杀不同于与人斗法，小心为上。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我明白。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >要不要休息一下？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >将士们还在奋战，我怎么能休息？</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1362},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_041", 12 ,{10,37,54}},
	},
	AutoFindWay = { true,  Position={10,37,54}},
	task = {1,364},	-- 发送给后台接受任务
};
storyList[100364] =
{

	TaskName = '击溃先锋军(三)',
	TaskInfo = '与同伴们配合，击溃商朝的先锋军队。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >好吧，我们一起战斗，去与金吒汇合。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >哈哈，你们也冲过来了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >金吒真厉害，一个人深入敌阵。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1363},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_069", 12 ,{10,40,38}},
	},
	AutoFindWay = { true,  Position={10,40,38}},
	task = {1,365},	-- 发送给后台接受任务
};
storyList[100365] =
{

	TaskName = '击溃先锋军(四)',
	TaskInfo = '与同伴们配合，击溃商朝的先锋军队。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >废话少说，跟我杀啊。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >师兄真是个急性子。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >还有最后一波。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >嗯。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1364},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_070", 12 ,{10,42,20}},
	},
	AutoFindWay = { true,  Position={10,42,20}},
	task = {1,366},	-- 发送给后台接受任务
};
storyList[100366] =
{

	TaskName = '击溃先锋军(五)',
	TaskInfo = '与同伴们配合，击溃商朝的先锋军队。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >杀啊。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >杀啊。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >哈哈，敌军溃散了。我去追击，你去打扫战场。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >呃，好吧。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1365},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_071", 12 ,{10,59,6}},
	},
	AutoFindWay = { true,  Position={10,59,6}},
	task = {1,367},	-- 发送给后台接受任务
};
storyList[100367] =
{

	TaskName = '营救伤兵(一)',
	TaskInfo = '首战告捷，打扫战场，看看受伤的士兵。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >注意看看有没有受伤的士兵，尽快救治。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >明白。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >.......</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >看来伤的不轻啊。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1366},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,368},	-- 发送给后台接受任务
};
storyList[100368] =
{

	TaskName = '营救伤兵(二)',
	TaskInfo = '首战告捷，打扫战场，看看受伤的士兵。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >.......</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >只能问问医生了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >士兵们的伤势很重啊，要尽快安排休息，寻找药材。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我去安排。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1367},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,369},	-- 发送给后台接受任务
};
storyList[100369] =
{

	TaskName = '营救伤兵(三)',
	TaskInfo = '首战告捷，打扫战场，看看受伤的士兵。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >还麻烦大人驱散周围的敌军骑兵，否则没法安心治疗。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >有些士兵血流不止，军中的金创药不够了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >那要怎么办？</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1368},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_074", 12 ,{10,54,52}},
	},
	AutoFindWay = { true,  Position={10,54,52}},
	task = {1,370},	-- 发送给后台接受任务
};
storyList[100370] =
{

	TaskName = '营救伤兵(四)',
	TaskInfo = '首战告捷，打扫战场，看看受伤的士兵。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >可以在敌人身上寻找一下，也许有备用的金创药。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好主意。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >太好了，血都止住了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >还需要什么？</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1369},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_067", 12 ,{10,61,28},"金创药"},
	},
	AutoFindWay = { true,  Position={10,61,28}},
	task = {1,371},	-- 发送给后台接受任务
};
storyList[100371] =
{

	TaskName = '营救伤兵(五)',
	TaskInfo = '首战告捷，打扫战场，看看受伤的士兵。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >还需要一些接骨草，用于治疗骨折的伤势。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >好了，伤兵们的伤势都稳定下来了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >这下我就放心了。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1370},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10007,1,{10,74,63,100012}}},
	},
	AutoFindWay = {true,Collection={10,74,63,100012}},
	task = {1,372},	-- 发送给后台接受任务
};
storyList[100372] =
{

	TaskName = '新的威胁',
	TaskInfo = '击败了先锋军，魔家四将终于出现，形成了新的威胁。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >多谢大人了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >不客气，我也该走了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你回来了，子牙师叔传下将令，让我们先冲阵，看看魔家兄弟的厉害。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1371},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,373},	-- 发送给后台接受任务
};
storyList[100373] =
{

	TaskName = '魔礼青(一)',
	TaskInfo = '杀掉魔家四将之一的魔礼青',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >先驱散魔家的喽啰，与雷震子汇合。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你也冲上来了？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >情况如何？</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1372},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_063", 12 ,{10,18,40}},
	},
	AutoFindWay = { true,  Position={10,18,40}},
	task = {1,374},	-- 发送给后台接受任务
};
storyList[100374] =
{

	TaskName = '魔礼青(二)',
	TaskInfo = '杀掉魔家四将之一的魔礼青',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >魔家兄弟在九霄布下阵法，不过要先击溃周围的守卫，才能去闯一闯九霄。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >看我的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你也冲上来了？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >情况如何？</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1373},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_064", 12 ,{10,17,15}},
	},
	AutoFindWay = { true,  Position={10,17,15}},
	task = {1,375},	-- 发送给后台接受任务
};
storyList[100375] =
{

	TaskName = '魔礼青(三)',
	TaskInfo = '杀掉魔家四将之一的魔礼青',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >发现九霄的入口了，我们进去闯一闯。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好，一起去。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你也冲上来了？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >情况如何？</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1374},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "B_079", 1 ,{10,12,12,1}},
	},
	AutoFindWay = { true,  Position2={10,12,12}},
	task = {1,376},	-- 发送给后台接受任务
};
storyList[100376] =
{

	TaskName = '求助杨戬',
	TaskInfo = '回去请杨戬一起破阵',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >魔家兄弟果然厉害，看来光我们两个的力量还不足，必须请杨戬师兄帮忙才行。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >也好，我回西岐一趟。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >魔家兄弟？他们四个各具神通，的确不好对付。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >还请杨戬师兄助我一臂之力。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1375},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,377},	-- 发送给后台接受任务
};
storyList[100377] =
{

	TaskName = '经验副本',
	TaskInfo = '完成一次经验副本',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >不过我看你修为尚有不足，推荐你去经验副本先历练一下。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >哦？还有这种地方？</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >感觉如何？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >副本里面的怪物果然厉害。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1376},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		jyfb = 1
	},
	AutoFindWay = {true,Collection={1,46,86,61}},
	task = {1,378},	-- 发送给后台接受任务
};
storyList[100378] =
{

	TaskName = "提升等级到40级",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "将人物等级提升到40级。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >哈哈，你最好先把等级提升到40级，然后我们一起破阵。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好吧。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >哈哈，我们一起出发，去击破魔家四将。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >出发。</font>", --完成任务对话
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		"showWorldTip()"
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1377},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 40,
	},
	task = {1,400},	-- 发送给后台接受任务
};
storyList[100400] =
{

	TaskName = "魔礼红(一)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "杀掉魔家四将之一的魔礼红",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >魔家门下走狗众多，你先配合邓婵玉驱散他们，可以降低魔家阵法的威力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好吧。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >做得好，我们继续。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >出发。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1378},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_066", 15 ,{10,42,73}},
	},
	AutoFindWay = { true,  Position={10,42,73}},
	task = {1,401},	-- 发送给后台接受任务
};
storyList[100401] =
{

	TaskName = "魔礼红(二)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "杀掉魔家四将之一的魔礼红",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >奋勇向前，驱散这些土鸡瓦狗。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >做得好，我们继续。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >出发。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1400},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_041", 15 ,{10,37,54}},
	},
	AutoFindWay = { true,  Position={10,37,54}},
	task = {1,402},	-- 发送给后台接受任务
};
storyList[100402] =
{

	TaskName = "魔礼红(三)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "杀掉魔家四将之一的魔礼红",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >看，九霄的阵法动摇了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >有效果了，再加把劲。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >九霄阵法出现了破绽，好机会。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >冲进去。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1401},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_069", 15 ,{10,41,34}},
	},
	AutoFindWay = { true,  Position={10,41,34}},
	task = {1,403},	-- 发送给后台接受任务
};
storyList[100403] =
{

	TaskName = "魔礼红(四)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "杀掉魔家四将之一的魔礼红",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >魔礼红，受死吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >别跑，我也要来。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >终于击败了魔礼红。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是不是一鼓作气？</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1402},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "B_080", 1 ,{10,12,12,1}},
	},
	AutoFindWay = { true,  Position2={10,12,12}},
	task = {1,404},	-- 发送给后台接受任务
};

storyList[100404] =
{

	TaskName = "提升等级到41级",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "将人物等级提升到41级。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >不，你先将等级提升到41级，才更有把握。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好吧。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >九霄又关闭了，看来魔家兄弟龟缩起来了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >那怎么办？</font>", --完成任务对话
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1403},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 41,
	},
	task = {2,28},	-- 发送给后台接受任务
};
storyList[200028] =
{

	TaskName = "守护通灵",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "通灵并装备一个守护技能",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >看你目前的实力，似乎遇到瓶颈了吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是啊，请指点一下。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >你可以通灵，并装备守护技能，能增加不少战力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1404},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		sh = 1,
	},
	--AutoFindWay = { true,  Position={10,52,45}},
	task = {1,405},	-- 发送给后台接受任务
};
storyList[100405] =
{

	TaskName = "魔礼寿(一)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "杀掉魔家四将之一的魔礼寿",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你与金吒师兄配合，彻底击溃商朝军队，我就不信他们一直龟缩不出。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好主意。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >呵呵，我就说怎么敌军阵脚大乱，原来是你杀过来了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >事情是这样的......</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2028},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_074", 15 ,{10,52,45}},
	},
	AutoFindWay = { true,  Position={10,52,45}},
	task = {1,406},	-- 发送给后台接受任务
};
storyList[100406] =
{

	TaskName = "魔礼寿(二)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "杀掉魔家四将之一的魔礼寿",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >哈哈，早就等得不耐烦了，士兵们，随我冲锋。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >金吒师兄真是个急性子啊。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >效果如何？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >还不够，九霄阵法还没有动静。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1405},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_070", 15 ,{10,43,20}},
	},
	AutoFindWay = { true,  Position={10,43,20}},
	task = {1,407},	-- 发送给后台接受任务
};
storyList[100407] =
{

	TaskName = "魔礼寿(三)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "杀掉魔家四将之一的魔礼寿",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >那我们就大闹一场，彻底冲散敌军。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >奇怪，为什么还没有反应？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是啊。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1406},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_071", 15 ,{10,64,7}},
	},
	AutoFindWay = { true,  Position={10,64,7}},
	task = {1,408},	-- 发送给后台接受任务
};
storyList[100408] =
{

	TaskName = "魔礼寿(四)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "杀掉魔家四将之一的魔礼寿",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >莫非是因为敌人有援军赶到？一起驱散他们。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >果然，九霄出现入口了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我马上赶过去。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1407},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_067", 15 ,{10,59,28}},
	},
	AutoFindWay = { true,  Position={10,59,28}},
	task = {1,409},	-- 发送给后台接受任务
};
storyList[100409] =
{

	TaskName = "魔礼寿(五)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "杀掉魔家四将之一的魔礼寿",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >等等我，这种破阵斩将的功劳可不能少了我一份。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >呵呵，同去。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >干得好，只剩下魔礼海一个人了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >不过我们的将士也死伤惨重啊。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1408},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "B_081", 1 ,{10,12,12,1}},
	},
	AutoFindWay = { true,  Position2={10,12,12}},
	task = {1,410},	-- 发送给后台接受任务
};

storyList[100410] =
{

	TaskName = '提升等级42级',
	TaskInfo = '将等级提升到42级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >我军也需要休整时间，你将等级提升到42级，我们再一起破阵。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你等级提升真快。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >让你久等了，我们出发吧。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1409},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 42,
	},

	task = {1,411},	-- 发送给后台接受任务
};
storyList[100411] =
{

	TaskName = "魔礼海(一)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "杀掉魔家四将之一的魔礼海",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >除掉最后的魔家弟子，魔礼海就独木难支了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >冲啊。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >不愧雷震子之名啊。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1410},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_063", 15 ,{10,17,40}},
	},
	AutoFindWay = { true,  Position={10,17,40}},
	task = {1,412},	-- 发送给后台接受任务
};
storyList[100412] =
{

	TaskName = "魔礼海(二)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "杀掉魔家四将之一的魔礼海",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >还有最后一批。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >九霄摇摇欲坠了，我已经听到魔礼海的绝望嚎叫声了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >嗯。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1411},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_064", 15 ,{10,17,16}},
	},
	AutoFindWay = { true,  Position={10,17,16}},
	task = {1,413},	-- 发送给后台接受任务
};
storyList[100413] =
{

	TaskName = "魔礼海(三)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "杀掉魔家四将之一的魔礼海",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >最后一战，彻底击败商军，胜负在此一举。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >出发。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >终于结束了，哈哈，我们获胜了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哈哈。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1412},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "B_082", 1 ,{10,12,12,1}},
	},
	AutoFindWay = { true,  Position2={10,12,12}},
	task = {1,414},	-- 发送给后台接受任务
};
storyList[100414] =
{

	TaskName = '回报捷报',
	TaskInfo = '将捷报告知姜子牙',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >赶紧回去，将捷报告诉子牙丞相。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >真是辛苦你们了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >为了天下百姓，不辛苦。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1413},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,415},	-- 发送给后台接受任务
};
storyList[100415] =
{

	TaskName = '提升等级43级',
	TaskInfo = '将等级提升到43级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >你先休整一下，将等级提升到43级。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >商朝组织下一次攻势，必然还有一段时间。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >看来我还可以休息一段时间。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1414},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 43,
	},

	task = {1,416},	-- 发送给后台接受任务
};


storyList[100416] =
{

	TaskName = "摇钱树",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导	
	TaskInfo = "家园里面的摇钱树成熟了，回家收获吧",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你庄园里的摇钱树应该成熟了，你可以先去收取后再来。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >啊，那我得马上回去。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >糟糕，收到一个不好的消息，似乎有修行者对你的庄园别有企图。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >什么?</font>", --完成任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >回来了，那我们继续。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >明白。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1415},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		yaoqian =1 
	},
	--AutoFindWay = { true,   Position={7,6,19}},
	
	task = {1,417},	-- 发送给后台接受任务
};

storyList[100417] =
{

	TaskName = "掠夺庄园",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "完成一次掠夺庄园。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >修行者之间的庄园是可以彼此攻击的，平时一定要小心。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >原来还有这种事情。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >所以你要努力修行，还要随时关注其他的修行者。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我去查看下。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1416},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		homewar =1 ,
	},
--	AutoFindWay = {true,SubmitNPC = true},
	task = {1,418},	-- 发送给后台接受任务
};
storyList[100418] =
{

	TaskName = "钓鱼",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "辛苦这么久了，去钓鱼举办个宴会犒劳下自己吧。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >别急，要劳逸结合。去钓鱼举办一场宴会吧，也可把朋友们也邀请来。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >也对。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >休息好了吧，要继续开始修行了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		--"PlayerTip(44)"
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1417},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		fish2 = 1,
	},
	AutoFindWay = {true,Collection={1,47,77,54}},
	task = {1,419},	-- 发送给后台接受任务
};

storyList[100419] =
{

	TaskName = '提升等级44级',
	TaskInfo = '将等级提升到44级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >这次的目标，要将等级提升到44级。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >有个新的任务安排给你，渭水作为粮食主产地，最近也颗粒无收。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >为什么？</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1418},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 44,
	},

	task = {1,420},	-- 发送给后台接受任务
};
storyList[100420] =
{

	TaskName = '闹鬼农庄(一)',
	TaskInfo = '去渭水解决农庄闹鬼事件，恢复粮食生产。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >据说是出了闹鬼的传闻，我怀疑是敌方修士在捣鬼，你去看看。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >鬼啊~</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我是人，不是鬼。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1419},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,421},	-- 发送给后台接受任务
};
storyList[100421] =
{

	TaskName = '闹鬼农庄(二)',
	TaskInfo = '去渭水解决农庄闹鬼事件，恢复粮食生产。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >你真的是人？我不信，除非你杀了外面那些鬼。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >呃，好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >看来你真的是丞相大人派来的，外面那些是什么东西？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >那是一些妖怪和山贼。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1420},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_068", 15 ,{10,75,35}},
	},
	AutoFindWay = { true,  Position={10,75,35}},
	task = {1,422},	-- 发送给后台接受任务
};
storyList[100422] =
{

	TaskName = '闹鬼农庄(三)',
	TaskInfo = '去渭水解决农庄闹鬼事件，恢复粮食生产。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >它们为什么在农庄附近徘徊？现在成熟的稻谷都没法收割。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我正是为此事而来。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >怎么样？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >这些山贼都失去理智。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1421},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_110", 15 ,{10,87,24}},
	},
	AutoFindWay = { true,  Position={10,87,24}},
	task = {2,37},	-- 发送给后台接受任务
};

storyList[200037] =
{

	TaskName = '提升等级45级',
	TaskInfo = '将等级提升到45级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >那怎么办？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >让我将修为提升到45级才能更好的解决。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你终于回来了，快帮帮我吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >放心吧</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1422},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 45,
	},

	task = {1,423},	-- 发送给后台接受任务
};




storyList[100423] =
{

	TaskName = '闹鬼农庄(四)',
	TaskInfo = '去渭水解决农庄闹鬼事件，恢复粮食生产。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >接下来要怎么做？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我再去抓个狼妖看看。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >哇，好可怕的妖怪。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >这些狼妖也失去了意识。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2037},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_111", 15 ,{10,91,45}},
	},
	AutoFindWay = { true,  Position={10,91,45}},
	task = {1,424},	-- 发送给后台接受任务
};
storyList[100424] =
{

	TaskName = '闹鬼农庄(五)',
	TaskInfo = '去渭水解决农庄闹鬼事件，恢复粮食生产。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >我突然想起来，农庄后面先是出现一个奇怪的墓碑，然后才出现这些怪物的。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >哦？这可能是个线索。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >就是这种墓碑，我当时看到就恶心想吐，然后第二天怪物就出现了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >这上面布满邪气，果然有蹊跷。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1423},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10003,1,{10,100,8,100013}}},
	},
	AutoFindWay = {true,Collection={10,100,8,100013}},
	task = {1,425},	-- 发送给后台接受任务
};
storyList[100425] =
{

	TaskName = '闹鬼农庄(六)',
	TaskInfo = '去渭水解决农庄闹鬼事件，恢复粮食生产。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >那您有办法彻底驱逐这些怪物吗？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >你稍安勿躁，我先回去求教师傅。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >唔，这是一种魔界阵法的施法材料，可以召唤邪物并迷惑其心智。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >那要如何解除这种邪法？</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1424},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,426},	-- 发送给后台接受任务
};
storyList[100426] =
{

	TaskName = '提升等级46级',
	TaskInfo = '将等级提升到46级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >这次的敌人不简单，你要将等级提升到46级，再去才比较保险。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >要解除这种邪法，必须杀掉施法者。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >如何寻找释放者呢？</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1425},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 46,
	},

	task = {1,427},	-- 发送给后台接受任务
};
storyList[100427] =
{

	TaskName = '平定农庄(一)',
	TaskInfo = '驱逐破坏农庄生产的幕后黑手',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >释放有两个前置条件，一是有魔化的草木类妖物污染灵气，二是有深井沟通地底。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >英雄，情况如何？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我已经找到幕后黑手了。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1426},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_120", 15 ,{10,101,31}},
	},
	AutoFindWay = { true,  Position={10,101,31}},
	task = {1,428},	-- 发送给后台接受任务
};
storyList[100428] =
{

	TaskName = '平定农庄(二)',
	TaskInfo = '驱逐破坏农庄生产的幕后黑手',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >太好了，一切就拜托你了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >放心。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >啊，农庄的怪物不在出现了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >嗯，我已经破解掉邪法。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1427},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_112", 15 ,{10,118,43}},
	},
	AutoFindWay = { true,  Position={10,118,43}},
	task = {2,38},	-- 发送给后台接受任务
};

storyList[200038] =
{

	TaskName = '平定农庄(三)',
	TaskInfo = '清理妖魔，恢复生产',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >那请少侠将田地里已经出现的妖魔清除，我们就可以收割了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >放心。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >还有其他的妖魔，也请少侠出手。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1428},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_068", 20 ,{10,75,35}},
	},
	AutoFindWay = { true,  Position={10,75,35}},
	task = {2,39},	-- 发送给后台接受任务
};
storyList[200039] =
{

	TaskName = '平定农庄(四)',
	TaskInfo = '清理妖魔，恢复生产',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >这次请将迷乱的山贼消灭，打通运送的道路。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >少侠你真厉害。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >过奖了。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2038},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_110", 20 ,{10,87,24}},
	},
	AutoFindWay = { true,  Position={10,87,24}},
	task = {2,40},	-- 发送给后台接受任务
};
storyList[200040] =
{

	TaskName = '提升等级47级',
	TaskInfo = '将等级提升到47级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >我看少侠也很累了，不如休息一下，将等级提升到47级再继续。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >恩，这样也不错。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >少侠你回来，果然更厉害了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好说。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2039},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 47,
	},
	--AutoFindWay = { true,  Position={10,87,24}},
	task = {2,41},	-- 发送给后台接受任务
};
storyList[200041] =
{

	TaskName = '平定农庄(五)',
	TaskInfo = '清理妖魔，恢复生产',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >请将狂暴的狼妖清除，避免它们再伤害人。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >少侠要再休息一下吗。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >不用了，继续。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2040},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_111", 20 ,{10,91,45}},
	},
	AutoFindWay = { true,  Position={10,91,45}},
	task = {2,42},	-- 发送给后台接受任务
};
storyList[200042] =
{

	TaskName = '平定农庄(六)',
	TaskInfo = '清理妖魔，恢复生产',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >之后只要将腐烂树妖消灭，就可以了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >这下我们就可以安心了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >太好了。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2041},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_120", 20 ,{10,101,31}},
	},
	AutoFindWay = { true,  Position={10,101,31}},
	task = {1,429},	-- 发送给后台接受任务
};

storyList[100429] =
{

	TaskName = '平定农庄(七)',
	TaskInfo = '回禀姜子牙。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >这下可以收割稻谷，恢复生产了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >这就好，总算完成任务了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >干的不错，粮食已经收上来了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我这次效率很高吧。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2042},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,430},	-- 发送给后台接受任务
};
storyList[100430] =
{

	TaskName = '提升等级48级',
	TaskInfo = '将等级提升到48级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >不要自满，前方传来密报，商朝又蠢蠢欲动了，你将等级提升到48级，再来找我。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >商朝修士摆下十绝阵，欲彻底封杀我军。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >那我们要怎么做？</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1429},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 48,
	},

	task = {1,431},	-- 发送给后台接受任务
};
storyList[100431] =
{

	TaskName = '寒冰阵(一)',
	TaskInfo = '突破寒冰阵',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >去前方与哪咤汇合，破除十绝阵中的寒冰与金光二阵，其他我自有安排。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >子牙师叔将破阵任务交给我们，我们可不能辜负他，你怎么看？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我看先破寒冰阵吧。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1430},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,432},	-- 发送给后台接受任务
};
storyList[100432] =
{

	TaskName = '寒冰阵(二)',
	TaskInfo = '突破寒冰阵',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >不错，寒冰阵袁天君实力较弱，从他入手比较好。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我先去冲阵看看。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >敌人好像不太强。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >是啊，但是麻烦的是阵法。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1431},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_114", 15 ,{10,102,71}},
	},
	AutoFindWay = { true,  Position={10,102,71}},
	task = {1,433},	-- 发送给后台接受任务
};
storyList[100433] =
{

	TaskName = '寒冰阵(三)',
	TaskInfo = '突破寒冰阵',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >还是先收集一下情报。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你看这个.......</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >原来阵法是这样的。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1432},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_113", 15 ,{10,87,71},"寒冰阵情报"},
	},
	AutoFindWay = { true,  Position={10,87,71}},
	task = {2,43},	-- 发送给后台接受任务
};
storyList[200043] =
{

	TaskName = '提升等级49级',
	TaskInfo = '将等级提升到49级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >终于发现阵法的破绽，但你目前修为不足，提升到49就才去破阵吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你回来了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >是的。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1433},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 49,
	},

	task = {1,434},	-- 发送给后台接受任务
};


storyList[100434] =
{

	TaskName = '寒冰阵(四)',
	TaskInfo = '突破寒冰阵',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >出发吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >哈哈，首功到手，先破了寒冰阵。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >呵呵。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2043},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "B_083", 1 ,{10,122,94,1}},
	},
	AutoFindWay = { true,  Position2={10,122,94}},
	task = {2,44},	-- 发送给后台接受任务
};
storyList[200044] =
{

	TaskName = '破阵准备（一）',
	TaskInfo = '为突破金光阵做准备',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >避免突破阵法后被围攻，我们先将周围的敌人消灭掉吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >哈哈，不错，我们继续。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >呵呵。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1434},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_114", 20 ,{10,102,71}},
	},
	AutoFindWay = { true,  Position2={10,102,71}},
	task = {2,45},	-- 发送给后台接受任务
};
storyList[200045] =
{

	TaskName = '破阵准备（二）',
	TaskInfo = '为突破金光阵做准备',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >再将寒冰弟子消灭就可以了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >很好，接下来我们就准备破金光阵吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2044},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_113", 20 ,{10,87,71}},
	},
	AutoFindWay = { true,  Position2={10,87,71}},
	task = {1,435},	-- 发送给后台接受任务
};




storyList[100435] =
{

	TaskName = '提升等级50级',
	TaskInfo = '将等级提升到50级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >休憩片刻，我们再去破金光阵。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >还是老办法，先冲乱敌人阵形，看看阵法有没有破绽。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2045},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 50,
	},

	task = {1,436},	-- 发送给后台接受任务
};
storyList[100436] =
{

	TaskName = '金光阵(一)',
	TaskInfo = '突破金光阵',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >冲啊！</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >看到金光阵了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好强大的阵法。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1435},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_113", 15 ,{10,87,71}},
	},
	AutoFindWay = { true,  Position={10,87,71}},
	task = {1,437},	-- 发送给后台接受任务
};
storyList[100437] =
{

	TaskName = '金光阵(二)',
	TaskInfo = '突破金光阵',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >但是肯定应该有破绽。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >抓几个敌人来问下。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >原来有些金光是专门攻人魂魄，我是莲花化身，不怕这个，我打头阵。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好，我在后面掩护你。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1436},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_114", 15 ,{10,102,71},"金光阵情报"},
	},
	AutoFindWay = { true,  Position={10,102,71}},
	task = {1,438},	-- 发送给后台接受任务
};
storyList[100438] =
{

	TaskName = '金光阵(三)',
	TaskInfo = '突破金光阵',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >准备好了吗？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >出发。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >哈哈，顺利完成任务。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >哈哈，真痛快。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1437},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "B_084", 1 ,{10,122,94,1}},
	},
	AutoFindWay = { true,  Position2={10,122,94}},
	task = {1,439},	-- 发送给后台接受任务
};

storyList[100439] =
{

	TaskName = '回报师傅',
	TaskInfo = '向姜子牙复命',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >你先向子牙师叔复命吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你做的很好，这次记你和哪咤的首功。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >呵呵。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1438},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},	
	task = {2,46},	-- 发送给后台接受任务
};
--51级增加人物
storyList[200046] =
{

	TaskName = '提升等级到51级',
	TaskInfo = '将等级提升到51级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >你休息一下，尽快将等级提升到51吧，接下来的大战还需要你的力量。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >昨天，渭水的渔夫前来报告说商军的残兵在渭水为恶。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >怎么会这样？</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1439},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 51,
	},
	--AutoFindWay = {true,SubmitNPC = true},	
	task = {2,47},	-- 发送给后台接受任务
};

storyList[200047] =
{

	TaskName = '消灭残军(一)',
	TaskInfo = '在渭水消灭商朝的残兵游勇。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >你去配合金吒将他们全部消灭。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了，师傅。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你来的正好，残军比较多，我一个人忙不过来了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我要做什么？</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2046},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_066", 30 ,{10,39,72}},
	},
	AutoFindWay = { true,  Position2={10,39,72}},
	task = {2,48},	-- 发送给后台接受任务
};
storyList[200048] =
{

	TaskName = '消灭残军(二)',
	TaskInfo = '在渭水消灭商朝的残兵游勇。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >精锐斥候不停地骚扰渭水百姓，先将他们消灭了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >这样渭水的老百姓可以平安的生活了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >是啊。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2047},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_041", 30 ,{10,37,54}},
	},
	AutoFindWay = { true,  Position2={10,37,54}},
	task = {2,49},	-- 发送给后台接受任务
};
storyList[200049] =
{

	TaskName = '消灭残军(三)',
	TaskInfo = '在渭水消灭商朝的残兵游勇。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >接下来就是商军士兵了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >没有问题。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >很好，准备下一个目标。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >是什么？</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2048},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_069", 30 ,{10,40,38}},
	},
	AutoFindWay = { true,  Position2={10,40,38}},
	task = {2,50},	-- 发送给后台接受任务
};
storyList[200050] =
{

	TaskName = '消灭残军(四)',
	TaskInfo = '在渭水消灭商朝的残兵游勇。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >商军游骑仗着马快袭扰粮草部队，给我们的进军带来了不少麻烦。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >那还等什么，快去将他们消灭。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你做的不错，武王正在联系各路诸侯共同进攻。你暂时休息一下。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2049},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_070", 30 ,{10,42,20}},
	},
	AutoFindWay = { true,  Position2={10,42,20}},
	task = {2,51},	-- 发送给后台接受任务
};
storyList[200051] =
{

	TaskName = '提升等级到52级',
	TaskInfo = '将等级提升到52级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >尽快将等级提升到53吧，接下来的大战还需要你的力量。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >同盟商议还要持续一段时间，你也不能这么闲着。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >那我做什么？</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2050},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 52,
	},
	--AutoFindWay = {true,SubmitNPC = true},	
	task = {2,52},	-- 发送给后台接受任务
};

storyList[200052] =
{

	TaskName = '消灭残军(五)',
	TaskInfo = '继续在渭水消灭商朝的残兵游勇。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >金吒来信说渭水的商军又有集结的迹象，让你去帮他消灭商军弓骑兵。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我这就去。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >看来又要麻烦你了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >都是为天下百姓。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2051},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_074", 30 ,{10,54,52}},
	},
	AutoFindWay = { true,  Position2={10,54,52}},
	task = {2,53},	-- 发送给后台接受任务
};
storyList[200053] =
{

	TaskName = '消灭残军(六)',
	TaskInfo = '继续在渭水消灭商朝的残兵游勇。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >接着我们一起去消灭邪派修士。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >没问题。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >哈哈，这些商朝军队真不经打。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >就是。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2052},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_067", 30 ,{10,61,28}},
	},
	AutoFindWay = { true,  Position2={10,61,28}},
	task = {2,54},	-- 发送给后台接受任务
};
storyList[200054] =
{

	TaskName = '消灭残军(七)',
	TaskInfo = '继续在渭水消灭商朝的残兵游勇。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >还有就是商军重骑兵了，给我们的后防线带来了不少死伤。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >放心交给我吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >看来没有什么事可以难住你了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >过奖。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2053},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_071", 30 ,{10,64,7}},
	},
	AutoFindWay = { true,  Position2={10,64,7}},
	task = {2,55},	-- 发送给后台接受任务
};
storyList[200055] =
{

	TaskName = '消灭残军(八)',
	TaskInfo = '继续在渭水消灭商朝的残兵游勇。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >神秘巫师，使用各种匪夷所思的邪术也给我们带来了不少问题。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >击杀他们就没有问题了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >武王已经听说你的事迹了，他非常感动。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >这都是我们应该做的。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2054},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_112", 30 ,{10,118,43}},
	},
	AutoFindWay = { true,  Position2={10,118,43}},
	task = {1,440},	-- 发送给后台接受任务
};

storyList[100440] =
{

	TaskName = '提升等级到53级',
	TaskInfo = '将等级提升到53级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >你休息一下，尽快将等级提升到53吧，接下来的大战积蓄力量。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >我已派遣武成王黄飞虎布下防御阵地，你尽快去协助他。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2055},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 53,
	},
	--AutoFindWay = {true,SubmitNPC = true},	
	task = {1,450},	-- 发送给后台接受任务
};

storyList[100450] =
{

	TaskName = '打通通道',
	TaskInfo = '大战已经开始，前往渭水协助武成王黄飞虎',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >对了，武成王好几天没有传递消息回来了，估计路上遭到了敌人的封锁，你一路小心。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >没问题。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >将军请留步。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >你是？</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1440},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_113", 15 ,{10,87,71}},
	},
	AutoFindWay = { true,  Position={10,87,71}},
	task = {1,451},	-- 发送给后台接受任务
};
storyList[100451] =
{

	TaskName = '落魄密探',
	TaskInfo = '帮助密探消灭敌人，保持通讯畅通',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >我是武成王派出的密探，但是道路被封锁，就一直被困在这里，消息没法送回西岐。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >原来如此，我来帮你一把。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >哈哈，你终于赶来了，我正愁没有先锋大将，去挫一挫敌人的锐气。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >多谢武成王为我留作先锋官的位置。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1450},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_114", 15 ,{10,102,71}},
	},
	AutoFindWay = { true,  Position={10,102,71}},
	task = {1,452},	-- 发送给后台接受任务
};
storyList[100452] =
{

	TaskName = '首战告捷',
	TaskInfo = '消灭魔化将领，挫一挫敌人的锐气',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >商朝的军阵中妖气冲天，看来妖魔众多，不好对付啊。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >放心吧，降妖除魔正是我所擅长。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >哈哈，干得好，这下敌人不敢再嚣张了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好像敌人出现新的妖魔了。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1451},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_075", 15 ,{10,99,119}},
	},
	AutoFindWay = { true,  Position={10,99,119}},
	task = {1,453},	-- 发送给后台接受任务
};
storyList[100453] =
{

	TaskName = '魔界军队',
	TaskInfo = '消灭魔界兽兵',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >这，这是魔界的军队啊，莫非商朝冒天下之大不韪，打开了魔界通道？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >不管那么多，我先出战。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >应该是魔界军队，你必须马上回去禀报丞相。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好，我就先回去一趟。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1452},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_076", 15 ,{10,84,133}},
	},
	AutoFindWay = { true,  Position={10,84,133}},
	task = {2,56},	-- 发送给后台接受任务
};
storyList[200056] =
{

	TaskName = '提升等级到54级',
	TaskInfo = '将等级提升到54级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >以你目前的实力对付魔界军队比较吃力，将等级提升到54吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >渭水的农夫传来信息，魔物又出现了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我这就去。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1453},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 54,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,57},	-- 发送给后台接受任务
};
storyList[200057] =
{

	TaskName = '渭水除妖（一）',
	TaskInfo = '妖魔再次肆虐渭水，去消灭它们吧。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >慌什么，遇事不乱才能成大事。你先去消灭魔化寄居蟹，再去找农夫。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >大人，你终于来了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >接下来就全交给我吧。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2056},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_040", 30 ,{10,50,123}},
	},
	AutoFindWay = { true,  Position={10,50,123}},
	task = {2,58},	-- 发送给后台接受任务
};
storyList[200058] =
{

	TaskName = '渭水除妖（二）',
	TaskInfo = '妖魔再次肆虐渭水，去消灭它们吧。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >请大人去消灭魔化蟹将。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >大人，辛苦了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >这没什么。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2057},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_072", 30 ,{10,43,101}},
	},
	AutoFindWay = { true,  Position={10,43,101}},
	task = {2,59},	-- 发送给后台接受任务
};
storyList[200059] =
{

	TaskName = '渭水除妖（三）',
	TaskInfo = '妖魔再次肆虐渭水，去消灭它们吧。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >瓦罐妖使用毒水污染土地，不尽快解决，以后将颗粒无收。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >祖辈传下来的土地终于保住了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >这就好。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2058},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_068", 30 ,{10,75,35}},
	},
	AutoFindWay = { true,  Position={10,75,35}},
	task = {2,62},	-- 发送给后台接受任务
};

storyList[200062] =
{

	TaskName = '提升等级到55级',
	TaskInfo = '将等级提升到55级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >为了更轻松的对付这些魔物，你先将等级提升到55吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >少侠，感觉你变强了很多啊。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我还需要继续努力。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2059},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 55,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,60},	-- 发送给后台接受任务
};


storyList[200060] =
{

	TaskName = '渭水除妖（四）',
	TaskInfo = '妖魔再次肆虐渭水，去消灭它们吧。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >在田间劳作的人被狂暴的狼妖袭击了，请帮帮我们。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >多谢大人。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >这是我该做的。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2062},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_111", 30 ,{10,91,45}},
	},
	AutoFindWay = { true,  Position={10,91,45}},
	task = {2,61},	-- 发送给后台接受任务
};
storyList[200061] =
{

	TaskName = '渭水除妖（五）',
	TaskInfo = '妖魔再次肆虐渭水，去消灭它们吧。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >腐烂树妖不停地吸收田地中的养分，使得粮食大大减产，只要解决了它们就无忧了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我这就去消灭它们。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >听说你解决了妖魔肆虐的问题，非常不错。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >将军过奖了。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2060},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_120", 30 ,{10,101,31}},
	},
	AutoFindWay = { true,  Position={10,101,31}},
	task = {1,454},	-- 发送给后台接受任务
};



storyList[100454] =
{

	TaskName = '军粮告急',
	TaskInfo = '虽然获得小胜，但是军粮不足，出现了补给危机',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >补给还没有运到，你去问问我的副官，军粮还剩下多少。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >大人，军粮只余10多日的了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >什么？怎么消耗这么快？</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2061},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,455},	-- 发送给后台接受任务
};
storyList[100455] =
{

	TaskName = '回禀丞相',
	TaskInfo = '向姜子牙报告敌军出现魔界军队和军粮不足的消息',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >敌人比想象中强大，为了保持士兵的战力和士气，粮食消耗也大了一倍。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >唉，好吧，我会回禀姜丞相的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >嗯嗯，军粮不足，魔界的变数，战斗持续下去对我们不利啊。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >那该怎么办?</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1454},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,456},	-- 发送给后台接受任务
};
storyList[100456] =
{

	TaskName = '提升等级到56级',
	TaskInfo = '将等级提升到56级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >唯一的办法是斩首行动，击败敌军主力。但是你的等级略低，提升到56级再来找我。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >我已经安排了一批军粮送去，大概还能支撑30天左右，只能解燃眉之急。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >哦。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1455},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 56,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,457},	-- 发送给后台接受任务
};
storyList[100457] =
{

	TaskName = '全面决战',
	TaskInfo = '向黄飞虎传达了全面决战的命令',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >你传我将令，命黄飞虎全面决战，吸引敌人大军注意，然后你寻找机会消灭敌人主力。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >责任重大啊，请师傅放心。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >怎么样？丞相怎么说？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我师傅说……</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1456},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,458},	-- 发送给后台接受任务
};
storyList[100458] =
{

	TaskName = '魔界悍将',
	TaskInfo = '消灭魔界悍将',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >唉，好吧，将军难免阵前亡，为了寻找一线胜机，我会带大军吸引敌人注意，剩下的就全靠你了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >多谢将军，请相信我。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >我已经吸引了一部分敌军，但是你还是要自己突破一部分阻拦。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我明白。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1457},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_077", 15 ,{10,113,138}},
	},
	AutoFindWay = { true,  Position={10,113,138}},
	task = {1,459},	-- 发送给后台接受任务
};
storyList[100459] =
{

	TaskName = '魔界鬼巫',
	TaskInfo = '消灭魔界鬼巫',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >还有一批魔界鬼巫，冲破阻拦，就有机会。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >出发。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >密探传来消息，敌军主力部队就在前面。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >太好了，机会难得，我立刻出发。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1458},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_078", 15 ,{10,97,155}},
	},
	AutoFindWay = { true,  Position={10,97,155}},
	task = {1,460},	-- 发送给后台接受任务
};
storyList[100460] =
{

	TaskName = '歼灭主力',
	TaskInfo = '歼灭敌军主力修士部队，取得最后胜利',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >祝你一路顺风！</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >等我好消息。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >不好，敌人用法阵又传送来一大批部队。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >可恶，功亏一篑了吗？</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1459},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_078", 20 ,{10,97,155}},
	},
	AutoFindWay = { true,  Position={10,97,155}},
	task = {1,461},	-- 发送给后台接受任务
};

storyList[100461] =
{

	TaskName = '提升等级到57级',
	TaskInfo = '将等级提升到57级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >没有办法，只有咬牙拼命了。但是你的等级略低，提升到57级再来找我。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >杀吧，我也要身先士卒，振奋士气。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我也一样。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1460},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 57,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,462},	-- 发送给后台接受任务
};
storyList[100462] =
{

	TaskName = '最后决战(一)',
	TaskInfo = '拼死决战，一定要获得最后的胜利',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >冲啊！</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >冲啊！</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >敌人真多！</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >这不算什么。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1461},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_075", 20 ,{10,97,115}},
	},
	AutoFindWay = { true,  Position={10,97,115}},
	task = {2,63},	-- 发送给后台接受任务
};

storyList[200063] =
{

	TaskName = '提升等级到58级',
	TaskInfo = '将等级提升到58级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >虽然你这么说，但为了你的安全，提升到58级再来找我。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >既然回来了，我们就继续吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1462},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 58,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,463},	-- 发送给后台接受任务
};

storyList[100463] =
{

	TaskName = '最后决战(二)',
	TaskInfo = '拼死决战，一定要获得最后的胜利',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >很有自信嘛，我们看谁杀的快！</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好！</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >哈哈，怎么样？我还不算老吧！</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >武成王果然勇猛。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2063},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_076", 20 ,{10,80,131}},
	},
	AutoFindWay = { true,  Position={10,80,131}},
	task = {2,64},	-- 发送给后台接受任务
};

storyList[200064] =
{

	TaskName = '提升等级到59级',
	TaskInfo = '将等级提升到59级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >虽然这么说了，但体力还是更不上了。全军也需要休整，你乘机将等级提升到59吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >很好，全军休整完毕正在等待命令。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我们的军队士气如虹。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1463},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 59,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,65},	-- 发送给后台接受任务
};

storyList[200065] =
{

	TaskName = '询问进军安排',
	TaskInfo = '向姜子牙询问后续进军安排',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >目前前线，战事复杂，你去问问丞相，可有什么新的安排。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你回来了，我与武王正在商量之后的进军计划。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >可有详细的计划。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2064},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {2,66},	-- 发送给后台接受任务
};

storyList[200066] =
{

	TaskName = '提升等级到60级',
	TaskInfo = '将等级提升到60级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >哪有这么快，一不小心就会全军覆没。你也别闲着，先去将等级提升60级。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >好了，最新的进军计划全在这个锦囊中。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我能看看吗？</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2065},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 60,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,67},	-- 发送给后台接受任务
};

storyList[200067] =
{

	TaskName = '进军计划',
	TaskInfo = '将最新的进军计划交给黄飞虎。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >军事机密不可泄露，你必须尽快交给黄飞虎将军。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >最新的计划，我马上看看。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >怎么安排的？</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2066},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {2,68},	-- 发送给后台接受任务
};

storyList[200068] =
{

	TaskName = '提升等级到61级',
	TaskInfo = '将等级提升到61级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >按照安排后面会有很多硬仗要打，你去提升到61级才能更好的完成任务。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >好了，开始进军吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >遵命。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2067},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 61,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,464},	-- 发送给后台接受任务
};

storyList[100464] =
{

	TaskName = '最后决战(三)',
	TaskInfo = '拼死决战，一定要获得最后的胜利',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >前面这种敌人盔甲厚重，你冲阵时要小心。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >多谢关心。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >呼呼，还有最后一批。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >武成王先休息一下，交给我吧。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2068},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_077", 20 ,{10,118,142}},
	},
	AutoFindWay = { true,  Position={10,118,142}},
	task = {2,69},	-- 发送给后台接受任务
};

storyList[200069] =
{

	TaskName = '提升等级到62级',
	TaskInfo = '将等级提升到62级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >这最后一批也是最强的部队，你还是提升到62级为好。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >我果然没看错人，你有了很大的提升。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >武王盛赞了，我们继续任务吧。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1464},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 62,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,465},	-- 发送给后台接受任务
};

storyList[100465] =
{

	TaskName = '最后决战(四)',
	TaskInfo = '拼死决战，一定要获得最后的胜利',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >这......好吧，后面就拜托你了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >请放心。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >终于结束了？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >结束了，我们胜利了。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2069},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_078", 30 ,{10,98,159}},
	},
	AutoFindWay = { true,  Position={10,98,159}},
	task = {2,70},	-- 发送给后台接受任务
};
storyList[200070] =
{

	TaskName = '提升等级到63级',
	TaskInfo = '将等级提升到63级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >虽然主战场上我们胜利了，但还有很多残兵需要消灭。你先去升级到63级。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >好了，现在开始打扫战场的任务。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1465},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 63,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,71},	-- 发送给后台接受任务
};
storyList[200071] =
{

	TaskName = '打扫战场（一）',
	TaskInfo = '消灭渭水的魔界残军。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >先从魔化将领开始。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >做的不错，还需要继续努力。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2070},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_075", 50 ,{10,107,115}},
	},
	AutoFindWay = { true,  Position={10,107,115}},
	task = {2,72},	-- 发送给后台接受任务
};

storyList[200072] =
{

	TaskName = '提升等级到64级',
	TaskInfo = '将等级提升到64级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >武王和丞相还在等待我们胜利的消息。你去提升到64级，才能更快消灭残军.</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >做的不错，我们马上开始下一步行动。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2071},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 64,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,73},	-- 发送给后台接受任务
};
storyList[200073] =
{

	TaskName = '打扫战场（二）',
	TaskInfo = '消灭渭水的魔界残军。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >现在去将魔界兽兵消灭掉。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >这样暂时应该没问题了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2072},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_076", 50 ,{10,89,132}},
	},
	AutoFindWay = { true,  Position={10,89,132}},
	task = {1,466},	-- 发送给后台接受任务
};
storyList[100466] =
{

	TaskName = '提升等级到65级',
	TaskInfo = '将等级提升到65级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >哈哈，终于胜利了，真是险胜啊。看你已精疲力尽，先休息一下吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >怎么样，恢复的如何？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >差不多了。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2073},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 65,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,467},	-- 发送给后台接受任务
};


storyList[100467] =
{

	TaskName = '传递捷报',
	TaskInfo = '讨伐再次失败，商朝已经无力阻止周国的崛起',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >好消息要赶紧回禀丞相知道，你先回去吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >我闻岐山有凤鸣之声，就知道有好消息。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >哈哈，我们已经大获全胜。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1466},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {2,74},	-- 发送给后台接受任务
};

storyList[200074] =
{

	TaskName = '提升等级到66级',
	TaskInfo = '将等级提升到66级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >虽然我们将商军的主力部队消灭了，但渭水还没有稳定，等你升到66级后有事安排你去做。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你来了，渭水还有不少的商朝残军，为了以后进军安全，需要你去消灭他们。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >请师傅吩咐。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1467},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 66,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,75},	-- 发送给后台接受任务
};
storyList[200075] =
{

	TaskName = '打扫战场（三）',
	TaskInfo = '消灭渭水上魔界残军。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >你去将魔界悍将消灭掉，然后去听黄飞虎的安排。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >我已收到丞相的命令，我们又可携手杀敌了，哈哈。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我也非常高兴。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2074},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_077", 50 ,{10,113,140}},
	},
	AutoFindWay = { true,  Position={10,113,140}},
	task = {2,76},	-- 发送给后台接受任务
};
storyList[200076] =
{

	TaskName = '提升等级到67级',
	TaskInfo = '将等级提升到67级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >为了更好的消灭残军，你去将等级提升到67吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >残军有集结的态势，必须阻止他们。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >要怎么做？</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2075},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 67,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,77},	-- 发送给后台接受任务
};
storyList[200077] =
{

	TaskName = '打扫战场（四）',
	TaskInfo = '消灭渭水上魔界残军。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >魔界鬼巫是组织者，去将他们消灭掉，就可以了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >这样暂时应该没问题了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2076},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_078", 50 ,{10,98,163}},
	},
	AutoFindWay = { true,  Position={10,98,163}},
	task = {2,78},	-- 发送给后台接受任务
};

storyList[200078] =
{

	TaskName = '提升等级到68级',
	TaskInfo = '将等级提升到68级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >虽然消灭了鬼巫，但残军还是集结了一大帮人，看来要消灭他们你必须达到68级。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >这些集结残军竟敢伏杀我们的运粮车队，实在可恶。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >怎么了？</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2077},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 68,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,79},	-- 发送给后台接受任务
};
storyList[200079] =
{

	TaskName = '打扫战场（五）',
	TaskInfo = '消灭渭水上魔界残军。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >魔界悍将带领一群兽兵伏杀了我们一队运粮车队，你去将他们消灭，为我们的士兵报仇。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >都是我轻敌才造成士兵的死伤啊。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >将军请勿自责。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2078},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_077", 50 ,{10,113,140}},
	},
	AutoFindWay = { true,  Position={10,113,140}},
	task = {2,80},	-- 发送给后台接受任务
};
storyList[200080] =
{

	TaskName = '提升等级到69级',
	TaskInfo = '将等级提升到69级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >现在不是消极的时候，还有大量的魔界兽兵，你提升到69后去将他们全部消灭掉。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >准备好了吗？。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >早就准备好了。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2079},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 69,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {2,81},	-- 发送给后台接受任务
};
storyList[200081] =
{

	TaskName = '打扫战场（六）',
	TaskInfo = '消灭渭水上魔界残军。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >那就去将魔界兽兵全部给我消灭掉。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >遵命。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >这样渭水就安全了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >是啊。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2080},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_076", 50 ,{10,80,131}},
	},
	AutoFindWay = { true,  Position={10,80,131}},
	task = {1,468},	-- 发送给后台接受任务
};

storyList[100468] =
{

	TaskName = '报喜武王',
	TaskInfo = '将胜利的喜讯报告给焦虑的武王殿下',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >呵呵，果然大气运是在我周国一方。你去将喜讯告诉武王殿下吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >战况如何了？本王每日坐立不安，却又要强做镇定，真是急死了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我们大获全胜，敌军完蛋了。</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2081},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,469},	-- 发送给后台接受任务
};
storyList[100469] =
{

	TaskName = '举国欢庆',
	TaskInfo = '周武王姬发下令举国欢庆七日，庆祝胜利',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >真的？哈哈，太好了，我要下令，举国欢庆七日，庆祝胜利。你可是第一功臣啊。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >不敢当。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >商朝已经是日落西山，周国的崛起已成大势。稍作休息，我们就要准备反攻商朝。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >这么快？</font>',

	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1468},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,470},	-- 发送给后台接受任务
};
storyList[100470] =
{

	TaskName = '提升等级到70级',
	TaskInfo = '将等级提升到70级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >此乃顺势而为，要抓紧机会。你也要抓紧机会提升等级到70级，伐商战役还需要你的力量。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >回来了，我军已经向牧野进军，你也前去帮忙吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我这就去。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1469},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 70,
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,500},	-- 发送给后台接受任务
};

--牧野任务
storyList[100500] =
{

	TaskName = '进军牧野',
	TaskInfo = '前往牧野，听候黄飞虎差遣。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >黄飞虎目前正有一见棘手的事需要你出力。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >纣王将奴隶派到前线来抵挡我军，他们都是可怜之人，我不忍心下令进攻。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >那如何是好。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1470},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,501},	-- 发送给后台接受任务
};
storyList[100501] =
{

	TaskName = '拯救奴隶',
	TaskInfo = '驱散奴隶，乘机找到控制他们的商朝监军。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >请你出手，将这些奴隶军驱散，然后跟踪他们找到控制他们的监军。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >交给我把。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >很好，这些奴隶四散逃窜，我立即派人跟踪他们。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >静候佳音。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1500},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_127", 50 ,{12,26,220}},
	},
	AutoFindWay = { true,  Position={12,26,220}},
	task = {1,502},	-- 发送给后台接受任务
};
storyList[100502] =
{

	TaskName = '拯救奴隶（二）',
	TaskInfo = '击杀监军，解救奴隶。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >已经找到监军的所在地，请你去他们击杀，解救这些可怜的奴隶吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我这就去。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >很好，这样我们就可以继续进军了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >祝将军逢战必胜。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1501},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_128", 50 ,{12,14,170}},
	},
	AutoFindWay = { true,  Position={12,14,170}},
	task = {1,503},	-- 发送给后台接受任务
};
storyList[100503] =
{

	TaskName = '提升等级到71级',
	TaskInfo = '将等级提升到71级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >我要考虑一下以后的进军计划，你也去将等级提升到71级吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你来了，有个人想见你。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >是谁？</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1502},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 71,
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,504},	-- 发送给后台接受任务
};

storyList[100504] =
{

	TaskName = '见面',
	TaskInfo = '与奴隶头领见面。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >是被我们救回来的一个奴隶，好像是他们推选出来的头领。说有重要的事只能告诉救命恩人。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >那我去见见他吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >恩人，多谢你救了我们，但我们还是活不了多久。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >为什么？</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1503},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,505},	-- 发送给后台接受任务
};
storyList[100505] =
{

	TaskName = '中毒',
	TaskInfo = '奴隶们都中毒了，想办法帮他们解毒。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >商纣为了控制我们，给我们下了毒，没有解药就活不了多久。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >放心吧，我会帮你们解毒的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你有什么事吗？如果没事就别打扰我救人。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >事情是这样的……</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1504},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,506},	-- 发送给后台接受任务
};
storyList[100506] =
{

	TaskName = '毒药配方',
	TaskInfo = '击杀炼药师，获得毒药的配方。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >他们中的毒很奇特，如果没有配方我解不了。你想办法把配方给我找来吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我这就去。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >做的不错，我这就去研究一下。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1505},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_129", 50 ,{12,20,135},"毒药配方"},
	},
	AutoFindWay = { true,  Position={12,20,135}},
	task = {1,507},	-- 发送给后台接受任务
};
storyList[100507] =
{

	TaskName = '临时解药',
	TaskInfo = '击杀监军获得临时解药。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >为了避免研制解药期间，奴隶们毒发身亡，你先去监军身上弄点临时解药给奴隶们送过去吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我这就去。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >非常感谢，这样我和兄弟们就可以多撑一段时间。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1506},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_128", 50 ,{12,23,179},"临时解药"},
	},
	AutoFindWay = { true,  Position={12,23,179}},
	task = {1,508},	-- 发送给后台接受任务
};
storyList[100508] =
{

	TaskName = '采集蕴灵草',
	TaskInfo = '帮随军医师采集制作解药的蕴灵草。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >我曾偷听过炼药师对话，解药成分中最重要的就是蕴灵草和魔化珍珠。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >哦，我马上去采集。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >快把蕴灵草给我。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1507},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10001,1,{3,58,155,100001}}},
	},
	AutoFindWay = {true,Collection={3,58,155,100001}},
	task = {1,509},	-- 发送给后台接受任务
};
storyList[100509] =
{

	TaskName = '采集魔化珍珠',
	TaskInfo = '帮随军医师采集制作解药的魔化珍珠。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >好，这样就差魔化珍珠，快去采集回来。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我马上就去。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >好，我马上就制作完整的解药，你稍等一会。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1508},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10006,1,{10,55,153,100015}}},
	},
	AutoFindWay = {true,Collection={10,55,153,100015}},
	task = {1,510},	-- 发送给后台接受任务
};
storyList[100510] =
{

	TaskName = '完整解药',
	TaskInfo = '将完整的解药交给奴隶头领',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >解药制作好了，你快给奴隶们送过去吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >非常感谢。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >恩人，我等性命是你所救，请受我等一拜。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >快起来，这也不是我一人的功劳。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1509},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,511},	-- 发送给后台接受任务
};
storyList[100511] =
{

	TaskName = '失踪的奴隶',
	TaskInfo = '有一部分奴隶被带走了，你需要去找到他们。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >恩人，我们还有一部分兄弟之前被带走了，你能不能也救救他们。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >交给我吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >长话短说，不要将我暴露了，不然以后就不好打探消息了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >你知道被带走的奴隶去哪里了吗？</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1510},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,512},	-- 发送给后台接受任务
};
storyList[100512] =
{

	TaskName = '提升等级到72级',
	TaskInfo = '将等级提升到72级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >他们啊！真可怜。我怕你承受不了，你去将等级提升到72级后我才会告诉你。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >他们被带去给妖术师做魔化实验了，被摧残的不成人形。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >可恶。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1511},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 72,
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,513},	-- 发送给后台接受任务
};
storyList[100513] =
{

	TaskName = '噩耗',
	TaskInfo = '将噩耗带给奴隶头领。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >就连人性都失去了，见人就杀。唉，可怜啊！</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我该如何对奴隶头领说呢。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >恩人，他们怎么样了？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >唉，是这样的……</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1512},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,514},	-- 发送给后台接受任务
};
storyList[100514] =
{

	TaskName = '解脱',
	TaskInfo = '魔化的奴隶继续活着也是痛苦，帮他们解脱吧！',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >兄弟们啊，为什么会这样？请恩人帮他们解脱吧，免得他们继续痛苦。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >交给我把。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >恩人，他们都去了吗？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >是的。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1513},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_130", 50 ,{12,15,102}},
	},
	AutoFindWay = { true,  Position={12,15,102}},
	task = {1,515},	-- 发送给后台接受任务
};
storyList[100515] =
{

	TaskName = '报仇',
	TaskInfo = '帮奴隶们报仇，先从炼药师开始。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >炼药师也是罪魁祸首之一，我无力报仇，只有麻烦恩人了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >交给我把。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >多谢恩人！</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >举手之劳。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1514},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_129", 50 ,{12,25,149}},
	},
	AutoFindWay = { true,  Position={12,25,149}},
	task = {1,516},	-- 发送给后台接受任务
};
storyList[100516] =
{

	TaskName = '回见黄飞虎',
	TaskInfo = '奴隶的问题已经解决，向黄飞虎报告。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >不能让兄弟们暴尸荒野，恩人有事就先去忙吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >也好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >我见奴隶都退走了，是否都解决了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >一言难尽啊。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1515},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,517},	-- 发送给后台接受任务
};
storyList[100517] =
{

	TaskName = '报告军情',
	TaskInfo = '将牧野发生的事情向姜子牙汇报。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >如此丧尽天良之事都可作出，真是天理不容。你先回去将发生的事向军师汇报一下。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >徒儿，怎么情绪如此低落？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >为什么受苦的总是百姓。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1516},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,518},	-- 发送给后台接受任务
};
storyList[100518] =
{

	TaskName = '提升等级到73级',
	TaskInfo = '将等级提升到73级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >兴，百姓苦；亡，百姓亦苦。你既心情不好，就先休息一下，将等级提升到73级。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >徒儿，恢复的怎么样了？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >师傅，我已没有问题。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1517},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 73,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,519},	-- 发送给后台接受任务
};
storyList[100519] =
{

	TaskName = '再临战场',
	TaskInfo = '得知妖术师的情报，立即前往战场。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >前方来报，已经发现妖术师的所在地，你去将之击杀，为哪些奴隶报仇吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我马上就去。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你来了，虽然知道妖术师在那里，但想击杀她们并不容易。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >怎么了？</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1518},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,520},	-- 发送给后台接受任务
};
storyList[100520] =
{

	TaskName = '前线阵地',
	TaskInfo = '找到先锋官，询问情报。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >你直接去问前锋官吧，他知道的更详细一些。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的，我这就去。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >妖术师就在前方的祭坛附近，但她们被各种机关傀儡保护着。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >能绕过去吗？</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1519},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,521},	-- 发送给后台接受任务
};
storyList[100521] =
{

	TaskName = '木精傀儡',
	TaskInfo = '为了消灭妖术师，就必须冲破傀儡的阻碍，先消灭木精傀儡。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >不行，只能强行突破，你先去将第一阵的木精傀儡消灭掉。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >交给我把。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >很好，那我们继续下一个目标。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >是什么？</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1520},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_131", 50 ,{12,57,220}},
	},
	AutoFindWay = { true,  Position={12,57,220}},
	task = {1,522},	-- 发送给后台接受任务
};
storyList[100522] =
{

	TaskName = '刀兵傀儡',
	TaskInfo = '将保护妖术师的刀兵傀儡消灭掉。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >守卫第二阵的刀兵傀儡，消灭他们我们就离妖术师更近一步。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >交给我把。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >好，只要在消灭最后一阵的傀儡就可以找到妖术师了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >那还等什么。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1521},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_132", 50 ,{12,91,224}},
	},
	AutoFindWay = { true,  Position={12,91,224}},
	task = {1,523},	-- 发送给后台接受任务
};
storyList[100523] =
{

	TaskName = '青铜傀儡',
	TaskInfo = '将保护妖术师的青铜傀儡消灭掉。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >最后一阵的守卫是青铜傀儡，请小心。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >放心吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >这样前方的道路就打通了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >妖术师我来了。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1522},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_133", 50 ,{12,72,184}},
	},
	AutoFindWay = { true,  Position={12,72,184}},
	task = {1,524},	-- 发送给后台接受任务
};
storyList[100524] =
{

	TaskName = '提升等级到74级',
	TaskInfo = '将等级提升到74级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >为了更有把握消灭妖术师，你最好将等级提升到74级后再去。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >出事了，怎么会这样？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >出什么事了？</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1523},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 74,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,525},	-- 发送给后台接受任务
};
storyList[100525] =
{

	TaskName = '复活的傀儡',
	TaskInfo = '如果不消灭傀儡师，傀儡就会无限复活。请杨戬帮忙找到傀儡师。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >消灭的傀儡全都复活了，如果不找到傀儡师，之前所做都将白费。你去请杨戬帮忙找到傀儡师。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >如此着急，有什么事吗？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >有要事请师兄帮忙。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1524},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,526},	-- 发送给后台接受任务
};
storyList[100526] =
{

	TaskName = '傀儡之心（一）',
	TaskInfo = '通过傀儡身上的傀儡石来找到傀儡师。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >傀儡师用妖法屏蔽了查看，但他们是通过傀儡石来控制傀儡的。只要获得足够的傀儡石就可反向找到他们。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我马上就去。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >将得到的傀儡石先交给我吧，我派人去给杨戬送去。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1525},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_131", 50 ,{12,54,225},"木精傀儡石"},
	},
	AutoFindWay = { true,  Position={12,54,225}},
	task = {1,527},	-- 发送给后台接受任务
};
storyList[100527] =
{

	TaskName = '傀儡之心（二）',
	TaskInfo = '傀儡石不足，还需要其他的傀儡石。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >杨戬传来消息说，只是木牛的傀儡石还不够，还需要更多的傀儡石。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >那我再去弄些刀兵的傀儡石。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >交给我吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1526},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_132", 50 ,{12,89,213},"刀兵傀儡石"},
	},
	AutoFindWay = { true,  Position={12,89,213}},
	task = {1,528},	-- 发送给后台接受任务
};
storyList[100528] =
{

	TaskName = '傀儡之心（三）',
	TaskInfo = '傀儡石不足，还需要其他的傀儡石。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >只要再有青铜傀儡的傀儡石就可以找到傀儡师了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我这就去。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >很好，快将傀儡石给我。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >都在这里了。</font>',--见杨戬
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1527},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_133", 50 ,{12,68,184},"青铜傀儡石"},
	},
	AutoFindWay = { true,  Position={12,68,184}},
	task = {1,529},	-- 发送给后台接受任务
};
storyList[100529] =
{

	TaskName = '提升等级到75级',
	TaskInfo = '将等级提升到75级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >已经找到傀儡师，但他们非常强大，你还是将等级提升到75级再去吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >回来了啊，不错，能力提升了很多。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >师兄过奖了。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1528},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 75,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,530},	-- 发送给后台接受任务
};
storyList[100530] =
{

	TaskName = '傀儡师',
	TaskInfo = '将傀儡师消灭掉，打通与妖术师之间的通路。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >傀儡师还没有意识到自己的位置已经暴露，你现在就去将他们消灭吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我马上就去。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >太好了，这样我们就可以向妖术师发动进攻了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >那马上出发吧。</font>',--见前锋官
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1529},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_134", 50 ,{12,113,231}},
	},
	AutoFindWay = { true,  Position={12,113,231}},
	task = {1,531},	-- 发送给后台接受任务
};
storyList[100531] =
{

	TaskName = '黑狗血',
	TaskInfo = '去渭水农夫那里要黑狗血来破除妖术师的护罩。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >可恶，居然有护罩。黑狗血应该可以破除，你去渭水农夫那里要一些来。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我马上就去。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >官爷，来此有何事。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >可有黑狗血。</font>',--见农夫
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1530},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,532},	-- 发送给后台接受任务
};
storyList[100532] =
{

	TaskName = '再临陈塘',
	TaskInfo = '农夫将黑狗血卖给了陈塘关的酒楼老板。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >都卖给陈塘关的酒楼老板了，说是用来去去之前的晦气。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >打扰了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >客官，您是吃饭还是住店呢？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我是来找黑狗血的。</font>',--见陈塘官酒店老板
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1531},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,533},	-- 发送给后台接受任务
};
storyList[100533] =
{

	TaskName = '花之心',
	TaskInfo = '用食人花的花心与酒店老板换黑狗血。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >黑狗血是我花了钱的，不能平白给你。听说牧野有种食人花的花心可酿美酒，你用花心来交换吧！</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >将花心交给我吧，你先休息一下。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',--见前锋官
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1532},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_135", 50 ,{12,98,141},"花心"},
	},
	AutoFindWay = { true,  Position={12,98,141}},
	task = {1,534},	-- 发送给后台接受任务
};
storyList[100534] =
{

	TaskName = '提升等级到76级',
	TaskInfo = '将等级提升到76级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >黑狗血拿来了，但你最好将等级提升到76级再去消灭妖术师。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >这样应该就没有问题了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我也这么觉得。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1533},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 76,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,535},	-- 发送给后台接受任务
};
storyList[100535] =
{

	TaskName = '妖术师',
	TaskInfo = '将妖术师消灭掉。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >现在去将妖术师消灭吧，为受难的奴隶们报仇。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >这下我们在牧野战场上就将占据主动。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >是啊。</font>',--见前锋官
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1534},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_136", 50 ,{12,119,168}},
	},
	AutoFindWay = { true,  Position={12,119,168}},
	task = {1,536},	-- 发送给后台接受任务
};
storyList[100536] =
{

	TaskName = '打扫战场（一）',
	TaskInfo = '为了没有后顾之忧，将青铜傀儡全部消灭掉。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >但青铜傀儡和傀儡师还有残余，我们必须将他们全部消灭，去除后顾之忧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我先去将青铜傀儡清除。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >做的不错。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >过奖。</font>',--见前锋官
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1535},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_133", 50 ,{12,92,179}},
	},
	AutoFindWay = { true,  Position={12,92,179}},
	task = {1,537},	-- 发送给后台接受任务
};
storyList[100537] =
{

	TaskName = '打扫战场（二）',
	TaskInfo = '为了没有后顾之忧，将傀儡师全部消灭掉。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >傀儡师不除，他们就能源源不断的制造各种傀儡，所以他们留不得。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >交给我吧</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >做的不错。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >过奖。</font>',--见前锋官
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1536},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_134", 50 ,{12,115,212}},
	},
	AutoFindWay = { true,  Position={12,115,212}},
	task = {1,538},	-- 发送给后台接受任务
};
storyList[100538] =
{

	TaskName = '再见武王',
	TaskInfo = '将牧野的战事想武王禀报，并询问后续计划。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >你先回西岐，将这里的情况向武王殿下汇报一下，看看有什么新的安排没有。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你回来，多亏你的活跃，才保证了牧野战事的顺利。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >这是我应做的。</font>',--见武王
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1537},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,539},	-- 发送给后台接受任务
};
storyList[100539] =
{

	TaskName = '提升等级到77级',
	TaskInfo = '将等级提升到77级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >后面的进攻计划还在制定中，你可乘机去将等级提升到77级。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >这个节骨眼上，怎么会出这种事。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >怎么了？</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1538},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 77,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,540},	-- 发送给后台接受任务
};
storyList[100540] =
{

	TaskName = '子牙昏迷',
	TaskInfo = '姜子牙突然昏迷，想办法救治。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >你的师父突然昏迷，怎么也唤不醒，全军也不得不原地驻扎。一定要尽快救醒你师父。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我去问问杨戬师兄。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >我查看过师叔了，完全找不到师叔昏迷的原因。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >那该如何是好。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1539},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,541},	-- 发送给后台接受任务
};
storyList[100541] =
{

	TaskName = '求助太乙',
	TaskInfo = '向太乙真人求助，希望他能救治姜子牙。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >别慌，太乙真人法力高深，应该有方法救治师叔。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我就去找太乙真人。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >子牙命中有此一劫啊。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >此劫该如何破除。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1540},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,542},	-- 发送给后台接受任务
};
storyList[100542] =
{

	TaskName = '昏迷原因',
	TaskInfo = '向太乙真人求助，希望他能救治姜子牙。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >子牙是被申公豹的砍头飞升邪术虏去二魂六魄才昏迷的，如不找回被虏去魂魄是不会苏醒的。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >那要到哪里去找。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >很难，子牙的魂魄被申公豹用来召唤魔界军队，不消灭魔界军队就不能取回魂魄。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >那我马上就去消灭他们。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1541},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,543},	-- 发送给后台接受任务
};
storyList[100543] =
{

	TaskName = '提升等级到78级',
	TaskInfo = '将等级提升到78级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >别慌，我已命金吒在牧野布聚魂之阵。布阵期间你去将等级提升到78级，以便更好的消灭魔界军队。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >遵命。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你来了，我已布好聚魂阵，只要你消灭魔界军队，师叔的魂魄自然会回到阵中。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',--见金吒
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1542},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 78,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,544},	-- 发送给后台接受任务
};
storyList[100544] =
{

	TaskName = '收集魂魄（一）',
	TaskInfo = '消灭魔界的魔狼部队。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >先消灭足够的魔狼部队，将师叔其中魂魄找回来一部分。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >做的不错。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >过奖。</font>',--见前锋官
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1543},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_137", 50 ,{12,69,162}},
	},
	AutoFindWay = { true,  Position={12,69,162}},
	task = {1,545},	-- 发送给后台接受任务
};
storyList[100545] =
{

	TaskName = '收集魂魄（二）',
	TaskInfo = '消灭魔界的鱼妖部队。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >这次是鱼妖，要小心一些。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >做的不错。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >过奖。</font>',--见前锋官
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1544},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_138", 50 ,{12,58,130}},
	},
	AutoFindWay = { true,  Position={12,58,130}},
	task = {1,546},	-- 发送给后台接受任务
};
storyList[100546] =
{

	TaskName = '提升等级到79级',
	TaskInfo = '将等级提升到79级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >已经将师叔的魂魄以找回一半，我需要修补一下阵法。你先去将等级升到79级为之后做准备。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >阵法已经修补完毕，我们继续。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1545},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 79,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,547},	-- 发送给后台接受任务
};
storyList[100547] =
{

	TaskName = '收集魂魄（三）',
	TaskInfo = '消灭魔界的魔甲兵部队。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >这次是魔甲兵，它们的防御力很强。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >做的不错，我们更进了一步。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >过奖。</font>',--见前锋官
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1546},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_139", 50 ,{12,34,100}},
	},
	AutoFindWay = { true,  Position={12,34,100}},
	task = {1,548},	-- 发送给后台接受任务
};
storyList[100548] =
{

	TaskName = '收集魂魄（四）',
	TaskInfo = '消灭魔界的魔灵部队。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >这次是魔灵，他们的攻击防不胜防。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >这下师叔的魂魄都找回来了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >太好了。</font>',--见前锋官
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1547},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_141", 50 ,{12,16,71}},
	},
	AutoFindWay = { true,  Position={12,16,71}},
	task = {1,549},	-- 发送给后台接受任务
};
storyList[100549] =
{

	TaskName = '子牙复苏',
	TaskInfo = '将姜子牙的魂魄送回去。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >这就是姜师叔被虏去的魂魄，你快护送回去吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >徒儿，这次多亏你，为师才能保住性命。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >师傅，这是我该做的。</font>',--见姜子牙
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1548},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,550},	-- 发送给后台接受任务
};
storyList[100550] =
{

	TaskName = "提升等级到80级",
	TaskInfo = "将等级提升到80级",
	AcceptInfo = "\t<font color='#e6dfcf' >可恶的申公豹以邪术害我，你去将等级提升到80后，替为师报仇。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >我军已经开始全面强攻，你也尽快过去帮忙。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >知道了。</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1549},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 80,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,551},	-- 发送给后台接受任务
};
storyList[100551] =
{

	TaskName = '全面进攻',
	TaskInfo = '去牧野听从黄飞虎的安排。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >攻入城门的部队遭到了魔界军队的强力抵抗，你去牧野听从黄飞虎的安排。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >知道了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你回来的正好，现在正是你出力的时候。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >请吩咐。</font>',--见黄飞虎
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1550},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,552},	-- 发送给后台接受任务
};
storyList[100552] =
{

	TaskName = '城门争夺（一）',
	TaskInfo = '消灭防守城门的幽魂，将城门掌握在我军手中。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >我军的主要目标是夺下城门，但防守城门的幽魂非常难缠，普通士兵更本伤害不到它们，只有靠你了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >放心吧。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >很好，这样城门就落入我手。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >是的。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1551},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_140", 50 ,{12,75,62}},
	},
	AutoFindWay = { true,  Position={12,75,62}},
	task = {1,553},	-- 发送给后台接受任务
};
storyList[100553] =
{

	TaskName = '城门争夺（二）',
	TaskInfo = '击退前来夺回城门的炎魔。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >前方来报，魔界的炎魔部队想夺回城门，你必须阻止它们。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我这就去。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >还不能松懈，我们一定要将城门守住，后方部队才能继续进攻。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >一起努力。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1552},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_142", 50 ,{12,40,25}},
	},
	AutoFindWay = { true,  Position={12,40,25}},
	task = {1,554},	-- 发送给后台接受任务
};
storyList[100554] =
{

	TaskName = '城门争夺（三）',
	TaskInfo = '阻止冰魔使用法术封堵城门。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >情报显示，魔军的冰魔正在释放大型法术，准备冰封城门，你要尽快破坏它们施法。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我这就去。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你果然不负众望。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >这没什么。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1553},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_143", 50 ,{12,81,29}},
	},
	AutoFindWay = { true,  Position={12,81,29}},
	task = {1,555},	-- 发送给后台接受任务
};
storyList[100555] =
{

	TaskName = '城门争夺（四）',
	TaskInfo = '胜利就在眼前，消灭最后的魔界军队吧。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >只要将最后的魔将解决掉，城门就完全掌握在我们手中。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >轻松搞定。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >这样进攻朝歌的道路就打通了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >太好了。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1554},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_144", 50 ,{12,112,63}},
	},
	AutoFindWay = { true,  Position={12,112,63}},
	task = {1,556},	-- 发送给后台接受任务
};
storyList[100556] =
{

	TaskName = '提升等级到81级',
	TaskInfo = '将等级提升到81级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >申公豹在点将台处布下护罩，暂时无法攻破。这期间你去将等级升到81，我来想想办法。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >申公豹在护罩的保护下，似乎正在召唤强大的魔物，我们必须阻止他。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >但要怎么攻破护罩呢？</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1555},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 81,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,557},	-- 发送给后台接受任务
};
storyList[100557] =
{

	TaskName = '破除护罩（一）',
	TaskInfo = '协助金吒破除护罩。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >这护罩是用魔物的精气维持，只要将牧野上的魔物清除掉就不攻自破。金吒正在做这事，你去帮他。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >你来了，我们比比谁杀的快。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >有何不可。</font>',--见金吒
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1556},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,558},	-- 发送给后台接受任务
};
storyList[100558] =
{

	TaskName = '破除护罩（二）',
	TaskInfo = '为破除护罩，将牧野上的魔物都清除掉吧。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >首先是魔界食人花。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好的。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >嘿嘿，这次我要杀的多一些。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >再来比一次。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1557},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_135", 50 ,{12,87,131}},
	},
	AutoFindWay = { true,  Position={12,87,131}},
	task = {1,559},	-- 发送给后台接受任务
};
storyList[100559] =
{

	TaskName = '破除护罩（三）',
	TaskInfo = '为破除护罩，将牧野上的魔物都清除掉吧。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >还不服啊，那这次用魔狼来比比。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >来就来。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >还是我要多一些，这次该服了吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >哼。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1558},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_137", 50 ,{12,63,144}},
	},
	AutoFindWay = { true,  Position={12,63,144}},
	task = {1,560},	-- 发送给后台接受任务
};
storyList[100560] =
{

	TaskName = '破除护罩（四）',
	TaskInfo = '为破除护罩，将牧野上的魔物都清除掉吧。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >还不服啊，这次的目标是鱼妖。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我先出发了。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >还是我多，你还的练练。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >可恶。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1559},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_138", 50 ,{12,71,118}},
	},
	AutoFindWay = { true,  Position={12,71,118}},
	task = {1,561},	-- 发送给后台接受任务
};

storyList[100561] =
{

	TaskName = '提升等级到82级',
	TaskInfo = '将等级提升到82级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >别生气嘛，最多下次我让让你。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >不用，我先去提升到82级再来比过。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >哦，能力提升不少嘛，看来我也不能掉以轻心。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >这次我一定赢。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1560},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 82,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,562},	-- 发送给后台接受任务
};

storyList[100562] =
{

	TaskName = '破除护罩（五）',
	TaskInfo = '为破除护罩，将牧野上的魔物都清除掉吧。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >我们再比谁杀的魔甲兵多。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >恩，这次比我多十个，怎么可能！</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >这下知道我的厉害了吧。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1561},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_139", 50 ,{12,42,89}},
	},
	AutoFindWay = { true,  Position={12,42,89}},
	task = {1,563},	-- 发送给后台接受任务
};
storyList[100563] =
{

	TaskName = '破除护罩（六）',
	TaskInfo = '为破除护罩，将牧野上的魔物都清除掉吧。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >之前我未出全力，这次再用魔灵比过。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >数量比我多了三层，你怎么变得这么厉害！</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >等级提升的好处。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1562},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_141", 50 ,{12,24,65}},
	},
	AutoFindWay = { true,  Position={12,24,65}},
	task = {1,564},	-- 发送给后台接受任务
};
storyList[100564] =
{

	TaskName = '破除护罩（七）',
	TaskInfo = '为破除护罩，将牧野上的魔物都清除掉吧。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >我们再用幽魂试试。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >还是比我多，你用了什么法宝？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >本身的实力。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1563},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_140", 50 ,{12,87,44}},
	},
	AutoFindWay = { true,  Position={12,87,44}},
	task = {1,565},	-- 发送给后台接受任务
};
storyList[100565] =
{

	TaskName = '提升等级到83级',
	TaskInfo = '将等级提升到83级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >我也去提升一下，待会再来比比。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我也得快点提升到83级，决不能输。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >这次我提升了不少，这下看谁能赢。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我也有提升哦。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1564},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 83,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,566},	-- 发送给后台接受任务
};

storyList[100566] =
{

	TaskName = '破除护罩（八）',
	TaskInfo = '为破除护罩，将牧野上的魔物都清除掉吧。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >你一定是用了强力的法宝，这次我也用，看谁厉害。目标就定炎魔好了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >无所谓。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >这次打平，还要比吗？</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >当然，必须决出最后的胜负。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1565},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_142", 50 ,{12,56,40}},
	},
	AutoFindWay = { true,  Position={12,56,40}},
	task = {1,567},	-- 发送给后台接受任务
};
storyList[100567] =
{

	TaskName = '破除护罩（九）',
	TaskInfo = '为破除护罩，将牧野上的魔物都清除掉吧。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >好，这次的目标是冰魔，我一定赢你。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >这可不好说。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >又打平了，看来我们实力相当啊。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >不到最后，谁都说不准。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1566},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_143", 50 ,{12,96,20}},
	},
	AutoFindWay = { true,  Position={12,96,20}},
	task = {1,568},	-- 发送给后台接受任务
};
storyList[100568] =
{

	TaskName = '破除护罩（十）',
	TaskInfo = '为破除护罩，将牧野上的魔物都清除掉吧。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >用最后的魔将来定胜负。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >一定奉陪。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >这次是你多，你赢了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >师兄，承让了。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1567},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_144", 50 ,{12,111,96}},
	},
	AutoFindWay = { true,  Position={12,111,96}},
	task = {1,569},	-- 发送给后台接受任务
};
storyList[100569] =
{

	TaskName = '回见黄飞虎',
	TaskInfo = '转告黄飞虎，点将台的护罩已经破除。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >魔物都消灭掉了，点将台上的护罩也已经破除，你去向黄飞虎将军报告吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >告辞。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >做的不错，这下看申公豹还怎么跑。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我一定要为师傅报仇。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1568},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,570},	-- 发送给后台接受任务
};
storyList[100570] =
{

	TaskName = '提升等级到84级',
	TaskInfo = '将等级提升到84级',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >申公豹太厉害了，接近点将台的士兵都被他杀了，你还是将等级提升到84级再去对付他。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >也好。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >这下应该没有问题了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >是的。</font>',
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1569},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		level = 84,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,571},	-- 发送给后台接受任务
};
storyList[100571] =
{

	TaskName = "申公豹",
	TaskInfo = "找到申公豹，准备决战。",
	AcceptInfo = "\t<font color='#e6dfcf' >申公豹已经被围在点将台，剩下的就靠你了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >放心吧。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >没想到，我会被逼到如此境地。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >申公豹，是算账的时候了。</font>",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1570},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,572},	-- 发送给后台接受任务
};

storyList[100572] =
{

	TaskName = '牧野欢歌',
	TaskInfo = '申公豹逃跑，也代表着牧野之战胜利结束。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >哼，就凭你还留不住我。回去告诉姜子牙，我不会这么轻易罢休的</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >胆小鬼，别跑。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >虽然没有抓到申公豹很可惜，但这样牧野之战就胜利了，全军欢呼吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >太好了。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1571},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,573},	-- 发送给后台接受任务
};


storyList[100573] =
{

	TaskName = '胜利消息',
	TaskInfo = '将牧野之战的胜利消息告诉姜子牙。',
	AcceptInfo = '\t<font color=\'#e6dfcf\' >全军需要休整一下，你去将胜利的消息告诉军师吧。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >我这就去。</font>',
	SubmitInfo = '\t<font color=\'#e6dfcf\' >看你满面喜意，就知道牧野之战已经胜利了。</font>\n\n<font color=\'#f8ee73\' ><b>我:</b></font><font color=\'#6cd763\' >是的，师傅。</font>',
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1572},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,574},	-- 发送给后台接受任务
};

storyList[100574] = {
	TaskName = "提升等级到85级",
	--TaskTrack = {1004,5,27},
	TaskInfo = "将等级提升到85级",
	AcceptInfo = "\t<font color='#e6dfcf' >现在还不是高兴的时候，不攻下朝歌就不是最后的胜利。为了以后的战斗，你去将等级提升到85级。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >遵命。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >在总攻朝歌之前，为师需要你铲除牧野余孽，以绝后患。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是，师傅。</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
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
	TaskName = "调查魔物（一）",
	--TaskTrack = {1004,5,27},
	TaskInfo = "前往牧野协助金吒调查魔物。",
	AcceptInfo = "<font color='#e6dfcf' >前方来报，近日牧野似有魔物复苏迹象，金吒正在调查，你去帮助他。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "<font color='#e6dfcf' >附近魔物不知为何死灰复燃，你能否助我一臂之力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >没问题。</font>",
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
	TaskName = "调查魔物（二）",
	--TaskTrack = {1004,5,27},
	TaskInfo = "调查食人花寻找线索",
	AcceptInfo = "\t<font color='#e6dfcf' >首先前去调查食人花精，不知能否找到线索。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >可有发现？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好像与魔狼有关。</font>",
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
	TaskName = "调查魔物（三）",
	--TaskTrack = {1004,5,27},
	TaskInfo = "调查魔狼寻找线索",
	AcceptInfo = "\t<font color='#e6dfcf' >好吧，前去调查魔狼。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >怎么样？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >发现有鱼妖作祟的迹象。</font>",
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
	TaskName = "提升等级到86级",
	--TaskTrack = {1004,5,27},
	TaskInfo = "将等级提升到86",
	AcceptInfo = "\t<font color='#e6dfcf' >接下来我来调查。这段期间你将等级提升到86级。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >鱼妖在摄取魔灵和魔甲兵的魂魄，不管什么原因我们必须阻止他。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >交给我吧。</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
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
	TaskName = "调查魔物（四）",
	--TaskTrack = {1004,5,27},
	TaskInfo = "消灭魔甲兵，破坏鱼妖计划",
	AcceptInfo = "\t<font color='#e6dfcf' >杀光魔灵和魔甲兵切断鱼妖摄取灵魂的来源。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我先去消灭魔甲兵。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >怎么样？还顺利么？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >还好。</font>",
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
	TaskName = "调查魔物（五）",
	--TaskTrack = {1004,5,27},
	TaskInfo = "消灭魔灵，破坏鱼妖计划",
	AcceptInfo = "\t<font color='#e6dfcf' >接下来是魔灵。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >交给我吧。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >不可大意。我们还不知道鱼妖摄取灵魂的真正目的。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >说的是。</font>",
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
	TaskName = "调查魔物（六）",
	--TaskTrack = {1004,5,27},
	TaskInfo = "消灭鱼妖",
	AcceptInfo = "\t<font color='#e6dfcf' >鱼妖不除后患无穷，交给你了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >放心。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >大侠饶命，小的再不敢了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >给我一个不杀你的理由。</font>",
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
	TaskName = "调查魔物（七）",
	--TaskTrack = {1004,5,27},
	TaskInfo = "通过鱼妖，得知幕后主使是幽魂",
	AcceptInfo = "\t<font color='#e6dfcf' >小的为幽魂所迫，为他们摄魂修炼法力，求大侠饶命。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >算了，我得马上告诉金吒，且饶你小命。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >幽魂残害生灵不能轻饶。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >没错。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1581},
	},
	ClientCompleteCondition = {},
	task = {1,583},
}
storyList[100583] = {
	TaskName = "提升等级到87级",
	--TaskTrack = {1004,5,27},
	TaskInfo = "将等级提升到87级",
	AcceptInfo = "\t<font color='#e6dfcf' >幽魂摄取魂魄后法力大增，为保万全，你先将等级提升到87级。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >知道了。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >你终于来了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >现在应该没问题了。</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
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
	TaskName = "清除后患（一）",
	--TaskTrack = {1004,5,27},
	TaskInfo = "消灭幽魂",
	AcceptInfo = "\t<font color='#e6dfcf' >幽魂就靠你了，杀光他们。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >摄取魂魄过后的幽魂果然厉害，即使魂飞魄散也能很快复原。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >那该如何是好。</font>",
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
	TaskName = "清除后患（二）",
	--TaskTrack = {1004,5,27},
	TaskInfo = "寻求姜子牙以找到彻底消灭幽魂的办法",
	AcceptInfo = "\t<font color='#e6dfcf' >你的师父手下能人辈出，他一定有办法。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我就去找师父。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >看你焦急的样子，牧野之事想必不顺吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是这样的。。。</font>",
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
	TaskName = "清除后患（三）",
	--TaskTrack = {1004,5,27},
	TaskInfo = "寻求李靖以找到彻底消灭幽魂的办法",
	AcceptInfo = "\t<font color='#e6dfcf' >徒儿别急，对付幽魂厉鬼李靖自有办法。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我这就去。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >摄人魂魄之事固然可恶，但也不能有勇无谋。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >说的是。</font>",
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
	TaskName = "提升等级到88级",
	--TaskTrack = {1004,5,27},
	TaskInfo = "将等级提升到88级",
	AcceptInfo = "\t<font color='#e6dfcf' >幽魂眷恋尘世不肯往生，我必须先派人找到其中症结才行。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >那我趁机把等级提升到88级。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >你回来了，正好有事要与你商量。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >请讲。</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
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
	TaskName = "清除后患（四）",
	--TaskTrack = {1004,5,10},
	TaskInfo = "回到牧野与金吒回合",
	AcceptInfo = "\t<font color='#e6dfcf' >金吒正在调查幽魂之事，你可前往牧野与他会合。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我这就去。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >幽魂生前原是当地村民，因被魔物所害，魂魄也被奴役，为他们报仇，让他们安息。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >交给我吧。</font>",
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
	TaskName = "清除后患（五）",
	--TaskTrack = {1004,5,10},
	TaskInfo = "消灭炎魔后金吒受伤",
	AcceptInfo = "\t<font color='#e6dfcf' >不可轻饶炎魔，前去教训他们。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >是我学艺不精，差点被炎魔烧成肉干了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >你不必自责。</font>",
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
	TaskName = "清除后患（六）",
	--TaskTrack = {1004,5,10},
	TaskInfo = "采集灵韵草为金吒疗伤",
	AcceptInfo = "\t<font color='#e6dfcf' >你能采集灵韵草帮我治愈灼伤吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >没问题，你忍着。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >相信以我的体质很快就能恢复的。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >额。。。</font>",
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
	TaskName = "提升等级到89级",
	--TaskTrack = {1004,5,10},
	TaskInfo = "将等级提升到89级",
	AcceptInfo = "\t<font color='#e6dfcf' >我们得吸取教训，努力提高自己实力，你也先将等级提升到89级。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >修炼的怎样了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >进步不小。</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
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
	TaskName = "清除后患（七）",
	--TaskTrack = {1004,5,10},
	TaskInfo = "采集珍珠果，制成抗冰药物",
	AcceptInfo = "\t<font color='#e6dfcf' >为免被冰魔冰冻技能所伤，采集魔化珍珠交与我制成抗冰药物。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >这样就不必担心冰魔威胁了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是的。</font>",
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
	TaskName = "清除后患（八）",
	--TaskTrack = {1004,5,10},
	TaskInfo = "消灭冰魔",
	AcceptInfo = "\t<font color='#e6dfcf' >消灭冰魔，不能让魔物祸害人间。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我们上。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >你果然厉害。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >过奖过奖。</font>",
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
	TaskName = "清除后患（九）",
	--TaskTrack = {1004,5,10},
	TaskInfo = "消灭魔将",
	AcceptInfo = "\t<font color='#e6dfcf' >最后前去消灭魔将，用他们的鲜血祭奠亡者的灵魂。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >相信这样能够平息亡者的怨气，我们尽力了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >没错，我们尽力了。</font>",
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
	TaskName = "提升等级到90级",
	--TaskTrack = {1004,5,10},
	TaskInfo = "将等级提升到90级",
	AcceptInfo = "\t<font color='#e6dfcf' >牧野已经安定，将等级提升到90级，做好进攻朝歌的准备。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >很好，这样你就可以担当更重要的任务了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >太好了。</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1594},
	},
	ClientCompleteCondition = {
		level = 90,
	},
	--AutoFindWay = {true,SubmitNPC = true},
	task = {1,596},	-- 发送给后台接受任务
}

--朝歌任务

storyList[100596] = {
	TaskName = "新的任务",
	--TaskTrack = {1004,5,10},
	TaskInfo = "姜子牙有新的任务交给你。",
	AcceptInfo = "\t<font color='#e6dfcf' >姜师叔已经制定了进攻朝歌计划，你去听他差遣吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我这就去。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >你来的正好，有个任务交给你。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >什么任务？</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1595},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,597},	-- 发送给后台接受任务
}
storyList[100597] = {
	TaskName = "潜入朝歌",
	--TaskTrack = {1004,5,10},
	TaskInfo = "去朝歌找到斥候小队。",
	AcceptInfo = "\t<font color='#e6dfcf' >我派了一只斥候小队前往朝歌，但他们已经很久没有消息传回，你秘密潜入朝歌去找到他们。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >你来了，可惜太晚了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >发生了什么事？</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1596},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,598},	-- 发送给后台接受任务
}
storyList[100598] = {
	TaskName = "寻人",
	--TaskTrack = {1004,5,10},
	TaskInfo = "找到斥候小队的队长。",
	AcceptInfo = "\t<font color='#e6dfcf' >我们小队一进入朝歌就迷失在阵法中，队长进去救其它兄弟了，请你一定要找到队长。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >放心吧。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >我的兄弟们啊，我一定会为你们报仇的。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >发生什么事了。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1597},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,600},	-- 发送给后台接受任务
}

storyList[100600] = {
	TaskName = "禀报姜子牙",
	--TaskTrack = {1004,5,10},
	TaskInfo = "返回西岐城，向姜子牙禀报。",
	AcceptInfo = "\t<font color='#e6dfcf' >朝歌已经被魔界占据，我们一进来就被法阵困住了，兄弟们都牺牲了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >没想到会是这样，快回去向师傅禀报</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >原来是这样，听你描述此阵法应该是五行迷魂阵，需先破除阵法后才能继续进军。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1598},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,601},	-- 发送给后台接受任务
}
storyList[100601] = {
	TaskName = "将等级提升到91级",
	--TaskTrack = {1004,5,10},
	TaskInfo = "将等级提升到91级。",
	AcceptInfo = "\t<font color='#e6dfcf' >破阵还需要做些准备，你先将等级提升到91，然后去朝歌找杨戬，听从他的吩咐。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >想要破阵，必须循序渐进。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >要如何做？</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1600},
	},
	ClientCompleteCondition = {
		level = 91,
	},
	task = {1,602},	-- 发送给后台接受任务
}
storyList[100602] = {
	TaskName = "破土阵",
	--TaskTrack = {1004,5,10},
	TaskInfo = "到牧野击杀傀儡师收集木之灵。",
	AcceptInfo = "\t<font color='#e6dfcf' >要想破除此五行迷魂阵，必先破除其中土阵，之后我方的进攻才会见效。但要破阵需要木之灵，快到牧野去杀傀儡师收集。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我立马就去。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >有了这些木之灵，就可破除敌人的土阵。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >太好了。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1601},
	},
	ClientCompleteCondition = {
		kill = { "M_134", 50 ,{12,115,212},"木之灵"},
	},
	AutoFindWay = { true,  Position={12,115,212}},
	task = {1,603},	-- 发送给后台接受任务
}
storyList[100603] = {
	TaskName = "破金阵",
	--TaskTrack = {1004,5,10},
	TaskInfo = "到牧野击杀炎魔收集火之灵。",
	AcceptInfo = "\t<font color='#e6dfcf' >土生金，土阵已破。金阵便可迎刃而解。但要破阵需要火之灵，快到牧野去杀炎魔收集。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我立马就去。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >干得好！有了这些火之灵，就可破除敌人的金阵。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >小菜一碟。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1602},
	},
	ClientCompleteCondition = {
		kill = { "M_142", 50 ,{12,56,40},"火之灵"},
	},
	AutoFindWay = { true,  Position={12,56,40}},
	task = {1,604},	-- 发送给后台接受任务
}
storyList[100604] = {
	TaskName = "破水阵",
	--TaskTrack = {1004,5,10},
	TaskInfo = "到牧野击杀魔甲兵收集土之灵。",
	AcceptInfo = "\t<font color='#e6dfcf' >金生水，水阵威力下降，快去牧野击杀魔甲兵收集土之灵，方可击破水阵。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我立马动身。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >干得好，水阵立马可破。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >要把敌人杀得片甲不留。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1603},
	},
	ClientCompleteCondition = {
		kill = { "M_139", 50 ,{12,42,89},"土之灵"},
	},
	AutoFindWay = { true,  Position={12,42,89}},
	task = {1,605},	-- 发送给后台接受任务
}
storyList[100605] = {
	TaskName = "将等级提升到92级",
	--TaskTrack = {1004,5,10},
	TaskInfo = "将等级提升到92级。",
	AcceptInfo = "\t<font color='#e6dfcf' >后面的战斗将更加艰难，你先将等级提升到92级。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >准备好了吗？我们继续杀敌。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >请吩咐。</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1604},
	},
	ClientCompleteCondition = {
		level = 92,
	},
	task = {1,606},	-- 发送给后台接受任务
}
storyList[100606] = {
	TaskName = "破木阵",
	--TaskTrack = {1004,5,10},
	TaskInfo = "到牧野击杀魔将收集金之灵。",
	AcceptInfo = "\t<font color='#e6dfcf' >水生木，木阵出现破绽。破阵需要金之灵，快去牧野杀魔将收集金之灵。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我立即动身。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >干得好，木阵立马可破。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >要把敌人杀得片甲不留。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1605},
	},
	ClientCompleteCondition = {
		kill = { "M_144", 50 ,{12,111,96},"金之灵"},
	},
	AutoFindWay = { true,  Position={12,111,96}},
	task = {1,607},	-- 发送给后台接受任务
}

storyList[100607] = {
	TaskName = "破火阵",
	--TaskTrack = {1004,5,10},
	TaskInfo = "到牧野击杀冰魔收集水之灵。",
	AcceptInfo = "\t<font color='#e6dfcf' >木生火，火阵威力下降，快去牧野击杀冰魔收集水之灵，有了水之灵方可破阵。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我立即动身。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >干得好，火阵立马可破。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >太好了，终于破了此阵。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1606},
	},
	ClientCompleteCondition = {
		kill = { "M_143", 50 ,{12,96,20},"水之灵"},
	},
	AutoFindWay = { true,  Position={12,96,20}},
	task = {2,82},	-- 发送给后台接受任务
}

storyList[200082] = {
	TaskName = "传信",
	--TaskTrack = {1004,5,10},
	TaskInfo = "将五行迷魂阵即将攻破的消息传给姜子牙。",
	AcceptInfo = "\t<font color='#e6dfcf' >很好，我马上准备破五行迷魂阵，你去转告姜师叔，让全军准备进攻。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我立即动身。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >回来了，五行迷魂阵可破？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >杨戬师兄已经就绪。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1607},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,608},	-- 发送给后台接受任务
}

storyList[100608] = {
	TaskName = "将等级提升到93级",
	--TaskTrack = {1004,5,10},
	TaskInfo = "将等级提升到93级。",
	AcceptInfo = "\t<font color='#e6dfcf' >破阵后即可全军进攻，我需要调兵遣将，你先去休整一下，将等级提升到93级。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >准备好了吗，我准备破阵。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {2082},
	},
	ClientCompleteCondition = {
		level = 93,
	},
	task = {1,609},	-- 发送给后台接受任务
}
storyList[100609] = {
	TaskName = "破除迷阵",
	--TaskTrack = {1004,5,10},
	TaskInfo = "击杀迷阵护法，破除迷阵。",
	AcceptInfo = "\t<font color='#e6dfcf' >五行阵已破，你去将枢纽护法击杀，避免他修复阵法。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >干得好，此阵一破，我军便可长驱直入，攻破朝歌!</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我要为死去的战友报仇!</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1608},
	},
	ClientCompleteCondition = {
		kill = {"M_146",50,{13,9,109}},
	},
	AutoFindWay = { true,  Position={13,9,109}},
	task = {1,610},	-- 发送给后台接受任务
}
storyList[100610] = {
	TaskName = "进军朝歌",
	--TaskTrack = {1004,5,10},
	TaskInfo = "进军朝歌，消灭门口的魔军。",
	AcceptInfo = "\t<font color='#e6dfcf' >向朝歌进军，要先去消灭门口的妖魔卫兵，好让我军能够长驱直入。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我愿做先锋军！</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >干得漂亮，这样我军就可以继续前进了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >胜利指日可待了。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1609},
	},
	ClientCompleteCondition = {
		kill = {"M_147",50,{13,40,124}},
	},
	AutoFindWay = { true,  Position={13,40,124}},
	task = {1,611},	-- 发送给后台接受任务
}
storyList[100611] = {
	TaskName = "进入城内",
	--TaskTrack = {1004,5,10},
	TaskInfo = "进入朝歌城内，找到城内斥候头领。",
	AcceptInfo = "\t<font color='#e6dfcf' >接下来需要进入朝歌，找到城内斥候头领，了解城内情况。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我这就动身。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >你来的正好，朝歌已经被妖魔占据。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >情况怎么样了。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1610},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,612},	-- 发送给后台接受任务
}
storyList[100612] = {
	TaskName = "传递情报",
	--TaskTrack = {1004,5,10},
	TaskInfo = "将朝歌城内的魔军情报带给黄飞虎。",
	AcceptInfo = "\t<font color='#e6dfcf' >朝歌城内的妖魔分布情报在这里，请速速回报给将军。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我这就带回去。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >有了这个情报，我就可以安排进攻方案了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是的。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1611},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,613},	-- 发送给后台接受任务
}
storyList[100613] = {
	TaskName = "提升等级到94",
	--TaskTrack = {1004,5,10},
	TaskInfo = "提升等级到94。",
	AcceptInfo = "\t<font color='#e6dfcf' >你先去将等级提升到94级，再来助我。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >正等着你来呢。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >接下来该怎么办。</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1612},
	},
	ClientCompleteCondition = {
		level = 94,
	},
	task = {1,614},	-- 发送给后台接受任务
}
storyList[100614] = {
	TaskName = "借取镇妖塔",
	--TaskTrack = {1004,5,10},
	TaskInfo = "去向李靖借取镇妖塔。",
	AcceptInfo = "\t<font color='#e6dfcf' >由于朝歌城内都是妖魔，需要借助李靖的镇妖塔的力量来消弱他们。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我这就去向李靖借镇妖塔。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >你是来借取镇妖塔的吧？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是的。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1613},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,615},	-- 发送给后台接受任务
}
storyList[100615] = {
	TaskName = "东海之晶",
	--TaskTrack = {1004,5,10},
	TaskInfo = "去东海采集东海之晶。",
	AcceptInfo = "\t<font color='#e6dfcf' >由于在渭水时使用过，镇妖塔内的妖魔又非常强大，再次使用可能会放出里面的妖魔，唯独用东海之晶来强化镇妖塔的灵力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我这就去找。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >多谢恩人多次救助我族之人，我族一定会报答恩人。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >正有一事需要你的帮助。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1614},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {2,83},	-- 发送给后台接受任务
}

storyList[200083] = {
	TaskName = "东海之晶",
	--TaskTrack = {1004,5,10},
	TaskInfo = "去东海采集东海之晶。",
	AcceptInfo = "\t<font color='#e6dfcf' >原来如此，能帮助恩人降妖除魔也是我族的荣耀，这东海之晶请收好。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >可得到东海之晶。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >幸不辱命。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1615},
	},
	ClientCompleteCondition = {
		
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,616},	-- 发送给后台接受任务
}

storyList[100616] = {
	TaskName = "将等级提升到95",
	--TaskTrack = {1004,5,10},
	TaskInfo = "将等级提升到95。",
	AcceptInfo = "\t<font color='#e6dfcf' >有了这东海之晶，镇妖塔的灵力将大大加强。但需要时间来加强，你先去升级到95吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >李靖已将镇妖塔送来，我们准备进攻。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我一定会竭尽全力！</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {2083},
	},
	ClientCompleteCondition = {
		level = 95,
	},
	task = {1,617},	-- 发送给后台接受任务
}
storyList[100617] = {
	TaskName = "歼灭妖魔",
	--TaskTrack = {1004,5,10},
	TaskInfo = "击杀朝歌城内的妖魔。",
	AcceptInfo = "\t<font color='#e6dfcf' >有了这镇妖塔，我军如虎添翼，快去消灭朝歌城内的妖魔骷髅兵吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >等待的就是这一天。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >很好，这样一来战局将对我军更加有利。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我军必胜！</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1616},
	},
	ClientCompleteCondition = {
		kill = {"M_148",50,{13,13,71}},
	},
	AutoFindWay = { true,  Position={13,13,71}},
	task = {1,618},	-- 发送给后台接受任务
}
storyList[100618] = {
	TaskName = "歼灭妖魔2",
	--TaskTrack = {1004,5,10},
	TaskInfo = "击杀朝歌城内的妖魔。",
	AcceptInfo = "\t<font color='#e6dfcf' >战况紧急，快去前线继续杀敌吧，这次去消灭狼妖。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >杀光那些妖魔！</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >很好，这样一来我方将主导战局</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多亏将士们奋勇杀敌。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1617},
	},
	ClientCompleteCondition = {
		kill = {"M_149",50,{13,24,230}},
	},
	AutoFindWay = { true,  Position={13,24,230}},
	task = {1,619},	-- 发送给后台接受任务
}
storyList[100619] = {
	TaskName = "歼灭妖魔3",
	--TaskTrack = {1004,5,10},
	TaskInfo = "击杀朝歌城内的妖魔。",
	AcceptInfo = "\t<font color='#e6dfcf' >敌军快要抵挡不住了，再去将腐尸兽消灭掉。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我立刻动身。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >太好了，我军必胜！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >胜利终将属于我们。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1618},
	},
	ClientCompleteCondition = {
		kill = {"M_150",50,{13,119,193}},
	},
	AutoFindWay = { true,  Position={13,119,193}},
	task = {1,620},	-- 发送给后台接受任务
}
storyList[100620] = {
	TaskName = "向姜子牙报告",
	--TaskTrack = {1004,5,10},
	TaskInfo = "朝歌城前部的妖魔已经消灭，快向姜子牙报告。",
	AcceptInfo = "\t<font color='#e6dfcf' >朝歌城前部的妖魔已经消灭，快去向国师报告。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >太好了，消灭了朝歌前部的妖魔，胜利之日指日可待。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >胜利终将属于我们。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1619},
	},
	ClientCompleteCondition = {
	
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,621},	-- 发送给后台接受任务
}
storyList[100621] = {
	TaskName = "提升等级到96",
	--TaskTrack = {1004,5,10},
	TaskInfo = "提升等级到96。",
	AcceptInfo = "\t<font color='#e6dfcf' >下一步准备消灭朝歌城内的虿盆与酒池肉林中的妖魔，此去非常凶险，你先升级到96级吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >准备好了吗？有任务要交给你。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >嗯。</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1620},
	},
	ClientCompleteCondition = {
		level = 96,
	},
	task = {1,622},	-- 发送给后台接受任务
}
storyList[100622] = {
	TaskName = "求药",
	--TaskTrack = {1004,5,10},
	TaskInfo = "找药店老板要一些祛除瘴气效果的药。",
	AcceptInfo = "\t<font color='#e6dfcf' >虿盆附近瘴气环绕，你先去陈塘关找药店老板要一些去除瘴气效果的药。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >有什么事？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >虿盆附近瘴气环绕，我来要一些去除瘴气效果的药。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1621},
	},
	ClientCompleteCondition = {
	
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,623},	-- 发送给后台接受任务
}
storyList[100623] = {
	TaskName = "采集珍珠果",
	--TaskTrack = {1004,5,10},
	TaskInfo = "去海边采集一些珍珠果。",
	AcceptInfo = "\t<font color='#e6dfcf' >虿盆附近的瘴气太厉害，需要加强药效才行。制作需要海边的珍珠果，你先去采集一些吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >有了这珍珠果我就可以加强药效了</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >太好了。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1622},
	},
	ClientCompleteCondition = {
	      items = {{10006,1,{8,74,127,100027,}}},
	},
	AutoFindWay = {Collection = {8,74,127,100027,},[1] = true,},
	task = {1,624},	-- 发送给后台接受任务
}
storyList[100624] = {
	TaskName = "购买药材",
	--TaskTrack = {1004,5,10},
	TaskInfo = "去西岐找药材商买一些药材。",
	AcceptInfo = "\t<font color='#e6dfcf' >我要配药走不开，你去西岐找药材商买需要的药材吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我这就动身。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >请问您要点什么？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我们需要制作一些去除瘴气的药的药材。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1623},
	},
	ClientCompleteCondition = {
	
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,625},	-- 发送给后台接受任务
}
storyList[100625] = {
	TaskName = "带回药材",
	--TaskTrack = {1004,5,10},
	TaskInfo = "取一些药材带给药店老板。",
	AcceptInfo = "\t<font color='#e6dfcf' >原来是这样，药就在那里，英雄你随便取吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >非常感谢。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >正等你回来呢。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >赶快做药吧。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1624},
	},
	ClientCompleteCondition = {
	    items = {{10002,1,{1,70,154,100005,}}},
	},
	AutoFindWay = {Collection = {1,70,154,100005,},[1] = true,},
	task = {1,626},	-- 发送给后台接受任务
}
storyList[100626] = {
	TaskName ="采集一些魔化珍珠果 ",
	--TaskTrack = {1004,5,10},
	TaskInfo = "去渭水采集一些魔化珍珠果",
	AcceptInfo = "\t<font color='#e6dfcf' >不行，普通珍珠果药效还不够，还要辛苦你去渭水采集一些魔化珍珠果才行。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我这就动身。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >有了这个就够了，马上就能做好药。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >太好了。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1625},
	},
	ClientCompleteCondition = {
	    items = {{10006,1,{10,52,150,100014,},},},
	},
	AutoFindWay = {Collection = {10,52,150,100014,},[1] = true,},
	task = {1,627},	-- 发送给后台接受任务
}
storyList[100627] = {
	TaskName ="消灭虿盆蛇妖",
	--TaskTrack = {1004,5,10},
	TaskInfo = "去虿盆消灭那里的蛇妖。",
	AcceptInfo = "\t<font color='#e6dfcf' >药终于做好了，赶快去虿盆消灭那里的蛇妖。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我这就动身。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >情况怎么样了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >那些蛇妖根本不堪一击，已被我歼灭。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1626},
	},
	ClientCompleteCondition = {
	    kill = {"M_151",50,{13,47,224}},
	},
	AutoFindWay = { true,  Position={13,47,224}},
	task = {1,628},	-- 发送给后台接受任务
}
storyList[100628] = {
	TaskName ="消灭酒池中的妖魔",
	--TaskTrack = {1004,5,10},
	TaskInfo = "消灭酒池中的妖魔。",
	AcceptInfo = "\t<font color='#e6dfcf' >敌人已经节节败退，快去击杀酒池中的妖魔。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >一定要把敌军击溃。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >非常好，胜利之日指日可待。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >敌人根本就是困兽之斗。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1627},
	},
	ClientCompleteCondition = {
	    kill = {"M_152",50,{13,75,212}},
	},
	AutoFindWay = { true,  Position={13,75,212}},
	task = {1,629},	-- 发送给后台接受任务
}
storyList[100629] = {
	TaskName ="消灭肉林中的妖魔",
	--TaskTrack = {1004,5,10},
	TaskInfo = "消灭肉林中的妖魔。",
	AcceptInfo = "\t<font color='#e6dfcf' >再去将肉林妖消灭。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >一定要把敌军击溃。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >非常好，敌军已经被我们击溃。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >一定要攻破朝歌。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1628},
	},
	ClientCompleteCondition = {
	    kill = {"M_153",50,{13,98,227}},
	},
	AutoFindWay = { true,  Position={13,98,227}},
	task = {1,630},	-- 发送给后台接受任务
}
storyList[100630] = {
	TaskName ="将等级提升到97级",
	--TaskTrack = {1004,5,10},
	TaskInfo = "将等级提升到97级。",
	AcceptInfo = "\t<font color='#e6dfcf' >连续作战，我军也非常疲惫，你去休整一下，将等级提升到97吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >整备好了吗，后面的敌人将更难对付。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我无所畏惧。</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1629},
	},
	ClientCompleteCondition = {
	    level = 97,
	},
	task = {1,631},	-- 发送给后台接受任务
}
storyList[100631] = {
	TaskName ="调查炮烙",
	--TaskTrack = {1004,5,10},
	TaskInfo = "调查一下炮烙。",
	AcceptInfo = "\t<font color='#e6dfcf' >炮烙处出现冤魂，夜间无助啼哭，扰得军士无法休息，你前去调查一下。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >我乃商朝姜后，被妖妃所害，炮烙双手，剜去一目，还被那妖妃施邪法拘魂魄于此地无法脱身。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >原来是这样。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1630},
	},
	ClientCompleteCondition = {
	   
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,632},	-- 发送给后台接受任务
}
storyList[100632] = {
	TaskName ="拯救",
	--TaskTrack = {1004,5,10},
	TaskInfo = "帮助姜后，拯救嫔妃冤魂。",
	AcceptInfo = "\t<font color='#e6dfcf' >还有这些嫔妃，都是受我牵累被妖妃所害，请英雄帮她们解除痛苦吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好吧。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >多谢英雄。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >要如何才能救你？</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1631},
	},
	ClientCompleteCondition = {
	   kill = {"M_154",50,{13,50,33}},
	},
	AutoFindWay = { true,  Position={13,50,33}},
	task = {1,633},	-- 发送给后台接受任务
}
storyList[100633] = {
	TaskName ="帮助姜后",
	--TaskTrack = {1004,5,10},
	TaskInfo = "寻找眼珠的线索。",
	AcceptInfo = "\t<font color='#e6dfcf' >只要找到我被剜去的眼珠，全我之身，即可解脱。你可以去问问我的贴身侍女。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好吧。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >我是西宫侍女，你来干什么。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我受姜后所托来寻找她的眼珠。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1632},
	},
	ClientCompleteCondition = {
	   
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,634},	-- 发送给后台接受任务
}
storyList[100634] = {
	TaskName ="找到眼珠(1)",
	--TaskTrack = {1004,5,10},
	TaskInfo = "寻找墓碑取回眼珠。",
	AcceptInfo = "\t<font color='#e6dfcf' >原来是这样，我已将姜后的眼珠藏与炮烙场后的墓碑下，英雄请快去取吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >一块破旧的墓碑。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >应该就是这个了。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1633},
	},
	ClientCompleteCondition = {
	   
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {2,84},	-- 发送给后台接受任务
}

storyList[200084] = {
	TaskName ="找到眼珠(2)",
	--TaskTrack = {1004,5,10},
	TaskInfo = "去地下找到双目。",
	AcceptInfo = "\t<font color='#e6dfcf' >在墓碑下挖出了装有眼珠的坛子。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >找到了。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >多谢英雄，我终于可以安息了，最后请英雄一定要手刃妲己那个妖妃，方解我心头之恨。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >放心吧，妲己妖后，我必将其斩杀。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1634},
	},
	ClientCompleteCondition = {
	   
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,635},	-- 发送给后台接受任务
}

storyList[100635] = {
	TaskName ="将等级提升到98级",
	--TaskTrack = {1004,5,10},
	TaskInfo = "将等级提升到98级。",
	AcceptInfo = "\t<font color='#e6dfcf' >妲己所在的鹿台被妖魔重重保护，你最好将等级提升到98级再去。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >准备好了吗，最后的决战即将打响。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我已经做好了准备。</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {2084},
	},
	ClientCompleteCondition = {
	   level = 98,
	},
	task = {1,636},	-- 发送给后台接受任务
}
storyList[100636] = {
	TaskName ="进入战场",
	--TaskTrack = {1004,5,10},
	TaskInfo = "去找黄飞虎。",
	AcceptInfo = "\t<font color='#e6dfcf' >决战一触即发，快去前线帮助黄飞虎。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >你终于来了，战况非常胶着。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我来给予敌人致命一击！</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1635},
	},
	ClientCompleteCondition = {
	   
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,637},	-- 发送给后台接受任务
}
storyList[100637] = {
	TaskName ="击杀守卫",
	--TaskTrack = {1004,5,10},
	TaskInfo = "击杀鹿台的妖魔守卫。",
	AcceptInfo = "\t<font color='#e6dfcf' >纣王与妖狐集结了大量的妖魔守卫鹿台，快去击杀他们。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >今日一定要将他们诛灭。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >很好，这样一来我军将更加有利。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >这些妖魔不过如此。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1636},
	},
	ClientCompleteCondition = {
	   kill = {"M_155",50,{13,24,42}},
	},
	AutoFindWay = { true,  Position={13,24,42}},
	task = {1,638},	-- 发送给后台接受任务
}
storyList[100638] = {
	TaskName ="击杀守卫2",
	--TaskTrack = {1004,5,10},
	TaskInfo = "击杀鹿台的妖魔守卫。",
	AcceptInfo = "\t<font color='#e6dfcf' >妖魔守卫数量众多，快去帮助前线击杀。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >真是难缠。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >很好，我军连连告捷，士气大涨！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多亏将士们奋勇杀敌。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1637},
	},
	ClientCompleteCondition = {
	   kill = {"M_156",50,{13,48,77}},
	},
	AutoFindWay = { true,  Position={13,48,77}},
	task = {1,639},	-- 发送给后台接受任务
}
storyList[100639] = {
	TaskName ="击杀守卫3",
	--TaskTrack = {1004,5,10},
	TaskInfo = "击杀鹿台的妖魔守卫。",
	AcceptInfo = "\t<font color='#e6dfcf' >再接再厉，一举将敌军击垮！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >杀光他们！</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >很好，敌军已经出现疲态，多亏你带领兄弟们奋勇杀敌!</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >这是所有将士们的功劳。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1638},
	},
	ClientCompleteCondition = {
	   kill = {"M_157",50,{13,95,60}},
	},
	AutoFindWay = { true,  Position={13,95,60}},
	task = {1,640},	-- 发送给后台接受任务
}
storyList[100640] = {
	TaskName ="将等级提升到99",
	--TaskTrack = {1004,5,10},
	TaskInfo = "将等级提升到99。",
	AcceptInfo = "\t<font color='#e6dfcf' >此次战役，我军伤亡同样惨重。你和将士们先去休整一下吧，将等级提升到99</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >准备好了吗？决战一触即发！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >等待的就是这一天。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1639},
	},
	ClientCompleteCondition = {
	   level = 99,
	},
	task = {1,641},	-- 发送给后台接受任务
}
storyList[100641] = {
	TaskName ="击杀守卫4",
	--TaskTrack = {1004,5,10},
	TaskInfo = "击杀鹿台的妖魔守卫",
	AcceptInfo = "\t<font color='#e6dfcf' >决战已经打响，快去前线增援！</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我立马动身。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >很好，敌军已经是困兽之斗。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >必将他们杀得片甲不留。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1640},
	},
	ClientCompleteCondition = {
	   kill = {"M_158",50,{13,106,83}},
	},
	AutoFindWay = { true,  Position={13,106,83}},
	task = {1,643},	-- 发送给后台接受任务
}

storyList[100643] = {
	TaskName ="击杀守卫5",
	--TaskTrack = {1004,5,10},
	TaskInfo = "击杀鹿台的妖魔守卫",
	AcceptInfo = "\t<font color='#e6dfcf' >敌军只剩下一些残余部队，去把他们全部歼灭。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >终于要结束了。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >很好，终于打赢了这场仗，你是我们的英雄。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >可惜我们仍然牺牲了很多将士。</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1641},
	},
	ClientCompleteCondition = {
	   kill = {"M_159",50,{13,112,129}},
	},
	AutoFindWay = { true,  Position={13,112,129}},
	task = {1,646},	-- 发送给后台接受任务
}

storyList[100646] = {
	TaskName ="报告武王",
	--TaskTrack = {1004,5,10},
	TaskInfo = "将胜利的消息报告给武王",
	AcceptInfo = "\t<font color='#e6dfcf' >攻入鹿台时发现，纣王和妖狐已经逃走了。但朝歌已经落入我手，我们胜利了。你去将此消息告知我王。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >战况如何了？爱卿，本王日日寝室难安。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我军大获全胜，伐纣大业已成，纣王逃走，天下太平了！</font>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1643},
	},
	ClientCompleteCondition = {
	   
	},
	AutoFindWay = {true,SubmitNPC = true},
	task = {1,647},	-- 发送给后台接受任务
}
storyList[100647] = {
	TaskName ="将等级提升到100",
	--TaskTrack = {1004,5,10},
	TaskInfo = "将等级提升到100",
	AcceptInfo = "\t<font color='#e6dfcf' >天下终于太平了,传我命令，举国欢庆。但那纣王妖狐逃走，不得不防，你先去把等级提升到100级吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >只能先这样了。</font>",
	SubmitInfo = "\t<font color='#e6dfcf' >我。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我！</font>",
	HelpInfo = "<a href='event:day.DDayPanel 2'><u>完成<font color='#3cff00'>活跃度</font>得海量<font color='#ff00ff'>经验,奖品</font></u></a>",
	ClientAcceptEvent = {},
	ClientSumitEvent = {},
	CleintAcceptCondition = {
		completed = {1646},
	},
	ClientCompleteCondition = {
	   level = 100,
	},
	--task = {1,648},	-- 发送给后台接受任务
}









storyList[300001] =
{

	TaskName = "加入帮会",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 1,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "加入任意帮会，或者自己创建帮会。",		-- 任务描述
	--AcceptInfo = "\t<font color='#e6dfcf' >商周之战即将开启，你也要做好准备，将等级提升到50再来找我吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >恭喜你加入帮会，仔细关注一下功能，会有很多惊喜哦。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = 999,
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		faction = 1
	},

};
storyList[300002] =
{

	TaskName = "宝石镶嵌[战力]",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 14,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "在任意装备上镶嵌一颗宝石。",		-- 任务描述
	--AcceptInfo = "\t<font color='#e6dfcf' >商周之战即将开启，你也要做好准备，将等级提升到50再来找我吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >宝石对战力有很大的帮助，多多收集宝石吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1324},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		equipbs = 1,		--任意装备镶嵌一颗宝石
	},
	task = {3,3},
};

storyList[300003] =
{
	TaskName = "装备强化[战力]",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 14,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "将身上的武器强化到12级。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >装备是重中之重，强化需要大量铜钱，从某种角度来说，铜钱=战力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >明白。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >哇，武器闪闪发光，真让人羡慕。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >过奖过奖。</font>", --完成任务对话
	HelpInfo = "(<a href='event:faction'><u><font color='#3cff00'>帮会商店</font>可兑换<font color='#ff00ff'>幸运石</font></u></a>)",	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3002},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		equiplevel = {0,12},
	},
	task = {3,4},	-- 发送给后台接受任务
};
storyList[300004] =
{
	TaskName = "家将修行[战力]",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 14,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "将家将修行到10阶。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >一个好汉三个帮，家将也是战力的重要组成部分。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也经常培养家将。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >不错，你的家将好厉害。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >过奖过奖。</font>", --完成任务对话
	HelpInfo = "(<a href='event:garden.DGardenPanel'><u><font color='#3cff00'>果园种植</font>可收获<font color='#ff00ff'>灵气，铜钱</font></u></a>)",	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3003},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		herolevel2 = 10
	},
	task = {3,5},	-- 发送给后台接受任务	
};

storyList[300005] =
{

	TaskName = "坐骑进化[战力]",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 14,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "将坐骑进阶到1阶。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >毫不夸张的说，坐骑就是身份象征，要战力有战力，要外形有外形，进化还有抽奖机会。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我马上去进化坐骑。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >哇，你的坐骑好拉风。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >过奖过奖。</font>", --完成任务对话
	HelpInfo = "(<a href='event:shop.DMallPanel 3'><u><font color='#3cff00'>绑定元宝商城</font>可购买<font color='#ff00ff'>进阶丹</font></u></a>)",	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3004},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		horselevel = 10  
	},

};
storyList[300006] =
{

	TaskName = "装备分解[战力]",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 14,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "分解任意一件装备",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >分解装备后，可以获得洗练石。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我要在哪里去弄装备呢？</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >淘汰下来的旧装备，或者挂机打怪可以获得低品质装备.</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点.</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1203},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		fanjie = 1
	},
	task = {3,7},	
};
storyList[300007] =
{

	TaskName = "装备洗练[战力]",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 14,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "穿戴任意一件洗练过的装备",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >洗练石是用来洗练装备的。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >洗练有什么用？</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >装备洗练之后，可以发挥出全部的潜力，增强你的战斗力.</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点.</font>", --完成任务对话
	HelpInfo = "(<a href='event:equip.DEquipPanel 3'><u>通过<font color='#3cff00'>分解装备</font>可得到<font color='#ff00ff'>洗炼石</font></u></a>)",	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3006},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		xilian = 1
	},
	
};

storyList[300008] =
{

	TaskName = "组队副本[经验]",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 15,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "请完成1次组队副本。",		-- 任务描述
	ClientCompleteAwards = 1 ,
	--AcceptInfo = "\t<font color='#e6dfcf' >毫不夸张的说，坐骑就是身份象征，要战力有战力，要外形有外形，进化还有抽奖机会。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我马上去进化坐骑。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >完成了组队副本，是不是有不少收获？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是啊。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1378},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		mfb = 1
	},
	task = {3,9},	-- 发送给后台接受任务
};
storyList[300009] =
{

	TaskName = "拍卖所[经验]",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 15,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "请完成1次拍卖或购买操作。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >组队副本会产出不少可拍卖的物品，是交易获得元宝的最佳途径。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >原来如此。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >怎么样？学会使用拍卖所了吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >学会了，多谢指点。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3008},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		pm =1
	},
	
};

storyList[300010] =
{

	TaskName = "神创天下(2星)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 10,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "通过神创天下的第2关",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你准备好再次挑战吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >不错，你要继续挑战吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >当然。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		--level = 999,
		completed={1256},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		monsterList = 2,
	},
	task = {3,11},	-- 发送给后台接受任务
};
storyList[300011] =
{

	TaskName = "神创天下(3星)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 10,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "通过神创天下的第3关",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你准备好再次挑战吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >不错，你要继续挑战吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >当然。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3010},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		monsterList = 3,
	},
	task = {3,12},	-- 发送给后台接受任务
};
storyList[300012] =
{

	TaskName = "神创天下(4星)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 10,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "通过神创天下的第4关",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你准备好再次挑战吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >不错，你要继续挑战吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >当然。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3011},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		monsterList = 4,
	},
	task = {3,13},	-- 发送给后台接受任务
};
storyList[300013] =
{

	TaskName = "神创天下(5星)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 10,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "通过神创天下的第5关",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你准备好再次挑战吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >不错，你要继续挑战吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >当然。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3012},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		monsterList = 5,
	},
	task = {3,14},	-- 发送给后台接受任务
};
storyList[300014] =
{

	TaskName = "神创天下(6星)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 10,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "通过神创天下的第6关",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你准备好再次挑战吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >不错，你要继续挑战吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >当然。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3013},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		monsterList = 6,
	},
	task = {3,15},	-- 发送给后台接受任务
};
storyList[300015] =
{

	TaskName = "神创天下(7星)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 10,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "通过神创天下的第7关",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你准备好再次挑战吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >不错，你要继续挑战吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >当然。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3014},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		monsterList = 7,
	},
	task = {3,16},	-- 发送给后台接受任务
};
storyList[300016] =
{

	TaskName = "神创天下(8星)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 10,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "通过神创天下的第8关",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你准备好再次挑战吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >不错，你要继续挑战吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >当然。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3015},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		monsterList = 8,
	},
	task = {3,17},	-- 发送给后台接受任务
};
storyList[300017] =
{

	TaskName = "神创天下(9星)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 10,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "通过神创天下的第9关",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你准备好再次挑战吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >不错，你要继续挑战吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >当然。</font>", --完成任务对话
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3016},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		monsterList = 9,
	},
	--task = {3,17},	-- 发送给后台接受任务
};


storyList[300030] =
{

	TaskName = "排位赛[经验]",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 13,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "请完成4次排位赛的挑战。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你准备好挑战排位赛了吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我想试试。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >通过排位赛，才能知道自己的真实实力，认清自己的定位。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是啊。</font>", --完成任务对话
	HelpInfo = "(<a href='event:DHeroRecruitPanel'><u>排位赛得<font color='#3cff00'>声望</font>可招募<font color='#ff00ff'>强力家将</font></u></a>)",	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = 999,
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		homebattle2 =4--排位赛
	},
	--task = {3,31},	-- 发送给后台接受任务
};
storyList[300031] =
{

	TaskName = "排位赛[经验]",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 13,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "请完成10次排位赛的挑战。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >你准备好挑战排位赛了吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我想试试。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >通过排位赛，才能知道自己的真实实力，认清自己的定位。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >是啊。</font>", --完成任务对话
	HelpInfo = "(<a href='event:DHeroRecruitPanel'><u>排位赛得<font color='#3cff00'>声望</font>可招募<font color='#ff00ff'>强力家将</font></u></a>)",	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = 999,
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		homebattle2 =10--排位赛
	},	
};



storyList[300035] =
{

	TaskName = "完成护送[经验]",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 11,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	
	TaskInfo = "请完成3次护送海美人。",		-- 任务描述
	
	SubmitInfo = "\t<font color='#e6dfcf' >护送时灵活躲避敌人才是关键。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={2027},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		husong = 3 , --完成一次护送
	},
};
storyList[300040] =
{

	TaskName = "完成悬赏[经验]",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 12,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "请完成20次悬赏任务。",		-- 任务描述
	
	SubmitInfo = "\t<font color='#e6dfcf' >悬赏任务每日最好都要完成，因为会奖励大量经验。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = 999,
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		taskhuan = 20  --完成3环悬赏任务
	},
	
};

storyList[300042] =
{

	TaskName = "登陆器登陆",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 17,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	ClientCompleteAwards = 1 ,
	TaskInfo = "请使用登陆器登陆。",		-- 任务描述
	
	SubmitInfo = "\t<font color='#e6dfcf' >使用登陆器登陆，游戏更加流畅。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		--level = 999,
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		dlq = 1 , 
	},
	
};
storyList[300045] =
{

	TaskName = "女仆宠爱[经验]",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 16,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "宠爱任意女仆5次",		-- 任务描述
	
	SubmitInfo = "\t<font color='#e6dfcf' >缠绵女仆，可以提升自己的战斗力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1377},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		daji = 5,
	},
	
};

storyList[300046] =
{

	TaskName = "法宝升星[战力]",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 16,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "将法宝升级到一阶",		-- 任务描述
	
	SubmitInfo = "\t<font color='#e6dfcf' >提升法宝可增加属性。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = 999,
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		magicFight = 1,
	},
	
};


storyList[300100] =
{

	TaskName = "清剿沼泽（一）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 4,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "去寻找沼泽郊野的无名侠士。",		-- 任务描述
	
	SubmitInfo = "\t<font color='#e6dfcf' >"..talk.name().."，好久不见啊，你总算来了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >又见面了，你找我有事吗？</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1377},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	task = {3,101},	-- 发送给后台接受任务
};
storyList[300101] =
{

	TaskName = "清剿沼泽（二）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 4,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "消灭瘴气沼泽的妖物",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >最近瘴气沼泽又出现了很多妖物，让本地居民很困扰，你能再帮帮我们吗？</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >义不容辞。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >果然厉害，还请继续帮帮我们。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3100},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_259", 20 ,{22,28,12}},
	},
	AutoFindWay = { true,  Position={22,28,12}},
	task = {3,102},	-- 发送给后台接受任务
};
storyList[300102] =
{

	TaskName = "清剿沼泽（三）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 4,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "消灭瘴气沼泽的妖物",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >小心妖物中的骑兵，它们要更加厉害一些。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我会小心的。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >好了，只剩下一些统领怪，又要花费你不少时间，真抱歉。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >不用客气。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3101},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_260", 20 ,{22,19,51}},
	},
	AutoFindWay = { true,  Position={22,19,51}},
	task = {3,103},	-- 发送给后台接受任务
};
storyList[300103] =
{

	TaskName = "清剿沼泽（四）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 4,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "消灭瘴气沼泽的妖物",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >注意不要深入到瘴气沼泽的最深处，那里有可能出现神秘的强大妖物。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哦？有空我倒想见识一番。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >哈哈，瘴气都消散了许多，这下很久都不会有妖物作乱了，太感谢你了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >不必客气。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3102},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_261", 20 ,{22,36,67}},
	},
	AutoFindWay = { true,  Position={22,36,67}},
	
};



storyList[300111] =
{

	TaskName = "镇压海族（一）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 5,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "陈塘关的哪吒有事情找你",		-- 任务描述
	--AcceptInfo = "\t<font color='#e6dfcf' >注意不要深入到瘴气沼泽的最深处，那里有可能出现神秘的强大妖物。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哦？有空我倒想见识一番。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >你来的正好，最近海族又蠢蠢欲动，看来又皮痒了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >呃，你又要去跟海族开战么？</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1403},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	task = {3,112},
	
};
storyList[300112] =
{

	TaskName = "镇压海族（二）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 5,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "镇压陈塘关外蠢蠢欲动的海族，保障陈塘关的安全",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >不行啊，我已经闹过一次了，再去东海影响太大，所以只有麻烦你了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >唉，我就知道。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >哈哈，痛快。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >你是痛快，苦力活全我干了。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3111},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_255", 20 ,{31,10,96}},
	},
	AutoFindWay = { true,  Position={31,10,96}},
	task = {3,113},
	
};
storyList[300113] =
{

	TaskName = "镇压海族（三）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 5,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "镇压陈塘关外蠢蠢欲动的海族，保障陈塘关的安全",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >嘻嘻，我们关系这么铁，你不会不帮我吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >怕你了，我继续吧。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >哈哈，这下海族应该知道痛了吧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >那也未必，我还没深入海底呢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3112},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_256", 20 ,{31,24,63}},
	},
	AutoFindWay = { true,  Position={31,24,63}},
	task = {3,114},
};
storyList[300114] =
{

	TaskName = "镇压海族（四）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 5,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "镇压陈塘关外蠢蠢欲动的海族，保障陈塘关的安全",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >那就除恶务尽，给海族一个狠狠的教训。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >交给我吧。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >哈哈，这下陈塘关安全了，回西岐我请你喝酒。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3113},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_257", 20 ,{31,6,42}},
	},
	AutoFindWay = { true,  Position={31,6,42}},
	
};

--45卡级新增任务
storyList[300115] =
{

	TaskName = "清剿渭水（一）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 5,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "渭水的邓婵玉有事情找你",		-- 任务描述
	--AcceptInfo = "\t<font color='#e6dfcf' >注意不要深入到瘴气沼泽的最深处，那里有可能出现神秘的强大妖物。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哦？有空我倒想见识一番。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >为了前方部队的安全，我们要清除他们的后顾之忧。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >交给我吧！</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1422},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	task = {3,116},
	
};
storyList[300116] =
{

	TaskName = "清剿渭水（二）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 5,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "清剿渭水的残余敌人。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >先去消灭残余的亡命徒。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >你放心。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >哈哈，做的不错。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >还有吗？</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3115},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_065",30,{10,12,83}},
	},
	AutoFindWay = { true,  Position={10,12,83}},
	task = {3,117},
	
};
storyList[300117] =
{

	TaskName = "清剿渭水（三）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 5,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "清剿渭水的残余敌人。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >再去消灭残余的无知暴民。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >你放心。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >手脚挺麻利的嘛。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >小菜一碟。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3116},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_039",30,{10,18,157}},
	},
	AutoFindWay = { true,  Position={10,18,157}},
	task = {3,118},
	
};
storyList[300118] =
{

	TaskName = "清剿渭水（四）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 5,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "清剿渭水的残余敌人。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >哟，稍微表扬一下就骄傲起来了，那再去将魔化寄居蟹给我清理了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >你还真能使唤人。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >很好，继续再接再励。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我就知道还没有完。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3117},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_040",30,{10,50,123}},
	},
	AutoFindWay = { true,  Position={10,50,123}},
	task = {3,119},
	
};
storyList[300119] =
{

	TaskName = "清剿渭水（五）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 5,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "清剿渭水的残余敌人。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >这次是去消灭魔化蟹将。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >知道了。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >你果然值得信赖。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >你这么说我有不好的预感。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3118},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_072",30,{10,43,101}},
	},
	AutoFindWay = { true,  Position={10,43,101}},
	task = {3,120},
	
};
storyList[300120] =
{

	TaskName = "清剿渭水（六）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 5,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "清剿渭水的残余敌人。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >费什么话，快去将魔化夜叉给我消灭了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我就知道。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >好了，你可以去休息了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >说好的福利呢？。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3119},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_073",30,{10,60,145}},
	},
	AutoFindWay = { true,  Position={10,60,145}},
	--task = {3,120},
	
};
--49级支线
storyList[300121] =
{

	TaskName = "平定渭水（一）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 5,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "渭水的邓婵玉有事情找你",		-- 任务描述
	--AcceptInfo = "\t<font color='#e6dfcf' >注意不要深入到瘴气沼泽的最深处，那里有可能出现神秘的强大妖物。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >哦？有空我倒想见识一番。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >前方部队高歌猛进，我们也不能落后了，继续清除后患。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好！</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={1433},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},
	task = {3,122},
	
};
storyList[300122] =
{

	TaskName = "平定渭水（二）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 5,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "清剿渭水的残余敌人。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >这次的目标是商军斥候。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >知道了。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >很好，下个目标。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3121},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_066",40,{10,39,72}},
	},
	AutoFindWay = { true,  Position={10,39,72}},
	task = {3,123},
	
};
storyList[300123] =
{

	TaskName = "平定渭水（三）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 5,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "清剿渭水的残余敌人。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >这次的目标是精锐斥候。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >知道了。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >很好，下个目标。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3122},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_041",40,{10,37,54}},
	},
	AutoFindWay = { true,  Position={10,37,54}},
	task = {3,124},
	
};
storyList[300124] =
{

	TaskName = "平定渭水（四）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 5,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "清剿渭水的残余敌人。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >这次的目标是商军士兵。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >知道了。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >很好，下个目标。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >好的。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3123},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_069",40,{10,40,38}},
	},
	AutoFindWay = { true,  Position={10,40,38}},
	task = {3,125},
	
};
storyList[300125] =
{

	TaskName = "平定渭水（五）",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	index = 5,	--支线任务排序
	TaskGuide=1,						-- 任务引导
	TaskInfo = "清剿渭水的残余敌人。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >这次的目标是商军游骑。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >知道了。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >好了，暂时完成了任务，你可以休息一下了。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >太好了。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={3124},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_070",40,{10,42,20}},
	},
	AutoFindWay = { true,  Position={10,42,20}},
	--task = {3,125},
	
};



storyList[400001] =
{

	TaskName = "讨伐任务(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = {40,44},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_350", 1000 ,{200,33,115}},
	},	
	task = {4,2},
};
storyList[400002] =
{

	TaskName = "讨伐任务(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4001},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_350", 1500 ,{200,58,138}},
	},	
	task = {4,3},
};
storyList[400003] =
{

	TaskName = "讨伐任务(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4002},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_350", 2000 ,{200,25,68}},
	},	
	
};

storyList[400006] =
{

	TaskName = "讨伐任务(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = {45,49},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_351", 1000 ,{201,33,115}},
	},	
	task = {4,7},
};
storyList[400007] =
{

	TaskName = "讨伐任务(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4006},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_351", 1500 ,{201,17,94}},
	},	
	task = {4,8},
};
storyList[400008] =
{

	TaskName = "讨伐任务(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4007},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_351", 2000 ,{201,15,43}},
	},	
	
};


storyList[400011] =
{

	TaskName = "讨伐任务(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = {50,54},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_352", 1000 ,{202,8,94}},
	},	
	task = {4,12},
};
storyList[400012] =
{

	TaskName = "讨伐任务(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4011},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_352", 1500 ,{202,8,94}},
	},	
	task = {4,13},
};
storyList[400013] =
{

	TaskName = "讨伐任务(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4012},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_352", 2000 ,{202,8,94}},
	},	
	
};


storyList[400016] =
{

	TaskName = "讨伐任务(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = {55,59},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_353", 1000 ,{203,20,46}},
	},	
	task = {4,17},
};
storyList[400017] =
{

	TaskName = "讨伐任务(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4016},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_353", 1500 ,{203,17,76}},
	},	
	task = {4,18},
};
storyList[400018] =
{

	TaskName = "讨伐任务(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4017},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_353", 2000 ,{203,35,80}},
	},	
	
};


storyList[400021] =
{

	TaskName = "讨伐任务(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = {60,64},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_354", 1000 ,{204,14,49}},
	},	
	task = {4,22},
};
storyList[400022] =
{

	TaskName = "讨伐任务(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4021},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_354", 1500 ,{204,34,55}},
	},	
	task = {4,23},
};
storyList[400023] =
{

	TaskName = "讨伐任务(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4022},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_354", 2000 ,{204,23,74}},
	},	
	
};


storyList[400026] =
{

	TaskName = "讨伐任务(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = {65,69},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_355", 1000 ,{205,68,161}},
	},	
	task = {4,27},
};
storyList[400027] =
{

	TaskName = "讨伐任务(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4026},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_355", 1500 ,{205,68,161}},
	},	
	task = {4,28},
};
storyList[400028] =
{

	TaskName = "讨伐任务(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4027},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_355", 2000 ,{205,68,161}},
	},	
	
};


storyList[400031] =
{

	TaskName = "讨伐任务(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = {70,74},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_356", 1000 ,{205,40,127}},
	},	
	task = {4,32},
};
storyList[400032] =
{

	TaskName = "讨伐任务(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4031},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_356", 1500 ,{205,40,127}},
	},	
	task = {4,33},
};
storyList[400033] =
{

	TaskName = "讨伐任务(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4032},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_356", 2000 ,{205,40,127}},
	},	
	
};

storyList[400036] =
{

	TaskName = "讨伐任务(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = {75,79},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_357", 1000 ,{205,58,67}},
	},	
	task = {4,37},
};
storyList[400037] =
{

	TaskName = "讨伐任务(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4036},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_357", 1500 ,{205,58,67}},
	},	
	task = {4,38},
};
storyList[400038] =
{

	TaskName = "讨伐任务(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4037},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_357", 2000 ,{205,58,67}},
	},	
	
};

storyList[400041] =
{

	TaskName = "讨伐任务(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = {80,84},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_358", 1000 ,{205,105,119}},
	},	
	task = {4,42},
};
storyList[400042] =
{

	TaskName = "讨伐任务(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4041},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_358", 1500 ,{205,105,119}},
	},	
	task = {4,43},
};
storyList[400043] =
{

	TaskName = "讨伐任务(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4042},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_358", 2000 ,{205,105,119}},
	},	
	
};
storyList[400046] =
{

	TaskName = "讨伐任务(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = {85,89},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_359", 1000 ,{206,23,99}},
	},	
	task = {4,47},
};
storyList[400047] =
{

	TaskName = "讨伐任务(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4046},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_359", 1500 ,{206,23,99}},
	},	
	task = {4,48},
};
storyList[400048] =
{

	TaskName = "讨伐任务(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4047},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_359", 2000 ,{206,23,99}},
	},	
	
};
storyList[400051] =
{

	TaskName = "讨伐任务(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = {90,94},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_360", 1000 ,{206,46,62}},
	},	
	task = {4,52},
};
storyList[400052] =
{

	TaskName = "讨伐任务(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4051},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_360", 1500 ,{206,46,62}},
	},	
	task = {4,53},
};
storyList[400053] =
{

	TaskName = "讨伐任务(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4052},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_360", 2000 ,{206,46,62}},
	},	
	
};
storyList[400056] =
{

	TaskName = "讨伐任务(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = {95,99},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_361", 1000 ,{207,21,73}},
	},	
	task = {4,57},
};
storyList[400057] =
{

	TaskName = "讨伐任务(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4056},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_361", 1500 ,{207,21,73}},
	},	
	task = {4,58},
};
storyList[400058] =
{

	TaskName = "讨伐任务(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请进入挂机秘境，完成怪物讨伐。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >挂机秘境镇压着各种妖魔，用于各族修炼士通过战斗来磨砺自己，提升实力。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >我也去修炼一会。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >如果有多余的时间，不妨多在挂机秘境修炼，不但经验丰厚，还会有各种贵重物品掉落。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢指点。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4057},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "GJ_361", 2000 ,{207,21,73}},
	},	
	
};
storyList[400101] =
{

	TaskName = "帮会日常(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		faction = 1,
		level = {30,39},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_018", 20 ,{8,57,124}},
	},	
	
};
storyList[400102] =
{

	TaskName = "帮会日常(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4101},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_019", 20 ,{8,25,95}},
	},	
	
};
storyList[400103] =
{

	TaskName = "帮会日常(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4102},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_017", 20 ,{8,14,50}},
	},	
	
};
storyList[400104] =
{

	TaskName = "帮会日常(4环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4103},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_018", 20 ,{8,57,124}},
	},	
	
};
storyList[400105] =
{

	TaskName = "帮会日常(5环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4104},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_019", 20 ,{8,25,95}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};
storyList[400160] =
{

	TaskName = "帮会日常(6环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4105},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_017", 20 ,{8,14,50}},
	},	
	
};
storyList[400161] =
{

	TaskName = "帮会日常(7环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4160},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_018", 20 ,{8,57,124}},
	},	
	
};
storyList[400162] =
{

	TaskName = "帮会日常(8环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4161},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_019", 20 ,{8,25,95}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};
storyList[400163] =
{

	TaskName = "帮会日常(9环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4162},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_017", 20 ,{8,14,50}},
	},	
	
};
storyList[400164] =
{

	TaskName = "帮会日常(10环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4163},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_018", 20 ,{8,57,124}},
	},	
	
};
storyList[400165] =
{

	TaskName = "帮会日常(11环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4164},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_019", 20 ,{8,25,95}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};
storyList[400166] =
{

	TaskName = "帮会日常(12环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4165},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_017", 20 ,{8,14,50}},
	},	
	
};
storyList[400167] =
{

	TaskName = "帮会日常(13环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4166},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_018", 20 ,{8,57,124}},
	},	
	
};
storyList[400168] =
{

	TaskName = "帮会日常(14环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4167},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_019", 20 ,{8,25,95}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};
storyList[400169] =
{

	TaskName = "帮会日常(15环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4168},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_017", 20 ,{8,14,50}},
	},	
	
};
storyList[400170] =
{

	TaskName = "帮会日常(16环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4169},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_018", 20 ,{8,57,124}},
	},	
	
};
storyList[400171] =
{

	TaskName = "帮会日常(17环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4170},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_019", 20 ,{8,25,95}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};
storyList[400172] =
{

	TaskName = "帮会日常(18环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4171},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_017", 20 ,{8,14,50}},
	},	
	
};
storyList[400173] =
{

	TaskName = "帮会日常(19环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4172},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_018", 20 ,{8,57,124}},
	},	
	
};
storyList[400174] =
{

	TaskName = "帮会日常(20环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	--SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4173},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_019", 20 ,{8,25,95}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};

--40~44
storyList[400106] =
{

	TaskName = "帮会日常(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		faction = 1,
		level = {40,44},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_259", 20 ,{22,27,10}},
	},	
	
};
storyList[400107] =
{

	TaskName = "帮会日常(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4106},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_260", 20 ,{22,16,43}},
	},	
	
};
storyList[400108] =
{

	TaskName = "帮会日常(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4107},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_261", 20 ,{22,34,67}},
	},	
	
};
storyList[400109] =
{

	TaskName = "帮会日常(4环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4108},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_259", 20 ,{23,11,70}},
	},	

};
storyList[400110] =
{

	TaskName = "帮会日常(5环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4109},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_261", 20 ,{22,34,67}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};
storyList[400180] =
{

	TaskName = "帮会日常(6环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4110},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_259", 20 ,{22,27,10}},
	},	
	
};
storyList[400181] =
{

	TaskName = "帮会日常(7环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4180},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_260", 20 ,{22,16,43}},
	},	
	
};
storyList[400182] =
{

	TaskName = "帮会日常(8环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4181},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_261", 20 ,{22,34,67}},
	},	
	
};
storyList[400183] =
{

	TaskName = "帮会日常(9环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4182},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_259", 20 ,{22,27,10}},
	},	
	
};
storyList[400184] =
{

	TaskName = "帮会日常(10环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4183},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_260", 20 ,{22,16,43}},
	},	
	
};
storyList[400185] =
{

	TaskName = "帮会日常(11环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4184},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_261", 20 ,{22,34,67}},
	},	
	
};
storyList[400186] =
{

	TaskName = "帮会日常(12环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4185},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_259", 20 ,{22,27,10}},
	},	
	
};
storyList[400187] =
{

	TaskName = "帮会日常(13环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4186},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_260", 20 ,{22,16,43}},
	},	
	
};
storyList[400188] =
{

	TaskName = "帮会日常(14环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4187},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_261", 20 ,{22,34,67}},
	},	
	
};
storyList[400189] =
{

	TaskName = "帮会日常(15环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4188},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_259", 20 ,{22,27,10}},
	},	
	
};
storyList[400190] =
{

	TaskName = "帮会日常(16环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4189},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_260", 20 ,{22,16,43}},
	},	
	
};
storyList[400191] =
{

	TaskName = "帮会日常(17环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4190},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_261", 20 ,{22,34,67}},
	},	
	
};
storyList[400192] =
{

	TaskName = "帮会日常(18环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4191},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_259", 20 ,{22,27,10}},
	},	
	
};
storyList[400193] =
{

	TaskName = "帮会日常(19环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4192},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_260", 20 ,{22,16,43}},
	},	
	
};
storyList[400194] =
{

	TaskName = "帮会日常(20环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4193},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_261", 20 ,{22,34,67}},
	},	
	
};







--45~49
storyList[400111] =
{

	TaskName = "帮会日常(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		faction = 1,
		level = {45,49},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_255", 20 ,{31,23,116}},
	},	
	
};
storyList[400112] =
{

	TaskName = "帮会日常(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4111},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_256", 20 ,{31,26,59}},
	},	
	
};
storyList[400113] =
{

	TaskName = "帮会日常(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4112},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_257", 20 ,{31,8,41}},
	},	
	
};
storyList[400114] =
{

	TaskName = "帮会日常(4环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4113},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_257", 20 ,{30,7,12}},
	},	
	
};
storyList[400115] =
{

	TaskName = "帮会日常(5环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4114},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_258", 20 ,{33,26,81}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};
storyList[400200] =
{

	TaskName = "帮会日常(6环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4115},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_255", 20 ,{31,23,116}},
	},	
	
};
storyList[400201] =
{

	TaskName = "帮会日常(7环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4200},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_256", 20 ,{31,26,59}},
	},	
	
};
storyList[400202] =
{

	TaskName = "帮会日常(8环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4201},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_257", 20 ,{31,8,41}},
	},	
	
};
storyList[400203] =
{

	TaskName = "帮会日常(9环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4202},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_257", 20 ,{30,7,12}},
	},	
	
};
storyList[400204] =
{

	TaskName = "帮会日常(10环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4203},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_258", 20 ,{33,26,81}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};
storyList[400205] =
{

	TaskName = "帮会日常(11环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4204},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_255", 20 ,{31,23,116}},
	},	
	
};
storyList[400206] =
{

	TaskName = "帮会日常(12环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4205},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_256", 20 ,{31,26,59}},
	},	
	
};
storyList[400207] =
{

	TaskName = "帮会日常(13环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4206},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_257", 20 ,{31,8,41}},
	},	
	
};
storyList[400208] =
{

	TaskName = "帮会日常(14环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4207},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_257", 20 ,{30,7,12}},
	},	
	
};
storyList[400209] =
{

	TaskName = "帮会日常(15环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4208},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_258", 20 ,{33,26,81}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};
storyList[400210] =
{

	TaskName = "帮会日常(16环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4209},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_255", 20 ,{31,23,116}},
	},	
	
};
storyList[400211] =
{

	TaskName = "帮会日常(17环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4210},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_256", 20 ,{31,26,59}},
	},	
	
};
storyList[400212] =
{

	TaskName = "帮会日常(18环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4211},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_257", 20 ,{31,8,41}},
	},	
	
};
storyList[400213] =
{

	TaskName = "帮会日常(19环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4212},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_257", 20 ,{30,7,12}},
	},	
	
};
storyList[400214] =
{

	TaskName = "帮会日常(20环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4213},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_258", 20 ,{33,26,81}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};


--50~59
storyList[400116] =
{

	TaskName = "帮会日常(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		faction = 1,
		level = {50,59},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_262", 20 ,{24,51,40}},
	},	
	
};
storyList[400117] =
{

	TaskName = "帮会日常(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4116},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_263", 20 ,{24,6,41}},
	},	
	
};
storyList[400118] =
{

	TaskName = "帮会日常(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4117},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_264", 20 ,{25,20,47}},
	},	
	
};
storyList[400119] =
{

	TaskName = "帮会日常(4环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4118},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_265", 20 ,{25,15,7}},
	},	
	
};
storyList[400120] =
{

	TaskName = "帮会日常(5环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4119},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_265", 20 ,{25,58,28}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};
storyList[400220] =
{

	TaskName = "帮会日常(6环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4120},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_262", 20 ,{24,51,40}},
	},	
	
};
storyList[400221] =
{

	TaskName = "帮会日常(7环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4220},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_263", 20 ,{24,6,41}},
	},	
	
};
storyList[400222] =
{

	TaskName = "帮会日常(8环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4221},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_264", 20 ,{25,20,47}},
	},	
	
};
storyList[400223] =
{

	TaskName = "帮会日常(9环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4222},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_265", 20 ,{25,15,7}},
	},	
	
};
storyList[400224] =
{

	TaskName = "帮会日常(10环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4223},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_265", 20 ,{25,58,28}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};
storyList[400225] =
{

	TaskName = "帮会日常(11环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4224},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_262", 20 ,{24,51,40}},
	},	
	
};
storyList[400226] =
{

	TaskName = "帮会日常(12环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4225},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_263", 20 ,{24,6,41}},
	},	
	
};
storyList[400227] =
{

	TaskName = "帮会日常(13环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4226},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_264", 20 ,{25,20,47}},
	},	
	
};
storyList[400228] =
{

	TaskName = "帮会日常(14环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4227},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_265", 20 ,{25,15,7}},
	},	
	
};
storyList[400229] =
{

	TaskName = "帮会日常(15环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4228},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_265", 20 ,{25,58,28}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};
storyList[400230] =
{

	TaskName = "帮会日常(16环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4229},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_262", 20 ,{24,51,40}},
	},	
	
};
storyList[400231] =
{

	TaskName = "帮会日常(17环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4230},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_263", 20 ,{24,6,41}},
	},	
	
};
storyList[400232] =
{

	TaskName = "帮会日常(18环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4231},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_264", 20 ,{25,20,47}},
	},	
	
};
storyList[400233] =
{

	TaskName = "帮会日常(19环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4232},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_265", 20 ,{25,15,7}},
	},	
	
};
storyList[400234] =
{

	TaskName = "帮会日常(20环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4233},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_265", 20 ,{25,58,28}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};


--60~100
storyList[400121] =
{

	TaskName = "帮会日常(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		faction = 1,
		level = {60,100},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_266", 20 ,{28,8,27}},
	},	
	
};
storyList[400122] =
{

	TaskName = "帮会日常(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4121},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_266", 20 ,{28,30,24}},
	},	
	
};
storyList[400123] =
{

	TaskName = "帮会日常(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4122},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_267", 20 ,{29,14,13}},
	},	
	
};
storyList[400124] =
{

	TaskName = "帮会日常(4环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4123},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_268", 20 ,{29,9,46}},
	},	
	
};
storyList[400125] =
{

	TaskName = "帮会日常(5环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4124},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_269", 20 ,{29,15,70}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};
storyList[400240] =
{

	TaskName = "帮会日常(6环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4125},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_266", 20 ,{28,8,27}},
	},	
	
};
storyList[400241] =
{

	TaskName = "帮会日常(7环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4240},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_266", 20 ,{28,30,24}},
	},	
	
};
storyList[400242] =
{

	TaskName = "帮会日常(8环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4241},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_267", 20 ,{29,14,13}},
	},	
	
};
storyList[400243] =
{

	TaskName = "帮会日常(9环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4242},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_268", 20 ,{29,9,46}},
	},	
	
};
storyList[400244] =
{

	TaskName = "帮会日常(10环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4243},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_269", 20 ,{29,15,70}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};
storyList[400245] =
{

	TaskName = "帮会日常(11环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4244},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_266", 20 ,{28,8,27}},
	},	
	
};
storyList[400246] =
{

	TaskName = "帮会日常(12环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4245},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_266", 20 ,{28,30,24}},
	},	
	
};
storyList[400247] =
{

	TaskName = "帮会日常(13环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4246},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_267", 20 ,{29,14,13}},
	},	
	
};
storyList[400248] =
{

	TaskName = "帮会日常(14环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4247},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_268", 20 ,{29,9,46}},
	},	
	
};
storyList[400249] =
{

	TaskName = "帮会日常(15环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4248},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_269", 20 ,{29,15,70}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};
storyList[400250] =
{

	TaskName = "帮会日常(16环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4249},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_266", 20 ,{28,8,27}},
	},	
	
};
storyList[400251] =
{

	TaskName = "帮会日常(17环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4250},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_266", 20 ,{28,30,24}},
	},	
	
};
storyList[400252] =
{

	TaskName = "帮会日常(18环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4251},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_267", 20 ,{29,14,13}},
	},	
	
};
storyList[400253] =
{

	TaskName = "帮会日常(19环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},		
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4252},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_268", 20 ,{29,9,46}},
	},	
	
};
storyList[400254] =
{

	TaskName = "帮会日常(20环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "请完成帮会日常任务。",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >帮会是我家，需要大家建设它。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	----SubmitInfo = "\t<font color='#e6dfcf' >完成任务可以获得贡献牌，捐献后可以获得帮贡，帮会也会获得帮会资金。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >多谢。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4253},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "G_269", 20 ,{29,15,70}},
	},	
	--task = {4,3},	-- 发送给后台接受任务
};














storyList[400150] =
{

	TaskName = "VIP任务(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "完成VIP任务可获得大量经验",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >国家需要大家的支持。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >我代表国家感谢你的支援。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >不客气。</font>", --完成任务对话	
	HelpInfo = "(<a href='event:auction.DAuctionPanel'><u>通过<font color='#3cff00'>组队副本</font>或<font color='#ff00ff'>拍卖所</font>购买</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = 999,
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{641,5}},
	},	
	
};
storyList[400151] =
{

	TaskName = "VIP任务(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "完成VIP任务可获得大量经验",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >国家需要大家的支持。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >我代表国家感谢你的支援。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >不客气。</font>", --完成任务对话	
	HelpInfo = "(<a href='event:auction.DAuctionPanel'><u>通过<font color='#3cff00'>组队副本</font>或<font color='#ff00ff'>拍卖所</font>购买</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4150},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{641,10}},
	},	
	
};
storyList[400152] =
{

	TaskName = "VIP任务(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "完成VIP任务可获得大量经验",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >国家需要大家的支持。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >我代表国家感谢你的支援。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >不客气。</font>", --完成任务对话	
	HelpInfo = "(<a href='event:auction.DAuctionPanel'><u>通过<font color='#3cff00'>组队副本</font>或<font color='#ff00ff'>拍卖所</font>购买</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4151},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{641,20}},
	},	

};

storyList[400900] =
{

	TaskName = "跨服日常",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "在跨服活动中获取20点威望值",		-- 任务描述
	--AcceptInfo = "\t<font color='#e6dfcf' >国家需要大家的支持。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >我代表国家感谢你的支援。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >不客气。</font>", --完成任务对话	
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = 50 ,
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		eGetWW = 20,
	},	

};



storyList[400950] =
{

	TaskName = "VIP任务(1环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "完成VIP任务可获得大量经验",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >国家需要大家的支持。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >我代表国家感谢你的支援。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >不客气。</font>", --完成任务对话	
	HelpInfo = "(<a href='event:auction.DAuctionPanel'><u>通过<font color='#3cff00'>组队副本</font>或<font color='#ff00ff'>拍卖所</font>购买</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		level = 35,
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{641,5}},
	},	
	
};
storyList[400951] =
{

	TaskName = "VIP任务(2环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "完成VIP任务可获得大量经验",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >国家需要大家的支持。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >我代表国家感谢你的支援。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >不客气。</font>", --完成任务对话	
	HelpInfo = "(<a href='event:auction.DAuctionPanel'><u>通过<font color='#3cff00'>组队副本</font>或<font color='#ff00ff'>拍卖所</font>购买</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4950},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{641,10}},
	},	
	
};
storyList[400952] =
{

	TaskName = "VIP任务(3环)",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	--TaskGuide=1,						-- 任务引导
	--ClientCompleteAwards = 1 ,
	TaskInfo = "完成VIP任务可获得大量经验",		-- 任务描述
	AcceptInfo = "\t<font color='#e6dfcf' >国家需要大家的支持。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >大家一起努力。</font>", --接受任务对话
	SubmitInfo = "\t<font color='#e6dfcf' >我代表国家感谢你的支援。</font>\n\n<font color='#f8ee73' ><b>我:</b></font><font color='#6cd763' >不客气。</font>", --完成任务对话	
	HelpInfo = "(<a href='event:auction.DAuctionPanel'><u>通过<font color='#3cff00'>组队副本</font>或<font color='#ff00ff'>拍卖所</font>购买</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		completed={4951},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{641,20}},
	},	

};



storyList[400999] =
{

	TaskName = "护送海美人",		-- 任务名称
   	-- nocancel=1,						-- 不能取消
	NoTransfer = 1,					--不能传送
	TaskInfo = "请将美女护送到东海逍遥阁，路途遥远，请朋友一路保护会增大成功率。",		-- 任务描述
	ClientAcceptEvent = {				-- 客户端接受任务事件
		
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		  level = {35,999},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		
	},	
	AutoFindWay = {true,SubmitNPC = true},
};
--活动任务

storyList[600001] =
{

	TaskName = "击杀守卫",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "击杀远古遗迹的守卫",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		-- level = {40,45},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_121", 30 ,{519,31,125}},
		
	},
};
storyList[600002] =
{

	TaskName = "收集符文",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "从远古遗迹的守卫身上收集远古符文碎片",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		-- level = {40,45},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_122", 10 ,{519,43,30}},
		
	},
};
storyList[600003] =
{

	TaskName = "收集灵药",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "在远古遗迹采集千年灵芝药材",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		-- level = {40,45},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10008,20,{519,9,29,100034}}},
	},
};
storyList[600004] =
{

	TaskName = "收集炼丹炉",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "在远古遗迹采集远古修士遗留的炼丹炉",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		-- level = {40,45},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10009,10,{519,58,59,100041}}},
	},
};
storyList[600006] =
{

	TaskName = "击杀守卫",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "击杀远古遗迹的守卫",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		-- level = {46,50},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_121", 30 ,{519,31,125}},
		
	},
};
storyList[600007] =
{

	TaskName = "收集符文",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "从远古遗迹的守卫身上收集远古符文碎片",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		 -- level = {46,50},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_122", 10 ,{519,43,30}},
		
	},
};
storyList[600008] =
{

	TaskName = "收集灵药",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "在远古遗迹采集千年灵芝药材",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		-- level = {46,50},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10008,20,{519,9,29,100034}}},
	},
};
storyList[600009] =
{

	TaskName = "收集炼丹炉",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "在远古遗迹采集远古修士遗留的炼丹炉",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		 -- level = {46,50},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10009,10,{519,58,59,100041}}},
	},
};

storyList[600011] =
{

	TaskName = "击杀守卫",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "击杀远古遗迹的守卫",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		-- level = {51,55},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_121", 30 ,{519,31,125}},
		
	},
};
storyList[600012] =
{

	TaskName = "收集符文",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "从远古遗迹的守卫身上收集远古符文碎片",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		-- level = {51,55},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_122", 10 ,{519,43,30}},
		
	},
};
storyList[600013] =
{

	TaskName = "收集灵药",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "在远古遗迹采集千年灵芝药材",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		-- level = {51,55},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10008,20,{519,9,29,100034}}},
	},
};
storyList[600014] =
{

	TaskName = "收集炼丹炉",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "在远古遗迹采集远古修士遗留的炼丹炉",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		-- level = {51,55},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10009,10,{519,58,59,100041}}},
	},
};
storyList[600016] =
{

	TaskName = "击杀守卫",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "击杀远古遗迹的守卫",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		-- level = {56,60},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_121", 30 ,{519,31,125}},
		
	},
};
storyList[600017] =
{

	TaskName = "收集符文",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "从远古遗迹的守卫身上收集远古符文碎片",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		 -- level = {56,60},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_122", 10 ,{519,43,30}},
		
	},
};
storyList[600018] =
{

	TaskName = "收集灵药",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "在远古遗迹采集千年灵芝药材",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		 -- level = {56,60},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10008,20,{519,9,29,100034}}},
	},
};
storyList[600019] =
{

	TaskName = "收集炼丹炉",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "在远古遗迹采集远古修士遗留的炼丹炉",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		 -- level = {56,60},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10009,10,{519,58,59,100041}}},
	},
};

storyList[600021] =
{

	TaskName = "击杀守卫",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "击杀远古遗迹的守卫",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		 -- level = {61,65},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_121", 30 ,{519,31,125}},
		
	},
};
storyList[600022] =
{

	TaskName = "收集符文",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "从远古遗迹的守卫身上收集远古符文碎片",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		 -- level = {61,65},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_122", 10 ,{519,43,30}},
		
	},
};
storyList[600023] =
{

	TaskName = "收集灵药",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "在远古遗迹采集千年灵芝药材",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		 -- level = {61,65},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10008,20,{519,9,29,100034}}},
	},
};
storyList[600024] =
{

	TaskName = "收集炼丹炉",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "在远古遗迹采集远古修士遗留的炼丹炉",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		 -- level = {61,65},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10009,10,{519,58,59,100041}}},
	},
};
storyList[600026] =
{

	TaskName = "击杀守卫",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "击杀远古遗迹的守卫",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		--	level = {66,100},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_121", 30 ,{519,31,125}},
		
	},
};
storyList[600027] =
{

	TaskName = "收集符文",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "从远古遗迹的守卫身上收集远古符文碎片",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		-- level = {66,100},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		kill = { "M_122", 10 ,{519,43,30}},
		
	},
};
storyList[600028] =
{

	TaskName = "收集灵药",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "在远古遗迹采集千年灵芝药材",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		 -- level = {66,100},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10008,20,{519,9,29,100034}}},
	},
};
storyList[600029] =
{

	TaskName = "收集炼丹炉",		-- 任务名称
	TaskGuide=1,						-- 任务引导
	TaskInfo = "在远古遗迹采集远古修士遗留的炼丹炉",		-- 任务描述
	NoTransfer = 1,						--不能传送
	HelpInfo = "(<a href='event:active.DActiveSoulMansion'><u>远古遗迹只在<font color='#3cff00'>活动时间</font>开启</u></a>)",
	ClientAcceptEvent = {				-- 客户端接受任务事件
	},	
	ClientSumitEvent = {				-- 客户端提交任务事件
	},	
	CleintAcceptCondition = 			-- 客户端接受任务条件
	{
		 -- level = {66,100},
	},
	ClientCompleteCondition = 			-- 客户端完成任务条件
	{
		items = {{10009,10,{519,58,59,100041}}},
	},
};



--主线剧情结束后的回调执行
storyEvent = {
--获得坐骑
--[1000002] = "SubmitNPC=37",
[1000132] = "Position2=1,36,169",
--哪吒自刎
[1000005] = "SubmitNPC=155",
--变身演示
[1000007] = "SubmitNPC=202",
[1000009] = "SubmitNPC=202",
[1000010] = "SubmitNPC=202",
[1000136] = "trans=3,90,175,9",
};
