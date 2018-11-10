--[[
file:	Monster_Conf.lua
desc:	Monster created by script conf.
author:	chal
update:	2011-12-05
notes:
	1�����г����������ڹ��ﶼͳһ���������ű�����,��deadScriptΪkey�ۼ�
	2�����û��deadScript���Բ���������

��������:
	enum CAMP_DEFINE
	{
		CP_MONSTERFRIEND = 0,	// �����Ѻ���Ӫ�����
		CP_PLAYER1,				// �����Ӫ1
		CP_PLAYER2,				// �����Ӫ2	
		CP_PLAYER3,				// �����Ӫ3	
		CP_PLAYERFRIEND4,		// ����Ѻ���Ӫ �����
		CP_PLAYERENEMY5,		// ��ҵж���Ӫ1�����
		CP_PLAYERENEMY6,		// ��ҵж���Ӫ2�����	
		CP_MAX,
	};

��������˵��:
	@controlId  ���������ID(����������䣡����)
		������;��     1~99 
		{
			��ͬ��: ����ʾѪ��...
			[5 ~ 8] = ���ֺ��(�ҽ�)
			[9 ~ 12] = ��λ������(����AI�ҹ�)
			[13] = ����ս����
		}
		�ض����ܹ�	   1~99
		������		   100~9999
		��ֺ�BOSS   10000~ 99999
		Ұ���  	   100000����
	

	@deadScript   	  ���>=10000��ʬ��������   ���<10000��������
		[1,999] �������	
		{
			[1,7] ׯ԰��λ���Ӷ����
			[8] ����BOSS
		}
		[1000,3999] Ұ���
		[4000,9999] ����� ÿ���100�ֶ�
		{
			4000 ~ 4099		����ս��
			4100 ~ 4199		����
			4200			ץ��
			4201 ~ 4299		���ս
			4300			��ʯ����
			4301			����ڳ�
			4401 ~ 4499		��ṥ��ս
			4501 ~ 4599		���BOSS
			4600 ~ 4699		������������
			4900 ~ 4999		��������
		}
		--10000��������ʬ�����ص�
		14300--��ʯ��

	
	@eventScript   	���>1000 ����BOSS���ⴥ���¼�  
					��� [1,200] �ص�SI_OnClickMonster()
					{
						[1] �������
						[2] ��ᱦ��
						[3] ����ؾ�����
						[5] �칬����
						[6] �����
						.
						.
						.
						[10] ��Ḵ��ˮ��
					}
					��� [201,250] ǰ̨����
					{
						[201] = ��������
						[202]-槼�
						[203]�ڱ��̳Ǹ���
						[204]vip������ʬ��
						[205]���鸱���й�
						[206]����
						[207]������������
						[208]�����������
					}
	
	@moveScript 	���<10000 ����Ѳ�߹�			���> 10000 �ص� OnMonsterMove_xxx
	--17001 ~       ���ָ���
	--22001			������������
	
regionId ����ID
monsterId ����ID
objectType ��������
name ��������
imageID ͼ�����
headID  ͷ����
level   �ȼ�
school  ְҵ
camp    ��Ӫ   123 �����Ӫ�� 4 �Ѻ���Ӫ�� 56�ж���Ӫ
exp     Я������
money   Я����Ϸ��
bossType   BOSS����  0 ��BOSS  1 ͳ���˺���BOSS   2 ͳ���˺�������Ҫ�ű���������BOSS  4 �г��ϵͳ��BOSS  8 ������ʱ��Ʒ��BOSS  10 �����ǵ�BOSS��С�� 20 �������ǵ�BOSS����
aiType    ����AI����,0����AI  1���ɹ���AI  2�����ܻ�AI  4���ɷ���AI(���ת��)  8������AI  10��׷��AI  20��ר��AI  40�����AI  80�����AI (16����,Ҫת��Ϊ10����)
attackArea  ׷����Χ��8-16��  ������Χ���Զ�����
moveArea    �ƶ���Χ��4-8��   0 ���ǲ��ƶ���վ׮��
searchArea  ������Χ��5-10��  
atkSpeed    �����ٶ�(֡��)
dynDropID   ��̬����ID
refreshTime ˢ�¼��ʱ��֡�� 1��= 5֡�� 0��ʾ��ˢ��
deadbody ��ʬʱ��֡ �� 1��= 5֡�� 0��ʾ����ʬ
IdleTime     ��������֡,���ǹ��ﴴ���Ժ�,�����ж�,Ҳ���ܱ�����,��������֡��ſ�ʼ�����ж������ھ�������ʱ�͹��ﴴ����Чʱ�ȴ�     
x            ˢ������
y	     ˢ������	
dir          ˢ����Է���
mapIcon      �Ƿ��ڵ�ͼ������ʾ�ù�����綯̬ˢ�ĻBOSS��
refreshScript    ˢ�´����ű�      �������ܺ����� = SI_OnMonsterRefresh���
moveScript       �ƶ������ű�	   �������ܺ����� = SI_OnMonsterMove���
updateTick   ��ʱ����֡,��ô���һ��timeScript, ѭ������
timeScript       ��ʱ�����ű�      �������ܺ����� = SI_MonsterAIUpdate���    
deadScript       ���������ű�      �������ܺ����� = SI_OnMonsterDead���
eventScript      ע�����������ű���������Ѫ�����ȣ�
monAtt      13���������� {����,ŭ��,����,����,����,����,����,�ֿ�,��,�����˺�,���Է���,�����˺�,�ƶ��ٶ�} ���޸ĵ����Կ�����nil������,
skillID      8������ID,ͬ��     
skillLevel   8�����ܵȼ�,ͬ��
targetID     �ƶ�Ŀ���ID
targetX      �ƶ��ص������
targetY      �ƶ��ص������
BRMONSTER    �Ƿ�����ˢ�� 
centerX      ����ˢ�����꣨����ˢ,�Ͳ�����X��Y���ԣ�
centerY      ����ˢ������
BRArea       ����ˢ�·�Χ
BRNumber     ����ˢ�ĸ���
BRTeamNumber  ������,ˢ�µ����α��
 mapIcon = 1   ��ʾ��Ҫȫ����ͬ����Ϣ�Ĺ���(ͬ��Ѫ��)
Priority_Except ={ selecttype =  , type =  , target =  }   ����Ŀ��ѡ��
selecttype ��[ѡ������] 1.ֻ����Ŀ�� 2.������Ŀ�� 3 ���ȹ���Ŀ�� 
 type��[Ŀ������] 1,ĳ����Ӫ 2 ĳ������ 3 ĳ����� 4 ĳ������ 5 ���
 target������ǹ���,��д����controlId  ��������,�������������,��д���SID�����ĳ����ҡ�

 {monsterId = 1,deadbody = 30,IdleTime = 1}
 
 ���⺯�� ,������ﴥ���¼�
 SI_OnClickMonster

��̬�޸Ĺ�������
CI_UpdateMonsterData (type,...)
1: �������� ��������������Щ
2: ָ��������� - factonname
3��������ָ��һ����ʱ���� skillid lv ʹ�ô���


]]--

-- ���������������� KEY(deadScript) ��1000��ʼ��1000���������������
-- ע�⣺Ӧ�þ�����֤ key = deadScript
-- ע��: ������Ҫ����controlID������������д�����;������ʹ���ظ�cid����
MonsterConfList = 
{
	--[301] = {
		--{ name = 'Ұ��', monsterId = 2 ,controlId=302, movespeed = 110 ,   dir = 2, objectType = 0, aiType=4, refreshScript=0 ,  BRMONSTER = 1 , centerX = 53 , centerY = 22 , BRArea = 1 , BRNumber =3 ,Priority_Except ={ selecttype = 1 , type = 2 , target = 301 } ,targetID=301, },
		--{ name = '������',eventScript=1,controlId=301,x=54,y=17, monsterId = 1 , movespeed = 0 ,  dir = 6, objectType = 0, aiType=9, school = 4},
	--	},
	[1] = {
		{ monsterId = 5,level = 99,name = "Ѳ��ʿ��" , imageID = 2095,headID = 1011,x = 29 ,y = 111,targetX = 40 ,targetY = 100,camp = 4,controlId = 100150,moveScript=1101 },
		{ monsterId = 5,level = 99,name = "Ѳ��ʿ��" , imageID = 2095,headID = 1011,x = 31 ,y = 50,targetX = 16 ,targetY = 35,camp = 4,controlId = 100151,moveScript=1201 },
		{ monsterId = 5,level = 99,name = "Ѳ��ʿ��" , imageID = 2095,moveArea = 1,headID = 1011,x = 33 ,y = 52,targetID = 100151,camp = 4,controlId = 100156 },
		{ monsterId = 5,level = 99,name = "Ѳ��ʿ��" , imageID = 2095,moveArea = 1,headID = 1011,x = 34 ,y = 53,targetID = 100156,camp = 4,controlId = 100157 },
		{ monsterId = 5,level = 99,name = "Ѳ��ʿ��" , imageID = 2095,headID = 1011,x = 43 ,y = 31,targetX = 54 ,targetY = 42,camp = 4,controlId = 100152,moveScript=1301 },
		{ monsterId = 5,level = 99,name = "Ѳ�߹�" , imageID = 2096,headID = 1012,x = 81 ,y = 43,targetX = 98 ,targetY = 60,camp = 4,controlId = 100153,moveScript=1401 },
		{ monsterId = 5,level = 99,name = "Ѳ��ʿ��" , imageID = 2095,headID = 1011,x = 53 ,y = 156,targetX = 96 ,targetY = 113,camp = 4,controlId = 100154,moveScript=1501 },
		{ monsterId = 5,level = 99,name = "Ѳ��ʿ��" , imageID = 2095,moveArea = 1,headID = 1011,x = 55 ,y = 155,targetID = 100154,camp = 4,controlId = 100158 },
		{ monsterId = 5,level = 99,name = "Ѳ��ʿ��" , imageID = 2095,moveArea = 1,headID = 1011,x = 54 ,y = 157,targetID = 100158,camp = 4,controlId = 100159 },
		{ monsterId = 5,level = 99,name = "Ѳ�߹�" , imageID = 2096,headID = 1012,x = 74 ,y = 98,targetX = 64 ,targetY = 98,camp = 4,controlId = 100155,moveScript=1601 },
		{ monsterId = 5,level = 99,name = "Ѳ��ʿ��" , imageID = 2095,moveArea = 1,headID = 1011,x = 74 ,y = 97,targetID = 100155,camp = 4,controlId = 100160 },
		{ monsterId = 5,level = 99,name = "Ѳ��ʿ��" , imageID = 2095,moveArea = 1,headID = 1011,x = 74 ,y = 99,targetID = 100160,camp = 4,controlId = 100161 },
	},
	[3] = {
		{monsterId = 5,moveArea = 0 ,x = 62 ,y = 163,dir = 1 ,refreshTime = 1,deadbody = 6 ,controlId = 100101 },
		--{monsterId = 5,moveArea = 0 ,x = 63 ,y = 164,dir = 1 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 64 ,y = 165,dir = 1 ,refreshTime = 1,deadbody = 6 ,controlId = 100102},
		--{monsterId = 5,moveArea = 0 ,x = 65 ,y = 166,dir = 1 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 66 ,y = 167,dir = 1 ,refreshTime = 1,deadbody = 6 ,controlId = 100103},
		--{monsterId = 5,moveArea = 0 ,x = 67 ,y = 168,dir = 1 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 68 ,y = 169,dir = 1 ,refreshTime = 1,deadbody = 6 ,controlId = 100104},
		--{monsterId = 5,moveArea = 0 ,x = 68 ,y = 170,dir = 1 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 69 ,y = 172,dir = 1 ,refreshTime = 1,deadbody = 6 ,controlId = 100105},
		--{monsterId = 5,moveArea = 0 ,x = 70 ,y = 173,dir = 1 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 71 ,y = 174,dir = 1 ,refreshTime = 1,deadbody = 6 ,controlId = 100106},
		--{monsterId = 5,moveArea = 0 ,x = 72 ,y = 175,dir = 1 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 73 ,y = 176,dir = 1 ,refreshTime = 1,deadbody = 6 ,controlId = 100107},
		--{monsterId = 5,moveArea = 0 ,x = 74 ,y = 178,dir = 1 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 75 ,y = 179,dir = 1 ,refreshTime = 1,deadbody = 6 ,controlId = 100108},
		--{monsterId = 5,moveArea = 0 ,x = 76 ,y = 180,dir = 1 ,refreshTime = 1,deadbody = 3},
		
		
		{monsterId = 5,moveArea = 0 ,x = 67 ,y = 159,dir = 5 ,refreshTime = 1,deadbody = 6 ,controlId = 100109},
		--{monsterId = 5,moveArea = 0 ,x = 68 ,y = 160,dir = 5 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 69 ,y = 161,dir = 5 ,refreshTime = 1,deadbody = 6 ,controlId = 100110},
		--{monsterId = 5,moveArea = 0 ,x = 70 ,y = 162,dir = 5 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 73 ,y = 167,dir = 5 ,refreshTime = 1,deadbody = 6 ,controlId = 100111},
		--{monsterId = 5,moveArea = 0 ,x = 72 ,y = 166,dir = 5 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 71 ,y = 164,dir = 5 ,refreshTime = 1,deadbody = 6 ,controlId = 100112},
		--{monsterId = 5,moveArea = 0 ,x = 74 ,y = 169,dir = 5 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 75 ,y = 170,dir = 5 ,refreshTime = 1,deadbody = 6 ,controlId = 100113},
		--{monsterId = 5,moveArea = 0 ,x = 76 ,y = 171,dir = 5 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 77 ,y = 172,dir = 5 ,refreshTime = 1,deadbody = 6 ,controlId = 100115},
		--{monsterId = 5,moveArea = 0 ,x = 78 ,y = 173,dir = 5 ,refreshTime = 1,deadbody = 3},
		{monsterId = 5,moveArea = 0 ,x = 79 ,y = 175,dir = 5 ,refreshTime = 1,deadbody = 6 ,controlId = 100114},

	},
}

-- ���������������ׯ԰ս����� �й���һ����
-- ע�⣺Ӧ�þ�����֤ key = deadScript
-- ע��: ������Ҫ����controlID������������д�����;������ʹ���ظ�cid����
PlayerMonsterConf = {
	-- ׯ԰��λ�����ط�����
	[1] = {monsterId = 1,controlId = 9,deadbody = 30,IdleTime = 15,objectType = 0,deadScript = 1,aiType = 71},	
	-- ׯ԰�Ӷ���ط�����
	[2] = {monsterId = 2,deadbody = 30,IdleTime = 15,objectType = 0,deadScript = 2,aiType = 71},	
	-- ׯ԰�Ӷ���ط����
	[3] = {monsterId = 3,deadbody = 30,IdleTime = 15,objectType = 0,deadScript = 3,aiType = 135}, 
	-- ׯ԰�Ӷṥ�������
	[4] = {monsterId = 3, deadbody = 30,IdleTime = 15,objectType = 0,deadScript = 4,aiType = 151},	
	-- ����ׯ԰��ӹ���
	[5] = {monsterId = 3,moveArea = 0, deadbody = 30,IdleTime = 5,objectType = 0,deadScript = 5,aiType = 151},
	-- ׯ԰�Ӷ���ط�����
	[6] = {monsterId = 3, deadbody = 30,IdleTime = 5,objectType = 0,deadScript = 6,aiType = 135}, 
	-- ׯ԰��λ������������
	[7] = {monsterId = 1,controlId = 10,deadbody = 30,IdleTime = 15,objectType = 0,deadScript = 7,aiType = 71},
	-- ׯ԰��λ�����������
	[8] = {monsterId = 3,controlId = 11,deadbody = 30,IdleTime = 15,objectType = 0,deadScript = 7,aiType = 135},
	-- ׯ԰��λ�����ط����
	[9] = {monsterId = 3,controlId = 12,deadbody = 30,IdleTime = 15,objectType = 0,deadScript = 1,aiType = 135},
	-- [8] �Ǹ�����BOSS�õ� ���ﲻҪ��!!!!!
	
}

BuffMonsterConf ={
   -- ��ʦ�ٻ�
	[1] = {monsterId = 89,objectType = 0,IdleTime = 30,aiType = 769},	
   -- ��������
	[2] = {monsterId = 613,objectType = 0,IdleTime = 30,aiType = 513},	 
   -- �ٻ�����
	[3] = {monsterId = 614,objectType = 0,IdleTime = 30,aiType = 1539},	
   -- ���Ļ�ʿ
	[4] = {monsterId = 615,objectType = 0,IdleTime = 30,aiType = 1539},	

}


