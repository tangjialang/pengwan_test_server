--[[
file:	player_buy.lua
desc:	player buy operations.
author:	chal
update:	2011-12-09
refix:	done by wk
]]--
local db_module =require('Script.cext.dbrpc')
local db_point=db_module.db_point
local common_log  = require('Script.common.Log')
local Log = common_log.Log
local mathceil,tostring,type= math.ceil,tostring,type
local Player_openbag = msgh_s2c_def[15][11]
local player_buyct = msgh_s2c_def[15][15]

local TipCenter=TipCenter
local CI_SetMemberInfo,GetServerID=CI_SetMemberInfo,GetServerID
local CI_GetPlayerData,CheckGoods=CI_GetPlayerData,CheckGoods
local PI_PayPlayer,checkYuanbao=PI_PayPlayer,checkYuanbao
local look,CI_OpenPackage = look,CI_OpenPackage
local GetItemSetting,CI_DelItemByPos,GiveGoods = GetItemSetting,CI_DelItemByPos,GiveGoods
local GetTimesInfo = GetTimesInfo
local TipCenter,GetStringMsg,SendLuaMsg = TipCenter,GetStringMsg,SendLuaMsg
local CheckTimes = CheckTimes
local TimesTypeTb = TimesTypeTb

--1 �ɾ͵��� 2 ���� 3 ����(��Ԫ��) 4 ��ṱ�� 5 �����̵���� 6 ս�� 7 ���� 8 ��ʷ����ֵ 9 pkֵ 10 ������ 11 ����ֵ 12 ����ֵ 13 �������ֵ
local uv_pointMax = {60000,199999999,999999,999999,999999,99999999,99999999,199999999,99999999,99999999,199999999,999999,99999999,9999999}

local pres_conf = {
	needpres = {2400,5200,8400,13800,19800,26400,36000,46400,57600,72600,88600,105600,127200,150000,174000,203400,234200,266400,304800,354800,9999999},
	attr = {
		[1] = {375,750,1125,1687,2250,3375,4875,6375,7875,9750,12875,16000,19750,23500,27250,36000,44750,53500,63500,76000},
		[4] = {75,150,225,337,450,675,975,1275,1575,1950,2575,3200,3950,4700,5450,7200,8950,10700,12700,15200},
		[8] = {50,100,150,225,300,450,650,850,1050,1300,1716,2133,2633,3133,3633,4800,5966,7133,8466,10133},
		[9] = {50,100,150,225,300,450,650,850,1050,1300,1716,2133,2633,3133,3633,4800,5966,7133,8466,10133},
	}
}

-- ��¼��Ҹ�����Ϸ��������
local function GetPlayerPointData(playerid)
	if playerid == nil or playerid == 0 then
		return
	end
	local taskTb = GetDBTaskData( playerid )

	if taskTb.pt == nil then
		taskTb.pt = {
		} 
		-- �Ȳ�����ʷ���ֵ����Ϊ�ò������õ����Ե�������һ��������ֵ
	end
	return taskTb.pt
end

-- ������ͬ�����£������Ϣ��ʱ����
local function SendPlayerPoints( sid )
	local aData = GetPlayerPointData( sid )
	if aData == nil then return end
end

-- ������Ҵ��ҽӿ�
function GetPlayerPoints( sid , pType )
	local aData = GetPlayerPointData(sid)

	if aData == nil then return end
	return aData[pType]
end

