#!/bin/bash

set -e
: "${BUILD:=41}"

if [ "$BUILD" == "41" ]; then
    BRANCHE="public"
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

exec gosu pzserver /steam/steamcmd.sh +force_install_dir /app +login anonymous +app_update 380870 validate -beta "${BRANCHE}" +quit

if awk "BEGIN {exit !($BUILD <= 40)}"; then
    sed -i 's/"-Xmx2048m",/"-XmxTEMP",/' /app/ProjectZomboid64.json
else
    sed -i 's/"-Xmx8g",/"-XmxTEMP",/' /app/ProjectZomboid64.json
fi

sed -i '/"-XmxTEMP",/ a\
		"-Duser.language=TEMP",\' /app/ProjectZomboid64.json


sed -i '/"-XmxTEMP",/ a\
	"-Ddeployment.user.cachedir=/data",\' /app/ProjectZomboid64.json


if awk "BEGIN {exit !($BUILD <= 39)}"; then
    sed -i '/INSTDIR="`pwd`"/ a\ulimit -n 4096\' /app/start-server.sh
fi


if awk "BEGIN {exit !($BUILD <= 40)}"; then
    JRE_VERSION="8.88.0.19-ca-jre8.0.462"
else
    JRE_VERSION="17.60.17-ca-jre17.0.16"
fi

if [ "$UPDATE_JRE" == "1" ]; then
    echo "Updating JRE..."
    rm -Rf /app/jre64
    wget https://cdn.azul.com/zulu/bin/zulu${JRE_VERSION}-linux_x64.tar.gz
    tar -xf zulu${JRE_VERSION}-linux_x64.tar.gz
    rm -f zulu${JRE_VERSION}-linux_x64.tar.gz
    mv zulu${JRE_VERSION}-linux_x64 jre64
fi
