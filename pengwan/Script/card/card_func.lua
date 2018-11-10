--[[
file:	card_func.lua
desc:	����ϵͳ
author:	wk
update:	2013-8-7
]]--

local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local skill_buff	 = msgh_s2c_def[42][1]		
local gl_buff	 = msgh_s2c_def[42][2]		
local xd_buff	 = msgh_s2c_def[42][3]		
local zb_buff	 = msgh_s2c_def[42][4]
local qh_res	 = msgh_s2c_def[42][5]		
local look = look
local ScriptAttType = ScriptAttType
local pairs,type = pairs,type
local RPC=RPC
local CI_GetCurPos=CI_GetCurPos
local __G=_G
--local PI_UpdateScriptAtt=PI_UpdateScriptAtt
local CheckGoods=CheckGoods
local GetRWData=GetRWData
local BroadcastRPC=BroadcastRPC
local AddPlayerPoints=AddPlayerPoints
local GI_GetPlayerData=GI_GetPlayerData
local CI_GetPlayerData=CI_GetPlayerData

local card_conf=require("Script.card.card_conf")
local card_useid_conf=card_conf.card_useid_conf
local card_att_conf=card_conf.card_att_conf
local CI_SetSkillLevel=CI_SetSkillLevel
local _ceil=math.ceil
local CI_UpdateBuffExtra=CI_UpdateBuffExtra
local CI_HasBuff,CI_DelBuff,CI_AddBuff= CI_HasBuff,CI_DelBuff,CI_AddBuff
local _random=math.random
local CheckCost=CheckCost
local GetPlayerPoints=GetPlayerPoints
local rint,tostring=rint,tostring
local ScriptGidType=ScriptGidType
local SI_getgid_Object=SI_getgid_Object
local AreaRPC=AreaRPC
local CI_SelectObject=CI_SelectObject
local CI_GetSkillLevel=CI_GetSkillLevel
local mathfloor,mathrandom = math.floor,math.random
local GiveGoods,CheckGoods,isFullNum = GiveGoods,CheckGoods,isFullNum
local SendLuaMsg,TipCenter,GetStringMsg = SendLuaMsg,TipCenter,GetStringMsg
local needmoney=50--ϴ����Ҫ��Ǯ
local needid=804 --ǿ��
-------------------------------------------------------------------
module(...)
-------------------------------------------------------------------
--������ҿ���������
local function get_carddata( playerid )
	local card_data=GI_GetPlayerData( playerid , 'card' , 400 )
	-- look(card_data)
	if card_data.asl == nil then 
		-- if card_data[1]==nil then
			-- card_data[1]={}
			-- card_data[2]={}
			-- card_data[3]={}
			-- card_data[4]={}
			-- card_data[5]={}
			-- card_data.sl=0---������ֵ
			card_data.nsl=1---������ֵ
			card_data.asl=1---����ֵ��ʷ���ֵ
			-- card_data.get=3---��ȡ��¼,3�����쵽��3��
			-- card_data.us={}---ʹ���е�3������buff
			-- card_data.have={}---ӵ�е�buff,idΪkey,ֵΪ�ȼ�
			-- card_data.gl={}---װ�����ܴ�������
		-- end
	end
	return card_data
end
-- --�õ������ȼ�
-- local function card_getsllv( sl )
-- 	local slconf=card_att_conf.att_sl
-- 	for i=1,10 do
-- 		if slconf[i] then
-- 			if sl<slconf[i].slup then
-- 				return i-1
-- 			end
-- 		end
-- 	end
-- 	return 0
-- end
-- --���þ��Ѽ���
-- local function card_setskill( lv )
-- 	local school = CI_GetPlayerData(2)
-- 	if school == 1 then
-- 		local a=CI_SetSkillLevel(1,108,lv,12)
-- 		look(a)
-- 	elseif school == 2 then
-- 		CI_SetSkillLevel(1,123,lv,12)
-- 	elseif school == 3 then
-- 		CI_SetSkillLevel(1,124,lv,12)
-- 	end
-- end
-- --�������Ը���
-- local function _card_upatt(playerid,zhang)	
-- 	local carddata=get_carddata( playerid )
-- 	if carddata==nil then return end
-- 	local AttTable =GetRWData(1)
-- 	local sl=carddata.sl or 0
-- 	local lv=card_getsllv(sl) --����ֵ��Ӧ�ȼ�
-- 	local att_conf=card_att_conf.att_sl[lv]
-- 	if att_conf==nil then return end
-- 	for k,v in pairs(att_conf) do
-- 		if type(k)==type(0) and type(v)==type({}) then
-- 			AttTable[v[1]]=v[2]
-- 		end
-- 	end

