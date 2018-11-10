--[[
file:	Faction_Build.lua
desc:	帮会建筑及神兽功能
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


--帮会徽标配置
local fSign_conf = {
	limitLv = 3, --开放等级（大殿）
	maxLv = 9, --等级上限,
	buff = {1000,nil,200,200},
	spend = {1000,2000,4000,10000,20000,40000,100000,200000,400000,800000}, --花费帮会资金
	sign = {[1] = 100, [2] = 101,[3] = 102,[4] = 103,[5] = 104,[6] = 105,[7] = 106,[8] = 107,[9] = 108,[10] = 109}, --ico
}

--获取建筑CD时间
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

--获取帮会神兽
function GetFactionSoulCDData(fid)
	local fdata = GetFactionData(fid)
	if(fdata == nil)then return end
	
	if(fdata.soul == nil)then
		fdata.soul = {0}
	end
	
	return fdata.soul
end

--秒CD
function ClearFactionBuildCD(sid)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --帮会不存在
	end
	
	local cd = GetFactionBuildCDData(fid)
	if(cd == nil)then return false,1 end --cd数据出错
	
	local now = GetServerTime()
	if(cd<now)then return false,2 end --不需要秒
	
	local temp = cd - now
	local times = math_floor(temp/60)
	if(temp%60 == 0)then times = times + 1 end
	
	if(CheckCost(sid,times,0,1,'100018_帮会建筑秒CD'))then
		dbMgr.faction.data[fid].CD.build = now
		SendFactionData(fid)
	else
		return false,3 --元宝不足
	end
end

--升级帮会建筑
function upFactionBuild(sid,index)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --帮会不存在
	end
	local title = CI_GetMemberInfo(1)
	if(title<FACTION_FBZ)then
		return false,1 --帮主、副帮主才可以升
	end
	
	local data = fBuild_conf[index]
	if(data == nil)then
		return false,2 --建筑不存在
	end
	local maxlv = data.maxlv
	
	local curLv,mainLv
	if(index == 1)then --主殿
		curLv = CI_GetFactionInfo(nil,2)
		if(curLv == nil)then --还未激活
			return false,4
		end
		if(curLv>=maxlv)then
			return false,5 --等级已达上限
		end
	else
		mainLv = CI_GetFactionInfo(nil,2)
		if index == 7 then
			curLv = CI_GetFactionInfo(nil,12)
		else
			curLv = CI_GetFactionInfo(nil,3+index)
		end
		local limit = fBuild_conf.limit[index]
		if(curLv == nil or mainLv == nil or limit == nil or limit>mainLv)then --还未激活
			return false,4
		end
		if(curLv>=maxlv)then
			return false,5 --等级已达上限
		end
		if(curLv>=mainLv)then --不能超过主殿等级
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
	if(cdTime~=nil)then --判断CD时间
		if(cdTime~=nil)then
			if(now<cdTime)then
				return false,7 --CD时间未到
			end
		end
	end
	
	local fmoney = data.m[curLv] --需要帮会资金
	local money = CI_GetFactionInfo(nil,3)
	if(fmoney>money)then
		return false,6 --帮会资金不足
	end
	
	local nextLv = curLv + 1
	if(nextLv<maxlv)then
		local times = data.t[curLv]
		if(times == nil)then
			return false,8 --未读取到下一级CD时间
		end
		now = now + times
	else
		local isContinu = false
		local tempLv
		--[[	older
		for i = 5,9 do --不管大殿
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
		for i = 5,12 do --不管大殿
			if i ~=10 and i ~= 11 then
				if i == 12 then
					i = 10
				end
				if(fBuild_conf[i-3])then				--应该是i-3
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
				return false,8 --未读取到下一级CD时间
			end
			now = now + times
		end
	end
	
	local result
	
	if(index == 1)then --主殿升级，需要判断是否有激活其它建筑
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
		return false,0 --没帮会
	end
	
	if(now ~= nil)then
		dbMgr.faction.data[fid].CD.build = now
	end
	
	CI_SetFactionInfo(nil,3,money - fmoney)
	
	SendFactionData(fid) --发送更新数据
	
	return true,index,nextLv
end

--[[
  	CAT_MAX_HP	= 0,		// 血量上限0
	CAT_MAX_MP,				// 怒气上限(预留)1
	CAT_ATC,				// 攻击2
	CAT_DEF,				// 防御3
	CAT_HIT,				// 命中4
	CAT_DUCK,				// 闪避5
	CAT_CRIT,				// 暴击6
	CAT_RESIST,				// 抵抗7
	CAT_BLOCK,				// 格挡8
	CAT_AB_ATC,				// 绝对伤害9
	CAT_AB_DEF,				// 绝对防御10
	CAT_CritDam,			// 暴击伤害11
	CAT_MoveSpeed,			// 移动速度(预留)12
]]--

--升级帮会徽标
function upFSign(sid)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --帮会不存在
	end
	
	local title = CI_GetMemberInfo(1)
	if(title<FACTION_FBZ)then
		return false,1 --帮主、副帮主才可以升
	end
	
	local curlv = CI_GetFactionInfo(nil,4)	
	local lv = CI_GetFactionInfo(nil,2)
	
	if(lv<fSign_conf.limitLv)then return false,2 end --3级才能升级徽标
	if(lv<=curlv)then return false,3 end --不能超过帮会等级

	if(curlv>=fSign_conf.maxLv)then
		return false,4 --已达上限
	end
	
	local nextlv = curlv + 1
	local spend = fSign_conf.spend[nextlv]
	if(spend == nil)then
		return false,5 --配置错误
	end
	
	local money = CI_GetFactionInfo(nil,3)
	if(spend>money)then
		return false,6 --帮会资金不足
	else
		money = money - spend
	end
	
	CI_SetFactionInfo(nil,3,money)
	CI_SetFactionInfo(nil,4,nextlv)
	
	return true,money,nextlv
end

--喂养神兽
function FeedSoul(sid)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --帮会不存在
	end

	local data = GetFactionSoulCDData(fid)
	if data == nil then
		return false,3 --获取神兽数据失败
	end
	
	--soul = {1084,100,1,10}, --神兽喂养(道具、成长度上限、成长度增量、帮贡增量)
	local group = data[1]
	local maxGroup = fBuild_conf.soul[2]
	if(group>= maxGroup)then
		return false,1 --成长度已满
	end
	
	if(CheckGoods(fBuild_conf.soul[1],1,0,sid,'喂养神兽')==0)then
		return false,2 --没有足够道具
	end
	
	group = group + fBuild_conf.soul[3]
	if(group>maxGroup)then group = maxGroup end
	data[1] = group
	AddPlayerPoints(sid,4,fBuild_conf.soul[4],nil,'喂神兽')	
	
	return true,data
end

function set_soul_group(sid,add)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return --帮会不存在
	end

	local data = GetFactionSoulCDData(fid)
	if data == nil then
		return --获取神兽数据失败
	end
	
	local group = data[1]
	local maxGroup = fBuild_conf.soul[2]
	if(group>= maxGroup)then
		return --成长度已满
	end
	
	group = group + add
	if(group>maxGroup)then group = maxGroup end
	data[1] = group
	
	SendLuaMsg( 0, { ids = Faction_Soul,data = data}, 9 )
end