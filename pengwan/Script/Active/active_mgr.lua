--	
--	活动数据管理，这里是一个公用的活动数据管理器：NPC，玩家，怪物
--	目前用到的活动有(活动视情况（比如多人活动）使用该模板)：
--

--[[
	version1
	不限时动态场景的奖励处理：刷新/掉线还在；下线就没了；  	在线不领一直等
	限时动态场景的奖励处理  ：刷新/掉线还在；下线就没了；	先传出去，再弹面板
	
	活动框架要接管的功能：
	[1] 活动数据（同步/不同步）
	[2] 动态场景管理：创建/房间维护/销毁（房间倒计时，结束时立即销毁）/进入/退出
	[3] 玩家： 下线/刷新上线（初始化活动数据）/切换场景/死亡/玩家活动数据（是否可以独立出来？）
	[4] 怪物： 创建/删除/怪物全部死亡回调
	[5] NPC：  创建/删除
	
	_activity_entity = {
		mgr =>
		userdata = {},
		player={},
		name =	activename,
	}
	
	version2
	I  承载的功能
	
	1 提供统一的功能入口： 上线/刷新/下线/死亡/切换场景/初始化/进入/退出
	2 动态场景的管理：创建/销毁/定时
	3 房间管理
	4 活动数据的管理
	
	II 承载的活动类型
	
	1 非时间类的活动
		[1]参数 （活动时间 = nil ）（不支持房间管理）
		[2]数据：
			->需要动态场景
				(*场景必须为自动删除类场景*)(场景倒计时<90)
				清理数据：（OnRegionDelete）				
					player（玩家离开活动清理、即玩家下线/切换场景）
					data（OnRegionDelete清理）
					如果有场景倒计时回调 --> 删除场景
			->不需要动态场景
				看需要放入这个框架
				清理数据：
					player(玩家离开活动清理、即玩家下线/切换场景)
					data（暂时应该没有数据）
		[]举例：降魔录/排位赛/偷袭/擂台赛/宝石副本
	  
	2 时间类的活动
		[1]参数 （活动时间不为空：活动的结束是由框架接管，并进行清理数据）（活动时间 <90）
		[2]数据：
			->需要动态场景
				(*不能有场景倒计时*)
				data（活动结束定时清理）
				room (只提供内部使用、不提供外部调用接口)
				player（活动结束定时清理）
			->不需要动态场景
				data（活动结束定时清理）
				player（活动结束定时清理）
	
	  []举例：qsls
	  
	  统一管理：超过90分钟的动态场景统一删
	  
	  玩家请求进入动态场景（包括副本）需要判断不能进入两次
	  玩家进入动态场景失败的处理：时间类活动等待时间结束；非时间类活动，如果是没有倒计时的动态场景，则直接删除场景
	  
	  确保玩家活动标识的清除：非定时的活动（下线/切场景/外部调用） ； 定时的活动（下线/切场景/场景删除）
	  定时的活动又没有动态场景的活动标识的清除：addplayer就要记玩家
	  
]]

---------------------------------------------------------------------------
--include:
local TP_FUNC = type( function() end)
local pairs,ipairs,type = pairs,ipairs,type
local tostring = tostring
local setmetatable = setmetatable
-- local __G = _G

local __debug = __debug
local RPC = RPC
local RPCEx = RPCEx
local look = look
local rint = rint
local uv_DRList = DRList
local SetEvent = SetEvent
local ClrEvent = ClrEvent
local GetServerTime = GetServerTime
local CI_GetCurPos = CI_GetCurPos
local PI_CreateRegion = PI_CreateRegion
local PI_MovePlayer = PI_MovePlayer
local GI_SetPlayerPrePos = GI_SetPlayerPrePos
local GI_ExitToPrePos = GI_ExitToPrePos
local GetRegionPlayerCount = GetRegionPlayerCount
local CreateObjectIndirect = CreateObjectIndirect
local PI_MapTrap=PI_MapTrap
local tablepush=table.push
local BroadcastRPC=BroadcastRPC
local CI_DeleteDRegion=CI_DeleteDRegion
local TipCenter = TipCenter
local GetStringMsg = GetStringMsg
local _random=math.random
local CI_GetPlayerData=CI_GetPlayerData
local Log=Log
local IsSpanServer = IsSpanServer

