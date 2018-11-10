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

-- 获取场景剧情
msgDispatcher[2][2] = function(playerid, msg)
	----rfalse('请求场景剧情')
	-- local playData = CS_GetPlayerData(playerid)
	-- if playData ~= nil and playData.TaskID ~= nil then	--位于副本，加载副本剧情
		-- SendRegionStory(playData.TaskID,true)
	-- else	
		-- if	msg.regionID~=nil then						--触发指定场景剧情
			-- SendRegionStory(msg.regionID)
		-- else
			-- local x,y,regionID = CI_GetCurPos()		--触发当前场景剧情
			-- SendRegionStory(regionID)
		-- end
	-- end
end
]]--