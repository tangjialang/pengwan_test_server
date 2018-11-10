--[[
file:	batt_gem.lua
desc:	战斗法宝系统
author:	wk
update:	2012-1-16
refix:	done by wk
]]--

local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local BTerror	 = msgh_s2c_def[20][1]	
local BT_Update=msgh_s2c_def[20][2]	
local up_btdatda	 = msgh_s2c_def[20][3]	
local BT_see	 = msgh_s2c_def[20][4]	
local b_akill	 = msgh_s2c_def[20][7]	
local b_h	 = msgh_s2c_def[20][8]	
local b_reset	 = msgh_s2c_def[20][15]	
local CI_UpdateBuffExtra=CI_UpdateBuffExtra
local CI_GetPlayerData=CI_GetPlayerData
local PI_UpdateScriptAtt=PI_UpdateScriptAtt
local _insert=table.insert
local GetRWData=GetRWData
local rint=rint
local look = look
local ScriptAttType = ScriptAttType
local pairs=pairs
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos
local CI_SetPlayerIcon=CI_SetPlayerIcon
local Gambuchang = MailConfig.Gambuchang
local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond
local GetDiffDayFromTime=common_time.GetDiffDayFromTime


local tempexp={0,0,0,0,0,0,0,0,0,0,0,0}---进阶到下一阶得到经验
local needid={
	634,--升级使用先天之灵
	772,--突破使用女神之泪
	771,--幸运符
}
local maxlv = 150   --等級上限
local attbase={20,4,3.2,3}--属性基础值 气血	攻击	闪避	抵抗

local skill_goodsid={732,733,734,735,736,736}--骑兵技能升级所需道具d,6级需要5个736
local addatt={500,100,50,25,}--兵魂增加属性
local skillconf={30,31,32,33,34,35}--技能id,35为被动技能
local max_ql={[5]=10,[6]=20,[7]=30,[8]=40,[9]=100,[10]=100,[11]=100,[12]=100,[13]=100,[14]=100,[15]=100}--器灵使用最大个数
local max_qh = 600
--祝福丹当等级高于丹药时加的经验值,以祝福丹阶数为key
local  gem_zfconf={
	[2]=110,
	[3]=200,
	[4]=300,
	[5]=400,
	[6]=500,
	[7]=600,
	[8]=700,
	[9]=800,
}

local batlv_conf={
	--成功率公式相关
	arg1=0.055,
	arg2={
		[1]=0.95,
		[2]=0.8,
		[3]=0.7,
		[4]=0.65,
		[5]=0.6,
		[6]=0.58,
		[7]=0.57,
		[8]=0.56,
		[9]=0.55,
		[10]=0.5,
		[11]=0.5,
		[12]=0.5,
		[13]=0.5,
		[14]=0.5,
		[15]=0.5,
	},
	---幸运值相关,最低,最高,升星保底最小值,升星保底最大值(全为道具使用个数)
	xingyun={
		[1]={1,3,12,25},
		[2]={5,10,60,100},
		[3]={20,30,200,300},
		[4]={40,60,400,600},
		[5]={70,100,800,1200},
		[6]={100,140,1500,2000},
		[7]={120,160,2000,3000},
		[8]={140,180,2800,4000},
		[9]={160,200,3600,5000},
		[10]={200,240,5000,8000},
		[11]={300,350,10000,15000},
		[12]={500,600,30000,40000},
		[13]={600,700,40000,50000},
		[14]={700,800,50000,60000},
		[15]={900,1000,60000,70000},
	},
}


function GetDBBATTGEMData(playerid)
	local batdata=GI_GetPlayerData( playerid , 'batt' , 70 )
	if batdata == nil then return end
	--[[
		[1]={[1]={}}---以前数据,生效的最大等级
		[2]=2,法魂
		[3]=4,法灵
		[4]={2,2,1},技能等级
		[5]=2,实际等级
		[6]=4,幸运值

		[7]=10000,每日可获得失败返还经验最大值
		[8]=4,升星道具使用个数,升星保底用
		[10]=nil,补偿标识,为true时为补偿过
	]]--
	return batdata
end



