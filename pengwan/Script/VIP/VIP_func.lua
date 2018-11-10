--[[
file:	VIP_func.lua
desc:	VIP
author:	csj
]]--

local uv_TimesTypeTb = TimesTypeTb
local VipMailConf = MailConfig.VIPNotice
local pairs,tostring = pairs,tostring
local ipairs = ipairs
local look = look
--s2c_msg_def
local VIP_Data = msgh_s2c_def[34][1]
local VIP_Get = msgh_s2c_def[34][2]
local VIP_Exps = msgh_s2c_def[34][3]
local SendLuaMsg = SendLuaMsg
local CI_SetPlayerIcon = CI_SetPlayerIcon
local GetServerTime =GetServerTime
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos
----------------------------------------------------------------
--data:

-- VIP ����
local VIPConfig = {
	LvInfo = {		-- ��Ҫ����
		[1] = {0,},		
		[2] = {10000,},
		[3] = {20000,},
		[4] = {40000,},
		[5] = {80000,},
		[6] = {160000,},
		[7] = {320000,},
		[8] = {640000,},
		[9] = {1280000,},
	},
	TypeInfo = {	-- ��Ҫ��Ԫ����,����Ļ���vip����,ʱЧ����,ͼ����(���ڸ��¸�C++��ʾ),ÿ�����Ӿ���,ÿ��VIP���
		[1] = {0,0,1,1,0,			{{644,5,1},{51,1,1}}	},			-- ����
		[2] = {198,0,10,2,1000,		{{644,5,1},{739,1,1}}	},			-- �ƽ�
		[3] = {468,10000,30,3,1000,		{{644,5,1},{739,2,1}}	},		-- �׽�
		[4] = {1988,40000,180,4,1500,	{{644,5,1},{640,2,1},{669,1,1}}	},		-- �Ͻ�
	},
	gift = {{710,5,1},{52,5,1},{604,100,1},{618,5,1},{0,1000000,1},{622,1,1},{673,5,1},{1062,5,1}},
}

--------------------------------------------------------------------
--inner function:

-- ��ȡVIP����
local function GetPlayerVIPData( playerid )
	local vipdata=GI_GetPlayerData( playerid , 'VIP' , 30 )
	if vipdata == nil then return end
	-- {
	-- 	[1]: [1] ���� [2] �ƽ� [3] �׽� [4] �Ͻ�
	--  [2]: ʣ��ʱ��
	--  [3]: vip����
	--  [4]: ��ʱVIP����ʱ��
	--	[5]: �Ƿ��һ�ι���VIP���꿨(nil:û��� 1 �����û����� 2 �Ѿ��������)
	-- }
	--look(tostring(vipdata))
	return vipdata
end

--[[
	��ȡVIP��Ϣ�����ṩ�ⲿ����,��Ϊ����û�ж�ʱЧ�ԣ�
@return: 
	vipType: [1] ���� [2] �ƽ� [3] �׽� [4] �Ͻ�
	vipLeft: ʣ��ʱ��
	vipExp: vip����
]]--
local function PI_GetVIPInfo(sid)
	local vipData = GetPlayerVIPData(sid)
	if vipData == nil then
		return 0,0,0
	end
	
	return (vipData[1] or 0),(vipData[2] or 0),(vipData[3] or 0)
end

-- ����vip��Ϣ
local function PI_SetVIPInfo(sid,vipType,vipLeft,vipExp)
	local vipData = GetPlayerVIPData(sid)
	if vipData == nil then return end
	vipData[1] = vipType or 0
	vipData[2] = vipLeft or 0
	vipData[3] = vipExp or 0
	-- look(vipData[1])
	-- look(vipData[2])
	-- look(vipData[3])
end

-- ����ͬ��VIP��Ϣ(not use)
local function VIP_SyncData(sid)
	local vipData = GetPlayerVIPData(sid)
	if vipData == nil  then
		return
	end
	SendLuaMsg( 0, { ids = VIP_Data, data = vipData }, 9 )
end

---------------------------------------------------------------------------------
--interface:

