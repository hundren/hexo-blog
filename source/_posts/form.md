---
title: 写前端就是写表单？
date: 2021-01-14 08:40:37
categories: 知识总结
tags: [架构]
---
首先，大家思考一下表单是什么？前端又是什么？
<!-- more -->
***

## 表单是什么？

小弟不才，曾有幸参与`某中台的表单引擎`的开发工作，一般开发前我们都是先用`领域设计模型`分析一波，时间的关系，先上图
![](/images/form/form.png)

用现在流行的`八卦文`翻译一下就是要先找出业务的聚合根，再分析它的属性，然后再总结它的生命周期
最后我们得出的结论是：
写前端<font size="24" color="red">不</font>等于写表单
**本文终。**
![](/images/form/stop.jpeg)

## 前端是什么？

>那写前端到底是写什么？
>本人才疏学浅
>我认为人机需要交互的地方都属于前端
>包括但不限于全息控制、人脑控制、声音控制、AR、VR
>所以说要立志要做大前端的那位
>你们以后的css样式可能还要加上声音/气味属性了

```css
.flower:{
  color: yellow;
  sound: quiet;
  smell: sweet;
}
```

## 我设计的表单

但相信大家都同意的是，表单开发在日常的开发中，应该是最复杂，占用的时间应该是最多的
我先来随便说几点：

- 动态表单生成
- 多级联动
- 动态校验
- 定制业务组件
- 嵌套子级表单
- 数据反显
- 编辑状态禁用
- 等等

某知名博文《写前端就是写表单？》的博主曾经说过：“控制最小边界，组合，就是好架构”
所以我们先设计一个最小的表单

### 最小的表单

1.要有一个`<form></form>`
2.要有一个`formData`
3.要有一个`控件配置表`

### 配置表

> 建一个form-register.ts 的文件

ts, 是的我加了ts
就是将所有组件import进来 再export出去
规范点的话还能用require.context动态引入

```js
import Text from './Text/index.vue'
//类型
export  formConfigs:formTypes= {
  text: Text
}
```

眼利的朋友应该发现有一个formTypes

```js
//组件的class很强大，可以直接作为类型
export interface formTypes {
  Text?: Text
}
```

那还有一个最关键的别人调用的配置项是长怎样的呢，以下是我的参考，具体可以根据自己业务需要自行添加

```js
export interface fieldType {
  fieldType: keyof formTypes
  key: string
  dict?: string
  type?: string
  name?: string
  label?: string
  placeholder?: string
  required?: boolean
  isShow?: Function //是否显示
  dateType?: 'date' | 'time' | 'year-month' | 'month-day' | 'datetime'
  readonly?: boolean
  rules?: rule[]
  isWrap?: boolean
  hiddenLabel? :boolean
  extraKey?: string | extraKeyType[]
  formDataFormatter?: Function //格式化函数
  formDataConvert?: Function // 转换成多个其他值
  propShowValue?:string //显示的字段
  handleChange?: Function
  [k: string]: any
}
```

大家发现会有一个`[k: string]: any`，需然牺牲了一些类型约束，但是换来的扩展自由也是很有价值的

### 组合

>加入了一个动态组件渲染

```js
<form>
  <template v-for="fieldItem in fieldList">
    <component
      :key="fieldItem.key"
      :is="formRegister[fieldItem.fieldType]"
      :fieldItem="fieldItem"
      v-bind="fieldItem"
      v-model="formData[fieldItem.key]"
    ></component>
  </template>
</form>
```

>这里用到`v-bind`把所有属性props进去，react的话可以自己解构`...props`
到这里如无意外的话，你的表单组件应该渲染出来了
但有人可能就会问，也不是杠什么的，你的`fieldList`是怎样来的

### 函数生成器

当初设计的时候第一直觉，就是props一个`fieldList`的数组进来
但后来遇到一些问题

- 组件之间联动
- 数据值强绑定
- 表单项动态生成
- 校验规则条件动态变化
- 等
可能都要监听`formData`值的变化，再改变`fieldList`的值

> 后来，某天发呆的时候，想到《上帝掷骰子吗》一书中，对多宇宙的一个解说是，`每个世界线的变动都会再产生出一个新宇宙`

好家伙，那我们为什么不能写一个多宇宙的表单组件呢？`每次formData值的变动就再产生出一个新的fieldList`
**fieldListMaker诞生**
我马上改成如下：

```js
  get formDataString() {
    return JSON.stringify(this.formData)
  }
  @Watch('formDataString', { immediate: true, deep: false })
  formDataChanged(val: any, oldVal: any) {
    if (val !== oldVal) {
      this.fieldList = this.fieldListMaker(val)
    }
  }
```

传入的时候fieldListMaker长这样

```js
fieldListMaker(formData: any): Array<fieldType> {
    // 你在这里可以做你想做的各种东西😊
    return [
      {
        fieldType: 'text',
        key: 'abc',
        label: 'def'
      }
    ]
}
```

## 总结

实际使用就是

```js
import FormList from '@/components/form/index.vue'
<FormList
    ref="formRef"
    :fieldListMaker="fieldListMaker"
    :showBtn="false"
    @change="handleFormChange"
  />
```

大家可以根据各自喜好，在里面添加一些方法，如：

1. 校验方法
2. 设置属性值方法
3. 清空校验方法
4. 强制更新list方法
5. 等
各种业务表单组件也可以自己添加，只要约定好一些基本方法，里面@Model('change')出来一个双向绑定就好了
**真.完结,撒花**

>彩蛋

有兴趣的可以看源代码[多宇宙表单](https://github.com/hundren/multiverse-form "代码地址")
