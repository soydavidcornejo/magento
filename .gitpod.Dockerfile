# Usar una imagen base de Gitpod
FROM gitpod/workspace-full:latest

# Instalar dependencias necesarias
RUN sudo apt-get update && sudo apt-get install -y \
    apache2 \
    mariadb-server \
    php \
    php-cli \
    php-fpm \
    php-mysql \
    php-xml \
    php-mbstring \
    php-intl \
    php-zip \
    php-curl \
    php-gd \
    php-soap \
    libapache2-mod-php \
    unzip \
    curl \
    && sudo apt-get clean

# Habilitar modulos necesarios de Apache
RUN sudo a2enmod rewrite

# Habilitar extensión SOAP
RUN sudo phpenmod soap

# Crear el directorio de Magento
RUN sudo mkdir -p /var/www/html/magento

# Cambiar permisos
RUN sudo chown -R gitpod:gitpod /var/www/html/magento

# Establecer el directorio de trabajo
WORKDIR /var/www/html/magento

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && sudo mv composer.phar /usr/local/bin/composer

# Exponer el puerto 80 para Apache
EXPOSE 80
