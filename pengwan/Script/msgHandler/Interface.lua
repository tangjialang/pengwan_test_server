--[[
file:	Interface.lua
desc:	mssage interface.
author:	chal
update:	2011-12-07
]]--

--////////////////////////////////////////
-- send self-define msg.

--------------------------------------------------------------------------
--include:
local RPC = RPC
local TeamRPC = TeamRPC
local RegionRPC = RegionRPC
local BroadcastRPC = BroadcastRPC
--local CampRPC = CampRPC
local FactionRPC = FactionRPC
--------------------------------------------------------------------------
--interface:
--To player:
--右下系统消息
function TipNormal(Msg)
	RPC("ShowMsg", Msg, 0)
end
--下方任务描述信息
function TipUnder(Msg, fadeOut)
	RPC("ShowMsg", Msg, 1, fadeOut or 20 )
end
--中间错误消息
function TipCenter(Msg)
	RPC("ShowMsg", Msg, 2 )
end
--中间颜色消息(广播)
function TipCenterEx(Msg, fadeOut)
	BroadcastRPC("ShowMsg", Msg, 3, fadeOut or 20 )
end
--中间滚动(广播)
function TipCBrodCast(Msg, fadeOut)
	BroadcastRPC("ShowMsg", Msg, 4 , fadeOut or 20 )
end
--左下聊天栏(广播)
function TipChatBar(Msg)
	BroadcastRPC("ShowMsg", Msg, 5 )
end
--中间滚动+聊天栏(广播)
function TipABrodCast(Msg, fadeOut)
	BroadcastRPC("ShowMsg", Msg, 6 , fadeOut or 20 )
end

--弹框信息
-- function TipMB(Msg)
	-- RPC("MessageBox", Msg )
-- end
--带传送选项的信息     arg = {20,3,100,费用}
-- function TipWithTile(Msg,arg)
	-- RPC("TipTile", Msg ,arg)
-- end
-- To Team:
-- function TipTNormal(tid , Msg )
	-- TeamRPC(tid , "ShowMsg", Msg, 0)
-- end
-- function TipTCenter(tid , Msg , fadeOut)
	-- TeamRPC(tid , "ShowMsg", Msg , 2 , fadeOut or 20 )
-- end
-- function TipTUnder(tid , Msg , fadeOut)
	-- TeamRPC(tid , "ShowMsg", Msg , 1 , fadeOut or 20 )
-- end
-- function TipTMB(tid , Msg)
	-- TeamRPC(tid , "MessageBox", Msg )
-- end
-- function TipTWithTile(tid ,Msg,arg)
	-- TeamRPC(tid,"TipTile", Msg ,arg)
-- end
-- To region:
-- function TipRNormal(regionID , Msg )
	-- RegionRPC(regionID ,"ShowMsg", Msg, 0)
-- end
-- function TipRCenter(regionID ,Msg , fadeOut)
	-- RegionRPC(regionID ,"ShowMsg", Msg , 2 , fadeOut or 20 )
-- end
-- function TipRUnder(regionID ,Msg , fadeOut)
	-- RegionRPC(regionID ,"ShowMsg", Msg , 1 , fadeOut or 20 )
-- end
-- function TipRMB(regionID ,Msg)
	-- RegionRPC(regionID ,"MessageBox", Msg )
-- end
-- function TipRWithTile(regionID ,Msg,arg)
	-- RegionRPC(regionID ,"TipTile", Msg ,arg)
-- end
--玩家行为触发的公告
-- function TipRBrodCast(regionID ,Msg , fadeOut)
	-- RegionRPC(regionID ,"ShowMsg", Msg , 4 , fadeOut or 20 )
-- end
-- To all:
-- function TipANormal(Msg )
	-- BroadcastRPC("ShowMsg", Msg, 0)
-- end
-- function TipACenter(Msg , fadeOut)
	-- BroadcastRPC("ShowMsg", Msg , 2 , fadeOut or 20 )
-- end
-- function TipAUnder(Msg , fadeOut)
	-- BroadcastRPC("ShowMsg", Msg , 1 , fadeOut or 20 )
-- end
function TipAMB(Msg)
	BroadcastRPC("MessageBox", Msg )
end
-- function TipAWithTile(Msg,arg)
	-- BroadcastRPC("TipTile", Msg ,arg)
-- end

-- To Camp:
-- function TipCNormal( c1,c2,level,Msg )
	-- CampRPC(c1,c2,level,"ShowMsg", Msg, 0)
-- end
--TipCMB(1,1,1,"ShowMsg", "策划四以下 ", 0)
-- function TipCCenter(c1,c2,level,Msg , fadeOut)
	-- CampRPC(c1,c2,level,"ShowMsg", Msg , 2 , fadeOut or 20 )
-- end
-- function TipCUnder(c1,c2,level,Msg , fadeOut)
	-- CampRPC(c1,c2,level,"ShowMsg", Msg , 1 , fadeOut or 20 )
-- end
-- function TipCMB(c1,c2,level,Msg)
	-- CampRPC(c1,c2,level,"MessageBox", Msg )
-- end
-- function TipCWithTile(c1,c2,level,Msg,arg)
	-- CampRPC(c1,c2,level,"TipTile", Msg ,arg)
-- end
--玩家行为触发的公告
-- function TipCBrodCast(c1,c2,level,Msg , fadeOut)
	-- CampRPC(c1,c2,level,"ShowMsg", Msg , 4 , fadeOut or 20 )
-- end
--对帮会发送
-- function TipFNormal(name,Msg)
	-- FactionRPC(name ,"ShowMsg",Msg,0)
-- end
-- function TipFCenter(name,Msg)
	-- FactionRPC(name ,"ShowMsg",Msg,2)
-- end
-- function TipFUnder(name,Msg)
	-- FactionRPC(name ,"ShowMsg",Msg,1)
-- end
-- function TipFWithTile(name,Msg,arg)
	-- FactionRPC(name,"TipTile", Msg ,arg)
-- end
-- function TipFBrodCast(name,Msg , fadeOut)
	-- FactionRPC(name,"ShowMsg", Msg , 4 , fadeOut or 20 )
-- end
