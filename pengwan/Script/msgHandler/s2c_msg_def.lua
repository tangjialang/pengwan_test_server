--[[
file:	s2c_msg_def.lua
desc:	define all msg idx from server to client by lua
author:	chal
update:	2011-11-28
refix:	done by chal
]]--

--------------------------------------------------------------------------
--include:
local _CI_SendLuaMsg 	= CI_SendLuaMsg
local _debug 			= __debug
local tostring 			= tostring
local common 			= require('Script.common.Log')
local Log 				= common.Log

--------------------------------------------------------------------------
-- data:

local _s2c_def = {

	-- Task
	[1] = {
		[1] 	= {1,0},		-- one player's task data.
		[2] 	= {1,1},		-- npc info & npc task state(signed with '!').
		[3] 	= {1,2},		-- task info.
		[4] 	= {1,3},		-- npc click return.
		[5] 	= {1,4},		-- task accept and submit.
		[6] 	= {1,5},		-- send store info to client.
		[7] 	= {1,6},		-- 威望兑换经验面板打开
		[10] 	= {1,9},		-- 悬赏任务数据
		[11] 	= {1,10},		-- 7天奖励
		[12] 	= {1,11},		-- 悬赏快速全部完成
	},
	
	-- Story
	[2] = {
		[1] 	= {2,0}, 		-- Tell client to play a story by ID.
	},
	
	-- playerop
	[3] = {
		[1] 	= {3,0},
		[2] 	= {3,1},		-- 发送闭关累积时间 .
		[3] 	= {3,2},
		[4] 	= {3,3},
		[8] 	= {3,7},
		[9] 	= {3,8},
		[10] 	= {3,9},
		[11] 	= {3,10},		-- 官职加功勋返回信息
		[12] 	= {3,11},		-- 官职失败信息
		[13] 	= {3,12},		-- 傣禄领取
		[14]	= {3,13},		-- dayData dc/time/fun数据发送
		[15]    = {3,14},      ----投资
		[16]    = {3,17},      ----个人工资数据
		[17]    = {3,18},      ----个人工资领取出错
		[18]    = {3,19},      ----7天登录数据
		[19]    = {3,20},      ----7天登录领取出错返回
		[20]    = {3,21},      ----每日首充领奖成功
		[21]    = {3,22},      ----每日首充领奖出错返回
		[22]    = {3,23},      ----登陆存储过程信息返回
		[23]    = {3,24},		----战力比拼
		[26]    = {3,25},		----时装更新
		[27]    = {3,26},		----玩家捐献结果
		[28]    = {3,27},		----玩家捐献领奖结果
		[29]    = {3,28},		----玩家排行榜
		[30]    = {3,29},		----玩家上线全服通告
		[31]   = {3, 30},  --玩家觉醒返回
		[32]   = {3, 31},  --玩家领取觉醒装备返回
	},
	
	-- copysence
	[4] = {
		[1] 	= {4,0},		-- 副本进入条件检查	
		[2]		= {4,1},		-- 副本流程
		[3]		= {4,2},		-- 副本追踪
		[4]		= {4,3},		-- 副本奖励
		[5]		= {4,4},		-- 组队副本房间列表
		[6]		= {4,5},		-- 创建房间
		[7]		= {4,6},		-- 加入房间
		[8]		= {4,7},		-- 退出房间
		[9] 	= {4,8},		-- 过关信息
		[10] 	= {4,9},		-- 总过关星级
		[11] 	= {4,10},		-- 组队副本邀请
		[12] 	= {4,11},		-- 扫荡
		[13] 	= {4,12},		-- 五行炼狱副本世界数据
		[14]  = {4,13},		-- 玩家玄天阁数据
		[15]  = {4,14},		-- 玄天阁领奖结果
	},
	
	-- faction
	[7] = {
		[1] 	= {7,0},		--帮会出错
		[2] 	= {7,1},		--厢房升级
		[3] 	= {7,2},		--帮会捐献
		[4] 	= {7,3},		--建筑升级成功返回消息
		[5] 	= {7,4},		--神兽喂养成功返回消息
		[6] 	= {7,5},		--获取帮会技能数据
		[7] 	= {7,6},		--帮会徽标升成功返回消息
		[8] 	= {7,7},		--帮会lua保存的数据
		[10] 	= {7,9},		--获取敌对帮会
		[12] 	= {7,11},		--帮会庇护
		[13] 	= {7,12},		--帮会夺宝数据更新
		[14] 	= {7,13},		--帮会掠夺战报
		[15] 	= {7,14},		--有人申请加入帮会
		[16] 	= {7,15},		--申请加入帮会成功
		[17] 	= {7,16},		--取消申请加入帮会
		[18] 	= {7,17},		--成功加入帮会
		[19] 	= {7,18},		--成功审批申请
		[20] 	= {7,19},		--发送帮会同盟数据
		[21] 	= {7,20},		--申请帮会同盟
		[22] 	= {7,21},		--拒绝帮会同盟
		[23] 	= {7,22},		--发送机器人帮会数据
		[24]    = {7,23},		--发送帮会运镖交押金数据
		[25]    = {7,24},		--发送帮会运镖开始数据
		[26]    = {7,25},		--发送帮会运镖结束数据
		[27]    = {7,26},		--牵引镖车
		[28]    = {7,27},		--取消牵引镖车
		[29]    = {7,28},		--城主信息
	},
	
	--hero
	[9] = {
		[1] 	= {9,0},		--获取家将数据
		[2] 	= {9,1},		--家将失败信息
		[3]		= {9,2},		--家将经验更新
	},
	
	--活动类
	[12] = {
		[1] 	= {12,0},
		[4] 	= {12,3},
		[5] 	= {12,4},
		[16] 	= {12,15},
		[17] 	= {12,16},
		[18] 	= {12,17},
		[19] 	= {12,18},
		[20] 	= {12,19},
		[21] 	= {12,20},
		[22] 	= {12,21},
		[23] 	= {12,22},
		[24] 	= {12,23},
		[25] 	= {12,24},
		[28] 	= {12,27},
		[29] 	= {12,28},
		[30] 	= {12,29},
		[31] 	= {12,30},--温泉跳水分数
		[32] 	= {12,31},--挖宝pos
		[33] 	= {12,32},--挖宝结果
		[34] 	= {12,33},--错误信息
		[35] 	= {12,34},--点击出商店相关
		[36] 	= {12,35},--注册时间
		[37] 	= {12,36},--活动充值/消费排行榜
		[38] 	= {12,37},--存入成功
		[39] 	= {12,38},--领奖成功
		[40] 	= {12,39},--取出总投资元宝成功
		---春节活动
		[41]    = {12, 40}, --抽奖结果奖励相关
		[42]	= {12, 41 },  --积分领奖奖励相关
		[43]	= {12, 42},  --积分兑换奖励相关
		[44]	= {12, 43},  --活动信息
		[45]	= {12, 44},  --登陆领奖相关信息
		[46]	= {12, 45},  --完成指标领奖相关信息
		[47]	= {12, 46},  --充值领奖相关信息
		[48]	= {12, 47},  --充值相关信息
		[49]	= {12, 48},	 --领取印章返回信息
	},
	
	--achievement
	[13] = {
		[1] 	= {13,0},		-- 活跃度
		[2] 	= {13,1},		-- 活跃度错识
		[3] 	= {13,2},		-- 领取目标奖励成功
		[4] 	= {13,3},		-- 领取目标出错
	},
	
	--player
	[15] = {
		[5]		= {15,4},
		[6]		= {15,5},
		[7]		= {15,6},
		[8]		= {15,7},		-- 领取经验找回
		[9]		= {15,8},
		[11]	= {15,10},
		[12]	= {15,11},
		[13] 	= {15,12},		-- 称号Data
		[14] 	= {15,13},		-- 获得称号/移除称号
		[15] 	= {15,14},		-- 购买次数		
		[16] 	= {15,15},		-- 密友	
		[17] 	= {15,16},		-- 血包	
		[18] 	= {15,17},		-- 战斗力查看	
	},
	
	--horse
	[17] = {
		[1] 	= {17,0},		--坐骑数据
		[2] 	= {17,1},		--坐骑失败回应
		[3] 	= {17,2},		--有新的幻化坐骑解锁
		[4] 	= {17,3},		--设置幻化形象
		[5] 	= {17,4},		--坐骑属性加成
		[6] 	= {17,5},		--设置坐骑抽奖标识
		[7]		= {17,6},		--坐骑装备数据更新
		[8]		= {17,7},		--坐骑装备操作出错
	},
	
	-- Escort 运镖
	[18] = {
		[1] 	= {18,0},		
		[2] 	= {18,1},		
		[3] 	= {18,2},		
		[4] 	= {18,3},	
		[5] 	= {18,4},
		[6] 	= {18,5},
		[7] 	= {18,6},
	},
	
	--shenbing+骑兵
	[20] = {
		[1] 	= {20,0},		
		[2] 	= {20,1},		
		[3] 	= {20,2},		
		[4] 	= {20,3},	
		[5] 	= {20,4},--骑兵等级变动 
		[6] 	= {20,5},--骑兵技能变动
		[7] 	= {20,6},--法宝技能变动
		[8] 	= {20,7},--法宝器魂变动
		[9] 	= {20,8},--看骑兵
		[10] 	= {20,9},--丹药
		[11] 	= {20,10},--翅膀数据更新
		[12] 	= {20,11},--翅膀数据出错
		[13] 	= {20,12},--更新翼灵、翼魂
		[14] 	= {20,13},--其它人的翅膀数据
		[15] 	= {20,14},--女神重置
		[16] 	= {20,15},--骑兵开光
		[17] 	= {20,16},--夫妻名字显示
		--帮会神兵
		[18] = {20,17},	--已达到满级
		[19] = {20,18},	--当前阶10星,满
		[20] = {20,19},	--神兵信息下发
		[21] = {20,20},	--神兵突破成功或者失败
		--龙脉系统
		[22] = {20,21}, -- 获取玩家龙脉信息
		[23] = {20,22}, -- 龙脉升级返回信息
		--戒指
		[24] = {20, 23}, --傲视戒指返回信息
		[25] = {20, 24}, --装备戒指返回信息
	},
	
	--结婚系统
	[21] = {
		[1] 	= {21,0},		
		[2] 	= {21,1},		
		[3] 	= {21,2},		
		[4] 	= {21,3},	
		[5] 	= {21,4},
		[6] 	= {21,5},
		[7] 	= {21,6},
		[8] 	= {21,7},
		[9] 	= {21,8},
		[10] 	= {21,9},
		[11] 	= {21,10},
		[12] 	= {21,11},
		[13] 	= {21,12},
		[14] 	= {21,13},
		[15] 	= {21,14},
		[16] 	= {21,15},
		[17] 	= {21,16},
		[18] 	= {21,17},
		[19] 	= {21,18},
		-- [20] 	= {21,19},--查看戒指
	},
	
	--YY
	[22] = {
		[2] 	= {22,1},			
		[3] 	= {22,2},		
		[4] 	= {22,3},	
		[5] 	= {22,4},
		[6] 	= {22,5},
		[7] 	= {22,6},
		[8] 	= {22,7},
		[9] 	= {22,8},
		[10] 	= {22,9},
		[11] 	= {22,10},
		[12] 	= {22,11},
	},
	
	--equip
	[23] = {
		[2] 	= {23,1},			
		[3] 	= {23,2},		
		[4] 	= {23,3},	
		[5] 	= {23,4},
		[6] 	= {23,5},
		[7] 	= {23,6},
		[8] 	= {23,7},
		[9] 	= {23,8},
		[10] 	= {23,9},
		[11] 	= {23,10},
		[12] 	= {23,11},
		[13] 	= {23,12},--升星
	},
	
	--store
	[24] = {
		[1] 	= {24,0},			
		[2] 	= {24,1},		
		[3] 	= {24,2},	
		[4] 	= {24,3},	--批量购买
		[5] 	= {24,4},	--帮会商店限购
		[6] 	= {24,5},	--道具置换
		[7] 	= {24,6},	--全服限购购买成功
		[8] 	= {24,7},	--全服限购请求
	
	},
	
	--timesmgr
	[25] = {
		[1] 	= {25,0},	-- 所有次数数据
		[2] 	= {25,1},	-- 次数更新数据
		
	},
	
	--daji
	[26] = {
		[1] 	= {26,0},
		[2] 	= {26,1},
		[3] 	= {26,2},
		[4] 	= {26,3},
	},
	
	--garden
	[27] = {
		[1] 	= {27,0},	-- 菜园数据
		[2] 	= {27,1},	-- 开启田地
		[3] 	= {27,2},	-- 播种
		[4] 	= {27,3},	-- 菜园互动操作
		[5] 	= {27,4},	-- 被狗咬
		[6] 	= {27,5},	-- 菜园操作记录
		[7] 	= {27,6},	-- 摇钱树信息
		[8] 	= {27,7},	-- 幸运值
		[9] 	= {27,8},	-- 好友状态
		[10] 	= {27,9},	-- 好友状态
	},
	
	--party
	[28] = {
		[1] 	= {28,0},
		[2] 	= {28,1},	
		[3] 	= {28,2},	
		[4] 	= {28,3},	
		[5] 	= {28,4},	
		[6] 	= {28,5},	
		[7] 	= {28,6},
		[8] 	= {28,7},	
		[9] 	= {28,8},	
		[10] 	= {28,9},
		[11] 	= {28,10},
	},
	
	--lottoy
	[29] = {
		[1]		= {29,0},--操作结果
		[2]		= {29,1},--vip={}--vip抽奖目录
		[3]		= {29,2},--result={}--vip抽奖结果
		[4]		= {29,3},----传统抽奖目录
		[5]		= {29,4},--result={}--山庄排位赛抽奖结果
		[6]		= {29,5},--result={}--山庄排位赛抽奖目录
		[7]		= {29,6},--传统抽奖结果抽中物品
		[8]		= {29,7},--在线时间
		[9]		= {29,8},--开面板数据
		[10]		= {29,9},--仓库数据
		[11]		= {29,10},--领奖成功
		[12]		= {29,11},--点标签
		[13]		= {29,12},--珍宝兑换成功
		[14]		= {29,13}, --幸运转盘初始化
		[15]		= {29,14},--幸运转盘结果
		[16]		= {29,15},--无排行寻宝领奖结果
		
		[17]		= {29,16},--摇奖结果
		[18]		= {29,17},--前20名积分 玩家
		[19]		= {29,18},--摇奖自动,返回10次
		
		[20]		= {29,19},--端午节活动领奖
		
		--梦幻卡牌
		[21] = {29,20},	--获取牌型
		[22] = {29,21},	--设置模式
		[23] = {29,22}, --翻牌
		[24] = {29,23}, --自选卡牌
		[25] = {29,24}, --
		--------------------------
		[26] = {29,25}, --勇士领奖
		[27] = {29,26}, --勇士使用宝箱
		
		[28] = {29,27},--啤酒节活动领奖
		[29] = {29,28},--中秋节活动领奖
		[30] = {29,29},--国庆节活动领奖
		
		[31] = {29,30},--梦幻卡牌上线处理
		[32] = {29, 31},  --圣诞节领奖
	},
	
	--skill
	[30] = {
		[1]		= {30,0},
		[2]		= {30,1},--初始化
		[3]		= {30,2},--职业
		[4]		= {30,3},--天赋
		[5]		= {30,4},--心法修炼结果
		[6]		= {30,5},--抵抗心法
	},
	
	--装饰
	[31] = {
		[1] 	= {31,0},
		[2] 	= {31,1},	
		[3] 	= {31,2},	
		[4] 	= {31,3},	
	},
	
	--manor_rank
	[32] = {
		[1] 	= {32,0},	-- 排位列表信息
		[2] 	= {32,1},	-- 排位列表信息
		[3] 	= {32,2},	-- 排位赛战报
		[4] 	= {32,3},	-- 点击奖励通知消息
		[5] 	= {32,4},	-- 秒排位赛CD
		[6] 	= {32,5},	-- 排位赛退出
		[7] 	= {32,6},	-- 每日领奖信息
		[8] 	= {32,7},	-- 排位赛鼓舞
		[9] 	= {32,8},	-- 每两小时荣誉点奖励
	},
	
	-- 降魔录
	[33] = {
		[1]		= {33,0},--出现骰子
		[2]		= {33,1},--挑战成功
		[3]		= {33,2},--初始化
		[4]		= {33,3},
		[5]		= {33,4},
	},
	
	--vip
	[34] = {
		[1]	 	= {34,0},
		[2] 	= {34,1},
		[3] 	= {34,2},
		[4] 	= {34,3},
		[5] 	= {34,4},
	},
	
	--manor_robbery
	[35] = {		
		[1] 	= {35,0},	-- 剩余次数
		[2] 	= {35,1},	-- 庄园掠夺列表数据
		[3] 	= {35,2},	-- 进入掠夺
		[4] 	= {35,3},	-- 庄园掠夺所需详细信息
		[5] 	= {35,4},	-- 查看战斗力
		[6] 	= {35,5},	-- 战报
	},
	
	--manor_tech
	[36] = {
		[1] 	= {36,0},	-- 科技数据
		[2] 	= {36,1}, 	-- 科技升级
	},
	
	-- manor_login
	[37] = {				
		[1] 	= {37,0},	-- 登陆初始化数据
		[2] 	= {37,1},	-- 更新庄园等级、经验
		[3] 	= {37,2},	-- 更新庄园排位和掠夺引导状态值
	},
	
	-- 宠物数据
	[38] = {
		[1] 	= {38,0},	-- 宠物数据
		[2] 	= {38,1},	-- 购买宠物
		[3] 	= {38,2},	-- 幻化宠物
	},
	
	-- 点金聚灵
	[39] = {	
		[1] 	= {39,0},	-- 初始化
		[2] 	= {39,1},	-- 结果
		-----装备展示消息
		[3] = {39, 2}, 
	},
	
	--玉石副本
	[40] = {
		[1]		= {40,0},--出现骰子
		[2]		= {40,1},--骰子点数
		[3]		= {40,2},--购买buff
	},
	
	-- 脚本排行榜
	[41] = {
		[1]		= {41,0},--出现骰子		
	},
	-- 封神榜
	[42] = {
		[1]		= {42,0},--技能		
		[2]		= {42,1},--概率
		[3]		= {42,2},--洗点
		[4]		= {42,3},--装备技能
		[5]		= {42,4},--强化
	},
	-- 跨服,3v3
	[43] = {
		[1]		= {43,0},--		
		[2]		= {43,1},--
		[3]		= {43,2},--
		[4]		= {43,3},--
		[5]		= {43,4},--
		[6]		= {43,5},--
	},

	[44] = {
		[1]		= {44,0},--		
		[2]		= {44,1},--
	},
	--元神系统
	[45] = {
		[1] = {45,0},--初始化
		[2] = {45,1},--升级
		[3] = {45,2},--  一键升级
		[4] = {45,3},--挑战
		[5] = {45,4},-- 一键扫荡
		[6] = {45,5},--扫荡
		[7] = {45,6},--次数购买
		[8] = {45,7},
		[9] = {45,8}, -- 元神重置
		[10]={45,9}, --升级,炼神
		[11]={45,10},--一键升级，炼神
		-----
		[12] = {45,11},	--元神分身升级
		[13] = {45,12},	--元神分身
		[14] = {45,13},	--分身攻击
	},
	
	[46] = {--跨服组队副本
		[1]		= {46,0},--列表
		[2]		= {46,1},--进入
		[3]		= {46,2},--离开
		[4]		= {46,3},--玩家状态
		[5]		= {46,4},--开始副本
	},
	[47] = {--跨服1v1
		[1]		= {47,0},
		[2]		= {47,1},
		[3]		= {47,2},
		[4]		= {47,3},
		[5]		= {47,4},
		[6]		= {47,5},
		[7]		= {47,6},
		[8]		= {47,7},
		[9]		= {47,8},
		[10]	= {47,9},
		[11]	= {47,10},

	},
	[48] = {--夫妻挑战副本
		[1]		= {48,0}, --
		[2]		= {48,1}, 
		[3]		= {48,2}, 
		[4]		= {48,3}, 	--
		[5] 	= {48,4},	--quenching
		[6]		= {48,5},	--Buy Skill
	},
	[49] =
	{
		[1] = {49,0}, --世界杯押注返回
		[2] = {49,1}, --世界杯领奖返回
		[3] = {49,2}, --世界杯赛程表
		[4] = {49,3}, --世界杯押注查询	
	},
	[50]={--元神武装
		[1] = {50,0}, --升级
		[2] = {50,1}, --查看属性
		
	},
    [51] = {--经验神树
        [1] = {51,0},  --播种
        [2] = {51,1},  --果实开启
        [3] = {51,2},  --查看
        [4] = {51,3},  --刷新
        [5] = {51,4},  --摘取
        [6] = {51,5},  --偷取
        [7] = {51,6}, -- 偷取成功与否 
		[8] = {51,7}, --
		[9] = {51,8}, -- 

    },
	[52] = { -- 珍珠阁
		[1] = {52,0},   --物品首次刷新
		[2] = {52,1},   --单个物品折扣刷新
		[3] = {52,2},   --道具购买
		[4] = {52,3},  -- 物品刷新
	},
    [53] = { -- 本命法宝
        [1] = {53,0},   --升星
        [2] = {53,1},   --镶嵌魂石
        [3] = {53,2},   --魂石卸载
        [4] = {53,3},   --面板初始化
        [5] = {53,4},   --法宝初始化
		[6] = {53,5},	--一骑当千同步副本星数
		[7] = {53,6},	--一骑当千领取盒子
		[8] = {53,7},	--一骑当千扫荡
		[9] = {53,8},	--一骑当千购买次数
		[10] = {53,9},	----一骑当千购买清除扫荡cd
        [11] = {53,10},

    },
	--[[
		151 ~ 254 预留给跨服消息
	]]--
	[151] = {
		[1] 	= {151,1},
	},
	--版本控制
	[255] = {
		[3] 	= {255,2},
	},
}
--------------------------------------------------------------------------
-- inner function:
local function _SendLuaMsg(sid,args,ityped,a1,a2,a3)
	-- look(sid)
	-- look(ityped)
	-- if ityped == 9 or ityped == 10 then
		-- local binit = CI_GetPlayerData(0,2,sid)
		-- look(binit)
		-- if binit ~= 1 then
			-- look('_SendLuaMsg player not init')
			-- return
		-- end
	-- end

	local ret = _CI_SendLuaMsg( sid, args, ityped, a1, a2, a3 )
	if ret == nil or ret <= 0 then
		if _debug then
			 local msg = 'SendLuaMsg erro:{'..tostring(args.ids[1])..','..tostring(args.ids[2])..'} ,ret = '..tostring(ret)..',a1='..tostring(sid)..',a2='..tostring(ityped)..',f='..tostring(args.f)
			 Log("SendLuaMsg.txt",msg)
			 Log("SendLuaMsg.txt",debug.traceback())
		end
	else
		if _debug and ret >= 1000 then
			local msg = 'msg:{'..tostring(args.ids[1])..','..tostring(args.ids[2])..'},Len='..tostring(ret)
			Log("SendLuaMsg.txt",msg)
		end
	end	
	return ret
