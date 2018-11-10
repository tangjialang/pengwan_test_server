--[[
file: span_1v1_l.lua
desc: ���1v1_���ذ�
autor: dzq
time:2014-5-4
]]--
local _random=math.random
local db_module = require('Script.cext.dbrpc')
local db_get_span_server = db_module.db_get_span_server
local common_time = require('Script.common.time_cnt')
local GetTimeToSecond = common_time.GetTimeToSecond
local msg_1v1_rank	 = msgh_s2c_def[47][1]--ÿ�����������������ǰ20������Ϣ�ظ�
local msg_matesucc = msgh_s2c_def[47][2]  --���߿ͷ���ƥ��ɹ�
local msg_1v1_all = msgh_s2c_def[47][3] 
local msg_isnot_enroll = msgh_s2c_def[47][4]--�Ƿ��Ѿ�����
local msg_worship_info = msgh_s2c_def[47][5]--���ظ��ͷ��˵�Ĥ����Ϣ
local msg_one_info = msgh_s2c_def[47][6]--������Ҹ��˿����Ϣ
local msg_quiz_ret = msgh_s2c_def[47][7] 
--local msg_leaveSpan_1v1 = msgh_s2c_def[47][8] --����뿪���
local msg_lv1_quiz = msgh_s2c_def[47][9] --������Ҿ�������
local msg_lv1_recive = msgh_s2c_def[47][10] --��Ҿ��º󷵻ص�����
local msg_worship = msgh_s2c_def[47][11]--���Ĥ�ݷ��ص���Ϣ
local SetEvent = SetEvent
local SPAN_1v1_ID= 7 --���1v1�id

local conf_1v1 = 
{
	-- enroll����
	[1] = 
	{
		tBegin = 0,tEnd = 3*24*3600,	
		--�����ж�����Ƿ��ڱ���ʱ��
		enstart = 3600*8,
		endsign_time=2.5*24*3600,---23.59����ʱ����2��С��3��ʱ֪ͨǰ̨��������
		--[[{
			{3600*8,3600*24},
			{24*3600 + 3600*8,3600*24*2},
			{3600*24*2 + 3600*8,3600*24*3},
		}--]]
	},
	--audition--��ѡ
	[2] = 
	{
		tBegin = 3*24*3600 + 1,tEnd = 4*24*3600,
	}, 
	--preliminaryԤ��
	[3] = 
	{
		tBegin = 4*24*3600 + 1,tEnd = 5*24*3600,
		--����ʱ�䷶Χ
		quizBegin = (4*24 + 8)*3600,quizEnd = (4*24+ 20)*3600 + 30*60,
	},
	--semifinals�����	
	[4] = 
	{
		tBegin = 5*24*3600 + 1,tEnd = 6*24*3600,
		--����ʱ�䷶Χ
		quizBegin = (5*24 + 8)*3600,quizEnd = (5*24+ 20)*3600 + 30*60,
	}, 
	--finals ����
	[5] = 
	{
		tBegin = 6*24*3600 + 1,tEnd = 7*24*3600,
		--����ʱ�䷶Χ
		quizBegin = (6*24 + 8)*3600,quizEnd = (6*24+ 20)*3600 + 30*60,
		--�����ڼ�Ĥ�ݷ�Χ
		worshipBg = 6*24*3600 + 21*3600 + 22*60,
	},
	--��ҫ����
	[6] = 
	{
		tBegin = 7*24*3600 + 1,tEnd = 10*24*3600,
	}, 
}
local award_1v1_conf = 
{
	--��ѡ����
	[2] = {813},
	--Ԥ������
	[3] = 
	{
		--��1��2������Ϊ�ȼ���Χ�������Ϊ��Ʒid  Ϊ����
		{1,10,{813,300}},
		{11,30,{813,200}},
		{31,100,{813,100}},
	},
	--���������
	[4] = 
	{	--��1��2������Ϊ�ȼ���Χ�������Ϊ��Ʒid  Ϊ����
		{1,3,{813,600}},
		{4,10,{813,500}},
		{11,32,{813,400}},
	},
	--��������
	[5] = 
	{
		--��1��2������Ϊ�ȼ���Χ�������Ϊ��Ʒid  Ϊ����
		{1,1,{1495,1}},
		{2,2,{813,900},{1517,1}},
		{3,3,{813,800},{1518,1}},
		{4,10,{813,700}},
	},
	
--�����ǿͷ����õ�
	--����123���Ľ���
	[6] =
	{
		--��һ������Ϊ����id �ڶ�������Ϊ����
		[1] = {{813,1000},{1516,1},{312,1}},
		[2] = {{813,900},{1517,1}},
		[3] = {{813,800},{1518,1}},
	},
	--������ʱ���
	[7] =
	{
		--ÿ���׶ε�ʱ��
		[1] = {"2014/07/12 00:00:00"},
		---ÿ������ʱ���
		[2] = {{"20:40:00","21:25:00"},{"20:40:00","21:20:00"},
                       {"20:40:00","21:20:00"},{"20:40:00","21:20:00"}},
		-- ÿ��ı�����ʼʱ��(�����Ҫ��ʾ��ʼʱ��)
		[3] = {"2014/05/19 20:40-21:25","2014/05/20 20:40-21:20","2014/05/21 20:40-21:20","2014/05/22 20:40-21:20"},
	},
	--����������
	[8] = {"��ѡ��","Ԥ��","�����","����"},
	--��õ���Ʒid
	[9] = {813},
}
--��ʼ��ʱ��
local initTime = GetTimeToSecond(2014,7,19,0,0,0)
--��ÿ��id
local function getspx_id()
	local spxb = GetSpanListData(SPAN_1v1_ID)
	if spxb == nil or spxb[1]==nil then return end
	local value = spxb[1][1]
	if(value) then
		return value[1]
	else
		return nil
	end	
