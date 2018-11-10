--[[
file:	Item_ScriptConf.lua
desc:	item used by script conf.
author:	chal
update:	2011-12-07
]]--
--:Interface call by server.
--[[
 GiveGoods(道具ID，数量，是否绑定，注释)
  三个返回值：
成功失败  true  false
失败代码：
// 无效的道具标号    0
// 需要添加的道具太多了  1
// 背包空间不够  2
// 创建道具失败		 3
// 参数列表中的道具重复 4
// 玩家身上的钱太多了 5
实际给的个数    
装备类型
101: 武器
102：衣服
103：裤子
104：鞋子
105：项链
106：腰牌
107：手链
108：戒指
109：元神头盔
110：元神铠甲
111：印章
112：元神护腿
113：元神翼甲
114:  元神护肩
115:  元神手镯
116：元神武器
130：坐骑
150：元神
]]
local card_=require("Script.card.card_func")
local card_useitem=card_.card_useitem
--------------------------------------------------------------------------
--include:
local TP_FUNC = type( function() end)
local GetWorldLevel=GetWorldLevel
local Hero_Data = msgh_s2c_def[9][1]
local Hero_Fail = msgh_s2c_def[9][2]
local Horse_Data = msgh_s2c_def[17][1]
local Horse_Fail = msgh_s2c_def[17][2]
local MRB_Data = msgh_s2c_def[35][2]	-- 庄园掠夺列表数据
local Wing_Err = msgh_s2c_def[20][12]
local pairs,type,tostring = pairs,type,tostring
local ipairs = ipairs
local mathfloor,mathrandom = math.floor,math.random
local GiveGoods,CheckGoods,isFullNum,PI_PayPlayer = GiveGoods,CheckGoods,isFullNum,PI_PayPlayer
local look = look
local CI_AddMulExpTicks,CI_GetPlayerData = CI_AddMulExpTicks,CI_GetPlayerData
local SendLuaMsg,TipCenter,GetStringMsg = SendLuaMsg,TipCenter,GetStringMsg
local GiveGoodsBatch,CI_GetCurPos,CI_AddBuff = GiveGoodsBatch,CI_GetCurPos,CI_AddBuff
local wbao = require('Script.active.wabao')
local wb_usebu=wbao.wb_usebu
local escort = require('Script.active.escort')
local es_ueslibao=escort.es_ueslibao
local BroadcastRPC=BroadcastRPC
local item_getnumactive=item_getnumactive

local shq_m = require('Script.ShenQi.shenqi_func')
local equip_jiezhi = shq_m.equip_jiezhi

--------------------------------------------------------------------------
-- data:
--道具编号与称号编号对应表
local TitleItemList = {
	[103] = 1, --系统指导员
	[1132] = 4,
	[1133] = 5,
	[1134] = 6,
	[1135] = 7,
	[1136] = 8,
	[1137] = 9,
	[1138] = 10,
	[1139] = 11,
	[1140] = 12,
	[1113] = 118,
	[1116] = 33,
	[1117] = 40,
	[1118] = 46,
	[1119] = 116,
	[1120] = 117,
	[1121] = 105,
	[1122] = 106,
	[1123] = 107,
	[1124] = 108,
	[1125] = 109,
	[1126] = 110,
	[1127] = 111,
	[1128] = 112,
	[1129] = 113,
	[1130] = 114,
	[1131] = 115,
	[1174] = 47,
	[1250] = 48,
	[1251] = 49,
	[1252] = 59,
	[1253] = 55,
	[1254] = 56,
	[1255] = 57,
	[1278] = 35,
	[1279] = 36,
	[1280] = 37,
	[1281] = 38,
	[1282] = 58,
	[1475] = 50,
	[1476] = 51,
	[1477] = 52,
	[1478] = 53,
	[1479] = 54,
	[1485] = 14,
	[1486] = 16,
	[1497] = 60,
	[1498] = 61,
	[1499] = 62,
	[1500] = 63,
	[1516] = 64,
	[1517] = 65,
	[1518] = 66,
	[1567] = 32,
}
--帮会夺宝宝箱
local FactionLuckItem = {668,664,638,620,601,603,624}
--妲己的香囊
local SeedItem = {1021,1022,1024,1025,1036,1037,1039,1040} -- 种子

--战场宝箱
local WarLuckItem = {{710,2,1},{51,2,1},{710,1,1},{624,3,1},{635,2,1},{621,1,1} ,{629,1,1} ,{51,1,1} ,{636,5,1},{634,5,1}}
--装备类型	
local ItemScript_equipType = {101,102,103,104,105,106,107,108}
--时效类活动礼包类物品
local TimeItemConf = {
	[3016]={[1]=88, [2] = {{710,20,1},{673,2,1},{676,2,1},{3017,1,1}}},
	[3017]={[1]=488, [2] = {{710,30,1},{673,2,1},{618,5,1},{3018,1,1}}},
	[3018]={[1]=888, [2] = {{710,40,1},{673,2,1},{627,300,1},{3019,1,1}}},
	[3019]={[1]=1688, [2] = {{710,80,1},{711,1,1},{673,3,1},{3020,1,1}}},
	[3020]={[1]=4888, [2] = {{712,1,1},{715,1,1},{673,5,1}}},
	[3021]={[1]=88, [2] = {{710,5,1},{3022,1,1}}},
	[3022]={[1]=488, [2] = {{710,20,1},{713,3,1},{3023,1,1}}},
	[3023]={[1]=888, [2] = {{710,30,1},{714,1,1}}},
	[3024]={[1]=88, [2] = {{636,15,1},{3025,1,1}}},
	[3025]={[1]=288, [2] = {{636,40,1},{627,20,1},{3026,1,1}}},
	[3026]={[1]=588, [2] = {{636,100,1},{627,100,1}}},
	[3027]={[1]=88, [2] = {{634,15,1},{3028,1,1}}},
	[3028]={[1]=488, [2] = {{634,60,1},{732,3,1},{3029,1,1}}},
	[3029]={[1]=888, [2] = {{634,100,1},{733,1,1}}},
	[3030]={[1]=88, [2] = {{625,2,1},{3031,1,1}}},
	[3031]={[1]=488, [2] = {{625,8,1},{626,30,1},{3032,1,1}}},
	[3032]={[1]=888, [2] = {{625,12,1},{626,100,1}}},
	[3056]={[1]=700, [2] = {{710,33,1}}},
	[3057]={[1]=3500, [2] = {{710,166,1}}},
	[3063]={[1]=700, [2] = {{762,100,1}}},
	[3064]={[1]=3500, [2] = {{762,500,1}}},
	[3065]={[1]=88, [2] = {{762,15,1},{3066,1,1}}},
	[3066]={[1]=488, [2] = {{762,60,1},{765,3,1},{3067,1,1}}},
	[3067]={[1]=888, [2] = {{762,100,1},{766,1,1}}},
}
--幸运石宝箱
local XINYUNSHIBAOXIANG =  {
{614,5,1,3000},{614,6,1,5000},{614,7,1,6500},{614,8,1,7500},{614,9,1,8500},{614,10,1,9000},{615,5,1,9500},{615,6,1,9600},{615,7,1,9700},{616,5,1,9800},{616,6,1,9900},{616,7,1,10000},
}
--橙装碎片宝箱
local CHENGSESUIPIANBAOXIANG = {
{601,5,1,2400,0},{601,10,1,2850,0},{601,20,1,3000,0},{710,1,1,3560,0},{710,2,1,3630,0},{636,2,1,5630,0},{636,3,1,6005,0},{636,5,1,6130,0},{624,1,1,7180,0},{625,1,1,7555,0},{634,2,1,9400,0},{634,3,1,9625,0},{634,5,1,9700,0},{647,1,0,9740,1},{652,1,0,9840,1},{657,1,0,9900,1},{648,1,0,9920,1},{653,1,0,9970,1},{658,1,0,10000,1},
}
--开服活动百宝箱
local BAIBAOXIANG = {
	[1]  = {{0,0,0,5000},{768,1,1,7900},{636,2,1,8900},{710,1,1,9900},{52,1,1,10000},},
	[2]	 = {{0,0,0,3000},{768,1,1,7900},{636,2,1,8900},{710,1,1,9900},{52,1,1,10000},},
	[3]	 = {{0,0,0,1000},{768,1,1,7900},{636,2,1,8900},{710,1,1,9900},{52,1,1,10000},},
	[4]	 = {{0,0,0,100},{768,1,1,7900},{636,2,1,8900},{710,1,1,9900},{52,1,1,10000},},
}
--新春礼包
local XINCHUNLIBAO = {
	{711,1,1,1000},{730,1,1,2500},{763,1,1,5500},{783,1,1,8500},{677,1,1,9000},{717,1,1,10000},
}

