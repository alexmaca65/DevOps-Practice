FROM remote-host

# Avoid interactive prompts during apt installs (tzdata)
ARG TZ=UTC
ENV TZ=$TZ DEBIAN_FRONTEND=noninteractive

# Set container timezone non-interactively:
#   - Create a symlink from /etc/localtime -> $TZ (Ex: Europe/Bucharest)
#   - Reconfigure tzdata so system files (/etc/timezone) match the symlink
# Install NGINX and PHP packages in one single apt-get install call
RUN apt-get update && \
  apt-get install -y tzdata && \
  ln -fs /usr/share/zoneinfo/$TZ /etc/localtime &&\
  dpkg-reconfigure -f noninteractive tzdata && \
  apt-get install -y \
    sudo \
    nginx \
    php-fpm \
    php-cli \
    php-mysql \
    php-soap \
    php-xml \
    php-zip \
    php-json \
    php-mbstring \
    php-gd \
    openssl && \
  rm -rf /var/lib/apt/lists/*

# Expose HTTP (80) and HTTPS (443) ports
EXPOSE 80 443

# Create a deploy user and allow passwordless sudo
RUN echo "remote_user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/remote_user && \
  chmod 440 /etc/sudoers.d/remote_user

# Copy nginx config, index.php and start-services script
COPY ./webserver-config/nginx.conf /etc/nginx/conf.d/default.conf
COPY ./webserver-config/index.php /var/www/html/index.php
COPY ./webserver-config/start.sh /start.sh
COPY ./webserver-config/table.j2 /var/www/html/index.php

RUN chmod +x /start.sh

CMD /start.sh
