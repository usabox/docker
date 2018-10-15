#from centos:7

FROM php:7-cli

RUN apt-get update --fix-missing \
    && apt-get upgrade -y
# 安装 supervisor
RUN apt-get install -y supervisor openssh-server

RUN apt-get install -y wget unzip git
#
#RUN wget https://mirrors.tuna.tsinghua.edu.cn/epel/epel-release-latest-7.noarch.rpm \
#    && rpm -ivh epel-release-latest-7.noarch.rpm
#
#RUN yum install supervisor openssh-server unzip bind-utils -y


#centos 安装 ssh

#ADD id_rsa /tmp/id_rsa
#ADD id_rsa.pub /tmp/id_rsa.pub
#
#RUN mkdir /root/.ssh
#
#RUN cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys \
#        && cat /tmp/id_rsa.pub >> /root/.ssh/id_rsa.pub \
#        && cat /tmp/id_rsa >> /root/.ssh/id_rsa
#
#RUN rm -f /tmp/id_rsa* \
#        && chmod 644 /root/.ssh/authorized_keys /root/.ssh/id_rsa.pub \
#        && chmod 400 /root/.ssh/id_rsa
#
#RUN /usr/sbin/sshd-keygen



#ubuntu 安装ssh




ADD id_rsa /tmp/id_rsa
ADD id_rsa.pub /tmp/id_rsa.pub

RUN mkdir /root/.ssh

RUN cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys \
        && cat /tmp/id_rsa.pub >> /root/.ssh/id_rsa.pub \
        && cat /tmp/id_rsa >> /root/.ssh/id_rsa

RUN rm -f /tmp/id_rsa* \
        && chmod 644 /root/.ssh/authorized_keys /root/.ssh/id_rsa.pub \
        && chmod 400 /root/.ssh/id_rsa


RUN mkdir /var/run/sshd


#安装 consul
RUN cd ~ &&  wget https://releases.hashicorp.com/consul/1.2.2/consul_1.2.2_linux_amd64.zip \
    && unzip consul_1.2.2_linux_amd64.zip


RUN mv ~/consul /usr/bin


# ubuntu 路径 /etc/supervisor/supervisord.conf

RUN sed -i '/\[supervisord\]/a\nodaemon=true' /etc/supervisor/supervisord.conf \
&& sed -i "s/#UseDNS yes/UseDNS no/g" /etc/ssh/sshd_config

# centos 路径 /etc/supervisord.conf
#RUN sed -i "s/nodaemon=false/nodaemon=true/g" /etc/supervisord.conf \
#    && sed -i "s/#UseDNS yes/UseDNS no/g" /etc/ssh/sshd_config

RUN cat /etc/supervisor/supervisord.conf

RUN git clone https://gitee.com/swoole/swoole.git swoole

RUN apt-get install libssl-dev -y



RUN cd swoole \
    && phpize \
    && ./configure --enable-openssl \
    && make \
    && make install \
    && cd .. \
    && docker-php-ext-enable swoole

RUN git clone https://github.com/phpredis/phpredis \
    && cd phpredis/ \
    && phpize \
    && ./configure \
    && make && make install \
    && cd .. \
    && docker-php-ext-enable redis

EXPOSE 22 9000


CMD ["/usr/bin/supervisord"]