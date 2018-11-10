--[[
file:	CI_interface_info.lua
desc:	only info for CI_ function
author:	all
update:	2013-7-16

伪语言描述规则：
[1] 函数关键字 ： cifuncinfo(与'function'区别)
[2] a1 ：固定需要传入的参数一
[3] b1 : 按需要传入的可变参数一
[4] @  : 注释
[5] ！ : 需要注意的事项
----------------------------------------
@选定功能需要操作的对象
！脚本需要指定操作对象时，需要保存原对象，操作完成后务必恢复为原对象
cifuncinfo CI_SelectObject(a1,b1,b2) 
	if a1 == 0 then
		@当前玩家
	elseif a1 == 1 then
		b1 = number@玩家GID
		@GID对应的玩家
	elseif a1 == 2 then
		b1 = number@玩家SID
		@SID对应的玩家
	elseif a1 == 3 then
		@当前怪物
	elseif a1 == 4 then
		b1 = number@怪物GID
		b2 = number@静态场景地图id或者动态场景gid or nil@玩家所在场景
		@GID对应的怪物
	elseif a1 == 5 then
		b1 = number@NPCGID
		b2 = number@静态场景地图id或者动态场景gid or nil@玩家所在场景
		@GID对应的NPC
	elseif a1 == 6 then
		b1 = number@怪物或NPC的CID
		b2 = number@静态场景地图id或者动态场景gid or nil@玩家所在场景
		@CID对应的怪物或NPC
	end
	return -101@选择操作对象失败 or -102@对象不符
end
@其他接口需要指定对象时，通用该参数规则，在固定参数后面（如下以"..."表示），用于指定操作对象
----------------------------------------
----------------------------------------
cifuncinfo CI_UpdateNpcData(a1,a2,...)
	if a1 == 1 then
		a2 = {imageId,x,y,clickScript,dir,mType,headID,iconID} 
	elseif a1 == 2 then
		a2 = true@采集 or false@未采集
	end
	return nil@失败 or true@成功
end
----------------------------------------
----------------------------------------
cifuncinfo CI_GetNpcData(a1,...)
	if a1 == 1 then
		return 1@采集 or 0@未采集
	end
end
----------------------------------------
----------------------------------------
cifuncinfo GetMonsterData(a1,...)
	if a1 == 1 then
		return 怪物等级
	elseif a1 == 2 then
		return 怪物ID
	elseif a1 == 3 then
		return 怪物名字
	elseif a1 == 4 then
		return 怪物携带经验
	elseif a1 == 5 then
		return 怪物携带铜钱
	elseif a1 == 6 then
		return 怪物当前血量
	elseif a1 == 7 then
		return 怪物最大血量
	elseif a1 == 8 then
		return 怪物当前坐标x,y
	elseif a1 == 9 then
		return 怪物所属帮会 or nil
	elseif a1 == 23 then
		return 怪物GID,copysceneGID
	elseif a1 == 26 then
		return 怪物所在场景ID
	end
end
----------------------------------------
----------------------------------------
cifuncinfo CI_SetPlayerIcon(a1,a2,a3,a4,...)
功能：设置玩家图标 
参数个数 >=4
参数说明：
arg1：设置类型。
0 - 系统图标
1 - 脚本设置图标（称号：格式由脚本自定，如8位一个称号，则最多支持4个称号）；
2 - 脚本临时图标（用于临时图标显示，同时只存在一个。如最高位表示显示的功能类型，剩余31位表示数值）

arg2：not care when arg1 != 0 

arg3：数值

arg4：是否同步给前台（OnPlayerLogin中调用时不发送前台）

设置玩家vip标识：
CI_SetPlayerIcon（0，0，arg3 ,arg4）
设置战斗力排行称号
CI_SetPlayerIcon（0，1，arg3 ,arg4）

CI_SetPlayerIcon 成功返回true 错误返回nil
CI_GetPlayerIcon 错误返回-1

函数名称：CI_GetPlayerIcon
功能：获得玩家图标 
参数个数 >=2
参数说明：
arg1：类型。
0 - 系统图标
1 - 脚本设置图标（称号）
2 - 脚本临时图标
arg2：not care when arg1 != 0 

获得玩家vip标识：
CI_GetPlayerIcon（0，0）

------------------------------------------------------------
------------------------------------------------------------
cifuncinfo CI_UpdateMonsterData (a1,a2,a3,a4...)
	if a1 == 1 then
		a2 = 怪物配置表
		a3=1为强制更新
	elseif a1 == 2 then
		a2 = 怪物帮派
	elseif a1 == 3 then
		a2 = 怪物技能ID
		a3 = 怪物技能等级
		a4 = 触发次数
	elseif a1 == 4 then
		a2 = 主人sid
	end
end
	1: 更新属性 参数就是怪物配置表
	2: 指定怪物帮派 - factonname
	3：给怪物指定一个临时技能 skillid, count(连续触发次数)
	4: 给怪物指定主人

CI_MoveMonster(x,y,0,3)  移动到x,y, 当第3位为1时移动到出生点,3为当前怪

----------------------------------------
]]--
