FROM cm2network/steamcmd:latest

RUN /home/steam/steamcmd/steamcmd.sh +force_install_dir /home/steam/pz_server +login anonymous +app_update 380870 validate +quit

WORKDIR /home/steam/pz_server

COPY run.sh /home/steam/

EXPOSE 16261/udp
EXPOSE 16262/udp

VOLUME [ "/home/steam/Zomboid" ]

CMD ["bash", "/home/steam/run.sh"]
