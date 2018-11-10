--[[
file:	player_awake.lua
desc:	���100������
author:	zhongsx
update:	2015-04-22
]]--

local msg_awake =  msgh_s2c_def[3][31]
local msg_equip =  msgh_s2c_def[3][32]

local GI_GetPlayerData = GI_GetPlayerData
local SendLuaMsg = SendLuaMsg
local CI_GetPlayerData = CI_GetPlayerData
local PI_PayPlayer = PI_PayPlayer
local CI_PayPlayer = CI_PayPlayer
local  GiveGoodsBatch = GiveGoodsBatch
local TipCenter = TipCenter
local RPCEx = RPCEx
local look = look
local type = type
local CheckCost = CheckCost
local isFullNum = isFullNum
local GiveGoods  = GiveGoods
--------------------------
module(...)
--------------------------
--����
local awakeconf ={
	limitlevel = 100, --������С�ȼ�
	maxproc = 100, --�����ѽ���
	equip = {
		[1] = 5257,  --����װ��
		[2] = 5294,  --����װ��
		[3] = 5331,   --����װ��
	}, --���ѳɹ���, ���͵�װ�� ��ְҵ
	--ÿһ���� ��Ҫ���� proc * 400000 exp
	needexp = function(proc)
		return ((proc + 1) * 400000)
	end,
	needyb = 20, --ÿһ������Ҫ����1000YB
}
	
--[[
	awake={
		[1] = 0~100; ---���ѽ���
		[2] = 1 or 0;  --�Ƿ�����ȡװ��
	}
]]--
local function GetAwakeData(sid)
	local pdata = GI_GetPlayerData(sid, 'awake', 16)
	if pdata == nil then return end
	if pdata[1] == nil then 
		pdata[1] = 0
	end
	return pdata
end

--��Ҿ��ѷ���
local function _awake_data(sid, itype)
	if type(itype) ~= type(0) then return end

	local pdata = GetAwakeData(sid)
	if pdata == nil then return end

	--�ѳɹ����ѻ��߾��Ѷ��Ѵ�MAX
	if pdata[1] >= awakeconf.maxproc then 
		SendLuaMsg(0, {ids=msg_awake, itype=itype, err = 8}, 9)
		return 
	end

	local lv = CI_GetPlayerData(1)		-- ��ҵȼ�
	if lv < awakeconf.limitlevel then 
		SendLuaMsg(0, {ids=msg_awake,  itype=itype, err = 5}, 9)
		return 
	end
	
	--���ѷ�ʽ
	local pExps, needexp 
	if itype == 1 then 
		 pExps = CI_GetPlayerData(4)		-- ��ҵ�ǰ����
		 needexp = awakeconf.needexp(pdata[1]) 
		if pExps < needexp  then 
			SendLuaMsg(0, {ids=msg_awake,  itype=itype,  err = 6}, 9)
			return 
		end
		--��һ������ �۳�����
		PI_PayPlayer(1,-needexp,0,0,'������ѽ�������')
		pdata[1] = pdata[1] + 1
	elseif itype == 2 then 
		if not CheckCost( sid , awakeconf.needyb,  1 , 1, "������ѽ�������") then
			SendLuaMsg(0, {ids=msg_awake,  itype=itype, err = 7}, 9)
			return
		end
		--��һ������ �۳�����
		CheckCost( sid , awakeconf.needyb,  0, 1, "������ѽ�������") 
		pdata[1] = pdata[1] + 1
	end
	
	--������ --��������
	local  needexp
	if pdata[1] == awakeconf.maxproc  then 
		RPCEx(sid, 'awake_succ')
	end
	--
	SendLuaMsg(0, {ids=msg_awake,  itype=itype, proc=pdata[1]}, 9)
end

--��ҷ����ɹ���ȡװ��
local function _get_equip(sid)
	local pdata = GetAwakeData(sid)
	if pdata == nil then return end
	
	local lv = CI_GetPlayerData(1)		-- ��ҵȼ�
	if lv < awakeconf.limitlevel then 
		SendLuaMsg(0, {ids=msg_equip, err = 9}, 9)
		return 
	end
	---
	if pdata[1] ~= awakeconf.maxproc then 
		SendLuaMsg(0, {ids=msg_equip, err = 9}, 9)
		return 
	end
	
	--װ���Ƿ�����ȡ
	if pdata[2] == 1 then 
		SendLuaMsg(0, {ids=msg_equip, err = 10}, 9)
		return 
	end

	-- ��鱳��
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,2))
		return
	end
	---
	local school =   CI_GetPlayerData(2)  --��ȡ���ְҵ
	local ret = GiveGoods(awakeconf.equip[school], 1, 1, '���ѳɹ����͵�װ��')
	if ret then 
		pdata[2] = 1
		SendLuaMsg(0, {ids=msg_equip}, 9)
	end
end

---
player_awake_data = _awake_data
player_get_equip = _get_equip