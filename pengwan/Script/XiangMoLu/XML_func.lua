--[[
file:	XML_func.lua
desc:	降魔录系统
author:	wk
update:	2013-3-29
refix:	done by wk
]]--		
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local XMLfb_arise	 = msgh_s2c_def[33][1]
local XMLfb_SUCC	 = msgh_s2c_def[33][2]
local XMLfb_start	 = msgh_s2c_def[33][3]
local XML_Exit	     = msgh_s2c_def[33][4]
local common 		 = require('Script.common.Log')
local Log 			 = common.Log
local active_mgr_m = require('Script.active.active_mgr')
local active_xml = active_mgr_m.active_xml
local look = look
local ScriptAttType = ScriptAttType
local pairs,type = pairs,type
local TipCenterEx=TipCenterEx
local CreateObjectIndirect=CreateObjectIndirect
local CI_OnSelectRelive=CI_OnSelectRelive
local PI_UpdateScriptAtt=PI_UpdateScriptAtt
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos
----------------------------------
local uv_XML_conf=XML_conf
local zhang_=1--章开启需要上一章星级
local maxjie=6--每章最大节数
local jie_=1--节数开启需要上节星级
local monstertime=1 --小怪波数
local buffid=120 --buffid
local mapconf={{506,11,12},{513,11,17},{515,16,23},{514,15,22},} --对应mapid,x,y

--定义玩家降魔录数据区
local function GetDBXMLData( playerid )--玩家数据下定义YY功能区
	local xml_data=GI_GetPlayerData( playerid , 'xml' , 150 )
	if xml_data == nil then return end
		-- if xml_data[1]==nil then
			-- xml_data[1]={}
			-- xml_data[2]={}
			-- xml_data[3]={}
			-- xml_data[4]={}
			-- xml_data[5]={}
		-- end
			--look(tostring(xml_data))
	return xml_data
end
--玩家临时数据接口
local function GetXMLfbdataTemp(playerid)
	if playerid == nil then return nil end
	local cData = GetPlayerTemp_custom(playerid)
	if cData == nil  then return end
	if cData.xml == nil then
		cData.xml = {
			time_n=1,--第几波
			do_num=0,--进的哪个副本
			--deadnow=0,--怪物死亡个数
			--num=0,--buff点数
		}
	end
	return cData.xml
end
-- --初始化
-- function XMLFBd_Start(playerid)
	-- local fbdata=GetDBXMLData( playerid )
	-- if fbdata==nil then return end
	-- SendLuaMsg( 0, { ids=XMLfb_start,data=fbdata}, 9 )--发送前台骰子点数
-- end


--判断进入副本条件
local function Check_condition(playerid,num)
	if num<111 or num>999 then return end
	local xmldata=GetDBXMLData( playerid )
	local zhang=rint(num/100)
	local jie=rint((num%100)/10)
	local xin=num%10
	if xmldata[zhang]==nil then xmldata[zhang]={} end
	local xmlnum=xmldata[zhang][jie]
	--local level = CI_GetPlayerData(1)
	-- if level<45 then 
		-- --look('lv_error')
		-- return 
	-- end --45级开放功能
	
	if zhang>1 then----判断章开启没
		if #xmldata[zhang-1]<maxjie then
			--look('need-num-zhang__error')
			--look(xmldata[zhang-1])
			return
		end
		local tempnum=5
		for k, v in pairs(xmldata[zhang-1]) do
			if type(k)==type(0) and type(v)==type(0) then
				if v<tempnum then
					tempnum=v
				end
			end
		end
		if tempnum<zhang_ then
			--look('needzhang__error')
			return
		end
	end
	if jie>1 then-----判断节开启没
		local temp_num =xmldata[zhang][jie-1]
		if temp_num==nil then
			Log('xmldata.txt',num)
			Log('xmldata.txt',xmldata)
		end
		if temp_num <jie_ then
			--look('needjie__error')
			return
		end
	end	
	if xmlnum==nil then-----判断星开启没
		xmlnum=0
	end
	if xmlnum-xin~=-1  then
		--look('xinji_error')
		return
	end
	local xmlconf=uv_XML_conf[num]
	if xmlconf==nil then 
		--look('uv_XML_conf[num]_error')
		return 
	end
	local need=xmlconf.need
	if need==nil then
		return true
	end
	if  need[2]~=nil then----需求等级
		local level = CI_GetPlayerData(1)
		if level<need[2] then
			--look('1111111')
			return
		end
	end
	if  need[3]~=nil then----需求战斗力
		local fire = CI_GetPlayerData(62)--取玩家战斗力
		--local fire =GetCertainPlayerData(playerid,62)--=================================测试对不对
		if fire<need[2] then
			--look('222222222')
			return
		end
	end	
	if need[1]~=nil then----需求材料
		if CheckGoods( need[1][1] ,need[1][2],0,playerid,'降魔录系统') == 0 then
			--look('data_id=='..need[1][1])
			--SendLuaMsg(0,{ids=STARTParty,result=2},9)
			return 
		end
	end
	return true
