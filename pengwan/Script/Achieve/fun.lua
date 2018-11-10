--[[
成就、活跃、目标
author:	xiao.y
update:	2013-7-8
]]--
--------------------------------------------------------------------------
--include:
local __G = _G
local pairs = pairs
local look = look
local EveryDay_Actibe_msg = msgh_s2c_def[13][1]
local SendLuaMsg = SendLuaMsg
local isFullNum,GiveGoods,GiveGoodsBatch = isFullNum,GiveGoods,GiveGoodsBatch
local math_floor = math.floor
local SetTaskMask = SetTaskMask
local GetTaskMask = GetTaskMask
local type = type
local CI_GetPlayerData = CI_GetPlayerData
local DGiveP = DGiveP
local RPC = RPC
local TipCenter = TipCenter
--------------------------------------------------------------------------
--module:
module(...)

--------------------------------------------------------------------------
--活跃配置
local FunConf = {
	active = {
	[1] = { --index=前台显示排序, val 加的活跃值 info 活跃
		[28] = {index=1,val = 5,times = 1, info = "<font color='#fff3ca'>今日签到</font><font color='#feff97'>·奖品</font>　　　　<font color='#00ff2a'><a href='event:day.DDayPanel 0'><u>签到</u></a></font>",tip = "每日签到，可以获得。"},		
		[23] = {index=2,val = 5 ,times = 1, info = "<font color='#fff3ca'>帮会抽奖</font><font color='#feff97'>·奖品</font>　　　　<font color='#00ff2a'><a href='event:faction.DFactionPanel 0'><u>抽奖</u></font>",tip = "帮会抽奖，消耗少量帮贡，概率获得珍贵道具."},
		[35] = {index=3,val = 5 ,times = 1, info = "<font color='#fff3ca'>帮会夺宝</font><font color='#feff97'>·奖品</font>　　　　<font color='#00ff2a'><a href='event:faction.DFactionPanel 0'><u>夺宝</u></font>",tip = "帮会夺宝，全帮参与，看谁的骰子数最大."},		
		[43] = {index=4,val = 5,times = 1, info = "<font color='#fff3ca'>铜钱副本</font><font color='#ffdb5d'>·铜钱</font>　　　　<font color='#00ff2a'><a href='event:move 1 56 66 59'><u>前往</u></a></font><font color='#f6ff00'><a href='event:trans move 1 56 66 59'>{传}</a></font>",tip = "铜钱副本中，每波打完怪都会出现一个宝箱，装满了铜钱。"},
		[18] = {index=5,val = 5,times = 1, info = "<font color='#fff3ca'>点石成金</font><font color='#ffdb5d'>·铜钱</font>　　　　<font color='#00ff2a'><a href='event:active.DAddMoney'><u>点金</u></a></font>",tip = "看看人品吧，出现暴击，立刻赚翻。"},
		
		
		[21] = {index=9,val = 5,times = 1, info = "<font color='#fff3ca'>坐骑升阶</font><font color='#ff6f20'>·战斗力</font>　　　<font color='#00ff2a'><a href='event:horse.DHorsePanel 0'><u>进化</u></a></font>",tip = "坐骑升阶可以快速提高战力，并且每日有1次免费次数。"},		
		[6]  = {index=10,val = 5,times = 5, info = "<font color='#fff3ca'>悬赏任务</font><font color='#00ff84'>·经验</font>　　　　<font color='#00ff2a'><a href='event:move 1 70 62 50'><u>前往</u></a></font><font color='#f6ff00'><a href='event:trans move 1 70 62 50'>{传}</a></font>",tip = "在悬赏牌处可以接受悬赏任务。"},
		[25] = {index=11,val = 5,times = 1, info = "<font color='#fff3ca'>护送美人</font><font color='#00ff84'>·经验</font>　　　　<font color='#00ff2a'><a href='event:move 1 85 77 53'><u>前往</u></a></font><font color='#f6ff00'><a href='event:trans move 1 85 77 53'>{传}</a></font>",tip = "活动时间完成护送会获得更多收益。"},
		
		
		[11] = {index=14,val = 5,times = 3, info = "<font color='#fff3ca'>庄主排位</font><font color='#90ff00'>·声望</font><font color='#feff97'>奖品</font>　　<font color='#00ff2a'><a href='event:home.DQualifyingPanel'><u>挑战</u></a></font>",tip = "排位越高，每日结算的奖励越高。"},
		
		[45]  = {index=16,val = 5,times = 1, info = "<font color='#fff3ca'>经验副本<font color='#00ff84'>·经验</font>　 　 　<font color='#00ff2a'><a href='event:move 1 46 86 61'><u>前往</u></a></font><font color='#f6ff00'><a href='event:trans move 1 46 86 61'>{传}</a></font>",tip = "经验副本是获得每日获得经验的重要途径之一。"},
		[2]  = {index=17,val = 5,times = 2, info = "<font color='#fff3ca'>组队副本</font><font color='#ff00f6'>·装备</font>　　　　<font color='#00ff2a'><a href='event:move 1 65 106 52'><u>前往</u></a></font><font color='#f6ff00'><a href='event:trans move 1 65 106 52'>{传}</a></font>",tip = "组队副本不但产出紫色装备碎片，还产出一些非绑定的可交易赚钱的材料。"},		
		[3]  = {index=18,val = 5,times = 1, info = "<font color='#fff3ca'>宝石副本</font><font color='#00fcff'>·宝石</font>　　　　<font color='#00ff2a'><a href='event:move 1 62 63 51'><u>前往</u></a></font><font color='#f6ff00'><a href='event:trans move 1 62 63 51'>{传}</a></font>",tip = "每打完一波怪，都会获得一定数量的宝石，每日不可错过。"},		
		[66]  = {index=19,level = 44,val = 5,times = 1, info = "<font color='#fff3ca'>历练副本</font><font color='#feff97'>·历练值</font>　　　<font color='#00ff2a'><a href='event:move 1 47 94 71'><u>前往</u></a></font><font color='#f6ff00'><a href='event:trans move 1 47 94 71'>{传}</a></font>",tip = "历练值可以用来学习修神诀，提升战斗力。"},		
		[71]  = {index=20,level = 46,val = 5,times = 1, info = "<font color='#fff3ca'>升星副本</font><font color='#feff97'>·奖品</font> 　 　　<font color='#00ff2a'><a href='event:move 1 65 64 73'><u>前往</u></a></font><font color='#f6ff00'><a href='event:trans move 1 65 64 73'>{传}</a></font>",tip = "在空间裂缝中击杀域外天魔，可以获得星辰碎片，提升装备属性。"},		
		[67]  = {index=20,level = 51,val = 5,times = 1, info = "<font color='#fff3ca'>坐骑副本</font><font color='#feff97'>·奖品</font>  　　　<font color='#00ff2a'><a href='event:move 1 87 85 72'><u>前往</u></a></font><font color='#f6ff00'><a href='event:trans move 1 87 85 72'>{传}</a></font>",tip = "获取妖兽身上的材料，用于强化坐骑装备，战力越高，怪物掉落的材料数量越多。"},		
		[33] = {index=21,val = 5,times = 1, info = "<font color='#fff3ca'>守护之灵</font><font color='#ff6f20'>·战斗力</font>　　　<font color='#00ff2a'><a href='event:magic.DAmuletMagicPanel'><u>通灵</u></a></font>",tip = "守护之灵可以获得守护技能，提高战力。"},		
		
		[37] = {index=22,val = 5,times = 1, info = "<font color='#fff3ca'>捕鱼达人</font><font color='#feff97'>·奖品</font>　　　　<font color='#00ff2a'><a href='event:day.DDayPanel 4'><u>查看</u></a></font>",tip = "参加“捕鱼达人”活动，领取任意一个捕鱼宝箱都可完成，捕鱼是有技巧的哦。"},
		[36] = {index=23,val = 10,times = 1, info = "<font color='#fff3ca'>曲水流觞</font><font color='#00ff84'>·经验</font>　　　　<font color='#00ff2a'><a href='event:day.DDayPanel 4'><u>查看</u></a></font>",tip = "参加“曲水流觞”都可以完成，轻轻松松拿经验。"},
		[51] = {index=24,val = 10,times = 1, info = "<font color='#fff3ca'>星跳瑶池</font><font color='#00ff84'>·经验</font>　　　　<font color='#00ff2a'><a href='event:day.DDayPanel 4'><u>查看</u></a></font>",tip = "参加“星跳瑶池”都可以完成，跳水好玩又刺激。"},		
		[38] = {index=25,val = 10,times = 1, info = "<font color='#fff3ca'>战场活动</font><font color='#feff97'>·奖品</font>　　　　<font color='#00ff2a'><a href='event:day.DDayPanel 4'><u>查看</u></a></font>",tip = "参加“三界夺宝”，“帮会战”或“王城争霸”活动都可以完成。"},		
		--[39] = {index=25,val = 10,times = 1,info = "<font color='#fff3ca'>竞技场</font><font color='#feff97'>·奖品</font>　　　　　<font color='#00ff2a'><a href='event:day.DDayPanel 4'><u>查看</u></a></font>",tip = "竞技场的每日前10场无论胜负都有丰厚奖励，一定要参加哦。"},
		[64] = {index=26,val = 10,times = 5,info = "<font color='#fff3ca'>天降宝箱</font><font color='#00ff84'>·经验</font>　　　　<font color='#00ff2a'><a href='event:day.DDayPanel 4'><u>查看</u></a></font>",tip = "天降宝箱，经验，铜钱，灵气，元宝，只要眼疾手快，奖励多多！"},
		},
	[3] = { --推荐休闲玩法			

			[1001] = {index=26,level = 43, info = "<font color='#fff3ca'>摇钱树</font><font color='#ffdb5d'>·铜钱</font>　　　　　<font color='#00ff2a'><a href='event:house'><u>回家</u></a></font>",tip = "在庄园中收获一次摇钱树。"},
			[1002] = {index=27,info = "<font color='#fff3ca'>女仆互动</font><font color='#ff6f20'>·战斗力</font>　　　<font color='#00ff2a'><a href='event:house'><u>回家</u></a></font>",tip = "与女仆合欢可以增加战斗力，提高亲密度可以获得额外加成。"},		
			[1003] = {index=28,level = 43, info = "<font color='#fff3ca'>掠夺庄园</font><font color='#ff9c00'>·战功</font>　　　　<font color='#00ff2a'><a href='event:home.DHomePlunderPanel'><u>掠夺</u></a></font>",tip = "掠夺名字颜色越高的玩家收益越高，如果是敌对帮会玩家，还可额外获得帮贡。"},		
			[1004] = {index=29,info = "<font color='#fff3ca'>果园收获</font><font color='#ffdb5d'>·铜钱</font><font color='#ca3cff'>灵气</font>　　<font color='#00ff2a'><a href='event:garden.DGardenPanel'><u>收获</u></a></font>",tip = "幸运值足够高的果树有概率长出变异果，可以获得意外惊喜。"},
			[1005] = {index=30,level = 40, info = "<font color='#fff3ca'>沙滩钓鱼</font><font color='#feff97'>·奖品</font>　　　　<font color='#00ff2a'><a href='event:move 1 47 77 54'><u>前往</u></a></font><font color='#f6ff00'><a href='event:trans move 1 47 77 54'>{传}</a></font>",tip = "通过西岐城的NPC，可以传送去沙滩钓鱼。"},					
			[1006] = {index=31,level = 40, info = "<font color='#fff3ca'>举办宴会</font><font color='#00ff84'>·经验</font>　　　　<font color='#00ff2a'><a href='event:house'><u>回家</u></a></font>",tip = "宴会需要的海鲜食材，可以通过钓鱼获得。"},		
			[1007] = {index=32,level = 40, info = "<font color='#fff3ca'>击杀精英</font><font color='#feff97'>·奖品</font>　　　　<font color='#00ff2a'><a href='event:move 1 3 99'><u>前往</u></a></font><font color='#f6ff00'><a href='event:trans move 1 3 99'>{传}</a></font>",tip = "挂机秘境地图中，每层在每小时的半点会刷新两只精英怪。击杀可以获得炼骨丹，彩虹石等付费道具。"},		
		},		
	[2] = { --奖励
			[1] = {val = 20 , item = {{638,10},{630,3}}},
			[2] = {val = 40 , item = {{51,1},{668,2},{664,2}}},
			[3] = {val = 80 , item = {{747,1},{601,10},{603,10},{1283,3}}},
			[4] = {val = 100 , item = {{625,1},{636,5},{671,1},{615,1}}},
		},
	},
	object = { --目标
		[1] = { level = 30,item = {{640,10},{601,1},{603,1}},-- level 开放等级 item 全部达成可领奖励(道具ID，个数)
			[1] = {pos=0,index = 5,title = '进行一次帮会捐献',content = "捐献帮贡牌或铜钱可获得帮贡。帮会日常任务会奖励帮贡牌。\n                                                                   <font color='#00ff2a'><a href='event:faction.DFactionPanel 0'><u>帮会捐献</u></a></font>", item = {{640,3}}}, -- pos 目标位（字节位*10+字节中的第几位） item 领取的奖励
			--[2] = {pos=1,index = 6,title = '任意帮会技能学习到3级',content = "首先要升级帮会的技能书院，才能学习更高级的帮会技能。\n\n                                                                <font color='#00ff2a'><a href='event:faction.DFactionPanel 0'><u>学习技能</u></a></font>", item = {{640,3}}},
			[2] = {pos=1,index = 6,title = '成为VIP',content = "成为VIP后，不但可以免费传送，而且可以免费领取酷炫骑兵，立刻大幅提升战斗力。\n                                                                <font color='#00ff2a'><a href='event:vip.DVipPanel'><u>成为VIP</u></a></font>", item = {{640,10}}},
			[3] = {pos=2,index = 3,title = '将任意装备强化到10级',content = "强化成功率不足的时候，记得放入幸运石。\n                                                                    <font color='#00ff2a'><a href='event:equip.DEquipPanel 0'><u>装备强化</u></a></font>", item = {{640,3}}},
			--[4] = {pos=3,index = 4,title = '将任意装备洗练出1条橙色附加属性',content = "洗练石可以通过分解无用的装备来获得，挂机可以概率掉落装备。\n \n                                                                  <font color='#00ff2a'><a href='event:equip.DEquipPanel 2'><u>装备洗练</u></a></font>", item = {{640,3}}},
			[4] = {pos=3,index = 4,title = '将任意装备洗练1次',content = "洗练石可以通过分解无用的装备来获得，挂机可以概率掉落装备。\n                                                                   <font color='#00ff2a'><a href='event:equip.DEquipPanel 2'><u>装备洗练</u></a></font>", item = {{640,3}}},
			--[5] = {pos=4,index = 6,title = '将坐骑进化为“汗血宝马”',content = "坐骑进阶丹可通过活动获得，也可以通过讨伐任务获得，还可以用绑定元宝购买。\n\n                                                                  <font color='#00ff2a'><a href='event:horse.DHorsePanel 0'><u>坐骑培养</u></a></font>", item = {{640,3}}},
			[5] = {pos=4,index = 1,title = '与任意女仆互动1次',content = "与女仆互动，可以增加战力，提高女仆亲密度，更可以获得战力额外加成。\n                                                                 <font color='#00ff2a'><a href='event:interact.DInteractStagePanel'><u>女仆互动</u></a></font>", item = {{640,3}}},			
			[6] = {pos=5,index = 2,title = '将任意家将修行到10阶',content = "灵气可通过果园种植获得，也可以通过庄主排位赛结算奖励获得。\n                                                                  <font color='#00ff2a'><a href='event:hero.DHeroPanel 1'><u>家将修行</u></a></font>", item = {{640,3}}},
		},
		[2] = { level = 40,item = {{640,20},{696,1},{694,1}},
			[1] = {pos=6,title = '在任意装备镶嵌1颗3级宝石',content = "宝石可以通过每日宝石副本获得，并且可以向上合成。\n                                                                  <font color='#00ff2a'><a href='event:equip.DEquipPanel 1'><u>宝石镶嵌</u></a></font>", item = {{640,5}}},
			--[2] = {pos=7,title = '将坐骑的炼骨提升到10级',content = "坐骑升级到一定阶数，才会开启炼骨。炼骨丹可以挂机掉落，也可以在拍卖所收购。\n\n                                                                  <font color='#00ff2a'><a href='event:horse.DHorsePanel 1'><u>坐骑炼骨</u></a></font>", item = {{640,5}}},
			[2] = {pos=7,title = '任意帮会技能学习到3级',content = "首先要升级帮会的技能书院，才能学习更高级的帮会技能。\n                                                                <font color='#00ff2a'><a href='event:faction.DFactionPanel 0'><u>学习技能</u></a></font>", item = {{640,5}}},
			[3] = {pos=10,title = '守护之魂装备任意一个紫色技能',content = "通灵技能最重要的是运气，另外也要多准备铜钱哦！\n                                                                  <font color='#00ff2a'><a href='event:magic.DAmuletMagicPanel'><u>守护通灵</u></a></font>", item = {{640,5}}},
			[4] = {pos=11,title = '神创天下凡人9星过关',content = "战斗力越高，能通关的关卡越多，获得的奖励越多。\n                                                                 <font color='#00ff2a'><a href='event:DCreateWorld'><u>挑战</u></a></font>", item = {{640,5}}},
			--[5] = {pos=12,title = '将任意装备强化到15级',content = "强化成功率不足的时候，记得放入幸运石。\n \n\n                                                                   <font color='#00ff2a'><a href='event:equip.DEquipPanel 0'><u>装备强化</u></a></font>", item = {{640,5}}},
			[5] = {pos=12,title = '将任意装备洗练出1条橙色附加属性',content = "洗练石可以通过分解无用的装备来获得，挂机可以概率掉落装备。\n                                                                   <font color='#00ff2a'><a href='event:equip.DEquipPanel 2'><u>装备洗练</u></a></font>", item = {{640,5}}},
			--[6] = {pos=13,title = '将坐骑进化为“雷霆狼骑”',content = "坐骑进阶丹可通过活动获得，也可以通过讨伐任务获得，还可以用绑定元宝购买。\n\n                                                                  <font color='#00ff2a'><a href='event:horse.DHorsePanel 0'><u>坐骑培养</u></a></font>", item = {{640,5}}},
			[6] = {pos=13,title = '将坐骑进化为“汗血宝马”',content = "坐骑进阶丹可通过打怪掉落，日常任务获得，还可以用绑定元宝购买。\n                                                                  <font color='#00ff2a'><a href='event:horse.DHorsePanel 0'><u>坐骑培养</u></a></font>", item = {{640,5}}},			
		},
		[3] = { level = 50,item = {{640,30},{637,10},{732,1}},
			[1] = {pos=14,title = '将宝石纯化提升到10级',content = "宝石纯化可以提升镶嵌中宝石的数值。彩虹石可以挂机掉落，也可以在拍卖所收购。\n                                                                  <font color='#00ff2a'><a href='event:equip.DJewelLevel'><u>宝石纯化</u></a></font>", item = {{640,8}}},
			[2] = {pos=15,title = '将任意橙装进行1次强化',content = "橙装碎片可以在爵位商店兑换，传说之石可以在塔防副本获得。\n                                                                  <font color='#00ff2a'><a href='event:equip.DEquipPanel 0'><u>装备强化</u></a></font>", item = {{640,8}}},			
			--[3] = {pos=16,title = '将任意家将修行到30阶',content = "灵气可通过果园种植获得，也可以通过庄主排位赛结算奖励获得。\n\n                                                                  <font color='#00ff2a'><a href='event:hero.DHeroPanel 1'><u>家将修行</u></a></font>", item = {{640,8}}},
			[3] = {pos=16,title = '将坐骑的炼骨提升到10级',content = "坐骑升级到一定阶数，才会开启炼骨。炼骨丹可以挂机掉落，也可以在拍卖所收购。\n                                                                  <font color='#00ff2a'><a href='event:horse.DHorsePanel 1'><u>坐骑炼骨</u></a></font>", item = {{640,8}}},
			[4] = {pos=17,title = '将女神升级到1阶',content = "女神升阶后，可以伴随你左右，并且可以帮你战斗。\n                                                                  <font color='#00ff2a'><a href='event:magic.DFightMagicPanel'><u>女神升阶</u></a></font>", item = {{640,8}}},
			--[5] = {pos=20,title = '守护之魂装备任意一个橙色技能',content = "通灵技能最重要的是运气，另外也要多准备铜钱哦！\n\n                                                                  <font color='#00ff2a'><a href='event:magic.DAmuletMagicPanel'><u>通灵技能</u></a></font>", item = {{640,8}}},
			[5] = {pos=20,title = '将骑兵提升到2阶',content = "骑兵不仅外形酷炫，并且能提升大量战力。五色神铁可在活跃度，周跑环中获得。\n                                                                 <font color='#00ff2a'><a href='event:horseWeapon.DHorseWeaponPanel'><u>提升骑兵</u></a></font>", item = {{640,8}}},
			--[6] = {pos=21,title = '将坐骑进化为“太虚白熊”',content = "坐骑进阶丹可通过活动获得，也可以通过讨伐任务获得，还可以用绑定元宝购买。\n\n                                                                  <font color='#00ff2a'><a href='event:horse.DHorsePanel 0'><u>坐骑培养</u></a></font>", item = {{640,8}}},
			[6] = {pos=21,title = '食用了任意一种属性丹',content = "人物属性丹可在VIP副本，排位赛藏宝阁等地方获得。使用即可增加战斗力。\n                                                                  <font color='#00ff2a'><a href='event:DMainStatePanel 4'><u>属性丹</u></a></font>", item = {{640,8}}},
		},
		[4] = { level = 60,item = {{640,50},{626,150},{627,150}},
			[1] = {pos=22,title = '将职业天赋升级到10级',content = "职业天赋不但可以增加属性，并且可以对职业技能进行效果加强。\n                                                                  <font color='#00ff2a'><a href='event:skill.DSkillPanel 2'><u>职业天赋</u></a></font>", item = {{640,12}}},
			--[2] = {pos=23,title = '任意帮会技能学习到8级',content = "首先要升级帮会的技能书院，才能学习更高级的帮会技能。\n\n                                                                <font color='#00ff2a'><a href='event:faction.DFactionPanel'><u>学习技能</u></a></font>", item = {{640,12}}},
			[2] = {pos=23,title = '将骑兵提升到3阶',content = "骑兵不仅外形酷炫，并且能提升大量战力。五色神铁可在活跃度，周跑环中获得。\n                                                                  <font color='#00ff2a'><a href='event:horseWeapon.DHorseWeaponPanel'><u>提升骑兵</u></a></font>", item = {{640,12}}},
			--[3] = {pos=24,title = '在任意装备镶嵌1颗8级宝石',content = "宝石可以通过每日宝石副本获得，并且可以向上合成。\n\n                                                                  <font color='#00ff2a'><a href='event:equip.DEquipPanel 1'><u>宝石镶嵌</u></a></font>", item = {{640,12}}},
			[3] = {pos=24,title = '将神翼提升到2阶',content = "神翼就是身份的标志，并且可以提升大量战力。神翼技能也是在扭转战局的关键。\n                                                                 <font color='#00ff2a'><a href='event:wing.DWingPanel'><u>提升神翼</u></a></font>", item = {{640,12}}},
			--[4] = {pos=25,title = '守护之魂的总评分达到30000',content = "通灵技能最重要的是运气，另外也要多准备铜钱哦！\n\n                                                                  <font color='#00ff2a'><a href='event:magic.DAmuletMagicPanel'><u>通灵技能</u></a></font>", item = {{640,12}}},
			[4] = {pos=25,title = '守护之魂装备任意一个橙色技能',content = "通灵技能最重要的是运气，另外也要多准备铜钱哦！\n                                                                 <font color='#00ff2a'><a href='event:magic.DAmuletMagicPanel'><u>通灵技能</u></a></font>", item = {{640,12}}},
			[5] = {pos=26,title = '将女神升级到5阶',content = "女神升阶后，可以伴随你左右，并且可以帮你战斗。\n                                                                  <font color='#00ff2a'><a href='event:magic.DFightMagicPanel'><u>女神升阶</u></a></font>", item = {{640,12}}},
			[6] = {pos=27,title = '将坐骑进化为“咆哮天虎”',content = "坐骑进阶丹可通过打怪掉落，日常任务获得，还可以用绑定元宝购买。\n                                                                 <font color='#00ff2a'><a href='event:horse.DHorsePanel 0'><u>坐骑培养</u></a></font>", item = {{640,12}}},
		},
		[5] = { level = 70,item = {{640,80},{771,30},{766,2}},
			[1] = {pos=30,title = '将职业天赋升级到30级',content = "职业天赋不但可以增加属性，并且可以对职业技能进行效果加强。\n                                                                 <font color='#00ff2a'><a href='event:skill.DSkillPanel 2'><u>职业天赋</u></a></font>", item = {{640,15}}},
			[2] = {pos=31,title = '任意帮会技能学习到8级',content = "首先要升级帮会的技能书院，才能学习更高级的帮会技能。\n                                                               <font color='#00ff2a'><a href='event:faction.DFactionPanel'><u>学习技能</u></a></font>", item = {{640,15}}},
			[3] = {pos=32,title = '将骑兵提升到4阶',content = "骑兵不仅外形酷炫，并且能提升大量战力。五色神铁可在活跃度，周跑环中获得。\n                                                                  <font color='#00ff2a'><a href='event:horseWeapon.DHorseWeaponPanel'><u>提升骑兵</u></a></font>", item = {{640,15}}},
			[4] = {pos=33,title = '在任意装备镶嵌1颗8级宝石',content = "宝石可以通过每日宝石副本获得，并且可以向上合成。\n                                                                  <font color='#00ff2a'><a href='event:equip.DEquipPanel 1'><u>宝石镶嵌</u></a></font>", item = {{640,15}}},
			[5] = {pos=34,title = '将神翼提升到5阶',content = "神翼就是身份的标志，并且可以提升大量战力。神翼技能也是在扭转战局的关键。\n                                                                 <font color='#00ff2a'><a href='event:wing.DWingPanel'><u>提升神翼</u></a></font>", item = {{640,15}}},
			[6] = {pos=35,title = '守护之魂的总评分达到30000',content = "通灵技能最重要的是运气，另外也要多准备铜钱哦！\n                                                                  <font color='#00ff2a'><a href='event:magic.DAmuletMagicPanel'><u>通灵技能</u></a></font>", item = {{640,15}}},			
		},
	},
	sc = {pos = 50,bdyb = 200}, --收藏领取标识 bdyb 获取的绑定元宝数
	lvgift = {--等级礼包
		[1] = {lv = 40,pos = 51,item = {{1096,200}}},
		[2] = {lv = 42,pos = 52,item = {{1096,300}}},
		[3] = {lv = 44,pos = 53,item = {{1096,500}}},
		[4] = {lv = 46,pos = 54,item = {{1096,800}}},
		[5] = {lv = 48,pos = 55,item = {{1096,1000}}},
		[6] = {lv = 50,pos = 56,item = {{1096,1500}}},
		[7] = {lv = 52,pos = 57,item = {{1096,2000}}},
		[8] = {lv = 54,pos = 60,item = {{1096,2400}}},
		[9] = {lv = 56,pos = 61,item = {{1096,3500}}},
		[10] = {lv = 58,pos = 62,item = {{1096,5000}}},
		[11] = {lv = 60,pos = 63,item = {{1096,8800}}},
		[12] = {lv = 62,pos = 64,item = {{1096,12888}}},
	},
	dl = {
		-- money = 1,		-- 绑银
		-- item = 3,		-- 道具
		-- lingqi = 5,		-- 灵气
		pos = 65,
		[1] = 200000,
		[3] = {{5625,1,1},},
		[5] = 200000,
	}, --下载登录器奖励
	-- 66 第6个字节的第6位,新手礼品表示位置
	--67  4399手机验证
}
--新手卡激活码物品配置表
local newplayergift_goodconf = {
		{601,5,1},				--5个高级铜钱卡
		{603,5,1},				--5个高级灵气珠
		{612,5,1},				--5个3级幸运石
		{1061,5,1},				--5个3级攻击之酒
		{51,2,1},				--2个1.5倍经验符
		{1,2,1}	,				--2个紫霞仙丹
		{604,5,1},				--5个初级洗练石
		{100,10,1}				--10飞行符
}

