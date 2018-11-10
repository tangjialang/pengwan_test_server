--[[
file:	wing_fun.lua
desc:	���
author:	xiao.y
updator: zhongsx 
]]--
--------------------------------------------------------------------------
--include:
local CI_SetPlayerIcon  = CI_SetPlayerIcon -- 6
local CI_GetPlayerIcon  = CI_GetPlayerIcon
local GI_GetPlayerData = GI_GetPlayerData
local PI_UpdateScriptAtt = PI_UpdateScriptAtt
local GetRWData = GetRWData
local math_floor = math.floor
local math_ceil = math.ceil
local math_random = math.random
local CI_GetPlayerData = CI_GetPlayerData
local osdate = os.date
local GetServerTime = GetServerTime
local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond
local Wing_Data = msgh_s2c_def[20][11]
local SendLuaMsg = SendLuaMsg
local Wing_HLUpdate = msgh_s2c_def[20][13]
local Wing_OtherDate = msgh_s2c_def[20][14]
local CI_UpdateBuffExtra = CI_UpdateBuffExtra
local GetPlayer = GetPlayer
local GetServerOpenTime = GetServerOpenTime
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos

local rint = rint
local type = type
--------------------------------------------------------------------------
-- data:
--[[
  	CAT_MAX_HP	= 0,		// Ѫ������ 1
	CAT_MAX_MP,				// ְҵ���� 2
	CAT_ATC,				// ���� 3
	CAT_DEF,				// ���� 4
	CAT_HIT,				// ���� 5
	CAT_DUCK,				// ���� 6
	CAT_CRIT,				// ���� 7
	CAT_RESIST,				// �ֿ� 8
	CAT_BLOCK,				// �� 9
	CAT_AB_ATC,				// ְҵ����1����ϵ���ԣ� 10
	CAT_AB_DEF,				// ְҵ����2����ϵ���ԣ� 11
	CAT_CritDam,			// ְҵ����3��ľϵ���ԣ�12
	CAT_MoveSpeed,			// �ƶ��ٶ�(Ԥ��) 13
	CAT_S_REDUCE,			// ���Լ���	      14
]]--
local wing_conf = {
	minSwitchLv = 10, --������С��Ч�ȼ�
	maxLv = 20, --�����ߵȼ� 
	maxskLv = 5, --������ߵȼ�
	cost = {lq = 100000,goodid = 767,num = {1,2,3,5,8}},--lq ���� ��Ҫ����100000ͭǮ ��ӡ goodid ��ӡ��ID num ��������Ԫ��
	upgoodid = {762,10}, --{�����������,��ֵԪ����
	wing = { -- name ������� rs ��ԴID ico �������ͼ�� minV ��С����ֵ maxV �������ֵ yl �����ʹ�ø��� yh ����ʹ�ø��� num ���ܸ���
		[1] = {name = '����֮��', rs = 4, ico = 1, minV = 150, maxV = 215, yl = 0,yh = 0, num = 0},
		[2] = {name = '��ѩ֮��', rs = 3, ico = 2, minV = 321, maxV = 428, yl = 0,yh = 0, num = 1},
		[3] = {name = '��ʹ֮��', rs = 6, ico = 3, minV = 928, maxV = 1160, yl = 0,yh =600, num = 2},
		[4] = {name = '����֮��', rs = 2, ico = 4, minV = 1785, maxV = 2100, yl = 10,yh = 600, num = 3},
		[5] = {name = '�ڰ�֮��', rs = 5, ico = 5, minV = 4600, maxV = 5111, yl = 20,yh = 600, num = 4},
		[6] = {name = '�ǳ�֮��', rs = 3, ico = 6, minV = 9000, maxV = 9473, yl = 30,yh = 600, num = 5},
		[7] = {name = '��֮��', rs = 7, ico = 7, minV = 10000, maxV = 12002, yl = 50,yh = 600, num = 6},
		[8] = {name = 'ʥ��֮��', rs = 8, ico = 8, minV = 12000, maxV = 15050, yl = 50,yh = 600, num = 6},
		[9] = {name = '����֮��', rs = 9, ico = 9, minV = 15000, maxV = 19252, yl = 50,yh = 600, num = 6},
		[10] = {name = '����֮��', rs = 10, ico = 10, minV = 0, maxV = 0, yl = 100,yh = 600, num = 6},
		[11] = {name = '���ħ��', rs = 11, ico = 11, minV = 0, maxV = 0, yl = 100,yh = 600, num = 6},
	},
	att={--�����������ֵ
		[1]={500,200,160,100,100},
		[2]={1500,600,480,300,300},
		[3]={3500,1400,1120,600,600},
		[4]={7000,2800,2240,1000,1000},
		[5]={13000,5800,4640,1800,1800},
		[6]={21000,9800,7840,2800,2800},
		[7]={31000,14800,11840,4000,4000},
		[8]={42000,20300,16240,5100,5100},
		[9]={54000,26300,21040,6400,6400},
		[10]={69000,33800,27040,7900,7900},
		[100]={100,50,25,10,5,},--�����������
	},
	goods = { --������ ��Ӧ ����
		[1411] = {42,1,1,2}, --��Ѫǿ��{type,lv,����(1-4)
		[1412] = {43,1,2,2},
		[1413] = {44,1,3,2},
		[1414] = {45,1,4,2},
		[1415] = {46,1,nil,2},
		[1416] = {52,1,1,2}, 
		[1417] = {53,1,2,2},
		[1418] = {54,1,3,2},
		[1419] = {55,1,4,2},
		[1420] = {56,1,nil,2},
		[1421] = {67,1,1,4}, 
		[1422] = {68,1,2,4},
		[1423] = {69,1,3,4},
		[1424] = {70,1,4,4},
		[1425] = {71,1,nil,4},
		[1426] = {62,1,1,4}, 
		[1427] = {63,1,2,4},
		[1428] = {64,1,3,4},
		[1429] = {65,1,4,4},
		[1430] = {66,1,nil,4},
		[1431] = {57,1,1,6}, 
		[1432] = {58,1,2,6},
		[1433] = {59,1,3,6},
		[1434] = {60,1,4,6},
		[1435] = {61,1,nil,6},
		[1436] = {47,1,1,6}, 
		[1437] = {48,1,2,6},
		[1438] = {49,1,3,6},
		[1439] = {50,1,4,6},
		[1440] = {51,1,nil,6},
	},
	limit = {
		[42] = 11,
		[43] = 12,
		[44] = 13,
		[45] = 14,
		[46] = 15,
		[47] = 21,
		[48] = 22,
		[49] = 23,
		[50] = 24,
		[51] = 25,
		[52] = 31,
		[53] = 32,
		[54] = 33,
		[55] = 34,
		[56] = 35,
		[57] = 41,
		[58] = 42,
		[59] = 43,
		[60] = 44,
		[61] = 45,
		[62] = 51,
		[63] = 52,
		[64] = 53,
		[65] = 54,
		[66] = 55,
		[67] = 61,
		[68] = 62,
		[69] = 63,
		[70] = 64,
		[71] = 65,
	},
	up = { --����������������
		--1��2 
		[1] = {{765,10}}, -- [����] = �������б��
		--2��3 
		[2] = {{765,20},{766,5}},
		--3��4 
		[3] = {{765,30},{766,10}},
		--4��5 
		[4] = {{765,50},{766,20}},

	},
	switch_conf = { 	--������������
		[1] =  function(level)  --hp
			return rint(level * 300 + (level ^ 2) / 5)
		end,
		[3] = function(level) --����
			return rint(level * 100 + (level ^ 2) /10)
		end,
		[4] = function(level) --����
			return rint(level * 100 + (level ^ 2) /10)
		end,
		[7] = function(level) -- ����
			return rint(level * 50 + (level ^ 2) / 20)
		end,
		[9] = function(level) --��
			return rint(level * 50 + (level ^ 2) / 20)
		end,
		[100] = {  --���֮�� id, ��һ��������������������
			[1] = 762, 
			[2] = function(level)
				return (30 + rint((level + 1) / 1.5))
			end,
			[3] = 10, --���򵥼�
		},
		[101] = { --����֮�� id, ��һ��������������������
			[1] = 766,
			[2] =	function(level)
				return (1 + rint((level + 1) / 30))
			end,
		}
	},
}
--[[
3058 	2���߲���ë	
3059 	3���߲���ë	
3060 	4���߲���ë	
3061 	5���߲���ë	
3062 	6���߲���ë
3068	7���߲���ë
3069	8���߲���ë
3070	9���߲���ë
]]--
local wing_goodconf = {
	[3058] = 2,
	[3059] = 3,
	[3060] = 4,
	[3061] = 5,
	[3062] = 6,
	[3068] = 7,
	[3069] = 8,
	[3070] = 9,
}
--[[
�������
data = {
	[1] = ��ǰ�ȼ�
	[2] = ��������ֵ
	[3] = �������
	[4] = ������
	[5] = ����ʱ��
	[6] = { --����
		[1] = {����ID,���ܵȼ�}
	},
	[7] = ��ǰ���� 10000+lv 10000 ��ͨ��� 20000 ������
	[8] = �������
	[9] = �������
}
]]--
--��ȡ�������					  
local function _get_wing_data(sid)
	if(sid == nil or sid == 0)then return end
	local wingdata = GI_GetPlayerData( sid , 'wing' , 250 )
	return wingdata
end
--������˵ĳ������
function wing_get_other_date(sid,name,t,r)
	if(sid == nil and name~=nil)then
		sid = GetPlayer(name) or 0
	end
	if(not IsPlayerOnline(sid))then
		SendLuaMsg( 0, { ids = Wing_OtherDate, leave = 1 , t = t}, 9 )
		return
	end
	local wingdata=_get_wing_data(sid)
	if(r == nil)then
		SendLuaMsg( 0, { ids = Wing_OtherDate, data = wingdata , t = t}, 9 )
	else
		return wingdata
	end
end
--���¼���
local function _wing_update_att(sid,id,findid,bufflv,oldlv)
	local wingdata=_get_wing_data(sid)
	if(wingdata==nil or wingdata[1] == nil)then return end
	
	if(id == nil)then --��������
		local tempAtt=GetRWData(1)
		local lv = wingdata[1]
		local yl = wingdata[3] or 0
		local yh = wingdata[4] or 0
		local t = wingdata[5]
		local skill = wingdata[6]
		if(lv<=1 and t~=nil and GetServerTime()>t)then
			tempAtt[1]=0--��Ѫ
			tempAtt[3]=0--����
			tempAtt[4]=0--����
			tempAtt[7]=0--����
			tempAtt[9]=0--����
			PI_UpdateScriptAtt(sid,ScriptAttType.wing)
			CI_SetPlayerIcon(0,6,0,1)---��������
			return
		end
		
		--���Էֳ���������.. 10��ǰ 10����
		local f_lv = lv
		if lv > 10 then
			f_lv = 10
		end
		local attconf=wing_conf.att[f_lv]
		local addatt=wing_conf.att[100]
		tempAtt[1]=math_floor((attconf[1]+yh*addatt[1])*(yl*2+100)/100)--��Ѫ
		tempAtt[3]=math_floor((attconf[2]+yh*addatt[2])*(yl*2+100)/100)--����
		tempAtt[4]=math_floor((attconf[3]+yh*addatt[3])*(yl*2+100)/100)--����
		tempAtt[7]=math_floor((attconf[4]+yh*addatt[4])*(yl*2+100)/100)--����
		tempAtt[9]=math_floor((attconf[5]+yh*addatt[5])*(yl*2+100)/100)--��
		
		--������� ����ս����
		local switch_proc = wingdata[9] or 0  
		local switch_conf = wing_conf.switch_conf
		tempAtt[1] = tempAtt[1] + switch_conf[1](switch_proc)
		tempAtt[3] = tempAtt[3] + switch_conf[3](switch_proc)
		tempAtt[4] = tempAtt[4] + switch_conf[4](switch_proc)
		tempAtt[7] = tempAtt[7] + switch_conf[7](switch_proc)
		tempAtt[9] = tempAtt[9] + switch_conf[9](switch_proc)
		
		PI_UpdateScriptAtt(sid,ScriptAttType.wing)
	else
		look('���³����')
		look('�Ƴ������='..id..','..findid..','..bufflv)
		if(oldlv~=nil)then look('oldlv='..oldlv) end
		local b=CI_UpdateBuffExtra(id,findid,bufflv,oldlv)
		look(b)
	end
end
--ȡ��������Ϣ 1 �ȼ� 2 ����ֵ 3 ���� 4 ��� 
function wing_get_info(sid,t)
	local wingdata=_get_wing_data(sid)
	if(wingdata==nil or wingdata[1]==nil)then return end
	local val = wingdata[t]
	if(val == nil)then val = 0 end
	return val
end
--ȡ���ȼ���ս������ʽ
function wing_get_fpt(sid)
	local wingdata=_get_wing_data(sid)
	if(wingdata==nil or wingdata[1]==nil)then return 0,0 end
	local tempAtt=GetRWData(1)
	local lv = wingdata[1]
	local yl = wingdata[3] or 0
	local yh = wingdata[4] or 0
	
	--���Էֳ���������.. 10��ǰ 10����
	local f_lv = lv
	if lv > 10 then
		f_lv = 10
	end
	local attconf=wing_conf.att[f_lv]
	local addatt=wing_conf.att[100]
	tempAtt[1]=math_floor((attconf[1]+yh*addatt[1])*(yl*2+100)/100)--��Ѫ
	tempAtt[3]=math_floor((attconf[2]+yh*addatt[2])*(yl*2+100)/100)--����
	tempAtt[4]=math_floor((attconf[3]+yh*addatt[3])*(yl*2+100)/100)--����
	tempAtt[7]=math_floor((attconf[4]+yh*addatt[4])*(yl*2+100)/100)--����
	tempAtt[9]=math_floor((attconf[5]+yh*addatt[5])*(yl*2+100)/100)--��
	
	--������� ����ս����
	local switch_proc = wingdata[9] or 0  
	local switch_conf = wing_conf.switch_conf
	tempAtt[1] = tempAtt[1] + switch_conf[1](switch_proc)
	tempAtt[3] = tempAtt[3] + switch_conf[3](switch_proc)
	tempAtt[4] = tempAtt[4] + switch_conf[4](switch_proc)
	tempAtt[7] = tempAtt[7] + switch_conf[7](switch_proc)
	tempAtt[9] = tempAtt[9] + switch_conf[9](switch_proc)
	
	local pt = math_floor(tempAtt[3]+tempAtt[4]+tempAtt[1]*0.2+(tempAtt[7]+tempAtt[9])*1.3)
	return lv,pt
end

--gm�������
function wing_cgm(sid, icon)
	local wingData=_get_wing_data(sid)
	if(wingData==nil)then return end
	if(wingData[1] == nil)then
		wingData[1] = 1
		wingData[5] = GetServerOpenTime() + (24*3600)
		wingData[7] = 10001
		if icon == nil then 
			icon = 1
		end
		CI_SetPlayerIcon(0,6,icon,1)---��������
		local tempAtt=GetRWData(1)
		local attconf=wing_conf.att[1]
		local addatt=wing_conf.att[100]
		tempAtt[1]=math_floor(attconf[1])--��Ѫ
		tempAtt[3]=math_floor(attconf[2])--����
		tempAtt[4]=math_floor(attconf[3])--����
		tempAtt[7]=math_floor(attconf[4])--����
		tempAtt[9]=math_floor(attconf[5])--��
		PI_UpdateScriptAtt(sid,ScriptAttType.wing)
		SendLuaMsg( 0, { ids = Wing_Data, data = wingData, t = 0}, 9 )
	end
end
--ɾ�����
function wing_del(sid)
	--local icon = CI_GetPlayerIcon(0, 6)
	--look(icon)
	local wingData=_get_wing_data(sid)
	
	if(wingData~=nil and wingData[1]~=nil)then
		wingData[1] = nil
		wingData[2] = nil
		wingData[3] = nil
		wingData[4] = nil
		wingData[5] = nil
		wingData[6] = nil
		wingData[7] = nil
		wingData[9] = 0
		local tempAtt=GetRWData(1)
		tempAtt[1]=0--��Ѫ
		tempAtt[3]=0--����
		tempAtt[4]=0--����
		tempAtt[7]=0--����
		tempAtt[9]=0--����
		PI_UpdateScriptAtt(sid,ScriptAttType.wing)
		CI_SetPlayerIcon(0,6,0,1)---��������
		SendLuaMsg( 0, { ids = Wing_Data, data = wingData, t = 0}, 9 )
	end
end

--������
function wing_create(sid)
	look('��򴴽�')
	local wingData=_get_wing_data(sid)
	if(wingData==nil)then return end
	if(wingData[1] == nil)then
		local svrTime = GetServerOpenTime() --����ʱ��
		local dt = osdate("*t", svrTime)
		local sec = GetTimeToSecond(dt.year,dt.month,dt.day,0,0,0)
		local now = GetServerTime()
		dt = osdate("*t", now)
		local sec1 = GetTimeToSecond(dt.year,dt.month,dt.day,0,0,0)
		local times = now - sec
		if(times>=(5*24*3600))then --��6�쿪��
			wingData[1] = 1
			wingData[5] = sec1 + (24*3600*2)
			wingData[7] = 10001
			CI_SetPlayerIcon(0,6,1,1)---��������
			local tempAtt=GetRWData(1)
			local attconf=wing_conf.att[1]
			local addatt=wing_conf.att[100]
			look('--------------5-----------')
			tempAtt[1]=math_floor(attconf[1])--��Ѫ
			tempAtt[3]=math_floor(attconf[2])--����
			tempAtt[4]=math_floor(attconf[3])--����
			tempAtt[7]=math_floor(attconf[4])--����
			tempAtt[9]=math_floor(attconf[5])--��
			PI_UpdateScriptAtt(sid,ScriptAttType.wing)
			SendLuaMsg( 0, { ids = Wing_Data, data = wingData, t = 0}, 9 )
		end
	end
end

--���ÿ������
function wing_reset(sid,isref)
	if(IsSpanServer())then return end
	--look('���ÿ������')
	local wingData=_get_wing_data(sid)
	if(wingData==nil)then return end
	if(wingData[1] == nil)then
		local svrTime = GetServerOpenTime() --����ʱ��
		local dt = osdate("*t", svrTime)
		local sec = GetTimeToSecond(dt.year,dt.month,dt.day,0,0,0) or 0
		local now = GetServerTime()
		local times = now - sec
		if(times>=(5*24*3600))then --��6�쿪��
			SendLuaMsg( 0, { ids = Wing_Data, t = 0}, 9 )
		end
	else
		if(isref~=nil and wingData[1]>1 and wingData[2]~=nil)then
			wingData[2] = nil
		end
		if(wingData[1]>1)then
			if(wingData[5]~=nil)then
				wingData[5] = nil
			end
		elseif(wingData[5] and GetServerTime()>wingData[5])then
			local tempAtt=GetRWData(1)
			tempAtt[1]=0--��Ѫ
			tempAtt[3]=0--����
			tempAtt[4]=0--����
			tempAtt[7]=0--����
			tempAtt[9]=0--����
			PI_UpdateScriptAtt(sid,ScriptAttType.wing)
			CI_SetPlayerIcon(0,6,0,1)---��������
		end
		
		SendLuaMsg( 0, { ids = Wing_Data, data = wingData, t = 5}, 9 )
	end
end 

--���ȼ�
function wing_get_lv(sid)
	local wingdata = _get_wing_data(sid)
	if(wingdata==nil or wingdata[1] == nil) then 
		return 0
	else
		return wingdata[1]
	end
end

--������Լӳ�
function wing_add_attribute(sid,tempbuff)
	if sid==nil then return end
	local wingdata = _get_wing_data(sid)
	if(wingdata==nil or wingdata[1] == nil) then return end
	
	local tempAtt=GetRWData(1)
	local lv = wingdata[1]
	local yl = wingdata[3] or 0
	local yh = wingdata[4] or 0
	local t = wingdata[5]
	local skill = wingdata[6]
	if(lv<=1 and t~=nil and GetServerTime()>t)then return end
	
	--���Էֳ���������.. 10��ǰ 10����
	local f_lv = lv
	if lv > 10 then
		f_lv = 10
	end
	local attconf=wing_conf.att[f_lv]
	local addatt=wing_conf.att[100]
	tempAtt[1]=math_floor((attconf[1]+yh*addatt[1])*(yl*2+100)/100)--��Ѫ
	tempAtt[3]=math_floor((attconf[2]+yh*addatt[2])*(yl*2+100)/100)--����
	tempAtt[4]=math_floor((attconf[3]+yh*addatt[3])*(yl*2+100)/100)--����
	tempAtt[7]=math_floor((attconf[4]+yh*addatt[4])*(yl*2+100)/100)--����
	tempAtt[9]=math_floor((attconf[5]+yh*addatt[5])*(yl*2+100)/100)--��

	--������� ����ս����
	local switch_proc = wingdata[9] or 0  
	local switch_conf = wing_conf.switch_conf
	tempAtt[1] = tempAtt[1] + switch_conf[1](switch_proc)
	tempAtt[3] = tempAtt[3] + switch_conf[3](switch_proc)
	tempAtt[4] = tempAtt[4] + switch_conf[4](switch_proc)
	tempAtt[7] = tempAtt[7] + switch_conf[7](switch_proc)
	tempAtt[9] = tempAtt[9] + switch_conf[9](switch_proc)
	
	if(skill == nil)then return true end  --�޼���
	--�м���
	local idx = 1
	for i=10,15 do
		if(skill[idx]~=nil)then
			tempbuff[i][1]=skill[idx][1] --id
			tempbuff[i][2]=skill[idx][2] --lv
		end
		idx = idx + 1
	end
	CI_SetPlayerIcon(0,6,lv,1)
	return true
end
--ϰ�ó���� ����ID ����λ
function wing_learn_skill(sid,goodid,pos)
	local wingdata = _get_wing_data(sid)
	if(wingdata==nil or wingdata[1] == nil) then return false,1 end --�޳������
	
	local lv = wingdata[1]
	local yl = wingdata[3] or 0
	local yh = wingdata[4] or 0
	local t = wingdata[5]
	local skill = wingdata[6]
	
	if(lv<1)then return false,2 end --���ݳ���
	if(wing_conf.wing[lv] == nil or wing_conf.goods[goodid] == nil)then return false,3 end --���ó���
	if(skill~=nil and skill[pos]~=nil)then return false,4 end --����λ���м�����
	if(pos>wing_conf.wing[lv].num)then return false,5 end --������ǰ�ȼ�����λ����
	
	if(CheckGoods(goodid,1,1,sid)==0)then return false,6 end --û���㹻����
	
	local curskillID = wing_conf.goods[goodid][1]
	local curskillLv = wing_conf.goods[goodid][2]
	local limitLv = wing_conf.goods[goodid][4]
	if(lv<limitLv)then return false,7 end
	
	if(skill == nil)then 
		wingdata[6] = {} 
		skill = wingdata[6]
	end
	
	skill[pos] = {curskillID,curskillLv}
	CheckGoods(goodid,1,0,sid,'ѧϰ�����')
	
	--������Ӹ��¼��ܵĲ���
	_wing_update_att(sid,curskillID,0,curskillLv)
	
	return true,wingdata,curskillID,curskillLv
end
--���������
function wing_up_skill(sid,curskillID,curskillLv,pos)
	local wingdata = _get_wing_data(sid)
	if(wingdata==nil or wingdata[1] == nil)then return false,1 end --�޳������
	
	local skill = wingdata[6]
	if(skill == nil or skill[pos] == nil or skill[pos][1] ~= curskillID or skill[pos][2] ~= curskillLv)then return false,2 end --���ܲ�����
	local limitSkill = wing_conf.limit[curskillID]
	if(limitSkill==nil)then return false,4 end--�������ó���
	if(math_floor(limitSkill%10)>=wing_conf.maxskLv)then return false,3 end --�Ѵ�ȼ�����
	--if(curskillLv>=wing_conf.maxskLv)then return false,3 end --���ܵȼ��Ѵ�����
	
	local goods = wing_conf.goods
	local quality --���ܵ���
	for gid,tb in pairs(goods) do
		if(type(tb) == type({}) and tb[1] == curskillID and tb[2] == curskillLv)then
			quality = tb[3]
			break
		end
	end
	if(quality == nil)then return false,3 end --�Ѵ�ȼ�����
	local upgoods = wing_conf.up[quality]
	if(upgoods == nil)then return false,4 end --�����������ó���
	for _,v in pairs(upgoods) do
		if(type(v) == type({}))then
			if(CheckGoods(v[1],v[2],1,sid)==0)then return false,7 end --���߲���
		end
	end
	curskillID = curskillID + 1
	skill[pos][1] = curskillID
	--curskillLv = curskillLv + 1
	--skill[pos][2] = curskillLv
	for _,v in pairs(upgoods) do
		if(type(v) == type({}))then
			CheckGoods(v[1],v[2],0,sid,'���������')
		end
	end
	
	--������Ӹ��¼��ܵĲ���
	_wing_update_att(sid,curskillID,curskillID-1,1,1)
	
	return true,wingdata,curskillLv
end
--[[
����/��ӡ ���� 
tp 0 ���� 1 ��ӡ 
pos ����λ��
skillid ����ID����ȫ�ã�
skillLv ���ܵȼ�����ȫ�ã�
]]--
function wing_remove_skill(sid,tp,pos,skillid,lv)
	local wingdata = _get_wing_data(sid)
	if(wingdata==nil or wingdata[1] == nil)then return false,1 end --�޳������
	
	local skill = wingdata[6]
	if(skill == nil or skill[pos] == nil or skill[pos][1] ~= skillid)then return false,2 end --���ܲ�����
	
	if(tp == 0)then -- ����
		skill[pos] = nil
		local needpt = wing_conf.cost.lq
		if(needpt == nil or (not CheckCost(sid, needpt,1,3)))then return false,3 end --ͭǮ���㲻������	
		skill[pos] = nil
		CheckCost(sid, needpt,0,3,'����������۳�ͭǮ')
		--AddPlayerPoints(sid,2, - needpt,nil,'����������۳�����',true)
	elseif(tp == 1)then -- ��ӡ
		local neednum = wing_conf.cost.num[lv]
		local goodid = wing_conf.cost.goodid
		if(CheckGoods(goodid,neednum,1,sid)==0)then return false,4 end --û���㹻����
		local goods = wing_conf.goods
		local getGid --��ԭ�ļ�����
		for gid,tb in pairs(goods) do
			if(tb~=nil and type(tb) == type({}))then
				if(tb[1] == skillid)then
					getGid = gid
					break
				end
			end
		end
		if(getGid==nil)then return false,5 end --û�ҵ���Ӧ����
		local pakagenum = isFullNum()
		if pakagenum < 1 then return false,6 end --�����ո���
		GiveGoods(getGid,1,1,"����ܷ�ӡ")
		CheckGoods(goodid,neednum,0,sid)
		skill[pos] = nil
	end
	
	--������Ӹ��¼��ܵĲ���
	--look('�Ƴ������'..skillid..','..lv)
	_wing_update_att(sid,0,skillid,0,1)
	
	return true,wingdata
end

local tempned={nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}---�ӵ����˵���

--�������
--sid����ID
--ctype �������� 0 ������ 1 ���߲��㻨Ԫ��
--num	���߸���
--itype ��Ϊ����ִ��һ������4��	
local function wing_up_old(sid,ctype,num1,itype)
	local wingdata = _get_wing_data(sid)
	if(wingdata == nil or wingdata[1] == nil)then return false,1 end --�޳������
	
	local lv = wingdata[1]
	if(lv>=wing_conf.maxLv)then
		return false,2 --���׵�����
	end
	
	local proc = wingdata[2] or 0
	local oldlv = lv
	
	for j=1,#tempned do
		tempned[j]=nil
	end
	local maxTime=1
	if itype~=nil then
		maxTime=20
	end
	
	local num
	local needs
	local goodid = wing_conf.upgoodid[1]
	local cost = wing_conf.upgoodid[2]
	local minV,maxV
	local luck,gate,rannum,errIdx
	local spend
	for i=1,maxTime do
		spend = 0
		num = num1
		needs = (lv+1)*2 - 2
		if(wing_conf.wing[lv]==nil)then return false,5 end --���ó���
		minV = wing_conf.wing[lv].minV
		maxV = wing_conf.wing[lv].maxV
		if(ctype == 0)then --ֻ������
			if(CheckGoods(goodid,needs,1,sid)==0)then
				if(i == 1)then
					return false,3 --û���㹻����
				else
					errIdx = 3
					break
				end
			end
		else --���߲����Ԫ��
			if(num<needs)then
				spend = (needs - num)*cost
				if(num>0 and CheckGoods(goodid,num,1,sid)==0)then
					if(i == 1)then
						return false,3 --û���㹻����
					else
						errIdx = 3
						break
					end
				end
				if(not CheckCost(sid, spend,1,1))then
					if(i == 1)then
						return false,4 --Ԫ������
					else
						errIdx = 4
						break
					end
				end
			else
				if(CheckGoods(goodid,needs,1,sid)==0)then
					if(i == 1)then
						return false,3 --û���㹻����
					else
						errIdx = 3
						break
					end
				end
			end
		end
		
		--�۶�����
		if(spend>0)then --Ҫ��Ԫ��
			if(num>0)then
				CheckGoods(goodid,num,0,sid,'�������')
				num1 = 0
			end
			CheckCost(sid,spend,0,1,"�������")
		else
			CheckGoods(goodid,needs,0,sid,"�������")
			num1 = num1 - needs
			if(num1<0)then num1 = 0 end
		end
		
		luck = needs 
		tempned[i] = luck
		proc = proc + luck
		
		if(proc>minV)then --���������л���ɹ�
			if(proc>=maxV)then
				--�������ޱسɹ�
				wingdata[2] = 0
				lv = lv + 1
				break
			else
				gate=math_ceil((proc-minV)/needs*3)
				rannum=math_random(1,100)
				if(gate>=rannum)then
					--�ɹ�
					wingdata[2] = 0
					lv = lv + 1
					if(lv == 2)then --Ŀ���ɣ�������������2��
						set_obj_pos(sid,4003)
					elseif(lv == 5)then --������������5��
						set_obj_pos(sid,5005)
					end
					break
				end
			end
		end
		wingdata[2] = proc
	end
	local isup
	if(oldlv<lv)then
		--������
		isup = lv
		wingdata[1] = lv
		wingdata[7] = 10000+lv
		_wing_update_att(sid)
		CI_SetPlayerIcon(0,6,lv,1)---��������
		--look('CI_SetPlayerIcon(0,6,lv)'..lv)
	end
	return true,wingdata,isup,errIdx,tempned
end

--������ 
local function wing_up_switch(sid, ctype, stype, num1, num2)
	--look("wing_up_switch----------------------------------1")
	local wingdata = _get_wing_data(sid)
	local lv = wingdata[1]
	if (lv < wing_conf.minSwitchLv) then
		return false, 4 --���ݴ��� 
	end
	--�������Ƿ����� �������������������Ԫ������
	local item_first = wing_conf.switch_conf[100]
	local item_two = wing_conf.switch_conf[101]
	--pay_*  ����Ԫ�� ��CheckYBʧ��ʱ ���۳�
	--item_* ��������   
	local pay_proc, pay_num1, pay_num2, pay_cost  = 0,0,0,0
	local item_proc, item_num1, item_num2, item_cost  = 0,0,0,0
	local proc,  tmp_num1,  tmp_num2, need_num1, need_num2, num, tmpNum, tmpCostYb
	
	tmp_num1 = num1 or 0
	tmp_num2 = num2 or 0
	proc = wingdata[9] or 0
	--�Ƿ�һ������
	if stype then 
		num  = ((rint(proc / 100) + 1) * 100 - proc) or 0
	else
		num = 1
	end

	local  index = 0
	for i = 1, num do
		index = i
		need_num1 = item_first[2](proc + item_proc + 1)
		need_num2 = item_two[2](proc + item_proc + 1)
		--��Ʒ1
		if  tmp_num1 >= need_num1  and tmp_num2 >= need_num2 then
			tmp_num1 = tmp_num1 - need_num1
			item_num1 = item_num1 + need_num1
			
			tmp_num2 = tmp_num2 - need_num2
			item_num2 = item_num2 + need_num2
			
			item_proc = item_proc + 1
		else
			break
		end
	end
	
	-------------------------------------------------------------------
	pay_proc = pay_proc + item_proc
	pay_num1 = pay_num1 + item_num1
	pay_num2 = pay_num2 + item_num2
	pay_cost = pay_cost + item_cost
	--look("proc "..proc.." addproc "..item_proc.." num1 "..item_num1.." num2 "..item_num2.." cost "..item_cost)
	item_proc, item_num1, item_num2, item_cost  = 0,0,0,0
	-------------------------------------------------------------------
	--[[
	if ctype  then --�Ƿ��Զ�����
		tmpNum = num - index or 0
		for i = 1,  tmpNum do
			need_num1 = item_first[2](proc + item_proc + pay_proc + 1)
			need_num2 = item_two[2](proc + item_proc  + pay_proc + 1)
			if tmp_num2 < need_num2 then
				break
			elseif tmp_num1 < need_num1 then
				need_num1 = need_num1 - tmp_num1
				tmpCostYb = item_cost + need_num1 * item_first[3]
				if not CheckCost(sid, tmpCostYb, 1, 1)  then
					break
				end
				item_num1 = item_num1 + tmp_num1
				item_num2 = item_num2 + need_num2
				item_cost = tmpCostYb
				item_proc = item_proc + 1
			end
		end
	end		
	-------------------------------------------------------------------
	pay_proc = pay_proc + item_proc
	pay_num1 = pay_num1 + item_num1
	pay_num2 = pay_num2 + item_num2
	pay_cost = pay_cost + item_cost
	-------------------------------------------------------------------
	look("proc "..proc.." addproc "..pay_proc.." num1 "..pay_num1.." num2 "..pay_num2.."  cost "..pay_cost)
	--]]
	if CheckGoods(item_first[1], pay_num1 , 1, sid) == 0 
			or CheckGoods(item_two[1], pay_num2 , 1, sid) == 0  then
			return false, 3 --���߲���
	end
	if not CheckCost(sid, pay_cost, 1, 1)  then
		return false, 5 --Ԫ������
	end
	
	--�۳����߻�Ԫ��
	CheckGoods(item_two[1], pay_num2, 0, sid, "������") 
	if pay_num1 > 0 then
		CheckGoods(item_first[1], pay_num1, 0, sid, "������")
	end
	if pay_cost > 0 then
		CheckCost(sid, pay_cost, 0, 1, '������')
	end
	---���ȼ�һ
	proc = proc + pay_proc
	wingdata[9] = proc
	local oldlv = wingdata[1]
	local newLv = oldlv + rint(proc / 1000)
	--local icon = CI_GetPlayerIcon(0, 6)
	if oldlv < newLv then
		wingdata[1] = newLv
		wingdata[7] = 10000+newLv
		CI_SetPlayerIcon(0,6,newLv,1)---��������
	end
	--��������
	_wing_update_att(sid)
	return true,wingdata
end

--�������
--sid����ID
--ctype �������� 0 ������ 1 ���߲��㻨Ԫ��
--num	���֮����߸���
--itype ��Ϊ����ִ��һ������4��	
--stype �Ƿ�һ������(ħ����)
--num2 ����֮����߸���
function wing_up_proc(sid,ctype,num1,itype, stype, num2)
	local wingdata = _get_wing_data(sid)
	if(wingdata == nil or wingdata[1] == nil)then return false,1 end --�޳������
	--look("wing_up_proc----------------------------------2")
	--if type(ctype) ~= type(0) then return false end
	local lv = wingdata[1]
	if(lv>=wing_conf.maxLv)then
		return false,2 --���׵�����
	end
	if (lv < wing_conf.minSwitchLv) then
		return wing_up_old(sid, ctype, num1, itype)
	else
		return wing_up_switch(sid, ctype, stype, num1, num2 )
	end
end

function temp_wing(sid)
	local wingdata = _get_wing_data(sid)
	if(wingdata~=nil and wingdata[1]~=nil)then
		local lv = wingdata[1]
		if(lv >= 2)then --Ŀ���ɣ�������������2��
			set_obj_pos(sid,4003)
		end
		if(lv >= 5)then --������������5��
			set_obj_pos(sid,5005)
		end
	end
end

--���ʹ��
function wing_use_yh(sid)
	local wingdata = _get_wing_data(sid)
	if(wingdata == nil or wingdata[1] == nil or wingdata[1]<1)then
		return 0
	end
	local lv = wingdata[1]
	local yh = wingdata[4] or 0
	if(wing_conf.wing[lv] == nil or wing_conf.wing[lv].yh == nil)then
		return 0
	end
	
	local maxnum = wing_conf.wing[lv].yh
	if(yh>=maxnum)then return 0 end
	
	if(wingdata[4] == nil)then wingdata[4] = 0 end
	wingdata[4] = wingdata[4] + 1
	_wing_update_att(sid)
	SendLuaMsg(0,{ids=Wing_HLUpdate,yh=wingdata[4]},9)
end

--����ʹ��
function wing_use_yl(sid)
	local wingdata = _get_wing_data(sid)
	if(wingdata == nil or wingdata[1] == nil or wingdata[1]<1)then
		return 0
	end
	local lv = wingdata[1]
	local yl = wingdata[3] or 0
	
	if(wing_conf.wing[lv] == nil or wing_conf.wing[lv].yl == nil)then
		return 0
	end
	
	local maxnum = wing_conf.wing[lv].yl
	if(yl>=maxnum)then return 0 end

	if(wingdata[3] == nil)then wingdata[3] = 0 end
	wingdata[3] = wingdata[3] + 1
	_wing_update_att(sid)
	SendLuaMsg(0,{ids=Wing_HLUpdate,yl=wingdata[3]},9)
end

--ʹ�õ��߼�����ֵ
function wing_use_item(sid,goodid)
	local goodlv = wing_goodconf[goodid]
	if(goodlv==nil)then return false,0 end --����������Ӧ����
	local wingdata=_get_wing_data(sid)
	if(wingdata==nil or wingdata[1] == nil)then return false,1 end --������δ����
	local lv = wingdata[1]
	if(lv>=wing_conf.maxLv)then return false,3 end --�������_��ߵȼ�
	if(lv<goodlv)then return false,2 end 
	if(wing_conf.wing[lv] == nil or wing_conf.wing[lv].maxV == nil)then return false,4 end  --���ó���
	local maxV = wing_conf.wing[lv].maxV
	if(lv==goodlv)then
		rate = 0.15
	else
		rate = 0.01
	end
	local addLuck = math_floor(maxV * rate)
	local curLuck = wingdata[2] or 0
	if(curLuck>=maxV)then return false,5 end --����ֵ����
	if(wingdata[2]~=nil)then
		wingdata[2] = wingdata[2] + addLuck
	else
		wingdata[2] = addLuck
	end
	SendLuaMsg( 0, { ids = Wing_Data, data = wingdata, t = 6, add = addLuck}, 9 )
	return true
end

