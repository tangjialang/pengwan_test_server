
--[[
file:	sowar.lua
desc:	���ϵͳ
author:	wk
update:	2013-11-18
]]--

local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local s_att		 = msgh_s2c_def[20][5]	
local s_akill	 = msgh_s2c_def[20][6]	
local s_look	 = msgh_s2c_def[20][9]	
local s_kg		 = msgh_s2c_def[20][16]	
local marry_look = msgh_s2c_def[20][17]	
local CI_UpdateBuffExtra=CI_UpdateBuffExtra
local CI_GetPlayerData=CI_GetPlayerData
local PI_UpdateScriptAtt=PI_UpdateScriptAtt
local _insert=table.insert
local GetRWData=GetRWData
local rint=rint
local look = look
local ScriptAttType = ScriptAttType
local pairs=pairs
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos
local CI_SetPlayerIcon=CI_SetPlayerIcon
local db_module =require('Script.cext.dbrpc')
local db_sowar_xy=db_module.db_sowar_xy
local __G=_G
local needid={
	710,--��ɫ����
	801,--����ս��
}

local sowar_conf={
	skill_goodsid={713,714,715,716,717},--������������������d
	--����������
	sowar_up={
		[2]={195,300,0,36},--����2����Ҫ�������ֵ,�������ֵ,�������ʹ�ø���,����id
		[3]={700,1000,0,37},
		[4]={2625,3500,10,38},
		[5]={6000,7500,20,39},
		[6]={10000,12000,30,40},
		[7]={15300,17000, 100, 41},--��������
	},
	att={--�����������ֵ
		[1]={1000,200,160,100,60},
		[2]={3000,600,480,300,180},
		[3]={7000,1400,1120,600,360},
		[4]={14000,2800,2240,1000,600},
		[5]={29000,5800,4640,1800,1080},
		[6]={49000,9800,7840,2800,1680},
		[7]={74000,14800,11840,4000,2400},
		
		[100]={500,100,50,30,20,},--������������
	},
	maxbh = 600,  --����
}

--������
function sowar_getdata(playerid)
	local batdata=GI_GetPlayerData( playerid , 'sowar' , 50 )
	if batdata == nil then return end
	--[[
		[1]=1,�ȼ�
		[2]=2,�������
		[3]=3,�������
		[4]=25,����ֵ,ÿ�����
		[5]=time,�״λ��1��ʱ��,24Сʱ����ʧ
		[6]={2,2,1},���ܵȼ�
		[7]=5,����ȼ�
		[8]=0,������ʾ
	]]
	return batdata
end
--�鿴
function sowar_look( sid,name,itype,s )
	local isonline=true
	if type(sid)~=type(0) or sid<1 then
		sid=GetPlayer(name, 0)
		if sid==nil or sid<1 then 
			isonline=false
		end
	end
	if type(name)~=type('') then
		name=CI_GetPlayerData(5,2,sid)
		if type(name)~=type('') then 
			isonline=false
		end
	end
	if not isonline then 
		SendLuaMsg(0,{ids=s_look,leave = 1},9)
		return
	end
	local batdata=sowar_getdata(sid)
	SendLuaMsg(0,{ids=s_look,name=name,itype=itype,data=batdata,s=s},9)
end
--���ÿ������
function sowar_reset( playerid )
	--look('���ÿ������')
	local batdata=sowar_getdata(playerid)
	if batdata==nil then return end

	if batdata[1] then 
		
		if batdata[1]>1 and batdata[4]  then --2�������������ֵ
			db_sowar_xy(batdata[1],batdata[4])
			batdata[4]=nil
			SendLuaMsg(0,{ids=s_att,xy=0},9)
		else
			--look('1��')
			if batdata[5] and GetServerTime()>batdata[5] then 
				local tempAtt=GetRWData(1)
				tempAtt[1]=0--��Ѫ
				tempAtt[3]=0--����
				tempAtt[4]=0--����
				tempAtt[6]=0--����
				tempAtt[8]=0--����
				PI_UpdateScriptAtt(playerid,ScriptAttType.sowar)
				
				set_mouse_new_id(0)---��������
				--look('��������0000')
				batdata[5]=nil--���ʱ��
				SendLuaMsg(0,{ids=s_att,time=0},9)
			end
			
		end
	end

end

