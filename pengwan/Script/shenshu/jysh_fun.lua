--[[
   file:jysh_fun.lua
   desc:经验神树
   author:tjl
   updata:2018-11-7
]]--
identification = identification or 1         -- 用来服务器启动 恢复玩家神数个标识

--神树消息
local msgh_s2c_def     = msgh_s2c_def;       -- 获取消息管理者
local msg_seed         = msgh_s2c_def[51][1] -- 种植
local msg_open         = msgh_s2c_def[51][2] -- 果实开启
local msg_otherclick   = msgh_s2c_def[51][3] -- 点击查看树 
local msg_refresh      = msgh_s2c_def[51][4] -- 刷新
local msg_obtain       = msgh_s2c_def[51][5] -- 摘取
local msg_steal        = msgh_s2c_def[51][6] -- 偷取
local msg_steal_succed = msgh_s2c_def[51][7] -- 偷取成功与否
local msg_restart      = msgh_s2c_def[51][8] -- 重启服务器刷新神树数据
local msg_distance     = msgh_s2c_def[51][9] -- 判断距离

--配置文件
local conf      = require("Script.shenshu.jysh_cof") --导入配置文件
local jysh      = conf.jysh                          --神树果实的配置
local open      = conf.open                          --神树果实开启经验配置
local cishu     = conf.cishu
local tree_conf = conf.tree_conf                     --神树的外观配置

--游戏通用功能扩展模块
local define = require("Script.cext.define")  --全局定义库

--全局辅助函数
local rint             = rint              --去掉小数位
local look             = look              --打印提示信息
local random           = math.random       --随机数
local abs              = math.abs          --相反数
local Log              = Log               --日志
local GI_GetPlayerData = GI_GetPlayerData  --申请空间
local GetServerTime    = GetServerTime     --得到服务器当前时间
local SetEvent         = SetEvent          --设置时间后执行一个函数 后面为参数
local jy_TimesTypeTb   = TimesTypeTb       --次数管理器(种植 刷新的次数都在这里)
local SendLuaMsg       = SendLuaMsg        --发送消息给当前玩家
local GetWorldCustomDB = GetWorldCustomDB  --获取临时玩家的世界数据(神树数据)
local BroadcastRPC     = BroadcastRPC      --世界广播
local AreaRPC          = AreaRPC           --区域广播
local CI_SetReadyEvent = CI_SetReadyEvent  --设置独占读条事件
local ProBarType       = define.ProBarType --读条类型
local CheckTimes       = CheckTimes        --检测次数 次数管理器
local SendSystemMail   = SendSystemMail    --发送系统邮箱
local MailConfig       = MailConfig        --邮箱配置

--获得角色相关的函数
local CI_GetCurPos     = CI_GetCurPos      --得到当前位置
local CheckGoods       = CheckGoods        --检测道具
local CI_GetPlayerData = CI_GetPlayerData  --获取用户等级
local PI_PayPlayer     = PI_PayPlayer      --世界等级加成
local CheckCost        = CheckCost         --检测双倍经验支付元宝
local GetCurPlayerID   = GetCurPlayerID    --得到当前玩家ID

--得到临时数据(玩家数据有永久保存区和临时保存区 临时保存区会在玩家下线或者服务器关闭后时候清除)
local GetPlayerTemp_custom = GetPlayerTemp_custom --得到玩家常用的临时性数据

--创建模型更新外形函数
local CreateGroundItem     = CreateGroundItem     --果实掉地创建的模型
local CreateObjectIndirect = CreateObjectIndirect --创建神树模型
local CI_UpdateMonsterData = CI_UpdateMonsterData --更新设置模型外观
local CI_DelMonster        = CI_DelMonster        --删除模型

--lua全局函数做local引用
local type  = type  --数据类型判断
local pairs = pairs --迭代器
local __G   = _G    --全局环境表

module(...)

--得到世界数据
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

