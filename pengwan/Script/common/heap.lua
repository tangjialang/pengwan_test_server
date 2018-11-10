--[[
file:	heap.lua
desc:	heap 
author:	
update:	2013-07-01
module by chal
]]--

--------------------------------------------------------------------------
--include:
local mathfloor = math.floor
local setmetatable = setmetatable

--------------------------------------------------------------------------
-- module:
module(...)

local _heap = {}

--give a new heap object
function _heap:new( f,maxv )
	local o = { data = {}, last = 1, less_func = f ,smax = maxv }
	setmetatable( o, self)
	self.__index = self

	return o
end

--internal use
function _heap:cmp(a,b)
	if self.less_func then
		return self.less_func(a,b)
	end

	return a<b
end

--internal use
function _heap:__min( a, b)
	local ff = f or self.less_func
	if ff then
		if ff(a, b) then
			return a,1
		else
			return b, 2
		end
	else
		if a<b then
			return a, 1
		else
			return b, 2
		end
	end
end

--insert a element to heap
function _heap:insert( a)
	--upward
	self.data[ self.last ] = a

	local pos = self.last--3
	while pos>1 do
		local parent_pos = mathfloor(pos/2)--[1 3 2]
		if self:cmp( self.data[pos], self.data[ parent_pos ] ) then
			self.data[ pos ], self.data[parent_pos] = self.data[parent_pos], self.data[ pos ]
			pos = parent_pos
		else
			break
		end
	end

	self.last = self.last + 1
	if self.smax then
		while self.last > self.smax do
			self.data[self.last] = nil
			self.last = self.last -1
		end
	end
end

--pop the first(min) one and return it
function _heap:pop()
	-- downward
	local top = self:top()
	if nil==top then
		return
	end

	self.last = self.last - 1
	
	self.data[1] = self.data[ self.last] 
	self.data[ self.last] = nil

	local pos = 1
	local last_pos = self.last/ 2
	while pos<last_pos do
		local p, l, r = self.data[ pos ], self.data[ pos*2 ], self.data[ pos*2 +1 ]
		if nil==r then
			if not self:cmp( p, l ) then
				self.data[ pos ], self.data[ pos*2 ] = l, p
				pos = pos*2
			else
				break
			end
		else
			local m, witch = self:__min( l, r)
			if self:cmp( m, p ) then
				local newpos = pos*2 + witch-1
 				self.data[ pos ], self.data[ newpos ] = m, p
				pos = newpos
			else
				break
			end
		end
	end

	return top
end

function _heap:empty()
	return self.last==1
end

function _heap:top()
	if not self:empty() then
		return self.data[1]
	end
end

function _heap:GetMin()
	if not self:empty() then
		return self.data[self.last]
	end
end

function _heap:size()
	return self.last-1
end

function _heap:clear()
	self.data = {}
	self.last = 1
end

--to arrange a disorder table by heap rule
--unimpletented now
function _heap:adjust( f )

end

--------------------------------------------------------------------------
-- interface:
heap = _heap