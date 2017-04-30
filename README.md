# Invoiceplane
This container has a ready-to-go instance of [Invoiceplane](https://invoiceplane.com).  
Follow the installation instructions to understand how to get started with Invoiceplane  
  
## Installation Instructions
First of all, you need to `docker pull coelis/invoiceplane` to download the container.  
Once the container has been downloaded, you have to run a MariaDB / MySQL container (the database container):  
`docker run --name ip-mariadb -e MYSQL_ROOT_PASSWORD=RandomPasswordGoesHere -d mariadb:latest`  
When the container is started, you're ready to link the InvoicePlane container with the following command:  
`docker run -p 8000:80 --name ip --link ip-mariadb:mysql coelis/invoiceplane` (where 8000 is the port you want to expose your container to)  
  
Wait till it start, then visit http://localhost:8000/setup to get started: you'll have to setup an account and you'll be good to go, enjoy!  
  
## TL;DR
If you are proficient with the command line and want be ready in under 30 seconds do the following:  
```
git clone https://github.com/Coelis/InvoicePlane-Docker
cd InvoicePlane-Docker
./run_docker.sh
```
Then visit http://localhost:8000/setup, create a new account and enjoy
