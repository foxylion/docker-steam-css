#!/bin/bash
set -e
trap '' TERM INT HUP

# Ensure CSS is up to date
if [ "$1" == "update" ]; then
	./steamcmd.sh +login anonymous +force_install_dir ./css +app_update 232330 validate +quit
fi

cd css
./srcds_run -game cstrike +exec server.cfg +hostname "$CSS_HOSTNAME" +sv_password "$CSS_PASSWORD" +rcon_password "$RCON_PASSWORD" +map de_dust2
