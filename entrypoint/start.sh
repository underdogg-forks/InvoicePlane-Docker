#!/bin/bash

if [ -f /app/.configureme ] && [ "$FIRST_INSTALL" == "true" ]
then
  until echo "CREATE DATABASE invoiceplane;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD} -hmariadb
  do
    echo "Database isn't ready yet, waiting"
    sleep 5
  done
  echo "GRANT ALL PRIVILEGES ON invoiceplane.* TO invoiceplane@'%';" | mysql -uroot -p${MYSQL_ROOT_PASSWORD} -hmariadb
fi

if [ -f /app/.configureme ] && [ "$IMPORT_DATA" == "true" ]
then
  until echo ";" | mysql -uroot -p${MYSQL_ROOT_PASSWORD} -hmariadb
  do
    echo "Database isn't ready yet, waiting"
    sleep 5
  done

  echo "Importing SQL dump..."
  cat /app/dump.sql | mysql -uroot -p${MYSQL_ROOT_PASSWORD} -D invoiceplane -hmariadb
  rm /app/dump.sql
fi

if [ -f /app/.configureme ]
then
  cp /invoiceplane_setup/ipconfig.php /app/
  sed -i "s/%{IP_USER}/${MYSQL_USER}/" /app/ipconfig.php
  sed -i "s/%{IP_PASSWORD}/${MYSQL_PASSWORD}/" /app/ipconfig.php
  sed -i "s/%{IP_URL}/${IP_URL}/" /app/ipconfig.php
  sed -i "s/%{SUMEX_URL}/${SUMEX_URL}/" /app/ipconfig.php
  rm /app/.configureme
  mkdir -p /app/uploads/{archive,customer_files,temp/mpdf}
  chown -R root:$APPLICATION_USER /app
  chmod -R 775 /app/{uploads,ipconfig.php}; chmod 775 /app/application/{config,logs}
  composer install -d /app
  chmod -R 775 /app/vendor/mpdf/mpdf/tmp
  chown -R application:application /app/vendor/mpdf/mpdf/tmp
  pushd /app > /dev/null
  npm install -g grunt
  npm install
  grunt
  popd > /dev/null
fi
/entrypoint.cmd/supervisord.sh
