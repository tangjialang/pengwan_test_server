--[[
file:	Faction_System.lua
desc:	帮会系统功能
update:2013-7-1
refix:	done by xy
2014-8-21:add by sxj, update fBuild_conf.limit, add fBuild_conf[7], function update _upMainBuild()
]]--

--------------------------------------------------------------------------
--include:
local uv_TimesTypeTb = TimesTypeTb
local Faction_Fail = msgh_s2c_def[7][1]
local Faction_Build = msgh_s2c_def[7][4]
local Faction_Data = msgh_s2c_def[7][8]
local Faction_Buff = msgh_s2c_def[7][12]
local Faction_newJoin = msgh_s2c_def[7][15]
local Faction_SuccessJoin = msgh_s2c_def[7][18]
local Faction_ApplyResult = msgh_s2c_def[7][19]
local Faction_CityOwner = msgh_s2c_def[7][29]
local CI_GetPlayerData = CI_GetPlayerData
local SendLuaMsg = SendLuaMsg
local CheckCost = CheckCost
local CheckGoods = CheckGoods
local CI_CreateFaction = CI_CreateFaction
local CI_GetFactionInfo = CI_GetFactionInfo
local CheckTimes = CheckTimes
local CI_AddBuff = CI_AddBuff
local CI_GetMemberInfo = CI_GetMemberInfo
local CI_DeleteFaction = CI_DeleteFaction
local GetPlayerPoints = GetPlayerPoints
local AddPlayerPoints = AddPlayerPoints
local CI_GetFactionLeaderInfo = CI_GetFactionLeaderInfo
local GetServerTime = GetServerTime
local ReplaceFactionLeader = ReplaceFactionLeader
local CI_SetFactionInfo = CI_SetFactionInfo
local tostring = tostring
local db_module = require('Script.cext.dbrpc')
local GI_GetFactionID = db_module.get_faction_id
local GI_ApplyJoinFaction = db_module.apply_join_faction
local GI_DelApplyJoinFaction = db_module.delapply_join_faction
local GI_GetFHeaderLastLogin = db_module.get_fheader_lastlogin
local PI_PayPlayer = PI_PayPlayer
local define		= require('Script.cext.define')
local FACTION_BZ,FACTION_FBZ,FACTION_ZL,FACTION_XZ = define.FACTION_BZ,define.FACTION_FBZ,define.FACTION_ZL,define.FACTION_XZ
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos
local math_ceil = math.ceil
local math_floor = math.floor
local IsPlayerOnline = IsPlayerOnline
local CI_JoinFaction = CI_JoinFaction
local PI_GetPlayerName = PI_GetPlayerName
local PI_GetPlayerVipType = PI_GetPlayerVipType
local PI_GetPlayerLevel = PI_GetPlayerLevel
local PI_GetPlayerHeadID = PI_GetPlayerHeadID
local PI_SetPlayerFacID = PI_SetPlayerFacID
local define		= require('Script.cext.define')
local ProBarType = define.ProBarType
local table_locate = table.locate
local CI_LeaveFaction = CI_LeaveFaction
local time_cnt = require('Script.common.time_cnt')
local GetDiffDayFromTime = time_cnt.GetDiffDayFromTime
local os_date = os.date
local GetTimesInfo = GetTimesInfo
local bsmz = require ("Script.bsmz.bsmz_fun")
local bsmz_online = bsmz.bsmz_online
--------------------------------------------------------------------------
-- data:

--帮会配置
faction_conf = {
	create = {50,628},
	donate = {{682,20,20},{683,500,500}}, --道具、个人帮贡、帮会资金
	createlv = 30,
	union = 1000, --结盟费用
	clear = 500,--解盟费用
}

fBuild_conf = {
	soul = {1084,100,1,100}, --神兽喂养(道具、成长度上限、成长度增量、帮贡增量)
	yb = 10, --10分钟10元宝
	limit = {nil,2,1,4,3,1,5}, --建筑开启限制（主殿等级),除1外，其它不能为空
	[1] = {
		name = '帮会主殿',maxlv = 10, --名字、最高等级
		ico = 11,
		t = {20*60*60,24*60*60,30*60*60,38*60*60,48*60*60,60*60*60,74*60*60,90*60*60,108*60*60}, --CD时间
		m = {2000,4000,10000,20000,40000,100000,200000,400000,800000}, --花费帮会资金
		dec = '帮会主建筑，代表帮会等级。提升主殿等级，可以逐渐激活其他建筑，其它建筑不得高于主殿。',
	},
	[2] = {
		name = '帮贡商店',maxlv = 10, --limit 受主殿等级限制
		ico = 12,
		t = {3*60*60,6*60*60,10*60*60,15*60*60,21*60*60,28*60*60,36*60*60,45*60*60,55*60*60},
		m = {1000,2000,4000,10000,20000,40000,100000,200000,400000},
		dec = '帮贡商店等级越高，在帮贡商店中可以兑换到的东西越好。',
	},
	[3] = {
		name = '技能书院',maxlv = 10,
		ico = 13,
		t = {3*60*60,6*60*60,10*60*60,15*60*60,21*60*60,28*60*60,36*60*60,45*60*60,55*60*60},
		m = {500,1000,2000,5000,10000,20000,50000,100000,200000},
		dec = '技能书院等级越高，帮会成员能学习的帮会技能等级越高。',
	},
	[4] = {
		name = '神兽祭坛',maxlv = 10,
		ico = 14,
		t = {3*60*60,6*60*60,10*60*60,15*60*60,21*60*60,28*60*60,36*60*60,45*60*60,55*60*60},
		m = {1000,2000,4000,10000,20000,40000,100000,200000,400000},
		dec = '神兽祭坛等级越高，召唤神兽时，能选择的等级段越多。',
	},
	[5] = {
		name = '祈福大殿',maxlv = 10,
		ico = 15,
		t = {3*60*60,6*60*60,10*60*60,15*60*60,21*60*60,28*60*60,36*60*60,45*60*60,55*60*60},
		m = {1000,2000,4000,10000,20000,40000,100000,200000,400000},
		dec = '祈福大殿等级越高，每日帮会成员能进行帮会抽奖的次数越多。(次日生效)',
	},
	[6] = {
		name = '聚宝盆',maxlv = 10,
		ico = 16,
		t = {3*60*60,6*60*60,10*60*60,15*60*60,21*60*60,28*60*60,36*60*60,45*60*60,55*60*60},
		m = {500,1000,2000,5000,10000,20000,50000,100000,200000},
		dec = '聚宝盆等级越高，夺宝活动中发放的奖励越高。(次日生效)',
	},
	[7] = {
		name = '宝石迷阵',maxlv = 10,
		ico = 17,
		t = {20*60*60,24*60*60,30*60*60,38*60*60,48*60*60,60*60*60,74*60*60,90*60*60,108*60*60},
		m = {500000,1000000,1500000,2000000,2500000,3000000,3500000,4000000,5000000},
		dec = '迷阵建筑的等级越高，每日基础步数也会增加',
	},
}

