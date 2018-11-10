--[[
file:	Faction_Diplomacy.lua
desc:	帮会外交
update:2013-7-1
refix:	done by xy
]]--
--------------------------------------------------------------------------
--include:
local pairs,type = pairs,type
local Faction_EnemyList = msgh_s2c_def[7][10]
local Faction_UnionData = msgh_s2c_def[7][20]
local Faction_UnionApply = msgh_s2c_def[7][21]
local Faction_UnionRefuse = msgh_s2c_def[7][22]
local GetFactionData = GetFactionData
local CI_GetPlayerData = CI_GetPlayerData
local CI_GetMemberInfo = CI_GetMemberInfo
local CI_GetFactionInfo = CI_GetFactionInfo
local CI_SetFactionInfo = CI_SetFactionInfo
local FactionRPC = FactionRPC
local SendLuaMsg = SendLuaMsg
local define		= require('Script.cext.define')
local FACTION_BZ = define.FACTION_BZ
local GetFactionBootData = GetFactionBootData
local factionMoneyAdd = factionMoneyAdd
local math_floor = math.floor
local CI_ClearFriendFaction = CI_ClearFriendFaction
local BroadcastRPC = BroadcastRPC
local faction_conf = faction_conf
local MailUnionConf = MailConfig.FactionUnion
local MailDelUnionConf = MailConfig.FactionDelUnion
local MailDelUnionConf1 = MailConfig.FactionDelUnion1
local SendSystemMail = SendSystemMail
local sclist_m = require('Script.scorelist.sclist_func')
local get_score_rank = sclist_m.get_score_rank
--------------------------------------------------------------------------
-- data:

--敌对帮会
local uv_enemy = {{0,0,0},{0,0,0},{0,0,0}}
--同盟帮会
local uv_union = {0,0,0,0}

--获取敌对帮会
local function GetFactionEnemy(fid)
	local fdata = GetFactionData(fid)
	if(fdata == nil)then return end
	
	if(fdata.Enemy == nil) then
		fdata.Enemy = {}
	end
	
	return fdata.Enemy
end

--发送敌对帮会
local function _SendFactionEnemy(fid)
	local data = GetFactionEnemy(fid)
	if(data == nil)then return 3 end --获取我的敌对帮会数据失败
	local factionName
	local factionSign
	local idx = 1
	for id,v in pairs(data) do 
		if(type(id) == type(0))then
			factionName = CI_GetFactionInfo(id,1)
			factionSign = CI_GetFactionInfo(id,4)
			if(factionName == nil or factionName == 0)then --帮会已解散或已不存在
				data[id] = nil
			else
				if(idx>3)then break end
				uv_enemy[idx][1] = id
				uv_enemy[idx][2] = factionName
				uv_enemy[idx][3] = factionSign
				idx = idx + 1
			end
		end
	end
	for i = idx,3 do
		uv_enemy[i][1] = nil
		uv_enemy[i][2] = nil
		uv_enemy[i][3] = nil
	end
	SendLuaMsg( 0, { ids = Faction_EnemyList, list1 = uv_enemy[1],list2 = uv_enemy[2],list3 = uv_enemy[3], fid = fid}, 9 )
end

--添加敌对帮会 dtype类型 1 添加 0 移除
function SetFactionEnemy(efid,dtype)
	local fid = CI_GetPlayerData(23)
	if fid == nil or fid == 0 then
		return false,0 --帮会不存在
	end
	
	if(fid == efid)then return false,6 end --添加自己帮会，这绝对不行
	
	local title = CI_GetMemberInfo(1)
	if(title<FACTION_BZ)then
		return false,1 --帮主才可以设置
	end
	
	--检查帮会ID是否有效
	local factionName = CI_GetFactionInfo(efid,1)
	if(factionName == nil or factionName == 0)then 
		if(dtype == 1)then return false,2 end --没有找到敌对帮会
	end 
	
	local data = GetFactionEnemy(fid)
	if(data == nil)then return false,3 end --获取我的敌对帮会数据失败
	
	local tempdata = GetFactionBootData()
	if(dtype == 1 and tempdata~=nil and tempdata.union~=nil and tempdata.union[fid]~=nil)then
		if(tempdata.union[fid][1] == efid or tempdata.union[fid][2] == efid)then
			return false,7 --不能把结盟帮会加入敌对帮会
		end
	end

	if(data[efid]~=nil)then
		if(dtype == 1)then 
			return false,4 --已添加
		else
			data[efid] = nil
			_SendFactionEnemy(fid)
			FactionRPC(fid,'FF_FactionMsg',0,factionName,dtype)
			return true
		end
	end
	local t = 0
	for id,v in pairs(data) do 
		if(type(id) == type(0))then
			t = t+1
		end
	end
	if(t>=3)then return false,5 end --只能添加3个
	
	data[efid] = 1
	_SendFactionEnemy(fid)
	
	FactionRPC(fid,'FF_FactionMsg',0,factionName,dtype)
	
	return true
