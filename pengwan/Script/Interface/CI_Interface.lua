--[[
	C函数接口说明文档
]]--

--[[
	获取玩家基本信息: 
		CI_GetPlayerBaseData(sid, type) 
			@type: 	[nil]：排位赛 { 名字，等级，vip，外型，武器，头像 }
					[1] 偷袭 { 名字，等级，vip，帮会id，战斗力，头像 } --通缉度/庄园外观
					[2] 玩家基本数据 { 名字，等级，vip，外型，武器，帮会id，战斗力，头像 }	
]]--

--[[
	获取玩家战斗托管数据（C++部分）():
		 CI_GetPlayerTSData(sid)
		{
			{ 名字，等级，vip，外型，武器，帮会id，战斗力，头像}，
			{13个二级属性}，
			{{id}，{level}}，
		}
		imageID 外型
		headID 武器
		byBossType 头像 
]]--

--[[
	创建场景: 
		CI_CreateRegion(sid, regionType, Manual) 
			@regionType： [0] 普通场景 [-1] 普通动态场景 [> 0] 副本场景GID
			@Manual： [0] 自动管理场景删除 [1] 手动管理场景删除			
]]--

--[[
	删除场景: 
		CI_DeleteDRegion(gid,removePlayer,desRegionID,desX,desY) 
			@gid：场景GID
			@removePlayer：是否移除玩家,
			@desRegionID：目标场景id
			@desX：目标x
			@desY：目标y
			
			@return：[-1] 找不到该动态场景  [-2] 场景标记为不可手动删除 
					 [-3] 场景玩家数不为0	[-4] 副本流程创建的动态场景不能手动移出玩家 		
]]--

--[[
  函数名称：CI_SetPlayerIcon
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


孙超 11:55:35
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

 CI_SetPlayerIcon 成功返回true 错误返回nil
CI_GetPlayerIcon 错误返回-1
]]--

--[[
CreateGroundItem(场景id 场景gid 道具id 道具个数 坐标x 坐标y icount 保护gid 孔数 强化等级)
icount: 累加值
]]--