--[[
file:	random.norepeat.lua
desc:	��������������ظ��������
author:	chal
update:	2013-07-01
module by chal
]]--

--------------------------------------------------------------------------
--include:
local tableremove = table.remove
local mathrandom = math.random
local tableinsert = table.insert
local setmetatable = setmetatable
local look = look
--------------------------------------------------------------------------
-- module:
module(...)

local random_norepeat  =
{
	--intable �б�
	new = function( self, intable, num )
		local o = { intable=intable, index = {} }

		setmetatable(o, self )
		self.__index = self

		for i=1, #intable do
			o.index[i] = i
		end

		--���ɾ��������Ŀ
		if num then
			for i=1, #intable-num do
				tableremove( o.index, mathrandom(#o.index) )
			end
		end

		return o
	end,

	--��ȡ����ɾ��
	get = function( self )
		if #self.index>0 then
			local i = self.index[ mathrandom(1, #self.index ) ]
			return self.intable[ i ], i
		end
	end,

	--��ȡһ����ɾ��
	pop = function( self)
		if #self.index>0 then
			local ii = mathrandom(1, #self.index )
			local i = self.index[ ii ]
			tableremove( self.index, ii )
			return self.intable[ i ],i
		end
	end,
}

local function IN_ODDS_N( ODDS)
	local odds = ODDS
	local function odds_func( p)
		return p > (mathrandom()*odds)
	end
	return odds_func 
end

local function _table_rand(rateTable)
	local rnd = rint(100*mathrandom())+1
	local total = 0
	for k,v in ipairs(rateTable) do
		total = total + v
		if rnd < total then
			return k
		end
	end
	return 0	
end

--�õ����ظ������===������õ��������������1��10--{1��10}��
--has������/����� maxn��ȷ���õ���has���Ԫ�ظ��� pool����Χ
local function _Get_num( has , maxn , pool )
	if has==nil then has={} end
	local _min 	= pool[1]
	local _max 	= pool[2]
	local m		= 1
	for q = _min , _max do
		pool[m]=q
		m=m+1
	end
	
	local num = maxn
	if num>#pool then
		num=#pool
	end
	
	local a = random_norepeat:new(pool)
	local startpos = #has
	for i = 1,num do
		local mark=0
		local get = a:pop()
		if startpos > 0 then
			for i = 1 , startpos do
				if has[i] == get then
					mark=1
					break
				end
			end
		end
		if mark==0 then
			tableinsert(has,get)
		end
		if #has == maxn then return has end
	end
	look('random_num_error')
end

--------------------------------------------------------------------------
-- interface:

IN_ODDS 	= IN_ODDS_N(100)	-- ����Ƿ�����һ��100���ڵĸ���
table_rand	= _table_rand		-- ����һ��table�͸��ʱ��λ��
Get_num 	= _Get_num			-- �õ����ظ������