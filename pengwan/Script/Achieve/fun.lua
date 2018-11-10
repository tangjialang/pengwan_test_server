--[[
�ɾ͡���Ծ��Ŀ��
author:	xiao.y
update:	2013-7-8
]]--
--------------------------------------------------------------------------
--include:
local __G = _G
local pairs = pairs
local look = look
local EveryDay_Actibe_msg = msgh_s2c_def[13][1]
local SendLuaMsg = SendLuaMsg
local isFullNum,GiveGoods,GiveGoodsBatch = isFullNum,GiveGoods,GiveGoodsBatch
local math_floor = math.floor
local SetTaskMask = SetTaskMask
local GetTaskMask = GetTaskMask
local type = type
local CI_GetPlayerData = CI_GetPlayerData
local DGiveP = DGiveP
local RPC = RPC
local TipCenter = TipCenter
--------------------------------------------------------------------------
--module:
module(...)

--------------------------------------------------------------------------
--��Ծ����
local FunConf = {
	active = {
	[1] = { --index=ǰ̨��ʾ����, val �ӵĻ�Ծֵ info ��Ծ
		[28] = {index=1,val = 5,times = 1, info = "<font color='#fff3ca'>����ǩ��</font><font color='#feff97'>����Ʒ</font>��������<font color='#00ff2a'><a href='event:day.DDayPanel 0'><u>ǩ��</u></a></font>",tip = "ÿ��ǩ�������Ի�á�"},		
		[23] = {index=2,val = 5 ,times = 1, info = "<font color='#fff3ca'>���齱</font><font color='#feff97'>����Ʒ</font>��������<font color='#00ff2a'><a href='event:faction.DFactionPanel 0'><u>�齱</u></font>",tip = "���齱�����������ﹱ�����ʻ��������."},
		[35] = {index=3,val = 5 ,times = 1, info = "<font color='#fff3ca'>���ᱦ</font><font color='#feff97'>����Ʒ</font>��������<font color='#00ff2a'><a href='event:faction.DFactionPanel 0'><u>�ᱦ</u></font>",tip = "���ᱦ��ȫ����룬��˭�����������."},		
		[43] = {index=4,val = 5,times = 1, info = "<font color='#fff3ca'>ͭǮ����</font><font color='#ffdb5d'>��ͭǮ</font>��������<font color='#00ff2a'><a href='event:move 1 56 66 59'><u>ǰ��</u></a></font><font color='#f6ff00'><a href='event:trans move 1 56 66 59'>{��}</a></font>",tip = "ͭǮ�����У�ÿ������ֶ������һ�����䣬װ����ͭǮ��"},
		[18] = {index=5,val = 5,times = 1, info = "<font color='#fff3ca'>��ʯ�ɽ�</font><font color='#ffdb5d'>��ͭǮ</font>��������<font color='#00ff2a'><a href='event:active.DAddMoney'><u>���</u></a></font>",tip = "������Ʒ�ɣ����ֱ���������׬����"},
		
		
		[21] = {index=9,val = 5,times = 1, info = "<font color='#fff3ca'>��������</font><font color='#ff6f20'>��ս����</font>������<font color='#00ff2a'><a href='event:horse.DHorsePanel 0'><u>����</u></a></font>",tip = "�������׿��Կ������ս��������ÿ����1����Ѵ�����"},		
		[6]  = {index=10,val = 5,times = 5, info = "<font color='#fff3ca'>��������</font><font color='#00ff84'>������</font>��������<font color='#00ff2a'><a href='event:move 1 70 62 50'><u>ǰ��</u></a></font><font color='#f6ff00'><a href='event:trans move 1 70 62 50'>{��}</a></font>",tip = "�������ƴ����Խ�����������"},
		[25] = {index=11,val = 5,times = 1, info = "<font color='#fff3ca'>��������</font><font color='#00ff84'>������</font>��������<font color='#00ff2a'><a href='event:move 1 85 77 53'><u>ǰ��</u></a></font><font color='#f6ff00'><a href='event:trans move 1 85 77 53'>{��}</a></font>",tip = "�ʱ����ɻ��ͻ��ø������档"},
		
		
		[11] = {index=14,val = 5,times = 3, info = "<font color='#fff3ca'>ׯ����λ</font><font color='#90ff00'>������</font><font color='#feff97'>��Ʒ</font>����<font color='#00ff2a'><a href='event:home.DQualifyingPanel'><u>��ս</u></a></font>",tip = "��λԽ�ߣ�ÿ�ս���Ľ���Խ�ߡ�"},
		
		[45]  = {index=16,val = 5,times = 1, info = "<font color='#fff3ca'>���鸱��<font color='#00ff84'>������</font>�� �� ��<font color='#00ff2a'><a href='event:move 1 46 86 61'><u>ǰ��</u></a></font><font color='#f6ff00'><a href='event:trans move 1 46 86 61'>{��}</a></font>",tip = "���鸱���ǻ��ÿ�ջ�þ������Ҫ;��֮һ��"},
		[2]  = {index=17,val = 5,times = 2, info = "<font color='#fff3ca'>��Ӹ���</font><font color='#ff00f6'>��װ��</font>��������<font color='#00ff2a'><a href='event:move 1 65 106 52'><u>ǰ��</u></a></font><font color='#f6ff00'><a href='event:trans move 1 65 106 52'>{��}</a></font>",tip = "��Ӹ�������������ɫװ����Ƭ��������һЩ�ǰ󶨵Ŀɽ���׬Ǯ�Ĳ��ϡ�"},		
		[3]  = {index=18,val = 5,times = 1, info = "<font color='#fff3ca'>��ʯ����</font><font color='#00fcff'>����ʯ</font>��������<font color='#00ff2a'><a href='event:move 1 62 63 51'><u>ǰ��</u></a></font><font color='#f6ff00'><a href='event:trans move 1 62 63 51'>{��}</a></font>",tip = "ÿ����һ���֣�������һ�������ı�ʯ��ÿ�ղ��ɴ����"},		
		[66]  = {index=19,level = 44,val = 5,times = 1, info = "<font color='#fff3ca'>��������</font><font color='#feff97'>������ֵ</font>������<font color='#00ff2a'><a href='event:move 1 47 94 71'><u>ǰ��</u></a></font><font color='#f6ff00'><a href='event:trans move 1 47 94 71'>{��}</a></font>",tip = "����ֵ��������ѧϰ�����������ս������"},		
		[71]  = {index=20,level = 46,val = 5,times = 1, info = "<font color='#fff3ca'>���Ǹ���</font><font color='#feff97'>����Ʒ</font> �� ����<font color='#00ff2a'><a href='event:move 1 65 64 73'><u>ǰ��</u></a></font><font color='#f6ff00'><a href='event:trans move 1 65 64 73'>{��}</a></font>",tip = "�ڿռ��ѷ��л�ɱ������ħ�����Ի���ǳ���Ƭ������װ�����ԡ�"},		
		[67]  = {index=20,level = 51,val = 5,times = 1, info = "<font color='#fff3ca'>���︱��</font><font color='#feff97'>����Ʒ</font>  ������<font color='#00ff2a'><a href='event:move 1 87 85 72'><u>ǰ��</u></a></font><font color='#f6ff00'><a href='event:trans move 1 87 85 72'>{��}</a></font>",tip = "��ȡ�������ϵĲ��ϣ�����ǿ������װ����ս��Խ�ߣ��������Ĳ�������Խ�ࡣ"},		
		[33] = {index=21,val = 5,times = 1, info = "<font color='#fff3ca'>�ػ�֮��</font><font color='#ff6f20'>��ս����</font>������<font color='#00ff2a'><a href='event:magic.DAmuletMagicPanel'><u>ͨ��</u></a></font>",tip = "�ػ�֮����Ի���ػ����ܣ����ս����"},		
		
		[37] = {index=22,val = 5,times = 1, info = "<font color='#fff3ca'>�������</font><font color='#feff97'>����Ʒ</font>��������<font color='#00ff2a'><a href='event:day.DDayPanel 4'><u>�鿴</u></a></font>",tip = "�μӡ�������ˡ������ȡ����һ�����㱦�䶼����ɣ��������м��ɵ�Ŷ��"},
		[36] = {index=23,val = 10,times = 1, info = "<font color='#fff3ca'>��ˮ����</font><font color='#00ff84'>������</font>��������<font color='#00ff2a'><a href='event:day.DDayPanel 4'><u>�鿴</u></a></font>",tip = "�μӡ���ˮ��������������ɣ����������þ��顣"},
		[51] = {index=24,val = 10,times = 1, info = "<font color='#fff3ca'>��������</font><font color='#00ff84'>������</font>��������<font color='#00ff2a'><a href='event:day.DDayPanel 4'><u>�鿴</u></a></font>",tip = "�μӡ��������ء���������ɣ���ˮ�����ִ̼���"},		
		[38] = {index=25,val = 10,times = 1, info = "<font color='#fff3ca'>ս���</font><font color='#feff97'>����Ʒ</font>��������<font color='#00ff2a'><a href='event:day.DDayPanel 4'><u>�鿴</u></a></font>",tip = "�μӡ�����ᱦ���������ս�����������ԡ����������ɡ�"},		
		--[39] = {index=25,val = 10,times = 1,info = "<font color='#fff3ca'>������</font><font color='#feff97'>����Ʒ</font>����������<font color='#00ff2a'><a href='event:day.DDayPanel 4'><u>�鿴</u></a></font>",tip = "��������ÿ��ǰ10������ʤ�����з������һ��Ҫ�μ�Ŷ��"},
		[64] = {index=26,val = 10,times = 5,info = "<font color='#fff3ca'>�콵����</font><font color='#00ff84'>������</font>��������<font color='#00ff2a'><a href='event:day.DDayPanel 4'><u>�鿴</u></a></font>",tip = "�콵���䣬���飬ͭǮ��������Ԫ����ֻҪ�ۼ��ֿ죬������࣡"},
		},
	[3] = { --�Ƽ������淨			

			[1001] = {index=26,level = 43, info = "<font color='#fff3ca'>ҡǮ��</font><font color='#ffdb5d'>��ͭǮ</font>����������<font color='#00ff2a'><a href='event:house'><u>�ؼ�</u></a></font>",tip = "��ׯ԰���ջ�һ��ҡǮ����"},
			[1002] = {index=27,info = "<font color='#fff3ca'>Ů�ͻ���</font><font color='#ff6f20'>��ս����</font>������<font color='#00ff2a'><a href='event:house'><u>�ؼ�</u></a></font>",tip = "��Ů�ͺϻ���������ս������������ܶȿ��Ի�ö���ӳɡ�"},		
			[1003] = {index=28,level = 43, info = "<font color='#fff3ca'>�Ӷ�ׯ԰</font><font color='#ff9c00'>��ս��</font>��������<font color='#00ff2a'><a href='event:home.DHomePlunderPanel'><u>�Ӷ�</u></a></font>",tip = "�Ӷ�������ɫԽ�ߵ��������Խ�ߣ�����ǵж԰����ң����ɶ����ðﹱ��"},		
			[1004] = {index=29,info = "<font color='#fff3ca'>��԰�ջ�</font><font color='#ffdb5d'>��ͭǮ</font><font color='#ca3cff'>����</font>����<font color='#00ff2a'><a href='event:garden.DGardenPanel'><u>�ջ�</u></a></font>",tip = "����ֵ�㹻�ߵĹ����и��ʳ�������������Ի�����⾪ϲ��"},
			[1005] = {index=30,level = 40, info = "<font color='#fff3ca'>ɳ̲����</font><font color='#feff97'>����Ʒ</font>��������<font color='#00ff2a'><a href='event:move 1 47 77 54'><u>ǰ��</u></a></font><font color='#f6ff00'><a href='event:trans move 1 47 77 54'>{��}</a></font>",tip = "ͨ����᪳ǵ�NPC�����Դ���ȥɳ̲���㡣"},					
			[1006] = {index=31,level = 40, info = "<font color='#fff3ca'>�ٰ����</font><font color='#00ff84'>������</font>��������<font color='#00ff2a'><a href='event:house'><u>�ؼ�</u></a></font>",tip = "�����Ҫ�ĺ���ʳ�ģ�����ͨ�������á�"},		
			[1007] = {index=32,level = 40, info = "<font color='#fff3ca'>��ɱ��Ӣ</font><font color='#feff97'>����Ʒ</font>��������<font color='#00ff2a'><a href='event:move 1 3 99'><u>ǰ��</u></a></font><font color='#f6ff00'><a href='event:trans move 1 3 99'>{��}</a></font>",tip = "�һ��ؾ���ͼ�У�ÿ����ÿСʱ�İ���ˢ����ֻ��Ӣ�֡���ɱ���Ի�����ǵ����ʺ�ʯ�ȸ��ѵ��ߡ�"},		
		},		
	[2] = { --����
			[1] = {val = 20 , item = {{638,10},{630,3}}},
			[2] = {val = 40 , item = {{51,1},{668,2},{664,2}}},
			[3] = {val = 80 , item = {{747,1},{601,10},{603,10},{1283,3}}},
			[4] = {val = 100 , item = {{625,1},{636,5},{671,1},{615,1}}},
		},
	},
	object = { --Ŀ��
		[1] = { level = 30,item = {{640,10},{601,1},{603,1}},-- level ���ŵȼ� item ȫ����ɿ��콱��(����ID������)
			[1] = {pos=0,index = 5,title = '����һ�ΰ�����',content = "���װﹱ�ƻ�ͭǮ�ɻ�ðﹱ������ճ�����ά���ﹱ�ơ�\n                                                                   <font color='#00ff2a'><a href='event:faction.DFactionPanel 0'><u>������</u></a></font>", item = {{640,3}}}, -- pos Ŀ��λ���ֽ�λ*10+�ֽ��еĵڼ�λ�� item ��ȡ�Ľ���
			--[2] = {pos=1,index = 6,title = '�����Ἴ��ѧϰ��3��',content = "����Ҫ�������ļ�����Ժ������ѧϰ���߼��İ�Ἴ�ܡ�\n\n                                                                <font color='#00ff2a'><a href='event:faction.DFactionPanel 0'><u>ѧϰ����</u></a></font>", item = {{640,3}}},
			[2] = {pos=1,index = 6,title = '��ΪVIP',content = "��ΪVIP�󣬲���������Ѵ��ͣ����ҿ��������ȡ������������̴������ս������\n                                                                <font color='#00ff2a'><a href='event:vip.DVipPanel'><u>��ΪVIP</u></a></font>", item = {{640,10}}},
			[3] = {pos=2,index = 3,title = '������װ��ǿ����10��',content = "ǿ���ɹ��ʲ����ʱ�򣬼ǵ÷�������ʯ��\n                                                                    <font color='#00ff2a'><a href='event:equip.DEquipPanel 0'><u>װ��ǿ��</u></a></font>", item = {{640,3}}},
			--[4] = {pos=3,index = 4,title = '������װ��ϴ����1����ɫ��������',content = "ϴ��ʯ����ͨ���ֽ����õ�װ������ã��һ����Ը��ʵ���װ����\n \n                                                                  <font color='#00ff2a'><a href='event:equip.DEquipPanel 2'><u>װ��ϴ��</u></a></font>", item = {{640,3}}},
			[4] = {pos=3,index = 4,title = '������װ��ϴ��1��',content = "ϴ��ʯ����ͨ���ֽ����õ�װ������ã��һ����Ը��ʵ���װ����\n                                                                   <font color='#00ff2a'><a href='event:equip.DEquipPanel 2'><u>װ��ϴ��</u></a></font>", item = {{640,3}}},
			--[5] = {pos=4,index = 6,title = '���������Ϊ����Ѫ����',content = "������׵���ͨ�����ã�Ҳ����ͨ���ַ������ã��������ð�Ԫ������\n\n                                                                  <font color='#00ff2a'><a href='event:horse.DHorsePanel 0'><u>��������</u></a></font>", item = {{640,3}}},
			[5] = {pos=4,index = 1,title = '������Ů�ͻ���1��',content = "��Ů�ͻ�������������ս�������Ů�����ܶȣ������Ի��ս������ӳɡ�\n                                                                 <font color='#00ff2a'><a href='event:interact.DInteractStagePanel'><u>Ů�ͻ���</u></a></font>", item = {{640,3}}},			
			[6] = {pos=5,index = 2,title = '������ҽ����е�10��',content = "������ͨ����԰��ֲ��ã�Ҳ����ͨ��ׯ����λ�����㽱����á�\n                                                                  <font color='#00ff2a'><a href='event:hero.DHeroPanel 1'><u>�ҽ�����</u></a></font>", item = {{640,3}}},
		},
		[2] = { level = 40,item = {{640,20},{696,1},{694,1}},
			[1] = {pos=6,title = '������װ����Ƕ1��3����ʯ',content = "��ʯ����ͨ��ÿ�ձ�ʯ������ã����ҿ������Ϻϳɡ�\n                                                                  <font color='#00ff2a'><a href='event:equip.DEquipPanel 1'><u>��ʯ��Ƕ</u></a></font>", item = {{640,5}}},
			--[2] = {pos=7,title = '�����������������10��',content = "����������һ���������ŻῪ�����ǡ����ǵ����Թһ����䣬Ҳ�������������չ���\n\n                                                                  <font color='#00ff2a'><a href='event:horse.DHorsePanel 1'><u>��������</u></a></font>", item = {{640,5}}},
			[2] = {pos=7,title = '�����Ἴ��ѧϰ��3��',content = "����Ҫ�������ļ�����Ժ������ѧϰ���߼��İ�Ἴ�ܡ�\n                                                                <font color='#00ff2a'><a href='event:faction.DFactionPanel 0'><u>ѧϰ����</u></a></font>", item = {{640,5}}},
			[3] = {pos=10,title = '�ػ�֮��װ������һ����ɫ����',content = "ͨ�鼼������Ҫ��������������ҲҪ��׼��ͭǮŶ��\n                                                                  <font color='#00ff2a'><a href='event:magic.DAmuletMagicPanel'><u>�ػ�ͨ��</u></a></font>", item = {{640,5}}},
			[4] = {pos=11,title = '�����·���9�ǹ���',content = "ս����Խ�ߣ���ͨ�صĹؿ�Խ�࣬��õĽ���Խ�ࡣ\n                                                                 <font color='#00ff2a'><a href='event:DCreateWorld'><u>��ս</u></a></font>", item = {{640,5}}},
			--[5] = {pos=12,title = '������װ��ǿ����15��',content = "ǿ���ɹ��ʲ����ʱ�򣬼ǵ÷�������ʯ��\n \n\n                                                                   <font color='#00ff2a'><a href='event:equip.DEquipPanel 0'><u>װ��ǿ��</u></a></font>", item = {{640,5}}},
			[5] = {pos=12,title = '������װ��ϴ����1����ɫ��������',content = "ϴ��ʯ����ͨ���ֽ����õ�װ������ã��һ����Ը��ʵ���װ����\n                                                                   <font color='#00ff2a'><a href='event:equip.DEquipPanel 2'><u>װ��ϴ��</u></a></font>", item = {{640,5}}},
			--[6] = {pos=13,title = '���������Ϊ���������',content = "������׵���ͨ�����ã�Ҳ����ͨ���ַ������ã��������ð�Ԫ������\n\n                                                                  <font color='#00ff2a'><a href='event:horse.DHorsePanel 0'><u>��������</u></a></font>", item = {{640,5}}},
			[6] = {pos=13,title = '���������Ϊ����Ѫ����',content = "������׵���ͨ����ֵ��䣬�ճ������ã��������ð�Ԫ������\n                                                                  <font color='#00ff2a'><a href='event:horse.DHorsePanel 0'><u>��������</u></a></font>", item = {{640,5}}},			
		},
		[3] = { level = 50,item = {{640,30},{637,10},{732,1}},
			[1] = {pos=14,title = '����ʯ����������10��',content = "��ʯ��������������Ƕ�б�ʯ����ֵ���ʺ�ʯ���Թһ����䣬Ҳ�������������չ���\n                                                                  <font color='#00ff2a'><a href='event:equip.DJewelLevel'><u>��ʯ����</u></a></font>", item = {{640,8}}},
			[2] = {pos=15,title = '�������װ����1��ǿ��',content = "��װ��Ƭ�����ھ�λ�̵�һ�����˵֮ʯ����������������á�\n                                                                  <font color='#00ff2a'><a href='event:equip.DEquipPanel 0'><u>װ��ǿ��</u></a></font>", item = {{640,8}}},			
			--[3] = {pos=16,title = '������ҽ����е�30��',content = "������ͨ����԰��ֲ��ã�Ҳ����ͨ��ׯ����λ�����㽱����á�\n\n                                                                  <font color='#00ff2a'><a href='event:hero.DHeroPanel 1'><u>�ҽ�����</u></a></font>", item = {{640,8}}},
			[3] = {pos=16,title = '�����������������10��',content = "����������һ���������ŻῪ�����ǡ����ǵ����Թһ����䣬Ҳ�������������չ���\n                                                                  <font color='#00ff2a'><a href='event:horse.DHorsePanel 1'><u>��������</u></a></font>", item = {{640,8}}},
			[4] = {pos=17,title = '��Ů��������1��',content = "Ů�����׺󣬿��԰��������ң����ҿ��԰���ս����\n                                                                  <font color='#00ff2a'><a href='event:magic.DFightMagicPanel'><u>Ů������</u></a></font>", item = {{640,8}}},
			--[5] = {pos=20,title = '�ػ�֮��װ������һ����ɫ����',content = "ͨ�鼼������Ҫ��������������ҲҪ��׼��ͭǮŶ��\n\n                                                                  <font color='#00ff2a'><a href='event:magic.DAmuletMagicPanel'><u>ͨ�鼼��</u></a></font>", item = {{640,8}}},
			[5] = {pos=20,title = '�����������2��',content = "����������ο��ţ���������������ս������ɫ�������ڻ�Ծ�ȣ����ܻ��л�á�\n                                                                 <font color='#00ff2a'><a href='event:horseWeapon.DHorseWeaponPanel'><u>�������</u></a></font>", item = {{640,8}}},
			--[6] = {pos=21,title = '���������Ϊ��̫����ܡ�',content = "������׵���ͨ�����ã�Ҳ����ͨ���ַ������ã��������ð�Ԫ������\n\n                                                                  <font color='#00ff2a'><a href='event:horse.DHorsePanel 0'><u>��������</u></a></font>", item = {{640,8}}},
			[6] = {pos=21,title = 'ʳ��������һ�����Ե�',content = "�������Ե�����VIP��������λ���ر���ȵط���á�ʹ�ü�������ս������\n                                                                  <font color='#00ff2a'><a href='event:DMainStatePanel 4'><u>���Ե�</u></a></font>", item = {{640,8}}},
		},
		[4] = { level = 60,item = {{640,50},{626,150},{627,150}},
			[1] = {pos=22,title = '��ְҵ�츳������10��',content = "ְҵ�츳���������������ԣ����ҿ��Զ�ְҵ���ܽ���Ч����ǿ��\n                                                                  <font color='#00ff2a'><a href='event:skill.DSkillPanel 2'><u>ְҵ�츳</u></a></font>", item = {{640,12}}},
			--[2] = {pos=23,title = '�����Ἴ��ѧϰ��8��',content = "����Ҫ�������ļ�����Ժ������ѧϰ���߼��İ�Ἴ�ܡ�\n\n                                                                <font color='#00ff2a'><a href='event:faction.DFactionPanel'><u>ѧϰ����</u></a></font>", item = {{640,12}}},
			[2] = {pos=23,title = '�����������3��',content = "����������ο��ţ���������������ս������ɫ�������ڻ�Ծ�ȣ����ܻ��л�á�\n                                                                  <font color='#00ff2a'><a href='event:horseWeapon.DHorseWeaponPanel'><u>�������</u></a></font>", item = {{640,12}}},
			--[3] = {pos=24,title = '������װ����Ƕ1��8����ʯ',content = "��ʯ����ͨ��ÿ�ձ�ʯ������ã����ҿ������Ϻϳɡ�\n\n                                                                  <font color='#00ff2a'><a href='event:equip.DEquipPanel 1'><u>��ʯ��Ƕ</u></a></font>", item = {{640,12}}},
			[3] = {pos=24,title = '������������2��',content = "���������ݵı�־�����ҿ�����������ս����������Ҳ����Ťתս�ֵĹؼ���\n                                                                 <font color='#00ff2a'><a href='event:wing.DWingPanel'><u>��������</u></a></font>", item = {{640,12}}},
			--[4] = {pos=25,title = '�ػ�֮��������ִﵽ30000',content = "ͨ�鼼������Ҫ��������������ҲҪ��׼��ͭǮŶ��\n\n                                                                  <font color='#00ff2a'><a href='event:magic.DAmuletMagicPanel'><u>ͨ�鼼��</u></a></font>", item = {{640,12}}},
			[4] = {pos=25,title = '�ػ�֮��װ������һ����ɫ����',content = "ͨ�鼼������Ҫ��������������ҲҪ��׼��ͭǮŶ��\n                                                                 <font color='#00ff2a'><a href='event:magic.DAmuletMagicPanel'><u>ͨ�鼼��</u></a></font>", item = {{640,12}}},
			[5] = {pos=26,title = '��Ů��������5��',content = "Ů�����׺󣬿��԰��������ң����ҿ��԰���ս����\n                                                                  <font color='#00ff2a'><a href='event:magic.DFightMagicPanel'><u>Ů������</u></a></font>", item = {{640,12}}},
			[6] = {pos=27,title = '���������Ϊ�������컢��',content = "������׵���ͨ����ֵ��䣬�ճ������ã��������ð�Ԫ������\n                                                                 <font color='#00ff2a'><a href='event:horse.DHorsePanel 0'><u>��������</u></a></font>", item = {{640,12}}},
		},
		[5] = { level = 70,item = {{640,80},{771,30},{766,2}},
			[1] = {pos=30,title = '��ְҵ�츳������30��',content = "ְҵ�츳���������������ԣ����ҿ��Զ�ְҵ���ܽ���Ч����ǿ��\n                                                                 <font color='#00ff2a'><a href='event:skill.DSkillPanel 2'><u>ְҵ�츳</u></a></font>", item = {{640,15}}},
			[2] = {pos=31,title = '�����Ἴ��ѧϰ��8��',content = "����Ҫ�������ļ�����Ժ������ѧϰ���߼��İ�Ἴ�ܡ�\n                                                               <font color='#00ff2a'><a href='event:faction.DFactionPanel'><u>ѧϰ����</u></a></font>", item = {{640,15}}},
			[3] = {pos=32,title = '�����������4��',content = "����������ο��ţ���������������ս������ɫ�������ڻ�Ծ�ȣ����ܻ��л�á�\n                                                                  <font color='#00ff2a'><a href='event:horseWeapon.DHorseWeaponPanel'><u>�������</u></a></font>", item = {{640,15}}},
			[4] = {pos=33,title = '������װ����Ƕ1��8����ʯ',content = "��ʯ����ͨ��ÿ�ձ�ʯ������ã����ҿ������Ϻϳɡ�\n                                                                  <font color='#00ff2a'><a href='event:equip.DEquipPanel 1'><u>��ʯ��Ƕ</u></a></font>", item = {{640,15}}},
			[5] = {pos=34,title = '������������5��',content = "���������ݵı�־�����ҿ�����������ս����������Ҳ����Ťתս�ֵĹؼ���\n                                                                 <font color='#00ff2a'><a href='event:wing.DWingPanel'><u>��������</u></a></font>", item = {{640,15}}},
			[6] = {pos=35,title = '�ػ�֮��������ִﵽ30000',content = "ͨ�鼼������Ҫ��������������ҲҪ��׼��ͭǮŶ��\n                                                                  <font color='#00ff2a'><a href='event:magic.DAmuletMagicPanel'><u>ͨ�鼼��</u></a></font>", item = {{640,15}}},			
		},
	},
	sc = {pos = 50,bdyb = 200}, --�ղ���ȡ��ʶ bdyb ��ȡ�İ�Ԫ����
	lvgift = {--�ȼ����
		[1] = {lv = 40,pos = 51,item = {{1096,200}}},
		[2] = {lv = 42,pos = 52,item = {{1096,300}}},
		[3] = {lv = 44,pos = 53,item = {{1096,500}}},
		[4] = {lv = 46,pos = 54,item = {{1096,800}}},
		[5] = {lv = 48,pos = 55,item = {{1096,1000}}},
		[6] = {lv = 50,pos = 56,item = {{1096,1500}}},
		[7] = {lv = 52,pos = 57,item = {{1096,2000}}},
		[8] = {lv = 54,pos = 60,item = {{1096,2400}}},
		[9] = {lv = 56,pos = 61,item = {{1096,3500}}},
		[10] = {lv = 58,pos = 62,item = {{1096,5000}}},
		[11] = {lv = 60,pos = 63,item = {{1096,8800}}},
		[12] = {lv = 62,pos = 64,item = {{1096,12888}}},
	},
	dl = {
		-- money = 1,		-- ����
		-- item = 3,		-- ����
		-- lingqi = 5,		-- ����
		pos = 65,
		[1] = 200000,
		[3] = {{5625,1,1},},
		[5] = 200000,
	}, --���ص�¼������
	-- 66 ��6���ֽڵĵ�6λ,������Ʒ��ʾλ��
	--67  4399�ֻ���֤
}
--���ֿ���������Ʒ���ñ�
local newplayergift_goodconf = {
		{601,5,1},				--5���߼�ͭǮ��
		{603,5,1},				--5���߼�������
		{612,5,1},				--5��3������ʯ
		{1061,5,1},				--5��3������֮��
		{51,2,1},				--2��1.5�������
		{1,2,1}	,				--2����ϼ�ɵ�
		{604,5,1},				--5������ϴ��ʯ
		{100,10,1}				--10���з�
}

