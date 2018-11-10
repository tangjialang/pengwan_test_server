--[[
file:	dragon_func.lua
desc:	����ϵͳ 
author:	zhongsx
update:	2015-3-16
]]--

--
local msgh_s2c_def  = msgh_s2c_def
local msg_data   	= msgh_s2c_def[20][22]
local msg_up 		= msgh_s2c_def[20][23]

--
local conf = require("Script.ShenBing.dragon_conf")
local dragon_conf = conf.conf
local dragon_func = conf.att_func 
local each_item = conf.each_item
local max_proc = conf.max_proc
--
local look = look
local rint = rint
local pairs, type = pairs, type
local GI_GetPlayerData	= GI_GetPlayerData
local CI_GetPlayerData = CI_GetPlayerData
local SendLuaMsg = SendLuaMsg
local ScriptAttType = ScriptAttType
local GetRWData  = GetRWData
local CheckGoods = CheckGoods
local AreaRPC = AreaRPC
local IsSpanServer = IsSpanServer
local CI_GetCurPos = CI_GetCurPos
local CI_SetPlayerIcon = CI_SetPlayerIcon
local CI_GetPlayerIcon = CI_GetPlayerIcon
local __G = _G
-----------------
module(...)
-----------------

local function get_dragon_data(playerid) 
    local dragon_data = GI_GetPlayerData(playerid, "dragon", 20)
	if dragon_data == nil then return end
	if dragon_data[1] == nil then 
		--[1] ��ǰ�ȼ� [2] ��ǰ����
		dragon_data[1] = 0
		dragon_data[2] = 0
	end
	return  dragon_data
end

local function update_attup(sid)
	local dragon = get_dragon_data(sid)
	if nil == dragon then return end
	local AttTb = GetRWData(1)
	for key, func in pairs(dragon_func) do
		AttTb[key] = (AttTb[key] or 0) + func(dragon[1])
	end
	__G.PI_UpdateScriptAtt(sid, ScriptAttType.dragon)
end

-----------------------------------
local function _get_data(sid)
	local dragon = get_dragon_data(sid)
	--
	SendLuaMsg(0,  {ids=msg_data, data=dragon}, 9)
end

local function _up_data(sid, itype, num)
	if IsSpanServer() then return end

	if itype == null or num == null or type(num) ~= type(0) or type(itype) ~= type(0) then 
		SendLuaMsg(0,  {ids=msg_up, itype = 2, err = 1}, 9)	
		return 
	end
	
	local dragon = get_dragon_data(sid)
	if dragon[1] >= 90 then return end

	--�������ӵĽ����������ĵ�������
	local add_proc, cost_items, need_proc, need_items
	if itype == 1 then  --��һ������
		need_items = each_item(dragon[1]) * 1
		if 0 == CheckGoods(dragon_conf[3], need_items, 1, sid, "����ϵͳ") then
			--���߲���
			SendLuaMsg(0,  {ids=msg_up, itype = 2, err = 2}, 9)	
		 	return 
		else
			add_proc = 1
			cost_items = need_items  
		end
	elseif itype == 2 then -- ��һ��
		--������һ����������
		need_proc = max_proc(dragon[1]) - dragon[2]
		need_items = need_proc * each_item(dragon[1])
		if num > need_items then 
			if 0 == CheckGoods(dragon_conf[3], need_items, 1, sid, "����ϵͳ") then
				--���߲���
				SendLuaMsg(0,  {ids=msg_up, itype = 2, err = 2}, 9)	
		 		return 
			else
				add_proc = need_proc
				cost_items = need_items
			end
		else
			--ӵ�еĵ���������ӵĽ���
			need_proc = rint(num / each_item(dragon[1]))
			need_items = need_proc * each_item(dragon[1])
			
			if need_proc == 0 then  --���߲���
				SendLuaMsg(0,  {ids=msg_up, itype = 2, err = 2}, 9)	
				return 
			end
			
			if 0 == CheckGoods(dragon_conf[3], need_items, 1, sid, "����ϵͳ") then
				--���߲���
				SendLuaMsg(0,  {ids=msg_up, itype = 2, err = 2}, 9)	
		 		return 
			else
				add_proc = need_proc
				cost_items = need_items
			end
		end
	else
		--itype��ֵ����
		SendLuaMsg(0,  {ids=msg_up, itype = 2, err = 1}, 9)	
		return 
	end
	--����ʵ�ʿ۳�������
	local ret = CheckGoods(dragon_conf[3], cost_items, 0, sid, "����ϵͳ")
	local lv, flag 
	if ret then 
		dragon[2] = dragon[2] + add_proc
		if dragon[2] >= max_proc(dragon[1]) then 
			dragon[2] = dragon[2] - max_proc(dragon[1])
			dragon[1] = dragon[1] + 1
			--��һ�� ---updateatt
			update_attup(sid)
			--�ж��Ƿ���һ��
			flag = rint(dragon[1] % 10) 
			if flag == 0 then 
				lv = rint(dragon[1] / 10) 
				CI_SetPlayerIcon(3, 5, lv , 1) --ʱװ 0-7 �·�,���,���, �����ȼ�, ????,����....
				--CI_SetPlayerIcon(0,6,0,1)---��������
				local _,_,_,mapGID = CI_GetCurPos()
				AreaRPC(2, sid, mapGID, 'dragon_rpc', CI_GetPlayerData(16), dragon[1])
			end
		end
		SendLuaMsg(0, {ids=msg_up, itype = 1, level=dragon[1], proc=dragon[2]}, 9)	
	end
end

local function _get_attup(sid)
	local dragon = get_dragon_data(sid)
	if nil == dragon then return end
	local AttTb = GetRWData(1)
	for key, func in pairs(dragon_func) do
		AttTb[key] = (AttTb[key] or 0) + func(dragon[1])
	end
	return true
end


--BUG�޸� �������BUG
local function _repair_bug(sid)
	local dragon = get_dragon_data(sid)
	if nil == dragon then return end
	
	local llv = CI_GetPlayerIcon(3, 5)
	local lv = rint(dragon[1] / 10) or 0
	if llv ~= lv then 
		CI_SetPlayerIcon(3, 5, lv , 1)
	end
end

---interface
dragon_get_data  = _get_data
dragon_up_data 	 = _up_data
dragon_get_attup = _get_attup
dragon_repair_bug = _repair_bug