--[[
	file:	山庄装饰系统
	author:	wk
	update:	2013-3-6
	refix:	done by wk
--]]
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local storeend	 = msgh_s2c_def[24][2]
local ZS_start	 = msgh_s2c_def[31][1]
local ZS_set	 = msgh_s2c_def[31][2]
local ZS_buy	 = msgh_s2c_def[31][3]
local ZS_cancel	 = msgh_s2c_def[31][4]
local look = look
local GI_GetPlayerData=GI_GetPlayerData
local GetServerTime=GetServerTime
local _remove=table.remove
local _insert=table.insert


--价格1元宝，价格2绑定元宝，持续时间(天)，家园经验
local uv_Garniture_conf=Store_List[12]
local mapidconf=mapidconf--山庄地图配置
local uv_moneytree_conf=moneytree_conf--山庄摇钱树配置
local pairs,type,tostring =pairs,type,tostring
--定义山庄装饰数据
local function GetDBGarnitureData( playerid )
	local GarnitureData=GI_GetPlayerData( playerid , 'garn' , 300 )
	if GarnitureData == nil then return end
	--if GarnitureData.used==nil then
		-- GarnitureData[1]={}--背景{{id,time}...}
		-- GarnitureData[2]={}--摇钱树
		-- GarnitureData[3]={}--宠物
		-- GarnitureData[4]={}--天空
		-- GarnitureData.used={}--启用{[1]=1,[2]=2,[3]={1,2,3},}
	--end
	--look(tostring(GarnitureData))
	--look(GarnitureData)
	return GarnitureData
end
--每日重置时判断过期
local function Garniture_refresh(playerid)
	if playerid==nil  or playerid==0 then return end 
	local garniture_data=GetDBGarnitureData( playerid )
	if garniture_data == nil or type(garniture_data.used) ~= type({}) then 
		return
	end
	for i=1 ,4 do 
		for k,v in pairs (garniture_data[i]) do
			if type(k)==type(0) and type(v)==type({}) then
				if GetServerTime()-v[2]>=0 then
					if i==3 then
						if type(garniture_data.used[i]) ==type({}) then
							for h, j in pairs (garniture_data.used[i]) do
								if j==v[1] then
									_remove(garniture_data.used[i],h)
								end
							end
						end
					else
						if garniture_data.used[i]==v[1] then
							garniture_data.used[i]=nil
						end
					end
				end
				if GetServerTime()-v[2]-7*24*3600>=0 then
					_remove(garniture_data[i],k)
				end
			end
		end
	end
end
--初始化
local function Garniture_start(playerid)
	if playerid==nil then return end
	local garniture_data=GetDBGarnitureData( playerid )
	if garniture_data==nil then return end
	for i=1 ,4 do 
		for k,v in pairs (garniture_data[i]) do
			if type(k)==type(0) and type(v)==type({}) then
				if GetServerTime()-v[2]>=0 then
					v[3]=nil
				end
				if GetServerTime()-v[2]-7*24*3600>=0 then
					_remove(garniture_data[i],k)
				end
			end
		end
	end
	SendLuaMsg(0,{ids=ZS_start,data=GetDBGarnitureData( playerid )},9)
end
--进入山庄加载
function Garniture_interZY(playerid)
	local garniture_data=GetDBGarnitureData( playerid )
	if garniture_data==nil then return end
	garniture_data.used = garniture_data.used or {100,}
	return garniture_data.used
end
--取得庄园地图信息
function GetZY_mapinfo(playerid)
	local garniture_used=Garniture_interZY( playerid )
	if garniture_used==nil then return end
	local temp
	local num=garniture_used[1] or 100	
	if mapidconf[num] then
		temp=mapidconf[num]
		return temp,num
	end
end
--取庄园摇钱树信息
function GetZY_moneytreeinfo(playerid)
	local garniture_used=Garniture_interZY( playerid )
	if garniture_used==nil then return end
	local num=garniture_used[2] or 100	
	if uv_moneytree_conf[num] then
		return uv_moneytree_conf[num]
	end
end
--掠夺战需要信息
function Get_mapinfo(num)
	if mapidconf[num] then
		return mapidconf[num]
	end
