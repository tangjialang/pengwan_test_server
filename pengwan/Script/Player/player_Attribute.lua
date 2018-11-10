--[[
file:	player_attribute.lua
desc:	player attribute update
author:	wk
update:	2013-06-01
refix:	done by wk
]]--
--[[
	CAT_MAX_HP		= 1,		// Ѫ������
	CAT_S_ATC  		= 2,		// ְҵ����
	CAT_ATC  		= 3,		// ����
	CAT_DEF			= 4,		// ����
	CAT_HIT  		= 5,		// ����
	CAT_DUCK  		= 6,		// ����
	CAT_CRIT		= 7,		// ����
	CAT_RESIST		= 8,		// �ֿ�
	CAT_BLOCK	  	= 9,		// ��
	CAT_S_DEF1	  	= 10,		// ��ϵ����
	CAT_S_DEF2	  	= 11,		// ��ϵ����
	CAT_S_DEF3	  	= 12,		// ľϵ����
	CAT_MoveSpeed 	= 13,		// �ƶ��ٶ�(Ԥ��)
	CAT_S_REDUCE	= 14,		// ���Լ���

]]--

--[[
	�ű�����������
	1. ����
	2.�����
	3. ���
	4.���
	5.���
	6.��ҩ
	7. �ƺ�
	8. ս������
	9. ������
	10.��
	11. Ů��
	12. ����
	13.ʱװ
	14.����ָ
	15.�����ȼ�
	22. ������
]]--
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local attlookres		 = msgh_s2c_def[15][18]

ScriptAttType = { ------------����c++ʱΪ0-9,��1
	Mounts = 1,
	card = 2,--�����
	heros2 = 3,
	sowar = 4,
	wing = 5,--���
	danyao = 6,
	Title = 7,	
	FitTalisman = 8,
	DefTalisman = 9,
	xiangmolu = 10,--������
	nvpu=11,
	jingmai=12,
	shizhuang=13,
	marry=14,--���
	prestige=15,--�����ȼ�
	Faction = 16,
	yuanshen = 17,--Ԫ��
	lianshen = 18,--����
	wuzhuang = 19, --��װ
	fabao    = 20, --��������
	ysfs  = 21,   --Ԫ��
	fasb  = 22,  -- ������ 
	dragon = 23, --����ϵͳ
	jiezhi = 24, --���ӽ�ָ
}

local look = look
local CI_UpdateScriptAtt,CI_UpdateBuffExtra = CI_UpdateScriptAtt,CI_UpdateBuffExtra
local attnum = 14
local card_=require("Script.card.card_func")
local card_upatt=card_.card_upatt
local wuzhuang = require('Script.wuzhuang.wuzhuang_fun')
local wz_attup = wuzhuang.wz_attup
local fabao = require('Script.fabao.fabao_fun')
local fb_attup = fabao.fb_attup
local fasb = require('Script.ShenBing.faction_func')
local fasb_att = fasb.fasb_att
local dragon = require('Script.ShenBing.dragon_func')
local dragon_get_attup = dragon.dragon_get_attup
local shq_m = require('Script.ShenQi.shenqi_func')
local login_get_attup =  shq_m.login_get_attup

--1-5Ϊ����,6-9Ϊ��� 10-15Ϊ��� 16Ϊ���񴥷�����197
local uv_tempbuff={{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0}}
local ScriptAttType = ScriptAttType
--[[
	CI_UpdateBuffExtra ���¹�������buff
������ 
	--��ʼ����ʽ{{id,level},{},{}}
	--���¸�ʽ(id,checkid,bufflv,checklv)
	ȡ�¼���id=0,checkid=checkid,bufflv=0,checklv=0
	�¼Ӽ���id=id,checkid=0,bufflv=bufflv,checklv=0
	���¼���id=0,checkid=checkid,bufflv=bufflv,checklv=0
	

	
]]--


--[[
	CI_UpdateScriptAtt ���½ű����Ӷ�������
������
	1����table��������{ [���ܱ��]={[���Ա��]=value}}
	2�Ƿ��ǳ�ʼ�� 0 ���ǳ�ʼ�� 1 ��ʼ��
	3����ֵ�����ͣ� 1�ۼӷ�ʽ 2 ���÷�ʽ����֧�ּ���
	4��������:
	
]]--
function PI_UpdateScriptAtt(sid,itype, object)
	local val=2
	if itype == 7 then
		val = 1
	end	
	local atttab = GetRWData(1,true)
	local res
	-- look('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$')
	 -- look(atttab,1)
	if not object then
		res= CI_UpdateScriptAtt(atttab,0,val,itype-1)
	else
		res=CI_UpdateScriptAtt(atttab,0,val,itype-1,object,sid)--��ʧ����ʱ��,�罵ħ¼
	end

	-- debug --

	if __debug then
		for i=1 ,attnum do
			if atttab[i]~=nil then
				look('[debug]CI_UpdateScriptAtt not set nil',1)
				atttab[i]=nil
			end
		end
	end
	return res
end

