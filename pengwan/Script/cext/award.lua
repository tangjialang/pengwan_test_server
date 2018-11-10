--[[
file:	award_interface.lua
desc:	奖励通用接口
author:	
refix: done by chal
notes:
	1、通用奖励信息生成表( 包括任务奖励、副本奖励、运营活动奖励 )
	2、奖励道具判断（判断背包空格）
	3、统一给奖励接口
args:
	@sid [玩家sid]
	@AwardTb [原始奖励列表]
	@storeData [奖励存储数据区（副本奖励存储在永久数据区、任务和运营活动奖励存储在临时数据区）]
	@extra [额外参数信息] (对于数值类索引，这只能是个系数比列、对于字符串类索引，可以特殊处理)
	@fbID [副本奖励需要传这个值]
]]--

-- 奖励类型
-- local Award_Type = {
	-- money = 1,		-- 绑银
	-- exps = 2,		-- 经验
	-- item = 3,		-- 道具
	-- bindYB = 4,		-- 绑定元宝
	-- lingqi = 5,		-- 灵气
	-- factionGX = 6,	-- 帮会贡献
	-- zhanG = 7,		-- 战功
	-- shengW = 8,		-- 声望
	-- titel = 9,		-- 称号 {titleID,limitTime}
	-- fid = 10,		-- 代表只有这个帮会ID的人才能领奖
	-- ry = 11,			-- 荣誉值		
	-- LL = 12,			-- 历练值
-- }

