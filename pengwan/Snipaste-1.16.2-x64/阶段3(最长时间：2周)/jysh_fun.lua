--[[
file:	jysh_fun.lua
desc:	��������
author:	ct
update:	2014-7-07
]]--
identification = identification or 1

local msgh_s2c_def  = msgh_s2c_def
local msg_seed      = msgh_s2c_def[51][1] --����
local msg_open      = msgh_s2c_def[51][2] --��ʵ����
local msg_otherclick= msgh_s2c_def[51][3] --�鿴
local msg_refresh   = msgh_s2c_def[51][4] --ˢ��
local msg_obtain    = msgh_s2c_def[51][5]  --ժȡ
local msg_steal     = msgh_s2c_def[51][6]  --͵ȡ
local msg_steal_succeed = msgh_s2c_def[51][7]  -- ͵ȡ�ɹ����
local msg_restart = msgh_s2c_def[51][8]
local msg_distance = msgh_s2c_def[51][9]
local conf   = require("Script.shenshu.jysh_cof")
local jysh = conf.jysh
local tree_conf = conf.tree_conf
local open      =conf.open
local cishu    = conf.cishu   --ˢ���ܴ���
local rint = rint
local look = look
local GI_GetPlayerData = GI_GetPlayerData
local SendLuaMsg = SendLuaMsg
local CheckGoods = CheckGoods
local CI_GetPlayerData = CI_GetPlayerData
local GetServerTime = GetServerTime
local GetWorldCustomDB = GetWorldCustomDB
local npclist = npclist
local CI_GetCurPos = CI_GetCurPos
local type = type
local random=math.random
local CreateObjectIndirect = CreateObjectIndirect
local jy_TimesTypeTb = TimesTypeTb
local  SetEvent = SetEvent
local rint = rint
local PI_PayPlayer = PI_PayPlayer
local CheckCost   =  CheckCost
local CI_UpdateMonsterData = CI_UpdateMonsterData
local CreateGroundItem = CreateGroundItem
local RemoveObjectIndirect = RemoveObjectIndirect
local BroadcastRPC = BroadcastRPC
local CI_SetReadyEvent = CI_SetReadyEvent
local define		= require('Script.cext.define')
local ProBarType = define.ProBarType
local CheckTimes = CheckTimes
local CI_DelMonster = CI_DelMonster
local AreaRPC   = AreaRPC
local GetPlayerTemp_custom   =  GetPlayerTemp_custom
local GetCurPlayerID  = GetCurPlayerID
local  SendSystemMail = SendSystemMail
local MailConfig = MailConfig
local abs = math.abs
local pairs  =  pairs
local  GiveGoods  = GiveGoods
local __G = _G
local Log = Log

local tb ={}
function fa()
	local _tb = tb
end


module(...)
--��ӽ���������
---------------------------------
local function get_af_data()
	local getwc_data =  GetWorldCustomDB()
	if getwc_data == nil then return end
	if getwc_data.wc_data == nil then
	   getwc_data.wc_data = {}
	end
	return getwc_data.wc_data
end
--ÿ�η�����������ʱ����ر� ������  
local function _Data_Load(itype)
	if itype==1 then
		if  __G.identification==1 then
			 __G.identification=2
		else
			return
		end	
	end
	local wc_data =  get_af_data()
	local table_fruit ={[3]={{1503,10,1},}}
	for key, value in pairs(wc_data) do
		if type(key)==type(0) and type(value) ==type({})  then 
			local user_name = wc_data[key].name

			local hid = wc_data[key].hID
			local tree_color = (rint(hid/10))%10
			local tou       = wc_data[key].tou
			local num
		
			if 1 == tree_color then
				if 0 == tou then
					num = jysh[tree_color][1]
				elseif type(tou) == type('') then
					num = jysh[tree_color][1] - jysh[tree_color][2]
				end
			elseif 2 == tree_color then
				if 0 == tou then
					num = jysh[tree_color][1]
				elseif type(tou) == type('') then
					num = jysh[tree_color][1] - jysh[tree_color][2]
				end
			elseif 3  == tree_color then
				if 0 == tou then
					num = jysh[tree_color][1]
				elseif type(tou) == type('') then
					num = jysh[tree_color][1] - jysh[tree_color][2]
				end
			elseif 4 == tree_color then
				if 0 == tou then
					num = jysh[tree_color][1]
				elseif type(tou) == type('') then
					num = jysh[tree_color][1] - jysh[tree_color][2]
				end
			end
			
			table_fruit[3][1][2] = num
			SendSystemMail(user_name,MailConfig.Jysh_buchang,1,2,nil,table_fruit)
			wc_data[key] = nil
		end
	end	
