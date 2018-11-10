--[[
file:	chunjie_active.lua
desc:	����
author:	zhongsx
update:	2015-1-23
]]--


local msg_roll_res 		= msgh_s2c_def[12][41] 	--	{12, 40}
local msg_active_info 	= msgh_s2c_def[12][44]  --  {12, 43}
--
local msg_prize			= msgh_s2c_def[12][42] 	-- 	{12, 41}
local msg_exchange 		= msgh_s2c_def[12][43] 	--  {12, 42}
local msg_login 		= msgh_s2c_def[12][45]  --  {12, 44}
local msg_aim 			= msgh_s2c_def[12][46]  --  {12, 45}
local msg_recharge 		= msgh_s2c_def[12][47]  --  {12, 46}
local update_recharge 	= msgh_s2c_def[12][48]  --  {12, 47}
local msg_seal			= msgh_s2c_def[12][49]	-- 	{12, 28}

local mathrandom, ipairs,pairs, table_push, look = math.random, ipairs, pairs,table.push,look
local os_date, type, GiveGoods, rint, os_time = os.date, type, GiveGoods, rint, os.time
local isFullNum,BroadcastRPC,CheckCost,CheckGoods = isFullNum,BroadcastRPC,CheckCost,CheckGoods
local GetStringMsg,SendLuaMsg, TipCenter, BroadcastRPC =GetStringMsg,SendLuaMsg, TipCenter, BroadcastRPC 
local GetGroupID, DBRPC, IsPlayerOnline = GetGroupID, DBRPC, IsPlayerOnline
local award_check_items = award_check_items
local uv_CommonAwardTable=CommonAwardTable
local IsSpanServer = IsSpanServer
local active_notice_web = active_notice_web
local GI_GiveAward = GI_GiveAward
local tostring = tostring
local GiveGoodsBatch = GiveGoodsBatch
local table_insert = table.insert

local time_cnt = require('Script.common.time_cnt')
local analyze_time = time_cnt.analyze_time
local getdatetime	= time_cnt.getdatetime
local GetTimeThisDay = time_cnt.GetTimeThisDay
local GetTimeToSecond = time_cnt.GetTimeToSecond

local db_module = require('Script.cext.dbrpc')
-- local db_cj_award = db_module.db_cj_award
local db_cj_get_recharge_record = db_module.db_cj_get_recharge_record


-- local time_proc_m = require('Script.active.time_proc')
-- local regist_event_dynamic = time_proc_m.regist_event_dynamic

local fun_module = require('Script.achieve.fun')
local get_fundata = fun_module.get_fundata

local GetTimesInfo = GetTimesInfo
local GetServerTime = GetServerTime
local GetWorldCustomDB = GetWorldCustomDB
local GI_GetPlayerData = GI_GetPlayerData 
local CI_GetPlayerData  = CI_GetPlayerData
local GetWorldLevel = GetWorldLevel

local Log = Log
local AllActiveListConf = AllActiveListConf
local __G = _G
--------------------------------------------
module(...)
--------------------------------------------

--nil ��ʾ��������, 1 ���콱 0 �����콱
--
--[[ �ӻ�Զ���Type
	��½����  			101			
	�ۻ���½���� 		102					
	���ָ������					200		
			--���10�� 				201 		
			--��λ��ʤ��һ�� 	202
			--�ڱ�һ��				203 
			--��Ӹ���2��			204     
			--��������20��		205
			--��Ծ��80				206
			--��Ծ��100 			207
			--��������1��			208
	��ֵ����				301			
	���ֳ齱				401
]]--

--�TYPE ���Զ���type ��Ӧ
local type_conf = {
	[101] = 1000001, 
	[102] = 1000002,
	[200] = 1000003,
	[301] = 1000005,
}

