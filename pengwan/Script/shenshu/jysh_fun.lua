--[[
   file:jysh_fun.lua
   desc:��������
   author:tjl
   updata:2018-11-7
]]--
identification = identification or 1         -- �������������� �ָ������������ʶ

--������Ϣ
local msgh_s2c_def     = msgh_s2c_def;       -- ��ȡ��Ϣ������
local msg_seed         = msgh_s2c_def[51][1] -- ��ֲ
local msg_open         = msgh_s2c_def[51][2] -- ��ʵ����
local msg_otherclick   = msgh_s2c_def[51][3] -- ����鿴�� 
local msg_refresh      = msgh_s2c_def[51][4] -- ˢ��
local msg_obtain       = msgh_s2c_def[51][5] -- ժȡ
local msg_steal        = msgh_s2c_def[51][6] -- ͵ȡ
local msg_steal_succed = msgh_s2c_def[51][7] -- ͵ȡ�ɹ����
local msg_restart      = msgh_s2c_def[51][8] -- ����������ˢ����������
local msg_distance     = msgh_s2c_def[51][9] -- �жϾ���

--�����ļ�
local conf      = require("Script.shenshu.jysh_cof") --���������ļ�
local jysh      = conf.jysh                          --������ʵ������
local open      = conf.open                          --������ʵ������������
local cishu     = conf.cishu
local tree_conf = conf.tree_conf                     --�������������

--��Ϸͨ�ù�����չģ��
local define = require("Script.cext.define")  --ȫ�ֶ����

--ȫ�ָ�������
local rint             = rint              --ȥ��С��λ
local look             = look              --��ӡ��ʾ��Ϣ
local random           = math.random       --�����
local abs              = math.abs          --�෴��
local Log              = Log               --��־
local GI_GetPlayerData = GI_GetPlayerData  --����ռ�
local GetServerTime    = GetServerTime     --�õ���������ǰʱ��
local SetEvent         = SetEvent          --����ʱ���ִ��һ������ ����Ϊ����
local jy_TimesTypeTb   = TimesTypeTb       --����������(��ֲ ˢ�µĴ�����������)
local SendLuaMsg       = SendLuaMsg        --������Ϣ����ǰ���
local GetWorldCustomDB = GetWorldCustomDB  --��ȡ��ʱ��ҵ���������(��������)
local BroadcastRPC     = BroadcastRPC      --����㲥
local AreaRPC          = AreaRPC           --����㲥
local CI_SetReadyEvent = CI_SetReadyEvent  --���ö�ռ�����¼�
local ProBarType       = define.ProBarType --��������
local CheckTimes       = CheckTimes        --������ ����������
local SendSystemMail   = SendSystemMail    --����ϵͳ����
local MailConfig       = MailConfig        --��������

--��ý�ɫ��صĺ���
local CI_GetCurPos     = CI_GetCurPos      --�õ���ǰλ��
local CheckGoods       = CheckGoods        --������
local CI_GetPlayerData = CI_GetPlayerData  --��ȡ�û��ȼ�
local PI_PayPlayer     = PI_PayPlayer      --����ȼ��ӳ�
local CheckCost        = CheckCost         --���˫������֧��Ԫ��
local GetCurPlayerID   = GetCurPlayerID    --�õ���ǰ���ID

--�õ���ʱ����(������������ñ���������ʱ������ ��ʱ����������������߻��߷������رպ�ʱ�����)
local GetPlayerTemp_custom = GetPlayerTemp_custom --�õ���ҳ��õ���ʱ������

--����ģ�͸������κ���
local CreateGroundItem     = CreateGroundItem     --��ʵ���ش�����ģ��
local CreateObjectIndirect = CreateObjectIndirect --��������ģ��
local CI_UpdateMonsterData = CI_UpdateMonsterData --��������ģ�����
local CI_DelMonster        = CI_DelMonster        --ɾ��ģ��

--luaȫ�ֺ�����local����
local type  = type  --���������ж�
local pairs = pairs --������
local __G   = _G    --ȫ�ֻ�����

module(...)

