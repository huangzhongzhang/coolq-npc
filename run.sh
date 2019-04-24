#!/usr/bin/env bash
set -ex;

# 构建镜像
cd ./Dockerfile/;
docker build -t hzz1989/coolq_npc -f NPC.Dockerfile ../;
docker image prune -f;
cd -;

# 运行NPC容器
# 如果想要永久保留数据，需添加以下参数：
# -v /etc/mysql:/etc/mysql
# -v /var/lib/mysql:/var/lib/mysql
docker run -d --name Coolq_NPC \
-p 3306:3306 \
hzz1989/coolq_npc;

# 查看日志
#docker logs --tail 100 --follow Coolq_NPC;