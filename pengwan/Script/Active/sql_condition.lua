-- function ac_ver()
	-- return '1.0.0'
-- end
--[[
local ConditionType = {
	equip = 1,		-- װ��
	partic = 2,		-- ����
	rank = 3,		-- ����
	collect = 4,	-- �ռ�
	mount = 5,		-- ����
	heros = 6,		-- ���
	attr = 7,		-- ����
	recharge = 8,	-- ��ֵ���Ѵﵽ
	enviroment = 9,	-- �ı���Ϸ���� ֻ�������eventbuf
	special = 10,	-- ������
	escort = 11,	-- ��������
	boss = 12,		-- boss�
	qibing = 13,	-- ���
	merge = 14,		-- �Ϸ��(����...)
	m_time = 15,	-- ����������������ػ
	xiagou = 16,	-- �޹�
	dbcz = 17,		-- ���ʳ�ֵ
	wing = 18,		-- ����
	djxh - 19,		-- ��������
	nvshen = 20,	--Ů��
}

-- װ���ж�����[1]
local eq_Type = {
	kind = 1,		-- ����
	level = 2,		-- �ȼ�
	quality = 3,	-- Ʒ��
	fj_attr = 4,	-- ��������
	pinfen = 5,		-- ����
	enhance = 6,	-- ǿ��
	jewel = 7,		-- ��ʯ
	suit = 8,		-- ��װ
	zx = 9,			-- ����ǿ��
}

-- ��������[2]
local pa_Type = {
	zyfb = 1,		-- ս�۸���
	card = 2,		-- Ӣ����
	escort = 3,		-- ����	
}

-- ���а���[3]
local rk_Type = {
	cz = 1,			-- ��ֵ����
	cz_eday = 2,	-- ÿ�ճ�ֵ����
	xf = 3,			-- ��������
	xf_eday =4,		-- ÿ����������
	mount = 5,		-- ��������
	hero = 6,		-- �������
	level = 7,		-- ��ɫ�ȼ�����
	fight = 8,		-- ��ɫս��������
	yy = 9,			-- ������
	battle = 10,	-- ս������
	flower = 11,	-- �ʻ���������
	equipQH = 12,	-- װ��ǿ��
	bsnum = 13,		-- ��ʯ�ȼ���
	manorrank = 14,	-- ׯ԰��λ
	qibing = 15,	-- �������
	king = 16,		-- ����
	wing = 17,		-- ����
	king_fac = 18,	-- �������
	czex = 19,		-- ��ֵ+����
}

-- �ռ���[4]
local co_Type = {
	item = 1,		-- �ռ�����
	card = 2,		-- �ռ�Ӣ����
	
}

-- ������[5]
local mo_Type = {
	kind = 1,		-- ����
	level = 2,		-- �ȼ�
	quality = 3,	-- Ʒ��
	gengu = 4,		-- ����
	wuxing = 5,		-- ����
	enhance = 6,	-- ǿ��
	skill = 7,		-- ����	
}

-- �����[6]
local he_Type = {
	kind = 1,		-- ����
	level = 2,		-- �ȼ�
	quality = 3,	-- Ʒ��	
	enhance = 4,	-- ǿ��
	gift = 5,		-- �츳
	skill = 6,		-- ����	
}

-- ��ɫ������[7]
local attr_Type = {
	fight = 1,		-- ս����
	level = 2,		-- ��ɫ�ȼ�
	skill = 3,		-- ����
	wjqs = 4,		-- �侭����
	xinfa = 5,		-- �ķ�
	jingmai = 6,	-- ����
	zfexp = 7,		-- ף������(����)
	fwdegree = 8,	-- ���޺øж�(����)
}

-- ��ֵ������[8]
local rc_Type = {
	cz_dc = 1,		-- ���γ�ֵ
	cz_lj = 2,		-- �ۼƳ�ֵ
	xf_history = 3,	-- ��ʷ������
	cz_eday = 4,	-- ÿ�ճ�ֵ
	xf_eday = 5,	-- ÿ������
	xf_count = 6,	-- ��������
}

-- ��Ϸ�����ı�����[9]
local environType = {
	mon_award = 1,		-- ɱ�־��鱶��


	xunbao = 4,		-- Ѱ���
	zhuanpan = 5,	-- ���˴�ת��
}

-- ������[10]
local special_Type = {
	factionLV = 1,	-- ���ɳ弶
	edayActive = 2,	-- ÿ�ջ�Ծ��
	plat_onetime=3, --360ƽ̨�ȼ��콱 1Ϊ��� 2-100Ϊ����ȼ�,100-200Ϊ��ʿ�ȼ�
	360_everyday=4, --ƽ̨360����ÿ���콱,yy��Աÿ��
	yy_everyday=5, --yy��Աÿ��
	edayLogin = 6,	-- ÿ�յ�½(�жϵȼ�����)
	loginNum = 7, --�ۻ���½����
}

-- ���[13]
local qb_Type = {
	level = 1,		-- �ȼ�
	bh = 2,			-- ����
	bl = 3,			-- ����
}

-- �Ϸ��[14]
local qb_Type = {
	level = 1,		-- �ȼ�����
	zctime = 2,		-- �Ϸ�����	
}

-- ����������������ػ[15]
local times_Type = {
	addtime = 1,		-- ��������
}

-- ����[18]
local wing_Type = {
	level = 1,		-- �ȼ�
	yh = 2,			-- ���
	yl = 3,			-- ����
}

-- ��������
local Award_Type = {
	money = 1,		-- ͭ��
	exps = 2,		-- ����
	item = 3,		-- ����	
}


]]--
local achieve_=require('Script.Achieve.fun')
local get_fundata=achieve_.get_fundata
local active_mgr_m = require('Script.active.active_mgr')
local activitymgr=active_mgr_m.activitymgr
local CheckTimes=CheckTimes
local uv_TimesTypeTb = TimesTypeTb
local GetTimesInfo=GetTimesInfo

