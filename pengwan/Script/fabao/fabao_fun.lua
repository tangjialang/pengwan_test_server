 --[[
file:	fabao_fun.lua
desc:	��������
author:	ct
update:	2014-8-06
]]--
--������Ϣ
local msgh_s2c_def	    = msgh_s2c_def
local msg_fabao         = msgh_s2c_def[53][1]
local msg_hunshi        = msgh_s2c_def[53][2]
local msg_xiezai        = msgh_s2c_def[53][3]
local msg_jihuo         = msgh_s2c_def[53][11]

--���ñ�����
local conf   = require("Script.fabao.fabao_conf")
local fabao_conf  =  conf.Fabao_conf
local hunshi_conf = conf.Hunshi_conf
local baoshi_conf = conf.Baoshi_conf
local xing_conf   = conf.Xing_conf
local hunshi      =conf.Huns_conf

--�ⲿ��������
local type = type
local rint = rint
local pairs = pairs
local CI_GetPlayerData  = CI_GetPlayerData
local SendLuaMsg        = SendLuaMsg
local look              = look
local GI_GetPlayerData  = GI_GetPlayerData
local PI_UpdateScriptAtt = PI_UpdateScriptAtt
local GetRWData         = GetRWData
local PI_UpdateScriptAtt= PI_UpdateScriptAtt
local GetWorldCustomDB  = GetWorldCustomDB
local CheckGoods = CheckGoods
local GetItemNum = GetItemNum
local GiveGoods = GiveGoods
local isFullNum = isFullNum
local __G = _G

local MaxLevel = 300

module(...)

--�����û����� ����ռ�
local function fb_getfabaodata(playerid)
	local data = GI_GetPlayerData(playerid,'fb',180)  --�ռ���ܲ���
		 --[[data={
                    [1] =  {[1]={�ȼ�,����},[2]={��ʯID,��ʯID,��ʯID}} �����
                    [2] =  {[1]={�ȼ�,����},[2]={��ʯID,��ʯID,��ʯID}} ��������� 
                    [3] =  {[1]={�ȼ�,����},[2]={��ʯID,��ʯID,��ʯID}} ̫��ͼ
                    [4] =  {[1]={�ȼ�,����},[2]={��ʯID,��ʯID,��ʯID}} ������
                    [5] =  {[1]={�ȼ�,����},[2]={��ʯID,��ʯID,��ʯID}} ����ӡ
                    [6] =  {[1]={�ȼ�,����},[2]={��ʯID,��ʯID,��ʯID}} ���ɽ�          
            }]]
	return data
end

--������������ ������
local function _fb_attup(playerid,itype)
    local data= fb_getfabaodata(playerid)
	if nil == data then  return 	end
    if #data <=0   then return  end
	--��ȡ���ñ�
    local att_type  
    local att_value
    local att_value2 
    local att_type1 =  hunshi_conf   
    local att_value1 = baoshi_conf   
	local AttTable =GetRWData(1)
	local lv = 0 --�ǵĵȼ�
    for i=1,#data do
        --��ȡ�����ȼ�
	    lv = data[i][1][1]
        --��ȡ��������
	    for k,v in pairs(fabao_conf[1][i]) do
		    att_value= fabao_conf[2][v]
		    AttTable[v]=(AttTable[v] or 0)+rint(lv*50+lv^2)*att_value[1]
	    end
        --��ȡ��ʯ��id
        local data_hs = data[i][2]
        for i =1,3 do 
            if data_hs[i] ~= nil and data_hs[i] > 1520 then
                lv = att_type1[data_hs[i]][1]
                --��ȡ��ʯ����
                for k1,v1 in pairs(att_type1[data_hs[i]][2]) do
                    att_value2 = baoshi_conf[lv][v1][1]
                    AttTable[v1]=(AttTable[v1] or 0) + att_value2
               end
               --��ȥ��Ӧ����
            elseif nil == data_hs[i] then
                 for k1,v1 in pairs(hunshi[i]) do 
                     AttTable[v1] = (AttTable[v1] or 0) +0
                 end
            end
        end
    end 
	if itype == 1 then
        --�������
		__G.PI_UpdateScriptAtt(playerid,__G.ScriptAttType.fabao)
	end
	return true
end
--������������
--goods_num ��ʾ��һ������
    -- 1:�����;2:��������� ;3:̫��ͼ ;4:������;5:����ӡ;6:���ɽ�
--itype ����1 ��ʾ����  ����2 ��ʾһ������
local function _fabao_update (playerid,goods_num,bts_num,itype) 
    --�����ж�
    if goods_num < 1 or goods_num > 6 then return end
    --�ж���Ҳ���ʯ�ĸ����Ƿ���������
    if  nil == bts_num or bts_num <= 0 then return end  
    --��������ж�
    local data = fb_getfabaodata(playerid)
    if nil == data then return end
    --����û�м����˳�
    if nil == data[goods_num] then return end
    --�����ȼ��ﵽ��߼��޷�����
    if data[goods_num][1][1] >= MaxLevel then
        return 
    end
    --��ȡ�û��ȼ�
    local user_grade = CI_GetPlayerData(1)   
    --С��75 ��  �����������޷����� �˳�
    if user_grade < 75 then return end
    --��ȡ��ҷ����ȼ�
    local data_bm = data[goods_num][1]
     --������Ҫ�Ľ���	INT((�ȼ�+1)/10)*5+10  
    local progress = rint((data_bm[1]+1)/10)*5 + 10
    --������������ 	INT((�ȼ�+1)*1.5)  
    local expend = rint((data_bm[1]+1)*1.5)
    --һ������
    if 2 == itype then
        --������������ǻ���Ҫ���ٽ���
        local data_jd =  progress - data_bm[2]
        local fabao_jd = rint(bts_num/expend)
        --�ж�һ������ 
        if fabao_jd >= data_jd then
           --������
           expend = expend*data_jd
        elseif fabao_jd < data_jd then
            --�ж��ٵ��������ٵ�
            expend = expend*fabao_jd
            data_jd =  fabao_jd
        end
        if CheckGoods(1520,expend,1,playerid,"������������") ~= 1  then
		    SendLuaMsg(0,{ids=msg_fabao,lv = data_bm[1],step= data_bm[2],djid=goods_num},9)
		    return 
	    end
        data_bm[2] = data_bm[2] +data_jd
    --����
    elseif 1 == itype then
        if CheckGoods(1520,expend,1,playerid,"������������") ~= 1  then
		    SendLuaMsg(0,{ids=msg_fabao,lv = data_bm[1],step= data_bm[2],djid=goods_num},9)
		    return 
	    end
        data_bm[2] = data_bm[2]+1
    end
    CheckGoods(1520,expend,0,playerid,"������������")

     --������   ����  ���ȹ���
    if data_bm[2] >= progress then
		data_bm[1] = data_bm[1] +1
		data_bm[2] =0
		--����������
		_fb_attup(playerid,1)		
	end	
	SendLuaMsg(0,{ids=msg_fabao,lv = data[goods_num][1][1],step= data[goods_num][1][2],djid=goods_num},9)	
end

--��ʯ��Ƕ
    --goods_id :��ƷID
    --goods_num:�������  1:�����;2:��������� ;3:̫��ͼ ;4:������;5:����ӡ;6:���ɽ�
    --bianhao    :��ʯ���  1,2,3
