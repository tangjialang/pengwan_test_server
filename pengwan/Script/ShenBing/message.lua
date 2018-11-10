--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local Wing_Data = msgh_s2c_def[20][11]
local Wing_Err = msgh_s2c_def[20][12]
local Expupbatt=Expupbatt
local Batuplv=Batuplv
local firstbatt_look=firstbatt_look
local SendLuaMsg = SendLuaMsg

local fasb = require('Script.ShenBing.faction_func')
local fasb_break_shenbing	= fasb.fasb_break_shenbing
local fasb_train_shenbing 	= fasb.fasb_train_shenbing
local dragon = require('Script.ShenBing.dragon_func')
local dragon_get_data = dragon.dragon_get_data
local dragon_up_data = dragon.dragon_up_data
--------------------------------------------------------------------------
-- data:

-- ��ʼ��ս����������
msgDispatcher[16][0] = function ( playerid)	
	-- look('��ʼ��ս����������',1)
	firstbatt(playerid)
end
-- ǿ�� 
msgDispatcher[16][1] = function ( playerid, msg )	
	-- look(444)
	Expupbatt(playerid,msg.autobuy,msg.num,msg.itype,msg.useluck,msg.leixin)
end
-- ǰ̨������
msgDispatcher[16][2] = function ( playerid, msg )	
	-- look('ǰ̨������',1)
	firstbatt(playerid)
end
-- �鿴����
msgDispatcher[16][3] = function ( playerid, msg )	
	firstbatt_look(msg.sid,msg.name,msg.type,msg.s)
end

--------------������-------------------------

-- �������
msgDispatcher[16][4] = function ( playerid, msg )	
	sowar_begin( playerid )
end
-- �������
msgDispatcher[16][5] = function ( playerid, msg )	
	sowar_intensify(playerid,msg.buy,msg.lastnum,msg.itype,msg.leixin)
end
-- ѧϰ����
msgDispatcher[16][6] = function ( playerid, msg )	
	 sowar_learnskill(playerid,msg.num)
end
-- ����鿴
msgDispatcher[16][8] = function ( playerid, msg )	
	sowar_look(msg.sid,msg.name,msg.type,msg.s)
end
--------------�������-------------------------
-- ѧϰ��������
msgDispatcher[16][7] = function ( playerid, msg )	
	 gem_learnskill(playerid,msg.num)
end

---------------�����Ϣ---------------------------
--���ѧϰ����
msgDispatcher[16][9] = function ( playerid,msg)
	local result,data,skillid,lv = wing_learn_skill(playerid,msg.goodid,msg.pos)
	if(result)then
		SendLuaMsg( 0, { ids = Wing_Data, data = data,t = 1, skillid = skillid, lv = lv}, 9 )
	else
		SendLuaMsg( 0, { ids = Wing_Err, t = 1, data = data}, 9 )
	end
end

--�����������ӡ����
msgDispatcher[16][10] = function ( playerid,msg)
	local result,data = wing_remove_skill(playerid,msg.tp,msg.pos,msg.skillid,msg.lv)
	if(result)then
		SendLuaMsg( 0, { ids = Wing_Data, data = data, t = 2, tp = msg.tp, skillid = msg.skillid, lv = msg.lv}, 9 )
	else
		SendLuaMsg( 0, { ids = Wing_Err, t = 2, data = data}, 9 )
	end
end

--���������
msgDispatcher[16][11] = function ( playerid,msg)
	local result,data,lv = wing_up_skill(playerid,msg.skillid,msg.lv,msg.pos)
	if(result)then
		SendLuaMsg( 0, { ids = Wing_Data, data = data, t = 3, skillid = msg.skillid, lv = lv}, 9 )
	else
		SendLuaMsg( 0, { ids = Wing_Err, t = 3, data = data}, 9 )
	end
end

--�������
msgDispatcher[16][12] = function ( playerid,msg)
	--wingdata,isup,errIdx,tempned
	local result,data,isup,errIdx,add = wing_up_proc(playerid,msg.type,msg.num,msg.itype, msg.stype, msg.num2)
	if(result)then
		SendLuaMsg( 0, { ids = Wing_Data, data = data, t = 4, isup = isup, errIdx = errIdx, add = add}, 9 )
	else
		SendLuaMsg( 0, { ids = Wing_Err, t = 4, data = data}, 9 )
	end
end

--�鿴������ҵĳ��
msgDispatcher[16][13] = function ( playerid,msg)
	wing_get_other_date(msg.sid,msg.name,msg.t)
end

--�������
msgDispatcher[16][14] = function ( playerid,msg)
	wing_create(playerid)
end
--�������
msgDispatcher[16][15] = function ( playerid,msg)
	sowar_kaiguang( playerid,msg.buy,msg.lastnum)
end
--��ʾ��������
msgDispatcher[16][16] = function ( playerid,msg)
	marry_see( playerid,msg.itype)
end

---------------------------������-----------------
----����/Ԫ������������
msgDispatcher[16][17] = function(playerid, msg)
	fasb_train_shenbing(playerid, msg.itype, msg.atype, msg.lastnum)
end
--����ͻ�ư�����
msgDispatcher[16][18] = function(playerid)
	--fasb_break_shenbing(playerid)
end

---------------------------����ϵͳ------------------
--��ȡdata 
msgDispatcher[16][19] = function(playerid)
	dragon_get_data(playerid)
end

--��������
msgDispatcher[16][20] = function(playerid, msg)
	dragon_up_data(playerid, msg.itype, msg.num)
end