-- 	if zhang then --ͨ�ظ���
-- 		__G.PI_UpdateScriptAtt(playerid,ScriptAttType.card)--  ���½ű����ӵ��������
-- 	end

-- 	return true
-- end
--��������,6�ſ����Լ���,ǿ����ʽ����
local att_newconf={
	[1]={
		[3]={100,50,10,2,20},--����
		[9]={50,25,5,2,40},--��
	},
	[2]={
		[4]={100,50,10,2,20},--����
		[5]={50,25,5,2,40},--����
	},
	[3]={
		[1]={500,250,30,2,1},--��Ѫ
		[7]={50,25,5,2,40},--����
	},
	[4]={
		[3]={100,50,10,2,20},--����
		[6]={50,25,5,2,40},--�ر�
	},
	[5]={
		[4]={100,50,10,2,20},--����
		[8]={50,25,5,2,40},--����
	},
	[6]={
		[1]={500,250,30,2,1},--��Ѫ
		[5]={50,25,5,2,40},--����
	},
}

local skill_buff_conf={
	 	--1.buff�������ȼ�,2.���Էŵ�λ��,3.�ͷŶ���(1�Լ�,2����),4.�ֿ��ķ�id,
	 add_buff={
		[259]={10,1,1},
		[358]={10,1,1},
		[363]={5,1,1},
		[355]={5,1,2},
		[359]={10,2,1},
		[361]={10,2,1},
		[356]={5,2,2,96,},
		[357]={5,2,2,95,},
		[353]={10,3,2},
		[354]={10,3,2,97,},
		[362]={5,3,1},
		[360]={5,3,1},
	},

	--ʹ��3���������ϴ���buff
	use_buff={197,198,199},
}

--�������Ը���
local function _card_upatt(playerid,zhang,tempbuff)	
	-- look('�������Ը���111',1)
	-- look(tempbuff,1)
	local carddata=get_carddata( playerid )
	if carddata==nil then return end
	local AttTable =GetRWData(1)
	local sl=carddata.sl or 0
	-- local lv=card_getsllv(sl) --����ֵ��Ӧ�ȼ�
	-- local att_conf=card_att_conf.att_sl[lv]
	-- if att_conf==nil then return end
	-- for k,v in pairs(att_conf) do
	-- 	if type(k)==type(0) and type(v)==type({}) then
	-- 		AttTable[v[1]]=v[2]
	-- 	end
	-- end
	local taopai={}
	local nowlv
	for k,v in pairs(carddata) do
		if type(k)==type(0) and type(v)==type({}) then
			for j,h in pairs(v) do--��,j=1-6,h=�ȼ�
				if type(j)==type(0) and type(h)==type(0) then
					-- look('��'..j,1)
					-- look('�ȼ�'..h,1)
					if h==100 then 
						for x,y in pairs(att_newconf[j]) do
							AttTable[x]=(AttTable[x] or 0)+y[1]+(k-1)*y[2]
						end
						taopai[k]=(taopai[k] or 0)+1
					elseif h>100 then --��ǿ��
						for x,y in pairs(att_newconf[j]) do
							nowlv=(h-100)
							-- look(x,1)
							AttTable[x]=(AttTable[x] or 0)+y[1]+(k-1)*y[2] +rint(nowlv*y[3]+nowlv^y[4]/y[5])
							-- look(nowlv,1)
							-- look(y[1]+(k-1)*y[2],1)
							-- look(rint(nowlv*y[3]+nowlv^y[4]/y[5]),1)
						end
						taopai[k]=(taopai[k] or 0)+1
					end
				end
			end
			
		end
	end

	for k,v in pairs(taopai) do
		if v==6 then --6������
			AttTable[1]= (AttTable[1] or 0)+card_att_conf.extra_Award[k].hp
		end
	end
	-- look(AttTable,1)
	if zhang then --ͨ�ظ���
		__G.PI_UpdateScriptAtt(playerid,ScriptAttType.card)--  ���½ű����ӵ��������
		return
	end

	if  carddata.us and carddata.us[1] then --װ���˵�1����
		tempbuff[16][1]=92 --id
		tempbuff[16][2]=1 --lv
	end
	return true
