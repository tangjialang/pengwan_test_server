--[[
file:	Vip_Store.lua
desc:	�����̵�ϵͳ
author:	wk
update:	2013-1-24
refix:	done by wk
]]--
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local look = look
local storebuy	 = msgh_s2c_def[24][1]	
local storeend	 = msgh_s2c_def[24][2]	
local storenum	 = msgh_s2c_def[24][3]	
local pairs,tostring=pairs,tostring
local type=type
local isFullNum,BroadcastRPC=isFullNum,BroadcastRPC
local TipCenter,GetStringMsg = TipCenter,GetStringMsg
local GiveGoods,GetServerTime=GiveGoods,GetServerTime
local CheckCost=CheckCost
local _remove=table.remove
local _insert=table.insert
local _random=math.random
local uv_Store_Conf=Store_List
local uv_vipsotreconf=uv_Store_Conf[4]--vip������
-- local common 			= require('Script.common.Log')
-- local Log 				= common.Log
---------------------------------------------------------
--������������	
local function VipS_GetData()
	local w_customdata = GetWorldCustomDB()
	if w_customdata == nil then
		return
	end
	if w_customdata.VipData == nil then
		w_customdata.VipData = {
			LastAward = {},		-- ����鵽�Ľ��� ����20��
		}
	end
	return w_customdata.VipData
end
--������������̵�����

local function GetDBvipstoreData( playerid )
	local vipstore_Data=GI_GetPlayerData( playerid , 'vips' , 270 )
	if vipstore_Data == nil then return end
	-- if vipstore_Data.main==nil then
		-- --vipstore_Data.main={}--������
		-- --vipstore_Data.temp={}--��������
		-- --vipstore_Data.last=0--�ϴ�ˢ��ʱ��
		-- --vipstore_Data.mark1={}--������ɹ������
		-- --vipstore_Data.mark2={}--�����ɹ������
		-- --vipstore_Data.refre=0--5��ǰ�����⣬5�κ������ͨ�⣬100�ν�����ؿ⣬Ȼ������
	-- end
	--look(tostring(vipstore_Data))
	return vipstore_Data
end
--ˢ��n��vip�̵�
--12345,����ɹ���12��,����3�ű�ǩ,��45����Ʒ
local function viprefresh(sid,Num)
	if Num > 30 then Num = 30 end
	local vipdata=GetDBvipstoreData(sid)
	if vipdata.temp==nil then
		vipdata.temp={}
	end
	for k,v in pairs(vipdata.temp) do
		if type(v)==type(0) then
			vipdata.temp[k]=nil
		end
	end
	for j=1,Num do
		local temp=vipdata.temp
		local refre=vipdata.refre or 0
		if refre<59 then
			local conf=uv_vipsotreconf[2]
			if conf then
				for i=1,6 do
					local num=_random(1,10000)
					for k,v in pairs(conf) do
						if v[4] then
							if num<=v[4] then
								--local temp1=200+k
								local temp1=1200+k
								if temp[1]==nil then
									temp[1]=temp1
									--mark2[1]=1
								else
									local a=0
									for n,m in pairs (temp) do
										if type(m)==type(0) then
										
											--if m==temp1 then
											if m%1000==temp1%1000 then
												--mark2[n]=(mark2[n] or 0) +1
												temp[n]=m+1000
												a=1
											end
										end
									end
									if a==0 then
										_insert(temp,temp1)
										--_insert(mark2,1)
									end
								end		
								vipdata.refre=refre+1
								break
							end
						end
					end
				end
			end	
		else--��������Ʒ
			local conf=uv_vipsotreconf[2]
			if conf then
				for i=1,5 do
					local num=_random(1,10000)
					for k,v in pairs(conf) do
						if v[4] then
							if num<=v[4] then
								--local temp1=200+k
								local temp1=1200+k
								if temp[1]==nil then
									temp[1]=temp1
								else
									local a=0
									for n,m in pairs (temp) do
										if type(m)==type(0) then
											if m%1000==temp1%1000 then
												--mark2[n]=mark2[n] or 0 +1
												temp[n]=m+1000
												a=1
											end
										end
									end
									if a==0 then
										_insert(temp,temp1)
										--_insert(mark2,1)
									end
								end		
								vipdata.refre=refre+1
								break
							end
						end
					end
				end
			end	
			local conf1=uv_vipsotreconf[3]
			if conf1 then
				local num=_random(1,10000)
				for k,v in pairs(conf1) do
					if v[4] then
						if num<=v[4] then
							--_insert(temp,300+k)
							_insert(temp,1300+k)

							break
						end
					end
				end
			end	
			vipdata.refre=0
		end
	end
