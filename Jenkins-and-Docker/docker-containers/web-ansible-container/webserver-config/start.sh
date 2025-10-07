#!/bin/bash

# Start SSH in Foreground
/usr/sbin/sshd -D

# Start PHP-FPM process in Foreground
php-fpm8.1 -F

# Start NGINX daemon in Foreground
nginx -g "daemon off;"