--�ֻ���
local _4399phone_goodsconf={
	{1073,200,1},   			--200��Ԫ��
}
--360������
local _360jiasuqiu={
	
		{789,5,1},				
		{636,2,1},				
		{771,1,1},				
		{603,20,1},				
						
}
   --360����
_360dating={
		{647,1,1},				
		{618,5,1},				
		{3008,1,1},
		{710,3,1},				
		{634,5,1},				
		{803,20,1},
		{778,3,1},				
		{603,100,1},						
}
--��ȡ��Ծ������
local function _get_fundata(sid)
	local data = __G.GetPlayerDayData(sid)
	if data==nil then return end
	if data.fun == nil then
	   data.fun = {} --proc ������ɶ� get ����ȡ val ��ǰ��Ծֵ
	end
	return data.fun
end

--��¼���ջ�Ծ�� idx ��Ծ���� times ���մ��� times1 �ܴ��� times2 ��֮ǰ�Ĵ���
local function _set_data(sid , idx, times, times1, times2)
	local data = _get_fundata(sid)
	if data==nil then
		--look('SetFunData_error')
		return
	end
	local conf
	--��Ծ
	times2 = times2 or 0
	local conf = FunConf.active[1][idx]
	if(times~=nil and conf~=nil)then
		if(times >= conf.times and times2 < conf.times)then --���
			data.val = (data.val == nil and 0) or data.val
			local addVal = conf.val
			if(idx == 28)then --ÿ��ǩ��
				--+10	+15	+20	+25	+30	+35	+40	+50
				local vipLv = __G.GI_GetVIPLevel(sid)
				if(vipLv>3)then
					addVal = addVal + (10+(vipLv - 4)*5)--((vipLv<9 and vipLv * 5) or vipLv * 5 +5)
				end
			end
			data.val = data.val + addVal
		end
		--if(times < conf.times)then --���ڲ�Ӱ��ǰ̨�Ͳ�����
		--	SendLuaMsg( 0, { ids=EveryDay_Actibe_msg, data = data }, 9 )
		--end
		SendLuaMsg( 0, { ids=EveryDay_Actibe_msg, data = data }, 9 )
	end
