--[[
file:	card_func.lua
desc:	卡牌系统
author:	wk
update:	2013-8-7
]]--

local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local skill_buff	 = msgh_s2c_def[42][1]		
local gl_buff	 = msgh_s2c_def[42][2]		
local xd_buff	 = msgh_s2c_def[42][3]		
local zb_buff	 = msgh_s2c_def[42][4]
local qh_res	 = msgh_s2c_def[42][5]		
local look = look
local ScriptAttType = ScriptAttType
local pairs,type = pairs,type
local RPC=RPC
local CI_GetCurPos=CI_GetCurPos
local __G=_G
--local PI_UpdateScriptAtt=PI_UpdateScriptAtt
local CheckGoods=CheckGoods
local GetRWData=GetRWData
local BroadcastRPC=BroadcastRPC
local AddPlayerPoints=AddPlayerPoints
local GI_GetPlayerData=GI_GetPlayerData
local CI_GetPlayerData=CI_GetPlayerData

local card_conf=require("Script.card.card_conf")
local card_useid_conf=card_conf.card_useid_conf
local card_att_conf=card_conf.card_att_conf
local CI_SetSkillLevel=CI_SetSkillLevel
local _ceil=math.ceil
local CI_UpdateBuffExtra=CI_UpdateBuffExtra
local CI_HasBuff,CI_DelBuff,CI_AddBuff= CI_HasBuff,CI_DelBuff,CI_AddBuff
local _random=math.random
local CheckCost=CheckCost
local GetPlayerPoints=GetPlayerPoints
local rint,tostring=rint,tostring
local ScriptGidType=ScriptGidType
local SI_getgid_Object=SI_getgid_Object
local AreaRPC=AreaRPC
local CI_SelectObject=CI_SelectObject
local CI_GetSkillLevel=CI_GetSkillLevel
local mathfloor,mathrandom = math.floor,math.random
local GiveGoods,CheckGoods,isFullNum = GiveGoods,CheckGoods,isFullNum
local SendLuaMsg,TipCenter,GetStringMsg = SendLuaMsg,TipCenter,GetStringMsg
local needmoney=50--洗点需要的钱
local needid=804 --强化
-------------------------------------------------------------------
module(...)
-------------------------------------------------------------------
--定义玩家卡牌数据区
local function get_carddata( playerid )
	local card_data=GI_GetPlayerData( playerid , 'card' , 400 )
	-- look(card_data)
	if card_data.asl == nil then 
		-- if card_data[1]==nil then
			-- card_data[1]={}
			-- card_data[2]={}
			-- card_data[3]={}
			-- card_data[4]={}
			-- card_data[5]={}
			-- card_data.sl=0---老神力值
			card_data.nsl=1---新神力值
			card_data.asl=1---神力值历史最大值
			-- card_data.get=3---领取记录,3代表领到第3套
			-- card_data.us={}---使用中的3个技能buff
			-- card_data.have={}---拥有的buff,id为key,值为等级
			-- card_data.gl={}---装备技能触发概率
		-- end
	end
	return card_data
end
-- --得到神力等级
-- local function card_getsllv( sl )
-- 	local slconf=card_att_conf.att_sl
-- 	for i=1,10 do
-- 		if slconf[i] then
-- 			if sl<slconf[i].slup then
-- 				return i-1
-- 			end
-- 		end
-- 	end
-- 	return 0
-- end
-- --设置觉醒技能
-- local function card_setskill( lv )
-- 	local school = CI_GetPlayerData(2)
-- 	if school == 1 then
-- 		local a=CI_SetSkillLevel(1,108,lv,12)
-- 		look(a)
-- 	elseif school == 2 then
-- 		CI_SetSkillLevel(1,123,lv,12)
-- 	elseif school == 3 then
-- 		CI_SetSkillLevel(1,124,lv,12)
-- 	end
-- end
-- --人物属性更新
-- local function _card_upatt(playerid,zhang)	
-- 	local carddata=get_carddata( playerid )
-- 	if carddata==nil then return end
-- 	local AttTable =GetRWData(1)
-- 	local sl=carddata.sl or 0
-- 	local lv=card_getsllv(sl) --神力值对应等级
-- 	local att_conf=card_att_conf.att_sl[lv]
-- 	if att_conf==nil then return end
-- 	for k,v in pairs(att_conf) do
-- 		if type(k)==type(0) and type(v)==type({}) then
-- 			AttTable[v[1]]=v[2]
-- 		end
-- 	end

