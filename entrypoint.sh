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

mkdir -p /data /home/pzserver /cache

chown -R pzserver:pzserver /app /data /home/pzserver /steamcmd /cache

exec gosu pzserver "$@"
