--[[
file:	Active_escort.lua
desc:	个人运镖
author:	wk
update:	2013-06-7
]]--


local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local Escort_Get	 = msgh_s2c_def[18][1]	
local Escort_Status	 = msgh_s2c_def[18][2]	
local Escort_Finish	 = msgh_s2c_def[18][3]	
local Escort_Kill 	 = msgh_s2c_def[18][4]	
local es_lb 		 = msgh_s2c_def[18][6]	
local es_getzf 		 = msgh_s2c_def[18][7]	
local look = look
local uv_TimesTypeTb = TimesTypeTb
local _floor,_random=math.floor,math.random
local TipCenter=TipCenter
local GetStringMsg=GetStringMsg
local AddPlayerPoints=AddPlayerPoints
local CI_HasBuff=CI_HasBuff
local CI_GetPlayerData=CI_GetPlayerData
local PI_PayPlayer=PI_PayPlayer
local CheckTimes=CheckTimes
local GiveGoods=GiveGoods
local HasTask=HasTask
local CI_DelBuff=CI_DelBuff
local TS_DropTask=TS_DropTask
local isFullNum=isFullNum
local CI_GetCurPos=CI_GetCurPos
local CheckCost=CheckCost
local TS_AcceptTask=TS_AcceptTask
local os,pairs,type,ipairs=os,pairs,type,ipairs
local GetDBActiveData=GetDBActiveData
local rint=rint
local CI_AddBuff=CI_AddBuff
local baoyue_getpower=baoyue_getpower
local GetServerTime=GetServerTime
local CheckGoods=CheckGoods
-----------------------------------------------------------------------------



----------------------------------------------------------------------------
-- module:

module(...)

----------------------------------------------------------------------------

--每日固定活动时间13：10 – 14:00，可获得1.5倍押镖收益（经验和绑银收益）
local ESCORT_ADDTIME = {1310,1400}
local ESCORT_EXTRA = 1.5
local color_award={1,1.2,1.5,3,4}--各颜色镖车奖励倍数
local minlv=40 --40级下至少出紫色
local task_id={4999,4999,210,210} --取任务id--35级前,35级后
local get_color={ --白绿蓝紫橙 概率
	{40,99,100,100,100,}, 
	{0,50,99,100,100,},
	{0,0,90,100,100,},
	{0,0,0,93,100,},
}
local  e_xyconf={ --升到下级最低钱,最高钱
	[3]={20000,40000},
	[4]={100000,150000},
}
--海美人礼包
local  libao={---id,num,绑定,概率
		[1]={602,1,1,2000},
		[2]={602,3,1,6000},
		[3]={603,1,1,8000},
		[4]={603,3,1,9900},
		[5]={732,1,1,10000},
}
ESCORT_Amark=ESCORT_Amark or false --运营活动标识
--运营活动奖励配置
ESCORT_Conf=ESCORT_Conf or false

--押镖运营活动调用--itype=1开始,0结束
local function _escort_activecall(itype,msg)
	-- look('押镖运营活动调用')
	-- look(itype)
	if itype==1 then
		ESCORT_Amark=true
		ESCORT_Conf=msg
	else
		ESCORT_Amark=false
		ESCORT_Conf=nil
	end
end
------------------------------------------------ 11
--活动数据区
local function _getescortdata(sid)
	if(sid == nil)then return end
	local dayData = GetDBActiveData(sid)
	if dayData==nil  then return end
	if dayData.esco == nil then
		dayData.esco = {
		--[1]=1,--运镖状态
		--[2]=3,--镖车颜色
		
		--[3]=3,--经验,死亡时会有此字段,因死亡不能给经验
		--[4]=3,--灵气
		--[9]=4,礼包祝福值
		--[10]=3,幸运值
		}
	end
	return dayData.esco
end
--额外奖励
local function ESCORT_Other_award(sid,color)
	-- look('额外奖励')
	-- look(sid)
	-- look(color)
	if ESCORT_Amark==false then return end
	-- look(111)
	-- look(ESCORT_Conf)
	if type (ESCORT_Conf) == type ({}) then
		-- look(222)
		local award=ESCORT_Conf[color]
		if award then
			-- look(333)
			for k,v in pairs(award)  do
				-- look(444)
				if type(k) == type (0) and type(v) == type ({}) then
					-- look(555)
					for i,j in pairs(v)  do
						-- look(666)
						GiveGoods(i,j ,1,'运镖运营活动')
					end
				end
			end
		end
	end
