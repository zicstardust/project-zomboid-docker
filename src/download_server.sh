#!/usr/bin/env bash

set -e
: "${BUILD:=stable}"
: "${APP_CACHE:=true}"
: "${DISABLE_CACHE:=false}"


if [ "$BUILD" == "unstable" ]; then
    BUILD="42"
    APP_CACHE="0"
elif [ "$BUILD" == "stable" ]; then
    BUILD="41"
fi


if [ "$BUILD" == "42" ]; then
    BRANCHE="unstable"
elif [ "$BUILD" == "41" ]; then
    BRANCHE="public"
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
    echo "BUILD ${BUILD} not supported"
    exit 1
fi

echo "Downloading server BUILD ${BUILD}..."

if [[ "$DISABLE_CACHE" =~ ^(0|false|False|n|N)$ ]]; then
    cache.sh restore_steamcmd
    cache.sh restore_app $BUILD
fi

steamcmd.sh +force_install_dir /app +login anonymous +app_update 380870 validate -beta "${BRANCHE}" +quit

if [[ "$DISABLE_CACHE" =~ ^(0|false|False|n|N)$ ]]; then
    cache.sh backup_steamcmd
    cache.sh backup_app $BUILD $APP_CACHE
fi


#Configure server
configure_server.sh $BUILD