--更新单个法宝属性
local function BATTAttributeone(playerid,id,findid,bufflv)	
	
	if playerid==nil  then
		return
	end
	if  id==nil or id<1 then --更新属性

		local batdata=GetDBBATTGEMData(playerid)
		if batdata==nil or batdata[1] ==nil then 
			look("Getsowar_getdatarror")
			return
		end
		local tempAtt=GetRWData(1)

		local lv=batdata[1][1]
		local add=batdata[2] or 0
		local bili=batdata[3] or 0

		tempAtt[1]=rint((lv^(20/12)*attbase[1]+add*addatt[1])*(bili*2+100)/100)--气血
		tempAtt[3]=rint((lv^(20/12)*attbase[2]+add*addatt[2])*(bili*2+100)/100)--攻击
		tempAtt[4]=rint((lv^(20/12)*attbase[3]+add*addatt[3])*(bili*2+100)/100)--防御
		tempAtt[7]=rint((lv^(20/12)*attbase[4]+add*addatt[4])*(bili*2+100)/100)--暴击
		

		local a=PI_UpdateScriptAtt(playerid,ScriptAttType.FitTalisman)
	else --更新技能
		-- look('更新技能')
		local b=CI_UpdateBuffExtra(id,findid,bufflv,0)
		-- look(b)
	end

end

--初始化属性更新
function BATTAttribute(playerid,tempbuff)	
	if playerid==nil  then
		look("playeriderror")
		return
	end
	local batdata=GetDBBATTGEMData(playerid)
	if batdata==nil or batdata[1] ==nil then 
		--look("GetDBBATTGEMDataerror")
		return
	end
	local tempAtt=GetRWData(1)
	if batdata[1]==nil then return end
	local lv=batdata[1][1]
	local add=batdata[2] or 0
	local bili=batdata[3] or 0

	tempAtt[1]=rint((lv^(20/12)*attbase[1]+add*addatt[1])*(bili*2+100)/100)--气血
	tempAtt[3]=rint((lv^(20/12)*attbase[2]+add*addatt[2])*(bili*2+100)/100)--攻击
	tempAtt[4]=rint((lv^(20/12)*attbase[3]+add*addatt[3])*(bili*2+100)/100)--防御
	tempAtt[7]=rint((lv^(20/12)*attbase[4]+add*addatt[4])*(bili*2+100)/100)--暴击


	if batdata[4]==nil  then return true end  --无技能
	--有技能
	
	local tempa=1
	for i=1,4 do ---12345为骑兵buff,1排最后
		if  batdata[4][i+1] ~=nil then 
			tempbuff[tempa][1]=skillconf[i+1] --id
			tempbuff[tempa][2]=batdata[4][i+1] --lv
			tempa=tempa+1
		end
	end
	if batdata[4][1] ~=nil then 
		tempbuff[tempa][1]=skillconf[1]--id
		tempbuff[tempa][2]=batdata[4][1] --lv
	end

	local oldlv=CI_GetSkillLevel(4,skillconf[6])
	if oldlv<20 and oldlv>0 then
		CI_SetSkillLevel(4,skillconf[6],oldlv*16)
	end

	return true
end
-- --初始化个职业法宝
-- local function batbegin( playerid )
-- 	look('初始化个职业法宝',1)
-- 	local batdata=GetDBBATTGEMData(playerid)
-- 	if batdata==nil then 
-- 		look("GetDBBATTGEMDataerror")
-- 		return
-- 	end

-- 	local svrTime = GetServerOpenTime() or 0 --开服时间
-- 	local kftime=GetDiffDayFromTime(svrTime)+1--开服多久,天数
-- 	if kftime<4 then 
-- 		return
-- 	end
-- 	if batdata[1]==nil then
-- 		batdata[1]={1}--第1个法宝等级，经验
-- 		batdata[7]=10000000
-- 		BATTAttributeone(playerid)	
-- 	end
-- end

 --初始化面板,请求开始法宝 
 function firstbatt(playerid)
 	if IsSpanServer() then
   		return
   	end
	if playerid==nil  then
		look("dataerror")
		return
	end
	local batdata=GetDBBATTGEMData(playerid)
	if batdata==nil then 
		look("GetDBBATTGEMDataerror")
		return
	end
	-- local level = CI_GetPlayerData(1)

	local svrTime = GetServerOpenTime() or 0 --开服时间
	local kftime=GetDiffDayFromTime(svrTime)+1--开服多久,天数
	if kftime<4 then 
		return
	end

	if batdata[1]==nil then
		batdata[1]={1}--第1个法宝等级，经验
		batdata[7]=10000000
		BATTAttributeone(playerid)	
	end
	SendLuaMsg(0,{ids=BT_Update,btdata=batdata},9)
 end
 --查看面板
 function firstbatt_look(sid,name,itype,s)

	local isonline=true
	if type(sid)~=type(0) or sid<1 then
		sid=GetPlayer(name, 0)
		if sid==nil or sid<1 then 
			isonline=false
		end
	end
	if type(name)~=type('') then
		name=CI_GetPlayerData(5,2,sid)
		if type(name)~=type('') then 
			isonline=false
		end
	end
	if not isonline then 
		SendLuaMsg(0,{ids=BT_see,leave = 1},9)
		return
	end
	local batdata=GetDBBATTGEMData(sid)
	SendLuaMsg(0,{ids=BT_see,name=name,itype=itype,data=batdata,s=s},9)
	-- look('查看面板2222')
 end
 
