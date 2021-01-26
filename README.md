> 项目演示地址：[http://gym.liujian.cool](http://gym.liujian.cool)
>
> 项目gitHub源码地址：[https://github.com/liujianview/gymxmjpa](https://github.com/liujianview/gymxmjpa)
>
> 项目gitee源码地址：[https://gitee.com/liuchuanfengview/gymxmjpa](https://gitee.com/liuchuanfengview/gymxmjpa)
>
> 欢迎给个star鼓励一下~

## 一.前言

这次分享的项目是我的毕业设计：基于SpringBoot的健身房管理系统。这是我在GitHub上开源的第二个项目（第一个是我的个人博客网站：[http://liujian.cool](http://liujian.cool) ） 本系统用了 Sping Data JPA 这一不常用的数据库框架，是一个值得学习研究的点。

本项目演示地址为 [http://gym.liujian.cool](http://gym.liujian.cool)  用户名：admin 密码: admin123  方可进入。项目源码在文章开头，下载到本地导入IDEA，修改配置文件中数据库连接信息后，导入项目附带数据库的SQL文件生成所有表结构，就可以本地启动了，用户名密码同上。

## 二.系统总体设计

### 1.设计结构

#### 系统层次结构图如下：

![image-20210125203309103](https://img-blog.csdnimg.cn/img_convert/990c3343746b222872d041334d8d1cb9.png)

#### 主要功能如下：

- 管理员登录模块
- 会员管理模块
- 教练管理模块
- 课程管理模块
- 器材管理模块
- 物品遗失管理模块
- 商品管理模块
- 信息统计模块

### 2.涉及技术框架：

1. web框架：SpringBoot
2. 数据库框架：Sping Data JPA
3. 数据库：MySql
4. 项目构建工具：Maven
5. 前端模板：JSP
6. 安全框架：Shiro
7. 前端框架：BootStrap,Layui
8. 数据图表：ECharts

### 3.本项目所用环境：

1. 开发工具：IDEA
2. 编程语言：JDK1.8,HTML,CSS,JS，jQuery
3. 数据库：mysql5.6
4. 部署服务器：腾讯云Centos7

## 三.系统主要页面展示

### 登录界面

![image-20210125204622368](https://img-blog.csdnimg.cn/img_convert/da5d76a1ede727f01502886b56ddfb38.png)

### 数据统计界面

![image-20210125204723157](https://img-blog.csdnimg.cn/img_convert/372a2ba7ebce12d48cce9088eeb054a4.png)

### 会员列表界面

![image-20210125204804256](https://img-blog.csdnimg.cn/img_convert/9d7f61a0d92d5687fc7c27f2a9370cc1.png)

### 会员私教课程界面

![image-20210125204905369](https://img-blog.csdnimg.cn/img_convert/befa00e056959117974ec2eef8681c21.png)

### 物品遗失归还界面

![image-20210125205005148](https://img-blog.csdnimg.cn/img_convert/f96c6344c6bfd7c1d2e76e39d1d33a6b.png)

### 商品列表界面

![image-20210125205100971](https://img-blog.csdnimg.cn/img_convert/bf7a74da109829fe505356369a1550fe.png)

## 四.总结

本次分享的 健身房管理系统 功能还是很全的，页面也比较精美，适合刚接触SpringBoot和Spring Data JPA 框架的初学者做练手项目，项目中的图表功能：ECharts 也可以好好学习学习~

&emsp;更多精彩功能请关注我的个人博客网站：[http://liujian.cool](http://liujian.cool)

&emsp;&emsp;欢迎关注我的个人公众号：程序猿刘川枫
&emsp;&emsp;![](https://img-blog.csdnimg.cn/img_convert/1944436507a30c7c8541bcc5e4b75969.png)