--每次服务器重新启动对种植了经验神树玩家的补偿
local function _Data_Load(itype)
    if itype == 1 then
        if __G.identification == 1 then
            __G.identification = 2
        else
            return
        end
    end
    local wc_data = get_af_data() --得到经验神树世界数据
    local buchang_table = {[3] = {{1503,10,1},}} --给予补偿 低级经验果实
    for key, value in pairs(wc_data) do
        if type(key) == type(0) and type(value) == type({}) then --key值为number类型 value为table类型
            local user_name = wc_data[key].name      --树的名字
            local headID = wc_data[key].headID       --树标头id 通过这个id来换算树的颜色(等级)
            local tree_color = (rint(headID / 10)) % 10 --树的颜色
            local tou = wc_data[key].tou             --有没有小偷
            local num                                --赔偿果实的数量

            if 0 == tou then
                num = jysh[tree_color][1]                       --没有小偷
            elseif type(tou) == type('') then
                num = jysh[tree_color][1] - jysh[tree_color][2] --有小偷
            end

            buchang_table[3][1][2] = num --补偿玩家的低级经验果实的数量
            SendSystemMail(user,MailConfig.Jysh_buchang,1,2,nil,buchang_table); --发送到玩家的系统邮箱
            wc_data[key] = nil
        end
    end

end

--申请空间
local function jysh_userData(playerid)

    local data = GI_GetPlayerData(playerid,"jysh",16);

    return data --data[1] 树的gid
end

--判断服务器重启的时候清理用户个人种树的数据 已经种了树返回nil 否则返回数据块
local function user_check(playerid)

    local wc_data = get_af_data(); --得到世界数据
    local data = jysh_userData(playerid) --申请空间
    if nil == data then --申请失败
        return
    end

    if data[1] and (nil == wc_data[data[1]]) then --and (not IsSpanServer())判断是否为跨服服务器
        data[1] = nil
        SendLuaMsg(0, { ids = msg_restart }, 9)
        return nil
    end

    return data
end

--判断操作是否距离神树过远 1过于远
local function tree_distance(tree_gid)
    
    local wc_data = get_af_data()      --获取世界数据
    local tree_data = wc_data[tree_gid] --获取神树的数据
    if nil == tree_data then
        return 1
    end

    local user_x,user_y,rid,maGid = CI_GetCurPos() --获取用户的位置信息 场景id gid
    if rid ~= tree_data.reg then --判断操作场景距离是否过远
        SendLuaMsg(0, { ids = msg_distance }, 9)
        return 1
    end

    local x = abs(tree_data.x - user_x);
    local y = abs(tree_data.y - user_y);
    if x > 4 or y > 4 then --判断操作距离是否过远
        SendLuaMsg(0, { ids = msg_distance }, 9)
        return 1 
    end

    return 0
end

