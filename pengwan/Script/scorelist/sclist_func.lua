--[[
file:	sclist_interface.lua
desc:	all scorelist proc.
author:	csj
update:	2013-07-08
2014-08-23:update by sxj ,update _insert_scorelist()
]]--

-------------------------------------------------------------
--include:
local sc_list = msgh_s2c_def[41][1]

local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tablepush,tablelocate,tablesort = table.push,table.locate,table.sort

local __G = _G
local look = look
local SendLuaMsg = SendLuaMsg
local SendSystemMail = SendSystemMail
local GetServerTime = GetServerTime
local MailScoreList = MailConfig.ScoreList
local CI_GetPlayerIcon = CI_GetPlayerIcon
local CI_GetFactionInfo = CI_GetFactionInfo
local db_module = require('Script.cext.dbrpc')
local db_get_rank_list = db_module.db_get_rank_list

-------------------------------------------------------------
--module

module(...)

-------------------------------------------------------------
--data:

-------------------------------------------------------------
--inner function:

local function _cmp_score(a, b)
	if type(a) ~= type({}) or a[1] == nil then return false end
	if type(b) ~= type({}) or b[1] == nil then return true end
	return a[1] > b[1]
end

-- �ű����а�Data
-- mode: ˢ��ģʽ [1] ÿ�� [2] ÿ�� [3] ÿ��
-- itype: ���а�����
local function _get_scorelist_data(mode,itype)
	if mode == nil then return end
	local worldRank = __G.GetWorldRankData()
	if worldRank == nil then return end
	if worldRank.scData == nil then
		worldRank.scData = {}
	end
	worldRank.scData[mode] = worldRank.scData[mode] or {}
	local t = worldRank.scData[mode]
	if itype == nil then
		return t
	else
		t[itype] = t[itype] or {}
		return t[itype]
	end	
end

-- ͨ�ò����������
-- ע�⣺�������� [val] ����������� [id] ������ƥ���
--small=1 ԽС��ֵ�����,����ͨ��ʱ��,�ٵ�������
local function _insert_common(t,num,val,name,school,id,vt,small)
	if type(t) ~= type({}) or type(num) ~= type(0) then 
		return
	end
	if num > 200 then  				-- ���а��ܳ���200������
		return 
	end	
	local inst = true
	for k, v in ipairs(t) do
		if type(v) == type({}) then
			if v[4] == id then			-- ���������ж�Ӧ�ò���������(��ǰ׺������)
				v[1] = val
				v[2] = name
				inst = false
			end
		end
	end
	if inst then
		local pos = num
		if #t < num  then
			pos = #t + 1
		end	
		-- ���ÿ�δ����ֵ����ȷ����ô�������ǿ϶�����������(���Է�ֹ����������ʱ��)
		if t[pos] == nil then
			t[pos] = {val,name,school,id,vt}
		else
			if not small then 
				if val > t[pos][1] then
					t[pos][1] = val
					t[pos][2] = name
					t[pos][3] = school
					t[pos][4] = id
					t[pos][5] = vt
				end
			else
				if val < t[1][1] then
					t[1][1] = val
					t[1][2] = name
					t[1][3] = school
					t[1][4] = id
					t[1][5] = vt

				end
			end
		end
	end
	tablesort(t,_cmp_score)
end

-- �������а�
-- ���ڱ������ʱ���а�,����������Ŀ��Ե��ô˺���(�ⲿ����洢λ��)
--small=1 ԽС��ֵ�����,����ͨ��ʱ��,�ٵ�������
local function _insert_scorelist_ex(t,num,val,name,school,id,vt,small)
	if t == nil or num == nil or val == nil or name == nil or school == nil or id == nil then
		return false
	end
	if type(t) ~= type({}) or type(num) ~= type(0) then 
		return false
	end
	local ret = false
	if not small then
		if val > ((t[num] and t[num][4]) or 0) then
			ret = true
		end	
	else
		if val < ((t[1] and t[1][4]) or 0) then
			ret = true
		end	
	end
	_insert_common(t,num,val,name,school,id,vt,small)
	return ret
end

