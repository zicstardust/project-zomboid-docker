FROM cm2network/steamcmd:latest as build

RUN /home/steam/steamcmd/steamcmd.sh +force_install_dir /home/steam/pz_server +login anonymous +app_update 380870 validate +quit




FROM debian:stable-slim

RUN apt-get update \
&& apt-get -y --no-install-suggests --no-install-recommends install ca-certificates

ENV UID=1000
ENV GID=1000

RUN groupadd -g ${GID} pzserver \
&& useradd -m -u ${UID} -g pzserver pzserver

#RUN mkdir -p /home/pzserver \
#&& chown -R pzserver:pzserver /home/pzserver

RUN mkdir -p /data \
&& chown -R pzserver:pzserver /data

USER pzserver

WORKDIR /app

COPY --from=build --chown=pzserver:pzserver /home/steam/pz_server /app

RUN sed -i '/"-Djava.awt.headless=true",/ a\
		"-Duser.home=/data",\' ProjectZomboid64.json

#RUN sed -i '/"-Djava.awt.headless=true",/ a\
#		"-Ddeployment.user.cachedir=/data/cache",\' ProjectZomboid64.json

COPY --chown=pzserver:pzserver run.sh /app

EXPOSE 16261/udp
EXPOSE 16262/udp

VOLUME [ "/data" ]

CMD ["bash", "/app/run.sh"]