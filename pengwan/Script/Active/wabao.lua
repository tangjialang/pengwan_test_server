--[[
file:	挖宝-副本-商店
author:	wk
update:	2013-12-7
]]--
local wb_pos	 = msgh_s2c_def[12][32]
local wb_get 	 = msgh_s2c_def[12][33]
local wb_err 	 = msgh_s2c_def[12][34]
local wb_fbgoods = msgh_s2c_def[12][35]
local common_rnd = require('Script.common.random_norepeat')
local Get_num 			 = common_rnd.Get_num
local math=math
local GiveGoods = GiveGoods
local GetStringMsg=GetStringMsg
local TipCenter=TipCenter
local look = look
local SendLuaMsg=SendLuaMsg
local pairs=pairs
local isFullNum=isFullNum
local GetPlayerTemp_custom=GetPlayerTemp_custom
local GI_GetPlayerData=GI_GetPlayerData
local CheckCost=CheckCost
local _random=math.random
local _insert=table.insert
local type=type
local active_mgr_m = require('Script.active.active_mgr')
local activitymgr=active_mgr_m.activitymgr
local CheckTimes=CheckTimes
local uv_TimesTypeTb = TimesTypeTb
local GetTimesInfo=GetTimesInfo
local CI_GetPlayerData=CI_GetPlayerData
local CI_GetCurPos=CI_GetCurPos
----------------------------------------------------------------------------
-- module:

module(...)

----------------------------------------------------------------------------

local wa_conf={
	---pos={rid,x,y}
	pos={--坐标
	{1,3,66},{1,6,105},{1,25,123},{1,25,146},{1,10,165},{1,10,125},{1,43,171}, {1,61,165},{1,55,157},{1,80,161},{1,88,135},{1,111,129},{1,98,97},{1,101,75},{1,104,49},{1,110,102}, {1,72,48},{1,72,23},{1,18,12},{1,25,98},
	{7,62,30},{7,61,126},{7,11,113},{7,3,129},{7,28,127},{7,48,139},{7,79,129},{7,84,88},{7,47,93},{7,53,41}, {7,62,37},
	{8,76,108},{8,11,11},{8,8,51},{8,15,66},{8,52,134},{8,74,58},{8,43,27},
	{10,115,114},{10,69,119},{10,101,117},{10,123,127},{10,116,40},{10,87,44},{10,90,13},{10,60,14},{10,34,55},{10,42,104},
		},
	baotu={--宝图类型
			--fbgate=3000,
			fbgate={3000,5000,10000},
			fbgate2={1000,2000,3000,5000,7000,10000},
			[1]={--小藏宝图,awards={ 道具ID,概率,是否绑定}
				
				awards={{750,10000,0},{750,10000,0},{750,10000,0},{603,10000,0},{750,5000,0},{603,5000,0},{751,2000,0},{752,20,0},},
			},

			[2]={--大藏宝图
				
			},
			[3]={--圣诞藏宝图
				
			},
		},

	store={
		--充值<500元宝以下的用户
		[1]={
			stage = {1,4,9},--几次到下个进度
			needyb = 1 , --需要元宝
			--贵重商品库 必出1个  -商品ID,原价,初始折扣价,折扣价1,折扣价2,折扣价3
			[1] = {  
				{412,80,72,64,54,38},
				{422,80,72,64,54,38},
				{432,80,72,64,54,38},
				{442,80,72,64,54,38},

				},
			--普通品库 出7个
			[2]= {
				{754,80,72,64,50,30},
				{755,80,72,64,50,30},
				{756,80,72,64,50,30},
				{710,30,27,24,18,8},
				{411,20,18,16,13,8},
				{421,20,18,16,13,8},
				{431,20,18,16,13,8},
				{441,20,18,16,13,8},
				{751,30,27,24,18,10},

				},
		},
		--充值<10000元宝以下的用户
		[2]={
			stage = {1,4,9},--几次到下个进度
			needyb = 10 , --需要元宝
			--贵重商品库 必出1个  -商品ID,原价,初始折扣价,折扣价1,折扣价2,折扣价3
			[1] = {  
				{752,600,540,480,400,288},
				{737,400,380,340,280,188},
				{662,888,688,588,388,188},

				},
			--普通品库 出7个
			[2]= {
				{754,80,72,64,50,30},
				{755,80,72,64,50,30},
				{756,80,72,64,50,30},
				{710,30,27,24,18,8},
				{751,30,27,24,18,10},
				{713,200,190,170,140,88},
				{732,200,190,170,140,88},
				{692,100,90,80,68,48},
				{693,60,55,50,42,28},
				{1053,68,60,50,38,18},

				},
		},	
		
		--充值>=10000元宝以上的用户
		[3]={
			stage = {1,4,9},--几次到下个进度
			needyb = 10 , --需要元宝
			--贵重商品库 必出1个  -商品ID,原价,初始折扣价,折扣价1,折扣价2,折扣价3
			[1] = {  
				{711,5000,4500,4000,3200,1888},
				{730,5000,4500,4000,3200,1888},
				{763,2500,2250,2000,1600,988},

				},
			--普通品库 出7个
			[2]= {
				{754,80,72,64,50,30},
				{755,80,72,64,50,30},
				{756,80,72,64,50,30},
				{751,30,27,24,18,10},
				{752,600,540,480,400,288},
				{713,200,190,170,140,88},
				{714,800,760,680,580,388},
				{732,200,190,170,140,88},
				{733,800,760,680,580,388},
				{692,100,90,80,68,48},
				{693,60,55,50,42,28},
				{1053,68,60,50,38,18},
				{662,888,688,588,388,188},

				},
		},
		
	},
}

