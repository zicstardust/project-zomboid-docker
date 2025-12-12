FROM debian:13.2-slim

WORKDIR /app

RUN apt-get update && apt-get -y install ca-certificates gosu wget lib32gcc-s1; \
	wget "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"; \
	tar zxvf steamcmd_linux.tar.gz; \
	rm -f steamcmd_linux.tar.gz; \
	mkdir /steam; \
	mv /app/* /steam/

COPY entrypoint.sh /entrypoint.sh
COPY download_server.sh /download_server.sh
COPY run.sh /run.sh
COPY mods_downloader.sh /mods_downloader.sh

RUN chmod +x /entrypoint.sh /run.sh /download_server.sh /steam/steamcmd.sh /mods_downloader.sh

EXPOSE 16261/udp
#EXPOSE 16262/udp
#EXPOSE 8766/udp
#EXPOSE 8766/udp
EXPOSE 27015

VOLUME [ "/data" ]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/run.sh"]
