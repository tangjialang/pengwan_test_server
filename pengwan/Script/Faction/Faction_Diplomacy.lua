--[[
file:	Faction_Diplomacy.lua
desc:	����⽻
update:2013-7-1
refix:	done by xy
]]--
--------------------------------------------------------------------------
--include:
local pairs,type = pairs,type
local Faction_EnemyList = msgh_s2c_def[7][10]
local Faction_UnionData = msgh_s2c_def[7][20]
local Faction_UnionApply = msgh_s2c_def[7][21]
local Faction_UnionRefuse = msgh_s2c_def[7][22]
local GetFactionData = GetFactionData
local CI_GetPlayerData = CI_GetPlayerData
local CI_GetMemberInfo = CI_GetMemberInfo
local CI_GetFactionInfo = CI_GetFactionInfo
local CI_SetFactionInfo = CI_SetFactionInfo
local FactionRPC = FactionRPC
local SendLuaMsg = SendLuaMsg
local define		= require('Script.cext.define')
local FACTION_BZ = define.FACTION_BZ
local GetFactionBootData = GetFactionBootData
local factionMoneyAdd = factionMoneyAdd
local math_floor = math.floor
local CI_ClearFriendFaction = CI_ClearFriendFaction
local BroadcastRPC = BroadcastRPC
local faction_conf = faction_conf
local MailUnionConf = MailConfig.FactionUnion
local MailDelUnionConf = MailConfig.FactionDelUnion
local MailDelUnionConf1 = MailConfig.FactionDelUnion1
local SendSystemMail = SendSystemMail
local sclist_m = require('Script.scorelist.sclist_func')
local get_score_rank = sclist_m.get_score_rank
--------------------------------------------------------------------------
-- data:

--�ж԰��
local uv_enemy = {{0,0,0},{0,0,0},{0,0,0}}
--ͬ�˰��
local uv_union = {0,0,0,0}

--��ȡ�ж԰��
local function GetFactionEnemy(fid)
	local fdata = GetFactionData(fid)
	if(fdata == nil)then return end
	
	if(fdata.Enemy == nil) then
		fdata.Enemy = {}
	end
	
	return fdata.Enemy
end

--���͵ж԰��
local function _SendFactionEnemy(fid)
	local data = GetFactionEnemy(fid)
	if(data == nil)then return 3 end --��ȡ�ҵĵж԰������ʧ��
	local factionName
	local factionSign
	local idx = 1
	for id,v in pairs(data) do 
		if(type(id) == type(0))then
			factionName = CI_GetFactionInfo(id,1)
			factionSign = CI_GetFactionInfo(id,4)
			if(factionName == nil or factionName == 0)then --����ѽ�ɢ���Ѳ�����
				data[id] = nil
			else
				if(idx>3)then break end
				uv_enemy[idx][1] = id
				uv_enemy[idx][2] = factionName
				uv_enemy[idx][3] = factionSign
				idx = idx + 1
			end
		end
	end
	for i = idx,3 do
		uv_enemy[i][1] = nil
		uv_enemy[i][2] = nil
		uv_enemy[i][3] = nil
	end
	SendLuaMsg( 0, { ids = Faction_EnemyList, list1 = uv_enemy[1],list2 = uv_enemy[2],list3 = uv_enemy[3], fid = fid}, 9 )
end

--��ӵж԰�� dtype���� 1 ��� 0 �Ƴ�
function SetFactionEnemy(efid,dtype)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --��᲻����
	end
	
	if(fid == efid)then return false,6 end --����Լ���ᣬ����Բ���
	
	local title = CI_GetMemberInfo(1)
	if(title<FACTION_BZ)then
		return false,1 --�����ſ�������
	end
	
	--�����ID�Ƿ���Ч
	local factionName = CI_GetFactionInfo(efid,1)
	if(factionName == nil or factionName == 0)then 
		if(dtype == 1)then return false,2 end --û���ҵ��ж԰��
	end 
	
	local data = GetFactionEnemy(fid)
	if(data == nil)then return false,3 end --��ȡ�ҵĵж԰������ʧ��
	
	local tempdata = GetFactionBootData()
	if(dtype == 1 and tempdata~=nil and tempdata.union~=nil and tempdata.union[fid]~=nil)then
		if(tempdata.union[fid][1] == efid or tempdata.union[fid][2] == efid)then
			return false,7 --���ܰѽ��˰�����ж԰��
		end
	end

	if(data[efid]~=nil)then
		if(dtype == 1)then 
			return false,4 --�����
		else
			data[efid] = nil
			_SendFactionEnemy(fid)
			FactionRPC(fid,'FF_FactionMsg',0,factionName,dtype)
			return true
		end
	end
	local t = 0
	for id,v in pairs(data) do 
		if(type(id) == type(0))then
			t = t+1
		end
	end
	if(t>=3)then return false,5 end --ֻ�����3��
	
	data[efid] = 1
	_SendFactionEnemy(fid)
	
	FactionRPC(fid,'FF_FactionMsg',0,factionName,dtype)
	
	return true
