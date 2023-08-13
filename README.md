Vintage Story Server
====================

Dockerfile for running a Vintage Story Server in a container.

# Docker build
``` bash
docker build -t vintagestory_server .
```

# Docker run
With docker-compose:
``` bash
docker-compose -f ./docker-compose-vintagestory.yml up -d
```
With docker:
``` bash
docker run -v vintagestory_data:/var/vintagestory/data --restart unless-stopped -d -p 42420:42420 snook9/vintagestory_server:latest
```

## Data location
In the container, the data are located to **/var/vintagestory/data**.

# Server console
ATTENTION, use **CTRL+A** then **CTRL+D** to leave the console (leave the screen).<br/>
*CTRL+C will shutdown the server...*<br/>
*Replace $CONTAINER_NAME by your container name.*
``` bash
docker exec -u vintagestory -ti $CONTAINER_NAME screen -xS vintagestory_server
```
## Start and stop
To stop the server properly before a container stop.
``` bash
docker exec -u vintagestory -ti $CONTAINER_NAME /bin/bash ./server.sh stop
docker exec -u vintagestory -ti $CONTAINER_NAME /bin/bash ./server.sh start
```

# Debug
Enter in the container at launch time:
``` bash
docker run -ti -p 42420:42420 $CONTAINER_NAME /bin/bash
```
