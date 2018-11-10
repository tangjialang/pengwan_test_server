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

-- ������������
CreateCityOwner()

--:global check
check_config()

MakeLotconf(1)--��ʼ���齱�б�

Load_DynDrop()--���ض�̬�����

SetLimitstore(1)--���õ��ú�������3���޹���Ʒ

RandPosSys_AvoidRef()	-- ��ʼ���������ϵͳ(�ڲ���ֹˢ��)

init_active_static()

init_active_dynamic()

start_active_timer()	-- �������ʱ��(��̬ʱ�����ñ���Ӫ�)

public_timer()		-- �����ʱ��

boss_serverstart(1) --��boos����δˢ��״̬

init_auto_faction() --������ʼ�������˰��

init_span_server()	-- ��ʼ�������Ϣ

db_get_allspanserver()	-- ��ȡ���п���б�

cc_local_ranks()
----------------------------------------����  ����������  �ָ������ֲ����
Data_Load(1) 
collectgarbage("collect")
collectgarbage("stop")
local result = collectgarbage("setstepmul",260)
local result = collectgarbage("setpause",180)
--����������һ���ڴ����,�������ļ�
--TI_Snapshot(1)

--collectgarbage("restart")
--collectgarbage("step",320)
