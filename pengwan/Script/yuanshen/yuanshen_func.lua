--[[
file:	yuanshen_func.lua
desc:	Ԫ��ϵͳ
author:	dzq
update:	2014-4-8
refix:	done by dzq
]]--
local look = look
local table_insert = table.insert
local pairs,ipairs = pairs,ipairs
local CheckGoods	 = CheckGoods
local CheckCost	 = CheckCost
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
--local msg_yuanshen_init	 = msgh_s2c_def[45][1] ---   ��ʼ����Ϣ	
local msg_yuanshen_up	 = msgh_s2c_def[45][2]--����
local msg_yuanshen_all_up	 = msgh_s2c_def[45][3]--һ������
local msg_yuanshen_normal_challenge	 = msgh_s2c_def[45][4]--��ͨ��ս
local msg_yuanshen_all_challenge	 = msgh_s2c_def[45][5]--һ��ɨ��
local msg_yuanshen_one_challenge	 = msgh_s2c_def[45][6]--ɨ��
local msg_yuanshen_buytimes	         = msgh_s2c_def[45][7]--��������
local msg_yuanshen_suc               = msgh_s2c_def[45][8]--������ս�ɹ�
local msg_yuanshen_refresh              = msgh_s2c_def[45][9]-- Ԫ��ÿ������
local CI_UpdateScriptAtt = CI_UpdateScriptAtt
local CI_GetPlayerData=CI_GetPlayerData
local ScriptAttType = ScriptAttType
local type=type
local rint = rint
local GiveGoods=GiveGoods
local __G = _G
local GI_GetPlayerData=GI_GetPlayerData
local TipCenter = TipCenter
local isFullNum = isFullNum
local IsSpanServer = IsSpanServer


--�δ����� = INT(���e/3+2)*�������
--ÿ���M�� = INT(���e^2/6+2)*�������^2
--��Ѫ���� = INT(���e*10+���e^2)*5*�������
--����/���R = INT(���e*10+���e^2)*�������
--���Թ��� = INT(���e*10+���e^2)*�������
--���Կ��� = =INT(���e*10+���e^2*1.5)*�������
--�������� Ԫ��ȼ� �� �Ƿ�ͨ��Ԫ��ؿ�
function yuanshen_getdata( playerid )
	local data=GI_GetPlayerData( playerid , 'yuanshen' , 200 )
	local fb_data = CS_GetPlayerData(playerid)
	local fb_type = 17 --Ԫ�񸱱�Ϊ17
	if(data == nil) then 
		return
	end	

	if data.lv == nil or data.checkpoint == nil or data.gettimes== nil or data.usetimes == nil then 
	--��ʼ��Ԫ��ȼ�
		data.lv = {}
		data.gettimes = {} --���д���
		data.usetimes = {} --ʹ�ô���
		data.progress = {}
		if(fb_data.pro and fb_data.pro[fb_type]) then	
			data.checkpoint = fb_data.pro[fb_type]	
		else
			data.checkpoint = 0
		end
		for i = 1,10 do
			data.lv[i] = 0--�ȼ�
			data.gettimes[i] = 1 --���ô���
			data.usetimes[i] = 0 --�Ѿ�ʹ�ô���
			data.progress[i] = 0--������
		end
	end
	--��ս���ĸ�����
	if(fb_data.pro and fb_data.pro[fb_type]) then
		data.checkpoint = fb_data.pro[fb_type]%17000	
	end
	return data
end

--ÿ����������
function refresh_yuanshen(playerid)
	local data=yuanshen_getdata(playerid)
	if(data.gettimes == nil or data.usetimes == nil) then
		return
	end
	for i = 1,10 do
		if( data.gettimes[i] < 1) then
			data.gettimes[i] = 1
		end	
		data.usetimes[i] = 0
	end
	SendLuaMsg(0,{ids=msg_yuanshen_refresh,have = data.gettimes,used = data.usetimes},9)