end

--------------------------------------------------------------------------
-- interface:
SendLuaMsg 		= _SendLuaMsg
msgh_s2c_def	= _s2c_def



--------------------------------------------------------------------------
-- old

-- Task
--Task_Data	= msgh_s2c_def[1][1] 	-- one player's task data.
--NPC_Info  	= msgh_s2c_def[1][2]		-- npc info & npc task state(signed with '!').
--Task_Info 	= msgh_s2c_def[1][3]		-- task info.
--NPC_Click 	= msgh_s2c_def[1][4]		-- npc click return.
--Task_Proc	= msgh_s2c_def[1][5] 	-- task accept and submit.
--Store_Info	= msgh_s2c_def[1][6] 	-- send store info to client.
--XValue_Init  = msgh_s2c_def[1][7]		--威望兑换经验面板打开
--EveryDay_Actibe_msg = msgh_s2c_def[1][8]	--活跃度
--EveryDay_Error = msgh_s2c_def[1][9]	--活跃度错识
--Task_RingData = msgh_s2c_def[1][10]		-- 悬赏任务数据
--Day_Login = msgh_s2c_def[1][11]		-- 每日签到返回

-- Story
--Play_Story 	= msgh_s2c_def[2][1] 		-- Tell client to play a story by ID.
-- playerop
--Dead_UI		= msgh_s2c_def[3][1]
--BG_Time	= msgh_s2c_def[3][2]		-- 发送闭关累积时间 .
--Tran_Wait	= msgh_s2c_def[3][3]
--Send_Wlevel	= msgh_s2c_def[3][4] 	{3,3}
--AutoFightEnd = msgh_s2c_def[3][6]	{3,5}    --挂机时间结束
--AutoFightBegin = msgh_s2c_def[3][7]	{3,6}    --挂机时间开始计时  fTime = 剩余挂机时间（秒）
--Script_Init = msgh_s2c_def[3][8]	{3,7}
--ML_ScoreList = msgh_s2c_def[3][9]	{3,8}
--ML_Award = msgh_s2c_def[3][10]		{3,9}
--Tran_Complete = msgh_s2c_def[3][11]	{3,10}

