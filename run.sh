#!/bin/bash

cd /home/steam/pz_server

#Set non-steam
#if [[ -z "${NON_STEAM}" ]]; then
if [ "$NON_STEAM" == "true" ]; then
    STEAM_CONFIG="0"
else
    STEAM_CONFIG="1"
fi
sed -i "s/-Dzomboid.steam=1/-Dzomboid.steam=${STEAM_CONFIG}/" ProjectZomboid64.json

#Set Max RAM
if [[ -z "${MAX_RAM}" ]]; then
    RAM="8g"
else
    RAM=${MAX_RAM}
fi
sed -i "s/-Xmx8g/-Xmx${RAM}/" ProjectZomboid64.json

#server run
RANDOM_PASSWORD=$(head -c 16 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9')
./start-server.sh \
    -servername server \
    -adminusername ${ADMIN_USERNAME:-admin} \
    -adminpassword ${ADMIN_PASSWORD:-${RANDOM_PASSWORD}}