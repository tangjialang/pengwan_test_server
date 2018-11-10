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
--����ϵͳ��Ϣ
function TipNormal(Msg)
	RPC("ShowMsg", Msg, 0)
end
--�·�����������Ϣ
function TipUnder(Msg, fadeOut)
	RPC("ShowMsg", Msg, 1, fadeOut or 20 )
end
--�м������Ϣ
function TipCenter(Msg)
	RPC("ShowMsg", Msg, 2 )
end
--�м���ɫ��Ϣ(�㲥)
function TipCenterEx(Msg, fadeOut)
	BroadcastRPC("ShowMsg", Msg, 3, fadeOut or 20 )
end
--�м����(�㲥)
function TipCBrodCast(Msg, fadeOut)
	BroadcastRPC("ShowMsg", Msg, 4 , fadeOut or 20 )
end
--����������(�㲥)
function TipChatBar(Msg)
	BroadcastRPC("ShowMsg", Msg, 5 )
end
--�м����+������(�㲥)
function TipABrodCast(Msg, fadeOut)
	BroadcastRPC("ShowMsg", Msg, 6 , fadeOut or 20 )
end

--������Ϣ
-- function TipMB(Msg)
	-- RPC("MessageBox", Msg )
-- end
--������ѡ�����Ϣ     arg = {20,3,100,����}
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
--�����Ϊ�����Ĺ���
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
--TipCMB(1,1,1,"ShowMsg", "�߻������� ", 0)
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
--�����Ϊ�����Ĺ���
-- function TipCBrodCast(c1,c2,level,Msg , fadeOut)
	-- CampRPC(c1,c2,level,"ShowMsg", Msg , 4 , fadeOut or 20 )
-- end
--�԰�ᷢ��
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
