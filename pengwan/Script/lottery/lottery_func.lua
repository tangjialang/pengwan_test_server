--[[
file:	lottery_func.lua
desc:	�齱ϵͳ
author:	wk
update:	2013-2-22
refix:	done by wk
]]--

local type,tostring = type,tostring
local mathrandom = math.random
local GetStringMsg,TipCenter = GetStringMsg,TipCenter
local GetServerTime  = GetServerTime
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local LOT_result	 = msgh_s2c_def[29][1]	
local LOT_list	 	 = msgh_s2c_def[29][2]	
local LOT_get	 	 = msgh_s2c_def[29][3]	
local LOT_list2	 	 = msgh_s2c_def[29][4]	
local LOT_ZYget	 	 = msgh_s2c_def[29][5]	
local LOT_ZYlist	 = msgh_s2c_def[29][6]	
local LOT_commonget	 = msgh_s2c_def[29][7]	
local LOT_online	 = msgh_s2c_def[29][8]	
local look,BroadcastRPC = look,BroadcastRPC
local isFullNum=isFullNum
local CheckGoods,GiveGoods	 = CheckGoods,GiveGoods
local CheckCost	 = CheckCost
local online_conf=online_conf
local uv_TimesTypeTb = TimesTypeTb
local uv_Lot_Confuse=Lottery_ConfUse 	--���ɵĳ齱�������ݿ�
local uv_LOTConfig = Lottery_conf		--�齱Դ����
local uv_vipconf=uv_LOTConfig[1]			--vip�齱Դ����
local uv_onlineconf=uv_LOTConfig[2]			--���߳齱Դ����

local common_rnd = require('Script.common.random_norepeat')
local Get_num 			 = common_rnd.Get_num
local common 			= require('Script.common.Log')
local Log 				= common.Log

local Lottery_bg=20--�ﹱ�齱����
local  sctx_goodsconf={---�񴴱��任����
	{601,5,1},	
	{603,5,1},	
	{626,10,1},	
	{605,5,1},	
	{1052,50,1},	
	{612,3,1},
}

local fishbait_goodsconf = {--����һ���Ʒ�б�
	{1046,2,1},--2����з(��Ʒ���,����,�Ƿ��)
	{1047,1,1},--1����Ϻ
	{1048,2,1},--2��ɳ����
	{1049,1,1},--1��ʯ����
	{1050,2,1},--2������
	{1051,1,1},--1������
}
-- �����콱ʱ������
local ngConf = { 
	[1] = 300,--5����
	[2] = 600,--15����
	[3] = 900,--0.5Сʱ
	[4] = 1800,--1
	[5] = 1800,--1.5
	[6] = 3600,--2.5
	[7] = 3600,--3.5
	
}
-- local ngConf = { 
-- 	[1] = 7,--5����
-- 	[2] = 8,--15����
-- 	[3] = 9,--0.5Сʱ
-- 	[4] = 11,--1
-- 	[5] = 12,--1.5
-- 	[6] = 13,--2.5
-- 	[7] = 14,--3.5
	
-- }
-------------------------------------------------------------
local function GetDBLotdata(playerid )
	local lotData=GI_GetPlayerData( playerid , 'lott' , 250 )
	if lotData == nil then return end
	--look(tostring(lotData))
	return lotData
end
--vip�������ݳ�ʼ��
	-- mark=nil,--�汾�ű�ʶ
	-- item=nil,--��ʱ���ݣ���û��齱ʱ�˳�����Ĺ�����Ʒ����{}
	-- time=nil,--ÿ�����Ƴ�8�Σ����ڳ鼸����
	-- get=nil,--���γ齱8�λ�õ��Ķ���{}

--��ͨ�齱���ݳ�ʼ����1-vip����2-�ﹱ����3-���䣩��4-3ɫ���������5-5ɫ���������6-7ɫ���������7-���߳齱����8-�񴴱��䣩
local function GetDBLotteryData(playerid,itype)
	local LOTBGData=GetDBLotdata( playerid)
	if LOTBGData == nil then return end
	if LOTBGData[itype]==nil then
		LOTBGData[itype]={}
	end
	return LOTBGData[itype]
