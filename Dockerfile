FROM ubuntu:wily
MAINTAINER Jakob Jarosch <dev@jakobjarosch.de>

RUN apt-get update && \
    apt-get install -y wget lib32gcc1

RUN useradd -ms /bin/bash steam
USER steam
WORKDIR /home/steam

RUN wget -O /tmp/steamcmd_linux.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
    tar -xvzf /tmp/steamcmd_linux.tar.gz && \
    rm /tmp/steamcmd_linux.tar.gz

ADD ./entrypoint.sh entrypoint.sh

# Install CSS once to speed up container startup
RUN ./entrypoint.sh norun # Update to date as of 2015-11-10

ENV CSS_HOSTNAME Counter-Strike Source Dedicated Server
ENV CSS_PASSWORD ""
ENV RCON_PASSWORD mysup3rs3cr3tpassw0rd

ADD ./css css

EXPOSE 27015/udp # Game Port
EXPOSE 27015     # RCON Port

CMD ./entrypoint.sh