end

--��ȡ����
function card_bag_give(index, itype, itemid)
	local sid = CI_GetPlayerData(17)
	if sid == nil then return end
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return 0
	end
	if itype == 1 then
		if index == 1099 then --3��
			local randid = mathrandom(1162,1167)
			if 0 == CheckGoods(index, 1, 0, sid, '�ۿ�����') then return end
			GiveGoods(randid,1,1,"������") 
			RPC('card_give_rand', index, randid)
		elseif index == 1100 then --4��
			local randid = mathrandom(1168,1173)
			if 0 == CheckGoods(index, 1, 0, sid, '�ۿ�����') then return end
			GiveGoods(randid,1,1,"������")
			RPC('card_give_rand', index, randid)
		end
	else
		if itemid == nil then return end
		if index == 1099 then --3��
			if 0 == CheckGoods(index, 1, 1, sid, '�ۿ�����') then return end
			if not CheckCost( sid, 3*10, 0, 1, "��ȡ����") then return end
			CheckGoods(index, 1, 0, sid, '�ۿ�����')
			GiveGoods(itemid,1,1,"������")
			RPC('card_give_allocate', index, itemid)
		
		elseif index == 1100 then --4��
			if 0 == CheckGoods(index, 1, 1, sid, '�ۿ�����') then return end
			if not CheckCost( sid, 4*10, 0, 1, "��ȡ����") then return end
			CheckGoods(index, 1, 0, sid, '�ۿ�����')
			GiveGoods(itemid,1,1,"������")
			RPC('card_give_allocate', index, itemid)
			
		end
	end
end
	
--ʹ�ÿ���
local function _card_useitem(playerid,itemid,num)

	local carddata=get_carddata( playerid )
	if carddata==nil then return 0 end
	local idconf=card_useid_conf[itemid]
	if idconf==nil then return 0 end
	if CheckGoods( itemid ,1, 1, playerid,'ʹ�ÿ���') == 0 then
		return 0
	end
	local zhang,jie,addnum=idconf[1],idconf[2],idconf[3]--��,��,�ӵ�
	if zhang==nil or jie==nil or addnum==nil then return 0 end
	if carddata[zhang]==nil then 
		carddata[zhang]={}
	end
	local nownum=carddata[zhang][jie] or 0
	if nownum >=100 then return 0 end
	carddata[zhang][jie]=nownum+addnum
	if carddata[zhang][jie]>=100 then
		-- carddata[zhang][jie]=100
		-- local oldlv= card_getsllv( carddata.sl or 0)
		-- carddata.sl=(carddata.sl or 0)+idconf[4]--������ֵ

		local playername=CI_GetPlayerData(3)
		BroadcastRPC('card_all',playername,zhang,jie)
		-- local nowlv=card_getsllv( carddata.sl )
		-- if nowlv>oldlv then
		  _card_upatt(playerid,1)
		--   card_setskill( nowlv+1 )
		-- end

	end
	

	--CheckGoods( itemid ,1, 0, playerid,'����ϵͳ')
	RPC( 'card_one',zhang,jie,carddata[zhang][jie],carddata.sl)	
end
--�����
local function _card_activate(playerid,itemid,num)
	-- look(111)
	local carddata=get_carddata( playerid )
	if carddata==nil then return 0 end
	-- look(444)
	local idconf=card_useid_conf[itemid]
	if idconf==nil then return 0 end
	-- look(3333)
	local zhang,jie,addnum=idconf[1],idconf[2],idconf[3]--��,��,�ӵ�
	if zhang==nil or jie==nil or addnum==nil then return 0 end
	if carddata[zhang]==nil then 
		carddata[zhang]={}
	end
	local nownum=carddata[zhang][jie] or 0
	if nownum >=100 then 
		return 0 
	end
	-- look(0111)
	local max_neednum=_ceil(100-nownum)/addnum
	if num>max_neednum then
		num=max_neednum
	end
	if CheckGoods( itemid ,num, 1, playerid,'�����') == 0 then
		return 0
	end