--�õ���������
local function get_af_data( )

    local getwc_data = GetWorldCustomDB()
    if nil == getwc_data then 
        return 
    end

    if nil == getwc_data.wc_data then
        getwc_data.wc_data = {}
    end

    return getwc_data.wc_data;
end

--ÿ�η�����������������ֲ�˾���������ҵĲ���
local function _Data_Load(itype)
    if itype == 1 then
        if __G.identification == 1 then
            __G.identification = 2
        else
            return
        end
    end
    local wc_data = get_af_data() --�õ�����������������
    local buchang_table = {[3] = {{1503,10,1},}} --���貹�� �ͼ������ʵ
    for key, value in pairs(wc_data) do
        if type(key) == type(0) and type(value) == type({}) then --keyֵΪnumber���� valueΪtable����
            local user_name = wc_data[key].name      --��������
            local headID = wc_data[key].headID       --����ͷid ͨ�����id������������ɫ(�ȼ�)
            local tree_color = (rint(headID / 10)) % 10 --������ɫ
            local tou = wc_data[key].tou             --��û��С͵
            local num                                --�⳥��ʵ������

            if 0 == tou then
                num = jysh[tree_color][1]                       --û��С͵
            elseif type(tou) == type('') then
                num = jysh[tree_color][1] - jysh[tree_color][2] --��С͵
            end

            buchang_table[3][1][2] = num --������ҵĵͼ������ʵ������
            SendSystemMail(user,MailConfig.Jysh_buchang,1,2,nil,buchang_table); --���͵���ҵ�ϵͳ����
            wc_data[key] = nil
        end
    end

end

--����ռ�
local function jysh_userData(playerid)

    local data = GI_GetPlayerData(playerid,"jysh",16);

    return data --data[1] ����gid
end

--�жϷ�����������ʱ�������û��������������� �Ѿ�����������nil ���򷵻����ݿ�
local function user_check(playerid)

    local wc_data = get_af_data(); --�õ���������
    local data = jysh_userData(playerid) --����ռ�
    if nil == data then --����ʧ��
        return
    end

    if data[1] and (nil == wc_data[data[1]]) then --and (not IsSpanServer())�ж��Ƿ�Ϊ���������
        data[1] = nil
        SendLuaMsg(0, { ids = msg_restart }, 9)
        return nil
    end

    return data
end

--�жϲ����Ƿ����������Զ 1����Զ
local function tree_distance(tree_gid)
    
    local wc_data = get_af_data()      --��ȡ��������
    local tree_data = wc_data[tree_gid] --��ȡ����������
    if nil == tree_data then
        return 1
    end

    local user_x,user_y,rid,maGid = CI_GetCurPos() --��ȡ�û���λ����Ϣ ����id gid
    if rid ~= tree_data.reg then --�жϲ������������Ƿ��Զ
        SendLuaMsg(0, { ids = msg_distance }, 9)
        return 1
    end

    local x = abs(tree_data.x - user_x);
    local y = abs(tree_data.y - user_y);
    if x > 4 or y > 4 then --�жϲ��������Ƿ��Զ
        SendLuaMsg(0, { ids = msg_distance }, 9)
        return 1 
    end

    return 0
end

