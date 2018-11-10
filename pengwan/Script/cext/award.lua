--[[
file:	award_interface.lua
desc:	����ͨ�ýӿ�
author:	
refix: done by chal
notes:
	1��ͨ�ý�����Ϣ���ɱ�( ������������������������Ӫ����� )
	2�����������жϣ��жϱ����ո�
	3��ͳһ�������ӿ�
args:
	@sid [���sid]
	@AwardTb [ԭʼ�����б�]
	@storeData [�����洢�����������������洢���������������������Ӫ������洢����ʱ��������]
	@extra [���������Ϣ] (������ֵ����������ֻ���Ǹ�ϵ�����С������ַ������������������⴦��)
	@fbID [����������Ҫ�����ֵ]
]]--

-- ��������
-- local Award_Type = {
	-- money = 1,		-- ����
	-- exps = 2,		-- ����
	-- item = 3,		-- ����
	-- bindYB = 4,		-- ��Ԫ��
	-- lingqi = 5,		-- ����
	-- factionGX = 6,	-- ��ṱ��
	-- zhanG = 7,		-- ս��
	-- shengW = 8,		-- ����
	-- titel = 9,		-- �ƺ� {titleID,limitTime}
	-- fid = 10,		-- ����ֻ��������ID���˲����콱
	-- ry = 11,			-- ����ֵ		
	-- LL = 12,			-- ����ֵ
-- }