-- 	if zhang then --通关更新
-- 		__G.PI_UpdateScriptAtt(playerid,ScriptAttType.card)--  更新脚本增加的玩家属性
-- 	end

-- 	return true
-- end
--属性配置,6张卡属性激活,强化公式因子
local att_newconf={
	[1]={
		[3]={100,50,10,2,20},--攻击
		[9]={50,25,5,2,40},--格挡
	},
	[2]={
		[4]={100,50,10,2,20},--防御
		[5]={50,25,5,2,40},--命中
	},
	[3]={
		[1]={500,250,30,2,1},--气血
		[7]={50,25,5,2,40},--暴击
	},
	[4]={
		[3]={100,50,10,2,20},--攻击
		[6]={50,25,5,2,40},--回避
	},
	[5]={
		[4]={100,50,10,2,20},--防御
		[8]={50,25,5,2,40},--防爆
	},
	[6]={
		[1]={500,250,30,2,1},--气血
		[5]={50,25,5,2,40},--命中
	},
}

local skill_buff_conf={
	 	--1.buff升级最大等级,2.可以放的位置,3.释放对象(1自己,2对手),4.抵抗心法id,
	 add_buff={
		[259]={10,1,1},
		[358]={10,1,1},
		[363]={5,1,1},
		[355]={5,1,2},
		[359]={10,2,1},
		[361]={10,2,1},
		[356]={5,2,2,96,},
		[357]={5,2,2,95,},
		[353]={10,3,2},
		[354]={10,3,2,97,},
		[362]={5,3,1},
		[360]={5,3,1},
	},

	--使用3个技能身上带的buff
	use_buff={197,198,199},
}

--人物属性更新
local function _card_upatt(playerid,zhang,tempbuff)	
	-- look('人物属性更新111',1)
	-- look(tempbuff,1)
	local carddata=get_carddata( playerid )
	if carddata==nil then return end
	local AttTable =GetRWData(1)
	local sl=carddata.sl or 0
	-- local lv=card_getsllv(sl) --神力值对应等级
	-- local att_conf=card_att_conf.att_sl[lv]
	-- if att_conf==nil then return end
	-- for k,v in pairs(att_conf) do
	-- 	if type(k)==type(0) and type(v)==type({}) then
	-- 		AttTable[v[1]]=v[2]
	-- 	end
	-- end
	local taopai={}
	local nowlv
	for k,v in pairs(carddata) do
		if type(k)==type(0) and type(v)==type({}) then
			for j,h in pairs(v) do--卷,j=1-6,h=等级
				if type(j)==type(0) and type(h)==type(0) then
					-- look('卷'..j,1)
					-- look('等级'..h,1)
					if h==100 then 
						for x,y in pairs(att_newconf[j]) do
							AttTable[x]=(AttTable[x] or 0)+y[1]+(k-1)*y[2]
						end
						taopai[k]=(taopai[k] or 0)+1
					elseif h>100 then --有强化
						for x,y in pairs(att_newconf[j]) do
							nowlv=(h-100)
							-- look(x,1)
							AttTable[x]=(AttTable[x] or 0)+y[1]+(k-1)*y[2] +rint(nowlv*y[3]+nowlv^y[4]/y[5])
							-- look(nowlv,1)
							-- look(y[1]+(k-1)*y[2],1)
							-- look(rint(nowlv*y[3]+nowlv^y[4]/y[5]),1)
						end
						taopai[k]=(taopai[k] or 0)+1
					end
				end
			end
			
		end
	end

	for k,v in pairs(taopai) do
		if v==6 then --6卡集齐
			AttTable[1]= (AttTable[1] or 0)+card_att_conf.extra_Award[k].hp
		end
	end
	-- look(AttTable,1)
	if zhang then --通关更新
		__G.PI_UpdateScriptAtt(playerid,ScriptAttType.card)--  更新脚本增加的玩家属性
		return
	end

	if  carddata.us and carddata.us[1] then --装备了第1技能
		tempbuff[16][1]=92 --id
		tempbuff[16][2]=1 --lv
	end
	return true
