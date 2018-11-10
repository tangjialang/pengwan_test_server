--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher
local DJstart = DJstart
local DJbasegame = DJbasegame
local Buy_djenergy = Buy_djenergy
local DJlittlegame = DJlittlegame
local Garniture_start = Garniture_start
local Garniture_set = Garniture_set
local Garniture_cancel = Garniture_cancel
local EnterZY = EnterZY
local StartZYparty = StartZYparty
local InviteallZYparty = InviteallZYparty
local EnterZYparty = EnterZYparty
local look = look
local OutZYparty=OutZYparty
local ToastZYparty=ToastZYparty
local Send_patryinfo=Send_patryinfo
local RequestZYpeople=RequestZYpeople
local Lock_EnterZY=Lock_EnterZY
local Expel_ZY=Expel_ZY
local Get_partybuff=Get_partybuff
local GD_EnterGarden=GD_EnterGarden
local GD_OpenField=GD_OpenField
local GD_SowSeed=GD_SowSeed
local GD_Operations=GD_Operations
local GD_Escape=GD_Escape
local GD_FastOpt=GD_FastOpt
local GD_GetMoneyTree=GD_GetMoneyTree
local GD_AddLuck=GD_AddLuck
local GD_GetFriendList=GD_GetFriendList
local MR_SendRankList=MR_SendRankList
local MR_Fight=MR_Fight
local MR_AwardProc=MR_AwardProc
local MR_Exit=MR_Exit
local MR_ClearRankCD=MR_ClearRankCD
local MR_BuyTimes=MR_BuyTimes
local MRK_GiveAward=MRK_GiveAward
local MRB_PanelInfo=MRB_PanelInfo
local MRB_Robbery=MRB_Robbery
local MRB_Detail=MRB_Detail
local MRB_Attention=MRB_Attention
local MRB_CheckRobTimes=MRB_CheckRobTimes
local MRB_ShowFight=MRB_ShowFight
local MRB_Exit=MRB_Exit
local MTC_GetTecLv=MTC_GetTecLv
local MTC_UpLevel=MTC_UpLevel
local SendPetData=SendPetData
local SetPetStyle=SetPetStyle
local BuyPetStyle=BuyPetStyle

--------------------------------------------------------------------------
-- data:
--双修
msgDispatcher[21][0] = function (playerid,msg)
	-- rfalse("妲己游戏开始")
	-- local itype=msg.itype
	-- if itype==1 then --初始化
	-- 	DJstart(playerid)
	-- elseif itype==2 then--玩基础游戏【游戏对应：1出游，2献舞，3捶背，4按摩,5共浴,6双修】
	-- 	DJbasegame(playerid,msg.num,msg.index)
	-- elseif itype==3 then--购买cd
	-- 	dj_passcd(playerid)
	-- elseif itype==4 then--点击小游戏
	-- 	DJlittlegame(playerid,msg.game,msg.num,msg.djnum)
	-- end
	np_shuangxiu(playerid,msg.index ,msg.itype )
end
--秒cd
msgDispatcher[21][1] = function (playerid,msg)
	dj_passcd( playerid, msg.itype)
end
--送礼
msgDispatcher[21][2] = function (playerid,msg)
	DJitemaddliking( playerid ,msg.index,msg.num)
end
--开启女仆
msgDispatcher[21][3] = function (playerid,msg)
	np_opennvpu( playerid,msg.index )
end

------------------------------------------------------------------ 装饰消息
msgDispatcher[25][0]=function (playerid)
	Garniture_start(playerid)
end	
msgDispatcher[25][1]=function (playerid,msg)
	Garniture_set(playerid,msg.tag,msg.index)
end	
--取消装饰
msgDispatcher[25][2]=function (playerid,msg)
	Garniture_cancel(playerid,msg.tag,msg.index)
