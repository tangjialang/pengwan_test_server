--[[
file:	XML_func.lua
desc:	��ħ¼ϵͳ
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
local zhang_=1--�¿�����Ҫ��һ���Ǽ�
local maxjie=6--ÿ��������
local jie_=1--����������Ҫ�Ͻ��Ǽ�
local monstertime=1 --С�ֲ���
local buffid=120 --buffid
local mapconf={{506,11,12},{513,11,17},{515,16,23},{514,15,22},} --��Ӧmapid,x,y

--������ҽ�ħ¼������
local function GetDBXMLData( playerid )--��������¶���YY������
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
--�����ʱ���ݽӿ�
local function GetXMLfbdataTemp(playerid)
	if playerid == nil then return nil end
	local cData = GetPlayerTemp_custom(playerid)
	if cData == nil  then return end
	if cData.xml == nil then
		cData.xml = {
			time_n=1,--�ڼ���
			do_num=0,--�����ĸ�����
			--deadnow=0,--������������
			--num=0,--buff����
		}
	end
	return cData.xml
end
-- --��ʼ��
-- function XMLFBd_Start(playerid)
	-- local fbdata=GetDBXMLData( playerid )
	-- if fbdata==nil then return end
	-- SendLuaMsg( 0, { ids=XMLfb_start,data=fbdata}, 9 )--����ǰ̨���ӵ���
-- end


--�жϽ��븱������
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
	-- end --45�����Ź���
	
	if zhang>1 then----�ж��¿���û
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
	if jie>1 then-----�жϽڿ���û
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
	if xmlnum==nil then-----�ж��ǿ���û
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
	if  need[2]~=nil then----����ȼ�
		local level = CI_GetPlayerData(1)
		if level<need[2] then
			--look('1111111')
			return
		end
	end
	if  need[3]~=nil then----����ս����
		local fire = CI_GetPlayerData(62)--ȡ���ս����
		--local fire =GetCertainPlayerData(playerid,62)--=================================���ԶԲ���
		if fire<need[2] then
			--look('222222222')
			return
		end
	end	
	if need[1]~=nil then----�������
		if CheckGoods( need[1][1] ,need[1][2],0,playerid,'��ħ¼ϵͳ') == 0 then
			--look('data_id=='..need[1][1])
			--SendLuaMsg(0,{ids=STARTParty,result=2},9)
			return 
		end
	end
	return true
end
--���������߼�
local function XML_CreatMonster(playerid,mapgid,time_n,do_num)--ˢ�����֣�id���ڼ���

	local tempdata=GetXMLfbdataTemp(playerid)
	local m = uv_XML_conf[do_num]
	if  m==nil then 
		--look(5555)

		return
	end
	if m.monster==nil or time_n==monstertime+1 then --ˢ��BOSS
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
--���븱��
function Enter_XMLfb(playerid,do_num)
	local tempdata=GetXMLfbdataTemp(playerid)
	if tempdata==nil then return end
	if tempdata.do_num and tempdata.do_num>0 then
		XMLFb_Exit(playerid)
		tempdata=GetXMLfbdataTemp(playerid)
		if tempdata.do_num==0 then 
			look('��ħ¼������',1)
			Enter_XMLfb(playerid,do_num)
		end
		return
	end
	if playerid==nil or do_num ==nil then return end
	if not Check_condition(playerid,do_num) then --�������
		look('tiaojianbuzu')
		return 
	end
	local mapconf_=mapconf[rint(do_num/100)]
	local mapgid=active_xml:createDR(1,mapconf_[1]) --������ͼ
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

	
	--temp11111(playerid) ---���
end

--������Ӱ�ť
function Chick_benginXML(sid)
	local tempdata=GetXMLfbdataTemp(sid)
	local num=tempdata.num
	local mapgid=tempdata.mapgid
	XML_CreatMonster(sid,mapgid,tempdata.time_n,tempdata.do_num)--ˢ�����֣�id���ڼ���,�ĸ�����
end


--�˳�����
function XMLFb_Exit(playerid)
	active_xml:back_player(playerid)
end
--�л���ͼ
function active_xml:on_regionchange(playerid)

	local cData = GetPlayerTemp_custom(playerid)
	cData.xml=nil
end
--�������
function active_xml:on_playerdead(playerid)

	local tempdata=GetXMLfbdataTemp(playerid)
	if tempdata==nil then  return end
	local in_num=tempdata.do_num
	SendLuaMsg( playerid, { ids=XMLfb_SUCC,num=in_num,res=0}, 10 )
	
	CI_OnSelectRelive(0,3*5,2,playerid)--�����سǸ���,3��5֡
	return 1
end
--ˢ������
function active_xml:on_login(sid)
	local tempdata=GetXMLfbdataTemp(sid)
	if tempdata.do_num==nil then return end
	if tempdata.time_n==nil then
		active_xml:back_player(sid)
		return
	end
	SendLuaMsg( 0, { ids=XMLfb_arise}, 9 )
end
--��������ص�
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
		XML_GetAttribute(playerid,1)--��ս�ɹ�����������
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
	SendLuaMsg( playerid, { ids=XMLfb_arise,time_n=tempdata.time_n,}, 10 )--������Ӱ�ť
	Chick_benginXML(playerid)--
	--end
end

function XML_GetAttribute(playerid,itype)	--�������Ը���
	--look('�������Ը���')
	local xmldata=GetDBXMLData( playerid )
	local AttTable =GetRWData(1)
	for k,v in pairs(xmldata) do--���
		if type(k)==type(0) and type(v)==type({}) then	
			local xinxin_mark=5--�õ�����ͬʱ��������Ǽ�
			if #v~=maxjie then 
				xinxin_mark=nil
			end
			for i,j in pairs(v) do --[1]={}������
				if type(i)==type(0) and type(j)==type(0) then
					if xinxin_mark then--�õ�����ͬʱ��������Ǽ�
						if j<xinxin_mark then
							xinxin_mark=j
						end
					end
					local num=k*100+i*10+j
					if uv_XML_conf[num]==nil or uv_XML_conf[num].Award==nil  then  return end
					local temp=uv_XML_conf[num].Award
					for m,n in pairs(temp) do --��������
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
				for h=1,xinxin_mark do--��1������ɣ���������Ǽ�
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
	if itype==1 then --ͨ�ظ���
		PI_UpdateScriptAtt(playerid,ScriptAttType.xiangmolu,2)--  ���½ű����ӵ��������
	end
	--look('�������Ը������ ')
	return true
end

if __debug == false then 
	return
end

function clearallfml(playerid)--==============������ɾ��
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
		XML_GetAttribute(playerid,1)--��ս�ɹ�����������
			if xin==5 then
				local playername=CI_GetPlayerData(5)
				local fbname=uv_XML_conf[in_num].qiantaineed.bossName
				TipCenterEx(GetStringMsg(707,playername,fbname))
			end
	local cData = GetPlayerTemp_custom(playerid)
	cData.xml=nil
end