--������ֲ seed �������� 0��ͨ 1���
local function _jysh_plant(playerid,seed)

    local data = user_check(playerid) --����Ƿ������˷����� �Ƿ����������
    if nil == data or data[1] then --������
        return
    end

    local user_grade = CI_GetPlayerData(1) --��ȡ�û��ȼ�
    if nil == user_grade or user_grade < 50 then --����50�����û��ſ����־�������
        return
    end

    if seed ~= 1 and seed ~= 0 then --���������ж�
        return
    end

    local timetype = jy_TimesTypeTb.NPC_shenshu --��ȡ������������������
    if not CheckTimes( playerid, timetype, 1, -1, 1 ) then --������ �������������ֲʧ��
        return
    end

    local user_x,user_y,rid,maGid = CI_GetCurPos() --��ȡ�û�λ�� ����id �û�ȫ��Ψһid
    if 12 ~= rid then --�ض������ſ�����ֲ���� Ŀǰֻ֧��12�ŵ�ͼ���� ������ֲʧ��
        return
    end

    local user_name = CI_GetPlayerData( 5, 2, playerid) --��ȡ�û���name ������name
    --�������ݱ� --[[ 2000001 ��ͨ  2000002 ��� ]]--
    local tree_gid --��������gid ����(���߱��)������
    local tree_headID --����ͷ��id ��ɫֵ(4�� 3�� 2�� 1��) = (rint(tree_headID/10))%10 111 121 131 141
    if 0 == seed then
        tree_gid = 1501
        tree_headID = 111 --��ͼ�
    elseif 1 == seed then
        tree_gid = 1502
        tree_headID = 141 --��߼�
    end

    if nil == tree_headID or nil == tree_gid then
        return
    end

    if 1 ~= CheckGoods( tree_gid, 1, 1, playerid, "��������") then --�����߹�����
        return
    end
    CheckGoods( tree_gid, 1, 0, playerid, "��������") --�۳�����
    CheckTimes(playerid, timetype, -1, 1) --�۳�����

    local tree = tree_conf --�õ��������� ������
    local tree_gid
    if type(tree_conf) == type({}) then
        tree.name = user_name --��������
        tree.headID = tree_headID --��ͷ����
        tree.x = user_x --����λ��
        tree.y = user_y
        tree_gid = CreateObjectIndirect(tree); --������ ����ֵ--[[����id �û��� С͵���û��� ʱ��]]--
    end

    if nil == tree_gid then 
        return
    end

    data[1] = tree_gid
    local user_time = GetServerTime() --��ȡ��������ʱ��
    local wc_data = get_af_data() --�õ��������ݱ� ��������ݶ������������
    --look('playerid')
    --look(playerid)
    wc_data[tree_gid] = {      --�����������
        name = user_name,       --��ֲ�����
        ripe = user_time + 10, --����ʱ��
        num = cishu,            --ˢ�´���
        hID = tree_headID,      --����ͷ��id
        x = user_x,             --x,y��������
        y = user_y,
        reg = 12,               --��ͼ���
        tou = 0,                --С͵����
        sid = playerid          --�û�id
    }

    SetEvent(10, nil, "GI_jysh_inform", tree_gid) --100��֮��ִ�� GI_jysh_inform���� ����ϵͳ���� ��������ͨ�� ��ʵ������
    SendLuaMsg(0, { ids = msg_seed, npc_id = tree_gid }, 9) --���Ͳ��ֵ���Ϣ
end

--�鿴��
local function _jysh_look(playerid,tree_gid,look_tree)--�鿴����id

    local data = user_check(playerid) --����Ƿ������˷����� �Ƿ���������� �õ�����gid
    if nil == data then
        return
    end
    local wc_data = get_af_data() --�õ��������ݱ�
    SendLuaMsg(0, { ids = msg_otherclick, wc_data[tree_gid], look_tree = look_tree, npc_id = tree_gid }, 9);--���Ͳ鿴��Ϣ
end

