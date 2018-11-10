--[[
file:	寻找神兵
author:	wk
update:	2013-11-6
]]--

local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local fopen	 = msgh_s2c_def[29][9]	
local fdata	 = msgh_s2c_def[29][10]	
local fgetaward	 = msgh_s2c_def[29][11]	
local fopenp	 = msgh_s2c_def[29][12]	
local fzbdh	 = msgh_s2c_def[29][13]	
local norank_jfres	 = msgh_s2c_def[29][16]
local _random=math.random
local db_module = require('Script.cext.dbrpc')
local db_operationsactivity = db_module.db_operationsactivity
local uv_TimesTypeTb=TimesTypeTb
local _insert=table.insert
local _remove=table.remove
local sclist_m = require('Script.scorelist.sclist_func')
local insert_scorelist_ex = sclist_m.insert_scorelist_ex--(t,num,val,name,school,id,vt)

local db_RANK_in = db_module.db_RANK_in---(mainID,pname,rank)
local common_time = require('Script.common.time_cnt')
local GetDiffDayFromTime=common_time.GetDiffDayFromTime

--------
local fsb_conf=fsb_conf--寻宝配置区
local fsb_jf_conf=fsb_jf_conf--积分领奖配置
local fsb_lj_conf=fsb_lj_conf--累积领奖配置
local fsb_zrph_conf=fsb_zrph_conf--昨日排行领奖配置
local fsb_zbdh_conf=fsb_zbdh_conf--珍宝兑换
-- local kf_cxtime=7*24*3600
local kf_cxtime=7
local maxgetgood=8--8次内不出贵重物品

--无排行寻宝奖励--积分,道具id,数量,绑定
local norank_jfconf_award={
	[40]={
			[1]={100,803,20,1},
			[2]={200,803,50,1},
			[3]={500,803,100,1},
			[4]={1000,803,200,1},
			[5]={2000,803,400,1},
			[6]={5000,803,1000,1},
 		},
 	[50]={
			[1]={100,803,20,1},
			[2]={200,803,50,1},
			[3]={500,803,100,1},
			[4]={1000,803,200,1},
			[5]={2000,803,400,1},
			[6]={5000,803,1000,1},
 		},
 	[60]={
			[1]={100,802,3,1},
			[2]={200,802,6,1},
			[3]={500,802,15,1},
			[4]={1000,802,30,1},
			[5]={2000,802,60,1},
			[6]={5000,802,150,1},
		},
	[70]={
			[1]={100,812,20,1},
			[2]={200,812,50,1},
			[3]={500,812,100,1},
			[4]={1000,812,200,1},
			[5]={2000,812,400,1},
			[6]={5000,812,1000,1},

		},
	[80]={
			[1]={100,812,20,1},
			[2]={200,812,50,1},
			[3]={500,812,100,1},
			[4]={1000,812,200,1},
			[5]={2000,812,400,1},
			[6]={5000,812,1000,1},

		},	
}

-------------------------------------------------------------------------------
--个人板数据区_(1仓库数据,2消耗元宝,3得到神兵数,4套装领奖相关)
function fsb_getpdata( sid )
	local pdata=GI_GetPlayerData( sid , 'fsb' , 500 )
	if pdata==nil then return end
	--[[
		[1]={415=2,416=5,},--仓库列表
		[2]=255,--抽奖次数
		[3]=2,--得到神兵个数
		[4]=5,--本次活动累计积分
		[5]=5,--今日累计积分
		[6]={},--积分领奖记录
		[7]={},--本次活动珍宝兑换记录


		[9]=1,--版本号,开服时间或者活动开始时间
		[10]=44,--历史总积分

		[12]=255,--抽奖次数--无排行
		[13]=2,--得到神兵个数--无排行
		[14]=111,--积分--无排行
		[15]=2,--领取积分奖励到什么档次
		[19]=1,--版本号,开服时间或者活动开始时间--无排行
		
	]]--
	return pdata
