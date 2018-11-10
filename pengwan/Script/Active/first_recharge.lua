--[[
file:	first_recharge.lua
desc:	�׳�
author:	wk
update:	2013-10-23
]]--
local GetDBActiveData=GetDBActiveData
local TipCenter=TipCenter
local GetStringMsg=GetStringMsg
local CI_GetPlayerData=CI_GetPlayerData
local isFullNum=isFullNum
local RPC=RPC
local GiveGoodsBatch=GiveGoodsBatch
local BroadcastRPC=BroadcastRPC
local __G=_G
local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond
local GetServerOpenTime=GetServerOpenTime

----------------------------------------------------------------------------
-- module:

module(...)

----------------------------------------------------------------------------

local first_conf = {
	award={
		[11]={{5004,1,1},{200,1,1},{636,10,1},{52,2,1},{644,10,1},{3,1,1},{0,300000,1},{3016,1,1},{614,5,1}},--��1��ְҵ��
		[10]={{5041,1,1},{200,1,1},{636,10,1},{52,2,1},{644,10,1},{3,1,1},{0,300000,1},{3016,1,1},{614,5,1}},--��1��ְҵŮ
		[21]={{5078,1,1},{200,1,1},{636,10,1},{52,2,1},{644,10,1},{3,1,1},{0,300000,1},{3016,1,1},{614,5,1}},--��2��ְҵ��
		[20]={{5115,1,1},{200,1,1},{636,10,1},{52,2,1},{644,10,1},{3,1,1},{0,300000,1},{3016,1,1},{614,5,1}},--��2��ְҵŮ
		[31]={{5152,1,1},{200,1,1},{636,10,1},{52,2,1},{644,10,1},{3,1,1},{0,300000,1},{3016,1,1},{614,5,1}},--��3��ְҵ��
		[30]={{5189,1,1},{200,1,1},{636,10,1},{52,2,1},{644,10,1},{3,1,1},{0,300000,1},{3016,1,1},{614,5,1}},--��3��ְҵŮ
	},
	--360�İ��ê�������
	award2={
		[11]={{5004,1,1},{700,1,1},{203,1,1},{52,2,1},{644,10,1},{618,3,1},{710,10,1},{625,3,1},{3016,1,1},},--��1��ְҵ��
		[10]={{5041,1,1},{700,1,1},{203,1,1},{52,2,1},{644,10,1},{618,3,1},{710,10,1},{625,3,1},{3016,1,1},},--��1��ְҵŮ
		[21]={{5078,1,1},{700,1,1},{203,1,1},{52,2,1},{644,10,1},{618,3,1},{710,10,1},{625,3,1},{3016,1,1},},--��2��ְҵ��
		[20]={{5115,1,1},{700,1,1},{203,1,1},{52,2,1},{644,10,1},{618,3,1},{710,10,1},{625,3,1},{3016,1,1},},--��2��ְҵŮ
		[31]={{5152,1,1},{700,1,1},{203,1,1},{52,2,1},{644,10,1},{618,3,1},{710,10,1},{625,3,1},{3016,1,1},},--��3��ְҵ��
		[30]={{5189,1,1},{700,1,1},{203,1,1},{52,2,1},{644,10,1},{618,3,1},{710,10,1},{625,3,1},{3016,1,1},},--��3��ְҵŮ
	},
}
------------------------------------------------------

--��ȡ  ������ acti.rech ,1Ϊ���
local function _f_getaward( sid )
	local data=GetDBActiveData( sid )
	if data==nil then return end

	local fdata=data.rech
	if (fdata or 0 )==1 then 
		TipCenter(GetStringMsg(66))
		return
	end

	local recharge_m=CI_GetPlayerData(27)
	if recharge_m==nil  or  recharge_m<=0 then 
		TipCenter(GetStringMsg(66))
		return
	end

	local school=CI_GetPlayerData(2)
	local sex=CI_GetPlayerData(11)
	local award=first_conf.award[school*10+sex]
	local plat=__G.__plat
	if plat==101 then --360
		local sec	= GetTimeToSecond(2014,4,11,0,00,00) 
		local svrTime = GetServerOpenTime() or 0 --����ʱ��
		if svrTime>sec then
			award=first_conf.award2[school*10+sex]
		end
	else
		local sec	= GetTimeToSecond(2014,4,22,0,00,00) 
		local svrTime = GetServerOpenTime() or 0 --����ʱ��
		if svrTime>sec then
			award=first_conf.award2[school*10+sex]
		end
	end
	local pakagenum = isFullNum()
	if pakagenum < #award then
		TipCenter(GetStringMsg(14,#award))
		return
	end		

	GiveGoodsBatch( award,"�׳�")
	RPC('first_recharge')
	BroadcastRPC('_recharge',CI_GetPlayerData(5))
	data.rech =1 --��־��1
end
---------------------------
f_getaward=_f_getaward

