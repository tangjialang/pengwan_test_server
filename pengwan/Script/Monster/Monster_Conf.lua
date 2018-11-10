--[[
file:	Monster_Conf.lua
desc:	Monster created by script conf.
author:	chal
update:	2011-12-05
notes:
	1、所有除正常副本内怪物都统一配置在这张表里面,以deadScript为key累加
	2、如果没有deadScript可以不配置在这

势力定义:
	enum CAMP_DEFINE
	{
		CP_MONSTERFRIEND = 0,	// 怪物友好阵营（怪物）
		CP_PLAYER1,				// 玩家阵营1
		CP_PLAYER2,				// 玩家阵营2	
		CP_PLAYER3,				// 玩家阵营3	
		CP_PLAYERFRIEND4,		// 玩家友好阵营 （怪物）
		CP_PLAYERENEMY5,		// 玩家敌对阵营1（怪物）
		CP_PLAYERENEMY6,		// 玩家敌对阵营2（怪物）	
		CP_MAX,
	};

怪物配置说明:
	@controlId  怪物控制用ID(不能随便乱配！！！)
		特殊用途怪     1~99 
		{
			共同点: 不显示血条...
			[5 ~ 8] = 名字后跟(家将)
			[9 ~ 12] = 排位赛怪物(用于AI找怪)
			[13] = 攻城战雕像
		}
		特定功能怪	   1~99
		副本怪		   100~9999
		活动怪和BOSS   10000~ 99999
		野外怪  	   100000以上
	

	@deadScript   	  编号>=10000躺尸结束触发   编号<10000立即触发
		[1,999] 特殊怪物	
		{
			[1,7] 庄园排位和掠夺相关
			[8] 世界BOSS
		}
		[1000,3999] 野外怪
		[4000,9999] 活动怪物 每个活动100分段
		{
			4000 ~ 4099		三界战场
			4100 ~ 4199		神兽
			4200			抓鱼
			4201 ~ 4299		帮会战
			4300			玉石副本
			4301			帮会镖车
			4401 ~ 4499		帮会攻城战
			4501 ~ 4599		跨服BOSS
			4600 ~ 4699		单人塔防副本
			4900 ~ 4999		三界至尊
		}
		--10000以上是躺尸结束回调
		14300--宝石本

	
	@eventScript   	编号>1000 用于BOSS额外触发事件  
					编号 [1,200] 回调SI_OnClickMonster()
					{
						[1] 宴会桌子
						[2] 宴会宝箱
						[3] 帮会秘境宝箱
						[5] 天宫狩猎
						[6] 深海捕鱼
						.
						.
						.
						[10] 帮会复活水晶
					}
					编号 [201,250] 前台处理
					{
						[201] = 塔防副本
						[202]-妲己
						[203]挖宝商城副本
						[204]vip副本挖尸体
						[205]经验副本招怪
						[206]种树
						[207]单人塔防副本
						[208]三界至尊彩旗
					}
	
	@moveScript 	编号<10000 用于巡逻怪			编号> 10000 回调 OnMonsterMove_xxx
	--17001 ~       新手副本
	--22001			单人塔防副本
	
regionId 场景ID
monsterId 怪物ID
objectType 对象类型
name 怪物名字
imageID 图档编号
headID  头像编号
level   等级
school  职业
camp    阵营   123 玩家阵营， 4 友好阵营， 56敌对阵营
exp     携带经验
money   携带游戏币
bossType   BOSS类型  0 非BOSS  1 统计伤害的BOSS   2 统计伤害并且需要脚本处理奖励的BOSS  4 有仇恨系统的BOSS  8 掉落临时物品的BOSS  10 特殊标记的BOSS（小） 20 有特殊标记的BOSS（大）
aiType    怪物AI类型,0：无AI  1：可攻击AI  2：可受击AI  4：可反击AI(仇恨转移)  8：跟随AI  10：追击AI  20：专属AI  40：玩家AI  80：随从AI (16进制,要转换为10进制)
attackArea  追击范围（8-16）  超过范围就自动返回
moveArea    移动范围（4-8）   0 就是不移动的站桩怪
searchArea  搜索范围（5-10）  
atkSpeed    攻击速度(帧数)
dynDropID   动态掉落ID
refreshTime 刷新间隔时间帧（ 1秒= 5帧） 0表示不刷新
deadbody 躺尸时间帧 （ 1秒= 5帧） 0表示不躺尸
IdleTime     怪物启用帧,就是怪物创建以后,不会行动,也不能被攻击,经过多少帧后才开始正常行动。用于竞技倒计时和怪物创建特效时等待     
x            刷新坐标
y	     刷新坐标	
dir          刷新面对方向
mapIcon      是否在地图上限显示该怪物（例如动态刷的活动BOSS）
refreshScript    刷新触发脚本      触发接受函数名 = SI_OnMonsterRefresh编号
moveScript       移动触发脚本	   触发接受函数名 = SI_OnMonsterMove编号
updateTick   定时更新帧,多久触发一次timeScript, 循环触发
timeScript       定时触发脚本      触发接受函数名 = SI_MonsterAIUpdate编号    
deadScript       死亡触发脚本      触发接受函数名 = SI_OnMonsterDead编号
eventScript      注册条件触发脚本（掉多少血触发等）
monAtt      13个二级属性 {生命,怒气,攻击,防御,命中,闪避,暴击,抵抗,格挡,绝对伤害,绝对防御,暴击伤害,移动速度} 不修改的属性可以填nil或留空,
skillID      8个技能ID,同上     
skillLevel   8个技能等级,同上
targetID     移动目标的ID
targetX      移动地点的坐标
targetY      移动地点的坐标
BRMONSTER    是否批量刷怪 
centerX      批量刷的坐标（批量刷,就不用填X和Y属性）
centerY      批量刷的坐标
BRArea       批量刷新范围
BRNumber     批量刷的个数
BRTeamNumber  副本用,刷新的批次编号
 mapIcon = 1   表示需要全场景同步信息的怪物(同步血量)
Priority_Except ={ selecttype =  , type =  , target =  }   攻击目标选择：
selecttype ：[选择类型] 1.只攻击目标 2.不攻击目标 3 优先攻击目标 
 type：[目标类型] 1,某个阵营 2 某个门派 3 某个帮会 4 某个怪物 5 玩家
 target：如果是怪物,填写怪物controlId  如果是玩家,不填是所有玩家,填写玩家SID是针对某个玩家。

 {monsterId = 1,deadbody = 30,IdleTime = 1}
 
 特殊函数 ,点击怪物触发事件
 SI_OnClickMonster

动态修改怪物数据
CI_UpdateMonsterData (type,...)
1: 更新属性 参数就是上面那些
2: 指定怪物帮派 - factonname
3：给怪物指定一个临时技能 skillid lv 使用次数


]]--

