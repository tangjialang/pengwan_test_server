--[[
file:	Active_escort.lua
desc:	��������
author:	wk
update:	2013-06-7
]]--


local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local Escort_Get	 = msgh_s2c_def[18][1]	
local Escort_Status	 = msgh_s2c_def[18][2]	
local Escort_Finish	 = msgh_s2c_def[18][3]	
local Escort_Kill 	 = msgh_s2c_def[18][4]	
local es_lb 		 = msgh_s2c_def[18][6]	
local es_getzf 		 = msgh_s2c_def[18][7]	
local look = look
local uv_TimesTypeTb = TimesTypeTb
local _floor,_random=math.floor,math.random
local TipCenter=TipCenter
local GetStringMsg=GetStringMsg
local AddPlayerPoints=AddPlayerPoints
local CI_HasBuff=CI_HasBuff
local CI_GetPlayerData=CI_GetPlayerData
local PI_PayPlayer=PI_PayPlayer
local CheckTimes=CheckTimes
local GiveGoods=GiveGoods
local HasTask=HasTask
local CI_DelBuff=CI_DelBuff
local TS_DropTask=TS_DropTask
local isFullNum=isFullNum
local CI_GetCurPos=CI_GetCurPos
local CheckCost=CheckCost
local TS_AcceptTask=TS_AcceptTask
local os,pairs,type,ipairs=os,pairs,type,ipairs
local GetDBActiveData=GetDBActiveData
local rint=rint
local CI_AddBuff=CI_AddBuff
local baoyue_getpower=baoyue_getpower
local GetServerTime=GetServerTime
local CheckGoods=CheckGoods
-----------------------------------------------------------------------------



----------------------------------------------------------------------------
-- module:

module(...)

----------------------------------------------------------------------------

--ÿ�չ̶��ʱ��13��10 �C 14:00���ɻ��1.5��Ѻ�����棨����Ͱ������棩
local ESCORT_ADDTIME = {1310,1400}
local ESCORT_EXTRA = 1.5
local color_award={1,1.2,1.5,3,4}--����ɫ�ڳ���������
local minlv=40 --40�������ٳ���ɫ
local task_id={4999,4999,210,210} --ȡ����id--35��ǰ,35����
local get_color={ --�������ϳ� ����
	{40,99,100,100,100,}, 
	{0,50,99,100,100,},
	{0,0,90,100,100,},
	{0,0,0,93,100,},
}
local  e_xyconf={ --�����¼����Ǯ,���Ǯ
	[3]={20000,40000},
	[4]={100000,150000},
}
--���������
local  libao={---id,num,��,����
		[1]={602,1,1,2000},
		[2]={602,3,1,6000},
		[3]={603,1,1,8000},
		[4]={603,3,1,9900},
		[5]={732,1,1,10000},
}
ESCORT_Amark=ESCORT_Amark or false --��Ӫ���ʶ
--��Ӫ���������
ESCORT_Conf=ESCORT_Conf or false

--Ѻ����Ӫ�����--itype=1��ʼ,0����
local function _escort_activecall(itype,msg)
	-- look('Ѻ����Ӫ�����')
	-- look(itype)
	if itype==1 then
		ESCORT_Amark=true
		ESCORT_Conf=msg
	else
		ESCORT_Amark=false
		ESCORT_Conf=nil
	end
end
------------------------------------------------ 11
--�������
local function _getescortdata(sid)
	if(sid == nil)then return end
	local dayData = GetDBActiveData(sid)
	if dayData==nil  then return end
	if dayData.esco == nil then
		dayData.esco = {
		--[1]=1,--����״̬
		--[2]=3,--�ڳ���ɫ
		
		--[3]=3,--����,����ʱ���д��ֶ�,���������ܸ�����
		--[4]=3,--����
		--[9]=4,���ף��ֵ
		--[10]=3,����ֵ
		}
	end
	return dayData.esco
end
--���⽱��
local function ESCORT_Other_award(sid,color)
	-- look('���⽱��')
	-- look(sid)
	-- look(color)
	if ESCORT_Amark==false then return end
	-- look(111)
	-- look(ESCORT_Conf)
	if type (ESCORT_Conf) == type ({}) then
		-- look(222)
		local award=ESCORT_Conf[color]
		if award then
			-- look(333)
			for k,v in pairs(award)  do
				-- look(444)
				if type(k) == type (0) and type(v) == type ({}) then
					-- look(555)
					for i,j in pairs(v)  do
						-- look(666)
						GiveGoods(i,j ,1,'������Ӫ�')
					end
				end
			end
		end
	end