--手机绑定
local _4399phone_goodsconf={
	{1073,200,1},   			--200绑定元宝
}
--360加速球
local _360jiasuqiu={
	
		{789,5,1},				
		{636,2,1},				
		{771,1,1},				
		{603,20,1},				
						
}
   --360大厅
_360dating={
		{647,1,1},				
		{618,5,1},				
		{3008,1,1},
		{710,3,1},				
		{634,5,1},				
		{803,20,1},
		{778,3,1},				
		{603,100,1},						
}
--获取活跃度数据
local function _get_fundata(sid)
	local data = __G.GetPlayerDayData(sid)
	if data==nil then return end
	if data.fun == nil then
	   data.fun = {} --proc 保存完成度 get 已领取 val 当前活跃值
	end
	return data.fun
end

--记录今日活跃度 idx 活跃索引 times 当日次数 times1 总次数 times2 加之前的次数
local function _set_data(sid , idx, times, times1, times2)
	local data = _get_fundata(sid)
	if data==nil then
		--look('SetFunData_error')
		return
	end
	local conf
	--活跃
	times2 = times2 or 0
	local conf = FunConf.active[1][idx]
	if(times~=nil and conf~=nil)then
		if(times >= conf.times and times2 < conf.times)then --完成
			data.val = (data.val == nil and 0) or data.val
			local addVal = conf.val
			if(idx == 28)then --每日签到
				--+10	+15	+20	+25	+30	+35	+40	+50
				local vipLv = __G.GI_GetVIPLevel(sid)
				if(vipLv>3)then
					addVal = addVal + (10+(vipLv - 4)*5)--((vipLv<9 and vipLv * 5) or vipLv * 5 +5)
				end
			end
			data.val = data.val + addVal
		end
		--if(times < conf.times)then --大于不影响前台就不发了
		--	SendLuaMsg( 0, { ids=EveryDay_Actibe_msg, data = data }, 9 )
		--end
		SendLuaMsg( 0, { ids=EveryDay_Actibe_msg, data = data }, 9 )
	end
