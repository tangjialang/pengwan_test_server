--[[
author:	chal
update:	2013-10-24
notes: ��������lua�ڴ����
]]--

--local snapshot = require "snapshot"
local common 			= require('Script.common.Log')
local Log 				= common.Log

-- ������������ɻ�ÿ��sreset�����ɳ�ʼ����s_shot
-- ��һ��Ҫsresetǰ���Զ�����һ�ζԱȣ�Ŀǰֻ�ڵ��԰濪����������������ִ��Ч�ʶ�����
-- �ط�ǰ����ܹ��ֶ�ִ��һ�ζԱȣ��ٹط�
-- ����ʱ������ֶ�����TI_Snapshot()����һ�ζԱ�

local s_shot
g_cur_index = g_cur_index or 0
function TI_Snapshot(bcreate)
	if bcreate then
		--������ʼ����
		s_shot = snapshot()	
		look("TI_Snapshot create",1)	
		return
	end

	--��õ�ǰ����
	local e_shot = snapshot()
	
	--���浱ǰ�ڴ���գ����ڲ��
	local filename = "all_snapshot_"..tostring(g_cur_index)..".txt"	
	Log(filename,e_shot)
	
	--�ԱȲ��������
	filename = "cmp_snapshot_"..tostring(g_cur_index)..".txt"		
	for k,v in pairs(e_shot) do
		if s_shot[k] == nil then
			Log(filename,"["..tostring(k).."] = "..tostring(v)..".")
		end
	end
	
	g_cur_index = g_cur_index + 1
end