end
--Ѻ����Ӫ��жϰ���
local function Check_ESCORT_active(sid,color,other)
	if ESCORT_Amark==true then 
		if type (ESCORT_Conf) == type ({}) then
			if type (ESCORT_Conf[color]) == type ({}) then
				local award=#ESCORT_Conf[color]+other
				local pakagenum = isFullNum()
				if pakagenum < award then
					TipCenter(GetStringMsg(14,award))
					return false
				end 
			end
		end
	end
	return true
end
--����Ѻ����Ϣ
local function escort_status(sid)
	local sData = _getescortdata(sid)
	if(sData~=nil)then
		SendLuaMsg( 0, { ids=Escort_Status, status = sData[1],ctype=sData[2]}, 9 )
	end
end
--���ڻ�ȡ�ľ���,����,��Ԫ��
local function escort_expmoney(carType)
	if(carType<1 or carType>5)then return end
	local getexp,getBY 
	local goodsnum=2--�ʱ��3������
	local level = CI_GetPlayerData(1)
	if level<35 then
		level=35
	end
	local beishu=color_award[carType]
	getexp = _floor(level^2.4*10*beishu)
	getBY = _floor(level*250*beishu)
	local curdt = os.date( "*t", GetServerTime())
	local now=curdt.hour*100+curdt.min
	if  now>= ESCORT_ADDTIME[1] and now <= ESCORT_ADDTIME[2] then
		getexp = _floor(getexp * ESCORT_EXTRA)
		getBY = _floor(getBY * ESCORT_EXTRA)
		goodsnum=3
	end
	return getexp,getBY,goodsnum
end

--�õ�ˢ�º���ɫ
local function rndescort(now,level,cost)
	
	local sid = CI_GetPlayerData(17) 
	local sData = _getescortdata(sid)
	local res=baoyue_getpower( sid,2 )--����Ȩ��
	if(level<minlv) or  res then
		now= 4
	end
	
	local tempType=now
	local rate =_random(1,100)
	local gateconf=get_color[now]
	local xy=sData[10] or 0
	if now>=3 then --4,5��ɫ���⴦��
		
		local min=rint((level^2+1000)/1000)*e_xyconf[now][1]
		local max=rint((level^2+1000)/1000)*e_xyconf[now][2]
		if res then 
			min=min/3
			max=max/3
		end
		if xy<min then --����ֵ����
			--������ֵ
			sData[10]=xy+cost
			return tempType
		elseif  xy>=max then --����ֵ��
			sData[10]=xy+cost
			return tempType+1
		end
	end

	for k,v in pairs(gateconf) do
		if rate<=v then
			tempType=k
			break
		end
	end
	--������ֵ
	sData[10]=xy+cost
	return tempType
end
---------------------------------------------------------------------------------
--��ʼ����
local function _startescort()
	local level = CI_GetPlayerData(1)
	if level < 20 then --���ڵȼ�����
		TipCenter( GetStringMsg(4,20))
		return
	end
	local cx, cy, rid, isdy = CI_GetCurPos()
	if(rid ~= 1 or cx<80 or cx>90 or cy>85 or cy<71)then
		TipCenter( GetStringMsg(421))
		return
	end
	local sid = CI_GetPlayerData(17) 
	local sData = _getescortdata(sid)
	if(sData == nil)then return end
	if not CheckTimes(sid,uv_TimesTypeTb.Escort_time,1,-1,1) then
		TipCenter( GetStringMsg(429))
		return
	end
	if( sData[1] == 1)then
		TipCenter( GetStringMsg(430))
		return
	end
	TipCenter( GetStringMsg(422))
	local itype=sData[2] or 1
	CI_AddBuff(itype+368,0,1,false)--��ʦ�ֱ���
	sData[1] = 1 --����״̬
	escort_status(sid)--����Ѻ����Ϣ
	if not HasTask(sid,2027) then --����������ʱ��������ʱ�۴���
		CheckTimes(sid,uv_TimesTypeTb.Escort_time,1,-1)
	else
		CI_AddBuff(140,0,1,false)--��һ�λ����޵�
	end
	local taskid = task_id[2]
	-- if level<38 then 
	-- 	taskid = task_id[1]
	-- end
	TS_AcceptTask(sid,taskid,53) --������ 
end

