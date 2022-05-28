---
title: 使用hooks的一些小感想
date: 2022-01-14 22:24:37
categories: 知识总结
tags: 文章
---

>这里文章说的都是hooks<sup>react</sup>

### 那什么是hooks

故名思义 `Hooks` 译为钩子，`Hooks` 就是在函数组件内，负责钩进外部功能的函数。

(说了又好像没说)

### 有什么爽的👌

* 函数组件原地飞升
* 不用管this了
* 生命周期也不用记那么多了

开始结束的生命周期可以写在一起，代码更漂亮了

``` js
useEffect(()=>{
  console.log('开波')
  return ()=>{
    console.log('结束')
  }
},[])
// ps.空数组就是只进入一次
```

props的值的变化，xx值的变化都能放在一起监听

```js
useEffect(()=>{
  console.log('无论是数组还是对象，数据多深都能进（后来才发现也不是多深都能啦），这不比vue的watch爽？')
  // 那么useEffect是怎样监听数据变化的呢
  // 它和useLayoutEffect又有什么区别呢
  // 这要从hooks的基础概念链表说起，请往下看
},[props.a,b])
```

通过看useEffect的源码，我们不难发现

```js
// 通过看源码我们得知

 for (let i = 0; i < prevDeps.length && i < nextDeps.length; i++) {
    if (is(nextDeps[i], prevDeps[i])) {
      continue;
    }
    return false;
  }
// 我们知道它的对比方法是
// 其中里面的is是这个
import is from 'shared/objectIs';
function is(x: any, y: any) {
  return (
    (x === y && (x !== 0 || 1 / x === 1 / y)) || (x !== x && y !== y) // eslint-disable-line no-self-compare
  );
}

const objectIs: (x: any, y: any) => boolean =
  typeof Object.is === 'function' ? Object.is : is;

export default objectIs;
```

所以其实它就是用`Object.is`做比较

>有需要做深比较的可以用`ahooks`的`useDeepCompareEffect`，用法与 useEffect 一致，但 deps 通过 lodash 的`isEqual`进行深比较。

* 代码复用更高

### 吐槽一下

#### 闭包陷阱

```js
import {useEffect, useState} from 'react'

export default function App() {
  const [count, setCount] = useState(0)
  useEffect(()=>{
    setInterval(() => {
      setCount(count + 1)
    }, 1000);
  }, [])
  return (
       <p>count={count}</p>
  );
}
```

大家可能会一直期待着数字的变化，但它就偏不，一直保持着1

事情为什么会发展成这样，那就要从底层的渲染开始说起

>初次渲染->执行APP->usestate设置count为初始0->1秒后state改变->视图更新->按照fiber链表执行hooks->useEffect deps 不变->然后1秒后的count始终都是0+1

解决办法：

```js
// 有细心的网友可能会发现，网上其他地方可能会建议在useEffect的deps上加上count
useEffect(()=>{
  setInterval(() => {
    setCount(count + 1)
  }, 1000);
}, [count])
// 这样确实能拿到最新的count
// ❌但是这里喔不建议这样写
// 因为你想想，每次count的更新它都会重新进去建一个新的定时器
// 以后画面就会很鬼畜
```

建议版本方法

```js
useEffect(()=>{
  setInterval(() => {
    setCount(res=>(res+1))
  }, 1000);
}, [])
// setCount本身可以传方法，本来就是最新的值
```

高级版本ref大法

```js
//简单来说就是利用useRef返回的是同一个对象，指向同一片内存
let ref_ = useRef(1)
ref_.current++
useEffect(()=>{
  setInterval(()=>{
  console.log(ref.current) // 3
  }, 1000)
})
```

#### 不能用判断或者随机函数

举个🌰

```js
if (Math.random() > 0.5) {
  useState('first')
} 
let showSex = true
if(showSex){
    const [ sex, setSex ] = useState('男');
    showSex = false;
}
```

以上的行为都是打咩的

原因是hooks的数据管理是用链表管理的，所以数据不能一时有一时没

举个不太恰当的例子，就像

>* 数组[0]代表useState('A')
>* 数组[1]代表useState('B)
>* 现在你突然把'A'删掉了，那就变成数组[0]代表useState('B')了
>* 那么你就不是你了，他也不是他了

#### useCallBack 还是 useMemo

仅仅 `依赖数据` 发生变化, 才会重新计算结果，说是为了性能优化，起到缓存的作用，

这里说一个面试常问的`useCallBack` 和 `useMemo` 有什么区别？

网上各种解析长篇大论的，一句话其实就是

>useCallback 缓存钩子函数，useMemo 缓存返回值（计算结果）[当然useMemo也可以传入函数]。

这个时候，有好奇宝贝就会问了,那用这个会多那么多代码量，有什么用呢

答案是：性能优化，这里就要涉及到更深层的react的渲染原理了，"比较更新！！",react每次渲染的时候，它都把值和函数重新计算渲染，这里就会消耗点内存了，用上那2玩意，其实就是告诉react，我们没有变化，帮我存起来，不用再比较了

那么有些姓杠的小朋友，这时候就不耐烦了，站起来问道：为什么react不帮我们自动做这些优化呢，我就想静静地写代码，为什么还要考虑该不该包个`useCallBack`

问得好，这里顺便@一下官方团队，希望相关单位能密切关注这个问题

还会有些害羞的小朋友会嘀咕着，为什么class组件的时候就不需要注意这些呢

个人鄙见：新旧版本的渲染方法其实差不多的，我觉得前端深入研究性能优化是没有前途的，框架或者浏览器，一次小小的版本更新，可能效果就远远胜过了你多少个日日夜夜的辛勤付出了。

### 总结

hooks需好，但要小心使用
