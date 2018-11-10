--[[
file:	Hero_sill.lua
desc:	家将技能
author:	xiao.y
]]--
--------------------------------------------------------------------------
--include:
local math_floor = math.floor
local GetRWData = GetRWData
local HeroInfoTb = HeroInfoTb
local pairs = pairs
local CI_OperateHero = CI_OperateHero
local GetHeroData = GetHeroData
local PI_UpdateScriptAtt = PI_UpdateScriptAtt
local CheckGoods = CheckGoods
local GetPlayerPoints = GetPlayerPoints
local GetHeroAtts = GetHeroAtts
--------------------------------------------------------------------------
-- data:
--[[
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
-- 家将技能配置
hero_skill_conf = {
	num = {2,2,4,6,8}, --技能数
	maxlv = 5, --技能最高等级
	cost = {lq = 10000,goodid = 753,num = {1,2,3,5,8}},--lq 遗忘 需要消费10000灵气 封印 goodid 封印书ID num 各级所需元宝
	power = { --家将被动技能
		[10000] = { --att 给家将加的属性 rate 如果有，就是给人加的百分比，注意是百分比
			[1] = {name = '气血强化·初级',ico = 160,dec = '增加家将2000点气血',att = {[1] = 2000},},
			[2] = {name = '气血强化·中级',ico = 160,dec = '增加家将5000点气血',att = {[1] = 5000},},
			[3] = {name = '气血强化·高级',ico = 160,dec = '增加家将10000点气血',att = {[1] = 10000},},
			[4] = {name = '气血强化·大师级',ico = 160,dec = '增加家将15000点气血',att = {[1] = 15000},},
			[5] = {name = '气血强化·宗师级',ico = 160,dec = '增加家将30000点气血',att = {[1] = 30000},},
		},
		[20000] = {
			[1] = {name = '攻击强化·初级',ico = 161,dec = '增加家将300点攻击',att = {[3] = 300},},
			[2] = {name = '攻击强化·中级',ico = 161,dec = '增加家将600点攻击',att = {[3] = 600},},
			[3] = {name = '攻击强化·高级',ico = 161,dec = '增加家将1200点攻击',att = {[3] = 1200},},
			[4] = {name = '攻击强化·大师级',ico = 161,dec = '增加家将2500点攻击',att = {[3] = 2500},},
			[5] = {name = '攻击强化·宗师级',ico = 161,dec = '增加家将4000点攻击',att = {[3] = 4000},},
		},
		[30000] = {
			[1] = {name = '防御强化·初级',ico = 162,dec = '增加家将300点防御',att = {[4] = 300},},
			[2] = {name = '防御强化·中级',ico = 162,dec = '增加家将600点防御',att = {[4] = 600},},
			[3] = {name = '防御强化·高级',ico = 162,dec = '增加家将1200点防御',att = {[4] = 1200},},
			[4] = {name = '防御强化·大师级',ico = 162,dec = '增加家将2500点防御',att = {[4] = 2500},},
			[5] = {name = '防御强化·宗师级',ico = 162,dec = '增加家将4000点防御',att = {[4] = 4000},},
		},
		[40000] = {
			[1] = {name = '暴击强化·初级',ico = 163,dec = '增加家将150点暴击',att = {[7] = 150},},
			[2] = {name = '暴击强化·中级',ico = 163,dec = '增加家将300点暴击',att = {[7] = 300},},
			[3] = {name = '暴击强化·高级',ico = 163,dec = '增加家将600点暴击',att = {[7] = 600},},
			[4] = {name = '暴击强化·大师级',ico = 163,dec = '增加家将1200点暴击',att = {[7] = 1200},},
			[5] = {name = '暴击强化·宗师级',ico = 163,dec = '增加家将2000点暴击',att = {[7] = 2000},},
		},
		[50000] = { --att 给家将加的属性 rate 如果有，就是给人加的百分比，注意是百分比
			[1] = {name = '格挡回馈·初级',ico = 165,dec = '将家将格挡属性的5%返回给主角',rate = {[9] = 0.05},},
			[2] = {name = '格挡回馈·中级',ico = 165,dec = '将家将格挡属性的10%返回给主角',rate = {[9] = 0.1},},
			[3] = {name = '格挡回馈·高级',ico = 165,dec = '将家将格挡属性的15%返回给主角',rate = {[9] = 0.15},},
			[4] = {name = '格挡回馈·大师级',ico = 165,dec = '将家将格挡属性的30%返回给主角',rate = {[9] = 0.3},},
			[5] = {name = '格挡回馈·宗师级',ico = 165,dec = '将家将格挡属性的50%返回给主角',rate = {[9] = 0.5},},
		},
		[60000] = { 
			[1] = {name = '回避回馈·初级',ico = 166,dec = '将家将回避属性的5%返回给主角',rate = {[6] = 0.05},},
			[2] = {name = '回避回馈·中级',ico = 166,dec = '将家将回避属性的10%返回给主角',rate = {[6] = 0.1},},
			[3] = {name = '回避回馈·高级',ico = 166,dec = '将家将回避属性的15%返回给主角',rate = {[6] = 0.15},},
			[4] = {name = '回避回馈·大师级',ico = 166,dec = '将家将回避属性的30%返回给主角',rate = {[6] = 0.3},},
			[5] = {name = '回避回馈·宗师级',ico = 166,dec = '将家将回避属性的50%返回给主角',rate = {[6] = 0.5},},
		},
		[70000] = { 
			[1] = {name = '命中回馈·初级',ico = 167,dec = '将家将命中属性的5%返回给主角',rate = {[5] = 0.05},},
			[2] = {name = '命中回馈·中级',ico = 167,dec = '将家将命中属性的10%返回给主角',rate = {[5] = 0.1},},
			[3] = {name = '命中回馈·高级',ico = 167,dec = '将家将命中属性的15%返回给主角',rate = {[5] = 0.15},},
			[4] = {name = '命中回馈·大师级',ico = 167,dec = '将家将命中属性的30%返回给主角',rate = {[5] = 0.3},},
			[5] = {name = '命中回馈·宗师级',ico = 167,dec = '将家将命中属性的50%返回给主角',rate = {[5] = 0.5},},
		},
		[80000] = { 
			[1] = {name = '抗暴回馈·初级',ico = 168,dec = '将家将抗暴属性的5%返回给主角',rate = {[8] = 0.05},},
			[2] = {name = '抗暴回馈·中级',ico = 168,dec = '将家将抗暴属性的10%返回给主角',rate = {[8] = 0.1},},
			[3] = {name = '抗暴回馈·高级',ico = 168,dec = '将家将抗暴属性的15%返回给主角',rate = {[8] = 0.15},},
			[4] = {name = '抗暴回馈·大师级',ico = 168,dec = '将家将抗暴属性的30%返回给主角',rate = {[8] = 0.3},},
			[5] = {name = '抗暴回馈·宗师级',ico = 168,dec = '将家将抗暴属性的50%返回给主角',rate = {[8] = 0.5},},
		},
		[90000] = { 
			[1] = {name = '攻击回馈·初级',ico = 169,dec = '将家将攻击属性的5%返回给主角',rate = {[3] = 0.05},},
			[2] = {name = '攻击回馈·中级',ico = 169,dec = '将家将攻击属性的10%返回给主角',rate = {[3] = 0.1},},
			[3] = {name = '攻击回馈·高级',ico = 169,dec = '将家将攻击属性的15%返回给主角',rate = {[3] = 0.15},},
			[4] = {name = '攻击回馈·大师级',ico = 169,dec = '将家将攻击属性的30%返回给主角',rate = {[3] = 0.3},},
			[5] = {name = '攻击回馈·宗师级',ico = 169,dec = '将家将攻击属性的50%返回给主角',rate = {[3] = 0.5},},
		},
		[100000] = { 
			[1] = {name = '防御回馈·初级',ico = 170,dec = '将家将防御属性的5%返回给主角',rate = {[4] = 0.05},},
			[2] = {name = '防御回馈·中级',ico = 170,dec = '将家将防御属性的10%返回给主角',rate = {[4] = 0.1},},
			[3] = {name = '防御回馈·高级',ico = 170,dec = '将家将防御属性的15%返回给主角',rate = {[4] = 0.15},},
			[4] = {name = '防御回馈·大师级',ico = 170,dec = '将家将防御属性的30%返回给主角',rate = {[4] = 0.3},},
			[5] = {name = '防御回馈·宗师级',ico = 170,dec = '将家将防御属性的50%返回给主角',rate = {[4] = 0.5},},
		},
		[110000] = { 
			[1] = {name = '气血回馈·初级',ico = 171,dec = '将家将气血属性的5%返回给主角',rate = {[1] = 0.05},},
			[2] = {name = '气血回馈·中级',ico = 171,dec = '将家将气血属性的10%返回给主角',rate = {[1] = 0.1},},
			[3] = {name = '气血回馈·高级',ico = 171,dec = '将家将气血属性的15%返回给主角',rate = {[1] = 0.15},},
			[4] = {name = '气血回馈·大师级',ico = 171,dec = '将家将气血属性的30%返回给主角',rate = {[1] = 0.3},},
			[5] = {name = '气血回馈·宗师级',ico = 171,dec = '将家将气血属性的50%返回给主角',rate = {[1] = 0.5},},
		},
		[120000] = { 
			[1] = {name = '暴击回馈·初级',ico = 172,dec = '将家将暴击属性的5%返回给主角',rate = {[7] = 0.05},},
			[2] = {name = '暴击回馈·中级',ico = 172,dec = '将家将暴击属性的10%返回给主角',rate = {[7] = 0.1},},
			[3] = {name = '暴击回馈·高级',ico = 172,dec = '将家将暴击属性的15%返回给主角',rate = {[7] = 0.15},},
			[4] = {name = '暴击回馈·大师级',ico = 172,dec = '将家将暴击属性的30%返回给主角',rate = {[7] = 0.3},},
			[5] = {name = '暴击回馈·宗师级',ico = 172,dec = '将家将暴击属性的50%返回给主角',rate = {[7] = 0.5},},
		},
	},
	goods = { --技能书 对应 技能
		[1286] = {10000,1,1}, --气血强化{type,lv,档次(1-4)
		[1287] = {10000,2,5},
		[1288] = {10000,3,9},
		[1289] = {10000,4,13},
		[1290] = {10000,5},
		[1291] = {20000,1,1}, --攻击强化
		[1292] = {20000,2,5},
		[1293] = {20000,3,9},
		[1294] = {20000,4,13},
		[1295] = {20000,5},
		[1296] = {30000,1,1}, --防御强化
		[1297] = {30000,2,5},
		[1298] = {30000,3,6},
		[1299] = {30000,4,13},
		[1300] = {30000,5},
		[1301] = {40000,1,1}, --暴击强化
		[1302] = {40000,2,5},
		[1303] = {40000,3,9},
		[1304] = {40000,4,13},
		[1305] = {40000,5},
		[1306] = {209,1,1}, --毁灭
		[1307] = {210,1,1},
		[1308] = {211,1,1},
		[1309] = {212,1,1},
		[1310] = {213,1,},
		[1311] = {50000,1,2}, --格挡回馈{type,lv}
		[1312] = {50000,2,6},
		[1313] = {50000,3,10},
		[1314] = {50000,4,14},
		[1315] = {50000,5,},
		[1316] = {60000,1,2}, --回避回馈
		[1317] = {60000,2,6},
		[1318] = {60000,3,10},
		[1319] = {60000,4,14},
		[1320] = {60000,5,},
		[1321] = {70000,1,2}, --命中回馈
		[1322] = {70000,2,6},
		[1323] = {70000,3,10},
		[1324] = {70000,4,14},
		[1325] = {70000,5,},
		[1326] = {80000,1,2}, --抗暴回馈
		[1327] = {80000,2,6},
		[1328] = {80000,3,10},
		[1329] = {80000,4,14},
		[1330] = {80000,5,},
		[1331] = {214,1,3}, --致盲
		[1332] = {215,1,7},
		[1333] = {216,1,11},
		[1334] = {217,1,15},
		[1335] = {218,1,},
		[1336] = {219,1,4}, --脆弱
		[1337] = {220,1,8},
		[1338] = {221,1,12},
		[1339] = {222,1,16},
		[1340] = {223,1,},
		[1341] = {90000,1,3}, --攻击回馈{type,lv}
		[1342] = {90000,2,7},
		[1343] = {90000,3,11},
		[1344] = {90000,4,15},
		[1345] = {90000,5,},
		[1346] = {100000,1,3}, --防御回馈
		[1347] = {100000,2,7},
		[1348] = {100000,3,11},
		[1349] = {100000,4,15},
		[1350] = {100000,5,},
		[1351] = {110000,1,3}, --气血回馈
		[1352] = {110000,2,7},
		[1353] = {110000,3,11},
		[1354] = {110000,4,15},
		[1355] = {110000,5,},
		[1356] = {120000,1,3}, --暴击回馈
		[1357] = {120000,2,7},
		[1358] = {120000,3,11},
		[1359] = {120000,4,15},
		[1360] = {120000,5,},
	},
	limit = {
		[209] = 11,
		[210] = 12,
		[211] = 13,
		[212] = 14,
		[213] = 15,
		[214] = 21,
		[215] = 22,
		[216] = 23,
		[217] = 24,
		[218] = 25,
		[219] = 31,
		[220] = 32,
		[221] = 33,
		[222] = 34,
		[223] = 35,
	},
	up = { --技能升级道具配置
		--1升2 
		[1] = {{750,20},{751,3},}, -- [档次] = ｛道具列表｝
		[2] = {{750,40},{751,5},{752,1},},
		[3] = {{750,80},{751,12},{752,3},},
		[4] = {{750,80},{751,12},{752,6},},
		--2升3 
		[5] = {{750,45},{751,5},{752,1},},
		[6] = {{750,90},{751,12},{752,3},},
		[7] = {{750,180},{751,25},{752,10},},
		[8] = {{750,180},{751,25},{752,20},},
		--3升4 
		[9] = {{750,60},{751,12},{752,3},},
		[10] = {{750,120},{751,25},{752,10},},
		[11] = {{750,240},{751,45},{752,20},},
		[12] = {{750,240},{751,45},{752,40},},
		--4升5 
		[13] = {{750,80},{751,25},{752,10},},
		[14] = {{750,160},{751,45},{752,20},},
		[15] = {{750,320},{751,70},{752,35},},
		[16] = {{750,320},{751,70},{752,70},},
	},
}
local attNum = 14

local hero_skill = {}
local hero_skillLevel = {}

--家将技能升级
function up_hero_skill(sid,index,skillid,pos)
	local herodata = GetHeroData(sid)
	if(herodata == nil or herodata[index] == nil)then return false,1 end --家将不存在
	local hero = herodata[index]
	local id = hero[1]
	local htype = math_floor(id/1000)
	local hid = id % 1000
	if(HeroInfoTb[htype] == nil or HeroInfoTb[htype][hid] == nil)then return false,1 end --未找到对应武将
	if(hero.skill == nil or hero.skill[pos] == nil)then return false,2 end --无技能
	local curskill = hero.skill[pos]
	local curskillID = curskill[1]
	local curskillLv = curskill[2]
	if(curskillID~=skillid)then return false,3 end --技能Id不符
	
	local goods = hero_skill_conf.goods
	local quality --技能档次
	for gid,tb in pairs(goods) do
		if(type(tb) == type({}) and tb[1] == curskillID and tb[2] == curskillLv)then
			quality = tb[3]
			break
		end
	end
	if(quality == nil)then return false,4 end --已达等级上限
	local upgoods = hero_skill_conf.up[quality]
	if(upgoods == nil)then return false,6 end --升级技能配置出错
	
	for _,v in pairs(upgoods) do
		if(type(v) == type({}))then
			if(CheckGoods(v[1],v[2],1,sid)==0)then return false,7 end --道具不足
		end
	end
	
	if(curskillID>=10000)then --被动技能
		if(hero_skill_conf.power[curskillID] == nil)then return false,5 end --技能配置出错
		if(curskillLv>=hero_skill_conf.maxlv)then return false,4 end --已达等级上限
		
		curskillLv = curskillLv + 1
	else
		local limitSkill = hero_skill_conf.limit[curskillID]
		if(limitSkill==nil)then return false,5 end--技能配置出错
		if(math_floor(limitSkill%10)>=hero_skill_conf.maxlv)then return false,4 end --已达等级上限
		curskillID = curskillID + 1
		local newlimitSkill = hero_skill_conf.limit[curskillID]
		if(newlimitSkill == nil)then return false,5 end --技能配置出错
		if((math_floor(limitSkill%10)+1)~=math_floor(newlimitSkill%10) and math_floor(limitSkill/10)~=math_floor(newlimitSkill/10))then return false,5 end --技能配置出错
	end
	
	curskill[1] = curskillID
	curskill[2] = curskillLv
	
	for _,v in pairs(upgoods) do
		if(type(v) == type({}))then
			CheckGoods(v[1],v[2],0,sid,'家将技能升级')
		end
	end
	
	--这里加入计算个人属性，最后来写
	local fight = herodata.fight
	if(fight~=nil and fight == index)then
		local level,glevel,flevel
		level = hero[2]
		flevel = hero[4]
		glevel = hero[6]
		if(GetHeroAtts(htype,hid,level,flevel,glevel,hero.skill,hero.star))then
			local updateTb = GetRWData(2,true)
			local skillIdx = 1
			local hconf = HeroInfoTb[htype][hid]
			--清除技能
			for i = 1,#hero_skill do
				hero_skill[i] = nil
				hero_skillLevel[i] = nil
			end
			if(hconf.skill)then
				for i = 1,#hconf.skill do
					hero_skill[skillIdx] = hconf.skill[i]
					hero_skillLevel[skillIdx] = hconf.skilllevel[i]
					skillIdx = skillIdx + 1
				end
			end
			if(hero.skill)then
				for i = 1,8 do
					if(hero.skill[i]~=nil and type(hero.skill[i])==type({}) and hero.skill[i][1]<10000)then
						hero_skill[skillIdx] = hero.skill[i][1]
						hero_skillLevel[skillIdx] = hero.skill[i][2]
						skillIdx = skillIdx + 1
					end
				end
			end
			updateTb.skid = hero_skill
			updateTb.sklv = hero_skillLevel
			updateTb.id = hconf.rid
			local result = CI_OperateHero(2,index-1,updateTb)
			hero_set_power(sid,index,1)
		end
	end
	
	return true,herodata
end

--家将学习技能 goodid 技能书ID pos 空的技能位
function learn_hero_skill(sid,index,goodid,pos)
	local herodata = GetHeroData(sid)
	if(herodata == nil or herodata[index] == nil)then return false,1 end --家将不存在
	local hero = herodata[index]
	local id = hero[1]
	local htype = math_floor(id/1000)
	local hid = id % 1000
	if(HeroInfoTb[htype] == nil or HeroInfoTb[htype][hid] == nil)then return false,1 end --未找到对应武将
	local hconf = HeroInfoTb[htype][hid]
	local totalIdx = htype == 10 and hconf.color or htype
	local totalNum = hero_skill_conf.num[totalIdx]
	if(totalNum == nil or totalNum<pos)then return false,2 end -- 家将没有空余技能位
	
	if(CheckGoods(goodid,1,1,sid,'家将技能书')==0)then return false,5 end --没有足够道具
	local skillid = hero_skill_conf.goods[goodid]
	if(skillid == nil)then return false,3 end --技能不存在

	if(hero.skill~=nil)then
		if(hero.skill[pos]~=nil)then return false,6 end -- 当前技能位已有技能
		for i=1,totalNum do
			if(hero.skill[i]~=nil and type(hero.skill[i])==type({}))then
					if(hero.skill[i][1] == skillid[1])then 
						return false,4 -- 有同类型的技能了
					else
						if(hero_skill_conf.limit[hero.skill[i][1]] and hero_skill_conf.limit[skillid[1]] and math_floor(hero_skill_conf.limit[hero.skill[i][1]]/10)==math_floor(hero_skill_conf.limit[skillid[1]]/10))then
							return false,4 -- 有同类型的技能了
						end
					end
			end
		end
	end
	
	local temp_hero_skill = {} --家将单项技能 ｛id,lv｝
	temp_hero_skill[1] = skillid[1]
	temp_hero_skill[2] = skillid[2]
	if(hero.skill == nil)then hero.skill = {} end
	hero.skill[pos] = temp_hero_skill
	CheckGoods(goodid,1,0,sid,'家将技能书'..goodid)
	
	--这里加入计算个人属性，最后来写
	local fight = herodata.fight
	if(fight~=nil and fight == index)then
		local level,glevel,flevel
		level = hero[2]
		flevel = hero[4]
		glevel = hero[6]
		if(GetHeroAtts(htype,hid,level,flevel,glevel,hero.skill,hero.star))then
			local updateTb = GetRWData(2,true)
			local skillIdx = 1
			--清除技能
			for i = 1,#hero_skill do
				hero_skill[i] = nil
				hero_skillLevel[i] = nil
			end
			if(hconf.skill)then
				for i = 1,#hconf.skill do
					hero_skill[skillIdx] = hconf.skill[i]
					hero_skillLevel[skillIdx] = hconf.skilllevel[i]
					skillIdx = skillIdx + 1
				end
			end
			if(hero.skill)then
				for i = 1,8 do
					if(hero.skill[i]~=nil and type(hero.skill[i])==type({}) and hero.skill[i][1]<10000)then
						hero_skill[skillIdx] = hero.skill[i][1]
						hero_skillLevel[skillIdx] = hero.skill[i][2]
						skillIdx = skillIdx + 1
					end
				end
			end
			updateTb.skid = hero_skill
			updateTb.sklv = hero_skillLevel
			updateTb.id = hconf.rid
			local result = CI_OperateHero(2,index-1,updateTb)
			hero_set_power(sid,index,1)
		end
	end
	
	return true,herodata,skillid[1],skillid[2]
end

--[[
遗忘/封印 技能 
tp 0 遗忘 1 封印 
index 家将索引
pos 技能位置
skillid 技能ID（安全用）
]]--
function remove_hero_skill(sid,tp,index,pos,skillid,lv)
	local herodata = GetHeroData(sid)
	if(herodata == nil or herodata[index] == nil)then return false,1 end --家将不存在
	local hero = herodata[index]
	if(hero.skill == nil or hero.skill[pos] == nil)then return false,2 end --技能不存在
	local curskill = hero.skill[pos]
	if(curskill[1]~=skillid or curskill[2]~=lv)then return false,3 end --技能不符
	if(tp == 0)then -- 遗忘
		local needpt = hero_skill_conf.cost.lq
		local cpt = GetPlayerPoints(sid,2)
		if(cpt == nil or cpt<needpt)then return false,4 end --灵气不足升级
			
		hero.skill[pos] = nil
		AddPlayerPoints(sid,2, - needpt,nil,'家将技能遗忘扣除灵气',true)	
	elseif(tp == 1)then -- 封印
		local lv = curskill[2]
		local neednum = hero_skill_conf.cost.num[lv]
		local goodid = hero_skill_conf.cost.goodid
		if(CheckGoods(goodid,neednum,1,sid,'封印')==0)then return false,5 end --没有足够道具
		local goods = hero_skill_conf.goods
		local getGid --还原的技能书
		for gid,tb in pairs(goods) do
			if(tb~=nil and type(tb) == type({}))then
				if(tb[1] == curskill[1] and tb[2] == curskill[2])then
					getGid = gid
					break
				end
			end
		end
		if(getGid==nil)then return false,6 end --没找到对应道具
		local pakagenum = isFullNum()
		if pakagenum < 1 then return false,7 end --背包空格不足
		GiveGoods(getGid,1,1,"家将封印")
		CheckGoods(goodid,neednum,0,sid,'家将封印')
		hero.skill[pos] = nil
	end
	
	local fight = herodata.fight
	if(fight~=nil and fight == index)then
		local id = hero[1]
		local htype = math_floor(id/1000)
		local hid = id % 1000
		local conf = HeroInfoTb[htype][hid]
		local level,glevel,flevel
		level = hero[2]
		flevel = hero[4]
		glevel = hero[6]
		if(GetHeroAtts(htype,hid,level,flevel,glevel,hero.skill,hero.star))then
			local updateTb = GetRWData(2,true)
			--清除技能
			for i = 1,#hero_skill do
				hero_skill[i] = nil
				hero_skillLevel[i] = nil
			end
			local skillIdx = 1
			if(conf.skill)then
				for i = 1,#conf.skill do
					hero_skill[skillIdx] = conf.skill[i]
					hero_skillLevel[skillIdx] = conf.skilllevel[i]
					skillIdx = skillIdx + 1
				end
			end
			if(hero.skill)then
				for i = 1,8 do
					if(hero.skill[i]~=nil and type(hero.skill[i])==type({}) and hero.skill[i][1]<10000)then
						hero_skill[skillIdx] = hero.skill[i][1]
						hero_skillLevel[skillIdx] = hero.skill[i][2]
						skillIdx = skillIdx + 1
					end
				end
			end
			updateTb.id = conf.rid
			local result = CI_OperateHero(2,index-1,updateTb)
			if(hero.skill)then
				hero_set_power(sid,index,1)
			end
		end
	end
	
	return true,herodata
end

local hero_temp_rate = {}

--家将出战给主角加被动属性 isFight 1 出战 0 休战
function hero_set_power(sid,index,isFight)
	local herodata = GetHeroData(sid)
	if(herodata == nil or herodata[index] == nil)then return end --家将不存在
	local hero = herodata[index]
	local skill = hero.skill
	if(skill == nil)then return end --技能不存在
	local powerTb = hero_skill_conf.power
	local skillID,skillLv
	local tempRate
	
	for i = 1,attNum do
		hero_temp_rate[i] = 0
	end
	
	if(isFight == 1)then
		local isRate
		for _,tb in pairs(skill) do
			if(tb~=nil and type(tb) == type({}) and tb[1]~=nil and tb[1]>=10000)then
				--是被动技能
				skillID = tb[1]
				skillLv = tb[2]
				if(powerTb[skillID]~=nil and powerTb[skillID][skillLv]~=nil and powerTb[skillID][skillLv].rate~=nil)then
					tempRate = powerTb[skillID][skillLv].rate
					for i = 1,attNum do
						if(tempRate[i]~=nil)then
							hero_temp_rate[i] = hero_temp_rate[i] + tempRate[i]
							isRate = true
						end
					end
				end
			end
		end
		
		if(isRate)then
			--[[
			local id = hero[1]
			local lv = hero[2]
			local glevel = hero[6]
			local level = hero[4] --法化等级
			local htype = math_floor(id/1000)
			local hid = id % 1000
			if(GetHeroAtts(htype,hid,lv,flevel,level,skill))then
				local tb = GetRWData(2,true)
				for i = 1,attNum do
					if(hero_temp_rate[i]~=nil)then
						tb[i] = math_floor(tb[i]*(1+hero_temp_rate[i]))
					end
				end
				
				PI_UpdateScriptAtt(sid,3) -- 更新个人属性加成
			end
			]]--
			local tb = GetRWData(2,true)
			local AttTb = tb.att
			local temptb = GetRWData(1)
			
			for i = 1,attNum do
				if(hero_temp_rate[i]~=nil)then
					temptb[i] = math_floor(AttTb[i]*hero_temp_rate[i])
				end
			end
		else
			local temptb = GetRWData(1)
			for i = 1,attNum do
				temptb[i] = 0
			end
		end
		PI_UpdateScriptAtt(sid,3) -- 更新个人属性加成
	else
		local temptb = GetRWData(1)	
		for i = 1,attNum do
			temptb[i] = 0
		end
		PI_UpdateScriptAtt(sid,3)
	end
end