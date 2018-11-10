--[[
file:	DR_Conf.lua
desc:	Dynamic region conf.
author:	chal
update:	2011-12-05
refix: done by chal
]]--

--[[
	配置示例:
	activename1 = {
		actTimer = 30 * 60,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = cTimer+[60,5*60]		-- 活动结束后数据清理计时器(如果有cTimer必须配置在cTimer+[60,5*60]这个区间)
		partRM = 1 or {60,50},			-- 房间控制参数(非时间类活动不支持这个参数)：[1] 场景最大人数 [2] 场景分房阀值
		enterRM = {160,150},			-- 房间进入人数上限(不能跟partRM同时出现)
		dataType = 10,					-- [nil] 没有数据存储 [10]活动数据(data[regionGID]) [100]玩家数据(player[sid])
		NoClearP = 1,					-- [nil] 不用处理 [1] ** 需要手动调用清理数据clear_mydata **
		-- 场景配置
		[1] = {  --降魔录
			tMapID = 1003,				-- 地图ID
			EnterPos = {18,23},			-- 进入坐标(支持多坐标随机)
			BackPos = {1,18,23},		-- 退出坐标(如果不配置此参数则退出到进入之前的坐标)
			DelPos = {101,16,21}		-- 场景删除退出点
			bManual = 1,				-- 是否手动删除动态场景(*必须配置此参数) [1] 手动删除 [0] 自动删除
			cTimer = 10 * 60,			-- 场景倒计时(对于时间类活动有特殊要求，见clrTimer说明)
			HistoryMax = 1,				-- 是否记录历史最高场景人数(需要记录则dataType至少为记录活动数据)
			npc = {},					-- NPC id列表
			Monster = {},				-- 怪物配置表
			traps={{x,y,len,id},{}},    -- 陷阱,id+100000为回调
		},
	}
	
	注意：
		1、actTimer: [nil] 非时间类活动(常态活动)  [~=nil] 时间类活动 
		2、对于非时间类的活动: (比如：降魔录/排位赛/偷袭/擂台赛/宝石副本)
			-->不支持partRM参数、即不支持分房间处理
			-->场景配置的bManual参数必须为0、即自动删除场景
		3、对于时间类的活动: (比如：曲水流觞)			
			-->必须同时配置 actTimer 和 clrTimer 两个参数、且clrTimer不能超过10分钟
			-->如果有动态场景倒计时必须满足 cTimer + 60 <= clrTimer <= cTimer + 5*60、即cTimer不能超过5分钟
			-->建议：bManual参数配置为1、即手动删除场景
			
		4、数据存储:
			dataType: 
				[nil] 没有数据存储 [10] 活动数据 [100] 玩家数据 [110] 活动数据 & 玩家数据
		
		5、NoClearP:
			-->如果没有配置NoClearP这个参数、则会在玩家切换场景/下线时自动清理玩家数据和活动标志(player[sid])
			-->** 对于非时间类活动如果配置了这个参数那么一定要记得在适当的时候手动调用清理数据 **	
			--> [1] 需要手动调用清理数据
]]

