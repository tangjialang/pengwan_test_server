
// ����ջ�ռ��Ƿ�����
#define CHKSTK( n )	   lua_gettop(L)<n

#define LS_CHKSTK( n ) { if( CHKSTK(n) ) return 0; }

// ������ڼ�鲢���õ�ǰtop
#define LS_CHKTOP( n ) int __top = lua_gettop(L);  if(__top<n) return 0;

// ����������鷵��ֵ�������ջ����
#define	LS_CHKRET( n ) { if( __top + n != lua_gettop(L) ) { TraceInfo("LuaStackError.txt", "%s [check_return][%s-%d]top:%d ,return:%d, now:%d.stack:",\
	_GetStringTime(),__FILE__ , __LINE__ , __top , n ,lua_gettop(L) );stackDump(L); }; return n; }

// ����ͨ�÷��ؽ�����������ֽ�� ��
#define LS_RET( code ) { lua_pushnumber(L ,code);LS_CHKRET(1); }

//check
int CScriptManager::L_rfalse(lua_State *L)
{
	LS_CHKTOP(1);

	if( !lua_isnumber( L , 1 ) )  LS_CHKRET(0);
	int mdx = (int)lua_tonumber( L , 1 );
	if( mdx != 2 && mdx != 6 && mdx != 7 )
		LS_CHKRET(0);
    LPCSTR msg = static_cast<const char *>(lua_tostring(L, 2));
    if ( msg == NULL )
        msg = "(null)";

    rfalse(mdx, 1, msg);
    LS_CHKRET(0);
}
// check
int CScriptManager::L_Stand( lua_State* L )
{
	LS_CHKTOP(0);

	if(g_Script.m_pPlayer)
		g_Script.m_pPlayer->Stand(true,true , true );
	LS_CHKRET(0);
}
/*
	* ��������:ѧϰ���ܣ���ǰ�����ҿ�λ��
	* �������:
		��������:2
		args[1]:nSkillType 	�������� 1 �������� 4 ��������
		args[2]:nSkillId	����Id
	* ���ز���:
		����ֵ����:1
		rets[1]:ִ�н����int��	nil ǰ�������ж�ʧ�� 1 �ɹ� 0 δ�ҵ���λ -1 δ�ҵ��������� -2 ������������ -3 �Ѿ�ѧ�� -4 ���ü���ʧ�� -5 ���ʹ���
*/
int CScriptManager::L_CI_LearnSkill(lua_State* L)
{
	LS_CHKTOP(2);

	if(2!=lua_gettop(L) || !g_Script.m_pPlayer )
		LS_CHKRET(0);

	int nSkillType	= (int)lua_tointeger(L, 1);
	int nSkillId	= (int)lua_tointeger(L, 2);
	if( nSkillId < 1 ) LS_CHKRET(0);

	int ret = -5;
	switch( nSkillType)
	{
	case 1:
		ret = g_Script.m_pPlayer->LearnASkill( nSkillId-1 );
		break;
	case 4:
		ret = g_Script.m_pPlayer->LearnPSkill( nSkillId-1 );
		break;
	}
	lua_pushnumber( L , ret );
	LS_CHKRET(1);
}
/*
	* ��������:���ü��ܵȼ�
	* �������:
		��������:3 or 4
		args[1]:nSkillType 	�������� 1 �������� 4 �������� 2 �츳���� -1 ���ü����� -2 �����츳��
		args[2]:nSkillId	����Id
		args[3]:nSkillLevel	���õȼ�
		args[4]:idx			ָ�����ܴ��λ�ã��Ǳ�Ҫ�����Ҫ���˲��������봫�˲���ʱ����Ӻ���ǰ�ţ����⸲����ѧ���ܣ�
	* ���ز���:
		����ֵ����:1
		rets[1]:ִ�н����int��	nil ǰ�������ж�ʧ�� >0 ���º�ȼ� 0 ����ʧ�� -1 δ�ҵ����� -2 ���ʹ���
*/
int CScriptManager::L_CI_SetSkillLevel(lua_State* L)
{
	LS_CHKTOP(3);

	if( lua_gettop(L) < 3 || !g_Script.m_pPlayer )
		LS_CHKRET(0);

	int nSkillType	= (int)lua_tointeger(L, 1);
	int nSkillId	= (int)lua_tointeger(L, 2);
	int nSkillLevel = (int)lua_tointeger(L, 3);
	if( nSkillLevel < 0 || nSkillId < 1 ) LS_CHKRET(0);

	int ret = -2;
	switch( nSkillType)
	{
	case 1:
		if( lua_isnumber(L,4) ){
			// ֱ����������λ�õļ���
			// ���ڿ�ֱ����������λ��
			BYTE idx = (BYTE)lua_tonumber(L,4);
			// Ŀǰ�����ð��������Ѽ�/��˼�
			if( idx >= 0 && idx < MAX_SKILLCOUNT ){
				bool bChange = g_Script.m_pPlayer->m_Property.m_pSkills[idx].wID == nSkillId-1;
				g_Script.m_pPlayer->m_Property.m_pSkills[idx].wID		= nSkillId-1;
				g_Script.m_pPlayer->m_Property.m_pSkills[idx].wLevel	= nSkillLevel;
				g_Script.m_pPlayer->UTC_ActiveSkill( idx , bChange );
				ret = 1;
			}
		}else
			ret = g_Script.m_pPlayer->SetASkillLevel( nSkillId-1, nSkillLevel );
		break;
	case 2:
		ret = g_Script.m_pPlayer->LearnGiftSkill( nSkillId-1 , nSkillLevel );
		break;
	case 4:
		{
			BYTE idx = g_Script.m_pPlayer->GetPSkillIndex( nSkillId-1 );
			if( idx < TELERGY_NUM )
				ret = g_Script.m_pPlayer->SetPSkillLevel( idx , nSkillLevel );
			else
				ret = -1;
		}
		break;
	case -1:
		g_Script.m_pPlayer->ResetSkillTree();
		ret = 1;
		break;
	case -2:
		g_Script.m_pPlayer->ResetGiftTree();
		ret = 1;
		break;
	}
	lua_pushnumber( L , ret );
	LS_CHKRET(1);
}
/*
	* ��������:��ȡ���ܵȼ�
	* �������:
		��������:2
		args[1]:nSkillType 	�������� 1 �������� 4 �������� 2 �츳����
		args[2]:nSkillId	����Id
	* ���ز���:
		����ֵ����:1
		rets[1]:ִ�н����int��	nil ���ʹ��� >0 ���ܵȼ� 0 δ�ҵ���δѧ��ü���
*/
int CScriptManager::L_CI_GetSkillLevel(lua_State* L)
{
	LS_CHKTOP(2);

	if(2!=lua_gettop(L) || !g_Script.m_pPlayer )
		LS_CHKRET(0);

	int nSkillType	= (int)lua_tointeger(L, 1);
	int nSkillId	= (int)lua_tointeger(L, 2);
	if( nSkillId < 1 ) LS_CHKRET(0);

	switch( nSkillType)
	{
	case 1:
		lua_pushnumber(L, g_Script.m_pPlayer->GetASkillLevel( nSkillId-1 ));
		break;
	case 2:
		if( nSkillId <= MAX_GIFTCOUNT )
			lua_pushnumber(L, g_Script.m_pPlayer->m_Property.m_byGifts[nSkillId-1] );
		else
			LS_CHKRET(0);
		break;
	case 4:
		lua_pushnumber(L, g_Script.m_pPlayer->GetPSkillLevel( nSkillId-1 ));
		break;
	default:
		LS_CHKRET(0);
	}
	LS_CHKRET(1);
}
/*
	* ��������:��ȡ���ܵȼ�
	* �������:
		��������:2
		args[1]:nSkillType 	�������� 1 �������� 4 �������� 2 �츳����
		args[2]:nSkillId	����Id
	* ���ز���:
		����ֵ����:1
		rets[1]:ִ�н��	nil ���ʹ��� >0 ���ܵȼ� 0 δ�ҵ���δѧ��ü���
*/
// ���������
// args[1]	lua_State* L	��ջ
// args[2]	CPlayer* player	Ŀ�����
// args[3]	WORD index		���߱��
// args[4]	DWORD count		��������
// args[5]	BYTE bind		�Ƿ��
// args[6]	char* logStr	��־���ݣ�ȱʡ״̬ΪNULL��
// ����ֵ��
// retV[1]	bool ret		���ɽ��
// retV[2]	bool ret		���ɽ��
// retV[3]	bool ret		���ɽ��
static int s_giveGoods( lua_State* L, CPlayer* player, WORD index, DWORD count, BYTE bind,char* logStr = 0)
{
	LS_CHKTOP(0);

	if ( !player )
		LS_CHKRET(0);

	std::vector<CPlayer::GenItemBatchParam> paramList;
	paramList.push_back( CPlayer::GenItemBatchParam(index, count, bind) );

	CPlayer::GenItemBatchParam::RET_CODE retCode = CPlayer::GenItemBatchParam::RC_OK;
	int nCount = 0;
	if(logStr == 0)
		logStr = (char *)GetNpcScriptInfo("s_giveGoods");

	bool ret = player->GenerateNewItemBatch(paramList, retCode, nCount,logStr);

	lua_pushboolean(L, ret);
	lua_pushinteger(L, (lua_Integer)retCode);
	lua_pushinteger(L, (lua_Integer)nCount);

	LS_CHKRET(3);
}
/*
	* ��������:������
	* �������:
		��������:2 ~ 5
		args[1]:ItemId 		����Id
		args[2]:count		��������
		args[3]:bind		�Ƿ�󶨣���
		args[4]:Log			��־�������˲�����ʾ��д��־��
		args[5]:sid			���sid�������˲�����ʾ��ǰ��ң�
	* ���ز���:
		����ֵ����:3
		rets[1]:�������ɽ����bool��nil ���ʹ��� >0 ���ܵȼ� 0 δ�ҵ���δѧ��ü���
		rets[2]:�������ɽ����int��	nil ���ʹ��� >0 ���ܵȼ� 0 δ�ҵ���δѧ��ü���
		rets[3]:�������ɽ����int��	nil ���ʹ��� >0 ���ܵȼ� 0 δ�ҵ���δѧ��ü���
*/
int CScriptManager::L_giveGoods(lua_State *L)
{
	LS_CHKTOP(2);

	if( !lua_isnumber(L,1) || !lua_isnumber(L,2) )
		LS_CHKRET(0);

	LPCSTR logStr = 0;
	if(lua_isstring(L,4))
		logStr = static_cast<const char *>(lua_tostring(L, 4));

	CPlayer *pPlayer = NULL;
	DWORD sid = 0;
	if( lua_isnumber( L, 5) )
		sid = static_cast<DWORD>( lua_tonumber(L, 5));
	extern LPIObject GetPlayerBySID(DWORD);
	if( sid ) pPlayer = (CPlayer *)GetPlayerBySID(sid)->DynamicCast(IID_PLAYER);
	else pPlayer = g_Script.m_pPlayer;
	if( !pPlayer ) LS_CHKRET(0);

	return s_giveGoods(L, pPlayer, (WORD)lua_tointeger( L, 1), (DWORD)lua_tointeger( L, 2), (BYTE)lua_tointeger(L,3),(char*)logStr );
}
// check
// ������
/**
	�����������б�
**/
int CScriptManager::L_CheckGiveGoods( lua_State *L )
{
	LS_CHKTOP(1);

	if (!lua_istable(L, -1))
		LS_CHKRET(0);

	if (g_Script.m_pPlayer == NULL)
		LS_CHKRET(0);

	std::vector<CPlayer::GenItemBatchParam> paramList;
	size_t tableLen = lua_objlen(L, -1);

	for (int i = 1; i <= tableLen; ++i)
	{
		lua_rawgeti(L, -1, i);

		{
			if (!lua_istable(L, -1))
				LS_CHKRET(0);

			if (lua_objlen(L, -1) < 2)
				LS_CHKRET(0);

			lua_rawgeti(L, -1, 1);
			WORD index = (WORD)lua_tointeger(L, -1);
			lua_pop(L, 1);

			lua_rawgeti(L, -1, 2);
			DWORD count = (DWORD)lua_tonumber(L, -1);
			lua_pop(L, 1);

			lua_rawgeti(L, -1, 3);
			BYTE bind = (BYTE)lua_tointeger(L, -1);
			lua_pop(L, 1);

			paramList.push_back(CPlayer::GenItemBatchParam(index, count, bind));
		}

		lua_pop(L, 1);
	}

	CPlayer::GenItemBatchParam::RET_CODE retCode = CPlayer::GenItemBatchParam::RC_OK;
	int nCount = 0;
	bool ret = g_Script.m_pPlayer->CheckFillNewItemBatch(paramList, retCode, nCount);
	lua_pushboolean(L, ret);
	lua_pushinteger(L, (lua_Integer)retCode);
	lua_pushinteger(L, (lua_Integer)nCount);

	LS_CHKRET(3);
}
// check
// ���/�۳� ����
/**
	���������߱�� ������� check(1)/delete(0) ���sid ��־
**/
int CScriptManager::L_checkgoods( lua_State *L )
{
	LS_CHKTOP(2);

	if( !lua_isnumber(L,1) || !lua_isnumber(L,2) )
		LS_CHKRET(0);

    WORD	index		= static_cast<WORD>(lua_tonumber(L, 1));    // ���߱��
	DWORD	number		= static_cast<DWORD>(lua_tonumber(L, 2));	// �������

	BYTE	checkOnly	= 0;	// ��ʼ��Ϊ��ȡ
	if( lua_isnumber(L,3) )
		checkOnly	=  static_cast<BYTE>(lua_tonumber(L, 3));		// ֻ�Ǽ�⻹��ͬʱ��ȡ

	DWORD	dwSID		= static_cast<DWORD>( lua_tonumber(L,4) );

	LPCSTR discription = ( LPCSTR )lua_tostring(L, 5);
	if( !discription ) discription = GetNpcScriptInfo("L_checkgoods");

	std::vector<int> ignoreTable;
	if(lua_gettop(L)==7)
	{
		int x = static_cast<int>( lua_tonumber(L,6) );
		int y = static_cast<int>( lua_tonumber(L,7) );
		ignoreTable.push_back((y<<_CELLW)+x);
	}
	if( checkOnly == 6 && lua_gettop(L)!=8 ) LS_CHKRET(0);
	if(lua_gettop(L)==8)
	{
		int v1 = static_cast<int>( lua_tonumber(L,6) );
		int v2 = static_cast<int>( lua_tonumber(L,7) );
		int v3 = static_cast<int>( lua_tonumber(L,8) );
		ignoreTable.push_back(v1);
		ignoreTable.push_back(v2);
		ignoreTable.push_back(v3);
	}

	CPlayer *pPlayer = 0;
	if( dwSID==0 )
		pPlayer = g_Script.m_pPlayer;
	else
		pPlayer = (CPlayer *)GetPlayerBySID(dwSID)->DynamicCast(IID_PLAYER);
	if( pPlayer==0 ) {
		LS_CHKRET(0);
	}

    //// �����⴦��
    //if ( number == 0 )
    //    number = 1;

    lua_pushnumber( L, pPlayer->CheckGoods( index, number, checkOnly,&ignoreTable ,discription) );
    LS_CHKRET(1);
}
// check
// ��ȡ��������
/**
	���������߱�� (?�Ƿ��)
**/
int CScriptManager::L_getitemnum(lua_State *L)
{
	LS_CHKTOP(1);

	WORD index = static_cast<WORD>(lua_tonumber(L, 1));     // ���߱��
	int flag = 1;
	if( lua_type(L,2)==LUA_TNUMBER )
		flag = static_cast<int>(lua_tonumber(L, 2));
	lua_pushnumber( L, g_Script.m_pPlayer->GetItemNum(index, abs(flag)) );
    LS_CHKRET(1);
}
// check
// ���ö����¼�
/**
	������npcid �������� ����ʱ��(s) �Ƿ�㲥
**/
int CScriptManager::L_CI_SetReadyEvent(lua_State*L)
{
	LS_CHKTOP(5);

	if ( g_Script.m_pPlayer == NULL ) LS_CHKRET(0);

	int npcid		= (int)lua_tointeger(L, 1);
	int action		= (int)lua_tointeger(L, 2);
	int time		= (int)lua_tointeger(L, 3)*1000;
	int bBroadCast	= (int)lua_tointeger(L, 4);
	std::string sName = "";
	if ( lua_isstring(L,6) )
		sName = lua_tostring(L,6);

	if( npcid ){
		//��ʾ׼���¼���Ҫ�ж�NPC
		//��չ����֧��npc�͹���
		if( !g_Script.m_pPlayer->m_ParentRegion )
			LS_RET(-1);

		LPIObject obj = g_Script.m_pPlayer->m_ParentRegion->GetObjectByControlId( npcid );
		if( !obj )
			LS_RET(-2);
	}

	g_Script.m_pPlayer->StartCollect( npcid, time, action, lua_tostring(L, 5), sName ,bBroadCast );
	LS_RET(0);
}
// check
int CScriptManager::L_CI_CancelReadyEvent( lua_State* L )
{
	LS_CHKTOP(0);

	if( !g_Script.m_pPlayer )
		LS_CHKRET(0);

	g_Script.m_pPlayer->CancelProgress();

	LS_CHKRET(0);
}
// check
int CScriptManager::L_CI_GetPlayerData( lua_State *L )
{
	LS_CHKTOP(1);

	CPlayer *obj = NULL;
	GET_PLAYER( L , 1 );

	CPlayer *pPlayer = obj;
    if (pPlayer == NULL)
        LS_CHKRET(0);

	int wIndex = static_cast<int>( lua_tonumber( L , 1 ) );

	//comm att �������
	if( wIndex >= 100 && wIndex < 100 + SCommAtt::CAT_MAX ){
		lua_pushnumber(L, pPlayer->m_Atts.dwAtts[wIndex-100] );
		LS_CHKRET(1);
	}

    switch(wIndex)
    {
    // ����״̬
    case 0:
        lua_pushnumber(L, pPlayer->m_OnlineState);
        break;
   	// �ȼ�
    case 1:
        lua_pushnumber(L, pPlayer->m_Property.m_wLevel);
        break;
    // ְҵ
    case 2:
        lua_pushnumber(L, pPlayer->m_Property.m_bySchool);
        break;
    // name
    case 3:
        lua_pushstring(L, pPlayer->GetName());
        break;
    // ��ǰ����ֵ
	case 4:
		lua_pushnumber(L, (DWORD)pPlayer->m_Property.m_iExp);
		break;
	// name
	case 5:
		lua_pushstring(L, pPlayer->GetName());
		break;
	// ����ʱ��(min) //ÿ����һ�������������ÿ��Ű�������ʱ�����
	case 6:
		lua_pushnumber(L, pPlayer->m_Property.onlineTimeCount );
		break;
	// �˺�ͳ��
	case 7:
		{
			lua_pushnumber(L, pPlayer->m_dwDamCount[0] );
			lua_pushnumber(L, pPlayer->m_dwDamCount[1] );
			LS_CHKRET(2);
		}
		break;
	// ���PKģʽ
	case 8:
		lua_pushnumber(L, pPlayer->m_Property.m_byPKRule );
		break;
	// ǰ��ָ���������
	case 9:
		lua_pushnumber(L, pPlayer->mSkillAttackDataStruct.mDefenderWorldPosX);
		lua_pushnumber(L, pPlayer->mSkillAttackDataStruct.mDefenderWorldPosY);
		LS_CHKRET(2);
	// ��ҹ�����
	case 10:
		lua_pushnumber(L,pPlayer->m_Atts.dwAtts[SCommAtt::CAT_ATC]);
		break;
	// �Ա� 0 Ů 1 ��
	case 11:
		lua_pushnumber(L, pPlayer->m_Property.m_bySex);
		break;
	// ���޶��� �� 0 �� ����id
    case 12:
		lua_pushnumber(L, pPlayer->m_dwTeamID);
        break;
    // �Ƿ�ӳ� 0 �� 1 ��
	case 13:
		lua_pushnumber(L, (int)pPlayer->IsTeamLeader());
        break;
	case 14:
		luaEx_pushlightuserdata(L,&(pPlayer->m_Property.m_Equip) , sizeof(pPlayer->m_Property.m_Equip));
		break;
	// ����˺� �磺pengwan2001
    case 15:
        lua_pushstring(L, pPlayer->GetAccount());
		break;
	// ���gid 1110
    case 16:
        lua_pushnumber(L, pPlayer->GetGID());
		break;
	// ��Ҿ�̬id 1000001110
    case 17:
        lua_pushnumber(L, pPlayer->m_Property.m_dwStaticID);
		break;
	// ��������ȴ�ʱ��  ���� = pPlayer->m_DeadWaitTime / 5
	case 18:
		lua_pushnumber(L, pPlayer->m_DeadWaitTime);
        break;
    // �ͻ�������ip
	case 19:
        extern LPCSTR GetIPString( DNID dnid, WORD *port = NULL );
        {
            LPCSTR ip = GetIPString( pPlayer->m_ClientIndex );
            if ( ip == NULL )
                LS_CHKRET(0);
            lua_pushstring( L, ip );
        }
        break;
	case 20:
        if ( pPlayer->m_Property.m_szUPassword[0] == 0 )
            LS_CHKRET(0);

        pPlayer->m_Property.m_szUPassword[CONST_USERPASS-1] = 0;
        lua_pushstring( L, pPlayer->m_Property.m_szUPassword );
        break;
	case 21:
		lua_pushnumber( L , pPlayer->m_collectData.nTargetId );
    // ���ID
    case 23:
		lua_pushnumber( L, pPlayer->m_Property.dwFactionId );
		break;
	case 24:
		lua_pushnumber( L, pPlayer->m_wMP );
		break;
    // ��ǰѪ��
    case 25:
        lua_pushnumber( L, pPlayer->m_dwHP );
        break;
    // ���Ѫ��
    case 26:
        lua_pushnumber( L, pPlayer->GetMaxHP() );
        break;
    case 27:
		lua_pushnumber( L, pPlayer->m_Property.dwPointMax );
        break;
    case 28:
        lua_pushnumber( L, pPlayer->m_tempItem.size() );
        break;
    case 29:
		lua_pushnumber( L, pPlayer->m_Property.m_byJewelLevel );
        break;
	case 30:
		break;
	case 31:
		lua_pushnumber( L, pPlayer->m_Property.m_dwGMLevel);
		break;
	case 32:
		luaEx_pushint63( L, pPlayer->GetMac());
		break;
	case 35:
		lua_pushnumber(L, pPlayer->m_wTeamMemberCount);
		break;
	case 36:
		lua_pushnumber( L, pPlayer->m_Property.dwPointCost );
		break;
	// Ԫ������
	case 37:
		lua_pushnumber( L, pPlayer->m_Property.m_dwYuanBao );
		break;
	case 38:
		lua_pushnumber( L, pPlayer->m_wSuitAddE );
		break;
	// ��Ӫ
	case 39:
		lua_pushnumber(L, pPlayer->GetCamp());
		break;
	case 40:
		lua_pushnumber( L, pPlayer->m_wSuitAddJ);
		break;
	// ŭ�����ֵ
	case 41:
		lua_pushnumber( L, pPlayer->GetMaxMP() );
		break;
	case 42:
		lua_pushnumber( L, pPlayer->m_wSuitAddQ);
		break;
	// ͭǮ��
	case 48:
		lua_pushnumber(L, pPlayer->m_Property.m_dwMoney);
		break;
	// ��ǰ����ֵ
	case 52:
		lua_pushnumber(L, pPlayer->m_Property.m_iExp);
		break;
	// �������辭��ֵ
	case 53:
		lua_pushnumber(L, pPlayer->m_qwMaxExp);
		break;
	// ��ҵ�ǰ���� x y regionID
	case  56:
		lua_pushnumber(L, pPlayer->m_wCurX);
		lua_pushnumber(L, pPlayer->m_wCurY);
		lua_pushnumber(L, pPlayer->m_Property.m_wCurRegionID);
		LS_CHKRET(3);
	// ��Ҷ���gid
	case 57:
		{
			lua_pushnumber(L, pPlayer->GetTargetGID());
			LS_CHKRET(1);
		}
	case 58:
		{
			if( pPlayer->m_ParentArea ) {
				lua_pushnumber(L, pPlayer->m_ParentArea->m_PlayerList.size());
				LS_CHKRET(1);
			}
			LS_CHKRET(0);
		}
	case 60:
		{
			DWORD gid = 0;
			if( pPlayer->m_ParentRegion )
			if( CDynamicRegion *pRegion = (CDynamicRegion *)pPlayer->m_ParentRegion->DynamicCast(IID_DYNAMICREGION) )
				gid = pRegion->GetGID();
			lua_pushnumber(L, gid);
			LS_CHKRET(1);
		}
	case 61:
		{
			if( !pPlayer->mLastEnemyGID ) LS_CHKRET(0);
			if( GetPlayerByGID(pPlayer->mLastEnemyGID) ){
				lua_pushnumber(L, pPlayer->mLastEnemyGID);
				LS_CHKRET(1);
			}
			LS_CHKRET(0);
		}
	// ս����
	case 62:
		{
			lua_pushnumber(L,pPlayer->m_Property.dwFightVal );
			LS_CHKRET(1);
		}
	case 63:
		{
			lua_pushnumber(L,pPlayer->m_Property.m_OpenTags);
			LS_CHKRET(1);
		}
	case 64:
		{
			lua_pushnumber(L,pPlayer->m_Property.m_storeOpenTags);
			LS_CHKRET(1);
		}
	case 66:
		{
			lua_pushboolean(L,pPlayer->m_Property.m_szTongName[0]!=0);
			LS_CHKRET(1);
		}
	case 67:
		{
			lua_pushstring(L,pPlayer->m_Property.m_szTongName);
			LS_CHKRET(1);
		}
	// ����
	case 68:
		{
			extern bool CheckTalkMask( LPCSTR account );
			if( CheckTalkMask( pPlayer->GetAccount() ) )
				lua_pushnumber(L,1);
			else
				lua_pushnumber(L,0);
			LS_CHKRET(1);
		}
		break;
	case 69:
		{
			if( pPlayer->m_Property.m_szMateName[0]!=0 ){
				lua_pushstring(L,pPlayer->m_Property.m_szMateName);
				LS_CHKRET(1);
			}
			LS_CHKRET(0);
		}
	// ͷ��(0-3)
	case 70:
		lua_pushnumber(L, pPlayer->m_Property.m_byHead);
		break;
    default:
        LS_CHKRET(0);
    }

    LS_CHKRET(1);
}
// check
int CScriptManager::L_CI_SetPlayerData(lua_State *L)
{
	LS_CHKTOP(2);

	CPlayer *obj = g_Script.m_pPlayer;
    if ( obj == NULL )
        LS_CHKRET(0);

    int type = ( int )lua_tonumber( L, 1 );
	int ret  = 1;
	switch( type )
	{
	case 0:
		{
			//���������ʯǿ���ȼ�
			BYTE newLevel = ( BYTE )lua_tonumber( L, 2 );
			if( newLevel > obj->m_Property.m_byJewelLevel ){
				obj->m_Property.m_byJewelLevel = newLevel;
				SQSendJewelLevelMsg msg;
				msg.byNewLevel = obj->m_Property.m_byJewelLevel;
				g_StoreMessage( obj->m_ClientIndex , &msg , sizeof(msg) );

				// ������ʱȫ�����£��Ժ���Կ��������ķ�ʽ����
				obj->InitEquipmentData();
				obj->UpdateCommonAtt();
				ret = 0;
			}
			break;
		}
		break;
	case 1:
		{
			//����ͷ��
			BYTE newHead = ( BYTE )lua_tonumber( L, 2 );
			if( newHead != obj->m_Property.m_byHead ){
				obj->m_Property.m_byHead = newHead;
				ret = 0;
			}
		}
		break;
	case 2:
		{
			BYTE bHide = ( BYTE )lua_tonumber( L, 2 );
			//��������
			if( obj->SetHide( bHide ) )
				ret = 0;
		}
		break;
	case 3:
		{
			//�޸�����
			LPCSTR szName = ( LPCSTR )lua_tostring( L, 2 );
			//����ֻ���޸ģ��Ϸ��Լ�������֤����֮ǰ���ж�
			if( strlen(szName) < MAX_ROLENAMESIZE ) {
				strcpy_s( obj->m_Property.m_szName , szName );
				ret = 0;
			}
		}
		break;
	case 4:
		{
			//����pk����
			obj->m_Property.m_byPKRule = ( BYTE )lua_tonumber( L, 2 );
			ret = 0;
		}
		break;
	case 5:
		{
			//���ð��id����������ʱ�������ᣩ
			if( obj->m_Property.dwFactionId == 0 )
				obj->m_Property.dwFactionId = ( DWORD )lua_tonumber( L, 2 );
			ret = 0;
		}
		break;
	case 6:
		{
			if( CHKSTK(3) ){
				obj->m_wMP = 0;
				extern int		mp_max;
				obj->m_wMaxMP = mp_max;
			}else{
				//���⼼�����Ľ���ŭ��ʱ�����õ�ǰŭ�������ŭ��
				obj->m_wMP = ( WORD )lua_tonumber( L, 2 );
				obj->m_wMaxMP = ( WORD )lua_tonumber( L, 3 );
			}
			ret = 0;
		}
		break;
	case 7:
		{
			//�޸��Ա�
			BYTE bySex = ( BYTE )lua_tonumber( L, 2 );
			//����ֻ���޸�
			if( bySex < 2 ) {
				obj->m_Property.m_bySex = bySex;
				ret = 0;
			}
		}
		break;
	case 8:
		{
			//�޸�ְҵ
			BYTE bySchool = ( BYTE )lua_tonumber( L, 2 );
			//����ֻ���޸�
			if( bySchool < SD_MAX ) {
				obj->m_Property.m_bySchool = bySchool;
				ret = 0;
			}
		}
		break;
	case 9:
		{
			//�޸ķ�����ʱ��
			int idTime = ( int )lua_tonumber( L, 2 );
			if( idTime == -1 ){
				obj->limitedState = 0;
			}else{
				obj->IDlineTime = idTime - obj->onlineTime;
				obj->NotifyTimeLimit( obj->onlineTime );
			}
		}
		break;
	case 10:
		{
			//���÷�����id
			obj->m_GroupID = ( DWORD )lua_tonumber( L, 2 );
		}
		break;
	case 11:
		{
			//�����˺�ͳ��
			obj->m_dwDamCount[0] = 0;
			obj->m_dwDamCount[1] = 0;
		}
		break;
	}
	lua_pushnumber(L,ret);
    LS_CHKRET(1);
}
// check
// ����ȡ�� ͬ math.floor
int CScriptManager::L_rint(lua_State *L)
{
	LS_CHKTOP(1);

    int num = static_cast<int>(lua_tonumber(L, 1));
    lua_pushnumber(L, num);

    LS_CHKRET(1);
}
// check
// �ƶ����
/**
	�̶�������regionId	x	y
	��ѡ������gid	2	sid
**/
int CScriptManager::L_CI_MovePlayer(lua_State *L)
{
	LS_CHKTOP(3);

	CPlayer* obj = NULL;
	GET_PLAYER( L , 4 );

    WORD wRegion = static_cast<WORD>(lua_tonumber(L, 1));
    WORD wToX = static_cast<WORD>(lua_tonumber(L, 2));
    WORD wToY = static_cast<WORD>(lua_tonumber(L, 3));
    DWORD dwGID = static_cast<DWORD>(lua_tonumber(L, 4));

    BOOL ret = PutPlayerIntoDestRegion( obj, wRegion, wToX, wToY, dwGID, FALSE);
	if( ret ){
		lua_pushboolean(L, true);
		LS_CHKRET(1);
	}

	lua_pushboolean(L, false);
    LS_CHKRET(1);
}
// �ƶ����ﵽ x , y, args[3] = 1 ʱ�ƶ���������,args[4] = 3 Ϊ�ƶ���ǰ�� args[4] = 6 Ϊ�ƶ�ָ����
/**
	�̶�������x	  y		args[3]		args[4](��������)
	��ѡ������args[4] = 6 ʱ����Ҫ����args[5](controlID)
**/
int CScriptManager::L_CI_MoveMonster(lua_State *L)
{
	LS_CHKTOP(2);

	CMonster* obj = NULL;
	GET_MONSTER( L , 3 );

    WORD wToX = static_cast<WORD>(lua_tonumber(L, 1));
    WORD wToY = static_cast<WORD>(lua_tonumber(L, 2));
	BYTE toSrc = 0;
	if( lua_isnumber(L,3))
		toSrc = (BYTE)lua_tonumber(L, 3);
	if( toSrc == 1 ){
		wToX = obj->m_Property.m_wSrcX;
		wToY = obj->m_Property.m_wSrcY;
	}
	lua_pushboolean(L, GetGW()->MoveMonster( obj->self.lock(), wToX, wToY  ) );
    LS_CHKRET(1);
}
// check
// ��鱳��ʣ�������
int CScriptManager::L_isFullNum(lua_State *L)
{
	LS_CHKTOP(0);

	if (g_Script.m_pPlayer == NULL)
		LS_CHKRET(0);

	lua_pushnumber( L, g_Script.m_pPlayer->CheckAddItem() );
	LS_CHKRET(1);
}
// check
// ��鱳���Ƿ�װ��
int CScriptManager::L_isfull(lua_State *L)
{
	LS_CHKTOP(0);

	if (g_Script.m_pPlayer == NULL)
		LS_CHKRET(0);

	if (g_Script.m_pPlayer->CheckAddItem() > 0)
		lua_pushboolean(L, false);
	else
		lua_pushboolean(L, true);
	LS_CHKRET(1);
}
// ����/�۳���ҵ���ֵ������/�ȼ�/����/���� �� check
int CScriptManager::L_CI_PayPlayer(lua_State *L)
{
	LS_CHKTOP(2);

	CPlayer *obj = NULL;
	GET_PLAYER( L , 5 );

	WORD	wIndex		= ( WORD  )lua_tonumber(L, 1);
	int		iData		= ( int   )lua_tonumber(L, 2);
	int		toDie		= lua_isnumber(L,3) ? ( int   )lua_tonumber(L, 3) : 0;			// �Ƿ��Ѫ�۵���
	float	iPercent	= lua_isnumber(L,4) ? ( float )lua_tonumber(L, 4) : 0;			// �����ٷֱ�

    DWORD hpDec = 0;

    BOOL bResAttrib = FALSE;
    BOOL bAddPoint = FALSE;

	switch(wIndex)
	{
	case 1:  // ����
        {
			LPCSTR info = ( LPCSTR )lua_tostring( L , 5 );
			if( !info ) info = GetNpcScriptInfo("L_CI_PayPlayer");

            if(iData < 0)
            {
				if( obj->m_Property.m_iExp < abs(iData) )
					LS_CHKRET(0);

                if ((obj->m_Property.m_iExp + iData) > 0)
                    obj->m_Property.m_iExp += iData;
                else
                    obj->m_Property.m_iExp = 0;

				SAExpChangeMsg  ExpMsg;
				ExpMsg.dwGlobalID = obj->GetGID();
				ExpMsg.dwCurExp = (UINT64)obj->m_Property.m_iExp;
				ExpMsg.byExpChangeType = 5;
				g_StoreMessage( obj->m_ClientIndex, &ExpMsg, sizeof(SAExpChangeMsg) );

				extern int expRank;
				extern void WriteExpChangeToDB( CPlayer* player, int iData, LPCSTR info  );
				if( abs(iData) > expRank ){
					obj->SetKeyChange( KLT_EXP , 1 );
					WriteExpChangeToDB( obj, iData,info  );
				}
            }
			else if ( iData == 0 && toDie == 0 && iPercent > 0.0)
			{
				int maxExp = CRoleLevelUpTbl::GetSingleton()->GetPlayerDataByLevel( obj->m_Property.m_wLevel )->m_qwMaxExp;
				iData = maxExp * iPercent;
				if( iData > 0 )
					obj->SendAddPlayerExp( iData, 0, false, 1, info );
			}
            else
            {
				WORD byOldLevel = obj->m_Property.m_wLevel;

				if( iData > 0 )
					obj->SendAddPlayerExp( iData, 0, false, 1, info );

				WORD byNowLevel = obj->m_Property.m_wLevel;
            }
			LS_CHKRET(0);
        }
        break;
	case 2:  // �ȼ�
  //      {
		//	int val = obj->m_Property.m_wLevel + iData;
		//	if ( val >  CRoleLevelUpTbl::GetSingleton()->GetMaxLevel() || val <= 0 )
		//		LS_CHKRET(0);
		//
  //          if ( iData >= 0 )
		//	{
  //              obj->SendAddPlayerLevel( iData, SASetEffectMsg::EEFF_LEVELUP, GetNpcScriptInfo( "CI_PayPlayer" ) );
		//	}
  //          else
  //          {
  //              obj->SendAddPlayerLevel( 0, 0 );
  //          }
  //      }
		//LS_CHKRET(0);
        break;
    case 3:  // ����
		if( obj->isDead() ) break;// check

        if ( ( int )obj->m_dwHP + iData > ( int )obj->GetMaxHP() )
            obj->m_dwHP = obj->GetMaxHP();
        else if ( ( int )obj->m_dwHP + iData <= 0 )
            ( hpDec = obj->m_dwHP ), ( obj->m_dwHP = toDie ? 0 : 1 );
        else
        {
            obj->m_dwHP += iData;
            if ( iData < 0 ) hpDec = -iData;
        }

        bResAttrib = TRUE;
        break;
    case 4:  // ����
		if( obj->isDead() ) break;

        if ( ( int )obj->m_wMP + iData > ( int )obj->GetMaxMP() )
            obj->m_wMP = obj->GetMaxMP();
        else if ( ( int )obj->m_wMP + iData < 0 )
            obj->m_wMP = 0;
        else
            obj->m_wMP += iData;
        bResAttrib = TRUE;
        break;
	default:
		LS_CHKRET(0);
	}

    if ( hpDec )
		obj->SendObjectResAttrib();
    else if ( bResAttrib )
        obj->SendObjectResAttrib();

	LS_CHKRET(0);
}
// check
// ���ó���PK����
/**
	������regionId	PKType
**/
int CScriptManager::L_setregionpktype(lua_State *L)
{
	LS_CHKTOP(2);

    DWORD dwRegionID = static_cast<DWORD>(lua_tonumber(L, 1));
    DWORD dwPKType = static_cast<DWORD>(lua_tonumber(L, 2));

    CRegion *pRegion = ExtraLuaFunctions::GetRegionById( dwRegionID );
    //CRegion *pRegion = (CRegion *)FindRegionByID(wRegionID)->DynamicCast(IID_REGION);
    if ( pRegion == NULL )
        LS_CHKRET(0);

	if( dwPKType > 4 ) return lua_pushnumber( L, pRegion->m_dwPKAvailable ),1;

    pRegion->m_dwPKAvailable = dwPKType;

    LS_CHKRET(0);
}