-- �������а�
-- @mode: ˢ��ģʽ [1] ÿ�� [2] ÿ�� [3] ÿ��
-- @itype: [1] ��Ȫ [2] ��ˮ [3] ���� [4] ���� [5] ���� [6] ���� [7] ���� [8] ���� [9] ��ս[10] ����ս [11]����ս [12] ͭǮ����
-- ���ڰ������а�(itype == 9): val:���ս���� id:����ID name:�������� shcool:���ȼ�
-- ���ڸ������ͣ�������+�����ͣ���1��ȡ���Ǹ����ͣ���1��ȡģ�������͡� 
	-- ���磺ÿ�����ɱ�ʯ�������а�	itype = 100000000 + fid
	--			  ÿ�������������а�		itype = 200000000 + fid
local function _insert_scorelist(mode,itype,num,val,name,school,id)
	if itype == nil or val == nil or name == nil or school == nil or id == nil then
		return false
	end
	local t_list = _get_scorelist_data(mode,itype)
	if t_list == nil then 
		return false
	end
	if itype < 100000000 then
		if __G.active_type[itype] == nil then 
			return false
		end
	end
	local ret = false
	if val > ((t_list[num] and t_list[num][1]) or 0) then
		ret = true
	end
	local vt = 0		-- vip����
	if itype ~= 9 then
		vt = CI_GetPlayerIcon(0,0,2,id)
	end
	_insert_common(t_list,num,val,name,school,id,vt) 
	return ret
end

--ˢ�����а� 
local function _refresh_scorelist(mode)
	look("ScoreListRefresh:" .. mode)
	local sc_data = _get_scorelist_data(mode)
	if sc_data == nil then return end
	local now = GetServerTime()
	for k, v in pairs(sc_data) do
		if type(k) == type(0) and type(v) == type({}) then
			if __G.active_type[k] then
				if __G.active_type[k].awards then 
					local awd_conf = __G.active_type[k].awards[mode]
					if awd_conf then						
						if k == 9 then		-- ���ս(��ÿ������Ա������)
							look(awd_conf)
							for rk, info in ipairs(v) do
								-- ���ɽ���
								look('rk:' .. tostring(rk))
								local pos = nil
								if rk == 1 then
									pos = 1
									-- �����¼�����ܰ��ս����������һ�İ��
									-- ���ڹ���ս�ڵ�ǰ����Ϊnil�������Ĭ���سǷ�
									local cfData = __G.GetCityFightData()
									if cfData then
										cfData.ff_last = info[4]
									end
								elseif rk >= 2 and rk <= 10 then
									pos = 2
								end
								-- local pos = tablelocate(awd_conf,rk)
								look('pos:' .. tostring(pos))
								if pos and awd_conf[pos] then
									local fid = info[4]
									look('fid:' .. fid)
									if fid and fid > 0 then
										local t = awd_conf[pos]
										local fac_data = __G.GetFactionData(fid)
										if fac_data then		
											fac_data.f_score = 0		-- ����ÿ�ܰ�����
										end
										SendSystemMail(fid,MailScoreList,k,1,rk,t,7*24*60)										
									end
								end
							end 
						else
							for rk, info in ipairs(v) do
								-- ���ɽ���
								local pos = nil
								if rk == 1 then
									pos = 1
								elseif rk >= 2 and rk <= 10 then
									pos = 2
								end
								-- local pos = tablelocate(awd_conf,rk)
								if pos and awd_conf[pos] then
									SendSystemMail(info[2],MailScoreList,k,2,rk,awd_conf[pos],7*24*60)
								end
							end
						end
					end
				end
			end
				
			sc_data[k] = nil-- ��յ�ǰ���а�
		end		
	end	
end

-- �������а�����
local function _request_scorelist(sid,mode,itype)
	if mode == nil or itype == nil then
		return
	end
	local t_list = _get_scorelist_data(mode,itype)
	look(t_list)
	SendLuaMsg( 0, { ids = sc_list, mode = mode, itype = itype, t_list = t_list }, 9 )
end

-- ��ȡ��������
local function _get_score_rank(mode,itype,id)
	if mode == nil or itype == nil or id == nil then 
		return
	end
	local t_list = _get_scorelist_data(mode,itype)
	if type(t_list) == type({}) then
		for k, v in ipairs(t_list) do			
			if type(v) == type({}) then
				if v[4] == id then
					return k
				end
			end
		end
	end
end

----------------------------------------------------
--interface:

request_scorelist = _request_scorelist
refresh_scorelist = _refresh_scorelist
get_scorelist_data = _get_scorelist_data
get_score_rank = _get_score_rank
insert_scorelist = _insert_scorelist
insert_scorelist_ex = _insert_scorelist_ex
-- refresh_scorelist(2)

-- look(__G.GetWorldRankData().scData)