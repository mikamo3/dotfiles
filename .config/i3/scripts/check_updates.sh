#!/usr/bin/env sh
UPDATE_RESULT_PATH=/tmp/arch_update
while :; do
  if ! updates_arch=$(checkupdates 2>/dev/null | wc -l); then
    updates_arch=0
  fi

  if ! updates_aur=$(yay -Qum 2>/dev/null | wc -l); then
    updates_aur=0
  fi

  updates=$(("$updates_arch" + "$updates_aur"))
  echo "$updates" >>$UPDATE_RESULT_PATH
  sleep 3600
done
