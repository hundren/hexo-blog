---
title: react核心
date: 2021-06-21 22:20:38
categories: 知识总结
tags: [重学前端]
---
## react 的fiber

有5个优先级的等级

* Immediate
* UserBlocking
* Normal
* Low
* Idle

## 高阶组件

### 怎么写一个高阶组件？

1. 普通方式
2. 装饰器
3. 多个高阶组件组合

### 高阶组件

1. 属性代理

  1、操作props
  2、操作ref

2. 继续/劫持

## 什么是react hooks?优势

## react hooks 有什么优势

### class 的缺点

1. 组件间的状态逻辑很难复用
不要在render里写bind

### hooks 的优点

1. 利于业务逻辑的封装和拆分，可以自由自定义hooks
useEffect(()=>{})

### hooks使用注意事项

1. 不能在循环判断里用
   索引问题
2. 只能在 React 的函数组件中调⽤ Hook，不要在其他 JavaScript 函数中调⽤
