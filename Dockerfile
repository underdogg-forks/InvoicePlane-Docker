FROM webdevops/php-nginx:debian-9
LABEL maintainer denvit <denys@denv.it>
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get update && apt-get install -y mariadb-client nodejs
RUN git clone -b master https://github.com/Coelis/InvoicePlane/ /app; touch /app/.configureme
RUN git clone https://github.com/Coelis/InvoicePlane-Italian /app/application/language/italian
COPY nginx/vhost.conf /etc/nginx/vhost.conf
COPY invoiceplane_setup /invoiceplane_setup
COPY entrypoint/start.sh /
RUN chmod 755 /start.sh
EXPOSE 80
ENTRYPOINT /start.sh
