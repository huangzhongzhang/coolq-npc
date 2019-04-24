# NPC 使用说明

### ！！！腾讯已于2019年1月1日关闭WebQQ接口，该项目已停止维护。
以 Mojo-Webqq-Docker 为基础，具备 smartreply 和 openqq 等功能的 NPC。

## Mojo::Webqq项目地址:
[Mojo::Webqq](https://github.com/sjdy521/Mojo-Webqq)  
感谢[灰灰](https://github.com/sjdy521)的倾情付出。

## 包含功能

定时发送消息；

## 使用前提

需要自行安装 docker 运行环境。

## 使用步骤

### 1. 创建并运行 `cqhttp` 容器

```bash
$ docker pull richardchien/cqhttp:latest
$ mkdir coolq  # 用于存储 酷Q 的程序文件
$ docker run -d --name cqhttp \
    -v $(pwd)/coolq:/home/user/coolq \  # 将宿主目录挂载到容器内用于持久化 酷Q 的程序文件
    -p 9000:9000 \  # noVNC 端口，用于从浏览器控制 酷Q
    -p 5700:5700 \  # HTTP API 插件开放的端口
    -e COOLQ_ACCOUNT=123456 \ # 要登录的 QQ 账号，可选但建议填
    richardchien/cqhttp:latest
```

然后访问 `http://<你的IP>:9000/` 进入 noVNC（默认密码 `MAX8char`），登录 酷Q，即可开始使用（插件已自动启用，配置文件也根据启动命令的环境变量自动生成了）。一般情况下，你不太需要关注插件是如何存在于容器中的。

更多配置见：[richardchien/cqhttp](https://cqhttp.cc/docs/4.10/#/Docker)

### 2. 创建并运行 `Coolq_NPC` 容器

克隆代码后，执行以下命令：

```bash
$ bash run.sh
```

如果想要永久保留数据，将以下两个目录映射到本地即可：
`/etc/mysql`
`/var/lib/mysql`

## 3. 数据库配置

执行 run.sh 后，会自动在容器内创建数据库:

```
port：13306
database: NPC
tables: Crontab,Information
user：npc
password：QXCTyPzWEa5rBDs2

数据库用户名和密码可在 Script/Mysql/start_mysql.sh 中设置。
```

### 4. 配置定时信息发送

定时信息发送主要是实现定时向某些QQ群发送消息，以达到定时通知的功能。

`Information` 表配置示例如下：

| id | time | gnumber | gname | message | stat | comment |
| --- | --- | --- | --- | --- | --- | --- |
| 214 | "10 16 * * 1,3" | 361531XXX | 全国群 | 童鞋们，充饭卡的时间到啦！ :) | 1 | WEG |

**`Information` 表各字段含义如下：**

`id`：唯一，无实意；

`time`：发送时间，crontab 的格式；

`gnumber`：需要发送的群号码；

`gname`：需要发送的群名称；

`message`：发送的信息；

`stat`：状态：1，生效；0，失效；

`comment`：备注。



