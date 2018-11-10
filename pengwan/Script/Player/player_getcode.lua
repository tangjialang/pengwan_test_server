

------------------------------MD5��ʽ������---------------------------------
------------------------------MD5��ʽ������---------------------------------
--[[
	set_mask_pos...c++��128�ֽ�,ÿ�ֽ�0-8
	Ф��ʦ�õ�65(6�ֽ�5λ)
	MD5�������콱��110�ֽ���1100��һ��
]]--
local obj_set = require('Script.Achieve.fun')
local set_mask_pos = obj_set.set_mask_pos
local get_mask_pos = obj_set.get_mask_pos
local code_conf={
	
}
function getcode_md5( sid ,itype)
	local res=set_mask_pos(sid,itype)
end



-------------------------------���ݿ��콱-----------------------
-------------------------------���ݿ��콱-----------------------
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

--�ж��Ƿ���δ��ȡ�����
function findisHaveCard(cardid)
	--look('�ж��Ƿ���δ��ȡ�����')
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





--�µİ��콱�뺯��
function new_bindCodeFromDB(code)
	--look('�µİ��콱�뺯��')
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
		--look('��ȡ��ɫ�����Ϣ����')
		return	
	end

	local call = { dbtype = 201, sp = 'p_PlayerNoviceCard' , args = 3,[1] = code , [2] = account, [3] = serverid}
	local callback = { callback = 'DBCALLBACK_NewBindCode', args = 4, [1] = "?4",[2] = "?5",[3] = "?6", [4] = "?7"}
	DBRPC( call, callback )	
end

--�µ��콱�ص�����
function DBCALLBACK_NewBindCode(result,cardid,cardName,rs)
	-- --look('�µ��콱�ص�����')
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
				--[1] = { name = '265g�������',goods = {{0,1000},{200,10},{40,5}} , num = 2 },	
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

--��ʽ��ȡ
function GetCardGoods(cardid)	
	--look('��ʽ��ȡ')
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
			GiveGoods(v[1],v[2],1,"CDKEY���")
		end
		RPC('code_getwards',cardTd.goods,1)--�콱�ɹ�,ǰ̨��ʾ���
		cardData[cardid] = nil
		TipCenter(GetStringMsg(448))
	end
end