-- ����vip��ϵͳָ��Ա��GM
function set_vip_icon(sid,itype,val,br)
	if sid == nil or itype == nil or val == nil or br == nil then return end
	if not IsPlayerOnline(sid) then
		return 1
	end
	if val < 0 or val > 4 then 				--vip [0,4]
		return 2
	end
	local icon = CI_GetPlayerIcon(0,0,2,sid)
	if icon == 0x10 and itype ~= 3 then		-- GM��ֻ����ȡ������
		return 3
	end
	look('oldicon:' .. icon)
	if icon == nil or icon < 0 then return end
	if itype == 1 then		-- ����vip
		icon = rint(icon / (2^3)) * (2^3) + val	
	elseif itype == 2 then	-- ����ϵͳָ��Ա
		local oldbit = rint(icon / (2^3)) % 2
		if val == 0 then		-- ȡ��
			if oldbit == 1 then
				icon = icon - 2^3
			end
		elseif val == 1 then	-- ����
			if oldbit == 0 then
				icon = icon + 2^3
			end
		end
	elseif itype == 3 then	-- ����GM
		if val == 0 then		-- ȡ��
			icon = 0
		elseif val == 1 then	-- ����
			icon = 0x10
		end		
	end
	look('icon:' .. icon)
	CI_SetPlayerIcon(0,0,icon,br,2,sid)
	return 0
end

-- ��½��buff
function vip_login_addbuff(sid)
	-- local vipType = GI_GetVIPType(sid)
	-- if vipType and vipType == 4 then
	-- 	CI_AddBuff(94,0,1,true,2,sid)		-- ��buff
	-- end
	local vtype = GI_GetVIPType( sid ) or 0
	if vtype < 2 then
		return
	end
	local vip=GI_GetVIPLevel( sid ) or 0
	if vip>=4 then 
		CI_AddBuff(94,0,1,true,2,sid)		-- ��buff
	end
end

-- VIPÿ�ո���
function VIP_DayReset(sid,iDays)
	local vipData = GetPlayerVIPData(sid)
	if vipData == nil or vipData[1] == nil or vipData[2] == nil or vipData[3] == nil then 
		return 
	end
	if iDays < 1 then iDays = 1 end
	local bSetIcon = true
	local oldDays = vipData[2] or 0
	if oldDays == 0 then
		bSetIcon = false		-- �Ѿ�����VIP��Ӧ���Ѿ����ù�VIP��ʶ�� ����C++����
	end
	local oldType = vipData[1] or 0
	vipData[2] = oldDays - iDays
	if vipData[2] <= 0 then	
		-- vipData[1] = 0			-- ����vip���� �������� ����֮ǰ�������
		vipData[2] = 0				-- ����vipʣ������
		-- < 0 ˵��ʱ�䵽���ˡ���Ҫ�۳�ÿ�վ���
		vipData[3] = (vipData[3] or 0) - (iDays - oldDays) * 500
		-- ʱЧ���� ���VIP��ʶ
		if bSetIcon then
			set_vip_icon(sid,1,0,1)
			SendSystemMail(sid,VipMailConf,1,2)
		end
	end
	-- ����ǰ�ʼ�����
	if vipData[2] >= 1 and vipData[2] <= 3 then
		SendSystemMail(sid,VipMailConf,5,2)
	end
	
	local addExp = VIPConfig.TypeInfo[oldType][5] or 0
	oldDays = math.min(oldDays,iDays)	
	vipData[3] = (vipData[3] or 0) + oldDays * addExp
	if vipData[3] < 0 then vipData[3] = 0 end
	
	SendLuaMsg( 0, { ids = VIP_Data, data = vipData,bSetIcon = bSetIcon }, 9 )
end

-- VIP���Ӿ���
function VIP_AddExp(sid,exps)
	-- look('VIP_AddExp:' .. exps)
	if sid == nil or exps == nil then
		return
	end
	if exps < 0 then
		return
	end
	local vipData = GetPlayerVIPData(sid)
	if vipData == nil then 
		return 
	end
	local oldLv = GI_GetVIPLevel(sid)
	if oldLv == 0 then
		return
	end	
	vipData[3] = (vipData[3] or 0) + exps
	local newLv = GI_GetVIPLevel(sid)
	if newLv > oldLv then
		vip_timesreset(sid,oldLv,newLv)
		if newLv==4 then 
			CI_AddBuff(94,0,1,true,2,sid)		-- ��buff
		end
	end
	SendLuaMsg( 0, { ids = VIP_Exps, exps = vipData[3] }, 9 )
end

-- ����˻�ȡVIP�ȼ�ͳһ�ӿڡ�ֻ�������ж�Ȩ��
-- vipLv = 0 ����ʧЧ�ѹ�
function GI_GetVIPLevel(sid)
	if sid == nil then
		sid = CI_GetPlayerData(17)
	end
	local vipData = GetPlayerVIPData(sid)
	if vipData == nil then
		return 0
	end
	
	local now = GetServerTime()
	local vipLv = 0	
	if ( ((vipData[2] or 0) > 0) or (vipData[4] and now < vipData[4]) ) then	-- ֻҪʱЧ��û�� vip�ȼ�����Ϊ 1
		for k, v in ipairs(VIPConfig.LvInfo) do
			if (vipData[3] or 0) < v[1] then
				vipLv = k - 1
				break
			else
				vipLv = k
			end
		end
	end
	
	return vipLv
