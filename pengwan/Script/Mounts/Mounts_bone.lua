--[[
file:Mounts_bone.lua
desc:��������
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

--��������
local MouseBoneConf = {
	goodId = 627, --���ǵ�ID
	needCount = 20, --ÿ����Ҫ�����ǵ�����
	openLevel = 43, --���ŵȼ�
	maxLevel = 200, --�������ȼ�
}

local MouseChgeConf = MouseChgeConf

--����
function MouseBoneProc(sid,goodsNum)
	look('MouseBoneProc,'..sid..','..goodsNum)

	local mountsData = GetMountsData(sid)
	if(nil == mountsData)then
		return false,1  --û����������
	end
	
	--local playerLv=CI_GetPlayerData(1)
	--if(playerLv<MouseBoneConf.openLevel)then --��ɫ�ȼ�����
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
		return false,1 --û����������
	end
	
	if(CheckGoods(MouseBoneConf.goodId,goodsNum,1,sid,'������ǵ�')==0)then
		return false,3 --û���㹻����
	end
	
	local level = boneTb[1]
	local proc = boneTb[2]
	
	if(level>=MouseBoneConf.maxLevel)then
		return false,4 --�Ѵ���������
	end
 
	--if(level>=playerLv)then
	--	return false,5 --���ܳ����˵ĵȼ�
	--end
	
	local oldlevel = level
	local nextlevel = level + 1
	local needNum = (level+1)*20 --nextlevel * MouseBoneConf.needCount
	local nextProc = proc + goodsNum
	local isElse = 0
	while(nextProc>=needNum and needNum>0)do --������
		nextProc = nextProc - needNum
		level = level + 1
		if(level == 10)then --Ŀ���ɣ������������������10��
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
	
	CheckGoods(MouseBoneConf.goodId,goodsNum,0,sid,'�۳����ǵ�')
	boneTb[1] = level
	boneTb[2] = nextProc	
	
	if(level ~= oldlevel)then
		isUp = level
	end
	
	if(isUp>0)then --����������
		AddMountsAtt(sid)
	end
	
	return true,mountsData,goodsNum,isUp
end

function temp_mounts_bone(sid)
	local mountsData = GetMountsData(sid)
	if(mountsData and mountsData.bone)then
		local level = mountsData.bone[1]
		if(level >= 10)then --Ŀ���ɣ������������������10��
			set_obj_pos(sid,3003)
		end
	end
end