--得到战斗法宝战斗力总分
function BATT_Getallscore(playerid)
	if playerid==nil  then
		look("playeriderror")
		return
	end
	local batdata=GetDBBATTGEMData(playerid)
	if batdata==nil or batdata[1] ==nil then 
		--look("GetDBBATTGEMDataerror")
		return
	end
	local tempAtt=GetRWData(1)
	if batdata[1]==nil then return end
	local lv=batdata[1][1]
	local add=batdata[2] or 0
	local bili=batdata[3] or 0

	tempAtt[1]=rint((lv^(20/12)*attbase[1]+add*addatt[1])*(bili*2+100)/100)--气血
	tempAtt[3]=rint((lv^(20/12)*attbase[2]+add*addatt[2])*(bili*2+100)/100)--攻击
	tempAtt[4]=rint((lv^(20/12)*attbase[3]+add*addatt[3])*(bili*2+100)/100)--防御
	tempAtt[7]=rint((lv^(20/12)*attbase[4]+add*addatt[4])*(bili*2+100)/100)--暴击
	--look(tempAtt)
	local res=get_fightvalue(tempAtt)
	return res,lv
end
--升到下级需要经验
local function bat_getuplvexp( lv )

	if lv<33 then
		return rint((lv/3+2))*10
	else
		return rint(12+(lv-32))*10
	end
end

--取现在法宝等级
function get_battlelv( playerid )
	local batdata=GetDBBATTGEMData(playerid)
	if batdata==nil then 
		look("GetDBBATTGEMDataerror")
		return
	end
	if batdata[1]==nil then return end
	return batdata[1][1]
end

--学习技能
function gem_learnskill(playerid,num)
	--look('学习技能')
	
	local batdata=GetDBBATTGEMData(playerid)
	--look(batdata)
	if batdata==nil or  batdata[1]==nil  then 
		look("GetDBBATTGEMDataerror")
		return
	end
	local lv=rint(batdata[1][1]/10)
	if num>lv-3 then 
		--look(111)
		return
	end

	if batdata[4]==nil then 
		batdata[4]={}
	end
	local nowlv=batdata[4][num] or 0
	local maxlv=6
	local goodsid=skill_goodsid[nowlv+1]
	
	if  nowlv>=maxlv then  return end
	local goodsnum=1
	if nowlv==5 then 
		if lv<10 then return end--10阶才能升级6
		goodsnum=5
	end

	if 0 == CheckGoods(goodsid,goodsnum,0,playerid,'骑兵技能') then
		
		return
	end

	local buffid=skillconf[num]

	local findid=buffid
	if nowlv==0 then 
	
		findid=0
	end
	batdata[4][num]=nowlv+1

	if num==6 then --被动技能
		if nowlv==0 then
			CI_LearnSkill(4,buffid)
			CI_SetSkillLevel(4,buffid,16)--扩大16倍
		else
			-- CI_SetSkillLevel(4,buffid,nowlv+1)
			CI_SetSkillLevel(4,buffid,nowlv*16+16)
		end
	else--buff技能
		BATTAttributeone(playerid,buffid,findid,nowlv+1)--属性更新
	end
	SendLuaMsg(0,{ids=b_akill,num=num,lv=batdata[4][num]},9)
end

--使用法魂--+属性
function gem_usebhun( playerid)
	-- look('使用法魂',1)
	local batdata=GetDBBATTGEMData(playerid)
	if batdata==nil  or batdata[1]==nil  then 
		look("GetDBBATTGEMDataerror")
		return 0
	end
	local lv=rint(batdata[1][1]/10)
	if  lv<4 then return 0 end

	if (batdata[2] or 0)>= max_qh then return 0 end
	batdata[2]=(batdata[2] or 0)+1
	BATTAttributeone(playerid)
	-- look(batdata[2],1)
	SendLuaMsg(0,{ids=b_h,qh=batdata[2]},9)
