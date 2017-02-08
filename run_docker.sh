#!/bin/sh
rootPWD=$(pwgen -sy 16 -1)
./scripts/start_mariadb.sh $rootPWD
sleep 5
./scripts/start_ip.sh
