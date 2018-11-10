--[[
file:	wuzhuang_fun.lua
desc:	Ԫ����װ
author:	ct
update:	2014-6-16
]]--

local msgh_s2c_def	= msgh_s2c_def
local msg_wuzhuang_up =msgh_s2c_def[50][1]
local msg_check =msgh_s2c_def[50][2]
local conf=require("Script.wuzhuang.wuzhuang_conf")
local wuzhuang_conf=conf.wuzhuang_conf
local wuzhuang_zb_conf = conf.wuzhuang_zb_conf
local GetRWData = GetRWData
local rint = rint
local look = look
local GI_GetPlayerData = GI_GetPlayerData
local CI_GetPlayerData = CI_GetPlayerData
local CheckGoods = CheckGoods
local CheckCost = CheckCost
local SendLuaMsg = SendLuaMsg
local TipCenter = TipCenter
local pairs=pairs
local type=type
--local ScriptAttType = ScriptAttType
--local PI_UpdateScriptAtt = PI_UpdateScriptAtt
local __G = _G 
module(...)
--����ռ�
local function wz_getwuzhuangdata(playerid)
	local data = GI_GetPlayerData(playerid,'wz',70)
		--[[	 data={	[1]={0,0}, ���  ={�ȼ�������}	[2]={0,0}, �粿	[3]={0,0}, �β�	[4]={0,0}, ����	[5]={0,0}, ͷ��	[6]={0,0}, ����	[7]={0,0}  �Ȳ�	} ]]
	return data
end
--�������
local function _wz_attup(playerid,itype)
	local data=wz_getwuzhuangdata(playerid)
	if nil == data then
		return 
	end
	
	local att_type = wuzhuang_conf[1]
	local att_value= wuzhuang_conf[2]
	if nil == att_type then
		return
	end
	if nil == att_value then
		return
	end
	local AttTable =GetRWData(1)
	local lv = 0 --�ǵĵȼ�
	for i=1,7 do
		lv = type(data[i]) == type({}) and data[i][1] or 0
		att_type= wuzhuang_conf[1][i]
		for k,v in pairs(att_type) do
			att_value= wuzhuang_conf[2][v]
			AttTable[v]=(AttTable[v] or 0)+rint(lv*10+lv^2*att_value[1])*att_value[2]
		end
	end
	if itype == 1 then
		__G.PI_UpdateScriptAtt(playerid,__G.ScriptAttType.wuzhuang)
	end
	return true
end
--playerid �û�ID����
--����      
--[[     outfit��ʾ��һ������ 1:��� 2:�粿	3:�β� 4:���� 5:ͷ�� 6:���� 7:�Ȳ� num��ʾ���ϸ���  
		 money  0 ��ʾ���߲�����Ǯ��  1��ʾ ����Ǯ��]]
local function _wuzhuang_up(playerid,outfit,num,money)	
	if nil == playerid or playerid <= 0 then
		return
	end
	if outfit<=0 or outfit >7 then
		return
	end
	if money >1 or money <0 then
		return
	end
	if num < 0 then
		return
	end
	
	local expend              --��������
	local progress            --������Ҫ�Ľ���
	local data = wz_getwuzhuangdata(playerid)
	if nil == data then
		return 
	end
	local money_num           --���������Ҫ��Ǯ
    data[outfit] = data[outfit] or {0,0}
	--��������  INT((�ȼ�+1)/5*2)+1
	expend = rint((data[outfit][1]+1)/5*2) +1
	--����������Ҫ�Ľ��� INT(�ȼ�/15)*5+10
	progress = rint((data[outfit][1]+1)/15)*5+10
	if expend <= 0 then
		return
	end