--机器人帮会配置
fAuto_conf = {
	maxnum = 2, --最大可创建机器人帮会数
	fnum = 30, --帮会数限制（达到超过，不创建机器人帮会）
	wlv = 0, --世界等级限制(当前低于配置，不创建机器人帮会）
	num	= 20, --达到转让的人数(不得大于30)
	[1]={n='渡缘刹',h='向德辉',lv=34,sex=1,head=0,vip=4,school=1},
	[2]={n='两仪宗',h='权星汉',lv=36,sex=1,head=0,vip=4,school=2},
	[3]={n='天蚕族',h='柳德馨',lv=37,sex=0,head=0,vip=4,school=3},
	[4]={n='飞雪山',h='融文林',lv=34,sex=0,head=0,vip=4,school=1},
	[5]={n='白月涯',h='养修能',lv=36,sex=0,head=0,vip=4,school=2},
	[6]={n='龙王狱',h='左弘深',lv=37,sex=1,head=0,vip=4,school=3},
	[7]={n='翔鹰庵',h='尹天材',lv=34,sex=1,head=0,vip=4,school=1},
	[8]={n='爆炎城',h='苍弘厚',lv=36,sex=1,head=0,vip=4,school=2},
	[9]={n='噬魂书院',h='滕俊迈',lv=37,sex=0,head=0,vip=4,school=3},
	[10]={n='艮山帮',h='皇甫安志',lv=34,sex=0,head=0,vip=4,school=1},
	[11]={n='虎爪庵',h='宿建树',lv=36,sex=0,head=0,vip=4,school=2},
	[12]={n='青霞府',h='慕容鸿信',lv=37,sex=1,head=0,vip=4,school=3},
	[13]={n='断龙世家',h='亓官雪松',lv=34,sex=1,head=0,vip=4,school=1},
	[14]={n='狂涛宫',h='满涵煦',lv=36,sex=1,head=0,vip=4,school=2},
	[15]={n='天浪派',h='俞鸿风',lv=37,sex=0,head=0,vip=4,school=3},
	[16]={n='翔龙界',h='岑宏伟',lv=34,sex=0,head=0,vip=4,school=1},
	[17]={n='梅花坊',h='赖宾白',lv=36,sex=0,head=0,vip=4,school=2},
	[18]={n='虎凤舍',h='禄凯旋',lv=37,sex=1,head=0,vip=4,school=3},
	[19]={n='离恨斋',h='乐涵容',lv=34,sex=1,head=0,vip=4,school=1},
	[20]={n='活杀',h='南门明杰',lv=36,sex=1,head=0,vip=4,school=2},
	[21]={n='北斗神教',h='空阳羽',lv=37,sex=0,head=0,vip=4,school=3},
	[22]={n='半月寺',h='司徒庆生',lv=34,sex=0,head=0,vip=4,school=1},
	[23]={n='天仙党',h='桓阳秋',lv=36,sex=0,head=0,vip=4,school=2},
	[24]={n='地狱楼',h='莫雨华',lv=37,sex=1,head=0,vip=4,school=3},
	[25]={n='问心庙',h='岳帅志文',lv=34,sex=1,head=0,vip=4,school=1},
	[26]={n='千仞厦',h='燕弘图',lv=36,sex=1,head=0,vip=4,school=2},
	[27]={n='点星岛',h='熊宇荫',lv=37,sex=0,head=0,vip=4,school=3},
	[28]={n='傲世庵',h='刘阳舒',lv=34,sex=0,head=0,vip=4,school=1},
	[29]={n='风火会',h='曹皓轩',lv=36,sex=0,head=0,vip=4,school=2},
	[30]={n='爆碎阁',h='管嘉懿',lv=37,sex=1,head=0,vip=4,school=3},
	[31]={n='夺魂会',h='路雅昶',lv=34,sex=1,head=0,vip=4,school=1},
	[32]={n='天残氏',h='宰乐安',lv=36,sex=1,head=0,vip=4,school=2},
	[33]={n='赤星角',h='弘锐泽',lv=37,sex=0,head=0,vip=4,school=3},
	[34]={n='疾风会',h='康蕴和',lv=34,sex=0,head=0,vip=4,school=1},
	[35]={n='金凤居',h='訾坚白',lv=36,sex=0,head=0,vip=4,school=2},
	[36]={n='狂浪府',h='魏光亮',lv=37,sex=1,head=0,vip=4,school=3},
	[37]={n='金虹苑',h='屈良俊',lv=34,sex=1,head=0,vip=4,school=1},
	[38]={n='离魂殿',h='元天成',lv=36,sex=1,head=0,vip=4,school=2},
	[39]={n='罗汉岛',h='陆俊名',lv=37,sex=0,head=0,vip=4,school=3},
	[40]={n='金光殿',h='鲜于和正',lv=34,sex=0,head=0,vip=4,school=1},
	[41]={n='墨羽观',h='边溥心',lv=36,sex=0,head=0,vip=4,school=2},
	[42]={n='不二会',h='俟伟博',lv=37,sex=1,head=0,vip=4,school=3},
	[43]={n='白骨狱',h='荀元龙',lv=34,sex=1,head=0,vip=4,school=1},
	[44]={n='翠羽庙',h='井飞英',lv=36,sex=1,head=0,vip=4,school=2},
	[45]={n='圣光祠',h='宿朋兴',lv=37,sex=0,head=0,vip=4,school=3},
	[46]={n='相思峰',h='富永怡',lv=34,sex=0,head=0,vip=4,school=1},
	[47]={n='云浪寺',h='慎开朗',lv=36,sex=0,head=0,vip=4,school=2},
	[48]={n='罗汉殿',h='印明志',lv=37,sex=1,head=0,vip=4,school=3},
	[49]={n='绝叫殿',h='舒鹏飞',lv=34,sex=1,head=0,vip=4,school=1},
	[50]={n='溷元山',h='班泰河',lv=36,sex=1,head=0,vip=4,school=2},
	[51]={n='至高府',h='车康胜',lv=37,sex=0,head=0,vip=4,school=3},
	[52]={n='紫羽楼',h='郏嘉禧',lv=34,sex=0,head=0,vip=4,school=1},
	[53]={n='金羽氏',h='相欣然',lv=36,sex=0,head=0,vip=4,school=2},
	[54]={n='南无厦',h='翟明俊',lv=37,sex=1,head=0,vip=4,school=3},
	[55]={n='花蝶岛',h='危光亮',lv=34,sex=1,head=0,vip=4,school=1},
	[56]={n='赤盖坊',h='白温茂',lv=36,sex=1,head=0,vip=4,school=2},
	[57]={n='慾天山庄',h='莘高谊',lv=37,sex=0,head=0,vip=4,school=3},
	[58]={n='血雨宗',h='屠鸿志',lv=34,sex=0,head=0,vip=4,school=1},
	[59]={n='弥勒宇',h='许成周',lv=36,sex=0,head=0,vip=4,school=2},
	[60]={n='无上宫',h='纪元青',lv=37,sex=1,head=0,vip=4,school=3},
	[61]={n='终极教',h='章翰池',lv=34,sex=1,head=0,vip=4,school=1},
	[62]={n='悲问组',h='郝聪健',lv=36,sex=1,head=0,vip=4,school=2},
	[63]={n='暗鸦坞',h='束翰采',lv=37,sex=0,head=0,vip=4,school=3},
	[64]={n='兽心厦',h='奚天赋',lv=34,sex=0,head=0,vip=4,school=1},
	[65]={n='惊虹观',h='子车飞跃',lv=36,sex=0,head=0,vip=4,school=2},
	[66]={n='月皇派',h='乌俊楚',lv=37,sex=1,head=0,vip=4,school=3},
	[67]={n='玄雾祠',h='刘阳泽',lv=34,sex=1,head=0,vip=4,school=1},
	[68]={n='血光峰',h='蓬鹏鹍',lv=36,sex=1,head=0,vip=4,school=2},
	[69]={n='慈航派',h='澹台彬郁',lv=37,sex=0,head=0,vip=4,school=3},
	[70]={n='罗刹府',h='晏祺瑞',lv=34,sex=0,head=0,vip=4,school=1},
	[71]={n='湿婆教',h='通君昊',lv=36,sex=0,head=0,vip=4,school=2},
	[72]={n='擎雷房',h='邴智鑫',lv=37,sex=1,head=0,vip=4,school=3},
	[73]={n='乾天门',h='潘嘉熙',lv=34,sex=1,head=0,vip=4,school=1},
	[74]={n='极上殿',h='柳嘉誉',lv=36,sex=1,head=0,vip=4,school=2},
	[75]={n='墨霜剑派',h='慕容德厚',lv=37,sex=0,head=0,vip=4,school=3},
	[76]={n='问情观',h='元阳飇',lv=34,sex=0,head=0,vip=4,school=1},
	[77]={n='绝命岛',h='白昊穹',lv=36,sex=0,head=0,vip=4,school=2},
	[78]={n='真龙派',h='子车敏才',lv=37,sex=1,head=0,vip=4,school=3},
	[79]={n='天王塔',h='潘天华',lv=34,sex=1,head=0,vip=4,school=1},
	[80]={n='琉光角',h='干高峻',lv=36,sex=1,head=0,vip=4,school=2},
	[81]={n='拂柳组',h='荆锐志',lv=37,sex=0,head=0,vip=4,school=3},
	[82]={n='闇炎组',h='贲鸿才',lv=34,sex=0,head=0,vip=4,school=1},
	[83]={n='天命教',h='冉元驹',lv=36,sex=0,head=0,vip=4,school=2},
	[84]={n='明心塔',h='卫景同',lv=37,sex=1,head=0,vip=4,school=3},
	[85]={n='尖锋岛',h='房自珍',lv=34,sex=1,head=0,vip=4,school=1},
	[86]={n='菩萨角',h='阙嘉誉',lv=36,sex=1,head=0,vip=4,school=2},
	[87]={n='极上山',h='顾高兴',lv=37,sex=0,head=0,vip=4,school=3},
	[88]={n='水云堂',h='相博容',lv=34,sex=0,head=0,vip=4,school=1},
	[89]={n='狂浪城',h='妫海宏旷',lv=36,sex=0,head=0,vip=4,school=2},
	[90]={n='光龙斋',h='索和雅',lv=37,sex=1,head=0,vip=4,school=3},
	[91]={n='问世楼',h='禹玉树',lv=34,sex=1,head=0,vip=4,school=1},
	[92]={n='狂涛会',h='鲁鹏飞',lv=36,sex=1,head=0,vip=4,school=2},
	[93]={n='地煞房',h='牧凯歌',lv=37,sex=0,head=0,vip=4,school=3},
	[94]={n='八卦客栈',h='向伟泽',lv=34,sex=0,head=0,vip=4,school=1},
	[95]={n='凶魔刹',h='吉嘉运',lv=36,sex=0,head=0,vip=4,school=2},
	[96]={n='真武刹',h='赖俊发',lv=37,sex=1,head=0,vip=4,school=3},
	[97]={n='钢翼帮',h='席俊贤',lv=34,sex=1,head=0,vip=4,school=1},
	[98]={n='伏羲居',h='殳鸿涛',lv=36,sex=1,head=0,vip=4,school=2},
	[99]={n='醉梦岛',h='嵇安宁',lv=37,sex=0,head=0,vip=4,school=3},
	[100]={n='无影谷',h='伊信瑞',lv=34,sex=0,head=0,vip=4,school=1},
	[101]={n='毒蛇府',h='有琴天华',lv=36,sex=0,head=0,vip=4,school=2},
	[102]={n='玉女教',h='汝鄢翰翮',lv=37,sex=1,head=0,vip=4,school=3},
	[103]={n='暗黑道',h='皮天骄',lv=34,sex=1,head=0,vip=4,school=1},
	[104]={n='天罡山庄',h='公冶雅畅',lv=36,sex=1,head=0,vip=4,school=2},
	[105]={n='赤雷塔',h='经弘文',lv=37,sex=0,head=0,vip=4,school=3},
	[106]={n='无极苑',h='廉雅逸',lv=34,sex=0,head=0,vip=4,school=1},
	[107]={n='飞羽派',h='阙高芬',lv=36,sex=0,head=0,vip=4,school=2},
	[108]={n='邪风厦',h='寿博厚',lv=37,sex=1,head=0,vip=4,school=3},
	[109]={n='天狗阙',h='通光济',lv=34,sex=1,head=0,vip=4,school=1},
	[110]={n='飞龙房',h='黄乐游',lv=36,sex=1,head=0,vip=4,school=2},
	[111]={n='落枫党',h='伏同化',lv=37,sex=0,head=0,vip=4,school=3},
	[112]={n='离火岛',h='段干波涛',lv=34,sex=0,head=0,vip=4,school=1},
	[113]={n='观音宫',h='茹永年',lv=36,sex=0,head=0,vip=4,school=2},
	[114]={n='飞羽村',h='璩兴发',lv=37,sex=1,head=0,vip=4,school=3},
	[115]={n='墨羽榭',h='谈泰华',lv=34,sex=1,head=0,vip=4,school=1},
	[116]={n='元始阙',h='钭星津',lv=36,sex=1,head=0,vip=4,school=2},
	[117]={n='血龙狱',h='南门温文',lv=37,sex=0,head=0,vip=4,school=3},
	[118]={n='封神府',h='徐德元',lv=34,sex=0,head=0,vip=4,school=1},
	[119]={n='世尊岛',h='充雨伯',lv=36,sex=0,head=0,vip=4,school=2},
	[120]={n='金虎角',h='姬锐智',lv=37,sex=1,head=0,vip=4,school=3},
	[121]={n='玄羽客栈',h='阮子墨',lv=34,sex=1,head=0,vip=4,school=1},
	[122]={n='无华道',h='粱君昊',lv=36,sex=1,head=0,vip=4,school=2},
	[123]={n='无影世家',h='司雨石',lv=37,sex=0,head=0,vip=4,school=3},
	[124]={n='阿含舫',h='裘博涛',lv=34,sex=0,head=0,vip=4,school=1},
	[125]={n='冲霄苑',h='莫兴为',lv=36,sex=0,head=0,vip=4,school=2},
	[126]={n='无限族',h='益建白',lv=37,sex=1,head=0,vip=4,school=3},
	[127]={n='天地庵',h='齐乐欣',lv=34,sex=1,head=0,vip=4,school=1},
	[128]={n='无定庵',h='詹嘉珍',lv=36,sex=1,head=0,vip=4,school=2},
	[129]={n='童子世家',h='戚向笛',lv=37,sex=0,head=0,vip=4,school=3},
	[130]={n='邪月世家',h='尹俊美',lv=34,sex=0,head=0,vip=4,school=1},
	[131]={n='钢骨刹',h='焦伟诚',lv=36,sex=0,head=0,vip=4,school=2},
	[132]={n='遮那帮',h='濮阳新霁',lv=37,sex=1,head=0,vip=4,school=3},
	[133]={n='闇炎剑派',h='穆安怡',lv=34,sex=1,head=0,vip=4,school=1},
	[134]={n='惊天坊',h='汪嘉良',lv=36,sex=1,head=0,vip=4,school=2},
	[135]={n='银光庵',h='常金鑫',lv=37,sex=0,head=0,vip=4,school=3},
	[136]={n='金阳帮',h='禄高歌',lv=34,sex=0,head=0,vip=4,school=1},
	[137]={n='斩铁派',h='康乐欣',lv=36,sex=0,head=0,vip=4,school=2},
	[138]={n='斩铁宇',h='董浩荡',lv=37,sex=1,head=0,vip=4,school=3},
	[139]={n='陨日阁',h='甘和豫',lv=34,sex=1,head=0,vip=4,school=1},
	[140]={n='金胎居',h='虞智渊',lv=36,sex=1,head=0,vip=4,school=2},
	[141]={n='雷风角',h='傅鸿禧',lv=37,sex=0,head=0,vip=4,school=3},
	[142]={n='涅槃峰',h='劳德寿',lv=34,sex=0,head=0,vip=4,school=1},
	[143]={n='白月客栈',h='胥作人',lv=36,sex=0,head=0,vip=4,school=2},
	[144]={n='蚀精庙',h='汪博文',lv=37,sex=1,head=0,vip=4,school=3},
	[145]={n='擎天狱',h='谷粱志业',lv=34,sex=1,head=0,vip=4,school=1},
	[146]={n='天照道',h='贲建柏',lv=36,sex=1,head=0,vip=4,school=2},
	[147]={n='月皇社',h='司寇华灿',lv=37,sex=0,head=0,vip=4,school=3},
	[148]={n='无涯圣殿',h='那宜年',lv=34,sex=0,head=0,vip=4,school=1},
	[149]={n='紫虹府',h='谷粱英发',lv=36,sex=0,head=0,vip=4,school=2},
	[150]={n='生死观',h='熊英博',lv=37,sex=1,head=0,vip=4,school=3},
	[151]={n='巨鲨院',h='太叔锐阵',lv=34,sex=1,head=0,vip=4,school=1},
	[152]={n='斩龙楼',h='寿乐逸',lv=36,sex=1,head=0,vip=4,school=2},
	[153]={n='皇极居',h='方玉山',lv=37,sex=0,head=0,vip=4,school=3},
	[154]={n='狼牙舍',h='焦鸿羲',lv=34,sex=0,head=0,vip=4,school=1},
	[155]={n='地狱道',h='巩康适',lv=36,sex=0,head=0,vip=4,school=2},
	[156]={n='灵霄角',h='滕华皓',lv=37,sex=1,head=0,vip=4,school=3},
	[157]={n='红莲圣殿',h='干康泰',lv=34,sex=1,head=0,vip=4,school=1},
	[158]={n='极上刹',h='权成弘',lv=36,sex=1,head=0,vip=4,school=2},
	[159]={n='碎星旗',h='禹正浩',lv=37,sex=0,head=0,vip=4,school=3},
	[160]={n='斩情狱',h='林光霁',lv=34,sex=0,head=0,vip=4,school=1},
	[161]={n='百变门',h='阚心水',lv=36,sex=0,head=0,vip=4,school=2},
	[162]={n='般若斋',h='濮阳昊乾',lv=37,sex=1,head=0,vip=4,school=3},
	[163]={n='赤虹殿',h='东方雅健',lv=34,sex=1,head=0,vip=4,school=1},
	[164]={n='掩月庵',h='师承恩',lv=36,sex=1,head=0,vip=4,school=2},
	[165]={n='无上庙',h='陶良俊',lv=37,sex=0,head=0,vip=4,school=3},
	[166]={n='洗髓坊',h='澹台和泽',lv=34,sex=0,head=0,vip=4,school=1},
	[167]={n='紫焰门',h='强勇锐',lv=36,sex=0,head=0,vip=4,school=2},
	[168]={n='天蛛教',h='包君昊',lv=37,sex=1,head=0,vip=4,school=3},
	[169]={n='红莲阁',h='有琴嘉良',lv=34,sex=1,head=0,vip=4,school=1},
	[170]={n='血云榭',h='申景福',lv=36,sex=1,head=0,vip=4,school=2},
	[171]={n='湿婆狱',h='毛元龙',lv=37,sex=0,head=0,vip=4,school=3},
	[172]={n='飞云岛',h='利成双',lv=34,sex=0,head=0,vip=4,school=1},
	[173]={n='销魂谷',h='钭阳羽',lv=36,sex=0,head=0,vip=4,school=2},
	[174]={n='溷元旗',h='全天工',lv=37,sex=1,head=0,vip=4,school=3},
	[175]={n='天凤阁',h='莘勇毅',lv=34,sex=1,head=0,vip=4,school=1},
	[176]={n='悟禅厦',h='公天和',lv=36,sex=1,head=0,vip=4,school=2},
	[177]={n='追风寨',h='奚宏胜',lv=37,sex=0,head=0,vip=4,school=3},
	[178]={n='灵鹤谷',h='邓雪峰',lv=34,sex=0,head=0,vip=4,school=1},
	[179]={n='邪光堡',h='嵇波鸿',lv=36,sex=0,head=0,vip=4,school=2},
	[180]={n='玄阴陵',h='巫翰飞',lv=37,sex=1,head=0,vip=4,school=3},
	[181]={n='太极派',h='尹温韦',lv=34,sex=1,head=0,vip=4,school=1},
	[182]={n='游鱼庵',h='百里阳曜',lv=36,sex=1,head=0,vip=4,school=2},
	[183]={n='血焰派',h='方明远',lv=37,sex=0,head=0,vip=4,school=3},
	[184]={n='奇木剑派',h='危伟祺',lv=34,sex=0,head=0,vip=4,school=1},
	[185]={n='屠神房',h='束元勋',lv=36,sex=0,head=0,vip=4,school=2},
	[186]={n='空蝉教',h='施 承运',lv=37,sex=1,head=0,vip=4,school=3},
	[187]={n='圣火楼',h='那睿博',lv=34,sex=1,head=0,vip=4,school=1},
	[188]={n='天罡谷',h='吕浩壤',lv=36,sex=1,head=0,vip=4,school=2},
	[189]={n='暗锏陵',h='尤华辉',lv=37,sex=0,head=0,vip=4,school=3},
	[190]={n='墨羽院',h='柴志新',lv=34,sex=0,head=0,vip=4,school=1},
	[191]={n='残阳涯',h='朱正文',lv=36,sex=0,head=0,vip=4,school=2},
	[192]={n='天武祠',h='通雪峰',lv=37,sex=1,head=0,vip=4,school=3},
	[193]={n='森罗长',h='闫法景铄',lv=34,sex=1,head=0,vip=4,school=1},
	[194]={n='神梦房',h='黎越泽',lv=36,sex=1,head=0,vip=4,school=2},
	[195]={n='仁王榭',h='谭俊楚',lv=37,sex=0,head=0,vip=4,school=3},
	[196]={n='真龙榭',h='茹光启',lv=34,sex=0,head=0,vip=4,school=1},
	[197]={n='大乘氏',h='贲泰清',lv=36,sex=0,head=0,vip=4,school=2},
	[198]={n='狂龙世家',h='南门兴生',lv=37,sex=1,head=0,vip=4,school=3},
	[199]={n='准提剑派',h='甄兴邦',lv=34,sex=1,head=0,vip=4,school=1},
	[200]={n='定卐禅',h='田泰河',lv=36,sex=1,head=0,vip=4,school=2},
	[201]={n='玄雾旗',h='扈嘉祥',lv=37,sex=0,head=0,vip=4,school=3},
	[202]={n='洗髓亭',h='向昂雄',lv=34,sex=0,head=0,vip=4,school=1},
	[203]={n='白雾观',h='卫高雅',lv=36,sex=0,head=0,vip=4,school=2},
	[204]={n='血虹堡',h='皇甫鑫磊',lv=37,sex=1,head=0,vip=4,school=3},
	[205]={n='碧霞狱',h='袁嘉运',lv=34,sex=1,head=0,vip=4,school=1},
	[206]={n='锁心陵',h='卫冠玉',lv=36,sex=1,head=0,vip=4,school=2},
	[207]={n='银翼山庄',h='燕经略',lv=37,sex=0,head=0,vip=4,school=3},
	[208]={n='夺命斋',h='东奇文',lv=34,sex=0,head=0,vip=4,school=1},
	[209]={n='金凤社',h='向彬炳',lv=36,sex=0,head=0,vip=4,school=2},
	[210]={n='七星苑',h='端木咏思',lv=37,sex=1,head=0,vip=4,school=3},
	[211]={n='天元书院',h='充新翰',lv=34,sex=1,head=0,vip=4,school=1},
	[212]={n='梵天岛',h='束英博',lv=36,sex=1,head=0,vip=4,school=2},
	[213]={n='电网阙',h='隗力言',lv=37,sex=0,head=0,vip=4,school=3},
	[214]={n='虎尾宗',h='干元忠',lv=34,sex=0,head=0,vip=4,school=1},
	[215]={n='天仙亭',h='韩德厚',lv=36,sex=0,head=0,vip=4,school=2},
	[216]={n='血虹坞',h='孙修然',lv=37,sex=1,head=0,vip=4,school=3},
	[217]={n='天马斋',h='郏恺歌',lv=34,sex=1,head=0,vip=4,school=1},
	[218]={n='风霜阙',h='顾奇略',lv=36,sex=1,head=0,vip=4,school=2},
	[219]={n='冲虚房',h='舒玉韵',lv=37,sex=0,head=0,vip=4,school=3},
	[220]={n='风云宗',h='栾意蕴',lv=34,sex=0,head=0,vip=4,school=1},
	[221]={n='翔鹰坊',h='佘佴和畅',lv=36,sex=0,head=0,vip=4,school=2},
	[222]={n='焚天涯',h='时敏智',lv=37,sex=1,head=0,vip=4,school=3},
	[223]={n='碧落岛',h='亓官明诚',lv=34,sex=1,head=0,vip=4,school=1},
	[224]={n='惊卐情',h='曾天骄',lv=36,sex=1,head=0,vip=4,school=2},
	[225]={n='无量斋',h='钱锐逸',lv=37,sex=0,head=0,vip=4,school=3},
	[226]={n='菩提亭',h='牧俊友',lv=34,sex=0,head=0,vip=4,school=1},
	[227]={n='渡缘堡',h='孙勇锐',lv=36,sex=0,head=0,vip=4,school=2},
	[228]={n='佛光山庄',h='卓修永',lv=37,sex=1,head=0,vip=4,school=3},
	[229]={n='伏羲殿',h='红安国',lv=34,sex=1,head=0,vip=4,school=1},
	[230]={n='千鸟坞',h='璩元武',lv=36,sex=1,head=0,vip=4,school=2},
	[231]={n='寒冰党',h='年爱博艺',lv=37,sex=0,head=0,vip=4,school=3},
	[232]={n='阴风会',h='施承业',lv=34,sex=0,head=0,vip=4,school=1},
	[233]={n='屠神塔',h='上官星火',lv=36,sex=0,head=0,vip=4,school=2},
	[234]={n='豹爪书院',h='章烨华',lv=37,sex=1,head=0,vip=4,school=3},
	[235]={n='墨羽族',h='欧阳修齐',lv=34,sex=1,head=0,vip=4,school=1},
	[236]={n='虎☆长',h='浦建德',lv=36,sex=1,head=0,vip=4,school=2},
	[237]={n='紫霜坊',h='仰星光',lv=37,sex=0,head=0,vip=4,school=3},
	[238]={n='飞鱼神教',h='蔡俊力',lv=34,sex=0,head=0,vip=4,school=1},
	[239]={n='掩日长',h='干翔宇',lv=36,sex=0,head=0,vip=4,school=2},
	[240]={n='寒鸦狱',h='臧俊爽',lv=37,sex=1,head=0,vip=4,school=3},
	[241]={n='圣儒楼',h='佘佴鹏翼',lv=34,sex=1,head=0,vip=4,school=1},
	[242]={n='凄煌门',h='路伟毅',lv=36,sex=1,head=0,vip=4,school=2},
	[243]={n='天王涯',h='封欣悦',lv=37,sex=0,head=0,vip=4,school=3},
	[244]={n='十方庵',h='毕英才',lv=34,sex=0,head=0,vip=4,school=1},
	[245]={n='霸皇谷',h='宫鸿达',lv=36,sex=0,head=0,vip=4,school=2},
	[246]={n='镜月堂',h='刘嘉誉',lv=37,sex=1,head=0,vip=4,school=3},
	[247]={n='玄霜派',h='慕容博达',lv=34,sex=1,head=0,vip=4,school=1},
	[248]={n='相思圣殿',h='轩辕康乐',lv=36,sex=1,head=0,vip=4,school=2},
	[249]={n='寒霜书院',h='裴鸿雪',lv=37,sex=0,head=0,vip=4,school=3},
	[250]={n='缘灭祠',h='宗政玉成',lv=34,sex=0,head=0,vip=4,school=1},
	[251]={n='虚空殿',h='隆阳夏',lv=36,sex=0,head=0,vip=4,school=2},
	[252]={n='沧海组',h='闫法乐生',lv=37,sex=1,head=0,vip=4,school=3},
	[253]={n='碎骨斋',h='陆良弼',lv=34,sex=1,head=0,vip=4,school=1},
	[254]={n='钢翼旗',h='谢国豪',lv=36,sex=1,head=0,vip=4,school=2},
	[255]={n='极光宫',h='牧玉成',lv=37,sex=0,head=0,vip=4,school=3},
	[256]={n='千山馆',h='乐正俊健',lv=34,sex=0,head=0,vip=4,school=1},
	[257]={n='昭天圣殿',h='严开畅',lv=36,sex=0,head=0,vip=4,school=2},
	[258]={n='灵龙庵',h='米雅逸',lv=37,sex=1,head=0,vip=4,school=3},
	[259]={n='天元陵',h='宇文天工',lv=34,sex=1,head=0,vip=4,school=1},
	[260]={n='丹心寺',h='宣温瑜',lv=36,sex=1,head=0,vip=4,school=2},
	[261]={n='轮迴庙',h='叶烨磊',lv=37,sex=0,head=0,vip=4,school=3},
	[262]={n='玄冰观',h='越明旭',lv=34,sex=0,head=0,vip=4,school=1},
	[263]={n='菩提房',h='柯康复',lv=36,sex=0,head=0,vip=4,school=2},
	[264]={n='玄武居',h='姬乐咏',lv=37,sex=1,head=0,vip=4,school=3},
	[265]={n='雨霖教',h='祖烨赫',lv=34,sex=1,head=0,vip=4,school=1},
	[266]={n='双极陵',h='詹雨星',lv=36,sex=1,head=0,vip=4,school=2},
	[267]={n='逍遥阁',h='双英光',lv=37,sex=0,head=0,vip=4,school=3},
	[268]={n='阿鼻宇',h='谷俊悟',lv=34,sex=0,head=0,vip=4,school=1},
	[269]={n='问情神教',h='左英纵',lv=36,sex=0,head=0,vip=4,school=2},
	[270]={n='暗锏门',h='强文翰',lv=37,sex=1,head=0,vip=4,school=3},
	[271]={n='天极房',h='颛孙锐利',lv=34,sex=1,head=0,vip=4,school=1},
	[272]={n='白龙庵',h='都俊名',lv=36,sex=1,head=0,vip=4,school=2},
	[273]={n='悟禅坊',h='公冶元白',lv=37,sex=0,head=0,vip=4,school=3},
	[274]={n='狂尸界',h='阳佟锐意',lv=34,sex=0,head=0,vip=4,school=1},
	[275]={n='黄沙道',h='戎信鸿',lv=36,sex=0,head=0,vip=4,school=2},
	[276]={n='斩日派',h='毛茂勋',lv=37,sex=1,head=0,vip=4,school=3},
	[277]={n='两仪涯',h='卓雨泽',lv=34,sex=1,head=0,vip=4,school=1},
	[278]={n='玄霜观',h='台睿聪',lv=36,sex=1,head=0,vip=4,school=2},
	[279]={n='天地祠',h='应睿才',lv=37,sex=0,head=0,vip=4,school=3},
	[280]={n='离魂组',h='伯赏浩荡',lv=34,sex=0,head=0,vip=4,school=1},
	[281]={n='血魔书院',h='阳佟丰羽',lv=36,sex=0,head=0,vip=4,school=2},
	[282]={n='飞鹰寨',h='寇咏思',lv=37,sex=1,head=0,vip=4,school=3},
	[283]={n='梅花堂',h='微生和悌',lv=34,sex=1,head=0,vip=4,school=1},
	[284]={n='无垢客栈',h='瞿向笛',lv=36,sex=1,head=0,vip=4,school=2},
	[285]={n='至高府',h='郁远航',lv=37,sex=0,head=0,vip=4,school=3},
	[286]={n='星象厦',h='淳于泰和',lv=34,sex=0,head=0,vip=4,school=1},
	[287]={n='飞虎亭',h='潘睿明',lv=36,sex=0,head=0,vip=4,school=2},
	[288]={n='飞狐界',h='红鸿风',lv=37,sex=1,head=0,vip=4,school=3},
	[289]={n='风云斋',h='乌景山',lv=34,sex=1,head=0,vip=4,school=1},
	[290]={n='渡缘殿',h='怀浩穰',lv=36,sex=1,head=0,vip=4,school=2},
	[291]={n='雷鸣旗',h='公修远',lv=37,sex=0,head=0,vip=4,school=3},
	[292]={n='天龙宫',h='文温纶',lv=34,sex=0,head=0,vip=4,school=1},
	[293]={n='幽幻居',h='周智勇',lv=36,sex=0,head=0,vip=4,school=2},
	[294]={n='白虎宇',h='司徒明珠',lv=37,sex=1,head=0,vip=4,school=3},
	[295]={n='活杀山',h='钭天宇',lv=34,sex=1,head=0,vip=4,school=1},
	[296]={n='至尊☆龙堡',h='封英卫',lv=36,sex=1,head=0,vip=4,school=2},
	[297]={n='罗汉寨',h='冉阳秋',lv=37,sex=0,head=0,vip=4,school=3},
	[298]={n='灵鹤馆',h='宓高谊',lv=34,sex=0,head=0,vip=4,school=1},
	[299]={n='菩提观',h='孙永寿',lv=36,sex=0,head=0,vip=4,school=2},
	[300]={n='龙牙圣殿',h='益文敏',lv=37,sex=1,head=0,vip=4,school=3},

}

---驻地配置
local zhudi_conf={
	enter={
		[1]={25,33},--面板进
		[2]={50,60},--活动进
	},
}
local mijing_conf={
	opentime = {1200,2400},--秘境开启时间
	box={monsterId = 126 ,eventScript=3 ,camp = 4,x=6,y=48,},--宝箱
	f_monster={ --秘境怪物配置
		[2]={monsterId = 123 ,BRMONSTER = 1, centerX = 41 , centerY = 36 , BRArea = 6 , BRNumber =8 , deadbody = 6 ,refreshTime =50, },--小怪
		[3]={monsterId = 124 ,BRMONSTER = 1, centerX = 41 , centerY = 36 , BRArea = 6 , BRNumber =1 , deadbody = 6 ,refreshTime =100, },--小怪
		[4]={monsterId = 123 ,BRMONSTER = 1, centerX = 38 , centerY = 12 , BRArea = 6 , BRNumber =8 , deadbody = 6 ,refreshTime =50, },--小怪
		[5]={monsterId = 124 ,BRMONSTER = 1, centerX = 38 , centerY = 12 , BRArea = 6 , BRNumber =1 , deadbody = 6 ,refreshTime =100, },--小怪
		[6]={monsterId = 123 ,BRMONSTER = 1, centerX = 16 , centerY = 28 , BRArea = 6 , BRNumber =8 , deadbody = 6 ,refreshTime =50, },--小怪
		[7]={monsterId = 124 ,BRMONSTER = 1, centerX = 16 , centerY = 28 , BRArea = 6 , BRNumber =1 , deadbody = 6 ,refreshTime =100, },--小怪
		[8]={monsterId = 123 ,BRMONSTER = 1, centerX = 11 , centerY = 51 , BRArea = 6 , BRNumber =8 , deadbody = 6 ,refreshTime =150, },--小怪
		[9]={monsterId = 124 ,BRMONSTER = 1, centerX = 11 , centerY = 51 , BRArea = 6 , BRNumber =2 , deadbody = 6 ,refreshTime =150, },--小怪
		[10]={monsterId = 125 ,x= 40 , y =7 ,},--水晶
		[11]={monsterId = 125 ,x= 34 , y =11 ,},--水晶
		[12]={monsterId = 125 ,x= 37 , y =17 ,},--水晶
		[13]={monsterId = 125 ,x= 43 , y =13 ,},--水晶
	},
	wlevel = {		-- 世界等级对怪物属性影响
		[30] = {
			[2] = {[1] = 24000 , [3] = 800,[4] = 800 , [5] = 1000,[6] = 400 , [7] = 400,[8] = 400 , [9] = 400, },
			[3] = {[1] = 48000 , [3] = 1500,[4] = 1500 , [5] = 2000,[6] = 700 , [7] = 700,[8] = 700 , [9] = 700,},
			[4] = {[1] = 24000 , [3] = 800,[4] = 800 , [5] = 1000,[6] = 400 , [7] = 400,[8] = 400 , [9] = 400, },
			[5] = {[1] = 48000 , [3] = 1500,[4] = 1500 , [5] = 2000,[6] = 700 , [7] = 700,[8] = 700 , [9] = 700,},
			[6] = {[1] = 24000 , [3] = 800,[4] = 800 , [5] = 1000,[6] = 400 , [7] = 400,[8] = 400 , [9] = 400, },
			[7] = {[1] = 48000 , [3] = 1500,[4] = 1500 , [5] = 2000,[6] = 700 , [7] = 700,[8] = 700 , [9] = 700,},
			[8] = {[1] = 24000 , [3] = 800,[4] = 800 , [5] = 1000,[6] = 400 , [7] = 400,[8] = 400 , [9] = 400, },
			[9] = {[1] = 48000 , [3] = 1500,[4] = 1500 , [5] = 2000,[6] = 700 , [7] = 700,[8] = 700 , [9] = 700,},
		},
		[40] = {
			[2] = {[1] = 38000 , [3] = 1300,[4] = 1300 , [5] = 2000,[6] = 600 , [7] = 600,[8] = 600 , [9] = 600,},
			[3] = {[1] = 80000 , [3] = 2600,[4] = 2600 , [5] = 3000,[6] = 1300 , [7] = 1300,[8] = 1300 , [9] = 1300, },
			[4] = {[1] = 38000 , [3] = 1300,[4] = 1300 , [5] = 2000,[6] = 600 , [7] = 600,[8] = 600 , [9] = 600,},
			[5] = {[1] = 80000 , [3] = 2600,[4] = 2600 , [5] = 3000,[6] = 1300 , [7] = 1300,[8] = 1300 , [9] = 1300, },
			[6] = {[1] = 38000 , [3] = 1300,[4] = 1300 , [5] = 2000,[6] = 600 , [7] = 600,[8] = 600 , [9] = 600,},
			[7] = {[1] = 80000 , [3] = 2600,[4] = 2600 , [5] = 3000,[6] = 1300 , [7] = 1300,[8] = 1300 , [9] = 1300, },
			[8] = {[1] = 38000 , [3] = 1300,[4] = 1300 , [5] = 2000,[6] = 600 , [7] = 600,[8] = 600 , [9] = 600,},
			[9] = {[1] = 80000 , [3] = 2600,[4] = 2600 , [5] = 3000,[6] = 1300 , [7] = 1300,[8] = 1300 , [9] = 1300, },			
		},
		[45] = {
			[2] = {[1] = 48000 , [3] = 1600,[4] = 1300 , [5] = 2500,[6] = 800 , [7] = 800,[8] = 800 , [9] = 800,},
			[3] = {[1] = 100000 , [3] = 3300,[4] = 3000 , [5] = 4000,[6] = 1600 , [7] = 1600,[8] = 1600 , [9] = 1600, },
		    [4] = {[1] = 48000 , [3] = 1600,[4] = 1300 , [5] = 2500,[6] = 800 , [7] = 800,[8] = 800 , [9] = 800,},
			[5] = {[1] = 100000 , [3] = 3300,[4] = 3000 , [5] = 4000,[6] = 1600 , [7] = 1600,[8] = 1600 , [9] = 1600, },
			[6] = {[1] = 48000 , [3] = 1600,[4] = 1300 , [5] = 2500,[6] = 800 , [7] = 800,[8] = 800 , [9] = 800,},
			[7] = {[1] = 100000 , [3] = 3300,[4] = 3000 , [5] = 4000,[6] = 1600 , [7] = 1600,[8] = 1600 , [9] = 1600, },
			[8] = {[1] = 48000 , [3] = 1600,[4] = 1300 , [5] = 2500,[6] = 800 , [7] = 800,[8] = 800 , [9] = 800,},
			[9] = {[1] = 100000 , [3] = 3300,[4] = 3000 , [5] = 4000,[6] = 1600 , [7] = 1600,[8] = 1600 , [9] = 1600, },
		},
		[50] = {
			[2] = {[1] = 56000 , [3] = 1900,[4] = 1600 , [5] = 2500,[6] = 950 , [7] = 950,[8] = 950 , [9] = 950,},
			[3] = {[1] = 120000 , [3] = 3900,[4] = 3200 , [5] = 4500,[6] = 3000 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[4] = {[1] = 56000 , [3] = 1900,[4] = 1600 , [5] = 2500,[6] = 950 , [7] = 950,[8] = 950 , [9] = 950,},
			[5] = {[1] = 120000 , [3] = 3900,[4] = 3200 , [5] = 4500,[6] = 3000 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[6] = {[1] = 56000 , [3] = 1900,[4] = 1600 , [5] = 2500,[6] = 950 , [7] = 950,[8] = 950 , [9] = 950,},
			[7] = {[1] = 120000 , [3] = 3900,[4] = 3200 , [5] = 4500,[6] = 3000 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[8] = {[1] = 56000 , [3] = 1900,[4] = 1600 , [5] = 2500,[6] = 950 , [7] = 950,[8] = 950 , [9] = 950,},
			[9] = {[1] = 120000 , [3] = 3900,[4] = 3200 , [5] = 4500,[6] = 3000 , [7] = 1800,[8] = 1800 , [9] = 1800, },
		},
		[55] = {
			[2] = {[1] = 60000 , [3] = 2400,[4] = 2000 , [5] = 3000,[6] = 1200 , [7] = 1200,[8] = 1200 , [9] = 1200, },
			[3] = {[1] = 130000 , [3] = 4800,[4] = 4000 , [5] = 5200,[6] = 2400 , [7] = 2400,[8] = 2400 , [9] = 2400, },
			[4] = {[1] = 60000 , [3] = 2400,[4] = 2000 , [5] = 3000,[6] = 1200 , [7] = 1200,[8] = 1200 , [9] = 1200, },
			[5] = {[1] = 130000 , [3] = 4800,[4] = 4000 , [5] = 5200,[6] = 2400 , [7] = 2400,[8] = 2400 , [9] = 2400, },
			[6] = {[1] = 60000 , [3] = 2400,[4] = 2000 , [5] = 3000,[6] = 1200 , [7] = 1200,[8] = 1200 , [9] = 1200, },
			[7] = {[1] = 130000 , [3] = 4800,[4] = 4000 , [5] = 5200,[6] = 2400 , [7] = 2400,[8] = 2400 , [9] = 2400, },
			[8] = {[1] = 60000 , [3] = 2400,[4] = 2000 , [5] = 3000,[6] = 1200 , [7] = 1200,[8] = 1200 , [9] = 1200, },
			[9] = {[1] = 130000 , [3] = 4800,[4] = 4000 , [5] = 5200,[6] = 2400 , [7] = 2400,[8] = 2400 , [9] = 2400, },
		},
		[60] = {
			[2] = {[1] = 70000 , [3] = 2700,[4] = 2300 , [5] = 3500,[6] = 1800 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[3] = {[1] = 140000 , [3] = 5500,[4] = 4800 , [5] = 6000,[6] = 2700 , [7] = 2700,[8] = 2700 , [9] = 2700, },
			[4] = {[1] = 70000 , [3] = 2700,[4] = 2300 , [5] = 3500,[6] = 1800 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[5] = {[1] = 140000 , [3] = 5500,[4] = 4800 , [5] = 6000,[6] = 2700 , [7] = 2700,[8] = 2700 , [9] = 2700, },
			[6] = {[1] = 70000 , [3] = 2700,[4] = 2300 , [5] = 3500,[6] = 1800 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[7] = {[1] = 140000 , [3] = 5500,[4] = 4800 , [5] = 6000,[6] = 2700 , [7] = 2700,[8] = 2700 , [9] = 2700, },
			[8] = {[1] = 70000 , [3] = 2700,[4] = 2300 , [5] = 3500,[6] = 1800 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[9] = {[1] = 140000 , [3] = 5500,[4] = 4800 , [5] = 6000,[6] = 2700 , [7] = 2700,[8] = 2700 , [9] = 2700, },
		},
		[65] = {
			[2] = {[1] = 80000 , [3] = 3300,[4] = 2800 , [5] = 4000,[6] = 1600 , [7] = 1600,[8] = 1600 , [9] = 1600, },
			[3] = {[1] = 160000 , [3] = 6600,[4] = 6000 , [5] = 7000,[6] = 3300 , [7] = 3300,[8] = 3300 , [9] = 3300, },
			[4] = {[1] = 80000 , [3] = 3300,[4] = 2800 , [5] = 4000,[6] = 1600 , [7] = 1600,[8] = 1600 , [9] = 1600, },
			[5] = {[1] = 160000 , [3] = 6600,[4] = 6000 , [5] = 7000,[6] = 3300 , [7] = 3300,[8] = 3300 , [9] = 3300, },
			[6] = {[1] = 80000 , [3] = 3300,[4] = 2800 , [5] = 4000,[6] = 1600 , [7] = 1600,[8] = 1600 , [9] = 1600, },
			[7] = {[1] = 160000 , [3] = 6600,[4] = 6000 , [5] = 7000,[6] = 3300 , [7] = 3300,[8] = 3300 , [9] = 3300, },
			[8] = {[1] = 80000 , [3] = 3300,[4] = 2800 , [5] = 4000,[6] = 1600 , [7] = 1600,[8] = 1600 , [9] = 1600, },
			[9] = {[1] = 160000 , [3] = 6600,[4] = 6000 , [5] = 7000,[6] = 3300 , [7] = 3300,[8] = 3300 , [9] = 3300, },
		},
		[70] = {
			[2] = {[1] = 100000 , [3] = 3700,[4] = 3000 , [5] = 4000,[6] = 1800 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[3] = {[1] = 310000 , [3] = 7400,[4] = 6500 , [5] = 8000,[6] = 3700 , [7] = 3700,[8] = 3700 , [9] = 3700, },
			[4] = {[1] = 100000 , [3] = 3700,[4] = 3000 , [5] = 4000,[6] = 1800 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[5] = {[1] = 310000 , [3] = 7400,[4] = 6500 , [5] = 8000,[6] = 3700 , [7] = 3700,[8] = 3700 , [9] = 3700, },
			[6] = {[1] = 100000 , [3] = 3700,[4] = 3000 , [5] = 4000,[6] = 1800 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[7] = {[1] = 310000 , [3] = 7400,[4] = 6500 , [5] = 8000,[6] = 3700 , [7] = 3700,[8] = 3700 , [9] = 3700, },
			[8] = {[1] = 100000 , [3] = 3700,[4] = 3000 , [5] = 4000,[6] = 1800 , [7] = 1800,[8] = 1800 , [9] = 1800, },
			[9] = {[1] = 310000 , [3] = 7400,[4] = 6500 , [5] = 8000,[6] = 3700 , [7] = 3700,[8] = 3700 , [9] = 3700, },
		},
	},
	award={--奖励,以帮会等级为key
		fmoney=100,--帮会资金
		fss=2,--神兽成长
		[1]={{601,10,1},{605,50,1},{615,3,1}},
		[2]={{601,10,1},{605,50,1},{615,3,1}},
		[3]={{601,10,1},{605,60,1},{615,3,1}},
		[4]={{601,10,1},{605,60,1},{615,3,1}},
		[5]={{601,10,1},{605,70,1},{615,3,1}},
		[6]={{601,10,1},{605,70,1},{615,3,1}},
		[7]={{601,10,1},{605,80,1},{615,3,1}},
		[8]={{601,10,1},{605,80,1},{615,3,1}},
		[9]={{601,10,1},{605,100,1},{615,3,1}},
		[10]={{601,10,1},{605,100,1},{615,3,1}},
	},
}

--获取个人帮会数据					  
local function get_faction_data(sid)
	local fdata=GI_GetPlayerData( sid , 'faction' , 250 )
	if fdata == nil then return end
	return fdata
end

--判断帮会名称是否和机器人帮会名字重名
local function _is_auto_faction_name(name)
	for _,v in pairs(fAuto_conf) do
		if(type(v) == type({}) and v.n~=nil and v.n == name)then
			return true
		end
	end
	return false
end

--主殿升级，同时判断是否激活其它建筑,注意：帮会创建时要调用（初始化主殿1级及其它相关建筑激活）
local function _upMainBuild()
	local lv = CI_GetFactionInfo(nil,2)
	local limit
	local buildLv
	--[[sxj,2014-08-21 update start]]-- 
	for i = 2,7 do	
		limit = fBuild_conf.limit[i]
		if i == 7 then
			buildLv = CI_GetFactionInfo(nil,12)		--强制置为12
		else	
			buildLv = CI_GetFactionInfo(nil,3+i)
		end
		if(limit~=nil and buildLv~=nil and buildLv == 0 and limit<=lv)then
			if i == 7 then
				CI_SetFactionInfo(nil,12,1)		--强制置为12
			else	
				CI_SetFactionInfo(nil,3+i,1)
			end	
		end
	end
	--[[sxj,2014-08-21 update end]]--
	
	--[[ older
	for i = 2,6 do
		limit = fBuild_conf.limit[i]
		buildLv = CI_GetFactionInfo(nil,3+i)
		if(limit~=nil and buildLv~=nil and buildLv == 0 and limit<=lv)then
			CI_SetFactionInfo(nil,3+i,1)
		end
	end
	]]--
end

--添加帮会资金
local function _factionMoneyAdd(addmoney,fid)
	local money 
	if fid ~= nil then
		money = CI_GetFactionInfo(fid,3)
	else
		money = CI_GetFactionInfo(nil,3)
	end
	if money == nil then
		return --未查到帮会
	end
	--look('money='..money)
	money = money + addmoney
	--look('money='..money)
	CI_SetFactionInfo(fid,3,money)
end

--获取帮会数据
function GetFactionData(fid)
	local hsid = CI_GetFactionLeaderInfo(fid,0)
	if(hsid == nil)then
		return 
	end

	if(__debug and nil==dbMgr.faction.data)then
		if __debug then 
			look(debug.traceback())
			look( "GetFactionData Error, fid:" .. tostring(fid) ) 
		end
	end
	
	if(dbMgr.faction.data == nil)then
		dbMgr.faction.data = {}
	end
	
	if(dbMgr.faction.data[fid] == nil)then 
		dbMgr.faction.data[fid] = {} 
	end
	
	if(dbMgr.faction.data[fid].soul == nil)then
		dbMgr.faction.data[fid].soul = {0} --{成长度、CD时间}
	end
	--[[
		slmax={2,name}--试炼副本最大关数记录,名字
	]]
	
	return dbMgr.faction.data[fid]
end

--帮会临时数据
function GetFactionTempData(fid)
	if(fid == nil)then return end
	if(__debug and nil==dbMgr.faction.temp)then
		if __debug then 
			look(debug.traceback())
			look( "GetFactionTempData Error, fid:" .. tostring(fid) ) 
		end
	end
	
	if(dbMgr.faction.temp == nil)then
		dbMgr.faction.temp = {}
	end
	
	if(dbMgr.faction.temp[fid] == nil)then 
		dbMgr.faction.temp[fid] = {} 
	end
	
	return dbMgr.faction.temp[fid]
end

--获取帮会数据
function GetFactionBootData()
	if(__debug and nil==dbMgr.faction.data)then
		if __debug then 
			look(debug.traceback())
			look( "GetFactionData Error, fid:" .. tostring(fid)) 
		end
	end
	
	if(dbMgr.faction.data == nil)then
		dbMgr.faction.data = {num = 0}
	end
	
	return dbMgr.faction.data
end

--清帮会战积分
function clear_ff_score()
	local data = GetFactionBootData()
	if(data~=nil)then
		for i,v in pairs(data) do
			if(type(i) == type(0) and type(v) == type({}))then
				v.f_score = nil
			end
		end
	end
end

--设置清周帮贡标识
function set_player_ff_week_sign(sid,bOnline)
	--[[
	--look('=================================================')
	if(bOnline~=nil)then
		look('bOnline = '..bOnline)
	else
		look('bOnline is nil')
	end
	]]--
	if(bOnline == 1)then
		local temp = GetPlayerTemp_custom(sid)
		if(temp ~= nil)then
			temp.ff_cls = 1
		end
	else
		local fid = CI_GetPlayerData(23)
		if fid == nil or fid == 0 then
			return
		end
		CI_SetMemberInfo(0,2)
	end
end

--清除个人周帮贡
function clear_player_ff_week(sid)
	local temp = GetPlayerTemp_custom(sid)
	if(temp~=nil and temp.ff_cls ~= nil)then
		temp.ff_cls = nil
		local fid = CI_GetPlayerData(23)
		if fid == nil or fid == 0 then
			return
		end
		CI_SetMemberInfo(0,2)
	end
end

-- 每日遍历帮会重置
function faction_eday_refresh()
	local data = GetFactionBootData()
	-- 开服后每两天恢复一次运镖次数
	local openTime = GetServerOpenTime()
	-- local now = GetServerTime()
	if type(data) == type({}) then
		for i,v in pairs(data) do
			if(type(i) == type(0) and type(v) == type({}))then
				-- 1、清理帮会战积分
				v.c_score = nil
				--清理帮会试炼副本数据
				v.slmax = nil

				-- 2、清理神兽数据
				if v.ss then ---追加,清神兽数据
					v.ss[2]=nil
				end
				-- 3、处理帮会运镖数据
				v.yunb = v.yunb or { [1] = 2, }		-- 初始化2次
				if v.yunb then
					local ybData = v.yunb
					ybData[2] = nil
					ybData[3] = nil
					-- ybData[4] = nil
					ybData[5] = nil
					ybData[6] = nil
					ybData[7] = nil
					ybData[8] = nil
					-- ybData[9] = nil
					ybData[10] = nil
					-- 恢复运镖次数(上限5次)
					-- if ybData[1] < 5 then
						-- local days = GetDiffDayFromTime(openTime)
						-- look('faction_eday_refresh:' .. tostring(days))
						-- if days > 0 and days % 2 == 0 then
							-- ybData[1] = (ybData[1] or 0) + 1
						-- end
					-- end
				end
			end
		end
	end
end

--发送帮会的lua保存数据
function SendFactionData(fid)
	if(fid~=nil)then
		local data = GetFactionData(fid)
		if(data~=nil)then
			--look(data[fid])
			GetFaction_ybData(fid)
			SendLuaMsg( 0, { ids = Faction_Data, data = data}, 9 )
		end
	end
end

--申请创建帮会
function CreateFaction_Apply(sid,name,checkID)
	if(type(name) ~= type(""))then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = 6}, 9 )
		return
	end
	
	if(_is_auto_faction_name(name))then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = -6}, 9 )
		return
	end

	local level=CI_GetPlayerData(1) --23帮会ID
	if(faction_conf.createlv>level)then --等级不足
		SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = 5}, 9 )
		return
	end
	
	if(checkID~=1 and checkID~=2)then
		SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = 2}, 9 )
		return
	end
	
	local creatData = faction_conf.create
	if(checkID == 1 and not CheckCost( sid , creatData[1],1,1 ))then --元宝不足
		SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = 3}, 9 )
		return
	elseif(checkID == 2 and CheckGoods(creatData[2],1,1,sid,'申请创建帮会')==0)then --道具不足
		SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = 4}, 9 )
		return
	end

	--向数据库请求一个新的帮派ID
	GI_GetFactionID(name,checkID)
