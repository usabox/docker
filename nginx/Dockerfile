FROM nginx

RUN apt-get update --fix-missing 

# 安装 supervisor
RUN apt-get install -y supervisor openssh-server

RUN usermod -s /bin/bash root


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

EXPOSE 22 80 81 82

CMD ["/usr/bin/supervisord"]