end

--判断对方是否是敌对帮会
function isEnemyFaction(sid,pid)
	local fid = CI_GetPlayerData(23,2,sid)
	if fid == nil or fid == 0 then
		return false
	end
	
	local pfid = PI_GetPlayerFacID(pid)
	if pfid == nil or pfid == 0 then
		return false
	end
	
	local tb = GetFactionEnemy(fid)
	if(tb == nil or tb[pfid] == nil)then return false end
	
	return true
end

-------------帮会同盟------------------------------

--清除帮会同盟数据(帮会战后清除)
function ClearFactionUnion()
	local data = GetFactionBootData()
	if(data~=nil and data.union~=nil)then
		local myNmae,otherName
		local union
		for fid,v in pairs(data.union) do
			if(type(v) == type({}))then
				union = nil
				if(v[1]~=nil)then
					union = v[1]
				end
				if(v[2]~=nil)then
					union = v[2]
				end
				if(union~=nil)then
					myName = CI_GetFactionInfo(fid,1)
					otherName = CI_GetFactionInfo(union,1)
					if(myName~=nil and myName~=0 and otherName~=nil and otherName~=0)then
						SendSystemMail(fid,MailDelUnionConf1,1,1,{myName,otherName})
						SendSystemMail(union,MailDelUnionConf1,1,1,{myName,otherName})
						data.union[union] = nil
					end
				end
			end
		end
		data.union = nil
	end
	CI_ClearFriendFaction()
	BroadcastRPC('Union_Notice',2)
end

--发送帮会同盟数据
function sendFactionUnion(sid)
	local fid = CI_GetPlayerData(23,2,sid)
	local data1,data2
	if(fid~=nil and fid>0)then
		local data = GetFactionBootData()
		if(data~=nil and data.union~=nil and data.union[fid]~=nil)then
			local ufid
			local factionName,factionSign,factionLv
			if(data.union[fid][1]~=nil)then --盟主的帮会
				ufid = data.union[fid][1]
				if(type(ufid) == type(0))then
					factionName = CI_GetFactionInfo(ufid,1)
					if(factionName == nil or factionName == 0)then --帮会已解散或已不存在
						data.union[fid] = nil
					else
						factionSign = CI_GetFactionInfo(ufid,4)
						factionLv = CI_GetFactionInfo(ufid,2)
						uv_union[1] = ufid
						uv_union[2] = factionName
						uv_union[3] = factionSign
						uv_union[4] = factionLv
						data1 = uv_union
					end
				end
			elseif(data.union[fid][2]~=nil)then
				ufid = data.union[fid][2]
				if(type(ufid) == type(0))then
					factionName = CI_GetFactionInfo(ufid,1)
					if(factionName == nil or factionName == 0)then --帮会已解散或已不存在
						data.union[fid] = nil
					else
						factionSign = CI_GetFactionInfo(ufid,4)
						factionLv = CI_GetFactionInfo(ufid,2)
						uv_union[1] = ufid
						uv_union[2] = factionName
						uv_union[3] = factionSign
						uv_union[4] = factionLv
						data2 = uv_union
					end
				end
			end
		end
		SendLuaMsg( sid, { ids = Faction_UnionData, d1 = data1,d2 = data2, fid = fid}, 10 )
	end
end

--获取帮会结盟数据 t 1 同盟 2 被同盟
function get_faction_union(sid,t,facid)
	local fid = facid or CI_GetPlayerData(23,2,sid)
	if(fid~=nil and fid>0)then
		local data = GetFactionBootData()
		if(data~=nil and data.union~=nil and data.union[fid]~=nil and data.union[fid][t]~=nil)then
			return data.union[fid][t]
		else
			return fid
		end
	end
