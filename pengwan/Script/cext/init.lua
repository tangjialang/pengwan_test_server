--[[
cext为游戏通用功能的扩展类库
未封装为module的文件暂时用dofile
封装后的用require加载
其中si库可以在各个功能模块中做扩展
目前包括：
cext.tool		工具函数库
cext.define 	全局定义库
cext.dbrpc  	存储过程接口库
cext.tip 		通用提示消息库
cext.mail 		邮件接口库
cext.PI 		lua内部提供的用于封装CI接口或者提供给全局调用的接口库
cext.SI 		lua提供给c调用的接口库
cext.award 		通用奖励库
cext.cehua		策划接口库
]]--
dofile("cext\\tip.lua")
dofile("cext\\mail_Conf.lua")
dofile("cext\\mail.lua")
dofile("cext\\PI.lua")
dofile("cext\\SI.lua")

dofile("cext\\award.lua")
dofile("cext\\cehua.lua")
dofile('cext\\damage.lua')
dofile('cext\\dyn_drop.lua')


require('Script.cext.define')
require('Script.cext.tool')
require('Script.cext.dbrpc')