--[[
file:	playerskill.lua
desc:	��Ҽ���
author:	wk
update:	2013-03-05
refix:	done by wk
]]--
local tostring,rint,type = tostring,rint,type
local mathfloor = math.floor
local SendLuaMsg,CI_SetSkillLevel 	 = SendLuaMsg,CI_SetSkillLevel
local msgh_s2c_def	 = msgh_s2c_def
local Skill_res		 = msgh_s2c_def[30][1]	
local Skill_start	 = msgh_s2c_def[30][2]	
local Skill_zhiye	 = msgh_s2c_def[30][3]	
local Skill_tianfu	 = msgh_s2c_def[30][4]	
local Skill_dikang	 = msgh_s2c_def[30][6]	
local GI_GetPlayerData=GI_GetPlayerData
local GiveGoods=GiveGoods
local CheckCost=CheckCost
local CheckGoods=CheckGoods
local CI_GetPlayerData=CI_GetPlayerData
local PI_PayPlayer=PI_PayPlayer
local AddPlayerPoints=AddPlayerPoints
local GetPlayerPoints=GetPlayerPoints
local CI_GetSkillLevel=CI_GetSkillLevel
local CI_LearnSkill=CI_LearnSkill
local look = look
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos

local needmoney=50--ϴ����Ҫ��Ǯ

local sk_conf={
		[1]={9,10},--����
		[2]={19,20},--����
		[3]={29,30},--����
	}
	
local resistance_conf = {--�ֿ���������	�ֿ���
	[72] = {gradeid = 1, idx = 72, tlv = 0},		--����
	[73] = {gradeid = 1, idx = 73, tlv = 0},		--��Զ
	[74] = {gradeid = 2, idx = 74, tlv = 50},		--����
	[75] = {gradeid = 2, idx = 75, tlv = 50},		--��Ѫ
	[76] = {gradeid = 2, idx = 76, tlv = 50},		--����
	[77] = {gradeid = 3, idx = 77, tlv = 200},	--����
	[78] = {gradeid = 3, idx = 78, tlv = 200},	--����
	[79] = {gradeid = 3, idx = 79, tlv = 200},	--��ҩ
	[80] = {gradeid = 3, idx = 80, tlv = 200},	--����
	[81] = {gradeid = 4, idx = 81, tlv = 500},	--��Ĭ
	[82] = {gradeid = 4, idx = 82, tlv = 500},	--ѣ��
	[95] = {gradeid = 4, idx = 95, tlv = 500},	--Ԥ��
	[96] = {gradeid = 4, idx = 96, tlv = 500},	--Ԥ��
	[97] = {gradeid = 4, idx = 97, tlv = 500},	--Ԥ��
	[98] = {gradeid = 1, idx = 98, tlv = 1},	--Ԥ��
	[99] = {gradeid = 1, idx = 99, tlv = 1},	--Ԥ��
	[100] = {gradeid = 1, idx = 100, tlv = 1},	--Ԥ��
	[101] = {gradeid = 1, idx = 101, tlv = 1},	--Ԥ��
}

--������Ҽ��ܵ���
local function GetDBskillData( playerid )
	local skillData = GI_GetPlayerData( playerid , "skill" , 60 )
	if nil == skillData then
		return
	end
	if skillData.sk==nil then
		skillData.sk=0--��Ҽ��ܵ���
		--skillData.sall=0--����ܵļ��ܵ�����ϴ��ʱ�ã�
		--skillData.gen=0--����츳����
		--skillData.gall=0--����ܵ��츳������ϴ��ʱ�ã�
	end
	-- look(tostring(skillData))
	return skillData