--[[
	��������
	CSAwards = {					-- �������ؽ���
		Exp = 100000,					-- ����
		Money = 10000,				-- ͭǮ
		sy=1000,        --��Դ
		item = {					-- ������Ʒ
			{ Rate = { 1, 10000 }, ItemID = 627, CountList = { 5, 10 }, IsBind = 1 },--���ǵ�
			{ Rate = { 1, 10000 }, ItemID = 626, CountList = { 5, 10 }, IsBind = 1 },--�ʺ�ʯ
		},
		SpecialProc = {---���⽱���ص�����OnSpAward_1001
		},
		jf=100,-- ��Ӹ���2����--����ֵ
		star={--�Ǽ����⽱��
			[1]={--1��
				_time=120,
				award={--ͨ�ý�������
					[1]=100,
					[3]={{413,1,1},{413,1,1}},
					},
				},
			[2]={--2��
				_time=100,
				award={--ͨ�ý�������
					[1]=100,
					[3]={{413,1,1},{413,1,1}},
					},
				},	
			[3]={--3��
				_time=50,
				award={--ͨ�ý�������
					[1]=100,
					[3]={{413,1,1},{413,1,1}},
					},
				},	
			
			},
		vip={{416,1,1},{416,1,1},{416,1,1},{416,1,1},},--vip���⽱��,v3-4ѡ1
		first={--�״�--ͨ�ý�������
			[1]=100,
			[3]={{413,1,1},{413,1,1}},
			},
		ev_first={--ÿ���״�,ע��:������exp�ȶ���ͬʱ��,��������200����,exp=100,���������100
			[1]=100,
			[3]={{413,1,1},{413,1,1}},
			},
		equip= {
			count	-- [1 ~ 99] ����Ӧ����װ�� [{[1] = 2000,[2] = 10000,...}] �������(���뱣֤ÿ���������и���)
			eqLV 	-- [nil] ������ҵȼ�����Ӧװ��(����������ȡ) [20 ~ 100] װ���ȼ� ÿ10��һ������, 
			quality -- [1 ~ 5] ����ӦƷ��װ�� [{[1] = 2000,[2] = 10000,...}] ���Ʒ��(���뱣֤ÿ��Ʒ�ʶ��и���)
			school	-- [nil] �������ְҵ��װ�� [1] ���ְҵ(ƽ������ 1/3)
			eqType 	-- [nil] �����λ(ƽ������ 1/9) [1 ~ 9] ����Ӧ��λװ�� [{1,5}] ��1~5֮�䲿λ���
			sex  	-- [nil] ��������Ա��װ�� [1] ����Ա�(������) 
						Ҳ����˵���sex==nil�� eqType����ָ��Ϊ1 or 2(��ֻ���������Ч)�� ������Ч
			IsBind 	-- [0] ���� [1] ��
		},
		giveGoods={
			[1] = {{itemID,itemNum,bind},...},  	-- �������κ���Ϣ ����������
			[2] = {									-- װ����(����ְҵ���Ա�)
					[10] = {itemID,itemNum,bind},	-- ������(Ů)
					[11] = {itemID,itemNum,bind},	-- ������(��)
					[20] = {itemID,itemNum,bind},	-- ����(Ů)
					[21] = {itemID,itemNum,bind},	-- ����(��)
					[30] = {itemID,itemNum,bind},	-- ����(Ů)
					[31] = {itemID,itemNum,bind},	-- ����(��)					
				},
			}
			[3] = {									-- װ����(ֻ����ְҵ)
				[1] = {{itemID,itemNum,bind},...},	-- ������
				[2] = {{itemID,itemNum,bind},...},	-- ����
				[3] = {{itemID,itemNum,bind},...},	-- ����
		},
	},

]]
--------------------------------------------------------------------------
--include:
local _G = _G
local TP_FUNC = type( function() end)
local tablepush,tableempty,tablelocate 	= table.push,table.empty,table.locate
local mathrandom 	= math.random
local pairs,ipairs,type,tostring= pairs,ipairs,type,tostring
local define		 = require('Script.cext.define')
local EquipItemInfo = define.EquipItemInfo
local PI_PayPlayer = PI_PayPlayer
local GiveGoods = GiveGoods
local GiveGoodsBatch = GiveGoodsBatch
local look = look
local rint = rint
local CI_GetPlayerData = CI_GetPlayerData
local isFullNum,GetStringMsg,TipCenter = isFullNum,GetStringMsg,TipCenter
--------------------------------------------------------------------------
--interface:
CommonAwardTable = {
	AwardProc = function (sid,AwardTb,storeData,extra,fbID)	
		if sid == nil or AwardTb == nil then return end
		local result = {}
		for k, param in pairs(AwardTb) do
			if k == 'func' then			-- �Զ��庯�����ɽ���
				local foo =  _G[param]
				if type(foo) == TP_FUNC then
					foo(sid,result,fbID)
				end
				break
			end
			if k == 'tab' then
				if type(param) == type({}) then
					result = param		-- �Զ��影����
				end
				break
			end
			local func = CommonAwardTable[k]
			if func ~= nil and type(func) == TP_FUNC then
				func(sid,result,param,extra,fbID)
			end
		end
		
		if storeData  == nil then 
			return result
		else
			storeData.Awd = {
			['fbID'] = fbID,
			['Award'] = result,
		}
		end
		
		return			
	end,
	
	-- ���⽱�� �����һ��ͨ�� �Զ��影������
	-- ����û�õ��Ǽ�ʹ���ÿ���Ҳֻ����Ը���
	-- ���ﲢû�б�֤��ǰAward�б��Ѿ���ʼ���� �������������Ĳ���ֻ���ۼ�
	SpecialProc = function(sid,result,param,extra,fbID)
		local spfunc = 'OnSpAward' .. tostring(fbID)
		if type(spfunc) == TP_FUNC then
			func(sid,result,param,extra)
		end
	end,
	
	-- param = ���� ���������VIP�ȼ��йǸ�
	Exp = function (sid,result,param,extra,fbID)
		if type(param) == 'number' then				
			result[2] = (result[2] or 0) + param
			if fbID then
				local vipLv = GI_GetVIPLevel(sid)
				if vipLv >= 4 then
					result[2] = rint(result[2] * 1.5)
				elseif vipLv >=1 then
					result[2] = rint(result[2] * 1.2)	
				end
			end
		end		
	end,
	
	-- ����ID���ڽ���������Ϊ����ǰ̨�ܴ����жϾ�����ɺ��ٵ����������
	-- param = ����ID
	StoryID = function (sid,result,param,extra)
		if type(param) == type(0) then				
			result.storyid = param			
		end
	end,
	
	-- param = ��ͭǮ���㹫ʽ�йصĲ�����Ϣ
	Money = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[1] = (result[1] or 0) + param			
		end
	end,
	
	-- �ܻ�����������
	cicitem = function(sid,result,param,extra)
		result[3] = result[3] or {}
		if param == nil or tableempty( param ) == nil then return end
		local cctData = GetCircleTaskData(sid)
		if cctData == nil then return end
		for k, v in pairs(param) do
			if cctData.num and cctData.num + 1 == k then
				tablepush(result[3], {v[1], v[2], v[3]} )
			end
		end
	end,
	
	-- param = { Rate = { 1, 10000 }, ItemID = 102, CountList = { 1, 1 }, IsBind = 1 },
	item = function (sid,result,param,extra)
		result[3] = result[3] or {}
		if param == nil or tableempty( param ) then return end
		local r = mathrandom(1, 10000)			-- �������Ϊ��ֱ�
		local count = nil
		for _, itemconf in pairs(param) do
			local chance = itemconf.Rate
			if chance ~= nil and r >= chance[1] and r <= chance[2] then					
				if type(itemconf.CountList) == type({}) then
					count = mathrandom(itemconf.CountList[1], itemconf.CountList[2])
				else
					count = itemconf.CountList
				end
				tablepush(result[3], {itemconf.ItemID, count, itemconf.IsBind} )
			end
		end
	end,
	
	items_one = function (sid,result,param,extra)
		look('items_one',2)
		result[3] = result[3] or {}
		look(#param,2)
		tablepush(result[3], param[math.random(1,#param)])
	end,
	--�Ǽ����⽱��,5��4ѡ1
	star = function (sid,result,param1,extra,fbID)
		-- result[3] = result[3] or {}
		local pCSTemp = CS_GetPlayerTemp(sid)
		if pCSTemp.CopySceneGID==nil then return end
		local copyScene = CS_GetTemp(pCSTemp.CopySceneGID)
		-- local deadnum=(copyScene.deadnum or 0)
		if copyScene==nil then return end
		local usetime=GetServerTime()-  (copyScene.startTime or 0)
		for i=5,1,-1 do
			if param1[i] then 
				if usetime<=param1[i]._time then 
					result.star=i
					--CommonAwardTable.AwardProc(sid,param1[i].award)
					for k, param in pairs(param1[i].award) do
						local func = CommonAwardTable[k]
						if func ~= nil and type(func) == TP_FUNC then
							func(sid,result,param,extra,fbID)
						end
					end
					break
				end
			end
		end
		
	end,
	--�״�--ͨ�ý�������
	first = function (sid,result,param1,extra,fbID)
		local pCSData = CS_GetPlayerData(sid)	
		pCSData.pro = pCSData.pro or {}
		local csType = GetCSType(fbID)
		local max=pCSData.pro[csType] or 0
		if fbID>max then 
			--CommonAwardTable.AwardProc(sid,result,param1)
			result.first=param1
			for k, param in pairs(param1) do
				local func = CommonAwardTable[k]
				if func ~= nil and type(func) == TP_FUNC then
					func(sid,result,param,extra,fbID)
				end
			end

		end
	end,
	-- ������(��Ҫ�������������(װ������ְҵ���Ա�)������ǰ̨��ʾ)
	--[[
		param = {
			[1] = {{itemID,itemNum,bind},...},  	-- �������κ���Ϣ ����������
			[2] = {									-- װ����(����ְҵ���Ա�)
					[10] = {itemID,itemNum,bind},	-- ������(Ů)
					[11] = {itemID,itemNum,bind},	-- ������(��)
					[20] = {itemID,itemNum,bind},	-- ����(Ů)
					[21] = {itemID,itemNum,bind},	-- ����(��)
					[30] = {itemID,itemNum,bind},	-- ����(Ů)
					[31] = {itemID,itemNum,bind},	-- ����(��)					
				},
			}
			[3] = {									-- װ����(ֻ����ְҵ)
				[1] = {{itemID,itemNum,bind},...},	-- ������
				[2] = {{itemID,itemNum,bind},...},	-- ����
				[3] = {{itemID,itemNum,bind},...},	-- ����
			}
			... �����Ժ���չ
	]]--
	giveGoods = function (sid,result,param,extra)
		result[3] = result[3] or {}
		if param == nil or type(param) ~= type({}) or tableempty( param ) then return end
		if param[1] ~= nil then
			for k, item in pairs(param[1]) do
				if type(k) == type(0) and type(item) == type({}) then
					tablepush(result[3], item)
				end
			end
		end
		if param[2] ~= nil then
			local sch = CI_GetPlayerData(2,2,sid)
			local sex = CI_GetPlayerData(11,2,sid)
			if sch == nil or sex == nil then return end
			local index = sch * 10 + sex
			local item = param[2][index]
			if item ~= nil then 
				tablepush(result[3], item)
			end			
		end	
		if param[3] ~= nil then
			local sch = CI_GetPlayerData(2,2,sid)
			if sch == nil then return end
			local itemList = param[3][sch]
			if itemList == nil then return end
			for k, item in pairs(itemList) do
				if type(k) == type(0) and type(item) == type({}) then
					tablepush(result[3], item)
				end
			end
		end
	end,
	
	--[[
	param = {
		count	-- [1 ~ 99] ����Ӧ����װ�� [{[1] = 2000,[2] = 10000,...}] �������(���뱣֤ÿ���������и���)
		eqLV 	-- [nil] ������ҵȼ�����Ӧװ��(����������ȡ) [20 ~ 100] װ���ȼ� ÿ10��һ������, 
		quality -- [1 ~ 5] ����ӦƷ��װ�� [{[1] = 2000,[2] = 10000,...}] ���Ʒ��(���뱣֤ÿ��Ʒ�ʶ��и���)
		school	-- [nil] �������ְҵ��װ�� [1] ���ְҵ(ƽ������ 1/3)
		eqType 	-- [nil] �����λ(ƽ������ 1/9) [1 ~ 9] ����Ӧ��λװ�� [{1,5}] ��1~5֮�䲿λ���
		sex  	-- [nil] ��������Ա��װ�� [1] ����Ա�(������) 
					Ҳ����˵���sex==nil�� eqType����ָ��Ϊ1 or 2(��ֻ���������Ч)�� ������Ч
		IsBind 	-- [0] ���� [1] ��
	}
	]]--
	equip = function (sid,result,param,extra)
		result[3] = result[3] or {}
		if param == nil or type(param) ~= type({}) or tableempty( param ) then return end
		if param.count == nil then return end
		-- 1��ȡ����װ������
		local count = 0
		if type(param.count) == type(0) then
			count = param.count
		elseif type(param.count) == type({}) then
			local rd = mathrandom(1,10000)
			for k, v in ipairs(param.count) do
				if type(v) == type(0) and rd <= v then
					count = k
					break
				end
			end
		end
		if count == 0 then return end
		for i = 1, count do
			-- 2��ȡװ���ȼ�
			local eqLV = nil
			if param.eqLV == nil then
				eqLV = CI_GetPlayerData(1,2,sid)
			elseif type(param.eqLV) == type(0) then
				eqLV = param.eqLV
			end
			eqLV = tablelocate(EquipItemInfo, eqLV, 1)
			if eqLV == nil or EquipItemInfo[eqLV] == nil then
				return
			end
			-- 3��ȡװ��Ʒ��
			local quality = nil
			if param.quality == nil then return end
			if type(param.quality) == type(0) then
				quality = param.quality
			elseif type(param.quality) == type({}) then
				local rd = mathrandom(1,10000)
				for k, v in ipairs(param.quality) do
					if type(v) == type(0) and rd <= v then
						quality = k
						break
					end
				end
			end
			if quality == nil or EquipItemInfo[eqLV][quality] == nil then 
				return
			end
			-- 4��ȡװ��ְҵ
			local school = nil
			if param.school == nil then
				school = CI_GetPlayerData(2,2,sid)
			elseif type(param.school) == type(0) and param.school == 1 then
				school = mathrandom(1,3)
			end
			if school == nil or EquipItemInfo[eqLV][quality][school] == nil then
				return
			end
			local equipTable = EquipItemInfo[eqLV][quality][school]		-- ����װ���ȼ� Ʒ�� ְҵ��λװ��ID��
			-- 5��ȡװ����λ
			local eqType = nil
			if param.eqType == nil then
				eqType = mathrandom(1,9)
			elseif type(param.eqType) == type(0) then
				eqType = param.eqType
			elseif type(param.eqType) == type({}) then
				eqType = mathrandom(param.eqType[1],param.eqType[2])
			end
			if eqType == nil then
				return
			end
			-- 6��ȡװ���Ա�
			local sex = nil
			if param.sex == nil then
				sex = CI_GetPlayerData(11,2,sid)
				if sex == nil then return end
				if eqType == 1 or eqType == 2 then		-- �Ա�ֻ���������Ч
					if sex == 0 then
						eqType = 2
					elseif sex == 1 then
						eqType = 1
					end
				end
			end
			-- 7����λװ��ID
			local equipID = equipTable[eqType]
			-- 8����ӵ������б�
			local binsert = true
			for k, v in pairs(result[3]) do
				if type(k) == type(0) and type(v) == type({}) then
					if v[1] == equipID then
						v[2] = v[2] + 1
						binsert = false
						break
					end
				end
			end
			if binsert then
				tablepush(result[3], {equipID, 1, param.IsBind} )
			end
		end		
	end,
	
	
	-- ͭǮ
	[1] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[1] = (result[1] or 0) + rint(param * (extra or 1))
		end
	end,
	-- ����
	[2] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[2] = (result[2] or 0) + rint(param * (extra or 1))			
		end
	end,
	-- ����
	[3] = function (sid,result,param,extra)
		if type(param) == type({}) then	
			if result[3] == nil then  result[3] = {} end
			for _, item in pairs(param) do							
				tablepush(result[3], item)			
			end
		end
	end,
	-- ��Ԫ��
	[4] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[4] = (result[4] or 0) + rint(param * (extra or 1))			
		end
	end,
	-- ����
	[5] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[5] = (result[5] or 0) + rint(param * (extra or 1))			
		end
	end,
	-- ��ṱ��
	[6] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[6] = (result[6] or 0) + rint(param * (extra or 1))			
		end
	end,
	-- ս��
	[7] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[7] = (result[7] or 0) + rint(param * (extra or 1))			
		end
	end,
	--  ����
	[8] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[8] = (result[8] or 0) + rint(param * (extra or 1))			
		end
	end,
	[11] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[11] = (result[11] or 0) + rint(param * (extra or 1))			
		end
	end,
	[12] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[12] = (result[12] or 0) + rint(param * (extra or 1))			
		end
	end,
	[13] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[13] = (result[13] or 0) + rint(param * (extra or 1))			
		end
	end,
	[14] = function (sid,result,param,extra)
		if type(param) == 'number' then				
			result[14] = (result[14] or 0) + rint(param * (extra or 1))			
		end
	end,
}	

-- ��齱�����ߣ�������
function award_check_items( AwardList, AwardExtra )	
	if nil == AwardList or tableempty(AwardList) then
		return true
	end
	local succ,retCode,nCount
	-- ��������
	if AwardList[3] and type(AwardList[3]) == type({}) then
		if AwardExtra == nil or AwardExtra[3] == nil then
			succ,retCode,nCount = CheckGiveGoods(AwardList[3])			
		else
			local total = {}
			for k, v in ipairs(AwardList[3]) do
				table.insert(total,v)
			end
			for k, v in ipairs(AwardExtra[3]) do
				table.insert(total,v)
			end
			succ,retCode,nCount = CheckGiveGoods(total)
		end
		
		-- look('succ:' .. tostring(succ))
		-- look('retCode:' .. tostring(retCode))
		-- look('nCount:' .. tostring(nCount))
		
		if not succ then
			if (retCode == 3) then					
				local info = GetStringMsg(14,nCount)
				TipCenter(info) 
				return false
			else
				look('award_check_items error[' .. tostring(retCode) .. ']',1)
			end
			
		end
		-- local pakagenum = isFullNum()
		-- if pakagenum < #AwardList[3] then
			-- local info =GetStringMsg(14,#AwardList[3])
			-- TipCenter(info) 
			-- return false
		-- end
	end

	return true
end

-- ͳһ�������ӿ�(���Լ�Щ������¼��־)
-- ����ӿ���ֱ�Ӹ������ˣ��������жϱ�������������
function GI_GiveAward(sid, AwardList, LogInfo)
	if LogInfo == nil then
		look('GI_GiveAward: LogInfo == nil',1)
		return
	end
	if nil == AwardList or tableempty(AwardList) then
		return true
	end
	
	-- ��Ҫ: ������������ж��Ƿ�����������
	if AwardList[10] and AwardList[10] > 0 then
		local fid = CI_GetPlayerData(23,2,sid)
		if fid == nil or fid < 0 then
			return
		end
		if fid ~= AwardList[10] then
			look('GI_GiveAward faction id not match')
			return
		end
	end
	
	-- give goods {itemid,itemnum,isbind}
	-- ���������������� ��Ȼ������
	if AwardList[3] ~= nil then
		-- local succ,retCode,nCount = GiveGoodsBatch( AwardList[3], LogInfo, 2, sid )
		-- if not succ then
		-- 	look("GI_GiveAward erro:" .. tostring(retCode))
		-- 	return false,retCode,nCount
		-- end	
		for k,v in pairs(AwardList[3]) do
			GiveGoods(v[1],v[2],v[3],LogInfo)
		end	
	end
	-- give exp
	local exps = AwardList[2]
	if exps and type(exps) == type(0) then
		PI_PayPlayer(1,exps,0,0,LogInfo)
	end
	
	-- give money
	local money = AwardList[1]
	if money and type(money) == type(0) then
		GiveGoods(0,money,1,LogInfo)
	end
	
	-- ��Ԫ��
	local BDYB = AwardList[4]
	if BDYB and type(BDYB) == type(0) then
		AddPlayerPoints( sid , 3 , BDYB ,nil,LogInfo)
	end
	
	-- ������
	local LQ = AwardList[5]
	if LQ and type(LQ) == type(0) then
		AddPlayerPoints( sid , 2 , LQ,nil,LogInfo )
	end
	
	-- ���ﹱ
	local BG = AwardList[6]
	if BG and type(BG) == type(0) then
		AddPlayerPoints( sid , 4 , BG,nil,LogInfo )
	end
	
	-- ��ս��
	local ZG = AwardList[7]
	if ZG and type(ZG) == type(0) then
		AddPlayerPoints( sid , 6 , ZG,nil,LogInfo )
	end
	
	-- ������
	local SW = AwardList[8]
	if SW and type(SW) == type(0) then
		AddPlayerPoints( sid , 7 , SW,nil,LogInfo )
	end
	
	-- �ƺ� (��Ҫ����ְҵ���Ƿ�����Ч��)
	local title = AwardList[9]
	if type(title) == type({}) then
		local t
		if title[1] then		-- ��ְҵ����
			t = title[1]
		elseif type(title[2]) == type({}) then	-- ��ְҵ���� [1] Ů [2] ��
			local sex = CI_GetPlayerData(11,2,sid)
			if sex and sex >= 0 then
				sex = sex + 1
			end
			t = title[2][sex]
		end
		if type(t) == type(0) then		-- ����
			SetPlayerTitle(sid,t)
		elseif type(t) == type({}) then	-- ��Ч��
			SetPlayerTitle(sid,t[1],t[2])
		end
	end
	
	-- ������ֵ
	local RY = AwardList[11]
	if RY and type(RY) == type(0) then
		AddPlayerPoints( sid , 10 , RY,nil,LogInfo )
	end
	
	-- ������ֵ
	local LL = AwardList[12]
	if LL and type(LL) == type(0) then
		AddPlayerPoints( sid , 11 , LL,nil,LogInfo )
	end
	
	-- ������ֵ
	-- local WW = AwardList[13]
	-- if WW and type(WW) == type(0) then
		-- AddPlayerPoints( sid , 12 , WW,nil,LogInfo )
	-- end
	
	-- ���������ֵ
	local sRY = AwardList[14]
	if sRY and type(sRY) == type(0) then
		AddPlayerPoints( sid , 13 , sRY,nil,LogInfo )
	end
	
	return true
end