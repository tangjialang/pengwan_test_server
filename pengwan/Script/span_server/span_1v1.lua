local active_mgr_m = require('Script.active.active_mgr')
local activitymgr = active_mgr_m.activitymgr
local _insert=table.insert
local RegionRPC=RegionRPC
local GetServerTime = GetServerTime
local db_module = require('Script.cext.dbrpc')
local db_get_span_server = db_module.db_get_span_server
local _random=math.random
local _remove=table.remove

-------------------------------------------------------------
local SPAN_1v1_ID =  7 --���1v1�id
local active_name = 'span_1v1_vs'
local v1_site={{4,38},{44,37}}
local info1={}--ƥ�������Ϣ
local info2={}
v1_mark=v1_mark or 1 --������־,һ��ֻ��һ��
-------------------------------------------------------------
-- ȡv1����(��������)
local function _v1_getpub()
	local active_lt = GetWorldCustomDB()
	if(active_lt.kf1v1 == nil) then
		active_lt.kf1v1 = {}
	end
	local pub_data = active_lt.kf1v1
	pub_data.room = pub_data.room or {}  --�����б����ڹ���̬����ͼ
	--����б�,��Ҵ洢����
	pub_data.sign = pub_data.sign or {}  --������е����ݶ���������
	--[[
		{
		pinfo.jf = 0           --��ʼ����,������ǰ����,����ȥ
		pinfo.id = sid           --ԭ��sid
		pinfo[2] = fight           --ս����
		pinfo[3] = GetGroupID()	   --������serverid
		pinfo[4] = CI_GetPlayerData(3) --�������
		pinfo[5] = basedata[4]     --�·�
		pinfo[6] = basedata[5] --����
		pinfo.mark=true --��������ʶ
		},
	]]
	pub_data.save = pub_data.save or {}  --�������ݱ���
	--����Ƿ��¼�����־
	pub_data.login = pub_data.login or {}  --����Ƿ��¼�˿���
	--����1�жϵ�ǰ���ڻ���� ֵ��2��ѡ 3 Ԥ�� 4 ����� 5����
	pub_data.type = pub_data.type or 0

	--��ʾÿ�ֻ���еĴ��� ����2��ʾ��ѡ��3��ʾԤ�� 4��ʾ����� 5����
	pub_data.times = pub_data.times or {}
	
	pub_data.quiz = pub_data.quiz or {}--��������
	
	-- pub_data.isenroll = pub_data.isenroll or {} -- �Ƿ���
	return pub_data
end
--�����ж�
--[[local function compare(a,b)
	if(a.jf  == b.jf) then
		return a.fight > b.fight
	else		
		return  a.jf > b.jf
	end	
end--]]
--�������
local function v1v_player_rank(signdata)
	--��ʼ����
	--table.bublesort(signdata,compare)
		table.sort(signdata, function (a,b)
			if(a.jf  == b.jf) then
				return a[2] > b[2]
			else		
				return  a.jf > b.jf
			end	
		end)--]]
		--[[for i = 1,#signdata do
			signdata[i].rank = i
		end--]]
end

--ͨ�����id����������
--[[local function getrank_byid(sid)
	local adata=_v1_getpub()
	if adata==nil then return end
	local signdata=adata.sign
	
	for k,v in pairs(signdata) do
		if(v.id == sid) then
			return k
		end
	end
	return 0
end--]]
--�������Ѿ���������������
local function v1_have_enroll(id,svrid)
	local adata=_v1_getpub()
	if adata==nil or adata.sign == nil then return end
	local signinfo = adata.sign  
	-- local enroll = adata.isenroll
	-- local endid=id*1000+rint(svrid/10000)
	-- if(enroll[endid]) then
		-- return false
	-- else
		for k = 1,#signinfo do
			if(signinfo[k] and id == signinfo[k].id and svrid == signinfo[k][3] )  then
				return false
			end	
		end
		return true
	-- end
