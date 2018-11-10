--[[
file: span_3v3_l.lua
desc: ���3v3_���ذ�
autor: wk
time:2014-3-3
]]--
---------------------------------------------------------------
--include:
local reg_info = msgh_s2c_def[43][1]
local reg_creat = msgh_s2c_def[43][2]
local reg_succ = msgh_s2c_def[43][3]
local reg_mi = msgh_s2c_def[43][4]
local reg_fair = msgh_s2c_def[43][5]
local _random=math.random
local db_module = require('Script.cext.dbrpc')
local db_get_span_server = db_module.db_get_span_server

local SPAN_3v3_ID=4 --���3v3�id
local LTRMAPID = 101 -- ��̨������ͼID
local LTMapPos = { --������������
	{16, 21},
}

---------------------------------------------------------------
--module:

-- module(...)

---------------------------------------------------------------
--data:
--���ֶε���
-- local score_conf={
-- 	[1]=-1000,
-- 	[2]=0,
-- 	[3]=1000,
-- 	[4]=1500,
-- 	[5]=2000,
-- 	[6]=2500,
-- 	[7]=3000,
-- }
-- local score_conf={
-- 	[1]=-1000,
-- 	[2]=5000,
-- 	[3]=1000,
-- 	[4]=1500,
-- 	[5]=2000,
-- 	[6]=2500,
-- 	[7]=3000,
-- }
---------------------------------------------------------------


-- ȡ��������(��������)
local function reg_getpub()
	local pub_data = GetWorldCustomDB()
	if pub_data ==nil then return end
	--pub_data.mark=1 --�������ʶ
	pub_data.room = pub_data.room or {}  --�����б�
	--[[
		[1]={ --���1
			[1]=name,--��������
			[2]	=lv,--�ȼ�
			[3]	=osid,--����sid
			[4]	=fid,--���id,����
			[5]=111--,����
			[6]=11,��Ա1sid
			[7]=11,��Ա1
			[8]=sid,����sid
			[9]=11,3����Ա׼�����
			},

		]]
	return pub_data
end

--�����������
function v3_getplayerdata(sid)
	local act_data = GetDBActiveData(sid)
	if act_data == nil then return end
	if act_data.v3 == nil then
		act_data.v3 = {
		--[[
			[1]=1,ʤ���ܴ���
			[2]=1,ʧ���ܴ���
			[3]=1,��ʷ�����ʤ
			[4]=1,��ǰ��ʤ
			[5]=1,��ʷ�������
			[6]=1,���տ������
			[7]=1,������ʤ�������
			psid={sid1,sid2}---��Գɹ�,�Լ��ӻ���,���ֶ�
			team={1,1}--������,λ��
			dead=1,�����������
			jf=11,����
			t={sid1,sid2,sid3}--3����,�ر��������
			tsid--�ӳ�sid
		]]--
		}
	end
	return act_data.v3
end

---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
--��ʼ
function _v3reg_start()
	-- look('�����',1)
	local adata=reg_getpub()
	if adata==nil then return end
	adata.room=nil
	adata.mark=1--������ʶ
	-- ��ȡ���3v3������б�(�ص�����: CALLBACK_SpanServerGets)
	db_get_span_server(SPAN_3v3_ID,0)
	-- local spxb = GetSpanListData(SPAN_3v3_ID)
	-- look(spxb[1],1)
	BroadcastRPC('v3_reg_Start')

end
--����
local function _v3reg_end()
	local adata=reg_getpub()
	if adata==nil then return end
	adata.room=nil
	adata.mark=nil
	BroadcastRPC('v3_reg_End')
end
--ÿ������
function v3_reset( sid )
	local pdata=v3_getplayerdata(sid)
	if pdata==nil then return end
	pdata[6]=nil
	pdata[7]=nil