--端午粽子礼包
local DUANWUZONGZI = {
	{601,5,1,3000},{603,5,1,5500},{626,5,1,6500},{627,5,1,7500},{762,2,1,8000},{803,10,1,8500},{812,10,1,9000},{778,1,1,10000},
}
--中秋豆沙月饼
local ZHONGQIUYUEBING = {
	{1570,1,1,5000},{1571,1,1,10000},
}
--国庆宝箱
local GuoQingBaoXiang = {
	[1] = {{803,1000,1},{812,1000,1},{601,1000,1}},
    [2] = {678,1,1,50},
}
--万圣节日宝箱
local Wanshengbaoxiang = {
	[1] = {{803,500,1},{812,500,1},{601,200,1},{603,200,1}},
    [2] = {309,1,1,50},
}
--贡献礼包
local Gongxian = {
	{803,100,1,2000},{812,100,1,4000},{636,10,1,6000},{1585,50,1,8000},{603,100,1,10000},
}
--玄天礼包
local Xuantian = {
	{1585,400,1,2500},{1585,350,1,6000},{1585,250,1,10000},
}
--红包
local Hongbao = {
	{603,200,1,3000},{601,100,1,6000},{803,50,1,7600},{812,50,1,9200},{711,1,1,10000},
}

--宝石箱
local bsx = 
{
	[1] = {{410,1,1},{420,1,1},{430,1,1},{440,1,1},{450,1,1},{460,1,1},{470,1,1},{480,1,1},},
	[2] = {{411,1,1},{421,1,1},{431,1,1},{441,1,1},{451,1,1},{461,1,1},{471,1,1},{481,1,1},},
	[3] = {{412,1,1},{422,1,1},{432,1,1},{442,1,1},{452,1,1},{462,1,1},{472,1,1},{482,1,1},},
	[4] = {{413,1,1},{423,1,1},{433,1,1},{443,1,1},{453,1,1},{463,1,1},{473,1,1},{483,1,1},},
	[5] = {{414,1,1},{424,1,1},{434,1,1},{444,1,1},{454,1,1},{464,1,1},{474,1,1},{484,1,1},},
	[6] = {{415,1,1},{425,1,1},{435,1,1},{445,1,1},{455,1,1},{465,1,1},{475,1,1},{485,1,1},},
	[7] = {{416,1,1},{426,1,1},{436,1,1},{446,1,1},{456,1,1},{466,1,1},{476,1,1},{486,1,1},},
	[8] = {{417,1,1},{427,1,1},{437,1,1},{447,1,1},{457,1,1},{467,1,1},{477,1,1},{487,1,1},},
	[9] = {{418,1,1},{428,1,1},{438,1,1},{448,1,1},{458,1,1},{468,1,1},{478,1,1},{488,1,1},},
}

