--[[
file:	����ʯ����
author:	wk
update:	2013-3-25
]]--
local active_mgr_m = require('Script.active.active_mgr')
local active_yushi = active_mgr_m.active_yushi
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local ZXfb_arise	 = msgh_s2c_def[40][1]
local ZX_refresh 	 = msgh_s2c_def[40][2]
--local ZXbuy_buff	 = msgh_s2c_def[40][3]
local look = look
local pairs ,ipairs= pairs,ipairs
local _random,_ceil=math.random,math.ceil
local uv_TimesTypeTb = TimesTypeTb
local CreateObjectIndirect = CreateObjectIndirect
local GiveGoods = GiveGoods
local GetStringMsg=GetStringMsg
local TipCenter=TipCenter
local CheckTimes=CheckTimes
local CI_GetCurPos=CI_GetCurPos
local CreateGroundItem=CreateGroundItem
local CI_OnSelectRelive=CI_OnSelectRelive
local GetPlayerTemp_custom=GetPlayerTemp_custom
local CI_GetPlayerData=CI_GetPlayerData
local HasTask=HasTask
local call_monster_dead=call_monster_dead
local SetEvent=SetEvent
local Log=Log
local tostring=tostring
----------------------------------------------------------------------------
-- module:

module(...)

----------------------------------------------------------------------------
local pos_conf={{10,10},{20,10},{10,22},{20,22},}
local minilv=30 --��͵ȼ�Ҫ��
local boshu_diaoluo = {5,10,25,25,26} --����--������key
local taskid=1324 --��ʯ������������id
local zxfb_monsterconf = {     --ˢ�¹�������
		monster ={	
			[1]={   monsterId =225, BRMONSTER = 1, monAtt={[1] =3000,[3] =300,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , }, 	
			[2]={   monsterId =226, BRMONSTER = 1,  monAtt={[1] =5000,[3] =400,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , }, 
			[3]={   monsterId =227, BRMONSTER = 1,  monAtt={[1] =6000,[3] =500,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , }, 	
			[4]={   monsterId =228, BRMONSTER = 1,  monAtt={[1] =8000,[3] =700,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , }, 
			[5]={   monsterId =229, BRMONSTER = 1,  monAtt={[1] =15000,[3] =900,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , }, 	
			[6]={   monsterId =230, BRMONSTER = 1,  monAtt={[1] =30000,[3] =1100,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , }, 
			[7]={  monsterId =231, BRMONSTER = 1,  monAtt={[1] =50000,[3] =1300,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , }, 	
			[8]={  monsterId =232, BRMONSTER = 1,  monAtt={[1] =70000,[3] =1600,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , }, 
			[9]={  monsterId =233, BRMONSTER = 1,  monAtt={[1] =90000,[3] =1900,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , },
			[10]={  monsterId =234, BRMONSTER = 1,  monAtt={[1] =110000,[3] =2200,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , },
			[11]={  monsterId =235, BRMONSTER = 1,  monAtt={[1] =130000,[3] =2500,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , },
			[12]={  monsterId =236, BRMONSTER = 1,  monAtt={[1] =150000,[3] =2900,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , },
			[13]={  monsterId =237, BRMONSTER = 1,  monAtt={[1] =170000,[3] =3300,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , },
			[14]={  monsterId =238, BRMONSTER = 1,  monAtt={[1] =200000,[3] =3700,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , },
			[15]={  monsterId =239, BRMONSTER = 1,  monAtt={[1] =230000,[3] =4500,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , },
			[16]={  monsterId =240, BRMONSTER = 1,  monAtt={[1] =260000,[3] =5000,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , },
			[17]={  monsterId =241, BRMONSTER = 1,  monAtt={[1] =290000,[3] =5500,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , },
			[18]={  monsterId =242, BRMONSTER = 1,  monAtt={[1] =320000,[3] =6500,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , },
			[19]={  monsterId =243, BRMONSTER = 1,  monAtt={[1] =350000,[3] =8000,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , },
			[20]={  monsterId =244, BRMONSTER = 1,  monAtt={[1] =380000,[3] =10000,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , },
			[21]={  monsterId =245, BRMONSTER = 1,  monAtt={[1] =410000,[3] =12000,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , },
			[22]={  monsterId =246, BRMONSTER = 1,  monAtt={[1] =450000,[3] =14000,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , },
			[23]={  monsterId =247, BRMONSTER = 1,  monAtt={[1] =500000,[3] =16000,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , },
			[24]={  monsterId =248, BRMONSTER = 1,  monAtt={[1] =550000,[3] =18000,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , },
			[25]={  monsterId =249, BRMONSTER = 1,  monAtt={[1] =600000,[3] =20000,},centerX = 16, centerY = 11 , IdleTime = 5,targetX = 15, targetY = 16,BRArea = 1 , deadbody = 3 ,deadScript = 14300 , },
			}, 
		boss = {
			[1]={ monsterId = 250, isboss=1 ,deadbody = 3 ,deadScript = 14300 , x=16,y=16,}, 
			[2]={ monsterId = 251, isboss=1 ,deadbody = 3 ,deadScript = 14300 , x=16,y=16,}, 
			[3]={ monsterId = 252, isboss=1 ,deadbody = 3 ,deadScript = 14300 , x=16,y=16,}, 
			[4]={ monsterId = 253, isboss=1 ,deadbody = 3 ,deadScript = 14300 , x=16,y=16,}, 
			[5]={ monsterId = 254, isboss=1 ,deadbody = 3 ,deadScript = 14300 , x=16,y=16,}, 
			},
}
--�����ʱ���ݽӿ�
local function yushi_tempdata(sid)
	if sid == nil then return nil end
	local cData = GetPlayerTemp_custom(sid)
	if cData == nil  then return end
	if cData.zxfb == nil then
		cData.zxfb = {
		mapgid=0,
		time_n=1,--ˢ�ڼ�������
		num=0,--ˢ������
		gatenum=1,--�ڼ���ûˢboss
		deadnum=0,--����ʣ�༸����
		mark=0,--ˢ�ֱ�ʶ0ûˢ,1ˢ��
		}
	end
	return cData.zxfb
end
--��ȡָ���ȼ��������ʯ
local function yushi_getbaoshi(lv)
	if lv < 1 then 
		return 
	end
	local blv = lv - 1
	local r = _random(0,7)
	local id = 410 + r*10 + blv
	return id
end
--������ȡ�õ���--����û��,�ڼ���
local function yushi_getnum(time_a,time_n)
	if time_a==nil then return end
	local gate
	if time_n<=5 then
		gate=(time_a-1)*10
	elseif time_n<=15 then	
		gate=(time_a-1)*5
	elseif time_n<=20 then	
		gate=(time_a-1)*3
	elseif time_n<=25 then	
		gate=(time_a-1)*1
	end

	local rannum=_random(1,100)
	if rannum<=gate then
		return 6
	else
		return _random(1,5)
	end
end
--���������߼�
local function _yushi_creatmonster(sid,num,mapgid,time_n,first)--ˢ�����֣�id���ڼ���
	-- look('���������߼�')
	local m = zxfb_monsterconf.monster[time_n]
	m.regionId = mapgid
	m.BRNumber=1

	if num == 6 then --ˢ��BOSS
		local time_this=_ceil(time_n/5)
		local bosstemp = zxfb_monsterconf.boss[time_this]
		bosstemp.regionId = mapgid
		CreateObjectIndirect(bosstemp)
		return
	end
	if not HasTask(sid,taskid) then 
		--look('����������')
		for i=1,#pos_conf do
			m.centerX=pos_conf[i][1]
			m.centerY=pos_conf[i][2]
			m.controlId = first
			local a=CreateObjectIndirect(m)
			-- look( '��������'..i..'__'..tostring(a))
			first=first+1	
		
		end
	else --����������ʱ���Խ���
		--look('����������ʱ���Խ���')
		
		local ole1=m.monAtt[1]
		local ole3=m.monAtt[3]
		m.monAtt[1]=3000
		m.monAtt[3]=300
		
		for i=1,#pos_conf do
			m.controlId = first
			m.centerX=pos_conf[i][1]
			m.centerY=pos_conf[i][2]
			CreateObjectIndirect(m)
			-- look( '��������'..i)
			first=first+1
		end

		m.monAtt[1]=ole1
		m.monAtt[3]=ole3
	end
	-- look('���������߼����11111')
end
--���븱��
local function _enter_yushifb(sid)

	local cData = GetPlayerTemp_custom(sid)
	cData.zxfb=nil
	local ZXtempdata=yushi_tempdata(sid)
	if minilv > CI_GetPlayerData(1) then
		TipCenter(GetStringMsg(4,minilv))
		return
	end	
	if not CheckTimes(sid,uv_TimesTypeTb.CS_Jewel,1,-1,1) then
		return
	end
	local mapgid =active_yushi:createDR(1)
	if mapgid == nil then return end 
	ZXtempdata.mapgid=mapgid
	if not active_yushi:add_player(sid, 1, 0, nil, nil, mapgid) then return end
	CheckTimes(sid,uv_TimesTypeTb.CS_Jewel,1,-1)	-- ������
	local gatenum=ZXtempdata.gatenum
	local num=_random(1,5)
	ZXtempdata.gatenum=ZXtempdata.gatenum+1
	ZXtempdata.num=num
	-- ZXtempdata.num=1
	ZXtempdata.deadnum=0
	ZXtempdata.mark=0
	local t_n=ZXtempdata.time_n
	SendLuaMsg( 0, { ids=ZXfb_arise,time_n=ZXtempdata.time_n,num=num,}, 9 )--���븱���ɹ���������Ӱ�ť
	SetEvent(10,nil,'GI_Chick_bengin',sid,t_n)
end


--������Ӱ�ť
local function _chick_bengin(sid,t_n)
	-- look('������Ӱ�ť')

	local cx, cy, rid, isdy = CI_GetCurPos(2,sid)
	if not isdy then return end
	local ZXtempdata=yushi_tempdata(sid)
	if ZXtempdata==nil then return end
	local time_n=ZXtempdata.time_n
	if t_n then 
		if t_n~=time_n then
			-- look('��������') 
			return
		end
	end
	-- look('ZXtempdata.time_n=='..ZXtempdata.time_n)
	-- look('ZXtempdata.deadnum=='..ZXtempdata.deadnum)
	-- look('ZXtempdata.mark=='..ZXtempdata.mark)
	if ZXtempdata.deadnum>0 then return end
	if ZXtempdata.mark==1 then return end


	
	
	if not HasTask(sid,taskid) then --����������ʱ6��
		if time_n>25 then
			return
		end
	else
		if time_n>6 then
			return
		end
	end
	local num=ZXtempdata.num
	local mapgid=ZXtempdata.mapgid
	if mapgid==nil then return end
	ZXtempdata.num=0
	if num~=6 then

		ZXtempdata.deadnum=num*#pos_conf --Ҫ������ô�������һ��
	else
		ZXtempdata.deadnum=1
	end
	ZXtempdata.mark=1
	-- look('ZXtempdata.deadnum---end--=='..ZXtempdata.deadnum)
	--������ˢ����
	_yushi_creatmonster(sid,num,mapgid,time_n,101)--ˢ�����֣�id���ڼ���
	if num>1 and num<6 then 
		for i=1,num-1 do
			SetEvent(i*5,nil,'GI_yushi_creatmonster',sid,num,mapgid,time_n,101+i*4)
		end
	end
end

--�˳�����
local function _yushifb_exit(sid)

	active_yushi:back_player(sid)
end



--���������ص�--����
--function active_yushi:on_monDeadAll(mapGID)
local function _yushi_on_monDeadAll(sid)
	-- local temp=active_yushi:get_regiondata(mapGID)

	-- local sid =temp[1]

	local ZXtempdata=yushi_tempdata(sid)
	if ZXtempdata==nil then return  end
	ZXtempdata.time_n=ZXtempdata.time_n+1
	local randa=_random(0,3)
	local randb=_random(1,3)
	local cx, cy = CI_GetCurPos(2,sid)
	
	local num = 0
	for k,v in pairs(boshu_diaoluo) do 
		if ZXtempdata.time_n <= v then
			num = k
			break
		end
	end
	local CreateGroundItem = CreateGroundItem
	local count = 0
	for i = 1,num do
		CreateGroundItem(506,ZXtempdata.mapgid,yushi_getbaoshi(1),1,cx,cy,count)
		count = count + 1	
	end
	
	if ZXtempdata.time_n>25 then
		TipCenter(GetStringMsg(24))
		return
	elseif HasTask(sid,taskid) then 
		if ZXtempdata.time_n>6 then	
			TipCenter(GetStringMsg(24))
			
		end
	end
	local gatenum=ZXtempdata.gatenum
	local num=yushi_getnum(gatenum,ZXtempdata.time_n)
	if num<6 then
		ZXtempdata.gatenum=ZXtempdata.gatenum+1
	else
		ZXtempdata.gatenum=1
	end
	ZXtempdata.num=num
	-- ZXtempdata.num=1
	ZXtempdata.mark=0
	-- look('ȫ������')
	local t_n=ZXtempdata.time_n
	SendLuaMsg( sid, { ids=ZXfb_arise,time_n=ZXtempdata.time_n,num=num,}, 10 )--������Ӱ�ť
	SetEvent(10,nil,'GI_Chick_bengin',sid,t_n)
end

call_monster_dead[ 14300]=function ( )
	-- look('���������ص�')
	local sid=CI_GetPlayerData(17)
	local ZXtempdata=yushi_tempdata(sid)
	if ZXtempdata==nil then return  end
	ZXtempdata.deadnum=ZXtempdata.deadnum-1
	-- look('��������ʣ�����..==='..ZXtempdata.deadnum)
	if ZXtempdata.deadnum<1 then
		ZXtempdata.deadnum=0
		_yushi_on_monDeadAll(sid)
	end
end

--ˢ������
function active_yushi:on_login(sid)
	local ZXtempdata=yushi_tempdata(sid)
	if ZXtempdata.time_n==nil then return end
	SendLuaMsg( 0, { ids=ZXfb_arise,time_n=ZXtempdata.time_n,num=ZXtempdata.num}, 9 )
end
--�л���ͼ
function active_yushi:on_regionchange(playerid)

	local cData = GetPlayerTemp_custom(playerid)
	cData.zxfb=nil
end
--�������
function active_yushi:on_playerdead(playerid)

	CI_OnSelectRelive(0,3*5,2,playerid)--�����سǸ���,3��5֡
	return 1
end
----
function cs_yushi(sid)
	local ZXtempdata=yushi_tempdata(sid)
	Log('yushi.txt',CI_GetPlayerData(3))
	Log('yushi.txt',ZXtempdata)
end
--------------------------
Enter_ZXfb=_enter_yushifb
zxfb_Exit=_yushifb_exit
Chick_bengin=_chick_bengin
yushi_creatmonster=_yushi_creatmonster