-- ��ʼ�����нű��������
function GI_SetScriptAttr(sid)

	for i=1 ,#uv_tempbuff do
		uv_tempbuff[i][1]=0
		uv_tempbuff[i][2]=0
	end
	
	local atttab=GetRWData(1)
	local res
	-- 1����ӳƺ�����(�ۼ�)
	res = GetTitleAttr(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,1,ScriptAttType.Title-1)
	end
	-- 2��������
	res = yystart_GetAttribute(sid,uv_tempbuff)--uv_tempbuffû��
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.DefTalisman-1)
	end
	-- 3��ս������
	res = BATTAttribute(sid,uv_tempbuff)--uv_tempbuff����1-5λ
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.FitTalisman-1)
	end
	--4 .���
	res =  sowar_Attribute(sid,uv_tempbuff)--uv_tempbuff����6-9λ
	if res then
		local a=CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.sowar-1)
		-- look(a)
	end
	-- 0������
	res = LoginMountsAtt(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.Mounts-1)
	end
	-- 5 ���
	res = wing_add_attribute(sid,uv_tempbuff)--uv_tempbuff����10-15λ
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.wing-1)
	end
	--6��ҩ
	res = dy_Attribute(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.danyao-1)
	end
	--9 .��
	res =  XML_GetAttribute(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.xiangmolu-1)
	end
	--7.����
	res = card_upatt(sid,nil,uv_tempbuff)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.card-1)
	end
	--Ů��
	res = np_attup(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.nvpu-1)
	end
	--����
	res = AddRWAttvalue(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.jingmai-1)
	end
	--ʱװ
	res = add_loginatt(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.shizhuang-1)
	end
	--���
	res = marry_attup(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.marry-1)
	end
	
	--��Ἴ�ܵȼ�
	res = facskill_attup(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.Faction-1)
	end
	
	--�����ȼ�
	res = prestige_attup(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.prestige-1)
	end

		
	--Ԫ��
	res = yuanshen_attribute(sid,1)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.yuanshen-1)
	end	
	
	--Ԫ�����
	res = ysfs_attribute(sid,1)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.ysfs-1)
	end	
	--����
	res = ls_attup(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.lianshen-1)
	end	
	--Ԫ����װ
	res = wz_attup(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.wuzhuang-1)
	end
	--��������
	res = fb_attup(sid)
	if res then
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.fabao-1)
	end
	--�������
	res = fasb_att(sid, 1)
	if res then 
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.fasb-1)
	end
	--����ϵͳ
	res = dragon_get_attup(sid)
	if res then 
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.dragon-1)
	end
	--��ָ
	res = login_get_attup(sid)
	if res then 
		CI_UpdateScriptAtt(atttab,1,2,ScriptAttType.jiezhi-1)
	end
	-- 8�����¹���buff
	CI_UpdateBuffExtra(uv_tempbuff)
	-- look('8�����¹���buff',1)
	-- look(uv_tempbuff,1)
end

--ս�����Ա�,itype=1����,2װ��
--1
-- 1Ů��
-- 2�ػ�ͨ��
-- 3�����
-- 4������
-- 5�ƺżӳ�
-- 6���Ե�
-- 7������

--2
-- 1��ʯ����
-- 2ʱװ

local att_1={0,0,0,0,0,0,0}
local att_2={0,0}
function att_look( osid,itype )

	if IsPlayerOnline(osid) ~= true then
		TipCenter(GetStringMsg(7))
		return 
	end

	local atttab=GetRWData(1)
	local res

	if itype==1 then
		for k,v in pairs(att_1) do
			att_1[k]=0
		end
		--1Ů��
		res = np_attup(osid)
		if res then
			att_1[1]=get_fightvalue( atttab )
		end
		-- 2��������
		res = yystart_GetAttribute(osid)
		if res then
			att_1[2]=get_fightvalue( atttab )
		end
		--3����
		res = AddRWAttvalue(osid)
		if res then
			att_1[3]=get_fightvalue( atttab )
		end
		--4��
		res =  XML_GetAttribute(osid)
		if res then
			att_1[4]=get_fightvalue( atttab )
		end
		-- 5��ӳƺ�����(�ۼ�)
		res = GetTitleAttr(osid)
		if res then
			att_1[5]=get_fightvalue( atttab )
		end
		--6��ҩ
		res = dy_Attribute(osid)
		if res then
			att_1[6]=get_fightvalue( atttab )
		end
		--7.����
		res = card_upatt(osid)
		if res then
			att_1[7]=get_fightvalue( atttab )
		end
		SendLuaMsg( 0, { ids=attlookres,res=att_1, itype=itype }, 9 )	

	elseif itype==2 then
		for k,v in pairs(att_2) do
			att_2[k]=0
		end
		--1��ʯ����
		res = purify_getlv( playerid)
		if res then---����Ϊ��̨����ֵ,ǰ̨��ȼ���ս����
			att_2[1]=res
		end
		--2ʱװ
		res = add_loginatt(osid)
		if res then
			att_2[2]=get_fightvalue( atttab )

		end
		SendLuaMsg( 0, { ids=attlookres,res=att_2, itype=itype }, 9 )	
	end
end