end-- ȡv1����(��������)
--����itype��ʾ������� itype  1����������� 2�����������  3 ���������� 4�������
local function v1_getlocal_pub(itype)
	local active_lt = GetWorldCustomDB()
	if(active_lt.local1v1 == nil) then
		active_lt.local1v1 = {}
	end
	local pub_data = active_lt.local1v1
	if(itype) then
		--����������
		if(itype == 1) then
			pub_data.enroll1v1 = {}
		elseif(itype == 2) then
			pub_data.quiz1v1  = {}
		elseif(itype == 3) then
			pub_data.allplayer = {}
		elseif(itype == 4) then
			pub_data.times = 0
		end
	end	
	pub_data.quiz1v1 = pub_data.quiz1v1 or {}  --���澺������
	
	pub_data.enroll1v1 = pub_data.enroll1v1 or {}  --���汨������
	
	pub_data.allplayer = pub_data.allplayer or {} --�������������Ϣ
	
	pub_data.times = pub_data.times or 0          -- ����������
		
	pub_data.showtime = pub_data.showtime or 0      --���Ĥ�ݶ�ʱ������ʱ��
	
	--pub_data.isfirst = pub_data.isfirst or true  
	 
	return pub_data
end

--��ҿ��1v1��������
function v1_getplayerdata(sid)
	local act_data = GetDBActiveData(sid)
	if act_data == nil then return end
	if act_data.v1 == nil then
		act_data.v1 = {}
	end
	return act_data.v1
end
--ͨ�����id����������
local function getinfo_byid(sid,servid)
	local adata=v1_getlocal_pub()
	if adata==nil or adata.allplayer == nil then return end
	local allplayer =adata.allplayer

	for k,v in pairs(allplayer) do
		if(v.id == sid and v[3] == servid) then
			return k,v
		end
	end
	return 0,0
end
--�������֪ͨ���
function online_1v1(sid)
	--��������ʱ���
	--[[local enrollarea = in1v1time_area(3)
	 if(area == 1 and enrollarea) then
		RPCEx(sid,'enroll1v1_start')
	 elseif(area == 2 ) then
		 RPCEx(sid,'1v1audition_start')
	 elseif(area == 3) then
		 RPCEx(sid,'1v1preliminary_start')
	 elseif(area == 4) then	
		 RPCEx(sid,'1v1semifinals_start ')
	 elseif(area == 5) then
		 RPCEx(sid,'1v1semifinals_start')
	end--]]
	--ʱ����巶Χ
	local area = in1v1time_area(0)
	local spx_value = getspx_id()
	if(spx_value == nil) then
		return
	end	
	if(area == 0) then
		RPCEx(sid,'close_1v1_pic')
	elseif(area == 1) then
		local value = in1v1time_area(2)
		if(value == false) then
			RPCEx(sid,'close_1v1_pic')
		else
			RPCEx(sid,'open_1v1_pic')
		end
	else
		RPCEx(sid,'open_1v1_pic')
	end
end

--�жϵ�ǰʱ�䴦�ڻ���ĸ�ʱ���
--����ֵ 0���ڻ�ڼ� 1 ���� 2��ѡ 3 Ԥ�� 4����� 5 ����  6 ��ҫʱ��
--itype Ϊ0��ʾ��ǰ���ڱ����ĸ��׶� 1��ʾ�Ƿ��ھ���ʱ�䷶Χ 2��ʾ�Ƿ��ڱ���ʱ�䷶Χ 3��ʾ�Ƿ�ȫ������
--4��ʾ��Ƿ��ڿ�Ĥ�ݷ�Χ
function in1v1time_area(itype)
	local now = GetServerTime()
	if(itype == 0) then
		for i = 1,#conf_1v1 do
			if(now  > conf_1v1[i].tBegin + initTime and now  <= conf_1v1[i].tEnd + initTime) then
				if i==1 then
					if (now  > conf_1v1[i].endsign_time + initTime and now  <= conf_1v1[i].tEnd + initTime) then
					 	return i,true---��������
					end
				end
				return i
			end
		end
		return 0
	--�ж��Ƿ��ھ���ʱ�䷶Χ	
	elseif(itype == 1) then
		for i = 1,#conf_1v1 do
			if(conf_1v1[i].quizBegin and  conf_1v1[i].quizEnd ) then
				if(now  > conf_1v1[i].quizBegin + initTime and now  <= conf_1v1[i].quizEnd + initTime) then
					return true
				end
			end	
		end
		return false
	--�ж��Ƿ��ڱ���ʱ�䷶Χ	
	elseif(itype == 2) then
		--local list = conf_1v1[1][1]
		--local length = #list

		--for i = 1,length do
			--if(now > initTime + list[i][1] and now < list[i][2] + initTime) then
				--return true
			--end	
		--end
		--return false
		if(now >= initTime + conf_1v1[1].enstart and now < conf_1v1[2].tBegin + initTime) then
			return true
		else
			return false
		end
		
	--��Ƿ�ȫ������	
	elseif(itype == 3) then
		if(now > initTime + conf_1v1[6].tEnd) then
			return true
		else
			return false
		end
	--��Ƿ�����ҫ��Ĥ�ݷ�Χ
	elseif(itype == 4) then
		if(now > initTime + conf_1v1[5].worshipBg and now < initTime + conf_1v1[6].tEnd) then
			return true
		else
			return false
		end
	else
		return false
	end
