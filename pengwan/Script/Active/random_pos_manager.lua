--
--	������괦��ϵͳ
--	Ŀ�ģ��������ˢ�µ��߼�����Ҫ�Ƿ�ֹ��ͬһ�����ˢ�¹������ NPC
--

-- �������ݽṹ
-- RandPosSys_Open = { [RandPosID] = { Key1, Key2, ... }, }
-- RandPosSys_Close = { [RandPosID] = { Key1, Key2, ... }, }

-------------------------------------------------------------
--include:
local pairs,ipairs,type ,tostring= pairs,ipairs,type,tostring
local mathrandom = math.random
local tableremove,tableinsert,tableempty = table.remove,table.insert,table.empty

local look = look
local pos_conf_m = require('Script.active.random_pos_conf')
local rand_pos_config = pos_conf_m.rand_pos_config

-------------------------------------------------------------
--module:

module(...)

RandPosSys_Flag = RandPosSys_Flag or 0		-- ��ˢ����

RandPosSys_Open = RandPosSys_Open or {}
RandPosSys_Close = RandPosSys_Close or {}
	
local RandPosSys_Open = RandPosSys_Open
local RandPosSys_Close = RandPosSys_Close

---------------------------------------------------------
--inner:

-- �������ϵͳ��ʼ��
local function RandPosSys_Init()
	for ID,v in pairs(rand_pos_config) do
		RandPosSys_Open[ID] = {}
		RandPosSys_Close[ID] = {}
		for Key, _ in pairs(v) do
			tableinsert(RandPosSys_Open[ID], Key)
		end
	end
end

-- ��ˢ����
local function _RandPosSys_AvoidRef()
	if RandPosSys_Flag == 0 then
		----rfalse("��ʼ����")
		RandPosSys_Init()
		RandPosSys_Flag = 1
	end
end

-- ���� rand_pos_config[ID] ������regionID
local function _RandPosSys_GetAll(ID)
	if type(rand_pos_config) == type({}) then
		return rand_pos_config[ID]
	end
end

-- �� rand_pos_config[ID] �����ȡ��һ�����õ�����
-- ����ֵ�������ţ�X���꣬Y���꣬��λ���� rand_pos_config[ID] ���е�����, dir
local function _RandPosSys_Get(ID,isSave)
	-- look(RandPosSys_Open,1)
	if RandPosSys_Open[ID] == nil then
		look("RandPosSys_Get invalid ID:" .. tostring(ID),1)
		return
	end

	if tableempty(RandPosSys_Open[ID]) then
		look("RandPosSys_Open empty",1)
		return
	end
	local Rand = mathrandom(#RandPosSys_Open[ID])
	-- look(2222,1)
	-- look(ID,1)
	local Index = RandPosSys_Open[ID][Rand]
	local R = rand_pos_config[ID][Index].R
	local X = rand_pos_config[ID][Index].X
	local Y = rand_pos_config[ID][Index].Y
	-- look(Rand,1)
	-- look(R,1)
	-- look(Y,1)
	-- look(3333,1)
	if isSave == nil then 
		tableremove(RandPosSys_Open[ID], Rand)		-- �� Open �����Ƴ� Rand λ�õ�λ������
		tableinsert(RandPosSys_Close[ID], Index)	-- ��λ������ Index ���� Close ��
	end

	if rand_pos_config[ID][Index].Dir then
		return R, X, Y, Index, rand_pos_config[ID][Index].Dir
	else
		return R, X, Y, Index
	end
end

-- �� rand_pos_config[ID] �����ȡ��һ�����õ����꣬�ų��� ExIndex ������
-- ����ֵ�������ţ�X���꣬Y���꣬��λ���� rand_pos_config[ID] ���е�����
-- ����������ܻ������ѭ��!!!��ʱû����ע�͵�
-- function RandPosSys_GetExcept(ID, ExIndex)

	-- if RandPosSys_Open[ID] == nil then
		-- --rfalse("RandPosSys_GetExcept ��Ч�� ID:" .. tostring(ID))
		-- return
	-- end
	
	-- if table.empty(RandPosSys_Open[ID]) then
		-- --rfalse("�Ѿ�û�п���ʹ�õ�λ����...")
		-- return
	-- end

	-- if #(RandPosSys_Open[ID]) == 1 and RandPosSys_Open[ID][1] == ExIndex then
		-- --rfalse("RandPosSys_Open ����ֻ����һ������ʹ�õ�λ��...")
		-- return
	-- end

	-- local Rand = mathrandom(#RandPosSys_Open[ID])
	-- while RandPosSys_Open[ID][Rand] == ExIndex do
		-- Rand = mathrandom(#RandPosSys_Open[ID])
	-- end

	-- local Index = RandPosSys_Open[ID][Rand]
	-- local R = rand_pos_config[ID][Index].R
	-- local X = rand_pos_config[ID][Index].X
	-- local Y = rand_pos_config[ID][Index].Y

	-- tableremove(RandPosSys_Open[ID], Rand)		-- �� Open �����Ƴ� Rand λ�õ�λ������
	-- tableinsert(RandPosSys_Close[ID], Index)	-- ��λ������ Index ���� Close ��

-- --	return R, X, Y, Index

	-- -- ��� ����...= =
	-- if rand_pos_config[ID][Index].Dir then
		-- return R, X, Y, Index, rand_pos_config[ID][Index].Dir
	-- else
		-- return R, X, Y, Index
	-- end
-- end

-- ��־ rand_pos_config[ID][Index] ���������
-- ʵ���Ͻ������������� CLose[ID] ����ɾ�������� Open[ID] ��
local function RandPosSys_Reuse(ID, Index)
	if RandPosSys_Close[ID] then
		for k,v in pairs(RandPosSys_Close[ID]) do
			if v == Index then
				tableremove(RandPosSys_Close[ID], k)
				tableinsert(RandPosSys_Open[ID], Index)
				break
			end
		end
	end
end

-- ��־ rand_pos_config[ID] �������������
local function _RandPosSys_ReuseAll(ID)
	if RandPosSys_Close[ID] then
		for k in pairs(RandPosSys_Close[ID]) do
			RandPosSys_Close[ID][k] = nil			
		end
	end
	if rand_pos_config[ID] then
		for Key, _ in pairs(rand_pos_config[ID]) do
			tableinsert(RandPosSys_Open[ID], Key)
		end
	end
end

-----------------------------------------------------------
--interface:

RandPosSys_Get = _RandPosSys_Get
RandPosSys_AvoidRef = _RandPosSys_AvoidRef
RandPosSys_GetAll = _RandPosSys_GetAll
RandPosSys_ReuseAll = _RandPosSys_ReuseAll
