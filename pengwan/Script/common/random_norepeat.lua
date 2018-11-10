--[[
file:	random.norepeat.lua
desc:	随机数（包括不重复随机数）
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
	--intable 列表
	new = function( self, intable, num )
		local o = { intable=intable, index = {} }

		setmetatable(o, self )
		self.__index = self

		for i=1, #intable do
			o.index[i] = i
		end

		--随机删除多余项目
		if num then
			for i=1, #intable-num do
				tableremove( o.index, mathrandom(#o.index) )
			end
		end

		return o
	end,

	--获取但不删除
	get = function( self )
		if #self.index>0 then
			local i = self.index[ mathrandom(1, #self.index ) ]
			return self.intable[ i ], i
		end
	end,

	--获取一个并删除
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

--得到不重复随机数===传入表，得到个数，区间表【如1到10--{1，10}】
--has：传入/结果表 maxn：确保得到的has表的元素个数 pool：范围
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

IN_ODDS 	= IN_ODDS_N(100)	-- 检查是否命中一个100以内的概率
table_rand	= _table_rand		-- 命中一个table型概率表的位置
Get_num 	= _Get_num			-- 得到不重复随机数