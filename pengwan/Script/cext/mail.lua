--[[
file:	mail_interface.lua
desc:	system mail interface
author:	
update:	2013-06-01
refix: done by chal
]]--
--------------------------------------------------------------------------
--include:
local tostring = tostring
local type = type
local GetStringMsgEx = string.format_ex
local look = look
local SendLuaMsg = SendLuaMsg
local CI_SendSystemMail = CI_SendSystemMail
local DGiveP = DGiveP
local GiveGoods = GiveGoods
local time_cnt=require('Script.common.time_cnt')
local GetMonthMaxDays=time_cnt.GetMonthMaxDays
local db_module = require('Script.cext.dbrpc')
local rollback_give_mail_item = db_module.rollback_give_mail_item
local TipCenter,GetStringMsg = TipCenter,GetStringMsg
local GetServerTime = GetServerTime
local CI_GetFactionInfo = CI_GetFactionInfo
local Mail_GiveItem = msgh_s2c_def[15][9]
local CI_GetPlayerData = CI_GetPlayerData
local __G = _G
--------------------------------------------------------------------------
--inner:

local uv_MailTb = { title = "nil" , content = "nil" , award = nil }

-- sid == nil 发送全服邮件
-- MailType = 2 系统邮件
-- MailType = 15 战报邮件
local function _SendSystemMail(sid,config,num,MailType,Contents,AwardList,StayMin,bAll)
	--look('_SendSystemMail:' .. MailType)
	if  not (bAll  or sid) then 
		look(bAll,2)
		look(sid,2)
		look('_SendSystemMail Error!',2);
		return 
	end
	--if sid==nil then return end ---出于安全考虑,先屏蔽掉全服邮件发送20140526
	if config == nil or type(config) ~= type({}) then
		look("SendSystemMail Parameter error")
		return
	end
	if MailType == nil or (MailType ~= 2 and MailType ~= 15 and MailType ~= 1 ) then return end
	local MailConf = config[num]
	if MailConf == nil then
		look("SendSystemMail MailConf == nil")
		return
	end

	local tmpStr = nil
	-- 邮件标题
	uv_MailTb.title = MailConf.title			
	
	-- 邮件内容
	if MailType == 1 then
		if Contents == nil then
			tmpStr = MailConf.content
		else
			tmpStr = GetStringMsgEx(MailConf.content,Contents)		
		end
		uv_MailTb.content = tmpStr
	elseif MailType == 2 then
		if MailConf.title == "宝石迷阵活动奖励" then 
			uv_MailTb.content = Contents
		else
			if Contents == nil then
				tmpStr = MailConf.content
			else
				tmpStr = GetStringMsgEx(MailConf.content,Contents)		
			end
			uv_MailTb.content = tmpStr
		end
	elseif MailType == 15 then
		uv_MailTb.content = Contents
	end
	
	-- 邮件附件
	if AwardList == nil then
		uv_MailTb.award = MailConf.award
	else
		uv_MailTb.award = AwardList
	end
	local stays = StayMin or 15*24*60
	look(uv_MailTb)
	local ret
	if sid == nil then		
		ret = CI_SendSystemMail("",MailType,stays,uv_MailTb)
	else
		if type(sid) == type(0) then
			local name
			if MailType == 1 then
				name = CI_GetFactionInfo(sid,1)
				if type(name) == type('') then 
					ret = CI_SendSystemMail(name,MailType,stays,uv_MailTb)
					FactionRPC(sid,'faction_mail')		-- 帮会邮件通知
				end				
			else
				name = CI_GetPlayerData(5,2,sid)
				if type(name) == type('') then
					ret = CI_SendSystemMail(name,MailType,stays,uv_MailTb)
				else
					ret = CI_SendSystemMail(tostring(sid),MailType,stays,uv_MailTb)
				end				
			end			
		elseif type(sid) == type("") then
			ret = CI_SendSystemMail(sid,MailType,stays,uv_MailTb)
		end
	end	
	look('CI_SendSystemMail:' .. tostring(ret))
end