--ˢ���� playerid ����ߵ�id look_tree > 0��ʾ�鿴 0 ��ʾˢ��
local function _jysh_renovate(playerid,tree_gid)
    
    local wc_data = get_af_data() --�õ��������ݱ�
    local data = user_check(playerid) --����Ƿ������˷����� �Ƿ���������� �õ�����gid
    if nil == data or nil == data[1] then
        return
    end

    --����˵��������Ϊ׼
    tree_gid = data[1]
    local dis = tree_distance(tree_gid)
    if 1 == dis then
        return
    end

    local tree_data = wc_data[tree_gid] --��ȡ��������
    local old_time = tree_data.ripe - 3600 --�ɵ�ʱ��
    local now_time = GetServerTime() --ˢ�����ڵ�ʱ��
    if (now_time - old_time) > 3600 then --����ʱ��
        return
    end

    local tree_headID = tree_data.hID --����ͷ��
    if nil == tree_headID then
        return
    end

    local tree_color = rint(tree_headID/10)%10 --������ͷ��id���㴦������ɫ
    if tree_color < 1 or tree_color > 4 then --��ɫ����
        return
    end

    if tree_data.num <= 0 or 4 == tree_color then --������Ϊ0 ����Ʒ��Ϊ��ߵ�ʱ��
        SendLuaMsg(0, { ids = msg_refresh }, 9)
        return
    end

    --����ˢ�����ݽ��
    if 1 == tree_color then --Ʒ�ֵͼ� 100%���� 0%����
        tree_color = tree_color + 1
    elseif 2 == tree_color then --Ʒ�ֵͼ� 50%���� 50%����
        local probability = random(10) --ȡ[1 - 10]������� ������1 ~ 100�ĸ���
        if probability <= 5 then
            tree_color = tree_color + 1
        elseif probability > 5 then
            tree_color = tree_color - 1
        end
    elseif 3 == tree_color then --Ʒ�ֵͼ� 30%���� 70%����
        local probability = random(10) --ȡ[1 - 10]������� ������1 ~ 100�ĸ���
        if probability <= 3 then
            tree_color = tree_color + 1
        elseif probability > 3 then
            tree_color = tree_color - 1
        end
    end

    tree_data.num = tree_data.num - 1 --ˢ�´��� - 1
    tree_headID = (rint(tree_headID / 100) * 100) + tree_color * 10 + (tree_headID % 10) --����headID �ֱ�ȡ��λ ʮλ ��λ��������¼���
    tree_data.hID = tree_hID

    CI_UpdateMonsterData(1,{headID=tree_headID},nil,4,tree_gid,12) --������������
    AreaRPC(4,tree_gid,12,"jysh_refresh",user_type,tree_gid,nil) --��������㲥 
    SendLuaMsg(0, { ids =  msg_refresh,tree_color = tree_color,num = tree_data.num}, 9)
end

--͵ȡ����
local function _jysh_user_steal()

    local wc_data = get_af_data() --�õ���������
    local playerid = GetPlayerID() --��ȡ��ǰ���ID
    local user_custom = GetPlayerTemp_custom(playserid) --�õ���ҵ���ʱ���� ������С͵��Ϣ�����ݵ�
    if nil == user_custom then
        return
    end

    local tree_gid = user_custom.tou_tree_gid --�õ�Ҫ͵����id
    local dis = tree_distance(tree_gid) --�õ���������ľ���
    if 1 == dis then
        return
    end

    local tree_data = wc_data[tree_gid] --�õ����ݵ�����
    if nil == tree_data then
        return
    end

    local tree_headID = tree_data.hID --�õ���ͷ��id
    local hid = rint(tree_headID / 100)
    if type(tree_data.tou) == type('') or hid == 2 then --�Ѿ���͵�������
        return
    end

    local tou_name = user_custom.tou_name
    local tree_color = (rint(tree_headID/10))%10 --�õ�������ɫ
    local fruit_steal_num = jysh[tree_color][2] --��ʵ���Ա�͵�ĸ���
    local item_x = tree_data.x  --����λ��
    local item_y = tree_data.y
    local itemid = 1503 --����ID
    tree_data.hID = 2 * 100 +((rint(tree_headID / 10) % 10) * 10) + tree_headID % 10 -- ��͵֮�����headID �൱��tree_headID + 100
    tree_headID = tree_data.hID 
    tree_data.tou = tou_name --С͵������

    local count = 0 --���±�͵��ʵ���䶯��
    for i = 1,fruit_steal_num do
        CreateGroundItem(12, 0, itemid, 1, item_x, item_y, count) --��ʵ���� �������ع�ʵģ��
        count = count + 1
    end
    
    CI_UpdateMonsterData(1, {headID =  tree_headID}, nil, 4,tree_gid, 12) --������������
    AreaRPC(4, tree_gid, 12, "jysh_refresh", tree_headID, tree_gid, nil) -- ��������㲥 
end

