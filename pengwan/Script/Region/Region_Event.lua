--[[
file:	Region_Event.lua
desc:	region event register.
author:	chal
update:	2011-12-05
]]--
--[[
  --����ӿ�--�����������itype=1ģʽ������ܡ�
--itype=1,���ڳ�������Trapinfo={mapid,x,y,mapgid};---Ҫ���볡������newinfo={mapid,x,y,mapgid};---���巶Χlength����Ĭ��Ϊ3
--itype=2,���ڳ�������Trapinfo={mapid,x,y,mapgid};---newinfo=�ص��ű�id;---���巶Χlength����Ĭ��Ϊ3��var=�������
 PI_MapTrap(itype,Trapinfo,newinfo,length, var)
]]--
----------------------------------------------------------------
--include:
local type = type
local look = look
local SetTrap = SetTrap
local CI_GetPlayerData = CI_GetPlayerData
local RPC = RPC
local TP_FUNC = type( function() end)
local define = require('Script.cext.define')
local Define_POS = define.Define_POS
local AreaRPC=AreaRPC
--���崫������
local trapconf={
	--���ִ嵽��᪳�
	{2,{2,99,225},301},
	{2,{3,99,225},301},
	{2,{4,99,225},301},
	{2,{5,99,225},301},
	--��᪳�  ���ִ�
	{1,{1,3,140},{3,103,219}},
	--��᪳�  ��Ұ
	{2,{1,36,169},302},
	--��᪳�  �������
	{1,{1,114,169},{11,7,109}},
	--�������  ��᪳�  
	{1,{11,3,113},{1,111,166}},
	--��� ׯ԰ �������������ǰ̨��ʾ
	--{2,{1,48,7},330},
	--��Ұ ��᪳�
	{1,{6,3,111},{1,32,166}},
	--��Ұ �ٹ�����
	{2,{6,41,13},303},

	--��Ұ  ����
	{1,{6,67,76},{22,17,11}},
	-- ���� ��Ұ
	{1,{22,14,7},{6,63,71}},

	--��Ұ  ����
--	{1,{6,12,6},{21,34,100}},

	-- ���� ��Ұ
	--{1,{21,36,107},{6,12,11}},



	-- �ٹ�����   ��Ұ
	{1,{23,15,90},{6,42,17}},
	--��᪳�  ǬԪɽ
	{1,{1,3,19},{7,88,21}},
	-- ǬԪɽ ��᪳�
	{1,{7,91,16},{1,6,22}},
	-- ǬԪɽ ��ⶴ1
	{2,{7,6,19},304},
	--  ��ⶴ1 ǬԪɽ
	{1,{24,59,43},{7,11,26}},
	--  ��ⶴ1 ��ⶴ2
	{1,{24,58,6},{25,55,56}},
	--  ��ⶴ2 ��ⶴ1
	{1,{25,59,59},{24,54,12}},
	-- ǬԪɽ ������1��
	{2,{7,9,133},305},
	-- ǬԪɽ ǬԪ��ɽ
	{1,{7,91,138},{34,4,16}},
	--  ǬԪ��ɽ ǬԪɽ
	{1,{34,3,11},{7,88,130}},

	--  ������1��  ǬԪɽ
	{1,{28,3,7},{7,15,133}},
	--  ������1��  ������2��
	{1,{28,43,8},{29,8,10}},
	--  ������2��  ������1��
	{1,{29,3,4},{28,40,11}},

	--  ���  ������
	{1,{1,29,6},{8,50,8}},

	--   ������ ���
	{1,{8,46,5},{1,24,10}},
	-- ������ ��������
	{2,{8,44,138},306},
	--��� ��������
	{1,{30,18,3},{33,3,87}},
	--�  ����
	{1,{30,3,42},{31,22,21}},
	-- ��ң�� ������
	{1,{32,58,44},{8,47,133}}, 

	-- ������ ��������
	{2,{8,14,123},307},

	--����  ������
	{1,{31,27,107},{8,20,116}},

	--����
	{2,{31,27,20},308},

	-- �������� �
	{1,{33,3,81},{30,16,5}},

	-- ����ɳ̲ ���
	{1,{100,41,59},{1,48,78}},

	-- ��� μˮ
	{1,{1,114,133},{10,6,95}},

	-- μˮ ���
	{1,{10,3,93},{1,110,129}},
	
	-- μˮ ����
	{2,{10,12,12},309},
	-- μˮ ʮ����
	{2,{10,122,93},310},
	
	-- μˮ ��Ұ
	{1,{10,122,163},{12,8,229}},
	-- ��Ұ μˮ
	{1,{12,5,232},{10,120,158}},
	-- ��Ұ ����
	{1,{12,120,8},{13,5,172}},	
	-- ���� ��Ұ
	{1,{13,2,174},{12,118,10}},		
	
	-- μˮ ������
	--{2,{10,122,166},311},
	-- ���̾������ռ�
	{2,{101,16,33},312},
	-- ǬԪɽ��ˮ
	{2,{7,40,69},313},
	
	
	-- ��������1  ���
	{1,{200,3,131},{1,6,100}},
	
	--   ��� ��������1
	--{1,{1,3,98},{200,6,135}},
	{2,{1,3,98},321},
	-- 1 -2 
	{2,{200,17,5},314},
	--   ��������2 - 1
	{1,{201,59,123},{200,15,11}},
	-- 2 -3 
	{2,{201,9,9},315},
	--   ��������3 - 2
	{1,{202,9,104},{201,7,14}},
	-- 3 -4 
	{2,{202,19,3},316},
	--   ��������4 - 3
	{1,{203,6,86},{202,17,6}},
	-- 4 -5 
	{2,{203,32,6},317},
	--   ��������5 - 4
	{1,{204,5,89},{203,32,13}},
	-- 5 -6 
	{2,{204,8,5},318},
	--   ��������6 - 5
	{1,{205,72,126},{204,10,8}},
	-- 6 -7 
	{2,{205,112,17},319},
	--   ��������7 - 6
	{1,{206,5,109},{205,110,20}},
	-- 7 -8
	{2,{206,69,7},320},
	--   ��������8 - 7
	{1,{207,3,99},{206,66,11}},
}

