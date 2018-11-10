--[[
file:	jijin.lua
desc:	基金,余额宝
author:	wk
update:	2014-2-24
]]--


local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local JJ_cunru	 = msgh_s2c_def[12][38]	
local JJ_award	 = msgh_s2c_def[12][39]
local JJ_out	 = msgh_s2c_def[12][40]
local db_module = require('Script.cext.dbrpc')
local db_RANK_in = db_module.db_RANK_in---(mainID,pname,rank)
local common_time = require('Script.common.time_cnt')
local GetDiffDayFromTime=common_time.GetDiffDayFromTime
local GetServerTime=GetServerTime
local DBRPC=DBRPC
local isFullNum,TipCenter,GetStringMsg=isFullNum,TipCenter,GetStringMsg
local pairs,GiveGoods=pairs,GiveGoods
local look=look
local GetWorldCustomDB,GI_GetPlayerData=GetWorldCustomDB,GI_GetPlayerData
local rint,CheckCost=rint,CheckCost
local GetServerOpenTime=GetServerOpenTime
local DGiveP=DGiveP
local GetGroupID=GetGroupID
local os_date=os.date
local RPC=RPC	
local GetWorldLevel=GetWorldLevel

-------------------------------------------------------------------------------
module(...)

  --基金配置 1=每日奖励,2=6个档次奖励
-- local jj_conf={
-- 	[1]={{802,1,1},{803,10,1},{627,10,1},{626,10,1},{601,10,1},{603,10,1},},
-- 	[2]={
-- 		[1]={{803,100,1},},
-- 		[2]={{803,200,1},{603,50,1},},
-- 		[3]={{802,50,1},{771,10,1},{626,200,1},},
-- 		[4]={{802,100,1},{796,50,1},{601,100,1},{603,100,1},},
-- 		[5]={{802,150,1},{766,3,1},{803,200,1},{601,200,1},{603,200,1},},
-- 		[6]={{801,50,1},{789,100,1},{712,1,1},{802,200,1},{752,5,1},{796,100,1},},
-- 		},
-- }
local jj_conf={
	[50]={
		[1]={{803,40,1},{601,20,1},{812,40,1},{1601,10,1},{1585,40,1},{762,4,1},},
		[2]={
			[1]={{803,200,1},},
			[2]={{803,400,1},{804,30,1},},
			[3]={{803,800,1},{804,60,1},{796,20,1},},
			[4]={{803,1200,1},{804,100,1},{796,30,1},{778,10,1},},
			[5]={{803,2500,1},{804,150,1},{796,80,1},{778,15,1},{601,500,1},},
			[6]={{803,4000,1},{804,200,1},{796,200,1},{778,25,1},{601,1000,1},{712,1,1},},
		},
	},
	[60]={
		[1]={{803,40,1},{601,20,1},{812,40,1},{1601,10,1},{1585,40,1},{762,4,1},},
		[2]={
			[1]={{803,200,1},},
			[2]={{803,400,1},{804,30,1},},
			[3]={{803,800,1},{804,60,1},{796,20,1},},
			[4]={{803,1200,1},{804,100,1},{796,30,1},{778,10,1},},
			[5]={{803,2500,1},{804,150,1},{796,80,1},{778,15,1},{601,500,1},},
			[6]={{803,4000,1},{804,200,1},{796,200,1},{778,25,1},{601,1000,1},{731,1,1},},
		},
	},
	[70]={
		[1]={{803,40,1},{1520,100,1},{812,40,1},{1601,10,1},{1585,40,1},{762,4,1},},
		[2]={
			[1]={{803,300,1},},
			[2]={{803,500,1},{812,300,1},},
			[3]={{803,1000,1},{812,500,1},{796,30,1},},
			[4]={{803,2000,1},{812,1000,1},{796,50,1},{778,20,1},},
			[5]={{803,3000,1},{812,2000,1},{796,100,1},{778,30,1},{601,500,1},},
			[6]={{803,5000,1},{812,4000,1},{796,300,1},{778,80,1},{601,1000,1},{764,1,1},},
		},
	},
	[80]={
		[1]={{803,40,1},{1520,100,1},{812,40,1},{1601,10,1},{1585,40,1},{762,4,1},},
		[2]={
			[1]={{803,300,1},},
			[2]={{803,500,1},{812,300,1},},
			[3]={{803,1000,1},{812,500,1},{796,30,1},},
			[4]={{803,2000,1},{812,1000,1},{796,50,1},{778,20,1},},
			[5]={{803,3000,1},{812,2000,1},{796,100,1},{778,30,1},{601,500,1},},
			[6]={{803,5000,1},{812,4000,1},{796,300,1},{778,80,1},{601,1000,1},{764,1,1},},
		},
	},
}