end

--抽取卡牌
function card_bag_give(index, itype, itemid)
	local sid = CI_GetPlayerData(17)
	if sid == nil then return end
	local pakagenum = isFullNum()
	if pakagenum < 1 then
		TipCenter(GetStringMsg(14,1))
		return 0
	end
	if itype == 1 then
		if index == 1099 then --3卷卡
			local randid = mathrandom(1162,1167)
			if 0 == CheckGoods(index, 1, 0, sid, '扣卡牌套') then return end
			GiveGoods(randid,1,1,"给卡牌") 
			RPC('card_give_rand', index, randid)
		elseif index == 1100 then --4卷卡
			local randid = mathrandom(1168,1173)
			if 0 == CheckGoods(index, 1, 0, sid, '扣卡牌套') then return end
			GiveGoods(randid,1,1,"给卡牌")
			RPC('card_give_rand', index, randid)
		end
	else
		if itemid == nil then return end
		if index == 1099 then --3卷卡
			if 0 == CheckGoods(index, 1, 1, sid, '扣卡牌套') then return end
			if not CheckCost( sid, 3*10, 0, 1, "抽取卡牌") then return end
			CheckGoods(index, 1, 0, sid, '扣卡牌套')
			GiveGoods(itemid,1,1,"给卡牌")
			RPC('card_give_allocate', index, itemid)
		
		elseif index == 1100 then --4卷卡
			if 0 == CheckGoods(index, 1, 1, sid, '扣卡牌套') then return end
			if not CheckCost( sid, 4*10, 0, 1, "抽取卡牌") then return end
			CheckGoods(index, 1, 0, sid, '扣卡牌套')
			GiveGoods(itemid,1,1,"给卡牌")
			RPC('card_give_allocate', index, itemid)
			
		end
	end
end
	
--使用卡牌
local function _card_useitem(playerid,itemid,num)

	local carddata=get_carddata( playerid )
	if carddata==nil then return 0 end
	local idconf=card_useid_conf[itemid]
	if idconf==nil then return 0 end
	if CheckGoods( itemid ,1, 1, playerid,'使用卡牌') == 0 then
		return 0
	end
	local zhang,jie,addnum=idconf[1],idconf[2],idconf[3]--章,节,加点
	if zhang==nil or jie==nil or addnum==nil then return 0 end
	if carddata[zhang]==nil then 
		carddata[zhang]={}
	end
	local nownum=carddata[zhang][jie] or 0
	if nownum >=100 then return 0 end
	carddata[zhang][jie]=nownum+addnum
	if carddata[zhang][jie]>=100 then
		-- carddata[zhang][jie]=100
		-- local oldlv= card_getsllv( carddata.sl or 0)
		-- carddata.sl=(carddata.sl or 0)+idconf[4]--加神力值

		local playername=CI_GetPlayerData(3)
		BroadcastRPC('card_all',playername,zhang,jie)
		-- local nowlv=card_getsllv( carddata.sl )
		-- if nowlv>oldlv then
		  _card_upatt(playerid,1)
		--   card_setskill( nowlv+1 )
		-- end

	end
	

	--CheckGoods( itemid ,1, 0, playerid,'卡牌系统')
	RPC( 'card_one',zhang,jie,carddata[zhang][jie],carddata.sl)	
end
--激活卡牌
local function _card_activate(playerid,itemid,num)
	-- look(111)
	local carddata=get_carddata( playerid )
	if carddata==nil then return 0 end
	-- look(444)
	local idconf=card_useid_conf[itemid]
	if idconf==nil then return 0 end
	-- look(3333)
	local zhang,jie,addnum=idconf[1],idconf[2],idconf[3]--章,节,加点
	if zhang==nil or jie==nil or addnum==nil then return 0 end
	if carddata[zhang]==nil then 
		carddata[zhang]={}
	end
	local nownum=carddata[zhang][jie] or 0
	if nownum >=100 then 
		return 0 
	end
	-- look(0111)
	local max_neednum=_ceil(100-nownum)/addnum
	if num>max_neednum then
		num=max_neednum
	end
	if CheckGoods( itemid ,num, 1, playerid,'激活卡牌') == 0 then
		return 0
	end
