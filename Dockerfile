FROM quay.io/tomafro/nginx:latest

MAINTAINER Tom Ward (tom@popdog.net)

ADD docker/insecure-tomafro.net.crt /private/ssl/tomafro.net.crt
ADD docker/insecure-tomafro.net.key /private/ssl/tomafro.net.key

ADD docker/tomafro.net /etc/nginx/sites.d/tomafro.net

ADD public /var/www/tomafro.net
