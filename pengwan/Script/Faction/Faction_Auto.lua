--[[
file:	Faction_Auto.lua
desc:	�����˰��
refix:	done by xy
]]--

--------------------------------------------------------------------------
--include:
local faction_conf = faction_conf
local fAuto_conf = fAuto_conf
local BroadcastRPC = BroadcastRPC
local SendLuaMsg = SendLuaMsg
local Faction_SuccessJoin = msgh_s2c_def[7][18]
local Faction_AutoData = msgh_s2c_def[7][23]
local CI_GetFactionInfo = CI_GetFactionInfo
local db_module = require('Script.cext.dbrpc')
local GI_GetFactionID = db_module.get_faction_id
local GI_DelApplyJoinFaction = db_module.delapply_join_faction
local CI_GetFactionLeaderInfo = CI_GetFactionLeaderInfo
local CI_SelectObject = CI_SelectObject
local ReplaceFactionLeader = ReplaceFactionLeader
local type = type
local GetFactionBootData = GetFactionBootData
--local GetWorldLevel = GetWorldLevel
local math_floor = math.floor
local math_random = math.random
local CI_LeaveFaction = CI_LeaveFaction
--------------------------------------------------------------------------
-- data:

--[[
�����˰�����ݽṹ
auto = {
	n = ��ǰ�����˰������
	cur = ��ǰ�����˰�����˵�����
	[idx] = fid or idx --��ǰ�Ļ����˰��
}
]]--

--������ʼ�������˰��
function init_auto_faction()
	local data = GetFactionBootData()
	if(data==nil)then
		return --��������
	end
	
	if(data.num~=nil)then
		--look('========================')
		--look(data.num)
	end
	
	if(data.auto == nil or type(data.auto)~=type({}) or (data.auto.n~=nil and data.auto.n<fAuto_conf.maxnum))then
		--�����������ȼ��ж�
		--[[
		local wlevel = GetWorldLevel() or 1
		if(wlevel<fAuto_conf.wlv)then
			return
		end
		]]--
		--��������������ж�
		if(data.num~=nil and data.num>fAuto_conf.fnum)then
			return
		end
		if(data.auto == nil or type(data.auto)~=type({}))then
			data.auto = {}
			data.auto.n = 0
			data.auto.cur = math_random(1,250) --������ֿ�ʼ
		end
		local i = data.auto.n
		local newidx
		while(i<fAuto_conf.maxnum)do
			newidx = (data.auto.cur == nil) and 1 or data.auto.cur+1
			if(fAuto_conf[newidx] == nil)then
				return
			end
			data.auto.cur = newidx
			data.auto[newidx] = newidx
			data.auto.n = data.auto.n +1
			i = i+1
		end
	end
	

end

--���������˰��
local function _create_auto_faction()
	local data = GetFactionBootData()
	if(data==nil)then
		return --��������
	end
	if(data.auto == nil)then
		data.auto = {n = 0}
	elseif(data.auto.n>=fAuto_conf.maxnum)then
		return --��������������ﵽ���� 
	end
	
	local issend = false
	
	--�����������ȼ��ж�
	--[[
	local wlevel = GetWorldLevel() or 1
	if(wlevel<fAuto_conf.wlv)then
		return issend
	end
	]]--
	--��������������ж�
	if(data.num~=nil and data.num>fAuto_conf.fnum)then
		return issend
	end
	
	local newidx = (data.auto.cur == nil) and 1 or data.auto.cur+1
	if(data.auto[newidx]~=nil)then
		return issend--���������
	end
	if(fAuto_conf[newidx] == nil)then
		return issend--û�ӵ���
	end
	data.auto.cur = newidx
	data.auto[newidx] = newidx
	data.auto.n = data.auto.n +1
	
	BroadcastRPC('Faction_Auto',0,data.auto) --����ȫ��
	issend = true
	return issend
end

--ת�ð�����
local function _carry_auto_faction(fid,cfid)
	local data = GetFactionBootData()
	if(data==nil or data.auto == nil or data.auto.n == nil or data.auto[fid] == nil)then
		return --��������
	end
	if(data.auto[fid] == cfid and cfid~=fid)then
		local num = CI_GetFactionInfo(cfid,11)
		if(num>=fAuto_conf.num)then
			local hsid = CI_GetFactionLeaderInfo(cfid,2)
			local nhsid = CI_GetFactionLeaderInfo(cfid,0)
			look(hsid)
			if(hsid ~= nhsid)then
				local old_sid = CI_GetPlayerData(17)	
				if 1==CI_SelectObject(2,hsid) then
					ReplaceFactionLeader()
					temp = CI_LeaveFaction(cfid,1,0)
					if(temp ~= nil)then
						look(temp)
					end
				end
				CI_SelectObject(2,old_sid)
			end
			data.auto[fid] = nil
			data.auto.n = data.auto.n -1
			if(_create_auto_faction() == false)then
				BroadcastRPC('Faction_Auto',0,data.auto)
			end
		end
	end
end

--�Ƿ��ǻ����˰��
function is_auto_faction(fid)
	local data = GetFactionBootData()
	if(data~=nil or data.auto~=nil)then
		for idx,v in pairs(data.auto) do
			if(type(idx) == type(0))then
				if(v == fid)then
					return idx
				end
			end
		end
	end