--���µ�����������
local function sowar_Attributeone(playerid,id,findid,bufflv)	

	if playerid==nil  then
		return
	end
	if  id==nil or id<1 then --��������

		local batdata=sowar_getdata(playerid)
		if batdata==nil then 
			look("Getsowar_getdatarror")
			return
		end
		local tempAtt=GetRWData(1)

		local lv=batdata[1]
		local attconf=sowar_conf.att[lv]
		local addatt=sowar_conf.att[100]
		local add=batdata[2] or 0
		local bili=batdata[3] or 0
		local kglv=batdata[7] or 0--����ȼ�

		tempAtt[1]=rint((attconf[1]+add*addatt[1])*(bili*2+100)/100)+rint(kglv*300+kglv^2/5)--��Ѫ
		tempAtt[3]=rint((attconf[2]+add*addatt[2])*(bili*2+100)/100)+rint(kglv*100+kglv^2/10)--����
		tempAtt[4]=rint((attconf[3]+add*addatt[3])*(bili*2+100)/100)+rint(kglv*100+kglv^2/10)--����
		tempAtt[6]=rint((attconf[4]+add*addatt[4])*(bili*2+100)/100)+rint(kglv*50+kglv^2/20)--����
		tempAtt[8]=rint((attconf[5]+add*addatt[5])*(bili*2+100)/100)+rint(kglv*50+kglv^2/20)--����

		local a=PI_UpdateScriptAtt(playerid,ScriptAttType.sowar)
	else --���¼���
		-- look('���¼���')
		local b=CI_UpdateBuffExtra(id,findid,bufflv,0)
		-- look(b)
	end
end

--��ʼ�����Ը���
function sowar_Attribute(playerid,tempbuff)	
	--look('��ʼ�����Ը���111111')
	if playerid==nil  then return end
	local batdata=sowar_getdata(playerid)
	if batdata==nil then 
		look("GetDBBATTGEMDataerror")
		return
	end
	local tempAtt=GetRWData(1)
	if batdata[1]==nil then return end

	local lv=batdata[1]

	if lv==1 and batdata[5]==nil then return end --���ڲ���
	--look(lv)
	local attconf=sowar_conf.att[lv]
	local addatt=sowar_conf.att[100]
	local add=batdata[2] or 0
	local bili=batdata[3] or 0
	local kglv=batdata[7] or 0--����ȼ�

	-- tempAtt[1]=rint((attconf[1]+add*addatt[1])*(bili*2+100)/100)--��Ѫ
	-- tempAtt[3]=rint((attconf[2]+add*addatt[2])*(bili*2+100)/100)--����
	-- tempAtt[4]=rint((attconf[3]+add*addatt[3])*(bili*2+100)/100)--����
	-- tempAtt[6]=rint((attconf[4]+add*addatt[4])*(bili*2+100)/100)--����
	-- tempAtt[8]=rint((attconf[5]+add*addatt[5])*(bili*2+100)/100)--����

	tempAtt[1]=rint((attconf[1]+add*addatt[1])*(bili*2+100)/100)+rint(kglv*300+kglv^2/5)--��Ѫ
	tempAtt[3]=rint((attconf[2]+add*addatt[2])*(bili*2+100)/100)+rint(kglv*100+kglv^2/10)--����
	tempAtt[4]=rint((attconf[3]+add*addatt[3])*(bili*2+100)/100)+rint(kglv*100+kglv^2/10)--����
	tempAtt[6]=rint((attconf[4]+add*addatt[4])*(bili*2+100)/100)+rint(kglv*50+kglv^2/20)--����
	tempAtt[8]=rint((attconf[5]+add*addatt[5])*(bili*2+100)/100)+rint(kglv*50+kglv^2/20)--����

	--look(tempAtt)
	if batdata[6]==nil  then return true end  --�޼���

	--�м���
	local skillconf=sowar_conf.sowar_up
	local tempa=6
	for i=3,7 do ---6789Ϊ���buff,192�����
		--if i~=4 and i~=7 and batdata[6][i-1] ~=nil then 
		if i~=7 and batdata[6][i-1] ~=nil then 
			tempbuff[tempa][1]=skillconf[i][4] --id
			tempbuff[tempa][2]=batdata[6][i-1] --lv
			tempa=tempa+1
		end
	end
	if batdata[6][1] ~=nil then 
		tempbuff[tempa][1]=skillconf[2][4] --id
		tempbuff[tempa][2]=batdata[6][1] --lv
	end

	local oldlv=CI_GetSkillLevel(4,41)
	if oldlv<20 and oldlv>0 then
		CI_SetSkillLevel(4,41,oldlv*20)
	end

	return true
