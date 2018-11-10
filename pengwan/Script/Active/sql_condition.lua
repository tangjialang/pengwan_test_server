-- function ac_ver()
	-- return '1.0.0'
-- end
--[[
local ConditionType = {
	equip = 1,		-- 装备
	partic = 2,		-- 参与
	rank = 3,		-- 排行
	collect = 4,	-- 收集
	mount = 5,		-- 坐骑
	heros = 6,		-- 随从
	attr = 7,		-- 属性
	recharge = 8,	-- 充值消费达到
	enviroment = 9,	-- 改变游戏环境 只会出现在eventbuf
	special = 10,	-- 特殊类
	escort = 11,	-- 护送美人
	boss = 12,		-- boss活动
	qibing = 13,	-- 骑兵
	merge = 14,		-- 合服活动(补偿...)
	m_time = 15,	-- 次数管理器次数相关活动
	xiagou = 16,	-- 限购
	dbcz = 17,		-- 单笔充值
	wing = 18,		-- 神翼
	djxh - 19,		-- 道具消耗
	nvshen = 20,	--女神
}

-- 装备判断类型[1]
local eq_Type = {
	kind = 1,		-- 种类
	level = 2,		-- 等级
	quality = 3,	-- 品质
	fj_attr = 4,	-- 附加属性
	pinfen = 5,		-- 评分
	enhance = 6,	-- 强化
	jewel = 7,		-- 玉石
	suit = 8,		-- 套装
	zx = 9,			-- 紫星强化
}

-- 参与类型[2]
local pa_Type = {
	zyfb = 1,		-- 战役副本
	card = 2,		-- 英雄谱
	escort = 3,		-- 运镖	
}

-- 排行榜类[3]
local rk_Type = {
	cz = 1,			-- 充值排行
	cz_eday = 2,	-- 每日充值排行
	xf = 3,			-- 消费排行
	xf_eday =4,		-- 每日消费排行
	mount = 5,		-- 坐骑排行
	hero = 6,		-- 随从排行
	level = 7,		-- 角色等级排行
	fight = 8,		-- 角色战斗力排行
	yy = 9,			-- 护身法宝
	battle = 10,	-- 战斗法宝
	flower = 11,	-- 鲜花魅力排行
	equipQH = 12,	-- 装备强化
	bsnum = 13,		-- 宝石等级和
	manorrank = 14,	-- 庄园排位
	qibing = 15,	-- 骑兵排行
	king = 16,		-- 国王
	wing = 17,		-- 神翼
	king_fac = 18,	-- 国王帮会
	czex = 19,		-- 充值+额外
}

-- 收集类[4]
local co_Type = {
	item = 1,		-- 收集道具
	card = 2,		-- 收集英雄谱
	
}

-- 坐骑类[5]
local mo_Type = {
	kind = 1,		-- 种类
	level = 2,		-- 等级
	quality = 3,	-- 品质
	gengu = 4,		-- 根骨
	wuxing = 5,		-- 悟性
	enhance = 6,	-- 强化
	skill = 7,		-- 技能	
}

-- 随从类[6]
local he_Type = {
	kind = 1,		-- 种类
	level = 2,		-- 等级
	quality = 3,	-- 品质	
	enhance = 4,	-- 强化
	gift = 5,		-- 天赋
	skill = 6,		-- 技能	
}

-- 角色属性类[7]
local attr_Type = {
	fight = 1,		-- 战斗力
	level = 2,		-- 角色等级
	skill = 3,		-- 技能
	wjqs = 4,		-- 武经七书
	xinfa = 5,		-- 心法
	jingmai = 6,	-- 经脉
	zfexp = 7,		-- 祝福经验(春节)
	fwdegree = 8,	-- 福娃好感度(春节)
}

-- 充值消费类[8]
local rc_Type = {
	cz_dc = 1,		-- 单次充值
	cz_lj = 2,		-- 累计充值
	xf_history = 3,	-- 历史总消费
	cz_eday = 4,	-- 每日充值
	xf_eday = 5,	-- 每日消费
	xf_count = 6,	-- 消费总数
}

-- 游戏环境改变类型[9]
local environType = {
	mon_award = 1,		-- 杀怪经验倍数


	xunbao = 4,		-- 寻宝活动
	zhuanpan = 5,	-- 幸运大转盘
}

-- 特殊类[10]
local special_Type = {
	factionLV = 1,	-- 帮派冲级
	edayActive = 2,	-- 每日活跃度
	plat_onetime=3, --360平台等级领奖 1为年费 2-100为红钻等级,100-200为卫士等级
	360_everyday=4, --平台360红钻每日领奖,yy会员每日
	yy_everyday=5, --yy会员每日
	edayLogin = 6,	-- 每日登陆(判断等级而已)
	loginNum = 7, --累积登陆次数
}

-- 骑兵[13]
local qb_Type = {
	level = 1,		-- 等级
	bh = 2,			-- 兵魂
	bl = 3,			-- 兵灵
}

-- 合服活动[14]
local qb_Type = {
	level = 1,		-- 等级补偿
	zctime = 2,		-- 合服补偿	
}

-- 次数管理器次数相关活动[15]
local times_Type = {
	addtime = 1,		-- 参与次数活动
}

-- 神翼[18]
local wing_Type = {
	level = 1,		-- 等级
	yh = 2,			-- 翼魂
	yl = 3,			-- 翼灵
}

-- 奖励类型
local Award_Type = {
	money = 1,		-- 铜币
	exps = 2,		-- 经验
	item = 3,		-- 道具	
}


]]--
local achieve_=require('Script.Achieve.fun')
local get_fundata=achieve_.get_fundata
local active_mgr_m = require('Script.active.active_mgr')
local activitymgr=active_mgr_m.activitymgr
local CheckTimes=CheckTimes
local uv_TimesTypeTb = TimesTypeTb
local GetTimesInfo=GetTimesInfo

