#!/usr/bin/env sh
APP_NAME="arch update"
UPDATE_RESULT_PATH="~/.local/log/arch_update"
LOCALLOG="~/.local/log/arch_update_$(date +%Y%m%d%H%M%S.log)"
sh -c "
yay -Syu --noconfirm  &> $LOCALLOG && notify-send --app-name=$APP_NAME \"update success\" || notify-send --urgency=critical --app-name=$APP_NAME \"update failure\"
echo 0 >> $UPDATE_RESULT_PATH
" &