--�趨��̶�����
local active_conf = {
	--��½����
	[1000001] = {
		list = { title = 'ÿ�յ�½����', vIcon = 1030, ver = 0, pic = 0},
		cache = {
			--�ɼ�ʱ��,��ʼʱ�䣬����ʱ�䣬�콱ʱ��
			tView = 0, tBegin = 0,tEnd = 5*24*3600,tAward = 0,
			AwardBuf = {
				[1] = {
					con ={ [1006] = 0 }, --�ж����� ֵΪ��͵ȼ� 
					num = 1,	         --����				
					awd = {
						--��ȡ��Ʒ����key����Ϊ3��ʾ��Ʒ
						--������������Ʒid���������Ƿ��
						[3] = {{1602,2,1},{601,100,1},{603,100,1},{803,50,1},{812,50,1},{625,1,1}},
					},					
				},
			},			
		},
	},
	--���ָ������
	[1000003] = {
		list = { title = '���ָ������', vIcon = 1030, ver = 0, pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 5*24*3600,tAward = 0,
			AwardBuf = {
			--���10��
				[1] = {
					con ={ [1518] = 10 },
					num = 1,					
					awd = {
						[3] = {{1602,1,1}},
					},					
				},
				--���20��
				[2] = {
					con ={ [1518] = 20 },
					num = 1,					
					awd = {
						[3] = {{1602,2,1}},
					},					
				},
				--���30��
				[3] = {
					con ={ [1518] = 30 },
					num = 1,					
					awd = {
						[3] = {{1602,3,1}},
					},					
				},
			--��Ӹ���2��
				[4] = {
					con ={ [1502] = 2 },
					num = 1,					
					awd = {
						[3] = {{1602,2,1}},
					},					
				},
				--��������20��
				[5] = {
					con ={ [1506] = 20 },
					num = 1,					
					awd = {
						[3] = {{1602,2,1}},
					},					
				},
				--��Ծ�ȴﵽ80
				[6] = {
					con ={ [1002] = 80 },
					num = 1,					
					awd = {
						[3] = {{1602,2,1}},
					},					
				},
				--��Ծ�ȵ���100
				[7] = {
					con ={ [1002] = 100 },
					num = 1,					
					awd = {
						[3] = {{1602,3,1}},
					},					
				},
				--����������1��
				[8] = {
					con ={ [1525] = 1 },
					num = 1,					
					awd = {
						[3] = {{1602,2,1}},
					},					
				},
			},			
		},
	},
	--��ɱboss
	[1000004] = {
		list = { title = '��ɱboss', vIcon = 1030, ver = 0, pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 5*24*3600,tAward = 0,
			AwardBuf = {
				[1] = {
					con = {[1201] = 1},
					num = 1,
					awd = {
						[3] = {{1602,1,1},{796,1,1},{752,1,1},{802,1,1},{766,1,1},{765,1,1}},			
					},
				},
			},
		},
	},
	--��ֵ����
	[1000005] = {
		list = { title = '���ʳ�ֵ����',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 5*24*3600,tAward = 0,
			AwardBuf = {
			--200Ԫ��
				[1] = {
				--�����ֵ��ʾ��Χ
					con ={ [1701] = 200,[1702] = 499 },
					num = 999,					
					awd = {
						[3] = {{1602,3,1},},
					      },
					},
				[2] = {
					con ={ [1701] = 500,[1702] = 999 },
					num = 999,					
					awd = {
						[3] = {{1602,8,1},},
					},
				},
				[3] = {
					con ={ [1701] = 1000,[1702] = 1999 },
					num = 999,					
					awd = {
						[3] = {{1602,18,1},{803,30,1},{601,50,1},},
					},
				},
				[4] = {
					con ={ [1701] = 2000,[1702] = 4999 },
					num = 999,					
					awd = {
						[3] = {{1602,40,1},{803,80,1},{601,120,1},},
					},
				},
				[5] = {
					con ={ [1701] = 5000,[1702] = 9999 },
					num = 999,					
					awd = {
						[3] = {{1602,100,1},{803,200,1},{601,300,1},},
					},
				},
				[6] = {
					con ={ [1701] = 10000,[1702] = 19999 },
					num = 999,					
					awd = {
						[3] = {{1602,220,1},{803,450,1},{601,800,1},},
					},
				},
				[7] = {
					con ={ [1701] = 20000, [1702] = 9999999 },
					num = 999,					
					awd = {
						[3] = {{1602,450,1},{803,1000,1},{601,2000,1},},
					},
				},
			},			
		},
	},
	
	--���ڻ �̶�����
	-- [2034] = {
		-- list = { title = '���ڻ', vIcon = 2034, ver = 0, pic = 0 },
		-- cache = {
			-- tView = 0, tBegin = 0,  tEnd =  17 * 24 * 3600 , tAward = 0,
			-- AwardBuf = {
			-- },
		-- },
	-- },
	[2035] = {
		list = { title = '��һ�', vIcon = 2035, ver = 0, pic = 0 },
		cache = {
			tView = 0, tBegin = 0,  tEnd =  5 * 24 * 3600 , tAward = 0,
			AwardBuf = {
			},
		},
	}
}
--[[ --���� == 2 ]]--
local item_conf = {
	award_goods = { --���ֽ�������
		[2] = {
			[50] = {
				{100,{{803,200,1}}}, -- {�������ޣ�{{����id�������������Ƿ��}��{}��{}}}
				{200,{{803,400,1}}},
				{500,{{803,500,1},{802,50,1}}},
				{1000,{{803,500,1},{802,50,1},{796,50,1}}},
				{3000,{{803,1000,1},{802,100,1},{796,100,1}}},
				{5000,{{803,1000,1},{802,200,1},{796,200,1},{2807,1,1}}},
			},
			[60] = {
				{100,{{1601,10,1}}}, -- {�������ޣ�{{����id�������������Ƿ��}��{}��{}}}
				{200,{{1601,50,1}}},
				{500,{{1601,100,1},{802,100,1}}},
				{1000,{{1601,200,1},{802,50,1},{1602,50,1}}},
				{3000,{{763,1,1},{711,1,1},{730,1,1}}},
				{5000,{{764,2,1},{712,2,1},{731,2,1},{601,1000,1}}},
			},
			[70] = {
				{100,{{1601,10,1}}}, -- {�������ޣ�{{����id�������������Ƿ��}��{}��{}}}
				{200,{{1601,50,1}}},
				{500,{{1601,100,1},{802,100,1}}},
				{1000,{{1601,200,1},{802,50,1},{1602,50,1}}},
				{3000,{{763,1,1},{711,1,1},{730,1,1}}},
				{5000,{{764,2,1},{712,2,1},{731,2,1},{601,1000,1}}},
			},
		},
	},
	roll_goods ={ --����齱��������
		[2] = {
				[50] = { --����ȼ�50
					[1]={626,15,1,2300,0},
					[2]={627,15,1,4800,0},
					[3]={803,15,1,7300,0},
					[4]={691,5,1,7800,0},
					[5]={778,3,1,8700,0},
					[6]={802,3,1,9240,0},
					[7]={796,3,1,9500,0},
					[8]={752,1,1,9700,0},
					[9]={710,3,1,9950,0},
					[10]={763,1,1,9980,1},
					[11]={711,1,1,9990,1},
					[12]={730,1,1,10000,1},
				},
				[60] = { --����ȼ�60
					[1]={812,20,1,2000,0},
					[2]={1520,50,1,4500,0},
					[3]={1585,20,1,6500,0},
					[4]={788,10,1,7000,0},
					[5]={821,10,1,8500,0},
					[6]={1520,200,1,8800,0},
					[7]={821,15,1,9300,0},
					[8]={802,10,1,9600,0},
					[9]={1581,5,1,9950,1},
					[10]={763,1,1,9980,1},
					[11]={711,1,1,9990,1},
					[12]={730,1,1,10000,1},
				},
				[70] = { --����ȼ�70
					[1]={812,20,1,2000,0},
					[2]={1520,50,1,4500,0},
					[3]={1585,20,1,6500,0},
					[4]={788,10,1,7000,0},
					[5]={821,10,1,8500,0},
					[6]={1520,200,1,8800,0},
					[7]={821,15,1,9300,0},
					[8]={802,10,1,9600,0},
					[9]={1581,5,1,9950,1},
					[10]={763,1,1,9980,1},
					[11]={711,1,1,9990,1},
					[12]={730,1,1,10000,1},
				},
		},
	},
	dh_goods = { --�һ�����
		[2] = {	--�һ����� {����id���һ���������, ���߶һ����֣����һ�����, �Ƿ��}
				{803,50,500,999,1},
                {812,50,500,999,1}, 
				{601,50,200,999,1}, 
				{2702,1,2000,1,1}, 
				{2803,1,2000,1,1}, 
				{314,1,3000,1,1}, 
				{313,1,3000,1,1}, 
				{2802,1,4000,1,1}, 
				{2708,1,4000,1,1}, 
				{731,1,2000,5,1}, 
				{712,1,2000,5,1}, 
                {764,1,2000,5,1}, 							
		},
	},
	need_goods = { ---�齱�������
		[2] =1602,--- ��������
	},
	need_money = { ---�齱�������ĵ���
		[1]={[1]=10,[10]=10},---51�
		[2]={[1]=20,[10]=20,[20]=20,[30]=20,},--����
	}, 
	login_num_goods = { --�ۻ���½����
		[2] = { --�type
			--3 �ۻ���½���� {} --��ͨ����--�ۻ���ֵ10W����, 
			[3] = {
				{{803,200,1},{1520,500,1},{812,200,1},{636,50,1},{601,200,1},{771,10,1}},  
				{{803,200,1}, {812,200,1}, {601,200,1}} 
			},
			[5] = {
				{{803,300,1},{627,500,1},{812,300,1},{626,500,1},{601,300,1},{821,200,1}},  
				{{1520,1000,1}, {1593,2,1}, {601,500,1}} 
			},
			[7] = {
				{{803,500,1},{796,200,1},{812,500,1},{710,50,1},{601,500,1},{634,100,1}},  
				{{796,200,1}, {636,100,1}, {601,500,1}} 
			},
			[10] = {
				{{803,800,1},{796,300,1},{812,800,1},{762,200,1},{711,1,1},{763,1,1}},  
				{{796,500,1}, {766,20,1}, {601,1000,1}} 
			},
		},
	},
}
---------------------------------------------------------------------------------------
--��ǰ�TYPE �̶����� �����������ϵ����
local CurActiveType = 2
local BeginTime = GetTimeToSecond(2015, 4, 30,0,0,0)
local EndTime = GetTimeToSecond(2015, 5, 4, 23,59,59)
local CurChunJieID = 2035   -- ��ǰ�TYPE
local ActiveDes = "��һ�"

