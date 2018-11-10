--[[
夫妻挑战副本
]]--

local db_module = require('Script.cext.dbrpc')
local db_cc_save = db_module.db_cc_save
local db_cc_gen_ranks = db_module.db_cc_gen_ranks
local db_cc_get_ranks_list = db_module.db_cc_get_ranks_list
local db_cc_get_local_ranking = db_module.db_cc_get_local_ranking

local db_cc_divorce = db_module.db_cc_divorce

local msg_end = msgh_s2c_def[48][1]
local msg_list = msgh_s2c_def[48][2]
local msg_ranking = msgh_s2c_def[48][3]
local msg_getawards = msgh_s2c_def[48][4]
local msg_quenching = msgh_s2c_def[48][5]
local msg_buyskill = msgh_s2c_def[48][6]

ccfb_list = 
{
--排名奖励
[1]=	{{1,1,{{815,1200},{814,300},{603,50},{792,5}}} --{起始名次,结束名次,{{道具id,数量},{道具id,数量},...}}	
	,{2,3,{{815,1000},{814,250},{603,40},{792,3}}}
	,{4,5,{{815,800},{814,200},{603,35},{622,3}}}
	,{6,10,{{815,700},{814,150},{603,30},{622,3}}}
	,{11,20,{{815,600},{814,120},{603,25},{622,2}}}
	,{21,50,{{815,500},{814,90},{603,20},{622,2}}}
	,{51,100,{{815,400},{814,60},{603,15},{622,1}}}
	,{101,200,{{815,300},{814,40},{603,10},{622,1}}}
	,{201,1000,{{815,200},{814,20},{603,8},{621,2}}}
	,{1001,2000,{{815,120},{814,10},{603,5},{621,1}}}
	},
--波数奖励
[2]={[5] = {{815,100},{814,100}} --{波数,{{道具id,数量},{道具id,数量},...}}
	,[10] = {{815,200},{814,200}}
	,[15] = {{815,300},{814,300}}
	,[20] = {{815,400},{814,400}}
	,[25] = {{815,500},{814,500}}
	,[30] = {{815,600},{814,600}}
	,[35] = {{815,700},{814,700}}
	,[40] = {{815,800},{814,800}}
	,[45] = {{815,900},{814,900}}
	,[50] = {{815,1000},{814,1000}}
	,[55] = {{815,1100},{814,1100}}
	,[60] = {{815,1200},{814,1200}}
	,[65] = {{815,1300},{814,1300}}
	,[70] = {{815,1400},{814,1400}}
	,[75] = {{815,1500},{814,1500}}
	,[80] = {{815,1600},{814,1600}}
	,[85] = {{815,1700},{814,1700}}
	,[90] = {{815,1800},{814,1800}}
	,[95] = {{815,1900},{814,1900}}
	,[100] = {{815,2000},{814,2000}}
	},
	-- 第一个为技能的id
	[3] = {{375,376,377,378}},
	--淬炼戒子使用的道具id
	[4] = {815},
	
	[6] = {3000,10000,30000,60000}
}

--for i=0,20 do
		--cc_divorce(i + 10000)
		--cc_divorce(i + 20000)
	--	db_cc_save(	i + 10000,"NoName",1,
	--				i + 20000,"NoName",0,math.random(1,20))
--end

local function cc_get_pdata(sid)
	local pdata = GI_GetPlayerData(sid,'ccfb',80)
	if not pdata[10] then
		if pdata.high then 
			pdata[1] = pdata.high
			pdata.high = nil 
		end
		
		if pdata.skills_buy then 
			pdata[2] = pdata.skills_buy
			pdata.skills_buy = nil
		end
		if pdata.skills_count then 
			pdata[3] = pdata.skills_count
			pdata.skills_count = nil
		end
		
		if pdata.gotflag then 
			pdata[4] = pdata.gotflag
			pdata.gotflag = nil
		end
		if pdata.award_level then 
			pdata[5] = pdata.award_level
			pdata.award_level = nil
		end
		pdata[10] = true
	else
		pdata.high = nil 
		pdata.gotflag = nil
		pdata.award_level = nil
		
		pdata.skills_buy = nil
		pdata.skills_count = nil
	end
	return pdata
	--
	--[1]: high
	--[2]: skills_buy
	--[3]: skills_count
	
	--[4]: gotflag
	--[5]: award_level