end

--创建帮会返回新ID并创建
function DBCALLBACK_CreateFaction(factionId, name, checkID)
	if(type(name) ~= type(""))then
		look('create factionName is not string') 
		return
	end
	if(factionId~=nil and factionId>0)then
		if(checkID==1 or checkID==2)then
			local result = CI_CreateFaction(name,factionId)
			if(result == nil)then
				SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = 7}, 9 )
			elseif(result == 0)then
				local data = GetFactionBootData()
				if(data)then
					if(data.num == nil)then 
						data.num = 1
					else
						data.num = data.num + 1
					end
				end
				local playerid = CI_GetPlayerData(17)
				local creatData = faction_conf.create
				if(checkID == 1)then
					CheckCost(playerid,creatData[1],0,1,"100009_创建帮会")
					_upMainBuild()
					SendLuaMsg( 0, { ids = Faction_Build,idx = 1,lv = 1}, 9 )
				elseif(checkID == 2)then
					if(CheckGoods(creatData[2],1,0,playerid,'创建帮会')==1)then
						local upResult = CI_SetFactionInfo(nil,2,2)
						if(upResult == 1)then
							_upMainBuild()
							SendLuaMsg( 0, { ids = Faction_Build,idx = 1,lv = 2}, 9 )
						end
					end
				end
				local newFid = ((GetGroupID()%10000)*2^16)+factionId
				GetFaction_ybData(newFid)
				set_join_factionDate(playerid)
				SendLuaMsg(0, { ids=Faction_SuccessJoin,fn = name,t=2, fid = newFid}, 9 )
				GI_DelApplyJoinFaction(playerid,0,0)
			else
				SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = result}, 9 )
			end
		end
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 0, data = -6}, 9 )
	end
