--[[
file:	baoyue.lua
desc:	包月
author:	wk
time:2013- 08- 29
]]--
local look = look
local SendLuaMsg = SendLuaMsg
local by_buymes = msgh_s2c_def[34][4]
local by_buy_err = msgh_s2c_def[34][5]
local baoyueMailConf = MailConfig.baoyueMailConf
----------------------------------------------------------------
--data:
local by_config = {
	[1]=80,
	[2]=90,
	[3]=100,
	[4]=100,
	[5]=150,
	[100]=288, --全买
}
local by_maxnum=5 --包月最大条数
--------------------------------------------------------------------
--inner function:

-- 获取VIP数据
local function by_getplayerData( playerid )
	local bydata=GI_GetPlayerData( playerid , 'byue' , 30 )
	if bydata == nil then return end
	-- {
	-- 	[1]: 悬赏
	--  [2]: 护送
	--  [3]: 山庄侦察
	--  [4]: 扫荡---捕鱼
	--	[5]: 果园
	-- }
	--look(tostring(bydata))
	return bydata
end

--购买包月,itype=100为全买
function by_buy( playerid,itype,name )
	look(111)
	local nplayerid
	if name ~= nil then	-- 给好友购买 后台暂时不判断是否是好友
		nplayerid = GetPlayer(name,0)
	else
		nplayerid=playerid	
	end
	if nplayerid == nil then
		SendLuaMsg( 0, { ids = by_buy_err, name = name, res = 1 }, 9 )	-- 对方不在线
		return 
	end

	local bydata=by_getplayerData(nplayerid)
	if bydata==nil then return end
	local needmoney=by_config[itype]
	if needmoney==nil then return end
	if not CheckCost(playerid,needmoney,0,1,"100006_购买包月"..tostring(itype)) then
		
		return
	end	
	if itype==100 then 
		for i=1,by_maxnum do
			bydata[i]=(bydata[i] or 0)+30
		end
	elseif itype>0 and itype<=by_maxnum then
		bydata[itype]=(bydata[itype] or 0)+30
	end
	
	if name then
		local sname=CI_GetPlayerData(5)
		SendLuaMsg( nplayerid, { ids = by_buymes, itype = itype, data = bydata,name=sname }, 10 )
		SendLuaMsg( 0, { ids = by_buymes, itype = itype, name = name ,}, 9 )
		SendSystemMail(nplayerid,baoyueMailConf,1,2,sname)	-- 这里的iType正好对应邮件编号
	else
		SendLuaMsg( 0, { ids = by_buymes, itype = itype, data = bydata ,}, 9 )
	end
	look(333)
end
--重置刷新
function by_reset( playerid ,iDays)
	local bydata=by_getplayerData(playerid)
	if bydata==nil then return end
	if iDays < 1 then iDays = 1 end
	for i=1,by_maxnum do
		if bydata[i] and bydata[i]>0 then
			bydata[i]=bydata[i]-iDays
			if bydata[i]<0 then 
				bydata[i]=0
			end
		end
	end
	SendLuaMsg( 0, { ids = by_buymes, data = bydata }, 9 )
end
--获取权限
function baoyue_getpower( playerid, itype)
	local bydata=by_getplayerData(playerid)
	if bydata==nil then return end
	if itype>0 and itype<=by_maxnum then
		if bydata[itype] and bydata[itype]>0 then
			return true
		end
	end 
end


function test_by(playerid)
	local bydata=by_getplayerData(playerid)
	for i =1 ,5 do
		bydata[i]=nil
	end
	SendLuaMsg( 0, { ids = by_buymes, data = bydata }, 9 )
end

----减包月天数
function baoyue_cutday( playerid ,num)
	local bydata=by_getplayerData(playerid)
	for i =1 ,5 do
		if bydata[i] then
			bydata[i]=bydata[i]-num
			if bydata[i]<=0 then
				bydata[i]=0
			end
		end
	end
	SendLuaMsg( 0, { ids = by_buymes, data = bydata }, 9 )
end