end
--��ջ���
--[[local function clear_jf_1v1_l()
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.allplayer == nil) then
		return
	end	
	local allplayer = local_pub.allplayer
	for k,v in pairs(allplayer) do
		if(v) then
			v.jf = 0
		end	
	end
end	--]]
--���ʼ��ʱ��
function after_start_1v1(itype)
	 local area = in1v1time_area(0)
	 local spx_value = getspx_id()
	 if spx_value == nil or timearea == 0 then return end
	  
	  if(area == 1) then
		BroadcastRPC('enroll1v1_start')
	  elseif(area == 2 and itype == 2) then
		--����������
		--���������� ���Բ�����������
		--GI_1v1_local_times()
	 	BroadcastRPC('1v1audition_start')
	  elseif(area == 3 and itype == 3) then
		--GI_1v1_local_times()
	 	BroadcastRPC('1v1preliminary_start')
	  elseif(area == 4 and itype == 4) then	
		--GI_1v1_local_times()
	 	 BroadcastRPC('1v1semifinals_start ')
	  elseif(area == 5 and itype == 5) then
		--GI_1v1_local_times()
	 	BroadcastRPC('1v1semifinals_start')
	  else
	 	return
	  end
end
--���ʼ
function start_1v1(itype)
	-- -- ��ȡ���1v1������б�(�ص�����: CALLBACK_SpanServerGets)
	--�����������
	db_get_span_server(SPAN_1v1_ID,0)
	SetEvent(5, nil, 'after_start_1v1',itype) --5����������
end
--����ȡ�������������
local function _1v1_getsave_number(itype)
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.allplayer == nil) then
		return
	end	
	local allplayer = local_pub.allplayer
	local value
	if(itype == 2) then
		value = 100
	elseif(itype == 3) then
		value = 32
	elseif(itype == 4) then
		value = 8
	elseif(itype == 5) then
		value = 3
	end
	for k = 1,#allplayer do
		if(k > value) then
			allplayer[k] = nil
		else
			allplayer[k].jf = 0
		end
	end
end
 function end_1v1(itype)
	--�жϲ����ڵ�ǰʱ����ڱ���ʱ��
	local timearea,isend = in1v1time_area(0)
	local timesover = in1v1time_area(3)
	local spx_value = getspx_id()
	local local_pub = v1_getlocal_pub()
	if spx_value == nil or local_pub == nil then return end
	if(timearea == 1) then
		if  isend then 
			BroadcastRPC('enroll1v1_end')
		end
	elseif(timearea == 2 and itype == 2) then
		BroadcastRPC('1v1audition_end')
		--_1v1_getsave_number(itype)
		GI_1v1_local_times()

	elseif(timearea == 3 and itype == 3) then
		BroadcastRPC('1v1preliminary_end')
		--_1v1_getsave_number(itype)
		GI_1v1_local_times()

		--���󾺲½��
		--ask_lv1_quiz_ret(itype)
		--repley_1v1_quiz()
		SetEvent(15, nil,"repley_1v1_quiz")--15��󷢾��½���

	elseif(timearea == 4 and itype == 4) then	
		
		BroadcastRPC('1v1semifinals_end')
		--_1v1_getsave_number(itype)
		GI_1v1_local_times()

		--repley_1v1_quiz()
		SetEvent(15, nil,"repley_1v1_quiz")--15��󷢾��½���
		--���󾺲½��
		--ask_lv1_quiz_ret(itype)
	elseif(timearea == 5 and itype == 5) then
		BroadcastRPC('1v1finals_end')
		--_1v1_getsave_number(itype)
		GI_1v1_local_times()

		--repley_1v1_quiz()
		SetEvent(15, nil,"repley_1v1_quiz")--15��󷢾��½���
		--���󾺲½��	
		--ask_lv1_quiz_ret(itype)

		--ÿʮ���Ӵ���һ��Ĥ�ݸ��¶�ʱ��
		--GI_show_1v1_times()
		--SetEvent(600, nil,"GI_show_1v1_times",1)
		--��¼һ��ʱ�� ���ڶ�ʱ����
		local_pub.showtime = GetServerTime()
	elseif(timesover and itype == 6) then
		BroadcastRPC('1v1show_end')	
		--���ȫ��������ձ�������
		--clear_1v1_local()		
	else
		return
	end
end
--��������ʱ����ʱ����������
--function GI_1v1_local_time()
	