// check
int CScriptManager::L_getcurtimeA(lua_State *L)
{
	LS_CHKTOP(0);

    LPCSTR string = GetStringTime();
    lua_pushstring(L, string);

    LS_CHKRET(1);
}
// ɾ��һ��ָ��λ�õĵ��� check
/**
	������x(����)  y(����)  ���߱��  ?��������  ��־
**/
int  CScriptManager::L_CI_DelItemByPos(lua_State *L)
{
	LS_CHKTOP(4);

    if (g_Script.m_pPlayer == NULL)
        LS_CHKRET(0);

    WORD	wX			= (WORD)lua_tonumber(L, 1);
    WORD	wY			= (WORD)lua_tonumber(L, 2);
	WORD	wCheckID	= (WORD)lua_tonumber(L, 3);
	WORD	wCount		= (WORD)lua_tonumber(L, 4);
	LPCSTR	info		= (LPCSTR)lua_tostring(L, 5);
	if( !info ) info = GetNpcScriptInfo("L_CI_DelItemByPos");

	int ret = g_Script.m_pPlayer->DelItemByPos( wX , wY , wCheckID , wCount , info );
	lua_pushnumber( L , ret );
	LS_CHKRET(1);
}
// check
// �����������
/**
	������
**/
int CScriptManager::L_CI_SetPlayerIcon(lua_State *L)
{
	LS_CHKTOP(3);

	CPlayer *obj = NULL;
	GET_PLAYER( L , 4 );

	BYTE	type	= (BYTE )lua_tonumber(L, 1);
	BYTE	idx		= (BYTE )lua_tonumber(L, 2);
	DWORD	val		= (DWORD)lua_tonumber(L, 3);
	bool	bSend	= (bool )lua_toboolean(L, 4);

	if( obj->SetPlayerIcon( type , idx , val ) ){
		if( bSend ) obj->SendPlayerIcon();
		if( type ==0 && idx == 0 && val ){
			//����Ǳ�Ϊvip����º��ѺͰ��

			// ���ɸ���
			GetGW()->m_FactionManager.UpdateMember( NULL, obj, 2 );
			// ���Ѹ���
			SAFriendStateMsgEx msg;
			//check
			msg.dwSID		= obj->GetSID();
			msg.bySchool	= obj->GetSchool();
			msg.wLevel		= obj->GetLevel();
			msg.dwExtend	= obj->GetPlayerIcon(0,0);
			msg.byType		= 1;
			obj->SendFriendsMsg( &msg, sizeof( SAFriendStateMsgEx ) );
		}
		lua_pushboolean(L, true);
		LS_CHKRET(1);
	}
	LS_CHKRET(0);
}
// check
int CScriptManager::L_CI_GetPlayerIcon(lua_State *L)
{
	LS_CHKTOP(2);

	CPlayer *obj = NULL;
	GET_PLAYER( L , 2 );

	BYTE  type = (BYTE )lua_tonumber(L, 1);
	BYTE  idx  = (BYTE )lua_tonumber(L, 2);
	DWORD val  = obj->GetPlayerIcon( type , idx );
	if( type == 1 && idx != 0xff ){
		//���ڽű���֧��λ����������ǽű�ͼ�꣬��������֮���ٴ�
		lua_pushnumber( L ,   val & 0xff		);
		lua_pushnumber( L , ( val>>8 ) & 0xff	);
		lua_pushnumber( L , ( val>>16 ) & 0xff	);
		lua_pushnumber( L , ( val>>24 ) & 0xff	);
		LS_CHKRET(4);
	}
	lua_pushnumber( L , (int)val );
	LS_CHKRET(1);
}

// ȡ�öӳ���SID check
int L_GetTeamLeaderSID(lua_State* L)
{
	LS_CHKTOP(0);

	if ( g_Script.m_pPlayer == NULL )
		LS_CHKRET(0);

	if ( g_Script.m_pPlayer->m_dwTeamID == 0 )
		LS_CHKRET(0);

	Team stTeamInfo;
	if ( !GetTeamInfo( g_Script.m_pPlayer->m_dwTeamID, stTeamInfo ) )
		LS_CHKRET(0);

	if ( stTeamInfo.byMemberNum == 0 )
		LS_CHKRET(0);

	lua_pushnumber( L, stTeamInfo.stTeamPlayer[0].staticId );
	LS_CHKRET(1);
}

// check
extern void DelMember( const char* szName, CPlayer *pPlayer );
extern void DelMember( DWORD,DWORD );
int CScriptManager::L_DeleteTeamMember( lua_State* L )
{
	LS_CHKTOP(2);

	int t = lua_type(L,2);
	if( t==LUA_TSTRING )
	{
		int leaderSID = (int)lua_tonumber(L, 1);
		const char* memberName = (const char*)lua_tostring(L, 2);

		CPlayer* pLeader = (CPlayer*)GetPlayerBySID(leaderSID)->DynamicCast(IID_PLAYER);
		if (pLeader == NULL || memberName == NULL)
			LS_CHKRET(0);

		DelMember(memberName, pLeader);
	}
	else if( t==LUA_TNUMBER )
	{
		DWORD dwTeamId = (DWORD)lua_tonumber(L, 1);
		DWORD player_sid = (DWORD)lua_tonumber(L, 2);
		DelMember(dwTeamId, player_sid);
	}

	LS_CHKRET(0);
}
// check
int CScriptManager::L_GetCertainTeamInfo(lua_State *L)
{
	DWORD dwSID = static_cast<DWORD>( lua_tonumber(L,1));
	CPlayer *pPlayer = 0;
	if( dwSID != 0 )
		pPlayer = (CPlayer *)GetPlayerBySID(dwSID)->DynamicCast(IID_PLAYER);
	else
		return 0;
	CScriptState s( NULL, pPlayer, NULL );
	return L_GetTeamInfo( L );
}

// ���һ����������� check
int CScriptManager::L_GetTeamInfo( lua_State *L )
{
	LS_CHKTOP(0);

	if ( g_Script.m_pPlayer == NULL )
		LS_CHKRET(0);

	if ( g_Script.m_pPlayer->m_dwTeamID == 0 )
		LS_CHKRET(0);

	int prevStack = lua_gettop( L );

	Team stTeamInfo;
	if ( !GetTeamInfo( g_Script.m_pPlayer->m_dwTeamID, stTeamInfo ) )
        LS_CHKRET(0);

	if ( stTeamInfo.byMemberNum == 0 )
		LS_CHKRET(0);

	lua_createtable( L, stTeamInfo.byMemberNum, 0 );
	if ( !lua_istable( L, -1 ) )
		LS_CHKRET(0);

	// Ϊÿ����Ա����һ���ӱ�,Ĭ�϶ӳ�Ϊ��һ��,����Ϊ��Ա
	for ( int n = 0; n < stTeamInfo.byMemberNum; n++ )
	{
		lua_pushnumber( L, n + 1 );
        lua_createtable( L, 0, 2 );
		if ( !lua_istable( L, -1 ) ){
	        lua_settop( L, prevStack );
			LS_CHKRET(0);
		}

		// ����
		//lua_pushstring( L, "name" );
		//lua_pushstring( L, stTeamInfo.stTeamPlayer[n].szName );
		//lua_settable( L, -3 );

		// �ȼ�
		//WORD level = stTeamInfo.stTeamPlayer[n].byLevel;
		//lua_pushstring( L, "level" );
		//lua_pushnumber( L, level );
		//lua_settable( L, -3 );

		// ����
		//lua_pushstring( L, "tongName" );
		//lua_pushstring( L, stTeamInfo.stTeamPlayer[n].szTongName );
		//lua_settable( L, -3 );

		// PW��Ϸֵ
		//lua_pushstring( L, "xvalue" );
		//lua_pushnumber( L, stTeamInfo.stTeamPlayer[n].sXValue );
		//lua_settable( L, -3 );

		// ����
		//lua_pushstring( L, "school" );
		//lua_pushnumber( L, stTeamInfo.stTeamPlayer[n].bySchool );
		//lua_settable( L, -3 );

		// ��ǰHP
		//lua_pushstring( L, "curHP" );
  //      lua_pushnumber( L, stTeamInfo.stTeamPlayer[n].wCurHP );
		//lua_settable( L, -3 );

		// ���HP
		//lua_pushstring( L, "maxHP" );
		//lua_pushnumber( L, stTeamInfo.stTeamPlayer[n].wMaxHP );
		//lua_settable( L, -3 );

		// ����X
		//lua_pushstring( L, "x" );
		//lua_pushnumber( L, stTeamInfo.stTeamPlayer[n].byX );
		//lua_settable( L, -3 );

		// ����Y
		//lua_pushstring( L, "y" );
		//lua_pushnumber( L, stTeamInfo.stTeamPlayer[n].byY );
		//lua_settable( L, -3 );

		// �������
		lua_pushstring( L, "regionId" );
		lua_pushnumber( L, stTeamInfo.stTeamPlayer[n].wRegionID );
		lua_settable( L, -3 );

		// ͷ��
		//lua_pushstring( L, "head" );
		//lua_pushnumber( L, stTeamInfo.stTeamPlayer[n].byHead );
		//lua_settable( L, -3 );

		// SID�����ڲ���Ŀ��
		lua_pushstring( L, "staticId" );
        lua_pushnumber( L, stTeamInfo.stTeamPlayer[n].staticId );
		lua_settable( L, -3 );

		// serverId�����ڲ���Ŀ��
		//lua_pushstring( L, "serverId" );
  //      lua_pushnumber( L, stTeamInfo.stTeamPlayer[n].wServer );
		//lua_settable( L, -3 );

		lua_settable( L, -3 );
	}

	if( prevStack + 1 != lua_gettop( L ) ){
		TraceInfo_C("LuaStackError.txt", "[L_GetTeamInfo]: stack error!");
	}

	sassert( prevStack + 1 == lua_gettop( L ) );

	LS_CHKRET(1);
}

/** ��ȡ��ż���ڵĳ������� check
	���أ�
		-1 û����ż
		-2 ��ż������
		-3 ��ż�����ñ������
*/
int CScriptManager::L_GetMarrowInfo( lua_State *L )
{
	LS_CHKTOP(0);

	if( g_Script.m_pPlayer == NULL )
		LS_CHKRET(0);

	// �������� ��ʱ��δ�ã������Ժ���
	// int value = static_cast<int>(lua_tonumber(L, 1));

	// û����ż
	if( g_Script.m_pPlayer->m_Property.m_szMateName[0] == 0 )
		LS_RET(-1);

	// ��ż������
    LPIObject GetPlayerByName( LPCSTR szName );
	CPlayer *marPlay = (CPlayer *)(GetPlayerByName( g_Script.m_pPlayer->m_Property.m_szMateName )->DynamicCast( IID_PLAYER ) );
    if ( marPlay == NULL || marPlay->m_ParentRegion == NULL )
        LS_RET(-2);

    // �Է�����ż������
    if ( marPlay->m_Property.m_szMateName[0] == 0 ||
        dwt::strcmp( marPlay->m_Property.m_szMateName, g_Script.m_pPlayer->GetName(), MAX_ROLENAMESIZE ) != 0 )
    {
        g_Script.m_pPlayer->m_Property.m_szMateName[0] = 0;
       // g_Script.m_pPlayer->m_Property.m_dwMarryDate = 0;
        g_Script.m_pPlayer->SendMyState();
        LS_RET(-3);
    }

	if( marPlay->m_ParentRegion && marPlay->m_ParentRegion->DynamicCast(IID_DYNAMICREGION) ) return lua_pushnumber( L, -4 ), 1;

	WORD sceneID = marPlay->m_ParentRegion ? marPlay->m_ParentRegion->m_wRegionID : 0;
	WORD posx = marPlay->m_wCurX;
	WORD posy = marPlay->m_wCurY;

	// ����
	lua_pushnumber( L, sceneID );
	lua_pushnumber( L, posx );
	lua_pushnumber( L, posy );

	LS_CHKRET(3);
}

/** ��ȡ������һЩ��Ϣ ... check
*/
int CScriptManager::L_GetRegionInfo( lua_State *L )
{
	LS_CHKTOP(1);

	if ( g_Script.m_pPlayer == NULL || g_Script.m_pPlayer->m_ParentArea == NULL )
		LS_CHKRET(0);

	int pranmaType = ( int )lua_tonumber( L, 1 );
	switch( pranmaType )
	{
		/*��ż���ڵĳ�������*/
	case 1:
		{
			// û����ż
			if( strcmp( g_Script.m_pPlayer->m_Property.m_szMateName, "" ) == 0 )
				LS_RET(-1);

			// ��ż������
			LPIObject GetPlayerByName( LPCSTR szName );
			CPlayer *marPlay = (CPlayer *)(GetPlayerByName( g_Script.m_pPlayer->m_Property.m_szMateName )->DynamicCast( IID_PLAYER ) );
			if (  marPlay == NULL || marPlay->m_ParentRegion == NULL )
				LS_RET(-2);

			lua_pushnumber( L, marPlay->m_ParentRegion->m_MapProperty );
			LS_CHKRET(1);
		}
		break;
		/*��չ ..... */
	default:
		LS_RET(-1);
	}
}

// check
int CScriptManager::L_LockPlayer(lua_State* L)
{
	LS_CHKTOP(1);

	if( !lua_isnumber(L,1) )
		LS_CHKRET(0);

	DWORD dwTime = static_cast<DWORD>( lua_tonumber(L,1) );
	DWORD dwSID = static_cast<DWORD>( lua_tonumber(L,2) );

	CPlayer *pPlayer = 0;
	if( dwSID==0 )	pPlayer = g_Script.m_pPlayer;
	else			pPlayer = (CPlayer *)GetPlayerBySID(dwSID)->DynamicCast(IID_PLAYER);
	if( pPlayer==0 )LS_CHKRET(0);

	pPlayer->mLockEvent.Setup( dwTime, "lock" );

	LS_CHKRET(0);
}
// check
int CScriptManager::L_UnLockPlayer(lua_State* L)
{
	LS_CHKTOP(0);

	DWORD dwSID = static_cast<DWORD>( lua_tonumber(L,1) );

	CPlayer *pPlayer = 0;
	if( dwSID==0 )	pPlayer = g_Script.m_pPlayer;
	else			pPlayer = (CPlayer *)GetPlayerBySID(dwSID)->DynamicCast(IID_PLAYER);
	if( pPlayer==0 )LS_CHKRET(0);

	pPlayer->mLockEvent.Destroy( );

	LS_CHKRET(0);
}

// check
int CScriptManager::L_GetCurCopyScenesGID(lua_State *L)
{
	LS_CHKTOP(0);

	DWORD dwPlayerSID = static_cast<DWORD>(lua_tonumber(L, 1));
	CPlayer* pPlayer=0;
	if( dwPlayerSID == 0 )
		pPlayer = g_Script.m_pPlayer;
	else
		pPlayer = (CPlayer *)GetPlayerBySID(dwPlayerSID)->DynamicCast(IID_PLAYER);
	if (pPlayer == NULL)
		LS_CHKRET(0);

    DWORD wRegionID = 0;
    if ( pPlayer->m_ParentRegion )
    {
		CDynamicRegion* pRegion = (CDynamicRegion*)pPlayer->m_ParentRegion->DynamicCast( IID_DYNAMICREGION );
        if ( pRegion )
            wRegionID = pRegion->GetCopySceneGID();
    }
    lua_pushnumber(L, wRegionID);

    LS_CHKRET(1);
}

// ���ڲ����������ư󶨱�ʶ����ѭĬ�ϵİ󶨹���
// �ű����ɵر���߽ӿ�[�������ɵ���Ϊ�󶨵���] check
int CScriptManager::L_CreateGroundItem(lua_State *L)
{
	LS_CHKTOP(6);

	WORD  wRegionID = static_cast<WORD>(lua_tonumber(L, 1));
	DWORD dwRegionGID = static_cast<DWORD>(lua_tonumber(L, 2));

	CRegion *pRegion = NULL;
	if (dwRegionGID == 0)
	{
		pRegion = (CRegion *)FindRegionByID(wRegionID)->DynamicCast(IID_REGION);
	}
	else
	{
		pRegion = (CRegion *)FindRegionByGID(dwRegionGID)->DynamicCast(IID_REGION);
	}
	if (pRegion == NULL)
		LS_CHKRET(0);

	WORD	wIndex			= (WORD)lua_tonumber(L,3);
	int		number			= (int )lua_tonumber(L,4);
	int		x				= (int )lua_tonumber(L,5);
	int		y				= (int )lua_tonumber(L,6);
	DWORD	iCount			= (DWORD )lua_tonumber(L,7);
	int		protectedGID	= (int )lua_tonumber(L,8);
	WORD	slots			= (WORD)lua_tonumber(L,9);
	WORD	level			= (WORD)lua_tonumber(L,10);

	const SItemData* pData  = CItem::GetItemData( wIndex);
	if ( pData == NULL )
		LS_CHKRET(0);

	POINT pt = {x,y};
	CItem::CreateNewGroundItem( pRegion , protectedGID , 0 , iCount , pt ,wIndex , number , slots , level , false );

	LS_CHKRET(0);
}

// ���������� check
int CScriptManager::L_AskJoinTeam(lua_State *L)
{
	LS_CHKTOP(2);

	DWORD SourceSID = (DWORD)lua_tonumber(L,1);		// ������
	CPlayer *pSource = NULL;
	LPIObject pSouceObj = GetPlayerBySID(SourceSID);
	if( SourceSID && pSouceObj )
		pSource = (CPlayer *)pSouceObj->DynamicCast(IID_PLAYER);
	if ( !pSource)
	{
		lua_pushboolean( L, false);
		LS_CHKRET(1);
	}
	DWORD DestSID = (DWORD)lua_tonumber(L,2);		// �������ߣ��ӳ������ǵ���
	CPlayer *pDest = NULL;
	LPIObject pDestObj = GetPlayerBySID(DestSID);
	if( DestSID && pDestObj)
		pDest = (CPlayer *)pDestObj->DynamicCast(IID_PLAYER);

	if ( !pDest )		// ֱ�Ӽ�����飬�ɹ��������������ʾ��Ϣ
	{
		pDest->SendErrorMsg(SABackMsg::N_PLAYER_NOTFIND);
		lua_pushboolean( L, false);
		LS_CHKRET(1);
	}

	if ( pSource->m_ParentRegion == NULL || pSource->m_ParentRegion->DynamicCast( IID_DYNAMICREGION ) )
	{
		lua_pushboolean( L, false);
		LS_CHKRET(1);
	}

	if ( pDest->m_ParentRegion == NULL || pDest->m_ParentRegion->DynamicCast( IID_DYNAMICREGION ) )
	{
		lua_pushboolean( L, false);
		LS_CHKRET(1);
	}

	if( !IsAddPlayer( pDest, pSource ) )
	{
		lua_pushboolean( L, false);
		LS_CHKRET(1);
	}

	AddTeamMember( pDest, pSource );

	lua_pushboolean( L, true);
	LS_CHKRET(1);
}
// check
static int L_CI_AddMulExpTicks(lua_State *L)
{
	LS_CHKTOP(2);

	CPlayer *obj = NULL;
	GET_PLAYER( L , 2 );

	WORD  Multiple  = ( WORD  )lua_tonumber( L, 1 );
	DWORD AddTicks  = ( DWORD )lua_tonumber( L, 2 );

	if( Multiple == 0 || AddTicks == 0 || Multiple > 40 || AddTicks > 60000000 )
		LS_RET(-1);

	int sk = -1 , zk = -1;
	for( int i = 0 ; i < MUTI_EXP_TYPE ; i ++ ){
		MultiplicityExp &temp = obj->m_Property._MultiplicityExp[i];

		// ��������ͬ���ʵľ�����ֱ���˳�����
		if( temp._Multiple == Multiple ){
			sk = i;
			break;
		}

		// �����һ��δ�����õ�λ�ã��Ա����ڵò�����ͬ����������
		if( temp._Multiple == 0 && zk == -1 )
			zk = i;
	}

	// �Ҳ���λ��
	if( sk == -1 && zk == -1 )
		LS_RET(-2);

	// �Ҳ�����ͬ��λ�������õ�һ��Ϊ0��λ��
	if( sk == -1 ) sk = zk;

	if( sk < 0 || sk >= MUTI_EXP_TYPE )
		LS_RET(-3);

	MultiplicityExp &curExp = obj->m_Property._MultiplicityExp[sk];

	if( curExp._LeftTicks + AddTicks > 60000000 )
		LS_RET(-4);

	curExp._LeftTicks += AddTicks;
	curExp._Multiple = Multiple;

	obj->SendMultiplicityExpMsg();

	lua_pushnumber( L , 0 );
	LS_CHKRET(1);
}
// check
static int L_GetCurPlayerWallow(lua_State* L)
{
	LS_CHKTOP(0);

	if (g_Script.m_pPlayer == NULL)
		LS_CHKRET(0);

	if( g_Script.m_pPlayer->limitedState ){
		lua_pushnumber(L, g_Script.m_pPlayer->m_byFatigueStep);
		LS_CHKRET(1);
	}
	LS_CHKRET(0);
}
// check
int CScriptManager::L_GetServerTime(lua_State *L)
{
	LS_CHKTOP(0);
	time_t serverTime = time(0)+60;
	lua_pushnumber( L,serverTime ); // ������ʱ���ܿ�60��
	LS_CHKRET(1);
}
// check
int CScriptManager::L_GetUseLogDBId(lua_State *L)
{
	LS_CHKTOP(0);
	lua_pushnumber( L,useLogDBId ); // ����uselog dbid
	LS_CHKRET(1);
}
// check
int CScriptManager::L_GiveGoodsBatch(lua_State* L)
{
	LS_CHKTOP(1);

	if (!lua_istable(L, 1))
		LS_CHKRET(0);

	// ֧��ѡ����
	CPlayer *obj = NULL;
	GET_PLAYER( L , 2 );

	//if (g_Script.m_pPlayer == NULL)
	//	LS_CHKRET(0);

	std::vector<CPlayer::GenItemBatchParam> paramList;
	int tableLen = (int)lua_objlen(L, 1);
	if( tableLen > 60 ) LS_CHKRET(0);
	LPCSTR logStr = NULL;
	if(lua_isstring(L,2))
		logStr = static_cast<const char *>(lua_tostring(L, 2));
	if( logStr == NULL ) logStr = GetNpcScriptInfo("L_GiveGoodsBatch");

	for (int i = 1; i <= tableLen; ++i)
	{
		lua_rawgeti(L, 1, i);

		{
			if (!lua_istable(L, -1)){
				lua_pop(L, 1);
				continue;
			}
			size_t num = lua_objlen(L, -1);
			if ( num < 3){
				lua_pop(L, 1);
				continue;
			}

			lua_rawgeti(L, -1, 1);
			WORD index = (WORD)lua_tointeger(L, -1);
			lua_pop(L, 1);

			lua_rawgeti(L, -1, 2);
			DWORD count = (DWORD)lua_tonumber(L, -1);
			lua_pop(L, 1);

			lua_rawgeti(L, -1, 3);
			BYTE bind = (BYTE)lua_tointeger(L, -1);
			lua_pop(L, 1);

			WORD slots = 0 , level = 0;
			if( num == 5 ){
				lua_rawgeti(L, -1, 4);
				slots = (WORD)lua_tointeger(L, -1);
				lua_pop(L, 1);

				lua_rawgeti(L, -1, 5);
				level = (WORD)lua_tointeger(L, -1);
				lua_pop(L, 1);

			}

			paramList.push_back(CPlayer::GenItemBatchParam(index, count, bind, slots, level));
		}

		lua_pop(L, 1);
	}
	CPlayer::GenItemBatchParam::RET_CODE retCode = CPlayer::GenItemBatchParam::RC_OK;
	int nCount = 0;
	bool ret = obj->GenerateNewItemBatch(paramList, retCode, nCount,(char*)logStr);
	lua_pushboolean(L, ret);
	lua_pushinteger(L, (lua_Integer)retCode);
	lua_pushinteger(L, (lua_Integer)nCount);

	LS_CHKRET(3);
}
// check
int CScriptManager::L_CI_AddBuff( lua_State* L )
{
	LS_CHKTOP(4);

	CFightObject *obj = NULL;
	GET_FIGHTOBJ( L , 4 );

	WORD buffId		= static_cast<WORD>( lua_tointeger( L, 1 ) );
	int  iType		= (int)lua_tonumber( L, 2 );
	int  level		= static_cast<int>( lua_tointeger( L, 3 ) );
	BOOL isForever	= lua_toboolean( L, 4 );

	if( level <= 0  ) level = 1;
	bool ret = obj->buffManager.AddBuff( buffId, 0, level, iType, isForever , g_Script.m_pPlayer ? g_Script.m_pPlayer : obj );

	lua_pushboolean(L, ret);
	LS_CHKRET(1);
}
// check
int CScriptManager::L_CI_DelBuff( lua_State* L )
{
	LS_CHKTOP(1);

	CFightObject *obj = NULL;
	GET_FIGHTOBJ( L , 1 );

	int buffId = (int)lua_tonumber(L,1);
	if( buffId > 0 )
		obj->buffManager.DropBuff(buffId);

	lua_pushboolean(L, true);
	LS_CHKRET(1);
}
// check
int CScriptManager::L_CI_HasBuff( lua_State* L )
{
	LS_CHKTOP(1);

	CFightObject *obj = NULL;
	GET_FIGHTOBJ( L , 1 );

	int buffId = (int)lua_tonumber(L,1);
	if( buffId > 0 )
		lua_pushboolean(L, obj->buffManager.IsOwnerBuff( buffId ) );
	else
		lua_pushboolean(L, false);
	LS_CHKRET(1);
}
// check
int CScriptManager::L_CI_GetCapability( lua_State* L )
{
	LS_CHKTOP(1);

	CFightObject *obj = NULL;
	GET_FIGHTOBJ( L , 1 );

	E_CAPABLILITY cap = static_cast<E_CAPABLILITY>( lua_tointeger( L, 1 ) ) ;
	if( cap<0 || cap>= MAX_CHECKACT)
		LS_CHKRET(0);

	lua_pushboolean(L, obj->CheckAction( cap) );
	LS_CHKRET(1);
}
// check
int CScriptManager::L_CI_AddMonsterHPEvent(lua_State *L)
{
	LS_CHKTOP(5);

	CMonster *obj = NULL;
	GET_MONSTER( L , 5 );

	int ID				= static_cast<int>(lua_tointeger(L, 1));
	int TriggerCount	= static_cast<int>(lua_tointeger(L, 3));
	int Value			= static_cast<unsigned long>(lua_tointeger(L, 4));
	VEOpcode OP			= static_cast<VEOpcode>(lua_tointeger(L, 5));
	obj->m_triggerAI.AddHPEvent(TriggerAISystem::ValueEvent(ID, lua_tostring(L, 2), TriggerCount, Value, OP));
	LS_CHKRET(0);
}
// check
int CScriptManager::L_CI_AddMonsterAttackCountEvent(lua_State *L)
{
	LS_CHKTOP(5);

	CMonster *obj = NULL;
	GET_MONSTER( L , 5 );

	int ID				= static_cast<int>(lua_tointeger(L, 1));
	int TriggerCount	= static_cast<int>(lua_tointeger(L, 3));
	int Value			= static_cast<unsigned long>(lua_tointeger(L, 4));
	VEOpcode OP			= static_cast<VEOpcode>(lua_tointeger(L, 5));
	obj->m_triggerAI.AddAttackCountEvent(TriggerAISystem::ValueEvent(ID, lua_tostring(L, 2), TriggerCount, Value, OP));
	LS_CHKRET(0);
}
// check
int CScriptManager::L_CI_RemoveMonsterHPEvent(lua_State *L)
{
	LS_CHKTOP(1);

	CMonster *obj = NULL;
	GET_MONSTER( L , 1 );

	int ID = static_cast<int>(lua_tointeger(L, 1));
	obj->m_triggerAI.DelHPEvent(ID);
	LS_CHKRET(0);
}

