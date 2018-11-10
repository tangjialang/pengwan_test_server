--[[
file:	XML_func.lua
desc:	降魔录系统
author:	wk
update:	2013-3-29
refix:	done by wk
]]--		
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local sctx_arise	 = msgh_s2c_def[33][1]
local sctx_succend	 	= msgh_s2c_def[33][2]
local sctx_fail		 = msgh_s2c_def[33][3]
local sctx_info	     = msgh_s2c_def[33][4]
local sctx_award	= msgh_s2c_def[33][5]
local TimesTypeTb = TimesTypeTb
local common 		 = require('Script.common.Log')
local Log 			 = common.Log
local active_mgr_m = require('Script.active.active_mgr')
local active_sctx = active_mgr_m.active_sctx
local look = look
local ScriptAttType = ScriptAttType
local pairs,type = pairs,type
local TipCenterEx=TipCenterEx
local CreatSelectRelive=CI_OnSelectRelive
local PI_UpeObjectIndirect=CreateObjectIndirect
local CI_OndateScriptAtt=PI_UpdateScriptAtt
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos
local CI_SetPlayerIcon=CI_SetPlayerIcon
local GetServerTime =GetServerTime
----------------------------------
local uv_XML_conf=sctx_conf
local checklv_conf=sctx_conf.checklv_conf --大关等级限制

local cdtime=8*60

--定义玩家降魔录数据区
function sctx_getdbdata( playerid )--玩家数据下定义YY功能区
	local sctx_data=GI_GetPlayerData( playerid , 'sctx' , 50 )
	if sctx_data == nil then return end
		-- if sctx_data[1]==nil then
			-- sctx_data[1]=50----普通关数
			-- sctx_data[2]=55555--普通冷却(能打时间)
			-- sctx_data[3]=15----英雄关数
			-- sctx_data[4]=66666--英雄冷却
			-- sctx_data[5]=3--今日领奖(3代表领了3关,过了4关时再领可给4关奖励)
			--pdata[6]=fbid
		-- end
	return sctx_data
end

--定义世界数据	
local function sctx_getworlddata()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then
		return
	end
	if w_customdata.sctx == nil then
		w_customdata.sctx = {
			[1] = {},	-- 普通关过关人物信息{{name,sex,act},{name,sex,act},}
			[2] = {},	-- 英雄关过关人物信息
		}
	end
	return w_customdata.sctx
end
--更新世界数据
local function sctx_upworlddata( itype,num,playerid )
	-- look('更新世界数据')
	local wdata=sctx_getworlddata()
	local passdata=wdata[itype]
	if passdata==nil then return end
	if passdata[num]==nil then 
		passdata[num]={}
	end
	local info=passdata[num]

	local name=CI_GetPlayerData(3)
	local sex=CI_GetPlayerData(11)
	local act=CI_GetPlayerData(10)--攻击
	-- look(name)
	-- look(sex)
	-- look(act)
	if info[1]==nil then 
		info[1]={}
	end
	if info[1][1]~=nil then 
		if info[2]==nil then 
			info[2]={}
		end
		info[2][1]=info[1][1]
		info[2][2]=info[1][2]
		info[2][3]=info[1][3]
	end
	info[1][1]=name
	info[1][2]=sex
	info[1][3]=act
end
--判断进入副本条件--itype=1普通,2英雄
local function Check_condition(playerid,num,itype)
		-- look('判断进入副本条件')
	local pdata=sctx_getdbdata( playerid )
	if pdata==nil then return end
	local now=GetServerTime()
	if itype==1 then 
		local needlv=checklv_conf[math.ceil(num/9)]
		local lv=CI_GetPlayerData(1)
		if lv<needlv then return end
		if num-1~=(pdata[1] or 0) then --关数
			return 
		end
		if now<(pdata[2] or 0) then --时间
			return 
		end
	elseif itype==2 then 
		if (pdata[1] or 0)<18 then --英雄模式的第一关，需要先过关普通模式的第二层的第9关，才能挑战
			return
		end
		if num-1~=(pdata[3] or 0) then --关数
			return 
		end
		if now<(pdata[4] or 0) then --时间
			return 
		end
	else
		return
	end

	return true
end

--------------------------------------------------------------
--进入副本-- 第几关,类型(普通1,英雄2)
function sctx_enter(playerid,fbid)
	local pdata=sctx_getdbdata( playerid )
	if pdata==nil then return end
	local itype=rint(fbid/1000)-6
	local num=fbid%1000
	if not Check_condition(playerid,num,itype) then --检查条件
		look('tiaojianbuzu')
		return false
	end
	-- local school = CI_GetPlayerData(2)
	-- if 	school==1 then
	-- 		CI_DelBuff(226)
	-- elseif 	school==2 then
	-- 		CI_DelBuff(227)
	-- elseif 	school==3 then
	-- 		CI_DelBuff(228)
	-- end
	pdata[6]=fbid
	return true