---- ȡ��Ȼ������
local function getNaturalDay(t)
	local sec = rint(t/(24*3600)) * 24 * 3600 - 8*3600
	return sec
end

-- �����������
local function get_chunjie_worlddata()
	local wdata = GetWorldCustomDB()
	if wdata == nil then return end
	--look('��ȡ')
	if wdata.chunjie == nil then wdata.chunjie = {} end
	--[[----------------------
		[mainId] = { 
			[1] = {1000001, 1000002, 1000003, 1000004, 1000005, 1000006}
			[2] = version
			[3] = worldlv
	]]--
	--
	-- update_chunjie_data()

	return wdata.chunjie
end

--ȡ�����Ҿ�������
local function  get_chunjie_data(sid)
	local pdata = GI_GetPlayerData(sid, 'chunjie', 400)
	if pdata == nil then 
		Log("chunjie_log.txt",  "��ȡ"..sid.."��һ���ݱ���")
		return 
	end
	--[[
		[1] = { 
			[1] = 1, 
			[2] = 1,
			[3] = 1, 
			[4] = 1, 
			[5] = 1, 
			[6] = ��ʷ�ۻ���ֵ   
			[7] = 0 ~ 10 ��ڼ��ۻ���½����     
			[8] = �����״ε�½ʱ��
		},
		[2] = {
			[1] = {0~10, 0} 	��ɴ���, �Ƿ���ȡ                    
			[2] = {0~20, 0} 	��ɴ���, �Ƿ���ȡ
			...
		},
		--key ��ȡ����,  num ����ȡ���� 0 or >0    
		[4] = {
				[1] = {num}, 
				[2] = {num}, 
		  },
		[5] = { --�齱
			[1] = score   
			[2] = lv ����ȡ���ֽ����ĵ��� ��ʼΪ0 
			[3] = { {1515, 1},  {1515, 1},  } �Ѷһ����ߺʹ���
		}
		[6] = �mainId.
		[7] = version
		[8] = nil or not nil
	]]
	--pdata = pdata or {}
	return pdata
end

-----inner
--�������ʱ��
local function check_time()
	local ret = false
	local mainId = CurChunJieID
	local cache = __G.AllActiveListConf.cache
	--���һ
	local tNow = GetServerTime()
	local tBegin = BeginTime
	local tEnd = EndTime
	if  tNow > tBegin and tNow < tEnd then 
		ret = true
	end
	--����
	if ret == true and cache[mainId] == nil then
	 	update_chunjie_data()
	end

	return ret
end

--��Զ���itype ����mainId
local function get_chunjie_type(mainId)
	local itype
	for key, value in pairs(type_conf) do
		if mainId == value then 
			itype = key
			break
		end
	end
	return itype
end

local function get_player_time(sid, cache, timtb)
	--elseif  subtype == 1006 then  --ÿ�յ�½	
	local pdata = get_chunjie_data(sid)
	local fundata  = get_fundata(sid)
	--������������, �����������
	local stype, index
	local subtype, maintype
	local tmp 
	--
	for __, value in pairs(timtb) do
		--
		tmp = get_chunjie_type(value[3])
		if tmp ~= nil then
			index = rint( tmp / 100)
			stype = value[1]
			maintype =  rint(stype /100)
			subtype = rint(stype % 100)
			----��Ծ��
			if maintype == 10 and  subtype == 2  then 
				pdata[index] = pdata[index] or {}
				pdata[index][value[4]] = pdata[index][value[4]] or {}
				pdata[index][value[4]][1] = fundata.val 
			
				if pdata[index][value[4]][2] == nil then  --û����������
					--�������
					if fundata.val ~= nil and fundata.val >= value[2] then --��������
						pdata[index][value[4]][2] = 0
					end
				end
			elseif maintype == 15 then 
		-- subtype == 1518 then	--������
		-- subtype == 1563 then	--�ڱ�����
		-- subtype == 1502 then	--��Ӹ���
		-- subtype == 1525 then	--������Ů
				local timesCache, timesStore = GetTimesInfo(sid,  subtype)
				pdata[index] = pdata[index] or {}
				pdata[index][value[4]] = pdata[index][value[4]]  or {}
				pdata[index][value[4]][1]  = timesCache[1]
				if pdata[index][value[4]][2] == nil then
					if (timesCache[1] or 0) >= value[2] then
						pdata[index][value[4]][2] = 0
					end
				end
			-- elseif maintype == 80 then 
			-- 	if subtype == 2 then 
			-- 		pdata[1][6] = CI_GetPlayerData(27) or 0 --��ʷ�ۼƳ�ֵ
			-- 	end
			end
		end
	end
end

--��ȡ�MainId ��������
local function  get_active_mainId( itype)
	if itype == nil or type(itype) ~= type(0) then 
		--Log("chunjie_log.txt",  "get_active_mainId ��������ȷ")
		return 
	end
	local subtype = 1
	if itype > 200 and itype < 300 then 
		subtype = rint(itype % 200)
		itype = 200
	elseif itype > 300 and itype < 400 then 
		subtype = rint(itype % 300)
		itype = 301
	end
	return type_conf[itype], subtype
end

--��¼����Ƿ��ۻ���½����
local function record_login_num(plogin,  tNow)
	local loginTime = plogin[8] or 0
	if tNow < loginTime then  return end
	--��һ�ε�½ plogin �� 0
	if loginTime == 0 then
		plogin[8] = tNow
		plogin[1] = 0 -- (0��ʾ�����콱)
		plogin[7] = (plogin[7] or 0) +  1 --��һ�ε�½
	else
		-- ÿ������ʱ
		--��½ʱ�������������1��Ƚ�
		local function sub_time(h, m, s, tim)
			return GetTimeThisDay(tNow, h, m, s) - tim
		end
		local sub = sub_time(0, 0, 1, loginTime)
		if  sub > 0 then  --��һ���½
			plogin[1] = 0 -- (0��ʾ�����콱)
			plogin[8] = tNow  
			plogin[7] = plogin[7]  + 1 --��һ�ε�½
		end
	end	
	--���ÿ�����ȡ�ۻ���¼
	if plogin[2] ~= 1 and plogin[7] == 3 then 
		plogin[2] = 0 
	elseif plogin[3] ~= 1 and plogin[7] == 5 then
		plogin[3] = 0
	elseif plogin[4] ~= 1 and plogin[7] == 7 then 
		plogin[4] = 0
	elseif plogin[5] ~= 1 and plogin[7] == 10 then
		plogin[5] = 0
	end
end

--�ѻ������ű������б���
local function insert_active_cache(mainID, active)
	local baseTime = BeginTime
	local now = GetServerTime()
	if  now < (active.cache.tBegin + baseTime)
						or  now > (active.cache.tEnd + baseTime) then return end
	
	local list = __G.AllActiveListConf.list
	local cache = __G.AllActiveListConf.cache
	if list == nil or cache == nil then return end	
	list[mainID] = active.list
	cache[mainID] = {}
	cache[mainID].tView 	= os_date('%Y-%m-%d %H:%M:%S', baseTime + active.cache.tView)
	cache[mainID].tBegin 	= os_date('%Y-%m-%d %H:%M:%S', baseTime + active.cache.tBegin)
	cache[mainID].tEnd 		= os_date('%Y-%m-%d %H:%M:%S', baseTime + active.cache.tEnd)
	cache[mainID].tAward 	= os_date('%Y-%m-%d %H:%M:%S', baseTime + active.cache.tAward)
	cache[mainID].AwardBuf = active.cache.AwardBuf
	-- look(cache[mainID])
	--�¼�
	if active.cache.EventBuf then
		local t = active.cache.EventBuf
		local evtb = {}
		-- �����Ӻ�һ���ӵ����а�����			
		local begtm = os_date('*t', baseTime + active.cache.tBegin + 60)	
		local engtm = os_date('*t', baseTime +  active.cache.tEnd + 60)
		local bt = {begtm.year,begtm.month,begtm.day,begtm.hour,begtm.min,begtm.sec}
		local et = {engtm.year,engtm.month,engtm.day,engtm.hour,engtm.min,engtm.sec}
		evtb.Date = {bt,et}
		evtb.arg = t.arg			
		regist_event_dynamic(evtb, now, mainID)
	end
end

--�ӽű������б���ȥ�����Ϣ
local function  delete_active_cache(mainID)
	local list = __G.AllActiveListConf.list
	local cache = __G.AllActiveListConf.cache
	for k, vec in pairs(list) do
		if k == mainID then
			list[k] = nil
			cache[k] = nil
			break
		end
	end
end

-- ʵ�ʳ齱�㷨
local function roll_random(sid, need_item, need_money, goods_conf, times, buy)
	local pakagenum, name, goodsid, rand 
	local finaldata = {}
	local flag = 0
	buy = (buy ~= nil) and buy or 1 
	for i =1,times do
		 --�жϱ����ռ�
		 pakagenum = isFullNum() 
		if 1 > pakagenum  then 
			TipCenter(GetStringMsg(14,1))
			break
		end
		--�ж��Ƿ���ϳ齱���� ���۳���Ʒ
		if buy == 0 then 
			if 0 == CheckGoods(need_item, 1, 0, sid,  ActiveDes..'��齱 ')  then 
				flag = -1  --��������
				break 
			end
		elseif buy==1 then 
			if not need_item or 0 == CheckGoods(need_item,1, 0,sid,  ActiveDes..'��齱  ') then 
				if not (CheckCost(sid, need_money,0, 1,  ActiveDes..'��齱 ')) then  
					flag = -1  --��������
					break 
				end
			end	
		else
			break
		end
		--�������ջ�ȡ������Ϣ
		local function updatefinaldata(key, good) 
			local tmp = false
			for i, v in pairs(finaldata) do
				if v[1] == key then 
					v[2] = v[2] + 1
					tmp = true
					break
				end
			end
			if not tmp then 
				table_push(finaldata, {key, 1})
			end
		end
		--����齱
		rand = mathrandom(10000)
		for j, k in ipairs(goods_conf) do
			if rand <= k[4] then
				goodsid = k[1]
				--look("goodsid = " .. goodsid)
				GiveGoods(goodsid, k[2], k[3], ActiveDes..'��齱 ����')
				if k[5] == 1 then							--�ж��Ƿ��ǹ�����Ʒ
					name = CI_GetPlayerData(3)				--��ȡ�������
					--insert_award_luckroll(name, goodsid,  k[2], itype)	--��������
					BroadcastRPC('luck_roll', goodsid, name,  k[2], 8)  --ȫ���㲥
				end
				--finaldata[j] = k[2] + (finaldata[j] or 0)
				--table_push(finaldata, j)
				updatefinaldata(j, k)
				break
			end
		end
		flag = flag + 1   --���ʵ�ʳ齱�Ĵ���
	end	
	return flag, finaldata
end

-------------
--������
local _award = {}
--���콱����Ʒ��Ϣ
local function get_login_award(pchunjie, index, flag1, flag2)
	--
	if not flag1 then return end
	--��ս�����
	for k, v in pairs(_award) do
		_award[k] = nil
	end
	--
	local itype = CurActiveType
	--indexת��
	local num = 0
	if index == 1 then return end
	if index == 2 then 
		num = 3
	elseif index == 3 then 
		num = 5 
	elseif index == 4 then
		num = 7
	elseif index == 5 then
		num = 10
	else
		return 
	end
	--
	--award1 �ۼƵ�½�콱
	--award2 ����Ľ�����Ʒ 
	--���影��
	_award[3] = {}
	local award1 = item_conf.login_num_goods[itype][num][1]
	--�ѽ����ŵ���������
	for ___, v in pairs(award1) do
		table_push(_award[3], v)
	end
	local award2 
	if flag2 then  
		award2 = item_conf.login_num_goods[itype][num][2]
		for ___, v in pairs(award2) do
			table_push(_award[3], v)
		end 
	end

	return _award
end

--��ȡ�洢��������
local function get_db_limit(sid, mainID, subID)
	-- �洢���������ж�
	local serverid = GetGroupID()
	local account = CI_GetPlayerData(15)	
	local stype = nil
	local beg_val = nil
	local end_val = nil
	local con_val = nil
	local cache = __G.AllActiveListConf.cache
	local beg_time = cache[mainID].tBegin
	local end_time = cache[mainID].tEnd
	local awd_time = cache[mainID].tAward
	local AwardTb = cache[mainID].AwardBuf[subID]
	for key, v in pairs(AwardTb.con) do
		if type(key) == type(0) then
			stype = key
			beg_val = v
			end_val = v
			local mainType = rint(key / 100)
			local subType = rint(key % 100)				
			if mainType == 3 then		-- ���а��� 
				if type(v) == type({}) then
					beg_val = v[1]
					end_val = v[2]					
				end
				if subType == 18 then	-- ������
					con_val = CI_GetPlayerData(23)
				elseif subType == 19 then	-- ��ֵ����	+ ���⽱��
					con_val = v[3]
				end
			elseif mainType == 4 then	-- �����ռ���
				beg_val = 0
				end_val = 0
			elseif mainType == 8 then	-- ��ֵ������
				if subType == 4 or subType == 5 then	-- ÿ�ճ�ֵ����
					local dt = os_date( "*t" )
					beg_time = dt.year.."-"..dt.month.."-"..dt.day
					end_time = dt.year.."-"..dt.month.."-"..dt.day.." 23:59:59"
				end
			elseif mainType == 10 then	-- ������
				if subType == 2 or subType == 4 or subType == 6  then	-- ÿ�ջ�Ծ��/ƽ̨��ש
					local dt = os_date( "*t" )
					beg_time = dt.year.."-"..dt.month.."-"..dt.day
					end_time = dt.year.."-"..dt.month.."-"..dt.day.." 23:59:59"
				end
			elseif mainType == 14 then	-- �Ϸ��
				end_val = GetServerOpenTime()
			elseif mainType == 15 then	-- ������
				
				local dt = os_date( "*t" )
				beg_time = dt.year.."-"..dt.month.."-"..dt.day
				end_time = dt.year.."-"..dt.month.."-"..dt.day.." 23:59:59"
			elseif mainType == 19 then	-- ����������
				if type(v) == type({}) then
					beg_val = v[1]
					end_val = v[2]					
				end
			end
			break
		end
	end
	
	if AwardTb.con[1601]~=nil then --�޹����⴦��,����ȫ��������
		beg_val=AwardTb.con[1601]
	elseif AwardTb.con[1701]~=nil then --�޹����⴦��,����ȫ��������
		beg_val=AwardTb.con[1701]
		end_val=AwardTb.con[1702]
	end

	local now = GetServerTime()
	-- serverid, sid, account, mainID, subID, stype, beg_time, 
	-- end_time, awd_time, AwardTb.num, beg_val, end_val, con_val, now)
	local rettb = {serverid, sid, account, mainID, subID, stype, beg_time, end_time, 
					awd_time, AwardTb.num, beg_val, end_val, con_val, now}

	return rettb;
