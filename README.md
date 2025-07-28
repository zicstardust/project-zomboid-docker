# Project Zomboid Dedicated Server Docker 

[GitHub](https://github.com/zicstardust/project-zomboid-docker)

[Docker Hub](https://hub.docker.com/r/zicstardust/project-zomboid-dedicated-server)

## Supported Architectures

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| x86-64 | ✅ | latest, build41, build40 |


## Tags

| Tag | Available | Description |
| :----: | :----: |--- |
| [`latest`, `build41`](https://github.com/zicstardust/project-zomboid-docker/blob/main/dockerfile) | ✅ | Last Stable Server (41.78.16) |
| [`build40`](https://github.com/zicstardust/project-zomboid-docker/blob/main/dockerfile_build40) | ✅ | Last Build 40 Server (40.43) |

## Usage
### docker-compose
```
services:
  project_zomboid_dedicated_server:
    container_name: project_zomboid_dedicated_server
    image: zicstardust/project_zomboid_dedicated_server:latest
    environment:
      TZ: America/New_York
    ports:
      - 16261:16261/udp #Default_Port
      #- 16262:16262/udp #Direct Connection (only build 41)
      #- 8766:8766/udp #Steam 1 Port (only build 40)
      #- 8767:8767/udp #Steam 2 Port (only build 40)
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
