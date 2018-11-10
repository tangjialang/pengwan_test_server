--[[
file:	VIP_func.lua
desc:	VIP
author:	csj
]]--

local uv_TimesTypeTb = TimesTypeTb
local VipMailConf = MailConfig.VIPNotice
local pairs,tostring = pairs,tostring
local ipairs = ipairs
local look = look
--s2c_msg_def
local VIP_Data = msgh_s2c_def[34][1]
local VIP_Get = msgh_s2c_def[34][2]
local VIP_Exps = msgh_s2c_def[34][3]
local SendLuaMsg = SendLuaMsg
local CI_SetPlayerIcon = CI_SetPlayerIcon
local GetServerTime =GetServerTime
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos
----------------------------------------------------------------
--data:

-- VIP 配置
local VIPConfig = {
	LvInfo = {		-- 需要经验
		[1] = {0,},		
		[2] = {10000,},
		[3] = {20000,},
		[4] = {40000,},
		[5] = {80000,},
		[6] = {160000,},
		[7] = {320000,},
		[8] = {640000,},
		[9] = {1280000,},
	},
	TypeInfo = {	-- 需要的元宝数,购买的基础vip经验,时效天数,图标编号(用于更新给C++显示),每日增加经验,每日VIP礼包
		[1] = {0,0,1,1,0,			{{644,5,1},{51,1,1}}	},			-- 白银
		[2] = {198,0,10,2,1000,		{{644,5,1},{739,1,1}}	},			-- 黄金
		[3] = {468,10000,30,3,1000,		{{644,5,1},{739,2,1}}	},		-- 白金
		[4] = {1988,40000,180,4,1500,	{{644,5,1},{640,2,1},{669,1,1}}	},		-- 紫金
	},
	gift = {{710,5,1},{52,5,1},{604,100,1},{618,5,1},{0,1000000,1},{622,1,1},{673,5,1},{1062,5,1}},
}

--------------------------------------------------------------------
--inner function:

-- 获取VIP数据
local function GetPlayerVIPData( playerid )
	local vipdata=GI_GetPlayerData( playerid , 'VIP' , 30 )
	if vipdata == nil then return end
	-- {
	-- 	[1]: [1] 白银 [2] 黄金 [3] 白金 [4] 紫金
	--  [2]: 剩余时间
	--  [3]: vip经验
	--  [4]: 临时VIP到期时间
	--	[5]: 是否第一次购买VIP半年卡(nil:没买过 1 买过但没领礼包 2 已经领了礼包)
	-- }
	--look(tostring(vipdata))
	return vipdata
end

--[[
	获取VIP信息（不提供外部调用,因为这里没判断时效性）
@return: 
	vipType: [1] 白银 [2] 黄金 [3] 白金 [4] 紫金
	vipLeft: 剩余时间
	vipExp: vip经验
]]--
local function PI_GetVIPInfo(sid)
	local vipData = GetPlayerVIPData(sid)
	if vipData == nil then
		return 0,0,0
	end
	
	return (vipData[1] or 0),(vipData[2] or 0),(vipData[3] or 0)
end

-- 设置vip信息
local function PI_SetVIPInfo(sid,vipType,vipLeft,vipExp)
	local vipData = GetPlayerVIPData(sid)
	if vipData == nil then return end
	vipData[1] = vipType or 0
	vipData[2] = vipLeft or 0
	vipData[3] = vipExp or 0
	-- look(vipData[1])
	-- look(vipData[2])
	-- look(vipData[3])
end

-- 上线同步VIP信息(not use)
local function VIP_SyncData(sid)
	local vipData = GetPlayerVIPData(sid)
	if vipData == nil  then
		return
	end
	SendLuaMsg( 0, { ids = VIP_Data, data = vipData }, 9 )
end

---------------------------------------------------------------------------------
--interface:

-- 设置vip、系统指导员、GM
function set_vip_icon(sid,itype,val,br)
	if sid == nil or itype == nil or val == nil or br == nil then return end
	if not IsPlayerOnline(sid) then
		return 1
	end
	if val < 0 or val > 4 then 				--vip [0,4]
		return 2
	end
	local icon = CI_GetPlayerIcon(0,0,2,sid)
	if icon == 0x10 and itype ~= 3 then		-- GM号只能做取消操作
		return 3
	end
	look('oldicon:' .. icon)
	if icon == nil or icon < 0 then return end
	if itype == 1 then		-- 设置vip
		icon = rint(icon / (2^3)) * (2^3) + val	
	elseif itype == 2 then	-- 设置系统指导员
		local oldbit = rint(icon / (2^3)) % 2
		if val == 0 then		-- 取消
			if oldbit == 1 then
				icon = icon - 2^3
			end
		elseif val == 1 then	-- 设置
			if oldbit == 0 then
				icon = icon + 2^3
			end
		end
	elseif itype == 3 then	-- 设置GM
		if val == 0 then		-- 取消
			icon = 0
		elseif val == 1 then	-- 设置
			icon = 0x10
		end		
	end
	look('icon:' .. icon)
	CI_SetPlayerIcon(0,0,icon,br,2,sid)
	return 0
end

-- 登陆加buff
function vip_login_addbuff(sid)
	-- local vipType = GI_GetVIPType(sid)
	-- if vipType and vipType == 4 then
	-- 	CI_AddBuff(94,0,1,true,2,sid)		-- 加buff
	-- end
	local vtype = GI_GetVIPType( sid ) or 0
	if vtype < 2 then
		return
	end
	local vip=GI_GetVIPLevel( sid ) or 0
	if vip>=4 then 
		CI_AddBuff(94,0,1,true,2,sid)		-- 加buff
	end
end

-- VIP每日更新
function VIP_DayReset(sid,iDays)
	local vipData = GetPlayerVIPData(sid)
	if vipData == nil or vipData[1] == nil or vipData[2] == nil or vipData[3] == nil then 
		return 
	end
	if iDays < 1 then iDays = 1 end
	local bSetIcon = true
	local oldDays = vipData[2] or 0
	if oldDays == 0 then
		bSetIcon = false		-- 已经不是VIP了应该已经设置过VIP标识了 减少C++调用
	end
	local oldType = vipData[1] or 0
	vipData[2] = oldDays - iDays
	if vipData[2] <= 0 then	
		-- vipData[1] = 0			-- 更新vip类型 不更新了 保留之前买的类型
		vipData[2] = 0				-- 更新vip剩余天数
		-- < 0 说明时间到期了、需要扣除每日经验
		vipData[3] = (vipData[3] or 0) - (iDays - oldDays) * 500
		-- 时效过了 清除VIP标识
		if bSetIcon then
			set_vip_icon(sid,1,0,1)
			SendSystemMail(sid,VipMailConf,1,2)
		end
	end
	-- 到期前邮件提醒
	if vipData[2] >= 1 and vipData[2] <= 3 then
		SendSystemMail(sid,VipMailConf,5,2)
	end
	
	local addExp = VIPConfig.TypeInfo[oldType][5] or 0
	oldDays = math.min(oldDays,iDays)	
	vipData[3] = (vipData[3] or 0) + oldDays * addExp
	if vipData[3] < 0 then vipData[3] = 0 end
	
	SendLuaMsg( 0, { ids = VIP_Data, data = vipData,bSetIcon = bSetIcon }, 9 )
end

-- VIP增加经验
function VIP_AddExp(sid,exps)
	-- look('VIP_AddExp:' .. exps)
	if sid == nil or exps == nil then
		return
	end
	if exps < 0 then
		return
	end
	local vipData = GetPlayerVIPData(sid)
	if vipData == nil then 
		return 
	end
	local oldLv = GI_GetVIPLevel(sid)
	if oldLv == 0 then
		return
	end	
	vipData[3] = (vipData[3] or 0) + exps
	local newLv = GI_GetVIPLevel(sid)
	if newLv > oldLv then
		vip_timesreset(sid,oldLv,newLv)
		if newLv==4 then 
			CI_AddBuff(94,0,1,true,2,sid)		-- 加buff
		end
	end
	SendLuaMsg( 0, { ids = VIP_Exps, exps = vipData[3] }, 9 )
end

-- 服务端获取VIP等级统一接口、只适用于判断权限
-- vipLv = 0 表明失效已过
function GI_GetVIPLevel(sid)
	if sid == nil then
		sid = CI_GetPlayerData(17)
	end
	local vipData = GetPlayerVIPData(sid)
	if vipData == nil then
		return 0
	end
	
	local now = GetServerTime()
	local vipLv = 0	
	if ( ((vipData[2] or 0) > 0) or (vipData[4] and now < vipData[4]) ) then	-- 只要时效性没过 vip等级至少为 1
		for k, v in ipairs(VIPConfig.LvInfo) do
			if (vipData[3] or 0) < v[1] then
				vipLv = k - 1
				break
			else
				vipLv = k
			end
		end
	end
	
	return vipLv