end

--���ڴ��л�ȡ�����ӻ��ϸ��Ϣ �����������������ж���Ϣ
local function update_player_chunjie(sid)  
	local pchunjie = get_chunjie_data(sid)
	if pchunjie == nil or pchunjie[6] == nil then return end
	
	local mainId = pchunjie[6]
	local wdata = get_chunjie_worlddata()
	if wdata[mainId] == nil or wdata[mainId][2] ~= pchunjie[7] then return end
	local cache =  __G.AllActiveListConf.cache
	if cache[mainId] == nil then return end 
	--��ȡ��������
	local dbtb = {}
	local timtb = {}
	--�հ�
	local function get_key_func(contb, mainId, subId) 
		for key, val in pairs(contb) do
			if  key > 1700 and key < 1800 then  
				table_push(dbtb, {key, val, mainId, subId})
			else
				table_push(timtb, {key, val, mainId, subId})
			end
		end
	end
	--- ʵ��ȡ
	local subtb = wdata[mainId][1]
	local awardbuf 
	for ___, value  in pairs(subtb) do
		if cache[value]  ~= nil then 
			awardbuf= cache[value].AwardBuf
			for subId, v in pairs(awardbuf) do 
				get_key_func(v.con, value, subId)
			end
		end
	end

	 
	 --��Ҵ��� �� ��ʷ�ۻ���ֵ
	if #timtb > 0 then 
		get_player_time(sid, cache, timtb)
	end
