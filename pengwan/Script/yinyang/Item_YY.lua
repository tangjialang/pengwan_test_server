--[[
file:	Item_YY.lua
desc:	������ϵͳ
author:	wk
update:	2012-12-20
refix:	done by wk
]]--
local look = look
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local yy_changeskill	 = msgh_s2c_def[22][2]	
local yy_changeskill_all	 = msgh_s2c_def[22][3]	
local yy_getskill	 = msgh_s2c_def[22][4]	
--local yy_start	 = msgh_s2c_def[22][5]	
local yy_lvups		 = msgh_s2c_def[22][6]	
local yy_succskill	 = msgh_s2c_def[22][7]	
local yy_changeyy	 = msgh_s2c_def[22][8]	
local yy_onekeysale	 = msgh_s2c_def[22][9]	
local yy_skillbox	 = msgh_s2c_def[22][10]	
local yy_pakage		 = msgh_s2c_def[22][11]	
local yy_getallskill	 = msgh_s2c_def[22][12]	
local storeend	 = msgh_s2c_def[24][2]
local _insert=table.insert
local _random=math.random
local CI_GetPlayerData=CI_GetPlayerData
local BroadcastRPC=BroadcastRPC
local PI_UpdateScriptAtt=PI_UpdateScriptAtt
local CI_UpdateBuffExtra=CI_UpdateBuffExtra
local uv_TimesTypeTb=TimesTypeTb
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos
local ScriptAttType = ScriptAttType
local pairs=pairs
local type=type
local GiveGoods=GiveGoods
local common 			= require('Script.common.Log')
local Log 				= common.Log
local db_module =require('Script.cext.dbrpc')
local db_point=db_module.db_point
---------------------------------------------
--[[  CAT_MAX_HP,	1	// Ѫ������1
CAT_MAX_MP,	2	// ŭ������(Ԥ��)
CAT_ATC,	3	// ����2
CAT_DEF,	4	// ����3
CAT_HIT,	5	// ����4
CAT_DUCK,	6	// ����5
CAT_CRIT,	7	// ����6
CAT_RESIST,	8	// �ֿ�7
CAT_BLOCK,	9	// ��8]]--

local skillend={}--һ��ͨ��õ�������ʱ�洢--Ҫת��Ϊ�洢,����
local miniskillbox=1--���ֿܲ�
local maxskillbox=15
local fight_score={20000,35000}--ս���������ܿ�
local need_money={5000,8000,12000,20000}--����
local one_exp={10,30,60,120,240,480}--�������ܾ���
local giveskill_conf={45,15,10,0}---,���в�������
local SkillTypeConf = {0.2, 1, 1,1.3, 1.3,1.3,1.3,1.3,}--ս��������ֵ
-- local color_conf={---����ɫ����--��,��,��,��,��,��
-- 		[1]={0,0,0,0,0,100},
-- 		[2]={20,33,44,55,77,100}, 
-- 		[3]={33,55,66,77,88,100},
-- 		[4]={22,44,55,66,77,100},
-- 		}
local color_conf={---����ɫ����--��,��,��,��,��,��
	[1]={0,90,100,0,0,0},
	[2]={0,80,99,100,0,0}, 
	[3]={1,63,93,100,0,0},
	[4]={2,12,90,99,100,0},
	}

--��������2-10��
local lvup_skill={
		[1]={100,380,950,1950,3530,5860,9110,13480,19170,},
		[2]={180,670,1690,3470,6290,10430,16220,23990,34100,},
		[3]={450,1690,4250,8720,15770,26140,40620,60060,85350,},
		[4]={960,3610,9050,18550,33540,55570,86340,127650,181400,},
		[5]={2400,9025,22625,46375,83850,138925,215850,319125,453500,},
		[6]={7200,22562,67875,139125,251550,416775,647550,957375,1360500,},
		}
  --��������1-8������
local att_conf={
	[1]={58,11.6,9.28,8.8,8.8,8.8,8.8,8.8,},
	[2]={87,17.4,13.92,13.2,13.2,13.2,13.2,13.2,},
	[3]={174,34.8,27.84,26.4,26.4,26.4,26.4,26.4,},
	[4]={290,58,46.4,44,44,44,44,44,},
	[5]={580,116,92.8,88,88,88,88,88,},
	[6]={1450,290,232,220,220,220,220,220,},
}

--------------------------------	
local function GetDBYYData( playerid )--��������¶���YY������
	local yydata=GI_GetPlayerData( playerid , 'yy' , 400 )
	if yydata == nil then return end 
	if yydata.sbox==nil then 
		--yydata.sbox = {}--���ֿܲ�--���Ӽ���{id��exp����,lock}
		--yydata.score= 0--����
		--yydata.button={1,0,0,0}--��ľˮ����������1��
		--yydata.mark= 0--���������ֿ��ĸ���1Ϊ1��,
		yydata.first= 1--��һ��ͨ��̶�������,֮�������־
	end
	return yydata
end

-- function start_yy(playerid)--��ʼ��
	-- local yyw_data=GetDBYYData( playerid )
	-- SendLuaMsg(0,{ids=yy_start,start=yyw_data},9)	
-- end

--�õ��ɷŵ����ϼ������ֵ---30+=2,40=3,50=4
local function get_bodymax()
	local lv=CI_GetPlayerData(1)
	if lv<30 then
		return 0
	else
		return rint((lv-10)/10)
	end
end
--��⼼�ܰ��������п�λ��0Ϊ������
local function check_skillbox(playerid,site1,site2)
	local r_yydata=GetDBYYData(playerid)
	if r_yydata.sbox==nil then r_yydata.sbox={} end
	local t_data=r_yydata.sbox
	for i=site1,site2 do
		if t_data[i] == nil then			
			return i
		end
	end
	return 0
end

--1�εõ�����
local function getskill(playerid,five)
	--look('1�εõ�����')
	--look(five)
	local t_yydata=GetDBYYData( playerid )
	local site=check_skillbox(playerid,miniskillbox,maxskillbox)
	local add_score=t_yydata.score or 0
	local w_skill=t_yydata.sbox
		local butt=0
		if five==0 then 
			for i=1,5 do
				if t_yydata.button[i]==1 then
					butt=i
				end
			end	
		else
			butt=five
		end
		local n_conf=giveskill_conf[butt]
		local w_color=color_conf[butt]
		local n=_random(1,100)--���в���
		local n_color=_random(1,100)--������ɫ
		for k,v in pairs(w_color) do ----�ж���ɫ����
			if type(k)==type(0) and type(v)==type(0) then
				if n_color<=v then
					n_color=k-1--�õ���ɫֵ
					break
				end
			end
		end
		if n_color==0 then
			w_skill[site]={0,100}--��ɫ���⼼��
			add_score=add_score+butt
			t_yydata.score = add_score
		else
			local randnumber_skill=_random(1,8)
			local skill_id=randnumber_skill*10+n_color--�õ�����id
			if w_skill[site]==nil then
				w_skill[site]={}
			end	
			w_skill[site][1]=skill_id--����

			if t_yydata.first~=nil then 
				w_skill[site][1]=22--��������
				t_yydata.first=nil
			end

			-- w_skill[site][2]=nil--����
			-- w_skill[site][3]=nil--��ʼ0.δ����
			add_score=add_score+butt--����
			t_yydata.score = add_score
			if n_color>=3 then
				local playername = CI_GetPlayerData(5)
				
				BroadcastRPC('yyskill',playername,skill_id)
			end
		end
		SendLuaMsg(0,{ids=yy_succskill,succ=0},9)
		if n>n_conf then----�жϲ��� ��ľˮ����
			t_yydata.button[butt]=0
			t_yydata.button[1]=1--=��һ����
		else
			t_yydata.button[butt]=0
			t_yydata.button[butt+1]=1
			t_yydata.button[1]=1--=��һ����
		end
	SendLuaMsg(0,{ids=yy_getskill,get_skill={site=site,skill=w_skill[site],score=t_yydata.score,five=t_yydata.button}},9)--֪ͨǰ̨�õ����ܣ����ӻ��֣���������
end
--1�εõ�����(һ��ר��)
local function getskill_one(playerid,butt)
	local t_yydata=GetDBYYData( playerid )
	
	local add_score=t_yydata.score or 0
	local w_skill=t_yydata.sbox
	local n_conf=giveskill_conf[butt]
	local w_color=color_conf[butt]
	local n=_random(1,100)--���в���
	local n_color=_random(1,100)--������ɫ
	for k,v in pairs(w_color) do ----�ж���ɫ����
		if type(k)==type(0) and type(v)==type(0) then
			if n_color<=v then
				n_color=k-1--�õ���ɫֵ��0Ϊ��ɫ
				break
			end
		end
	end
	local skill_id
	if n_color==0 then
		skill_id=0
	else
		local randnumber_skill=_random(1,8)
		skill_id=randnumber_skill*10+n_color--�õ�����id	
	end
	local butt_next
	if n>n_conf then----�жϲ��� ��ľˮ����
		butt_next=1--=��һ����
	else
		butt_next=butt+1
	end

	if t_yydata.first~=nil then 
		skill_id=22--��������
		t_yydata.first=nil
	end

	return skill_id,butt,butt_next
end
--һ��ͨ��
local function yy_getall(playerid  )
	local p_yydata=GetDBYYData( playerid )
	local w_skill=p_yydata.sbox
	
	for k,v in pairs(skillend) do
		if v~=nil then
			skillend[k]=nil
		end
	end
	local cost_need--Ǯ������ʶ
	local skill_id --�õ�id
	local butt=1--֮ǰ����
	local butt_next=1--֮������
	local allscore=0--�õ�����
	local needmoney=0--��ҪǮ
	local thistimebutt
	local n_color--������ɫ
	local canget=0--���Եõ���
	local nowget=0--�Ѿ��õ���
	-- local white=0--��ɫ����
	for i=miniskillbox,maxskillbox do
		if w_skill[i]==nil then
			canget=canget+1
		end
	end
	for i=1,5 do
		if p_yydata.button[i]==1 then
			butt=i
			butt_next=i
		end
	end	
	repeat 
		--look('������ѭ��',1)
		if not  CheckTimes(playerid,uv_TimesTypeTb.YY_free,1,-1)  then 
			thistimebutt=butt_next
			if  CheckCost( playerid , needmoney+need_money[butt_next], 1 , 3) then
				skill_id,butt,butt_next=getskill_one(playerid,butt_next)
				if butt_next and skill_id and butt then
					allscore=allscore+butt
					needmoney=needmoney+need_money[thistimebutt]
					
					table.insert(skillend,skill_id)
					nowget=nowget+1
					
				end
			else
				cost_need=true
			end
		else
			skill_id,butt,butt_next=getskill_one(playerid,butt_next)
			if butt_next and skill_id and butt then
				allscore=allscore+butt
				--needmoney=needmoney+need_money[butt_next]
				table.insert(skillend,skill_id)
				nowget=nowget+1
				
			end
		end
	until cost_need or nowget==canget
	if needmoney>0 then	
		if not CheckCost( playerid , needmoney ,0 , 3,'һ��ͨ��') then
			return
		end
	else
		SendLuaMsg(0,{ids=yy_succskill,succ=2},9)
		return
	end
	local m=1
	for i=miniskillbox,maxskillbox do
		if w_skill[i]==nil then
			if skillend[m]==nil then
				break
			end
			if skillend[m]==0 then
				w_skill[i]={0,100}
			else
				w_skill[i]={skillend[m]}
			end
			n_color=skillend[m]%10
			if n_color>=3 then
				local playername = CI_GetPlayerData(5)
				BroadcastRPC('yyskill',playername,skillend[m])
			end
			m=m+1
		end
	end
	
	p_yydata.score=(p_yydata.score or 0)+allscore
	p_yydata.button={1}
	p_yydata.button[butt_next]=1
	-- Log('����.txt','����=='..CI_GetPlayerData(5))
	-- Log('����.txt',skillend)
	SendLuaMsg(0,{ids=yy_getallskill,skillend=skillend,allscore=p_yydata.score,butt=butt_next},9)
	if cost_need==true then
		SendLuaMsg(0,{ids=yy_succskill,succ=2},9)
	end
end

--ȡ�ȼ�
local function get_lvskill(color,_exp)
	local b_exp=lvup_skill[color]
	for k=1,9 do
		if _exp<b_exp[k] then 
			return k
		end	
	end
	return 10
end
--�������Ը���(skill={id,exp},itype=1Ϊ������2�ż��ܣ�-1Ϊȡ�¼���)
local function yy_GetAttribute(playerid,skill,itype)	
	--look('�������Ը���')
	if skill == nil then return end
	local stype = rint(skill[1]/10)	--ȡ��������	
	local color= skill[1]%10			--ȡ������ɫֵ
	local lv = get_lvskill(color,skill[2] or 0)--ȡ���ܵȼ�	
	if stype<9 then
		local tempAtt=GetRWData(1)
		if itype~=-1 then
			

				-- local a=rint((lv + 1)^2 * base*(color+1)^1.5/2.8)--����ֵ
				
				local a=rint((lv + 1)^2 *att_conf[color][stype])

				--a=rint(a/10)*10
				if stype>1 then
					stype=stype+1
				end
				tempAtt[stype]=a
			
		else
			if stype>1 then
				stype=stype+1
			end
			tempAtt[stype]=0
		end
		--look(tempAtt)
		PI_UpdateScriptAtt(playerid,ScriptAttType.DefTalisman)
	-- else
	-- 	local skillid=skill[1]
	-- 	local id=SkillTypeConf[skillid]
	-- 	local findid=id
	-- 	if itype==-1 then--ȡ�¼��ܣ�lv=0
	-- 		lv=0
	-- 		id=0
	-- 	elseif itype==1 then --���ϼ��ܣ��¼�
	-- 		findid=0
	-- 	end
	-- 	local a = CI_UpdateBuffExtra(id,findid,lv,0)
	end
end
--------------------------------------------------------
--�õ��������ܷ�
function YY_Getallscore(playerid)
	local g_yydata=GetDBYYData( playerid )
	if g_yydata ==nil then return  end
	local g_skill=g_yydata.sbox
	if g_skill == nil then return end
	local allmark=0
	for i = 201,208 do
		if g_skill[i] ~= nil then
			local stype = rint(g_skill[i][1]/10)	--ȡ��������	
			local color= g_skill[i][1]%10			--ȡ������ɫֵ
			local lv = get_lvskill(color,g_skill[i][2] or 0)--ȡ���ܵȼ�
			local base=SkillTypeConf[stype]
			
			if color<1 or color>6 or stype<1 or stype>8 then
				look('YY_Getallscore_error',1)
				look(color,1)
				look(stype,1)
				break
			end
			local value=rint((lv + 1)^2 *att_conf[color][stype])

			allmark =allmark+base*value
		end
	end
	return allmark
end
--����ܿ�ս�������ܿ�
function get_fightbox(playerid)
	local g_yydata=GetDBYYData( playerid )
	if g_yydata ==nil then return  end
	local nowscore=YY_Getallscore(playerid)
	local mark=g_yydata.mark or 0
	if mark==2 then

	elseif mark==1 then 
		if nowscore>=fight_score[2] then
			g_yydata.mark=2
		end
	else 
		if nowscore>=fight_score[2] then
			g_yydata.mark=2
		elseif nowscore>=fight_score[1] then
			g_yydata.mark=1
		end
	end

	if nowscore>=30000 then
		set_obj_pos(playerid,5006)

	end
end

--һ��ͨ��+����ͨ��--1.4
function  Judge_getskill (playerid,five)
	 look('һ��ͨ��+����ͨ��--1.4')
	 look(five)
	local p_yydata=GetDBYYData( playerid )
	if p_yydata.button==nil then p_yydata.button={1,0,0,0,0} end
	local site_yy=check_skillbox(playerid,miniskillbox,maxskillbox)
	local p_skilldata=p_yydata.sbox
	if site_yy==0 then
		SendLuaMsg(0,{ids=yy_succskill,succ=3},9)
		 look(33333)
		return
	else
		if five==0 then 
			yy_getall(playerid  )
		else 
			local butt=p_yydata.button
			if butt[five]~=1 then
				 look(22222)
				return 
			end
			if   CheckTimes(playerid,uv_TimesTypeTb.YY_free,1,-1)  then ---------------���
				
				getskill(playerid,five)--��ȡһ�μ���
				
			else----------�����
				if not CheckCost(playerid , need_money[five], 0 , 3) then
					SendLuaMsg(0,{ids=yy_succskill,succ=2},9)
					return
				end
					look("jhjhj")
					getskill(playerid,five)--��ȡһ�μ���
					return
			end
		end
	end
	
	look("dddd")
end	

--������������
function lock_skill(playerid,site,lock)--id����λ��
	local x_yydata=GetDBYYData( playerid )
	local x_skilldata=x_yydata.sbox
	if x_skilldata[site]==nil then--��
		return
	-- elseif x_skilldata[site][1]==0 then--��ɫ
	-- 	return
	elseif lock==1 then
		x_skilldata[site][3]=1
	elseif lock==0 then
		x_skilldata[site][3]=nil	
	else
		return
	end
	SendLuaMsg(0,{ids=yy_getskill,get_skill={site=site,skill=x_skilldata[site]}},9)
end

--�����������ں�
function fuseskill(playerid,a_site,b_site)--����id��������λ�ã�������λ��a->b
	local c_yydata=GetDBYYData( playerid )
	local c_skilldata=c_yydata.sbox
	if c_skilldata[b_site]==nil and c_skilldata[a_site]==nil then
		rfalse("dataerror=1")
		return
	elseif c_skilldata[b_site]~=nil and c_skilldata[a_site]==nil then
		rfalse("dataerror=2")
		return
	elseif c_skilldata[b_site]==nil and c_skilldata[a_site]~=nil then--�����ƶ�
		if b_site <= maxskillbox+1 then
			if a_site > 200 then --ȡ�¼���
				--rfalse("ȡ�¼���1111=="..a_site)
				c_skilldata[b_site]=c_skilldata[a_site]
				c_skilldata[a_site]=nil
				--local _mark=c_skilldata[b_site][2] or 0
				--c_yydata.mark=(c_yydata.mark or 0)-_mark
				yy_GetAttribute(playerid,c_skilldata[b_site],-1)--��������
			else--ֱ�ӻ�λ��
				c_skilldata[b_site]=c_skilldata[a_site]
				c_skilldata[a_site]=nil
			end
				SendLuaMsg(0,{ids=yy_changeskill,a_skill={a_site=a_site,skilla=c_skilldata[a_site]},b_skill={b_site=b_site,skillb=c_skilldata[b_site]}},9)
				return
		elseif a_site>200 then 
			c_skilldata[b_site]=c_skilldata[a_site]
			c_skilldata[a_site]=nil
			SendLuaMsg(0,{ids=yy_changeskill,a_skill={a_site=a_site,skilla=c_skilldata[a_site]},b_skill={b_site=b_site,skillb=c_skilldata[b_site]}},9)
		elseif b_site>200 then --���ϼ���
			--local LV=CI_GetPlayerData( 1 )
			local maxnum=get_bodymax()--�õ��ɷ��ü��������
			local nownum=0
			local a_id=rint(c_skilldata[a_site][1]/10)--ȡa��id
			for i=201,208 do
				if c_skilldata[i]~= nil then
					if i<207 then
						nownum=nownum+1
					end
					local b_id=rint(c_skilldata[i][1]/10)
					if b_id==a_id then
						SendLuaMsg(0,{ids=yy_succskill,succ=4},9)
						return
					end
				end	
			end
			if b_site<207 then --6��������ȼ���ĸ���
				if nownum>=maxnum then
					look('yymaxnumerror',1)
					return
				end
			else --ս�������ĸ���
				-- look('ս�������ĸ���')
				local mark=c_yydata.mark or 0
				-- look(b_site)
				-- look(mark)
				if b_site==207 then 
					if mark<1 then
						return
					end
				else
					if mark<2 then
						return
					end
				end
			end
			-- if a_id>=9 then
			-- 	local b_num=0
			-- 	for i=201,208 do
			-- 		if c_skilldata[i]~= nil then
			-- 			local b_id=rint(c_skilldata[i][1]/10)
			-- 			if b_id>=9 then
			-- 				b_num=b_num+1
			-- 			end
			-- 		end	
			-- 	end
			-- 	if b_num>=2 then
			-- 		SendLuaMsg(0,{ids=yy_succskill,succ=5},9)
			-- 		return
			-- 	end
			-- end
			c_skilldata[b_site]=c_skilldata[a_site]
			c_skilldata[a_site]=nil
			--local _mark=c_skilldata[b_site][2] or 0
			--c_yydata.mark=(c_yydata.mark or 0)+_mark
			yy_GetAttribute(playerid,c_skilldata[b_site],1)--��������
			SendLuaMsg(0,{ids=yy_changeskill,a_skill={a_site=a_site,skilla=c_skilldata[a_site]},b_skill={b_site=b_site,skillb=c_skilldata[b_site]}},9)
			local _color= c_skilldata[b_site][1]%10--ȡb��ɫֵ
			if _color==3 then
				set_obj_pos(playerid,2003)
			elseif _color==4 then
				set_obj_pos(playerid,4004)
			end
			get_fightbox(playerid)--��⿪���ܿ�
		end
	else--��ʼ�ں�
		if a_site <= maxskillbox+1 then
			local a_color= c_skilldata[a_site][1]%10--ȡa��ɫֵ
			local b_color= c_skilldata[b_site][1]%10--ȡb��ɫֵ
			local a_exp=0
			if a_color~=0 then 
				a_exp=(c_skilldata[a_site][2] or 0)+one_exp[a_color]--ȡa exp---{id��exp����,lock}
			else
				a_exp=(c_skilldata[a_site][2] or 0)
			end
			local b_exp=(c_skilldata[b_site][2] or 0)--ȡb_exp
			local lv_befor=get_lvskill(b_color,b_exp)--�ں�ǰb�ȼ�
			if lv_befor>=10 then return end
				c_skilldata[b_site][2]=b_exp+a_exp
				c_skilldata[a_site]=nil
				

			if b_site>200 then
				local lv_now=get_lvskill(b_color,b_exp+a_exp)--�ںϺ�b�ȼ�
				if lv_befor<lv_now then
					yy_GetAttribute(playerid,c_skilldata[b_site],2)--��������===========================ȷ�����
				end
				--c_yydata.mark=(c_yydata.mark or 0)+a_exp
				get_fightbox(playerid)--��⿪���ܿ�
			end
			SendLuaMsg(0,{ids=yy_changeskill,a_skill={a_site=a_site,skilla=c_skilldata[a_site]},b_skill={b_site=b_site,skillb=c_skilldata[b_site]}},9)
		elseif a_site>200 then
			return
		end
	end
end
--һ���ںϣ�����������
function fuseskill_all(playerid,site)
	look('һ���ںϣ�����������')
	if playerid==nil  then 
		return
	end
	local c_yydata=GetDBYYData( playerid )
	local c_skilldata=c_yydata.sbox 
	local GiveGoods = GiveGoods
	local goalskill=c_skilldata[maxskillbox+1]
	if goalskill==nil or goalskill[1]==0 then return end
	for i=miniskillbox,maxskillbox do 
		if c_skilldata[i]~=nil and c_skilldata[i][3]~=1 then--�ҵ����Ժϳɵļ���
			if c_skilldata[i][1]~=0 then--��ͨ����
				local color= c_skilldata[i][1]%10--ȡ��ɫֵ
				local _exp= (c_skilldata[i][2] or 0)+one_exp[color]--ȡ-exp
				goalskill[2]=(goalskill[2] or 0)+_exp

			else--������
				goalskill[2]=(goalskill[2] or 0)+c_skilldata[i][2]
			end
			c_skilldata[i]=nil--��������
		end
	end
	SendLuaMsg(0,{ids=yy_changeskill_all,skilldata=c_yydata.sbox,},9)	
end

--���ֶһ�
function yy_exchange(playerid,id,score_need)

	if id==nil then return end
	
	local g_yydata=GetDBYYData( playerid )
	local g_skill=g_yydata.sbox
	local site=check_skillbox(playerid,miniskillbox,maxskillbox)
	local score=g_yydata.score or 0
	if id<10000 then
		local color=id%10
		if color<3 or color>6 then return end
	end
	--local score_need=(color^2-color)*1000--==================ȷ����ģ�����������
	if site==0 then
		SendLuaMsg(0,{ids=yy_succskill,succ=3},9)
		--TipCenter("�Բ��𣬼��ܰ�������")--֪ͨ��ɫ��������
		return
	elseif score < score_need then
		SendLuaMsg(0,{ids=yy_succskill,succ=6},9)
		-- TipCenter("�Բ��𣬻��ֲ���")--֪ͨ���ֲ���
		return
	end
	if g_skill[site]==nil then
		g_skill[site]={}
	end	
	g_yydata.score=score-score_need
	g_skill[site][1]=id--����
	if id>=10000 then
		g_skill[site][1]=0--����
		g_skill[site][2]=1000--������
	end
	local playername = CI_GetPlayerData(5)


	BroadcastRPC('yyskill',playername,id)
	SendLuaMsg(0,{ids=yy_getskill,get_skill={site=site,skill=g_skill[site],score=g_yydata.score}},9)
	
	-- ���һ���־д�����ݿ�
	local serverID = GetGroupID()
	local account=CI_GetPlayerData(15,2,playerid)
	local rolename=CI_GetPlayerData(5,2,playerid)
	local rolelevel=CI_GetPlayerData(1,2,playerid)
	if type(serverID)~=type(0) or type(account)~=type('') or type(rolename)~=type('') or type(rolelevel)~=type(0) then
		Log('�洢ת��ʧ��.txt','-----------start---------')
		Log('�洢ת��ʧ��.txt',"�ػ��һ�")
		Log('�洢ת��ʧ��.txt',14)
		Log('�洢ת��ʧ��.txt',account)
		Log('�洢ת��ʧ��.txt',rolename)
		Log('�洢ת��ʧ��.txt',debug.traceback())
		Log('�洢ת��ʧ��.txt','-----------end---------')
	end 
--д�����ݿ� ������id���˺ţ���ɫ�������id����ɫ�ȼ���������������ע��Ϣ�����ͣ�ʣ�����
	db_point(serverID,account,rolename,playerid,rolelevel, score_need,"�ػ��һ�",14,g_yydata.score)
	-- look("�ػ��һ�д�����ݿ�")
end

--gm�ӻ���
function addyyscore(playerid,score)
	local j_yydata=GetDBYYData( playerid )
	local j_score=j_yydata.score or 0
	j_score=j_score+score
	j_yydata.score=j_score
	SendLuaMsg(0,{ids=yy_getskill,get_skill={score=j_yydata.score}},9)
end
--��ʼ�����Ը���
function yystart_GetAttribute(playerid,tempbuff)	
	local g_yydata=GetDBYYData( playerid )
	if g_yydata == nil then return end
	local g_skill=g_yydata.sbox
	if g_skill == nil then return end
	local tempAtt=GetRWData(1)
	local buffmark=4
	for i = 201,208 do
		if g_skill[i] ~= nil then
			local stype = rint(g_skill[i][1]/10)	--ȡ��������	
			local color= g_skill[i][1]%10			--ȡ������ɫֵ
			local lv = get_lvskill(color,g_skill[i][2] or 0)--ȡ���ܵȼ�
			if stype<9 then
					-- local a=rint((lv + 1)^2 * base*(color+1)^1.5/2.8)--����ֵ
					
					local a=rint((lv + 1)^2 *att_conf[color][stype])
					--a=rint(a/10)*10
					if stype>1 then
						stype=stype+1
					end
					tempAtt[stype]=a
				
			-- else
			-- 	local id=stype*10+color
			-- 	local id =SkillTypeConf[id] 
			-- 	if buffmark < 6 then
			-- 		tempbuff[buffmark][1]=id
			-- 		tempbuff[buffmark][2]=lv
			-- 		buffmark=buffmark+1
			-- 	end
			end
		end
	end
	return true
end

--itype=1���һ��������,2Ϊ���һ�������ɫ�ػ�֮�ꡣ,3Ϊ���һ�������ɫ�ػ�֮�ꡣ
--numΪ����ֵ
function yy_item_getskill( playerid,itype ,num)
	local t_yydata=GetDBYYData( playerid )
	local site=check_skillbox(playerid,miniskillbox,maxskillbox)
	if site<1 then 
		SendLuaMsg(0,{ids=yy_succskill,succ=3},9)
		return 0
	end
	if itype==1 then
		t_yydata.sbox[site]={0,num}
	elseif itype==2 then
		local id=_random(1,8)*10+3
		t_yydata.sbox[site]={id}
		local playername = CI_GetPlayerData(5)
		BroadcastRPC('yyskill',playername,id)
	elseif itype==3 then
		local id=_random(1,8)*10+4
		t_yydata.sbox[site]={id}
		local playername = CI_GetPlayerData(5)
		BroadcastRPC('yyskill',playername,id)
	elseif itype==4 then
		local id=_random(1,8)*10+5
		t_yydata.sbox[site]={id}
		local playername = CI_GetPlayerData(5)
		BroadcastRPC('yyskill',playername,id)	
	elseif itype==5 then
		local id=_random(1,8)*10+6
		t_yydata.sbox[site]={id}
		local playername = CI_GetPlayerData(5)
		BroadcastRPC('yyskill',playername,id)	
	end

	SendLuaMsg(0,{ids=yy_getskill,get_skill={site=site,skill=t_yydata.sbox[site]}},9)
end
