--[[
file:	store_func.lua
desc:	商城系统
author:	wk
update:	2013-1-21
refix:	done by wk
]]--
--[[
索引标识：（storeid）
[1]普通商店 [2]商城(附带代币) [3]商城限时打折促销 [4]神秘商店 [5]神秘积分商店 [6]通灵积分商店 
[7]帮会商店 (商品受帮会等级限制) [8]狩猎积分 
[9]官职 （官职限制） 
[10]装备 （玩家等级限制） 
[11]果园种子 （山庄等级限制） 
[12] 山庄装饰品商店
[101] 神秘商店批量商店]]--
local look = look
local TP_FUNC = type( function() end)
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local storeend	 = msgh_s2c_def[24][2]	
local storenum	 = msgh_s2c_def[24][3]	
local quick_buy	 = msgh_s2c_def[24][4]	
local f_shop	 = msgh_s2c_def[24][5]	
local w_shop	 = msgh_s2c_def[24][7]	
local world_xg	 =msgh_s2c_def[24][8]	
local isFullNum=isFullNum
local pairs,tostring=pairs,tostring
local type=type
local uv_Store_Conf=Store_List
local GiveGoods,GiveGoodsBatch=GiveGoods,GiveGoodsBatch
local CheckCost=CheckCost
local AddPlayerPoints=AddPlayerPoints
local Garniture_buy=Garniture_buy
local TipCenter,GetStringMsg=TipCenter,GetStringMsg
local __G=_G
local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond

local quickbuyconf=quickbuylist--快捷购买库
local storeMailConf=MailConfig.storeMail
-----------------------------世界限购数据------------------

--商店限购数据区
local function get_fshopdata(sid )
	local pdata=GI_GetPlayerData( sid , 'fshop' , 400 )
	if pdata==nil then return end
	--[[
	[1]={--帮会限购
		[517]=3,id517买了3个
		}
	[2]={--夺城战限购
		[517]=3,id517买了3个
		}
	[3]={--寻宝兑换券限购
		[517]=3,id517买了3个
		}
	[4]={--排位赛积分限购  itype=6
		[517]=3,id517买了3个
		}	
	[5]={--商城每日限购 itype=7
		[517]=3,id517买了3个
		}	
	[6]={--跨服荣誉每日限购 itype=8
		[517]=3,id517买了3个
		}		
	tz={---投资限购,投资结束后清除数据
		[1]={--投资限购1
			[5]=3,索引5买了3个
		}
		[2]={--投资限购2
			[5]=3,索引5买了3个
			}
		}
	]]
	return pdata
end
--商店限购重置
function fshop_reset( sid )
	local fdata=get_fshopdata(sid )
	if fdata==nil then return end
	for i ,j in pairs (fdata) do
		if type(i)==type(0) and type(j)==type({}) then 
			for k,v in pairs(j) do
				if type(k)==type(0) and type(v)==type(0) then 
					j[k]=nil
				end
			end
		end
	end
	local svrTime = GetServerOpenTime() or 0 --开服时间
	if GetServerTime()-svrTime>15*24*3600 then---开服15天后清数据
		fdata.tz=nil
	end
	


	SendLuaMsg(0,{ids=storeend,succ=14},9)
end


-----------------------------世界限购数据------------------
--世界限购数据区
local function Getserver_ltData()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then
		return
	end
	if w_customdata.st_li == nil then
		w_customdata.st_li = {
		--[[
			[1]={id=333,416=666},--开服2日限购
			
		]]--
		}
	end
	return w_customdata.st_li
end

---前台请求世界限购数据
function getworld_lidata( itype )
	local wdata=Getserver_ltData()
	if wdata==nil then return end
	SendLuaMsg(0,{ids=world_xg,itype=itype,data=wdata[itype]},9)
