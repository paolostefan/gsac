FROM php:8.1-fpm

ENV PACKAGES \
  g++ \
  iproute2 \
  iputils-ping \
  libicu-dev \
  libpq-dev \
  libzip-dev \
  symfony-cli \
  unzip \
  wget \
  zlib1g-dev

ENV PHP_EXTENSIONS \
  intl \
  opcache \
  pdo \
  pdo_pgsql \
  pgsql \
  zip

# Install symfony cli binary
RUN echo 'deb [trusted=yes] https://repo.symfony.com/apt/ /' > /etc/apt/sources.list.d/symfony-cli.list

RUN apt-get update && apt-get install -y ${PACKAGES} \
  && docker-php-ext-configure intl \
  && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
  && docker-php-ext-configure zip \
  && docker-php-ext-install ${PHP_EXTENSIONS}

ENV PECL_EXTENSIONS xdebug

RUN pecl install ${PECL_EXTENSIONS}

RUN apt-get autoremove -y && rm -rf /var/cache/apt/*

# Composer
COPY --from=composer:2.1 /usr/bin/composer /usr/bin/composer

# Unprivileged user
RUN groupadd --gid 1000 developer && useradd -d /var/www/html/ -s /bin/bash -u 1000 -g 1000 developer

RUN mkdir -p /var/www/html/guybrush/

RUN su developer -c 'git config --global user.email "developer@example.com"'
RUN su developer -c 'git config --global user.name "Rockstar Developer"'

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 755 /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh", "php-fpm" ]