-- 基本怪物配置里面 KEY(deadScript) 从1000开始、1000以下留给特殊怪物
-- 注意：应该尽量保证 key = deadScript
-- 注意: 所有需要配置controlID的特殊怪物、必须写清楚用途、以免使用重复cid出错
MonsterConfList = 
{
	--[301] = {
		--{ name = '野猪', monsterId = 2 ,controlId=302, movespeed = 110 ,   dir = 2, objectType = 0, aiType=4, refreshScript=0 ,  BRMONSTER = 1 , centerX = 53 , centerY = 22 , BRArea = 1 , BRNumber =3 ,Priority_Except ={ selecttype = 1 , type = 2 , target = 301 } ,targetID=301, },
		--{ name = '王二狗',eventScript=1,controlId=301,x=54,y=17, monsterId = 1 , movespeed = 0 ,  dir = 6, objectType = 0, aiType=9, school = 4},
	--	},
	[1] = {
		{ monsterId = 5,level = 99,name = "巡逻士兵" , imageID = 2095,headID = 1011,x = 29 ,y = 111,targetX = 40 ,targetY = 100,camp = 4,controlId = 100150,moveScript=1101 },
		{ monsterId = 5,level = 99,name = "巡逻士兵" , imageID = 2095,headID = 1011,x = 31 ,y = 50,targetX = 16 ,targetY = 35,camp = 4,controlId = 100151,moveScript=1201 },
		{ monsterId = 5,level = 99,name = "巡逻士兵" , imageID = 2095,moveArea = 1,headID = 1011,x = 33 ,y = 52,targetID = 100151,camp = 4,controlId = 100156 },
		{ monsterId = 5,level = 99,name = "巡逻士兵" , imageID = 2095,moveArea = 1,headID = 1011,x = 34 ,y = 53,targetID = 100156,camp = 4,controlId = 100157 },
		{ monsterId = 5,level = 99,name = "巡逻士兵" , imageID = 2095,headID = 1011,x = 43 ,y = 31,targetX = 54 ,targetY = 42,camp = 4,controlId = 100152,moveScript=1301 },
		{ monsterId = 5,level = 99,name = "巡逻官" , imageID = 2096,headID = 1012,x = 81 ,y = 43,targetX = 98 ,targetY = 60,camp = 4,controlId = 100153,moveScript=1401 },
		{ monsterId = 5,level = 99,name = "巡逻士兵" , imageID = 2095,headID = 1011,x = 53 ,y = 156,targetX = 96 ,targetY = 113,camp = 4,controlId = 100154,moveScript=1501 },
		{ monsterId = 5,level = 99,name = "巡逻士兵" , imageID = 2095,moveArea = 1,headID = 1011,x = 55 ,y = 155,targetID = 100154,camp = 4,controlId = 100158 },
		{ monsterId = 5,level = 99,name = "巡逻士兵" , imageID = 2095,moveArea = 1,headID = 1011,x = 54 ,y = 157,targetID = 100158,camp = 4,controlId = 100159 },
		{ monsterId = 5,level = 99,name = "巡逻官" , imageID = 2096,headID = 1012,x = 74 ,y = 98,targetX = 64 ,targetY = 98,camp = 4,controlId = 100155,moveScript=1601 },
		{ monsterId = 5,level = 99,name = "巡逻士兵" , imageID = 2095,moveArea = 1,headID = 1011,x = 74 ,y = 97,targetID = 100155,camp = 4,controlId = 100160 },
		{ monsterId = 5,level = 99,name = "巡逻士兵" , imageID = 2095,moveArea = 1,headID = 1011,x = 74 ,y = 99,targetID = 100160,camp = 4,controlId = 100161 },
	},
	[3] = {
		{monsterId = 5,moveArea = 0 ,x = 62 ,y = 163,dir = 1 ,refreshTime = 1,deadbody = 6 ,controlId = 100101 },
		--{monsterId = 5,moveArea = 0 ,x = 63 ,y = 164,dir = 1 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 64 ,y = 165,dir = 1 ,refreshTime = 1,deadbody = 6 ,controlId = 100102},
		--{monsterId = 5,moveArea = 0 ,x = 65 ,y = 166,dir = 1 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 66 ,y = 167,dir = 1 ,refreshTime = 1,deadbody = 6 ,controlId = 100103},
		--{monsterId = 5,moveArea = 0 ,x = 67 ,y = 168,dir = 1 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 68 ,y = 169,dir = 1 ,refreshTime = 1,deadbody = 6 ,controlId = 100104},
		--{monsterId = 5,moveArea = 0 ,x = 68 ,y = 170,dir = 1 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 69 ,y = 172,dir = 1 ,refreshTime = 1,deadbody = 6 ,controlId = 100105},
		--{monsterId = 5,moveArea = 0 ,x = 70 ,y = 173,dir = 1 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 71 ,y = 174,dir = 1 ,refreshTime = 1,deadbody = 6 ,controlId = 100106},
		--{monsterId = 5,moveArea = 0 ,x = 72 ,y = 175,dir = 1 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 73 ,y = 176,dir = 1 ,refreshTime = 1,deadbody = 6 ,controlId = 100107},
		--{monsterId = 5,moveArea = 0 ,x = 74 ,y = 178,dir = 1 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 75 ,y = 179,dir = 1 ,refreshTime = 1,deadbody = 6 ,controlId = 100108},
		--{monsterId = 5,moveArea = 0 ,x = 76 ,y = 180,dir = 1 ,refreshTime = 1,deadbody = 3},
		
		
		{monsterId = 5,moveArea = 0 ,x = 67 ,y = 159,dir = 5 ,refreshTime = 1,deadbody = 6 ,controlId = 100109},
		--{monsterId = 5,moveArea = 0 ,x = 68 ,y = 160,dir = 5 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 69 ,y = 161,dir = 5 ,refreshTime = 1,deadbody = 6 ,controlId = 100110},
		--{monsterId = 5,moveArea = 0 ,x = 70 ,y = 162,dir = 5 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 73 ,y = 167,dir = 5 ,refreshTime = 1,deadbody = 6 ,controlId = 100111},
		--{monsterId = 5,moveArea = 0 ,x = 72 ,y = 166,dir = 5 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 71 ,y = 164,dir = 5 ,refreshTime = 1,deadbody = 6 ,controlId = 100112},
		--{monsterId = 5,moveArea = 0 ,x = 74 ,y = 169,dir = 5 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 75 ,y = 170,dir = 5 ,refreshTime = 1,deadbody = 6 ,controlId = 100113},
		--{monsterId = 5,moveArea = 0 ,x = 76 ,y = 171,dir = 5 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 77 ,y = 172,dir = 5 ,refreshTime = 1,deadbody = 6 ,controlId = 100115},
		--{monsterId = 5,moveArea = 0 ,x = 78 ,y = 173,dir = 5 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 79 ,y = 175,dir = 5 ,refreshTime = 1,deadbody = 6 ,controlId = 100114},

	},
}

