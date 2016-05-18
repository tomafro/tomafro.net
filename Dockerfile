FROM tomafro/nginx:latest

MAINTAINER Tom Ward (tom@popdog.net)

ADD docker/tomafro.net /etc/nginx/sites.d/tomafro.net
ADD public /var/www/tomafro.net
