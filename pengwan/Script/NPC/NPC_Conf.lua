--[[
file:	NPC_conf.lua
desc:	npc config(S&C)1
author:	chal
update:	2011-11-30
version: 1.0.0

NPC配置改动说明:
	1、现在通过在NPC配置里面加一个NpcType字段来区分前台如何处理
	2、NpcType: 
		[nil] 弹默认面板 (主要用于任务NPC和功能性NPC)
		NpcFunction = {
				{"clientFunc", "组队副本(35级)",type=4},	-- NPC选项1
				{"clientFunc", "塔防副本(50级)",type=5},	-- NPC选项2
			},
		},
		[1] 弹自定义面板 (主要用于特殊处理NPC、例如:摇钱树)
		NpcFunction = {
				panel = 1,	-- 摇钱树面板
				panel = 2,	-- 宴会面板
				panel = 3,	-- 悬赏面板
				panel = 4,	-- 妲己面板
				panel = 17,	-- 组队副本
				panel = 25,	-- 跨服竞技报名官
			},
		},
		[2] 发送click消息 (主要用于动态NPC、例如:收集类NPC、副本机关NPC)
		Refresh=2,采集后移除,2秒后重刷
固定NPC：（对于副本内NPC有任务的可以配置在400000以下）
	(1 ~ 399999)
	普通剧情类NPC和功能NPC可自己分段
	(100000 ~ 200000)--采集,regonid=0为动态场景

动态NPC:
	(400000 ~ 699999) 

循环创建类NPC：
	(701000 ~ 999999)（1000递增）  	千实例类NPC （同一个NPC最多循环创建1000个）
	(100000 ~ +oo)（10000递增） 	万实例类NPC	（同一个NPC最多循环创建10000个）

]]--

npclist = {}

