--[[
file:	Task_EventConf.lua
desc:	task events define.
author:	����
update:	2011-09-23
notes:
����������ͷ��ʽ +HighLight
 * @param ���
		 * @param ����(���Ϊxml�����xml��ʾ)
		 * @param �Ƿ�����ʧ
		 * @param x����(��Χ��Ч)
		 * @param y����(��Χ��Ч)
		 * @param ��(��Χ��Ч)
		 * @param ��(��Χ��Ч)
		 * @param ��ͷ����
		 * @param �رջص�����
		 * @param Ҫָ�����ƷID
		 * @param �Ƿ�رյ�ǰ���
		 * @param ������¼�
		 * @param ���������˵������

		 
		 
	�������������ʽ showGuide  * ��������������� 
		 * @param ��Ʒ���
		 * @param ��ʾ��Ϣ
		 * @param ��ť����	 
		 * @param ������¼�
		 * @param ����Ƕ�̬���ɵ��ߣ���ʾָ������
		 * @param �Ƿ������½���ʾ
		 
	Ʈ����ʾ���
		addNewTip
		@param ���ݣ�<a href='event:DDayPanel 2'><u><b><font color='#80f080'>��</font></b><u></a>��
		@param hightligng���� ͬRegStep
	
	
	* ��������(ǿ������)
		 * @param ���
		 * @param ����
		 * @param x����(��Χ��Ч)
		 * @param y����(��Χ��Ч)
		 * @param ��(��Χ��Ч)
		 * @param ��(��Χ��Ч)
		 * @param ��ͷ����
		 * 
		 * */

	newGuide(DMainPanel,"�����õİ���������",495,50,44,63,4)
	newGuide(DMainStatePanel,"�����õİ�2��������",129,53,70,23,0)
	closeNewGuide('�Զ�Ѱ·ָ��')
	
]]
--------------------------------------------------------------------------
--include:
local pairs = pairs
local ipairs = ipairs
local CI_GetPlayerData = CI_GetPlayerData
local new_guide = require('Script.new_guide.fun')
local set_guide = new_guide.set_guide
local CI_AddBuff,CI_DelBuff = CI_AddBuff,CI_DelBuff
--------------------------------------------------------------------------
-- data:

local _call_accept_task = {
}

local _call_submit_task = {
}

--ǰ�ڼ���
_call_accept_task[1001] = function ()
	--CI_AddBuff(351,0,1,false)
end
--37.com�ƺ�����
_call_accept_task[1010] = function ()
	if __plat == 103 then  --37�ƺ�
		local sid = CI_GetPlayerData(17)
		if 	SetPlayerTitle(sid,47) == 1 then  --�Ѿ��гƺ�
			TipCenter(GetStringMsg(15))
			return 0
		end
		SetShowTitle(sid,{47,0,0,0})
	end
	if __plat == 160 then  --���ҳƺ�
		local sid = CI_GetPlayerData(17)
		if 	SetPlayerTitle(sid,58) == 1 then  --�Ѿ��гƺ�
			TipCenter(GetStringMsg(15))
			return 0
		end
		SetShowTitle(sid,{58,0,0,0})
	end
end
--���ջ���������
_call_accept_task[1054] = function ()
	set_guide(CI_GetPlayerData(17),0,1,1006,112) --��������
	CI_AddBuff(13,0,1,false)	--����BUFF
	--set_guide(playerid,0,0) --ȡ����������
	--TipMB("����ϵͳ����ѡ��")
	--GiveMounts(CI_GetPlayerData(17))
end
--ȡ����������
_call_accept_task[1058] = function ()
	--set_guide(playerid,0,1,1007) --��������
	set_guide(CI_GetPlayerData(17),0,0) --ȡ����������
	GiveMounts(CI_GetPlayerData(17))
	CI_DelBuff(351)
end