--end
--����¿�ʼ
function quiz_lv1_start(itype)
	local curtype = in1v1time_area(1)
	if(curtype == false) then
		return
	end	
	--Ԥ��ʱ��
	if(itype == curtype == 3) then
		--�����������
		v1_getlocal_pub(2)
		BroadcastRPC('quiz1v1_preliminary_start ')
	--�����ʱ��
	elseif(itype == curtype == 4) then
		--�����������
		v1_getlocal_pub(2)
		BroadcastRPC('quiz1v1_semifinals_start')
	--����ʱ��
	elseif(itype == curtype == 5) then
		--�����������
		v1_getlocal_pub(2)
		BroadcastRPC('quiz1v1_finals_start') 
	end
end
--����½���
function quiz_lv1_end(itype)
	local curtype = in1v1time_area(1)
	if(curtype == false) then
		return
	end	
	--Ԥ��ʱ��
	if(itype == curtype == 3) then
		BroadcastRPC('quiz1v1_preliminary_end  ')
	--�����ʱ��
	elseif(itype == curtype == 4) then
		BroadcastRPC('quiz1v1_semifinals_end ')
	--����ʱ��
	elseif(itype == curtype == 5) then
		BroadcastRPC('quiz1v1_finals_end') 
	end
end	
--����Ƿ���
function enroll_lv1_isnot(sid)
	local pdata=v1_getplayerdata(sid)
	if(pdata == nil) then
		return
	end		
	--ͨ�����ʼʱ���ж��Ƿ����������Ϣ
	if(pdata[7] ~= nil and pdata[7]~= initTime) then
		pdata[10] = false
	end
	local ret
	if(pdata[10]) then
		ret = 1
	else
		ret = 0
	end	

	local spx_value = getspx_id()
	if(spx_value == nil) then
		return
	end	
	--���߿ͷ�������Ƿ��� itype 0��ұ����Ļظ�  1��������Ƿ��� ret��ʾ�Ƿ��� 1 Ϊ���� 0Ϊû��
	SendLuaMsg(0, {ids=msg_isnot_enroll, ret=ret,itype = 1,spx_value = spx_value}, 9)
end
local function have_1v1_enroll(sid)
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.enroll1v1 == nil) then
		return
	end	
	local endata = local_pub.enroll1v1
	for k,v in pairs(endata) do
		if(v.id == sid) then
			return false
		end
	end
	return true
end
--��ұ���
function reg_1v1_sign(sid )
	--�ж�ս�����͵ȼ�
	local level = CI_GetPlayerData(1)
	local fight =  CI_GetPlayerData(62) --ս����
	local area = in1v1time_area(2)
	if(level < 55 or fight <50000 or area == false) then
		return
	end
	local pdata=v1_getplayerdata(sid)
	if pdata == nil then return end
	
	--ͨ�����ʼʱ���ж��Ƿ����������Ϣ
	if(pdata[7] ~= nil and pdata[7]~= initTime) then
		pdata[10] = false
	end
	local local_pub = v1_getlocal_pub()
	local endata = local_pub.enroll1v1
	local isenroll = have_1v1_enroll(sid)
	if(isenroll == false) then
		return
	end	
	if(pdata[10])then return end
	local basedata = PI_GetTsBaseData(sid)
	pdata.id = sid
	pdata.jf =pdata.jf or 0
	--��ұ���
	-- pdata[1] = pdata[1] or 0   --���ܵ���Ĥ�ݴ���
	-- pdata[2] = fight           --ս����
	pdata[3] = GetGroupID()	   --������serverid ��������Ҳ����Լ����
	-- pdata[4] = CI_GetPlayerData(3) --�������
	-- pdata[5] = basedata[4]     --�·�
	-- pdata[6] = basedata[5] --����
	pdata[7] = initTime  --�ѳ�ʼ��ʱ���¼�����������
	--pdata[8] --���ƥ�䵽�Ķ���id
	--pdata[9] --����Ƿ��ֿ�
	--pdata[10] -- ����Ƿ���
	--pdata[11] --���ʣ��Ĥ�ݴ���
	--[20]--   �Է�������id
	local svrid =getspx_id()
	if(svrid == nil) then
		return
	end	
	local pinfo={}

	pdata[1] = nil
	pdata[2] = nil           --ս����
	--pdata[3] = nil	   --������serverid
	pdata[4] = nil --�������
	pdata[5] = nil    --�·�
	pdata[6] = nil --����

	pinfo.jf = 0           --��ʼ����,������ǰ����,����ȥ
	pinfo.id = sid           --ԭ��sid
	pinfo[2] = fight           --ս����
	pinfo[3] = GetGroupID()	   --������serverid
	pinfo[4] = CI_GetPlayerData(3) --�������
	pinfo[5] = basedata[4]     --�·�
	pinfo[6] = basedata[5] --����
	PI_SendToSpanSvr(svrid,{ ids = 10001,info=pinfo})
		
end

