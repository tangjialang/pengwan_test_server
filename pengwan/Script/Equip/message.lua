--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local Enhance_Equip=Enhance_Equip
local Equip_drill=Equip_drill
local Equip_instone=Equip_instone
local Equip_outstone=Equip_outstone
local EquipDecompose=EquipDecompose
local stong_chg=stong_chg
local equip_combi=equip_combi
local Enhance_XL=Enhance_XL
local Enhance_XLsave=Enhance_XLsave
local stone_enhance=stone_enhance
local Purify_start=Purify_start
local Weapon_addlight=Weapon_addlight
local Restore_Equip=Restore_Equip
--------------------------------------------------------------------------
-- data:
msgDispatcher[19][1] = function (playerid,msg)

	if msg.equip_type==1 then --强化
		Enhance_Equip(playerid,msg.enhance)
	elseif msg.equip_type==2 then --打孔
		Equip_drill(playerid,msg.holedata)
	elseif msg.equip_type==3 then --镶嵌
		Equip_instone(playerid,msg.inset)
	elseif msg.equip_type==4 then --拆除
		Equip_outstone(playerid,msg.outst)
	elseif msg.equip_type==5 then --分解
		EquipDecompose(playerid,msg.indexFrom)
	elseif msg.equip_type==6 then --转换
		stong_chg(playerid,msg.ch)
	elseif msg.equip_type==7 then --合成
		equip_combi(playerid,msg.comb,msg.stype,msg.auto,msg.last)
	elseif msg.equip_type==8 then --洗炼
		Enhance_XL(playerid,msg.xl)	
	elseif msg.equip_type==9 then --保存洗炼
		Enhance_XLsave(playerid,msg.issave)	
	elseif msg.equip_type==10 then --强化还原	
		Restore_Equip(playerid,msg.outst,msg.id,msg.x,msg.y)
	end
end
--玉石纯化
msgDispatcher[19][2] = function (playerid,msg)
	stone_enhance(playerid,msg.num)
end
--玉石纯化--初始化
msgDispatcher[19][3] = function (playerid,msg)
	Purify_start(playerid)
end
--武器附灵
msgDispatcher[19][4] = function (playerid,msg)
	Weapon_addlight(playerid,msg.enhance)
end
--装备升星
msgDispatcher[19][5] = function (playerid,msg)
	equip_starup(playerid,msg.enhance)
end