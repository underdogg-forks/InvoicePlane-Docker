echo "Starting MariaDB with password $1"
docker run --name ip-mariadb -e MYSQL_ROOT_PASSWORD=$1 -d mariadb:latest