end

--�ֶ��ӻ�Ծ��
local function _add_fun_val(sid,addVal)
	local data = _get_fundata(sid)
	if data==nil then
		return
	end
	data.val = (data.val == nil and 0) or data.val
	data.val = data.val + addVal
	SendLuaMsg( 0, { ids=EveryDay_Actibe_msg, data = data }, 9 )
end

--��ȡÿ�ջ�Ծ���� idx ��Ծ��������
local function _get_fun_gift(sid,idx)
	local data = _get_fundata(sid)
	if(data == nil)then return false,1 end --��ȡ��Ծ����ʧ��
	
	local award = data.awad
	if(award~=nil and award[idx]~=nil)then return false,2 end --����ȡ
	
	local curAward = FunConf.active[2][idx]
	if(curAward == nil)then return false,3 end --��ȡ��Ծ��������ʧ��
	
	if(data.val == nil or data.val<curAward.val)then	 return false,4 end --��Ծֵ����
	
	local pakagenum = isFullNum()
	if pakagenum < #curAward.item then return false,5 end --�����ո���
	for _,v in pairs(curAward.item) do
		GiveGoods(v[1],v[2],1,"��Ծ�Ƚ���")
	end
	if(award == nil)then
		data.awad = {}
		award = data.awad
	end
	award[idx] = 1
	return true,data