-- 运营活动条件配置
ActiveConditionConf = {
	-- 条件判断
	CheckConditions = function ( sid, conditions, dodel )
		if type( conditions ) == 'table' then 					-- conditions = {}
			local ck = nil
			local info
			for k,v in pairs( conditions ) do
				local mainType = rint(k / 100)
				local subType = rint(k % 100)
				if ActiveConditionConf[mainType] ~= nil then	-- k is table's key.
					ck, info = ActiveConditionConf[mainType]( sid, subType, v, dodel )
				else
					ck, info = ( tostring( k ) .. ' ' .. tostring( v ) .. ' : no support!' )
				end
				--if ck ~= true then
				if not ck then
					return 0, info
				end
			end
		else
			return 0
		end		
		return 1
	end,
	
	-- 装备类条件
	[1] = function (sid, subType, args)
		if subType < 1 or subType > 9 then
			return false
		end
		return true
	end,
	-- 参与类条件
	[2] = function (sid, subType, args)
		if subType < 1 or subType > 3 then
			return false
		end
		return true
	end,
	-- 排行类条件
	[3] = function (sid, subType, args)
		if subType < 1 or subType > 19 then
			return false
		end
		return true
	end,
	-- 收集类条件 (暂时只支持道具(不支持装备)收集,并且全部扣除道具)
	[4] = function (sid, subType, args, dodel)
	
		if subType < 1 or subType > 2 then
			return false
		end
		if type(args) ~= type({}) then
			return false
		end
		if subType == 1 or subType == 2 then	-- 道具收集类
			for itemid, itemnum in pairs(args) do					
				if type(itemid) == type(0) and type(itemnum) == type(0) then
					if not (CheckGoods(itemid, itemnum, 1, sid,'运营活动') == 1 ) then
						return false
					end
				end
			end
			-- 需要扣除道具
			if dodel then
				for itemid, itemnum in pairs(args) do
					if type(itemid) == type(0) and type(itemnum) == type(0) then
						if not (CheckGoods(itemid, itemnum, 0, sid,'运营活动') == 1 ) then
							return false
						end
					end
				end
			end
		end
		
		return true
	end,
	-- 坐骑类条件
	[5] = function (sid, subType, args)
		if subType < 1 or subType > 7 then
			return false
		end
		return true
	end,
	-- 随从类条件
	[6] = function (sid, subType, args)
		if subType < 1 or subType > 6 then
			return false
		end
		return true
	end,
	-- 人物属性类条件
	[7] = function (sid, subType, args)
		if subType < 1 or subType > 8 then
			return false
		end
		if subType == 1 then						--战斗力
			local fightval = CI_GetPlayerData(62)	
			if fightval == nil or fightval <= 0 then return false end 
			if type(args) ~= type(0) or fightval < args then
				return false
			end			
		elseif subType == 7 then
			local lv = CJ_GetLevel(sid,1) or 0
			if type(args) ~= type(0) or lv < args then
				return false
			end 
		elseif subType == 8 then
			local lv = CJ_GetLevel(sid,2) or 0
			look('lvlvlvlv'.. lv,1)
			if type(args) ~= type(0) or lv < args then
				return false
			end 
		end
		return true
	end,
	-- 充值消费类条件
	[8] = function (sid, subType, args)
		if subType < 1 or subType > 6 then
			return false
		end
		if args == nil then
			return false
		end
		if subType == 3 then	-- 历史总消费
			local consum = GetPlayerPoints( sid , 8 )
			if consum == nil then return false end
			if type(args) ~= type(0) or consum < args then
				return false
			end
		end
		return true
	end,
	-- 改变游戏世界类型 不会有奖励
	[9] = function(sid, subType, args)
		return false
	end,	
	-- 特殊类
	[10] = function(sid, subType, args)
		if subType < 1 or subType > 6 then
			return false
		end
		if args == nil then
			return false
		end
		if subType == 1 then		-- 帮派冲级活动
			if type(args) ~= type(0) then
				return false
			end
			local flv=CI_GetFactionInfo(nil,2)
			if flv==nil or flv==0 then 

				return false
			end
			if flv<args then 

				return false
			end
		elseif subType == 2 then	-- 每日活跃度
			local actPoint = get_fundata(sid)
			if actPoint == nil or actPoint.val == nil then return false end
			if type(args) ~= type(0) or actPoint.val < args then
				return false
			end
		elseif subType == 3 then-- 钻等级领奖1为年费 2-100为红钻等级,100-200为卫士等级
			local lv =CI_GetPlayerIcon(0,5)
			if type(args) ~= type(0) or type(lv) ~= type(0) or lv<0 then return end
			if args==1  then--卫士等级前台判断
				if rint(lv/16)~=1 then return end
			elseif args<100  then
				if (lv%16)<args-1 then return end
			end
		elseif subType == 4 then	--每日礼包
			local plat=_G.__plat
			if plat==101 then --360
				local lv =CI_GetPlayerIcon(0,5)
				if type(args) ~= type(0) or type(lv) ~= type(0) or lv<0 then return end
				if (lv%16)~=args then return end
			end
		elseif subType == 6 then	--每日登陆(判断等级)
			local lv = CI_GetPlayerData(1,2,sid)
			if lv == nil or lv <= 0 then return false end 
			if type(args) ~= type(0) or lv < args then
				return false
			end
		end
		return true		
	end,
	-- 骑兵
	[13] = function(sid, subType, args)
		-- look('subType:' .. tostring(subType))
		-- look('args:' .. tostring(args))
		if subType < 1 or subType > 3 then
			return false
		end
		if args == nil then
			return false
		end
		if subType == 1 then		-- 骑兵等级
			local qblv = sowar_getlv(sid)
			if qblv == nil then
				return false
			end
			if type(args) ~= type(0) then
				return false
			end
			if qblv < args then
				return false
			end
		elseif subType == 2 then	-- 兵魂等级
			local bhlv = sowar_getlv(sid,1)
			if bhlv == nil then
				return false
			end
			if type(args) ~= type(0) then
				return false
			end
			if bhlv < args then
				return false
			end
		elseif subType == 3 then	-- 兵灵等级
			local bllv = sowar_getlv(sid,2)
			if bllv == nil then
				return false
			end
			if type(args) ~= type(0) then
				return false
			end
			if bllv < args then
				return false
			end
		end
		return true
	end,
	-- 合服
	[14] = function(sid, subType, args)
		-- look('subType:' .. tostring(subType))
		-- look('args:' .. tostring(args))
		if subType < 1 or subType > 2 then
			return false
		end
		if args == nil then
			return false
		end
		if subType == 1 then		-- 等级补偿
			local lv = CI_GetPlayerData(1,2,sid)
			if lv == nil or lv <= 0 then
				return false
			end
			if type(args) ~= type(0) then
				return false
			end
			if lv < args then
				return false
			end
		end
		return true
	end,

	-- 次数管理器
	[15] = function(sid, subType, args)
		-- look('subType:' .. tostring(subType),1)
		-- look(args,1)
		if subType < 1 or subType > 100 then
			return false
		end
		if args == nil then
			return false
		end
		
		if type(args) ~= type(0) then
			return false
		end
		local timeinfo=GetTimesInfo(sid,subType)
		if (timeinfo[1] or 0)<args then 
			return false
		end
		
		return true
	end,
	-- 限购
	[16] = function(sid, subType, args)
		-- look('subType:' .. tostring(subType),1)
		-- look(args,1)
		if subType == 3 then
			if args == nil then
				return false
			end
			
			if type(args) ~= type(0) then
				return false
			end
			if not  CheckCost( sid , args , 1 , 1, "限购") then
				return false
			end
		end
		
		return true
	end,
	[18] = function(sid, subType, args)
		if subType == 1 then
			if type(args) ~= type(0) then
				return false
			end
			local winglv = wing_get_info(sid,1) or 0
			if winglv < args then
				return false
			end
		elseif subType == 2 then
			if type(args) ~= type(0) then
				return false
			end
			local wingyh = wing_get_info(sid,4) or 0
			if wingyh < args then
				return false
			end
		elseif subType == 3 then
			if type(args) ~= type(0) then
				return false
			end
			local wingyl = wing_get_info(sid,3) or 0
			if wingyl < args then
				return false
			end
		end
		
		return true
	end
}


