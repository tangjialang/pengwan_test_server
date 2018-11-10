function check_give_awards()
    --1.1：检查条件，可以对每种错误指定不同的错误号，便于以后错误查找
    --首要是已领取标识
    if player_data.give == 1 then
        return -1
    end
    --其他条件判断
    if player_level < need_level then
        return -4
    end
    --奖励道具表是否合法，数据类型判断一定要判断是否是所需的数据类型
    if type(awardInfo) ~= type({}) then  
        return -2
    end
    --检查道具是否能给成功，如果不能给并且err_code是3表示是背包满，需要提示客户端还需要need_num个格子；
    --其他错误一般为奖励表问题，比如有道具表中找不到的道具id（1）、有重复的道具id（5）
    --is_can==nil表示奖励表错误：奖励道具表的每个元素必须是表，并且表中至少3个元素组成：道具id、道具数量、绑定标识（1为绑定）
    local is_can,err_code,need_num = CheckGiveGoods(awardInfo)
    if not is_can then
	    if err_code == 3 then					
		    local info =GetStringMsg(14,need_num)
		    TipCenter(info) 	
	    end
	    return -3
    end

    --1.2：检查所需1，所需多于1种则应该全部判断完再依次扣除，否则可以直接扣
    if CheckGoods(item_id,item_num, 1, sid,info) ~= 1 then
        return -5
    end
    --1.3：检查所需2
    if not CheckCost(sid,cost,1,type,info) then
        return -6
    end
    --1.4：扣除所需1
    if CheckGoods(item_id,item_num, 0, sid,info) ~= 1 then
        return -7
    end
    --1.5：扣除所需2
    if not CheckCost(sid,cost,0,type,info) then
        return -8
    end

    --2.1：设置标识，一定先设置标识再实际给奖励
    player_data.give = 1

    --3.1 ： 实际发放奖励
    local is_can,err_code,need_num = GiveGoodsBatch( awardInfo, info, 2, sid )
    if not is_can then
        -- 如果出现非预期的错误可以用look（1）打印出来备查
        look("give error finally : "..tostring(err_code).." , "..tostring(sid),1)
	    return -9
    end	

    --一般来说可以约定返回>=0为正确，负数为错误代码
    return 0
end