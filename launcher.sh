#!/bin/bash

# This launcher start the server and hook the SIGTERM signal
# So, when a docker stop is executed, the server is stopped properly

#Define cleanup procedure
cleanup() {
    echo "Container stopped, performing cleanup..."
    ./server.sh stop
}

#Trap SIGTERM
trap 'true' SIGTERM

# Starts the server
./server.sh start
# Sleep to prevent a container stop
sleep infinity &

#Wait
wait

#Cleanup
cleanup
