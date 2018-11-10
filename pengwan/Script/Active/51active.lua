--[[
file: 51active.lua
desc: 51�
]]--

local pairs,ipairs,type = pairs,ipairs,type
local os_date = os.date
local GetServerOpenTime = GetServerOpenTime
local GetServerMergeTime = GetServerMergeTime
local GetServerTime = GetServerTime
local rint = rint
local look = look
local __G = _G

local time_proc_m = require('Script.active.time_proc')
local regist_event_dynamic = time_proc_m.regist_event_dynamic
local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond

local initTime = GetTimeToSecond(2014,12,24,0,0,0) + 8*3600

-------------------------------------------------------------------------
--module:

module(...)

------------------------------------------------------------------------
--inner:
--��½
local activeconf_51 = {
	[2000001701] = {
		list = { title = '��½����',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			--�ɼ�ʱ��,��ʼʱ�䣬����ʱ�䣬�콱ʱ��
			tView = 0,tBegin = 0,tEnd = 3*24*3600,tAward = 0,
			AwardBuf = {
				[1] = {
					con ={ [1006] = 0 }, --�ж����� ֵΪ��͵ȼ�
					num = 1,	         --����				
					awd = {
						--��ȡ��Ʒ����key����Ϊ3��ʾ��Ʒ
						--������������Ʒid���������Ƿ��
						[3] = {{1594,2,1},{803,50,1},{601,20,1},{603,20,1},{1595,1,1},{1596,1,1}},
					},					
				},	
						
			},			
		},
	},
	--���ָ������
	[2000001702] = {
		list = { title = '���ָ������',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 3*24*3600,tAward = 0,
			AwardBuf = {
			--���10��
				[1] = {
					con ={ [1518] = 10 },
					num = 1,					
					awd = {
						[3] = {{1595,2,1},{1596,2,1}},
					},					
				},
			--���20��	
                [2] = {
					con ={ [1518] = 20 },
					num = 1,					
					awd = {
						[3] = {{1595,4,1},{1596,4,1}},
					},					
				},
				--���30��
				[3] = {
					con ={ [1518] = 30 },
					num = 1,					
					awd = {
						[3] = {{1595,10,1},{1596,10,1}},
					},					
				},
				--��Ӹ���2��
				[4] = {
					con ={ [1502] = 2 },
					num = 1,					
					awd = {
						[3] = {{1595,4,1},{1596,4,1}},
					},					
				},
				--��������20��
				[5] = {
					con ={ [1506] = 20 },
					num = 1,					
					awd = {
						[3] = {{1595,4,1},{1596,4,1}},
					},					
				},
				--��Ծ�ȴﵽ80
				[6] = {
					con ={ [1002] = 80 },
					num = 1,					
					awd = {
						[3] = {{1595,3,1},{1596,3,1}},
					},					
				},
				--��Ծ�ȵ���100
				[7] = {
					con ={ [1002] = 100 },
					num = 1,					
					awd = {
						[3] = {{1595,4,1},{1596,4,1}},
					},					
				},
				--����������1��
				[8] = {
					con ={ [1525] = 1 },
					num = 1,					
					awd = {
						[3] = {{1595,3,1},{1596,3,1}},
					},					
				},
			},			
		},
	},
	
	--51���¶һ�
	[2000001703] = {
		list = { title = '51���¶һ�',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 3*24*3600,tAward = 0,
			AwardBuf = {
			
				[1] = {
					--con �б�����keyֵΪid��ֵΪ����
					con ={ [401] = {[1595] = 1,[1596] = 1,} },
					num = 99, --����
					--keyֵΪ3��ʾ������Ʒ ������������Ϊid ���� �Ƿ��
					awd = {
						[3] = {{601,10,1}},
					},					
				},	

      			[2] = {
					con ={ [401] = {[1595] = 1,[1596] = 1,} },
					num = 99, --����
					awd = {
						[3] = {{636,1,1}},
					},					
				},	
				--��һ�Ͷ�����*10 �ʺ�ʯ*10
				[3] = {
					con ={ [401] = {[1595] = 1,[1596] = 1,} },
					num = 99, --����
					awd = {
						[3] = {{634,1,1}},
					},					
				},
				--��һ�Ͷ�����*10 ǿ����*3
				[4] = {
					con ={ [401] = {[1595] = 2,[1596] = 2,} },
					num = 99, --����
					awd = {
						[3] = {{803,10,1}},
					},				
				},	
				--��һ�Ͷ�����*100 �ƺ�-�Ͷ�����
				[5] = {
					con ={ [401] = {[1595] = 50,[1596] = 50,} },
					num = 1, --����
					awd = {
						[3] = {{763,1,1}},
					},						
				},	
				--��һ�Ͷ�����*200 ��һ�Ͷ���״*1
				[6] = {
					con ={ [401] = {[1595] = 100,[1596] = 100,} },
					num = 1, --����
					awd = {
						[3] = {{415,1,1}},
					},					
				},	
				
			},			
		},
	},
	--��ʱ����
	-- [2000001204] = {
		-- list = { title = '����������',vIcon = 1030,ver = 0,pic = 0 },
		-- cache = {
			-- tView = 0,tBegin = 0,tEnd = 4*24*3600,tAward = 0,
			-- AwardBuf = {
			-- --ǿ����*5
				-- [1] = {
					-- con ={ 
						-- [1601] = 999, --ȫ���޹�����
						-- [1602] = 50, --ԭ�� 
						-- [1603] = 25   --�ּ�
					-- },
					-- num = 999,		--�����޹�			
					-- awd = {
						-- [3] = {{804,5,1}},
					-- },					
				-- },	
			-- --���ǵ�*100
				-- [2] = {
					-- con ={ 
						-- [1601] = 666,
						-- [1602] = 200, 
						-- [1603] = 120 
					-- },
					-- num = 666,					
					-- awd = {
						-- [3] = {{627,100,1}},
					-- },					
				-- },
			-- --�ʺ�ʯ*100
				-- [3] = {
					-- con ={ 
						-- [1601] = 666,
						-- [1602] = 200, 
						-- [1603] = 120 
					-- },
					-- num = 666,					
					-- awd = {
						-- [3] = {{626,100,1}},
					-- },					
				-- },
			-- --�߼�������ʯ*1
				-- [4] = {
					-- con ={ 
						-- [1601] = 8,
						-- [1602] = 20000, 
						-- [1603] = 7000 
					-- },
					-- num = 8,					
					-- awd = {
						-- [3] = {{416,1,1}},
					-- },					
				-- },	
			-- },			
		-- },
	-- },	
	--��ɱboss
	[2000001705] = {
		list = { title = '��ɱboss',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 3*24*3600,tAward = 0,
			AwardBuf = {
					[3] = {{1594,1,1},{1595,1,1},{1596,1,1},{765,1,1},{766,1,1},{802,1,1}},		
			},
		},
	},
	--51��ֵ����
	[2000001706] = {
		list = { title = '51��ֵ����',vIcon = 1030,ver = 0,pic = 0 },
		cache = {
			tView = 0,tBegin = 0,tEnd = 3*24*3600,tAward = 0,
			AwardBuf = {
			--200Ԫ��
				[1] = {
				--�����ֵ��ʾ��Χ
					con ={ [1701] = 200,[1702] = 499 },
					num = 999,					
					awd = {
						[3] = {{1594,5,1},},
					      },
					},
				[2] = {
					con ={ [1701] = 500,[1702] = 999 },
					num = 999,					
					awd = {
						[3] = {{1594,12,1},},
					},
				},
				[3] = {
					con ={ [1701] = 1000,[1702] = 1999 },
					num = 999,					
					awd = {
						[3] = {{1594,25,1},{803,50,1},{601,50,1},},
					},
				},
				[4] = {
					con ={ [1701] = 2000,[1702] = 4999 },
					num = 999,					
					awd = {
						[3] = {{1594,55,1},{803,120,1},{601,120,1},},
					},
				},
				[5] = {
					con ={ [1701] = 5000,[1702] = 9999 },
					num = 999,					
					awd = {
						[3] = {{1594,120,1},{803,300,1},{601,300,1},},
					},
				},
				[6] = {
					con ={ [1701] = 10000,[1702] = 19999 },
					num = 999,					
					awd = {
						[3] = {{1594,250,1},{803,800,1},{601,800,1},},
					},
				},
				[7] = {
					con ={ [1701] = 20000,[1702] = 9999999 },
					num = 999,					
					awd = {
						[3] = {{1594,550,1},{803,2000,1},{601,2000,1},},
					},
				},
			},			
		},
	},
	-- [2000001207] = {
		-- list = { title = '������ת��',vIcon = 1030,ver = 0,pic = 0 },
		-- cache = {
			-- tView = 0,tBegin = 0,tEnd = 4*24*3600,tAward = 3*24*3600,
			-- AwardBuf = {				
			-- },
			-- EventBuf = {
				-- arg = {
					-- [1] = {
						-- [905] = 3,
					-- },
					-- [2] = {
						-- [905] = 1,
					-- },
				-- },
			-- },
		-- },

	-- }
--},
}
-- ȡ��Ȼ������
function GetNaturalDay(t)
	local sec = rint(t/(24*3600)) * 24 * 3600 - 8*3600
	return sec
