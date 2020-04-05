#!/usr/bin/env sh
APP_NAME="arch update"
UPDATE_RESULT_PATH="$HOME/.local/log/arch_update"
LOCALLOG="$HOME/.local/log/arch_update_$(date +%Y%m%d%H%M%S.log)"

sh -c "
if [[ $(pgrep -f "yay -Sy" | wc -l) != 0 ]];then
  notify-send --app-name=\"$APP_NAME\" \"now updating\"
  exit 1
fi

notify-send --app-name=\"$APP_NAME\" \"start update\"
yay -Syu --noconfirm  &> $LOCALLOG 
if [[ $? != 0 ]]; then
  notify-send --urgency=critical --app-name=\"$APP_NAME\" \"update failure\"
fi
notify-send --app-name=\"$APP_NAME\" \"update success\"
echo 0 >> $UPDATE_RESULT_PATH
" &
