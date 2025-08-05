#!/bin/bash

set -e

# Usa valores padrão se não definidos
: "${UID:=1000}"
: "${GID:=1000}"
: "${USERNAME:=steam}"

# Cria grupo se necessário
if ! getent group $USERNAME >/dev/null; then
    groupadd -g "$GID" "$USERNAME"
fi

# Cria usuário se necessário
if ! id -u "$USERNAME" >/dev/null 2>&1; then
    useradd -m -u "$UID" -g "$GID" -s /bin/bash "$USERNAME"
fi

# Corrige permissões
mkdir -p /home/$USERNAME/Steam
chown -R "$USERNAME":"$USERNAME" /home/$USERNAME /app

# Executa como o usuário criado
exec gosu "$USERNAME" "$@"