end

--��ȡĿ���콱����
local function _get_objdata(sid)
	local data=__G.GI_GetPlayerData( sid ,'obj',150)
	if data==nil then return end
	return data
end

--���Ŀ������
local function _clear_obj_pos(sid)
	local data = _get_objdata(sid)
	if(data~=nil)then
		for idx, v in pairs(data) do
			if(type(idx) == type(0))then
				data[idx] = nil
			end
		end
	end
end

--�콱���� data = {[1]=1101011,...} ���һλ��ǵ��Ǵ�������ȡ״̬,������Ŀ����������
--��ȡĿ�꽱�� objid Ŀ������
local function _get_obj_item(sid,objid)
	local ot = math_floor(objid/1000)
	local oid = math_floor(objid%1000)
	local objTb = FunConf.object[ot]
	if(objTb == nil or objTb[oid] == nil or objTb[oid].pos == nil)then return false,1 end --�Ҳ���Ŀ��
	local data = _get_objdata(sid)
	if(data == nil)then return false,2 end --��ȡ�콱����ʧ��
	if(data[ot]~=nil and math_floor((data[ot]/(10^oid))%10)>0)then return false,3 end --����ȡ�˽���
	local itemData = objTb[oid].item
	if(itemData == nil)then return false,4 end --û���佱��
	local pos = objTb[oid].pos
	local post = math_floor(pos/10)
	local posidx = math_floor(pos%10)
	if(GetTaskMask(post,posidx) == false)then return false,5 end --Ŀ����δ���
	local pakagenum = isFullNum()
	if pakagenum < #itemData then return false,6 end --�����ո���
	for _,v in pairs(itemData) do
		GiveGoods(v[1],v[2],1,"Ŀ�꽱��")
	end
	if(data[ot] == nil)then data[ot] = 0 end
	data[ot] = data[ot] + 10^oid
	return true,data
