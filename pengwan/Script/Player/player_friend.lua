--[[
file:	player_friend.lua
desc:	����ף��.
author:	wk
update:	2013-6-20
refix:	done by wk
]]--
local SendLuaMsg=SendLuaMsg
local Player_FriendLuck = msgh_s2c_def[15][5]
local Player_sp = msgh_s2c_def[15][16]
local GetPlayer=GetPlayer
local CI_GetPlayerData=CI_GetPlayerData
local PI_PayPlayer=PI_PayPlayer
local GetDBActiveData=GetDBActiveData

local Maxexp=5000000 --���exp500w

--isAdd ��ף������
local function Addfrindexp(playerid,aexp,isadd)
	local SpendData = GetDBActiveData(playerid)
	if SpendData == nil  then
		return
	end
	SpendData.fexp=(SpendData.fexp or 0) +aexp
	SpendData.ft=(SpendData.ft or 0) +1
	if SpendData.fexp>Maxexp then
		SpendData.fexp=Maxexp
	end
end

function GetFriendLuck(playerid,selfname,friendname,level,iType)
	if(level>40)then return end 
	local lv=CI_GetPlayerData(1)
	if lv>40 then return end 
	
	local sid = GetPlayer(friendname, 0)			-- ȡ��ף�����sid
	if playerid == nil or sid == nil then 
		return 
	end
	local friendData = GetDBActiveData(sid)
	local selfData = GetDBActiveData(playerid)
	
	if friendData == nil or selfData == nil then return end
	local luckExp = level * 50			
	Addfrindexp(playerid,luckExp)
	Addfrindexp(sid,luckExp,1)
	SendLuaMsg( 0, { ids=Player_FriendLuck, AddExp = luckExp, store = selfData.fexp, name = friendname}, 9 )
	SendLuaMsg( sid, { ids=Player_FriendLuck, AddExp = luckExp, iType = iType, name = selfname, store = friendData.fexp,ft =  friendData.ft }, 10 )
end

-- һ����ȡ����ף������
function GetLuckExp(playerid)
	local level=CI_GetPlayerData(1)
	if level<40 then return end 
	local SpendData = GetDBActiveData(playerid)
	if SpendData == nil or SpendData.fexp == nil then
		return
	end
	PI_PayPlayer(1, SpendData.fexp,0,0,'ף��exp')	
	SendLuaMsg( 0, { ids=Player_FriendLuck, AddExp = SpendData.fexp}, 9 )
	SpendData.fexp = nil
	SpendData.ft = nil
end

--�������  0 ��ͨ���� itype 1 ������ 2 �ǽ��
function friend_special( osid,itype )
	local res= CI_SetRelation(osid,itype) 
	--look('�������  0 ��ͨ���� itype 1 ������ 2 �ǽ��')
	SendLuaMsg( 0, { ids=Player_sp, res = res,osid=osid,itype=itype}, 9 )
end

local guaji_conf={
	[201]={30000,45},
	[202]={45000,50},
	[203]={60000,55},
	[204]={80000,60},
	[205]={120000,65},--6��
	[206]={350000,80},--7��
	[207]={400000,90},--8��
}
function limit_lv_zl( rid)
	if rid>=201 and rid<=207 then 
		local zhanli = CI_GetPlayerData(62)
		local level = CI_GetPlayerData(1)
		if  zhanli < guaji_conf[rid][1] and level < guaji_conf[rid][2] then
			TipCenter(GetStringMsg(18,guaji_conf[rid][1],guaji_conf[rid][2]))
			return
		end
	end
	return true
end
--����׷��,itype=0ֻ�۵���,1ֻ��Ǯ
function enemy_find( sid,osid ,itype)
	if not IsPlayerOnline(osid) then 
		RPC('enemy',3)--������
		return 
	end
	local cx, cy, rid,isdy = CI_GetCurPos(2,osid)
	if isdy then
		RPC('enemy',2)--����
		return
	end
	local ispk=RegionTable[rid].PKType
	
	if ispk==1 then
		RPC('enemy',1)--��pkͼ
	else
		
		local res=limit_lv_zl( rid)
		if not res then return end
		-- if rid>=201 and rid<=205 then 
		-- 	local zhanli = CI_GetPlayerData(62)
		-- 	local level = CI_GetPlayerData(1)
		-- 	if  zhanli < guaji_conf[rid][1] and level < guaji_conf[rid][2] then
		-- 		TipCenter(GetStringMsg(18,guaji_conf[rid][1],guaji_conf[rid][2]))
		-- 		return
		-- 	end
		-- end
		if itype==1 then
			if not CheckCost( sid , 50 , 1 , 1, "����׷��") then
				return
			end
			if not PI_MovePlayer(rid, cx, cy) then
				return
			end
	 		CheckCost( sid , 50 , 0 , 1, "100030_����׷��")
	 		RPC('enemy',0)--���ͳɹ�
	 	elseif itype==0 then 
	 		if not (CheckGoods( 671 , 1,1,sid,'����׷��') == 1) then
	 			return
	 		end
			if not PI_MovePlayer(rid, cx, cy) then
				return
			end
	 		CheckGoods( 671 , 1,0,sid,'����׷��')
	 		RPC('enemy',0)--���ͳɹ�	
	 	end
	end
end