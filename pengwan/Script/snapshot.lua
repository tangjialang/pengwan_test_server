--[[
author:	chal
update:	2013-10-24
notes: 用于生成lua内存快照
]]--

--local snapshot = require "snapshot"
local common 			= require('Script.common.Log')
local Log 				= common.Log

-- 服务器启动完成或每次sreset后，生成初始快照s_shot
-- 下一次要sreset前，自动进行一次对比（目前只在调试版开启，发布版视外网执行效率而定）
-- 关服前最好能够手动执行一次对比，再关服
-- 任意时间可以手动调用TI_Snapshot()进行一次对比

local s_shot
g_cur_index = g_cur_index or 0
function TI_Snapshot(bcreate)
	if bcreate then
		--创建初始快照
		s_shot = snapshot()	
		look("TI_Snapshot create",1)	
		return
	end

	--获得当前快照
	local e_shot = snapshot()
	
	--保存当前内存快照，用于查错
	local filename = "all_snapshot_"..tostring(g_cur_index)..".txt"	
	Log(filename,e_shot)
	
	--对比并保存差异
	filename = "cmp_snapshot_"..tostring(g_cur_index)..".txt"		
	for k,v in pairs(e_shot) do
		if s_shot[k] == nil then
			Log(filename,"["..tostring(k).."] = "..tostring(v)..".")
		end
	end
	
	g_cur_index = g_cur_index + 1
end
