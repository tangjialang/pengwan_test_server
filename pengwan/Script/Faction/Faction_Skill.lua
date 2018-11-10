--[[
file:	Faction_Skill.lua
desc:	��Ἴ��
update:2013-7-1
refix:	done by xy
]]--

--[[
  	CAT_MAX_HP	= 0,		// Ѫ������1
	CAT_MAX_MP,				// ŭ������(Ԥ��)2
	CAT_ATC,				// ����3
	CAT_DEF,				// ����3
	CAT_HIT,				// ����4
	CAT_DUCK,				// ����5
	CAT_CRIT,				// ����6
	CAT_RESIST,				// �ֿ�7
	CAT_BLOCK,				// ��8
	CAT_AB_ATC,				// �����˺�9
	CAT_AB_DEF,				// ���Է���10
	CAT_CritDam,			// �����˺�11
	CAT_MoveSpeed,			// �ƶ��ٶ�(Ԥ��)12
]]--
--------------------------------------------------------------------------
--include:
local Faction_Skill = msgh_s2c_def[7][6]
local CI_GetPlayerData = CI_GetPlayerData
local CI_GetSkillLevel = CI_GetSkillLevel
local GetPlayerPoints = GetPlayerPoints
local CI_LearnSkill = CI_LearnSkill
local CI_SetSkillLevel = CI_SetSkillLevel
local CI_GetFactionInfo = CI_GetFactionInfo
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos
local fBuild_conf = fBuild_conf
--------------------------------------------------------------------------
-- data:


--��Ἴ������
local fSkill_conf = {
	skillMaxLv = 20,
	spend = {200,400,700,1100,1600,2200,2800,3200,4000,5000,5500,6000,6500,7000,7500,8000,8500,9000,9500,10000},
	skill = {22,23,24,25,26,27,28,29},
	skillAtt = {
		att = {1,3,4,5,6,7,8,9},
		[1] = {1000,2000,3000,4000,5000,6000,7000,8000,9000,10000,11000,12000,13000,14000,15000,16000,17000,18000,19000,20000,21000,22000,23000,24000,},
		[2] = {200,400,600,800,1000,1200,1400,1600,1800,2000,2200,2400,2600,2800,3000,3200,3400,3600,3800,4000,4200,4400,4600,4800,},
		[3] = {160,320,480,640,800,960,1120,1280,1440,1600,1760,1920,2080,2240,2400,2560,2720,2880,3040,3200,3360,3520,3680,3840,},
		[4] = {150,300,450,600,750,900,1050,1200,1350,1500,1650,1800,1950,2100,2250,2400,2550,2700,2850,3000,3150,3300,3450,3600,},
		[5] = {150,300,450,600,750,900,1050,1200,1350,1500,1650,1800,1950,2100,2250,2400,2550,2700,2850,3000,3150,3300,3450,3600,},
		[6] = {150,300,450,600,750,900,1050,1200,1350,1500,1650,1800,1950,2100,2250,2400,2550,2700,2850,3000,3150,3300,3450,3600,},
		[7] = {150,300,450,600,750,900,1050,1200,1350,1500,1650,1800,1950,2100,2250,2400,2550,2700,2850,3000,3150,3300,3450,3600,},
		[8] = {150,300,450,600,750,900,1050,1200,1350,1500,1650,1800,1950,2100,2250,2400,2550,2700,2850,3000,3150,3300,3450,3600,},
	},
}
	
function fs_clear(sid)
	CI_SelectObject(2,sid)
	for i=1,8 do
		local skillID = fSkill_conf.skill[i]
		CI_SetSkillLevel(4,skillID,0);
		look(CI_GetSkillLevel(4,skillID),2)
	end
end

	
local function _GetFSkillData(sid)
	local fskillData=GI_GetPlayerData( sid , 'fskill' , 250 )
	if fskillData == nil then return end
	return fskillData
end

function temp_fskill(sid)
	local skillID
	local maxLv = 0
	local skilllv
	local skillData = _GetFSkillData(sid)
	for i=1,8 do
		skilllv = skillData[i] or 0
		if(skilllv>maxLv)then maxLv = skilllv end
	end
	if(maxLv >= 3)then --Ŀ���ɣ������Ἴ��ѧϰ��3��
		set_obj_pos(sid,2002)
	end
	if(maxLv >= 8)then --Ŀ���ɣ������Ἴ��ѧϰ��8��
		set_obj_pos(sid,5002)
	end
end

function facskill_OnLogin(sid)
	local skillData = _GetFSkillData(sid)
	if(skillData == nil)then return end
	if(skillData.flag == nil) then
		for i=1,8 do
			local skillID = fSkill_conf.skill[i]
			skillData[i] = CI_GetSkillLevel(4,skillID);
			CI_SetSkillLevel(4,skillID,0);
		end
		skillData.flag = true
	end
end

--�������ȼ�
function upFSkill(sid,index)
		
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --��᲻����
	end
	
	local skillData = _GetFSkillData(sid)
	if(skillData == nil)then return false,0 end
	local skilllv = skillData[index] or 0
	
	--look(skillData,1)
	--look(index,1)
	
	--local flv = CI_GetFactionInfo(nil,2) --���ȼ�
	local flv = CI_GetFactionInfo(nil,6) --������Ժ
	
	local maxlv = flv --��ǰ���������ȼ�
	local buildMaxlv = fBuild_conf[3].maxlv

	--look(skilllv..','..maxlv..','..buildMaxlv,2)
	
	if(skilllv>= fSkill_conf.skillMaxLv)then
		return false,3 --���ܵȼ��Ѵ�����
	elseif(skilllv>=maxlv and maxlv<buildMaxlv)then
		return false,2 --��ʾ����������Ժ
	end
		
	local nextlv = skilllv + 1
	local spend = fSkill_conf.spend[nextlv]
	if(spend == nil)then
		return false,4 --���ó���
	end

	local bPoint = GetPlayerPoints(sid,4)
	if(bPoint == nil or bPoint<spend)then
		return false,5 --�ﹱ����
	end
			
	AddPlayerPoints(sid,4,-spend,nil,'��Ἴ��',true)	
	
	skillData[index] = nextlv
	
	if(nextlv == 3)then --Ŀ���ɣ������Ἴ��ѧϰ��3��
		set_obj_pos(sid,2002)
	elseif(nextlv == 8)then --Ŀ���ɣ������Ἴ��ѧϰ��8��
		set_obj_pos(sid,5002)
	end
	
	facskill_attup(sid,1)
	
	return true,nextlv
end
--[[
function SendFSkillData(sid)
	local skillData = GetFSkillData(sid)
	SendLuaMsg( 0, { ids = Faction_Skill,data = skillData}, 9 )
end
]]--

--ˢ�°�Ἴ�ܼӳ�
function facskill_attup(sid,itype)
	local skillData = _GetFSkillData(sid)
	if(skillData == nil)then return false end --û�м�������
	local AttTb = GetRWData(1)
	for i = 1,8 do
		if(skillData[i]~=nil and skillData[i]>0)then
			AttTb[fSkill_conf.skillAtt.att[i]] = fSkill_conf.skillAtt[i][skillData[i]]
		end
	end
	if itype then
		PI_UpdateScriptAtt(sid,ScriptAttType.Faction,AttTb)
	end
	return true 
end