--	
--	����ݹ���������һ�����õĻ���ݹ�������NPC����ң�����
--	Ŀǰ�õ��Ļ��(��������������˻��ʹ�ø�ģ��)��
--

--[[
	version1
	����ʱ��̬�����Ľ�������ˢ��/���߻��ڣ����߾�û�ˣ�  	���߲���һֱ��
	��ʱ��̬�����Ľ�������  ��ˢ��/���߻��ڣ����߾�û�ˣ�	�ȴ���ȥ���ٵ����
	
	����Ҫ�ӹܵĹ��ܣ�
	[1] ����ݣ�ͬ��/��ͬ����
	[2] ��̬������������/����ά��/���٣����䵹��ʱ������ʱ�������٣�/����/�˳�
	[3] ��ң� ����/ˢ�����ߣ���ʼ������ݣ�/�л�����/����/��һ���ݣ��Ƿ���Զ�����������
	[4] ��� ����/ɾ��/����ȫ�������ص�
	[5] NPC��  ����/ɾ��
	
	_activity_entity = {
		mgr =>
		userdata = {},
		player={},
		name =	activename,
	}
	
	version2
	I  ���صĹ���
	
	1 �ṩͳһ�Ĺ�����ڣ� ����/ˢ��/����/����/�л�����/��ʼ��/����/�˳�
	2 ��̬�����Ĺ�������/����/��ʱ
	3 �������
	4 ����ݵĹ���
	
	II ���صĻ����
	
	1 ��ʱ����Ļ
		[1]���� ���ʱ�� = nil ������֧�ַ������
		[2]���ݣ�
			->��Ҫ��̬����
				(*��������Ϊ�Զ�ɾ���ೡ��*)(��������ʱ<90)
				�������ݣ���OnRegionDelete��				
					player������뿪��������������/�л�������
					data��OnRegionDelete����
					����г�������ʱ�ص� --> ɾ������
			->����Ҫ��̬����
				����Ҫ����������
				�������ݣ�
					player(����뿪��������������/�л�����)
					data����ʱӦ��û�����ݣ�
		[]��������ħ¼/��λ��/͵Ϯ/��̨��/��ʯ����
	  
	2 ʱ����Ļ
		[1]���� ���ʱ�䲻Ϊ�գ���Ľ������ɿ�ܽӹܣ��������������ݣ����ʱ�� <90��
		[2]���ݣ�
			->��Ҫ��̬����
				(*�����г�������ʱ*)
				data���������ʱ����
				room (ֻ�ṩ�ڲ�ʹ�á����ṩ�ⲿ���ýӿ�)
				player���������ʱ����
			->����Ҫ��̬����
				data���������ʱ����
				player���������ʱ����
	
	  []������qsls
	  
	  ͳһ��������90���ӵĶ�̬����ͳһɾ
	  
	  ���������붯̬������������������Ҫ�жϲ��ܽ�������
	  ��ҽ��붯̬����ʧ�ܵĴ���ʱ�����ȴ�ʱ���������ʱ�����������û�е���ʱ�Ķ�̬��������ֱ��ɾ������
	  
	  ȷ����һ��ʶ��������Ƕ�ʱ�Ļ������/�г���/�ⲿ���ã� �� ��ʱ�Ļ������/�г���/����ɾ����
	  ��ʱ�Ļ��û�ж�̬�����Ļ��ʶ�������addplayer��Ҫ�����
	  
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

-- һ��������ݴ洢ʵ��
_activity_entity = {
	new = function(self, mgr, name)		
		if mgr == nil or name == nil then 
			look('_activity_entity new:' .. tostring(name) .. ' param erro')
			return 
		end
		
		-- ����������ж�
		if uv_DRList[name] == nil then
			look('_activity_entity new:' .. tostring(name) .. ' config erro[1]')
			return
		end		
		
		local actconf = uv_DRList[name]		
		
		-- 1����ʱ������֧�ַַ��䴦��
		if actconf.actTimer == nil and (actconf.partRM or actconf.enterRM) then
			look('_activity_entity new:' .. tostring(name) .. ' config erro[2]')
			return
		end
		-- 2������ʱ��������ͬʱ���� actTimer �� clrTimer ��������
		if (actconf.actTimer and actconf.clrTimer == nil) or (actconf.actTimer == nil and actconf.clrTimer) then
			look('_activity_entity new:' .. tostring(self.name) .. ' config erro[3]')
			return
		end
		-- 3��clrTimer �ݶ����ܳ���10����
		if actconf.clrTimer and actconf.clrTimer > 10 * 60 then
			look('_activity_entity new:' .. tostring(self.name) .. ' config erro[4]')
			return
		end
		-- 4��bSpan �ж��Ƿ�Ϊ���
		if actconf.bSpan then
			if not IsSpanServer() then
				look('_activity_entity new:' .. tostring(self.name) .. ' config erro[5]')
				return
			end
		end		
		-- 5������ͬʱ��partRM �� enterRM
		if actconf.partRM and actconf.enterRM then
			look('_activity_entity new:' .. tostring(self.name) .. ' config erro[6]')
			return
		end
		
		-- ����ֻ��ʼ����������
		local o = { mgr = mgr, name = name, data = {}, flags = 1 }

		setmetatable(o, self)
		self.__index = self
		
		-- ����ʱ�������������ʱ��
		if actconf.actTimer then
			-- if actconf.actTimer > 90 * 60 then	-- �ʱ���ݶ����ܳ���90����
				-- look('_activity_entity new:' .. tostring(self.name) .. ' config erro[5]')
				-- return
			-- end			
			o.data.pub = {}										-- ֻ��ʱ��������pub����
			o.data.pub.atm = GetServerTime() + actconf.actTimer	-- ��¼һ������ʱ��
		
			SetEvent( actconf.actTimer, nil, "GI_OnActiveEnd", name)
		end
		return o
	end,
	
	-- �������̬����(֧��һ���Զ���ش�����/���ڳ�������ʱ�ش�)
	-- ���˴����Ĵ�����̬������Ҫ��sid(���ֻ�������汣֤��)
	createDR = function(self,DRNum,tMapID,sid,args)
		if self.name == nil then return end
		if uv_DRList[self.name] == nil or uv_DRList[self.name][DRNum] == nil then
			look('createDR:' .. tostring(self.name) .. ' config erro')
			return
		end
		local actconf = uv_DRList[self.name]
		local dyconf = actconf[DRNum]
		local mapID = tMapID or dyconf.tMapID	-- ������Զ��崫���Դ����mapidΪ׼
		if mapID == nil then
			look('createDR:' .. tostring(self.name) .. ' tMapID erro')
			return
		end
		-- ����Ҫ�г����������ã�����
		if dyconf.bManual == nil or (dyconf.bManual ~= 0 and dyconf.bManual ~= 1) then
			look('createDR:' .. tostring(self.name) .. ' bManual erro')
			return
		end
		
		-- ���õĻ��������ж�
		-- 1�����ڷ�ʱ����Ļ��������Ϊ�Զ�ɾ���ೡ�������г�������ʱ		
		if actconf.actTimer == nil and (dyconf.bManual == 1 and dyconf.cTimer == nil) then
			look('createDR:' .. tostring(self.name) .. ' param erro[1]')
			return
		end					
		-- 2������ʱ���������ж�̬��������ʱ�� clrTimer ������[cTimer+60,cTimer+5*60] �������
		if actconf.actTimer and actconf.clrTimer and dyconf.cTimer then
			--look(actconf.clrTimer)
			--look(dyconf.cTimer)
			if (actconf.clrTimer < dyconf.cTimer + 60) or (actconf.clrTimer > dyconf.cTimer+5*60) then
				look('createDR:' .. tostring(self.name) .. ' param erro[2]')
				return
			end
		end
		-- 3������ʱ���������ж�̬��������ʱ�� �������� partRM
		if actconf.actTimer and dyconf.cTimer then
			if actconf.partRM then
				look('createDR:' .. tostring(self.name) .. ' param erro[3]')
				return
			end
		end
		
		-- ������̬����֮ǰ���ж��Ƿ����ƶ�̬��������̬����
		-- ���ڽ��������˲���ͬʱ����������ͬ��ͼID�Ķ�̬����
		if sid then
			local rx, ry, rid, mapGID = CI_GetCurPos(2,sid)
			if mapGID and rid == mapID then			-- �ڶ�̬�������ܴ�����̬����
				look('createDR:' .. tostring(self.name) .. ' when player in dr')
				return
			end
		end
		-- ��ʼ������̬����		
		local mapGID = PI_CreateRegion(mapID, -1, dyconf.bManual, self.name)	
		if mapGID == nil then
			look('createDR:' .. tostring(self.name) .. ' mapGID erro')
			return
		end

		-- ��ʱ��֧�������ݽ���
		if dyconf.traps and type(dyconf.traps) == type({}) then
			for _, v in pairs(dyconf.traps) do
				
				uv_TrapInfo[2]=v[1]
				uv_TrapInfo[3]=v[2]
				uv_TrapInfo[4]=mapGID
				PI_MapTrap(2,uv_TrapInfo,100000+v[4],v[3])
			end
		end
		
		-- ����datatype��ʼ������
		if actconf.dataType then
			if rint((actconf.dataType / 10) )% 10 == 1 then	-- ��¼���������
				self.data[mapGID] = {}
			end			
		end		
		
		-- ��Ҫ������ɾ��(ʱ����������partRM)
		if actconf.actTimer and (actconf.partRM or actconf.enterRM) then	
			self.room = self.room or {}
			tablepush(self.room,{mapGID,0,0})						
		end	
		-- �зַ��䴦��
		if self.room then
			BroadcastRPC('ROM_Notice',self.name,self.room)
		end
		-- ���ó�������ʱ
		if dyconf.cTimer then
			self.data[mapGID] = {}
			if self.data[mapGID].cTimer then		-- ���֮ǰ�м�ʱ��û�����(���ܻ�������)
				look("createDR: cTimer pre_timer not clear")
			end
			local dpos = dyconf.DelPos
			if dpos then
				self.data[mapGID].cTimer = SetEvent( dyconf.cTimer, nil, "GI_OnDRTimeOut", self.name, mapGID, args, dpos[1], dpos[2], dpos[3])
			else
				self.data[mapGID].cTimer = SetEvent( dyconf.cTimer, nil, "GI_OnDRTimeOut", self.name, mapGID, args )
			end
			-- self.data[mapGID].btm = GetServerTime()	-- ��¼������ʼʱ��
		end
		
		-- �����Զ��崦����
		if type(self.on_regioncreate) == 'function' then
			self:on_regioncreate(mapGID,args)
		end
		
		-- ����һ��GID��Ϊ�ⲿ�ж�
		return mapGID
	end,
	
	-- ��ȡ��ַ�������
	-- 0 ���ַ��� 1 ����ǰ�������� 2 ��������ʷ��������
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
	
	-- ��鲢�ж��Ƿ񴴽��³���
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
		
		-- �жϷ�������
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
					if num >= actconf.partRM[1] and v[2] == 0 then		-- ���·���״̬
						v[2] = 1
						bSend = true
					elseif num < actconf.partRM[2] and v[2] == 1 then		-- ���·���״̬
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
					if num >= actconf.enterRM[1] and v[2] == 0 then		-- ���·���״̬
						v[2] = 1
						bSend = true
					elseif num < actconf.enterRM[2] and v[2] == 1 then		-- ���·���״̬
						v[2] = 0
						bSend = true
					end
					if num < actconf.enterRM[2] then
						bNeed = false
					end
				end
			end
		end
		
		-- ��Ҫ�����·���
		if bNeed then
			if self:createDR(DRNum) then
				bSend = true
			end
		end
		if bSend then
			BroadcastRPC('ROM_Notice',self.name,rmData)
		end
	end,

	-- ��ĳ��������һ�����
	-- ֧�̶ֹ�����:
	--		regionID [nil] �ûû�г��� [~=0] �̶����� [==0] ��̬������ʱmapGID������
	--		mapGID [nil] ������뵱ǰ���̬���� [~=nil] ����ָ��GID�Ķ�̬����
	add_player = function(self, sid, DRNum, regionID, x, y, mapGID)
		-- look('��ĳ��������һ�����')
		if sid == nil or DRNum == nil or self.name == nil then
			return end
		-- ����û�л����Ҫ���ֱ����ӵ��
		if regionID == nil then
			-- �����ҵ��
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
		
		-- ȡ���볡���ص�
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
		-- �����˳�λ��
		if dyconf.BackPos == nil then
			GI_SetPlayerPrePos(sid)
		else
			GI_SetPlayerPrePos(sid,dyconf.BackPos[1],dyconf.BackPos[2],dyconf.BackPos[3])
		end
		-- ȡ��̬������ǰ����
		local count = GetRegionPlayerCount(mapGID) or 0
		-- ��̬������֧�ַַ���
		if regionID == 0 and actconf.partRM and type(actconf.partRM) == type({}) and #actconf.partRM == 2 then
			if mapGID == nil or self.room == nil then
				look('mapGID == nil or self.room == nil')
				return
			end
			
			-- ���Գ��Ա�����������Ƿ��д�mapGID����ֹǰ̨��������mapGID(��ʱ������)
			-- ������Ҫ��¼������������������Ա���Ҫ���������ҵ�������
			local roomID = 0		-- ������
			local tempGID = nil		-- ��¼��ʱGID
			for k, v in ipairs(self.room) do
				if type(v) == type({}) then
					local gid = v[1]
					if gid and gid > 0 then
						if mapGID == 0 then			-- ���ҿշ���
							local ct = GetRegionPlayerCount(gid) or 0 
							if ct < actconf.partRM[1] then
								count = ct
								tempGID = gid
								roomID = k								
								break
							end
						else
							if mapGID == gid then	-- ������ҵ���ǰ����
								tempGID = gid
								roomID = k
								break
							end
						end
					end
				end
			end
			-- ���û�ҵ����ʵķ���
			if tempGID == nil then	
				TipCenter(GetStringMsg(449))
				return
			end
			
			-- ���������ж�
			if count >= actconf.partRM[1] then
				if not IsSpanServer() then 
					TipCenter(GetStringMsg(449))
					return
				else
					RPCEx(sid,'add_player',roomID)
				end
			end
			-- ָ����ǰ���ҺõĿշ������ԭʼ����GID
			mapGID = tempGID
			
			-- move player
			local res=PI_MovePlayer(regionID,enterX,enterY,mapGID,2,sid)
			if not res then
				look('DR_PutPlayerTo err:'..tostring(regionID)..','..tostring(enterX)..','..tostring(enterY)..','..tostring(mapGID))
				if mapGID and dyconf.bManual == 0 and count == 0 then		-- putʧ����������Զ�ɾ���ĳ������ҵ�ǰ��������Ϊ0 ɾ������
					CI_DeleteDRegion(mapGID,1)
				end
				return
			else
				-- �ж��Ƿ��з���δ�����ַ����������򴴽��·���
				if count + 1 >= actconf.partRM[2] then		
					self:check_createNewDR(DRNum)
				end
			end
		-- ����ʷ���������ַ���
		elseif regionID == 0 and actconf.enterRM and type(actconf.enterRM) == type({}) and #actconf.enterRM == 2 then
			if mapGID == nil or self.room == nil then
				look('mapGID == nil or self.room == nil')
				return
			end
			
			-- ���Գ��Ա�����������Ƿ��д�mapGID����ֹǰ̨��������mapGID(��ʱ������)
			-- ������Ҫ��¼������������������Ա���Ҫ���������ҵ�������
			local roomID = 0		-- ������
			local tempGID = nil		-- ��¼��ʱGID
			for k, v in ipairs(self.room) do
				if type(v) == type({}) then
					local gid = v[1]
					if gid and gid > 0 then
						if mapGID == 0 then			-- ���ҿշ���
							local ct = v[3] or 0 
							if ct < actconf.enterRM[1] then
								count = ct
								tempGID = gid
								roomID = k								
								break
							end
						else
							if mapGID == gid then	-- ������ҵ���ǰ����
								count = v[3] or 0
								tempGID = gid
								roomID = k
								break
							end
						end
					end
				end
			end
			-- ���û�ҵ����ʵķ���
			if tempGID == nil then	
				TipCenter(GetStringMsg(449))
				return
			end
			
			-- ���������ж�
			if count >= actconf.enterRM[1] then
				if not IsSpanServer() then 
					TipCenter(GetStringMsg(449))
					return
				else
					RPCEx(sid,'add_player',roomID)
				end
			end
			-- ָ����ǰ���ҺõĿշ������ԭʼ����GID
			mapGID = tempGID
			
			-- move player
			local res=PI_MovePlayer(regionID,enterX,enterY,mapGID,2,sid)
			if not res then
				look('DR_PutPlayerTo err:'..tostring(regionID)..','..tostring(enterX)..','..tostring(enterY)..','..tostring(mapGID))
				if mapGID and dyconf.bManual == 0 and count == 0 then		-- putʧ����������Զ�ɾ���ĳ������ҵ�ǰ��������Ϊ0 ɾ������
					CI_DeleteDRegion(mapGID,1)
				end
				return
			else
				-- �ж��Ƿ��з���δ�����ַ����������򴴽��·���
				self.room[roomID][3] = (self.room[roomID][3] or 0) + 1
				if count + 1 >= actconf.enterRM[2] then		
					self:check_createNewDR(DRNum)
				end
			end
		else		
			if not PI_MovePlayer(regionID,enterX,enterY,mapGID,2,sid) then
				look('DR_PutPlayerTo err:'..tostring(regionID)..','..tostring(enterX)..','..tostring(enterY)..','..tostring(mapGID))
				if mapGID and dyconf.bManual == 0 and count == 0 then		-- putʧ����������Զ�ɾ���ĳ������ҵ�ǰ��������Ϊ0 ɾ������
					CI_DeleteDRegion(mapGID,1)
				end
				return			
			end
		end
		-- �Ƿ��¼������ʷ��ߵ�����(��������dataType = 10 or 110)
		if dyconf.HistoryMax then		-- ���ڻ�û�õ��ݲ�����!!!
			
		end

		-- ��¼������ҽ�����(�뿪�����)
		if actconf.enterNum and self.room and self.room[roomID] then
			self.room[roomID][3] = (self.room[roomID][3] or 0) + 1
		end
		-- �����ҵ��
		self.mgr:_p2a_add(sid, self.name)

		-- if mapGID and self.data[mapGID] then
			-- RPCEx(sid,'region_btm',self.name,self.data[mapGID].btm)
		-- end

		return true,mapGID
	end,
	
	-- �Ӷ�̬�����˳�
	back_player = function(self, sid)
		if self:is_active(sid) then
			GI_ExitToPrePos(sid)
			return true
		end
		return false
	end,
	
	-- 	��ĳ������Ƴ�һ�����(internal use)
	remove_player = function(self, sid)
		if sid == nil then return end
		if uv_DRList[self.name] == nil then
			look('remove_player:' .. tostring(self.name) .. ' config erro')
			return
		end
		local actconf = uv_DRList[self.name]		
	--	look('actconf.NoClearP:' .. actconf.NoClearP)
		-- ���������ж��Ƿ�����������
		if actconf.NoClearP == nil and self.player and self.player[sid] then			
			self.player[sid] = nil			-- ����������
		end
		-- ������־
		self.mgr:_p2a_remove(sid, self.name)	
	end,
	
	-- ��ȡ���־
	get_state = function(self)
		return self.flags or 0
	end,
	
	-- ���û��־
	set_state = function(self,state)
		self.flags = state or 0
	end,
	
	-- ��ȡ������ʷ�������(��δʵ�֣�����)
	get_player_cnt = function( self, mapGID )
		-- if mapGID and self.data and self.data[mapGID] then
			-- return self.data[mapGID].player_cnt
		-- end
	end,
	
	-- ��ȡ������
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
	
	-- ʱ������������
	get_pub = function(self)
		if self.data then
			return self.data.pub
		end
	end,
	
	-- ��ȡ�regiondata�Ľӿ�
	-- ֻ֧��ȡ�������ݷ�ֹ�ⲿ������������������������
	get_regiondata = function(self, mapGID)		
		if mapGID and self.data then
			return self.data[mapGID]
		end
	end,
	
	-- ����regiondata�ӿ�(internal use)
	clear_regiondata = function(self, mapGID)
		if mapGID and self.data and self.data[mapGID] then
			-- �����������ʱ
			if self.data[mapGID].cTimer then
				ClrEvent(self.data[mapGID].cTimer)		
			end
			-- ����������
			self.data[mapGID] = nil
		end
	end,

	-- ��ȡ������data�Ľӿ�
	get_mydata = function( self, sid )
		local actconf = uv_DRList[self.name]
		-- ����������actTimer�Ĳ��ܵ��ô˺���
		if actconf == nil or actconf.dataType == nil then
			look("get_mydata : config erro[1]")
			return
		end		
		if rint((actconf.dataType / 100) )% 10 == 1 then	-- ��¼�������
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

	-- �����һ��־(�ṩ���ⲿ���õĽӿ�)
	clear_flags = function(self,sid)
		self.mgr:_p2a_remove(sid, self.name)
	end,
	
	-- �ж�����Ƿ��ڸû(�ṩ���ⲿ���õĽӿ�)
	is_active = function(self,sid)
		return self.mgr:is_playerin(sid, self.name)
	end,
	
	-- clearAll(internal use)
	-- Ϊ�����ֶ������������������ݴ����ж�һ������������
	clearAll = function(self)
		if uv_DRList[self.name] == nil then
			look('_activity_entity clearAll:' .. tostring(self.name) .. ' config erro[1]')
			return
		end
		local actconf = uv_DRList[self.name]
		--local dyconf = actconf[DRNum]
		
		-- ����������actTimer�Ĳ��ܵ��ô˺���
		if actconf.actTimer == nil then
			look("_activity_entity clearAll: config erro[2]")
			return
		end		

		-- ����ж�̬����������������
		if self.room then
			--look('�����,����������')
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
	
	-- ������������
	traverse_region = function(self, f, args)
		if self.room and type(f)==TP_FUNC then
			for _, v in ipairs(self.room) do
				if type(v) == type({}) then
					f( v[1], args)
				end
			end
		end
	end,
	
	--	��������ÿ�����ִ��һ����ͬ�Ĳ���
	traverse_player = function(self,  f )
		if type(f)==TP_FUNC then
		    local old_sid = CI_GetPlayerData(17)		-- ���浱ǰ��� SID
			for sid, mydata in pairs(self.player) do
				if 1==SetPlayer( sid, 1, 1 ) then
					 f(sid, mydata )
				end
			end
			SetPlayer( old_sid, 1, 1)
		end
	end,
	
	--������ÿ������ִ����ͬ�Ĳ���
	traverse_monster = function(self, f, regionid)
	end,
	
	--������ÿ��npcִ����ͬ����
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

--����ݹ�����
local _activity_mgr = 
{
	new = function(self)
		local o = { actives = {}, p2a = {} }

		setmetatable(o, self)
		self.__index = self

		return o
	end,

	-- ����һ���
	create = function(self, name, reset)
		if not self:is_has(name) then
		    local o = _activity_entity:new( self, name )
			self.actives[name] = o
			return o
		end
		-- **���õ�ʱ����data/player�µ�����
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

	-- �������ַ��ػ
	get = function( self, name )
		return self.actives[ name ]
	end,

	-- �ж��Ƿ���������
	is_has = function(self, name)
		return self.actives[name] ~= nil
	end,
	
	--internal use
	_p2a_add = function( self, sid, name )
		--look('_p2a_add')
		if nil==self.p2a[sid] then
			self.p2a[sid] = {}
		end

		-- Ϊ�˱���������á���ʱ����״̬Ϊ1
		self.p2a[sid][name] = 1
	end,
	
	--internal use
	_p2a_remove = function(self, sid, name)		
		if self.p2a[sid] and self.p2a[sid][name] then	
			self.p2a[sid][name] = nil
		end
	end,
	
	-- 	�ж�ĳ������Ƿ���ĳ�����(internal use)
	is_playerin = function(self, sid, name)
		return self.p2a[sid] ~= nil and self.p2a[sid][name] ~= nil
	end,

	get_actives = function( self, sid )
		return self.p2a[sid]
	end,	

	-- ���ڶ�ʱ�����Ķ�̬����(�����ڲ�����)
	clearAll = function(self, name)			
		if self.actives[ name ] then	
			-- ���ȵ���ÿ����Զ����������
			if type(self.actives[name].on_clear_data) == 'function' then
				self.actives[name]:on_clear_data()
			end
			
			local Activity = self.actives[ name ]
			Activity:clearAll()	
			
			-- ��������
			self.actives[ name ] = nil
		end		
	end,
	
	-- �����������
	clear_regiondata = function(self, name, gid)
		if self.actives[ name ] then
			self.actives[ name ]:clear_regiondata(gid)
		end
	end,
	
	-- ��������ʱ�ص�
	on_DRtimeout = function(self, name, mapGID, args)
		if self.actives[name] then
			-- �Զ��峡������ʱ�ص�����
			--look('--------------------on_DRtimeout---------------------------')
			if type(self.actives[name].on_DRtimeout) == 'function' then
				self.actives[name]:on_DRtimeout(mapGID,args)
			end
		end
	end,
	
	-- ����ɾ���ص�
	on_regiondelete = function(self,name,RegionID,mapGID)
		if self.actives[name] then
			-- ��Զ��峡��ɾ���ص�����
			if type(self.actives[name].on_regiondelete) == 'function' then
				self.actives[name]:on_regiondelete(RegionID,mapGID)
			end
		end
	end,
	
	-- ��������ȫ�������ص�
	on_monDeadAll = function(self,mapGID,name)
		if mapGID == nil or name == nil then return end
		if self.actives[name] then
			if type(self.actives[name].on_monDeadAll) == 'function' then
				self.actives[name]:on_monDeadAll(mapGID)
			end
		end		
	end,
	
	-- �����������
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
		return bret		-- ��Ҫ�������ֵ�ж��Ƿ񷵻�
	end,
	
	-- ��Ҹ����
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
		return bret		-- ��Ҫ�������ֵ�ж��Ƿ񷵻�
	end,
	
	-- ����л���������
	on_regionchange = function( self, sid )
		if self.p2a[sid] then
			for name in pairs(self.p2a[sid]) do
				-- look('name:' .. name)
				if self.actives[name] then
					-- ��Զ��峡���л�������
					if type(self.actives[name].on_regionchange) == 'function' then
						bret = self.actives[name]:on_regionchange(sid)
					end
					
					-- �ӻ�Ƴ����
					self.actives[name]:remove_player(sid)
				end
			end
			self.p2a[sid] = nil		-- ������л��־
		end				
	end,
	
	-- ������ߴ���
	on_logout = function( self, sid )
		if self.p2a[sid] then
			for name in pairs(self.p2a[sid]) do
				if self.actives[name] then
					-- ��Զ������ߴ�����
					if type(self.actives[name].on_logout) == 'function' then
						self.actives[name]:on_logout(sid)
					end

					-- �ӻ�Ƴ����
					self.actives[name]:remove_player(sid)
				end
			end
			self.p2a[sid] = nil
		end		
	end,
	
	-- ������ߴ���
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
		-- ���û���������з�����Ϣ ��Ҫ���͸����
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

-- ���ܳ�ʼ��
activitymgr = activitymgr or _activity_mgr:new()

-- ��λ��
active_marank = active_marank or activitymgr:create('MaRank')
-- ׯ԰�Ӷ�
active_marobb = active_marobb or activitymgr:create('MaRobb')
-- ��ħ¼
active_xml = active_xml or activitymgr:create('xml')
-- ׯ԰
active_manor = active_manor or activitymgr:create('manor')
-- ��ʯ
active_yushi = active_yushi or activitymgr:create('yushi')
-- ����
active_ss = active_ss or activitymgr:create('ss')