-- copysence
-- cs_check	= {4,0}		-- 副本进入条件检查	
-- cs_progress	= {4,1}		-- 副本流程
-- cs_tips		= {4,2}		-- 副本追踪
-- cs_awards	= {4,3}		-- 副本奖励
-- cs_roomlist	= {4,4}		-- 组队副本房间列表
-- cs_ctroom	= {4,5}		-- 创建房间
-- cs_joinroom	= {4,6}		-- 加入房间
-- cs_quitroom	= {4,7}		-- 退出房间
-- cs_passinfo = {4,8}		-- 过关信息
-- cs_allstar = {4,9}		-- 总过关星级
-- cs_invite = {4,10}		-- 组队副本邀请

-- equip
--Equip_Meta	= {5,0}		-- equip metarial.
--Equip_EnInfo= {5,1}		-- Send client equip enhance info.
--Equip_Update= {5,2}		-- equip ex att update.
--Item_Mix	= {5,3}		-- item mixs.
--Equip_Slots	= {5,4}		-- equip slots info.
-- camp
--[[
Camp_Data	= {6,0} --阵营数据
Camp_Fail	= {6,1} --阵营失败信息
Camp_Salary = {6,2} --阵营傣禄领取
Camp_Pos	= {6,3} --官职加功勋返回信息
]]--
--[[
Camp_Info	= {6,0}
Camp_Data	= {6,1}
Camp_Contri	= {6,2}
City_DataConf= {6,3}
CF_WaitEnter= {6,4}
Camp_Set	= {6,5}
City_List	= {6,6}
CF_CDNotice	= {6,7}
Camp_Notice	= {6,8}
Camp_GetPay = {6,9}
Camp_SetRand= {6,10}
Camp_Donate= {6,11}
Camp_BScore={6,12}
Camp_BAword={6,13}
Camp_LevelUp={6,14}
CF_EnterCF	= {6,15}
CF_AddCFSorce= {6,16}
CF_PlayEffect= {6,17}
CF_ABuff= {6,18}
Camp_Rank= {6,19}
Camp_LeaderInfo= {6,20}
Camp_CanGetPay={6,21}
Camp_GetwCamp={6,22}
Camp_SendSocre={6,23}
oldCamp_BScore={6,24}
]]--
-- Faction
--[[
Faction_Fail = {7,0} --帮会出错
Faction_UpdateSizelevel={7,1} --厢房升级
Faction_Donate={7,2} --帮会捐献
Faction_Build={7,3} --建筑升级成功返回消息
Faction_Soul={7,4} --神兽喂养成功返回消息
Faction_Skill={7,5} --获取帮会技能数据
Faction_Sign={7,6} --帮会徽标升成功返回消息
Faction_Data={7,7} --帮会lua保存的数据
--Faction_SetEnemy={7,8} --帮会添加敌对帮会成功
Faction_EnemyList={7,9} --获取敌对帮会
Faction_Delete={7,10} --解散帮会
Faction_Buff={7,11} --帮会庇护
Faction_Treasure={7,12} --帮会夺宝数据更新
Faction_ClearCD={7,13} --帮会清CD
]]--
--[[
Faction_LvUp= {7,0}		-- faction level up.
Faction_GetCampMoney= {7,1}		-- faction level up.
Faction_DonateItem= {7,2}		-- faction level up.
Faction_DonateOK= {7,3}
Faction_GetList={7,4}
Faction_GetLastWin={7,5}
Faction_GetFactionVal={7,6}
Faction_GetADWarRequestList={7,7}
Faction_ADWarOver={7,8}
Faction_UpdateSizelevel={7,9}
Faction_UpdateScore={7,10} --更新帮会积分
]]--

