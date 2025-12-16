#!/bin/bash

option=$1
BUILD=$2
APP_CACHE=$3


cache_dir="/cache"


backup_steamcmd(){
    echo "Caching steamcmd..."
    if [ -e "/${cache_dir}/steamcmd.tar.gz" ]; then
        rm -f "/${cache_dir}/steamcmd.tar.gz"
    fi

    if [ -e "/${cache_dir}/steamcmd_config.tar.gz" ]; then
        rm -f "/${cache_dir}/steamcmd_config.tar.gz"
    fi

    tar -C /steam -czf ${cache_dir}/steamcmd.tar.gz .
    tar -C /home/pzserver -czf ${cache_dir}/steamcmd_config.tar.gz ./Steam
    chmod 440 ${cache_dir}/steamcmd.tar.gz ${cache_dir}/steamcmd_config.tar.gz
}


restore_steamcmd(){
    if [ -e "${cache_dir}/steamcmd.tar.gz" ]; then
        echo "Restore cache steamcmd..."
        tar -xzf ${cache_dir}/steamcmd.tar.gz  -C /steam/
        tar -xzf ${cache_dir}/steamcmd_config.tar.gz  -C /home/pzserver/
    fi
}


backup_app(){
    if [ "${APP_CACHE}" != "0" ]; then
        echo "Caching server version ${BUILD}..."
        if [ -e "${cache_dir}/app_${BUILD}.tar.gz" ]; then
            rm -f "${cache_dir}/app_${BUILD}.tar.gz"
        fi

        tar -C /app -czf ${cache_dir}/app_${BUILD}.tar.gz .
        chmod 440 ${cache_dir}/app_${BUILD}.tar.gz
    fi
}


restore_app(){
    if [ -e "${cache_dir}/app_${BUILD}.tar.gz" ]; then
        echo "Restore cache server version ${BUILD}..."
        tar -xzf ${cache_dir}/app_${BUILD}.tar.gz -C /app/
    fi
}



case $option in

  backup_steamcmd)
    backup_steamcmd
    ;;

  restore_steamcmd)
    restore_steamcmd
    ;;

  backup_app)
    backup_app
    ;;

  restore_app)
    restore_app
    ;;

  *)
    echo "cache.sh: argument invalid"
    exit 1
    ;;
esac
