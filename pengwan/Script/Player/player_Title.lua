--[[
file:	Title_conf.lua
desc:	title config(S&C)
author:	chal
update:	2011-12-15
version: 1.0.0
refix: done by chal
]]--
--------------------------------------------------------------------------
--include:
local ipairs,type,rint= ipairs,type,rint
local ScriptAttType = ScriptAttType
local SendLuaMsg,GetServerTime = SendLuaMsg,GetServerTime
local CI_GetPlayerData,CI_SetPlayerIcon = CI_GetPlayerData,CI_SetPlayerIcon
local Title_Data = msgh_s2c_def[15][13]
local Title_Set = msgh_s2c_def[15][14]

--------------------------------------------------------------------------
--data:
local tidlist = {0,0,0,0}

local TitleList = {		-- 称号名，称号资源ID(无资源ID填0)，加属性,	获取条件
	[1] = {'系统指导员',1,nil,'系统指导员专用称号'},
	[4] = {'只手遮天',4,{[7] = 50},'使用道具后获得'},
	[5] = {'一代宗师',5,{[8] = 50},'使用道具后获得'},
	[6] = {'威震九州',6,{[5] = 50},'使用道具后获得'},
	[7] = {'国士无双',7,{[6] = 50},'使用道具后获得'},
	[8] = {'八部天龙',8,{[1] = 500},'使用道具后获得'},
	[9] = {'鸿蒙至宝',9,{[3] = 100},'使用道具后获得'},
	[10] = {'天下第一庄',10,{[9] = 50},'使用道具后获得'},
	[11] = {'封神至尊',11,{[1] = 1000},'使用道具后获得'},
	[12] = {'一掷千金',12,{[1] = 1000},'使用道具后获得'},
	--[13] = {'天空之王',13,nil,'“天宫狩猎”活动积分周排行第一\n时效性一周'},
	[14] = {'神之护佑',14,{[1] = 50},'使用道具后获得',},
	--[15] = {'深海之主',15,nil,'“深海捕鱼”活动积分周排行第一\n时效性一周'},
	[16] = {'圣王守护',16,{[1] = 50},'使用道具后获得',},
	--[17] = {'酒中仙',17,nil,'曲水流觞活动灌酒胜利数周排行第一'},
	--[18] = {'酒中痴',18,nil,'曲水流觞活动灌酒胜利数周排行2-10'},
	[19] = {'纵横无敌',19,nil,'“三界夺宝”活动积分周排行第一\n时效性一周'},
	[20] = {'叱咤沙场',20,nil,'“三界夺宝”活动积分周排行2-10\n时效性一周'},
	[21] = {'帮战称雄',21,nil,'“帮会战”积分周排行第一的帮会所有成员\n时效性一周'},
	[22] = {'独孤求败',22,nil,'“竞技场”活动积分周排行第一\n时效性一周'},
	[23] = {'难逢敌手',23,nil,'“竞技场”活动积分周排行2-10\n时效性一周'},
	[24] = {'天下最帅',24,nil,'个人魅力周排行第一（男）\n时效性一周'},
	[25] = {'英俊潇洒',25,nil,'个人魅力周排行2-10（男）\n时效性一周'},
	[26] = {'天下最美',26,nil,'个人魅力周排行第一（女）\n时效性一周'},
	[27] = {'倾国倾城',27,nil,'个人魅力周排行2-10（女）\n时效性一周'},
	--[28] = {'初入红尘',28,{[6] = 500},'完成“初入红尘”的所有成就项'},
	--[29] = {'神通小成',29,{[9] = 1000},'完成“神通小成”的所有成就项'},
	--[30] = {'声名远播',30,{[7] = 2000},'完成“声名远播”的所有成就项'},
	--[31] = {'封神无双',31,nil,'完成“封神无双 ”的所有成就项'},
	[32] = {'三界至尊',32,nil,'三界至尊第一名可获得\n时效性一个月'},
	[33] = {'游戏达人',33,{[1] = 100},'使用道具后获得'},
	--[34] = {'至尊帮会',34,nil,'占领王城的帮会成员可获得'},
	[35] = {'安全卫士',35,{[1] = 10},'使用道具后获得',plat ='SL'},
	[36] = {'安全英雄',36,{[1] = 20},'使用道具后获得',plat ='SL'},
	[37] = {'安全战神',37,{[1] = 30},'使用道具后获得',plat ='SL'},
	[38] = {'安全至尊',38,{[1] = 50},'使用道具后获得',plat ='SL'},
	[39] = {'国王',39,nil,'占领王城的城主可以获得该称号'},
	[40] = {'神魔降临',40,nil,'使用道具后获得',plat ='SQ'},
	[41] = {'新婚燕尔',41,{[6] = 10},'与配偶的亲密度达到500后，可以在“红娘”处领取'},
	[42] = {'举案齐眉',42,{[6] = 50},'与配偶的亲密度达到3000后，可以在“红娘”处领取'},
	[43] = {'天作之合',43,{[6] = 100},'与配偶的亲密度达到10000后，可以在“红娘”处领取'},
	[44] = {'白头偕老',44,{[6] = 200},'与配偶的亲密度达到30000后，可以在“红娘”处领取'},
	[45] = {'神仙眷侣',45,{[6] = 500},'与配偶的亲密度达到60000后，可以在“红娘”处领取'},
	[46] = {'百战精英',46,{[7] = 100},'使用道具后获得'},
	[47] = {'玩游戏上37.com',47,{[1] = 50},'使用道具后获得',plat ='SQ'},
	[48] = {'劳动光荣',48,{[1] = 100},'使用道具后获得'},
	[49] = {'青年标兵',49,{[1] = 100},'使用道具后获得'},
	[50] = {'安全达人',50,{[1] = 10},'使用道具后获得',plat ='SL'},
	[51] = {'安全准神',51,{[1] = 20},'使用道具后获得',plat ='SL'},
	[52] = {'安全真神',52,{[1] = 30},'使用道具后获得',plat ='SL'},
	[53] = {'安全主神',53,{[1] = 40},'使用道具后获得',plat ='SL'},
	[54] = {'安全神王',54,{[1] = 50},'使用道具后获得',plat ='SL'},
	[55] = {'万王至尊(第一届)',55,{[1] = 3000},'第一届“诸神之战”的第一名'},
	[56] = {'众神之王(第一届)',56,{[1] = 2000},'第一届“诸神之战”的第二名'},
	[57] = {'天界战神(第一届)',57,{[1] = 1000},'第一届“诸神之战”的第三名'},
	[58] = {'酷我神创天下',58,{[1] = 50},'使用道具后获得',plat ='KU'},
	[59] = {'酷我最强王者',59,nil,'使用道具后获得',plat ='KU'},
	[60] = {'竞猜达人',60,{[1] = 200},'世界杯结束后使用福来勋章在“精彩活动”中兑换'},
	[61] = {'先知球迷',61,{[1] = 300},'世界杯结束后使用福来勋章在“精彩活动”中兑换'},
	[62] = {'传说预言帝',62,{[1] = 400},'世界杯结束后使用福来勋章在“精彩活动”中兑换'},
	[63] = {'梦幻球王',63,{[1] = 500},'世界杯结束后使用福来勋章在“精彩活动”中兑换'},
	[64] = {'万王至尊(第二届)',64,{[1] = 3000},'第二届“诸神之战”的第一名'},
	[65] = {'众神之王(第二届)',65,{[1] = 2000},'第二届“诸神之战”的第二名'},
	[66] = {'天界战神(第二届)',66,{[1] = 1000},'第二届“诸神之战”的第三名'},
    [67] = {'公爵',67,nil,'捐献铜钱榜第一名奖励，时效一小时'},	
    [68] = {'侯爵',68,nil,'捐献铜钱榜第二名奖励，时效一小时'},
    [69] = {'伯爵',69,nil,'捐献铜钱榜第三名奖励，时效一小时'},
    [70] = {'子爵',70,nil,'捐献铜钱榜第四名奖励，时效一小时'},
    [71] = {'男爵',71,nil,'捐献铜钱榜第五名奖励，时效一小时'},

	--[100] = {'小神',0,{[8] = 10},'完成目标第一阶段所有任务'},
	--[101] = {'真神',0,{[6] = 20},'完成目标第二阶段所有任务'},
	--[102] = {'主神',0,{[5] = 50},'完成目标第三阶段所有任务'},
	--[103] = {'神王',0,{[9] = 100},'完成目标第四阶段所有任务'},
	--[104] = {'神皇',0,{[4] = 500},'完成目标第五阶段所有任务'},
	[105] = {'幸运果农',0,{[7] = 20},'开启“七色变异果”时概率获得'},
	[106] = {'我爱女仆',0,{[4] = 20},'开启“妲己香囊”时，概率获得.香囊级别越高，概率越高.'},	
	[107] = {'钓鱼高手',0,{[1] = 100},'钓鱼的时候小概率获得'},
	[108] = {'再世孟尝',0,{[1] = 100},'在庄园召开宴会时，有小概率获得.宴会档次越高，概率越大.'},
	[109] = {'帮会是我家',0,{[7] = 30},'开启帮会夺宝的宝箱，小概率获得.宝箱级别越高，概率越大.'},
	[110] = {'幸运儿',0,{[9] = 30},'每日在线抽奖小概率获得.'},
	[111] = {'BOSS杀手',0,{[3] = 30},'野外BOSS小概率掉落'},
	[112] = {'海洋杀手',0,{[3] = 10},'杀死挂机秘境1层的“精英怪”有小概率掉落'},
	[113] = {'森林杀手',0,{[3] = 20},'杀死挂机秘境2层的“精英怪”有小概率掉落'},
	[114] = {'熔岩杀手',0,{[3] = 30},'杀死挂机秘境3层的“精英怪”有小概率掉落'},
	[115] = {'幽魂杀手',0,{[3] = 40},'杀死挂机秘境4层的“精英怪”有小概率掉落'},
	[116] = {'冰雪杀手',0,{[3] = 50},'杀死挂机秘境5层的“精英怪”有小概率掉落'},
	[117] = {'幻象杀手',0,{[3] = 60},'杀死挂机秘境6层的“精英怪”有小概率掉落'},
	[118] = {'深渊杀手',0,{[3] = 70},'杀死挂机秘境7层的“精英怪”有小概率掉落'},
}

