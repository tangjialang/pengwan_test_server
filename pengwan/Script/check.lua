--[[
author:	chal
update:	2013-05-33
notes: ����������ִ�е�ͳһ�����ӿ�
]]--

function g_chk(t,...)
	local tool = require('Script.cext.tool')
	if t == 1 then
		tool.chk_g(arg[1],arg[2])
	elseif t == 2 then
		tool.chk_mgr()
	elseif t == 3 then
		tool.chk_p(arg[1],arg[2])
	elseif t == 4 then
		TipAMB("������������������������������������������������")
	end
end

-- function test_local_t()
	-- for j = 1,100 do
		-- local t = {}
		-- for i=1,10000 do
			-- t[i] = i
		-- end
	-- end
	-- return 1
-- end

-- if __debug then
	-- SetEvent(1,100,'test_local_t')
-- end