end
--加帮会buff 庇护
function SetFactionBuff(sid)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --帮会不存在
	end
	
	local lv = CI_GetFactionInfo(nil,4)
	if(lv<=0)then return false,1 end --帮会徽标未激活
	
	if(not CheckTimes(sid,uv_TimesTypeTb.FACTION_Buff,1,-1))then
		return false,3 --今日已领过了
	end
	
	CI_AddBuff(125,0,lv,false)
	
	return true
end
--[[
function SendFactionBuffTimes(sid)
	local times = 0
	local tb = GetDaySpendData(sid,SpendType.Faction_Buff)
	if(tb ~= nil)then
		times = tb.count
	end
	SendLuaMsg( 0, { ids = Faction_Buff, times = times}, 9 )
end
]]--

--解散帮会
function DeleteFaction(sid)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,-4 --帮会不存在
	end
	
	local title = CI_GetMemberInfo(1)
	if(title~=FACTION_BZ)then return false,-3 end --不是帮主
	
	if(faction_is_yunbiao(fid))then return false,-5 end --运彪期间不能解散帮会
	
	local fdata  = get_faction_data()
	fdata.jt = nil
	
	local result = CI_DeleteFaction(fid)
	if(result == nil)then return false,-4 end --帮会不存在
	if(result == 0)then
		return true
	else
		return false,result
	end
