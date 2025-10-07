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

COPY ./webserver-config/nginx.conf /etc/nginx/conf.d/default.conf

COPY ./webserver-config/start.sh /start.sh

RUN chmod +x /start.sh