end

--��ȡ��һ�ڼ䵥�ʳ�ֵ��Ϣ
local function update_player_recharge(sid)
	local cache = __G.AllActiveListConf.cache
	local mainId = CurChunJieID
	if cache[mainId] == nil then return end 

	--���ʳ�ֵ����������¼
	local beg_time = cache[mainId].tBegin
	local end_time = cache[mainId].tEnd
	local  serverid = GetGroupID()
	local  account = CI_GetPlayerData(15)
	db_cj_get_recharge_record(serverid, sid, account, 200, beg_time, end_time, 0)
end

--------------interface------------------------
local function _day_reset_cjdata(sid)
	if not check_time() then return end
	local pdata = get_chunjie_data(sid)
	local wdata = get_chunjie_worlddata()
	local mainId = CurChunJieID

	if pdata == nil then return end

	if  wdata[mainId] == nil  then 
		pdata = nil  --�������� ��ѽ���
		return
	end
	--��ֹ�����ҹ�һ�, û�д��ڳ�ʼ����
	if pdata[6] == nil then 	
		pdata[6] = mainId
		pdata[7] = wdata[mainId][2]
	else
		if pdata[7] == nil or wdata[mainId][2] ~= pdata[7] then 
			pdata[1] = nil
			pdata[2] = nil
			pdata[3] = nil
			pdata[4] = nil
			pdata[6] = mainId
			pdata[7] = wdata[mainId][2]
		end
	end
	--���ݳ�ʼ��
	--��½��������
	pdata[1] = pdata[1] or {}
	pdata[1][1] = 0
	pdata[1][8] = 0
	--
	local tNow = GetServerTime()
	record_login_num(pdata[1], tNow)
	--���ָ������
	pdata[2] = {}
end

local function _GetRechargeInfo(sid, flag,records)
	look("GetRechargeInfo 1")
	--200 500 1000 2000 5000 10000 20000
	-- paypoints, time
	local pchunjie = get_chunjie_data(sid)
	if pchunjie == nil then  return  end
	
	if records == nil then 
		if flag == 1 then 
			SendLuaMsg(sid,  {ids =update_recharge , pchunjie[3] },  9)--������Ϣ	
		end
		look("GetRechargeInfo 3")
		return 
	end
	
	local num1, num2, num3, num4, num5, num6, num7 = 0, 0, 0, 0, 0, 0, 0
	local tmp  = 0
	for key, paytb in pairs(records) do
		if type(key) == type(0) then
			tmp = paytb[1]
			if tmp >= 20000 then
				num7 = num7 + 1
			elseif tmp >= 10000 then
				num6 = num6 + 1
			elseif tmp >= 5000 then
				num5 = num5 + 1
			elseif tmp >= 2000 then
				num4 = num4 + 1
			elseif tmp >= 1000 then
				num3 = num3 + 1
			elseif tmp >= 500 then
				num2 = num2 + 1
			elseif tmp >= 200 then
				num1 = num1 + 1
			end
		end
	end
	pchunjie[3] = pchunjie[3] or {}
	pchunjie[3][1] = pchunjie[3][1] or {}
	pchunjie[3][1][1] = num1
	pchunjie[3][2] = pchunjie[3][2] or {}
	pchunjie[3][2][1] = num2
	pchunjie[3][3] = pchunjie[3][3] or {}
	pchunjie[3][3][1] = num3
	pchunjie[3][4] = pchunjie[3][4] or {}
	pchunjie[3][4][1] = num4
	pchunjie[3][5] = pchunjie[3][5] or {}
	pchunjie[3][5][1] = num5
	pchunjie[3][6] = pchunjie[3][6] or {}
	pchunjie[3][6][1] = num6
	pchunjie[3][7] = pchunjie[3][7] or {}
	pchunjie[3][7][1] = num7
	if flag == 1 then 
		SendLuaMsg(sid,  {ids =update_recharge , pchunjie[3] },  9)--������Ϣ	
	end
	look("GetRechargeInfo 2")
end