end
--����ռ�
local function jysh_userData(playerid)
    local data = GI_GetPlayerData(playerid,"jysh",16)
    --data[1]  ����id 
    return data
end
-- �жϷ�����������ʱ�������û����� ����������
--	�Ѿ����������� nil ���򷵻����ݿ�
local function user_check(playerid)
	local wc_data = get_af_data()
	local data = jysh_userData(playerid)
	if nil == data then
		return  
	end
	if data[1] and  wc_data[data[1]] == nil and (not IsSpanServer()) then
		data[1] = nil
		SendLuaMsg(0,{ids=msg_restart},9)
		return data,1
	end
	return data
end
--�жϲ������� �Ƿ����Զ
local function tree_distance(npc_gid)
	local wc_data = get_af_data()
	local tree_data = wc_data[npc_gid]
	if nil == tree_data then
		return 1
	end
	local user_x,user_y,rid,maGid = CI_GetCurPos()
	if rid ~= tree_data.reg then
		SendLuaMsg(0,{ids=msg_distance },9)
		return 1
	end
	local x = abs(tree_data.x - user_x)
	local y = abs(tree_data.y - user_y)
	if x > 4 or y > 4 then
		SendLuaMsg(0,{ids=msg_distance },9)
		return 1
	end
	return 0
end
--����������ʵ͵ȡ
function _Jysh_user_steal()
	local wc_data = get_af_data()
--	look('����������ʵ͵ȡ')
	local playerid = GetCurPlayerID()   -- ��ȡ��ǰ��ҵ�id
	local user_custom  = GetPlayerTemp_custom(playerid)
	if user_custom == nil then
			return
	end
	local npc_gid = user_custom.stree_id
	local val_tree = tree_distance(npc_gid)
	if 1 == val_tree then
		return
	end
	local tree_data = wc_data[npc_gid]
	if nil == tree_data then
		return
	end
	local hid = rint(tree_data.hID/100)
	if type(tree_data.tou) == type('') or hid == 2 then
		return
	end
	local user_name = user_custom.sname
	local user_type = tree_data.hID
	local npc_type = (rint(user_type /10))%10
	local scene = jysh[npc_type][2]
	local count = 0
	local tree_num =jysh[npc_type][2]
	local item_x = tree_data.x
	local item_y = tree_data.y
	local itemid = 1503   --����ID
--look("�Լ�͵ȡ")
	tree_data.hID =  2*100 +  (rint(user_type/10)%10)*10 +  user_type%10
    user_type  = tree_data.hID
	local t = {headID=user_type}
	CI_UpdateMonsterData(1,t,nil,4,npc_gid,12) --��������
	AreaRPC(4,npc_gid,12,"jysh_refresh",tree_data.hID,npc_gid,nil)
	tree_data.tou = user_name
	for i =1,tree_num  do
--		look("��ʵ������1")
		CreateGroundItem(12,0,itemid,1,item_x,item_y,count)
		count = count +1
	end

end
--��ֲ
    --seed �������� 0 ��ʾ��ͨ���ӣ�1 ��ʾ��ʾ�������

local function _jysh_plant(playerid,seed)
	local data  = user_check(playerid)
	if nil == data then
		return 	
	end
	if data[1]  then
		return
	end
	local user_grade = CI_GetPlayerData(1)   --��ȡ�û��ȼ�
	if nil == user_grade or user_grade < 50 then
        return 
	end
	if seed ~= 1 and seed ~= 0 then
        return 
	end
	local  timetype=jy_TimesTypeTb.NPC_shenshu
	if not CheckTimes(playerid,timetype,1,-1,1) then return end
	local user_x,user_y,rid,maGid = CI_GetCurPos()
	if  12 ~= rid then
        return 
	end
   --��ȡ�û�������
	local user_name = CI_GetPlayerData(5,2,playerid)

   --�������ݱ�
     --[[200001 ��ͨ 200002 ��ʾ������� ]]
    --��ȡgid
    local  tree_id
    if 0 == seed then
        tree_id = 1501
    elseif 1 == seed then
        tree_id = 1502
    end
    local user_ntype
    if 1501 == tree_id then
         user_ntype = 111
    elseif 1502 == tree_id then
         user_ntype = 141
    end
    if nil == user_ntype then
        return 
    end
    if CheckGoods(tree_id ,1,1,playerid,"��������") ~= 1 then
        return 
    end
    CheckGoods(tree_id ,1,0,playerid,"��������")
	CheckTimes(playerid,timetype,1,-1) 
   --- local  tree_data = {monsterId = 513,deadbody = 6,IdleTime = 300,aiType = 1539,camp = 4}
   --������ ��NPC�� 
    local tree =  tree_conf
	local user_npc
    if type(tree_conf) == type({}) then
        tree.name = user_name
        tree.headID = user_ntype
        tree.x = user_x
        tree.y = user_y
        user_npc = CreateObjectIndirect(tree)
    end
    if nil ==  user_npc then
        return 
    end 
   --[[NPC��id���û�����͵���û�����ʱ��]] 
    data[1] = user_npc
	-- look('user_npc')
	-- look(user_npc)
    local user_time =GetServerTime()
	--��ע��
	local wc_data = get_af_data()
	--[[name :��ֲ�û���   �� ripe  ������ʱ��   ��num  :ˢ�´��� ��hID  ͵û��͵�� �������� ���ӵ��ͺţ�x��y �������꣬reg ����ͼ��� ��tou��͵�������֣�sid�����û���id,]]
    look('playerid')
    look(playerid)
    wc_data[user_npc]={name = user_name,ripe =user_time+3600,num = cishu,hID = user_ntype,x = user_x,y=user_y,reg = 12,tou = 0,sid= playerid}
	--getwc_data.wc_data[user_npc] = wc_data[user_npc]
	SetEvent(3600,nil,"GI_jysh_time",user_npc)
    SendLuaMsg(0,{ids=msg_seed ,npc_id = user_npc},9)
end

--ˢ��
    --playerid��ʾ����ŵ�id   �� NCP de gid  look_tree 0 >��ʾ �鿴  0 =��ʾˢ��
local function _jysh_renovate(playerid)
	local wc_data = get_af_data()
	local data = user_check(playerid)
	if nil == data then
		return
	end
	if nil == data[1] then
		return
	end
	--����˵��������Ϊ׼
	local npc_gid  = data[1]
	local val_tree = tree_distance(npc_gid)
	if 1 == val_tree  then
		return
	end
	local tree_data = wc_data[npc_gid]
	local old_time = tree_data.ripe - 3600
    local now_time = GetServerTime()    --��ȡ��ǰʱ��
	if (now_time - old_time) > 3600 then
		return
	end
	local user_type = tree_data.hID
	if nil ==  user_type then
		return 
	end
	local tree_color = (rint(user_type/10))%10   
	if tree_color < 1 or tree_color >4 then
		return
	end
	if tree_data.num <= 0 or 4 == tree_color then
		SendLuaMsg(0,{ids=msg_refresh},9) 
		return
	end
	--����ˢ�½��
	if 1 == tree_color  then
		tree_color  = tree_color +1
	elseif 2 == tree_color  then
		local probability = random(10)
		if 5 >= probability then
			tree_color  = tree_color  +1
		elseif 5< probability then
			tree_color  = tree_color  - 1
		end
	elseif 3 == tree_color  then
		local probability = random(10)
		if 3 >= probability then
			tree_color  = tree_color  + 1
		elseif 3 < probability then
			tree_color  = tree_color  - 1
		end
	end
	
	tree_data.num = tree_data.num - 1
	SendLuaMsg(0,{ids=msg_refresh,tree_color = tree_color,num = tree_data.num},9)
	user_type = (rint(user_type/100))*100 + tree_color*10 + (user_type%10)
	tree_data.hID = user_type
	AreaRPC(4,npc_gid,12,"jysh_refresh",user_type,npc_gid,nil)
	CI_UpdateMonsterData(1,{headID=user_type},nil,4,npc_gid,12) --��������
end
--�鿴��
local function _jysh_look(playerid,npc_gid,look_tree)
	local val1,val2 = user_check(playerid)
	if 1 == val2 then
		return
	end
	local wc_data = get_af_data()
    SendLuaMsg(0,{ids=msg_otherclick,wc_data[npc_gid],look_tree= look_tree,npc_id = npc_gid },9)
end
--ժȡ,͵ȡ
 --playerid��ʾ����ŵ�id    �� npc_gid NCP de gid  
local function _jysh_obtain(playerid,npc_gid)
	local wc_data = get_af_data()
	local tree_data = wc_data[npc_gid]
	if nil == tree_data then
		return
	end
	local old_time = tree_data.ripe - 3600
    local now_time = GetServerTime()    --��ȡ��ǰʱ��
	if (now_time - old_time) < 3600 then
		return
	end
    local data = user_check(playerid)
    if nil == data then
        return 
    end
	local val_tree = tree_distance(npc_gid)
	if 1 == val_tree  then
		return
	end
	local user_npc = data[1] 
    local item_x = tree_data.x
    local item_y = tree_data.y	
    local user_name =CI_GetPlayerData(5,2,playerid)
    local user_sid =CI_GetPlayerData(1,2,playerid)
	local user_type = tree_data.hID
    local whether = (rint(user_type/100))%10
    local npc_type  = (rint(user_type /10))%10
    local tree_num  --��������
	local mapid = tree_data.reg
    local itemid = 1503   --����ID
    local i = 1
    if user_npc ~= npc_gid and user_sid ~= tree_data.sid then
		if user_name == tree_data.name then
			Log('jysh.txt',tree_data)
			Log('jysh.txt',user_name)
			Log('jysh.txt',user_npc)
			Log('jysh.txt',npc_gid)
		end
        if 2 == whether then
            return 
        elseif 1 == whether and type(tree_data.tou) ~= type('') then
			local user_custom  = GetPlayerTemp_custom(playerid)
			if user_custom == nil then
				return
			end
			user_custom.stree_id = npc_gid
			user_custom.sname    = user_name
            local sid = tree_data.sid
            SendLuaMsg(sid,{ids=msg_steal_succeed,x=item_x,y=item_y,tou = tou ,name = user_name},10)
		  --  AreaRPC(4,user_npc,12,"jysh_refresh",user_type,user_npc,nil)
            local defeated = CI_SetReadyEvent(0,ProBarType.collect,10,1,"GI_Jysh_CDtime")		
		end
    elseif  user_npc == npc_gid or user_sid == tree_data.sid then
		local tree_num
        if 1 == whether then
			tree_num =jysh[npc_type][2]*3
        elseif 2 == whether then
			tree_num =jysh[npc_type][2]*2   
        end
		if nil == tree_num then
			return 
		end
		CI_DelMonster(12,npc_gid)
	--	look("�Լ�ժȡ")
		local tou  = wc_data[npc_gid].tou
		SendLuaMsg(0,{ids=msg_obtain,num = tree_num,tou = tou,tree_color = npc_type,hID = tree_data.hID  },9) 
        data[1] = nil
        wc_data[npc_gid]= nil
		local count = 0
	    for i =1,tree_num do
	--	look("��ʵ������2")
			CreateGroundItem(12,0,itemid,1,item_x,item_y,count)
			count = count +1
	    end     
    end 