end

--手动加活跃度
local function _add_fun_val(sid,addVal)
	local data = _get_fundata(sid)
	if data==nil then
		return
	end
	data.val = (data.val == nil and 0) or data.val
	data.val = data.val + addVal
	SendLuaMsg( 0, { ids=EveryDay_Actibe_msg, data = data }, 9 )
end

--获取每日活跃奖励 idx 活跃奖励索引
local function _get_fun_gift(sid,idx)
	local data = _get_fundata(sid)
	if(data == nil)then return false,1 end --获取活跃数据失败
	
	local award = data.awad
	if(award~=nil and award[idx]~=nil)then return false,2 end --已领取
	
	local curAward = FunConf.active[2][idx]
	if(curAward == nil)then return false,3 end --获取活跃奖励数据失败
	
	if(data.val == nil or data.val<curAward.val)then	 return false,4 end --活跃值不足
	
	local pakagenum = isFullNum()
	if pakagenum < #curAward.item then return false,5 end --背包空格不足
	for _,v in pairs(curAward.item) do
		GiveGoods(v[1],v[2],1,"活跃度奖励")
	end
	if(award == nil)then
		data.awad = {}
		award = data.awad
	end
	award[idx] = 1
	return true,data
end

--获取目标领奖数据
local function _get_objdata(sid)
	local data=__G.GI_GetPlayerData( sid ,'obj',150)
	if data==nil then return end
	return data
