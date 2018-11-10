--[[
file:	player_changehead.lua
desc:	更换头像
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

local facechange_id=667 --易容丹，更换头像需要
local facechange_neednum={0,0,0,0,0,0,10,10,10,10,10,10,10,10,10,10}--0-2默认，3-5为人物等级，6-15为易容丹
local facechange_needlv={0,0,0,50,60,70,4,5,6,7,8,0,0,0,0,0}--0-2默认，3-5为人物等级，6-10为vip等级

--更换头像
function Face_Change(sid,num)

	if num==nil then return end
	local neednum=0
	if  num>=3 and num<=5 then --普通头像，需要等级
		local lv=CI_GetPlayerData(1)--人物等级
		local needlv=facechange_needlv[num+1]
		if needlv==nil or   needlv>lv then 
			return 
		end		
	elseif num>=6 and num<=10 then-- --vip头像，需要vip等级+道具
		local viplv = GI_GetVIPLevel(sid)	
		if viplv == 0 then	 		-- 还木有成为VIP啊！ 亲!
			SendLuaMsg( 0, { ids = VIP_Get, res = 1, opt = 1 }, 9 )	
			return
		end
		local needlv=facechange_needlv[num+1]
		 neednum=facechange_neednum[num+1]
		if needlv==nil or neednum==nil or  needlv>viplv then 
			return 
		end	
		if not (CheckGoods(facechange_id, neednum,1,'更换头像') == 1) then--扣道具
			return
		end	
	elseif num>=11 and num<=15 then--特殊头像，需要道具
		 neednum=facechange_neednum[num+1]
		if  neednum==nil  then 
			return 
		end	
		if not (CheckGoods(facechange_id, neednum,1,'更换头像') == 1) then--扣道具
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