#!/usr/bin/env bash
sh -c '
KITCHENTIMER_CONFIG_PATH=$HOME/.local/kitchentimer_config
KITCHENTIMER_COUNT=/tmp/kitchintimer_count

for ((i = "$(cat "$KITCHENTIMER_CONFIG_PATH")"; i >= 0; i--)); do
  echo $i >>"$KITCHENTIMER_COUNT"
  sleep 1
done
cat "$KITCHENTIMER_CONFIG_PATH" >>"$KITCHENTIMER_COUNT"
notify-send -u critical -a \"kitchentimer\" alert
' &
