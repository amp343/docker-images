FROM nowait/php:7.0-cli-alpine
MAINTAINER Nowait <devops@nowait.com>

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk --no-cache add 'php7-apache2<7.1' && \
    mkdir -p /run/apache2

COPY apache.conf /etc/apache2/conf.d/docker.conf

EXPOSE 80

CMD ["/usr/sbin/httpd","-DFOREGROUND"]