--------------------------------------------------------------------------
-- inner function:

-- 取称号数据(放在TaskData下面的数据会在更新时自动同步给前台)
-- 预留近100个称号(由于有时间类称号不好预估大小)
local function GetPlayerTitleDB(playerid)
	if playerid == nil or playerid == 0 then
		return
	end
	local titleData = GI_GetPlayerData( playerid , "title" , 300 )
	if titleData == nil then
		return
	end
	--look(tostring(titleData))
	return titleData
end

-- 根据icon当前值取 sel
local function GetIconField(icon,itype,field,sel)
	if icon == 0 then
		return 0
	end
	if field == nil then
		return icon	
	end
	local ctp = rint(icon / (10^8))
	if itype ~= ctp then		-- 判断类型
		look('GetTempTitle itype erro')
		return 0
	end
	
	-- 只能分成 1 2 4 8段
	if field ~= 1 and field ~= 2 and field ~= 4 and field ~= 8 then
		look('GetTempTitle field erro')
		return
	end
	if sel > field then
		look('GetTempTitle sel erro')
		return
	end
	local bits = 8 / field
	local val = rint(icon / (10 ^ ((sel - 1) * bits))) % (10 ^ bits)
	
	return val
end

-- 设置icon sel = val
local function SetIconField(icon,itype,field,sel,val,opt)
	-- 只能分成 1 2 4 8段
	if field ~= 1 and field ~= 2 and field ~= 4 and field ~= 8 then
		look('SetTempTitle field erro')
		return
	end
	if sel > field then
		look('SetTempTitle sel erro')
		return
	end
	local bits = 8 / field		-- 每段的位数

	icon = itype * (10^8) + (icon % (10^8))		-- 设置类型(覆盖)
	if opt == 0 then				-- 覆盖sel feild
		local oldval = rint(icon / (10 ^ ((sel - 1) * bits))) % (10 ^ bits)
		oldval = oldval * (10 ^ ((sel - 1) * bits))
		icon = icon - oldval
		icon = icon + val * (10 ^ ((sel - 1) * bits))
	elseif opt == 1 then			-- 追加sel feild				
		icon = icon + val * (10 ^ ((sel - 1) * bits))
	else
		return
	end
	return icon