end
--使用法灵--+%
function gem_usebling( playerid)
	-- look('使用法灵',1)
	local batdata=GetDBBATTGEMData(playerid)
	if batdata==nil or batdata[1]==nil then 
		look("GetDBBATTGEMDataerror")
		return 0
	end
	
	local lv=rint(batdata[1][1]/10)
	if  lv<5 then return 0 end
	if (batdata[3] or 0)>=max_ql[lv] then return 0 end

	batdata[3]=(batdata[3] or 0)+1
	BATTAttributeone(playerid)
	-- look(batdata[3],1)
	SendLuaMsg(0,{ids=b_h,ql=batdata[3]},9)
end


--使用祝福丹
function gem_uselvup( playerid,num )
	-- look('使用祝福丹')
	local batdata=GetDBBATTGEMData(playerid)
	if batdata==nil or batdata[1]==nil then 
		-- look(batdata)
		look("GetDBBATTGEMDataerror")
		return 0
	end
	local index=1
	local lv=batdata[index][1]
	if lv >=maxlv then 
		TipCenter(GetStringMsg(457))
		return 0
	end

	local nowlv=rint(batdata[1][1]/10)
	-- look(lv)
	-- look('使用祝福丹')
	if  nowlv<num then 
		TipCenter(GetStringMsg(27,num))
		return 0 
	elseif nowlv==num then 
		batdata[1][1]=batdata[1][1]+1
		batdata[5]=batdata[1][1]
		BATTAttributeone(playerid)
	end
	SendLuaMsg(0,{ids=up_btdatda,data=batdata[1],now=batdata[5]},9)
end






------------------------------------------------
--测试--加等级
function BAT_addlv(playerid,lv)
	local batdata=GetDBBATTGEMData(playerid)
	if lv>maxlv then return end
	if batdata[1]==nil then batdata[1]={1,0} end
	batdata[1][1]=lv--第1个法宝等级，经验，法宝类型(50级别0，100级别1)
	batdata[5]=lv
	SendLuaMsg(0,{ids=up_btdatda,data=batdata[1],res=true,now=batdata[5],xy=batdata[6],exp=batdata[7]},9)
	BATTAttributeone(playerid)
end
--清空技能
function BAT_cllv(playerid)
	local batdata=GetDBBATTGEMData(playerid)
	batdata[4]={}
	for i=1,6 do
		SendLuaMsg(0,{ids=b_akill,num=i,lv=batdata[4][i]},9)
	end
end
------------------------------------------------------