--神树种植 seed 种子类型 0普通 1五彩
local function _jysh_plant(playerid,seed)

    local data = user_check(playerid) --检测是否重启了服务器 是否清空了数据
    if nil == data or data[1] then --已种树
        return
    end

    local user_grade = CI_GetPlayerData(1) --获取用户等级
    if nil == user_grade or user_grade < 50 then --大于50级的用户才可以种经验神树
        return
    end

    if seed ~= 1 and seed ~= 0 then --种子类型判断
        return
    end

    local timetype = jy_TimesTypeTb.NPC_shenshu --获取经验神树次数管理器
    if not CheckTimes( playerid, timetype, 1, -1, 1 ) then --检测次数 如果次数不够种植失败
        return
    end

    local user_x,user_y,rid,maGid = CI_GetCurPos() --获取用户位置 场景id 用户全局唯一id
    if 12 ~= rid then --特定场景才可以种植神树 目前只支持12号地图场景 否则种植失败
        return
    end

    local user_name = CI_GetPlayerData( 5, 2, playerid) --获取用户的name 神树的name
    --建立数据表 --[[ 2000001 普通  2000002 五彩 ]]--
    local tree_gid --给予种子gid 用于(道具编号)检测道具
    local tree_headID --树的头像id 颜色值(4橙 3紫 2蓝 1绿) = (rint(tree_headID/10))%10 111 121 131 141
    if 0 == seed then
        tree_gid = 1501
        tree_headID = 111 --最低级
    elseif 1 == seed then
        tree_gid = 1502
        tree_headID = 141 --最高级
    end

    if nil == tree_headID or nil == tree_gid then
        return
    end

    if 1 ~= CheckGoods( tree_gid, 1, 1, playerid, "经验神树") then --检测道具够不够
        return
    end
    CheckGoods( tree_gid, 1, 0, playerid, "经验神树") --扣除道具
    CheckTimes(playerid, timetype, -1, 1) --扣除次数

    local tree = tree_conf --得到树的配置 建立树
    local tree_gid
    if type(tree_conf) == type({}) then
        tree.name = user_name --树的名字
        tree.headID = tree_headID --树头像编号
        tree.x = user_x --树的位置
        tree.y = user_y
        tree_gid = CreateObjectIndirect(tree); --创建树 返回值--[[树的id 用户名 小偷的用户名 时间]]--
    end

    if nil == tree_gid then 
        return
    end

    data[1] = tree_gid
    local user_time = GetServerTime() --获取服务器的时间
    local wc_data = get_af_data() --得到世界数据表 下面把数据都存在世界表中
    --look('playerid')
    --look(playerid)
    wc_data[tree_gid] = {      --添加世界数据
        name = user_name,       --种植玩家名
        ripe = user_time + 10, --成熟时间
        num = cishu,            --刷新次数
        hID = tree_headID,      --树的头像id
        x = user_x,             --x,y树的坐标
        y = user_y,
        reg = 12,               --地图编号
        tou = 0,                --小偷名字
        sid = playerid          --用户id
    }

    SetEvent(10, nil, "GI_jysh_inform", tree_gid) --100秒之后执行 GI_jysh_inform函数 发送系统邮箱 发送世界通告 果实成熟了
    SendLuaMsg(0, { ids = msg_seed, npc_id = tree_gid }, 9) --发送播种的消息
end

--查看树
local function _jysh_look(playerid,tree_gid,look_tree)--查看树的id

    local data = user_check(playerid) --检测是否重启了服务器 是否清空了数据 得到树的gid
    if nil == data then
        return
    end
    local wc_data = get_af_data() --得到世界数据表
    SendLuaMsg(0, { ids = msg_otherclick, wc_data[tree_gid], look_tree = look_tree, npc_id = tree_gid }, 9);--发送查看信息
end

