--[[
file:	PI_interface.lua
desc:	package for 'ci_xxx' function
author:	chal
update:	2013-07-02
refix: done by chal
todo: coding to module 
]]--
--------------------------------------------------------------------------
--include:
local type = type
local CreateObjectIndirect = CreateObjectIndirect
local look = look
local tablepush = table.push
local RemoveObjectIndirect = RemoveObjectIndirect
local GiveGoodsBatch = GiveGoodsBatch
local SendSystemMail = SendSystemMail
--------------------------------------------------------------------------
--interface:
local GIDList = {}
local ControlIDList = {}

--[[
	�´���npcһ�ɵ����½ӿڣ�����ʹ�� CreateObjectIndirect ����������controlId
	400000��ǰ�Ƕ�̬����������ã�ֻҪ��֤���ظ�������Ϊ��������ͨnpc��������npc�Ͳɼ��� npc�ȣ�
	��̬npc�� ����Ϸ��400000-500000
	500000-600000������
	600000-701000�����ֶΣ���������
	701000֮�� --- 1000000  ǧʵ��npc
	1000000֮��		��ʵ��npc
Notice:
	NPCID < 400000 Ϊ��̬NPC �ɷ�������������
	40000 < NPCID < 700000	��̬NPC������Ҫѭ�������ģ� �ɸ����ܻ����� 
	NPCID >= 700000			��̬NPC����Ҫѭ�������ģ� �ɸ����ܻ�����
]]--

-- iType [0] ���� [1] NPC
-- nID ���õĹ���ID��NPC ID
-- CreateInfo i98
-- num ѭ���������� ����Ҫѭ�������Ĳ����˲��� ��1 Ҳ����
function CreateObjectIndirectEx(iType,nID,CreateInfo,num,posList)
	--clear first
	for i = 1,#GIDList do
		GIDList[i] = nil
	end
	for i = 1,#ControlIDList do
		ControlIDList[i] = nil
	end
	if iType == 0 then
		
	elseif iType == 1 then
		if num == nil or num == 1 then
			CreateInfo.controlId = nID + 100000			-- ͳһ��100000
			if posList ~= nil and posList[1] ~= nil then
				local pos = posList[1]
				if pos[3] ~= nil then
					CreateInfo.regionId = pos[3]
				end					
				CreateInfo.x = pos[1]
				CreateInfo.y = pos[2]
			end
			local GID = CreateObjectIndirect(CreateInfo)
			look('CreateObjectIndirectEx:' .. tostring(GID))
			return GID,CreateInfo.controlId
		else			
			if nID < 701000 or nID >= 1000000 then				-- ѭ��������NPC npcidֻ�����������
				look("CreateObjectIndirectEx nID erro")
			end
			for i = 0, num - 1 do
				CreateInfo.controlId = nID + 100000 + i			-- ͳһ��100000
				if posList ~= nil and posList[i + 1] ~= nil then
					local pos = posList[i + 1]
					if pos[3] ~= nil then
						CreateInfo.regionId = pos[3]
					end					
					CreateInfo.x = pos[1]
					CreateInfo.y = pos[2]
				end 
				local GID = CreateObjectIndirect(CreateInfo)
				if not GID then
					look('CreateObjectIndirect_err__'..tostring(CreateInfo.controlId))
				end
				tablepush(GIDList,GID)
				tablepush(ControlIDList,CreateInfo.controlId)	
			end
			return GIDList,ControlIDList
		end
	else
		look("CreateObjectIndirectEx param erro")
	end
end

-- iType [0] ���� [1] NPC
-- rID ����ID
-- nID ���õĹ���ID��NPC ID ע�⣺���ﲻ�ܴ�controlID
-- num ѭ��ɾ������ ����Ҫѭ�������Ĳ����˲���
function RemoveObjectIndirectEx(iType,rID,nID,num)
	if iType == 0 then
		
	elseif iType == 1 then
		if num == nil then
			local controlId = nID + 100000			-- ͳһ��100000
			RemoveObjectIndirect(rID,controlId)			
		else
			for i = 0, num - 1 do
				local controlId = nID + 100000 + i			-- ͳһ��100000
				RemoveObjectIndirect(rID,controlId)				
			end
		end
	else
		look("RemoveObjectIndirectEx param erro")
	end
end

-- �������㷢�ʼ���ͳһ�ӿ�
-- ���ڸ���Ʒ�Ľӿڱ���ǿ�Ƽ���־
function PI_GiveGoodsEx(sid,config,num,MailType,Contents,ItemList,StayMin,LogInfo)
	look('PI_GiveGoodsEx1')
	look(LogInfo)
	if sid == nil or ItemList == nil or LogInfo == nil then return end
	look(ItemList)
	if type(ItemList) == type({}) then
		local succ, retCode, num = GiveGoodsBatch( ItemList,LogInfo,2,sid)	
		if not succ and retCode == 3 then	--�������㷢�ʼ�
			local pName = PI_GetPlayerName(sid)
			if type(pName) == type('') then
				local AwardList = {[3] = ItemList}
				SendSystemMail(pName,config,num,MailType,Contents,AwardList,StayMin)	
			end
		end
	end
end

--��װCI_MovePlayer,��Ҫ��Ի���
function PI_MovePlayer(regionid, x, y, mapgid, itype,playerSID)
	
	if regionid==0 then
		if escort_not_trans(playerSID) then --����״̬���ܴ���̬ͼ
			look('escort_not_trans')
			return
		end
	end
	local res=limit_lv_zl( regionid)--ս���ȼ�����
	if not res then return end
	
	local res  =CI_MovePlayer(regionid, x, y, mapgid, itype,playerSID) 
	if not res then
		return res
	end
	return res
end
--CI_PayPlayer,��������ȼ��ӳ�
function PI_PayPlayer(itype,value,arg1,arg2,info,object,id)
	if itype==1 and value >0 then
		local plv=CI_GetPlayerData(1,object,id)
		if plv >39 then
			local wlv=GetWorldLevel() or 0
			if wlv-plv>=10 then
				value=value*2
			elseif wlv-plv>=5 then
				value=rint(value*1.5)
			end
		end
	end
	return CI_PayPlayer(itype,value,arg1,arg2,info,object,id)
end
--����ÿ�յ�������
function PI_SetEnvironment(arg)
	CI_SetEnvironment(arg[1],arg[2])
end
--����Ѳ�����鱶��
function  PI_Set_xunhang( arg )
	if arg >0  then
	 	CI_SetEnvironment(1,arg,3)
	elseif arg ==0 then
		CI_SetEnvironment(1,1,-1) --ȡ����������
	end
end