end
--��ұ����洢����
function v1_savedata(info)
	local adata=_v1_getpub()
	local area = in1v1time_area(2)
	local svrid=info[3]
	if adata==nil or adata.sign == nil or area == false then 
		PI_SendToLocalSvr(svrid,{ids = 10001,id = info.id,ret = 0})--��ұ���
		return 
	end
	--�����ӳ���ɵĶ�α���
	local isenroll = v1_have_enroll(info.id,svrid)
	if(isenroll) then
		local signdata=adata.sign
		signdata[#signdata+1]=info
		adata.save[#signdata+1]=info
		--_insert(signdata,info)
		PI_SendToLocalSvr(svrid,{ids = 10001,id = info.id,ret = 1})--��ұ���
	end		
end

--ͨ�����id�����ҹ�������
local function get_1v1_data_byid(id,serverid)
	local adata=_v1_getpub()
	if(adata== nil  or adata.sign == nil) then
		return
	end	
	local signdata = adata.sign
	for k,v in pairs(signdata) do
		if(v.id == id) and (v[3] == serverid) then
			return v
			
		end	
	end
	return 0
end
--��ѡ��Ӯ���ִ���itype=1��,2Ӯ 3�ֿ� sid ���id  
local function _1v1_jifen_end( itype,sid,data)
		local adata=_v1_getpub()
		local pdata = v1_getplayerdata(sid)
		if(adata== nil or adata.sign == nil ) then
			return
		end
		
		local info
		--��ʾ�ֿ�
		if(itype == 3) then
			info =data
		else
			if(pdata == nil) then
				return
			end
			local id = pdata.id
			info = get_1v1_data_byid(id,pdata[3])
		end 
		if(info == nil or info == 0) then
			return
		end	
		local area = in1v1time_area(0)
		if(area == 0 or area == 1) then
			return
		end
		--��ǰ���е�����
		local curtimes = adata.times[area] or 1
		--��ǰ����������
		local timetype = adata.type
		--��ѡ
		if(timetype == 2) then
		--1~5��	
			if(curtimes>=1 and curtimes<=5) then
				if(itype == 1) then
					info.jf = (info.jf or 0) + 2
				elseif(itype == 2) then
					info.jf = (info.jf or 0) + 4
				elseif(itype == 3) then
					info.jf = (info.jf or 0) + 4
				end			
		--6~10��		
			elseif(curtimes>=6 and curtimes<=10) then
				if(itype == 1) then
					info.jf = (info.jf or 0) + 3
				elseif(itype == 2) then
					info.jf = (info.jf or 0) + 5
				elseif(itype == 3) then
					info.jf = (info.jf or 0) + 5			
				end
		--11~15		
			elseif(curtimes>=11 and curtimes <=15) then
				if(itype == 1) then
					info.jf = (info.jf or 0) + 5
				elseif(itype == 2) then
					info.jf = (info.jf or 0) + 7
				elseif(itype == 3) then
					info.jf = (info.jf or 0) + 7	
				end
			end	
		--Ԥ��	
		elseif (timetype == 3) then	
			if(itype == 1) then
				info.jf = (info.jf or 0) + 0
			elseif(itype == 2) then
				info.jf = (info.jf or 0) + 2
			elseif(itype == 3) then
				info.jf = (info.jf or 0) + 1
			end
			--�����
		elseif (timetype == 4) then	
			if(itype == 1) then
				info.jf = (info.jf or 0) + 0
			elseif(itype == 2) then
				info.jf = (info.jf or 0) + 2
			elseif(itype == 3) then
				info.jf = (info.jf or 0) + 1
			end
			--����
		elseif (timetype == 5) then	
			if(itype == 1) then
				info.jf = (info.jf or 0) + 0
			elseif(itype == 2) then
				info.jf = (info.jf or 0) + 2
			elseif(itype == 3) then
				info.jf = (info.jf or 0) + 1
			end
		else
		end	
		--�����������
		if(pdata) then
			local basedata = PI_GetTsBaseData(sid)
			info[2]=CI_GetPlayerData(62,2,sid)--ս����
			--info[4]=CI_GetPlayerData(3,2,sid)--����
			info[5]=basedata[4]--�·�
			info[6]=basedata[5]--����
		end	
end
--�ж�����Ƿ���Ӯ
function iswin_1v1(sid,oid)
	local ret = {}
	local DamageA  = (DamageA or 0 )+CI_GetPlayerData(7,2,sid)
	local DamageB  = (DamageB or 0)+CI_GetPlayerData(7,2,oid)
	local pdata1=v1_getplayerdata(sid)
	local pdata2=v1_getplayerdata(oid)
	if(pdata1 == nil or pdata2 == nil) then
		return
	end
	local fight1 = CI_GetPlayerData(62,2,sid)
	local fight2 =  CI_GetPlayerData(62,2,oid)
	if DamageA==DamageB then
		if(fight1 > fight2) then
			ret.win = sid
			ret.fail = oid
		elseif(fight1 < fight2) then
			ret.win = oid
			ret.fail = sid
		elseif(fight1 == fight2) then
			ret.win = oid
			ret.fail = sid
		end
			--�ж�ս����
	elseif(DamageA>DamageB) then
		ret.win = sid
		ret.fail = oid
	elseif(DamageA<DamageB)	then	
		ret.win = oid
		ret.fail = sid
	end
	return ret
end
--�������
local  function _on_playerdead(self,deader_sid,rid,mapGID,killer_sid)
	local adata=_v1_getpub()
	local jf2 = get_1v1_every_jf(2)
	local jf1 = get_1v1_every_jf(1)
	local info = adata.login[mapGID]
	CI_OnSelectRelive(0,3*5,2,deader_sid)--�����سǸ���,3��5֡
	
	if(info == nil or info[3] == nil) then
		leaveSpan_1v1(killer_sid,3,0,deader_sid,3,0)
		return
	end
	--��û���
	if(info[3] == false) then
		_1v1_jifen_end( 1,deader_sid)
		_1v1_jifen_end( 2,killer_sid)		
		--local jf2 = get_1v1_every_jf(2)
		--local jf1 = get_1v1_every_jf(1)
		leaveSpan_1v1(killer_sid,2,jf2,deader_sid,1,jf1)
		adata.login[mapGID][3] = true
	else
		leaveSpan_1v1(killer_sid,3,0,deader_sid,3,0)
	end
end

-- ʱ�䵽����
function SI_v1_timeout( mapGID )
	local adata=_v1_getpub()
	if(adata.login[mapGID]==nil) then
		return
	end
	local sid=adata.login[mapGID][1]
	local oid=adata.login[mapGID][2]
	local mark = adata.login[mapGID][3]
	if(sid == nil or oid == nil or mark == nil) then
		leaveSpan_1v1(sid,3,0,oid,3,0)
		return
	end	
	if(mark== false) then
		local ret = iswin_1v1(sid,oid)
		if(ret == nil) then
			leaveSpan_1v1(sid,3,0,oid,3,0)
		end
		--��û���
		local jf2 = get_1v1_every_jf(2)
		local jf1 = get_1v1_every_jf(1)
		
		_1v1_jifen_end( 2,ret.win )
		_1v1_jifen_end( 1,ret.fail )
		--�뿪���
		leaveSpan_1v1(ret.win,2,jf2,ret.fail,1,jf1)
		--leaveSpan_1v1(ret.fail,1,jf1)
		adata.login[mapGID][3] = true
	else
		leaveSpan_1v1(sid,3,0,oid,3,0)
	end	
end
-- ���ߴ���
local function _on_logout(self,sid)
	local _,_,_,mapGID = CI_GetCurPos(2,sid)
	local adata=_v1_getpub()
	if(adata.login[mapGID]==nil) then
		return
	end
	local info = adata.login[mapGID]
	--���ʱ�䵽�ˣ���һ����ڸ�����
	local mark = adata.login[mapGID][3]
	local id = adata.login[mapGID][1] 
	local oid = adata.login[mapGID][2] 
	--�Ƿ��ȡ�˽��� �����ȡ�˽�������������
	if(mark == false) then
		--��ȡ����
		--����ӳ�����
		if(id ~= nil and oid ~= nil) then
			local jf2 = get_1v1_every_jf(2)
			local jf1 = get_1v1_every_jf(1)
			local winid
			local failid
			if(sid == id) then
				winid = oid
				failid = id
			elseif(sid == oid) then
				winid = id
				failid = oid
			else
			end
			_1v1_jifen_end( 2,winid )
			_1v1_jifen_end( 1,failid )
			leaveSpan_1v1(winid,2,jf2,failid,1,jf1)
			--leaveSpan_1v1(failid,1,jf1)
			info[3] = true
			--������߰����sid�ÿ�
			if(info[1]~= nil and sid == info[1]) then
				info[1] = nil
			elseif(info[2]~= nil and sid == info[2]) then
				info[2] = nil
			end
		else
			leaveSpan_1v1(id,3,0,oid,3,0)
		end	
	else
		--leaveSpan_1v1(id,2,0,oid,1,0)
	end
end
--�ж϶����Ƿ��ڻ�У����û�У����˳�����
function no_player_1v1(sid,mapGID)
	local adata=_v1_getpub()
	local info = adata.login[mapGID]
	--�쳣���
	if(info == nil) then
		return
	end	
	--�쳣���
	if(info[1] == nil and info[2] == nil ) then
		return
	end	
	--��Ҷ���
	if(info[1] ~= nil and info[2] ~= nil ) then
		return
	end	
	--��һ�������
	if(info[1] ~= nil and info[3] == false) then
		_1v1_jifen_end(2,info[1])		
		--��ȡʤ������
		local jf2 = get_1v1_every_jf(2)
		leaveSpan_1v1(info[1],2,jf2,nil,nil,nil)	
		info[3] = true
	end
	--�ڶ��������
	if(info[2] ~= nil and info[3] == false) then
		_1v1_jifen_end(2,info[2])		
		--��ȡʤ������
		local jf2 = get_1v1_every_jf(2)
		leaveSpan_1v1(info[2],2,jf2,nil,nil,nil)	
		info[3] = true
	end
	return
end

--�����ʱע��:����
local function active_v1vs_regedit(span_1v1_vsdata)
	--span_1v1_vsdata.on_DRtimeout = _on_DRtimeout
	span_1v1_vsdata.on_playerdead=_on_playerdead
	span_1v1_vsdata.on_logout = _on_logout
end
--����:����
local function v1vs_enter(sid, mapGID,x,y)
	local span_1v1_vsdata=activitymgr:get(active_name)
	if span_1v1_vsdata==nil then
		return
	end
	if  not span_1v1_vsdata:is_active(sid) then
		if not span_1v1_vsdata:add_player(sid, 1, 0, x, y, mapGID) then 
			return 
		end
	end
end
--��Ҷ����볡��5�����ʾͷ������ ������ӳٽ������˲�����ʾ
function GI_show_1v1_ico(player1,player2,mapGID)
		local data1=v1_getplayerdata(player1)
		local data2=v1_getplayerdata(player2)
		if(data1 == nil or data2 == nil) then
			return
		end	
		local id1 = data1.id
		local TBData1 = PI_GetTsBaseData(player1)
		local name1 = CI_GetPlayerData(3,2,player1)
		local group1 = data1[3]
		local sex1 = CI_GetPlayerData(11,2,player1)
		
		local name2 = CI_GetPlayerData(3,2,player2)
		local group2 = data2[3]
		local id2 = data2.id
		local TBData2 = PI_GetTsBaseData(player2)
		local sex2 = CI_GetPlayerData(11,2,player2)
		--ǰ��λ��ʾ��һλ��ҵ����� 7-12λ��ʾ�ڶ�λ�������
		local info = {player1,TBData1[2],TBData1[8],sex1,name1,group1,player2,TBData2[2],TBData2[8],sex2,name2,group2}
		RegionRPC(mapGID,'v1_mapbase',info)--����ΪӮ�Ķ����б�
end
--��ҵ�½���
function v1_login(sid)
	local span_1v1_vsdata=activitymgr:get(active_name)
	local adata=_v1_getpub()
	local pdata=v1_getplayerdata(sid)
	if (span_1v1_vsdata==nil or pdata == nil)then
		return
	end

	--�洢��ҵĿ��id
	local oid = pdata[8]
	local id = pdata.id
	
	--������ҵ�ǰ����
	local curpos
	local mapGID
	local roomdata=adata.room
	if roomdata[id]~=nil and roomdata[id][pdata[3]] then 	
		mapGID=roomdata[id][pdata[3]]
		curpos = 1
		--��Ҫ���ж����15��֮����������
		local info = adata.login[mapGID]
		if(info and info[3]) then	
			leaveSpan_1v1(sid,3,0,nil,nil,nil)
			return
		end		
	else	
		mapGID=span_1v1_vsdata:createDR(1)--��һ����������
		if(mapGID == nil) then
			leaveSpan_1v1(sid,3,0,nil,nil,nil)
			return
		end
		--��gid��������
		roomdata[id] =roomdata[id] or {}
		roomdata[oid]=roomdata[oid] or {}
		roomdata[id][pdata[3]]=mapGID
		roomdata[oid][pdata[20]]=mapGID			
		curpos = 2
		SetEvent(40, nil, "no_player_1v1",sid,mapGID)
		SetEvent(120, nil, "SI_v1_timeout",mapGID)
		--��һ����ҽ���		
	end	
	local svrid = pdata[3]
	adata.login[mapGID]=adata.login[mapGID] or {}
	--����1 2��ʾ���id 3��ʾ�Ƿ������ 4 ��ʾ��һ����ҽ���ʱ�� 5��ʾ�ڶ�����ҽ���ʱ��
	if(adata.login[mapGID][1]) then
		adata.login[mapGID][2] = sid 
		--��¼��ǰʱ�� ������ҵ���ʱ
		adata.login[mapGID][5] = GetServerTime()
		
		local seconds = {adata.login[mapGID][4],adata.login[mapGID][5]}
		RPCEx(sid,'kf_1v1_times',seconds)
	else
		adata.login[mapGID][4] = GetServerTime()
		adata.login[mapGID][1] = sid 
		
		local seconds = {adata.login[mapGID][4],nil}
		RPCEx(sid,'kf_1v1_times',seconds)
	end
	--��ʾδ��ȡ������
	adata.login[mapGID][3] = false
	--��Ҷ���½ʱ��
	local player1 = adata.login[mapGID][1]
	local player2 = adata.login[mapGID][2]
	local x =v1_site[curpos][1]
	local y=v1_site[curpos][2]
	v1vs_enter(sid, mapGID,x,y)
	if(player1 and player2) then
		SetEvent(4, nil, "GI_show_1v1_ico",player1,player2,mapGID)	
	end
	return true
end
--���ʼǰ��ջ���
local function clear_jf_1v1()
	local adata=_v1_getpub()
	if(adata==nil or adata.sign == nil ) then
		return
	end
	local signdata=adata.sign
	for k,v in pairs(signdata) do
		v.jf = 0
		v[21] = nil--���콱��ʶ
	end
end
--�����:
function v1vs_start(itype)	
	--�����ڻʱ����ڱ���ʱ��
	local area = in1v1time_area(0)
	local adata=_v1_getpub()
	if(area == 0 or area == 1 or adata==nil ) then
		return
	end
	activitymgr:create(active_name)
	local span_1v1_vsdata=activitymgr:get(active_name)
	active_v1vs_regedit(span_1v1_vsdata)


	--��ʼ������
	local signdata=adata.sign
	--�������1
	adata.times[itype] = 0
	--����		
	if(itype == 2 and area == 2) then--��ѡ
		--��ջ���
		clear_jf_1v1()
		adata.type = 2
		GI_v1_noteam(2,0)
		--SetEvent(180, nil, "GI_v1_noteam",2,1)
		SetEvent(240, nil, "GI_v1_noteam",2,1)--��ѡ�޸�Ϊ4����
	elseif (itype == 3 and area == 3) then --Ԥ��
		clear_jf_1v1()
		adata.type  = 3
		GI_v1_noteam(3,0)
		SetEvent(240, nil, "GI_v1_noteam",3,1)
	elseif (itype == 4 and  area == 4) then --�����
		clear_jf_1v1()
		adata.type  = 4
		GI_v1_noteam(4,0)
		SetEvent(240, nil, "GI_v1_noteam",4,1)
	elseif (itype == 5 and  area == 5) then -- ����
		clear_jf_1v1()
		adata.type  = 5
		GI_v1_noteam(5,0)
		SetEvent(420, nil, "GI_v1_noteam",5,1)		
	end
	-- ��ȡ���1v1������б�(�ص�����: CALLBACK_SpanServerGets)
	db_get_span_server(SPAN_1v1_ID,0)
	local spxb = GetSpanListData(SPAN_1v1_ID)
end
--����� ���ظ�������Ҫ���������
--itype �������� list����б�
local function award_1v1_over(itype,list)
	for i = 1,#list do
		if list[i][21]==nil then--δ������ʶ,��ֹ��η���
			local svrid = list[i][3]
			PI_SendToLocalSvr(svrid,{ids = 10008,itype = itype,info=list[i],rank = i})--�Լ�
			list[i][21]=true
		end
	end
end
--�����
function v1vs_end(itype)
	local area = in1v1time_area(0)
	if( area== 0 or area~= itype) then
		return
	end	
	local adata=_v1_getpub()
	if adata==nil or adata.sign ==  nil  then return end
	local signdata=adata.sign
	--����
	v1v_player_rank(signdata)
	--��������
	if(area == 1) then
		return
	else
		local areavalue
		--�򱾷����ͽ���
		if itype>=2 and itype <=5 then 
			award_1v1_over(itype,signdata)
		end
		-- ȡǰһ����
		if(itype == 2) then
			areavalue = 100
		--ȡǰ32��
		elseif(itype == 3) then
			areavalue = 32
		--ȡǰ8��
		elseif(itype == 4) then
			areavalue = 8
		--ȡǰ3��	
		elseif(itype == 5) then
			areavalue = 3
		--�ȫ������
		elseif(itype == 6)	then
			local timesover = in1v1time_area(3)
			if(timesover) then
				--clear_1v1_kf()
			end
			return
		end
		--��������
		for i = 1,#signdata do
			if(i > areavalue) then
				signdata[i] = nil
			end
		end
	end	
end

--ƥ���߼�,��ѡ90����ƥ��,ÿ��20��,������һ����ƥ��
v1_mate_time=v1_mate_time or 0--ƥ��λ��,��ѡʱÿ��20��
function v1_mate(itype,thistype,times)
	local adata=_v1_getpub()
	local signdata=adata.sign
	local mimi
	local max
	if itype==2 then
		mimi=v1_mate_time*20+1
		max=v1_mate_time*20+20
		if v1_mate_time>= 90 then--90��ƥ������ʣ�µ�
			max=#signdata
		end 
		v1_mate_time=v1_mate_time+1
	else
		mimi=1
		max=#signdata
	end
	local step,info,osid,svrid,dinfo,dsid,hsvrid

	for k=mimi,max do
		v=signdata[k]

		if type(k)==type(0) and  type(v)==type({}) then  		
			--�����������������ż��
			local res
			if thistype==1 then 
				if(k%2 == 1) then
					res=true
					st_num=1
				end
			else
				if(k%4 == 1) or (k%4 == 2)  then
					res=true
					st_num=2
				end
			end

			if res then
				step = k+st_num
				info=signdata[k] --��һ�������Ϣ
				osid=info.id --���id
				svrid= info[3] --������id

				if(signdata[step] == nil) then--�ֿմ���
					_1v1_jifen_end(3,nil,info)
					local jf = get_1v1_every_jf(3)
					PI_SendToLocalSvr(svrid,{ids = 10002,info=info,style = 0,jf = jf,times = times})
					return --��ѡƥ�����,��ֹѭ��

				else	--ƥ�䵽�������Ϣ	
					dinfo=signdata[step]
					dsid=dinfo.id 
					hsvrid=dinfo[3]					

					info1.id=osid
					info1[8] = dsid
					info1[20] = hsvrid

					info2.id=dsid
					info2[8] = osid
					info2[20] = svrid

					PI_SendToLocalSvr(svrid,{ids = 10002,info=info1,style = 1,jf = jf,times = times})--�Լ�
					PI_SendToLocalSvr(hsvrid,{ids = 10002,info=info2,style = 1,jf = jf,times = times})--�Է�
				
					if step>=#signdata and #signdata%2==0 then --ƥ�����
					
						return 
					end
				end	
			end
		end

	end
	if itype==2 and  v1_mate_time<=90 then--��ѡ1��ƥ��һ��
		return 1
	end
end

--ÿ��һ��ʱ�������������
--2����ѡ 3 Ԥ�� 4 ����� 5 ���� 0�˳���ʱ�� 
--style��ʾ�Ƿ��ֿ� 0 Ϊ�ֿ� 1��Ϊ�ֿ�
--round ��ʾ�Ƿ�ѭ�� 0��ʾ��ѭ�� 1��ʾѭ��
function GI_v1_noteam(itype,round)	

	local adata=_v1_getpub()
	--0��ʾ��ֹ��ʱ��
	if adata==nil or itype == 0 then return end
	local signdata=adata.sign
	--����

	--v1v_player_rank(signdata)
	v1_mark=2
	
	--��¼ս���Ĵ��� ���������������������ѭ��
	adata.times[itype] = (adata.times[itype] or 0) + 1
	local times = adata.times[itype] 
	--����
	local thistype=math.random(1,2)--ƥ�����Ū����,һ��1-2,3-4,һ��1-3,2-4

	-- local step,info,osid,svrid,dinfo,dsid,hsvrid

	-- for k,v in pairs(signdata) do
	-- 	if type(k)==type(0) and  type(v)==type({}) then  		
	-- 		--�����������������ż��
	-- 		local res
	-- 		if thistype==1 then 
	-- 			if(k%2 == 1) then
	-- 				res=true
	-- 				st_num=1
	-- 			end
	-- 		else
	-- 			if(k%4 == 1) or (k%4 == 2)  then
	-- 				res=true
	-- 				st_num=2
	-- 			end
	-- 		end

	-- 		if res then
	-- 			step = k+st_num
	-- 			info=signdata[k] --��һ�������Ϣ
	-- 			osid=info.id --���id
	-- 			svrid= info[3] --������id

	-- 			if(signdata[step] == nil) then--�ֿմ���
	-- 				_1v1_jifen_end(3,nil,info)
	-- 				local jf = get_1v1_every_jf(3)
	-- 				PI_SendToLocalSvr(svrid,{ids = 10002,info=info,style = 0,jf = jf,times = times})
	-- 			else	--ƥ�䵽�������Ϣ	
	-- 				dinfo=signdata[step]
	-- 				dsid=dinfo.id 
	-- 				hsvrid=dinfo[3]					

	-- 				info1.id=osid
	-- 				info1[8] = dsid
	-- 				info1[20] = hsvrid

	-- 				info2.id=dsid
	-- 				info2[8] = osid
	-- 				info2[20] = svrid

	-- 				PI_SendToLocalSvr(svrid,{ids = 10002,info=info1,style = 1,jf = jf,times = times})--�Լ�
	-- 				PI_SendToLocalSvr(hsvrid,{ids = 10002,info=info2,style = 1,jf = jf,times = times})--�Է�
	-- 			end	
	-- 		end
	-- 	end
	-- end
	--v1_mate(itype,signdata,thistype,times)--ִ��һ��

	v1_mate_time=0 --��ѡ��0,ȷ���´ΰ�ȫ

	SetEvent(1, nil, "v1_mate",itype,thistype,times)--1��ѭ��

	adata.room = {}
	adata.login = {}
	

	--��ѭ��
	if(round == 0) then
		return
	end	
	if(itype == 2 and  round == 1) then		
		if(times >= 15) then--��ѡ15��
			return
		else
			--return 180--3���Ӽ��
			return 240--4���Ӽ��
		end	
	elseif(itype == 3 and round == 1) then	
		if(times >= 10 ) then--Ԥѡ��10��
			return
		else	
			return 240 --4���Ӽ��
		end	
	elseif(itype == 4 and round == 1) then		
		if(times >= 10) then--�����10��
			return
		else	
			return 240--4���Ӽ��
		end	
	elseif(itype == 5 and round == 1) then		
		if(times >= 6) then--����6��
			return
		else	
			return 420--7���Ӽ��
		end	
	end
	
end

function v1_setevent(svrid,times,num1,num2,mark)
	local pdata = _v1_getpub()
	if(pdata==nil or pdata.sign == nil) then
		return
	end
	local temptb={}
	for i=num1,num2 do
		temptb[i]=pdata.sign[i]
	end
	PI_SendToLocalSvr(svrid,{ids = 10003,times =times,list = temptb,mark=mark})
end


--���1v1ÿ���������ǰ20��������Ϣ
function askinfo_1v1_rank_kf(itype,group)
	local pdata = _v1_getpub()
	if(pdata==nil or pdata.sign == nil) then
		return
	end
	--����
	if v1_mark==2 then 
		v1v_player_rank(pdata.sign)
		v1_mark=1
	end
	--�������Լ�����
	--local rank = getrank_byid(sid)
	local svrid = group
	local times = pdata.times[itype]
	--���rankΪ0 ���ʾ������ǷǱ������
	
	local temptb={}
	-- for i=1,20 do
	-- 	temptb[i]=pdata.sign[i]
	-- end
	-- PI_SendToLocalSvr(svrid,{ids = 10003,times =times,list = temptb,mark=1})
	
	
	-- SetEvent(1, nil, "v1_setevent",svrid,times,21,40,2)
	-- SetEvent(2, nil, "v1_setevent",svrid,times,41,60,2)
	-- SetEvent(3, nil, "v1_setevent",svrid,times,61,80,2)
	-- SetEvent(4, nil, "v1_setevent",svrid,times,81,100,3)
	
	for i=1,50 do
		temptb[i]=pdata.sign[i]
	end
	PI_SendToLocalSvr(svrid,{ids = 10003,times =times,list = temptb,mark=1})
	
	
	SetEvent(1, nil, "v1_setevent",svrid,times,51,100,3)
	-- SetEvent(2, nil, "v1_setevent",svrid,times,41,60,2)
	-- SetEvent(3, nil, "v1_setevent",svrid,times,61,80,2)
	-- SetEvent(4, nil, "v1_setevent",svrid,times,81,100,3)
	
end

--��ҿ��Ĥ��
 function kf1v1_worship(desid,index)
	local pdata = _v1_getpub()
	if(pdata==nil) then
		return
	end
	--�ҵ����
	local signinfo = pdata.sign
	if(signinfo[index] == nil) then return end
	if(signinfo[index].id~=desid) then
		return
	end
	signinfo[index][1] = (signinfo[index][1] or 0) + 1

end
--��ҿ��Ĥ�ݵ���Ϣ
function ask_1v1_worship_kf(group)
	local pdata = _v1_getpub()
	if(pdata==nil or pdata.sign == nil) then
		return
	end
	local signdata=pdata.sign
	local list = {}
	for i = 1,3 do
		if(signdata[i] and signdata[i][1]) then
			list[i]=signdata[i][1]
		end
	end
	local svrid = group
	PI_SendToLocalSvr(svrid,{ids = 10005,list = list})
end
--������󷵻ظ���Ҿ�������
 --[[function kf_quiz_lv1_save(sid,itype,sid1,sid2,sid3,num)
	local pdata = _v1_getpub()
	if(pdata==nil or pdata.sign == nil or pdata.show == nil) then
		return
	end
	local righttimes = 0 --�¶ԵĴ���
	local info = {playid,itype, sid1,ssid2,sid3,num,righttimes}
	if(pdata.quiz[itype] == nil) then
		pdata.quiz[itype] = {}
	end
	table.insert(pdata.quiz[itype],info)
end--]]

--���½�� listΪĳ�ֱ������ʹ������
--[[function kf_quiz_lv1_ret(itype,group)
	local pdata = _v1_getpub()
	if(pdata==nil or pdata.sign == nil ) then
		return
	end
	local signinfo = pdata.sign
	local list = {}
	for i = 1,3 do
		if(signinfo[i]) then
			table.insert(list,signinfo[i].id)
		end
	end
	--�򱾷�����Ϣ
	PI_SendToLocalSvr(group,{ids = 10006,itype = itype,list = list})	
end--]]

--itype 2����Ӯ 1 ������
function leaveSpan_1v1(sid,itype1,jf1,oid,itype2,jf2)
	--�򱾷�����Ϣ
	--local _,_,_,mapGID = CI_GetCurPos(2,sid)
	if sid then
		RPCEx(sid,'v1_leavespan',sid,itype1,jf1,oid,itype2,jf2)
	end
	if oid then
		RPCEx(oid,'v1_leavespan',sid,itype1,jf1,oid,itype2,jf2)
	end	
	--RegionRPC(mapGID,'v1_leavespan',sid,itype1,jf1,oid,itype2,jf2)--����ΪӮ�Ķ����б�--]]
