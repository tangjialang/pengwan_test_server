 --[[
file:	fabao_fun.lua
desc:	本命法宝
author:	ct
update:	2014-8-06
]]--
--定义消息
local msgh_s2c_def	    = msgh_s2c_def
local msg_fabao         = msgh_s2c_def[53][1]
local msg_hunshi        = msgh_s2c_def[53][2]
local msg_xiezai        = msgh_s2c_def[53][3]
local msg_jihuo         = msgh_s2c_def[53][11]

--配置表引用
local conf   = require("Script.fabao.fabao_conf")
local fabao_conf  =  conf.Fabao_conf
local hunshi_conf = conf.Hunshi_conf
local baoshi_conf = conf.Baoshi_conf
local xing_conf   = conf.Xing_conf
local hunshi      =conf.Huns_conf

--外部函数引用
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

--定义用户数据 申请空间
local function fb_getfabaodata(playerid)
	local data = GI_GetPlayerData(playerid,'fb',180)  --空间可能不够
		 --[[data={
                    [1] =  {[1]={等级,进度},[2]={魂石ID,魂石ID,魂石ID}} 摄魂铃
                    [2] =  {[1]={等级,进度},[2]={魂石ID,魂石ID,魂石ID}} 九龙神火罩 
                    [3] =  {[1]={等级,进度},[2]={魂石ID,魂石ID,魂石ID}} 太极图
                    [4] =  {[1]={等级,进度},[2]={魂石ID,魂石ID,魂石ID}} 阴阳镜
                    [5] =  {[1]={等级,进度},[2]={魂石ID,魂石ID,魂石ID}} 番天印
                    [6] =  {[1]={等级,进度},[2]={魂石ID,魂石ID,魂石ID}} 诛仙剑          
            }]]
	return data
end

--本命法宝升星 加属性
local function _fb_attup(playerid,itype)
    local data= fb_getfabaodata(playerid)
	if nil == data then  return 	end
    if #data <=0   then return  end
	--获取配置表
    local att_type  
    local att_value
    local att_value2 
    local att_type1 =  hunshi_conf   
    local att_value1 = baoshi_conf   
	local AttTable =GetRWData(1)
	local lv = 0 --星的等级
    for i=1,#data do
        --获取法宝等级
	    lv = data[i][1][1]
        --获取法宝配置
	    for k,v in pairs(fabao_conf[1][i]) do
		    att_value= fabao_conf[2][v]
		    AttTable[v]=(AttTable[v] or 0)+rint(lv*50+lv^2)*att_value[1]
	    end
        --获取魂石的id
        local data_hs = data[i][2]
        for i =1,3 do 
            if data_hs[i] ~= nil and data_hs[i] > 1520 then
                lv = att_type1[data_hs[i]][1]
                --获取魂石配置
                for k1,v1 in pairs(att_type1[data_hs[i]][2]) do
                    att_value2 = baoshi_conf[lv][v1][1]
                    AttTable[v1]=(AttTable[v1] or 0) + att_value2
               end
               --减去相应属性
            elseif nil == data_hs[i] then
                 for k1,v1 in pairs(hunshi[i]) do 
                     AttTable[v1] = (AttTable[v1] or 0) +0
                 end
            end
        end
    end 
	if itype == 1 then
        --添加属性
		__G.PI_UpdateScriptAtt(playerid,__G.ScriptAttType.fabao)
	end
	return true
end
--本命法宝升星
--goods_num 表示哪一个道具
    -- 1:摄魂铃;2:九龙神火罩 ;3:太极图 ;4:阴阳镜;5:番天印;6:诛仙剑
--itype 等于1 表示升星  等于2 表示一键升星
local function _fabao_update (playerid,goods_num,bts_num,itype) 
    --参数判断
    if goods_num < 1 or goods_num > 6 then return end
    --判断玩家补天石的个数是否满足条件
    if  nil == bts_num or bts_num <= 0 then return end  
    --玩家数据判断
    local data = fb_getfabaodata(playerid)
    if nil == data then return end
    --法宝没有激活退出
    if nil == data[goods_num] then return end
    --法宝等级达到最高级无法升级
    if data[goods_num][1][1] >= MaxLevel then
        return 
    end
    --获取用户等级
    local user_grade = CI_GetPlayerData(1)   
    --小于75 级  不满足需求无法升级 退出
    if user_grade < 75 then return end
    --获取玩家法宝等级
    local data_bm = data[goods_num][1]
     --升级需要的进度	INT((等级+1)/10)*5+10  
    local progress = rint((data_bm[1]+1)/10)*5 + 10
    --单次消耗数量 	INT((等级+1)*1.5)  
    local expend = rint((data_bm[1]+1)*1.5)
    --一键升星
    if 2 == itype then
        --计算玩家离升星还需要多少进度
        local data_jd =  progress - data_bm[2]
        local fabao_jd = rint(bts_num/expend)
        --判断一键升级 
        if fabao_jd >= data_jd then
           --升到星
           expend = expend*data_jd
        elseif fabao_jd < data_jd then
            --有多少道具升多少点
            expend = expend*fabao_jd
            data_jd =  fabao_jd
        end
        if CheckGoods(1520,expend,1,playerid,"本命法宝升星") ~= 1  then
		    SendLuaMsg(0,{ids=msg_fabao,lv = data_bm[1],step= data_bm[2],djid=goods_num},9)
		    return 
	    end
        data_bm[2] = data_bm[2] +data_jd
    --升星
    elseif 1 == itype then
        if CheckGoods(1520,expend,1,playerid,"本命法宝升星") ~= 1  then
		    SendLuaMsg(0,{ids=msg_fabao,lv = data_bm[1],step= data_bm[2],djid=goods_num},9)
		    return 
	    end
        data_bm[2] = data_bm[2]+1
    end
    CheckGoods(1520,expend,0,playerid,"本命法宝升星")

     --进度满   升级  进度归零
    if data_bm[2] >= progress then
		data_bm[1] = data_bm[1] +1
		data_bm[2] =0
		--升级加属性
		_fb_attup(playerid,1)		
	end	
	SendLuaMsg(0,{ids=msg_fabao,lv = data[goods_num][1][1],step= data[goods_num][1][2],djid=goods_num},9)	