-- Item
--Item_Use	= {8,0}		-- Item use result by operate.
--VIPStoreMessage = {8,1}     --获取神秘商店信息
--Book_CallBack = {8,2}     --获取神秘商店信息
--Luck_Init = {8,3} --初始化抽奖
--Luck_Award = {8,4} --领奖
--Luck_Fail = {8,5} --抽奖出错返回
--ItemStoreInit = {8,5} --兑换券商品初始化
--ItemStoreBuy = {8,6} --兑换成功
--Item_GCard = {8,7}

-- Hero
--[[
Hero_Data	= {9,0}		-- 获取武将数据
Hero_Fail	= {9,1}		-- 武将失败信息
]]--
-- Venation
--[[
Venation_Data	= {11,0}		-- get venation data
Venation_FailInfo	= {11,1}	-- get venation fail info
]]--

-- active
--Boss_Info = msgh_s2c_def[12][1]{12,0}
--BMap_Info = {12,1}
--BMap_Find = {12,2}
--ActiveConf_InitIDS = msgh_s2c_def[12][4]{12,3}
--AcitveIcon_Info = msgh_s2c_def[12][5]{12,4}
--AI_NoticeBAtc = {12,5}
--AI_EnterPVP = {12,6}
--Active_Record = {12,7}
--Do_RecordAward = {12,8}
--ywhy_leftitem = {12,9}
--ywhy_award = {12,10}
--ywhy_score = {12,11}
--ywhy_data = {12,12}
--ywhy_doAward = {12,13}
---wq_roominfo = {12,14}
--wq_iteminfo = msgh_s2c_def[12][16]{12,15}
--LT_Match = msgh_s2c_def[12][17]{12,16}
--LT_pData = msgh_s2c_def[12][18]{12,17}
--LT_viewlist = msgh_s2c_def[12][19]{12,18}
--lt_enterView = msgh_s2c_def[12][20]{12,19}
--LT_viewstate = msgh_s2c_def[12][21]{12,20}
--LT_Scorelist = msgh_s2c_def[12][22]{12,21}
--LT_Rpt = msgh_s2c_def[12][23]{12,22}
--LT_NoticeEnd = msgh_s2c_def[12][24]{12,23}
--LT_RegComp = msgh_s2c_def[12][25]{12,24}
--LT_GoldVol = msgh_s2c_def[12][26]{12,25}
--MoneyTree_OPEN = {12,26}
--FaceChange=msgh_s2c_def[12][28]{12,27}
--Fish_begins=msgh_s2c_def[12][29]{12,28}

