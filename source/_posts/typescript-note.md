---
title: TypeScript学习笔记
date: 2019-05-19 23:00:46
categories: 学习笔记
tags: [JS填坑,填坑]
---
# 个人理解
## 定义
'TypeScript'-顾名思义，就是有Type的Script
<!-- more -->
****
那么它和没有Type的Script有什么不一样呢，例如某Java前缀的Script
举个例子：实际开发需求中我们要定义一个商品名称的变量为goodsName(<font color=red>ps:众所周知商品名称都必须是要字符串的</font>)
```js
// js中定义一个变量,先赋值一个字符串
let goodsName = 'apple' // 很好，看起来都一起正常
// 然鹅，一位刚失恋的程序员哥哥，不小心把它改成一个数字（说笑，程序员哪会有女朋友）
goodsName = 520 // 这时候程序也没有阻止小哥哥这种赤裸裸的示爱行为
// 甚至可以改成布尔值
goodsName = true
// -----------------
// 可以想想刚失恋的小哥哥，把这个变量提交给后端的接口
// 最后给产品发现了
// 后端调查发现是前端提交的数据类型错误
// 顺利摔锅给前端
// 从此小哥哥就步入了人生的低谷，情场事业双失😔
```
然而如果这时候这位程序员小哥哥用上了TypeScript
```js
// 同上也先定义一个变量
let goodsName: string = 'apple' // 看看有什么不同？没错，就是多了个string
goodsName = 520 //这时候就会有一条红线在变量下方
// Error, number不是string类型
// -----------------
// 看到这条提示的红线，小哥哥也终于意识到了
// 他的爱情也像这条红线那样
// 已经到了高亮的结束边缘
// 最后小哥哥看着那条红线
// 突然对爱情重拾希望，然后不顾红线的错误提示，提交给后端
// 结局同上
```
## 一些踩过的坑
### 可选属性
``` bash
interface SquareConfig {
  color?: string;
  width?: number;
}
```
### 任意数量的其它属性
``` bash
interface SquareConfig {
 [propName: string]: any;
}
```
### 只读属性
``` bash
interface Point {
    readonly x: number;
    readonly y: number;
}
let p1: Point = { x: 10, y: 20 };
p1.x = 5; // error!
```
### 函数类型
``` bash
//方法1
function add(x: number, y: number): number {
    return x + y;
}

//方法2
let myAdd = function(x: number, y: number): number { return x + y; };
```
### 把类当做接口使用
``` bash
class Point {
    x: number;
    y: number;
}

interface Point3d extends Point {
    z: number;
}

let point3d: Point3d = {x: 1, y: 2, z: 3};
```
# 总结
1. 提示真的很爽
2. 会增加写类型的时间
3. 大型项目来说上面花的时间是值得的，后期维护时间会变少

