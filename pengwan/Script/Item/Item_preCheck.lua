--[[
file:	Item_preCheck.lua
desc:	check item before use or create.
author:	chal
update:	2011-12-07
]]--
--:
local db_module =require('Script.cext.dbrpc')
local db_item_in=db_module.db_item_in
local db_item_out=db_module.db_item_out


function UseItemPreCheck( itemid )

end
--[[
---活动道具使用个数 itype=1为圣诞礼包,2经验包,3元旦礼包
4 春节抽奖道具控制
]]--
function item_tempdata( sid )
	local cData = GetPlayerTemp_custom(sid)
	if cData == nil  then return end
	if cData.itemp == nil then
		cData.itemp = {
			--[[
			[1]=1 --1为圣诞礼包
			
			]]
		}
	end
	return cData.itemp
end
--道具存储过程回调
function CALLBACK_item_out( sid ,itype,res )
	-- look('道具存储过程回调-',1)
	-- look(res,1)
	local tdata=item_tempdata( sid )
	tdata[itype]= res

end
--取道具使用个数 itype=1为圣诞礼包
function item_getnumactive( sid ,itype)
	 -- look('取道具使用个数-',1)
	local tdata=item_tempdata( sid )
	-- if tdata[itype]==nil then 
	-- 	 look('存储--取道具使用个数',1)
	-- 	db_item_out(sid ,itype)
	-- end
	 -- look(tdata,1)
	return tdata[itype] or 0
end
--增加道具使用个数
function item_addnumactive( sid ,itype)
	
	local tdata=item_tempdata( sid )
	if tdata==nil then 
		-- look('增加道具使用个数出错',1)
		return
	end
	tdata[itype]= (tdata[itype] or 0)+1
end
--下线写入存储--道具使用个数
function item_innumactive( sid )
	-- look('下线写入存储--道具使用个',1)
	local tdata=item_tempdata( sid )
	for k,v in pairs(tdata) do
		if type(k)==type(0) and type(v)==type(0) then 
			-- look(k,1)
			-- look(v,1)
			db_item_in(sid ,k,v)	
		end
	end
end
------------------------打磨相关-------------------------
------------------------打磨相关-------------------------
------------------------打磨相关-------------------------
------------------------打磨相关-------------------------

local uv_TimesTypeTb = TimesTypeTb
local CheckTimes=CheckTimes
local DayResetTimes=DayResetTimes
local Marryring = msgh_s2c_def[21][14]
local M_look = msgh_s2c_def[21][20]
--婚戒属性
function marry_attup( playerid ,itype)
	local pdata=GetPlayerMarryData(playerid)
	if pdata==nil or pdata[3]==nil then return  end
	local tempAtt=GetRWData(1)

	tempAtt[1]=rint(pdata[3][1]^2/6+25*pdata[3][1])+500--生命
	tempAtt[3]=rint(pdata[3][2]^2/18+8*pdata[3][2])+100--攻击
	tempAtt[4]=rint(pdata[3][3]^2/24+6*pdata[3][3])+80--防御
	
	--look('marry_attup',2)

	
	local quenching = pdata[5]
	local lvl = quenching[1]
	
	tempAtt[1]=tempAtt[1]+rint(25*lvl+(lvl^2/6))--生命
	tempAtt[3]=tempAtt[3]+rint(lvl*8+(lvl^2/18))--攻击
	tempAtt[4]=tempAtt[4]+rint(lvl*6+(lvl^2/24))--防御
	
	if itype then 
		PI_UpdateScriptAtt(playerid,ScriptAttType.marry)
	end
	return true
end
--使用婚戒
function marry_usering( playerid )
	local pdata=GetPlayerMarryData(playerid)
	if pdata==nil then return 0 end
	if pdata[3]~=nil then return 0 end
	pdata[3]={1,1,1}
	marry_attup( playerid ,1)
	SendLuaMsg(0,{ids = Marryring,res = 2,data=pdata[3]},9)
end
--下线写存储
function marry_logour( playerid)
	local pdata=GetPlayerMarryData(playerid)
	if pdata==nil then return  end
	return pdata[3]
end