// check
int CScriptManager::L_CI_AddMonsterBuffBeginEvent(lua_State *L)
{
	LS_CHKTOP(3);

	CMonster *obj = NULL;
	GET_MONSTER( L , 3 );

	int ID = static_cast<int>(lua_tointeger(L, 1));
	int BuffID = static_cast<unsigned short>(lua_tointeger(L, 3));
	obj->m_triggerAI.AddBuffBeginEvent(TriggerAISystem::BuffEvent(ID, lua_tostring(L, 2), 1, BuffID));

	LS_CHKRET(0);
}
// check
int CScriptManager::L_CI_AddMonsterBuffEndEvent(lua_State *L)
{
	LS_CHKTOP(3);

	CMonster *obj = NULL;
	GET_MONSTER( L , 3 );

	int ID = static_cast<int>(lua_tointeger(L, 1));
	int BuffID = static_cast<unsigned short>(lua_tointeger(L, 3));
	obj->m_triggerAI.AddBuffEndEvent(TriggerAISystem::BuffEvent(ID,lua_tostring(L, 2), 1, BuffID));

	LS_CHKRET(0);
}
// check
int CScriptManager::L_SetCostumeBuff( lua_State* L )
{
	LS_CHKTOP(1);

	if( g_Script.m_pPlayer )
		g_Script.m_pPlayer->SetCostume((int)lua_tonumber(L,1));
	LS_CHKRET(0);
}
// check
int CScriptManager::L_IsCostume( lua_State* L )
{
	LS_CHKTOP(0);

	CPlayer* player = g_Script.m_pPlayer;
	if( lua_isnumber(L,1) )
		player = (CPlayer*)GetPlayerBySID(lua_tointeger(L, 1))->DynamicCast(IID_PLAYER);

	if (!player)
		LS_CHKRET(0);

	if( player->m_costumeBuffID )
		lua_pushboolean(L,TRUE);
	else
		lua_pushboolean(L,FALSE);

	LS_CHKRET(1);
}
// check
int CScriptManager::L_GetCostumeID( lua_State* L )
{
	LS_CHKTOP(0);

	CPlayer* player = g_Script.m_pPlayer;

	if( lua_isnumber(L,1) )
		player = (CPlayer*)GetPlayerBySID(lua_tointeger(L, 1))->DynamicCast(IID_PLAYER);

	if (!player)
		LS_CHKRET(0);
	lua_pushnumber(L, player->m_costumeBuffID );
	LS_CHKRET(1);
}

// check
int CScriptManager::L_GetRidingMountId( lua_State* L )
{
	LS_CHKTOP(0);

	if( g_Script.m_pPlayer )
		lua_pushinteger( L, g_Script.m_pPlayer->GetRidingMountId() );
	else
		lua_pushinteger(L, 0);
	LS_CHKRET(1);
}
// check
int CScriptManager::L_SetTaskMask( lua_State* L )
{
	LS_CHKTOP(2);

	CPlayer *obj = NULL;
	GET_PLAYER( L , 2 );

	WORD group = (WORD)lua_tointeger(L, 1);
	WORD index = (WORD)lua_tointeger(L, 2);

	obj->SetMark(group, index);

	LS_CHKRET(0);
}

//check
int CScriptManager::L_GetTaskMask( lua_State* L )
{
	LS_CHKTOP(2);

	if( !g_Script.m_pPlayer )
		LS_CHKRET(0);

	BOOL b = g_Script.m_pPlayer->m_Property.ChkMark( (WORD)lua_tointeger(L, 1), (WORD)lua_tointeger(L, 2) );
	if( -1== b)
		LS_CHKRET(0);

	lua_pushboolean( L, b );
	LS_CHKRET(1);
}
// check
int CScriptManager::L_SendTaskMask( lua_State* L )
{
	LS_CHKTOP(0);

	if( !g_Script.m_pPlayer )
		LS_CHKRET(0);

	g_Script.m_pPlayer->SendTaskMask( (lua_isnumber(L,1) ? lua_tonumber(L,1) : -1) );

	lua_pushboolean( L, true);
	LS_CHKRET(1);
}
// check
int CScriptManager::L_IsTeamLeader( lua_State *L )
{
	LS_CHKTOP(0);

	if( !g_Script.m_pPlayer )
		LS_CHKRET(0);
	lua_pushboolean( L, g_Script.m_pPlayer->m_bIsTeamLeader );

	LS_CHKRET(1);
}
// check
int CScriptManager::L_CI_OpenPackage( lua_State* L )
{
	LS_CHKTOP(2);

	CPlayer *obj = NULL;
	GET_PLAYER(L,2);

	BYTE number = ( BYTE )lua_tointeger( L , 1 );
	BYTE type   = ( BYTE )lua_tointeger( L , 2 );

	SAAddPackOpenFlags msg;
	msg.byType = type;

	if( type == 2 ){
		if( obj->m_Property.m_storeOpenTags + number > MAX_ITEM_NUMBER )
			LS_RET(-1);

		obj->m_Property.m_storeOpenTags += number;
		msg.openFlags = obj->m_Property.m_storeOpenTags;
	}else if( type == 1 ){
		if( obj->m_Property.m_OpenTags + number > MAX_ITEM_NUMBER )
			LS_RET(-1);

		obj->m_Property.m_OpenTags += number;
		obj->InitPackage();
		msg.openFlags = obj->m_Property.m_OpenTags;
		//ÿ����һ�������������ÿ��Ű�������ʱ�����
		obj->m_Property.onlineTimeCount = 0;
	}else LS_RET(-2);

	g_StoreMessage(obj->m_ClientIndex ,  &msg , sizeof(SAAddPackOpenFlags));

	lua_pushnumber( L, 0);
	LS_CHKRET(1);
}
// check
int CScriptManager::L_CI_OnSelectRelive( lua_State* L )
{
	LS_CHKTOP(2);

	CPlayer *obj = NULL;
	GET_PLAYER( L , 2 );

	//�����Ϊ�ж�Ѫ��Ϊ0���ɽ��ո�������ڽű��������������ʱֱ�����ø���
	//if ( (EA_DEAD != obj->GetCurActionID() && EA_DEAD != obj->GetBackupActionID() ) )
	if( obj->isDead() == false )
		LS_RET(-1);

	if ( obj->m_DeadWaitTime == 0 )
		LS_RET(-2);

	BYTE op = (BYTE)lua_tonumber(L,1);
	obj->m_reliveOP = op;
	obj->m_DeadWaitTime = (long)lua_tonumber(L,2);;
	if (obj->m_DeadWaitTime != 0 ){
		SAReliveCountDown msg;
		msg.dwGID = obj->GetGID();
		msg.times = (obj->m_DeadWaitTime/5) -1 ;
		if( obj->m_ParentArea)
			obj->m_ParentArea->SendAdj( &msg , sizeof(SAReliveCountDown) , 0 );
	}

	lua_pushnumber( L, 0);
	LS_CHKRET(1);
}

// check
int CScriptManager::L_SetCamp( lua_State* L )
{
	LS_CHKTOP(1);

	CPlayer *obj = NULL;
	GET_PLAYER( L , 1 );

	CPlayer *pPlayer = obj;

	int newCamp  = (int)lua_tonumber(L,1);
	if ( newCamp < CP_PLAYER1 || newCamp > CP_PLAYER3 ){
		lua_pushboolean( L, false );
		LS_CHKRET(1);
	}

	pPlayer->SetCamp(newCamp);

	lua_pushboolean( L, true);
	LS_CHKRET(1);
}

//����Ǯ�Ƿ��㹻 check
int CScriptManager::L_checkYuanbao(lua_State *L)
{
	LS_CHKTOP(3);

	if( !lua_isnumber(L,1) ||
		!lua_isnumber(L,2) ||
		!lua_isnumber(L,3)
		)
		LS_CHKRET(0);

	DWORD money = static_cast<DWORD>( lua_tonumber(L,1) );
	bool  bDel =  lua_tonumber(L,2)!=0;
	DWORD dwSID = static_cast<DWORD>( lua_tonumber(L,3) );
	LPCSTR discription = ( LPCSTR )lua_tostring(L, 4);
	if( !discription ) discription = GetNpcScriptInfo("L_checkYuanbao");

	CPlayer *pPlayer = 0;
	if (dwSID==0)
		pPlayer = g_Script.m_pPlayer;
	else
		pPlayer = (CPlayer*)GetPlayerBySID(dwSID)->DynamicCast(IID_PLAYER);

	if (pPlayer==0)
		goto FAILURE;

	if (pPlayer->m_Property.m_dwYuanBao < money || (int)money < 0)
		goto FAILURE;

	if( bDel ) {
		pPlayer->DecMoney(money,1);
		pPlayer->SendCurrentMoney(1);
		pPlayer->m_Property.dwPointCost += money;
		if( money ) pPlayer->UpdateVIPLevel();
		extern int useLogDBId;
		extern void WriteUsePointToDB( BYTE dbId, CPlayer* player, DWORD wNum, LPCSTR info ,DWORD index = 0 , DWORD count=0 );
		WriteUsePointToDB( useLogDBId, pPlayer, money, discription,(DWORD)lua_tonumber(L,5) ,(DWORD)lua_tonumber(L,6));
	}
	lua_pushboolean( L, true );

	LS_CHKRET(1);
FAILURE:
	lua_pushboolean( L, false );
	LS_CHKRET(1);
}

// ����ϵͳ�ʼ��Ľӿڣ�ϵͳ�ʼ�ͳһ����lua���л� ��check
int CScriptManager::L_CI_SendSystemMail(lua_State *L)
{
	LS_CHKTOP(4);

	if(!lua_isstring(L,1) || !lua_istable(L,4))
		LS_CHKRET(0);
	LPCSTR	szName	= (LPCSTR)lua_tostring(L,1);
	WORD	wType	= (WORD)lua_tonumber(L,2);
	WORD	wDay	= (WORD)lua_tonumber(L,3);

	SQGMSendMailMsg msg;
	msg.mail.m_iMsgType		= wType;
	msg.mail.m_activeDay	= wDay;
	strcpy_s( msg.mail.m_szRecver , szName );
	try
	{
		int rc = luaEx_serialize( L, 4, msg.mail.m_content , sizeof( msg.mail.m_content ) );
		if ( rc <= 0 || rc > MAX_MAILCONTENT - 2  ){
			lua_pushnumber(L,rc);
			LS_CHKRET(1);
		}

		//*( LPWORD )msg.mail.m_content = ( rc | 0x8000 );
		msg.cSize = rc;

		GetGW()->SendSystemMailToPlayer(0,&msg);
	}
	catch ( lite::Xcpt & )
	{
		lua_pushnumber(L,1);
		LS_CHKRET(1);
	}

	lua_pushnumber(L,0);
	LS_CHKRET(1);
}
static int L_IsValidName( lua_State* L )
	{
		LS_CHKTOP(1);

		LPCSTR str = lua_tostring( L, 1 );
		BOOL ret = false;
		if ( str ) {
			BOOL IsValidName(LPCSTR);
			ret = IsValidName( str );
		}
		lua_pushboolean( L, ret );
		LS_CHKRET(1);
	}
	// check
	static int L_RandomInt( lua_State *L )
	{
		LS_CHKTOP(2);

		int		low = 0;
		int		high = 0;

		if( lua_isnumber( L ,1 ) )
			low		= ( int )lua_tonumber( L, 1 );

		if( lua_isnumber( L ,2 ) )
			high	= ( int )lua_tonumber( L, 2 );

		lua_pushnumber( L, Random_Int(low,high) );
		LS_CHKRET(1);
	}
	// check
	static int L_CI_SendLuaMsg( lua_State *L )
	{
		LS_CHKTOP(3);

		// ��3����������ȷ������Ϣ��Ҫ�����������͵����л�
		DWORD type = ( DWORD )lua_tonumber( L, 3 );

		SQALuaCustomMsg msg;
		ZeroMemory( msg.streamData, sizeof( msg.streamData ) );
		BYTE flags = ( BYTE )( type & 8 );
		type = type & ~8;
		size_t size = 0;
		const int top = lua_gettop( L );
		try
		{
			if ( flags == 8 )
			{
				int rc = luaEx_serialize( L, 2, msg.streamData + 2, sizeof( msg.streamData ) - 2 );
				if ( rc <= 0 || rc > sizeof( msg.streamData ) - 2 ){
					TraceInfo_C("LuaSLError.log", "L_CI_SendLuaMsg [ck=%d]",rc);
					LS_CHKRET(0); // ����ʧ��
				}

				*( LPWORD )msg.streamData = ( rc | 0x8000 );
				size = sizeof( msg.streamData ) - ( rc + 2 );
			}
		}
		catch ( lite::Xcpt & )
		{
			TraceInfo_C("LuaSLError.log", "L_CI_SendLuaMsg [lite error]");
			lua_settop( L, top );
			LS_CHKRET(0);
		}

		if ( lua_gettop( L ) != top )
		{
			TraceInfo_C("LuaStackError.txt","L_SendLuaMsg stack error");
			lua_settop( L, top );
			LS_CHKRET(0);
		}

		// ��;�����쳣, �޷��ټ���!
		if ( size == 0 )
			LS_RET(-1);

		DWORD sid = ( DWORD )lua_tonumber( L, 1 );
		const WORD msg_size = static_cast<WORD>(sizeof( msg ) - size);

		if ( type == 1 )
		{
			if ( g_Script.m_pPlayer )
			{
				g_Script.m_pPlayer->SendMsg( &msg, msg_size );
				lua_pushnumber( L, msg_size );
				LS_CHKRET(1);
			}
		}
		else if ( type == 2 )
		{
			if ( CPlayer* player = ( CPlayer* )GetPlayerBySID( sid )->DynamicCast( IID_PLAYER ) )
			{
				player->SendMsg( &msg, msg_size );
				lua_pushnumber( L, msg_size );
				LS_CHKRET(1);
			}
		}
		else if ( type == 0 )
		{
			if ( CRegion *region = GetRegionById( sid ) )
			{
				region->Broadcast( &msg, msg_size, 0 );
				lua_pushnumber( L, msg_size );
				LS_CHKRET(1);
			}
		}
		else if ( type == 3 )
		{
			BroadcastMsg( &msg, ( WORD )( sizeof( msg ) - size ) );
			lua_pushnumber( L, msg_size );
			LS_CHKRET(1);
		} else if( type == 4 ) {
			// reverse
		} else if( type==5) {
			// ���Ͱ�����Ϣ
			if( lua_isstring( L, 1) ) {
				CRegion* except_region = 0;
				if( lua_isnumber(L, 4) )
					except_region = GetRegionById( static_cast<DWORD>(lua_tointeger(L, 4)) );
				CFactionManager::SendFactionAndRegion( (DWORD)lua_tonumber(L,1), &msg, msg_size, except_region);
				lua_pushnumber( L, msg_size );
				LS_CHKRET(1);
			}
		}else if( type==6) {
			// �Զ���Ϊ���Ľ�������㲥
			CActiveObject *obj = NULL;
			GET_OBJ( L , 3 );
			if( obj->m_ParentArea ) {
				obj->m_ParentArea->SendAdj( &msg, msg_size, -1 );
				lua_pushnumber( L, msg_size );
				LS_CHKRET(1);
			}
		}else if( type == 7) {
			TeamManager::SendTeamMsg( sid , &msg , msg_size );
			lua_pushnumber( L, msg_size );
			LS_CHKRET(1);
		}

		LS_RET(-2);
	}
	// ���°������ check
	static int L_CI_SetFactionInfo( lua_State *L )
	{
		LS_CHKTOP(3);

		SFactionData::SFaction *faction = NULL;
		if ( lua_type( L, 1 ) == LUA_TNUMBER )
		{
			DWORD dwFactionId = ( DWORD )lua_tonumber( L, 1 );
			if ( dwFactionId != 0 && dwFactionId < 0xffffff00 )
				faction = GetFactionHeaderInfo( dwFactionId );
		}
		else
		{
			if ( g_Script.m_pPlayer && g_Script.m_pPlayer->m_Property.dwFactionId )
				faction = GetFactionHeaderInfo( g_Script.m_pPlayer->m_Property.dwFactionId );
		}

		if ( faction == NULL )
			LS_CHKRET(0);

		int type = (int)lua_tonumber(L ,2);
		int ret = 0;
		switch( type )
		{
		case 1:
			{
				//����
				LPCSTR szName = ( LPCSTR )lua_tostring( L, 3 );
				//�ж�������
				extern std::map< std::string , DWORD > factionIdMap;
				if ( factionIdMap.find( szName ) != factionIdMap.end() )
					ret = -1;
				else if( strlen(szName) < MAX_TONGNAMESIZE ) {
					strcpy_s( faction->szFactionName , szName );
					factionIdMap[faction->szFactionName] = faction->dwFactionId;
					ret = 1;
				}
			}
			break;
		case 2:
			faction->byFactionLevel = (BYTE)lua_tonumber( L ,3 );
			//���ȼ���������������ˢ�±�ʶ
			if( GetGW() ) GetGW()->m_FactionManager.UpdateList();
			ret = 1;
			break;
		case 3:
			faction->dwMoney = (DWORD)lua_tonumber( L ,3 );
			ret = 1;
			break;
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
		case 9:
			faction->buildingLevel[type-4] = (BYTE)lua_tonumber( L ,3 );
			ret = 1;
			break;
		case 10:
			faction->bySizeLevel  = (BYTE)lua_tonumber( L ,3 );
			if( faction->bySizeLevel > 10 ) faction->bySizeLevel = 10;
			//����᷿�ȼ���������������ˢ�±�ʶ
			if( GetGW() ) GetGW()->m_FactionManager.UpdateList( );
			ret = 1;
			break;
		case 11:
			faction->dwFriendFactionID = (DWORD)lua_tonumber( L ,3 );
			ret = 1;
			break;
		}

		lua_pushnumber( L , ret );
		LS_CHKRET(1);
	}

	// ��ȡ�ű���Ҫ�İ������ check
	static int L_CI_GetFactionInfo( lua_State *L )
	{
		LS_CHKTOP(2);

		SFactionData::SFaction *faction = NULL;

        if ( lua_type( L, 1 ) == LUA_TNUMBER )
        {
		    DWORD dwFactionId = ( DWORD )lua_tonumber( L, 1 );
		    if ( dwFactionId != 0 && dwFactionId < 0xffffff00 )
		        faction = GetFactionHeaderInfo( dwFactionId );
        }
        else
        {
	        if ( g_Script.m_pPlayer && g_Script.m_pPlayer->m_Property.dwFactionId)
		        faction = GetFactionHeaderInfo( g_Script.m_pPlayer->m_Property.dwFactionId );
        }

        if ( faction == NULL )
            LS_CHKRET(0);

		int type = (int)lua_tonumber(L ,2);
		int ret = 0;
		switch( type )
		{
		case 1:
			lua_pushstring( L, faction->szFactionName );
			ret = 1;
			break;
		case 2:
			lua_pushnumber( L, faction->byFactionLevel );
			ret = 1;
			break;
		case 3:
			lua_pushnumber( L, faction->dwMoney );
			ret = 1;
			break;
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
		case 9:
			lua_pushnumber( L, faction->buildingLevel[type-4] );
			ret = 1;
			break;
		case 10:
			lua_pushnumber( L , faction->bySizeLevel );
			ret = 1;
			break;
		case 11:
			lua_pushnumber( L , faction->byMemberNum );
			ret = 1;
			break;
		}

		LS_CHKRET(ret);
	}

	//���� check
	static int L_CI_CreateFaction(lua_State *L)
	{
		LS_CHKTOP(2);

		const char *szFactionName = static_cast<const char*>(lua_tostring(L, 1));
		DWORD dwFactionId = static_cast< DWORD >( lua_tonumber( L, 2 ) );

		int ret = 1;

		if( CHKSTK(8) ){
			// �������ֻȡ��ǰ���
			if (g_Script.m_pPlayer == NULL)
				LS_CHKRET(0);

			ret = GetGW()->m_FactionManager.CreateFaction( szFactionName, g_Script.m_pPlayer, dwFactionId );
		}else{
			SFactionData::SMember temp;
			ZeroMemory( &temp, sizeof( temp ) );
			temp.Level			= (BYTE)lua_tonumber(L,3);
			temp.School			= (BYTE)lua_tonumber(L,4);
			temp.head			= (BYTE)lua_tonumber(L,5);
			temp.Sex			= (BYTE)lua_tonumber(L,6);
			temp.extend			= (BYTE)lua_tonumber(L,7);

			//check
			if( !lua_isstring( L ,8 ) )
				LS_RET(1);
			strcpy_s( temp.szName, lua_tostring(L,8) );

			ret = GetGW()->m_FactionManager.CreateFaction( szFactionName, NULL, dwFactionId , &temp );
		}

		lua_pushnumber(L, ret);
		LS_CHKRET(1);
	}
	//��ɢ��� check
	static int L_CI_DeleteFaction( lua_State *L )
	{
		LS_CHKTOP(1);

		DWORD factionID = (DWORD)lua_tonumber( L, 1 );
		DWORD bGM		= (DWORD)lua_tonumber( L, 2 );

		if ( bGM != 12345 && g_Script.m_pPlayer == NULL)
			LS_CHKRET(0);

		int ret = GetGW()->m_FactionManager.DeleteFaction( factionID , g_Script.m_pPlayer );
		LS_RET(ret);
	}
	//������
	static int L_CI_JoinFaction( lua_State *L )
	{
		LS_CHKTOP(2);

		DWORD factionID = (DWORD)lua_tonumber(L,1);
		DWORD playerSID = (DWORD)lua_tonumber(L,2);

		BOOL ret = FALSE;

		if( CHKSTK(8) ){

			CPlayer *p = ( CPlayer *)GetPlayerBySID( playerSID )->DynamicCast(IID_PLAYER);
			if( !p ) LS_RET(1);

			ret = GetGW()->m_FactionManager.AddMember( factionID , p );

		}else{

			SFactionData::SMember temp;
			temp.dwPlayerSid	= playerSID;
			temp.Level			= (BYTE)lua_tonumber(L,3);
			temp.School			= (BYTE)lua_tonumber(L,4);
			temp.head			= (BYTE)lua_tonumber(L,5);
			temp.Sex			= (BYTE)lua_tonumber(L,6);
			temp.extend			= (BYTE)lua_tonumber(L,7);

			//check
			if( !lua_isstring( L ,8 ) )
				LS_RET(1);
			strcpy_s( temp.szName, lua_tostring(L,8) );

			ret = GetGW()->m_FactionManager.AddMember( factionID , NULL , &temp );
		}

		if ( !ret )
			lua_pushnumber(L, 2);
		else
			lua_pushnumber(L, 0);
		LS_CHKRET(1);
	}
	//�뿪��� check
	static int L_CI_LeaveFaction( lua_State *L )
	{
		LS_CHKTOP(2);

		DWORD factionID = (DWORD)lua_tonumber(L,1);
		DWORD playerSID = (DWORD)lua_tonumber(L,2);
		BYTE  bSelf		= (BYTE )lua_tonumber(L,3);

		if ( !GetGW()->m_FactionManager.DelMember( factionID, playerSID, bSelf ) )
			lua_pushnumber(L, 1);
		else
			lua_pushnumber(L, 0);
		LS_CHKRET(1);
	}

	// ��ȡ��������Ϣ check
	static int L_CI_GetFactionLeaderInfo( lua_State *L )
	{
		LS_CHKTOP(2);

		DWORD factionID = ( DWORD )lua_tonumber( L, 1 );
		if ( factionID == 0 )
			LS_CHKRET(0);

		static SFactionData data;
		memset( &data, 0, sizeof( data ) );
		if ( !GetFactionInfo( factionID, data ) )
			LS_CHKRET(0);

		int type = ( int )lua_tonumber( L, 2 );
		switch( type )
		{
		// ����sid�����һ������ʱ��
		case 0:
			lua_pushnumber( L,data.stMember[0].dwPlayerSid );
			lua_pushnumber( L,data.stMember[0].dwLoginOutTime );
			LS_CHKRET(2);
			break;
		// ����sid��
		case 1:
			lua_pushnumber( L,data.stMember[0].dwPlayerSid );
			for ( int i = 0; i < data.stFaction.byMemberNum && i < MAX_MEMBER_NUMBER; i++ )
			if ( data.stMember[i].Title == FACTION_TITLE_MAX-1 ){
				lua_pushnumber( L,data.stMember[i].dwPlayerSid );
				LS_CHKRET(2);
			}
			LS_CHKRET(1);
			break;
		case 2:
			{
				DWORD sid = 0;
				DWORD _mp = 0 , _ml = 0;

				for ( int i = 0; i < data.stFaction.byMemberNum && i < MAX_MEMBER_NUMBER ; i++ )
				if( CPlayer *p = ( CPlayer* )GetPlayerBySID( data.stMember[i].dwPlayerSid )->DynamicCast( IID_PLAYER ) ){
					if( p->m_Property.dwPointMax > _mp ){
						// ����ѡ���ۼƳ�ֵ��ߵ����
						_mp = p->m_Property.dwPointMax;
						sid = p->GetSID();
					}else if( _mp == 0 && p->GetLevel() > _ml ){
						// û�л�ȡ����ֵ���ʱ��¼�ȼ���ߵ����
						_ml = p->GetLevel();
						sid = p->GetSID();
					}
				}
				lua_pushnumber( L,sid );
				LS_CHKRET(1);
			}
			break;
		// ������ɫ�����Ա�ְҵ
		case 3:
			{
				lua_pushstring( L,data.stMember[0].szName );
				lua_pushnumber( L,data.stMember[0].Sex );
				lua_pushnumber( L,data.stMember[0].School );
				LS_CHKRET(3);
			}
			break;
		}

		LS_CHKRET(0);
	}

	//�������� check
	static int L_ReplaceFactionLeader( lua_State* L )
	{
		LS_CHKTOP(0);
		if( !g_Script.m_pPlayer ) LS_CHKRET(0);
		if( SetAccess(g_Script.m_pPlayer , g_Script.m_pPlayer->GetSID() , FACTION_TITLE_MAX ) ) {
			lua_pushnumber(L,1);
			LS_CHKRET(1);
		}
		LS_CHKRET(0);
	}

	static int L_CI_ClearFriendFaction( lua_State* L )
	{
		LS_CHKTOP(0);
		GetGW()->m_FactionManager.ClearFriendFaction();
		LS_CHKRET(0);
	}

	// ��ȡ��ҵİ�����ݣ�ֻ���ͶԽű����õġ�0 �ƺ� 1 ���һ���˰�ʱ�� check
	static int L_CI_GetMemberInfo( lua_State *L )
	{
		LS_CHKTOP(1);

		CPlayer *obj = NULL;
		GET_PLAYER( L ,1 );

		int type = (int)lua_tonumber( L , 1 );
		int ret = 0;
		switch( type )
		{
		case 1:
			lua_pushnumber( L , obj->m_stFacRight.Title );
			ret = 1;
			break;
		//case 2:
		//	lua_pushnumber( L , obj->m_Property.dwLastLeaveFactionTime );
		//	ret = 1;
		//	break;
		}
		LS_CHKRET(ret);
	}

	//���ð���Ա����[Ŀǰֻ���ܰﹱ/�ܰﹱ] check
	static int L_CI_SetMemberInfo( lua_State *L )
	{
		LS_CHKTOP(2);

		CPlayer *obj = NULL;
		GET_PLAYER( L ,2 );

		int val  = (int)lua_tonumber(L, 1);
		int type = (int)lua_tonumber(L, 2);
		int ret  = 0;
		switch( type )
		{
		case 1://���Ӱﹱ
			obj->m_stFacRight.dwFValAll		+= val;
			obj->m_stFacRight.dwFValWeek	+= val;
			ret = 1;
			break;
		case 2://�����ܰﹱ
			obj->m_stFacRight.dwFValWeek = val;
			ret = 1;
			break;
		}
		if( ret ) obj->m_bFactionDataChange = true;
		lua_pushnumber( L , ret );
		LS_CHKRET(1);
	}
	// check
	static int L_GetGroupID( lua_State *L )
	{
		LS_CHKTOP(0);
		extern DWORD GetGroupID();
		lua_pushnumber( L, GetGroupID() );
		LS_CHKRET(1);
	}
    // check
	static int L_CI_SetEnvironment ( lua_State* L)
	{
		LS_CHKTOP(2);

		BYTE index = ( BYTE ) lua_tonumber( L, 1 ); //���õ����� 1����־���ֵ���� 2�������Ǯ������ 3��������Ʒ���ʱ���
												  // 4���౶ʱ��	5:��������
		if ( index == NULL )
			LS_CHKRET(0);

		float scale = ( float )lua_tonumber( L, 2 ); // ���õ�ֵ
		if ( scale == NULL )
			LS_CHKRET(0);

		switch ( index )
		{
		case 1:
			if( CHKSTK(3) ) LS_RET(-1);
			extern float	fExpScale;
			extern int		iexpType;
			fExpScale = scale;
			if( fExpScale < 0 || fExpScale > 100 )
				LS_RET(-2);
			iexpType = (int)lua_tonumber(L,3);
			break;
		case 2:
			extern float	fDropMoneyScale;
			fDropMoneyScale = scale;
			break;
		case 3:
			extern float	fDropItemScale;
			fDropItemScale = scale;
			break;
		case 4:
			extern int dwMultiTime;
			dwMultiTime = (BYTE)scale;
			break;
		case 5:
			extern std::map<WORD,WORD> g_dropCtrlTable;
			extern std::map< WORD,std::map<DWORD,WORD> > g_dropPlayerCtrlTable;
			g_dropCtrlTable.clear();
			g_dropPlayerCtrlTable.clear();
			break;
		}
		LS_CHKRET(0);
	}
	// check
	static int L_GetServerName( lua_State *L )
	{
		LS_CHKTOP(0);
		extern std::string sidname;
		lua_pushstring( L, sidname.c_str() );
		LS_CHKRET(1);
	}
	// check
	static int L_GetServerID(lua_State *L)
	{
		LS_CHKTOP(0);
		WORD wID = GetServerID();
		lua_pushnumber(L, wID);
		LS_CHKRET(1);
	}

	static int L_CI_EnterSpanServer( lua_State *L )
	{
		LS_CHKTOP(7);

		CPlayer *obj = NULL;
		GET_PLAYER( L ,7 );

		if( obj->GetAccount() == NULL || obj->GetName() == NULL )
			LS_CHKRET(0);

		// spanid
		WORD	spanid		= (WORD)lua_tonumber( L, 1 );
		LPCSTR	serverip	= lua_tostring( L, 2 );
		LPCSTR	serverport	= lua_tostring( L, 3 );
		LPCSTR	password	= lua_tostring( L, 4 );
		LPCSTR	sourceip	= lua_tostring( L, 5 );
		LPCSTR	sourceport	= lua_tostring( L, 6 );
		DWORD	sourceEntry	= lua_tonumber( L, 7 );

		if ( password == NULL || serverip == NULL || serverport == NULL )
			LS_CHKRET(0);

		extern BYTE tempTransBuff[0xffff];
		extern DWORD GetGroupID();

		if ( sourceip == NULL || sourceport == NULL )
			LS_CHKRET(0);

#ifdef _DEBUG
#pragma push_macro("new")
#undef new
#endif
		SQGameServerRPCOPMsg &msg = * new ( tempTransBuff ) SQGameServerRPCOPMsg;
#ifdef _DEBUG
#pragma pop_macro("new")
#endif
		msg.dstDatabase = SQGameServerRPCOPMsg::SPAN_DATABASE;

		// ȡ����������
		obj->UpdateProperty( false );
		// ��������buff����
		obj->SetBuffSaveData();

		static SFixProperty data;
		memset( &data, 0, sizeof( data ) );
		static_cast< SFixProperty& >( data ) = static_cast< SFixProperty& >( obj->m_Property );

		static char			m_buffer[0x10000];
		LPVOID pakBuf		= m_buffer;
		size_t dataSize		= sizeof( m_buffer);
		if ( !TryEncoding( &data, sizeof( SFixProperty ), pakBuf, dataSize ) )
			LS_RET(1);

		try
		{
			lite::Serializer sl( msg.streamData, dataSize + sizeof( SQGameServerRPCOPMsg ) );

			// ע������쳣ʱ���ص����ݣ�����
			sl [OP_BEGIN_ERRHANDLE] ( 0 ) ( "p_SaveToSpanServer" ) [OP_END_ERRHANDLE]

			// ׼���洢����
			[OP_PREPARE_STOREDPROC] ( "p_SaveToSpanServer" )

			// �趨���ò���
			[OP_BEGIN_PARAMS]
			(1) ( obj->GetAccount() )
			(2) ( password )
			(3) ( sourceip )
			(4) ( sourceport )
			(5) ( sourceEntry )
			(6) ( GetGroupID())
			(7) ( obj->GetName()  )
			(8) ( obj->GetSID()  )
			(9) ( pakBuf, dataSize )
			(10) ( obj->m_Property.m_dwGMLevel )
			(11)( ( BYTE )obj->GetPlayerIcon( 0 , 5 ) )
			[OP_END_PARAMS]

			// ���ô洢����
			[OP_CALL_STOREDPROC]

			// ��ʼ���������ݺ�
			[OP_INIT_RETBOX] ( 1024 )
			[OP_BOX_VARIANT] ( ( int )SMessage::EPRO_SCRIPT_MESSAGE )
			[OP_BOX_VARIANT] ( ( int )SScriptBaseMsg::EPRO_SPAN_BACK )
			[OP_BOX_VARIANT] ( serverip )
			[OP_BOX_VARIANT] ( serverport )
			[OP_BOX_VARIANT] ( spanid )
			[OP_BOX_VARIANT] ( obj->m_ClientIndex )
			[OP_BOX_PARAM] ( 1 )
			[OP_BOX_PARAM] ( 2 )
			[OP_BOX_VARIANT] ( obj->GetGID() )
			[OP_BOX_VARIANT] ( obj->m_Property.m_dwGMLevel )
			[OP_BOX_PARAM] ( 12 )

			// �������ݺ�
			[OP_RETURN_BOX]

			[OP_RPC_END];

		    sl.EndEdition();
		    SendToLoginServer( &msg, sizeof( SQGameServerRPCOPMsg ) - sizeof( msg.streamData ) + sl.curSize() );
		}
		catch ( lite::Xcpt &e )
		{
			extern std::string szDirname;
			static std::string logname = szDirname + "rpcerr.log";
			TraceInfo( logname.c_str(), "[%s]p_SaveToSpanServer Error��[%s][%s]", GetStringTime(),obj->GetName() , e.GetErrInfo() );
		}

		LS_CHKRET(0);
	}