end

--解散帮会的C++回调
function OnFactionClear(fid)
	if(fid~=nil and fid>0)then
		local data = GetFactionBootData()
		if(data)then
			if(data.num ~= nil)then 
				data.num = data.num - 1
			end
		end
		if(dbMgr.faction~=nil)then --清除帮会lua数据
			if(dbMgr.faction.data~=nil and dbMgr.faction.data[fid]~=nil)then
				dbMgr.faction.data[fid] = nil
			end
			if(dbMgr.faction.temp~=nil)then
				if(dbMgr.faction.temp[fid]~=nil)then
					dbMgr.faction.temp[fid] = nil
				end
			end
		end
		
		--解除同盟关系
		delFactionUnion(nil,fid)
	end
end

--个人离开帮会C++回调



--帮会捐献 mtype 0 元宝 1 道具1 2 道具2 3 铜钱 money 元宝数/道具数
function DonateFaction(sid,money,mtype)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --帮会信息获取失败
	end--帮会不存在
	
	local bp = GetPlayerPoints(sid,4)
	local curVal = 0
	if(bp ~= nil)then
		curVal = bp
	end
	if(curVal>=999999)then
		return false,4 --个人帮贡已达上限
	end
	
	local item
	local addVal
	if(mtype == 1 or mtype == 2)then
		item = faction_conf.donate[mtype]
		if(item == nil)then return 5 end --道具非法
		addVal = money * item[2]
	elseif(mtype == 3)then
		addVal = math_floor(money/1000)
	else
		addVal = money
	end
	
	local isfull
	if((addVal+curVal)>999999)then 
		addVal = 999999 - curVal
		isfull = 1
	end
	
	if(addVal<0)then
		return false,4 --个人帮贡已达上限
	end
	
	local fmoney --增加的帮会资金
	local pVal --个人增加的帮会贡献
	--{{682,20,20},{683,500,500}} --道具、个人帮贡、帮会资金
	if(mtype == 0)then --元宝
		if not CheckCost( sid , addVal , 0 , 1 ,"100017_帮会个人捐献") then
			return false,3 --元宝不足
		end
		pVal = addVal*10
		fmoney = addVal*10
	elseif(mtype == 3)then --铜钱
		local dayDonate = 0
		local timesF = GetTimesInfo(sid,uv_TimesTypeTb.donate_F)
		if(timesF and timesF[1])then
			dayDonate = timesF[1]
		end
		if((dayDonate + addVal*1000)>5000000)then
			return false,8
		end
	
		if(addVal<=0)then
			return false,7 --铜钱少于1000
		end
		if(CheckGoods(0,addVal*1000,0,sid,'帮会捐赠')==0)then
			return false,2 --没有足够道具
		end
		CheckTimes(sid,uv_TimesTypeTb.donate_F,addVal*1000,-1)
		pVal = addVal
		fmoney = addVal
	else
		money = math_ceil(addVal/item[2])
		if(CheckGoods(item[1],money,0,sid,'帮会捐赠')==0)then
			return false,6 --没有足够道具
		end
		pVal = addVal 
		fmoney = money * item[3]
	end
	
	set_obj_pos(sid,1001) --完成一次帮会捐献
	
	_factionMoneyAdd(fmoney)
	AddPlayerPoints(sid,4,pVal,nil,'帮会捐献')
	if(fmoney>=100)then
		FactionRPC(fid,'FF_TreasureMsg',3,CI_GetPlayerData(5),fmoney)
	end
	return true,fmoney,pVal,isfull
