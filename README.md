# Docker Image for Counter-Strike Source

This docker image provides a preconfigured Counter-Strike Source server with several plugins.

List of used plugins:
- [metamod:source v1.10.6](http://www.metamodsource.net/downloads/)
- [SourceMod v1.7.3-5275](http://www.sourcemod.net/downloads.php?branch=stable)
- [Quake Sounds v1.8](https://forums.alliedmods.net/showthread.php?t=58548)
- [Damage Report/Stats v1.1.13](https://forums.alliedmods.net/showthread.php?t=64661)

## Start the container

The docker container requires some ports to be exposed, therefore a more advanced run command is required.

```
docker run -d --name css-server-27015 \
           -p 27015:27015 -p 27015:27015/udp -p 1200:1200 \
           -p 27005:27005/udp -p 27020:27020/udp -p 26901:26901/udp \
           -e RCON_PASSWORD=mypassword \
           foxylion/steam-css
```

## Restart the container

Due to the linux kernel is caching the udp connection state you have to manually clean the udp connection tracking, before you can immediately reconenct to the server. More details can be found [here](https://github.com/docker/docker/issues/8795).

```
apt-get install conntrack
conntrack -D -p udp
```

## Available Environment Variables

- ``RCON_PASSWORD`` is your personal RCON password to authenticate as the administrator
- ``CSS_HOSTNAME`` is your custom server name shown in the server list
- ``CSS_PASSWORD`` is the password a user may require to connect, can be left empty

## Expose you maps and sounds as a htdocs directory

You can mount a directory where the css server should copy all currently installed maps and sounds so you can use the `sv_downloadurl` option.

```
- v /path/to/target:/home/steam/htdocs
```

## Other files to override

### Custom mapcycle.txt

```
-v /path/to/mapcycle.txt:/home/steam/css/cstrike/cfg/mapcycle.txt
```

### SourceMod admins_simple.ini

To control the SourceMod admins on the server you can use your own admins.cfg or admins_simple.ini file.

```
-v /path/to/admins_simple.ini:/home/steam/css/cstrike/addons/sourcemod/configs/admins_simple.ini
```

### Modified server.cfg

The default server.cfg can also be overriden, but you can also only override some specific settings, therefore use the following pattern
```
-v /path/to/my-server.cfg:/home/steam/css/cstrike/cfg/my-server.cfg
```

### Other configuration files

Any other configuration file can also be overriden using the same method as above, you must just locate the right file in the docker container. The folder structure is the same as when you install the server locally.
