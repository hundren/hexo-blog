---
title: 一些前端题目
categories: 学习笔记
tags: [面试,题目]
---
整理一下一些前端题目
<!-- more -->
1.用纯css,html写一个导航栏的tab切换
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
2.说出输出顺序结果

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
首先先碰到一个 setTimeout，于是会先设置一个定时，在定时结束后将传递这个函数放到任务队列里面，因此开始肯定不会输出 1 。

然后是一个 Promise，里面的函数是直接执行的，因此应该直接输出 2 3 。

然后，Promise 的 then 应当会放到当前 tick 的最后，但是还是在当前 tick 中。

因此，应当先输出 5，然后再输出 4 。

最后在到下一个 tick，就是 1 。

“2 3 5 4 1”

3.统计字符串中每种字符出现的次数,出现次数最多的是? 出现?次
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
4.以下分别输出什么,为什么
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
答案是1和undefined。

func是在winodw的上下文中被执行的，所以会访问不到count属性。

4.在页面中展现一颗多叉树的结构，如图，并添加节点的选择、增加与删除的功能
 ·点击某个节点元素，则该节点元素呈现一个特殊被选中的样式
 ·增加一个删除按钮，当选中某个节点元素后，点击删除按钮，则将该节点及其所有子节点删除掉
 ·增加一个输入框及一个“添加”按钮当选中某个节点元素后，点击增加按钮，则在该节点下增加一个子节点，节·点内容为输入框中内容，插入在其子节点的最后一个位置
 ·提供一个按钮，显示开始遍历，点击后，以动画的形式呈现遍历的过程
 ·当前被遍历到的节点做一个特殊显示（比如不同的颜色）
 ·每隔一段时间（500ms，1s等时间自定）再遍历下一个节点
 ·增加一个输入框及一个“查询”按钮，点击按钮时，开始在树中以动画形式查找节点内容和输入框中内容一致的节点，找到后以特殊样式显示该节点，找不到的话给出找不到的提示。查询过程中的展示过程和遍历过程保持一致

 http://ife.baidu.com/2016/task/all