end
--Ԫ���ʼ����Ϣ
--[[function yuanshen_init(playerid)
	local data=yuanshen_getdata( playerid)
	local lvlist = data.lv
	local point = data.checkpoint
	look(" ����������"..point,1)
	--���д��������ô���
	local havetimes = data.gettimes
	local usedtimes  = data.usetimes
	local progressValue = data.progress
	--��������Ϣ�����ͷ���
	SendLuaMsg(0,{ids=msg_yuanshen_init,lv = lvlist,
	checkpoint = point,have =havetimes,used = usedtimes,progress = progressValue},9)
end--]]
-- ����Ԫ�����ͺ͵ȼ��������ֵ
local function get_attribute(atttype,lv,curtype,atttab)
	if(atttype == nil) then
		return
	end	
	local conftype = yuanshen_conf[curtype][3]
	if(conftype == nil) then
		return
	end	
	--��Ѫ���� INT(���e*10+���e^2)*5*�������
	if(atttype == 1) then
		atttab[atttype] = (lv*10 + lv^2)*5*conftype + (atttab[atttype] or 0)
	--���Թ��� NT(���e*10+���e^2)*�������	
    elseif(atttype == 2) then	
		atttab[atttype] = (lv*10 + lv^2)*conftype+ (atttab[atttype] or 0)	
	--��������� INT(���e*10+���e^2)*�������	
	elseif(atttype == 3 or atttype == 4) then
		atttab[atttype] = (lv*10 + lv^2)*conftype + (atttab[atttype] or 0)		
	--���Է���  INT(���e*10+���e^2*1.5)*�������	
	elseif(atttype == 10 or atttype  == 11 or atttype ==12) then
		atttab[atttype] = rint((lv*10 + lv^2*1.5)*conftype) + (atttab[atttype] or 0)
	end
	return 	atttab
end
--�������� init 1��ʾ��ʼ����0��ʾ�ǳ�ʼ��
function yuanshen_attribute(playerid,init)
	local atttab=GetRWData(1)
	local data=yuanshen_getdata(playerid)
	--����ʲô���Դ����ñ��ȡ
	for curtype = 1,10 do
		local lv = data.lv[curtype]
		local attr_first = yuanshen_conf[curtype][1][1]
		local attr_second = yuanshen_conf[curtype][1][2]
		local attr_third = yuanshen_conf[curtype][1][3]
		get_attribute(attr_first,lv,curtype,atttab)
		get_attribute(attr_second,lv,curtype,atttab)
		get_attribute(attr_third,lv,curtype,atttab)
	end
	if(init == 0) then
		PI_UpdateScriptAtt(playerid,ScriptAttType.yuanshen)
	end	
	return true
end
--Ԫ������ģ��
--curtype Ԫ������ 
local function  temp_yuanshen_up(playerid,curtype)
	if(playerid == nil or curtype == nil) then
		return 0
	end		
	-- ��ö�ӦԪ��ĵȼ�
	local data = yuanshen_getdata(playerid)
	local lv = data.lv[curtype]
	local conftype = yuanshen_conf[curtype][3]
	--�������ĵ���Ʒ���� �δ����� = INT(���e/3+2)*�������
	local num = rint(lv/3 + 2 )*conftype
	local itemId = yuanshen_conf.cost_id --���ñ��ȡ
	if(data.lv[curtype] >= yuanshen_conf.ysmaxlv) then
		return 0
	end
	if(CheckGoods(itemId, num,0,playerid,'Ԫ��������Ʒ') == 0) then
		return 0
	end	
	--������ ÿ���M�� = INT(���e^2/6+2)*�������^2
	local progress = (rint(lv^2/6 + 2))*conftype^2
	--����
	if(data.progress[curtype] + num >= progress) then
		data.progress[curtype] = data.progress[curtype] + num - progress
		data.lv[curtype] = data.lv[curtype] + 1
		yuanshen_attribute(playerid,0)
	else
		data.progress[curtype] =  data.progress[curtype] + num	
	end

	return 1
