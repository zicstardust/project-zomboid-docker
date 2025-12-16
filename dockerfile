FROM debian:13.2-slim

WORKDIR /app

COPY entrypoint.sh /entrypoint.sh
COPY src/* /

RUN chmod +x /*.sh; \
	apt-get update && apt-get -y install ca-certificates gosu wget lib32gcc-s1; \
	apt-get -y autoremove; \
	apt-get -y autoclean; \
	apt-get -y clean; \
	rm -Rf /var/lib/apt/lists/*; \
	wget "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"; \
	tar zxvf steamcmd_linux.tar.gz; \
	rm -f steamcmd_linux.tar.gz; \
	mkdir /steam; \
	mv /app/* /steam/

EXPOSE 16261/udp
#EXPOSE 16262/udp
#EXPOSE 8766/udp
#EXPOSE 8766/udp
EXPOSE 27015

VOLUME [ "/data" ]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/run.sh"]
