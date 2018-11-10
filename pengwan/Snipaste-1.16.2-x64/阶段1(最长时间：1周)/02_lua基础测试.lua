
本阶段主要考察对lua基础知识的掌握程度

1.lua有哪些变量类型？--nil(空) bool(布尔) number(数字) string(字符串) table(表) function(函数) userdata(自定义类型) thread(线程)

2.如何用lua的逻辑操作符实现 C 语言中的三目运算 a ? b : c , 这个实现方式与 C 语言中的实现是否等价？  --(a and b) or c --A and B A为真则执行B A为假则执行A   A or C A为假则执行C A为真则执行A 和c语言的三目运算符 等价

3.lua函数的参数和返回值与 C 语言相比，有什么区别？ --lua的参数 在函数调用时实参和形参可以个数不同 lua中有变长参数...  

4.何谓尾调用，尾调用有何意义？--当一个函数调用是另一个函数的最后一个动作时 才可以算是一条尾调用 尾调用不需要消耗栈内存 因此递归尾调用层次可以无限制

5.以下两种定义局部函数的方法有没有区别？ --两种写法等价(写递归函数要注意 两种有稍微的不同)
local function fun1() --只是函数写法的一种语法糖 是下面函数书写的简写
--[[
	语法糖会被Lua展开为 先定义好fun1 再把一个函数的值赋值给这个变量接收
	local fun1;
	fun1 = function()end
]]--
	-- body
end

local fun1 = function() --标准函数写法
--[[
在写递归的时候要注意 
由于这种方式定义的函数局部的fun1还没定义完毕
所以在函数内递归 其实调用的是一个全局fun1而并不是函数本身
在写递归函数如果用上面的语法糖方式定义递归函数则不会出错
]]--
	-- body 
end

6.什么是闭包？ --闭包是指一个函数及一系列这个函数会访问到'非局部变量' 
--[[
闭包是由一个函数和该函数会访问到非局部变量所组成的 
非局部变量指的是不在局部范围内 
也不是全局范围内定义的一个变量 
主要应用在嵌套函数和匿名函数里 
如果一个函数没有会访问到非局部变量那么这个函数就是普通的函数
在lua中函数是闭包的一种特殊情况
]]--

7.运行以下代码查看输出结果，解释输出结果为什么是这样。
local data = 100

local function fun1()
	print(data)--访问到非局部变量 upvalue = 200 upvalue(是一个变量不是值)
	data = data+50 --upvalue + 50 一个闭包 每一个闭包函数都有一个upvalue
end

data = 200 --修改 upvalue为200

local data = 300

local function fun2()
	print(data)--访问到非局部变量 upvalue = 300
	data = data+50 --upvalue + 50 一个闭包
end

data = 400 --修改 upvalue为400

fun1() --200
fun2() --400

fun1() --250
fun2() --450
       
8.用lua生成一组10 个 1~100 之间不重复随机数。
math.randomseed(tostring(os.time()):reverse():sub(1, 7)) –-设置时间种子
for i = 1,10 do
	print(math.random(1,100));
end

9.针对以下数据分别以学号升序和成绩降序进行排序，如果成绩相同学号小的排在前面。
	学号		成绩
	58			80
	32			85
	64			92
	21			63
	35			70
	10			51
	97			92
	71			92   

10.输入一个字符串，要求求出字符串中任意字符出现的次数。
如"hello world"中'h'出现1次，'e'出现1次，'l'出现3次，'o'出现2次，'w'出现1次，'r'出现1次，'d'出现1次
local s = {};
local c = io.read();
for v in string.gmatch(c,'%a') do
	if v == nil then
		s[v] = 1;
	else
		s[v] = s[v] + 1;
	end
end
for k,v in pairs(s) do 
    print(k,v);
end


