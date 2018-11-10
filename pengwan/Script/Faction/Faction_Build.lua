--[[
file:	Faction_Build.lua
desc:	��Ὠ�������޹���
update:2013-7-1
refix:	done by xy
2014-08-21:add by sxj, update upFactionBuild(sid,index)
]]--
--------------------------------------------------------------------------
--include:
local type = type
local GetFactionData = GetFactionData
local upMainBuild = upMainBuild
local CI_GetPlayerData = CI_GetPlayerData
local GetServerTime = GetServerTime
local math_floor = math.floor
local SendFactionData = SendFactionData
local CheckCost = CheckCost
local CI_GetMemberInfo = CI_GetMemberInfo
local CI_GetFactionInfo = CI_GetFactionInfo
local CI_SetFactionInfo = CI_SetFactionInfo
local AddPlayerPoints = AddPlayerPoints
local CheckGoods = CheckGoods
local fBuild_conf = fBuild_conf
local define		= require('Script.cext.define')
local FACTION_FBZ = define.FACTION_FBZ
local SendLuaMsg = SendLuaMsg
local Faction_Soul = msgh_s2c_def[7][5]
--------------------------------------------------------------------------
-- data:


--���ձ�����
local fSign_conf = {
	limitLv = 3, --���ŵȼ�����
	maxLv = 9, --�ȼ�����,
	buff = {1000,nil,200,200},
	spend = {1000,2000,4000,10000,20000,40000,100000,200000,400000,800000}, --���Ѱ���ʽ�
	sign = {[1] = 100, [2] = 101,[3] = 102,[4] = 103,[5] = 104,[6] = 105,[7] = 106,[8] = 107,[9] = 108,[10] = 109}, --ico
}

--��ȡ����CDʱ��
local function GetFactionBuildCDData(fid)
	local fdata = GetFactionData(fid)
	if(fdata == nil)then return end

	if(fdata.CD == nil) then
		fdata.CD = {}
	end
	
	if(fdata.CD.build == nil)then
		fdata.CD.build = 0
	end
	
	return fdata.CD.build
end

--��ȡ�������
function GetFactionSoulCDData(fid)
	local fdata = GetFactionData(fid)
	if(fdata == nil)then return end
	
	if(fdata.soul == nil)then
		fdata.soul = {0}
	end
	
	return fdata.soul
end

--��CD
function ClearFactionBuildCD(sid)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --��᲻����
	end
	
	local cd = GetFactionBuildCDData(fid)
	if(cd == nil)then return false,1 end --cd���ݳ���
	
	local now = GetServerTime()
	if(cd<now)then return false,2 end --����Ҫ��
	
	local temp = cd - now
	local times = math_floor(temp/60)
	if(temp%60 == 0)then times = times + 1 end
	
	if(CheckCost(sid,times,0,1,'100018_��Ὠ����CD'))then
		dbMgr.faction.data[fid].CD.build = now
		SendFactionData(fid)
	else
		return false,3 --Ԫ������
	end
end

--������Ὠ��
function upFactionBuild(sid,index)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --��᲻����
	end
	local title = CI_GetMemberInfo(1)
	if(title<FACTION_FBZ)then
		return false,1 --�������������ſ�����
	end
	
	local data = fBuild_conf[index]
	if(data == nil)then
		return false,2 --����������
	end
	local maxlv = data.maxlv
	
	local curLv,mainLv
	if(index == 1)then --����
		curLv = CI_GetFactionInfo(nil,2)
		if(curLv == nil)then --��δ����
			return false,4
		end
		if(curLv>=maxlv)then
			return false,5 --�ȼ��Ѵ�����
		end
	else
		mainLv = CI_GetFactionInfo(nil,2)
		if index == 7 then
			curLv = CI_GetFactionInfo(nil,12)
		else
			curLv = CI_GetFactionInfo(nil,3+index)
		end
		local limit = fBuild_conf.limit[index]
		if(curLv == nil or mainLv == nil or limit == nil or limit>mainLv)then --��δ����
			return false,4
		end
		if(curLv>=maxlv)then
			return false,5 --�ȼ��Ѵ�����
		end
		if(curLv>=mainLv)then --���ܳ�������ȼ�
			return false,3
		end
	end
	
	local cdTime = GetFactionBuildCDData(fid)
	if(cdTime == nil)then
		return false,4
	end
	
	if(type(cdTime) == type({}))then cdTime = 0 end
	
	local now = GetServerTime()
	--local cdTime = cdData[index]
	if(cdTime~=nil)then --�ж�CDʱ��
		if(cdTime~=nil)then
			if(now<cdTime)then
				return false,7 --CDʱ��δ��
			end
		end
	end
	
	local fmoney = data.m[curLv] --��Ҫ����ʽ�
	local money = CI_GetFactionInfo(nil,3)
	if(fmoney>money)then
		return false,6 --����ʽ���
	end
	
	local nextLv = curLv + 1
	if(nextLv<maxlv)then
		local times = data.t[curLv]
		if(times == nil)then
			return false,8 --δ��ȡ����һ��CDʱ��
		end
		now = now + times
	else
		local isContinu = false
		local tempLv
		--[[	older
		for i = 5,9 do --���ܴ��
			if(fBuild_conf[i])then
				tempLv = CI_GetFactionInfo(nil,i)
				if(tempLv<fBuild_conf[i-3].maxlv)then
					isContinu = true
					break
				end
			end
		end
		]]--
		--[[sxj,2014-08-21 update start]]-- 
		for i = 5,12 do --���ܴ��
			if i ~=10 and i ~= 11 then
				if i == 12 then
					i = 10
				end
				if(fBuild_conf[i-3])then				--Ӧ����i-3
					if i ==10 then
						tempLv = CI_GetFactionInfo(nil,12)
					else
						tempLv = CI_GetFactionInfo(nil,i)
					end
					if(tempLv<fBuild_conf[i-3].maxlv)then
						if (data == fBuild_conf[i-3] and tempLv < 9) or tempLv < 10 then
							isContinu = true
							break
						end
					end
				end
			end
		end
		--[[sxj,2014-08-21 update end]]--
		if(isContinu)then
			local times = data.t[curLv]
			if(times == nil)then
				return false,8 --δ��ȡ����һ��CDʱ��
			end
			now = now + times
		end
	end
	
	local result
	
	if(index == 1)then --������������Ҫ�ж��Ƿ��м�����������
		result = CI_SetFactionInfo(nil,2,nextLv)
		if(result == 1)then 
			upMainBuild() 
		end
	else
		if index == 7 then
			result = CI_SetFactionInfo(nil,12,nextLv)
		else
			result = CI_SetFactionInfo(nil,index+3,nextLv)
		end
	end
	
	if(result ~= 1)then
		return false,0 --û���
	end
	
	if(now ~= nil)then
		dbMgr.faction.data[fid].CD.build = now
	end
	
	CI_SetFactionInfo(nil,3,money - fmoney)
	
	SendFactionData(fid) --���͸�������
	
	return true,index,nextLv