end

--------------------------------------------------------------------------
-- interface:
------------------[称号相关]------------------
-- 设置获取称号(只是添加到称号列表、并没有设置显示)
function SetPlayerTitle(sid,titleID,tm)
	if sid == nil then
		sid = CI_GetPlayerData(17)
	end
	local titleData = GetPlayerTitleDB(sid)
	if titleData == nil then return end
	if TitleList[titleID] == nil then return end
	-- look(titleData)
	-- 时效性称号一定不能配置属性！！！
	if tm and tm ~= 0 and TitleList[titleID][3] then
		return
	end
	local now = GetServerTime()
	if tm and now >= tm then
		SendLuaMsg( sid, { ids = Title_Set, opt = 1, res = 2, }, 10 )
		return
	end
	if titleData[titleID] == nil then
		local attr = GetRWData(1)
		-- 加属性
		if TitleList[titleID] and TitleList[titleID][3] and type(TitleList[titleID][3]) == type({}) then
			for k, v in pairs(TitleList[titleID][3]) do
				if type(k) == type(0) and type(v) == type(0) then
					attr[k] = (attr[k] or 0) + v
				end
			end
			PI_UpdateScriptAtt(sid,ScriptAttType.Title)
		end
		titleData[titleID] = tm or 0
		SendLuaMsg( sid, { ids = Title_Set, opt = 1, res =0, tid = titleID, tm = titleData[titleID] }, 10 )
	else
		if tm and tm > 0 then
			titleData[titleID] = tm
		end
		SendLuaMsg( sid, { ids = Title_Set, opt = 1, res = 1, }, 10 )
		return 1		-- 道具使用需根据这个返回值判断是否扣除道具
	end
