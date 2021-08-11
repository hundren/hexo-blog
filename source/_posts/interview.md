---
title: 面试经历
date: 2021-08-15 23:09:37
categories: 文章
tags: [面试]
---
分享一下一些面试经历
***

## 腾讯-小游戏部门

笔试题

```js
-/**
 * 给定一组图片链接，加载全部图片
 * @param {String[]} imgList 图片链接数组
 * @return {Promise}
 */
function loadAllImages(imgList) {

}

function loadOneImage(src) {
  
}
               
const imgList = [
  'https://www.midea.com/1.png',
  'https://www.midea.com/2.png',
  'https://www.midea.com/3.png',
]

// 预期: imgList包含的全部图片链接加载成功后执行回调
loadAllImages(imgList).then((imgs) => {
 console.log('loadAllImages success', imgs);
});

```

* 怎样将html、css转换成canvas
* 有没做过小游戏
* img的onLoad怎样回调
* reactNative 转换成app的原理
* 项目上的问题
* 为什么要用mpvue

## 腾讯-质控部门

### 笔试题

```js
for (var i = 0; i < 10; i++) {
    setTimeout(function () {
      console.log(i)
    }, 1000)
  }
```

```js
aaaabbbccccddfgh  给定一个字符串,写一个函数输出数量最多，相同的也要输出
```

* 忘记问了什么了

## 字节

### 编程题目

```js
* 合并排序
* 写个方法把<div a="111">123</div>转换成对象
```

### 问题

* xhr攻击
* Https安全
* 微前端怎样做样式隔离
* 说说项目上那个很厉害的领域设计模型
* websocket 原理

## 欢聚

题目1

```js
setTimeout(() => {
  console.log(2)
}, 0);
const promise = new Promise((resolve,reject)=>{
  console.log(3);
  resolve(7)
  console.log(4)
})
promise.then((value)=>{
  console.log(5)
  console.log(value)
  return Promise.resolve(8)
}).then((value)=>{
  console.log(value)
})
console.log(6)
```

题目2

```js
arr.splice()
arr.reverse()
arr.slice()
arr.map()
哪些会造成数组原结构改变
```

* 输入url整个过程
* 说说跨域
* 协议、域名、端口哪些会造成跨域
* 浏览器缓存
* 301 是什么
* cookie跨域获取
* vue的mixins的顺序，mixins，page和子组件
* created生命周期获取dom
* 说说事件循环
* 说说TCP的3次握手，第2次中断了会怎样
* 指令有什么生命周期

### 树根

```js
function delayToEcho (msg, cb) {
  setTimeout(() => {
    const err = Date.now() % 2 === 0 ? null : new Error();
    cb(err, msg);
  }, 1000);
}

// 正常调用
delayToEcho('msg', (err, msg) => {});

function promisify (fn) {
  return (msg)=>{
    // 请把这个函数实现，能够让第 #15 行开始的代码能够成功运行
    return new Promise((resolve,reject)=>{
      fn(msg,(err,msg)=>{
        if(err){
          reject(err)
        }else{
          resolve(msg)
        }
      })
    })
  }
}

// console.log('promisify',promisify(delayToEcho)('dddd'))
promisify(delayToEcho)('msg')
.then(msg => {
  console.log('msg',msg);
})
.catch((err) => {
  console.log('err',err);
});
```

* 样式居中
* new方法
* react 的hooks有哪些
* 箭头函数特点

### 碧桂园

* 浏览器缓存
* vue的diff
* object对象有哪些不能枚举
* 说说es6数组的新api

### 欢聚shopeline

## 一面

* 浏览器的性能瓶颈
* webpack的dll缓存你们的更新机制
* umi的不好的地方
* vue和react不同的性能优化方法
* 一个main.js包和多个小包的各自的好处
* cdn缓存的方法、页面数据缓存
* vue的渲染生命周期
* ci/cd的实现
* 组件库的设计
* ts的使用情况
* vue2对ts的支持
* 有什么项目比较有痛点
* 有没做过ssr
* 飞冰和umi的区别
* react的jsx怎样转换成页面

## 二面

* webpack5的联邦绑定
* 微前端怎样渲染那个url
* nodejs多线程怎样通信
* nodejs中间件怎样数据共享
* websocket突然收到多个并发怎样处理
* nodejs的global是什么

### YY

* 树的最大权重路径问题（随机权重）
* cookie跨域设置
* 防御dns攻击
* ssr怎样知道html和数据返回了
* 前端负责人和一线技术
* 聊聊微前端
* Https为什么可以防止dns攻击
* nodejs的内存泄漏定位
* 写个左右布局的样式，头像固定
* vue 和 react 的对比
* react Native 的写法

## 二面

* 我想发一个跨域，header需要怎样配置（Access-Control-Allow-Origin:*）
* webpack5有什么新特性
* webpack5的tree shaking和webpack4有什么区别
* 有没有了解过server worker
* 有没有了解过webworker，用在什么地方
* webgl基于什么实现
* 说说vue的路由原理，hash和history分别用到什么api
* computed是个独立的沙箱，说说vuex怎么会被computed监听到
* canvas怎样读取图片，怎样获取canvas图片后的色值，上传到服务器用什么办法
* 如何控制canvas动画的快慢
* ci/cd 的实现，docker机制
* 让你用c语言自己实现一个数组的push要怎样写
* 微前端的原理
* webassembly有没了解过，他最终浏览器是会转成什么
* nodejs 的守护进程用什么，他们的原理是怎样的
* 开发nodejs的时候是怎样部署到服务器的
* websocket的底层原理，最大并发是多少，服务器怎样限制这个最大并发数
* 说说v8的堆和栈，（基础类型和引用类型，基本类型栈，引用堆）
* 为什么考虑到用RN
* 进程和线程的区别
* 移动端自适应方案
