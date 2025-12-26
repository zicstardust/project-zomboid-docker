# Project Zomboid Dedicated Server 
Project Zomboid dedicated server container with auto download of workshop mods for non-steam servers

[GitHub](https://github.com/zicstardust/project-zomboid-dedicated-server)

## Container
### Tags

| Tag | Architecture | Description |
| :----: | :----: | :----: |
| [`latest`](https://github.com/zicstardust/project-zomboid-dedicated-server/blob/main/dockerfile) | amd64 | Dedicated Server |

### Registries
| Registry | Full image name | Description |
| :----: | :----: | :----: |
| [`docker.io`](https://hub.docker.com/r/zicstardust/project-zomboid-dedicated-server) | `docker.io/zicstardust/project-zomboid-dedicated-server` | Docker Hub |
| [`ghcr.io`](https://github.com/zicstardust/project-zomboid-dedicated-server/pkgs/container/project-zomboid-dedicated-server) | `ghcr.io/zicstardust/project-zomboid-dedicated-server` | GitHub |

## Usage
### Compose
```
services:
  pzserver:
    container_name: project-zomboid-dedicated-server
    image: docker.io/zicstardust/project-zomboid-dedicated-server:latest
    restart: unless-stopped
    environment:
      TZ: America/New_York
    ports:
      - 16261:16261/udp #Default_Port
      #- 16262:16262/udp #Direct Connection (only build 41 and 42)
      #- 8766:8766/udp #Steam Port 1 (only builds 40, 39 and 38)
      #- 8767:8767/udp #Steam Port 2 (only builds 40, 38 and 38)
      #- 27015:27015 #Rcon port (IMPORTANT: set RCONPassword in server.ini)
    volumes:
      - /path/to/data:/data
      - /path/to/cache:/cache #Opcional: Download cache
```

## Environment variables

| variables | Function | Default | Exemple/Info
| :----: | --- | :----: | --- |
| `TZ` | Set Timezone | | |
| `PUID` | Set UID | 1000 | |
| `PGID` | Set GID | 1000 | |
| `BUILD` | Set build server version | stable | [Look at the set build section](#set-build) |
| `ADMIN_USERNAME` | Set admin username | admin | |
| `ADMIN_PASSWORD` | Set admin password | `generate random password` | Random password can be viewed in the server log |
| `STEAM` | set `0` to join non-steam players | 1 |
| `MAX_RAM` | set max ram to JVM | 4g | `8g = 8 gigabytes`<br/>`2048m = 2048 megabytes` |
| `LANGUAGE` | set server language | en | `fr`, `ru`, `en`, `pt`, `ptbr`, etc |
| `UPDATE_JRE` | set `1` to update default JRE (experimental)| 0 | |
| `DISABLE_MOD_DOWNLOADER` | set `1` to disable auto mods downloader | 0 | |
| `DISABLE_CACHE` | set `1` to disable download cache | 0 | |

## Set BUILD

| Value | Description | Server version |
| :----: | --- | --- |
| `42`, `unstable` | Last Build 42 Server | 42.13.0  |
| `41`, `stable` | Last Build 41 Server | 41.78.16 |
| `41.78.7` | Legacy build 41 Server | 41.78.7 |
| `41.77` | Legacy build 41 Server | 41.77 |
| `41.73` | Legacy build 41 Server | 41.73 |
| `41.71` | Legacy build 41 Server | 41.71 |
| `41.68` | Legacy build 41 Server | 41.68 |
| `40` | Last Build 40 Server | 40.43 |
| `39` | Last Build 39 Server | 39.67.5 |
| `38` | Last Build 38 Server | 38.30 |


## Auto download mods for non-steam server
If the STEAM environment variable is set to `0` and you have mods in the `WorkshopItems` key in `/data/Zomboid/Server/server.ini`.

Mods in the `WorkshopItems` key will automatically be downloaded and will replace all files in the `/data/Zomboid/mods` directory.

To disable automatic mod downloads, set the `DISABLE_MOD_DOWNLOADER` environment variable to `1`.