end
--ȡ���ս����
function sowar_getfight(playerid) 
	if playerid==nil  then return end
	local batdata=sowar_getdata(playerid)
	if batdata==nil then 
		look("GetDBBATTGEMDataerror")
		return
	end
	local tempAtt=GetRWData(1)
	if batdata[1]==nil then return end
	local lv=batdata[1]

	if lv==1 and batdata[5]==nil then return end --���ڲ���
	--look(lv)
	local attconf=sowar_conf.att[lv]
	local addatt=sowar_conf.att[100]
	local add=batdata[2] or 0
	local bili=batdata[3] or 0
	local kglv=batdata[7] or 0--����ȼ�

	-- tempAtt[1]=rint((attconf[1]+add*addatt[1])*(bili*2+100)/100)--��Ѫ
	-- tempAtt[3]=rint((attconf[2]+add*addatt[2])*(bili*2+100)/100)--����
	-- tempAtt[4]=rint((attconf[3]+add*addatt[3])*(bili*2+100)/100)--����
	-- tempAtt[6]=rint((attconf[4]+add*addatt[4])*(bili*2+100)/100)--����
	-- tempAtt[8]=rint((attconf[5]+add*addatt[5])*(bili*2+100)/100)--����
	tempAtt[1]=rint((attconf[1]+add*addatt[1])*(bili*2+100)/100)+rint(kglv*300+kglv^2/5)--��Ѫ
	tempAtt[3]=rint((attconf[2]+add*addatt[2])*(bili*2+100)/100)+rint(kglv*100+kglv^2/10)--����
	tempAtt[4]=rint((attconf[3]+add*addatt[3])*(bili*2+100)/100)+rint(kglv*100+kglv^2/10)--����
	tempAtt[6]=rint((attconf[4]+add*addatt[4])*(bili*2+100)/100)+rint(kglv*50+kglv^2/20)--����
	tempAtt[8]=rint((attconf[5]+add*addatt[5])*(bili*2+100)/100)+rint(kglv*50+kglv^2/20)--����

	local res=get_fightvalue(tempAtt)
	return res
end
-- �������
function sowar_begin( playerid )
	local plat=__G.__plat
	-- look('�������',1)
	-- look(plat,1)
	-- local plat=101
	-- if plat==103 then --37��
		-- local scdata=sctx_getdbdata( playerid )
		-- if scdata==nil then return end
		-- local nownum=scdata[1] or 0
		-- if nownum<3 then 
			-- return 
		-- end
	-- else
		local vip=GI_GetVIPType(playerid)
		if vip<2 then return end
	-- end
	-- look(11,1)
	local batdata=sowar_getdata(playerid)
	if batdata==nil then 
		look("GetDBBATTGEMDataerror")
		return
	end
	if batdata[1]==nil then
		batdata[1]=1
		set_mouse_new_id(batdata[1])---��������
		batdata[5]=GetServerTime()+24*3600
		sowar_Attributeone(playerid)	
		SendLuaMsg(0,{ids=s_att,lv=batdata[1],time=batdata[5]},9)
	end
	
end

