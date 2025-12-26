#!/usr/bin/env bash

set -e
: "${UPDATE_JRE:=0}"
: "${STEAM:=1}"
: "${DISABLE_MOD_DOWNLOADER:=0}"

BUILD=$1
JRE8_VERSION="8.90.0.19-ca-jre8.0.472"
JRE17_VERSION="17.62.17-ca-jre17.0.17"
JRE25_VERSION="25.30.17-ca-jre25.0.1"


#Set MAX_RAM
sed -i "s/Xmx2048m/Xmx${MAX_RAM:-4g}/" /app/ProjectZomboid64.json #BUILD <= 40
sed -i "s/Xmx8g/Xmx${MAX_RAM:-4g}/" /app/ProjectZomboid64.json #BUILD >= 41


#Remove JRE -Xms arg (BUILD <= 40)
#sed '/Xms2048m/d' /app/ProjectZomboid64.json


#Set server language
sed -i '/"-Dzomboid.steam=1",/ a\
		"-Duser.language=TEMP",\' /app/ProjectZomboid64.json
sed -i "s/-Duser.language=TEMP/-Duser.language=${LANGUAGE:-en}/" /app/ProjectZomboid64.json


#Set gamedata to /data
sed -i '/"-Dzomboid.steam=1",/ a\
		"-Ddeployment.user.cachedir=/data",\' /app/ProjectZomboid64.json


#Set ulimit from server BUILD <= 39
if awk "BEGIN {exit !($BUILD <= 39)}"; then
    sed -i '/INSTDIR="`pwd`"/ a\ulimit -n 4096\' /app/start-server.sh
fi


#Set STEAM
sed -i "s/-Dzomboid.steam=1/-Dzomboid.steam=${STEAM}/" /app/ProjectZomboid64.json


#Update JRE
if [ "$UPDATE_JRE" == "1" ]; then
    if awk "BEGIN {exit !($BUILD <= 40)}"; then
        JRE_VERSION=$JRE8_VERSION
    elif awk "BEGIN {exit !($BUILD >= 42)}"; then
        JRE_VERSION=$JRE25_VERSION
    else
        JRE_VERSION=$JRE17_VERSION
    fi

    echo "Updating JRE to ${JRE_VERSION}..."
    rm -Rf /app/jre64
    wget -q https://cdn.azul.com/zulu/bin/zulu${JRE_VERSION}-linux_x64.tar.gz
    tar -xf zulu${JRE_VERSION}-linux_x64.tar.gz
    rm -f zulu${JRE_VERSION}-linux_x64.tar.gz
    mv zulu${JRE_VERSION}-linux_x64 jre64
fi

#Download Mods
if [ "$STEAM" == "0" ] && [ "${DISABLE_MOD_DOWNLOADER}" == "0" ]; then
    echo "Downloading mods for non-steam server..."
    /mods_downloader.sh
fi