end

function GI_GetVIPType(sid)
	if sid == nil then 
		return 0
	end
	local vipType = CI_GetPlayerIcon(0,0,2,sid)
	if vipType == nil or vipType < 0 then
		return 0
	end
	return vipType%(2^3)	
end

-- ����VIP
function VIP_BuyLv(sid,fName,iType,buseitem)	
	if iType == nil or iType <= 1 or iType > 4 then
		return
	end
	local playerid = sid
	if fName ~= nil then	-- �����ѹ��� ��̨��ʱ���ж��Ƿ��Ǻ���
		playerid = GetPlayer(fName,0)		
	end
	look(playerid)
	if playerid == nil then
		SendLuaMsg( 0, { ids = VIP_Data, fName = fName, res = 1 }, 9 )	-- �Է�������
		return 
	end
	local vipData = GetPlayerVIPData(playerid)
	if vipData == nil then return end
	local vipType,vipLeft,vipExp = PI_GetVIPInfo(playerid)	
	-- look(vipType)
	-- look(vipLeft)
	-- look(vipExp)

	local cost = VIPConfig.TypeInfo[iType][1]
	if cost == nil or cost < 0 then
		look("����Ҫ��������!!!")
		return
	end
	-- ע�⣺��ǮҪ�۹����Ǹ��˵� �ȼ��
	if not buseitem and not CheckCost(sid,cost,1,1,"����VIP") then
		SendLuaMsg( 0, { ids = VIP_Data, fName = fName, res = 3 }, 9 )	-- ľ��ǮҲ���ΪVIP
		return
	end
	local oldLv = GI_GetVIPLevel(sid)
	if vipLeft > 0 then
		vipType = math.max(vipType,iType)
	else
		vipType = iType
	end	
	if buseitem and iType == 2 then
		vipLeft = vipLeft + 3
	else
		vipLeft = vipLeft + VIPConfig.TypeInfo[iType][3]
	end
	
	vipExp = math.max(vipExp,VIPConfig.TypeInfo[iType][2])
	
	-- ����VIP��Ϣ
	PI_SetVIPInfo(playerid,vipType,vipLeft,vipExp)
	
	-- ע�⣺��ǮҪ�۹����Ǹ��˵ģ����ܿ�
	-- ��Ǯ���������þ���֮�� ��Ȼ�ᱻ����
	if not buseitem then
		CheckCost(sid,cost,0,1,"100007_VIP_" .. tostring(iType))
	else
		VIP_AddExp(sid,cost)
	end
	
	local newLv = GI_GetVIPLevel(sid)
	if newLv > oldLv then
		vip_timesreset(sid,oldLv,newLv)
	end
	
	-- �������ʱVIP�����Ƿ���������ʱVIP
	if vipData[4] then
		vipData[4] = nil
	end
	
	-- ����VIPͼ��	
	set_vip_icon(playerid,1,vipType,1)
	
	-- �����Ƿ��һ�ι�����꿨
	if iType == 4 then
		vipData[5] = vipData[5] or 1
		CI_AddBuff(94,0,1,true,2,playerid)		-- ��buff
	end
	
	local pName = CI_GetPlayerData(5)
	if fName == nil then
		SendLuaMsg( 0, { ids = VIP_Data, data = vipData, res = 0, buseitem = buseitem }, 9 )
		SendSystemMail(playerid,VipMailConf,100+iType,2)	-- �����iType���ö�Ӧ�ʼ����
		if iType == 4 then
			BroadcastRPC('tip_notice',1,pName)
		end		
	else
		SendLuaMsg( 0, { ids = VIP_Data, fName = fName, res = 0 }, 9 )
		-- �����ʼ�֪ͨ�Է�		
		SendLuaMsg( playerid, { ids = VIP_Data, pName = pName, data = vipData, res = 0 }, 10 )		
		SendSystemMail(playerid,VipMailConf,iType,2,pName)	-- �����iType���ö�Ӧ�ʼ����
		if iType == 4 then
			BroadcastRPC('tip_notice',1,fName)
		end
	end
	set_obj_pos(playerid,1002)
end

