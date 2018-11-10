--[[
file:	player_gift.lua
desc:	player gift.
author:	
update:	2013-05-30
refix: done by chal
]]--
-- 登陆7天奖励配置

--------------------------------------------------------------------------
--include:
local s_Login = msgh_s2c_def[1][11]
local isFullNum = isFullNum

local _get_mask_pos = get_mask_pos --获取位 Achieve/fun 
local _set_mask_pos = set_mask_pos --设置位

--------------------------------------------------------------------------
-- data:

-- 登陆7天奖励配置  id,数量,绑定1,孔数1,等级15---至少配前3个,有职业时123,没有时配1就可以了
local EveryDayLoginGoods = {
	[1] = {--第1天
			[1]={{3001,1,1},{644,10,1},},
		},
	[2] = {--第2天,分职业123
			[1]={{5344,1,1,1,15},{636,5,1},{1105,2,1},},
			[2]={{5381,1,1,1,15},{636,5,1},{1105,2,1},},
			[3]={{5418,1,1,1,15},{636,5,1},{1105,2,1},},
		},
	[3] = {
			[1]={{1116,1,1},{643,2,1},{638,10,1},{613,5,1},},
		},
	[4] = {--有个+15戒指
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

--数据放在活动数据下,初始化为0,0,领完后nil
function getdata_serveropen( sid )
	local adata=GetDBActiveData( sid )
	if adata==nil then return end
		if adata.kaif==nil then
			adata.kaif={
				[1]=0,--1为领过,nil为领完,不显示图标
				[2]=0,--领过几天
			}
		end
	return adata.kaif
end
--每天可領一次,累計領7天結束
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
	GiveGoodsBatch(awardconf,"登陆7天奖励")
	data[1]=1
	data[2]=data[2]+1

	if data[2]>=7 then --7天领完,清空数据
		data[1]=nil
		data[2]=nil
	end
	SendLuaMsg( 0, { ids = s_Login,data = data}, 9 )
end

--每日重置领取
function resetget_serveropen( sid )
	local data=getdata_serveropen( sid )
	if data==nil then return end
	if  data[1]==nil then return end
	data[1]=0
	SendLuaMsg( 0, { ids = s_Login,data = data}, 9 )
end