end

--����ʱ��齱
local function GetNewPlayerGift( playerid )
	if type(ngConf) ~= type({}) then return end
	--local custom = GetCurDBCustomData()
	local custom = GetPlayerDayData(playerid)
	if type(custom.time) ~= type({}) or custom.time[1]==nil or custom.time[1] <= 0 then return end
	local start = custom.time[1]
	local step = custom.time[2] or 1 
	if step > #ngConf then 
		return
	end
	local gift = ngConf[step]
	if type( gift) ~= type(0) or gift <= 0 then
		return
	end
	if GetServerTime() < start then 
		TipCenter(GetStringMsg(434))
		return
	end
	step = step + 1
	if step > #ngConf then 
		custom.time[1] = nil
		custom.time[2] = 8
	else
		custom.time[1] = GetServerTime()+ngConf[step]
		custom.time[2] = step
	end
	SendLuaMsg(0,{ids=LOT_online,_time=custom.time},9)	
	return true,step-1
end
---����������������Ļ����۳�
local function checkCommon_Lottery(playerid,itype)
	if playerid==nil then 
		look('Common_Lotteryplayeriderror')
		return 0
	end
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return 0
	end
	if itype==1 then--itype=1�ﹱ��2����+Կ�ף�3�����
		local bgdata=GetPlayerPoints(playerid,4)
		if bgdata ==nil then 
			return 0 
		end
		local Lottedata=GetDBLotteryData(playerid,itype+1)
		if   Lottedata==nil then
			look('Vip_Lotterydataerror1',1)
			return 
		end
		if Lottedata.mark~=uv_Lot_Confuse.mark then
			Lottedata.item=nil
			--SendLuaMsg(0,{ids=LOT_result,result=12},9)
			Common_startLottery(playerid,itype,1)
			return
		end
		if bgdata<Lottery_bg then --�ﹱ����==================
			SendLuaMsg(0,{ids=LOT_result,result=3},9)
			return 0
		end
		-- local  count =get_Factiontime(playerid)
		-- if count==nil then
			-- look('banghuierrror')
			-- return
		-- end
		-- if count <= 0 then
			-- return 0
		-- end
		-- local fTd = GetDaySpendData(playerid,SpendType.Faction_Luck)
		-- fTd.count=fTd.count+1
		if not CheckTimes(playerid,uv_TimesTypeTb.FACTION_lott,1,-1) then
			return 0
		end
		AddPlayerPoints( playerid , 4 , -Lottery_bg,nil,'�齱' ,true)--===============
		return 1
		
	elseif itype==2 then
		if CheckGoods( 632, 1, 1, playerid,'����') == 0 then--����
			SendLuaMsg(0,{ids=LOT_result,result=8},9)
			return 0
		end
		if CheckGoods( 631, 1, 1, playerid,'Կ��') == 0 then--Կ��
			SendLuaMsg(0,{ids=LOT_result,result=7},9)
			return 0
		end
		CheckGoods( 632, 1,0,playerid,'����')
		CheckGoods( 631, 1,0,playerid,'Կ��')
		return 1
	elseif itype==3 then
		if CheckGoods( 1081, 1, 1, playerid,'�����3') == 0 then--�����3����
			SendLuaMsg(0,{ids=LOT_result,result=9},9)
			return 0
		end
		CheckGoods( 1081, 1,0,playerid,'�����3')
		return 1
	elseif itype==4 then
		if CheckGoods( 1082, 1, 1, playerid,'�����5') == 0 then--�����5����
			SendLuaMsg(0,{ids=LOT_result,result=10},9)
			return 0
		end
		CheckGoods( 1082, 1,0,playerid,'�����5')
		return 1
	elseif itype==5 then
		if CheckGoods( 1083, 1, 1, playerid,'�����7') == 0 then--�����7����
			SendLuaMsg(0,{ids=LOT_result,result=11},9)
			return 0
		end
		CheckGoods( 1083, 1,0,playerid,'�����7')
		return 1
	elseif itype==6 then
		if CheckGoods( 690, 1, 1, playerid,'�񴴱���') == 0 then--�񴴱��乻��
			SendLuaMsg(0,{ids=LOT_result,result=11},9)
			return 0
		end
		CheckGoods( 690, 1,0,playerid,'�񴴱���')
		return 1
	end	