end
--�����ж�
function _v3reg_online( sid )
	-- look('�����ж�',1)
	local x, y, rid, mapgid = CI_GetCurPos()
	local adata=reg_getpub()
	if adata==nil then return end
	if adata.mark==nil  then return end

	if rid==101 then 
		if  adata.room==nil then return end
		local teamID = CI_GetPlayerData(12)
		local bLeader
		if teamID and teamID ~= 0 then
			-- look('�ж���',1)
			local TeamInfo = GetTeamInfo()	
			local leaderSID
		  	for k,v in pairs(TeamInfo) do
		  		if k==1 then 
		  			leaderSID=v.staticId
		  		end			
			end
			if adata.room[leaderSID]~=nil then 
					-- look(111,1)
				SendLuaMsg(0,{ids=reg_creat,tinfo=adata.room[leaderSID]},9)
			end
		else
			if adata.room[sid]~=nil then --�Լ�һ���˴���״̬
				-- look(111,1)
				SendLuaMsg(0,{ids=reg_creat,tinfo=adata.room[sid]},9)
			else --���ǲ��ǿ������,�������
				local pdata=v3_getplayerdata(sid)
				if pdata~=nil and pdata.t~=nil then 
					local sid1=pdata.t[1]
					local sid2=pdata.t[2]
					local sid3=pdata.t[3]
					if sid==sid3 then --�ӳ�
						if sid1 then
							AskJoinTeam(sid1,sid3)--��2������Ϊ�ӳ�
						end
						if sid2 then
							AskJoinTeam(sid2,sid3)--��2������Ϊ�ӳ�
						end
					else --��Ա
						AskJoinTeam(sid,sid3)--��2������Ϊ�ӳ�
					end
				end
			end
		end

	end
	-- look('�����ж����',1)
	RPC('v3_reg_Start',1)
	
