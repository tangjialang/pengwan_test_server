--[[
file：	bsmz_fun.lua
desc:	宝石迷阵
author: sxj
update: 2014-08-21
]]--
--------------------------------------------------------------------------
--include:
local os = os
local type = type
local pairs = pairs
local Faction_Build = msgh_s2c_def[7][4]
local SetEvent = SetEvent
local dbMgr = dbMgr
local GetWorldCustomDB = GetWorldCustomDB
local CI_GetPlayerData = CI_GetPlayerData
local CI_GetMemberInfo = CI_GetMemberInfo
local define		= require('Script.cext.define')
local FACTION_FBZ = define.FACTION_FBZ
local GetServerTime = GetServerTime
local GetWorldLevel = GetWorldLevel
local rint = rint
local conf = require ('Script.bsmz.bsmz_conf')
local CI_GetFactionInfo = CI_GetFactionInfo
local get_join_factiontime = get_join_factiontime
local FactionRPC = FactionRPC
local CheckCost = CheckCost
local CheckGoods = CheckGoods
local GiveGoods = GiveGoods
local RPC = RPC
local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist = sclist_m.insert_scorelist
local get_scorelist_data = sclist_m.get_scorelist_data
local MailConfig=MailConfig
local look = look
local SendSystemMail = SendSystemMail
local __G = _G
local RPCEx = RPCEx
local CI_SetFactionInfo = CI_SetFactionInfo
local SendLuaMsg = SendLuaMsg
---------------------------------------------------
module(...)

--[[	宝石迷阵数据结构
bsmz_data = {
	[fid] = {
		[1] = {活动标识，结束时间，基础步数，Boss当前血量,击杀者,Boss总血量}
		[2] = {
			[sid] = {个人步数，总伤害，地图}
			...
		}
	...
	}
}

]]--
	--添加进世界数据
local function get_in_data()
	local getwc_data = GetWorldCustomDB()
	if getwc_data == nil then 
		return 
	end
	if  getwc_data.bsmz_data == nil then
		getwc_data.bsmz_data = {}		
	end
	return getwc_data.bsmz_data
end
	--宝石迷阵帮会数据
local function bsmz_facData(fid)
	local bsmz_data = get_in_data()
	if bsmz_data[fid] == nil then
		bsmz_data[fid] = {}					
	end
	return bsmz_data[fid]	
end	
	--宝石迷阵个人数据
local function bsmz_perData(playerid)
	local fid = CI_GetPlayerData(23)	
		--帮会不存在
	if fid == nil or fid == 0 then
		return	
	end
	local faction_data = bsmz_facData(fid)
		--帮会数据不存在
	if faction_data == nil then
		return				
	end
	faction_data[2] = faction_data[2] or {}
	faction_data[2][playerid] = faction_data[2][playerid] or {}
	return faction_data[2][playerid]
end	
 	--数据检测
local function bsmz_check(fid)
		--帮会不存在
	if fid == nil or fid == 0 then
		return false,0 --帮会不存在
	end
		--建筑不存在
	local build = __G.fBuild_conf[7]
	if build == nil then
		return false,1 --建筑不存在
	end
		--建筑未激活
	local curLv = CI_GetFactionInfo(fid,12) --建筑暂定为12
	if curLv == nil then
		return false,2 --建筑未激活
	end
		--帮派数据表不存在
	local data = bsmz_facData(fid)
	if data == nil then 
		return false, 10	--后台数据错误
	end
	return true
end  
   --开启
		--open: nil 活动未开启，1 活动已经开启 2 活动已经结束