end
--创建怪物逻辑
local function XML_CreatMonster(playerid,mapgid,time_n,do_num)--刷几个怪，id，第几波

	local tempdata=GetXMLfbdataTemp(playerid)
	local m = uv_XML_conf[do_num]
	if  m==nil then 
		--look(5555)

		return
	end
	if m.monster==nil or time_n==monstertime+1 then --刷新BOSS
		m.boss.regionId = mapgid
		CreateObjectIndirect(m.boss,'xml')--
		tempdata.monsternum=1
	else
		m.monster.regionId = mapgid
		tempdata.monsternum=m.monster.BRNumber
		CreateObjectIndirect(m.monster,'xml')
	end
end

--------------------------------------------------------------
--进入副本
function Enter_XMLfb(playerid,do_num)
	local tempdata=GetXMLfbdataTemp(playerid)
	if tempdata==nil then return end
	if tempdata.do_num and tempdata.do_num>0 then
		XMLFb_Exit(playerid)
		tempdata=GetXMLfbdataTemp(playerid)
		if tempdata.do_num==0 then 
			look('降魔录连续进',1)
			Enter_XMLfb(playerid,do_num)
		end
		return
	end
	if playerid==nil or do_num ==nil then return end
	if not Check_condition(playerid,do_num) then --检查条件
		look('tiaojianbuzu')
		return 
	end
	local mapconf_=mapconf[rint(do_num/100)]
	local mapgid=active_xml:createDR(1,mapconf_[1]) --创建地图
	if mapgid == nil then return end 
	tempdata.time_n=1
	tempdata.do_num=do_num
	tempdata.mapgid=mapgid
	local temp=active_xml:get_regiondata(mapgid)
	if temp==nil then return end
	temp[1]=playerid
	if not active_xml:add_player(playerid, 1, 0,mapconf_[2],mapconf_[3], mapgid) then return end
	SendLuaMsg( 0, { ids=XMLfb_arise,time_n=tempdata.time_n}, 9 )
	Chick_benginXML(playerid)

	
	--temp11111(playerid) ---秒过
end

--点击骰子按钮
function Chick_benginXML(sid)
	local tempdata=GetXMLfbdataTemp(sid)
	local num=tempdata.num
	local mapgid=tempdata.mapgid
	XML_CreatMonster(sid,mapgid,tempdata.time_n,tempdata.do_num)--刷几个怪，id，第几波,哪个副本
end


--退出副本
function XMLFb_Exit(playerid)
	active_xml:back_player(playerid)
end
--切换地图
function active_xml:on_regionchange(playerid)

	local cData = GetPlayerTemp_custom(playerid)
	cData.xml=nil
end
--玩家死亡
function active_xml:on_playerdead(playerid)

	local tempdata=GetXMLfbdataTemp(playerid)
	if tempdata==nil then  return end
	local in_num=tempdata.do_num
	SendLuaMsg( playerid, { ids=XMLfb_SUCC,num=in_num,res=0}, 10 )
	
	CI_OnSelectRelive(0,3*5,2,playerid)--立即回城复活,3秒5帧
	return 1
end
--刷新上线
function active_xml:on_login(sid)
	local tempdata=GetXMLfbdataTemp(sid)
	if tempdata.do_num==nil then return end
	if tempdata.time_n==nil then
		active_xml:back_player(sid)
		return
	end
	SendLuaMsg( 0, { ids=XMLfb_arise}, 9 )
