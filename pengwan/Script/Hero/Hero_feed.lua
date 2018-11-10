--[[
file:	Hero_feed.lua
desc:	武将修行
author:	xiao.y
update:2013-7-1
refix:	done by xy
]]--
--------------------------------------------------------------------------
--include:
local uv_TimesTypeTb = TimesTypeTb
local CheckTimes=CheckTimes
local HeroInfoTb = HeroInfoTb
local Hero_conf = Hero_conf
local GetHeroData = GetHeroData
local GetHeroAtts = GetHeroAtts
local GetPlayerPoints = GetPlayerPoints
local RandomInt = RandomInt
local AddPlayerPoints = AddPlayerPoints
local GetRWData = GetRWData
local CI_OperateHero = CI_OperateHero
local math_floor = math.floor
local look = look
local CI_GetPlayerData = CI_GetPlayerData
local GetPlayerTemp_custom = GetPlayerTemp_custom
local BroadcastRPC = BroadcastRPC
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos
local look = look
--------------------------------------------------------------------------
-- data:

function HeroFeedProc(sid,index)
	look('HeroFeedProc,'..sid..','..index)
	local herodata = GetHeroData(sid)
	if(herodata == nil)then return false,1 end --武将不存在
	local hero = herodata[index]
	if(hero == nil)then return false,1 end
	
	local id = hero[1]
	local lv = hero[2]
	local flevel = hero[4]
	local level = hero[6] --培养等级
	local proc = hero[7] --当前进度
	local totalPt = (hero[8] == nil) and 0 or hero[8]
	local oldlevel = level
	local skill = hero.skill
	local star = hero.star
	
	--local plevel = CI_GetPlayerData(1)
	--if(plevel<=level)then
	--	return false,4 --随从等级不能大于玩家等级
	--end
	
	if(level>=Hero_conf.mxlv)then return false,2 end --等级达上限
	
	local htype = math_floor(id/1000)
	local hid = id % 1000
	if(HeroInfoTb[htype] == nil or HeroInfoTb[htype][hid] == nil)then return false,1 end --未找到对应武将
	
	--if(level>=HeroInfoTb[htype][hid].maxlv)then return false,2 end --等级达上限
	
	local needpt = 2000*(level+1) --math_floor((level+1)/5*8)
	local isfree = CheckTimes(sid,uv_TimesTypeTb.HERO_Free,1,-1,1)
	if(not isfree)then
		local cpt = GetPlayerPoints(sid,2)
		if cpt == nil then
			return false,3 --战魂点数有问题
		end
		 
		if(cpt<needpt)then return false,3 end --点数不足升级
	end
	
	local nextlevel = level+1
	local nextproc = math_floor(nextlevel/1.5+1) --(nextlevel<30 and math_floor(nextlevel/2+1)) or math_floor(nextlevel^2/55)
	nextproc = nextproc * 10
	local isBVal = 1
	local val = RandomInt(1,1000)
	if(val<=300)then
		isBVal = 2
	elseif(val<=350)then
		isBVal = 5
	elseif(val<=360)then
		isBVal = 10
	end
	local conf
	proc = proc + isBVal*10
	local isElse = 0
	while(proc>=nextproc and nextproc>0)do
		proc = proc - nextproc
		level = level + 1
		if(level == 10)then --目标达成：将任意家将修行到10阶
			set_obj_pos(sid,1006)
		end
		--[[
		elseif(level == 30)then --目标达成：将任意家将修行到30阶
			set_obj_pos(sid,3003)
		end
		]]--
		if(level>=Hero_conf.mxlv)then
			isElse = 1
			break
		end
		nextlevel = level + 1
		nextproc = math_floor(nextlevel/1.5+1)
		--nextproc = (nextlevel<30 and math_floor(nextlevel/2+1)) or math_floor(nextlevel^2/55)
		nextproc = nextproc * 10
	end
	
	if(isfree)then
		CheckTimes(sid,uv_TimesTypeTb.HERO_Free,1,-1)
	else
		AddPlayerPoints(sid,2, - needpt,nil,'家将修行扣除灵气',true)
		totalPt = totalPt + needpt
	end	
		
	if(isElse == 1)then
		proc = nextproc
	end
	
	hero[6] = level
	hero[7] = proc
	hero[8] = totalPt

	local fight = herodata.fight
	local temp = GetPlayerTemp_custom(sid)
	local tempfight
	local isup
	if(temp~=nil)then
		tempfight = temp.fight
	end
	
	--look(herodata.fight)
	if(level~=oldlevel)then
		isup = 1
		if(fight~=nil and fight == index)then
			conf = HeroInfoTb[htype][hid]
			if(GetHeroAtts(htype,hid,lv,flevel,level,skill,star))then
				local updateTb = GetRWData(2,true)
				updateTb.id = conf.rid
				local result = CI_OperateHero(2,index-1,updateTb)
				if(skill)then
					hero_set_power(sid,index,1)
				end
				if(result~=nil and result>0 and tempfight~=nil)then
					tempfight[6] = level
				end
			end
		end
	end
	
	if(isBVal == 10)then
		BroadcastRPC('BJ_Notice',2,CI_GetPlayerData(3),isBVal,sid)
	end
	
	return true,herodata,isup,isBVal,level
end