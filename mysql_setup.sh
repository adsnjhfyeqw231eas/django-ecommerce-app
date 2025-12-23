#!/bin/bash
# host level
if command -v sudo >/dev/null; then
sudo mysql <<EOF
CREATE DATABASE IF NOT EXISTS ecommerce;
CREATE USER IF NOT EXISTS 'ecomuser'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON ecommerce.* TO 'ecomuser'@'%';
FLUSH PRIVILEGES;
EOF
else
# docker level
mysql -h "$MYSQL_HOST" \
      -u root \
      -p"$MYSQL_ROOT_PASSWORD" <<EOF
CREATE DATABASE IF NOT EXISTS ecommerce;
CREATE USER IF NOT EXISTS 'ecomuser'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON ecommerce.* TO 'ecomuser'@'%';
FLUSH PRIVILEGES;
EOF
fi

