--[[
file:	hero_star.lua
desc:	星盘
author:	xiao.Y
]]--
--------------------------------------------------------------------------
--include:
local math_random = math.random
local GetPlayerPoints = GetPlayerPoints
local GetHeroData = GetHeroData
local AddPlayerPoints = AddPlayerPoints
local GetHeroAtts = GetHeroAtts
local GetRWData = GetRWData
local math_floor = math.floor
-------------------------------------------------------------------------
--星盘配
local star_conf = {
	[1] = {rate = 95000, vmin = 1,vmax = 3, lq = 30000},
	[2] = {rate = 85000, vmin = 2,vmax = 4, lq = 50000},
	[3] = {rate = 75000, vmin = 3,vmax = 5, lq = 70000},
	[4] = {rate = 65000, vmin = 4,vmax = 8, lq = 100000},
	[5] = {rate = 55000, vmin = 5,vmax = 9, lq = 130000},
	[6] = {rate = 45000, vmin = 6,vmax = 10, lq = 160000},
	[7] = {rate = 35000, vmin = 7,vmax = 12, lq = 200000},
	[8] = {rate = 25000, vmin = 8,vmax = 13, lq = 300000},
	[9] = {rate = 18000, vmin = 9,vmax = 14, lq = 500000},
	[10] = {vmin = 5,vmax = 15, lq = 300000, num = 15, att = {3,4,7}}, --本命星
}

-- data:
--获取星盘数据					  
local function _get_star_data(sid,index)
	local herodata = GetHeroData(sid)
	if(herodata == nil or herodata[index] == nil)then return end
	if(herodata[index].star == nil)then herodata[index].star = {} end
	local data = herodata[index].star
	return data
end

--获取某个星盘的数据
local function _get_star_type_data(sid,index,idx)
	local herodata = GetHeroData(sid)
	if(herodata == nil or herodata[index] == nil)then return end
	if(herodata[index].star == nil)then herodata[index].star = {} end
	local data = herodata[index].star
	if(data == nil)then return end
	if(data[idx] == nil)then data[idx] = {} end
	return data[idx]
end

--统计点亮的个数
function _total_light_star(sid,index)
	local data = _get_star_data(sid,index)
	if(data == nil)then return end
	local num = 0
	local val
	local tdata
	for i = 1,3 do
		tdata = _get_star_type_data(sid,index,i)
		if(tdata~=nil)then
			for j = 1,9 do
				if(tdata[j]~=nil)then
					num = num + 1
				end
			end
		end
	end
	return num
end