end

--[[
function SetPlayerFactionVal(sid,val)
	local ffData = FF_GetPlayerData(sid)
	if ffData then
		ffData.fVal = val
	end
	SendLuaMsg( 0, { ids=Faction_GetFactionVal, fbg = ffData.fVal }, 9 )
end
function GetPlayerFactionVal(sid)
	local ffData = FF_GetPlayerData(sid)
	if ffData then
		return ffData.fVal 
	end
	return 0
end
--:Faction LeveUp
function FactionLevelUp()
	local factionData = GetFactionInfo()
	if(nil == factionData) then
		--rfalse('获取帮会信息失败')	
		return false,'获取帮会信息失败'		
	end
	
	local level = factionData.level
	if(level >= 5)then
		--rfalse('已经是最大等级')
		return false,'已经是最大等级'			
	end
	
	level = level + 1
	
	--升级帮会等级
	--rfalse(factionData.factionName..','..level)
	if(SetFactionInfo(factionData.factionName,{level=level}))then
		SendLuaMsg( 0, { ids=Faction_LvUp, data ={ level=level} }, 9 )
		TipCenter( GetStringMsg(206))
		return true
	else
		return false,'提升帮会等级失败'
	end
end
]]--

-- 主动删除帮会用
--DeleteFaction("11")

--[[添加帮会积分
function factionScoresAdd(addscores,fid)
	local faction 
	if fid ~= nil then
		faction = GetFactionInfo(fid)
	else
		faction = GetFactionInfo()
	end
	if faction == nil then
		return
	end
	--rfalse(" faction.scores:"..tostring(faction.scores).."   faction.factionName .."..tostring(faction.factionName))
	SetFactionInfo(faction.factionName,{ scores = addscores })
	SendLuaMsg( 0, { ids=Faction_UpdateScore, score = addscores }, 9 )
end

function factionPersonScoreAdd(addscores)
	local sid = CI_GetPlayerData(17) 
end

function AddPlayerFactionVal(sid,val)
	
	local ffData = FF_GetPlayerData(sid)
	if ffData then
		ffData.fVal = ( ffData.fVal or 0 ) + val
	end
	if(__plat == 4 and ffData.fVal>=9000)then
		Achieve_Default(sid,6011)
	end
	
	local old_sid = CI_GetPlayerData(17)	
	if 1==SetPlayer( sid, 1, 1 ) then
		SetMemberInfo(val)
		TipNormal( GetStringMsg(1,val))
		SendLuaMsg( 0, { ids=Faction_GetFactionVal, fbg = ffData.fVal }, 9 )
	end
	SetPlayer( old_sid, 1, 1)
	
	
end
]]--

--弹劾帮主
function ImpeachFHeader(sid)
	local isFF = GI_Is_Active_Live('cf')
	if(isFF)then return end

	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then return end--帮会不存在
	local title = CI_GetMemberInfo(1)
	if(title == FACTION_BZ)then return end --自己就是帮主，弹劾毛啊
	
	local hsid,seconds = CI_GetFactionLeaderInfo(fid,0)
	if(hsid == nil or seconds ==nil or seconds == 0)then
		TipCenter('帮主离线时间尚不足弹劾条件！')
		return 
	end
	
	if(IsPlayerOnline(hsid))then --帮会在线
		return
	end
	
	local now = GetServerTime()
	local times = now - seconds
	if title == FACTION_FBZ then
		if(times<60*60*24*3)then return end
	elseif title == FACTION_ZL then
		if(times<60*60*24*4)then return end
	elseif title == FACTION_XZ then
		if(times<60*60*24*5)then return end
	else
		if(times<60*60*24*6)then return end
	end
	
	ReplaceFactionLeader()
	
	-- 如果是国王被弹劾更新国王信息
	local owner_fid = getCityOwner()
	if owner_fid and owner_fid == fid then
		SetPlayerTitle(sid,39)
		CI_AddBuff(304,0,1,true,2,sid)
		UpdateCityImageID(fid)
		BroadcastRPC('Set_King',CI_GetPlayerData(5,2,sid))
	end
	--GI_GetFHeaderLastLogin(hsid,sid,fid)
