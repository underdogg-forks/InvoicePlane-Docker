#!/bin/sh
rootPWD=$(pwgen -s 18 -1)
./scripts/start_mariadb.sh $rootPWD
./scripts/start_ip.sh
