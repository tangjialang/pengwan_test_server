 --[[
file:Mounts_conf.lua
desc:坐骑通用配置方法
author:xiao.y
update:2013-7-1
refix:	done by xy
]]--
--[[坐骑幻化配置
  	CAT_MAX_HP	= 0,		// 血量上限 1
	CAT_MAX_MP,				// 职业攻击 2
	CAT_ATC,				// 攻击 3
	CAT_DEF,				// 防御 4
	CAT_HIT,				// 命中 5
	CAT_DUCK,				// 闪避 6
	CAT_CRIT,				// 暴击 7
	CAT_RESIST,				// 抵抗 8
	CAT_BLOCK,				// 格挡 9
	CAT_AB_ATC,				// 职业抗性1（火系抗性） 10
	CAT_AB_DEF,				// 职业抗性2（冰系抗性） 11
	CAT_CritDam,			// 职业抗性3（木系抗性）12
	CAT_MoveSpeed,			// 移动速度(预留) 13
	CAT_S_REDUCE,			// 抗性减免	      14
]]--

--------------------------------------------------------------------------
--include:

local Horse_Data = msgh_s2c_def[17][1]
local Horse_Att = msgh_s2c_def[17][5]
local Horse_Luck = msgh_s2c_def[17][6]
local GetPlayer = GetPlayer
local SendLuaMsg = SendLuaMsg
local CI_GetPlayerData = CI_GetPlayerData
local pairs = pairs
local CI_OperateMounts = CI_OperateMounts
local GetRidingMountId = GetRidingMountId
local math_floor = math.floor
local GetRWData = GetRWData
local PI_UpdateScriptAtt = PI_UpdateScriptAtt
local table_copy = table.copy
local CI_SetSkillLevel = CI_SetSkillLevel
local BroadcastRPC = BroadcastRPC
local look = look
local Horsebuchang = MailConfig.Horsebuchang
local IsPlayerOnline = IsPlayerOnline
--------------------------------------------------------------------------
-- data:
--[[  CAT_MAX_HP,	1	// 血量上限1
CAT_MAX_MP,	2	// 怒气上限(预留)
CAT_ATC,	3	// 攻击2
CAT_DEF,	4	// 防御3
CAT_HIT,	5	// 命中4
CAT_DUCK,	6	// 闪避5
CAT_CRIT,	7	// 暴击6
CAT_RESIST,	8	// 抵抗7
CAT_BLOCK,	9	// 格挡8]]--

MouseIsLuck = 1 --是否开放抽将，1 开放 0 关闭

MouseChgeConf = {
	speed = 60, --坐骑初始速度
	att = {10,nil,2,1.6,1.5,nil,nil,nil,nil}, --属性计算系数
	mxlv = 120, --最大进化等级
	good = {636,10}, --{进化所需道具,每个价值元宝数}
	good1 = 627, --100级后进化所需道具
	uplv = 100, --进入变态升级模式的等级要求
	[1] = { --普通(自动解锁)
		[1] = {level = 0,ico = 421,skill = 125,name = '银甲战骑',rid = 1,txt = '入门级坐骑，身披重甲的标准西周战骑。'}, --[道具ID] = {level解锁等级 ico显示图标 name名称 att属性加成 speed速度加成 day时效（单位天）,addLv提高培养等级上限的值}
		[2] = {level = 10,ico = 422,skill = 113,name = '汗血宝马',speed = 2,rid = 2,txt = '百里挑一的优良战骑，体力和耐力超乎寻常，凡间之物能如此已是不易。'},
		[3] = {level = 20,ico = 423,skill = 114,name = '雷霆狼骑',speed = 2,rid = 3,txt = '据说是蚩尤所驯化的狼骑后裔，很有灵性，忠诚度不容质疑，嚎叫声有种噬魂夺魄的气势。'},
		[4] = {level = 30,ico = 425,skill = 115,name = '太虚白熊',speed = 2,rid = 5,txt = '相传居于圣山昆仑，别被它的体型吓住，其实它很温顺，但在敌人面前却是彪悍了得。'},
		[5] = {level = 40,ico = 424,skill = 116,name = '绝影灵豹',speed = 2,rid = 4,txt = '生活在蛮荒不毛之地的灵豹，充满野性，将其驯化是个漫长且艰辛的过程。'},
		[6] = {level = 50,ico = 426,skill = 117,name = '咆哮天虎',speed = 3,rid = 6,txt = '傲立于圣山昆仑之巅的天虎，其吼声如雷，有震慑敌人的之效。'},		
		[7] = {level = 60,ico = 428,skill = 118,name = '混沌狴犴',speed = 3,rid = 8,txt = '乃龙之子，血统高贵，威风八面、霸气十足，正义与威严的化身。'},
		[8] = {level = 70,ico = 427,skill = 119,name = '爆炎年兽',speed = 3,rid = 7,txt = '要驾驭这样一头脾气暴躁的年兽需要相当的勇气，年兽的忠诚与它的执拗一样，完美的坐骑。'},
		[9] = {level = 80,ico = 430,skill = 120,name = '炙火麒麟',speed = 4,rid = 10,txt = '太古时代的圣物之一，其尊贵气质和强大气场是倍受王族的青睐。'},		
		[10] = {level = 90,ico = 429,skill = 121,name = '碧晶海兽',speed = 4,rid = 9,txt = '龙族偏爱的坐骑，乘风破浪、来去自如，速度与激情的完美结合。'},
		[11] = {level = 100,ico = 431,skill = 122,name = '至尊龙帝',speed = 5,rid = 11,txt = '坐骑中的绝对王者！若能驭之，此生何憾。'},
		[12] = {level = 110,ico = 431,skill = 122,name = '至尊龙帝',speed = 5,rid = 26,txt = '坐骑中的绝对王者！若能驭之，此生何憾。'},
		[13] = {level = 120,ico = 431,skill = 122,name = '至尊龙帝',speed = 5,rid = 27,txt = '坐骑中的绝对王者！若能驭之，此生何憾。'},
	},
	[2] = { --特殊 h = 24  limit = 20, 达到20级永久获得，配合h配置
		[1] = {ico = 434,name = '瑞祥玄龟',att = {100,nil,nil,nil,nil,nil,nil,nil},rid = 14,txt = '太古时代留存下来的古老物种，被视为具有瑞祥之气的神圣之物，据说能带来好运。'}, --{cardid 幻化卡ID h 时效多少小时}		
		[2] = {ico = 432,name = '陆行火鸟',att = {2000,nil,nil,nil,200,200,nil,nil},rid = 12,txt = '来自于华夏之外的奇异生物，胃口极大、耐力惊人，叫声不怎么让人感到愉悦。'},		
		[3] = {ico = 436,name = '迅猛恐龙',att = {3000,nil,300,300},rid = 16,txt = '来自于遗落世界的古老生物，曾几何时这些生物统治着整个世界，如今却只能在地心苟活。'},
		[4] = {ico = 435,name = '魅影天蝎',att = {5000,nil,1000,1000},rid = 15,txt = '来自异域的神秘生物，与黑暗为伴的剧毒天蝎，如同魅影一般让人难以捉摸其行踪。'},
		[5] = {ico = 438,name = '巨刃犀牛',att = {nil,nil,1000,800,nil,nil,500},rid = 18,txt = '虽是草食动物，却有着暴躁的脾气。千万别惹怒了它，它的彪悍足以让你后悔你的冒犯之举。'},
		[6] = {ico = 632,name = '圣诞麋鹿',att = {nil,nil,200,nil,nil,100},rid = 19,txt = '圣诞节的吉祥物，拥有它，明年一年都会有好运！'},
		[7] = {ico = 572,name = '昆仑陆吾',att = {nil,nil,1000,1000,nil,nil,nil,nil,500},rid = 17,txt = '昆仑山山神，掌管天之九部和天帝园圃的时节，是一种强大的神兽。'},
		[8] = {ico = 726,name = '烈焰独角兽',att = {nil,nil,500,400,nil,nil,300},rid = 23,txt = '马年吉祥物，烈焰奔腾的骏马，代表您的事业在马年红红火火，蒸蒸日上。'},
		[9] = {ico = 728,name = '通灵狸猫',att = {nil,nil,500,400,nil,nil,300},rid = 24,txt = '这是一只极具灵性的狸猫。'},
		[10] = {ico = 802,name = '雪山盘角羊',h = 168,att = {nil,nil,nil,nil,nil,nil,nil},rid = 25,txt = '这是一只具有一对大角的雪山盘角羊，性情温和。'},
		[11] = {ico = 727,name = '拳击螃蟹',att = {2000,nil,300,300,nil,nil,nil},rid = 22,txt = '来着异域，擅长拳击的神奇螃蟹。'},
		[12] = {ico = 861,name = '恶魔狮蝎',att = {2000,nil,500,500,nil,nil,nil},rid = 28,txt = '狮身蝎爪，行动如闪电的变种怪兽，浑身散发着恶魔的气息。'},
		[13] = {ico = 871,name = '地狱犬',att = {2000,nil,500,500,nil,nil,nil},rid = 29,txt ='三头犬，真正意义上的恶魔，地狱大门的守护者。'},
		[14] = {ico = 906,name = '羊驼',att = {nil,nil,500,400,nil,nil,300},rid = 30,txt ='羊驼，上古时期的神兽，只有传说中的人才配拥有它。'},
		[15] = {ico = 931,name = '幽灵坐骑',att = {nil,nil,1000,800,nil,nil,500},rid = 31,txt ='幽灵坐骑，别被它的外表迷惑，它可是拥有十万马力的上古神器。'},
		[16] = {ico = 936,name = '邪煞冰晶兽',att = {3000,nil,1000,1000},rid = 32,txt = '出没于极寒之地的圣兽，拥有闪电一般的速度。'},
		[17] = {ico = 947,name = '飞天神象',att = {nil,nil,1000,800,nil,nil,500},rid = 33,txt = '来自西域神秘国度的吉祥物，能给人们带来快乐和祝福。'},
		[18] = {ico = 952,name = '死亡夜魇',att = {200000,nil,200000,200000,200000,200000,200000},rid = 35,txt = '上古邪神死亡夜魇，所有上古怨灵魂魄的集合体，是所有邪念、阴暗面的源泉。'},
	},
}

local mount_buchang = {
	[46]=3,	
	[47]=6,	
	[48]=9,	
	[49]=17,	
	[50]=26,
	[51]=37,	
	[52]=52,
	[53]=70,
	[54]=92,
	[55]=121,	
	[56]=157,	
	[57]=197,	
	[58]=244,	
	[59]=300,	
	[60]=359,	
	[61]=432,	
	[62]=519,	
	[63]=613,	
	[64]=717,	
	[65]=833,	
	[66]=967,	
	[67]=1116,	
	[68]=1278,	
	[69]=1454,	
	[70]=1644,	
	[71]=1868,	
	[72]=2106,	
	[73]=2364,	
	[74]=2642,	
	[75]=2940,	
	[76]=3279,	
	[77]=3640,	
	[78]=4027,	
	[79]=4434,	
	[80]=4869,	
	[81]=5359,	
	[82]=5882,	
	[83]=6434,	
	[84]=7014,	
	[85]=7627,	
	[86]=8313,	
	[87]=9034,	
	[88]=9797,	
	[89]=10595,	
	[90]=11436,	
	[91]=12367,	
	[92]=13342,	
	[93]=14362,	
	[94]=15425,	
	[95]=16538,	
	[96]=17763,	
	[97]=19042,	
	[98]=20373,	
	[99]=21764,	
	[100]=23214,
}

--坐骑装备配置
MouseEquipConf = {
	maxnum = 8, --装备的个数
	lv = {10,10,20,20,30, 800}, --各品质强化上限
	openLevel = {51,20}, --开放等级 人51级 坐骑2阶
	mxlv = 6, --最大品质
	kwGoodid = 796, --符文石ID
	kwmxlv = 800, --刻纹最大等级
	uplv = {--提品
		[1] = {lv = 30,up = {{795,10},30},}, --lv 提品的限制等级 up {提品需要的材料,个数,材料价值元宝单价}
		[2] = {lv = 40,up = {{795,20},30},},
		[3] = {lv = 50,up = {{795,30},30},},
		[4] = {lv = 60,up = {{795,40},30},},
		[5] = {lv = 70,up = {{795,50},30},},
	},
	hardlv = {
		--[[
		白色品质 – 妖兽内丹●残品
		绿色品质 – 妖兽内丹●下品
		蓝色品质 – 妖兽内丹●中品
		紫色品质 – 妖兽内丹●上品
		橙色品质 – 妖兽内丹●极品
		红色品质 – 妖兽内丹●完美
		]]--
		goodid1 = {788,788}, --强化材料1
		cost1 = {5,5}, --材料价值元宝
		goodid2 = {789,789,789,789,789,789}, --强化材料2
		num1 = {10,20,35,50,65,80}, --材料1需要个数
		num2 = {1,2,3,4,5,6}, --材料2需要个数
		money = {50000,100000,150000,200000,250000,300000}, --消的铜钱数
	},
	extra = { --全品质属性加成
		[2]={300,nil,100,80,50,30,50,30,20},
		[3]={900,nil,300,240,150,90,150,90,60},
		[4]={1800,nil,600,480,300,180,300,180,120},
		[5]={3000,nil,1000,800,500,300,500,300,200},
		[6]={4500,nil,1500,1200,750,450,750,450,300},
	},
	Kwextra = { --全刻纹属性加成
		[1]={300,nil,100,80,50,30,50,30,20},
		[2]={900,nil,300,240,150,90,150,90,60},
		[3]={1800,nil,600,480,300,180,300,180,120},
		[4]={3000,nil,1000,800,500,300,500,300,200},
		[5]={4500,nil,1500,1200,750,450,750,450,300},
		[6]={6000,nil,2000,1500,900,600,900,600,400},
		[7]={7500,nil,2500,1800,1100,750,1100,750,500},
		[8]={9000,nil,3000,2100,1300,900,1300,900,600},
		[9]={10500,nil,3500,2400,1500,1050,1500,1050,700},
		[10]={12000,nil,4000,2700,1700,1200,1700,1200,800},
		[11]={13500,nil,4500,3000,1900,1350,1900,1350,900},
		[12]={15000,nil,5000,3300,2100,1500,2100,1500,1000},
		[13]={16500,nil,5500,3600,2300,1650,2300,1650,1100},
		[14]={18000,nil,6000,3900,2500,1800,2500,1800,1200},
		[15]={19500,nil,6500,4200,2700,1950,2700,1950,1300},
		[16]={21000,nil,7000,4500,2900,2100,2900,2100,1400},
		[17]={22500,nil,7500,4800,3100,2250,3100,2250,1500},
		[18]={24000,nil,8000,5100,3300,2400,3300,2400,1600},
		[19]={25500,nil,8500,5400,3500,2550,3500,2550,1700},
		[20]={27000,nil,9000,5700,3700,2700,3700,2700,1800},
		[21]={28500,nil,9500,6000,3900,2850,3900,2850,1900},
		[22]={30000,nil,10000,6300,4100,3000,4100,3000,2000},
		[23]={31500,nil,10500,6600,4300,3150,4300,3150,2100},
		[24]={33000,nil,11000,6900,4500,3300,4500,3300,2200},
		[25]={34500,nil,11500,7200,4700,3450,4700,3450,2300},
		[26]={36000,nil,12000,7500,4900,3600,4900,3600,2400},
		[27]={37500,nil,12500,7800,5100,3750,5100,3750,2500},
		[28]={39000,nil,13000,8100,5300,3900,5300,3900,2600},
		[29]={40500,nil,13500,8400,5500,4050,5500,4050,2700},
		[30]={42000,nil,14000,8700,5700,4200,5700,4200,2800},
		[31]={43000,nil,14500,9000,5900,4350,5900,4350,2900},
		[32]={44000,nil,15000,9300,6100,4500,6100,4500,3000},
		[33]={45000,nil,15500,9600,6300,4650,6300,4650,3100},
		[34]={46000,nil,16000,9900,6500,4800,6500,4800,3200},
		[35]={47000,nil,16500,10200,6700,4950,6700,4950,4300},
		[36]={48000,nil,17000,10500,6900,5100,6900,5100,4400},
		[37]={49000,nil,17500,10800,7100,5250,7100,5250,4500},
		[38]={50000,nil,18000,11100,7300,5400,7300,5400,4600},
		[39]={51000,nil,18500,11400,7500,5550,7500,5550,4700},
		[40]={52000,nil,19000,11700,7700,5700,7700,5700,4800},
		[41]={53000,nil,19500,12000,7900,5850,7900,5850,4900},
		[42]={54000,nil,20000,12300,8100,6000,8100,6000,5000},
		[43]={55000,nil,20500,12600,8300,6150,8300,6150,6100},
		[44]={56000,nil,21000,12900,8500,6300,8500,6300,6200},
		[45]={57000,nil,21500,13200,8700,6450,8700,6450,6300},
		[46]={58000,nil,22000,13500,8900,6600,8900,6600,6400},
		[47]={59000,nil,22500,13800,9100,6750,9100,6750,6500},
		[48]={60000,nil,23000,14100,9300,6900,9300,6900,6600},
		[49]={61000,nil,23500,14400,9500,7050,9500,7050,6700},
		[50]={62000,nil,24000,14700,9700,7200,9700,7200,6800},
		[51]={65000,nil,25000,16000,10000,7500,10000,7500,7000},
		[52]={68000,nil,26000,17000,10500,8000,10500,8000,7200},
		[53]={71000,nil,27000,18000,11000,8500,11000,8500,7400},
		[54]={74000,nil,28000,19000,11500,9000,11500,9000,7600},
		[55]={77000,nil,29000,20000,12000,9500,12000,9500,7800},
		[56]={80000,nil,30000,21000,12500,10000,12500,10000,8000},
		[57]={83000,nil,31000,22000,13000,10500,13000,10500,8200},
		[58]={86000,nil,32000,23000,13500,11000,13500,11000,8400},
		[59]={89000,nil,33000,24000,14000,11500,14000,11500,8600},
		[60]={92000,nil,34000,25000,14500,12000,14500,12000,8800},
		[61]={95000,nil,35000,26000,15000,12500,15000,12500,9000},
		[62]={98000,nil,36000,27000,15500,13000,15500,13000,9200},
		[63]={101000,nil,37000,28000,16000,13500,16000,13500,9400},
		[64]={104000,nil,38000,29000,16500,14000,16500,14000,9600},
		[65]={107000,nil,39000,30000,17000,14500,17000,14500,9800},
		[66]={110000,nil,40000,31000,17500,15000,17500,15000,10000},
		[67]={113000,nil,41000,32000,18000,15500,18000,15500,10200},
		[68]={116000,nil,42000,33000,18500,16000,18500,16000,10400},
		[69]={119000,nil,43000,34000,19000,16500,19000,16500,10600},
		[70]={122000,nil,44000,35000,19500,17000,19500,17000,10800},
		[71]={125000,nil,55000,36000,20000,17500,20000,17500,11000},
		[72]={128000,nil,56000,37000,20500,18000,20500,18000,11200},
		[73]={131000,nil,57000,38000,21000,18500,21000,18500,11400},
		[74]={134000,nil,58000,39000,21500,19000,21500,19000,11600},
		[75]={137000,nil,59000,40000,22000,19500,22000,19500,11800},
		[76]={140000,nil,60000,41000,22500,20000,22500,20000,12000},
		[77]={143000,nil,61000,42000,23000,20500,23000,20500,12200},
		[78]={146000,nil,62000,43000,23500,21000,23500,21000,12400},
		[79]={149000,nil,63000,44000,24000,21500,24000,21500,12600},
		[80]={152000,nil,64000,45000,24500,22000,24500,22000,12800},
	

	},
	att = {
		[1]={100,nil,30,24,20,16,20,20,20},
		[2]={150,nil,45,36,30,24,30,30,30},
		[3]={200,nil,60,48,50,40,50,50,50},
		[4]={300,nil,80,64,60,48,60,60,60},
		[5]={400,nil,100,80,75,60,75,75,75},
		[6]={500,nil,120,96,90,72,90,90,90},

	},
	[1] = {
		name = {'玄铁鞍具','翡翠鞍具','蓝晶鞍具','紫玉鞍具','暗金鞍具','神话鞍具'},
		ico = {730,731,732,733,734,735},
		att = {1,8},
		t = 2, --t 装备类型 1 攻击类 2 防御类
		--[[
		攻击类装备，需要材料“妖兽爪牙”
		防御类装备，需要材料“妖兽皮毛”
		]]--
	},
	[2] = {
		name = {'玄铁缰绳','翡翠缰绳','蓝晶缰绳','紫玉缰绳','暗金缰绳','神话缰绳'},
		ico = {736,737,738,739,740,741},
		att = {7,9},
		t = 1, --t 装备类型 1 攻击类 2 防御类
	},
	[3] = {
		name = {'玄铁蹄铁','翡翠蹄铁','蓝晶蹄铁','紫玉蹄铁','暗金蹄铁','神话蹄铁'},
		ico = {742,743,744,745,746,747},
		att = {3,5},
		t = 1, --t 装备类型 1 攻击类 2 防御类
	},
	[4] = {
		name = {'玄铁马镫','翡翠马镫','蓝晶马镫','紫玉马镫','暗金马镫','神话马镫'},
		ico = {748,749,750,751,752,753},
		att = {4,6},
		t = 2, --t 装备类型 1 攻击类 2 防御类
	},
	[5] = {
		name = {'玄铁护甲','翡翠护甲','蓝晶护甲','紫玉护甲','暗金护甲','神话护甲'},
		ico = {754,755,756,757,758,759},
		att = {4,9},
		t = 2, --t 装备类型 1 攻击类 2 防御类
	},
	[6] = {
		name = {'玄铁兽盔','翡翠兽盔','蓝晶兽盔','紫玉兽盔','暗金兽盔','神话兽盔'},
		ico = {760,761,762,763,764,765},
		att = {1,6},
		t = 2, --t 装备类型 1 攻击类 2 防御类
	},
	[7] = {
		name = {'玄铁挂饰','翡翠挂饰','蓝晶挂饰','紫玉挂饰','暗金挂饰','神话挂饰'},
		ico = {766,767,768,769,770,771},
		att = {3,8},
		t = 1, --t 装备类型 1 攻击类 2 防御类
	},
	[8] = {
		name = {'玄铁马鞭','翡翠马鞭','蓝晶马鞭','紫玉马鞭','暗金马鞭','神话马鞭'},
		ico = {772,773,774,775,776,777},
		att = {7,5},
		t = 1, --t 装备类型 1 攻击类 2 防御类
	},
}

--坐骑数据结构					  
local MountsTb = { 
	id = 1001, --坐骑幻化ID(类型*1000+index)
	lv = 1, --进化当前等级
	new = 1,
	--bone = {0,0}, --坐骑炼骨等级(当前等级、当前进度)
	--pt = {抽奖点数、已领礼包} -- 初始化没有{抽奖点数,领取礼包标识11111111} 五点需要清空
	--luck ={0,0} --初始化没有 {加成成功率,幸运值} 五点需要清空
	--extra = {[id]=[time,limit]}(要判断是否过期) 或 {[id] = 1}(永不过期)
	--特殊幻化 初始化没有 id特殊幻化索引，time过期时间, limit 如果不为空，则到期时坐骑等级未达20级则过期，否则永久不过期
	__x = 250--初始化坐骑时加入数据区判断值
}

--获取坐骑数据					  
local function _GetMountsData(sid)
	local mountsdata=GI_GetPlayerData( sid , 'mount' , 250 )
	if mountsdata == nil or mountsdata.id == nil then return end
	return mountsdata
end

--返回坐骑等级
function get_mounts_lv(sid)
	local data = _GetMountsData(sid)
	if(data)then
		return data.lv
	end
end

--计算加成属性并更新个人属性
local function _AddMountsAtt(sid)
	local data = _GetMountsData(sid)
	if(nil == data)then
		return  --没有坐骑数据
	end
	local AttTb = GetRWData(1)
	local Temp = MouseChgeConf.att --属性计算系数
	local lv = data.lv
	--ROUND(C5^1.2*0.45,2)
	for i = 1,12 do
		if(Temp[i] ~= nil)then
			AttTb[i] = math_floor((10+(lv^1.7)*1.8) * Temp[i])
		end
	end
	
	--是否有特殊幻化
	if(data.extra~=nil)then
		local tb
		local tbatt
		for cidx,v in pairs (data.extra) do
			tb = MouseChgeConf[2][cidx]
			if(tb~=nil and tb.att~= nil)then --这里就不判断时效性了，伤不起啊 
				for i = 1,12 do
					if(tb.att[i]~=nil)then
						if(AttTb[i] == nil)then AttTb[i] = 0 end
						AttTb[i] = AttTb[i] + tb.att[i]
					end
				end
			end
		end
	end
	
	local addRate = 0 --炼骨的百分比加成
	if(data.bone~=nil and data.bone[1]>0)then
		addRate = data.bone[1]/100
	end
	--炼骨加成
	for i = 1,12 do
		if(AttTb[i]~=nil)then
			AttTb[i] = math_floor(AttTb[i]*(1+addRate))
		end
	end
	
	--计算坐骑装备加成
	if(data.equ~=nil)then
		local mq
		local mlv
		local mklv
		local equlv
		local q = 6
		local kw = MouseEquipConf.kwmxlv
		local attconf
		for i = 1,8 do
			equlv = data.equ[i]
			if(equlv~=nil)then
				mq = math_floor(equlv/1000000) --品质
				mlv = math_floor(equlv%1000) --强化等级
				mklv = math_floor(math_floor(equlv/1000)%1000) --刻纹等级

				attconf = MouseEquipConf[i].att
				if(attconf)then
					for _,v in pairs(attconf) do
						if(v~=nil)then
							--强化的
							if(AttTb[v] == nil)then AttTb[v] = 0 end
							for j = 1,mq do
								if(j<mq)then
									AttTb[v] = AttTb[v] + MouseEquipConf.att[j][v]*MouseEquipConf.lv[j]
								else
									AttTb[v] = AttTb[v] + MouseEquipConf.att[j][v]*mlv
								end
							end
							--刻纹的
							if(v == 1)then
								AttTb[v] = AttTb[v] + 100*mklv + math_floor(mklv*(mklv+1)/2/10*20)
							elseif(v == 3 or v == 4)then
								AttTb[v] = AttTb[v] + 40*mklv + math_floor(mklv*(mklv+1)/2/10*6)
							else
								AttTb[v] = AttTb[v] + 20*mklv + math_floor(mklv*(mklv+1)/2/10*4)
							end
						end
					end
				end
				if(mq<q)then q = mq end
				if(mklv<kw)then kw = mklv end
			else
				q = 0
				kw = 0
			end
		end
		
		if(MouseEquipConf.extra[q]~=nil)then
			attconf = MouseEquipConf.extra[q]
			for idx,v in pairs(attconf) do
				if(AttTb[idx] == nil)then AttTb[idx] = 0 end
				AttTb[idx] = AttTb[idx] + v
			end
		end
		
		if(kw>9)then
			local kwidx = math_floor(kw/10)
			if(MouseEquipConf.Kwextra[kwidx]~=nil)then
				attconf = MouseEquipConf.Kwextra[kwidx]
				for idx,v in pairs(attconf) do
					if(AttTb[idx] == nil)then AttTb[idx] = 0 end
					AttTb[idx] = AttTb[idx] + v
				end
			end
		end
	end
	
	PI_UpdateScriptAtt(sid,1)
	
	SendLuaMsg( 0, { ids = Horse_Att}, 9 )
end

--向前台发送坐骑数据 sid 玩家ID
local function _SendMouseData(sid,isupdate,name,type,r)
	if(sid == nil and name~=nil)then
		sid = GetPlayer(name) or 0
	end
	if(not IsPlayerOnline(sid))then
		SendLuaMsg( 0, { ids = Horse_Data, t = 0, sid = sid, leave = 1}, 9 )
		return
	end
	local data = _GetMountsData(sid)
	if(r == nil)then
		if(data~=nil)then 
			if(isupdate and CI_GetPlayerData(17) == sid)then _AddMountsAtt(sid) end 
			SendLuaMsg( 0, { ids = Horse_Data, t = 0, data = data, sid = sid, type = type, name = name}, 9 )
		else
			SendLuaMsg( 0, { ids = Horse_Data, t = 0, sid = sid}, 9 )
		end
	else
		return data
	end
end

--登录时人物加成或计算战斗力时调用，不计算速度
local function _LoginMountsAtt(sid)
	local data = _GetMountsData(sid)
	if(nil == data)then
		return  --没有坐骑数据
	end
	local AttTb = GetRWData(1)
	local Temp = MouseChgeConf.att --属性计算系数
	local lv = data.lv
	--ROUND(C5^1.2*0.45,2)
	for i = 1,12 do
		if(Temp[i] ~= nil)then
			AttTb[i] = math_floor((10+(lv^1.7)*1.8) * Temp[i])
		end
	end
	
	--是否有特殊幻化
	if(data.extra~=nil)then
		local tb
		local tbatt
		for cidx,v in pairs (data.extra) do
			tb = MouseChgeConf[2][cidx]
			if(tb~=nil and tb.att~= nil)then --这里就不判断时效性了，伤不起啊 
				for i = 1,12 do
					if(tb.att[i]~=nil)then
						if(AttTb[i] == nil)then AttTb[i] = 0 end
						AttTb[i] = AttTb[i] + tb.att[i]
					end
				end
			end
		end
	end
	
	local addRate = 0 --炼骨的百分比加成
	if(data.bone~=nil and data.bone[1]>0)then
		addRate = data.bone[1]/100
	end
	--炼骨加成
	for i = 1,14 do
		if(AttTb[i]~=nil)then
			AttTb[i] = math_floor(AttTb[i]*(1+addRate))
		else
			AttTb[i] = 0
		end
	end
	
	--计算坐骑装备加成
	if(data.equ~=nil)then
		local mq
		local mlv
		local mklv
		local equlv
		local q = 6
		local kw = MouseEquipConf.kwmxlv
		local attconf
		for i = 1,8 do
			equlv = data.equ[i]
			if(equlv~=nil)then
				mq = math_floor(equlv/1000000) --品质
				mlv = math_floor(equlv%1000) --强化等级
				mklv = math_floor(math_floor(equlv/1000)%1000) --刻纹等级
				
				attconf = MouseEquipConf[i].att
				if(attconf)then
					for _,v in pairs(attconf) do
						if(v~=nil)then
							--强化的
							if(AttTb[v] == nil)then AttTb[v] = 0 end
							for j = 1,mq do
								if(j<mq)then
									AttTb[v] = AttTb[v] + MouseEquipConf.att[j][v]*MouseEquipConf.lv[j]
								else
									AttTb[v] = AttTb[v] + MouseEquipConf.att[j][v]*mlv
								end
							end
							--刻纹的
							if(v == 1)then
								AttTb[v] = AttTb[v] + 100*mklv + math_floor(mklv*(mklv+1)/2/10*20)
							elseif(v == 3 or v == 4)then
								AttTb[v] = AttTb[v] + 40*mklv + math_floor(mklv*(mklv+1)/2/10*6)
							else
								AttTb[v] = AttTb[v] + 20*mklv + math_floor(mklv*(mklv+1)/2/10*4)
							end
						end
					end
				end
				if(mq<q)then q = mq end
				if(mklv<kw)then kw = mklv end
			else
				q = 0
				kw = 0
			end
		end
		
		if(MouseEquipConf.extra[q]~=nil)then
			attconf = MouseEquipConf.extra[q]
			for idx,v in pairs(attconf) do
				if(AttTb[idx] == nil)then AttTb[idx] = 0 end
				AttTb[idx] = AttTb[idx] + v
			end
		end
		
		if(kw>9)then
			local kwidx = math_floor(kw/10)
			if(MouseEquipConf.Kwextra[kwidx]~=nil)then
				attconf = MouseEquipConf.Kwextra[kwidx]
				for idx,v in pairs(attconf) do
					if(AttTb[idx] == nil)then AttTb[idx] = 0 end
					AttTb[idx] = AttTb[idx] + v
				end
			end
		end
	end
	
	return true
end

--上下坐骑
local function _UpDownMount(sid,isride)
	look('_UpDownMount'..isride)
	local data = _GetMountsData(sid)
	if(nil == data)then return end
	
	if(isride>0)then --下马
		look('下马')
		if(CI_OperateMounts(2))then
		end
	else --上马
		local SpeedVal = MouseChgeConf.speed
		for id,v in pairs (MouseChgeConf[1]) do
			if(v~=nil and v.speed~=nil and v.level~=nil and data.lv>=v.level)then --已解锁的幻化
				SpeedVal = SpeedVal + v.speed
			end
		end
		--是否有特殊幻化
		if(data.extra~=nil)then
			local tb
			for cidx,v in pairs (data.extra) do
				tb = MouseChgeConf[2][cidx]
				if(tb~=nil and tb.speed~=nil)then
					SpeedVal = SpeedVal + tb.speed
				end
			end
		end
		
		local id = data.id
		if(CI_OperateMounts(1,id,SpeedVal))then
			look('坐骑ID'..id)
		end
	end
end

--给坐骑
function GiveMounts(sid)
	local tb
	local hid
	local hlv
	local data = _GetMountsData(sid)
	if(data~=nil)then
		hlv = data.lv
		if(hlv~=nil)then
			tb = MouseChgeConf[1]
			local len = #tb
			local curIdx
			for i = 1,len do
				if(tb[i]~=nil and tb[i].level~=nil)then
					if(tb[i].level<=hlv)then
						curIdx = i
					else
						break
					end
				end
			end
			if(curIdx~=nil and tb[curIdx]~=nil and tb[curIdx].skill~=nil)then
				CI_SetSkillLevel(1,tb[curIdx].skill,1,13) --设置坐骑技
			end
			--_UpDownMount(sid,1)
			_UpDownMount(sid,0)
		end
		return -1 --已经有坐骑了
	end
	dbMgr[sid].data.mount = table_copy(MountsTb)
	tb = MouseChgeConf[1]
	hid = MountsTb.id%100
	if(tb and tb[hid] and tb[hid].skill)then
		CI_SetSkillLevel(1,tb[hid].skill,1,13) --设置坐骑技
	end
	--_UpDownMount(sid,1)
	_UpDownMount(sid,0)
	_SendMouseData(sid,true)
	return 0
end

--登录检查是否要上马
function LoginCheckRide(sid)
	local data = _GetMountsData(sid)
	if(data~=nil)then
		if(data.ride~=nil)then
			_UpDownMount(sid,0)
			data.ride = nil
		end
	end
end

--获得坐骑的战斗力
function GetMountsFPoint(sid)
	local mountsdata = _GetMountsData(sid)
	if(mountsdata == nil)then return 0,0 end --坐骑不存在
	if(_LoginMountsAtt(sid))then
		local attTb = GetRWData(1,true)
		if(attTb == nil)then return 0,0 end
		local mountID = mountsdata.id
		local fightPoint = math_floor(attTb[3]+attTb[4]+attTb[10]+attTb[11]+attTb[12]+attTb[1]*0.2+(attTb[5]+attTb[6]+attTb[7]+attTb[8]+attTb[9])*1.3 + attTb[2]*2 + attTb[14]*1.5)
		return mountID,fightPoint
	end
	return 0,0 
end

--下线
function setMountsLogout(sid)
	local data = _GetMountsData(sid)
	if(nil == data)then return end
	local rid = GetRidingMountId()
	if(rid>0)then
		data.ride = 1
	else
		data.ride = nil
	end
end

--清除
function clearMount(sid)
	local data = _GetMountsData(sid)
	if(data~=nil)then
		data.pt = nil
		SendLuaMsg( 0, { ids = Horse_Data, t = 0, data = data, sid = sid}, 9 )
	end
end

--发送坐骑抽奖标识
function sendMountLuck()
	SendLuaMsg( 0, { ids = Horse_Luck, isluck = MouseIsLuck, dt = MouseActiveData()}, 9 )
end

--更新广播 sign 1 开启 0 结束
function sendMountLuckRPC(sign)
	MouseIsLuck = sign
	BroadcastRPC('Mouse_UpdateLuck',MouseIsLuck,MouseActiveData())
end

--y,mt,d,h,m,s 坐骑抽奖活动的到期时间
--GetTimeToSecond(2013,11,10,0,0,0)
function MouseActiveData()
	local openTime = GetServerOpenTime()
	--look('开服时间是'..openTime)
	if(openTime>0)then openTime = openTime + 7*24*60*60 end
	return openTime
end

--骑兵升阶
function set_mouse_new_id(lv)
	local sid = CI_GetPlayerData(17)
	if(sid == nil or sid == 0)then return end
	local mountsData = _GetMountsData(sid)
	if(mountsData~=nil)then
		local hid = mountsData.id
		local ctype = math_floor(hid/1000)
		local id = math_floor(hid%100)
		mountsData.id = ctype*1000 + lv*100 + id
		local mountid = GetRidingMountId()
		if(mountid>0)then --如果在马上就换坐骑形象
			--UpDownMount(sid,1)
			UpDownMount(sid,0)
		else
			CI_OperateMounts(1,-mountsData.id,0)
		end
	end
end

--修改经验补偿---20131122
function horse_login_makeup(playerid)
	if playerid==nil or playerid<1 then return end
	local data=_GetMountsData(playerid)
	if data==nil then 
		return
	end
	if data.new ~= nil then return end
	if data.lv == nil or data.lv<=45 then 
		data.new = 1
		return 
	end
	
	local lv=data.lv
	local goods={[3] = {{636,mount_buchang[lv],1},}}
	local arg={rint(lv/10),lv%10,mount_buchang[lv]}
	SendSystemMail(playerid,Horsebuchang,1,2,arg,goods)
	data.new = 1
end

GetMountsData = _GetMountsData
SendMouseData = _SendMouseData
LoginMountsAtt = _LoginMountsAtt
AddMountsAtt = _AddMountsAtt
UpDownMount = _UpDownMount