local function _bsmz_open(playerid,num)
	local fid = CI_GetPlayerData(23)
	local result,redata = bsmz_check(fid)
	if result == false then
		return result,redata
	end
		--帮内职位不够
	local title = CI_GetMemberInfo(1)
	if title < FACTION_FBZ then
		return false,3 --帮主、副帮主才能开启
	end
		--不在规定时间内
	local endTime = GetServerTime()
		--date = {hour,min,wday,day,month,year,sec,yday,isdst}
	local date = os.date("*t",endTime)		
	if date.hour <12 or date.hour >=22 then
		return false,4 --不在规定时间内
	end	
	local data = bsmz_facData(fid)
	data[1] = data[1] or {}			
	if data[1][1] == 2 then
		return false,5 --活动已经结束		
	elseif data[1][1] == 1 then
		return false,6 --活动已经开启
	elseif data[1][1] ~= nil then
		return false,11 --活动标识错误
	end		
		--获取世界等级 值为 50、60、70、80、90
	local wLevel = GetWorldLevel() or 50
	if wLevel < 50 then
		wLevel = 50
	elseif wLevel > 90 then
		wLevel = 90
	end
	wLevel = (rint(wLevel/10))*10	
	endTime = endTime + 2*60*60	
	local open = 1
	local curLv = CI_GetFactionInfo(nil,12) --建筑暂定为12
	local step = 20+ curLv	
	local BossBlood = conf.bsmz_conf[wLevel]* (num)
				 --活动标识，结束时间，基础步数，Boss当前血量，击杀者,Boss总血量
	data[1][1] = open
	data[1][2] = endTime
	data[1][3] = step
	data[1][4] = BossBlood
	data[1][5] = nil
	data[1][6] = BossBlood
		--广播 结束时间给前端
	FactionRPC(fid,'ff_bsmz_open',data[1][2])	
		--时间到，回调结束函数
	SetEvent(2*60*60,nil,"GI_bsmz_end",fid)			
	return true,open	--活动开启成功
end

    --开始游戏（初始化）
local function _bsmz_begin(playerid)
	local fid = CI_GetPlayerData(23)
	local result,redata = bsmz_check(fid)
	if result == false then
		return result,redata
	end
		--帮会共有数据不存在
	local facData = bsmz_facData(fid)
	local shareData = facData[1]
	if shareData == nil then
		return false,10 --后台数据错误
	end
		--个人数据表不存在	
	local perData = bsmz_perData(playerid)
	if perData == nil then 
		return false,11 --后台数据错误
	end
		--活动不是开启状态
	if shareData[1] ==nil then
		return false,3 -- 活动未开始
	end
		--活动已经结束
	if shareData[1] ~= 1 and shareData[1] ~= nil then
		return false,4 -- 活动已经结束
	end
		--入帮小于24小时
	local join = __G.get_join_factiontime(playerid)
	local now = GetServerTime()
	if now - join < 24*60*60 then
		return false,5 	--入帮小于24小时
	end
		--排行榜
	local itype = 100000000 + fid	--定义排行榜itype, 活动类型 + fid
	local sclist = get_scorelist_data(1,itype)
	look("开始排行榜")
	look(sclist)
	perData[1] = perData[1] or shareData[3]	--个人步数
	perData[2] = perData[2] or 0		--总伤害
	perData[3] = perData[3] or nil			--宝石矩阵地图
				--地图，Boss当前血量，Boss总血量，排行榜，个人步数，个人总伤害	
	return true,perData[3],shareData[4],shareData[6],sclist,perData[1],perData[2]						
end
	--开始游戏存地图
local function _bsmz_save_map(playerid,map)
	local fid = CI_GetPlayerData(23)
	local result,redata = bsmz_check(fid)
	if result == false then
		return result,redata
	end
		--帮会共有数据不存在
	local facData = bsmz_facData(fid)
	local shareData = facData[1]
	if shareData == nil then
		return false,10 --后台数据错误
	end
		--个人数据表不存在	
	local perData = bsmz_perData(playerid)
	if perData == nil then 
		return false,11 --后台数据错误
	end
	if perData[3] ~= nil then 
		return
	end
	perData[3] = map
end
	--游戏过程（移动+伤害）
