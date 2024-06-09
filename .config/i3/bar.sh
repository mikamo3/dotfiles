#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: $0 <bar_id>"
    exit 1
elif [ "$1" == "top" ]; then
bumblebee-status \
               -m hostname xrandr bluetooth2 date time \
               -p date.format="%Y-%m-%d" \
               time.format="%T" \
               interval=1 \
               -t solarized-powerline
elif [ "$1" == "bottom" ]; then
  bumblebee-status \
               -m uptime traffic cpu memory\
               -p traffic.exclude=lo,br-,docker,virbr \
               interval=1 \
               -t solarized-powerline
fi
