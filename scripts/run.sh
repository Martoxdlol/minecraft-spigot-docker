#!/bin/sh

cp /usr/src/build/spigot.jar spigot.jar
echo "eula=true" > eula.txt
[ -d "/config/" ] && cp /config/* . 

java -Xmx10G -jar spigot.jar

