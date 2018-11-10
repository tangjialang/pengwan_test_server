--[[
file:	ServerStart.lua
desc:	all function calls when server starts.
author:	chal
update:	2011-12-05
]]--

local DynDrop=DynDropTable
local Load_DynDrop=DynDrop.Load_DynDrop

local tool = require('Script.cext.tool')
local check_config = tool.check_config
local rand_mgr_m = require('Script.active.random_pos_manager')
local RandPosSys_AvoidRef = rand_mgr_m.RandPosSys_AvoidRef
local time_proc_m = require('Script.active.time_proc')
local init_active_static = time_proc_m.init_active_static
local init_active_dynamic = time_proc_m.init_active_dynamic
local start_active_timer = time_proc_m.start_active_timer
local boss_active_m = require('Script.active.boss_active')
local boss_serverstart = boss_active_m.boss_serverstart
local public_m = require('Script.gmserver.public')
local public_timer = public_m.public_timer
local shenshu = require('Script.shenshu.jysh_fun')
local Data_Load = shenshu.Data_Load

-- init random seed.
math.randomseed( os.time() )

--:update world level.
SI_UpdateWorldLevel()
--:init task link list.
taskid_check()

--:create region
GI_CreateMap()
InitMapEvent()

--:init npc.
InitTaskNpc()

-- 创建城主雕像
CreateCityOwner()

--:global check
check_config()

MakeLotconf(1)--初始化抽奖列表

Load_DynDrop()--加载动态掉落表

SetLimitstore(1)--重置调用函数生成3个限购商品

RandPosSys_AvoidRef()	-- 初始化随机坐标系统(内部防止刷新)

init_active_static()

init_active_dynamic()

start_active_timer()	-- 启动活动计时器(静态时间配置表、运营活动)

public_timer()		-- 公告计时器

boss_serverstart(1) --各boos处于未刷新状态

init_auto_faction() --开服初始化机器人帮会

init_span_server()	-- 初始化跨服信息

db_get_allspanserver()	-- 获取所有跨服列表

cc_local_ranks()
----------------------------------------神树  服务器启动  恢复玩家种植的树
Data_Load(1) 
collectgarbage("collect")
collectgarbage("stop")
local result = collectgarbage("setstepmul",260)
local result = collectgarbage("setpause",180)
--开服先生成一次内存快照,并保存文件
--TI_Snapshot(1)

--collectgarbage("restart")
--collectgarbage("step",320)
