--[[
author:	liyi
update:	2012-05-07
refix: done by chal
]]--

--------------------------------------------------------------------------
--include:
local type = type
--------------------------------------------------------------------------
--data:
local All_TIP_MSG = {
--[[
ShowMsg_1	抱歉，您的元宝不足！
ShowMsg_2	抱歉，您的绑定元宝不足！
ShowMsg_3	抱歉，您的铜币不足！
ShowMsg_4	对不起，您的等级不足%S,无法执行该操作！
ShowMsg_5	对不起，您的等级不足，不能传送！
ShowMsg_6	对不起,您没有飞行符或不是vip!
ShowMsg_7	对不起，对方不在线！
ShowMsg_8	恭喜您购买成功!
ShowMsg_9	恭喜您出售成功!
ShowMsg_10	恭喜您获得%S点战功!
ShowMsg_11	护送状态下无法变身!
ShowMsg_12	当前地图无法变身!
ShowMsg_13	恭喜您获得了%S点庄园经验!
ShowMsg_14	背包空格不足%S，需要清理背包,您可在西岐的仓库管理员处存放物品!
ShowMsg_15	您已经拥有该称号!
ShowMsg_16	恭喜您获得了新的称号!
ShowMsg_17	您正在副本或活动中,请先退出!
ShowMsg_18	需要战斗力达到%S,或者人物等级达到%S,才能进入该场景!
ShowMsg_19	恭喜您获得%S点声望!
ShowMsg_20	对不起，次数不足!
ShowMsg_21	对不起，秘境尚未开启!
ShowMsg_22	对不起，对方烂醉,无法敬酒!
ShowMsg_23	恭喜您领奖成功!
ShowMsg_24	恭喜您通关副本!
ShowMsg_25	对不起，你处于烂醉状态,无法操作!
ShowMsg_26	对不起，您的战斗力不足%S,无法执行该操作!
ShowMsg_27	对不起，您的女神阶数不足%S阶,无法使用该道具!
ShowMsg_28	对不起，您的骑兵阶数不足%S阶,无法使用该道具!
ShowMsg_29	恭喜您获得%S点历练值!
ShowMsg_30	恭喜您获得%S点荣誉!
ShowMsg_38	对不起，在您的包裹中没有找到“$C%S$C”！
ShowMsg_42	恭喜您获得%S个“$C%S$C”！
ShowMsg_66	非常抱歉，您已经领取过奖励了
ShowMsg_67	非常抱歉，您未充值!
ShowMsg_68	主人不能吃宴席，只能敬酒!


ShowMsg_144	抱歉，您的绑银或银子不足！
ShowMsg_207	您尚未入帮！
ShowMsg_115	您尚未加入阵营！
ShowMsg_251	非常抱歉，您已达到日购买最大次数！
ShowMsg_426	非常抱歉，您的VIP等级不足%S级，无法执行该操作！
ShowMsg_427	非常抱歉，您包裹里面的“$C%S$C”不足%S个！！
ShowMsg_420	恭喜您获得经验值
ShowMsg_421	您距离NPC太远，无法接受护送任务
ShowMsg_422	护送开始，请在20分钟内将美人护送至东海逍遥阁
ShowMsg_423	拦截成功，获得经验#1点,灵气#2点！
ShowMsg_424	您距离NPC太远，无法交付护送任务!
ShowMsg_425	您尚未护送，我无法给您奖励！
ShowMsg_428	非常抱歉，您护送失败了!
ShowMsg_429	非常抱歉，您的护送次数不足！
ShowMsg_430	非常抱歉，您正在护送状态中!
ShowMsg_431	您正在副本或活动中,请先退出再进庄园!
ShowMsg_432	您正在护送中,不能变身及进入副本或活动!
ShowMsg_433	非常抱歉，宴会已经开启!
ShowMsg_434 在线时间不足！
ShowMsg_435 对不起,装备类型不符,无法进行操作!
ShowMsg_436 对不起,该对象已被采集!
ShowMsg_437 对不起,本帮神兽活动未开启!
ShowMsg_438 对不起,本帮神兽活动已结束!
ShowMsg_439 对不起,对方接受次数达到上限!
ShowMsg_440 对不起,您已在答题或持酒状态!
ShowMsg_441 对不起,一天只能参加一次帮会神兽活动!
ShowMsg_442 = "您已经领取过激活码了！",
ShowMsg_443 = "该激活码已经被人使用过了！",
ShowMsg_444 = "激活码不存在！",
ShowMsg_445 = "礼包不存在",
ShowMsg_446 = "您尚未领取#1，领取后方能领取其它礼包!",
ShowMsg_447 = "您当前没有礼包可以领取，确认是否已经领取过了",
ShowMsg_448 = "恭喜您激活码兑换成功!",
ShowMsg_449 = "该房间人数已满!",
ShowMsg_450 = "恭喜您的女仆获得好感度20点!",
ShowMsg_451 = "恭喜您获得守护之魂-经验球!",
ShowMsg_452 = "对不起,宴会已结束",
ShowMsg_453 = "对不起,本商品已达购买上限",
ShowMsg_454 = "恭喜您减少10点罪恶值!",
ShowMsg_455 = "对不起,不能在活动地图中召集帮众!",
ShowMsg_456 = "对不起,已达领取上限!",
ShowMsg_457 = "对不起,女神已满级!",
ShowMsg_458 = "对不起,您已經领取过了！"
ShowMsg_459 = "您的历练值不足！！"
ShowMsg_460 = "对不起,已达血包最大值！"
ShowMsg_461 = "对不起,所需骑兵等级不足！"
ShowMsg_462 = "对不起,所需神翼等级不足！"
ShowMsg_463 = "对不起,您已经拥有该时装！"
ShowMsg_464 = "对不起,帮会资金不足！"

ShowMsg_673	吃宴席中...
ShowMsg_674	当前场景不能燃放烟花！
ShowMsg_675	喜结良缘
ShowMsg_676	义结金兰
ShowMsg_677	您还没有结缘，不能解除关系！
ShowMsg_678	您预约了宴席，不能解除关系
ShowMsg_679	请确定你队伍中只有两人并且你是队长！
ShowMsg_680	您拒绝了对方的解除关系请求！
ShowMsg_681	你现在不处于结婚或结拜状态,不能使用缘分戒指！
ShowMsg_682	您还没有结缘，不能做此操作
ShowMsg_683	对方不在线，不能做此操作
ShowMsg_684	冷却时间没到，不能做此操作！
ShowMsg_685	%S和%S的普通宴席
ShowMsg_686	%S和%S的豪华宴席
ShowMsg_687	你的结缘请求已经发出,请等待对方同意！
ShowMsg_688	您还没有结缘，不能领取奖励！
ShowMsg_689	您已领取过结缘奖励,不能再次领取！
ShowMsg_690	恭喜您成功领取末日结缘奖励！
ShowMsg_691	只有集齐“圣诞快乐”四个字才能兑换奖励！
ShowMsg_693	对不起，您已在自己庄园中!
ShowMsg_694	对不起，对方不在线
ShowMsg_695	对不起，对方不允许进入庄园
ShowMsg_696	对不起，您操作太频繁了
ShowMsg_697	您已参加宴会
ShowMsg_698	^0"%S"^1在对^0“%S”^1敬酒时一饮而尽，幸运的在杯底发现5点绑定元宝
ShowMsg_699	玉石副本
]]--
}

local uv_tiptb = { id = 0, arg = {0,} }

--------------------------------------------------------------------------
--interface:
--Get Tip Msg
--id为空表示后台提示的字符串（不支持构造），arg1为表索引
--id不为空，则id为前台配置的提示信息索引，arg1.arg2为替换参数（目前不支持多于2个参数）
function GetStringMsg(id,arg1,arg2)
	local tb = uv_tiptb
	if tb == nil then return end
	
	for i=1 ,#(tb.arg) do
		tb.arg[i]=nil
	end

	if id == nil and type(arg1) == type(0) then 
		tb.arg[1] = All_TIP_MSG[arg1]
	else
		tb.id = id
		tb.arg[1] = arg1
		tb.arg[2] = arg2
	end
	return tb
end