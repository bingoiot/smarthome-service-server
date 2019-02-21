
# 通信服务环境及安装v1.2

---
一、简介
---
    通信服务提供app、设备的socket通信，使用.net core开发，同时支持linux、windows、OSX  等平台。
    支持可使用nginx、LVS、LVS+nginx等负载均衡等方式进行集群。
    服务同时支持udp\tcp,推荐使用docker运行服务。仅仅几条指令，可直接运行服务

+ 运行环境：docker 或 .net core
+ 缓存:redis(3.0+)
+ 数据库：mysql或postgresql
+ (windows系统需要安装VB/VC运行库)

**注意事项：**
1. 服务运行前，请确保已经申请sn
2. windows系统需安装vc运行库
3. 端口是固定的udp tcp都为16729(http api端口16739)
4. 测试账号，初次开启服务，会生动生成100个设备mac和sn

---
二、注册获取服务SN
---
    控制台：http://console.afteriot.com
    注册登录后，添加服务器，服务器详情里可查看生成的sn。Ip变更时，SN也会相应的改变。


---
三、使用docker运行服务
---
1 在服务器安装好docker 设置开机启动
2本地建文件夹jifan/config    (jifan这个目录名称可随意定义)
3新建配置文件appsettings.json 放在 jifan/config 的目录中，
把注册申请的服务器ip,sn填上，数据库，缓存等配置好即可。
**文件内容如下：**
```
 {
  "mydb": { //数据库连接
    "connectionString": "Server=127.0.0.1 ;port=3306;User id=root;password=123456;Database=jifan_consumer_db;",
    "providerName": "mysql" //mysql或者Npgsql
  },
  "redisServer": [ //reids 地址与密码，集群可添加多个数组配置
    {
      "connectionString": "127.0.0.1:6379,password=123456"
    }
  ],
  "currentServerCode": "0", //局域网内 相同服务应用编号 不可重复
  "serverLocalIp": "127.0.0.1", //服务内网ip(便于集群)
  "serverIp": "111.222.33.44", //服务公网ip(请保证与申请的一至)
  "serverSn": "7EE3DC828619E5B5856D2FA911C819CA", // 服务 sn 服务公网ip(请保证与申请的一至)
  //服务类型 tcp和 udp   默认端口16729
  "myServerMaxConnectionNumber": "50000", //socket服务最大连接数
  "beaconTime": "10", //连接心跳 秒
  "checkTime": "60", // 设备登录检测时间间格 秒
  "deviceLoginTimeOut": "30", // 设备登录超时时间 分
  "receiveDataApi": {//自定义url,设备上报数据会post到指定的url
    "encode": "hex", //hex, utf-8,ascii 编码 数据会转成指定编码  hex为十六进制的字符串
    "postUrl": [ //自定义数据对接 输出。设备上报数据 服务器通过post请求，向以下url发送数据
      {
        "url": "http://www.xxxx1.com"
      },
      {
        "url": "http://www.xxxx2.com"
      }
    ]
  }
}
```
appsettings.json 配置文件 例子下载：
https://raw.githubusercontent.com/bingoiot/jifan_server/master/server/config/appsettings.json
4下载镜像
```docker pull bingoiot/jifanserver```

5运行容器
```docker run --restart unless-stopped --name myjifan -d -p 16729:16729 -p 16739:16739  -v /jifan/logfile:/myapp/logfile -v /jifan/config:/myapp/config  jifanserver:latest```

**注：**
*-v /jifan/logfile:/myapp/logfile 
-v /jifan/config:/myapp/config  :目录挂载、映射，把日志，配置文件挂载到docker中
打开jifan/logfile/info 文件夹，查看日志，发现服务已经开始运行成功！*

---
四、Linux环境运行环境搭建引导
---
**4.1 安装docker**
参考：http://www.runoob.com/docker/centos-docker-install.html
**4.2 docker部署redis,mongodb,mysql、nginx常用环境**
参考：http://www.runoob.com/docker/centos-docker-install.html
**4.3安装 redis 3.0**
如何在Ubuntu 16.04上安装并配置Redis:
https://blog.csdn.net/zstack_org/article/details/69951845
Centos 安装redis
https://www.cnblogs.com/renzhicai/p/7773080.html
**4.4、安装 mysql或者postgresql**
Centos 下安装mysql:
https://www.cnblogs.com/silentdoer/articles/7258232.html
ubuntu 安装mysql:
https://blog.csdn.net/itxiaolong3/article/details/77905923

---
五、windows环境搭建、服务安装
---

**5.1安装.net core  2.1.x版本**

第一步：进入微软官网下载页 https://www.microsoft.com/net/download
下载.net core sdk 安装默认即可。
 
  ![netcore下载](https://raw.githubusercontent.com/ludycool/openfile/master/jifan_server/.netcored.png) 

**5.2安装  微软VB/VC运行库合集(Microsoft VB/VC Runtime Library)**
下载：http://down7.pc6.com/xy3/VBVCRedist.zip
或者https://raw.githubusercontent.com/bingoiot/jifan_tool/master/VBVCRedist/VBVCRedist_x64.exe
*安装时，功能全选即可*


**5.3安装 redis 3.0**
下载连接：https://raw.githubusercontent.com/bingoiot/jifan_tool/master/redis/Redis-x64-3.2.100.msi
下载安装即可
附：Windows 安装redis  修改密码等操作：http://www.cnblogs.com/jaign/articles/7920588.html
注意事项：
*配置文件里，配置密码   requirepass  xxxx 时，requirepass这面不能有空格。这是个坑。*

**5.4安装 mysql或者postgresql**
5.4.1、 windows安装mysql博客：
https://blog.csdn.net/wdx1121/article/details/79523254
或
https://www.cnblogs.com/xsmile/p/7753984.html
需要配置密码
**5.4.2、 Windows 安装postgresql**
https://www.cnblogs.com/2dogslife/p/8414764.html

**5.5下载程序**
Git地址：https://github.com/bingoiot/jifan_server.git

**5.6运行服务**
1.安装好环境，下载得到程序。更改配置文件appsettings.json里参数
2.把注册申请的服务器ip,sn填上，数据库，缓存等配置好即可。
3.使用cmd cd定位到程序放置的文件夹 执行``` dotnet jifanserver.dll```
4.或直接双击运行：windows运行服务.bat 
 ![windows 运行](https://raw.githubusercontent.com/ludycool/openfile/master/jifan_server/runcmd.png)

**5.5使用nssm安装进程守护**
如有需要，可以把程序注册 成服务，开机能自动起动。
附nssm 把程序安装成服务
https://www.cnblogs.com/emrys5/p/nssm-netcore.html




















