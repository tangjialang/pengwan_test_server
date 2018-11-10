--[[
file:	stong_change.lua
desc:	��ʯת��ϵͳ
author:	wk
update:	2012-12-26
refix:	done by wk
]]--
local type,pairs = type,pairs
local TipCenter,GetStringMsg	 = TipCenter,GetStringMsg
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local equip_ch	 = msgh_s2c_def[23][7]	
local isFullNum=isFullNum
local CheckGoods	 = CheckGoods
local CheckCost	 = CheckCost
local look = look
local money_base=2000 --ת����ҪǮ�Ļ���
local money_conf={270,1080,4320}--6������ʯͷת����ҪԪ��
--��ʼ��ʯת��
function stong_chg(playerid,change)
	if  playerid==nil or change==nil then
		return
	end
	local beforeID=change.stongid1
	local afterID=change.stongid2
	local num=change.num
	if type(beforeID) ~= type(0)  or type(afterID) ~= type(0)  or type(num) ~= type(0) then
		look('stong_chg:arg is nil.')
		return
	end
	if beforeID<410 or beforeID>490 or afterID<410 or afterID >490 then
		return
	end
	local pakagenum = isFullNum()--====������
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return
	end
	local stonglv1=(beforeID-400)%10+1
	local stonglv2=(afterID-400)%10+1
	if stonglv1~=stonglv2  then 
		return
	end
	
	if stonglv1<=5 then
		local money=money_base*4^(stonglv1-1)*num --ת����ʯ��Ҫ��Ǯ
		if not CheckCost(playerid, money,1,3,'ת����ʯ') then--Ǯ����
			return
		end
		if CheckGoods( beforeID, num, 0, playerid,'ת����ʯ') == 0 then--��ʯͷ�ڲ�
			return
		else
			GiveGoods(afterID,num,1,'ת����ʯ')--��ʯͷ
			CheckCost(playerid, money,0,3,'ת����ʯ')--��Ǯ
		end
	else
		local money=money_conf[stonglv1-5]*num --ת����ʯ��Ҫ��Ǯ
		look(money)
		if not CheckCost(playerid, money,1,1,'ת����ʯ') then--Ǯ����
			
			return
		end
		if CheckGoods( beforeID, num, 0, playerid,'ת����ʯ') == 0 then--��ʯͷ�ڲ�
			
			return
		else
			GiveGoods(afterID,num,1,'ת����ʯ')--��ʯͷ
			CheckCost(playerid, money,0,1,'ת����ʯ')--��Ǯ
		end
	end

	SendLuaMsg(0,{ids=equip_ch,succ=1},9)
end 