#!/usr/bin/env bash

#download server
download_server.sh

#Print server java version
echo "SERVER JAVA VERSION: $(/app/jre64/bin/java --version)"

#server run
/app/start-server.sh \
    -servername server \
    -adminusername ${ADMIN_USERNAME:-admin} \
    -adminpassword ${ADMIN_PASSWORD:-$(head -c 16 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9')}