//	static int L_CI_GetMonsterHitList( lua_State *L )
//	{
//		LS_CHKTOP(1);
//
//		int number = ( int )lua_tonumber( L, 1 );
//
//		if( number <= 0 )
//			LS_RET(-1);
//
//		CMonster *obj = NULL;
//		GET_MONSTER( L , 1 );
//
//		if( !( obj->GetBossType() & BOSS_HIT_RS ) )
//			LS_RET(-3);
//
//		number = number > obj->m_HitMap.size() ? obj->m_HitMap.size() : number;
//		if( number <= 0 )
//			LS_RET(-2);
//
//		std::vector<PAIR> temp_v(obj->m_HitMap.begin() , obj->m_HitMap.end());
//		sort(temp_v.begin(),temp_v.end(),cmp_by_value);
//
//		int stackPos = lua_gettop( L );
//		if( stackPos < 1 ) LS_CHKRET(0);
//
//		lua_createtable( L, number, 0 );
//		if ( !lua_istable( L, -1 ) )
//			goto _failure;
//
//
//		int cur = 1;
//		std::vector<PAIR> ::iterator it = temp_v.begin();
//		while (it != temp_v.end())
//		{
//			if( cur > number )
//				break;
//
//			// ���������Ч������Թ�
//			if( it->second.pPlayer == NULL )
//				continue;
//
//			lua_createtable( L, 2, 0 );
//			if ( !lua_istable( L, -1 ) )
//				goto _failure;
//
//			lua_pushnumber( L, it->first );
//			lua_rawseti( L, -2, 1 );
//
//			lua_pushnumber( L, it->second.dwDamage );
//			lua_rawseti( L, -2, 2 );
//
//			lua_rawseti( L, -2, cur ++ );
//
//			it++;
//		}
//
//		if( stackPos + 1 != lua_gettop( L ) ){
//			TraceInfo_C("LuaStackError.txt", "[L_CI_GetMonsterHitList]: stack error!");
//		}
//		LS_CHKRET(1);
//
//_failure:
//		if ( stackPos < lua_gettop( L ) )
//			lua_settop( L, stackPos );
//		LS_CHKRET(0);
//
//	}

	static int L_CI_GetPKList( lua_State *L )
	{
		LS_CHKTOP(2);

		int number = ( int )lua_tonumber( L, 1 );
		int second = ( int )lua_tonumber( L, 2 );

		if( number <= 0 || second <= 0 || second > MAX_PKTIME )
			LS_RET(-1);

		CPlayer *obj = NULL;
		GET_PLAYER( L , 2 );

		number = number > obj->m_PkMap.size() ? obj->m_PkMap.size() : number;
		if( number <= 0 )
			LS_RET(-2);

		int stackPos = lua_gettop( L );
		if( stackPos < 2 ) LS_CHKRET(0);

		lua_createtable( L, number, 0 );
		if ( !lua_istable( L, -1 ) )
			goto _failure;


		int cur = 1;
		map<DWORD, DWORD>::iterator it = obj->m_PkMap.begin();
		while (it != obj->m_PkMap.end())
		{
			if( cur > number )
				break;

			if ( MAX_PKTIME - it->second <= second ){
				lua_pushnumber( L, it->first );
				lua_rawseti( L, -2, cur ++ );
			}

			it++;
		}

		if( stackPos + 1 != lua_gettop( L ) ){
			TraceInfo_C("LuaStackError.txt", "[L_CI_GetPKList]: stack error!");
		}
		LS_CHKRET(1);

_failure:
		if ( stackPos < lua_gettop( L ) )
			lua_settop( L, stackPos );
		LS_CHKRET(0);

	}
	// check
	static int L_CI_AreaAddExp( lua_State *L )
	{
		LS_CHKTOP(6);

		DWORD	targetSID	= ( DWORD	)lua_tonumber( L, 1 );
		int		range		= ( int		)lua_tonumber( L, 2 );
		BYTE	selectType	= ( BYTE	)lua_tonumber( L, 3 );
		DWORD	selectID	= ( DWORD	)lua_tonumber( L, 4 );

		CActiveObject* obj = NULL;
		if( range > 0 ){
			GET_OBJ(L,6);
		}

		if( range > 0 && obj == NULL )
			LS_RET(-1);

		int  exp	= ( int  )lua_tonumber( L, 5 );
		if( exp <= 0 ) LS_RET(-5);

		LPCSTR info	= ( LPCSTR )lua_tostring( L, 6 );
		if( !info ) info = GetNpcScriptInfo("L_CI_AreaAddExp");

		check_list< LPIObject > *templist = NULL;
		if( range == 0 ){
			CRegion *destRegion = GetRegionById( targetSID );
			if ( destRegion == NULL )
				LS_RET(-2);
			templist = &destRegion->m_PlayerList;
		}else{
			if( range <= 0 ||  obj == NULL || obj->m_ParentArea == NULL )
				LS_RET(-3);
			templist = &obj->m_ParentArea->m_PlayerList;
		}
		if( !templist || templist->size() == 0 )
			LS_RET(-4);

		check_list<LPIObject>::iterator iter = templist->begin();
		while (iter != templist->end())
		{
			CPlayer *pPlayer = (CPlayer *)(*iter)->DynamicCast(IID_PLAYER);
			if ( pPlayer && pPlayer->GetSID() != targetSID )
			{
				if ( range == 0 ){
					pPlayer->SendAddPlayerExp( exp, 0, false, 0,info);
				}
				else if ( range > 0 ){
					// �ж�ɸѡ����
					if ( selectType == 1 && selectID != pPlayer->GetFactionID() ||
						 selectType == 2 && selectID!= pPlayer->m_dwTeamID ){
							iter++;
							continue;
						}
					if( abs(obj->m_wCurX - pPlayer->m_wCurX) > range ||
						abs(obj->m_wCurY - pPlayer->m_wCurY) > range ){
							iter++;
							continue;
						}
					pPlayer->SendAddPlayerExp( exp, 0, false, 0,info);
				}
			}
			iter++;
		}

		LS_RET(0);
	}
	// check
	static int L_SetSpouse(lua_State *L)
	{
		LS_CHKTOP(2);

		CPlayer *pPlayer = NULL;
		DWORD sid = 0;
		if( lua_isnumber( L, 1) )
			sid = static_cast<DWORD>( lua_tonumber(L, 1));
		extern LPIObject GetPlayerBySID(DWORD);
		if( sid ) pPlayer = (CPlayer *)GetPlayerBySID(sid)->DynamicCast(IID_PLAYER);
		else pPlayer = g_Script.m_pPlayer;
		if( !pPlayer ) LS_CHKRET(0);

		LPCSTR lpszName = static_cast<const char*>(lua_tostring(L, 2));

		if(lpszName != NULL)
		{
			//check
			strcpy_s(pPlayer->m_Property.m_szMateName, lpszName);
			pPlayer->SendMyState();
		}

		LS_CHKRET(0);
	}
	// check
	static int L_DelSpouse(lua_State *L)
	{
		LS_CHKTOP(1);

		CPlayer *pPlayer = NULL;
		DWORD sid = 0;
		if( lua_isnumber( L, 1) )
			sid = static_cast<DWORD>( lua_tonumber(L, 1));
		extern LPIObject GetPlayerBySID(DWORD);
		if( sid ) pPlayer = (CPlayer *)GetPlayerBySID(sid)->DynamicCast(IID_PLAYER);
		else pPlayer = g_Script.m_pPlayer;
		if( !pPlayer ) LS_CHKRET(0);

		ZeroMemory(pPlayer->m_Property.m_szMateName, MAX_ROLENAMESIZE);
		pPlayer->SendMyState();

		LS_CHKRET(0);
	}
	// check
	static int L_CI_SetRelation(lua_State *L)
	{
		LS_CHKTOP(2);

		CPlayer *obj = NULL;
		GET_PLAYER( L , 2 );

		DWORD targetSID		= (DWORD)lua_tonumber(L, 1);
		BYTE  byRelation	= (BYTE)lua_tonumber(L, 2);
		if( obj->SetFriendRelation( targetSID ,byRelation ) ){
			lua_pushboolean( L ,true );
			LS_CHKRET(1);
		}
		LS_CHKRET(0);
	}
	// check
	static int L_CI_GetRelation(lua_State *L)
	{
		LS_CHKTOP(1);

		CPlayer *obj = NULL;
		GET_PLAYER( L , 1 );

		DWORD targetSID		= (DWORD)lua_tonumber(L, 1);
		lua_pushnumber( L ,obj->GetFriendRelation( targetSID ) );
		LS_CHKRET(1);
	}
	// check
	static int L_GetFriendDegree(lua_State *L)
	{
		LS_CHKTOP(1);

		CPlayer *pPlayer = NULL;
		DWORD sid = 0;
		if( lua_isnumber( L, 2) )
			sid = static_cast<DWORD>( lua_tonumber(L, 2));
		extern LPIObject GetPlayerBySID(DWORD);
		if( sid ) pPlayer = (CPlayer *)GetPlayerBySID(sid)->DynamicCast(IID_PLAYER);
		else pPlayer = g_Script.m_pPlayer;
		if( !pPlayer ) LS_CHKRET(0);

		int Ret = -1;
		DWORD targetSID = (DWORD)lua_tonumber(L, 1);
		if(targetSID)
			Ret = pPlayer->GetFriendDegree(targetSID);

		lua_pushnumber(L, Ret);
		LS_CHKRET(1);
	}
	// check
	static int L_AddDearDegree( lua_State *L )
	{
		LS_CHKTOP(3);

		CPlayer *pPlayer = NULL;
		DWORD sid = 0;
		if( lua_isnumber( L, 1) )
			sid = static_cast<DWORD>( lua_tonumber(L, 1));
		extern LPIObject GetPlayerBySID(DWORD);
		if( sid ) pPlayer = (CPlayer *)GetPlayerBySID(sid)->DynamicCast(IID_PLAYER);
		else pPlayer = g_Script.m_pPlayer;
		if( !pPlayer ) LS_CHKRET(0);
		DWORD targetSID = ( DWORD )lua_tonumber( L,2 );
		DWORD val = ( DWORD )lua_tonumber( L,3 );
		//if( val>100 ) LS_CHKRET(0);
		if( pPlayer->AddFriendsDegree(pPlayer->m_ClientIndex,targetSID,val) ){
			lua_pushboolean( L, true );
			LS_CHKRET(1);
		}
		LS_CHKRET(0);
	}
	// �ű����һ����ע��� check
	static int L_CI_AddEnemy(lua_State *L)
	{
		LS_CHKTOP(1);

		CPlayer *obj = g_Script.m_pPlayer;
		if( !obj ) LS_CHKRET(0);

		DWORD targetSID		= (DWORD)lua_tonumber(L, 1);
		if( CPlayer *pDest = (CPlayer *)GetPlayerBySID(targetSID)->DynamicCast(IID_PLAYER) ){
			if ( obj->AddRelation( pDest , 2 ) )
				lua_pushnumber( L , 0 );
			else
				lua_pushnumber( L , 1 );
			LS_CHKRET(1);
		}else{
			LS_CHKSTK(5);

			BYTE	s_h		= (BYTE)lua_tonumber( L , 2 );
			LPCSTR	name	= (LPCSTR)lua_tostring( L , 3 );
			BYTE	school  = (BYTE)lua_tonumber( L , 4 );
			WORD	level	= (WORD)lua_tonumber( L , 5 );

			int ret = obj->AddRelationfromTG( targetSID , s_h/100 , s_h%100 , name , school , level );
			lua_pushnumber( L , ret );
			LS_CHKRET(1);
		}
		LS_CHKRET(0);
	}

	// ��ҵ�һ�ν�����Ϸʱ�����⴦�� check
	static int L_CI_RoleCreateInit( lua_State *L )
	{
		LS_CHKTOP(2);

		CPlayer *p = g_Script.m_pPlayer;
		if( !p ) LS_CHKRET(0);

		DWORD type	= ( DWORD )lua_tonumber( L,1 );
		DWORD arg	= ( DWORD )lua_tonumber( L,2 );

		if( type == 1 ){
			// ҪĬ�ϸ�����
			// arg Ϊ������������
			const SItemData *itemData = CItem::GetItemData( arg );
			if ( itemData == NULL || itemData->byType != ITEM_T_EQUIPMENT_BEGIN )
				LS_RET(-1);

			SEquipment &equip = p->m_Property.m_Equip[0];
			if( equip.wIndex == 0 ){
				// �������������������������
				if ( GenerateNewItem( (SRawItemBuffer &)equip , GenItemParams( arg ) , true ) )
					LS_RET(0);
			}
		}

		LS_CHKRET(0);
	}
	// check
	static int L_TRACE_BEGIN( lua_State *L )
	{
		LS_CHKTOP(0);
		FMTRACE_BEGIN(15);
		LS_CHKRET(0);
	}
	// check
	static int L_TRACE_END( lua_State *L )
	{
		LS_CHKTOP(0);
		int tick = FMTRACE_END(15);
		lua_pushnumber(L,tick);
		LS_CHKRET(1);
	}

	/*
	1 ��λ����[�б�����/�ȼ�/VIP/���ͣ��·�/�Ա�ְҵ��/���� ] 		[ͷ��/��������/����] [�����Ϣ]
	2 ͵Ϯ��  [�б�����/�ȼ�/VIP/���ID/ս����] [ͨ����/ɽׯ����]		[ͷ��/��������/����] [�����Ϣ/������Ϣ]
	*/
	// ��ȡ������һ�����Ϣ�������б���ʾ �� check
	static int L_CI_GetPlayerBaseData( lua_State *L )
	{
		LS_CHKTOP(1);

		int stackPos = lua_gettop( L );
		if( stackPos < 1 ) LS_CHKRET(0);

		DWORD sid = (DWORD)lua_tonumber(L, 1);
		CPlayer *pPlayer = (CPlayer *)GetPlayerBySID(sid)->DynamicCast(IID_PLAYER);
		//���߷��ؿ�
		if( !pPlayer ) LS_CHKRET(0);

		int type = (int)lua_tointeger(L ,2);

		int Elems = 5;
		if( type == 1 ) Elems += 1;
		else if( type == 2 ) Elems += 3;

		lua_createtable( L, Elems, 0 );
		if ( !lua_istable( L, -1 ) )
			goto _failure;

		Elems = 1;
		//����
		lua_pushstring( L, pPlayer->GetName() );
		lua_rawseti( L, -2, Elems ++ );
		//�ȼ�
		lua_pushnumber( L, pPlayer->GetLevel() );
		lua_rawseti( L, -2, Elems ++ );
		//vip�ȼ�
		lua_pushnumber( L, pPlayer->GetPlayerIcon(0,0) );
		lua_rawseti( L, -2, Elems ++ );

		if( type == 0 || type == 2 ){
			//����
			lua_pushnumber( L, pPlayer->GetClothID() );
			lua_rawseti( L, -2, Elems ++ );
			//����
			lua_pushnumber( L, pPlayer->GetWeaponID() );
			lua_rawseti( L, -2, Elems ++ );
		}

		if( type == 1 || type == 2 ){
			//���id
			lua_pushnumber( L, pPlayer->m_Property.dwFactionId );
			lua_rawseti( L, -2, Elems ++ );
			//ս����
			lua_pushnumber( L, pPlayer->m_Property.dwFightVal);
			lua_rawseti( L, -2, Elems ++ );
			//ͷ��
			lua_pushnumber( L, ( pPlayer->m_Property.m_bySex*100 + pPlayer->m_Property.m_byHead ) );
			lua_rawseti( L, -2, Elems ++ );
		}

		if( stackPos + 1 != lua_gettop( L ) ){
			TraceInfo_C("LuaStackError.txt", "[L_CI_GetPlayerBaseData]: stack error!");
		}
		LS_CHKRET(1);

	_failure:
		if ( stackPos < lua_gettop( L ) )
			lua_settop( L, stackPos );
		LS_CHKRET(0);
	}

	// ��ȡ����й����� check
	static int L_CI_GetPlayerTSData( lua_State *L )
	{
		PROFILER;

		LS_CHKTOP(1);

		int stackPos = lua_gettop( L );
		if( stackPos < 1 ) LS_CHKRET(0);

		DWORD sid = (DWORD)lua_tonumber(L, 1);
		CPlayer *pPlayer = (CPlayer *)GetPlayerBySID(sid)->DynamicCast(IID_PLAYER);
		//���߷��ؿ�
		if( !pPlayer ) LS_CHKRET(0);

		lua_createtable( L, 3, 0 );
		if ( !lua_istable( L, -1 ) )
			goto _failure;

		// base_data
		lua_createtable( L, 8, 0 );
		if ( !lua_istable( L, -1 ) )
			goto _failure;
		//����
		lua_pushstring( L, pPlayer->GetName() );
		lua_rawseti( L, -2, 1 );
		//�ȼ�
		lua_pushnumber( L, pPlayer->GetLevel() );
		lua_rawseti( L, -2, 2 );
		//vip�ȼ�
		lua_pushnumber( L, pPlayer->GetPlayerIcon(0,0) );
		lua_rawseti( L, -2, 3 );
		//����
		lua_pushnumber( L, pPlayer->GetClothID() );
		lua_rawseti( L, -2, 4 );
		//����
		lua_pushnumber( L, pPlayer->GetWeaponID() );
		lua_rawseti( L, -2, 5 );
		//���id
		lua_pushnumber( L, pPlayer->m_Property.dwFactionId );
		lua_rawseti( L, -2, 6 );
		//ս����
		lua_pushnumber( L, pPlayer->m_Property.dwFightVal);
		lua_rawseti( L, -2, 7 );
		//ͷ��
		lua_pushnumber( L, ( pPlayer->m_Property.m_bySex*100 + pPlayer->m_Property.m_byHead ) );
		lua_rawseti( L, -2, 8 );
		//end
		lua_rawseti( L, -2, 1 );

		//fight_data check �����ݲ����
		lua_createtable( L, SCommAtt::CAT_MAX, 0 );
		if ( !lua_istable( L, -1 ) )
			goto _failure;
		int i;
		for( i = 0 ; i < SCommAtt::CAT_MAX ; i ++ ){
			lua_pushnumber( L, pPlayer->m_Atts.dwAtts[i] );
			lua_rawseti( L, -2, i+1 );
		}
		//end
		lua_rawseti( L, -2, 2 );

		//skill_data
		lua_createtable( L, 2, 0 );
		if ( !lua_istable( L, -1 ) )
			goto _failure;

		//id
		lua_createtable( L, MAX_SKILL_SET, 0 );
		if ( !lua_istable( L, -1 ) )
			goto _failure;
		for( i = 0 ; i < MAX_SKILL_SET-1 ; i ++ ){
			BYTE idx = pPlayer->m_Property.bySkillIndex[i];
			if( idx == 0 || idx >= MAX_SKILLCOUNT ) continue;

			lua_pushnumber( L, pPlayer->m_Property.m_pSkills[idx].wID );
			lua_rawseti( L, -2, i+1 );
		}
		//ѹ����ͨ����
		lua_pushnumber( L, pPlayer->m_Property.m_pSkills[0].wID );
		lua_rawseti( L, -2, i+1 );

		lua_rawseti( L, -2, 1 );

		//level
		lua_createtable( L, MAX_SKILL_SET, 0 );
		if ( !lua_istable( L, -1 ) )
			goto _failure;
		for( i = 0 ; i < MAX_SKILL_SET-1 ; i ++ ){
			BYTE idx = pPlayer->m_Property.bySkillIndex[i];
			if( idx == 0 || idx >= MAX_SKILLCOUNT ) continue;

			lua_pushnumber( L, pPlayer->m_Property.m_pSkills[idx].wLevel );
			lua_rawseti( L, -2, i+1 );
		}
		//ѹ����ͨ����
		lua_pushnumber( L, pPlayer->m_Property.m_pSkills[0].wLevel );
		lua_rawseti( L, -2, i+1 );

		lua_rawseti( L, -2, 2 );
		//end
		lua_rawseti( L, -2, 3 );

		if( stackPos + 1 != lua_gettop( L ) ){
			TraceInfo_C("LuaStackError.txt", "[L_CI_GetPlayerTSData]: stack error!");
		}
		LS_CHKRET(1);

_failure:
		if ( stackPos < lua_gettop( L ) )
			lua_settop( L, stackPos );
		LS_CHKRET(0);
	}

	static int L_CI_GetTopFactionID( lua_State *L )
	{
		LS_CHKTOP(0);

		if(!GetGW())
			LS_CHKRET(0);

		lua_pushnumber(L,GetGW()->m_FactionManager.GetTopFactionID() );
		LS_CHKRET(1);
	}

	static int L_CI_SendSpanMsg( lua_State *L )
	{
		LS_CHKTOP(3);
		size_t	size = 0;
		DWORD	dwDestID	= ( DWORD )lua_tonumber( L, 1 );
		BYTE	type		= ( BYTE  )lua_tonumber( L, 3 );

		SAGameScriptTransfreMsg msg;
		msg.byType = type;
		msg.dbcId = SQGameServerRPCOPMsg::SPAN_DATABASE;
		msg.destServerId = dwDestID;
		ZeroMemory( msg.streamData, sizeof( msg.streamData ) );

		const int top = lua_gettop( L );
		try
		{
			int rc = luaEx_serialize( L, 2, msg.streamData + 2, sizeof( msg.streamData ) - 2 );
			if ( rc <= 0 || rc > sizeof( msg.streamData ) - 2 ){
				TraceInfo_C("LuaSLError.log", "L_CI_SendSpanMsg [ck=%d]",rc);
				LS_CHKRET(0); // ����ʧ��
			}

			*( LPWORD )msg.streamData = rc;
			size = sizeof( msg.streamData ) - ( rc + 2 );
		}
		catch ( lite::Xcpt & )
		{
			TraceInfo_C("LuaSLError.log", "L_CI_SendSpanMsg [lite error]");
			lua_settop( L, top );
			LS_CHKRET(0);
		}

		if ( lua_gettop( L ) != top )
		{
			TraceInfo_C("LuaStackError.txt","L_CI_SendSpanMsg stack error");
			lua_settop( L, top );
			LS_CHKRET(0);
		}

		// ��;�����쳣, �޷��ټ���!
		if ( size == 0 )
			LS_RET(-1);

		const WORD msg_size = static_cast<WORD>(sizeof( msg ) - size);
		SendToLoginServer( &msg, msg_size );
		LS_RET(0);
	}