end
--押镖运营活动判断包裹
local function Check_ESCORT_active(sid,color,other)
	if ESCORT_Amark==true then 
		if type (ESCORT_Conf) == type ({}) then
			if type (ESCORT_Conf[color]) == type ({}) then
				local award=#ESCORT_Conf[color]+other
				local pakagenum = isFullNum()
				if pakagenum < award then
					TipCenter(GetStringMsg(14,award))
					return false
				end 
			end
		end
	end
	return true
end
--发送押镖信息
local function escort_status(sid)
	local sData = _getescortdata(sid)
	if(sData~=nil)then
		SendLuaMsg( 0, { ids=Escort_Status, status = sData[1],ctype=sData[2]}, 9 )
	end
end
--运镖获取的经验,灵气,绑定元宝
local function escort_expmoney(carType)
	if(carType<1 or carType>5)then return end
	local getexp,getBY 
	local goodsnum=2--活动时间3个宝箱
	local level = CI_GetPlayerData(1)
	if level<35 then
		level=35
	end
	local beishu=color_award[carType]
	getexp = _floor(level^2.4*10*beishu)
	getBY = _floor(level*250*beishu)
	local curdt = os.date( "*t", GetServerTime())
	local now=curdt.hour*100+curdt.min
	if  now>= ESCORT_ADDTIME[1] and now <= ESCORT_ADDTIME[2] then
		getexp = _floor(getexp * ESCORT_EXTRA)
		getBY = _floor(getBY * ESCORT_EXTRA)
		goodsnum=3
	end
	return getexp,getBY,goodsnum
end

--得到刷新后颜色
local function rndescort(now,level,cost)
	
	local sid = CI_GetPlayerData(17) 
	local sData = _getescortdata(sid)
	local res=baoyue_getpower( sid,2 )--包月权限
	if(level<minlv) or  res then
		now= 4
	end
	
	local tempType=now
	local rate =_random(1,100)
	local gateconf=get_color[now]
	local xy=sData[10] or 0
	if now>=3 then --4,5颜色特殊处理
		
		local min=rint((level^2+1000)/1000)*e_xyconf[now][1]
		local max=rint((level^2+1000)/1000)*e_xyconf[now][2]
		if res then 
			min=min/3
			max=max/3
		end
		if xy<min then --幸运值不到
			--加幸运值
			sData[10]=xy+cost
			return tempType
		elseif  xy>=max then --幸运值满
			sData[10]=xy+cost
			return tempType+1
		end
	end

	for k,v in pairs(gateconf) do
		if rate<=v then
			tempType=k
			break
		end
	end
	--加幸运值
	sData[10]=xy+cost
	return tempType
end
---------------------------------------------------------------------------------
--开始运镖
local function _startescort()
	local level = CI_GetPlayerData(1)
	if level < 20 then --运镖等级限制
		TipCenter( GetStringMsg(4,20))
		return
	end
	local cx, cy, rid, isdy = CI_GetCurPos()
	if(rid ~= 1 or cx<80 or cx>90 or cy>85 or cy<71)then
		TipCenter( GetStringMsg(421))
		return
	end
	local sid = CI_GetPlayerData(17) 
	local sData = _getescortdata(sid)
	if(sData == nil)then return end
	if not CheckTimes(sid,uv_TimesTypeTb.Escort_time,1,-1,1) then
		TipCenter( GetStringMsg(429))
		return
	end
	if( sData[1] == 1)then
		TipCenter( GetStringMsg(430))
		return
	end
	TipCenter( GetStringMsg(422))
	local itype=sData[2] or 1
	CI_AddBuff(itype+368,0,1,false)--大师兄变身
	sData[1] = 1 --运镖状态
	escort_status(sid)--发送押镖信息
	if not HasTask(sid,2027) then --有主线任务时结束任务时扣次数
		CheckTimes(sid,uv_TimesTypeTb.Escort_time,1,-1)
	else
		CI_AddBuff(140,0,1,false)--第一次护送无敌
	end
	local taskid = task_id[2]
	-- if level<38 then 
	-- 	taskid = task_id[1]
	-- end
	TS_AcceptTask(sid,taskid,53) --接任务 
end

