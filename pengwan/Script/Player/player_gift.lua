--[[
file:	player_gift.lua
desc:	player gift.
author:	
update:	2013-05-30
refix: done by chal
]]--
-- ��½7�콱������

--------------------------------------------------------------------------
--include:
local s_Login = msgh_s2c_def[1][11]
local isFullNum = isFullNum

local _get_mask_pos = get_mask_pos --��ȡλ Achieve/fun 
local _set_mask_pos = set_mask_pos --����λ

--------------------------------------------------------------------------
-- data:

-- ��½7�콱������  id,����,��1,����1,�ȼ�15---������ǰ3��,��ְҵʱ123,û��ʱ��1�Ϳ�����
local EveryDayLoginGoods = {
	[1] = {--��1��
			[1]={{3001,1,1},{644,10,1},},
		},
	[2] = {--��2��,��ְҵ123
			[1]={{5344,1,1,1,15},{636,5,1},{1105,2,1},},
			[2]={{5381,1,1,1,15},{636,5,1},{1105,2,1},},
			[3]={{5418,1,1,1,15},{636,5,1},{1105,2,1},},
		},
	[3] = {
			[1]={{1116,1,1},{643,2,1},{638,10,1},{613,5,1},},
		},
	[4] = {--�и�+15��ָ
			[1]={{5566,1,1,1,15},{1029,1,1},{603,30,1},{1,5,1},{605,10,1},},
		},
	[5] = {
			[1]={{694,1,1},{637,5,1},{1044,1,1},{601,35,1},{603,35,1},},
		},
	[6] = {
			[1]={{302,1,1},{642,1,1},{627,2,1},{634,10,1},{601,40,1},{603,40,1},},
		},
	[7] = {
			[1]={{201,1,1},{618,10,1},{5662,1,1},{666,1,1},{601,50,1},{603,50,1},},
		},
}

--���ݷ��ڻ������,��ʼ��Ϊ0,0,�����nil
function getdata_serveropen( sid )
	local adata=GetDBActiveData( sid )
	if adata==nil then return end
		if adata.kaif==nil then
			adata.kaif={
				[1]=0,--1Ϊ���,nilΪ����,����ʾͼ��
				[2]=0,--�������
			}
		end
	return adata.kaif
end
--ÿ����Iһ��,��Ӌ�I7��Y��
function getgift_serveropen(sid)
	local data=getdata_serveropen( sid )
	if data==nil then return end
	
	if  data[1]~=0 then return end

	local  nowday=data[2]+1
	local school=CI_GetPlayerData(2)
	local awardconf=EveryDayLoginGoods[nowday][school]
	if awardconf ==nil  then 
		awardconf=EveryDayLoginGoods[nowday][1]
	end
	if awardconf ==nil  then 
		look('getgift_serveropen_conf_error',1)
		return
	end

	local pakagenum = isFullNum()
	if pakagenum < #awardconf then
		TipCenter(GetStringMsg(14,#awardconf))
		return
	end
	GiveGoodsBatch(awardconf,"��½7�콱��")
	data[1]=1
	data[2]=data[2]+1

	if data[2]>=7 then --7������,�������
		data[1]=nil
		data[2]=nil
	end
	SendLuaMsg( 0, { ids = s_Login,data = data}, 9 )
end

--ÿ��������ȡ
function resetget_serveropen( sid )
	local data=getdata_serveropen( sid )
	if data==nil then return end
	if  data[1]==nil then return end
	data[1]=0
	SendLuaMsg( 0, { ids = s_Login,data = data}, 9 )
end