end
--定义世界数据	
local function fsb_GetwData()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then
		return
	end
	if w_customdata.fsbw == nil then
		w_customdata.fsbw = {
			
			[1]={},--最近抽到的奖励{id,name},排行寻宝
			[2]={},--累计积分排行
			[3]={},--今日排行
			[4]={},--昨日排行
			[5]={},--累计积分排行领奖记录
			[6]={},--昨日排行排行领奖记录
			[10]={},--有排行活动开始时间,领奖时间,结束时间
			[11]={},--最近抽到的奖励{id,name},无排行寻宝
			[20]={},--无排行活动开始时间,领奖时间,结束时间

			
		}
	end
	return w_customdata.fsbw
end
--写入贵重物品 itype=1为无排行寻宝
local function fsb_insertdata( id ,name,itype)
	local alldata=fsb_GetwData()
	local wdata
	if itype then 
		if alldata[11]==nil then
			alldata[11]={}
		end
		wdata=alldata[11]
	else
		if alldata[1]==nil then
			alldata[1]={}
		end
		wdata=alldata[1]
	end
	_insert(wdata,1,{id,name})
	if #wdata>12 then
		_remove(wdata,13)
	end
end
--写入排行榜  score1=累计,score2=今日
--insert_scorelist_ex---(t,num,val,name,school,id,vt)
local function fsb_inrank(sid,score1, score2 )
	-- --look('写入排行榜',1)
	
	local alldata=fsb_GetwData()
	if alldata==nil then return end
	if alldata[2]==nil then 
		alldata[2]={}
	end
	if alldata[3]==nil then 
		alldata[3]={}
	end
	local name=CI_GetPlayerData(5)
	local school=CI_GetPlayerData(2)
	-- --look(alldata[2],1)
	-- --look(alldata[3],1)
	-- --look(score1,1)
	-- --look(fsb_lj_conf.needscore ,1)
	local res1,res2
	if score1>=fsb_lj_conf.needscore then 
		res1=insert_scorelist_ex(alldata[2],20,score1,name,school,sid)
	end
	if score2>=fsb_zrph_conf.needscore then 
		res2=insert_scorelist_ex(alldata[3],20,score2,name,school,sid)
	end

	return res1 or res2
end


--开面板请求日志 itype=1为无排行寻宝
function fsb_openpanle(itype)
	local alldata=fsb_GetwData()
	if alldata==nil then return end
	if itype then
		SendLuaMsg(0,{ids=fopen,data=alldata[11],itype=itype},9)
	else
		SendLuaMsg(0,{ids=fopen,data=alldata[1]},9)
	end
end

