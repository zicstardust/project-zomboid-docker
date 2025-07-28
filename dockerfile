FROM cm2network/steamcmd:latest AS build

RUN /home/steam/steamcmd/steamcmd.sh +force_install_dir /home/steam/pz_server +login anonymous +app_update 380870 validate +quit

RUN sed -i '/"-Djava.awt.headless=true",/ a\
		"-Duser.home=/data",\' /home/steam/pz_server/ProjectZomboid64.json


FROM debian:stable-slim

WORKDIR /app

ENV UID=1000
ENV GID=1000

COPY --from=build --chown=pzserver:pzserver /home/steam/pz_server /app
COPY --chown=pzserver:pzserver run.sh /app

RUN apt-get update \
&& apt-get -y --no-install-suggests --no-install-recommends install ca-certificates \
&& groupadd -g ${GID} pzserver \
&& useradd -m -u ${UID} -g pzserver pzserver \
&& mkdir -p /data \
&& chown -R pzserver:pzserver /data \
&& chown -R pzserver:pzserver /app  \
&& chmod +x /app/run.sh


USER pzserver

EXPOSE 16261/udp
EXPOSE 16262/udp

VOLUME [ "/data" ]

CMD [ "/app/run.sh" ]
