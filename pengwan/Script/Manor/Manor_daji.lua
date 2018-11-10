--[[
	file:	妲己系统
	author:	wk
	update:	2013-2-4
	refix:	done by wk
--]]

local SendLuaMsg 	 = SendLuaMsg
local msgh_s2c_def	 = msgh_s2c_def
local np_hg	 = msgh_s2c_def[26][1]	
local open	 = msgh_s2c_def[26][2]
local nv_sx	 = msgh_s2c_def[26][3]	
local reset	 = msgh_s2c_def[26][4]		
local AddPlayerPoints=AddPlayerPoints
local isFullNum,PI_PayPlayer,GiveGoods=isFullNum,PI_PayPlayer,GiveGoods
local CheckCost	 = CheckCost
local CheckGoods,GetServerTime	 = CheckGoods,GetServerTime
--local look = look
local common 			= require('Script.common.Log')
local Log 				= common.Log
local _random=math.random
local GetRWData=GetRWData
local PI_UpdateScriptAtt=PI_UpdateScriptAtt
local obj_set = require('Script.Achieve.fun')
local set_obj_pos = obj_set.set_obj_pos

local e_time=12  --女仆每日双修次数
local lk_item={{691,25},}--加好感度道具{id,好感度}

--女仆配置
local nvpu_conf={
	[1]={---1号女仆
		maxlv=300,--最大等级
		needitem={415,0},--开启需要道具id,个数
		needmoney={5,30000},---需要铜钱相关
		---att_get={1111,222},----属性相关值
		att={[1]={0,5},[3]={0,2},[9]={0,1},},--属性类型
		lkconf={ --[1]好感度[2]等级需要好感度[3]对应属性加成	
			[1]={"冷淡",0,0},
			[2]={"普通",500,5},
			[3]={"友好",1500,15},
			[4]={"熟悉",3000,25},
			[5]={"热情",5000,35},
			[6]={"默契",7500,45},
			[7]={"喜欢",10500,55},
			[8]={"心动",14000,65},
			[9]={"爱慕",18000,80},
			[10]={"崇拜",22500,100},
			},
	},
	[2]={---2号女仆
		maxlv=300,--最大等级
		needitem={199,1},--开启需要道具个数
		needmoney={10,60000},
		---att_get={1111,222},----属性相关值
		att={[4]={0,5},[6]={0,2},[8]={0,2},},
		lkconf={ --[1]好感度[2]等级需要好感度[3]对应属性加成	
			[1]={"冷淡",0,0},
			[2]={"普通",1000,5},
			[3]={"友好",3000,15},
			[4]={"熟悉",6000,25},
			[5]={"热情",10000,35},
			[6]={"默契",15000,45},
			[7]={"喜欢",21000,55},
			[8]={"心动",28000,65},
			[9]={"爱慕",36000,80},
			[10]={"崇拜",45000,100},
			},
	},
	[3]={---3号女仆
		maxlv=300,--最大等级
		needitem={198,10},--开启需要道具个数
		needmoney={20,120000},
		---att_get={1111,222},----属性相关值
		att={[3]={0,10},[7]={0,4},[5]={0,4},},
		lkconf={ --[1]好感度[2]等级需要好感度[3]对应属性加成	
			[1]={"冷淡",0,0},
			[2]={"普通",2000,5},
			[3]={"友好",6000,15},
			[4]={"熟悉",12000,25},
			[5]={"热情",20000,35},
			[6]={"默契",30000,45},
			[7]={"喜欢",42000,55},
			[8]={"心动",56000,65},
			[9]={"爱慕",72000,80},
			[10]={"崇拜",90000,100},
			},
	},
	[4]={---4号女仆
		maxlv=300,--最大等级
		needitem={197,1},--开启需要道具个数
		needmoney={20,150000},
		---att_get={1111,222},----属性相关值
		att={[1]={0,30},[4]={0,10},[6]={0,3},},
		lkconf={ --[1]好感度[2]等级需要好感度[3]对应属性加成	
			[1]={"冷淡",0,0},
			[2]={"普通",2000,5},
			[3]={"友好",6000,15},
			[4]={"熟悉",12000,25},
			[5]={"热情",20000,35},
			[6]={"默契",30000,45},
			[7]={"喜欢",42000,55},
			[8]={"心动",56000,65},
			[9]={"爱慕",72000,80},
			[10]={"崇拜",90000,100},
			},
	},
	[5]={---5号女仆
		maxlv=300,--最大等级
		needitem={196,1},--开启需要道具个数
		needmoney={30,300000},
		---att_get={1111,222},----属性相关值
		att={[1]={0,50},[3]={0,10},[4]={0,10},},
		lkconf={ --[1]好感度[2]等级需要好感度[3]对应属性加成	
			[1]={"冷淡",0,0},
			[2]={"普通",4000,5},
			[3]={"友好",12000,15},
			[4]={"熟悉",24000,25},
			[5]={"热情",40000,35},
			[6]={"默契",60000,45},
			[7]={"喜欢",84000,55},
			[8]={"心动",112000,65},
			[9]={"爱慕",144000,80},
			[10]={"崇拜",180000,100},
			},
	},
}
--定义妲己数据
local function GetDBDJData( playerid )
	local djData=GI_GetPlayerData( playerid , 'dj' , 100 )
	if djData == nil then return end
	if djData.last==nil then
			djData.lk={0,}--每个女仆好感度
			djData.last=GetServerTime()--cd
			--[1]={0,}--每个女仆双修等级
			--[2]=2--女仆双修次数

		end
	return djData
