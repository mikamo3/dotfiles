#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: $0 <bar_id>"
    exit 1
elif [ "$1" == "top" ]; then
bumblebee-status \
               -m    date time uptime  \
               -p date.format="%Y-%m-%d" \
               time.format="%T" \
               interval=1 \
               -t solarized-powerline
elif [ "$1" == "bottom" ]; then
  bumblebee-status \
               -m hostname  nic cpu2 memory disk arch-update \
               -p nic.exclude=lo,br-,docker,virbr \
               interval=1 \
               cpu2.layout="cpu2.cpuload cpu2.coresload"  \
               -t solarized-powerline
fi
