--[[
file:	stdExt.lua
desc:	lua��׼����չ��table/string��
author:	
update:	2013-07-01
module by chal
]]--

--------------------------------------------------------------------------
--include:
local type		= type
local pairs 	= pairs
local ipairs 	= ipairs
local table		= table
local string 	= string
local tostring 	= tostring
local setfenv	= setfenv
local mathmin 	= math.min
local _TP_TABLE = type{}
local look=look

--------------------------------------------------------------------------
--module:

-------------- ��׼��table��չ
setfenv(1,table)
--desc:	��dataѹ��t��β��
function push(t, data, maxNum)
	if maxNum == nil or #t < maxNum then
		t[#t+ 1] = data
	else
		for i = 1, #t - 1 do
			t[i] = t[i + 1]
		end
		t[maxNum] = data
	end
	return t
end

--desc:		�������Ƿ���keys��,����з��� t.a.b.c.d,���߷���nil
function has_keys( t, keys)
	if type(t)==_TP_TABLE then	
		if type(keys)==_TP_TABLE then
			local tb = t
			for k,v in pairs(keys) do
				if type(t)==_TP_TABLE and tb[v]~=nil then
					tb = tb[v]
				else
					return nil
				end
			end
			return tb
		else
			return t[keys]
		end
	else
		return nil
	end
end

--	desc:	���ӱ�,��t2������Ԫ����ӵ�t1β��
function cat(t1, t2)
	if type(t1)==_TP_TABLE then
		if type(t2) ==_TP_TABLE then
			for k,v in pairs(t2) do
				push(t1, v)
			end
		elseif type(t2)~=type(nil) then
			push(t1, t2)
		end
	end
	return t1
end

--	desc:	���copyһ��table
--	param:	t	ģ���
--	return:	t��һ������,��һ���µ�ʵ��
function copy(t)
	if type(t)~=_TP_TABLE then
		return nil
	end
	
	local newtable={}
	for k,v in pairs(t) do
		if type(v)==_TP_TABLE then
			newtable[k] = copy(v)
		else
			newtable[k] = v			
		end
	end
	
	return newtable
end

--	desc:	���table�Ƿ���Ϊ��
function empty( tab )
	for k,v in pairs( tab ) do
		return false
	end
	return true
end

-- desc:	ð������,��������ͬtable.sort
function bublesort( t, f )
	for i = 1,#t do
		for j = i+1, #t do
			local doswap
			if f then
				doswap = not f( t[i], t[j] )
			else
				doswap = t[i] > t[j]							
			end

			if doswap then
				local temp = t[i]
				t[i] = t[j]
				t[j] = temp
			end
		end
	end
	return t
end

--��t2��ϲ���t��
function merge( t, t2)
	if type(t)~=_TP_TABLE then
		return t
	end
	
	for k, v in pairs(t2) do
		t[k] = v
	end
	return t
end

--[[
	��λindex�ڱ�t�е�λ�� (�����и�����)
	ע�⣺�ҵ���t�ֲ�С��index��������
	����nil����ʧ��
	flags: 
		[nil] (С�ڱ����С���� or ���ڱ��������� ����nil)
		[0] (С�ڱ����С���� ������С����; ���ڱ��������� ����nil) 
		[1] (���ڱ��������� �����������; С�ڱ����С���� ����nil) 
		[2] (С�ڱ����С���� ������С����) && (���ڱ��������� �����������)
	��Ϊ��һ�������������һ��Ҫ����ʹ�ã�����
]]--
function locate(t, index, flags)
	if index == nil or type(t)~=_TP_TABLE then
		return
	end
	local lower = nil
	for k, v in pairs(t) do
		if type(k) == type(0) then
			if k >= (lower or 0) and k <= index then
				lower = k
			end
		end
	end
	if flags == nil then
		if index < minn(t) then
			lower = nil
		end
		if index > maxn(t) then
			lower = nil
		end
	elseif flags == 0 then
		if index < minn(t) then
			lower = minn(t)
		end
		if index > maxn(t) then
			lower = nil
		end
	elseif flags == 1 then
		if index > maxn(t) then
			lower = maxn(t)
		end
		if index < minn(t) then
			lower = nil
		end
	elseif flags == 2 then
		if index < minn(t) then
			lower = minn(t)
		end
		if index > maxn(t) then
			lower = maxn(t)
		end
	end	
	return lower
end

-- ȡ�����С����
function minn(t)
	if type(t) ~= _TP_TABLE then
		return
	end
	local minx
	for k, v in pairs(t) do
		if type(k) == type(0) then
			minx = minx or k
			minx = mathmin(minx,k)
		end
	end
	return minx or 0
end

-------------- ��׼��string��չ
setfenv(1,string)

--	�ַ����ָ� ֧������
--	param:	s	����ֵ�string	
--			p	�ָ���(������������ʽ)
--	return: {}��ֳ��������б�
function gsplit(s, p)
	local init = 1
	local ret = {}

	repeat
		--look('string��չgsplitѭ��',1)
		local bpos, epos, cap = find( s, p, init)
		if nil ~= bpos then
			if bpos~=init then
				local preP = sub(s, init, bpos-1)
				table.push( ret, preP)
			end

			if cap then
				table.push( ret, cap)
			end
			init = epos+1
		elseif len(s)>=init then
			table.push( ret, sub(s,init) )
		end
	until nil==bpos

	return ret
end

	--desc: s�Ƿ���b��ʼ
function begin_with(s, b)
	return b==sub(s, 1, len(b) )
end

--desc: s�Ƿ���e��β
function end_with(s, b)
	return b==sub(s, len(s)- len(b) +1)
end

function format_ex(str,arg)
	if str == nil then return "" end
	if type(str) ~= type("") then
		error("erro param")
		return
	end	
	local msg = tostring(str)
	if arg~=nil then
		if type(arg) == type({}) and #arg > 0 then
			for i=1,#arg do
				msg = gsub(msg,"#"..i, tostring(arg[i]))
			end
		else
			msg = gsub(msg,"#1", tostring(arg))
		end
	end	
	return msg
end

-- ���ַ����ӿ�ʼ��ch���ַ����滻Ϊre
-- ���ı�Դ�ַ���
function replace_ex(source,ch,re)
	local cbegin,cend = find(source,ch)
	if cbegin == nil or cend == nil then
		return source
	end

	local msg = tostring(source)
	local sub = gsub(msg,1,cend)
	msg = gsub(msg,sub,re)
	return msg
end