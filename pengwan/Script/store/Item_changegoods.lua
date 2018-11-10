--[[
file:	Item_changegoods.lua
desc:	换道具
author:	wk
update:	2013-12-02
]]--
--:
local c_goods	 = msgh_s2c_def[24][6]	


--可换几种配几种,yb=10为需要10元宝,后面为置换道具
local change_itemconf={
--	骑兵
	[747]={
		title = "骑兵宝箱",
		[1]={yb=0,goods={{710,3,1},},},
		[2]={yb=18,goods={{738,1,1},{710,3,1},},},
		[3]={yb=48,goods={{786,1,1},{738,1,1},{710,3,1},},},
		[4]={yb=68,goods={{52,1,1},{786,1,1},{738,1,1},{710,3,1},},},
	},
	--坐骑
	[748]={
		title = "坐骑礼包",
		[1]={yb=0,goods={{636,5,1},},},
		[2]={yb=18,goods={{738,1,1},{636,5,1},},},
		[3]={yb=48,goods={{785,1,1},{738,1,1},{636,5,1},},},
		[4]={yb=68,goods={{52,1,1},{785,1,1},{738,1,1},{636,5,1},},},
	
	},
	--女神
	[749]={
		title = "女神礼包",
		[1]={yb=0,goods={{634,5,1},},},
		[2]={yb=18,goods={{738,1,1},{634,5,1},},},
		[3]={yb=48,goods={{784,1,1},{738,1,1},{634,5,1},},},
		[4]={yb=68,goods={{52,1,1},{784,1,1},{738,1,1},{634,5,1},},},
	},
}

function change_goods( sid,itemid,itype )
	look(itemid)
	look(itype)
	if change_itemconf[itemid] ==nil or change_itemconf[itemid][itype] ==nil then return end
	local money=change_itemconf[itemid][itype].yb
	local goods=change_itemconf[itemid][itype].goods

	local pakagenum = isFullNum()
	if pakagenum < #goods then
		TipCenter(GetStringMsg(14,#goods))
		return
	end

	if not (CheckGoods(itemid, 1,1,sid,'四选一'..tostring(itemid)..'_'..tostring(itype)) == 1) then 
		return
	end
	if money>0 then 
		if not CheckCost( sid , money , 0 , 1, '四选一'..tostring(itemid)..'_'..tostring(itype)) then
			return
		end
	end
	CheckGoods(itemid, 1,0,sid,'四选一'..tostring(itemid)..'_'..tostring(itype))
	GiveGoodsBatch( goods,'四选一'..tostring(itemid)..'_'..tostring(itype))
	SendLuaMsg(0,{ids=c_goods,itemid=itemid,itype=itype},9)
end
