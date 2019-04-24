#!/usr/bin/env bash
# qq群信息发送

cd $(dirname $0)
echo -e "\n$(date)\n";

# 发送的群名称
Gnumber=${1}

# coolq中定义的host和port
API_ADDR=127.0.0.1
API_PORT=5700

if echo 'a'|telnet -e a $API_ADDR $API_PORT &> /dev/null
then
    # 处理 message 格式
    message=$(echo -e "${2}"|od -t x1 -A n -v -w10000 | tr " " %)

    # 发送信息
    api_url="htt://$API_ADDR:$API_PORT/send_group_msg_async?group_id=${Gnumber}&message=${message}"
    set -x
    curl $api_url
    set +x
else
    echo -e "\nOPEN-QQ服务未启动，跳过信息发送！\n"
fi
