 --[[
file:Mounts_conf.lua
desc:����齱��
author:xiao.y
update:2013-7-1
refix:	done by xy
]]--

--------------------------------------------------------------------------
--include:
local GetMountsData = GetMountsData
local BroadcastRPC = BroadcastRPC
local math_floor = math.floor
local math_random = math.random
local isFullNum = isFullNum
local GiveGoods = GiveGoods
local BroadcastRPC = BroadcastRPC
--local GetWorldLevel = GetWorldLevel
local GetWorldCustomTempDB = GetWorldCustomTempDB
local MouseIsLuck = MouseIsLuck
local GetServerTime = GetServerTime
--------------------------------------------------------------------------
-- data:

--��������
local MountPT_conf = {
		--��������ﵽ >=98�� ʹ�õڶ�������
		--{���ؿ̶�,{����ID,����,�������ޡ���������(����<val<=����)}}
		[1] = {10,gift = {
		{{636,1,0,5000},{636,2,5000,10000},{636,10,0,0},{636,50,0,0}},
		{{636,1,0,5000},{636,2,5000,10000},{636,10,0,0},{636,50,0,0}},
		}},
		[2] = {30,gift = {
		{{636,2,0,5000},{636,4,5000,10000},{636,20,0,0},{636,100,0,0}},
		{{636,2,0,5000},{636,4,5000,10000},{636,20,0,0},{636,100,0,0}},
		}},
		[3] = {70,gift = {
		{{636,4,0,1000},{636,8,1000,10000},{636,40,0,0},{636,200,0,0}},
		{{636,4,0,1000},{636,8,1000,10000},{636,40,0,0},{636,200,0,0}},
		}},
		[4] = {150,gift = {
		{{636,8,0,8000},{636,16,8000,10000},{636,80,0,0},{636,400,0,0}},
		{{636,8,0,8000},{636,16,8000,10000},{636,80,0,0},{636,400,0,0}},
		}},
		[5] = {310,gift = {
		{{636,16,0,8000},{636,32,8000,10000},{636,160,0,0},{636,800,0,0}},
		{{636,16,0,8000},{636,32,8000,10000},{636,160,0,0},{636,800,0,0}},
		}},
		[6] = {630,gift = {
		{{636,32,0,8000},{636,64,8000,10000},{636,320,0,0},{636,1600,0,0}},
		{{636,32,0,8000},{636,64,8000,10000},{636,320,0,0},{636,1600,0,0}},
		}},
		[7] = {1270,gift = {
		{{636,64,0,10000},{636,128,0,0},{636,640,0,0},{636,3200,0,0}},
		{{636,64,0,10000},{636,128,0,0},{636,640,0,0},{636,3200,0,0}},
		}},
		[8] = {2550,gift = {
		{{636,128,0,10000},{636,256,0,0},{636,1280,0,0},{636,6400,0,0}},
		{{636,128,0,10000},{636,256,0,0},{636,1280,0,0},{636,6400,0,0}},
		}},
}

--����齱ȫ������ {��ǰ�ѳ��������ǰ�ɳ��������ǰ�齱��8���ܴ���}
local function getMouseLuckWData()
	local tb = GetWorldCustomTempDB()
	if(tb == nil)then return end
	if(tb.mluck == nil)then tb.mluck = {} end
	return tb.mluck
end

--��ӳ齱����
function addMountPt(sid,v)
	local data = GetMountsData(sid)
	if(nil ~= data)then
		if(data.pt == nil)then 
			data.pt = {v,0} --{�齱���������������¼}
		else
			data.pt[1] = data.pt[1] + v
		end
	end
end

--�齱
function getMountPtGift(sid)
	if(IsSpanServer())then
		MouseIsLuck = 0
	end

	if(MouseIsLuck == 0)then return false,7 end
	
	local endTime = MouseActiveData()
	if(endTime>0)then
		local curTimes = GetServerTime()
		if(endTime<curTimes)then return false,7 end
	end

	local data = GetMountsData(sid)
	if(nil == data)then
		return false,1  --û����������
	end
	local pt = data.pt
	if(pt == nil)then
		return false,2	--û�г齱����
	end
	
	local val = pt[1] --��ǰ�ۼƳ齱����
	local record = pt[2] --���������¼��ȫ��11111111��
	
	local times = 0 -- �齱����
	--����齱����
	for i = 1,8 do
		if(MountPT_conf[i][1]>pt[1])then
			break
		end
		times = i
	end
	--look('times=='..times)
	if(times == 0)then
		return false,3	--û�г齱����
	end
	
	local pakagenum = isFullNum()
	if(pakagenum< 1)then
		return false,6	--������
	end
	
	local extraTimes = 0
	if(times == 8)then --�ж��Ƿ��ж������
		local temp = val - MountPT_conf[8][1]
		local temp1 = MountPT_conf[8][1] - MountPT_conf[7][1]
		extraTimes = math_floor(temp/temp1)
	end
	local curGift = 0 --������ȡ�������
	local temp2
	--look('record,extraTimes='..record..','..extraTimes)
	for i = 1,times  do
		if(i<8)then
			temp2 = math_floor(record/(10^(i-1)))%10
		else
			temp2 = math_floor(record/(10^(i-1)))
		end
		--look('i=temp2='..i..','..temp2)
		if(temp2 == 0)then --δ��
			curGift = i
			break
		elseif(i == 8)then
			if(temp2<(extraTimes+1))then --��������
				curGift = i
				break
			end
		end
	end
	
	if(curGift==0)then
		return false,4	--����������
	end
	--look('curGift='..curGift)
	local gift = MountPT_conf[curGift].gift[1]
	--local wlevel = GetWorldLevel()
	local wlevel = data.lv
	if(wlevel>=98)then
		gift = MountPT_conf[curGift].gift[2]
	end
	
	if(gift == nil)then return false,5 end --��ȡ������ó���
	local wdata
	local wTime = 0 --���кö�������
	local wUpTime = 1 --���кö�����������
	local wTotalTime = 0 --�ܳ�8��Ĵ�����ÿ10�Σ����޼�1��
	if(curGift == 8)then --����ǵ�8��ĳ齱
		wdata = getMouseLuckWData()
		if(wdata and wdata[1]~=nil)then
			wTime = wdata[1]
			wUpTime = wdata[2]
			wTotalTime = wdata[3]
		end
	end
	local rnd = math_random(1,10000)
	local good
	local idx
	for i = 1,4 do
		if(rnd>gift[i][3] and rnd<=gift[i][4])then
			if(curGift == 8 and i == 4)then --Ǳ����
				if(wTime>=wUpTime)then
					good = gift[3] --���ս��
					idx = 3
				else
					good = gift[i] --���ս��
					idx = i
					wTime = wTime + 1
				end
				wTotalTime = wTotalTime + 1
				wUpTime = math_floor(wTotalTime/10)+1
			else
				good = gift[i] --���ս��
				idx = i
			end
			break
		end
	end
	
	if(wdata)then
		wdata[1] = wTime
		wdata[2] = wUpTime
		wdata[3] = wTotalTime
	end
	
	if(good == nil)then return false,5 end --��ȡ������ó���
	if idx > 2 then
		--ϵͳ����  ��ϲ���XXX�����ｱƷ���г���XXX����N��
		BroadcastRPC('Mouse_Notice',CI_GetPlayerData(3),good[1],good[2],sid)
	end
	
	GiveGoods(good[1],good[2],1,"����齱���")
	pt[2] = pt[2] + 10^(curGift-1)
	--look('------'..idx)
	return true,data,idx,good[1]
end