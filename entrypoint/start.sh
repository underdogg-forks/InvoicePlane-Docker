#!/bin/bash

if [ -f /app/.configureme ]
then
  until echo "CREATE DATABASE invoiceplane;" | mysql -uroot -p${MYSQL_ENV_MYSQL_ROOT_PASSWORD} -h${MYSQL_PORT_3306_TCP_ADDR}
  do
    echo "Database isn't ready yet, waiting"
    sleep 5
  done
  cp /invoiceplane_setup/config.php /app/application/config/
  cp /invoiceplane_setup/index.php /app/index.php
  cp /invoiceplane_setup/database.php /app/application/config/
  rm /app/.configureme
  chown -R root:$APPLICATION_USER /app
  chmod -R 775 /app/uploads; chmod 775 /app/application/{config,logs}
  composer install -d /app
fi
/entrypoint.cmd/supervisord.sh