end
----------------------------具体商店购买处理------------------
----------------------------具体商店购买处理------------------
----------------------------具体商店购买处理------------------
----------------------------具体商店购买处理------------------
local call_storefunc={
	--1普通商店购买
	[1]= function (sid,tag,index,num,itemid)
		local storeConf = uv_Store_Conf[1] 
		local t = storeConf[tag][index]--得到需要购买物品的小表
		local id=t[1]--购买id

		local pk=1
		if tag==1 then 
			pk=((GetPlayerPoints(sid,9) or 0)+100)/100
			if pk>5 then 
				pk=5
			end
		end
		local need =rint( t[2]*num*pk)

		--local need = t[2]*num	
		if id==nil or need==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		if not CheckCost( sid , need , 1 , 3, "普通商店") then
			SendLuaMsg(0,{ids=storeend,succ=2},9)
			return
		end
		GiveGoods(id,num,1,'普通商店')
		CheckCost( sid , need , 0 , 3, "普通商店")
		return true
	end,

		
		
	--2商城购买--可以代购
	[2]= function (sid,tag,index,num,itemid,name)
		if name ~= nil then	-- 给好友购买 后台暂时不判断是否是好友
			local o_sid = GetPlayer(name,0)
			if o_sid==nil then
				SendLuaMsg(0,{ids=storeend,succ=12},9)
				return
			end
		end
		local storeConf = uv_Store_Conf[2] 
		local t = storeConf[tag][index]--得到需要购买物品的小表
		local id=t[1]--购买id
		local itype=t[3]--货币类型
		local need = t[2]*num	
		if id==nil or need==nil then  return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		local info="商城"
		if name then 
			info=info.."_赠送_"..name
		end
		if itype==2 then --元宝购买,可为其他人购买
			if not CheckCost( sid , need , 1 , 1, info) then
				SendLuaMsg(0,{ids=storeend,succ=1},9)
				return
			end
			if name then 
				local AwardList={[3]={{id,num,0},}}
				SendSystemMail(name,storeMailConf,1,2,CI_GetPlayerData(5),AwardList)	-- 这里的iType正好对应邮件编号
			else
				GiveGoodsBatch( {{id,num,0},},"商城购买")
			end


			CheckCost( sid , need , 0 , 1, info,id,num)
		elseif itype==5 then --绑定元宝购买
			local now=GetPlayerPoints(sid,3)
			if now==nil then  return  end 
			if now>=need then
				GiveGoods(id,num,1,'绑定元宝购买')
				AddPlayerPoints( sid , 3 , -need,nil,'商城',true )-----------
			else
				SendLuaMsg(0,{ids=storeend,succ=8},9)
				return
			end
		end
		return true
	end,
	--3限购商店购买
	[3]= function (sid,tag,index,num,itemid)
		local one_list=GetLimitstoreWorldData()--取今日限购3个商品表
		if one_list==nil then return end
		local limitdata=one_list.todaydata
		local id=limitdata[index][1]--购买id
		if id ~=itemid then
			look('itemiderror')
			return
		end
		local need = limitdata[index][3]*num
		if not CheckCost( sid , need , 1 , 1, "商城") then
			--TipCenter("元宝不够")
			SendLuaMsg(0,{ids=storeend,succ=1},9)
			return
		end

		--限购
		local maxnum=limitdata[index][5] or 1
		local fdata=get_fshopdata(sid )
		if fdata==nil then return end
		if fdata[5]==nil then 
			fdata[5]={}
		end
		local nownum=fdata[5][id] or 0
		if nownum>=maxnum or num> maxnum-nownum then 
			SendLuaMsg(0,{ids=storeend,succ=4},9)
			return
		end
		fdata[5][id]=nownum+num	
		SendLuaMsg(0,{ids=f_shop,index=id,num=fdata[5][id],itype=7},9)

		CheckCost( sid , need , 0 , 1, "限购商城",id,num)
		GiveGoods(id,num,1,'3限购商店购买')

		-- if  CheckTimes(sid,index+6,num,-1) then
		-- 	GiveGoods(id,num,1,'3限购商店购买')
		-- 	CheckCost( sid , need , 0 , 1, "限购商城",id,num)
		-- else
		-- 	SendLuaMsg(0,{ids=storeend,succ=4},9)
		-- 	return
		-- end
		return true
	end,
	--5神秘商店积分兑换	
	[5]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[5][tag][index]
		local id=t[1]
		local need=t[2]*num
		if id==nil or need==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		local nowscore=GetPlayerPoints( sid , 5 )--==========后面加，得到现在积分===============
		if nowscore==nil then return end
		if nowscore<need then
			look("Store5scoreerror")
			SendLuaMsg(0,{ids=storeend,succ=5},9)
			return
		end
		GiveGoods(id,num,1,'5神秘商店积分兑换')
		AddPlayerPoints( sid , 5 , -need ,nil,'商城',true)
		return true
	end,
	--6通灵积分兑换	
	[6]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[6][tag][index]
		local id=t[1]
		local need=t[2]
		if id==nil or need==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		yy_exchange(sid,id,need)
		
	end,
	--7帮会商店
	[7]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[7][tag][index]
		local id=t[1]
		local need=t[2]*num
		local needlv=t[4]--所需帮会等级

		if id==nil or need==nil  or needlv==nil then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		local fid = CI_GetPlayerData(23)
		if fid == nil or fid == 0 then
			return --帮会不存在
		end
		local nowlv=CI_GetFactionInfo(nil,5)--取帮会商店等级
		if nowlv<needlv then
			SendLuaMsg(0,{ids=storeend,succ=7},9)
			return
		end
		local nowbg=GetPlayerPoints(sid,4)--取现在帮贡
		if nowbg<need then
			
			SendLuaMsg(0,{ids=storeend,succ=11},9)
			return
		end

		local maxnum=t[5] or 1000 --限购个数
		local fdata=get_fshopdata(sid )
		if fdata==nil then return end
		if fdata[1]==nil then 
			fdata[1]={}
		end
		local nownum=fdata[1][id] or 0
		if nownum>=maxnum or num> maxnum-nownum then 
			return
		end

		fdata[1][id]=nownum+num	
		GiveGoods(id,num,1,'帮会商店')
		AddPlayerPoints( sid , 4 , -need,nil,'帮会商店' ,true)--扣帮贡
		SendLuaMsg(0,{ids=f_shop,index=id,num=fdata[1][id],itype=1},9)
		return true
	end	,
	--8狩猎积分兑换	
	[8]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[8][tag][index]
		local id=t[1]
		local need=t[2]*num
		if id==nil or need==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		local pdata =  GI_GetPlayerData(sid,'zm',32)
	--[1] 次数限制 
	--[2] 积分 
		local nowcore=pdata[2]
		if nowcore<need then
			SendLuaMsg(0,{ids=storeend,succ=5},9)
			return
		end

		pdata[2] = nowcore-need
		RPC('ZM_update',pdata[2])
		GiveGoods(id,num,1,'8狩猎积分兑换')	
		return true
	end,
	--9官职商店
	[9]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[9][tag][index]
		local id=t[1]
		local need=t[2]*num
		local needlv=t[4]--所需官职等级
		local needitem=uv_Store_Conf[9].needitem[1]
		if id==nil or need==nil or needlv==nil or needitem==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		local nowlv=GetPos(GetPlayerPoints( sid , 6 )) --现在官职等级===============================后面改
		if nowlv<needlv then 
			SendLuaMsg(0,{ids=storeend,succ=6},9)
			return
		end
		if not (CheckGoods(needitem, need,0,sid,'9官职商店') == 1) then
			--look("needitemerror=="..needitem)
			--look("need=="..need)
			SendLuaMsg(0,{ids=storeend,succ=9},9)
			return 
		end
		GiveGoods(id,num,1,'官职商店')	
		return true
	end,
	--10饰品商店
	[10]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[10][tag][index]
		local id=t[1]
		local need=t[2]*num
		local needlv=t[4]--所需人物等级
		local needitem=uv_Store_Conf[9].needitem[1]
		if id==nil or need==nil or needlv==nil or needitem==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		local nowlv=CI_GetPlayerData(1)--现在人物等级
		if nowlv<needlv then 
			SendLuaMsg(0,{ids=storeend,succ=3},9)
			return
		end
		if not (CheckGoods(needitem, need,0,sid,'10饰品商店') == 1) then
			SendLuaMsg(0,{ids=storeend,succ=9},9)
			return 
		end
		GiveGoods(id,num,1,'饰品商店')	
		-- look("兑换成功")
		return true
	end,
	--11果园种子商店
	[11]= function (sid,tag,index,num,itemid)

		local t=uv_Store_Conf[11][tag][index]
		local id=t[1]
		local need=t[2]*num
		local needlv=t[4]--所需人物等级
		if id==nil or need==nil or needlv==nil  then  return end
		if id~=itemid then
	
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		--现在家园等级
		local pManorData = GetManorData_Interf(sid)
		if pManorData == nil then  return end
		local nowlv = pManorData.mLv or 1

		if nowlv<needlv then 
			SendLuaMsg(0,{ids=storeend,succ=3},9)

			return
		end	
		if not CheckCost( sid , need , 1 , 3) then
			SendLuaMsg(0,{ids=storeend,succ=2},9)

			return
		end
		GiveGoods(id,num,1,'果园种子')
		CheckCost( sid , need , 0 , 3, "果园种子")
		return true
		
	end,
	--12山庄装饰商店--
	[12]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[12][tag][index]
		local id=t[1]
		local need=t[2]
		local addexp=t[4]--所给经验
		if id==nil or need==nil or addexp==nil  then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		Garniture_buy(sid,tag,index,num,itemid)
		return true
	end,
	--13攻城战商店
	[13]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[13][tag][index]
		local id=t[1]
		local need=t[2]*num
		

		if id==nil or need==nil  then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end

		local fid = CI_GetPlayerData(23)
		if fid == nil or fid == 0 then
			return --帮会不存在
		end
		-- local firstfid=1
		-- if fid~=firstfid then ---非夺城战第一名

		-- 	return 
		-- end
		local itype=t[3]--货币类型
		if itype==2 then --铜币
			if not CheckCost( sid , need , 1 , 3, "13攻城战商店") then
				SendLuaMsg(0,{ids=storeend,succ=2},9)
				return
			end
		elseif itype==1 then --元宝
			if not CheckCost( sid , need , 1 , 1, "13攻城战商店") then
				SendLuaMsg(0,{ids=storeend,succ=1},9)
				return
			end
		else
			return
		end
		
		
		local maxnum=t[5] or 1000 --限购个数
		local fdata=get_fshopdata(sid )
		if fdata==nil then return end
		if fdata[2]==nil then 
			fdata[2]={}
		end
		local nownum=fdata[2][id] or 0
		if nownum>=maxnum or num> maxnum-nownum then 
			return
		end

		fdata[2][id]=nownum+num	

		if itype==2 then --铜币
			CheckCost( sid , need , 0 , 3, "13攻城战商店")
		elseif itype==1 then --元宝
			CheckCost( sid , need , 0 , 1, "13攻城战商店")
		else
			return
		end

		GiveGoods(id,num,1,'13攻城战商店')
		
		SendLuaMsg(0,{ids=f_shop,index=id,num=fdata[2][id],itype=2},9)
		return true
	end	,
	--14寻宝积分商店
	[14]= function (sid,tag,index,num,itemid)
		look('14寻宝积分商店')
		look(tag)
		look(index)
		look(itemid)
		local t=uv_Store_Conf[14][tag][index]
		local id=t[1]
		local need=t[2]*num
		

		if id==nil or need==nil  then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			look(333)
			return
		end
		local pdata=fsb_getpdata( sid )
		if pdata==nil then look(222) return end
		if (pdata[10] or 0)<need then 
			look(111)
			return
		end
		
		pdata[10]=pdata[10]-need

		GiveGoods(id,num,1,'15寻宝兑换券商店')
		return true,need
	end	,
	--15寻宝兑换券商店
	[15]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[15][tag][index]
		local id=t[1]
		local need=t[2]*num
		

		if id==nil or need==nil  then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end

		local needitem=uv_Store_Conf[15].needitem[1]
		if not (CheckGoods(needitem, need,1,sid,'15寻宝兑换券商店') == 1) then
			SendLuaMsg(0,{ids=storeend,succ=9},9)
			return 
		end

		local maxnum=t[4] --限购个数
		if maxnum then
			local fdata=get_fshopdata(sid )
			if fdata==nil then return end
			if fdata[3]==nil then 
				fdata[3]={}
			end
			local nownum=fdata[3][id] or 0
			if nownum>=maxnum or num> maxnum-nownum then 
				return
			end
			fdata[3][id]=nownum+num	
			CheckGoods(needitem, need,0,sid,'15寻宝兑换券商店')
			SendLuaMsg(0,{ids=f_shop,index=id,num=fdata[3][id],itype=3},9)
		else
			CheckGoods(needitem, need,0,sid,'15寻宝兑换券商店')
		end
		
		GiveGoods(id,num,1,'15寻宝兑换券商店')
		return true,need
	end	,
	--16全服限购商店
	[16]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[16][tag][index]
		local id=t[1]
		local need=t[2]*num
		if id==nil or need==nil  then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end

		if not CheckCost( sid , need, 1 , 1, "16全服限购商店") then
			return
		end
		local maxnum=t[4] --限购个数
	
		local sdata=Getserver_ltData()
		if sdata==nil then return end
		if sdata[1]==nil then 
			sdata[1]={}
		end
		local nownum=sdata[1][id] or 0
		if nownum>=maxnum or num> maxnum-nownum then 
			SendLuaMsg(0,{ids=storeend,succ=15},9)
			return
		end
		sdata[1][id]=nownum+num
		if not CheckCost( sid , need, 0 , 1, "16全服限购商店") then
			return
		end
		SendLuaMsg(0,{ids=w_shop,index=id,num=sdata[1][id],itype=1},9)
		GiveGoods(id,num,1,'16全服限购商店')
		return true,need
	end	,
	--17投资限购商店
	[17]= function (sid,tag,index,num,itemid)

		local svrTime = GetServerOpenTime() or 0 --开服时间
		if GetServerTime()-svrTime>15*24*3600 then return end

		local t=uv_Store_Conf[17][tag][index]
		local id=t[1]
		local need=t[2]*num
		look(111111,1)
		if id==nil or need==nil  then  return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			look(123,1)
			return
		end
		look(222,1)
		if not CheckCost( sid , need, 1 , 1, "17投资限购商店") then
			look(78,1)
			return
		end

		if t[6] then ---等级限制
			if CI_GetPlayerData(1)<t[6] then 
				look(555,1)
				return
			end
		end

		if t[7] and t[7] >0 then --vip等级限制
			local vtype = GI_GetVIPType( sid ) or 0
			if vtype < 2 then
				return
			end
			local vip=GI_GetVIPLevel( sid ) or 0
			if vip<t[7] then 
				look(444,1)
				return
			end
		end


		local maxnum=t[4] --限购个数
		
		local fdata=get_fshopdata(sid )
		if fdata==nil then return end
		if fdata.tz==nil then 
			fdata.tz={}
		end

		local sdata=fdata.tz
		if sdata==nil then return end
		if sdata[1]==nil then 
			sdata[1]={}
		end
		local nownum=sdata[1][index] or 0
		if nownum>=maxnum or num> maxnum-nownum then 
			SendLuaMsg(0,{ids=storeend,succ=15},9)
			look(644,1)
			return
		end
		sdata[1][index]=nownum+num
		if not CheckCost( sid , need, 0 , 1, "17投资限购商店") then
			look(666,1)
			return
		end
		look('购买成功',1)
		SendLuaMsg(0,{ids=f_shop,index=index,num=sdata[1][index],itype=4},9)
		local getnum=t[8] or 1
		GiveGoods(id,num*getnum,1,'17投资限购商店')
		return true,need
	end	,

	--18投资限购商店2
	[18]= function (sid,tag,index,num,itemid)
		local svrTime = GetServerOpenTime() or 0 --开服时间
		if GetServerTime()-svrTime>15*24*3600 then return end


		local t=uv_Store_Conf[18][tag][index]
		local id=t[1]
		local need=t[2]*num
		-- look(111,1)
		if id==nil or need==nil  then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			-- look(222,1)
			return
		end
		if not CheckCost( sid , need, 1 , 1, "18投资限购商店") then
			-- look(3333,1)
			return
		end
		if t[6] then ---等级限制
			if CI_GetPlayerData(1)<t[6] then 
				-- look(33443,1)
				return
			end
		end

		if t[7] and t[7] >0 then --vip等级限制
			local vtype = GI_GetVIPType( sid ) or 0
			if vtype < 2 then
				return
			end
			local vip=GI_GetVIPLevel( sid ) or 0
			if vip<t[7] then 
				-- look(311,1)
				return
			end
		end


		local maxnum=t[4] --限购个数
		
		local fdata=get_fshopdata(sid )
		if fdata==nil then return end
		if fdata.tz==nil then 
			fdata.tz={}
		end
		-- look(8888,1)
		local sdata=fdata.tz
		if sdata==nil then  return end
		if sdata[2]==nil then 
			sdata[2]={}
		end
		local nownum=sdata[2][index] or 0
		if nownum>=maxnum or num> maxnum-nownum then 
			-- look(8666,1)
			SendLuaMsg(0,{ids=storeend,succ=15},9)
			return
		end
		sdata[2][index]=nownum+num
		-- look(988,1)
		if not CheckCost( sid , need, 0 , 1, "18投资限购商店") then
			return
		end
		-- look(999,1)
		SendLuaMsg(0,{ids=f_shop,index=index,num=sdata[2][index],itype=5},9)
		local getnum=t[8] or 1
		GiveGoods(id,num*getnum,1,'18投资限购商店')
		return true,need
	end	,
	--19稀有商店
	[19]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[19][tag][index]
		local id=t[1]
		local need=t[2]*num
		local needitem=uv_Store_Conf[19].needitem[1]
		if id==nil or need==nil  or needitem==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		if not (CheckGoods(needitem, need,0,sid,'19稀有商店') == 1) then
			SendLuaMsg(0,{ids=storeend,succ=9},9)
			return 
		end
		GiveGoods(id,num,1,'19稀有商店')	
		return true
	end,
	--20排位赛荣誉兑换	
	[20]= function (sid,tag,index,num,itemid)
		if IsSpanServer() then return end
		local t=uv_Store_Conf[20][tag][index]
		local id=t[1]
		local need=t[2]*num
		if id==nil or need==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		local nowscore=GetPlayerPoints( sid , 10 )--==========后面加，得到现在积分===============
		if nowscore==nil then return end
		if nowscore<need then
			look("Store5scoreerror")
			SendLuaMsg(0,{ids=storeend,succ=5},9)
			return
		end

		local maxnum=t[4]  --限购个数
		if maxnum then
			local fdata=get_fshopdata(sid )
			if fdata==nil then return end
			if fdata[4]==nil then 
				fdata[4]={}
			end
			local nownum=fdata[4][id] or 0
			if nownum>=maxnum or num> maxnum-nownum then 
				return
			end
			fdata[4][id]=nownum+num	
			SendLuaMsg(0,{ids=f_shop,index=id,num=fdata[4][id],itype=6},9)
		end

		AddPlayerPoints( sid , 10 , -need ,nil,'20神秘商店积分兑换',true)
		GiveGoods(id,num,1,'20神秘商店积分兑换')
		return true
	end,
	--21跨服荣誉限购商店
	[21]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[21][tag][index]
		local id=t[1]
		local need=t[2]*num
		-- look(111,1)
		if id==nil or need==nil  then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			-- look(222,1)
			return
		end

		local nowscore=GetPlayerPoints( sid , 13 )--==========后面加，得到现在积分===============
		if nowscore==nil then return end
		if nowscore<need then
			look("Store5scoreerror")
			SendLuaMsg(0,{ids=storeend,succ=5},9)
			return
		end

		local maxnum=t[4]  --限购个数
		if maxnum then
			local fdata=get_fshopdata(sid )
			if fdata==nil then return end
			if fdata[6]==nil then 
				fdata[6]={}
			end
			local nownum=fdata[6][id] or 0
			if nownum>=maxnum or num> maxnum-nownum then 
				return
			end
			fdata[6][id]=nownum+num	
			SendLuaMsg(0,{ids=f_shop,index=id,num=fdata[6][id],itype=8},9)
		end

		AddPlayerPoints( sid , 13 , -need ,nil,'21跨服荣誉限购商店',true)
		GiveGoods(id,num,1,'21跨服荣誉限购商店')
		return true
	end	,
	--22老虎机积分兑换
	[22]= function (sid,tag,index,num,itemid)
		look('14寻宝积分商店')
		look(tag)
		look(index)
		look(itemid)
		local t=uv_Store_Conf[22][tag][index]
		local id=t[1]
		local need=t[2]*num
		

		if id==nil or need==nil  then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			look(333)
			return
		end
		local score=lhj_get_score(sid) or 0
		if score<need then 
			look(111)
			return
		end
		
		if not lhj_cost_score(sid,need) then 
			return
		end
		GiveGoods(id,num,1,'22老虎机积分兑换')
		return true,need
	end	,
	--360平台改版用開服特惠
	[23]= function (sid,tag,index,num,itemid)

		local svrTime = GetServerOpenTime() or 0 --开服时间
		if GetServerTime()-svrTime>15*24*3600 then return end

		local plat=__G.__plat
		if plat==101 then --360
			local sec	= GetTimeToSecond(2014,4,11,10,00,00) 
			-- local svrTime = GetServerOpenTime() or 0 --开服时间
			if svrTime<sec then
				return
			end
		end
		
		local t=uv_Store_Conf[23][tag][index]
		local id=t[1]
		local need=t[2]*num
		
		if id==nil or need==nil  then  return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
		
			return
		end
		local itype=t[3]--货币类型
		if itype==2 then --元宝购买
			if not CheckCost( sid , need, 1 , 1, "23商店") then
				return
			end
		elseif itype==5 then 
			local now=GetPlayerPoints(sid,3)
            if now==nil then  return  end 
            if now<need then
            	return
            end
        end

		if t[6] then ---等级限制
			if CI_GetPlayerData(1)<t[6] then 
				
				return
			end
		end

		if t[7] and t[7] >0 then --vip等级限制
			local vtype = GI_GetVIPType( sid ) or 0
			if vtype < 2 then
				return
			end
			local vip=GI_GetVIPLevel( sid ) or 0
			if vip<t[7] then 
				
				return
			end
		end


		local maxnum=t[4] --限购个数
		
		local fdata=get_fshopdata(sid )
		if fdata==nil then return end
		if fdata.tz==nil then 
			fdata.tz={}
		end

		local sdata=fdata.tz
		if sdata==nil then return end
		if sdata[1]==nil then 
			sdata[1]={}
		end
		local nownum=sdata[1][index] or 0
		if nownum>=maxnum or num> maxnum-nownum then 
			SendLuaMsg(0,{ids=storeend,succ=15},9)
			-- look(644,1)
			return
		end
		sdata[1][index]=nownum+num
		if itype==2 then --元宝购买
			if not CheckCost( sid , need, 0 , 1, "23商店") then
				-- look(666,1)
				return
			end
		elseif itype==5 then 
			 AddPlayerPoints( sid , 3 , -need,nil,'23商店',true )
		end
		-- look('购买成功',1)
		SendLuaMsg(0,{ids=f_shop,index=index,num=sdata[1][index],itype=4},9)
		local getnum=t[8] or 1
		GiveGoods(id,num*getnum,1,'23投资限购商店')
		return true,need
	end	,

	--360平台改版用
	[24]= function (sid,tag,index,num,itemid)
		local svrTime = GetServerOpenTime() or 0 --开服时间
		if GetServerTime()-svrTime>15*24*3600 then return end

		local plat=__G.__plat
		if plat==101 then --360
			local sec	= GetTimeToSecond(2014,4,11,10,00,00) 
			-- local svrTime = GetServerOpenTime() or 0 --开服时间
			if svrTime<sec then
				return
			end
		end

		local t=uv_Store_Conf[24][tag][index]
		local id=t[1]
		local need=t[2]*num
		-- look(111,1)
		if id==nil or need==nil  then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			-- look(222,1)
			return
		end
		if not CheckCost( sid , need, 1 , 1, "24商店") then
			-- look(3333,1)
			return
		end
		if t[6] then ---等级限制
			if CI_GetPlayerData(1)<t[6] then 
				-- look(33443,1)
				return
			end
		end

		if t[7] and t[7] >0 then --vip等级限制
			local vtype = GI_GetVIPType( sid ) or 0
			if vtype < 2 then
				return
			end
			local vip=GI_GetVIPLevel( sid ) or 0
			if vip<t[7] then 
				-- look(311,1)
				return
			end
		end


		local maxnum=t[4] --限购个数
		
		local fdata=get_fshopdata(sid )
		if fdata==nil then return end
		if fdata.tz==nil then 
			fdata.tz={}
		end
		-- look(8888,1)
		local sdata=fdata.tz
		if sdata==nil then  return end
		if sdata[2]==nil then 
			sdata[2]={}
		end
		local nownum=sdata[2][index] or 0
		if nownum>=maxnum or num> maxnum-nownum then 
			-- look(8666,1)
			SendLuaMsg(0,{ids=storeend,succ=15},9)
			return
		end
		sdata[2][index]=nownum+num
		-- look(988,1)
		if not CheckCost( sid , need, 0 , 1, "24投资限购商店") then
			return
		end
		-- look(999,1)
		SendLuaMsg(0,{ids=f_shop,index=index,num=sdata[2][index],itype=5},9)
		local getnum=t[8] or 1
		GiveGoods(id,num*getnum,1,'24投资限购商店')
		return true,need
	end	,
	--25荣耀商店
	[25]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[25][tag][index]
		local id=t[1]
		local need=t[2]*num
		local needitem=uv_Store_Conf[25].needitem[1]
		if id==nil or need==nil  or needitem==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		if not (CheckGoods(needitem, need,0,sid,'25荣耀商店') == 1) then
			SendLuaMsg(0,{ids=storeend,succ=9},9)
			return 
		end
		GiveGoods(id,num,1,'25荣耀商店')	
		return true
	end,
	--26世界杯商店
	[26]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[26][tag][index]
		local id=t[1]
		local need=t[2]*num
		local needitem=uv_Store_Conf[26].needitem[tag]
		if id==nil or need==nil  or needitem==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		if not (CheckGoods(needitem, need,0,sid,'26世界杯商店') == 1) then
			SendLuaMsg(0,{ids=storeend,succ=9},9)
			return 
		end
		GiveGoods(id,num,1,'26世界杯商店')	
		return true
	end,
}