end
--购买装饰
function Garniture_buy(playerid,tag,index,num,itemid)
	look('购买装饰')
	if playerid==nil or tag==nil or index==nil then return end
	local id=uv_Garniture_conf[tag][index][1]
	if itemid~=id then
		look('itemiderror')
		return
	end
	local needmongey=uv_Garniture_conf[tag][index][2]
	local addexp=uv_Garniture_conf[tag][index][4]
	local lasttime=uv_Garniture_conf[tag][index][5]
	local moneytype=uv_Garniture_conf[tag][index][3]
	if moneytype==2 then
		if not CheckCost( playerid , needmongey , 1 , 1, "山庄装饰") then
			SendLuaMsg(0,{ids=storeend,succ=1},9)
			return
		end
	elseif moneytype==1 then
		if not CheckCost( playerid , needmongey , 1 , 3, "山庄装饰") then
			SendLuaMsg(0,{ids=storeend,succ=3},9)
			return
		end
	else
		return
	end
	local garniture_data=GetDBGarnitureData( playerid )
	if garniture_data==nil then return end
	local mark=0
	if garniture_data[tag] then
		for k,v in pairs (garniture_data[tag]) do
			if type(k)==type(0) and type(v)==type({}) then
				if v[1]==id then
					if GetServerTime()-v[2]<0 then
						look("Garnituretime not over")
						return
					else
						v[2]=GetServerTime()+lasttime*24*3600
						mark=1
						break
					end
				end
			end
		end
	end
	if mark==0 then
		if garniture_data[tag] ==nil then
			garniture_data[tag]={} 
		end
		_insert(garniture_data[tag],{id,GetServerTime()+lasttime*24*3600})
	end
	if moneytype==2 then
		CheckCost( playerid , needmongey , 0 , 1, "100026_山庄装饰元宝") 
	elseif moneytype==1 then
		CheckCost( playerid , needmongey , 0 , 3, "山庄装饰铜币") 
	end
	SendLuaMsg(0,{ids=ZS_buy,tag=tag,index=index,last_time=GetServerTime()+lasttime*24*3600},9)
	look('装饰装饰装饰装饰')
end
--启用装饰
function Garniture_set(playerid,tag,index)
	if playerid==nil or tag==nil or index==nil  then return end
	local garniture_data=GetDBGarnitureData( playerid )
	if garniture_data==nil then return end
	if tag~=3 then
		local isbuy=0
		local cancel=0
		local delid=0
		for k,v in pairs (garniture_data[tag]) do
			if type(k)==type(0) and type(v)==type({}) then
				if v[1]==index then
					isbuy=1
				end
				if garniture_data.used[tag]==v[1] then
					cancel=1
					delid=k
				end
			end
		end
		if isbuy==0 then 
			look('Garniture_noid')
			return
		else
			garniture_data.used[tag]=index
		end
		if cancel==1 then 
			cancel=tag*1000+garniture_data[tag][delid][1]
		else
			cancel=nil
		end
		SendLuaMsg(0,{ids=ZS_set,tag=tag,index=index,cancel=cancel},9)--成功
	else
		local mark=0
		for k,v in pairs (garniture_data[tag]) do
			if type(k)==type(0) and type(v)==type({}) then
				if v[1]==index then
					if type(garniture_data.used[tag])~=type({}) then
						garniture_data.used[tag]={}
					end
					local tempuse=true
					for m,n in pairs(garniture_data.used[tag]) do
						if n==index then
							tempuse=false
							break
						end
					end
					if tempuse then
						_insert(garniture_data.used[tag],index)
						mark=1
					end
					break
				end
			end
		end
		if mark==0 then
			return
		end
		SendLuaMsg(0,{ids=ZS_set,tag=tag,index=index},9)--成功
	end
end
--取消装饰
function Garniture_cancel(playerid,tag,index)
	look('取消装饰')
	if playerid==nil or tag==nil or index==nil  then return end
	local garniture_data=GetDBGarnitureData( playerid )
	if garniture_data==nil then return end
	if garniture_data.used[tag] then
		if tag~=3 then
			garniture_data.used[tag]=nil
			local cancel=tag*1000+index
			SendLuaMsg(0,{ids=ZS_cancel,cancel=cancel},9)
		else
			if type(garniture_data.used[tag])==type({}) then
				for k,v in pairs (garniture_data.used[tag]) do
					if index==v then
						_remove(garniture_data.used[tag],k)
						local cancel=tag*1000+index
						SendLuaMsg(0,{ids=ZS_cancel,cancel=cancel},9)
					end
				end
			end
		end
	end	
end