end
--秒cd
function dj_passcd( playerid ,itype)
	-- look('秒cd',1)
	local djdata=GetDBDJData( playerid )
	if djdata ==nil   then return end
	local now=GetServerTime()
	local _time=(djdata.last or 0)
	if _time<=now then return end
	local money=math.ceil((_time-now)/300)*1
	if itype==1 then 
		local nowp=GetPlayerPoints(playerid,3)
		if nowp==nil then  return  end 
		if nowp<money*5 then return end
			
		AddPlayerPoints( playerid , 3 , -money*5,nil,'100018_购买女仆cd',true )
	else

		if not CheckCost(playerid , money, 0 , 1,'100018_购买女仆cd') then
			
			return
		end
	end
	djdata.last=0
	--SendLuaMsg(0,{ids=djgame,itype=3,last=djdata.last},9)
	SendLuaMsg(0,{ids=reset,res=2},9)
end
--取好感度等级_平移至果园,一次性,亲密度清空,风险大,注意!!
function GETDJ_gardenadd_one(playerid,index)
	if playerid==nil    then return end
	local djdata=GetDBDJData( playerid )
	djdata.lk = djdata.lk or {}
	if index ==nil then 
		index=1
	end
	local lk= djdata.lk[index] or 0
	local num
	local DJconf=nvpu_conf[index].lkconf
	for i=1,10 do 
		if lk<DJconf[i][2] then
			num=i-1
			break
		end
	end	
	if lk>=DJconf[10][2] then 
		num=10
	end

	djdata.lk[index]=0---清空

	return num
end
--取好感度
function GETDJ_gardenadd(playerid,index)
	if playerid==nil    then return end
	local djdata=GetDBDJData( playerid )
	djdata.lk = djdata.lk or {}
	if index ==nil then 
		index=1
	end
	local lk= djdata.lk[index] or 0
	local num
	local DJconf=nvpu_conf[index].lkconf
	for i=1,10 do 
		if lk<DJconf[i][2] then
			num=i-1
			break
		end
	end	
	if lk>=DJconf[10][2] then 
		num=10
	end
	return num
end
--道具使用（加女仆好感度）
function DJitemaddliking(playerid,index,num)
	if playerid==nil  or index==nil or num==nil then return end
	local djdata=GetDBDJData( playerid )
	if djdata == nil then return end
	djdata.lk = djdata.lk or {}
	local oldelv=GETDJ_gardenadd(playerid,index)

	local goods=lk_item[1]
	if 0 == CheckGoods(goods[1],num,0,playerid,'加女仆好感度') then
		return
	end

	djdata.lk[index]=(djdata.lk[index] or 0)+goods[2]*num--加好感度公式
	--SendLuaMsg(0,{ids=djgame,itype=3,lk=djdata.lk},9)
	SendLuaMsg(0,{ids=np_hg,index=index,hg=djdata.lk[index]},9)

	local nowlv=GETDJ_gardenadd(playerid,index)
	if nowlv>oldelv then 
		np_attup( playerid ,1)
	end
end
--开启女仆
function np_opennvpu( playerid,index )
	local djdata=GetDBDJData( playerid )
	if djdata == nil then return end
	if djdata.lk[index]~=nil then return end

	local goods=nvpu_conf[index].needitem

	if 0 == CheckGoods(goods[1],goods[2],0,playerid,'开启女仆') then
		return
	end

	djdata.lk[index]=(djdata.lk[index] or 0)
	SendLuaMsg(0,{ids=open,index=index},9)
end