--�������,itype=1Ϊ�Զ�����,ǰ̨��1�κ�̨����10��
function sowar_intensify(playerid,buy,lastnum,itype)
	-- look('�������')
	-- look('buy=='..buy)
	-- look('lastnum=='..lastnum)
	-- look('itype=='..tostring(itype))
	--look(TRACE_BEGIN()) 
	if playerid==nil  or buy==nil or lastnum==nil  then
		look("sowar_intensify dataerror",1)
		return
	end
	local batdata=sowar_getdata(playerid)
	if batdata==nil or  batdata[1]==nil  then 
		look("GetDBBATTGEMDataerror")
		return
	end
	local lv=batdata[1]--�ȼ�	
	if lv >=7 then 
		return 
	end

	local lastnum1=lastnum
	local max=1
	if itype then
		max=10
	end
	local result
	local use=0
	for i=1,max do
		--����,Ǯ����
		local neednum=lv+1
		if buy==0 then--����Ǯ
			if 0 == CheckGoods(needid[1],neednum,0,playerid,'�������') then--�۵��߻���Ǯ
				SendLuaMsg(0,{ids=BTerror,erro=1},9)
				break
				--return
			end
		else --��Ǯ
			local needdeduct=0
			if lastnum1>=neednum then --������Ʒ����������Ʒ
				if 0 == CheckGoods(needid[1],neednum,1,playerid,'�������') then
					break	
					--return
				else
					needdeduct=neednum
					neednum=0
					lastnum1=lastnum1-neednum--ʣ�����
				end
			elseif lastnum1<neednum and lastnum1>0 then
				if 0 == CheckGoods(needid[1],lastnum1,1,playerid,'�������') then
					break
					--return
				else
					needdeduct=lastnum1
					neednum=neednum-lastnum1
					lastnum1=0----ʣ�����0
				end
			end

			if neednum>0 then--��Ҫ��Ǯ
				if not CheckCost(playerid , neednum*30, 0 , 1,'�������') then
					SendLuaMsg(0,{ids=BTerror,erro=2},9)
					break
					--return
				end
			end
			CheckGoods(needid[1],needdeduct,0,playerid,'�������')
		end

		local luck=batdata[4] or 0--����ֵ
		local gatemini=sowar_conf.sowar_up[lv+1][1]
		local gatemax=sowar_conf.sowar_up[lv+1][2]
		if luck<=gatemini then --ʧ��,����ֵ����
			batdata[4]=luck+(lv+1)*3
			
		else
			local gate=math.ceil((luck-gatemini)/neednum*3)
			local rannum=math.random(1,100)

			if luck<gatemax and rannum>gate then --���ֵһ����δ�и���,ʧ��
				batdata[4]=luck+(lv+1)*3
			
			else --�ɹ�
				batdata[4]=nil--����ֵ��0
				batdata[1]=batdata[1]+1--����
				set_mouse_new_id(batdata[1])---��������
				sowar_Attributeone(playerid)--���Ը���
				batdata[5]=nil ---����ʱ��
				if batdata[1]==2 then 
					set_obj_pos(playerid,3005)
				elseif batdata[1]==3 then 
					set_obj_pos(playerid,4002)
				elseif batdata[1]==4 then 
					set_obj_pos(playerid,5003)
				end

				result=true
				break --����,����
			end

		end
		use=use+1
	end

	if result then 
		SendLuaMsg(0,{ids=s_att,lv=batdata[1],xy=0,res=1,max=use},9)
	else
		SendLuaMsg(0,{ids=s_att,xy=batdata[4],res=0,max=use},9)
	end
	--look(TRACE_END())
end

--ѧϰ����
function sowar_learnskill(playerid,num)
	-- look('ѧϰ����')
	
	local batdata=sowar_getdata(playerid)
	-- look(batdata)
	if batdata==nil or  batdata[1]==nil  then 
		look("GetDBBATTGEMDataerror")
		return
	end
	if num>batdata[1]-1 then 
		-- look(111)
		return
	end

	if batdata[6]==nil then 
		batdata[6]={}
	end
	local nowlv=batdata[6][num] or 0
	local maxlv=5
	local goodsid=sowar_conf.skill_goodsid[nowlv+1]
	-- if num==2 or num==4 then --������2��
	-- 	maxlv=6
	-- 	if nowlv>0 then 
	-- 		goodsid=sowar_conf.skill_goodsid[nowlv]
	-- 	end
	-- end
	if  nowlv>=maxlv then  return end
	

	if 0 == CheckGoods(goodsid,1,0,playerid,'�������') then
		
		return
	end

	local buffid=sowar_conf.sowar_up[num+1][4]

	local findid=buffid
	if nowlv==0 then 
		-- if num==2 or num==4 then --������2��
		-- 	nowlv=1
		-- end
		findid=0
	end
	batdata[6][num]=nowlv+1

	if num==6 then --��������
		if nowlv==0 then
			CI_LearnSkill(4,buffid)
			CI_SetSkillLevel(4,buffid,20)
		else
			CI_SetSkillLevel(4,buffid,nowlv*20+20)
		end
	else--buff����
		sowar_Attributeone(playerid,buffid,findid,nowlv+1)--���Ը���
	end
	SendLuaMsg(0,{ids=s_akill,num=num,lv=batdata[6][num]},9)