end

--请求成为帮会同盟
function applyFactionUnion(sid,fid)
	local isFF = GI_Is_Active_Live('cf')
	if(isFF)then --王城争霸期间不能结盟
		return false,13
	end
	
	isFF = GI_Is_Active_Live('ff')
	if(isFF)then  --帮会战期间不能结盟
		return false,14
	end
	--这里加入帮会战场状态的判断
	local myfid = CI_GetPlayerData(23)
	if myfid == nil or myfid == 0 then return false,0 end --没有帮会
	
	if(myfid == fid)then return false,10 end --疯了吧，和自己结盟
	
	local title = CI_GetMemberInfo(1)
	if(title~=FACTION_BZ)then return false,1 end --不是帮主没权限申请
		
	local myflv = CI_GetFactionInfo(nil,2)
	if(myflv == nil)then
		return false,0 --我的帮会不存在
	end
	
	if(myflv<5)then return false,2 end --不足5级
	
	local flv = CI_GetFactionInfo(fid,2)
	if(flv == nil)then
		return false,3 --对方的帮会不存在
	end
		
	if(myflv<flv)then
		return false,4 --盟主帮会的等级限制
	end
	
	local data = GetFactionBootData()
	if(data~=nil and data.union~=nil)then
		if(data.union[myfid]~=nil)then
			return false,5 --您已经建立了同盟关系
		elseif(data.union[fid]~=nil)then
			return false,6 --对方已经建立了同盟关系
		end
	end
	
	local edata = GetFactionEnemy(fid)
	if(edata~=nil and edata[fid]~=nil)then
		return false,9
	end
	
	--帮会资金判断
	local money = CI_GetFactionInfo(nil,3)
	if(money<faction_conf.union)then
		return false,7 --资金不足
	end
	--这里加入帮会积分的判断
	local rank = get_score_rank(2,9,myfid)
	if(rank~=nil and rank == 1)then
		return false,11
	end
	
	rank = get_score_rank(2,9,fid)
	if(rank~=nil and rank == 1)then
		return false,12
	end
	
	local bzid = CI_GetFactionLeaderInfo(fid,1)
	if(bzid~=nil and IsPlayerOnline(bzid))then
		local factionName = CI_GetFactionInfo(myfid,1)
		SendLuaMsg( bzid, { ids=Faction_UnionApply,fid=myfid,fname=factionName,lv=myflv}, 10 )
	else
		return false,8 --对方帮主不在线
	end
	
	return true
end

