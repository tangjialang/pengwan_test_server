--[[
file:	store_func.lua
desc:	�̳�ϵͳ
author:	wk
update:	2013-1-21
refix:	done by wk
]]--
--[[
������ʶ����storeid��
[1]��ͨ�̵� [2]�̳�(��������) [3]�̳���ʱ���۴��� [4]�����̵� [5]���ػ����̵� [6]ͨ������̵� 
[7]����̵� (��Ʒ�ܰ��ȼ�����) [8]���Ի��� 
[9]��ְ ����ְ���ƣ� 
[10]װ�� ����ҵȼ����ƣ� 
[11]��԰���� ��ɽׯ�ȼ����ƣ� 
[12] ɽׯװ��Ʒ�̵�
[101] �����̵������̵�]]--
local look = look
local TP_FUNC = type( function() end)
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local storeend	 = msgh_s2c_def[24][2]	
local storenum	 = msgh_s2c_def[24][3]	
local quick_buy	 = msgh_s2c_def[24][4]	
local f_shop	 = msgh_s2c_def[24][5]	
local w_shop	 = msgh_s2c_def[24][7]	
local world_xg	 =msgh_s2c_def[24][8]	
local isFullNum=isFullNum
local pairs,tostring=pairs,tostring
local type=type
local uv_Store_Conf=Store_List
local GiveGoods,GiveGoodsBatch=GiveGoods,GiveGoodsBatch
local CheckCost=CheckCost
local AddPlayerPoints=AddPlayerPoints
local Garniture_buy=Garniture_buy
local TipCenter,GetStringMsg=TipCenter,GetStringMsg
local __G=_G
local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond

local quickbuyconf=quickbuylist--��ݹ����
local storeMailConf=MailConfig.storeMail
-----------------------------�����޹�����------------------

--�̵��޹�������
local function get_fshopdata(sid )
	local pdata=GI_GetPlayerData( sid , 'fshop' , 400 )
	if pdata==nil then return end
	--[[
	[1]={--����޹�
		[517]=3,id517����3��
		}
	[2]={--���ս�޹�
		[517]=3,id517����3��
		}
	[3]={--Ѱ���һ�ȯ�޹�
		[517]=3,id517����3��
		}
	[4]={--��λ�������޹�  itype=6
		[517]=3,id517����3��
		}	
	[5]={--�̳�ÿ���޹� itype=7
		[517]=3,id517����3��
		}	
	[6]={--�������ÿ���޹� itype=8
		[517]=3,id517����3��
		}		
	tz={---Ͷ���޹�,Ͷ�ʽ������������
		[1]={--Ͷ���޹�1
			[5]=3,����5����3��
		}
		[2]={--Ͷ���޹�2
			[5]=3,����5����3��
			}
		}
	]]
	return pdata
end
--�̵��޹�����
function fshop_reset( sid )
	local fdata=get_fshopdata(sid )
	if fdata==nil then return end
	for i ,j in pairs (fdata) do
		if type(i)==type(0) and type(j)==type({}) then 
			for k,v in pairs(j) do
				if type(k)==type(0) and type(v)==type(0) then 
					j[k]=nil
				end
			end
		end
	end
	local svrTime = GetServerOpenTime() or 0 --����ʱ��
	if GetServerTime()-svrTime>15*24*3600 then---����15���������
		fdata.tz=nil
	end
	


	SendLuaMsg(0,{ids=storeend,succ=14},9)
end


-----------------------------�����޹�����------------------
--�����޹�������
local function Getserver_ltData()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then
		return
	end
	if w_customdata.st_li == nil then
		w_customdata.st_li = {
		--[[
			[1]={id=333,416=666},--����2���޹�
			
		]]--
		}
	end
	return w_customdata.st_li
end

---ǰ̨���������޹�����
function getworld_lidata( itype )
	local wdata=Getserver_ltData()
	if wdata==nil then return end
	SendLuaMsg(0,{ids=world_xg,itype=itype,data=wdata[itype]},9)
