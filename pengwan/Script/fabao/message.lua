
--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local fabao = require('Script.fabao.fabao_fun')
local fabao_update = fabao.fabao_update
local hunshi_xiangqian       = fabao.hunshi_xiangqian
local hunshi_xiezai     = fabao.hunshi_xiezai
local fb_activated     =  fabao.fb_activated
--------------------------------------------------------------------------

--±æ√¸∑®±¶…˝–«
msgDispatcher[51][1] = function(playerid,msg)
    look('±æ√¸∑®±¶…˝–«')
	fabao_update(playerid,msg.goodsa_num,msg.bts_num,msg.itype)
end
--ªÍ Øœ‚«∂°¢ªÍ Ø–∂‘ÿ
msgDispatcher[51][2] = function(playerid,msg)
   if 1 == msg.itype then
        look('ªÍ Øœ‚«∂')
	    hunshi_xiangqian(playerid,msg.goods_num,msg.goods_id,msg.bianhao)
    elseif 2 == msg.itype then 
        look('ªÍ Ø–∂‘ÿ')
        hunshi_xiezai(playerid,msg.goods_num,msg.goods_id,msg.bianhao)
    end
end
--∑®±¶º§ªÓ
msgDispatcher[51][3] = function(playerid,msg)
        look('∑®±¶º§ªÓ')
	    fb_activated(playerid,msg.goods_num,msg.xing)
end
