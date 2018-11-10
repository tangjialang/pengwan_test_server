--[[
file:	dragon_conf.lua
desc:	����ϵͳ �����ļ�
author:	zhongsx
update:	2015-3-16
]]--

local rint = rint
local look = look

---------------
module(...)
-----------------
--[[
��������	INT(��ǰ�ȼ�+3)		
����	�̶�10		
��Ѫ	INT(�ȼ�*100+�ȼ�^2)*48		
����	INT(�ȼ�*100+�ȼ�^2)*6		
����	INT(�ȼ�*100+�ȼ�^2*0.8)*6		
���Թ���	INT(�ȼ�*100+�ȼ�^2*0.8)*6		
������	INT(�ȼ�*100+�ȼ�^2*0.6)*6		
]]--


local CAT_MAX_HP	= 1		-- Ѫ������
local CAT_S_ATC  	= 2		-- ְҵ����
local CAT_ATC  		= 3		-- ����
local CAT_DEF		= 4		-- ����
local CAT_S_DEF1	= 10		-- ��ϵ����
local CAT_S_DEF2	= 11		-- ��ϵ����
local CAT_S_DEF3	= 12		-- ľϵ����

conf = {
	[1] = 90, --maxlv
	[2] = 10, --���ٵȼ���һ��
	[3] = 1601, --���꾫�� ����ID		
}

--ÿһ��������Ҫ���ٵ���
each_item = function(lv)
	return (lv + 1 + 3)
end

--��ǰlv�ȼ�������һ���ܹ���Ҫ���ٽ���
max_proc = function(lv)
	return 20
end

att_func = {
	--Ѫ������
	[CAT_MAX_HP] = function(lv)
		return rint((lv * 100 + lv ^ 2) * 48)
	end,
	--ְҵ����
	[CAT_S_ATC] = function(lv)
		return rint( (lv * 100 + (lv ^ 2) * 0.8) *6)
	end,
	--����
	[CAT_ATC] = function(lv)
		return rint( (lv * 100 + lv ^ 2) * 6)
	end,
	--����
	[CAT_DEF] = function(lv)
		return rint( (lv * 100 + (lv ^ 2) * 0.8) *6)	
	end,
	--��ϵ����
	[CAT_S_DEF1] = function(lv)
		return rint( (lv * 100 + (lv ^ 2) * 0.6) *6)
	end,
	--��ϵ����
	[CAT_S_DEF2] = function(lv)
		return rint( (lv * 100 + (lv ^ 2) * 0.6) *6)
	end,
	--ľϵ����
	[CAT_S_DEF3] = function(lv)
		return rint( (lv * 100 + (lv ^ 2) * 0.6) *6)
	end,
}