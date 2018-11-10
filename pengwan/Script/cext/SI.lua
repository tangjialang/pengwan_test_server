--[[
file:	SI_interface.lua
desc:	SI_XXXX
author:	all
update:	2013-7-6
version: 1.0.0
]]--

--------------------------------------------------------------------------
--include:
local db_module = require('Script.cext.dbrpc')
local db_day_refresh = db_module.db_day_refresh
local db_hour_refresh = db_module.db_hour_refresh
local db_get_wlevel = db_module.db_get_wlevel
local donate = require("Script.Player.player_donate")		-- ��Ҿ��׾�λϵͳ
local donate_rank_refresh = donate.donate_rank_refresh
---��������
ScriptGidType={
	player=1,
	npc=2,
	monster=3,
	item=4,
	hero=5,
}

--����ת��Ϊս����
local att_conf={
	[1]=0.2,
	[2]=2,
	[3]=1,
	[4]=1,
	[5]=1.3,
	[6]=1.3,
	[7]=1.3,
	[8]=1.3,
	[9]=1.3,
	[10]=1,
	[11]=1,
	[12]=1,
	[13]=1,
	[14]=1,
}

-- ÿ�յ��ô洢���̴���
function SI_DBDayRefresh()
	db_day_refresh()
end

-- ÿСʱ���ô洢���̴���
-- Ŀǰֻ�����������а�ˢ��
function SI_DBHourRefresh()
	donate_rank_refresh()		--	ˢ�¾������а�
	db_hour_refresh()
	MRK_AddHonor()
end

-- ��������ȼ�
function SI_UpdateWorldLevel()
	db_get_wlevel()
end

function CALLBACK_UpdateWorldLevel(wlevel)
	-- look('CALLBACK_UpdateWorldLevel:' .. tostring(wlevel))	
	SetWorldLevel(wlevel)
end

--���齱��
--itype=1��������(classΪ�������鱶��),2���������(classΪ���㽱������)
function active_get_exp(class,itype)
	local worldlv=GetWorldLevel()
	if worldlv<40 then
		worldlv=40
	end
	local res
	if itype==1 then
		res=math.floor(worldlv^2.6*23/2000*class)
	else
		res=math.floor(worldlv^2.6*23/10*class)
	end
	return res
end

--ȡս����---�������Ա�
function get_fightvalue( attTb )
	if type(attTb)~=type({}) then return end 
	local res=0
	for k,v in pairs(attTb)  do 
		--look(k..'----'..v)
		if type(k)==type(0) and type(v)==type(0) and v>0 then 
			res=att_conf[k]*v+res
			--look(res)
		end
	end
	return rint(res)
end

-- �ж��Ƿ��ǿ��������
-- ���������ID [ 9990001 ~ 9999999 ]
function IsSpanServer()
	local serverid = GetGroupID() or 0
	if serverid > 9990000 then
		return true
	end
	return false
end




--����gid,���ض���,1��,2npc,3����,4����,5���
function SI_getgid_Object(gid)
	if type(gid) ~= type(0) then return 0 end
	-- look('����gid,���ض���',1)
	-- look(gid,1)
	if gid<268435456 then --ʮ������0x10000000
		return 1
	elseif gid<536870912 then --ʮ������0x20000000
		return 2
	elseif gid<805306368 then --ʮ������0x30000000
		return 3
	elseif gid<1073741824 then --ʮ������0x40000000
		return 4
	elseif gid<1342177280 then --ʮ������0x50000000
		return 5
	else
		return 0
	end
end