end

--��ȡĿ���ɵĴ��� t Ŀ���������
local function _get_obj_finish_item(sid,t)
	local objTb = FunConf.object[t]
	if(objTb == nil)then return false,1 end --�Ҳ���Ŀ��
	local itemData = objTb.item
	if(itemData == nil)then return false,2 end --û���佱��
	local data = _get_objdata(sid)
	if(data == nil)then return false,3 end --��ȡ�콱����ʧ��
	if(data[t]~=nil and math_floor(data[t]%10)>0)then return false,4 end --����ȡ�˽���
	local post
	local postidx
	for i = 1,#objTb-1 do
		if(objTb[i] ~= nil and objTb[i].pos~=nil)then
			post = math_floor(objTb[i].pos/10)
			posidx = math_floor(objTb[i].pos%10)
			if(GetTaskMask(post,posidx) == false)then return false,5 end --Ŀ����δ���
		end
	end
	local pakagenum = isFullNum()
	if pakagenum < #itemData then return false,6 end --�����ո���
	for _,v in pairs(itemData) do
		GiveGoods(v[1],v[2],1,"Ŀ�����")
	end
	if(data[t] == nil)then data[t] = 0 end
	data[t] = data[t] + 1
	return true,data
end

--����λ
local function _set_mask_pos(sid,pos)
	--look('set mask pos '..sid..','..pos)
	if(sid == nil or sid<=0 or pos == nil)then
		look('error task set (pos/sid) is null or <=0',1)
		return
	end
	local group = math_floor(pos/10)
	local idx = math_floor(pos%10)
	if(group>127 or group<0 or idx>7)then
		look('error task set pos = '..pos,1)
		return
	end
	result = SetTaskMask(group,idx,2,sid)
	if(result)then
		-- look('set pos result='..result)
	else
		-- look('set pos result is null')
	end
