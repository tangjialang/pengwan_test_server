--[[
	file:	appearance.lua
	desc: ʱװϵͳ
	author:	wk
	update:	2014-1-8
--]]
local SendLuaMsg = SendLuaMsg
local app_updata= msgh_s2c_def[3][26]

--ʱװ����,����id=[����,���α��,ʹ������}--0�·�1���-2���

--����3Ϊ������⼰��������С����
--[[
	ʮλ��λΪ�������Ԥ��
	��λ=1Ϊ������ʾ--������������ļ���
]]--



local appearance_conf={
	--�·� - ����ȼ�
	[2601]={1,1,30},
	[2602]={1,2,30},
	[2603]={1,3,30},
	[2604]={1,4,30},
	[2605]={1,5,30},
	[2606]={1,6,30},
	--��� --�������
	[2701]={2,1,2},
	[2703]={2,2,2},
	[2702]={2,3,2},
	[2704]={2,4,2},
	[2705]={2,5,2},
	[2706]={2,6,2},
	[2707]={2,7,2},
	[2708]={2,8,2},
	[2709]={2,9,2},
	[2710]={2,10,2},
	--��� --�������
	[2801]={3,1,2},
	[2802]={3,2,2},
	[2803]={3,3,2},
	[2804]={3,4,2},
	[2805]={3,5,2},
	[2806]={3,6,2},
	[2807]={3,7,2},
}

--ǿ������
local app_enhance_conf={
	[1]={780,3},--��Ҫid,����
	[2]={780,5},
	[3]={780,10},
	[4]={781,5},
	[5]={781,10},
	[6]={781,15},
	[7]={782,10},
	[8]={782,15},
	[9]={782,20},
	[10]={783,1},
}
--ǿ��ʯ�۸�
local goodsmoney={
	[780]=20,
	[781]=40,
	[782]=80,
}
--����--1����ʱװ����ֵ,����1��
local app_attconf_1={
	[1]={--�·�,1��ʱװ����ֵ,������Ҫ����2-10����,keyΪʱװλ��
		[1]={[1]=300,[3]=100,[8]=50,},
		[2]={[1]=300,[3]=100,[8]=50,},	
		[3]={[1]=1000,[3]=500,[8]=250,},
		[4]={[1]=1000,[3]=500,[8]=250,},
		[5]={[1]=800,[3]=300,[8]=150,},
		[6]={[1]=1000,[3]=500,[8]=250,},
	},
	[2]={
		[1]={[3]=500,[5]=250,[7]=250,},	
		[2]={[3]=1000,[5]=500,[7]=500,},	
		[3]={[3]=500,[5]=250,[7]=250,},			
		[4]={[3]=500,[5]=250,[7]=250,},		
		[5]={[3]=500,[5]=250,[7]=250,},	
		[6]={[3]=1000,[5]=500,[7]=500,},			
		[7]={[3]=500,[5]=250,[7]=250,},
		[8]={[3]=500,[5]=250,[7]=250,},
		[9]={[3]=500,[5]=250,[7]=250,},
		[10]={[3]=1000,[5]=500,[7]=500,},
	},
	[3]={
		[1]={[4]=1500,[6]=700,[9]=700,},	
		[2]={[4]=1500,[6]=700,[9]=700,},	
		[3]={[4]=1500,[6]=700,[9]=700,},	
		[4]={[4]=500,[6]=250,[9]=250,},	
		[5]={[4]=500,[6]=250,[9]=250,},
		[6]={[4]=500,[6]=250,[9]=250,},
		[7]={[4]=1500,[6]=700,[9]=700,},
	},
}
--����---2-11���̶�ֵ
local app_attconf_2={
	[1]={--�·�,�ۼӷ�ʽ,2-10���̶�,keyΪ�˼�������
		[2]={[1]=130,[3]=40,[8]=20},
		[3]={[1]=330,[3]=100,[8]=50},
		[4]={[1]=590,[3]=200,[8]=90},
		[5]={[1]=1110,[3]=360,[8]=170},
		[6]={[1]=1760,[3]=560,[8]=270},
		[7]={[1]=2540,[3]=800,[8]=390},
		[8]={[1]=3450,[3]=1100,[8]=530},
		[9]={[1]=4620,[3]=1460,[8]=710},
		[10]={[1]=5920,[3]=1860,[8]=910},
		[11]={[1]=7880,[3]=2360,[8]=1210},

	},
	[2]={		
		[2]={[3]=40,[5]=20,[7]=20},
		[3]={[3]=100,[5]=50,[7]=50},
		[4]={[3]=200,[5]=90,[7]=90},
		[5]={[3]=360,[5]=170,[7]=170},
		[6]={[3]=560,[5]=270,[7]=270},
		[7]={[3]=800,[5]=390,[7]=390},
		[8]={[3]=1100,[5]=530,[7]=530},
		[9]={[3]=1460,[5]=710,[7]=710},
		[10]={[3]=1860,[5]=910,[7]=910},
		[11]={[3]=2360,[5]=1210,[7]=1210},

	},
	[3]={
		[2]={[4]=40,[6]=20,[9]=20},
		[3]={[4]=100,[6]=50,[9]=50},
		[4]={[4]=200,[6]=90,[9]=90},
		[5]={[4]=360,[6]=170,[9]=170},
		[6]={[4]=560,[6]=270,[9]=270},
		[7]={[4]=800,[6]=390,[9]=390},
		[8]={[4]=1100,[6]=530,[9]=530},
		[9]={[4]=1460,[6]=710,[9]=710},
		[10]={[4]=1860,[6]=910,[9]=910},
		[11]={[4]=2360,[6]=1210,[9]=1210},
	},
}
------------------------------------------------------------------

