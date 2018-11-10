--[[
file:	yuanshen_ls_func.lua
desc:	元神系统_炼神
author:	ct
update:	2014-6-16
refix:	done by dzq
]]--
--消息定义
local msgh_s2c_def	 = msgh_s2c_def
local msg_lianshen_up = msgh_s2c_def[45][10] --炼神 升级
local msg_lianshen_all_Up = msgh_s2c_def[45][11] --炼神 一键升级
local SendLuaMsg = SendLuaMsg
local GI_GetPlayerData = GI_GetPlayerData 
local rank = rank --炼神类型
local conf=require("Script.yuanshen.lianshen_conf")
local lianshen_conf=conf.lianshen_conf
local IsSpanServer = IsSpanServer
--curtype  七星 类型
--playerid  玩家ID
--获取 炼神 每颗星的等级  
--获取玩家炼神等级
local function ls_getlianshendata(playerid)
	local data = GI_GetPlayerData(playerid,"sl",20)
	--[[
		[1]=122 --等级
		[2]=15  --进度
		[3]=3534 --副本进度
	
	]]
--	data[1]=1
--	look("ls_getlianshendata  data:")
--	look(data[1])
	return data
end

local function getrankdata(rdata)

	local genre      --表示星的类型
	local rankd      --表示星的等级
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
--属性加成
function ls_attup(playerid,itype)
	local data=ls_getlianshendata(playerid)
	
	local lv = 0 --星的等级
	local att_type = lianshen_conf[1]
	local att_value= lianshen_conf[2]
	local AttTable =GetRWData(1)
	local curtype,rankd=getrankdata(data[1])--类型，等级
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


-- debris     --星辰碎片数
--炼神普通升级
function lianshen_normal_up(playerid)
	if IsSpanServer() then return end
	local curtype   --七星 类型
	local rankd     --七星 等级
	local progress   --进度
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
	

	if CheckGoods(803,debris,0,playerid,"炼神普通升级")==0 then               
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


--炼神一键升级     num 表示 包裹里面的 碎片数量
function lianshen_all_up(playerid,num)
    if IsSpanServer() then return end
	local curtype   --七星 类型
	local rankd     --七星 等级
	local progress   --进度
	local debris
	local progress_num   --当前进度需要的 碎片数量
	local remain    -- 表示 扣除 升级 需要的 碎片  剩余数
	local data = ls_getlianshendata(playerid)

	--获取星辰碎片
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
		if CheckGoods(803,remain,0,playerid,"炼神一键升级")==0 then
			SendLuaMsg(0,{ids=msg_lianshen_all_Up,lv = data[1],step= data[2]},9)
			return
		end
		data[2] = data[2] + rint(num/debris)
	elseif num >= progress_num then
		if CheckGoods(803,progress_num,0,playerid,"炼神一键升级")==0 then
			SendLuaMsg(0,{ids=msg_lianshen_all_Up,lv = data[1],step= data[2]},9)
			return
		end
	
		data[1] = data[1] +1
		data[2] = 0
		ls_attup(playerid,1)
	end

	SendLuaMsg(0,{ids=msg_lianshen_all_Up,lv = data[1],step= data[2]},9)
end