--[[
	副本奖励
	CSAwards = {					-- 副本过关奖励
		Exp = 100000,					-- 经验
		Money = 10000,				-- 铜钱
		sy=1000,        --神源
		item = {					-- 奖励物品
			{ Rate = { 1, 10000 }, ItemID = 627, CountList = { 5, 10 }, IsBind = 1 },--炼骨丹
			{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 5, 10 }, IsBind = 1 },--彩虹石
		},
		SpecialProc = {---特殊奖励回调处理OnSpAward_1001
		},
		jf=100,-- 组队副本2积分--历练值
		star={--星级额外奖励
			[1]={--1星
				_time=120,
				award={--通用奖励配置
					[1]=100,
					[3]={{413,1,1},{413,1,1}},
					},
				},
			[2]={--2星
				_time=100,
				award={--通用奖励配置
					[1]=100,
					[3]={{413,1,1},{413,1,1}},
					},
				},	
			[3]={--3星
				_time=50,
				award={--通用奖励配置
					[1]=100,
					[3]={{413,1,1},{413,1,1}},
					},
				},	
			
			},
		vip={{416,1,1},{416,1,1},{416,1,1},{416,1,1},},--vip额外奖励,v3-4选1
		first={--首次--通用奖励配置
			[1]=100,
			[3]={{413,1,1},{413,1,1}},
			},
		ev_first={--每日首次,注意:配置了exp等都会同时给,比如给玩家200经验,exp=100,那这里就配100
			[1]=100,
			[3]={{413,1,1},{413,1,1}},
			},
		equip= {
			count	-- [1 ~ 99] 给相应数量装备 [{[1] = 2000,[2] = 10000,...}] 随机数量(必须保证每个数量都有概率)
			eqLV 	-- [nil] 根据玩家等级给相应装备(现在是向下取) [20 ~ 100] 装备等级 每10级一个档次, 
			quality -- [1 ~ 5] 给相应品质装备 [{[1] = 2000,[2] = 10000,...}] 随机品质(必须保证每个品质都有概率)
			school	-- [nil] 根据玩家职业给装备 [1] 随机职业(平均概率 1/3)
			eqType 	-- [nil] 随机部位(平均概率 1/9) [1 ~ 9] 给相应部位装备 [{1,5}] 在1~5之间部位随机
			sex  	-- [nil] 根据玩家性别给装备 [1] 随机性别(不处理) 
						也就是说如果sex==nil、 eqType必须指定为1 or 2(即只针对武器有效)、 否则无效
			IsBind 	-- [0] 不绑定 [1] 绑定
		},
		giveGoods={
			[1] = {{itemID,itemNum,bind},...},  	-- 不区分任何信息 单纯给道具
			[2] = {									-- 装备类(区分职业和性别)
					[10] = {itemID,itemNum,bind},	-- 将军府(女)
					[11] = {itemID,itemNum,bind},	-- 将军府(男)
					[20] = {itemID,itemNum,bind},	-- 修仙(女)
					[21] = {itemID,itemNum,bind},	-- 修仙(男)
					[30] = {itemID,itemNum,bind},	-- 九黎(女)
					[31] = {itemID,itemNum,bind},	-- 九黎(男)					
				},
			}
			[3] = {									-- 装备类(只区分职业)
				[1] = {{itemID,itemNum,bind},...},	-- 将军府
				[2] = {{itemID,itemNum,bind},...},	-- 修仙
				[3] = {{itemID,itemNum,bind},...},	-- 九黎
		},
	},

]]
--------------------------------------------------------------------------
--include:
local _G = _G
local TP_FUNC = type( function() end)
local tablepush,tableempty,tablelocate 	= table.push,table.empty,table.locate
local mathrandom 	= math.random
local pairs,ipairs,type,tostring= pairs,ipairs,type,tostring
local define		 = require('Script.cext.define')
local EquipItemInfo = define.EquipItemInfo
local PI_PayPlayer = PI_PayPlayer
local GiveGoods = GiveGoods
local GiveGoodsBatch = GiveGoodsBatch
local look = look
local rint = rint
local CI_GetPlayerData = CI_GetPlayerData
local isFullNum,GetStringMsg,TipCenter = isFullNum,GetStringMsg,TipCenter
--------------------------------------------------------------------------
--interface:
CommonAwardTable = {
	AwardProc = function (sid,AwardTb,storeData,extra,fbID)	
		if sid == nil or AwardTb == nil then return end
		local result = {}
		for k, param in pairs(AwardTb) do
			if k == 'func' then			-- 自定义函数生成奖励
				local foo =  _G[param]
				if type(foo) == TP_FUNC then
					foo(sid,result,fbID)
				end
				break
			end
			if k == 'tab' then
				if type(param) == type({}) then
					result = param		-- 自定义奖励表
				end
				break
			end
			local func = CommonAwardTable[k]
			if func ~= nil and type(func) == TP_FUNC then
				func(sid,result,param,extra,fbID)
			end
		end
		
		if storeData  == nil then 
			return result
		else
			storeData.Awd = {
			['fbID'] = fbID,
			['Award'] = result,
		}
		end
		
		return			
	end,
	
	-- 特殊奖励 比如第一次通关 自定义奖励处理
	-- 现在没用但是即使启用坑内也只能针对副本
	-- 这里并没有保证当前Award列表已经初始化了 所以这里所做的操作只能累加
	SpecialProc = function(sid,result,param,extra,fbID)
		local spfunc = 'OnSpAward' .. tostring(fbID)
		if type(spfunc) == TP_FUNC then
			func(sid,result,param,extra)
		end
	end,
	
	-- param = 经验 副本经验跟VIP等级有骨干
	Exp = function (sid,result,param,extra,fbID)
		if type(param) == 'number' then				
			result[2] = (result[2] or 0) + param
			if fbID then
				local vipLv = GI_GetVIPLevel(sid)
				if vipLv >= 4 then
					result[2] = rint(result[2] * 1.5)
				elseif vipLv >=1 then
					result[2] = rint(result[2] * 1.2)	
				end
			end
		end		
	end,
	
	-- 剧情ID做在奖励里面是为了让前台能处理判断剧情完成后再掉宝箱给奖励
	-- param = 剧情ID
	StoryID = function (sid,result,param,extra)
		if type(param) == type(0) then				
			result.storyid = param			
		end
	end,
	
	-- param = 跟铜钱计算公式有关的参数信息
	Money = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[1] = (result[1] or 0) + param			
		end
	end,
	
	-- 跑环任务环数道具
	cicitem = function(sid,result,param,extra)
		result[3] = result[3] or {}
		if param == nil or tableempty( param ) == nil then return end
		local cctData = GetCircleTaskData(sid)
		if cctData == nil then return end
		for k, v in pairs(param) do
			if cctData.num and cctData.num + 1 == k then
				tablepush(result[3], {v[1], v[2], v[3]} )
			end
		end
	end,
	
	-- param = { Rate = { 1, 10000 }, ItemID = 102, CountList = { 1, 1 }, IsBind = 1 },
	item = function (sid,result,param,extra)
		result[3] = result[3] or {}
		if param == nil or tableempty( param ) then return end
		local r = mathrandom(1, 10000)			-- 随机概率为万分比
		local count = nil
		for _, itemconf in pairs(param) do
			local chance = itemconf.Rate
			if chance ~= nil and r >= chance[1] and r <= chance[2] then					
				if type(itemconf.CountList) == type({}) then
					count = mathrandom(itemconf.CountList[1], itemconf.CountList[2])
				else
					count = itemconf.CountList
				end
				tablepush(result[3], {itemconf.ItemID, count, itemconf.IsBind} )
			end
		end
	end,
	
	items_one = function (sid,result,param,extra)
		look('items_one',2)
		result[3] = result[3] or {}
		look(#param,2)
		tablepush(result[3], param[math.random(1,#param)])
	end,
	--星级额外奖励,5星4选1
	star = function (sid,result,param1,extra,fbID)
		-- result[3] = result[3] or {}
		local pCSTemp = CS_GetPlayerTemp(sid)
		if pCSTemp.CopySceneGID==nil then return end
		local copyScene = CS_GetTemp(pCSTemp.CopySceneGID)
		-- local deadnum=(copyScene.deadnum or 0)
		if copyScene==nil then return end
		local usetime=GetServerTime()-  (copyScene.startTime or 0)
		for i=5,1,-1 do
			if param1[i] then 
				if usetime<=param1[i]._time then 
					result.star=i
					--CommonAwardTable.AwardProc(sid,param1[i].award)
					for k, param in pairs(param1[i].award) do
						local func = CommonAwardTable[k]
						if func ~= nil and type(func) == TP_FUNC then
							func(sid,result,param,extra,fbID)
						end
					end
					break
				end
			end
		end
		
	end,
	--首次--通用奖励配置
	first = function (sid,result,param1,extra,fbID)
		local pCSData = CS_GetPlayerData(sid)	
		pCSData.pro = pCSData.pro or {}
		local csType = GetCSType(fbID)
		local max=pCSData.pro[csType] or 0
		if fbID>max then 
			--CommonAwardTable.AwardProc(sid,result,param1)
			result.first=param1
			for k, param in pairs(param1) do
				local func = CommonAwardTable[k]
				if func ~= nil and type(func) == TP_FUNC then
					func(sid,result,param,extra,fbID)
				end
			end

		end
	end,
	-- 给道具(主要用于任务给道具(装备区分职业、性别)、方便前台显示)
	--[[
		param = {
			[1] = {{itemID,itemNum,bind},...},  	-- 不区分任何信息 单纯给道具
			[2] = {									-- 装备类(区分职业和性别)
					[10] = {itemID,itemNum,bind},	-- 将军府(女)
					[11] = {itemID,itemNum,bind},	-- 将军府(男)
					[20] = {itemID,itemNum,bind},	-- 修仙(女)
					[21] = {itemID,itemNum,bind},	-- 修仙(男)
					[30] = {itemID,itemNum,bind},	-- 九黎(女)
					[31] = {itemID,itemNum,bind},	-- 九黎(男)					
				},
			}
			[3] = {									-- 装备类(只区分职业)
				[1] = {{itemID,itemNum,bind},...},	-- 将军府
				[2] = {{itemID,itemNum,bind},...},	-- 修仙
				[3] = {{itemID,itemNum,bind},...},	-- 九黎
			}
			... 用于以后扩展
	]]--
	giveGoods = function (sid,result,param,extra)
		result[3] = result[3] or {}
		if param == nil or type(param) ~= type({}) or tableempty( param ) then return end
		if param[1] ~= nil then
			for k, item in pairs(param[1]) do
				if type(k) == type(0) and type(item) == type({}) then
					tablepush(result[3], item)
				end
			end
		end
		if param[2] ~= nil then
			local sch = CI_GetPlayerData(2,2,sid)
			local sex = CI_GetPlayerData(11,2,sid)
			if sch == nil or sex == nil then return end
			local index = sch * 10 + sex
			local item = param[2][index]
			if item ~= nil then 
				tablepush(result[3], item)
			end			
		end	
		if param[3] ~= nil then
			local sch = CI_GetPlayerData(2,2,sid)
			if sch == nil then return end
			local itemList = param[3][sch]
			if itemList == nil then return end
			for k, item in pairs(itemList) do
				if type(k) == type(0) and type(item) == type({}) then
					tablepush(result[3], item)
				end
			end
		end
	end,
	
	--[[
	param = {
		count	-- [1 ~ 99] 给相应数量装备 [{[1] = 2000,[2] = 10000,...}] 随机数量(必须保证每个数量都有概率)
		eqLV 	-- [nil] 根据玩家等级给相应装备(现在是向下取) [20 ~ 100] 装备等级 每10级一个档次, 
		quality -- [1 ~ 5] 给相应品质装备 [{[1] = 2000,[2] = 10000,...}] 随机品质(必须保证每个品质都有概率)
		school	-- [nil] 根据玩家职业给装备 [1] 随机职业(平均概率 1/3)
		eqType 	-- [nil] 随机部位(平均概率 1/9) [1 ~ 9] 给相应部位装备 [{1,5}] 在1~5之间部位随机
		sex  	-- [nil] 根据玩家性别给装备 [1] 随机性别(不处理) 
					也就是说如果sex==nil、 eqType必须指定为1 or 2(即只针对武器有效)、 否则无效
		IsBind 	-- [0] 不绑定 [1] 绑定
	}
	]]--
	equip = function (sid,result,param,extra)
		result[3] = result[3] or {}
		if param == nil or type(param) ~= type({}) or tableempty( param ) then return end
		if param.count == nil then return end
		-- 1、取生成装备数量
		local count = 0
		if type(param.count) == type(0) then
			count = param.count
		elseif type(param.count) == type({}) then
			local rd = mathrandom(1,10000)
			for k, v in ipairs(param.count) do
				if type(v) == type(0) and rd <= v then
					count = k
					break
				end
			end
		end
		if count == 0 then return end
		for i = 1, count do
			-- 2、取装备等级
			local eqLV = nil
			if param.eqLV == nil then
				eqLV = CI_GetPlayerData(1,2,sid)
			elseif type(param.eqLV) == type(0) then
				eqLV = param.eqLV
			end
			eqLV = tablelocate(EquipItemInfo, eqLV, 1)
			if eqLV == nil or EquipItemInfo[eqLV] == nil then
				return
			end
			-- 3、取装备品质
			local quality = nil
			if param.quality == nil then return end
			if type(param.quality) == type(0) then
				quality = param.quality
			elseif type(param.quality) == type({}) then
				local rd = mathrandom(1,10000)
				for k, v in ipairs(param.quality) do
					if type(v) == type(0) and rd <= v then
						quality = k
						break
					end
				end
			end
			if quality == nil or EquipItemInfo[eqLV][quality] == nil then 
				return
			end
			-- 4、取装备职业
			local school = nil
			if param.school == nil then
				school = CI_GetPlayerData(2,2,sid)
			elseif type(param.school) == type(0) and param.school == 1 then
				school = mathrandom(1,3)
			end
			if school == nil or EquipItemInfo[eqLV][quality][school] == nil then
				return
			end
			local equipTable = EquipItemInfo[eqLV][quality][school]		-- 根据装备等级 品质 职业定位装备ID表
			-- 5、取装备部位
			local eqType = nil
			if param.eqType == nil then
				eqType = mathrandom(1,9)
			elseif type(param.eqType) == type(0) then
				eqType = param.eqType
			elseif type(param.eqType) == type({}) then
				eqType = mathrandom(param.eqType[1],param.eqType[2])
			end
			if eqType == nil then
				return
			end
			-- 6、取装备性别
			local sex = nil
			if param.sex == nil then
				sex = CI_GetPlayerData(11,2,sid)
				if sex == nil then return end
				if eqType == 1 or eqType == 2 then		-- 性别只针对武器有效
					if sex == 0 then
						eqType = 2
					elseif sex == 1 then
						eqType = 1
					end
				end
			end
			-- 7、定位装备ID
			local equipID = equipTable[eqType]
			-- 8、添加到道具列表
			local binsert = true
			for k, v in pairs(result[3]) do
				if type(k) == type(0) and type(v) == type({}) then
					if v[1] == equipID then
						v[2] = v[2] + 1
						binsert = false
						break
					end
				end
			end
			if binsert then
				tablepush(result[3], {equipID, 1, param.IsBind} )
			end
		end		
	end,
	
	
	-- 铜钱
	[1] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[1] = (result[1] or 0) + rint(param * (extra or 1))
		end
	end,
	-- 经验
	[2] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[2] = (result[2] or 0) + rint(param * (extra or 1))			
		end
	end,
	-- 道具
	[3] = function (sid,result,param,extra)
		if type(param) == type({}) then	
			if result[3] == nil then  result[3] = {} end
			for _, item in pairs(param) do							
				tablepush(result[3], item)			
			end
		end
	end,
	-- 绑定元宝
	[4] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[4] = (result[4] or 0) + rint(param * (extra or 1))			
		end
	end,
	-- 灵气
	[5] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[5] = (result[5] or 0) + rint(param * (extra or 1))			
		end
	end,
	-- 帮会贡献
	[6] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[6] = (result[6] or 0) + rint(param * (extra or 1))			
		end
	end,
	-- 战功
	[7] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[7] = (result[7] or 0) + rint(param * (extra or 1))			
		end
	end,
	--  声望
	[8] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[8] = (result[8] or 0) + rint(param * (extra or 1))			
		end
	end,
	[11] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[11] = (result[11] or 0) + rint(param * (extra or 1))			
		end
	end,
	[12] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[12] = (result[12] or 0) + rint(param * (extra or 1))			
		end
	end,
	[13] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[13] = (result[13] or 0) + rint(param * (extra or 1))			
		end
	end,
	[14] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[14] = (result[14] or 0) + rint(param * (extra or 1))			
		end
	end,
}	

-- 检查奖励道具（背包）
function award_check_items( AwardList, AwardExtra )	
	if nil == AwardList or tableempty(AwardList) then
		return true
	end
	local succ,retCode,nCount
	-- 奖励道具
	if AwardList[3] and type(AwardList[3]) == type({}) then
		if AwardExtra == nil or AwardExtra[3] == nil then
			succ,retCode,nCount = CheckGiveGoods(AwardList[3])			
		else
			local total = {}
			for k, v in ipairs(AwardList[3]) do
				table.insert(total,v)
			end
			for k, v in ipairs(AwardExtra[3]) do
				table.insert(total,v)
			end
			succ,retCode,nCount = CheckGiveGoods(total)
		end
		
		-- look('succ:' .. tostring(succ))
		-- look('retCode:' .. tostring(retCode))
		-- look('nCount:' .. tostring(nCount))
		
		if not succ then
			if (retCode == 3) then					
				local info = GetStringMsg(14,nCount)
				TipCenter(info) 
				return false
			else
				look('award_check_items error[' .. tostring(retCode) .. ']',1)
			end
			
		end
		-- local pakagenum = isFullNum()
		-- if pakagenum < #AwardList[3] then
			-- local info =GetStringMsg(14,#AwardList[3])
			-- TipCenter(info) 
			-- return false
		-- end
	end

	return true
end

-- 统一给奖励接口(可以加些参数记录日志)
-- 这个接口是直接给奖励了，不会再判断背包不足得情况。
function GI_GiveAward(sid, AwardList, LogInfo)
	if LogInfo == nil then
		look('GI_GiveAward: LogInfo == nil',1)
		return
	end
	if nil == AwardList or tableempty(AwardList) then
		return true
	end
	
	-- 重要: 这个必须首先判断是否属于这个帮会
	if AwardList[10] and AwardList[10] > 0 then
		local fid = CI_GetPlayerData(23,2,sid)
		if fid == nil or fid < 0 then
			return
		end
		if fid ~= AwardList[10] then
			look('GI_GiveAward faction id not match')
			return
		end
	end
	
	-- give goods {itemid,itemnum,isbind}
	-- 必须配齐三个参数 不然给不了
	if AwardList[3] ~= nil then
		-- local succ,retCode,nCount = GiveGoodsBatch( AwardList[3], LogInfo, 2, sid )
		-- if not succ then
		-- 	look("GI_GiveAward erro:" .. tostring(retCode))
		-- 	return false,retCode,nCount
		-- end	
		for k,v in pairs(AwardList[3]) do
			GiveGoods(v[1],v[2],v[3],LogInfo)
		end	
	end
	-- give exp
	local exps = AwardList[2]
	if exps and type(exps) == type(0) then
		PI_PayPlayer(1,exps,0,0,LogInfo)
	end
	
	-- give money
	local money = AwardList[1]
	if money and type(money) == type(0) then
		GiveGoods(0,money,1,LogInfo)
	end
	
	-- 绑定元宝
	local BDYB = AwardList[4]
	if BDYB and type(BDYB) == type(0) then
		AddPlayerPoints( sid , 3 , BDYB ,nil,LogInfo)
	end
	
	-- 给灵气
	local LQ = AwardList[5]
	if LQ and type(LQ) == type(0) then
		AddPlayerPoints( sid , 2 , LQ,nil,LogInfo )
	end
	
	-- 给帮贡
	local BG = AwardList[6]
	if BG and type(BG) == type(0) then
		AddPlayerPoints( sid , 4 , BG,nil,LogInfo )
	end
	
	-- 给战功
	local ZG = AwardList[7]
	if ZG and type(ZG) == type(0) then
		AddPlayerPoints( sid , 6 , ZG,nil,LogInfo )
	end
	
	-- 给声望
	local SW = AwardList[8]
	if SW and type(SW) == type(0) then
		AddPlayerPoints( sid , 7 , SW,nil,LogInfo )
	end
	
	-- 称号 (需要区分职业、是否有有效期)
	local title = AwardList[9]
	if type(title) == type({}) then
		local t
		if title[1] then		-- 无职业区分
			t = title[1]
		elseif type(title[2]) == type({}) then	-- 有职业区分 [1] 女 [2] 男
			local sex = CI_GetPlayerData(11,2,sid)
			if sex and sex >= 0 then
				sex = sex + 1
			end
			t = title[2][sex]
		end
		if type(t) == type(0) then		-- 永久
			SetPlayerTitle(sid,t)
		elseif type(t) == type({}) then	-- 有效期
			SetPlayerTitle(sid,t[1],t[2])
		end
	end
	
	-- 给荣誉值
	local RY = AwardList[11]
	if RY and type(RY) == type(0) then
		AddPlayerPoints( sid , 10 , RY,nil,LogInfo )
	end
	
	-- 给历练值
	local LL = AwardList[12]
	if LL and type(LL) == type(0) then
		AddPlayerPoints( sid , 11 , LL,nil,LogInfo )
	end
	
	-- 给威望值
	-- local WW = AwardList[13]
	-- if WW and type(WW) == type(0) then
		-- AddPlayerPoints( sid , 12 , WW,nil,LogInfo )
	-- end
	
	-- 给跨服荣誉值
	local sRY = AwardList[14]
	if sRY and type(sRY) == type(0) then
		AddPlayerPoints( sid , 13 , sRY,nil,LogInfo )
	end
	
	return true
end