-- achievement
--[[
Points_Info = {13,0}
Object_GetLog = {13,1}
]]--
-- getcode
--Player_Code = {15,0}
--Player_BindCode = {15,1}
--Player_BindedCode = {15,2}
--Player_GetGoodsForCard = {15,3}
--Player_FriendLuck = msgh_s2c_def[15][5]{15,4}		--好友祝福
--Player_SendFlower = msgh_s2c_def[15][6]{15,5}		--送花
--Player_OutExpInfo = msgh_s2c_def[15][7]{15,6}
--Player_GiveOutExp = msgh_s2c_def[15][8]{15,7}
--Mail_GiveItem = msgh_s2c_def[15][9]{15,8}
--Player_DexpNotice = msgh_s2c_def[15][10]{15,9}
--Player_openbag = msgh_s2c_def[15][11]{15,10}
--Player_Spk = msgh_s2c_def[15][12]{15,11}			-- 小喇叭
-- herocard
-- HeroCard_process = {16,0}
-- HeroCard_Info = {16,1}
-- HeroCard_Active = {16,2}
-- HeroCard_Get = {16,3}

-- horse
--[[
Horse_Data = {17,0} --坐骑数据
Horse_Fail = {17,1} --坐骑失败回应
Horse_NewChane = {17,2} --有新的幻化坐骑解锁
Horse_SetStyle = {17,3} --设置幻化形象
Horse_Att = {17,4} --坐骑属性加成
]]--

