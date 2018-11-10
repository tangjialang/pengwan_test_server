--[[
file:	Task_EventConf.lua
desc:	task events define.
author:	李毅
update:	2011-09-23
notes:
新手引导箭头方式 +HighLight
 * @param 面板
		 * @param 内容(如果为xml则加载xml显示)
		 * @param 是否点击消失
		 * @param x坐标(包围特效)
		 * @param y坐标(包围特效)
		 * @param 宽(包围特效)
		 * @param 高(包围特效)
		 * @param 箭头方向
		 * @param 关闭回调方法
		 * @param 要指向的物品ID
		 * @param 是否关闭当前面板
		 * @param 点击后事件
		 * @param 点击后主角说话内容

		 
		 
	新手引导面板形式 showGuide  * 弹出新手引导面板 
		 * @param 物品编号
		 * @param 提示信息
		 * @param 按钮名字	 
		 * @param 点击后事件
		 * @param 如果是动态生成道具，显示指定名称
		 * @param 是否在右下角显示
		 
	飘窗提示面板
		addNewTip
		@param 内容（<a href='event:DDayPanel 2'><u><b><font color='#80f080'>打开</font></b><u></a>）
		@param hightligng参数 同RegStep
	
	
	* 新手引导(强制引导)
		 * @param 面板
		 * @param 内容
		 * @param x坐标(包围特效)
		 * @param y坐标(包围特效)
		 * @param 宽(包围特效)
		 * @param 高(包围特效)
		 * @param 箭头方向
		 * 
		 * */

	newGuide(DMainPanel,"测试用的啊！！！！",495,50,44,63,4)
	newGuide(DMainStatePanel,"测试用的啊2！！！！",129,53,70,23,0)
	closeNewGuide('自动寻路指令')
	
]]
--------------------------------------------------------------------------
--include:
local pairs = pairs
local ipairs = ipairs
local CI_GetPlayerData = CI_GetPlayerData
local new_guide = require('Script.new_guide.fun')
local set_guide = new_guide.set_guide
local CI_AddBuff,CI_DelBuff = CI_AddBuff,CI_DelBuff
--------------------------------------------------------------------------
-- data:

local _call_accept_task = {
}

local _call_submit_task = {
}

--前期加速
_call_accept_task[1001] = function ()
	--CI_AddBuff(351,0,1,false)
end
--37.com称号需求
_call_accept_task[1010] = function ()
	if __plat == 103 then  --37称号
		local sid = CI_GetPlayerData(17)
		if 	SetPlayerTitle(sid,47) == 1 then  --已经有称号
			TipCenter(GetStringMsg(15))
			return 0
		end
		SetShowTitle(sid,{47,0,0,0})
	end
	if __plat == 160 then  --酷我称号
		local sid = CI_GetPlayerData(17)
		if 	SetPlayerTitle(sid,58) == 1 then  --已经有称号
			TipCenter(GetStringMsg(15))
			return 0
		end
		SetShowTitle(sid,{58,0,0,0})
	end
end
--救苏护体验坐骑
_call_accept_task[1054] = function ()
	set_guide(CI_GetPlayerData(17),0,1,1006,112) --体验坐骑
	CI_AddBuff(13,0,1,false)	--加速BUFF
	--set_guide(playerid,0,0) --取消体验坐骑
	--TipMB("坐骑系统开启选项")
	--GiveMounts(CI_GetPlayerData(17))
end
--取消体验坐骑
_call_accept_task[1058] = function ()
	--set_guide(playerid,0,1,1007) --体验坐骑
	set_guide(CI_GetPlayerData(17),0,0) --取消体验坐骑
	GiveMounts(CI_GetPlayerData(17))
	CI_DelBuff(351)
end

--获得怒气打怪
_call_accept_task[1104] = function ()
	local sid = CI_GetPlayerData(17)
	local ret = PI_PayPlayer(4,-300,0,0,'怒气清零',2,sid)
	local ret = PI_PayPlayer(4,300,0,0,'怒气清零',2,sid)
end
--获得怒气打怪
_call_accept_task[1171] = function ()
	local sid = CI_GetPlayerData(17)
	local ret = PI_PayPlayer(4,-300,0,0,'怒气清零',2,sid)
	local ret = PI_PayPlayer(4,300,0,0,'怒气清零',2,sid)
end

--获得第一个家将
_call_accept_task[1115] = function ()
	GiveHeroFirst(CI_GetPlayerData(17))
end
--剧情传送
_call_accept_task[1178] = function ()
	PI_MovePlayer(8,67,135)
end

--铜钱副本
_call_accept_task[1181] = function ()
	PI_MovePlayer(1,61,64)
end

--宝石副本
_call_accept_task[1324] = function ()
	PI_MovePlayer(1,61,64)
end

--经验副本
_call_accept_task[1377] = function ()
	PI_MovePlayer(1,46,86)
end

--护送海美人
_call_accept_task[2027] = function ()
	PI_MovePlayer(1,82,76)
end


--哪咤自杀剧情传送
_call_accept_task[1179] = function ()
	PI_MovePlayer(8,57,58)
end

--开启VIP试用
_call_accept_task[1150] = function ()
	VIP_SetTemp(CI_GetPlayerData(17))
end


--魔家兄弟副本点传送
_call_accept_task[1375] = function ()
	PI_MovePlayer(10,12,13)
end
_call_accept_task[1403] = function ()
	PI_MovePlayer(10,12,13)
end
_call_accept_task[1409] = function ()
	PI_MovePlayer(10,12,13)
end
_call_accept_task[1413] = function ()
	PI_MovePlayer(10,12,13)
end


--接受某主线任务时，自动接受讨伐日常任务
_call_accept_task[1404] = function ()
	-- 判断玩家 今日的讨伐日常接受或完成没有，没有就帮他接
	--任务号4001
	local sid = CI_GetPlayerData(17)
	TS_AcceptTask(sid,4001,0)
	TS_AcceptTask(sid,4950,0)
	
	--增加1次宝石副本次数
	--CheckTimes(sid,TimesTypeTb.CS_Jewel,1,0)		
	
	
end


_call_accept_task[2005] = function ()
	local ret = PI_PayPlayer(4,-300,0,0,'怒气清零',2,CI_GetPlayerData(17))
		local school = CI_GetPlayerData(2)
		if school == 1 then
			CI_SetSkillLevel(1,108,1,12)
		elseif school == 2 then
			CI_SetSkillLevel(1,123,1,12)
		elseif school == 3 then
			CI_SetSkillLevel(1,124,1,12)
		end
		
end

--接受登陆器支线任务
_call_accept_task[1106] = function ()
	--多玩平台没有登陆器支线任务
	--if __plat ~= 102 then
	--	TS_AcceptTask(CI_GetPlayerData(17),3042,0)
	--end
	
end

--完成加入帮会后，帮其接受日常任务
_call_submit_task[3001] = function ()
	--判断玩家 今日的帮会日常接受或完成没有，，没有就帮他接
	--玩家等级 < 40  接受4101 任务， >= 40  接受4106  >= 45 接受 4111任务
	local taskid = 4101 
	local level = CI_GetPlayerData(1)
	if level >= 45 then 
		taskid = 4111
	elseif level >= 40 then 
		taskid = 4106
	end
	TS_AcceptTask(CI_GetPlayerData(17),taskid,0)
end


--完成50级任务后，帮忙接跨服日常
_call_submit_task[1435] = function ()
	local sid = CI_GetPlayerData(17)
	TS_AcceptTask(sid,4900,0)
end
----------------------------------------------------
--interface:

call_accept_task  	= _call_accept_task
call_submit_task	= _call_submit_task

