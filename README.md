Vintage Story Server
====================

Dockerfile for running a Vintage Story Server in a container.

# First Step
First, you must download the Tar.gz Archive/Linux server version from https://www.vintagestory.at.<br/>
The .tar.gz archive must be located next to the Dockerfile.

# Docker build
``` bash
docker build -t vintagestory_server .
```

# Docker run
With docker-compose:
``` bash
docker-compose -f .\docker-compose-vintagestory.yml up -d
```
With docker:
``` bash
docker run --name vintagestory_server -v vintagestory_data:/var/vintagestory/data --restart unless-stopped -d -p 42420:42420 docker.io/library/vintagestory_server
```

## Data location
In the container, the data are located to **/var/vintagestory/data**.

# Server console
ATTENTION, use **CTRL+A** then **CTRL+D** to leave the console (leave the screen).<br/>
*CTRL+C will shutdown the server...*
``` bash
docker exec -u vintagestory -ti vintagestory_server screen -xS vintagestory_server
```
## Start and stop
To stop the server properly before a container stop.
``` bash
docker exec -u vintagestory -ti vintagestory_server /bin/bash ./server.sh stop
docker exec -u vintagestory -ti vintagestory_server /bin/bash ./server.sh start
```

# Debug
Enter in the container at launch time:
``` bash
docker run -ti -p 42420:42420 vintagestory_server /bin/bash
```
