--[[
file:	qizhenge_fun.lua
desc:	珍珠阁
author:	ct
update:	2014-7-18
]]
local msgh_s2c_def	= msgh_s2c_def
local msg_qzg_goods =msgh_s2c_def[52][1]
local msg_Refresh =msgh_s2c_def[52][2]
local msg_goods_buying =msgh_s2c_def[52][3]
local msg_goods_Refresh = msgh_s2c_def[52][4]
local GI_GetPlayerData = GI_GetPlayerData
local conf   = require("Script.qizhenge.qizhenge_conf")
local goods_all = conf.goods_all
local rint = rint
local SendLuaMsg = SendLuaMsg
local GetServerTime = GetServerTime
local CheckCost = CheckCost
local common_rnd = require('Script.common.random_norepeat')
local pairs = pairs
local random = math.random
local GiveGoods = GiveGoods
local  GetWorldCustomDB = GetWorldCustomDB
local  look = look
local type = type
local GetWorldLevel = GetWorldLevel
local isFullNum = isFullNum
module(...)
--定义世界数据	
local function qzg_GetwData()
	local getwc_data = GetWorldCustomDB()
	if getwc_data == nil then
		return
	end
	getwc_data.qzg_data = getwc_data.qzg_data or {}
	--[[
		[1] = 活动开启标识
		[2] = _get_af_data(playerid)
	]]
	return getwc_data.qzg_data
end

--每日清空
--1 表示 物品索引   [1] 索引 [2] 表示物品剩余次数 [3] 是否购买 [4] 折扣刷新次数
--添加进世界数据
---------------------------------
local function _get_af_data(playerid)
	local qzg_data =  qzg_GetwData()
	if qzg_data == nil then return end
	qzg_data[2] = qzg_data[2] or {}
	qzg_data[2][playerid] = qzg_data[2][playerid] or {} 
		--[[	[1] = {
						[索引] = {
							[1] = 剩余购买次数
							}
						}
				[2]={
					[道具] = {
						[1] =  {
								[1] = 索引
								[2] = 剩余购买次数
								[3] =折扣刷新次数 
								[4] = 是否购买标识
								[5] = 折扣索引
								}
						[2] = {
								....
								}
						[3] = 道具索引
						[4] = 道具索引
						[5] = 道具索引
						[6] = 道具索引
					}
				[3] = {
						[1] =时间
						[2] =物品刷新次数
					}
				}
			]]
	return qzg_data[2][playerid]
end
--判断活动是否 开启
local function qzg_Opening(playerid)
	local qzg_open =qzg_GetwData()
	if nil == qzg_open[1] then
		return false
	else
		return true
	end
end
--查找以前是否有生成过 买过的商品
local function qzg_goods_buy(suoyin,qzg_data)
	if nil == suoyin or nil == qzg_data then
		return -5
	end
	local suoyin1 = rint(suoyin/100)
	local suoyin2 = suoyin%100
	if nil == qzg_data[1] or nil == qzg_data[1][suoyin] then
		return  goods_all[suoyin1][suoyin2][4]
	end
	return qzg_data[1][suoyin]
end
--按照概率生成折扣
local function qzg_gailv(qzg_suoyin)
	if nil == qzg_suoyin  then
		return -4
	end
	local suoyin1 = rint(qzg_suoyin/100)
	local suoyin2 = qzg_suoyin%100
	local gaivl1 = goods_all[suoyin1][suoyin2][5][2]
	local gaivl2 = goods_all[suoyin1][suoyin2][6][2]
	local gaivl3 = goods_all[suoyin1][suoyin2][7][2]
	local gailv1 = random(1,100)
	if gailv1 <= gaivl1 then
		return 5
	elseif gailv1 >gaivl1 and gailv1<= gaivl1+gaivl2 then	
		return 6
	elseif gailv1 > gaivl1+gaivl2 and gailv1 <= gaivl1+gaivl2 + gaivl3 then
		return 7
	elseif gailv1 > gaivl1+gaivl2 + gaivl3 and gailv1 <= 100 then
		return 8
	end
	return -8
end
--随机折扣 和商品剩余次数
local function qzg_zhekou(index,key,qzg_data)
	if nil == qzg_data[3] then 	return -3 	end
	local last = qzg_goods_buy(key,qzg_data)
	if type(last) == type(0) then
		if last <0 then  return last end
	end
	local zhekou1 = qzg_gailv(key)
	if zhekou1 <0  then  return zhekou1 end
	if index == 1 and 3 == rint(key/100) and 3>= (qzg_data[3][2] or 0) then
		qzg_data[2][index] = {key,last,0,0,8}
	else
		qzg_data[2][index]= {key,last,0,0,zhekou1}
	end
	return index + 1
	--刷新前三次 必出一个四折区域的 一个两折商品