end

--清空目标数据
local function _clear_obj_pos(sid)
	local data = _get_objdata(sid)
	if(data~=nil)then
		for idx, v in pairs(data) do
			if(type(idx) == type(0))then
				data[idx] = nil
			end
		end
	end
end

--领奖数据 data = {[1]=1101011,...} 最后一位标记的是大奖励的领取状态,索引是目标类型索引
--领取目标奖励 objid 目标索引
local function _get_obj_item(sid,objid)
	local ot = math_floor(objid/1000)
	local oid = math_floor(objid%1000)
	local objTb = FunConf.object[ot]
	if(objTb == nil or objTb[oid] == nil or objTb[oid].pos == nil)then return false,1 end --找不到目标
	local data = _get_objdata(sid)
	if(data == nil)then return false,2 end --获取领奖数据失败
	if(data[ot]~=nil and math_floor((data[ot]/(10^oid))%10)>0)then return false,3 end --已领取了奖励
	local itemData = objTb[oid].item
	if(itemData == nil)then return false,4 end --没有配奖励
	local pos = objTb[oid].pos
	local post = math_floor(pos/10)
	local posidx = math_floor(pos%10)
	if(GetTaskMask(post,posidx) == false)then return false,5 end --目标尚未达成
	local pakagenum = isFullNum()
	if pakagenum < #itemData then return false,6 end --背包空格不足
	for _,v in pairs(itemData) do
		GiveGoods(v[1],v[2],1,"目标奖励")
	end
	if(data[ot] == nil)then data[ot] = 0 end
	data[ot] = data[ot] + 10^oid
	return true,data