end

--��ȡλ
local function _get_mask_pos(sid,pos) 
	if(sid == nil or sid<=0 or pos == nil)then
		look('error task get (pos/sid) is null or <=0',1)
		return
	end
	local group = math_floor(pos/10)
	local idx = math_floor(pos%10)
	if(group>127 or group<0 or idx>7)then
		look('error task get pos = '..pos,1)
		return
	end
	return GetTaskMask(group,idx)
end


--���Ŀ��
local function _set_obj_pos(sid,objid)
	local ot = math_floor(objid/1000)
	local oid = math_floor(objid%1000)
	local objTb = FunConf.object[ot]
	if(objTb == nil or objTb[oid] == nil or objTb[oid].pos == nil)then return end --�Ҳ���Ŀ��
	local pos = objTb[oid].pos
	_set_mask_pos(sid,pos)
end

--��ȡ�ղؽ���
local function _get_sc_item(sid)
	local scTb = FunConf.sc
	if(scTb == nil or scTb.pos == nil)then return 1 end --���ó���
	local isGet = _get_mask_pos(sid,scTb.pos)
	if(isGet == nil)then return 2 end --��ȡ��ȡ��ʶʧ��
	if(isGet == true)then return 3 end --����ȡ
	if(scTb.bdyb and type(scTb.bdyb) == type(0))then --�Ӱ�Ԫ��
		__G.AddPlayerPoints( sid , 3 , scTb.bdyb ,nil,'�ղؼӰ�Ԫ��')
	end
	_set_mask_pos(sid,scTb.pos)
