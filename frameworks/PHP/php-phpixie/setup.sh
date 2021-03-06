#!/bin/bash

sed -i 's|localhost|'"${DBHOST}"'|g' assets/config/db.php
sed -i 's|".*/FrameworkBenchmarks/php-phpixie|"'"${TROOT}"'|g' deploy/php-phpixie
sed -i 's|Directory .*/FrameworkBenchmarks/php-phpixie|Directory '"${TROOT}"'|g' deploy/php-phpixie
sed -i 's|root .*/FrameworkBenchmarks/php-phpixie|root '"${TROOT}"'|g' deploy/nginx.conf
sed -i 's|/usr/local/nginx/|'"${IROOT}"'/nginx/|g' deploy/nginx.conf

export PATH="$COMPOSER_HOME:$PHP_HOME/bin:$PHP_HOME/sbin:$PATH"

composer.phar install --optimize-autoloader
$PHP_FPM --fpm-config $FWROOT/config/php-fpm.conf -g $TROOT/deploy/php-fpm.pid
$NGINX_HOME/sbin/nginx -c $TROOT/deploy/nginx.conf
