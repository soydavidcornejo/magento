FROM gitpod/workspace-full

RUN sudo apt-get update \
    && sudo apt-get install -y \
    php7.4 \
    php7.4-cli \
    php7.4-fpm \
    php7.4-common \
    php7.4-curl \
    php7.4-intl \
    php7.4-mbstring \
    php7.4-mysql \
    php7.4-xml \
    php7.4-zip \
    php7.4-bcmath \
    php7.4-gd \
    php7.4-soap \
    mysql-server \
    apache2

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

RUN composer global require hirak/prestissimo