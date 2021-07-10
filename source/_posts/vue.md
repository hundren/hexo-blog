---
title: vue核心
date: 2021-06-21 22:20:38
categories: 知识总结
tags: [重学前端]
---
### why O(n)?

严格意义不是真的O(n),复杂度其实是O(nm)

### how O(n)?

同层级比较

### 用index做key

vue: [0,1,2],[0,1] 误删
react: 会重新渲染 都是新建

### 虚拟dom过程

 虚拟 DOM

 1. 什么是虚拟 DOM

 ```js
 {
  type: 'div',
  props: {
  children: []
  },
  el: xxxx
 }
 ```

 2. 怎么创建虚拟 DOM

```js
 -> h 、createElement...
 function h(type, props) { return { type, props } }
```

3. 使用呢

```js
 JSX:
 <div>
  <ul className='padding-20'>
    <li key='li-01'>this is li 01</li>
  </ul>
 </div>
```

 经过一些工具转一下：

 ```js
 createElement('div', {
  children: [
    createElement('ul', { className: 'padding-20' },
    createElement('li', { key: 'li-01'}, 'this is li 01'))
  ]
 })
```

 4. 虚拟DOM的数据结构有了，那就是渲染了 (mount/render)

 ```js
 f(vnode) -> view

 f(vode) {
 document.createElement();
 ....

 parent.insert()
 . insertBefore
 }

 export const render = (vnode, parent) => {  }

 <div id='app'></div>
```

 5. diff 相关了(patch)

 ```js
 f(oldVnodeTree, newVnodeTree, parent) -> 调度? -> view
```