end
--��ʵ����
    -- fruit_type ��ʵ����  1 ΪС  2 ΪΪ�� 3 Ϊ��
    --money ����0  ��ʾ������   1 ��ʾ ������
local function _jysh_open(playerid,fruit_type,money)
	if fruit_type < 0 or fruit_type > 4 then
		return
	end
	if money ~= 0 and money ~= 1 then
		return
	end

    local  timetype=jy_TimesTypeTb.NPC_open
    if not CheckTimes(playerid,timetype,1,-1,1) then  return    end
	local i =1 
    local  user_grade = CI_GetPlayerData(1)
	if user_grade < 0 then
		return
	end
    if user_grade > 75 then
        user_grade = 75
    end
    local grade = user_grade 
    if 1 == money  then
        if  fruit_type <= 3 then
          --INT(��ҵȼ�^5/2000)
            grade = user_grade^5
            local  experience = rint((grade)/open[fruit_type][1])
	        if CheckGoods(1502+fruit_type,1,1,playerid,"�����龭��") ~= 1 then
				return 
			end
   --         look("�����龭��")
			CheckGoods(1502+fruit_type,1,0,playerid,"�����龭��")
            PI_PayPlayer(1, experience,0,0,'����������')
			SendLuaMsg(0,{ids=msg_open,fruit_type = fruit_type  },9)			   
        end  
      elseif 0 == money then
          if  fruit_type <= 3 then
			grade = user_grade^5
			local  experience = rint((grade)/open[fruit_type][1])*2
			local  yuanbao = rint(rint(experience/2)/100000)
			if  CheckCost (playerid,yuanbao,1,1,"������˫������") == false then		  
				return 
			end 
			if CheckGoods(1502+fruit_type,1,1,playerid,"�����龭��") ~= 1 then
				return 
			end
			--INT(��ҵȼ�^5/2000)
			CheckCost (playerid,yuanbao,0,1,"������˫������")
			CheckGoods(1502+fruit_type,1,0,playerid,"�����龭��")
			PI_PayPlayer(1, experience,0,0,'������˫������')
			--              look("������˫������")       
		end
			SendLuaMsg(0,{ids=msg_open,fruit_type = fruit_type  },9)  
      end
      CheckTimes(playerid,timetype,1,-1)
end

function _Jysh_tree_time(user_npc)
	local wc_data = get_af_data()
	if nil == user_npc then
		return 
	end
	local tree_data = wc_data[user_npc]
	local user_type = tree_data.hID
    local x = tree_data.x
    local y = tree_data.y
	local reg = tree_data.reg
    local name = tree_data.name
	local npc_type = (rint(user_type /10))%10
	local form = 1112
	if npc_type == 3 then
		form = 1113
	elseif npc_type == 4 then
		form = 1114
	end
	local res=CI_UpdateMonsterData(1,{imageID = form},nil,4,user_npc,12) --��������
--	look(form)
    if form == 1113 or form == 1114 then
        BroadcastRPC("jysh_world",x,y,name,npc_type,reg)   
		--����㲥
    end
	AreaRPC(4,user_npc,12,"jysh_refresh",user_type,user_npc,form)
	SendSystemMail(name,MailConfig.Jysh_fruit,1,2)
    return false
end

function jysh_clear(sid)
	local data = jysh_userData(sid)
	if not data then return end
	local wc_data = get_af_data()
	for k,v in pairs(wc_data) do
		if v.sid == sid then
			wc_data[k] = nil
			CI_DelMonster(12,k)
			data[1] = nil
		end
	end
end

jysh_plant     = _jysh_plant
jysh_renovate  = _jysh_renovate
jysh_obtain    = _jysh_obtain
jysh_open      = _jysh_open
jysh_num       = _jysh_num
Jysh_tree_time = _Jysh_tree_time
Jysh_user_steal=_Jysh_user_steal
jysh_look      = _jysh_look
Data_Load      = _Data_Load