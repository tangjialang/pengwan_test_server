--[[
file: bits.lua
desc: Î»²Ù×÷¿â
autor: csj
]]--

-----------------------------------------------------------------
-- include:

local type,pairs,ipairs = type,pairs,ipairs
local tostring = tostring
local rint = rint
local look = look


bits = {}

setfenv(1, bits)

local maxbits = 32
	
function set(src,begs,ends,num)
	if src == nil or begs == nil or ends == nil or num == nil then return end	
	if begs <= 0 or ends > maxbits then return end
	if begs > ends then return end
	if num > 2 ^(ends - begs +1) - 1 then
		look('bits.set num error',1)
		return 
	end
	local pre_v = rint(src / (2 ^ ends)) * (2 ^ ends)
	local end_v = 0
	begs = begs - 1
	if begs > 0 then
		end_v = src % (2 ^ begs) 
	end
	local new_v = num * (2 ^ begs)
	
	local dest = pre_v + new_v + end_v
	
	return dest
end

function get(src,begs,ends)
	if begs <= 0 or ends > maxbits then return end
	if begs > ends then return end
	src = rint(src / (2 ^ (begs - 1)))
	local dest = src % (2 ^(ends - begs + 1))
	
	return dest
end

function test(src,bit)
	if bit <= 0 or bit > maxbits then return end
	local bv = get(src,bit,bit)
	return bv == 1
end