// ��̬�������� check
int CScriptManager::L_CreateRegion( lua_State *L )
{
	LS_CHKTOP(1);

	if( !lua_istable( L, 1 ) )
		LS_CHKRET(0);

#define CHECK_AND_SET( _key, _member ) _IF_GET_FIELD_NUMBER( 1, _key ) \
	param._member = static_cast< WORD >( __number ); else LS_CHKRET(0);

	CRegion::SParameter param;
	memset( &param, 0, sizeof( param ) );

	CHECK_AND_SET( "MapID"		, wRegionID			)
	CHECK_AND_SET( "SourceMapID", wSourceMapID			)
	CHECK_AND_SET( "property"	, MapProperty		)
	CHECK_AND_SET( "limit"		, Limit				)
	CHECK_AND_SET( "rid"		, wReLiveRegionID	)
	CHECK_AND_SET( "rx"			, ptReLivePoint.x	)
	CHECK_AND_SET( "ry"			, ptReLivePoint.y	)
	CHECK_AND_SET( "level"		, dwNeedLevel		)
	CHECK_AND_SET( "multi"		, wRegionMultExp	)
	CHECK_AND_SET( "PKType"		, dwPKAvailable		)
	CHECK_AND_SET( "PKMode"		, dwPKMode			)
	CHECK_AND_SET( "PKLvDiff"	, nPKDiffLevel		)

	//�̶�����
	int copySceneGID = lua_isnumber(L,2) ? lua_tonumber( L ,2 ) : 0;
    if( copySceneGID == 0 )
    {
        if ( FindRegionByID( param.wRegionID) )
            LS_RET(0); // Ŀ�곡���Ѿ�����

        LPIObject region = GetApp()->m_pGameWorld->CRegionManager::GenerateObject( IID_REGION, 0, (LPARAM)&param );
		if ( !region ){
            rfalse( 2, 1, "�޷�װ�ؾ�̬���� [%d]", param.wRegionID );
			LS_CHKRET(0);
		}

        CRegion *ptr = ( CRegion* )region->DynamicCast( IID_REGION );
		if ( ptr == NULL ){
            rfalse( 2, 1, "����ľ�̬����ָ�� [%d]", param.wRegionID );
			LS_CHKRET(0);
		}

		// ����Ǿ�̬����,�ͽ����֪ͨ����½������
#ifdef _DEBUG
#pragma push_macro("new")
#undef new
#endif
		char tempBuffer[ 256 ];
		SARefreshRegionServerMsgEx &msg = * new ( tempBuffer ) SARefreshRegionServerMsgEx;	// check

#ifdef _DEBUG
#pragma pop_macro("new")
#endif
		msg.dnidClient = 0xff12ff34ff56ff78;
		lite::Serializer slm( msg.dataStream, sizeof( tempBuffer ) - sizeof( msg ) );
		SRegion r;
		r.ID = param.wRegionID;
		r.MapID = param.wRegionID;
		r.NeedLevel = ptr->m_dwNeedLevel;
		slm( &r, sizeof( r ) );
		SendToLoginServer( &msg, ( int )( sizeof( tempBuffer ) - slm.EndEdition() ) );
		lua_pushnumber( L, ptr->GetGID() );
		LS_CHKRET(1);
    }
	else	//��̬����
	{
		LPIObject region = GetApp()->m_pGameWorld->CRegionManager::GenerateObject( IID_DYNAMICREGION, 0, (LPARAM)&param );
		if ( !region ){
			rfalse( 2, 1, "�޷�װ�ض�̬���� [%d]", param.wRegionID );
			LS_CHKRET(0);
		}

		CDynamicRegion *ptr = (CDynamicRegion *)region->DynamicCast(IID_DYNAMICREGION);
		if ( ptr == NULL ){
			rfalse( 2, 1, "����Ķ�̬����ָ�� [%d]", param.wRegionID );
			LS_CHKRET(0);
		}

		//���Ϊ�����߹�����ɾ��
		int val = lua_isnumber(L,3) ?lua_tonumber(L,3) : 0;
		if( val == 1 )
			ptr->m_bAutoDelete = false;

		if( copySceneGID != -1 )
			ptr->SetCopySceneGID(copySceneGID);
		else if( lua_isstring(L,4)){
			LPCSTR name = lua_tostring( L ,4 );
			if( name ) ptr->SetCopySceneName(name);
		}
		lua_pushnumber( L, ptr->GetGID() );
		LS_CHKRET(1);
	}
#undef CHECK_AND_SET
	LS_CHKRET(0);
}


// �ýӿڽ��޸ĵ��ߵ�ΨһID check
static int L_ModifyItem( lua_State *L )
{
	LS_CHKTOP(2);

	int size = 0;
	void *data = luaEx_touserdata( L, 1, &size );
	LPCSTR option = lua_tostring( L, 2 );
	LPCSTR info = ( LPCSTR ) lua_tostring( L, 3 );
	if( info == NULL ) info = GetNpcScriptInfo("L_ModifyItem");

	if ( size != sizeof( SPackageItem ) )
		LS_CHKRET(0);

	SPackageItem &item = *( SPackageItem* )data;

	BOOL result = FALSE;
	switch ( option[0] )
	{
	case 'X':
	case 'D':
		if ( g_Script.m_pPlayer == NULL )
			LS_CHKRET(0);

		// ɾ��ָ������
		if ( !g_Script.m_pPlayer->CheckItem( item ) )
			LS_CHKRET(0);

		result = g_Script.m_pPlayer->DelItem( item, info, option[0] == 'X',TRUE );
		break;

	case 'A': // ��ָ��������ӵ�������ϣ�����ΨһID��
	case 'R': // ��ָ�����߻ָ���������ϣ�����ΨһID��
		{
			if ( g_Script.m_pPlayer == NULL )
				LS_CHKRET(0);

			if ( option[0] == 'A' )
			{
				// ���Ƹù���ֻ�����GenerateItemDetailsʹ�ã�
				if ( ( item.byCellX != 255 ) || ( item.byCellY != 255 ) )
					LS_CHKRET(0);
			}

			SCellPos pos = { -1, -1 };
			if ( !g_Script.m_pPlayer->CheckAddItem( item.wIndex, pos ) )
			{
				g_Script.m_pPlayer->SendErrorMsg( SABackMsg::B_FULLBAG );
				LS_CHKRET(0);
			}

			if ( option[0] == 'A' )
			{
				// �����µ�ΨһID��
				//if ( !GenerateNewUniqueId( item ) )
				//    return 0;
			}

			result = g_Script.m_pPlayer->AddExistingItem( item, pos, true, info , true );
		}
		break;

	case 'G':
		// ��ָ���������ɵ�������
		{
			// ���Ƹù���ֻ�����GenerateItemDetailsʹ�ã�
			if ( ( item.byCellX != 255 ) || ( item.byCellY != 255 ) )
				LS_CHKRET(0);

			// ��ȡָ������������
			if ( !lua_istable( L, 3 ) )
				LS_CHKRET(0);

			DWORD regionId = static_cast< DWORD >( _GET_FIELD_NUMBER_DIRECTLY( 3, "regionId" ) );
			if ( regionId == 0 ){
				rfalse( 2, 1, "(MI)û��ָ��Ŀ�곡��" );
				LS_CHKRET(0);
			}

			CRegion *destRegion = GetRegionById( regionId );
			if ( destRegion == NULL ){
				rfalse( 2, 1, "(MI)�Ҳ���ָ������" );
				LS_CHKRET(0);
			}

			WORD xTile = static_cast< WORD >( _GET_FIELD_NUMBER_DIRECTLY( 3 , "x" ) );
			WORD yTile = static_cast< WORD >( _GET_FIELD_NUMBER_DIRECTLY( 3 , "y" ) );
			if ( ( xTile == 0 ) || ( yTile == 0 ) ){
				rfalse( 2, 1, "(MI)δ�趨��������" );
				LS_CHKRET(0);
			}

			// �����µ�ΨһID��
			SRawItemBuffer &_item = item;
			//if ( !GenerateNewUniqueId( _item ) )
			//	return 0;

			DWORD dropCount = 0;
			POINT pt = { xTile , yTile };
			result = CItem::DropToGround( _item , 0 , 0 , pt ,NULL ,destRegion , dropCount );
		}
		break;

	case 'J' :
		_asm nop
		break;
	}

	if ( !result )
		LS_CHKRET(0);

	lua_pushnumber( L, 1 );
	LS_CHKRET(1);
}

// ͨ���ýű�����������һ�����ñ��д��ڵ�����Ϊ�������ñ��е����ݣ�check
static int L_GetItemSetting( lua_State *L )
{
	LS_CHKTOP(1);

	DWORD index = ( DWORD )lua_tonumber( L, 1 );
	const SItemData *itemData = CItem::GetItemData( index );
	if ( index == 0 || itemData == NULL )
		LS_CHKRET(0);

	// ���ڱ��ֶ�ջƽ�⣡
	int stackPos = lua_gettop( L );

	lua_createtable( L, 0, 2 );
	if ( !lua_istable( L, -1 ) )
		goto _failure;

	SETTABLE_BY_STRING( "byCanSaleNpc", itemData->byCanSaleNpc );
	SETTABLE_BY_STRING( "dwSell", itemData->dwSell );
	SETTABLE_BY_STRING( "enExp", itemData->wValidTime );
	SETTABLE_BY_STRING( "quality", itemData->byQuality );

	sassert( stackPos + 1 == lua_gettop( L ) );
	LS_CHKRET(1);

_failure:
	sassert( stackPos < lua_gettop( L ) );
	if ( stackPos < lua_gettop( L ) )
		lua_settop( L, stackPos );
	LS_CHKRET(0);
}

// ͨ���ýű�����������һ�����ñ��д��ڵ�����Ϊ���ݵ������ͷֽ�������������ݣ�check
static int L_GetItemDetails( lua_State *L )
{
	LS_CHKTOP(1);

	int size = 0;
	void *data = luaEx_touserdata( L, 1, &size );
	bool doCheck = ( lua_toboolean( L, 2 ) == 0 );
	bool miscOnly = ( lua_toboolean( L, 3 ) == 1 );

	if ( size != sizeof( SPackageItem ) )
		LS_CHKRET(0);

	SPackageItem &item = *( SPackageItem* )data;
	if ( doCheck && ( ( g_Script.m_pPlayer == NULL ) || !g_Script.m_pPlayer->CheckItem( item ) ) )
		LS_CHKRET(0);

	const SItemData *itemData = CItem::GetItemData( item.wIndex );
	if ( itemData == NULL )
		LS_CHKRET(0);

	if ( miscOnly )
	{
		// ֻ���� misc�ײ����ݣ����ڼ�ӹ�����ߵĸ��±�
		// lua_pushnumber( L, reinterpret_cast< double& >( static_cast< SItemBase& >( item ) ) );
		char buf[256];
		sprintf( buf, "%I64X", ( QWORD )( ( reinterpret_cast< QWORD& >( static_cast< SItemBase& >( item ) ) >> 24 ) & 0x000000ffffffffff ) );
		lua_pushstring( L, buf );
		LS_CHKRET(1);
	}

	// ���ڱ��ֶ�ջƽ�⣡
	int stackPos = lua_gettop( L );

	int nElements = 8;
	if ( ITEM_IS_OVERLAP( itemData->byType ) )
		nElements += 1;
	else if ( ITEM_IS_EQUIPMENT( itemData->byType ) )
		nElements += 3;

	lua_createtable( L, 0, nElements );
	if ( !lua_istable( L, -1 ) )
		goto _failure;

	SETTABLE_BY_STRING( "index", ( DWORD )item.wIndex );
	SETTABLE_BY_STRING( "quality", itemData->byQuality );
	SETTABLE_BY_STRING( "type", itemData->byType );
	SETTABLE_BY_STRING( "flags", ( DWORD )item.flags );
	SETTABLE_BY_STRING( "cellX", ( DWORD )item.byCellX );
	SETTABLE_BY_STRING( "cellY", ( DWORD )item.byCellY );
	lua_pushstring( L, "misc" );
	luaEx_pushint63( L, item.uniqueId() );
	lua_settable( L, -3 );

	SETTABLE_BY_STRING( "levelEM", itemData->wLevelEM );

	if ( ITEM_IS_OVERLAP( itemData->byType ) )
	{
		SETTABLE_BY_STRING( "number", reinterpret_cast< SOverlap& >(
			static_cast< SItemBase& >( item ) ).number  );
	}
	else if ( ITEM_IS_EQUIPMENT( itemData->byType ) )
	{
#define ITEM_CONVERT reinterpret_cast< SEquipment& >( static_cast< SItemBase& >( item ) )

		SETTABLE_BY_STRING( "level",     ( ITEM_CONVERT.level ) );
		SETTABLE_BY_STRING( "levelEx",   ( ITEM_CONVERT.levelEx ) );
		lua_pushstring( L, "slots" );
		lua_createtable( L, 5, 0 );
		if ( !lua_istable( L, -1 ) )
			goto _failure;

		for ( int i = 0; i < SEquipment::MAX_SLOTS; ++i )
		{
			lua_pushnumber( L, 400+ITEM_CONVERT.slots[i].type * 10 + ITEM_CONVERT.slots[i].value );
			lua_rawseti( L, -2, i + 1 );
		}

		lua_settable( L, -3 );

		lua_pushstring( L, "properties" );
		lua_createtable( L, 5, 0 );
		if ( !lua_istable( L, -1 ) )
			goto _failure;
		for ( int i = 0; i < SEquipment::MAX_QUALITYS-1; ++i )
		{
			lua_pushnumber( L, ITEM_CONVERT.qualitys[i].type * 10000 +  ITEM_CONVERT.qualitys[i].value );
			lua_rawseti( L, -2, i + 1 );
		}
		lua_settable( L, -3 );

#undef ITEM_CONVERT
	}
	else if ( ITEM_IS_SCRIPT( itemData->byType ) )
	{
		// ����ǽű�����ߣ�����һ��script�����������нű����ݣ�
		lua_pushstring( L, "scripts" );
		lua_createtable( L, 8, 0 );
		if ( !lua_istable( L, -1 ) )
			goto _failure;

		try
		{
			SScriptItem &scriptItem = reinterpret_cast< SScriptItem& >( static_cast< SItemBase& >( item ) );
			if ( scriptItem.declare )
			{
				lite::Serialreader slr( scriptItem.streamData );
				for ( int i = 0; i < 8; i ++ )
				{
					if ( scriptItem.declare & ( 1 << i ) )
					{
						reinterpret_cast< lite::lua_variant& >( slr() ).push( L );
						lua_rawseti( L, -2, i + 1 );
					}
				}
			}
		}
		catch ( lite::Xcpt& )
		{
			goto _failure;
		}

		lua_settable( L, -3 );
	}


	// ��Ȼ��������ô�����ݣ���ֻ������һ������ѣ�
	sassert( stackPos + 1 == lua_gettop( L ) );
	LS_CHKRET(1);

_failure:
	sassert( stackPos < lua_gettop( L ) );
	if ( stackPos < lua_gettop( L ) )
		lua_settop( L, stackPos );
	LS_CHKRET(0);
}


// ͨ���ú��������ݴ�������ñ��޸ģ����£����ߵ����� check
// ����õ�����������ϵĵ��ߣ���ͬ��֪ͨ�ͻ��˸������ݣ�
static int L_UpdateItemDetails( lua_State *L )
{
	LS_CHKTOP(2);

	int size = 0;
	void *data = luaEx_touserdata( L, 1, &size );
	bool doCheck = ( lua_toboolean( L, 3 ) == 0 );
	bool acceptIndexChange = ( lua_toboolean( L, 4 ) == 1 ); // �Ƿ����index�ĸı䣡

	if ( size != sizeof( SPackageItem ) )
		LS_CHKRET(0);

	if ( !lua_istable( L, 2 ) )
		LS_CHKRET(0);

	SPackageItem &item = *( SPackageItem* )data;
	SPackageItem tempItem;
	if ( doCheck )
	{
		if ( ( g_Script.m_pPlayer == NULL ) || !g_Script.m_pPlayer->CheckItem( item ) )
			LS_CHKRET(0);

		tempItem = item;
	}

	const SItemData *itemData = CItem::GetItemData( item.wIndex );
	if ( itemData == NULL )
		LS_CHKRET(0);

	// ��ȡ2������,misc��flags,���misc���޸ĵĻ����Ͳ��ܼ�������ִ���ˣ�
	lua_getfield( L, 2, "misc" );
	QWORD misc = luaEx_toint63( L, -1 );
	lua_pop( L, 1 );

	if ( misc != item.uniqueId() )
		LS_CHKRET(0);

	// �����־λ�趨Ϊ�����Խ��ܵ���index���޸ģ�
	if ( acceptIndexChange )
	{
		// �ڻ�ȡ���߱�ź�Ҫͳһ�жϣ��仯ǰ��ĵ���Ӧ�����������
		_IF_GET_FIELD_NUMBER( 2 , "index" )
		{
			const SItemData *newData = CItem::GetItemData( ( WORD )__number );
			if ( newData == NULL )
				LS_CHKRET(0);

#define COMPARE( _t ) ( _t( newData->byType ) && _t( itemData->byType ) )
#define COMPARE_IDX( _t ) ( _t( newData->wItemID ) && _t( itemData->wItemID ) )
#define MULTI_COMPARE  ( COMPARE( ITEM_IS_EQUIPMENT ) /*|| COMPARE( ISNORMAL ) */|| COMPARE( ITEM_IS_OVERLAP ) /*|| COMPARE( ISSPECIALOVERLAP )*/ || COMPARE_IDX( ITEM_IS_JEWEL ) )

			// ���ж��¾ɵ��ߵ����ͣ������ͬ���Ͳ���Ҫ����ߵ��ж���
			if ( ( itemData->byType != newData->byType ) && !MULTI_COMPARE )
				LS_CHKRET(0);

#undef MULTI_COMPARE
#undef COMPARE

			item.wIndex = ( WORD )__number;
		}
		else
		{
			// ���ָ�����޸�index������û���ҵ�index�����ݣ���ʧ�ܷ��أ�
			LS_CHKRET(0);
		}
	}

	// ���±�־λ��
	_IF_GET_FIELD_NUMBER( 2,"flags" )  item.flags = ( DWORD )__number;

	if ( ITEM_IS_OVERLAP( itemData->byType ) )
	{
#define ITEM_CONVERT reinterpret_cast< SOverlap& >( static_cast< SItemBase& >( item ) )

		// ���Ϊ���ص��࣬��Ҫ����number
		_IF_GET_FIELD_NUMBER( 2,"number" )
		{
			ITEM_CONVERT.number = ( DWORD )__number;

			// �ص���������Ϊ0
			if ( ITEM_CONVERT.number == 0 )
				LS_CHKRET(0);
		}
#undef ITEM_CONVERT
	}
	else if ( ITEM_IS_EQUIPMENT( itemData->byType ) )
	{
#define ITEM_CONVERT reinterpret_cast< SEquipment& >( static_cast< SItemBase& >( item ) )

		lua_getfield( L, 2, "slots" );
		if ( lua_istable( L, -1 ) ) for ( int i = 0; i < SEquipment::MAX_SLOTS; ++i )
		{
			// ���ǰ��Ĳ����Ч�����������ݶ��������ˣ�
			if ( ( i != 0 ) && ITEM_CONVERT.slots[i-1].isInvalid() )
			{
				*( LPBYTE )&ITEM_CONVERT.slots[i] = 0;
				continue;
			}
			ITEM_CONVERT.slots[i].type = ( BYTE )( (( DWORD )_GET_ARRAY_NUMBER_DIRECTLY( -1,i + 1 ) - 400 )/ 10 );
			ITEM_CONVERT.slots[i].value = ( BYTE )( (( DWORD )__number-400 )% 10 );

		}
		lua_pop( L, 1 );

		_IF_GET_FIELD_NUMBER( 2 , "level" )		ITEM_CONVERT.level		= ( BYTE )( __number );
		_IF_GET_FIELD_NUMBER( 2 , "levelEx" )	ITEM_CONVERT.levelEx	= ( BYTE )( __number );

		SEquipment::Unit * att = NULL;

		lua_getfield( L, 2, "properties" );
		if ( lua_istable( L, -1 ) )
		{
			att = ITEM_CONVERT.qualitys;
			for ( int i = 0; i < SEquipment::MAX_QUALITYS - 1; i++ )
				AttUpdate( att[i], ( DWORD )_GET_ARRAY_NUMBER_DIRECTLY( -1 , i + 1 ) );
		}
		lua_pop( L, 1 );

#undef ITEM_CONVERT
	}
	else if ( ITEM_IS_SCRIPT( itemData->byType ) )
	{
		// ����ǽű�����ߣ�����һ��script�����������нű����ݣ�
		lua_getfield( L, 2, "scripts" );
		if ( !lua_istable( L, -1 ) ){   // ���û��script�ӱ������ʧ�ܣ�
			lua_pop( L, 1 );
			LS_CHKRET(0);
		}

		size_t size = 0;
		SScriptItem &scriptItem = reinterpret_cast< SScriptItem& >( static_cast< SItemBase& >( item ) );
		try
		{
			ZeroMemory( item.buffer, sizeof( item.buffer ) );
			lite::Serializer slm( scriptItem.streamData, sizeof( scriptItem.streamData ) );

			// ����8��������ȷ��ÿһ��Ԫ�ص���Ч�� 1 2 4 8 16 32 64 128
			for ( int i = 0; i < 8; i ++ )
			{
				lua_rawgeti( L, -1, i + 1 );
				if ( !lua_isnil( L, -1 ) )  // ��Ч�����ݲű����������
				{
					scriptItem.declare |= ( 1 << i );
					slm( (int)lite::lua_variant( L, -1 ) );
				}
				else
					scriptItem.declare &= ( ~( 1 << i ) );
				lua_pop( L, 1 );
			}

			// ƽ��������־!
			slm.EndEdition();
			size = slm.maxSize();
		}
		catch ( lite::Xcpt & )
		{
			// ������ִ��󣬵�Ȼ�͸���ʧ���ˣ�
			// ��Ҫ�ѳ����쳣ʱ���Ǹ��ű����ݳ�ջ! �Ա���ջƽ��
			lua_pop( L, 1 );
		}

		// ��script��ջ
		lua_pop( L, 1 );

		// ��;�����쳣, �޷��ټ���!
		if ( size == 0 )
			LS_CHKRET(0);

		// ���û���κ�����, ���൱���������
		scriptItem.size = sizeof( SItemBase ) + 1;
		if ( scriptItem.declare != 0 )
			scriptItem.size += ( BYTE )size;
	}

	// ������ϵĵ��ߣ����ҳ��������ݱ仯���Ÿ��µ��ͻ��ˣ�
	if ( doCheck && ( memcmp( &tempItem, &item, sizeof( tempItem ) ) != 0 ) )
	{
		SPackageItem *realItem = g_Script.m_pPlayer->FindItemByPos( item.byCellX, item.byCellY );
		if( realItem )
		{
			if ( memcmp( realItem, &tempItem, sizeof( tempItem ) ) != 0 )
				LS_CHKRET(0);

			g_Script.m_pPlayer->SendItemSynMsg( &( *realItem = item ) , eITEM_SYN_FRESH);

			// ��¼
			if ( itemData && ITEM_IS_EQUIPMENT( itemData->byType ) )
			{
				g_Script.m_pPlayer->SetKeyChange(KLT_ITEM,1,item.wIndex);
			}
		}
	}

	// �ɹ��󷵻�1��
	lua_pushnumber( L, 1 );
	LS_CHKRET(1);
}

static void AttUpdate( SEquipment::Unit &att, DWORD vt )
{
	DWORD type = att.type = vt / 10000;
	att.value = vt % 10000;
}

