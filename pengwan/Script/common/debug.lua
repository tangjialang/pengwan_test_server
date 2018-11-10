--[[
	file:	debug_interface.lua
	desc:	用于调试的函数接口
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
--c++调试控制,权限高:errorout 0不打印 1打到控制台 2打到文本
--inner:
--服务器初始化，置1，只打印到文本

-- if __debug then
-- 	Rfalse_mark = Rfalse_mark or 6
-- 	Rfalse_lv 	= Rfalse_lv or 2
-- else
	Rfalse_mark = Rfalse_mark or 6
	Rfalse_lv 	= Rfalse_lv or 1
-- end


local Rfalseconf={
	[1]={[6]="打印到文本",[7]="打印到debugview",[2]="打印到控制台"},
	[2]={'打印重要错误','打印重要错误+流程错误','打印重要错误+流程错误+调试信息'},
}

--打印到sever
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
	
	-- 调用 Save 方法进行日志的记录
	Save(Obj, 1)
end

--封装c，脚本调用：
--itype==1重要错误，2流程错误，nil调试信息，【4其他。。。(暂不用)】
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

--c调用，itype2=打印地点：6只打印到文本，7只打印到debugview，2只打印到控制台
--itype3=打印等级：1打印重要错误，2打印重要错误+流程错误，3打印重要错误+流程错误+调试信息
--例:sdebug 2 2
function SI_debugrfalse(itype2,itype3)

	if itype2 ~=2 and itype2 ~=6 and itype2 ~=7 then 
		rfalse( 2 , '打印地点错误:为2,6,7')
		return
	end
	if itype3 ~=1 and itype3 ~=2 and itype3 ~=3 then 
		rfalse( 2 , '打印等级错误:为1,2,3')
		return
	end
	Rfalse_mark=itype2
	Rfalse_lv=itype3
	rfalse( 2 , Rfalseconf[1][itype2])
	rfalse( 2 , Rfalseconf[2][itype3])
end


--统计普通表序列化后大小
function gettablesize(t)
	if type(t)~=type({}) then 
		look('not table',1)
		return 
	end

	local s = 0
    for k,v in pairs( t ) do
        if ( ttype( v ) ~= 5 ) then--非表
            s = s + vksize( v, k )
        elseif ( k ~= '' ) then         -- 不是哑元变量
            local res=gettablesize( v ) -- 子表，继续统计
            s = s + res + vksize( nil, k ) + 1
        end
    end
	return s
end
