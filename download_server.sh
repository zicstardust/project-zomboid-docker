#!/bin/bash

set -e
: "${BUILD:=stable}"

if [ "$BUILD" == "42" ] || [ "$BUILD" == "unstable" ]; then
    BRANCHE="unstable"
    BUILD="42"
elif [ "$BUILD" == "41" ] || [ "$BUILD" == "stable" ]; then
    BRANCHE="public"
    BUILD="41"
elif [ "$BUILD" == "41.78.7" ]; then
    BRANCHE="legacy_41_78_7"
elif [ "$BUILD" == "41.77" ]; then
    BRANCHE="legacy41_77"
elif [ "$BUILD" == "41.73" ]; then
    BRANCHE="legacy41_73"
elif [ "$BUILD" == "41.71" ]; then
    BRANCHE="legacy_41_71"
elif [ "$BUILD" == "41.68" ]; then
    BRANCHE="legacy41_68"
elif [ "$BUILD" == "40" ]; then
    BRANCHE="legacy40"
elif [ "$BUILD" == "39" ]; then
    BRANCHE="build-39-vehicles"
elif [ "$BUILD" == "38" ]; then
    BRANCHE="38.30(pre-vehicles)"
else
    echo "${BUILD} not supported"
    exit 1
fi

echo "Downloading server version ${BUILD}..."

if [ "${DISABLE_CACHE}" != "1" ]; then
    /cache.sh restore_steamcmd
    /cache.sh restore_app $BUILD
fi

RUN_AGAIN=1
while [ $RUN_AGAIN -eq 1 ]
do
    /steam/steamcmd.sh +force_install_dir /app +login anonymous +app_update 380870 validate -beta "${BRANCHE}" +quit
    
    if [ "$?" == "0" ]; then
        RUN_AGAIN=0
    fi  
done

if [ "${DISABLE_CACHE}" != "1" ]; then
    /cache.sh backup_steamcmd
    /cache.sh backup_app $BUILD $APP_CACHE
fi

sleep 3

if awk "BEGIN {exit !($BUILD <= 40)}"; then
    sed -i "s/Xmx2048m/XmxTEMP/" /app/ProjectZomboid64.json
else
    sed -i "s/Xmx8g/XmxTEMP/" /app/ProjectZomboid64.json
fi

sed -i '/"-XmxTEMP",/ a\
		"-Duser.language=TEMP",\' /app/ProjectZomboid64.json


sed -i '/"-XmxTEMP",/ a\
	"-Ddeployment.user.cachedir=/data",\' /app/ProjectZomboid64.json


if awk "BEGIN {exit !($BUILD <= 39)}"; then
    sed -i '/INSTDIR="`pwd`"/ a\ulimit -n 4096\' /app/start-server.sh
fi

if [ "$UPDATE_JRE" == "1" ]; then
    if awk "BEGIN {exit !($BUILD <= 40)}"; then
        JRE_VERSION="8.90.0.19-ca-jre8.0.472"
    elif awk "BEGIN {exit !($BUILD <= 41)}"; then
        JRE_VERSION="17.62.17-ca-jre17.0.17"
    else
        JRE_VERSION="25.30.17-ca-jre25.0.1"
    fi
    echo "Updating JRE to ${JRE_VERSION}..."
    rm -Rf /app/jre64
    wget -q https://cdn.azul.com/zulu/bin/zulu${JRE_VERSION}-linux_x64.tar.gz
    tar -xf zulu${JRE_VERSION}-linux_x64.tar.gz
    rm -f zulu${JRE_VERSION}-linux_x64.tar.gz
    mv zulu${JRE_VERSION}-linux_x64 jre64
fi
