#!/usr/bin/env bash
set -euo pipefail

export XDEBUG_CONFIG="client_host=$(ip route show | awk '/default/ { print $3 }')"

chown -R developer: /var/www/html/guybrush
rm -f /var/www/html/guybrush/.gitkeep

if [ -d /var/www/html/guybrush/var/ ]; then
  mkdir -p /var/www/html/guybrush/var/log/
  touch /var/www/html/guybrush/var/log/xdebug.log
fi

exec "$@"
