--[[
file:	danyao.lua
desc:	��ҩϵͳ
author:	wk
update:	2013-12-10
refix:	done by wk
]]--

local look = look
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos
local dy_use	 = msgh_s2c_def[20][10]	

--[[  CAT_MAX_HP,	1	// Ѫ������1
CAT_MAX_MP,	2	// ŭ������(Ԥ��)
CAT_ATC,	3	// ����2
CAT_DEF,	4	// ����3
CAT_HIT,	5	// ����4
CAT_DUCK,	6	// ����5
CAT_CRIT,	7	// ����6
CAT_RESIST,	8	// �ֿ�7
CAT_BLOCK,	9	// ��8]]--
--����idΪkey,{���Ա��,ֵ}
local dy_conf={  
	[754]={3,10},
	[755]={4,10},
	[756]={1,30},
	[784]={3,18},
	[785]={4,15},
	[786]={7,10},
	[757]={3,150},
	[758]={1,500},
	[759]={7,80},
	[760]={4,100},
	[761]={8,80},	
}

--��ҩ���ȼ�
local dy_max = 600
--������
local function dy_getpdata( sid )
	local dydata=GI_GetPlayerData( sid , 'dyao' , 100 )
	if dydata == nil then return end
	--[[
		[415]=2,����id,����
		[466]=6,
	]]
	return dydata
end

--��������
function dy_Attribute(playerid,itype)	
	if playerid==nil  then
		return
	end
	local data= dy_getpdata( playerid )
	if data==nil then return  end

	local tempAtt=GetRWData(1)

	for k,v in pairs(data) do
		if type(k)==type(0) and type(v)==type(0) then
			local attnum=dy_conf[k][1]
			local attvalue=dy_conf[k][2]*v
			tempAtt[attnum]=(tempAtt[attnum] or 0)+attvalue
		end
	end
	if itype==1 then --���µ�����������
		local a=PI_UpdateScriptAtt(playerid,ScriptAttType.danyao)
	else
		return true  --��ʼ�����Ը���
	end
end

--ʹ�õ�ҩ
function dy_usegoods( playerid,id )
	--look('ʹ�õ�ҩ',1)
	-- look(id)
	local data= dy_getpdata( playerid )
	if data==nil then  return 0 end
	-- local lv=rint(CI_GetPlayerData(1)/10)*10
	--local lv=CI_GetPlayerData(1)
	if (data[id] or 0)>= dy_max then 
		-- look(111)
		return 0
	end
	local dconf=dy_conf[id]
	if dconf==nil then look(333) return 0 end
	data[id]=(data[id] or 0)+1
	SendLuaMsg(0,{ids=dy_use,id=id,num=data[id]},9)
	dy_Attribute(playerid,1)	
	-- look(444)
	set_obj_pos(playerid,3006)
end