end

--�ж϶Է��Ƿ��ǵж԰��
function isEnemyFaction(sid,pid)
	local fid = CI_GetPlayerData(23,2,sid)
	if fid == nil or fid == 0 then
		return false
	end
	
	local pfid = PI_GetPlayerFacID(pid)
	if pfid == nil or pfid == 0 then
		return false
	end
	
	local tb = GetFactionEnemy(fid)
	if(tb == nil or tb[pfid] == nil)then return false end
	
	return true
end

-------------���ͬ��------------------------------

--������ͬ������(���ս�����)
function ClearFactionUnion()
	local data = GetFactionBootData()
	if(data~=nil and data.union~=nil)then
		local myNmae,otherName
		local union
		for fid,v in pairs(data.union) do
			if(type(v) == type({}))then
				union = nil
				if(v[1]~=nil)then
					union = v[1]
				end
				if(v[2]~=nil)then
					union = v[2]
				end
				if(union~=nil)then
					myName = CI_GetFactionInfo(fid,1)
					otherName = CI_GetFactionInfo(union,1)
					if(myName~=nil and myName~=0 and otherName~=nil and otherName~=0)then
						SendSystemMail(fid,MailDelUnionConf1,1,1,{myName,otherName})
						SendSystemMail(union,MailDelUnionConf1,1,1,{myName,otherName})
						data.union[union] = nil
					end
				end
			end
		end
		data.union = nil
	end
	CI_ClearFriendFaction()
	BroadcastRPC('Union_Notice',2)
end

--���Ͱ��ͬ������
function sendFactionUnion(sid)
	local fid = CI_GetPlayerData(23,2,sid)
	local data1,data2
	if(fid~=nil and fid>0)then
		local data = GetFactionBootData()
		if(data~=nil and data.union~=nil and data.union[fid]~=nil)then
			local ufid
			local factionName,factionSign,factionLv
			if(data.union[fid][1]~=nil)then --�����İ��
				ufid = data.union[fid][1]
				if(type(ufid) == type(0))then
					factionName = CI_GetFactionInfo(ufid,1)
					if(factionName == nil or factionName == 0)then --����ѽ�ɢ���Ѳ�����
						data.union[fid] = nil
					else
						factionSign = CI_GetFactionInfo(ufid,4)
						factionLv = CI_GetFactionInfo(ufid,2)
						uv_union[1] = ufid
						uv_union[2] = factionName
						uv_union[3] = factionSign
						uv_union[4] = factionLv
						data1 = uv_union
					end
				end
			elseif(data.union[fid][2]~=nil)then
				ufid = data.union[fid][2]
				if(type(ufid) == type(0))then
					factionName = CI_GetFactionInfo(ufid,1)
					if(factionName == nil or factionName == 0)then --����ѽ�ɢ���Ѳ�����
						data.union[fid] = nil
					else
						factionSign = CI_GetFactionInfo(ufid,4)
						factionLv = CI_GetFactionInfo(ufid,2)
						uv_union[1] = ufid
						uv_union[2] = factionName
						uv_union[3] = factionSign
						uv_union[4] = factionLv
						data2 = uv_union
					end
				end
			end
		end
		SendLuaMsg( sid, { ids = Faction_UnionData, d1 = data1,d2 = data2, fid = fid}, 10 )
	end
end

--��ȡ���������� t 1 ͬ�� 2 ��ͬ��
function get_faction_union(sid,t,facid)
	local fid = facid or CI_GetPlayerData(23,2,sid)
	if(fid~=nil and fid>0)then
		local data = GetFactionBootData()
		if(data~=nil and data.union~=nil and data.union[fid]~=nil and data.union[fid][t]~=nil)then
			return data.union[fid][t]
		else
			return fid
		end
	end