local uv_TrapInfo = {0,0,0,0}
----------------------------------------------------------------------------
-- module:

module(...)

----------------------------------------------------------------------------
--inner:

-- 一个活动的数据存储实体
_activity_entity = {
	new = function(self, mgr, name)		
		if mgr == nil or name == nil then 
			look('_activity_entity new:' .. tostring(name) .. ' param erro')
			return 
		end
		
		-- 基本活动配置判断
		if uv_DRList[name] == nil then
			look('_activity_entity new:' .. tostring(name) .. ' config erro[1]')
			return
		end		
		
		local actconf = uv_DRList[name]		
		
		-- 1、非时间类活动不支持分房间处理
		if actconf.actTimer == nil and (actconf.partRM or actconf.enterRM) then
			look('_activity_entity new:' .. tostring(name) .. ' config erro[2]')
			return
		end
		-- 2、对于时间类活动必须同时配置 actTimer 和 clrTimer 两个参数
		if (actconf.actTimer and actconf.clrTimer == nil) or (actconf.actTimer == nil and actconf.clrTimer) then
			look('_activity_entity new:' .. tostring(self.name) .. ' config erro[3]')
			return
		end
		-- 3、clrTimer 暂定不能超过10分钟
		if actconf.clrTimer and actconf.clrTimer > 10 * 60 then
			look('_activity_entity new:' .. tostring(self.name) .. ' config erro[4]')
			return
		end
		-- 4、bSpan 判断是否为跨服
		if actconf.bSpan then
			if not IsSpanServer() then
				look('_activity_entity new:' .. tostring(self.name) .. ' config erro[5]')
				return
			end
		end		
		-- 5、不能同时有partRM 和 enterRM
		if actconf.partRM and actconf.enterRM then
			look('_activity_entity new:' .. tostring(self.name) .. ' config erro[6]')
			return
		end
		
		-- 这里只初始化基本数据
		local o = { mgr = mgr, name = name, data = {}, flags = 1 }

		setmetatable(o, self)
		self.__index = self
		
		-- 对于时间类活动、启动活动定时器
		if actconf.actTimer then
			-- if actconf.actTimer > 90 * 60 then	-- 活动时间暂定不能超过90分钟
				-- look('_activity_entity new:' .. tostring(self.name) .. ' config erro[5]')
				-- return
			-- end			
			o.data.pub = {}										-- 只有时间类活动才有pub数据
			o.data.pub.atm = GetServerTime() + actconf.actTimer	-- 记录一个结束时间
		
			SetEvent( actconf.actTimer, nil, "GI_OnActiveEnd", name)
		end
		return o
	end,
	
	-- 创建活动动态场景(支持一个自定义回传参数/用于场景倒计时回传)
	-- 个人触发的创建动态场景需要传sid(这个只能在外面保证了)
	createDR = function(self,DRNum,tMapID,sid,args)
		if self.name == nil then return end
		if uv_DRList[self.name] == nil or uv_DRList[self.name][DRNum] == nil then
			look('createDR:' .. tostring(self.name) .. ' config erro')
			return
		end
		local actconf = uv_DRList[self.name]
		local dyconf = actconf[DRNum]
		local mapID = tMapID or dyconf.tMapID	-- 如果有自定义传入以传入的mapid为准
		if mapID == nil then
			look('createDR:' .. tostring(self.name) .. ' tMapID erro')
			return
		end
		-- 必须要有场景管理配置！！！
		if dyconf.bManual == nil or (dyconf.bManual ~= 0 and dyconf.bManual ~= 1) then
			look('createDR:' .. tostring(self.name) .. ' bManual erro')
			return
		end
		
		-- 配置的基本规则判断
		-- 1、对于非时间类的活动场景必须为自动删除类场景或者有场景倒计时		
		if actconf.actTimer == nil and (dyconf.bManual == 1 and dyconf.cTimer == nil) then
			look('createDR:' .. tostring(self.name) .. ' param erro[1]')
			return
		end					
		-- 2、对于时间类活动并且有动态场景倒计时的 clrTimer 必须在[cTimer+60,cTimer+5*60] 这个区间
		if actconf.actTimer and actconf.clrTimer and dyconf.cTimer then
			--look(actconf.clrTimer)
			--look(dyconf.cTimer)
			if (actconf.clrTimer < dyconf.cTimer + 60) or (actconf.clrTimer > dyconf.cTimer+5*60) then
				look('createDR:' .. tostring(self.name) .. ' param erro[2]')
				return
			end
		end
		-- 3、对于时间类活动并且有动态场景倒计时的 不能配置 partRM
		if actconf.actTimer and dyconf.cTimer then
			if actconf.partRM then
				look('createDR:' .. tostring(self.name) .. ' param erro[3]')
				return
			end
		end
		
		-- 创建动态场景之前先判断是否限制动态场景传动态场景
		-- 现在仅仅限制了不能同时创建两个相同地图ID的动态场景
		if sid then
			local rx, ry, rid, mapGID = CI_GetCurPos(2,sid)
			if mapGID and rid == mapID then			-- 在动态场景不能创建动态场景
				look('createDR:' .. tostring(self.name) .. ' when player in dr')
				return
			end
		end
		-- 开始创建动态场景		
		local mapGID = PI_CreateRegion(mapID, -1, dyconf.bManual, self.name)	
		if mapGID == nil then
			look('createDR:' .. tostring(self.name) .. ' mapGID erro')
			return
		end

		-- 暂时简单支持配置陷进点
		if dyconf.traps and type(dyconf.traps) == type({}) then
			for _, v in pairs(dyconf.traps) do
				
				uv_TrapInfo[2]=v[1]
				uv_TrapInfo[3]=v[2]
				uv_TrapInfo[4]=mapGID
				PI_MapTrap(2,uv_TrapInfo,100000+v[4],v[3])
			end
		end
		
		-- 根据datatype初始化数据
		if actconf.dataType then
			if rint((actconf.dataType / 10) )% 10 == 1 then	-- 记录活动场景数据
				self.data[mapGID] = {}
			end			
		end		
		
		-- 需要处理场景删除(时间类活动并且有partRM)
		if actconf.actTimer and (actconf.partRM or actconf.enterRM) then	
			self.room = self.room or {}
			tablepush(self.room,{mapGID,0,0})						
		end	
		-- 有分房间处理
		if self.room then
			BroadcastRPC('ROM_Notice',self.name,self.room)
		end
		-- 设置场景倒计时
		if dyconf.cTimer then
			self.data[mapGID] = {}
			if self.data[mapGID].cTimer then		-- 如果之前有计时器没有清除(可能会有问题)
				look("createDR: cTimer pre_timer not clear")
			end
			local dpos = dyconf.DelPos
			if dpos then
				self.data[mapGID].cTimer = SetEvent( dyconf.cTimer, nil, "GI_OnDRTimeOut", self.name, mapGID, args, dpos[1], dpos[2], dpos[3])
			else
				self.data[mapGID].cTimer = SetEvent( dyconf.cTimer, nil, "GI_OnDRTimeOut", self.name, mapGID, args )
			end
			-- self.data[mapGID].btm = GetServerTime()	-- 记录场景开始时间
		end
		
		-- 调用自定义处理函数
		if type(self.on_regioncreate) == 'function' then
			self:on_regioncreate(mapGID,args)
		end
		
		-- 返回一个GID作为外部判断
		return mapGID
	end,
	
	-- 获取活动分房间类型
	-- 0 不分房间 1 按当前房间人数 2 按房间历史进入人数
	get_part_type = function(self)
		if self.name == nil then 
			return 0 
		end
		if uv_DRList[self.name] == nil then
			look('check_createNewDR:' .. tostring(self.name) .. ' config erro')
			return 0
		end
		local actconf = uv_DRList[self.name]
		
		if type(actconf.partRM) == type({}) and #actconf.partRM == 2 then
			return 1
		end
		
		if type(actconf.enterRM) == type({}) and #actconf.enterRM == 2 then
			return 2
		end
		
		return 0
	end,
	
	-- 检查并判断是否创建新场景
	check_createNewDR = function(self,DRNum)
		if self.name == nil then return end
		if uv_DRList[self.name] == nil or uv_DRList[self.name][DRNum] == nil then
			look('check_createNewDR:' .. tostring(self.name) .. ' config erro')
			return
		end
		local actconf = uv_DRList[self.name]
		local dyconf = actconf[DRNum]

		local part_type = self:get_part_type()
		if part_type == 0 then
			return
		end
		
		local rmData = self.room
		if rmData == nil then return end
		
		-- 判断房间上限
		if actconf.limit and actconf.limit >= #rmData then
			look('check_createNewDR room is limit')
			return
		end
		
		local bNeed = true
		local bSend = false
		if part_type == 1 then
			for _, v in ipairs(rmData) do
				if type(v) == type({}) then
					local gid = v[1]
					local num = GetRegionPlayerCount(gid)
					if num >= actconf.partRM[1] and v[2] == 0 then		-- 更新房间状态
						v[2] = 1
						bSend = true
					elseif num < actconf.partRM[2] and v[2] == 1 then		-- 更新房间状态
						v[2] = 0
						bSend = true
					end
					if num < actconf.partRM[2] then
						bNeed = false
					end
				end
			end
		elseif part_type == 2 then
			for _, v in ipairs(rmData) do
				if type(v) == type({}) then
					local num = v[3] or 0
					if num >= actconf.enterRM[1] and v[2] == 0 then		-- 更新房间状态
						v[2] = 1
						bSend = true
					elseif num < actconf.enterRM[2] and v[2] == 1 then		-- 更新房间状态
						v[2] = 0
						bSend = true
					end
					if num < actconf.enterRM[2] then
						bNeed = false
					end
				end
			end
		end
		
		-- 需要创建新房间
		if bNeed then
			if self:createDR(DRNum) then
				bSend = true
			end
		end
		if bSend then
			BroadcastRPC('ROM_Notice',self.name,rmData)
		end
	end,

	-- 向某个活动中添加一个玩家
	-- 支持固定场景:
	--		regionID [nil] 该活动没有场景 [~=0] 固定场景 [==0] 动态场景此时mapGID才有用
	--		mapGID [nil] 随机进入当前活动动态场景 [~=nil] 进入指定GID的动态场景
	add_player = function(self, sid, DRNum, regionID, x, y, mapGID)
		-- look('向某个活动中添加一个玩家')
		if sid == nil or DRNum == nil or self.name == nil then
			return end
		-- 对于没有活动场景要求的直接添加到活动
		if regionID == nil then
			-- 添加玩家到活动
			self.mgr:_p2a_add(sid, self.name)
			-- look('oself.mgr:_p2a_add(sil')
			return
		end
		if regionID == 0 and mapGID == nil then look('regionID == 0 and mapGID == nil') return end
		if uv_DRList[self.name] == nil or uv_DRList[self.name][DRNum] == nil then
			look('add_player:' .. tostring(self.name) .. ' config erro[1]')
			return
		end		
		local actconf = uv_DRList[self.name]
		local dyconf = actconf[DRNum]
		
		-- 取进入场景地点
		local enterX = x
		local enterY = y
		if x == nil or y == nil then
			local pos = dyconf.EnterPos
			if dyconf.EnterPos == nil then
				look('add_player:' .. tostring(self.name) .. ' config erro[2]')
				return 
			end
			if type(dyconf.EnterPos[1]) == type({}) then
				pos = dyconf.EnterPos[_random(1,#dyconf.EnterPos)]
			end
			enterX = pos[1]
			enterY = pos[2]
		end
		-- look('enterX:' .. enterX)
		-- look('enterY:' .. enterY)
		-- 设置退出位置
		if dyconf.BackPos == nil then
			GI_SetPlayerPrePos(sid)
		else
			GI_SetPlayerPrePos(sid,dyconf.BackPos[1],dyconf.BackPos[2],dyconf.BackPos[3])
		end
		-- 取动态场景当前人数
		local count = GetRegionPlayerCount(mapGID) or 0
		-- 动态场景才支持分房间
		if regionID == 0 and actconf.partRM and type(actconf.partRM) == type({}) and #actconf.partRM == 2 then
			if mapGID == nil or self.room == nil then
				look('mapGID == nil or self.room == nil')
				return
			end
			
			-- 可以尝试遍历房间查找是否有此mapGID、防止前台传入错误的mapGID(暂时不处理)
			-- 现在需要记录房间进入总人数，所以必须要遍历房间找到房间编号
			local roomID = 0		-- 房间编号
			local tempGID = nil		-- 记录临时GID
			for k, v in ipairs(self.room) do
				if type(v) == type({}) then
					local gid = v[1]
					if gid and gid > 0 then
						if mapGID == 0 then			-- 查找空房间
							local ct = GetRegionPlayerCount(gid) or 0 
							if ct < actconf.partRM[1] then
								count = ct
								tempGID = gid
								roomID = k								
								break
							end
						else
							if mapGID == gid then	-- 如果查找到当前房间
								tempGID = gid
								roomID = k
								break
							end
						end
					end
				end
			end
			-- 如果没找到合适的房间
			if tempGID == nil then	
				TipCenter(GetStringMsg(449))
				return
			end
			
			-- 房间人数判断
			if count >= actconf.partRM[1] then
				if not IsSpanServer() then 
					TipCenter(GetStringMsg(449))
					return
				else
					RPCEx(sid,'add_player',roomID)
				end
			end
			-- 指向先前查找好的空房间或者原始传入GID
			mapGID = tempGID
			
			-- move player
			local res=PI_MovePlayer(regionID,enterX,enterY,mapGID,2,sid)
			if not res then
				look('DR_PutPlayerTo err:'..tostring(regionID)..','..tostring(enterX)..','..tostring(enterY)..','..tostring(mapGID))
				if mapGID and dyconf.bManual == 0 and count == 0 then		-- put失败了如果是自动删除的场景并且当前场景人数为0 删除场景
					CI_DeleteDRegion(mapGID,1)
				end
				return
			else
				-- 判断是否还有房间未超过分房条件、否则创建新房间
				if count + 1 >= actconf.partRM[2] then		
					self:check_createNewDR(DRNum)
				end
			end
		-- 按历史进入人数分房间
		elseif regionID == 0 and actconf.enterRM and type(actconf.enterRM) == type({}) and #actconf.enterRM == 2 then
			if mapGID == nil or self.room == nil then
				look('mapGID == nil or self.room == nil')
				return
			end
			
			-- 可以尝试遍历房间查找是否有此mapGID、防止前台传入错误的mapGID(暂时不处理)
			-- 现在需要记录房间进入总人数，所以必须要遍历房间找到房间编号
			local roomID = 0		-- 房间编号
			local tempGID = nil		-- 记录临时GID
			for k, v in ipairs(self.room) do
				if type(v) == type({}) then
					local gid = v[1]
					if gid and gid > 0 then
						if mapGID == 0 then			-- 查找空房间
							local ct = v[3] or 0 
							if ct < actconf.enterRM[1] then
								count = ct
								tempGID = gid
								roomID = k								
								break
							end
						else
							if mapGID == gid then	-- 如果查找到当前房间
								count = v[3] or 0
								tempGID = gid
								roomID = k
								break
							end
						end
					end
				end
			end
			-- 如果没找到合适的房间
			if tempGID == nil then	
				TipCenter(GetStringMsg(449))
				return
			end
			
			-- 房间人数判断
			if count >= actconf.enterRM[1] then
				if not IsSpanServer() then 
					TipCenter(GetStringMsg(449))
					return
				else
					RPCEx(sid,'add_player',roomID)
				end
			end
			-- 指向先前查找好的空房间或者原始传入GID
			mapGID = tempGID
			
			-- move player
			local res=PI_MovePlayer(regionID,enterX,enterY,mapGID,2,sid)
			if not res then
				look('DR_PutPlayerTo err:'..tostring(regionID)..','..tostring(enterX)..','..tostring(enterY)..','..tostring(mapGID))
				if mapGID and dyconf.bManual == 0 and count == 0 then		-- put失败了如果是自动删除的场景并且当前场景人数为0 删除场景
					CI_DeleteDRegion(mapGID,1)
				end
				return
			else
				-- 判断是否还有房间未超过分房条件、否则创建新房间
				self.room[roomID][3] = (self.room[roomID][3] or 0) + 1
				if count + 1 >= actconf.enterRM[2] then		
					self:check_createNewDR(DRNum)
				end
			end
		else		
			if not PI_MovePlayer(regionID,enterX,enterY,mapGID,2,sid) then
				look('DR_PutPlayerTo err:'..tostring(regionID)..','..tostring(enterX)..','..tostring(enterY)..','..tostring(mapGID))
				if mapGID and dyconf.bManual == 0 and count == 0 then		-- put失败了如果是自动删除的场景并且当前场景人数为0 删除场景
					CI_DeleteDRegion(mapGID,1)
				end
				return			
			end
		end
		-- 是否记录场景历史最高的人数(必须配置dataType = 10 or 110)
		if dyconf.HistoryMax then		-- 现在还没用到暂不处理!!!
			
		end

		-- 记录房间玩家进入数(离开不会减)
		if actconf.enterNum and self.room and self.room[roomID] then
			self.room[roomID][3] = (self.room[roomID][3] or 0) + 1
		end
		-- 添加玩家到活动
		self.mgr:_p2a_add(sid, self.name)

		-- if mapGID and self.data[mapGID] then
			-- RPCEx(sid,'region_btm',self.name,self.data[mapGID].btm)
		-- end

		return true,mapGID
	end,
	
	-- 从动态场景退出
	back_player = function(self, sid)
		if self:is_active(sid) then
			GI_ExitToPrePos(sid)
			return true
		end
		return false
	end,
	
	-- 	从某个活动中移除一个玩家(internal use)
	remove_player = function(self, sid)
		if sid == nil then return end
		if uv_DRList[self.name] == nil then
			look('remove_player:' .. tostring(self.name) .. ' config erro')
			return
		end
		local actconf = uv_DRList[self.name]		
	--	look('actconf.NoClearP:' .. actconf.NoClearP)
		-- 根据配置判断是否清除玩家数据
		if actconf.NoClearP == nil and self.player and self.player[sid] then			
			self.player[sid] = nil			-- 清除玩家数据
		end
		-- 清除活动标志
		self.mgr:_p2a_remove(sid, self.name)	
	end,
	
	-- 获取活动标志
	get_state = function(self)
		return self.flags or 0
	end,
	
	-- 设置活动标志
	set_state = function(self,state)
		self.flags = state or 0
	end,
	
	-- 获取场景历史最高人数(暂未实现！！！)
	get_player_cnt = function( self, mapGID )
		-- if mapGID and self.data and self.data[mapGID] then
			-- return self.data[mapGID].player_cnt
		-- end
	end,
	
	-- 获取房间编号
	get_room_id = function (self, mapGID)
		if mapGID and type(self.room) == type({}) then
			for k, v in ipairs(self.room) do
				if type(v) == type({}) then
					if v[1] == mapGID then
						return k
					end
				end
			end
		end
	end,
	
	-- 时间类活动公用数据
	get_pub = function(self)
		if self.data then
			return self.data.pub
		end
	end,
	
	-- 获取活动regiondata的接口
	-- 只支持取场景数据防止外部任意添加数据造成数据清理不到
	get_regiondata = function(self, mapGID)		
		if mapGID and self.data then
			return self.data[mapGID]
		end
	end,
	
	-- 清除活动regiondata接口(internal use)
	clear_regiondata = function(self, mapGID)
		if mapGID and self.data and self.data[mapGID] then
			-- 清除场景倒计时
			if self.data[mapGID].cTimer then
				ClrEvent(self.data[mapGID].cTimer)		
			end
			-- 清理场景数据
			self.data[mapGID] = nil
		end
	end,

	-- 获取活动中玩家data的接口
	get_mydata = function( self, sid )
		local actconf = uv_DRList[self.name]
		-- 必须有配置actTimer的才能调用此函数
		if actconf == nil or actconf.dataType == nil then
			look("get_mydata : config erro[1]")
			return
		end		
		if rint((actconf.dataType / 100) )% 10 == 1 then	-- 记录玩家数据
			self.player = self.player or {}
		end
		if sid and self.player then
			self.player[ sid ] = self.player[ sid ] or {}
			return self.player[ sid ]
		end
	end,
	
	-- clear player data
	clear_mydata = function(self,sid)
		if self.player and self.player[sid] then
			self.player[sid] = nil
		end
	end,	

	-- 清除玩家活动标志(提供给外部调用的接口)
	clear_flags = function(self,sid)
		self.mgr:_p2a_remove(sid, self.name)
	end,
	
	-- 判断玩家是否在该活动(提供给外部调用的接口)
	is_active = function(self,sid)
		return self.mgr:is_playerin(sid, self.name)
	end,
	
	-- clearAll(internal use)
	-- 为避免手动调用这个函数造成数据错误、判断一下这个活动的配置
	clearAll = function(self)
		if uv_DRList[self.name] == nil then
			look('_activity_entity clearAll:' .. tostring(self.name) .. ' config erro[1]')
			return
		end
		local actconf = uv_DRList[self.name]
		--local dyconf = actconf[DRNum]
		
		-- 必须有配置actTimer的才能调用此函数
		if actconf.actTimer == nil then
			look("_activity_entity clearAll: config erro[2]")
			return
		end		

		-- 如果有动态场景、清除所有玩家
		if self.room then
			--look('活动结束,清除所有玩家')
			for _, v in ipairs(self.room) do
				if type(v) == type({}) then
					CI_DeleteDRegion(v[1],1)
				end
			end
		end
		self.data = nil
		self.room = nil
		self.player = nil
	end,	
	
	-- 场景遍历操作
	traverse_region = function(self, f, args)
		if self.room and type(f)==TP_FUNC then
			for _, v in ipairs(self.room) do
				if type(v) == type({}) then
					f( v[1], args)
				end
			end
		end
	end,
	
	--	遍历并对每个玩家执行一个相同的操作
	traverse_player = function(self,  f )
		if type(f)==TP_FUNC then
		    local old_sid = CI_GetPlayerData(17)		-- 保存当前玩家 SID
			for sid, mydata in pairs(self.player) do
				if 1==SetPlayer( sid, 1, 1 ) then
					 f(sid, mydata )
				end
			end
			SetPlayer( old_sid, 1, 1)
		end
	end,
	
	--遍历对每个怪物执行相同的操作
	traverse_monster = function(self, f, regionid)
	end,
	
	--遍历对每个npc执行相同操作
	traverse_npc = function(self,f)		
	end,
	
	-- create monster
	create_monster = function(self, monconf, extra)
		local gid = CreateObjectIndirect( monconf )
	end,
	
	-- create npc
	create_npc = function(self,mapid,npcconf)
		local gid  = CreateObjectIndirect(npcconf)
	end,
}

--活动数据管理器
local _activity_mgr = 
{
	new = function(self)
		local o = { actives = {}, p2a = {} }

		setmetatable(o, self)
		self.__index = self

		return o
	end,

	-- 创建一个活动
	create = function(self, name, reset)
		if not self:is_has(name) then
		    local o = _activity_entity:new( self, name )
			self.actives[name] = o
			return o
		end
		-- **重置的时候保留data/player下的数据
		if reset then		
			local Activity = self:get(name)
			local aData = Activity.data
			local aPlayer = Activity.player
			local o = _activity_entity:new( self, name )			
			o.data = aData			
			o.player = aPlayer
			self.actives[name] = o					
			return o
		end		
	end,

	-- 根据名字返回活动
	get = function( self, name )
		return self.actives[ name ]
	end,

	-- 判断是否已有这个活动
	is_has = function(self, name)
		return self.actives[name] ~= nil
	end,
	
	--internal use
	_p2a_add = function( self, sid, name )
		--look('_p2a_add')
		if nil==self.p2a[sid] then
			self.p2a[sid] = {}
		end

		-- 为了避免过多引用、暂时设置状态为1
		self.p2a[sid][name] = 1
	end,
	
	--internal use
	_p2a_remove = function(self, sid, name)		
		if self.p2a[sid] and self.p2a[sid][name] then	
			self.p2a[sid][name] = nil
		end
	end,
	
	-- 	判断某个玩家是否处于某个活动中(internal use)
	is_playerin = function(self, sid, name)
		return self.p2a[sid] ~= nil and self.p2a[sid][name] ~= nil
	end,

	get_actives = function( self, sid )
		return self.p2a[sid]
	end,	

	-- 用于定时结束的动态场景(活动框架内部调用)
	clearAll = function(self, name)			
		if self.actives[ name ] then	
			-- 首先调用每个活动自定义结束处理
			if type(self.actives[name].on_clear_data) == 'function' then
				self.actives[name]:on_clear_data()
			end
			
			local Activity = self.actives[ name ]
			Activity:clearAll()	
			
			-- 清除活动数据
			self.actives[ name ] = nil
		end		
	end,
	
	-- 清除场景数据
	clear_regiondata = function(self, name, gid)
		if self.actives[ name ] then
			self.actives[ name ]:clear_regiondata(gid)
		end
	end,
	
	-- 场景倒计时回调
	on_DRtimeout = function(self, name, mapGID, args)
		if self.actives[name] then
			-- 自定义场景倒计时回调处理
			--look('--------------------on_DRtimeout---------------------------')
			if type(self.actives[name].on_DRtimeout) == 'function' then
				self.actives[name]:on_DRtimeout(mapGID,args)
			end
		end
	end,
	
	-- 场景删除回调
	on_regiondelete = function(self,name,RegionID,mapGID)
		if self.actives[name] then
			-- 活动自定义场景删除回调函数
			if type(self.actives[name].on_regiondelete) == 'function' then
				self.actives[name]:on_regiondelete(RegionID,mapGID)
			end
		end
	end,
	
	-- 场景怪物全部死亡回调
	on_monDeadAll = function(self,mapGID,name)
		if mapGID == nil or name == nil then return end
		if self.actives[name] then
			if type(self.actives[name].on_monDeadAll) == 'function' then
				self.actives[name]:on_monDeadAll(mapGID)
			end
		end		
	end,
	
	-- 玩家死亡处理
	on_playerdead = function( self, sid, rid, mapGID, killerSID )
		--look('-----------on_playerdead-------')
		local bret = 0
		if self.p2a[sid] then
			for name in pairs(self.p2a[sid]) do
				if self.actives[name] then
					if type(self.actives[name].on_playerdead) == 'function' then
						bret = self.actives[name]:on_playerdead(sid, rid, mapGID, killerSID) or 0
					end
				end
			end
		end
		return bret		-- 需要根据这个值判断是否返回
	end,
	
	-- 玩家复活处理
	on_playerlive = function( self, sid )
		--look('-----------on_playerlive-------')
		local bret = 0
		if self.p2a[sid] then
			for name in pairs(self.p2a[sid]) do
				if self.actives[name] then
					if type(self.actives[name].on_playerlive) == 'function' then
						bret = self.actives[name]:on_playerlive(sid) or 0
					end
				end
			end
		end
		return bret		-- 需要根据这个值判断是否返回
	end,
	
	-- 玩家切换场景处理
	on_regionchange = function( self, sid )
		if self.p2a[sid] then
			for name in pairs(self.p2a[sid]) do
				-- look('name:' .. name)
				if self.actives[name] then
					-- 活动自定义场景切换处理函数
					if type(self.actives[name].on_regionchange) == 'function' then
						bret = self.actives[name]:on_regionchange(sid)
					end
					
					-- 从活动移除玩家
					self.actives[name]:remove_player(sid)
				end
			end
			self.p2a[sid] = nil		-- 清除所有活动标志
		end				
	end,
	
	-- 玩家下线处理
	on_logout = function( self, sid )
		if self.p2a[sid] then
			for name in pairs(self.p2a[sid]) do
				if self.actives[name] then
					-- 活动自定义下线处理函数
					if type(self.actives[name].on_logout) == 'function' then
						self.actives[name]:on_logout(sid)
					end

					-- 从活动移除玩家
					self.actives[name]:remove_player(sid)
				end
			end
			self.p2a[sid] = nil
		end		
	end,
	
	-- 玩家上线处理
	on_login = function ( self, sid )
		--look('-----------on_login--------------')
		if self.p2a[sid] then
			for name in pairs(self.p2a[sid]) do	
				if self.actives[name] then
					if type(self.actives[name].on_login) == 'function' then
						self.actives[name]:on_login(sid)
					end					
				end
			end			
		end
		-- 活动还没结束并且有房间信息 需要发送给玩家
		for name, Activity in pairs(self.actives) do
			--look('active name:' .. tostring(name))
			if Activity:get_state() ~= 0 then
				local pub = Activity.data.pub
				local atm
				if type(pub) == type({}) and pub.atm ~= nil then
					atm = pub.atm
				end				
				RPC('Active_online',name,Activity.room,atm)
			end
		end		
	end,
}

----------------------------------------------------------
--interface:

-- 活动框架初始化
activitymgr = activitymgr or _activity_mgr:new()

-- 排位赛
active_marank = active_marank or activitymgr:create('MaRank')
-- 庄园掠夺
active_marobb = active_marobb or activitymgr:create('MaRobb')
-- 降魔录
active_xml = active_xml or activitymgr:create('xml')
-- 庄园
active_manor = active_manor or activitymgr:create('manor')
-- 玉石
active_yushi = active_yushi or activitymgr:create('yushi')
-- 神兽
active_ss = active_ss or activitymgr:create('ss')