--判断中神兵概率itype=1为无排行寻宝
local function fsb_getsbgate( sid,nowuse,nowgetsb ,itype)
	local data=fsb_getpdata( sid )
	if data==nil then --look(111343) 
		return 
	end
	local getsb_conf
	if not itype then 
		getsb_conf=fsb_conf
		
	elseif itype==1 then --无排行寻宝
		getsb_conf=fsb_conf_norank1--1倍
	elseif itype==5 then 
		getsb_conf=fsb_conf_norank5--5倍
	end

	local sbconf=getsb_conf.sb[nowgetsb+1]
	local gate=0 
	if sbconf then
		local needyb=sbconf[2]
		if nowuse>=needyb then --有概率出
			gate=500
			local sureyb=sbconf[3]
			if nowuse>= sureyb then --必出
				gate=10000
			end
		end
	end

	local rannum=_random(1,10000)
	local goodsid=0
	local goodsnum=0
	local getmark=false

	if  gate>0 then

		if rannum<=gate then --中神兵
			-- --look('中神兵',1)
			local school=CI_GetPlayerData(2)
			local sex=CI_GetPlayerData(11)
			local name=CI_GetPlayerData(5)
			local index=school*10+sex
			goodsid=getsb_conf.equipid[sbconf[1]][index]
			goodsnum=1
			getmark=true

			-- --look(data[3],1)
			BroadcastRPC('fsb_getsb',goodsid,name)
			fsb_insertdata( goodsid ,name,itype)
			if not itype then 
				data[3]=nowgetsb+1--得到神兵数+1
				db_operationsactivity(sid,'寻找神兵','抽到第几件神兵_'..data[3]..':id_'..goodsid)

			else
				data[13]=nowgetsb+1--得到神兵数+1
				db_operationsactivity(sid,'寻找神兵2','抽到第几件神兵_'..data[13]..':id_'..goodsid)

			end
			--db_operationsactivity(sid,'寻找神兵','抽到第几件神兵_'..data[3]..':id_'..goodsid)
		end
	end
	if not getmark then --未中
		-- --look('未中',1)
		local oconf=getsb_conf.others---1无排行寻宝支持世界等级
		if itype==1 then --无排行寻宝
			local worldlv=rint(GetWorldLevel()/10)*10
			if worldlv<40 and getsb_conf.others[worldlv]==nil then
				worldlv=40
			end
			if worldlv>60 and getsb_conf.others[worldlv]==nil then
				worldlv=60
			end
			oconf=getsb_conf.others[worldlv]
		end
		for i=1,#oconf do
			local v=oconf[i]
			if rannum<=v[3] then 
				goodsid=v[1]
				goodsnum=v[2]				
				if v[4] and v[4]==1 then --贵重物品
					if nowuse <maxgetgood then--前几次不出贵重品
						goodsid = oconf[1][1]
						goodsnum = oconf[1][2]
					else
						local name=CI_GetPlayerData(5)
						fsb_insertdata( goodsid ,name,itype)
						BroadcastRPC('fsb_getsb',goodsid,CI_GetPlayerData(5))
						db_operationsactivity(sid,'寻找神兵','抽到贵重物品_id_'..goodsid)
					end					
				end
				break
			end
		end	
	end
	if data[1]==nil then 
		data[1]={}
	end
	data[1][goodsid]=(data[1][goodsid] or 0)+goodsnum--仓库加个数


	if not itype then 
		data[2]=nowuse+1		--加次数
		data[4]=(data[4] or 0) +1--本次活动累计积分
		data[5]=(data[5] or 0) +1--今日累计积分
		data[10]=(data[10] or 0) +1--历史累计积分
		fsb_inrank(sid,data[4], data[5] )
	else
		if itype==1 then 
			data[12]=nowuse+1		--加次数--1倍
		elseif itype==5 then 
			data[12]=nowuse+5		--加次数--5倍
		end


		
		data[14]=(data[14] or 0) +itype--本次活动累计积分
	end
	return true
end

