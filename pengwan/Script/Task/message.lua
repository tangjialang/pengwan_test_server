--[[
file:	message.lua
desc:	task script messages.
author:	chal
update:	2011-12-02
]]--

--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local XValue_Init  = msgh_s2c_def[1][7]
local SendTaskInfo,TS_AcceptTask,TS_SubmitTask = SendTaskInfo,TS_AcceptTask,TS_SubmitTask
local TS_DropTask,RT_RefreshTask,RT_GetRingData = TS_DropTask,RT_RefreshTask,RT_GetRingData
--------------------------------------------------------------------------
-- data:

-- Query task/npc info if client cannot get from local.
msgDispatcher[1][1] = function ( playerid, msg )
	if ( msg.query_taskid ~= nil ) then
		--rfalse("send player's task info.  "..msg.query_taskid)
		SendTaskInfo( playerid,msg.query_taskid )
	elseif ( msg.query_npcid ~= nil ) then
		--rfalse("send player's npc data.")
		--SendNpcInfo( playerid , msg.query_npcid )
	else 
		--rfalse('unknown query from client by idx = {1,1}')
	end
end

-- Accept task.
msgDispatcher[1][2] = function ( playerid, msg )
	if playerid and msg then
		TS_AcceptTask( playerid, msg.taskid, msg.npcid, msg.nSelect  )
	end
end
-- submit task.
msgDispatcher[1][3] = function ( playerid, msg )
	if playerid and msg then
		TS_SubmitTask( playerid, msg.taskid, msg.npcid, msg.direct )
	end
end
-- drop task.
msgDispatcher[1][4] = function ( playerid, msg )
	TS_DropTask( playerid, msg.taskid)
end
--[[
-- click npc task
msgDispatcher[1][5] = function ( playerid, msg )
	checkClickNpcTask( GetDBTaskData(playerid), msg.npcid, msg.taskid )
end
--VIP����ֱ���������
msgDispatcher[1][6] = function ( playerid, msg )
	--rfalse(" VIP qingqiu "..tostring(msg.taskid).."  -== "..tostring(msg.goodid))
	VIPSubmitTask(playerid,msg.taskid,msg.goodid,msg.npcid)
end
--�������һ��������
msgDispatcher[1][7] = function ( playerid, msg )
	--rfalse("�������һ��������   "..GetXValueExp())
	SendLuaMsg( 0, { ids=XValue_Init, left = IsXValueValid(0) , xexp = GetXValueExp() }, 9 )
end

--�����һ�����
msgDispatcher[1][8] = function ( playerid, msg )
	BuyXValueExp(playerid,msg.xval)
	SendLuaMsg( 0, { ids=XValue_Init, left = IsXValueValid(0) , xexp = GetXValueExp() }, 9 )
end
]]--
--ˢ����������
msgDispatcher[1][11] = function ( playerid, msg )
	RT_RefreshTask(playerid)
end

-- ��ȡ������������
msgDispatcher[1][12] = function ( playerid, msg )
	RT_GetRingData(playerid)
end

--����ϵͳר��,+100��buff
msgDispatcher[1][13] = function ( playerid, msg )
	power_uptask( playerid )
end
--ǰ̨�������
msgDispatcher[1][14] = function ( playerid, msg )
	bury_id( playerid,msg.id ,msg.lv)
end
--ǰ̨��shareд�洢
msgDispatcher[1][15] = function ( playerid, msg )
	b_openshare()
end
--�ܻ������
msgDispatcher[1][16] = function ( playerid, msg )
	task_creatnpcmonster(msg.npcid)
end
--�ܻ��������ȫ�����
msgDispatcher[1][17] = function ( playerid, msg )
	CCT_QuickComplete(playerid)
end
--�����������ȫ�����
msgDispatcher[1][18] = function ( playerid, msg )
	RT_DirectComplete(playerid)
end
--����ճ��������ȫ�����
msgDispatcher[1][19] = function ( playerid, msg )
	DTS_DirectComplete(playerid)
end