--��ұ����ظ� 
function receive_1v1_sign(sid,ret)
	local pdata=v1_getplayerdata(sid)
	if(pdata==nil) then
		return
	end
	--�����ɹ�
	pdata[10] = true
	--���ػ��汨����Ϣ
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.enroll1v1 == nil) then
		return
	end	
	local endata = local_pub.enroll1v1
	local isenroll = have_1v1_enroll(sid)
	if(isenroll) then
		--table.insert(local_pub.enroll1v1,pdata)
		local_pub.enroll1v1[#local_pub.enroll1v1+1]=pdata
	else
		Log('���������쳣.txt',pdata)
		Log('���������쳣.txt',"���������쳣")
	end
	local spx_value = getspx_id()
	if(spx_value == nil) then
		return
	end	
	--���߿ͷ�������Ƿ��� itype 0��ұ����Ļظ�  1��������Ƿ��� ret��ʾ�Ƿ��� 1 Ϊ���� 0 Ϊû��
	SendLuaMsg(sid, {ids=msg_isnot_enroll, ret=ret,itype = 0,spx_value = spx_value}, 10)
end

--�յ�����������ظ�,res=1��Գɹ�,osid=��һ��ӳ�id
--style Ϊ1��ʾƥ�䵽����� 0��ʾ�ֿ�
function v1reg_get_kfref(info,style,jf,times)

	local pdata=v1_getplayerdata(info.id)
	local adata = v1_getlocal_pub()
	if(pdata == nil or adata == nil) then
		return
	end	
	--���ÿƥ��ɹ�һ�����������������
	if(adata.isfirst == nil) then
		--�㲥��Ϣ ����ǰ�˵���ʱ
		BroadcastRPC('1v1count_time',times)
		local curtimes = GetServerTime()
		SetEvent(60*3+48, nil,"GI_1v1_local_times")--2����18��ȡ������������
		adata.isfirst  = true		
	end
	
	pdata[8] = info[8] --����id
	pdata[20] = info[20] --����serverid
	pdata.id = info.id
	pdata[9]  = 0
	--�ֿյ�ʱ����������ڽ��������ж�
	if(style == 0) then
		pdata[9] = 1
	end
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.enroll1v1 == nil) then
		return
	end	
	local_pub.times = times
	--������������һ������style����ǰ̨����
	SendLuaMsg(info.id,{ids=msg_matesucc,info=info,style = style,times = times,jf = jf},10)
end

--ǰ̨ȷ������
function v1reg_endin(sid,pass, localIP, port, entryid)
	local spxb = GetSpanListData(SPAN_1v1_ID)
	--�ֿ��ж�
	local pdata=v1_getplayerdata(sid)
	if(pdata == nil) then 
		return 
	end
	if(pdata[9] == 1) then
		pdata[9]  = nil
		return
	end

	if spxb == nil or spxb[1]==nil or spxb[1][1] == nil then
		return
	end
	local sInfo = spxb[1][1]
	SetPlayerSpanUID(sid,SPAN_1v1_ID)
	local span_id = GetTargetSvrID(sInfo[1])
	local span_ip= sInfo[2]
	local span_port=sInfo[3]
	PI_PayPlayer(3,1000000,nil,nil,'���1v1')
	PI_EnterSpanServerEx(sid, span_id, span_ip, span_port, pass, localIP, port, entryid)
end
--���滺������
function save_1v1_front20(times,list,mark)
	local local_pub = v1_getlocal_pub()
	local allplayer = local_pub.allplayer
	if mark and mark == 1 then
		local_pub.allplayer = list
	else
		for k,v in pairs(list) do
			allplayer[k]=v
		end
	end
	--local_pub.allplayer = list
	--�㲥ǰ̨����ǰ̨������Ϣ
	if mark and mark == 3 and #local_pub.allplayer>0 then
	
		BroadcastRPC('1v1askinfo_20')
	end
	
	--local_pub.times = times