--ˢ��
local function _refescort(times)
	look('ˢ��')
	look(times)
	local sid = CI_GetPlayerData(17) 
	local sData = _getescortdata(sid)
	if(sData == nil)then return end
	if(sData[1] == 1 )then
		TipCenter( GetStringMsg(430))
		return
	end
	if(sData[2] and sData[2]>=5)then
		return --û��Ҫˢ��
	end
	if not CheckTimes(sid,uv_TimesTypeTb.Escort_time,1,-1,1) then
		TipCenter( GetStringMsg(429))
		return
	end
	local level = CI_GetPlayerData(1)
	local cost=rint((level^2+1000)/1000)*1000
	
	local money=0
	local nowtype=sData[2] or 1
	if times and times>1 then
		if times<=nowtype then return end
		repeat
			-- look('����ˢ��ѭ��',1)
			if not CheckCost(sid,cost,0,3,"����ˢ��") then
				TipCenter( GetStringMsg(3))
				cost =false
			else
				money=money+cost
				local renum=rndescort(nowtype,level,cost)	
				if renum>nowtype then
					nowtype=renum
				end
			end
		until (nowtype>=times or cost == false )
	else
		if not CheckCost(sid,cost,0,3,"����ˢ��") then
				TipCenter( GetStringMsg(3))
				return
			else
				money=cost
				local renum=rndescort(nowtype,level,cost)	
				
				if renum>nowtype then
					 nowtype=renum
				end	
			end
		end
	sData[2]=nowtype
	SendLuaMsg( 0, { ids=Escort_Get, ctype = nowtype,money=money}, 9 )
end

--�������
local function _endescort(issuccess,curSid,isnpc)
	if (curSid == nil) then
		local sid = CI_GetPlayerData(17)
		local level = CI_GetPlayerData(1)
		local sData = _getescortdata(sid)
		if(sData == nil)then return end
		if( sData[1]==nil )then
			if(isnpc)then
				TipCenter( GetStringMsg(425))
			end
			return
		end
		local itype=sData[2] or 1
		local getexp,getBY ,goodsnum= escort_expmoney(itype)
		local cx, cy, rid, isdy = CI_GetCurPos()
		local fail
		if(issuccess)then --���ڳɹ�
			local other=0
			if itype==5 then
				local pakagenum = isFullNum()
				if pakagenum < 1 then
					TipCenter(GetStringMsg(14,1))
					return 
				end
				other=1
			end
			if not Check_ESCORT_active(sid,itype,other) then --��Ӫ������ж�
				return 
			end
			-- if((rid~=32) or cx<45 or cx>50 or cy <5 or cy>14)then --���ڵ�ͼ����
			-- 	TipCenter( GetStringMsg(424))
			-- 	return
			-- end
			if itype==5 then
				GiveGoods(1084,goodsnum,1,'����' )
			end
			AddPlayerPoints(sid,2,getBY,nil,'���ͽ���')
			PI_PayPlayer(1, getexp,0,0,'���ͽ���')

			ESCORT_Other_award(sid,itype)--��Ӫ�����
		else --����ʧ��
			fail = 1
			getBY = _floor(getBY*0.5)
			getexp = _floor(getexp * 0.5) --����ֻ��ԭ���� ��� 50%�ľ��� 50%�İ���
			if sData[5]==100 then --������������˾���,����ʱ��
				sData[3]=getexp
				sData[4]=getBY
			else
				AddPlayerPoints(sid,2,getBY,nil,'���ͽ���')
				PI_PayPlayer(1, getexp,0,0,'���ͽ���')
			end
			TipCenter( GetStringMsg(428))
		end
		
		
		
		sData[2] = nil--��������
		sData[1] = nil
		sData[10]=nil
		
		escort_status(sid)	--����Ѻ��״̬
		if  HasTask(sid,2027) then --����������ʱ��������ʱ�۴���
			CheckTimes(sid,uv_TimesTypeTb.Escort_time,1,-1)
			CI_DelBuff(140)
		end
		SendLuaMsg( 0, { ids=Escort_Finish, getexp = getexp, getBY = getBY, fail = fail}, 9 )
		CI_DelBuff(itype+368)
		local taskid=4999
		-- if  HasTask(sid,4998) then
		-- 	taskid=4998
		-- 	TS_DropTask( sid, taskid) --��������
		
		-- elseif HasTask(sid,4999) then
			--taskid=4999
			TS_DropTask( sid, taskid) --��������
		-- end
		
	end
end


