--[[
file:	mail_conf.lua
desc:	system mail conf
author:	
update:	
refix: done by chal
update: 2014-08-23 ,add by sxj ,add MailConfig.Bsmz
]]--
-- ID 礼包ID 不能重复 按顺序递增 (ID == 0 无礼包)
-- title 邮件标题
-- content 邮件内容
-- name  礼包名称
-- itemlist 礼包物品列表 133,100;271,500; 物品ID,物品数量;物品ID,物品数量;
-- desc 礼包描述

-- %itemid% 表示取道具名称显示

local char31 = ""
local char30 = ""		-- *所有玩家名字必须用char30分隔*
MailConfig = {
	LTLiBao = {
		[1] = {ID = 10000001,title = "竞技场前十名奖励",content = "由于您在竞技场中表现优异，竞技积分在上周排行榜中位列第一，特发放竞技礼包奖励。",name = "竞技冠军包",itemlist = "7113,30;",desc = "竞技场第一名奖励，包含30个竞技礼券兑换符。"},
		[2] = {ID = 10000002,title = "竞技场前十名奖励",content = "由于您在竞技场中表现优异，竞技积分在上周排行榜中位列第二，特发放竞技礼包奖励。",name = "竞技亚军包",itemlist = "7113,20;",desc = "竞技场第二名奖励，包含20个竞技礼券兑换符。"},
		[3] = {ID = 10000003,title = "竞技场前十名奖励",content = "由于您在竞技场中表现优异，竞技积分在上周排行榜中位列第三，特发放竞技礼包奖励。",name = "竞技季军包",itemlist = "7113,15;",desc = "竞技场第三名奖励，包含15个竞技礼券兑换符。"},
		[4] = {ID = 10000004,title = "竞技场前十名奖励",content = "由于您在竞技场中表现优异，竞技积分在上周排行榜中位列第四，特发放竞技礼包奖励。",name = "竞技第四名礼包",itemlist = "7113,12;",desc = "竞技场第四名奖励，包含12个竞技礼券兑换符。"},
		[5] = {ID = 10000005,title = "竞技场前十名奖励",content = "由于您在竞技场中表现优异，竞技积分在上周排行榜中位列第五，特发放竞技礼包奖励。",name = "竞技前十名礼包",itemlist = "7113,10;",desc = "竞技场第五~十名奖励，包含10个竞技礼券兑换符。"},
		[6] = {ID = 10000006,title = "竞技场前十名奖励",content = "由于您在竞技场中表现优异，竞技积分在上周排行榜中位列第六，特发放竞技礼包奖励。",name = "竞技前十名礼包",itemlist = "7113,10;",desc = "竞技场第五~十名奖励，包含10个竞技礼券兑换符。"},
		[7] = {ID = 10000007,title = "竞技场前十名奖励",content = "由于您在竞技场中表现优异，竞技积分在上周排行榜中位列第七，特发放竞技礼包奖励。",name = "竞技前十名礼包",itemlist = "7113,10;",desc = "竞技场第五~十名奖励，包含10个竞技礼券兑换符。"},
		[8] = {ID = 10000008,title = "竞技场前十名奖励",content = "由于您在竞技场中表现优异，竞技积分在上周排行榜中位列第八，特发放竞技礼包奖励。",name = "竞技前十名礼包",itemlist = "7113,10;",desc = "竞技场第五~十名奖励，包含10个竞技礼券兑换符。"},
		[9] = {ID = 10000009,title = "竞技场前十名奖励",content = "由于您在竞技场中表现优异，竞技积分在上周排行榜中位列第九，特发放竞技礼包奖励。",name = "竞技前十名礼包",itemlist = "7113,10;",desc = "竞技场第五~十名奖励，包含10个竞技礼券兑换符。"},
		[10] = {ID = 10000010,title = "竞技场前十名奖励",content = "由于您在竞技场中表现优异，竞技积分在上周排行榜中位列第十，特发放竞技礼包奖励。",name = "竞技前十名礼包",itemlist = "7113,10;",desc = "竞技场第五~十名奖励，包含10个竞技礼券兑换符。"},
	},
	Enhance = {
		[101] = {ID = 10000017,title = "1件装备强化+10奖励",content = "由于您将一件装备强化至+10星，特发放1件装备强化+10礼包。",name = "1件装备强化+10礼包",itemlist = "7123,1;",desc = "1件装备强化+10奖励，包含1个二级玉石随机包。"},
		[131] = {ID = 10000018,title = "1件装备强化+13奖励",content = "由于您将一件装备强化至+13星，特发放1件装备强化+13礼包。",name = "1件装备强化+13礼包",itemlist = "7112,1;",desc = "1件装备强化+13奖励，包含1个三级玉石随机包。"},
		[151] = {ID = 10000019,title = "1件装备强化+15奖励",content = "由于您将一件装备强化至+15星，特发放1件装备强化+15礼包。",name = "1件装备强化+15礼包",itemlist = "7124,1;",desc = "1件装备强化+15奖励，包含1个四级玉石随机包。"},
		[103] = {ID = 10000020,title = "3件装备强化+10奖励",content = "由于您将3件装备强化至+10星，特发放3件装备强化+10礼包。",name = "3件装备强化+10礼包",itemlist = "7123,3;",desc = "3件装备强化+10奖励，包含3个二级玉石随机包。"},
		[133] = {ID = 10000021,title = "3件装备强化+13奖励",content = "由于您将3件装备强化至+13星，特发放3件装备强化+13礼包。",name = "3件装备强化+13礼包",itemlist = "7112,3;",desc = "3件装备强化+13奖励，包含3个三级玉石随机包。"},
		[153] = {ID = 10000022,title = "3件装备强化+15奖励",content = "由于您将3件装备强化至+15星，特发放3件装备强化+15礼包。",name = "3件装备强化+15礼包",itemlist = "7124,3;",desc = "3件装备强化+15奖励，包含3个四级玉石随机包。"},
		[106] = {ID = 10000023,title = "6件装备强化+10奖励",content = "由于您将6件装备强化至+10星，特发放6件装备强化+10礼包。",name = "6件装备强化+10礼包",itemlist = "7123,5;",desc = "6件装备强化+10奖励，包含5个二级玉石随机包。。"},
		[136] = {ID = 10000024,title = "6件装备强化+13奖励",content = "由于您将6件装备强化至+13星，特发放6件装备强化+13礼包。",name = "6件装备强化+13礼包",itemlist = "7112,5;",desc = "6件装备强化+13奖励，包含5个三级玉石随机包。"},
		[156] = {ID = 10000025,title = "6件装备强化+15奖励",content = "由于您将6件装备强化至+15星，特发放6件装备强化+15礼包。",name = "6件装备强化+15礼包",itemlist = "7124,5;",desc = "6件装备强化+15奖励，包含5个四级玉石随机包。"},
	},
	HeroInborn = {
		[3] = {ID = 10000014,title = "随从天赋3星奖励",content = "由于您的一个出战随从的天赋达到了3星，特发放随从天赋3星礼包。",name = "随从天赋3星礼包",itemlist = "7117,1;",desc = "随从天赋3星奖励，包含1个3级技能魂石。"},
		[5] = {ID = 10000015,title = "随从天赋5星奖励",content = "由于您的一个出战随从的天赋达到了5星，特发放随从天赋5星礼包。",name = "随从天赋5星礼包",itemlist = "7118,1;",desc = "随从天赋5星奖励，包含1个4级技能魂石。"},
		[7] = {ID = 10000016,title = "随从天赋7星奖励",content = "由于您的一个出战随从的天赋达到了7星，特发放随从天赋7星礼包。",name = "随从天赋7星礼包",itemlist = "7119,1;",desc = "随从天赋7星奖励，包含1个5级技能魂石。"},
	},
	VIPNotice = {
		[1] = {ID = 0,title = "VIP到期提醒",content = '主人，我是您的女仆妲己，我们家的VIP已经到期了，VIP尊贵身份是我们庄园强大的基础，小仆愿与主人同甘共苦...<font color="#baff7c" size="13"><a href="event:vip.DVipPanel"><u>立即续费</u></a></font>',},
		[2] = {ID = 0,title = "VIP购买通知",content = '主人，您的好友#1为您购买了VIP十天卡，从即刻开始我们将可以享受VIP十天卡的所有特权啦！\n主人，我们可以通过以下方式提升战斗力：\n<font color="#baff7c" size="13"><a href="event:horseweapon"><u>1.骑兵升级</u></a></font>\n<font color="#baff7c" size="13"><a href="event:equip.DEquipPanel 0 "><u>2.装备强化</u></a></font>\n<font color="#baff7c" size="13"><a href="event:horse.DHorsePanel 0 "><u>3.坐骑进化</u></a></font>\n<font color="#baff7c" size="13"><a href="event:hero.DHeroPanel 0 "><u>4.家将培养</u></a></font>\n<font color="#baff7c" size="13"><a href="event:magic.DAmuletMagicPanel"><u>5.守护之魂</u></a></font>',},
		[3] = {ID = 0,title = "VIP购买通知",content = '主人，您的好友#1为您购买了VIP月卡，从即刻开始我们将可以享受VIP月卡的所有特权啦！\n主人，我们可以通过以下方式提升战斗力：\n<font color="#baff7c" size="13"><a href="event:horseweapon"><u>1.骑兵升级</u></a></font>\n<font color="#baff7c" size="13"><a href="event:equip.DEquipPanel 0 "><u>2.装备强化</u></a></font>\n<font color="#baff7c" size="13"><a href="event:horse.DHorsePanel 0 "><u>3.坐骑进化</u></a></font>\n<font color="#baff7c" size="13"><a href="event:hero.DHeroPanel 0 "><u>4.家将培养</u></a></font>\n<font color="#baff7c" size="13"><a href="event:magic.DAmuletMagicPanel"><u>5.守护之魂</u></a></font>',},
		[4] = {ID = 0,title = "VIP购买通知",content = '主人，您的好友#1为您购买了VIP半年卡，从即刻开始我们将可以享受VIP半年卡的所有特权啦！\n主人，我们可以通过以下方式提升战斗力：\n<font color="#baff7c" size="13"><a href="event:horseweapon"><u>1.骑兵升级</u></a></font>\n<font color="#baff7c" size="13"><a href="event:equip.DEquipPanel 0 "><u>2.装备强化</u></a></font>\n<font color="#baff7c" size="13"><a href="event:horse.DHorsePanel 0 "><u>3.坐骑进化</u></a></font>\n<font color="#baff7c" size="13"><a href="event:hero.DHeroPanel 0 "><u>4.家将培养</u></a></font>\n<font color="#baff7c" size="13"><a href="event:magic.DAmuletMagicPanel"><u>5.守护之魂</u></a></font>',},
		[5] = {ID = 0,title = "VIP即将到期通知",content = '主人，我是您的女仆妲己，我们家的VIP马上就要到期了，VIP尊贵身份是我们庄园强大的基础，小仆愿与主人同甘共苦...<font color="#baff7c" size="13"><a href="event:vip.DVipPanel"><u>立即续费</u></a></font>',},
		[102] = {ID = 0,title = "VIP开通通知",content = '主人，恭喜您购买了VIP十天卡，从即刻开始我们将可以享受VIP十天卡的所有特权啦！\n主人，我们可以通过以下方式提升战斗力：\n<font color="#baff7c" size="13"><a href="event:horseweapon"><u>1.骑兵升级</u></a></font>\n<font color="#baff7c" size="13"><a href="event:equip.DEquipPanel 0 "><u>2.装备强化</u></a></font>\n<font color="#baff7c" size="13"><a href="event:horse.DHorsePanel 0 "><u>3.坐骑进化</u></a></font>\n<font color="#baff7c" size="13"><a href="event:hero.DHeroPanel 0 "><u>4.家将培养</u></a></font>\n<font color="#baff7c" size="13"><a href="event:magic.DAmuletMagicPanel"><u>5.守护之魂</u></a></font>',},
		[103] = {ID = 0,title = "VIP开通通知",content = '主人，恭喜您购买了VIP月卡，从即刻开始我们将可以享受VIP月卡的所有特权啦！\n主人，我们可以通过以下方式提升战斗力：\n<font color="#baff7c" size="13"><a href="event:horseweapon"><u>1.骑兵升级</u></a></font>\n<font color="#baff7c" size="13"><a href="event:equip.DEquipPanel 0 "><u>2.装备强化</u></a></font>\n<font color="#baff7c" size="13"><a href="event:horse.DHorsePanel 0 "><u>3.坐骑进化</u></a></font>\n<font color="#baff7c" size="13"><a href="event:hero.DHeroPanel 0 "><u>4.家将培养</u></a></font>\n<font color="#baff7c" size="13"><a href="event:magic.DAmuletMagicPanel"><u>5.守护之魂</u></a></font>',},
		[104] = {ID = 0,title = "VIP开通通知",content = '主人，恭喜您购买了VIP半年卡，从即刻开始我们将可以享受VIP半年卡的所有特权啦！\n主人，我们可以通过以下方式提升战斗力：\n<font color="#baff7c" size="13"><a href="event:horseweapon"><u>1.骑兵升级</u></a></font>\n<font color="#baff7c" size="13"><a href="event:equip.DEquipPanel 0 "><u>2.装备强化</u></a></font>\n<font color="#baff7c" size="13"><a href="event:horse.DHorsePanel 0 "><u>3.坐骑进化</u></a></font>\n<font color="#baff7c" size="13"><a href="event:hero.DHeroPanel 0 "><u>4.家将培养</u></a></font>\n<font color="#baff7c" size="13"><a href="event:magic.DAmuletMagicPanel"><u>5.守护之魂</u></a></font>',},	
	},
	baoyueMailConf={
		[1] = {ID = 0,title = "包月特权购买通知",content = '主人，您的好友#1为您购买了包月特权，从即刻开始我们将可以享受包月特权的所有服务啦！',},
	},
	ActiveNotice = {
		[1] = {ID = 0,title = "新服排行榜活动决出公告",content = '经过开服前7天大家的不懈努力，新服冲级赛、战力排名赛、强力随从榜的十大排行榜已经成功决出，请获奖者前往“活动领奖中心”领取奖品。<font color="#baff7c" size="13"><a href="event:DDayPanel 0"><u>详情点击</u></a></font>'},
	},
	MarryNotice = {
		[1] = {title = "宴席邀请",content = '<font color="#66FF00"><b>#1</b></font>与<font color="#66FF00"><b>#2</b></font><font color="##33FFFF">喜结良缘</font>，将于<font color="##33FFFF"><b>#3:#4</b></font>在西岐城举办盛大宴席，邀请大家届时准时参加，共同庆祝一对新人<font color="##33FFFF">喜结良缘</font>！',},
		[2] = {title = "宴席取消通知",content = '因你们没有在预约时间内开启宴席，导致宴席取消，现返还您部分的宴席订金，请注意收取！',},
		[3] = {title = "解除关系通知",content = '<font color="#66FF00"><b>#1</b></font>已申请与你强制解除关系，曲终人散矣！',},
		[4] = {title = "宴席红包",content = '通过你们举办的宴席，您获得#1个结缘石（大），#2个结缘石（小）的红包！',name = "宴席红包", itemlist = "",desc = "#1个结缘石（大），#2个结缘石（小）"},
		[5] = {title = "普通宴席礼包",content = '恭喜你们成功举办普通宴席，获得普通宴席礼包一个！',name = "普通宴席礼包", },
		[6] = {title = "普通宴席礼包",content = '恭喜你们成功举办普通宴席，获得普通宴席礼包一个！',name = "普通宴席礼包", },
		[7] = {title = "豪华宴席礼包",content = '恭喜你们成功举办豪华宴席，获得豪华宴席礼包一个！',name = "豪华宴席礼包", },
		[8] = {title = "豪华宴席礼包",content = '恭喜你们成功举办豪华宴席，获得豪华宴席礼包一个！',name = "豪华宴席礼包", },
		[9] = {title = "私人宴席礼包",content = '恭喜你们成功举办私人宴席，获得私人宴席礼包一个！',name = "私人宴席礼包", },
		[10] = {title = "私人宴席礼包",content = '恭喜你们成功举办私人宴席，获得私人宴席礼包一个！',name = "私人宴席礼包", },
		[11] = {title = "喜结良缘",content = '恭喜您在茫茫人海中寻得真爱，请与您的另一半，组队前往西岐的“月老”处，举办婚宴。只有完成婚宴，您才能获得月老的祝福，获得结婚戒指，姻缘称号，以及新婚时装！', },		
		[12] = {title = "预约宴席定金返还",content = '合服宴席预约定金返还!'},
	},
	RobMail = {			-- 庄园掠夺相关邮件
		[1] = {title = "庄园掠夺战报",},
		[2] = {title = "梳妆盒",content = '由于您的背包已满，现将您刚才通过庄园掠夺获得的1个梳妆盒发送给您，请注意收取附件！'},
	},
	FactionDB = {		-- 帮派夺宝
		[1] = {title = "帮会夺宝奖励",content = '恭喜你获得帮会夺宝胜利，获得#1个帮会宝箱'},
	},
	FactionUnion = {		-- 帮派结盟
		[1] = {title = "帮会结盟成功",content = '<font color="#66FF00"><b>#1</b></font>帮会已<font color="#66FF00"><b>#2</b></font>帮会正式结盟，<font color="#66FF00"><b>#3</b></font>帮会将作为<font color="#66FF00"><b>#4</b></font>帮会的一员参与帮会战场！'},
	},
	FactionDelUnion = {		-- 帮派取消结盟
		[1] = {title = "帮会结盟关系解除",content = '<font color="#66FF00"><b>#1</b></font>帮会已解除了和<font color="#66FF00"><b>#2</b></font>帮会同盟关系！'},
	},
	FactionDelUnion1 = {		-- 帮派取消结盟
		[1] = {title = "帮会结盟关系解除",content = '帮会战已结束，<font color="#66FF00"><b>#1</b></font>帮会和<font color="#66FF00"><b>#2</b></font>帮会的同盟关系已解除！'},
	},
	GardenDB = {		-- 果园变异果
		[1] = {title = "变异果",content = '由于您的背包已满，现将您刚才收获的1个%#1%发送给您，请注意收取附件！'},
		[2] = {title = "变异果",content = '由于您的背包已满，现将您刚才摘取的1个%#1%发送给您，请注意收取附件！'},
	},
	Party = {		-- 宴会结算
		[1] = {title = "宴会奖励",content = '您的宴会共有#1人参加，敬酒#2次,请在附件中提取奖励'},
	},
	ScoreList = {		-- 排行榜结算
		[3] = {title = "狩猎排行榜十大",content = '恭喜您在上周的天宫狩猎活动中获得第#1名，获得了炫彩称号哦！'},
		[4] = {title = "捕鱼排行榜十大",content = '恭喜您在上周的深海捕鱼活动中获得第#1名，获得了炫彩称号哦！'},
		[6] = {title = "三界夺宝排行榜十大",content = '恭喜您在上周的三界夺宝活动中获得第#1名，获得了炫彩称号哦！'},
		[9] = {title = "帮会战排行榜冠军",content = '恭喜您，上周您的帮会在帮会战中获得第1名，您获得了炫彩称号哦！'},
		[8] = {title = "竞技场排行榜十大",content = '恭喜您在上周的竞技场中获得第#1名，获得了炫彩称号哦！'},
		[5] = {title = "魅力排行榜十大",content = '恭喜您在上周的魅力排行榜中获得第#1名，获得了炫彩称号哦！'},
		[1] = {title = "星跳瑶池排行榜十大",content = '恭喜您在上周的星跳瑶池活动中获得第#1名，获得了炫彩称号哦！'},
		[2] = {title = "曲水流觞排行榜十大",content = '恭喜您在上周的曲水流觞活动中获得第#1名，获得了炫彩称号哦！'},
		
		
	},
	SanJieDB = {		-- 三界结算
		[1] = {title = "最完美玩家",content = '恭喜您在本次的三界战场活动中获得积分最多，成为本场最完美玩家，获得5个金元宝！',award = {[3] = {{640,5,1},},}},
		[2] = {title = "最勇猛玩家",content = '恭喜您在本次的三界战场活动中击杀玩家最多，成为本场最勇猛玩家，获得5个金元宝！',award = {[3] = {{640,5,1},},}},
		[3] = {title = "最勤劳玩家",content = '恭喜您在本次的三界战场活动中采集法宝碎片数最多，成为本场最勤劳玩家，获得5个金元宝！',award = {[3] = {{640,5,1},},}},
		[4] = {title = "最倒霉玩家",content = '因为您在本次的三界战场活动中被杀次数最多，成为本场最倒霉玩家，获得5个金元宝！',award = {[3] = {{640,5,1},},}},
	},
	ff = {		-- 帮会结算
		[1] = {title = "最完美玩家",content = '恭喜您在本次的帮会战活动中获得积分最多，成为本场最完美玩家，获得5个金元宝！',award = {[3] = {{640,5,1},},}},
		[2] = {title = "最勇猛玩家",content = '恭喜您在本次的帮会战活动中击杀玩家最多，成为本场最勇猛玩家，获得5个金元宝！',award = {[3] = {{640,5,1},},}},
		[3] = {title = "最勤劳玩家",content = '恭喜您在本次的帮会战活动中采集法宝碎片数最多，成为本场最勤劳玩家，获得5个金元宝！',award = {[3] = {{640,5,1},},}},
		[4] = {title = "最倒霉玩家",content = '因为您在本次的帮会战活动中被杀次数最多，成为本场最倒霉玩家，获得5个金元宝！',award = {[3] = {{640,5,1},},}},
	},
	cf = {		-- 攻城战结算
		[1] = {title = "最完美玩家",content = '恭喜您在本次的攻城战活动中获得积分最多，成为本场最完美玩家，获得5个金元宝！',award = {[3] = {{640,5,1},},}},
		[2] = {title = "最勇猛玩家",content = '恭喜您在本次的攻城战活动中击杀玩家最多，成为本场最勇猛玩家，获得5个金元宝！',award = {[3] = {{640,5,1},},}},
		[3] = {title = "最勤劳玩家",content = '恭喜您在本次的攻城战活动中采变身弩车次数最多，成为本场最勤劳玩家，获得5个金元宝！',award = {[3] = {{640,5,1},},}},
		[4] = {title = "最倒霉玩家",content = '因为您在本次的攻城战活动中被杀次数最多，成为本场最倒霉玩家，获得5个金元宝！',award = {[3] = {{640,5,1},},}},
	},
	afight = {		-- 匿名战场
		[1] = {title = "最完美玩家",content = '恭喜您在本次的匿名战场活动中获得积分最多，成为本场最完美玩家，获得5个金元宝！',award = {[3] = {{640,5,1},},}},
		[2] = {title = "最勇猛玩家",content = '恭喜您在本次的匿名战场活动中击杀玩家最多，成为本场最勇猛玩家，获得5个金元宝！',award = {[3] = {{640,5,1},},}},
		[3] = {title = "最幸运玩家",content = '恭喜您在本次的匿名战场活动中给予战场BOSS最后一击，成为本场最幸运玩家，获得5个金元宝！',award = {[3] = {{640,5,1},},}},
		[4] = {title = "最倒霉玩家",content = '因为您在本次的匿名战场活动中第一个将复活次数用完，成为本场最倒霉玩家，获得5个金元宝！',award = {[3] = {{640,5,1},},}},
	},
	LTMail = {			-- 竞技场相关邮件
		[1] = {title = "勋章",content = '由于您的背包已满，现将您刚才获得的#1个勋章发送给您，请注意收取附件！'},
	},
	storeMail = {			-- 商城代购
		[1] = {title = "商城购买道具",content = '您的好友#1为您购买了商城道具，请注意收取附件！'},
	},
	QSMail = {			-- 曲水流觞单日排行奖励
		[1] = {title = "活动积分排行奖励",content = '恭喜您在本次曲水流觞活动中获得第1名奖励,请注意收取附件！',award = {[3] = {{0,200000,1},},}},
		[2] = {title = "活动积分排行奖励",content = '恭喜您在本次曲水流觞活动中获得第2名奖励,请注意收取附件！',award = {[3] = {{0,150000,1},},}},
		[3] = {title = "活动积分排行奖励",content = '恭喜您在本次曲水流觞活动中获得第3名奖励,请注意收取附件！',award = {[3] = {{0,100000,1},},}},
		[4] = {title = "活动积分排行奖励",content = '恭喜您在本次曲水流觞活动中获得第4-10名奖励,请注意收取附件！',award = {[3] = {{0,50000,1},},}},
	},
	WQMail = {			-- 温泉单日排行奖励
		[1] = {title = "活动积分排行奖励",content = '恭喜您在本次温泉活动中获得第1名奖励,请注意收取附件！',award = {[3] = {{0,200000,1},},}},
		[2] = {title = "活动积分排行奖励",content = '恭喜您在本次温泉活动中获得第2名奖励,请注意收取附件！',award = {[3] = {{0,150000,1},},}},
		[3] = {title = "活动积分排行奖励",content = '恭喜您在本次温泉活动中获得第3名奖励,请注意收取附件！',award = {[3] = {{0,100000,1},},}},
		[4] = {title = "活动积分排行奖励",content = '恭喜您在本次温泉活动中获得第4-10名奖励,请注意收取附件！',award = {[3] = {{0,50000,1},},}},
	},
	YaJinMail = {		-- 帮会运镖押金
		[1] = {title = "帮会运镖押金返还",content = '恭喜您所在的帮会护送圆满成功！全额返还押金!'},	
		[2] = {title = "帮会运镖押金奖励",content = '恭喜您所在的帮会完成护送！获得额外奖励!'},
		[3] = {title = "帮会运镖押金返还",content = '合服押金返还!'},
	},
	Gambuchang = {		-- 法宝修改补偿
		[1] = {title = "法宝返礼",content = '亲爱的玩家，由于我们对法宝系统进行调整，降低了4阶5星以上法宝升级所需花费，你的法宝在调整前已达到#1阶#2星，比调整后升级到此阶多花费#3个先天之灵，现在对这部分先天之灵进行全额返还，请查收附件！'},	
	},
	Horsebuchang = {		-- 坐骑修改补偿
		[1] = {title = "坐骑返礼",content = '亲爱的玩家，由于我们对坐骑系统进行调整，降低了4阶6星以上坐骑升级所需花费，你的坐骑在调整前已达到#1阶#2星，比调整后升级到此阶多花费#3个坐骑进阶丹，现在对这部分坐骑进阶丹进行全额返还，请查收附件！'},	
	},
	Activetip = {		-- 跨服活动开启提示
		[1] = {title = "跨服活动开启公告",content = '亲爱的玩家，由于您所在服务器已开服7天，从今以后，天降宝箱将升级为跨服版！'},	
	},
	Kf1v1 = {		-- 跨服1v1补偿
		[1] = {title = "跨服1v1争霸赛补偿",content = '亲爱的玩家，由于跨服1v1争霸赛异常开启导致部分玩家王城争霸赛没有正常完成，给您带来的不便敬请见谅！我们特此补偿荣耀水晶*1000个。感谢你对《神创天 下》一直以来的支持！我们会努力做得更好。',award = {[3] = {{813,1000,1},},}},	
	},
	Kf1v1_over_award = {		-- 跨服1v1结束获取奖励
		[1] = {title = "跨服1v1结束获取奖励",content = '亲爱的玩家，您在本次竞赛的排名为第#1名，<font color="#baff7c" size="13">很遗憾晋级失败,请继续努力!</font>'},	
	},
	Kf1v1_over_award_jj = {		-- 跨服1v1结束获取奖励--晋级奖励
		[1] = {title = "跨服1v1结束获取奖励",content = '亲爱的玩家，您在本次竞赛的排名为第#1名，<font color="#baff7c" size="13">恭喜您成功晋级!</font>'},	
	},
	Kf1v1_quiz = {		-- 跨服1v1结束获取奖励
		[1] = {title = "跨服1v1获取竞猜奖励",content = '亲爱的玩家，恭喜你跨服1v1竞猜成功#1个名次,你将获取竞猜奖励'},	
	},
	Jysh_fruit = {   --果实成熟后邮件通知玩家
		[1] = {title = "果实成熟通知",content = '亲爱的玩家，恭喜你所种植的果树已经成熟请赶快摘取哟'},	
	},
	Jysh_buchang = {   --经验神树  补偿
		[1] = {title = "经验神树种植补偿",content = '亲爱的玩家，有由于服务器重启给您的神树种植收成带来的不便，在此我们特定补偿您应得的果实数量'},
	},
	Bsmz = {	
		[1] = {title = "宝石迷阵活动奖励",content = nil,
				award = {
					[1] = {[3] = {[1] = {0,2000000,1},},},
					[2] = {[3] = {[1] = {0,1000000,1},},},
					[3] = {[3] = {[1] = {0,500000,1},},},
					[4] = {[3] = {[1] = {0,200000,1},},},
				},
		},
	},
	Bsmzkill = {
		[1] = {title = "宝石迷阵击杀奖励",content = '恭喜你在宝石迷阵活动中给予BOSS最后一击，获得奖励铜币100万。\n',award = {[3] = {{0,1000000,1},},}},
	},
	Bbbz = {
		[1] = {title = "背包满了",content = '亲爱的玩家，由于您的包裹满了, 现将把获得物品发邮件给你, 请注意收取附件!'},	
	},
}