--刷新
local function _refescort(times)
	look('刷新')
	look(times)
	local sid = CI_GetPlayerData(17) 
	local sData = _getescortdata(sid)
	if(sData == nil)then return end
	if(sData[1] == 1 )then
		TipCenter( GetStringMsg(430))
		return
	end
	if(sData[2] and sData[2]>=5)then
		return --没必要刷新
	end
	if not CheckTimes(sid,uv_TimesTypeTb.Escort_time,1,-1,1) then
		TipCenter( GetStringMsg(429))
		return
	end
	local level = CI_GetPlayerData(1)
	local cost=rint((level^2+1000)/1000)*1000
	
	local money=0
	local nowtype=sData[2] or 1
	if times and times>1 then
		if times<=nowtype then return end
		repeat
			-- look('运镖刷新循环',1)
			if not CheckCost(sid,cost,0,3,"运镖刷新") then
				TipCenter( GetStringMsg(3))
				cost =false
			else
				money=money+cost
				local renum=rndescort(nowtype,level,cost)	
				if renum>nowtype then
					nowtype=renum
				end
			end
		until (nowtype>=times or cost == false )
	else
		if not CheckCost(sid,cost,0,3,"运镖刷新") then
				TipCenter( GetStringMsg(3))
				return
			else
				money=cost
				local renum=rndescort(nowtype,level,cost)	
				
				if renum>nowtype then
					 nowtype=renum
				end	
			end
		end
	sData[2]=nowtype
	SendLuaMsg( 0, { ids=Escort_Get, ctype = nowtype,money=money}, 9 )
end

--完成运镖
local function _endescort(issuccess,curSid,isnpc)
	if (curSid == nil) then
		local sid = CI_GetPlayerData(17)
		local level = CI_GetPlayerData(1)
		local sData = _getescortdata(sid)
		if(sData == nil)then return end
		if( sData[1]==nil )then
			if(isnpc)then
				TipCenter( GetStringMsg(425))
			end
			return
		end
		local itype=sData[2] or 1
		local getexp,getBY ,goodsnum= escort_expmoney(itype)
		local cx, cy, rid, isdy = CI_GetCurPos()
		local fail
		if(issuccess)then --运镖成功
			local other=0
			if itype==5 then
				local pakagenum = isFullNum()
				if pakagenum < 1 then
					TipCenter(GetStringMsg(14,1))
					return 
				end
				other=1
			end
			if not Check_ESCORT_active(sid,itype,other) then --运营活动包裹判断
				return 
			end
			-- if((rid~=32) or cx<45 or cx>50 or cy <5 or cy>14)then --交镖地图问题
			-- 	TipCenter( GetStringMsg(424))
			-- 	return
			-- end
			if itype==5 then
				GiveGoods(1084,goodsnum,1,'运镖' )
			end
			AddPlayerPoints(sid,2,getBY,nil,'护送奖励')
			PI_PayPlayer(1, getexp,0,0,'护送奖励')

			ESCORT_Other_award(sid,itype)--运营活动奖励
		else --运镖失败
			fail = 1
			getBY = _floor(getBY*0.5)
			getexp = _floor(getexp * 0.5) --收益只有原来的 获得 50%的经验 50%的绑银
			if sData[5]==100 then --死亡情况给不了经验,复活时给
				sData[3]=getexp
				sData[4]=getBY
			else
				AddPlayerPoints(sid,2,getBY,nil,'护送奖励')
				PI_PayPlayer(1, getexp,0,0,'护送奖励')
			end
			TipCenter( GetStringMsg(428))
		end
		
		
		
		sData[2] = nil--清理数据
		sData[1] = nil
		sData[10]=nil
		
		escort_status(sid)	--发送押镖状态
		if  HasTask(sid,2027) then --有主线任务时结束任务时扣次数
			CheckTimes(sid,uv_TimesTypeTb.Escort_time,1,-1)
			CI_DelBuff(140)
		end
		SendLuaMsg( 0, { ids=Escort_Finish, getexp = getexp, getBY = getBY, fail = fail}, 9 )
		CI_DelBuff(itype+368)
		local taskid=4999
		-- if  HasTask(sid,4998) then
		-- 	taskid=4998
		-- 	TS_DropTask( sid, taskid) --放弃任务
		
		-- elseif HasTask(sid,4999) then
			--taskid=4999
			TS_DropTask( sid, taskid) --放弃任务
		-- end
		
	end
end


