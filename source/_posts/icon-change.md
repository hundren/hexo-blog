---
title: 怎样更改组件库的图标？
date: 2019-03-14 23:09:37
categories: 学习笔记
tags: [填坑]
---
想必很多前端现在都是用别人的组件库，ant-design、element-ui或者vant等，那么当组件上的icon和我们美丽动人的UI小姐姐画出的UI稿不一样的时候，你们会怎么做呢？
<!-- more -->
## 组件api替换大法
1、组件本身提供api给你更换icon，换之则可
2、但每次使用都要替换也是挺麻烦的，可以尝试先封装一下，使用高阶组件

>可行性高，操作容易、略麻烦

## 源码copy大法
1、不使用传统的npm install的包安装方法
2、将组件库的源码copy下来单独一个文件
3、修改源码组件对应的图标
4、或者自己建立一个私有的npm库将整个组件库推上去

>1、一次操作到位
>2、但是组件库版本滞后

## webpack修改大法
以ant-design为例子
### webpack上的resolve路径
``` bash
  resolve: {
    extensions: ['.ts', '.tsx', '.js', '.jsx', '.less', '.css', '.json'],
    alias: {
      '@src': path.resolve(__dirname, '../', './src'),
      '@package': path.resolve(__dirname, '../', 'src', 'package'),
      '@libs': path.resolve(__dirname, '../', 'src', 'libs'),
      '@assets': path.resolve(__dirname, '../', 'src', 'assets'),
      '@ant-design/icons/lib/dist$': path.resolve(__dirname, '../', 'src', 'icon.js'),
      'vue': 'vue/dist/vue.esm.js',
    }
  }
```
主要就是改变这个打包路径 '@ant-design/icons/lib/dist$'

### icon.js的文件
``` bash

export {
  default as CloseOutline
} from '@libs/components/icons/CloseOutline'
export {
  default as CheckOutline
} from '@ant-design/icons/lib/outline/CheckOutline'
export {
  default as LoadingOutline
} from '@ant-design/icons/lib/outline/LoadingOutline'
export {
  default as CheckCircleOutline
} from '@ant-design/icons/lib/outline/CheckCircleOutline'
export {
  default as InfoCircleOutline
} from '@ant-design/icons/lib/outline/InfoCircleOutline'
export {
  default as CloseCircleOutline
} from '@ant-design/icons/lib/outline/CloseCircleOutline'
export {
  default as ExclamationCircleOutline
} from '@ant-design/icons/lib/outline/ExclamationCircleOutline'
export {
  default as CheckCircleFill
} from '@ant-design/icons/lib/fill/CheckCircleFill'
export {
  default as InfoCircleFill
} from '@ant-design/icons/lib/fill/InfoCircleFill'
export {
  default as CloseCircleFill
} from '@ant-design/icons/lib/fill/CloseCircleFill'
export {
  default as ExclamationCircleFill
} from '@ant-design/icons/lib/fill/ExclamationCircleFill'
export { default as UpOutline } from '@ant-design/icons/lib/outline/UpOutline'
export {
  default as DownOutline
} from '@ant-design/icons/lib/outline/DownOutline'
export {
  default as LeftOutline
} from '@ant-design/icons/lib/outline/LeftOutline'
export {
  default as RightOutline
} from '@ant-design/icons/lib/outline/RightOutline'
export {
  default as RedoOutline
} from '@ant-design/icons/lib/outline/RedoOutline'
export {
  default as CalendarOutline
} from '@ant-design/icons/lib/outline/CalendarOutline'
export {
  default as SearchOutline
} from '@ant-design/icons/lib/outline/SearchOutline'
export {
  default as BarsOutline
} from '@ant-design/icons/lib/outline/BarsOutline'
export {
  default as StarFill
} from '@ant-design/icons/lib/fill/StarFill'
export {
  default as FilterOutline
} from '@ant-design/icons/lib/outline/FilterOutline'
export {
  default as CaretUpFill
} from '@ant-design/icons/lib/fill/CaretUpFill'
export {
  default as CaretDownFill
} from '@ant-design/icons/lib/fill/CaretDownFill'
export {
  default as CaretUpOutline
} from '@ant-design/icons/lib/outline/CaretUpOutline'
export {
  default as CaretDownOutline
} from '@ant-design/icons/lib/outline/CaretDownOutline'
export {
  default as PlusOutline
} from '@ant-design/icons/lib/outline/PlusOutline'
export {
  default as FileOutline
} from '@ant-design/icons/lib/outline/FileOutline'
export {
  default as FolderOpenOutline
} from '@ant-design/icons/lib/outline/FolderOpenOutline'
export {
  default as FolderOutline
} from '@ant-design/icons/lib/outline/FolderOutline'
export {
  default as PaperClipOutline
} from '@ant-design/icons/lib/outline/PaperClipOutline'
export {
  default as PictureOutline
} from '@ant-design/icons/lib/outline/PictureOutline'
export {
  default as EyeOutline
} from '@ant-design/icons/lib/outline/EyeOutline'
export {
  default as DeleteOutline
} from '@ant-design/icons/lib/outline/DeleteOutline'

```
就是将你需要更改的图标的地址改为你本地的
而且这里可以只引入一些你需要的图标，会减少一些icon库的打包大小

### 本地的图标
```bash
"use strict"
Object.defineProperty(exports, "__esModule", { value: true })
var CloseOutline = {
  name: 'close',
  theme: 'outline',
  icon: {
    tag: 'svg',
    attrs: { version: '1.0', viewBox: '0 0 16 16', focusable: false },
    children: [
      {
        tag: 'path',
        attrs: {
          'fill-rule': 'evenodd',
          d: 'M10.17 7.72l5.63-5.67a.63.63 0 000-.9l-.86-.91a.63.63 0 00-.91 0L8.35 5.9a.42.42 0 01-.61 0L2.06.2a.63.63 0 00-.91 0l-.91.9a.63.63 0 000 .91l5.68 5.67c.17.17.17.43 0 .6L.2 13.98a.63.63 0 000 .92l.9.9c.27.26.66.26.92 0l5.68-5.66a.42.42 0 01.6 0l5.68 5.67c.26.25.65.25.91 0l.91-.91a.63.63 0 000-.91l-5.63-5.67a.42.42 0 010-.6'
        }
      }
    ]
  }
}
exports.default = CloseOutline
```
使用ant-design-icons的库做转换
[https://github.com/ant-design/ant-design-icons](https://github.com/ant-design/ant-design-icons)

---

## 总结
各有利弊,欢迎补充