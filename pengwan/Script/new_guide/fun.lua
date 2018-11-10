--[[
new_guide
author:	xiao.y
]]--
--------------------------------------------------------------------------
--include:
local CI_OperateMounts = CI_OperateMounts
local CI_SetSkillLevel = CI_SetSkillLevel
local look = look
local math_floor = math.floor
local type = type
local __G = _G
--------------------------------------------------------------------------
--module:
module(...)

--处理 sid 玩家ID t 类型 sign 标识（1 设置 0 取消）arg 参数表
local function _set_guide(sid,t,sign,arg1,arg2)
	if(t == 0)then --设置坐骑
		if(sign == 1)then
			look('proc 1')
			if(arg1~=nil and type(arg1)==type(0))then
				local hid = arg1 --坐骑ID
				local htype = math_floor(hid/1000)
				local hidx = math_floor(hid%1000)
				look('proc 2 ='..htype..','..hidx)
				local MouseChgeConf = __G.MouseChgeConf
				if(MouseChgeConf and MouseChgeConf[htype] and MouseChgeConf[htype][hidx])then
					look('proc 3')
					local SpeedVal = MouseChgeConf.speed
					local item = MouseChgeConf[htype][hidx]
					if(item.speed~=nil)then SpeedVal = SpeedVal + item.speed end
					local result1 = CI_OperateMounts(1,hid,SpeedVal)
					if(result1)then 
						look('result1='..result1)
					else
						look('result1 is null')
					end
					if(arg2 == nil or type(arg2)~=type(0))then arg2 = 112 end
					local result = CI_SetSkillLevel(1,arg2,1,13)
					if(result)then
						look(result)
					else
						look('result is null')
					end
				end
			end
		else
			CI_OperateMounts(2)
			look('--------------------------')
			local result = CI_SetSkillLevel(1,1,0,13)
			if(result)then
				look(result)
			else
				look('result is null')
			end
		end
	end
end
--------------------------------------------------------------------------
-- interface:
set_guide = _set_guide