--[[
	file:ׯ԰�Ƽ�
	author:	csj
--]]
local pairs,type,rint = pairs,type,rint
local ipairs = ipairs
--local UpdateHeroFight = UpdateHeroFight
local SendLuaMsg = SendLuaMsg
--s2c_msg_def
local MAT_Data = msgh_s2c_def[36][1]	-- �Ƽ�����
local MAT_UpLv = msgh_s2c_def[36][2] 	-- �Ƽ�����

--------------------------------------------------------------
--data:

local ManorTechConf = {
	-- [needLV]: ����ׯ԰�ȼ� [attr]: �������Ա���
	[1] = {needLV = 1,attr = {[3] = 2,[8] = 1.5}},		-- ����ѵ��
	[2] = {needLV = 5,attr = {[5] = 1.5,[7] = 1.5}},		-- ����ѵ��
	[3] = {needLV = 10,attr = {[1] = 10,[6] = 1.5}},		-- ����ѵ��
	[4] = {needLV = 15,attr = {[4] = 2,[9] = 1.5}},		-- ����ѵ��
	[5] = {needLV = 20,attr_D = {[1] = 15,[3] = 2,[4] = 3}},		-- ����ѵ��
	[6] = {needLV = 25},		-- ҡǮ��				
	[7] = {needLV = 30},		-- �Ӷ���
	[8] = {needLV = 40},		-- ������
}

------------------------------------------------------------------
--inner function:


------------------------------------------------------------------
--interface:

-- ����ׯ԰�Ƽ�
function MTC_UpLevel(sid,index)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	if pManorData.Tech == nil then 
		pManorData.Tech = {}
	end
	if ManorTechConf[index] == nil then 
		return
	end
	--look(index)
	local tecLV = pManorData.Tech[index] or 0
	if tecLV >= (pManorData.mLv or 1) then
		SendLuaMsg( 0, { ids = MAT_UpLv, res = 1 }, 9 )
		return
	end
	if pManorData.mLv < ManorTechConf[index].needLV then
		SendLuaMsg( 0, { ids = MAT_UpLv, res = 2 }, 9 )
		return
	end
	-- �ж�����
	tecLV = tecLV + 1
	local nCost = tecLV * tecLV * 100
	local cPoint = GetPlayerPoints(sid, 2)
	if cPoint == nil or cPoint < nCost then
		SendLuaMsg( 0, { ids = MAT_UpLv, res = 3 }, 9 )
		return
	end
	-- ������
	AddPlayerPoints(sid,2, - nCost,nil,'ׯ԰�Ƽ�')
	
	pManorData.Tech[index] = tecLV
	-- �����������
	--if ManorTechConf[index].attr then
	--	UpdateHeroFight(sid)
	--end
	-- look(pManorData.Tech)
	SendLuaMsg( 0, { ids = MAT_UpLv, res = 0, idx = index }, 9 )
end

-- ��ȡׯ԰�Ƽ��ȼ�
-- ע�⣺indexΪ�յ�����»ᷢ��Ϣ��ǰ̨(���ڵ�½Ҫ�� ����Ͳ�����)
function MTC_GetTecLv(sid,index)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil then return end
	if pManorData.Tech == nil then 
		pManorData.Tech = {}
	end
	if index then		
		return pManorData.Tech[index]
	else
		-- SendLuaMsg( sid, { ids = MAT_Data, data = pManorData.Tech }, 10 )
		return pManorData.Tech
	end
end

-- ��ȡ�Ƽ��ӳ�������Ա�
function MTC_GetHerosAttr(sid)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil or pManorData.Tech == nil then return end
	local tAttr = GetRWData(1)		-- �����Ա�
	for k, tecLV in pairs(pManorData.Tech) do
		if type(k) == type(0) and type(tecLV) == type(0) and tecLV > 0 then
			if ManorTechConf[k] and ManorTechConf[k].attr then
				for m, n in pairs(ManorTechConf[k].attr) do
					if tecLV <= 20 then
						tAttr[m] = rint((tAttr[m] or 0) + (tecLV * 10) * n)
					elseif tecLV <= 50 then
						tAttr[m] = rint((tAttr[m] or 0) + (20 * 10 + (tecLV - 20) * 20) * n)
					elseif tecLV <= 80 then
						tAttr[m] = rint((tAttr[m] or 0) + (20 * 10 + 30 * 20 + (tecLV - 50) * 50) * n)
					elseif tecLV <= 100 then
						tAttr[m] = rint((tAttr[m] or 0) + (20 * 10 + 30 * 20 + 30 * 50 + (tecLV - 80) * 100) * n)
					end
				end
			end
		end
	end
	return tAttr
end

-- ��ȡ�Ƽ��ӳɳ������Ա�
function MTC_GetPetAttr(sid)
	local pManorData = GetManorData_Interf(sid)
	if pManorData == nil or pManorData.Tech == nil then return end
	local tAttr = GetRWData(1)		-- �����Ա�
	local rint = rint
	local pairs = pairs
	for k, tecLV in pairs(pManorData.Tech) do
		if type(k) == type(0) and type(tecLV) == type(0) and tecLV > 0 then
			if ManorTechConf[k] and ManorTechConf[k].attr_D then
				for m, n in pairs(ManorTechConf[k].attr_D) do
					if tecLV <= 20 then
						tAttr[m] = rint((tAttr[m] or 0) + (tecLV * 10) * n)
					elseif tecLV <= 50 then
						tAttr[m] = rint((tAttr[m] or 0) + (20 * 10 + (tecLV - 20) * 20) * n)
					elseif tecLV <= 80 then
						tAttr[m] = rint((tAttr[m] or 0) + (20 * 10 + 30 * 20 + (tecLV - 50) * 50) * n)
					elseif tecLV <= 100 then
						tAttr[m] = rint((tAttr[m] or 0) + (20 * 10 + 30 * 20 + 30 * 50 + (tecLV - 80) * 100) * n)
					end
				end
			end
		end
	end
	return tAttr
end

