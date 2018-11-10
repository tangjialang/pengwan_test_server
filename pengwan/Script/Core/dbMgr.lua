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

-- ����Ѿ����ع��ˣ���ֱ�ӷ��ء�����
if ( dbMgr ~= nil ) then
    return
end

-- ##############################################################################################
-- �������ݱ��������߼�
-- ##############################################################################################

-- Ĭ��һ�������ú�Ԫ���ܱ�2���޸�
local dbTable = { __metatable = "__meta_dbTable" } 

-- ���� ���ݱ���
dbTable.new = function()
    -- Ĭ����ԪΪ������б�������ݣ�
    local nilTable = { _ = { __c = 0, __s = 0 } }
    setmetatable( nilTable, dbTable )
    return nilTable
end

-- ���� Ϊ tostring ������Ϣ�ַ���
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

-- ���� ����ͨ���¡��һ���µ����ݱ�ע�⣬ת���ı��в����зǷ��������� ���� nil function thead ...
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
            v = dbTable.__clone( v, tab, k ) -- ����ط�ֻ�������ӱ����ͣ���Ҫ����ת������
            c = c + 1 + v[''].__c
            s = s + v[''].__s + vksize( nil, k ) + 1 -- ���������Դ��ӱ�����־�����ӱ��˳���־ֻ���Ƕ������ڵ�
        else
            v = dbTable.__clonex( v ) -- �������Ԫ����ֻ����ͨ�Ŀ�¡
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

-- ���� ����ͨ��ת��Ϊ���ݱ� ע�⣬ת���ı��в����зǷ��������� ���� nil function thead ...
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
        elseif ( k ~= '' ) then         -- ��ת����Ԫ����
            dbTable.__convert( v, t, k ) -- ����ط�ֻ�������ӱ����ͣ���Ҫ����ת������
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

-- ���� ��ֵ��ͳ������������ݴ�С
dbTable.__rawset = function ( t, k, v, pv ) 

    -- ���ݱ���ӱ������ֻ�������ݱ�
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
        -- ���������
        if ( v ~= nil ) then 
            if ( isTable ) then 
                c = 1 + v[''].__c 
                s = v[''].__s + vksize( nil, k ) + 1
            else 
                c = 1 
                s = vksize( v, k )
            end
        else
            -- �����ǿ����ݸ�ֵ�����ݵ����
            return
        end
    else
        if ( v ~= nil ) then
			if pv == v then
				-- ����¾�ֵ��ͬ������£���������
				return
			end
            -- �������ݸ���
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
            -- ��������ɾ��
            if ( ttype( pv ) == 5 ) then 
                c = -( 1 + pv[''].__c ) 
                s = -( pv[''].__s + vksize( nil, k ) + 1 )
            else 
                c = -1 
                s = -vksize( pv, k )
            end
        end
    end

    -- �ȼ�����ݱ��ڸ��º�����ݴ�С�Ƿ񳬱�
    local tab = t
    while ( tab ) do
        -- ������ݴ�С�Ƿ�ᱻ��ֵ����
        if ( ( tab.__x ~= nil ) and ( ( tab[''].__s + s ) >= tab.__x ) ) then
			
			local str="dbTable is full limited:"..tostring(tab[''].__kn).."\n"
			Lua_Debug(str)
            error(str)
        end
        tab = tab[''].__p
    end

    -- ����ͳ�����ǰ���ڣ����������ϴ��ݸ��½��
    tab = t
    while ( tab ) do
        tab[''].__c = tab[''].__c + c
        tab[''].__s = tab[''].__s + s
        tab = tab[''].__p
    end

    -- ������õ����ӱ���Ϊ�ӱ����__p������
    if ( isTable ) then
        v[''].__p = t
    end

    -- ����ʵ�ʵ����ݸ���
    rawset( t, k, v )

	-- ͬ���������ݵ��ͻ��ˣ�ֻͬ�����θ��µĲ��֣�����ͻ���û�л�ȡ�����������ݱ������������ȡһ��
	local sync = {}
	local tmp = t
	while tmp ~= nil and tmp[''].__k == nil do
		sync[#sync+1] = tmp[''].__kn
		tmp = tmp[''].__p
	end
	if tmp[''].__k ~= nil then
		-- ע�⣬Ŀǰ����ֻͬ��data.taskData�µ��������ݲŻ�ͬ�����ͻ��ˣ�
		-- �����������£���������ǰ��ȫ���ݸ���
		if #sync >= 2 and sync[#sync] == 'data' and sync[#sync-1] == 'task' then
			--rfalse('******::: sync task 1.0')
			sync.ids = { 1, 0 }
			sync.k = k
			sync.v = v 
			SendLuaMsg( tmp[''].__k, sync, 10 )
		end
	end
end

-- Ԫ���� ���������
dbTable.__newindex = function( t, k, v )
	----rfalse("db.__newindex");
    dbTable.__rawset( t, k, v )
end

-- Ԫ���� �������ݸ���
dbTable.__assign = function( t, k, v )
    dbTable.__rawset( t, k, v, t[k] )
end

-- ##############################################################################################
-- �������ݹ����������߼�
-- ##############################################################################################

-- ���ݱ��������ͨ��ע��Ԫ��ķ�ʽ���޸� dbTable.__index ����Ϊ��
local meta = { __metatable = "__meta_dbTable_mgr" } 

-- Ĭ�����еĿ�ֵ���ʲ�����Ϊ�����ӱ�
-- ��������ʹ���������±���Ϊ����ĳ����ҵ������ӱ����ַ������±���Ϊ���������ӱ�
meta.__index = function ( t, k )
	-- look("db.__index" .. k)
    local tab = nil
    local isLoad = nil
    if ( LoadDBTable ~= nil ) then
        tab = LoadDBTable( k )                      -- ͨ��������ض�Ӧ���ݵı���
        if ( tab == nil ) then                      -- �������Ҳ���ָ�������ݡ����ߴӳ�������ʱ���ݴ��ڴ���
            return nil
        end
        isLoad = true
    else 
        tab = {}
    end

    dbTable.__convert( tab )                        -- ����ͨ��ת��Ϊ���ݱ�
    tab[''].__k = k
    rawset( t, k, tab )
    if isLoad and type(k)=='number' then
        if tab[''].__s > 5080 then
			--��¼�Ա�鿴
			chk_p(k,tab[''].__s)
        end
    end
    return tab
end

-- ��ֱֹ����dbTable������������������
meta.__newindex = function ( t, k, v )
    error( "dbTable is read only table!!!" )
end

-- ��ֹ�޸�dbTable�������еĻ������ݱ��
meta.__assign = function ( t, k, v )
    error( "dbTable is read only table!!!" )
end

-- ��ʼ������������Ϊ֮���Ԫ��
dbMgr = {}

-- �ڽű�ˢ��ǰ��OnScriptClosing����ã�������dbTable������������
function dbMgr.UpdateAll() 
    for k,v in pairs( dbMgr ) do		
        if ( ttype( v ) == 5 ) then			
            SaveDBTable( k )
        end
    end
end

-- ��ʾһ�����������Ϣ
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
