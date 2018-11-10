--[[
file:	player_pos.lua
desc:	人物官职
author:	xiao.y
update:2013-7-1
refix:	done by xy
]]--
--------------------------------------------------------------------------
--include:
local ipairs = ipairs
local uv_TimesTypeTb = TimesTypeTb
local Player_Pos = msgh_s2c_def[3][11]
local Player_PosFail	= msgh_s2c_def[3][12]
local GetPlayerPoints = GetPlayerPoints
local AddPlayerPoints = AddPlayerPoints
local CheckTimes = CheckTimes
local look = look
local SendLuaMsg = SendLuaMsg
local IsPlayerOnline = IsPlayerOnline
--------------------------------------------------------------------------
-- data:

--官职配置
local CampPostConf = {
	[1] = {name = '庶民',ico = 389,ifloor = 1, salary = 100,feats = 0,gico = {648,9901,9903,9905,9907,9908,9909}}, --name 名字 salary 俸禄 feats 功勋 gico 可兑换物品ICO
	[2] = {name = '下士',ico = 388,ifloor = 1, salary = 150,feats = 100,gico = {648,9901,9903,9905,9907,9908,9909}},
	[3] = {name = '上士',ico = 387,ifloor = 1, salary = 200,feats = 500,gico = {648,9901,9903,9905,9907,9908,9909}},
	[4] = {name = '准男爵',ico = 386,ifloor = 2, salary = 250,feats = 1000,gico ={648,9901,9903,9905,9907,9908,9909}},
	[5] = {name = '男爵',ico = 385,ifloor = 2, salary = 300,feats = 3000,gico ={648,9901,9903,9905,9907,9908,9909}},
	[6] = {name = '准子爵',ico = 384,ifloor = 3, salary = 350,feats = 6000,gico ={648,9901,9903,9905,9907,9908,9909}},
	[7] = {name = '子爵',ico = 383,ifloor = 3, salary = 400,feats = 12000,gico ={648,9901,9903,9905,9907,9908,9909}},
	[8] = {name = '准伯爵',ico = 382,ifloor = 4, salary = 450,feats = 24000,gico ={648,9901,9903,9905,9907,9908,9909}},
	[9] = {name = '伯爵',ico = 381,ifloor = 4, salary = 500,feats = 48000,gico ={648,9901,9903,9905,9907,9908,9909}},
	[10] = {name = '准侯爵',ico = 380,ifloor = 5, salary = 600,feats = 80000,lose = 200,gico ={648,9901,9903,9905,9907,9908,9909}},
	[11] = {name = '侯爵',ico = 379,ifloor = 5, salary = 700,feats = 130000,lose = 300,gico = {648,9901,9903,9905,9907,9908,9909}},
	[12] = {name = '公爵',ico = 378,ifloor = 5, salary = 800,feats = 200000,lose = 400,gico = {648,9901,9903,9905,9907,9908,9909}},
	[13] = {name = '王爵',ico = 377,ifloor = 6, salary = 1000,feats = 300000,lose = 600,gico = {648,9901,9903,9905,9907,9908,9909}},
}

--官职功勋值设置
function AddPosFeats(sid,val)
	local pName = PI_GetPlayerName(sid)
	local cpt = GetPlayerPoints( sid , 6 )
	if(cpt == nil)then
		cpt = 0
	end --无数据
	local temp = cpt
	AddPlayerPoints( sid , 6 , val ,nil,'功勋')
	cpt = GetPlayerPoints( sid , 6 )
	local temp1 = cpt
	
	if(temp == temp1)then 
		SendLuaMsg( sid, { ids = Player_PosFail, t = 1, data = 2}, 10 )
	end --值未变化
	
	local post = 0
	local post1 = 0
	post1 = GetPos(temp1)
	post = GetPos(temp)
	
	local isup = 0
	if(post ~= post1)then
		isup = (post1>post and 1) or 2 --1升职2降职
	end
	
	if(IsPlayerOnline(sid))then
		SendLuaMsg( sid, { ids = Player_Pos, t = 1, isup = data}, 10 )
	end
end
--根据功勋取官职索引
function GetPos(val)
	-- look('GetPos')
	-- look(val)
	local pos = 1
	if(val ~= nil)then
		for i,v in ipairs(CampPostConf) do
			if(val<v.feats)then break end
			pos = i
		end
	end
	return pos
end
--[[
--根据SID取官职索引
function GetPosFromSid(sid)
	local cpt = GetPlayerPoints( sid , 6 )
	if(cpt == nil)then return 0 end --无数据
	
	return GetPos(cpt)
end
]]--
--领取俸禄
function GetSalary(sid)
	local cpt = GetPlayerPoints( sid , 6 )
	if(cpt == nil)then
		cpt = 0
	end --无数据
	local post = GetPos(cpt)
	
	if(CampPostConf[post] == nil)then return false,4 end --无俸禄可领
	local salary = CampPostConf[post].salary
	if(salary == nil) then return false,4 end
	
	if(not CheckTimes(sid,uv_TimesTypeTb.POS_Salary,1,-1))then
		return false,3 --今日已领过了
	end
	
	local pt = GetPlayerPoints(sid,3)
	local ptVal = 0
	if(pt~=nil)then ptVal = pt end
	AddPlayerPoints(sid,3,salary,nil,'领俸禄')
	pt = GetPlayerPoints(sid,3)
	local pt1Val = pt
	
	local addpt = pt1Val - ptVal

	return true,addpt
end




