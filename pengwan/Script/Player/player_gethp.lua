--[[
file:	gethp.lua
desc:	Ѫ��ϵͳ
author:	wk
update:	2014-1-2
]]--
local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local xb_updata	 = msgh_s2c_def[15][17]
local CI_GetPlayerData=CI_GetPlayerData

--Ѫ��������
local function xb_getpdata( playerid )
	local xbdata=GI_GetPlayerData( playerid , 'xueb' , 30 )
	if xbdata == nil then return end
	--[[
		[1]=111,Ѫ��ֵ
		[2]=0.5,��Ѫ��ֵ
		[3]=1111,��ȴʱ��
	]]--
	return xbdata
end
--�õ���Ѫֵ
local function xb_getmaxhp( lv )
	if lv<40 then
		return 1000
	elseif lv<50 then
		return 2000
	elseif lv<60 then
		return 5000
	elseif lv<70 then
		return 10000
	elseif lv<80 then
		return 15000		
	else
		return 18000
	end
end

--����Ѫ����ֵ
function xb_setvalue( sid,value )
		  -- look('����Ѫ����ֵ',1)
		  -- look(value,1)
	if value<0 or value>1 then return end
	local xdata=xb_getpdata( sid )
	xdata[2]=value
	-- look(xdata,1)
	SendLuaMsg( 0, { ids = xb_updata,fz=xdata[2]}, 9 )
end


--ʹ�õ��߼�Ѫ��ֵ
function xb_useitem( sid,num )
	 -- look('ʹ�õ��߼�Ѫ��ֵ',1)
	local xdata=xb_getpdata( sid )
	if xdata==nil then 
		-- look(4,1)
		return 0 
	end
	if (xdata[1] or 0)>=2000000000 then 
		TipCenter(GetStringMsg(460))
		return 0
	end
	xdata[1]=(xdata[1] or 0)+num


	if xdata[1]>2000000000 then 
		xdata[1]=2000000000 
	end
	-- look(3,1)
	-- if not CI_HasBuff(10) then 
	-- 	-- look('��Ѫûbuf',1)
	-- 	CI_AddBuff(10,0,1,1)
	-- end
	 -- look(xdata[1],1)
	SendLuaMsg( 0, { ids = xb_updata,xb=xdata[1],itype=1}, 9 )
end
--buff�ص�,ʹ��Ѫ��
function xb_buffback(sid)
	 -- look('buff�ص�,ʹ��Ѫ��',1)
	 -- look(CI_GetPlayerData(3),1)
	local xdata=xb_getpdata( sid )
	if xdata==nil then return  end
	local now=GetServerTime()
	if now<(xdata[3] or 0) then 
		return 
	end

	local bili=xdata[2] or 0.65--��ֵ
	--local bili=0.5--��ֵ
	local maxhp=CI_GetPlayerData(26)
	local nowhp=CI_GetPlayerData(25)
	if nowhp<=0 then 
		return 
	end
	 -- look(xdata,1)

	if nowhp/maxhp>bili then 
		-- look(bili,1)
		 -- look(maxhp,1)
		-- look(nowhp,1)
		return
	end
	local have=xdata[1]--ӵ��ֵ
	-- look(have,1)
	if have==nil or have<=0 then return end
	local lv=CI_GetPlayerData(1)
	local canget=xb_getmaxhp( lv )
	if have<canget then 
		canget=have
	end
	local maxcanget=maxhp-nowhp
	if canget<=maxcanget then
		PI_PayPlayer(3,canget)
		xdata[1]=xdata[1]-canget
	else
		PI_PayPlayer(3,maxcanget)
		xdata[1]=xdata[1]-maxcanget
	end
	-- if xdata[1]<=0 then 
	-- 	-- Log('123.txt','ɾ��buf')
	-- 	CI_DelBuff(10)
	-- end
	-- look('����',1)
	xdata[3]=now+10
	SendLuaMsg( 0, { ids = xb_updata,xb=xdata[1],t=xdata[3]}, 9 )
end
-- --��½�ж��費��Ҫ��Ѫ��buff
-- function xb_onlogin( sid )
-- 	local xdata=xb_getpdata( sid )
-- 	if xdata==nil or xdata[1]==nil or xdata[1]<=0 then return  end
-- 	CI_AddBuff(10,0,1,1)
-- end