--刷新树 playerid 点击者的id look_tree > 0表示查看 0 表示刷新
local function _jysh_renovate(playerid,tree_gid)
    
    local wc_data = get_af_data() --得到世界数据表
    local data = user_check(playerid) --检测是否重启了服务器 是否清空了数据 得到树的gid
    if nil == data or nil == data[1] then
        return
    end

    --服务端的玩家数据为准
    tree_gid = data[1]
    local dis = tree_distance(tree_gid)
    if 1 == dis then
        return
    end

    local tree_data = wc_data[tree_gid] --获取神树数据
    local old_time = tree_data.ripe - 3600 --旧的时间
    local now_time = GetServerTime() --刷新现在的时间
    if (now_time - old_time) > 3600 then --错误时间
        return
    end

    local tree_headID = tree_data.hID --树的头标
    if nil == tree_headID then
        return
    end

    local tree_color = rint(tree_headID/10)%10 --有树的头像id换算处树的颜色
    if tree_color < 1 or tree_color > 4 then --颜色出错
        return
    end

    if tree_data.num <= 0 or 4 == tree_color then --当次数为0 树的品种为最高的时候
        SendLuaMsg(0, { ids = msg_refresh }, 9)
        return
    end

    --处理刷新数据结果
    if 1 == tree_color then --品种低级 100%升级 0%降级
        tree_color = tree_color + 1
    elseif 2 == tree_color then --品种低级 50%升级 50%降级
        local probability = random(10) --取[1 - 10]的随机数 来代表1 ~ 100的概率
        if probability <= 5 then
            tree_color = tree_color + 1
        elseif probability > 5 then
            tree_color = tree_color - 1
        end
    elseif 3 == tree_color then --品种低级 30%升级 70%降级
        local probability = random(10) --取[1 - 10]的随机数 来代表1 ~ 100的概率
        if probability <= 3 then
            tree_color = tree_color + 1
        elseif probability > 3 then
            tree_color = tree_color - 1
        end
    end

    tree_data.num = tree_data.num - 1 --刷新次数 - 1
    tree_headID = (rint(tree_headID / 100) * 100) + tree_color * 10 + (tree_headID % 10) --更新headID 分别取百位 十位 个位相加来重新计算
    tree_data.hID = tree_hID

    CI_UpdateMonsterData(1,{headID=tree_headID},nil,4,tree_gid,12) --设置树的外形
    AreaRPC(4,tree_gid,12,"jysh_refresh",user_type,tree_gid,nil) --进行区域广播 
    SendLuaMsg(0, { ids =  msg_refresh,tree_color = tree_color,num = tree_data.num}, 9)
end

--偷取函数
local function _jysh_user_steal()

    local wc_data = get_af_data() --得到世界数据
    local playerid = GetPlayerID() --获取当前玩家ID
    local user_custom = GetPlayerTemp_custom(playserid) --得到玩家的临时数据 用来存小偷信息等数据的
    if nil == user_custom then
        return
    end

    local tree_gid = user_custom.tou_tree_gid --得到要偷树的id
    local dis = tree_distance(tree_gid) --得到玩家与树的距离
    if 1 == dis then
        return
    end

    local tree_data = wc_data[tree_gid] --得到数据的数据
    if nil == tree_data then
        return
    end

    local tree_headID = tree_data.hID --得到树头标id
    local hid = rint(tree_headID / 100)
    if type(tree_data.tou) == type('') or hid == 2 then --已经被偷的情况下
        return
    end

    local tou_name = user_custom.tou_name
    local tree_color = (rint(tree_headID/10))%10 --得到树的颜色
    local fruit_steal_num = jysh[tree_color][2] --果实可以被偷的个数
    local item_x = tree_data.x  --树的位置
    local item_y = tree_data.y
    local itemid = 1503 --道具ID
    tree_data.hID = 2 * 100 +((rint(tree_headID / 10) % 10) * 10) + tree_headID % 10 -- 被偷之后更新headID 相当于tree_headID + 100
    tree_headID = tree_data.hID 
    tree_data.tou = tou_name --小偷的名字

    local count = 0 --更新被偷果实掉落动画
    for i = 1,fruit_steal_num do
        CreateGroundItem(12, 0, itemid, 1, item_x, item_y, count) --果实掉地 创建掉地果实模型
        count = count + 1
    end
    
    CI_UpdateMonsterData(1, {headID =  tree_headID}, nil, 4,tree_gid, 12) --更新树的外形
    AreaRPC(4, tree_gid, 12, "jysh_refresh", tree_headID, tree_gid, nil) -- 进行区域广播 
end

