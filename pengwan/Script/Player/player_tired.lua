--[[
file:	player_tired.lua
desc:	ƣ�Ͷ�,��������.
author:	wk
update:	2014-5-13
]]--

local SendLuaMsg=SendLuaMsg
local Player_FriendLuck = msgh_s2c_def[15][5]
local Player_sp = msgh_s2c_def[15][16]
local db_module =require('Script.cext.dbrpc')
local db_tired_writeid=db_module.db_tired_writeid
local db_tired_getinfo=db_module.db_tired_getinfo
local db_tired_logout=db_module.db_tired_logout

local function tired_getpdata( playerid )
	local p_data=GI_GetPlayerData( playerid , 'tire' , 20 )
	-- p_data[1] =1 ���� 
	return p_data
end
--������״̬,��½ȡ�������ʱ��,�޸ı�������ʱ��
function tired_getonlinetime(sid)
	-- look(111,1)
	local a=GetCurPlayerWallow()
	-- look(a,1)
	if a and a>=0 then
		local pdata=tired_getpdata(sid)
		if pdata==nil then return end
		if pdata[1]and pdata[1]==1 then
			CI_SetPlayerData(9, -1)
		else
			db_tired_getinfo(sid)
		end
		
	end

	
end

--ȡ����ʱ���ص� isadult=0δ��д���֤�� 1����д���֤�ŵ�δ����  2�ѳ���
function tired_getcallback(sid,onlinetime,isadult)
	-- look('ȡ����ʱ���ص�',1)
	-- look(onlinetime,1)
	
	-- look(isadult,1)
	
	if isadult==2 then 
		CI_SetPlayerData(9, -1)
		
	else
		if onlinetime and onlinetime>=0 then 
		 	CI_SetPlayerData(9, onlinetime) ----������ʱ����Ϊonlinetime��
		end	
	end
	RPC('tired',2,isadult)--�����Ϣ
	-- local a=GetCurPlayerWallow() or 0
	-- look(a,1)
end
--��д���֤��Ϣisup=1 18������
function tired_getnum(sid ,id,name,isup)
	--look('��д���֤��Ϣisup',1)
	db_tired_writeid(sid,id,name)

	
end
--��д���֤��Ϣ�ص� res=1 δ����  2 �ѳ���
function tired_writecallback(sid,onlinetime,res)
	RPC('tired',1,onlinetime)--��д�ɹ�
	if res and res==2 then 
		local pdata=tired_getpdata(sid)
		if pdata==nil then return end
		pdata[1]=1
		CI_SetPlayerData(9, -1)
		RPC('tired',2,res)--��д�ɹ�
	else
		if onlinetime and onlinetime>=0 then 
			CI_SetPlayerData(9, onlinetime) ----������ʱ����Ϊonlinetime��
		end
		
	end
	
end

--����д�洢,��������ʱ��
function tired_logout()
	db_tired_logout()
end