end	
------------------------------------------------------------------ 宴会消息
--进入山庄
msgDispatcher[23][0]=function (playerid,msg)
	look('进入山庄')
	-- look(msg)
	-- local nplayerid= GetPlayer(msg.nplayerid, 0)
	-- if type(nplayerid)~=type(0) or nplayerid<0 then
		-- TipCenter(GetStringMsg(664))--不在线
		-- return
	-- end
	-- look(playerid)
	-- look(nplayerid)
	EnterZY(playerid,msg.nplayerid,1)
end	
--开宴席
msgDispatcher[23][1]=function (playerid,msg)
	StartZYparty(playerid,msg.num)
end	
--邀请好友
msgDispatcher[23][2]=function (playerid,msg)
look('邀请好友')
look(msg)
	-- local msg1={}
	-- for k,v in pairs(msg.msg1) do
		-- if type(v)==type("") then
			-- local id=GetPlayer(v, 0)
			-- if type(id)==type(0) and  id>0 then
				-- msg1[k]=id
			-- end
		-- end
	-- end
	InviteallZYparty(playerid,msg.msg1)
end	
--进入宴会
msgDispatcher[23][3]=function (playerid,msg)
	-- look('进入宴会')
	-- local nplayerid= GetPlayer(msg.nplayerid, 0)
	-- if type(nplayerid)~=type(0) or nplayerid<0 then
		-- return
	-- end
	EnterZYparty(playerid,msg.nplayerid)
end	
--退出宴会
msgDispatcher[23][4]=function (playerid,msg)
	OutZYparty(playerid,nil,0)
end	

--敬酒
msgDispatcher[23][5]=function (playerid,msg)
look(msg)
	ToastZYparty(playerid,msg.nplayerid)
end	
--请求宴会信息
msgDispatcher[23][6]=function (playerid)
look('请求宴会信息')
	Send_patryinfo(playerid)
end	
--请求庄园人物信息
msgDispatcher[23][7]=function (playerid)
	RequestZYpeople(playerid)
end	
--庄园锁定框
msgDispatcher[23][8]=function (playerid,msg)
	Lock_EnterZY(playerid,msg.itype)
end	
--驱逐庄园玩家
msgDispatcher[23][9]=function (playerid,msg)
-- look('驱逐庄园玩家')
	-- local nplayerid= GetPlayer(msg.nplayerid, 0)
	-- if type(nplayerid)~=type(0) or nplayerid<0 then
		-- return
	-- end
	Expel_ZY(playerid,msg.nplayerid)
end	

--点击参加宴会
msgDispatcher[23][10]=function (playerid,msg)
	Get_partybuff()
end	
--请求宴会结果
msgDispatcher[23][11]=function (playerid,msg)
	party_getendinfo(playerid)
end	
------------------------------------------------------------------ 花园消息 ------------------------------------------------

-- 获取花园数据
msgDispatcher[22][1] = function (playerid,msg)
	rfalse("GD_EnterGarden")
	GD_EnterGarden(playerid, msg.othersid)
end

-- 开启田地
msgDispatcher[22][2] = function (playerid,msg)
	GD_OpenField(playerid, msg.index)
end

-- 种菜
msgDispatcher[22][3] = function (playerid,msg)	
	GD_SowSeed(playerid, msg.index, msg.seedID)
end

-- 花园操作(1 除草 2 除虫 3 浇水 4 偷取/收获)
msgDispatcher[22][4] = function (playerid,msg)
	GD_Operations(playerid, msg.othersid, msg.index, msg.opt)
end

-- 被咬逃跑
msgDispatcher[22][5] = function (playerid,msg)
	GD_Escape(playerid, msg.othersid, msg.index)
end

-- 一键操作
msgDispatcher[22][6] = function (playerid,msg)
	GD_FastOpt(playerid, msg.othersid, msg.iType, msg.param)
end

-- 获取摇钱树信息
msgDispatcher[22][7] = function (playerid,msg)
	GD_GetMoneyTree(playerid,msg.iType)
end

