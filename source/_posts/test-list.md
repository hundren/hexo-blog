---
title: 一些前端题目
date: 2018-03-22 23:09:37
categories: 学习笔记
tags: [面试,题目]
---
# 整理一下一些前端题目
<!-- more -->
## 以下分别输出什么,为什么

``` bash
var User = {
  count: 1,
  getCount: function() {
    return this.count;
  }
};
 
console.log(User.getCount());  // what?
var func = User.getCount;
console.log(func());  // what?

```
答案是:1和undefined。

## 以下代码执行结果是什么

``` bash

  var foo = 1,bar = 2,j,test;
  test = function(j) {
      j = 5;
      var bar = 5;
      foo = 5;
  }
  test(10);
  console.log(foo); //
  console.log(bar); //
  console.log(j); //

};
 
console.log(User.getCount());  // what?
var func = User.getCount;
console.log(func());  // what?

```
答案是:5 2 undefined。

## 说出输出的结果顺序

``` bash
setTimeout(function() {
  console.log(1)
}, 0);
new Promise(function executor(resolve) {
  console.log(2);
  for( var i=0 ; i<10000 ; i++ ) {
    i == 9999 && resolve();
  }
  console.log(3);
}).then(function() {
  console.log(4);
});
console.log(5);

```
答案：“2 3 5 4 1”

## 以下代码执行结果是什么

``` bash
function foo() {this.value = 42;}
foo.prototype = {method: function () {return true;}};
function bar() {
    var value = 1;
    return{method:function(){return value;}};
}
foo.prototype = new bar();
console.log(foo.prototype.constructor); //
console.log(foo.prototype instanceof  bar); //
var test = new foo();
console.log(test instanceof foo);//
console.log(test instanceof bar);//
console.log(test.method());//

```
答案：ƒ Object() { [native code] } 
      False
      true
	  false
      1

## 用纯css,html写一个导航栏的tab切换(不使用js)

``` bash
方法1：
<ul class='nav'>
    <li><a href="#content1">列表1</a></li>
    <li><a href="#content2">列表2</a></li>
</ul>
<div id="content1">列表1内容:123456</div>
<div id="content2">列表2内容:abcdefgkijkl</div>
<style type="text/css">
	#content1,
	#content2{
	    display:none;
	}
 
	#content1:target,
	#content2:target{
	    display:block;
	}
	#content1:target ~ .nav li{
	    // 改变li元素的背景色和字体颜色
	    &:first-child{
	        background:#ff7300;
	        color:#fff;
	    }
	}
	#content2:target ~ .nav li{
	    // 改变li元素的背景色和字体颜色
	    &:last-child{
	        background:#ff7300;
	        color:#fff;
	    }
	}
</style>
方法2：
<div class="container">
    <input class="nav1" id="li1" type="radio" name="nav">
    <input class="nav2" id="li2" type="radio" name="nav">
    <ul class='nav'>
        <li class='active'><label for="li1">列表1</label></li>
        <li><label for="li2">列表2</label></li>
    </ul>
    <div class="content">
        <div class="content1">列表1内容:123456</div>
        <div class="content1">列表2内容:abcdefgkijkl</div>
    </div>
</div>
<style type="text/css">
	.container{
    position:relative;
    width:400px;
    margin: 50px auto;
}
input{
    display:none;
}
.nav{
    position:relative;
    overflow:hidden;
}
li{
    width:200px;
    float:left;
    text-align:center;
    background:#ddd;
}
li label{
    display:block;
    width:200px;
    line-height:36px;
    font-size:18px;
    cursor:pointer;
}
.content{
    position:relative;
    overflow:hidden;
    width:400px;
    height:100px;
    border:1px solid #999;
    box-sizing:border-box;
    padding:10px;
}
.content1,
.content2{
    display:none;
    width:100%;
    height:100%;
}
.nav1:checked ~ .nav li {
    background:#ddd;
    color:#000;
    
    &:first-child{
        background:#ff7300;
        color:#fff;
    }
}
.nav2:checked ~ .nav li{
    background:#ddd;
    color:#000;
    
    &:last-child{
        background:#ff7300;
        color:#fff;
    }
}
.nav1:checked ~ .content > div{
    display:none;
    
    &:first-child{
    display:block;
    }
}
.nav2:checked ~ .content > div{
    display:none;
    
    &:last-child{
    display:block;
    }
}
.active {
        background:#ff7300;
        color:#fff;
}
.default{
    display:block;
}
</style>

```

## 编写程序，统计字符串var str="helloworld";中每种字符出现的次数,出现次数最多的是? 出现?次

``` bash
var str="helloworld";
  方法一：用hash
  for(var i=0,hash={};i<str.length;i++){
    if(hash[str[i]]){
      hash[str[i]]++
    }else{
      hash[str[i]]=1;
    }
  }
  console.dir(hash);
方法二：用正则
var arr=str.split("")
  .sort()
  .join("")
  .match(/([a-z])\1*/g)
  .sort(function(a,b){
return b.length-a.length; })
console.log("出现最多的是: "+arr[0][0]
  +"共"+arr[0].length+"次");
var hash={};
  arr.forEach(function(val){
    hash[val[0]]=val.length;
  });
  console.dir(hash);
```

## 民间有一直有一游戏，玩法就是，大家轮流报数，如果报到能被7整除的数字，或者尾数是7的数字，都算踩地雷了。就应该罚唱歌。
请编写程序，输出1~60之间的所有“安全数”
比如：
1、2、3、4、5、6、8、9、10、11、12、13、15、16、18、19、20、22、23、24、25、26、29、30……

``` bash
for(var i = 1; i <= 60 ; i++){
if(i%7 == 0 || i%10 == 7){
console.log(i);
}
}
```

## 浏览器输入url到完整显示出页面经历的过程
第一种简单的说呢就是这样的：
第一步：客户机提出域名解析请求,并将该请求发送给本地的域名服务器。
第二步：当本地的域名服务器收到请求后,就先查询本地的缓存,如果有该纪录项,则本地的域名服务器就直接把查询的结果返回。
第三步：如果本地的缓存中没有该纪录,则本地域名服务器就直接把请求发给根域名服务器,然后根域名服务器再返回给本地域名服务器一个所查询域(根的子域)的主域名服务器的地址。
第四步：本地服务器再向上一步返回的域名服务器发送请求,然后接受请求的服务器查询自己的缓存,如果没有该纪录,则返回相关的下级的域名服务器的地址。
第五步：重复第四步,直到找到正确的纪录。


## 机试题
 ·点击某个节点元素，则该节点元素呈现一个特殊被选中的样式
 ·增加一个删除按钮，当选中某个节点元素后，点击删除按钮，则将该节点及其所有子节点删除掉
 ·增加一个输入框及一个“添加”按钮当选中某个节点元素后，点击增加按钮，则在该节点下增加一个子节点，节·点内容为输入框中内容，插入在其子节点的最后一个位置
 ·提供一个按钮，显示开始遍历，点击后，以动画的形式呈现遍历的过程
 ·当前被遍历到的节点做一个特殊显示（比如不同的颜色）
 ·每隔一段时间（500ms，1s等时间自定）再遍历下一个节点
 ·增加一个输入框及一个“查询”按钮，点击按钮时，开始在树中以动画形式查找节点内容和输入框中内容一致的节点，找到后以特殊样式显示该节点，找不到的话给出找不到的提示。查询过程中的展示过程和遍历过程保持一致

[神奇的链接](http://ife.baidu.com/2016/task/all)