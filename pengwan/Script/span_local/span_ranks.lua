
local msg_span_rank = msgh_s2c_def[44][1]
local msg_self_ranking = msgh_s2c_def[44][2]

local SendLuaMsg = SendLuaMsg
local GetWorldCustomDB = GetWorldCustomDB
local GetPlayerPoints = GetPlayerPoints
local CI_GetPlayerData = CI_GetPlayerData


local db_module = require('Script.cext.dbrpc')
local db_kfph_read = db_module.db_kfph_read
local db_kfph_write = db_module.db_kfph_write
local db_kfph_update = db_module.db_kfph_update
local db_kfph_ranking_list = db_module.db_kfph_ranking_list

local function kfph_getwdata()
	local wdata = GetWorldCustomDB()
	if wdata.kfph == nil then
		wdata.kfph = {}
		wdata.kfph[1] = {}	--zl_s
		wdata.kfph[2] = {}	--ww_s
		wdata.kfph[3] = {}	--jjls_s
		
		wdata.kfph[4] = {}	--角色排行zl_s
		wdata.kfph[5] = {}	--角色排行ww_s
		wdata.kfph[6] = {}	--角色排行jjls_s
	end
	return wdata.kfph
end

function kfph_day_refresh()
	local wdata = kfph_getwdata()
	wdata[1] = {}
	wdata[2] = {}
	wdata[3] = {}
	
	--look("获取排名",2)
	db_kfph_ranking_list(1)
	db_kfph_ranking_list(2)
	db_kfph_ranking_list(3)
end

function kfph_player_refresh(sid)
	local zl_s=CI_GetPlayerData(62)
	if zl_s < 100000 then return end
	local ww_s = GetPlayerPoints(sid,12)
	local jjls_s = v3_getmaxwin(sid)
	db_kfph_write(sid,zl_s,ww_s,jjls_s,GI_GetVIPType(sid))
	
	--look("更新玩家数据成功",2)
end

function kfph_ranking_list()
	--look("生成排名",2)
	db_kfph_update()
end

function CALL_BACK_KfphRead(list,l_type,page,pagesize,icount)
	--look(list,2)
	local wdata=kfph_getwdata()
	wdata[l_type][page] = list
	wdata[l_type].icount = icount
	SendLuaMsg(0,{ids=msg_span_rank,list=wdata[l_type][page],l_type=l_type,page=page,pagezie=pagezie,icount=icount},9)
	--look("获取数据返回成功",2)
end

function CALL_BACK_RankingList(list,l_type)
	local wdata=kfph_getwdata()
	if list == nil then
		list={}
	end 
	wdata[3+l_type] = list
	--look(list,2)
	--look(l_type,2)
	--look("获取排名返回成功",2)
end

function kfph_get_list(sid,l_type,page,pagesize)
	local wdata = kfph_getwdata()
	if wdata[l_type][page] ~= nil then
		SendLuaMsg(0,{ids=msg_span_rank,list=wdata[l_type][page],l_type=l_type,page=page,pagezie=pagezie,icount=wdata[l_type].icount},9)
	else
		db_kfph_read(l_type,page,pagesize)
	end
end

function kfph_get_self_ranking(sid,l_type)
	
	local wdata = kfph_getwdata()
	local rlist = wdata[3+l_type]
	local ranking
	--look(wdata[3+l_type],2)
	if rlist then
		for k,v in pairs(rlist) do
			if type(v) == type({}) and v[1] == sid then
				ranking = v[2]
				break
			end
		end
	end	
	SendLuaMsg(0,{ids=msg_self_ranking,l_type = l_type,ranking=ranking},9)
end