local setmetatable,type,tostring,pairs,error,rawset = setmetatable,type,tostring,pairs,error,rawset
local topointer,ttype,vksize = jex.topointer,jex.ttype,jex.vksize
local common 		= require('Script.common.Log')
local Lua_Debug 	= common.Lua_Debug
local tool 			= require('Script.cext.tool')
local chk_p			= tool.chk_p
local SaveDBTable,SaveDBTable	= SaveDBTable,SaveDBTable
local look			= look

function OnScriptClosing()
    dbMgr.UpdateAll()
end

-- 如果已经加载过了，则直接返回。。。
if ( dbMgr ~= nil ) then
    return
end

-- ##############################################################################################
-- 创建数据表自身部分逻辑
-- ##############################################################################################

-- 默认一旦被设置后元表不能被2次修改
local dbTable = { __metatable = "__meta_dbTable" } 

-- 方法 数据表构造
dbTable.new = function()
    -- 默认哑元为不会进行保存的数据！
    local nilTable = { _ = { __c = 0, __s = 0 } }
    setmetatable( nilTable, dbTable )
    return nilTable
end

-- 方法 为 tostring 构造信息字符串
dbTable.__tostring = function ( t )
    return "[" .. tostring( t[''].__kn ) .. " " .. topointer( t ) .. "] __c = " .. t[''].__c .. " __s = " .. 
        t[''].__s .. ( t[''].__p == nil and " __k = " .. t[''].__k or " __p = " .. topointer( t[''].__p ) )
end

dbTable.__clonex = function ( t ) 
    local tab = {}
    for k,v in pairs( t ) do
        if ( ttype( v ) == 5 ) then 
            v = dbTable.__clonex( v )
        end
        tab[k] = v
    end
    return tab
end

-- 方法 从普通表克隆出一个新的数据表！注意，转换的表中不能有非法数据类型 比如 nil function thead ...
dbTable.__clone = function ( t, p, keyname ) 
    local tx = t['']
    if ( tx and ( tx.__c ~= nil or tx.__s ~= nil or tx.__p ~= nil ) ) then
        error( "tab already have __c or __s or __p, conversion interrupted" )
    end

    local tab = {}
    local c = 0
    local s = 0
    for k,v in pairs( t ) do
        if ( ttype( v ) ~= 5 ) then 
            c = c + 1
            s = s + vksize( v, k )
        elseif ( k ~= '' ) then
            v = dbTable.__clone( v, tab, k ) -- 这个地方只可能是子表类型，需要继续转。。。
            c = c + 1 + v[''].__c
            s = s + v[''].__s + vksize( nil, k ) + 1 -- 引导符中自带子表进入标志，但子表退出标志只能是独立存在的
        else
            v = dbTable.__clonex( v ) -- 如果是哑元，则只做普通的克隆
        end
        tab[k] = v
    end

    tab[''] = { __c = c, __s = s }
    if ( p ~= nil ) then
        tab[''].__p = p
    end

    if ( keyname ~= nil ) then
        tab[''].__kn = keyname
    end

    setmetatable( tab, dbTable )
    return tab
end

-- 方法 将普通表转换为数据表！ 注意，转换的表中不能有非法数据类型 比如 nil function thead ...
dbTable.__convert = function ( t, p, keyname ) 
    local tx = t['']
    if ( tx and ( tx.__c ~= nil or tx.__s ~= nil or tx.__p ~= nil ) ) then
        error( "tab already have __c or __s or __p, conversion interrupted" )
    end

    local c = 0
    local s = 0
    for k,v in pairs( t ) do
        if ( ttype( v ) ~= 5 ) then
            c = c + 1
            s = s + vksize( v, k )
        elseif ( k ~= '' ) then         -- 不转换哑元变量
            dbTable.__convert( v, t, k ) -- 这个地方只可能是子表类型，需要继续转。。。
            c = c + 1 + v[''].__c
            s = s + v[''].__s + vksize( nil, k ) + 1
        end
    end

    if ( tx == nil ) then
        t[''] = { __c = c, __s = s }
    else
        tx.__c = c
        tx.__s = s
    end

    if ( p ~= nil ) then
        t[''].__p = p
    end

    if ( keyname ~= nil ) then
        t[''].__kn = keyname
    end

    setmetatable( t, dbTable )
end