--数据区
function wb_getpdata( sid )
	local pdata=GI_GetPlayerData( sid , 'wbao' , 100 )
	if pdata==nil then return end
	--[[
		[1]=2,--宝图位置,nil为没有
		[2]=1,--宝图类型
		[3]={1,3,5,7}--应该得到物品位置
		[4]=1,--开图次数
	]]--
	return pdata
end
--临时副本数据
function wb_getfbtempdata( sid )
	local cData = GetPlayerTemp_custom(sid)
	if cData == nil  then return end
	if cData.wba == nil then
		cData.wba = {
			--[[
			[1]=1 --进度
			[2]={1,1,2,3,4,5,6,7,} --商店物品
			[3]={1,}--购买记录
			[4]=1--充值档次
			]]
		}
	end
	return cData.wba
end
--使用藏宝图
function wb_usebu( sid,itype )
	local wdata=wb_getpdata( sid )
	if wdata[1] ~=nil then 
		SendLuaMsg(0,{ids=wb_err,res=1},9)
		return 0
	end
	local w_conf=wa_conf.pos
	if w_conf==nil then return 0 end
	local rannum=_random(1,#w_conf)
	wdata[1]=rannum
	wdata[2]=itype
	wdata[3]=nil
	SendLuaMsg(0,{ids=wb_pos,pos=wdata[1],itype=itype},9)
end
--点击挖宝
local function _wb_chick( sid)
	look('点击挖宝')
	local wdata=wb_getpdata( sid )
	if wdata==nil then return end
	if wdata[1]==nil then return end
	local itype=wdata[2]
	local award_conf=wa_conf.baotu[itype].awards
	if wdata[3]==nil then 
		wdata[3]={}
		
		local rannum=_random(1,10000)
		for k,v in pairs(award_conf) do
			if rannum<v[2] then 
				_insert(wdata[3],k)
			end
		end
	end
	
	local pakagenum = isFullNum()
	if pakagenum < #wdata[3] then
		TipCenter(GetStringMsg(14, #wdata[3]))
		return
	end

	for i,j in pairs(wdata[3]) do
		if type(i)==type(0) and type(j)==type(0) then 
			
			GiveGoods(award_conf[j][1],1,award_conf[j][3],'挖宝')
			
		end
	end
	wdata[1]=nil
	wdata[2]=nil
	local fb
	local res=CheckTimes(sid,uv_TimesTypeTb.wabao,1,-1,1)
	
	
	
	if res then 
		local timeinfo=GetTimesInfo(sid,uv_TimesTypeTb.wabao)
		look(timeinfo)
		local ran_fb=_random(1,10000)
		local nowtime=wdata[4] or 0
		local gatenum
		if (timeinfo[1] or 0)==0 then 
			gatenum=wa_conf.baotu.fbgate[nowtime+1]
		else
			gatenum=wa_conf.baotu.fbgate2[nowtime+1]
		end
		if ran_fb<=(gatenum or 100000)  then 
			fb=true
			wdata[4]=nil
		else
			wdata[4]=nowtime+1
		end
		--CheckTimes(sid,uv_TimesTypeTb.wabao,1,-1) --进入副本扣次数
	end

	SendLuaMsg(0,{ids=wb_get,itype=itype,goods=wdata[3],fb=fb},9)

	
	wdata[3]=nil

	local fata=wb_getfbtempdata( sid )---副本数据
	fata[1]=nil
	fata[2]=nil
	fata[3]=nil
	fata[4]=nil

end


--副本完成,点击出商店
function wb_getstore( sid )
	look('副本完成,点击出商店')
	local cx, cy, rid,isdy = CI_GetCurPos()
	if not isdy then  return end
	look(rid)
	if rid~=513  then return end
	
	local moneylv=CI_GetPlayerData(27) or 0 --累计充值
	local itype=3
	if moneylv<=500 then 
		itype=1
	elseif moneylv<=10000 then 
		itype=2
	end
	local sconf=wa_conf.store[itype]
	local fata=wb_getfbtempdata( sid )
	if fata[2]==nil then
		fata[2]={}
		
		fata[2]=Get_num(fata[2],7,{1,#sconf[2]})--取7个普通物品
		fata[2][8]=_random(1,#sconf[1])--取一个贵重物品

		fata[4]=itype
		--look(fata[2])
	end
	SendLuaMsg(0,{ids=wb_fbgoods,goods=fata[2],drop=fata[1],last=fata[3]},9)
end
--商店贿赂,降低价格
function wb_drop( sid )
	local fata=wb_getfbtempdata( sid )
	local need=wa_conf.store[fata[4]].needyb
	if not  CheckCost( sid , need , 0 , 1, "挖宝商店砍价") then
		SendLuaMsg(0,{ids=wb_err,res=3},9)
		return
	end
	fata[1]=(fata[1] or 0)+1
	SendLuaMsg(0,{ids=wb_fbgoods,drop=fata[1]},9)
end
--购买商品,num买第几个
function wb_buy( sid,num )

	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14, 1))
		return
	end

	local fata=wb_getfbtempdata( sid )
	if fata[3]==nil then 
		fata[3]={}
	end
	if (fata[3][num] or 0 )>0 then 
		SendLuaMsg(0,{ids=wb_err,res=2},9)
		return 
	end
	local goodsnum=fata[2][num]--道具在配置的哪个位置
	local sconf=wa_conf.store[fata[4]]--配置
	local goods	
	if num==8 then --贵重
		goods=sconf[1][goodsnum]
	else--普通
		goods=sconf[2][goodsnum]
	end
	local step=fata[1] or 0
	local down=4
	for k,v in pairs( sconf.stage) do
		if step< v then
			down=k
			break
		end
	end

	local needmoney=goods[2+down]
	local id=goods[1]
	if not  CheckCost( sid , needmoney , 0 , 1, "挖宝商店购买") then
		SendLuaMsg(0,{ids=wb_err,res=3},9)
		return
	end

	GiveGoods(id,1,1,'挖宝商城')
	fata[3][num]=1
	SendLuaMsg(0,{ids=wb_fbgoods,last=fata[3]},9)
end


-------
wb_chick=_wb_chick
wb_getstore=wb_getstore
wb_buy=wb_buy
wb_drop=wb_drop
wb_usebu=wb_usebu


----测试 
--清数据
function wb_clc( sid)
	local cData = GetPlayerTemp_custom(sid)
	if cData == nil  then return end
	cData.wba = nil
		
end