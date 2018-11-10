--[[
file:	Region_Event.lua
desc:	region event register.
author:	chal
update:	2011-12-05
]]--
--[[
  --陷阱接口--【尽量构造成itype=1模式提高性能】
--itype=1,现在场景数据Trapinfo={mapid,x,y,mapgid};---要传入场景数据newinfo={mapid,x,y,mapgid};---陷阱范围length，空默认为3
--itype=2,现在场景数据Trapinfo={mapid,x,y,mapgid};---newinfo=回调脚本id;---陷阱范围length，空默认为3，var=传入参数
 PI_MapTrap(itype,Trapinfo,newinfo,length, var)
]]--
----------------------------------------------------------------
--include:
local type = type
local look = look
local SetTrap = SetTrap
local CI_GetPlayerData = CI_GetPlayerData
local RPC = RPC
local TP_FUNC = type( function() end)
local define = require('Script.cext.define')
local Define_POS = define.Define_POS
local AreaRPC=AreaRPC
--陷阱传送配置
local trapconf={
	--新手村到西岐城
	{2,{2,99,225},301},
	{2,{3,99,225},301},
	{2,{4,99,225},301},
	{2,{5,99,225},301},
	--西岐城  新手村
	{1,{1,3,140},{3,103,219}},
	--西岐城  郊野
	{2,{1,36,169},302},
	--西岐城  帮会运镖
	{1,{1,114,169},{11,7,109}},
	--帮会运镖  西岐城  
	{1,{11,3,113},{1,111,166}},
	--西岐 庄园 特殊出来，不在前台显示
	--{2,{1,48,7},330},
	--郊野 西岐城
	{1,{6,3,111},{1,32,166}},
	--郊野 百鬼妖树
	{2,{6,41,13},303},

	--郊野  沼泽
	{1,{6,67,76},{22,17,11}},
	-- 沼泽 郊野
	{1,{22,14,7},{6,63,71}},

	--郊野  废墟
--	{1,{6,12,6},{21,34,100}},

	-- 废墟 郊野
	--{1,{21,36,107},{6,12,11}},



	-- 百鬼妖树   郊野
	{1,{23,15,90},{6,42,17}},
	--西岐城  乾元山
	{1,{1,3,19},{7,88,21}},
	-- 乾元山 西岐城
	{1,{7,91,16},{1,6,22}},
	-- 乾元山 金光洞1
	{2,{7,6,19},304},
	--  金光洞1 乾元山
	{1,{24,59,43},{7,11,26}},
	--  金光洞1 金光洞2
	{1,{24,58,6},{25,55,56}},
	--  金光洞2 金光洞1
	{1,{25,59,59},{24,54,12}},
	-- 乾元山 听风林1层
	{2,{7,9,133},305},
	-- 乾元山 乾元后山
	{1,{7,91,138},{34,4,16}},
	--  乾元后山 乾元山
	{1,{34,3,11},{7,88,130}},

	--  听风林1层  乾元山
	{1,{28,3,7},{7,15,133}},
	--  听风林1层  听风林2层
	{1,{28,43,8},{29,8,10}},
	--  听风林2层  听风林1层
	{1,{29,3,4},{28,40,11}},

	--  西岐  陈塘关
	{1,{1,29,6},{8,50,8}},

	--   陈塘关 西岐
	{1,{8,46,5},{1,24,10}},
	-- 陈塘关 东海副本
	{2,{8,44,138},306},
	--深海到 定海神针
	{1,{30,18,3},{33,3,87}},
	--深海  龙宫
	{1,{30,3,42},{31,22,21}},
	-- 逍遥阁 陈塘关
	{1,{32,58,44},{8,47,133}}, 

	-- 陈塘关 龙宫副本
	{2,{8,14,123},307},

	--龙宫  陈塘关
	{1,{31,27,107},{8,20,116}},

	--龙宫
	{2,{31,27,20},308},

	-- 定海神针 深海
	{1,{33,3,81},{30,16,5}},

	-- 阳光沙滩 西岐
	{1,{100,41,59},{1,48,78}},

	-- 西岐 渭水
	{1,{1,114,133},{10,6,95}},

	-- 渭水 西岐
	{1,{10,3,93},{1,110,129}},
	
	-- 渭水 九霄
	{2,{10,12,12},309},
	-- 渭水 十绝阵
	{2,{10,122,93},310},
	
	-- 渭水 牧野
	{1,{10,122,163},{12,8,229}},
	-- 牧野 渭水
	{1,{12,5,232},{10,120,158}},
	-- 牧野 朝歌
	{1,{12,120,8},{13,5,172}},	
	-- 朝歌 牧野
	{1,{13,2,174},{12,118,10}},		
	
	-- 渭水 绝龙岭
	--{2,{10,122,166},311},
	-- 立刻竞技场空间
	{2,{101,16,33},312},
	-- 乾元山跳水
	{2,{7,40,69},313},
	
	
	-- 海底迷阵1  西岐
	{1,{200,3,131},{1,6,100}},
	
	--   西岐 海底迷阵1
	--{1,{1,3,98},{200,6,135}},
	{2,{1,3,98},321},
	-- 1 -2 
	{2,{200,17,5},314},
	--   海底迷阵2 - 1
	{1,{201,59,123},{200,15,11}},
	-- 2 -3 
	{2,{201,9,9},315},
	--   海底迷阵3 - 2
	{1,{202,9,104},{201,7,14}},
	-- 3 -4 
	{2,{202,19,3},316},
	--   海底迷阵4 - 3
	{1,{203,6,86},{202,17,6}},
	-- 4 -5 
	{2,{203,32,6},317},
	--   海底迷阵5 - 4
	{1,{204,5,89},{203,32,13}},
	-- 5 -6 
	{2,{204,8,5},318},
	--   海底迷阵6 - 5
	{1,{205,72,126},{204,10,8}},
	-- 6 -7 
	{2,{205,112,17},319},
	--   海底迷阵7 - 6
	{1,{206,5,109},{205,110,20}},
	-- 7 -8
	{2,{206,69,7},320},
	--   海底迷阵8 - 7
	{1,{207,3,99},{206,66,11}},
}

