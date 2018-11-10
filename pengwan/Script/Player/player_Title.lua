--[[
file:	Title_conf.lua
desc:	title config(S&C)
author:	chal
update:	2011-12-15
version: 1.0.0
refix: done by chal
]]--
--------------------------------------------------------------------------
--include:
local ipairs,type,rint= ipairs,type,rint
local ScriptAttType = ScriptAttType
local SendLuaMsg,GetServerTime = SendLuaMsg,GetServerTime
local CI_GetPlayerData,CI_SetPlayerIcon = CI_GetPlayerData,CI_SetPlayerIcon
local Title_Data = msgh_s2c_def[15][13]
local Title_Set = msgh_s2c_def[15][14]

--------------------------------------------------------------------------
--data:
local tidlist = {0,0,0,0}

local TitleList = {		-- �ƺ������ƺ���ԴID(����ԴID��0)��������,	��ȡ����
	[1] = {'ϵͳָ��Ա',1,nil,'ϵͳָ��Աר�óƺ�'},
	[4] = {'ֻ������',4,{[7] = 50},'ʹ�õ��ߺ���'},
	[5] = {'һ����ʦ',5,{[8] = 50},'ʹ�õ��ߺ���'},
	[6] = {'�������',6,{[5] = 50},'ʹ�õ��ߺ���'},
	[7] = {'��ʿ��˫',7,{[6] = 50},'ʹ�õ��ߺ���'},
	[8] = {'�˲�����',8,{[1] = 500},'ʹ�õ��ߺ���'},
	[9] = {'��������',9,{[3] = 100},'ʹ�õ��ߺ���'},
	[10] = {'���µ�һׯ',10,{[9] = 50},'ʹ�õ��ߺ���'},
	[11] = {'��������',11,{[1] = 1000},'ʹ�õ��ߺ���'},
	[12] = {'һ��ǧ��',12,{[1] = 1000},'ʹ�õ��ߺ���'},
	--[13] = {'���֮��',13,nil,'���칬���ԡ�����������е�һ\nʱЧ��һ��'},
	[14] = {'��֮����',14,{[1] = 50},'ʹ�õ��ߺ���',},
	--[15] = {'�֮��',15,nil,'������㡱����������е�һ\nʱЧ��һ��'},
	[16] = {'ʥ���ػ�',16,{[1] = 50},'ʹ�õ��ߺ���',},
	--[17] = {'������',17,nil,'��ˮ��������ʤ���������е�һ'},
	--[18] = {'���г�',18,nil,'��ˮ��������ʤ����������2-10'},
	[19] = {'�ݺ��޵�',19,nil,'������ᱦ������������е�һ\nʱЧ��һ��'},
	[20] = {'߳��ɳ��',20,nil,'������ᱦ�������������2-10\nʱЧ��һ��'},
	[21] = {'��ս����',21,nil,'�����ս�����������е�һ�İ�����г�Ա\nʱЧ��һ��'},
	[22] = {'�������',22,nil,'��������������������е�һ\nʱЧ��һ��'},
	[23] = {'�ѷ����',23,nil,'���������������������2-10\nʱЧ��һ��'},
	[24] = {'������˧',24,nil,'�������������е�һ���У�\nʱЧ��һ��'},
	[25] = {'Ӣ������',25,nil,'��������������2-10���У�\nʱЧ��һ��'},
	[26] = {'��������',26,nil,'�������������е�һ��Ů��\nʱЧ��һ��'},
	[27] = {'������',27,nil,'��������������2-10��Ů��\nʱЧ��һ��'},
	--[28] = {'����쳾',28,{[6] = 500},'��ɡ�����쳾�������гɾ���'},
	--[29] = {'��ͨС��',29,{[9] = 1000},'��ɡ���ͨС�ɡ������гɾ���'},
	--[30] = {'����Զ��',30,{[7] = 2000},'��ɡ�����Զ���������гɾ���'},
	--[31] = {'������˫',31,nil,'��ɡ�������˫ �������гɾ���'},
	[32] = {'��������',32,nil,'���������һ���ɻ��\nʱЧ��һ����'},
	[33] = {'��Ϸ����',33,{[1] = 100},'ʹ�õ��ߺ���'},
	--[34] = {'������',34,nil,'ռ�����ǵİ���Ա�ɻ��'},
	[35] = {'��ȫ��ʿ',35,{[1] = 10},'ʹ�õ��ߺ���',plat ='SL'},
	[36] = {'��ȫӢ��',36,{[1] = 20},'ʹ�õ��ߺ���',plat ='SL'},
	[37] = {'��ȫս��',37,{[1] = 30},'ʹ�õ��ߺ���',plat ='SL'},
	[38] = {'��ȫ����',38,{[1] = 50},'ʹ�õ��ߺ���',plat ='SL'},
	[39] = {'����',39,nil,'ռ�����ǵĳ������Ի�øóƺ�'},
	[40] = {'��ħ����',40,nil,'ʹ�õ��ߺ���',plat ='SQ'},
	[41] = {'�»����',41,{[6] = 10},'����ż�����ܶȴﵽ500�󣬿����ڡ��������ȡ'},
	[42] = {'�ٰ���ü',42,{[6] = 50},'����ż�����ܶȴﵽ3000�󣬿����ڡ��������ȡ'},
	[43] = {'����֮��',43,{[6] = 100},'����ż�����ܶȴﵽ10000�󣬿����ڡ��������ȡ'},
	[44] = {'��ͷ����',44,{[6] = 200},'����ż�����ܶȴﵽ30000�󣬿����ڡ��������ȡ'},
	[45] = {'���ɾ���',45,{[6] = 500},'����ż�����ܶȴﵽ60000�󣬿����ڡ��������ȡ'},
	[46] = {'��ս��Ӣ',46,{[7] = 100},'ʹ�õ��ߺ���'},
	[47] = {'����Ϸ��37.com',47,{[1] = 50},'ʹ�õ��ߺ���',plat ='SQ'},
	[48] = {'�Ͷ�����',48,{[1] = 100},'ʹ�õ��ߺ���'},
	[49] = {'������',49,{[1] = 100},'ʹ�õ��ߺ���'},
	[50] = {'��ȫ����',50,{[1] = 10},'ʹ�õ��ߺ���',plat ='SL'},
	[51] = {'��ȫ׼��',51,{[1] = 20},'ʹ�õ��ߺ���',plat ='SL'},
	[52] = {'��ȫ����',52,{[1] = 30},'ʹ�õ��ߺ���',plat ='SL'},
	[53] = {'��ȫ����',53,{[1] = 40},'ʹ�õ��ߺ���',plat ='SL'},
	[54] = {'��ȫ����',54,{[1] = 50},'ʹ�õ��ߺ���',plat ='SL'},
	[55] = {'��������(��һ��)',55,{[1] = 3000},'��һ�조����֮ս���ĵ�һ��'},
	[56] = {'����֮��(��һ��)',56,{[1] = 2000},'��һ�조����֮ս���ĵڶ���'},
	[57] = {'���ս��(��һ��)',57,{[1] = 1000},'��һ�조����֮ս���ĵ�����'},
	[58] = {'����������',58,{[1] = 50},'ʹ�õ��ߺ���',plat ='KU'},
	[59] = {'������ǿ����',59,nil,'ʹ�õ��ߺ���',plat ='KU'},
	[60] = {'���´���',60,{[1] = 200},'���籭������ʹ�ø���ѫ���ڡ����ʻ���жһ�'},
	[61] = {'��֪����',61,{[1] = 300},'���籭������ʹ�ø���ѫ���ڡ����ʻ���жһ�'},
	[62] = {'��˵Ԥ�Ե�',62,{[1] = 400},'���籭������ʹ�ø���ѫ���ڡ����ʻ���жһ�'},
	[63] = {'�λ�����',63,{[1] = 500},'���籭������ʹ�ø���ѫ���ڡ����ʻ���жһ�'},
	[64] = {'��������(�ڶ���)',64,{[1] = 3000},'�ڶ��조����֮ս���ĵ�һ��'},
	[65] = {'����֮��(�ڶ���)',65,{[1] = 2000},'�ڶ��조����֮ս���ĵڶ���'},
	[66] = {'���ս��(�ڶ���)',66,{[1] = 1000},'�ڶ��조����֮ս���ĵ�����'},
    [67] = {'����',67,nil,'����ͭǮ���һ��������ʱЧһСʱ'},	
    [68] = {'���',68,nil,'����ͭǮ��ڶ���������ʱЧһСʱ'},
    [69] = {'����',69,nil,'����ͭǮ�������������ʱЧһСʱ'},
    [70] = {'�Ӿ�',70,nil,'����ͭǮ�������������ʱЧһСʱ'},
    [71] = {'�о�',71,nil,'����ͭǮ�������������ʱЧһСʱ'},

	--[100] = {'С��',0,{[8] = 10},'���Ŀ���һ�׶���������'},
	--[101] = {'����',0,{[6] = 20},'���Ŀ��ڶ��׶���������'},
	--[102] = {'����',0,{[5] = 50},'���Ŀ������׶���������'},
	--[103] = {'����',0,{[9] = 100},'���Ŀ����Ľ׶���������'},
	--[104] = {'���',0,{[4] = 500},'���Ŀ�����׶���������'},
	[105] = {'���˹�ũ',0,{[7] = 20},'��������ɫ�������ʱ���ʻ��'},
	[106] = {'�Ұ�Ů��',0,{[4] = 20},'������槼����ҡ�ʱ�����ʻ��.���Ҽ���Խ�ߣ�����Խ��.'},	
	[107] = {'�������',0,{[1] = 100},'�����ʱ��С���ʻ��'},
	[108] = {'�����ϳ�',0,{[1] = 100},'��ׯ԰�ٿ����ʱ����С���ʻ��.��ᵵ��Խ�ߣ�����Խ��.'},
	[109] = {'������Ҽ�',0,{[7] = 30},'�������ᱦ�ı��䣬С���ʻ��.���伶��Խ�ߣ�����Խ��.'},
	[110] = {'���˶�',0,{[9] = 30},'ÿ�����߳齱С���ʻ��.'},
	[111] = {'BOSSɱ��',0,{[3] = 30},'Ұ��BOSSС���ʵ���'},
	[112] = {'����ɱ��',0,{[3] = 10},'ɱ���һ��ؾ�1��ġ���Ӣ�֡���С���ʵ���'},
	[113] = {'ɭ��ɱ��',0,{[3] = 20},'ɱ���һ��ؾ�2��ġ���Ӣ�֡���С���ʵ���'},
	[114] = {'����ɱ��',0,{[3] = 30},'ɱ���һ��ؾ�3��ġ���Ӣ�֡���С���ʵ���'},
	[115] = {'�Ļ�ɱ��',0,{[3] = 40},'ɱ���һ��ؾ�4��ġ���Ӣ�֡���С���ʵ���'},
	[116] = {'��ѩɱ��',0,{[3] = 50},'ɱ���һ��ؾ�5��ġ���Ӣ�֡���С���ʵ���'},
	[117] = {'����ɱ��',0,{[3] = 60},'ɱ���һ��ؾ�6��ġ���Ӣ�֡���С���ʵ���'},
	[118] = {'��Ԩɱ��',0,{[3] = 70},'ɱ���һ��ؾ�7��ġ���Ӣ�֡���С���ʵ���'},
}