end

--领取目标达成的大奖励 t 目标分类索引
local function _get_obj_finish_item(sid,t)
	local objTb = FunConf.object[t]
	if(objTb == nil)then return false,1 end --找不到目标
	local itemData = objTb.item
	if(itemData == nil)then return false,2 end --没有配奖励
	local data = _get_objdata(sid)
	if(data == nil)then return false,3 end --获取领奖数据失败
	if(data[t]~=nil and math_floor(data[t]%10)>0)then return false,4 end --已领取了奖励
	local post
	local postidx
	for i = 1,#objTb-1 do
		if(objTb[i] ~= nil and objTb[i].pos~=nil)then
			post = math_floor(objTb[i].pos/10)
			posidx = math_floor(objTb[i].pos%10)
			if(GetTaskMask(post,posidx) == false)then return false,5 end --目标尚未达成
		end
	end
	local pakagenum = isFullNum()
	if pakagenum < #itemData then return false,6 end --背包空格不足
	for _,v in pairs(itemData) do
		GiveGoods(v[1],v[2],1,"目标大奖励")
	end
	if(data[t] == nil)then data[t] = 0 end
	data[t] = data[t] + 1
	return true,data
end

--设置位
local function _set_mask_pos(sid,pos)
	--look('set mask pos '..sid..','..pos)
	if(sid == nil or sid<=0 or pos == nil)then
		look('error task set (pos/sid) is null or <=0',1)
		return
	end
	local group = math_floor(pos/10)
	local idx = math_floor(pos%10)
	if(group>127 or group<0 or idx>7)then
		look('error task set pos = '..pos,1)
		return
	end
	result = SetTaskMask(group,idx,2,sid)
	if(result)then
		-- look('set pos result='..result)
	else
		-- look('set pos result is null')
	end
