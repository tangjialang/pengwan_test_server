--include:
local msgDispatcher = msgDispatcher      --消息分配器 Script/msgHandler/s2c_msg_def文件下可查看消息的下标 经验神树为49
local jysh          = require('Script.shenshu.jysh_fun') --导入经验神树函数功能模块
local jysh_plant    = jysh.jysh_plant    --播种
local jysh_open     = jysh.jysh_open     --开启果实
local jysh_renovate = jysh.jysh_renovate --刷新
local jysh_look     = jysh.jysh_look     --查看
local jysh_obtain   = jysh.jysh_obtain   --摘取/偷取
local jysh_clear    = jysh.jysh_clear    --删除


--经验神树播种
msgDispatcher[49][1] = function(playerid,msg)
	--jysh_plant(playerid,msg.seed) --玩家的场景id 种子类型
	jysh_plant(playerid,msg.seed)
end

--经验神树开启果实
msgDispatcher[49][2] = function(playerid,msg)
	jysh_open(playerid,msg.fruit_type,msg.money) --果实类型  money是否翻倍 1不翻倍 0翻倍
end

--经验神树刷新
msgDispatcher[49][3] = function(playerid,msg) --msg.look_tree 大于0表示查看 等于0表示刷新
--	if 0 == msg.look_tree then
--		jysh_renovate(playerid,msg.tree_gid) --刷新
--	elseif 0 < msg.look_tree then
--		jysh_look(playerid,msg.tree_gid,msg.look_tree) --查看
if 0 == msg.look_tree then
	-- look("刷新")
		jysh_renovate(playerid,msg.npc_gid)
	elseif 0 < msg.look_tree then
	-- look("查看")
		jysh_look(playerid,msg.npc_gid,msg.look_tree)
	end
end

--经验神树摘取/偷取果实
msgDispatcher[49][4] = function(playerid,msg)
	jysh_obtain(playerid,msg.npc_gid)
end