end
--�����ж�,ֻ��ѧһ������
local function sk_canlearn( itype,skillid)
	local school=CI_GetPlayerData(2)
	-- look(skillid,1)
	local s_one=sk_conf[school][1]
	local s_two=sk_conf[school][2]
	if skillid==s_one then
		local res=CI_GetSkillLevel(itype,s_two)
		if (res or 0)>0 then 
			return
		end
	elseif skillid==s_two then
		local res=CI_GetSkillLevel(itype,s_one)
		if (res or 0)>0 then 
			return
		end
	end
	return true
end
-- ��õ�ǰ�ȼ���Ҫ��Ů�ʯ
local function GetNeededStoneNum(lv, skillid)
	if lv == nil or lv < 0 or type(lv) ~= type(0) or skillid == nil then return end
	local grade = resistance_conf[skillid].gradeid--�ֿ��ķ�����
	if grade == nil then return end
	local needednum = 500
	if grade == 1 then--��һ��
		needednum = mathfloor((lv + 1)*2/5) + 10
	elseif grade == 2 then--�ڶ���
		needednum = mathfloor((lv + 1)*3/5) + 20
	elseif grade == 3 then--������
		needednum = mathfloor((lv + 1)*6/5) + 30
	elseif grade == 4 then--���ĵ�
		needednum = mathfloor((lv + 1)*4) + 40
	end
	return needednum
end
-- �õ��ķ��ֿ����ܵȼ�
local function Get_mindtotallevel(itype)
	local tlv = 0
	local currlv = 0
	for _, v in pairs(resistance_conf) do
		currlv = CI_GetSkillLevel(itype, v.idx)--=============ȡ���ڼ��ܵȼ�
		if currlv == nil or currlv < 0 then return end
		tlv = tlv + currlv
		currlv = 0
	end
	look("mind tlv = " .. tostring(tlv))
	return tlv
end
--�õ��ܼ��ܵ�
local function Get_allskill(lv)
	return mathfloor(lv/2)
end
-- --��ʼ��
-- function Skill_start1(playerid)
	-- if playerid==nil  then return end
	-- local skilldata=GetDBskillData( playerid )
	-- if skilldata==nil or skilldata.sk==nil then return end
	-- SendLuaMsg(0,{ids=Skill_start,nownum=skilldata.sk,gen=skilldata.gen,gall=skilldata.gall},9)
-- end
--ϴ�� itype=trueΪתְ,��ҪǮ
function Skill_kill(playerid,mark,money,itype)

	if playerid==nil or mark==nil or money==nil then return end
	local skilldata=GetDBskillData( playerid )
	local level = CI_GetPlayerData(1)
	if skilldata==nil or skilldata.sk==nil then return end
	if mark==0 then
		if skilldata.sk==mathfloor(level/2) then return end
	else
		if skilldata.gen==skilldata.gall then return end
	end
	if level>45 and itype==nil then--45�����շ� 
		if money==0 then
			if not CheckCost( playerid , needmoney , 0 , 1, "100023_ϴ��") then
				return
			end
		elseif money==1 then
			local now=GetPlayerPoints(playerid,3)
			if now==nil then return end 
			if now>=needmoney*5 then
				AddPlayerPoints( playerid , 3 , -needmoney*5 ,nil,'ϴ��')-----------
			else
				return
			end
		else
			return
		end
	end
	
	if mark==0 then
		skilldata.sk=mathfloor(level/2)
		CI_SetSkillLevel(-1,1,0)
		SendLuaMsg(0,{ids=Skill_zhiye,nownum=skilldata.sk},9)
	else
		skilldata.gen=skilldata.gall
		CI_SetSkillLevel(-2,1,0)
		SendLuaMsg(0,{ids=Skill_tianfu,gen=skilldata.gen},9)
	end