--死亡情况给不了经验,复活时给
local function _pay_escortexponlive(sid)

	local sData = _getescortdata(sid)
	if(sData==nil)then
		return
	end
	if sData[5]==100 then 
		PI_PayPlayer(1, sData[3],0,0,'护送奖励')
		AddPlayerPoints(sid,2,sData[4],nil,'护送奖励')
		sData[3]=nil
		sData[4]=nil
		sData[5]=nil
	end
end


--NPC调用
local function _endescortnpc(sid, npcid)
look(npcid)
	local sub_id =210
	-- if  HasTask(sid,4998) then
	-- 	sub_id=210
	-- 	look(11)
	-- elseif HasTask(sid,4999) then
	-- 	sub_id=209
	-- 	look(22)
	-- else
	-- 	look(33)
	-- 	return
	-- end
	if npcid ~= sub_id then
		return
	end
	_endescort(true,nil,true)
end

--运镖人死亡,劫镖人收益
local function _escort_playerdead(sid,fsid)

	local sData1 = _getescortdata(sid)
	if( sData1[1] == 1 )then
		local itype=sData1[2] or 1
		sData1[5] = 100--死亡复活后凭此给经验
		_endescort(false)
		
		if type(fsid)==type(0) and fsid~=0 then
			if not CheckTimes(fsid,uv_TimesTypeTb.Escort_kill,1,-1,1) then
				SendLuaMsg(fsid,{ids=Escort_Kill,getexp=0,},10)
				return
			end
			local getexp,getBY= escort_expmoney(itype)
			getBY = _floor(getBY*0.5)
			getexp = _floor(getexp * 0.5)
			
			if(getexp~=nil and getBY~=nil)then
				AddPlayerPoints(fsid,2,getBY,nil,'护送奖励')
				PI_PayPlayer(1, getexp,0,0,'护送奖励',2,fsid)

				CheckTimes(fsid,uv_TimesTypeTb.Escort_kill,1,-1)
				SendLuaMsg(fsid,{ids=Escort_Kill,getexp=getexp,getBY=getBY},10)
			end
		end
		
		
		
	else
		return
	end
	
	
	return true
end
--运镖再上线处理
local function _escort_login()
	local sid = CI_GetPlayerData(17) 
	local sData = _getescortdata(sid)
	if sData==nil then return end
	if(sData[1]==1)then
		local a=(sData[2] or 1)+368
		if not CI_HasBuff(a) then 	--判断运镖是否有押镖buff
			_endescort(false)
		else
			escort_status(sid)
		end
	elseif(sData[5]==100)then
		PI_PayPlayer(1, sData[3],0,0,'护送奖励')
		AddPlayerPoints(sid,2,sData[4],nil,'护送奖励')
		SendLuaMsg( 0, { ids=Escort_Finish, getexp = sData[3], getBY = sData[4], fail = fail}, 9 )
		sData[3]=nil
		sData[4]=nil
		sData[5]=nil
	end
end

--使用海美人礼包
function _es_ueslibao( sid )
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return 0
	end
	
	local sData = _getescortdata(sid)
	if sData==nil then return 0 end
	if 0 == CheckGoods(1084,1,0,sid,'海美人抽奖') then
		return
	end
	local rannum=_random(1,10000)
	local getnum=1
	for k,v in ipairs(libao) do		
		if rannum<=v[4] then
			GiveGoods(v[1],v[2] ,v[3],'海美人抽奖')
			getnum=k
			break
		end
	end
	
	if (sData[9] or 0)<9 then
		sData[9]=(sData[9] or 0)+1
	end
	SendLuaMsg( 0, { ids=es_lb,get=getnum,zf=sData[9]}, 9 )
end
--祝福值领东西
function _es_getzfgoods( sid )
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return 0
	end
	local sData = _getescortdata(sid)
	if sData==nil then return 0 end
	if (sData[9] or 0)<9 then
		return 0
	end
	if not CheckCost(sid , 30, 0 , 1,'祝福值领东西') then
		return 0
	end
	
	GiveGoods(732,1 ,1,'祝福值领东西')
	sData[9]=nil
	SendLuaMsg( 0, { ids=es_getzf,zf=0}, 9 )
end
-------------------------------------------------------
refescort=_refescort
startescort=_startescort
endescort=_endescort
endescortnpc=_endescortnpc
getescortdata=_getescortdata
pay_escortexponlive=_pay_escortexponlive
escort_playerdead=_escort_playerdead
escort_login=_escort_login
escort_activecall=_escort_activecall
es_ueslibao=_es_ueslibao
es_getzfgoods=_es_getzfgoods
