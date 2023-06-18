#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
profile=$(autorandr --current) 
if [[ "$profile" == "minipc_single_usbc" ]];then
  master="DisplayPort-0"
  slave="" 
fi

if [[ "$(hostname)" == "kamo3workmini" ]];then
  net_interface="wlan0"
fi

MONITOR=$master polybar --reload -c ~/.config/polybar/config.ini top &
MONITOR=$master NET_INTERFACE=$net_interface polybar --reload -c ~/.config/polybar/config.ini bottom &

if [[ $slave != "" ]];then
  MONITOR=$slave polybar --reload -c ~/.config/polybar/config.ini top_right &
  MONITOR=$slave polybar --reload -c ~/.config/polybar/config.ini bottom &
fi

echo "Polybar launched..."
