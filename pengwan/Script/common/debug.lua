--[[
	file:	debug_interface.lua
	desc:	���ڵ��Եĺ����ӿ�
	author:	
	update:	2013-05-31
]]--

--------------------------------------------------------------------------
--include:
local rfalse = rfalse
local type,tostring,pairs = type,tostring,pairs
local vksize = jex.vksize
local ttype=jex.ttype
--------------------------------------------------------------------------
--c++���Կ���,Ȩ�޸�:errorout 0����ӡ 1�򵽿���̨ 2���ı�
--inner:
--��������ʼ������1��ֻ��ӡ���ı�

-- if __debug then
-- 	Rfalse_mark = Rfalse_mark or 6
-- 	Rfalse_lv 	= Rfalse_lv or 2
-- else
	Rfalse_mark = Rfalse_mark or 6
	Rfalse_lv 	= Rfalse_lv or 1
-- end


local Rfalseconf={
	[1]={[6]="��ӡ���ı�",[7]="��ӡ��debugview",[2]="��ӡ������̨"},
	[2]={'��ӡ��Ҫ����','��ӡ��Ҫ����+���̴���','��ӡ��Ҫ����+���̴���+������Ϣ'},
}

--��ӡ��sever
local function rfalse_up(site,Obj)
	
	local function Save(Obj, Level)
		local Blank = ""
			for i = 1, Level do
				Blank = Blank .. "   "
			end
		if type(Obj) == "number" or type(Obj) == "string" then

			rfalse(site,Blank.."   "..Obj)
		elseif type(Obj) == type({}) then
			
			rfalse(site,Blank.."{")
			for k,v in pairs(Obj) do
				if tostring(k) ~= "" and v ~= Obj then
					rfalse(site,Blank.. " [".. tostring(k).. "] = ")
					Save(v, Level + 1)
					--rfalse("\n")
				end
			end
			rfalse(site,Blank.. "}")
		else
			rfalse(site,Blank..'valve=='..tostring(Obj))
		end
	end
	
	-- ���� Save ����������־�ļ�¼
	Save(Obj, 1)
end

--��װc���ű����ã�
--itype==1��Ҫ����2���̴���nil������Ϣ����4����������(�ݲ���)��
local function _look(obj,itype)
	--rfalse(2,debug.traceback())

	if itype==nil then 
		itype=3
	end
	
	if itype <=Rfalse_lv then
		rfalse_up( Rfalse_mark , obj)
		if itype==1 then 
			rfalse_up( 6 , debug.traceback())
		end
		--rfalse_up( 2 , debug.traceback())
	end
end

--------------------------------------------------------------------------
--interface:
look = _look

--c���ã�itype2=��ӡ�ص㣺6ֻ��ӡ���ı���7ֻ��ӡ��debugview��2ֻ��ӡ������̨
--itype3=��ӡ�ȼ���1��ӡ��Ҫ����2��ӡ��Ҫ����+���̴���3��ӡ��Ҫ����+���̴���+������Ϣ
--��:sdebug 2 2
function SI_debugrfalse(itype2,itype3)

	if itype2 ~=2 and itype2 ~=6 and itype2 ~=7 then 
		rfalse( 2 , '��ӡ�ص����:Ϊ2,6,7')
		return
	end
	if itype3 ~=1 and itype3 ~=2 and itype3 ~=3 then 
		rfalse( 2 , '��ӡ�ȼ�����:Ϊ1,2,3')
		return
	end
	Rfalse_mark=itype2
	Rfalse_lv=itype3
	rfalse( 2 , Rfalseconf[1][itype2])
	rfalse( 2 , Rfalseconf[2][itype3])
end


--ͳ����ͨ�����л����С
function gettablesize(t)
	if type(t)~=type({}) then 
		look('not table',1)
		return 
	end

	local s = 0
    for k,v in pairs( t ) do
        if ( ttype( v ) ~= 5 ) then--�Ǳ�
            s = s + vksize( v, k )
        elseif ( k ~= '' ) then         -- ������Ԫ����
            local res=gettablesize( v ) -- �ӱ�����ͳ��
            s = s + res + vksize( nil, k ) + 1
        end
    end
	return s
end
