--[[
file:	Faction_Conf.lua
desc:	����������
author:	zhongsx
update:	2014-11-13
version: 1.0.0
]]--

local rint = rint
local look = look
module(...)

-- ���� ���� ���������� 
NumFeeProgress_Conf = { 
	[1] = {20, 6, 10},
	[2] = {30, 10, 15},
	[3] = {40, 11,	 16},
	[4] = {50, 12, 16},
	[5] =	{70, 14, 17},
	[6] = {90, 18, 22},
	[7] = {120, 20, 24},
	[8] = {150, 25, 30},
	[9] = {190, 27, 31},
	[10] = {230, 32, 38},
	[11] = {280, 35, 40},
	[12] = {330, 41,	 47},
	[13] = {390, 43, 48},
	[14] = {450, 50,56},
	[15] = {520, 57, 65}
}

--��������
Other_Conf = {
	--��������ID,  ͻ�Ƶ���ID  ����
	items = {{1585, 2},  {1585, 2} },
	--���ư��ȼ�
	limit_faction_level = 7,
	--define from player_attribute.lua
	CAT_MAX_HP		= 1,		-- Ѫ������
	CAT_S_DEF1	  	= 10,		-- ��ϵ����
	CAT_S_DEF2	  	= 11,		-- ��ϵ����
	CAT_S_DEF3	  	= 12,		-- ľϵ����
	CAT_ICE_ATC  	= 2,		-- ְҵ����
	--tain type
	TAIN_TYPE_YB	= 1,		--ʹ��Ԫ������
	TAIN_TYPE_ITEM	= 2,   --ʹ�õ�������

	break_exp = 1,
	--����λ20
	Max_Class_Level = 20,
	--������ܴﵽ�����ȼ�
	Max_Level = 200,
}

--������  ��Ѫ, ����, ����, ���׽���, ͻ�Ƽ���,��ǰ��λ���/С�ȼ� �㷨����
Func_Conf = {}

--��Ѫ hp
Func_Conf[Other_Conf.CAT_MAX_HP] = function (level)
	return rint((level * 200 + level ^ 2 ) * 8)
end
--���Թ��� atttack
Func_Conf[Other_Conf.CAT_ICE_ATC]	= function(level)
	return rint(level * 200 + level  ^ 2)
end
--���Է���
Func_Conf[Other_Conf.CAT_S_DEF1]  = function(level)
	return rint((level * 200 + level  ^ 2 ) *0.8)
end

Func_Conf[Other_Conf.CAT_S_DEF2] = Func_Conf[Other_Conf.CAT_S_DEF1]  
Func_Conf[Other_Conf.CAT_S_DEF3] = Func_Conf[Other_Conf.CAT_S_DEF1]  

--ÿ���Ľ���
Func_Conf.progress = function(level)
	return rint( level * 10  + (level ^ 2 ) / 10 )
end
--�������������ĵ�������
Func_Conf.get_train_cost = function (level)
	return 5
end
--�����������ӵĽ���
Func_Conf.get_train_proc = function(level)
	return 1
end
--����ͻ�����ӵĽ���
Func_Conf.get_break_proc = function(level)
	return 1
end
--ͻ�����ĵ�����
--��ǰ����
Func_Conf.get_break_cost = function(class)
	return rint(class * 2 + 2)
end


--�ɹ���������, ͻ�ƴ���
Func_Conf.get_probability = function(break_num)
	--break_num = (((break_num - 50) > 0) and (break_num - 50) ) or 0
	--local  base_prob = 50 + (rint(break_num / 5) * 10 )+ rint(break_num % 5)	
	return (((break_num - 50) * 2) and ((break_num - 50) * 2)) or 0
end	
--��ȡ��ǰ��λ�����ȼ�����С�ȼ�
Func_Conf.get_maxmin_level = function(level)
	local tmp = Other_Conf.Max_Level / Other_Conf.Max_Class_Level 
	--local max_lv, min_lv = (rint(level % tmp) + 1) * tmp,  rint(level % tmp) * tmp
	local max_lv = (rint(level/tmp) + 1)*tmp
	local min_lv = (rint(level/tmp))*tmp
	
	--look("get_maxmin_level----"..level.."-----"..tmp.."----"..max_lv.."---"..min_lv)
	return max_lv, min_lv
end


	