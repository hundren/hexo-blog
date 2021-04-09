---
title: Github Actions, yes! + docker, yes yes!
date: 2020-01-18 14:09:37
categories: 学习笔记
tags: [部署,Linux]
---
最近点开了一下Github Actions的技能树，在说真香之前，不得不说一下我踩过的这些前置任务的坑。找到这篇文章看的朋友大概也知道Github Actions是Github上的持续集成服务，它允许你在一些节点上（如提交代码，特定时间等）触发一些操作。这里我们实现自动部署应用到自己的服务器。
![](/images/gitactions/bg2019091201.jpg)
***

## 首先要买一台服务器

过程略。。。

## 建立仓库

有细心看标题的朋友，应该知道我们是在<code>Github</code>（世界最大同性交友网站）上玩的
![](/images/gitactions/ci.png)
在你的项目里面建一个.github文件夹（注意有一点.），然后再建一个workflows文件夹，里面再新建一个后缀为yml的文件（名字任意），完成以上步骤你大概就完成50%的工作量了。

```bash
# ci.yml
name: deploy to aliyun
on:
  push:
    branches:
      - master
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      # 切换分支
      - name: Checkout
        uses: actions/checkout@master
      # 使用 node:10
      - name: use Node.js 10
        uses: actions/setup-node@v1
        with:
          node-version: 10
      # npm install
      - name: npm install and build
        run: |
          yarn install
          npm run build
        env:
          CI: true
      # Deploy
      - name: FTP-Deploy
        uses: SamKirkland/FTP-Deploy-Action@2.0.0
        env:
          FTP_SERVER: ${{ secrets.REMOTE_HOST }}
          FTP_USERNAME: ${{ secrets.REMOTE_USER }}
          FTP_PASSWORD: ${{ secrets.REMOTE_PWD }}
          LOCAL_DIR: build
          METHOD: sftp
          REMOTE_DIR: /home/www
          ARGS: --delete
      - name: Docker-deploy
        uses: appleboy/ssh-action@master
        with:
          host: ${{ secrets.REMOTE_HOST }}
          username: ${{ secrets.REMOTE_USER }}
          key: ${{ secrets.ACCESS_TOKEN }}
          script: |
            docker exec 你的docker容器名称 rm -rf /usr/share/nginx/html
            docker cp /home/www 你的docker容器名称:/usr/share/nginx/html
```

展示一下我的终极配置，当然事情的发展没有这么简单

### 配置详情

git actions的奥妙之处就在于它有丰富的插件资源可以使用
![](/images/gitactions/actions-market.png)
对于我们部署而言，前3个资源一般来说也是没问题的，最大的问题就在于发布，毕竟要和服务器打交道
>踩过的坑如下

我之前发布用的模块是这个

```bash
# Deploy
      - name: Deploy
        uses: easingthemes/ssh-deploy@v2.0.7
        env:
          SSH_PRIVATE_KEY: ${{ secrets.ACCESS_TOKEN }}
          ARGS: "-avz --delete"
          SOURCE: "build/"
          REMOTE_HOST: ${{ secrets.REMOTE_HOST }}
          REMOTE_USER: ${{ secrets.REMOTE_USER }}
          TARGET: ${{ secrets.TARGET }}
```

<font color="green">哦，对，大家看到这些secrets的变量是不是很奇怪，其实是为了隐私安全问题，在github项目上Settings里Secrets上添加就好了</font>

然后一直报这个错😢
![](/images/gitactions/error.png)
服务器上什么的<code>ssh</code>都设置好了，在本地上

```bash
ssh -i id_rsa root@xxx.xxx.xxx.x
```

用私密登录也是正常的，用其它ssh登录的actions也可以用，事情发展到不可开交的地步，战事一触即发，幸好我们还有其它别人写好的actions可以用，后来换上<code>FTP-Deploy-Action</code>，心情就变得愉快了，妈妈再也不用担心我写代码了

### docker容器

如果没有用到docker的话，文章写到这里就可以结束了，把你的项目发布上了服务器，nginx配置指定一下域名和路径你就成功上岸了

<font color="red">那什么是docker？</font>
<div style="float:left;margin-right:20px"><img width="360" src="/images/gitactions/docker.png"></div>
<div style="float:left"><img  width="360" src="/images/gitactions/virtual.png"></div>
<div style="float:none;clear:both;">
</div>
遇事不决先上图

小弟不才，说说自己的见解，看图就很容易看出docker和虚拟机的最大区别，说人话就是，首先要说出docker里的容器和镜像的概念，容器就是根据你需要的镜像启动的，比如你有一个centos系统镜像，传统的虚拟机就是每个虚拟机上都用这个镜像往里面装一次，而docker就用这个镜像启动就可以了，这就生成了一个容器，而容器之间是独立的，这样就能做到资源的复用，扯远了。

```bash
//我也是用的别人的nginx镜像，简单记录一下
docker pull nginx:latest
docker run --name nginx-test -p 80:80 -d nginx
```

那细心的朋友也发现，我最后的那个actions的配置其实就是一些ssh命令

```bash
docker exec 你的docker容器名称 rm -rf /usr/share/nginx/html
docker cp /home/www 你的docker容器名称:/usr/share/nginx/html
```

1、第一个就是先删除容器里的之前的项目，但也踩过坑，<code>docker exec</code>这个就是进入容器的命令了，之前我写的是<code>docker exec -it xxx /bin/bash</code>进去再<code>rm -rf</code>然后<code>exit</code>这样的，想法很美滋滋，但是ci命令上就报<code>err: the input device is not a TTY</code>后来才换成现在的命令
2、第二个就是把发上服务器的项目复制到容器里

## 开发应用

过程也略。。。（到目前为止，如无意外的话，你只要push一下代码，就会进入到我们设置好的“陷阱”里，一顿自动操作执行下来，你的网站就部署上去了）

## 优化与改进（先挖好个坑）

### 自动发布到容器里（方案一）

1、将容器的sftp端口映射到服务器的某个端口上
2、在ftp actions里配置好对应的端口上传上去

### 用dockerFile自制镜像 （方案二）

1、ci.yml里面就是执行自制的docker镜像run一下
2、镜像逻辑大概如下：拉取最新代码到容器->打包项目->覆盖项目上的自定义nginx配置文件到容器nginx的默认路径

参考文档：

>[GitHub Actions 入门教程 - 阮一峰](http://www.ruanyifeng.com/blog/2019/09/getting-started-with-github-actions.html)<br>[使用GithubActions自动部署应用到自己的服务器（ECS）](https://www.kai666666.top/2020/01/04/%E4%BD%BF%E7%94%A8GithubActions%E8%87%AA%E5%8A%A8%E9%83%A8%E7%BD%B2%E5%BA%94%E7%94%A8%E5%88%B0%E8%87%AA%E5%B7%B1%E7%9A%84%E6%9C%8D%E5%8A%A1%E5%99%A8%EF%BC%88ECS%EF%BC%89/)
