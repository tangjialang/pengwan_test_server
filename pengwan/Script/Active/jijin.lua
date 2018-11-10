--[[
file:	jijin.lua
desc:	����,��
author:	wk
update:	2014-2-24
]]--


local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local JJ_cunru	 = msgh_s2c_def[12][38]	
local JJ_award	 = msgh_s2c_def[12][39]
local JJ_out	 = msgh_s2c_def[12][40]
local db_module = require('Script.cext.dbrpc')
local db_RANK_in = db_module.db_RANK_in---(mainID,pname,rank)
local common_time = require('Script.common.time_cnt')
local GetDiffDayFromTime=common_time.GetDiffDayFromTime
local GetServerTime=GetServerTime
local DBRPC=DBRPC
local isFullNum,TipCenter,GetStringMsg=isFullNum,TipCenter,GetStringMsg
local pairs,GiveGoods=pairs,GiveGoods
local look=look
local GetWorldCustomDB,GI_GetPlayerData=GetWorldCustomDB,GI_GetPlayerData
local rint,CheckCost=rint,CheckCost
local GetServerOpenTime=GetServerOpenTime
local DGiveP=DGiveP
local GetGroupID=GetGroupID
local os_date=os.date
local RPC=RPC	
local GetWorldLevel=GetWorldLevel

-------------------------------------------------------------------------------
module(...)

  --�������� 1=ÿ�ս���,2=6�����ν���
-- local jj_conf={
-- 	[1]={{802,1,1},{803,10,1},{627,10,1},{626,10,1},{601,10,1},{603,10,1},},
-- 	[2]={
-- 		[1]={{803,100,1},},
-- 		[2]={{803,200,1},{603,50,1},},
-- 		[3]={{802,50,1},{771,10,1},{626,200,1},},
-- 		[4]={{802,100,1},{796,50,1},{601,100,1},{603,100,1},},
-- 		[5]={{802,150,1},{766,3,1},{803,200,1},{601,200,1},{603,200,1},},
-- 		[6]={{801,50,1},{789,100,1},{712,1,1},{802,200,1},{752,5,1},{796,100,1},},
-- 		},
-- }
local jj_conf={
	[50]={
		[1]={{803,40,1},{601,20,1},{812,40,1},{1601,10,1},{1585,40,1},{762,4,1},},
		[2]={
			[1]={{803,200,1},},
			[2]={{803,400,1},{804,30,1},},
			[3]={{803,800,1},{804,60,1},{796,20,1},},
			[4]={{803,1200,1},{804,100,1},{796,30,1},{778,10,1},},
			[5]={{803,2500,1},{804,150,1},{796,80,1},{778,15,1},{601,500,1},},
			[6]={{803,4000,1},{804,200,1},{796,200,1},{778,25,1},{601,1000,1},{712,1,1},},
		},
	},
	[60]={
		[1]={{803,40,1},{601,20,1},{812,40,1},{1601,10,1},{1585,40,1},{762,4,1},},
		[2]={
			[1]={{803,200,1},},
			[2]={{803,400,1},{804,30,1},},
			[3]={{803,800,1},{804,60,1},{796,20,1},},
			[4]={{803,1200,1},{804,100,1},{796,30,1},{778,10,1},},
			[5]={{803,2500,1},{804,150,1},{796,80,1},{778,15,1},{601,500,1},},
			[6]={{803,4000,1},{804,200,1},{796,200,1},{778,25,1},{601,1000,1},{731,1,1},},
		},
	},
	[70]={
		[1]={{803,40,1},{1520,100,1},{812,40,1},{1601,10,1},{1585,40,1},{762,4,1},},
		[2]={
			[1]={{803,300,1},},
			[2]={{803,500,1},{812,300,1},},
			[3]={{803,1000,1},{812,500,1},{796,30,1},},
			[4]={{803,2000,1},{812,1000,1},{796,50,1},{778,20,1},},
			[5]={{803,3000,1},{812,2000,1},{796,100,1},{778,30,1},{601,500,1},},
			[6]={{803,5000,1},{812,4000,1},{796,300,1},{778,80,1},{601,1000,1},{764,1,1},},
		},
	},
	[80]={
		[1]={{803,40,1},{1520,100,1},{812,40,1},{1601,10,1},{1585,40,1},{762,4,1},},
		[2]={
			[1]={{803,300,1},},
			[2]={{803,500,1},{812,300,1},},
			[3]={{803,1000,1},{812,500,1},{796,30,1},},
			[4]={{803,2000,1},{812,1000,1},{796,50,1},{778,20,1},},
			[5]={{803,3000,1},{812,2000,1},{796,100,1},{778,30,1},{601,500,1},},
			[6]={{803,5000,1},{812,4000,1},{796,300,1},{778,80,1},{601,1000,1},{764,1,1},},
		},
	},
}





