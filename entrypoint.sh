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
chown -R "$USERNAME":"$USERNAME" /app /data

exec gosu "$USERNAME" "$@"
