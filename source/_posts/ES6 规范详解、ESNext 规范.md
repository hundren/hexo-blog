---
layout: es6
title: ES6 规范详解、ESNext 规范
date: 2021-04-28 21:53:20
categories: 知识总结
tags: [重学前端]
---
## 定义变量

var、const、let、function
let 变量提升、作用域

### 箭头函数

1、箭头函数this是定义时决定，普通函数是使用时决定
2、简写

```js
const fn = ()=> 'sss'
```

3、不能做构造函数

### class

```js
class Test(){
  static getFormatName(){

  }
}
```

static 静态方法，只能console.log(Test.getFormatName())

### 遍历

1. for in

* 会调用原型链（obj.hasOwnProperty(key)）判断一下
* 不适合遍历数组

2. for of

### Object

1. Object.keys
2. Object.values
3. Object.entries
4. Object.getOwnPropertyNames
5. Object.getOwnPropertyDescriptor
对象的描述

* configurable: true
* writable: false
* enumerable: true //枚举

Reflect 一种js 优化

```js
Reflect.deleteProperty(obj,name) 等
```

### Array

array.slice() 可以浅拷贝

* Array.from
如何把arguments转换成真数组

1. [...arguments]
2. Array.from(arguments)
3. Array.prototype.slice.call(arguments)