end
--获取商品
local function get_goods(qujian,maxind,qzg_data,index)
	if nil == qzg_data or nil ==qujian or nil == index then 
		return -2
	end
	local rnum = random(1,#goods_all[qujian])
	if 0 ~= (qzg_data[3][2] or 1 )%2 and 4 == qujian then return index end
	for i=1,#goods_all[qujian] do
		local key = qujian*100+ rnum
		if nil == qzg_data[1][key]  or qzg_data[1][key] >=1   then
			index = qzg_zhekou(index,key,qzg_data)
			if index < 0  then return index end
		end
		if index > maxind then 	break 	end
		--判断是否循环到表尾
		rnum = rnum%(#goods_all[qujian]) +1
	end
	return index
end
--随机商品 
	--qujian 表示区间是哪一个折扣区  num  表示 随机几个商品
	--返回商品索引
	---3随机折扣和获取剩余次数出错 -4 概率出折扣出错 
local  function qzg_discount(qujian,maxind,qzg_data,index)
	if nil == qujian or qujian >=5 or nil == maxind or nil == qzg_data or nil == index then
		return -1
	end
	index = get_goods(qujian,maxind,qzg_data,index)
	return index
end
----------------------------------------------------------------
-- _qzg_first   函数是 用户第一次使用的时候调用 产生  六个(按照折扣区的随机数量) 随机商品
--物品刷新
local function _qzg_goodsRandom(playerid,spid)
	local qzg_bool = qzg_Opening(playerid)   --判断活动是否开启
	if false == qzg_bool then return end
	local qzg_data = _get_af_data(playerid)
	if nil == qzg_data then return end
	--商品购买完 免费刷新
	--判断是否是这一天的第一次登陆
	--点击物品耍新   第一种  时间到了可以刷新   第二种   上次六个商品购买完了可以刷新  第三种  直接用钱可以刷新
	local now_time = GetServerTime()
	qzg_data[1] = qzg_data[1] or {}
	qzg_data[2] = qzg_data[2] or {}
	qzg_data[3] = qzg_data[3] or {}
	local qzg_time = qzg_data[3][1] or 0
	if   qzg_time and now_time < qzg_time then
		local qzg_gm = false
		for i = 1,6 do
			if 0 == qzg_data[2][i][4] then
				qzg_gm = true
				break
			end
		end
		if  qzg_gm then
			if  CheckCost (playerid,10,1,1,"商品用钱刷新") == false  then	
				return
			end
			CheckCost (playerid,10,0,1,"商品用钱刷新")
		end
	end
	local index = 1
	local qzg_time = GetServerTime()+3600
		--每隔两次刷新  出现一个特殊商品
	index  = qzg_discount(3,index+1,qzg_data,index)
	if index <0 then return index  	end
	index  = qzg_discount(4,index,qzg_data,index)
	if index <0 then  return index end     			---5 判断商品是否购买过出错
	index  = qzg_discount(2,index,qzg_data,index)
	if index <0 then   return index end
	index  = qzg_discount(1,6,qzg_data,index)
	if index <0 then  return index end
	qzg_data[3][1] = qzg_time
	qzg_data[3][2] = (qzg_data[3][2] or 0) +1
	if 1 == qzg_data[3][2] then
		SendLuaMsg(0,{ids=msg_qzg_goods,sj = qzg_time,sy = qzg_data[2]},9)
	else
		SendLuaMsg(0,{ids=msg_goods_Refresh,sj = qzg_time,sy = qzg_data[2]},9)
	end
	return index
end
--客户端刷新处理
local function _qzg_Client(playerid)
	local qzg_data = _get_af_data(playerid)
	SendLuaMsg(0,{ids=msg_qzg_goods,sj = qzg_data[3][1],sy = qzg_data[2]},9)
end
--单个 物品折扣刷新
	-- playerid 表示该用户的ID    spid 表示刷新商品的 索引
local function _commodities_Refresh (playerid,spid)
	local qzg_bool = qzg_Opening(playerid)   --判断活动是否开启
	if false == qzg_bool then 	return	end
	local qzg_data = _get_af_data(playerid)
	local qzg_dt =  qzg_data[2][spid]
	if nil == spid or (spid < 1 or spid > 6) then 	return 	end
	local zhek = qzg_dt[5] or 0
	--折扣最低了 无法再刷新
	--刷新三次以后无法再刷
	if 8 <= zhek or 3<  qzg_dt[3]   then
		SendLuaMsg(0,{ids = msg_Refresh,suoy = spid,zk = qzg_dt[5],cs = qzg_dt[3]},9)
		return 
	end
	local money = 0
	if 0 == qzg_dt[3] or 1 == qzg_dt[3] then
		money =  (qzg_dt[3]+1) * 5
	elseif 2 == qzg_dt[3] then
		money = 20
	end
	if CheckCost(playerid,money,1,1,"商品折扣刷新扣钱") == false  then
		return
	end
	CheckCost (playerid,money,0,1,"商品折扣刷新扣钱")
	zhek = zhek+1
	qzg_dt[5] = qzg_dt[5]+1
	qzg_dt[3] = qzg_dt[3]+1
	SendLuaMsg(0,{ids = msg_Refresh,suoy = spid,zk = qzg_dt[5],cs = qzg_dt[3]},9)
end
--物品购买 
local function _goods_buying(playerid,spid)
	local qzg_bool = qzg_Opening(playerid)   --判断活动是否开启
	if false == qzg_bool then return end
	--判断背包是否有剩余位置
	local snum = isFullNum()
	if snum< 1 then return 	end
	local qzg_data = _get_af_data(playerid)
	local qzg_dt = qzg_data[2][spid]
	local zhek = qzg_dt[5]
	local val = rint(qzg_dt[1]/100)
	local val2 = qzg_dt[1]%100
	local money = goods_all[val][val2][zhek][3]	
	if 0 >=  money  then return end
	if 1 == qzg_dt[4] then return end
	if CheckCost (playerid,money,1,1,"珍珠阁道具购买 ") == false then
		return
	end	
	CheckCost (playerid,money,0,1,"珍珠阁道具购买")
	qzg_data[1] = qzg_data[1] or {}
	local key1= qzg_dt[1]
	if 	qzg_dt[2] ~= true then
		qzg_dt[2]=qzg_dt[2] -1
		qzg_data[1][key1]=qzg_dt[2]
	end
	qzg_dt[4] = 1
	local daoju = goods_all[val][val2][1]
	local dj_num = goods_all[val][val2][2]
	GiveGoods(daoju,dj_num,1,"珍珠阁道具购买")	
	SendLuaMsg(0,{ids =msg_goods_buying,suoy = spid,gm = qzg_dt[4],gcs = qzg_dt[2]},9)
end
--晚上购买次数恢复
local function _qzg_num_clear(playerid)
	local qzg_data = _get_af_data(playerid)
	if nil == qzg_data then
		return
	end
	local qzg_bool = qzg_Opening(playerid)   --判断活动是否开启
	if false == qzg_bool then 	return	end
	if #qzg_data >0 then
		qzg_data[1] = nil 
		qzg_data[1] = {}
		local qzg_dtt = qzg_data[2]
		local sy1,sy2,sy,zk
		for i =1,6 do
			sy1 = rint(qzg_dtt[i][1]/100)
			sy2 = qzg_dtt[i][1]%100
			zk = goods_all[sy1][sy2][4]
			qzg_dtt[i][2] = zk
			sy = qzg_dtt[i][1]
			qzg_data[1][sy] = zk
		end
	end
end
--活动val=1结束,val=2开启
local function _qzg_active (val,tBegin,tAward,tEnd)
	-- look('XXXXXXXXXXXX')
	local alldata=qzg_GetwData()
	-- look('val')
	-- look(val)	
	--val  =1 
	if val==1 then  --清理数据
		alldata[1]=nil 
		alldata[2]=nil
	elseif val==2 then
		if alldata[1]==nil or alldata[1]~=tBegin then 
			alldata[1]={tBegin,tAward,tEnd}	--活动时间	
		end
	end
end

--------------------------------------------------------------------------
qzg_goods = _qzg_goods
goods_buying = _goods_buying
commodities_Refresh   =   _commodities_Refresh
qzg_goodsRandom = _qzg_goodsRandom
qzg_num_clear = _qzg_num_clear
get_af_data = _get_af_data 
qzg_Client = _qzg_Client 
qzg_active = _qzg_active