end
--����ÿ���������ǰ20����
function askinfo_1v1_front20(sid,itype)
	local area = in1v1time_area(0)
	local local_pub = v1_getlocal_pub()
	--���ڱ�����������ʱ�䷶Χ��
	if(local_pub == nil or local_pub.allplayer == nil or area == 0 or area == 1) then
		return
	end	
	local allplayer = local_pub.allplayer
	if(#allplayer ~= 0) then
		local times = local_pub.times
		repley_1v1_front20(sid,times,allplayer)
	else
		local pdata=v1_getplayerdata(sid)
		local group = GetGroupID()
		local serverid=getspx_id()
		if(serverid == nil) then
			return
		end	
		local_pub.allplayer[1]={}
		PI_SendToSpanSvr(serverid,{ ids = 10002,itype = itype,group = group})
	end	
end
--�����������������Ϣ
function askinfo_1v1_all(sid)
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.allplayer == nil) then
		return
	end
	local allplayer = local_pub.allplayer
	if(#allplayer == 0) then
		return
	end
	repley_1v1_all(sid,allplayer)	
	--������ڲ�����0��ʾ����������
	--[[if(#allplayer ~= 0) then
		repley_1v1_all(sid,allplayer)	
	else
	--��ʾû�л�������
		local pdata=v1_getplayerdata(sid)
		local group = pdata.group
		local serverid=getspx_id()
		PI_SendToSpanSvr(serverid,{ ids = 10003, playid = sid,group = group})
	end	--]]
end
--��ʱ������������Ϣ
function GI_1v1_local_times()
	local data = v1_getlocal_pub()
	local times = data.times
	local area = in1v1time_area(0)
	if(area == nil or area == 0) then
		return
	end
	--������������
	local group = GetGroupID()
	local serverid=getspx_id()
	if(serverid == nil) then
		return
	end	
	PI_SendToSpanSvr(serverid,{ ids = 10002,itype = itype,group = group})
	data.isfirst = nil	
end

--�����������ǰ20����Ϣ�Ļظ�
 function repley_1v1_front20(sid,times,list)
	local pdata=v1_getplayerdata(sid)
	local local_pub = v1_getlocal_pub()
	local allplayer = local_pub.allplayer
	--�������ݵ�����
	if(#allplayer == 0) then
		-- local group = GetGroupID()
		-- local serverid=getspx_id()
		-- PI_SendToSpanSvr(serverid,{ ids = 10002,itype = itype,group = group})
		-- return
	end	
	local rank,info = getinfo_byid(sid,GetGroupID())
	local jf
	if(type(info) == type(0)) then
		jf = 0
	else
		jf = info.jf
	end
	local value = {}
	
	for k = 1,20 do
		if(list[k]) then
			--table.insert(value,list[k])
			value[k] = list[k]
		end
	end
	SendLuaMsg(sid,{ids=msg_1v1_rank,rank = rank,times = times,list=value,jf = jf},10)
end
--���ػ����������������
function repley_1v1_all(sid,list)
	SendLuaMsg(sid,{ids=msg_1v1_all,list=list},10)
end

--������󾺲�����
function ask_lv1_quiz(sid,itype)
	local area = in1v1time_area(1)
	
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.quiz1v1 == nil or area == false) then
		return 
	end
	local quizdata = local_pub.quiz1v1
	local info = quizdata[sid]

	SendLuaMsg(0,{ids=msg_lv1_quiz,info=info},9)
	
end
--������Ҿ��½��
--function ask_lv1_quiz_ret(itype)
	--local sever =getspx_id()
	--local group = GetGroupID()
	--PI_SendToSpanSvr(sever,{ ids = 10007,itype = itype,group = group})
--end
--����ظ���ע
local function findData(id,sid1,sid2,sid3,num,itype,name,svrid1,svrid2,svrid3)
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.quiz1v1==nil) then
		return 
	end
	local quizdata = local_pub.quiz1v1
	
	if(quizdata[id]) then
		if quizdata[id].num + num>1000 then 
			return 
		end
		quizdata[id].sid1 =sid1
		quizdata[id].sid2 =sid2
		quizdata[id].sid3 =sid3
		quizdata[id].svrid1=svrid1--Ѻע3���ķ�����id
		quizdata[id].svrid2=svrid2
		quizdata[id].svrid3=svrid3
		quizdata[id].num = quizdata[id].num + num
		return quizdata[id]
	end
	local info ={id = id,itype = itype,sid1 = sid1,sid2 = sid2,sid3 = sid3,num = num,name = name,svrid1 = svrid1,svrid2 = svrid2,svrid3 = svrid3}
	quizdata[id] = info
	return info
end
--�յ���Ҿ������ݴ��� 
function quiz_lv1_quiz(id,itype,sid1,sid2,sid3,num,svrid1,svrid2,svrid3)
	--�ж���ҵ���ע����Ŀ
	if(type(num) ~= type(0) or num == 0 ) then
		return
	end
	local area = in1v1time_area(1)
	--����ʱ�䷶Χ��
	if(area == false) then
		SendLuaMsg(id,{ids=msg_lv1_recive,info=nil,ret = 0},10)
		return
	end	
	--���û��ѡ�񾺲����
	if(sid1 == nil and sid2 == nil and sid3 == nil) then
		SendLuaMsg(id,{ids=msg_lv1_recive,info=nil,ret = 0},10)
		return
	end	
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.quiz1v1==nil) then
		SendLuaMsg(id,{ids=msg_lv1_recive,info=nil,ret = 0},10)
		return 
	end
	--������Ŀ����һ��
	if(num*10 > 10000) then
		SendLuaMsg(id,{ids=msg_lv1_recive,info=nil,ret = 0},10)
		return  
	end
	--�жϽ�Ǯ�Ƿ��㹻
	if not CheckCost(id, num*10,1,1,'���¿۳�Ԫ��')  then
		SendLuaMsg(id,{ids=msg_lv1_recive,info=nil,ret = 0},10)
		return  
	end
	local name =  CI_GetPlayerData(3)
	--local quizdata = local_pub.quiz1v1
	local info = findData(id,sid1,sid2,sid3,num,itype,name,svrid1,svrid2,svrid3) 
	if(info == nil) then
		return
	end
	--���¿۳���Ǯ
	if not CheckCost(id, num*10,0,1,'���¿۳�Ԫ��')  then
		SendLuaMsg(id,{ids=msg_lv1_recive,info=nil,ret = 0},10)
		return  
	end
	SendLuaMsg(id,{ids=msg_lv1_recive,info=info,ret = 1},10)			
