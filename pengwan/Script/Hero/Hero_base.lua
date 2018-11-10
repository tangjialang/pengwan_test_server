--[[
file:	Hero_base.lua
desc:	武将
author:	xiao.y
update:2013-7-1
refix:	done by xy
]]--
--------------------------------------------------------------------------
--include:
local Hero_Data = msgh_s2c_def[9][1]
local Hero_UpdateExp = msgh_s2c_def[9][3]
local HeroInfoTb = HeroInfoTb
local Hero_conf = Hero_conf
local pairs = pairs
local SendLuaMsg = SendLuaMsg
local GetPlayer = GetPlayer
local CI_OperateHero = CI_OperateHero
local GetRWData = GetRWData
local math_floor = math.floor
local attNum = 14
local CI_GetPlayerData = CI_GetPlayerData
local look = look
local IsPlayerOnline = IsPlayerOnline

--------------------------------------------------------------------------
-- data:

--[[
家将数据结构
data = {
	[1] = {id,level,exp,flv,fproc,glv,gproc}, ID,家将等级，家将当前经验，家将法力等级，法力进度,成长等级，成长进度
	...
	[4] = {},
	ulk = {},道具解锁的家将
}
]]--

--随从技能
--获取随从数据					  
local function _GetHeroData(sid)
	if( sid == nil or sid == 0 )then return end
	local dataTb = GetHerosData_Interf(sid)
	return dataTb
end

--家将初始等级设置
local function _InitHeroLv(htype)
	--[[
	local lv
	if(htype == 1)then lv = 20
	elseif(htype == 2)then lv = 30
	elseif(htype == 3)then lv = 40
	elseif(htype >= 4)then lv = 50
	end
	return lv
	]]--
	return 20
end

