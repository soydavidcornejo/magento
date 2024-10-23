ARG VARIANT=22-bookworm
FROM node:${VARIANT}

ARG USERNAME=node
ARG NPM_GLOBAL=/usr/local/share/npm-global

# Add NPM global to PATH.
ENV PATH=${NPM_GLOBAL}/bin:${PATH}

# Instalar dependencias adicionales del sistema (Apache, MariaDB, PHP)
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        apache2 \
        mariadb-server \
        php \
        php-mysql \
        php-cli \
        php-fpm \
        php-xml \
        php-soap \
        php-zip \
        php-curl \
        php-gd \
        php-intl \
        libapache2-mod-php \
        unzip \
        curl \
    && apt-get clean

# Habilitar modulos necesarios de Apache
RUN a2enmod rewrite

# Crear y cambiar permisos del directorio para Magento (si lo necesitas)
RUN mkdir -p /var/www/html/magento \
    && chown -R ${USERNAME}:${USERNAME} /var/www/html/magento

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Configurar npm para uso global y ESLint
RUN \
    # Configure global npm install location, use group to adapt to UID/GID changes
    if ! cat /etc/group | grep -e "^npm:" > /dev/null 2>&1; then groupadd -r npm; fi \
    && usermod -a -G npm ${USERNAME} \
    && umask 0002 \
    && mkdir -p ${NPM_GLOBAL} \
    && touch /usr/local/etc/npmrc \
    && chown ${USERNAME}:npm ${NPM_GLOBAL} /usr/local/etc/npmrc \
    && chmod g+s ${NPM_GLOBAL} \
    && npm config -g set prefix ${NPM_GLOBAL} \
    && su ${USERNAME} -c "npm config -g set prefix ${NPM_GLOBAL}" \
    # Install eslint
    && su ${USERNAME} -c "umask 0002 && npm install -g eslint" \
    && npm cache clean --force > /dev/null 2>&1

# Instalar más módulos npm globalmente si lo necesitas
# RUN su node -c "npm install -g typescript pm2"

# [Opcional] Instalar una versión adicional de Node.js usando nvm
# ARG EXTRA_NODE_VERSION=14
# RUN su node -c "source /usr/local/share/nvm/nvm.sh && nvm install ${EXTRA_NODE_VERSION}"

# Limpiar los caches para reducir el tamaño del contenedor
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Exponer el puerto 80 para Apache
EXPOSE 8080