-- look(011)
	carddata[zhang][jie]=nownum+addnum*num
	if carddata[zhang][jie]>=100 then
		-- carddata[zhang][jie]=100
		-- local oldlv= card_getsllv( carddata.sl or 0)
		-- carddata.sl=(carddata.sl or 0)+idconf[4]--加神力值

		local playername=CI_GetPlayerData(3)
		BroadcastRPC('card_all',playername,zhang,jie)
		-- local nowlv=card_getsllv( carddata.sl )
		-- if nowlv>oldlv then
		  _card_upatt(playerid,1)
		--   card_setskill( nowlv+1 )
		-- end

	end
	

	CheckGoods( itemid ,num, 0, playerid,'卡牌系统')
	RPC( 'card_one',zhang,jie,carddata[zhang][jie],carddata.sl)	
end

--领取套装奖励
function _card_getattaward( playerid,k )
	-- look('领取套装奖励')
	local carddata=get_carddata( playerid )
	local get=carddata.get or 0
	if k-get~=1 then look('111') return end
	local v=carddata[k]

	if type(k)~=type(0) or type(v)~=type({}) then	look('222') return end

	local xinxin_mark=6
	if #v~=xinxin_mark then 
		-- look('333')
		return
	end
	for i,j in pairs(v) do --[1]={}的内容
		if type(i)==type(0) and type(j)==type(0) then
			if j<100 then
				xinxin_mark=nil
			end
		end
	end
	if xinxin_mark==nil then look('444') return end

	carddata.get=k
	local yb=card_att_conf.extra_Award[k].yb
	-- local sl=card_att_conf.extra_Award[k].sl
	if yb then
		AddPlayerPoints( playerid , 3 , yb , nil,'卡牌')
	end
	-- local oldlv=card_getsllv( carddata.sl or 0 )
	-- carddata.sl=(carddata.sl or 0)+sl--加神力值
	-- local nowlv=card_getsllv( carddata.sl )
	-- if nowlv>oldlv then
	--   _card_upatt(playerid,1)
	--   card_setskill( nowlv+1 )
	-- end
	RPC( 'card_get',k,carddata.sl)--领取完成	
end
--封神卡牌强化 buy=0不用钱,1用钱,auto=1直接升到下一星
function card_enhange( playerid,zhang,jie ,buy,lastnum,auto)
	-- look('封神卡牌强化',1)
	-- look(zhang,1)
	-- look(jie,1)
	-- look(buy,1)
	-- look(lastnum,1)
	-- look(auto,1)
	local carddata=get_carddata( playerid )
	if carddata==nil then return end
	local nownum=carddata[zhang][jie] or 0
	if nownum <100 or  nownum >= 200 then 
		return 
	end
	local nowlv=nownum-100

	local neednum=rint(nowlv/10)*2+2
	local needyb=0
	local addlv=1
	if auto==1 then 
		addlv=10-nowlv%10
		neednum=neednum*addlv
	end
	-- look(2222,1)
	if buy==0 then--不用钱
		if 0 == CheckGoods(needid,neednum,1,playerid,'封神卡牌强化') then
			return
		end
	else --用钱
		if lastnum>0 and lastnum<neednum then 
			if CheckGoods( needid, lastnum, 1, playerid,'封神卡牌强化') == 0 then
				return
			end
			needyb=(neednum-lastnum)*10
			if not CheckCost(playerid, needyb,1,1) then
				return
			end
		elseif lastnum==0 then 
			needyb=neednum*10
			if not CheckCost(playerid, needyb,1,1) then
				return
			end
		elseif lastnum>=neednum then 
			if CheckGoods( needid, neednum, 1, playerid,'封神卡牌强化') == 0 then
				return
			end
		else
			return
		end
	end
	-- look(3333,1)
	if buy==0 then--不用钱
		if 0 == CheckGoods(needid,neednum,0,playerid,'封神卡牌强化') then
			return
		end
	else --用钱
		if lastnum==0 then 
			if not CheckCost(playerid, needyb,0,1,'封神卡牌强化') then
				return
			end
		else
			if lastnum<=neednum then 
				if CheckGoods( needid, lastnum, 0, playerid,'封神卡牌强化') == 0 then
					return
				end
			else
				if CheckGoods( needid, neednum, 0, playerid,'封神卡牌强化') == 0 then
					return
				end
			end
			if needyb>0 then 
				if not CheckCost(playerid, needyb,0,1,'封神卡牌强化') then
					return
				end
			end
		end
	end
	-- look(4444,1)
	carddata[zhang][jie]=nownum+addlv
	if carddata[zhang][jie]==200 then 
		carddata.nsl=(carddata.nsl or 0)+1
		carddata.asl=(carddata.asl or 0)+1
	end
	_card_upatt(playerid,1)
	SendLuaMsg(0,{ids=qh_res,zhang=zhang,jie=jie,lv=carddata[zhang][jie],nsl=carddata.nsl},9)