end

-- 获取临时称号
function GetTempTitle(sid,itype,sel)
	if sid == nil or itype == nil then return end
	local icon = CI_GetPlayerIcon(2,0,2,sid) 
	if icon == 0 then
		return 0
	end
	local val
	-- 三界战场(field == 2)
	if itype == 1 then
		val = GetIconField(icon,itype,2,sel)
	elseif itype == 2 then
		val = GetIconField(icon,itype,1,sel)
	end
	return val
end

-- 设置临时称号(自定义数值)
-- @opt: 针对段的操作 [0] 设置(覆盖) [1] 增加
-- @itype: 会覆盖之前的类型 最大支持40种[1 ~ 40](后8为按类型自己分段使用)
--		[1] 三界战场法宝碎片数和连斩 field == 2(分2段每段4位)  sel = 1 连斩数 sel = 2 法宝碎片数
--		[2] 帮会运镖牵引标志 field = 1 (一段8位) sel = 1 表示牵引
function SetTempTitle(sid,itype,sel,val,opt)
	if sid == nil or itype == nil or opt == nil then return end
	local icon = CI_GetPlayerIcon(2,0,2,sid)
	if itype < 1 or itype > 40 then
		look('SetTempTitle itype erro')
		return
	end
	local field
	if itype == 1 then			-- 三界战场(field == 2)
		if val > 99 then
			val = 99
		end		
		field = 2
	elseif itype == 2 then		-- 帮会镖车牵引(field == 1)
		if val > 99 then
			val = 99
		end 
		field = 1
	end
	-- 增加最终转换为设置(有最大值限制)
	if opt == 1 then
		local oldval = GetIconField(icon,itype,field,sel) or 0
		val = val + oldval			
	end
	icon = SetIconField(icon,itype,field,sel,val,0)
	if icon then
		-- look('icon:' .. icon)
		CI_SetPlayerIcon(2,0,icon,1,2,sid)
	end
end

-- 清除临时称号
function ClrTempTitle(sid)
	CI_SetPlayerIcon(2,0,0,1,2,sid)
end

