--[[
	*****Lua systems*****
	Game scripts using lua.
	Copyright(C) 2011 Pengwan.
]]--

local rfalse,DoFile,pairs = rfalse,DoFile,pairs

--[[
	__debug��ʱĿǰ����:
	1: ������ʾ���ӡ
	2: SendLuaMsg����ͳ��ȴ���300ʱ��¼��־
	3: �������Ժ�,�ж�c++��λ���Ա�ɹ��� 
	
]]--

--__plat=101Ϊ360
__debug = true  
__plat 	= __plat or 0 

-- -- sresetǰ�Ƚ���һ�ζԱ�
-- if TI_Snapshot and __debug then
-- 	TI_Snapshot()
-- end

--register dofile function.
function dofile(filename)
	local newstring = filename;
	local ret = DoFile(newstring)
	if (ret == nil) then
		rfalse(2,"error in DoFile!");
	end
	
	if(ret == 0) then
		--rfalse(2,"load "..newstring.." OK!")
	elseif(ret == 1) then
		rfalse(2,"load "..newstring..", Error run!")
	elseif(ret == 2) then
		rfalse(2,"load "..newstring..", Error lua file!")
	elseif(ret == 3) then
		rfalse(2,"load "..newstring..", Error syntax!" )
	elseif(ret == 4) then
		rfalse(2,"load "..newstring..", Error lua memory!")
	elseif(ret == 5) then
		rfalse(2,"load "..newstring..", Error user error error!")
	else
		rfalse(2,"load "..newstring.." don't known!!")
	end  
end

local ro = {
	__newindex = function(t,k,v) 
		look('read only:' .. tostring(k) '__'.. tostring(v),1) 
	end
}

local eq = {
	__assign = function(t,k,v)
		look('__assign:' .. tostring(k).. '__'.. tostring(v),1)
	end
}

local rw = {}

-- ֻ����
function readonly(t)
	setmetatable(t,ro)
	return t
end
-- ��д��
function readwrite(t)
	rw[#rw+1] = t
	return t
end
-- ���ܸ���ֵ
function noassign(t)
	setmetatable(t,eq)
	return t
end

function setplat(plat)
	__plat = plat or 0
end

local function module_reset()
	for _name,v in pairs(package.loaded) do
		package.loaded[_name] = nil
	end
end

module_reset()

--load all script files.
require('Script.common') --����ͨ��ģ���

local common 			= require('Script.common.Log')
Log 				= common.Log ---ȫ��,��Ҫ�޸�

local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond
__Ver	= GetTimeToSecond(2014,8,8,10,00,00) 

dofile("Core\\include.lua") --���ݹ���ģ�� 
dofile("msgHandler\\include.lua") --��Ϣ������ģ�� ���� ����
require('Script.cext') --��Ϸͨ�ù�����չģ�� ���� ����
dofile("TimesMgr\\include.lua") --���������� ���� ����
dofile("world\\include.lua") --���繦��ģ��(�������ݽӿں�ѭ��) ���� ����
dofile("NPC\\include.lua") --NPCģ�� ����
dofile("Monster\\Include.lua") --����ģ�� ����
dofile("Story\\init.lua") --���¾���ģ�� ����
dofile("Task\\include.lua") --����ģ�� ����
dofile("Region\\include.lua") --���򳡾�ģ�� ����
dofile("VIP\\include.lua") --VIPģ�� ����
dofile("Player\\include.lua") --���ģ�� ����
dofile("store\\include.lua") --�̵�ģ�� ����
dofile("Item\\Include.lua") --��Ŀģ�� ����
dofile("Hero\\Include.lua") --Ӣ��ģ�� ����
dofile("Trusteeship\\include.lua") --�й� �һ�ģ�� ����
dofile("sctx\\include.lua") --��ħ¼ϵͳģ�� ����
dofile("CopyScene\\include.lua") --����ģ�� ����
dofile("Faction\\include.lua") --����ģ�� ����
dofile("Mounts\\include.lua") --����齱��ģ�� ����
require('Script.achieve') --�ɾͻ�Ծ ����
require("Script.active")		-- �ģ�� ����
dofile("ShenBing\\include.lua") -- ��� ����
dofile("yinyang\\include.lua") --������ ����
dofile("Equip\\include.lua") --װ�� ����
dofile("Manor\\include.lua") --ׯ԰ ����
dofile("lottery\\include.lua") --����ת�̵ȳ齱� ����
dofile("Marry\\include.lua") --���ϵͳ ����
require('Script.new_guide') --������ʱ����� ����
require("Script.card") --����ϵͳ ����
require('Script.scorelist') --�÷�ϵͳ ����
require('Script.gmserver') --����ϵͳ ����
require('Script.ShenQi') --���� ����
dofile("span_server\\include.lua") --���� ����
dofile("span_local\\include.lua") --��� ����
dofile("chatserver\\include.lua") --���칦�ܴ��� ����
dofile("yuanshen\\include.lua") --Ԫ�� ����
require("Script.wuzhuang") --��װ ����
require("Script.shenshu")   --�������� 
require("Script.qizhenge")   --����� ����
require("Script.fabao")     --�������� ����
require("Script.bsmz")	--��ʯ���� ����
dofile("snapshot.lua") --����
dofile('gm_cmd.lua') --gmָ��
dofile("check.lua") --���
dofile("ServerStart.lua") --��������ʼ
rfalse(2,"load main.lua OK!")