end
----------------------------�����̵깺����------------------
----------------------------�����̵깺����------------------
----------------------------�����̵깺����------------------
----------------------------�����̵깺����------------------
local call_storefunc={
	--1��ͨ�̵깺��
	[1]= function (sid,tag,index,num,itemid)
		local storeConf = uv_Store_Conf[1] 
		local t = storeConf[tag][index]--�õ���Ҫ������Ʒ��С��
		local id=t[1]--����id

		local pk=1
		if tag==1 then 
			pk=((GetPlayerPoints(sid,9) or 0)+100)/100
			if pk>5 then 
				pk=5
			end
		end
		local need =rint( t[2]*num*pk)

		--local need = t[2]*num	
		if id==nil or need==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		if not CheckCost( sid , need , 1 , 3, "��ͨ�̵�") then
			SendLuaMsg(0,{ids=storeend,succ=2},9)
			return
		end
		GiveGoods(id,num,1,'��ͨ�̵�')
		CheckCost( sid , need , 0 , 3, "��ͨ�̵�")
		return true
	end,

		
		
	--2�̳ǹ���--���Դ���
	[2]= function (sid,tag,index,num,itemid,name)
		if name ~= nil then	-- �����ѹ��� ��̨��ʱ���ж��Ƿ��Ǻ���
			local o_sid = GetPlayer(name,0)
			if o_sid==nil then
				SendLuaMsg(0,{ids=storeend,succ=12},9)
				return
			end
		end
		local storeConf = uv_Store_Conf[2] 
		local t = storeConf[tag][index]--�õ���Ҫ������Ʒ��С��
		local id=t[1]--����id
		local itype=t[3]--��������
		local need = t[2]*num	
		if id==nil or need==nil then  return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		local info="�̳�"
		if name then 
			info=info.."_����_"..name
		end
		if itype==2 then --Ԫ������,��Ϊ�����˹���
			if not CheckCost( sid , need , 1 , 1, info) then
				SendLuaMsg(0,{ids=storeend,succ=1},9)
				return
			end
			if name then 
				local AwardList={[3]={{id,num,0},}}
				SendSystemMail(name,storeMailConf,1,2,CI_GetPlayerData(5),AwardList)	-- �����iType���ö�Ӧ�ʼ����
			else
				GiveGoodsBatch( {{id,num,0},},"�̳ǹ���")
			end


			CheckCost( sid , need , 0 , 1, info,id,num)
		elseif itype==5 then --��Ԫ������
			local now=GetPlayerPoints(sid,3)
			if now==nil then  return  end 
			if now>=need then
				GiveGoods(id,num,1,'��Ԫ������')
				AddPlayerPoints( sid , 3 , -need,nil,'�̳�',true )-----------
			else
				SendLuaMsg(0,{ids=storeend,succ=8},9)
				return
			end
		end
		return true
	end,
	--3�޹��̵깺��
	[3]= function (sid,tag,index,num,itemid)
		local one_list=GetLimitstoreWorldData()--ȡ�����޹�3����Ʒ��
		if one_list==nil then return end
		local limitdata=one_list.todaydata
		local id=limitdata[index][1]--����id
		if id ~=itemid then
			look('itemiderror')
			return
		end
		local need = limitdata[index][3]*num
		if not CheckCost( sid , need , 1 , 1, "�̳�") then
			--TipCenter("Ԫ������")
			SendLuaMsg(0,{ids=storeend,succ=1},9)
			return
		end

		--�޹�
		local maxnum=limitdata[index][5] or 1
		local fdata=get_fshopdata(sid )
		if fdata==nil then return end
		if fdata[5]==nil then 
			fdata[5]={}
		end
		local nownum=fdata[5][id] or 0
		if nownum>=maxnum or num> maxnum-nownum then 
			SendLuaMsg(0,{ids=storeend,succ=4},9)
			return
		end
		fdata[5][id]=nownum+num	
		SendLuaMsg(0,{ids=f_shop,index=id,num=fdata[5][id],itype=7},9)

		CheckCost( sid , need , 0 , 1, "�޹��̳�",id,num)
		GiveGoods(id,num,1,'3�޹��̵깺��')

		-- if  CheckTimes(sid,index+6,num,-1) then
		-- 	GiveGoods(id,num,1,'3�޹��̵깺��')
		-- 	CheckCost( sid , need , 0 , 1, "�޹��̳�",id,num)
		-- else
		-- 	SendLuaMsg(0,{ids=storeend,succ=4},9)
		-- 	return
		-- end
		return true
	end,
	--5�����̵���ֶһ�	
	[5]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[5][tag][index]
		local id=t[1]
		local need=t[2]*num
		if id==nil or need==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		local nowscore=GetPlayerPoints( sid , 5 )--==========����ӣ��õ����ڻ���===============
		if nowscore==nil then return end
		if nowscore<need then
			look("Store5scoreerror")
			SendLuaMsg(0,{ids=storeend,succ=5},9)
			return
		end
		GiveGoods(id,num,1,'5�����̵���ֶһ�')
		AddPlayerPoints( sid , 5 , -need ,nil,'�̳�',true)
		return true
	end,
	--6ͨ����ֶһ�	
	[6]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[6][tag][index]
		local id=t[1]
		local need=t[2]
		if id==nil or need==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		yy_exchange(sid,id,need)
		
	end,
	--7����̵�
	[7]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[7][tag][index]
		local id=t[1]
		local need=t[2]*num
		local needlv=t[4]--������ȼ�

		if id==nil or need==nil  or needlv==nil then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		local fid = CI_GetPlayerData(23)
		if fid == nil or fid == 0 then
			return --��᲻����
		end
		local nowlv=CI_GetFactionInfo(nil,5)--ȡ����̵�ȼ�
		if nowlv<needlv then
			SendLuaMsg(0,{ids=storeend,succ=7},9)
			return
		end
		local nowbg=GetPlayerPoints(sid,4)--ȡ���ڰﹱ
		if nowbg<need then
			
			SendLuaMsg(0,{ids=storeend,succ=11},9)
			return
		end

		local maxnum=t[5] or 1000 --�޹�����
		local fdata=get_fshopdata(sid )
		if fdata==nil then return end
		if fdata[1]==nil then 
			fdata[1]={}
		end
		local nownum=fdata[1][id] or 0
		if nownum>=maxnum or num> maxnum-nownum then 
			return
		end

		fdata[1][id]=nownum+num	
		GiveGoods(id,num,1,'����̵�')
		AddPlayerPoints( sid , 4 , -need,nil,'����̵�' ,true)--�۰ﹱ
		SendLuaMsg(0,{ids=f_shop,index=id,num=fdata[1][id],itype=1},9)
		return true
	end	,
	--8���Ի��ֶһ�	
	[8]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[8][tag][index]
		local id=t[1]
		local need=t[2]*num
		if id==nil or need==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		local pdata =  GI_GetPlayerData(sid,'zm',32)
	--[1] �������� 
	--[2] ���� 
		local nowcore=pdata[2]
		if nowcore<need then
			SendLuaMsg(0,{ids=storeend,succ=5},9)
			return
		end

		pdata[2] = nowcore-need
		RPC('ZM_update',pdata[2])
		GiveGoods(id,num,1,'8���Ի��ֶһ�')	
		return true
	end,
	--9��ְ�̵�
	[9]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[9][tag][index]
		local id=t[1]
		local need=t[2]*num
		local needlv=t[4]--�����ְ�ȼ�
		local needitem=uv_Store_Conf[9].needitem[1]
		if id==nil or need==nil or needlv==nil or needitem==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		local nowlv=GetPos(GetPlayerPoints( sid , 6 )) --���ڹ�ְ�ȼ�===============================�����
		if nowlv<needlv then 
			SendLuaMsg(0,{ids=storeend,succ=6},9)
			return
		end
		if not (CheckGoods(needitem, need,0,sid,'9��ְ�̵�') == 1) then
			--look("needitemerror=="..needitem)
			--look("need=="..need)
			SendLuaMsg(0,{ids=storeend,succ=9},9)
			return 
		end
		GiveGoods(id,num,1,'��ְ�̵�')	
		return true
	end,
	--10��Ʒ�̵�
	[10]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[10][tag][index]
		local id=t[1]
		local need=t[2]*num
		local needlv=t[4]--��������ȼ�
		local needitem=uv_Store_Conf[9].needitem[1]
		if id==nil or need==nil or needlv==nil or needitem==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		local nowlv=CI_GetPlayerData(1)--��������ȼ�
		if nowlv<needlv then 
			SendLuaMsg(0,{ids=storeend,succ=3},9)
			return
		end
		if not (CheckGoods(needitem, need,0,sid,'10��Ʒ�̵�') == 1) then
			SendLuaMsg(0,{ids=storeend,succ=9},9)
			return 
		end
		GiveGoods(id,num,1,'��Ʒ�̵�')	
		-- look("�һ��ɹ�")
		return true
	end,
	--11��԰�����̵�
	[11]= function (sid,tag,index,num,itemid)

		local t=uv_Store_Conf[11][tag][index]
		local id=t[1]
		local need=t[2]*num
		local needlv=t[4]--��������ȼ�
		if id==nil or need==nil or needlv==nil  then  return end
		if id~=itemid then
	
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		--���ڼ�԰�ȼ�
		local pManorData = GetManorData_Interf(sid)
		if pManorData == nil then  return end
		local nowlv = pManorData.mLv or 1

		if nowlv<needlv then 
			SendLuaMsg(0,{ids=storeend,succ=3},9)

			return
		end	
		if not CheckCost( sid , need , 1 , 3) then
			SendLuaMsg(0,{ids=storeend,succ=2},9)

			return
		end
		GiveGoods(id,num,1,'��԰����')
		CheckCost( sid , need , 0 , 3, "��԰����")
		return true
		
	end,
	--12ɽׯװ���̵�--
	[12]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[12][tag][index]
		local id=t[1]
		local need=t[2]
		local addexp=t[4]--��������
		if id==nil or need==nil or addexp==nil  then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		Garniture_buy(sid,tag,index,num,itemid)
		return true
	end,
	--13����ս�̵�
	[13]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[13][tag][index]
		local id=t[1]
		local need=t[2]*num
		

		if id==nil or need==nil  then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end

		local fid = CI_GetPlayerData(23)
		if fid == nil or fid == 0 then
			return --��᲻����
		end
		-- local firstfid=1
		-- if fid~=firstfid then ---�Ƕ��ս��һ��

		-- 	return 
		-- end
		local itype=t[3]--��������
		if itype==2 then --ͭ��
			if not CheckCost( sid , need , 1 , 3, "13����ս�̵�") then
				SendLuaMsg(0,{ids=storeend,succ=2},9)
				return
			end
		elseif itype==1 then --Ԫ��
			if not CheckCost( sid , need , 1 , 1, "13����ս�̵�") then
				SendLuaMsg(0,{ids=storeend,succ=1},9)
				return
			end
		else
			return
		end
		
		
		local maxnum=t[5] or 1000 --�޹�����
		local fdata=get_fshopdata(sid )
		if fdata==nil then return end
		if fdata[2]==nil then 
			fdata[2]={}
		end
		local nownum=fdata[2][id] or 0
		if nownum>=maxnum or num> maxnum-nownum then 
			return
		end

		fdata[2][id]=nownum+num	

		if itype==2 then --ͭ��
			CheckCost( sid , need , 0 , 3, "13����ս�̵�")
		elseif itype==1 then --Ԫ��
			CheckCost( sid , need , 0 , 1, "13����ս�̵�")
		else
			return
		end

		GiveGoods(id,num,1,'13����ս�̵�')
		
		SendLuaMsg(0,{ids=f_shop,index=id,num=fdata[2][id],itype=2},9)
		return true
	end	,
	--14Ѱ�������̵�
	[14]= function (sid,tag,index,num,itemid)
		look('14Ѱ�������̵�')
		look(tag)
		look(index)
		look(itemid)
		local t=uv_Store_Conf[14][tag][index]
		local id=t[1]
		local need=t[2]*num
		

		if id==nil or need==nil  then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			look(333)
			return
		end
		local pdata=fsb_getpdata( sid )
		if pdata==nil then look(222) return end
		if (pdata[10] or 0)<need then 
			look(111)
			return
		end
		
		pdata[10]=pdata[10]-need

		GiveGoods(id,num,1,'15Ѱ���һ�ȯ�̵�')
		return true,need
	end	,
	--15Ѱ���һ�ȯ�̵�
	[15]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[15][tag][index]
		local id=t[1]
		local need=t[2]*num
		

		if id==nil or need==nil  then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end

		local needitem=uv_Store_Conf[15].needitem[1]
		if not (CheckGoods(needitem, need,1,sid,'15Ѱ���һ�ȯ�̵�') == 1) then
			SendLuaMsg(0,{ids=storeend,succ=9},9)
			return 
		end

		local maxnum=t[4] --�޹�����
		if maxnum then
			local fdata=get_fshopdata(sid )
			if fdata==nil then return end
			if fdata[3]==nil then 
				fdata[3]={}
			end
			local nownum=fdata[3][id] or 0
			if nownum>=maxnum or num> maxnum-nownum then 
				return
			end
			fdata[3][id]=nownum+num	
			CheckGoods(needitem, need,0,sid,'15Ѱ���һ�ȯ�̵�')
			SendLuaMsg(0,{ids=f_shop,index=id,num=fdata[3][id],itype=3},9)
		else
			CheckGoods(needitem, need,0,sid,'15Ѱ���һ�ȯ�̵�')
		end
		
		GiveGoods(id,num,1,'15Ѱ���һ�ȯ�̵�')
		return true,need
	end	,
	--16ȫ���޹��̵�
	[16]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[16][tag][index]
		local id=t[1]
		local need=t[2]*num
		if id==nil or need==nil  then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end

		if not CheckCost( sid , need, 1 , 1, "16ȫ���޹��̵�") then
			return
		end
		local maxnum=t[4] --�޹�����
	
		local sdata=Getserver_ltData()
		if sdata==nil then return end
		if sdata[1]==nil then 
			sdata[1]={}
		end
		local nownum=sdata[1][id] or 0
		if nownum>=maxnum or num> maxnum-nownum then 
			SendLuaMsg(0,{ids=storeend,succ=15},9)
			return
		end
		sdata[1][id]=nownum+num
		if not CheckCost( sid , need, 0 , 1, "16ȫ���޹��̵�") then
			return
		end
		SendLuaMsg(0,{ids=w_shop,index=id,num=sdata[1][id],itype=1},9)
		GiveGoods(id,num,1,'16ȫ���޹��̵�')
		return true,need
	end	,
	--17Ͷ���޹��̵�
	[17]= function (sid,tag,index,num,itemid)

		local svrTime = GetServerOpenTime() or 0 --����ʱ��
		if GetServerTime()-svrTime>15*24*3600 then return end

		local t=uv_Store_Conf[17][tag][index]
		local id=t[1]
		local need=t[2]*num
		look(111111,1)
		if id==nil or need==nil  then  return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			look(123,1)
			return
		end
		look(222,1)
		if not CheckCost( sid , need, 1 , 1, "17Ͷ���޹��̵�") then
			look(78,1)
			return
		end

		if t[6] then ---�ȼ�����
			if CI_GetPlayerData(1)<t[6] then 
				look(555,1)
				return
			end
		end

		if t[7] and t[7] >0 then --vip�ȼ�����
			local vtype = GI_GetVIPType( sid ) or 0
			if vtype < 2 then
				return
			end
			local vip=GI_GetVIPLevel( sid ) or 0
			if vip<t[7] then 
				look(444,1)
				return
			end
		end


		local maxnum=t[4] --�޹�����
		
		local fdata=get_fshopdata(sid )
		if fdata==nil then return end
		if fdata.tz==nil then 
			fdata.tz={}
		end

		local sdata=fdata.tz
		if sdata==nil then return end
		if sdata[1]==nil then 
			sdata[1]={}
		end
		local nownum=sdata[1][index] or 0
		if nownum>=maxnum or num> maxnum-nownum then 
			SendLuaMsg(0,{ids=storeend,succ=15},9)
			look(644,1)
			return
		end
		sdata[1][index]=nownum+num
		if not CheckCost( sid , need, 0 , 1, "17Ͷ���޹��̵�") then
			look(666,1)
			return
		end
		look('����ɹ�',1)
		SendLuaMsg(0,{ids=f_shop,index=index,num=sdata[1][index],itype=4},9)
		local getnum=t[8] or 1
		GiveGoods(id,num*getnum,1,'17Ͷ���޹��̵�')
		return true,need
	end	,

	--18Ͷ���޹��̵�2
	[18]= function (sid,tag,index,num,itemid)
		local svrTime = GetServerOpenTime() or 0 --����ʱ��
		if GetServerTime()-svrTime>15*24*3600 then return end


		local t=uv_Store_Conf[18][tag][index]
		local id=t[1]
		local need=t[2]*num
		-- look(111,1)
		if id==nil or need==nil  then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			-- look(222,1)
			return
		end
		if not CheckCost( sid , need, 1 , 1, "18Ͷ���޹��̵�") then
			-- look(3333,1)
			return
		end
		if t[6] then ---�ȼ�����
			if CI_GetPlayerData(1)<t[6] then 
				-- look(33443,1)
				return
			end
		end

		if t[7] and t[7] >0 then --vip�ȼ�����
			local vtype = GI_GetVIPType( sid ) or 0
			if vtype < 2 then
				return
			end
			local vip=GI_GetVIPLevel( sid ) or 0
			if vip<t[7] then 
				-- look(311,1)
				return
			end
		end


		local maxnum=t[4] --�޹�����
		
		local fdata=get_fshopdata(sid )
		if fdata==nil then return end
		if fdata.tz==nil then 
			fdata.tz={}
		end
		-- look(8888,1)
		local sdata=fdata.tz
		if sdata==nil then  return end
		if sdata[2]==nil then 
			sdata[2]={}
		end
		local nownum=sdata[2][index] or 0
		if nownum>=maxnum or num> maxnum-nownum then 
			-- look(8666,1)
			SendLuaMsg(0,{ids=storeend,succ=15},9)
			return
		end
		sdata[2][index]=nownum+num
		-- look(988,1)
		if not CheckCost( sid , need, 0 , 1, "18Ͷ���޹��̵�") then
			return
		end
		-- look(999,1)
		SendLuaMsg(0,{ids=f_shop,index=index,num=sdata[2][index],itype=5},9)
		local getnum=t[8] or 1
		GiveGoods(id,num*getnum,1,'18Ͷ���޹��̵�')
		return true,need
	end	,
	--19ϡ���̵�
	[19]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[19][tag][index]
		local id=t[1]
		local need=t[2]*num
		local needitem=uv_Store_Conf[19].needitem[1]
		if id==nil or need==nil  or needitem==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		if not (CheckGoods(needitem, need,0,sid,'19ϡ���̵�') == 1) then
			SendLuaMsg(0,{ids=storeend,succ=9},9)
			return 
		end
		GiveGoods(id,num,1,'19ϡ���̵�')	
		return true
	end,
	--20��λ�������һ�	
	[20]= function (sid,tag,index,num,itemid)
		if IsSpanServer() then return end
		local t=uv_Store_Conf[20][tag][index]
		local id=t[1]
		local need=t[2]*num
		if id==nil or need==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		local nowscore=GetPlayerPoints( sid , 10 )--==========����ӣ��õ����ڻ���===============
		if nowscore==nil then return end
		if nowscore<need then
			look("Store5scoreerror")
			SendLuaMsg(0,{ids=storeend,succ=5},9)
			return
		end

		local maxnum=t[4]  --�޹�����
		if maxnum then
			local fdata=get_fshopdata(sid )
			if fdata==nil then return end
			if fdata[4]==nil then 
				fdata[4]={}
			end
			local nownum=fdata[4][id] or 0
			if nownum>=maxnum or num> maxnum-nownum then 
				return
			end
			fdata[4][id]=nownum+num	
			SendLuaMsg(0,{ids=f_shop,index=id,num=fdata[4][id],itype=6},9)
		end

		AddPlayerPoints( sid , 10 , -need ,nil,'20�����̵���ֶһ�',true)
		GiveGoods(id,num,1,'20�����̵���ֶһ�')
		return true
	end,
	--21��������޹��̵�
	[21]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[21][tag][index]
		local id=t[1]
		local need=t[2]*num
		-- look(111,1)
		if id==nil or need==nil  then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			-- look(222,1)
			return
		end

		local nowscore=GetPlayerPoints( sid , 13 )--==========����ӣ��õ����ڻ���===============
		if nowscore==nil then return end
		if nowscore<need then
			look("Store5scoreerror")
			SendLuaMsg(0,{ids=storeend,succ=5},9)
			return
		end

		local maxnum=t[4]  --�޹�����
		if maxnum then
			local fdata=get_fshopdata(sid )
			if fdata==nil then return end
			if fdata[6]==nil then 
				fdata[6]={}
			end
			local nownum=fdata[6][id] or 0
			if nownum>=maxnum or num> maxnum-nownum then 
				return
			end
			fdata[6][id]=nownum+num	
			SendLuaMsg(0,{ids=f_shop,index=id,num=fdata[6][id],itype=8},9)
		end

		AddPlayerPoints( sid , 13 , -need ,nil,'21��������޹��̵�',true)
		GiveGoods(id,num,1,'21��������޹��̵�')
		return true
	end	,
	--22�ϻ������ֶһ�
	[22]= function (sid,tag,index,num,itemid)
		look('14Ѱ�������̵�')
		look(tag)
		look(index)
		look(itemid)
		local t=uv_Store_Conf[22][tag][index]
		local id=t[1]
		local need=t[2]*num
		

		if id==nil or need==nil  then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			look(333)
			return
		end
		local score=lhj_get_score(sid) or 0
		if score<need then 
			look(111)
			return
		end
		
		if not lhj_cost_score(sid,need) then 
			return
		end
		GiveGoods(id,num,1,'22�ϻ������ֶһ�')
		return true,need
	end	,
	--360ƽ̨�İ����_���ػ�
	[23]= function (sid,tag,index,num,itemid)

		local svrTime = GetServerOpenTime() or 0 --����ʱ��
		if GetServerTime()-svrTime>15*24*3600 then return end

		local plat=__G.__plat
		if plat==101 then --360
			local sec	= GetTimeToSecond(2014,4,11,10,00,00) 
			-- local svrTime = GetServerOpenTime() or 0 --����ʱ��
			if svrTime<sec then
				return
			end
		end
		
		local t=uv_Store_Conf[23][tag][index]
		local id=t[1]
		local need=t[2]*num
		
		if id==nil or need==nil  then  return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
		
			return
		end
		local itype=t[3]--��������
		if itype==2 then --Ԫ������
			if not CheckCost( sid , need, 1 , 1, "23�̵�") then
				return
			end
		elseif itype==5 then 
			local now=GetPlayerPoints(sid,3)
            if now==nil then  return  end 
            if now<need then
            	return
            end
        end

		if t[6] then ---�ȼ�����
			if CI_GetPlayerData(1)<t[6] then 
				
				return
			end
		end

		if t[7] and t[7] >0 then --vip�ȼ�����
			local vtype = GI_GetVIPType( sid ) or 0
			if vtype < 2 then
				return
			end
			local vip=GI_GetVIPLevel( sid ) or 0
			if vip<t[7] then 
				
				return
			end
		end


		local maxnum=t[4] --�޹�����
		
		local fdata=get_fshopdata(sid )
		if fdata==nil then return end
		if fdata.tz==nil then 
			fdata.tz={}
		end

		local sdata=fdata.tz
		if sdata==nil then return end
		if sdata[1]==nil then 
			sdata[1]={}
		end
		local nownum=sdata[1][index] or 0
		if nownum>=maxnum or num> maxnum-nownum then 
			SendLuaMsg(0,{ids=storeend,succ=15},9)
			-- look(644,1)
			return
		end
		sdata[1][index]=nownum+num
		if itype==2 then --Ԫ������
			if not CheckCost( sid , need, 0 , 1, "23�̵�") then
				-- look(666,1)
				return
			end
		elseif itype==5 then 
			 AddPlayerPoints( sid , 3 , -need,nil,'23�̵�',true )
		end
		-- look('����ɹ�',1)
		SendLuaMsg(0,{ids=f_shop,index=index,num=sdata[1][index],itype=4},9)
		local getnum=t[8] or 1
		GiveGoods(id,num*getnum,1,'23Ͷ���޹��̵�')
		return true,need
	end	,

	--360ƽ̨�İ���
	[24]= function (sid,tag,index,num,itemid)
		local svrTime = GetServerOpenTime() or 0 --����ʱ��
		if GetServerTime()-svrTime>15*24*3600 then return end

		local plat=__G.__plat
		if plat==101 then --360
			local sec	= GetTimeToSecond(2014,4,11,10,00,00) 
			-- local svrTime = GetServerOpenTime() or 0 --����ʱ��
			if svrTime<sec then
				return
			end
		end

		local t=uv_Store_Conf[24][tag][index]
		local id=t[1]
		local need=t[2]*num
		-- look(111,1)
		if id==nil or need==nil  then return end
		if id~=itemid then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			-- look(222,1)
			return
		end
		if not CheckCost( sid , need, 1 , 1, "24�̵�") then
			-- look(3333,1)
			return
		end
		if t[6] then ---�ȼ�����
			if CI_GetPlayerData(1)<t[6] then 
				-- look(33443,1)
				return
			end
		end

		if t[7] and t[7] >0 then --vip�ȼ�����
			local vtype = GI_GetVIPType( sid ) or 0
			if vtype < 2 then
				return
			end
			local vip=GI_GetVIPLevel( sid ) or 0
			if vip<t[7] then 
				-- look(311,1)
				return
			end
		end


		local maxnum=t[4] --�޹�����
		
		local fdata=get_fshopdata(sid )
		if fdata==nil then return end
		if fdata.tz==nil then 
			fdata.tz={}
		end
		-- look(8888,1)
		local sdata=fdata.tz
		if sdata==nil then  return end
		if sdata[2]==nil then 
			sdata[2]={}
		end
		local nownum=sdata[2][index] or 0
		if nownum>=maxnum or num> maxnum-nownum then 
			-- look(8666,1)
			SendLuaMsg(0,{ids=storeend,succ=15},9)
			return
		end
		sdata[2][index]=nownum+num
		-- look(988,1)
		if not CheckCost( sid , need, 0 , 1, "24Ͷ���޹��̵�") then
			return
		end
		-- look(999,1)
		SendLuaMsg(0,{ids=f_shop,index=index,num=sdata[2][index],itype=5},9)
		local getnum=t[8] or 1
		GiveGoods(id,num*getnum,1,'24Ͷ���޹��̵�')
		return true,need
	end	,
	--25��ҫ�̵�
	[25]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[25][tag][index]
		local id=t[1]
		local need=t[2]*num
		local needitem=uv_Store_Conf[25].needitem[1]
		if id==nil or need==nil  or needitem==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		if not (CheckGoods(needitem, need,0,sid,'25��ҫ�̵�') == 1) then
			SendLuaMsg(0,{ids=storeend,succ=9},9)
			return 
		end
		GiveGoods(id,num,1,'25��ҫ�̵�')	
		return true
	end,
	--26���籭�̵�
	[26]= function (sid,tag,index,num,itemid)
		local t=uv_Store_Conf[26][tag][index]
		local id=t[1]
		local need=t[2]*num
		local needitem=uv_Store_Conf[26].needitem[tag]
		if id==nil or need==nil  or needitem==nil then return end
		if id~=itemid then
			look("itemiderror")
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		if not (CheckGoods(needitem, need,0,sid,'26���籭�̵�') == 1) then
			SendLuaMsg(0,{ids=storeend,succ=9},9)
			return 
		end
		GiveGoods(id,num,1,'26���籭�̵�')	
		return true
	end,
}




