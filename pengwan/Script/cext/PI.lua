--[[
file:	PI_interface.lua
desc:	package for 'ci_xxx' function
author:	chal
update:	2013-07-02
refix: done by chal
todo: coding to module 
]]--
--------------------------------------------------------------------------
--include:
local type = type
local CreateObjectIndirect = CreateObjectIndirect
local look = look
local tablepush = table.push
local RemoveObjectIndirect = RemoveObjectIndirect
local GiveGoodsBatch = GiveGoodsBatch
local SendSystemMail = SendSystemMail
--------------------------------------------------------------------------
--interface:
local GIDList = {}
local ControlIDList = {}

--[[
	新创建npc一律调用新接口，不再使用 CreateObjectIndirect ，不能配置controlId
	400000以前非动态，可以随便用，只要保证不重复（划分为剧情类普通npc，功能性npc和采集类 npc等）
	动态npc段 老游戏是400000-500000
	500000-600000不能用
	600000-701000已用字段，保留不管
	701000之后 --- 1000000  千实例npc
	1000000之后		万实例npc
Notice:
	NPCID < 400000 为常态NPC 由服务器启动创建
	40000 < NPCID < 700000	动态NPC（不需要循环创建的） 由各功能或活动创建 
	NPCID >= 700000			动态NPC（需要循环创建的） 由各功能或活动创建
]]--

-- iType [0] 怪物 [1] NPC
-- nID 配置的怪物ID或NPC ID
-- CreateInfo i98
-- num 循环创建参数 不需要循环创建的不传此参数 传1 也可以
function CreateObjectIndirectEx(iType,nID,CreateInfo,num,posList)
	--clear first
	for i = 1,#GIDList do
		GIDList[i] = nil
	end
	for i = 1,#ControlIDList do
		ControlIDList[i] = nil
	end
	if iType == 0 then
		
	elseif iType == 1 then
		if num == nil or num == 1 then
			CreateInfo.controlId = nID + 100000			-- 统一加100000
			if posList ~= nil and posList[1] ~= nil then
				local pos = posList[1]
				if pos[3] ~= nil then
					CreateInfo.regionId = pos[3]
				end					
				CreateInfo.x = pos[1]
				CreateInfo.y = pos[2]
			end
			local GID = CreateObjectIndirect(CreateInfo)
			look('CreateObjectIndirectEx:' .. tostring(GID))
			return GID,CreateInfo.controlId
		else			
			if nID < 701000 or nID >= 1000000 then				-- 循环创建类NPC npcid只能在这个区间
				look("CreateObjectIndirectEx nID erro")
			end
			for i = 0, num - 1 do
				CreateInfo.controlId = nID + 100000 + i			-- 统一加100000
				if posList ~= nil and posList[i + 1] ~= nil then
					local pos = posList[i + 1]
					if pos[3] ~= nil then
						CreateInfo.regionId = pos[3]
					end					
					CreateInfo.x = pos[1]
					CreateInfo.y = pos[2]
				end 
				local GID = CreateObjectIndirect(CreateInfo)
				if not GID then
					look('CreateObjectIndirect_err__'..tostring(CreateInfo.controlId))
				end
				tablepush(GIDList,GID)
				tablepush(ControlIDList,CreateInfo.controlId)	
			end
			return GIDList,ControlIDList
		end
	else
		look("CreateObjectIndirectEx param erro")
	end
end

-- iType [0] 怪物 [1] NPC
-- rID 场景ID
-- nID 配置的怪物ID或NPC ID 注意：这里不能传controlID
-- num 循环删除参数 不需要循环创建的不传此参数
function RemoveObjectIndirectEx(iType,rID,nID,num)
	if iType == 0 then
		
	elseif iType == 1 then
		if num == nil then
			local controlId = nID + 100000			-- 统一加100000
			RemoveObjectIndirect(rID,controlId)			
		else
			for i = 0, num - 1 do
				local controlId = nID + 100000 + i			-- 统一加100000
				RemoveObjectIndirect(rID,controlId)				
			end
		end
	else
		look("RemoveObjectIndirectEx param erro")
	end
end

-- 背包不足发邮件的统一接口
-- 现在给物品的接口必须强制加日志
function PI_GiveGoodsEx(sid,config,num,MailType,Contents,ItemList,StayMin,LogInfo)
	look('PI_GiveGoodsEx1')
	look(LogInfo)
	if sid == nil or ItemList == nil or LogInfo == nil then return end
	look(ItemList)
	if type(ItemList) == type({}) then
		local succ, retCode, num = GiveGoodsBatch( ItemList,LogInfo,2,sid)	
		if not succ and retCode == 3 then	--背包不足发邮件
			local pName = PI_GetPlayerName(sid)
			if type(pName) == type('') then
				local AwardList = {[3] = ItemList}
				SendSystemMail(pName,config,num,MailType,Contents,AwardList,StayMin)	
			end
		end
	end
end

--封装CI_MovePlayer,主要针对护送
function PI_MovePlayer(regionid, x, y, mapgid, itype,playerSID)
	
	if regionid==0 then
		if escort_not_trans(playerSID) then --护送状态不能传动态图
			look('escort_not_trans')
			return
		end
	end
	local res=limit_lv_zl( regionid)--战力等级限制
	if not res then return end
	
	local res  =CI_MovePlayer(regionid, x, y, mapgid, itype,playerSID) 
	if not res then
		return res
	end
	return res
end
--CI_PayPlayer,用于世界等级加成
function PI_PayPlayer(itype,value,arg1,arg2,info,object,id)
	if itype==1 and value >0 then
		local plv=CI_GetPlayerData(1,object,id)
		if plv >39 then
			local wlv=GetWorldLevel() or 0
			if wlv-plv>=10 then
				value=value*2
			elseif wlv-plv>=5 then
				value=rint(value*1.5)
			end
		end
	end
	return CI_PayPlayer(itype,value,arg1,arg2,info,object,id)
end
--重置每日掉落上限
function PI_SetEnvironment(arg)
	CI_SetEnvironment(arg[1],arg[2])
end
--设置巡防经验倍率
function  PI_Set_xunhang( arg )
	if arg >0  then
	 	CI_SetEnvironment(1,arg,3)
	elseif arg ==0 then
		CI_SetEnvironment(1,1,-1) --取消倍数设置
	end
end