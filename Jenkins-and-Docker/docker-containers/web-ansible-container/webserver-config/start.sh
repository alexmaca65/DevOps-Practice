#!/bin/bash

# Ensure PHP-FPM socker directory exists each start
mkdir -p /run/php

# Start SSH in Background
echo "[start] launching sshd..."
/usr/sbin/sshd -D &

# Start PHP-FPM process in Background
echo "[start] launching php-fpm..."
php-fpm8.1 -F &

# Start NGINX daemon in Foreground (becomes PID 1 for Docker)
echo "[start] launching nginx (foreground)..."
nginx -g "daemon off;"