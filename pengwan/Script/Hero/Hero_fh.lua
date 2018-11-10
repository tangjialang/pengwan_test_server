--[[
file:	Hero_feed.lua
desc:	家将法化
author:	xiao.y
update:2013-7-1
refix:	done by xy
]]--
--------------------------------------------------------------------------
--include:
local HeroInfoTb = HeroInfoTb
local Hero_conf = Hero_conf
local GetHeroData = GetHeroData
local CI_GetPlayerData = CI_GetPlayerData
local math_floor = math.floor
local CheckGoods = CheckGoods
local CheckCost = CheckCost
local GetHeroAtts = GetHeroAtts
local GetRWData = GetRWData
local CI_OperateHero = CI_OperateHero
local GetPlayerTemp_custom = GetPlayerTemp_custom
local RandomInt = RandomInt
local BroadcastRPC = BroadcastRPC
local look = look
--------------------------------------------------------------------------
-- data:
--家将法化
--sid人物ID
--index家将索引
--ctype 进化类型 0 花道具 1 道具不足花元宝
--num	道具个数
function HeroFHProc(sid,index,ctype,num)
	look('HeroFHProc,'..sid)
	local herodata = GetHeroData(sid)
	if(herodata == nil)then return false,1 end --家将不存在
	local hero = herodata[index]
	if(hero == nil)then return false,1 end
	
	local id = hero[1]
	local lv = hero[2]
	local glevel = hero[6]
	local level = hero[4] --法化等级
	local proc = hero[5] --当前进度
	local htype = math_floor(id/1000)
	local hid = id % 1000
	local skill = hero.skill
	
	--local plevel = CI_GetPlayerData(1)
	--if(plevel<=level)then
	--	return false,2 --随从等级不能大于玩家等级
	--end
	
	if(level>=Hero_conf.mxlv)then return false,3 end --等级达上限
	
	local oldlevel = level
	local nextlevel = level + 1
	local needs = math_floor(nextlevel/5+1) --需要的道具数
	local nextproc = (nextlevel<35 and math_floor(nextlevel/2+1)) or math_floor(nextlevel^2/65) --下一级经验进度
	nextproc = nextproc * 10
	local goodid = Hero_conf.good[1] --道具ID
	local cost = Hero_conf.good[2] --花费元宝数
	
	local spend = 0 --需要花费的元宝数

	if(ctype == 0)then --不花元宝
		if(CheckGoods(goodid,needs,1,sid,'家将法化')==0)then
			return false,4 --没有足够道具
		end
	else --道具不足扣元宝
		if(num<needs)then
			spend = (needs - num)*cost
			if(num>0 and CheckGoods(goodid,num,1,sid,'家将法化')==0)then
				return false,4 --没有足够道具
			end
			if(not CheckCost(sid, spend,1,1,"家将法化"))then
				return false,5 --元宝不足
			end
		else
			if(CheckGoods(goodid,needs,1,sid,'家将法化')==0)then
				return false,4 --没有足够道具
			end
		end
	end
	
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
		if(level>=Hero_conf.mxlv)then
			isElse = 1
			break
		end
		nextlevel = level + 1
		nextproc = (nextlevel<35 and math_floor(nextlevel/2+1)) or math_floor(nextlevel^2/65)
		nextproc = nextproc * 10
	end
	
	if(isElse == 1)then
		proc = nextproc
	end
	
	hero[4] = level
	hero[5] = proc

	if(spend>0)then --要扣元宝
		if(num>0)then
			CheckGoods(goodid,num,0,sid,"家将神化")
		end
		CheckCost(sid,spend,0,1,"家将神化")
	else
		CheckGoods(goodid,needs,0,sid,"家将神化")
	end
	
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
			if(GetHeroAtts(htype,hid,lv,flevel,level,skill))then
				local updateTb = GetRWData(2,true)
				updateTb.id = conf.rid
				local result = CI_OperateHero(2,index-1,updateTb)
				if(result~=nil and result>0 and tempfight~=nil)then
					tempfight[4] = level
				end
			end
		end
	end
	
	if(isBVal == 10)then
		BroadcastRPC('BJ_Notice',1,CI_GetPlayerData(3),isBVal,sid)
	end
	
	return true,herodata,isup,isBVal,level
end