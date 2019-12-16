---
title: 是export还是module.exports，是import还是require，是ES6还是CommonJS，是爱❤️还是责任？
date: 2019-10-12 08:09:37
categories: 学习笔记
tags: [JS填坑,填坑]
---
故事要从一次错误的编码开始。。。
<!-- more -->
# Node的模块
众所周知，在上古年代，node的开发一直被 Commonjs 规范所支配着，这也是悲剧发生的导火索，请看灾难现场：

```js
// version.js
var version = 3;
function incVersion() {
  version++;
}
module.exports = {
  version,
  incVersion,
};

// main.js
var mod = require('./version');
console.log(mod.version);  // 3
mod.incVersion();
console.log(mod.version); // 3
```
这，这一瞬间，时间的涡轮好像停止了一样，版本号变量<font color="green">*version*</font>一直停留在3永不向前，就好像我的人生那样，停滞不前，是命运的捉弄，还是人为的操控呢？

不，是值的拷贝，CommonJS 模块输出的是值的拷贝，也就是说，mod.version是一个原始类型的值，会被缓存，那么我们怎样解决这个问题呢?
```js
# 可以改写成函数
var version = 3;
function incVersion() {
  version++;
}
module.exports = {
  get version() {
    return version
  },
  incVersion,
};
```
或者用es6的import引用，那么这又是什么呢，敲黑板，画重点，要考。

# ES6 模块与 CommonJS 模块
它们有两个重大差异。

>CommonJS 模块输出的是一个值的拷贝，ES6 模块输出的是值的引用。

>CommonJS 模块是运行时加载，ES6 模块是编译时输出接口。

|       | CommonJS | ES6 | 特征 |
| :----:| :----:| :----: | :--: |
| exports | ✓ | x | 是 module.exports 的一个引用 |
| module.exports | ✓ | x | module.exports = xxx，就是导出xxx |
| export | x | ✓ | 多个 |
| export default | x | ✓ | 单个 |
| require | ✓ | ✓ | 导出的内容是module.exports的指向的内存块内容/ es6时是一个对象（{default:xxx}）|
| import | x | ✓ | 引用多个 |

```js
//无聊的冷门尝试 es6试用require
//a.js
export default 123
//main.js
const a = require('./a')
console.log('a', a) //{default: 123}

//a.js
export const a = 123
//main.js
const a = require('./a')
console.log('a', a) //{a: 123}
```
## exports 和 module.exports
在一个node执行一个文件时，会给这个文件内生成一个 exports和module对象，
而module又有一个exports属性。他们之间的关系如下图，都指向一块{}内存区域。
```js
exports = module.exports = {};
```
![](/images/module/exports.png)

## export 和 export default
首先我们讲这两个导出，下面我们讲讲它们的区别
1. <font color="pink">export</font>与<font color="pink">export default</font>均可用于导出常量、函数、文件、模块等
2. 在一个文件或模块中，<font color="pink">export</font>、<font color="pink">import</font>可以有多个，<font color="pink">export default</font>仅有一个
3. 通过<font color="pink">export</font>方式导出，在导入时要加{}，<font color="pink">export default</font>则不需要
4. <font color="pink">export</font>能直接导出变量表达式，<font color="pink">export default</font>不行。

# 天坑-循环依赖
“循环依赖”（circular dependency）指的是，a脚本的执行依赖b脚本，而b脚本的执行又依赖a脚本。
```js
// a.js
var b = require('b'); //a-step 1
module.exports.value = 'a'; //a-step 2

// b.js
var a = require('a'); //b-step 1
module.exports.value = 'b'; //b-step 2
```
一般很少会这样写，出现的话证明你的功能逻辑有耦合了，应该先分开，但是一些大型项目就很难避免，小弟不才，真的遇到过。

node的执行顺序
 >a-step 1 –> b-step 1 –> b-step 2 –> a-step 2

 当年的黑科技临时解决办法，其实不建议，就是将a中的a-step 2移到a-step 1之上。
 ```js
 // a.js
module.exports.value = 'a'; //a-step 2
var b = require('b'); //a-step 1
 ```
---
上面的其实是**Commonjs**版的，**es6**的解决方法有点不一样，具体就是将要引用的变量改成函数，因为函数具有提升作用，在加载时就已经有定义了。（ps:改成了函数表达式也不行，因为不具有提升作用）
# 最后
那么在座各位天才小儿童，肯定能想到怎样用es6解决那个灾难现场了吧，答案就是直接用
```js
//a.js
var version = 3;
function incVersion() {
  version ++;
}
export { version, incVersion }

//main.js
import { version, incVersion } from './a'
console.log( 'version', version )
incVersion()
console.log( 'version', version )
```