end
--���ؾ��½��
 function repley_1v1_quiz()	
	local local_pub = v1_getlocal_pub()
	
	--ȡǰ������Ϣ
	local allplayer = local_pub.allplayer
	if( allplayer == nil or local_pub == nil or local_pub.quiz1v1==nil) then
		return 
	end
	local sid1 = 0
	local sid2 = 0
	local sid3 = 0
	
	if type( allplayer[1] ) == type({}) and type(allplayer[1].id) == type(0) then sid1 = allplayer[1].id end
	if type( allplayer[2] ) == type({}) and type(allplayer[2].id) == type(0) then sid2 = allplayer[2].id end
	if type( allplayer[3] ) == type({}) and type(allplayer[3].id) == type(0) then sid3 = allplayer[3].id end
	
	local svrid1=  0
	local svrid2 = 0
	local svrid3 = 0
	
	if type( allplayer[1] ) == type({}) and type(allplayer[1][3]) == type(0) then svrid1 = allplayer[1][3] end
	if type( allplayer[2] ) == type({}) and type(allplayer[2][3]) == type(0) then svrid2 = allplayer[2][3] end
	if type( allplayer[3] ) == type({}) and type(allplayer[3][3]) == type(0) then svrid3 = allplayer[3][3] end
	local quizdata = local_pub.quiz1v1
	--�ȽϺ���
	for k,v in pairs(quizdata) do
		if type(k)==type(0) and  type(v)==type({}) then  
			if(sid1 and sid1 ~= 0 and sid1 == v.sid1 and svrid1 == v.svrid1) then
				v.times = (v.times or 0) + 1
			end	
			if(sid2 and sid2 ~= 0 and sid2 == v.sid2 and svrid2 == v.svrid2) then
				v.times = (v.times or 0)+ 1
			end	
			if(sid3 and sid3 ~= 0 and sid3 == v.sid3 and svrid3 == v.svrid3) then
				v.times = (v.times or 0) + 1
			end	
			if(v.times == nil) then
				v.times = 0
			end
			--ͳ����ע��
			local num  = v.num
			local value
			if(v.times == 0) then
				value = rint(num*1*10)
			elseif(v.times  == 1) then
				value = rint(num*1.5*10)
			elseif(v.times  == 2) then
				value = rint(num*2*10)
			elseif(v.times  == 3) then
				value = rint(num*3*10)
			end	
			--���ʼ�
			local name = v.name
			if(name ~= nil)  then
				local AwardList={[3]={{813,value,1},}}
				SendSystemMail(name,MailConfig.Kf1v1_quiz,1,2,{v.times},AwardList)	
				SendLuaMsg(v.id,{ids=msg_quiz_ret,info=v},10)
				quizdata[k] = nil
			end	
		end		
	end
	--�����������
	local_pub.quiz1v1 = {}
end
--�����Ʒ��������
--sid ���id
--itype ��������
--rank ��������
local function get_1v1_rankaward(sid,itype,rank,jf)
	if(itype < 2 or itype > 5 or sid == nil or rank == 0) then
		return
	end	
	local AwardList
	if(itype == 2) then
		if(jf > 80) then
			jf = 80
		elseif(jf < 50 ) then
			jf = 50
		end	
		AwardList={[3]={{award_1v1_conf[2][1],jf,1},}}
		return AwardList
	end
	local length = #award_1v1_conf[itype]
	for i = 1,length do
		local down = award_1v1_conf[itype][i][1]
		local up = award_1v1_conf[itype][i][2]
		if(down == nil or up == nil ) then
			return
		end	
		if(rank >= down and rank <= up) then
			local num = 3
			local list = award_1v1_conf[itype][i]
			AwardList={[3]={}}
			while(list[num]) do		
				local id = list[num][1]
				local number = list[num][2]
				local temp = {id,number,1}
				table.insert(AwardList[3],temp)
				num = num +1
			end
			return AwardList
		end
	end
end
--����������Ϣ����,����������
function gameover_1v1_award(itype,info,rank)
	--�����ʼ�
	if(info == nil or info[4] == nil) then
		return
	end	
	local name = info[4]
	local AwardList = get_1v1_rankaward(info.id,itype,rank,info.jf)
	if(name ~= nil) then
		local areavalue
		if(itype == 2) then--ȡǰ100��
			areavalue = 100
		elseif(itype == 3) then--ȡǰ32��
			areavalue = 32
		elseif(itype == 4) then--ȡǰ8��	
			areavalue = 8
		elseif(itype == 5) then	--3
			areavalue = 3
		end
		if rank<=areavalue then --����,��ʾ��ͬ
			SendSystemMail(name,MailConfig.Kf1v1_over_award_jj,1,2,{rank},AwardList)
		else
			SendSystemMail(name,MailConfig.Kf1v1_over_award,1,2,{rank},AwardList)
		end  
	end	
end
--[[function repley_leaveSpan_1v1(info)
	SendLuaMsg(info.id,{ids=msg_leaveSpan_1v1,info=info},10)
end--]]
--���Ĥ��
function worship_lv1(sid,id,index)
	--worship
	local pdata=v1_getplayerdata(sid)
	local area = in1v1time_area(4)
	if(area == false) then
		SendLuaMsg(sid,{ids=msg_worship,times = pdata[11],ret = ret},10)
		return
	end
	--��¼ÿ����ҵ�Ĥ�ݴ���
	if(pdata[11] == nil) then
		pdata[11] = 3
	end	
	local ret 
	if(pdata[11] <= 0) then
		--���ظ��ͷ���
		ret = 0
		SendLuaMsg(sid,{ids=msg_worship,times = pdata[11],ret = ret},10)
		return
	else
		--���ظ��ͷ���
		pdata[11] = pdata[11] -1
		ret = 1
		--���Ĥ�ݻ�ý���
		local level = CI_GetPlayerData(1)
		GiveGoods(0,1000*level,1,'���Ĥ�ݻ�ý���')	
		SendLuaMsg(sid,{ids=msg_worship,times = pdata[11],ret = ret},10)		
	end	
	local serverid = getspx_id()
	if(serverid == nil) then
		return
	end	
	PI_SendToSpanSvr(serverid,{ ids = 10004,desid = id,index = index})