-- ��Ӫ���������
ActiveConditionConf = {
	-- �����ж�
	CheckConditions = function ( sid, conditions, dodel )
		if type( conditions ) == 'table' then 					-- conditions = {}
			local ck = nil
			local info
			for k,v in pairs( conditions ) do
				local mainType = rint(k / 100)
				local subType = rint(k % 100)
				if ActiveConditionConf[mainType] ~= nil then	-- k is table's key.
					ck, info = ActiveConditionConf[mainType]( sid, subType, v, dodel )
				else
					ck, info = ( tostring( k ) .. ' ' .. tostring( v ) .. ' : no support!' )
				end
				--if ck ~= true then
				if not ck then
					return 0, info
				end
			end
		else
			return 0
		end		
		return 1
	end,
	
	-- װ��������
	[1] = function (sid, subType, args)
		if subType < 1 or subType > 9 then
			return false
		end
		return true
	end,
	-- ����������
	[2] = function (sid, subType, args)
		if subType < 1 or subType > 3 then
			return false
		end
		return true
	end,
	-- ����������
	[3] = function (sid, subType, args)
		if subType < 1 or subType > 19 then
			return false
		end
		return true
	end,
	-- �ռ������� (��ʱֻ֧�ֵ���(��֧��װ��)�ռ�,����ȫ���۳�����)
	[4] = function (sid, subType, args, dodel)
	
		if subType < 1 or subType > 2 then
			return false
		end
		if type(args) ~= type({}) then
			return false
		end
		if subType == 1 or subType == 2 then	-- �����ռ���
			for itemid, itemnum in pairs(args) do					
				if type(itemid) == type(0) and type(itemnum) == type(0) then
					if not (CheckGoods(itemid, itemnum, 1, sid,'��Ӫ�') == 1 ) then
						return false
					end
				end
			end
			-- ��Ҫ�۳�����
			if dodel then
				for itemid, itemnum in pairs(args) do
					if type(itemid) == type(0) and type(itemnum) == type(0) then
						if not (CheckGoods(itemid, itemnum, 0, sid,'��Ӫ�') == 1 ) then
							return false
						end
					end
				end
			end
		end
		
		return true
	end,
	-- ����������
	[5] = function (sid, subType, args)
		if subType < 1 or subType > 7 then
			return false
		end
		return true
	end,
	-- ���������
	[6] = function (sid, subType, args)
		if subType < 1 or subType > 6 then
			return false
		end
		return true
	end,
	-- ��������������
	[7] = function (sid, subType, args)
		if subType < 1 or subType > 8 then
			return false
		end
		if subType == 1 then						--ս����
			local fightval = CI_GetPlayerData(62)	
			if fightval == nil or fightval <= 0 then return false end 
			if type(args) ~= type(0) or fightval < args then
				return false
			end			
		elseif subType == 7 then
			local lv = CJ_GetLevel(sid,1) or 0
			if type(args) ~= type(0) or lv < args then
				return false
			end 
		elseif subType == 8 then
			local lv = CJ_GetLevel(sid,2) or 0
			look('lvlvlvlv'.. lv,1)
			if type(args) ~= type(0) or lv < args then
				return false
			end 
		end
		return true
	end,
	-- ��ֵ����������
	[8] = function (sid, subType, args)
		if subType < 1 or subType > 6 then
			return false
		end
		if args == nil then
			return false
		end
		if subType == 3 then	-- ��ʷ������
			local consum = GetPlayerPoints( sid , 8 )
			if consum == nil then return false end
			if type(args) ~= type(0) or consum < args then
				return false
			end
		end
		return true
	end,
	-- �ı���Ϸ�������� �����н���
	[9] = function(sid, subType, args)
		return false
	end,	
	-- ������
	[10] = function(sid, subType, args)
		if subType < 1 or subType > 6 then
			return false
		end
		if args == nil then
			return false
		end
		if subType == 1 then		-- ���ɳ弶�
			if type(args) ~= type(0) then
				return false
			end
			local flv=CI_GetFactionInfo(nil,2)
			if flv==nil or flv==0 then 

				return false
			end
			if flv<args then 

				return false
			end
		elseif subType == 2 then	-- ÿ�ջ�Ծ��
			local actPoint = get_fundata(sid)
			if actPoint == nil or actPoint.val == nil then return false end
			if type(args) ~= type(0) or actPoint.val < args then
				return false
			end
		elseif subType == 3 then-- ��ȼ��콱1Ϊ��� 2-100Ϊ����ȼ�,100-200Ϊ��ʿ�ȼ�
			local lv =CI_GetPlayerIcon(0,5)
			if type(args) ~= type(0) or type(lv) ~= type(0) or lv<0 then return end
			if args==1  then--��ʿ�ȼ�ǰ̨�ж�
				if rint(lv/16)~=1 then return end
			elseif args<100  then
				if (lv%16)<args-1 then return end
			end
		elseif subType == 4 then	--ÿ�����
			local plat=_G.__plat
			if plat==101 then --360
				local lv =CI_GetPlayerIcon(0,5)
				if type(args) ~= type(0) or type(lv) ~= type(0) or lv<0 then return end
				if (lv%16)~=args then return end
			end
		elseif subType == 6 then	--ÿ�յ�½(�жϵȼ�)
			local lv = CI_GetPlayerData(1,2,sid)
			if lv == nil or lv <= 0 then return false end 
			if type(args) ~= type(0) or lv < args then
				return false
			end
		end
		return true		
	end,
	-- ���
	[13] = function(sid, subType, args)
		-- look('subType:' .. tostring(subType))
		-- look('args:' .. tostring(args))
		if subType < 1 or subType > 3 then
			return false
		end
		if args == nil then
			return false
		end
		if subType == 1 then		-- ����ȼ�
			local qblv = sowar_getlv(sid)
			if qblv == nil then
				return false
			end
			if type(args) ~= type(0) then
				return false
			end
			if qblv < args then
				return false
			end
		elseif subType == 2 then	-- ����ȼ�
			local bhlv = sowar_getlv(sid,1)
			if bhlv == nil then
				return false
			end
			if type(args) ~= type(0) then
				return false
			end
			if bhlv < args then
				return false
			end
		elseif subType == 3 then	-- ����ȼ�
			local bllv = sowar_getlv(sid,2)
			if bllv == nil then
				return false
			end
			if type(args) ~= type(0) then
				return false
			end
			if bllv < args then
				return false
			end
		end
		return true
	end,
	-- �Ϸ�
	[14] = function(sid, subType, args)
		-- look('subType:' .. tostring(subType))
		-- look('args:' .. tostring(args))
		if subType < 1 or subType > 2 then
			return false
		end
		if args == nil then
			return false
		end
		if subType == 1 then		-- �ȼ�����
			local lv = CI_GetPlayerData(1,2,sid)
			if lv == nil or lv <= 0 then
				return false
			end
			if type(args) ~= type(0) then
				return false
			end
			if lv < args then
				return false
			end
		end
		return true
	end,

	-- ����������
	[15] = function(sid, subType, args)
		-- look('subType:' .. tostring(subType),1)
		-- look(args,1)
		if subType < 1 or subType > 100 then
			return false
		end
		if args == nil then
			return false
		end
		
		if type(args) ~= type(0) then
			return false
		end
		local timeinfo=GetTimesInfo(sid,subType)
		if (timeinfo[1] or 0)<args then 
			return false
		end
		
		return true
	end,
	-- �޹�
	[16] = function(sid, subType, args)
		-- look('subType:' .. tostring(subType),1)
		-- look(args,1)
		if subType == 3 then
			if args == nil then
				return false
			end
			
			if type(args) ~= type(0) then
				return false
			end
			if not  CheckCost( sid , args , 1 , 1, "�޹�") then
				return false
			end
		end
		
		return true
	end,
	[18] = function(sid, subType, args)
		if subType == 1 then
			if type(args) ~= type(0) then
				return false
			end
			local winglv = wing_get_info(sid,1) or 0
			if winglv < args then
				return false
			end
		elseif subType == 2 then
			if type(args) ~= type(0) then
				return false
			end
			local wingyh = wing_get_info(sid,4) or 0
			if wingyh < args then
				return false
			end
		elseif subType == 3 then
			if type(args) ~= type(0) then
				return false
			end
			local wingyl = wing_get_info(sid,3) or 0
			if wingyl < args then
				return false
			end
		end
		
		return true
	end
}