--[[2018.11.9 update]]--
--ժȡ��͵ȡ ����ߵ�id
local function _jysh_obtain(click_playerid, click_tree_gid)

    local wc_data = get_af_data() --��ȡ����������Ϣ
    local tree_data = wc_data[click_tree_gid] --��ȡ�����������������Ϣ
    if nil == tree_data then
       return
    end

    local old_time = tree_data.ripe - 100 --��ȡ�ɵ�ʱ��
    local now_time = GetServerTime() --��ȡ���ڵ�ʱ��
    if (now_time - old_time) < 100 then --ʱ�����
        return
    end

    local data = user_check(click_playerid) --����Ƿ������˷����� �Ƿ���������� �õ�����gid
    if nil == data then
        return
    end

    local dis = tree_distance(click_tree_gid)
    if 1 == dis then
        return
    end

    local user_tree_gid = data[1] --��ȡ��ǰ����gid
    local user_item_x = tree_data.x  --�õ�����λ��
    local user_item_y = tree_data.y
    local user_name = CI_GetPlayerData(5,2,click_playerid) --�õ����name
    local user_sid = CI_GetPlayerData(1,2,click_playerid) --�õ����sid
    local user_tree_headID = tree_data.hID --��ȡ����ͷ��
    local is_steal = rint((user_tree_headID) / 100) --�Ƿ�͵ 2�ѽᱻ͵�� 1δ��͵ȡ
    local tree_color = rint(user_tree_headID / 10) % 10 --�õ�������ɫ
    local rid = tree_data.reg --����id
    local itemid = 1503 --����id
    if user_tree_gid ~= click_tree_gid and user_sid ~= tree_data.sid then --��С͵
        if user_name == tree_data.name then
            Log('jysh.txt',tree_data)
			Log('jysh.txt',user_name)
			Log('jysh.txt',user_tree_gid)
			Log('jysh.txt',click_tree_gid)
        end

        if 2 == is_steal then  --�ѽᱻ͵ȡ��
            return
        elseif 1 == is_steal then --δ��͵ȡ
            local user_custom = GetPlayerTemp_custom(playerid) --��¼��ʱ������
            if nil == user_custom then
                return
            end
            user_custom.tou_tree_gid = click_tree_gid --��¼��͵����gid
            user_custom.tou_name = user_name --��¼С͵����
            local sid = tree_data.sid --Ψһ��̬id

            SendLuaMsg(sid,{ids=msg_steal_succeed,x=user_item_x,y=user_item_y,tou = tree_data.tou ,name = user_name},10)
            CI_SetReadyEvent(0,ProBarType.collect,10,1,"GI_jysh_steal") --ִ��͵ȡ����
        end

    elseif  user_tree_gid == click_tree_gid or user_sid == tree_data.sid then--�Լ�ժȡ
        local tree_num --�Լ��õ���ʵ������
        if 1 == is_steal then
            tree_num = jysh[tree_color][2] * 3
        elseif 2 == is_steal then
            tree_num = jysh[tree_color][2] * 2
        end

        if nil == tree_num then
            return
        end
        CI_DelMonster(12,click_tree_gid) --ɾ��������
        local tou = wc_data[click_tree_gid].tou
        SendLuaMsg(0,{ids=msg_obtain,num = tree_num,tou = tou,tree_color = tree_color,hID = tree_data.hID  },9)
        data[1] = nil 
        wc_data[click_tree_gid] = nil --������ı�����
        local count = 0
        for i = 1,tree_num do
            CreateGroundItem(12,0,itemid,1,user_item_x,user_item_y,count) --��ʵ����
			count = count +1
        end

    end
end