local function _CALLBACK_GetItemFromMail(sid,MailID,itemID,itemNum,content,mtype,createtime,ret)
	look("CALLBACK_GetItemFromMail")
	look(ret)
	look(sid)
	look(MailID)
	look(itemID)
	look(content)
	look(mtype)
	look(createtime)
	if ret == nil or sid == nil or MailID == nil or mtype == nil or createtime == nil or itemID == nil then 
		return 
	end	
	if ret == 1 then			-- 取成功了
		--[[if mtype == 1 then 		--宝石迷阵活动奖励邮件
			if content.title == "宝石迷阵活动奖励" then 
				--入帮小于24小时
				local name = CI_GetPlayerData(3)
				local AwardTb = {[3] = {[1] = {0,0,1},},}
				local join = __G.get_join_factiontime(sid)
				local now = GetServerTime()
				look("JOIN")
				look(join)
				look("now")
				look(now)
				if now - join >= 24*60*60 then
					if name == content.content[1] then
						AwardTb = {[3] = {[1] = {0,2000000,1},},}
					elseif name == content.content[2] or name == content.content[3] then
						AwardTb = {[3] = {[1] = {0,1000000,1},},}
					elseif name == content.content[4] or name == content.content[5] or name == content.content[6] or name == content.content[7] or name == content.content[8] or name == content.content[9] or name == content.content[10] then
						AwardTb = {[3] = {[1] = {0,500000,1},},}
					else
						AwardTb = {[3] = {[1] = {0,200000,1},},}
					end
				end
				_GiveAward(AwardTb)
			end]]--
		if mtype == 16 then		-- 竞技场排行榜奖励邮件(后台根据排名给奖励/只有称号奖励)
			if itemID == 1 then
				SetPlayerTitle(sid,22,itemNum + 7*24*3600)
			elseif itemID >= 2 and itemID <= 10 then
				SetPlayerTitle(sid,23,itemNum + 7*24*3600)
			end			
			SendLuaMsg( 0, { ids = Mail_GiveItem, MailID = MailID, res = 1 }, 9 )
			return
		end
		if itemID == -1 then	-- 元宝
			if itemNum and itemNum > 0 then
				DGiveP(itemNum, "邮件附件:" .. tostring(MailID))
			end
		elseif itemID == 0 then	-- 附件在content.award
			if type(content) == type({}) and type(content.award) == type({}) then
				local AwardTb = content.award
				if AwardTb[9] and type(AwardTb[9]) == type({}) then	-- 对于时效性称号要设置过期时间
					local t = AwardTb[9][1]
					if type(t) == type({}) then
						if t[2] == 30*24*3600 then
							local mdays = GetMonthMaxDays(createtime)
							t[2] = mdays*24*3600
						end
						t[2] = (t[2] or 0) + createtime - 600
					end
					t = AwardTb[9][2]
					if type(t) == type({}) then
						if type(t[1]) == type({}) then
							if t[1][2] == 30*24*3600 then
								local mdays = GetMonthMaxDays(createtime)
								t[1][2] = mdays*24*3600 
							end
							t[1][2] = (t[1][2] or 0) + createtime - 600
						end
						if type(t[2]) == type({}) then
							if t[2][2] == 30*24*3600 then
								local mdays = GetMonthMaxDays(createtime)
								t[2][2] = mdays*24*3600
							end
							t[2][2] = (t[2][2] or 0) + createtime - 600
						end
					end
				end
				look(AwardTb)
				local getok = award_check_items(AwardTb)
				if not getok then
					look("getok")
					SendLuaMsg( 0, { ids = Mail_GiveItem, MailID = MailID, res = 0 }, 9 )
					rollback_give_mail_item(sid,MailID)
					return
				end
				local ret = GI_GiveAward(sid,AwardTb,'邮件附件')
				if not ret then
					look("ret")
					SendLuaMsg( 0, { ids = Mail_GiveItem, MailID = MailID, res = 0 }, 9 )
					rollback_give_mail_item(sid,MailID)
					return
				end
			end
		elseif itemID > 0 then	-- 附件{itemID,itemNum}(拍卖行相关道具不绑定)
			if itemNum and itemNum >0 then
				local succ, retCode, num = GiveGoods(itemID,itemNum,0,"邮件附件道具")
				if not succ and retCode == 3 then
					TipCenter(GetStringMsg(14,num))
					SendLuaMsg( 0, { ids = Mail_GiveItem, MailID = MailID, res = 0 }, 9 )
					rollback_give_mail_item(sid,MailID)
					return			
				end
			end
		end
		look('Mail_GiveItem success!')
		SendLuaMsg( 0, { ids = Mail_GiveItem, MailID = MailID, res = 1 }, 9 )
	else
		SendLuaMsg( 0, { ids = Mail_GiveItem, MailID = MailID, res = 0 }, 9 )	
	end	
end

--------------------------------------------------------------------------
--interface:

CALLBACK_GetItemFromMail = _CALLBACK_GetItemFromMail
SendSystemMail = _SendSystemMail