--���ŭ�����
_call_accept_task[1104] = function ()
	local sid = CI_GetPlayerData(17)
	local ret = PI_PayPlayer(4,-300,0,0,'ŭ������',2,sid)
	local ret = PI_PayPlayer(4,300,0,0,'ŭ������',2,sid)
end
--���ŭ�����
_call_accept_task[1171] = function ()
	local sid = CI_GetPlayerData(17)
	local ret = PI_PayPlayer(4,-300,0,0,'ŭ������',2,sid)
	local ret = PI_PayPlayer(4,300,0,0,'ŭ������',2,sid)
end

--��õ�һ���ҽ�
_call_accept_task[1115] = function ()
	GiveHeroFirst(CI_GetPlayerData(17))
end
--���鴫��
_call_accept_task[1178] = function ()
	PI_MovePlayer(8,67,135)
end

--ͭǮ����
_call_accept_task[1181] = function ()
	PI_MovePlayer(1,61,64)
end

--��ʯ����
_call_accept_task[1324] = function ()
	PI_MovePlayer(1,61,64)
end

--���鸱��
_call_accept_task[1377] = function ()
	PI_MovePlayer(1,46,86)
end

--���ͺ�����
_call_accept_task[2027] = function ()
	PI_MovePlayer(1,82,76)
end


--������ɱ���鴫��
_call_accept_task[1179] = function ()
	PI_MovePlayer(8,57,58)
end

--����VIP����
_call_accept_task[1150] = function ()
	VIP_SetTemp(CI_GetPlayerData(17))
end


--ħ���ֵܸ����㴫��
_call_accept_task[1375] = function ()
	PI_MovePlayer(10,12,13)
end
_call_accept_task[1403] = function ()
	PI_MovePlayer(10,12,13)
end
_call_accept_task[1409] = function ()
	PI_MovePlayer(10,12,13)
end
_call_accept_task[1413] = function ()
	PI_MovePlayer(10,12,13)
end


--����ĳ��������ʱ���Զ������ַ��ճ�����
_call_accept_task[1404] = function ()
	-- �ж���� ���յ��ַ��ճ����ܻ����û�У�û�оͰ�����
	--�����4001
	local sid = CI_GetPlayerData(17)
	TS_AcceptTask(sid,4001,0)
	TS_AcceptTask(sid,4950,0)
	
	--����1�α�ʯ��������
	--CheckTimes(sid,TimesTypeTb.CS_Jewel,1,0)		
	
	
end


_call_accept_task[2005] = function ()
	local ret = PI_PayPlayer(4,-300,0,0,'ŭ������',2,CI_GetPlayerData(17))
		local school = CI_GetPlayerData(2)
		if school == 1 then
			CI_SetSkillLevel(1,108,1,12)
		elseif school == 2 then
			CI_SetSkillLevel(1,123,1,12)
		elseif school == 3 then
			CI_SetSkillLevel(1,124,1,12)
		end
		
end

--���ܵ�½��֧������
_call_accept_task[1106] = function ()
	--����ƽ̨û�е�½��֧������
	--if __plat ~= 102 then
	--	TS_AcceptTask(CI_GetPlayerData(17),3042,0)
	--end
	
end

--��ɼ�����󣬰�������ճ�����
_call_submit_task[3001] = function ()
	--�ж���� ���յİ���ճ����ܻ����û�У���û�оͰ�����
	--��ҵȼ� < 40  ����4101 ���� >= 40  ����4106  >= 45 ���� 4111����
	local taskid = 4101 
	local level = CI_GetPlayerData(1)
	if level >= 45 then 
		taskid = 4111
	elseif level >= 40 then 
		taskid = 4106
	end
	TS_AcceptTask(CI_GetPlayerData(17),taskid,0)
end


--���50������󣬰�æ�ӿ���ճ�
_call_submit_task[1435] = function ()
	local sid = CI_GetPlayerData(17)
	TS_AcceptTask(sid,4900,0)
end
----------------------------------------------------
--interface:

call_accept_task  	= _call_accept_task
call_submit_task	= _call_submit_task

