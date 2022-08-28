FROM debian:11

EXPOSE 42420

# Variables from the server.sh
ARG USERNAME=vintagestory
ARG VSPATH=/home/vintagestory/server
ARG DATAPATH=/var/vintagestory/data

# Install dependencies
RUN apt-get update -q -y
RUN apt-get install -yf \
    screen wget curl vim
# Mono
RUN apt-get install -yf \
    apt-transport-https dirmngr gnupg ca-certificates
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb https://download.mono-project.com/repo/debian stable-buster main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-get update -q -y
RUN apt-get install -yf \
    mono-complete

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
COPY ./vs_server_*.*.*.tar.gz $VSPATH
RUN tar xzf vs_server_*.*.*.tar.gz
RUN chmod +x ./server.sh

# Changes user
USER $USERNAME

# Start the server
# With sleep infinity to prevent exit
CMD ./server.sh start ; sleep infinity
