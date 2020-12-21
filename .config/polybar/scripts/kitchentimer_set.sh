#!/usr/bin/env bash
KITCHENTIMER_CONFIG_PATH=$HOME/.local/kitchentimer_config
KITCHENTIMER_COUNT=/tmp/kitchintimer_count

if [[ "$1" == "add" ]]; then
  COUNT=$(($(cat "$KITCHENTIMER_CONFIG_PATH") + 10))
else
  COUNT=$(($(cat "$KITCHENTIMER_CONFIG_PATH") - 10))
fi
if [[ $COUNT -le 0 ]]; then
  COUNT=0
fi
echo "$COUNT" >"$KITCHENTIMER_CONFIG_PATH"
echo "$COUNT" >>"$KITCHENTIMER_COUNT"
