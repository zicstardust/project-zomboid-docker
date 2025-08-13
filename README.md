# Project Zomboid Dedicated Server Docker 

[GitHub](https://github.com/zicstardust/project-zomboid-docker)

[Docker Hub](https://hub.docker.com/r/zicstardust/project-zomboid-dedicated-server)

## Tags

| Tag | Architecture | Description |
| :----: | :----: |--- |
| [`latest`, `41`](https://github.com/zicstardust/project-zomboid-docker/blob/main/dockerfile_build41) | amd64 | Last Stable Server (41.78.16) |
| [`updatejre`, `41-updatejre`](https://github.com/zicstardust/project-zomboid-docker/blob/main/dockerfile_build41-updatejre) | amd64 | Last Stable Server (41.78.16) with JRE updated |
| [`40`](https://github.com/zicstardust/project-zomboid-docker/blob/main/dockerfile_build40) | amd64 | Last Build 40 Server (40.43) |
| [`40-updatejre`](https://github.com/zicstardust/project-zomboid-docker/blob/main/dockerfile_build40-updatejre) | amd64 | Last Build 40 Server (40.43) with JRE updated |
| [`39`](https://github.com/zicstardust/project-zomboid-docker/blob/main/dockerfile_build39) | amd64 | Last Build 39 Server (39.67.5) |
| [`39-updatejre`](https://github.com/zicstardust/project-zomboid-docker/blob/main/dockerfile_build39-updatejre) | amd64 | Last Build 39 Server (39.67.5) with JRE updated |
| [`38`](https://github.com/zicstardust/project-zomboid-docker/blob/main/dockerfile_build38) | amd64 | Last Build 38 Server (38.30) |
| [`38-updatejre`](https://github.com/zicstardust/project-zomboid-docker/blob/main/dockerfile_build38-updatejre) | amd64 | Last Build 38 Server (38.30) with JRE updated |

## Usage
### docker-compose
```
services:
  server:
    container_name: project-zomboid-dedicated-server
    image: zicstardust/project-zomboid-dedicated-server:latest
    environment:
      TZ: America/New_York
    ports:
      - 16261:16261/udp #Default_Port
      #- 16262:16262/udp #Direct Connection (only build 41)
      #- 8766:8766/udp #Steam Port 1 (only builds 40, 39 and 38)
      #- 8767:8767/udp #Steam Port 2 (only builds 40, 38 and 38)
      #- 27015:27015 #Rcon_port (Import set rcon password in server.ini)
    volumes:
      - /path/to/data:/data
```

## Environment variables

| variables | Function | Default |
| :----: | --- | --- |
| `TZ` | Set Timezone | |
| `UID` | Set UID | 1000 |
| `GID` | Set GID | 1000 |
| `ADMIN_USERNAME` | Set User ID | admin |
| `ADMIN_PASSWORD` | Set Group ID | `generate random password` |
| `STEAM` | set `0` to join non-steam players | 1 |
| `MAX_RAM` | set max ram to JVM<br/><br/>examples:<br/><br/>`2g = 2 gigabytes`<br/><br/>`1536m = 1536 megabytes`| 4g |
| `LANGUAGE` | set server language<br/><br/>examples: `fr`, `ru`, `en`, `pt`, `ptbr`, etc | en |
