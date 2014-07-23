export PASSPHRASE=insecure
export DOMAIN="tomafro.net"

openssl genrsa -des3 -out insecure-$DOMAIN.key -passout env:PASSPHRASE 2048
openssl rsa -in insecure-$DOMAIN.key -out insecure-$DOMAIN.key -passin env:PASSPHRASE

subj="
C=GB
ST=GB
O=tomafro.net
localityName=London
commonName=tomafro.net
organizationalUnitName=tomafro.net
emailAddress=insecure@tomafro.net
"

openssl req \
    -new \
    -batch \
    -subj "$(echo -n "$subj" | tr "\n" "/")" \
    -key insecure-$DOMAIN.key \
    -out insecure-$DOMAIN.csr

openssl x509 -req -days 3650 -in insecure-$DOMAIN.csr -signkey insecure-$DOMAIN.key -out insecure-$DOMAIN.crt