--[[
	外部调用函数及接口实现
	I、活动框架调用说明:
		1、activitymgr:create('name')
			调用说明:
				-->非时间类活动：Active_name = Active_name or activitymgr:create('name') -- 全局唯一
				-->时间类活动：
					活动开始时调用 activitymgr:create('name')
					需要使用 Active_name时调用 Active_name = activitymgr:get('name')
				
		2、如果需要创建动态场景:
			Active_name:createDR(DRNum,tMapID,args)
			参数说明:
				@DRNum: 必传参数[DRList配置动态场景序号]
				@tMapID: 决定动态场景地图ID [nil] 取配置的tMapID [~nil] tMapID
				@args: 可不传参数 [用于场景倒计时回传、需配置场景倒计时才有效]
		3、添加玩家到该活动
			Active_name:add_player(sid, DRNum, regionID, x, y, mapGID)
			参数说明:
				@sid: 必传参数
				@DRNum: 必传参数[DRList配置动态场景序号]
				@regionID: [nil] 无场景需求 [0] 动态场景 [>0] 固定场景
				@x: 如果x ~= nil and y ~= nil 则以 x,y 作为进入点坐标、否则以EnterPos的配置作为进入点坐标
				@y: 如果x ~= nil and y ~= nil 则以 x,y 作为进入点坐标、否则以EnterPos的配置作为进入点坐标
				@mapGID: 动态场景GID ( 只在regionID == 0 时有效 )
					
	II、提供给外部调用接口
		1、获取整个活动数据: activitymgr:get('name') 仅用来返回[Active_name]所有活动相关处理都调用下面的接口 
		2、获取场景历史最高人数: Active_name:get_player_cnt(mapGID) (暂未实现！！！)
		3、获取活动场景数据: Active_name:get_regiondata(mapGID) return: 返回的表带有一个默认KEY [cTimer] 不能被覆盖
		4、获取活动玩家数据: Active_name:get_mydata(sid)
		5、清理活动玩家数据: Active_name:clear_mydata(sid)
		6、清理活动玩家标志: Active_name:clear_flags(sid)
		7、判断玩家是否在该活动: Active_name:is_active(sid)
		8、玩家退出动态场景: Active_name:back_player(sid)
		9、场景遍历操作函数: Active_name:traverse_region(f) 回调f(gid)
		10、获取活动标识: Active_name:get_state() 0/1
		11、获取时间类活动公共数据: Active_name:get_pub()
		
	III、外部需要实现的接口
		1、场景怪物全部死亡处理:Active_name:on_monDeadAll(mapGID)
		2、玩家死亡处理:Active_name:on_playerdead(sid,rid,mapgid,killersid)
		3、场景切换处理:Active_name:on_regionchange(sid)
		4、下线处理:Active_name:on_logout(sid)
		5、上线处理:Active_name:on_login(sid)
		6、场景删除回调:Active_name:on_regiondelete(RegionID, mapGID)
]]--