-- -- Escort 运镖
-- Escort_Get = {18,0} --返回当前运镖类型
-- Escort_Status = {18,1}
-- Escort_Finish = {18,2}
-- Escort_Kill = {18,3}


-- YZ 英雄远征
-- YZ_UpdateItem = {19,0}
-- YZ_PageItem = {19,1}
-- YZ_AwardStore = {19,2}
-- YZ_DoAward = {19,3}

-- -- ShenBing 神兵系统
-- BTerror = {20,0}--error=0
-- --BT_Update = {20,1}--初始化战斗法宝数据
-- up_btdatda={20,2}--更新强化数据
-- BT_see={20,3}--查看


--Marry 系统
-- MarryConfirm = {21,0}   --求婚请求
-- MarryResult = {21,1}    --求婚结果
-- MarryReserve = {21,2}	-- 预约婚姻结果
-- WeddingNotice = {21,3}       --婚宴5分钟后开始
-- ReserveList = {21,4}         --预约列表
-- MarryData = {21,5}			 -- 结婚数据
-- InteractQuest = {21,6}         --请求跳舞或拥抱
-- InteractComfirm = {21,7}   --请求拥抱或跳舞确认
-- EatFeast = {21,8}			-- 吃婚宴结果
-- feastdata = {21,9}
-- divorceVerify = {21,10}         --发送离婚请求
-- DivorceRes = {21,11}        	--离婚结果
-- RingData = {21,12}
-- ForceVerify = {21,13}			-- 离婚确认
-- MarrySkill = {21,14}			-- 使用婚姻技能
-- MSkillCD = {21,15}
-- MarryBegin = {21,16}
-- RingKey = {21,17}