npclist = {
--新手村1
	[1] = {
	NpcCreate = { regionId = 3 , name = "姜子牙" , title = '姜子牙' , npcimg=11006, imageId = 1006,headID=1006, x = 95 , y = 154 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '太极未判昏已过。风后女娲石上坐。三皇五帝己派相。承宗流源应不错。而今天下一统周。礼乐文章八百秋。', },
	},
	-- [2] = {
	-- NpcCreate = { regionId = 3 , name = "金霞童子" , title = '金霞童子' ,  npcimg=11016, imageId = 1016,headID=1016, x = 91 , y = 139 , dir = 5, objectType = 1 , mType = 0,},
	-- NpcInfo = { talk = '师傅正在大发雷霆，我躲远点！', },
	-- },
	-- [3] = {
	-- NpcCreate = { regionId = 3 , name = "太乙真人" , title = '太乙真人' , npcimg=12050, imageId = 1231, headID=2050, x = 81 , y = 129 , dir = 4 , objectType = 1 , mType = 0,},
	-- NpcInfo = { talk = '身在此山中，云深不知处。', },
	-- },
	[4] = {
	NpcCreate = { regionId = 3 , name = "小师妹宁宁" , title = '小师妹宁宁' , npcimg=11007, imageId = 1007,headID=1007, x = 54 , y = 151 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '看来药草要成熟了，我采啊采啊采啊采。。。。', },
	},
	[5] = {
	NpcCreate = { regionId = 3 , name = "彤云仙子" , title = '彤云仙子' , npcimg=12062, imageId = 1232,headID=2062, x = 91 , y = 175 ,  dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '最近哪里来的一些狂徒，竟然跑来昆仑山挑衅，真是讨厌。', },
	},
	[6] = {
	NpcCreate = { regionId = 3 , name = "二郎神-杨戬" , title = '二郎神-杨戬' , npcimg=12058, imageId = 1233,headID=2058, x = 104 , y = 201 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '天地正气，浩然于胸，我等修行者，必当自强不息。', },
	},
	-- [7] = {
	-- NpcCreate = { regionId = 3 , name = "邪剑客头目" , title = '邪剑客头目' , npcimg=12026, imageId = 1234,headID=2026, x = 71 , y = 164 , dir = 5 , objectType = 1 , mType = 0,},
	-- NpcInfo = { talk = '据说昆仑山有仙丹出世，偷吃一颗可以增寿百年，看看有没有机会,嘿嘿......', },
	-- },
	[8] = {
	NpcCreate = { regionId = 3 , name = "二师姐" , title = '二师姐' , npcimg=11008, imageId = 1008,headID=1008, x = 67 , y = 143 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '昆仑山的景色，还是云海最漂亮。', },
	},
	-- [9] = {
	-- NpcCreate = { regionId = 3 , name = "三师姐" , title = '三师姐' , npcimg=11008, imageId = 1008,headID=1008, x = 91 , y = 175 , dir = 5, objectType = 1 , mType = 0,},
	-- NpcInfo = { talk = '这瀑布真壮观。', },
	-- },
	-- [29] = {
	-- NpcCreate = { plat = 101 , regionId = 1 , name = "360会员特权使者" , title = '360会员特权使者' ,  npcimg=12061,imageId = 1215,headID=1021, x = 37 , y = 107 , dir = 5, objectType = 1 , mType = 10,},
	-- NpcInfo = { talk = '登录360安全卫士，即可成为尊贵的360会员，领取专享特权礼包。等级越高，道具越丰厚哦~', },
	-- NpcFunction = {
				-- {"clientFunc", "立刻领取",type=26},
			-- },
	-- },
--京城NPC
	[30] = {
	NpcCreate = { regionId = 1 , name = "城防士兵" ,  npcimg=11011, imageId = 1011,headID=1011, x = 16 , y = 137 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '来人止步，请出示证件！', },
	},
	[31] = {
	NpcCreate = { regionId = 1 , name = "队长王小二" ,  npcimg=11011, imageId = 1011,headID=1011, x = 45 , y = 105 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '天干物燥，小心火烛！', },
	},
	[32] = {
	NpcCreate = { regionId = 1 , name = "药品商" , title = '药品商' , npcimg=11015, imageId = 1022,headID=1022, x = 73 , y = 150 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '来买点药吧，人在江湖飘，哪能不挨刀啊！', },
	NpcFunction = {
				{"clientFunc", "购买药品",type=8},
			},
	},
	[33] = {
	NpcCreate = { regionId = 1 , name = "城防武官" ,  npcimg=11012, imageId = 1012,headID=1012, x = 36 , y = 55 , dir = 4 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '只要我有一口气在，就要保证西岐固若金汤，安全无虞。', },
	},
	[34] = {
	NpcCreate = { regionId = 1 , name = "苏府护院" ,  npcimg=11011, imageId = 1011,headID=1011, x = 39 , y = 26 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '维护苏府的安全是我的职责。', },
	},
	[35] = {
	NpcCreate = { regionId = 1 , name = "苏府侍女" ,  npcimg=11021, imageId = 1021,headID=1021, x = 30 , y = 153 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '希望老爷能快点找回妲己小姐。', },
	},
	[36] = {
	NpcCreate = { regionId = 1 , name = "苏护" , title = '苏护' , npcimg=12053, imageId = 2054,headID=2054, x = 58 , y = 24 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '天可怜见，终于我们一家团圆。', },
	},
	[37] = {
	NpcCreate = { regionId = 1 , name = "苏府管家" ,  npcimg=11015, imageId = 1015,headID=1015, x = 44 , y = 10 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '苏府的钥匙都在我这，我一定要帮老爷看好仓库。', },
	},
	[38] = {
	NpcCreate = { regionId = 1 , name = "武成王-黄飞虎" , title = '武成王-黄飞虎' , npcimg=12056, imageId = 2056,headID=2056, x = 81 , y = 61 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = "在组队副本有可能获得“<font color='#f8ee73' >寒铁矿石</font>”,你如果能交给我，我就奖励你<font color='#f8ee73' >大量经验</font>。\n    捐献铜钱，可获得每日奖励，还有机会获得“<font color='#f8ee73' >爵位称号</font>”！", },
	NpcFunction = {
					{"clientFunc", "我要捐献铜钱",type=17},
			},
	},
	[39] = {
	NpcCreate = { regionId = 1 , name = "仓库管理员" , title = '仓库' ,iconID = 2, npcimg=11015, imageId = 1015,headID=1015, x = 85 , y = 94 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '我的保险柜，可是经过国际ISO的N级认证的哦！', },
	NpcFunction = {
					{"clientFunc", "打开仓库",type=2},
			},
	},
	[40] = {
	NpcCreate = { regionId = 1 , name = "金吒" ,  npcimg=12059, imageId = 2059,headID=2059, x = 108 , y = 95 , dir = 4 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '平时多流一身汗,战时少淌一滴血!', },
	},
	[41] = {
	NpcCreate = { regionId = 1 , name = "孙老板" , npcimg=11214,imageId = 1214,headID=1008, x = 91 , y = 130 , dir = 4 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '来来来，全手工制作布艺品，完全手绘，不可错过！', },
	},
	[42] = {
	NpcCreate = { regionId = 1 , name = "余神医" ,  npcimg=11014, imageId = 1014,headID=1014, x = 52 , y = 141 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '不贴小广告，不乱收费，专治各种隐疾，童叟无欺！', },
	},
	[43] = {
	NpcCreate = { regionId = 1 , name = "周文王-姬昌" , title = '周文王-姬昌' , npcimg=11003, imageId = 1003,headID=1003, x = 109 , y = 24 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '自吾先君太公曰『当有圣人适周，周以兴』。子真是邪？吾太公望子久矣。', },
	},

	[45] = {
	NpcCreate = { regionId = 1 , name = "富家小姐" ,npcimg=11021, imageId = 1021,headID=1021, x = 17 , y = 99 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '关关雎鸠，在河之洲，窈窕淑女，君子好逑。', },
	},
	[46] = {
	NpcCreate = { regionId = 1 , name = "红娘" , title = '红娘' ,npcimg=11222, imageId = 1222,headID=1222, x = 13 , y = 74 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '愿天下有情的，都成了眷属。是前生注定事，莫错过姻缘。', },
	NpcFunction = {
				{"clientFunc", "领取称号",type=14},
			},
	},
	[47] = {
	NpcCreate = { regionId = 1 , name = "月老" , title = '月老' , npcimg=11211,imageId = 1211,headID=1014, x = 5 , y = 60 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '巧妻长拌拙夫眠,千里姻缘使线牵。世事都从愁里过,月如无恨月常圆。', },
	NpcFunction = {
				{"clientFunc", "召开婚宴",type=13},
				{"clientFunc", "协议离婚",type=15},
				{"clientFunc", "强制离婚",type=16},				
			},
	},
	[48] = {
	NpcCreate = { regionId = 1 , name = "姜子牙" , title = '姜子牙' , npcimg=11006, imageId = 1034,headID=1006, x = 101 , y = 31 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '太极未判昏已过。风后女娲石上坐。三皇五帝己派相。承宗流源应不错。而今天下一统周。礼乐文章八百秋。', },
	},
	[49] = {
	NpcCreate = { regionId = 1 , name = "周武王-姬发" , title = '周武王-姬发' , npcimg=11002, imageId = 1002,headID=1002, x = 106 , y = 39 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '纣王无道，当举国伐之!', },
	},
	[50] = {
	NpcCreate = { regionId = 1 , name = "悬赏榜" , title = '悬赏榜' ,iconID=7, imageId = 1031,headID=1031, x = 70 , y = 61 , dir = 0 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '悬赏任务', },
	NpcType = 1,
	NpcFunction = {
				panel = 3,
			},
	},
	[51] = {
	NpcCreate = { regionId = 1 , name = "宝石副本" , title = '宝石' ,iconID=5,  imageId = 2061,headID=2061, x = 61 , y = 63 , dir = 4 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '东海盛产宝石，每日一次不可错过。', },
	NpcType = 1,
	NpcFunction = {
				panel = 6,
			},
	},
	[52] = {
	NpcCreate = { regionId = 1 , name = "组队副本" , title = '组队' ,iconID=4, npcimg=12055, imageId = 2055,headID=2055, x = 67 , y = 106 , dir = 4 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '组队副本收益丰厚，可以获得大量非绑定的贵重品，每日不可错过。', },
	NpcFunction = {
				{"clientFunc", "组队副本",type=4},
			},
	},
	[53] = {
	NpcCreate = { regionId = 1 , name = "护送海美人" , title = '护送' ,iconID = 1, npcimg=12061, imageId = 2002,headID=2002, x = 86 , y = 77 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '海族美人，谁能帮我送回东海啊？', },
	NpcType = 1,
	NpcFunction = {
				panel = 5,
			},
	},
	[54] = {
	NpcCreate = { regionId = 1 , name = "沙滩美女" , title = '沙滩' ,iconID=8, npcimg=11039, imageId = 1039,headID=1039, x = 46 , y = 77 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '阳光沙滩，美女多多哦！', },
	NpcFunction = {
				{"call", "沙滩钓鱼",func = "EnterDongHai"},
			},
	},
	[55] = {
	NpcCreate = { regionId = 1 , name = "远古遗迹" , title = '远古遗迹' , iconID=13, npcimg=11008, imageId = 1008,headID=1008, x = 17 , y = 9 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '欢迎光临！', },
	NpcType = 1,
	NpcFunction = {
				panel = 16,
			},
	},
	[56] = {
	NpcCreate = { regionId = 1 , name = "二郎神-杨戬" ,title = '二郎神-杨戬' ,  npcimg=12058, imageId = 2058,headID=2058, x = 69 , y = 36 , dir = 4 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '愿助子牙师叔讨伐商纣，早日完成封神大业!', },
	},
	
	[57] = {
	NpcCreate = { regionId = 1 , name = "修炼使者" ,title = '挂机修炼' , npcimg=12059, imageId = 1219,headID=1219, x = 9 , y = 98 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '海底迷阵挂机，不但经验丰厚，还会掉落许多贵重道具!', },
	NpcFunction = {
				{"call", "挂机修炼",func = "EnterGuajia"},
			},
	},
	[58] = {
	NpcCreate = { regionId = 1 , name = "周跑环任务",title = '周跑环任务' , iconID=14, npcimg=12062, imageId = 1232,headID=2062, x = 70 , y = 137 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '周跑环任务，奖励非常丰厚哦！', },
	},		
	[59] = {
	NpcCreate = { regionId = 1 , name = "铜钱副本" , title = '铜钱' , iconID=10, imageId = 1232,headID=2062, x = 55 , y = 66 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '铜钱多多，每日不可错过!', },
	NpcType = 1,
	NpcFunction = {
				panel = 7,
			},
	},
	
	[60] = {
	NpcCreate = { regionId = 1 , name = "塔防副本" , title = '塔防' , iconID=3, imageId = 2052,headID=2052, x = 76 , y = 105 , dir = 4 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '高难度考验，但是掉落大量传说之石，可以合成橙色装备哦!', },
	NpcType = 1,
	NpcFunction = {
				panel = 8,
			},
	},
	[61] = {
	NpcCreate = { regionId = 1 , name = "经验副本" , title = '经验副本',iconID=12, npcimg=12050,imageId = 2051,headID=2051, x = 45 , y = 86 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '经验副本中，每日可以获得大量经验!', },
	NpcType = 1,
	NpcFunction = {
				panel = 15,
			},
	},
	[62] = {
	NpcCreate = { regionId = 1 , name = "水果铺" ,   npcimg=11021,imageId = 1025,headID=1025, x = 56 , y = 133 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '新鲜的水果啦!', },
	},
	[63] = {
	NpcCreate = { regionId = 1 , name = "罗公子" ,   npcimg=11020, imageId = 1020,headID=1020, x = 83 , y = 124 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '这布匹不错，要不要给娘子做件新衣服呢？', },
	},
	[64] = {
	NpcCreate = { regionId = 1 , name = "轿夫" ,  npcimg=11017,  imageId = 1017,headID=1017, x = 22 , y = 97 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '客官要不要坐轿？100文就可以周游西岐城！', },
	},
	[65] = {
	NpcCreate = { regionId = 1 , name = "夫妻副本", title = '夫妻副本',iconID=22,  imageId = 1020,headID=1020, x = 16 , y = 69 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 23,
			},
	},
	[66] = {
	NpcCreate = { regionId = 1 , name = "乞丐" ,   npcimg=11026, imageId = 1026,headID=1026, x = 6 , y = 164 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '朱门酒肉臭，路有冻死骨啊！', },
	},
	
	[68] = {
	NpcCreate = { regionId = 1 , name = "谢小妹" ,  npcimg=11021, imageId = 1025,headID=1025, x = 14 , y = 46 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '卖雨伞，饥带饱粮，晴带雨伞啊！', },
	},
	[69] = {
	NpcCreate = { regionId = 1 , name = "礼乐官" ,    npcimg=11013, imageId = 1013,headID=1013, x = 90 , y = 26 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '说起礼乐，这个周公之礼，大家明白的吧！', },
	},
	[70] = {
	NpcCreate = { regionId = 1 , name = "礼乐官" ,  npcimg=11013, imageId = 1013,headID=1013, x = 107 , y = 49 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '编钟敲击起来真带劲，礼乐官也是个力气活啊！', },
	},
	[71] = {
	NpcCreate = { regionId = 1 , name = "历练副本" , title = '历练副本',iconID=20, imageId = 2063,headID=2063, x = 46 , y = 94 , dir = 3 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 21,
			},
	},
	[72] = {
	NpcCreate = { regionId = 1 , name = "坐骑装备" , title = '坐骑装备',iconID=21, imageId = 2060,headID=2060, x = 88 , y = 85 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 22,
			},
	},
	[73] = {
	NpcCreate = { regionId = 1 , name = "升星副本", title = '升星副本',iconID=23, imageId = 2057,headID=2057,  x = 66 , y = 63 , dir = 4 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 24,
			},
	},
	[74] = {
	NpcCreate = { regionId = 1 , name = "单人塔防", title = '单人塔防',iconID=24, imageId = 2065,headID=2065,  x = 60 , y = 104 , dir = 4 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 26,
			},
	},	
	
--西岐郊野NPC	
	[101] = {
	NpcCreate = { regionId = 6 , name = "受伤的村民" , title = '受伤的村民' , npcimg=11209,  imageId = 1209,headID=1024, x = 22 , y = 124 , dir = 4 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '好多妖怪啊，谁来救救我！', },
	},
	[102] = {
	NpcCreate = { regionId = 6 , name = "老村长" , title = '老村长' , npcimg=11023, imageId = 1023,headID=1023, x = 59 , y = 86 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '叶落归根，就算是妖物也别向让我离开，我是最牛钉子户。', },
	},
	[103] = {
	NpcCreate = { regionId = 6 , name = "刘大娘" , title = '刘大娘' ,npcimg=11200,  imageId = 1200,headID=1200, x = 61 , y = 49 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '妖怪别吃我啊，我都一把老骨头了，咬不动啊。', },
	},
	[104] = {
	NpcCreate = { regionId = 6 , name = "无名侠士" , title = '无名侠士' , npcimg=11217,  imageId = 1217,headID=1217, x = 48 , y = 49 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '妖物太多，可恨我学艺不精，无力继续除妖啊。', },
	},
	[105] = {
	NpcCreate = { regionId = 6 , name = "守陵人" , title = '守陵人' , npcimg=11009, imageId = 1009,headID=1009, x = 5 , y = 69 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '瘴气越来越重，冤魂都跑出来了！', },
	},
	[106] = {
	NpcCreate = { regionId = 6 , name = "冤魂统领" ,  npcimg=11010, imageId = 1010,headID=1010, x = 16 , y = 40 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '血......肉......饥渴......', },
	},
	[107] = {
	NpcCreate = { regionId = 6 , name = "无助的村民" , npcimg=11201,  imageId = 1201,headID=1024, x = 56 , y = 126 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '唉，这日子可怎么过啊~', },
	},
	[108] = {
	NpcCreate = { regionId = 6 , name = "惊恐的村民" ,  npcimg=11024, imageId = 1024,headID=1024, x = 38 , y = 82 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '好多，好多妖怪啊!救命啊~', },
	},
	
	--陈塘关NPC
	[150] = {
	NpcCreate = { regionId = 8 , name = "总兵府管家" , title = '总兵府管家' , npcimg=11015, imageId = 1015,headID=1015, x = 67 , y = 15 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '你好，我们家老爷不在家！', },
	},
	[151] = {
	NpcCreate = { regionId = 8 , name = "酒楼老板" , title = '酒楼老板' ,npcimg=11022, imageId = 1022,headID=1022, x = 30 , y = 24 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '唉，现在的生意不好做啊！', },
	},
	[152] = {
	NpcCreate = { regionId = 8 , name = "城防队长" , title = '城防队长' ,npcimg=11210,  imageId = 1210,headID=1011, x = 30 , y = 63 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '大家不要害怕瘟疫，注意石灰消毒，饭前便后多洗手......', },
	},
	[153] = {
	NpcCreate = { regionId = 8 , name = "药店老板" , title = '药店老板' , npcimg=11014, imageId = 1014,headID=1014, x = 47 , y = 74 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '这种瘟疫不同寻常，药物竟然完全无效，奇怪。', },
	},
	[154] = {
	NpcCreate = { regionId = 8 , name = "玄慈大师" , title = '玄慈大师' , npcimg=11205, imageId = 1205,headID=1205, x = 8 , y = 43 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '施主，看你面相，与我佛有缘啊！', },
	},
	[155] = {
	NpcCreate = { regionId = 8 , name = "托塔天王-李靖" , title = '陈塘关总兵' , npcimg=12051, imageId = 2051,headID=2051, x = 57 , y = 55 , dir = 4, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '可恶，镇妖塔里的妖气为何散播出来了？', },
	},
	[156] = {
	NpcCreate = { regionId = 8 , name = "失业的渔民" , title = '失业的渔民' , npcimg=11026, imageId = 1026,headID=1026, x = 64 , y = 99 , dir = 4, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '可恶，最近这些海族是怎么了？如此狂暴。', },
	},
	[157] = {
	NpcCreate = { regionId = 8 , name = "哪吒" , title = '哪吒' , npcimg=12052, imageId = 2052,headID=2052, x = 67 , y = 134 , dir = 4, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '哪里来的小龙？正好抽了筋，给我爹爹做条腰带。', },
	},
	[158] = {
	NpcCreate = { regionId = 8 , name = "马大嫂" , title = '马大嫂' , npcimg=11200,  imageId = 1200,headID=1200, x = 31 , y = 127 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '我那可怜的丹妹啊~', },
	},
	[159] = {
	NpcCreate = { regionId = 8 , name = "海商" , title = '海商' ,npcimg=11013, imageId = 1207,headID=1013, x = 42 , y = 114 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '唉，无法出海，让人怎么活啊！', },
	},
	[160] = {
	NpcCreate = { regionId = 8 , name = "船夫三水" , title = '船夫三水' , npcimg=11017, imageId = 1017,headID=1017, x = 14 , y = 94 , dir = 4, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '什么时候才能出海啊！', },
	},
	[161] = {
	NpcCreate = { regionId = 8 , name = "木工肖师傅" , title = '木工肖师傅' , npcimg=11017, imageId = 1206,headID=1017, x = 53 , y = 85 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '不要着急，慢慢来。', },
	},
	

	
	--乾元山NPC
	[200] = {
	NpcCreate = { regionId = 7 , name = "修仙童子" , title = '修仙童子' , npcimg=11016, imageId = 1016,headID=1016, x = 80 , y = 26 , dir = 4, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '有朋自远方来，不亦乐乎！', },
	},
	[201] = {
	NpcCreate = { regionId = 7 , name = "天蝉子" , title = '天蝉子' , npcimg=12060, imageId = 1203,headID=1020, x = 71 , y = 53 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '师傅正在棋盘崖修行，你们上去就可以见到他。', },
	},
	[202] = {
	NpcCreate = { regionId = 7 , name = "太乙真人" , title = '太乙真人' ,npcimg=12050,  imageId = 2050,headID=2050, x = 41 , y = 17 , dir = 4, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '吾徒儿哪吒命中有此一劫，天数不可违！', },
	},
	[203] = {
	NpcCreate = { regionId = 7 , name = "天星子" , title = '天星子' , npcimg=11218, imageId = 1218,headID=1218, x = 42 , y = 44 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '日日餐风饮露，要是来点酒肉就更好了。', },
	},
	[204] = {
	NpcCreate = { regionId = 7 , name = "哪吒" , title = '莲花童子' , npcimg=12052, imageId = 2052,headID=2052, x = 54 , y = 78 , dir = 4, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '两朵莲花现化身，灵珠二世出凡尘；手提紫焰蛇牙宝，脚踏金霞风火轮。豹皮囊内安天下，红锦绫中福世民；历代圣人为第一，史官遗笔万年新。', },
	},
	[205] = {
	NpcCreate = { regionId = 7 , name = "青松居士" , title = '青松居士' , npcimg=11013, imageId = 1207,headID=1013, x = 28 , y = 54 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '乾元山上皆是灵兽，非不得已，不可随意杀生。', },
	},
	[206] = {
	NpcCreate = { regionId = 7 , name = "金霞童子" , title = '金霞童子' , npcimg=11016, imageId = 1016,headID=1016, x = 28 , y = 77 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '乾元后山最近好像不太对劲，莫非又有什么成精了？', },
	},
	[207] = {
	NpcCreate = { regionId = 7 , name = "天虹子" , title = '天虹子' , npcimg=11008, imageId = 1008,headID=1008, x = 7 , y = 44 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '师傅说天地大劫将至，气运混乱，就连我们乾元山也出现了妖物，唉。', },
	},
	[208] = {
	NpcCreate = { regionId = 7 , name = "守洞童子" ,  npcimg=11016, imageId = 1016,headID=1016, x = 10 , y = 20 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '金光洞最近妖风阵阵，鬼哭狼嚎，莫非有妖物潜入了？', },
	},
	--[[
	[209] = {
	NpcCreate = { regionId = 32 , name = "人鱼族使者" , title = '人鱼族使者' , npcimg=12061,imageId = 1215,headID=1021, x = 50 , y = 48 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '多谢英雄，送回我族子民。', },
	NpcFunction = {
				{"call", "完成护送",func = "GI_endescortnpc"},
			},
	},
	]]--
	[210] = {
	NpcCreate = { regionId = 32 , name = "人鱼族接引使" , title = '人鱼族接引使' , npcimg=12061,imageId = 1221,headID=1021, x = 49 , y = 9 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '多谢英雄，送回我族子民。', },
	NpcFunction = {
				{"call", "完成护送",func = "GI_endescortnpc"},
			},
	},
	
	[211] = {
		NpcCreate = { regionId = 7 , name = "莲花仙子" , npcimg=11008,imageId = 1164,headID=1164, x = 46 , y = 96 , dir = 0 , objectType = 1 , mType = 0},		
		NpcInfo = { talk = '出淤泥而不染，濯清涟而不妖。', },	
		},	
	[212] = {
		NpcCreate = { regionId = 7 , name = "荷花池美女" , imageId = 1163,headID=1163, x = 43 , y = 87 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[213] = {
		NpcCreate = { regionId = 7 , name = "荷花池美女" , imageId = 1169,headID=1169, x = 51 , y = 93 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	--乾元后山	
	[215] = {
	NpcCreate = { regionId = 34 , name = "青松居士" , title = '青松居士' , npcimg=11013, imageId = 1207,headID=1013, x = 8 , y = 18 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '乾元山上皆是灵兽，非不得已，不可随意杀生。', },
	},	
	[216] = {
	NpcCreate = { regionId = 34 , name = "天蝉子" , title = '天蝉子' , npcimg=12060, imageId = 1203,headID=1020, x = 32 , y = 22 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '这里怎么变得鬼气森森，一定有蹊跷。', },
	},
	[217] = {
	NpcCreate = { regionId = 34 , name = "天星子" , title = '天星子' , npcimg=11218, imageId = 1218,headID=1218, x = 11 , y = 50 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '整日修行，好久不曾出手，妖物们都欺上门了！', },
	},
	[218] = {
	NpcCreate = { regionId = 34 , name = "天虹子" , title = '天虹子' , npcimg=11008, imageId = 1008,headID=1008, x = 39 , y = 90 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '看来今日，我剑下又要沾上妖魔的鲜血了。', },
	},
	[219] = {
	NpcCreate = { regionId = 34 , name = "魔界修士" , title = '魔界修士' ,  npcimg=11010, imageId = 1010,headID=1010, x = 4 , y = 75 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '乾元山是好地方啊，灵气充沛，如果能为我所用......嘿嘿......', },
	},
	
	--沙滩NPC
	[250] = {
	NpcCreate = { regionId = 100 , name = "贝壳仙子" , imageId = 1152,headID=1152, x = 28 , y = 29, dir = 0 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 11,
			},
	},
	[251] = {
	NpcCreate = { regionId = 100 ,  name = "海螺公主" , imageId = 1153,headID=1153, x = 38 , y = 18 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 11,
			},
	},
	[252] = {
	NpcCreate = { regionId = 100 , name = "海美人" , imageId = 1154,headID=1154, x = 34 , y = 28 , dir = 0 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 11,
			},
	},
	[253] = {
	NpcCreate = { regionId = 100 , name = "小龙女" , imageId = 1155,headID=1155, x = 38 , y = 23 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 11,
			},
	},
	[254] = {
	NpcCreate = { regionId = 100 , name = "海洋精灵" , imageId = 1156,headID=1156, x = 20 , y = 42 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 11,
			},
	},
	[255] = {
	NpcCreate = { regionId = 100 , name = "听风美人" , imageId = 1157,headID=1157, x = 19 , y = 40 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 11,
			},
	},
	[256] = {
	NpcCreate = { regionId = 100 , name = "美人鱼" , imageId = 1158,headID=1158, x = 16 , y = 37 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 11,
			},
	},
	[257] = {
	NpcCreate = { regionId = 100 ,  name = "白云仙女" , imageId = 1159,headID=1159, x = 28 , y = 22 , dir = 0 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 11,
			},
	},
		--运镖
	[258] = {
	NpcCreate = { regionId = 11 , name = "帮会总管" ,iconID=15, title = '帮会总管' , npcimg=11013, imageId = 1013,headID=1013, x = 6 , y = 104 , dir = 3 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '在我这里可以护送美人们前往天庭！', },
	NpcFunction = {
			{"clientFunc", "开始护送(帮主或副帮主)",type=9},
			{"clientFunc", "投注押金",type=11},
		},
	},
	[259] = {
	NpcCreate = { regionId = 11 , name = "天宫主管" , iconID=15, title = '天宫主管' ,npcimg=11013, imageId = 1013,headID=1013, x = 123 , y = 25 , dir = 5 , objectType = 1 , mType = 0,},
	NpcInfo = { talk = '天庭选秀开始了，召集天下美人送入天庭！', },
	NpcFunction = {
			{"clientFunc", "完成护送",type=10},
		},
	},
	
	[260] = {
	NpcCreate = { regionId = 100 , name = "鱼饵兑换" , title = '鱼饵兑换',iconID=19,npcimg=11039, imageId = 1039,headID=1039, x = 23 , y = 35 , dir = 3 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 20,
			},
	},


	--竞技场NPC
	[280] = {
	NpcCreate = { regionId = 101 ,  name = "竞技报名官" ,iconID=9, imageId = 2058,headID=2058, x = 16 , y = 9 , dir = 4 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 25,
			},
	},
	[281] = {
	NpcCreate = { regionId = 101 ,  name = "竞技报名官" ,iconID=9, imageId = 1012,headID=1012, x = 10 , y = 10 , dir = 3 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 25,
			},
	},
	[282] = {
	NpcCreate = { regionId = 101 ,  name = "竞技报名官" ,iconID=9, imageId = 1012,headID=1012, x = 5 , y = 15 , dir = 3 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 25,
			},
	},
	[283] = {
	NpcCreate = { regionId = 101 ,  name = "竞技报名官" ,iconID=9, imageId = 1012,headID=1012, x = 4 , y = 24 , dir = 3 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 25,
			},
	},
	[284] = {
	NpcCreate = { regionId = 101 ,  name = "竞技报名官" ,iconID=9, imageId = 1012,headID=1012, x = 27 , y = 24 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 25,
			},
	},
	[285] = {
	NpcCreate = { regionId = 101 ,  name = "竞技报名官" ,iconID=9, imageId = 1012,headID=1012, x = 26 , y = 15 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 25,
			},
	},
	[286] = {
	NpcCreate = { regionId = 101 ,  name = "竞技报名官" ,iconID=9, imageId = 1012,headID=1012, x = 22 , y = 10 , dir = 5 , objectType = 1 , mType = 0,},
	NpcType = 1,
	NpcFunction = {
				panel = 25,
			},
	},
	--渭水NPC
	[300] = {
	NpcCreate = { regionId = 10 , name = "李大爷" , title = '李大爷',  npcimg=11023, imageId = 1023,headID=1023, x = 11 , y = 120 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '外面兵荒马乱的，小孩子还是留在家里比较安全.', },
	},
	[301] = {
	NpcCreate = { regionId = 10 , name = "小妹妹" ,   npcimg=11007, imageId = 1007,headID=1007, x = 12 , y = 118 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '我想去读书，但是爷爷说外面好危险.', },
	},
	[302] = {
	NpcCreate = { regionId = 10 , name = "教书先生" , title = '教书先生',  npcimg=11013, imageId = 1207,headID=1013, x = 30 , y = 159 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '唉，学生们都回家，不敢来上课了，这可怎么办啊.', },
	},
	[303] = {
	NpcCreate = { regionId = 10 , name = "书童" , title = '书童',  npcimg=11016, imageId = 1016,headID=1016, x = 41 , y = 165 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '这私塾紧靠着渭水，河里有妖物捣乱，小孩子们能不害怕么？所以都不敢来读书了.', },
	},
	[304] = {
	NpcCreate = { regionId = 10 , name = "酒店老板" , title = '酒店老板', npcimg=11022, imageId = 1022,headID=1022, x = 10 , y = 149 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '这些亡命之徒一直霸占市场，生意都没法做了，唉!', },
	},
	[305] = {
	NpcCreate = { regionId = 10 , name = "渭水渔夫" , title = '渭水渔夫' , npcimg=11017, imageId = 1017,headID=1017, x = 48 , y = 100 , dir = 4, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '河里怎么会突然出现一些河妖，唉，以后怎么过日子啊！', },
	},
	[306] = {
	NpcCreate = { regionId = 10 , name = "邓婵玉" , title = '邓婵玉' , npcimg=11008, imageId = 2057,headID=2057, x = 25 , y = 70 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '魔家四兄弟个个本领神奇，不可大意!', },
	},
	[307] = {
	NpcCreate = { regionId = 10 , name = "雷震子" , title = '雷震子' , npcimg=12055, imageId = 2055,headID=2055, x = 8 , y = 31 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '哈哈，敌军再多都不怕，通通受死吧!', },
	},
	[308] = {
	NpcCreate = { regionId = 10 ,  name = "金吒",title = "金吒" ,  npcimg=12059, imageId = 2059,headID=2059, x = 39 , y = 20 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '哈哈，敌军再多都不怕，通通受死吧!', },
	},
	[309] = {
	NpcCreate = { regionId = 10 , name = "渔娘" ,title = "渔娘" ,npcimg=11202, imageId = 1202,headID=1202, x = 29 , y = 126 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '唉，这可叫我们如何过活啊!', },
	},
	[310] = {
	NpcCreate = { regionId = 10 , name = "青年男子" , npcimg=11024, imageId = 1024,headID=1024, x = 64 , y = 79 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '在天愿作比翼鸟!', },
	},
	[311] = {
	NpcCreate = { regionId = 10 , name = "青年女子" , npcimg=11021, imageId = 1025,headID=1025, x = 65 , y = 79 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '在地愿为连理枝!', },
	},
	[312] = {
	NpcCreate = { regionId = 10 , name = "小红妹" ,title = '小红妹' , npcimg=11021, imageId = 1021,headID=1021, x = 68 , y = 75 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '为什么勇哥还没来，是不是路上出事了？', },
	},
	[313] = {
	NpcCreate = { regionId = 10 , name = "受伤的士兵" , title = '受伤的士兵' ,npcimg=11209,  imageId = 1209,headID=1024, x = 54 , y = 38 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '.......', },
	},
	[314] = {
	NpcCreate = { regionId = 10 , name = "随军医师" ,  npcimg=11014, imageId = 1014,headID=1014,x = 52 , y = 38 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '别乱动，你这一身伤可不轻啊!', },
	},
	[315] = {
	NpcCreate = { regionId = 10 , name = "农夫" , title = '农夫' , imageId = 1201,headID=1024, x = 119 , y = 15 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '本来是农夫，山泉，有点田，现在全被妖物给毁了，唉！', },
	},
	[316] = {
	NpcCreate = { regionId = 10 , name = "乞丐" , title = '乞丐' ,  npcimg=11026, imageId = 1026,headID=1026, x = 118 , y = 66 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '战争什么时候才能结束啊！', },
	},
	[317] = {
	NpcCreate = { regionId = 10 , name = "黄飞虎" ,title = '黄飞虎' ,  npcimg=12056, imageId = 2056,headID=2056, x = 73 , y = 110 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '诸位请打起精神，不可让商军靠近城镇！', },
	},
	[318] = {
	NpcCreate = { regionId = 10 , name = "副将" ,title = '副将' ,  npcimg=11012, imageId = 1012,headID=1012, x = 73 , y = 105 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '有我无敌！', },
	},
	[319] = {
	NpcCreate = { regionId = 10 , name = "哪吒" ,title = '哪吒' , npcimg=12052, imageId = 2052,headID=2052, x = 106 , y = 82 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '十绝阵非同小可，果真不简单!', },
	},
	[320] = {
	NpcCreate = { regionId = 10 , name = "周军士兵" ,   npcimg=11011, imageId = 1011,headID=1011, x = 83 , y = 112 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '喝，奋勇杀敌！', },
	},
	[321] = {
	NpcCreate = { regionId = 10 , name = "周军士兵" ,   npcimg=11011, imageId = 1011,headID=1011, x = 86 , y = 110 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '喝，奋勇杀敌！', },
	},
	[322] = {
	NpcCreate = { regionId = 10 , name = "周军士兵" ,   npcimg=11011, imageId = 1011,headID=1011, x = 73 , y = 121 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '喝，奋勇杀敌！', },
	},
	[323] = {
	NpcCreate = { regionId = 10 , name = "周军士兵" ,   npcimg=11011, imageId = 1011,headID=1011, x = 70 , y = 124 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '喝，奋勇杀敌！', },
	},
	[324] = {
	NpcCreate = { regionId = 10 , name = "周军士兵" ,   npcimg=11011, imageId = 1011,headID=1011, x = 65 , y = 121 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '喝，奋勇杀敌！', },
	},
	[325] = {
	NpcCreate = { regionId = 10 , name = "周军士兵" ,   npcimg=11011, imageId = 1011,headID=1011, x = 61 , y = 117 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '喝，奋勇杀敌！', },
	},
	[326] = {
	NpcCreate = { regionId = 10 , name = "周军士兵" ,   npcimg=11011, imageId = 1011,headID=1011, x = 57 , y = 113 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '喝，奋勇杀敌！', },
	},
	[327] = {
	NpcCreate = { regionId = 10 , name = "周军士兵" ,   npcimg=11011, imageId = 1011,headID=1011, x = 54 , y = 110 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '喝，奋勇杀敌！', },
	},
	
	--牧野NPC
	
	[350] = {
	NpcCreate = { regionId = 12 , name = "黄飞虎" ,title = '黄飞虎' ,  npcimg=12056, imageId = 2056,headID=2056, x = 4 , y = 212 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '诸位请奋力拼杀，胜利就在眼前！', },
	},
	[351] = {
	NpcCreate = { regionId = 12 , name = "奴隶头领" ,title = '奴隶头领' ,  npcimg=12131, imageId = 2131,headID=2131, x = 7 , y = 190 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '什么时候，我才能摆脱这悲惨的命运！', },
	},
	[352] = {
	NpcCreate = { regionId = 12 , name = "随军医师" ,title = '随军医师' ,  npcimg=11014, imageId = 1014,headID=1014, x = 4 , y = 198 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '人命在战争中真不值钱，能救一个是一个吧！', },
	},
	[353] = {
	NpcCreate = { regionId = 12 , name = "前锋官" ,title = '前锋官' ,  npcimg=11012, imageId = 1012,headID=1012, x = 79 , y = 212 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '无论前方是什么险阻，都无法阻挡我军前进的步伐！', },
	},
	[354] = {
	NpcCreate = { regionId = 12 , name = "金吒" ,title = '金吒' ,  npcimg=12059, imageId = 2059,headID=2059, x = 34 , y = 117 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '我一定要救活姜师叔！', },
	},
	[355] = {
	NpcCreate = { regionId = 12 , name = "密探" ,title = '密探' ,  npcimg=12137, imageId = 2137,headID=2137, x = 6 , y = 146 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '你看不见我，你看不见我！', },
	},
	[356] = {
	NpcCreate = { regionId = 12 , name = "申公豹" ,title = '申公豹' ,  npcimg=12233, imageId = 2233,headID=2233, x = 110 , y = 25 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '我将用我的方法成就无上大道！', },
	},
	[357] = {
	NpcCreate = { regionId = 12 , name = "投降的鱼妖" ,title = '投降的鱼妖' ,  npcimg=12229, imageId = 2229,headID=2229, x = 76, y = 108 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '饶了我这条死鱼吧！', },
	},
	
	--朝歌NPC
	[370] = {
	NpcCreate = { regionId = 13 , name = "黄飞虎" ,title = '黄飞虎' ,  npcimg=12056, imageId = 2056,headID=2056, x = 41 , y = 153 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '诸位请奋力拼杀，胜利就在眼前！', },
	},
	[371] = {
	NpcCreate = { regionId = 13 , name = "斥候伤员" ,title = '斥候伤员' ,  npcimg=11209, imageId = 1209,headID=1209, x = 11 , y = 137 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '请一定要救出队长。', },
	},
	[372] = {
	NpcCreate = { regionId = 13 , name = "斥候队长" ,title = '斥候队长' ,  npcimg=11012, imageId = 1012,headID=1012, x = 53 , y = 129 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '我一定要将兄弟们救出去！', },
	},
	[373] = {
	NpcCreate = { regionId = 13 , name = "杨戬" ,title = '杨戬' ,  npcimg=12058, imageId = 2058,headID=2058, x = 37 , y = 157 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '今日一定要诛灭那暴君与妖后！', },
	},
	[374] = {
	NpcCreate = { regionId = 13 , name = "斥候头领" ,title = '斥候头领' ,  npcimg=11012, imageId = 1012,headID=1012, x = 82 , y = 129 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '朝歌城内到处都是妖魔，形势非常危急！', },
	},
	[375] = {
	NpcCreate = { regionId = 13 , name = '姜后冤魂', title = "姜后冤魂" , imageId = 2244,headID=2244, x = 57 , y = 41 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '一块破旧的墓碑', },
	},
	[376] = {
	NpcCreate = { regionId = 13 , name = '西宫侍女', title = "西宫侍女" , npcimg=11021, imageId = 1021,headID=1021, x = 64 , y = 19 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '可怜姜后如此贤德，却被妖妃所害。', },
	},
	[377] = {
	NpcCreate = { regionId = 13 , name = '破旧的墓碑', title = "破旧的墓碑" , imageId = 1029,headID=1029, x = 43 , y = 8 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '一块破旧的墓碑', },
	},
	[378] = {
	NpcCreate = { regionId = 32 , name = '人鱼族使者', title = "人鱼族使者" , npcimg=12061,imageId = 1221,headID=1021, x = 5 , y = 17 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '希望族人都能平安。', },
	},
	
	
	
	
	
	
	--装饰性NPC
	[1000] = {
	NpcCreate = { regionId = 1 , name = "卫兵" ,  npcimg=11011, imageId = 1011,headID=1011, x = 51 , y = 25 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '西岐的安全，由我们来守护！', },
	},
	[1001] = {
	NpcCreate = { regionId = 1 , name = "卫兵" ,  npcimg=11011, imageId = 1011,headID=1011, x = 58 , y = 32 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '西岐的安全，由我们来守护！', },
	},
	[1002] = {
	NpcCreate = { regionId = 1 , name = "卫兵" ,  npcimg=11011, imageId = 1011,headID=1011, x = 18 , y = 31 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '西岐的安全，由我们来守护！', },
	},
	[1003] = {
	NpcCreate = { regionId = 1 , name = "卫兵" ,  npcimg=11011, imageId = 1011,headID=1011, x = 76 , y = 57 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '西岐的安全，由我们来守护！', },
	},
	[1004] = {
	NpcCreate = { regionId = 1 , name = "卫兵" ,  npcimg=11011, imageId = 1011,headID=1011, x = 85 , y = 64 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '西岐的安全，由我们来守护！', },
	},
	[1005] = {
	NpcCreate = { regionId = 1 , name = "卫兵" ,  npcimg=11011, imageId = 1011,headID=1011, x = 94 , y = 52 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '西岐的安全，由我们来守护！', },
	},
	[1006] = {
	NpcCreate = { regionId = 1 , name = "卫兵" , npcimg=11011, imageId = 1011,headID=1011, x = 86 , y = 44 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '西岐的安全，由我们来守护！', },
	},
	[1007] = {
	NpcCreate = { regionId = 1 , name = "侍卫官" ,  npcimg=11012, imageId = 1012,headID=1012, x = 92 , y = 36 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '西岐的安全，由我们来守护！', },
	},
	[1008] = {
	NpcCreate = { regionId = 1 , name = "侍卫官" ,  npcimg=11012, imageId = 1012,headID=1012, x = 101 , y = 45 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '西岐的安全，由我们来守护！', },
	},
	[1009] = {
	NpcCreate = { regionId = 1 , name = "卫兵" ,  npcimg=11011, imageId = 1011,headID=1011, x = 76 , y = 26 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '西岐的安全，由我们来守护！', },
	},
	[1010] = {
	NpcCreate = { regionId = 1 , name = "卫兵" ,  npcimg=11011, imageId = 1011,headID=1011, x = 71 , y = 31 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '西岐的安全，由我们来守护！', },
	},
	[1011] = {
	NpcCreate = { regionId = 1 , name = "卫兵" ,  npcimg=11011, imageId = 1011,headID=1011, x = 66 , y = 39 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '西岐的安全，由我们来守护！', },
	},
	[1012] = {
	NpcCreate = { regionId = 1 , name = "卫兵" ,  npcimg=11011, imageId = 1011,headID=1011, x = 106 , y = 59 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '西岐的安全，由我们来守护！', },
	},
	[1013] = {
	NpcCreate = { regionId = 1 , name = "卫兵" ,  npcimg=11011, imageId = 1011,headID=1011, x = 100 , y = 75 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '西岐的安全，由我们来守护！', },
	},
	[1014] = {
	NpcCreate = { regionId = 1 , name = "卫兵" ,  npcimg=11011, imageId = 1011,headID=1011, x = 111 , y = 123 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = 'MerryChristmas！', },
	},
	
	--对话打怪型NPC
	
	[1020] = {
	NpcCreate = { regionId = 22 , name = "在逃的通缉犯" , imageId = 2030,headID=2030, x = 11 , y = 82 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '你是来抓我的吗？嘿嘿！', },
	},
	[1021] = {
	NpcCreate = { regionId = 31 , name = "在逃的通缉犯" , imageId = 2066,headID=2017, x = 7 , y = 6 , dir = 3, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '你是来抓我的吗？嘿嘿！', },
	},
	[1022] = {
	NpcCreate = { regionId = 10 , name = "在逃的通缉犯" , imageId = 2136,headID=2136, x = 111 , y = 10 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '你是来抓我的吗？嘿嘿！', },
	},
	[1023] = {
	NpcCreate = { regionId = 7 , name = "在逃的通缉犯" , imageId = 2133,headID=2133, x = 47 , y = 113 , dir = 5, objectType = 1 , mType = 0,},
	NpcInfo = { talk = '你是来抓我的吗？嘿嘿！', },
	},
	
	
	----采集类NPC
	[100001] = {
			NpcCreate = {  regionId = 3, name = '蕴灵草', title = "" , imageId = 1027,headID=1027,  x = 58, y = 155, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10001,1,1}}},
			action = { 995, 4},
			PreTaskID={1004,1508,1590},
			NoDel=1,
			ProgressTips=1,
		},
	[100002] = {
			NpcCreate = {  regionId = 3, name = '蕴灵草', title = "" , imageId = 1027,headID=1027,  x = 56, y = 154, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10001,1,1}}},
			action = { 995, 4},
			PreTaskID={1004,1508,1590},
			NoDel=1,
			ProgressTips=1,
		},
	[100003] = {
			NpcCreate = {  regionId = 3, name = '蕴灵草', title = "" , imageId = 1027,headID=1027,  x = 56, y = 161, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10001,1,1}}},
			action = { 995, 4},
			PreTaskID={1261,1508,1590},
			NoDel=1,
			ProgressTips=1,
		},
	[100004] = {
			NpcCreate = {  regionId = 3, name = '蕴灵草', title = "" , imageId = 1027,headID=1027,  x = 58, y = 161, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10001,1,1}}},
			action = { 995, 4},
			PreTaskID=1261,
			NoDel=1,
			ProgressTips=1,
		},
	----采集类NPC
	[100005] = {
			NpcCreate = {  regionId = 1, name = '晒干的药材', title = "" , imageId = 1028,headID=1028,  x = 70, y = 154, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10002,1,1}}},
			action = { 995, 4},
			PreTaskID={1063,1625},
			NoDel=1,
			ProgressTips=1,
		},	
	[100006] = {
			NpcCreate = {  regionId = 1, name = '晒干的药材', title = "" , imageId = 1028,headID=1028,  x = 68, y = 151, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10002,1,1}}},
			action = { 995, 4},
			PreTaskID={1063,1625},
			NoDel=1,
			ProgressTips=1,
		},		
	[100007] = {
			NpcCreate = {  regionId = 1, name = '晒干的药材', title = "" , imageId = 1028,headID=1028,  x = 68, y = 156, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10002,1,1}}},
			action = { 995, 4},
			PreTaskID={1063,1625},
			NoDel=1,
			ProgressTips=1,
		},	
	[100008] = {
			NpcCreate = {  regionId = 1, name = '晒干的药材', title = "" , imageId = 1028,headID=1028,  x = 73, y = 157, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10002,1,1}}},
			action = { 995, 4},
			PreTaskID={1063,1625},
			NoDel=1,
			ProgressTips=1,
		},	
	----采集类NPC
	[100010] = {
			NpcCreate = {  regionId = 6, name = '残破古碑', title = "" , imageId = 1029,headID=1029,  x = 30, y = 61, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10003,1,1}}},
			action = { 995, 4},
			PreTaskID=1103,
			NoDel=1,
			ProgressTips=1,
		},	
	[100011] = {
			NpcCreate = {  regionId = 6, name = '接骨草', title = "" , imageId = 1027,headID=1027,  x = 64, y = 107, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10007,1,1}}},
			action = { 995, 4},
			PreTaskID=1099,
			NoDel=1,
			ProgressTips=1,
		},
	[100012] = {
			NpcCreate = {  regionId = 10, name = '接骨草', title = "" , imageId = 1027,headID=1027,  x = 75, y = 63, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10007,1,1}}},
			action = { 995, 4},
			PreTaskID=1371,
			NoDel=1,
			ProgressTips=1,
		},
	[100013] = {
			NpcCreate = {  regionId = 10, name = '奇怪的墓碑', title = "" , imageId = 1029,headID=1029,  x = 101, y = 7, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10003,1,1}}},
			action = { 995, 4},
			PreTaskID=1424,
			NoDel=1,
			ProgressTips=1,
		},		
	[100014] = {
			NpcCreate = {  regionId = 10, name = '魔化珍珠', title = "" , imageId = 1150,headID=1150,  x = 52, y = 150, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10006,1,1}}},
			action = { 995, 4},
			PreTaskID={1360,1509,1592,1626},
			NoDel=1,
			ProgressTips=1,
		},	
	[100015] = {
			NpcCreate = {  regionId = 10, name = '魔化珍珠', title = "" , imageId = 1150,headID=1150,  x = 55, y = 153, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10006,1,1}}},
			action = { 995, 4},
			PreTaskID={1360,1509,1592,1626},
			NoDel=1,
			ProgressTips=1,
		},	
	[100016] = {
			NpcCreate = {  regionId = 10, name = '魔化珍珠', title = "" , imageId = 1150,headID=1150,  x = 58, y = 156, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10006,1,1}}},
			action = { 995, 4},
			PreTaskID={1360,1509,1592,1626},
			NoDel=1,
			ProgressTips=1,
		},	