mapID = mapID or 1
---陷阱回调 固定场景10000以下,副本动态类10000-100000,活动动态类100000以上
call_OnMapEvent={
	[301]=function ()
		--新手村去京城
		--look('新手村去京城')
		PI_MovePlayer(1,6,141)
	end,
	[302]=function ()
		--西岐沼泽副本触发点
		
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		--look( "sid =" ..sid)
		if  taskData.current[1054] ~= nil  then
			RPC('CSBOSSInfo',1002)
			--(sid,1002)
		else
			PI_MovePlayer(6,8,114)
		end
	end,

	[303]=function ()
		--百鬼妖树副本触发点
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[1105] ~= nil then
			
			--(sid,1003)
			RPC('CSBOSSInfo',1003)
		else
			PI_MovePlayer(23,18,89)
		end
		
	end,

	[304]=function ()
		--金光洞1，2层副本触发点
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[2006] ~= nil then

			--(sid,1004)
			RPC('CSBOSSInfo',1006)
		elseif taskData.current[1213] ~= nil then

			--(sid,1005)
			RPC('CSBOSSInfo',1007)
		else
			PI_MovePlayer(24,54,41)
		end	
	end,

	[305]=function ()
		--听风林1，2层副本触发点
		
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[1308] ~= nil then

			--(sid,1004)
			RPC('CSBOSSInfo',1010)
		elseif taskData.current[1321] ~= nil then

			--(sid,1005)
			RPC('CSBOSSInfo',1011)
		else
			PI_MovePlayer(28,5,11)
		end	
	end,

	[306]=function ()
		--陈塘关 东海副本
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[1168] ~= nil then

			--(sid,1004)
			RPC('CSBOSSInfo',1004)
		elseif taskData.current[1173] ~= nil then

			--(sid,1005)
			RPC('CSBOSSInfo',1005)
		else
			--PI_MovePlayer(30,16,5)
			PI_MovePlayer(32,55,56)
		end	
	end,

	[307]=function ()
		--陈塘关 龙宫副本
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[1216] ~= nil then
			RPC('CSBOSSInfo',1008)
		elseif  taskData.current[2019] ~= nil then
			RPC('CSBOSSInfo',1016)
		else
			PI_MovePlayer(31,26,113)
		end	
	end,

	[308]=function ()
		--龙宫  海底
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[1217] ~= nil then
			RPC('CSBOSSInfo',1009)
		else
			--PI_MovePlayer(33,3,87)
			PI_MovePlayer(30,6,48)
		end	
	end,
	
	[309]=function ()
		--渭水  九霄
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[1375] ~= nil then
			RPC('CSBOSSInfo',1012)
		elseif  taskData.current[1403] ~= nil then
			RPC('CSBOSSInfo',1013)
		elseif  taskData.current[1409] ~= nil then
			RPC('CSBOSSInfo',1014)
		elseif  taskData.current[1413] ~= nil then
			RPC('CSBOSSInfo',1015)
		else

			--PI_MovePlayer(36,11,11)
		end	
	end,
	[310]=function ()
		--渭水  十绝阵
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[1434] ~= nil then
			RPC('CSBOSSInfo',1017)
		elseif  taskData.current[1438] ~= nil then
			--金光阵	
			RPC('CSBOSSInfo',1018)
		else

			--PI_MovePlayer(37,11,11)
		end	
	end,
	[311]=function ()
		--渭水  绝龙岭 
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[1460] ~= nil then
			--绝龙岭
		else

			--PI_MovePlayer(38,11,11)
		end	
	end,
	--立刻竞技场
	[312]=function ()
		local pos = Define_POS[math.random(1,#Define_POS)]
		PI_MovePlayer(pos[1],pos[2],pos[3])
	end,
	--乾元山跳水
	[313]=function ()
		local selfgid = CI_GetPlayerData(16)
		AreaRPC(0,nil,nil,"WQ_Jump",selfgid)
	end,
	--[[庄园副本
	[330]=function ()
		local sid = CI_GetPlayerData(17)
		local taskData = GetDBTaskData( sid )
		if  taskData.current[2009] ~= nil then

			--(sid,1004)
			RPC('CSBOSSInfo',1020)
		end	
	end,]]--
	--海底1层进2层  45级
	[314]=function ()
		local zhanli = CI_GetPlayerData(62)
		local level = CI_GetPlayerData(1)
		if  zhanli < 30000 and level < 45 then
			TipCenter(GetStringMsg(18,30000,45))
			return
		else
			PI_MovePlayer(201,57,119)
		end
	end,
	--海底2层进3层 50级
	[315]=function ()
		local zhanli = CI_GetPlayerData(62)
		local level = CI_GetPlayerData(1)
		if  zhanli < 45000 and level < 50 then
			TipCenter(GetStringMsg(18,45000,50))
			return
		else
			PI_MovePlayer(202,9,97)
		end
	end,
	--海底3层进4层 55
	[316]=function ()
		local zhanli = CI_GetPlayerData(62)
		local level = CI_GetPlayerData(1)
		if  zhanli < 60000 and level < 55 then
			TipCenter(GetStringMsg(18,60000,55))
			return
		else
			PI_MovePlayer(203,9,83)
		end
	end,
	--海底4层进5层 60
	[317]=function ()
		local zhanli = CI_GetPlayerData(62)
		local level = CI_GetPlayerData(1)
		if  zhanli < 80000 and level < 60 then
			TipCenter(GetStringMsg(18,80000,60))
			return
		else
			PI_MovePlayer(204,9,87)
		end
	end,
	--海底5层进6层 65
	[318]=function ()
		local zhanli = CI_GetPlayerData(62)
		local level = CI_GetPlayerData(1)
		if  zhanli < 120000 and level < 65 then
			TipCenter(GetStringMsg(18,120000,65))
			return
		else
			PI_MovePlayer(205,71,132)
		end
	end,
	--海底6层进7层 80
	[319]=function ()
		local zhanli = CI_GetPlayerData(62)
		local level = CI_GetPlayerData(1)
		if  zhanli < 350000 and level < 80 then
			TipCenter(GetStringMsg(18,350000,80))
			return
		else		
		PI_MovePlayer(206,9,102)
		end
	end,
	--海底7层进8层
	[320]=function ()
		local zhanli = CI_GetPlayerData(62)
		local level = CI_GetPlayerData(1)
		if  zhanli < 400000 and level < 90 then
			TipCenter(GetStringMsg(18,400000,90))
			return
		else		
		PI_MovePlayer(207,7,95)
		end
	end,
	--西岐到海底1
	[321]=function ()
		
		EnterGuajia()
	end,
	[10006]=function ()
		--庄园离开
		local playerid=CI_GetPlayerData(17)
		OutZYparty(playerid,nil,0)
	end,
}
----------------------------------------------------------------
--interface:


--[[陷阱接口--【尽量构造成itype=1模式提高性能】
--itype=1(直传),现在场景数据Trapinfo={mapid,x,y,mapgid};---要传入场景数据newinfo={mapid,x,y,mapgid};---陷阱范围length，空默认为3
--itype=2(回调),现在场景数据Trapinfo={mapid,x,y,mapgid};---newinfo=回调脚本id;---陷阱范围length，空默认为3，var=传入参数
--itype=3(伤害),现在场景数据Trapinfo={mapid,x,y,mapgid};
			newinfo={	[1]=伤害类型：0 血量 1 怒气;
						[2]=值类型： 0 值 1 百分比;
						[3]=数值 （正为加，负为减）;
						[4]=前台用于表现时借用的buffid  ]]--
function PI_MapTrap(itype,Trapinfo,newinfo,length, var)
	if type(Trapinfo)~=type({}) then return  end
	local SetTrap = SetTrap
	local regionID=Trapinfo[1]
	local x=Trapinfo[2]
	local y=Trapinfo[3]
	local regionGID=Trapinfo[4]
	if itype==1 then --直接传送类
		if  type(newinfo)~=type({})  then
			look('mapinfo_error1',1)
			return
		end
		local new_regionID=newinfo[1]
		local new_x=newinfo[2]
		local new_y=newinfo[3]
		local new_regionGID=newinfo[4]
		if length == nil then
			length = 3 -- 默认为3X3 9个格子
		end
		for i=0,length-1 do
			for j=0,length-1 do
				if type(mapID) == type(0) then --构造陷阱唯一id
					mapID= mapID+1 
				end
				local a=SetTrap(regionID,mapID,1,new_regionID,new_x,new_y,regionGID,x+i-((length-1)/2),y+j-((length-1)/2), new_regionGID)
			end
		end
	elseif itype==2 then --回调类
		if  type(newinfo)~=type(0)  then
			look('mapinfo_error2',1)
			return
		end
		if length == nil then
			length = 3 
		end
		for i=0,length-1 do
			for j=0,length-1 do
				if type(mapID) == type(0) then --构造陷阱唯一id
					mapID= mapID+1 
				end
				SetTrap(regionID,mapID,4,x+i-((length-1)/2),y+j-((length-1)/2),newinfo, regionGID, var)
			end
		end
	elseif itype==3 then --伤害类
		if  type(newinfo)~=type({})  then
			look('mapinfo_error3',1)
			return
		end
		if length == nil then
			length = 3 
		end
		for i=0,length-1 do
			for j=0,length-1 do
				if type(mapID) == type(0) then --构造陷阱唯一id
					mapID= mapID+1 
				end
				SetTrap(regionID,mapID,8,x+i-((length-1)/2),y+j-((length-1)/2),newinfo[1],regionGID,newinfo[2],newinfo[3],newinfo[4])
			end
		end
	else
		return
	end
end

local PI_MapTrap = PI_MapTrap

--进入沙滩钓鱼场景
function EnterDongHai()
	if escort_not_trans() then
		return
	end
	PI_MovePlayer(100,25,35)
end
--进入挂机场景
function EnterGuajia()
	local lv=CI_GetPlayerData(1)
	if lv >=80 then
		PI_MovePlayer(206,9,105)
	elseif lv >=65 then
		PI_MovePlayer(205,71,132)
	elseif lv >=60 then
		PI_MovePlayer(204,25,58)
	elseif lv >=55 then
		PI_MovePlayer(203,13,80)
	elseif lv >=50 then
		PI_MovePlayer(202,25,35)
	elseif lv >=45 then
		PI_MovePlayer(201,25,35)
	else
		PI_MovePlayer(200,25,35)
	end
end
-----场景传送
function InitMapEvent()
	for k,v in pairs(trapconf) do
		PI_MapTrap(v[1],v[2],v[3])
	end
end
-----陷阱回调
function SI_OnMapEvent(id,arg)
	local funname=call_OnMapEvent[id]
	if type(funname)~=TP_FUNC then
		return
	end
	funname(arg)
end