end

--�����Ϊ���ͬ��
function applyFactionUnion(sid,fid)
	local isFF = GI_Is_Active_Live('cf')
	if(isFF)then --���������ڼ䲻�ܽ���
		return false,13
	end
	
	isFF = GI_Is_Active_Live('ff')
	if(isFF)then  --���ս�ڼ䲻�ܽ���
		return false,14
	end
	--���������ս��״̬���ж�
	local myfid = CI_GetPlayerData(23)
	if myfid == nil or myfid == 0 then return false,0 end --û�а��
	
	if(myfid == fid)then return false,10 end --���˰ɣ����Լ�����
	
	local title = CI_GetMemberInfo(1)
	if(title~=FACTION_BZ)then return false,1 end --���ǰ���ûȨ������
		
	local myflv = CI_GetFactionInfo(nil,2)
	if(myflv == nil)then
		return false,0 --�ҵİ�᲻����
	end
	
	if(myflv<5)then return false,2 end --����5��
	
	local flv = CI_GetFactionInfo(fid,2)
	if(flv == nil)then
		return false,3 --�Է��İ�᲻����
	end
		
	if(myflv<flv)then
		return false,4 --�������ĵȼ�����
	end
	
	local data = GetFactionBootData()
	if(data~=nil and data.union~=nil)then
		if(data.union[myfid]~=nil)then
			return false,5 --���Ѿ�������ͬ�˹�ϵ
		elseif(data.union[fid]~=nil)then
			return false,6 --�Է��Ѿ�������ͬ�˹�ϵ
		end
	end
	
	local edata = GetFactionEnemy(fid)
	if(edata~=nil and edata[fid]~=nil)then
		return false,9
	end
	
	--����ʽ��ж�
	local money = CI_GetFactionInfo(nil,3)
	if(money<faction_conf.union)then
		return false,7 --�ʽ���
	end
	--�����������ֵ��ж�
	local rank = get_score_rank(2,9,myfid)
	if(rank~=nil and rank == 1)then
		return false,11
	end
	
	rank = get_score_rank(2,9,fid)
	if(rank~=nil and rank == 1)then
		return false,12
	end
	
	local bzid = CI_GetFactionLeaderInfo(fid,1)
	if(bzid~=nil and IsPlayerOnline(bzid))then
		local factionName = CI_GetFactionInfo(myfid,1)
		SendLuaMsg( bzid, { ids=Faction_UnionApply,fid=myfid,fname=factionName,lv=myflv}, 10 )
	else
		return false,8 --�Է�����������
	end
	
	return true
end

