FROM tomafro/nginx:latest

MAINTAINER Tom Ward (tom@popdog.net)

ADD insecure-tomafro.net.crt /private/ssl/tomafro.net.crt
ADD insecure-tomafro.net.key /private/ssl/tomafro.net.key

ADD nginx/tomafro.net /etc/nginx/sites-enabled/tomafro.net
ADD nginx/codeclub.tomafro.net /etc/nginx/sites-enabled/codeclub.tomafro.net

RUN sed -i "s/# server_names_hash_bucket_size/server_names_hash_bucket_size/" /etc/nginx/nginx.conf

ADD public /var/www/tomafro.net
ADD codeclub /var/www/codeclub.tomafro.net
