---
title: this/必包/作用域
date: 2021-05-02 20:23:05
categories: 知识总结
tags: [重学前端]
---

bind可以传基本类型，只会绑定一次

```js
function fn(){
  console.log(this)
}
fn.bind(1).bind(2)() // Number {1}
```
