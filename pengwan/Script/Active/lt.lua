--[[
file: lt
]]--

---------------------------------------------------------
--include:

local pairs,ipairs,type = pairs,ipairs,type
local tostring = tostring
local math_random,math_abs = math.random,math.abs
local table_insert,table_remove = table.insert,table.remove
local __G = _G

local look = look
local rint = rint
local GetDBActiveData = GetDBActiveData
local GetActiveTemp = GetActiveTemp
local CI_GetCurPos = CI_GetCurPos
local CI_GetPlayerData = CI_GetPlayerData
local GetWorldLevel = GetWorldLevel
local PI_PayPlayer = PI_PayPlayer
local CI_SetPlayerData = CI_SetPlayerData
local IsPlayerOnline = IsPlayerOnline
local TimesTypeTb = TimesTypeTb
local CheckTimes = CheckTimes
local GetTimesInfo = GetTimesInfo
local sc_add = sc_add
local SetEvent = SetEvent
local SendLuaMsg = SendLuaMsg
local RPCEx = RPCEx
local BroadcastRPC = BroadcastRPC
local GetServerTime = GetServerTime
local AddPlayerPoints = AddPlayerPoints
local PI_GiveGoodsEx = PI_GiveGoodsEx
local PI_MovePlayer = PI_MovePlayer
local CI_OnSelectRelive = CI_OnSelectRelive
-- local PI_GetTsBaseData = PI_GetTsBaseData
local RegionRPC = RegionRPC
local active_mgr_m = require('Script.active.active_mgr')
local activitymgr=active_mgr_m.activitymgr
local db_module = require('Script.cext.dbrpc')
local lt_insert_list = db_module.lt_insert_list

local LT_Match = msgh_s2c_def[12][17]
local LT_pData = msgh_s2c_def[12][18]
local LT_viewlist = msgh_s2c_def[12][19]
local lt_enterView = msgh_s2c_def[12][20]
local LT_viewstate = msgh_s2c_def[12][21]
-- local LT_Scorelist = msgh_s2c_def[12][22]
local LT_result = msgh_s2c_def[12][23]
local LT_NoticeEnd = msgh_s2c_def[12][24]
local LT_RegComp = msgh_s2c_def[12][25]
local ltmailconf = MailConfig.LTMail
local LTSCORE_List_Max = 100

local BASELV = 40
local ULIMIT = 2
local FIELDLEN = ULIMIT * 2 + 1
local BASEFIELD = BASELV + ULIMIT
local LTRMAPID = 101 -- 擂台报名地图ID
local LTMapPos = {
	{16, 21},
}

local active_name = 'jjc'

------------------------------------------------------------
--module:

module(...)

------------------------------------------------------------
--inner:

local function LT_GetPlayerData(sid)
	local act_data = GetDBActiveData(sid)
	if act_data == nil then return end
	if act_data.lt_d == nil then
		act_data.lt_d = {}
	end
	return act_data.lt_d
end

-- 玩家临时数据
local function LT_GetPlayertemp(sid)
	local act_temp = GetActiveTemp(sid)
	if act_temp == nil then return end
	if act_temp.lt_t == nil then
		act_temp.lt_t = {}
	end
	return act_temp.lt_t
end

-- 取公共数据(活动结束清除)
local function lt_getpub()
	local active_lt = activitymgr:get(active_name)
	if active_lt == nil then			
		return
	end	
	local pub_data = active_lt:get_pub()
	if pub_data then
		pub_data.fieldlist = pub_data.fieldlist or {}
		pub_data.matchlist = pub_data.matchlist or {}
	end
	return pub_data
end

local function lt_get_mydata(sid)
	local active_lt = activitymgr:get(active_name)
	if active_lt == nil then			
		return
	end		
	local my_data = active_lt:get_mydata(sid)
	if my_data == nil then return end
	my_data.regtime = my_data.regtime or 0		-- 报名时间
	my_data.state = my_data.state or 0			-- 玩家状态
	
	return my_data	
end

-- 获取玩家应该分在哪个等级段
local function _get_lv_field(sid)
	local lv = CI_GetPlayerData(sid,1)		-- 玩家等级
	local lvList = getLevelList(0)			-- 等级排行榜
	local lvCount = #lvList
	local lvLimit = 0
	if lvList and lvList[lvCount] and type(lvList[lvCount]) == type({}) and #lvList[lvCount] == 2 then
		lvLimit = lvList[lvCount][2]
	else
		look("获取等级排行榜异常")
		return
	end
	local field = BASEFIELD + rint((lvLimit - BASELV)/FIELDLEN) * FIELDLEN	
	if lv < lvLimit then
		field = BASEFIELD + rint((lv - BASELV)/FIELDLEN) * FIELDLEN
		if lv >= BASEFIELD + ULIMIT then
			if lv == field + ULIMIT then
				local rd = math_random(1,100)		-- 50%几率放到高等级段
				if rd > 50 then
					field = field + FIELDLEN
				end
			elseif lv == field - ULIMIT then
				if lv ~= BASELV then
					local rd = math_random(1,100)		-- 50%几率放到低等级段
					if rd <= 50 then
						field = field - FIELDLEN
					end
				end
			end
		end
	end
	
	return field