--[[2018.11.9 update]]--
--摘取、偷取 点击者的id
local function _jysh_obtain(click_playerid, click_tree_gid)

    local wc_data = get_af_data() --获取世界数据信息
    local tree_data = wc_data[click_tree_gid] --获取点击者神树的数据信息
    if nil == tree_data then
       return
    end

    local old_time = tree_data.ripe - 100 --获取旧的时间
    local now_time = GetServerTime() --获取现在的时间
    if (now_time - old_time) < 100 then --时间错误
        return
    end

    local data = user_check(click_playerid) --检测是否重启了服务器 是否清空了数据 得到树的gid
    if nil == data then
        return
    end

    local dis = tree_distance(click_tree_gid)
    if 1 == dis then
        return
    end

    local user_tree_gid = data[1] --获取当前树的gid
    local user_item_x = tree_data.x  --得到树的位置
    local user_item_y = tree_data.y
    local user_name = CI_GetPlayerData(5,2,click_playerid) --得到玩家name
    local user_sid = CI_GetPlayerData(1,2,click_playerid) --得到玩家sid
    local user_tree_headID = tree_data.hID --获取树的头标
    local is_steal = rint((user_tree_headID) / 100) --是否被偷 2已结被偷过 1未被偷取
    local tree_color = rint(user_tree_headID / 10) % 10 --得到树的颜色
    local rid = tree_data.reg --场景id
    local itemid = 1503 --道具id
    if user_tree_gid ~= click_tree_gid and user_sid ~= tree_data.sid then --是小偷
        if user_name == tree_data.name then
            Log('jysh.txt',tree_data)
			Log('jysh.txt',user_name)
			Log('jysh.txt',user_tree_gid)
			Log('jysh.txt',click_tree_gid)
        end

        if 2 == is_steal then  --已结被偷取了
            return
        elseif 1 == is_steal then --未被偷取
            local user_custom = GetPlayerTemp_custom(playerid) --记录暂时性数据
            if nil == user_custom then
                return
            end
            user_custom.tou_tree_gid = click_tree_gid --记录被偷树的gid
            user_custom.tou_name = user_name --记录小偷名字
            local sid = tree_data.sid --唯一静态id

            SendLuaMsg(sid,{ids=msg_steal_succeed,x=user_item_x,y=user_item_y,tou = tree_data.tou ,name = user_name},10)
            CI_SetReadyEvent(0,ProBarType.collect,10,1,"GI_jysh_steal") --执行偷取函数
        end

    elseif  user_tree_gid == click_tree_gid or user_sid == tree_data.sid then--自己摘取
        local tree_num --自己得到果实的数量
        if 1 == is_steal then
            tree_num = jysh[tree_color][2] * 3
        elseif 2 == is_steal then
            tree_num = jysh[tree_color][2] * 2
        end

        if nil == tree_num then
            return
        end
        CI_DelMonster(12,click_tree_gid) --删除经验树
        local tou = wc_data[click_tree_gid].tou
        SendLuaMsg(0,{ids=msg_obtain,num = tree_num,tou = tou,tree_color = tree_color,hID = tree_data.hID  },9)
        data[1] = nil 
        wc_data[click_tree_gid] = nil --清空树的表数据
        local count = 0
        for i = 1,tree_num do
            CreateGroundItem(12,0,itemid,1,user_item_x,user_item_y,count) --果实掉地
			count = count +1
        end

    end
end

