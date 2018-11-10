--[[
file:	player_menu_op.lua
desc:	all client menu op request.
author:	
update:	2013-06-01
refix: done by chal
]]--
local type = type
local RegionTable = RegionTable
local RPC,GetPlayer = RPC,GetPlayer
local CI_GetCurPos = CI_GetCurPos
local CI_GetPlayerData = CI_GetPlayerData
local CI_SetPlayerData = CI_SetPlayerData
local shq_m = require('Script.ShenQi.shenqi_func')
local GetPlayerShenQiData = shq_m.GetPlayerShenQiData
local zhanli_bipin = msgh_s2c_def[3][23]

-- 查看他人信息
function GI_ViewOtherInfo(sid,other,iType)
	if type(other) == type(0) then		-- sid
		if IsPlayerOnline(other) then
			local pName = CI_GetPlayerData(5,2,other)
			local MLData = ML_GetPlayerData(other)				-- 魅力
			local CJ = GetPlayerPoints(other,1) or 0		-- 成就
			local ZG = GetPlayerPoints(other,6) or 0		-- 战功
			local pManorData = GetManorData_Interf(other)	-- 庄园
			local mdata=GetPlayerMarryData(other) --戒指
			local rdata = GetPlayerShenQiData(other)			-- 神戒
			RPC("ViewOhter",other,iType,MLData.zml or 0,CJ,ZG,pManorData.mLv or 0,pName,mdata[3],rdata)
		end
	elseif type(other) == type("") then -- name
		local playerid = GetPlayer(other)
		if playerid then
			local MLData = ML_GetPlayerData(playerid)					-- 魅力
			local CJ = GetPlayerPoints(playerid,1) or 0			-- 成就
			local ZG = GetPlayerPoints(playerid,6) or 0 		-- 战功
			local pManorData = GetManorData_Interf(playerid)	-- 庄园
			local mdata=GetPlayerMarryData(playerid) --戒指
			local rdata = GetPlayerShenQiData(playerid)			-- 神戒
			RPC("ViewOhter",other,iType,MLData.zml or 0,CJ,ZG,pManorData.mLv or 0,nil,mdata[3],rdata)
		end
	end
end

function SetPlayerPKMode(sid,mode)
	if type(sid) ~= type(0) or type(mode) ~= type(0) then
		return
	end
	local level = CI_GetPlayerData(1,2,sid)
	if level < 30 then
		RPC('player_setpk',1)
		return
	end
	local _,_,rid = CI_GetCurPos(2,sid)
	if RegionTable[rid] == nil then
		return
	end
	local mapPK = RegionTable[rid].PKType or 1
	if mapPK == 1 and mode ~= 0xff then		-- 非PK场景玩家不能设置为非和平模式的其他PK模式
		--RPC('player_setpk',2)
		return
	end
	if mode ~= 0xff then	-- 玩家切换到非和平模式时移除死亡buff
		CI_DelBuff(242,2,sid)
	end
	CI_SetPlayerData(4,mode,2,sid)
	RPC('player_setpk',0,mode)
end

function  fightcompare(sname)
	local horse = 5  		--坐骑5
	local weapon = 6 		--骑兵6
	local god = 7    		--神创天下7
	local amulet = 8 		--守护通灵8
	local goddess = 10 		--女神10
	local hero = 11   	 	--家将11
	local wing = 13  	  	--神翼13
	
	SendLuaMsg( 0, {ids = zhanli_bipin,[5] = horse,[6] = weapon,[7] = god,[8] = amulet,
							[10] = goddess,[11] = hero,[13] = wing},9 )
end

--穿戴360勋章
function  shenqi_stamp_visible(playerid,val)
	local srcIcon = CI_GetPlayerIcon(3,4)
	srcIcon = bits.set(srcIcon,4,4,val)
	CI_SetPlayerIcon(3,4,srcIcon)
end