--审批帮会同盟 c 0 拒绝 1 同意
function checkFactionUnion(sid,fid,c)
	local isFF = GI_Is_Active_Live('cf')
	if(isFF)then --王城争霸期间不能结盟
		return false,13
	end
	
	isFF = GI_Is_Active_Live('ff')
	if(isFF)then  --帮会战期间不能结盟
		return false,14
	end

	local myfid = CI_GetPlayerData(23)
	if myfid == nil or myfid == 0 then
		return false,0 --帮会不存在
	end
	
	if(c == 1)then --同意
		if(myfid == fid)then return false,10 end --疯了吧，和自己结盟
	
		--这里加入帮会战场状态的判断
		local title = CI_GetMemberInfo(1)
		if(title~=FACTION_BZ)then return false,1 end --不是帮主
			
		local myflv = CI_GetFactionInfo(nil,2)		
		
		local flv = CI_GetFactionInfo(fid,2)
		if(flv == nil)then
			return false,3 --对方的帮会不存在
		end

		if(flv<5)then return false,2 end --不足5级
			
		if(myflv>flv)then
			return false,4 --盟主帮会的等级限制
		end
		
		local data = GetFactionBootData()
		if(data == nil)then
			return false,5 --数据出错
		end
		
		if(data.union~=nil)then
			if(data.union[myfid]~=nil)then
				return false,6 --您已经建立了同盟关系
			elseif(data.union[fid]~=nil)then
				return false,7 --对方已经建立了同盟关系
			end
		end
		
		local edata = GetFactionEnemy(fid)
		if(edata~=nil and edata[myfid]~=nil)then
			return false,8 --不能加敌对帮会
		end
		
		edata = GetFactionEnemy(myfid)
		if(edata~=nil and edata[fid]~=nil)then
			return false,8 --不能加敌对帮会
		end
		
		--帮会资金判断
		local money = CI_GetFactionInfo(fid,3)
		if(money<faction_conf.union)then
			return false,9 --资金不足
		end
		
		--这里加入帮会积分的判断
		--这里加入帮会积分的判断
	local rank = get_score_rank(2,9,myfid)
	if(rank~=nil and rank == 1)then
		return false,11
	end
	
	rank = get_score_rank(2,9,fid)
	if(rank~=nil and rank == 1)then
		return false,12
	end
		
		if(data.union == nil)then data.union = {} end
		if(data.union[myfid] == nil)then data.union[myfid] = {} end
		data.union[myfid][2] = nil
		data.union[myfid][1] = fid
		if(data.union[fid] == nil)then data.union[fid] = {} end
		data.union[fid][2] = myfid
		data.union[fid][1] = nil
		
		CI_SetFactionInfo(fid,11,myfid)
		CI_SetFactionInfo(myfid,11,fid)
		
		--扣除需要的帮会资金
		CI_SetFactionInfo(fid,3,money - faction_conf.union)
		factionMoneyAdd(math_floor(faction_conf.union*0.6),myfid)
		
		local myName = CI_GetFactionInfo(myfid,1)
		local otherName = CI_GetFactionInfo(fid,1)
		local otherSign = CI_GetFactionInfo(fid,4)
		local mySign = CI_GetFactionInfo(myfid,4)

		SendSystemMail(myfid,MailUnionConf,1,1,{myName,otherName,myName,otherName})
		SendSystemMail(fid,MailUnionConf,1,1,{myName,otherName,myName,otherName})
		
		BroadcastRPC('Union_Notice',1,fid,myfid,otherName,myName,otherSign,mySign,flv,myflv)
	else --拒绝
		local bzid = CI_GetFactionLeaderInfo(fid,1)
		if(bzid~=nil and IsPlayerOnline(bzid))then
			local factionName = CI_GetFactionInfo(myfid,1)
			SendLuaMsg( bzid, { ids=Faction_UnionRefuse,fname=factionName,fid=myfid}, 10 )
		end
	end
	
	return true
end

--解除帮会同盟
function delFactionUnion(sid,_fid)

	local isFF = GI_Is_Active_Live('cf')
	if(isFF)then --王城争霸期间不能解盟
		return false,3
	end
	
	isFF = GI_Is_Active_Live('ff')
	if(isFF)then  --帮会战期间不能解盟
		return false,4
	end
	
	local myfid
	local data
	if(_fid == nil)then
		myfid = CI_GetPlayerData(23)
		if myfid == nil or myfid == 0 then
			return false,0 --帮会不存在
		end
	
		local title = CI_GetMemberInfo(1)
		if(title~=FACTION_BZ)then return false,1 end --不是帮主
		
		data = GetFactionBootData()
		if(data==nil or data.union==nil or data.union[myfid]==nil or data.union[myfid][2]==nil)then
			return false,2 --帮会没有同盟数据
		end
		
		--帮会资金判断
		local money = CI_GetFactionInfo(nil,3)
		if(money<faction_conf.clear)then
			return false,3 --资金不足
		end
		
		CI_SetFactionInfo(myfid,3,money - faction_conf.clear)
	else
		myfid = _fid
		data = GetFactionBootData()
		if(data==nil or data.union==nil or data.union[myfid]==nil or data.union[myfid][2]==nil)then
			return false,2 --帮会没有同盟数据
		end
	end
	
	local fid = data.union[myfid][2]
	data.union[myfid] = nil
	data.union[fid] = nil
	CI_SetFactionInfo(fid,11,0)
	CI_SetFactionInfo(myfid,11,0)
	
	local myName = CI_GetFactionInfo(myfid,1)
	local otherName = CI_GetFactionInfo(fid,1)
	if(myName ~=nil and myName ~= 0 and otherName ~= nil and otherName ~= 0)then
		SendSystemMail(myfid,MailDelUnionConf,1,1,{myName,otherName})
		SendSystemMail(fid,MailDelUnionConf,1,1,{myName,otherName})
	end
	
	BroadcastRPC('Union_Notice',0,myfid,fid,myName,otherName)
	
	return true
end

SendFactionEnemy = _SendFactionEnemy