-- --YY 阴阳系统
-- yy_changeskill={22,1}--{22,6}--[[融合后两个技能变化   a_skill={a_site=12，skilla={技能id，经验exp分子，锁定lock}}，b_skill={b_site=15，skillb={技能id，经验exp分子,锁定lock}}]]--
-- yy_changeskill_all={22,2}--整体技能变化_一键融合() 	skilldata={为整个包裹表}
-- yy_getskill={22,3}--{22,9}--get_skill={site=12，skill={技能id，经验exp分子,锁定lock}，,score=55，five=2}；five为五行
-- --yy_start={22,4}--{22,9}--初始化数据
-- yy_lvups={22,5}--请求一键融合返回值，skill={}，exp_=500
-- yy_succskill={22,6}--启灵失败提示
-- yy_changeyy={22,7}--卖出技能成功，succ=1
-- yy_onekeysale={22,8}--一键出售
-- yy_skillbox={22,9}--一键融合仓库技能，skilldata={为整个仓库表}
-- yy_pakage={22,10}--开启包裹
-- --装备系统
-- equip_up={23,1}--0/1 强化成功失败
-- equip_open={23,2}--0/1 打孔成功失败
-- equip_in={23,3}--0/1 镶嵌成功失败
-- equip_out={23,4}--0/1 拆除成功失败
-- equip_resove={23,5}--0/1 分解成功失败
-- equip_ch={23,6}--0/1 转换成功失败
-- Equip_xlres={23,7}-- 洗练得到属性
-- equip_xlend={23,8}--0/1 洗炼保存后结果
-- equip_comi={23,9}--0/1 洗炼保存后结果
-- equip_Purify1={23,10}--醇化
-- equip_addlight={23,11}--附灵
-- --商店系统
-- storebuy={24,0}--购买
-- storeend={24,1}--结果
-- storenum={24,2}--购买剩余

