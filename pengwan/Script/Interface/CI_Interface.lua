--[[
	C�����ӿ�˵���ĵ�
]]--

--[[
	��ȡ��һ�����Ϣ: 
		CI_GetPlayerBaseData(sid, type) 
			@type: 	[nil]����λ�� { ���֣��ȼ���vip�����ͣ�������ͷ�� }
					[1] ͵Ϯ { ���֣��ȼ���vip�����id��ս������ͷ�� } --ͨ����/ׯ԰���
					[2] ��һ������� { ���֣��ȼ���vip�����ͣ����������id��ս������ͷ�� }	
]]--

--[[
	��ȡ���ս���й����ݣ�C++���֣�():
		 CI_GetPlayerTSData(sid)
		{
			{ ���֣��ȼ���vip�����ͣ����������id��ս������ͷ��}��
			{13����������}��
			{{id}��{level}}��
		}
		imageID ����
		headID ����
		byBossType ͷ�� 
]]--

--[[
	��������: 
		CI_CreateRegion(sid, regionType, Manual) 
			@regionType�� [0] ��ͨ���� [-1] ��ͨ��̬���� [> 0] ��������GID
			@Manual�� [0] �Զ�������ɾ�� [1] �ֶ�������ɾ��			
]]--

--[[
	ɾ������: 
		CI_DeleteDRegion(gid,removePlayer,desRegionID,desX,desY) 
			@gid������GID
			@removePlayer���Ƿ��Ƴ����,
			@desRegionID��Ŀ�곡��id
			@desX��Ŀ��x
			@desY��Ŀ��y
			
			@return��[-1] �Ҳ����ö�̬����  [-2] �������Ϊ�����ֶ�ɾ�� 
					 [-3] �����������Ϊ0	[-4] �������̴����Ķ�̬���������ֶ��Ƴ���� 		
]]--

--[[
  �������ƣ�CI_SetPlayerIcon
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


�ﳬ 11:55:35
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

 CI_SetPlayerIcon �ɹ�����true ���󷵻�nil
CI_GetPlayerIcon ���󷵻�-1
]]--

--[[
CreateGroundItem(����id ����gid ����id ���߸��� ����x ����y icount ����gid ���� ǿ���ȼ�)
icount: �ۼ�ֵ
]]--