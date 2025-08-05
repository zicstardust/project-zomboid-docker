## Usage
```
docker run -d \
  --name=pz_mod_downloader \
  -e TZ=America/New_York \
  -e UID=1000 \
  -e GID=1000 \
  -v <path to mods>:/mods \
  -v <path to server.ini>:/server.ini:ro \
  zicstardust/pz_mod_downloader:latest
```
