--[[
file:	Limit_store.lua
desc:	�޹��̵�ϵͳ
author:	wk
update:	2013-1-24
refix:	done by wk
]]--
SetLimitstore_mark=SetLimitstore_mark or 1 --����������ʱִ��һ�α�ʶ

local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local storebuy	 = msgh_s2c_def[24][1]	
local look = look
local pairs=pairs
local type=type
local uv_Store_Conf=Store_List
local _remove=table.remove
local _insert=table.insert
local _random=math.random
local db_module = require('Script.cext.dbrpc')
local db_operationsactivity = db_module.db_operationsactivity
-------------------------------ÿ���޹�--------------------------------------------
-- local server_limitconf={ --id,num,price,ԭ��,������Ʒ
-- 	[1]={306,3,28888,50000,1},--1Ҫȫ������
-- 	[2]={697,1000,488,1000},
-- 	[3]={698,300,5488,7680},
-- 	}

--������ȼ����汾�Ŵ洢,����3�����,100,0,1
--100�����ıس�,1�����ĳ�һ��,ʣ�µ���0�����
--{id,�۸�,���ڼ۸�,-,����,�޹�����}
local LimitS=3--�޹��̵�3����Ʒ
local Limitstore_conf={ ---������ȼ�Ϊ����
	[40]={ ---Ĭ������,������ȼ�����40���Ҳ�������ʱ�����
		[100]={
			{702,3564,1988,10000,1},
			{701,594,468,10000,1},
			{797,150,88,10000,1},


			},
		[0]={
			
			},
		[1]={
			
			},
	},
	[45]={ ---Ĭ������,������ȼ�����40���Ҳ�������ʱ�����
		[100]={
			{702,3564,1988,10000,1},
			{701,594,468,10000,1},


			},
		[0]={
			{797,150,88,3000,1},
			{626,5,2,6000,200},
			{627,5,2,10000,200},
			},
		[1]={
			
			},
	},
	[50]={ ---Ĭ������,������ȼ�����40���Ҳ�������ʱ�����
		[100]={
			{1053,50,18,10000,20},

			},
		[0]={
			{797,150,88,3000,1},
			{626,5,2,6000,200},
			{627,5,2,10000,200},				
			},
		[1]={
			
			},
	},
	[55]={ ---Ĭ������,������ȼ�����40���Ҳ�������ʱ�����
		[100]={
			{1053,50,18,10000,25},
			{789,50,30,10000,5},
			},
		[0]={
			{626,5,2,3000,500},
			{627,5,2,6000,500},
			{771,150,80,10000,10},

			},
		[1]={
			
			},
	},
	[60]={ ---Ĭ������,������ȼ�����40���Ҳ�������ʱ�����
		[100]={
			{1053,50,18,10000,30},
			{789,50,30,10000,10},

			},
		[0]={
			{626,5,2,3000,500},
			{627,5,2,6000,500},
			{771,150,80,10000,10},
			
			},
		[1]={
			
			},
	},
	[65]={ ---Ĭ������,������ȼ�����40���Ҳ�������ʱ�����
		[100]={
			{1053,50,18,10000,30},
			{789,50,30,10000,15},

			},
		[0]={
			{626,5,2,3000,500},
			{627,5,2,6000,500},
			{771,150,80,10000,10},

			},
		[1]={
			
			},
	},
	[70]={ ---Ĭ������,������ȼ�����40���Ҳ�������ʱ�����
		[100]={
			{1053,50,18,10000,30},
			{789,50,30,10000,20},

			},
		[0]={
			{626,5,2,3000,500},
			{627,5,2,6000,500},
			{771,150,80,10000,10},
			
			},
		[1]={
			
			},
	},
	[75]={ ---Ĭ������,������ȼ�����40���Ҳ�������ʱ�����
		[100]={
			{1053,50,18,10000,30},
			{789,50,30,10000,20},

			},
		[0]={
			{626,5,2,3000,500},
			{627,5,2,6000,500},
			{771,150,80,10000,10},
			
			},
		[1]={
			
			},
	},
	[80]={ ---Ĭ������,������ȼ�����40���Ҳ�������ʱ�����
		[100]={
			{1053,50,18,10000,30},
			{789,50,30,10000,20},

			},
		[0]={
			{626,5,2,3000,500},
			{627,5,2,6000,500},
			{771,150,80,10000,10},
			
			},
		[1]={
			
			},
	},
	[85]={ ---Ĭ������,������ȼ�����40���Ҳ�������ʱ�����
		[100]={
			{1053,50,18,10000,30},
			{789,50,30,10000,20},

			},
		[0]={
			{626,5,2,3000,500},
			{627,5,2,6000,500},
			{771,150,80,10000,10},
			
			},
		[1]={
			
			},
	},
	[90]={ ---Ĭ������,������ȼ�����40���Ҳ�������ʱ�����
		[100]={
			{1053,50,18,10000,30},
			{789,50,30,10000,20},

			},
		[0]={
			{626,5,2,3000,500},
			{627,5,2,6000,500},
			{771,150,80,10000,10},
			
			},
		[1]={
			
			},
	},
	[95]={ ---Ĭ������,������ȼ�����40���Ҳ�������ʱ�����
		[100]={
			{1053,50,18,10000,30},
			{789,50,30,10000,20},

			},
		[0]={
			{626,5,2,3000,500},
			{627,5,2,6000,500},
			{771,150,80,10000,10},
			
			},
		[1]={
			
			},
	},
}

