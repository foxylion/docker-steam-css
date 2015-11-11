# Docker Container for Counter-Strike Source

This docker container provides a preconfigured Counter-Strike Source server with several plugins.

List of used plugins:
- [metamod:source v1.10.6](http://www.metamodsource.net/downloads/)
- [SourceMod v1.7.3-5275](http://www.sourcemod.net/downloads.php?branch=stable)
- [Quake Sounds v1.8](https://forums.alliedmods.net/showthread.php?t=58548)
- [Damage Report/Stats v1.1.13](https://forums.alliedmods.net/showthread.php?t=64661)

## Start the docker container

The docker container requires some ports to be exposed, therefore a more advanced run command is required.

```
docker run -d --name css-server-27015 \
           -p -p 27015:27015 -p 27015:27015/udp -p 1200:1200 \
           -p 27005:27005/udp -p 27020:27020/udp -p 26901:26901/udp \
           -e RCON_PASSWORD=mypassword
           foxylion/steam-css
```

## Available Environment Variables

- ``RCON_PASSWORD`` is your personal RCON password to authenticate as the administrator
- ``CSS_HOSTNAME`` is your custom server name shown in the server list
- ``CSS_PASSWORD`` is the password a user may require to connect, can be left empty

## Available files to override

### Custom mapcycle.txt

```
-v /path/to/mapcycle.txt:/home/steam/css/cstrike/cfg/mapcycle.txt
```

## Modified server.cfg

The default server.cfg can also be overriden, but you can also only override some specific settings, therefore use the following pattern
```
-v /path/to/my-server.cfg:/home/steam/css/cstrike/cfg/my-server.cfg
```
The file is executed on every round start and server restart.