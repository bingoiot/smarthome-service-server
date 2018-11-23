# 通信服务环境及安装

---
一、简介
---
    通信服务提供app、设备的socket通信，使用.net core开发，同时支持linux、windows、OSX  等平台。
    支持可使用nginx、LVS、LVS+nginx等负载均衡等方式进行集群。
    每台服务器可同时运行udp、tcp两个服务 ，以应对多种网络环境。

+ 运行环境：.net core
+ 缓存:redis(3.0+)
+ 数据库：mysql或postgresql
+ (windows系统需要安装VB/VC运行库)

**注意事项：**
1. 同一局域内网，须要确保至少有一个udp服务以上的，用于跨网通信。
2. windows系统需安装vc运行库
3. 端口是固定的udp为16729(http api端口16739)，tcp为16728(http api端口16738)
4. 测试账号，初次开启服务，会生动生成100个设备mac和sn

---
二、注册获取服务SN
---
    控制台：http://console.afteriot.com
    注册登录后，添加服务器，服务器详情里可查看生成的sn。Ip变更时，SN也会相应的改变。


---
三、下载程序
---
Git地址：https://github.com/bingoiot/jifan_server.git

---
四、运行
---
1. 安装好环境，得到下载程序。更改配置文件appsettings.json里参数
2. 把注册申请的服务器ip,sn填上，数据库，缓存等配置好即可。
3. Windows:
cmd 定位到程序放置的文件夹 执行``` dotnet jifanserver.dll```
4. 或直接双击运行：windows运行服务.bat 

 ![windows 运行](https://raw.githubusercontent.com/ludycool/openfile/master/jifan_server/runcmd.png)

5. Linux: 
 命令进到程序放置的文件夹，执行 ``` dotnet ./jifanserver.dll ```

 ![Linux 运行](https://raw.githubusercontent.com/ludycool/openfile/master/jifan_server/runcmd2.png) 
---
五、windows环境搭建
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
**5.4.2、 Windows 安装postgresql 博客**
https://www.cnblogs.com/2dogslife/p/8414764.html

**5.5使用nssm安装进程守护**
如有需要，可以把程序注册 成服务，开机能自动起动。
附nssm 把程序安装成服务
https://www.cnblogs.com/emrys5/p/nssm-netcore.html

---
六、Linux环境搭建
---
**6.1安装.net core  2.1.x版本**
参照微软官网：https://www.microsoft.com/net/learn/get-started-with-dotnet-tutorial#install
 
  ![netcore下载](https://raw.githubusercontent.com/ludycool/openfile/master/jifan_server/.netcored2.png) 

先择系统后，根据提示，使用命令安装

**6.2安装 redis 3.0**
如何在Ubuntu 16.04上安装并配置Redis:
https://blog.csdn.net/zstack_org/article/details/69951845
Centos 安装redis
https://www.cnblogs.com/renzhicai/p/7773080.html
**6.3、安装 mysql或者postgresql**
Centos 下安装mysql:
https://www.cnblogs.com/silentdoer/articles/7258232.html
ubuntu 安装mysql:
https://blog.csdn.net/itxiaolong3/article/details/77905923

**6.4、使用系统服务或者supervisor 创建进程守护**
6.4.1、Linux下为使用supervisor为 dotnet 创建守护进程:
https://www.cnblogs.com/savorboard/p/dotnetcore-supervisor.html
6.4.2 创建系统服役。做进程守护：

创建服务文件
```sudo nano /etc/systemd/system/jifan-server.service```
内容：
```
[Unit]
Description=Example .NET Web API Application running on Ubuntu

[Service]
WorkingDirectory=/home/lulu/var/jifan
ExecStart=/usr/bin/dotnet  /home/lulu/var/jifan/jifanserver.dll
Restart=always
RestartSec=10 # Restart service after 10 seconds if dotnet service crashes
SyslogIdentifier=lulu-dotnet-jifanserver
User=root
Environment=ASPNETCORE_ENVIRONMENT=Production 

[Install]
WantedBy=multi-user.target
```
必须转义某些值（例如，SQL 连接字符串）以供配置提供程序读取环境变量。 使用以下命令生成适当的转义值以供在配置文件中使用：
```systemd-escape "<value-to-escape>"```
启用该服务
```systemctl enable jifan-server.service```

开启该服务，并确认它正在运行
```systemctl start jifan-server.service systemctl status jifan-server.service```