end
-- ��ͨ����
function yuanshen_normal_up(playerid,curtype)
	if IsSpanServer() then return end
	local Ret = temp_yuanshen_up(playerid,curtype)
	local data = yuanshen_getdata(playerid)
	local lv = data.lv[curtype]
	local progress = rint(data.progress[curtype])
	SendLuaMsg(0,{ids=msg_yuanshen_up,sendtype   = curtype,sendlv   = lv,succ = Ret,sendprogress = progress},9)
end
--һ������
--�߻��������� ֻ������һ��
function yuanshen_allup(playerid, curtype, num)
	if IsSpanServer() then return end
	if(playerid == nil or curtype == nil or num == nil) then
		return 0
	end		

	-- ��ö�ӦԪ��ĵȼ�
	local data = yuanshen_getdata(playerid)
	local lv = data.lv[curtype]
	local isSucc = 1--�Ƿ�һ�������ɹ�
	local nextlv = lv + 1
	if(data.lv[curtype] == nil or data.lv[curtype] >= yuanshen_conf.ysmaxlv) then
		return
	end	
	
	local conftype = yuanshen_conf[curtype][3]
	--ÿ�����ĵ���Ʒ���� �δ����� = INT(���e/3+2)*�������
	local every_num = rint(lv/3 + 2 )*conftype		
	
	if every_num >  num then 
		return 
	end
	
	local itemId = yuanshen_conf.cost_id --���ñ��ȡ
	--������ ÿ���M�� = INT(���e^2/6+2)*�������^2
	local need_pro = (rint(lv^2/6 + 2))*conftype^2
	local cur_pro = rint(data.progress[curtype])
	--������һ�� ��Ҫ����ITEM һ������һ������
	local need_num = (need_pro - cur_pro) ; 
	--������Ʒ����
	if need_num > num then
		if(CheckGoods(itemId, num, 0, playerid,'Ԫ��������Ʒ') == 0) then
			return 0
		end	
		data.progress[curtype] =  data.progress[curtype] + num	
	else 
		--���е����� �㹻��һ��
		if(CheckGoods(itemId, need_num, 0, playerid,'Ԫ��������Ʒ') == 0) then
			return 0
		end	
		data.progress[curtype] =  data.progress[curtype] + need_num - need_pro
		data.lv[curtype] = data.lv[curtype] + 1
		yuanshen_attribute(playerid,0)
	end

	--[[
	while(data.lv[curtype] < nextlv and data.lv[curtype] < 100) do
		local Ret = temp_yuanshen_up(playerid,curtype)
		if(Ret == 0) then
			break
		else
			isSucc = 1		
		end	
	end	
	--]]
	
	--������Ϣ
	local lvValue = data.lv[curtype]
	local progress = rint(data.progress[curtype])
	SendLuaMsg(0,{ids=msg_yuanshen_all_up,sendtype   = curtype,succ = isSucc,sendlv   = lvValue,sendprogress = progress},9)
	
end

--�������ػ�ý��� c_type 0��ʾɨ����1��ʾ��ս
function yuanshen_getaward(playerid,curtype,c_type)
	-- ��ý���
	local data = yuanshen_getdata(playerid)
	local cursize = #yuanshen_conf[curtype][2]
	local itemid
	local itemnum
	local isbind
	for i = 1,cursize do 
		itemid = yuanshen_conf[curtype][2][i][1] --��Ʒid
		itemnum = yuanshen_conf[curtype][2][i][2] --��Ʒ����
		isbind = yuanshen_conf[curtype][2][i][3] --�Ƿ��
		if(itemid == nil or itemnum == nil or isbind == nil) then
			return 
		end	
		--GiveGoods(itemid,itemnum,isbind,'����Ԫ�񸱱������Ʒ')
	end
	if(c_type == 1) then 
		--�����ۼ�ʹ�ô���
		data.lv[curtype] = data.lv[curtype]  + 1     --�����һ�����Ҳ�������Ʒ
		yuanshen_attribute(playerid,0)
		data.usetimes[curtype] = data.usetimes[curtype] + 1	
		data.gettimes[curtype]  = data.gettimes[curtype] -1
		SendLuaMsg(0,{ids=msg_yuanshen_suc,ctype = curtype,succ = 1},9)
	else
		
		GiveGoods(itemid,itemnum,isbind,'����Ԫ�񸱱������Ʒ')	
	end