--点击抽奖(itype=1,10,50),money=0只用道具,1只用钱,2先用last个道具,剩余用钱
--index有值为无排行寻宝,=1为1倍,=5为5倍
function fsb_lottery( sid ,itype,money,last,index)
	--look('点击抽奖',1)
	--look(itype,1)
	--look(money,1)
	--look(last,1)
	--look(index,1)
	if IsSpanServer() then return end
	
	if not index then 
		if not fsb_cango( sid,1 ) then
			return
		end
	else
		if not fsb_cango( sid,11 ) then
			return
		end
	end
	-- --look('点击抽奖123',1)
	local  needmoney=0
	local  norank_money=0--5倍抽奖额外元宝
	if itype==1 then 
		if index==1 then 
			needmoney=10
		else
			needmoney=20
		end
		norank_money=50
	elseif	itype==10 then 
		if index==1 then 
			needmoney=100
		else
			needmoney=190
		end
		-- needmoney=190
		norank_money=450
	elseif itype==50 then 
		if index==1 then 
			needmoney=500
		else
			needmoney=900
		end
		-- needmoney=900
		norank_money=2000
	else
		return
	end
	local itemid=768
	if index==1 then 
		itemid=1462
	end

	if money==0 then
		if not index then
			if CheckGoods( itemid, itype, 1, sid,'寻找神兵抽奖') == 0 then--查石头在不	
				-- --look(777,1)
				return
			end
		elseif index==1 then 
			if CheckGoods( itemid, itype, 1, sid,'寻找神兵抽奖') == 0 then--查石头在不	
				-- --look(777,1)
				return
			end
		elseif index==5 then --无排行5倍,道具+钱
			if CheckGoods( itemid, itype, 1, sid,'寻找神兵抽奖') == 0 then--查石头在不	
				-- --look(777,1)
				return
			end
			if not CheckCost( sid , norank_money , 1 , 1, "寻找神兵抽奖") then
				-- --look(888,1)
				return
			end
		end

	elseif money==1 then
		if not CheckCost( sid , needmoney , 1 , 1, "寻找神兵抽奖") then
			-- --look(888,1)
			return
		end
	elseif money==2 then
		if last>=itype then return end

		if CheckGoods( itemid, last, 1, sid,'寻找神兵抽奖') == 0 then--查石头在不	
			-- --look(999,1)
			return
		end
		local endmoney=needmoney-(last*needmoney/itype)
		if not CheckCost( sid , endmoney, 1 , 1, "寻找神兵抽奖") then
			-- --look(555,1)
			return
		end
	else
		return
	end
	-- --look(222,1)
	local data=fsb_getpdata( sid )
	if data==nil then return end
	local nowuse --现在次数
	local nowgetsb --现在得到神兵数
	for i=1,itype do
		if index then-- 无排行
			nowuse=data[12] or 0
			nowgetsb=data[13] or 0
		else
			nowuse=data[2] or 0
			nowgetsb=data[3] or 0
		end
		local res= fsb_getsbgate(sid, nowuse,nowgetsb,index)
		if res==nil then  return end
	end

	if money==0 then
		 -- CheckGoods( 768, itype, 0, sid,'寻找神兵抽奖') 
		 if not index then
			CheckGoods( itemid, itype, 0, sid,'寻找神兵抽奖')
		elseif index==1 then 
			CheckGoods( itemid, itype, 0, sid,'无排行寻宝')
				
		elseif index==5 then --无排行5倍,道具+钱
			CheckGoods( itemid, itype, 0, sid,'无排行寻宝')
			CheckCost( sid , norank_money , 0 , 1, "无排行寻宝") 	
		end
	elseif money==1 then
		 CheckCost( sid , needmoney , 0 , 1, "寻找神兵抽奖") 
	elseif money==2 then
		CheckGoods( itemid, last, 0, sid,'寻找神兵抽奖') 	
		local endmoney=needmoney-(last*needmoney/itype)
		if endmoney>0 then 
			CheckCost( sid , endmoney, 0 , 1, "寻找神兵抽奖") 
		end
	end
	-- --look(444,1)
	SendLuaMsg(0,{ids=fdata,data=data[1],mark=1,s1=data[10],s2=data[4],index=index,jf=data[14]},9)
end

--查看仓库
function fsb_lookbox( sid )
	local data=fsb_getpdata( sid )
	if data==nil then return end
	SendLuaMsg(0,{ids=fdata,data=data[1]},9)
end

--取道具
function fsb_boxtobody( sid ,id,itype)
	local data=fsb_getpdata( sid )
	if data==nil or   data[1]==nil then return end
	
	
	if  not itype or  itype~=1 then--取一个
		local goodsnum=data[1][id] 
		if goodsnum==nil then return end
		local num=1
		if goodsnum>9999 then  --加999判断
			num=math.ceil(goodsnum/9999)
		end
		local pakagenum = isFullNum()
		if pakagenum < num then
			TipCenter(GetStringMsg(14,num))
			
			return
		end
		GiveGoods(id,goodsnum,1,'寻找神兵')
		data[1][id]=nil
	else --一键
		for k,v in pairs(data[1]) do 
			if type(k)==type(0) and type(v)==type(0) then 
				local num=1
				if v>9999 then  --加999判断
					num=math.ceil(v/9999)
				end
				local pakagenum = isFullNum()
				if pakagenum < num then
					TipCenter(GetStringMsg(14,num))
					SendLuaMsg(0,{ids=fdata,data=data[1],mark=-1},9)
					return
				end
				GiveGoods(k,v,1,'寻找神兵')
				data[1][k]=nil
			end
		end
	end

	SendLuaMsg(0,{ids=fdata,data=data[1],mark=-1},9)
end

