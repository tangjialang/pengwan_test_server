--[[
file:	TouchGold.lua
desc:	点金聚灵系统
author:	wk
update:	2013-5-30
refix:	done by wk
]]--
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local Touch_begin	 = msgh_s2c_def[39][1]
local Touch_res		 = msgh_s2c_def[39][2]
local CheckTimes=CheckTimes
local mathrandom = math.random
local _push=table.push
local GetTimesInfo,GiveGoods=GetTimesInfo,GiveGoods
local GetWorldCustomDB=GetWorldCustomDB
local uv_TimesTypeTb = TimesTypeTb
local CI_GetPlayerData=CI_GetPlayerData
--点金-聚灵世界数据-- 最近抽到的奖励 保留10个
local function Get_djjl_worldData()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then
		return
	end
	if w_customdata.money_lq_data == nil then
		w_customdata.money_lq_data = {
			djin = {},	--点金	{name,gate}
			jlin={},	--聚灵
		}
	end
	return w_customdata.money_lq_data
end
--更新点金聚灵世界数据
local function Addawad_djjl(itype,name,amuck,money)
	local djdata=Get_djjl_worldData()
	local enddata
	if itype==1 then
		enddata=djdata.djin
	else
		enddata=djdata.jlin
	end
	_push(enddata, {name,amuck,money}, 8)
end

--初始化
function Touch_Start(itype)
	local djdata=Get_djjl_worldData()
	local enddata
	if itype==1 then
		enddata=djdata.djin
	else
		enddata=djdata.jlin
	end
	SendLuaMsg(0,{ids=Touch_begin,itype=itype,enddata=enddata},9)
end


--点金-聚灵
function Chickmoney(sid,itype)
	local timetype
	if itype==1 then 
		timetype=uv_TimesTypeTb.Dj_money
	elseif itype==2 then 
		timetype=uv_TimesTypeTb.JL_lingqi
	else
		return
	end
	if not CheckTimes(sid,timetype,1,-1,1) then return end
	local timeinfo=GetTimesInfo(sid,timetype)
	look(timeinfo)
	if timeinfo then
		local surplus_time=timeinfo[1] or 0
		if surplus_time>0 then
			local needmoney=0
			needmoney=2+2*(surplus_time-1)
			if needmoney>40 then
				needmoney=40
			end
			if not CheckCost(sid,needmoney,0,1,'100008_点金') then
				return 
			end
		end
		--local getmoney=rint(CI_GetPlayerData(1)^1.6*60+(surplus_time+1)^1.3*200)
		-- local getmoney=CI_GetPlayerData(1)*500+(surplus_time+1)*500
		local getmoney=CI_GetPlayerData(1)*200+45000
		
		local amuck=1
		if surplus_time>0 then 
			if (surplus_time+11)%10==5 then 
				getmoney=getmoney*2
				amuck=2
			elseif (surplus_time+1)%10==0 then 
				getmoney=getmoney*5
				amuck=5
			end
		end

		if itype==1 then
			GiveGoods(0, getmoney,1,'点金')
		else
			AddPlayerPoints( sid , 2 , getmoney,nil,'点金' )
		end
		CheckTimes(sid,timetype,1,-1)
		if amuck>1 then
			local name=CI_GetPlayerData(5)
			Addawad_djjl(itype,name,amuck,getmoney)
		end
		SendLuaMsg(0,{ids=Touch_res,itype=itype,getmoney=getmoney,amuck=amuck},9)
	end	
end