-- look(011)
	carddata[zhang][jie]=nownum+addnum*num
	if carddata[zhang][jie]>=100 then
		-- carddata[zhang][jie]=100
		-- local oldlv= card_getsllv( carddata.sl or 0)
		-- carddata.sl=(carddata.sl or 0)+idconf[4]--������ֵ

		local playername=CI_GetPlayerData(3)
		BroadcastRPC('card_all',playername,zhang,jie)
		-- local nowlv=card_getsllv( carddata.sl )
		-- if nowlv>oldlv then
		  _card_upatt(playerid,1)
		--   card_setskill( nowlv+1 )
		-- end

	end
	

	CheckGoods( itemid ,num, 0, playerid,'����ϵͳ')
	RPC( 'card_one',zhang,jie,carddata[zhang][jie],carddata.sl)	
end

--��ȡ��װ����
function _card_getattaward( playerid,k )
	-- look('��ȡ��װ����')
	local carddata=get_carddata( playerid )
	local get=carddata.get or 0
	if k-get~=1 then look('111') return end
	local v=carddata[k]

	if type(k)~=type(0) or type(v)~=type({}) then	look('222') return end

	local xinxin_mark=6
	if #v~=xinxin_mark then 
		-- look('333')
		return
	end
	for i,j in pairs(v) do --[1]={}������
		if type(i)==type(0) and type(j)==type(0) then
			if j<100 then
				xinxin_mark=nil
			end
		end
	end
	if xinxin_mark==nil then look('444') return end

	carddata.get=k
	local yb=card_att_conf.extra_Award[k].yb
	-- local sl=card_att_conf.extra_Award[k].sl
	if yb then
		AddPlayerPoints( playerid , 3 , yb , nil,'����')
	end
	-- local oldlv=card_getsllv( carddata.sl or 0 )
	-- carddata.sl=(carddata.sl or 0)+sl--������ֵ
	-- local nowlv=card_getsllv( carddata.sl )
	-- if nowlv>oldlv then
	--   _card_upatt(playerid,1)
	--   card_setskill( nowlv+1 )
	-- end
	RPC( 'card_get',k,carddata.sl)--��ȡ���	
end
--������ǿ�� buy=0����Ǯ,1��Ǯ,auto=1ֱ��������һ��
function card_enhange( playerid,zhang,jie ,buy,lastnum,auto)
	-- look('������ǿ��',1)
	-- look(zhang,1)
	-- look(jie,1)
	-- look(buy,1)
	-- look(lastnum,1)
	-- look(auto,1)
	local carddata=get_carddata( playerid )
	if carddata==nil then return end
	local nownum=carddata[zhang][jie] or 0
	if nownum <100 or  nownum >= 200 then 
		return 
	end
	local nowlv=nownum-100

	local neednum=rint(nowlv/10)*2+2
	local needyb=0
	local addlv=1
	if auto==1 then 
		addlv=10-nowlv%10
		neednum=neednum*addlv
	end
	-- look(2222,1)
	if buy==0 then--����Ǯ
		if 0 == CheckGoods(needid,neednum,1,playerid,'������ǿ��') then
			return
		end
	else --��Ǯ
		if lastnum>0 and lastnum<neednum then 
			if CheckGoods( needid, lastnum, 1, playerid,'������ǿ��') == 0 then
				return
			end
			needyb=(neednum-lastnum)*10
			if not CheckCost(playerid, needyb,1,1) then
				return
			end
		elseif lastnum==0 then 
			needyb=neednum*10
			if not CheckCost(playerid, needyb,1,1) then
				return
			end
		elseif lastnum>=neednum then 
			if CheckGoods( needid, neednum, 1, playerid,'������ǿ��') == 0 then
				return
			end
		else
			return
		end
	end
	-- look(3333,1)
	if buy==0 then--����Ǯ
		if 0 == CheckGoods(needid,neednum,0,playerid,'������ǿ��') then
			return
		end
	else --��Ǯ
		if lastnum==0 then 
			if not CheckCost(playerid, needyb,0,1,'������ǿ��') then
				return
			end
		else
			if lastnum<=neednum then 
				if CheckGoods( needid, lastnum, 0, playerid,'������ǿ��') == 0 then
					return
				end
			else
				if CheckGoods( needid, neednum, 0, playerid,'������ǿ��') == 0 then
					return
				end
			end
			if needyb>0 then 
				if not CheckCost(playerid, needyb,0,1,'������ǿ��') then
					return
				end
			end
		end
	end
	-- look(4444,1)
	carddata[zhang][jie]=nownum+addlv
	if carddata[zhang][jie]==200 then 
		carddata.nsl=(carddata.nsl or 0)+1
		carddata.asl=(carddata.asl or 0)+1
	end
	_card_upatt(playerid,1)
	SendLuaMsg(0,{ids=qh_res,zhang=zhang,jie=jie,lv=carddata[zhang][jie],nsl=carddata.nsl},9)