end

--获取位
local function _get_mask_pos(sid,pos) 
	if(sid == nil or sid<=0 or pos == nil)then
		look('error task get (pos/sid) is null or <=0',1)
		return
	end
	local group = math_floor(pos/10)
	local idx = math_floor(pos%10)
	if(group>127 or group<0 or idx>7)then
		look('error task get pos = '..pos,1)
		return
	end
	return GetTaskMask(group,idx)
end


--达成目标
local function _set_obj_pos(sid,objid)
	local ot = math_floor(objid/1000)
	local oid = math_floor(objid%1000)
	local objTb = FunConf.object[ot]
	if(objTb == nil or objTb[oid] == nil or objTb[oid].pos == nil)then return end --找不到目标
	local pos = objTb[oid].pos
	_set_mask_pos(sid,pos)
end

--领取收藏奖励
local function _get_sc_item(sid)
	local scTb = FunConf.sc
	if(scTb == nil or scTb.pos == nil)then return 1 end --配置出错
	local isGet = _get_mask_pos(sid,scTb.pos)
	if(isGet == nil)then return 2 end --获取领取标识失败
	if(isGet == true)then return 3 end --已领取
	if(scTb.bdyb and type(scTb.bdyb) == type(0))then --加绑定元宝
		__G.AddPlayerPoints( sid , 3 , scTb.bdyb ,nil,'收藏加绑定元宝')
	end
	_set_mask_pos(sid,scTb.pos)
