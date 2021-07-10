---
title: webpack
date: 2021-05-29 17:26:28
categories: 知识总结
tags: [重学前端]
---
### 我们常说的chunk和bundle的区别是什么？（important！）

1. Chunk
是Webpack打包过程中Modules的集合，是`打包过程`中的概念。
Webpack的打包是从⼀个⼊⼝模块开始，⼊⼝模块引⽤其他模块，模块再引⽤模块。
Webpack通过引⽤关系逐个打包模块，这些module就形成了⼀个Chunk。
当然如果有多个⼊⼝模块，可能会产出多条打包路径，每条路径都会形成⼀个Chunk。

2. bundle
Bundle是我们最终输出的⼀个或多个打包好的⽂件

3. Chunk 和 Bundle 的关系?
