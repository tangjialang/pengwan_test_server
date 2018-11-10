--[[
file:	Hero_avert.lua
desc:	武将继承
author:	xiao.y
refix:	done by xy
]]--
--------------------------------------------------------------------------
--include:
local HeroInfoTb = HeroInfoTb
local GetHeroData = GetHeroData
local GetHeroAtts = GetHeroAtts
local GetPlayerPoints = GetPlayerPoints
local AddPlayerPoints = AddPlayerPoints
local GetRWData = GetRWData
local CI_OperateHero = CI_OperateHero
local math_floor = math.floor
local look = look
--------------------------------------------------------------------------
-- data:

--家将继承
function HeroAvertProc(sid,index,index1)
	look('HeroAvertProc')
	if(index == nil or index1 == nil or index == index1)then return false,5 end --继承的家将有误

	local herodata = GetHeroData(sid)
	if(herodata == nil)then return false,1 end --武将不存在
	
	local hero = herodata[index]
	if(hero == nil)then return false,1 end
	local hero1 = herodata[index1]
	if(hero1 == nil)then return false,1 end
	
	local fight = herodata.fight
	if(fight~=nil and (fight == index or fight == index1))then return false,2 end --家将在出战状态
	
	local id = hero[1]
	local level = hero[2]
	local proc1 = hero[3]
	local flevel = hero[4]
	local proc2 = hero[5]
	local glevel = hero[6]
	local proc3 = hero[7]
	local pt = (hero[8] == nil) and 0 or hero[8]
	--等级*0.5+成长等级*1+法力等级*1.5)^2*500+10000
	local needpt
	if(level<=20)then
		needpt = math_floor(glevel*2000)
	else
		needpt = math_floor((level*0.2+glevel)^2*500)+10000
	end
	
	local cpt = GetPlayerPoints(sid,2)
	if cpt == nil then
		return false,4 --战魂点数有问题
	end
	 
	if(cpt<needpt)then return false,4 end --点数不足升级
	
	local id1 = hero1[1]
	local level1 = hero1[2]
	local proc11 = hero1[3]
	local flevel1 = hero1[4]
	local proc12 = hero1[5]
	local glevel1 = hero1[6]
	local proc13 = hero1[7]
	local pt1 = (hero1[8] == nil) and 0 or hero1[8]
	
	--if(level<=level1 and flevel<=flevel1 and glevel<=glevel1)then return false,3 end --没有继承的必要
	
	if(level>level1)then
		level1 = level
		proc11 = proc1
	elseif(level==level1 and proc1>proc11)then
		proc11 = proc1
	end
	
	if(flevel>flevel1)then
		flevel1 = flevel
		proc12 = proc2
	elseif(flevel==flevel1 and proc2>proc12)then
		proc112 = proc2
	end
	
	if(glevel>glevel1)then
		glevel1 = glevel
		proc13 = proc3
	elseif(glevel==glevel1 and proc3>proc13)then
		proc13 = proc3
	end
	
	if(pt>pt1)then
		pt1 = pt
	end
	
	hero1[2] = level1
	hero1[3] = proc11
	hero1[4] = flevel1
	hero1[5] = proc12
	hero1[6] = glevel1
	hero1[7] = proc13
	hero1[8] = pt1
	local isUpdateSkill
	if(hero.skill~=nil)then
		hero1.skill = hero.skill
		isUpdateSkill = true
	end
	
	local starNum = _total_light_star(sid,index)
	
	if(starNum~=nil and starNum>0)then
		hero1.star = hero.star
	end
	
	local htype = math_floor(id/1000)
	local hid = id % 1000
	local htype1 = math_floor(id1/1000)
	local hid1 = id1 % 1000
	
	local lv = 1
	
	hero[2] = lv
	hero[3] = 0
	hero[4] = 0
	hero[5] = 0
	hero[6] = 0
	hero[7] = 0
	hero[8] = 0
	hero.skill = nil
	hero.star = nil
	
	AddPlayerPoints(sid,2, - needpt,nil,'家将传功扣除灵气',true)
	
	local fight = herodata.fight
	local temp = GetPlayerTemp_custom(sid)
	local tempfight
	if(temp~=nil)then
		tempfight = temp.fight
	end
	--[[
	if(fight~=nil)then
		local conf
		local updateTb
		if(fight == index)then
			conf = HeroInfoTb[htype][hid]
			if(GetHeroAtts(htype,hid,lv,0,0))then
				updateTb = GetRWData(2,true)
				updateTb.id = conf.rid
				updateTb.lv = lv
				local result = CI_OperateHero(2,index-1,updateTb)
				if(result~=nil and result>0 and tempfight~=nil)then
					tempfight[1] = id
					tempfight[2] = level
					tempfight[3] = flevel
					tempfight[4] = glevel
				end
			end
		elseif(fight == index1)then
			conf = HeroInfoTb[htype1][hid1]
			if(GetHeroAtts(htype1,hid1,level1,flevel1,glevel1))then
				updateTb = GetRWData(2,true)
				updateTb.id = conf.rid
				updateTb.lv = level1
				local result = CI_OperateHero(2,index-1,updateTb)
				if(result~=nil and result>0 and tempfight~=nil)then
					tempfight[1] = id1
					tempfight[2] = level1
					tempfight[3] = flevel1
					tempfight[4] = glevel1
				end
			end
		end
	end
	]]--
	
	return true,herodata
end