----采集类NPC
	[100020] = {
			NpcCreate = {  regionId = 8, name = '木材', title = "" , imageId = 1030,headID=1030,  x = 41, y = 83, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10004,1,1}}},
			action = { 995, 4},
			PreTaskID=1164,
			NoDel=1,
			ProgressTips=1,
		},	
	[100021] = {
			NpcCreate = {  regionId = 8, name = '木材', title = "" , imageId = 1030,headID=1030,  x = 44, y = 79, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10004,1,1}}},
			action = { 995, 4},
			PreTaskID=1164,
			NoDel=1,
			ProgressTips=1,
		},	
	[100022] = {
			NpcCreate = {  regionId = 8, name = '木材', title = "" , imageId = 1030,headID=1030,  x = 41, y = 88, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10004,1,1}}},
			action = { 995, 4},
			PreTaskID=1164,
			NoDel=1,
			ProgressTips=1,
		},	
	[100023] = {
			NpcCreate = {  regionId = 8, name = '木材', title = "" , imageId = 1030,headID=1030,  x = 47, y = 81, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10004,1,1}}},
			action = { 995, 4},
			PreTaskID=1164,
			NoDel=1,
			ProgressTips=1,
		},	
	[100024] = {
			NpcCreate = {  regionId = 8, name = '木材', title = "" , imageId = 1030,headID=1030,  x = 52, y = 89, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10004,1,1}}},
			action = { 995, 4},
			PreTaskID=1164,
			NoDel=1,
			ProgressTips=1,
		},	
		----采集类NPC
	[100025] = {
			NpcCreate = {  regionId = 34, name = '镇魂冰莲', title = "" , imageId = 1143,headID=1143,  x = 31, y = 72, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10005,1,1}}},
			action = { 995, 4},
			PreTaskID={1317},
			NoDel=1,
			ProgressTips=1,
		},		
	[100026] = {
			NpcCreate = {  regionId = 7, name = '镇魂冰莲', title = "" , imageId = 1143,headID=1143,  x = 43, y = 95, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10005,1,1}}},
			action = { 995, 4},
			PreTaskID={1263,2032},
			NoDel=1,
			ProgressTips=1,
		},	
	[100027] = {
			NpcCreate = {  regionId = 8, name = '珍珠果', title = "" , imageId = 1150,headID=1150,  x = 74, y = 127, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10006,1,1}}},
			action = { 995, 4},
			PreTaskID={1262,1623},
			NoDel=1,
			ProgressTips=1,
		},	
	[100028] = {
			NpcCreate = {  regionId = 8, name = '珍珠果', title = "" , imageId = 1150,headID=1150,  x = 72, y = 128, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10006,1,1}}},
			action = { 995, 4},
			PreTaskID={1262,1623},
			NoDel=1,
			ProgressTips=1,
		},
	[100029] = {
			NpcCreate = {  regionId = 8, name = '珍珠果', title = "" , imageId = 1150,headID=1150,  x = 76, y = 125, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10006,1,1}}},
			action = { 995, 4},
			PreTaskID={1262,1623},
			NoDel=1,
			ProgressTips=1,
		},	
	[100030] = {
			NpcCreate = {  regionId = 8, name = '珍珠果', title = "" , imageId = 1150,headID=1150,  x = 70, y = 130, dir = 0, objectType = 1,dir = 0 , mType = 10},
			NpcType = 2,
			product={ [3] = {{10006,1,1}}},
			action = { 995, 4},
			PreTaskID={1262,1623},
			NoDel=1,
			ProgressTips=1,
		},	
	[100031] = {
			NpcCreate = {  regionId = 0, name = '千年灵芝',imageId = 1240,headID=1240,  x = 12, y = 17, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=3,	
			NpcType = 2,
			product={ [3] = {{10008,1,1}}},
			action = { 995, 4},	
			PreTaskID={6003,6008,6013,6018,6023,6028,6033,6038,6043,6048,6053,6058},
			ProgressTips=1,
		},	
	[100032] = {
			NpcCreate = {  regionId = 0, name = '千年灵芝',imageId = 1240,headID=1240,  x = 8, y = 19, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=3,	
			NpcType = 2,
			product={ [3] = {{10008,1,1}}},
			action = { 995, 4},	
			PreTaskID={6003,6008,6013,6018,6023,6028,6033,6038,6043,6048,6053,6058},
			ProgressTips=1,
		},	
	[100033] = {
			NpcCreate = {  regionId = 0, name = '千年灵芝',imageId = 1240,headID=1240,  x = 5, y = 24, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=3,	
			NpcType = 2,
			product={ [3] = {{10008,1,1}}},
			action = { 995, 4},	
			PreTaskID={6003,6008,6013,6018,6023,6028,6033,6038,6043,6048,6053,6058},
			ProgressTips=1,
		},	
	[100034] = {
			NpcCreate = {  regionId = 0, name = '千年灵芝',imageId = 1240,headID=1240,  x = 8, y = 29, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=3,	
			NpcType = 2,
			product={ [3] = {{10008,1,1}}},
			action = { 995, 4},	
			PreTaskID={6003,6008,6013,6018,6023,6028,6033,6038,6043,6048,6053,6058},
			ProgressTips=1,
		},	
	[100035] = {
			NpcCreate = {  regionId = 0, name = '千年灵芝',imageId = 1240,headID=1240,  x = 12, y = 32, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=3,	
			NpcType = 2,
			product={ [3] = {{10008,1,1}}},
			action = { 995, 4},	
			PreTaskID={6003,6008,6013,6018,6023,6028,6033,6038,6043,6048,6053,6058},
			ProgressTips=1,
		},		
	[100036] = {
			NpcCreate = {  regionId = 0, name = '千年灵芝',imageId = 1240,headID=1240,  x = 16, y = 29, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=3,	
			NpcType = 2,
			product={ [3] = {{10008,1,1}}},
			action = { 995, 4},	
			PreTaskID={6003,6008,6013,6018,6023,6028,6033,6038,6043,6048,6053,6058},
			ProgressTips=1,
		},	
	[100037] = {
			NpcCreate = {  regionId = 0, name = '千年灵芝',imageId = 1240,headID=1240,  x = 18, y = 24, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=3,	
			NpcType = 2,
			product={ [3] = {{10008,1,1}}},
			action = { 995, 4},	
			PreTaskID={6003,6008,6013,6018,6023,6028,6033,6038,6043,6048,6053,6058},
			ProgressTips=1,
		},	
	[100038] = {
			NpcCreate = {  regionId = 0, name = '千年灵芝',imageId = 1240,headID=1240,  x = 16, y = 19, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=3,	
			NpcType = 2,
			product={ [3] = {{10008,1,1}}},
			action = { 995, 4},	
			PreTaskID={6003,6008,6013,6018,6023,6028,6033,6038,6043,6048,6053,6058},
			ProgressTips=1,
		},	
    [100039] = {
			NpcCreate = {  regionId = 0, name = '远古炼丹炉',imageId = 1241,headID=1241,  x = 54, y = 53, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=12,	
			NpcType = 2,
			product={ [3] = {{10009,1,1}}},
			action = { 995, 4},	
			PreTaskID={6004,6009,6014,6019,6024,6029,6034,6039,6044,6049,6054,6059},
			ProgressTips=1,
		},	
    [100040] = {
			NpcCreate = {  regionId = 0, name = '远古炼丹炉',imageId = 1241,headID=1241,  x = 54, y = 63, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=15,	
			NpcType = 2,
			product={ [3] = {{10009,1,1}}},
			action = { 995, 4},	
			PreTaskID={6004,6009,6014,6019,6024,6029,6034,6039,6044,6049,6054,6059},
			ProgressTips=1,
		},	
    [100041] = {
			NpcCreate = {  regionId = 0, name = '远古炼丹炉',imageId = 1241,headID=1241,  x = 58, y = 58, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=18,	
			NpcType = 2,
			product={ [3] = {{10009,1,1}}},
			action = { 995, 4},	
			PreTaskID={6004,6009,6014,6019,6024,6029,6034,6039,6044,6049,6054,6059},
			ProgressTips=1,
		},	
    [100042] = {
			NpcCreate = {  regionId = 0, name = '远古炼丹炉',imageId = 1241,headID=1241,  x = 62, y = 53, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=20,	
			NpcType = 2,
			product={ [3] = {{10009,1,1}}},
			action = { 995, 4},	
			PreTaskID={6004,6009,6014,6019,6024,6029,6034,6039,6044,6049,6054,6059},
			ProgressTips=1,
		},		
    [100043] = {
			NpcCreate = {  regionId = 0, name = '远古炼丹炉',imageId = 1241,headID=1241,  x = 62, y = 63, dir = 0, objectType = 1,dir = 0 , mType = 10},
			Refresh=15,	
			NpcType = 2,
			product={ [3] = {{10009,1,1}}},
			action = { 995, 4},	
			PreTaskID={6004,6009,6014,6019,6024,6029,6034,6039,6044,6049,6054,6059},
			ProgressTips=1,
		},		

	[400001] = {
		NpcCreate = { regionId = 0 , name = "摇钱树" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400002] = {
		NpcCreate = { regionId = 0 , name = "摇钱树" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400003] = {
		NpcCreate = { regionId = 0 , name = "摇钱树" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400004] = {
		NpcCreate = { regionId = 0 , name = "摇钱树" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400005] = {
		NpcCreate = { regionId = 0 , name = "摇钱树" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400006] = {
		NpcCreate = { regionId = 0 , name = "摇钱树" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400007] = {
		NpcCreate = { regionId = 0 , name = "摇钱树" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400008] = {
		NpcCreate = { regionId = 0 , name = "摇钱树" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400009] = {
		NpcCreate = { regionId = 0 , name = "摇钱树" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400010] = {
		NpcCreate = { regionId = 0 , name = "摇钱树" , title = '' ,npcimg=11052, imageId = 2004,headID=2004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400100] = {--默认摇钱树
		NpcCreate = { regionId = 0 , name = "摇钱树" , title = '' , imageId = 1120,headID=1120, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '', },
		NpcType = 1,
		NpcFunction = {
				panel = 1,
			},
		},
	[400101] = {--妲己
		NpcCreate = { regionId = 0 , name = "妲己(女仆)" , title = '女仆' ,npcimg=11004, imageId = 1033,headID=1004, x = 17 , y = 46 , dir = 5 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '欢迎主人回家！', },
		NpcType = 1,
		NpcFunction = {
				panel = 4,
			},
		},
	[400201] = {
		NpcCreate = { regionId = 0 , name = "瑶池美女" , imageId = 1172,headID=1172, x = 8 , y = 9 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[400202] = {
		NpcCreate = { regionId = 0 , name = "瑶池美女" , imageId = 1171,headID=1171, x = 11 , y = 7 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[400203] = {
		NpcCreate = { regionId = 0 , name = "瑶池美女"  ,imageId = 1168,headID=1168, x = 11 , y = 12 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[400204] = {
		NpcCreate = { regionId = 0 , name = "瑶池美女" , imageId = 1170,headID=1170, x = 22 , y = 15 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[400205] = {
		NpcCreate = { regionId = 0 , name = "瑶池美女"  ,imageId = 1162,headID=1162, x = 26 , y = 16 , dir = 5 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[400206] = {
		NpcCreate = { regionId = 0 , name = "瑶池美女" , imageId = 1157,headID=1157, x = 29 , y = 17 , dir = 5 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[400207] = {
		NpcCreate = { regionId = 0 , name = "瑶池美女" , imageId = 1156,headID=1156, x = 30 , y = 22 , dir = 5 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[400208] = {
		NpcCreate = { regionId = 0 , name = "瑶池美女" , imageId = 1160,headID=1160, x = 34 , y = 25 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},
	[400209] = {
		NpcCreate = { regionId = 0 , name = "瑶池美女" , imageId = 1161,headID=1161, x = 39 , y = 36 , dir = 6 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},
	[400210] = {
		NpcCreate = { regionId = 0 , name = "瑶池美女" , imageId = 1163,headID=1163, x = 25 , y = 48 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},		
	[400211] = {
		NpcCreate = { regionId = 0 , name = "瑶池美女" , imageId = 1169,headID=1169, x = 20 , y = 37 , dir = 5 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	[400212] = {
		NpcCreate = { regionId = 0 , name = "瑶池美女" , imageId = 1164,headID=1164, x = 13 , y = 33 , dir = 0 , objectType = 1 , mType = 10},		
		NpcType = 3,
		},	
	
	[400301] = {
		NpcCreate = { regionId = 0 , name = "天界先锋官" , title = '天界先锋官' , npcimg=12052, imageId = 1165,headID=2052, x = 85 , y = 15 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '如果你提交水晶矿，可以在我这里兑换成战场积分！', },
			NpcFunction = {
						{"call", "提交矿石",func = "GI_sjzc_submit_res"},
					},
			},
	[400302] = {
		NpcCreate = { regionId = 0 , name = "人界先锋官" , title = '人界先锋官' , npcimg=12056, imageId = 1166,headID=2056, x = 6 , y = 81 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '如果你提交水晶矿，可以在我这里兑换成战场积分！', },
			NpcFunction = {
						{"call", "提交矿石",func = "GI_sjzc_submit_res"},
					},
			},	
	[400303] = {
		NpcCreate = { regionId = 0 , name = "魔界先锋官" , title = '魔界先锋官' , npcimg=11010, imageId = 1167,headID=1010, x = 90 , y = 148 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '如果你提交水晶矿，可以在我这里兑换成战场积分！', },
			NpcFunction = {
						{"call", "提交矿石",func = "GI_sjzc_submit_res"},
					},
			},
	[400304] = {
		NpcCreate = { regionId = 0 , name = "铜宝箱" , title = '铜宝箱' , imageId = 2119,headID=1144, x = 56 , y = 73 , dir = 5, objectType = 1 , mType = 0,clickScript = 50002,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 2,
		ProgressTips = 1,	
	},		
	[400305] = {
		NpcCreate = { regionId = 0 , name = "银宝箱" , title = '银宝箱' , imageId = 2118,headID=1144, x = 56 , y = 73 , dir = 5, objectType = 1 , mType = 0,clickScript = 50002,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 2,
		ProgressTips = 1,	
	},
	[400306] = {
		NpcCreate = { regionId = 0 , name = "金宝箱" , title = '金宝箱' , imageId = 2117,headID=1144, x = 56 , y = 73 , dir = 5, objectType = 1 , mType = 0,clickScript = 50002,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 2,
		ProgressTips = 1,	
	},
	
	[400401] = {
		NpcCreate = { regionId = 0 , name = "帮会总管" , title = '帮会总管' , npcimg=11032, imageId = 1032,headID=1032,x = 19 , y = 14 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '战火无情，如果遇到落难的百姓，请施以援手，自有回报！', },
			NpcFunction = {
						{"call", "完成护送",func = "GI_ff_submit_res"},
					},
		},
	[400402] = {
		NpcCreate = { regionId = 0 , name = "帮会总管" , title = '帮会总管' , npcimg=11032, imageId = 1032,headID=1032,x = 3 , y = 168 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '战火无情，如果遇到落难的百姓，请施以援手，自有回报！', },
			NpcFunction = {
						{"call", "完成护送",func = "GI_ff_submit_res"},
					},
		},
	[400403] = {
		NpcCreate = { regionId = 0 , name = "帮会总管" , title = '帮会总管' , npcimg=11032, imageId = 1032,headID=1032,x = 88 , y = 159 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '战火无情，如果遇到落难的百姓，请施以援手，自有回报！', },
			NpcFunction = {
						{"call", "完成护送",func = "GI_ff_submit_res"},
					},
		},	
		
	
	[400410] = {
		NpcCreate = { regionId = 0 , name = "被困的美女" , title = '被困的美女' , imageId = 1137,headID=1137, x = 49 , y = 82 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		PBType=3,	
		NpcType = 2,
		ProgressTips = 1,	
	},
	[400411] = {
		NpcCreate = { regionId = 0 , name = "被困的美女" , title = '被困的美女' , imageId = 1137,headID=1137, x = 65 , y = 99 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		PBType=3,	
		NpcType = 2,
		ProgressTips = 1,	
	},
	[400412] = {
		NpcCreate = { regionId = 0 , name = "被困的美女" , title = '被困的美女' , imageId = 1137,headID=1137, x = 49 , y = 116 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		PBType=3,
		NpcType = 2,
		ProgressTips = 1,	
	},
	[400413] = {
		NpcCreate = { regionId = 0 , name = "被困的美女" , title = '被困的美女' , imageId = 1137,headID=1137, x = 34 , y = 98 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		PBType=3,
		NpcType = 2,
		ProgressTips = 1,	
	},
	[400430] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 7 , y = 156 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400431] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 8 , y = 157 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400432] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 9 , y = 158 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400433] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 10 , y = 159 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400434] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 23 , y = 49 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400435] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 24 , y = 48 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400436] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 25 , y = 47 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400437] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 26 , y = 46 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400438] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 78 , y = 154 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400439] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 79 , y = 153 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400440] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 80 , y = 152 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400441] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 81 , y = 151 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400442] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 82 , y = 150 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400443] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 83 , y = 149 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400444] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 11 , y = 160 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400445] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 12 , y = 161 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400446] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 13 , y = 162 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},
	[400447] = {
		NpcCreate = { regionId = 0 , name = "栅栏" ,imageId = 1239,headID=1137, x = 14 , y = 163 , dir = 0, objectType = 1 , mType = 0,clickScript = 50011,},
		NpcType = 3,
	},	
	----玉玺
	[400500] = {
		NpcCreate = {  regionId = 0, name = '玉玺', title = "玉玺" ,iconID=18, imageId = 1181,headID=1181,  x = 56, y = 69, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50020},
		NpcType = 2,
		ProgressTips = 1,	
		PBType=5,		
	},
	----军械总管
	[400501] = {
		NpcCreate = { regionId = 0 , name = "军械总管" ,iconID=17, title = '军械总管' , npcimg=11013, imageId = 1013,headID=1013, x = 12 , y = 112 , dir = 3 , objectType = 1 , mType = 0,},
		NpcInfo = { talk = '在我这里可以购买攻城锤车，破坏雕像的速度会加快很多！', },
		NpcFunction = {
				{"clientFunc", "购买攻城锤车",type=12},
			},	
	},
	[400502] = {
		NpcCreate = { regionId = 0 , name = "传国玉玺" ,   imageId = 1013,headID=1013, x = 67 , y = 84 , dir = 0 , objectType = 1 , mType = 0,},
		NpcType = 1,
		NpcFunction = {
				panel = 19,
			},		
	},
	-----天降宝箱400510-400550
	[400510] = {
			NpcCreate = {  regionId = 0, name = '混沌至尊宝箱',imageId = 1244,headID=1244,  x = 37, y = 54, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=20,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400511] = {
			NpcCreate = {  regionId = 0, name = '青龙宝箱',imageId = 1245,headID=1245,  x = 15, y = 23, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400512] = {
			NpcCreate = {  regionId = 0, name = '白虎宝箱',imageId = 1246,headID=1246,  x = 65, y = 74, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400513] = {
			NpcCreate = {  regionId = 0, name = '朱雀宝箱',imageId = 1247,headID=1247,  x = 58, y = 27, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400514] = {
			NpcCreate = {  regionId = 0, name = '玄武宝箱',imageId = 1248,headID=1248,  x = 10, y = 74, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400515] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 13, y = 102, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400516] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 14 ,y = 80, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400517] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 5, y = 80, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400518] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 5, y = 70, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400519] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 12, y = 70, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400520] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 4, y = 47, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400521] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 8, y = 33, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400522] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 19, y = 33, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400523] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 20, y = 19, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400524] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 9, y = 22, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400525] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 38, y = 16, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400526] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 52, y = 23, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400527] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 64, y = 25, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400528] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 63, y = 33, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400529] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 53, y = 32, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400530] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 70, y = 51, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400531] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 69, y = 69, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400532] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 60, y = 70, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400533] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 62, y = 80, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400534] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 70, y = 79, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50021},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	--跨服寻宝 400550 - 400553
	
	[400550] = {
			NpcCreate = {  regionId = 0, name = '深蓝宝箱',imageId = 1245,headID=1245,  x = 72, y = 108, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50022},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400551] = {
			NpcCreate = {  regionId = 0, name = '白玉宝箱',imageId = 1246,headID=1246,  x = 68, y = 58, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50022},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400552] = {
			NpcCreate = {  regionId = 0, name = '赤红宝箱',imageId = 1247,headID=1247,  x = 98, y = 150, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50022},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400553] = {
			NpcCreate = {  regionId = 0, name = '翡翠宝箱',imageId = 1248,headID=1248,  x = 37, y = 137, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50022},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	
	--跨服 天降宝箱
	-----天降宝箱400510-400550
	[400560] = {
			NpcCreate = {  regionId = 0, name = '混沌至尊宝箱',imageId = 1244,headID=1244,  x = 37, y = 54, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=20,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400561] = {
			NpcCreate = {  regionId = 0, name = '青龙宝箱',imageId = 1245,headID=1245,  x = 15, y = 23, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400562] = {
			NpcCreate = {  regionId = 0, name = '白虎宝箱',imageId = 1246,headID=1246,  x = 65, y = 74, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400563] = {
			NpcCreate = {  regionId = 0, name = '朱雀宝箱',imageId = 1247,headID=1247,  x = 58, y = 27, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400564] = {
			NpcCreate = {  regionId = 0, name = '玄武宝箱',imageId = 1248,headID=1248,  x = 10, y = 74, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=10,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400565] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 13, y = 102, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400566] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 14 ,y = 80, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400567] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 5, y = 80, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400568] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 5, y = 70, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400569] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 12, y = 70, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400570] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 4, y = 47, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400571] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 8, y = 33, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400572] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 19, y = 33, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400573] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 20, y = 19, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400574] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 9, y = 22, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400575] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 38, y = 16, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400576] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 52, y = 23, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400577] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 64, y = 25, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400578] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 63, y = 33, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400579] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 53, y = 32, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400580] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 70, y = 51, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400581] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 69, y = 69, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400582] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 60, y = 70, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400583] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 62, y = 80, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	[400584] = {
			NpcCreate = {  regionId = 0, name = '宝箱',imageId = 1249,headID=1249,  x = 70, y = 79, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50023},
			Refresh=3,	
			NpcType = 2,
			action = { 995, 4},	
			ProgressTips=1,
	},
	
	--跨服 三界战场 400601 ~ 400603
	[400601] = {
		NpcCreate = { regionId = 0 , name = "天界先锋官" , title = '天界先锋官' , npcimg=12052, imageId = 1165,headID=2052, x = 85 , y = 15 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '如果你提交水晶矿，可以在我这里兑换成战场积分！', },
			NpcFunction = {
						{"call", "提交矿石",func = "GI_span_sjzc_submit_res"},
					},
			},
	[400602] = {
		NpcCreate = { regionId = 0 , name = "人界先锋官" , title = '人界先锋官' , npcimg=12056, imageId = 1166,headID=2056, x = 6 , y = 81 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '如果你提交水晶矿，可以在我这里兑换成战场积分！', },
			NpcFunction = {
						{"call", "提交矿石",func = "GI_span_sjzc_submit_res"},
					},
			},	
	[400603] = {
		NpcCreate = { regionId = 0 , name = "魔界先锋官" , title = '魔界先锋官' , npcimg=11010, imageId = 1167,headID=1010, x = 90 , y = 148 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '如果你提交水晶矿，可以在我这里兑换成战场积分！', },
			NpcFunction = {
						{"call", "提交矿石",func = "GI_span_sjzc_submit_res"},
					},
			},
	
	
	----单人副本NPC
	 ----金光洞二层   --Nodel=1 采集后不消失 ProBarType = 1收集 2传送 3解救 4机关开启 fight = 1 采集结束后自动挂机
	[500001] = {
		NpcCreate = { regionId = 0 , name = "被困女弟子" , title = '被困女弟子' , npcimg=11052, imageId = 1007,headID=1007, x = 40 , y = 38 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 2,
	},
	[500015] = {
		NpcCreate = { regionId = 0 , name = "香炉" , title = '香炉' , npcimg=11052, imageId = 1151,headID=1151, x = 24 , y = 61 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 2,
		ProgressTips = 1,	
		PBType=4,	 
  		fight = 1,
    },
	[500016] = {
		NpcCreate = { regionId = 0 , name = "香炉" , title = '香炉' , npcimg=11052, imageId = 1151,headID=1151, x = 24 , y = 61 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 2,
		ProgressTips = 1,	
		PBType=4,     
		fight = 1,
	
    },
   	
	 ----金光洞一层
	[500002] = {
		NpcCreate = { regionId = 0 , name = "女弟子" , title = '女弟子' , npcimg=11052, imageId = 1221,headID=1221, x = 11 , y = 26 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 2,
	},
	[500003] = {
		NpcCreate = { regionId = 0 , name = "宝箱" , title = '宝箱' , npcimg=11052, imageId = 1144,headID=1144, x = 43 , y = 15 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 1,
		NpcFunction = {
				panel = 17,
			},
	},
	[500004] = {
		NpcCreate = { regionId = 0 , name = "宝箱" , title = '宝箱' , npcimg=11052, imageId = 1144,headID=1144, x = 5 , y = 69 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 1,
		NpcFunction = {
				panel = 18,
			},
	},
	[500014] = {
		NpcCreate = { regionId = 0 , name = "香炉" , title = '香炉' , npcimg=11052, imageId = 1151,headID=1151, x = 24 , y = 61 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 2,
		ProgressTips = 1,	
		PBType=4,
		fight = 1,
		
    },
    ----东海一层
	
	[500012] = {
		NpcCreate = { regionId = 0 , name = "男童" , title = '男童' , npcimg=11052, imageId = 1147,headID=1147, x = 12 , y = 8 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 2,
		ProgressTips = 1,	
		PBType=3,	
		fight = 1,
	},
	 ----东海龙宫
	[500005] = {
		NpcCreate = { regionId = 0 , name = "宝箱" , title = '宝箱' , npcimg=11052, imageId = 1144,headID=1144, x = 43 , y = 15 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 2,
		ProgressTips = 1,
		NoDel=1,		
	},
	 ----定海神针1
	[500006] = {
		NpcCreate = { regionId = 0 , name = "宝箱" , title = '宝箱' , npcimg=11052, imageId = 1144,headID=1144, x = 2 , y = 36 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 2,
		ProgressTips = 1,
		NoDel=1,
	},
	 ----东海救人
	[500007] = {
		NpcCreate = { regionId = 0 , name = "宝箱" , title = '宝箱' , npcimg=11052, imageId = 1144,headID=1144, x = 12 , y = 8 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 2,
		ProgressTips = 1,
		NoDel=1,		
	},
	[500009] = {
		NpcCreate = { regionId = 0 , name = "男童" , title = '男童' , npcimg=11052, imageId = 1147,headID=1147, x = 12 , y = 8 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 2,
		ProgressTips = 1,	
		PBType=3,	
		fight = 1,	
	},
	[500010] = {
		NpcCreate = { regionId = 0 , name = "男童" , title = '男童' , npcimg=11052, imageId = 1147,headID=1147, x = 12 , y = 8 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 2,
		ProgressTips = 1,	
		PBType=3,
		fight = 1,
	},
	[500011] = {
		NpcCreate = { regionId = 0 , name = "女童" , title = '女童' , npcimg=11052, imageId = 1148,headID=1148, x = 12 , y = 8 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 2,
		ProgressTips = 1,	
		PBType=3,	
		fight = 1,
	},
	----哪吒复仇
	[500008] = {
		NpcCreate = { regionId = 0 , name = "宝箱" , title = '宝箱' , npcimg=11052, imageId = 1144,headID=1144, x = 12 , y = 8 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 2,
		ProgressTips = 1,
		NoDel=1,	
	},
	----拯救苏护
	[500013] = {
		NpcCreate = { regionId = 0 , name = "石碑" , title = '石碑' , npcimg=11052, imageId = 1029,headID=1029, x = 24 , y = 61 , dir = 5, objectType = 1 , mType = 0,clickScript = 40005,},
		NpcInfo = { talk = '祝你一路顺风！', },
		NpcType = 2,
		ProgressTips = 1,	
		PBType=4,
		fight = 1,
    },
		
	[701000] = {
		NpcCreate = { regionId = 0 , name = "宴席" , title = '来吃酒' ,npcimg=11052, imageId = 1130,headID=1130, x = 21 , y = 47 , dir = 0 , objectType = 1 , mType = 0},
		NpcInfo = { talk = '宴席信息', },	
		NpcType = 1,
		NpcFunction = {
			panel = 2,
		},
	},
	[702000] = {
		NpcCreate = { regionId = 0 , name = "豪华宴席" , title = '来吃酒' ,npcimg=11052, imageId = 1131,headID=1131, x = 21 , y = 47 , dir = 0 , objectType = 1 , mType = 0},
		NpcInfo = { talk = '宴席信息', },		
		NpcType = 1,
		NpcFunction = {
			panel = 2,
		},
	},
	[703000] = {
		NpcCreate = { regionId = 0 , name = "鸭子" , imageId = 1141,headID=1141, x = 21 , y = 47 , dir = 5 , objectType = 1 , mType = 0,clickScript = 60008,},
		NpcInfo = { talk = '宴席信息', },		
		NpcType = 2,
		ProgressTips = 1,
	},
	
	[704000] = {
		NpcCreate = {  regionId = 0, name = '水晶矿', title = "水晶矿" ,layered = true, imageId = 1180,headID=1180,  x = 85, y = 96, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50001},
		NpcType = 2,
		action = { 995, 4},
		ProgressTips=1,	
		
	},	
	[705000] = {
		NpcCreate = {  regionId = 0, name = '水晶矿', title = "水晶矿" ,layered = true, imageId = 1178,headID=1178,  x = 86, y = 103, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50001},
		NpcType = 2,
		action = { 995, 4},
		ProgressTips=1,
	},	
			
	[706000] = {
		NpcCreate = { regionId = 0 , name = "荷叶酒" , imageId = 1138,headID=1138, x = 21 , y = 47 , dir = 5 , objectType = 1 , mType = 0,clickScript = 60009,},
		NpcInfo = { talk = '宴席信息', },		
		NpcType = 1,
		ProgressTips = 1,
		NpcFunction = {
				panel = 12,
		},
	},
	[707000] = {
		NpcCreate = { regionId = 0 , name = "荷叶酒" , imageId = 1139,headID=1139, x = 21 , y = 47 , dir = 5 , objectType = 1 , mType = 0,clickScript = 60009,},
		NpcInfo = { talk = '宴席信息', },		
		NpcType = 1,
		ProgressTips = 1,
		NpcFunction = {
			panel = 12,
		},
	},
	[708000] = {
		NpcCreate = { regionId = 0 , name = "荷叶酒" , imageId = 1140,headID=1140, x = 21 , y = 47 , dir = 5 , objectType = 1 , mType = 0,clickScript = 60009,},
		NpcInfo = { talk = '宴席信息', },		
		NpcType = 1,
		ProgressTips = 1,
		NpcFunction = {
			panel = 12,
		},
	},
	[709000] = {
			NpcCreate = {  regionId = 0, name = '水晶矿', title = "水晶矿" , layered = true,imageId = 1178,headID=1178,  x = 86, y = 103, dir = 7, objectType = 1,dir = 0 , mType = 10,clickScript = 50001},
			NpcType = 2,
			action = { 995, 4},
			ProgressTips=1,
	},	
	[711000] = {
		NpcCreate = { regionId = 0 , name = "普通婚宴" , title = '来吃酒' ,npcimg=11052, imageId = 1130,headID=1130, x = 21 , y = 47 , dir = 0 , objectType = 1 , mType = 0,clickScript = 60040},
		NpcInfo = { talk = '宴席信息', },	
		NpcType = 2,		
	},
	[712000] = {
		NpcCreate = { regionId = 0 , name = "豪华婚宴" , title = '来吃酒' ,npcimg=11052, imageId = 1131,headID=1131, x = 21 , y = 47 , dir = 0 , objectType = 1 , mType = 0,clickScript = 60040},
		NpcInfo = { talk = '宴席信息', },		
		NpcType = 2,		
	},
	[713000] = {
		NpcCreate = {  regionId = 0, name = '水晶矿', title = "水晶矿" ,layered = true, imageId = 1180,headID=1180,  x = 85, y = 96, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50003},
		NpcType = 2,
		action = { 995, 4},
		ProgressTips=1,	
		
	},	
	[714000] = {
		NpcCreate = {  regionId = 0, name = '水晶矿', title = "水晶矿" ,layered = true, imageId = 1178,headID=1178,  x = 86, y = 103, dir = 0, objectType = 1,dir = 0 , mType = 10,clickScript = 50003},
		NpcType = 2,
		action = { 995, 4},
		ProgressTips=1,
	},	
	[715000] = {
			NpcCreate = {  regionId = 0, name = '水晶矿', title = "水晶矿" , layered = true,imageId = 1178,headID=1178,  x = 86, y = 103, dir = 7, objectType = 1,dir = 0 , mType = 10,clickScript = 50003},
			NpcType = 2,
			action = { 995, 4},
			ProgressTips=1,
	},
	-- --跨服竞技报名官
	-- [713000] = {
	-- NpcCreate = { regionId = 101 ,  name = "竞技报名官" ,iconID=9, imageId = 1012,headID=1012, x = 27 , y = 24 , dir = 5 , objectType = 1 , mType = 0,},
	-- NpcType = 1,
	-- NpcFunction = {
	-- 			panel = 25,
	-- 		},
	-- },
}	