// ֱ�Ӹ���item���ݴ�����ָ�����͵ĵ��ߣ� check
// ��ֱ������չʾ����Ҫͨ��modifyitem��ӵ�������ϣ�
static int L_GenerateItemDetails( lua_State *L )
{
	LS_CHKTOP(1);

	if ( !lua_istable( L, 1 ) )
		LS_CHKRET(0);

	WORD index = static_cast< WORD >( _GET_FIELD_NUMBER_DIRECTLY( 1 , "index" ) );

	const SItemData *itemData = CItem::GetItemData( index );
	if ( itemData == NULL )
		LS_CHKRET(0);

	SPackageItem itemBuffer;
	memset( &itemBuffer, 0, sizeof( itemBuffer ) );

	if ( !GenerateNewItem( itemBuffer, GenItemParams( index ) ) )
		LS_CHKRET(0);

	SPackageItem &item = itemBuffer;
	item.byCellX = item.byCellY = -1;

	// ���ñ�־λ��
	_IF_GET_FIELD_NUMBER( 1 , "flags" )  item.flags = ( DWORD )__number;
	// �޸ļ���[����ӿ��������������⻯���ߵģ���Ȼ���޸Ĺ��ģ����Ծ�����ӿ����ɵĵ���ǿ�ư�]
	item.flags = 1;

	if ( ITEM_IS_OVERLAP( itemData->byType ) )
	{
		item.size = sizeof( SOverlap );

#define ITEM_CONVERT reinterpret_cast< SOverlap& >( static_cast< SItemBase& >( item ) )

		// ���Ϊ���ص��࣬��Ҫ����number
		_IF_GET_FIELD_NUMBER( 1 , "number" )
		{
			ITEM_CONVERT.number = ( DWORD )__number;

			// �ص���������Ϊ0
			if ( ITEM_CONVERT.number == 0 )
				LS_CHKRET(0);
		}
#undef ITEM_CONVERT
	}
	else if ( ITEM_IS_EQUIPMENT( itemData->byType ) )
	{
		item.size = sizeof( SEquipment );

#define ITEM_CONVERT reinterpret_cast< SEquipment& >( static_cast< SItemBase& >( item ) )

		lua_getfield( L, 1, "slots" );
		if ( lua_istable( L, -1 ) ) for ( int i = 0; i < SEquipment::MAX_SLOTS; ++i )
		{
			// ���ǰ��Ĳ����Ч�����������ݶ��������ˣ�
			if ( ( i != 0 ) && ITEM_CONVERT.slots[i-1].isInvalid() )
			{
				*( LPBYTE )&ITEM_CONVERT.slots[i] = 0;
				continue;
			}

			ITEM_CONVERT.slots[i].type = ( BYTE )(( ( DWORD )_GET_ARRAY_NUMBER_DIRECTLY( -1 , i + 1 ) - 400 )/ 10 );
			ITEM_CONVERT.slots[i].value = ( BYTE )( (( DWORD )__number - 400 )% 10 );

			// ͬ�ϣ����ǰ��Ĳ��Ϊ�գ�����������Ҳ������Ϊ��Ƕ״̬��
			if ( ( i != 0 ) && ITEM_CONVERT.slots[i-1].isEmpty() && ITEM_CONVERT.slots[i].isJewel() )
				*( LPBYTE )&ITEM_CONVERT.slots[i] = 0;
		}
		lua_pop( L, 1 );

		_IF_GET_FIELD_NUMBER( 1 , "level" )		ITEM_CONVERT.level		= ( BYTE )( __number );
		_IF_GET_FIELD_NUMBER( 1 , "levelEx" )	ITEM_CONVERT.levelEx	= ( BYTE )( __number );

		SEquipment::Unit * att = NULL;
		lua_getfield( L, 1, "qualitys" );
		if ( lua_istable( L, -1 ) )
		{
			att = ITEM_CONVERT.qualitys;
			for ( int i = 0; i < SEquipment::MAX_QUALITYS-1; i++ )
				AttUpdate( att[i], ( DWORD )_GET_ARRAY_NUMBER_DIRECTLY( -1 , i + 1 ) );
		}
		lua_pop( L, 1 );

#undef ITEM_CONVERT
	}
	else if ( ITEM_IS_SCRIPT( itemData->byType ) )
	{
		// ����ǽű�����ߣ�����һ��script�����������нű����ݣ�
		lua_getfield( L, 1, "scripts" );
		if ( lua_istable( L, -1 ) )    // ���û��script�ӱ������ʧ�ܣ�
		{
			size_t size = 0;
			SScriptItem &scriptItem = reinterpret_cast< SScriptItem& >( static_cast< SItemBase& >( item ) );
			try
			{
				ZeroMemory( item.buffer, sizeof( item.buffer ) );
				lite::Serializer slm( scriptItem.streamData, sizeof( scriptItem.streamData ) );

				// ����8��������ȷ��ÿһ��Ԫ�ص���Ч�� 1 2 4 8 16 32 64 128
				for ( int i = 0; i < 8; i ++ )
				{
					lua_rawgeti( L, -1, i + 1 );
					if ( !lua_isnil( L, -1 ) )  // ��Ч�����ݲű����������
					{
						scriptItem.declare |= ( 1 << i );
						slm( (int)lite::lua_variant( L, -1 ) );
					}
					lua_pop( L, 1 );
				}

				// ƽ��������־!
				slm.EndEdition();
				size = slm.maxSize();
			}
			catch ( lite::Xcpt & )
			{
			}

			// ��;�����쳣, �޷��ټ���!
			if ( size == 0 )
				LS_CHKRET(0);

			// ���û���κ�����, ���൱���������
			scriptItem.size = sizeof( SItemBase ) + 1;
			if ( scriptItem.declare != 0 )
				scriptItem.size += ( BYTE )size;
		}
		// ��script��ջ
		lua_pop( L, 1 );
	}

	// �ɹ��󷵻�dataHandle��
	void *p = lua_newuserdata( L, sizeof( SPackageItem ) );
	if( !p ) LS_CHKRET(0);
	// nocheck ȡ���ڷ��䲻�����
	memcpy_unsafe( p, sizeof( SPackageItem ), &item, sizeof( SPackageItem ) );
	LS_CHKRET(1);
}
// check
static int L_RemoveObjectIndirect( lua_State *L )
{
	LS_CHKTOP(2);

	DWORD regionId  = static_cast< DWORD >( lua_tonumber( L, 1 ) );
	DWORD controlId = static_cast< DWORD >( lua_tonumber( L, 2 ) );

	CRegion *destRegion = GetRegionById( regionId );
	if ( destRegion == NULL ){
		rfalse( 2, 1, "(ROI)�Ҳ���ָ������" );
		LS_CHKRET(0);
	}

	BOOL result = destRegion->RemoveObjectByControlId( controlId );
	if ( !result )
		LS_CHKRET(0);

	lua_pushnumber( L, 1 );
	LS_CHKRET(1);
}
// check
static int L_CI_SelectObject( lua_State *L )
{
	LS_CHKTOP(0);

	SELECT_OBJECT_EX( L , 0 );

	lua_pushnumber( L, 1 );
	LS_CHKRET(1);
}
// check
static int L_GetObjectUniqueId( lua_State *L )
{
	LS_CHKTOP(0);

	DWORD npcId     = 0;
	DWORD monsterId = 0;
	DWORD playerId  = 0;

	if ( g_Script.m_pNpc	 )	npcId		= g_Script.m_pNpc->m_Property.controlId;
	if ( g_Script.m_pMonster )	monsterId	= g_Script.m_pMonster->m_Property.controlId;
	if ( g_Script.m_pPlayer  )	playerId	= g_Script.m_pPlayer->m_Property.m_dwStaticID;

	lua_pushnumber( L, npcId     );
	lua_pushnumber( L, monsterId );
	lua_pushnumber( L, playerId  );

	LS_CHKRET(3);
}
// check
static int L_GetMonsterData( lua_State *L )
{
	LS_CHKTOP(1);

	CMonster *obj = NULL;
	GET_MONSTER(L,1);

	WORD wIndex = static_cast<WORD>(lua_tonumber(L, 1 ));

	int		wData	= 0;
	short	lData	= 0L;
	LPCSTR	str		= " ";

	CMonster &mon = *obj;
	CMonster::SMonsterProperty &pty = mon.m_Property;

	//comm att �������
	if( wIndex >= 10 && wIndex < 10 + SCommAtt::CAT_MAX ){
		lua_pushnumber(L, pty.m_monAtt.dwAtts[wIndex-10] );
		LS_CHKRET(1);
	}

	switch( wIndex )
	{
	case 1:
		wData = mon.GetLevel();
		lua_pushnumber(L, wData);
		break;
	case 2:
		wData = pty.m_id;
		lua_pushnumber(L, wData);
		break;
	case 3:
		str = mon.GetName();
		lua_pushstring(L, str);
		break;
	case 4:
		wData = (int)pty.m_takeExp;
		lua_pushnumber(L, wData);
		break;
	case 5:
		wData = pty.m_takeMoney;
		lua_pushnumber(L, wData);
		break;
	case 6:
		lua_pushnumber( L, mon.m_dwHP );
		break;
	case 7:
		lua_pushnumber( L, mon.GetMaxHP() );
		break;
	case 8:
		lua_pushnumber(L, mon.m_wCurX);
		lua_pushnumber(L, mon.m_wCurY);
		LS_CHKRET(2);
	case 9:
		if( '\0' == mon.m_szTongName[0] )
			LS_CHKRET(0);
		lua_pushstring( L, mon.m_szTongName );
		break;
		/*10-33 Ϊȡ��������*/
	case 34:
		wData = pty.m_imageID;
		lua_pushnumber(L, wData);
		break;
	case 35:
		lua_pushnumber(L, mon.m_Property.m_targetX);
		lua_pushnumber(L, mon.m_Property.m_targetY);
		lua_pushnumber(L, mon.m_Property.m_moveScriptID);
		LS_CHKRET(3);
	case 36:
		if( mon.m_ParentRegion )
			lua_pushnumber(L, mon.m_ParentRegion->GetGID());
		break;
	case 37:
		lua_pushnumber(L, mon.GetGID());
		lua_pushnumber(L, mon.m_dwCopySceneGID);
		LS_CHKRET(2);
	case 38:
		lua_pushnumber(L, mon.m_Property.m_wSrcX);
		lua_pushnumber(L, mon.m_Property.m_wSrcY);
		LS_CHKRET(2);
	case 39:
		lua_pushnumber(L,mon.m_dwFactionID);
		break;
	// ���﹥�������gid
	case 40:
		lua_pushnumber(L, mon.GetTargetGID());
		break;
	// ȡ���� controlId
	case 43:
		lua_pushnumber(L, mon.GetControlID());	// ���д���Ϊ���˲²⣬������ʵ��C++���� (wjl)
		break;
	default:
		LS_CHKRET(0);
	}

	LS_CHKRET(1);
}
// check
static int L_CI_UpdateMonsterData( lua_State *L )
{
	LS_CHKTOP(1);

	CMonster *obj = NULL;

	int type = static_cast< int >( lua_tonumber( L , 1 ) );
	if( type == 2 ){
		//faction
		GET_MONSTER(L,2);

		LPCTSTR fname = NULL;
		if( lua_isstring(L,2) )
			fname = lua_tostring(L, 2);
		else if( g_Script.m_pPlayer )
			fname = g_Script.m_pPlayer->m_Property.m_szTongName;

		if( !fname || '\0' == fname[0] )
			LS_CHKRET(0);
		obj->SetFaction( fname );
		lua_pushboolean(L, true);
		LS_CHKRET(1);
	}else if( type == 3 ){
		//temp skill
		if( !lua_isnumber(L, 2) ) LS_CHKRET(0);

		GET_MONSTER(L,4);

		WORD skillid = (WORD)lua_tointeger( L, 2 );
		WORD skilllv = (WORD)lua_tointeger( L, 3 );
		int times = lua_isnumber(L, 4) ? lua_tointeger(L, 4) : 1;
		obj->SetTempSkill( skillid, skilllv,times);
		lua_pushboolean(L, true);
		LS_CHKRET(1);
	}else if( type == 4 ){
		//set owner
		if( !lua_isnumber(L, 2) ) LS_CHKRET(0);

		GET_MONSTER(L,2);

		//������
		obj->m_pMaster.reset();

		DWORD sid = (DWORD)lua_tointeger( L, 2 );
		CPlayer *pMaster = ( CPlayer *)GetPlayerBySID( sid )->DynamicCast(IID_PLAYER);
		if( !pMaster ) LS_CHKRET(0);
		obj->m_pMaster = pMaster->self;

		lua_pushboolean(L, true);
		LS_CHKRET(1);
	}
	//else:update property
	if( !lua_istable( L ,2 ) )
		LS_CHKRET(0);

	GET_MONSTER(L,3);

	CMonster &mon = *obj;
	CMonster::SMonsterProperty &pty = mon.m_Property;

	//ָ����̬����
	_IF_GET_FIELD_NUMBER( 2,"refreshTime"	) pty.m_dwRefreshTime	= static_cast< WORD  >( __number );
	_IF_GET_FIELD_NUMBER( 2,"updateTick"	) pty.updateScriptTime	= static_cast< WORD  >( __number );
	_IF_GET_FIELD_NUMBER( 2,"IdleTime"		) pty.m_wIdleTimeFB		= static_cast< WORD  >( __number );
	_IF_GET_FIELD_NUMBER( 2,"deadbody"		) pty.m_deadbodyTime	= static_cast< WORD  >( __number );

	_IF_GET_FIELD_NUMBER( 2,"targetID"		) pty.m_targetID		= static_cast< DWORD >( __number );
	_IF_GET_FIELD_NUMBER( 2,"targetX"		) pty.m_targetX			= static_cast< WORD  >( __number );
	_IF_GET_FIELD_NUMBER( 2,"targetY"		) pty.m_targetY			= static_cast< WORD  >( __number );

	_IF_GET_FIELD_NUMBER( 2,"refreshScript"	) pty.m_refreshScriptID	= static_cast< WORD  >( __number );
	_IF_GET_FIELD_NUMBER( 2,"moveScript"	) pty.m_moveScriptID	= static_cast< WORD  >( __number );
	_IF_GET_FIELD_NUMBER( 2,"timeScript"	) mon.updateScriptId	= static_cast< WORD  >( __number );
	_IF_GET_FIELD_NUMBER( 2,"deadScript"    ) pty.m_deadScriptID    = static_cast< int	 >( __number );
	_IF_GET_FIELD_NUMBER( 2,"eventScript"	) pty.m_eventScriptID	= static_cast< int	 >( __number );

	// ������״̬�²Ž���Ѫ��������
	if( mon.isDead() == false ){
		_IF_GET_FIELD_NUMBER( 2,"hp"			) mon.m_dwHP			= static_cast< DWORD >( __number );

		if ( mon.m_dwHP > mon.GetMaxHP() )
			mon.RestoreFullHPDirectly();
	}

	// �滻��������
	lua_getfield( L, 2, "name" );
	//check
	if( lua_isstring( L, -1 ) ) strcpy_s( pty.m_name, lua_tostring( L, -1 ) );
	lua_pop( L, 1 );

	_IF_GET_FIELD_NUMBER( 2,"imageID"		) pty.m_imageID			= static_cast< int  >( __number );
	_IF_GET_FIELD_NUMBER( 2,"headID"		) pty.m_headID			= static_cast< int  >( __number );
	_IF_GET_FIELD_NUMBER( 2,"level"			) pty.m_wLevel			= static_cast< WORD >( __number );
	_IF_GET_FIELD_NUMBER( 2,"school"		) pty.m_bySchool		= static_cast< BYTE >( __number );
	_IF_GET_FIELD_NUMBER( 2,"camp"			) pty.m_byCamp			= static_cast< BYTE >( __number );
	_IF_GET_FIELD_NUMBER( 2,"exp"			) pty.m_takeExp			= static_cast< int  >( __number );
	_IF_GET_FIELD_NUMBER( 2,"money"			) pty.m_takeMoney		= static_cast< int  >( __number );
	_IF_GET_FIELD_NUMBER( 2,"bossType"		) pty.m_byBossType		= static_cast< BYTE >( __number );
	_IF_GET_FIELD_NUMBER( 2,"aiType"		) pty.m_byAIType		= static_cast< WORD >( __number );

	_IF_GET_FIELD_NUMBER( 2,"attackArea"	) pty.m_maxAttackArea	= static_cast< int  >( __number );
	_IF_GET_FIELD_NUMBER( 2,"moveArea"		) pty.m_maxMoveArea		= static_cast< int  >( __number );
	_IF_GET_FIELD_NUMBER( 2,"searchArea"	) pty.m_maxSearchArea	= static_cast< int  >( __number );
	_IF_GET_FIELD_NUMBER( 2,"atkSpeed"		) pty.m_attackSpeed		= static_cast< int  >( __number );

	_IF_GET_FIELD_NUMBER( 2,"scriptICON"	) pty.m_scriptICON		= static_cast< DWORD  >( __number );

	if( pty.m_maxAttackArea > MAX_ATTACK_AREA	)	pty.m_maxAttackArea = MAX_ATTACK_AREA;
	if( pty.m_maxMoveArea   > MAX_MOVE_AREA		)	pty.m_maxMoveArea	= MAX_MOVE_AREA;
	if( pty.m_maxSearchArea > MAX_SEARCH_AREA	)	pty.m_maxSearchArea = MAX_SEARCH_AREA;
	// ������ΧӦС��׷����Χ
	if( pty.m_maxAttackArea )
	if( pty.m_maxSearchArea > pty.m_maxAttackArea ) pty.m_maxSearchArea	= pty.m_maxAttackArea;

	_IF_GET_FIELD_NUMBER( 2,"dynDropID"		) pty.m_dynDropTableId	= static_cast< int  >( __number );

	lua_getfield( L, 2, "monAtt" );
	//check>0
	int temp = 0;
	if ( lua_istable( L, -1 ) ) {
		for ( int i = 0; i < SCommAtt::CAT_MAX; ++i ){
		temp = (int)( _GET_ARRAY_NUMBER_DIRECTLY( -1, i + 1 ) );
		if( temp > 0 ) pty.m_monAtt.dwAtts[i] = temp; temp = 0;
		}
		// ��������
		mon.UpdateCommonAtt();
	}
	lua_pop( L, 1 );

	lua_getfield( L, 2, "skillID" );
	if ( lua_istable( L, -1 ) ) for ( int i = 0; i < MAX_MONSTER_SKILL; ++i )
		pty.m_monSkill[i].wID = static_cast< WORD >( _GET_ARRAY_NUMBER_DIRECTLY( -1,i + 1 ) );
	lua_pop( L, 1 );

	// ����ͳ�Ƽ��ܼ���
	lua_getfield( L, 2, "skillLevel" );
	if ( lua_istable( L, -1 ) ) {
		mon.m_skillcount = 0;
		for ( int i = 0; i < MAX_MONSTER_SKILL; ++i ){
			pty.m_monSkill[i].wLevel = static_cast< WORD >( _GET_ARRAY_NUMBER_DIRECTLY( -1,i + 1 ) );
			if( pty.m_monSkill[i].wLevel ) mon.m_skillcount ++;
		}

	}
	lua_pop( L, 1 );

	// ����Ŀ��ѡ��
	lua_getfield( L, 2, "Priority_Except" );
	if ( lua_istable( L, -1 ) )
	{
		mon.bySelectType			= static_cast< BYTE  >( _GET_FIELD_NUMBER_DIRECTLY( -1, "selecttype" ) );		// 1������   2���ų�
		mon.byPriorityExceptType	= static_cast< BYTE	 >( _GET_FIELD_NUMBER_DIRECTLY( -1, "type" ) );				// ���Ȼ��ų�ѡ��Ŀ�����ͣ� 1,��ɫ  2,����  3,�Ա�  4,����  5,����
		mon.dwPriorityTarget		= static_cast< DWORD >( _GET_FIELD_NUMBER_DIRECTLY( -1, "target" ) );			// Ŀ�꣬�磺���SID������ID������ID��������
	}
	lua_pop( L, 1 );

	if( lua_isnumber( L ,3 ) ){
		if( mon.m_ParentArea )
			mon.m_ParentArea->SendAdj(mon.GetStateMsg(), sizeof(SASynMonsterMsg), -1);
	}

	lua_pushboolean(L, true);
	LS_CHKRET(1);
}
// check
static int L_GetRegionPlayerCount( lua_State *L )
{
	LS_CHKTOP(1);

	DWORD regionId = static_cast< DWORD >( lua_tonumber( L, 1 ) );
	if ( regionId == 0 )
		LS_CHKRET(0);

	CRegion *region = reinterpret_cast< CRegion* >( GetRegionById( regionId ) );
	if ( region == NULL )
		LS_CHKRET(0);

	lua_pushnumber( L, region->m_PlayerList.size() );
	LS_CHKRET(1);
}
// check
static int L_ClearPackage( lua_State *L )
{
	LS_CHKTOP(0);

	if ( g_Script.m_pPlayer == NULL )
		LS_CHKRET(0);

	g_Script.m_pPlayer->ArrangePackage( 0 );

	LS_CHKRET(0);
}


// ͨ���ýű�����������һ�����ñ��д��ڵ�����Ϊ���ݵ������ͷֽ�������������ݣ�check
static int L_GetItemScripts( lua_State *L )
{
	LS_CHKTOP(1);

	int size = 0;
	void *data = luaEx_touserdata( L, 1, &size );
	BOOL doCheck = ( lua_toboolean( L, 2 ) == 0 );

	SItemBase *item = ( SPackageItem* )data;
	BOOL isPackageItem = true; // �ú���ͬʱ֧�ֱ����еĵ��ߺ�װ�����еĵ��ߣ�
	if ( size == sizeof( SPackageItem ) )
	{
		if ( doCheck && ( ( g_Script.m_pPlayer == NULL ) || !g_Script.m_pPlayer->CheckItem( *( SPackageItem* )item ) ) )
			LS_CHKRET(0);
	}
	else if ( size == sizeof( SEquipment ) )
	{
		// ˵����װ�����ĵ��ߣ�
		if ( doCheck && ( ( g_Script.m_pPlayer == NULL ) || !g_Script.m_pPlayer->CheckItemForEqui( *( SEquipment* )data ) ) )
			LS_CHKRET(0);

		item = ( SEquipment* )data;
		isPackageItem = false;
	}
	else
	{
		// ��������ݣ�
		LS_CHKRET(0);
	}

	const SItemData *itemData = CItem::GetItemData( item->wIndex );
	if ( itemData == NULL )
		LS_CHKRET(0);

	// ���ڱ��ֶ�ջƽ�⣡
	int stackPos = lua_gettop( L );

	// ���ݵ��������ж���Ҫ����һ������luaTable
	// ##############################################
	// ע�⣡�������͵��߽ṹ������ȫ��Ӧ������
	// ##############################################

	lua_createtable( L, 0, 5 );
	if ( !lua_istable( L, -1 ) )
		goto _failure;

	SETTABLE_BY_STRING( "index", ( DWORD )item->wIndex );
	SETTABLE_BY_STRING( "type", itemData->byType );
	SETTABLE_BY_STRING( "flags", ( DWORD )item->flags );

	lua_pushstring( L, "misc" );
	luaEx_pushint63( L, item->uniqueId() );
	lua_settable( L, -3 );

	// װ����
	if ( ITEM_IS_EQUIPMENT( itemData->byType ) )
	{
#define ITEM_CONVERT reinterpret_cast< SEquipment& >( *item )

#undef ITEM_CONVERT
	}
	// �ű���
	else if ( ITEM_IS_SCRIPT( itemData->byType ) )
	{
		// ����ǽű�����ߣ�����һ��script�����������нű����ݣ�
		lua_pushstring( L, "scripts" );
		lua_createtable( L, 8, 0 );
		if ( !lua_istable( L, -1 ) )
			goto _failure;

		try
		{
			SScriptItem &scriptItem = reinterpret_cast< SScriptItem& >( static_cast< SItemBase& >( *item ) );
			if ( scriptItem.declare )
			{
				lite::Serialreader slr( scriptItem.streamData );
				for ( int i = 0; i < 8; i ++ )
				{
					if ( scriptItem.declare & ( 1 << i ) )
					{
						reinterpret_cast< lite::lua_variant& >( slr() ).push( L );
						lua_rawseti( L, -2, i + 1 );
					}
				}
			}
		}
		catch ( lite::Xcpt& )
		{
			goto _failure;
		}

		lua_settable( L, -3 );
	}

	// ��Ȼ��������ô�����ݣ���ֻ������һ������ѣ�
	sassert( stackPos + 1 == lua_gettop( L ) );
	LS_CHKRET(1);

_failure:
	sassert( stackPos < lua_gettop( L ) );
	if ( stackPos < lua_gettop( L ) )
		lua_settop( L, stackPos );

	LS_CHKRET(0);
}

// ͨ���ú��������ݴ�������ñ��޸ģ����£����ߵ�����
// ����õ�����������ϵĵ��ߣ���ͬ��֪ͨ�ͻ��˸������ݣ� check
static int L_UpdateItemScripts( lua_State *L )
{
	LS_CHKTOP(2);

	int size = 0;
	void *data = luaEx_touserdata( L, 1, &size );
	bool doCheck = ( lua_toboolean( L, 3 ) == 0 );

	union {
		SRawItemBuffer rawitem;
		SEquipment equip;
	} itemUpdate;
	memset( &itemUpdate, 0, sizeof( itemUpdate ) );

	SItemBase *item = ( SPackageItem* )data;
	BOOL isPackageItem = true; // �ú���ͬʱ֧�ֱ����еĵ��ߺ�װ�����еĵ��ߣ�
	if ( size == sizeof( SPackageItem ) )
	{
		if ( doCheck && ( ( g_Script.m_pPlayer == NULL ) || !g_Script.m_pPlayer->CheckItem( *( SPackageItem* )item ) ) )
			LS_CHKRET(0);

		size = sizeof( SRawItemBuffer );
		itemUpdate.rawitem = *reinterpret_cast< SRawItemBuffer* >( item );
	}
	else if ( size == sizeof( SEquipment ) )
	{
		// ˵����װ�����ĵ��ߣ�
		if ( doCheck && ( ( g_Script.m_pPlayer == NULL ) || !g_Script.m_pPlayer->CheckItemForEqui( *( SEquipment* )data ) ) )
			LS_CHKRET(0);

		item = ( SEquipment* )data;
		isPackageItem = false;
		itemUpdate.equip = *reinterpret_cast< SEquipment* >( item );
	}
	else
	{
		// ��������ݣ�
		LS_CHKRET(0);
	}

	if ( !lua_istable( L, 2 ) )
		LS_CHKRET(0);

	const SItemData *itemData = CItem::GetItemData( item->wIndex );
	if ( itemData == NULL )
		LS_CHKRET(0);

	// ��ȡ2������,misc��flags,���misc���޸ĵĻ����Ͳ��ܼ�������ִ���ˣ�
	lua_getfield( L, 2, "misc" );
	QWORD misc = luaEx_toint63( L, -1 );
	lua_pop( L, 1 );

	if ( misc != item->uniqueId() )
		LS_CHKRET(0);

	// ���±�־λ��
	_IF_GET_FIELD_NUMBER( 2 , "flags" )  itemUpdate.rawitem.flags = ( DWORD )__number;

	// װ����
	if ( ITEM_IS_EQUIPMENT( itemData->byType ) )
	{
	}
	// �ű���
	else if ( ITEM_IS_SCRIPT( itemData->byType ) )
	{
		// ����ǽű�����ߣ�����һ��script�����������нű����ݣ�
		lua_getfield( L, 2, "scripts" );
		if ( !lua_istable( L, -1 ) ){    // ���û��script�ӱ������ʧ�ܣ�
			lua_pop( L, 1 );
			LS_CHKRET(0);
		}

		size_t size = 0;
		SScriptItem &scriptItem = reinterpret_cast< SScriptItem& >( static_cast< SItemBase& >( itemUpdate.rawitem ) );
		try
		{
			ZeroMemory( itemUpdate.rawitem.buffer, sizeof( itemUpdate.rawitem.buffer ) );
			lite::Serializer slm( scriptItem.streamData, sizeof( scriptItem.streamData ) );

			// ����8��������ȷ��ÿһ��Ԫ�ص���Ч�� 1 2 4 8 16 32 64 128
			for ( int i = 0; i < 8; i ++ )
			{
				lua_rawgeti( L, -1, i + 1 );
				if ( !lua_isnil( L, -1 ) )  // ��Ч�����ݲű����������
				{
					scriptItem.declare |= ( 1 << i );
					slm( (int)lite::lua_variant( L, -1 ) );
				}
				else
					scriptItem.declare &= ( ~( 1 << i ) );
				lua_pop( L, 1 );
			}

			// ƽ��������־!
			slm.EndEdition();
			size = slm.maxSize();
		}
		catch ( lite::Xcpt & )
		{
			// ������ִ��󣬵�Ȼ�͸���ʧ���ˣ�
			// ��Ҫ�ѳ����쳣ʱ���Ǹ��ű����ݳ�ջ! �Ա���ջƽ��
			lua_pop( L, 1 );
		}

		// ��script��ջ
		lua_pop( L, 1 );

		// ��;�����쳣, �޷��ټ���!
		if ( size == 0 )
			LS_CHKRET(0);

		// ���û���κ�����, ���൱���������
		scriptItem.size = sizeof( SItemBase ) + 1;
		if ( scriptItem.declare != 0 )
			scriptItem.size += ( BYTE )size;
	}

	// ������ϵĵ��ߣ����ҳ��������ݱ仯���Ÿ��µ��ͻ��ˣ�
	if ( doCheck && ( memcmp( &itemUpdate.rawitem, item, size ) != 0 ) )
	{
		if ( isPackageItem )
		{
			SPackageItem *pi = ( SPackageItem* )data;
			SPackageItem *realItem = g_Script.m_pPlayer->FindItemByPos( pi->byCellX, pi->byCellY );
			if ( realItem == NULL )
				LS_CHKRET(0);

			if ( memcmp( ( SItemBase* )realItem, pi, sizeof( SPackageItem ) ) != 0 )
				LS_CHKRET(0);

			static_cast< SRawItemBuffer& >( *realItem ) = itemUpdate.rawitem;
			g_Script.m_pPlayer->SendItemSynMsg( realItem , eITEM_SYN_FRESH);
		}
		else
		{
			SEquipment *equip = g_Script.m_pPlayer->CheckItemForEqui( *( SEquipment* )data );
			if ( equip == NULL )
				LS_CHKRET(0);

			if ( memcmp( equip, item, sizeof( SEquipment ) ) != 0 )
				LS_CHKRET(0);

			*equip = itemUpdate.equip;
		}
	}

	// �ɹ��󷵻�1��
	lua_pushnumber( L, 1 );
	LS_CHKRET(1);
}
// check
static int L_SetEvent( lua_State *L )
{
	LS_CHKTOP(3);

	QWORD PushLuaEvent( lua_State *L );
	QWORD kid = PushLuaEvent( L );
	LPCSTR errstr = NULL;
	switch ( kid )
	{
	case -1: errstr = "SetEvent : removing lua event in event self-execution"; break;
	case -2: errstr = "SetEvent : get error ex parameters"; break;
	case -3: errstr = "SetEvent : tick margin greater than one day in seconds"; break;
	case -4: errstr = "SetEvent : args #1 or #3 is invalid type"; break;
	}

	if ( errstr )
		luaL_error( L, errstr );

	luaEx_pushint63( L, kid );
	LS_CHKRET(1);
}
// check
static int L_ClrEvent( lua_State *L )
{
	LS_CHKTOP(1);

	int t1 = lua_type( L, 1 );
	QWORD idk = 0;
	DWORD uid = 0;
	if ( t1 == LUA_TNUMBER )
		uid = (DWORD)lua_tonumber( L, 1 );
	else if ( luaEx_isint63( L, 1 ) )
		idk = luaEx_toint63( L, 1 );

	int ClrEvent( DWORD uid, QWORD *pidk );
	int ck = ClrEvent( uid, ( t1 == LUA_TNUMBER ) ? NULL : &idk );
	if ( ck == -1 )
		luaL_error( L, "ClrEvent : removing lua event in event self-execution" );

	if ( ck <= 0 )
		LS_CHKRET(0);

	LS_RET(1);
}
// check
static int L_GetPlayer( lua_State* L )
{
	LS_CHKTOP(1);

	LPCSTR name = ( LPCSTR  )lua_tostring( L, 1 );
	BOOL isSelect = CHKSTK(2) ? 0:( BOOL  )lua_tonumber( L, 2 );

	if ( name == NULL )
		LS_CHKRET(0);

	CPlayer *player = (CPlayer *)(GetPlayerByName( name )->DynamicCast( IID_PLAYER ) );
	if ( player == NULL )
		LS_CHKRET(0);

	if ( isSelect )
		g_Script.m_pPlayer = player;

	lua_pushnumber( L, player->GetSID() );
	LS_CHKRET(1);
}
// check
static int L_MaskPlayerTalk( lua_State* L )
{
	LS_CHKTOP(1);

	CPlayer *obj = NULL;
	GET_PLAYER( L , 1 );

	WORD dontTalkTime = ( WORD )lua_tonumber( L, 1 );	// ������
	if ( dontTalkTime )
	{
		if ( GMTalkMask.find( obj->GetAccount() ) != GMTalkMask.end() )
			LS_CHKRET(0);

		GMTalkMask[ obj->GetAccount() ] = timeGetTime() + dontTalkTime * 6000;
		lua_pushnumber( L, 1 );
		LS_CHKRET(1);
	}
	else
	{
		if ( GMTalkMask.find( obj->GetAccount() ) == GMTalkMask.end() )
			LS_CHKRET(0);

		GMTalkMask.erase( obj->GetAccount() );
		lua_pushnumber( L, 1 );
		LS_CHKRET(1);
	}

	LS_CHKRET(0);
}

// check
static int L_DGiveP( lua_State *L )
{
	LS_CHKTOP(2);

	if( !g_Script.m_pPlayer ) LS_CHKRET(0);

	DWORD  val  = ( DWORD )lua_tonumber( L, 1 );
	LPCSTR info = ( LPCSTR )lua_tostring( L, 2 );
	if( !info ) info = GetNpcScriptInfo("L_DGiveP");

	g_Script.m_pPlayer->IncMoney( val,1);
	g_Script.m_pPlayer->SendCurrentMoney(1);
	extern void WriteAddMoneyToDB( CPlayer* player,DWORD money,BYTE moneyType ,LPCSTR info );
	WriteAddMoneyToDB(g_Script.m_pPlayer,val,1,info);
	lua_pushboolean( L, true );
	LS_CHKRET(1);
}
// check
static int L_CheckTempItem( lua_State *L )
{
	LS_CHKTOP(1);

	CPlayer *pPlayer = g_Script.m_pPlayer;
	if( !pPlayer ) LS_CHKRET(0);

	WORD wItemID = ( WORD )lua_tonumber( L, 1 );

	for( std::list<CPlayer::tempAddItem>::iterator it = pPlayer->m_tempItem.begin(); it != pPlayer->m_tempItem.end();)
	{
		std::list<CPlayer::tempAddItem>::iterator tit = it ++;
		SItemBase *bItem = (SItemBase*)tit->itemBuf;
		if( bItem && wItemID == bItem->wIndex ) {
			lua_pushboolean( L, true );
			LS_CHKRET(1);
		}
	}

	lua_pushboolean( L, false );
	LS_CHKRET(1);
}
// check
static int L_DelTempItem( lua_State *L )
{
	LS_CHKTOP(1);

	CPlayer *pPlayer = g_Script.m_pPlayer;
	if( !pPlayer ) LS_CHKRET(0);

	WORD wItemID = ( WORD )lua_tonumber( L, 1 );
	int count = 0;
	for( std::list<CPlayer::tempAddItem>::iterator it = pPlayer->m_tempItem.begin(); it != pPlayer->m_tempItem.end();)
	{
		std::list<CPlayer::tempAddItem>::iterator tit = it ++;
		SItemBase *bItem = (SItemBase*)tit->itemBuf;
		if( bItem && wItemID == bItem->wIndex ) {
			pPlayer->m_tempItem.erase( tit );
			count ++;
		}
	}
	if( count ) pPlayer->UpdateTempItemToClient(TRUE);
	lua_pushnumber( L, count );
	LS_CHKRET(1);
}
// check
static int L_PayEquipTime( lua_State *L  )
{
	LS_CHKTOP(3);

	DWORD pos	= static_cast<DWORD>( lua_tonumber(L, 2));
	DWORD index = static_cast<DWORD>( lua_tonumber(L, 3));
	if( !IsTimeEquip( pos ) ) LS_CHKRET(0);
	CPlayer *pPlayer = NULL;
	DWORD sid = 0;
	if( lua_isnumber( L, 1) )
		sid = static_cast<DWORD>( lua_tonumber(L, 1));
	extern LPIObject GetPlayerBySID(DWORD);
	if( sid ) pPlayer = (CPlayer *)GetPlayerBySID(sid)->DynamicCast(IID_PLAYER);
	else pPlayer = g_Script.m_pPlayer;
	if( !pPlayer ) LS_CHKRET(0);
	if( pPlayer->m_Property.m_Equip[pos].wIndex != index ) LS_CHKRET(0);
	int ret = pPlayer->PayEquipTime((EQUIP_POSITION)pos);
	lua_pushnumber( L, ret );
	LS_CHKRET(1);
}
// check
static int L_CI_InitRegionLimit( lua_State* L )
{
	LS_CHKTOP(2);

	DWORD dwRegionID = ( DWORD )lua_tonumber( L, 1 );
	if ( !lua_istable( L, 2 ) )
		LS_CHKRET(0);

	CRegion *destRegion = GetRegionById( dwRegionID );
	if ( destRegion == NULL )
		LS_CHKRET(0);

	destRegion->m_broadCastList.clear();
	destRegion->m_LimitItemList.clear();
	destRegion->m_AddBuffList.clear();
	destRegion->m_DelBuffList.clear();
	// ��������ʹ�õĵ����б�
	int i = 0;
	lua_getfield( L, 2, "ItemL" );
	if ( lua_istable( L, -1 ) ) for ( i = 0; i < (int)lua_objlen( L, -1 ); ++i ){
		destRegion->m_LimitItemList.insert( ( DWORD )( _GET_ARRAY_NUMBER_DIRECTLY( -1,i + 1 ) ) );
	}
	lua_pop( L, 1 );
	// ������Ҫ�㲥�������Ʒ�б�
	lua_getfield( L, 2, "ItemB" );
	if ( lua_istable( L, -1 ) ) for ( i = 0; i < (int)lua_objlen( L, -1 ); ++i ){
		destRegion->m_broadCastList.insert( ( WORD )( _GET_ARRAY_NUMBER_DIRECTLY( -1,i + 1 ) ) );
	}
	lua_pop( L, 1 );
	// ��������ʱ��ӵ�buff�б�
	lua_getfield( L, 2, "BuffA" );
	if ( lua_istable( L, -1 ) ) for ( i = 0; i < (int)lua_objlen( L, -1 ); ++i ){
		destRegion->m_AddBuffList.push_back( ( WORD )( _GET_ARRAY_NUMBER_DIRECTLY( -1,i + 1 ) ) );
	}
	lua_pop( L, 1 );
	// �����뿪ʱ�Ƴ���buff�б�
	lua_getfield( L, 2, "BuffD" );
	if ( lua_istable( L, -1 ) ) for ( i = 0; i < (int)lua_objlen( L, -1 ); ++i ){
		destRegion->m_DelBuffList.push_back( ( WORD )( _GET_ARRAY_NUMBER_DIRECTLY( -1,i + 1 ) ) );
	}
	lua_pop( L, 1 );

	LS_RET(1);
}
// check
static int L_SetRegionMultExp( lua_State *L )
{
	LS_CHKTOP(3);

	DWORD regionid = ( DWORD )lua_tonumber( L, 1);
	if (regionid == NULL)
		LS_CHKRET(0);

	CRegion *destRegion = GetRegionById(regionid);
	if (destRegion == NULL)
		LS_CHKRET(0);

	int type = ( int ) lua_tonumber( L, 2 );

	switch( type )
	{
	case 1:
		{
			// ���ó����౶����
			destRegion->m_wRegionMultExp = ( float )lua_tonumber( L, 3 );
			if ( destRegion->m_wRegionMultExp < 0 || destRegion->m_wRegionMultExp > 10 )
				destRegion->m_wRegionMultExp = 1;
		}
		break;
	case 2:
		{
			// ���ó���������
			destRegion->m_dwFactionID = (DWORD)lua_tonumber( L, 3 );
		}
		break;
	}

	LS_RET(0);
}

