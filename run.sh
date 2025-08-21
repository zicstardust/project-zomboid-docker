#!/bin/bash

#Set non-steam
sed -i "s/-Dzomboid.steam=1/-Dzomboid.steam=${STEAM:-1}/" /app/ProjectZomboid64.json

#Set Max RAM
sed -i "s/-XmxTEMP/-Xmx${MAX_RAM:-4g}/" /app/ProjectZomboid64.json

#Set language
sed -i "s/-Duser.language=TEMP/-Duser.language=${LANGUAGE:-en}/" /app/ProjectZomboid64.json

#server run
RANDOM_PASSWORD=$(head -c 16 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9')
/app/start-server.sh \
    -servername server \
    -adminusername ${ADMIN_USERNAME:-admin} \
    -adminpassword ${ADMIN_PASSWORD:-${RANDOM_PASSWORD}}
