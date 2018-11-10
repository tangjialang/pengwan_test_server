--[[
file:	wing_fun.lua
desc:	翅膀
author:	xiao.y
updator: zhongsx 
]]--
--------------------------------------------------------------------------
--include:
local CI_SetPlayerIcon  = CI_SetPlayerIcon -- 6
local CI_GetPlayerIcon  = CI_GetPlayerIcon
local GI_GetPlayerData = GI_GetPlayerData
local PI_UpdateScriptAtt = PI_UpdateScriptAtt
local GetRWData = GetRWData
local math_floor = math.floor
local math_ceil = math.ceil
local math_random = math.random
local CI_GetPlayerData = CI_GetPlayerData
local osdate = os.date
local GetServerTime = GetServerTime
local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond
local Wing_Data = msgh_s2c_def[20][11]
local SendLuaMsg = SendLuaMsg
local Wing_HLUpdate = msgh_s2c_def[20][13]
local Wing_OtherDate = msgh_s2c_def[20][14]
local CI_UpdateBuffExtra = CI_UpdateBuffExtra
local GetPlayer = GetPlayer
local GetServerOpenTime = GetServerOpenTime
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos

local rint = rint
local type = type
--------------------------------------------------------------------------
-- data:
--[[
  	CAT_MAX_HP	= 0,		// 血量上限 1
	CAT_MAX_MP,				// 职业攻击 2
	CAT_ATC,				// 攻击 3
	CAT_DEF,				// 防御 4
	CAT_HIT,				// 命中 5
	CAT_DUCK,				// 闪避 6
	CAT_CRIT,				// 暴击 7
	CAT_RESIST,				// 抵抗 8
	CAT_BLOCK,				// 格挡 9
	CAT_AB_ATC,				// 职业抗性1（火系抗性） 10
	CAT_AB_DEF,				// 职业抗性2（冰系抗性） 11
	CAT_CritDam,			// 职业抗性3（木系抗性）12
	CAT_MoveSpeed,			// 移动速度(预留) 13
	CAT_S_REDUCE,			// 抗性减免	      14
]]--
local wing_conf = {
	minSwitchLv = 10, --开光最小有效等级
	maxLv = 20, --翅膀最高等级 
	maxskLv = 5, --技能最高等级
	cost = {lq = 100000,goodid = 767,num = {1,2,3,5,8}},--lq 遗忘 需要消费100000铜钱 封印 goodid 封印书ID num 各级所需元宝
	upgoodid = {762,10}, --{翅膀升级道具,价值元宝｝
	wing = { -- name 翅膀名称 rs 资源ID ico 翅膀名字图标 minV 最小幸运值 maxV 最大幸运值 yl 翼灵可使用个数 yh 翼魂可使用个数 num 技能个数
		[1] = {name = '钢铁之翼', rs = 4, ico = 1, minV = 150, maxV = 215, yl = 0,yh = 0, num = 0},
		[2] = {name = '冰雪之翼', rs = 3, ico = 2, minV = 321, maxV = 428, yl = 0,yh = 0, num = 1},
		[3] = {name = '天使之翼', rs = 6, ico = 3, minV = 928, maxV = 1160, yl = 0,yh =600, num = 2},
		[4] = {name = '紫云之翼', rs = 2, ico = 4, minV = 1785, maxV = 2100, yl = 10,yh = 600, num = 3},
		[5] = {name = '黑暗之翼', rs = 5, ico = 5, minV = 4600, maxV = 5111, yl = 20,yh = 600, num = 4},
		[6] = {name = '星辰之翼', rs = 3, ico = 6, minV = 9000, maxV = 9473, yl = 30,yh = 600, num = 5},
		[7] = {name = '神创之翼', rs = 7, ico = 7, minV = 10000, maxV = 12002, yl = 50,yh = 600, num = 6},
		[8] = {name = '圣王之翼', rs = 8, ico = 8, minV = 12000, maxV = 15050, yl = 50,yh = 600, num = 6},
		[9] = {name = '炽天之翼', rs = 9, ico = 9, minV = 15000, maxV = 19252, yl = 50,yh = 600, num = 6},
		[10] = {name = '至尊之翼', rs = 10, ico = 10, minV = 0, maxV = 0, yl = 100,yh = 600, num = 6},
		[11] = {name = '斑斓魔翼', rs = 11, ico = 11, minV = 0, maxV = 0, yl = 100,yh = 600, num = 6},
	},
	att={--骑兵增加属性值
		[1]={500,200,160,100,100},
		[2]={1500,600,480,300,300},
		[3]={3500,1400,1120,600,600},
		[4]={7000,2800,2240,1000,1000},
		[5]={13000,5800,4640,1800,1800},
		[6]={21000,9800,7840,2800,2800},
		[7]={31000,14800,11840,4000,4000},
		[8]={42000,20300,16240,5100,5100},
		[9]={54000,26300,21040,6400,6400},
		[10]={69000,33800,27040,7900,7900},
		[100]={100,50,25,10,5,},--翼魂增加属性
	},
	goods = { --技能书 对应 技能
		[1411] = {42,1,1,2}, --气血强化{type,lv,档次(1-4)
		[1412] = {43,1,2,2},
		[1413] = {44,1,3,2},
		[1414] = {45,1,4,2},
		[1415] = {46,1,nil,2},
		[1416] = {52,1,1,2}, 
		[1417] = {53,1,2,2},
		[1418] = {54,1,3,2},
		[1419] = {55,1,4,2},
		[1420] = {56,1,nil,2},
		[1421] = {67,1,1,4}, 
		[1422] = {68,1,2,4},
		[1423] = {69,1,3,4},
		[1424] = {70,1,4,4},
		[1425] = {71,1,nil,4},
		[1426] = {62,1,1,4}, 
		[1427] = {63,1,2,4},
		[1428] = {64,1,3,4},
		[1429] = {65,1,4,4},
		[1430] = {66,1,nil,4},
		[1431] = {57,1,1,6}, 
		[1432] = {58,1,2,6},
		[1433] = {59,1,3,6},
		[1434] = {60,1,4,6},
		[1435] = {61,1,nil,6},
		[1436] = {47,1,1,6}, 
		[1437] = {48,1,2,6},
		[1438] = {49,1,3,6},
		[1439] = {50,1,4,6},
		[1440] = {51,1,nil,6},
	},
	limit = {
		[42] = 11,
		[43] = 12,
		[44] = 13,
		[45] = 14,
		[46] = 15,
		[47] = 21,
		[48] = 22,
		[49] = 23,
		[50] = 24,
		[51] = 25,
		[52] = 31,
		[53] = 32,
		[54] = 33,
		[55] = 34,
		[56] = 35,
		[57] = 41,
		[58] = 42,
		[59] = 43,
		[60] = 44,
		[61] = 45,
		[62] = 51,
		[63] = 52,
		[64] = 53,
		[65] = 54,
		[66] = 55,
		[67] = 61,
		[68] = 62,
		[69] = 63,
		[70] = 64,
		[71] = 65,
	},
	up = { --技能升级道具配置
		--1升2 
		[1] = {{765,10}}, -- [档次] = ｛道具列表｝
		--2升3 
		[2] = {{765,20},{766,5}},
		--3升4 
		[3] = {{765,30},{766,10}},
		--4升5 
		[4] = {{765,50},{766,20}},

	},
	switch_conf = { 	--开光升级配置
		[1] =  function(level)  --hp
			return rint(level * 300 + (level ^ 2) / 5)
		end,
		[3] = function(level) --攻击
			return rint(level * 100 + (level ^ 2) /10)
		end,
		[4] = function(level) --防御
			return rint(level * 100 + (level ^ 2) /10)
		end,
		[7] = function(level) -- 暴击
			return rint(level * 50 + (level ^ 2) / 20)
		end,
		[9] = function(level) --格挡
			return rint(level * 50 + (level ^ 2) / 20)
		end,
		[100] = {  --天界之羽 id, 下一个开光进度所需道具数量
			[1] = 762, 
			[2] = function(level)
				return (30 + rint((level + 1) / 1.5))
			end,
			[3] = 10, --购买单价
		},
		[101] = { --鲲鹏之翼 id, 下一个开光进度所需道具数量
			[1] = 766,
			[2] =	function(level)
				return (1 + rint((level + 1) / 30))
			end,
		}
	},
}
--[[
3058 	2阶七彩羽毛	
3059 	3阶七彩羽毛	
3060 	4阶七彩羽毛	
3061 	5阶七彩羽毛	
3062 	6阶七彩羽毛
3068	7阶七彩羽毛
3069	8阶七彩羽毛
3070	9阶七彩羽毛
]]--
local wing_goodconf = {
	[3058] = 2,
	[3059] = 3,
	[3060] = 4,
	[3061] = 5,
	[3062] = 6,
	[3068] = 7,
	[3069] = 8,
	[3070] = 9,
}
--[[
翅膀数据
data = {
	[1] = 当前等级
	[2] = 本日幸运值
	[3] = 翼灵个数
	[4] = 翼魂个数
	[5] = 到期时间
	[6] = { --技能
		[1] = {技能ID,技能等级}
	},
	[7] = 当前形象 10000+lv 10000 普通翅膀 20000 特殊翅膀
	[8] = 解锁翅膀
	[9] = 开光进度
}
]]--
--获取翅膀数据					  
local function _get_wing_data(sid)
	if(sid == nil or sid == 0)then return end
	local wingdata = GI_GetPlayerData( sid , 'wing' , 250 )
	return wingdata
end
--请求别人的翅膀数据
function wing_get_other_date(sid,name,t,r)
	if(sid == nil and name~=nil)then
		sid = GetPlayer(name) or 0
	end
	if(not IsPlayerOnline(sid))then
		SendLuaMsg( 0, { ids = Wing_OtherDate, leave = 1 , t = t}, 9 )
		return
	end
	local wingdata=_get_wing_data(sid)
	if(r == nil)then
		SendLuaMsg( 0, { ids = Wing_OtherDate, data = wingdata , t = t}, 9 )
	else
		return wingdata
	end
end
--更新技能
local function _wing_update_att(sid,id,findid,bufflv,oldlv)
	local wingdata=_get_wing_data(sid)
	if(wingdata==nil or wingdata[1] == nil)then return end
	
	if(id == nil)then --更新属性
		local tempAtt=GetRWData(1)
		local lv = wingdata[1]
		local yl = wingdata[3] or 0
		local yh = wingdata[4] or 0
		local t = wingdata[5]
		local skill = wingdata[6]
		if(lv<=1 and t~=nil and GetServerTime()>t)then
			tempAtt[1]=0--气血
			tempAtt[3]=0--攻击
			tempAtt[4]=0--防御
			tempAtt[7]=0--防御
			tempAtt[9]=0--攻击
			PI_UpdateScriptAtt(sid,ScriptAttType.wing)
			CI_SetPlayerIcon(0,6,0,1)---外形设置
			return
		end
		
		--属性分成两个部分.. 10级前 10级后
		local f_lv = lv
		if lv > 10 then
			f_lv = 10
		end
		local attconf=wing_conf.att[f_lv]
		local addatt=wing_conf.att[100]
		tempAtt[1]=math_floor((attconf[1]+yh*addatt[1])*(yl*2+100)/100)--气血
		tempAtt[3]=math_floor((attconf[2]+yh*addatt[2])*(yl*2+100)/100)--攻击
		tempAtt[4]=math_floor((attconf[3]+yh*addatt[3])*(yl*2+100)/100)--防御
		tempAtt[7]=math_floor((attconf[4]+yh*addatt[4])*(yl*2+100)/100)--暴击
		tempAtt[9]=math_floor((attconf[5]+yh*addatt[5])*(yl*2+100)/100)--格挡
		
		--开光进度 换算战斗力
		local switch_proc = wingdata[9] or 0  
		local switch_conf = wing_conf.switch_conf
		tempAtt[1] = tempAtt[1] + switch_conf[1](switch_proc)
		tempAtt[3] = tempAtt[3] + switch_conf[3](switch_proc)
		tempAtt[4] = tempAtt[4] + switch_conf[4](switch_proc)
		tempAtt[7] = tempAtt[7] + switch_conf[7](switch_proc)
		tempAtt[9] = tempAtt[9] + switch_conf[9](switch_proc)
		
		PI_UpdateScriptAtt(sid,ScriptAttType.wing)
	else
		look('更新翅膀技能')
		look('移除翅膀技能='..id..','..findid..','..bufflv)
		if(oldlv~=nil)then look('oldlv='..oldlv) end
		local b=CI_UpdateBuffExtra(id,findid,bufflv,oldlv)
		look(b)
	end
end
--取翅膀各种信息 1 等级 2 幸运值 3 翼灵 4 翼魂 
function wing_get_info(sid,t)
	local wingdata=_get_wing_data(sid)
	if(wingdata==nil or wingdata[1]==nil)then return end
	local val = wingdata[t]
	if(val == nil)then val = 0 end
	return val
end
--取翅膀等级、战斗力公式
function wing_get_fpt(sid)
	local wingdata=_get_wing_data(sid)
	if(wingdata==nil or wingdata[1]==nil)then return 0,0 end
	local tempAtt=GetRWData(1)
	local lv = wingdata[1]
	local yl = wingdata[3] or 0
	local yh = wingdata[4] or 0
	
	--属性分成两个部分.. 10级前 10级后
	local f_lv = lv
	if lv > 10 then
		f_lv = 10
	end
	local attconf=wing_conf.att[f_lv]
	local addatt=wing_conf.att[100]
	tempAtt[1]=math_floor((attconf[1]+yh*addatt[1])*(yl*2+100)/100)--气血
	tempAtt[3]=math_floor((attconf[2]+yh*addatt[2])*(yl*2+100)/100)--攻击
	tempAtt[4]=math_floor((attconf[3]+yh*addatt[3])*(yl*2+100)/100)--防御
	tempAtt[7]=math_floor((attconf[4]+yh*addatt[4])*(yl*2+100)/100)--暴击
	tempAtt[9]=math_floor((attconf[5]+yh*addatt[5])*(yl*2+100)/100)--格挡
	
	--开光进度 换算战斗力
	local switch_proc = wingdata[9] or 0  
	local switch_conf = wing_conf.switch_conf
	tempAtt[1] = tempAtt[1] + switch_conf[1](switch_proc)
	tempAtt[3] = tempAtt[3] + switch_conf[3](switch_proc)
	tempAtt[4] = tempAtt[4] + switch_conf[4](switch_proc)
	tempAtt[7] = tempAtt[7] + switch_conf[7](switch_proc)
	tempAtt[9] = tempAtt[9] + switch_conf[9](switch_proc)
	
	local pt = math_floor(tempAtt[3]+tempAtt[4]+tempAtt[1]*0.2+(tempAtt[7]+tempAtt[9])*1.3)
	return lv,pt
end

--gm创建翅膀
function wing_cgm(sid, icon)
	local wingData=_get_wing_data(sid)
	if(wingData==nil)then return end
	if(wingData[1] == nil)then
		wingData[1] = 1
		wingData[5] = GetServerOpenTime() + (24*3600)
		wingData[7] = 10001
		if icon == nil then 
			icon = 1
		end
		CI_SetPlayerIcon(0,6,icon,1)---外形设置
		local tempAtt=GetRWData(1)
		local attconf=wing_conf.att[1]
		local addatt=wing_conf.att[100]
		tempAtt[1]=math_floor(attconf[1])--气血
		tempAtt[3]=math_floor(attconf[2])--攻击
		tempAtt[4]=math_floor(attconf[3])--防御
		tempAtt[7]=math_floor(attconf[4])--暴击
		tempAtt[9]=math_floor(attconf[5])--格挡
		PI_UpdateScriptAtt(sid,ScriptAttType.wing)
		SendLuaMsg( 0, { ids = Wing_Data, data = wingData, t = 0}, 9 )
	end
end
--删除翅膀
function wing_del(sid)
	--local icon = CI_GetPlayerIcon(0, 6)
	--look(icon)
	local wingData=_get_wing_data(sid)
	
	if(wingData~=nil and wingData[1]~=nil)then
		wingData[1] = nil
		wingData[2] = nil
		wingData[3] = nil
		wingData[4] = nil
		wingData[5] = nil
		wingData[6] = nil
		wingData[7] = nil
		wingData[9] = 0
		local tempAtt=GetRWData(1)
		tempAtt[1]=0--气血
		tempAtt[3]=0--攻击
		tempAtt[4]=0--防御
		tempAtt[7]=0--防御
		tempAtt[9]=0--攻击
		PI_UpdateScriptAtt(sid,ScriptAttType.wing)
		CI_SetPlayerIcon(0,6,0,1)---外形设置
		SendLuaMsg( 0, { ids = Wing_Data, data = wingData, t = 0}, 9 )
	end
end

--激活翅膀
function wing_create(sid)
	look('翅膀创建')
	local wingData=_get_wing_data(sid)
	if(wingData==nil)then return end
	if(wingData[1] == nil)then
		local svrTime = GetServerOpenTime() --开服时间
		local dt = osdate("*t", svrTime)
		local sec = GetTimeToSecond(dt.year,dt.month,dt.day,0,0,0)
		local now = GetServerTime()
		dt = osdate("*t", now)
		local sec1 = GetTimeToSecond(dt.year,dt.month,dt.day,0,0,0)
		local times = now - sec
		if(times>=(5*24*3600))then --第6天开放
			wingData[1] = 1
			wingData[5] = sec1 + (24*3600*2)
			wingData[7] = 10001
			CI_SetPlayerIcon(0,6,1,1)---外形设置
			local tempAtt=GetRWData(1)
			local attconf=wing_conf.att[1]
			local addatt=wing_conf.att[100]
			look('--------------5-----------')
			tempAtt[1]=math_floor(attconf[1])--气血
			tempAtt[3]=math_floor(attconf[2])--攻击
			tempAtt[4]=math_floor(attconf[3])--防御
			tempAtt[7]=math_floor(attconf[4])--暴击
			tempAtt[9]=math_floor(attconf[5])--格挡
			PI_UpdateScriptAtt(sid,ScriptAttType.wing)
			SendLuaMsg( 0, { ids = Wing_Data, data = wingData, t = 0}, 9 )
		end
	end
end

--翅膀每日重置
function wing_reset(sid,isref)
	if(IsSpanServer())then return end
	--look('翅膀每日重置')
	local wingData=_get_wing_data(sid)
	if(wingData==nil)then return end
	if(wingData[1] == nil)then
		local svrTime = GetServerOpenTime() --开服时间
		local dt = osdate("*t", svrTime)
		local sec = GetTimeToSecond(dt.year,dt.month,dt.day,0,0,0) or 0
		local now = GetServerTime()
		local times = now - sec
		if(times>=(5*24*3600))then --第6天开放
			SendLuaMsg( 0, { ids = Wing_Data, t = 0}, 9 )
		end
	else
		if(isref~=nil and wingData[1]>1 and wingData[2]~=nil)then
			wingData[2] = nil
		end
		if(wingData[1]>1)then
			if(wingData[5]~=nil)then
				wingData[5] = nil
			end
		elseif(wingData[5] and GetServerTime()>wingData[5])then
			local tempAtt=GetRWData(1)
			tempAtt[1]=0--气血
			tempAtt[3]=0--攻击
			tempAtt[4]=0--防御
			tempAtt[7]=0--防御
			tempAtt[9]=0--攻击
			PI_UpdateScriptAtt(sid,ScriptAttType.wing)
			CI_SetPlayerIcon(0,6,0,1)---外形设置
		end
		
		SendLuaMsg( 0, { ids = Wing_Data, data = wingData, t = 5}, 9 )
	end
end 

--翅膀等级
function wing_get_lv(sid)
	local wingdata = _get_wing_data(sid)
	if(wingdata==nil or wingdata[1] == nil) then 
		return 0
	else
		return wingdata[1]
	end
end

--翅膀属性加成
function wing_add_attribute(sid,tempbuff)
	if sid==nil then return end
	local wingdata = _get_wing_data(sid)
	if(wingdata==nil or wingdata[1] == nil) then return end
	
	local tempAtt=GetRWData(1)
	local lv = wingdata[1]
	local yl = wingdata[3] or 0
	local yh = wingdata[4] or 0
	local t = wingdata[5]
	local skill = wingdata[6]
	if(lv<=1 and t~=nil and GetServerTime()>t)then return end
	
	--属性分成两个部分.. 10级前 10级后
	local f_lv = lv
	if lv > 10 then
		f_lv = 10
	end
	local attconf=wing_conf.att[f_lv]
	local addatt=wing_conf.att[100]
	tempAtt[1]=math_floor((attconf[1]+yh*addatt[1])*(yl*2+100)/100)--气血
	tempAtt[3]=math_floor((attconf[2]+yh*addatt[2])*(yl*2+100)/100)--攻击
	tempAtt[4]=math_floor((attconf[3]+yh*addatt[3])*(yl*2+100)/100)--防御
	tempAtt[7]=math_floor((attconf[4]+yh*addatt[4])*(yl*2+100)/100)--暴击
	tempAtt[9]=math_floor((attconf[5]+yh*addatt[5])*(yl*2+100)/100)--格挡

	--开光进度 换算战斗力
	local switch_proc = wingdata[9] or 0  
	local switch_conf = wing_conf.switch_conf
	tempAtt[1] = tempAtt[1] + switch_conf[1](switch_proc)
	tempAtt[3] = tempAtt[3] + switch_conf[3](switch_proc)
	tempAtt[4] = tempAtt[4] + switch_conf[4](switch_proc)
	tempAtt[7] = tempAtt[7] + switch_conf[7](switch_proc)
	tempAtt[9] = tempAtt[9] + switch_conf[9](switch_proc)
	
	if(skill == nil)then return true end  --无技能
	--有技能
	local idx = 1
	for i=10,15 do
		if(skill[idx]~=nil)then
			tempbuff[i][1]=skill[idx][1] --id
			tempbuff[i][2]=skill[idx][2] --lv
		end
		idx = idx + 1
	end
	CI_SetPlayerIcon(0,6,lv,1)
	return true
end
--习得翅膀技能 技能ID 技能位
function wing_learn_skill(sid,goodid,pos)
	local wingdata = _get_wing_data(sid)
	if(wingdata==nil or wingdata[1] == nil) then return false,1 end --无翅膀数据
	
	local lv = wingdata[1]
	local yl = wingdata[3] or 0
	local yh = wingdata[4] or 0
	local t = wingdata[5]
	local skill = wingdata[6]
	
	if(lv<1)then return false,2 end --数据出错
	if(wing_conf.wing[lv] == nil or wing_conf.goods[goodid] == nil)then return false,3 end --配置出错
	if(skill~=nil and skill[pos]~=nil)then return false,4 end --技能位上有技能了
	if(pos>wing_conf.wing[lv].num)then return false,5 end --超过当前等级技能位上限
	
	if(CheckGoods(goodid,1,1,sid)==0)then return false,6 end --没有足够道具
	
	local curskillID = wing_conf.goods[goodid][1]
	local curskillLv = wing_conf.goods[goodid][2]
	local limitLv = wing_conf.goods[goodid][4]
	if(lv<limitLv)then return false,7 end
	
	if(skill == nil)then 
		wingdata[6] = {} 
		skill = wingdata[6]
	end
	
	skill[pos] = {curskillID,curskillLv}
	CheckGoods(goodid,1,0,sid,'学习翅膀技能')
	
	--这里添加更新技能的操作
	_wing_update_att(sid,curskillID,0,curskillLv)
	
	return true,wingdata,curskillID,curskillLv
end
--升级翅膀技能
function wing_up_skill(sid,curskillID,curskillLv,pos)
	local wingdata = _get_wing_data(sid)
	if(wingdata==nil or wingdata[1] == nil)then return false,1 end --无翅膀数据
	
	local skill = wingdata[6]
	if(skill == nil or skill[pos] == nil or skill[pos][1] ~= curskillID or skill[pos][2] ~= curskillLv)then return false,2 end --技能不存在
	local limitSkill = wing_conf.limit[curskillID]
	if(limitSkill==nil)then return false,4 end--技能配置出错
	if(math_floor(limitSkill%10)>=wing_conf.maxskLv)then return false,3 end --已达等级上限
	--if(curskillLv>=wing_conf.maxskLv)then return false,3 end --技能等级已达上限
	
	local goods = wing_conf.goods
	local quality --技能档次
	for gid,tb in pairs(goods) do
		if(type(tb) == type({}) and tb[1] == curskillID and tb[2] == curskillLv)then
			quality = tb[3]
			break
		end
	end
	if(quality == nil)then return false,3 end --已达等级上限
	local upgoods = wing_conf.up[quality]
	if(upgoods == nil)then return false,4 end --升级技能配置出错
	for _,v in pairs(upgoods) do
		if(type(v) == type({}))then
			if(CheckGoods(v[1],v[2],1,sid)==0)then return false,7 end --道具不足
		end
	end
	curskillID = curskillID + 1
	skill[pos][1] = curskillID
	--curskillLv = curskillLv + 1
	--skill[pos][2] = curskillLv
	for _,v in pairs(upgoods) do
		if(type(v) == type({}))then
			CheckGoods(v[1],v[2],0,sid,'翅膀技能升级')
		end
	end
	
	--这里添加更新技能的操作
	_wing_update_att(sid,curskillID,curskillID-1,1,1)
	
	return true,wingdata,curskillLv
end
--[[
遗忘/封印 技能 
tp 0 遗忘 1 封印 
pos 技能位置
skillid 技能ID（安全用）
skillLv 技能等级（安全用）
]]--
function wing_remove_skill(sid,tp,pos,skillid,lv)
	local wingdata = _get_wing_data(sid)
	if(wingdata==nil or wingdata[1] == nil)then return false,1 end --无翅膀数据
	
	local skill = wingdata[6]
	if(skill == nil or skill[pos] == nil or skill[pos][1] ~= skillid)then return false,2 end --技能不存在
	
	if(tp == 0)then -- 遗忘
		skill[pos] = nil
		local needpt = wing_conf.cost.lq
		if(needpt == nil or (not CheckCost(sid, needpt,1,3)))then return false,3 end --铜钱不足不足升级	
		skill[pos] = nil
		CheckCost(sid, needpt,0,3,'翅膀技能遗忘扣除铜钱')
		--AddPlayerPoints(sid,2, - needpt,nil,'翅膀技能遗忘扣除灵气',true)
	elseif(tp == 1)then -- 封印
		local neednum = wing_conf.cost.num[lv]
		local goodid = wing_conf.cost.goodid
		if(CheckGoods(goodid,neednum,1,sid)==0)then return false,4 end --没有足够道具
		local goods = wing_conf.goods
		local getGid --还原的技能书
		for gid,tb in pairs(goods) do
			if(tb~=nil and type(tb) == type({}))then
				if(tb[1] == skillid)then
					getGid = gid
					break
				end
			end
		end
		if(getGid==nil)then return false,5 end --没找到对应道具
		local pakagenum = isFullNum()
		if pakagenum < 1 then return false,6 end --背包空格不足
		GiveGoods(getGid,1,1,"翅膀技能封印")
		CheckGoods(goodid,neednum,0,sid)
		skill[pos] = nil
	end
	
	--这里添加更新技能的操作
	--look('移除翅膀技能'..skillid..','..lv)
	_wing_update_att(sid,0,skillid,0,1)
	
	return true,wingdata
end

local tempned={nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}---加的幸运点数

--升级翅膀
--sid人物ID
--ctype 进化类型 0 花道具 1 道具不足花元宝
--num	道具个数
--itype 不为空则，执行一次运算4次	
local function wing_up_old(sid,ctype,num1,itype)
	local wingdata = _get_wing_data(sid)
	if(wingdata == nil or wingdata[1] == nil)then return false,1 end --无翅膀数据
	
	local lv = wingdata[1]
	if(lv>=wing_conf.maxLv)then
		return false,2 --升阶到上限
	end
	
	local proc = wingdata[2] or 0
	local oldlv = lv
	
	for j=1,#tempned do
		tempned[j]=nil
	end
	local maxTime=1
	if itype~=nil then
		maxTime=20
	end
	
	local num
	local needs
	local goodid = wing_conf.upgoodid[1]
	local cost = wing_conf.upgoodid[2]
	local minV,maxV
	local luck,gate,rannum,errIdx
	local spend
	for i=1,maxTime do
		spend = 0
		num = num1
		needs = (lv+1)*2 - 2
		if(wing_conf.wing[lv]==nil)then return false,5 end --配置出错
		minV = wing_conf.wing[lv].minV
		maxV = wing_conf.wing[lv].maxV
		if(ctype == 0)then --只花道具
			if(CheckGoods(goodid,needs,1,sid)==0)then
				if(i == 1)then
					return false,3 --没有足够道具
				else
					errIdx = 3
					break
				end
			end
		else --道具不足扣元宝
			if(num<needs)then
				spend = (needs - num)*cost
				if(num>0 and CheckGoods(goodid,num,1,sid)==0)then
					if(i == 1)then
						return false,3 --没有足够道具
					else
						errIdx = 3
						break
					end
				end
				if(not CheckCost(sid, spend,1,1))then
					if(i == 1)then
						return false,4 --元宝不足
					else
						errIdx = 4
						break
					end
				end
			else
				if(CheckGoods(goodid,needs,1,sid)==0)then
					if(i == 1)then
						return false,3 --没有足够道具
					else
						errIdx = 3
						break
					end
				end
			end
		end
		
		--扣东西了
		if(spend>0)then --要扣元宝
			if(num>0)then
				CheckGoods(goodid,num,0,sid,'翅膀升级')
				num1 = 0
			end
			CheckCost(sid,spend,0,1,"翅膀升级")
		else
			CheckGoods(goodid,needs,0,sid,"翅膀升级")
			num1 = num1 - needs
			if(num1<0)then num1 = 0 end
		end
		
		luck = needs 
		tempned[i] = luck
		proc = proc + luck
		
		if(proc>minV)then --大于下限有机会成功
			if(proc>=maxV)then
				--大于上限必成功
				wingdata[2] = 0
				lv = lv + 1
				break
			else
				gate=math_ceil((proc-minV)/needs*3)
				rannum=math_random(1,100)
				if(gate>=rannum)then
					--成功
					wingdata[2] = 0
					lv = lv + 1
					if(lv == 2)then --目标达成：将神翼提升到2阶
						set_obj_pos(sid,4003)
					elseif(lv == 5)then --将神翼提升到5阶
						set_obj_pos(sid,5005)
					end
					break
				end
			end
		end
		wingdata[2] = proc
	end
	local isup
	if(oldlv<lv)then
		--升级了
		isup = lv
		wingdata[1] = lv
		wingdata[7] = 10000+lv
		_wing_update_att(sid)
		CI_SetPlayerIcon(0,6,lv,1)---外形设置
		--look('CI_SetPlayerIcon(0,6,lv)'..lv)
	end
	return true,wingdata,isup,errIdx,tempned
end

--开光翅膀 
local function wing_up_switch(sid, ctype, stype, num1, num2)
	--look("wing_up_switch----------------------------------1")
	local wingdata = _get_wing_data(sid)
	local lv = wingdata[1]
	if (lv < wing_conf.minSwitchLv) then
		return false, 4 --数据错乱 
	end
	--检查道具是否满足 并计算所需道具数量或元宝数量
	local item_first = wing_conf.switch_conf[100]
	local item_two = wing_conf.switch_conf[101]
	--pay_*  花费元宝 在CheckYB失败时 不扣除
	--item_* 计算消费   
	local pay_proc, pay_num1, pay_num2, pay_cost  = 0,0,0,0
	local item_proc, item_num1, item_num2, item_cost  = 0,0,0,0
	local proc,  tmp_num1,  tmp_num2, need_num1, need_num2, num, tmpNum, tmpCostYb
	
	tmp_num1 = num1 or 0
	tmp_num2 = num2 or 0
	proc = wingdata[9] or 0
	--是否一键升星
	if stype then 
		num  = ((rint(proc / 100) + 1) * 100 - proc) or 0
	else
		num = 1
	end

	local  index = 0
	for i = 1, num do
		index = i
		need_num1 = item_first[2](proc + item_proc + 1)
		need_num2 = item_two[2](proc + item_proc + 1)
		--物品1
		if  tmp_num1 >= need_num1  and tmp_num2 >= need_num2 then
			tmp_num1 = tmp_num1 - need_num1
			item_num1 = item_num1 + need_num1
			
			tmp_num2 = tmp_num2 - need_num2
			item_num2 = item_num2 + need_num2
			
			item_proc = item_proc + 1
		else
			break
		end
	end
	
	-------------------------------------------------------------------
	pay_proc = pay_proc + item_proc
	pay_num1 = pay_num1 + item_num1
	pay_num2 = pay_num2 + item_num2
	pay_cost = pay_cost + item_cost
	--look("proc "..proc.." addproc "..item_proc.." num1 "..item_num1.." num2 "..item_num2.." cost "..item_cost)
	item_proc, item_num1, item_num2, item_cost  = 0,0,0,0
	-------------------------------------------------------------------
	--[[
	if ctype  then --是否自动购买
		tmpNum = num - index or 0
		for i = 1,  tmpNum do
			need_num1 = item_first[2](proc + item_proc + pay_proc + 1)
			need_num2 = item_two[2](proc + item_proc  + pay_proc + 1)
			if tmp_num2 < need_num2 then
				break
			elseif tmp_num1 < need_num1 then
				need_num1 = need_num1 - tmp_num1
				tmpCostYb = item_cost + need_num1 * item_first[3]
				if not CheckCost(sid, tmpCostYb, 1, 1)  then
					break
				end
				item_num1 = item_num1 + tmp_num1
				item_num2 = item_num2 + need_num2
				item_cost = tmpCostYb
				item_proc = item_proc + 1
			end
		end
	end		
	-------------------------------------------------------------------
	pay_proc = pay_proc + item_proc
	pay_num1 = pay_num1 + item_num1
	pay_num2 = pay_num2 + item_num2
	pay_cost = pay_cost + item_cost
	-------------------------------------------------------------------
	look("proc "..proc.." addproc "..pay_proc.." num1 "..pay_num1.." num2 "..pay_num2.."  cost "..pay_cost)
	--]]
	if CheckGoods(item_first[1], pay_num1 , 1, sid) == 0 
			or CheckGoods(item_two[1], pay_num2 , 1, sid) == 0  then
			return false, 3 --道具不足
	end
	if not CheckCost(sid, pay_cost, 1, 1)  then
		return false, 5 --元宝不足
	end
	
	--扣除道具或元宝
	CheckGoods(item_two[1], pay_num2, 0, sid, "神翼开光") 
	if pay_num1 > 0 then
		CheckGoods(item_first[1], pay_num1, 0, sid, "神翼开光")
	end
	if pay_cost > 0 then
		CheckCost(sid, pay_cost, 0, 1, '神翼开光')
	end
	---进度加一
	proc = proc + pay_proc
	wingdata[9] = proc
	local oldlv = wingdata[1]
	local newLv = oldlv + rint(proc / 1000)
	--local icon = CI_GetPlayerIcon(0, 6)
	if oldlv < newLv then
		wingdata[1] = newLv
		wingdata[7] = 10000+newLv
		CI_SetPlayerIcon(0,6,newLv,1)---外形设置
	end
	--更新属性
	_wing_update_att(sid)
	return true,wingdata
end

--升级翅膀
--sid人物ID
--ctype 进化类型 0 花道具 1 道具不足花元宝
--num	天界之羽道具个数
--itype 不为空则，执行一次运算4次	
--stype 是否一键升阶(魔化用)
--num2 鲲鹏之翼道具个数
function wing_up_proc(sid,ctype,num1,itype, stype, num2)
	local wingdata = _get_wing_data(sid)
	if(wingdata == nil or wingdata[1] == nil)then return false,1 end --无翅膀数据
	--look("wing_up_proc----------------------------------2")
	--if type(ctype) ~= type(0) then return false end
	local lv = wingdata[1]
	if(lv>=wing_conf.maxLv)then
		return false,2 --升阶到上限
	end
	if (lv < wing_conf.minSwitchLv) then
		return wing_up_old(sid, ctype, num1, itype)
	else
		return wing_up_switch(sid, ctype, stype, num1, num2 )
	end
end

function temp_wing(sid)
	local wingdata = _get_wing_data(sid)
	if(wingdata~=nil and wingdata[1]~=nil)then
		local lv = wingdata[1]
		if(lv >= 2)then --目标达成：将神翼提升到2阶
			set_obj_pos(sid,4003)
		end
		if(lv >= 5)then --将神翼提升到5阶
			set_obj_pos(sid,5005)
		end
	end
end

--翼魂使用
function wing_use_yh(sid)
	local wingdata = _get_wing_data(sid)
	if(wingdata == nil or wingdata[1] == nil or wingdata[1]<1)then
		return 0
	end
	local lv = wingdata[1]
	local yh = wingdata[4] or 0
	if(wing_conf.wing[lv] == nil or wing_conf.wing[lv].yh == nil)then
		return 0
	end
	
	local maxnum = wing_conf.wing[lv].yh
	if(yh>=maxnum)then return 0 end
	
	if(wingdata[4] == nil)then wingdata[4] = 0 end
	wingdata[4] = wingdata[4] + 1
	_wing_update_att(sid)
	SendLuaMsg(0,{ids=Wing_HLUpdate,yh=wingdata[4]},9)
end

--翼灵使用
function wing_use_yl(sid)
	local wingdata = _get_wing_data(sid)
	if(wingdata == nil or wingdata[1] == nil or wingdata[1]<1)then
		return 0
	end
	local lv = wingdata[1]
	local yl = wingdata[3] or 0
	
	if(wing_conf.wing[lv] == nil or wing_conf.wing[lv].yl == nil)then
		return 0
	end
	
	local maxnum = wing_conf.wing[lv].yl
	if(yl>=maxnum)then return 0 end

	if(wingdata[3] == nil)then wingdata[3] = 0 end
	wingdata[3] = wingdata[3] + 1
	_wing_update_att(sid)
	SendLuaMsg(0,{ids=Wing_HLUpdate,yl=wingdata[3]},9)
end

--使用道具加幸运值
function wing_use_item(sid,goodid)
	local goodlv = wing_goodconf[goodid]
	if(goodlv==nil)then return false,0 end --不是神翼相应道具
	local wingdata=_get_wing_data(sid)
	if(wingdata==nil or wingdata[1] == nil)then return false,1 end --神翼尚未激活
	local lv = wingdata[1]
	if(lv>=wing_conf.maxLv)then return false,3 end --神翼已達最高等級
	if(lv<goodlv)then return false,2 end 
	if(wing_conf.wing[lv] == nil or wing_conf.wing[lv].maxV == nil)then return false,4 end  --配置出错
	local maxV = wing_conf.wing[lv].maxV
	if(lv==goodlv)then
		rate = 0.15
	else
		rate = 0.01
	end
	local addLuck = math_floor(maxV * rate)
	local curLuck = wingdata[2] or 0
	if(curLuck>=maxV)then return false,5 end --幸运值已满
	if(wingdata[2]~=nil)then
		wingdata[2] = wingdata[2] + addLuck
	else
		wingdata[2] = addLuck
	end
	SendLuaMsg( 0, { ids = Wing_Data, data = wingdata, t = 6, add = addLuck}, 9 )
	return true
end

