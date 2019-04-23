FROM daocloud.io/centos:6
MAINTAINER HZZ <huangzz.xyz>
WORKDIR /root
ENV TZ="Asia/Shanghai"

COPY Script/NPC/* ./
RUN \
    set -x;ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    chmod 755 viewqr && \
    yum install -y epel-release wget && \
    yum install -y git telnet bc jq gcc perl cpan curl crontabs openssl openssl-* mysql && \
    yum clean all && \
    echo "*/5 * * * * root cd /root;bash set_crontab.sh &> set_crontab_exec.log" >> /etc/cron.d/setcrontab && \
    echo "*/5 * * * * root cd /root;bash -x set_knowledge.sh &> set_knowledge_exec.log" >> /etc/cron.d/setcrontab;
ENTRYPOINT ["bash","start_npc.sh"]