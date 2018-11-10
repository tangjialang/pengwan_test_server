--[[
file: Userdefine_Proc.lua
desc: 自定义处理函数
]]--

local type,pairs = type,pairs
local new_guide = require('Script.new_guide.fun')
local set_guide = new_guide.set_guide

---------------------------------------------主线副本-------------------------------------

function ud_1001_1(copyScene,param)	
	--RPC('showNewTalk',2)
	--TipCenter("陷阱点1111触发")
end

function ud_1001_2(copyScene,param)
	--RPC('showNewTalk',3)
	--TipCenter("陷阱点2222触发")
end

function ud_1001_3(copyScene,param)
	--TipCenter("陷阱点3333触发")
end

function ud_1001_4(copyScene,param)
	PI_PayPlayer(1, 1200,0,0,'新手副本')
	GiveGoods(10,20,0,'新手副本')
	RPC('showNewTalk',5)
end

function ud_1001_5(copyScene,param)
	RPC('showNewTalk',6)
end

function ud_1002_1(copyScene,param)
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then return end
	set_guide(sid,0,0) --取消体验坐骑
end
---------------------------------------------觉醒副本-------------------------------------

function ud_1006_1(copyScene,param)
	local school = CI_GetPlayerData(2)
	if 	school==1 then
			CI_DelBuff(226)

	elseif 	school==2 then
			CI_DelBuff(227)
	
	elseif 	school==3 then
			CI_DelBuff(228)

	else
		return
	end
end
---------------------------------------------组队副本-------------------------------------
-- 组队副本宝箱特殊处理
function ud_2001_1(copyScene,param)
	look('ud_2001_1')
	if copyScene == nil or param == nil then return end
	if type(copyScene.PlayerSIDList) == type({}) then
		for pid in pairs(copyScene.PlayerSIDList) do
			if type(pid) == type(0) then
				DropItemProc(pid,param,param.x,param.y,true)
			end
		end
	end
end


---------------------------------------------铜钱副本-------------------------------------

-- 铜钱副本宝箱特殊处理
function ud_6001_1(copyScene,param)
	if param == nil then return end
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then return end
	local lv = CI_GetPlayerData(1)
	if lv == nil or lv <= 0 then return end
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp == nil or pCSTemp.CopySceneGID == nil then return end
	local copyScene = CS_GetTemp(pCSTemp.CopySceneGID)
	if copyScene==nil then return end
	local money = 0
	if param == 1 then
		money = math.floor(lv*200)
	elseif param == 2 then
		money = math.floor(lv*400)
	elseif param == 3 then
		money = math.floor(lv*600)
	elseif param == 4 then
		money = math.floor(lv*800)
	elseif param == 5 then
		money = math.floor(lv*1500)
	end
	RPC('met_givemoney',money)
	copyScene.getm = (copyScene.getm or 0) + money
	GiveGoods(0,money,0,'宝箱掉落')
end

---------------------------------------------历练副本-------------------------------------

function ud_13001_1(copyScene,param)
	if copyScene == nil or param == nil then return end
	local sid = CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then return end
	local lv = CI_GetPlayerData(1)
	if lv == nil or lv <= 0 then return end
	local pCSTemp = CS_GetPlayerTemp(sid)
	if pCSTemp == nil or pCSTemp.CopySceneGID == nil then return end	
	RPC('met_givell',param)
	copyScene.getl = (copyScene.getl or 0) + param
	AddPlayerPoints(sid,11,param,nil,'历练副本')
end

function ud_17000(copyScene,param)
	look('ud 17000',2)
	look(param)
	
end

------------------------------测试副本------------------------------------
function ud_999001_1(copyScene,param)
	TipCenter("触发刷怪")
	local _monster = {
				{ monsterId = 71,monAtt={[1] =99999999,},aiType = 23,searchArea = 10 ,moveSpeed = 400,BRMONSTER = 1, centerX = 70, centerY = 56,targetX = 83,targetY = 24,BRArea = 1 , BRNumber =5 ,camp = 4, },				
				{ monsterId = 19,BRMONSTER = 1, centerX = 83, centerY = 24,BRArea = 1 , BRNumber =5 ,camp = 5, },
			}
		local _mon
		if  copyScene == nil then return end
		local DynmicSceneMap = copyScene.DynamicSceneGIDList[1]
		_mon = _monster[1]
		_mon.copySceneGID = copyScene.CopySceneGID
		_mon.regionId = DynmicSceneMap.dynamicMapGID	
		CreateObjectIndirect(_mon)
		
		_mon = _monster[2]
		_mon.copySceneGID = copyScene.CopySceneGID
		_mon.regionId = DynmicSceneMap.dynamicMapGID	
		CreateObjectIndirect(_mon)
end

