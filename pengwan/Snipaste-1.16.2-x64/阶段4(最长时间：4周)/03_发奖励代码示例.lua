function check_give_awards()
    --1.1��������������Զ�ÿ�ִ���ָ����ͬ�Ĵ���ţ������Ժ�������
    --��Ҫ������ȡ��ʶ
    if player_data.give == 1 then
        return -1
    end
    --���������ж�
    if player_level < need_level then
        return -4
    end
    --�������߱��Ƿ�Ϸ������������ж�һ��Ҫ�ж��Ƿ����������������
    if type(awardInfo) ~= type({}) then  
        return -2
    end
    --�������Ƿ��ܸ��ɹ���������ܸ�����err_code��3��ʾ�Ǳ���������Ҫ��ʾ�ͻ��˻���Ҫneed_num�����ӣ�
    --��������һ��Ϊ���������⣬�����е��߱����Ҳ����ĵ���id��1�������ظ��ĵ���id��5��
    --is_can==nil��ʾ��������󣺽������߱��ÿ��Ԫ�ر����Ǳ����ұ�������3��Ԫ����ɣ�����id�������������󶨱�ʶ��1Ϊ�󶨣�
    local is_can,err_code,need_num = CheckGiveGoods(awardInfo)
    if not is_can then
	    if err_code == 3 then					
		    local info =GetStringMsg(14,need_num)
		    TipCenter(info) 	
	    end
	    return -3
    end

    --1.2���������1���������1����Ӧ��ȫ���ж��������ο۳����������ֱ�ӿ�
    if CheckGoods(item_id,item_num, 1, sid,info) ~= 1 then
        return -5
    end
    --1.3���������2
    if not CheckCost(sid,cost,1,type,info) then
        return -6
    end
    --1.4���۳�����1
    if CheckGoods(item_id,item_num, 0, sid,info) ~= 1 then
        return -7
    end
    --1.5���۳�����2
    if not CheckCost(sid,cost,0,type,info) then
        return -8
    end

    --2.1�����ñ�ʶ��һ�������ñ�ʶ��ʵ�ʸ�����
    player_data.give = 1

    --3.1 �� ʵ�ʷ��Ž���
    local is_can,err_code,need_num = GiveGoodsBatch( awardInfo, info, 2, sid )
    if not is_can then
        -- ������ַ�Ԥ�ڵĴ��������look��1����ӡ��������
        look("give error finally : "..tostring(err_code).." , "..tostring(sid),1)
	    return -9
    end	

    --һ����˵����Լ������>=0Ϊ��ȷ������Ϊ�������
    return 0
end