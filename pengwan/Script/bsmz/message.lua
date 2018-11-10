
--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local bsmz          = require ("Script.bsmz.bsmz_fun")
local bsmz_open = bsmz.bsmz_open
local bsmz_begin = bsmz.bsmz_begin
local bsmz_play = bsmz.bsmz_play
local bsmz_save_map = bsmz.bsmz_save_map 
local RPC = RPC
local look = look
--------------------------------------------------------------------------

--��ʯ����
    --������Ϸ
msgDispatcher[54][1] = function(playerid,msg)	--open״̬��nilδ������1����,2����		num:��Ծ����
	local result,data = bsmz_open(playerid,msg.num)
	if result == false then 
		look("bsmz_open error:")
		look(data)
	end
	RPC('bsmz_open',result,data)		
end

    --��ʼ��Ϸ����ʼ����
msgDispatcher[54][2] = function(playerid,msg)	
    look("��ʼ��Ϸ")	
	local result,data1,data2,data3,data4,data5,data6 = bsmz_begin(playerid)
	if result == false then 
		look("bsmz_begin error:")
		look(data1)
	end	
		--result = true,data = ��ͼ��Boss��ǰѪ����Boss��Ѫ�������а񣬸��˲������������˺�
	RPC('bsmz_begin',result,data1,data2,data3,data4,data5,data6)		
end

	--�ƶ�+�˺�����Ϸ���̣�
msgDispatcher[54][3] = function(playerid,msg) 
	--msg.allmultiple�ܱ���	--msg.sub�۷ѱ�ʶ --msg.map_save��ʯ��ͼ
	local result,data1,data2 = bsmz_play(playerid,msg.allmultiple,msg.sub,msg.map_save)
	if result == false then 
		look("bsmz_play error:")
		look(data1)
	end
		--result = true,data = ���˲������������˺�
	RPC('bsmz_play',result,data1,data2)
end

msgDispatcher[54][4] = function(playerid,msg)
	look("���ͼ")
	bsmz_save_map(playerid,msg.map_save)
end