-----------------------------��ں�������----------------------------------
---------------------------------------------------------------------------
-----------------------------��ں�������----------------------------------
--�̵깺��ͳһ���
function mainstore(sid,storeid,tag,index,num,itemid,name)

	if storeid==nil or tag == nil or index == nil or num == nil or itemid==nil then return end
	if num>999  or num<=0  then return end
	if storeid==4 or storeid==101 then --�����̵�
		local succ=buymystical(sid,storeid,tag,index,num,itemid)
		if succ then
			SendLuaMsg(0,{ids=storeend,succ=0,storeid=storeid,itemid=itemid},9)
		end
		return
	end
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return
	end
	--local funcname=_G["Store"..storeid]
	local funcname=call_storefunc[storeid]
	if type(funcname)=="function" then
		local succ,need=	funcname(sid,tag,index,num,itemid,name)
		if succ then
			SendLuaMsg(0,{ids=storeend,succ=0,storeid=storeid,itemid=itemid,name=name,need=need},9)
		end
		return succ
	end
end


--��ݹ���[itype=1����ʹ��]
function Quickbuy(sid,id,num,itype)
	if sid==nil or id==nil or num ==nil then return end
	if num>999 or num<=0 then return end
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return 0
	end
	local itemconf=quickbuyconf[id]
	if itemconf==nil then
		look('Quickbuy_conferror',1)
		return
	end
	
	local needmoney=itemconf[1]*num
	local moneytype=itemconf[2]
	if moneytype==1 then
		local pk=((GetPlayerPoints(sid,9) or 0)+100)/100
		if pk>5 then 
			pk=5
		end
		if not CheckCost( sid , rint(needmoney*pk), 0 , 3, "��ݹ���") then
			return
		end
	elseif moneytype==2 then
		if not CheckCost( sid , needmoney , 0 , 1, "��ݹ���",id,num) then
		return
		end
	elseif moneytype==3 then
		local point=GetPlayerPoints(sid,2)
		local now=point[1]--����
		if now==nil then return end 
		if now>=needmoney then
			AddPlayerPoints( sid , 2 , -needmoney ,nil,'��ݹ���',true)-----------
		else
			return
		end
	elseif moneytype==4 then
		local point=GetPlayerPoints(sid,3)
		local now=point[1]--���ڴ���
		if now==nil then return end 
		if now>=needmoney then
			AddPlayerPoints( sid , 3 , -needmoney,nil,'��ݹ���',true)-----------
		else
			return
		end
	else
		return
	end
	if itype==1 then
		local canuse=itemconf[3]
		if canuse~=1 then
			GiveGoods(id,num,1,'��ݹ���')
			return
		end
		-- local funname='OnUseItem_batch'..tostring(id)
		-- local func = _G[funname ]
		local res=OnUseItem_batch(id , num,nil,nil,true)
		if not res then
			look('OnUseItem_batch id error id=='..tostring(id),1)
			GiveGoods(id,num,1,'��ݹ���')
			return 
		end
		
	else
		GiveGoods(id,num,1,'��ݹ���')
	end
	--TipCenter(GetStringMsg(8))
	SendLuaMsg(0,{ids=quick_buy},9)
end