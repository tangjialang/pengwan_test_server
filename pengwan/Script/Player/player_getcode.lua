

------------------------------MD5形式激活码---------------------------------
------------------------------MD5形式激活码---------------------------------
--[[
	set_mask_pos...c++有128字节,每字节0-8
	肖老师用到65(6字节5位)
	MD5激活码领奖用110字节起1100第一个
]]--
local obj_set = require('Script.Achieve.fun')
local set_mask_pos = obj_set.set_mask_pos
local get_mask_pos = obj_set.get_mask_pos
local code_conf={
	
}
function getcode_md5( sid ,itype)
	local res=set_mask_pos(sid,itype)
end



-------------------------------数据库领奖-----------------------
-------------------------------数据库领奖-----------------------
function GetDBCardData()
	local playerid = CI_GetPlayerData(17)
	if( playerid == nil or playerid == 0 )then
		return
	end
	local codeData = GI_GetPlayerData( playerid , "code" , 200 )
	if nil == codeData then
		return
	end
	return codeData
end

--判断是否有未领取的礼包
function findisHaveCard(cardid)
	--look('判断是否有未领取的礼包')
	if(cardid~=nil)then	
		local cardData = GetDBCardData()
		if(cardData ~= nil and cardData[cardid]~=nil)then
			cardTd = cardData[cardid]
			local pakagenum = isFullNum()
			if pakagenum < cardTd.num then
				TipCenter(GetStringMsg(14,cardTd.num))
			else
				--SendLuaMsg( 0, { ids = Player_BindedCode, cTd = cardTd,cId = cardid}, 9 )
			end
		end
	else
		local cardData = GetDBCardData()
		if(cardData~=nil)then
			for i, v in pairs(cardData) do
				local cardTd = v
				if(cardTd~=nil and type(cardTd)==type({}) and cardTd.name~=nil)then
					-- TipCenter( GetStringMsg(446,cardTd.name))
					-- local pakagenum = isFullNum()
					-- if pakagenum < cardTd.num then
					-- 	TipCenter(GetStringMsg(14,cardTd.num))
					-- else
						--SendLuaMsg( 0, { ids = Player_BindedCode, cTd = cardTd,cId = i}, 9 )
						GetCardGoods(i)
					-- end
					return false
				end
			end
		end
		return true
	end
end





--新的绑定领奖码函数
function new_bindCodeFromDB(code)
	--look('新的绑定领奖码函数')
	if code==nil then return end
	if(not findisHaveCard())then return end
			
	-- --look('code='..code)
	local playerid = CI_GetPlayerData(17)
	local account = CI_GetPlayerData(15)
	local serverid = GetGroupID()
	
	if(code==nil)then
		return	
	end
	
	if(playerid==nil or account==nil or serverid==nil)then
		--look('获取角色相关信息出错！')
		return	
	end

	local call = { dbtype = 201, sp = 'p_PlayerNoviceCard' , args = 3,[1] = code , [2] = account, [3] = serverid}
	local callback = { callback = 'DBCALLBACK_NewBindCode', args = 4, [1] = "?4",[2] = "?5",[3] = "?6", [4] = "?7"}
	DBRPC( call, callback )	
end

--新的领奖回调函数
function DBCALLBACK_NewBindCode(result,cardid,cardName,rs)
	-- --look('新的领奖回调函数')
	-- --look(result)
	-- --look(cardid)
	-- --look(cardName)
	-- --look(rs)
	if(result~=nil)then
		if(result<0)then
			if(result==-1)then
				TipCenter(GetStringMsg(442))			
			elseif(result==-2)then
				TipCenter( GetStringMsg(443))			
			elseif(result==-3)then
				TipCenter(GetStringMsg(444))
			end	
		else
			----look(result..','..cardid..','..cardName)
			local cardTd
			if(cardid~=nil and cardName~=nil)then
				--[1] = { name = '265g独家礼包',goods = {{0,1000},{200,10},{40,5}} , num = 2 },	
				cardTd = {}
				cardTd.name = cardName
				cardTd.goods = {}
				cardTd.num = 0
				
				if rs ~= "" then
					local ret = string.gsplit(rs,";")
					cardTd.num = #ret
					for k, v in pairs(ret) do
						local iteminfo = string.gsplit(v,",")
						if type(iteminfo) == type({}) and #iteminfo == 2 then
							local itemIndex = tonumber(iteminfo[1])
							local itemCount = tonumber(iteminfo[2])
							table.push(cardTd.goods,{itemIndex,itemCount})
						end
					end
				end

			end

			if(cardTd == nil)then 
				TipCenter(GetStringMsg(445)) 
			else
				local cardData = GetDBCardData()
				if(cardData == nil)then cardData = {} end
				
				cardData[cardid] = cardTd		
				
				local pakagenum = isFullNum()
				local _num=cardTd.num 
				if _num==nil then return end
				if pakagenum < _num then
					TipCenter(GetStringMsg(14,_num))
				else
					--SendLuaMsg( 0, { ids = Player_BindedCode, cTd = cardTd,cId = cardid}, 9 )
					GetCardGoods(cardid)	
				end
			end
		end	
	end
	
	--SendLuaMsg( 0, { ids = Player_BindedCode}, 9 )	
end

--正式领取
function GetCardGoods(cardid)	
	--look('正式领取')
	local cardData = GetDBCardData()
	if(cardData == nil)then
		TipCenter(GetStringMsg(447)) 
		return	
	end
	--look(cardData)
	----look('cardid='..cardid)
	local cardTd = cardData[cardid]
	if(cardTd == nil)then 
		TipCenter(GetStringMsg(447)) 
		return
	end
	
	local pakagenum = isFullNum()
	if pakagenum < cardTd.num then
		TipCenter(GetStringMsg(14,cardTd.num))
		return
	else
		for i,v in pairs(cardTd.goods) do
			GiveGoods(v[1],v[2],1,"CDKEY礼包")
		end
		RPC('code_getwards',cardTd.goods,1)--领奖成功,前台显示面板
		cardData[cardid] = nil
		TipCenter(GetStringMsg(448))
	end
end