end


--时间到判断失败
function sctx_endfail(playerid)
	look('切换地图回调')
	-- look(debug.traceback())
	
	local pdata=sctx_getdbdata( playerid )
	if pdata==nil then return end
	if pdata[6]==nil then return end 

	local fbid=pdata[6]
	local itype=rint(fbid/1000)-6
	local num=fbid%1000

	local now=GetServerTime()+cdtime
	if itype==1 then 
		if num<10 then --前9关不做处理
			SendLuaMsg( playerid, { ids=sctx_fail,itype=itype,num=num}, 10 )
			return
		end
		pdata[2]=now		--时间到,中途突出等失败加cd
	else
		pdata[4]=now
	end
	SendLuaMsg( playerid, { ids=sctx_fail,time=now,itype=itype,num=num}, 10 )
end
--boss死亡回调--通关成功
--call_monster_dead[4201]=function ()

function sctx_succ(playerid,fbid)
	local playerid = CI_GetPlayerData(17)
	local pdata=sctx_getdbdata( playerid )

	local itype=rint(fbid/1000)-6
	local num=fbid%1000

	if itype==1 then 
		pdata[1]=num
		pdata[2]=nil
		local a=CI_SetPlayerIcon(0,4,num,1,2,playerid)--设置称号
		if pdata[1]==9 then
			set_obj_pos(playerid,2004)
		end
		if num%9==0 then 
			BroadcastRPC('sctx_rpcall',CI_GetPlayerData(3),num)
		end
	else
		pdata[3]=num
		pdata[4]=nil
	end
	
	SendLuaMsg( playerid, { ids=sctx_succend,num=num,itype=itype}, 10 )

	XML_GetAttribute(playerid,1)	--人物属性更新
	--sctx_getgoods( itype,num )--道具奖励
	sctx_upworlddata( itype,num ,playerid)--更新世界数据
	pdata[6]=nil
end
--请求通关玩家数据
function sctx_getsuccdata(num,itype )
		-- look('请求通关玩家数据')
	local wdata=sctx_getworlddata()
	local passdata=wdata[itype]
	if passdata==nil then return end
	local info=passdata[num]
	--local info={{'二狗',100},{'旺财',111}}
	SendLuaMsg( 0, { ids=sctx_info,num=num,itype=itype,info=info}, 9 )
end

--领奖
function sctx_getaward( playerid )
	look('领奖')
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return 
	end

	local pdata=sctx_getdbdata( playerid )
	if pdata==nil then return end
	local canget=(pdata[1] or 0)
	if canget==0 then return end
	local nowget=pdata[5] or 0

	if canget>50 then 
		canget=50
	end
	
	if nowget>=50 then 
		TipCenter(GetStringMsg(456))
		return 
	end

	if canget<=nowget then return end
	local num=canget-nowget
	pdata[5] =canget
	GiveGoods(690,num,1,'神创天下每日奖励')
	SendLuaMsg( 0, { ids=sctx_award,num=canget}, 9 )
	CheckTimes(playerid,TimesTypeTb.SC_award,1)	
end

--领奖数据清空
function sctx_reset_award( playerid )
	local pdata=sctx_getdbdata( playerid )
	if pdata==nil then return end
	pdata[5]=nil
	SendLuaMsg( 0, { ids=sctx_award,num=0}, 9 )
end

--人物属性更新
function XML_GetAttribute(playerid,itype)	
	--look('人物属性更新')
	local pdata=sctx_getdbdata( playerid )
	if pdata==nil then return end
	local AttTable =GetRWData(1)

	local common_num=pdata[1] --普通
	if common_num==nil then return end
	if uv_XML_conf[1][common_num]==nil then return end
	local common_conf=uv_XML_conf[1][common_num].Award
	for k,v in pairs(common_conf) do
	 	if type(k)==type(0) and type(v)==type(0) then	
	 		AttTable[k]=(AttTable[k] or 0)+v
	 	end
	end

	local hero_num=pdata[3] --英雄
	if hero_num then 
		local hero_conf=uv_XML_conf[2][hero_num].Award
		look('英雄')
		look(hero_conf)
		for m,n in pairs(hero_conf) do
	 		if type(m)==type(0) and type(n)==type(0) then	
	 			AttTable[m]=(AttTable[m] or 0)+n
	 		end
	 	end
	end

	if itype==1 then --通关更新
		 PI_UpdateScriptAtt(playerid,ScriptAttType.xiangmolu,2)--  更新脚本增加的玩家属性
	end
	return true
end

----测试
--设置等级
function sc_setlv( playerid ,num)
	local pdata=sctx_getdbdata( playerid )
	pdata[1]=num
	SendLuaMsg( playerid, { ids=sctx_succend,num=num,itype=1}, 10 )
	XML_GetAttribute(playerid,1)	--人物属性更新
	sctx_upworlddata( 1,num ,playerid)--更新世界数据
	pdata[6]=nil
end