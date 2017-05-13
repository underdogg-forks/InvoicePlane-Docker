FROM webdevops/php-nginx:alpine-3-php7
LABEL maintainer denvit <denys@denv.it>
RUN apk-install mariadb-client nodejs
RUN git clone -b master https://github.com/Coelis/InvoicePlane/ /app; touch /app/.configureme
COPY nginx/vhost.conf /etc/nginx/vhost.conf
COPY invoiceplane_setup /invoiceplane_setup
COPY entrypoint/start.sh /
RUN chmod 755 /start.sh
EXPOSE 80
ENTRYPOINT /start.sh