end

-- ����51��
local function _insert_51_active()
	look('_insert_51_active',2)
	
	local baseTime = initTime
	if baseTime == nil or baseTime == 0 then return end
	local active_conf = activeconf_51
	if active_conf == nil then return end
	local now = GetServerTime()
	if now < baseTime - 8*3600 or now >= baseTime + 8*24*3600 then
		return
	end	
	look('_insert_51_active11',2)
	
	local list = __G.AllActiveListConf.list
	local cache = __G.AllActiveListConf.cache
	if list == nil or cache == nil then return end
	for k, v in pairs(active_conf) do
		list[k] = v.list
		cache[k] = {}
		-- look('v.cache.tView:' .. v.cache.tView,1)
		-- look('baseTime:' .. baseTime,1)
		cache[k].tView = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(baseTime+v.cache.tView))
		cache[k].tBegin = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(baseTime+v.cache.tBegin))
		cache[k].tEnd = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(baseTime+v.cache.tEnd))
		cache[k].tAward = os_date('%Y-%m-%d %H:%M:%S', GetNaturalDay(baseTime+v.cache.tAward))
		cache[k].AwardBuf = v.cache.AwardBuf
		if v.cache.EventBuf then
			local t = v.cache.EventBuf
			local evtb = {}
			-- �����Ӻ�һ���ӵ����а�����			
			local begtm = os_date('*t', GetNaturalDay(baseTime+v.cache.tBegin) + 60)	
			local awdtm = os_date('*t', GetNaturalDay(baseTime+v.cache.tAward) + 60)
			if t.Date then
				if type(t.Date[1]) == type(0) then
					begtm = os_date('*t', GetNaturalDay(baseTime+t.Date[1]))
				end
				if type(t.Date[2]) == type(0) then
					awdtm = os_date('*t', GetNaturalDay(baseTime+t.Date[2]))
				end
			end
			local bt = {begtm.year,begtm.month,begtm.day,begtm.hour,begtm.min,begtm.sec}
			local at = {awdtm.year,awdtm.month,awdtm.day,awdtm.hour,awdtm.min,awdtm.sec}
			evtb.Date = {bt,at}
			evtb.arg = t.arg			
			regist_event_dynamic(evtb,now,k)
		end
	end
end

------------------------------------------------------------------------
--interface:

insert_51_active = _insert_51_active