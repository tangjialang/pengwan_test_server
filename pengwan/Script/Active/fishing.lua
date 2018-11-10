--[[
file:	Fish_Active.lua
desc:	钓鱼活动
author:	wk
update:	2013-6-4
]]--

local Fish_begins=msgh_s2c_def[12][29]
local look = look
local uv_TimesTypeTb = TimesTypeTb
local _random=math.random
local GetPlayerTemp_custom=GetPlayerTemp_custom
local isFullNum=isFullNum
local CheckGoods=CheckGoods
local CheckTimes=CheckTimes
local SendLuaMsg=SendLuaMsg
local GiveGoods=GiveGoods
local GetStringMsg=GetStringMsg
local TipCenter=TipCenter
-------------------------------------------------------------------------
 
-- module:

module(...)

----------------------------------------------------------------------------
local fishid=638 --鱼饵
local common_conf={1045,1046,1048,1050} --普通库
local precious_conf={1047,1049,1051,632,641} --贵重库
----------------------------------------------------------------------------
--玩家临时数据接口
local function fish_gettempdata(playerid)
	if playerid == nil then return nil end
	local cData = GetPlayerTemp_custom(playerid)
	if cData == nil  then return end
	if cData.fish == nil then
		cData.fish = {
		}
	end
	return cData.fish
end
--点击钓鱼
local function _fish_begin(playerid)

	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return
	end

	if CheckGoods( fishid ,1, 1, playerid,'钓鱼') == 0 then
		return false
	end
	local fdata=fish_gettempdata(playerid)
	if fdata==nil then return end
	local rannum=_random(1,10000)
	local res=0
	local id
	if rannum>9999 then
		res=1
		id = 1123    --特殊称号
	elseif rannum>8000 then
		res=1
		id=precious_conf[_random(1,#precious_conf)]
	else
		id=common_conf[_random(1,#common_conf)]
	end
	fdata.id=id
	SendLuaMsg(0,{ids=Fish_begins,res=res,id=id},9)

	
end
--钓鱼结果
local function _fish_result(playerid,succ)

	local fdata=fish_gettempdata(playerid)
	if fdata==nil or fdata.id ==nil then return end
	if CheckGoods( fishid ,1, 0, playerid,'钓鱼') == 0 then
		return false
	end
	if succ==1 then 
		GiveGoods(fdata.id,1,0,'钓鱼')--给东西 
	end
	fdata.id=nil
	CheckTimes(playerid,uv_TimesTypeTb.Fish_Time,1)
end
----------------------------------------------------------------------------
Fish_begin=_fish_begin
Fish_result=_fish_result