end
--------------------------------------------------------------------------------------


--�������߳齱
 function lot_reset2(playerid)
	local LOTBXData=GetDBLotdata( playerid )
	if LOTBXData == nil then return end
	LOTBXData[7]=nil --�����������
	
	LOTBXData[1]=nil --vip�������

	local dayData 	= GetPlayerDayData(playerid)
	dayData.time = dayData.time or {}		-- ÿ�����߳齱ʱ������
	dayData.time[1] = GetServerTime()+ngConf[1]
	dayData.time[2] =  1
	SendLuaMsg(0,{ids=LOT_online,_time=dayData.time},9)	
end
---------------------------------------------------------------------------------
--vip���Ƴ齱��ʼ������new
function startVip_Lottery(playerid,itype,again)
	-- look('����vip�齱')
	local Lottedata
	if itype==1 then
		Lottedata=GetDBLotteryData(playerid,7)
	else
		Lottedata=GetDBLotteryData(playerid,1)
	end
	
	if Lottedata==nil then
		look('Vip_Lotterydataerror2',1)
		return 
	end
	local vip_conf
	if itype==1 then
		vip_conf=uv_Lot_Confuse[2]
	else
		vip_conf=uv_Lot_Confuse[1]
	end
	if type(vip_conf)~=type({}) then 
		look('vip_conferror')
		return 
	end
	--if Lottedata.item==nil or  Lottedata.time~=nil then --û�����ɿ�,������
	if Lottedata.mark~=uv_Lot_Confuse.mark or Lottedata.item==nil then
		-- look('��������vip�齱')
		if Lottedata.item==nil then
			Lottedata.time=nil--��մ���
			Lottedata.get=nil --��ռ�����õĽ�����
		end
		Lottedata.item=mathrandom(1,#vip_conf) --���һ����
		Lottedata.mark=uv_Lot_Confuse.mark --�ܿ��ʶ
	end
	local item=vip_conf[Lottedata.item]
	SendLuaMsg(0,{ids=LOT_list,vip=item,wtime=Lottedata.time,result=Lottedata.get,again=again,itype=itype},9)
	-- look('��һ����='..Lottedata.item)
end
--vip���Ƶ���齱
function getVip_Lottery	(playerid,itype)
	-- look('vip���Ƶ���齱')
	if playerid==nil then
		return 
	end
	
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		SendLuaMsg(0,{ids=LOT_result,result=1},9)
		return
	end
	local Lottedata
	if itype==1 then
		Lottedata=GetDBLotteryData(playerid,7)
	else
		Lottedata=GetDBLotteryData(playerid,1)
	end
	if Lottedata==nil then return end
	local thistime=Lottedata.time or 0
	-- look('thistime='..thistime+1)
	if thistime  >=8 then
		Lottedata.item=nil
		SendLuaMsg(0,{ids=LOT_result,result=5},9)--����8��
		return
	end
	if itype==1 then
		--�������
		return---20140107ȥ�����߳齱
		--if not GetNewPlayerGift( playerid ) then  return end
	else
		--���vip����
		if CheckGoods( 644, thistime+1, 1, playerid,'vip����') == 0 then--vip���ƹ���
			SendLuaMsg(0,{ids=LOT_result,result=2},9)
			return
		end
	end
	local mark=Lottedata.mark
	local mark_conf=uv_Lot_Confuse.mark

	if mark~=mark_conf then 
		-- look('�����')
		startVip_Lottery(playerid,itype,1)
		
		return
	end
	if  Lottedata==nil or Lottedata.item==nil then
		look('Vip_Lotterydataerror3',1)
		return 
	end
	local templot=uv_Lot_Confuse[1][Lottedata.item]
	if #templot~=18 then 
		SendLuaMsg(0,{ids=LOT_result,result=4},9)
		look('Lottedataerror',1)
		return
	end
	if thistime  ==0 then
		local a={}
		if itype==1 then
			a=Get_num(nil,1,{2,6})--���߳齱,��һ�γ��õ��
			a=Get_num(a,4,{7,18})
			a=Get_num(a,7,{2,18})
			a=Get_num(a,8,{1,6})
		else
			a=Get_num(nil,4,{7,18})
			a=Get_num(a,7,{2,18})
			a=Get_num(a,8,{1,6})
		end
		if a==false or #a~=8 then
			SendLuaMsg(0,{ids=LOT_result,result=4},9)
			look('getLottedata.tempget_error',1)
			return
		end
		Lottedata.get=a
	end
	GETVipLottery(playerid,itype)
	--local thistimeget=Lottedata.get[thistime +1]
	if thistime==0 then
		SendLuaMsg(0,{ids=LOT_get,result=Lottedata.get,wtime=thistime +1,itype=itype},9)
	else
		SendLuaMsg(0,{ids=LOT_get,wtime=thistime +1,itype=itype},9)
	end
	--GETVipLottery(playerid,itype)
	-- look('thistime========'..thistime+1)
end
--��ȡvip�齱���� itype==1����ʱ��齱
function GETVipLottery(playerid,itype)
	local Lottedata
	if itype==1 then
		Lottedata=GetDBLotteryData(playerid,7)
	else
		Lottedata=GetDBLotteryData(playerid,1)
	end
	if  Lottedata==nil then
		look('Vip_Lotterydataerror3',1)
		return 
	end
	local thistime=Lottedata.time or 0
	if thistime  >=8 then
		SendLuaMsg(0,{ids=LOT_result,result=5},9)--����8��
		return
	end
	
	local templot
	if itype==1 then
		templot=uv_Lot_Confuse[2][Lottedata.item]
	else
		templot=uv_Lot_Confuse[1][Lottedata.item]
	end
	if Lottedata.get==nil or Lottedata.get[1]==nil then
		look('Lottedata.tempgeterror',1)
		return 
	end
	if itype==1 then
		
	else
		if CheckGoods( 644, thistime+1, 0, playerid,'vip����') == 0 then--vip���ƹ���
			SendLuaMsg(0,{ids=LOT_result,result=2},9)
			return
		end
	end
	local thistimeget=Lottedata.get[thistime +1]
	
	local item=templot[thistimeget]
	if item[4]==nil then 
		GiveGoods(item[1],item[2],1,'vip�齱')--������
	
	else
		GiveGoods(item[1],item[2],0,'vip�齱')
	
	end
	Lottedata.time=thistime+1--������1
	if Lottedata.time>7 then
		Lottedata.item=nil
	end

	if item[3]==1 then --������Ʒ��ȫ������
		--TipCenter('�õ��ö���id='..item[1])
		BroadcastRPC('LOT_special',7+(itype or 0),CI_GetPlayerData(5),item)
	end
	--SendLuaMsg(0,{ids=LOT_result,result=0,itype=6},9)
end

--��ͳ�齱��ʼ������(12����Ʒ)
--itype=1�ﹱ��2����+Կ�ף�3�����3��4�����5��5�����7��,6�񴴱���
function Common_startLottery(playerid,itype,again)
	-- look('�齱��ʼ������',1)
	-- look(itype,1)
	-- look(again,1)
	if playerid==nil or itype==nil then 
		look('Common_startLotteryerror')
		return
	end
	local common_conf=uv_LOTConfig[itype+2]
	local Lottedata
	if itype==6 then 
		Lottedata=GetDBLotteryData(playerid,itype+2)
	else
		 Lottedata=GetDBLotteryData(playerid,itype+1)
	end
	if  common_conf==nil or Lottedata==nil then
		look('Vip_Lotterydataerror5',1)
		return 
	end
	local ku_conf=uv_Lot_Confuse[itype+2]
	if Lottedata.mark~=uv_Lot_Confuse.mark or Lottedata.item==nil then
		Lottedata.get=nil
		Lottedata.mark=uv_Lot_Confuse.mark
		Lottedata.item=mathrandom(1,#ku_conf)
	end
	-- look('item=='..Lottedata.item,1)
	local temp_conf=ku_conf[Lottedata.item]
	for i=1,12 do
		if temp_conf[i]==nil then
			look("Lottedata.item[i]error",1)
			return
		end
	end
	if itype==1 then
		if not CheckTimes(playerid,uv_TimesTypeTb.FACTION_lott,1,-1,1) then
		
			return
		end
		-- local  count =get_Factiontime(playerid)
		-- if count==nil then
			-- look('banghuierrror')
			-- return
		-- end
		-- look('count=='..count)
		SendLuaMsg(0,{ids=LOT_list2,itype=itype,common=temp_conf,again=again},9)
	else
		SendLuaMsg(0,{ids=LOT_list2,itype=itype,common=temp_conf,again=again},9)
	end
	-- look(Lottedata,1)
end
 --��ͳ�齱�������
 function startCommon_Lottery(playerid,itype)
-- look('��ͳ�齱�������',1)
-- look(itype,1)
	if playerid==nil or itype==nil then 
		look('Common_startLotteryerror')
		return
	end
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return
	end
	
	local common_conf=uv_LOTConfig[itype+2]
	local Lottedata
	if itype==6 then 
		Lottedata=GetDBLotteryData(playerid,itype+2)
	else
		 Lottedata=GetDBLotteryData(playerid,itype+1)
	end
	if  common_conf==nil or Lottedata==nil then
		look('Vip_Lotterydataerror6',1)
		return 
	end
	if Lottedata.mark~=uv_Lot_Confuse.mark then
		Common_startLottery(playerid,itype,1)
		-- look(444,1)
		return
	end
	-- look(Lottedata,1)
	if Lottedata.item==nil then
	 	-- look(333,1) 
	 	return 
	end

	
	local result=checkCommon_Lottery(playerid,itype)
	if result==0 then 
		-- look(222,1)
		return
	end

	local b=mathrandom(1,100)
	local a=0
	if b<=70 then --��ͨ
		a=mathrandom(7,12)
	elseif b<=99 then --����
		a=mathrandom(3,6)
	else
		a=mathrandom(1,2)
	end
	local temp_conf=uv_Lot_Confuse[itype+2][Lottedata.item]
		    -- local num1=rint(temp_conf[a]/100)
			-- local num2=temp_conf[a]%100
		-- item=common_conf[num1][num2]
	-- if temp_conf==nil then 

	-- end
	local item=temp_conf[a]
	Lottedata.get=a
	SendLuaMsg(0,{ids=LOT_commonget,itype=itype,get=item},9)
	getCommon_Lottery(playerid,itype)
	-- look(Lottedata,1)
end
--��ͳ�齱��ȡ
--itype=1�ﹱ��2����+Կ�ף�3�����3��4�����5��5�����7��6�񴴱��䣬
function getCommon_Lottery	(playerid,itype)
	-- look('��ͳ�齱��ȡ',1)
	-- look(itype,1)
	if playerid==nil or itype==nil then 
		look('Common_startLotteryerror')
		return
	end
	local common_conf=uv_LOTConfig[itype+2]
	local Lottedata
	if itype==6 then 
		Lottedata=GetDBLotteryData(playerid,itype+2)
	else
		 Lottedata=GetDBLotteryData(playerid,itype+1)
	end
	--local Lottedata=GetDBLotteryData(playerid,itype+1)
	if  common_conf==nil then
		look('common_conferror',1)
		return 
	end
	if  Lottedata==nil or Lottedata.item==nil or Lottedata.get== nil then
		look('getCommon_Lotterydataerror',1)
		return 
	end
	local get=Lottedata.get
	local temp_conf=uv_Lot_Confuse[itype+2][Lottedata.item]
	-- local num1=rint(temp_conf[get]/100)
	-- local num2=temp_conf[get]%100
	-- local item=common_conf[num1][num2]
	local item=temp_conf[get]
	if item[4]==nil then 
		GiveGoods(item[1],item[2],1,'��ͳ�齱'..itype)--������
	else
		GiveGoods(item[1],item[2],0,'��ͳ�齱'..itype)
	end
	if item[3]==1 then --������Ʒ��ȫ������
		BroadcastRPC('LOT_special',itype,CI_GetPlayerData(5),item)
	end
	-- look('��ͳ�齱��ȡ���',1)
	Lottedata.item=nil
	SendLuaMsg(0,{ids=LOT_result,result=0,itype=itype},9)
	--Common_startLottery(playerid,itype)--��ˢ�ڶ���
end		

--ÿ������15��齱��
function MakeLotconf(itype)
	if itype==1 then
		if uv_Lot_Confuse.mark then
			return
		end	
	end
	if uv_Lot_Confuse==nil then 
		uv_Lot_Confuse={}
	end
	
	local uv_Lot_Confuseuv_Lot_Confuse = uv_Lot_Confuse
	local Get_num = Get_num
	
	uv_Lot_Confuse.mark=GetServerTime()
	uv_Lot_Confuse[1]={}--vip
	uv_Lot_Confuse[2]={}--����
	uv_Lot_Confuse[3]={}----��ͳ:�ﹱ��
	uv_Lot_Confuse[4]={}--��ͳ:�����
	uv_Lot_Confuse[5]={}--��ͳ:3ɫ�����
	uv_Lot_Confuse[6]={}--��ͳ:5ɫ�����
	uv_Lot_Confuse[7]={}--��ͳ:7ɫ�����
	uv_Lot_Confuse[8]={}--��ͳ:�����±���
	for j=1 , 15 do--vip�齱��ˢ��
		---------------------vip
		if uv_Lot_Confuse[1][j]==nil then
			uv_Lot_Confuse[1][j]={}
		end
		if 12>#uv_vipconf[1] or 5>#uv_vipconf[2] then
			look('Vip_Lottery conferror',1)
			return
		end
		uv_Lot_Confuse[1][j][1]=uv_vipconf[3][mathrandom(1,#uv_vipconf[3])]--��Ʒ��ȡ1һ����ֱ�ӷŵ�һ��
		local precious=Get_num(nil,5,{1,#uv_vipconf[2]})--����,ȡ5��
		for i =2 ,6 do
			uv_Lot_Confuse[1][j][i]=uv_vipconf[2][precious[i-1]]
		end
		local common=Get_num(nil,12,{1,#uv_vipconf[1]})--��ͨ��ȡ12��
		for i=1 ,12  do 
			uv_Lot_Confuse[1][j][i+6]=uv_vipconf[1][common[i]]
		end
		-----------------------����
		if uv_Lot_Confuse[2][j]==nil then
			uv_Lot_Confuse[2][j]={}
		end
		if 12>#uv_onlineconf[1] or 5>#uv_onlineconf[2] then
			look('Vip_Lottery conferror',1)
			return
		end
		uv_Lot_Confuse[2][j][1]=uv_onlineconf[3][mathrandom(1,#uv_onlineconf[3])]--��Ʒ��ȡ1һ����ֱ�ӷŵ�һ��
		local precious1=Get_num(nil,5,{1,#uv_onlineconf[2]})--����,ȡ5��
		for i =2 ,6 do
			uv_Lot_Confuse[2][j][i]=uv_onlineconf[2][precious1[i-1]]
		end
		local common1=Get_num(nil,12,{1,#uv_onlineconf[1]})--��ͨ��ȡ12��
		for i=1 ,12  do 
			uv_Lot_Confuse[2][j][i+6]=uv_onlineconf[1][common1[i]]
		end
		--------------------
	end
	for k=3,8 do --��ͨ��ˢ��
		for j=1,15 do
			if uv_Lot_Confuse[k][j]==nil then
				uv_Lot_Confuse[k][j]={}
			end
			local common_conf=uv_LOTConfig[k]
			if 6>#common_conf[1] or 4>#common_conf[2] or 2>#common_conf[3] then
				look('Vip_Lottery conferror',1)
				return
			end
			local jipin=Get_num(nil,2,{1,#common_conf[3]})--��Ʒ��ȡ2һ����ֱ�ӷŵ�1,2��
			local precious=Get_num(nil,4,{1,#common_conf[2]})--����,ȡ5��
			uv_Lot_Confuse[k][j][1]=common_conf[3][jipin[1]]--��Ʒ��ȡ1һ����ֱ�ӷŵ�һ��
			uv_Lot_Confuse[k][j][2]=common_conf[3][jipin[2]]--��Ʒ��ȡ1һ����ֱ�ӷŵ�һ��
			for i =3 ,6 do
				uv_Lot_Confuse[k][j][i]=common_conf[2][precious[i-2]]
			end
			local common=Get_num(nil,6,{1,#common_conf[1]})--��ͨ��ȡ6��
			for i=1 ,6 do
				uv_Lot_Confuse[k][j][i+6]=common_conf[1][common[i]]
			end
		end
	end
end


--------�񴴱��任����
function sctx_changegoods(playerid , iType,num)
	if iType == 1 then
		local pakagenum = isFullNum()
		if pakagenum < #sctx_goodsconf then
			TipCenter(GetStringMsg(14,#sctx_goodsconf))
			return 
		end
		local neednum=num*5
		local needmoney=num*50
		if 0 == CheckGoods(690,neednum,1,playerid,'�񴴱��任����') then--�۵��߻���Ǯ
			return
		end
		if not CheckCost(playerid , needmoney, 0 , 1,'�񴴱��任����') then
			return
		end
		for k,v in pairs(sctx_goodsconf) do
			GiveGoods(v[1],v[2]*num,v[3],'�񴴱��任����')
		end
		--GiveGoodsBatch(sctx_goodsconf,"�񴴱��任����")

		CheckGoods(690,neednum,0,playerid,'�񴴱��任����')
		RPC('sc_getgoods')--��ȡ�ɹ�
	elseif iType == 2 then 
		local pakagenum = isFullNum()
		if pakagenum < #fishbait_goodsconf then --�жϱ����ռ��Ƿ��㹻
			TipCenter(GetStringMsg(14,#fishbait_goodsconf))
			return 
		end
		local neednum=num*10
		local needmoney=num*100000
		if 0 == CheckGoods(638,neednum,1,playerid,'����һ���Ʒ')  then --�ж�����Ƿ��жһ�������Ʒ
			return
		end
		if not CheckCost(playerid,needmoney,0,3,'����һ���Ʒ') then -- �ж�ͭǮ�Ƿ��㹻
			return 
		end

		for k,v in pairs(fishbait_goodsconf) do
			GiveGoods(v[1],v[2]*num,v[3],'����һ���Ʒ')
		end

		--GiveGoodsBatch(fishbait_goodsconf,"����һ���Ʒ")
		CheckGoods(638,neednum,0,playerid,'����һ���Ʒ')
		RPC('sc_getgoods')--��ȡ�ɹ�
	end	
end


----------------------����ʱ���콱--------------------------
----------------------����ʱ���콱--------------------------
----------------------����ʱ���콱--------------------------
function online_getawards( playerid,index )
	local AwardTb	
	local lv=CI_GetPlayerData(1)
	local endlv=table.locate(online_conf,lv,2)--[0] (С�ڱ����С���� ������С����; ���ڱ��������� �����������) 

	local vtype = GI_GetVIPType( playerid ) or 0
	if vtype < 2 then
		AwardTb=online_conf[endlv].common
	else
		AwardTb=online_conf[endlv].vip
	end

	local getok = award_check_items(AwardTb[index]) 
	if not getok then
		return
	end

	local res,num=GetNewPlayerGift( playerid )
	if not res then  return end

	local _,retCode = GI_GiveAward(playerid,AwardTb[num],"����ʱ���콱")
	RPC('on_succ',index)
end