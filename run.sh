#!/bin/bash

cd /home/steam/pz_server

#Set non-steam
sed -i "s/-Dzomboid.steam=1/-Dzomboid.steam=${STEAM:-1}/" ProjectZomboid64.json

#Set Max RAM
sed -i "s/-Xmx8g/-Xmx${MAX_RAM:-8g}/" ProjectZomboid64.json

#server run
RANDOM_PASSWORD=$(head -c 16 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9')
./start-server.sh \
    -servername server \
    -adminusername ${ADMIN_USERNAME:-admin} \
    -adminpassword ${ADMIN_PASSWORD:-${RANDOM_PASSWORD}}