end
--�����
function Active_Skill(playerid,mark,itype,skillid,send)
	if playerid==nil or itype==nil or skillid==nil or mark==nil then return end
	local skilldata=GetDBskillData( playerid )
	local oldlv=CI_GetSkillLevel(itype,skillid)--=============ȡ���ڼ��ܵȼ�
	local needid = 802--Ů�ʯID
	if oldlv == nil or oldlv < 0 then return end
	if skilldata==nil or skilldata.sk==nil then return end
	
	if mark==0 then--����
		if skilldata.sk<1 then
			SendLuaMsg(0,{ids=Skill_res,res=0},9)
			look('skillnumerror')
			return
		end
		if not sk_canlearn( itype,skillid) then
			return
		end
	elseif mark==1 then--�츳
		if skilldata.gen == nil or skilldata.gen <1 then
			SendLuaMsg(0,{ids=Skill_res,res=0},9)
			look('geniusnumerror')
			return
		end
	elseif mark==2 then--�ֿ��ķ�
		local needednum = GetNeededStoneNum(oldlv, skillid)	--ȡ����Ҫ��Ů�ʯ��
		if CheckGoods(needid, needednum, 1, playerid, "Ů�ʯ") == 0 then
			SendLuaMsg(0,{ids=Skill_res,res=0},9)
			look('nvwastonenumerror')
			return
		end
		local tlv = Get_mindtotallevel(itype)
		if tlv == nil or tlv < resistance_conf[skillid].tlv then--�����ܵȼ�����
			look("levelerror")
			return
		end
	else
		return
	end
	local a= CI_LearnSkill(itype,skillid)
	if a==1 then
		if mark==0 then
			skilldata.sk=skilldata.sk-1
			if send==nil then
				SendLuaMsg(0,{ids=Skill_zhiye,itype=itype,skillid=skillid,nownlv=1,nownum=skilldata.sk},9)
			end
		elseif mark==1 then
			skilldata.gen=skilldata.gen-1
			SendLuaMsg(0,{ids=Skill_tianfu,itype=itype,skillid=skillid,nownlv=1,gen=skilldata.gen},9)
		elseif mark==2 then
			local needednum = GetNeededStoneNum(oldlv, skillid)	--ȡ����Ҫ��Ů�ʯ��
			if needednum == nil then return end
			if CheckGoods(needid, needednum, 0, playerid, "�����ֿ��ķ�") == 1 then
				SendLuaMsg(0,{ids=Skill_dikang,itype=itype,skillid=skillid,nownlv=1},9)
			end
		end
	else
		SendLuaMsg(0,{ids=Skill_res,res=1},9)
	end
end
--��������
function Set_Skill(playerid,mark,itype,skillid,num)
	if playerid==nil or itype==nil or skillid==nil or mark==nil then return end
	local skilldata=GetDBskillData( playerid )
	local oldlv=CI_GetSkillLevel(itype,skillid)--=============ȡ���ڼ��ܵȼ�
	local needid = 802--Ů�ʯID
	if oldlv == nil or oldlv < 0 then return end
	if skilldata==nil or skilldata.sk==nil then return end
	
	if mark==0 then
		if skilldata.sk<(num or 1) then
			SendLuaMsg(0,{ids=Skill_res,res=0},9)
				look('skillnumerror')
			return
		end
		if not sk_canlearn( itype,skillid) then
			return
		end
	elseif mark==1 then
		if skilldata.gen == nil or skilldata.gen <1 then
			SendLuaMsg(0,{ids=Skill_res,res=0},9)
				look('geniusnumerror')
			return
		end
	elseif mark==2 then
		local needednum = GetNeededStoneNum(oldlv, skillid)	--ȡ����Ҫ��Ů�ʯ��
		if CheckGoods(needid, needednum, 1, playerid, "Ů�ʯ") == 0 then
			SendLuaMsg(0, {ids = Slill_res, res = 0}, 9)
				look("nvwastonenumerror")
			return
		end
		local tlv = Get_mindtotallevel(itype)
		if tlv == nil or tlv < resistance_conf[skillid].tlv then--�����ܵȼ�����
			look("levelerror")
			return
		end
	else
		return
	end
	-- local oldlv=CI_GetSkillLevel(itype,skillid)--=============ȡ���ڼ��ܵȼ�
	local b=(oldlv or 0)+(num or 1)
		local a=CI_SetSkillLevel(itype,skillid,b)
		if a>0 then
			if mark==0 then
				skilldata.sk=skilldata.sk-(num or 1)
				if num==nil then
					SendLuaMsg(0,{ids=Skill_zhiye,itype=itype,skillid=skillid,nownlv=oldlv+(num or 1),nownum=skilldata.sk},9)
				end	
			elseif mark == 1 then
				skilldata.gen=skilldata.gen-1
				SendLuaMsg(0,{ids=Skill_tianfu,itype=itype,skillid=skillid,nownlv=oldlv+1,gen=skilldata.gen},9)
			elseif mark==2 then
				local nownlv = oldlv + 1
				if nownlv > 100 then return end	--�ֿ��ķ����ܵȼ�����Ϊ100
				
				local needednum = GetNeededStoneNum(oldlv, skillid)	--ȡ����Ҫ��Ů�ʯ��
				if needednum == nil then return end
				if CheckGoods(needid, needednum, 0, playerid, "�����ֿ��ķ�") == 1 then
					SendLuaMsg(0, {ids = Skill_dikang, itype = itype, skillid = skillid, nownlv}, 9)
				end
			end
		else
			SendLuaMsg(0,{ids=Skill_res,res=1},9)
		end
