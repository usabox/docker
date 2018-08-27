from centos:7

RUN yum install wget -y

RUN wget https://mirrors.tuna.tsinghua.edu.cn/epel/epel-release-latest-7.noarch.rpm \
    && rpm -ivh epel-release-latest-7.noarch.rpm

RUN yum install supervisor openssh-server unzip -y


ADD id_rsa /tmp/id_rsa
ADD id_rsa.pub /tmp/id_rsa.pub

RUN mkdir /root/.ssh

RUN cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys \
        && cat /tmp/id_rsa.pub >> /root/.ssh/id_rsa.pub \
        && cat /tmp/id_rsa >> /root/.ssh/id_rsa

RUN rm -f /tmp/id_rsa* \
        && chmod 644 /root/.ssh/authorized_keys /root/.ssh/id_rsa.pub \
        && chmod 400 /root/.ssh/id_rsa

RUN /usr/sbin/sshd-keygen


#安装 consul
RUN cd ~ &&  wget https://releases.hashicorp.com/consul/1.2.2/consul_1.2.2_linux_amd64.zip \
    && unzip consul_1.2.2_linux_amd64.zip


RUN mv ~/consul /usr/bin


RUN sed -i "s/nodaemon=false/nodaemon=true/g" /etc/supervisord.conf \
    && sed -i "s/#UseDNS yes/UseDNS no/g" /etc/ssh/sshd_config

EXPOSE 22 9000

CMD ["/usr/bin/supervisord"]