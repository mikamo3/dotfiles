#!/usr/bin/env sh
KITCHENTIMER_CONFIG_PATH=$HOME/.local/kitchentimer_config
KITCHENTIMER_COUNT=/tmp/kitchintimer_count

if [ ! -e "$KITCHENTIMER_CONFIG_PATH" ]; then
  echo "10" >"$KITCHENTIMER_CONFIG_PATH"
fi
COUNT=$(cat "$KITCHENTIMER_CONFIG_PATH")
echo "$COUNT" >"$KITCHENTIMER_COUNT"
tail -f $KITCHENTIMER_COUNT