end
--ͨ����������btype  ����times ���ret ��û�����ʾ

function get_1v1_every_jf(ret)
	local adata=_v1_getpub()
	local btype = in1v1time_area(0)
	if(adata == nil or btype == 0 or btype == 1) then
		return
	end	
	local times = adata.times[btype] or 1
	if(btype == 2) then
		if(times >= 0 and times <= 5) then
			if(ret == 1) then
				return 2
			elseif(ret == 2) then
				return 4
			elseif(ret == 3) then
				return 4
			end				
		elseif(times>=6 and times<=10) then
			if(ret == 1) then
				return 3
			elseif(ret == 2) then
				return 5
			elseif(ret == 3) then
				return 5
			end	
		elseif(times>=11 and times <= 15) then
			if(ret == 1) then
				return 5
			elseif(ret == 2) then
				return 7
			elseif(ret == 3) then
				return 7
			end	
		end
	elseif(btype == 3) then
		if(times>=1 and times<=10) then
			if(ret == 1) then
				return 0
			elseif(ret == 2) then
				return 2
			elseif(ret == 3) then
				return 1
			end	
		end
	elseif(btype == 4) then
		if(times>=1 and times<=10) then
			if(ret == 1) then
				return 0
			elseif(ret == 2) then
				return 2
			elseif(ret == 3) then
				return 1
			end	
		end
	elseif(btype == 5) then
		if(times>=1 and times<=6) then
			if(ret == 1) then
				return 0
			elseif(ret == 2) then
				return 2
			elseif(ret == 3) then
				return 1
			end	
		end
	end
end
--��տ������
function clear_1v1_kf()
	local active_lt = GetWorldCustomDB()
	active_lt.kf1v1 = {}
end
--�鿴����
--[[function test2(itype)
	local adata=_v1_getpub()
	if adata==nil then return end
	local times = adata.times[2]
	local list  = adata.sign
	look(adata,1)
	look(times,1)
	--look(adata.times,1)
end --]]
function get100_1v1()
	local adata=_v1_getpub()
	if adata==nil or adata.sign ==  nil  then return end
	local info=adata.sign
	local temp = {}
	for i = 1,#info do
		if type(info[i]) == type({}) then
			temp[i] = info[i]
		end
	end
	adata.sign = temp
	
	--��ʼȡ��������
	local signdata = adata.sign
	for i = 1,#signdata do
		if(i > 100) then
			signdata[i] = nil
		end
	end
end




