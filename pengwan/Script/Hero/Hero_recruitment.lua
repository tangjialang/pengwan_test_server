--[[
file:	Hero_recruitment.lua
desc:	武将招募
author:	xiao.y
update:2013-7-1
refix:	done by xy
]]--
--武将卡

--------------------------------------------------------------------------
--include:
local Hero_conf = Hero_conf
local GetHeroData = GetHeroData
local CI_GetPlayerData = CI_GetPlayerData
local GetPlayerPoints = GetPlayerPoints
local AddPlayerPoints = AddPlayerPoints
local math_floor = math.floor
local InitHeroLv = InitHeroLv
local look = look
--------------------------------------------------------------------------
-- data:

local Hero_ItemConf = {
[200] = 10001,
[201] = 10002,
[210] = 10003,
[203] = 10004,
[209] = 10005,
}

local HeroInfoTb = HeroInfoTb

--激活武将
function HeroActiveProc(sid,goodid)	
	local unlockID = Hero_ItemConf[goodid]
	if(unlockID == nil)then return 0,3 end --不是武将卡

	local herodata = GetHeroData(sid)
	if(herodata == nil)then return 0,1 end --武将不存在

	if(herodata.ulk~=nil and herodata.ulk[unlockID]~=nil)then return 0,2 end --已解锁
	
	if(herodata.ulk == nil)then herodata.ulk = {} end
	herodata.ulk[unlockID] = 1
	
	return 1,herodata,unlockID
end

--招募武将
function HeroRecruitProc(sid,index,htype)
	look('HeroRecruitProc')
	local playerLv=CI_GetPlayerData(1)
	if(playerLv<Hero_conf.mipl)then return false,1 end --玩家等级不足

	local herodata = GetHeroData(sid)
	if(herodata == nil)then return false,2 end --武将不存在
	local rid = htype * 1000 + index --要添加的武将ID
	
	if(HeroInfoTb[htype] == nil or HeroInfoTb[htype][index] == nil)then return false,1 end --武将配置出错
	local hdata = HeroInfoTb[htype][index]
	local goodid
	if(htype == 10 and (herodata.ulk == nil or herodata.ulk[rid] == nil))then
		goodid = hdata.goodid
		if(goodid == nil)then return false,1 end --配置出错
		
		if(CheckGoods(goodid,1,1,sid,'招募武将')==0)then
			return false,3 --没有足够道具,家将未解锁
		end
	end
	
	local insertIndex = 0
	for i=1,Hero_conf.mxnm do
		if(herodata[i]~=nil)then
			if(herodata[i][1] == rid)then
				return false,4	--已经招募了此武将
			end
		else
			if(insertIndex == 0)then
				insertIndex = i
				break
			end
		end
	end
	
	if(insertIndex == 0)then return false,5 end --招募武将数已达上限
	
	local cpt = GetPlayerPoints(sid,2)
	if cpt == nil then
		return false,6 --点数不足招募
	end
	
	local needpt = hdata.point
	if(cpt<needpt)then return false,6 end --点数不足招募
	
	if(hdata.sw~=nil and hdata.sw>0)then
		local swpt = GetPlayerPoints(sid,7)
		if swpt == nil then
			return false,7 --声望不足招募
		end
		
		if(swpt<hdata.sw)then
			return false,7 --声望不足招募
		end
	end
	
	local needpt = hdata.point
	if(cpt<needpt)then return false,6 end --点数不足招募
	
	AddPlayerPoints(sid,2, - needpt,nil,'家将招募扣除灵气',true)
	herodata[insertIndex] = {rid,InitHeroLv(htype),0,0,0,0,0}
	if(herodata.init==nil)then herodata.init = 1 end --防止出问题
	if(goodid~=nil)then 
		CheckGoods(goodid,1,0,sid,'家将卡招慕家将')
		if(herodata.ulk == nil)then 
			herodata.ulk = {}
		end
		herodata.ulk[rid] = 1
	end
	
	return true,herodata,rid
end

--解雇武将(解雇里清除Gid)
function HeroFireProc(sid,index)
	look('HeroFireProc')
	local herodata = GetHeroData(sid)
	if(herodata == nil or herodata[index] == nil)then return false,1 end --武将不存在
	
	local hdata = herodata[index]
	local rid = hdata[1]
	local totalPt
	local level = hdata[2]
	if(hdata[8] ~= nil)then
		totalPt = hdata[8]
	end
	if(herodata.fight~=nil)then
		if(herodata.fight == index)then
			return false,2 --出战家将不能被解雇
		end
	end
	
	if(totalPt~=nil and totalPt > 0)then --返还战魂
		AddPlayerPoints(sid,2, math_floor(totalPt*0.5),nil,'解雇家将返还')
	end
	herodata[index] = nil
	
	return true,herodata,rid
end