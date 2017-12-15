from centos

RUN yum update -y

RUN yum install -y openssh-server openssh-clients  vim net-tools vim

# 安装 supervisor
RUN yum install -y epel-release\
    && yum install -y python-pip \
    && pip install --upgrade pip\
    && pip install supervisor

RUN sed -i "s/HostKey\ \/etc\/ssh\/ssh_host_ecdsa_key/#HostKey\ \/etc\/ssh\/ssh_host_ecdsa_key/g" /etc/ssh/sshd_config
RUN sed -i "s/HostKey\ \/etc\/ssh\/ssh_host_ed25519_key/#HostKey\ \/etc\/ssh\/ssh_host_ed25519_key/g" /etc/ssh/sshd_config
RUN sed -i "s/#PermitRootLogin\ yes/PermitRootLogin\ yes/" /etc/ssh/sshd_config
RUN sed -i "s/UsePAM\ yes/UsePAM\ no/" /etc/ssh/sshd_config
RUN sed -i "s/#UseDNS\ yes/UseDNS\ no/" /etc/ssh/sshd_config

RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key

#COPY ./etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key
#COPY ./etc/ssh/ssh_host_rsa_key.pub /etc/ssh/ssh_host_rsa_key.pub
#RUN chmod -R 0644 /etc/ssh/ssh_host_rsa_key
#RUN chmod -R 0644 /etc/ssh/ssh_host_rsa_key.pub

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

EXPOSE 22


#CMD ["/bin/bash", "-c", "tail -f /etc/supervisord.conf"]
CMD ["/usr/bin/supervisord"]

#CMD ['/usr/sbin/sshd -D']