end
------------------------------------------------------------
--��ʼ�������̵�(105,1�������òֿ�ţ�05����λ��)
function vip_store(sid)
	local vipdata=GetDBvipstoreData(sid)
	if vipdata==nil then 
		return
	end
	local last_time=vipdata.last or 0
	local now_time=GetServerTime()
	if now_time>last_time then--��ˢ��
		re_vipstore(sid,0,0)--���ˢ��
	end
	local data=VipS_GetData()
	if data ==nil or  data.LastAward==nil  then
		return
	end
	SendLuaMsg(0,{ids=storebuy,storeid=4,last=vipdata.last,luckinfo=data.LastAward},9)
end
-- --��ʼ�����������̵�
-- function vip_store2(sid)
	-- local vipdata=GetDBvipstoreData(sid)
	-- local main1={}
	-- for k,v in pairs (vipdata.temp) do
		-- if type(k)==type(0) and type(v)==type(0) then
			-- if main1[k]==nil then
				-- main1[k]={}
			-- end
			-- main1[k]=uv_vipsotreconf[rint(v/100)][v%100]
		-- end
	-- end
	-- SendLuaMsg(0,{ids=storebuy,storeid=101,storeconf=main1,mark2=vipdata.mark2},9)
-- end
--ˢ��vip�̵�
function re_vipstore(sid,itype,Num)
	local vipdata=GetDBvipstoreData(sid)
	if vipdata==nil then 
		look("dataerror")
		return
	end
	if itype==0 then --���ˢ��
		--vipdata.main={}
		if vipdata.main==nil then 
			vipdata.main={}
		end
		local main=vipdata.main
		local conf=uv_vipsotreconf[1]
		if conf then
			for i=1,6 do
				main[i]=nil
				local num=_random(1,10000)
				for k,v in pairs(conf) do
					if v[4] then 
						if num<=v[4] then
							--main[i]=100+k
							main[i]=1100+k
							break
						end
					end
				end
			end
		end	
		vipdata.last=GetServerTime()+4*3600
		--vipdata.mark1={}
		--SendLuaMsg(0,{ids=storebuy,storeid=4,last=vipdata.last,storeconf=vipdata.main,mark1=vipdata.mark1,},9)
		SendLuaMsg(0,{ids=storebuy,storeid=4,last=vipdata.last,storeconf=vipdata.main,},9)
	elseif itype==1 then --Ԫ��ˢ��1��
		if not CheckCost( sid , 10, 0 , 1, "100005_�����̳�ˢ��") then
			SendLuaMsg(0,{ids=storeend,succ=1},9)
			return
		end
		--vipdata.main={}
		--vipdata.mark1={}
		if vipdata.main==nil then 
			vipdata.main={}
		end
		local main=vipdata.main
		local allnum=vipdata.refre or 0
		if allnum<5 then
			local conf=uv_vipsotreconf[1]
			if conf then
				for i=1,6 do
					main[i]=nil
					local num=_random(1,10000)
					for k,v in pairs(conf) do
						if v[4] then
							if num<=v[4] then
								--main[i]=100+k
								main[i]=1100+k
								break
							end
						end
					end
				end
			end	
			vipdata.refre=allnum+1
		elseif allnum>=5 and allnum<100 then
			local conf=uv_vipsotreconf[2]
			if conf then
				for i=1,6 do
					local num=_random(1,10000)
					for k,v in pairs(conf) do
						if v[4] then
							if num<=v[4] then
								--main[i]=200+k
								main[i]=1200+k
								break
							end
						end
					end
				end
			end	
			vipdata.refre=allnum+1
		else
			local conf=uv_vipsotreconf[2]
			if conf then
				for i=1,5 do
					local num=_random(1,10000)
					for k,v in pairs(conf) do
						if v[4] then
							if num<=v[4] then
								--main[i]=200+k
								main[i]=1200+k
								break
							end
						end
					end
				end
			end	
			local conf1=uv_vipsotreconf[3]
			if conf1 then
				local num=_random(1,10000)
				for k,v in pairs(conf1) do
					if v[4] then
						if num<=v[4] then
							--main[6]=300+k
							main[6]=1300+k
							break
						end
					end
				end
			end	
			vipdata.refre=0
		end
		AddPlayerPoints( sid , 5 , 1 ,nil,'���ػ���')
		--vipdata.mark1={}
		-- local main1={}
		-- for k,v in pairs (vipdata.main) do
			-- if type(k)==type(0) and type(k)==type(0) then
				-- if main1[k]==nil then
					-- main1[k]={}
				-- end
				-- main1[k]=uv_vipsotreconf[rint(v/100)][v%100]
			-- end
		-- end
		--SendLuaMsg(0,{ids=storebuy,storeid=4,storeconf=main,mark1=vipdata.mark1,},9)
		SendLuaMsg(0,{ids=storebuy,storeid=4,storeconf=main,},9)
	elseif itype==2 then --Ԫ��ˢ��n��	
		--rfalse("Num"..Num)
		local moneynum=10*Num
		if Num==10 then
			moneynum=moneynum*0.95
		elseif Num==30 then
			moneynum=moneynum*0.9
		else
			return
		end
		if not CheckCost( sid , moneynum, 0 , 1, "100005_�����̳�����ˢ��") then
			SendLuaMsg(0,{ids=storeend,succ=1},9)
			return
		end
		viprefresh(sid,Num)
		AddPlayerPoints( sid , 5 , Num,nil,'���ػ���' )
		-- local main1={}
		-- for k,v in pairs (vipdata.temp) do
			-- if type(k)==type(0) and type(k)==type(0) then
				-- if main1[k]==nil then
					-- main1[k]={}
				-- end
				-- main1[k]=uv_vipsotreconf[rint(v/100)][v%100]
			-- end
		-- end
		--SendLuaMsg(0,{ids=storebuy,storeid=101,storeconf=vipdata.temp,mark2=vipdata.mark2,},9)	
		SendLuaMsg(0,{ids=storebuy,storeid=101,storeconf=vipdata.temp,},9)	
	end