-------------------------20131219修改添加--排行,商店-----------------------
-------------------------20131219修改添加--排行,商店-----------------------
-------------------------20131219修改添加--排行,商店-----------------------

--点开面板,itype=1累计排行,2今日排行,3昨日排行
function fsb_openpanel(sid,itype)
	local alldata=fsb_GetwData()
	if alldata==nil then return end
	local pdata=fsb_getpdata( sid )
	if pdata==nil then  return end
	-- --look('点开面板,itype=1累计排行,2今日排行,3昨日排行')
	-- --look(itype)
	----look(alldata)
	if itype==1 then 
		SendLuaMsg(0,{ids=fopenp,data=alldata[2],s=pdata[4],itype=itype,mark=alldata[5]},9)
	elseif itype==2 then 
		SendLuaMsg(0,{ids=fopenp,data=alldata[3],s=pdata[5],itype=itype},9)
	elseif itype==3 then 
		SendLuaMsg(0,{ids=fopenp,data=alldata[4],itype=itype,mark=alldata[6]},9)
	end
end

--12点生成昨日排行
function fsb_creatrank()
	-- --look('12点生成昨日排行',1)
	local alldata=fsb_GetwData()
	local now=GetServerTime()
	local svrTime = GetServerOpenTime() or 0 --开服时间
	-- local kftime=now- svrTime--开服多久
	local kftime=GetDiffDayFromTime(svrTime)+1--开服多久,天数
	if kftime >= kf_cxtime+2 then 
		if alldata==nil or alldata[10]==nil then  return end
		local tEnd=alldata[10][3] or 0
		if now>tEnd then 
			-- --look('生成排行22',1)
			return 
		end
	end
	alldata[6]={}--昨日领奖记录清空
	alldata[4]={}--昨日排行数据清空
	-- Log('寻宝.txt',alldata)
	if alldata[3] ==nil then return end
	for k,v in pairs(alldata[3]) do--今日
		if type(k)==type(0) and type(v)==type({}) then 
			-- Log('寻宝.txt',k)
			-- Log('寻宝.txt',v)
			alldata[4][k]=v
			alldata[3][k]=nil
		end
	end

	-- for i=1,20 do 
	-- 	if type(alldata[2][i])==type({}) then
	-- 		db_RANK_in(2000005101,alldata[2][i][2],alldata[2][i][1])--累计
	-- 	end
	-- 	if type(alldata[4][i])==type({}) then
	-- 		db_RANK_in(2000005102,alldata[4][i][2],alldata[4][i][1])--昨日
	-- 	end
	-- end
	-- --look('生成排行4444',1)
end
--玩家数据重置
function fsb_preset( sid )
	if not fsb_cango( sid ) then
		return
	end
	local pdata=fsb_getpdata( sid )
	if pdata==nil then  return end
	pdata[5]=nil