end
--怪物死完回调
function active_xml:on_monDeadAll(mapGID)
	local temp=active_xml:get_regiondata(mapGID)
	local playerid =temp[1]
	local tempdata=GetXMLfbdataTemp(playerid)
	if tempdata==nil then  return end
	local monsternum=tempdata.monsternum
	tempdata.time_n=tempdata.time_n+1
	if tempdata.time_n>monstertime+1 or monsternum==1 then
		local xmldata=GetDBXMLData( playerid )
		local in_num=tempdata.do_num
		local zhang=rint(in_num/100)
		local jie=rint((in_num%100)/10)
		local xin=in_num%10
		xmldata[zhang][jie]=xin
		SendLuaMsg( playerid, { ids=XMLfb_SUCC,num=in_num,res=1}, 10 )
		XML_GetAttribute(playerid,1)--挑战成功，更新属性
		if xin==5 then
			local playername=CI_GetPlayerData(5,2,playerid)
			local fbname=uv_XML_conf[in_num].qiantaineed.bossName
			TipCenterEx(GetStringMsg(707,playername,fbname))
		end
		if in_num==113 then
			set_obj_pos(playerid,2004)
		end
		tempdata.time_n=nil
		return
	end
	SendLuaMsg( playerid, { ids=XMLfb_arise,time_n=tempdata.time_n,}, 10 )--添加骰子按钮
	Chick_benginXML(playerid)--
	--end
end

function XML_GetAttribute(playerid,itype)	--人物属性更新
	--look('人物属性更新')
	local xmldata=GetDBXMLData( playerid )
	local AttTable =GetRWData(1)
	for k,v in pairs(xmldata) do--外层
		if type(k)==type(0) and type(v)==type({}) then	
			local xinxin_mark=5--得到此章同时过的最大星级
			if #v~=maxjie then 
				xinxin_mark=nil
			end
			for i,j in pairs(v) do --[1]={}的内容
				if type(i)==type(0) and type(j)==type(0) then
					if xinxin_mark then--得到此章同时过的最大星级
						if j<xinxin_mark then
							xinxin_mark=j
						end
					end
					local num=k*100+i*10+j
					if uv_XML_conf[num]==nil or uv_XML_conf[num].Award==nil  then  return end
					local temp=uv_XML_conf[num].Award
					for m,n in pairs(temp) do --奖励内容
						if type(m)==type(0) and type(n)==type(0) then
							local atttype=m
							if m<100 then
								AttTable[atttype]= (AttTable[atttype] or 0) + n
							else
								--suicong_XMLAttr[atttype]=	(suicong_XMLAttr[atttype] or 0) +n
							end
							
							
						end
					end
				end
			end
			if xinxin_mark then
				for h=1,xinxin_mark do--【1】轮完成，计算最大星级
					local ATTnum=uv_XML_conf.extra_Award[k][h]
					local Att_type=ATTnum[1]
					if ATTnum[1]<100 then
						AttTable[Att_type]= (AttTable[Att_type] or 0) + ATTnum[2]
					else
						--suicong_XMLAttr[Att_type]=	(suicong_XMLAttr[Att_type] or 0) +ATTnum[2]
					end
				end
			end
			
			
		end
	end
	if itype==1 then --通关更新
		PI_UpdateScriptAtt(playerid,ScriptAttType.xiangmolu,2)--  更新脚本增加的玩家属性
	end
	--look('人物属性更新完成 ')
	return true
end

if __debug == false then 
	return
end

function clearallfml(playerid)--==============测试完删除
	dbMgr[ playerid ].data.xml = nil
	SendLuaMsg( 0, { ids=XMLfb_start,data={}}, 9 )
end
function temp11111(playerid)
local tempdata=GetXMLfbdataTemp(playerid)
	local xmldata=GetDBXMLData( playerid )
			local in_num=tempdata.do_num
			local zhang=rint(in_num/100)
			local jie=rint((in_num%100)/10)
			local xin=in_num%10
			--look('succ_end')
			xmldata[zhang][jie]=xin
		--	TipCenter('11111')
			SendLuaMsg( 0, { ids=XMLfb_SUCC,num=in_num,res=1}, 9 )
		--	TipCenter('2222')
		--	TipCenter('send succ info')
		XML_GetAttribute(playerid,1)--挑战成功，更新属性
			if xin==5 then
				local playername=CI_GetPlayerData(5)
				local fbname=uv_XML_conf[in_num].qiantaineed.bossName
				TipCenterEx(GetStringMsg(707,playername,fbname))
			end
	local cData = GetPlayerTemp_custom(playerid)
	cData.xml=nil
end
