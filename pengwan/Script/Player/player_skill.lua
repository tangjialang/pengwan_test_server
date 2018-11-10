--[[
file:	playerskill.lua
desc:	玩家技能
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

local needmoney=50--洗点需要的钱

local sk_conf={
		[1]={9,10},--将军
		[2]={19,20},--修仙
		[3]={29,30},--九黎
	}
	
local resistance_conf = {--抵抗技能配置	抵抗：
	[72] = {gradeid = 1, idx = 72, tlv = 0},		--拉近
	[73] = {gradeid = 1, idx = 73, tlv = 0},		--推远
	[74] = {gradeid = 2, idx = 74, tlv = 50},		--减速
	[75] = {gradeid = 2, idx = 75, tlv = 50},		--吸血
	[76] = {gradeid = 2, idx = 76, tlv = 50},		--禁跳
	[77] = {gradeid = 3, idx = 77, tlv = 200},	--减防
	[78] = {gradeid = 3, idx = 78, tlv = 200},	--减攻
	[79] = {gradeid = 3, idx = 79, tlv = 200},	--禁药
	[80] = {gradeid = 3, idx = 80, tlv = 200},	--定身
	[81] = {gradeid = 4, idx = 81, tlv = 500},	--沉默
	[82] = {gradeid = 4, idx = 82, tlv = 500},	--眩晕
	[95] = {gradeid = 4, idx = 95, tlv = 500},	--预留
	[96] = {gradeid = 4, idx = 96, tlv = 500},	--预留
	[97] = {gradeid = 4, idx = 97, tlv = 500},	--预留
	[98] = {gradeid = 1, idx = 98, tlv = 1},	--预留
	[99] = {gradeid = 1, idx = 99, tlv = 1},	--预留
	[100] = {gradeid = 1, idx = 100, tlv = 1},	--预留
	[101] = {gradeid = 1, idx = 101, tlv = 1},	--预留
}

--定义玩家技能点数
local function GetDBskillData( playerid )
	local skillData = GI_GetPlayerData( playerid , "skill" , 60 )
	if nil == skillData then
		return
	end
	if skillData.sk==nil then
		skillData.sk=0--玩家技能点数
		--skillData.sall=0--玩家总的技能点数（洗点时用）
		--skillData.gen=0--玩家天赋点数
		--skillData.gall=0--玩家总的天赋点数（洗点时用）
	end
	-- look(tostring(skillData))
	return skillData
end
--技能判断,只能学一个大招
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
-- 获得当前等级需要的女娲石
local function GetNeededStoneNum(lv, skillid)
	if lv == nil or lv < 0 or type(lv) ~= type(0) or skillid == nil then return end
	local grade = resistance_conf[skillid].gradeid--抵抗心法档次
	if grade == nil then return end
	local needednum = 500
	if grade == 1 then--第一档
		needednum = mathfloor((lv + 1)*2/5) + 10
	elseif grade == 2 then--第二档
		needednum = mathfloor((lv + 1)*3/5) + 20
	elseif grade == 3 then--第三档
		needednum = mathfloor((lv + 1)*6/5) + 30
	elseif grade == 4 then--第四档
		needednum = mathfloor((lv + 1)*4) + 40
	end
	return needednum
end
-- 得到心法抵抗的总等级
local function Get_mindtotallevel(itype)
	local tlv = 0
	local currlv = 0
	for _, v in pairs(resistance_conf) do
		currlv = CI_GetSkillLevel(itype, v.idx)--=============取现在技能等级
		if currlv == nil or currlv < 0 then return end
		tlv = tlv + currlv
		currlv = 0
	end
	look("mind tlv = " .. tostring(tlv))
	return tlv
end
--得到总技能点
local function Get_allskill(lv)
	return mathfloor(lv/2)
end
-- --初始化
-- function Skill_start1(playerid)
	-- if playerid==nil  then return end
	-- local skilldata=GetDBskillData( playerid )
	-- if skilldata==nil or skilldata.sk==nil then return end
	-- SendLuaMsg(0,{ids=Skill_start,nownum=skilldata.sk,gen=skilldata.gen,gall=skilldata.gall},9)
-- end
--洗点 itype=true为转职,不要钱
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
	if level>45 and itype==nil then--45级后收费 
		if money==0 then
			if not CheckCost( playerid , needmoney , 0 , 1, "100023_洗点") then
				return
			end
		elseif money==1 then
			local now=GetPlayerPoints(playerid,3)
			if now==nil then return end 
			if now>=needmoney*5 then
				AddPlayerPoints( playerid , 3 , -needmoney*5 ,nil,'洗点')-----------
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
--激活技能
function Active_Skill(playerid,mark,itype,skillid,send)
	if playerid==nil or itype==nil or skillid==nil or mark==nil then return end
	local skilldata=GetDBskillData( playerid )
	local oldlv=CI_GetSkillLevel(itype,skillid)--=============取现在技能等级
	local needid = 802--女娲石ID
	if oldlv == nil or oldlv < 0 then return end
	if skilldata==nil or skilldata.sk==nil then return end
	
	if mark==0 then--技能
		if skilldata.sk<1 then
			SendLuaMsg(0,{ids=Skill_res,res=0},9)
			look('skillnumerror')
			return
		end
		if not sk_canlearn( itype,skillid) then
			return
		end
	elseif mark==1 then--天赋
		if skilldata.gen == nil or skilldata.gen <1 then
			SendLuaMsg(0,{ids=Skill_res,res=0},9)
			look('geniusnumerror')
			return
		end
	elseif mark==2 then--抵抗心法
		local needednum = GetNeededStoneNum(oldlv, skillid)	--取所需要的女娲石数
		if CheckGoods(needid, needednum, 1, playerid, "女娲石") == 0 then
			SendLuaMsg(0,{ids=Skill_res,res=0},9)
			look('nvwastonenumerror')
			return
		end
		local tlv = Get_mindtotallevel(itype)
		if tlv == nil or tlv < resistance_conf[skillid].tlv then--技能总等级不够
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
			local needednum = GetNeededStoneNum(oldlv, skillid)	--取所需要的女娲石数
			if needednum == nil then return end
			if CheckGoods(needid, needednum, 0, playerid, "升级抵抗心法") == 1 then
				SendLuaMsg(0,{ids=Skill_dikang,itype=itype,skillid=skillid,nownlv=1},9)
			end
		end
	else
		SendLuaMsg(0,{ids=Skill_res,res=1},9)
	end
end
--升级技能
function Set_Skill(playerid,mark,itype,skillid,num)
	if playerid==nil or itype==nil or skillid==nil or mark==nil then return end
	local skilldata=GetDBskillData( playerid )
	local oldlv=CI_GetSkillLevel(itype,skillid)--=============取现在技能等级
	local needid = 802--女娲石ID
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
		local needednum = GetNeededStoneNum(oldlv, skillid)	--取所需要的女娲石数
		if CheckGoods(needid, needednum, 1, playerid, "女娲石") == 0 then
			SendLuaMsg(0, {ids = Slill_res, res = 0}, 9)
				look("nvwastonenumerror")
			return
		end
		local tlv = Get_mindtotallevel(itype)
		if tlv == nil or tlv < resistance_conf[skillid].tlv then--技能总等级不够
			look("levelerror")
			return
		end
	else
		return
	end
	-- local oldlv=CI_GetSkillLevel(itype,skillid)--=============取现在技能等级
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
				if nownlv > 100 then return end	--抵抗心法技能等级上限为100
				
				local needednum = GetNeededStoneNum(oldlv, skillid)	--取所需要的女娲石数
				if needednum == nil then return end
				if CheckGoods(needid, needednum, 0, playerid, "升级抵抗心法") == 1 then
					SendLuaMsg(0, {ids = Skill_dikang, itype = itype, skillid = skillid, nownlv}, 9)
				end
			end
		else
			SendLuaMsg(0,{ids=Skill_res,res=1},9)
		end
end

--一键加点
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
--加技能点数
function Add_Skillnum(playerid,num)
	if playerid==nil or num==nil  then return end
	local skilldata=GetDBskillData( playerid )
	if skilldata==nil or skilldata.sk==nil then return end
	skilldata.sk=skilldata.sk+num 
	SendLuaMsg(0,{ids=Skill_start,nownum=skilldata.sk},9)
end	
--买天赋点数
function Add_geniusnum(playerid)
	if playerid==nil   then return end
	local skilldata=GetDBskillData( playerid )
	if skilldata==nil  then return end
	local lv=skilldata.gall or 0--现在天赋等级
	local need_money=rint((lv+20)^3.5*3/10000)*10000
	local needexp=rint((lv+20)^4*4/10000)*10000
	if not CheckCost( playerid , need_money , 1 , 3, "天赋") then
		--SendLuaMsg(0,{ids=storeend,succ=3},9)
		return
	end
	local nowexp=CI_GetPlayerData( 4 )
	if nowexp<needexp then  return end
	PI_PayPlayer(1,-needexp,0,0,'购买天赋')
	CheckCost( playerid , need_money , 0 , 3, "购买天赋")
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
