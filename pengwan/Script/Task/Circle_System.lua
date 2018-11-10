--[[
file: Circle_System.lua
desc: ���ܻ�����
autor: csj
]]--

local pairs,ipairs,type = pairs,ipairs,type
local math_random = math.random
local rint = rint
local isFullNum = isFullNum
local TipCenter = TipCenter
local CircleTaskConfig = CircleTaskConfig
local CircleTaskLib = CircleTaskLib

MAXCIRCLE = 200

function GetCircleTaskData(playerID)
	local cctData = GI_GetPlayerData( playerID , "circle" , 40 )
	if nil == cctData then
		return
	end
	-- cctData = {
	--	[1] = 1,		-- ��������
	--	[2] = 1,		-- �ȼ�������
	--	[3] = 1,		-- ������
	-- 	num = 1,		-- ��ǰ����
	-- }
	return cctData
end

-- ����ܻ�����
function CCT_RandSystem(sid)
	local lv = CI_GetPlayerData(1,2,sid)
	if lv == nil or lv <= 0 then return end
	local taskData = GetDBTaskData(sid)
	if taskData == nil then return end
	if taskData.current and taskData.current[7001] then
		look('CCT_RandSystem taskid has accept',1)
		return
	end
	local cctData = GetCircleTaskData(sid)
	if cctData == nil then return end
	-- if cctData[1] or cctData[2] or cctData[3] then		-- logic check 
		-- look('CCT_RandSystem not clear',1)
	-- end
	local ctconf = CircleTaskConfig
	local idx = 0
	for k, config in ipairs(ctconf) do
		if lv >= config.LevelNeed[1] and lv <= config.LevelNeed[2] then
			idx = k
			break
		end
	end
	if idx == 0 then return end
	local tt
	-- ÿ23����һ����������
	local curnum = cctData.num or 0
	if curnum > 0 and curnum % 23 == 0 then
		tt = 101
	else
		local t = ctconf[idx].TaskScale
		local rd = math_random(1,10000)
		for k, v in ipairs(t) do
			if rd <= v then
				tt = k					-- ������������
				break
			end
		end
	end
		
	if tt == nil or CircleTaskLib[tt] == nil then return end
	local tp = idx		
	local ctLib = CircleTaskLib[tt][tp]
	if type(ctLib) ~= type({}) then return end
	local sn = math_random(1,#ctLib)
	
	-- �������ֵ
	cctData[1] = tt
	cctData[2] = tp
	cctData[3] = sn
	return true
end

-- �������������
function CCT_BuildComplete(sid)
	local cctData = GetCircleTaskData(sid)
	if cctData == nil then return end
	local tt,tp,sn = cctData[1],cctData[2],cctData[3]
	if tt == nil or tp == nil or sn == nil then 
		look('CCT_BuildComplete error 1')
		return
	end
	if CircleTaskLib[tt] == nil or CircleTaskLib[tt][tp] == nil then
		look('CCT_BuildComplete error 2')
		return
	end
	local ctLib = CircleTaskLib[tt][tp]
	return ctLib[sn]
end

-- ���ɽ�����
function CCT_BuildAwards(sid)
	local cctData = GetCircleTaskData(sid)
	if cctData == nil then return end
	local tt,tp,sn = cctData[1],cctData[2],cctData[3]
	if tt == nil or tp == nil or sn == nil then 
		look('CCT_BuildComplete error 1')
		return
	end
	if CircleTaskConfig[tp] == nil then
		look('CCT_BuildComplete error 2')
		return
	end
	local ctc_conf = CircleTaskConfig[tp]	
	return ctc_conf.CompleteAwards
end

-- �������ʣ�໷
function CCT_QuickComplete(sid)
	local taskData = GetDBTaskData(sid)
	if taskData == nil then return end
	local cctData = GetCircleTaskData(sid)
	if cctData == nil then return end
	local rest = MAXCIRCLE - (cctData.num or 0)
	if rest < 0 then rest = 0 end
	local cost = rint(rest * 10)
	if cost <= 0 then return end
	if not CheckCost(sid, cost, 1, 1, '�ܻ�����') then
		return
	end
	local lv = CI_GetPlayerData(1)
	if lv == nil or lv <= 0 then return end
	local ctconf = CircleTaskConfig
	local idx = 0
	for k, config in ipairs(ctconf) do
		if lv >= config.LevelNeed[1] and lv <= config.LevelNeed[2] then
			idx = k
			break
		end
	end
	if idx == 0 then return end
	local Awards = ctconf[idx].CompleteAwards
	if Awards == nil then return end
	local money = rint(Awards[1] * rest)
	-- local lq = rint(Awards[5] * rest)
	
	local extra = ctconf[idx].ExtraAwards
	local higher = table.maxn(extra)
	if higher == nil then return end
	for k, v in pairs(extra) do
		if k >= (cctData.num or 0) and k <= higher  then
			higher = k
		end
	end
	if type(extra[higher]) ~= type({}) then return end
	local num = #extra[higher]
	local pakagenum = isFullNum()
	if pakagenum < #extra[higher] then
		TipCenter(GetStringMsg(14,num))
		return
	end
	if taskData.current and taskData.current[7001] then
		taskData.current[7001] = nil
	end
	cctData.num = MAXCIRCLE
	cctData[1] = nil
	cctData[2] = nil
	cctData[3] = nil
	-- �ж���� ��ʼ��ǮǮ
	if not CheckCost(sid, cost, 0, 1, '100032_�ܻ�����') then
		return
	end
	-- ������
	GiveGoods(0,money,1,'�ܻ�������')
	-- AddPlayerPoints( sid, 2, lq, nil, '�ܻ�������' )
	GiveGoodsBatch(extra[higher],'�ܻ�������⽱��')
	RPC('circle_quick')
end

-- ÿ�����ò��Զ�������
function CCT_WeekReset(sid)
	local taskData = GetDBTaskData(sid)
	if taskData == nil then return end
	local cctData = GetCircleTaskData(sid)
	if cctData == nil then return end
	
	-- ���������������
	if taskData.current[7001] and taskData.current[7001] then
		taskData.current[7001] = nil
	end
	cctData.num = 0
	cctData[1] = nil
	cctData[2] = nil
	cctData[3] = nil
		
	-- ���½ӵ�һ������()
	TS_AcceptTask( sid, 7001, 0)
end