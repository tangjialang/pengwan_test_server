--[[
cextΪ��Ϸͨ�ù��ܵ���չ���
δ��װΪmodule���ļ���ʱ��dofile
��װ�����require����
����si������ڸ�������ģ��������չ
Ŀǰ������
cext.tool		���ߺ�����
cext.define 	ȫ�ֶ����
cext.dbrpc  	�洢���̽ӿڿ�
cext.tip 		ͨ����ʾ��Ϣ��
cext.mail 		�ʼ��ӿڿ�
cext.PI 		lua�ڲ��ṩ�����ڷ�װCI�ӿڻ����ṩ��ȫ�ֵ��õĽӿڿ�
cext.SI 		lua�ṩ��c���õĽӿڿ�
cext.award 		ͨ�ý�����
cext.cehua		�߻��ӿڿ�
]]--
dofile("cext\\tip.lua")
dofile("cext\\mail_Conf.lua")
dofile("cext\\mail.lua")
dofile("cext\\PI.lua")
dofile("cext\\SI.lua")

dofile("cext\\award.lua")
dofile("cext\\cehua.lua")
dofile('cext\\damage.lua')
dofile('cext\\dyn_drop.lua')


require('Script.cext.define')
require('Script.cext.tool')
require('Script.cext.dbrpc')