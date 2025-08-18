#!/bin/bash

set -e

: "${PUID:=1000}"
: "${PGID:=1000}"

if ! getent group pzserver >/dev/null; then
    groupadd -g "$PGID" pzserver
fi

if ! id -u pzserver >/dev/null 2>&1; then
    useradd -m -u "$PUID" -g "$PGID" -s /sbin/nologin pzserver
fi

mkdir -p /data

JRE_VERSION=
if [ "$UPDATE_JRE" == "1" ]; then
    echo "Updating JRE..."
    rm -Rf /app/jre64
    wget https://cdn.azul.com/zulu/bin/zulu${JRE_VERSION}-linux_x64.tar.gz
    tar -xf zulu${JRE_VERSION}-linux_x64.tar.gz
    rm -f zulu${JRE_VERSION}-linux_x64.tar.gz
    mv zulu${JRE_VERSION}-linux_x64 jre64
fi


chown -R pzserver:pzserver /app /data

exec gosu pzserver "$@"
