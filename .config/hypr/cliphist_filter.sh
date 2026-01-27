#!/bin/bash
active_class=$(hyprctl activewindow -j | jq -r .class 2>/dev/null)

# 除外するアプリケーションのリスト
if [[ "$active_class" =~ ^(1password|KeePassXC|Bitwarden)$ ]]; then
    exit 0
fi

cliphist store