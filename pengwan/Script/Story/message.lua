--[[
file:	message.lua
desc:	store script messages.
author:	chal
update:	2011-12-02
]]--
--------------------------------------------------------------------------
--include:

--local msgDispatcher = msgDispatcher
--local CS_GetPlayerData = CS_GetPlayerData
--------------------------------------------------------------------------
-- data:
--[[
msgDispatcher[2][1] = function ( playerid, msg )
	--rfalse('msg.step'..msg.step)
	--ClickStoryStep(playerid, msg.npcid, msg.step , msg.storyid)
end

-- ��ȡ��������
msgDispatcher[2][2] = function(playerid, msg)
	----rfalse('���󳡾�����')
	-- local playData = CS_GetPlayerData(playerid)
	-- if playData ~= nil and playData.TaskID ~= nil then	--λ�ڸ��������ظ�������
		-- SendRegionStory(playData.TaskID,true)
	-- else	
		-- if	msg.regionID~=nil then						--����ָ����������
			-- SendRegionStory(msg.regionID)
		-- else
			-- local x,y,regionID = CI_GetCurPos()		--������ǰ��������
			-- SendRegionStory(regionID)
		-- end
	-- end
end
]]--