end

--魂石镶嵌
    --goods_id :商品ID
    --goods_num:法宝编号  1:摄魂铃;2:九龙神火罩 ;3:太极图 ;4:阴阳镜;5:番天印;6:诛仙剑
    --bianhao    :宝石编号  1,2,3
--道具不足 返回-1
--已经镶嵌相同类型 返回-2
local function _hunshi_xiangqian(playerid,goods_num,goods_id,bianhao)
    --判断玩家数据
    local data= fb_getfabaodata(playerid)
	if nil == data then return 	end
    if nil == goods_id then return end
    if goods_num < 1 or goods_num > 6 then return end
    --判断法宝道具有没有激活
    if nil == data[goods_num] then return  end
    --获取玩家魂石数据
    local data_hs = data[goods_num]
    --look(data_hs[2])
    --判断有没有空的位置镶嵌魂石 和重复的魂石
    --判断是否镶嵌过
    local data_hshi
    data_hs[2] = data_hs[2] or {}
    --如果镶嵌了三个 就不再镶嵌了
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
    --法宝等级不足不能镶嵌
    if data_hs[1][1] < 1 then return end
    if rint(data_hs[1][1]/10)+1 <  hunshi_conf[goods_id][1] then return end
    data_hshi = data_hs[2]
    --类型重复的不能镶嵌
    if goods_id>= 1521 and goods_id <=1530 then
        --攻击魂石
        if nil == data_hshi[1] then 
            data_hshi[1]  = goods_id
        elseif nil ~= data_hshi[1] then
            SendLuaMsg(0,{ids=msg_hunshi,bsid = goods_id,bshi=1,bh=bianhao,val = 2,fbbh = goods_num},9)
            return  -2    
        end
    --属性魂石
    elseif goods_id>= 1536 and goods_id <=1545  then
        if nil == data_hshi[2] then 
            data_hshi[2]  = goods_id      
        elseif nil ~= data_hshi[2] then
            SendLuaMsg(0,{ids=msg_hunshi,bsid = goods_id,bshi=1,bh=bianhao,val = 2,fbbh = goods_num},9)
            return -2
        end
    --减免魂石
    elseif goods_id>= 1551 and goods_id <=1560 then
        if nil == data_hshi[3] then 
            data_hshi[3] = goods_id
        elseif nil ~= data_hshi[3] then
            SendLuaMsg(0,{ids=msg_hunshi,bsid = goods_id,bshi=1,bh=bianhao,val = 2,fbbh = goods_num},9)
            return  -2     
        end   
    end
	local data_bm = data_hs[1]
    --添加属性
    _fb_attup(playerid,1)
    --扣除宝石
    if CheckGoods(goods_id,1,1,playerid,"魂石扣除") ~= 1  then
	    SendLuaMsg(0,{ids=msg_fabao,lv = data_bm[1],step= data_bm[2],djid=goods_num},9)
	    return -1
    end
    CheckGoods(goods_id,1,0,playerid,"魂石扣除")
    SendLuaMsg(0,{ids=msg_hunshi,bsid = goods_id,bshi=1,bh=bianhao,val = 1,fbbh = goods_num },9)	
end

--魂石卸载
local function _hunshi_xiezai(playerid,goods_num,goods_id,bianhao)
     --判断玩家数据
    local data= fb_getfabaodata(playerid)
	if nil == data then return 	end
    if nil == goods_id then return end
    if bianhao<1 or bianhao > 3 then return end
    if goods_num < 1 or goods_num > 6 then return end
    local data_hs = data[goods_num][2]
    --如果魂石数据为空不操作
    if nil == data_hs then return end
    if nil == data_hs[bianhao]  then return end
    data_hs[bianhao] = nil
    --look(data[goods_num][2])
    --添加属性
    _fb_attup(playerid,1)
    --判断背包是否有剩余位置
	local snum = isFullNum()
    if snum< 1 then return 	end
    GiveGoods(goods_id,1,1,"魂石卸载")
    SendLuaMsg(0,{ids=msg_xiezai,bsid = goods_id,bshi=2,bh=bianhao,fbbh = goods_num},9)	
end


--法宝激活
    -- playerid:玩家ID 
        --返回 -1 用户数据错误
        --返回 -2 法宝编号出错
        --返回 -3 法宝已经开启 不可重复开启
        --返回 -4 表示开启的星不够 
        --返回 >=1  表示成功开启法宝
        --返回 -5 表示等级不足
    -- xing :表示当前多少星
local function _fb_activated (playerid,xing)
    local data= fb_getfabaodata(playerid)
    if nil == data then return -1 end
    local user_grade = CI_GetPlayerData(1,2,playerid)   --获取指定用户的等级
    --小于75 级  不满足需求无法升级 退出
    if user_grade < 75 then  return -5  end
    --星不够无法开启
    for i =1,6 do
        if  xing >= xing_conf[i] then
        --初始化
            if nil == data[i] then
                data[i]={[1]={0,0},[2]={}}
            end
        --星不满足的时候退出
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
