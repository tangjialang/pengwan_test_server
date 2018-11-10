--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher

--------------------------------------------------------------------------
-- data:

--结婚初始化
msgDispatcher[17][1] = function (mplayerid,msg)
	Marry_Init(mplayerid,msg.fplayerid,msg.content)
end
--求婚确认
msgDispatcher[17][2] = function (fplayerid,msg)	
	MarryConfirmResult(fplayerid,msg.mplayerid,msg.result)
end
--预约婚宴
msgDispatcher[17][3] = function (mplayerid,msg)
	ReserveWedding(mplayerid,msg.TB_Index,msg.weddingTp)
end
--开始婚宴
msgDispatcher[17][4] = function (mplayerid)
	WeddingBegin(mplayerid)
end
-- 预约列表
msgDispatcher[17][5] = function (playerid)
	GetReserveList(playerid)
end
--请求互动
msgDispatcher[17][6] = function (playerid,msg)
	CoupleInteract(playerid,msg.iType) 
end
--确认使用拥抱或跳舞
msgDispatcher[17][7] = function (playerid,msg)
	CoupleComfirm(playerid,msg.mplayerid,msg.iType,msg.result)
end

-- 请求婚姻面板数据
msgDispatcher[17][8] = function (playerid,msg)
	SendMarryData(playerid,msg.othername)
end

--双方协议离婚/解除结拜关系
msgDispatcher[17][9] = function(mplayerid,msg)
	TreatyDivorce(mplayerid)
end
--请求离婚结果
msgDispatcher[17][10] = function (fplayerid,msg)
	DivorceConfirm(fplayerid,msg.mplayerid,msg.result) 
end
--单人强制离婚/解除结拜关系 
msgDispatcher[17][11] = function (mplayerid,msg)
	ForceDivorce(mplayerid)      
end

--婚戒打磨
msgDispatcher[17][12] = function (playerid,msg)
	marry_damo( playerid,msg.buy,msg.lastnum)   
end

msgDispatcher[17][13] = function (mplayerid,msg)
	ForceDivorceConfirm(mplayerid,msg.iType)      
end

msgDispatcher[17][14] = function (mplayerid,msg)
	Marry_UseSkill(mplayerid,msg.index)      
end
-- 请求未婚推荐列表
msgDispatcher[17][15] = function (mplayerid,msg)
	SendSingleData(mplayerid)      
end

-- 婚戒打磨重置
msgDispatcher[17][16] = function (playerid,msg)
	marry_timereset( playerid)    
end

-- 领取结婚称号
msgDispatcher[17][17] = function (playerid,msg)
	Marry_GetTitle( playerid, msg.idx)    
end
-- -- 查看
-- msgDispatcher[17][18] = function (playerid,msg)
-- 	Marry_GetTitle( msg.sid,msg.name,msg.type,msg.s)    
-- end

