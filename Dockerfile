FROM debian:latest

# Upgrade system and install base dependencies
ENV DEBIAN_FRONTEND noninteractive
ENV PACKAGES nginx php php-fpm supervisor
RUN apt-get update \
    && apt-get upgrade --yes \
    && apt-get install --yes --no-install-recommends ${PACKAGES} \
    && apt-get autoremove --yes

# Add webserver user
RUN usermod --uid=10000 www-data
RUN mkdir -p /var/run/php \
    && chown www-data /var/run/php

# Create version-independent PHP paths
RUN ln -s /etc/php/8* /etc/php/current
RUN ln -s /usr/sbin/php-fpm8* /usr/sbin/php-fpm-current

# Copy container config
COPY files/nginx.conf /etc/nginx/nginx.conf
COPY files/php-fpm.conf /etc/php/current/fpm/php-fpm.conf
COPY files/supervisord.conf /etc/supervisor/supervisord.conf

# Become supervisord
CMD exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
