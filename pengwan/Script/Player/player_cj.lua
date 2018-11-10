local GI_GetPlayerData = GI_GetPlayerData
local BroadcastRPC = BroadcastRPC

local cj_conf = {
	[1] = {
		[{50,200}] = 1,
		[{200,500}] = 2,
		[{500,1000}] = 3,
		[{1000,1800}] = 4,
		[{1800,3000}] = 5,
		[{3000,4500}] = 6,
		[{4500,7000}] = 7,
		[{7000,90000}] = 8,		
	},
	[2] = {
		[{5,10}] = 1,
		[{10,20}] = 2,
		[{20,40}] = 3,
		[{40,80}] = 4,
		[{80,200}] = 5,
		[{200,400}] = 6,
		[{400,9000}] = 7,
	},
}

--获取玩家的春节活动
function GetDBChunJieData(playerid)
	local chjData = GI_GetPlayerData(playerid,'chj',20)
	if nil == chjData then
		return
	end	
	return chjData
end

-- 取等级
function CJ_GetLevel(playerid,iType)
	if playerid == nil or iType == nil then 
		return 0
	end
	local chjData = GetDBChunJieData(playerid)				
	if chjData == nil then 
		return 0
	end
	local conf = cj_conf[iType]
	if conf == nil then 
		return 0
	end
	local num = chjData[iType] or 0	
	for k, v in pairs(conf) do
		if num >= k[1] and num < k[2] then
			return v
		end
	end
	return 0
end

-- iType [1]经验 [2] 好感
-- br 是否广播
function UpdateChunJieData(playerid,iType,num,br)  
	local chjData = GetDBChunJieData(playerid)				
	if chjData == nil then return end
	if num <= 0 then return end					--只允许增加
	
	if iType == 1 then 
		chjData[1] = (chjData[1] or 0) + num  	--加经验
		if br and br == 1 then
			local pName = CI_GetPlayerData(5,2,playerid)
			BroadcastRPC("cj_brcast",pName)
		end
	elseif iType == 2 then
		chjData[2] = (chjData[2] or 0) + num	--加好感度		
	end
	RPCEx(playerid,'cj_data',chjData,br)
end

-- 春节给红包
function CJ_GiveHB(playerid,num)
	if playerid == nil or num == nil then return end
	if num <= 0 then return end
	local chjData = GetDBChunJieData(playerid)				
	if chjData == nil then return end
	local cur = chjData[2] or 0
	num = math.min(num,400 - cur)
	if num <= 0 then return end
	if CheckGoods( 1456, num, 0, playerid, '给红包') == 0 then
		return
	end
	UpdateChunJieData(playerid,2,num)		-- 加好感度
	UpdateChunJieData(playerid,1,num*3)		-- 加经验
end