end

function CALLBACK_ImpeachFHeader(seconds,sid,hsid,fid)
	--local nhsid = CI_GetFactionLeaderInfo(fid,0)
	--if(nhsid == nil or nhsid ~= hsid)then return end
	
	--if not CheckCost( sid , 100 , 1 , 1 ,'弹劾帮主') then return endReplaceFactionLeader()
	--if(ReplaceFactionLeader()==nil)then
	--	CheckCost( sid , 100 , 0 , 1,'100016_弹劾帮主' )
	--end
end

--提升帮会人数
function UpdateSizeLevel(sid)
	local sizelevel = CI_GetFactionInfo(nil,10)
	if(sizelevel == nil)then --获取帮会信息
		return false,0
	end
	
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --帮会不存在
	end
	
	if(sizelevel>=2)then
		--达到帮会人数上限值
		--TipCenter(GetStringMsg(574))
		return false,1
	end
	
	sizelevel = sizelevel + 1
	
	local cost = sizelevel*100
	if(cost == nil)then return false end
	
	if CheckCost( sid , cost, 1 , 1 ) then
		if(CI_SetFactionInfo(nil,10,sizelevel) == 1)then
			CheckCost( sid , cost , 0 , 1 ,'100020_升级帮会人数')
			FactionRPC(fid,'FF_TreasureMsg',2,sid,CI_GetPlayerData(5))
			return true,sizelevel
		else
			return false,2
		end
	else
		--金额不足
		return false,3
	end
end

--帮会祝福
function FactionLuck(psid,sid)
	PI_PayPlayer(1,188,0,0,'帮会祝福',2,psid)
end