end
--领奖,itype=1积分领奖,2累积排行,3昨日排行
function fsb_getawards( sid,itype ,num)
	-- --look('领奖,itype=1积分领奖,2累积排行,3昨日排行',1)
	-- --look(itype,1)
	-- --look(num,1)
	if itype==1 then 
		if not fsb_cango( sid,4 ) then
			return
		end
	else
		if not fsb_cango( sid,itype ) then
			return
		end
	end
	local AwardTb
	local getmark
	if itype==1 then --领奖,itype=1积分领奖
		local pdata=fsb_getpdata( sid )
		if pdata==nil then  return end

		local jf=pdata[4] or 0
		if jf<fsb_jf_conf[num].need then 
			return
		end
		if pdata[6]==nil then 
			pdata[6]={}
		end
		getmark=pdata[6]
		if getmark[num]==true then
			return
		end
		----look(fsb_jf_conf)
		AwardTb=fsb_jf_conf[num].awards
	elseif itype==2 then --领奖,2累积排行
		local alldata=fsb_GetwData()
		if alldata==nil then return end
		local lj_data=alldata[2]--排行数据
		if alldata[5]==nil then 
			alldata[5]={}
		end
		getmark=alldata[5]--领奖记录
		if getmark[num]==true then
			return
		end

		if lj_data[num]==nil then return end
		local id=lj_data[num][4]
		if id~=sid then --不在此位,不能领奖
			return 
		end
		local  value=lj_data[num][1]
		AwardTb=fsb_lj_conf[num].awards
		if num<=5 and value>=fsb_lj_conf[num].need then --前5分数够时有额外奖励
			AwardTb=fsb_lj_conf[num].awards2
		end

	elseif itype==3 then --领奖,3昨日排行
		local alldata=fsb_GetwData()
		if alldata==nil then return end
		local zr_data=alldata[4]--排行数据
		if alldata[6]==nil then 
			alldata[6]={}
		end
		getmark=alldata[6]--领奖记录
		if getmark[num]==true then
			return
		end

		if zr_data[num]==nil then return end
		local id=zr_data[num][4]
		if id~=sid then --不在此位,不能领奖
			return 
		end

		local  value=zr_data[num][1]
		AwardTb=fsb_zrph_conf[num].awards
		if num<=5 and value>=fsb_zrph_conf[num].need then --前5分数够时有额外奖励
			AwardTb=fsb_zrph_conf[num].awards2
		end

	else
		return
	end


	local getok = award_check_items(AwardTb) 		
	if not getok then
		return
	end
	-- --look(AwardTb,1)
	GI_GiveAward( sid, AwardTb, "寻宝领奖"..tostring(itype)..tostring(num) )
	getmark[num]=true
	SendLuaMsg(0,{ids=fgetaward,res=1,itype=itype,num=num},9)
end

--活动val=1结束,val=2开启,itype=1为无排行寻宝
function fsb_active(val,tBegin,tAward,tEnd,itype)
	-- Log('寻宝11.txt','活动val=1开启,val=2结束')
	-- Log('寻宝11.txt',val)
	-- look('寻宝11',1)
	-- look(val,1)
	-- --look(tBegin,1)
	-- --look(tAward,1)
	-- --look(tEnd,1)
	-- --look(itype,1)
	local alldata=fsb_GetwData()
	-- Log('寻宝11.txt',alldata)
	if not itype then
		if val==2 then 
			if alldata[10]==nil or alldata[10][1]~=tBegin then 
				for i=1,10 do--清理数据
					alldata[i]=nil
				end
			end
			alldata[10]={tBegin,tAward,tEnd}	--活动时间
		elseif val==1 then 
			for i=1,10 do--清理数据
				alldata[i]=nil
			end
		end
	else
		if val==2 then 
			if alldata[20]==nil or alldata[20][1]~=tBegin then 
				--清理数据
				alldata[11]=nil
				alldata[20]=nil
			end
			alldata[20]={tBegin,tAward,tEnd}	--活动时间
		elseif val==1 then 
			--清理数据
			alldata[11]=nil
			alldata[20]=nil
			
		end
	end
