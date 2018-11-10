
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

--宝石迷阵
    --开启游戏
msgDispatcher[54][1] = function(playerid,msg)	--open状态：nil未开启，1开启,2结束		num:活跃人数
	local result,data = bsmz_open(playerid,msg.num)
	if result == false then 
		look("bsmz_open error:")
		look(data)
	end
	RPC('bsmz_open',result,data)		
end

    --开始游戏（初始化）
msgDispatcher[54][2] = function(playerid,msg)	
    look("开始游戏")	
	local result,data1,data2,data3,data4,data5,data6 = bsmz_begin(playerid)
	if result == false then 
		look("bsmz_begin error:")
		look(data1)
	end	
		--result = true,data = 地图，Boss当前血量，Boss总血量，排行榜，个人步数，个人总伤害
	RPC('bsmz_begin',result,data1,data2,data3,data4,data5,data6)		
end

	--移动+伤害（游戏过程）
msgDispatcher[54][3] = function(playerid,msg) 
	--msg.allmultiple总倍数	--msg.sub扣费标识 --msg.map_save宝石地图
	local result,data1,data2 = bsmz_play(playerid,msg.allmultiple,msg.sub,msg.map_save)
	if result == false then 
		look("bsmz_play error:")
		look(data1)
	end
		--result = true,data = 个人步数，个人总伤害
	RPC('bsmz_play',result,data1,data2)
end

msgDispatcher[54][4] = function(playerid,msg)
	look("存地图")
	bsmz_save_map(playerid,msg.map_save)
end





