--[[
file:	player_changehead.lua
desc:	����ͷ��
author:	wk
update:	2013-06-01
refix:	done by wk
]]--
local SendLuaMsg=SendLuaMsg
local FaceChange=msgh_s2c_def[12][28]
local GI_GetVIPLevel=GI_GetVIPLevel
local CI_GetPlayerData=CI_GetPlayerData
local CheckGoods=CheckGoods
local CI_SetPlayerData=CI_SetPlayerData
local look,SendLuaMsg = look,SendLuaMsg

local facechange_id=667 --���ݵ�������ͷ����Ҫ
local facechange_neednum={0,0,0,0,0,0,10,10,10,10,10,10,10,10,10,10}--0-2Ĭ�ϣ�3-5Ϊ����ȼ���6-15Ϊ���ݵ�
local facechange_needlv={0,0,0,50,60,70,4,5,6,7,8,0,0,0,0,0}--0-2Ĭ�ϣ�3-5Ϊ����ȼ���6-10Ϊvip�ȼ�

--����ͷ��
function Face_Change(sid,num)

	if num==nil then return end
	local neednum=0
	if  num>=3 and num<=5 then --��ͨͷ����Ҫ�ȼ�
		local lv=CI_GetPlayerData(1)--����ȼ�
		local needlv=facechange_needlv[num+1]
		if needlv==nil or   needlv>lv then 
			return 
		end		
	elseif num>=6 and num<=10 then-- --vipͷ����Ҫvip�ȼ�+����
		local viplv = GI_GetVIPLevel(sid)	
		if viplv == 0 then	 		-- ��ľ�г�ΪVIP���� ��!
			SendLuaMsg( 0, { ids = VIP_Get, res = 1, opt = 1 }, 9 )	
			return
		end
		local needlv=facechange_needlv[num+1]
		 neednum=facechange_neednum[num+1]
		if needlv==nil or neednum==nil or  needlv>viplv then 
			return 
		end	
		if not (CheckGoods(facechange_id, neednum,1,'����ͷ��') == 1) then--�۵���
			return
		end	
	elseif num>=11 and num<=15 then--����ͷ����Ҫ����
		 neednum=facechange_neednum[num+1]
		if  neednum==nil  then 
			return 
		end	
		if not (CheckGoods(facechange_id, neednum,1,'����ͷ��') == 1) then--�۵���
			return
		end	
	end
	
		local a=CI_SetPlayerData(1,num)
	if a ==0 then
		if num>5 then
			CheckGoods(facechange_id, neednum)
		end
		SendLuaMsg( 0, { ids = FaceChange,num=num}, 9 )
	end	
end