-----------------------------入口函数处理----------------------------------
---------------------------------------------------------------------------
-----------------------------入口函数处理----------------------------------
--商店购买统一入口
function mainstore(sid,storeid,tag,index,num,itemid,name)

	if storeid==nil or tag == nil or index == nil or num == nil or itemid==nil then return end
	if num>999  or num<=0  then return end
	if storeid==4 or storeid==101 then --神秘商店
		local succ=buymystical(sid,storeid,tag,index,num,itemid)
		if succ then
			SendLuaMsg(0,{ids=storeend,succ=0,storeid=storeid,itemid=itemid},9)
		end
		return
	end
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return
	end
	--local funcname=_G["Store"..storeid]
	local funcname=call_storefunc[storeid]
	if type(funcname)=="function" then
		local succ,need=	funcname(sid,tag,index,num,itemid,name)
		if succ then
			SendLuaMsg(0,{ids=storeend,succ=0,storeid=storeid,itemid=itemid,name=name,need=need},9)
		end
		return succ
	end
end


--快捷购买[itype=1购买并使用]
function Quickbuy(sid,id,num,itype)
	if sid==nil or id==nil or num ==nil then return end
	if num>999 or num<=0 then return end
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return 0
	end
	local itemconf=quickbuyconf[id]
	if itemconf==nil then
		look('Quickbuy_conferror',1)
		return
	end
	
	local needmoney=itemconf[1]*num
	local moneytype=itemconf[2]
	if moneytype==1 then
		local pk=((GetPlayerPoints(sid,9) or 0)+100)/100
		if pk>5 then 
			pk=5
		end
		if not CheckCost( sid , rint(needmoney*pk), 0 , 3, "快捷购买") then
			return
		end
	elseif moneytype==2 then
		if not CheckCost( sid , needmoney , 0 , 1, "快捷购买",id,num) then
		return
		end
	elseif moneytype==3 then
		local point=GetPlayerPoints(sid,2)
		local now=point[1]--灵力
		if now==nil then return end 
		if now>=needmoney then
			AddPlayerPoints( sid , 2 , -needmoney ,nil,'快捷购买',true)-----------
		else
			return
		end
	elseif moneytype==4 then
		local point=GetPlayerPoints(sid,3)
		local now=point[1]--现在代币
		if now==nil then return end 
		if now>=needmoney then
			AddPlayerPoints( sid , 3 , -needmoney,nil,'快捷购买',true)-----------
		else
			return
		end
	else
		return
	end
	if itype==1 then
		local canuse=itemconf[3]
		if canuse~=1 then
			GiveGoods(id,num,1,'快捷购买')
			return
		end
		-- local funname='OnUseItem_batch'..tostring(id)
		-- local func = _G[funname ]
		local res=OnUseItem_batch(id , num,nil,nil,true)
		if not res then
			look('OnUseItem_batch id error id=='..tostring(id),1)
			GiveGoods(id,num,1,'快捷购买')
			return 
		end
		
	else
		GiveGoods(id,num,1,'快捷购买')
	end
	--TipCenter(GetStringMsg(8))
	SendLuaMsg(0,{ids=quick_buy},9)
end