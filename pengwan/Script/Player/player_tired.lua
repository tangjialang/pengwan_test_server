--[[
file:	player_tired.lua
desc:	疲劳度,版署需求.
author:	wk
update:	2014-5-13
]]--

local SendLuaMsg=SendLuaMsg
local Player_FriendLuck = msgh_s2c_def[15][5]
local Player_sp = msgh_s2c_def[15][16]
local db_module =require('Script.cext.dbrpc')
local db_tired_writeid=db_module.db_tired_writeid
local db_tired_getinfo=db_module.db_tired_getinfo
local db_tired_logout=db_module.db_tired_logout

local function tired_getpdata( playerid )
	local p_data=GI_GetPlayerData( playerid , 'tire' , 20 )
	-- p_data[1] =1 成年 
	return p_data
end
--防沉迷状态,登陆取最大在线时间,修改本服在线时长
function tired_getonlinetime(sid)
	-- look(111,1)
	local a=GetCurPlayerWallow()
	-- look(a,1)
	if a and a>=0 then
		local pdata=tired_getpdata(sid)
		if pdata==nil then return end
		if pdata[1]and pdata[1]==1 then
			CI_SetPlayerData(9, -1)
		else
			db_tired_getinfo(sid)
		end
		
	end

	
end

--取在线时长回调 isadult=0未填写身份证号 1已填写身份证号但未成年  2已成年
function tired_getcallback(sid,onlinetime,isadult)
	-- look('取在线时长回调',1)
	-- look(onlinetime,1)
	
	-- look(isadult,1)
	
	if isadult==2 then 
		CI_SetPlayerData(9, -1)
		
	else
		if onlinetime and onlinetime>=0 then 
		 	CI_SetPlayerData(9, onlinetime) ----防沉迷时间设为onlinetime秒
		end	
	end
	RPC('tired',2,isadult)--身份信息
	-- local a=GetCurPlayerWallow() or 0
	-- look(a,1)
end
--填写身份证信息isup=1 18岁以上
function tired_getnum(sid ,id,name,isup)
	--look('填写身份证信息isup',1)
	db_tired_writeid(sid,id,name)

	
end
--填写身份证信息回调 res=1 未成年  2 已成年
function tired_writecallback(sid,onlinetime,res)
	RPC('tired',1,onlinetime)--填写成功
	if res and res==2 then 
		local pdata=tired_getpdata(sid)
		if pdata==nil then return end
		pdata[1]=1
		CI_SetPlayerData(9, -1)
		RPC('tired',2,res)--填写成功
	else
		if onlinetime and onlinetime>=0 then 
			CI_SetPlayerData(9, onlinetime) ----防沉迷时间设为onlinetime秒
		end
		
	end
	
end

--下线写存储,计算在线时长
function tired_logout()
	db_tired_logout()
end