end


--ǰ̨ʹ�ü��� index=1��1����,2��2����,3��3����
function card_useskill( playerid,index,x,y,gid )
	-- look(111,1)
	-- look(index,1)
	-- look(x,1)
	-- look(y,1)
	-- look(gid,1)
	-- look(111,1)
	local carddata=get_carddata( playerid )
	if carddata==nil or carddata.us==nil or carddata.have==nil then return end
	local buffid=carddata.us[index]
	if buffid==nil then return end
	local nextid=carddata.us[index+1] or 0 -- ������һ������id
	local lv=carddata.have[buffid]
	-- local buffid=363
	-- local nextid=buffid+1 -- ������һ������id
	-- local lv=1

	
	local needbuff=skill_buff_conf.use_buff[index]

	-- if buffid==nil or lv==nil then return end

	if not CI_HasBuff(needbuff) then 	--��buff
		return
	end
	-- look(buffid,1)
	
	if buffid == 361 then --�й�
		__G.PI_SCallMonster(playerid,2,x,y,lv)
	elseif buffid == 362 then
		__G.PI_SCallMonster(playerid,3,x,y,lv)
	elseif buffid == 363 then
		__G.PI_SCallMonster(playerid,4,nil,nil,lv)
	else --���йֵļ���
		if skill_buff_conf.add_buff[buffid][3]==1 then--���Լ�ʩ��
			CI_AddBuff(buffid,0,lv,false)
		else --�Զ���ʩ��
			-- look(gid,1)
			local obj
			if gid==nil then return end
			local gidtype=SI_getgid_Object(gid)
			if gidtype==ScriptGidType.monster then 
				obj=4
			elseif gidtype==ScriptGidType.player then
				obj=1
			else
				return
			end
			local ox, oy, orid, omapgid = CI_GetCurPos(obj,gid)
			local x, y, rid, mapgid = CI_GetCurPos()
			if orid~=rid or omapgid~=mapgid then return end
			local dikangid=skill_buff_conf.add_buff[buffid][4]
			-- look(dikangid,1)
			-- look(obj,1)
			if ((ox-x)^2+(oy-y)^2)^0.5>8 then return end

			if dikangid and obj==1  then
				local dilanglv=0
				

					
				if 1==CI_SelectObject(1,gid) then --���ö���Ϊ��ǰ����
					 dilanglv=CI_GetSkillLevel(4,dikangid)
				end
				CI_SelectObject(2,playerid)--�����Լ�Ϊ��ǰ����(��ԭ)

				-- look(dilanglv,1)
				-- TipCenter('�ֿ��ȼ�='..tostring(dilanglv))

				if _random(1,100)<=dilanglv then --�ֿ��ɹ�
					-- TipCenter('�ֿ��ɹ�')
					--local dikangbuff=skill_buff_conf.add_buff[buffid][5]
					AreaRPC(0,nil,nil,"fs_dk",gid,buffid)
					-- return 
				else
					CI_AddBuff(buffid,0,lv,false,obj,gid)
				end
			
			else
				CI_AddBuff(buffid,0,lv,false,obj,gid)
			end
		end
	end

	CI_DelBuff(needbuff)
	-- look(44,1)
	-- look(index,1)
	if index<3 and nextid>0 then
		if carddata.gl==nil then 
			carddata.gl={}
		end
		local beishu=0
		if index==1 then 
			beishu=2
		else
			beishu=1
		end
		local gl=(carddata.gl[index] or 0)*beishu+20
		-- look(gl,1)
		local rannum=_random(1,100)
		if rannum<=gl then 			
			CI_AddBuff(needbuff+1,0,1,false)
		end
	end
