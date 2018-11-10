--[[
file:	Hero_recruitment.lua
desc:	�佫��ļ
author:	xiao.y
update:2013-7-1
refix:	done by xy
]]--
--�佫��

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

--�����佫
function HeroActiveProc(sid,goodid)	
	local unlockID = Hero_ItemConf[goodid]
	if(unlockID == nil)then return 0,3 end --�����佫��

	local herodata = GetHeroData(sid)
	if(herodata == nil)then return 0,1 end --�佫������

	if(herodata.ulk~=nil and herodata.ulk[unlockID]~=nil)then return 0,2 end --�ѽ���
	
	if(herodata.ulk == nil)then herodata.ulk = {} end
	herodata.ulk[unlockID] = 1
	
	return 1,herodata,unlockID
end

--��ļ�佫
function HeroRecruitProc(sid,index,htype)
	look('HeroRecruitProc')
	local playerLv=CI_GetPlayerData(1)
	if(playerLv<Hero_conf.mipl)then return false,1 end --��ҵȼ�����

	local herodata = GetHeroData(sid)
	if(herodata == nil)then return false,2 end --�佫������
	local rid = htype * 1000 + index --Ҫ��ӵ��佫ID
	
	if(HeroInfoTb[htype] == nil or HeroInfoTb[htype][index] == nil)then return false,1 end --�佫���ó���
	local hdata = HeroInfoTb[htype][index]
	local goodid
	if(htype == 10 and (herodata.ulk == nil or herodata.ulk[rid] == nil))then
		goodid = hdata.goodid
		if(goodid == nil)then return false,1 end --���ó���
		
		if(CheckGoods(goodid,1,1,sid,'��ļ�佫')==0)then
			return false,3 --û���㹻����,�ҽ�δ����
		end
	end
	
	local insertIndex = 0
	for i=1,Hero_conf.mxnm do
		if(herodata[i]~=nil)then
			if(herodata[i][1] == rid)then
				return false,4	--�Ѿ���ļ�˴��佫
			end
		else
			if(insertIndex == 0)then
				insertIndex = i
				break
			end
		end
	end
	
	if(insertIndex == 0)then return false,5 end --��ļ�佫���Ѵ�����
	
	local cpt = GetPlayerPoints(sid,2)
	if cpt == nil then
		return false,6 --����������ļ
	end
	
	local needpt = hdata.point
	if(cpt<needpt)then return false,6 end --����������ļ
	
	if(hdata.sw~=nil and hdata.sw>0)then
		local swpt = GetPlayerPoints(sid,7)
		if swpt == nil then
			return false,7 --����������ļ
		end
		
		if(swpt<hdata.sw)then
			return false,7 --����������ļ
		end
	end
	
	local needpt = hdata.point
	if(cpt<needpt)then return false,6 end --����������ļ
	
	AddPlayerPoints(sid,2, - needpt,nil,'�ҽ���ļ�۳�����',true)
	herodata[insertIndex] = {rid,InitHeroLv(htype),0,0,0,0,0}
	if(herodata.init==nil)then herodata.init = 1 end --��ֹ������
	if(goodid~=nil)then 
		CheckGoods(goodid,1,0,sid,'�ҽ�����Ľ�ҽ�')
		if(herodata.ulk == nil)then 
			herodata.ulk = {}
		end
		herodata.ulk[rid] = 1
	end
	
	return true,herodata,rid
end

--����佫(��������Gid)
function HeroFireProc(sid,index)
	look('HeroFireProc')
	local herodata = GetHeroData(sid)
	if(herodata == nil or herodata[index] == nil)then return false,1 end --�佫������
	
	local hdata = herodata[index]
	local rid = hdata[1]
	local totalPt
	local level = hdata[2]
	if(hdata[8] ~= nil)then
		totalPt = hdata[8]
	end
	if(herodata.fight~=nil)then
		if(herodata.fight == index)then
			return false,2 --��ս�ҽ����ܱ����
		end
	end
	
	if(totalPt~=nil and totalPt > 0)then --����ս��
		AddPlayerPoints(sid,2, math_floor(totalPt*0.5),nil,'��ͼҽ�����')
	end
	herodata[index] = nil
	
	return true,herodata,rid
end