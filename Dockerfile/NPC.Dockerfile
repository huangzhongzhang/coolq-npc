FROM daocloud.io/centos:6
MAINTAINER HZZ <www.huangzz.xyz>
WORKDIR /root
ENV TZ=Asia/Shanghai

COPY Script/* ./
RUN \
    set -x;ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    yum install -y epel-release wget && \
    yum install -y git telnet bc jq gcc perl cpan curl crontabs openssl openssl-* mysql-server mysql && \
    yum clean all && \
    echo "*/5 * * * * root cd /root;bash set_crontab.sh &> set_crontab_exec.log" >> /etc/cron.d/setcrontab;
VOLUME ["/etc/mysql", "/var/lib/mysql"]
EXPOSE 3306
ENTRYPOINT ["bash","start_npc.sh"]


