---
title: React-native,我们一起走过的坑。
date: 2018-04-19 23:09:37
categories: 学习笔记
tags: [JS填坑,填坑]
---

前几个星期，点开了RN的技能树，废话不多说，那我就意简言赅地记录一下自己遇到的坑，避免后人再犯自己的错误。
<!-- more -->
先说明一下我的运行环境：
1.我当时这个年代用的RN版本是0.55
2.使用的脚手架是create-react-native-app
# 调试
## EJECT前（即生成那个android和ios文件前）
如果你像我那样，按照官方的说明方法：初始化了一个项目
但也是找不到android和ios文件的话，不要慌张，要淡定，因为这时你还没有EJECT，官方解析就是：
"eject" eventually to create your own native builds
但是，是男人的话怎么能那么快eject的，所以这时就该大名鼎鼎的'Expo'登场了，你只需要在你的手机或者模拟器上安装上这个最新版的'Expo'软件，然后在你的本地项目运行命令npm start，这时不出意料的话你就会弹出一个二维码出来（但是不知为何我每次都是出意外地弹了一个崩了的二维码），在你的Expo上扫一扫就能运行成功了，当然最后是少不摇一摇你的手机打开调试，Android模拟器：Command⌘ + M，iOS模拟器：Command⌘ + D，打开Enable Live Reload,然后你就能愉快地撸码了。
但是身为一个前端工程师，一眼见不到那个盒子模型，心里总会不舒服的，这时，你只要执行上面一样的操作，选择Show inspector就行了。
![](/images/Developer Menu.jpg)
## EJECT后
这时候，情况就比较尴尬了
这时你已经进入了贤者模式，而你的项目结构也会发生一些微妙的变化，看你能不能找出来，找出来后，这时候你要面对就是那个android文件夹和ios文件夹，身为一个只懂JS的前端工程师的我来说，一开始我是拒绝的
但是深入理解之后，我发现我其实根本不用管它们的。
当运行npm run android/npm run ios后，你的手机/模拟器毫无意外就会被强制地安装上了一个应用了，这时候调试同上的。
>总结
>普通手机应用的话还是eject后真机模拟器调试方便的，不竟后面还有一些你预想不到的一些npm模块居然还要更改android文件什么才能用的，哼(￢︿̫̿￢☆)
>如果你那么不幸，像我一样要开发什么鬼特制机的话，那些机全身上下只有一些USB接口，而接上电脑后又完全没有响应的话，这时候EXPO那骚一般的远程调试就适合不过了

# 样式
## 不能继承 不能继承 不能继承
好吧，我先深呼吸一下，先放些代码给大家感受下
``` bash
<View style={styles.view}>
    <Text style={styles.text}></Text>
    <Text style={styles.text}></Text>
</View>
const styles = StyleSheet.create({
  view: {
    width:300,
  }，
  text：{
    fontSize:10,   
  }
 }
```
如果你想把这个view里面的text字体都设为10的话怎么办？
嗯，没错，你只能乖乖地每一个text都写上一个样式了。
好吧，首先我们要知道它是模仿css的规则的而已，所以也就只能这样了。

## 默认尺寸是DP
百分比不能用
可以用flex:1,flex:2,做等比例

# 组件坑
## Image
### 要先设宽高
为了性能方便所有网络图片都要先设固定宽高（来自官方傲娇的解析）
像这样
``` bash
 <Image 
    style={{width: 100, height: 100}}
    source={{uri: url}}
/>
```
那么问题来了，我特么的怎么知道图片的尺寸是什么。
解决方法：
1、使用Image自带的getSize方法先获取宽高
2、使用别的大神的组件React Native Fit Image 等

### 资源超过400kb左右不显示
所以说原生组件，😔
推荐使用别的组件库：react-native-fast-image（要先装个glide，略为麻烦）

### 静态资源
source={require('./xxx.jpg')} 资源路径不能拼接，但可以这样写
``` bash
const a=require('./xxx/')
<Image source={a}/>
```

## 点击事件尽量使用Touchable开头的

## react-navigation
官方推荐的路由组件库
我使用StackNavigator方法
坑1： navigation.goBack()，返回上一个页面所有生命周期都没有进入，不像小程序有一个onShow周期
坑2：navigation.goBack()，不能带参数
我的解决办法：
1、把方法传进下一个页面，goBack()前调用
2、传入route_key，使用setParams方法传参

# 打包
建议按官网流程
我踩过的坑：index.js 里的 registerComponent 不同app要不一样

*未完待续*