-- 从称号列表移除
-- 现在的逻辑:判断如果移除的是当前选择显示的称号、需要更新给C++
function RemovePlayerTitle(sid,titleID)
	if sid == nil then
		sid = CI_GetPlayerData(17)
	end
	if not IsPlayerOnline(sid) then
		return
	end
	local titleData = GetPlayerTitleDB(sid)
	if titleData == nil then return end
	if titleID then
		if titleData[titleID] then
			titleData[titleID] = nil
		else
			return
		end
	else
		for k, v in pairs(titleData) do
			if type(k) == type(0) then
				titleData[k] = nil
			end
		end
	end
		
	if titleID then
		local tid1,tid2,tid3,tid4 = CI_GetPlayerIcon(1,0,2,sid)
		tidlist[1] = tid1
		tidlist[2] = tid2
		tidlist[3] = tid3
		tidlist[4] = tid4
		if titleID == tid1 then
			tidlist[1] = 0
		elseif titleID == tid2 then
			tidlist[2] = 0
		elseif titleID == tid3 then
			tidlist[3] = 0
		elseif titleID == tid4 then
			tidlist[4] = 0
		end
		SetShowTitle(sid, tidlist)
	else
		SetShowTitle(sid, {0,0,0,0})
	end
	SendLuaMsg( sid, { ids = Title_Data, dt = titleData }, 10 )
end

function GetTitleAttr(sid)
	local titleData = GetPlayerTitleDB(sid)
	if titleData == nil then return end	
	-- 返回属性表	
	-- look('-----------------------')
	-- look(titleData)
	local attr = GetRWData(1)
	for tid, tm in pairs(titleData) do		-- 这里也限制一下时效性称号不能加属性
		if type(tid) == type(0) and tm == 0 and TitleList[tid] and TitleList[tid][3] and type(TitleList[tid][3]) == type({}) then
			for k, v in pairs(TitleList[tid][3]) do
				if type(k) == type(0) and type(v) == type(0) then
					attr[k] = (attr[k] or 0) + v
				end
			end
		end
	end
	-- look(attr)
	return attr
end

-- 设置需要显示的称号 tidList = 选择的titleID 列表
function SetShowTitle(sid, tList)
	-- look('SetShowTitle')
	-- look(tList)
	if tList == nil or type(tList) ~= type({}) or #tList > 4 then return end
	if sid == nil then
		sid = CI_GetPlayerData(17)
	end
	local sicon = 0
	local titleData = GetPlayerTitleDB(sid)
	if titleData == nil then return end
	for k, tid in ipairs(tList) do
		if titleData[tid] then			-- 检查前台传过来的数据的合法性
			sicon = sicon + rint(tid * math.pow(256,k-1))
		end
	end	
	-- look('sicon:' .. sicon)
	return CI_SetPlayerIcon(1,0,sicon,1,2,sid)	
end

-- 每日重置时检查称号时效
-- 称号的数据量可能会很大所以判断下如果有过期的才发整个data、
-- 如果只发过期的也可以但是会生成临时表
function checkTitleTime(sid)
	--look('checkTitleTime')
	local titleData = GetPlayerTitleDB(sid)
	if titleData == nil then return end
	local bsend = false
	local now = GetServerTime()
	local tid1,tid2,tid3,tid4 = CI_GetPlayerIcon(1,0,2,sid)
	tidlist[1] = tid1
	tidlist[2] = tid2
	tidlist[3] = tid3
	tidlist[4] = tid4
	-- look(tidlist)
	for tid, tm in pairs(titleData) do
		if type(tid) == type(0) and tm ~= 0 then
			-- look(tm)
			-- look(now)
			if tm < now then				
				if tid1 ~= -1 then
					if tid == tid1 then
						tidlist[1] = 0
						SetShowTitle(sid, tidlist)
					elseif tid == tid2 then
						tidlist[2] = 0
						SetShowTitle(sid, tidlist)
					elseif tid == tid3 then
						tidlist[3] = 0
						SetShowTitle(sid, tidlist)
					elseif tid == tid4 then
						tidlist[4] = 0
						SetShowTitle(sid, tidlist)
					end
				end
				titleData[tid] = nil
				bsend = true
			end
		end
	end
	-- look(titleData)
	if bsend then
		SendLuaMsg( sid, { ids = Title_Data, dt = titleData }, 10 )
	end
end