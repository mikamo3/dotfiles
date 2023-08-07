#!/bin/bash
# check is running
if [[ $$ -ne $(pgrep -fo "$0") ]];then
  echo "Already running"
  exit 1
fi
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
profile=$(autorandr --detected)
if [[ "$profile" == "minipc_single_usbc" ]];then
  master="DisplayPort-0"
  slave=""
elif [[ "$profile" == "minipc_dual" ]];then
  master="HDMI-A-0"
  slave="DisplayPort-0"
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
