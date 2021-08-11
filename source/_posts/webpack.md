---
title: webpack
date: 2021-05-29 17:26:28
categories: 知识总结
tags: [重学前端]
---

### 我们常说的Module是什么

webpack支持 ESModule, CommonJS, AMD, Assests

### 如何表达各种依赖关系？

### 我们常说的chunk和bundle的区别是什么？（important！）

1. Chunk
是Webpack打包过程中Modules的集合，是`打包过程`中的概念。
Webpack的打包是从⼀个⼊⼝模块开始，⼊⼝模块引⽤其他模块，模块再引⽤模块。
Webpack通过引⽤关系逐个打包模块，这些module就形成了⼀个Chunk。
当然如果有多个⼊⼝模块，可能会产出多条打包路径，每条路径都会形成⼀个Chunk。

2. bundle
Bundle是我们最终输出的⼀个或多个打包好的⽂件

3. Chunk 和 Bundle 的关系?
大多数情况，一个chunk一个bundle

### Plugin 和 Loader 分别做什么？怎样工作的？

1. Loader
模块转换器，将非js模块转化为webpack能识别的
2. Plugin
扩展插件,webpack各个阶段都会广播出对应的事件
3. Compiler
对象，也可以理解为webpack的实例

4. Compliation
模块资源

### 简单描述一下打包过程

1. 初始化参数：shell webpack.config.js
2. 开始编译
3. 确定入口
4. 编译模块
5. 完成模块编译
6. 输出资源