local call_OnUseItem={
	
	--小血包
	[25]=function ()
		local sid = CI_GetPlayerData(17)
		return xb_useitem( sid,300000 )
	end,
	--大血包
	[26]=function ()
		local sid = CI_GetPlayerData(17)
		return xb_useitem( sid,600000 )
	end,
	--1.2倍经验符
	[50]=function ()
		CI_AddMulExpTicks(2,60*30)
	end,
	--1.5倍经验符
	[51]=function ()
		CI_AddMulExpTicks(5,60*30)
	end,
	--2倍经验符
	[52]=function ()
		CI_AddMulExpTicks(10,60*30)
	end,

	--全套武功 1 普通技能  4 心法
	[101]=function ()
		local sid = CI_GetPlayerData(17)
		local CI_LearnSkill = CI_LearnSkill
		local GetLevelUpEquip = GetLevelUpEquip
		
		local school = CI_GetPlayerData(2)
		----rfalse("职业"..school)
		--PI_PayPlayer(1,1000000000)
		local level = CI_GetPlayerData(1)
		level = mathfloor(level/10)
		if level < 3 then level = 2 end
		if level > 9 then level = 9 end
		for k,v in pairs( ItemScript_equipType ) do
			GetLevelUpEquip(v,school,level*10,0,3,1,1)
		end
		GiveMounts(CI_GetPlayerData(17))

		if school == 1 then
			local a=CI_SetSkillLevel(1,108,1,12)
			
		elseif school == 2 then
			CI_SetSkillLevel(1,123,1,12)
		elseif school == 3 then
			CI_SetSkillLevel(1,124,1,12)
		end

		--GiveGoods(0,90000000)
		--DGiveP(99999999,'101')
		--GiveGoods(102,1)
		--AddPlayerPoints( sid , 3 , 9000000,nil,'101' )
		--AddPlayerPoints( sid , 2 , 90000000,nil,'101' )

		TipCenter("hey brother, you're NB now !")
	end,
	--GM专用任务卡
	[104]=function ()
		local sid = CI_GetPlayerData(17)
		--开启坐骑
		GiveMounts(sid)
		--经验
		PI_PayPlayer(1, 28000000,0,0,'GM专用任务卡')

		local taskData = GetDBTaskData(sid)
		if taskData then
			taskData.completed = {}
			taskData.current = {}
			taskData.current[1376] = {}
			MarkKillInfo( taskData, 1376 )
		end		
		--怒气技能
		local school = CI_GetPlayerData(2)
		if school == 1 then
			CI_SetSkillLevel(1,108,1,12)
		elseif school == 2 then
			CI_SetSkillLevel(1,123,1,12)
		elseif school == 3 then
			CI_SetSkillLevel(1,124,1,12)
		end
	end,	
		
	--新使用家将卡激活
	[200]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data,hid = HeroActiveProc(sid,index)
		if(result == 0)then --失败
			SendLuaMsg( 0, { ids = Hero_Fail, t = 4, data = data}, 9 )
			return 0
		end
		
		SendLuaMsg( 0, { ids = Hero_Data, data = data, t = 4, hid = hid}, 9 )
	end,
	--坐骑幻化卡
	[300]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = MouseChangeProc(sid,index)
		if(result == 0)then --失败
			SendLuaMsg( 0, { ids = Horse_Fail, t = 3, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 3}, 9 )
	end,
	--封神王者礼包
	[674]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch({{636,10,1},{634,10,1}},"封神王者礼包")
	end,
	
	--封神至尊礼包
	[675]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 6 then
			TipCenter(GetStringMsg(14,6))
			return 0
		end
		GiveGoodsBatch({{636,80,1},{634,80,1},{710,20,1},{626,100,1},{627,100,1},{646,1,1}},"封神至尊礼包")
	end,


	--初级铜钱卡 双击使用后，可获得2000铜币  这4个要支持批量使用道具
	[600]=function (index)
		GiveGoods(0,2000,1,"铜钱卡")
	end,

	--高级铜钱卡 双击使用后，可获得10000铜币
	[601]=function (index)
		GiveGoods(0,10000,1,"铜钱卡")
	end,

	--初级灵力珠 双击使用后，可获得2000灵力
	[602]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 2 , 2000 ,nil,'初级灵力珠')
	end,

	--高级灵力珠 双击使用后，可获得10000灵力
	[603]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 2 , 10000 ,nil,'高级灵力珠')
	end,
	
	
	
	--随机宝石箱子
	[625]=function (index)
		local blv = 0  --1级宝石
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		if index == 624 then
			blv = 1  --2级宝石
		elseif index == 625 then
			blv = 2  --3级宝石
		elseif index == 663 then
			blv = 3  --4级宝石
		elseif index == 666 then
			blv = 4  --5级宝石
		elseif index == 677 then
			blv = 5  --6级宝石
		elseif index == 678 then
			blv = 6  --7级宝石
		elseif index == 1582 then
			blv = 7  --8级宝石
		elseif index == 1592 then
			blv = 8  --9级宝石
		end
		local r = mathrandom(0,7)
		local id = 410 + r*10 + blv
		GiveGoods(id,1,1,"宝石箱")
	end,

	--免战牌，双击使用后，8小时内避免您的山庄被人攻打 ,该道具重复使用时间可以累加
	[629]=function (index)
		local sid = CI_GetPlayerData(17)
		local selfMaData = GetManorData_Interf(sid)
		if selfMaData == nil then return 0 end
		local now = GetServerTime()
		if selfMaData.rbPT and selfMaData.rbPT > now then
			selfMaData.rbPT = selfMaData.rbPT + 8*60*60
		else
			selfMaData.rbPT = now + 8*60*60
		end
		SendLuaMsg( 0, { ids = MRB_Data,rpCD = selfMaData.rbPT }, 9 )
	end,

	--神秘箱子，要判断神秘钥匙 631是否存在，有的话，删一个钥匙然后抽奖
	[632]=function (index)
		--前台直连

	end,
	

	--鱼饵包
	[639]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		GiveGoods(638,10,1,"鱼饵包")
	end,

	--金元宝，使用后获得50个绑定元宝，支持批量使用
	[640]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 3 , 50,nil,'金元宝' )
	end,
	--小金元宝，使用后获得10个绑定元宝，支持批量使用
	[739]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 3 , 10,nil,'小金元宝' )
	end,
	--使用后获得1个绑定元宝，支持批量使用
	[817]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 3 , 1,nil,'金元宝' )
	end,
	
	--大地灵石 蕴含大地灵力的灵石，使用后，山庄可获得经验50点。
	[642]=function (index)
		if index == 633 then
			AddManorExp(CI_GetPlayerData(17),10)
			TipCenter(GetStringMsg(13,10))
		elseif index == 643 then
			AddManorExp(CI_GetPlayerData(17),30)
			TipCenter(GetStringMsg(13,30))
		elseif index == 642 then
			AddManorExp(CI_GetPlayerData(17),50)
			TipCenter(GetStringMsg(13,50))
		end
	end,

	--VIP令牌，开启VIP抽奖。
	[644]=function (index)
		--前台直连
		return 0
	end,
	--传说之石包
	[662]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		GiveGoods(637,50,1,"传说之石包")
	end,

	--讨伐令 双击使用后，增加1次山庄掠夺的次数。
	[670]=function (index)
		local sid = CI_GetPlayerData(17)
		local ret = CheckTimes(sid,TimesTypeTb.rob_fight,1,0)
		if not ret then
			return 0
		end
	end,

	--增加10W经验
	[672]=function (index)
		
		PI_PayPlayer(1, 100000,0,0,'经验丹')
	end,
	--增加100W经验
	[673]=function (index)
		PI_PayPlayer(1, 1000000,0,0,'经验丹')
	end,
	--增加1W经验
	[679]=function (index)
		PI_PayPlayer(1, 10000,0,0,'经验丹')
	end,
	--给元宝
	[684]=function (index)
		DGiveP(1,'awards_元宝道具')
	end,
	--给元宝
	[809]=function (index)
		DGiveP(5,'awards_元宝道具')
	end,
	--给元宝
	[685]=function (index)
		DGiveP(10,'awards_元宝道具')
	end,
	--给元宝
	[686]=function (index)
		DGiveP(100,'awards_元宝道具')
	end,
	--给元宝
	[687]=function (index)
		DGiveP(1000,'awards_元宝道具')
	end,
	--战场宝箱
	 
	[689]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end				
		GiveGoodsBatch({WarLuckItem[mathrandom(1,#WarLuckItem)]},"战场宝箱")
	end,
	
	--梳妆盒，增加妲己好感度20点 
	[691]=function (index)
		local sid = CI_GetPlayerData(17)
		DJitemaddliking(sid,20,1)
		TipCenter(GetStringMsg(450))  --要弹提示
	end,
	
	--声望令牌，增加声望100点 
	[692]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 7 , 100 ,nil,'声望令牌')
		TipCenter(GetStringMsg(19,100))  --要弹提示
	end,
	
	--战功牌，增加战功100点 
	[693]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 6 , 100 ,nil,'战功牌')
		TipCenter(GetStringMsg(10,100))  --要弹提示
	end,
	
	--双击使用后，可获得一个随机紫色守护之魂。
	[694]=function (index)
		local sid = CI_GetPlayerData(17)
		return yy_item_getskill( sid,2 )
	end,
	
	--双击使用后，可获得一个随机橙色守护之魂。
	[695]=function (index)
		local sid = CI_GetPlayerData(17)
		return yy_item_getskill( sid,3 )
	end,
	--双击使用后，可获得一个守护之魂-经验球。
	[696]=function (index)
		local sid = CI_GetPlayerData(17)
		local res=yy_item_getskill( sid,1,100 )
		if res==0 then return 0 end
		TipCenter(GetStringMsg(451))  --要弹提示
		return 
	end,
	

	--炼骨丹礼包 炼骨丹*100
	[697]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end				
		GiveGoods(627,100,1,"炼骨丹礼包")
	end,
	
	--4级宝石礼包  双击使用后，可获得攻击、防御、气血4级宝石各8个。
	[698]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end				
		GiveGoodsBatch({{413,8,1},{423,8,1},{433,8,1},},"4级宝石礼包")

	end,

	--赎罪卡,减10点罪恶值
	[699]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 9 , -10 , nil,'赎罪卡',true)
		TipCenter(GetStringMsg(454))
	end,

	--VIP十天卡
	[700]=function (index)
		local sid = CI_GetPlayerData(17)		
		VIP_BuyLv(sid,nil,2,1)
	end,
	--VIP月卡
	[701]=function (index)
		local sid = CI_GetPlayerData(17)		
		VIP_BuyLv(sid,nil,3,1)
	end,
	--VIP半年卡
	[702]=function (index)
		local sid = CI_GetPlayerData(17)		
		VIP_BuyLv(sid,nil,4,1)
	end,
	-- 宝箱
	[703]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
		if school == 1 then
			GiveGoodsBatch({{5233,1,1,1,10},},'累充宝箱')			
		elseif school == 2 then
			GiveGoodsBatch({{5270,1,1,1,10},},'累充宝箱')
		elseif school == 3 then
			GiveGoodsBatch({{5307,1,1,1,10},},'累充宝箱')
		end
	end,
	
	[704]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
		if school == 1 then
			GiveGoodsBatch({{5344,1,1,1,10},},'累充宝箱')			
		elseif school == 2 then
			GiveGoodsBatch({{5381,1,1,1,10},},'累充宝箱')
		elseif school == 3 then
			GiveGoodsBatch({{5418,1,1,1,10},},'累充宝箱')
		end
	end,
	
	[705]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
		if school == 1 then
			GiveGoodsBatch({{5455,1,1,1,10},},'累充宝箱')			
		elseif school == 2 then
			GiveGoodsBatch({{5492,1,1,1,10},},'累充宝箱')
		elseif school == 3 then
			GiveGoodsBatch({{5529,1,1,1,10},},'累充宝箱')
		end
	end,
	
	[706]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
			GiveGoodsBatch({{5629,1,1,1,10},},'累充宝箱')			
	end,
	
	[707]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
			GiveGoodsBatch({{5597,1,1,1,10},},'累充宝箱')			
	end,
	
	[708]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
			GiveGoodsBatch({{5661,1,1,1,10},},'累充宝箱')			
	end,
	
	[709]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
			GiveGoodsBatch({{5565,1,1,1,10},},'累充宝箱')			
	end,
	--器魂
	[711]=function (index)
		local sid = CI_GetPlayerData(17)	
		return sowar_usebhun( sid)		
	end,
	--器灵
	[712]=function (index)
		local sid = CI_GetPlayerData(17)	
		return sowar_usebling( sid)	
	end,
	--法魂
	[730]=function (index)
		local sid = CI_GetPlayerData(17)	
		return gem_usebhun( sid)		
	end,
	--法灵
	[731]=function (index)
		local sid = CI_GetPlayerData(17)	
		return gem_usebling( sid)	
	end,
	--翼魂
	[763]=function (index)
		local sid = CI_GetPlayerData(17)	
		return wing_use_yh( sid)		
	end,
	--翼灵
	[764]=function (index)
		local sid = CI_GetPlayerData(17)	
		return wing_use_yl( sid)	
	end,
	
	--守护大经验球  +1000 经验
	[737]=function (index)
		local sid = CI_GetPlayerData(17)
		local res=yy_item_getskill( sid,1,1000 )
		if res==0 then return 0 end
		TipCenter(GetStringMsg(451))  --要弹提示
		return 
	end,
	
	--修为丹，获得本级经验的1%
	[738] = function(index)	
		--当前经验 52 ，本级经验53
		local mexp = CI_GetPlayerData(53)  
		--local level = CI_GetPlayerData(1)
		mexp = mathfloor(mexp/100)
		if mexp < 500000 then
			mexp = 500000
		end
		PI_PayPlayer(1, mexp,0,0,'修为丹')
		
	end,
	
	--橙色宝箱
	[740]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
		if school == 1 then
			GiveGoodsBatch({{5234,1,1},},'累充宝箱')			
		elseif school == 2 then
			GiveGoodsBatch({{5271,1,1},},'累充宝箱')
		elseif school == 3 then
			GiveGoodsBatch({{5308,1,1},},'累充宝箱')
		end
	end,
	
	[741]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
		if school == 1 then
			GiveGoodsBatch({{5345,1,1},},'累充宝箱')			
		elseif school == 2 then
			GiveGoodsBatch({{5382,1,1},},'累充宝箱')
		elseif school == 3 then
			GiveGoodsBatch({{5419,1,1},},'累充宝箱')
		end
	end,
	
	[742]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
		if school == 1 then
			GiveGoodsBatch({{5456,1,1},},'累充宝箱')			
		elseif school == 2 then
			GiveGoodsBatch({{5493,1,1},},'累充宝箱')
		elseif school == 3 then
			GiveGoodsBatch({{5530,1,1},},'累充宝箱')
		end
	end,
	
	[743]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
			GiveGoodsBatch({{5630,1,1},},'累充宝箱')			
	end,
	
	[744]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
			GiveGoodsBatch({{5598,1,1},},'累充宝箱')			
	end,
	
	[745]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
			GiveGoodsBatch({{5662,1,1},},'累充宝箱')			
	end,
	
	[746]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local school = CI_GetPlayerData(2)		
			GiveGoodsBatch({{5566,1,1},},'累充宝箱')			
	end,
	--吃丹药
	[754]=function (index)
		local sid = CI_GetPlayerData(17)
		return dy_usegoods( sid,index )		
	end,
	
	--开服活动百宝箱
	[774] = function (index)
		local sid = CI_GetPlayerData(17)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		--开启经验次数，10次内取1，10~20次取2，20~30次取3，30次以上取4
		local tb
		local  nownum=item_getnumactive( sid ,2)+1
		if nownum<10 then
			tb = BAIBAOXIANG[1]
		elseif nownum<20 then
			tb = BAIBAOXIANG[2]
		elseif nownum<30 then
			tb = BAIBAOXIANG[3]
		else
			tb = BAIBAOXIANG[4]
		end
		
		local num = mathrandom(1,10000)
		for k,v in pairs( tb ) do
			if num < v[4] then
				if v[1] > 0 then				
					GiveGoods(v[1],v[2],v[3],"百宝箱")
				else
					PI_PayPlayer(1,500000,0,0,'百宝箱')
					--记录次数
					item_addnumactive( sid ,2)
				end
				break
			end		
		end
	end,
	
	
	--勇气套装宝箱
	[775] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 7 then
			TipCenter(GetStringMsg(14,7))
			return 0
		end
		local school = CI_GetPlayerData(2)		
		if school == 1 then
			GiveGoodsBatch({{5341,1,1},{5226,1,1},{5448,1,1},{5558,1,1},{5590,1,1},{5622,1,1},{5654,1,1},},'勇气套装宝箱')			
		elseif school == 2 then
			GiveGoodsBatch({{5378,1,1},{5263,1,1},{5485,1,1},{5558,1,1},{5590,1,1},{5622,1,1},{5654,1,1},},'勇气套装宝箱')
		elseif school == 3 then
			GiveGoodsBatch({{5415,1,1},{5300,1,1},{5522,1,1},{5558,1,1},{5590,1,1},{5622,1,1},{5654,1,1},},'勇气套装宝箱')
		end	
	end,
	
	--双击使用可以获得500点历练值。
	[778] = function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 11 , 500 ,nil,'历练卷轴')
		TipCenter(GetStringMsg(29,500))  --要弹提示		
	end,
	--双击使用可以获得100点荣誉点。
	[779] = function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 10 , 100 ,nil,'荣誉勋章')
		TipCenter(GetStringMsg(30,100))  --要弹提示				
	end,
	--婚戒
	[787] = function (index)
		local sid = CI_GetPlayerData(17)
		return marry_usering( sid )			
	end,
	-- --婚戒打磨次数重置
	-- [791] = function (index)
	-- 	local sid = CI_GetPlayerData(17)
	-- 	return marry_timereset( sid)		
	-- end,
	--果园成长包
	[797] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,2))
			return 0
		end
		
		GiveGoodsBatch({{642,10,1},{1028,12,1}},"果园成长包")
	end,
	
	
	--新婚礼包·大
	[798] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,5))
			return 0
		end
		
		GiveGoodsBatch({{792,1,1},{790,13,1},{791,1,1},{1465,5,1},{2602,1,1}},"新婚礼包·大")
	end,
	
	--彩虹石礼包
	[799] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		
		GiveGoodsBatch({{626,100,1}},"彩虹石礼包")
	end,
	--新婚礼包
	[800] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		
		GiveGoodsBatch({{622,1,1},{790,9,1},{1465,3,1}},"新婚礼包")
	end,
	--获得100点跨服荣誉
	[808] = function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 13 , 100 ,nil,'跨服荣誉')
		TipCenter(GetStringMsg(30,100))  --要弹提示			
	end,
	--双击使用后，可获得一个随机红色守护之魂。
	[823]=function (index)
		local sid = CI_GetPlayerData(17)
		return yy_item_getskill( sid,4 )
	end,
    --双击使用后，可获得一个随机彩色守护之魂。
	[826]=function (index)
		local sid = CI_GetPlayerData(17)
		return yy_item_getskill( sid,5 )
	end,	
	--拾取铜钱
	[1000]=function (index)
		local num = 500
		if index == 1001 then
			num = 1000
		elseif index == 1002 then	
			num = 2000
		elseif index == 1003 then	
			num = 3000
		elseif index == 1004 then	
			num = 5000
		end
		GiveGoods(0,num,1,"拾取铜钱")
	end,
	--掉落拾取50级橙色防具碎片
	[1005] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		GiveGoods(652,1,1,"VIP副本拾取")
		
	end,
	--掉落拾取5点历练值
	[1006] = function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 11 , 5 ,nil,'历练副本拾取')
		
	end,
	--掉落拾取100点历练值
	[1007] = function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 11 , 100 ,nil,'历练副本拾取')		
	end,
	--掉落的星辰碎片
	[1008] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		GiveGoods(803,1,1,"副本拾取")	
	end,
	
		--给元宝
	[1009]=function (index)
		--DGiveP(1,'杀人爆元宝')
	end,
		--给元宝
	[1010]=function (index)
		--DGiveP(5,'杀人爆元宝')
	end,
		--给元宝
	[1011]=function (index)
		--DGiveP(10,'杀人爆元宝')
	end,
	--海蟹 用于在山庄举办海鲜大餐，或直接使用，获得灵气2000     这6个道具可以批量使用
	[1046]=function (index)  
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 2 , 2000 ,nil,'海蟹')
	end,
	--大龙虾 用于在山庄举办海鲜大餐，或直接使用，获得灵气6000
	[1047]=function (index)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 2 , 6000 ,nil,'大龙虾')
	end,
	--沙丁鱼 用于在山庄举办海鲜大餐，或直接使用，获得铜钱3000
	[1048]=function (index)
		GiveGoods(0,3000,1,"铜钱卡")
	end,
	--石斑鱼 用于在山庄举办海鲜大餐，或直接使用，获得铜钱9000
	[1049]=function (index)
		GiveGoods(0,9000,1,"铜钱卡")
	end,
	--海参 用于在山庄举办海鲜大餐，或直接使用，获得经验5000
	[1050]=function (index)
		PI_PayPlayer(1, 5000,0,0,'使用海参')
	end,
	--鲍鱼 用于在山庄举办海鲜大餐，或直接使用，获得经验15000
	[1051]=function (index)
		PI_PayPlayer(1, 15000,0,0,'使用鲍鱼')
	end,

	--勋章包 开启后可获得100个勋章
	[1053]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		GiveGoods(1052,100,1,"勋章包")
	end,

	--BUG反馈王者礼包 BUG反馈热心玩家，专属奖励礼包！
	[1575]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		GiveGoodsBatch({{710,1,1},{601,50,1},{603,50,1},{803,50,1}},"BUG反馈王者礼包")
	end,
	
	--BUG反馈至尊礼包 BUG反馈热心玩家，专属奖励礼包！
	[1576]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		GiveGoodsBatch({{710,3,1},{601,100,1},{603,100,1},{803,100,1}},"BUG反馈至尊礼包")
	end,
	
	--战场霸主宝箱
	[1074]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		GiveGoodsBatch({{1052,500,1},{670,3,1},{669,3,1}},"战场霸主宝箱")
		
	end,
	--战场精英宝箱
	[1075]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		GiveGoodsBatch({{1052,300,1},{670,1,1},{669,1,1}},"战场精英宝箱")
	end,
	--胜利者宝箱
	[1076]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch({{1052,300,1},{668,3,1}},"胜利者宝箱")
	end,
	--勇敢者宝箱
	[1077]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch({{1052,200,1},{668,1,1}},"勇敢者宝箱")

	end,

	--冠军宝箱
	[1078]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		GiveGoodsBatch({{669,3,1},{638,20,1},{682,15,1},{634,10,1}},"冠军宝箱")
	end,
	--亚军宝箱
	[1079]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		GiveGoodsBatch({{669,1,1},{638,10,1},{682,10,1},{634,8,1}},"亚军宝箱")
	end,
	--季军宝箱
	[1080]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		GiveGoodsBatch({{668,3,1},{638,5,1},{682,5,1},{634,5,1}},"亚军宝箱")
	end,

	-- --海美人礼包
	-- [1084]=function (index)
	-- 	local sid = CI_GetPlayerData(17)
	-- 	return es_ueslibao( sid )
	-- end,
	
	--帮会夺宝宝箱
	[1090]=function (index)
		local fid = CI_GetPlayerData(23)
		if fid == nil or fid == 0 then
			TipCenter(GetStringMsg(207))
			return 0						--帮会不存在
		end
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,2))
			return 0
		end
		
		local num = 1086
		num = index - num + 1 
		if num > 0 and num < 11 then
			GiveGoods(FactionLuckItem[mathrandom(1,#FactionLuckItem)],1,1,"帮会夺宝宝箱")
			--AddPlayerPoints( CI_GetPlayerData(17) , 4 , num*100 ,nil,'帮会夺宝宝箱')
			GiveGoods(682,num,1,"帮会夺宝宝箱") --称号
		end
		if mathrandom(0,10000) < num then
			GiveGoods(1125,1,1,"帮会夺宝宝箱") --称号
		end
	end,

	
	--妲己的香囊
	[1110]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		local num = 1
		local stone = 633
		if index == 1107 then
			num = 2
		elseif index == 1108 then 
			num = 3
		elseif index == 1109 then
			stone = 643
			num = 4
		elseif index == 1110 then
			stone = 643
			num = 5
		elseif index == 1111 then
			stone = 643
			num = 6
		elseif index == 1112 then
			stone = 642
			num = 7
		elseif index == 1113 then
			stone = 642
			num = 8
		end
		
		GiveGoodsBatch({{SeedItem[mathrandom(1,#SeedItem)],num,1},{stone,1,1}},"妲己香囊")
		if mathrandom(0,10000) < (index - 1105) then
			GiveGoods(1122,1,1,"妲己香囊") --称号
		end
	end,

	--变身符
	[1105]=function (index)
		if escort_not_trans() then
			TipCenter(GetStringMsg(11))
			return 0
		end
		local x,y,r = CI_GetCurPos()
		if r < 200 or r > 210 then
			if r > 99 then
				TipCenter(GetStringMsg(12))
				return 0
			end
		end
		CI_AddBuff(mathrandom(200,215),0,1,false)
	end,

	
	--使用后获得称号
	[1120]=function (index)
		local sid = CI_GetPlayerData(17)
		local tid = TitleItemList[index]
		if tid == nil then 
			return 0
		end
		
		local tm
		if tid == 32 then tm = GetServerTime() + 24*3600*30 end
		if  SetPlayerTitle(sid,tid,tm) == 1 then  --已经有称号
			TipCenter(GetStringMsg(15))
			return 0
		end
		TipCenter(GetStringMsg(16))
	end,
	
	--战场BUFF
	[1141]=function (index)
		CI_AddBuff(mathrandom(142,146),0,1,false)
	end,
	--战场变身BUFF
	[1142]=function (index)
		CI_AddBuff(229,0,1,false)
	end,
	
	--抽取卡牌
	[1100]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		if index == 1099 then	
			GiveGoods(mathrandom(1162,1167),1,1,"抽取卡牌") --3卷卡
		elseif index == 1100 then
			GiveGoods(mathrandom(1168,1173),1,1,"抽取卡牌") --4卷卡
		end
	end,
	
	
	--封神榜卡牌使用
	[1150]=function (index)
		local sid = CI_GetPlayerData(17)
		local res=card_useitem(sid,index)
		return res
	end,
	
	
	
	-- 经验副本拾取技能
	[1266]=function (index)
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <=0 then 
			return 0
		end
		expfb_getskill(sid,1)
	end,
	
	[1267]=function (index)
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <=0 then 
			return 0
		end
		expfb_getskill(sid,2)
	end,
	
	[1268]=function (index)
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <=0 then 
			return 0
		end
		expfb_getskill(sid,3)
	end,
	
	[1269]=function (index)
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <=0 then 
			return 0
		end
		expfb_getskill(sid,4)
	end,
	
	--捕鱼宝箱
	[1270]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		
		if index == 1270 then
			AddPlayerPoints( sid , 2 , 100000,nil,'捕鱼宝箱' )
			
		elseif index == 1271 then 
			AddPlayerPoints( sid , 2 , 150000,nil,'捕鱼宝箱' )
			GiveGoods(WarLuckItem[mathrandom(1,#WarLuckItem)][1],1,1,"捕鱼宝箱")
		elseif index == 1272 then
			AddPlayerPoints( sid , 2 , 200000,nil,'捕鱼宝箱' )
			GiveGoods(WarLuckItem[mathrandom(1,#WarLuckItem)][1],1,1,"捕鱼宝箱")
		elseif index == 1273 then
			AddPlayerPoints( sid , 2 , 300000,nil,'捕鱼宝箱' )
			GiveGoods(WarLuckItem[mathrandom(1,#WarLuckItem)][1],1,1,"捕鱼宝箱")
		elseif index == 1274 then
			AddPlayerPoints( sid , 2 , 500000,nil,'捕鱼宝箱' )
			GiveGoods(WarLuckItem[mathrandom(1,#WarLuckItem)][1],2,1,"捕鱼宝箱")
		end
		
		--GiveGoodsBatch({{SeedItem[mathrandom(1,#SeedItem)],num,1},{stone,1,1}},"妲己香囊")
		--if mathrandom(0,10000) < (index - 1105) then
		--	GiveGoods(1122,1,1,"妲己香囊") --称号
		--end
	end,
	
	--经验道具
	[1275]=function()
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <=0 then 
			return 0
		end
		local level = CI_GetPlayerData(1,2,sid)
		local addexp = mathfloor(level^2.6)*2
		PI_PayPlayer(1,addexp,0,0,'拾取经验球1')
		HeroAddExp(addexp)
	end,
	
	--经验道具2
	[1449]=function()
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <=0 then 
			return 0
		end
		local level = CI_GetPlayerData(1,2,sid)
		local addexp = mathfloor(level*350+15000)
		PI_PayPlayer(1,addexp,0,0,'拾取经验球2')
		HeroAddExp(addexp)
	end,
	
	-- 鞭炮
	[1457]=function()
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <=0 then 
			return 0
		end
		UpdateChunJieData(sid,1,5,2)	
	end,
	
	-- 烟花
	[1458]=function()
		local sid = CI_GetPlayerData(17)
		if sid == nil or sid <=0 then 
			return 0
		end
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return
		end
		UpdateChunJieData(sid,1,20,1)
		GiveGoods(1451,40,1,"烟花")
	end,
	
	--神装强化礼包
	[1276]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local num = mathrandom(1,10000)
		for k,v in pairs( XINYUNSHIBAOXIANG ) do
			if num < v[4] then
				GiveGoods(v[1],v[2],v[3],"神装强化礼包")
				TipCenter(GetStringMsg(42,v[2],v[1]))
				break
			end		
		end
		
	end,
	
	--幸运刮刮乐
	[1277]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local num = mathrandom(1,10000)
		for k,v in pairs( CHENGSESUIPIANBAOXIANG ) do
			if num < v[4] then
				GiveGoods(v[1],v[2],v[3],"幸运刮刮乐")
				TipCenter(GetStringMsg(42,v[2],v[1]))
				if v[5] == 1 then
					--公告
					BroadcastRPC('ggl_notice',CI_GetPlayerData(5),v[1])
				end
				break
			end		
		end
	end,
	
	--藏宝图
	[1283]=function (index)
		local sid = CI_GetPlayerData(17)
		return wb_usebu( sid,1 )
	end,
	
	--至尊封神礼包
	[1401]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		local zhanli = CI_GetPlayerData(62)
		if zhanli < 100000 then
			TipCenter(GetStringMsg(26,100000))
			return 0
		end
		GiveGoodsBatch({{417,1,1},{3062,1,1},{3042,1,1},{3048,1,1}},"至尊封神礼包")
	end,
	--豪华封神礼包
	[1402]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		local zhanli = CI_GetPlayerData(62)
		if zhanli < 70000 then
			TipCenter(GetStringMsg(26,70000))
			return 0
		end
		GiveGoodsBatch({{416,1,1},{3060,1,1},{3040,1,1},{3046,1,1}},"豪华封神礼包")
	end,
	--黄金封神礼包
	[1403]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,4))
			return 0
		end
		local zhanli = CI_GetPlayerData(62)
		if zhanli < 50000 then
			TipCenter(GetStringMsg(26,50000))
			return 0
		end
		GiveGoodsBatch({{415,1,1},{3059,1,1},{3039,1,1},{3045,1,1}},"黄金封神礼包")
	end,
	--攻击礼包
	[1404]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch({{626,10,1},{413,1,1}},"攻击礼包")
	end,
		--防御礼包
	[1405]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch({{626,10,1},{423,1,1}},"防御礼包")
	end,
		--气血礼包
	[1406]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch({{626,10,1},{433,1,1}},"气血礼包")
	end,
	--圣诞礼包
	[1407]=function (index)
		-- look('圣诞礼包',1)
		local sid = CI_GetPlayerData(17)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoods(1408,mathrandom(4,10),1,"圣诞礼包")
		
		if mathrandom(1,10000) >9990 then
			GiveGoods(711,1,1,"圣诞礼包")

			BroadcastRPC('sdlb_notice',CI_GetPlayerData(5),711)
		end
		--圣诞袜子功能，30，80，130，180次出4个
		local  nownum=item_getnumactive( sid ,1)+1
		--look(nownum,1)
		if nownum then 
			if nownum==22 or nownum==51 or nownum==97 or nownum==168 then
				GiveGoods(1410,1,1,"圣诞礼包")
				BroadcastRPC('sdlb_notice',CI_GetPlayerData(5),1410)
			end
		end
		item_addnumactive( sid ,1)
	end,
	--元旦礼包
	[1409]=function (index)
		local sid = CI_GetPlayerData(17)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		
		local tb = {1442,1444,1445}
		--次数可以整除 23 则开道具 1443
		local  nownum=item_getnumactive( sid ,3)+1
		if nownum%23==0 then
			GiveGoods(1443,mathrandom(4,10),1,"元旦礼包")
		else
			GiveGoods(tb[mathrandom(1,#tb)],mathrandom(4,10),1,"元旦礼包")
		end		
		item_addnumactive( sid ,3)
		--记录次数
	end,
	--骑兵礼包
	[1446] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,2))
			return 0
		end
		
		GiveGoodsBatch({{710,400,1},{711,1,1}},"骑兵礼包")
	end,
	--神翼礼包
	[1447] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		
		GiveGoodsBatch({{762,100,1}},"神翼礼包")
	end,
	--女神礼包
	[1448] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,2))
			return 0
		end
		
		GiveGoodsBatch({{634,100,1},{771,3,1}},"女神礼包")
	end,
	
	--新春开年大礼包
	[1459] = function (index)
	
		--2014-2-11 日即以后才能开启
		
			
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,5))
			return 0
		end
		
		GiveGoodsBatch({{0,1000000,1},{603,100,1},{691,20,1},{778,10,1}},"新春开年大礼包")
		local num = mathrandom(1,10000)
		for k,v in pairs( XINCHUNLIBAO ) do
			if num < v[4] then
				GiveGoods(v[1],v[2],v[3],"新春开年大礼包")
				RPC('GetRandomprops',k,1459)
				break
			end		
		end
	end,
	
	--新春祝福经验丹
	[1460] = function (index)
		--当前经验 52 ，本级经验53
		local mexp = CI_GetPlayerData(53)  
		local level = CI_GetPlayerData(1)
		local wlevel = GetWorldLevel() or 40
		
		if level - wlevel >= 2 then
			--等级比世界等级高2级以上，10%经验
			mexp = mathfloor(mexp/10)
		elseif level - wlevel >= 0 then
			--等级等于世界等级或高1级，20%经验
			mexp = mathfloor(mexp/5)
		elseif level - wlevel >= -2  then
			--等级比世界等级相同低2级内，33%经验
			mexp = mathfloor(mexp/3)
		end
			--否则升1级，本级经验低于1KW的按1KW计算
		if mexp < 10000000 then
			mexp = 10000000
		end		
		PI_PayPlayer(1, mexp,0,0,'新春祝福经验丹')
	end,
	
	--新春礼包
	[1461] = function (index)
			
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		
		GiveGoodsBatch({{1052,100,1},{626,20,1},{627,20,1}},"新春礼包")
	end,
	--婚礼烟花
	[1465] = function (index)
		local wlevel = GetWorldLevel() or 40
		local sid = CI_GetPlayerData(17)
		local name = CI_GetPlayerData(5)
		AddPlayerPoints( sid , 2 , wlevel*1000,nil,'婚礼烟花' )
		BroadcastRPC('marry_brcast',name)
	end,
	--新婚红包
	[1466] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,2))
			return 0
		end
		
		GiveGoodsBatch({{622,1,1},{778,1,1}},"新婚红包")
	end,
	--元宵
	[1470] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		
		GiveGoodsBatch({{796,2,1},{789,2,1},{778,3,1}},"元宵")
	end,
	--百服活动礼包
	[1471] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,2))
			return 0
		end
		GiveGoods(1464,mathrandom(5,10),1,"百服活动礼包")
		if mathrandom(0,10000) < 125 then 
			GiveGoods(1463,1,1,"百服活动礼包")		
		end
	end,
	--六一糖果
	[1483] = function (index)
		PI_PayPlayer(1, 100000,0,0,'六一糖果')
	end,
	--端午粽子礼包
	[1484]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local num = mathrandom(1,10000)
		for k,v in pairs( DUANWUZONGZI ) do
			if num < v[4] then
				GiveGoods(v[1],v[2],v[3],"端午粽子礼包")
				TipCenter(GetStringMsg(42,v[2],v[1]))
				break
			end		
		end
		
	end,
	--中秋豆沙月饼
	[1572]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local num = mathrandom(1,10000)
		for k,v in pairs( ZHONGQIUYUEBING ) do
			if num < v[4] then
				GiveGoods(v[1],v[2],v[3],"中秋豆沙月饼")
				TipCenter(GetStringMsg(42,v[2],v[1]))
				break
			end		
		end
		
	end,
	--贡献礼包
	[1586]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local num = mathrandom(1,10000)
		for k,v in pairs( Gongxian ) do
			if num < v[4] then
				GiveGoods(v[1],v[2],v[3],"贡献礼包")
				TipCenter(GetStringMsg(42,v[2],v[1]))
				break
			end		
		end
		
	end,
	--玄天礼包
	[1593]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local num = mathrandom(1,10000)
		for k,v in pairs( Xuantian ) do
			if num < v[4] then
				GiveGoods(v[1],v[2],v[3],"玄天礼包")
				TipCenter(GetStringMsg(42,v[2],v[1]))
				break
			end		
		end
		
	end,
	--红包
	[1600]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local num = mathrandom(1,10000)
		for k,v in pairs( Hongbao ) do
			if num < v[4] then
				GiveGoods(v[1],v[2],v[3],"红包")
				TipCenter(GetStringMsg(42,v[2],v[1]))
				break
			end		
		end
		
	end,
	--三界至尊王者宝箱
	[1597] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		
		GiveGoodsBatch({{731,1,1},{712,1,1},{764,1,1}},"三界至尊王者宝箱")
	end,
	--三界至尊战神宝箱
	[1598] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		
		GiveGoodsBatch({{730,1,1},{711,1,1},{763,1,1}},"三界至尊战神宝箱")
	end,
	--星辰碎片宝箱（蓝）
	[827] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		
		GiveGoodsBatch({{803,40,1}},"星辰碎片宝箱")
	end,
	--星辰碎片宝箱（紫）
	[828] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		
		GiveGoodsBatch({{803,60,1}},"星辰碎片宝箱")
	end,
	--妖兽皮毛袋
	[829] = function (index)
		local pakagenum = isFullNum()
		if pakagenum < 2 then
			TipCenter(GetStringMsg(14,2))
			return 0
		end
		
		GiveGoodsBatch({{788,40,1},{789,5,1}},"妖兽皮毛袋")
	end,
	
	--红钻8级特权礼包
	[1487]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,5))
			return 0
		end
		GiveGoodsBatch({{603,100,1},{601,30,1},{762,20,1},{634,20,1},{639,3,1}},"360红钻礼包")
	end,
	--红钻8级特权礼包
	[1488]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,5))
			return 0
		end
		GiveGoodsBatch({{603,100,1},{3,10,1},{710,10,1},{778,20,1},{1485,1,1}},"360红钻礼包")
	end,
	--红钻8级特权礼包
	[1489]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,5))
			return 0
		end
		GiveGoodsBatch({{601,100,1},{778,100,1},{634,100,1},{639,10,1},{1486,1,1}},"360红钻礼包")
	end,
	--红钻8级特权礼包
	[1490]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,5))
			return 0
		end
		GiveGoodsBatch({{601,500,1},{710,20,1},{3,10,1},{634,48,1},{309,1,1}},"360红钻礼包")
	end,
	--红钻8级特权礼包
	[1491]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,5))
			return 0
		end
		GiveGoodsBatch({{603,50,1},{601,50,1},{778,10,1},{762,30,1},{789,10,1}},"360红钻礼包")
	end,
	--红钻8级特权礼包
	[1492]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,5))
			return 0
		end
		GiveGoodsBatch({{601,50,1},{636,50,1},{627,250,1},{639,6,1},{640,40,1}},"360红钻礼包")
	end,
	--第二届诸神之战冠军礼包
	[1495]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch({{813,1000,1},{1516,1,1},{312,1,1}},"第二届诸神之战冠军礼包")
	end,	
	--诸神之战冠军礼包
	[1496]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch({{813,1000,1},{1253,1,1},{2802,1,1}},"诸神之战冠军礼包")
	end,
	--时装
	[2601] = function (index)
		local sid = CI_GetPlayerData(17)
		return app_getone( sid,index )
	end,
	
	--兽神丹 ，使用后坐骑当前兽阶直接提升1级，要自动出现坐骑进化面板
	[3000]=function (index)
		
		local result,data,isup,cidx = MountUpFromGoods(sid)
		if(result == false)then --失败
			SendLuaMsg( 0, { ids = Horse_Fail, t = 6, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 6,up = isup, add = add, cidx = cidx}, 9 )
	end,

	--升仙丹，使用后，直接提升1级
	[3001]=function (index)
		--当前经验 52 ，本级经验53
		local mexp = CI_GetPlayerData(53)  
		local level = CI_GetPlayerData(1)
		if level < 100 then
			if level > 80 then  
				--由於80級后玩家滿級經驗所需太多,
				--所以改為每次加500000000
				local num = rint(mexp / 500000000) 
				local less = rint(mexp % 500000000)
				for i = 1, num do
					PI_PayPlayer(1, 500000000, 0,0,'升级丹')	
				end	
				PI_PayPlayer(1, less, 0,0,'升级丹')
			else 
				PI_PayPlayer(1, mexp,0,0,'升级丹')
			end
		else
			PI_PayPlayer(1, 50000000,0,0,'升级丹')
		end
	end,
	--坐骑丹优惠银卡
	[3002]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 700 , 0 , 1, "坐骑丹优惠银卡") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(636,100,1,"坐骑丹优惠银卡")
	end,
	--坐骑丹优惠金卡
	[3003]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 3500 , 0 , 1, "坐骑丹优惠金卡") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(636,500,1,"坐骑丹优惠金卡")
	end,
	--法宝优惠银卡
	[3004]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 700 , 0 , 1, "法宝优惠银卡") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(634,100,1,"法宝优惠银卡")
	end,
	--法宝优惠金卡
	[3005]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 3500 , 0 , 1, "法宝优惠金卡") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(634,500,1,"法宝优惠金卡")
	end,
	--洗练石优惠卡
	[3006]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 500 , 0 , 1, "洗练石优惠卡") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(605,250,1,"洗练石优惠卡")
	end,
	--宝石优惠银卡
	[3007]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 240 , 0 , 1, "宝石优惠银卡") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(412,2,1,"宝石优惠银卡")
		GiveGoods(422,2,1,"宝石优惠银卡")
		GiveGoods(432,2,1,"宝石优惠银卡")
	end,
		--宝石优惠金卡
	[3008]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 3 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 3840 , 0 , 1, "宝石优惠金卡") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(414,2,1,"宝石优惠金卡")
		GiveGoods(424,2,1,"宝石优惠金卡")
		GiveGoods(434,2,1,"宝石优惠金卡")
	end,
		--铜钱优惠卡
	[3009]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 288 , 0 , 1, "铜钱优惠卡") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(601,100,1,"铜钱优惠卡")
	end,
		--幸运石优惠卡
	[3010]=function (index)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , 960 , 0 , 1, "幸运石优惠卡") then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoods(616,30,1,"幸运石优惠卡")
	end,
	
	--坐骑阶数2~3阶之间时，双击使用后，坐骑星数立刻上升1星。<br/>坐骑当前阶数必须达到2阶才能使用
	--坐骑超过3阶时，固定获得配置经验。
	[3074]=function (index) --只在3阶使用
		local sid = CI_GetPlayerData(17)
		local result,data,isup,cidx = MountUpFromGoodsExp(sid,index)
		if(result == false)then --失败
			SendLuaMsg( 0, { ids = Horse_Fail, t = 7, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 6,up = isup, add = add, cidx = cidx}, 9 )
	end,
	
	[3011]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data,isup,cidx = MountUpFromGoodsExp(sid,3011)
		if(result == false)then --失败
			SendLuaMsg( 0, { ids = Horse_Fail, t = 7, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 6,up = isup, add = add, cidx = cidx}, 9 )
	end,
	--坐骑阶数3~4阶之间时，双击使用后，坐骑星数立刻上升1星。<br/>坐骑当前阶数必须达到3阶才能使用
	--坐骑超过4阶时，固定获得 230 点经验。
	[3012]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data,isup,cidx = MountUpFromGoodsExp(sid,3012)
		if(result == false)then --失败
			SendLuaMsg( 0, { ids = Horse_Fail, t = 7, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 6,up = isup, add = add, cidx = cidx}, 9 )
	end,
	--坐骑阶数4~5阶之间时，双击使用后，坐骑星数立刻上升1星。<br/>坐骑当前阶数必须达到4阶才能使用
	--坐骑超过5阶时，固定获得 450 点经验。
	[3013]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data,isup,cidx = MountUpFromGoodsExp(sid,3013)
		if(result == false)then --失败
			SendLuaMsg( 0, { ids = Horse_Fail, t = 7, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 6,up = isup, add = add, cidx = cidx}, 9 )
	end,
	--坐骑阶数5~6阶之间时，双击使用后，坐骑星数立刻上升1星。<br/>坐骑当前阶数必须达到5阶才能使用
	--坐骑超过6阶时，固定获得 770 点经验。
	[3014]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data,isup,cidx = MountUpFromGoodsExp(sid,3014)
		if(result == false)then --失败
			SendLuaMsg( 0, { ids = Horse_Fail, t = 7, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 6,up = isup, add = add, cidx = cidx}, 9 )
	end,
	--坐骑阶数6~7阶之间时，双击使用后，坐骑星数立刻上升1星。<br/>坐骑当前阶数必须达到6阶才能使用
	--坐骑超过7阶时，固定获得 1230 点经验。
	[3015]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data,isup,cidx = MountUpFromGoodsExp(sid,3015)
		if(result == false)then --失败
			SendLuaMsg( 0, { ids = Horse_Fail, t = 7, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 6,up = isup, add = add, cidx = cidx}, 9 )
	end,
	
	--[[
	3058 	2阶七彩羽毛	
	3059 	3阶七彩羽毛	
	3060 	4阶七彩羽毛	
	3061 	5阶七彩羽毛	
	3062 	6阶七彩羽毛	
	]]--
	
	[3058]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = wing_use_item(sid,3058)
		look('##############################')
		if(result == false)then --失败
			look('data'..data);
			SendLuaMsg( 0, { ids = Wing_Err, t = 6, data = data}, 9 )
			return 0
		end
	end,
	
	[3059]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = wing_use_item(sid,3059)
		if(result == false)then --失败
			SendLuaMsg( 0, { ids = Wing_Err, t = 6, data = data}, 9 )
			return 0
		end
	end,
	
	[3060]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = wing_use_item(sid,3060)
		if(result == false)then --失败
			SendLuaMsg( 0, { ids = Wing_Err, t = 6, data = data}, 9 )
			return 0
		end
	end,
	
	[3061]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = wing_use_item(sid,3061)
		if(result == false)then --失败
			SendLuaMsg( 0, { ids = Wing_Err, t = 6, data = data}, 9 )
			return 0
		end
	end,
	
	[3062]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = wing_use_item(sid,3062)
		if(result == false)then --失败
			SendLuaMsg( 0, { ids = Wing_Err, t = 6, data = data}, 9 )
			return 0
		end
	end,
	
	[3068]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = wing_use_item(sid,3068)
		if(result == false)then --失败
			SendLuaMsg( 0, { ids = Wing_Err, t = 6, data = data}, 9 )
			return 0
		end
	end,
	
	[3069]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = wing_use_item(sid,3069)
		if(result == false)then --失败
			SendLuaMsg( 0, { ids = Wing_Err, t = 6, data = data}, 9 )
			return 0
		end
	end,
	
	[3070]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data = wing_use_item(sid,3070)
		if(result == false)then --失败
			SendLuaMsg( 0, { ids = Wing_Err, t = 6, data = data}, 9 )
			return 0
		end
	end,
	
	[3038]=function (index)
		local sid = CI_GetPlayerData(17)
		local result,data,isup,cidx = MountUpFromGoodsExp(sid,index)
		if(result == false)then --失败
			SendLuaMsg( 0, { ids = Horse_Fail, t = 7, data = data}, 9 )
			return 0
		end
		SendLuaMsg( 0, { ids = Horse_Data, data = data, t = 6,up = isup, add = add, cidx = cidx}, 9 )
	end,
	
	--活动礼包
	[3020] = function(index)	
		local item = TimeItemConf[index]
		if item == nil then 
			return 0 
		end 
		local num = #item[2]		
		local pakagenum = isFullNum()
		if pakagenum < num then
			TipCenter(GetStringMsg(14,num))
			return 0
		end
		local sid = CI_GetPlayerData(17)
		if not CheckCost( sid , item[1] , 0 , 1, "每日首充礼包_"..tostring(index)) then
			TipCenter(GetStringMsg(1))
			return 0
		end
		GiveGoodsBatch(item[2],"每日首充礼包"..tostring(index))
	end,
	--初级七彩神铁
	[3033] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,2 )
	end,
	--中级七彩神铁
	[3034] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,3 )
	end,
	--高级七彩神铁
	[3035] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,4 )
	end,
	--完美七彩神铁
	[3036] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,5 )
	end,
	
	--2阶七彩矿
	[3044] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,2,1 )
	end,
	
	--3阶七彩矿
	[3045] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,3,1 )
	end,
	--4阶七彩矿
	[3046] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,4,1 )
	end,
	--5阶七彩矿
	[3047] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,5,1 )
	end,
	--6阶七彩矿
	[3048] = function(index)	
		local sid = CI_GetPlayerData(17)
		return sowar_addxy( sid,6,1 )
	end,


	
	--3阶女神祝福
	[3049] = function(index)	
		local sid = CI_GetPlayerData(17)
		return gem_uselvup( sid,3 )
	end,
	--4阶女神祝福
	[3050] = function(index)	
		local sid = CI_GetPlayerData(17)
		return gem_uselvup( sid,4 )
	end,
	--5阶女神祝福
	[3051] = function(index)	
		local sid = CI_GetPlayerData(17)
		return gem_uselvup( sid,5 )
	end,
	--6阶女神祝福
	[3052] = function(index)	
		local sid = CI_GetPlayerData(17)
		return gem_uselvup( sid,6 )
	end,
	--7阶女神祝福
	[3053] = function(index)	
		local sid = CI_GetPlayerData(17)
		return gem_uselvup( sid,7 )
	end,
	--8阶女神祝福
	[3054] = function(index)	
		local sid = CI_GetPlayerData(17)
		return gem_uselvup( sid,8 )
	end,
	--9阶女神祝福
	[3055] = function(index)	
		local sid = CI_GetPlayerData(17)
		return gem_uselvup( sid,9 )
	end,
	
	--双击使用可以获得100点狩猎积分。
	[824] = function (num)
		local sid = CI_GetPlayerData(17)
		zm_add_score(sid,100)
		TipCenter(GetStringMsg(31,100))  --要弹提示	
	end,	
	
		--双击使用可以获得100点狩猎积分。
	[1580] = function (num)
		local pakagenum = isFullNum()
		if pakagenum < 4 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch(GuoQingBaoXiang[1],"国庆至尊宝箱")
		local goods  = GuoQingBaoXiang[2]
		if math.random(1,100) < goods[4] then
			GiveGoods(goods[1],goods[2],goods[3],"国庆至尊宝箱")
			local name = CI_GetPlayerData(3)
			BroadcastRPC('gqbx_tip',name,goods[1],goods[2])  --全服广播
			
			--TipCenter(GetStringMsg(42,goods[2],goods[1]))
		end
	end,
    [1584] = function (num)
		local pakagenum = isFullNum()
		if pakagenum < 5 then
			TipCenter(GetStringMsg(14,3))
			return 0
		end
		GiveGoodsBatch(Wanshengbaoxiang[1],"万圣节宝箱")
		local goods  = Wanshengbaoxiang[2]
		if math.random(1,100) < goods[4] then
			GiveGoods(goods[1],goods[2],goods[3],"万圣节宝箱")
			local name = CI_GetPlayerData(3)
			BroadcastRPC('gqbx_tip',name,goods[1],goods[2])  --全服广播
			
			--TipCenter(GetStringMsg(42,goods[2],goods[1]))
		end
	end,	
	[9915] = function (inedex)
		local sid = CI_GetPlayerData(17)
		equip_jiezhi(sid, 9915)
	end,
}