local function _bsmz_play(playerid,allmultiple,sub,map)
	local fid = CI_GetPlayerData(23)
	local result,redata = bsmz_check(fid)
	if result == false then
		return result,redata
	end
	--帮会共有数据不存在
	local facData = bsmz_facData(fid)
	local shareData = facData[1]
	if shareData == nil then	
		return false,10	--后台数据错误
	end
	--个人数据表不存在	
	local perData = bsmz_perData(playerid)
	if perData == nil then 
		return false,11 --后台数据错误
	end		
	--入帮小于24小时
	local join = __G.get_join_factiontime(playerid)
	local now = GetServerTime()
	if now - join < 24*60*60 then
		return false,5 	--入帮小于24小时
	end
	
	--活动不是开启状态
	if shareData[1] ==nil then
		return false,3 -- 活动未开始
	end
		--活动已经结束
	if shareData[1] ~= 1 and shareData[1] ~= nil then
		return false,4 -- 活动已经结束
	end
	local canContinue = nil 
	if perData[1] >0 then 
		canContinue = 1				--扣步数
	else
		if sub ==1 and CheckGoods(825,1,1,playerid,"宝石迷阵步数卡") == 1 then 
			canContinue = 2			--扣步数卡
		else
			if sub ==1 and CheckCost(playerid,1,1,1,"宝石迷阵移动")  then
				canContinue = 3 	--扣元宝
			else
				return false,5	--元宝不够
			end
		end
	end
	if canContinue ==1 or canContinue ==2 or canContinue == 3 then
		if canContinue == 1 then
			perData[1] = perData[1] - 1
		elseif canContinue == 2 then
			CheckGoods(825,1,0,playerid,"宝石迷阵移动扣步数卡")
		elseif canContinue ==3 then
			CheckCost(playerid,1,0,1,"宝石迷阵移动扣元宝")
		end
		local fight = CI_GetPlayerData(62)	--玩家战力		
		if allmultiple > 8 then	--倍数限制？
			allmultiple = 8
		end
		if allmultiple < 0 then	
			allmultiple = 0
		end
		if allmultiple ~= 0 then
			local name = CI_GetPlayerData(3)
			local itype = 100000000 + fid	--定义排行榜itype, 活动类型 + fid
			local name = CI_GetPlayerData(3)
			local school = CI_GetPlayerData(2)
			local harm = rint(allmultiple * fight)	--单步总伤害	
			if shareData[4] <=harm then	--Bosss死亡
				harm = shareData[4]			
				shareData[4] = 0
				shareData[5] = playerid
				perData[2] = perData[2] + harm			
																
			else
				shareData[4] = shareData[4] - harm
				perData[2] = perData[2] + harm										
			end			
			local money = rint(harm/20)	
			if money < 10000 then
				money = 10000
			elseif money > 1000000 then
				money = 1000000			
			end	
			insert_scorelist(1,itype,10,perData[2],name,school,playerid)
			local sclist = get_scorelist_data(1,itype)				
			GiveGoods(0,money,1,"宝石迷阵单步伤害铜钱")
			perData[3] = map
				--广播 Boss血量，排行榜给前端
			FactionRPC(fid,'ff_bsmz_playing',shareData[4],sclist)
			if 	shareData[4] == 0 then
					--调用结束函数
				bsmz_end(fid)
			end
		end
	end	
	return true,perData[1],perData[2]	
end

	--游戏结束，结算