--开启果实
--[[
    fruit_type 果实类型 1小 2中 3大
    money 是否开启加倍 0开启双倍 1不开启加倍
]]--
local function _jysh_open(playerid,fruit_type,money)

    if fruit_type < 0 or fruit_type > 4 or (money ~= 0 and money ~= 1) then
        return
    end

    local timetype = jy_TimesTypeTb.NPC_open --为得到开启经验神树的次数
    if not CheckTimes(playerid, timetype, 1, -1, 1) then --次数不够的情况
        return
    end

    local user_grade = CI_GetPlayerData(1) --得到玩家的等级
    if user_grade < 0 then 
        return
    end

    if user_grade > 75 then --最高按75级来换算经验...
        user_grade = 75
    end

    local grade = user_grade
    --[[换算经验公公式
    INT(玩家等级^5/2000) 小
    INT(玩家等级^5/1000) 中
    INT(玩家等级^5/500)  大
    ]]--
    if 1 == money then --不开启加倍
        if fruit_type <= 3 then
            grade = user_grade^5
            local exp = rint(grade / open[fruit_type][1])
            if CheckGoods(1502 + fruit_type,1,1,playerid,"经验树经验") ~= 1 then --物品不存在
                return
            end
            CheckGoods(1502 + fruit_type,1,0,playerid,"经验书经验") --扣除道具
            PI_PayPlayer(1, exp,0,0,'经验树经验') --等级加成
            SendLuaMsg(0,{ ids = msg_open,fruit_type = fruit_type}, 9)
        end

    elseif 0 == money then --开启加倍
        if fruit_type <= 3 then
            grade = user_grade^5
            local exp = rint(grade/open[fruit_type][1]) * 2 --双倍
             --[[
            计算需要元宝的公式 = INT（经验/100000） 
            CheckCost   --扣除元宝 第三位参数 1表示检查 0表示扣除
            CheckGoods  --扣除道具 第三位参数 1表示检查 0表示扣除
            ]]--
            local yuanbao = rint(rint(exp / 2) / 100000) --计算需要元宝个数
            if CheckCost(playerid,yuanbao,1,1,playerid,"经验树双倍经验") == false then --元宝不够不存在
                return
            end

            if CheckGoods(1502 + fruit_type,1,1,playerid,"经验树经验") ~= 1 then --物品不存在
                return
            end
            CheckCost(playerid,yuanbao,0,1,playerid,"经验树双倍经验") --扣除元宝
            CheckGoods(1502 + fruit_type,1,0,playerid,"经验树经验") --扣除道具
            PI_PayPlayer(1, exp,0,0,'经验树经验') --等级加成
            SendLuaMsg(0,{ ids = msg_open,fruit_type = fruit_type}, 9)
        end

    end
end

--通告果实成熟函数
local function _jysh_inform(tree_gid)
    
    local wc_data = get_af_data() --得到玩家关于神树的数据
    if nil == tree_gid then   
        return
    end

    local tree_data = wc_data[tree_gid] --得到神树数据信息
    local tree_headID =tree_data.hID --获得神树头像id
    local x = tree_data.x --位置信息
    local y = tree_data.y
    local reg = tree_data.reg --场景编号
    local name = tree_data.name --树的名字
    local tree_color = rint(tree_headID / 10) % 10 --得到树的颜色
    local form = 1112 --图片id
    if tree_color == 3 then
        form = 1113
    elseif tree_color == 4 then
        form = 1114
    end
    
    CI_UpdateMonsterData(1, {imageID = form}, nil, 4, tree_gid, 12) --树已成熟 设置外形
    if form == 1113  or form == 1114 then
        BroadcastRPC("jysh_world",x,y,name,tree_color,reg) --世界广播
    end

    AreaRPC(4, tree_gid, 12, "jysh_refresh",tree_color,tree_gid,form) --进行区域广播
    SendSystemMail(name,MailConfig.Jysh_fruit,1,2) --发送系统邮箱
end

--删除神树
local function _jysh_clear(playerid)

    local data = jysh_userData(playerid) --得到申请空间的数据
    if not data then
        return
    end

    local wc_data = get_af_data() --得到世界数据
    for k,v in pairs(wc_data) do
        if v.sid == playerid then  --找到与玩家相同的数据id时进行表清空
            wc_data[k] = nil
            CI_DelMonster(12,k); --删除神树
            data[1] = nil
        end
    end
end

--引入到外部的全局函数
Data_Load       = _Data_Load       --每次服务器重新启动对种植了经验神树玩家的补偿
jysh_plant      = _jysh_plant      --种植
jysh_look       = _jysh_look       --查看树
jysh_renovate   = _jysh_renovate   --刷新树
jysh_user_steal = _jysh_user_steal --偷取函数
jysh_obtain     = _jysh_obtain     --摘取、偷取
jysh_open       = _jysh_open       --果实开启
jysh_inform     = _jysh_inform     --果实成熟时的广播通告
jysh_clear      = _jysh_clear      --清除神树


