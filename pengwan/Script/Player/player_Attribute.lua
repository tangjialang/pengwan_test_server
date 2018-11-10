--[[
file:	player_attribute.lua
desc:	player attribute update
author:	wk
update:	2013-06-01
refix:	done by wk
]]--
--[[
	CAT_MAX_HP		= 1,		// 血量上限
	CAT_S_ATC  		= 2,		// 职业攻击
	CAT_ATC  		= 3,		// 攻击
	CAT_DEF			= 4,		// 防御
	CAT_HIT  		= 5,		// 命中
	CAT_DUCK  		= 6,		// 闪避
	CAT_CRIT		= 7,		// 暴击
	CAT_RESIST		= 8,		// 抵抗
	CAT_BLOCK	  	= 9,		// 格挡
	CAT_S_DEF1	  	= 10,		// 火系抗击
	CAT_S_DEF2	  	= 11,		// 冰系抗击
	CAT_S_DEF3	  	= 12,		// 木系抗击
	CAT_MoveSpeed 	= 13,		// 移动速度(预留)
	CAT_S_REDUCE	= 14,		// 抗性减免

]]--

--[[
	脚本功能索引：
	1. 坐骑
	2.封神榜
	3. 随从
	4.骑兵
	5.翅膀
	6.丹药
	7. 称号
	8. 战斗法宝
	9. 护身法宝
	10.神创
	11. 女仆
	12. 经脉
	13.时装
	14.结婚戒指
	15.威望等级
	22. 帮会神兵
]]--
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local attlookres		 = msgh_s2c_def[15][18]

ScriptAttType = { ------------传入c++时为0-9,减1
	Mounts = 1,
	card = 2,--封神榜
	heros2 = 3,
	sowar = 4,
	wing = 5,--翅膀
	danyao = 6,
	Title = 7,	
	FitTalisman = 8,
	DefTalisman = 9,
	xiangmolu = 10,--神创天下
	nvpu=11,
	jingmai=12,
	shizhuang=13,
	marry=14,--婚戒
	prestige=15,--威望等级
	Faction = 16,
	yuanshen = 17,--元神
	lianshen = 18,--炼神
	wuzhuang = 19, --武装
	fabao    = 20, --本命法宝
	ysfs  = 21,   --元神
	fasb  = 22,  -- 帮会神兵 
	dragon = 23, --龙脉系统
	jiezhi = 24, --傲视戒指
}

local look = look
local CI_UpdateScriptAtt,CI_UpdateBuffExtra = CI_UpdateScriptAtt,CI_UpdateBuffExtra
local attnum = 14
local card_=require("Script.card.card_func")
local card_upatt=card_.card_upatt
local wuzhuang = require('Script.wuzhuang.wuzhuang_fun')
local wz_attup = wuzhuang.wz_attup
local fabao = require('Script.fabao.fabao_fun')
local fb_attup = fabao.fb_attup
local fasb = require('Script.ShenBing.faction_func')
local fasb_att = fasb.fasb_att
local dragon = require('Script.ShenBing.dragon_func')
local dragon_get_attup = dragon.dragon_get_attup
local shq_m = require('Script.ShenQi.shenqi_func')
local login_get_attup =  shq_m.login_get_attup

--1-5为法宝,6-9为骑兵 10-15为翅膀 16为封神触发技能197
local uv_tempbuff={{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0}}
local ScriptAttType = ScriptAttType
--[[
	CI_UpdateBuffExtra 更新攻防附带buff
参数： 
	--初始化格式{{id,level},{},{}}
	--更新格式(id,checkid,bufflv,checklv)
	取下技能id=0,checkid=checkid,bufflv=0,checklv=0
	新加技能id=id,checkid=0,bufflv=bufflv,checklv=0
	更新技能id=0,checkid=checkid,bufflv=bufflv,checklv=0
	

	
]]--


--[[
	CI_UpdateScriptAtt 更新脚本附加二级属性
参数：
	1属性table：二级表{ [功能编号]={[属性编号]=value}}
	2是否是初始化 0 不是初始化 1 初始化
	3更新值的类型： 1累加方式 2 重置方式（不支持减）
	4功能类型:
	
]]--
function PI_UpdateScriptAtt(sid,itype, object)
	local val=2
	if itype == 7 then
		val = 1
	end	
	local atttab = GetRWData(1,true)
	local res
	-- look('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$')
	 -- look(atttab,1)
	if not object then
		res= CI_UpdateScriptAtt(atttab,0,val,itype-1)
	else
		res=CI_UpdateScriptAtt(atttab,0,val,itype-1,object,sid)--丢失对象时用,如降魔录
	end

	-- debug --

	if __debug then
		for i=1 ,attnum do
			if atttab[i]~=nil then
				look('[debug]CI_UpdateScriptAtt not set nil',1)
				atttab[i]=nil
			end
		end
	end
	return res
end