-- ��ȡÿ��VIP���
function VIP_GetDayGift(sid)
	look('VIP_GetDayGift')
	local vipType = CI_GetPlayerIcon(0,0)	
	look('vipType:' .. tostring(vipType))
	if vipType%(2^3) <= 0 then	 		-- ��ľ�г�ΪVIP���� ��!
		SendLuaMsg( 0, { ids = VIP_Get, res = 1, opt = 1 }, 9 )	
		return
	end
	if VIPConfig.TypeInfo[vipType] == nil then return end
	local goods = VIPConfig.TypeInfo[vipType][6]
	if goods == nil then return end
	local pakagenum = isFullNum()
	if pakagenum < #goods then			-- ���������󰡣��ף�
		SendLuaMsg( 0, { ids = VIP_Get, res = 3, opt = 1 }, 9 )	
		return
	end
	-- �ж��Ƿ���ȡ
	if not CheckTimes(sid,uv_TimesTypeTb.VIP_DayGet,1,-1) then
		look("��ȡ���˰����ף�")
		return
	end
	local succ, retCode, num = GiveGoodsBatch(goods,"VIP�������")
	if not succ and retCode == 3 then
		TipCenter(GetStringMsg(14,num))
		return
	end

	SendLuaMsg( 0, { ids = VIP_Get, res = 0, opt = 1 }, 9 )
end

-- ��ȡ�״ι���VIP���꿨���
function VIP_GetFirstGift(sid)
	local vipData = GetPlayerVIPData(sid)
	if vipData == nil then return end
	if vipData[5] == nil or vipData[5] > 1 then
		SendLuaMsg( 0, { ids = VIP_Get, res = 1, opt = 2 }, 9 )
		return
	end
	local goods = VIPConfig.gift
	local pakagenum = isFullNum()
	if pakagenum < #goods then			-- ���������󰡣��ף�
		SendLuaMsg( 0, { ids = VIP_Get, res = 2, opt = 2 }, 9 )	
		return
	end
	-- ��������ȡ
	vipData[5] = 2
	local succ, retCode, num = GiveGoodsBatch(goods,"VIP�������")
	if not succ and retCode == 3 then
		TipCenter(GetStringMsg(14,num))
		return
	end
	SendLuaMsg( 0, { ids = VIP_Get, res = 0, opt = 2 }, 9 )
end

-- ������ʱvip(��Ҫ����ֻ֤�����һ��)
function VIP_SetTemp(sid)
	sid = sid or CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then return end
	local vipLv = GI_GetVIPLevel(sid)
	local vipData = GetPlayerVIPData(sid)
	if vipLv and vipLv == 0 and vipData then
		if vipData[4] == nil then
			set_vip_icon(sid,1,1,1)
			vipData[4] = GetServerTime() + 30*60
			look('SetEvent')
			SetEvent(30*60,nil,'VIP_Notice',sid)
			SendLuaMsg( sid, { ids = VIP_Data, data = vipData, tmp = 1 }, 10 )
		end		
	end
end

function VIP_Notice(sid)
	if VipMailConf == nil then return end
	if IsPlayerOnline(sid) then
		local vipData = GetPlayerVIPData(sid)
		if vipData then
			vipData[4] = nil
		end
		local vipLv = GI_GetVIPLevel(sid)
		if vipLv == nil or vipLv == 0 then
			set_vip_icon(sid,1,0,1)			-- ���VIP��ʶ
			SendLuaMsg( sid, { ids = VIP_Data, data = vipData, tmp = 0 }, 10 )
			
			-- �����ʼ�����
			SendSystemMail(sid,VipMailConf,1,2)
		end
	end
end

-- VIP���ߴ���(�ж���ʱVIP��Ϣ)
function VIP_OnlineProc(sid)
	local vipData = GetPlayerVIPData(sid)				
	if vipData then
		local now = GetServerTime()
		if vipData[4] and now >= vipData[4] then	-- ��ʱVIPʧЧ��
			vipData[4] = nil
			local vipLv = GI_GetVIPLevel(sid)
			if vipLv == nil or vipLv == 0 then
				set_vip_icon(sid,1,0,1)				-- ���VIP��ʶ
			end
			SendLuaMsg( sid, { ids = VIP_Data, data = vipData, tmp = 0 }, 10 )
		end
	end
end

-- for test
function clear_vip(sid)
	local vipData = GetPlayerVIPData(sid)
	if vipData then
		vipData[1] = nil
		vipData[2] = nil
		vipData[3] = nil
		vipData[4] = nil
		vipData[5] = nil
		set_vip_icon(sid,1,0,1)			-- ���VIP��ʶ
		SendLuaMsg( sid, { ids = VIP_Data, data = vipData }, 10 )
	end
end

-- ��ʱvip
function vip_tempfun(sid)
	local vipType = GI_GetVIPType(sid)
	if vipType >= 2 then
		set_obj_pos(sid,1002)
	end
end