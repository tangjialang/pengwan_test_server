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

-- 脚本排行榜Data
-- mode: 刷新模式 [1] 每日 [2] 每周 [3] 每月
-- itype: 排行榜类型
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

-- 通用插入操作函数
-- 注意：必须满足 [val] 是用来排序的 [id] 是用来匹配的
--small=1 越小的值能入榜,比如通关时间,少的排名好
local function _insert_common(t,num,val,name,school,id,vt,small)
	if type(t) ~= type({}) or type(num) ~= type(0) then 
		return
	end
	if num > 200 then  				-- 排行榜不能超过200条数据
		return 
	end	
	local inst = true
	for k, v in ipairs(t) do
		if type(v) == type({}) then
			if v[4] == id then			-- 以名字来判断应该不会有问题(带前缀的名字)
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
		-- 如果每次传入的值都正确、那么这样覆盖肯定不会有问题(可以防止不断生成临时表)
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

-- 插入排行榜
-- 用于本场活动临时排行榜,随活动结束清除的可以调用此函数(外部传入存储位置)
--small=1 越小的值能入榜,比如通关时间,少的排名好
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

-- 插入排行榜
-- @mode: 刷新模式 [1] 每日 [2] 每周 [3] 每月
-- @itype: [1] 温泉 [2] 曲水 [3] 狩猎 [4] 捕鱼 [5] 魅力 [6] 三界 [7] 神兽 [8] 竞技 [9] 帮战[10] 匿名战 [11]王城战 [12] 铜钱捐献
-- 对于帮派排行榜(itype == 9): val:帮会战积分 id:帮派ID name:帮派名称 shcool:帮会等级
-- 对于复合类型：父类型+子类型；对1亿取商是父类型，对1亿取模是子类型。 
	-- 例如：每个帮派宝石迷阵排行榜：	itype = 100000000 + fid
	--			  每个帮会玄天阁排行榜：		itype = 200000000 + fid
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
	local vt = 0		-- vip类型
	if itype ~= 9 then
		vt = CI_GetPlayerIcon(0,0,2,id)
	end
	_insert_common(t_list,num,val,name,school,id,vt) 
	return ret
end

--刷新排行榜 
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
						if k == 9 then		-- 帮会战(给每个帮会成员发奖励)
							look(awd_conf)
							for rk, info in ipairs(v) do
								-- 生成奖励
								look('rk:' .. tostring(rk))
								local pos = nil
								if rk == 1 then
									pos = 1
									-- 这里记录下上周帮会战积分排名第一的帮会
									-- 用于攻城战在当前积分为nil的情况下默认守城方
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
											fac_data.f_score = 0		-- 清理每周帮会积分
										end
										SendSystemMail(fid,MailScoreList,k,1,rk,t,7*24*60)										
									end
								end
							end 
						else
							for rk, info in ipairs(v) do
								-- 生成奖励
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
				
			sc_data[k] = nil-- 清空当前排行榜
		end		
	end	
end

-- 请求排行榜数据
local function _request_scorelist(sid,mode,itype)
	if mode == nil or itype == nil then
		return
	end
	local t_list = _get_scorelist_data(mode,itype)
	look(t_list)
	SendLuaMsg( 0, { ids = sc_list, mode = mode, itype = itype, t_list = t_list }, 9 )
end

-- 获取积分排名
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