end
--��������ģ��
--����1��ʾ���id 2��ʾ���� 3��ʾ�Ƿ���ս 0��ʾ���ǣ�1��ʾ��
--����ֵ0��ʾ����ʧ�ܣ� 1��ʾ����ɹ�
local function temp_challenge(playerid,curtype,ctype)
	local vipLv = __G.GI_GetVIPLevel(playerid)
	local conf_times = yuanshen_conf.times[vipLv] --���ô���
	if(conf_times == nil) then
		return 0
	end	
	local data = yuanshen_getdata(playerid)
	local usetimes = data.usetimes[curtype] --ʹ�õĴ���
	local gettimes = data.gettimes[curtype] --��õĴ���
	if(gettimes <= 0 ) then
		return 0
	end	
	--�����ۼ�ʹ�ô���
	if(ctype == 0 ) then
		data.usetimes[curtype] = data.usetimes[curtype] + 1	
		data.gettimes[curtype]  = data.gettimes[curtype] -1
	end	
	return 1
end
--������ս
function normal_challenge(playerid,curtype)
	--�ܷ���ս
	local data = yuanshen_getdata(playerid)
	if(curtype ~= data.checkpoint + 1) then
		return
	end	
	local Ret = temp_challenge(playerid,curtype,1)
	--���߿ͷ����Ƿ���Խ���
	SendLuaMsg(0,{ids=msg_yuanshen_normal_challenge,ctype = curtype,succ = Ret},9)
	if(Ret == 1) then
		local curvalue = 17000 + curtype 
		CS_RequestEnter(playerid,curvalue)
	end
end
--����ɨ��
function one_challenge(playerid,curtype)
	local pakagenum = isFullNum()
	if(pakagenum < 1) then
		TipCenter(GetStringMsg(14,1))
		return
	end	
	local Ret = temp_challenge(playerid,curtype,0)
	if(Ret == 1) then
		yuanshen_getaward(playerid,curtype,0)
	end	
	SendLuaMsg(0,{ids=msg_yuanshen_one_challenge,ctype = curtype,succ = Ret},9)
end

local function all_challenge_type(playerid,curtype)
	local data = yuanshen_getdata(playerid)
	local gettimes = data.gettimes[curtype] --��õĴ���
	while(gettimes > 0) do
		temp_challenge(playerid,curtype,0)
		gettimes = gettimes -1
		yuanshen_getaward(playerid,curtype,0)
	end