-- 初始化所有脚本添加属性
function GI_SetScriptAttr(sid)

	for i=1 ,#uv_tempbuff do
		uv_tempbuff[i][1]=0
		uv_tempbuff[i][2]=0
	end
	
	local atttab=GetRWData(1)
	local res
	-- 1、添加称号属性(累加)
	res = GetTitleAttr(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,1,ScriptAttType.Title-1)
	end
	-- 2、护身法宝
	res = yystart_GetAttribute(sid,uv_tempbuff)--uv_tempbuff没用
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.DefTalisman-1)
	end
	-- 3、战斗法宝
	res = BATTAttribute(sid,uv_tempbuff)--uv_tempbuff用了1-5位
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.FitTalisman-1)
	end
	--4 .骑兵
	res =  sowar_Attribute(sid,uv_tempbuff)--uv_tempbuff用了6-9位
	if res then
		local a=CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.sowar-1)
		-- look(a)
	end
	-- 0、坐骑
	res = LoginMountsAtt(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.Mounts-1)
	end
	-- 5 翅膀
	res = wing_add_attribute(sid,uv_tempbuff)--uv_tempbuff用了10-15位
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.wing-1)
	end
	--6丹药
	res = dy_Attribute(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.danyao-1)
	end
	--9 .神创
	res =  XML_GetAttribute(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.xiangmolu-1)
	end
	--7.卡牌
	res = card_upatt(sid,nil,uv_tempbuff)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.card-1)
	end
	--女仆
	res = np_attup(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.nvpu-1)
	end
	--经脉
	res = AddRWAttvalue(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.jingmai-1)
	end
	--时装
	res = add_loginatt(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.shizhuang-1)
	end
	--婚戒
	res = marry_attup(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.marry-1)
	end
	
	--帮会技能等级
	res = facskill_attup(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.Faction-1)
	end
	
	--威望等级
	res = prestige_attup(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.prestige-1)
	end

		
	--元神
	res = yuanshen_attribute(sid,1)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.yuanshen-1)
	end	
	
	--元神分身
	res = ysfs_attribute(sid,1)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.ysfs-1)
	end	
	--炼神
	res = ls_attup(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.lianshen-1)
	end	
	--元神武装
	res = wz_attup(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.wuzhuang-1)
	end
	--本命法宝
	res = fb_attup(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.fabao-1)
	end
	--法宝神兵
	res = fasb_att(sid, 1)
	if res then 
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.fasb-1)
	end
	--龙脉系统
	res = dragon_get_attup(sid)
	if res then 
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.dragon-1)
	end
	--戒指
	res = login_get_attup(sid)
	if res then 
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.jiezhi-1)
	end
	-- 8、更新攻防buff
	CI_UpdateBuffExtra(uv_tempbuff)
	-- look('8、更新攻防buff',1)
	-- look(uv_tempbuff,1)
end

--战斗力对比,itype=1主角,2装备
--1
-- 1女仆
-- 2守护通灵
-- 3修神诀
-- 4神创天下
-- 5称号加成
-- 6属性丹
-- 7封神卡牌

--2
-- 1宝石纯化
-- 2时装

local att_1={0,0,0,0,0,0,0}
local att_2={0,0}
function att_look( osid,itype )

	if IsPlayerOnline(osid) ~= true then
		TipCenter(GetStringMsg(7))
		return 
	end

	local atttab=GetRWData(1)
	local res

	if itype==1 then
		for k,v in pairs(att_1) do
			att_1[k]=0
		end
		--1女仆
		res = np_attup(osid)
		if res then
			att_1[1]=get_fightvalue( atttab )
		end
		-- 2、护身法宝
		res = yystart_GetAttribute(osid)
		if res then
			att_1[2]=get_fightvalue( atttab )
		end
		--3经脉
		res = AddRWAttvalue(osid)
		if res then
			att_1[3]=get_fightvalue( atttab )
		end
		--4神创
		res =  XML_GetAttribute(osid)
		if res then
			att_1[4]=get_fightvalue( atttab )
		end
		-- 5添加称号属性(累加)
		res = GetTitleAttr(osid)
		if res then
			att_1[5]=get_fightvalue( atttab )
		end
		--6丹药
		res = dy_Attribute(osid)
		if res then
			att_1[6]=get_fightvalue( atttab )
		end
		--7.卡牌
		res = card_upatt(osid)
		if res then
			att_1[7]=get_fightvalue( atttab )
		end
		SendLuaMsg( 0, { ids=attlookres,res=att_1, itype=itype }, 9 )	

	elseif itype==2 then
		for k,v in pairs(att_2) do
			att_2[k]=0
		end
		--1宝石纯化
		res = purify_getlv( playerid)
		if res then---纯化为后台传数值,前台算等级及战斗力
			att_2[1]=res
		end
		--2时装
		res = add_loginatt(osid)
		if res then
			att_2[2]=get_fightvalue( atttab )

		end
		SendLuaMsg( 0, { ids=attlookres,res=att_2, itype=itype }, 9 )	
	end
end