end

local function cc_get_wdata()
	local w_customdata = GetWorldCustomDB()
	if w_customdata.ccfb == nil then
		w_customdata.ccfb =	{
		[1] = {}, --全服排行缓存
		[2] = nil, --本服玩家排名
		min_score = 0,--前2000名最低分数
		}
	end
	return w_customdata.ccfb
end

function cc_endfail(sid)
	--look('cc_endfail',1)
	for k,v in pairs(ccfb_list[3][1]) do
		CI_DelBuff(v,2,sid)
	end
	local pdata = cc_get_pdata(sid)
	pdata[2] =nil
	pdata[3] =nil
	local sid2 = GetCoupleSID(sid)--配偶sid
	local sceneGID = GetCurCopyScenesGID(sid2)

	if sceneGID then
		local copyScene = CS_GetTemp(sceneGID)
		if copyScene then
			cc_completed(sid,sid2,copyScene.turns or 1)
		end
	end
end

function cc_begin(sid)
	----look("cc_begin",2)
	local pdata = cc_get_pdata(sid)
	pdata[2] = 0
	pdata[3] = 3
	SendLuaMsg(sid,{ids = msg_buyskill,skills_buy=pdata[2],skills_count=pdata[3]},10)
end

function cc_completed(hsid,wsid,score)
	--look("cc_completed",1)
	local wdata = cc_get_wdata()
	wdata.min_score = wdata.min_score or 0
	--如果性别不对,则交换
	local sex = CI_GetPlayerData(11,2,hsid)
	if sex == 0 then hsid,wsid = wsid,hsid	end
	local hpdata = cc_get_pdata(hsid)
	local wpdata = cc_get_pdata(wsid)
	
	hpdata[1] = hpdata[1] or 0
	if score > hpdata[1] then hpdata[1] = score end
	wpdata[1] = wpdata[1] or 0
	if score > wpdata[1] then wpdata[1] = score	end	

	if score >= wdata.min_score then
		db_cc_save(	hsid,CI_GetPlayerData(3,2,hsid),CI_GetPlayerData(62,2,hsid),
					wsid,CI_GetPlayerData(3,2,wsid),CI_GetPlayerData(62,2,wsid),score)
	end
	SendLuaMsg(hsid,{ids = msg_end,score=score,high = hpdata[1]},10)
	SendLuaMsg(wsid,{ids = msg_end,score=score,high = wpdata[1]},10)
end

function cc_player_use_skill(sid,index)
	----look('cc_player_use_skill',2)

	local copyScene = CS_GetCopyScene(sid)
	if not copyScene then return end
	local sid2 = GetCoupleSID(sid)
	local pdata = cc_get_pdata(sid)
	local skills_count = pdata[3] or 0
	if skills_count > 0 then 
		local skillid = ccfb_list[3][1][index]
		if skillid and GetFriendDegree(sid,sid2) >= ccfb_list[6][index] then
			pdata[3] = skills_count-1
			local succ = CI_AddBuff(skillid,false,1,false,2,GetCoupleSID(sid))
		end
	end
	SendLuaMsg(sid,{ids = msg_buyskill,skills_buy=pdata[2],skills_count=pdata[3]},10)
end

function cc_player_buy_skill(sid)
	----look('cc_player_buy_skill',2)
	local pdata = cc_get_pdata(sid)
	local skills_buy = pdata[2] or 0
	local skills_count = pdata[3] or 0

	if CheckCost(sid,20*(pdata[2]+1),0,1,'挑战购买技能') then
		pdata[2] = skills_buy+1
		pdata[3] = skills_count+1
		SendLuaMsg(sid,{ids = msg_buyskill,skills_buy=pdata[2],skills_count=pdata[3]},10)
	end