--申请加入帮会
function FactionApplyJoin(sid,fid)
	local level = CI_GetPlayerData(1)
	if(level<30)then
		return false,4 --等级不足30级
	end

	local myfid = CI_GetPlayerData(23)
	if myfid>0 then
		return false,1 --已经有帮会了
	end
	--是否是机器人帮会
	local autoID = is_auto_faction(fid)
	if(autoID)then
		join_auto_faction(autoID,sid)
		return true
	end
	local flv = CI_GetFactionInfo(fid,2)
	if(flv == nil)then
		return false,2 --帮会不存在
	end
	
	local lv = CI_GetFactionInfo(fid,10)
	local totalnum = 30 + lv*6 + (flv-1)*2
	local num = CI_GetFactionInfo(fid,11)
	if(totalnum<=num)then
		return false,3 --帮会人数已达上限
	end
	
	--p_factionapply`(_fid int, _roleid int, _rolename varchar(22), 
	--_vip int, _sex int, _rolelevel int, _ntime int)
	local bzid,fbzid = CI_GetFactionLeaderInfo(fid,1)
	local sex = CI_GetPlayerData(11)
	local school = CI_GetPlayerData(2)
	local name = PI_GetPlayerName(sid)
	local vip = PI_GetPlayerVipType(sid)
	local level = PI_GetPlayerLevel(sid)
	local head = PI_GetPlayerHeadID(sid)
	local ntime = GetServerTime()
	--fid,sid,name,vip,sex,level,school,head,ntime
	GI_ApplyJoinFaction(fid,sid,name,vip,sex,level,school,head,ntime)
	if(bzid~=nil and IsPlayerOnline(bzid))then
		SendLuaMsg( bzid, { ids=Faction_newJoin}, 10 )
	end
	if(fbzid~=nil and IsPlayerOnline(fbzid))then
		SendLuaMsg( fbzid, { ids=Faction_newJoin}, 10 )
	end
	return true
end

--审批加入帮会请求 t 0 拒绝 1 同意
function FactionAskJoin(sid,dsid,t,page)
	--look(sid..'....'..dsid..','..t..','..page)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --帮会不存在
	end
	
	local title = CI_GetMemberInfo(1)
	if(title ~= FACTION_BZ and title ~= FACTION_FBZ)then return false,1 end --只有帮主和副帮主有审批权限
	
	local fname = CI_GetFactionInfo(fid,1)
	if(t == 1)then
		local dfid = PI_GetPlayerFacID(dsid)
		if(dfid~=nil and dfid>0)then
			GI_DelApplyJoinFaction(dsid,0,0)
			if(fid == dfid)then
				return false,2 --已经在本帮了
			else
				return false,5 --在别人的帮会
			end
		end
		
		local flv = CI_GetFactionInfo(fid,2)
		if(flv == nil)then
			return false,0 --帮会不存在
		end
		local lv = CI_GetFactionInfo(fid,10)
		local totalnum = 30 + lv*6 + (flv-1)*2
		local num = CI_GetFactionInfo(fid,11)
		if(totalnum<=num)then
			return false,3 --帮会人数已达上限
		end
		
		if(IsPlayerOnline(dsid))then
			local result = CI_JoinFaction(fid,dsid)
			if(result == 0)then --成功加入帮会
				set_join_factionDate(dsid)
				if(type(fname) == type(""))then
					SendLuaMsg(dsid, { ids=Faction_SuccessJoin,fn = fname,t=t, fid = fid}, 10 )
					sendFactionUnion(dsid)
				end
				GI_DelApplyJoinFaction(dsid,0,0)
				bsmz_online(dsid)
			end
		else
			GI_DelApplyJoinFaction(dsid,fid,1,page)
		end
	else
		if(IsPlayerOnline(dsid) and type(fname) == type(""))then
			local dfid = PI_GetPlayerFacID(dsid)
			if(dfid == nil or dfid == 0)then
				SendLuaMsg(dsid, { ids=Faction_SuccessJoin,fn = fname,t=t, fid = fid}, 10 )
			end
		end
		GI_DelApplyJoinFaction(dsid,0,0)
	end
	
	return true
end

--审批离线的数据库回调
function DBCALLBACK_ApplyFaction(fid,page,sid,rs)
	if type(rs) == type({}) and table.empty(rs) == false then
		local v = rs[1]
		if(v~=nil and type(v) == type({}) and #v==7)then
			--roleId, roleName, vip, sex, roleLevel,school,head
			--CI_JoinFaction(factionid , playersid,level,school,head,sex,name)
			--look(v)
			local result = CI_JoinFaction(fid,sid,v[5],v[6],v[7],v[4],v[3],v[2])
			if(result == 0)then
				PI_SetPlayerFacID(sid,fid)
				SendLuaMsg( 0, { ids = Faction_ApplyResult, page = page, t = 1, sid = sid}, 9 )
			end
		end
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 13, data = 4, page = page, sid = sid}, 9 )
	end
end

--取消加入帮会请求
function FactionAbortJoin(sid,fid)
	GI_DelApplyJoinFaction(sid,fid,0)
end

factionMoneyAdd = _factionMoneyAdd
upMainBuild = _upMainBuild

-------------------------------帮会驻地相关 by wk--------------------------------------
-------------------------------帮会驻地相关 by wk--------------------------------------
--帮会驻地数据--全
function GetFactionTempregionData()
	if(dbMgr.faction.temp == nil)then
		dbMgr.faction.temp = {}
	end
	
	if(dbMgr.faction.temp.region == nil)then 
		dbMgr.faction.temp.region = {
			--[fid]=gid
		} 
	end
	return dbMgr.faction.temp.region 
end

--清除帮会驻地地图--1小时一次
function faction_clc_region( )
	local fadta=GetFactionTempregionData()
	for k,v in pairs(fadta) do
		if type(k)==type(0) and type(v)==type(0) then 
			local peoplenum=GetRegionPlayerCount(v)
			
			if peoplenum==0 or peoplenum==nil then 
				CI_DeleteDRegion(v,false)
				fadta[k]=nil
			end
		end
	end
end
--进入帮会驻地
function faction_in_region(itype)
	
	local _,_,_,gid = CI_GetCurPos()
	if gid then
		TipCenter(GetStringMsg(17))
		return
	end
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return  --帮会不存在
	end
	local fadta=GetFactionTempregionData()
	if fadta[fid]==nil then
		local gid=PI_CreateRegion( 520, -1, 1)
		
		fadta[fid]=gid
	end 
	if itype==1 then
		PI_MovePlayer(0,zhudi_conf.enter[1][1],zhudi_conf.enter[1][2],fadta[fid]) 
	elseif itype==2 then
		PI_MovePlayer(0,zhudi_conf.enter[2][1],zhudi_conf.enter[2][2],fadta[fid]) 
	end
end
-------------------------------帮会秘境相关 by wk--------------------------------------
-------------------------------帮会秘境相关 by wk--------------------------------------
--帮会秘境数据--全
function GetFactionTemp_mijingData()

	if(dbMgr.faction.temp == nil)then
		dbMgr.faction.temp = {}
	end
	
	if(dbMgr.faction.temp.mijing == nil)then 
		dbMgr.faction.temp.mijing = {
			--[fid]=gid
		} 
	end
	return dbMgr.faction.temp.mijing 
end

--清除帮会秘境地图--1小时一次
function faction_clc_mijing( )
	local fadta=GetFactionTemp_mijingData()
	for k,v in pairs(fadta) do
		if type(k)==type(0) and type(v)==type(0) then 
			local peoplenum=GetRegionPlayerCount(v)
			if peoplenum==0 or peoplenum==nil then 
				CI_DeleteDRegion(v,false)
				fadta[k]=nil
			end
		end
	end
end
--每日固定活动时间12：00 – 24:00，

--进入秘境
function faction_in_mijing( )
	-- look('进入秘境')

	local opentime =mijing_conf.opentime
	local curdt = os.date( "*t", GetServerTime())
	local now=curdt.hour*100+curdt.min
	if  now< opentime[1] or now > opentime[2] then
		TipCenter(GetStringMsg(21))
		
		return
	end

	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		
		return  --帮会不存在
	end
	local fadta=GetFactionTemp_mijingData()
	if fadta[fid]==nil then
		local gid=PI_CreateRegion( 521, -1, 1)
		
		fadta[fid]=gid

		mijing_conf.box.regionId=gid --刷宝箱
		CreateObjectIndirect(mijing_conf.box)

		local wlevel_conf = mijing_conf.wlevel --刷怪
		local world_lv = GetWorldLevel() or 1 
		local tpos = table_locate(wlevel_conf,world_lv,2)
		if tpos == nil or wlevel_conf[tpos] == nil then	
			look('fff monster config erro')
			return
		end
		local f_monster=mijing_conf.f_monster
		for k,v in pairs (f_monster) do 
			f_monster[k].regionId=gid
			f_monster[k].level = tpos
			f_monster[k].monAtt = wlevel_conf[tpos][k]	
			local a=CreateObjectIndirect(f_monster[k])
		end
	end 
	
	PI_MovePlayer(0,28,65,fadta[fid]) 
end


--秘境采集宝箱回调
call_monster_chick[3]=function ()	
	
	local playerid= CI_GetPlayerData(17)
	local fid= CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return  --帮会不存在
	end
	local flv=CI_GetFactionInfo(fid,2)
	local award=mijing_conf.award[flv]
	local pakagenum = isFullNum()
	if pakagenum < #award then
		TipCenter(GetStringMsg(14,#award))
		return 0
	end		

	local timeinfo=GetTimesInfo(playerid,uv_TimesTypeTb.Faction_box)
	

	if not CheckTimes(playerid,uv_TimesTypeTb.Faction_box,1,-1,1) then
		TipCenter(GetStringMsg(20))
		return
	end
	
	CI_SetReadyEvent(nil,ProBarType.open,3,0,'faction_openbox')
end
--开宝箱回调
function faction_openbox()
	
	local playerid= CI_GetPlayerData(17)
	local fid= CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		
		return  --帮会不存在
	end
	local flv=CI_GetFactionInfo(fid,2)
	local award=mijing_conf.award[flv]
	 CheckTimes(playerid,uv_TimesTypeTb.Faction_box,1,-1)
	GiveGoodsBatch( award,"秘境宝箱")

	factionMoneyAdd(mijing_conf.award.fmoney,fid)--加帮会资金
	set_soul_group(playerid,mijing_conf.award.fss)--加神兽成长
	RPC('f_box',flv) --挖宝箱成功,弹面板
	return 1
end
--离帮 lsid 离开人的ID
function leave_faction(sid,lsid)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then return false,0 end --无帮会
	
	local isFF = GI_Is_Active_Live('cf')
	if(isFF)then
		if(sid == lsid)then
			return false,10
		else
			return false,11
		end
	end
	
	isFF = GI_Is_Active_Live('ff')
	if(isFF)then 
		if(sid == lsid)then
			return false,12
		else
			return false,13
		end
	end
	
	if(faction_is_yunbiao(fid))then --运镖时不能退帮
		if(sid == lsid)then
			return false,8
		else
			return false,9
		end
	end
	
	local pos = CI_GetMemberInfo(1)
	local result
	if(sid == lsid)then --离帮
		if(pos>=FACTION_XZ)then return false,1 end --有职位不能离帮
		result = CI_LeaveFaction(fid,lsid,1)
		if(result == 0)then
			RemovePlayerTitle(sid,21)
		end
		set_join_factionDate(sid)
	else --踢人
		if(pos<FACTION_FBZ)then return false,2 end --权限不足,副帮主才能踢人
		local hsid = CI_GetFactionLeaderInfo(fid,0)
		if(hsid == nil)then return false,3 end --未取到帮主信息
		if(hsid == lsid)then return false,4 end --不能踢帮主
		
		local fdata = GetFactionData(fid)
		if(fdata == nil)then
			return false,5 --获取帮会数据失败
		end
		
		look('帮会数据==========')
		look(fdata)
		local flv = CI_GetFactionInfo(nil,2)
		if(flv~=nil and flv>=4)then
			fdata.tnum = nil
			fdata.tdata = nil
		else
			if(IsPlayerOnline(lsid))then
				local dt = os_date("*t", now)
				local tdate = dt.year*10000 + dt.month * 100 + dt.day
				if(fdata.tdata == nil or fdata.tdata~= tdate)then
					fdata.tnum = 0
					fdata.tdata = tdate	
				end

				if(flv == nil or flv<=2)then
					if(fdata.tnum ~= nil and fdata.tnum>=3)then
						return false,7 --每天只能T3次在线玩家
					end
				elseif(flv<=3)then
					if(fdata.tnum ~= nil and fdata.tnum>=5)then
						return false,6 --每天只能T5次在线玩家
					end
				end
			end
		end
		
		result = CI_LeaveFaction(fid,lsid,0)
		if(result == 0 and IsPlayerOnline(lsid))then
			set_join_factionDate(lsid)
			if(flv==nil or flv<3)then
				fdata.tnum = fdata.tnum == nil and 1 or fdata.tnum+1
			end
			RemovePlayerTitle(lsid,21)
		end
	end
end
--离线退帮的上线判断
function online_leave_faction(sid)
	local fid = CI_GetPlayerData(23)
	--look('fid:' .. fid)
	if fid == nil or fid == 0 then
		RemovePlayerTitle(sid,21)
	end --无帮会
	--设置离帮时间
	set_join_factionDate(sid)
end

-- 帮会攻城战数据
function GetCityFightData()
	if dbMgr.city_fight.data == nil then
		dbMgr.city_fight.data =  {
		--city_fac==fid--城主帮会id
	}	
	end
	return dbMgr.city_fight.data
end

-- -- 活动事件调用
-- function King_activecall(state,subType)
	-- local cfData = GetCityFightData()
	-- if cfData == nil then return end
	-- local fac_id = cfData.city_fac
	-- if fac_id == nil then return end
	-- local king_sid = CI_GetFactionLeaderInfo(fid,1)
	-- if king_sid == nil or king_sid <= 0 then return end
	-- local king_name = CI_GetFactionLeaderInfo(fac_id,3)
	-- if type(king_name) ~= type('') then return end
	-- if subType == 1 then	-- 合服第一任国王
		-- cfData.hf_king_fac = fac_id
		-- cfData.hf_king_sid = king_sid
		-- cfData.hf_king_name = king_name
	-- end
-- end

-- function King_activeinfo(sid)
	-- local cfData = GetCityFightData()
	-- if cfData == nil then return end
	-- local fac_id = cfData.hf_king_fac
	-- if fac_id == nil then return end
	-- local king_name = cfData.king_name
	-- local fac_name = CI_GetFactionInfo(fac_id,1)
	-- if type(fac_name) ~= type('') then return end
	-- RPC('king_info',0)
-- end

function getCityOwner()
	local cfData = GetCityFightData()
	if cfData == nil then return end
	return cfData.city_fac
end

function sendCityOwner(sid)
	local cfData = GetCityFightData()
	if cfData == nil then return end
	local have = false
	local fac_id = cfData.city_fac
	--look('sendCityOwner fac_id' .. tostring(fac_id))
	if fac_id and fac_id > 0 then
		local fac_name = CI_GetFactionInfo(fac_id,1)
		local name = CI_GetFactionLeaderInfo(fac_id,3)
		if type(fac_name) == type('') and type(name) == type('') then
			SendLuaMsg( sid, { ids = Faction_CityOwner, owner = fac_name, cz = name}, 10 )
		end
		
		-- 添加新城主称号、buff
		local bzsid = CI_GetFactionLeaderInfo(fac_id,1)
		if bzsid and bzsid == sid then
			SetPlayerTitle(bzsid,39)
			CI_AddBuff(304,0,1,true,2,bzsid)
			have = true
		end
	end
	if not have then
		RemovePlayerTitle(sid,39)
		CI_DelBuff(304,2,sid)
	end
end

-- 登陆调用
function CityOwnerLogin(sid)
	local cfData = GetCityFightData()
	if cfData == nil then return end
	local fac_id = cfData.city_fac
	if fac_id and fac_id > 0 then
		local bzsid = CI_GetFactionLeaderInfo(fac_id,1)		
		if bzsid and bzsid == sid then
			local name = CI_GetPlayerData(5,2,sid)
			BroadcastRPC('city_owner_login',name)
		end
	end
end

-- 更新城主雕像
function UpdateCityImageID(fac_id,idx)
	local npcid = 400502	
	local controlID = npcid + 100000
	local index
	if idx then
		index = idx
	else
		local name,sex,sch = CI_GetFactionLeaderInfo(fac_id,3)
		if type(name) ~= type('') then return end
		 index = sch*10 + sex
	end
	if index == nil then return end
	local ImageID = 2159
	if index == 10 then
		ImageID = 2163
	elseif index == 11 then
		ImageID = 2162
	elseif index == 20 then
		ImageID = 2165
	elseif index == 21 then
		ImageID = 2164
	elseif index == 30 then
		ImageID = 2167
	elseif index == 31 then
		ImageID = 2166
	end	
	--look('UpdateCityImageID: ' .. tostring(ImageID))
	local ret = CI_UpdateNpcData(1,{imageId = ImageID,headID = ImageID},6,controlID,1)
end

function UpdateCityImageIDEx(sid)
	local owner_fid = getCityOwner()
	if owner_fid == nil then return end
	local bzsid = CI_GetFactionLeaderInfo(owner_fid,1)
	if bzsid and bzsid == sid then
		local cfData = GetCityFightData()
		if cfData == nil then return end
		cfData.sex = CI_GetPlayerData(11,2,sid)
		cfData.sch = CI_GetPlayerData(2,2,sid)
		local sex = cfData.sex
		local sch = cfData.sch
		if sex and sch then
			local index = sch*10 + sex
			UpdateCityImageID(owner_fid,index)
		end
	end
end

-- 创建城主雕像
function CreateCityOwner()
	local npcid = 400502
	local controlID = npcid+100000
	local v = npclist[npcid]	
	if type(v) == type({}) then		
		v.NpcCreate.regionId = 1
		v.NpcCreate.imageId = 2159
		v.NpcCreate.headID = 2159
		v.NpcCreate.controlId = controlID
		local ret = RemoveObjectIndirect( 1, controlID )
		CreateObjectIndirect( v.NpcCreate )
		-- 更新雕像
		local cfData = GetCityFightData()
		if cfData == nil then return end
		local fac_id = cfData.city_fac
		if fac_id == nil then return end
		--look('fac_id:' .. tostring(fac_id))
		local sex = cfData.sex
		local sch = cfData.sch
		if sex and sch then
			local index = sch*10 + sex
			UpdateCityImageID(fac_id,index)
		end
	end	
end

is_auto_faction_name = _is_auto_faction_name


--夺城战帮主权利
function tq_guowang( sid,osid,itype )
	
	local fdata=GetCityFightData()
	local fid=fdata.city_fac
	if fid==nil then return end
	local Leader =CI_GetFactionLeaderInfo(fid,0)---国王
	if sid~=Leader then return end
	local name
	if type(osid)==type(0) and osid>0 then 
		name=CI_GetPlayerData(5,2,osid)
	elseif type(osid)==type('') then
		name=osid
		osid=GetPlayer(name, 0)
		if type(osid)~=type(0) or osid<=0 then return end
	end
	
	if itype==1 then --禁言--301
		if(not CheckTimes(sid,uv_TimesTypeTb.city_JY,1,-1))then
			return 
		end
		CI_AddBuff(301,0,1,false,2,osid)
		BroadcastRPC('gwtq',itype,CI_GetPlayerData(5),name)
	elseif itype==2 then  --变狗--302
		if(not CheckTimes(sid,uv_TimesTypeTb.city_BG,1,-1))then
			return 
		end
		CI_AddBuff(302,0,1,false,2,osid)
		BroadcastRPC('gwtq',itype,CI_GetPlayerData(5),name)
	elseif itype==3 then --脱袍--303
		if(not CheckTimes(sid,uv_TimesTypeTb.city_TP,1,-1))then
			return 
		end
		CI_AddBuff(303,0,1,false,2,osid)
		BroadcastRPC('gwtq',itype,CI_GetPlayerData(5),name)
	elseif itype==4 then --召集
		local cx, cy, rid,isdy = CI_GetCurPos()
		if isdy then 
			if rid~=504 and rid~=523 then 
				TipCenter(GetStringMsg(455))
				return 
			end
		end
		if(not CheckTimes(sid,uv_TimesTypeTb.city_ZJ,1,-1))then
			return 
		end
		FactionRPC( fid, 'gwtq_zj',cx, cy, rid,isdy)
	else
		return
	end
end

--玩家响应召集
function trance_p( sid )
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return  --帮会不存在
	end

	local fdata=GetCityFightData()
	local cfid=fdata.city_fac
	if cfid==nil then return end
	if cfid~=fid then return end
	local Leadersid =CI_GetFactionLeaderInfo(fid,0)---国王
	if Leadersid==nil then return end

	if not IsPlayerOnline(Leadersid) then 
		TipCenter(GetStringMsg(7))--不在线
		return
	end
	local cx, cy, rid,isdy = CI_GetCurPos(2,Leadersid)

	local res=limit_lv_zl( rid)--战力等级限制
	if not res then return end
	if escort_not_trans(sid) then --护送状态不能传
		look('escort_not_trans')
		return
	end
	if isdy then 
		if rid==504 then
			GI_Active_Enter(1,sid,rid,cx,cy,isdy)
		elseif rid==523 then 
			GI_Active_Enter(2,sid,rid,cx,cy,isdy)
		else
			return 
		end
	end
	PI_MovePlayer(rid, cx, cy, isdy)
end

--设置加入帮会的时间
function set_join_factionDate(sid)
	--look('设置加入帮会的时间')
	local fid = CI_GetPlayerData(23,2,sid)
	local fdata=GI_GetPlayerData( sid , 'faction' , 250 )
	if fdata == nil then return end
	--look(fid)

	if fid ~= nil and fid > 0 then
		if(fdata.jt == nil)then fdata.jt = GetServerTime() end
	else
		if(fdata.jt ~= nil)then fdata.jt = nil end
	end
	RPCEx(sid,'join_fac',fdata.jt)
	--look(fdata.jt)
end
--获取加入帮会的时间
function get_join_factiontime(sid)
	local fid = CI_GetPlayerData(23,2,sid)
	if fid ~= nil and fid > 0 then
		local fdata=GI_GetPlayerData( sid , 'faction' , 250 )
		if fdata == nil then return end
		if(fdata.jt == nil)then fdata.jt = GetServerTime() end
		return fdata.jt
	else
		return nil
	end
end