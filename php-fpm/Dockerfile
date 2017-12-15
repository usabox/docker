FROM php:7.1-fpm 

MAINTAINER xieyutian "xieyutianhn@gmail.com"
RUN \
    apt-get update --fix-missing \
    && apt-get install -y --no-install-recommends \
        libmcrypt-dev \
        libssl-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        zip \
        unzip \
        tar \
        git \
    && apt-get autoremove \
    && apt-get clean \
    && docker-php-ext-install -j$(nproc) iconv mcrypt pdo pdo_mysql\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd


COPY swoole/ swoole/

COPY command.sh command.sh

RUN cd swoole \
    && phpize \
    && ./configure \
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

RUN php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" && php composer-setup.php && php -r "unlink('composer-setup.php');" \
    && php composer.phar config -g repo.packagist composer https://packagist.phpcomposer.com

RUN php -r "copy('https://nodejs.org/dist/v6.11.4/node-v6.11.4-linux-x64.tar.xz','node-v6.11.4-linux-x64.tar.xz');"\
    && tar xfJ node-v6.11.4-linux-x64.tar.xz \
    && mv node-v6.11.4-linux-x64 /usr/local/node \
    && rm node-v6.11.4-linux-x64.tar.xz

ENV PATH $PATH:/usr/local/node/bin

RUN npm install -g cnpm --registry=https://registry.npm.taobao.org


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


RUN mkdir /var/run/sshd && systemctl enable ssh && service ssh start

EXPOSE 22 9000

CMD ["/usr/bin/supervisord"]



