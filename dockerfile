FROM debian:13.0-slim

WORKDIR /app

RUN apt-get update && apt-get -y install ca-certificates gosu wget

RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -; \
	mkdir /steam; \
	mv /app/* /steam/

COPY entrypoint.sh /entrypoint.sh
COPY download_server.sh /download_server.sh
COPY run.sh /run.sh
COPY --from=build /home/steam/pz_server /app

RUN chmod +x /entrypoint.sh /run.sh /download_server.sh

EXPOSE 16261/udp
EXPOSE 16262/udp
EXPOSE 27015

VOLUME [ "/data" ]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/run.sh"]