----����3���޹���Ʒ
local function DBCALLBACK_setLMstore(storeconf)
	local Limit_data=GetLimitstoreWorldData()
	if Limit_data==nil then 
		look("Limit_dataerror",1)
		return 
	end
	Limit_data.todaydata={}
	local limitdata=Limit_data.todaydata
	local tempstoreconf=storeconf--��ʱ�ֿ�����
	local num=LimitS
	if type(tempstoreconf[100])==type({}) and type(tempstoreconf[100][1])==type({}) then
		local num1=#tempstoreconf[100]
		if num1>LimitS then
			look("Limitnumbererror")
			return
		end
		for k,v in pairs (tempstoreconf[100]) do
			_insert(limitdata,v)
		end
		num=num-num1
	end
	if num>0 then
		if type(tempstoreconf[1])==type({}) and type(tempstoreconf[1][1])==type({}) then
			local num2=_random(1,10000)
			for k,v in pairs(tempstoreconf[1]) do
				if v[4] then 
					if num2<=v[4] then
						_insert(limitdata,v)
						num=num-1
						break
					end
				end
			end
		end
	end
	if num>0 then
		if num==1 then
			if  type(tempstoreconf[0])==type({}) and type(tempstoreconf[0][1])==type({}) then
				local num2=_random(1,10000)
				for k,v in pairs(tempstoreconf[0]) do
					if v[4] then 
						if num2<=v[4] then
							_insert(limitdata,v)
							break
						end
					end
				end
			end
		elseif num>1 then
			if type(tempstoreconf[0])==type({}) and  type(tempstoreconf[0][num])==type({}) then
				-- look("datalack")
				-- return
			-- end
				for i=1 ,num do
					local now
					local temp=0
					local num3=_random(1,10000)
					for k,v in pairs(tempstoreconf[0]) do
						if v[4] then 
							if num3<=v[4] then
								now=v
								_remove(tempstoreconf[0],k)
								temp=1
								break
							end
						end
					end
					if temp==0 then
						local endrand=_random(1,#(tempstoreconf[0]))
						now=tempstoreconf[0][endrand]
					end
					_insert(limitdata,now)
				end
			end
		end
	end
	--look(limitdata)
end



--���õ��ú�������3���޹���Ʒ
function SetLimitstore(itype)
	if itype==1 then
		if  SetLimitstore_mark==1 then
			SetLimitstore_mark=2
		else
			return
		end	
	end
	
	local worldlv=rint(GetWorldLevel()/5)*5
	-- local call = { dbtype = 1, sp = 'GetLimitstore' , args = 2,[1] =worldlv ,[2]=1}---����ͳһ�޸�[2]Ϊƽ̨��ʶ
	-- if call==nil then
	--	call= dbtype = 1, sp = 'GetLimitstore' , args = 2,[1] =1 ,[2]=1}
	--end
	-- local callback = { callback = 'DBCALLBACK_setLMstore', args = 1, [1] = "?2"}
	-- DBRPC( call, callback )	
	if worldlv<40 or Limitstore_conf[worldlv]==nil then
		worldlv=40
	end
	DBCALLBACK_setLMstore(Limitstore_conf[worldlv])