-- local a=1
--战斗法宝强化 itype=1为自动进阶,前台发1次后台进阶10次
function Expupbatt(playerid,buy,lastnum,itype,useluck,leixin)
	-- look('战斗法宝强化 itype=1为自动进阶,前台发1次后台进阶10次',1)
	-- look(leixin,1)
	-- look(buy,1)
	local index=1
	if playerid==nil  or buy==nil or lastnum==nil  then
		look("dataerror")
		return
	end
	local batdata=GetDBBATTGEMData(playerid)
	if batdata==nil  then 
		look("GetDBBATTGEMDataerror")
		return
	end
	 -- look(batdata,1)
	local level = CI_GetPlayerData(1)
	-- if level>=bat_getneedlv() then
	-- 	batbegin( playerid )
	-- else 
	-- 	SendLuaMsg(0,{ids=BTerror,erro=0},9)
	-- 	return
	-- end
	if batdata[index]==nil then return end
	local lv=batdata[index][1]
	if lv >=maxlv then 
		SendLuaMsg(0,{ids=BTerror,erro=4},9)
		return 
	end
	----判断结束
	
	----处理钱和道具
	local lastnum1=lastnum
	local neednum=math.ceil((lv+1)/10)
	local itemid=needid[1]
	local nowlv=batdata[5]---实际等级
	if nowlv==nil then 
		nowlv=lv
	end
	local xin=nowlv%10
	-- look(nowlv,1)
	if leixin and xin~=9 then 
		SendLuaMsg(0,{ids=BTerror,erro=5},9)
		return
	end
	if  xin==9 then 
		neednum=math.ceil((lv+1)/20)
		itemid=needid[2]
	end
	local shengjineednum=neednum

	-- look(itype,1)
	-- look(nowlv,1)
	-- look(lv,1)
	local max=1
	if itype and  xin==9   then
		max=10
	end
	local res
	for i=1,max do	
		-- look('循环次数='..a,1)
		-- a=a+1
		local needusemoney=0
		if buy==0 then
			if 0 == CheckGoods(itemid,neednum,0,playerid,'女神升级') then--扣道具或者钱
				if leixin then 
					SendLuaMsg(0,{ids=BTerror,erro=6},9)
				else
					SendLuaMsg(0,{ids=BTerror,erro=1},9)
				end
				break
			end
		else
			local needdeduct=0
			if lastnum1>=neednum then
				if 0 == CheckGoods(itemid,neednum,1,playerid,'女神升级') then
					-- look(1111)
					break
				else
					needdeduct=neednum
					-- neednum=0
					-- needusemoney=0
					lastnum1=lastnum1-neednum--剩余道具
				end
			elseif lastnum1<neednum  then
				if lastnum1>0 then
					if 0 == CheckGoods(itemid,lastnum1,1,playerid,'女神升级') then
						-- look(2222)
						break
					else
						needdeduct=lastnum1
						-- neednum=neednum-lastnum1
						needusemoney=neednum-lastnum1
						lastnum1=0----剩余道具0
					end
				else
					needusemoney=neednum
				end
			end
			-- look('needusemoney',1)
			-- look(needusemoney,1)
			if needusemoney>0 then
				local money=needusemoney*10
				if  xin==9 then 
					money=needusemoney*50
				end
				-- look('money',1)
				-- look(money,1)
				if not CheckCost(playerid , money, 0 , 1,'100003_女神升级') then
					SendLuaMsg(0,{ids=BTerror,erro=2},9)
					break
				end
			end
			CheckGoods(itemid,needdeduct,0,playerid,'女神升阶')
		end

		--幸运符
		--look(batdata,1)
		if useluck then
			local nowlv=batdata[5]---实际等级
			if nowlv==nil then 
				nowlv=lv
			end
			local xin=nowlv%10
			local jie=rint(nowlv/10)
			if xin==9 then return end
			local gate=batlv_conf.arg2[jie+1]-batlv_conf.arg1*(nowlv-jie*10)
			-- look(jie,1)
			-- look(nowlv,1)
			-- look(gate,1)
			local needxyf=rint(shengjineednum*2/gate)
			-- look(needxyf,1)
			if 0 == CheckGoods(needid[3],needxyf,0,playerid,'女神升级') then
					--look(2222)
				return
			end
		end

		----升级相关
		res,amuck=bat_upres(playerid,shengjineednum,useluck )
		-- look(res,1)
		-- look(shengjineednum,1)
		-- look(batdata[5],1)
		if res and  batdata[5]>batdata[index][1] then ---升级
		--	batdata[index][1]=batdata[index][1]+1--升一级
			batdata[index][1]= batdata[5]
			if batdata[index][1]==10 then
				set_obj_pos(playerid,3004)
			elseif batdata[index][1]==50 then
				set_obj_pos(playerid,4005)
			end
			local jnlast=batdata[index][1]%10
			local jnlv=rint(batdata[index][1]/10)
			if jnlast==0 and jnlv>1 then--3阶开始有外形,传1时前台不处理
				CI_SetPlayerIcon(0,3,jnlv-1,1)
			end
			BATTAttributeone(playerid)
		end
		if res then 
			break
		end
	end
	SendLuaMsg(0,{ids=up_btdatda,data=batdata[index],res=res,now=batdata[5],xy=batdata[6],exp=batdata[7],amuck=amuck},9)
end

--升级相关配置