--��������
local function app_getpdata( playerid )
	local aData=GI_GetPlayerData( playerid , 'appe' , 200 )
	if aData == nil then return end
		--[[
		if aData[1]==nil then
			aData[1]={},--�·� ----�Ա��Ϊkey,�ȼ�Ϊֵ
			aData[2]={},--���
			aData[3]={},--���
			use={[1]=1,[2]=3,[3]=5},--ʹ���е�ʱװ
		end
		]]--
	return aData
end
--����д�洢
function app_logout( playerid )
	local pdata=app_getpdata( playerid )
	if pdata==nil then return end
	return pdata.use
end
--��½���Դ���
function add_loginatt( playerid )
	local pdata=app_getpdata( playerid )
	if pdata==nil then return end
	local AttTable =GetRWData(1)
	local lv1,lvup
	for k,v in pairs(pdata) do--k������,vʱװ����
		if type(k)==type(0) and type(v)==type({}) then 
			for j,h in pairs(v) do--j��ʱװ���,h�ȼ�
				if type(j)==type(0) and type(h)==type(0) then 
					if app_attconf_1[k] and app_attconf_2[k] then
						lv1=app_attconf_1[k][j]--1������
						if lv1 then 
							for a,b in pairs(lv1) do
								AttTable[a]=(AttTable[a] or 0)+b
							end
						end
						if h>1 then 
							lvup=app_attconf_2[k][h]--��������
							for c,d in pairs(lvup) do
								AttTable[c]=(AttTable[c] or 0)+d
							end
						end
					end
				end
			end
		end
	end
	-- look('��½ʱװ����',1)
	-- look(AttTable,1)
	--PI_UpdateScriptAtt(playerid,ScriptAttType.shizhuang)
	return true
end
--��½ͬ��ʱװ
function app_login(playerid)
	local pdata=app_getpdata( playerid )
	if pdata==nil or pdata.use==nil then return end
	for k,v in pairs(pdata.use) do
		if type(k)==type(0) and type(v)==type(0) then 
			if v>0 then 
				CI_SetPlayerIcon(3,k-1,v)--3ʱװ,0-7�·�,�����
			end
		end
	end
end

--ǿ��.�õ�ʱװ��������
local function app_addatt( index, lv,num)
	-- look('ǿ��.�õ�ʱװ��������',1)
	local att_table={}
	if lv>=1 then--ǿ��
		for k,v in pairs(app_attconf_2[index][lv+1]) do
			if lv==1 then--2��
				att_table[k]=v
			else
				att_table[k]=v-app_attconf_2[index][lv][k]
			end
		end
	else --�õ�
		if app_attconf_1[index][num]==nil then return  end
		for k,v in pairs(app_attconf_1[index][num]) do
			att_table[k]=v
		end
	end
	 -- look(att_table,1)
	CI_UpdateScriptAtt(att_table,0,1,ScriptAttType.shizhuang-1)--�ۼ�����
end


