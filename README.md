# Automatic Docker Bitwarden Backup

[GitHub](https://github.com/zicstardust/project-zomboid-docker)

[Docker Hub](https://hub.docker.com/r/zicstardust/project-zomboid-dedicated-server)

## Supported Architectures

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| x86-64 | ✅ | latest |


## Tags


| Tag | Available | Description |
| :----: | :----: |--- |
| [`latest`](https://github.com/zicstardust/project-zomboid-docker/blob/main/Dockerfile) | ✅ | Server lastest stable version |

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
      #- 16262:16262/udp #Direct Connection
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
| `MAX_RAM` | set max ram to JVM<br/><br/>examples:<br/><br/>`2g = 2 gigabytes`<br/><br/>`1536m = 1536 megabytes`| 8g |