end

function GI_GetVIPType(sid)
	if sid == nil then 
		return 0
	end
	local vipType = CI_GetPlayerIcon(0,0,2,sid)
	if vipType == nil or vipType < 0 then
		return 0
	end
	return vipType%(2^3)	
end

-- 购买VIP
function VIP_BuyLv(sid,fName,iType,buseitem)	
	if iType == nil or iType <= 1 or iType > 4 then
		return
	end
	local playerid = sid
	if fName ~= nil then	-- 给好友购买 后台暂时不判断是否是好友
		playerid = GetPlayer(fName,0)		
	end
	look(playerid)
	if playerid == nil then
		SendLuaMsg( 0, { ids = VIP_Data, fName = fName, res = 1 }, 9 )	-- 对方不在线
		return 
	end
	local vipData = GetPlayerVIPData(playerid)
	if vipData == nil then return end
	local vipType,vipLeft,vipExp = PI_GetVIPInfo(playerid)	
	-- look(vipType)
	-- look(vipLeft)
	-- look(vipExp)

	local cost = VIPConfig.TypeInfo[iType][1]
	if cost == nil or cost < 0 then
		look("这是要闹哪样啊!!!")
		return
	end
	-- 注意：扣钱要扣购买那个人的 先检查
	if not buseitem and not CheckCost(sid,cost,1,1,"购买VIP") then
		SendLuaMsg( 0, { ids = VIP_Data, fName = fName, res = 3 }, 9 )	-- 木有钱也想成为VIP
		return
	end
	local oldLv = GI_GetVIPLevel(sid)
	if vipLeft > 0 then
		vipType = math.max(vipType,iType)
	else
		vipType = iType
	end	
	if buseitem and iType == 2 then
		vipLeft = vipLeft + 3
	else
		vipLeft = vipLeft + VIPConfig.TypeInfo[iType][3]
	end
	
	vipExp = math.max(vipExp,VIPConfig.TypeInfo[iType][2])
	
	-- 设置VIP信息
	PI_SetVIPInfo(playerid,vipType,vipLeft,vipExp)
	
	-- 注意：扣钱要扣购买那个人的，不能坑
	-- 扣钱必须在设置经验之后 不然会被覆盖
	if not buseitem then
		CheckCost(sid,cost,0,1,"100007_VIP_" .. tostring(iType))
	else
		VIP_AddExp(sid,cost)
	end
	
	local newLv = GI_GetVIPLevel(sid)
	if newLv > oldLv then
		vip_timesreset(sid,oldLv,newLv)
	end
	
	-- 如果有临时VIP无论是否过期清除临时VIP
	if vipData[4] then
		vipData[4] = nil
	end
	
	-- 设置VIP图标	
	set_vip_icon(playerid,1,vipType,1)
	
	-- 设置是否第一次购买半年卡
	if iType == 4 then
		vipData[5] = vipData[5] or 1
		CI_AddBuff(94,0,1,true,2,playerid)		-- 加buff
	end
	
	local pName = CI_GetPlayerData(5)
	if fName == nil then
		SendLuaMsg( 0, { ids = VIP_Data, data = vipData, res = 0, buseitem = buseitem }, 9 )
		SendSystemMail(playerid,VipMailConf,100+iType,2)	-- 这里的iType正好对应邮件编号
		if iType == 4 then
			BroadcastRPC('tip_notice',1,pName)
		end		
	else
		SendLuaMsg( 0, { ids = VIP_Data, fName = fName, res = 0 }, 9 )
		-- 发送邮件通知对方		
		SendLuaMsg( playerid, { ids = VIP_Data, pName = pName, data = vipData, res = 0 }, 10 )		
		SendSystemMail(playerid,VipMailConf,iType,2,pName)	-- 这里的iType正好对应邮件编号
		if iType == 4 then
			BroadcastRPC('tip_notice',1,fName)
		end
	end
	set_obj_pos(playerid,1002)
end

