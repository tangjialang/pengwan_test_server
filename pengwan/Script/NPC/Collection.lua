--[[
file:	Collection.lua
desc:	Collection Function
author:	chal
update:	2011-11-30
]]--
--:
local uv_CommonAwardTable = CommonAwardTable
local define		= require('Script.cext.define')
local ProBarType = define.ProBarType
local look,rint,tonumber = look,rint,tonumber
local npclist = npclist
local mathrandom = math.random
local CreateObjectIndirect,CI_SetReadyEvent = CreateObjectIndirect,CI_SetReadyEvent
local CI_GetPlayerData,RemoveObjectIndirect = CI_GetPlayerData,RemoveObjectIndirect

local function IsCollectNpc(npcid)
	local npc = npclist[npcid]
	return nil~=npc and nil~=npc.product
end
--:
function CollectItem( npcid , playerid ) 
	if IsCollectNpc(npcid) == nil then
		return
	end
	local npc = npclist[npcid]
	local cancol = false
	if npc.PreTaskID then		
		if type(npc.PreTaskID) == type(0) then
			if CurPlayerHasTask(npc.PreTaskID) then
				cancol = true
			end
		elseif type(npc.PreTaskID) == type({}) then
			for k, v in ipairs(npc.PreTaskID) do
				if CurPlayerHasTask(v) then
					cancol = true
					break
				end
			end
		end		
	end
	if CurPlayerHasTask(5001) or CurPlayerHasTask(7001) then
		cancol = true
	end
	if cancol == true then
		if type('')==type(npc.PreCollectEvent) and _G[npc.PreCollectEvent] then
			_G[npc.PreCollectEvent]()
		end
		--look('采集1  npcid =  '..npcid)
		local controlID = npcid + 100000
		local ret = CI_SetReadyEvent( controlID,ProBarType.collect,3,0,"CollectComplete" )
	end
end
--:callback
function CollectComplete(controlID)
	--look('采集2  controlID = '..controlID)
	if controlID == nil then 
		return 0
	end
	local _,_,rid,mapGID = CI_GetCurPos(6,controlID)
	if mapGID == nil or mapGID == 0 then 
		mapGID = rid
	end		
	local ret = CI_SelectObject(6,controlID,mapGID)
	if ret == nil or ret <= 0 then
		TipCenter(GetStringMsg(436))
		return 0
	end
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then 
		return 0
	end
	local npcid = controlID - 100000
	local npc = npclist[npcid]
	local AwardTb = uv_CommonAwardTable.AwardProc(sid,npc.product)
	local getok = award_check_items(AwardTb) 		
	if not getok then
		return 0
	end		
	GI_GiveAward( sid, AwardTb, "npc收集" )

	if npc.Refresh then 
		SetEvent(npc.Refresh, nil, "npc_refresh",npcid,mapGID) 
		if npc.NoDel then 
			RemoveObjectIndirect( mapGID, npcid + 100000)
		end
	end

	if npc.NoDel == nil then
		local w=RemoveObjectIndirect( mapGID, npcid + 100000)
	end
	return 1
end

--重刷npc
function npc_refresh( npcid ,rgid)
	local npc = npclist[npcid]
	npc.NpcCreate.regionId=rgid
	npc.NpcCreate.clickScript = 30000
	CreateObjectIndirectEx(1,npcid,npc.NpcCreate)
end