--1 �ɾ͵��� 2 ���� 3 ����(��Ԫ��) 4 ��ṱ�� 5 �����̵���� 6 ս�� 7 ���� 8 ��ʷ����ֵ 9 pkֵ 10 ������ 11 ����ֵ 12 ����ֵ 13 �������ֵ 14 �ػ�ͨ�����
--bSet:�Ƿ�ֱ������
--itype=trueΪ��
function AddPlayerPoints( sid , pType , val , bSet,info,itype)
	if itype then
		if val>0 then 
			return
		end
	end
	if type(info)~=type('') then
		look('AddPlayerPoints_no_info',1)
		info = "lua_undef"
		Log('point_info����.txt',pType..'__val='..val)
		Log('point_info����.txt',debug.traceback())
	end
	if sid == nil or pType == nil or val == nil then return end
	if pType > 13 then return end
	local aData = GetPlayerPointData(sid)

	-- ���⴦��
	if pType == 4 then
		if(val>0)then CI_SetMemberInfo(val,1) end --���ðﹱ
	end

	if bSet then 
		aData[pType] = val
	else
		aData[pType] = (aData[pType] or 0) + val
	end
	if aData[pType] >= uv_pointMax[pType] then aData[pType] = uv_pointMax[pType] end
	if aData[pType] < 0 then aData[pType]=0 end
	if bSet == nil and (val>10 or val<-10) and pType~=8 and pType~=9 then		
		--local serverID = GetServerID()
		local serverID = GetGroupID()
		local account=CI_GetPlayerData(15,2,sid)
		local rolename=CI_GetPlayerData(5,2,sid)
		local rolelevel=CI_GetPlayerData(1,2,sid)
		-- local account=CI_GetPlayerData(15)
		-- local rolename=CI_GetPlayerData(5)
		-- local rolelevel=CI_GetPlayerData(1)
		if type(serverID)~=type(0) or type(account)~=type('') or type(rolename)~=type('') or type(rolelevel)~=type(0) then
			Log('�洢ת��ʧ��.txt','-----------start---------')
			Log('�洢ת��ʧ��.txt',info)
			Log('�洢ת��ʧ��.txt',pType)
			Log('�洢ת��ʧ��.txt',account)
			Log('�洢ת��ʧ��.txt',rolename)
			Log('�洢ת��ʧ��.txt',debug.traceback())
			Log('�洢ת��ʧ��.txt','-----------end---------')
		end 
		db_point(serverID,account,rolename,sid,rolelevel,val,info ,pType,aData[pType])
	end
end

-- spend money interface
-- bCheck 1 check only ,0 check and del
-- costType 1 Ԫ�� 3 ͭǮ 
function CheckCost( sid , cost , bCheck , costType ,info,itemid,itemnum)
	if sid == nil or cost == nil then return end
	--rfalse('bCheck='..bCheck..',costType='..costType..',cost='..cost..',sid='..sid)
	if cost<0 then return end
	if costType == 1 then
		if not checkYuanbao(cost, ((bCheck>0 and 0) or 1) ,sid ,info,itemid,itemnum) then
			return false
		end
		if bCheck == 0 then
			VIP_AddExp(sid,cost)
			AddPlayerPoints( sid , 8 , cost , nil,info)
		end
	elseif costType == 3 then
		if CheckGoods(0, cost, bCheck ,sid ,info) == 1 then
			return true
		end
		return false
	else
		Log('checkcost.txt',debug.traceback())
		return false
	end
	return true
end

-- �����ж��ٿ۶��١�����Ϊֹ(Ŀǰֻ���ͭǮ)
-- ���������������!!!
function CheckCostAll( sid, cost, loginfo)
	if type(loginfo) ~= type('') then
		look('CheckCostAll loginfo == nil',1)
		return
	end
	local left = CI_GetPlayerData(48,2,sid)
	if left == nil or left < 0 then return end
	if left < cost then
		cost = left
	end
	
	CheckGoods(0,cost,0,sid,loginfo)
end

--�������itype=1��������2���ֿ⣬
function BuyPackage(sid,itype,index)
	
	local Packagenum=0--������
	local needmoney=0
	local now=0
	local _exp_index=0
	local _exp_now=0
	if itype==1 then
		now=CI_GetPlayerData(63)
		Packagenum=index-now--������ʼ30��
		if Packagenum<=0 then
			return
		end
		local maxm=(index-30)*10+(index-30)*10*((index-30)-1)/2
		local minm=0
		local onlinetime=CI_GetPlayerData(6)
		local needtime=10+(now+1-1)*10
			if needtime<=onlinetime then
				 minm=(now-30+1)*10+(now-30+1)*10*((now-30+1)-1)/2
				 needmoney=mathceil((maxm-minm)/10)
			else
				minm=(now-30)*10+(now-30)*10*((now-30)-1)/2
				 needmoney=mathceil((maxm-minm-onlinetime)/10)
			end
			if needmoney>0 then
				if not CheckCost(sid , needmoney, 1 , 1,'��������'..tostring(itype)) then
					return
				end
			end
		_exp_index=(index-30)*1000+((index-30)-1)*(index-30)*1000/2
		_exp_now=(now-30)*1000+((now-30)-1)*(now-30)*1000/2
	elseif itype==2 then
		now=CI_GetPlayerData(64)
		Packagenum=index-now--�ֿ��ʼ36��
		if Packagenum<=0 then
			return
		end
		local maxm=(index-36)*10+(index-36)*10*((index-36)-1)/2
		local minm=(now-36)*10+(now-36)*10*((now-36)-1)/2
		needmoney=mathceil((maxm-minm)/10)
		if not CheckCost(sid , needmoney, 1 , 1,'��������'..tostring(itype)) then
			return
		end
		_exp_index=(index-36)*1000+((index-36)-1)*(index-36)*1000/2
		_exp_now=(now-36)*1000+((now-36)-1)*(now-36)*1000/2
	else
		return
	end
	local _exp=_exp_index-_exp_now
	if _exp<0 then
		return
	end
	local a=CI_OpenPackage(Packagenum,itype)
	if a==0 then
		if needmoney>0 then
			 CheckCost(sid , needmoney, 0 , 1,'100001_��������'..tostring(itype)) 	
		end
		PI_PayPlayer(1,_exp,0,0,'��������')--���Լ�����
		SendLuaMsg( 0, { ids = Player_openbag,index=index,itype=itype,_exp=_exp,num=Packagenum}, 9 )
	end