-------------------------[[common Config end,]]-------------------------

-------------------------[[Batch Config Begin]]-------------------------
local call_OnUseItem_batch={
	--小血包
	[25]=function (num)
		local sid = CI_GetPlayerData(17)
		return xb_useitem( sid,300000*num )
	end,
	--大血包
	[26]=function (num)
		local sid = CI_GetPlayerData(17)
		return xb_useitem( sid,600000*num )
	end,
	--海蟹 用于在山庄举办海鲜大餐，或直接使用，获得灵气2000     这6个道具可以批量使用
	[1046]=function (num)  
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 2 , 2000*num ,nil,'海蟹')
	end,
	--大龙虾 用于在山庄举办海鲜大餐，或直接使用，获得灵气6000
	[1047]=function (num)  
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 2 , 6000*num,nil,'大龙虾' )
	end,
	--沙丁鱼 用于在山庄举办海鲜大餐，或直接使用，获得铜钱3000
	[1048]=function (num)  
		GiveGoods(0,3000*num,1,"沙丁鱼")
	end,
	--石斑鱼 用于在山庄举办海鲜大餐，或直接使用，获得铜钱9000
	[1049]=function (num)  
	
		GiveGoods(0,9000*num,1,"石斑鱼")
	end,
	--海参 用于在山庄举办海鲜大餐，或直接使用，获得经验5000
	[1050]=function (num)  
		PI_PayPlayer(1, 5000*num,0,0,'海参')
	end,
	--鲍鱼 用于在山庄举办海鲜大餐，或直接使用，获得经验15000
	[1051]=function (num)  
		PI_PayPlayer(1, 15000*num,0,0,'鲍鱼')
	end,
	--勋章包 开启后可获得100个勋章
	[1053]=function (num)
		local pakagenum = isFullNum()
		if pakagenum < 1 then
			TipCenter(GetStringMsg(14,1))
			return 0
		end
		GiveGoods(1052,100*num,1,"勋章包")
	end,
	
	--初级铜钱卡 双击使用后，可获得2000铜币  这4个要支持批量使用道具
	[600]=function (num)
		GiveGoods(0,2000*num,1,"铜钱卡")
	end,

	--高级铜钱卡 双击使用后，可获得10000铜币
	[601]=function (num)
		GiveGoods(0,10000*num,1,"铜钱卡")
	end,

	--初级灵力珠 双击使用后，可获得1000灵力
	[602]=function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 2 , 2000*num,nil,'初级灵力珠批量' )
	end,

	--初级灵力珠 双击使用后，可获得5000灵力
	[603]=function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 2 , 10000*num ,nil,'初级灵力珠批量')
	end,
	
	--金元宝,使用后获得50个绑定元宝，支持批量使用
	[640]=function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 3 , 50*num ,nil,'金元宝批量')
	end,
	--小金元宝，使用后获得10个绑定元宝，支持批量使用
	[739]=function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 3 , 10*num,nil,'小金元宝' )
	end,
	--使用后获得1个绑定元宝，支持批量使用
	[817]=function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 3 , 1*num,nil,'1绑定元宝' )
	end,
	--增加10W经验
	[672]=function (num)
		
		PI_PayPlayer(1, 100000*num,0,0,'经验丹')
	end,
	--增加100W经验
	[673]=function (num)
		PI_PayPlayer(1, 1000000*num,0,0,'经验丹')
	end,
	--增加1W经验
	[679]=function (num)
		PI_PayPlayer(1, 10000*num,0,0,'经验丹')
	end,
	
		--给元宝
	[684]=function (num)
		DGiveP(1*num,'awards_元宝道具')
	end,
	--给元宝
	[809]=function (num)
		DGiveP(5*num,'awards_元宝道具')
	end,
	--给元宝
	[685]=function (num)
		DGiveP(10*num,'awards_元宝道具')
	end,
	--给元宝
	[686]=function (num)
		DGiveP(100*num,'awards_元宝道具')
	end,
	--给元宝
	[687]=function (num)
		DGiveP(1000*num,'awards_元宝道具')
	end,
	
	--声望令牌，增加声望100点 
	[692]=function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 7 , 100*num ,nil,'声望令牌')
		TipCenter(GetStringMsg(19,100*num))  --要弹提示
	end,
	
	--战功牌，增加战功100点 
	[693]=function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 6 , 100*num ,nil,'战功牌')
		TipCenter(GetStringMsg(10,100*num))  --要弹提示
	end,
	
	[738] = function(num)	
		--当前经验 52 ，本级经验53
		local mexp = CI_GetPlayerData(53)  
		mexp = mathfloor(mexp/100)
		if mexp < 500000 then
			mexp = 500000
		end
		local total = mexp*num
		look(total,2)
		
		local hi = total / 0xFFFFFFF 
		for i=1,hi do
			PI_PayPlayer(1, 0xFFFFFFF,0,0,'修为丹')
		end
		local odd = total % 0xFFFFFFF
		PI_PayPlayer(1, odd,0,0,'修为丹')
	end,
	
	--双击使用可以获得500点历练值。
	[778] = function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 11 , 500*num ,nil,'历练卷轴')
		TipCenter(GetStringMsg(29,500*num))  --要弹提示		
	end,
	--双击使用可以获得100点荣誉点。
	[779] = function (num)
		local sid = CI_GetPlayerData(17)
		AddPlayerPoints( sid , 10 , 100*num ,nil,'荣誉勋章')
		TipCenter(GetStringMsg(30,100*num))  --要弹提示				
	end,
	
	--1级宝石箱
	[623] = function (num)
			for i = 1,num do
				GiveGoodsBatch({bsx[1][math.random(1,#bsx[1])]},"宝石箱")
			end
	end,
	
	--2级宝石箱
	[624] = function (num)
		for i = 1,num do
			GiveGoodsBatch({bsx[2][math.random(1,#bsx[2])]},"宝石箱")
		end
	end,
	
	--3级宝石箱
	[625] = function (num)
		for i = 1,num do
			GiveGoodsBatch({bsx[3][math.random(1,#bsx[3])]},"宝石箱")
		end
	end,
	
	--4级宝石箱
	[663] = function (num)
		for i = 1,num do
			GiveGoodsBatch({bsx[4][math.random(1,#bsx[4])]},"宝石箱")
		end
	end,
	
	--5级宝石箱
	[666] = function (num)
		for i = 1,num do
			GiveGoodsBatch({bsx[5][math.random(1,#bsx[5])]},"宝石箱")
		end
	end,
	
	--6级宝石箱
	[677] = function (num)
		for i = 1,num do
			GiveGoodsBatch({bsx[6][math.random(1,#bsx[6])]},"宝石箱")
		end
	end,
	
	--7级宝石箱
	[678] = function (num)
		for i = 1,num do
			GiveGoodsBatch({bsx[7][math.random(1,#bsx[7])]},"宝石箱")
		end
	end,
	
	--8级宝石箱
	[1582] = function (num)
		for i = 1,num do
			GiveGoodsBatch({bsx[8][math.random(1,#bsx[8])]},"宝石箱")
		end
	end,
	
	--9级宝石箱
	[1592] = function (num)
		for i = 1,num do
			GiveGoodsBatch({bsx[9][math.random(1,#bsx[9])]},"宝石箱")
		end
	end,

}
-------------------------[[Batch Config end,]]-------------------------

--普通道具使用（服务器调用）
function OnUseItem(scriptId, index, handle, useType)
	local func = call_OnUseItem[scriptId]
	if type(func) ~= TP_FUNC then
		return 0
	end

	local retValue = 0
	local ret = func(index, handle, useType)
	if ret == nil then
		retValue = 1
	else
		retValue = ret
	end

	if( ret == -1 )then
		return 0
	end

	return retValue
end

--宝石箱特殊处理
local batch_conf = {623,624,625,663,666,677,678,1582,}
--批量使用道具（只走脚本）scriptId为道具id
--目前支持使用批量道具表[前台需要](1046,1047,1048,1049,1050,1051,600,601,602,603)
--itype=true为购买并使用,直接扣钱,不给东西
function OnUseItem_batch(scriptId , num,bding,nbind,itype)
	if type(scriptId)~=type(0) or type(num)~=type(0) or num<0 then return end
	local func =call_OnUseItem_batch[scriptId]
	for k,v in pairs(batch_conf) do		--批量开启宝石箱特殊处理
		if v == scriptId then
			local packagenum = isFullNum()
			local packageneed = 0
			if num and num > 0 then
				if num > 8 then
					packageneed = 8
				else
					packageneed = num
				end
			end
			if packagenum < packageneed then
				TipCenter(GetStringMsg(14, packageneed))
				return
			end
		end
	end
	if type(func) ~= TP_FUNC then
		look('OnUseItem_batch id error id=='..tostring(scriptId),1)
		return 
	end
	if not itype then 
		if num~=bding+nbind then
			return
		end
		if bding>0 then
			if not (CheckGoods(scriptId, bding,2)==1) then
				return
			end
		end
		if nbind>0 then
			if not (CheckGoods(scriptId, nbind,5)==1) then
				return
			end
		end
	end
	local ret = func(num)
	return true
end