end

--[[
  	CAT_MAX_HP	= 0,		// Ѫ������0
	CAT_MAX_MP,				// ŭ������(Ԥ��)1
	CAT_ATC,				// ����2
	CAT_DEF,				// ����3
	CAT_HIT,				// ����4
	CAT_DUCK,				// ����5
	CAT_CRIT,				// ����6
	CAT_RESIST,				// �ֿ�7
	CAT_BLOCK,				// ��8
	CAT_AB_ATC,				// �����˺�9
	CAT_AB_DEF,				// ���Է���10
	CAT_CritDam,			// �����˺�11
	CAT_MoveSpeed,			// �ƶ��ٶ�(Ԥ��)12
]]--

--�������ձ�
function upFSign(sid)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --��᲻����
	end
	
	local title = CI_GetMemberInfo(1)
	if(title<FACTION_FBZ)then
		return false,1 --�������������ſ�����
	end
	
	local curlv = CI_GetFactionInfo(nil,4)	
	local lv = CI_GetFactionInfo(nil,2)
	
	if(lv<fSign_conf.limitLv)then return false,2 end --3�����������ձ�
	if(lv<=curlv)then return false,3 end --���ܳ������ȼ�

	if(curlv>=fSign_conf.maxLv)then
		return false,4 --�Ѵ�����
	end
	
	local nextlv = curlv + 1
	local spend = fSign_conf.spend[nextlv]
	if(spend == nil)then
		return false,5 --���ô���
	end
	
	local money = CI_GetFactionInfo(nil,3)
	if(spend>money)then
		return false,6 --����ʽ���
	else
		money = money - spend
	end
	
	CI_SetFactionInfo(nil,3,money)
	CI_SetFactionInfo(nil,4,nextlv)
	
	return true,money,nextlv
end

--ι������
function FeedSoul(sid)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --��᲻����
	end

	local data = GetFactionSoulCDData(fid)
	if data == nil then
		return false,3 --��ȡ��������ʧ��
	end
	
	--soul = {1084,100,1,10}, --����ι��(���ߡ��ɳ������ޡ��ɳ����������ﹱ����)
	local group = data[1]
	local maxGroup = fBuild_conf.soul[2]
	if(group>= maxGroup)then
		return false,1 --�ɳ�������
	end
	
	if(CheckGoods(fBuild_conf.soul[1],1,0,sid,'ι������')==0)then
		return false,2 --û���㹻����
	end
	
	group = group + fBuild_conf.soul[3]
	if(group>maxGroup)then group = maxGroup end
	data[1] = group
	AddPlayerPoints(sid,4,fBuild_conf.soul[4],nil,'ι����')	
	
	return true,data
end

function set_soul_group(sid,add)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return --��᲻����
	end

	local data = GetFactionSoulCDData(fid)
	if data == nil then
		return --��ȡ��������ʧ��
	end
	
	local group = data[1]
	local maxGroup = fBuild_conf.soul[2]
	if(group>= maxGroup)then
		return --�ɳ�������
	end
	
	group = group + add
	if(group>maxGroup)then group = maxGroup end
	data[1] = group
	
	SendLuaMsg( 0, { ids = Faction_Soul,data = data}, 9 )
end