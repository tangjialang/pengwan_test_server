--[[
file:	Region_Create.lua
desc:	region create conf.
author:	chal
update:	2011-12-05
refix: done by chal
]]--

----------------------------------------------------------------
--include:
local type,pairs = type,pairs
local CI_CreateRegion = CI_CreateRegion
----------------------------------------------------------------
--inner:

--[[	 
	 MapID-地图编号(与键值一致) ,
	 property - 场景属性(1 普通 2 不保存坐标（返回出生点）4 对象可重叠  8 要公告掉落物品)  包含两项就是数值相加
	,limit - 场景限制 (1 限制坐骑 2 限制飞行 4 等级pk限制 8 限制挂机 16 限制换装备,32 限制自动使用道具  64 限制召唤随从,128 限制变身 256 怒气清零)
	,rid - 复活点地图,rx - 复活坐标,ry- 复活坐标,level - 等级限制 ,multi - 场景多倍经验(1=正常经验，1.5=1.5倍经验，2=2倍经验) ,
	PKType - PK限制 (0 允许 1 禁止 2 竞技),
	PKMode - PK模式,(0x00 所有可PK  0x01 回避同阵营 0x02 回避异阵营 0x04 回避中立 0x08回避同职业 0x10 回避异职业 0x20 回避同帮会 0x40 回避异帮会 0xFF 回避所有)
	PKLvDiff - 允许PK的最大等级差
	dbuf = 1  地图配置加这个字段表示死亡会加保护buffer
	PKLost = 1   --死亡会掉落神器碎片或爆元宝
	PKValue=1,   --杀人会加PK值
	
	
]]--
local _RegionTable = {
[1] = { dbuf = 1,MapID = 1,MapName = "西岐城",property = 1,limit = 0 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0,Monster = {1}}, --京城
--[2] = { MapID = 2,MapName = "新手村",property = 5,limit = 0 ,rid = 2,rx = 80,ry = 120,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, --新手村
[3] = { MapID = 3,MapName = "昆仑山",property = 5,limit = 0 ,rid = 3,rx = 100,ry = 159,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0,Monster = {3}}, --新手村
--[4] = { MapID = 4,MapName = "新手村",property = 5,limit = 0 ,rid = 4,rx = 80,ry = 120,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, --新手村
--[5] = { MapID = 5,MapName = "新手村",property = 5,limit = 0 ,rid = 5,rx = 80,ry = 120,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, --新手村
[6] = { MapID = 6,PKLost =1,PKValue=1, MapName = "西岐郊野",property = 1,limit = 4 ,rid = 6,rx = 10,ry = 116,level= 10,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, --西岐郊野
[7] = { MapID = 7,PKLost =1,PKValue=1, MapName = "乾元山",property = 1,limit = 4 ,rid = 7,rx = 87,ry = 24,level= 10,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, --乾元山
[8] = { MapID = 8,PKLost =1,PKValue=1, MapName = "陈塘关",property = 1,limit = 4 ,rid = 8,rx = 54,ry = 12,level= 20,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[10] = { MapID = 10,PKLost =1,PKValue=1, MapName = "渭水",property = 9,limit = 4 ,rid = 10,rx = 18,ry = 151,level= 35,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[11] = { MapID = 11,PKLost =1,MapName = "帮会运镖",property = 1,limit = 2 ,rid = 11,rx = 20,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=32 , PKLvDiff = 0}, 
[12] = { MapID = 12,PKLost =1,PKValue=1, MapName = "牧野",property = 9,limit = 4 ,rid = 12,rx = 18,ry = 151,level= 50,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[13] = { MapID = 13,PKLost =1,PKValue=1, MapName = "朝歌",property = 9,limit = 4 ,rid = 12,rx = 18,ry = 151,level= 50,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},

[22] = { MapID = 22,PKLost =1,PKValue=1,MapName = "瘴气沼泽",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 30,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[23] = { MapID = 23,PKLost =1,PKValue=1,MapName = "百鬼妖树",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 30,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[24] = { MapID = 24,PKLost =1,PKValue=1,MapName = "金光洞1层",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[25] = { MapID = 25,PKLost =1,PKValue=1,MapName = "金光洞2层",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[28] = { MapID = 28,PKLost =1,PKValue=1,MapName = "听风林1层",property = 1,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 50,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[29] = { MapID = 29,PKLost =1,PKValue=1,MapName = "听风林2层",property = 1,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 50,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[30] = { MapID = 30,PKLost =1,PKValue=1,MapName = "深海海底",property = 1,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[31] = { MapID = 31,PKLost =1,PKValue=1,MapName = "东海龙宫",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[32] = { MapID = 32,PKLost =1,PKValue=1,MapName = "东海逍遥阁",property = 1,limit = 6 ,rid = 1,rx = 60,ry = 90,level= 20,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[33] = { MapID = 33,PKLost =1,PKValue=1,MapName = "定海神针",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[34] = { MapID = 34,PKLost =1,PKValue=1,MapName = "乾元后山",property = 1,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 30,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[100] = { MapID = 100,MapName = "阳光沙滩",property = 1,limit = 195 ,rid = 1,rx = 60,ry = 90,level= 30,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[101] = { MapID = 101,MapName = "竞技空间",property = 1,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 30,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  

[200] = {dbuf = 1, MapID = 200,PKValue=1,MapName = "挂机迷阵1层",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 37,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[201] = {dbuf = 1, MapID = 201,PKValue=1,MapName = "挂机迷阵2层",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 37,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[202] = {dbuf = 1, MapID = 202,PKValue=1,MapName = "挂机迷阵3层",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[203] = {dbuf = 1, MapID = 203,PKValue=1,MapName = "挂机迷阵4层",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[204] = {dbuf = 1, MapID = 204,PKValue=1,MapName = "挂机迷阵5层",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[205] = {dbuf = 1, MapID = 205,PKValue=1,MapName = "挂机迷阵6层",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[206] = {dbuf = 1, MapID = 206,PKValue=1,MapName = "挂机迷阵7层",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[207] = {dbuf = 1, MapID = 207,PKValue=1,MapName = "挂机迷阵8层",property = 9,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 40,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 

[500] = { MapID = 500,MapName = "曲水流觞",property = 2,limit = 195 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[501] = { MapID = 501,MapName = "天宫狩猎",property = 2,limit = 195 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[502] = { MapID = 502,MapName = "深海捕鱼",property = 2,limit = 195 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[503] = { MapID = 503,PKLost =1,MapName = "三界战场",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=1 , PKLvDiff = 0}, 
[504] = { MapID = 504,PKLost =1,MapName = "帮会战场",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=32 , PKLvDiff = 0}, 
[505] = { MapID = 505,MapName = "帮会BOSS",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[506] = { MapID = 506,MapName = "海洋",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[507] = { MapID = 507,MapName = "塔防副本",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0}, 
[508] = { MapID = 508,MapName = "瑶池温泉",property = 2,limit = 195 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[509] = { MapID = 509,MapName = "水晶矿洞",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[510] = { MapID = 510,MapName = "竞技场",property = 2,limit = 2 ,rid = 101,rx = 16,ry = 10,level= 0,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[512] = { MapID = 512,MapName = "排位赛",property = 2,limit = 98 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0}, 
[513] = { MapID = 513,MapName = "沼泽",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[514] = { MapID = 514,MapName = "森林",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[515] = { MapID = 515,MapName = "熔岩",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[516] = { MapID = 516,MapName = "宝石副本",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[517] = { MapID = 517,MapName = "经验副本",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0},  
[518] = { MapID = 518,MapName = "铜钱副本",property = 6,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[519] = { MapID = 519,MapName = "远古遗迹",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[520] = { MapID = 520,MapName = "帮会驻地",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[521] = { MapID = 521,MapName = "帮会秘境",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[522] = { MapID = 522,MapName = "神创天下",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[523] = { MapID = 523,PKLost =1,MapName = "王城争霸",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=32 , PKLvDiff = 0},  
[524] = { MapID = 524,MapName = "元神副本",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[525] = { MapID = 525,MapName = "帮会试炼副本",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[526] = { MapID = 526,MapName = "五行炼狱副本",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[527] = { MapID = 527,MapName = "本命法宝",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},
[528] = { MapID = 528,MapName = "单人塔防",property = 4,limit = 238 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},
[530] = { MapID = 530,MapName = "服务器副本",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0},
[531] = { MapID = 531,MapName = "轩辕坟",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},
[532] = { MapID = 532,MapName = "服务器副本2",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0},
[533] = { MapID = 533,PKLost =1,MapName = "服务器副本3",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=21 , PKLvDiff = 0},
[534] = { MapID = 534,MapName = "玄天阁",property = 2,limit = 258 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0}, 

[1001] = { MapID = 1001,MapName = "深海捕鲨",property = 2,limit = 195 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1002] = { MapID = 1002,MapName = "沼泽郊野",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1003] = { MapID = 1003,MapName = "百鬼妖树",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1004] = { MapID = 1004,MapName = "金光洞1层",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1005] = { MapID = 1005,MapName = "金光洞2层",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1006] = { MapID = 1006,MapName = "乾元后山",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 

[1008] = { MapID = 1008,MapName = "听风林1层",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1009] = { MapID = 1009,MapName = "听风林2层",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1010] = { MapID = 1010,MapName = "熔岩秘窟",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},
[1011] = { MapID = 1011,MapName = "东海逍遥阁",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},
[1012] = { MapID = 1012,MapName = "东海1层",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[1013] = { MapID = 1013,MapName = "水晶龙宫",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[1014] = { MapID = 1014,MapName = "深渊洞穴",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1015] = { MapID = 1015,MapName = "郊野沼泽",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1016] = { MapID = 1016,MapName = "定海神针",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1017] = { MapID = 1017,MapName = "赤霄",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1018] = { MapID = 1018,MapName = "碧霄",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1019] = { MapID = 1019,MapName = "紫霄",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1020] = { MapID = 1020,MapName = "青霄",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1021] = { MapID = 1021,MapName = "独木桥",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0}, 
[1022] = { MapID = 1022,MapName = "寒冰阵",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1023] = { MapID = 1023,MapName = "金光阵",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0}, 
[1027] = { MapID = 1027,MapName = "瘴气沼泽",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[1032] = { MapID = 1032,MapName = "坐骑装备副本1",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[1033] = { MapID = 1033,MapName = "坐骑装备副本2",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[1034] = { MapID = 1034,MapName = "坐骑装备副本3",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  

[1036] = { MapID = 1036,PKLost =1,MapName = "天降宝箱",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[1037] = { MapID = 1037,MapName = "坐骑装备副本1",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[1038] = { MapID = 1038,MapName = "坐骑装备副本2",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[1039] = { MapID = 1039,MapName = "坐骑装备副本3",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0},  
[1040] = { MapID = 1040,MapName = "夫妻副本",property = 2,limit = 66 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0},  
[1041] = { MapID = 1041,PKLost =1,MapName = "跨服BOSS",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[1042] = { MapID = 1042,MapName = "升星副本",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0},  
[1043] = { MapID = 1043,PKLost =1,MapName = "跨服寻宝",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0},  
[1044] = { MapID = 1044,MapName = "夫妻同心",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0}, 
[1045] = { MapID = 1045,MapName = "跨服1v1",property = 2,limit = 2 ,rid = 1,rx = 70,ry = 70,level= 0,multi= 1,PKType = 0, PKMode=0 , PKLvDiff = 0}, 
[2000] = { MapID = 2000,MapName = "庄园副本",property = 2,limit = 2 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0}, 
[2001] = { MapID = 2001,MapName = "庄园",property = 2,limit = 98 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0}, 
[2002] = { MapID = 2002,MapName = "庄园",property = 2,limit = 98 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=1 , PKLvDiff = 0}, 
}

-- --跨服服务器启动时需要创建的地图
-- local _RegionTable_kuafu = {
-- 	[1] = { dbuf = 1,MapID = 1,MapName = "西岐城",property = 1,limit = 0 ,rid = 1,rx = 60,ry = 90,level= 0,multi= 1,PKType = 1, PKMode=0 , PKLvDiff = 0,Monster = {1}}, --京城
-- }

-- 跨服地图
local span_maps = {1041,1043,502,503,1045}

function IsSpanMap(MapID)
	for k, id in ipairs(span_maps) do
		if MapID == id then
			return true
		end
	end
	return false
end


-- local r_id={200 ,201 ,202 ,203 ,204 ,205 ,518,22, 23 , 24, 25,   31 , 33}
local r_id={200 ,201 ,202 ,203 ,204 ,205 ,518}
if __plat==101 then 
	for k,v in pairs(r_id) do
		if _RegionTable[v] then 
			if  _RegionTable[v].property==1 then 
				_RegionTable[v].property=5
			elseif  _RegionTable[v].property==2 then 
				_RegionTable[v].property=6
			end
		end
	end
end
----------------------------------------------------------------
--interface:

-- 封装C创建场景接口
-- @regionType [0] 普通场景 [-1] 动态场景 [> 0] 副本GID
-- @Manual [0] 自动管理场景删除 [1] 手动管理场景删除
function PI_CreateRegion(MapID,regionType,Manual,name)
	local mapTb = _RegionTable[MapID]
	if mapTb == nil or type(mapTb) ~= type({}) then
		return
	end
	local gid = CI_CreateRegion( mapTb, regionType, Manual, name)
	if gid then	
		-- 加载场景配置文件
		LoadRegionConfEx(MapID,gid)
	end
	return gid
end


--开服创建
function GI_CreateMap()
	-- local r_table=_RegionTable
	-- if  IsSpanServer() then
	-- 	r_table=_RegionTable_kuafu
	-- end
	for MapID, MapConf in pairs( _RegionTable ) do
		if MapID < 500 then
			local ck = PI_CreateRegion(MapID, 0, 0)
			-- 返回0表示该场景已存在
			if ck and ck ~= 0 then
				-- 创建怪物				
				if type(MapConf.Monster) == type({}) then
					for _,id in pairs(MapConf.Monster) do
						CreateMonsterByID(id,MapID)
					end
				end
			end
		end
	end
end

RegionTable = _RegionTable