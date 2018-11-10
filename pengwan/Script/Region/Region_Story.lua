--[[
file:	Region_Story.lua
desc:	region story conf.
author:	chal
update:	2011-12-05
]]--
--[[
local RegionStoryList = {
	[2] = 300001,	--新手村
	[3] = 300000,	--临安东郊
	[5] = 300002,	--历城
}
--副本剧情对应
local CopysenceStoryList = {
[1001] = 700011,
[1002] = 700012,
[1003] = 700013,
[2001] = 700001,
[2002] = 700002,
[2003] = 700003,
[2004] = 700004,
[2005] = 700005,
[2006] = 700006,
[2901] = 700001,
[2902] = 700002,
[2903] = 700003,
[2904] = 700004,
[2905] = 700005,
[2906] = 700006,
[3001] = 700014,
[3002] = 700015,
[3003] = 700016,
[3004] = 700017,
[3005] = 700018,
[3006] = 700019,
[3901] = 700014,
[3902] = 700015,
[3903] = 700016,
[3904] = 700017,
[3905] = 700018,
[3906] = 700019,
[4001] = 700020,
[4002] = 700021,
[4003] = 700022,
[4004] = 700023,
[4006] = 700024,
[4901] = 700020,
[4902] = 700021,
[4903] = 700022,
[4904] = 700023,
[4906] = 700024,
[100100] = 700025,
[100101] = 700026,
[100102] = 700027,
[100103] = 700028,
}

function  SendRegionStory(regionID,isFb)
	-- cs story.
	if isFb then
		local storyID =CopysenceStoryList[regionID]
		if storyID~=nil and type(storyID) == type(0) then
			SendStoryData(storyID)
		end
	else
		-- common region.
		local storyID =RegionStoryList[regionID]
		if storyID~=nil and type(storyID) == type(0) then
			SendStoryData(storyID)
		end
	end
end
]]--