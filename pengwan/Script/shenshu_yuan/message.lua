
--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local jysh          = require('Script.shenshu.jysh_fun')
local jysh_plant    = jysh.jysh_plant
local jysh_open     = jysh.jysh_open
local jysh_renovate = jysh.jysh_renovate
local jysh_obtain   = jysh.jysh_obtain
local jysh_look     = jysh.jysh_look
local jysh_clear = jysh.jysh_clear
--------------------------------------------------------------------------


--经验神树
    --播种
msgDispatcher[49][1] = function(playerid,msg)
  --  look("播种")
	jysh_plant(playerid,msg.seed)
end
   --果实开启
msgDispatcher[49][2] = function(playerid,msg)
    --look("果实开启")
	jysh_open(playerid,msg.fruit_type,msg.money)
end
  --刷新
msgDispatcher[49][3] = function(playerid,msg)

	if 0 == msg.look_tree then
	-- look("刷新")
		jysh_renovate(playerid,msg.npc_gid)
	elseif 0 < msg.look_tree then
	-- look("查看")
		jysh_look(playerid,msg.npc_gid,msg.look_tree)
	end
end
 -- 摘取和偷取
msgDispatcher[49][4] = function(playerid,msg)
 --   look("偷取摘取")
	jysh_obtain(playerid,msg.npc_gid)
end


function clean_tree(sid)
	jysh_clear(sid)
end