end
--һ��ɨ��
function all_challenge(playerid)
	local pakagenum = isFullNum()
	if(pakagenum < 1) then
		TipCenter(GetStringMsg(14,1))
		return
	end	
	local data = yuanshen_getdata(playerid)
	local msg = {}
	local check = data.checkpoint
	for ctype = 1,check do
		all_challenge_type(playerid,ctype)
		local value = data.usetimes[ctype]
		table_insert(msg,value)
		--yuanshen_getaward(playerid,ctype,0)			
	end
	--�ж�һ��ɨ���Ƿ�ɹ�
	local allRet
	if(#msg == 0) then
		allRet = 0
	else
		allRet = 1
	end	
	SendLuaMsg(0,{ids=msg_yuanshen_all_challenge,succ = allRet,list = msg},9)
end
--��������  
function yuanshen_buytimes(playerid,curtype)
	local vipLv = __G.GI_GetVIPLevel(playerid)
	local conf_times = yuanshen_conf.times[vipLv]
	local no_cost_times = 1 ---��Ѵ���
	if(conf_times == nil) then 
		return 
	end	
	local data = yuanshen_getdata(playerid)
	local curtimes = data.gettimes[curtype] + data.usetimes[curtype]
	local buytimes = data.gettimes[curtype] + data.usetimes[curtype] - 1
	if( buytimes > conf_times ) then
		return
	end	
	local cost_yb = 20*curtimes 
	if not CheckCost(playerid, cost_yb,0,1,'Ԫ�񸱱�����') then
		return  0
	end	
	data.gettimes[curtype] = data.gettimes[curtype] + 1
	
	SendLuaMsg(0,{ids=msg_yuanshen_buytimes,ctype = curtype,have = data.gettimes[curtype],used = data.usetimes[curtype]},9)
	
end


--�����������--------------------�����ƶ��������ļ���

--������
function sl_getpdata( playerid )
	local pdata=GI_GetPlayerData( playerid , 'sl' , 50 )
		--[[
			[3]=��ǰ��
		]]
	return pdata
end

--�ж���ҿ��Դ򱾹ز� index=����
local function sl_canplay( playerid,index )
	local pdata=sl_getpdata( playerid )
	if  pdata==nil then return end
	local nowlv=pdata[3] or 0
	if index~=nowlv+1 then 
		return 
	end
	return true
end
--ȡ����Ƿ��д���ͨ������
local function sl_canplayeasy(index)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return  --��᲻����
	end
	local fcdata=GetFactionData(fid) --�������
	fcdata.slmax=fcdata.slmax or {}
	local nowmaxlv=fcdata.slmax[1] or 0
	if nowmaxlv>=index then 
		return true
	end
	return false
end
--������ɴ���--���˽���,���Ѹ���������,itype=1����ģʽ
function sl_fbsucc(playerid,fbID,itype)
	look('������ɴ���')
	local mainid,index = GetSubID(fbID)
	local pdata=sl_getpdata( playerid )
	if  pdata==nil then return end
	local nowlv=pdata[3] or 0
	if index>nowlv then
		pdata[3]=nowlv+1
		RPC('sl_succ',pdata[3])
	end
	if itype~=1 then return end
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return  --��᲻����
	end
	local fcdata=GetFactionData(fid) --�������
	fcdata.slmax=fcdata.slmax or {}
	local nowmaxlv=fcdata.slmax[1] or 0
	look(nowmaxlv)
	look(index)
	if index>nowmaxlv then 
		local name=CI_GetPlayerData(3)
		local school=CI_GetPlayerData(2)
		local sex=CI_GetPlayerData(11)
		local head=CI_GetPlayerData(70)
		fcdata.slmax[1] =index
		fcdata.slmax[2] =name
		fcdata.slmax[3] =sex
		fcdata.slmax[4] =head
		fcdata.slmax[5] =playerid
		FactionRPC( fid, 'sl_max',fcdata.slmax[1],name,sex,head,playerid)
	end
end
--����������ս
function sl_challenge(playerid,fbID)
	--look(fbID,1)
	local rx, ry, rid, mapGID = CI_GetCurPos(2,playerid)
	if mapGID then 
		TipCenter(GetStringMsg(17))
		return 
	end
	local jointime= __G.get_join_factiontime(playerid)
	if jointime==nil or GetServerTime()-jointime<24*3600 then 
		return 
	end
	if fbID<19000 or fbID>20000 then return end
	local mainid,index = GetSubID(fbID)
	--�ܷ���ս
	local canplay=sl_canplay( playerid,index )
	if  not canplay then return end
	--���˴��û
	local canplayeasy=sl_canplayeasy(index)
	if canplayeasy then 
		fbID=20000+index
	end
	CS_RequestEnter(playerid,fbID)
end
--���ÿ������
function sl_fbreset( playerid )
	local pdata=sl_getpdata( playerid )
	if  pdata==nil then return end
	pdata[3]=nil
end








