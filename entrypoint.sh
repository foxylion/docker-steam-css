#!/bin/bash

# Ensure CSS is up to date
./steamcmd.sh +login anonymous +force_install_dir ./css +app_update 232330 validate +quit

if [ "$1" == "norun" ]; then
	exit
fi

cd css
./srcds_run -game cstrike -console +exec server.cfg +hostname "$CSS_HOSTNAME" +rcon_password $RCON_PASSWORD +map de_dust2