--��ڼ�������ߴ���
local function _online_chunjie_data(sid)
	if IsSpanServer() then return end
	if not check_time() then return end

	local pdata = get_chunjie_data(sid)
	local wdata = get_chunjie_worlddata()
	if pdata == nil then return end
	--1
	local mainId = CurChunJieID
	if wdata == nil or wdata[mainId] == nil  then 
		pdata = nil  --��������
		--Log("chunjie_log.txt",  "��ȡ�"..mainId.."���ݱ���, �û�п���")
		return
	end
	---2
	local operate_active = __G.AllActiveListConf.cache[mainId]
	if operate_active == nil then return end
	local tNow = GetServerTime()
	local tBegin =getdatetime(analyze_time(operate_active.tBegin, 0))
	local tEnd = getdatetime(analyze_time(operate_active.tEnd, 0))
	if tNow < tBegin or tNow > tEnd then 
		--Log("chunjie_log.txt",  "�"..mainId.."�ѽ���")
		return 
	end
	--3
	--���ݳ�ʼ��
	if pdata[6] == nil then 	
		pdata[6] = mainId
		pdata[7] = wdata[mainId][2]

	else
		if  pdata[7] == nil or wdata[mainId][2] ~= pdata[7] then 
			pdata[1] = nil
			pdata[2] = nil
			pdata[3] = nil
			pdata[4] = nil
			pdata[6] = mainId
			pdata[7] = wdata[mainId][2]
		end
	end
	--��¼����ȼ�
	pdata[4] = pdata[4] or {}
	pdata[4][4] = rint(GetWorldLevel()/10)*10 
	-- if pdata[4][4] == nil then 
		-- pdata[4][4] = wdata[mainId][3]
	-- end

	--4 ��¼����Ƿ��ۻ���½
	pdata[1] = pdata[1] or {}
	record_login_num(pdata[1] , tNow)
	--5 ��½��ȡ�����ӻ��ϸ��Ϣ���ж��Ƿ�����������Ϣ
	update_player_chunjie(sid)
	update_player_recharge(sid)
end


-- --��Ӫ�����
-- --itype 0 ����  1 ����
-- local function _set_chunjie_mark(itype, val, mainId)
-- 	Log("chunjie_log.txt",  "_set_chunjie_mark "..itype.."  id "..mainId)
-- 	look("_set_chunjie_mark      ")
-- 	local chunjie_data = get_chunjie_worlddata()
-- 	local version = GetServerTime()
-- 	if itype == 1 then 
-- 		look(chunjie_data)
-- 		chunjie_data[mainId] = {}
-- 		chunjie_data[mainId][2] = version
-- 		chunjie_data[mainId][1] = {}
-- 		for key, value in pairs(active_conf) do 
-- 			if key ~= CurChunJieID then
-- 				insert_active_cache(key, value)
-- 				table_push(chunjie_data[mainId][1], key)
-- 			end
-- 		end
-- 	elseif itype == 0 then 
-- 		chunjie_data[mainId] = nil
-- 		for key, value in pairs(active_conf) do
-- 			delete_active_cache(key)
-- 		end
-- 	end
-- 	active_notice_web(itype, version, mainId)
-- end

--��ȡ��ϸ��Ϣ
local function _get_chunjie_info(sid)
	if not check_time() then return end

	update_player_chunjie(sid)
	update_player_recharge(sid)
	--���ݻitype ���������ڴ��еĴ洢λ��
	-- local index = rint(itype / 100)
	local pdata = get_chunjie_data(sid)
	-- local active_info = active_conf ,[2] =active_info
	SendLuaMsg(0, {ids = msg_active_info,  [1]=pdata },9)
end

----------------------------------------------------------------
--itype �Ϸ� 1, ���� 2, ÿ�� 3,  ����4,  ơ�ƽ� 5, �����	6, ʥ���� 7
local function _chunjie_rolling(sid, times, buy) -- ��ʼ�齱
	if IsSpanServer() then return end
	if not check_time() then return end
	----
	local itype = CurActiveType
	 --ȡ����ȼ�
	local worldlv = rint(GetWorldLevel()/10)*10
	worldlv = worldlv < 50 and 50 or worldlv
	-- local wdata = get_chunjie_worlddata()
	-- if wdata == nil or wdata[CurChunJieID] == nil then return end
	-- local worldlv = rint(wdata[CurChunJieID][3] / 10) * 10
	if  item_conf.roll_goods[itype][worldlv] == nil then worldlv = 70 end
	--ȡ�齱����
	local need_item = item_conf.need_goods[itype] 
	local need_money =  item_conf.need_money[itype][times]
	local goods_conf = item_conf.roll_goods[itype][worldlv] 
	local flag, finaldata = roll_random(sid, need_item, need_money, goods_conf, times, buy)
	local operate, pdata, pchunjie
	if flag > 0 then
		pchunjie  = get_chunjie_data(sid) 
		pchunjie[4] = pchunjie[4] or {}
		pdata = pchunjie[4]
		pdata[1] = (pdata[1] or 0) + flag * 2
		SendLuaMsg(0, {ids=msg_roll_res, finaldata, itype=itype, score = pdata[1]},9)
	elseif flag == -1 then
		SendLuaMsg(0, {ids=msg_roll_res, err = 1 }, 9)
	end	
end