---升级处理
function bat_upres(playerid,lucknum,useluck )
	-- look('升级处理',1)
	-- look(lucknum,1)
	local batdata=GetDBBATTGEMData(playerid)
	if batdata==nil  then return	end
	local lv=batdata[1][1]
	local nowlv=batdata[5]---实际等级
	if nowlv==nil then 
		nowlv=lv
	end
	local xin=nowlv%10
	local jie=rint(nowlv/10)

	if xin<9 then -- 升星

		if useluck then--使用幸运符
			batdata[5]=nowlv+1
			return true
		end

		--保底功能
		local minup=batlv_conf.xingyun[jie+1][3]
		local maxup=batlv_conf.xingyun[jie+1][4]
		local nowusetime=batdata[8] or 0
		-- look(',保底功能',1)
		-- look(maxup,1)
		-- look(nowusetime,1)
		if nowusetime<minup then 
			if xin==8 then ---8升9必然失败
				batdata[5]=jie*10+7
				if (batdata[7] or 0)>0 then --女神升级失败返还经验
					local cangetexp=lucknum*10000
					PI_PayPlayer(1,cangetexp,0,0,'女神升级失败')
					batdata[7]=(batdata[7] or 0)-cangetexp
				end
				batdata[8]=(batdata[8] or 0)+lucknum--+使用次数
				-- look('使用次数',1)
				return 
			end
		elseif  nowusetime>=maxup then 
			batdata[8]=nil
			batdata[5]=jie*10+9---直升9级
			return true ,1
		end

		---正常概率
		local rannum=math.random(1,100)
		local gate=batlv_conf.arg2[jie+1]-batlv_conf.arg1*(nowlv-jie*10)
		if rannum<=gate*100 then --成功
			batdata[5]=nowlv+1
			batdata[8]=(batdata[8] or 0)+lucknum--+使用次数
			-- look('使用次数',1)
			return true
		else --失败
			local _end
			_end=(batdata[5] or 0)-1
			if xin<3 then
				if _end<jie*10 then 
					_end=jie*10
				end
			elseif xin<6 then
				if _end<jie*10+3 then 
					_end=jie*10+3
				end
			elseif xin<9 then
				if _end<jie*10+6 then 
					_end=jie*10+6
				end
			end
			batdata[5]=_end
			if (batdata[7] or 0)>0 then --女神升级失败返还经验
				local cangetexp=lucknum*10000
				PI_PayPlayer(1,cangetexp,0,0,'女神升级失败')
				batdata[7]=(batdata[7] or 0)-cangetexp
			end
			batdata[8]=(batdata[8] or 0)+lucknum--+使用次数
			-- look('使用次数',1)
			return 
		end
		
	elseif xin==9 then -- 进阶
		-- look('进阶',1)
		-- look(lucknum,1)
		local luck = batdata[6] or 0 --幸运值
		local gatemini=batlv_conf.xingyun[jie+1][1]
		local gatemax=batlv_conf.xingyun[jie+1][2]
		if (luck + lucknum) <=gatemini then --失败,幸运值不够
			batdata[6]=luck+lucknum	
		else
			local gate=math.ceil((luck-gatemini)*3/lucknum)
			local rannum=math.random(1,100)

			if (luck + lucknum) < gatemax and rannum > gate then --最大值以下且未中概率,失败
			
				batdata[6]=luck+lucknum
			
			else --成功
				batdata[6]=nil--幸运值清0
				batdata[5]=nowlv+1
				return true
			end

		end
	end
end

--每日重置
function bat_reset( playerid,itype )
	local batdata=GetDBBATTGEMData(playerid)
	if batdata==nil  then return	end
	if batdata[1]==nil then return end
	local lv=batdata[1][1]
	if lv==nil or lv==0 then return end
	local neednum=math.ceil((lv+1)/10)
	if batdata[1][2] and batdata[1][2]>0 then --如果以前有经验值,直接升一级
		batdata[1][1]=batdata[1][1]+1
		batdata[1][2]=nil
		batdata[5]=batdata[1][1]

		if batdata[1][1]==10 then
			set_obj_pos(playerid,3004)
		elseif batdata[1][1]==50 then
			set_obj_pos(playerid,4005)
		end
		local jnlast=batdata[1][1]%10
		local jnlv=rint(batdata[1][1]/10)
		if jnlast==0 and jnlv>1 then--3阶开始有外形,传1时前台不处理
			CI_SetPlayerIcon(0,3,jnlv-1,1)
		end
		
		SendLuaMsg(0,{ids=up_btdatda,data=batdata[1],now=batdata[5]},9)
	end
	if itype then return end
	batdata[7]=10000000

	SendLuaMsg(0,{ids=b_reset,mexp==batdata[7]},9)
	
end
function bat_buglv(playerid )
	local batdata=GetDBBATTGEMData(playerid)
	if batdata==nil  then return	end
	local jnlv=rint(batdata[1][1]/10)
	if jnlv<3 then return end
	CI_SetPlayerIcon(0,3,jnlv-1,1,2,playerid)
end