end

--һ���ӵ�
function onekey_skill(playerid, msg )

	local skilldata=GetDBskillData( playerid )
	for k,v in pairs(msg) do --{id,itype,num,mark}
		if type(k)==type(0) and type(v)==type({}) then
			if v[4]==nil then 
				Set_Skill(playerid,0,v[2],v[1],v[3])

			else
				Active_Skill(playerid,0,v[2],v[1],1)	
				if v[3]-1>0 then
					Set_Skill(playerid,0,v[2],v[1],v[3]-1)
				end
			end
		end
	end
	SendLuaMsg(0,{ids=Skill_zhiye,nownum=skilldata.sk,onekey=true},9)
end
--�Ӽ��ܵ���
function Add_Skillnum(playerid,num)
	if playerid==nil or num==nil  then return end
	local skilldata=GetDBskillData( playerid )
	if skilldata==nil or skilldata.sk==nil then return end
	skilldata.sk=skilldata.sk+num 
	SendLuaMsg(0,{ids=Skill_start,nownum=skilldata.sk},9)
end	
--���츳����
function Add_geniusnum(playerid)
	if playerid==nil   then return end
	local skilldata=GetDBskillData( playerid )
	if skilldata==nil  then return end
	local lv=skilldata.gall or 0--�����츳�ȼ�
	local need_money=rint((lv+20)^3.5*3/10000)*10000
	local needexp=rint((lv+20)^4*4/10000)*10000
	if not CheckCost( playerid , need_money , 1 , 3, "�츳") then
		--SendLuaMsg(0,{ids=storeend,succ=3},9)
		return
	end
	local nowexp=CI_GetPlayerData( 4 )
	if nowexp<needexp then  return end
	PI_PayPlayer(1,-needexp,0,0,'�����츳')
	CheckCost( playerid , need_money , 0 , 3, "�����츳")
	skilldata.gen=(skilldata.gen or 0)+1 
	skilldata.gall=lv+1
	if lv+1==10 then
		set_obj_pos(playerid,4001)
	elseif lv+1==30 then
		set_obj_pos(playerid,5001)
	end
	SendLuaMsg(0,{ids=Skill_start,gen=skilldata.gen,gall=skilldata.gall},9)
end	

function skill_chengjiu( playerid )
	local skilldata=GetDBskillData( playerid )
	if skilldata==nil  then return end
	local lv=skilldata.gall or 0
	if lv>=30 then 
		set_obj_pos(playerid,5001)
	end
end