end

--���ͻ����˰������
function send_auto_faction()
	local data = GetFactionBootData()
	if(data~=nil or data.auto~=nil)then
		SendLuaMsg( 0, { ids = Faction_AutoData,data = data.auto,num = data.num}, 9 )
	end
end

--�����������˰��
function join_auto_faction(sid,fid)
	local myfid = CI_GetPlayerData(23)
	if(myfid~=nil and myfid>0)then return false,0 end --�Ѿ��а���� 
	local data = GetFactionBootData()
	if(data==nil or data.auto == nil or data.auto.n == nil or data.auto[fid] == nil)then
		return false,1 --��������
	end
	local cfid = data.auto[fid]
	if(cfid ~= fid)then
		--�����˰���Ѿ����� ��ֻ��Ҫ���������
		local flv = CI_GetFactionInfo(cfid,2)
		if(flv == nil)then
			return false,2 --��᲻����
		end
		
		local lv = CI_GetFactionInfo(cfid,10)
		local totalnum = 30 + lv*6 + (flv-1)*2
		local num = CI_GetFactionInfo(cfid,11)
		if(totalnum<=num)then
			return false,3 --��������Ѵ�����
		end
		local result = CI_JoinFaction(cfid,sid)
		if(result == 0)then --�ɹ�������
			if((num+1)>=fAuto_conf.fnum)then
				_carry_auto_faction(fid,cfid)
			end
			local fname = CI_GetFactionInfo(cfid,1)
			if(type(fname) == type(""))then
				SendLuaMsg(0, { ids=Faction_SuccessJoin,fn = fname,t=1, fid = cfid}, 9 )
			end
			GI_DelApplyJoinFaction(sid,0,0)
		end
	else
		--�ߴ����������
		local level=CI_GetPlayerData(1) --23���ID
		if(faction_conf.createlv>level)then --�ȼ�����
			return false,4
		end
		
		--�����������ȼ��ж�
		--[[
		local wlevel = GetWorldLevel() or 1
		if(wlevel<fAuto_conf.wlv)then
			return
		end
		]]--
		--��������������ж�
		if(data.num~=nil and data.num>fAuto_conf.fnum)then
			return false,5*1000+data.num
		end
		local item = fAuto_conf[fid]
		if(item~=nil and type(item.n)==type(""))then
			--�����ݿ�����һ���µİ���ID
			GI_GetFactionID(item.n,-1,fid)
		end
	end
end

--���������˰�᷵����ID������
function DBCALLBACK_CreateAutoFaction(factionId, name, autuID)
	if(type(name) ~= type(""))then
		look('create auto factionName is not string') 
		SendLuaMsg( 0, { ids = Faction_Fail, t = 17, data = 100}, 9 )
		return
	end
	if(factionId~=nil and factionId>0 and autuID~=nil and autuID>0)then
		--[1] = {n = '$$�������1$$',h = '��������1',lv = 30,sex = 0,head = 1,vip = 4, school = 1},
		local item = fAuto_conf[autuID]
		if(item == nil)then 
			SendLuaMsg( 0, { ids = Faction_Fail, t = 17, data = 102}, 9 )
			return 
		end
		local _name = item.h
		local _vip = item.vip
		local _sex = item.sex
		local _level = item.lv
		local _school = item.school
		local _head = item.head
		--look(name..','..factionId..','.._name..','.._vip..','.._sex..','.._level..','.._school..','.._head)
		--level,school,head,sex,name
		local result = CI_CreateFaction(name,factionId,_level,_school,_head,_sex,_vip,_name)
		if(result == 0)then
			local data = GetFactionBootData()
			local newFid = ((GetGroupID()%10000)*(2^16))+factionId
			local data = GetFactionBootData()
			
			if(data~=nil)then
				if(data.num == nil)then 
					data.num = 1
				else
					data.num = data.num + 1
				end
				if(data.auto ~= nil and data.auto[autuID] ~= nil and data.auto[autuID] == autuID)then
					data.auto[autuID] = newFid
					BroadcastRPC('Faction_Auto',0,data.auto)
				end
			end
			local sid = CI_GetPlayerData(17)
			if(sid>0 and IsPlayerOnline(sid))then
				local myfid = CI_GetPlayerData(23)
				if myfid == nil or myfid == 0 then
					local result1 = CI_JoinFaction(newFid,sid)
					if(result1 == 0)then --�ɹ�������
						set_join_factionDate(dsid)
						SendLuaMsg(0, { ids=Faction_SuccessJoin,fn = name,t=1, fid = newFid}, 9)
						GI_DelApplyJoinFaction(sid,0,0)
					end
				end
			end
			upMainBuild()
			GetFaction_ybData(newFid)
			SendLuaMsg( 0, { ids = Faction_Build,idx = 1,lv = 1}, 9 )
		else
			SendLuaMsg( 0, { ids = Faction_Fail, t = 17, data = result}, 9 )
		end
	else
		SendLuaMsg( 0, { ids = Faction_Fail, t = 17, data = 101}, 9 )
	end
end