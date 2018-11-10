--[[
Manor_Dog.lua
ׯ԰������
xiao.y
]]--

--s2c_msg_def
local Pet_Data = msgh_s2c_def[38][1]	-- ��������
local Pet_Buy = msgh_s2c_def[38][2]	-- �������
local Pet_Set = msgh_s2c_def[38][3]	-- �û�����
local look = look
local pairs,type = pairs,type
local Manor_PetConf,GiveGoods,SendLuaMsg = Manor_PetConf,GiveGoods,SendLuaMsg

----------------------------------------------------------------------------
--inner function:


----------------------------------------------------------------------------
--interface:

--��ȡ��������	(��������)				  
function GetPetData(sid)
	if( sid == nil or sid == 0 )then return end
	
	local pManorData = GetPlayerManorData(sid)
	if pManorData == nil then return end
	
	return pManorData.PetD
end

-- ���ͳ�������
function SendPetData(sid)
	look("SendPetData:" .. sid)
	if( sid == nil or sid == 0 )then return end
	local pManorData = GetPlayerManorData(sid)
	if pManorData == nil then return end
	SendLuaMsg( 0, { ids=Pet_Data, data = pManorData.PetD }, 9 )
end

--����������� idx ���û�����
function BuyPetStyle(sid,idx)
	if idx == nil then return end
	local petData = GetPetData(sid)
	if petData == nil then return end --��ȡ������ʧ��
	
	local conf = Manor_PetConf[idx]
	if(conf == nil or conf.cost == nil or conf.day == nil) then return end --��ȡ������ʧ��(��Ǯ�Ǳ����,�������ǲ��еģ�

	-- �ж��Ƿ����
	if petData[idx] and petData[idx] > 0 then
		SendLuaMsg( 0, { ids = Pet_Buy, res = 1, idx = idx }, 9 )
		return
	end
	
	local cost = conf.cost
	local day = conf.day
	
	if not CheckCost(sid,cost,0,1,"100024_�����������") then	--Ԫ������
		SendLuaMsg( 0, { ids = Pet_Buy, res = 2, idx = idx }, 9 )
		return  
	end
	
	petData[idx] = day
	SendLuaMsg( 0, { ids = Pet_Buy, res = 0, idx = idx }, 9 )
	return
end

--���ù��û�
function SetPetStyle(sid,idx)
	if idx == nil then return end
	local petData = GetPetData(sid)
	if petData == nil then return end
	if petData.id == idx then			--��ǰ����������
		SendLuaMsg( 0, { ids = Pet_Set, res = 1, idx = idx }, 9 )
		return 
	end 
	if idx ~= 1 and petData[idx] == nil then
		SendLuaMsg( 0, { ids = Pet_Set, res = 2, idx = idx }, 9 )
		return
	end
	
	petData.id = idx
	look(petData.id)
	SendLuaMsg( 0, { ids = Pet_Set, res = 0, idx = idx }, 9 )
	return
end

-- ÿ������ʱ���ٹ���ʱЧ����
function checkPetTime(sid,days)
	if days == nil or type(days) ~= type(0) then return end
	local petData = GetPetData(sid)
	if petData == nil then return end
	
	for idx,left in pairs(petData) do
		if type(idx) == type(0) and type(left) == type(0) then
			left = left - days
			if left <= 0 then
				petData[idx] = nil
				if petData.id == idx then
					petData.id = 1
				end
			else
				petData[idx] = left
			end			
		end
	end
		
	SendLuaMsg( 0, { ids=Pet_Data, data = petData }, 9 )
end

-- ��ȡ������Ϣͳһ�ӿ� (����ׯ԰�Ӷ�)
function PI_GetPetInfo(sid)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	local petID = PI_GetPetID(sid)
	if petID == nil then return end
	local petConf = Manor_PetConf[petID]
	if petConf == nil then return end
	local mLv = pManorData.mLv
	
	local PetInfo = GetRWData(2)

	PetInfo.n = petConf.name
	PetInfo.lv = petConf.mLv
	PetInfo.id = petConf.rid					
	PetInfo.skid = petConf.skill
	PetInfo.sklv = petConf.skilllevel

	for k, v in pairs(Manor_PetConf.attr) do
		if type(k) == type(0) and type(v) == type({}) and #v == 2 then
			PetInfo.att[k] = rint((PetInfo.att[k] or 0) + v[1] + mLv * mLv * 1.2 * 1.2 * v[2])
		end
	end
	return true
end