--双修index为女仆编号,itype=1为使用元宝双倍标识
function np_shuangxiu(playerid,index ,itype )
	-- look('双修index为女仆编号',1)
	-- look(index,1)
	-- look(itype,1)
	local djdata=GetDBDJData( playerid )
	if djdata == nil then return end
	if djdata.lk[index]==nil then return end

	local now=GetServerTime()
	if (djdata.last or 0)>now+40*60 then return end

	if djdata[1]==nil then -- 等级
		djdata[1]={}
	end
	
	local maxlv=nvpu_conf[index].maxlv
	local lv=djdata[1][index] or 0
	local _time=djdata[2] or 0
	if lv>=maxlv or _time>=e_time then return end
	local needmoney=nvpu_conf[index].needmoney[2]

	--local needmoney=(lv+1)*nvpu_conf[index].needmoney[1]+nvpu_conf[index].needmoney[2]
	if itype==1 then 
		if not CheckCost(playerid , needmoney, 1 , 3,'双修') then
			return
		end
		local needyb=nvpu_conf[index].needmoney[1]
		if not CheckCost(playerid , needyb, 0 , 1,'双倍双修') then
			return
		end
		if not CheckCost(playerid , needmoney, 0 , 3,'双修') then
			return
		end
		djdata[1][index]=lv+2
		if djdata[1][index]>maxlv then
			djdata[1][index]=maxlv
		end
	else
		
		if not CheckCost(playerid , needmoney, 0 , 3,'双修') then
			return
		end
		djdata[1][index]=lv+1
	end
	
	djdata[2]=_time+1
	if djdata.last<now then
		djdata.last=now+20*60
	else
		djdata.last=djdata.last+20*60
	end
	np_attup( playerid ,1)
	set_obj_pos(playerid,1005)
	SendLuaMsg(0,{ids=nv_sx,index=index,lv=djdata[1][index],_time=djdata[2],last=djdata.last},9)
end
--重置
function np_reset( playerid )
	local djdata=GetDBDJData( playerid )
	if djdata == nil then return end
	if djdata[2]==nil then return end--次数
	djdata[2]=nil
	SendLuaMsg(0,{ids=reset,res=1},9)
end
--加属性,itype=1在线操作升级更新
function np_attup( playerid ,itype)
	--look('人物属性更新')
	local djdata=GetDBDJData( playerid )
	if djdata == nil then return end
	local AttTable =GetRWData(1)
	if djdata[1]==nil then return end

	local att,lv,lk
	
	for k,v in pairs(djdata[1]) do
		if type(k)==type(0) and type(v)==type(0) then 
			if nvpu_conf[k] then 
				att=nvpu_conf[k].att
				lv= GETDJ_gardenadd(playerid,k) 
				-- look(lv,1)
				lk=nvpu_conf[k].lkconf[lv][3]
				
				for j,h in pairs(att) do
					
					--local up=v*h[2]+(1+v)*v/2/h[1]
					local up=v*h[2]
					AttTable[j]=(AttTable[j] or 0)+rint(up*(lk+100)/100)
				end
			end
		end
	end

	if itype==1 then --在线操作升级更新
		 PI_UpdateScriptAtt(playerid,ScriptAttType.nvpu)
	end
	return true
end




----- 测试----
function nvpu_uplv( playerid,index ,num )
	local djdata=GetDBDJData( playerid )
	if djdata == nil then return end
	if djdata[1]==nil then 
		djdata[1]={}
	end
	djdata[1][index]=num
	np_attup( playerid ,1)
	SendLuaMsg(0,{ids=nv_sx,index=index,lv=djdata[1][index],_time=djdata[2],last=djdata.last},9)
end







-- --[1]好感度[2]等级需要好感度[3]对应属性加成
-- local DJconf={	
-- 			[1]={"冷淡",0,0},
-- 			[2]={"普通",100,5},
-- 			[3]={"友好",300,15},
-- 			[4]={"熟悉",700,25},
-- 			[5]={"热情",1400,35},
-- 			[6]={"默契",2400,45},
-- 			[7]={"喜欢",3700,55},
-- 			[8]={"心动",5300,65},
-- 			[9]={"爱慕",7300,80},
-- 			[10]={"崇拜",10300,100},
-- 			}
--[1]好感度,[2]日恢复体力,[3]开放功能,[4]随从对应奖励功能{[1]=对果园加成...},[5]需要好感度
--开放功能(1献舞,2弹奏,3诱惑,4沐浴)
--对果园加成({收益提高2%,时间缩短10%})