-- 使用幸运药
msgDispatcher[22][8] = function (playerid,msg)
	GD_AddLuck(playerid, msg.index, msg.luckid)
end

-- 获取好友列表信息
msgDispatcher[22][9] = function (playerid,msg)
	GD_GetFriendList(playerid, msg.page, msg.pidList)
	-- test(playerid, msg.pidList)
end

-- 升级土地等级
msgDispatcher[22][10] = function (playerid,msg)
	GD_UpLandLv(playerid, msg.iType)
	-- test(playerid, msg.pidList)
end


------------------------------------------------------ 庄园排位赛消息 ------------------------------------------------

-- 获取排位列表信息
msgDispatcher[26][1] = function (playerid,msg)
	MR_SendRankList(playerid)
end

-- 夺取排位
msgDispatcher[26][2] = function (playerid,msg)
	MR_Fight(playerid, msg.idx, msg.fid)
end

-- 排位赛奖励处理
msgDispatcher[26][3] = function (playerid,msg)
	MR_AwardProc(playerid)
end

-- 排位赛退出消息处理
msgDispatcher[26][4] = function (playerid,msg)
	MR_Exit(playerid)
end

-- 排位赛退出消息处理
msgDispatcher[26][5] = function (playerid,msg)
	MR_ClearRankCD(playerid,msg.iType)
end

-- 排位赛购买次数消息处理
msgDispatcher[26][6] = function (playerid,msg)
	MR_BuyTimes(playerid,msg.num)
end

-- 排位赛领奖消息处理
msgDispatcher[26][7] = function (playerid,msg)
	MRK_GiveAward(playerid)
end

-- 排位赛快速查看
msgDispatcher[26][8] = function (playerid,msg)
	MR_FastView(playerid)
end

-- 排位赛快速查看
msgDispatcher[26][9] = function (playerid,msg)
	set_fight_obj(playerid, msg.setv)
end

-- 排位赛鼓舞
msgDispatcher[26][10] = function (playerid,msg)
	MR_Inspire(playerid, msg.iType)
end



---------------------------------------------庄园掠夺-----------------------------------------------

-- 获取掠夺列表信息
msgDispatcher[28][1] = function (playerid,msg)
	MRB_PanelInfo(playerid,msg.iType,msg.param,msg.nPage)
end

-- 庄园掠夺
msgDispatcher[28][2] = function (playerid,msg)
	MRB_Robbery(playerid, msg.othersid)
end

-- 获取掠夺详细信息
msgDispatcher[28][3] = function (playerid,msg)
	MRB_Detail(playerid, msg.othersid)
end

-- 关注
msgDispatcher[28][4] = function (playerid,msg)
	MRB_Attention(playerid, msg.othersid)
end

-- 购买次数
-- msgDispatcher[28][5] = function (playerid,msg)
	-- MRB_CheckRobTimes(playerid, 3)
-- end

-- 查看战斗力
msgDispatcher[28][6] = function (playerid,msg)
	MRB_ShowFight(playerid)
end

-- 退出
msgDispatcher[28][7] = function (playerid,msg)
	MRB_Exit(playerid)
end

-------------------------------------------------庄园科技---------------------------------------

-- 获取庄园科技数据
msgDispatcher[30][1] = function (playerid,msg)
	MTC_GetTecLv(playerid)
end

-- 庄园科技升级
msgDispatcher[30][2] = function (playerid,msg)
	MTC_UpLevel(playerid,msg.index)
end

-------------------------------------------------宠物处理---------------------------------------

-- 获取宠物数据
msgDispatcher[31][1] = function (playerid,msg)
	SendPetData(playerid)
end

-- 购买宠物
msgDispatcher[31][2] = function (playerid,msg)
	BuyPetStyle(playerid,msg.idx)
end

-- 幻化宠物
msgDispatcher[31][3] = function (playerid,msg)
	SetPetStyle(playerid,msg.idx)
end


