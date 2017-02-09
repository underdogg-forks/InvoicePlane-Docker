docker run -it -p 8000:80 --name ip --entrypoint=/start.sh --link ip-mariadb:mysql coelis/invoiceplane:latest