end





--�������Ʒ 1,���ֿ�2,�ֻ�3,360������,4,360����
local function _giveplayer_jihuogift(sid,iType)
	local  temp_goodconf
	local pos
	if	iType == 1 then 
		temp_goodconf = newplayergift_goodconf
		pos = 66
		local isGet = _get_mask_pos(sid,pos)
		if(isGet == nil)then return 3 end --��ȡ��ȡ��ʶʧ��
		if(isGet == true)then --����ȡ
			TipCenter(__G.GetStringMsg(458))
			return 4 
		end 
		local pakagenum = isFullNum()
		if pakagenum < #temp_goodconf then --�����ո���
			TipCenter(__G.GetStringMsg(14,#temp_goodconf))
			return 5 
		end 
		if(temp_goodconf~=nil)then
			GiveGoodsBatch(temp_goodconf,"���ֽ���")
			RPC('code_getwards',temp_goodconf,iType)--�콱�ɹ�,ǰ̨��ʾ���
		end
		_set_mask_pos(sid,pos)
	elseif iType == 2 then
		pos = 67
		local isGet = _get_mask_pos(sid,pos)
		if(isGet == nil)then return 3 end --��ȡ��ȡ��ʶʧ��
		if(isGet == true)then return 4 end --����ȡ
		__G.AddPlayerPoints( sid , 3 , 200 ,nil,'�ֻ���֤���Ӱ�Ԫ��')
		RPC('code_getwards',_4399phone_goodsconf,iType)--�콱�ɹ�,ǰ̨��ʾ���
		_set_mask_pos(sid,pos)
	elseif	iType == 3 then 
		temp_goodconf = _360jiasuqiu
		pos = 70
		local isGet = _get_mask_pos(sid,pos)
		if(isGet == nil)then return 3 end --��ȡ��ȡ��ʶʧ��
		if(isGet == true)then --����ȡ
			TipCenter(__G.GetStringMsg(458))
			return 4 
		end 
		local pakagenum = isFullNum()
		if pakagenum < #temp_goodconf then --�����ո���
			TipCenter(__G.GetStringMsg(14,#temp_goodconf))
			return 5 
		end 
		if(temp_goodconf~=nil)then
			GiveGoodsBatch(temp_goodconf,"360������")
			RPC('code_getwards',temp_goodconf,iType)--�콱�ɹ�
		end
		_set_mask_pos(sid,pos)
	elseif	iType == 4 then 
		temp_goodconf = _360dating
		pos = 71
		local isGet = _get_mask_pos(sid,pos)
		if(isGet == nil)then return 3 end --��ȡ��ȡ��ʶʧ��
		if(isGet == true)then --����ȡ
			TipCenter(__G.GetStringMsg(458))
			return 4 
		end 
		local pakagenum = isFullNum()
		if pakagenum < #temp_goodconf then --�����ո���
			TipCenter(__G.GetStringMsg(14,#temp_goodconf))
			return 5 
		end 
		if(temp_goodconf~=nil)then
			GiveGoodsBatch(temp_goodconf,"360����")
			RPC('code_getwards',temp_goodconf,iType)--�콱�ɹ�
		end
		_set_mask_pos(sid,pos)
	end
end




--�ȼ������ȡ
local function _get_lv_item(sid,idx)
	local tb = FunConf.lvgift[idx]
	if(tb == nil or tb.pos == nil or tb.lv == nil)then return 1 end --���ó���
	local level = CI_GetPlayerData(1)
	if(level<tb.lv)then return 2 end --�ȼ�����
	local isGet = _get_mask_pos(sid,tb.pos)
	-- look('12313122111111')
	-- look(isGet)
	if(isGet == nil)then return 3 end --��ȡ��ȡ��ʶʧ��
	if(isGet == true)then return 4 end --����ȡ
	if(tb.item~=nil)then
		for _,v in pairs(tb.item) do
			DGiveP(v[2],'awards_�ȼ�����')
		end
		--[[
		local pakagenum = isFullNum()
		if pakagenum < #tb.item then return false,5 end --�����ո���
		for _,v in pairs(tb.item) do
			GiveGoods(v[1],v[2],1,"�ȼ�����")
		end
		]]--
	end
	_set_mask_pos(sid,tb.pos)
end

--��ȡ΢�˽���
local function _get_dl_item(sid)
	local dlTb = FunConf.dl
	if(dlTb == nil or dlTb.pos == nil)then return 1 end --���ó���
	local isGet = _get_mask_pos(sid,dlTb.pos)
	if(isGet == nil)then return 2 end --��ȡ��ȡ��ʶʧ��
	if(isGet == true)then return 3 end --����ȡ
	if(dlTb[3]~=nil and type(dlTb[3]) == type({}))then --���� �������жϵ��ߣ�����
		local pakagenum = isFullNum()
		if pakagenum < #dlTb[3] then
			return false,4 --�����ո���
		end
		GiveGoodsBatch(dlTb[3],"��΢�˵�¼������ȡ")
	end
	if(dlTb[1]~=nil)then --ͭǮ
		GiveGoods(0,dlTb[1],1,"��΢�˵�¼������ȡ")
	end
	if(dlTb[5]~=nil)then --����
		__G.AddPlayerPoints(sid,2,dlTb[1],nil,'��΢�˵�¼������ȡ')
	end
	_set_mask_pos(sid,dlTb.pos)
	return true
end
--------------------------------------------------------------------------
-- interface:
get_fundata = _get_fundata
set_data = _set_data
get_fun_gift = _get_fun_gift
get_obj_item = _get_obj_item
get_obj_finish_item = _get_obj_finish_item
set_obj_pos = _set_obj_pos
clear_obj_pos = _clear_obj_pos
set_mask_pos = _set_mask_pos
get_mask_pos = _get_mask_pos
get_sc_item = _get_sc_item
get_lv_item = _get_lv_item
get_dl_item = _get_dl_item
giveplayer_jihuogift = _giveplayer_jihuogift
add_fun_val = _add_fun_val