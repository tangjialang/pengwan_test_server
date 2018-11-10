--[[
file:	config_interface.lua
desc:	�߻��õĹ��ܽӿ�
author:	chal
update:	2011-12-01
]]--
--------------------------------------------------------------------------
--include:
local mathfloor = math.floor
local pairs,tostring = pairs,tostring
local ipairs = ipairs
local TableHasKeys = table.has_keys
local define		 = require('Script.cext.define')
local EquipItemInfo = define.EquipItemInfo
local look = look

local CI_GetPlayerData = CI_GetPlayerData
local GiveGoodsBatch = GiveGoodsBatch

--------------------------------------------------------------------------
--interface:
------------------[��ֵ��]------------------
--���ظõȼ�һ���Ͷ�ŵľ���ֵ
function GetEveryDayGiveExp(level)
	local rate = 1
	if level < 40 then
		rate = 0.7
	elseif level < 60 then
		rate = 0.9
	end
	if level > 60 then
		level = 60 + mathfloor((level-60)/3)
	end
	if level > 72 then
		level = 73
	end
	local dayExp = level*level*level*level+level*level*(level%10+10)
	return mathfloor(dayExp*rate)
end

--���ظõȼ�һ���ܻ���Ͷ�ŵİ���
function GetEveryDayGiveMoney(level)
	local rate = level-40
	if rate < 0 then 
		rate = 0
	end
	local money = mathfloor(50000 + rate * 2000)
	return money
end

--ȡ��װ��ID��DATE�� װ������,ְҵ,װ���ȼ�,ǿ���ȼ�,Ʒ��,�Ƿ��,����
function GetLevelUpEquip(equipType,school,equiplevel,level,pinzhi,isbind,slots)
	if equipType < 101 or equipType > 112 then 
		look("����ǿ��װ���ӿڣ�װ�������쳣��"..tostring(equipType))
		return 
	end
	if school < 0 or school > 3 then 
		look("����ǿ��װ���ӿڣ�ְҵ�����쳣��"..tostring(school))
		return 
	end
	if equiplevel < 10 or equiplevel > 100 then 
		look("����ǿ��װ���ӿڣ�װ���ȼ��쳣��"..tostring(equiplevel))
		return 
	end
	if level < 0 or level > 40 then 
		look("����ǿ��װ���ӿڣ�ǿ���ȼ��쳣��"..tostring(equiplevel))
		return 
	end
	if pinzhi < 1 or pinzhi > 5 then 
		look("����ǿ��װ���ӿڣ�װ��Ʒ���쳣��"..tostring(pinzhi))
		return 
	end
	local id 
	if not isbind then  isbind = 1 end
	if not slots then  slots = 0 end
	local EquipType_need=equipType%100+1
	if equipType==101 then 
		local sexuality=CI_GetPlayerData(11)
		if sexuality==1 then
			EquipType_need=1
		else
			EquipType_need=2
		end
	end
	local id = EquipItemInfo[equiplevel][pinzhi][school][EquipType_need]
	GiveGoodsBatch({{id,1,isbind,slots,level}},'�߻��ӿ����ɽ���')
end

------------------[���ݿ���־](not use)------------------
--д���ճ���������¼��Ϣ 
--���ͣ���ע�����齱������������
-- function SaveActiveLog_Sql(aType,info,expAdd,award)
-- --dbtype 0-mysql  1-sqlserver  101-uselog
	-- --local call = { dbtype = 1, sp = 'BindRandCode' , args = 4,[1] = code , [2] = account, [3] = playerid, [4] = serverid}
	-- --local callback = { callback = 'DBCALLBACK_BindCode', args = 1, [1] = "?5"}  �ص�����
	-- --DBRPC( call, callback )
	-- local roleid = CI_GetPlayerData(17)
	-- if roleid == nil then
		-- roleid = 0
	-- end
	-- local level = CI_GetPlayerData(1)
	-- if level == nil then
		-- level = 0
	-- end
	-- local serverid = GetGroupID()
	-- --local school = CI_GetPlayerData(2)
	-- --local camp = 0
	-- --local playerCamp = GetDBPlayerCampData(roleid)
	-- --	if playerCamp ~= nil then
	-- --		camp = playerCamp.campID
	-- --	end
	-- local call = { dbtype = 101, sp = 'n_activelog' , args = 7 , [1] = serverid,[2] = roleid, [3] = rint(level), [4] = aType, [5] = info,[6] = expAdd, [7] = award}
	-- DBRPC( call)
-- end

-- --��¼���в�����־
-- function SaveActionLog_Sql(atype,info)
	-- local rolename = CI_GetPlayerData(3)
	-- local serverid = GetGroupID()
	-- local call = { dbtype = 101, sp = 'n_actionlog' , args = 4 , [1] = serverid,[2] = rolename, [3] = atype, [4] = info}
	-- DBRPC( call)
-- end