-- 次数管理器
-- TMS_Data = {25,0}	-- 所有次数数据
-- TMS_Sync = {25,1}	-- 次数更新数据
-- Refresh_time={25,2} -- 各小功能次数重置

-- --妲己系统
-- djgame={26,0}--骰子游戏结果
-- djresult={26,1}--操作错误结果

-- 果园系统
-- GD_Data = {27,0}	-- 菜园数据
-- GD_Open = {27,1}	-- 开启田地
-- GD_Sow = {27,2}		-- 播种
-- GD_Opt = {27,3}		-- 菜园互动操作
-- GD_Bite = {27,4}	-- 被狗咬
-- GD_Record = {27,5}	-- 菜园操作记录
-- GD_mTree = {27,6}	-- 摇钱树信息
-- GD_Luck = {27,7}	-- 幸运值
-- GD_fList = {27,8}	-- 好友状态

-- STARTParty={28,0}--庄园宴会操作错误结果
-- BeginParty={28,1}--宴会开启
-- InviteParty={28,2}--邀请参加宴会
-- ToastParty1={28,3}--敬酒本人消息
-- ToastParty2={28,4}--被敬酒人消息
-- ZYparty_info={28,5}--宴会信息
-- ZYpeople={28,6}--【庄园里面的人--{人，帮会}】
-- ZYwho={28,7}--【进入哪个庄园】
-- ZYExpel={28,8}--被驱逐了
-- Join_Party={28,9}--参加宴会了
-- ZY_exit={28,10}--退出山庄
--抽奖系统
-- LOT_result={29,0}--操作结果
-- LOT_list={29,1}--vip={}--vip抽奖目录
-- LOT_get={29,2}--result={}--vip抽奖结果
-- LOT_list2={29,3}----传统抽奖目录
-- LOT_ZYget={29,4}--result={}--山庄排位赛抽奖结果
-- LOT_ZYlist={29,5}--result={}--山庄排位赛抽奖目录
-- LOT_commonget={29,6}--传统抽奖结果抽中物品
--技能系统相关
-- Skill_res={30,0}
-- Skill_start={30,1}--初始化
-- Skill_zhiye={30,2}--职业
-- Skill_tianfu={30,3}--天赋
--山庄装饰
-- ZS_start={31,0}
-- ZS_set={31,1}
-- ZS_buy={31,2}
-- ZS_cancel={31,3}

-- 庄园排位
-- MRK_Data = {32,0}	-- 排位列表信息
-- MRK_Enter = {32,1}	-- 排位列表信息
-- MRK_Report = {32,2}	-- 排位赛战报
-- MRK_Do = {32,3}		-- 点击奖励通知消息
-- MRK_ClrCD = {32,4}	-- 秒排位赛CD
-- MRK_Exit = {32,5}	-- 排位赛退出

-- 降魔录
-- XMLfb_arise={33,0}--出现骰子
-- XMLfb_SUCC={33,1}--挑战成功
-- XMLfb_start={33,2}--初始化
-- XML_Exit={33,3}
-- VIP
-- VIP_Data = {34,0}
-- VIP_Get = {34,1}

-- 庄园掠夺
-- MRB_Times = {35,0}	-- 剩余次数
-- MRB_Data = {35,1}	-- 庄园掠夺列表数据
-- MRB_Enter = {35,2}	-- 进入掠夺
-- MRB_Detl = {35,3}	-- 庄园掠夺所需详细信息
-- MRB_Show = {35,4}	-- 查看战斗力
-- MRB_Rept = {35,5} 	-- 战报

-- 庄园科技
-- MAT_Data = {36,0}	-- 科技数据
-- MAT_UpLv = {36,1} 	-- 科技升级

-- 庄园登陆发送数据
-- MRD_Init = {37,0}	-- 登陆初始化数据
-- MRD_Exps = {37,1}	-- 更新庄园等级、经验
-- MRD_SetF = {37,2}	-- 更新庄园排位和掠夺引导状态值

-- 宠物数据
-- Pet_Data = {38,0}	-- 宠物数据
-- Pet_Buy = {38,1}	-- 购买宠物
-- Pet_Set = {38,2}	-- 幻化宠物

-- 点金聚灵
-- Touch_begin = {39,0}	-- 初始化
-- Touch_res = {39,1}	-- 结果

--玉石副本
-- ZXfb_arise={40,0}--出现骰子
-- ZX_refresh={40,1}--骰子点数
-- ZXbuy_buff={40,2}--购买buff
-- tips
-- version
--update_ver 	= msgh_s2c_def[255][1]{255,0}	-- notice version update.
--time_ver 	= msgh_s2c_def[255][3]{255,2}  --更新后版本变化，前台面板提示