end

local ranks_award_table = ccfb_list[1]
local level_award_table = ccfb_list[2]

function cc_get_rank_list(sid,page,pagesize)
	----look('cc_get_rank_list',2)
	local lists = cc_get_wdata()[1]
	if lists[page] ~= nil then
		SendLuaMsg(0,{ids=msg_list,list=lists[page],page=page,pagesize=pagesize,total=lists.total},9)
	else
		db_cc_get_ranks_list(sid,page,pagesize)
	end
end

function cc_get_player_ranking(sid)
	local local_ranks = cc_get_wdata()[2]
	if local_ranks then
		for k,v in pairs(local_ranks) do
			if type(v) == type({}) and (v[1] == sid or v[2] == sid) then
				return v[3]
			end
		end
	end
	return nil
end

local function cc_give_awards(sid,awards,tag)
	if not awards then return end
	local k,v
	for k,v in pairs(awards) do
		GiveGoods(v[1],v[2],v[3],tag)
	end
end

function cc_player_get_award(sid,ntype,level)
	----look('cc_player_get_award',2)

	local pdata = cc_get_pdata(sid)
	if not pdata then return end
	local k,v
	if ntype == 1 then--每日排名领奖
		if pdata[4] then return end
		local ranking = cc_get_player_ranking(sid)
		if not ranking then return end
		for k,v in pairs(ranks_award_table) do
			if ranking >= v[1] and ranking <= v[2] then
				if isFullNum() < #v[3] then
					TipCenter(GetStringMsg(14,#v[3]))
					return
				end	
				pdata[4] = true
				cc_give_awards(sid,v[3],"挑战(每日领奖)")
				SendLuaMsg(0,{ids=msg_getawards,ntype=ntype,succ = true},9)
				return
			end
		end
	elseif ntype == 2 then--等级领奖
		if level > pdata[1] then return end
		pdata[5] = pdata[5] or 0
		local awards = level_award_table[level]
		if not awards then return end
		if level > pdata[5] then
			if isFullNum() < #awards then
				TipCenter(GetStringMsg(14,#awards))
				return
			end	
			pdata[5] = level
			cc_give_awards(sid,awards,"挑战(通关奖励)")
			SendLuaMsg(0,{ids=msg_getawards,ntype=ntype,level = level,succ = true},9)
		end
	end
end

function cc_clean_ranks()
	----look("cc_clean_ranks",2)
	local wdata = cc_get_wdata()
	wdata[2] = nil
end

function cc_player_day_refresh(sid)
	look("cc_player_day_refresh",2)
	local pdata = cc_get_pdata(sid)
	pdata[4] = false
end

function cc_update_ranks()
	----look("cc_update_ranks",2)
	db_cc_gen_ranks()
end
 
function cc_local_ranks()
	----look("cc_local_ranks",2)
	db_cc_get_local_ranking()
end

function cc_on_read_ranks_list(list,total,sid,page,pagesize)
	----look('cc_on_read_ranks_list',2)
	----look(list,2)
	local lists = cc_get_wdata()[1]
	lists[page] = list
	if page == 0 then
		lists.total = total or 0
	end
	SendLuaMsg(sid,{ids=msg_list,list=lists[page],page=page,pagesize=pagesize,total=lists.total},9)
end

function cc_on_read_local_ranking(list,min_score)
	----look("cc_on_read_local_ranking",2)
	
	local wdata = cc_get_wdata()
	wdata.min_score = min_score or 0
	wdata[2] = list
	wdata[1] = {}
end

function cc_divorce(sid)
	----look('cc_divorce',2)
	db_cc_divorce(sid)
end

function cc_clear_ranks_cache()
	local wdata = cc_get_wdata()
	wdata[1] = {}
end

function cc_on_player_login(sid)
	local pdata = cc_get_pdata(sid)
end