--�������ͬ�� c 0 �ܾ� 1 ͬ��
function checkFactionUnion(sid,fid,c)
	local isFF = GI_Is_Active_Live('cf')
	if(isFF)then --���������ڼ䲻�ܽ���
		return false,13
	end
	
	isFF = GI_Is_Active_Live('ff')
	if(isFF)then  --���ս�ڼ䲻�ܽ���
		return false,14
	end

	local myfid = CI_GetPlayerData(23)
	if myfid == nil or myfid == 0 then
		return false,0 --��᲻����
	end
	
	if(c == 1)then --ͬ��
		if(myfid == fid)then return false,10 end --���˰ɣ����Լ�����
	
		--���������ս��״̬���ж�
		local title = CI_GetMemberInfo(1)
		if(title~=FACTION_BZ)then return false,1 end --���ǰ���
			
		local myflv = CI_GetFactionInfo(nil,2)		
		
		local flv = CI_GetFactionInfo(fid,2)
		if(flv == nil)then
			return false,3 --�Է��İ�᲻����
		end

		if(flv<5)then return false,2 end --����5��
			
		if(myflv>flv)then
			return false,4 --�������ĵȼ�����
		end
		
		local data = GetFactionBootData()
		if(data == nil)then
			return false,5 --���ݳ���
		end
		
		if(data.union~=nil)then
			if(data.union[myfid]~=nil)then
				return false,6 --���Ѿ�������ͬ�˹�ϵ
			elseif(data.union[fid]~=nil)then
				return false,7 --�Է��Ѿ�������ͬ�˹�ϵ
			end
		end
		
		local edata = GetFactionEnemy(fid)
		if(edata~=nil and edata[myfid]~=nil)then
			return false,8 --���ܼӵж԰��
		end
		
		edata = GetFactionEnemy(myfid)
		if(edata~=nil and edata[fid]~=nil)then
			return false,8 --���ܼӵж԰��
		end
		
		--����ʽ��ж�
		local money = CI_GetFactionInfo(fid,3)
		if(money<faction_conf.union)then
			return false,9 --�ʽ���
		end
		
		--�����������ֵ��ж�
		--�����������ֵ��ж�
	local rank = get_score_rank(2,9,myfid)
	if(rank~=nil and rank == 1)then
		return false,11
	end
	
	rank = get_score_rank(2,9,fid)
	if(rank~=nil and rank == 1)then
		return false,12
	end
		
		if(data.union == nil)then data.union = {} end
		if(data.union[myfid] == nil)then data.union[myfid] = {} end
		data.union[myfid][2] = nil
		data.union[myfid][1] = fid
		if(data.union[fid] == nil)then data.union[fid] = {} end
		data.union[fid][2] = myfid
		data.union[fid][1] = nil
		
		CI_SetFactionInfo(fid,11,myfid)
		CI_SetFactionInfo(myfid,11,fid)
		
		--�۳���Ҫ�İ���ʽ�
		CI_SetFactionInfo(fid,3,money - faction_conf.union)
		factionMoneyAdd(math_floor(faction_conf.union*0.6),myfid)
		
		local myName = CI_GetFactionInfo(myfid,1)
		local otherName = CI_GetFactionInfo(fid,1)
		local otherSign = CI_GetFactionInfo(fid,4)
		local mySign = CI_GetFactionInfo(myfid,4)

		SendSystemMail(myfid,MailUnionConf,1,1,{myName,otherName,myName,otherName})
		SendSystemMail(fid,MailUnionConf,1,1,{myName,otherName,myName,otherName})
		
		BroadcastRPC('Union_Notice',1,fid,myfid,otherName,myName,otherSign,mySign,flv,myflv)
	else --�ܾ�
		local bzid = CI_GetFactionLeaderInfo(fid,1)
		if(bzid~=nil and IsPlayerOnline(bzid))then
			local factionName = CI_GetFactionInfo(myfid,1)
			SendLuaMsg( bzid, { ids=Faction_UnionRefuse,fname=factionName,fid=myfid}, 10 )
		end
	end
	
	return true
end

--������ͬ��
function delFactionUnion(sid,_fid)

	local isFF = GI_Is_Active_Live('cf')
	if(isFF)then --���������ڼ䲻�ܽ���
		return false,3
	end
	
	isFF = GI_Is_Active_Live('ff')
	if(isFF)then  --���ս�ڼ䲻�ܽ���
		return false,4
	end
	
	local myfid
	local data
	if(_fid == nil)then
		myfid = CI_GetPlayerData(23)
		if myfid == nil or myfid == 0 then
			return false,0 --��᲻����
		end
	
		local title = CI_GetMemberInfo(1)
		if(title~=FACTION_BZ)then return false,1 end --���ǰ���
		
		data = GetFactionBootData()
		if(data==nil or data.union==nil or data.union[myfid]==nil or data.union[myfid][2]==nil)then
			return false,2 --���û��ͬ������
		end
		
		--����ʽ��ж�
		local money = CI_GetFactionInfo(nil,3)
		if(money<faction_conf.clear)then
			return false,3 --�ʽ���
		end
		
		CI_SetFactionInfo(myfid,3,money - faction_conf.clear)
	else
		myfid = _fid
		data = GetFactionBootData()
		if(data==nil or data.union==nil or data.union[myfid]==nil or data.union[myfid][2]==nil)then
			return false,2 --���û��ͬ������
		end
	end
	
	local fid = data.union[myfid][2]
	data.union[myfid] = nil
	data.union[fid] = nil
	CI_SetFactionInfo(fid,11,0)
	CI_SetFactionInfo(myfid,11,0)
	
	local myName = CI_GetFactionInfo(myfid,1)
	local otherName = CI_GetFactionInfo(fid,1)
	if(myName ~=nil and myName ~= 0 and otherName ~= nil and otherName ~= 0)then
		SendSystemMail(myfid,MailDelUnionConf,1,1,{myName,otherName})
		SendSystemMail(fid,MailDelUnionConf,1,1,{myName,otherName})
	end
	
	BroadcastRPC('Union_Notice',0,myfid,fid,myName,otherName)
	
	return true
end

SendFactionEnemy = _SendFactionEnemy