-- local DJconf={	
-- 			[1]={"冷淡",6,1,{{0,0},},0},
-- 			[2]={"普通",10,1,{{10,0},},200},
-- 			[3]={"友好",15,2,{{20,0},},600},
-- 			[4]={"熟悉",20,2,{{30,0},},2000},
-- 			[5]={"热情",25,3,{{40,0},},4000},
-- 			[6]={"默契",30,3,{{50,5},},8000},
-- 			[7]={"喜欢",35,4,{{60,10},},12000},
-- 			[8]={"心动",40,4,{{70,15},},16000},
-- 			[9]={"爱慕",45,4,{{80,20},},20000},
-- 			[10]={"崇拜",50,4,{{100,30},},30000},
-- 			}
-- --小游戏奖励
-- local function little_gamegift(playerid)
-- 	local lv=CI_GetPlayerData(1)
-- 	local rannum=_random(1,3)
-- 	local resnum
-- 	if rannum==1 then
-- 		resnum=lv^2*5
-- 		PI_PayPlayer(1, resnum,0,0,'女仆游戏')
-- 	elseif rannum==2 then
-- 		resnum=lv^2*3
-- 		GiveGoods(0,resnum,0,'小游戏奖励')
-- 	else
-- 		resnum=lv^2*3
-- 		AddPlayerPoints( playerid , 2 , resnum ,nil,'女仆游戏')
-- 	end
-- 	return rannum,resnum
-- end	

-- local function dj_vipup(playerid)
-- 	local viplv = GI_GetVIPLevel(playerid) or 0
-- 	if viplv<5 then
-- 		return 1
-- 	elseif viplv<9 then 
-- 		return (viplv*10+100)/100
-- 	else
-- 		return 2
-- 	end
-- end

-- --小游戏（result=1赢，2平，3输）
-- function DJlittlegame(playerid,game,num,djnum)
-- 	local pakagenum = isFullNum()
-- 	if pakagenum < 1 then
-- 		return
-- 	end
-- 	if playerid==nil or game==nil or num==nil then return end
-- 	local djdata=GetDBDJData( playerid )
-- 	if djdata ==nil     then return end
-- 	if not  CheckTimes(playerid,uv_TimesTypeTb.DJ_Time,1,-1) then return end 

-- 	local now=GetServerTime()

-- 	if (djdata.last or 0)>now+40*60 then return end

-- 	if djdata.win==nil then
-- 		djdata.win={}
-- 	end
-- 	local win=djdata.win[djnum] or 0
-- 	local winrate=80-win*10
-- 	if winrate<10 then
-- 		winrate=10
-- 	end
-- 	djdata.lk = djdata.lk or {}
-- 	local result=0
-- 	local rannum=_random(1,100)
-- 	if rannum<=winrate then
-- 		result=1
-- 		djdata.lk[1]=(djdata.lk[1] or 0)+rint(10*dj_vipup(playerid))
-- 		djdata.win[djnum]=win+1
		
-- 		if win+1>2 then
-- 			local itemid=win+1104
-- 			if itemid>1113 then
-- 				itemid=1113
-- 			end
-- 			GiveGoods(itemid,1,1,'妲己游戏')
-- 		end
-- 	else
-- 		djdata.lk[1]=(djdata.lk[1] or 0)+rint(5*dj_vipup(playerid))
-- 		djdata.win[djnum]=nil
-- 	end
-- 	local num1=0
-- 	local num2=0
-- 	if game==1 then
-- 		if result==0 then
-- 			num1=_random(2,6)
-- 			num2=_random(1,num1-1)
-- 		else
-- 			num2=_random(2,6)
-- 			num1=_random(1,num2-1)
-- 		end
-- 	else
-- 		num2=num
-- 		 if result==0 then
-- 			num1=num2-1
-- 			if num1<1 then
-- 				num1=num2+2
-- 			end
-- 		else
-- 			num1=num2+1
-- 			if num1>3 then
-- 				num1=num2-2
-- 			end
-- 		end
-- 	end
-- 	--local elsetype ,elsenum=little_gamegift(playerid)
-- 	if djdata.last<now then
-- 		djdata.last=now+20*60
-- 	else
-- 		djdata.last=djdata.last+20*60
-- 	end
-- 	SendLuaMsg(0,{ids=djgame,itype=1,lk=djdata.lk,win=djdata.win,game=game,num1=num1,num2=num2,last=djdata.last,djnum=djnum,elsetype=elsetype,elsenum=elsenum},9)	
-- end

--返回果园加成{收益提高2%,时间缩短10%}