end

--ʹ�ñ���--+����
function sowar_usebhun( playerid)
	local batdata=sowar_getdata(playerid)
	if batdata==nil  then 
		look("GetDBBATTGEMDataerror")
		return 0
	end
	if  (batdata[1] or 0)<3 then return 0 end
	if (batdata[2] or 0)>= sowar_conf.maxbh then return 0 end
	batdata[2]=(batdata[2] or 0)+1
	sowar_Attributeone(playerid)
	SendLuaMsg(0,{ids=s_att,bh=batdata[2]},9)
end
--ʹ�ñ���--+%
function sowar_usebling( playerid)
	local batdata=sowar_getdata(playerid)
	if batdata==nil or batdata[1]==nil then 
		look("GetDBBATTGEMDataerror")
		return 0
	end
	if  batdata[1]<4 then return 0 end

	if (batdata[3] or 0)>=sowar_conf.sowar_up[batdata[1]][3] then return 0 end

	batdata[3]=(batdata[3] or 0)+1
	sowar_Attributeone(playerid)
	SendLuaMsg(0,{ids=s_att,bl=batdata[3]},9)
end



--ʹ���߲�����������ֵ num=2,2�ײ�����,itype=1Ϊ�߲ʿ�
function sowar_addxy( playerid,num ,itype)
	local batdata=sowar_getdata(playerid)
	if batdata==nil   then 
		look("GetDBBATTGEMDataerror")
		return 0
	end
	local lv=batdata[1] or 0
	if  lv<num or lv>7 then 
		TipCenter(GetStringMsg(28,num))
		return 0 
	end
	if lv>=7 then return end 
	local up=15
	if lv>num then 
		up=5
		if itype==1 then
			up=1
		end
	end
	
	local maxxy=sowar_conf.sowar_up[lv+1][2]
	if  (batdata[4] or 0)>=maxxy then return 0 end
	batdata[4]=(batdata[4] or 0)+rint(maxxy*up/100)
	if batdata[4]>maxxy then 
		batdata[4]=maxxy
	end
	SendLuaMsg(0,{ids=s_att,xy=batdata[4]},9)
end

--itype=nilȡ����ȼ�,1ȡ����,2ȡ����
function sowar_getlv( playerid ,itype)
	local batdata=sowar_getdata(playerid)
	if batdata==nil  then 
		look("GetDBBATTGEMDataerror")
		return 0
	end
	local res
	if itype==nil then 
		res=batdata[1] or 0
	elseif itype==1 then 
		res=batdata[2] or 0
	elseif itype==2 then 
		res=batdata[3] or 0
	else
		return 0
	end
	return res
end


function sowar_chengjiu( playerid )
	local batdata=sowar_getdata(playerid)
	if batdata==nil or batdata[1]==nil  then 
		return 0
	end
	local lv=batdata[1]
	if lv>=4 then 
		set_obj_pos(playerid,3005)
		set_obj_pos(playerid,4002)
		set_obj_pos(playerid,5003)
	elseif lv>=3 then 
		set_obj_pos(playerid,4002)
		set_obj_pos(playerid,3005)
	elseif lv>=2 then 
		set_obj_pos(playerid,3005)
	end
end