--设置星盘 t 0 强化 1　精炼 2 取消
function set_player_star(sid,index,idx,bit,t)
	if(idx<1 or idx>3 or bit>9 or bit<1)then return false,0 end --索引出错
	local herodata = GetHeroData(sid)
	if(herodata == nil)then return false,1 end --获取星盘数据出错
	local tdata = _get_star_type_data(sid,index,idx)
	if(tdata == nil)then return false,1 end --获取星盘数据出错
	local conf = star_conf[bit]
	if(conf == nil)then return false,4 end --配置有错
	local needlq = conf.lq
	local isfail
	
	if(t == 0)then --强化
		local num = _total_light_star(sid,index)
		if(num>=star_conf[10].num)then return false,7 end --已点亮15个灯
		if(bit>1 and tdata[bit-1] == nil)then return false,8 end --要强化的前面的灯必须亮
		if(tdata[bit]~=nil)then return false,3 end --已强化
		local cpt = GetPlayerPoints(sid,2)
		if(cpt == nil or cpt<needlq)then return false,5 end --灵气不足升级
		local rand = math_random(1,100000)
		if(rand>conf.rate)then
			if(bit>=4 and bit<=6)then
				tdata[4] = nil
				tdata[5] = nil
				tdata[6] = nil
			end
			if(bit>=7 and bit<=9)then
				tdata[7] = nil
				tdata[8] = nil
				tdata[9] = nil
			end
			isfail = 1
		else
			tdata[bit] = math_random(conf.vmin,conf.vmax)
			isfail = 0
		end
		AddPlayerPoints(sid,2, -needlq,nil,'星盘强化灵气扣除',true)
	elseif(t == 1)then --精炼
		if(tdata[bit]==nil)then return false,6 end --还未点亮
		local cpt = GetPlayerPoints(sid,2)
		if(cpt == nil or cpt<needlq)then return false,5 end --灵气不足升级
		local rand = math_random(1,100000)
		if(rand>conf.rate)then
			if(bit>=4 and bit<=6)then
				tdata[4] = nil
				tdata[5] = nil
				tdata[6] = nil
			end
			if(bit>=7 and bit<=9)then
				tdata[7] = nil
				tdata[8] = nil
				tdata[9] = nil
			end
			isfail = 1
		else
			tdata[bit] = math_random(conf.vmin,conf.vmax)
			isfail = 0
		end
		AddPlayerPoints(sid,2, -needlq,nil,'星盘精炼灵气扣除',true)
	elseif(t == 2)then --取消
		if(tdata[bit]==nil)then return false,6 end --还未点亮
		local cpt = GetPlayerPoints(sid,2)
		if(cpt == nil or cpt<needlq)then return false,5 end --灵气不足升级
		local rand = math_random(1,100000)
		if(rand>(100000 - conf.rate))then
			isfail = 1
		else
			tdata[bit] = nil
			isfail = 0
		end
		AddPlayerPoints(sid,2, -needlq,nil,'星盘精炼灵气扣除',true)
	end
	
	local num = _total_light_star(sid,index)
	local boss = _get_star_type_data(sid,index,4)
	if(num>=star_conf[10].num)then
		if(boss~=nil and boss[1] == nil)then
			local attType = star_conf[10].att[math_random(1,3)]
			boss[1] = attType
			boss[2] = math_random(conf.vmin,conf.vmax)
		end
	else
		if(boss~=nil and boss[1] ~= nil)then
			boss[1] = nil
			boss[2] = nil
		end
	end
	
	if(herodata~=nil and herodata.fight~=nil)then
		local hero = herodata[herodata.fight]
		if(hero)then
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
				updateTb.id = conf.rid
				local result = CI_OperateHero(2,herodata.fight-1,updateTb)
				if(hero.skill)then
					hero_set_power(sid,herodata.fight,1)
				end
			end
		end
	end
	
	return true,herodata,isfail
end

--本命星激活
function set_player_boss(sid,index)
	local herodata = GetHeroData(sid)
	if(herodata == nil)then return false,1 end --获取星盘数据出错
	local data = _get_star_data(sid,index)
	if(data == nil)then return false,1 end --获取星盘数据出错
	local tdata = _get_star_type_data(sid,index,4)
	if(tdata == nil)then return false,1 end --获取星盘数据出错
	local conf = star_conf[10]
	if(conf == nil)then return false,4 end --配置有错
	local needlq = conf.lq
	local cpt = GetPlayerPoints(sid,2)
	if(cpt == nil or cpt<needlq)then return false,5 end --灵气不足升级
	local num = _total_light_star(sid,index)
	if(num<conf.num)then return false,9 end --未点亮15个灯
	local attType = conf.att[math_random(1,3)]
	tdata[1] = attType
	tdata[2] = math_random(conf.vmin,conf.vmax)
	AddPlayerPoints(sid,2, -needlq,nil,'本命星精炼灵气扣除',true)
	
	local herodata = GetHeroData(sid)
	if(herodata~=nil and herodata.fight~=nil)then
		local hero = herodata[herodata.fight]
		if(hero)then
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
				updateTb.id = conf.rid
				local result = CI_OperateHero(2,herodata.fight-1,updateTb)
				if(hero.skill)then
					hero_set_power(sid,herodata.fight,1)
				end
			end
		end
	end
	
	return true,herodata
end