end


--����vip��Ʒ
function buymystical(sid,storeid,tag,index,num,itemid)
	if storeid==nil or tag == nil or index == nil or num == nil then return end
	local vipdata=GetDBvipstoreData(sid)
	local storeConf
	local t
	if vipdata then
		if storeid==4 then
			storeConf=vipdata.main
		elseif storeid==101 then
			storeConf=vipdata.temp
		else
			SendLuaMsg(0,{ids=storeend,succ=10},9)
		end
		if storeConf[index] ==nil then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return
		end
		t=uv_vipsotreconf[rint((storeConf[index]%1000)/100)][storeConf[index]%100]
		if rint(storeConf[index]/1000)<num then
			SendLuaMsg(0,{ids=storeend,succ=10},9)
			return 
		end
	end
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return 
	end
	local id=t[1]--����id
	if itemid~=id then
		SendLuaMsg(0,{ids=storeend,succ=10},9)
		return
	end
	local itype=t[5]--�Ƿ�Ϊ������Ʒ
	local need = t[2]*num
	if not CheckCost( sid , need , 1 , 1, "�����̳�") then
		SendLuaMsg(0,{ids=storeend,succ=1},9)
		return
	end
	if not CheckTimes(sid,5,num,-1) then 
		SendLuaMsg(0,{ids=storeend,succ=4},9)
		return
	end

	GiveGoods(id,num,1,'����vip��Ʒ')
	CheckCost( sid , need , 0 , 1,"�����̳ǹ���",id,num)
	storeConf[index]=storeConf[index]-num*1000
	SendLuaMsg(0,{ids=storenum,storeid=storeid,index=index,num=storeConf[index]},9)
	if itype==1 then
		local data=VipS_GetData()
		if data and data.LastAward then
			local playername = CI_GetPlayerData(5)	
			local tempinfo={}
			tempinfo.name=playername
			tempinfo.id=id
			tempinfo.price=t[2]
			_insert(data.LastAward,1,tempinfo)
			if #data.LastAward>20 then
				_remove(data.LastAward,21)
			end
			BroadcastRPC('Luckstory',tempinfo)
		end
	end
	return true
end