--计算家将属性(glevel 成长等级 flevel 法力等级)
local function _GetHeroAtts(t,idx,level,flevel,glevel,skill,star)
	if(HeroInfoTb[t]~=nil and HeroInfoTb[t][idx]~=nil)then
		local group = HeroInfoTb[t][idx].group
		local tb = GetRWData(2)
		local AttTb = tb.att
		local addRate = 0 --法力的百分比加成
		
		if(glevel == nil)then glevel = 0 end
		if(flevel == nil)then flevel = 0 end
		if(glevel>0)then --培养等级加成
			if(flevel>0)then
				if(flevel>=100)then
					addRate = 0.8 + flevel/100
				elseif(flevel>=80)then
					addRate = 0.4 + flevel/100
				elseif(flevel>=60)then
					addRate = 0.2 + flevel/100
				elseif(flevel>=40)then
					addRate = 0.1 + flevel/100
				elseif(flevel>=20)then
					addRate = 0.05 + flevel/100 
				else
					addRate = flevel/100 
				end
			end
			for i = 1,attNum do
				if(group[i]~=nil and i~=13)then
					if(i == 1)then
						AttTb[i] = math_floor(((glevel+1)^2)*8.4+1)
					elseif(i == 3)then
						AttTb[i] = math_floor(((glevel+1)^2)*1+1)
					elseif(i == 4)then
						AttTb[i] = math_floor(((glevel+1)^2)*0.84+1)
					elseif(i == 5)then
						AttTb[i] = math_floor(((glevel+1)^2)*0.8+1)
					else
						AttTb[i] = math_floor(((glevel+1)^2)*0.4+1)
					end
				end
			end

			if(addRate>0)then
				for i = 1,attNum do
					if(AttTb[i]~=nil and i~=13)then --速度不加
						AttTb[i] = math_floor(AttTb[i]*(1+addRate))
					end
				end
			end
		end
		
		for i = 1,attNum do
			if(group[i]~=nil)then
				if(level<65)then
					if(i == 1)then
						AttTb[i] = AttTb[i] + math_floor((level^1.5)*group[i]*1.8+250)
					elseif(i == 3 or i == 4)then
						AttTb[i] = AttTb[i] +  math_floor((level^1.5)*group[i]*0.45+50)
					elseif(i == 13)then --速度
						AttTb[i] = group[i]
					else
						AttTb[i] = AttTb[i] +  math_floor((level^1.5)*group[i]*0.35+30)
					end
				else
					--[[CAT_MAX_HP	= 0,		// 血量上限 1
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
					CAT_S_REDUCE,			// 抗性减免	      14]]--
					if(i == 1)then
						AttTb[i] = AttTb[i] + math_floor(34400+(level-64)*50)
					elseif(i == 3)then
						AttTb[i] = AttTb[i] + math_floor(4097+(level-64)*10)
					elseif(i == 4)then
						AttTb[i] = AttTb[i] + math_floor(3442+(level-64)*8)
					elseif(i == 5)then
						AttTb[i] = AttTb[i] + math_floor(3277+(level-64)*5)
					elseif(i == 6 or i == 7 or i == 8 or i== 9)then
						AttTb[i] = AttTb[i] + math_floor(1638+(level-64)*1)
					--elseif(i == 7)then
					--	AttTb[i] = AttTb[i] + math_floor(1638+(level-64)*1)
					end
				end
			end
		end
		
		if(skill~=nil)then --新技能，计算加成属性
			local tempAtt
			local skillID,skillLv
			local powerTb = hero_skill_conf.power
			for _,tb in pairs(skill) do
				if(tb~=nil and type(tb) == type({}) and tb[1]~=nil and tb[1]>=10000)then
					skillID = tb[1]
					skillLv = tb[2]
					if(powerTb[skillID]~=nil and powerTb[skillID][skillLv]~=nil and powerTb[skillID][skillLv].att~=nil)then
						tempAtt = powerTb[skillID][skillLv].att
						for i = 1,attNum do
							if(tempAtt[i]~=nil)then
								AttTb[i] = AttTb[i] + tempAtt[i]
							end
						end
					end
				end
			end
		end
		
		if(star~=nil)then
			local rate
			if(star[1]~=nil)then
				rate = 0
				for i = 1,9 do
					if(star[1][i]~=nil)then
						rate = rate + star[1][i]
					end
				end
				if(star[4]~=nil and star[4][1]~=nil and star[4][2]~=nil and star[4][1] == 3)then
					rate = rate + star[4][2]
				end
				if(rate>0 and AttTb[3]>0)then
					AttTb[3] = math_floor(AttTb[3]*(100+rate)/100)
				end
			end
			if(star[2]~=nil)then
				rate = 0
				for i = 1,9 do
					if(star[2][i]~=nil)then
						rate = rate + star[2][i]
					end
				end
				if(star[4]~=nil and star[4][1]~=nil and star[4][2]~=nil and star[4][1] == 4)then
					rate = rate + star[4][2]
				end
				if(rate>0 and AttTb[4]>0)then
					AttTb[4] = math_floor(AttTb[4]*(100+rate)/100)
				end
			end
			if(star[3]~=nil)then
				rate = 0
				for i = 1,9 do
					if(star[3][i]~=nil)then
						rate = rate + star[3][i]
					end
				end
				if(star[4]~=nil and star[4][1]~=nil and star[4][2]~=nil and star[4][1] == 7)then
					rate = rate + star[4][2]
				end
				if(rate>0 and AttTb[7]>0)then
					AttTb[7] = math_floor(AttTb[7]*(100+rate)/100)
				end
			end
		end
		
		if(AttTb[13] == nil or AttTb[13] == 0)then AttTb[13] = 250 end --防止速度为0的情况
		--look(':::::::::::::::::::::::::::::::::::::::::::::::::::::::')
		--look(AttTb)
		return true
	end
end

local hero_skill = {}
local hero_skillLevel = {}

--设置出战 isFight 1 出战 0 休战
local function _HeroFight(sid,index,isFight,ischeck,auto)
	--look('_HeroFight')
	--look('90000000000000000000000000000000000000')
	local herodata = _GetHeroData(sid)
	if(herodata == nil or herodata[index] == nil)then return false,1 end --武将不存在
	if(isFight == 1)then
		herodata.auto = nil
		if(ischeck == nil)then
			if(herodata.fight ~= nil)then
				if(herodata.fight == index)then 
					return false,2 --已是出战状态
				end
				local result = _HeroFight(sid,herodata.fight,0)
				if(result == false)then return false,5 end
			end
		end	

		--清除技能
		for i = 1,#hero_skill do
			hero_skill[i] = nil
			hero_skillLevel[i] = nil
		end
		
		local curhero = herodata[index]
		local hid = curhero[1]
		local level = curhero[2]
		local flevel = curhero[4]
		local glevel = curhero[6]
		local newskill = curhero.skill
		local star = curhero.star
		
		local t = math_floor(hid/1000)
		local idx = hid%1000
		if(HeroInfoTb[t]==nil or HeroInfoTb[t][idx]==nil)then return false,1 end
		local conf = HeroInfoTb[t][idx]
		
		local fight
		local temp = GetPlayerTemp_custom(sid)
		if(temp ~= nil)then
			fight = temp.fight
		end
		local updateTb	
		local skillIdx = 1
		if(fight == nil)then	
			--第一次用需要更新，包括技能
			if(_GetHeroAtts(t,idx,level,flevel,glevel,newskill,star))then
				updateTb = GetRWData(2,true)
				updateTb.n = conf.name
				if(conf.skill)then
					for i = 1,#conf.skill do
						hero_skill[skillIdx] = conf.skill[i]
						hero_skillLevel[skillIdx] = conf.skilllevel[i]
						skillIdx = skillIdx + 1
					end
				end
				if(herodata[index].skill)then
					for i = 1,8 do
						if(curhero.skill[i]~=nil and type(curhero.skill[i])==type({}) and curhero.skill[i][1]<10000)then
							hero_skill[skillIdx] = curhero.skill[i][1]
							hero_skillLevel[skillIdx] = curhero.skill[i][2]
							skillIdx = skillIdx + 1
						end
					end
				end
				updateTb.skid = hero_skill
				updateTb.sklv = hero_skillLevel
				--updateTb.skid = conf.skill
				--updateTb.sklv = conf.skilllevel
				updateTb.id = conf.rid
				updateTb.lv = level
				--look(updateTb)
				local result = CI_OperateHero(1,index-1,updateTb)
				if(result~=nil)then
					--look('result1=========='..result)
					if(result>0)then
						temp.fight = {hid,level,flevel,glevel}
						herodata.fight = index
						if(newskill)then
							hero_set_power(sid,index,1)
						end
					end
				else
					return false,5
				end
			end
		elseif(hid ~= fight[1] or level ~= fight[2] or flevel ~= fight[3] or glevel ~= fight[4] or newskill~=nil or herodata.star~=nil)then
			--look('00000000000000000000000000000000000')
			--需要更新
			if(_GetHeroAtts(t,idx,level,flevel,glevel,newskill,star))then
				--look('888888888888888888888888888888888888')
				updateTb = GetRWData(2,true)
				updateTb.n = conf.name
				if(conf.skill)then
					for i = 1,#conf.skill do
						hero_skill[skillIdx] = conf.skill[i]
						hero_skillLevel[skillIdx] = conf.skilllevel[i]
						skillIdx = skillIdx + 1
					end
				end
				if(curhero.skill)then
					for i = 1,8 do
						if(curhero.skill[i]~=nil and type(curhero.skill[i])==type({}) and curhero.skill[i][1]<10000)then
							hero_skill[skillIdx] = curhero.skill[i][1]
							hero_skillLevel[skillIdx] = curhero.skill[i][2]
							skillIdx = skillIdx + 1
						end
					end
				end
				updateTb.skid = hero_skill
				updateTb.sklv = hero_skillLevel
				--updateTb.skid = conf.skill
				--updateTb.sklv = conf.skilllevel
				updateTb.id = conf.rid
				updateTb.lv = level
				--look(updateTb)
				local result = CI_OperateHero(1,index-1,updateTb)
				if(result~=nil)then
					--look('result2=========='..result)
					if(result>0)then
						--fight = {herodata[index][1],herodata[index][2]}
						fight[1] = hid
						fight[2] = level
						fight[3] = flevel
						fight[4] = glevel
						fight.skill = nil
						herodata.fight = index
						--look('55555555555555555555555555555555')
						if(newskill)then
							--look('55555555555555555555555555555555')
							hero_set_power(sid,index,1)
						end
					end
				else
					return false,5
				end
			end
		else
			--不需要更新
			local result = CI_OperateHero(1,index-1)
			if(result~=nil)then
				--look('result3=========='..result)
				if(result>0)then
					herodata.fight = index
				end
			else
				return false,5
			end
		end
	else
		if(herodata.fight == nil or herodata.fight ~= index)then return false,3 end --不是出战状态
		local result = CI_OperateHero(3,index-1)
		if(result~=nil)then
			--look('result4=========='..result)
			if(result>0)then
				if(auto~=nil)then
					herodata.auto = herodata.fight
				else
					herodata.auto = nil
					hero_set_power(sid,index,0)
				end
				herodata.fight = nil
			end
		else
			--look('result is nil')
			return false,5
		end
	end
	
	return true,herodata
end

--给随从
function GiveHeroFirst(sid)
	if( sid == nil or sid == 0 )then return end
	local data = GetHerosData_Interf(sid)
	if(data~=nil and data.init==nil)then
		data.init = 1
		data[1] = {1001,_InitHeroLv(1),0,0,0,0,0}
		_HeroFight(sid,1,1)
	end
	if(data~=nil)then
		SendLuaMsg( 0, { ids = Hero_Data, data = data, t = 0, sid = sid}, 9 )
	else
		SendLuaMsg( 0, { ids = Hero_Data, t = 0, sid = sid}, 9 )
	end
end

--发送武将数据
function _SendHeroData(sid,name,type,r)
	if(sid == nil and name~=nil)then
		sid = GetPlayer(name) or 0
	end
	if(not IsPlayerOnline(sid))then
		SendLuaMsg( 0, { ids = Hero_Data, t = 0, sid = sid, leave = 1}, 9 )
		return
	end
	local data = _GetHeroData(sid)
	if(r == nil)then
		if(data~=nil)then
			SendLuaMsg( 0, { ids = Hero_Data, data = data, t = 0, sid = sid, type = type, name = name}, 9 )
		else
			SendLuaMsg( 0, { ids = Hero_Data, t = 0, sid = sid}, 9 )
		end
	else
		return data
	end
end

--获得等级最大随从的战斗力
function GetHeroFPoint(sid)
	local herodata = _GetHeroData(sid)
	if(herodata == nil)then return 0,0 end --没有武将
	local maxPoint,index,hid = 0,-1
	local hdata
	local attTb
	local fightPoint
	local skill,star
	local id,level,htype,hid,glevel,flevel
	local math_floor = math_floor
	local rdtata
	for i = 1,4 do
		if(herodata[i]~=nil)then
			hdata = herodata[i]
			id = hdata[1]
			level = hdata[2]
			flevel = hdata[4]
			glevel = hdata[6]
			skill = hdata.skill
			star = hdata.star
			htype = math_floor(id/1000)
			hid = id % 1000
			if(_GetHeroAtts(htype,hid,level,flevel,glevel,skill,star))then
				local tb = GetRWData(2,true)
				attTb = tb.att
				if(attTb ~= nil)then
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
					--战斗力=（攻击+防御+暴击伤害）*1+（五行攻击+五行防御）*1.8+生命*0.5+（命中+闪避+暴击+格挡+抵抗）*1.3
					--（攻击+防御）1+生命0.2+（命中+闪避+暴击+格挡+抵抗）*1.3+特殊攻击2+（火系抗性+冰系抗性+木系抗性）1+抗性减免1.5
					fightPoint = math_floor(attTb[3]+attTb[4]+attTb[10]+attTb[11]+attTb[12]+attTb[1]*0.2+(attTb[5]+attTb[6]+attTb[7]+attTb[8]+attTb[9])*1.3 + attTb[2]*2 + attTb[14]*1.5)
					if(maxPoint<fightPoint)then
						index = id
						maxPoint = fightPoint
						rdata = herodata[i]
					end
				end
			end
		end
	end
	if(index == -1)then  return 0,0 end
	
	return index,maxPoint,rdata
end

--通过等级获取升级所需经验
local function _get_hero_total_exp(lv)
	--[[经验公式	
	1-40级	等级^2.5*10		
	41-50级	等级^2.8*10		
	51-60级	等级^3.2*10		
	61-70级	等级^3.4*10		
	70-100级	等级^3.6*10	
	]]--	
	local totalExp
	if(lv<=40)then
		totalExp = math_floor(lv^1.8*10)
	elseif(lv<=50)then
		totalExp = math_floor(lv^3*10)
	elseif(lv<=60)then
		totalExp = math_floor(lv^3*50)
	elseif(lv<=70)then
		totalExp = math_floor(lv^3.4*10)
	else
		totalExp = math_floor(lv^3.6*10)
	end
	
	return totalExp
end

--随从加经验
function HeroAddExp(addexp)
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then return end --sid获取失败
	local herodata = _GetHeroData(sid)
	if(herodata == nil or herodata.fight == nil or herodata[herodata.fight] == nil)then return end --没有家将出战
	local data = herodata[herodata.fight]
	local id = data[1]
	local lv = data[2]
	local hexp = data[3]
	if(lv>=Hero_conf.mxlv)then return end --家将满级了
	local plevel = CI_GetPlayerData(1)
	if(plevel<=lv)then return end --不能超过主角等级
	hexp = hexp + addexp
	local oldlv = lv
	local nextexp = _get_hero_total_exp(lv)
	while(hexp>=nextexp and nextexp>0)do --升级了 nextexp>0 保险用
		lv = lv+1
		hexp = hexp - nextexp
		if(lv>=Hero_conf.mxlv)then --满级了
			hexp = 0
			break
		end
		nextexp = _get_hero_total_exp(lv)
	end
	
	data[2] = lv
	data[3] = hexp
	
	if(oldlv~=lv)then --升级后的操作
		local htype = math_floor(id/1000)
		local hid = id % 1000
		local conf
		local updateTb
		local flevel = data[4] --法化等级
		local glevel = data[6] --修行等级
		local skill = data.skill
		local star = data.star
		conf = HeroInfoTb[htype][hid]
		if(_GetHeroAtts(htype,hid,lv,flevel,glevel,skill,star))then
			updateTb = GetRWData(2,true)
			updateTb.id = conf.rid
			updateTb.lv = lv
			local result = CI_OperateHero(2,herodata.fight-1,updateTb)
			if(result~=nil and result>0)then
				local temp = GetPlayerTemp_custom(sid)
				local tempfight
				if(temp~=nil)then
					tempfight = temp.fight
				end
				if(tempfight~=nil)then
					tempfight[2] = level
				end
			end
			if(skill)then
				hero_set_power(sid,herodata.fight,1)
			end
		end
	end
	SendLuaMsg( 0, { ids = Hero_UpdateExp, lv = lv, hexp = hexp, idx = herodata.fight}, 9 )
end

--登录自动召唤
function HeroAutoFight(sid)
	local temp = GetPlayerTemp_custom(sid)
	if(temp ~= nil and temp.fight ~= nil)then return end
	local herodata = _GetHeroData(sid)
	if(herodata == nil)then return end --武将不存在
	if(herodata.fight ~= nil)then
		_HeroFight(sid,herodata.fight,1,1)
	end
end

--自动召回家将
function HeroAutoBackFight(sid)
	local herodata = _GetHeroData(sid)
	if(herodata == nil or herodata.fight == nil)then return end --武将不存在
	local fightIdx = herodata.fight
	if(herodata[fightIdx] == nil)then return end --武将不存在
	local result = CI_OperateHero(3,fightIdx-1)
	if(result~=nil)then
		if(result>0)then
			herodata.fight = nil
			herodata.auto = fightIdx
			SendLuaMsg( 0, { ids = Hero_Data, data = herodata, t = 0}, 9 )
		end
	end
end

--自动出战家将
function HeroAutoFightForRelive(sid)
	local herodata = _GetHeroData(sid)
	if(herodata == nil or herodata.auto == nil)then return end
	local result,data = _HeroFight(sid,herodata.auto,1)
	if(result)then
		SendLuaMsg( 0, { ids = Hero_Data, data = data, t = 0}, 9 )
	end
end

--获取家将属性接口
function GetHeroInfo(sid,index)
	local herodata = _GetHeroData(sid)
	if(herodata == nil)then return end --家将不存在
	local hero = herodata[index]
	if(hero == nil)then return end --家将不存在
	
	local id = hero[1]
	local level = hero[2]
	local flevel = hero[4] --法化等级
	local glevel = hero[6] --修行等级
	local newskill = hero.skill
	local star = hero.star
	local htype = math_floor(id/1000)
	local hid = id % 1000
	if(HeroInfoTb[htype]==nil or HeroInfoTb[htype][hid]==nil)then return end --配置里没找到
	local hconf = HeroInfoTb[htype][hid]
	local hname = hconf.name
	local skill = hconf.skill
	local skilllevel = hconf.skilllevel
	local rid = hconf.rid
	if(_GetHeroAtts(htype,hid,level,flevel,glevel,newskill,star))then
		local tb = GetRWData(2,true)
		if(tb)then
			tb.n = hname
			tb.lv = level
			tb.id = rid
			tb.skid = skill
			tb.sklv = skilllevel
		end	
		return true
	end
end

--获取最近一次出战家将的ID
function get_cur_hero_fight(sid)
	local herodata = _GetHeroData(sid)
	if(herodata == nil)then return end --家将不存在
	if(herodata.fight~=nil)then return herodata.fight end
	local temp = GetPlayerTemp_custom(sid)
	if(temp==nil or temp.fight == nil or temp.fight[1] == nil)then return end
	for i = 1,4 do
		if(herodata[i]~=nil and herodata[i][1]~=nil and herodata[i][1] == temp.fight[1])then
			return i
		end
	end
end

GetHeroData = _GetHeroData
GetHeroAtts = _GetHeroAtts
HeroFight = _HeroFight
SendHeroData = _SendHeroData
InitHeroLv = _InitHeroLv