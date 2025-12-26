#!/usr/bin/env bash
set -euo pipefail

mods_dir="/data/Zomboid/mods"
server_ini_file="/data/Zomboid/Server/server.ini"

if [ ! -f $server_ini_file ]; then
    exit 0
fi

if [ ! -d $mods_dir ]; then
    mkdir -p ${mods_dir}
fi


function ini_get() {
    local file="$1"
    local key="$2"
    grep -E "^\s*${key}\s*=" "$file" | sed -E "s/^\s*${key}\s*=\s*//"
}

workshop_ids=$(ini_get "$server_ini_file" "WorkshopItems")

IFS=";" read -ra ids <<< "$workshop_ids"

if [ "$workshop_ids" == "" ]; then
    echo "No mods to download"
    exit 0
fi

rm -Rf /home/pzserver/Steam/steamapps/workshop/content/108600/*
rm -Rf ${mods_dir}/*

for item in "${ids[@]}"; do
    echo "Downloading mod: \"$item\"..."
    /steamcmd/steamcmd.sh +login anonymous +workshop_download_item 108600 "$item" +quit &> /dev/null
done

find /home/pzserver/Steam/steamapps/workshop/content/108600/ -maxdepth 3 -type d -path "*/mods/*" -exec cp -r {} "$mods_dir" \;