--个人板数据区_(1仓库数据,2消耗元宝,3得到神兵数,4套装领奖相关)
function jj_getpdata( sid )
	local pdata=GI_GetPlayerData( sid , 'jjin' , 30 )
	if pdata==nil then return end
	--[[
		[1]=111,--活动开始时间
		[2]=255,--投资份数
		[3]=2,--每日领奖总次数
		[4]=5,--单次投资领奖
		[5]=33,当日领取时份数
		
	]]--
	return pdata
end
--定义世界数据	
local function jj_GetwData()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then
		return
	end
	if w_customdata.jijin == nil then
		w_customdata.jijin = {
			[1]={},--活动开始时间,领奖时间,结束时间
			--worldlv=worldlv--活动开启是世界等级
		}
	end
	return w_customdata.jijin
end
--得到可领奖档次
local function jj_getindex( num )
	if num<5 then 
		return 1
	elseif num<10 then 
		return 2
	elseif num<20 then 
		return 3
	elseif num<30 then 
		return 4
	elseif num<40 then 
		return 5
	elseif num<=50 then 
		return 6
	end	
end
--活动val=1结束,val=2开始
function jj_active(val,tBegin,tAward,tEnd)
	-- look('活动val=1开启,val=2结束',1)
	-- look(val,1)
	-- look(tBegin,1)
	-- look(tAward,1)
	-- look(tEnd,1)
	local alldata=jj_GetwData()
	-- Log('寻宝11.txt',alldata)
	
	if val==2 then 
		
		if alldata[1]==nil or alldata[1][1]~=tBegin then 
			for i=1,10 do--清理数据
				alldata[i]=nil
			end
			local worldlv=rint(GetWorldLevel()/10)*10
			if worldlv<50 then
				worldlv=50
			end
			if  jj_conf[worldlv]==nil and jj_conf[70]~=nil then
				worldlv=70
			end
			alldata.worldlv=worldlv--存入世界数据
			-- look(worldlv,1)
		end
		alldata[1]={tBegin,tAward,tEnd}	--活动时间

		
	elseif val==1 then 
		for i=1,10 do--清理数据
			alldata[i]=nil
		end
	end

end

--各种权限判断 --itype=1存入,2每日,3单次,4取出

local function jj_cango( sid,itype )
	local now=GetServerTime()
	local alldata=jj_GetwData()
	if alldata==nil then return end
	local pdata=jj_getpdata( sid )
	if pdata==nil then return end

	local tBegin,tAward,tEnd

	if alldata[1]==nil then 
		alldata[1]={}
	end
	tBegin=alldata[1][1] or 0
	tAward=alldata[1][2] or 0
	tEnd=alldata[1][3] or 0
	


	
	--判断版本
	-- look('判断版本',1)
	
	if tBegin >0 then--有新活动

			if pdata[1]==nil or pdata[1]~=tBegin then --版本号不一样,清数据
				if pdata[2]==nil then 
					for i=3,5 do
						pdata[i]=nil
					end
					pdata[1]=tBegin
				else
					if itype~=4 then
						return
					end
				end
			end
	else--无活动
		if pdata[2]~=nil then --清数据
			for i=3,5 do
				pdata[i]=nil
			end
		
		end
	end
	
	-- look('判断版本111',1)
	--判断权限
	if itype==1 then --itype=1存入
		if (now < tBegin ) or (now>tAward ) then 
			
			return
		end
	elseif itype==2 then --itype=2每日
		if (now < tAward ) or (now>tEnd ) then 
			-- look(os_date('%Y-%m-%d %H:%M:%S',now),1)
			-- look(os_date('%Y-%m-%d %H:%M:%S', tAward),1)
			-- look(os_date('%Y-%m-%d %H:%M:%S', tEnd),1)
		
			return
		end
	elseif itype==3 then --itype=3单次
		if (now < tBegin ) or (now>tEnd ) then 
			return
		end
	elseif itype==4 then --itype=4取出
		if (pdata[1] or 0)==tBegin then --在本次活动且在未到结束时间
			if (now < tEnd ) then 
				return
			end
		end
	end
	-- look(333,1)
	return true
end


--基金存入 num份数
function jj_touzi( sid,num )
	if not jj_cango( sid,1 ) then return end
	-- look('基金存入',1)


	local wdata=jj_GetwData()
	local btime=wdata[1][1]
	local begintime=os_date('%Y-%m-%d %H:%M:%S', btime)
	local endtime=os_date('%Y-%m-%d %H:%M:%S', GetServerTime())
	local pdata=jj_getpdata(sid)
	if pdata==nil then return end
	if pdata[2]~=nil and pdata[1] ~=btime then
		return 
	end
	local serverid = GetGroupID()
	-- look(serverid,1)
	-- look(begintime,1)
	-- look(endtime,1)
	local call = { dbtype = 2, sp = 'N_ActivityPayBuyPoint' , args = 5, [1] = sid,[2] = serverid,[3] = begintime,[4] = endtime,[5]=1}
	local callback = { callback = 'jj_cz_callback', args = 4, [1] = sid,[2]=num,[3] =btime,[4] = "?6" ,}
	DBRPC( call, callback )

	-- jj_cz_callback( sid,num,begintime,1000000 )
end

--存入回调
function jj_cz_callback( sid,num,begintime,value )
	-- look('存入回调',1)
	-- look(value,1)

	local canbuy=rint(value/1000)
	local pdata=jj_getpdata(sid)
	if pdata==nil then return end
	local nowbuy=pdata[2] or 0 --现在购买次数
	if (nowbuy+num)>50  or (canbuy-nowbuy)<num then return end
	if not CheckCost(sid , num*1000, 0 , 1,'基金存入') then
		return
	end
	pdata[2]=nowbuy+num
	pdata[1] =begintime

	SendLuaMsg( 0, { ids = JJ_cunru, num=pdata[2] }, 9 )
end



--itype=1领取每日奖励,itype=2领取单次奖励,index为领第几档
function jj_getaward( sid,itype,index )
	-- look('1领取每日奖励',1)
	-- look(itype,1)
	-- look(index,1)
	if not jj_cango( sid,itype+1 ) then return end
	-- look(11,1)
	local pdata=jj_getpdata(sid)
	if pdata==nil then return end
	local nowbuy=pdata[2] or 0 --现在购买份数
	-- look(22,1)
	local alldata=jj_GetwData()
	if alldata==nil then return end
	if itype==1 then 
		
	
		local tAward=alldata[1][2] or 0

		local nowget=pdata[3] or 0--现在领过次数
		-- local canget_all=10   --能领总次数
		local canget_all=GetDiffDayFromTime(tAward)+1--距离活动领奖天数
		local aconf=jj_conf[alldata.worldlv][1] --奖励配置

		local pakagenum = isFullNum()
		if pakagenum < #aconf then
			TipCenter(GetStringMsg(14,#aconf))
			return
		end
		local canget=canget_all-nowget
		if canget<=0 then  --没次数
			if pdata[5] ==nowbuy then return end
			for k,v in pairs(aconf) do
				GiveGoods(v[1],v[2]*1*(nowbuy-(pdata[5] or 0)),v[3],'基金每日领奖')
			end
		else --有次数
			for k,v in pairs(aconf) do
				GiveGoods(v[1],v[2]*canget*nowbuy,v[3],'基金每日领奖')
			end
		end


		pdata[3]=canget_all
		pdata[5]=nowbuy--记录此次领奖时购买份数

	elseif itype==2 then 
		local nowget=pdata[4] or 0--现在领过档次
		local canget_all=jj_getindex(nowbuy) --能领档次
		if canget_all<index or index-nowget~=1 then return end

		local aconf=jj_conf[alldata.worldlv][2][index] --奖励配置
		local pakagenum = isFullNum()
		if pakagenum < #aconf then
			TipCenter(GetStringMsg(14,#aconf))
			return
		end
		for k,v in pairs(aconf) do
			GiveGoods(v[1],v[2],v[3],'基金档次领奖')
		end
		pdata[4]=index
	else
		return 
	end
	if itype==1 then 
		SendLuaMsg( 0, { ids = JJ_award, itype=itype,index=index,data=pdata }, 9 )
	else
		SendLuaMsg( 0, { ids = JJ_award, itype=itype,index=index }, 9 )
	end
end

--取出基金元宝
function jj_getyb_all( sid )
	if not jj_cango( sid,4 ) then return end
	local pdata=jj_getpdata(sid)
	if pdata==nil then return end
	local nowbuy=pdata[2] or 0 --现在购买份数
	if nowbuy<1 then return end

	DGiveP(nowbuy*1000,'取出基金元宝')
	pdata[2]=nil
	SendLuaMsg( 0, { ids = JJ_out }, 9 )
end

--取世界等级
function jj_getworldlv(  )
	local alldata=jj_GetwData()
	-- look(alldata,1)
	if alldata==nil then return end
	RPC('jj_wl',alldata.worldlv)
end