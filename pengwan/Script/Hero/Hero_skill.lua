--[[
file:	Hero_sill.lua
desc:	�ҽ�����
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
  	CAT_MAX_HP	= 0,		// Ѫ������ 1
	CAT_MAX_MP,				// ְҵ���� 2
	CAT_ATC,				// ���� 3
	CAT_DEF,				// ���� 4
	CAT_HIT,				// ���� 5
	CAT_DUCK,				// ���� 6
	CAT_CRIT,				// ���� 7
	CAT_RESIST,				// �ֿ� 8
	CAT_BLOCK,				// �� 9
	CAT_AB_ATC,				// ְҵ����1����ϵ���ԣ� 10
	CAT_AB_DEF,				// ְҵ����2����ϵ���ԣ� 11
	CAT_CritDam,			// ְҵ����3��ľϵ���ԣ�12
	CAT_MoveSpeed,			// �ƶ��ٶ�(Ԥ��) 13
	CAT_S_REDUCE,			// ���Լ���	      14
]]--
-- �ҽ���������
hero_skill_conf = {
	num = {2,2,4,6,8}, --������
	maxlv = 5, --������ߵȼ�
	cost = {lq = 10000,goodid = 753,num = {1,2,3,5,8}},--lq ���� ��Ҫ����10000���� ��ӡ goodid ��ӡ��ID num ��������Ԫ��
	power = { --�ҽ���������
		[10000] = { --att ���ҽ��ӵ����� rate ����У����Ǹ��˼ӵİٷֱȣ�ע���ǰٷֱ�
			[1] = {name = '��Ѫǿ��������',ico = 160,dec = '���Ӽҽ�2000����Ѫ',att = {[1] = 2000},},
			[2] = {name = '��Ѫǿ�����м�',ico = 160,dec = '���Ӽҽ�5000����Ѫ',att = {[1] = 5000},},
			[3] = {name = '��Ѫǿ�����߼�',ico = 160,dec = '���Ӽҽ�10000����Ѫ',att = {[1] = 10000},},
			[4] = {name = '��Ѫǿ������ʦ��',ico = 160,dec = '���Ӽҽ�15000����Ѫ',att = {[1] = 15000},},
			[5] = {name = '��Ѫǿ������ʦ��',ico = 160,dec = '���Ӽҽ�30000����Ѫ',att = {[1] = 30000},},
		},
		[20000] = {
			[1] = {name = '����ǿ��������',ico = 161,dec = '���Ӽҽ�300�㹥��',att = {[3] = 300},},
			[2] = {name = '����ǿ�����м�',ico = 161,dec = '���Ӽҽ�600�㹥��',att = {[3] = 600},},
			[3] = {name = '����ǿ�����߼�',ico = 161,dec = '���Ӽҽ�1200�㹥��',att = {[3] = 1200},},
			[4] = {name = '����ǿ������ʦ��',ico = 161,dec = '���Ӽҽ�2500�㹥��',att = {[3] = 2500},},
			[5] = {name = '����ǿ������ʦ��',ico = 161,dec = '���Ӽҽ�4000�㹥��',att = {[3] = 4000},},
		},
		[30000] = {
			[1] = {name = '����ǿ��������',ico = 162,dec = '���Ӽҽ�300�����',att = {[4] = 300},},
			[2] = {name = '����ǿ�����м�',ico = 162,dec = '���Ӽҽ�600�����',att = {[4] = 600},},
			[3] = {name = '����ǿ�����߼�',ico = 162,dec = '���Ӽҽ�1200�����',att = {[4] = 1200},},
			[4] = {name = '����ǿ������ʦ��',ico = 162,dec = '���Ӽҽ�2500�����',att = {[4] = 2500},},
			[5] = {name = '����ǿ������ʦ��',ico = 162,dec = '���Ӽҽ�4000�����',att = {[4] = 4000},},
		},
		[40000] = {
			[1] = {name = '����ǿ��������',ico = 163,dec = '���Ӽҽ�150�㱩��',att = {[7] = 150},},
			[2] = {name = '����ǿ�����м�',ico = 163,dec = '���Ӽҽ�300�㱩��',att = {[7] = 300},},
			[3] = {name = '����ǿ�����߼�',ico = 163,dec = '���Ӽҽ�600�㱩��',att = {[7] = 600},},
			[4] = {name = '����ǿ������ʦ��',ico = 163,dec = '���Ӽҽ�1200�㱩��',att = {[7] = 1200},},
			[5] = {name = '����ǿ������ʦ��',ico = 163,dec = '���Ӽҽ�2000�㱩��',att = {[7] = 2000},},
		},
		[50000] = { --att ���ҽ��ӵ����� rate ����У����Ǹ��˼ӵİٷֱȣ�ע���ǰٷֱ�
			[1] = {name = '�񵲻���������',ico = 165,dec = '���ҽ������Ե�5%���ظ�����',rate = {[9] = 0.05},},
			[2] = {name = '�񵲻������м�',ico = 165,dec = '���ҽ������Ե�10%���ظ�����',rate = {[9] = 0.1},},
			[3] = {name = '�񵲻������߼�',ico = 165,dec = '���ҽ������Ե�15%���ظ�����',rate = {[9] = 0.15},},
			[4] = {name = '�񵲻�������ʦ��',ico = 165,dec = '���ҽ������Ե�30%���ظ�����',rate = {[9] = 0.3},},
			[5] = {name = '�񵲻�������ʦ��',ico = 165,dec = '���ҽ������Ե�50%���ظ�����',rate = {[9] = 0.5},},
		},
		[60000] = { 
			[1] = {name = '�رܻ���������',ico = 166,dec = '���ҽ��ر����Ե�5%���ظ�����',rate = {[6] = 0.05},},
			[2] = {name = '�رܻ������м�',ico = 166,dec = '���ҽ��ر����Ե�10%���ظ�����',rate = {[6] = 0.1},},
			[3] = {name = '�رܻ������߼�',ico = 166,dec = '���ҽ��ر����Ե�15%���ظ�����',rate = {[6] = 0.15},},
			[4] = {name = '�رܻ�������ʦ��',ico = 166,dec = '���ҽ��ر����Ե�30%���ظ�����',rate = {[6] = 0.3},},
			[5] = {name = '�رܻ�������ʦ��',ico = 166,dec = '���ҽ��ر����Ե�50%���ظ�����',rate = {[6] = 0.5},},
		},
		[70000] = { 
			[1] = {name = '���л���������',ico = 167,dec = '���ҽ��������Ե�5%���ظ�����',rate = {[5] = 0.05},},
			[2] = {name = '���л������м�',ico = 167,dec = '���ҽ��������Ե�10%���ظ�����',rate = {[5] = 0.1},},
			[3] = {name = '���л������߼�',ico = 167,dec = '���ҽ��������Ե�15%���ظ�����',rate = {[5] = 0.15},},
			[4] = {name = '���л�������ʦ��',ico = 167,dec = '���ҽ��������Ե�30%���ظ�����',rate = {[5] = 0.3},},
			[5] = {name = '���л�������ʦ��',ico = 167,dec = '���ҽ��������Ե�50%���ظ�����',rate = {[5] = 0.5},},
		},
		[80000] = { 
			[1] = {name = '��������������',ico = 168,dec = '���ҽ��������Ե�5%���ظ�����',rate = {[8] = 0.05},},
			[2] = {name = '�����������м�',ico = 168,dec = '���ҽ��������Ե�10%���ظ�����',rate = {[8] = 0.1},},
			[3] = {name = '�����������߼�',ico = 168,dec = '���ҽ��������Ե�15%���ظ�����',rate = {[8] = 0.15},},
			[4] = {name = '������������ʦ��',ico = 168,dec = '���ҽ��������Ե�30%���ظ�����',rate = {[8] = 0.3},},
			[5] = {name = '������������ʦ��',ico = 168,dec = '���ҽ��������Ե�50%���ظ�����',rate = {[8] = 0.5},},
		},
		[90000] = { 
			[1] = {name = '��������������',ico = 169,dec = '���ҽ��������Ե�5%���ظ�����',rate = {[3] = 0.05},},
			[2] = {name = '�����������м�',ico = 169,dec = '���ҽ��������Ե�10%���ظ�����',rate = {[3] = 0.1},},
			[3] = {name = '�����������߼�',ico = 169,dec = '���ҽ��������Ե�15%���ظ�����',rate = {[3] = 0.15},},
			[4] = {name = '������������ʦ��',ico = 169,dec = '���ҽ��������Ե�30%���ظ�����',rate = {[3] = 0.3},},
			[5] = {name = '������������ʦ��',ico = 169,dec = '���ҽ��������Ե�50%���ظ�����',rate = {[3] = 0.5},},
		},
		[100000] = { 
			[1] = {name = '��������������',ico = 170,dec = '���ҽ��������Ե�5%���ظ�����',rate = {[4] = 0.05},},
			[2] = {name = '�����������м�',ico = 170,dec = '���ҽ��������Ե�10%���ظ�����',rate = {[4] = 0.1},},
			[3] = {name = '�����������߼�',ico = 170,dec = '���ҽ��������Ե�15%���ظ�����',rate = {[4] = 0.15},},
			[4] = {name = '������������ʦ��',ico = 170,dec = '���ҽ��������Ե�30%���ظ�����',rate = {[4] = 0.3},},
			[5] = {name = '������������ʦ��',ico = 170,dec = '���ҽ��������Ե�50%���ظ�����',rate = {[4] = 0.5},},
		},
		[110000] = { 
			[1] = {name = '��Ѫ����������',ico = 171,dec = '���ҽ���Ѫ���Ե�5%���ظ�����',rate = {[1] = 0.05},},
			[2] = {name = '��Ѫ�������м�',ico = 171,dec = '���ҽ���Ѫ���Ե�10%���ظ�����',rate = {[1] = 0.1},},
			[3] = {name = '��Ѫ�������߼�',ico = 171,dec = '���ҽ���Ѫ���Ե�15%���ظ�����',rate = {[1] = 0.15},},
			[4] = {name = '��Ѫ��������ʦ��',ico = 171,dec = '���ҽ���Ѫ���Ե�30%���ظ�����',rate = {[1] = 0.3},},
			[5] = {name = '��Ѫ��������ʦ��',ico = 171,dec = '���ҽ���Ѫ���Ե�50%���ظ�����',rate = {[1] = 0.5},},
		},
		[120000] = { 
			[1] = {name = '��������������',ico = 172,dec = '���ҽ��������Ե�5%���ظ�����',rate = {[7] = 0.05},},
			[2] = {name = '�����������м�',ico = 172,dec = '���ҽ��������Ե�10%���ظ�����',rate = {[7] = 0.1},},
			[3] = {name = '�����������߼�',ico = 172,dec = '���ҽ��������Ե�15%���ظ�����',rate = {[7] = 0.15},},
			[4] = {name = '������������ʦ��',ico = 172,dec = '���ҽ��������Ե�30%���ظ�����',rate = {[7] = 0.3},},
			[5] = {name = '������������ʦ��',ico = 172,dec = '���ҽ��������Ե�50%���ظ�����',rate = {[7] = 0.5},},
		},
	},
	goods = { --������ ��Ӧ ����
		[1286] = {10000,1,1}, --��Ѫǿ��{type,lv,����(1-4)
		[1287] = {10000,2,5},
		[1288] = {10000,3,9},
		[1289] = {10000,4,13},
		[1290] = {10000,5},
		[1291] = {20000,1,1}, --����ǿ��
		[1292] = {20000,2,5},
		[1293] = {20000,3,9},
		[1294] = {20000,4,13},
		[1295] = {20000,5},
		[1296] = {30000,1,1}, --����ǿ��
		[1297] = {30000,2,5},
		[1298] = {30000,3,6},
		[1299] = {30000,4,13},
		[1300] = {30000,5},
		[1301] = {40000,1,1}, --����ǿ��
		[1302] = {40000,2,5},
		[1303] = {40000,3,9},
		[1304] = {40000,4,13},
		[1305] = {40000,5},
		[1306] = {209,1,1}, --����
		[1307] = {210,1,1},
		[1308] = {211,1,1},
		[1309] = {212,1,1},
		[1310] = {213,1,},
		[1311] = {50000,1,2}, --�񵲻���{type,lv}
		[1312] = {50000,2,6},
		[1313] = {50000,3,10},
		[1314] = {50000,4,14},
		[1315] = {50000,5,},
		[1316] = {60000,1,2}, --�رܻ���
		[1317] = {60000,2,6},
		[1318] = {60000,3,10},
		[1319] = {60000,4,14},
		[1320] = {60000,5,},
		[1321] = {70000,1,2}, --���л���
		[1322] = {70000,2,6},
		[1323] = {70000,3,10},
		[1324] = {70000,4,14},
		[1325] = {70000,5,},
		[1326] = {80000,1,2}, --��������
		[1327] = {80000,2,6},
		[1328] = {80000,3,10},
		[1329] = {80000,4,14},
		[1330] = {80000,5,},
		[1331] = {214,1,3}, --��ä
		[1332] = {215,1,7},
		[1333] = {216,1,11},
		[1334] = {217,1,15},
		[1335] = {218,1,},
		[1336] = {219,1,4}, --����
		[1337] = {220,1,8},
		[1338] = {221,1,12},
		[1339] = {222,1,16},
		[1340] = {223,1,},
		[1341] = {90000,1,3}, --��������{type,lv}
		[1342] = {90000,2,7},
		[1343] = {90000,3,11},
		[1344] = {90000,4,15},
		[1345] = {90000,5,},
		[1346] = {100000,1,3}, --��������
		[1347] = {100000,2,7},
		[1348] = {100000,3,11},
		[1349] = {100000,4,15},
		[1350] = {100000,5,},
		[1351] = {110000,1,3}, --��Ѫ����
		[1352] = {110000,2,7},
		[1353] = {110000,3,11},
		[1354] = {110000,4,15},
		[1355] = {110000,5,},
		[1356] = {120000,1,3}, --��������
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
	up = { --����������������
		--1��2 
		[1] = {{750,20},{751,3},}, -- [����] = �������б��
		[2] = {{750,40},{751,5},{752,1},},
		[3] = {{750,80},{751,12},{752,3},},
		[4] = {{750,80},{751,12},{752,6},},
		--2��3 
		[5] = {{750,45},{751,5},{752,1},},
		[6] = {{750,90},{751,12},{752,3},},
		[7] = {{750,180},{751,25},{752,10},},
		[8] = {{750,180},{751,25},{752,20},},
		--3��4 
		[9] = {{750,60},{751,12},{752,3},},
		[10] = {{750,120},{751,25},{752,10},},
		[11] = {{750,240},{751,45},{752,20},},
		[12] = {{750,240},{751,45},{752,40},},
		--4��5 
		[13] = {{750,80},{751,25},{752,10},},
		[14] = {{750,160},{751,45},{752,20},},
		[15] = {{750,320},{751,70},{752,35},},
		[16] = {{750,320},{751,70},{752,70},},
	},
}
local attNum = 14

local hero_skill = {}
local hero_skillLevel = {}

--�ҽ���������
function up_hero_skill(sid,index,skillid,pos)
	local herodata = GetHeroData(sid)
	if(herodata == nil or herodata[index] == nil)then return false,1 end --�ҽ�������
	local hero = herodata[index]
	local id = hero[1]
	local htype = math_floor(id/1000)
	local hid = id % 1000
	if(HeroInfoTb[htype] == nil or HeroInfoTb[htype][hid] == nil)then return false,1 end --δ�ҵ���Ӧ�佫
	if(hero.skill == nil or hero.skill[pos] == nil)then return false,2 end --�޼���
	local curskill = hero.skill[pos]
	local curskillID = curskill[1]
	local curskillLv = curskill[2]
	if(curskillID~=skillid)then return false,3 end --����Id����
	
	local goods = hero_skill_conf.goods
	local quality --���ܵ���
	for gid,tb in pairs(goods) do
		if(type(tb) == type({}) and tb[1] == curskillID and tb[2] == curskillLv)then
			quality = tb[3]
			break
		end
	end
	if(quality == nil)then return false,4 end --�Ѵ�ȼ�����
	local upgoods = hero_skill_conf.up[quality]
	if(upgoods == nil)then return false,6 end --�����������ó���
	
	for _,v in pairs(upgoods) do
		if(type(v) == type({}))then
			if(CheckGoods(v[1],v[2],1,sid)==0)then return false,7 end --���߲���
		end
	end
	
	if(curskillID>=10000)then --��������
		if(hero_skill_conf.power[curskillID] == nil)then return false,5 end --�������ó���
		if(curskillLv>=hero_skill_conf.maxlv)then return false,4 end --�Ѵ�ȼ�����
		
		curskillLv = curskillLv + 1
	else
		local limitSkill = hero_skill_conf.limit[curskillID]
		if(limitSkill==nil)then return false,5 end--�������ó���
		if(math_floor(limitSkill%10)>=hero_skill_conf.maxlv)then return false,4 end --�Ѵ�ȼ�����
		curskillID = curskillID + 1
		local newlimitSkill = hero_skill_conf.limit[curskillID]
		if(newlimitSkill == nil)then return false,5 end --�������ó���
		if((math_floor(limitSkill%10)+1)~=math_floor(newlimitSkill%10) and math_floor(limitSkill/10)~=math_floor(newlimitSkill/10))then return false,5 end --�������ó���
	end
	
	curskill[1] = curskillID
	curskill[2] = curskillLv
	
	for _,v in pairs(upgoods) do
		if(type(v) == type({}))then
			CheckGoods(v[1],v[2],0,sid,'�ҽ���������')
		end
	end
	
	--����������������ԣ������д
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
			--�������
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

--�ҽ�ѧϰ���� goodid ������ID pos �յļ���λ
function learn_hero_skill(sid,index,goodid,pos)
	local herodata = GetHeroData(sid)
	if(herodata == nil or herodata[index] == nil)then return false,1 end --�ҽ�������
	local hero = herodata[index]
	local id = hero[1]
	local htype = math_floor(id/1000)
	local hid = id % 1000
	if(HeroInfoTb[htype] == nil or HeroInfoTb[htype][hid] == nil)then return false,1 end --δ�ҵ���Ӧ�佫
	local hconf = HeroInfoTb[htype][hid]
	local totalIdx = htype == 10 and hconf.color or htype
	local totalNum = hero_skill_conf.num[totalIdx]
	if(totalNum == nil or totalNum<pos)then return false,2 end -- �ҽ�û�п��༼��λ
	
	if(CheckGoods(goodid,1,1,sid,'�ҽ�������')==0)then return false,5 end --û���㹻����
	local skillid = hero_skill_conf.goods[goodid]
	if(skillid == nil)then return false,3 end --���ܲ�����

	if(hero.skill~=nil)then
		if(hero.skill[pos]~=nil)then return false,6 end -- ��ǰ����λ���м���
		for i=1,totalNum do
			if(hero.skill[i]~=nil and type(hero.skill[i])==type({}))then
					if(hero.skill[i][1] == skillid[1])then 
						return false,4 -- ��ͬ���͵ļ�����
					else
						if(hero_skill_conf.limit[hero.skill[i][1]] and hero_skill_conf.limit[skillid[1]] and math_floor(hero_skill_conf.limit[hero.skill[i][1]]/10)==math_floor(hero_skill_conf.limit[skillid[1]]/10))then
							return false,4 -- ��ͬ���͵ļ�����
						end
					end
			end
		end
	end
	
	local temp_hero_skill = {} --�ҽ������ ��id,lv��
	temp_hero_skill[1] = skillid[1]
	temp_hero_skill[2] = skillid[2]
	if(hero.skill == nil)then hero.skill = {} end
	hero.skill[pos] = temp_hero_skill
	CheckGoods(goodid,1,0,sid,'�ҽ�������'..goodid)
	
	--����������������ԣ������д
	local fight = herodata.fight
	if(fight~=nil and fight == index)then
		local level,glevel,flevel
		level = hero[2]
		flevel = hero[4]
		glevel = hero[6]
		if(GetHeroAtts(htype,hid,level,flevel,glevel,hero.skill,hero.star))then
			local updateTb = GetRWData(2,true)
			local skillIdx = 1
			--�������
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
����/��ӡ ���� 
tp 0 ���� 1 ��ӡ 
index �ҽ�����
pos ����λ��
skillid ����ID����ȫ�ã�
]]--
function remove_hero_skill(sid,tp,index,pos,skillid,lv)
	local herodata = GetHeroData(sid)
	if(herodata == nil or herodata[index] == nil)then return false,1 end --�ҽ�������
	local hero = herodata[index]
	if(hero.skill == nil or hero.skill[pos] == nil)then return false,2 end --���ܲ�����
	local curskill = hero.skill[pos]
	if(curskill[1]~=skillid or curskill[2]~=lv)then return false,3 end --���ܲ���
	if(tp == 0)then -- ����
		local needpt = hero_skill_conf.cost.lq
		local cpt = GetPlayerPoints(sid,2)
		if(cpt == nil or cpt<needpt)then return false,4 end --������������
			
		hero.skill[pos] = nil
		AddPlayerPoints(sid,2, - needpt,nil,'�ҽ����������۳�����',true)	
	elseif(tp == 1)then -- ��ӡ
		local lv = curskill[2]
		local neednum = hero_skill_conf.cost.num[lv]
		local goodid = hero_skill_conf.cost.goodid
		if(CheckGoods(goodid,neednum,1,sid,'��ӡ')==0)then return false,5 end --û���㹻����
		local goods = hero_skill_conf.goods
		local getGid --��ԭ�ļ�����
		for gid,tb in pairs(goods) do
			if(tb~=nil and type(tb) == type({}))then
				if(tb[1] == curskill[1] and tb[2] == curskill[2])then
					getGid = gid
					break
				end
			end
		end
		if(getGid==nil)then return false,6 end --û�ҵ���Ӧ����
		local pakagenum = isFullNum()
		if pakagenum < 1 then return false,7 end --�����ո���
		GiveGoods(getGid,1,1,"�ҽ���ӡ")
		CheckGoods(goodid,neednum,0,sid,'�ҽ���ӡ')
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
			--�������
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

--�ҽ���ս�����Ǽӱ������� isFight 1 ��ս 0 ��ս
function hero_set_power(sid,index,isFight)
	local herodata = GetHeroData(sid)
	if(herodata == nil or herodata[index] == nil)then return end --�ҽ�������
	local hero = herodata[index]
	local skill = hero.skill
	if(skill == nil)then return end --���ܲ�����
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
				--�Ǳ�������
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
			local level = hero[4] --�����ȼ�
			local htype = math_floor(id/1000)
			local hid = id % 1000
			if(GetHeroAtts(htype,hid,lv,flevel,level,skill))then
				local tb = GetRWData(2,true)
				for i = 1,attNum do
					if(hero_temp_rate[i]~=nil)then
						tb[i] = math_floor(tb[i]*(1+hero_temp_rate[i]))
					end
				end
				
				PI_UpdateScriptAtt(sid,3) -- ���¸������Լӳ�
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
		PI_UpdateScriptAtt(sid,3) -- ���¸������Լӳ�
	else
		local temptb = GetRWData(1)	
		for i = 1,attNum do
			temptb[i] = 0
		end
		PI_UpdateScriptAtt(sid,3)
	end
end