--------------------------------------------------------------------------
-- inner function:

-- ȡ�ƺ�����(����TaskData��������ݻ��ڸ���ʱ�Զ�ͬ����ǰ̨)
-- Ԥ����100���ƺ�(������ʱ����ƺŲ���Ԥ����С)
local function GetPlayerTitleDB(playerid)
	if playerid == nil or playerid == 0 then
		return
	end
	local titleData = GI_GetPlayerData( playerid , "title" , 300 )
	if titleData == nil then
		return
	end
	--look(tostring(titleData))
	return titleData
end

-- ����icon��ǰֵȡ sel
local function GetIconField(icon,itype,field,sel)
	if icon == 0 then
		return 0
	end
	if field == nil then
		return icon	
	end
	local ctp = rint(icon / (10^8))
	if itype ~= ctp then		-- �ж�����
		look('GetTempTitle itype erro')
		return 0
	end
	
	-- ֻ�ֳܷ� 1 2 4 8��
	if field ~= 1 and field ~= 2 and field ~= 4 and field ~= 8 then
		look('GetTempTitle field erro')
		return
	end
	if sel > field then
		look('GetTempTitle sel erro')
		return
	end
	local bits = 8 / field
	local val = rint(icon / (10 ^ ((sel - 1) * bits))) % (10 ^ bits)
	
	return val
end

-- ����icon sel = val
local function SetIconField(icon,itype,field,sel,val,opt)
	-- ֻ�ֳܷ� 1 2 4 8��
	if field ~= 1 and field ~= 2 and field ~= 4 and field ~= 8 then
		look('SetTempTitle field erro')
		return
	end
	if sel > field then
		look('SetTempTitle sel erro')
		return
	end
	local bits = 8 / field		-- ÿ�ε�λ��

	icon = itype * (10^8) + (icon % (10^8))		-- ��������(����)
	if opt == 0 then				-- ����sel feild
		local oldval = rint(icon / (10 ^ ((sel - 1) * bits))) % (10 ^ bits)
		oldval = oldval * (10 ^ ((sel - 1) * bits))
		icon = icon - oldval
		icon = icon + val * (10 ^ ((sel - 1) * bits))
	elseif opt == 1 then			-- ׷��sel feild				
		icon = icon + val * (10 ^ ((sel - 1) * bits))
	else
		return
	end
	return icon
end

--------------------------------------------------------------------------
-- interface:
------------------[�ƺ����]------------------
-- ���û�ȡ�ƺ�(ֻ����ӵ��ƺ��б���û��������ʾ)
function SetPlayerTitle(sid,titleID,tm)
	if sid == nil then
		sid = CI_GetPlayerData(17)
	end
	local titleData = GetPlayerTitleDB(sid)
	if titleData == nil then return end
	if TitleList[titleID] == nil then return end
	-- look(titleData)
	-- ʱЧ�Գƺ�һ�������������ԣ�����
	if tm and tm ~= 0 and TitleList[titleID][3] then
		return
	end
	local now = GetServerTime()
	if tm and now >= tm then
		SendLuaMsg( sid, { ids = Title_Set, opt = 1, res = 2, }, 10 )
		return
	end
	if titleData[titleID] == nil then
		local attr = GetRWData(1)
		-- ������
		if TitleList[titleID] and TitleList[titleID][3] and type(TitleList[titleID][3]) == type({}) then
			for k, v in pairs(TitleList[titleID][3]) do
				if type(k) == type(0) and type(v) == type(0) then
					attr[k] = (attr[k] or 0) + v
				end
			end
			PI_UpdateScriptAtt(sid,ScriptAttType.Title)
		end
		titleData[titleID] = tm or 0
		SendLuaMsg( sid, { ids = Title_Set, opt = 1, res =0, tid = titleID, tm = titleData[titleID] }, 10 )
	else
		if tm and tm > 0 then
			titleData[titleID] = tm
		end
		SendLuaMsg( sid, { ids = Title_Set, opt = 1, res = 1, }, 10 )
		return 1		-- ����ʹ��������������ֵ�ж��Ƿ�۳�����
	end
end

-- ��ȡ��ʱ�ƺ�
function GetTempTitle(sid,itype,sel)
	if sid == nil or itype == nil then return end
	local icon = CI_GetPlayerIcon(2,0,2,sid) 
	if icon == 0 then
		return 0
	end
	local val
	-- ����ս��(field == 2)
	if itype == 1 then
		val = GetIconField(icon,itype,2,sel)
	elseif itype == 2 then
		val = GetIconField(icon,itype,1,sel)
	end
	return val
end

-- ������ʱ�ƺ�(�Զ�����ֵ)
-- @opt: ��ԶεĲ��� [0] ����(����) [1] ����
-- @itype: �Ḳ��֮ǰ������ ���֧��40��[1 ~ 40](��8Ϊ�������Լ��ֶ�ʹ��)
--		[1] ����ս��������Ƭ������ն field == 2(��2��ÿ��4λ)  sel = 1 ��ն�� sel = 2 ������Ƭ��
--		[2] �������ǣ����־ field = 1 (һ��8λ) sel = 1 ��ʾǣ��
function SetTempTitle(sid,itype,sel,val,opt)
	if sid == nil or itype == nil or opt == nil then return end
	local icon = CI_GetPlayerIcon(2,0,2,sid)
	if itype < 1 or itype > 40 then
		look('SetTempTitle itype erro')
		return
	end
	local field
	if itype == 1 then			-- ����ս��(field == 2)
		if val > 99 then
			val = 99
		end		
		field = 2
	elseif itype == 2 then		-- ����ڳ�ǣ��(field == 1)
		if val > 99 then
			val = 99
		end 
		field = 1
	end
	-- ��������ת��Ϊ����(�����ֵ����)
	if opt == 1 then
		local oldval = GetIconField(icon,itype,field,sel) or 0
		val = val + oldval			
	end
	icon = SetIconField(icon,itype,field,sel,val,0)
	if icon then
		-- look('icon:' .. icon)
		CI_SetPlayerIcon(2,0,icon,1,2,sid)
	end
end

-- �����ʱ�ƺ�
function ClrTempTitle(sid)
	CI_SetPlayerIcon(2,0,0,1,2,sid)
end

-- �ӳƺ��б��Ƴ�
-- ���ڵ��߼�:�ж�����Ƴ����ǵ�ǰѡ����ʾ�ĳƺš���Ҫ���¸�C++
function RemovePlayerTitle(sid,titleID)
	if sid == nil then
		sid = CI_GetPlayerData(17)
	end
	if not IsPlayerOnline(sid) then
		return
	end
	local titleData = GetPlayerTitleDB(sid)
	if titleData == nil then return end
	if titleID then
		if titleData[titleID] then
			titleData[titleID] = nil
		else
			return
		end
	else
		for k, v in pairs(titleData) do
			if type(k) == type(0) then
				titleData[k] = nil
			end
		end
	end
		
	if titleID then
		local tid1,tid2,tid3,tid4 = CI_GetPlayerIcon(1,0,2,sid)
		tidlist[1] = tid1
		tidlist[2] = tid2
		tidlist[3] = tid3
		tidlist[4] = tid4
		if titleID == tid1 then
			tidlist[1] = 0
		elseif titleID == tid2 then
			tidlist[2] = 0
		elseif titleID == tid3 then
			tidlist[3] = 0
		elseif titleID == tid4 then
			tidlist[4] = 0
		end
		SetShowTitle(sid, tidlist)
	else
		SetShowTitle(sid, {0,0,0,0})
	end
	SendLuaMsg( sid, { ids = Title_Data, dt = titleData }, 10 )
end

function GetTitleAttr(sid)
	local titleData = GetPlayerTitleDB(sid)
	if titleData == nil then return end	
	-- �������Ա�	
	-- look('-----------------------')
	-- look(titleData)
	local attr = GetRWData(1)
	for tid, tm in pairs(titleData) do		-- ����Ҳ����һ��ʱЧ�ԳƺŲ��ܼ�����
		if type(tid) == type(0) and tm == 0 and TitleList[tid] and TitleList[tid][3] and type(TitleList[tid][3]) == type({}) then
			for k, v in pairs(TitleList[tid][3]) do
				if type(k) == type(0) and type(v) == type(0) then
					attr[k] = (attr[k] or 0) + v
				end
			end
		end
	end
	-- look(attr)
	return attr
end

-- ������Ҫ��ʾ�ĳƺ� tidList = ѡ���titleID �б�
function SetShowTitle(sid, tList)
	-- look('SetShowTitle')
	-- look(tList)
	if tList == nil or type(tList) ~= type({}) or #tList > 4 then return end
	if sid == nil then
		sid = CI_GetPlayerData(17)
	end
	local sicon = 0
	local titleData = GetPlayerTitleDB(sid)
	if titleData == nil then return end
	for k, tid in ipairs(tList) do
		if titleData[tid] then			-- ���ǰ̨�����������ݵĺϷ���
			sicon = sicon + rint(tid * math.pow(256,k-1))
		end
	end	
	-- look('sicon:' .. sicon)
	return CI_SetPlayerIcon(1,0,sicon,1,2,sid)	
end

-- ÿ������ʱ���ƺ�ʱЧ
-- �ƺŵ����������ܻ�ܴ������ж�������й��ڵĲŷ�����data��
-- ���ֻ�����ڵ�Ҳ���Ե��ǻ�������ʱ��
function checkTitleTime(sid)
	--look('checkTitleTime')
	local titleData = GetPlayerTitleDB(sid)
	if titleData == nil then return end
	local bsend = false
	local now = GetServerTime()
	local tid1,tid2,tid3,tid4 = CI_GetPlayerIcon(1,0,2,sid)
	tidlist[1] = tid1
	tidlist[2] = tid2
	tidlist[3] = tid3
	tidlist[4] = tid4
	-- look(tidlist)
	for tid, tm in pairs(titleData) do
		if type(tid) == type(0) and tm ~= 0 then
			-- look(tm)
			-- look(now)
			if tm < now then				
				if tid1 ~= -1 then
					if tid == tid1 then
						tidlist[1] = 0
						SetShowTitle(sid, tidlist)
					elseif tid == tid2 then
						tidlist[2] = 0
						SetShowTitle(sid, tidlist)
					elseif tid == tid3 then
						tidlist[3] = 0
						SetShowTitle(sid, tidlist)
					elseif tid == tid4 then
						tidlist[4] = 0
						SetShowTitle(sid, tidlist)
					end
				end
				titleData[tid] = nil
				bsend = true
			end
		end
	end
	-- look(titleData)
	if bsend then
		SendLuaMsg( sid, { ids = Title_Data, dt = titleData }, 10 )
	end
end