end
--���Ĥ����ҫ
local function show_1v1_times()
	local area = in1v1time_area(4)
	local serverid=getspx_id()
	if(serverid == nil or area == false) then
		return
	end	
	local group = GetGroupID()
	--����������Ϣ
	PI_SendToSpanSvr(serverid,{ ids = 10005,group = group})
end
--����Ĥ����Ϣ����
function save_1v1_worship(list)
	local local_pub = v1_getlocal_pub()
	if(local_pub == nil or local_pub.showtime == nil) then
		return
	end	
	--��Ĥ�ݵĴ�����ֵ����������
	local allplayer = local_pub.allplayer
	for k = 1,3 do
		if(allplayer[k] and list[k]) then
			allplayer[k][1] = list[k]
		end
	end
	--BroadcastRPC('1v1_worship',list)
	
end
--���������Ĥ����Ϣ
function ask_worship_lv1(sid)
	local area = in1v1time_area(4)
	local data = v1_getplayerdata(sid)
	local wtimes = data[11]
	if(area == false) then
		return
	end	
	local local_pub = v1_getlocal_pub()
	--���ڱ�����������ʱ�䷶Χ��
	if(local_pub == nil or local_pub.showtime == nil) then
		return
	end	
	local list = {}
	for k = 1,3 do
		if(local_pub.allplayer[k]) then
			list[k] = local_pub.allplayer[k]
		end
	end
	SendLuaMsg(sid,{ids=msg_worship_info,wtimes = wtimes,list= list},10)
	--������ں�ʱ��ͼ�¼��ʱ�䳬��10���ӣ�������������
	local curtimes = GetServerTime()
	if(curtimes - local_pub.showtime > 60*10) then
		show_1v1_times()
		local_pub.showtime = curtimes
	end
end
--���������Ϣ
function clear_1v1_enroll(sid)
	local pdata=v1_getplayerdata(sid)
	if(pdata == nil) then return end
	pdata[10] = false
end
--Ĥ�ݴ�������
function refresh_worship_lv1(sid)
	local area = in1v1time_area(4)
	if(area == false) then
		return
	end
	local pdata=v1_getplayerdata(sid)
	if(pdata == nil) then
		return
	end	
	pdata[11] = 3
end
--��ձ�������
function clear_1v1_local()
	local active_lt = GetWorldCustomDB()
	active_lt.local1v1 = {}
end

--�鿴����
--[[function test1()
	--local pdata=v1_getplayerdata(sid)
	local local_pub = v1_getlocal_pub()
	local allplayer = local_pub.quiz1v1
	look(allplayer,1)
end--]]


--���������ǰ����Ҫ����
function v1_clearnotusedata( sid )
	local pdata=v1_getplayerdata(sid)
	if pdata==nil then return end
	pdata.name=nil
	pdata.opposite=nil
	pdata.fight=nil
	pdata.cloth=nil
	pdata.group=nil
	pdata.weapon=nil

	pdata[1] = nil
	pdata[2] = nil           --ս����
	--pdata[3] = nil	   --������serverid
	pdata[4] = nil --�������
	pdata[5] = nil    --�·�
	pdata[6] = nil --����

end

--�����ұ���key��������
function v1_clearkeylocal()
	local local_pub = v1_getlocal_pub()
	local allplayer = local_pub.allplayer
	for k,v in pairs(allplayer) do
		if type(k) == type(0) and type(v) == type({}) then
			v.weapon = nil
			v.group = nil
			v.cloth = nil
			v.fight = nil
			v.opposite = nil
			v.name = nil
			v.num = nil
			v.enroll = nil
		end
	end
end

------���Ա���2000�����-----
function sign_1v1_2000(sid)
	local basedata = PI_GetTsBaseData(sid)
	local svrid =getspx_id()
	if(svrid == nil) then
		return
	end	
	local pinfo={}
	pinfo.jf = 0           --��ʼ����,������ǰ����,����ȥ
	pinfo.id = 12345678           --ԭ��sid
	pinfo[2] = 8235789           --ս����
	pinfo[3] = GetGroupID()	   --������serverid
	pinfo[4] = CI_GetPlayerData(3)..tostring(i) --�������
	pinfo[5] = basedata[4]     --�·�
	pinfo[6] = basedata[5] --����
	for i=1,2000 do
		pinfo.id=pinfo.id+1
		pinfo[2]=pinfo[2]+1
		pinfo[4] = CI_GetPlayerData(3)..tostring(i)
		PI_SendToSpanSvr(svrid,{ ids = 10001,info=pinfo})
	end
	
end