--婚戒打磨 buy=0只用道具,1用钱,lastnum剩余个数
function marry_damo( playerid,buy,lastnum)
	local pdata=GetPlayerMarryData(playerid)
	if pdata==nil then return 0 end
	if pdata[3]==nil then return end
	if not CheckTimes(playerid,uv_TimesTypeTb.marry_ring,1,-1,1) then 
		return
	end
	local index=3
	local att1=pdata[3][1]
	local att2=pdata[3][2]
	local att3=pdata[3][3]
	if att1==att3 then 
		index=1
	elseif att1-att2==1 then 
		index=2
	end
	if pdata[3][index]>=500 then return end--500级上限
	local id=790
	local neednum=rint(pdata[3][index]/20+1)
	if buy==0 then
		if 0 == CheckGoods(id,neednum,0,playerid,'婚戒打磨') then
			-- look('强化时装1111',1)
			return
		end
	elseif buy==1 then
		if (lastnum or 0)>=1 and (lastnum or 0)<neednum then 
			if 0 == CheckGoods(id,lastnum,1,playerid,'婚戒打磨') then
				-- look('强化时装1111',1)
				return
			end
			local needmoney=10*(neednum-lastnum)
			if not (CheckCost(playerid, needmoney,0,1,'婚戒打磨')) then 
				return
			end
			if 0 == CheckGoods(id,lastnum,0,playerid,'婚戒打磨') then
				-- look('强化时装1111',1)
				return
			end
			-- look('强化时装1111',1)
		else
			local needmoney=10*neednum
			if not (CheckCost(playerid, needmoney,0,1,'婚戒打磨')) then 
				return
			end
		end
	else
		return
	end



	pdata[3][index]=pdata[3][index]+1
	CheckTimes(playerid,uv_TimesTypeTb.marry_ring,1,-1)
	marry_attup( playerid ,1)
	SendLuaMsg(0,{ids = Marryring,res = 1,data=pdata[3]},9)
end

---打磨次数重置
function marry_timereset( playerid)
	-- look('打磨次数重置',1)
	if 0 == CheckGoods(791,1,0,playerid,'打磨次数重置') then
		return
	end
	DayResetTimes(playerid,uv_TimesTypeTb.marry_ring)
	-- look('打磨次数1111重置',1)
end
 
-----gm测试
--加等级
function marry_uplv( playerid ,index,num)
	-- look(1,1)
	local xinfaData1 = GetPlayerMarryData(playerid)
	local xinfaData = xinfaData1[3]
	if xinfaData == nil then
		xinfaData1[3]={1,1,1} 
	end	
	for i=1,3 do 
		if i<=index then 
			xinfaData[i]=num
		else
			xinfaData[i]=num-1
		end
	end
	marry_attup( playerid ,1)
	SendLuaMsg(0,{ids = Marryring,res = 1,data=xinfaData},9)
end

--淬炼婚戒
local function marry_quenching_once(quenching)
	local lvl = quenching[1]
	if lvl >= 600 then return false end
	local prg = quenching[2] + 1
	local prg_next = rint(lvl/100)*10+10
	if prg >= prg_next then
		quenching[2] = 0
		quenching[1] = lvl + 1
	else
		quenching[2] = prg
	end
	return true
end

function marry_quenching(playerid,num)
	--look('marry_quenching',2)
	local quenching = GetPlayerMarryData(playerid)[5]
	
	if num then
		if 0 == CheckGoods(815,num,1,playerid,'婚戒淬炼') then
			return
		end
		local remain_num = num
		while true do
			local lvl = quenching[1]
			local mtrl_num = rint((lvl/5)+1)*2
			if remain_num < mtrl_num then break end
			if not marry_quenching_once(quenching) then break end
			remain_num = remain_num - mtrl_num
		end
		CheckGoods(815,num-remain_num,0,playerid,'婚戒淬炼')
	else
		local lvl = quenching[1]
		local mtrl_num = rint((lvl/5)+1)*2
		if 0 == CheckGoods(815,mtrl_num,0,playerid,'婚戒淬炼') then
			return
		end
		marry_quenching_once(quenching)
	end
	marry_attup( playerid ,1)

	SendLuaMsg(0,{ids = {48,4},level = quenching[1],prg=quenching[2]},9)
end