static int L_ClearByDay( lua_State *L )
{
	LS_CHKTOP(0);
	CPlayer *pPlayer = g_Script.m_pPlayer;
	if( !pPlayer ) LS_CHKRET(0);

	pPlayer->m_Property.wDearAgreeMax = 0;
	pPlayer->DecFriendsDegree();
	LS_CHKRET(0);
}

//*************************************
// ���¹���buff check
//*************************************
static int L_CI_UpdateBuffExtra( lua_State *L )
{
	LS_CHKTOP(1);

	if( lua_istable( L ,1 ) ){
		// ��ʼ��
		CFightObject *obj = NULL;
		GET_FIGHTOBJ( L ,1 );

		// �����
		ZeroMemory( obj->m_ExtraBuff,sizeof(obj->m_ExtraBuff) );

		int tableLen = (int)lua_objlen(L, 1);
		for ( int m = 0 ; m < tableLen && m < MAX_BUFF_EXTRA; m++ ){
			lua_rawgeti(L, 1, m+1 );
			if ( lua_istable(L, -1) ){
				if (lua_objlen(L, -1) < 2){
					lua_pop(L, 1);
					LS_CHKRET(0);
				}

				lua_rawgeti(L, -1, 1);
				int id = (int)lua_tointeger(L, -1);
				lua_pop(L, 1);

				lua_rawgeti(L, -1, 2);
				int level = (int)lua_tonumber(L, -1);
				lua_pop(L, 1);

				// Ϊ0��ʾ�Թ�һ��ռλ
				if( id == 0 ) { lua_pop(L, 1); continue;}

				// ��Ч��buff
				if( id<1 || level < 1 ){
					lua_pop(L, 1);
					LS_RET(1);
				}

				obj->m_ExtraBuff[m][0] = id;
				obj->m_ExtraBuff[m][1] = level;
			}
			lua_pop( L, 1 );
		}
	}else if( lua_isnumber(L ,1) ){
		LS_CHKSTK(4);

		CFightObject *obj = NULL;
		GET_FIGHTOBJ( L ,4 );

		int id			= (int)lua_tointeger( L, 1 );
		int checkid		= (int)lua_tointeger( L, 2 );
		int level		= (int)lua_tointeger( L, 3 );
		int checklevel	= (int)lua_tointeger( L, 4 );
		if( id<0 || level < 0 )
			LS_RET(1);

		for( int i = 0 ; i < MAX_BUFF_EXTRA ; i ++ )
			if( ( obj->m_ExtraBuff[i][0] == checkid ) && ( ( checklevel == 0 ) || ( obj->m_ExtraBuff[i][1] == checklevel ) ) ){
				obj->m_ExtraBuff[i][0] = id;
				obj->m_ExtraBuff[i][1] = level;
				break;
			}
	}else
		LS_CHKRET(0);

	LS_RET(0);
}