end

--��ݳ���
function Fast_Sale(sid,id,num,x,y)
	if sid==nil or id==nil or num==nil then return end
	local iteminfo=GetItemSetting(id)

	if type(iteminfo)==type({}) then
		local cansale=iteminfo.byCanSaleNpc
		local saleprice=iteminfo.dwSell
		if cansale and cansale==1 then
			if saleprice and saleprice>0 then
				local a =CI_DelItemByPos(x,y,id,0,'��ݳ���')
				if a>0 then
					GiveGoods(0,saleprice*a,1,'��ݳ���')
				end
			end
		end
	end
	TipCenter(GetStringMsg(9))
end

--------- ���������๦�� ---------

-- ʹ��С����˵��
function SmallSpeak(sid,iType)
	if iType == nil then return 99 end
	if CheckGoods(619, 1,0,sid,'ʹ��С����˵��') == 1 then
		return 0
	else
		if iType == 1 then
			if not CheckCost(sid,50,0,1,'100015_ʹ��С����˵��') then
				return 2
			else
				return 0
			end
		else
			return 1
		end
	end
end

-- �������(����������)
function player_buytimes(sid,ctype,num)
	if sid == nil or ctype == nil then 
		return
	end
	num = num or 1
	if num <= 0 then return end
	local ct = CheckTimes(sid,ctype,num,1,1)
	if ct == false then
		SendLuaMsg( 0, { ids = player_buyct,res = 1}, 9 )
		return
	end
	local tf = GetTimesInfo(sid,ctype)
	if type(tf) ~= type({}) then
		return
	end
	local cost
	if ctype == TimesTypeTb.CS_Jewel then		-- ��ʯ����
		cost = 50*num
	elseif ctype == TimesTypeTb.MK_Attack then	-- ��λ��
		cost = 20*num
	elseif ctype == TimesTypeTb.rob_fight then	-- �Ӷ�
		cost = 10 + (tf[3] or 0) * 5
		if cost > 50 then
			cost = 50
		end
	elseif ctype == TimesTypeTb.vip_fuben then	-- �Ӷ�
		cost = 50 * num
	end
	
	if cost == nil or cost < 0 then				-- logic erro
		return
	end
	if not CheckCost(sid, cost, 0, 1, '100012_�������__' .. tostring(ctype)) then
		SendLuaMsg( 0, { ids = player_buyct,res = 2}, 9 )
		return
	end
	CheckTimes(sid,ctype,num,1)					-- ���ӹ������&ʣ�����	
	SendLuaMsg( 0, { ids = player_buyct,res = 0}, 9 )
end

-- ���������
function give_sphonour(sid, val)
	if sid == nil or sid < 0 or val == nil then return end
	AddPlayerPoints(sid, 13, val, nil,'�������')
end

----[[
-- ��������ֵ��ȡ��������ȼ�
function get_preslv(sid)
	if sid == nil or sid < 0 then return end
	local pres = GetPlayerPoints(sid, 12) --ȡ�������ֵ
	pres = pres or 0
	local preslv = 0
	for i = 1, #pres_conf.needpres do
		if pres_conf.needpres[i + 1] then
			if pres >= pres_conf.needpres[i] and pres < pres_conf.needpres[i + 1] then
				preslv = i
				break
			end
		else
			if pres >= pres_conf.needpres[i] then
				preslv = i
				break
			end
		end
	end
	return preslv
end
-- ����ֵ��������
-- itype��1 ������ֵ 2 ������ֵ
-- act_type��1 ���������� 2 ����������
function pres_add_score(sid, itype, val, act_type)
	if sid == nil or itype == nil or val == nil or act_type == nil then return end
	if val < 0 then return end
	local TYPE_PRE = 12
	local preslv = get_preslv(sid)
	preslv = preslv or 0
	if itype == 1 then --������ֵ
		if act_type == 1 then			
			local ret = CheckTimes(sid, TimesTypeTb.span_pres, val, 0, 0) --�������ֵÿ������
		end
		preslv = get_preslv(sid)
		AddPlayerPoints(sid, TYPE_PRE, -val, nil,'����ֵ',true) -- ��ʧ����ֵ
		local pres = GetPlayerPoints(sid, TYPE_PRE) --ȡ�������ֵ
		if preslv or 0 <= 0 then
			prestige_attup(sid,1) --���Լӳ�
		elseif (pres or 0) < pres_conf.needpres[preslv] then
			prestige_attup(sid,1) --���Լӳ�
			SetPresIcon(sid)
		end
	elseif itype == 2 then --������ֵ
		if act_type == 1 then
			local timesCache = GetTimesInfo(sid,TimesTypeTb.span_pres)
			if type(timesCache) ~= type({}) then return end
			local pres_daylast = timesCache[2]
			pres_daylast = pres_daylast or 0
			-- look('pres_daylast = ' .. pres_daylast)
			val = math.min(pres_daylast, val)
			if CheckTimes(sid, TimesTypeTb.span_pres, val, -1, 0) then --�������ֵÿ������
				AddPlayerPoints(sid, TYPE_PRE, val, nil,'����ֵ') -- ��������ֵ
				local pres = GetPlayerPoints(sid, TYPE_PRE) --ȡ�������ֵ
				if (pres or 0) >= pres_conf.needpres[preslv + 1] then
					preslv = preslv + 1 --���������ƺ�
					SetPresIcon(sid,preslv)
					if preslv >= 20 then return end --�����ȼ��Ѵﵽ���� 
					prestige_attup(sid,1) --���Լӳ�
					-- RPC('preslv_chg', preslv)
				end
			end
		else
			AddPlayerPoints(sid, TYPE_PRE, val, nil,'����ֵ') -- ��������ֵ
			
			local pres = GetPlayerPoints(sid, TYPE_PRE) --ȡ�������ֵ
			if (pres or 0) >= pres_conf.needpres[preslv + 1] then
				preslv = preslv + 1 --���������ƺ�
				SetPresIcon(sid,preslv)
				if preslv >= 20 then return end --�����ȼ��Ѵﵽ���� 
				prestige_attup(sid,1) --���Լӳ�
				-- RPC('preslv_chg', preslv)
			end
		end
	end	
end
-- ��������15���Ժ�ÿ���Զ���ʧ����ֵ
function day_delete_pres(sid)
	local preslv = get_preslv(sid)
	preslv = preslv or 0
	if (preslv or 0) >= 16 then
		local pres = GetPlayerPoints(sid, 12) --ȡ�������ֵ
		pres = pres or 0
		pres = math.min(pres - pres_conf.needpres[preslv], 200*(preslv - 15))
		AddPlayerPoints( sid, 12, -pres, false, '����ֵ', true)
	end
end
-- ����Ѫ����
function prestige_attup(playerid,itype)
	if playerid==nil  then
		return
	end
	local preslv=get_preslv(playerid)
	if preslv == nil then return end
	local tempAtt=GetRWData(1)
	if preslv <= 0 then
		if type(pres_conf.attr) == type({}) then
			for k, v in pairs(pres_conf.attr) do
				tempAtt[k] = 0
			end
		end
	else 
		if type(pres_conf.attr) == type({}) then
			for k, v in pairs(pres_conf.attr) do
				tempAtt[k] = (tempAtt[k] or 0) + v[preslv]
			end
		end
	end
	if itype then 
		PI_UpdateScriptAtt(playerid,ScriptAttType.prestige)
	end
	return true
end

-- ���ߵ���
function SetPresIcon(sid,plv)
	if sid == nil then return end
	local presLV = 0
	if plv then
		presLV = plv
	else
		presLV = get_preslv(sid) or 0
	end
	
	if presLV <= 0 or presLV >= 32 then return end
	local srcIcon = CI_GetPlayerIcon(3,3)
	srcIcon = bits.set(srcIcon,11,15,presLV)
	
	CI_SetPlayerIcon(3,3,srcIcon)
end
--]]