--���߲��� ����-1
--�Ѿ���Ƕ��ͬ���� ����-2
local function _hunshi_xiangqian(playerid,goods_num,goods_id,bianhao)
    --�ж��������
    local data= fb_getfabaodata(playerid)
	if nil == data then return 	end
    if nil == goods_id then return end
    if goods_num < 1 or goods_num > 6 then return end
    --�жϷ���������û�м���
    if nil == data[goods_num] then return  end
    --��ȡ��һ�ʯ����
    local data_hs = data[goods_num]
    --look(data_hs[2])
    --�ж���û�пյ�λ����Ƕ��ʯ ���ظ��Ļ�ʯ
    --�ж��Ƿ���Ƕ��
    local data_hshi
    data_hs[2] = data_hs[2] or {}
    --�����Ƕ������ �Ͳ�����Ƕ��
    local kk =0
    for key,val in pairs(data_hs[2]) do 
        if type(key) == type(0) then
            if nil == val then
                break
            else
                kk = kk +1
            end 
        end
    end
    if kk >=3 then return end
    --�����ȼ����㲻����Ƕ
    if data_hs[1][1] < 1 then return end
    if rint(data_hs[1][1]/10)+1 <  hunshi_conf[goods_id][1] then return end
    data_hshi = data_hs[2]
    --�����ظ��Ĳ�����Ƕ
    if goods_id>= 1521 and goods_id <=1530 then
        --������ʯ
        if nil == data_hshi[1] then 
            data_hshi[1]  = goods_id
        elseif nil ~= data_hshi[1] then
            SendLuaMsg(0,{ids=msg_hunshi,bsid = goods_id,bshi=1,bh=bianhao,val = 2,fbbh = goods_num},9)
            return  -2    
        end
    --���Ի�ʯ
    elseif goods_id>= 1536 and goods_id <=1545  then
        if nil == data_hshi[2] then 
            data_hshi[2]  = goods_id      
        elseif nil ~= data_hshi[2] then
            SendLuaMsg(0,{ids=msg_hunshi,bsid = goods_id,bshi=1,bh=bianhao,val = 2,fbbh = goods_num},9)
            return -2
        end
    --�����ʯ
    elseif goods_id>= 1551 and goods_id <=1560 then
        if nil == data_hshi[3] then 
            data_hshi[3] = goods_id
        elseif nil ~= data_hshi[3] then
            SendLuaMsg(0,{ids=msg_hunshi,bsid = goods_id,bshi=1,bh=bianhao,val = 2,fbbh = goods_num},9)
            return  -2     
        end   
    end
	local data_bm = data_hs[1]
    --�������
    _fb_attup(playerid,1)
    --�۳���ʯ
    if CheckGoods(goods_id,1,1,playerid,"��ʯ�۳�") ~= 1  then
	    SendLuaMsg(0,{ids=msg_fabao,lv = data_bm[1],step= data_bm[2],djid=goods_num},9)
	    return -1
    end
    CheckGoods(goods_id,1,0,playerid,"��ʯ�۳�")
    SendLuaMsg(0,{ids=msg_hunshi,bsid = goods_id,bshi=1,bh=bianhao,val = 1,fbbh = goods_num },9)	
end

--��ʯж��
local function _hunshi_xiezai(playerid,goods_num,goods_id,bianhao)
     --�ж��������
    local data= fb_getfabaodata(playerid)
	if nil == data then return 	end
    if nil == goods_id then return end
    if bianhao<1 or bianhao > 3 then return end
    if goods_num < 1 or goods_num > 6 then return end
    local data_hs = data[goods_num][2]
    --�����ʯ����Ϊ�ղ�����
    if nil == data_hs then return end
    if nil == data_hs[bianhao]  then return end
    data_hs[bianhao] = nil
    --look(data[goods_num][2])
    --�������
    _fb_attup(playerid,1)
    --�жϱ����Ƿ���ʣ��λ��
	local snum = isFullNum()
    if snum< 1 then return 	end
    GiveGoods(goods_id,1,1,"��ʯж��")
    SendLuaMsg(0,{ids=msg_xiezai,bsid = goods_id,bshi=2,bh=bianhao,fbbh = goods_num},9)	
end


--��������
    -- playerid:���ID 
        --���� -1 �û����ݴ���
        --���� -2 ������ų���
        --���� -3 �����Ѿ����� �����ظ�����
        --���� -4 ��ʾ�������ǲ��� 
        --���� >=1  ��ʾ�ɹ���������
        --���� -5 ��ʾ�ȼ�����
    -- xing :��ʾ��ǰ������
local function _fb_activated (playerid,xing)
    local data= fb_getfabaodata(playerid)
    if nil == data then return -1 end
    local user_grade = CI_GetPlayerData(1,2,playerid)   --��ȡָ���û��ĵȼ�
    --С��75 ��  �����������޷����� �˳�
    if user_grade < 75 then  return -5  end
    --�ǲ����޷�����
    for i =1,6 do
        if  xing >= xing_conf[i] then
        --��ʼ��
            if nil == data[i] then
                data[i]={[1]={0,0},[2]={}}
            end
        --�ǲ������ʱ���˳�
        elseif xing < xing_conf[i] then
            SendLuaMsg(0,{ids=msg_jihuo,data = data[i]},9)
            return i
        end
    end 
    return -4
    
end
fabao_update    = _fabao_update
hunshi_xiangqian = _hunshi_xiangqian
fb_attup         = _fb_attup
hunshi_xiezai    = _hunshi_xiezai
fb_activated     = _fb_activated
--mianban_chushi   =_mianban_chushi
--fbmianban_chushi = _fbmianban_chushi
