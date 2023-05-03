#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [ "$m" == "DisplayPort-0" ]; then
      MONITOR=$m polybar --reload -c ~/.config/polybar/config.ini top &
    fi
    if [ "$m" == "HDMI-A-0" ]; then
      MONITOR=$m polybar --reload -c ~/.config/polybar/config.ini top_right &
    fi
    MONITOR=$m polybar --reload -c ~/.config/polybar/config.ini bottom &
  done
else
  polybar -r -c ~/.config/polybar/config.ini top  &
  polybar -r -c ~/.config/polybar/config.ini bottom  &
fi

echo "Polybar launched..."
