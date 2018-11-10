--[[
file:	yuanshen_ls_func.lua
desc:	Ԫ��ϵͳ_����
author:	ct
update:	2014-6-16
refix:	done by dzq
]]--
--��Ϣ����
local msgh_s2c_def	 = msgh_s2c_def
local msg_lianshen_up = msgh_s2c_def[45][10] --���� ����
local msg_lianshen_all_Up = msgh_s2c_def[45][11] --���� һ������
local SendLuaMsg = SendLuaMsg
local GI_GetPlayerData = GI_GetPlayerData 
local rank = rank --��������
local conf=require("Script.yuanshen.lianshen_conf")
local lianshen_conf=conf.lianshen_conf
local IsSpanServer = IsSpanServer
--curtype  ���� ����
--playerid  ���ID
--��ȡ ���� ÿ���ǵĵȼ�  
--��ȡ�������ȼ�
local function ls_getlianshendata(playerid)
	local data = GI_GetPlayerData(playerid,"sl",20)
	--[[
		[1]=122 --�ȼ�
		[2]=15  --����
		[3]=3534 --��������
	
	]]
--	data[1]=1
--	look("ls_getlianshendata  data:")
--	look(data[1])
	return data
end

local function getrankdata(rdata)

	local genre      --��ʾ�ǵ�����
	local rankd      --��ʾ�ǵĵȼ�
	if rdata == nil then
		return 
	end
	
	rankd=rint(rdata/7)
	genre=rdata%7
	
	if rdata >= 7 then
		if genre==0  then
			genre =7 		
		end
	end
	if rdata%7 == 0 then
		rankd = rankd
	else
		rankd=rankd+1
	end

	return genre,rankd
end
--���Լӳ�
function ls_attup(playerid,itype)
	local data=ls_getlianshendata(playerid)
	
	local lv = 0 --�ǵĵȼ�
	local att_type = lianshen_conf[1]
	local att_value= lianshen_conf[2]
	local AttTable =GetRWData(1)
	local curtype,rankd=getrankdata(data[1])--���ͣ��ȼ�
	if nil == curtype then
		return
	end

	for i=1,7 do
		if i<= curtype then
			lv=rankd
		else
			lv=rankd-1
		end
		
		att_type= lianshen_conf[1][i]
		
		for k,v in pairs(att_type) do
			att_value= lianshen_conf[2][v]
			AttTable[v]=(AttTable[v] or 0)+rint(lv*10+lv^2*att_value[1])*att_value[2]
		end
	end

	if itype==1 then 
		PI_UpdateScriptAtt(playerid,ScriptAttType.lianshen)
	end
	return true
end


-- debris     --�ǳ���Ƭ��
--������ͨ����
function lianshen_normal_up(playerid)
	if IsSpanServer() then return end
	local curtype   --���� ����
	local rankd     --���� �ȼ�
	local progress   --����
	local data = ls_getlianshendata(playerid)
	local debris

	if nil == data then
		return 	
	end
	if nil==data[1] then
		data[1]=0
	end
	if lianshen_conf.lsmaxlv ==data[1] then  
		SendLuaMsg(0,{ids=msg_lianshen_up,lv = data[1],step= data[2]},9)
		return
	end
	curtype,rankd = getrankdata(data[1])  

	if  curtype == 7 then
		debris = rint((rankd+1)/1.5)+1
	else
		debris = rint(rankd/1.5)+1
	end
	if debris <= 0  then
		return 
	end
	
	progress = rint((rankd/15))*5+10
	

	if CheckGoods(803,debris,0,playerid,"������ͨ����")==0 then               
		SendLuaMsg(0,{ids=msg_lianshen_up,lv = data[1],step= data[2]},9)
		return
	end
	
	
	data[2]=(data[2] or 0)+1
	if  progress<=data[2] then
		data[1]=data[1]+1
		data[2]=0
		ls_attup(playerid,1)
	end
	
	SendLuaMsg(0,{ids=msg_lianshen_up,lv = data[1],step= data[2]},9)
end


--����һ������     num ��ʾ ��������� ��Ƭ����
function lianshen_all_up(playerid,num)
    if IsSpanServer() then return end
	local curtype   --���� ����
	local rankd     --���� �ȼ�
	local progress   --����
	local debris
	local progress_num   --��ǰ������Ҫ�� ��Ƭ����
	local remain    -- ��ʾ �۳� ���� ��Ҫ�� ��Ƭ  ʣ����
	local data = ls_getlianshendata(playerid)

	--��ȡ�ǳ���Ƭ
	if nil == data then
		return 	
	end

	if nil==data[1] then
		data[1]=0
	end
	if lianshen_conf.lsmaxlv  <=data[1] then   
		SendLuaMsg(0,{ids=msg_lianshen_all_Up,lv = data[1],step= data[2]},9)
		return 
	end
	
	curtype,rankd = getrankdata(data[1])   

	if  curtype == 7 then
		debris = rint((rankd+1)/1.5)+1
	else
		debris = rint(rankd/1.5)+1
	end
	

	progress =rint( (rankd/15))*5+10
	data[2] = data[2] or 0
	progress_num= (progress - data[2])*debris
	if progress_num<=0 or num <= 0 then
		return
	end

	if num < progress_num then
		remain=rint(num/debris)*debris
		if remain <=0 then
			return
		end
		if CheckGoods(803,remain,0,playerid,"����һ������")==0 then
			SendLuaMsg(0,{ids=msg_lianshen_all_Up,lv = data[1],step= data[2]},9)
			return
		end
		data[2] = data[2] + rint(num/debris)
	elseif num >= progress_num then
		if CheckGoods(803,progress_num,0,playerid,"����һ������")==0 then
			SendLuaMsg(0,{ids=msg_lianshen_all_Up,lv = data[1],step= data[2]},9)
			return
		end
	
		data[1] = data[1] +1
		data[2] = 0
		ls_attup(playerid,1)
	end

	SendLuaMsg(0,{ids=msg_lianshen_all_Up,lv = data[1],step= data[2]},9)
end