--���˰�������_(1�ֿ�����,2����Ԫ��,3�õ������,4��װ�콱���)
function jj_getpdata( sid )
	local pdata=GI_GetPlayerData( sid , 'jjin' , 30 )
	if pdata==nil then return end
	--[[
		[1]=111,--���ʼʱ��
		[2]=255,--Ͷ�ʷ���
		[3]=2,--ÿ���콱�ܴ���
		[4]=5,--����Ͷ���콱
		[5]=33,������ȡʱ����
		
	]]--
	return pdata
end
--������������	
local function jj_GetwData()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then
		return
	end
	if w_customdata.jijin == nil then
		w_customdata.jijin = {
			[1]={},--���ʼʱ��,�콱ʱ��,����ʱ��
			--worldlv=worldlv--�����������ȼ�
		}
	end
	return w_customdata.jijin
end
--�õ����콱����
local function jj_getindex( num )
	if num<5 then 
		return 1
	elseif num<10 then 
		return 2
	elseif num<20 then 
		return 3
	elseif num<30 then 
		return 4
	elseif num<40 then 
		return 5
	elseif num<=50 then 
		return 6
	end	
end
--�val=1����,val=2��ʼ
function jj_active(val,tBegin,tAward,tEnd)
	-- look('�val=1����,val=2����',1)
	-- look(val,1)
	-- look(tBegin,1)
	-- look(tAward,1)
	-- look(tEnd,1)
	local alldata=jj_GetwData()
	-- Log('Ѱ��11.txt',alldata)
	
	if val==2 then 
		
		if alldata[1]==nil or alldata[1][1]~=tBegin then 
			for i=1,10 do--��������
				alldata[i]=nil
			end
			local worldlv=rint(GetWorldLevel()/10)*10
			if worldlv<50 then
				worldlv=50
			end
			if  jj_conf[worldlv]==nil and jj_conf[70]~=nil then
				worldlv=70
			end
			alldata.worldlv=worldlv--������������
			-- look(worldlv,1)
		end
		alldata[1]={tBegin,tAward,tEnd}	--�ʱ��

		
	elseif val==1 then 
		for i=1,10 do--��������
			alldata[i]=nil
		end
	end

end

--����Ȩ���ж� --itype=1����,2ÿ��,3����,4ȡ��

local function jj_cango( sid,itype )
	local now=GetServerTime()
	local alldata=jj_GetwData()
	if alldata==nil then return end
	local pdata=jj_getpdata( sid )
	if pdata==nil then return end

	local tBegin,tAward,tEnd

	if alldata[1]==nil then 
		alldata[1]={}
	end
	tBegin=alldata[1][1] or 0
	tAward=alldata[1][2] or 0
	tEnd=alldata[1][3] or 0
	


	
	--�жϰ汾
	-- look('�жϰ汾',1)
	
	if tBegin >0 then--���»

			if pdata[1]==nil or pdata[1]~=tBegin then --�汾�Ų�һ��,������
				if pdata[2]==nil then 
					for i=3,5 do
						pdata[i]=nil
					end
					pdata[1]=tBegin
				else
					if itype~=4 then
						return
					end
				end
			end
	else--�޻
		if pdata[2]~=nil then --������
			for i=3,5 do
				pdata[i]=nil
			end
		
		end
	end
	
	-- look('�жϰ汾111',1)
	--�ж�Ȩ��
	if itype==1 then --itype=1����
		if (now < tBegin ) or (now>tAward ) then 
			
			return
		end
	elseif itype==2 then --itype=2ÿ��
		if (now < tAward ) or (now>tEnd ) then 
			-- look(os_date('%Y-%m-%d %H:%M:%S',now),1)
			-- look(os_date('%Y-%m-%d %H:%M:%S', tAward),1)
			-- look(os_date('%Y-%m-%d %H:%M:%S', tEnd),1)
		
			return
		end
	elseif itype==3 then --itype=3����
		if (now < tBegin ) or (now>tEnd ) then 
			return
		end
	elseif itype==4 then --itype=4ȡ��
		if (pdata[1] or 0)==tBegin then --�ڱ��λ����δ������ʱ��
			if (now < tEnd ) then 
				return
			end
		end
	end
	-- look(333,1)
	return true
end


--������� num����
function jj_touzi( sid,num )
	if not jj_cango( sid,1 ) then return end
	-- look('�������',1)


	local wdata=jj_GetwData()
	local btime=wdata[1][1]
	local begintime=os_date('%Y-%m-%d %H:%M:%S', btime)
	local endtime=os_date('%Y-%m-%d %H:%M:%S', GetServerTime())
	local pdata=jj_getpdata(sid)
	if pdata==nil then return end
	if pdata[2]~=nil and pdata[1] ~=btime then
		return 
	end
	local serverid = GetGroupID()
	-- look(serverid,1)
	-- look(begintime,1)
	-- look(endtime,1)
	local call = { dbtype = 2, sp = 'N_ActivityPayBuyPoint' , args = 5, [1] = sid,[2] = serverid,[3] = begintime,[4] = endtime,[5]=1}
	local callback = { callback = 'jj_cz_callback', args = 4, [1] = sid,[2]=num,[3] =btime,[4] = "?6" ,}
	DBRPC( call, callback )

	-- jj_cz_callback( sid,num,begintime,1000000 )
end

--����ص�
function jj_cz_callback( sid,num,begintime,value )
	-- look('����ص�',1)
	-- look(value,1)

	local canbuy=rint(value/1000)
	local pdata=jj_getpdata(sid)
	if pdata==nil then return end
	local nowbuy=pdata[2] or 0 --���ڹ������
	if (nowbuy+num)>50  or (canbuy-nowbuy)<num then return end
	if not CheckCost(sid , num*1000, 0 , 1,'�������') then
		return
	end
	pdata[2]=nowbuy+num
	pdata[1] =begintime

	SendLuaMsg( 0, { ids = JJ_cunru, num=pdata[2] }, 9 )
end



--itype=1��ȡÿ�ս���,itype=2��ȡ���ν���,indexΪ��ڼ���
function jj_getaward( sid,itype,index )
	-- look('1��ȡÿ�ս���',1)
	-- look(itype,1)
	-- look(index,1)
	if not jj_cango( sid,itype+1 ) then return end
	-- look(11,1)
	local pdata=jj_getpdata(sid)
	if pdata==nil then return end
	local nowbuy=pdata[2] or 0 --���ڹ������
	-- look(22,1)
	local alldata=jj_GetwData()
	if alldata==nil then return end
	if itype==1 then 
		
	
		local tAward=alldata[1][2] or 0

		local nowget=pdata[3] or 0--�����������
		-- local canget_all=10   --�����ܴ���
		local canget_all=GetDiffDayFromTime(tAward)+1--�����콱����
		local aconf=jj_conf[alldata.worldlv][1] --��������

		local pakagenum = isFullNum()
		if pakagenum < #aconf then
			TipCenter(GetStringMsg(14,#aconf))
			return
		end
		local canget=canget_all-nowget
		if canget<=0 then  --û����
			if pdata[5] ==nowbuy then return end
			for k,v in pairs(aconf) do
				GiveGoods(v[1],v[2]*1*(nowbuy-(pdata[5] or 0)),v[3],'����ÿ���콱')
			end
		else --�д���
			for k,v in pairs(aconf) do
				GiveGoods(v[1],v[2]*canget*nowbuy,v[3],'����ÿ���콱')
			end
		end


		pdata[3]=canget_all
		pdata[5]=nowbuy--��¼�˴��콱ʱ�������

	elseif itype==2 then 
		local nowget=pdata[4] or 0--�����������
		local canget_all=jj_getindex(nowbuy) --���쵵��
		if canget_all<index or index-nowget~=1 then return end

		local aconf=jj_conf[alldata.worldlv][2][index] --��������
		local pakagenum = isFullNum()
		if pakagenum < #aconf then
			TipCenter(GetStringMsg(14,#aconf))
			return
		end
		for k,v in pairs(aconf) do
			GiveGoods(v[1],v[2],v[3],'���𵵴��콱')
		end
		pdata[4]=index
	else
		return 
	end
	if itype==1 then 
		SendLuaMsg( 0, { ids = JJ_award, itype=itype,index=index,data=pdata }, 9 )
	else
		SendLuaMsg( 0, { ids = JJ_award, itype=itype,index=index }, 9 )
	end
end

--ȡ������Ԫ��
function jj_getyb_all( sid )
	if not jj_cango( sid,4 ) then return end
	local pdata=jj_getpdata(sid)
	if pdata==nil then return end
	local nowbuy=pdata[2] or 0 --���ڹ������
	if nowbuy<1 then return end

	DGiveP(nowbuy*1000,'ȡ������Ԫ��')
	pdata[2]=nil
	SendLuaMsg( 0, { ids = JJ_out }, 9 )
end

--ȡ����ȼ�
function jj_getworldlv(  )
	local alldata=jj_GetwData()
	-- look(alldata,1)
	if alldata==nil then return end
	RPC('jj_wl',alldata.worldlv)
end