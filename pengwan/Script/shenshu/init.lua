--require 内部设置了模块搜索路径Script.xxx.yyy  xxx是游戏的什么功能模块 yyy是xxx的什么功能模块
--dofile 内部设置了搜索路径xxx/yyy.lua 同行这里要加.lua后缀名
require("Script.shenshu.jysh_cof") --不管调用多少次只会编译一次
require("Script.shenshu.jysh_fun")
dofile 'shenshu\\message.lua' --每调用就会重新编译一次 dofile加载文件时要加lua的后缀