end
--各种权限判断 --itype=1有排行抽奖,2累计排行领奖,3昨天排行领奖
--itype=11无排行抽奖
function fsb_cango( sid,itype )
	local now=GetServerTime()
	local alldata=fsb_GetwData()
	if alldata==nil then return end
	local svrTime = GetServerOpenTime() or 0 --开服时间

	local tBegin,tAward,tEnd


	if itype~=11 then
		if alldata[10]==nil then 
			alldata[10]={}
		end
		 tBegin=alldata[10][1] or 0
		 tAward=alldata[10][2] or 0
		 tEnd=alldata[10][3] or 0
	else
		if alldata[20]==nil then 
			alldata[20]={}
		end
		 tBegin=alldata[20][1] or 0
		 tAward=alldata[20][2] or 0
		 tEnd=alldata[20][3] or 0
	end
	-- local kftime=now- svrTime--开服多久
	local kftime=GetDiffDayFromTime(svrTime)+1--开服多久,天数
	--判断版本
	-- --look('判断版本',1)
	local pdata=fsb_getpdata( sid )
	if pdata==nil then return end
	if (kftime > kf_cxtime +2) then

		if tBegin >0 then--有新活动
			if itype~=11 then
				if pdata[9]==nil or pdata[9]~=tBegin then --版本号不一样,清数据
					for i=2,8 do
						pdata[i]=nil
					end
					pdata[9]=tBegin
				end
			else 
				if pdata[19]==nil or pdata[19]~=tBegin then --版本号不一样,清数据
					for i=12,18 do
						pdata[i]=nil
					end
					pdata[19]=tBegin
				end
			end
		else--无活动
			if itype~=11 then
				if pdata[2]~=nil then --清数据
					for i=2,9 do
						pdata[i]=nil
					end
					
				end
			else--无排行寻宝
				if pdata[12]~=nil then --清数据
					
					for i=12,15 do
						pdata[i]=nil
					end
					
				end
			end
			return
		end
	end
	-- --look('判断版本111',1)
	--判断权限
	if itype==1 then --itype=1抽奖,2累计排行领奖,3昨天排行领奖
		if (kftime > kf_cxtime ) and (now>tAward ) then 
			return
		end
	elseif itype==2 then --itype=1抽奖,2累计排行领奖,3昨天排行领奖
		local res1=kftime > kf_cxtime+2
		local res2=kftime <= kf_cxtime
		if  tBegin==0 then --无活动,判断开服
			if res1 or res2 then 
				return 
			end
		else	--有活动
			if (now>tEnd) or (now<tAward) then 
				return
			end
		end
	elseif itype==3 then --itype=1抽奖,2累计排行领奖,3昨天排行领奖
		if (kftime > kf_cxtime+2 ) and (now>tEnd ) then 
			return
		end
	end

	return true
end
--珍宝兑换
function fsb_zbduihuan( playerid,index )
	-- --look('珍宝兑换',1)
	-- --look(index,1)
	local data=fsb_getpdata( playerid )
	if data==nil then  return end
	if data[7]==nil then
		data[7]={}
	end
	if data[7][index]==true then  return end
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return 
	end 
	local conf=fsb_zbdh_conf[index]
	if conf==nil or conf[1] ==nil then  return end

	local itemid=conf.result
	local needid--需要id
	local neednum--需要个数

	for k,v in pairs(conf[1]) do
		needid=v[1]--需要id
		neednum=v[2]--需要个数
		if needid==nil or neednum==nil then  return end
		if CheckGoods( needid, neednum, 1, playerid,'珍宝兑换') == 0 then--查石头在不
			SendLuaMsg( 0, { ids = equip_comi, succ=2 }, 9 )
			
			return
		end
	end

	GiveGoods(itemid,1,1,'珍宝兑换')--给石头
	for k,v in pairs(conf[1]) do
		needid=v[1]--需要id
		neednum=v[2]--需要个数
		CheckGoods(needid, neednum, 0, playerid,'珍宝兑换')--扣宝石
	end
	
	data[7][index]=true
	SendLuaMsg( 0, { ids = fzbdh, index=index }, 9 )
end


--无排行寻宝积分领奖
function fsb_getawards_norank( playerid )
	local data=fsb_getpdata( playerid )
	if data==nil then  return end
	if data[14]==nil then return end

	local worldlv=rint(GetWorldLevel()/10)*10
	
	if worldlv<40 and norank_jfconf_award[worldlv]==nil then
		worldlv=40
		
	end
	
	-- --look(worldlv,1)
	if worldlv>60 and norank_jfconf_award[worldlv]==nil then
	-- --look(111,1)
		worldlv=60
	end
	local norank_jfconf=norank_jfconf_award[worldlv]

	
	for i=1,#norank_jfconf do
		if data[14]>=norank_jfconf[i][1] then 
			local pakagenum = isFullNum()
			if pakagenum < 1 then
				TipCenter(GetStringMsg(14,1))
				break 
			end 
			if (data[15] or 0)<i then 
				GiveGoods(norank_jfconf[i][2],norank_jfconf[i][3],norank_jfconf[i][4],'无排行寻宝积分领奖')
				data[15]=i
			end
		end
	end

	SendLuaMsg( 0, { ids = norank_jfres, index=data[15] }, 9 )
end