--����
	--ֻ�õ�������
	if 1 == money then
		if CheckGoods(821,expend,0,playerid,"Ԫ����װ��λǿ��") ~= 1  then
			SendLuaMsg(0,{ids=msg_wuzhuang_up,lv = data[outfit][1],outfit=outfit,step= data[outfit][2]},9)
			return
		end
	--���߲����ʱ����Ǯ����
	elseif 0 == money then
		--������ ֻ�õ�������
		if num >= expend then
			if CheckGoods(821,expend,0,playerid,"Ԫ����װ��λǿ��") ~= 1  then
				SendLuaMsg(0,{ids=msg_wuzhuang_up,lv = data[outfit][1],outfit=outfit,step= data[outfit][2]},9)
				return
			end
		--���߲��� �۵��� ��Ǯ
		elseif num < expend then
			money_num=(expend-num)*5
			if money_num < 0 then
				return
			end
			if CheckCost (playerid,money_num,1,1,"Ԫ����װ��λǿ��") == false or CheckGoods(821,num,1,playerid,"Ԫ����װ��λǿ��") ~= 1 then
				SendLuaMsg(0,{ids=msg_wuzhuang_up,lv = data[outfit][1],outfit=outfit,step= data[outfit][2]},9)
				return
			end
			CheckCost (playerid,money_num,0,1,"Ԫ����װ��λǿ��")
			CheckGoods(821,num,0,playerid,"Ԫ����װ��λǿ��")
		end
	end
	data[outfit][2] = data[outfit][2]+1
	--������   ����  ���ȹ���
	if data[outfit][2] >= progress then
		data[outfit][1] = data[outfit][1] +1
		data[outfit][2] =0
		--����������
		_wz_attup(playerid,1)		
	end	
	SendLuaMsg(0,{ids=msg_wuzhuang_up,lv = data[outfit][1],outfit=outfit,step= data[outfit][2]},9)
	return true
end

local function wuzhuang_check(playerid,id,name)
	local look_attribute = true
	if type(id)~= type(0) or id < 1 or nil == id then
		look_attribute = false
	end
	if type(name) ~= type('') then
		name=CI_GetPlayerData(5,2,id)
		if type(name) ~= type('') then
			look_attribute = false
		end
	end
	if not look_attribute then
		SendLuaMsg(0,{ids=msg_check,name=name,data=0},9)
		return
	end
	local data_attribute = wz_getwuzhuangdata(id)
	SendLuaMsg(0,{ids=msg_check,name=name,data=data_attribute},9)
end
   --װ��id   outfit_id 
--SI_EquipItem��װ��id�� ����װ��
--[[
	70�� ��ɫ 10��,��ɫ 20��, ��ɫ 30��,��ɫ 40��,��ɫ 50��, 
	80�� ��ɫ 60��
	90�� ��ɫ 70��

]]
local function _EquipItem(outfit_id)
	local grade      --��Ʒ��Ӧ�Ĳ����ȼ�
	local location   --��Ʒ����
	if nil == wuzhuang_zb_conf[outfit_id] then
		return 0
	end
	local playerid = CI_GetPlayerData(17)
	local data=wz_getwuzhuangdata(playerid)
	if nil == data then
		return 1
	end
 	grade = wuzhuang_zb_conf[outfit_id][1]
	location = wuzhuang_zb_conf[outfit_id][2]
	local curlv = data[location] and data[location][1] or 0 
	if curlv >= grade then
		return 0
	end
	return 1
end
--SI_UnEquipItem��װ��id�� ����װ��
--[[local function _UnEquipItem(outfit_id)
	return 0
end]]

--GM���� ֱ�����õ�ǰ�ȼ�
local function _gm_set_level(sid, outfit, level)
	local pdata = wz_getwuzhuangdata(sid)
	if pdata == nil then return end
	if type(outfit) ~= type(0) then return end
	if outfit > 7 or outfit < 1 then return end
	pdata[outfit] = pdata[outfit] or {0,0}
	pdata[outfit][1] = (pdata[outfit][1] or 0) + level
	pdata[outfit][2] =0
	_wz_attup(sid,1)
	SendLuaMsg(0, {ids=msg_wuzhuang_up,lv = pdata[outfit][1], outfit=outfit, step= pdata[outfit][2]}, 9)
end

-----------------------------------------
wuzhuang_up = _wuzhuang_up
wz_attup    = _wz_attup
EquipItem   = _EquipItem
--UnEquipItem = _UnEquipItem
wz_check       = wuzhuang_check
gm_set_level = _gm_set_level