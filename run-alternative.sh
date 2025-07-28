#!/bin/bash
cd "$(dirname "$0")" || exit 1
#cd /app

INSTDIR="`dirname $0`" ; cd "${INSTDIR}" ; INSTDIR="`pwd`"

export PATH="${INSTDIR}/jre64/bin:$PATH"
export LD_LIBRARY_PATH="${INSTDIR}/linux64:${INSTDIR}/natives:${INSTDIR}:${INSTDIR}/jre64/lib/amd64:${LD_LIBRARY_PATH}"
export JSIG="libjsig.so"

export LD_PRELOAD="${LD_PRELOAD}:${JSIG}:/app/jre64/lib/libjsig.so"

#server run
RANDOM_PASSWORD=$(head -c 16 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9')

PZ_CLASSPATH="java/commons-compress-1.18.jar:java/uncommons-maths-1.2.3.jar:java/trove-3.0.3.jar:java/sqlite-jdbc-3.27.2.1.jar:java/lwjgl_util.jar:java/lwjgl-opengl-natives-linux.jar:java/lwjgl-opengl.jar:java/lwjgl-jemalloc-natives-linux.jar:java/lwjgl-jemalloc.jar:java/lwjgl-glfw-natives-linux.jar:java/lwjgl-glfw.jar:java/lwjgl-natives-linux.jar:java/lwjgl.jar:java/jaxb-runtime.jar:java/jaxb-api.jar:java/javax.activation-api.jar:java/javacord-2.0.17-shaded.jar:java/jassimp.jar:java/istack-commons-runtime.jar:java/."

./jre64/bin/java \
  -Djava.awt.headless=true \
  -Dzomboid.steam=${STEAM:-1} \
  -Dzomboid.znetlog=1 \
  -XX:+UseZGC \
  -XX:-OmitStackTraceInFastThrow \
  -Xmx${MAX_RAM:-8g} \
  -Djava.library.path="linux64/:natives/" \
  -Djava.security.egd="file:/dev/urandom" \
  -Duser.home="/data" \
  -cp "$PZ_CLASSPATH" \
  zombie.network.GameServer \
  -servername server \
  -adminusername ${ADMIN_USERNAME:-admin} \
  -adminpassword ${ADMIN_PASSWORD:-${RANDOM_PASSWORD}}