end
--���뱨������
function _v3reg_enter( sid)
	-- local lv = CI_GetPlayerData(1)
	-- if lv and lv < 35 then
	-- 	return
	-- end
	local adata=reg_getpub()
	if adata==nil then return end
	if adata.mark~=1 then --������ʶ
		return
	end

	local rd = _random(1, #LTMapPos)
	local pos = LTMapPos[rd]
	if not PI_MovePlayer(LTRMAPID,pos[1],pos[2],0,2,sid) then
		look("_lt_putinto_map faild")
	end
end

--��������б� 
local function _reg_getteaminfo( )
	-- look('��������б�',1)
	local adata=reg_getpub()
	if adata==nil then return end
	local roomdata=adata.room
	SendLuaMsg(0,{ids=reg_info,info=roomdata},9)
end
--����3v3����
local function _reg_creatteam( sid ,mi)
	-- look('����3v3����',1)
	local adata=reg_getpub()
	-- local pdata=reg_get_mydata(sid)
	if adata==nil then return end
	local roomdata=adata.room
	  -- [3] check team leader
	local teamID = CI_GetPlayerData(12)
	-- look("teamID:" .. teamID,1)
	local bLeader
	if teamID and teamID ~= 0 then
		bLeader = CI_GetPlayerData(13)
		if bLeader and bLeader == 0 then-- �ж���ȴ���Ƕӳ����ܴ�������	
			return
		end
	end

	if roomdata[sid]~=nil then 
		-- TipCenter('�Ѵ���')
		return
	end

	local tinfo={
		[1]=CI_GetPlayerData(5),--��������
		[2]	=CI_GetPlayerData(1),--�ȼ�
		-- [3]	=CI_GetPlayerData(23),--�������,�ĳɶ���sid��
		-- [4]	=CI_GetPlayerData(23),--���id,����
		[4]=CI_GetFactionInfo(nil,1),
		-- [5]=mi,--,����

		[8]=sid,
		}
	if bLeader then
		local TeamInfo = GetTeamInfo()	
		local ti=6
	  	for _,v in pairs(TeamInfo) do			
			if v.staticId ~= nil and v.staticId ~= sid then
				tinfo[ti]=v.staticId
				ti=ti+1
			end
		end	
	end
	-- _insert(roomdata,tinfo)
	roomdata[sid]=tinfo
	-- pdata.id=#roomdata
	-- look(#roomdata,1)
	-- look(pdata,1)
	local teamID = CI_GetPlayerData(12)
	if teamID and teamID ~= 0 then
		local att={}
		for i=6,8 do
			if roomdata[sid][i] then 
				att[i]=CI_GetPlayerData(62,2,roomdata[sid][i])
			end
		end
		TeamRPC(teamID,"reg_in",tinfo,att)
	else

		SendLuaMsg(0,{ids=reg_creat,tinfo=tinfo},9)
	end
	-- look(roomdata,1)
end

--�������
local function _reg_intoteam( sid,osid,mi )
	-- look('�������',1)
	-- look(sid,1)
	-- look(osid,1)
	-- look(CI_GetPlayerData(5,2,osid),1)
	local index=osid
	local adata=reg_getpub()
	if adata==nil then return end
	local roomdata=adata.room
	
	if roomdata[index]==nil then 
		SendLuaMsg(0,{ids=reg_mi,res=3},9)
		return 
	end
	if roomdata[index][5] then --����
		if mi~=roomdata[index][5] then 
			SendLuaMsg(0,{ids=reg_mi,res=2},9)
			return 
		end
	end

	local ret = AskJoinTeam(sid,osid)
	-- look(ret,1)
	if ret == false then 
		-- look(333,1)
		return 
	end

	if roomdata[index][6]==nil then
		roomdata[index][6]=sid
	elseif roomdata[index][7]==nil then
		roomdata[index][7]=sid
	else
		return
	end

	local att={}
	for i=6,8 do
		if roomdata[index][i] then 
			att[i]=CI_GetPlayerData(62,2,roomdata[index][i])
		end
	end

	local teamID = CI_GetPlayerData(12)
	TeamRPC(teamID,"reg_in",roomdata[index],att)
	-- look(555,1)
end
--���ٽ���
function v3_quick_in( sid )
	-- look('���ٽ���',1)
	local adata=reg_getpub()
	if adata==nil then return end
	local roomdata=adata.room
	local mark
	for k,v in pairs(roomdata) do
		if (v[6]==nil or v[7]==nil) and type(v[8])==type(0) then 
			if v[5]==nil then --δ����
				-- look(111,1)
				_reg_intoteam( sid,v[8] )
				mark=1
				break
			end
		end
	end
	if not mark then 
		-- look(222,1)
		_reg_creatteam( sid )
	end
end
--�޸�����
function v3_changemima( sid,mi )
	-- look('�޸�����',1)
	-- look(mi,1)
	local adata=reg_getpub()
	if adata==nil then return end
	local roomdata=adata.room
	if roomdata[sid]==nil then return end
	roomdata[sid][5]=mi
	SendLuaMsg(0,{ids=reg_mi,res=1},9)
	-- look(1111,1)
end
--�߳���Ա t�ӳ��ǽ�ɢ����
local function _reg_tplayer( sid,name )
	-- look('�߳���Ա',1)
	-- look(sid,1)
	-- look(name,1)
	local adata=reg_getpub()
	if adata==nil then return end
	local roomdata=adata.room

	local TeamInfo = GetTeamInfo()	
	local leaderSID
	
	if TeamInfo then
	  	for k,v in pairs(TeamInfo) do
	  		if k==1 then 
	  			leaderSID=v.staticId
	  		end			
		end
	else
		leaderSID=sid
	end
	-- look(1111,1)
	-- local osid=GetPlayer(name)
	local osid=name
	local teamID = CI_GetPlayerData(12)
	if roomdata[leaderSID]==nil then return end
	local info=roomdata[leaderSID]
	if info[6]==osid then ---��λ
		-- look(222,1)
		info[6]=nil
		info[9]= rint((info[9] or 0)/10)*10--����λȥ��
		-- look(roomdata[leaderSID],1)
		--���7�����Ƶ�6��
		if info[7] then
			info[6]=info[7]
			info[9]= rint((info[9] or 0)/10)---��ʮλת��Ϊ��λ
			info[7]=nil
		end

		TeamRPC(teamID,"reg_in",roomdata[leaderSID]) --��ӹ㲥
	elseif info[7]==osid then ---ʮλ
		-- look(3333,1)
		info[7]=nil
		info[9]= (info[9] or 0)%10--��ʮλȥ��
		-- look(roomdata[leaderSID],1)
		TeamRPC(teamID,"reg_in",roomdata[leaderSID]) --��ӹ㲥
	elseif info[8]==osid then 
		-- look(4444,1)
		roomdata[leaderSID]=nil --��ɢ
		-- local teamID = CI_GetPlayerData(12)
		-- if teamID and teamID ~= 0 then
		-- 	TeamRPC(teamID,"reg_js") --��ɢ
		-- else
		-- 	RPC("reg_js")
		-- end
		TeamRPC(teamID,"reg_in",roomdata[leaderSID]) --��ӹ㲥
	end
	-- DeleteTeamMember(leaderSID,name)
	DeleteTeamMember(leaderSID,CI_GetPlayerData(5,2,name))
end

--����
function v3reg_logout( sid )
	-- look('����',1)
	local adata=reg_getpub()
	if adata==nil then return end
	if  adata.room==nil then return end ---���������
	if adata.room[sid]~=nil then --�ӳ�����
		if adata.room[sid][6] then
			_reg_tplayer( sid,adata.room[sid][6] )
		end
		if adata.room[sid][7] then
			_reg_tplayer( sid,adata.room[sid][7] )
		end
		adata.room[sid]=nil
		return
	end
	--��Ա����
	local TeamInfo = GetTeamInfo()	
	-- look(99,1)
	if TeamInfo==nil then return end
	local tsid
	-- look(88,1)
  	for k,v in pairs(TeamInfo) do			
		if k==1 then 
			tsid=v.staticId
			break
		end
	end	
	if tsid==nil then return end 
	-- look(sid,1)
	-- look(tsid,1)
	-- look(adata.room,1)
	if adata.room[tsid]~=nil then 
		-- look(00,1)
		_reg_tplayer( sid,sid ) --t�Լ�
		local pdata=v3_getplayerdata(sid)
		if pdata==nil then return end
		pdata.t=nil --��������,ȥ���������鹦��
	end
	-- pdata.psid=nil---��Գɹ�,�Լ��ӻ���,���ֶ�
	-- pdata.team=nil--������,λ��
	-- pdata.dead=nil--,�����������

end
--׼�����,itype=1ȡ��׼��
local function _reg_reday( sid,itype )
	-- look('׼�����',1)
	-- look(itype,1)
	local adata=reg_getpub()
	if adata==nil then return end
	local roomdata=adata.room

	local TeamInfo = GetTeamInfo()	
	local leaderSID
	if TeamInfo==nil then return end
  	for k,v in pairs(TeamInfo) do
  		if k==1 then 
  			leaderSID=v.staticId
  		end			
	end
	if leaderSID==nil then return end
	local info=roomdata[leaderSID]
	if info==nil then return end
	if  sid==info[6] then
		if itype==1 then
			info[9]= rint((info[9] or 0)/10)*10
		else
			info[9]= (info[9] or 0) +1
		end
	elseif  sid==info[7] then
		if itype==1 then--quxiao
			info[9]= (info[9] or 0)%10
		else
			info[9]= (info[9] or 0)%10 +10
		end
	end
	-- look(info[9],1)
	local teamID = CI_GetPlayerData(12) 
	TeamRPC(teamID,"reg_in",roomdata[leaderSID]) --������ӹ㲥
	--SendLuaMsg(osid,{ids=reg_zb,osid=sid},10)
end
--�ӳ�����
local function _reg_sign(sid )
	-- look('�ӳ�����',1)
	local adata=reg_getpub()
	if adata==nil then return end
	local roomdata=adata.room
	-- local signdata=adata.sign
	-- local pdata=reg_get_mydata(sid)
	-- local id=pdata.id
	local id=sid
	-- local jifen=333
	local jifen=0
	local num=0
	if roomdata[id]==nil then return end
	local sid1=roomdata[id][6]
	local sid2=roomdata[id][7]
	local sid3=roomdata[id][8]
	local neednum=0
	for i=6,8 do
		
		if roomdata[id][i] then 
			local pdata=v3_getplayerdata(roomdata[id][i])
			if pdata then 
				pdata.t={sid1,sid2,sid3}
				pdata.deadnum=nil
				jifen=jifen+(pdata.jf or 1000)
				num=num+1
				if i==6 then 
					neednum=1
				elseif i==7 then
					neednum=neednum+10
				end
			end
		end
		
	end

	if (roomdata[id][9] or 0)~=neednum then 

		return 
	end

	jifen=jifen/num
	-- look(jifen,1)
	

	local teaminfo={sid1,sid2,sid3,jifen,GetGroupID()}
	roomdata[id]=nil
	local teamID = CI_GetPlayerData(12) 
	if teamID and teamID ~= 0 then
		TeamRPC(teamID,"v3_lock") --���������,��������
	else
		RPC("v3_lock") --���������,��������
	end

	--37��103,360 101,����102
	local serverid=9990001
	-- if __plat == 101 or __plat == 102 or __plat == 103 then
	-- 	serverid = 9990101
	-- end
	--�Ͽ���� ʹ��9990001
	-- if  __plat == 103 then
		-- serverid = 9990101
	-- elseif __plat == 101 then
		-- serverid = 9990111
	-- end
	-- look(GetGroupID(),1)
	PI_SendToSpanSvr(serverid,{ ids = 4001, svrid = GetGroupID(),info=teaminfo})
end

--�յ�����������ظ�,res=1��Գɹ�,osid=��һ��ӳ�id
function _v3reg_get_kfref(res,ojf,info,id,num,kfnum)
	-- look('�յ�����������ظ�',1)
	-- look(res,1)
	-- look(osid,1)
	-- look(info,1)
	if res~=1 then return end
	local jf=info[4]
	for i=1,3 do
		if info[i] then 
			local pdata=v3_getplayerdata(info[i])
			if pdata then 
				pdata.psid={jf,ojf,kfnum}
				pdata.team={id,num}
				-- look('���͸�ǰ̨ȷ��',1)
				SendLuaMsg(info[i],{ids=reg_succ,info=info},10)
			end
		end
	end
end
--ǰ̨ȷ������
local function _v3reg_endin(sid,pass, localIP, port, entryid)
	-- look('ǰ̨ȷ������',1)
	local pdata=v3_getplayerdata(sid)
	local spxb = GetSpanListData(SPAN_3v3_ID)
	if spxb == nil or spxb[1]==nil then return end
	local kfnum=pdata.psid[3]
	local sInfo=spxb[1][kfnum]
	SetPlayerSpanUID(sid,SPAN_3v3_ID)
	local span_id = GetTargetSvrID(sInfo[1])
	local span_ip= sInfo[2]
	local span_port=sInfo[3]
	-- look(sid,1)
	-- look(span_id,1)
	-- look(span_ip,1)
	-- look(span_port,1)
	-- look(pass,1)
	-- look(localIP,1)
	-- look(port,1)
	-- look(entryid,1)
	-- �������Ѫ��
	PI_PayPlayer(3,1000000,nil,nil,'���3v3')
	PI_EnterSpanServerEx(sid, span_id, span_ip, span_port, pass, localIP, port, entryid)
end

--���ʧ��
function v3reg_fair_kf(info)
	-- look('���ʧ��',1)
	for i=1,3 do
		if info[i] then 
			local pdata=v3_getplayerdata(info[i])
			if pdata then 
				SendLuaMsg(info[i],{ids=reg_fair},10)
			end
		end
	end
end
--ȡ�����ʤ��
function v3_getmaxwin( sid )
	local pdata=v3_getplayerdata(sid)
	if pdata==nil then return end
	return pdata[3]
end
---------------------------------------------
v3reg_start=_v3reg_start
v3reg_enter=_v3reg_enter
v3reg_online=_v3reg_online
reg_inter=_reg_inter
reg_creatteam=_reg_creatteam
reg_intoteam=_reg_intoteam
reg_tplayer=_reg_tplayer
reg_reday=_reg_reday
reg_sign=_reg_sign
reg_getteaminfo=_reg_getteaminfo
v3reg_get_kfref=_v3reg_get_kfref
v3reg_endin=_v3reg_endin
v3reg_end=_v3reg_end