-- 方法 赋值并统计数据项和数据大小
dbTable.__rawset = function ( t, k, v, pv ) 

    -- 数据表的子表的类型只能是数据表
    local isTable = ( ttype( v ) == 5 )
    if ( isTable and ( getmetatable(v) ~= "__meta_dbTable" ) ) then 
        if ( getmetatable(v) == nil ) then 
            v = dbTable.__clone( v, nil, k ) 
        else
            error( "sub table can not convert to dbTable" ) 
        end
    end

    local c = 0;
    local s = 0;
    if ( pv == nil ) then 
        -- 新数据添加
        if ( v ~= nil ) then 
            if ( isTable ) then 
                c = 1 + v[''].__c 
                s = v[''].__s + vksize( nil, k ) + 1
            else 
                c = 1 
                s = vksize( v, k )
            end
        else
            -- 不考虑空数据赋值空数据的情况
            return
        end
    else
        if ( v ~= nil ) then
			if pv == v then
				-- 如果新旧值相同的情况下，不做更新
				return
			end
            -- 现有数据更替
            if ( isTable ) then 
                c = v[''].__c 
                s = v[''].__s + 1
            else
                s = vksize( v )
            end
            if ( ttype( pv ) == 5 ) then 
                c = c - pv[''].__c 
                s = s - pv[''].__s - 1
            else
                s = s - vksize( pv )
            end
        else
            -- 现有数据删除
            if ( ttype( pv ) == 5 ) then 
                c = -( 1 + pv[''].__c ) 
                s = -( pv[''].__s + vksize( nil, k ) + 1 )
            else 
                c = -1 
                s = -vksize( pv, k )
            end
        end
    end

    -- 先检测数据表在更新后的数据大小是否超标
    local tab = t
    while ( tab ) do
        -- 检测数据大小是否会被阈值限制
        if ( ( tab.__x ~= nil ) and ( ( tab[''].__s + s ) >= tab.__x ) ) then
			
			local str="dbTable is full limited:"..tostring(tab[''].__kn).."\n"
			Lua_Debug(str)
            error(str)
        end
        tab = tab[''].__p
    end

    -- 更新统计项到当前表内，并尝试向上传递更新结果
    tab = t
    while ( tab ) do
        tab[''].__c = tab[''].__c + c
        tab[''].__s = tab[''].__s + s
        tab = tab[''].__p
    end

    -- 如果设置的是子表，则为子表添加__p父表项
    if ( isTable ) then
        v[''].__p = t
    end

    -- 进行实际的数据更新
    rawset( t, k, v )

	-- 同步更新内容到客户端，只同步本次更新的部分，如果客户端没有获取过完整的数据表，则重新请求获取一次
	local sync = {}
	local tmp = t
	while tmp ~= nil and tmp[''].__k == nil do
		sync[#sync+1] = tmp[''].__kn
		tmp = tmp[''].__p
	end
	if tmp[''].__k ~= nil then
		-- 注意，目前限制只同步data.taskData下的所有数据才会同步到客户端！
		-- 这是增量更新，而不是以前的全数据更新
		if #sync >= 2 and sync[#sync] == 'data' and sync[#sync-1] == 'task' then
			--rfalse('******::: sync task 1.0')
			sync.ids = { 1, 0 }
			sync.k = k
			sync.v = v 
			SendLuaMsg( tmp[''].__k, sync, 10 )
		end
	end
end

-- 元操作 新索引添加
dbTable.__newindex = function( t, k, v )
	----rfalse("db.__newindex");
    dbTable.__rawset( t, k, v )
end

-- 元操作 现有数据更替
dbTable.__assign = function( t, k, v )
    dbTable.__rawset( t, k, v, t[k] )
end

-- ##############################################################################################
-- 创建数据管理器部分逻辑
-- ##############################################################################################

-- 数据表管理器，通过注册元表的方式，修改 dbTable.__index 的行为！
local meta = { __metatable = "__meta_dbTable_mgr" } 

-- 默认所有的空值访问操作均为加载子表！
-- 我们这里使用数字型下标作为具体某个玩家的数据子表，而字符串型下标作为定制数据子表
meta.__index = function ( t, k )
	-- look("db.__index" .. k)
    local tab = nil
    local isLoad = nil
    if ( LoadDBTable ~= nil ) then
        tab = LoadDBTable( k )                      -- 通过程序加载对应数据的表项
        if ( tab == nil ) then                      -- 可能是找不到指定的数据、或者从程序载入时数据存在错误
            return nil
        end
        isLoad = true
    else 
        tab = {}
    end

    dbTable.__convert( tab )                        -- 将普通表转换为数据表
    tab[''].__k = k
    rawset( t, k, tab )
    if isLoad and type(k)=='number' then
        if tab[''].__s > 5080 then
			--记录以便查看
			chk_p(k,tab[''].__s)
        end
    end
    return tab
end

-- 禁止直接向dbTable管理器中添加新数据项！
meta.__newindex = function ( t, k, v )
    error( "dbTable is read only table!!!" )
end

-- 禁止修改dbTable管理器中的基础数据表项！
meta.__assign = function ( t, k, v )
    error( "dbTable is read only table!!!" )
end

-- 初始化管理器，并为之添加元表！
dbMgr = {}

-- 在脚本刷新前在OnScriptClosing里调用，将所有dbTable保存至缓存中
function dbMgr.UpdateAll() 
    for k,v in pairs( dbMgr ) do		
        if ( ttype( v ) == 5 ) then			
            SaveDBTable( k )
        end
    end
end

-- 显示一个表的所有信息
function dbMgr.ShowTable( tab, sop, path, seeall, level ) 
    if ( path == nil ) then 
		path = '' 
		sop( "#self : " .. tostring( tab ) )
	end
	
	if level ~= nil then
		if level == 0 then
			return
		end
	end
	
    local isEmpty = true
    if nil==tab then
        look( debug.traceback() )
        return
    end
    
    for k,v in pairs( tab ) do
        if ( seeall or ( k ~= '' ) ) then
            sop( path .. tostring( k ) .. " = ".. tostring( v ) )
            isEmpty = false
            if ( ttype( v ) == 5 ) then
                dbMgr.ShowTable( v, sop, path .. "  ", seeall, level and level - 1 or nil ) 
            end
        end
    end
    if ( isEmpty ) then
       sop( path .. topointer( tab ) .. " table is empty" )
    end
end

setmetatable( dbMgr, meta )
