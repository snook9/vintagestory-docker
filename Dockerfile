FROM debian:11

EXPOSE 42420

# Variables from the server.sh
ARG USERNAME=vintagestory
ARG VSPATH=/home/vintagestory/server
ARG DATAPATH=/var/vintagestory/data
# Name of the tar.gz file from cdn.vintagestory.at
ARG FILENAME=vs_server_linux-x64_1.20.7.tar.gz

# Install dependencies
RUN apt-get update -q -y
RUN apt-get install -yf \
    screen wget curl vim
# .NET
RUN apt-get install -yf \
    procps
RUN wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
# .NET RUNTIME
RUN apt-get update && \
    apt-get install -y aspnetcore-runtime-7.0

# Add user
RUN useradd -ms /bin/bash $USERNAME
# Server folder
RUN mkdir -p $VSPATH
RUN chown -R $USERNAME $VSPATH
# Data folder
RUN mkdir -p $DATAPATH
RUN chown -R $USERNAME $DATAPATH

# Vintage story server extract
WORKDIR $VSPATH
#COPY ./$FILENAME $VSPATH
RUN wget https://cdn.vintagestory.at/gamefiles/stable/$FILENAME
COPY ./launcher.sh $VSPATH
RUN tar xzf $FILENAME
RUN chown -R $USERNAME $VSPATH
RUN chmod +rx ./server.sh
RUN chmod +rx ./launcher.sh

# Clean up
RUN rm -f $FILENAME

# Changes user
USER $USERNAME

# Start the server
# This script hooks the stop command
ENTRYPOINT [ "./launcher.sh" ]