end
--�����޹��̵�������������ÿ��5����������
function GetLimitstoreWorldData()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then
		return
	end
	if w_customdata.LimitData == nil then
		w_customdata.LimitData = {
		--todaydata={},
		}
	end
	return w_customdata.LimitData
end
--��ʼ���̳�+�޹��̵� t����ʶ
function limit_store(sid,t,ver)

	local one_list=GetLimitstoreWorldData()--ȡ�����޹�3����Ʒ��
	if one_list==nil  then 
		return 
	end
	if one_list.todaydata==nil then 
		one_list.todaydata={}
	end
	local limitdata=one_list.todaydata
	if limitdata[1]==nil then 
		SetLimitstore()
	end
	local storeConf = uv_Store_Conf[2] 
	if  ver~=storeConf.ver then
		SendLuaMsg(0,{ids=storebuy,storeid=2,storeconf=storeConf,limitstore=one_list.todaydata,t = t,ver=ver},9)
	else	
		SendLuaMsg(0,{ids=storebuy,storeid=2,limitstore=one_list.todaydata,t = t,ver=ver},9)
	end
end

----------------------------------ȫ���޹�--------------------------------------------

-- --������
-- local function Getserver_limitData()
-- 	local w_customdata = GetWorldCustomDB()
-- 	if w_customdata == nil then
-- 		return
-- 	end
-- 	if w_customdata.s_limit == nil then
-- 		w_customdata.s_limit = {
-- 		--[[
-- 			[1]=1,--��������-Ϭţ,3   306
-- 			[2]=2,--���ǵ���� 1000   697
-- 			[3]=3,--4����ʯ�� 300     698
-- 		]]--
-- 		}
-- 	end
-- 	return w_customdata.s_limit
-- end

-- --�鿴
-- function server_limitlook()
-- 	local wdata=Getserver_limitData()
-- 	if wdata==nil then return end
-- 	RPC('server_limit_l',wdata[1],wdata[2],wdata[3])
-- end

-- --����
-- function server_limitbuy(sid,itype)
-- 	if  itype<1 or itype>#server_limitconf then return end

-- 	local wdata=Getserver_limitData()
-- 	if wdata==nil then return end
-- 	local wconf=server_limitconf[itype]
-- 	if  (wdata[itype]  or 0)>=wconf[2] then 
-- 		TipCenter(GetStringMsg(453))
-- 		return 
-- 	end

-- 	local pakagenum = isFullNum()
-- 	if pakagenum < 1 then
-- 		TipCenter(GetStringMsg(14,1))
-- 		return
-- 	end

-- 	if not CheckCost( sid , wconf[3] , 1 , 1, "7���޹�") then
-- 		return
-- 	end

-- 	GiveGoods(wconf[1],1,1,'7���޹�')
-- 	CheckCost( sid , wconf[3] , 0 , 1, "7���޹�")
-- 	wdata[itype]=(wdata[itype] or 0)+1
-- 	RPC('server_limit_s',itype,wdata[itype])
-- 	if wconf[4] and wconf[4]==1 then
-- 		BroadcastRPC('server_limit',wconf[1],CI_GetPlayerData(5))
-- 		db_operationsactivity(sid,'7���޹�','����Ϭţ')
-- 	end
-- end

-- --GM�������
-- function server_clcall( )
-- 	local wdata=Getserver_limitData()
-- 	wdata[1]=nil
-- 	wdata[2]=nil
-- 	wdata[3]=nil
-- end