end

--��������
function card_upbuff( playerid,buffid )
	-- look('��������',1)
	local carddata=get_carddata( playerid )
	if carddata==nil  or carddata.nsl==nil then return end
	if carddata.asl==nil then
		carddata.asl=carddata.nsl or 0
	end
	-- look(carddata,1)
	if carddata.have==nil then 
		carddata.have={}
	end
	local nowlv=carddata.have[buffid] or 0
	local nowsl=carddata.nsl or 0
	-- look(nowsl,1)
	if nowsl<1 then return end
	-- look(buffid,1)
	if nowlv>=skill_buff_conf.add_buff[buffid][1] then 
		return 
	end
	carddata.have[buffid]= nowlv+1
	carddata.nsl=nowsl-1
	SendLuaMsg(0,{ids=skill_buff,buffid=buffid,lv=nowlv+1,nsl=carddata.nsl},9)
end
--��������
function card_upgl( playerid,index  )
	local carddata=get_carddata( playerid )
	if carddata==nil  or carddata.nsl==nil then return end
	local nowsl=carddata.nsl or 0
	-- look(nowsl,1)
	if nowsl<1 then return end
	if carddata.gl==nil then 
		carddata.gl={}
	end
	local nowgl=carddata.gl[index] or 0
	carddata.gl[index]= nowgl+1
	carddata.nsl=nowsl-1
	-- look(111,1)
	SendLuaMsg(0,{ids=gl_buff,index=index,lv=carddata.gl[index],nsl=carddata.nsl},9)
end

--�����ϴ��
function card_gorget( playerid ,money)
	local carddata=get_carddata( playerid )
	if carddata==nil   then return end
	if (carddata.asl or 0)>5 then 
		if money==0 then
			if not CheckCost( playerid , needmoney , 0 , 1, "�����ϴ��") then
				return
			end
		elseif money==1 then
			local now=GetPlayerPoints(playerid,3)
			if now==nil then return end 
			if now>=needmoney*5 then
				AddPlayerPoints( playerid , 3 , -needmoney*5 ,nil,'�����ϴ��')
			else
				return
			end
		else
			return
		end
		
	end

	carddata.us={}--��ʹ��
	carddata.gl={}--��ʹ��
	carddata.have={}--��ӵ��
	carddata.nsl=carddata.asl
	CI_UpdateBuffExtra(0,92,0,0)
	SendLuaMsg(0,{ids=xd_buff, nsl=carddata.nsl},9)
end
--װ������
function card_addskill( playerid,index,buffid )
	local carddata=get_carddata( playerid )
	if carddata==nil  or carddata.have==nil then return end
	if carddata.us==nil then 
		carddata.us={}
	end
	if buffid~=0 then
		if carddata.have[buffid]==nil then return end
		local canindex=skill_buff_conf.add_buff[buffid][2]
		if canindex~=index then return end
		if index==1 and carddata.us[index] ==nil then 
			-- look(111,1)
			local a=CI_UpdateBuffExtra(92,0,1,0)
			-- look(a,1)
		end
		carddata.us[index]=buffid
	else
		carddata.us[index]=nil
		if index==1 then 
			local a=CI_UpdateBuffExtra(0,92,0,0)
			 -- look(a,1)
		end
	end
	SendLuaMsg(0,{ids=zb_buff,index=index,buffid=buffid},9)
end



----------------------
card_useitem=_card_useitem
card_upatt=_card_upatt
card_getattaward=_card_getattaward
card_activate=_card_activate

if __debug == false then return end
--������������
function card_cl(playerid)
	local carddata=get_carddata( playerid )
	carddata.sl=nil
	carddata.get=nil
	for i=1 ,10 do
		carddata[i]=nil
	end
end

function card_addsl(playerid)
	local carddata=get_carddata( playerid )
	carddata.sl=1000
	carddata.nsl=1000
	carddata.asl=1000
	SendLuaMsg(0,{ids=gl_buff,nsl=carddata.nsl},9)	
end