local function _bsmz_end(fid)
	local result,redata = bsmz_check(fid)
	if result == false then
		return result,redata
	end
		--帮会共有数据不存在
	local facData = bsmz_facData(fid)
	local shareData = facData[1]
	if shareData == nil then
		return
	end
		--活动不是开启状态
	if shareData[1] ~= 1 then
		return
	end	
	shareData[1] = 2	
	local kname = nil
	if shareData[5] then
		kname = CI_GetPlayerData(3,2,shareData[5])	--击杀者名字 没有击杀为nil
	end
	if shareData[4] == 0 then 	--Boss被击杀	
			--最后一击奖励
		SendSystemMail(kname,MailConfig.Bsmzkill,1,2) 
			-- 排行榜
		local itype = 100000000 + fid	--定义排行榜itype, 活动类型 + fid
		-- 发送邮件
		local sclist = get_scorelist_data(1,itype)
		sclist[11] = kname

		local BsmzMail = MailConfig.Bsmz
		local award = MailConfig.Bsmz[1].award
		for k,tb in pairs(facData[2]) do
			if type(k) == type(0) and tb[2] ~=0 and tb[2] ~= nil then
				local name = CI_GetPlayerData(3,2,k)
				if name ~= nil then
					if sclist[1] ~= nil and name == sclist[1][2] then		--第1名
						SendSystemMail(name,BsmzMail,1,2,sclist,award[1])
					
					elseif sclist[2] ~= nil and name ==sclist[2][2] then	--第2名
						SendSystemMail(name,BsmzMail,1,2,sclist,award[2])
						
					elseif sclist[3] ~= nil and name == sclist[3][2] then	--第3名
						SendSystemMail(name,BsmzMail,1,2,sclist,award[2])
					elseif  (sclist[4] ~= nil and name == sclist[4][2]) or (sclist[5] ~= nil and name == sclist[5][2]) or
							(sclist[6] ~= nil and name == sclist[6][2]) or (sclist[7] ~= nil and name == sclist[7][2]) or
							(sclist[8] ~= nil and name == sclist[8][2]) or (sclist[9] ~= nil and name == sclist[9][2]) or
							(sclist[10] ~= nil and name == sclist[10][2]) then	--第4-10名
						SendSystemMail(name,BsmzMail,1,2,sclist,award[3])
						
					else 
						SendSystemMail(name,BsmzMail,1,2,sclist,award[4])
						
					end
				end
			end
		end
	end
	look("结束消息")
	look(shareData[1])
		--广播 活动标识、Boss血量，排行榜，击杀者给前端
	FactionRPC(fid,'ff_bsmz_end',shareData[1],shareData[4],sclist,kname)
end

	--刷新上线调用
local function _bsmz_online(playerid)
	local fid = CI_GetPlayerData(23)
		--玩家不存在
	if playerid == nil then	
		return 
	end	
		--帮会不存在
	if fid == nil or fid == 0 then	
		
		return 
	end	
		--帮会数据表不存在	
	local bsmz_data = get_in_data()
	if bsmz_data[fid] == nil or bsmz_data[fid][1] == nil then
		return
	end
		--结束时间,开启标识
	RPCEx(playerid,'bsmz_online',bsmz_data[fid][1][2],bsmz_data[fid][1][1])	
end

	--老帮派宝石迷阵更新建筑
local function _bsmz_add()
	local lv = CI_GetFactionInfo(nil,2)
	local buildLv = CI_GetFactionInfo(nil,12)
	if (lv ~= nil and lv >=5) and (buildLv == nil or buildLv == 0 ) then
		CI_SetFactionInfo(nil,12,1)
		SendLuaMsg( 0, { ids = Faction_Build,idx = 7,lv = 1}, 9 )
	end
end

local function _bsmz_refresh()
	dbMgr.world_custom_data.data.bsmz_data = nil
	look("bsmz_data_after:")
	look(dbMgr.world_custom_data.data.bsmz_data)
end

local function _bsmz_clear()
	local fid = CI_GetPlayerData(23)
	dbMgr.world_custom_data.data.bsmz_data[fid] = nil 
	look("bsmz_data_after singer:")
	look(dbMgr.world_custom_data.data.bsmz_data[fid])
end
--------------------------------------------------------------------------
--interface:

bsmz_open = _bsmz_open
bsmz_begin = _bsmz_begin
bsmz_save_map = _bsmz_save_map
bsmz_play = _bsmz_play
bsmz_end = _bsmz_end
bsmz_online = _bsmz_online
bsmz_refresh = _bsmz_refresh
bsmz_save_map = _bsmz_save_map
bsmz_clear = _bsmz_clear
bsmz_add = _bsmz_add