DRList = 
{	 
	xml = { --降魔录
		dataType = 10,
		[1]={
			--tMapID = 1016,
			bManual = 0,
		},
	},
	manor = { --庄园
		dataType=110,
		NoClearP=1,
		[1]={
			--tMapID = 1016,
			EnterPos = {15,27},
			bManual = 0,
		},
	},
	yushi = {  --玉石副本
		dataType = 10,
		[1]={
			tMapID = 516,
			EnterPos = {15,16},
			bManual = 0,
		},
	},
	ss = {  --神兽
		[1]={
			tMapID = 505,
			EnterPos = {39,38},
			bManual = 1,				-- 是否手动删除动态场景(*必须配置此参数) [1] 手动删除 [0] 自动删除
			cTimer = 30*60,			-- 场景倒计时
		},
	},
	Escort={  --护送
		
	},
	wenquan = {  --温泉
		actTimer = 30*60,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 10,		-- 活动结束后10秒强制传出
		partRM = {60,50},	
		dataType = 110,					-- [nil] 没有数据存储 [10]活动数据(data[regionGID]) [100]玩家数据(player[sid])
		NoClearP = 1,					-- ** 对于非时间类的活动如果配置了这个参数一定要记得手动调用clear_mydata **
		[1]={
			tMapID = 508,
			EnterPos = {{6,15},{10,20},{15,20},},--进入随机坐标
			bManual = 1,
			traps={{14,14,2,101},}
		},
	},
	qsls = {  --曲水流觞
		actTimer = 30*60,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 10,		-- 活动结束后10秒强制传出
		partRM = {60,50},	
		dataType = 110,					-- [nil] 没有数据存储 [10]活动数据(data[regionGID]) [100]玩家数据(player[sid])
		--NoClearP = 1,					-- ** 对于非时间类的活动如果配置了这个参数一定要记得手动调用clear_mydata **
		[1]={
			tMapID = 500,
			EnterPos = {{27,104},{10,95},{23,88},{20,71},{37,58},{28,65},{11,45},{29,19},{9,32}},--进入随机坐标
			bManual = 1,
		},
	},
	task = {  --任务活动
		actTimer = 60*60,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 10,		-- 活动结束后10秒强制传出
		partRM = {2010,2000},	
		--dataType = 110,					-- [nil] 没有数据存储 [10]活动数据(data[regionGID]) [100]玩家数据(player[sid])
		--NoClearP = 1,					-- ** 对于非时间类的活动如果配置了这个参数一定要记得手动调用clear_mydata **
		[1]={
			tMapID = 519,
			EnterPos = {{9,78},},--进入随机坐标
			bManual = 1,
			traps={{3,79,3,102},} --traps={{x,y,len,id},{}},    -- 陷阱,id+100000为回调
		},
	},
	tjbx = {  --天降宝箱
		actTimer = 30*60,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 10,		-- 活动结束后10秒强制传出
		partRM = 1,	
		dataType = 10,					-- [nil] 没有数据存储 [10]活动数据(data[regionGID]) [100]玩家数据(player[sid])
		--NoClearP = 1,					-- ** 对于非时间类的活动如果配置了这个参数一定要记得手动调用clear_mydata **
		[1]={
			tMapID = 1036,
			EnterPos = {{37,107},},--进入随机坐标
			bManual = 1,
			-- traps={{3,79,3,103},} --traps={{x,y,len,id},{}},    -- 陷阱,id+100000为回调
		},
	},
	hunting = {  --抓马
		actTimer = 7200,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 10,					-- 活动结束后10秒强制传出
		partRM = {60,50},	
		dataType = 100,					-- [nil] 没有数据存储 [10]活动数据(data[regionGID]) [100]玩家数据(player[sid])
		NoClearP = 1,					-- ** 对于非时间类的活动如果配置了这个参数一定要记得手动调用clear_mydata **
		[1]={
			tMapID = 501,
			EnterPos = {{7,35},{16,35},{25,35},{34,35},{43,35},{52,35},},--进入随机坐标
			bManual = 1,
			
		},
	},
	--捕鱼
	catch_fish = {  
		actTimer = 33*60,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 60,					-- 活动结束后10秒强制传出
		partRM = {60,50},	
		dataType = 100,					-- [nil] 没有数据存储 [10]活动数据(data[regionGID]) [100]玩家数据(player[sid])
		NoClearP = 1,					-- ** 对于非时间类的活动如果配置了这个参数一定要记得手动调用clear_mydata **
		[1]={
			tMapID = 502,
			EnterPos = {{7,27},{16,27},{25,27},{34,27},{43,27},{52,27},},--进入随机坐标
			bManual = 1,
			
		},
	},
	-- 排位赛
	MaRank = {							-- 活动名称(name)
		dataType = 10,		
		-- 场景配置
		[1] = {  
			tMapID = 512,				-- 地图ID
			EnterPos = {15,30},			-- 进入坐标(支持多坐标随机)							
			bManual = 0,				-- 是否手动删除动态场景(*必须配置此参数) [1] 手动删除 [0] 自动删除
			cTimer = 3 * 60,			-- 场景倒计时						
		},
	},
	-- 庄园掠夺
	MaRobb = {
		dataType = 10,
		-- 场景配置		
		[1] = {  
			tMapID = 1002,				-- 地图ID									
			bManual = 0,				-- 是否手动删除动态场景(*必须配置此参数) [1] 手动删除 [0] 自动删除
			cTimer = 3 * 60,			-- 场景倒计时						
		},
	},
	
	-- 三界战场
	sjzc = {		
		actTimer = 30*60,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 10,					-- 活动结束后10秒强制传出
		partRM = 1,
		dataType = 110,					-- 活动数据&玩家数据
		NoClearP = 1,					-- 手动清除玩家数据
		-- 场景配置		
		[1] = {  
			tMapID = 503,				-- 地图ID									
			bManual = 1,				-- 是否手动删除动态场景(*必须配置此参数) [1] 手动删除 [0] 自动删除				
		},
	},
	--匿名战场
	afight={		
		actTimer = 20*60,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 10,					-- 活动结束后10秒强制传出
		partRM = 1,
		dataType = 110,					-- 活动数据&玩家数据
		NoClearP = 1,					-- 手动清除玩家数据
		-- 场景配置		
		[1] = {  
			tMapID = 503,				-- 地图ID									
			bManual = 1,				-- 是否手动删除动态场景(*必须配置此参数) [1] 手动删除 [0] 自动删除				
		},
	},
	-- 竞技场
	jjc = {
		actTimer = 30*60,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 5*60 + 60,			-- 活动结束后5*60秒强制传出
		dataType = 100,					-- 活动数据&玩家数据
		NoClearP = 1,					-- 手动清除玩家数据
		-- 场景配置		
		[1] = {  
			tMapID = 510,				-- 地图ID									
			bManual = 0,				-- 是否手动删除动态场景(*必须配置此参数) [1] 手动删除 [0] 自动删除
			DelPos = {101,16,21},		-- 场景删除退出点
			cTimer = 5*60,				-- 场景倒计时			
		},
	},
	
	-- 帮会战
	ff = {
		actTimer = 30*60,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 10,					-- 活动结束后10秒强制传出
		partRM = 1,
		dataType = 100,					-- 活动数据&玩家数据
		NoClearP = 1,					-- 手动清除玩家数据
		-- 场景配置		
		[1] = {  
			tMapID = 504,				-- 地图ID									
			bManual = 1,				-- 是否手动删除动态场景(*必须配置此参数) [1] 手动删除 [0] 自动删除			
		},
	},
	
	-- 攻城战
	cf = {
		actTimer = 60*60,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 10,					-- 活动结束后10秒强制传出
		partRM = 1,
		dataType = 100,					-- 活动数据&玩家数据
		NoClearP = 1,					-- 手动清除玩家数据
		-- 场景配置		
		[1] = {  
			tMapID = 523,				-- 地图ID									
			bManual = 1,				-- 是否手动删除动态场景(*必须配置此参数) [1] 手动删除 [0] 自动删除			
		},
	},
	span_boss = {  -- 跨服BOSS
		actTimer = 33*60,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 60,					-- 活动结束后10秒强制传出
		partRM = {65,55},
		dataType = 10,					-- [nil] 没有数据存储 [10]活动数据(data[regionGID]) [100]玩家数据(player[sid])
		bSpan = 1,						-- 是否跨服活动
		[1]={
			tMapID = 1041,
			EnterPos = {5,111},			--进入随机坐标
			bManual = 1,			
		},
	},
	
	span_xunbao = {  -- 跨服寻宝
		actTimer = 12*60*60 + 33*60,	-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 60,					-- 活动结束后60秒强制传出
		partRM = {1600,1500},
		dataType = 10,					-- 活动数据
		bSpan = 1,
		limit = 1,						-- 只能创建一个房间
		-- 场景配置		
		[1] = {  
			tMapID = 1043,				-- 地图ID	
			EnterPos = {73,108},	
			bManual = 1,				-- 是否手动删除动态场景(*必须配置此参数) [1] 手动删除 [0] 自动删除				
		},
	},

	-- span_3v3_reg = {  -- 跨服3v3报名场景
	-- 	actTimer = 33*60,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
	-- 	clrTimer = 2,					-- 活动结束后10秒强制传出
	-- 	partRM = {65,55},
	-- 	dataType = 110,					-- [nil] 没有数据存储 [10]活动数据(data[regionGID]) [100]玩家数据(player[sid])
	-- 	-- bSpan = nil,						-- 是否跨服活动
	-- 	[1]={
	-- 		tMapID = 101,				-- 地图ID									
	-- 		bManual = 0,				-- 是否手动删除动态场景(*必须配置此参数) [1] 手动删除 [0] 自动删除
	-- 		-- DelPos = {101,16,21},		-- 场景删除退出点
	-- 		-- cTimer = 5*60,				-- 场景倒计时	
	-- 		EnterPos = {11,11},			--进入随机坐标		
	-- 	},
	-- },

	span_3v3_vs = {  -- 跨服3v3打架场景
		actTimer = 122*60,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 4*60,			-- 活动结束后5*60秒强制传出
		dataType = 110,					-- 活动数据&玩家数据
		-- NoClearP = 1,					-- 手动清除玩家数据
		-- 场景配置		
		[1] = {  
			tMapID = 510,				-- 地图ID									
			bManual = 0,				-- 是否手动删除动态场景(*必须配置此参数) [1] 手动删除 [0] 自动删除
			DelPos = {101,16,21},		-- 场景删除退出点
			--EnterPos = {20,28},			--进入随机坐标		
			cTimer = 3*60,				-- 场景倒计时			
		},
	},
	span_1v1_vs = {  -- 跨服1v1打架场景
		actTimer = 62*60,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 4*60,			-- 活动结束后5*60秒强制传出
		dataType = 110,					-- 活动数据&玩家数据
		-- NoClearP = 1,					-- 手动清除玩家数据
		-- 场景配置		
		[1] = {  
			tMapID = 1045,				-- 地图ID									
			bManual = 1,				-- 是否手动删除动态场景(*必须配置此参数) [1] 手动删除 [0] 自动删除
			--DelPos = {101,16,21},		-- 场景删除退出点
			--EnterPos = {20,28},			--进入随机坐标		
			cTimer = 60*2 + 0 + 10,				-- 场景倒计时			
		},
	},
	span_tjbx = {  --跨服天降宝箱
		actTimer = 33*60,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 60,					-- 活动结束后10秒强制传出
		partRM = {50,40},	
		dataType = 10,					-- [nil] 没有数据存储 [10]活动数据(data[regionGID]) [100]玩家数据(player[sid])
		--NoClearP = 1,					-- ** 对于非时间类的活动如果配置了这个参数一定要记得手动调用clear_mydata **
		[1]={
			tMapID = 1036,
			EnterPos = {{37,107},},--进入随机坐标
			bManual = 1,
			-- traps={{3,79,3,103},} --traps={{x,y,len,id},{}},    -- 陷阱,id+100000为回调
		},
	},
	-- 跨服三界战场
	span_sjzc = {		
		actTimer = 33*60,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 60,					-- 活动结束后10秒强制传出
		enterRM = {180,150},
		dataType = 110,					-- 活动数据&玩家数据
		NoClearP = 1,					-- 手动清除玩家数据
		-- 场景配置		
		[1] = {  
			tMapID = 503,				-- 地图ID									
			bManual = 1,				-- 是否手动删除动态场景(*必须配置此参数) [1] 手动删除 [0] 自动删除				
		},
	},
	
	-- 三界至尊(海选)
	sjzz = {		
		actTimer = 2400,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 10,					-- 活动结束后10秒强制传出
		partRM = 1,
		[1]={
			tMapID = 530,
			EnterPos = {{19,105},},--进入随机坐标
			bManual =1,
		},
	},
		
	-- 三界至尊(预赛)
	sjzz_ys = {		
		actTimer = 2400,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 10,					-- 活动结束后10秒强制传出
		partRM = 1,
		[1]={
			tMapID = 532,
			EnterPos = {{17,120},},--进入随机坐标
			bManual = 1,
		},
	},
	
		-- 三界至尊(决赛)
	sjzz_js = {		
		actTimer = 2400,				-- 活动时间计时器(*必须 < 90 * 60)(如果配置这个值活动结束后会删除整个活动数据)
		clrTimer = 10,					-- 活动结束后10秒强制传出
		partRM = 1,
	
		[1]={
			tMapID = 533,
			EnterPos = {{24,98},},--进入随机坐标
			bManual =1,
		},
	},
}