end





--激活卡领物品 1,新手卡2,手机3,360加速球,4,360大厅
local function _giveplayer_jihuogift(sid,iType)
	local  temp_goodconf
	local pos
	if	iType == 1 then 
		temp_goodconf = newplayergift_goodconf
		pos = 66
		local isGet = _get_mask_pos(sid,pos)
		if(isGet == nil)then return 3 end --获取领取标识失败
		if(isGet == true)then --已领取
			TipCenter(__G.GetStringMsg(458))
			return 4 
		end 
		local pakagenum = isFullNum()
		if pakagenum < #temp_goodconf then --背包空格不足
			TipCenter(__G.GetStringMsg(14,#temp_goodconf))
			return 5 
		end 
		if(temp_goodconf~=nil)then
			GiveGoodsBatch(temp_goodconf,"新手奖励")
			RPC('code_getwards',temp_goodconf,iType)--领奖成功,前台显示面板
		end
		_set_mask_pos(sid,pos)
	elseif iType == 2 then
		pos = 67
		local isGet = _get_mask_pos(sid,pos)
		if(isGet == nil)then return 3 end --获取领取标识失败
		if(isGet == true)then return 4 end --已领取
		__G.AddPlayerPoints( sid , 3 , 200 ,nil,'手机验证增加绑定元宝')
		RPC('code_getwards',_4399phone_goodsconf,iType)--领奖成功,前台显示面板
		_set_mask_pos(sid,pos)
	elseif	iType == 3 then 
		temp_goodconf = _360jiasuqiu
		pos = 70
		local isGet = _get_mask_pos(sid,pos)
		if(isGet == nil)then return 3 end --获取领取标识失败
		if(isGet == true)then --已领取
			TipCenter(__G.GetStringMsg(458))
			return 4 
		end 
		local pakagenum = isFullNum()
		if pakagenum < #temp_goodconf then --背包空格不足
			TipCenter(__G.GetStringMsg(14,#temp_goodconf))
			return 5 
		end 
		if(temp_goodconf~=nil)then
			GiveGoodsBatch(temp_goodconf,"360加速球")
			RPC('code_getwards',temp_goodconf,iType)--领奖成功
		end
		_set_mask_pos(sid,pos)
	elseif	iType == 4 then 
		temp_goodconf = _360dating
		pos = 71
		local isGet = _get_mask_pos(sid,pos)
		if(isGet == nil)then return 3 end --获取领取标识失败
		if(isGet == true)then --已领取
			TipCenter(__G.GetStringMsg(458))
			return 4 
		end 
		local pakagenum = isFullNum()
		if pakagenum < #temp_goodconf then --背包空格不足
			TipCenter(__G.GetStringMsg(14,#temp_goodconf))
			return 5 
		end 
		if(temp_goodconf~=nil)then
			GiveGoodsBatch(temp_goodconf,"360大厅")
			RPC('code_getwards',temp_goodconf,iType)--领奖成功
		end
		_set_mask_pos(sid,pos)
	end
end




--等级礼包领取
local function _get_lv_item(sid,idx)
	local tb = FunConf.lvgift[idx]
	if(tb == nil or tb.pos == nil or tb.lv == nil)then return 1 end --配置出错
	local level = CI_GetPlayerData(1)
	if(level<tb.lv)then return 2 end --等级不足
	local isGet = _get_mask_pos(sid,tb.pos)
	-- look('12313122111111')
	-- look(isGet)
	if(isGet == nil)then return 3 end --获取领取标识失败
	if(isGet == true)then return 4 end --已领取
	if(tb.item~=nil)then
		for _,v in pairs(tb.item) do
			DGiveP(v[2],'awards_等级奖励')
		end
		--[[
		local pakagenum = isFullNum()
		if pakagenum < #tb.item then return false,5 end --背包空格不足
		for _,v in pairs(tb.item) do
			GiveGoods(v[1],v[2],1,"等级奖励")
		end
		]]--
	end
	_set_mask_pos(sid,tb.pos)
end

--领取微端奖励
local function _get_dl_item(sid)
	local dlTb = FunConf.dl
	if(dlTb == nil or dlTb.pos == nil)then return 1 end --配置出错
	local isGet = _get_mask_pos(sid,dlTb.pos)
	if(isGet == nil)then return 2 end --获取领取标识失败
	if(isGet == true)then return 3 end --已领取
	if(dlTb[3]~=nil and type(dlTb[3]) == type({}))then --道具 必须先判断道具，背包
		local pakagenum = isFullNum()
		if pakagenum < #dlTb[3] then
			return false,4 --背包空格不足
		end
		GiveGoodsBatch(dlTb[3],"新微端登录奖励领取")
	end
	if(dlTb[1]~=nil)then --铜钱
		GiveGoods(0,dlTb[1],1,"新微端登录奖励领取")
	end
	if(dlTb[5]~=nil)then --灵气
		__G.AddPlayerPoints(sid,2,dlTb[1],nil,'新微端登录奖励领取')
	end
	_set_mask_pos(sid,dlTb.pos)
	return true
end
--------------------------------------------------------------------------
-- interface:
get_fundata = _get_fundata
set_data = _set_data
get_fun_gift = _get_fun_gift
get_obj_item = _get_obj_item
get_obj_finish_item = _get_obj_finish_item
set_obj_pos = _set_obj_pos
clear_obj_pos = _clear_obj_pos
set_mask_pos = _set_mask_pos
get_mask_pos = _get_mask_pos
get_sc_item = _get_sc_item
get_lv_item = _get_lv_item
get_dl_item = _get_dl_item
giveplayer_jihuogift = _giveplayer_jihuogift
add_fun_val = _add_fun_val