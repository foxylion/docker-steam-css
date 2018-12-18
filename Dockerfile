FROM ubuntu:xenial

RUN apt-get update && \
    apt-get install -y wget lib32gcc1 lib32tinfo5 unzip nginx

RUN useradd -ms /bin/bash steam
WORKDIR /home/steam

USER steam

RUN wget -O /tmp/steamcmd_linux.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
    tar -xvzf /tmp/steamcmd_linux.tar.gz && \
    rm /tmp/steamcmd_linux.tar.gz

# Install CSS once to speed up container startup
RUN ./steamcmd.sh +login anonymous +force_install_dir ./css +app_update 232330 validate +quit # Update to date as of 2016-02-06

ENV CSS_HOSTNAME Counter-Strike Source Dedicated Server
ENV CSS_PASSWORD ""
ENV RCON_PASSWORD mysup3rs3cr3tpassw0rd

EXPOSE 27015/udp
EXPOSE 27015
EXPOSE 1200
EXPOSE 27005/udp
EXPOSE 27020/udp
EXPOSE 26901/udp

ADD ./entrypoint.sh entrypoint.sh

# Support for 64-bit systems
# https://www.gehaxelt.in/blog/cs-go-missing-steam-slash-sdk32-slash-steamclient-dot-so/
RUN ln -s /home/steam/linux32/ /home/steam/.steam/sdk32

# Add Source Mods
COPY --chown=steam:steam mods/ /temp
RUN cd /home/steam/css/cstrike && \
    tar zxvf /temp/mmsource-1.10.6-linux.tar.gz && \
    tar zxvf /temp/sourcemod-1.7.3-git5275-linux.tar.gz && \
    unzip /temp/quake_sounds1.8.zip && \
    unzip /temp/mapchooser_extended_1.10.2.zip && \
    mv /temp/gem_damage_report.smx addons/sourcemod/plugins && \
    rm /temp/*

# Add default configuration files
ADD cfg/ /home/steam/css/cstrike/cfg

CMD ./entrypoint.sh
