--------------------------------------------------------------------------
--include:

local msgDispatcher = msgDispatcher

--------------------------------------------------------------------------
-- data:

--����ʼ��
msgDispatcher[17][1] = function (mplayerid,msg)
	Marry_Init(mplayerid,msg.fplayerid,msg.content)
end
--���ȷ��
msgDispatcher[17][2] = function (fplayerid,msg)	
	MarryConfirmResult(fplayerid,msg.mplayerid,msg.result)
end
--ԤԼ����
msgDispatcher[17][3] = function (mplayerid,msg)
	ReserveWedding(mplayerid,msg.TB_Index,msg.weddingTp)
end
--��ʼ����
msgDispatcher[17][4] = function (mplayerid)
	WeddingBegin(mplayerid)
end
-- ԤԼ�б�
msgDispatcher[17][5] = function (playerid)
	GetReserveList(playerid)
end
--���󻥶�
msgDispatcher[17][6] = function (playerid,msg)
	CoupleInteract(playerid,msg.iType) 
end
--ȷ��ʹ��ӵ��������
msgDispatcher[17][7] = function (playerid,msg)
	CoupleComfirm(playerid,msg.mplayerid,msg.iType,msg.result)
end

-- ��������������
msgDispatcher[17][8] = function (playerid,msg)
	SendMarryData(playerid,msg.othername)
end

--˫��Э�����/�����ݹ�ϵ
msgDispatcher[17][9] = function(mplayerid,msg)
	TreatyDivorce(mplayerid)
end
--���������
msgDispatcher[17][10] = function (fplayerid,msg)
	DivorceConfirm(fplayerid,msg.mplayerid,msg.result) 
end
--����ǿ�����/�����ݹ�ϵ 
msgDispatcher[17][11] = function (mplayerid,msg)
	ForceDivorce(mplayerid)      
end

--����ĥ
msgDispatcher[17][12] = function (playerid,msg)
	marry_damo( playerid,msg.buy,msg.lastnum)   
end

msgDispatcher[17][13] = function (mplayerid,msg)
	ForceDivorceConfirm(mplayerid,msg.iType)      
end

msgDispatcher[17][14] = function (mplayerid,msg)
	Marry_UseSkill(mplayerid,msg.index)      
end
-- ����δ���Ƽ��б�
msgDispatcher[17][15] = function (mplayerid,msg)
	SendSingleData(mplayerid)      
end

-- ����ĥ����
msgDispatcher[17][16] = function (playerid,msg)
	marry_timereset( playerid)    
end

-- ��ȡ���ƺ�
msgDispatcher[17][17] = function (playerid,msg)
	Marry_GetTitle( playerid, msg.idx)    
end
-- -- �鿴
-- msgDispatcher[17][18] = function (playerid,msg)
-- 	Marry_GetTitle( msg.sid,msg.name,msg.type,msg.s)    
-- end