//*************************************
// ���½ű����Խӿ�(for player) check
//*************************************
static int L_CI_UpdateScriptAtt( lua_State *L )
{
	LS_CHKTOP(4);

	if ( !lua_istable( L, 1 ) )
		LS_CHKRET(0);

	CPlayer *obj = NULL;
	GET_PLAYER( L , 4 );

	int valType		= (int)lua_tointeger( L, 3 );
	int funcType	= (int)lua_tointeger( L, 4 );
	if( funcType < 0 || funcType >= Max_Script_Func )
		LS_CHKRET(0);

	for( DWORD i = 0; i < SCommAtt::CAT_MAX; ++i ){
		lua_rawgeti( L, 1 ,i + 1 );
		if( lua_isnumber( L , -1 ) ){
			int val = ( int )lua_tointeger( L, -1 );
			DWORD max = (i == SCommAtt::CAT_MAX_HP) ? 1200000 : 300000;
			// check >0 <max
			if( valType == 1 ){	//�ۼӷ�ʽ
				if( val > 0 && ( val + obj->m_ScriptAtt[funcType].dwAtts[i] < max ) )
					obj->m_ScriptAtt[funcType].dwAtts[i]  += val;
			}
			else{ //��ֵ��ʽ
				if( val >= 0 && val < max )
					obj->m_ScriptAtt[funcType].dwAtts[i]  = val;
			}
		
		lua_pop( L, 1 );

		// ȡ��ֵ������[������nil]
		lua_pushnil( L );
		lua_rawseti( L, 1, i + 1  );
	}

	int bInit = (int)lua_tointeger( L, 2 );
	if( bInit != 1 ) obj->UpdateCommonAtt();
	LS_RET(1);
}
//*************************************
// ���װ�����Խӿ� GetEquipDetails check
//arg:λ�ã�װ����ţ�����ã�
//return:{ index,quality,type,levelEM,level,misc,slots={},properties = {},} check
//*************************************
static int L_CI_GetEquipDetails( lua_State *L )
{
	LS_CHKTOP(2);

	if( !g_Script.m_pPlayer ) LS_CHKRET(0);
	int  iEquipPos	= -1;
	if( lua_isnumber(L, 1)) iEquipPos = lua_tointeger(L,1);
	if( iEquipPos == -1 ) LS_CHKRET(0);

	int checkIndex = lua_tointeger(L,2);

	SEquipment *equip = g_Script.m_pPlayer->GetEquip(iEquipPos);
	if( !equip || checkIndex != equip->wIndex ) LS_CHKRET(0);

	const SItemData *itemData = CItem::GetItemData( equip->wIndex );
	if (itemData == NULL ||!ITEM_IS_EQUIPMENT( itemData->byType ))
		LS_CHKRET(0);

	int stackPos = lua_gettop( L );
	lua_createtable( L, 0, 8 );
	if ( !lua_istable( L, -1 ) )
		goto _failure;

	SETTABLE_BY_STRING( "index", ( DWORD )equip->wIndex );
	SETTABLE_BY_STRING( "quality", itemData->byQuality );
	SETTABLE_BY_STRING( "type", itemData->byType );
	SETTABLE_BY_STRING( "levelEM", itemData->wLevelEM );
	SETTABLE_BY_STRING( "level",     ( equip->level) );
	SETTABLE_BY_STRING( "levelEx",   ( equip->levelEx) );

	lua_pushstring( L, "misc" );
	luaEx_pushint63( L, equip->uniqueId() );
	lua_settable( L, -3 );

	lua_pushstring( L, "slots" );
	lua_createtable( L, 5, 0 );
	if ( !lua_istable( L, -1 ) )
		goto _failure;

	for ( int i = 0; i < SEquipment::MAX_SLOTS; ++i )
	{
		lua_pushnumber( L, 400+equip->slots[i].type * 10 + equip->slots[i].value );
		lua_rawseti( L, -2, i + 1 );
	}
	lua_settable( L, -3 );

	lua_pushstring( L, "properties" );
	lua_createtable( L, 5, 0 );
	if ( !lua_istable( L, -1 ) )
		goto _failure;
	for ( int i = 0; i < SEquipment::MAX_QUALITYS-1; ++i )
	{
		lua_pushnumber( L, equip->qualitys[i].type * 10000 +  equip->qualitys[i].value );
		lua_rawseti( L, -2, i + 1 );
	}
	lua_settable( L, -3 );

	if( stackPos + 1 != lua_gettop( L ) ){
		TraceInfo_C("LuaStackError.txt", "[L_CI_GetEquipDetails]: stack error!");
	}
	LS_CHKRET(1);

_failure:
	sassert( stackPos < lua_gettop( L ) );
	if ( stackPos < lua_gettop( L ) )
		lua_settop( L, stackPos );
	LS_CHKRET(0);
}
//*************************************
//����װ�����Խӿ� UpdateEquipDetails check
//arg:λ�ã�{}
//return:1 check
//*************************************
static int L_CI_UpdateEquipDetails( lua_State *L )
{
	LS_CHKTOP(2);

	if( !g_Script.m_pPlayer ) LS_CHKRET(0);
	int  iEquipPos	= -1;
	if( lua_isnumber(L, 1)) iEquipPos = lua_tointeger(L,1);
	if( iEquipPos == -1 ) LS_CHKRET(0);

	SEquipment *equip = g_Script.m_pPlayer->GetEquip(iEquipPos);
	if( !equip || equip->wIndex == 0 ) LS_CHKRET(0);

	const SItemData *itemData = CItem::GetItemData( equip->wIndex );
	if ( itemData == NULL || !ITEM_IS_EQUIPMENT( itemData->byType )  )
		LS_CHKRET(0);

	if ( !lua_istable( L, 2 ) )
		LS_CHKRET(0);

	SEquipment oldEquip = *equip;

	lua_getfield( L, 2, "misc" );
	QWORD misc = luaEx_toint63( L, -1 );
	lua_pop( L, 1 );

	if (  misc != equip->uniqueId() )
		 LS_CHKRET(0);

	_IF_GET_FIELD_NUMBER( 2 ,"index" )
	{
		if( __number != equip->wIndex ){
			const SItemData *newData = CItem::GetItemData( ( WORD )__number );
			if ( newData == NULL || !ITEM_IS_EQUIPMENT( newData->byType ) )
				LS_CHKRET(0);
			if( newData->byType != itemData->byType )	// ֻ����ͬһ���͵�ת��
				LS_CHKRET(0);
			equip->wIndex = ( WORD )__number;
		}
	}

	lua_getfield( L, 2, "slots" );
	if ( lua_istable( L, -1 ) ) for ( int i = 0; i < SEquipment::MAX_SLOTS; ++i )
	{
		if ( ( i != 0 ) && equip->slots[i-1].isInvalid() )
		{
			*( LPBYTE )&equip->slots[i] = 0;
			continue;
		}
		equip->slots[i].type = ( BYTE )( (( DWORD )_GET_ARRAY_NUMBER_DIRECTLY( -1 , i + 1 ) - 400 )/ 10 );
		equip->slots[i].value = ( BYTE )( (( DWORD )__number-400 )% 10 );
	}
	lua_pop( L, 1 );

	_IF_GET_FIELD_NUMBER( 2 , "level" )		equip->level	= ( BYTE )( __number );
	_IF_GET_FIELD_NUMBER( 2 , "levelEx" )	equip->levelEx	= ( BYTE )( __number );

	lua_getfield( L, 2, "properties" );
	if ( lua_istable( L, -1 ) )
	{
		for ( int i = 0; i < SEquipment::MAX_QUALITYS - 1; i++ )
			AttUpdate( equip->qualitys[i], ( DWORD )_GET_ARRAY_NUMBER_DIRECTLY( -1 , i + 1 ) );
	}
	lua_pop( L, 1 );

	if ( ( memcmp( &oldEquip, equip, sizeof( oldEquip ) ) != 0 ) )
	{
		SAEquipInfoMsg msg;
		msg.stEquip = g_Script.m_pPlayer->m_Property.m_Equip[iEquipPos];
		msg.byPos = iEquipPos;
		g_StoreMessage( g_Script.m_pPlayer->m_ClientIndex, &msg, sizeof( msg ) );
		g_Script.m_pPlayer->InitEquipmentData();
		g_Script.m_pPlayer->UpdateCommonAtt();
	}
	LS_RET(1);
}

//*************************************
//�ű���������ӿ� check
//arg:{}
//return:1
//*************************************
static int L_CreateObjectIndirect( lua_State *L )
{
	LS_CHKTOP(1);

	if ( !lua_istable( L, 1 ) )
		LS_CHKRET(0);

	DWORD regionId = static_cast< DWORD >( _GET_FIELD_NUMBER_DIRECTLY( 1,"regionId" ) );
	if ( regionId == 0 ){
		rfalse( 12, 1, "[SCO]û��ָ��Ŀ�곡��" );
		LS_CHKRET(0);
	}

	CRegion *destRegion = GetRegionById( regionId );
	if ( destRegion == NULL ){
		rfalse( 12, 1, "[SCO]�Ҳ���ָ������" );
		LS_CHKRET(0);
	}

	DWORD controlId = 0;
	_IF_GET_FIELD_NUMBER( 1,"controlId" )
	{
		if ( destRegion->CheckObjectByControlId( controlId = static_cast< DWORD >( __number ) ) ){
			rfalse( 12, 1, "[SCO]ָ�������е��ƶ���Ŷ����Ѿ�����[r=%d, cid=%d]", regionId, controlId );
			LS_CHKRET(0);
		}
	}

	DWORD objectType = static_cast< DWORD >( _GET_FIELD_NUMBER_DIRECTLY( 1,"objectType" ) );
	if ( objectType == 0 )
	{
		CMonster::SParameter param;
		ZeroMemory( &param, sizeof( CMonster::SParameter) );
		//����Ĭ�Ϸ���
		param.byteDir = 4;

		// ��ȡ������
		param.wListID = static_cast< BOOL >( _GET_FIELD_NUMBER_DIRECTLY( 1,"monsterId" ) );
		if( param.wListID == 0 ){
			rfalse( 2, 1, "[SCO]����ID��1��ʼ" );
			LS_CHKRET(0);
		}
		SMonsterData *monsterData = CMonster::GetMonsterData( param.wListID );
		if ( monsterData == NULL ){
			rfalse( 2, 1, "[SCO]�ڻ����б����Ҳ�����ӦID�Ĺ���" );
			LS_CHKRET(0);
		}

		#if USE_MONSTERDATA_POOL
			static object_pool<SMonsterData>  monsterDataPool;
			param.baseData = monsterDataPool.construct();
		#else
			param.baseData = new SMonsterData();	// no use
		#endif
		if( param.baseData == NULL ){
			TraceInfo("Monster_Error.txt","%s [rid:%d][monsterid:%d]",_GetStringTime(),destRegion->m_wRegionID , param.wListID );
			rfalse( 2, 1, "[SCO]param.baseData == NUL" );
			LS_CHKRET(0);
		}

		*param.baseData = *monsterData;

		//ָ����̬����
		_IF_GET_FIELD_NUMBER( 1,"refreshTime"	) param.dwRefreshTime   = static_cast< WORD >( __number );
		_IF_GET_FIELD_NUMBER( 1,"updateTick"	) param.updateTick		= static_cast< WORD  >( __number );
		_IF_GET_FIELD_NUMBER( 1,"IdleTime"		) param.wIdleTime		= static_cast< WORD  >( __number );
		_IF_GET_FIELD_NUMBER( 1,"deadbody"		) param.deadbodyTime	= static_cast< WORD  >( __number );

		_IF_GET_FIELD_NUMBER( 1,"x"				) param.wX              = static_cast< WORD  >( __number );
		_IF_GET_FIELD_NUMBER( 1,"y"				) param.wY              = static_cast< WORD  >( __number );
		_IF_GET_FIELD_NUMBER( 1,"dir"			) param.byteDir         = static_cast< BYTE  >( __number );
		_IF_GET_FIELD_NUMBER( 1,"mapIcon"		) param.byMapMarkIcon	= static_cast< BYTE  >( __number );
		_IF_GET_FIELD_NUMBER( 1,"refreshScript"	) param.refreshScriptID = static_cast< WORD  >( __number );
		_IF_GET_FIELD_NUMBER( 1,"moveScript"	) param.moveScriptID	= static_cast< WORD  >( __number );
		_IF_GET_FIELD_NUMBER( 1,"timeScript"	) param.timeScriptID	= static_cast< WORD  >( __number );
		_IF_GET_FIELD_NUMBER( 1,"targetID"		) param.targetID		= static_cast< DWORD >( __number );
		_IF_GET_FIELD_NUMBER( 1,"targetX"		) param.targetX			= static_cast< WORD  >( __number );
		_IF_GET_FIELD_NUMBER( 1,"targetY"		) param.targetY			= static_cast< WORD  >( __number );


		// �滻��������
		SMonsterData *pro = param.baseData;

		lua_getfield( L, 1, "name" );
		//check
		if( lua_isstring( L, -1 ) ) strcpy_s( pro->m_name, lua_tostring( L, -1 ) );
		lua_pop( L, 1 );

		_IF_GET_FIELD_NUMBER( 1,"imageID"		) pro->m_imageID		= static_cast< int  >( __number );
		_IF_GET_FIELD_NUMBER( 1,"headID"		) pro->m_headID			= static_cast< int  >( __number );
		_IF_GET_FIELD_NUMBER( 1,"level"			) pro->m_wLevel			= static_cast< WORD >( __number );
		_IF_GET_FIELD_NUMBER( 1,"school"		) pro->m_bySchool		= static_cast< BYTE >( __number );
		_IF_GET_FIELD_NUMBER( 1,"camp"			) pro->m_byCamp			= static_cast< BYTE >( __number );
		_IF_GET_FIELD_NUMBER( 1,"exp"			) pro->m_takeExp		= static_cast< int  >( __number );
		_IF_GET_FIELD_NUMBER( 1,"money"			) pro->m_takeMoney		= static_cast< int  >( __number );

		_IF_GET_FIELD_NUMBER( 1,"bossType"		) pro->m_byBossType		= static_cast< BYTE >( __number );
		_IF_GET_FIELD_NUMBER( 1,"aiType"		) pro->m_byAIType       = static_cast< WORD >( __number );
		_IF_GET_FIELD_NUMBER( 1,"attackArea"	) pro->m_maxAttackArea	= static_cast< int  >( __number );
		_IF_GET_FIELD_NUMBER( 1,"moveArea"		) pro->m_maxMoveArea    = static_cast< int  >( __number );
		_IF_GET_FIELD_NUMBER( 1,"searchArea"	) pro->m_maxSearchArea	= static_cast< int  >( __number );
		_IF_GET_FIELD_NUMBER( 1,"atkSpeed"		) pro->m_attackSpeed	= static_cast< int  >( __number );
		_IF_GET_FIELD_NUMBER( 1,"dynDropID"		) pro->m_dynDropTableId	= static_cast< int  >( __number );

		/*
		scriptICON˵����
			boss�����ֶ�	���	�Ա�*100 + ͷ��
			ͼ��id			���	�·�id(����б��׾��Ǳ���, ����Ϊ�·�)
			ͷ��id			���	����id(�������� + ħ��ȼ� ��������ݵĶ�ȡ��ʽ)
			scriptICON		32bit
		*/
		_IF_GET_FIELD_NUMBER( 1,"scriptICON"		) pro->m_scriptICON	= static_cast< DWORD  >( __number );

		if( pro->m_maxAttackArea > MAX_ATTACK_AREA )	pro->m_maxAttackArea	= MAX_ATTACK_AREA;
		if( pro->m_maxMoveArea   > MAX_MOVE_AREA )		pro->m_maxMoveArea		= MAX_MOVE_AREA;
		if( pro->m_maxSearchArea > MAX_SEARCH_AREA )	pro->m_maxSearchArea	= MAX_SEARCH_AREA;
		// ������ΧӦС��׷����Χ
		// ׷����ΧΪ0��ʾ����׷��
		if( pro->m_maxAttackArea )
		if( pro->m_maxSearchArea > pro->m_maxAttackArea )
			pro->m_maxSearchArea	= pro->m_maxAttackArea;

		lua_getfield( L, 1, "monAtt" );
		// check>0
		int temp = 0;
		if ( lua_istable( L, -1 ) ) for ( int i = 0; i < SCommAtt::CAT_MAX; ++i ){
			temp = (int)( _GET_ARRAY_NUMBER_DIRECTLY( -1, i + 1 ) );
			if( temp > 0 ) pro->m_monAtt.dwAtts[i] = temp; temp = 0;
		}
		lua_pop( L, 1 );

		_IF_GET_FIELD_NUMBER( 1,"deadScript"   ) pro->m_deadScriptID   = static_cast< int	>( __number );
		_IF_GET_FIELD_NUMBER( 1,"eventScript"	) pro->m_eventScriptID	= static_cast< int	>( __number );

		lua_getfield( L, 1, "skillID" );
		if ( lua_istable( L, -1 ) ) for ( int i = 0; i < MAX_MONSTER_SKILL; ++i )
			pro->m_monSkill[i].wID = static_cast< WORD >( _GET_ARRAY_NUMBER_DIRECTLY( -1,i + 1 ) );
		lua_pop( L, 1 );

		lua_getfield( L, 1, "skillLevel" );
		if ( lua_istable( L, -1 ) ) for ( int i = 0; i < MAX_MONSTER_SKILL; ++i )
			pro->m_monSkill[i].wLevel = static_cast< WORD >( _GET_ARRAY_NUMBER_DIRECTLY( -1,i + 1 ) );
		lua_pop( L, 1 );

		// ����Ŀ��ѡ��
		BYTE selectType = 0 , peType = 0  ;
		DWORD target = 0 ;
		lua_getfield( L, 1, "Priority_Except" );
		if ( lua_istable( L, -1 ) )
		{
			selectType	= static_cast< BYTE  >( _GET_FIELD_NUMBER_DIRECTLY( -1, "selecttype" ) );		// 1������   2���ų�
			peType		= static_cast< BYTE	 >( _GET_FIELD_NUMBER_DIRECTLY( -1, "type" ) );				// ���Ȼ��ų�ѡ��Ŀ�����ͣ� 1,��ɫ  2,����  3,�Ա�  4,����  5,����
			target		= static_cast< DWORD >( _GET_FIELD_NUMBER_DIRECTLY( -1, "target" ) );			// Ŀ�꣬�磺���SID������ID������ID��������
		}
		lua_pop( L, 1 );

		BYTE bBR = 0;
		_IF_GET_FIELD_NUMBER( 1,"BRMONSTER" ) bBR = static_cast< BYTE >( __number );
		if ( bBR )
		{
			_IF_GET_FIELD_NUMBER( 1,"BRTeamNumber" ) param.dwBRTeamNumber   = static_cast< DWORD >( __number );
			_IF_GET_FIELD_NUMBER( 1,"centerX"      ) param.wCenterX         = static_cast< WORD  >( __number );
			_IF_GET_FIELD_NUMBER( 1,"centerY"      ) param.wCenterY         = static_cast< WORD  >( __number );
			_IF_GET_FIELD_NUMBER( 1,"BRArea"       ) param.wBRArea          = static_cast< WORD  >( __number );
			_IF_GET_FIELD_NUMBER( 1,"BRNumber"     ) param.dwBRNumber       = static_cast< DWORD >( __number );

			DWORD dwCSGID = static_cast< DWORD >( _GET_FIELD_NUMBER_DIRECTLY( 1,"copySceneGID" ) );

			while ( (param.dwBRNumber < 1000) && (param.dwBRNumber--) )
			{
				// ��һ��ȷ��ˢ������
				RandomPos( destRegion, param.wX, param.wY, param.wCenterX, param.wCenterY, param.wBRArea, 50);
				CMonster *monster = destRegion->CreateMonster( &param, controlId );
				if( !monster ) {
					rfalse( 2, 1, "[SCO]CreateMonsterʧ�ܣ�" );
					if( param.baseData ) {
						#if USE_MONSTERDATA_POOL
							monsterDataPool.destroy(param.baseData);
						#else
							delete param.baseData;
						#endif
						param.baseData = NULL;
					}
					LS_CHKRET(0);
				}

				monster->bySelectType			= selectType;
				monster->byPriorityExceptType	= peType;
				monster->dwPriorityTarget		= target;

				// ������ͼ�й���
				monster->SetCopySceneGID( dwCSGID );
			}
			lua_pushnumber( L, 1 );
		}
		else
		{
			if( lua_isnumber( L , 2 ) ){
				DWORD sid = (DWORD)lua_tonumber(L, 2);
				CPlayer *pPlayer = (CPlayer *)GetPlayerBySID(sid)->DynamicCast(IID_PLAYER);
				//���ߵĻ���������������ݸ��ǹ�������(���� �ȼ� ��������)
				if( pPlayer ) pPlayer->CopyAttToMonster(param);
			}
			CMonster *monster = destRegion->CreateMonster( &param, controlId );
			if ( monster == NULL ) {
				rfalse( 2, 1, "[SCO]CreateMonsterʧ�ܣ�" );
				if( param.baseData ) {
					#if USE_MONSTERDATA_POOL
						monsterDataPool.destroy(param.baseData);
					#else
						delete param.baseData;
					#endif
					param.baseData = NULL;
				}
				LS_CHKRET(0);
			}

			monster->bySelectType			= selectType;
			monster->byPriorityExceptType	= peType;
			monster->dwPriorityTarget		= target;

			// ������ͼ�й���
			monster->SetCopySceneGID( static_cast< int >( _GET_FIELD_NUMBER_DIRECTLY( 1,"copySceneGID" ) ) );
			lua_pushnumber( L, monster->GetGID() );
		}

		if( param.baseData ) {
			#if USE_MONSTERDATA_POOL
				monsterDataPool.destroy(param.baseData);
			#else
				delete param.baseData;
			#endif
			param.baseData = NULL;
		}
		LS_CHKRET(1);
	}
	else if ( objectType == 1 )
	{
		CNpc::SParameter param;
		memset( &param, 0, sizeof( param ) );

		_IF_GET_FIELD_NUMBER( 1,"imageId"     ) param.wTypeID        = static_cast< WORD >( __number );
		_IF_GET_FIELD_NUMBER( 1,"x"           ) param.wX             = static_cast< WORD >( __number );
		_IF_GET_FIELD_NUMBER( 1,"y"           ) param.wY             = static_cast< WORD >( __number );
		_IF_GET_FIELD_NUMBER( 1,"clickScript" ) param.wClickScriptID = static_cast< WORD >( __number );
		_IF_GET_FIELD_NUMBER( 1,"dir"         ) param.wDir           = static_cast< WORD >( __number );
		_IF_GET_FIELD_NUMBER( 1,"mType"       ) param.m_tType        = static_cast< BYTE >( __number );
		_IF_GET_FIELD_NUMBER( 1,"headID"      ) param.wHeadID        = static_cast< WORD >( __number );
		_IF_GET_FIELD_NUMBER( 1,"iconID"      ) param.byIconID       = static_cast< BYTE >( __number );

		CNpc *npc = destRegion->CreateNpc( &param, controlId );
		if ( npc == NULL ){
			rfalse( 2, 1, "(COI)CreateNpcʧ�ܣ�" );
			LS_CHKRET(0);
		}

		lua_pushnumber( L, npc->GetGID() );
		LS_CHKRET(1);
	}
	else if ( objectType == 2 )
	{
		// ��ȡ�������
		BYTE idx = static_cast< BYTE >( _GET_FIELD_NUMBER_DIRECTLY( 1,"idx" ) );
		if( idx >= MAX_HEROS ){
			rfalse( 2, 1, "(SCO)create hero idx error!" );
			LS_CHKRET(0);
		}

		CHero *pHero = g_Script.m_pPlayer->GetHero( idx ,NULL );
		if( !pHero ){
			rfalse( 2, 1, "(SCO)create hero error!" );
			LS_CHKRET(0);
		}

		//ָ����������
		CHero::SHeroData *pro = ( CHero::SHeroData *)&pHero->m_Property;
		lua_getfield( L, 1, "name" );
		//check
		if( lua_isstring( L, -1 ) ) strcpy_s( pro->m_name, lua_tostring( L, -1 ) );
		lua_pop( L, 1 );
		//check > 0
		int temp = 0;
		lua_getfield( L, 1, "heroAtt" );
		if ( lua_istable( L, -1 ) ) for ( int i = 0; i < SCommAtt::CAT_MAX; ++i ){
			temp = (int)( _GET_ARRAY_NUMBER_DIRECTLY( -1, i + 1 ) );
			if( temp > 0 ) pro->m_heroAtt.dwAtts[i] = temp; temp = 0;
		}
		lua_pop( L, 1 );

		lua_getfield( L, 1, "skillID" );
		if ( lua_istable( L, -1 ) ) for ( int i = 0; i < MAX_HEROSKILL; ++i )
			pro->m_heroSkill[i].wID = static_cast< WORD >( _GET_ARRAY_NUMBER_DIRECTLY( -1,i + 1 ) );
		lua_pop( L, 1 );

		lua_getfield( L, 1, "skillLevel" );
		if ( lua_istable( L, -1 ) ) {
			pHero->m_skillcount = 0;
			for ( int i = 0; i < MAX_HEROSKILL; ++i ){
				pro->m_heroSkill[i].wLevel = static_cast< WORD >( _GET_ARRAY_NUMBER_DIRECTLY( -1,i + 1 ) );
				if( pro->m_heroSkill[i].wLevel ) pHero->m_skillcount ++;
			}
		}
		lua_pop( L, 1 );

		lua_pushnumber( L, pHero->GetGID() );
		LS_CHKRET(1);
	}
	else if ( objectType == 3 )
	{
		LS_CHKRET(0);
	}
	else
	{
		LS_CHKRET(0);
	}

	LS_CHKRET(0);
}
//��������ӿ� check
// 1�ٳ� 2 �ٻ�
static int L_CI_OperateMounts( lua_State *L )
{
	LS_CHKTOP(1);

	CPlayer *obj = NULL;

	int		op		= static_cast< int	>( lua_tonumber( L, 1 ) );

	//�޸�����
	if( op == 1 )
	{
		LS_CHKSTK(3);

		GET_PLAYER( L , 3 );

		int	id		= static_cast< int >( lua_tonumber( L, 2 ) );
		int	speed	= static_cast< int >( lua_tonumber( L, 3 ) );
		if( id == -1 || speed < 0 )
			LS_CHKRET(0);

		// �����Ҫ�����жϵ�ͼ�Ƿ���������,�����û�б���������
		if ( id > 0 && obj->GetRidingMountId() <= 0 )
		if ( ( obj->m_ParentRegion && obj->m_ParentRegion->CheckRegionLimit( LimitMounts ) ) ||
			 ( obj->CheckAction(ECA_CANMOUNTS) == false ) )
			LS_CHKRET(0);

		obj->SetRidingMount( (short)id , (WORD)speed );
	}
	//�������ı�����
	else if( op == 2)
	{
		GET_PLAYER( L , 1 );

		obj->SetRidingMount();
	}

	LS_RET(0);
}

//��Ӳ����ӿ� check
// 1�ٳ� 2 ���� 3 �ٻ� 4 ���
//�ٳ���Ҫ�������ԵĴ����ٳ�ʱ�ڽű���ʱ���ݼ�¼һ����ǰ��ӵȼ�������´��ٳ�ʱ�ȼ���ͬ����£���һ���ٳ�ʱ�ȼ�Ϊ�գ�
static int L_CI_OperateHero( lua_State *L )
{
	LS_CHKTOP(2);

	CPlayer *pPlayer = g_Script.m_pPlayer;
	if( !pPlayer ) LS_RET(-6);

	CRegion *pr = pPlayer->m_ParentRegion;
	if( !pr ) LS_RET(-4);

	int		op		= static_cast< int	>( lua_tonumber( L, 1 ) );
	BYTE	idx		= static_cast< BYTE >( lua_tonumber( L, 2 ) );

	if( idx >= MAX_HEROS ) LS_CHKRET(0);

	CHero *pHero = NULL;

	//�ٳ�
	if( op == 1 )
	{
		//�������������
		if( pr->CheckRegionLimit( LimitCallHero ) )
			LS_RET(-5);

		//�Ѿ�����ӱ��ٳ�
		if( pPlayer->GetCallHeroIndex() != MAX_HEROS )
			LS_RET(-1);
		pHero = pPlayer->GetHero( idx ,NULL );
	}
	//���� - ȡ���� - ��buff
	else if( op == 2 || op == 5 || op == 6 )
	{
		//ֻ�ܸ��µ�ǰ��ս�����
		if( pPlayer->GetCallHeroIndex() != idx )
			LS_RET(-2);
		pHero = pPlayer->GetHeroCall();
	}
	//�ٻ�
	else if( op == 3 )
	{
		if( pPlayer->CallBackHero( idx ) )
			LS_RET(1);
		LS_CHKRET(0);
	}
	//���
	else if( op == 4 )
	{
		//������ٳ�״̬�����ٻ�
		if( pPlayer->GetCallHeroIndex() == idx ){
			if( !pPlayer->CallBackHero( idx ) )
				LS_RET(-3);
		}

		if( pPlayer->DelHero( idx ) )
			LS_RET(1);
		LS_CHKRET(0);
	}
	else if( op == 5 ) {
		int index = -1;
		if(!CHKSTK(3) && lua_isnumber( L , 3 ) ) index = lua_tonumber(L,3);
		switch(index){
			case 1:
				lua_pushnumber(L,pHero->m_dwHP);
				break;
			case 2:
				lua_pushnumber(L,pHero->m_Property.m_MasterSID);
				break;
			case 3:
				pPlayer = pHero->GetMaster();
				lua_pushnumber(L,pPlayer ? pPlayer->GetCallHeroIndex() : -2 );
				break;
			default:
				lua_pushnumber(L,-11);
				break;
		}
		LS_CHKRET(1);
	}
	else if( op == 6 ) {

		if(!CHKSTK(6)) LS_RET(-12);

		WORD buffId		= static_cast<WORD>( lua_tointeger( L, 3 ) );
		BOOL interrupt	= lua_toboolean( L, 4 );
		int  level		= static_cast<int>( lua_tointeger( L, 5 ) );
		BOOL isForever	= lua_toboolean( L, 6 );

		if( level <= 0  ) level = 1;
		bool ret = pHero->buffManager.AddBuff( buffId, interrupt, level, 0, isForever , pHero );

		lua_pushboolean(L, ret);
		LS_CHKRET(1);
	}

	if( !pHero ) LS_CHKRET(0);

	if( !CHKSTK(3) && lua_istable( L , 3 ) ){
		//ָ����������
		CHero::SHeroData *pro = ( CHero::SHeroData *)&pHero->m_Property;

		_IF_GET_FIELD_NUMBER( 3,"id"     ) pro->m_wTypeID	= static_cast< WORD >( __number );
		_IF_GET_FIELD_NUMBER( 3,"lv"     ) pro->m_byLevel	= static_cast< BYTE >( __number );
		// check
		lua_getfield( L, 3, "n" );
		if( lua_isstring( L, -1 ) ) strcpy_s( pro->m_name, lua_tostring( L, -1 ) );
		lua_pop( L, 1 );
		// check > 0
		lua_getfield( L, 3, "att" );
		int temp = 0;
		if ( lua_istable( L, -1 ) ) for ( int i = 0; i < SCommAtt::CAT_MAX; ++i ){
			temp = (int)( _GET_ARRAY_NUMBER_DIRECTLY( -1, i + 1 ) );
			if( temp > 0 ) pro->m_heroAtt.dwAtts[i] = temp; temp = 0;
		}
		lua_pop( L, 1 );

		lua_getfield( L, 3, "skid" );
		if ( lua_istable( L, -1 ) ) for ( int i = 0; i < MAX_HEROSKILL; ++i )
			pro->m_heroSkill[i].wID = static_cast< WORD >( _GET_ARRAY_NUMBER_DIRECTLY( -1,i + 1 ) );
		lua_pop( L, 1 );

		lua_getfield( L, 3, "sklv" );

		if ( lua_istable( L, -1 ) ) {
			pHero->m_skillcount = 0;
			for ( int i = 0; i < MAX_HEROSKILL; ++i ){
				pro->m_heroSkill[i].wLevel = static_cast< WORD >( _GET_ARRAY_NUMBER_DIRECTLY( -1,i + 1 ) );
				if( pro->m_heroSkill[i].wLevel ) pHero->m_skillcount ++;
			}
		}
		lua_pop( L, 1 );
	}

	if( op == 1 ){
		if( !pPlayer->CallHero( idx , pHero ) )
			LS_CHKRET(0);
	}
	else if( op == 2 ){
		pHero->UpdateCommonAtt();
	}

	lua_pushnumber( L, pHero->GetGID() );
	LS_CHKRET(1);
}
//�ֶ�ɾ����̬�����Ľӿ� check
// gid,�Ƿ��Ƴ����,Ŀ�곡��id��Ŀ��x��Ŀ��y
// ����ֵ�� -1 �Ҳ����ö�̬���� -2 �������Ϊ�����ֶ�ɾ�� -4 �������̴����Ķ�̬���������ֶ��Ƴ���� -3 �����������Ϊ0
static int L_CI_DeleteDRegion( lua_State *L )
{
	LS_CHKTOP(2);

	DWORD gid = ( DWORD )lua_tonumber( L, 1 );
	CRegion *destRegion = GetRegionById( gid );
	if ( destRegion == NULL )
		LS_CHKRET(0);

	CDynamicRegion *pDyRegion = (CDynamicRegion *)destRegion->DynamicCast(IID_DYNAMICREGION) ;
	if ( !pDyRegion )
		LS_RET(-1);

	// ��������ӿڸ�Ϊ����ɾ�����⶯̬����
	//if ( pDyRegion->m_bAutoDelete == 1 )
	//	return lua_pushnumber( L, -2 ),1;

	bool bPutPlayer = lua_toboolean(L,2);

	if( bPutPlayer ){
		//�������̴����Ķ�̬���������ֶ��Ƴ����
		if( pDyRegion->GetCopySceneGID() )
			LS_RET(-4);

		WORD rid =  CHKSTK(5) ? 0:(WORD)lua_tonumber( L,3);
		WORD rx  = (WORD)lua_tonumber( L,4);
		WORD ry  = (WORD)lua_tonumber( L,5);
		if( !rid ){
			rid = 1;
			int r = Random_Int(0,12);
			rx = retPos[r].x;
			ry = retPos[r].y;
		}
		if( destRegion->m_PlayerList.size() > 0 ){
			check_list<LPIObject> templist( destRegion->m_PlayerList );
			check_list<LPIObject>::iterator iter = templist.begin();
			while (iter != templist.end())
			{
				CPlayer *pPlayer = (CPlayer *)(*iter)->DynamicCast(IID_PLAYER);
				PutPlayerIntoDestRegion( pPlayer, rid , rx , ry , 0 , FALSE );
				iter++;
			}
		}
	}

	if( destRegion->m_PlayerList.size() > 0 )
		LS_RET(-3);

	destRegion->isValid() = false;
	LS_RET(0);
}
// check
// ɾ������
/**
	������regionId   monsterGID
**/
static int L_CI_DelMonster(lua_State *L)
{
	LS_CHKTOP(2);

	DWORD			RegionGID = static_cast<DWORD>(lua_tonumber(L, 1));
	unsigned long	MonsterGID = (unsigned long)lua_tonumber(L, 2);

	CRegion *pRegion = NULL;
	pRegion = GetRegionById(RegionGID);
	if (pRegion == NULL)
		LS_CHKRET(0);

	pRegion->DelMonster(MonsterGID);

	LS_CHKRET(0);
}
// check
// ��ȡ��ǰλ�� x y regionId mapgid
/**
	��ѡ����: 2   sid	(��ȡָ�����ʱʹ��)
**/
static int L_CI_GetCurPos( lua_State *L )
{
	LS_CHKTOP(0);

	CActiveObject *obj = NULL;
	GET_OBJ( L , 0);

	WORD	wX = 0;
	WORD	wY = 0;
	DWORD	wRegionID = 0;
	DWORD	dwGID = 0;

	obj->GetCurPos( wX, wY );

	CRegion *pr = obj->m_ParentRegion;
	if ( pr )
	{
		if ( pr->DynamicCast( IID_DYNAMICREGION ) )
		{
			dwGID = pr->GetGID();
			wRegionID = pr->m_wRegionID;
		}
		else
		{
			wRegionID = pr->m_wRegionID;
		}
	}

	lua_pushnumber(L, wX);
	lua_pushnumber(L, wY);
	lua_pushnumber(L, wRegionID);
	if( dwGID ){
		lua_pushnumber(L, dwGID);
		LS_CHKRET(4);
	}
	LS_CHKRET(3);
}
// check
// ɾ��NPC
/**
	������regionId   monsterGID
**/
static int L_CI_DelNpc(lua_State *L)
{
	LS_CHKTOP(2);

	DWORD  dwRegionID = static_cast<DWORD>(lua_tonumber(L, 1));
	DWORD  dwNpcGID = static_cast<DWORD>(lua_tonumber(L, 2));

	CRegion *pRegion = NULL;

	if(dwRegionID > 0x40000000)
	{
		pRegion = (CRegion *)FindRegionByGID(
			dwRegionID)->DynamicCast(IID_REGION);

	}
	else
	{
		pRegion = (CRegion *)FindRegionByID(
			dwRegionID)->DynamicCast(IID_REGION);
	}

	if (pRegion)
		pRegion->DelNpc(dwNpcGID);

	LS_CHKRET(0);
}
// check
static int L_GetRegionRetPos( lua_State *L )
{
	LS_CHKTOP(0);

	if ( g_Script.m_pPlayer == NULL )
		LS_CHKRET(0);

	WORD wX = 0;
	WORD wY = 0;
	WORD wRegionID = 0;

	if ( CRegion *pr = g_Script.m_pPlayer->m_ParentRegion )
	{
		wRegionID = pr->m_wReLiveRegionID;
		wX = ( WORD )pr->m_ptReLivePoint.x;
		wY = ( WORD )pr->m_ptReLivePoint.y;
	}

	lua_pushnumber(L, wX);
	lua_pushnumber(L, wY);
	lua_pushnumber(L, wRegionID);

	LS_CHKRET(3);
}
// check
static int L_SetRegionRetPos( lua_State *L )
{
	LS_CHKTOP(2);

	if ( g_Script.m_pPlayer == NULL )
		LS_CHKRET(0);

	CRegion *pr = g_Script.m_pPlayer->m_ParentRegion;
	if ( pr == NULL )
		LS_CHKRET(0);


	pr->m_ptReLivePoint.x = lua_tointeger(L, 1);
	pr->m_ptReLivePoint.y = lua_tointeger(L, 2);

	if( !CHKSTK(3) && lua_isnumber(L,3) )
		pr->m_wReLiveRegionID = (WORD)lua_tointeger(L, 3);

	LS_RET(0);
}
// check
// ���������
/**
	������regionId   mapId   ��������   ...
**/
static int L_SetTrap(lua_State *L)
{
	LS_CHKTOP(3);

	WORD  wRegionID = (WORD)lua_tonumber(L, 1);

	DWORD dwRegionGID = CHKSTK(7) ? 0 : (DWORD)lua_tonumber(L, 7);

	CRegion *pRegion = NULL;

	if (dwRegionGID == 0)
	{
		pRegion = (CRegion *)FindRegionByID(wRegionID)->DynamicCast(IID_REGION);
	}
	else
	{
		LPIObject FindRegionByGID(DWORD GID);
		pRegion = (CRegion *)FindRegionByGID(dwRegionGID)->DynamicCast(IID_REGION);
	}

	if(pRegion == NULL)
		LS_RET(0);

	WORD wOrder = (WORD)lua_tonumber(L, 2);

	WORD x = 0, y = 0;
	CTrigger Trap;
	Trap.m_dwType = (DWORD)lua_tonumber(L, 3);
	// �˺�������
	if ( Trap.m_dwType == CTrigger::TT_DAMAGE_TRAP )
	{
		LS_CHKSTK(9);

		x = (WORD)lua_tonumber(L, 4);
		y = (WORD)lua_tonumber(L, 5);
		Trap.SDamageTrap.damType = (BYTE)lua_tonumber(L, 6);
		Trap.SDamageTrap.valType = (BYTE)lua_tonumber(L, 8);
		Trap.SDamageTrap.value	 = (int)lua_tonumber(L, 9);
		Trap.SDamageTrap.buffID  = CHKSTK(10) ? 0 : (WORD)lua_tonumber(L, 10);
	}
	// �ص�������
	else if ( Trap.m_dwType == CTrigger::TT_MAPTRAP_EVENT )
	{
		LS_CHKSTK(8);

		x = Trap.SMapEvent.wCurX = (WORD)lua_tonumber(L, 4);
		y = Trap.SMapEvent.wCurY = (WORD)lua_tonumber(L, 5);
		Trap.SMapEvent.dwScriptID = (DWORD)lua_tonumber(L, 6);
		Trap.SMapEvent.args = (int)lua_tonumber(L, 8);
	}
	// ֱ��������
	else if ( Trap.m_dwType == CTrigger::TT_CHANGE_REGION )
	{
		LS_CHKSTK(9);

		Trap.SChangeRegion.wNewRegionID = (WORD)lua_tonumber(L, 4);
		Trap.SChangeRegion.wStartX = (WORD)lua_tonumber(L, 5);
		Trap.SChangeRegion.wStartY = (WORD)lua_tonumber(L, 6);
		Trap.SChangeRegion.dwNewRegionGID = CHKSTK(10) ? 0 : (DWORD)lua_tonumber(L, 10);
		x = (WORD)lua_tonumber(L, 8);
		y = (WORD)lua_tonumber(L, 9);
	}
	else if ( Trap.m_dwType != 0 )
		LS_RET( 0 );

	if(pRegion->SetTrap(/*(BYTE) �ᵼ�½ض�*/wOrder, x, y, &Trap))
	{
		lua_pushnumber(L, 1);

		// ����Trap���������Ѿ����óɹ���lite::variantʧЧ��
		memset( &Trap, 0, sizeof( Trap ) );
	}
	else
		lua_pushnumber(L, 0);

	LS_CHKRET(1);
}
// check
// ����NPC����
/**
	��������������   ��������(boolean or table)
	��ѡ������6   controlID   mapGID (����ָ������,��ָ����ʾ��ǰ����)
**/
static int L_CI_UpdateNpcData( lua_State *L )
{
	LS_CHKTOP(2);

	CNpc *obj = NULL;
	GET_NPC( L , 2 );

	int type = static_cast< int >( lua_tonumber( L , 1 ) );
	if( type == 2 ){
		// collect flags
		// �ɼ���־
		obj->SetCollected( lua_toboolean(L, 2) );
		LS_RET(0);
	}
	//else: update property
	// ��������
	if( !lua_istable( L , 2 ) )
		LS_CHKRET(0);

	_IF_GET_FIELD_NUMBER( 2,"imageId"     ) obj->m_Property.m_wTypeID			= static_cast< WORD >( __number );
	_IF_GET_FIELD_NUMBER( 2,"x"           ) obj->m_wCurX						= static_cast< WORD >( __number );
	_IF_GET_FIELD_NUMBER( 2,"y"           ) obj->m_wCurY						= static_cast< WORD >( __number );
	_IF_GET_FIELD_NUMBER( 2,"clickScript" ) obj->m_Property.m_wClickScriptID	= static_cast< WORD >( __number );
	_IF_GET_FIELD_NUMBER( 2,"dir"         ) obj->m_byDir						= static_cast< WORD >( __number );
	_IF_GET_FIELD_NUMBER( 2,"mType"       ) obj->m_Property.m_tType				= static_cast< BYTE >( __number );
	_IF_GET_FIELD_NUMBER( 2,"headID"      ) obj->m_Property.m_wHeadID			= static_cast< WORD >( __number );
	_IF_GET_FIELD_NUMBER( 2,"iconID"      ) obj->m_Property.m_byIconID			= static_cast< BYTE >( __number );

	if( obj->m_ParentArea )
		obj->m_ParentArea->SendAdj( obj->GetStateMsg(), sizeof(SASynNpcMsg), -1);

	LS_RET(0);
}
//check
// ��ȡNPC����
/**
	��������������
	��ѡ������6   controlID 	(����ָ������,��ָ����ʾ��ǰ����)
**/
static int L_CI_GetNpcData( lua_State *L )
{
	LS_CHKTOP(1);

	CNpc *obj = NULL;
	GET_NPC( L , 1 );

	WORD wIndex = static_cast<WORD>(lua_tonumber(L, 1 ));
	switch( wIndex )
	{
	// �Ƿ�ɱ��ɼ�
	case 1:
		lua_pushnumber(L, obj->IsCollected() );
		break;
	default:
		LS_CHKRET(0);
	}
	LS_CHKRET(1);
}
// check
// ���ö�̬����ɾ��ģʽ
/**
	����������gid   �Ƿ��Զ�ɾ��(��0���� �Զ�ɾ��,����Ϊ�ֶ�ɾ��)
**/
static int L_CI_SetDRDelMode( lua_State *L )
{
	LS_CHKTOP(2);

	DWORD gid = (DWORD)lua_tonumber(L, 1 );
	CDynamicRegion *dr = (CDynamicRegion *)FindRegionByGID( gid )->DynamicCast(IID_DYNAMICREGION);
	if( !dr ) LS_CHKRET(0);
	dr->m_bAutoDelete = (bool)lua_tonumber(L,2);
	LS_RET(0);
}
// check
// ��ȡ��̬��������б�
/**
	����������gid
**/
static int L_CI_SendDRPlayerList( lua_State *L )
{
	LS_CHKTOP(1);

	CPlayer *obj = g_Script.m_pPlayer;

	DWORD gid = (DWORD)lua_tonumber(L, 1 );
	CDynamicRegion *dr = (CDynamicRegion *)FindRegionByGID( gid )->DynamicCast(IID_DYNAMICREGION);
	if( !dr ) LS_CHKRET(0);

	SASendDRPlayerList msg;
	msg.count = 0;
	try
	{
		lite::Serializer slm( msg.streamData, sizeof( msg.streamData ) );
		check_list<LPIObject>::iterator iter = dr->m_PlayerList.begin();
		while ( iter != dr->m_PlayerList.end() && msg.count <= 30 )
		{
			if( CPlayer *p = (CPlayer *)(*iter)->DynamicCast(IID_PLAYER) ){
				slm( p->GetName() );
				msg.count ++;
			}
			iter ++;
		}

		g_StoreMessage( obj->m_ClientIndex , &msg , (int)(sizeof(msg) - slm.EndEdition()) );
	}
	catch ( lite::Xcpt & )
	{
		LS_CHKRET(0);
	}
	LS_RET(0);
}

static int L_TI_TestWPR( lua_State *L )
{
	LS_CHKTOP(1);
	LS_RET(0);
}

BOOL CScriptManager::RegisterFunc()
{
	//base
	RegisterFunction("rfalse", L_rfalse);
	RegisterFunction("rint", L_rint);
	RegisterFunction("GetCurTimeA", L_getcurtimeA);
	RegisterFunction("GetServerTime", L_GetServerTime);
	RegisterFunction("GetUseLogDBId", L_GetUseLogDBId);

	//system
	RegisterFunction("CI_SendSystemMail", L_CI_SendSystemMail );

	//items
	RegisterFunction("GiveGoodsBatch", L_GiveGoodsBatch);
	RegisterFunction("GiveGoods", L_giveGoods);
	RegisterFunction("CheckGiveGoods", L_CheckGiveGoods);
	RegisterFunction("CheckGoods", L_checkgoods);
	RegisterFunction("GetItemNum", L_getitemnum);
	RegisterFunction("isFull", L_isfull);
	RegisterFunction("isFullNum", L_isFullNum);
	RegisterFunction("CI_PayPlayer", L_CI_PayPlayer);
	RegisterFunction("CI_DelItemByPos", L_CI_DelItemByPos);

	//player's datas
	RegisterFunction("CI_GetPlayerData", L_CI_GetPlayerData);
	RegisterFunction("CI_SetPlayerData", L_CI_SetPlayerData);

	//player's action
	RegisterFunction("Stand", L_Stand);
	RegisterFunction("CI_GetCapability", L_CI_GetCapability);
	RegisterFunction("CI_MovePlayer", L_CI_MovePlayer);
	RegisterFunction("CI_SetPlayerIcon", L_CI_SetPlayerIcon);
	RegisterFunction("CI_GetPlayerIcon", L_CI_GetPlayerIcon);
	RegisterFunction("CI_SetReadyEvent", L_CI_SetReadyEvent );
	RegisterFunction("CI_CancelReadyEvent", L_CI_CancelReadyEvent);
	RegisterFunction("CI_AddMulExpTicks", L_CI_AddMulExpTicks);
	RegisterFunction("GetCurPlayerWallow", L_GetCurPlayerWallow);
	RegisterFunction("CI_OpenPackage", L_CI_OpenPackage);
	RegisterFunction("CI_OnSelectRelive", L_CI_OnSelectRelive);
	RegisterFunction("SetCamp",L_SetCamp);
	RegisterFunction("checkYuanbao",L_checkYuanbao);

	RegisterFunction("CI_LearnSkill"	,L_CI_LearnSkill	);//check
	RegisterFunction("CI_GetSkillLevel"	,L_CI_GetSkillLevel	);//check
	RegisterFunction("CI_SetSkillLevel"	,L_CI_SetSkillLevel	);//check

	RegisterFunction("GetRidingMountId", L_GetRidingMountId);

	//region
	RegisterFunction("CI_CreateRegion", L_CreateRegion);
	RegisterFunction("SetRegionPKType", L_setregionpktype);

	//monster
	RegisterFunction("KillMonster", L_KillMonster);
	RegisterFunction("CI_MoveMonster", L_CI_MoveMonster);

	//team
	RegisterFunction("GetTeamInfo", L_GetTeamInfo);
	RegisterFunction("GetTeamLeaderSID", L_GetTeamLeaderSID);
	RegisterFunction("GetCertainTeamInfo", L_GetCertainTeamInfo);
	RegisterFunction("IsTeamLeader", L_IsTeamLeader);
	//����
	RegisterFunction("AskJoinTeam", L_AskJoinTeam);						//���뷿��
	RegisterFunction("DeleteTeamMember", L_DeleteTeamMember);			//�Ƴ����䣨�����뿪�����ˣ��ӳ��뿪�򷿼��ɢ��

	//marrow
	RegisterFunction("GetMarrowInfo", L_GetMarrowInfo );
	RegisterFunction("GetRegionInfo", L_GetRegionInfo );

	//cs
	RegisterFunction("LockPlayer", L_LockPlayer);
	RegisterFunction("UnLockPlayer", L_UnLockPlayer);
	RegisterFunction("GetCurCopyScenesGID", L_GetCurCopyScenesGID);
	RegisterFunction("CreateGroundItem", L_CreateGroundItem);

	//buff
	RegisterFunction("CI_AddBuff",L_CI_AddBuff);
	RegisterFunction("CI_DelBuff",L_CI_DelBuff);
	RegisterFunction("CI_HasBuff",L_CI_HasBuff);
	RegisterFunction("SetCostumeBuff", L_SetCostumeBuff);
	RegisterFunction("IsCostume", L_IsCostume);
	RegisterFunction("GetCostumeID", L_GetCostumeID);

	//event
	RegisterFunction("CI_AddMonsterHPEvent",L_CI_AddMonsterHPEvent);
	RegisterFunction("CI_AddMonsterAttackCountEvent",L_CI_AddMonsterAttackCountEvent);
	RegisterFunction("CI_RemoveMonsterHPEvent",L_CI_RemoveMonsterHPEvent);
	RegisterFunction("CI_AddMonsterBuffBeginEvent",L_CI_AddMonsterBuffBeginEvent);
	RegisterFunction("CI_AddMonsterBuffEndEvent",L_CI_AddMonsterBuffEndEvent);

	//mark
	RegisterFunction("GetTaskMask", L_GetTaskMask);
	RegisterFunction("SetTaskMask", L_SetTaskMask);
	RegisterFunction("SendTaskMask", L_SendTaskMask);

	//datas
	RegisterFunction( CI_SendLuaMsg             );

	//tools
	RegisterFunction( RandomInt					);
	RegisterFunction( IsValidName               );

	//global
	RegisterFunction( GetGroupID				);
	RegisterFunction( CI_SetEnvironment         );
	RegisterFunction( GetServerName             );
	RegisterFunction( GetServerID				);

	//faction
	RegisterFunction( CI_CreateFaction			);
	RegisterFunction( CI_DeleteFaction			);
	RegisterFunction( CI_JoinFaction			);
	RegisterFunction( CI_LeaveFaction			);
	RegisterFunction( CI_SetMemberInfo			);
	RegisterFunction( CI_GetMemberInfo			);
	RegisterFunction( CI_GetFactionInfo			);
	RegisterFunction( CI_SetFactionInfo			);
	RegisterFunction( CI_GetFactionLeaderInfo	);
	RegisterFunction( ReplaceFactionLeader		);
	RegisterFunction( CI_ClearFriendFaction		);
	RegisterFunction( CI_GetTopFactionID		);

	//relation
	RegisterFunction( SetSpouse					);
	RegisterFunction( DelSpouse					);
	RegisterFunction( GetFriendDegree			);
	RegisterFunction( AddDearDegree				);
	RegisterFunction( CI_SetRelation			);
	RegisterFunction( CI_GetRelation			);
	RegisterFunction( CI_AddEnemy				);

	//active
	RegisterFunction( CI_AreaAddExp				);
	RegisterFunction( CI_GetPKList				);


	//overdb
	RegisterFunction( CI_EnterSpanServer		);
	RegisterFunction( CI_SendSpanMsg			);

	//tuoguan
	RegisterFunction( CI_GetPlayerBaseData		);
	RegisterFunction( CI_GetPlayerTSData		);

	//special handle
	RegisterFunction( CI_RoleCreateInit			);

	//trace
	RegisterFunction( TRACE_BEGIN );
	RegisterFunction( TRACE_END );
	//objects
	RegisterFunction( CreateObjectIndirect      );
	RegisterFunction( RemoveObjectIndirect      );
	RegisterFunction( GetObjectUniqueId         );
	RegisterFunction( CI_SelectObject           );
	RegisterFunction( CI_GetCurPos				);
	RegisterFunction( CI_UpdateBuffExtra		);

	//monster
	RegisterFunction( GetMonsterData			);
	RegisterFunction( CI_UpdateMonsterData      );
	RegisterFunction( CI_DelMonster				);

	//npc
	RegisterFunction( CI_UpdateNpcData			);
	RegisterFunction( CI_GetNpcData				);
	RegisterFunction( CI_DelNpc					);

	//heros & mounts
	RegisterFunction( CI_OperateHero			);
	RegisterFunction( CI_OperateMounts			);

	//player
	RegisterFunction( ClearPackage		        );
	RegisterFunction( DGiveP					);
	RegisterFunction( GetPlayer                 );
	RegisterFunction( ClearByDay				);

	//items
	RegisterFunction( GetItemSetting            );
	RegisterFunction( GetItemDetails            );
	RegisterFunction( UpdateItemDetails         );
	RegisterFunction( GenerateItemDetails       );
	RegisterFunction( ModifyItem                );
	RegisterFunction( GetItemScripts            );
	RegisterFunction( UpdateItemScripts         );
	RegisterFunction( CI_UpdateScriptAtt		);
	RegisterFunction( CI_GetEquipDetails		);
	RegisterFunction( CI_UpdateEquipDetails		);
	RegisterFunction( PayEquipTime				);

	//region
	RegisterFunction( GetRegionPlayerCount		);
	RegisterFunction( CI_DeleteDRegion			);
	RegisterFunction( GetRegionRetPos			);
	RegisterFunction( SetRegionRetPos			);
	RegisterFunction( CI_InitRegionLimit        );
	RegisterFunction( SetRegionMultExp          );
	RegisterFunction( CI_SetDRDelMode           );
	RegisterFunction( CI_SendDRPlayerList		);

	//traps
	RegisterFunction( SetTrap					);

	//events
	RegisterFunction( SetEvent                  );
	RegisterFunction( ClrEvent                  );

	//test
	RegisterFunction( TI_TestWPR				);

	return TRUE;
}


SetRegionMultExp(regionid,4,camp)// ���ó�����Ӫ����
CI_GetRegionInfo(regionid,1)     // ��ȡ������Ӫ����

