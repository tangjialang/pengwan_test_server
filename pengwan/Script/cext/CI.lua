--[[
file:	CI_interface_info.lua
desc:	only info for CI_ function
author:	all
update:	2013-7-16

α������������
[1] �����ؼ��� �� cifuncinfo(��'function'����)
[2] a1 ���̶���Ҫ����Ĳ���һ
[3] b1 : ����Ҫ����Ŀɱ����һ
[4] @  : ע��
[5] �� : ��Ҫע�������
----------------------------------------
@ѡ��������Ҫ�����Ķ���
���ű���Ҫָ����������ʱ����Ҫ����ԭ���󣬲�����ɺ���ػָ�Ϊԭ����
cifuncinfo CI_SelectObject(a1,b1,b2) 
	if a1 == 0 then
		@��ǰ���
	elseif a1 == 1 then
		b1 = number@���GID
		@GID��Ӧ�����
	elseif a1 == 2 then
		b1 = number@���SID
		@SID��Ӧ�����
	elseif a1 == 3 then
		@��ǰ����
	elseif a1 == 4 then
		b1 = number@����GID
		b2 = number@��̬������ͼid���߶�̬����gid or nil@������ڳ���
		@GID��Ӧ�Ĺ���
	elseif a1 == 5 then
		b1 = number@NPCGID
		b2 = number@��̬������ͼid���߶�̬����gid or nil@������ڳ���
		@GID��Ӧ��NPC
	elseif a1 == 6 then
		b1 = number@�����NPC��CID
		b2 = number@��̬������ͼid���߶�̬����gid or nil@������ڳ���
		@CID��Ӧ�Ĺ����NPC
	end
	return -101@ѡ���������ʧ�� or -102@���󲻷�
end
@�����ӿ���Ҫָ������ʱ��ͨ�øò��������ڹ̶��������棨������"..."��ʾ��������ָ����������
----------------------------------------
----------------------------------------
cifuncinfo CI_UpdateNpcData(a1,a2,...)
	if a1 == 1 then
		a2 = {imageId,x,y,clickScript,dir,mType,headID,iconID} 
	elseif a1 == 2 then
		a2 = true@�ɼ� or false@δ�ɼ�
	end
	return nil@ʧ�� or true@�ɹ�
end
----------------------------------------
----------------------------------------
cifuncinfo CI_GetNpcData(a1,...)
	if a1 == 1 then
		return 1@�ɼ� or 0@δ�ɼ�
	end
end
----------------------------------------
----------------------------------------
cifuncinfo GetMonsterData(a1,...)
	if a1 == 1 then
		return ����ȼ�
	elseif a1 == 2 then
		return ����ID
	elseif a1 == 3 then
		return ��������
	elseif a1 == 4 then
		return ����Я������
	elseif a1 == 5 then
		return ����Я��ͭǮ
	elseif a1 == 6 then
		return ���ﵱǰѪ��
	elseif a1 == 7 then
		return �������Ѫ��
	elseif a1 == 8 then
		return ���ﵱǰ����x,y
	elseif a1 == 9 then
		return ����������� or nil
	elseif a1 == 23 then
		return ����GID,copysceneGID
	elseif a1 == 26 then
		return �������ڳ���ID
	end
end
----------------------------------------
----------------------------------------
cifuncinfo CI_SetPlayerIcon(a1,a2,a3,a4,...)
���ܣ��������ͼ�� 
�������� >=4
����˵����
arg1���������͡�
0 - ϵͳͼ��
1 - �ű�����ͼ�꣨�ƺţ���ʽ�ɽű��Զ�����8λһ���ƺţ������֧��4���ƺţ���
2 - �ű���ʱͼ�꣨������ʱͼ����ʾ��ͬʱֻ����һ���������λ��ʾ��ʾ�Ĺ������ͣ�ʣ��31λ��ʾ��ֵ��

arg2��not care when arg1 != 0 

arg3����ֵ

arg4���Ƿ�ͬ����ǰ̨��OnPlayerLogin�е���ʱ������ǰ̨��

�������vip��ʶ��
CI_SetPlayerIcon��0��0��arg3 ,arg4��
����ս�������гƺ�
CI_SetPlayerIcon��0��1��arg3 ,arg4��

CI_SetPlayerIcon �ɹ�����true ���󷵻�nil
CI_GetPlayerIcon ���󷵻�-1

�������ƣ�CI_GetPlayerIcon
���ܣ�������ͼ�� 
�������� >=2
����˵����
arg1�����͡�
0 - ϵͳͼ��
1 - �ű�����ͼ�꣨�ƺţ�
2 - �ű���ʱͼ��
arg2��not care when arg1 != 0 

������vip��ʶ��
CI_GetPlayerIcon��0��0��

------------------------------------------------------------
------------------------------------------------------------
cifuncinfo CI_UpdateMonsterData (a1,a2,a3,a4...)
	if a1 == 1 then
		a2 = �������ñ�
		a3=1Ϊǿ�Ƹ���
	elseif a1 == 2 then
		a2 = �������
	elseif a1 == 3 then
		a2 = ���＼��ID
		a3 = ���＼�ܵȼ�
		a4 = ��������
	elseif a1 == 4 then
		a2 = ����sid
	end
end
	1: �������� �������ǹ������ñ�
	2: ָ��������� - factonname
	3��������ָ��һ����ʱ���� skillid, count(������������)
	4: ������ָ������

CI_MoveMonster(x,y,0,3)  �ƶ���x,y, ����3λΪ1ʱ�ƶ���������,3Ϊ��ǰ��

----------------------------------------
]]--