--ʹ�õ��ߵõ�ʱװ
function app_getone( playerid,id )
	 -- look('ʹ�õ��ߵõ�ʱװ',1)
	 -- look(id,1)
	local pdata=app_getpdata( playerid )
	if pdata==nil then return end
	if appearance_conf[id]==nil  then 
		return 0
	end
	
	local index=appearance_conf[id][1]
	local num=appearance_conf[id][2]
	local limit=appearance_conf[id][3]
	if index==2 then --���
		local lv=sowar_getlv( playerid )
		-- look(playerid,1)
		-- look(lv,1)
		if lv<limit then 
			TipCenter(GetStringMsg(461))
			return 0
		end
	elseif index==3 then --���
		local lv=wing_get_lv(playerid)
		if lv<limit then 
			TipCenter(GetStringMsg(462))
			return 0
		end
	end
	if pdata[index]==nil then 
		pdata[index]={}
	end
	-- look(pdata,1)
	if pdata[index][num]~=nil then 
		TipCenter(GetStringMsg(463))
		return 0
	end
	pdata[index][num]=1
	-- look(pdata,1)
	
	SendLuaMsg(0,{ids=app_updata,index=index,num=num,lv=pdata[index][num]},9)
	return app_addatt( index, 0,num)
end
--ʹ��ʱװ
function app_use( playerid,data)
	 -- look('ʹ��ʱװ',1)
	local pdata=app_getpdata( playerid )
	if pdata==nil then return end
	local index,num
	-- look(data,1)
	-- look(pdata,1)
	for k,v in pairs(data) do
		if type(k)==type(0) and type(v)==type(0) then 
			index=k
			num=v
			if pdata[index]==nil then 
				 -- look(333,1)
				return
			end
			if num>0 then 
				if pdata[index][num]==nil then 
					 -- look(222,1)
					return 
				end  
			end
			CI_SetPlayerIcon(3,index-1,num)--3ʱװ,0-7�·�,�����
			if pdata.use==nil then 
				pdata.use={}
			end
			pdata.use[index]=num
			
		end
	end
	 -- look(111,1)
	AreaRPC(0,nil,nil,"app_use",CI_GetPlayerData(16),data)
end
--ǿ��ʱװ
function app_enhance( playerid ,index,num,buy,lastnum)
	-- look('ǿ��ʱװ',1)
	-- look(index,1)
	-- look(num,1)
	-- look(buy,1)
	-- look(lastnum,1)
	local pdata=app_getpdata( playerid )
	if pdata==nil then return end
	if pdata[index]==nil then 
		return
	end
	if pdata[index][num]==nil then 
		return 
	end  
	local lv=pdata[index][num]
	if lv>=11 then return end
	local needconf=app_enhance_conf[lv]
	local id=needconf[1]
	local neednum=needconf[2]

	if buy==0 then
		if 0 == CheckGoods(id,neednum,0,playerid,'ǿ��ʱװ') then
			-- look('ǿ��ʱװ1111',1)
			return
		end
	elseif buy==1 then
		if (lastnum or 0)>=1 and (lastnum or 0)<neednum then 
			if 0 == CheckGoods(id,lastnum,1,playerid,'ǿ��ʱװ') then
				-- look('ǿ��ʱװ1111',1)
				return
			end
			local needmoney=goodsmoney[id]*(neednum-lastnum)
			if not (CheckCost(playerid, needmoney,0,1,'ǿ��ʱװ')) then 
				return
			end
			if 0 == CheckGoods(id,lastnum,0,playerid,'ǿ��ʱװ') then
				-- look('ǿ��ʱװ1111',1)
				return
			end
			-- look('ǿ��ʱװ1111',1)
		else
			local needmoney=goodsmoney[id]*neednum
			if not (CheckCost(playerid, needmoney,0,1,'ǿ��ʱװ')) then 
				return
			end
		end
	else
		return
	end

	pdata[index][num]=lv+1
	-- look(111,1)

	-- local att_table={}
	-- for k,v in pairs(app_attconf_2[index][lv+1]) do
	-- 	if lv==1 then--2��
	-- 		att_table[k]=v
	-- 	else
	-- 		att_table[k]=v-app_attconf_2[index][lv][k]
	-- 	end
	-- end
	-- app_addatt( att_table )
	app_addatt( index, lv)


	SendLuaMsg(0,{ids=app_updata,index=index,num=num,lv=pdata[index][num]},9)
end