-- 特殊怪物配置用于庄园战斗相关 托管玩家或随从
-- 注意：应该尽量保证 key = deadScript
-- 注意: 所有需要配置controlID的特殊怪物、必须写清楚用途、以免使用重复cid出错
PlayerMonsterConf = {
	-- 庄园排位赛防守方人物
	[1] = {monsterId = 1,controlId = 9,deadbody = 30,IdleTime = 15,objectType = 0,deadScript = 1,aiType = 71},	
	-- 庄园掠夺防守方人物
	[2] = {monsterId = 2,deadbody = 30,IdleTime = 15,objectType = 0,deadScript = 2,aiType = 71},	
	-- 庄园掠夺防守方随从
	[3] = {monsterId = 3,deadbody = 30,IdleTime = 15,objectType = 0,deadScript = 3,aiType = 135}, 
	-- 庄园掠夺攻击方随从
	[4] = {monsterId = 3, deadbody = 30,IdleTime = 15,objectType = 0,deadScript = 4,aiType = 151},	
	-- 进入庄园随从怪物
	[5] = {monsterId = 3,moveArea = 0, deadbody = 30,IdleTime = 5,objectType = 0,deadScript = 5,aiType = 151},
	-- 庄园掠夺防守方宠物
	[6] = {monsterId = 3, deadbody = 30,IdleTime = 5,objectType = 0,deadScript = 6,aiType = 135}, 
	-- 庄园排位赛攻击方人物
	[7] = {monsterId = 1,controlId = 10,deadbody = 30,IdleTime = 15,objectType = 0,deadScript = 7,aiType = 71},
	-- 庄园排位赛攻击方随从
	[8] = {monsterId = 3,controlId = 11,deadbody = 30,IdleTime = 15,objectType = 0,deadScript = 7,aiType = 135},
	-- 庄园排位赛防守方随从
	[9] = {monsterId = 3,controlId = 12,deadbody = 30,IdleTime = 15,objectType = 0,deadScript = 1,aiType = 135},
	-- [8] 是给世界BOSS用的 这里不要用!!!!!
	
}

BuffMonsterConf ={
   -- 法师召唤
	[1] = {monsterId = 89,objectType = 0,IdleTime = 30,aiType = 769},	
   -- 火焰旋风
	[2] = {monsterId = 613,objectType = 0,IdleTime = 30,aiType = 513},	 
   -- 召唤树人
	[3] = {monsterId = 614,objectType = 0,IdleTime = 30,aiType = 1539},	
   -- 爱心护士
	[4] = {monsterId = 615,objectType = 0,IdleTime = 30,aiType = 1539},	

}


