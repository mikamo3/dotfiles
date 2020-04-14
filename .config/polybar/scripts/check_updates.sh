#!/usr/bin/env sh
UPDATE_RESULT_PATH=/tmp/arch_update
while [ ! -e "$UPDATE_RESULT_PATH" ]; do
  echo "0"
  sleep 1
done
tail -n1 -f $UPDATE_RESULT_PATH
