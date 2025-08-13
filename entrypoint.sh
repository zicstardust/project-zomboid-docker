#!/bin/bash

set -e

: "${UID:=1000}"
: "${GID:=1000}"
: "${USERNAME:=pzserver}"

if ! getent group $USERNAME >/dev/null; then
    groupadd -g "$GID" "$USERNAME"
fi

if ! id -u "$USERNAME" >/dev/null 2>&1; then
    useradd -m -u "$UID" -g "$GID" -s /bin/bash "$USERNAME"
fi

mkdir -p /data

JRE_VERSION=
if [ "$UPDATE_JRE" == "1" ]; then
    echo "Updating JRE..."
    #mv /app/jre64 /app/jre_old
    rm -Rf /app/jre64
    wget https://cdn.azul.com/zulu/bin/zulu${JRE_VERSION}-linux_x64.tar.gz
    tar -xf zulu${JRE_VERSION}-linux_x64.tar.gz
    rm -f zulu${JRE_VERSION}-linux_x64.tar.gz
    mv zulu${JRE_VERSION}-linux_x64 jre64
fi


chown -R "$USERNAME":"$USERNAME" /app /data

exec gosu "$USERNAME" "$@"
