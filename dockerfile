FROM debian:13.3-slim

ENV DEBIAN_FRONTEND="noninteractive"

WORKDIR /app

COPY entrypoint.sh /entrypoint.sh
COPY src/* /usr/local/bin/

RUN chmod +x /entrypoint.sh; \
	chmod +x /usr/local/bin/*; \
	apt-get update && apt-get -y install ca-certificates gosu wget lib32gcc-s1; \
	apt-get -y autoremove; \
	apt-get -y autoclean; \
	apt-get -y clean; \
	rm -Rf /var/lib/apt/lists/*; \
	wget "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"; \
	mkdir -p /opt/steamcmd; \
	tar zxvf steamcmd_linux.tar.gz -C /opt/steamcmd/; \
	rm -f steamcmd_linux.tar.gz

EXPOSE 16261/udp
EXPOSE 16262/udp
EXPOSE 8766/udp
EXPOSE 8766/udp
EXPOSE 27015

VOLUME [ "/data" ]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["run.sh"]