--������ʵ
--[[
    fruit_type ��ʵ���� 1С 2�� 3��
    money �Ƿ����ӱ� 0����˫�� 1�������ӱ�
]]--
local function _jysh_open(playerid,fruit_type,money)

    if fruit_type < 0 or fruit_type > 4 or (money ~= 0 and money ~= 1) then
        return
    end

    local timetype = jy_TimesTypeTb.NPC_open --Ϊ�õ��������������Ĵ���
    if not CheckTimes(playerid, timetype, 1, -1, 1) then --�������������
        return
    end

    local user_grade = CI_GetPlayerData(1) --�õ���ҵĵȼ�
    if user_grade < 0 then 
        return
    end

    if user_grade > 75 then --��߰�75�������㾭��...
        user_grade = 75
    end

    local grade = user_grade
    --[[���㾭�鹫��ʽ
    INT(��ҵȼ�^5/2000) С
    INT(��ҵȼ�^5/1000) ��
    INT(��ҵȼ�^5/500)  ��
    ]]--
    if 1 == money then --�������ӱ�
        if fruit_type <= 3 then
            grade = user_grade^5
            local exp = rint(grade / open[fruit_type][1])
            if CheckGoods(1502 + fruit_type,1,1,playerid,"����������") ~= 1 then --��Ʒ������
                return
            end
            CheckGoods(1502 + fruit_type,1,0,playerid,"�����龭��") --�۳�����
            PI_PayPlayer(1, exp,0,0,'����������') --�ȼ��ӳ�
            SendLuaMsg(0,{ ids = msg_open,fruit_type = fruit_type}, 9)
        end

    elseif 0 == money then --�����ӱ�
        if fruit_type <= 3 then
            grade = user_grade^5
            local exp = rint(grade/open[fruit_type][1]) * 2 --˫��
             --[[
            ������ҪԪ���Ĺ�ʽ = INT������/100000�� 
            CheckCost   --�۳�Ԫ�� ����λ���� 1��ʾ��� 0��ʾ�۳�
            CheckGoods  --�۳����� ����λ���� 1��ʾ��� 0��ʾ�۳�
            ]]--
            local yuanbao = rint(rint(exp / 2) / 100000) --������ҪԪ������
            if CheckCost(playerid,yuanbao,1,1,playerid,"������˫������") == false then --Ԫ������������
                return
            end

            if CheckGoods(1502 + fruit_type,1,1,playerid,"����������") ~= 1 then --��Ʒ������
                return
            end
            CheckCost(playerid,yuanbao,0,1,playerid,"������˫������") --�۳�Ԫ��
            CheckGoods(1502 + fruit_type,1,0,playerid,"����������") --�۳�����
            PI_PayPlayer(1, exp,0,0,'����������') --�ȼ��ӳ�
            SendLuaMsg(0,{ ids = msg_open,fruit_type = fruit_type}, 9)
        end

    end
end

--ͨ���ʵ���캯��
local function _jysh_inform(tree_gid)
    
    local wc_data = get_af_data() --�õ���ҹ�������������
    if nil == tree_gid then   
        return
    end

    local tree_data = wc_data[tree_gid] --�õ�����������Ϣ
    local tree_headID =tree_data.hID --�������ͷ��id
    local x = tree_data.x --λ����Ϣ
    local y = tree_data.y
    local reg = tree_data.reg --�������
    local name = tree_data.name --��������
    local tree_color = rint(tree_headID / 10) % 10 --�õ�������ɫ
    local form = 1112 --ͼƬid
    if tree_color == 3 then
        form = 1113
    elseif tree_color == 4 then
        form = 1114
    end
    
    CI_UpdateMonsterData(1, {imageID = form}, nil, 4, tree_gid, 12) --���ѳ��� ��������
    if form == 1113  or form == 1114 then
        BroadcastRPC("jysh_world",x,y,name,tree_color,reg) --����㲥
    end

    AreaRPC(4, tree_gid, 12, "jysh_refresh",tree_color,tree_gid,form) --��������㲥
    SendSystemMail(name,MailConfig.Jysh_fruit,1,2) --����ϵͳ����
end

--ɾ������
local function _jysh_clear(playerid)

    local data = jysh_userData(playerid) --�õ�����ռ������
    if not data then
        return
    end

    local wc_data = get_af_data() --�õ���������
    for k,v in pairs(wc_data) do
        if v.sid == playerid then  --�ҵ��������ͬ������idʱ���б����
            wc_data[k] = nil
            CI_DelMonster(12,k); --ɾ������
            data[1] = nil
        end
    end
end

--���뵽�ⲿ��ȫ�ֺ���
Data_Load       = _Data_Load       --ÿ�η�����������������ֲ�˾���������ҵĲ���
jysh_plant      = _jysh_plant      --��ֲ
jysh_look       = _jysh_look       --�鿴��
jysh_renovate   = _jysh_renovate   --ˢ����
jysh_user_steal = _jysh_user_steal --͵ȡ����
jysh_obtain     = _jysh_obtain     --ժȡ��͵ȡ
jysh_open       = _jysh_open       --��ʵ����
jysh_inform     = _jysh_inform     --��ʵ����ʱ�Ĺ㲥ͨ��
jysh_clear      = _jysh_clear      --�������


