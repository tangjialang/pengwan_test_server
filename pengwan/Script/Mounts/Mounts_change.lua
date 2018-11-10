--[[
file:Mounts_change.lua
desc:����û�
author:xiao.y
update:2013-7-1
refix:	done by xy
]]--
--------------------------------------------------------------------------
--include:
local pairs,type = pairs,type
local Horse_NewChane = msgh_s2c_def[17][3]
local GetMountsData = GetMountsData
local AddMountsAtt = AddMountsAtt
local UpDownMount = UpDownMount
local SendLuaMsg = SendLuaMsg
local GetServerTime=GetServerTime
local math_floor = math.floor
local GetRidingMountId = GetRidingMountId
local CI_SetSkillLevel = CI_SetSkillLevel
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos
local look = look
--------------------------------------------------------------------------
-- data:

local MouseChangeCard = {
	[300] = 2,
	[301] = 6,
	[302] = 1,
	[303] = 4,
	[304] = 3,
	[306] = 5,
	[305] = 7,
	[307] = 8,
	[308] = 9,
	[309] = 10,
	[310] = 11,
	[311] = 12,
	[312] = 13,
	[313] = 14,
	[314] = 15,
	[315] = 16,
	[318] = 17,
	[321] = 18,
}

local MouseChgeConf = MouseChgeConf

--������������
local function _SetMouseStyle(sid,id,ctype)
	look('_SetMouseStyle')
	if(ctype == nil or (ctype ~= 1 and ctype ~= 2))then
		--�û����Ͳ���
		return false,1
	end
	
	local mountsData = GetMountsData(sid)
	local newid = ctype*1000 + (sowar_getlv(sid)*100) + id
	if(nil == mountsData)then
		return false,2  --û����������
	end
	
	if(mountsData.id == newid)then
		return false,3 --��ǰ������������
	end
	
	local tb = MouseChgeConf[ctype][id]
	if(tb == nil)then
		--û�ҵ�ָ���û�����
		return false,4
	end
	
	if(ctype == 1)then --һ������
		if(mountsData.lv>=tb.level)then --�ѽ���
			mountsData.id = newid
		else
			return false,5 --δ����
		end
	elseif(ctype == 2)then --����û�����
		if(mountsData.extra == nil or mountsData.extra[id] == nil)then
			return false,6 --û������û�����
		end
		
		mountsData.id = newid
	end
	
	local mountid = GetRidingMountId()
	if(mountid>0)then --��������Ͼͻ���������
		--UpDownMount(sid,1)
		UpDownMount(sid,0)
	else
		CI_OperateMounts(1,-mountsData.id,0)
	end
	
	return true
end

--�û���ʹ�� id���⿨����
function MouseChangeProc(sid,cardid)
	look('MouseChangeProc')
	local mountsData = GetMountsData(sid)
	if(nil == mountsData)then
		return 0,1  --û����������
	end
	--look('cardid='..cardid)
	if(MouseChangeCard[cardid] == nil)then
		return 0,2 --û�д�����û�����
	end
	
	local id = MouseChangeCard[cardid]
	local tb = MouseChgeConf[2][id]
	if(tb == nil)then
		return 0,2 --û�д�����û�����
	end
	
	local enddate
	local v
	local haveIndex = -1
	if(mountsData.extra == nil)then mountsData.extra = {} end
	if(tb.h~=nil)then --��ʱЧ��
		local lv = mountsData.lv
		local limit = tb.limit
		if(limit~=nil and lv >= limit)then --������Ч
			mountsData.extra[id] = 1
		else
			local times = GetServerTime()
			local isnohave = true
			if(mountsData.extra~=nil)then --�����ʱЧ��
				if(mountsData.extra[id] == nil)then
					mountsData.extra[id] = {times + tb.h*60*60,limit}
				else
					v = mountsData.extra[id]
					if(v[1]>times)then
						v[1] = v[1] + tb.h*60*60
					else
						v[1] = times + tb.h*60*60
					end
					v[2] = limit
				end
			end
		end
	else
		if(mountsData.extra[id] == 1)then
			return 0,3
		else
			mountsData.extra[id] = 1
		end
	end
	_SetMouseStyle(sid,id,2)
	AddMountsAtt(sid)
	SendLuaMsg( 0, { ids = Horse_NewChane,ctb = id,type = 2}, 9 )
	return 1,mountsData
end
--������׺����
function CheckUnlockStyle(sid,lv)
	look('CheckUnlockStyle')
	if(lv == nil)then return end
	local data = GetMountsData(sid)
	if(nil == data)then return end
	local tb = MouseChgeConf[1]
	local len = #tb
	for i = 1,len do
		if(tb[i]~=nil and tb[i].level~=nil and tb[i].level == lv)then --����������ǰ̨
			if(_SetMouseStyle(sid,i,1))then
				--[[
				if(i == 2)then --Ŀ���ɣ����������Ϊ����Ѫ����
					set_obj_pos(sid,1005)
				elseif(i == 3)then --Ŀ���ɣ����������Ϊ���������� 
					set_obj_pos(sid,2006)
				elseif(i == 4)then --Ŀ���ɣ����������Ϊ��̫����ܡ�
					set_obj_pos(sid,3006)
				elseif(i == 6)then --Ŀ���ɣ����������Ϊ�������컢��
					set_obj_pos(sid,4006) --Ŀ���ɣ����������Ϊ�������컢��
				end
				]]--
				if(i == 2)then --Ŀ���ɣ����������Ϊ����Ѫ���� 
					set_obj_pos(sid,2006)
				elseif(i == 6)then --Ŀ���ɣ����������Ϊ�������컢��
					set_obj_pos(sid,4006)
				end
				if(tb[i].skill)then
					local result = CI_SetSkillLevel(1,tb[i].skill,1,13) --�������＼
				end
				return i
			end
		end
	end
	return 0
end

function temp_mounts(sid)
	local data = GetMountsData(sid)
	if(data~=nil and data.lv~=nil)then
		local lv = data.lv
		if(lv >= 10)then --Ŀ���ɣ����������Ϊ����Ѫ���� 
			set_obj_pos(sid,2006)
		end
		if(lv >= 50)then --Ŀ���ɣ����������Ϊ�������컢��
			set_obj_pos(sid,4006)
		end
	end
end

--��ȡ���ﵱǰ�׵�����ID
local function _get_level_style(sid)
	local mountsData = GetMountsData(sid)
	if(nil == mountsData)then
		return --û����������
	end
	local lv = mountsData.lv
	local tb = MouseChgeConf[1]
	local len = #tb
	local curidx
	for i = 1,len do
		if(tb[i]~=nil and tb[i].level~=nil)then
			if(lv>=tb[i].level)then
				curidx = i
			else
				break
			end
		end
	end
	
	return curidx
end

--�������ʱЧ��
function checkMouseEndTime(sid)
	local mountsData = GetMountsData(sid)
	if(nil == mountsData or mountsData.extra == nil)then
		return  --û����������
	end
	
	local extraData = mountsData.extra
	local hid = mountsData.id
	local lv = mountsData.lv
	local ctype = math_floor(hid/1000)
	local id = hid%100
	local mountsID = ctype*1000 + id
	
	local newextra
	local removeTb
	local curServerTime = GetServerTime()
	local overID --���������ID
	for idx,v in pairs(extraData) do
		if type(idx) == type(0) and type(v) == type({}) then
			if(v[1]<curServerTime)then --����
				if(v[2]~=nil and lv>=v[2])then
					extraData[idx] = 1
				else
					if(removeTb == nil)then removeTb = {} end
					removeTb[#removeTb+1] = idx
					extraData[idx] = nil
					overID = 2000 + idx
					if(mountsID == overID)then --����ڵ��ǵ�ǰ�û�������Ϊ��ǰ������
						local curidx = _get_level_style(sid)
						mountsData.id = 1000 + (sowar_getlv(sid)*100) + curidx
						
						_SetMouseStyle(sid,id,ctype)
						local mountid = GetRidingMountId()
						if(mountid>0)then --��������Ͼͻ���������
							--UpDownMount(sid,1)
							UpDownMount(sid,0)
						else
							CI_OperateMounts(1,-mountsData.id,0)
						end
					end
				end
			else
				if(v[2]~=nil and lv>=20)then
					extraData[idx] = 1
				end
			end
		end
	end
	
	if(removeTb~=nil)then
		SendLuaMsg( 0, { ids = Horse_NewChane,ctb = removeTb,type = 3}, 9 )
	end
end

SetMouseStyle = _SetMouseStyle