---�����콱
local function _award_prize(sid, level)
	if IsSpanServer() then return end
	if not check_time() then return end
	local itype = CurActiveType

	--ȡ����ȼ�
	local worldlv=rint(GetWorldLevel()/10)*10
	worldlv = worldlv < 50 and 50 or worldlv
	
	-- local wdata = get_chunjie_worlddata()
	-- if wdata == nil or wdata[CurChunJieID] == nil then return end
	-- local worldlv = rint(wdata[CurChunJieID][3]/10)*10
	if item_conf.roll_goods[itype][worldlv] ==nil then worldlv=70 end
	
	local awards = item_conf.award_goods[itype][worldlv][level]
	if not awards then
		SendLuaMsg(0, {ids=msg_prize, err = 0, level = level }, 9)---��������
		return 
	end
	--�жϻ����Ƿ���������
	local chunjie_data = get_chunjie_data(sid)
	local pdata = chunjie_data[4] or {}
	
	pdata[1] = pdata[1] or 0
	if pdata[1] < awards[1] then
		SendLuaMsg(0, {ids=msg_prize, err = 1,  level=level }, 9)--����δ�ﵽ
		return
	end
	--�жϱ����Ƿ���������
	--�Ƿ����㹻�Ŀո� ��#awards[2]����ͬ��Ʒ
	if isFullNum() < #awards[2] then
		TipCenter(GetStringMsg(14,  #awards[2]))
		return
	end	
	--��ȡ����+ ���ݴ���
	pdata[2] = pdata[2] or 0
	if level == pdata[2] + 1 then
		pdata[2] = level
		GiveGoodsBatch(awards[2],  ActiveDes.."������콱  ")
		SendLuaMsg(0,{ids=msg_prize, level=level }, 9)--������Ϣ
	else
		SendLuaMsg(0,{ids=msg_prize, err = 0, level=level }, 9)--������Ϣ
	end
end

--ʹ�û��ֶһ�����
local function _award_exchange(sid, itemId, exIndex, index1)
	if IsSpanServer() then return end
	if not check_time() then return end
	--
	local itype = CurActiveType
	
	--��ȡ�һ���Ʒ��Ϣ
	local chunjie_data = get_chunjie_data(sid)
	local pdata = chunjie_data[4] or {}
	local dh_goods = item_conf.dh_goods[itype]
	local item
	for __, goods in pairs(dh_goods) do
		if goods[1] == itemId then
			item = goods
			break
		end
	end
	if item == nil then 
		SendLuaMsg(0, {ids=msg_exchange, err = 0, itemId = itemId, index=exIndex , index1 = index1}, 9)--��������
		return 
	end
	--����Ƿ�����һ�����
	pdata[1] = pdata[1] or 0
	if pdata[1] < item[3] then
		SendLuaMsg(0, {ids=msg_exchange, err = 1,  itemId = itemId,index=exIndex , index1 = index1}, 9)--����δ�ﵽ
		return
	end
	--�жϱ����Ƿ���������
	--�Ƿ����㹻�Ŀո� ��#awards[2]����ͬ��Ʒ
	if isFullNum() < 1 then
		TipCenter(GetStringMsg(14,  1))
		return
	end
	--�ж��Ƿ��ѳ�����ȡ����
	pdata[3] = pdata[3] or {}
	local records = pdata[3]
	local index 
	for k, goods in pairs(records) do
		if goods[1] == item[1] then
			if goods[2] >= item[4] then 
				SendLuaMsg(0, {ids=msg_exchange, err = 2,  itemId = itemId, index=exIndex,  index1 = index1}, 9)--��ȡ��������
				return
			else
				index = k
				break
			end
		end
	end
	--�ۼƶһ����� 
	--�۳�����
	local good
	pdata[1] = pdata[1] - item[3] --��ȥ�һ�����
	if index ~= nil then 	
		-- records[index] =  records[index] or {}
		good = records[index]
		good[2] = good[2] + 1
	else
		
		good = {item[1], 1}
		table_push(pdata[3], good)
	end
	GiveGoods(item[1], item[2], item[5],  ActiveDes.."���ֶһ�����")
	SendLuaMsg(0, {ids=msg_exchange,  score = pdata[1], num =good[2] ,itemId = itemId, index=exIndex, index1 = index1}, 9)
end

--��½�콱
local function _award_login(sid, index)
	if IsSpanServer() then return end
	if not check_time() then return end
	
	local pchunjie = get_chunjie_data(sid)
	if pchunjie == nil or pchunjie[1] == nil then  return  end
	--�ж��Ƿ�����콱 0 �����콱 1 ���콱
	local flag1 = (pchunjie[1][index] == 0) and true or false	
	pchunjie[1][6] = CI_GetPlayerData(27) or 0 --��ʷ�ۼƳ�ֵ ����10W
	local flag2 = (pchunjie[1][6] >= 100000) and true or false

	if index == 1 and flag1 then 
		local mainId, subId = get_active_mainId(101)
		local cache = __G.AllActiveListConf.cache
		local AwardTb = cache[mainId].AwardBuf[subId]
		local AwardTb_ = uv_CommonAwardTable.AwardProc(sid, AwardTb.awd)
		--check awards ��鱳��
		local getok = award_check_items(AwardTb_) 	
		if not getok then
			SendLuaMsg(0,{ids=msg_login, err = 3,  index=index }, 9)--������
			return 
		end
		local ret = GI_GiveAward(sid, AwardTb_, ActiveDes.."ÿ�յ�½����")
		if ret then
			pchunjie[1][index] = 1
			SendLuaMsg(0,{ids=msg_login, index=index }, 9)
		end
	else
		-- if flag2 == false then 
		-- 	SendLuaMsg(0, {ids=msg_login, err = 1,  index=index }, 9) --��ȡ��������
		-- 	return 
		-- end
		--���콱����Ʒ
		local awardbuf = get_login_award(pchunjie, index, flag1, flag2) 
		if awardbuf == nil then return end
		--
		if isFullNum() < #awardbuf[3] then
			SendLuaMsg(0,{ids=msg_login, err = 3,  index=index }, 9)--������
			return 
		end
		--�콱�ɹ��������콱
		local ret = GI_GiveAward(sid, awardbuf,  ActiveDes.."�ۻ���½����")
		if ret then 
			pchunjie[1][index] = 1
			SendLuaMsg(0,{ids=msg_login, index=index }, 9)
		end
	end
	-- local mainId, subId = get_active_mainId(101)
	-- local msg = {ids=msg_login, index=index }
	-- award_active_check(sid, mainId, subId, msg)
end

--���ָ���콱
local function _award_aim(sid, index)
	if IsSpanServer() then return end
	if not check_time() then return end
	--���´���
	update_player_chunjie(sid)
	--��ȡ�����������
	local pchunjie = get_chunjie_data(sid)
	if pchunjie == nil or pchunjie[2] == nil then  return  end

	if pchunjie[2][index] == nil or pchunjie[2][index][1] == nil then
		SendLuaMsg(0,{ids=msg_aim,  err = 1, index=index }, 9)
		return 
	end

	--�ж��콱����
	if pchunjie[2][index][2] == 1 then 
		SendLuaMsg(0,{ids=msg_aim,  err = 2, index=index }, 9)
		return 
	end
	
	local itype =  200 + index	
	local mainId, subId = get_active_mainId(itype)
	local cache = __G.AllActiveListConf.cache
	--����Ƿ�������
	local cache =  __G.AllActiveListConf.cache
	if cache[mainId] == nil then return end 

	local AwardTb = cache[mainId].AwardBuf[subId]
	local AwardTb_ = uv_CommonAwardTable.AwardProc(sid, AwardTb.awd)

	--check awards ��鱳��
	local getok = award_check_items(AwardTb_) 	
	if not getok then
		SendLuaMsg(0,{ids=msg_aim, err = 3,  index=index }, 9)--������
		return 
	end
	local ret = GI_GiveAward(sid, AwardTb_, ActiveDes.."���ָ��������")
	if ret then
		pchunjie[2][index][2] = 1
		SendLuaMsg(0, {ids=msg_aim, index=index }, 9)
	end

	--local msg = {ids=msg_aim, index=index }
	--get_award_num(sid, mainId, subId, msg)
	--award_active_check(sid, mainId, subId, msg)
end

--��ֵ�콱
local function _award_recharge(sid, index)
	if IsSpanServer() then return end
	if not check_time() then return end
	
	--���³�ֵ����
	-- update_player_chunjie(sid)
	get_recharge(sid)
	--��ȡ�����������
	local pchunjie = get_chunjie_data(sid)
	if pchunjie == nil or pchunjie[3] == nil then  return  end
	if pchunjie[3][index] == nil or pchunjie[3][index][1] == nil then
		SendLuaMsg(0,{ids=msg_recharge,  err = 1, index=index }, 9)
		return 
	end

	local rnum = pchunjie[3][index][1] or 0 --��ֵ���� 
	local hnum = pchunjie[3][index][2] or 0 --����ȡ����
	if	(rnum - hnum) <= 0 then 
		SendLuaMsg(0,{ids=msg_recharge,  err = 2, index=index }, 9)
		return 
	end

	local itype = 300 + index	
	local mainId, subId = get_active_mainId(itype)
	-- --����Ƿ�������
	-- local cache =  __G.AllActiveListConf.cache
	-- if cache[mainId] == nil then return end 
	-- --ִ����ȡ�����
	-- local msg = {ids=msg_recharge, index=index }
	-- award_active_check(sid, mainId, subId, msg)
		local cache = __G.AllActiveListConf.cache
	--����Ƿ�������
	local cache =  __G.AllActiveListConf.cache
	if cache[mainId] == nil then return end 

	local AwardTb = cache[mainId].AwardBuf[subId]
	local AwardTb_ = uv_CommonAwardTable.AwardProc(sid, AwardTb.awd)

	--check awards ��鱳��
	local getok = award_check_items(AwardTb_) 	
	if not getok then
		SendLuaMsg(0,{ids=msg_recharge, err = 3,  index=index }, 9)--������
		return 
	end
	local ret = GI_GiveAward(sid, AwardTb_, ActiveDes.."��ֵ����")
	if ret then
		pchunjie[3][index][2] = pchunjie[3][index][2] or 0
		pchunjie[3][index][2] = pchunjie[3][index][2] + 1
		SendLuaMsg(0, {ids=msg_recharge, index=index }, 9)
	end
end

local function _get_recharge(sid)
	if IsSpanServer() then return end
	if not check_time() then return end

	local pdata = get_chunjie_data(sid)
	local wdata = get_chunjie_worlddata()
	local mainId = CurChunJieID
	if mainId == nil then return end
	local beg_time, end_time
	local cache = __G.AllActiveListConf.cache
	if wdata[mainId] ~= nil and cache[mainId] ~= nil then
		--���ʳ�ֵ����������¼
		beg_time = cache[mainId].tBegin
		end_time = cache[mainId].tEnd
		local  serverid = GetGroupID()
		local  account = CI_GetPlayerData(15)
		--1 ��ʾ��Ҫ������Ϣ ��ǰ�� o ����
		db_cj_get_recharge_record(serverid, sid, account, 200, beg_time, end_time, 1)
	end
end

local function _update_chunjie_data()
	--������Ӫ�ʱ�жϻ����ʱ�� �ͽ���ʱ��
	look("insert chunjie active begin")
	
	local mainId = CurChunJieID
	local tNow = GetServerTime()
	local tBegin = BeginTime
	local tEnd = EndTime
	--ȡ��������
	local wdata = GetWorldCustomDB()
	if wdata == nil then return end
	--look('��ȡ')
	if wdata.chunjie == nil then wdata.chunjie = {} end
	local chunjie_data = wdata.chunjie

	if  tNow < tBegin or tNow > tEnd then 
		if chunjie_data[mainId] ~= nil then 
			--���� 
			for key, value in pairs(active_conf) do
				delete_active_cache(key)
			end
			chunjie_data[mainId] = nil
			Log("chunjie.txt", "�رջ")
			__G.active_notice_web(0, tNow, mainId)
		end
	else
		local cache = __G.AllActiveListConf.cache 
		if chunjie_data[mainId] == nil then 
			chunjie_data[mainId] = {}
			chunjie_data[mainId][2] = tNow --version

			-- local worldlv = rint(GetWorldLevel()/10)*10
			-- worldlv = worldlv < 50 and 50 or worldlv
			-- chunjie_data[mainId][3] = worldlv

			--�����������ݹ�ϵ�б�
			chunjie_data[mainId][1] = {}
			for key, value in pairs(active_conf) do
				if cache[key] == nil then 
					table_push(chunjie_data[mainId][1], key)
				end
			end
			Log("chunjie.txt", "������������")
			__G.active_notice_web(1, tNow, mainId)
		end

		--����
		for key, value in pairs(active_conf) do
			if cache[key] == nil then 
				insert_active_cache(key, value)
				Log("chunjie.txt", "�����:"..key)
			end
		end
	end
	look("insert chunjie active end")
end

--��ȡӡ�� 9911
local function _award_seal(sid)
	local tNow = GetServerTime()
	local tAward = GetTimeToSecond(2015, 2, 28, 0, 0, 0)
	local tEnd = EndTime
	local chunjie_data = get_chunjie_data(sid)

	if tNow < tAward or tNow > tEnd then 
		SendLuaMsg(0, {ids=msg_seal, err=1}, 9)
		return 
	else	
		if chunjie_data[8] == 1 then --����ȡ
			SendLuaMsg(0, {ids=msg_seal, err=2}, 9)
			return 
		end
		--��ʷ��ֵ
		local paypoints = CI_GetPlayerData(27) or 0
		if paypoints < 500 then 
			SendLuaMsg(0, {ids=msg_seal, err=1}, 9)
			return 
		end
		GiveGoods(9911, 1, 1, ActiveDes..'���ս���')
		chunjie_data[8] = 1
		SendLuaMsg(0, {ids=msg_seal, suc=1}, 9)
	end
end

---------------------------test---------------------------------------
local function _add_chunjie_score(sid, score)
	if type(score) ~= type(0) then return end
	
	local chunjie_data = get_chunjie_data(sid)
	if chunjie_data == nil  then return end
	
	chunjie_data[4] = chunjie_data[4] or {}
	chunjie_data[4][1] = chunjie_data[4][1] or 0
	chunjie_data[4][1] = chunjie_data[4][1]  + score
	
	SendLuaMsg(0, {ids = msg_active_info,  [1]=chunjie_data },9)
end

local function _clear_active_chunjie()	
	__G.AllActiveListConf = {
		list ={},
		cache ={},
	}
	--
	local wdata = GetWorldCustomDB()
	if wdata == nil then return end
	wdata.chunjie = nil
end

local function _test_chunjie(itype)
	if itype == 1 then 
		update_chunjie_data()
	elseif itype == 0 then
		clear_active_chunjie()
	end
end
---------------------------test-----------------------------------------
test_chunjie 			= _test_chunjie
clear_active_chunjie 	= _clear_active_chunjie
add_chunjie_score 		= _add_chunjie_score
----------------------------------------------------------------------
---interface
GetRechargeInfo 	= _GetRechargeInfo
--
get_chunjie_info 	= _get_chunjie_info
get_recharge 		= _get_recharge

update_chunjie_data = _update_chunjie_data
online_chunjie_data = _online_chunjie_data
day_reset_cjdata 	= _day_reset_cjdata

chunjie_rolling = _chunjie_rolling
--�콱��Ϣ��
award_prize 	= _award_prize
award_exchange 	= _award_exchange
award_login 	= _award_login
award_aim 		= _award_aim
award_recharge 	= _award_recharge
award_seal 		= _award_seal
 