mapID = mapID or 1
---����ص� �̶�����10000����,������̬��10000-100000,���̬��100000����
call_OnMapEvent={
	[301]=function ()
		--���ִ�ȥ����
		--look('���ִ�ȥ����')
		PI_MovePlayer(1,6,141)
	end,
	[302]=function ()
		--������󸱱�������
		
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		--look( "sid =" ..sid)
		if  taskData.current[1054] ~= nil  then
			RPC('CSBOSSInfo',1002)
			--(sid,1002)
		else
			PI_MovePlayer(6,8,114)
		end
	end,

	[303]=function ()
		--�ٹ���������������
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[1105] ~= nil then
			
			--(sid,1003)
			RPC('CSBOSSInfo',1003)
		else
			PI_MovePlayer(23,18,89)
		end
		
	end,

	[304]=function ()
		--��ⶴ1��2�㸱��������
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[2006] ~= nil then

			--(sid,1004)
			RPC('CSBOSSInfo',1006)
		elseif taskData.current[1213] ~= nil then

			--(sid,1005)
			RPC('CSBOSSInfo',1007)
		else
			PI_MovePlayer(24,54,41)
		end	
	end,

	[305]=function ()
		--������1��2�㸱��������
		
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[1308] ~= nil then

			--(sid,1004)
			RPC('CSBOSSInfo',1010)
		elseif taskData.current[1321] ~= nil then

			--(sid,1005)
			RPC('CSBOSSInfo',1011)
		else
			PI_MovePlayer(28,5,11)
		end	
	end,

	[306]=function ()
		--������ ��������
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[1168] ~= nil then

			--(sid,1004)
			RPC('CSBOSSInfo',1004)
		elseif taskData.current[1173] ~= nil then

			--(sid,1005)
			RPC('CSBOSSInfo',1005)
		else
			--PI_MovePlayer(30,16,5)
			PI_MovePlayer(32,55,56)
		end	
	end,

	[307]=function ()
		--������ ��������
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[1216] ~= nil then
			RPC('CSBOSSInfo',1008)
		elseif  taskData.current[2019] ~= nil then
			RPC('CSBOSSInfo',1016)
		else
			PI_MovePlayer(31,26,113)
		end	
	end,

	[308]=function ()
		--����  ����
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[1217] ~= nil then
			RPC('CSBOSSInfo',1009)
		else
			--PI_MovePlayer(33,3,87)
			PI_MovePlayer(30,6,48)
		end	
	end,
	
	[309]=function ()
		--μˮ  ����
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[1375] ~= nil then
			RPC('CSBOSSInfo',1012)
		elseif  taskData.current[1403] ~= nil then
			RPC('CSBOSSInfo',1013)
		elseif  taskData.current[1409] ~= nil then
			RPC('CSBOSSInfo',1014)
		elseif  taskData.current[1413] ~= nil then
			RPC('CSBOSSInfo',1015)
		else

			--PI_MovePlayer(36,11,11)
		end	
	end,
	[310]=function ()
		--μˮ  ʮ����
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[1434] ~= nil then
			RPC('CSBOSSInfo',1017)
		elseif  taskData.current[1438] ~= nil then
			--�����	
			RPC('CSBOSSInfo',1018)
		else

			--PI_MovePlayer(37,11,11)
		end	
	end,
	[311]=function ()
		--μˮ  ������ 
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[1460] ~= nil then
			--������
		else

			--PI_MovePlayer(38,11,11)
		end	
	end,
	--���̾�����
	[312]=function ()
		local pos = Define_POS[math.random(1,#Define_POS)]
		PI_MovePlayer(pos[1],pos[2],pos[3])
	end,
	--ǬԪɽ��ˮ
	[313]=function ()
		local selfgid = CI_GetPlayerData(16)
		AreaRPC(0,nil,nil,"WQ_Jump",selfgid)
	end,
	--[[ׯ԰����
	[330]=function ()
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[2009] ~= nil then

			--(sid,1004)
			RPC('CSBOSSInfo',1020)
		end	
	end,]]--
	--����1���2��  45��
	[314]=function ()
		local zhanli = CI_GetPlayerData(62)
		local level = CI_GetPlayerData(1)
		if  zhanli < 30000 and level < 45 then
			TipCenter(GetStringMsg(18,30000,45))
			return
		else
			PI_MovePlayer(201,57,119)
		end
	end,
	--����2���3�� 50��
	[315]=function ()
		local zhanli = CI_GetPlayerData(62)
		local level = CI_GetPlayerData(1)
		if  zhanli < 45000 and level < 50 then
			TipCenter(GetStringMsg(18,45000,50))
			return
		else
			PI_MovePlayer(202,9,97)
		end
	end,
	--����3���4�� 55
	[316]=function ()
		local zhanli = CI_GetPlayerData(62)
		local level = CI_GetPlayerData(1)
		if  zhanli < 60000 and level < 55 then
			TipCenter(GetStringMsg(18,60000,55))
			return
		else
			PI_MovePlayer(203,9,83)
		end
	end,
	--����4���5�� 60
	[317]=function ()
		local zhanli = CI_GetPlayerData(62)
		local level = CI_GetPlayerData(1)
		if  zhanli < 80000 and level < 60 then
			TipCenter(GetStringMsg(18,80000,60))
			return
		else
			PI_MovePlayer(204,9,87)
		end
	end,
	--����5���6�� 65
	[318]=function ()
		local zhanli = CI_GetPlayerData(62)
		local level = CI_GetPlayerData(1)
		if  zhanli < 120000 and level < 65 then
			TipCenter(GetStringMsg(18,120000,65))
			return
		else
			PI_MovePlayer(205,71,132)
		end
	end,
	--����6���7�� 80
	[319]=function ()
		local zhanli = CI_GetPlayerData(62)
		local level = CI_GetPlayerData(1)
		if  zhanli < 350000 and level < 80 then
			TipCenter(GetStringMsg(18,350000,80))
			return
		else		
		PI_MovePlayer(206,9,102)
		end
	end,
	--����7���8��
	[320]=function ()
		local zhanli = CI_GetPlayerData(62)
		local level = CI_GetPlayerData(1)
		if  zhanli < 400000 and level < 90 then
			TipCenter(GetStringMsg(18,400000,90))
			return
		else		
		PI_MovePlayer(207,7,95)
		end
	end,
	--��᪵�����1
	[321]=function ()
		
		EnterGuajia()
	end,
	[10006]=function ()
		--ׯ԰�뿪
		local playerid=CI_GetPlayerData(17)
		OutZYparty(playerid,nil,0)
	end,
}
----------------------------------------------------------------
--interface:


--[[����ӿ�--�����������itype=1ģʽ������ܡ�
--itype=1(ֱ��),���ڳ�������Trapinfo={mapid,x,y,mapgid};---Ҫ���볡������newinfo={mapid,x,y,mapgid};---���巶Χlength����Ĭ��Ϊ3
--itype=2(�ص�),���ڳ�������Trapinfo={mapid,x,y,mapgid};---newinfo=�ص��ű�id;---���巶Χlength����Ĭ��Ϊ3��var=�������
--itype=3(�˺�),���ڳ�������Trapinfo={mapid,x,y,mapgid};
			newinfo={	[1]=�˺����ͣ�0 Ѫ�� 1 ŭ��;
						[2]=ֵ���ͣ� 0 ֵ 1 �ٷֱ�;
						[3]=��ֵ ����Ϊ�ӣ���Ϊ����;
						[4]=ǰ̨���ڱ���ʱ���õ�buffid  ]]--
function PI_MapTrap(itype,Trapinfo,newinfo,length, var)
	if type(Trapinfo)~=type({}) then return  end
	local SetTrap = SetTrap
	local regionID=Trapinfo[1]
	local x=Trapinfo[2]
	local y=Trapinfo[3]
	local regionGID=Trapinfo[4]
	if itype==1 then --ֱ�Ӵ�����
		if  type(newinfo)~=type({})  then
			look('mapinfo_error1',1)
			return
		end
		local new_regionID=newinfo[1]
		local new_x=newinfo[2]
		local new_y=newinfo[3]
		local new_regionGID=newinfo[4]
		if length == nil then
			length = 3 -- Ĭ��Ϊ3X3 9������
		end
		for i=0,length-1 do
			for j=0,length-1 do
				if type(mapID) == type(0) then --��������Ψһid
					mapID= mapID+1 
				end
				local a=SetTrap(regionID,mapID,1,new_regionID,new_x,new_y,regionGID,x+i-((length-1)/2),y+j-((length-1)/2), new_regionGID)
			end
		end
	elseif itype==2 then --�ص���
		if  type(newinfo)~=type(0)  then
			look('mapinfo_error2',1)
			return
		end
		if length == nil then
			length = 3 
		end
		for i=0,length-1 do
			for j=0,length-1 do
				if type(mapID) == type(0) then --��������Ψһid
					mapID= mapID+1 
				end
				SetTrap(regionID,mapID,4,x+i-((length-1)/2),y+j-((length-1)/2),newinfo, regionGID, var)
			end
		end
	elseif itype==3 then --�˺���
		if  type(newinfo)~=type({})  then
			look('mapinfo_error3',1)
			return
		end
		if length == nil then
			length = 3 
		end
		for i=0,length-1 do
			for j=0,length-1 do
				if type(mapID) == type(0) then --��������Ψһid
					mapID= mapID+1 
				end
				SetTrap(regionID,mapID,8,x+i-((length-1)/2),y+j-((length-1)/2),newinfo[1],regionGID,newinfo[2],newinfo[3],newinfo[4])
			end
		end
	else
		return
	end
end

local PI_MapTrap = PI_MapTrap

--����ɳ̲���㳡��
function EnterDongHai()
	if escort_not_trans() then
		return
	end
	PI_MovePlayer(100,25,35)
end
--����һ�����
function EnterGuajia()
	local lv=CI_GetPlayerData(1)
	if lv >=80 then
		PI_MovePlayer(206,9,105)
	elseif lv >=65 then
		PI_MovePlayer(205,71,132)
	elseif lv >=60 then
		PI_MovePlayer(204,25,58)
	elseif lv >=55 then
		PI_MovePlayer(203,13,80)
	elseif lv >=50 then
		PI_MovePlayer(202,25,35)
	elseif lv >=45 then
		PI_MovePlayer(201,25,35)
	else
		PI_MovePlayer(200,25,35)
	end
end
-----��������
function InitMapEvent()
	for k,v in pairs(trapconf) do
		PI_MapTrap(v[1],v[2],v[3])
	end
end
-----����ص�
function SI_OnMapEvent(id,arg)
	local funname=call_OnMapEvent[id]
	if type(funname)~=TP_FUNC then
		return
	end
	funname(arg)
end