--������������˾���,����ʱ��
local function _pay_escortexponlive(sid)

	local sData = _getescortdata(sid)
	if(sData==nil)then
		return
	end
	if sData[5]==100 then 
		PI_PayPlayer(1, sData[3],0,0,'���ͽ���')
		AddPlayerPoints(sid,2,sData[4],nil,'���ͽ���')
		sData[3]=nil
		sData[4]=nil
		sData[5]=nil
	end
end


--NPC����
local function _endescortnpc(sid, npcid)
look(npcid)
	local sub_id =210
	-- if  HasTask(sid,4998) then
	-- 	sub_id=210
	-- 	look(11)
	-- elseif HasTask(sid,4999) then
	-- 	sub_id=209
	-- 	look(22)
	-- else
	-- 	look(33)
	-- 	return
	-- end
	if npcid ~= sub_id then
		return
	end
	_endescort(true,nil,true)
end

--����������,����������
local function _escort_playerdead(sid,fsid)

	local sData1 = _getescortdata(sid)
	if( sData1[1] == 1 )then
		local itype=sData1[2] or 1
		sData1[5] = 100--���������ƾ�˸�����
		_endescort(false)
		
		if type(fsid)==type(0) and fsid~=0 then
			if not CheckTimes(fsid,uv_TimesTypeTb.Escort_kill,1,-1,1) then
				SendLuaMsg(fsid,{ids=Escort_Kill,getexp=0,},10)
				return
			end
			local getexp,getBY= escort_expmoney(itype)
			getBY = _floor(getBY*0.5)
			getexp = _floor(getexp * 0.5)
			
			if(getexp~=nil and getBY~=nil)then
				AddPlayerPoints(fsid,2,getBY,nil,'���ͽ���')
				PI_PayPlayer(1, getexp,0,0,'���ͽ���',2,fsid)

				CheckTimes(fsid,uv_TimesTypeTb.Escort_kill,1,-1)
				SendLuaMsg(fsid,{ids=Escort_Kill,getexp=getexp,getBY=getBY},10)
			end
		end
		
		
		
	else
		return
	end
	
	
	return true
end
--���������ߴ���
local function _escort_login()
	local sid = CI_GetPlayerData(17) 
	local sData = _getescortdata(sid)
	if sData==nil then return end
	if(sData[1]==1)then
		local a=(sData[2] or 1)+368
		if not CI_HasBuff(a) then 	--�ж������Ƿ���Ѻ��buff
			_endescort(false)
		else
			escort_status(sid)
		end
	elseif(sData[5]==100)then
		PI_PayPlayer(1, sData[3],0,0,'���ͽ���')
		AddPlayerPoints(sid,2,sData[4],nil,'���ͽ���')
		SendLuaMsg( 0, { ids=Escort_Finish, getexp = sData[3], getBY = sData[4], fail = fail}, 9 )
		sData[3]=nil
		sData[4]=nil
		sData[5]=nil
	end
end

--ʹ�ú��������
function _es_ueslibao( sid )
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return 0
	end
	
	local sData = _getescortdata(sid)
	if sData==nil then return 0 end
	if 0 == CheckGoods(1084,1,0,sid,'�����˳齱') then
		return
	end
	local rannum=_random(1,10000)
	local getnum=1
	for k,v in ipairs(libao) do		
		if rannum<=v[4] then
			GiveGoods(v[1],v[2] ,v[3],'�����˳齱')
			getnum=k
			break
		end
	end
	
	if (sData[9] or 0)<9 then
		sData[9]=(sData[9] or 0)+1
	end
	SendLuaMsg( 0, { ids=es_lb,get=getnum,zf=sData[9]}, 9 )
end
--ף��ֵ�춫��
function _es_getzfgoods( sid )
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return 0
	end
	local sData = _getescortdata(sid)
	if sData==nil then return 0 end
	if (sData[9] or 0)<9 then
		return 0
	end
	if not CheckCost(sid , 30, 0 , 1,'ף��ֵ�춫��') then
		return 0
	end
	
	GiveGoods(732,1 ,1,'ף��ֵ�춫��')
	sData[9]=nil
	SendLuaMsg( 0, { ids=es_getzf,zf=0}, 9 )
end
-------------------------------------------------------
refescort=_refescort
startescort=_startescort
endescort=_endescort
endescortnpc=_endescortnpc
getescortdata=_getescortdata
pay_escortexponlive=_pay_escortexponlive
escort_playerdead=_escort_playerdead
escort_login=_escort_login
escort_activecall=_escort_activecall
es_ueslibao=_es_ueslibao
es_getzfgoods=_es_getzfgoods
