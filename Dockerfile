FROM ubuntu:wily
MAINTAINER Jakob Jarosch <dev@jakobjarosch.de>

ENV CSS_HOSTNAME Counter-Strike Source Dedicated Server
ENV RCON_PASSWORD mysup3rs3cr3tpassw0rd

RUN apt-get update && \
    apt-get install -y wget lib32gcc1

RUN mkdir /steam
WORKDIR /steam

RUN wget -O /tmp/steamcmd_linux.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz
RUN tar -xvzf /tmp/steamcmd_linux.tar.gz

ADD ./entrypoint.sh entrypoint.sh

# Install CSS once to speed up container startup
RUN /steam/entrypoint.sh norun # CSS 2015-11-10

ADD ./css css

EXPOSE 27015

CMD /steam/entrypoint.sh