end

-- 获取复活点 随机
local function _get_relive_pos()
	local rd = math_random(1, #LTMapPos)
	local pos = LTMapPos[rd]
	return pos,LTRMAPID
end

-- 获取当前报名人数
local function _get_report_count()
	local pub_data = lt_getpub()
	if pub_data == nil or pub_data.fieldlist == nil then return end
	local count = 0
	for k, v in pairs(pub_data.fieldlist) do
		if type(k) == type(0) and type(v) == type({}) then
			count = count + #v
		end
	end
	return count
end

-- 设置玩家当前状态
-- 1 报名
-- 2 匹配成功
function _set_player_state(sid,state)
	local p_LTData =  lt_get_mydata(sid)
	if p_LTData and p_LTData.state then		
		p_LTData.state = state				
	end	
end

-- 重置玩家状态
local function _lt_reset_player(sid)
	local p_LTData =  lt_get_mydata(sid)
	if p_LTData == nil then		
		return				
	end
	p_LTData.state = 0
	p_LTData.regtime = 0
end

local function _lt_clear_state(sid)
	local p_ltData = lt_get_mydata(sid)
	if p_ltData == nil then return end
	local temp = LT_GetPlayertemp(sid)
	if temp == nil then return end
	if temp.viewstate then temp.viewstate = nil end
	if temp.viewgid then temp.viewgid = nil end
	if temp.fitsid then temp.fitsid = nil end
	if temp.ltgid then temp.ltgid = nil end
	
	p_ltData.state = 0
	p_ltData.regtime = 0
end

-- 从报名列表移除
local function _lt_remove_field(sid)
	local pub_data = lt_getpub()
	if pub_data == nil or pub_data.fieldlist == nil then return end
	local tflist = pub_data.fieldlist
	for k, v in pairs(tflist) do
		if type(k) == type(0) and type(v) == type({}) then
			for m, n in pairs(v) do
				if type(m) == type(0) and type(n) == type(0) then
					if sid == n then						
						table_remove(tflist[k],m)
						return
					end
				end
			end
		end
	end
end

-- 必须在配对成功后马上建场景
local function _lt_match_success(sidA,sidB)
	look('_lt_match_success')
	local active_lt = activitymgr:get(active_name)
	if active_lt == nil then	
		return
	end	
	local pub_data = lt_getpub()
	if pub_data == nil or pub_data.matchlist ==nil then return end
	local a_temp = LT_GetPlayertemp(sidA)
	local b_temp = LT_GetPlayertemp(sidB)
	if a_temp == nil or b_temp == nil then
		look("a_temp == nil or b_temp == nil")
		return
	end
	if a_temp.fitsid ~= nil or b_temp.fitsid ~= nil then
		-- 玩家竞技数据有问题 这个需要看情况处理
		look("Have Matched")
		return
	end	
	if a_temp.ltgid == nil and b_temp.ltgid == nil then
		local xmap = active_lt:createDR(1)
		if xmap == nil then
			look("xmap == nil")
			return 
		end		
		a_temp.ltgid = xmap
		b_temp.ltgid = xmap
		local snA = CI_GetPlayerData(5,2,sidA)
		local snB = CI_GetPlayerData(5,2,sidB)
		local lvA = CI_GetPlayerData(1,2,sidA)
		local lvB = CI_GetPlayerData(1,2,sidB)
		local scA = CI_GetPlayerData(2,2,sidA)
		local scB = CI_GetPlayerData(2,2,sidB)
		-- SetRegionPKX(xmap,1)
		pub_data.matchlist[xmap] = { fightlist = {{sidA,snA,lvA,scA},{sidB,snB,lvB,scB}} }		-- 记录动态场景GID
	end
	a_temp.fitsid = sidB
	b_temp.fitsid = sidA
	_set_player_state(sidA,2)		-- 设置为匹配成功状态
	_set_player_state(sidB,2)
	return a_temp.ltgid
end

-- 更新数据
local function _lt_update_data(winSID,loseSID,iType)
	look('_lt_update_data 11')
	local player_win = LT_GetPlayerData(winSID)
	if player_win == nil then return end
	local player_lose = LT_GetPlayerData(loseSID)
	if player_lose == nil then return end
	local p_LTDataWin =  lt_get_mydata(winSID)
	if p_LTDataWin == nil then return end
	local p_LTDataLose =  lt_get_mydata(loseSID)
	if p_LTDataLose == nil then return end
	look('_lt_update_data 22')
	local win_tc = GetTimesInfo(winSID,TimesTypeTb.PK_Time)
	if win_tc == nil then return end
	local lose_tc = GetTimesInfo(loseSID,TimesTypeTb.PK_Time)
	if lose_tc == nil then return end
	
	-- 计算奖励
	local win_score,lose_score,win_sw,lose_sw,win_week,lose_week	
	if (win_tc[1] or 1) < 10 then
		win_score = 10		
		win_sw = 20			
	else
		win_score = 2		
		win_sw = 2			
	end
	if iType == 1 or iType == 2 then
		if (lose_tc[1] or 0) < 10 then
			lose_score = 5
			lose_sw = 20
		else
			lose_score = 1
			lose_sw = 1
		end
	end
	-- 加周积分
	win_week = sc_add(winSID,8,win_score,2)
	if lose_score then
		lose_week = sc_add(loseSID,8,lose_score,2)
	end
	-- 加声望
	AddPlayerPoints(winSID, 7, win_sw,nil,'竞技')
	if lose_sw then
		look('lose_sw:' .. lose_sw)
		AddPlayerPoints(loseSID, 7, lose_sw,nil,'竞技')
	end
	-- -- 给勋章
	-- PI_GiveGoodsEx(winSID,ltmailconf,1,2,win_xz,{{1052,win_xz,1},},nil,'竞技场给勋章')
	-- if lose_xz then
		-- PI_GiveGoodsEx(loseSID,ltmailconf,1,2,lose_xz,{{1052,lose_xz,1},},nil,'竞技场给勋章')
	-- end
	
	-- 更新胜利/失败场次
	player_win.win = (player_win.win or 0) + 1 
	player_win.lose = player_win.lose or 0
	player_lose.win = player_lose.win or 0
	player_lose.lose = (player_lose.lose or 0) + 1
	
	-- 更新每日次数
	CheckTimes(winSID,TimesTypeTb.PK_Time,1)		-- 只做统计
	CheckTimes(loseSID,TimesTypeTb.PK_Time,1)		-- 只做统计	

	-- 更新排行榜
	if win_week then
		lt_insert_list(winSID,win_week,rint(player_win.win/(player_win.win + player_win.lose)*100))
	end
	if lose_week then
		lt_insert_list(loseSID,lose_week,rint(player_lose.win/(player_lose.win + player_lose.lose)*100))
	end
	
	SendLuaMsg( winSID, { ids=LT_result }, 10 )
	SendLuaMsg( loseSID, { ids=LT_result, iType = iType }, 10 )	
end

-- iType = 0 正常结束 如果是观战人员 只清理观战列表
-- 1 名字 2 等级 3 战斗力 4 积分 5 礼券 6 职业 7 总积分 8 伤害输出 9 经验
local function _lt_lose(loseSID,iType)	
	local pub_data = lt_getpub()
	if pub_data == nil or pub_data.matchlist == nil then return end
	
	local tempLoser = LT_GetPlayertemp(loseSID)
	if tempLoser == nil then return end	
	
	local winSID = tempLoser.fitsid	-- 取对方sid
	if winSID == nil then
		return
	end	
	local tempWinner = LT_GetPlayertemp(winSID)
	if tempWinner == nil then return end
	
	if tempLoser.ltgid == nil or tempWinner.ltgid == nil or tempLoser.ltgid ~= tempWinner.ltgid then return end
	if pub_data.matchlist[tempLoser.ltgid] == nil then return end		
	
	local gid = tempLoser.ltgid
	-- 清理temp数据	
	tempLoser.fitsid = nil
	tempWinner.fitsid = nil
	tempLoser.ltgid = nil
	tempWinner.ltgid = nil
	
	-- 更新数据发送奖励
	_lt_update_data(winSID,loseSID,iType)
	
	-- 死亡帮他复活
	if iType == 1 then
		CI_OnSelectRelive(0,3*5,2,loseSID)
	end
	
	local win_ts = __G.PI_GetTsBaseData(winSID)
	local lose_ts = __G.PI_GetTsBaseData(loseSID)
	local win_dmg = CI_GetPlayerData(7,2,winSID)
	local lose_dmg = CI_GetPlayerData(7,2,loseSID)
	
	local tmatch = pub_data.matchlist[gid]				
	if tmatch.viewlist and type(tmatch.viewlist) == type({}) then		
		for m, n in pairs(tmatch.viewlist) do
			SendLuaMsg( n, { ids=LT_NoticeEnd, win_dmg = win_dmg, lose_dmg = lose_dmg, win_ts = win_ts, lose_ts = lose_ts }, 10 )
		end
	end
	SendLuaMsg( winSID, { ids=LT_NoticeEnd, win_dmg = win_dmg, lose_dmg = lose_dmg, lose_ts = lose_ts }, 10 )
	SendLuaMsg( loseSID, { ids=LT_NoticeEnd, win_dmg = win_dmg, lose_dmg = lose_dmg, win_ts = win_ts }, 10 )	

	pub_data.matchlist[gid] = nil	
end

-- flags 0 -- 点击离开按钮（客户端类离开消息） 1 -- 死亡 2 -- 时间到了 3 -- 切换场景 4-- 下线 5 -- 上线
local function _lt_exit(sid,flags)	
	--look('_lt_exit:' .. tostring(flags))
	local p_LTData =  lt_get_mydata(sid)
	if p_LTData == nil then return end	
	local temp = LT_GetPlayertemp(sid)
	if temp == nil then return end
	local pub_data = lt_getpub()
	if pub_data == nil or pub_data.matchlist == nil then return end
	if p_LTData.state == 0 and (temp.viewstate == nil or temp.viewstate == 0) then 		
		return 
	end
	if p_LTData.state == 1 then							-- 如果玩家在报名状态下离开场景或者下线		
		_lt_remove_field(sid)
	end		
	if temp.fitsid ~= nil or temp.ltgid ~= nil then		-- 如果战斗双方有人退出
		_lt_lose(sid,flags)
		if flags == 0 then
			local rd = math_random(1, #LTMapPos)
			local pos = LTMapPos[rd]
			if not PI_MovePlayer(LTRMAPID,pos[1],pos[2],0,2,sid) then
				look("_lt_exit faild")
			end	
		end
		return true										-- 保证只退出一次 _lt_lose会清理temp 所以客户端传消息退出的时候不会再进这个了
	end
	--look('_lt_exit 2:' .. tostring(flags))
	if temp.viewstate and temp.viewstate == 1 then		-- 观看者退出		
		if temp.viewgid and pub_data.matchlist[temp.viewgid] then
			if pub_data.matchlist[temp.viewgid].viewlist then
				local t = pub_data.matchlist[temp.viewgid].viewlist
				for k, v in pairs(t) do
					if v == sid then						
						table_remove(t,k)
					end
				end					
			end
		end
		local gid = temp.viewgid
		temp.viewstate = 0
		temp.viewgid = nil
		CI_SetPlayerData(2,0)		-- 取消隐身
		SendLuaMsg( 0, { ids=LT_viewstate, state = 0 }, 9 )		
		local pname = CI_GetPlayerData(5)	
		
		RegionRPC(gid,"lt_enter_view",pname,0)
	end
	--look('_lt_exit 3:' .. tostring(flags))	
	-- 有可能赢了也在里面死了
	if flags == 1 then
		CI_OnSelectRelive(0,3*5,2,sid)
	end
	local rx,ry,rid = CI_GetCurPos()
	if rid ~= LTRMAPID and p_LTData.state ~= 1 and flags ~= 1 and flags ~= 3  then			-- 非场景切换退出才PutPlayerTo		
		local rd = math_random(1, #LTMapPos)
		local pos = LTMapPos[rd]
		if not PI_MovePlayer(LTRMAPID,pos[1],pos[2],0,2,sid) then
			look("_lt_exit faild")
		end	
	end
	p_LTData.state = 0			-- 退出后统一清理状态数据
	p_LTData.regtime = 0
end

-- 时间到了 根据伤害输出及战斗力判定输赢
local function _lt_check(sidA,sidB,gid)	
	local tempA = LT_GetPlayertemp(sidA)
	if tempA == nil then
		return 
	end	
	if tempA.fitsid == nil or tempA.ltgid == nil then
		if __debug then look("tempA.fitsid == nil or tempA.ltgid == nil") end
		return
	end
	
	local tempB = LT_GetPlayertemp(sidB)
	if tempB == nil then 
		return 
	end	
	if tempB.fitsid == nil or tempB.ltgid == nil then
		if __debug then look("tempB.fitsid == nil or tempB.ltgid == nil") end
		return
	end
	
	if tempA.ltgid ~= gid or tempB.ltgid ~= gid then
		if __debug then look("tempA.ltgid ~= gid or tempB.ltgid ~= gid") end
		return
	end
	
	if tempA.fitsid ~= sidB or tempB.fitsid ~= sidA then
		if __debug then look("tempA.fitsid ~= sidB or tempB.fitsid ~= sidA") end
		return
	end
	
	local DamageA = CI_GetPlayerData(7,2,sidA)
	local DamageB = CI_GetPlayerData(7,2,sidB)
	local fightvalA = CI_GetPlayerData(62,2,sidA)
	local fightvalB = CI_GetPlayerData(62,2,sidB)
	if DamageA == DamageB and fightvalA == fightvalB then
		DamageA = DamageA + 1
	end
	if DamageA < DamageB then
		_lt_exit(sidA,2)
	elseif DamageA > DamageB then
		_lt_exit(sidB,2)
	else 
		if fightvalA < fightvalB then		
			_lt_exit(sidA,2)
		else
			_lt_exit(sidB,2)
		end		
	end	
end

-- flags 0 -- 点击离开按钮（客户端类离开消息） 1 -- 死亡 2 -- 时间到了 3 -- 切换场景 4-- 下线 5 -- 上线
local function _on_regionchange(self,sid)
	_lt_exit(sid,3)
end

-- 死亡直接复活(最终会调用场景切换)
local function _on_playerdead(self, sid, rid, mapGID, killerSID)	
	_lt_exit(sid,1)
	return 1
end

-- 复活处理
local function _on_playerlive(self, sid)
	local rd = math_random(1, #LTMapPos)
	local pos = LTMapPos[rd]
	if not PI_MovePlayer(LTRMAPID,pos[1],pos[2],0,2,sid) then
		look("_on_playerlive faild")
		return
	end	
	return 1
end

-- 时间到处理
local function _on_DRtimeout(self, mapGID, args)
	look('lt: _on_DRtimeout')
	local pub_data = lt_getpub()
	if pub_data == nil or pub_data.matchlist == nil or pub_data.matchlist[mapGID] == nil then return end
	local flist = pub_data.matchlist[mapGID].fightlist
	look(flist)
	if flist and flist[1] and flist[2] then
		_lt_check(flist[1][1],flist[2][1],mapGID)
	end
end

-- 上线处理
local function _on_login(self,sid)
	look(' lt_on_login  ')
end

-- 下线处理
local function _on_logout(self,sid)
	_lt_exit(sid,4)
end

-- 注册活动类函数(internal use)
local function _lt_register_func(active_lt)
	active_lt.on_regionchange = _on_regionchange
	active_lt.on_playerdead = _on_playerdead
	active_lt.on_playerlive = _on_playerlive
	active_lt.on_login = _on_login
	active_lt.on_logout = _on_logout
	active_lt.on_DRtimeout = _on_DRtimeout
	-- active_lt.on_active_end = _on_active_end	
end

-- 擂台竞技活动开始 
-- 世界等级45级以前不开放
local function _lt_start()	
	local wLevel = GetWorldLevel() or 1
	-- if wLevel < 45 then
		-- return
	-- end
	-- assert 1: 没结束之前不能开始
	local active_lt = activitymgr:get(active_name)
	if active_lt then
		look('lt_start has not end')		
		return
	end	
	-- 创建活动
	active_lt = activitymgr:create(active_name)
	if active_lt == nil then
		look('lt_start create erro')
		return
	end
	-- 注册活动类函数(internal use)
	_lt_register_func(active_lt)
		
	local pub_data = lt_getpub()
	if pub_data == nil then return end
	-- 广播活动开始
	BroadcastRPC('lt_start')
	SetEvent(10, nil, "GI_lt_matching")
end

-- 传送到报名地图
local function _lt_putinto_map(sid)
	local lv = CI_GetPlayerData(1)
	if lv and lv < 35 then
		return
	end
	local active_lt = activitymgr:get(active_name)
	if active_lt == nil then
		look('_lt_putinto_map active_lt == nil')		
		return
	end	
	-- local rx,ry,rid,mapGID = CI_GetCurPos()
	-- if mapGID and mapGID > 0 then		
		-- return
	-- end	
	local rd = math_random(1, #LTMapPos)
	local pos = LTMapPos[rd]
	if not PI_MovePlayer(LTRMAPID,pos[1],pos[2],0,2,sid) then
		look("_lt_putinto_map faild")
	end
end

-- 玩家报名 push到报名列表
function _lt_sign_up(sid)
	local temp = LT_GetPlayertemp(sid)
	if temp.fitsid ~= nil or temp.ltgid ~= nil then 		-- 匹配成功状态不能报名
		if __debug then look("temp.fitsid ~= nil or temp.ltgid ~= nil") end
		SendLuaMsg( 0, { ids=LT_RegComp, res = 4 }, 9 )
		return 
	end	
	-- assert 1: 判断活动是否已结束
	local active_lt = activitymgr:get(active_name)
	if active_lt == nil then 
		SendLuaMsg( 0, { ids=LT_RegComp, res = 1 }, 9 )
		return 
	end
	-- assert 2: 判断活动是否已结束
	local active_flags = active_lt:get_state()
	if active_flags == 0 then
		SendLuaMsg( 0, { ids=LT_RegComp, res = 1 }, 9 )
		return
	end
	
	local pub_data = lt_getpub()
	if pub_data == nil then return end
	look('-----------------')
	local p_ltData = lt_get_mydata(sid)
	if p_ltData == nil then return end
	look('+++++++++++++++++')	
	if p_ltData.state >= 1 then		-- 已经报名了
		SendLuaMsg( 0, { ids=LT_RegComp, res = 2 }, 9 )
		return 
	end
	local lv = CI_GetPlayerData(1)		-- 玩家等级
	if lv < 40 then
		SendLuaMsg( 0, { ids=LT_RegComp, res = 3 }, 9 )
		return
	end
	
	-- 取等级段
	local field = BASEFIELD + rint((lv - BASELV)/FIELDLEN) * FIELDLEN
	if lv >= BASEFIELD + ULIMIT then
		if lv == field + ULIMIT then
			local rd = math_random(1,100)		-- 50%几率放到高等级段
			if rd > 50 then
				field = field + FIELDLEN
			end
		elseif lv == field - ULIMIT then
			if lv ~= BASELV then
				local rd = math_random(1,100)		-- 50%几率放到低等级段
				if rd <= 50 then
					field = field - FIELDLEN
				end
			end
		end
	end
	
	p_ltData.state = 1	-- 报名状态
	p_ltData.regtime = GetServerTime()	
	if pub_data.fieldlist[field] == nil then
		pub_data.fieldlist[field] = {}
	end
	table_insert(pub_data.fieldlist[field],sid)
	look(pub_data.fieldlist)
	SendLuaMsg( 0, { ids=LT_RegComp, res = 0 }, 9 )
end

-- 取消报名
local function _lt_cancle(sid)		
	local p_ltData = lt_get_mydata(sid)
	if p_ltData == nil then return end
	local pub_data = lt_getpub()
	if pub_data == nil or pub_data.matchlist == nil or pub_data.fieldlist == nil then return end	
	if p_ltData.state == 1 then							-- 取消报名
		_lt_remove_field(sid)
	end
	if p_ltData.state == 2 then							-- 如果已经匹配成功不能取消报名		
		return
	end
	p_ltData.state = 0
	p_ltData.regtime = 0
	SendLuaMsg( 0, { ids=LT_Match, res = 2 }, 9 )
end

-- 匹配玩家算法
function _lt_matching()	
	local active_lt = activitymgr:get(active_name)
	if active_lt == nil then 
		look('_lt_matching active_lt == nil')
		return 
	end
	-- assert 1: 判断活动是否已结束
	local active_flags = active_lt:get_state()
	if active_flags == 0 then	
		look('_lt_matching active_flags == 0')
		return
	end
	-- look("_lt_matching")
	local pub_data = lt_getpub()
	if pub_data == nil or pub_data.fieldlist == nil or pub_data.matchlist == nil then 
		return 
	end
	local restlist = {}
	for k, v in pairs(pub_data.fieldlist) do
		if type(k) == type(0) and type(v) == type({}) then			
			while #v >= 2 do				
				local mtA = math_random(1,#v)
				local sidA = v[mtA]
				table_remove(v,mtA)				
				local mtB = math_random(1,#v)	
				local sidB = v[mtB]
				table_remove(v,mtB)
				local snA = CI_GetPlayerData(5,2,sidA)
				local snB = CI_GetPlayerData(5,2,sidB)
				if IsPlayerOnline(sidA) and IsPlayerOnline(sidB) then
					local gid = _lt_match_success(sidA,sidB)
					if gid == nil then 
						look("gid == nil")
					end
					
					SendLuaMsg( sidA, { ids=LT_Match, res = 1, name = snB }, 10 )
					SendLuaMsg( sidB, { ids=LT_Match, res = 1, name = snA }, 10 )							
					SetEvent(10,nil,'GI_lt_enter_ex',sidA,sidB,gid)
				elseif IsPlayerOnline(sidA) then 
					look("LT_Matching Erro")
					_lt_reset_player(sidA)
					SendLuaMsg( sidA, { ids=LT_Match, res = 0 }, 10 )
				elseif IsPlayerOnline(sidB) then 
					look("LT_Matching Erro")
					_lt_reset_player(sidB)
					SendLuaMsg( sidB, { ids=LT_Match, res = 0 }, 10 )								
				end								
			end
			if #v > 0 then				
				table_insert(restlist,k)
			end
		end
	end

	-- 落单的这里继续匹配	
	for k, v in pairs(restlist)	do
		if type(k) == type(0) and type(v) == type(0) then			
			for m, n in pairs(restlist) do
				if type(m) == type(0) and type(n) == type(0) then					
					-- if n == v + FIELDLEN or n == v - FIELDLEN then
					if n ~= v then
						local sidA = pub_data.fieldlist[v][1]
						local sidB = pub_data.fieldlist[n][1]
						restlist[k] = nil
						restlist[m] = nil
						table_remove(pub_data.fieldlist[v],1)
						table_remove(pub_data.fieldlist[n],1)
						local snA = CI_GetPlayerData(5,2,sidA)
						local snB = CI_GetPlayerData(5,2,sidB)
						if IsPlayerOnline(sidA) and IsPlayerOnline(sidB) then -- 这里再做一次在线判断 如果对方不在线提示匹配失败
							local gid = _lt_match_success(sidA,sidB)
							if gid == nil then 
								look("gid == nil")
							end
							
							SendLuaMsg( sidA, { ids=LT_Match, res = 1, name = snB }, 10 )
							SendLuaMsg( sidB, { ids=LT_Match, res = 1, name = snA }, 10 )							
							SetEvent(10,nil,'GI_lt_enter_ex',sidA,sidB,gid)	
						elseif IsPlayerOnline(sidA) then 
							look("LT_Matching Erro")
							_lt_reset_player(sidA)
							SendLuaMsg( sidA, { ids=LT_Match, res = 0 }, 10 )
						elseif IsPlayerOnline(sidB) then 
							look("LT_Matching Erro")
							_lt_reset_player(sidB)
							SendLuaMsg( sidB, { ids=LT_Match, res = 0 }, 10 )												
						end																																		
					end
				end
			end
		end
	end
	
	-- 如果还是没匹配到就是人品有问题了 如果他的报名时间过了30秒 发送匹配失败消息 让他重新报名
	for k, v in pairs(restlist)	do
		if type(k) == type(0) and type(v) == type(0) then			
			local sid = pub_data.fieldlist[v][1]
			local p_ltData = lt_get_mydata(sid)								
			if GetServerTime() - p_ltData.regtime >= 30 then	
				p_ltData.state = 0
				p_ltData.regtime = 0
				table_remove(pub_data.fieldlist[v],1)
				SendLuaMsg( sid, { ids=LT_Match, res = 0 }, 10 )				
			end
		end
	end
	
	-- local ltData = lt_getpub()	
	-- if ltData and ltData.cState == 0 then 			-- 结束后不能再匹配 清理列表
		-- for k, v in pairs(pub_data.fieldlist) do
			-- if type(k) == type(0) and type(v) == type({}) then				
				-- if #v > 0 then
					-- for m, n in pairs(v) do
						-- if type(m) == type(0) and type(n) == type(0) then
							-- local sid = n
							-- _lt_reset_player(sid)
							-- table_remove(pub_data.fieldlist[k],m)
							-- SendLuaMsg( sid, { ids=LT_Match, res = 0 }, 10 )
						-- end
					-- end
				-- end
			-- end
		-- end
		-- return 
	-- end
	
	SetEvent(10, nil, "GI_lt_matching")
end

-- 第一个进入的创建场景
function _lt_enter(sidA)
	local active_lt = activitymgr:get(active_name)
	if active_lt == nil then 
		look('_lt_enter active_lt == nil')
		return 
	end
	local pub_data = lt_getpub()
	if pub_data == nil or pub_data.matchlist ==nil then return end
	local a_temp = LT_GetPlayertemp(sidA)
	if a_temp == nil or a_temp.fitsid == nil then
		look("a_temp == nil or a_temp.fitsid")
		return
	end		
	local sidB = a_temp.fitsid
	local b_temp = LT_GetPlayertemp(sidB)
	if b_temp == nil or b_temp.fitsid == nil or b_temp.fitsid ~= sidA then		
		return 
	end	
	if a_temp.ltgid == nil or b_temp.ltgid == nil then
		return
	end
	local flist = pub_data.matchlist[a_temp.ltgid].fightlist
	if flist[1][1] == sidA then
		if not active_lt:add_player(sidA,1,0,19,24,a_temp.ltgid) then
			look("lt_enter fail 1")
			return
		end	
	else
		if not active_lt:add_player(sidA,1,0,27,37,a_temp.ltgid) then
			look("lt_enter fail 2")
			return
		end
	end
	-- 进入加满血量
	PI_PayPlayer(3,1000000,nil,nil,'竞技场',2,sidA)
end

local function _lt_sync_pos(sidA,sidB,gid)
	if sidA == nil or sidB == nil or gid == nil then return end
	local pub_data = lt_getpub()
	if pub_data == nil or pub_data.matchlist == nil then return end
	if pub_data.matchlist[gid] == nil then return end
	local ax,ay = CI_GetCurPos(2,sidA)
	local bx,by = CI_GetCurPos(2,sidB)
	local areaX,areaY
	if ax and ax > 0 and bx and bx > 0 then
		areaX = math_abs(rint(ax/8) - rint(bx/8))
		areaY = math_abs(rint(ay/8) - rint(by/8))
	end
	if (areaX and areaX > 1) or (areaY and areaY > 1) then
		RPCEx(sidB,'lt_sync_pos',ax,ay)	
		RPCEx(sidA,'lt_sync_pos',bx,by)
	end
	return 1
end

-- 这里肯定都传进去了 只是做一些状态判定
-- 也可以判定双方是否都已经传到竞技地图 如果没有 可以强制传送
local function _lt_enter_ex(sidA,sidB,gid)	
	local pub_data = lt_getpub()
	if pub_data == nil or pub_data.matchlist == nil then		
		return 
	end

	local a_temp = LT_GetPlayertemp(sidA)
	local b_temp = LT_GetPlayertemp(sidB)
	if a_temp == nil or b_temp == nil then
		if __debug then look("a_temp == nil or b_temp == nil") end		
		return
	end
	
	if a_temp.fitsid == nil or b_temp.fitsid == nil or a_temp.fitsid ~= sidB or b_temp.fitsid ~= sidA then		
		return
	end
	if a_temp.ltgid == nil or b_temp.ltgid == nil or a_temp.ltgid ~= b_temp.ltgid or a_temp.ltgid ~= gid then		
		return
	end
	
	pub_data.matchlist[a_temp.ltgid].bTime = GetServerTime()
	-- 每秒同步玩家坐标
	SetEvent(1,nil,'GI_lt_sync_pos',sidA,sidB,gid)
end

local function _lt_viewer_enter(sid,gid)
	look('_lt_viewer_enter')
	local pub_data = lt_getpub()
	if pub_data == nil or pub_data.matchlist == nil then return end
	local p_ltData = lt_get_mydata(sid)
	if p_ltData == nil then return end
	local temp = LT_GetPlayertemp(sid)
	if temp == nil then return end	
	if temp.viewstate and temp.viewstate == 1 then
		SendLuaMsg( 0, { ids=lt_enterView, res = 1 }, 9 )
		return 
	end
	if p_ltData.state > 0 then								-- 已经报名状态不能观战
		SendLuaMsg( 0, { ids=lt_enterView, res = 4 }, 9 )
		return 
	end
	
	if pub_data.matchlist[gid] == nil then 
		SendLuaMsg( 0, { ids=lt_enterView, res = 2 }, 9 )
		return 
	end
	if pub_data.matchlist[gid].viewlist == nil then
		pub_data.matchlist[gid].viewlist = {}
	end
	local active_lt = activitymgr:get(active_name)
	if active_lt == nil then return end
	if not active_lt:add_player(sid,1,0,29,28,gid) then	
		SendLuaMsg( 0, { ids=lt_enterView, res = 3 }, 9 )
		return
	end
	temp.viewstate = 1
	temp.viewgid = gid
	CI_SetPlayerData(2,1)		-- 设置隐身
	table_insert(pub_data.matchlist[gid].viewlist,sid)	
	SendLuaMsg( 0, { ids=lt_enterView, res = 0 }, 9 )
	local pname = CI_GetPlayerData(5)		
	RegionRPC(gid,"lt_enter_view",pname,1)	
end

-- 玩家请求面板信息
local function _lt_panel_info(sid)
	local waitcount = _get_report_count() or 0		
	SendLuaMsg( 0, { ids=LT_pData, wait = waitcount }, 9 )	
end

-- 发送观战列表 
local function _lt_send_viewlist(sid)
	look('_lt_send_viewlist')
	local pub_data = lt_getpub()
	if pub_data == nil or pub_data.matchlist == nil then return end
	look(pub_data.matchlist)
	local t = {}
	local count = 0
	for k, v in pairs(pub_data.matchlist) do
		if type(k) == type(0) and type(v) == type({}) then
			t[k] = v
			count = count + 1
			if count >= 10 then
				break
			end
		end
	end
	look(t)
	SendLuaMsg( 0, { ids=LT_viewlist, list = t }, 9 )
end

-- 每周重置
local function _lt_clear_week(sid)

end

-- 清理数据
local function _lt_clear_data(sid)
	local temp = LT_GetPlayertemp(sid)
	if temp == nil then
		return
	end
	if temp.fitsid then temp.fitsid = nil end
	if temp.ltgid then temp.ltgid = nil end
	if temp.viewstate then temp.viewstate = 0 end
	if temp.viewgid then temp.viewgid = nil end	
	local p_LTData =  lt_get_mydata(sid)
	if p_LTData == nil then return end
	p_LTData.state = 0
	p_LTData.regtime = 0
end

----------------------------------------------------
--interface:

lt_putinto_map = _lt_putinto_map
lt_start = _lt_start
lt_sign_up = _lt_sign_up
lt_cancle = _lt_cancle
lt_matching = _lt_matching
lt_enter =_lt_enter
lt_enter_ex = _lt_enter_ex 
lt_cancle = _lt_cancle
lt_exit = _lt_exit
lt_panel_info = _lt_panel_info
lt_send_viewlist = _lt_send_viewlist
lt_viewer_enter = _lt_viewer_enter
lt_clear_week = _lt_clear_week
lt_clear_data = _lt_clear_data
lt_sync_pos = _lt_sync_pos