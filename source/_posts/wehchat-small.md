---
title: 微信小程序填坑日记
categories: 学习笔记
tags: [微信小程序,填坑]
---
记录一下那些年，开发微信小程序踩过的坑
<!-- more -->
# 微信小程序认识

## 总体认识
隐约感受到的RN的身影
[官方的Q&A文档](https://mp.weixin.qq.com/debug/wxadoc/dev/framework/performance/tips.html)
>为什么脚本内不能使用window等对象
>页面的脚本逻辑是在JsCore中运行，JsCore是一个没有窗口对象的环境，所以不能在脚本中使用window，也无法在脚本中操作组件

碰巧RN也是通过JsCore与手机的原生语言通信的，简单来说它只不过是以 JavaScript 的形式告诉 Objective-C /java该执行什么代码
反正我们知道它能直接调用微信本身的控件就行了
## 小体认识
*MVVM*,*前后端分离*,*数据绑定*,*数据驱动*
![](https://hundren.github.io/demo/blogimg/model.png)
# 一些代码
自定义弹框
``` bash
<view hidden="{{showTrue}}"></view>
<view wx:if="{{showTrue}}"></view>
```
改变样式
``` bash
<view class="{{diyClassName}}"></view>
```
# 学习资源
[最重要的当然是官方文档](https://mp.weixin.qq.com/debug/wxadoc/dev/)
[微信小程序资源汇总](https://github.com/justjavac/awesome-wechat-weapp)
[用chrome运行小程序](https://github.com/chemzqm/wept)
[官方demo源码](https://github.com/Hao-Wu/WeApp-Demo)

# 填过的坑
1.透明底的png图片,border-raduis：50%会变形
2.canvas在swiper和scroll-view不兼容会浮出来
3.iphone：scroll-view内部滚动必须设置高度，在iphone不能设100%,可以通过js设高度或设固定值
4.iphone：image图片里padding不能设百分比,只能设固定值
5.最多只能打开5个页面,注意一下页面跳转的关闭