--�������
function sowar_kaiguang( playerid,buy,lastnum)
	-- look('�������',1)
	-- look(buy,1)
	-- look(lastnum,1)
	if playerid==nil  then return end
	local batdata=sowar_getdata(playerid)
	if batdata==nil then 
		look("GetDBBATTGEMDataerror")
		return
	end
	
	if batdata[1]==nil then return end
	local kglv=batdata[7] or 0
	if kglv>=300 then return end
	if batdata[1]<7 then return end--���δ��7��

	local neednum1=30+rint((kglv+1)/1.5)--��ɫ����
	local neednum2=1+rint((kglv+1)/30)--����ս��
	if 0 == CheckGoods(needid[2],neednum2,1,playerid,'�������') then
		return
	end
	local needyb=0
	if buy==0 then--����Ǯ
		if 0 == CheckGoods(needid[1],neednum1,1,playerid,'�������') then
			return
		end
	else --��Ǯ
		if lastnum>0 and lastnum<neednum1 then 
			if CheckGoods( needid[1], lastnum, 1, playerid,'�������') == 0 then
				return
			end
			 needyb=(neednum1-lastnum)*30
			if not CheckCost(playerid, needyb,1,1) then
				return
			end
		elseif lastnum==0 then 
			 needyb=neednum1*30
			if not CheckCost(playerid, needyb,1,1) then
				return
			end
		elseif lastnum>=neednum1 then 
			if CheckGoods( needid[1], neednum1, 1, playerid,'�������') == 0 then
				return
			end
		else
			return
		end
	end
	-- look('�������111',1)
	if buy==0 then--����Ǯ
		if 0 == CheckGoods(needid[1],neednum1,0,playerid,'�������') then
			return
		end
	else --��Ǯ
		if lastnum==0 then 
			if not CheckCost(playerid, needyb,0,1,'�������') then
				return
			end
		else
			if lastnum<=neednum1 then 
				if CheckGoods( needid[1], lastnum, 0, playerid,'�������') == 0 then
					return
				end
			else
				if CheckGoods( needid[1], neednum1, 0, playerid,'�������') == 0 then
					return
				end
			end
			if needyb>0 then 
				if not CheckCost(playerid, needyb,0,1,'�������') then
					return
				end
			end
		end
	end
	-- look('�������2222',1)
	-- 
	if 0 == CheckGoods(needid[2],neednum2,0,playerid,'�������') then
		return
	end
	 -- look('�������333',1)
	batdata[7]=kglv+1
	
	sowar_Attributeone(playerid)--���Ը���
	SendLuaMsg(0,{ids=s_kg,kglv=batdata[7]},9)

	if batdata[7]%100==0 then 
		local srcIcon = CI_GetPlayerIcon(3,3)
		srcIcon =bits.set(srcIcon,1,8,batdata[7]/100)
		--CI_SetPlayerIcon(3,3,(batdata[7] or 0)*100+batdata[7]/100)--3ʱװ,3�������
		CI_SetPlayerIcon(3,3,srcIcon)--3ʱװ,3�������
		AreaRPC(0,nil,nil,"sowar_up",CI_GetPlayerData(16),batdata[7]/100)
	end

end

--����3Ϊ������⼰��������С����
--[[
	ʮλ��λΪ�������Ԥ��
	��λ=1Ϊ������ʾ--������������ļ���
]]--
--����������ʾ,1����,0Ĭ����ʾ
function marry_see( playerid,itype)
	-- look(itype,1)
	local batdata=sowar_getdata(playerid)
	local kglv=0
	if batdata~=nil  then 
		kglv=(batdata[7] or 0)/100
	end
	local srcIcon = CI_GetPlayerIcon(3,3)
		

	if itype==1 then 
		batdata[8]=1
		-- CI_SetPlayerIcon(3,3,100+kglv)
		srcIcon =bits.set(srcIcon,9,9,1)
		CI_SetPlayerIcon(3,3,srcIcon)--3ʱװ,3�������
	else
		batdata[8]=0
		-- CI_SetPlayerIcon(3,3,kglv)
		srcIcon =bits.set(srcIcon,9,9,0)
		CI_SetPlayerIcon(3,3,srcIcon)--3ʱװ,3�������
	end
	SendLuaMsg(0,{ids=marry_look,itype=itype},9)
end

--��½ͬ��������⼰ʱװ
function sowar_login(playerid)
	local batdata=sowar_getdata(playerid)

	local srcIcon = CI_GetPlayerIcon(3,3)
	srcIcon =bits.set(srcIcon,1,8,(batdata[7] or 0)/100)
	srcIcon =bits.set(srcIcon,9,9,(batdata[8] or 0))
	CI_SetPlayerIcon(3,3,srcIcon)--3ʱװ,3�������

	--CI_SetPlayerIcon(3,3,(batdata[8] or 0)*100+(batdata[7] or 0)/100)
end
-------------------------------------
---test
function sowar_clc( playerid )
	local batdata=sowar_getdata(playerid)
	if batdata==nil  then 
		look("GetDBBATTGEMDataerror")
		return 0
	end
	for i=1,6 do
		batdata[i]=nil
	end
	SendLuaMsg(0,{ids=s_att,lv=1,xy=0},9)
end