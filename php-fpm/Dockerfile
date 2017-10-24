FROM php:7.1-fpm 

MAINTAINER xieyutian "xieyutianhn@gmail.com"
RUN \
    apt-get update \
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
    && make install

RUN pecl install redis-3.1.3 \
    && pecl install xdebug-2.5.5 \
    && docker-php-ext-enable redis xdebug swoole

RUN php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" && php composer-setup.php && php -r "unlink('composer-setup.php');" \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com

RUN php -r "copy('https://nodejs.org/dist/v6.11.4/node-v6.11.4-linux-x64.tar.xz','node-v6.11.4-linux-x64.tar.xz');"\
    && tar xfJ node-v6.11.4-linux-x64.tar.xz \
    && mv node-v6.11.4-linux-x64 /usr/local/node \
    && rm node-v6.11.4-linux-x64.tar.xz

ENV PATH $PATH:/usr/local/node/bin

RUN npm install -g cnpm --registry=https://registry.npm.taobao.org