end


--前台使用技能 index=1用1技能,2用2技能,3用3技能
function card_useskill( playerid,index,x,y,gid )
	-- look(111,1)
	-- look(index,1)
	-- look(x,1)
	-- look(y,1)
	-- look(gid,1)
	-- look(111,1)
	local carddata=get_carddata( playerid )
	if carddata==nil or carddata.us==nil or carddata.have==nil then return end
	local buffid=carddata.us[index]
	if buffid==nil then return end
	local nextid=carddata.us[index+1] or 0 -- 触发下一个技能id
	local lv=carddata.have[buffid]
	-- local buffid=363
	-- local nextid=buffid+1 -- 触发下一个技能id
	-- local lv=1

	
	local needbuff=skill_buff_conf.use_buff[index]

	-- if buffid==nil or lv==nil then return end

	if not CI_HasBuff(needbuff) then 	--无buff
		return
	end
	-- look(buffid,1)
	
	if buffid == 361 then --招怪
		__G.PI_SCallMonster(playerid,2,x,y,lv)
	elseif buffid == 362 then
		__G.PI_SCallMonster(playerid,3,x,y,lv)
	elseif buffid == 363 then
		__G.PI_SCallMonster(playerid,4,nil,nil,lv)
	else --不招怪的技能
		if skill_buff_conf.add_buff[buffid][3]==1 then--对自己施放
			CI_AddBuff(buffid,0,lv,false)
		else --对对手施放
			-- look(gid,1)
			local obj
			if gid==nil then return end
			local gidtype=SI_getgid_Object(gid)
			if gidtype==ScriptGidType.monster then 
				obj=4
			elseif gidtype==ScriptGidType.player then
				obj=1
			else
				return
			end
			local ox, oy, orid, omapgid = CI_GetCurPos(obj,gid)
			local x, y, rid, mapgid = CI_GetCurPos()
			if orid~=rid or omapgid~=mapgid then return end
			local dikangid=skill_buff_conf.add_buff[buffid][4]
			-- look(dikangid,1)
			-- look(obj,1)
			if ((ox-x)^2+(oy-y)^2)^0.5>8 then return end

			if dikangid and obj==1  then
				local dilanglv=0
				

					
				if 1==CI_SelectObject(1,gid) then --设置对手为当前对象
					 dilanglv=CI_GetSkillLevel(4,dikangid)
				end
				CI_SelectObject(2,playerid)--设置自己为当前对象(还原)

				-- look(dilanglv,1)
				-- TipCenter('抵抗等级='..tostring(dilanglv))

				if _random(1,100)<=dilanglv then --抵抗成功
					-- TipCenter('抵抗成功')
					--local dikangbuff=skill_buff_conf.add_buff[buffid][5]
					AreaRPC(0,nil,nil,"fs_dk",gid,buffid)
					-- return 
				else
					CI_AddBuff(buffid,0,lv,false,obj,gid)
				end
			
			else
				CI_AddBuff(buffid,0,lv,false,obj,gid)
			end
		end
	end

	CI_DelBuff(needbuff)
	-- look(44,1)
	-- look(index,1)
	if index<3 and nextid>0 then
		if carddata.gl==nil then 
			carddata.gl={}
		end
		local beishu=0
		if index==1 then 
			beishu=2
		else
			beishu=1
		end
		local gl=(carddata.gl[index] or 0)*beishu+20
		-- look(gl,1)
		local rannum=_random(1,100)
		if rannum<=gl then 			
			CI_AddBuff(needbuff+1,0,1,false)
		end
	end
end

--升级技能
function card_upbuff( playerid,buffid )
	-- look('升级技能',1)
	local carddata=get_carddata( playerid )
	if carddata==nil  or carddata.nsl==nil then return end
	if carddata.asl==nil then
		carddata.asl=carddata.nsl or 0
	end
	-- look(carddata,1)
	if carddata.have==nil then 
		carddata.have={}
	end
	local nowlv=carddata.have[buffid] or 0
	local nowsl=carddata.nsl or 0
	-- look(nowsl,1)
	if nowsl<1 then return end
	-- look(buffid,1)
	if nowlv>=skill_buff_conf.add_buff[buffid][1] then 
		return 
	end
	carddata.have[buffid]= nowlv+1
	carddata.nsl=nowsl-1
	SendLuaMsg(0,{ids=skill_buff,buffid=buffid,lv=nowlv+1,nsl=carddata.nsl},9)
end
--升级概率
function card_upgl( playerid,index  )
	local carddata=get_carddata( playerid )
	if carddata==nil  or carddata.nsl==nil then return end
	local nowsl=carddata.nsl or 0
	-- look(nowsl,1)
	if nowsl<1 then return end
	if carddata.gl==nil then 
		carddata.gl={}
	end
	local nowgl=carddata.gl[index] or 0
	carddata.gl[index]= nowgl+1
	carddata.nsl=nowsl-1
	-- look(111,1)
	SendLuaMsg(0,{ids=gl_buff,index=index,lv=carddata.gl[index],nsl=carddata.nsl},9)
end

--封神榜洗点
function card_gorget( playerid ,money)
	local carddata=get_carddata( playerid )
	if carddata==nil   then return end
	if (carddata.asl or 0)>5 then 
		if money==0 then
			if not CheckCost( playerid , needmoney , 0 , 1, "封神榜洗点") then
				return
			end
		elseif money==1 then
			local now=GetPlayerPoints(playerid,3)
			if now==nil then return end 
			if now>=needmoney*5 then
				AddPlayerPoints( playerid , 3 , -needmoney*5 ,nil,'封神榜洗点')
			else
				return
			end
		else
			return
		end
		
	end

	carddata.us={}--清使用
	carddata.gl={}--清使用
	carddata.have={}--清拥有
	carddata.nsl=carddata.asl
	CI_UpdateBuffExtra(0,92,0,0)
	SendLuaMsg(0,{ids=xd_buff, nsl=carddata.nsl},9)
end
--装备技能
function card_addskill( playerid,index,buffid )
	local carddata=get_carddata( playerid )
	if carddata==nil  or carddata.have==nil then return end
	if carddata.us==nil then 
		carddata.us={}
	end
	if buffid~=0 then
		if carddata.have[buffid]==nil then return end
		local canindex=skill_buff_conf.add_buff[buffid][2]
		if canindex~=index then return end
		if index==1 and carddata.us[index] ==nil then 
			-- look(111,1)
			local a=CI_UpdateBuffExtra(92,0,1,0)
			-- look(a,1)
		end
		carddata.us[index]=buffid
	else
		carddata.us[index]=nil
		if index==1 then 
			local a=CI_UpdateBuffExtra(0,92,0,0)
			 -- look(a,1)
		end
	end
	SendLuaMsg(0,{ids=zb_buff,index=index,buffid=buffid},9)
end



----------------------
card_useitem=_card_useitem
card_upatt=_card_upatt
card_getattaward=_card_getattaward
card_activate=_card_activate

if __debug == false then return end
--测试清理数据
function card_cl(playerid)
	local carddata=get_carddata( playerid )
	carddata.sl=nil
	carddata.get=nil
	for i=1 ,10 do
		carddata[i]=nil
	end
end

function card_addsl(playerid)
	local carddata=get_carddata( playerid )
	carddata.sl=1000
	carddata.nsl=1000
	carddata.asl=1000
	SendLuaMsg(0,{ids=gl_buff,nsl=carddata.nsl},9)	
end