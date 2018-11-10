--[[
file:Mounts_bone.lua
desc:坐骑炼骨
author:xiao.y
update:2013-7-1
refix:	done by xy
]]--

--------------------------------------------------------------------------
--include:
local GetMountsData = GetMountsData
local AddMountsAtt = AddMountsAtt
--local CI_GetPlayerData = CI_GetPlayerData
local CheckGoods = CheckGoods
local math_floor = math.floor
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos
local look = look
--------------------------------------------------------------------------
-- data:

--坐骑炼骨
local MouseBoneConf = {
	goodId = 627, --炼骨丹ID
	needCount = 20, --每级需要的炼骨丹个数
	openLevel = 43, --开放等级
	maxLevel = 200, --炼骨最大等级
}

local MouseChgeConf = MouseChgeConf

--炼骨
function MouseBoneProc(sid,goodsNum)
	look('MouseBoneProc,'..sid..','..goodsNum)

	local mountsData = GetMountsData(sid)
	if(nil == mountsData)then
		return false,1  --没有坐骑数据
	end
	
	--local playerLv=CI_GetPlayerData(1)
	--if(playerLv<MouseBoneConf.openLevel)then --角色等级不足
	--	return false,2
	--end
	local boneTb
	if(mountsData.bone == nil)then
		mountsData.bone = {0,0}
		boneTb = mountsData.bone
	else
		boneTb = mountsData.bone
	end
	
	if(boneTb == nil)then
		--look(mountsData.bone)
		return false,1 --没有炼骨数据
	end
	
	if(CheckGoods(MouseBoneConf.goodId,goodsNum,1,sid,'检查炼骨丹')==0)then
		return false,3 --没有足够道具
	end
	
	local level = boneTb[1]
	local proc = boneTb[2]
	
	if(level>=MouseBoneConf.maxLevel)then
		return false,4 --已达炼骨上限
	end
 
	--if(level>=playerLv)then
	--	return false,5 --不能超过人的等级
	--end
	
	local oldlevel = level
	local nextlevel = level + 1
	local needNum = (level+1)*20 --nextlevel * MouseBoneConf.needCount
	local nextProc = proc + goodsNum
	local isElse = 0
	while(nextProc>=needNum and needNum>0)do --升级了
		nextProc = nextProc - needNum
		level = level + 1
		if(level == 10)then --目标达成：将坐骑的炼骨提升到10级
			set_obj_pos(sid,3003)
		end
		if(level>=MouseBoneConf.maxLevel)then
			isElse = 1
			break
		end
		--if(level>=playerLv)then
		--	isElse = 2
		--	break
		--end
		nextlevel = level + 1
		needNum = (level+1)*20
	end
	local isUp = 0
	if(isElse == 1)then
		goodsNum = goodsNum - nextProc
		nextProc = needNum
	--elseif(isElse == 2)then
	--	goodsNum = goodsNum - nextProc
	--	nextProc = 0
	end
	
	CheckGoods(MouseBoneConf.goodId,goodsNum,0,sid,'扣除炼骨丹')
	boneTb[1] = level
	boneTb[2] = nextProc	
	
	if(level ~= oldlevel)then
		isUp = level
	end
	
	if(isUp>0)then --属性有提升
		AddMountsAtt(sid)
	end
	
	return true,mountsData,goodsNum,isUp
end

function temp_mounts_bone(sid)
	local mountsData = GetMountsData(sid)
	if(mountsData and mountsData.bone)then
		local level = mountsData.bone[1]
		if(level >= 10)then --目标达成：将坐骑的炼骨提升到10级
			set_obj_pos(sid,3003)
		end
	end
end