-- 领取每日VIP礼包
function VIP_GetDayGift(sid)
	look('VIP_GetDayGift')
	local vipType = CI_GetPlayerIcon(0,0)	
	look('vipType:' .. tostring(vipType))
	if vipType%(2^3) <= 0 then	 		-- 还木有成为VIP啊！ 亲!
		SendLuaMsg( 0, { ids = VIP_Get, res = 1, opt = 1 }, 9 )	
		return
	end
	if VIPConfig.TypeInfo[vipType] == nil then return end
	local goods = VIPConfig.TypeInfo[vipType][6]
	if goods == nil then return end
	local pakagenum = isFullNum()
	if pakagenum < #goods then			-- 背包不够大啊！亲！
		SendLuaMsg( 0, { ids = VIP_Get, res = 3, opt = 1 }, 9 )	
		return
	end
	-- 判断是否领取
	if not CheckTimes(sid,uv_TimesTypeTb.VIP_DayGet,1,-1) then
		look("领取过了啊！亲！")
		return
	end
	local succ, retCode, num = GiveGoodsBatch(goods,"VIP新手礼包")
	if not succ and retCode == 3 then
		TipCenter(GetStringMsg(14,num))
		return
	end

	SendLuaMsg( 0, { ids = VIP_Get, res = 0, opt = 1 }, 9 )
end

-- 领取首次购买VIP半年卡礼包
function VIP_GetFirstGift(sid)
	local vipData = GetPlayerVIPData(sid)
	if vipData == nil then return end
	if vipData[5] == nil or vipData[5] > 1 then
		SendLuaMsg( 0, { ids = VIP_Get, res = 1, opt = 2 }, 9 )
		return
	end
	local goods = VIPConfig.gift
	local pakagenum = isFullNum()
	if pakagenum < #goods then			-- 背包不够大啊！亲！
		SendLuaMsg( 0, { ids = VIP_Get, res = 2, opt = 2 }, 9 )	
		return
	end
	-- 设置已领取
	vipData[5] = 2
	local succ, retCode, num = GiveGoodsBatch(goods,"VIP新手礼包")
	if not succ and retCode == 3 then
		TipCenter(GetStringMsg(14,num))
		return
	end
	SendLuaMsg( 0, { ids = VIP_Get, res = 0, opt = 2 }, 9 )
end

-- 设置临时vip(重要：保证只会调用一次)
function VIP_SetTemp(sid)
	sid = sid or CI_GetPlayerData(17)
	if sid == nil or sid <= 0 then return end
	local vipLv = GI_GetVIPLevel(sid)
	local vipData = GetPlayerVIPData(sid)
	if vipLv and vipLv == 0 and vipData then
		if vipData[4] == nil then
			set_vip_icon(sid,1,1,1)
			vipData[4] = GetServerTime() + 30*60
			look('SetEvent')
			SetEvent(30*60,nil,'VIP_Notice',sid)
			SendLuaMsg( sid, { ids = VIP_Data, data = vipData, tmp = 1 }, 10 )
		end		
	end
end

function VIP_Notice(sid)
	if VipMailConf == nil then return end
	if IsPlayerOnline(sid) then
		local vipData = GetPlayerVIPData(sid)
		if vipData then
			vipData[4] = nil
		end
		local vipLv = GI_GetVIPLevel(sid)
		if vipLv == nil or vipLv == 0 then
			set_vip_icon(sid,1,0,1)			-- 清除VIP标识
			SendLuaMsg( sid, { ids = VIP_Data, data = vipData, tmp = 0 }, 10 )
			
			-- 发送邮件提醒
			SendSystemMail(sid,VipMailConf,1,2)
		end
	end
end

-- VIP上线处理(判断临时VIP信息)
function VIP_OnlineProc(sid)
	local vipData = GetPlayerVIPData(sid)				
	if vipData then
		local now = GetServerTime()
		if vipData[4] and now >= vipData[4] then	-- 临时VIP失效了
			vipData[4] = nil
			local vipLv = GI_GetVIPLevel(sid)
			if vipLv == nil or vipLv == 0 then
				set_vip_icon(sid,1,0,1)				-- 清除VIP标识
			end
			SendLuaMsg( sid, { ids = VIP_Data, data = vipData, tmp = 0 }, 10 )
		end
	end
end

-- for test
function clear_vip(sid)
	local vipData = GetPlayerVIPData(sid)
	if vipData then
		vipData[1] = nil
		vipData[2] = nil
		vipData[3] = nil
		vipData[4] = nil
		vipData[5] = nil
		set_vip_icon(sid,1,0,1)			-- 清除VIP标识
		SendLuaMsg( sid, { ids = VIP_Data, data = vipData }, 10 )
	end
end

-- 临时vip
function vip_tempfun(sid)
	local vipType = GI_GetVIPType(sid)
	if vipType >= 2 then
		set_obj_pos(sid,1002)
	end
end